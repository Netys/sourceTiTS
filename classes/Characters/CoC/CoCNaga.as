package classes.Characters.CoC
{
	import classes.Creature;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	
	public class CoCNaga extends Creature
	{
		//constructor
		public function CoCNaga()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "naga";
			this.originalRace = "naga";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
			this.customDodge = "The naga slides out of the way of your attack, serpentine body stretching and contorting in ways far beyond human ability.";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 3;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "scales";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 50;
			this.level = 2;
			this.credits = (rand(5) + 8) * 10;
			this.HPMod = 15;
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 28 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 42 / 20 * this.level;
			this.willpowerRaw = 42 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;			

			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "green";
			this.tallness = 5*12+10;
			this.thickness = 42;
			this.tone = 70;
			this.hairColor = "brown";
			this.scaleColor = "green";
			this.furColor = "";
			this.hairLength = 16;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "mediterranean-toned";
			this.skinFlags = [];
			
			this.faceType = GLOBAL.TYPE_SNAKE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_SNAKE;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 2;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_NAGA;
			this.legCount = 1;
			this.legFlags = [GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_TENDRIL, GLOBAL.FLAG_SCALED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_SNAKE;
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
			this.hipRatingRaw = 8;
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
			this.cumMultiplierRaw = 1.5;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 2;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 4;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 998;
			this.cockVirgin = true;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			this.createVagina();
			this.vaginas[0].hymen = false;
			this.vaginas[0].clits = 1;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].bonusCapacity = 40;
			this.vaginas[0].type = GLOBAL.TYPE_NAGA;
			this.vaginas[0].vaginaColor = "pink";
			//Goo is hyper friendly!
			this.elasticity = 1.4;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.30;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 3;
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			//this.createPerk("Multiple Attacks",1,0,0,0,"");
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			credits = (rand(5) + 8) * 10;
			
			this.inventory = [];			
			//this.drop = new WeightedDrop().
			//add(null,1).
			//add(consumables.REPTLUM,5).
			//add(consumables.SNAKOIL,4);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			CombatAttacks.MeleeAttack(this, target); // TODO: stub
		}
	}
}
