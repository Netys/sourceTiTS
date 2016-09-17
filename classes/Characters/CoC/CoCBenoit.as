package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	
	public class CoCBenoit extends Creature
	{
		public function CoCBenoit() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Benoit";
			this.originalRace = "basilisk";
			this.a = "";
			this.capitalA = "";
			this.long = "";
			this.customDodge = "";
			this.customBlock = "";
			
			this.armor.longName = "scales";
			this.armor.defense = 10;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.inventory = []; // trader's inventory is handled by custom mechanics
			this.sellMarkup = 2.0;
			this.buyMarkdown = 0.33;
			this.typesBought = [GLOBAL.ALL];
			
			this.keeperSell = "\"<i>Let us feel what you are trying to palm off upon me zis time, zen,</i>\" sighs [benoit.short], sitting down and opening [benoit.hisHer] hand to you.";
			this.keeperBuy = "\"<i>Some may call zis junk,</i>\" says [benoit.short], indicating [benoit.hisHer] latest wares.  \"<i>Me... I call it garbage.</i>\"";
			
			this.level = 12;
			this.XPRaw = normalXP();
			this.credits = 5000;
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
			this.personality = 60;
			
			this.femininity = 10;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "murky";
			this.tallness = 6 * 12 + 2;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "iridescent red";
			this.scaleColor = "gray";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = GLOBAL.HAIR_TYPE_FEATHERS;
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
			this.earType = GLOBAL.TYPE_LIZAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = GLOBAL.TYPE_LIZAN;
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
			
			if (kGAMECLASS.flags["COC.BENOIT_STATUS"] == 3 || int(kGAMECLASS.flags["COC.BENOIT_STATUS"]) == 0)
			{
				this.createCock(12, 0.5);
				this.shiftCock(0, GLOBAL.TYPE_SNAKE);
				
				this.balls = 2;
				this.ballSizeRaw = 2;
			}
			
			this.impregnationType = "CoCBenoitPregnancy";
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			if (kGAMECLASS.flags["COC.BENOIT_STATUS"] > 0)
			{
				this.breastRows[0].breastRatingRaw = 1;
				this.createVagina();
				this.shiftVagina(0, GLOBAL.TYPE_SNAKE);
				this.femininity = 75;
				this.hipRatingRaw = 12;
				this.buttRatingRaw = 8;
				this.hairLength = 4;
				
			}
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 30;
			
			this.createStatusEffect("Genital Slit", 0, 0, 0, 0);
			
			this._isLoading = false;
		}
		
		override public function onLeaveBuyMenu():void
		{
			kGAMECLASS.benoitIntro();
		}
	}
}