package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCWizardRobes;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCBrigid extends CoCHarpy
	{
		public function CoCBrigid() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Brigid";
			this.originalRace = "harpy";
			this.a = "";
			this.capitalA = "";
			this.long = "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.longName = "poker";
			this.meleeWeapon.attackVerb = "burning stab";
			this.meleeWeapon.attackNoun = "stab";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.baseDamage.burning.damageValue = 5;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 30.0;
			baseHPResistances.drug.resistanceValue = 20.0;
			baseHPResistances.pheromone.resistanceValue = 30.0;
			baseHPResistances.tease.resistanceValue = 60.0;
			
			this.armor.longName = "feathers";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 2000;
			this.level = 19;
			this.credits = (rand(25) + 140) * 10;
			this.HPMod = 1000;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 90 / 20 * this.level;
			this.reflexesRaw = 120 / 20 * this.level;
			this.aimRaw = 120 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 40;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 50;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "yellow";
			this.tallness = 7 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "pink";
			this.scaleColor = "none";
			this.furColor = "blue";
			this.hairLength = 16;
			this.hairType = GLOBAL.HAIR_TYPE_FEATHERS;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FEATHERS;
			this.skinTone = "pink";
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
			this.armType = GLOBAL.TYPE_AVIAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_AVIAN;
			this.legType = GLOBAL.TYPE_AVIAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FEATHERED];
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
			this.hipRatingRaw = 20;
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
			this.buttRatingRaw = 13;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 5;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 2; // B
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (target.hasStatusEffect("Stunned")) {
				target.removeStatusEffect("Stunned");
				if (rand(2) == 0) BrigidAssGrind(target);
				else brigidPoke(target);
				return;
			}
			
			if (rand(3) == 0) BrigidAssGrind(target);
			else if (rand(2) == 0) brigidBop(target);
			else brigidPoke(target);
		}
		
		//Attack One: Hot Poker, Right Up Your Ass!
		private function brigidPoke(target:Creature):void {
			output("Brigid stalks forward with confidence, her shield absorbing your defensive blows until she's right on top of you. She bats your [pc.mainWeapon] aside and thrashes you with her hot poker, scalding your " + target.skin() + " and sending you reeling. ");
			//(Effect: Heavy Damage)
			var damage:TypeCollection = this.meleeDamage();
			damage.multiply(1.5);
			damageRand(damage, 15);
			applyDamage(damage, this, target);
		}
		
		//Attack Two: SHIELD BOP! OOM BOP!
		private function brigidBop(target:Creature):void {
			output("The harpy feints at you with her poker; you dodge the blow");
			if (combatMiss(this, target, 15)) {
				output(", as well as following shield slam. ");
				return;
			}
			output(", but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you off balance. ");
			//(Effect: Stagger/Stun)
			var damage:TypeCollection = this.meleeDamage();
			damage.multiply(0.3);
			damageRand(damage, 15);
			applyDamage(damage, this, target);
			//if (pc.findPerk(PerkLib.Resolute) >= 0) output("  Of course, your resolute posture prevents her from accomplishing much.");
			//else pc.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
		}
		
		//Attack Three: Harpy Ass Grind GO!
		private function BrigidAssGrind(target:Creature):void {
			output("Brigid grins as she approaches you.  She handily deflects a few defensive blows and grabs you by the shoulders.  She forces you onto your knees and before you can blink, has turned around and smashed your face into her ass!  \"<i>Mmm, you like that, don'tcha?</i>\" she growls, grinding her huge, soft ass across your face, giving you an up-close and personal feel of her egg-laying hips. ");
			applyDamage(new TypeCollection( { tease: 15 + target.libido() / 10 + rand(10) } ), this, target, "minimal");
		}
	}
}