package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Apparel.ComfortableClothes;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.TITSSaveEdit.Data.CoCTypeDefs;
	
	public class CoCKatherine extends Creature
	{
		public function CoCKatherine() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Kath";
			this.originalRace = "cat-morph";
			this.a = "";
			this.capitalA = "";
			this.long = "";
			this.customDodge = "";
			this.customBlock = "";
			
			this.armor = new ComfortableClothes(); // sort of placeholder
			this.inventory.push(this.armor);
			this.armor.longName = "clothing";
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 4;
			this.physiqueRaw = 40 / 20 * this.level;
			this.reflexesRaw = 100 / 20 * this.level;
			this.aimRaw = 70 / 20 * this.level;
			this.intelligenceRaw = 65 / 20 * this.level;
			this.willpowerRaw = 10 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_FELINE;
			this.eyeColor = "green";
			this.tallness = 5 * 12 + 2;
			this.thickness = 20;
			this.tone = 65;
			this.hairColor = "neon pink";
			this.scaleColor = "none";
			this.furColor = "black";
			this.hairLength = 20;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "fair";
			this.skinFlags = [];
			this.faceType = GLOBAL.TYPE_FELINE;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_FELINE;
			this.tongueFlags = [GLOBAL.FLAG_NUBBY];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_FELINE;
			this.armType = GLOBAL.TYPE_FELINE;
			this.armFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_FELINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED];
			this.tailType = GLOBAL.TYPE_FELINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED];
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRatingRaw = 2;
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
			this.buttRatingRaw = 2;
			//No dicks here!
			this.cocks = [];
			this.createCock(8, 4 / 3);
			this.shiftCock(0, GLOBAL.TYPE_CANINE);
			this.cocks[0].knotMultiplier = 4;
			this.cumMultiplierRaw = 10;
			this.refractoryRate = 15;
			this.cumQualityRaw = 0;
			this.balls = 2;
			this.ballSizeRaw = 3;
			this.ballFullness = 100;
			this.ballEfficiency = 4;
			this.minutesSinceCum = 9999;
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_FELINE;
			this.vaginalVirgin = false;
			this.vaginas[0].hymen = false;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 20;
			this.elasticity = 3;
			this.fertilityRaw = 0;
			
			this.breastRows[0].breastRatingRaw = 2; // B
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 10;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.createPerk("Sterile", 0, 0, 0, 0);
			
			this._isLoading = false;
		}

		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{}
		
		public function CockMultiple(single:String, double:String):String { return (cocks.length < 2 ? single : double); }
		
		public function catGirl(isCatGirl:String, isCatMorph:String):String { return (hasFur() ? isCatMorph : isCatGirl); }
		
		public function cockType(dogText:String = "canine", catText:String = "feline"):String { return (hasCock(GLOBAL.TYPE_CANINE) ? dogText : catText); }
		
		public function cockAdj():String
		{
			if (longestCockLength() <= 5) return "little ";
			if (longestCockLength() <= 7) return " ";
			if (longestCockLength() <= 10) return "sizeable ";
			if (longestCockLength() <= 14) return "large ";
			if (longestCockLength() <= 18) return "huge ";
			return "enormous ";
		}

		public function knotAdj():String {
			var knot:Number = cocks[0].knotMultiplier;
			if (knot < 1.5) return "small";
			if (knot >= 4) return "huge";
			return "sizeable";
		}
		
		public function hasBalls():Boolean { return balls > 0; }
		
		public function ballAdj():String
		{
			if (ballDiameter() <= 1) return "small";
			if (ballDiameter() <= 3) return "large";
			if (ballDiameter() <= 5) return "huge";
			if (ballDiameter() <= 7) return "massive";
			return "enormous";
		}
		
		public function fertileText(fertileText:String, infertileText:String):String { return (fertility() > 0 ? fertileText : infertileText); }
		
		public function playerMaster():Boolean { return kGAMECLASS.flags["COC.KBIT_SUB_CALL_MASTER"] != undefined; }
		
		public function clothesChoice(...args:*):String
		{
			return args[0];
		}
		
		public function clothesLowerChoice(...args:*):String
		{
			return args[0];
		}
	}
}