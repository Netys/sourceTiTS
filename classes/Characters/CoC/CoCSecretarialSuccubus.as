package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Transformatives.CoCLactaid;
	
	public class CoCSecretarialSuccubus extends Creature
	{
		//constructor
		public function CoCSecretarialSuccubus()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "secretarial succubus";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 4;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 500;
			this.level = 7;
			this.credits = (rand(25) + 10) * 10;
			this.HPMod = 100;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 35 / 20 * this.level;
			this.willpowerRaw = 35 / 20 * this.level;
			this.libidoRaw = 80;
			this.energyRaw = 100;
			this.lustRaw = 30;

			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = rand(9) + 60;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "blond";
			this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 13;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "blue";
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
			this.hipRatingRaw = 10;
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
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [new CoCLactaid()];
			
			_isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(6) == 0 && !target.hasStatusEffect("Kiss Of Death"))
				SuccubusKissAttack(target);
			else if (target.lust() >= target.lustMax() * 0.33)
			{
				if (rand(4) == 0) SuccubusWhipAttack(target);
				else SuccubusSeduceAttack(target);
			}
			else if (target.HP() <= target.HPMax() * 0.66)
			{
				if (rand(3) == 0) SuccubusSeduceAttack(target);
				else SuccubusWhipAttack(target);
			}
			else
			{
				if (rand(3) == 0) SuccubusWhipAttack(target);
				else SuccubusSeduceAttack(target);
			}
		}

		public function SuccubusWhipAttack(target:Creature):void
		{
			if (hasStatusEffect("Whip Ready")) {
				//Blind dodge change
				if (hasStatusEffect("Blind")) { //Blind dodge change
					output("[enemy.name] swings her whip at you wildly, totally missing due to [enemy.hisher] blindness!");
					return;
				}
				output("Grinning deviously, the succubus cracks her whip with expert skill, landing a painful ");
				if (target.shields() > 0) output("(and somehow bypassing your shields) ");
				output("blow on your ");
				
				var temp:int = rand(6);
				var damage:int;
				//Whip yo ass!
				if (temp == 0) {
					output("ass");
					damage = 4;
					if (target.hasArmor() && !target.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
						damage = Math.max(damage - target.armor.defense, 0);
					if (damage == 0) {
						output(" but you feel no pain thanks to your protection!  ");
						applyDamage(new TypeCollection( { tease: 6 + int(target.libido() / 20) } ), this, target, "minimal");
					}
					else applyDamage(new TypeCollection( { tease: 6 + int(target.libido() / 20), unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
				}
				//Whip yo tits!
				if (temp == 1) {
					if (target.breastRows.length > 0 && target.biggestTitSize() > 0) output(target.allBreastsDescript() + "");
					else output("chest");
					
					damage = 9;
					if (target.hasArmor() && !target.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
						damage = Math.max(damage - target.armor.defense, 0);
					if (damage == 0) {
						output(" but you feel no pain thanks to your protection!  ");
						applyDamage(new TypeCollection( { tease: 4 + int(target.libido() / 15) } ), this, target, "minimal");
					}
					else applyDamage(new TypeCollection( { tease: 4 + int(target.libido() / 15), unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
				}
				//Whip yo groin
				if (temp == 2) {
					var groinProtection:int = 0;
					
					//Take armor in account.
					if (target.hasArmor() && !target.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) && target.armor.hasFlag(DamageFlag.PLATED)) {
						groinProtection += target.armor.defense; // plated armors DO have codpiece, right?
					}
					//Wearing armored undergarments? BONUS POINTS!
					if (target.hasLowerGarment() && !target.lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) {
						groinProtection += target.lowerUndergarment.defense;
					}
					if (target.hasStatusEffect("Genital Slit")) // natural defence!
						groinProtection++;
					if (target.hasFullSheaths())
						groinProtection++;
					//Apply damage
					if (groinProtection >= 3) {
						output("groin, but luckily you're wearing groin protection!  ");
						damage = 0;
					}
					else {
						if (!target.hasGenitals()) {
							output("groin!  ");
							damage = 5;
							damage = int(damage / (groinProtection + 1)); 
							applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
						}
						if (target.hasCock() && !target.hasVagina()) {
							output("groin, dealing painful damage to your [pc.cocksLight], doubling you over in agony!  ");
							damage = int((target.maxHP()) / 4);
							if (groinProtection > 0) {
								output("! Of course, it would have been worse if you didn't have groin protection! ");
								damage = int(damage / (groinProtection + 1));
							}
							if (damage < 20) damage = 20;
							target.lust( -15);
							applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
						}
						if (!target.hasCock() && target.hasVagina()) {
							output("groin, making your [pc.vagina] sting with pain");
							damage = 10;
							target.lust( -8);
							applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
						}
						if (target.isHerm()) {
							output("groin, dealing painful damage to your [pc.cocksLight] and [pc.vagina], doubling you over in agony!  ");
							damage = int((target.maxHP()) / 3)
							if (groinProtection > 0) {
								output("! Of course, it would have been worse if you didn't have groin protection");
								damage = int(damage / (groinProtection + 1));
							}
							if (damage < 30) damage = 30;
							target.lust( -20);
							applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
						}
					}
				}
				//Whip yo legs
				if (temp == 3) {
					output("legs!  ");
					damage = 7;
					applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
				}
				//Whip yo arms
				if (temp == 4) {
					output("arms!  ");
					damage = 8;
					applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
				}
				//Whip yo neck
				if (temp == 5) {
					output("neck!  ");
					damage = 24;
					applyDamage(new TypeCollection( { unresistablehp : damage }, DamageFlag.BYPASS_SHIELD ), this, target, "minimal");
				}
			}
			else {
				output("The succubus flicks her wrist, allowing a whip-like cord to slither out from the palm of her clawed hand.  She cracks the whip experimentally, cackling with glee.");
				createStatusEffect("Whip Ready", 0, 0, 0, 0, false, "OffenseUp", "Your enemy is now armed with whip!", true);
				meleeWeapon.baseDamage.kinetic.damageValue += level;
				meleeWeapon.longName = "whip";
				meleeWeapon.attackVerb = "brutal whip-crack";
				meleeWeapon.attackNoun = "whip";
			}
		}

		public function SuccubusKissAttack(target:Creature):void
		{
			//[Kiss of Death Text]
			output("The succubus dances forwards, cocking her elbow back for a vicious strike. ");
			//avoid!
			if (combatMiss(this, target)) {
				output("  You start to sidestep and realize it's a feint.   Ducking low, you slide under her real attack... a kiss?!  ");
				if (target.lust() >= 70) output("  Maybe you shouldn't have bothered to move, it might have been fun.");
			}
			//get hit
			else {
				output("  You start to dodge to the side, but she shifts direction expertly and plants a wet kiss on your lips.  She spins and dodges away with a ballet dancer's grace, leaving you to wonder what just happened.  ");
				if (!target.hasStatusEffect("Kiss Of Death")) target.createStatusEffect("Kiss Of Death", 0, 0, 0, 0, true, "", "", true);
			}
		}

		public function SuccubusSeduceAttack(target:Creature):void
		{
			var temp:int;
			//determine which method of teasing you use
			temp = rand(3);
			//Butt slap!
			if (temp == 0) {
				output(capitalA + short + " slaps her [enemy.butt]");
				if (buttRating() >= 10) {
					output(", making it jiggle delightfully.");
					//85% success rate for the jiggly girls
					if (rand(100) <= 95 + target.libido() - target.willpower()) {
						applyDamage(new TypeCollection( { tease: rand(buttRating()) + 10 } ), this, target, "minimal");
						output("\nThe display is quite arousing.");
					}
					else output("\nYou're unimpressed.\n\n");
				}
				else {
					output(".");
					//50%ish chance of success for the tight butted.
					if (rand(100) <= (70 + buttRating() * 2 + target.libido() - target.willpower())) {
						applyDamage(new TypeCollection( { tease: rand(buttRating()) + 9 } ), this, target, "minimal");
						output("\nThe display is quite arousing.");
					}
					else output("\nYou're unimpressed.\n\n");
				}
			}
			//Jiggly-tits
			if (temp == 1 && breastRows[0].breastRating() >= 2) {
				//rand(breastRating) + breastRows*BreastperRow
				//Single breast row
				if (breastRows.length == 1) {
					//50+ breastsize% success rate
					output(capitalA + short + " caresses some of her ample chest-flesh before shaking it from side to side enticingly.  ");
					if (rand(100) <= (65 + biggestTitSize() + target.libido() - target.willpower())) {
						applyDamage(new TypeCollection( { tease: rand(breastRows[0].breastRating()) + breastRows.length + 10 } ), this, target, "minimal");
						output("\nThe display is quite arousing.  ");
					}
					else output("\nYou're unimpressed.\n\n");
				}
				if (breastRows.length > 1) {
					//50 + 10% per breastRow + breastSize%
					output(capitalA + short + " caresses some of her rows of ample chest-flesh before shaking it all from side to side enticingly.  ");
					if (rand(100) <= (54 + (breastRows.length - 1) * 15 + breastRows[0].breastRating() + target.libido() - target.willpower())) {
						applyDamage(new TypeCollection( { tease: rand(breastRows[0].breastRating()) + breastRows.length * breastRows[0].breasts + 5 } ), this, target, "minimal");
						output("\nThe display is quite arousing.");
					}
					else output("\nYou're unimpressed.\n\n");
				}
			}
			//Genetals flash!
			if (temp == 2) {
				output(capitalA + short + " reaches down and strokes her moist lips.  She sighs and licks her fingers clean, giving you a smoldering gaze.");
				//Success = 50% + 10% times each cock/vagina
				//rand(vaginas*2 + cocks*2) + wetness and/or length/6
				if (rand(101) <= (65 + vaginas.length * 10 + cocks.length * 10 + target.libido() - target.willpower())) {
					applyDamage(new TypeCollection( { tease: rand(vaginas.length * 2 + cocks.length * 2) + 13 } ), this, target, "minimal");
					output("\nThe display is quite arousing.");
				}
				else output("\nYou're unimpressed.\n\n");
			}
		}
	}
}