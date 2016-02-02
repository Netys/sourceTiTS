package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.CoCDragonScale;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCKiha extends Creature
	{
		public function CoCKiha() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Kiha";
			this.originalRace = "dragon?";
			this.a = "";
			this.capitalA = "";
			this.long = "Kiha is standing across from you, holding a double-bladed axe that's nearly as big as she is.  She's six feet tall, and her leathery wings span nearly twelve feet extended.  Her eyes are pure crimson, save for a black slit in the center, and a pair of thick draconic horns sprout from her forehead, arcing over her ruby-colored hair to point behind her.  Dim red scales cover her arms, legs, back, and strong-looking tail, providing what protection they might to large areas of her body.  The few glimpses of exposed skin are dark, almost chocolate in color, broken only by a few stray scales on the underside of her bosom and on her cheekbones.  Her vagina constantly glistens with moisture, regardless of her state of arousal.  Despite her nudity, Kiha stands with the confidence and poise of a trained fighter.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "double-bladed axe";
			this.meleeWeapon.attackVerb = "fiery cleave";
			this.meleeWeapon.attackNoun = "fiery cleave";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 25;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 60.0;
			//baseHPResistances.drug.resistanceValue = 60.0;
			//baseHPResistances.pheromone.resistanceValue = 60.0;
			//baseHPResistances.tease.resistanceValue = 60.0;
			
			this.armor.longName = "thick scales";
			this.armor.defense = 30;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1500;
			this.level = 16;
			this.credits = (rand(15) + 95) * 10;
			this.HPMod = 430;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 85 / 20 * this.level;
			this.aimRaw = 85 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "crimson";
			this.tallness = 6 * 12 + 1;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "red";
			this.scaleColor = "red";
			this.furColor = "none";
			this.hairLength = 3;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "dark";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_DRACONIC;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 2;
			this.hornLength = 12;
			this.hornType = GLOBAL.TYPE_DRACONIC;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.armFlags = [GLOBAL.FLAG_SCALED];
			this.gills = false;
			this.wingType = GLOBAL.TYPE_DRACONIC;
			this.legType = GLOBAL.TYPE_DRACONIC;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_SCALED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_LIZAN;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK, GLOBAL.FLAG_PREHENSILE];
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
			this.buttRatingRaw = 5;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 4;
			
			this.nippleColor = "black";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 40;
			
			//this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			
			if (rand(5) == 0) this.inventory.push(new CoCDragonScale());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if(hasStatusEffect("Blinded")) {
				output("\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.\n\n");
				removeStatusEffect("Blinded");
			}
			
			var select:Number = rand(5);
			if (select <= 1) eAttack(target);
			else if (select == 2) {
				kihaFirePunch(target);
			}
			else if (select == 3) kihaFireBreath(target);
			else kihaTimeWaster(target);
		}
		
		protected function eAttack(target:Creature):void
		{
			if (combatMiss(this, target)) {
				output("You nimbly dodge the Kiha's massive axe!\n");
				return;
			}
			
			var d:TypeCollection = this.meleeDamage();
			d.add(new TypeCollection( { burning : level + rand(6) } ));
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			//No damage
			if(damageResult.hpDamage <= 0) {
				if(damageResult.shieldDamage > 0) output("Kiha connects with her axe! Your shield crackles but holds.  ");
				else output("You block Kiha's fiery cleave.  ");
			}
			//Take Damage
			else output("Kiha charges at you, axe swinging in a high, savage arc.  An afterwash of flames trails behind her blow, immolating you!  ");
			outputDamage(damageResult);
			//output("\n");
		}
		
		private function kihaTimeWaster(target:Creature):void {
			output("She supports the axe on a shoulder, cracking her neck and arching her back to stretch herself, giving you an unintended show.  ");
			applyDamage(new TypeCollection( { tease : 5 } ), this, target);
		}

		private function kihaFirePunch(target:Creature):void {
			output("The draconic girl throws her trusty weapon into the sodden ground, using the distraction to build up balls of flame around her fists.  She runs towards you, launching herself in your direction with a flurry of punches.");

			//Dodged
			if (combatMiss(this, target)) {
				output("You manage to jump to the side, intense heat rushing past you as you narrowly avoid her advance.  You twist around, finding that she's reunited with her axe and angrier than before.");
			}
			//HIT!
			else {
				var d:TypeCollection = new TypeCollection( { kinetic : physique() / 2, burning : level + rand(6) } );
				damageRand(d, 15);
				var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
				
				output("Before you can react, you're struck by the power of her blows");
				if(damageResult.hpDamage <= 0) {
					if(damageResult.shieldDamage > 0) output(". Your shield crackles but holds.  ");
					else output(", but you block Kiha's assault!  ");
				} else
					output(", feeling an intense pain in your chest as each fist makes contact.  With a final thrust, you're pushed backwards onto the ground; the dragoness smiles as she pulls her axe out of the ground, her hands still steaming from the fingertips.  ");
				outputDamage(damageResult);
			}
		}
		
		//Fire breath
		private function kihaFireBreath(target:Creature):void {
			output("Kiha throws her arms back and roars, exhaling a swirling tornado of fire directly at you!  ");
			//Miss:
			if (rangedCombatMiss(this, target)) {
				output("You manage to sidestep the flames in the nick of time; much to the dragoness' displeasure.  ");
			}
			else {
				var d:TypeCollection = new TypeCollection( { burning : 90 + rand(10) } );
				var damageResult:DamageResult = calculateDamage(d, this, target);
				
				if(damageResult.hpDamage <= 0) {
					if(damageResult.shieldDamage > 0) output("Your shield crackles but holds.  ");
					else output("You are fireproof!  ");
				} else
					output("You try to avoid the flames, but you're too slow!  The inferno slams into you, setting you alight!  You drop and roll on the ground, putting out the fires as fast as you can.  As soon as the flames are out, you climb back up, smelling of smoke and soot.  ");
				outputDamage(damageResult);
			}
		}
		
		/*
		Special 2: Kiha lifts her axe overhead and then hurls it at you in a surprising feat of speed and strength. Not keen on getting cleaved in two, you sidestep the jagged metal.
		Hit: But when your attention refocuses on the dragoness, you realize she's right in front of you! She hits you in the face with a vicious straight punch, knocking you on your back.
		Miss: When your gaze returns to the dragoness, you realize she's right in front of you! Luckily your reflexes are good enough that you manage to duck under the incoming punch. By the time you've recovered, Kiha is already standing, battle-ready and axe in hand. (uh, no? in the time it takes the PC to unbend from a simple duck, she's already disentangled herself from close quarters, run over to where the axe landed on the opposite side of him, extracted it from whatever it may be stuck in, and toted it back to the player? do it again with sense; she should be stunned or disarmed for at least a turn if she misses -Z)

		Special 3: Kiha suddenly lets out a roar, swings her axe down and then charges headlong at you!
		Hit: Like a runaway boulder, the dragoness slams into you, brutally propelling you to the ground, jarring bone and leaving you dazed. //Stun effect applies for 2 rounds//
		Miss: You nimbly turn aside and roll her off your shoulder at the last moment, leaving her ploughing on uncontrollably until she (catches her foot in a sinkhole and twists her ankle painfully, faceplanting in the bog)/(slams headfirst into a half-rotten tree with a shower of mouldering splinters). She quickly rights herself and turns to face you, but it clearly took its toll on her. //Kiha takes damage//
		*/
		//override protected function handleFear(target:Creature):Boolean
		//{
			//removeStatusAffect(StatusAffects.Fear);
			//output("Kiha shudders for a moment, then looks your way with a clear head.  \"<i>Fear was the first thing the demons taught us to overcome.  Do you think it would stay my blade?</i>\"\n");
			//return true;
		//}
//
		//override protected function handleBlind():Boolean
		//{
			//return true;
		//}
	}
}