package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.TITSSaveEdit.Data.CoCTypeDefs;
	
	public class CoCAnemone extends Creature
	{
		public function CoCAnemone() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "anemone";
			this.originalRace = "anemone";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 5;
			this.meleeWeapon.longName = "tendrils";
			this.meleeWeapon.attackVerb = "tentacle";
			this.meleeWeapon.attackNoun = "tentacle";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "clammy skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 20;
			this.level = 4;
			this.credits = (rand(5) + 1) * 10;
			this.HPMod = 120;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 40 / 20 * this.level;
			this.reflexesRaw = 40 / 20 * this.level;
			this.aimRaw = 40 / 20 * this.level;
			this.intelligenceRaw = 50 / 20 * this.level;
			this.willpowerRaw = 50 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;			
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "dark blue";
			this.tallness = 5 * 12 + 5;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "purplish-black";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 20;
			this.hairType = GLOBAL.TYPE_ANEMONE;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "purple";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = true;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_HUMAN;
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
			this.hipRatingRaw = CoCTypeDefs.HIP_RATING_CURVY;
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
			this.buttRatingRaw = CoCTypeDefs.BUTT_RATING_NOTICEABLE;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(7);
			this.shiftCock(0, GLOBAL.TYPE_ANEMONE);
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 3;
			this.vaginas[0].bonusCapacity = 5;
			
			this.breastRows[0].breastRatingRaw = 2; // B
			this.nippleColor = "dark blue";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.createStatusEffect("Disarm Immune");
			
			this.impregnationType = "CoCAnemonePregnancy";
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [new CoCDryTent()];
			
			this._isLoading = false;
		}

		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			output("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.");
			output(" You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.  ");
			
			var str:Number = rand(4 + target.libido() / 20) + 1;
			//First application
			if (!target.hasStatusEffect("Anemone Venom")) target.createStatusEffect("Anemone Venom", 0, 0, 0, 0, false, "LustUp", "Anemone venom is arousing you!");
			//Gain some lust
			//pc.lust(2 * str);
			
			applyDamage(new TypeCollection( { drug: 2 } ), this, target);

			//Loop through applying 1 point of venom at a time.
			while (str > 0) {
				str--;
				// Need some SAFE method to temporary alter stats.
				////Str bottommed out, convert to lust
				//if (pc.physiqueRaw < 2) pc.lust(2);
				////Lose a point of str.
				//else {
					//pc.physiqueRaw--;
					//pc.addStatusValue("Anemone Venom", 1, 1);
				//}
				////Spe bottomed out, convert to lust
				//if (pc.reflexesRaw < 2) pc.lust(2);
				////Lose a point of spe.
				//else {
					//pc.reflexesRaw--;
					//pc.addStatusValue("Anemone Venom", 2, 1);
				//}
				
				//Str bottommed out, convert to lust
				if (target.physiqueRaw < target.statusEffectv1("Anemone Venom")) applyDamage(new TypeCollection( { drug: 2 } ), this, target);
				//Lose a point of str.
				else {
					target.addStatusValue("Anemone Venom", 1, 1);
				}
				//Spe bottomed out, convert to lust
				if (target.reflexesRaw < target.statusEffectv2("Anemone Venom")) applyDamage(new TypeCollection( { drug: 2 } ), this, target);
				//Lose a point of spe.
				else {
					target.addStatusValue("Anemone Venom", 2, 1);
				}
			}
		 }		
	}
}