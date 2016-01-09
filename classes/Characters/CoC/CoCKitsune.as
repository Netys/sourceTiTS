package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCKitsune extends Creature
	{
		public function CoCKitsune() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "kitsune";
			this.originalRace = "kitsune";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "A kitsune stands in front of you, about five and a half feet tall.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 5;
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "skimpy robes";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 35.0;
			baseHPResistances.tease.resistanceValue = 20.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 250;
			this.level = 6;
			this.credits = (rand(5) + 1) * 10;
			this.HPMod = 120;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 90 / 20 * this.level;
			this.aimRaw = 90 / 20 * this.level;
			this.intelligenceRaw = 95 / 20 * this.level;
			this.willpowerRaw = 95 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;			
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "blue";
			this.tallness = 66;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 20;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "white";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_VULPINE;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = true;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_VULPINE;
			this.tailCount = 6;
			this.tailFlags = [GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_LONG, GLOBAL.FLAG_FLUFFY, GLOBAL.FLAG_FURRED];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 0;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRatingRaw = 10;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
			this.buttRatingRaw = 10;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[0].bonusCapacity = 9001;
			
			this.breastRows[0].breastRatingRaw = 4;
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 100;
			
			this.createStatusEffect("Disarm Immune");
			
			hairColor = RandomInCollection(["red", "black", "blonde"]);
			furColor = hairColor;
			
			long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of ";
			if (hairColor == "red") {
				long += "unkempt, shoulder-length reddish";
				hairLength = 10;
				createCock(12);
				balls = 2;
				ballSizeRaw = 2;
			} else if (hairColor == "black") {
				long += "lustrous, ass-length black";
				hairLength = tallness / 1.5;
			} else {
				long += "long flaxen";
				hairLength = tallness / 2.2;
			}
			long += " hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [new CoCFoxJewel()];
			credits = (rand(10) + 10) * 10;
			
			this._isLoading = false;
		}
		
		// TODO: implement AI
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var moves:Array = [foxFireAttack, foxFireAttack, kitSuneTeases, kitSuneTeases];
			
			if (!target.hasStatusEffect("Grappled")) {
				 moves.push(kitsuneEntwine);
			} else {
				return; // all actions handled in player's turn
			}
			
			if (!target.hasStatusEffect("Sealed")) {
				moves.push(kitsuneSealAttack);
				moves.push(kitsuneSealAttack);
			} else 
			
			if (!hasStatusEffect("Illusion")) {
				 moves.push(illusionKitsuneAttack);
			}
			
			moves[rand(moves.length)](target);
		}
		
		public function postHostileTurnActions():void {
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Sealed")) {
				pc.addStatusValue("Sealed", 1, -1);
				if (pc.statusEffectv1("Sealed") <= 0)
					pc.removeStatusEffect("Sealed");
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", kitsuneStruggle, pc);
				addButton(4, "Do Nothing", kitsuneWait, pc);
				return;
			}
			if (pc.hasStatusEffect("Sealed"))
			{
				switch(pc.statusEffectv2("Sealed")) {
					case 0:
						addDisabledButton(0, "Attack", "Attack", "Your attack ability is sealed!");
						addDisabledButton(1, "Shoot", "Shoot", "Your attack ability is sealed!");
						break;
					case 1:
						addDisabledButton(5, "Tease", "Tease", "Your tease ability is sealed!");
						break;
					case 2:
						addDisabledButton(3, "Inventory", "Inventory", "Your inventory is sealed!");
						break;
					case 3:
						addDisabledButton(14, "Run", "Run", "Your retreat ability is sealed!");
						break;
					case 4:
						addDisabledButton(4, "Specials", "Specials", "Your special abilities are sealed!");
						break;
				}
			}
		}
		
		// Combat Abilities:
		// the kitsune are an almost purely magical mob, relying mainly on tease attacks and spells that raise lust.
		//Entwine:
		private function kitsuneEntwine(target:Creature):void
		{
			output("The kitsune closes in on you with a mischievous glint in her eyes.  You raise your guard, keeping your eyes trained on her to ensure that she doesn't try to pull anything.  Suddenly, you feel something coiling around your [pc.leg], and let out a yelp as you are suddenly lifted into the air, entangled in the kitsune's tails!");
			output("\n\nYour limbs are bound tightly while coils of delightfully soft fur caress you on all sides.  You can do little besides struggle against your furry bonds as the constant writhing of her tails sends shudders flying up and down your spine.");
			target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are entangled by all that soft and fluffy fox tails!", true);
			
			applyDamage(new TypeCollection( { tease : 10 + target.libido() / 8 } ), this, target);
		}

		//Struggle - event 5077 in combat.as
		public function kitsuneStruggle(target:Creature):void
		{
			clearOutput();
			clearMenu();
			//Struggle:
			output("You struggle against the kitsune's tails with all your might, desperately trying to free yourself before she has her way with you.");
			//Success
			if (rand(10) + target.PQ() / 10 + target.statusEffectv1("Grappled") >= 12) {
				output("  Summoning up reserves of strength you didn't know you had, you wrench yourself free of her tails, pushing her away.\n");
				target.removeStatusEffect("Grappled");
				CombatManager.processCombat();
			}
			//Failure - +5-10 LUST
			else {
				output("  Despite your valiant efforts, your wriggling only serves to get you deeper entangled in the fluffy tails, eliciting an amused giggle from the kitsune.");
				output("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!");
				applyDamage(new TypeCollection( { tease : 5 + target.libido() / 10 } ), this, target);
				target.addStatusValue("Grappled", 1, 3);
				CombatManager.processCombat();
			}
		}

		public function kitsuneWait(target:Creature):void
		{
			clearOutput();
			clearMenu();
			output("Happily, you slump deeper into the fluffy tails, eliciting an amused giggle from the kitsune.");
			if (kGAMECLASS.silly) output("  You're so glad you got to touch fluffy tail.");
			output("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!  ");
			
			applyDamage(new TypeCollection( { tease : 5 + target.libido() / 10 } ), this, target);
			
			CombatManager.processCombat();
		}

		//Fox Fire: - Low piercing damage, +10-15 LUST
		private function foxFireAttack(target:Creature):void
		{
			output("The kitsune makes a small circle in the air with her fingers, conjuring up a pale blue flame into her palm with the sound of flint striking against steel.  Pursing her lips, she blows it toward you with a kiss.");
			output("\n\nThe flames burn furiously, but leave you with an incredibly pleasant tingling sensation all over your body.  Your skin flushes with excitement, and you can feel blood rushing to your extremities, making you shudder with pleasure. ");
		
			applyDamage(new TypeCollection( { burning : 5 + rand(20), psionic : 15 + target.libido() / 10 } ), this, target);
		}

		//Illusion: - Raises enemy evasion, but can be resisted.
		//Factors affecting resist: INT (1% per point, max 70%), "Whispered" perk (20% flat bonus), "Religious" background and < 20 corruption (20% bonus at 0, losing 1% per point of corruption.)
		//Success:
		private function illusionKitsuneAttack(target:Creature):void
		{
			output("You struggle to keep your eyes on the kitsune, ghostly laughter echoing all around you as you turn to and fro, trying to track her movements.  It almost seems like the edges of reality are blurring around her, severely distorting your perceptions and making it hard to follow her.  It's going to be much harder to hit her if she keeps this up!");
			//Resist: - successfully resisting deals small health & lust damage to kitsune
			var resist:int = Math.min(30, target.WQ() / 3);
			if (target.hasPerk("Whispered")) resist += 20;
			if (target.hasPerk("History: Religious") && target.cor() < 20) resist += 20 - target.cor();
			if (target.hasTail(GLOBAL.TYPE_VULPINE)) resist += (target.tailCount - 1) * 10; // fellow kitsunes should be highly resistant!
			
			if (rand(100) < resist) {
				output("\n\nThe kitsune seems to melt away before your eyes for a moment, as though the edges of reality are blurring around her.  You tighten your focus, keeping your eyes trained on her, and she suddenly reels in pain, clutching her forehead as she is thrust back into view.  She lets out a frustrated huff of disappointment, realizing that you have resisted her illusions.");
			}
			else {
				createStatusEffect("Illusion", reflexes(), 0, 0, 0, false, "Icon_Haste", "Kitsune is hidden behind illusion!", true);
				reflexes(reflexesMax(), true);
			}
		}

		//Seal: - cancels and disables whatever command the player uses this round. Lasts 3 rounds, cannot seal more than one command at a time.
		//PCs with "Religious" background and < 20 corruption have up to 20% resistance to sealing at 0 corruption, losing 1% per corruption.
		private function kitsuneSealAttack(target:Creature):void
		{			
			var resist:int = Math.min(30, target.WQ() / 3);
			if (target.hasPerk("Whispered")) resist += 20;
			if (target.hasPerk("History: Religious") && target.cor() < 20) resist += 20 - target.cor();
			if (target.hasTail(GLOBAL.TYPE_VULPINE)) resist += (target.tailCount - 1) * 10; // fellow kitsunes should be highly resistant!
			
			var select:int = rand(5);
			//Attack:
			if (select == 0) {
				output("The kitsune playfully darts around you, grinning coyly.  She somehow slips in under your reach, and before you can react, draws a small circle on your chest with her fingertip.  As you move to strike again, the flaming runic symbol she left on you glows brightly, and your movements are halted mid-swing.");
				output("\n\n\"<i>Naughty naughty, you should be careful with that.</i>\"");

				output("\n\nDespite your best efforts, every time you attempt to attack her, your muscles recoil involuntarily and prevent you from going through with it.  <b>The kitsune's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
				target.createStatusEffect("Sealed", 4, 0, 0, 0, false, "Icon_Blocked", "Your attack ability is blocked by kitsune's magic!", true);
			}
			else if (select == 1) {
				//Tease:
				output("You are taken by surprise when the kitsune appears in front of you out of nowhere, trailing a fingertip down your chest.  She draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The kitsune's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
				target.createStatusEffect("Sealed", 4, 1, 0, 0, false, "Icon_Blocked", "Your tease ability is blocked by kitsune's magic!", true);
			}
			//Items:
			else if (select == 2) {
				output("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the kitsune says as she appears right in front of you, taking you off guard.  Her finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The kitsune's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
				target.createStatusEffect("Sealed", 4, 2, 0, 0, false, "Icon_Blocked", "Your inventory is blocked by kitsune's magic!", true);
			}
			//Run:
			else if (select == 3) {
				output("\"<i>Tsk tsk, leaving so soon?</i>\"  the kitsune says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, she draws a small circle on your chest with her fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your [pc.legs] won't budge!\n\n\"<i>Sorry baby, you'll just have to stay and play~.</i>\" she says in a singsong tone, appearing in front of you again.  <b>The kitsune's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
				target.createStatusEffect("Sealed", 4, 3, 0, 0, false, "Icon_Blocked", "Your retreat is blocked by kitsune's magic!", true);
			}
			//Special:
			else if (select == 4) {
				output("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your physical skills!");
				output("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
				output("\n\n<b>The kitsune's spell has sealed your special skills!</b>  You won't be able to use any of them until the spell wears off.");
				target.createStatusEffect("Sealed", 4, 4, 0, 0, false, "Icon_Blocked", "Your special skills are blocked by kitsune's magic!", true);
			}
			if (resist >= rand(100)) {
				output("\n\nUpon your touch, the seal dissipates, and you are free of the kitsune's magic!  She pouts in disappointment, looking thoroughly irritated, but quickly resumes her coy trickster facade.");
				target.removeStatusEffect("Sealed");
			}
		}

		//Tease Texts:
		private function kitSuneTeases(target:Creature):void
		{
			var select:int = rand(3);
			if (isHerm() && rand(2) == 0) select = 3;
			if (select == 0) output("You rub your eyes, suddenly seeing triple as you find yourself in the midst of a crowd of kitsune doppelgangers.  They run their hands all over you, teasing and doting on you as their tails caress every inch of your body.  Taken by surprise, you forget to fight back until they have already dispersed, blending back into a single fox-woman.");
			else if (select == 1) output("Bending forward, the kitsune runs her hands down over her breasts, jiggling them enticingly and squeezing them together.  Hooking a finger in her robes, she slides it down, tugging them aside until her nipples are just barely covered, and with a teasing smirk, pulls them back up, leaving you wanting.");
			else if (select == 2) output("Turning her back to you, the kitsune fans out her tails, peering back as she lifts the hem of her robe to expose her plump hindquarters.  Her tails continually shift and twist, blocking your view, but it only serves to make you want it even <i>more</i>, licking your lips in anticipation.");
			//Redhead only:
			else output("The kitsune sways her hips enticingly as she appears in front of you abruptly, rubbing up against your side.  Her teasing caresses make you shiver with arousal, and you can feel something thick and warm pressing against your [pc.hips].  She gives you a wry grin as she breaks away from you, sporting an obvious tent in her robes.  \"<i>Just you wait...</i>\"");
			applyDamage(new TypeCollection( { psionic : 5 + target.libido() / 7 } ), this, target);
		}
	}
}