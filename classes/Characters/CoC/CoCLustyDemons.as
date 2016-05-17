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
	
	public class CoCLustyDemons extends Creature
	{
		public function CoCLustyDemons()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Needs a few things checked.
			this.short = "lusty demons";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You're facing a group of thirty demons of various kinds.  Imps, incubi and succubi of all sizes and colors are encircling you, doing their best to show their genitals or their gigantic rows of breasts, often both.  You can see an impressive number of towering cocks, drooling pussies, and jiggling tits wiggle around as they move.  Most of the genitalia are monstrous, ridiculously disproportionate to the actual demons sporting them - to say nothing of the imps!  Some of the succubi are winking at you, blowing invisible kisses as they dance in circles around your pole.  Among them, you can easily spot the tallest demoness of the horde, Vapula; her perfect purple-skinned body, big perky boobs, luscious buttocks, fleshy lips, and seductive stare draw your attention like a magnet.  She's sporting a pair of magnificent wings and her abundant hair gives her face a fierce, lion-like appearance.  While her eyes ravage you with an insatiable hunger, she gives orders with the assurance of a well-established dominatrix.";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 1;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = 50.0;
			baseHPResistances.drug.damageValue = 25.0;
			baseHPResistances.pheromone.damageValue = 25.0;
			baseHPResistances.psionic.damageValue = 25.0;
			
			this.level = 14;
			this.XPRaw = bossXP();
			this.credits = (150 + rand(100)) * 10;
			this.HPMod = 680;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 10 / 20 * this.level;
			this.aimRaw = 10 / 20 * this.level;
			this.intelligenceRaw = 5 / 20 * this.level;
			this.willpowerRaw = 5 / 20 * this.level;
			this.libidoRaw = 50;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.femininity = 50;
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
			this.createCock();
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			this.cocks[0].cLengthRaw = 18;
			this.cocks[0].cThicknessRatioRaw = 1.75;
			this.cocks[0].cockColor = "red";
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
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity += 10;
			
			this.impregnationType = "CoCImpPregnancy";
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Force It Gender");
			this.createPerk("Multiple Attacks", 5, 0, 0, 0, "");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			inventory = [RandomInCollection(new CoCSucMilk(), new CoCIncubiD(), new CoCOvipositionElixir(), new CoCBookBlack())];
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			if (hasStatusEffect("Sacrifice") && (kGAMECLASS.pc.reflexes() >= 40 || kGAMECLASS.pc.physique() >= 40)) removeStatusEffect("Sacrifice");
			
			if (hasStatusEffect("Sacrifice"))
			{
				addDisabledButton(0, "Attack", "Attack", "You are chained!");
				addDisabledButton(14, "Run", "Run", "You are chained!");
			}
			else if (!kGAMECLASS.pc.canFly()) addDisabledButton(14, "Run", "Run", "You are surrounded!");
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			packAttack(target);
		}
		
		public function teaseReactions(lustDelta:Number):String
		{
			if(lustDelta == 0) return (capitalA + short + " seems unimpressed.");
			else if(lustQ() <= 33) return ("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
			else if(lustQ() <= 66) return ("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
			else return ("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
		}
		
		public function packAttack(target:Creature):void {
			setPerkValue("Multiple Attacks", 1, rand((100 - Math.max(lustQ(), 100 - HPQ())) / 20) + 2);
			CombatAttacks.MeleeAttack(this, target);
			output("\n\n");
			this.meleeWeapon.baseDamage.kinetic.damageValue += 15;
			CombatAttacks.SingleMeleeAttackImpl(this, target, false);
			this.meleeWeapon.baseDamage.kinetic.damageValue -= 15;
		}
	}
}