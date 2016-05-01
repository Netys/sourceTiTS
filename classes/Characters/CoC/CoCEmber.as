package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
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
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.CoCDragonScale;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCEmber extends Creature
	{
		public function CoCEmber() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Ember";
			this.originalRace = "dragon";
			this.a = "";
			this.capitalA = "";
			this.long = "OVERRIDE";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.attackVerb = "slash";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 25;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 50.0;
			baseHPResistances.drug.resistanceValue = 50.0;
			baseHPResistances.pheromone.resistanceValue = 50.0;
			baseHPResistances.tease.resistanceValue = 50.0;
			
			baseHPResistances.burning.resistanceValue = 75;
			baseHPResistances.freezing.resistanceValue = -50;
			
			this.armor.longName = "thick scales";
			this.armor.defense = 30;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1500;
			this.level = 15 + Math.round(int(kGAMECLASS.flags["COC.EMBER_AFFECTION"]) / 20);
			this.credits = 0;
			this.HPMod = 550 + (int(kGAMECLASS.flags["COC.EMBER_AFFECTION"]) * 2);
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 75 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 75 / 20 * this.level;
			this.willpowerRaw = 75 / 20 * this.level;
			this.libidoRaw = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = int(kGAMECLASS.flags["COC.EMBER_COR"]);
			
			var roundface:Boolean = (int(kGAMECLASS.flags["COC.EMBER_ROUNDFACE"]) > 0)
			
			this.femininity = 50;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "orange";
			this.tallness = 7 * 12 + 3;
			this.thickness = 50;
			this.tone = 80;
			this.hairColor = "red";
			this.scaleColor = "red";
			this.furColor = "none";
			this.hairLength = (roundface ? 12 : 0) + int(kGAMECLASS.flags["COC.EMBER_HAIR"]) * 8;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = roundface ? GLOBAL.SKIN_TYPE_SKIN : GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "dark";
			this.skinFlags = new Array();
			this.faceType = roundface ? GLOBAL.TYPE_HUMAN : GLOBAL.TYPE_DRACONIC;
			this.faceFlags = roundface ? [] : [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_DRACONIC;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = roundface ? GLOBAL.TYPE_HUMAN : GLOBAL.TYPE_DRACONIC;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 4;
			this.hornLength = 12;
			this.hornType = GLOBAL.TYPE_DRACONIC;
			this.armType = GLOBAL.TYPE_DRACONIC;
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
			this.tailType = GLOBAL.TYPE_DRACONIC;
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
			this.cocks = [];
			this.vaginas = [];
			this.breastRows = [];
			this.createBreastRow();
			
			var gender:int = int(kGAMECLASS.flags["COC.EMBER_GENDER"]);
			if (gender == 1 || gender == 3) {
				this.createCock(16);
				if (int(kGAMECLASS.flags["COC.EMBER_INTERNAL_DICK"]) != 0 || roundface) this.shiftCock(0, GLOBAL.TYPE_DRACONIC);
				else {
					this.cocks[0].addFlag(GLOBAL.FLAG_KNOTTED);
					this.cocks[0].knotMultiplier = 1.25;
				}
				this.balls = 2;
				this.ballSizeRaw = 4 * Math.PI;
				this.cumMultiplierRaw = 3;
			}
			if (gender >= 2) {
				this.createVagina();
				this.vaginas[0].loosenessRaw = 3;
				this.vaginas[0].wetnessRaw = 4;
				this.vaginas[0].hymen = int(kGAMECLASS.flags["COC.EMBER_PUSSY_FUCK_COUNT"]) == 0;
				this.vaginalVirgin = this.vaginas[0].hymen;
				this.breastRows[0].breastRatingRaw = 11;
				this.femininity = 80;
			} else {
				this.breastRows[0].breastRatingRaw = 0;
				this.femininity = 20;
			}
			
			this.nippleColor = "pink";
			if (int(kGAMECLASS.flags["COC.EMBER_MILK"] > 0)) {
				this.milkFullness = 80;
				this.milkMultiplier = 80;
			}
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 40;
			
			if (int(kGAMECLASS.flags["COC.EMBER_OVIPOSITION"]) > 0) this.createPerk("Oviposition");
			this.createStatusEffect("Disarm Immune");
			if (int(kGAMECLASS.flags["COC.EMBER_INTERNAL_DICK"]) > 0 || !roundface) this.createStatusEffect("Genital Slit");
			
			if (rand(5) == 0) this.inventory.push(new CoCDragonScale());
			
			this._isLoading = false;
		}
		
		override public function get long():String 
		{
			return "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + mf("he", "she") + " lashes " + mf("his", "her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
		}
		
		override public function set long(value:String):void 
		{
			super.long = value;
		}
		
		override public function analCapacity():Number 
		{
			return kGAMECLASS.cockVolume(60);
		}
		
		override public function vaginalCapacity(arg:int = 0):Number 
		{
			return kGAMECLASS.cockVolume(60);
		}
		
		override public function isPregnant(slot:int = -1):Boolean 
		{
			return kGAMECLASS.flags["COC.EMBER_INCUBATION"] != undefined;
		}
		
		public function postHostileTurnActions():Boolean {
			if (lust() >= 40) {
				kGAMECLASS.emberReactsToLustiness();
				return true;
			}
			return false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("StunCooldown")) {
				addStatusValue("StunCooldown", 1, -1);
				if (statusEffectv1("StunCooldown") <= 0) removeStatusEffect("StunCooldown");
			}
			
			else if (rand(4) == 0) {
				dragonFarce(target);
				return;
			}
			
			if (rand(6) == 0) embersSupahSpecialDragonBreath(target);
			else if (rand(3) == 0) emberTailSlap(target);
			else emberAttack(target);
		}
		
		//The Actual Ember Fight (Z)
		//PC can't use any sexual moves in this battle. This means anything that deals or affects Ember's lust in any way.
		//It doesn't make sense to affect Ember's lust due to the nature of the combat, however it IS possible and encouraged to use lust moves when fighting Bimbo or Corrupt Ember.
		
		//Ember Attacks:
		private function emberAttack(target:Creature):void {
			//Basic attack, average damage, average accuracy
			output("With a growl, the dragon lashes out in a ferocious splay-fingered slash, "+ mf("his","her") + " claws poised to rip into your flesh.  ");
			//Miss/dodge
			if (combatMiss(this, target)) 
			{
				output("You dodge aside at the last second and Ember's claws whistle past you.");
			}
			else if (hasStatusEffect("Blinded") && rand(3) > 0) 
			{
				output("Ember's blind attack fail to connect!");
			}
			var damageResult:DamageResult = calculateDamage(meleeDamage().rand(), this, target, "melee");
			
			if (damageResult.shieldDamage > 0)
			{
				if (target.shieldsRaw > 0) output(" Your shield crackles but holds.");
				else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached.");
			}
			
			if (damageResult.hpDamage > 0)
				output("Ember's claws rip into you, leaving stinging wounds. ");
			
			outputDamage(damageResult);
		}
		
		//Dragon Breath: Very rare attack, very high damage
		private function embersSupahSpecialDragonBreath(target:Creature):void {
			if (hasStatusEffect("Blinded") && rand(2) == 0) {
				//Blind Ember: 
				output("The blinded dragon tracks you with difficulty as you sprint around the landscape; seeing an opportunity, you strafe around " + mf("his", "her") + " side, planting yourself behind a large flat boulder near " + mf("him", "her") + " and pelting " + mf("him", "her") + " with a small rock.  The scream as the dragon turns the magical conflagration toward you, only to have it hit the rock and blow up in " + mf("his", "her") + " face, is quite satisfying.");
				//(Ember HP damage)
				applyDamage(new TypeCollection( { burning: 25, kinetic : 25 }, DamageFlag.EXPLOSIVE ).rand(), this, this, "minimal");
			}
			else {
				output("Ember inhales deeply, then " + mf("his", "her") + " jaws open up, releasing streams of fire, ice and lightning; magical rather than physical, the gaudy displays lose cohesion and amalgamate into a column of raw energy as they fly at you.");
				if (rangedCombatMiss(this, target)) output("  It's a narrow thing, but you manage to throw yourself aside at the last moment.  Fortunately, the energy whirling around and tearing up the soil blinds Ember to your escape until you have recovered and are ready to keep fighting.");
				else {
					var damageResult:DamageResult = calculateDamage(new TypeCollection( { burning: 75, kinetic : 75 }, DamageFlag.EXPLOSIVE ).rand(), this, target);
					
					if (damageResult.shieldDamage > 0)
					{
						if (target.shieldsRaw > 0) output(" Your shield crackles but holds.");
						else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached.");
					}
					
					if (damageResult.hpDamage > 0)
						output("  The pain as the deadly combination washes over you is indescribable.  It's a miracle that you endure it, and even Ember looks amazed to see you still standing. ");
					
					outputDamage(damageResult);
				}
			}
		}
		
		//Tailslap: Rare attack, high damage, low accuracy
		private function emberTailSlap(target:Creature):void {
			//Blind dodge change
			if (hasStatusEffect("Blinded")) {
				output("Ember completely misses you with a blind tail-slap!");
				return;
			}
			output("Ember suddenly spins on "+ mf("his","her") + " heel, the long tail that splays behind " + mf("him","her") + " lashing out like a whip.  As it hurtles through the air towards you, your attention focuses on the set of spikes suddenly protruding from its tip!");
			if (combatMiss(this, target) || rand(2) == 0) {
				output("  You ");
				if (rand(2) == 0) output("duck under");
				else output("leap over");
				output(" the tail at the last moment, causing Ember to lose control of "+ mf("his","her") + " own momentum and stumble.");
			}
			else {
				var damageResult:DamageResult = calculateDamage(meleeDamage().multiply(2).rand(), this, target, "melee");
				
				if (damageResult.shieldDamage > 0)
				{
					if (target.shieldsRaw > 0) output(" Your shield crackles but holds.");
					else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached.");
				}
				
				if (damageResult.hpDamage > 0)
					output("  The tail slams into you with bone-cracking force, knocking you heavily to the ground even as the spines jab you wickedly.  You gasp for breath in pain and shock, but manage to struggle to your [pc.feet] again. ");
				
				outputDamage(damageResult);
			}
		}
		
		//Dragon Force: Tainted Ember only
		private function dragonFarce(target:Creature):void {
			//Effect: Stuns the PC for one turn and deals some damage, not much though. (Note: PC's version of this does something different and Ember has no cooldown to use this again. Obviously do not spam or peeps will rage.)
			//Description:
			output("Ember bares "+ mf("his","her") + " teeth and releases a deafening roar; a concussive blast of force heads straight for you!  ");
			if (rangedCombatMiss(this, target)) {
				output("You quickly manage to jump out of the way and watch in awe as the blast gouges into the ground you were standing on mere moments ago.");
			}
			else {
				var damageResult:DamageResult = calculateDamage(new TypeCollection( { kinetic : 12 }, DamageFlag.EXPLOSIVE, DamageFlag.BYPASS_SHIELD ).rand(), this, target, "melee");
				
				output("Try as you might, you can't seem to protect yourself; and the blast hits you like a stone, throwing you to the ground. ");
				if (!target.hasStatusEffect("Stun Immune")) {
					output("Your head swims - it'll take a moment before you can regain your balance. ");
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
				}
				createStatusEffect("StunCooldown", 4, 0, 0, 0);
				
				outputDamage(damageResult);
			}
		}
	}
}