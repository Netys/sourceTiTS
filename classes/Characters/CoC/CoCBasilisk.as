package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Armor.CoCChainmailBikini;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCScimitar;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCBasilisk extends Creature
	{
		public function CoCBasilisk() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "basilisk";
			this.originalRace = "basilisk";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  He has a thin but ropy build, his tightly muscled yellow underbelly the only part of his frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind his skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at his face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 30;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 50.0;
			//baseHPResistances.drug.resistanceValue = 50.0;
			//baseHPResistances.pheromone.resistanceValue = 50.0;
			//baseHPResistances.tease.resistanceValue = 50.0;
			
			this.armor.longName = "scales";
			this.armor.defense = 10;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1000;
			this.level = 12;
			this.credits = (rand(10) + 10) * 10;
			this.HPMod = 200;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 85 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 70 / 20 * this.level;
			this.willpowerRaw = 70 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "red";
			this.tallness = 6 * 12 + 2;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "gray";
			this.scaleColor = "gray";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "gray";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_LIZAN;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_LIZAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_SCALED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_LIZAN;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK, GLOBAL.FLAG_PREHENSILE];
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
			this.hipRatingRaw = 3;
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
			this.buttRatingRaw = 4;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(6);
			this.shiftCock(0, GLOBAL.TYPE_SNAKE);
			
			this.balls = 2;
			this.ballSizeRaw = 2;
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 30;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Genital Slit", 0, 0, 0, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
					
			if (rand(10) != 0) inventory.push(new CoCReptilum());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if(!target.hasStatusEffect("Basilisk Compulsion") && rand(3) == 0 && !hasStatusEffect("Blinded")) compulsion(target);
			else if(rand(3) == 0) basiliskTailSwipe(target);
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		public function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Basilisk Slow")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Basilisk Slow"));
				kGAMECLASS.pc.removeStatusEffect("Basilisk Slow");
			}
		}
		
		public static function basiliskSpeed(target:Creature, amount:Number = 0):void {
			if (!target.hasStatusEffect("Basilisk Slow") < 0) target.createStatusEffect("Basilisk Slow", 0, 0, 0, 0, false, "Icon_Slow", "You are slowed down by basilisk gaze!", true);
			
			while(amount > 0 && target.reflexes() > 2) {
				amount--;
				target.addStatusValue("Basilisk Slow", 1, 1);
				target.reflexes( -1);
			}
		}
		
		public static function canLookIntoEyes():Boolean {
			return kGAMECLASS.pc.hasPerk("Basilisk Resistance")
				|| kGAMECLASS.pc.hasPerk("Enlightened Nine-tails") && InCollection(kGAMECLASS.pc.eyeColor, kGAMECLASS.elderKitsuneEyeColors)
				|| kGAMECLASS.pc.hasPerk("Corrupted Nine-tails") && InCollection(kGAMECLASS.pc.eyeColor, kGAMECLASS.corruptKitsuneEyeColors)
				|| InCollection(kGAMECLASS.pc.eyeType, GLOBAL.TYPE_MYR, GLOBAL.TYPE_GABILANI, GLOBAL.TYPE_SYNTHETIC);
		}

		//special 1: basilisk mental compulsion attack
		//(Check vs. Intelligence/Sensitivity, loss = recurrent speed loss each
		//round, one time lust increase):
		private function compulsion(target:Creature):void {
			output("The basilisk opens its mouth and, staring at you, utters words in its strange, dry, sibilant tongue.  The sounds bore into your mind, working and buzzing at the edges of your resolve, suggesting, compelling, then demanding you look into the basilisk's eyes.  ");
			// few special eyes can even turn the tables... though this requires enormous willpower
			if (target.hasPerk("Enlightened Nine-tails") && InCollection(target.eyeColor, kGAMECLASS.elderKitsuneEyeColors)) {
				output("You are looking directly into Basilisk eyes, and he is looking into yours...  However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk. And basilisk for his part see only unfathomable serenity of clear summer sky...  ");
				if (rand(target.willpower()) > willpower()) {
					createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blinded", "Basilisk is dazzled under your gaze!", true, 0);
					output("Losing the clash of wills, basilisk is dazzled under your gaze!");
				} else output("The basilisk curses as he finds out that your gaze can be as dangerous as his own!");
				target.createStatusEffect("Basilisk Compulsion", 0, 0, 0, 0, true, "", "", true, 0); // will not try again
			}
			else if (target.hasPerk("Corrupted Nine-tails") && InCollection(target.eyeColor, kGAMECLASS.corruptKitsuneEyeColors)) {
				output("You are looking directly into Basilisk eyes, and he is looking into yours...  However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk. And basilisk for his part see only cold gleam of dull winter sky...  ");
				if (rand(target.willpower()) > willpower()) {
					createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blinded", "Basilisk is dazzled under your gaze!", true, 0);
					output("Losing the clash of wills, basilisk is dazzled under your gaze!");
				} else output("The basilisk curses as he finds out that your gaze can be as dangerous as his own!");
				target.createStatusEffect("Basilisk Compulsion", 0, 0, 0, 0, true, "", "", true, 0); // will not try again
			}
			//Immune to Basilisk?
			else if (target.hasPerk("Basilisk Resistance")) {
				output("You can't help yourself... you glimpse the reptile's grey, slit eyes. However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk. The basilisk curses as he finds out that you're immune!");
				target.createStatusEffect("Basilisk Compulsion", 0, 0, 0, 0, true, "", "", true, 0); // will not try again
			}
			// solid color eyes, also cold glass of optic sensor implant
			else if (InCollection(kGAMECLASS.pc.eyeType, GLOBAL.TYPE_MYR, GLOBAL.TYPE_GABILANI, GLOBAL.TYPE_SYNTHETIC)) {
				output("You are looking directly into Basilisk eyes, and he is looking into yours...  However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk.  The basilisk curses as he finds out that he can't catch your eye!");
				target.createStatusEffect("Basilisk Compulsion", 0, 0, 0, 0, true, "", "", true, 0); // will not try again
			}
			//Failure:
			else if (target.WQ() / 5 + rand(20) < 24) {
				output("You concentrate, focus your mind and resist the basilisk's psychic compulsion."); // WILL try again
			}
			//Success:
			else {
				output("You can't help yourself... you glimpse the reptile's grey, slit eyes. You look away quickly, but you can picture them in your mind's eye, staring in at your thoughts, making you feel sluggish and unable to coordinate. Something about the helplessness of it feels so good... you can't banish the feeling that really, you want to look in the basilisk's eyes forever, for it to have total control over you.  ");
				applyDamage(new TypeCollection( { psionic : 3 } ), this, target);
				
				//apply status here
				basiliskSpeed(target, 20);
				target.createStatusEffect("Basilisk Compulsion", 0, 0, 0, 0, true, "", "", true, 0); // will not try again
				IncrementFlag("COC.BASILISK_RESISTANCE_TRACKER");
				IncrementFlag("COC.BASILISK_RESISTANCE_TRACKER");
			}
		}
		
		//Special 3: basilisk tail swipe (Small physical damage):
		private function basiliskTailSwipe(target:Creature):void {
			output("The basilisk suddenly whips its tail at you, swiping your [pc.feet] from under you!  You quickly stagger upright, being sure to hold the creature's feet in your vision.  ");
			
			var d:TypeCollection = this.meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			if (damageResult.totalDamage == 0) output("The fall didn't harm you at all.  ");
			
			outputDamage(damageResult);
		}
	}
}