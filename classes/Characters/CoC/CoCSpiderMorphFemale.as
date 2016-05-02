package classes.Characters.CoC 
{
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.CoCToughSpiderSilk;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.CoCSweetGossamer;
	import classes.kGAMECLASS;
	
	public class CoCSpiderMorphFemale extends CoCSpiderMorph
	{
		public function CoCSpiderMorphFemale() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "female spider-morph";
			this.originalRace = "spider";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The female spider-morph is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The spider-girl is currently eyeing you with a strange expression and her fangs bared.";
			this.customDodge = "";
			this.customBlock = "";
			isUniqueInFight = false;
			btnTargetText = "F.Spider";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "dagger";
			this.meleeWeapon.attackVerb = "stab";
			this.meleeWeapon.attackNoun = "stab";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "exoskeleton";
			this.armor.defense = 14;
			this.armor.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 40.0;
			//baseHPResistances.drug.resistanceValue = 40.0;
			//baseHPResistances.pheromone.resistanceValue = 40.0;
			//baseHPResistances.tease.resistanceValue = 40.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 500;
			this.level = 13;
			this.credits = (rand(10) + 10) * 10;
			this.HPMod = 200;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 60 / 20 * this.level;
			this.reflexesRaw = 99 / 20 * this.level;
			this.aimRaw = 99 / 20 * this.level;
			this.intelligenceRaw = 99 / 20 * this.level;
			this.willpowerRaw = 99 / 20 * this.level;
			this.libidoRaw = 35;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 20;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_ARACHNID;
			this.eyeColor = "black";
			this.tallness = 7 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "black";
			this.furColor = "black";
			this.hairLength = 13;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_CHITIN;
			this.skinTone = "white";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_ARACHNID;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_ARACHNID;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_ARACHNID;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_ARACHNID;
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
			this.hipRatingRaw = 12;
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
			this.buttRatingRaw = 9;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].vaginaColor = "black";
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows[0].breastRatingRaw = 10;
			this.nippleColor = "dusky";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 30;
			
			//this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			var drop:* = kGAMECLASS.WeightedRandom(
						[new CoCSweetGossamer(), new CoCToughSpiderSilk(), null] ,
						[5,                      1,                        4]);
			
			if (drop != null) inventory.push(drop);
			
			this._isLoading = false;
		}
	}
}