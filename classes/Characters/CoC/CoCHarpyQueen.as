package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCEldritchStaff;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHarpyQueen extends CoCHarpy
	{
		public function CoCHarpyQueen() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Harpy Queen";
			this.originalRace = "harpy";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new CoCEldritchStaff();
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 40.0;
			baseHPResistances.drug.resistanceValue = 20.0;
			baseHPResistances.pheromone.resistanceValue = 20.0;
			baseHPResistances.tease.resistanceValue = 60.0;
			
			this.armor.longName = "armor";
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
			this.tallness = 6 * 12 + 6;
			this.thickness = 60;
			this.tone = 20;
			this.hairColor = "blue";
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
			this.hipRatingRaw = 25;
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
			this.buttRatingRaw = 20;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 5;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 150;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 4; // D
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 60;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [new CoCEldritchStaff()];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(4) == 0) eldritchRopes(target);
			else if (rand(2) == 0) lustSpikeAttack(target);
			else windSlamAttack(target);
		}
		
		//ATTACK ONE: ELDRITCH ROPES
		public function eldritchRopes(target:Creature):void {
			output("The Harpy Queen flicks her left wrist at you. Before you can blink, ropes of white-hot magic hurtle toward you. You manage to duck and dodge a few of them, but a pair still grab your wrists, pulling painfully at your arms.");
			//(Effect: Grab + Physical Damage)
			target.createStatusEffect("Grappled", 4, 0, 0, 0, false, "Icon_Constricted", "You are entangled by magical ropes!", true);
			applyDamage(new TypeCollection( { kinetic : 25 + rand(10) }, DamageFlag.CRUSHING ), this, target);
		}
		
		public override function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", ropeStruggles, false);
				addButton(4, "Do Nothing", ropeStruggles, true);
				return;
			}
		}
		
		public function ropeStruggles(wait:Boolean = false):void {
			clearOutput();
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//Struggle Fail: 
			if (rand(10) > 0 && pc.physique() / 3 + rand(20) < 23 || wait) {
				output("You give a mighty try, but cannot pull free of the magic ropes!  The Harpy Queen laughs uproariously, pulling at your arms harder.");
				applyDamage(new TypeCollection( { kinetic : 25 + rand(10) }, DamageFlag.CRUSHING ), this, pc);
			}
			else {
				output("With supreme effort, you pull free of the magic ropes, causing the queen to tumble to her hands and knees.");
				pc.removeStatusEffect("Grappled");
			}
			CombatManager.processCombat();
		}
		
		//ATTACK TWO: LUST SPIKE
		public function lustSpikeAttack(target:Creature):void {
			output("The Harpy Queen draws a strange arcane circle in the air, lines of magic remaining wherever the tip of her staff goes.  You try to rush her, but the circle seems to have created some kind of barrier around her.  You can only try to force it open - but too late!  A great pink bolt shoots out of the circle, slamming into your chest.  You suddenly feel light-headed and so very, very horny...");
			//(Effect: Heavy Lust Damage)
			applyDamage(damageRand(new TypeCollection( { psionic : 30 } ), 15), this, target);
		}
		
		//ATTACK THREE: Wind Slam!
		public function windSlamAttack(target:Creature):void {
			output("The queen swings her arm at you and, despite being a few feet away, you feel a kinetic wall slam into you, and you go flying - right into the harpy brood!  You feel claws, teeth and talons dig into you, but you're saved by a familiar pair of scaled arms.  \"<i>Get back in there!</i>\" Helia shouts, throwing you back into the battle!");
			//(Effect; Heavy Damage)
			applyDamage(damageRand(new TypeCollection( { kinetic : 60 } ), 15), this, target);
		}
	}
}