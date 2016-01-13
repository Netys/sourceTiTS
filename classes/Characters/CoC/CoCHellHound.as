package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	
	
	public class CoCHellHound extends Creature
	{
		//constructor
		public function CoCHellHound()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "hellhound";
			this.originalRace = "hellhound";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.";
			this.customBlock = "";
					
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "thick fur";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 200;
			this.level = 5;
			this.credits = rand(50) + 50;
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 40 / 20 * this.level;
			this.aimRaw = 40 / 20 * this.level;
			this.intelligenceRaw = 1 / 20 * this.level;
			this.willpowerRaw = 1 / 20 * this.level;
			this.libidoRaw = 95;
			this.energyRaw = 100;
			this.lustRaw = 25;
			this.HPMod = 25;
			this.HPRaw = this.HPMax();
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_CANINE;
			this.eyeColor = "black";
			this.tallness = 47;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "red";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 3;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "black";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_CANINE;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_CANINE;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_CANINE;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_CANINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_CANINE;
			this.tailCount = 1;
			this.tailFlags = new Array();
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
			this.cocks = [];
			this.createCock(12);
			this.shiftCock(0, GLOBAL.TYPE_CANINE);
			this.createCock(12);
			this.shiftCock(1, GLOBAL.TYPE_CANINE);
			//balls
			this.balls = 4;
			this.cumMultiplierRaw = 5;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 4;
			this.ballFullness = 1;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.05;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows = [];
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;

			this.createStatusEffect("Disarm Immune");
			
			credits = (10 + rand(10)) * 10;
			
			sexualPreferences.setRandomPrefs(5+rand(3));
						
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCCaninePepper(), new CoCCaninePepperBlack(), new CoCCaninePepperBulby(), new CoCCaninePepperDouble(), new CoCCaninePepperKnotty(), new CoCCaninePepperLarge()] ,
						[10,                    1,                          1,                          1,                           1,                           1]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0) hellhoundFire(target);
			else CombatAttacks.MeleeAttack(this, target);
		}

		public function hellhoundFire(target:Creature):void {
			//Blind dodge change
			if(hasStatusEffect("Blinded")) {
				output(capitalA + short + " completely misses you with a wave of dark fire! Thank the gods it's blind!");
			}
			else if(rangedCombatMiss(this, target)) {
				output("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You easily avoid the wave, diving to the side and making the most of your talents at evasion.");
			}
			else {
				//Determine the damage to be taken
				output("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much, the unnatural heat fills your body with arousal. ");
				//game.dynStats("lus", 20+(player.sens/10));
				applyDamage(new TypeCollection( { psionic : 20 + (target.libido() / 10), burning : 15 + rand(10) } ), this, target, "minimal");
			}
		}

		//protected function hellhoundScent():void {
			//if(player.findStatusAffect(StatusAffects.NoFlee) >= 0) {
				//if(spe == 100) {
					//hellhoundFire();
					//return;
				//}
				//else {
					//outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.", false);
					//spe = 100;	
				//}
			//}
			//else {
				//spe += 40;
				//outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...", false);
				//
			//}
			//processCombat();
		//}
	}
}