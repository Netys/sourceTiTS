package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Util.*;
	
	public class CoCChameleonGirl extends Creature
	{
		public function CoCChameleonGirl() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			var colors:Array = RandomInCollection(SKIN_VARIATIONS);
			
			this.short = "chameleon";
			this.originalRace = "chameleon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You're faced with a tall lizard-like girl with smooth " + colors[0] + " skin and long, " + colors[1] + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 30;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon.attack = 10;
			this.rangedWeapon.longName = "tongue";
			this.rangedWeapon.attackVerb = "tongue-slap";
			this.rangedWeapon.attackNoun = "tongue-slap";
			this.rangedWeapon.baseDamage.kinetic.damageValue = 10;
			this.rangedWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 65.0;
			//baseHPResistances.drug.resistanceValue = 65.0;
			//baseHPResistances.pheromone.resistanceValue = 65.0;
			//baseHPResistances.tease.resistanceValue = 65.0;
			
			baseHPResistances.burning.resistanceValue = 75;
			baseHPResistances.freezing.resistanceValue = -50;
			
			this.armor.longName = "skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.level = 14;
			this.XPRaw = normalXP();
			this.credits = (10 + rand(50)) * 10;
			this.HPMod = 350;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 95 / 20 * this.level;
			this.aimRaw = 95 / 20 * this.level;
			this.intelligenceRaw = 85 / 20 * this.level;
			this.willpowerRaw = 85 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 50;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "red";
			this.tallness = 68;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "black";
			this.scaleColor = colors[1];
			this.furColor = "none";
			this.hairLength = 13;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = colors[0];
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_LIZAN;
			this.hornLength = 4;
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
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 85;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 12;
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 85;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BUTTS,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_MALEBITS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MASCULINE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		/**
		 * Pairs of skinTone/skinAdj
		 */
		private const SKIN_VARIATIONS:Array = [
			["red", "black"],
			["green", "yellowish"],
			["blue", "lighter blue"],
			["purple", "bright yellow"],
			["orange", "brown"],
			["tan", "white"]
		];
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			RandomInCollection(rollKickClawWhatTheFuckComboIsThisShit, chameleonTongueAttack, chameleonClaws)(target);
		}
		
		public function chameleonTongueAttack(target:Creature):void
		{
			var hit:Boolean = rangedCombatMiss(this, target);
			
			if (!hit)
			{
				if(rand(2)==0) output("The chameleon girl lashes out with her tongue, but you deflect the sticky projectile off your arm, successfully defending against it.  She doesn't look happy about it when she slurps the muscle back into her mouth.");
				else output("The chameleon girl whips her head and sends her tongue flying at you, but you hop to the side and manage to avoid it.  The pink blur flies back into her mouth as quickly as it came at you, and she looks more than a bit angry that she didn't find her target.");
			}
			else
			{
				output("The chameleon whips her head forward and sends her tongue flying at you.  It catches you in the gut, the incredible force behind it staggering you.  The pink blur flies back into her mouth as quickly as it came at you, and she laughs mockingly as you recover your footing.");
				applyDamage(this.rangedDamage().rand(), this, target, "ranged");
			}
		}
		
		public function chameleonClaws(target:Creature):void
		{
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 1) {
				output(capitalA + short + " completely misses you with a blind claw-attack!");
			}
			//Evade:
			else if (combatMiss(this, target)) output("The chameleon girl's claws slash towards you, but you lean away from them and they fly by in a harmless blur.");
			//Get hit
			else {
				output("The chameleon swings her arm at you, catching you with her claws.  You wince as they scratch your skin, leaving thin cuts in their wake.");
				applyDamage(this.meleeDamage().rand(), this, target, "melee");
			}
		}
		
		//Attack 3:
		public function rollKickClawWhatTheFuckComboIsThisShit(target:Creature):void
		{
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 1) {
				output(capitalA + short + " completely misses you with a blind roll-kick!");
			}
			//Evade:
			else if (combatMiss(this, target)) {
				output("The chameleon girl leaps in your direction, rolls, and kicks at you.  You sidestep her flying charge and give her a push from below to ensure she lands face-first in the bog. ");
				applyDamage(new TypeCollection( { truedamage : 1 + rand(10) } ), this, this);
			}
			//Get hit
			else {
				output("The chameleon leaps in your direction, rolls, and kicks you square in the shoulder as she ascends, sending you reeling.  You grunt in pain as a set of sharp claws rake across your chest. ");
				applyDamage(this.meleeDamage().multiply(1.25).rand(), this, target, "melee");
			}
		}
	}
}