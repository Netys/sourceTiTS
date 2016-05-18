package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.clearMenu;
	import classes.Engine.Interfaces.clearOutput;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCPipe;
	import classes.Items.Melee.GooeyPsuedopod;
	import classes.Items.Miscellaneous.CoCGreenGel;
	import classes.kGAMECLASS;
	
	public class CoCGooGirl extends Creature
	{
		//constructor
		public function CoCGooGirl()
		{
			this._latestVersion = 1;
			this.version = this._latestVersion;
			this._neverSerialize = true;
			
			this.short = "goo-girl";
			this.originalRace = "goo";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow.";
			this.customDodge = "The goo twists a portion of its body out of the way of the attack, moving in a way that would be fatal for any vertebrate.";
			this.customBlock = "Your attack sinks into the goo, the wound vanishing almost instantly as her surface recloses.";
			this.meleeWeapon = new GooeyPsuedopod();
			
			this.armor.longName = "gooey skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.level = 3;
			this.XPRaw = normalXP();
			this.credits = (rand(5) + 1) * 10;
			
			this.physiqueRaw = 5;
			this.reflexesRaw = 4;
			this.aimRaw = 4;
			this.intelligenceRaw = 4;
			this.willpowerRaw = 4;
			this.libidoRaw = 50;
			this.HPMod = 40;
			this.shieldsRaw = 0;
			this.HPRaw = this.HPMax();
			this.energyRaw = 100;
			this.lustRaw = 10;
			
			this.personality = 10;
			if (int(kGAMECLASS.flags["COC.FACTORY_SHUTDOWN"]) == 0) this.personality = 40;
			if (int(kGAMECLASS.flags["COC.FACTORY_SHUTDOWN"]) == 2) this.personality = 80;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.kinetic.resistanceValue = 75.0;
			baseHPResistances.electric.resistanceValue = -25.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			baseHPResistances.freezing.resistanceValue = -25.0;
			baseHPResistances.corrosive.resistanceValue = 75.0;
			baseHPResistances.poison.resistanceValue = 90.0;
			baseHPResistances.psionic.resistanceValue = 0.0;
			baseHPResistances.drug.resistanceValue = 0.0;
			baseHPResistances.pheromone.resistanceValue = -20.0;
			baseHPResistances.tease.resistanceValue = -25.0;
			
			this.femininity = 90;
			this.eyeType = 0;
			this.eyeColor = kGAMECLASS.gooGirlColor(5);
			this.tallness = rand(8) + 70;
			this.thickness = 60;
			this.tone = 50;
			this.hairColor = kGAMECLASS.gooGirlColor(2);
		    this.scaleColor = kGAMECLASS.gooGirlColor(6);
			this.furColor = kGAMECLASS.gooGirlColor(7);
			this.hairLength = 12 + rand(10);
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_GOO;
			this.skinTone = kGAMECLASS.gooGirlColor();
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
			this.vaginas[0].vaginaColor = kGAMECLASS.gooGirlColor(4);
			//Goo is hyper friendly!
			this.elasticity = 100;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 14;
			this.nippleColor = kGAMECLASS.gooGirlColor(2);
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 5;
			
			this.impregnationType = "CoCGooGirlPregnancy";
			
			if(kGAMECLASS.pc.biggestTitSize() > 3) {
				breastRows[0].breastRatingRaw = kGAMECLASS.pc.biggestTitSize();
				long += "  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + kGAMECLASS.pc.chestDesc() + ".";
			}
			else {
				breastRows[0].breastRatingRaw = 3;
			}
			
			sexualPreferences.clearPrefs(); // no preferences here
			
			if(rand(2) == 0) // TODO: WETCLTH 1/2
				inventory.push(kGAMECLASS.WeightedRandom(
				[new CoCGreenGel(), new CoCPipe()],
				[5,                 1]));
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", gooStruggle, pc);
				addButton(4, "Do Nothing", gooWait, pc);
				return;
			}
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if(target.hasStatusEffect("Grappled")) {}
			else if (rand(5) == 0) gooEngulph(target);
			else if (rand(3) == 0) gooPlay(target);
			else gooThrow(target);
		}

		public function teaseReactions(damage:Number):String
		{
			if (lustQ() <= 33) return "The goo-girl looks confused by your actions, as if she's trying to understand what you're doing.";
			else if (lustQ() < 66) return "The curious goo has begun stroking herself openly, trying to understand the meaning of your actions by imitating you.";
			else if (lustQ() <= 99) return "The girl begins to understand your intent. She opens and closes her mouth, as if panting, while she works slimy fingers between her thighs and across her jiggling nipples.";
			else return "It appears the goo-girl has gotten lost in her mimicry, squeezing her breasts and jilling her shiny " + skinTone + " clit, her desire to investigate you forgotten.";
		}

		//Play – 
		private function gooPlay(target:Creature):void
		{
			output("The goo-girl lunges, wrapping her slimy arms around your waist in a happy hug, hot muck quivering excitedly against you. She looks up, empty eyes confused by your lack of enthusiasm and forms her mouth into a petulant pout before letting go.  You shiver in the cold air, regretting the loss of her embrace.  ");
			applyDamage(new TypeCollection( { tease : 3 + rand(3) + target.libido() / 10 } ), this, target);
		}
		
		//Throw – 
		private function gooThrow(target:Creature):void
		{
			output("The girl reaches into her torso, pulls a large clump of goo out, and chucks it at you like a child throwing mud. The slime splatters on your chest");
			if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
				output(" and creeps under your [pc.gear], tickling your [pc.skinFurScales] like fingers dancing across your body");
			output(".  ");
			
			applyDamage(new TypeCollection( { kinetic : 1 } ), this, target);
			applyDamage(new TypeCollection( { tease : 5 + rand(3) + target.libido() / 10 } ), this, target);
		}
		
		//Engulf – 
		private function gooEngulph(target:Creature):void
		{
			output("The goo-girl gleefully throws her entire body at you and, before you can get out of the way, she has engulfed you in her oozing form!  ");
			if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
				output("Tendrils of " + skinTone + " slime slide up your nostrils and through your lips, filling your lungs with the girl's muck. You begin suffocating!  ");
			
			target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are engulfed by goo!", true);
		}
		
		private function gooWait(target:Creature):void
		{
			clearOutput();
			clearMenu();
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("You writhe uselessly, trapped inside the goo girl's body. With your sealed armor this situation is clearly stalemate. ");
			}
			else {
				output("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours. ");
				applyDamage(new TypeCollection( { truedamage : .35 * target.maxHP() }, DamageFlag.BYPASS_SHIELD ), this, target);
			}
			CombatManager.processCombat();
		}
		
		private function gooStruggle(target:Creature):void
		{
			clearOutput();
			clearMenu();
			if (rand(3) == 0 || rand(80) < target.physique()) {
				output("You claw your fingers wildly within the slime and manage to brush against her heart-shaped nucleus. The girl silently gasps and loses cohesion, allowing you to pull yourself free while she attempts to solidify.  ");
				target.removeStatusEffect("Grappled");
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("You writhe uselessly, trapped inside the goo girl's body. With your sealed armor this situation is clearly stalemate. ");
			}
			else {
				output("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours. ");
				applyDamage(new TypeCollection( { truedamage : .15 * target.maxHP() }, DamageFlag.BYPASS_SHIELD ), this, target);
			}
			CombatManager.processCombat();
		}
	}
}