package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCLivingStatue extends Creature
	{
		public function CoCLivingStatue() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "living statue";
			this.originalRace = "Automaton";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "This animate marble statue shows numerous signs of wear and tear, but remains as strong and stable as the day it was carved. Its pearly, white skin is pockmarked in places from age, yet the alabaster muscles seem to move with almost liquid grace. You get the impression that the statue was hewn in the days before the demons, then brought to life shortly after. It bears a complete lack of genitalia - an immaculately carved leaf is all that occupies its loins. It wields a hammer carved from the same material as the rest of it.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.isLustImmune = true;
			
			this.meleeWeapon.longName = "stone greathammer";
			this.meleeWeapon.attackVerb = "smash";
			this.meleeWeapon.attackNoun = "smash";
			this.meleeWeapon.hasRandomProperties = true;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.CRUSHING);
			
			this.armor.longName = "cracked stone";
			this.armor.defense = 10;
			baseHPResistances.kinetic.resistanceValue = 0.0;
			baseHPResistances.electric.resistanceValue = 0.0;
			baseHPResistances.poison.resistanceValue = 100.0;
			baseHPResistances.corrosive.resistanceValue = 100.0;
			baseHPResistances.burning.resistanceValue = 100.0;
			baseHPResistances.freezing.resistanceValue = -50.0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 5000;
			this.level = 22;
			this.credits = 0;
			this.HPMod = 1000;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 25 / 20 * this.level;
			this.aimRaw = 25 / 20 * this.level;
			this.intelligenceRaw = 50 / 20 * this.level;
			this.willpowerRaw = 50 / 20 * this.level;
			this.libidoRaw = 0;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 0;
			this.personality = 100;
			
			this.femininity = 0;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "marble";
			this.tallness = 30 * 12;
			this.thickness = 100;
			this.tone = 100;
			this.hairColor = "marble";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 50;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "marble";
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
			this.vaginas = []
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "marble";
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (this.HPQ() < 70 && !this.hasStatusEffect("KnockBack"))
			{
				this.backhand();
			}
			else if (this.HPQ() < 40 && !this.hasStatusEffect("DisarmUsed") && target.hasWeapon())
			{
				this.disarm();
			}
			else
			{
				var opts:Array = [];
				
				if (!target.hasStatusEffect("Blinded")) opts.push(dirtKick);
				if (!target.hasStatusEffect("Stunned")) opts.push(concussiveBlow);
				opts.push(cycloneStrike);
				opts.push(cycloneStrike);
				opts.push(overhandSmash);
				
				opts[rand(opts.length)]();
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Knocked Back")) {
				addButton(0, "Engage", function():*{
					clearOutput();
					output("You close the distance between you and " + a + short + " as quickly as possible.\n\n");
					pc.removeStatusEffect("Knocked Back");
					CombatManager.processCombat();
				});
			}
		}
		
		private function concussiveBlow():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			//Maybe replace this with passive stun? TERRIBLE IDEA
			output("The giant raises his hammer for an obvious downward strike. His marble muscles flex as he swings it downward. You're able to hop out of the way of the clearly telegraphed attack, but nothing could prepare you for the shockwave it emits as it craters the ground. ");
			
			if (this.hasStatusEffect("ConcussiveBlow") && pc.canFly() && combatMiss(this, pc, -10, 2)) {
				output("Ready this time, you use your [pc.wings] to stay airborne while shockwave quakes the ground! ");
				return;
			}
			//Stun success
			if (rand(2) == 0 && !pc.hasStatusEffect("Stunned"))
			{
				output("<b>The vibrations leave you rattled and stunned. It'll take you a moment to recover!</b> ");
				pc.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
			}
			else
			//Fail
			{
				output("You shake off the vibrations immediately. It'll take more than that to stop you! ");
			}
			
			//Light magic-type damage!
			applyDamage(new TypeCollection( { kinetic : 25 * intelligence() / pc.intelligence() }, DamageFlag.EXPLOSIVE ), this, pc);
			this.createStatusEffect("ConcussiveBlow", 0, 0, 0, 0); // Applying to mob as a "used ability" marker
		}
		
		private function dirtKick():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The animated sculpture brings its right foot around, dragging it through the gardens at a high enough speed to tear a half score of bushes out by the root. A cloud of shrubbery and dirt washes over you!");
			
			if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output(" Your armor keeps it out of your eyes!");
			}
			//blind
			if (rand(2) == 0 && !pc.hasStatusEffect("Blinded"))
			{
				pc.createStatusEffect("Blinded", 2, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
				output(" <b>You are blinded!</b>");
			}
			else
			{
				//Not blind
				output(" You close your eyes until it passes and resume the fight!");
			}
		}
		
		private function backhand():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//Knocks you away and forces you to spend a turn running back to do melee attacks.
			output("The marble golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			
			//Dodge
			if (combatMiss(this, pc)) output(" You slide underneath the surprise swing!");
			else
			{
				//Get hit
				output(" It chits you square in the chest. The momentum sends you flying through the air. You land with a crunch against a wall. <b>You'll have to run back to the giant to engage it in melee once more.</b> ");
				
				pc.createStatusEffect("Knocked Back", 0, 0, 0, 0, false, "Icon_Blocked", "You'll have to run back to the giant to engage it in melee once more.", true, 0, 0xFF0000);
				applyDamage(new TypeCollection( { kinetic : physique() / 2 }, DamageFlag.CRUSHING ), this, pc);
			}
			this.createStatusEffect("KnockBack", 0, 0, 0, 0); // Applying to mob as a "used ability" marker
		}
		
		private function overhandSmash():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//High damage, lowish accuracy.
			output("Raising its hammer high overhead, the giant swiftly brings its hammer down in a punishing strike!");
			
			if (rand(100) < 25 || combatMiss(this, pc, -10, 2)) output(" You're able to sidestep it just in time.");
			else
			{
				//Hit
				output(" The concussive strike impacts you with bonecrushing force. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1.5);
				applyDamage(damage, this, pc);
			}
		}
		
		private function disarm():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The animated statue spins its hammer around, striking at your [pc.mainWeapon] with its haft.");
	
			//Avoid
			if (combatMiss(this, pc)) output(" You manage to hold onto your equipment, for now.");
			//Oh noes!
			else
			{
				output(" Your equipment flies off into the bushes! You'll have to fight another way. ");
				pc.createStatusEffect("Disarmed", 3, 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", true, 0, 0xFF0000);
			}
			this.createStatusEffect("DisarmUsed", 0, 0, 0, 0);
		}
		
		private function cycloneStrike():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//Difficult to avoid, moderate damage.
			output("Twisting back, the giant abruptly launches into a circular spin. Its hammer stays low enough to the ground that its circular path is tearing a swath of destruction through the once pristine garden, and it's coming in your direction!");
			
			//Avoid
			if (combatMiss(this, pc)) output(" By the grace of the gods, you somehow avoid the spinning hammer.");
			else
			{
				//Hit
				output(" You're squarely struck by the spinning hammer. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(0.75);
				applyDamage(damage, this, pc);
			}
		}
	}
}