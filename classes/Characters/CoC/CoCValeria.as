package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.clearMenu;
	import classes.Engine.Interfaces.clearOutput;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCClaymore;
	import classes.Items.Melee.CoCPipe;
	import classes.Items.Melee.GooeyPsuedopod;
	import classes.Items.Miscellaneous.CoCGreenGel;
	import classes.kGAMECLASS;
	
	public class CoCValeria extends Creature
	{
		//constructor
		public function CoCValeria()
		{
			this._latestVersion = 1;
			this.version = this._latestVersion;
			this._neverSerialize = true;
			
			this.short = kGAMECLASS.flags["COC.MET_VALERIA"] == undefined ? "Goo Armor" : "Valeria";
			this.originalRace = "goo";
			this.a = kGAMECLASS.flags["COC.MET_VALERIA"] == undefined ? "a " : "";
			this.capitalA = kGAMECLASS.flags["COC.MET_VALERIA"] == undefined ? "A " : "";
			
			this.long = "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.";
			this.customDodge = "The goo twists a portion of its body out of the way of the attack, moving in a way that would be fatal for any vertebrate.";
			this.customBlock = "Your attack sinks into the goo, the wound vanishing almost instantly as her surface recloses.";
			this.meleeWeapon = new CoCClaymore();
			
			this.armor.longName = "gooey skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.kinetic.resistanceValue = 85.0;
			baseHPResistances.electric.resistanceValue = -25.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			baseHPResistances.freezing.resistanceValue = -75.0;
			baseHPResistances.corrosive.resistanceValue = 60.0;
			baseHPResistances.poison.resistanceValue = 90.0;
			baseHPResistances.psionic.resistanceValue = 0.0;
			baseHPResistances.drug.resistanceValue = 0.0;
			baseHPResistances.pheromone.resistanceValue = -20.0;
			baseHPResistances.tease.resistanceValue = -25.0;
			
			this.level = 16;
			this.XPRaw = normalXP();
			this.credits = (rand(25) + 160) * 10;
			this.HPMod = 500;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 60 / 20 * this.level;
			this.reflexesRaw = 50 / 20 * this.level;
			this.aimRaw = 50 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 50;
			
			this.femininity = 90;
			this.eyeType = 0;
			this.eyeColor = "blue";
			this.tallness = rand(8) + 70;
			this.thickness = 60;
			this.tone = 50;
			this.hairColor = "blue";
		    this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 12 + rand(10);
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_GOO;
			this.skinTone = "blue";
			this.skinFlags = [GLOBAL.FLAG_SQUISHY, GLOBAL.FLAG_LUBRICATED, GLOBAL.FLAG_AMORPHOUS];
			this.faceType = 0;
			this.faceFlags = new Array();
			this.tongueType = 0;
			this.lipMod = 1;
			this.earType = 0;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_GOOEY;
			this.legCount = 1;
			this.legFlags = [GLOBAL.FLAG_AMORPHOUS];
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
			this.hipRatingRaw = 15;
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
			this.buttRatingRaw = 10;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 50;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 24;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 400;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 5674;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			this.createVagina();
			this.vaginas[0].hymen = false;
			this.vaginas[0].clits = 1;
			this.vaginas[0].wetnessRaw = 5;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].bonusCapacity = 10;
			this.vaginas[0].vaginaColor = "blue";
			//Goo is hyper friendly!
			this.elasticity = 100;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 3;
			this.nippleColor = "blue";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 5;
			
			sexualPreferences.clearPrefs(); // no preferences here
			
			inventory = [];
			
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(2) == 0 && !target.hasStatusEffect("Grappled")) gooSilenceAttack(target);
			else if (rand(3) > 0) gooArmorAttackPhysical(target);
			else gooArmorAttackTwoGooConsume(target);
		}
		
		//ATTACK ONE: Greatsword
		public function gooArmorAttackPhysical(target:Creature):void {
			if (combatMiss(this, target)) {
				output("The goo-armor rushes forward and swings her sword in a mighty arc, but you evade the attack!");
			}
			//HIT!
			else {
				output("The goo-armor rushes forward and swings her sword in a mighty arc.  You aren't quite quick enough to dodge her blow, and the goopy sword slams into you, throwing you back and leaving a nasty welt. ");
				applyDamage(damageRand(this.meleeDamage(), 15), this, target);
			}
		}
		
		//ATTACK TWO: Goo Consume
		public function gooArmorAttackTwoGooConsume(target:Creature):void {
			output("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you.  You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest.  More and more goo latches onto you - you'll have to fight to get out of this.");
			
			target.createStatusEffect("Grappled", 5, 0, 0, 0, false, "Icon_Constricted", "You are engulfed by goo!", true);
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", struggleAtGooBind, pc);
				//addButton(4, "Do Nothing", gooWait, pc);
				return;
			}
		}
		
		//(Struggle)
		public function struggleAtGooBind(target:Creature):void {
			clearOutput();
			//If fail:
			if (rand(10) > 0 && target.physique() / 3 + rand(20) < 23) {
				output("You try and get out of the goo's grasp, but every bit of goop you pull off you seems to be replaced by twice as much!");
				//(If fail 5 times, go to defeat scene)
				target.addStatusValue("Grappled", 2, 1);
				if (target.statusEffectv2("Grappled") >= 5) {
					//if (findStatusEffect(StatusEffects.Spar) >= 0) game.valeria.pcWinsValeriaSparDefeat();
					//else 
					kGAMECLASS.gooArmorBeatsUpPC();
					return;
				}
			}
			//If succeed: 
			else {
				output("You finally pull the goop off of you and dive out of her reach before the goo-girl can re-attach herself to you.  Pouting, she refills her suit of armor and reassumes her fighting stance.");
				target.removeStatusEffect("Grappled");
			}
			CombatManager.processCombat();
		}
		
		//ATTACK THREE: Goo Silence
		public function gooSilenceAttack(target:Creature):void {
			//(No spells until PC passes a moderate STR check or burns it away)
			output("The goo pulls a hand off her greatsword and shoots her left wrist out towards you.");
			
			if (rangedCombatMiss(this, target, 15)) {
				output("  You lean back and let bit of goop pass harmlessly overhead, avoiding the attack.");
			}
			else if (target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  You recoil as a bit of goop slaps on your mask.");
			}
			else {
				output("  You recoil as a bit of goop slaps onto your mouth, preventing you from speaking - looks like you're silenced until you can pull it off!");
				target.createStatusEffect("Silence", 3, 0, 0, 0, false, "Icon_Silence", "You can't talk with all that sticky goo slapped on yor face!", true, 0);
			}
		}
	}
}