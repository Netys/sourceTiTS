package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCWizardRobes;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHarpy extends Creature
	{
		public function CoCHarpy() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "harpy";
			this.originalRace = "harpy";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "talons";
			this.meleeWeapon.attackVerb = "slashing talons";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 30.0;
			//baseHPResistances.drug.resistanceValue = 30.0;
			//baseHPResistances.pheromone.resistanceValue = 30.0;
			//baseHPResistances.tease.resistanceValue = 30.0;
			
			this.armor.longName = "feathers";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 75;
			this.level = 10;
			this.credits = (10 + rand(4)) * 10;
			this.HPMod = 150;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 60 / 20 * this.level;
			this.reflexesRaw = 90 / 20 * this.level;
			this.aimRaw = 90 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 70;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "yellow";
			this.tallness = 6 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
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
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 5;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 2; // B
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			if (rand(10) == 0) inventory.push(new CoCWizardRobes());
			else inventory.push(new CoCGoldenSeed());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("Level") || rand(2) == 0) {
				harpyUberCharge(target);
			}
			else if (rand(4) == 0) harpyTease(target);
			else harpyAttack(target);
		}
		
		public function additionalCombatMenuEntries():void
		{
			if (!hasStatusEffect("Level")) return;
			
			// LIMIT BREAK!
			
			if (kGAMECLASS.pc.canFly()) 
				addButton(0, "Chase", harpyUberChase, null, "Chase", "Fly after her for aerial clash!");
			else {
				kGAMECLASS.userInterface.buttonTray.buttons[0].setDisabled();
				kGAMECLASS.userInterface.buttonTray.buttons[0].func = null;
				kGAMECLASS.userInterface.buttonTray.buttons[0].tooltipBody = "Your enemy is out of reach!";
			}
			
			if (kGAMECLASS.pc.rangedWeapon.baseDamage.hasFlag(DamageFlag.BULLET) || kGAMECLASS.pc.rangedWeapon.baseDamage.hasFlag(DamageFlag.LASER))
				addButton(1, "Snipe", harpyUberSnipe, null, "Snipe", "She made a huge mistake allowing you to take good aim - your weapon is not affected by range as much!");
			
			addButton(8, "Wait", harpyUberWait, null, "Wait", "Take defensive stance and wait.");
		}
		
		protected function harpyUberWait():void
		{
			clearOutput();
			output("Unsure what she is up to, you are assuming defensive stance.");
			addStatusValue("Level", 1, 1);
			CombatManager.processCombat();
		}
		
		// chase is 100% prevented dive, but not much damage
		protected function harpyUberChase():void
		{
			clearOutput();
			output("Using your own [pc.wings] you chase her in air");
			removeStatusEffect("Level");
			if (rand(kGAMECLASS.pc.reflexes()) > rand(reflexes())) {
				output(" and caught her for melee strike!  ");
				applyDamage(kGAMECLASS.pc.meleeDamage(), kGAMECLASS.pc, this);
				output("  Her initiative is lost, and you both are landing for now.  ");
				CombatManager.processCombat();
				
			} else {
				output(", but she is too fast for you to catch. Still, her initiative is lost, and you both are landing for now.\n");
				CombatManager.processCombat();
			}
		}
		
		// snipe is a good chance to break her dive and deal massive damage, but you'll be screwed in case of miss
		protected function harpyUberSnipe():void
		{
			clearOutput();
			output("Taking your time to take a good aim");
			if (!rangedCombatMiss(kGAMECLASS.pc, this, -1, 0.25)) {
				output(", you’ve managed to catch her in her dive, dealing critical damage and making her hit the ground. Ouch!");
				removeStatusEffect("Level");
				var d:TypeCollection = kGAMECLASS.pc.rangedDamage();
				d.multiply(4);
				applyDamage(d, kGAMECLASS.pc, this);
				createStatusEffect("Stunned", 1, 0, 0, 0, false, "Stun", "Cannot take action!", true, 0);
				CombatManager.processCombat();
				
			} else {
				output(" is not helping much when you can’t hit anything smaller than sky itself. You’ve missed!");
				addStatusValue("Level", 1, -1); // and if you missed, you are sooo screwed...
				CombatManager.processCombat();
			}
		}
		
		protected function harpyUberCharge(target:Creature):void
		{
			//(Harpy special attack 1, part one)
			if (!hasStatusEffect("Level")) {
				createStatusEffect("Level", 0, 0, 0, 0, false, "Icon_OffUp", "She is gaining altitude!", true);
				output("Flapping her wings frantically, she flies away from you and gains height, hanging in the light before you.  She lets out a shrill and terrifying cry, narrowing her eyes as she focuses in on you!");
				return;
			}
			
			//(Harpy special attack 1, part two if PC does anything but "Wait")
			var d:TypeCollection = this.meleeDamage();
		
			if(statusEffectv1("Level") == 1) { // waited - half usual attack damage, crash land
				output("You stand firm and ready yourself as the crazed harpy hovers above you. Letting out an ear-splitting cry she dives at you with her claws extended, reaching an incredible speed before she levels out.  The harpy is heading right for you!  Thanks to your ready position, you manage to dive aside just as the harpy reaches you.  She clips you slightly, spinning you as you dive for the ground.  You hit the ground hard, but look up in time to see her make a rough, graceless landing.  Her body rolls until it reached a standstill.  The enraged harpy drags herself up and takes flight once more!  ");
				d.multiply(0.5); 
				applyDamage(d, this, target);
				applyDamage(new TypeCollection( { kinetic : 20 }, DamageFlag.CRUSHING), this, this); // crash landed
			}
			// if tried to snipe you have no chance to avoid, else it is very small
			else if (statusEffectv1("Level") != -1 && combatMiss(this, target, -1, 0.25)) {
				output("The harpy lets out a terrible cry and drops, reaching an almost impossible speed as she dives down at you.  Her eyes are narrowed like a true bird of prey.  Still, your reflexes are perfect - you manage to slide away, taking only glancing blow!  ");
				applyDamage(d, this, target); // usual attack damage
			}
			else { // full damage
				output("You were too busy with your own attack to avoid it!  Her claws surge down and pierce your [pc.gear] like paper, driving hard into the flesh beneath and making you cry out in pain.  The harpy dumps you onto the ground, your wounds bleeding profusely. ");
				d.multiply(4);
				if(statusEffectv1("Level") == -1) d.multiply(1.5); // x6 for faily snipers
				applyDamage(d, this, target);
			}
			removeStatusEffect("Level");
		}

		//(Harpy special attack 2, lust increase)
		protected function harpyTease(target:Creature):void
		{
			output("The harpy charges at you carelessly, her body striking you with the full weight of her motherly hips.  The pair of you go crashing backwards onto the ground.  You grapple with her weighty ass, trying your best not to think dirty thoughts, but the way she's maniacally flapping and writhing her curvy body against you makes it impossible! After a brief, groping wrestle on the ground, she pushes you away and takes flight again.  ");
			applyDamage(new TypeCollection( { tease : 12 + rand(target.libido() / 5) } ), this, target);
		}

		protected function harpyAttack(target:Creature):void
		{
			if (combatMiss(this, target)) {
				output("With another deranged cry the harpy dives at you, swinging her razor-sharp talons through the air with the grace of a ballerina. Your quick reflexes allow you to dodge every vicious slash she makes at you.");
				return;
			}
			
			var d:TypeCollection = this.meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			if (damageResult.totalDamage == 0) {
				output("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.  ");
			} else if(damageResult.hpDamage == 0) {
				output("The harpy surges forward, bringing her razor-sharp claws down on you, but your shild holds!  ");
			} else {
				output("The harpy surges forward, bringing her razor-sharp claws down on you, tearing at all the exposed flesh she can reach!  ");
			}
			outputDamage(damageResult);
		}
	}
}