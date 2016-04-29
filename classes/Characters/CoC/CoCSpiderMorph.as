package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCSpiderMorph extends Creature
	{
		public function CoCSpiderMorph() 
		{}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if(target.reflexes() >= 2 && rand(2) == 0) {
				spiderMorphWebAttack(target);
			}
			else if(!target.hasStatusEffect("Web Silence") && rand(3) == 0) {
				spiderSilence(target);
			}
			else if(!target.hasStatusEffect("Disarmed") && target.hasEquippedWeapon() && rand(3) == 0) {
				spiderDisarm(target);
			}
			else if(rand(2) == 0 || target.reflexes() < 2) getBitten(target);
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		public function additionalCombatMenuEntries():void
		{
			if (kGAMECLASS.pc.hasStatusEffect("Disarmed")) { // TODO: use fists?
				addDisabledButton(0, "Attack", "Attack", "You are disarmed!");
				addDisabledButton(1, "Shoot", "Shoot", "You are disarmed!");
			}
			
			if ((kGAMECLASS.pc.hasStatusEffect("Web") || kGAMECLASS.pc.hasStatusEffect("Silence")) && kGAMECLASS.pc.energy() >= 5 && (kGAMECLASS.isNineTails(kGAMECLASS.pc) || (kGAMECLASS.pc.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_WHITEFIRE) > 0 && !kGAMECLASS.pc.hasStatusEffect("Silence"))) {
				addButton(10, "Burn Webs", CleansingFlame, null, "Burn webs", "Get rid of that webs by <b>all</b> means!");
			}
		}
		
		public function CleansingFlame():void {
			clearOutput();
			kGAMECLASS.pc.energy( -5);
			
			output("In desperate attempt to get rid of your restrains, you are brought to setting them ablaze!  ");
			var damage:Number = 0;
			if (kGAMECLASS.pc.hasPerk("Enlightened Nine-tails")) {
				output("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You squeeze it in your [pc.hand], and it envelops your own body, burning webs and showering dazzling azure sparks everywhere. Good news - your own fox fire can't burn you. Bad news - burning webs can...  ");
				damage = 0;
			}
			else if (kGAMECLASS.pc.hasPerk("Corrupted Nine-tails")) {
				output("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You squeeze it in your [pc.hand], and it envelops your own body, burning webs and showering dazzling lavender sparks everywhere. Good news - your own fox fire can't burn you. Bad news - burning webs can...  ");
				damage = 0;
			}
			else if ((kGAMECLASS.pc.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_WHITEFIRE) > 0) {
				output("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and flash of searing flame envelops your own body, burning webs and your own body alike!  ");
				damage = 10;
			}
			
			damage += kGAMECLASS.pc.statusEffectv1("Web");
			if (kGAMECLASS.pc.hasStatusEffect("Silence")) damage += 10;
			
			applyDamage(new TypeCollection( { burning : damage }, DamageFlag.BYPASS_SHIELD ), kGAMECLASS.pc, kGAMECLASS.pc, "minimal");
			WebCleanup();
			
			if(kGAMECLASS.pc.WQ() > 90 || kGAMECLASS.pc.cor() > 90) {
				output("\n\n" + capitalA + short + " is watching at your maniacal glee in downright terror!  ");
				createStatusEffect("Stunned", 1, 0, 0, 0, true, "Stun", "Cannot act for a turn.", true, 0);
			}
			kGAMECLASS.updatePCStats();
			output(kGAMECLASS.onSpellCast(kGAMECLASS.pc));
			CombatManager.processCombat();
		}
		
		public function onCleanup():void {
			WebCleanup();
		}
		
		public function WebCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Web")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Web"));
				kGAMECLASS.pc.removeStatusEffect("Web");
			}
			kGAMECLASS.pc.removeStatusEffect("Silence");
		}

		/**
		 * -Web - lowers speed by 25 each application and disables
		 * flight once hit.*/
		public function spiderMorphWebAttack(target:Creature = null):void
		{
			if (target == null) target = kGAMECLASS.pc;
			output("Turning to the side, " + a + short + " raises " + mf("his", "her") + " abdomen and unleashes a spray of webbing in your direction!  ");
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + " misses completely due to their blindness.");
			}
			//Determine if dodged!
			else if (rangedCombatMiss(this, target)) {
				output("You dodge away, avoiding the sticky strands!");
			}
			//Got hit
			else {
				var amount:Number = (target.reflexesMax() * 0.25) - target.physique() / 10;
				if (amount <= 0) { // 250 physique?
					output("The silky strands hit you, webbing around you, but with your ultimate strength you tear it apart!");
					return;
				}
				if (!target.hasStatusEffect("Web")) {
					output("The silky strands hit you, webbing around you and making it hard to move with any degree of speed.");
					if (target.canFly()) output("  Your wings struggle uselessly in the bindings, no longer able to flap fast enough to aid you.");
					output("\n");
					target.createStatusEffect("Web", 0, 0, 0, 0, false, "Icon_Slow", "You are strandled by spider web!");
				}
				else {
					output("The silky strands hit you, weighing you down and restricting your movement even further.\n");
				}
				//Only apply as much speed slow as necessary.
				if (target.reflexes() - amount < 1) {
					amount = target.reflexes() - 1;
				}
				//Apply changes, display arrows, and track speed lost
				target.reflexes( -amount);
				target.addStatusValue("Web", 1, amount);
			}
		}

		/**-Bite - Raises arousal by 30*/
		public function getBitten(target:Creature):void
		{
			//-Languid Bite - Inflicted on PC's who have been reduced to 1 speed by webbing, raises arousal by 60.
			if (target.reflexes() < 2 && target.hasStatusEffect("Web")) {
				output("The arachnid aggressor slowly saunters forward while you struggle under the heaps of webbing, gently placing " + mf("his", "her") + " arms around your back in a tender hug.  " + mf("His", "Her") + " fangs slide into your neck with agonizing slowness, immediately setting off a burning heat inside you that makes you dizzy and weak.  ");
				if (target.hasCock()) {
					output("[pc.EachCock] turns rock hard and squirts weakly, suddenly so aroused that it starts soaking your [pc.lowerGarment]");
					if (target.hasVagina()) output(" along with your [pc.vagina]");
					output(".  ");
				}
				else if (target.hasVagina()) output("Your [pc.vagina] grows wet as hell and so sensitive that every step and movement reminds you of the powerful need for something between your sopping nether-lips.  ");
				output("While " + mf("his", "her") + " venom pours into you, the spider-" + mf("boy", "girl") + " reaches into your gear to play with your [pc.nipple], and you moan like a whore from the dual stimulation of " + mf("his", "her") + " venom and nipple-play.\n\n");
				if (hasVagina()) output("The saucy dominatrix exhausts her supply of aphrodisiac toxin for the moment and finally steps back, admiring her work and giving you a lewd wink.  ");
				else output("The confident male exhausts his supply of aphrodisiac toxin for the moment and finally steps back, admiring his work and giving you a lewd wink.  ");
				
				applyDamage(new TypeCollection( { tease : 20, drug : 40 } ), this, target);
				
				if (target.lustQ() > 99) output("\n\nYou wobble, utterly defeated and about to cave in to your lust.");
				else output("\n\nYou struggle not to fall down and start masturbating on the spot.");
			}
			output("The spider-" + mf("boy", "girl") + " lunges forward with " + mf("his", "her") + " mouth open, " + mf("his", "her") + " two needle-like fangs closing rapidly.  ");
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + " misses completely due to their blindness.");
			}
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("You dodge away, avoiding " + mf("his", "her") + " bite!");
			}
			else {
				if (rand(5) == 0) {
					output("You react far too slowly, and before you can even think to dodge, " + mf("he", "she") + "'s bitten deep into you, pumping large squirts of venom deep into your body.  Unnatural heat rolls through you, pooling in your groin until you're lewdly bucking your hips against the spider-morph's thigh.  " + mf("He", "She") + " pulls out and steps back, ");
					if (hasVagina()) output("casually cupping her breasts while you watch with venom-dilated eyes, slowly touching yourself.  Once she stops, you shake your head and master yourself, remembering that you're supposed to be fighting this " + mf("boy", "girl") + "!  ");
					else output("casually tugging on his relatively short, girthy dick as you watch with venom-dilated eyes, slowly touching yourself.  Once he stops, you shake your head and master yourself, remembering that you're supposed to be fighting this " + mf("boy", "girl") + "!  ");
					
					applyDamage(new TypeCollection( { tease : 10, drug : 40 } ), this, target);
				}
				else {
					output("You react too slowly, and before you can dodge, " + mf("he", "she") + "'s bitten you, leaving behind a burning venom that warms your blood and stokes your lust.  ");
					applyDamage(new TypeCollection( { drug : 30 } ), this, target);
				}
			}
		}

		/**-Disarm - hits the PC's weapon with web and sticks it to a
		 nearby tree, reducing PC's attack to 0 for the rest of the fight.*/
		public function spiderDisarm(target:Creature):void
		{
			output(capitalA + short + " shifts and sprays webbing, aiming a tight strand of it at your weapon.  ");
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("The blind web-shot goes horribly wide, missing you entirely.");
			}
			//Determine if dodged!
			else if (rangedCombatMiss(this, target)) {
				output("You pull it back and the webbing goes wide, missing entirely.");
			}
			else if (target.meleeWeapon.longName.indexOf("gauntlet") != -1) {
				output("The webbing hits your ");
				if (target.meleeWeapon.longName == "spiked gauntlet") output("gauntlet, but it's so effectively fastened to your hands that the attack fails to disarm you.\n");
				else output("gauntlets, but they're so effectively fastened to your hands that the attack fails to disarm you.\n");
			}
			else {
				output("You don't react fast enough and the sticky webbing pulls your weapon out of your grip, gluing it to a nearby tree.  There's no way to get it back right now!");
				target.createStatusEffect("Disarmed", 9999, 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", true, 0);
			}
		}

		/**-Silence - sprays webs on the PC's mouth, silencing them for 1 to 3 turns.*/
		public function spiderSilence(target:Creature):void
		{
			output(capitalA + short + " squirts a concentrated spray of " + mf("his", "her") + " webs directly at your face!  ");
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("The blind web-shot goes horribly wide, missing you entirely.");
			}
			//Determine if dodged!
			else if (rangedCombatMiss(this, target)) {
				output("You lean back and let them pass harmlessly overhead, avoiding the attack.");
			}
			else if (target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("Web splatters harmlessly on your mask!");
			}
			else {
				output("They hit you before you can move, covering most of your nose and mouth and making it hard to breathe.  You'll be unable to use your voice while you're constantly struggling just to draw air!\n");
				target.createStatusEffect("Silence", 3, 0, 0, 0, false, "Icon_Silence", "You can't talk with all that webbings on yor face!", true, 0);
			}
		}
	}
}