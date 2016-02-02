package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCPipe;
	import classes.Items.Melee.GooeyPsuedopod;
	import classes.Items.Miscellaneous.CoCGreenGel;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCGreenSlime extends Creature
	{
		//constructor
		public function CoCGreenSlime()
		{
			this._latestVersion = 1;
			this.version = this._latestVersion;
			this._neverSerialize = true;
			
			this.short = "green slime";
			this.originalRace = "goo";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.";
			this.customDodge = "The goo twists a portion of its body out of the way of the attack, moving in a way that would be fatal for any vertebrate.";
			this.customBlock = "Your attack sinks into the goo, the wound vanishing almost instantly as her surface recloses.";
			this.meleeWeapon = new GooeyPsuedopod();
			
			this.armor.longName = "gooey skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 50;
			this.level = 2;
			this.credits = rand(50) + 10;
			
			this.physiqueRaw = 4;
			this.reflexesRaw = 1;
			this.aimRaw = 1;
			this.intelligenceRaw = 1;
			this.willpowerRaw = 1;
			this.libidoRaw = 50;
			this.personality = 50;
			this.HPMod = 30;
			this.shieldsRaw = 0;
			this.HPRaw = this.HPMax();
			this.energyRaw = 100;
			this.lustRaw = 30;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.kinetic.resistanceValue = 75.0;
			baseHPResistances.electric.resistanceValue = -25.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			baseHPResistances.freezing.resistanceValue = -25.0;
			baseHPResistances.corrosive.resistanceValue = 75.0;
			baseHPResistances.poison.resistanceValue = 90.0;
			baseHPResistances.psionic.resistanceValue = 0.0;
			baseHPResistances.drug.resistanceValue = 0.0;
			baseHPResistances.pheromone.resistanceValue = -20.0;
			baseHPResistances.tease.resistanceValue = -25.0;
			
			this.femininity = 10;
			this.eyeType = 0;
			this.eyeColor = "green";
			this.tallness = 49;
			this.thickness = 60;
			this.tone = 50;
			this.hairColor = "green";
		    this.scaleColor = "green";
			this.furColor = "green";
			this.hairLength = 12;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_GOO;
			this.skinTone = "green";
			this.skinFlags = [GLOBAL.FLAG_SQUISHY, GLOBAL.FLAG_LUBRICATED, GLOBAL.FLAG_AMORPHOUS];
			this.faceType = 0;
			this.faceFlags = new Array();
			this.tongueType = 0;
			this.lipMod = 1;
			this.earType = 0;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_GOOEY;
			this.legCount = 1;
			this.legFlags = [GLOBAL.FLAG_AMORPHOUS];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = 0;
			this.tailCount = 0;
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
			this.hipRatingRaw = 6;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();			
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 50;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 24;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 400;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 5674;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			this.createCock(18, 2);
			this.cocks[0].cType = GLOBAL.TYPE_HUMAN;
			this.cocks[0].cockFlags = [GLOBAL.FLAG_GOOEY, GLOBAL.FLAG_LUBRICATED];
			//Goo is hyper friendly!
			this.elasticity = 100;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "deep emerald";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 5;
			
			tallness = rand(8) + 80;
			
			sexualPreferences.setRandomPrefs(3 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			
			inventory.push(kGAMECLASS.WeightedRandom( // TODO: WETCLTH 1/2
				[new CoCGreenGel(), new CoCPipe()],
				[1,                 10], true));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(2) == 0) {
				if (rand(3) == 0 && lust() > 30) lustReduction(target);
				else lustAttack(target)
			}
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		private function lustAttack(target:Creature):void {
			output("The creature surges forward slowly with a swing that you easily manage to avoid.  You notice traces of green liquid spurt from the creature as it does, forming a thin mist");
			if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
				output(" that makes your skin tingle with excitement when you inhale it.  ");
				applyDamage(new TypeCollection( { tease : 8 + target.libido() / 10 } ), this, target);
			}
			else output(" that resides on your armor.  ");
		}
		
		private function lustReduction(target:Creature):void {
			output("The creature collapses backwards as its cohesion begins to give out, and the faint outline of eyes and a mouth form on its face.  Its chest heaves as if it were gasping, and the bolt upright erection it sports visibly quivers and pulses before relaxing slightly.  ");
			lust( -13);
		}
	}
}