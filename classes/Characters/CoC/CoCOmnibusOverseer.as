package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	
	public class CoCOmnibusOverseer extends Creature
	{		
		//constructor
		public function CoCOmnibusOverseer()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Omnibus Overseer";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 15;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 33.0;
			baseHPResistances.drug.resistanceValue = 33.0;
			baseHPResistances.pheromone.resistanceValue = 33.0;
			baseHPResistances.tease.resistanceValue = 33.0;
			
			this.XPRaw = 500;
			this.level = 8;
			this.credits = (rand(25) + 10) * 10;
			this.HPMod = 200;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 45 / 20 * this.level;
			this.aimRaw = 45 / 20 * this.level;
			this.intelligenceRaw = 85 / 20 * this.level;
			this.willpowerRaw = 85 / 20 * this.level;
			this.libidoRaw = 80;
			this.energyRaw = 100;
			this.lustRaw = 20;

			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = rand(9) + 70;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "purple";
			this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 42;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "light purple";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_DEMONIC;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_DEMONIC;
			this.hornLength = 13;
			this.armType = GLOBAL.TYPE_DEMONIC;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_SMALLDEMONIC;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_DEMONIC;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_TAILCOCK,GLOBAL.FLAG_SMOOTH,GLOBAL.FLAG_PREHENSILE,GLOBAL.FLAG_LONG];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 1;
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
			this.buttRatingRaw = 2;
			//No dicks here!
			this.cocks = new Array();
			this.createCock();
			this.cocks[0].cLengthRaw = 10;
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 30;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 2;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 90;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 4182;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			this.createVagina();
			this.vaginas[0].hymen = false;
			this.vaginas[0].clits = 1;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].bonusCapacity = 30;
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			//this.fertility = 0;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 5;
			this.nippleColor = "cerulean";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 2;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			_isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0) DemonFactoryOmnibusLustAura(target);
			else if(rand(3) == 0) DemonFactoryOmnibusMilkAttack(target)
			else CombatAttacks.MeleeAttack(this, target);
		}

		public function DemonFactoryOmnibusLustAura(target:Creature):void {
			output("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (hasStatusEffect("Arousing Aura")) {
				output("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				applyDamage(new TypeCollection( { psionic: (8 + (target.libido() / 20 + target.cor() / 25)) } ), this, target, "minimal");
			}
			else {
				createStatusEffect("Arousing Aura", 0, 0, 0, 0, false, "LustUp", "Demonic aura of lust surrounds her!", true);
			}
		}

		public function DemonFactoryOmnibusMilkAttack(target:Creature):void {
			if (rand(2) == 0)
				output("The demoness grips her sizable breasts and squeezes, spraying milk at you.\n");
			else output("Your foe curls up to pinch her nipples, tugging hard and squirting milk towards you.\n");
			
			if (hasStatusEffect("Blind")) { //Blind dodge change
				output("Thankfully her aim was off due to the blindness currently affect her.");
				return;
			}
			//if ((pc.spe > 50 && rand(4) == 0) || (pc.findPerk(PerkLib.Evade) >= 0 && rand(3) == 0) || (pc.findPerk(PerkLib.Misdirection) >= 0 && rand(4) == 0 && pc.armorName == "red, high-society bodysuit")) {
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output("Your sealed armor protects you! ");
				return;
			}
			if(rangedCombatMiss(this, target, 0)) {
				output("You sidestep the gushing fluids. ");
				return;
			}
			//You didn't dodge
			if (rand(2) == 0) {
				output("The milk splatters across your face and chest, soaking you with demonic cream.  Some managed to get into your mouth, and you swallow without thinking.  It makes you tingle with warmth.  ");
			}
			else {
				output("The milk splashes into your [pc.gear], soaking you effectively.  ");
				if (target.cocks.length > 0) {
					output("Your [pc.cock] gets hard as the milk lubricates and stimulates it.  ");
					applyDamage(new TypeCollection( { pheromone: 5 } ), this, target, "minimal");
				}
				if (target.vaginas.length > 0) {
					output("You rub your thighs together as the milk slides between your pussy lips, stimulating you far more than it should.  ");
					applyDamage(new TypeCollection( { pheromone: 5 } ), this, target, "minimal");
				}
			}
			applyDamage(new TypeCollection( { pheromone: 7 + target.libido() / 20 } ), this, target, "minimal");
			//game.dynStats("lus", 7 + pc.sens / 20);
				if (target.isLactating()) output("Milk dribbles from your [pc.fullChest] in sympathy.");
		}
	}
}