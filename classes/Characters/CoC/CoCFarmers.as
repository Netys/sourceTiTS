package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.addDisabledButton;
	import classes.Engine.Utility.possessive;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCFarmers extends Creature
	{
		public function CoCFarmers()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Needs a few things checked.
			this.short = "farmers";
			this.originalRace = "sheep";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "This is a group of thirty angry villagers, almost all human-looking but for the tiny horn-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attackVerb = "stab";
			this.meleeWeapon.attackNoun = "stab";
			this.meleeWeapon.longName = "pitchforks";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 8;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "clothes";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.isLustImmune = true;
			
			this.level = 10;
			this.XPRaw = bossXP();
			this.credits = (rand(25) + 40) * 10;
			this.HPMod = 500;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 40 / 20 * this.level;
			this.reflexesRaw = 60 / 20 * this.level;
			this.aimRaw = 60 / 20 * this.level;
			this.intelligenceRaw = 35 / 20 * this.level;
			this.willpowerRaw = 35 / 20 * this.level;
			this.libidoRaw = 35;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 20;
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = rand(8) + 70;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 15;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "red";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_DEMONIC;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_DEMONIC;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_DEMONIC;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_DEMONIC;
			this.legType = GLOBAL.TYPE_DEMONIC;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
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
			this.buttRatingRaw = 10;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(9);
			this.shiftCock(0, GLOBAL.TYPE_GOAT);
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 3;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			this.vaginas = [];
			this.createVagina();
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 3;
			
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.05;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 1;
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity += 10;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Force It Gender");
			this.createPerk("Multiple Attacks", 5, 0, 0, 0, "");
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			if(!kGAMECLASS.pc.canFly()) addDisabledButton(14, "Run", "Run", "You are surrounded!");
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			packAttack(target);
		}
		
		public function packAttack(target:Creature):void {
			setPerkValue("Multiple Attacks", 1, rand((100 - Math.max(lustQ(), 100 - HPQ())) / 10) + 2);
			CombatAttacks.MeleeAttack(this, target);
		}
	}
}