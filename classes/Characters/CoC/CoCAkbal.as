package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCPipe;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	
	
	public class CoCAkbal extends Creature
	{
		//constructor
		public function CoCAkbal()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Akbal";
			this.originalRace = "jaguar";
			this.a = "";
			this.capitalA = "";
			this.long = "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.";
			this.customBlock = "";
			this.customDodge = "Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.";
			this.isPlural = false;
					
			this.meleeWeapon.attackVerb = "claw-slash";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 5;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 35.0;
			baseHPResistances.tease.resistanceValue = 20.0;
			
			this.armor.longName = "shimmering pelt";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 250;
			this.level = 6;
			this.credits = 150;
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 50 / 20 * this.level;
			this.aimRaw = 50 / 20 * this.level;
			this.intelligenceRaw = 75 / 20 * this.level;
			this.willpowerRaw = 75 / 20 * this.level;
			this.libidoRaw = 50;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.HPMod = 20;
			this.HPRaw = this.HPMax();
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_FELINE;
			this.eyeColor = "green";
			this.tallness = 4*12;
			this.thickness = 20;
			this.tone = 90;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "spotted tan";
			this.hairLength = 5;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "black";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_FELINE;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_FELINE;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_FELINE;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_FELINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
			this.armType = GLOBAL.TYPE_FELINE;
			this.armFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_FELINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED];
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
			this.hipRatingRaw = 2;
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
			this.cocks = [];
			this.createCock(15);
			this.shiftCock(GLOBAL.TYPE_FELINE);
			this.cocks[0].delFlag(GLOBAL.FLAG_TAPERED);
			this.cocks[0].addFlag(GLOBAL.FLAG_FLARED);
			this.cocks[0].addFlag(GLOBAL.FLAG_RIBBED);
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 15;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 12;
			this.ballFullness = 1;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.05;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows = [];
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			
			this.nippleColor = "dark";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 2;
			this.ass.loosenessRaw = 1;
			//this.inventory.push();

			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_FEMININE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BUTTS,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_TAILS,			GLOBAL.REALLY_LIKES_SEXPREF);
			//sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		0);
			//sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			//sexualPreferences.setPref(GLOBAL.SEXPREF_EXOTIC_BODYSHAPE,0);
			
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCIncubiD(), new CoCWhiskerFruit(), new CoCPipe(), new CoCAkbalSaliva()] ,
						[4,                3,                     1,             1]));
			
			this._isLoading = false;
		}
		
		public function onCleanup():void {
			kGAMECLASS.pc.removeStatusEffect("Whispered"); // This is not actually requied, legacy check
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(5) == 0)
				CoCAkbalSpecial(target);
			else if (HP() < maxHP() * 0.8 && rand(2) == 0 && lustQ() < 75)
				CoCAkbalHeal(target);
			else if (target.lust() >= target.lustMax() * 0.33)
			{
				if (rand(3) == 0) CoCAkbalAttack(target);
				else CoCAkbalLustAttack(target);
			}
			else if (target.HP() <= target.HPMax() * 0.66)
			{
				if (rand(3) == 0) CoCAkbalLustAttack(target);
				else CoCAkbalAttack(target);
			}
			else
			{
				if (rand(2) == 0) CoCAkbalAttack(target);
				else CoCAkbalLustAttack(target);
			}
		}
		
		public function CoCAkbalAttack(target:Creature):void
		{
			//Chances to miss:
			var damage:Number = 0;
			//Blind dodge change
			if (hasStatusEffect("Blinded"))
				output("Akbal seems to have no problem guiding his attacks towards you, despite his blindness.\n");
				
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("You dodge Akbal's attack with superior quickness!");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			//*Normal Attack A - 
			if (rand(2) == 0) {
				//(medium HP damage)
				//damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				//if (damage <= 0) {
					//output("Akbal lunges forwards but with your toughness", false);
					//if (player.armorDef > 0)
						//output(" and " + player.armorName + ", he fails to deal any damage.", false);
					//else
						//output(" he fails to deal any damage.", false);
				//}
				//else {
					output("Akbal rushes at you, his claws like lightning as they leave four red-hot lines of pain across your stomach.");
					applyDamage(new TypeCollection( { kinetic: 15 + rand(10) } ), this, target);
				//}
			} else { //*Normal Attack B
				//(high HP damage)
				//damage = int((str + 25 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				//if (damage == 0) {
					//output("Akbal lunges forwards but between your toughness ", false);
					//if (player.armorDef > 0)
						//output("and " + player.armorName + ", he fails to deal any damage.", false);
				//}
				//else {
					output("Akbal snarls as he flies towards you, snapping his ivory teeth on your arm. You scream out in pain as you throw him off.");
					//player.takeDamage(damage);
				//}
			}
		}

		public function CoCAkbalLustAttack(target:Creature):void
		{
			//*Lust Attack - 
			if (!target.hasStatusEffect("Whispered"))
			{
				output("You hear whispering in your head. Akbal begins speaking to you as he circles you, telling all the ways he'll dominate you once he beats the fight out of you.  ");
				//(Lust increase)
				applyDamage(new TypeCollection( { psionic : 7 + (100 - target.WQ()) / 10 } ), this, target);
				target.createStatusEffect("Whispered", 0, 0, 0, 0, false, "LustUp", "You hear Akbal's whisper inside yor head!", true);
			}
			//Continuous Lust Attack - 
			else
			{
				output("The whispering in your head grows, many voices of undetermined sex telling you all the things the demon wishes to do to you. You can only blush.  ");
				//(Lust increase)
				applyDamage(new TypeCollection( { psionic : 12 + (100 - target.WQ()) / 10 } ), this, target);
			}
		}

		public function CoCAkbalSpecial(target:Creature):void
		{
			// TODO: ADEQUATE debuff system
			//*Special Attack A - 
			//if (rand(2) == 0 && player.spe > 20)
			//{
				//var speedChange:Number = player.spe / 5 * -1;
				//output("Akbal's eyes fill with light, and a strange sense of fear begins to paralyze your limbs.", false);
				////(Speed decrease)
				//game.dynStats("spe", speedChange);
				//if (player.findStatusAffect(StatusAffects.AkbalSpeed) >= 0)
					//player.addStatusValue(StatusAffects.AkbalSpeed, 1, speedChange);
				//else
					//player.createStatusAffect(StatusAffects.AkbalSpeed, speedChange, 0, 0, 0);
			//}
			////*Special Attack B - 
			//else
			//{
				output("Akbal releases an ear-splitting roar, hurling a torrent of emerald green flames towards you.\n");
				//(high HP damage)
				//Determine if dodged!
				if (rangedCombatMiss(this, target))
				{
					output("You dodge Akbal's fire with superior quickness!  ");
					return;
				}
				output("You are burned badly by the flames!");
				applyDamage(new TypeCollection( { burning : 40 } ), this, target, "minimal");
			//}
		}

		//*Support ability - 
		public function CoCAkbalHeal(target:Creature):void
		{
			if (HP() >= maxHP())
				output("Akbal licks himself, ignoring you for now.");
			else
			{
				output("Akbal licks one of his wounds, and you scowl as the injury quickly heals itself.");
				HP(30);
				lust(10);
			}
		}
	}
}