package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCScimitar;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCPhoenix extends CoCHarpy
	{
		public function CoCPhoenix() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "phoenix";
			this.originalRace = "harpy";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The figure facing you is one of the dangerous hybrids of the Salamander and Harpy races; a Phoenix created by the self proclaimed harpy \"Queen\". Her appearance is close to a normal, crimson-feathered harpy, save for a few noticeable additions. Wings larger than a normal harpy’s sprout from her back, probably to make up for the fact that the usual harpy armwings fade into scaled forearms, an obvious marker of her Salamander parentage. Her lower body is much the same, feather-covered hips and thighs merging with scales around the knee and ending in a clawed lizard foot; not to mention the long, fiery tail that swishes to and from behind her as she circles you. \n\nStanding perhaps six and a half feet tall, her large breasts strain against the tarnished metal of her vest, just as her ample hips threaten to burst free from her tight loincloth. A half-erect lizard cock pokes out pushing the cloth to one side and allowing for a clear view of her slick, puffy pussy just below it. Her scimitar cuts great swaths through the air as she darts through the air above you, taking full advantage of the open space you find yourselves in.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new CoCScimitar();
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 30.0;
			baseHPResistances.drug.resistanceValue = 30.0;
			baseHPResistances.pheromone.resistanceValue = 30.0;
			baseHPResistances.tease.resistanceValue = 30.0;
			
			baseHPResistances.burning.resistanceValue = 75;
			baseHPResistances.freezing.resistanceValue = -50;
			
			this.armor.longName = "chainmail";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 23;
			this.XPRaw = normalXP();
			this.credits = (rand(25) + 160) * 10;
			this.HPMod = 750;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 100 / 20 * this.level;
			this.aimRaw = 100 / 20 * this.level;
			this.intelligenceRaw = 65 / 20 * this.level;
			this.willpowerRaw = 65 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;
			this.personality = 45;
			
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
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [];
			if (rand(20) == 0) inventory.push(new CoCScimitar());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("Uber")) {
				phoenixFireBreath(target);
				return;
			}
			
			var choice:Number = rand(4);
			switch (choice) {
				case 0:
					eAttack(target);
					break;
				case 1:
					doubleSlash(target);
					break;
				case 2:
					phoenixFireBreath(target);
					break;
				case 3:
					lustBang(target);
					break;
				default:
					eAttack(target);
			}
		}
		
		protected function eAttack(target:Creature):void
		{
			CombatAttacks.MeleeAttack(this, target);
		}
		
		protected function doubleSlash(target:Creature):void {
			output("You fall back under a hail of feints and jabs as your enemy darts at you, swinging furiously. The sheer number of blows the phoenix lays against you is incredible, forcing you backwards as you try to deflect the flurry of deadly strikes.  ");
			if (combatMiss(this, target)) {
				output("You are able to parry one of her blows with enough force to push her back, giving you a little more breathing room.");
			}
			else {
				output("Seeing an opening, the phoenix forces her way through your guard with a quick pair of powerful strikes.\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target);
				output("\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target);
			}
		}
		
		public function HandleAction(attackOpts:Object):Boolean
		{
			if (attackOpts.isWait != undefined)
			{
				if (hasStatusEffect("Uber")) addStatusValue("Uber", 1, 1);
			}
			return false;
		}
		
		protected function phoenixFireBreath(target:Creature):void {
			if (!hasStatusEffect("Uber")) {
				output("Suddenly the phoenix disengages from you and loops through the air, giving out a loud cry before she starts to barrel down at you. She’s clearly building up for something, so you’d better wait until she makes her move if you want a chance to dodge!");
				createStatusEffect("Uber");
			}
			else {
				if (statusEffectv1("Uber") > 0) {
					output("You dive to the ground just as the phoenix breathes a great gout of flame at you. The fire blooms over your back, singeing your [pc.gear], but doesn’t harm you. As she swoops low you see the phoenix scowl, looking quite disappointed, but it’s clear she isn’t done yet!");
				}
				//MASSIVE DAMAGE!
				else {
					output("As she zooms over you a great gout of flame erupts from the phoenix’s mouth! You dive out of the way, but all too late. The wall of fire rolls over you as you leap through it, the brief contact with the inferno searing both you and your [pc.gear] badly. ");
					applyDamage(new TypeCollection( { burning : 100 + rand(50) } ), this, target);
				}
				removeStatusEffect("Uber");
			}
		}
		
		protected function lustBang(target:Creature):void {
			output("\"<i>Here, CATCH!</i>\" The phoenix shouts, lobbing a small, circular canister at you before ducking behind her sturdy shield. Oh shit!");
			if (rangedCombatMiss(this, target)) {
				output("Luckily, the metal cylinder bounces off the uneven terrain of the mountain, giving you just enough time to dive away as a huge cloud of pink erupts into the air. The phoenix glances around her shield, face darkening as she sees you readying yourself for another strike instead of writhing on the ground in an oversensitive pile of lust.");
			}
			else if (target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  It immediately explodes in a great pink cloud.  Whatever it was, your sealed armor kept it out. The phoenix glances around her shield, face darkening as she sees you readying yourself for another strike instead of writhing on the ground in an oversensitive pile of lust.");
			}
			else {
				output("You cough and hack, waving your arms to try and dissipate the fog, but by the time the cloud has faded you feel lightheaded and lusty. Your");
				if (target.hasCock()) output("[pc.cocks] quickly engorges, already leaking precum down your [pc.leg]");
				if (target.hasCock() && target.hasVagina()) output("whilst your");
				if (target.hasVagina()) output("thighs are suddenly soaked by a torrent of [pc.girlCum] as your body reacts to the potent chemicals");
				output(".");
				applyDamage(new TypeCollection( { drug : (30 + rand(30)) * target.lustQ() / 100 } ), this, target);
			}
		}
	}
}