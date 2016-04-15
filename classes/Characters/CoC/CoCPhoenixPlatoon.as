package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCPhoenixPlatoon extends CoCHarpy
	{
		public function CoCPhoenixPlatoon() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "phoenix platoon";
			this.originalRace = "harpy";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
			this.customDodge = "";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "scimitars";
			this.meleeWeapon.attackVerb = "slash";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 60.0;
			baseHPResistances.drug.resistanceValue = 60.0;
			baseHPResistances.pheromone.resistanceValue = 60.0;
			baseHPResistances.tease.resistanceValue = 60.0;
			
			this.armor.longName = "feathers";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 2500;
			this.level = 20;
			this.credits = (rand(25) + 160) * 10;
			this.HPMod = 1000;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 70 / 20 * this.level;
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
			this.tallness = rand(8) + 70;
			this.thickness = 50;
			this.tone = 75;
			this.hairColor = "red";
			this.scaleColor = "red";
			this.furColor = "red";
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
			this.legType = GLOBAL.TYPE_LIZAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FEATHERED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_LIZAN;
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
			this.createCock(12);
			this.shiftCock(0, GLOBAL.TYPE_LIZAN);
			this.balls = 0;
			this.ballSizeRaw = 2 * Math.PI;
			this.cumMultiplierRaw = 3;
			this.impregnationType = "CoCOviElixEggs";
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 4; // D
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
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
			
			if (!hasStatusEffect("Platoon")) {
				phoenixPlatoonRush(target);
				createStatusEffect("Platoon");
			}
			else if (statusEffectv1("Platoon") == 0) {
				phoenixPlatoonFireBreath(target);
				addStatusValue("Platoon", 1, 1);
			}
			else {
				phoenixPlatoonLustbang(target);
				removeStatusEffect("Platoon");
			}
		}
		
		//ATTACK ONE: SPARTAN RUSH
		public function phoenixPlatoonRush(target:Creature):void {
			output("You fall back under a hail of scimitar attacks.  The sheer number of phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or maneuver without getting hit!\n");
			//(Effect: Multiple medium-damage attacks)
			//(Effect: Multiple light attacks)
			var attacks:int = 2 + rand(3);
			for (var i:int = 0; i < attacks; i++) 
			{
				output("\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target);
			}
		}

		//ATTACK TWO: FIRE BREATH
		public function phoenixPlatoonFireBreath(target:Creature):void {
			output("Suddenly, the shield wall parts, revealing a single member of the platoon, a particularly muscular girl with a raging erection.  Before you can consider what's going on, she rears back and huffs at you.  To your horror, a great gout of fire erupts from her mouth, rolling towards you.  You dive, but are still caught partially in the inferno.");
			//(Effect: One heavy-damage attack)
			applyDamage(damageRand(new TypeCollection( { burning : 50 } ), 15), this, target);
		}
		
		//ATTACK THREE: LUSTBANG GRENADE
		public function phoenixPlatoonLustbang(target:Creature):void {
			output("\"<i>LUSTBANG OUT!</i>\" one of the rear-most phoenixes shouts, causing all the other warriors to duck down behind their shields.");
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  A large glass sphere rolls out from the shield wall, and immediately explodes in a great pink cloud.  Whatever it was, your sealed armor kept it out.");
				return;
			}
			
			output("  Oh, shit!  A large glass sphere rolls out from the shield wall, and immediately explodes in a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and lusty, barely able to resist the urge to throw yourself at the phoenixes and beg for their cocks and cunts.");
			//(Effect: Large lust increase)
			applyDamage(damageRand(new TypeCollection( { drug : 30 } ), 15), this, target);
		}
	}
}