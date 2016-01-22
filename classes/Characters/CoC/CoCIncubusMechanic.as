package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Transformatives.CoCGroPlus;
	import classes.kGAMECLASS;
	
	public class CoCIncubusMechanic extends Creature
	{		
		//constructor
		public function CoCIncubusMechanic()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "incubus mechanic";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 4;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 50.0;
			baseHPResistances.drug.resistanceValue = 50.0;
			baseHPResistances.pheromone.resistanceValue = 50.0;
			baseHPResistances.tease.resistanceValue = 50.0;
			
			this.XPRaw = 750;
			this.level = 8;
			this.credits = (rand(25) + 50) * 10;
			this.HPMod = 150;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 45 / 20 * this.level;
			this.aimRaw = 45 / 20 * this.level;
			this.intelligenceRaw = 85 / 20 * this.level;
			this.willpowerRaw = 85 / 20 * this.level;
			this.libidoRaw = 80;
			this.energyRaw = 100;
			this.lustRaw = 50;

			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = rand(9) + 70;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "black";
			this.scaleColor = "light purple";
			this.furColor = "light purple";
			this.hairLength = 13;
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
			this.legType = GLOBAL.TYPE_DEMONIC;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_DEMONIC;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_SMOOTH,GLOBAL.FLAG_PREHENSILE,GLOBAL.FLAG_LONG];
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
			this.hipRatingRaw = 6;
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
			this.cocks[0].cLengthRaw = 12;
			//balls
			this.balls = 2;
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
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [new CoCGroPlus()];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (lust() > 33 && rand(lustMax()) > lust()) DemonFactoryIncubusSpoogeAttack(target);
			else if (target.isBiped() && rand(4) == 0) DemonFactoryIncubusCockTripAttack(target);
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		public function DemonFactoryIncubusCockTripAttack(target:Creature):void {
			if (hasStatusEffect("Blinded")) { //Blind dodge change
				output(capitalA + short + " suddenly grows it's dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				return;
			}
			output(capitalA + short + " lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your [pc.butt] and pull your [pc.legs] out from under you.");
			if ((target.RQ() - 30) > rand(60)) {
				output("  You spin as you fall, twisting your [pc.legs] free and springing back to your [pc.feet] unharmed.");
			}
			else { //Fall down go boom
				output("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your [pc.legs], smearing them with oozing demonic fluids.");
				if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
				{
					output(" Your sealed armor protects you from soaking! ")
					applyDamage(new TypeCollection( { tease: 3, kinetic: 5 } ), this, target);
					return;
				}
				else if (target.lustQ() >= 80 || target.cor() >= 80) {
					output("  Moaning with desire, you lick your lips as you slide your well-lubricated [pc.legs] free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire.");
					target.cor(1);
					applyDamage(new TypeCollection( { tease: 3, pheromone: 13, kinetic: 5 } ), this, target);
				}
				else if (target.lustQ() >= 50 || target.cor() >= 50) {
					output("  Blushing at the scent and feel of cum on your [pc.legs], you twist and pull free.  You find yourself wondering what this demon's dick would taste like.");
					applyDamage(new TypeCollection( { tease: 3, pheromone: (8 + target.cor() / 20), kinetic: 5 } ), this, target);
				}
				else {
					output("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed [pc.legs].");
					applyDamage(new TypeCollection( { tease: 3, pheromone: (5 + target.cor() / 20), kinetic: 5 } ), this, target);
				}
			}
			output("\n\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.");
		}

		public function DemonFactoryIncubusSpoogeAttack(target:Creature):void {
			lust( -10);
			
			if (hasStatusEffect("Blinded")) { //Blind dodge change
				output(capitalA + short + " pumps and thrusts his hips lewdly before cumming with intense force in your direction!  Thankfully his aim was off due to the blindness currently affect him.");
				return;
			}
			
			output("Your demonic foe places his hands behind his head and lewdly pumps and thrusts his hips at you.  Your eyes open wide as a globule of cum erupts from the demon-prick and flies right at you.  ");
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output("Your sealed armor protects you! ")
				applyDamage(new TypeCollection( { tease: 3 } ), this, target);
				return;
			}
			//if (pc.shield == game.shields.DRGNSHL && rand(2) == 0)
			//{
				//output("Your shield managed to absorb the attack!")
				//combatRoundOver();
				//return;
			//}
			
			output("You do your best to dodge, but some still lands on your ");
			switch (rand(3)) {
				case 0: //Face
					output("face.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your mouth and nose!  You can feel it moving around inside you, doing its best to prepare you for its master.");
						applyDamage(new TypeCollection( { pheromone: 5, tease: 3 } ), this, target, "minimal");
					//if (pc.findStatusAffect(StatusAffects.DemonSeed) < 0)
						//pc.createStatusAffect(StatusAffects.DemonSeed, 5, 0, 0, 0);
					//else pc.addStatusValue(StatusAffects.DemonSeed, 1, 7);
					//pc.slimeFeed();
					break;
				case 1: //Chest
					if (target.hasFuckableNipples()) {
						output("[pc.fullChest].  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.");
						applyDamage(new TypeCollection( { pheromone: 5, tease: 3 } ), this, target, "minimal");
						//if (pc.findStatusAffect(StatusAffects.DemonSeed) < 0)
							//pc.createStatusAffect(StatusAffects.DemonSeed, 5, 0, 0, 0);
						//else pc.addStatusValue(StatusAffects.DemonSeed, 1, 8);
						//pc.slimeFeed();
					}
					else {
						output("[pc.fullChest].  Thankfully it doesn't seem to have much effect.");
						applyDamage(new TypeCollection( { tease: 5 } ), this, target, "minimal");
					}
					break;
				default: //Crotch
					if (target.vaginas.length > 0) {
						output("crotch.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way past your [pc.gear] and into your [pc.vagina].  You can feel it moving around inside you, doing its best to prepare you for its master.");
						applyDamage(new TypeCollection( { pheromone: 5, tease: 3 } ), this, target, "minimal");
						//if (pc.findStatusAffect(StatusAffects.DemonSeed) < 0)
							//pc.createStatusAffect(StatusAffects.DemonSeed, 5, 0, 0, 0);
						//else pc.addStatusValue(StatusAffects.DemonSeed, 1, 8);
						//pc.slimeFeed();
					}
					else {
						output("crotch.  Thankfully, it doesn't seem to have much effect.");
						applyDamage(new TypeCollection( { tease: 3 } ), this, target, "minimal");
					}
			}
		}
	}
}