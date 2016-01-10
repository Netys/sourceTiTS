package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCMinotaurAxe;
	import classes.Items.Miscellaneous.CoCMinotaurCum;
	import classes.Items.Transformatives.CoCMinotaurBlood;
	import classes.kGAMECLASS;
	
	public class CoCMinotaur extends Creature
	{
		//constructor
		public function CoCMinotaur()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "minotaur";
			this.originalRace = "minotaur";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "An angry-looking minotaur looms over you.  Covered in shaggy [monster.furColor] fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "thick fur";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.resistanceValue = 15.0;
			
			//ballz - here 'coz they are minotaur's true main stat
			this.balls = 2;
			this.ballSizeRaw = 2 + rand(13);
			
			this.XPRaw = 250;
			this.level = 4;
			this.credits = 0;
			this.HPMod = 20 + rand(this.ballSize()*2);
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 20 / 20 * this.level;
			this.willpowerRaw = 20 / 20 * this.level;
			this.libidoRaw = 50;
			this.energyRaw = 100;
			this.lustRaw = 30;

			this.femininity = 15;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = rand(37) + 84;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "brown";
			this.scaleColor = "";
			this.furColor = "brown";
			this.hairLength = 3;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "light brown";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_BOVINE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_BOVINE;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_BOVINE;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_BOVINE;
			this.hornLength = 13;
			this.armType = GLOBAL.TYPE_BOVINE;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_BOVINE;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_BOVINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG];
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
			this.hipRatingRaw = 4;
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
			this.buttRatingRaw = 4;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(rand(13) + 24);
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			this.cumMultiplierRaw = 1.5;
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
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "brown";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 4;
			this.ass.loosenessRaw = 6;
			this.ass.bonusCapacity = 30;
			
			this.createStatusEffect("Disarm Immune");
			
			if (rand(3) == 0) meleeWeapon = new CoCMinotaurAxe();
						
			ballSizeRaw = 2 + rand(13);
			minutesSinceCum = ballSize() * 600;
			HPMod = 40 + rand(ballSize() * 5);
			
			tallness = rand(37) + 84;
			lust(ballSize() * 3, true);
			libido(40 + ballSize() * 2, true);
			
			if (hasMeleeWeapon()) physique(physique() * 1.5, true);
			level = hasMeleeWeapon() ? 6 : 5;
			credits = (rand(5) + 5) * 10;
			
			HPRaw = HPMax();
			
			long = "An angry-looking minotaur looms over you.  Covered in shaggy [enemy.furColor] fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature." +
					(ballSize() > 4 ? "  Barely visible below the tattered shreds of loincloth are [enemy.balls], swollen with the minotaur's long pent-up need." : "") +	
					(hasMeleeWeapon() ? "  <b>This minotaur seems to have found a deadly looking [enemy.meleeWeapon] somewhere!</b>" : "");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			if (rand(5) == 0) inventory.push(new CoCMinotaurCum());
			else inventory.push(new CoCMinotaurBlood());
			
			_isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0) CoCMinotaurPheromones(target);
			else CombatAttacks.MeleeAttack(this, target);
		}

		public function CoCMinotaurPheromones(target:Creature):void {
			//spriteSelect(44);
			output("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air, ");
			//sometimes get hit with the pre for stronger effect!
			if (rangedCombatMiss(this, target))
				output("right past your head.  ");
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) // always wear your hazmat suit when working with drugs!
			{
				output("splattering hatmlessly over your airtight armor. ")
				applyDamage(new TypeCollection( { tease: 1 + target.libido() / 25 } ), this, target, "minimal");
			}
			else {
				output("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				
				if(target.LQ() > 75) {
					output("swallowing it into your mouth without thinking.  ");
					applyDamage(new TypeCollection( { pheromone: 5 + target.libido() / 20, drug : 5 + target.libido() / 20 } ), this, target);
				}
				else {
					output("feeling your heart beat with desire as your tongue licks the residue from your lips.  ");
					applyDamage(new TypeCollection( { pheromone: 2.5 + target.libido() / 40, drug : 2.5 + target.libido() / 40 } ), this, target);
				}
			}
			
			if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
			{
				output("\n\nThe animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.");
				applyDamage(new TypeCollection( { pheromone : 10 + target.libido() / 20 } ), this, target);
			}
			
			if(target.hasPerk("Minotaur Cum Addict") || flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] == 2) {
				if(rand(2) == 0) output("\n\n<b>You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.</b>");
				else output("\n\n<b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>");
				applyDamage(new TypeCollection( { drug : 5 + rand(5) } ), this, target);
			}
		}
	}
}