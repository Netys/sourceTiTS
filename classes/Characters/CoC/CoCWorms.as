package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCJeweledRapier;
	import classes.Items.Miscellaneous.*;
	import classes.kGAMECLASS;
	
	
	public class CoCWorms extends Creature
	{			
		//constructor
		public function CoCWorms()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "worms";
			this.originalRace = "worms";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.";
			this.customDodge = "";
			this.customBlock = "";
			
			isLustImmune = true;
			
			this.meleeWeapon.attackVerb = "slap";
			this.meleeWeapon.attackNoun = "slap";
			this.meleeWeapon.longName = "worm";
			
			this.armor.longName = "skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.burning.resistanceValue = -75.0;
			baseHPResistances.freezing.resistanceValue = -50.0;
			baseHPResistances.electric.resistanceValue = -50.0;
			baseHPResistances.kinetic.resistanceValue = 75.0;
			baseHPResistances.poison.resistanceValue = 100.0;
			
			this.level = 3;
			this.XPRaw = normalXP();
			this.credits = 0;
			this.HPMod = 40;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 10 / 20 * this.level;
			this.aimRaw = 10 / 20 * this.level;
			this.intelligenceRaw = 1 / 20 * this.level;
			this.willpowerRaw = 100 / 20 * this.level;
			this.libidoRaw = 90;
			this.energyRaw = 100;
			this.lustRaw = 0;
			this.personality = 100;

			this.femininity = 5;
			this.eyeType = 0;
			this.eyeColor = "red";
			this.tallness = 120;
			this.thickness = 50;
			this.tone = 50;
			this.hairColor = "none";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = 0;
			this.skinTone = "purple";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 2;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = 0;
			this.legCount = 0;
			this.legFlags = new Array();
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
			this.hipRatingRaw = 0;
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
			this.buttRatingRaw = 0;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 0;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 0;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 0;
			this.ballFullness = 0;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 0;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 0;
			this.minutesSinceCum = 9999;
			this.timesCum = 0;
			this.cockVirgin = true;
			this.vaginalVirgin = true;
			this.analVirgin = true;
			this.vaginas = new Array();
			this.cocks = new Array();
			//Goo is hyper friendly!
			this.elasticity = 0;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 0;
			this.clitLength = 0;
			this.pregnancyMultiplierRaw = 0;
			
			this.createStatusEffect("Infertile");
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "black";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 0;
			this.ass.bonusCapacity = 0;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//Worms have different AI
			if (rand(2) == 0)
				wormAttack(target);
			else wormsEntice(target);
		}
		
		public function wormAttack(target:Creature):void {
			//Dodged!
			if (combatMiss(this, target)) {
				output("The worm colony flails at you with its simulated arms, but its lack of coordination allows you to easily dodge its attack.");
				return;
			}
			output("The worm colony strikes at you with its makeshift limbs. It strikes you and the limb splatters, dispersing the worms comprising the false arm.");
			applyDamage(meleeDamage().rand(), this, target, "melee");
		}
		
		public function wormsEntice(target:Creature):void {
			//FAIL
			if (rand(2) == 0 || target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				if (target.lustQ() < 50) output("The worm colony stands before you and begins secreting a significant amount of slime. You are perplexed as to why the worms have done this. You shrug your shoulders and remain on guard.\n");
				else output("The worm colony shambles over to you and attempts to grapple you. Quickly sidestepping the clumsy movements of the creature, you avoid what could have been a horrible fate as the mass falls over and splatters in its failed attempt to engulf you.\n");
				return;
			}
			
			//SUCCESS
			if (target.lustQ() < 50) {
				output("The worm colony stands before you and begins secreting a significant amount of slime. Inexplicably, you find your [pc.cocks] already erect and is throbbing. The erection is quite meddlesome and you find yourself distracted by the unwanted arousal.");
				applyDamage(new TypeCollection( { pheromones : 10 + target.libido() / 20 + target.cor() / 20 } ), this, target);
			}
			else {
				output("The worm colony shambles over to you and attempts to grapple you. Attempting to dodge, you fail to get away fast enough and fall to the ground engulfed by the mass. You are completely covered in the slimy worms!!! Incapable of avoiding any of their movements, you feel their slime coat every inch of your body and you feel the struggle and strain of each individual worm as they crawl all over you. You immediately begin flailing wildly as you cannot even breathe!");
				//Chance of insta-loss if infested twice
				if (hasStatusEffect("InfestAttempted")) {
					output("  Struggle as you might, the creatures overwhelm your body and prevent you from any conceivable opportunity to get them off you, Your head quickly becomes visible, allowing you to breathe as you stare helplessly at the cocoon of worms trapping you.");
					target.lust(target.lustMax(), true);
					return;
				}
				//Escaped!
				else {
					output("\n\nYou struggle wildly as you fight the worm colony for both air and to get the things off you. The sticky slime secreted by the individual worms greatly increases your task. After freeing one of your arms, you uncover your face, allowing you to breathe, and begin sweeping the beasts from your body. Stunned by your renewed vigor, the mass loses its cohesion, allowing your to quickly clear the worms from your body. The disbanded colony retreats a distance from you and begins reforming itself as you purge your body of the annelids.");
					createStatusEffect("InfestAttempted", 0, 0, 0, 0);
				}
			}
		}
	}
}
