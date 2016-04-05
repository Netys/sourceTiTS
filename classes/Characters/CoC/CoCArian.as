package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Util.*;
	
	public class CoCArian extends Creature
	{
		public function CoCArian() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Arian";
			this.originalRace = "lizan";
			this.a = "";
			this.capitalA = "";
			this.long = "";
			this.customDodge = "";
			this.customBlock = "";
			
			this.XPRaw = 0;
			this.level = 12;
			this.credits = (rand(10) + 10) * 10;
			this.HPMod = 0;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 10 / 20 * this.level;
			this.reflexesRaw = 10 / 20 * this.level;
			this.aimRaw = 10 / 20 * this.level;
			this.intelligenceRaw = 100 / 20 * this.level;
			this.willpowerRaw = 80 / 20 * this.level;
			this.libidoRaw = 35;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 100; // used mostly in sex scenes, so...
			
			this.femininity = 40;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "auburn";
			this.tallness = 5 * 12 + 6;
			this.thickness = 30;
			this.tone = 25;
			this.hairColor = "white";
			this.scaleColor = "white";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "white";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_LIZAN;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = -2;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = GLOBAL.TYPE_LIZAN;
			this.hornLength = 0;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(6);
			this.shiftCock(0, GLOBAL.TYPE_SNAKE);
			
			this.balls = 0;
			this.ballSizeRaw = 2 * Math.PI;
			this.ballFullness = 100;
			this.cumMultiplierRaw = 3;
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "pink";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.cockVirgin = true;
			this.analVirgin = false;
			this.vaginalVirgin = true;
			
			this.createStatusEffect("Genital Slit", 0, 0, 0, 0);
			
			this._isLoading = false;
		}
		
		public function arianChestAdjective():String {
			var buffer:String = "";
			var temp:int = rand(10);
			if (breastRows[0].breastRating() == 0) return "";
			else if (breastRows[0].breastRating() == 1) {
				if (temp <= 4) buffer += "small";
				else if (temp <= 6) buffer += "petite";
				else if (temp <= 8) buffer += "perky";
				else buffer += "palm-filling";
			}
			else if (breastRows[0].breastRating() < 5) {
				if (temp <= 3) buffer += "generous";
				else if (temp <= 5) buffer += "hand-filling";
				else if (temp <= 7) buffer += "bouncy";
				else buffer += "shapely";
			}
			else {
				if (temp <= 3) buffer += "large";
				else if (temp <= 5) buffer += "voluptuous";
				else if (temp <= 6) buffer += "jiggly";
				else if (temp <= 7) buffer += "bra-bursting";
				else if (temp <= 8) buffer += "bountiful";
				else buffer += "huge";
			}
			return buffer;
		}
		
		public function arianChestNoun():String {
			var buffer:String = "";
			//Men get no cool descriptions!
			if (breastRows[0].breastRating() == 0) return "chest";
			
			//Name 'dose titays
			var temp:int = rand(10);
			if (temp <= 2) buffer += "tits";
			else if (temp <= 5) buffer += "breasts";
			else if (temp <= 7) buffer += "pillows";
			else buffer += "boobs";
			return buffer;
		}
		
		public function arianChest():String {
			return arianChestAdjective() + " " + arianChestNoun();
		}
	}
}