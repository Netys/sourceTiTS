package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCFetishCultist extends Creature
	{
		public function CoCFetishCultist() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "fetish cultist";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath. She is wearing a religious outfit that closely hugs her curvacious shape, with a skirt so short that you can clearly see her pussy's lips.\n\nShe has clealy lost her grasp on sanity, and filled the void with pure perversion.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "whip";
			this.meleeWeapon.attackVerb = "whip";
			this.meleeWeapon.attackNoun = "whip";
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = -25.0;
			baseHPResistances.drug.resistanceValue = -25.0;
			baseHPResistances.pheromone.resistanceValue = -25.0;
			baseHPResistances.tease.resistanceValue = -25.0;
			
			this.armor.longName = FETISHY_OUTFIT;
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 75;
			this.level = 2;
			this.credits = (5 + rand(10)) * 10;
			this.HPMod = 20;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 1 / 20 * this.level;
			this.willpowerRaw = 1 / 20 * this.level;
			this.libidoRaw = 75;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 25;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 5 * 12 + 7;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 15;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "pale";
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
			this.gills = false;
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
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].wetnessRaw = 2;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 6; // DD
			
			this.nippleColor = "green";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCLaBova(), new CoCRidingCrop(), new CoCOvipositionElixir(), new CoCLustDraft()] ,
						[1,               1,                   2,                          6]));
			
			this._isLoading = false;
		}

		private static const NAUGHTY_NURSES_UNIFORM:String = "naughty nurse's uniform";
		private static const TEACHERS_OUTFIT:String = "teacher's outfit";
		private static const SWIMSUIT:String = "swimsuit";
		private static const NOBLES_CLOTHING:String = "noble's clothing";
		private static const PERVY_NUNS_CLOTHING:String = "pervy nun's clothing";
		private static const FETISHY_OUTFIT:String = "fetishy outfit";
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			var changed:Boolean = false;
			if (target == null) return;
			
			//Fetish Cultist Update
			switch (rand(5)) {
				case 0:
					if (this.armor.longName != PERVY_NUNS_CLOTHING) {
						//Religious outfit!
						long = "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath.  She is wearing a religious robe that closely hugs her curvacious shape. There is a specially-placed opening over her pussy lips.";
						this.armor.longName = PERVY_NUNS_CLOTHING;
						changed = true;
					}
					break;
				case 1:
					if (this.armor.longName != NOBLES_CLOTHING) {
						//Noble outfit
						this.armor.longName = NOBLES_CLOTHING;
						long = "She's wearing a skimpy noble's dress, which lets you get a good look at her well-filled bra through an over-generous cleavage. Her skirt is so short that you clearly see her pussy lips.  She smiles at you in a rather cute way.  She looks like she's coming out of a painting, executed by a rather depraved and lust-filled artist.";
						changed = true;
					}
					break;
				case 2:
					if (this.armor.longName != SWIMSUIT) {
						//Swim outfit
						long = "She's currently wearing a swimsuit that's apparently much too small for her, because it stretches across every curve and clearly outlines them for you to see.  Her sizable breasts look like they could burst through the fabric at any moment.  You can even see her erect nipples and her puffy lower lips.";
						this.armor.longName = SWIMSUIT;
						changed = true;
					}
					break;
				case 3:
					if (this.armor.longName != TEACHERS_OUTFIT) {
						//Pervy Teacher
						long = "She's now wearing a teacher's outfit, complete with glasses, make-up, her black hair in a tight bun, and a serious-looking outfit... with no back side at all.  She turns to the side to give you a good look at her rear, smiling mischievously.";
						this.armor.longName = TEACHERS_OUTFIT;
						changed = true;
					}
					break;
				case 4:
					if (this.armor.longName != NAUGHTY_NURSES_UNIFORM) {
						//Naughty Nurse
						long = "The woman is wearing heavy make-up and a whorish nurse's suit, seemingly in white latex with two openings at her breasts and a large one on her crotch and inner thighs. It lets her blood-gorged pussy lips hang freely, which she displays proudly.";
						this.armor.longName = NAUGHTY_NURSES_UNIFORM;
						changed = true;
					}
					break;
			}
			
			//Talk abouts it mang!
			if(changed) output("The fetish cultist's clothing shifts and twists, taking on the appearance of a " + this.armor.longName + ".\n\n");
			lust(3);
			
			if (rand(2) == 0) cultistRaisePlayerLust(target);
			else cultistLustTransfer(target);
		}
		
		private function cultistRaisePlayerLust(target:Creature):void {
			//Two text variants!
			if(rand(2) == 0) {
				if(armor.longName == PERVY_NUNS_CLOTHING) output("She suddenly stops chanting and spreads her legs, opening her loose pussy wide with one hand while moaning like a whore.  She toys with her breasts and fondles one of her nipples with her other hand.\n\nDespite yourself,  you can't help but be aroused by the scene.");
				if(armor.longName == NOBLES_CLOTHING) output("She suddenly blushes and start giggling, saying: 'Really my lord!' in a suave, submitting voice while pulling down her skirt.  The movement lets you get an even better look down her cleavage, and her breasts appear even fuller than before.\n\nDespite yourself, you can't help but be aroused by the scene.");
				if(armor.longName == SWIMSUIT) output("She does a series of lewd stretches, showing off her tightly-clad, sexy body in every possible detail.  In particular, her excited, blood-gorged pussy lips, clearly outlined, seem to be begging for you to come and grope them... and that's just for a start.  Despite yourself, you can't help but be aroused by the scene.");
				if(armor.longName == TEACHERS_OUTFIT) output("Obviously very flexible, she arches her back with one hand on her hip, displaying her firm round ass while looking at you with a lascivious expression.  She says in a sexy voice, \"<i>Maybe we should have a... private talk after class...</i>\"  Despite yourself, you can't help but be aroused by the scene.");
				if(armor.longName == NAUGHTY_NURSES_UNIFORM) output("Still displaying her figure in her tight suit, she asks with a lewd smile, \"<i>Is there one of your needs I could satisfy, my dear?</i>\"  She grabs one of her firm, full breasts, \"<i>Are you thirsty, maybe?</i>\"  Despite yourself, you can't help but be aroused by the scene.");
				if(armor.longName == FETISHY_OUTFIT) output("She suddenly starts posing in sexy outfits.  Despite yourself, you can't help but be aroused by it.");
			}
			else {
				output("She suddenly starts mauling her shapely breasts, her fingers nearly disappearing briefly in the soft, full flesh, while fingering herself eagerly, emitting a variety of lewd noises.  You are entranced by the scene, the sexual excitement she's experiencing penetrating your body in warm waves coming from your groin.");
			}
			
			applyDamage(new TypeCollection( { tease : target.libido() / 10 + target.cor() / 20 + 4 } ), this, target);
		}
		
		private function cultistLustTransfer(target:Creature):void {
			if(lust() <= 30 || rand(2) == 0) {
				output("Her eyes glaze over, ");
				if(target.cor() < 40) output("and you're almost afraid to know ");
				else output("and you wish you knew ");
				output("what she is thinking of since you can almost feel her own lust building.  ");
				applyDamage(new TypeCollection( { tease : 10 } ), this, this, "minimal");
			}
			else {
				output("Her eyes glaze over and you feel your mind suddenly becoming filled with a blur of every sexual perversion you could possibly think of, and then some.");
				if(target.vaginas.length > 0) {
					output("  You feel your [pc.vagina] soaking itself in a sudden burst");
					if(target.cockTotal() > 0)  output(", while a sudden influx of pre-cum blurts out and streams down [pc.eachCock], painfully hardened by a vast amount of blood rushing to your groin");
					output(".");
				}
				else if(target.cockTotal() > 0) output("  A sudden influx of pre-cum blurts out and streams down [pc.eachCock], painfully hardened by a vast amount of blood rushing to your groin.");
				else if (!target.hasGenitals()) output("  Your genderless body is suddenly filled by a perverted warmth.  ");
				applyDamage(new TypeCollection( { psionic : (lust() / 3 * (1 + target.cor() / 300)) } ), this, target);
				
				output("\n\nYou notice that the young woman seems to have calmed down some.  ");
				lust( -50);
				if (lust() <= 0) lust(10);
			}
		}
	}
}