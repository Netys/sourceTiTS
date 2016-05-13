package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.CoCOvipositionElixir;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCSandTrap extends Creature
	{
		public function CoCSandTrap() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "sandtrap";
			this.originalRace = "sandtrap";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting the sandtrap.  It sits half buried at the bottom of its huge conical pit, only its lean human anatomy on show, leering at you from beneath its shoulder length black hair with its six equally sable eyes.  You cannot say whether its long, soft face with its pointed chin is very pretty or very handsome - every time the creature's face moves, its gender seems to shift.  Its lithe, brown flat-chested body supports four arms, long fingers playing with the rivulets of powder sand surrounding it.  Beneath its belly you occasionally catch glimpses of its insect half: a massive sand-coloured abdomen which anchors it to the desert, with who knows what kind of anatomy.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 10.0;
			//baseHPResistances.drug.resistanceValue = 10.0;
			//baseHPResistances.pheromone.resistanceValue = 10.0;
			baseHPResistances.tease.resistanceValue = 55.0;
			
			this.armor.longName = "chitin";
			this.armor.defense = 10;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 4;
			this.XPRaw = normalXP();
			this.credits = (2 + rand(5)) * 10;
			this.HPMod = 100;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 45 / 20 * this.level;
			this.aimRaw = 45 / 20 * this.level;
			this.intelligenceRaw = 55 / 20 * this.level;
			this.willpowerRaw = 55 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 50;
			
			this.femininity = 50;
			this.eyeType = GLOBAL.TYPE_ARACHNID;
			this.eyeColor = "black";
			this.tallness = rand(8) + 150;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 15;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "fair";
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
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_ARACHNID;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(10);
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 3;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 4;
			this.ballFullness = 1;
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[0].bonusCapacity = 20;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 0;
			
			this.nippleColor = "green";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Force It Gender");
			
			credits = (2 + rand(5)) * 10;
			tallness = rand(8) + 150;
			
			if (rand(3) == 0) fertilizedEggs = 10;
			createStatusEffect("Level", 4, 0, 0, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_MALEBITS,GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_BREASTS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_BUTTS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NARROW_HIPS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_FEMININE,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MASCULINE,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			if (rand(3) == 0) inventory = [new CoCOvipositionElixir()]; 
			else inventory = [new CoCTrapOil()];
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			//[(new PG for PC height levels)PC level 4: 
			if(SandTrapLevel() == 4) output("\n\nYou are right at the edge of its pit.  If you can just manage to keep your footing here, you'll be safe.");
			else if(SandTrapLevel() == 3) output("\n\nThe sand sinking beneath your feet has carried you almost halfway into the creature's pit.");
			else output("\n\nThe dunes tower above you and the hissing of sand fills your ears.  <b>The leering sandtrap is almost on top of you!</b>");
			//no new PG)
			output("\n\nYou could try attacking it with your [pc.meleeWeapon], but that will carry you straight to the bottom.  Alternately, you could try to tease it or hit it at range, or climb and maintain your footing until you can clamber up higher.\n\n");

			if (SandTrapLevel() < 4)
			{
				addButton(12, "Climb", SandTrapClimb, null, "Climb", "Climb the sand to move away from the sand trap.");
				addDisabledButton(14, "Run", "Run", "You're too deeply mired to escape!  You'll have to <b>climb</b> some first!");
			}
			else addDisabledButton(12, "Climb", "Climb", "You already are on the edge of the pit.");
			if(kGAMECLASS.pc.canFly())	addButton(14, "Fly Away", SandTrapRunaway, null, "Fly Away", "Just fly away.");
			
			addButton(0, "Charge", SandTrapMeleeAttack, null, "Charge", "Attack sand trap with a melee strike. Damage is based on physique. <b>You can use your elevation to add some more weight to you attack, but it is all-or-nothing move.</b>");
		}

		public function SandTrapMeleeAttack():void {
			clearOutput();
			clearMenu();
			output("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
			var damage:TypeCollection = kGAMECLASS.pc.meleeDamage();
			trace("Before: " + damage.getTotal());
			damage.add(damage.getTotal() * (SandTrapLevel() - 1));
			trace("After: " + damage.getTotal());
			damageRand(damage, 15);
			applyDamage(damage, kGAMECLASS.pc, this, "melee");
			SandTrapLevel( -4);
			if (this.HP() > 0) addButton(0, "Next", CombatManager.processCombat);
			else CombatManager.processCombat();
		}
				
		public function SandTrapRunaway():void {
			clearOutput();
			if(kGAMECLASS.pc.canFly()) {
				output("You flex the muscles in your back and, shaking clear of the sand, burst into the air!  Wasting no time you fly free of the sandtrap and its treacherous pit.  \"One day your wings will fall off, little ant,\" the snarling voice of the thwarted androgyne carries up to you as you make your escape.  \"And I will be waiting for you when they do!\"");
				CombatManager.abortCombat();
				kGAMECLASS.processTime(10 + rand(10));
			} else if(rand(kGAMECLASS.pc.RQ() + kGAMECLASS.pc.PQ() + rand(25)) > 75) {
				output("You manage to leave the pit.");
				CombatManager.abortCombat();
				kGAMECLASS.processTime(10 + rand(10));
			} else {
				output("You can't get out from the pit!");
				addButton(0, "Next", CombatManager.processCombat);
			}
		}

		//Wait:
		public function SandTrapClimb():void {
			clearOutput();
			clearMenu();
			//game.spriteSelect(97);
			kGAMECLASS.pc.createStatusEffect("Climbed", 0, 0, 0, 0, true, "", "", true);
			//Strength check success: [Player goes up one level, does not go down a level this turn]
			if (kGAMECLASS.pc.canFly()) {
				output("Instead of struggling against crumbling sand walls, you simply fly up to the pit's edge.");
				SandTrapLevel(4);
			}
			else if (kGAMECLASS.pc.PQ() / 10 + rand(20) > 10) {
				output("Instead of attacking, you turn away from the monster and doggedly attempt to climb back up the pit, digging all of your limbs into the soft powder as you climb against the sandslide.");
				output("\n\nSweat beads your forehead - trying to clamber out of this pit is like running against the softest treadmill imaginable.  Nonetheless, through considerable effort you see you've managed to pull further clear of the sandtrap's grasp.  \"<i>Watching you squirm around like that gets me so hot,</i>\" it calls up to you.  Turning around you see that the creature is rubbing its hands all over its lean body whilst watching you struggle.  \"<i>Such an energetic little mating dance, just for me... mmm, prey who do that are always the best!</i>\"");
				SandTrapLevel(2);
				kGAMECLASS.pc.energy( -1);
			}
			else {
				//Strength check fail:  [Player goes down as normal]
				output("Instead of attacking, you turn away from the monster and doggedly attempt to climb back up the pit, digging all of your limbs into the soft powder as you climb against the sandslide.");
				output("\n\nSweat beads your forehead - trying to clamber out of this pit is like running against the softest treadmill imaginable.  You feel like you're going to burst and you eventually give up, noting wearily that you've managed to get nowhere. \"<i>Watching you squirm around like that gets me so hot,</i>\" the sandtrap calls to you.  Turning around you see that the creature is rubbing its hands all over its lean body whilst watching you struggle.  \"<i>Such an energetic little mating dance, just for me... mmm, prey who do that are always the best!</i>\"");
				SandTrapLevel(1);
				kGAMECLASS.pc.energy( -1);
			}
			output("\n\n");
			CombatManager.processCombat();
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//PC sinks a level (end of any turn in which player didn't successfully \"<i>Wait</i>\"):
			if (!target.hasStatusEffect("Climbed")) {
				output("Rivulets of sand run past you as you continue to sink deeper into both the pit and the sand itself.\n\n");
				SandTrapLevel(-1);
			}
			target.removeStatusEffect("Climbed");
			if (SandTrapLevel() <= 1)
			{
				target.lust(target.lustMax(), true); // really, hardcode for custom loss condition from ai?
				return;
			}
			//if (SandTrapLevel() == 4 && findStatusAffect(StatusAffects.Climbed) < 0) nestleQuikSandAttack();
			//else 
			sandTrapPheremones(target);
		}

		public function SandTrapLevel(adjustment:Number = 0):Number {
			if (!this.hasStatusEffect("Level")) this.setStatusValue("Level", 1, 2);
			if (adjustment != 0) {
				this.addStatusValue("Level", 1, adjustment);
				//Keep in bounds ya lummox
				if (this.statusEffectv1("Level") < 1) this.setStatusValue("Level", 1, 1);
				if (this.statusEffectv1("Level") > 4) this.setStatusValue("Level", 1, 4);
			}
			return this.statusEffectv1("Level");
		}


		//sandtrap pheromone attack:
		public function sandTrapPheremones(target:Creature):void {
			//game.spriteSelect(97);
			output("The sandtrap puckers its lips.  For one crazed moment you think it's going to blow you a kiss... but instead it spits clear fluid at you!   You desperately try to avoid it, even as your lower half is mired in sand.");
			if (target.RQ() / 10 + rand(15) > 15 || rangedCombatMiss(this, target)) {
				output("  Moving artfully with the flow rather than against it, you are able to avoid the trap's fluids, which splash harmlessly into the dune.  ");
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  Your sealed armor protects you!  ");
			}
			else {
				output("  Despite ducking away from the jet of fluid as best you can, you cannot avoid some of the stuff splashing upon your arms and face.  The substance feels oddly warm and oily, and though you quickly try to wipe it off it sticks resolutely to your skin and the smell hits your nose.  Your heart begins to beat faster as warmth radiates out from it; you feel languid, light-headed and sensual, eager to be touched and led by the hand to a sandy bed...  Shaking your head, you try to stifle what the foreign pheromones are making you feel.  ");
				applyDamage(new TypeCollection( { pheromone : 10 + target.libido() / 10 } ), this, target);
			}
		}

		//sandtrap quicksand attack:
		//private function nestleQuikSandAttack():void {
			////game.spriteSelect(97);
			//outputText("The sandtrap smiles at you winningly as it thrusts its hands into the sifting granules.  The sand beneath you suddenly seems to lose even more of its density; you're sinking up to your thighs!");
			////Quicksand attack fail:
			//if(player.spe/10 + rand(20) > 10  || player.getEvasionRoll(false)) {
				//outputText("  Acting with alacrity, you manage to haul yourself free of the area affected by the sandtrap's spell, and set yourself anew.");
			//}
			////Quicksand attack success: (Speed and Strength loss, ability to fly free lost)
			//else {
				//outputText("  You can't get free in time and in a panic you realize you are now practically wading in sand.  Attempting to climb free now is going to be very difficult.");
				//if(player.canFly()) outputText("  You try to wrench yourself free by flapping your wings, but it is hopeless.  You are well and truly snared.");
				//SandTrapLevel(-1);
				//if(findStatusAffect(StatusAffects.Climbed) < 0) createStatusAffect(StatusAffects.Climbed,0,0,0,0);
			//}
		//}
	}
}