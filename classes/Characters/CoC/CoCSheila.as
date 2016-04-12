package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	
	public class CoCSheila extends Creature
	{
		public function CoCSheila() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			var sheilaDemon:Boolean = flags["COC.SHEILA_DEMON"] == 1;
			this.short = "Sheila";
			this.originalRace = "kangaroo";
			this.a = "";
			this.capitalA = "";
			if (sheilaDemon)
			{
				this.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + kGAMECLASS.sheilaCup() + " breasts on her chest" +(kGAMECLASS.sheilaCorruption() <= 40 ? " are firm, squeezable teardrops; she runs a hand absently over one from time to time." :	" jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.") +"  Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself.";
			}
			else
			{
				this.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Most of her lightly-tanned skin is hidden, either by her vest and shorts or by the fuzzy fur that covers her legs from the thighs down to her prominent nails.  Her " + kGAMECLASS.sheilaCup() + " breasts are briefly defined against the white of her shirt as she sways on her feet, " + (kGAMECLASS.sheilaCorruption() <= 40 ? "small, round things that match her slender frame." : "swollen, jiggling globes that stand in contrast to her slender body and tell a tale of all the corruption that has been pumped into her.") + "  Her straight, jaw-length auburn hair hangs unrestrained, falling around the fuzzy ears that stick out sideways from her head.  The hat she usually wears is hanging on her back by a string, pushed off to prevent its being lost in the chaos.  Something about slipping a rope around her own neck just to keep a hat tells you that Sheila's mind isn't really staying in the fight - though it could also be the desperate, faraway look in her eyes.";
			}
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "foot";
			this.meleeWeapon.attackVerb = "kick";
			this.meleeWeapon.attackNoun = "kick";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 3;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			baseHPResistances.psionic.resistanceValue = sheilaDemon ? 85 : 60.0;
			baseHPResistances.drug.resistanceValue = sheilaDemon ? 85 : 60.0;
			baseHPResistances.pheromone.resistanceValue = sheilaDemon ? 85 : 60.0;
			baseHPResistances.tease.resistanceValue = sheilaDemon ? 85 : 60.0;
			
			this.XPRaw = 1500;
			this.level = 14;
			this.credits = (rand(5) + 5) * 10;
			this.HPMod = sheilaDemon ? 400 : 200;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = (sheilaDemon ? 80 : 95) / 20 * this.level;
			this.aimRaw = (sheilaDemon ? 80 : 95) / 20 * this.level;
			this.intelligenceRaw = 50 / 20 * this.level;
			this.willpowerRaw = 50 / 20 * this.level;
			this.libidoRaw = 30;
			this.personality = kGAMECLASS.sheilaCorruption();
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = sheilaDemon ? 50 : 30;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 6 * 12;
			this.thickness = 30;
			this.tone = 70;
			this.hairColor = "auburn";
			this.scaleColor = "none";
			this.furColor = "auburn";
			this.hairLength = 11;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "tan";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_KANGAROO;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_KANGAROO;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_KANGAROO;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_KANGAROO;
			this.gills = true;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_KANGAROO;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_KANGAROO;
			this.tailCount = 1;
			this.tailFlags = [];
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
			this.hipRatingRaw = 4;
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
			this.buttRatingRaw = 5;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_KANGAROO;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = sheilaDemon ? 3 : 1;
			this.vaginas[0].bonusCapacity = 15;
			
			this.breastRows[0].breastRatingRaw = int(kGAMECLASS.sheilaCorruption() / 10);
			this.nippleColor = "gray";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 40;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			if (!sheilaDemon) inventory.push(new CoCKangaFruit());
			else inventory.push(kGAMECLASS.WeightedRandom(
				[new CoCKangaFruit(), new CoCIncubiD(), new CoCSucMilk()] ,
				[1,                   1,                1]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (flags["COC.SHEILA_DEMON"] == 1) {
				demonSheilaAI(target);
				return;
			}
			if (rand(3) == 0) CombatAttacks.MeleeAttack(this, target);
			else if (rand(2) == 0) sheilaFlyingKick(target);
			else sheilaFrogPunch(target);
		}

		/*
		so it's come to a [Fight] - combat before demon Sheila:
		-fast and fairly strong, can deal decent damage and dodges attacks/phys specials very well, hard to escape if piqued, but light on hp/lust res and very vulnerable to magic or constrict if captured - goes down in 1-2 good attacks
		-overall, weaker but faster than other shit on the plains*/

		//special 1: frog punch (med-high damage, slightly lower accuracy than reg attack, deals minor concussion which adds 5-10 pts fatigue, may stun pc and prevent attack, misses while blinded or misfires on pcs under 3'6")
		private function sheilaFrogPunch(target:Creature):void {
			//Midget misfire (if PC < 3'6"):
			if (target.tallness < 42 && rand(2) == 0) {
				output("Sheila bounces up to you and crouches low, curling her body like a watchspring.  She uncoils with her fist aimed at your jaw, but you easily perform a crouch of your own and duck under her lanky form, unbending yourself to push her legs up as she flies harmlessly overhead.  You can hear a partial shriek before she crashes face-first into the dirt behind you. ");
				applyDamage(new TypeCollection( { kinetic : 3 + rand(10) } ), this, this);
			}
			//Miss:
			else if (combatMiss(this, target, -5, 1.2)) {
				output("Sheila bounces up to you and crouches low, curling up her body like a watchspring.  The girl uncoils with fist raised, but you lean away from the uppercut, catching a faceful of her breasts instead!  Sheila squeals and pushes away from you");
				//[(libido>40)
				if (target.slut() > 40) {
					output(", though not before you have a chance to stick your tongue in her cleavage!");
				}
				else output(".");
				output("  Blushing pinkly, she crosses her arms over her chest as she resumes her distance.");
				//(+med-small lib-based lust damage to PC)
				applyDamage(new TypeCollection( { tease : 10 + rand(target.libido() / 10) } ), this, target);
			}
			//Hit:
			else {
				output("Sheila bounces up to you and crouches low, curling up her body like a watchspring.  The girl uncoils just as quickly, launching herself at your face with a fist raised in front of her.  She lands a staggering crack on your jaw which knocks your head back and blurs your vision!  ");
				//deals minor concussion which adds 5-10 pts fatigue, may stun pc and prevent attack, misses while blinded or misfires on pcs under 3'6")
				if (rand(2) == 0 && !target.hasPerk("Resolute")) {
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
					output("<b>You are stunned!</b>  ");
				}
				var damage:TypeCollection = this.meleeDamage();
				damageRand(damage.multiply(0.95), 15);
				applyDamage(damage, this, target);
				target.energy( -(5 + rand(5)));
			}
		}

		//special 2: flying kick rabbit punch (high damage, much lower accuracy than reg attack, deals concussion which adds 10-15 pts fatigue, may stun pc and prevent attack)
		private function sheilaFlyingKick(target:Creature):void {
			//Miss:
			if (combatMiss(this, target, -5, 2)) {
				output("Sheila squats down, then bounds explosively toward you!  She swings her leg out in front to kick, but you roll to the side and she slips past your shoulder.  You hear an \"<i>Oof!</i>\" as she lands on her butt behind you.  When you turn to look, she's already back to her feet, rubbing her smarting posterior and looking a bit embarrassed.");
				//(small Sheila HP loss)
				applyDamage(new TypeCollection( { kinetic : 3 + rand(10) } ), this, this);
			}
			//Hit:
			else {
				output("Sheila squats down, then bounds explosively toward you feet-first!  She snaps one leg out softly just as she reaches your chest, then twists her body to the side, bringing her other leg over and landing a kick to the rear of your skull!  Your vision blurs and you wobble on your feet as she pushes off your chest.  ");
				//Stun triggered:
				if (rand(2) == 0 && !target.hasPerk("Resolute")) {
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
					output("<b>You are stunned!</b>  ");
				}
				var damage:TypeCollection = this.meleeDamage();
				damageRand(damage.multiply(1.5), 15);
				applyDamage(damage, this, target);
				target.energy( -(10 + rand(6)));
			}
		}

		//[Fight] - Combat with demon Sheila (demon sheila = 1):
		//-slightly slower, has much more stamina, intel, and HP now
		//-all special attacks are lust damage
		//-no normal attack
		//-starts with a high base lust(50%+), but also has high resistance to additional lust damage
		//-little higher difficulty than other plains fights, but not much
		//-now totally okay with taking gems and riding the player so hard he passes out for 8 hours regardless
		//-drops shitty kangaroo item and imp food

		//Demon Sheila Combat - Descrip
		//You are fighting Sheila! [Level: Whoopi Goldberg's dreadlocks]
		//Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + sheilaCup() + " breasts on her chest [(sheila corruption <=40)are firm, squeezable teardrops; she runs a hand absently over one from time to time.  /(else)jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.  ]Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself.
		
		private function demonSheilaAI(target:Creature):void {
			//Count up till give up!
			if (!hasStatusEffect("Counter")) createStatusEffect("Counter");
			addStatusValue("Counter", 1, 1);
			if (statusEffectv1("Counter") >= 5) {
				sitAndPout(target);
				return;
			}
			var choices:Array = [];

			if (!target.hasStatusEffect("SheilaOil")) {
				choices = [suspiciousGlint,
					tittyMonsterAttack,
					splashAttackLookOutShellEvolveIntoGyrados];
			}
			else {
				choices = [pressurePointsAttack,
					lickEmAndStickEm];
			}
			choices[rand(choices.length)](target);
		}
		
		//Demon Sheila Combat - Special Attacks
		//1: Suspicious Glint (int-based hit chance)
		private function suspiciousGlint(target:Creature):void {
			if (hasStatusEffect("Blinded") && rand(2) == 0) {
				output("Sheila's blind eyes glint suspiciously as she focuses her power, trying to send her fantasy to anything caught in their stare.  It seems to work - the rock next to you vibrates a little.");
			}
			//Miss:
			else if (target.willpower() / 10 + rand(20) + 1 > 16) {
				output("Sheila's eyes glint suspiciously as she proclaims her affection for you and begs you to look into them, but you keep your head down and focus on her feet.  You can feel her stare boring holes into you, but eventually she abandons the attempt.");
			}
			//Hit:
			else {
				output("Sheila's eyes glint suspiciously, and you feel your mind slowing down and your body heating up as you meet her lascivious gaze.  Too late you look away, but the damage is done; her fantasies of ");
				if (!target.hasCock()) output("burying her drooling tail inside you until it squirts");
				else output("riding your dick to the hilt");
				output(" run rampant inside your head and crowd out everything else.  \"<i>Did you see it, [pc.name]?  My love for you?</i>\" Sheila asks, smiling.  God, did you ever!  You can hardly focus on anything!");
				//big (20+) int drop and big lib-based lust gain if successful, locks Infest command for the fight if successful, always misses if Sheila is blinded
				if (!target.hasStatusEffect("TwuWuv")) {
					target.createStatusEffect("TwuWuv", 0, 0, 0, 0);
					var counter:int = 20 + rand(5);
					// inteDown.visible = true;
					// inteUp.visible = false;
					while(counter > 0) {
						if (target.willpowerRaw >= 2) {
							target.willpowerRaw--;
							target.addStatusValue("TwuWuv", 1, 1);
						}
						counter--;
					}
				}
				applyDamage(new TypeCollection( { psionic : 30 + target.libido() / 10 + target.cor() / 10 } ), this, target);
			}
		}
		
		public function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("TwuWuv")) {
				kGAMECLASS.pc.willpowerRaw += kGAMECLASS.pc.statusEffectv1("TwuWuv");
				kGAMECLASS.pc.removeStatusEffect("TwuWuv");
			}
			kGAMECLASS.pc.removeStatusEffect("SheilaOil");
		}
		
		//2: Tittymonster
		private function tittyMonsterAttack(target:Creature):void {
			output("Sheila giggles and strokes her " + kGAMECLASS.sheilaCup() + " breasts, trying to entice you.");
			//results, no new pg
			//[(sheila corruption < 20; 'miss')
			if (kGAMECLASS.sheilaCorruption() < 20) output("  But with nothing there for her to work with, it's a lot like being teased by a dressmaker's mannequin.");
			//(else if sheila corruption < 150; 'hit')
			else if (kGAMECLASS.sheilaCorruption() < 150) {
				output("  As her hands run over the soft-looking mammaries, kneading and squeezing them, teasing the nipples relentlessly until she lets out a cute little moan, you feel the blood rush to your face.  \"<i>Enjoying this, are you?</i>\" she calls sweetly.  \"<i>Why don't you stop being contrary and come play with them too?</i>\"");
				//med lib-based lust damage if 20 < sheila corruption < 150
				applyDamage(new TypeCollection( { tease : 25 + target.libido() / 10 } ), this, target);
			}
			//(else; 'miss')
			else {
				output("  She has trouble even budging tits so comically mismatched to her slender frame; her hands just sink into the voluminous flesh when she tries to squeeze them together, but the demon doesn't manage to move mountains.  It's like watching someone try to push half-inflated swimming equipment around.  You actually laugh a little as she gives up, rubbing her lower back with a gripe.");
			}
		}

		//3: Splash (spd-based hit chance)
		private function splashAttackLookOutShellEvolveIntoGyrados(target:Creature):void {
			output("Sheila waits patiently, staring at you and stroking her dark, spaded tail with its opposite.  A line of the always-oozing oil falls from the slit, pooling in the smooth brown coil; she unwinds it rapidly, flinging the liquid at your face playfully.  ");
			//results, no new PG
			if (rangedCombatMiss(this, target)) {
				output("You easily lean away from the path of her tainted fluids, and she sighs.  \"<i>You're no fun, mate.</i>\"");
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("The oil can't seep into your airtight armor!");
			}
			//Hit:
			else {
				output("It lands on target, and you're forced to close your eyes lest it get in them!");
				target.createStatusEffect("Blinded", 1, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
				target.createStatusEffect("SheilaOil", 0, 0, 0, 0);
			}
		}
		
		//4: Sit 'n Pout
		//should only be used after turn 4 or 5
		private function sitAndPout(target:Creature):void {
			output("Sheila frowns at you, then plops down on the grass, staring at her feet.  \"<i>Fine.  You win, mate.  I don't feel like arguing anymore, so... just please yourself, I guess.  The best part about a lovers' quarrel is the make-up sex anyway...</i>\" she says, spreading her legs hopefully.  The pout turns to a very faint smile under her bangs.");
			credits = 0;
			XPRaw = 0;
			inventory = [];
			lust(lustMax(), true);
			//(if PC lust < 30)
			if (target.lust() < 33) {
				output("\n\nYou're not that interested, though; Sheila harrumphs as you pass her by and leave.\n\n");
				CombatManager.abortCombat();
				return;
			}
			//end fight, suppress xp/gem/item reward, go to victory choices if lust >= 30
		}

		//5: Lick 'Em and Stick 'Em (int-based hit chance)
		//replaces any calls for Suspicious Glint if PC is blinded by Splash
		private function lickEmAndStickEm(target:Creature):void {
			output("Sheila's voice gets closer, becoming disarmingly apologetic as you scrub furiously at your face in darkness.  \"<i>Oh, my.  I didn't mean to get that in your eyes... let me help clean you up, love.</i>\"  Your face is gently gripped between her hands and pulled down, then the demon begins passing her tongue over you affectionately, wiping the fluid away with long, ticklish licks as you wait for the other shoe to fall.");
			output("\"<i>All better,</i>\" Sheila announces.  With her thumb, she gingerly pushes one eyelid up before you can pull away, proving her claim - and causing you to look right into her own glowing, purple iris.  A fantasy invades your mind, one where ");
			if (target.hasCock()) output("[pc.oneCock] fucks Sheila to the base while her tail snakes around and penetrates your [pc.vagOrAss]");
			else output("you take Sheila from behind by plunging her spaded tail into your [pc.vagina] as she lies face-down on the ground with her ass pushed in the air");
			output(".");
			//results, no new pg
			//[(int check passed)
			//Miss:
			if (target.willpower() / 10 + rand(20) + 1 > 16) {
				output("\n\nBefore the fantasy can advance, you recoil and pull out of the demon's hands, shoving her away.");
				applyDamage(new TypeCollection( { psionic : 15 + target.libido() / 20 + target.cor() / 20 } ), this, target);
			}
			//(int check failed)
			else {
				output("\n\nYour ego's urgent danger warnings are drowned in a sea of rising lust, and you find yourself transfixed.  The vision continues until Sheila tires of fantasizing.");
				//mild lib-based lust gain if PC resists; else big int drop and big lib-based lust gain plus Infest lock for remainder of fight
				applyDamage(new TypeCollection( { psionic : 25 + target.libido() / 20 + target.cor() / 20 } ), this, target);
				//harder to resist and bigger damage than normal Suspicious Glint
			}
		}

		//6: "Pressure Points"
		//replaces any calls for Tittymonster if PC is blinded by Splash
		private function pressurePointsAttack(target:Creature):void {
			output("For a moment, all goes quiet, save for a soft rustle.\n\n");
			//results, no new pg
			//[(sheila corruption < 100; hit, 'light damage')]
			if (kGAMECLASS.sheilaCorruption() < 100) {
				output("The silence is broken with a giggle as the demon catches you in an embrace, pressing her " + kGAMECLASS.sheilaCup() + " breasts into you.  You shiver as she drags the perky nipples over your " + target.skinFurScales() + ", but push her away.");
				applyDamage(new TypeCollection( { tease : 15 + target.libido() / 20 + target.cor() / 20 } ), this, target);
			}
			else if (kGAMECLASS.sheilaCorruption() < 300) {
				output("A sigh ends the silence as your body is partially enfolded in the hot valley of an aroused Sheila's cleavage. As the demon grabs you and pushes her tits into you, the skin-on-" + target.skinFurScales() + " contact makes you shiver, and your attempts to get free meet with some resistance... or rather, a lack of resistance, as the soft, yielding breast flesh quivers and heats to your touch without moving the demon overmuch.  You accidentally brush her nipples several times before you can escape, unleashing horny moans from Sheila that linger in your mind.");
				applyDamage(new TypeCollection( { tease : 25 + target.libido() / 20 + target.cor() / 20 } ), this, target);
			}
			else {//; miss)
				output("You're a bit unnerved, but soon realize that you can tell where Sheila is by listening for the telltale sounds of her colossal breasts scraping the ground as she draws closer to you.  With this in mind, you continue to face your opponent and back away as you wipe your eyes.");
				output("\n\n\"<i>Aww, come on!</i>\" she whines.");
			}
		}
	}
}