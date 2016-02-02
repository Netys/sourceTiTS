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
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Armor.CoCChainmailBikini;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCScimitar;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHel extends Creature
	{
		public function CoCHel() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "salamander";
			this.originalRace = "salamander";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "curved sword";
			this.meleeWeapon.attackVerb = "slashing blade";
			this.meleeWeapon.attackNoun = "slashing blade";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 20;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 65.0;
			//baseHPResistances.drug.resistanceValue = 65.0;
			//baseHPResistances.pheromone.resistanceValue = 65.0;
			//baseHPResistances.tease.resistanceValue = 65.0;
			
			this.armor.longName = "scales";
			this.armor.defense = 14;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1500;
			this.level = 16;
			this.credits = (10 + rand(5)) * 10;
			this.HPMod = 275;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 65;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "red";
			this.tallness = 90;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "red";
			this.scaleColor = "dusky";
			this.furColor = "none";
			this.hairLength = 13;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "dusky";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
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
			this.hipRatingRaw = 12;
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
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 85;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 12;
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 85;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BUTTS,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_MALEBITS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MASCULINE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			if (kGAMECLASS.flags["COC.HEL_TALKED_ABOUT_HER"] == 1) {
				this.a = "";
				this.capitalA = "";
				this.short = "Hel";
			} else {
				this.a = "the ";
				this.capitalA = "The ";
				this.short = "salamander";
			}
					
			if (rand(20) == 0) inventory.push(new CoCChainmailBikini());
			else if (rand(20) == 0) inventory.push(new CoCScimitar());
			else if (rand(10) < 7) inventory.push(new CoCReptilum());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			RandomInCollection(helAttack, helAttack2, helCleavage)(target);
		}
		
		private function helAttack(target:Creature):void {
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 1) {
				output(capitalA + short + " completely misses you with a blind attack!\n");
			}
			//Determine if dodged!
			else if (combatMiss(this, target)) {
				output("You nimbly dodge the salamander's massive sword thrust!\n");
			}
			//Determine damage - str modified by enemy toughness!
			else
			{
				var d:TypeCollection = this.meleeDamage();
				damageRand(d, 15);
				var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
				
				//No damage
				if(damageResult.hpDamage <= 0) {
					//Due to toughness or amor...
					if(damageResult.shieldDamage > 0) output("The salamander connects with her sword! Your shield crackles but holds.  ");
					else output("You deflect and block every slash " + a + short + " throws at you.  ");
				}
				//Take Damage
				else
					output("The salamander lunges at you, sword swinging in a high, savage arc.  You attempt to duck her attack, but she suddenly spins about mid-swing, bringing the sword around on a completely different path.  It bites deep into your flesh, sending you stumbling back. ");
				outputDamage(damageResult);
			}
			output("\n");
		}

		//Attack 2 – Tail Slap (Hit)
		//low dodge chance, lower damage
		private function helAttack2(target:Creature):void {
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 1) {
				output(capitalA + short + " completely misses you with a blind attack!\n");
				return;
			}
			//Determine if dodged!
			else if (combatMiss(this, target, -1, 0.5)) { // half chance to avoid
				output("The salamander rushes at you, knocking aside your defensive feint and trying to close the distance between you.  She lashes out at your feet with her tail, and you're only just able to dodge the surprise attack.");
				return;
			}
			var d:TypeCollection = this.meleeDamage();
			d.add(-1 * d.getTotal() / 2); // half damage
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			//No damage
			if(damageResult.hpDamage <= 0) {
				//Due to toughness or amor...
				if(damageResult.shieldDamage > 0) output("The salamander's tail-swipe hits you! Your shield crackles but holds.  ");
				else output("The salamander's tail-swipe hits you but fails to move or damage you.  ");
			}
			//Take Damage
			else output("The salamander rushes at you, knocking aside your defensive feint and sliding in past your guard.  She lashes out at your feet with her tail, and you can feel the heated wake of the fiery appendage on your ensuing fall toward the now-smouldering grass.  ");
			
			outputDamage(damageResult);
			output("\n");
		}

		private function helCleavage(target:Creature):void {
			//FAIL
			if(combatMiss(this, target, -1, 1.33)) {
				output("To your surprise, the salamander suddenly pulls up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms reaches around your waist, and the other toward your head, but you roll away from her grip and push her bodily away.  She staggers a moment, but then quickly yanks the jangling bikini top back down with a glare.\n");
			}
			//Attack 3 – Lust – Cleavage (Failure)
			else {
				output("To your surprise, the salamander suddenly yanks up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms encircles your waist, and the other forcefully shoves your face into her cleavage.  She jiggles her tits around your face for a moment before you're able to break free, though you can feel a distinct heat rising in your loins.  As quickly as they were revealed, the breasts are concealed again and your opponent is ready for more combat!  ");
				applyDamage(new TypeCollection( { tease : 20 + rand(10) + target.libido() / 10 + rand(target.libido() / 20) } ), this, target);
			}
		}
	}
}