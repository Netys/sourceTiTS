package classes.GameData 
{
	import classes.Characters.Celise;
	import classes.Characters.CoC.CoCJojo;
	import classes.Characters.CoC.CoCLivingStatue;
	import classes.Characters.Cockvine;
	import classes.Characters.GrayGoo;
	import classes.Characters.Kaska;
	import classes.Characters.PlayerCharacter;
	import classes.Characters.RaskvelFemale;
	import classes.Characters.RaskvelMale;
	import classes.Characters.ZilFemale;
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.GameData.Pregnancy.Handlers.CockvinePregnancy;
	import classes.GLOBAL;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Items.Miscellaneous.GrayMicrobots;
	import classes.kGAMECLASS;
	import classes.Engine.Utility.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Combat.*;
	import classes.Engine.Combat.DamageTypes.*;
	
	/**
	 * Static library of combat attack implementations
	 * 
	 * TODO: Move dronetarget updating into the CombatContainer processing code.
	 * @author Gedan
	 */
	public class CombatAttacks 
	{
		public static function GetAttacksFor(target:Creature):/*SingleCombatAttack*/Array
		{
			var atks:Array = [];
			
			for (var i:int = 0; i < a.length; i++)
			{
				var atk:SingleCombatAttack = a[i];
				
				if (!atk.IsDisplayable(target))
				{
					continue;
				}
				
				atks.push(atk);
			}
			
			return atks;
		}
		
		// For a given list of creatures, find the "best fit" for an automatically selected target for an attack that otherwise
		// doesn't require a target to be selected.
		// Basically, this is for AoE attacks that don't require an explicit target, but still make reference to an action taking place
		// against one specific enemy to start the chain of events.
		private static function GetBestPotentialTarget(hGroup:Array):Creature
		{
			if (hGroup.length == 1) return hGroup[0];
			
			var possibleCreature:Creature = null;
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				var currentCreature:Creature = hGroup[i] as Creature;
				
				if (currentCreature.isDefeated()) continue;
				
				if (currentCreature is PlayerCharacter && !(possibleCreature is PlayerCharacter))
				{
					possibleCreature = currentCreature;
				}
				else if (currentCreature.isUniqueInFight && (possibleCreature != null && !possibleCreature.isUniqueInFight))
				{
					possibleCreature = currentCreature;
				}
				else if (possibleCreature == null)
				{
					possibleCreature = currentCreature;
				}
			}
			
			return possibleCreature;
		}
		
		private static var o:CombatAttacks;
		private static var a:Array;
		
		{
			a = new Array();
			o = new CombatAttacks();
		}
		
		public function CombatAttacks()
		{
			// Headbutt
			Headbutt = new SingleCombatAttack();
			Headbutt.ButtonName = "Headbutt";
			Headbutt.EnergyCost = 25;
			Headbutt.RequiresClass = GLOBAL.CLASS_MERCENARY;
			Headbutt.TooltipTitle = "Headbutt";
			Headbutt.TooltipBody = "A physique-based attack that does not benefit from weapon damage but has a chance of stunning your target.";
			Headbutt.SetAttackTypeFlags(SingleCombatAttack.ATF_MELEE, SingleCombatAttack.ATF_SPECIAL);
			Headbutt.Implementor = HeadbuttImpl; // headbutt
			a.push(Headbutt);
			
			// Rapidfire
			RapidFire = new SingleCombatAttack();
			RapidFire.ButtonName = "Rapid Fire";
			RapidFire.EnergyCost = 20;
			RapidFire.RequiresPerk = "Rapid Fire";
			RapidFire.DisabledIfEffectedBy = ["Disarmed"];
			RapidFire.TooltipTitle = "Rapid Fire";
			RapidFire.TooltipBody = "Perform a long range attack with two additional, low accuracy shots following it.";
			RapidFire.IsRangedBased = true;
			RapidFire.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			RapidFire.Implementor = RapidFireImpl; // rapidFire
			a.push(RapidFire);
			
			// Power Strike
			PowerStrike = new SingleCombatAttack();
			PowerStrike.ButtonName = "Power Strike";
			PowerStrike.EnergyCost = 20;
			PowerStrike.RequiresPerk = "Power Strike";
			PowerStrike.DisabledIfEffectedBy = ["Disarmed"];
			PowerStrike.TooltipTitle = "Power Strike";
			PowerStrike.TooltipBody = "Strike once with a melee weapon for 200% of normal damage.";
			PowerStrike.IsMeleeBased = true;
			PowerStrike.SetAttackTypeFlags(SingleCombatAttack.ATF_MELEE, SingleCombatAttack.ATF_SPECIAL);
			PowerStrike.Implementor = PowerStrikeImpl; // powerStrike
			a.push(PowerStrike);
			
			// Take Cover
			TakeCover = new SingleCombatAttack();
			TakeCover.ButtonName = "Take Cover";
			TakeCover.EnergyCost = 20;
			TakeCover.RequiresPerk = "Take Cover";
			TakeCover.TooltipTitle = "Take Cover";
			TakeCover.TooltipBody = "Increased ranged evasion to 90% for three turns.";
			TakeCover.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			TakeCover.Implementor = TakeCoverImpl; // takeCover;
			TakeCover.RequiresTarget = false;
			a.push(TakeCover);
			
			// Carpet Grenades
			CarpetGrenades = new SingleCombatAttack();
			CarpetGrenades.ButtonName = "Carpet Grenades";
			CarpetGrenades.EnergyCost = 25;
			CarpetGrenades.RequiresPerk = "Carpet Grenades";
			CarpetGrenades.DisabledIfEffectedBy = ["Disarmed"];
			CarpetGrenades.TooltipTitle = "Carpet Grenades";
			CarpetGrenades.TooltipBody = "An attack that is extra effective against multiple foes. Its damage is increased by level and intelligence.";
			CarpetGrenades.SetAttackTypeFlags(SingleCombatAttack.ATF_AOE, SingleCombatAttack.ATF_SPECIAL);
			CarpetGrenades.Implementor = CarpetGrenadesImpl; // carpetGrenades
			CarpetGrenades.RequiresTarget = false;
			a.push(CarpetGrenades);
			
			// Det. Charge
			DetonationCharge = new SingleCombatAttack();
			DetonationCharge.ButtonName = "Det. Charge";
			DetonationCharge.EnergyCost = 25;
			DetonationCharge.RequiresPerk = "Detonation Charge";
			DetonationCharge.DisabledIfEffectedBy = ["Disarmed"];
			DetonationCharge.TooltipTitle = "Detonation Charge";
			DetonationCharge.TooltipBody = "Deals a high amount of level and intelligence-based thermal damage against a single foe.";
			DetonationCharge.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			DetonationCharge.Implementor = DetonationChargeImpl; // detCharge
			a.push(DetonationCharge);
			
			// Second Wind
			SecondWind = new SingleCombatAttack();
			SecondWind.ButtonName = "Second Wind";
			SecondWind.RequiresLevel = 5;
			SecondWind.RequiresPerk = "Second Wind";
			SecondWind.DisabledIfEffectedBy = ["Used Second Wind"];
			SecondWind.TooltipTitle = "Second Wind";
			SecondWind.TooltipBody = "Regenerate 50% of your maximum HP and energy once per battle! An invaluable ability for the mercenary in the field.";
			SecondWind.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			SecondWind.Implementor = SecondWindImpl;
			SecondWind.RequiresTarget = false;
			a.push(SecondWind);
			
			// Paralyzing Shock
			ParalyzingShock = new SingleCombatAttack();
			ParalyzingShock.ButtonName = "P. Shock";
			ParalyzingShock.EnergyCost = 25;
			ParalyzingShock.RequiresClass = GLOBAL.CLASS_ENGINEER;
			ParalyzingShock.TooltipTitle = "Paralyzing Shock";
			ParalyzingShock.TooltipBody = "An ability with an intelligence-based chance to paralyze a single foe. Enemies with higher physique scores will be more likely to resist its effects!";
			ParalyzingShock.IsRangedBased = true;
			ParalyzingShock.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			ParalyzingShock.Implementor = ParalyzingShockImpl;
			a.push(ParalyzingShock);
			
			// Volley
			Volley = new SingleCombatAttack();
			Volley.ButtonName = "Volley";
			Volley.EnergyCost = 20;
			Volley.RequiresPerk = "Volley";
			Volley.DisabledIfEffectedBy = ["Disarmed"];
			Volley.IsRangedBased = true;
			Volley.TooltipTitle = "Volley";
			Volley.TooltipBody = "Perform a ranged attack with an additional, low-accuracy attack added on. Can blind foes based upon aim and the target's reflexes, but only if done with <b>an energy weapon.</b>";
			Volley.Implementor = VolleyImpl;
			Volley.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(Volley);
			
			// Overcharge
			Overcharge = new SingleCombatAttack();
			Overcharge.ButtonName = "Overcharge";
			Overcharge.EnergyCost = 20;
			Overcharge.RequiresPerk = "Overcharge";
			Overcharge.DisabledIfEffectedBy = ["Disarmed"];
			Overcharge.RequiresDamageFlags = [DamageFlag.ENERGY_WEAPON];
			Overcharge.IsRangedBased = true;
			Overcharge.TooltipTitle = "Overcharge";
			Overcharge.TooltipBody = "A powerful ranged attack, Overcharge deals 150% damage and has a chance of stunning. Higher intelligence increases the chance of successfully stunning your foe.";
			Overcharge.Implementor = OverchargeImpl;
			Overcharge.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(Overcharge);
			
			// Deflector Regen
			DeflectorRegeneration = new SingleCombatAttack();
			DeflectorRegeneration.ButtonName = "D. Regen";
			DeflectorRegeneration.EnergyCost = 20;
			DeflectorRegeneration.RequiresPerk = "Deflector Regeneration";
			DeflectorRegeneration.TooltipTitle = "Deflector Regeneration";
			DeflectorRegeneration.TooltipBody = "Restores a portion of your shields every turn for four turns. Higher intelligence will increase the amount.";
			DeflectorRegeneration.RequiresTarget = false;
			DeflectorRegeneration.Implementor = DeflectorRegenerationImpl;
			DeflectorRegeneration.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			a.push(DeflectorRegeneration);
			
			// Power Surge
			PowerSurge = new SingleCombatAttack();
			PowerSurge.ButtonName = "P. Surge";
			PowerSurge.EnergyCost = 33;
			PowerSurge.RequiresPerk = "Power Surge";
			PowerSurge.TooltipTitle = "Power Surge";
			PowerSurge.TooltipBody = "Restores a moderate amount of shields based on intelligence.";
			PowerSurge.RequiresTarget = false;
			PowerSurge.Implementor = PowerSurgeImpl;
			PowerSurge.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			a.push(PowerSurge);
			
			// Thermal Disruptor
			ThermalDisruptor = new SingleCombatAttack();
			ThermalDisruptor.ButtonName = "T. Disrupt";
			ThermalDisruptor.EnergyCost = 25;
			ThermalDisruptor.RequiresPerk = "Thermal Disruptor";
			ThermalDisruptor.DisabledIfEffectedBy = ["Disarmed"];
			ThermalDisruptor.TooltipTitle = "Thermal Disruptor";
			ThermalDisruptor.TooltipBody = "Deals a large amount of intelligence-based thermal damage to a single target.";
			ThermalDisruptor.Implementor = ThermalDisruptorImpl;
			ThermalDisruptor.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(ThermalDisruptor);
			
			// Grav Disruptor
			GravidicDisruptor = new SingleCombatAttack();
			GravidicDisruptor.ButtonName = "G. Disrupt";
			GravidicDisruptor.EnergyCost = 25;
			GravidicDisruptor.RequiresPerk = "Gravidic Disruptor";
			GravidicDisruptor.DisabledIfEffectedBy = ["Disarmed"];
			GravidicDisruptor.TooltipTitle = "Gravidic Disruptor";
			GravidicDisruptor.TooltipBody = "Deals a moderate amount of intelligence-based, Unresistable damage to a single target.";
			GravidicDisruptor.Implementor = GravidicDisruptorImpl;
			GravidicDisruptor.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(GravidicDisruptor);
			
			// Shield Hack
			ShieldHack = new SingleCombatAttack();
			ShieldHack.ButtonName = "S. Hack";
			ShieldHack.EnergyCost = 25;
			ShieldHack.RequiresPerk = "Shield Hack";
			ShieldHack.TooltipTitle = "Shield Hack";
			ShieldHack.TooltipBody = "An attack that deals a high amount of electric-typed damage to a target's shields. Damage is increased by intelligence.";
			ShieldHack.Implementor = ShieldHackImpl;
			ShieldHack.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(ShieldHack);
			
			// Weapon Hack
			WeaponHack = new SingleCombatAttack();
			WeaponHack.ButtonName = "W. Hack";
			WeaponHack.EnergyCost = 10;
			WeaponHack.RequiresPerk = "Weapon Hack";
			WeaponHack.TooltipTitle = "Weapon Hack";
			WeaponHack.TooltipBody = "Attempt to neutralize a foe's <b>energy weapon</b> using your intelligence. Smarter foes will resist your attempts.";
			WeaponHack.Implementor = WeaponHackImpl;
			WeaponHack.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(WeaponHack);
			
			// PocketSand/Flash Grenade
			PocketSand = new SingleCombatAttack();
			PocketSand.ButtonName = "P. Sand";
			PocketSand.EnergyCost = 10;
			PocketSand.RequiresClass = GLOBAL.CLASS_SMUGGLER;
			PocketSand.RequiresTarget = false;
			PocketSand.TooltipTitle = "Pocket Sand";
			PocketSand.TooltipBody = "Produce some sand from your level and use it to blind your enemies! Better aim will help you land the attack.";
			PocketSand.Implementor = PocketSandImp;
			PocketSand.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL, SingleCombatAttack.ATF_AOE);
			PocketSand.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return kGAMECLASS.silly;
			};
			a.push(PocketSand);
			
			FlashGrenade = new SingleCombatAttack();
			FlashGrenade.ButtonName = "F. Grenade";
			FlashGrenade.EnergyCost = 10;
			FlashGrenade.RequiresClass = GLOBAL.CLASS_SMUGGLER;
			FlashGrenade.RequiresTarget = false;
			FlashGrenade.TooltipTitle = "Flash Grenade";
			FlashGrenade.TooltipBody = "Produce a rechargable flash grenade and use it to blind your enemy. Better aim will increase the chance of success.";
			FlashGrenade.Implementor = FlashGrenadeImpl;
			FlashGrenade.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL, SingleCombatAttack.ATF_AOE);
			FlashGrenade.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return !kGAMECLASS.silly;
			};
			a.push(FlashGrenade);
			
			// Low Blow
			LowBlow = new SingleCombatAttack();
			LowBlow.ButtonName = "Low Blow";
			LowBlow.EnergyCost = 15;
			LowBlow.RequiresPerk = "Low Blow";
			LowBlow.TooltipTitle = "Low Blow";
			LowBlow.TooltipBody = "A melee ability with a physique-based chance of stunning your target. It does low damage, and stronger foes will be more able to resist being stunned.";
			LowBlow.Implementor = LowBlowImpl;
			LowBlow.SetAttackTypeFlags(SingleCombatAttack.ATF_MELEE, SingleCombatAttack.ATF_SPECIAL);
			a.push(LowBlow);
			
			// Disarming Shot
			DisarmingShot = new SingleCombatAttack();
			DisarmingShot.ButtonName = "Disarm Shot";
			DisarmingShot.EnergyCost = 20;
			DisarmingShot.RequiresPerk = "Disarming Shot";
			DisarmingShot.DisabledIfEffectedBy = ["Disarmed"];
			DisarmingShot.Implementor = DisarmingShotImpl;
			DisarmingShot.TooltipTitle = "Disarming Shot";
			DisarmingShot.TooltipBody = "A single shot that will disable your target's usage of traditional weapons - if it hits. The strike has the same chance of hitting as any other shot. Note that this does not effect creatures or machines with integrated weaponry.";
			DisarmingShot.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(DisarmingShot);
			
			// Stealth
			StealthFieldGenerator = new SingleCombatAttack();
			StealthFieldGenerator.ButtonName = "Stealth Field";
			StealthFieldGenerator.EnergyCost = 20;
			StealthFieldGenerator.RequiresPerk = "Stealth Field Generator";
			StealthFieldGenerator.DisabledIfEffectedBy = ["Stealth Field Generator"];
			StealthFieldGenerator.Implementor = StealthFieldGeneratorImpl;
			StealthFieldGenerator.TooltipTitle = "Stealth Field Generator";
			StealthFieldGenerator.TooltipBody = "Creates a stealth field that greatly increases your evasion for a few turns.";
			StealthFieldGenerator.RequiresTarget = false;
			StealthFieldGenerator.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			a.push(StealthFieldGenerator);
			
			// Grenade
			Grenade = new SingleCombatAttack();
			Grenade.ButtonName = "Grenade";
			Grenade.EnergyCost = 25;
			Grenade.RequiresPerk = "Grenade";
			Grenade.DisabledIfEffectedBy = ["Disarmed"];
			Grenade.Implementor = GrenadeImpl;
			Grenade.TooltipTitle = "Grenade";
			Grenade.RequiresTarget = false;
			Grenade.SetAttackTypeFlags(SingleCombatAttack.ATF_AOE, SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			Grenade.TooltipBody = "Does a moderate amount of intelligence-based thermal and kinetic damage to your enemies.";
			a.push(Grenade);
			
			// GasGren
			GasGrenade = new SingleCombatAttack();
			GasGrenade.ButtonName = "Gas Grenade";
			GasGrenade.EnergyCost = 25;
			GasGrenade.RequiresPerk = "Gas Grenade";
			GasGrenade.DisabledIfEffectedBy = ["Disarmed"];
			GasGrenade.Implementor = GasGrenadeImpl;
			GasGrenade.TooltipTitle = "Gas Grenade";
			GasGrenade.RequiresTarget = false;
			GasGrenade.TooltipBody = "An unavoidable attack that deals a fair amount of lust damage to your enemies. Increases slightly with level.";
			GasGrenade.SetAttackTypeFlags(SingleCombatAttack.ATF_AOE, SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(GasGrenade);
			
			// Smuggled Stim
			SmuggledStimulant = new SingleCombatAttack();
			SmuggledStimulant.ButtonName = "S. Stimulant";
			SmuggledStimulant.DisabledIfEffectedBy = ["Used Smuggled Stimulant"];
			SmuggledStimulant.RequiresPerk = "Smuggled Stimulant";
			SmuggledStimulant.Implementor = SmuggleStimulatImpl;
			SmuggledStimulant.TooltipTitle = "Smuggled Stimulant";
			SmuggledStimulant.TooltipBody = "Inject yourself with a smuggled stimulant, causing you to recover 25 energy a turn for three turns.";
			SmuggledStimulant.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			SmuggledStimulant.RequiresTarget = false;
			a.push(SmuggledStimulant);
			
			// Burst of Energy
			BurstOfEnergy = new SingleCombatAttack();
			BurstOfEnergy.ButtonName = "Bst. Energy";
			BurstOfEnergy.DisabledIfEffectedBy = ["Used Burst of Energy"];
			BurstOfEnergy.RequiresPerk = "Burst of Energy";
			BurstOfEnergy.Implementor = BurstOfEnergyImpl;
			BurstOfEnergy.TooltipTitle = "Burst of Energy";
			BurstOfEnergy.TooltipBody = "Get a burst of energy, recovering 60 energy.\n\nYou may only do this once per encounter.";
			BurstOfEnergy.RequiresTarget = false;
			BurstOfEnergy.SetAttackTypeFlags(SingleCombatAttack.ATF_SPECIAL);
			a.push(BurstOfEnergy);
			
			// Concussive Shot
			ConcussiveShot = new SingleCombatAttack();
			ConcussiveShot.ButtonName = "C. Shot";
			ConcussiveShot.DisabledIfEffectedBy = ["Disarmed"];
			ConcussiveShot.EnergyCost = 25;
			ConcussiveShot.IsRangedBased = true;
			ConcussiveShot.RequiresItemFlags = [GLOBAL.ITEM_FLAG_BOW_WEAPON];
			ConcussiveShot.RequiresPerk = "Concussive Shot";
			ConcussiveShot.ExtendedDisplayabilityCheck = function():Boolean {
				return kGAMECLASS.pc.rangedWeapon.hasFlag(GLOBAL.ITEM_FLAG_BOW_WEAPON);
			}
			ConcussiveShot.TooltipTitle = "Concussive Shot";
			ConcussiveShot.TooltipBody = "Fire an explosive arrow at your target, potentially stunning them for 1-2 rounds.";
			ConcussiveShot.Implementor = ConcussiveShotImpl;
			ConcussiveShot.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(ConcussiveShot);
			
			// Goozooka
			GoozookaAttack = new SingleCombatAttack();
			GoozookaAttack.ButtonName = "Goozooka";
			GoozookaAttack.DisabledIfEffectedBy = ["Disarmed"];
			GoozookaAttack.IsRangedBased = true;
			GoozookaAttack.ExtendedDisplayabilityCheck = function():Boolean {
				return kGAMECLASS.pc.hasKeyItem("Goozooka");
			}
			GoozookaAttack.ExtendedAvailabilityCheck = function():Boolean {
				return kGAMECLASS.pc.hasItemByType(GrayMicrobots);
			}
			GoozookaAttack.TooltipTitle = "Goozooka";
			GoozookaAttack.TooltipBody = "Fire a Gray Goo at your enemy for the princely sum of a single sample of Gray Microbots.";
			GoozookaAttack.Implementor = GoozookaAttackImpl;
			GoozookaAttack.SetAttackTypeFlags(SingleCombatAttack.ATF_RANGED, SingleCombatAttack.ATF_SPECIAL);
			a.push(GoozookaAttack);
			
			// Shared NPC Attacks
			// Attacks only intended to be used by NPCs!
			AphrodisiacDarts = new SingleCombatAttack();
			AphrodisiacDarts.IsRangedBased = true;
			AphrodisiacDarts.Implementor = AphrodisiacDartsImpl;
			
			WrenchAttack = new SingleCombatAttack();
			WrenchAttack.IsMeleeBased = true;
			WrenchAttack.Implementor = WrenchAttachImpl;
			
			TripAttack = new SingleCombatAttack();
			TripAttack.IsMeleeBased = true;
			TripAttack.Implementor = TripAttackImpl;
			
			////////////////////////
			////    MAGIC!!!    ////
			////////////////////////
			
			// Charge Weapon
			ChargeWeapon = new SingleCombatAttack();
			ChargeWeapon.ButtonName = "Charge Weapon";
			ChargeWeapon.EnergyCost = 10;
			ChargeWeapon.DisabledIfEffectedBy = ["Silence"];
			ChargeWeapon.TooltipTitle = "Charge Weapon";
			ChargeWeapon.TooltipBody = "The Charge Weapon spell will infuse your weapon with electrical energy, causing it to do even more damage.  The effect lasts for the entire combat. Damage bonus is based on your intellegence.";
			ChargeWeapon.Implementor = ChargeWeaponImpl;
			ChargeWeapon.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			ChargeWeapon.RequiresTarget = false;
			ChargeWeapon.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() < target.lustMax() * ((target.hasPerk("Enlightened") >= 0 && target.cor() < 10) ? 0.85 : 0.75) && !target.hasStatusEffect("Charge Weapon");
			}
			ChargeWeapon.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_CHARGE) > 0;
			}
			a.push(ChargeWeapon);
			
			// Blind - basically flash grenade
			Blind = new SingleCombatAttack();
			Blind.ButtonName = "Blind";
			Blind.EnergyCost = 10;
			Blind.DisabledIfEffectedBy = ["Silence"];
			Blind.TooltipTitle = "Blind";
			Blind.TooltipBody = "Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted. Chance is based on your intellegence and target's reflexes.";
			Blind.Implementor = BlindImpl;
			Blind.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Blind.RequiresTarget = false;
			Blind.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() < target.lustMax() * ((target.hasPerk("Enlightened") >= 0 && target.cor() < 10) ? 0.85 : 0.75);
			}
			Blind.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_BLIND) > 0;
			}
			a.push(Blind);
			
			// Whitefire
			Whitefire = new SingleCombatAttack();
			Whitefire.ButtonName = "Whitefire";
			Whitefire.EnergyCost = 30;
			Whitefire.DisabledIfEffectedBy = ["Silence"];
			Whitefire.TooltipTitle = "Whitefire";
			Whitefire.TooltipBody = "Whitefire is a potent fire based attack that will burn your foe with flickering white flames. Effect is based on your intellegence.";
			Whitefire.Implementor = WhitefireImpl;
			Whitefire.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Whitefire.RequiresTarget = true;
			Whitefire.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() < target.lustMax() * ((target.hasPerk("Enlightened") >= 0 && target.cor() < 10) ? 0.85 : 0.75);
			}
			Whitefire.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_WHITEFIRE) > 0 && !kGAMECLASS.isNineTails(target); // replaced with Fox Fire for Nine-tails
			}
			a.push(Whitefire);
			
			// Arouse - basically any single target lust attack
			Arouse = new SingleCombatAttack();
			Arouse.ButtonName = "Arouse";
			Arouse.EnergyCost = 15;
			Arouse.DisabledIfEffectedBy = ["Silence"];
			Arouse.TooltipTitle = "Arouse";
			Arouse.TooltipBody = "The arouse spell draws on your own inner lust in order to enflame the enemy's passions. Power is based on your intellegence. Target's willpower affects it considerably.";
			Arouse.Implementor = ArouseImpl;
			Arouse.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Arouse.RequiresTarget = true;
			Arouse.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() >= 50;
			}
			Arouse.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_AROUSE) > 0;
			}
			a.push(Arouse);
			
			// Heal
			Heal = new SingleCombatAttack();
			Heal.ButtonName = "Heal";
			Heal.EnergyCost = 20;
			Heal.DisabledIfEffectedBy = ["Silence"];
			Heal.TooltipTitle = "Heal";
			Heal.TooltipBody = "Heal will attempt to use black magic to close your wounds and restore your body, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you. Heal amount is based on your intellegence. Backfire chance is based on your current lust and willpower.";
			Heal.Implementor = HealImpl;
			Heal.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Heal.RequiresTarget = false;
			Heal.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() >= 50 && target.HPQ() < 100;
			}
			Heal.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_HEAL) > 0;
			}
			a.push(Heal);
			
			// Might
			Might = new SingleCombatAttack();
			Might.ButtonName = "Might";
			Might.EnergyCost = 25;
			Might.DisabledIfEffectedBy = ["Silence"];
			Might.TooltipTitle = "Might";
			Might.TooltipBody = "The Might spell draws upon your lust and uses it to fuel a temporary increase in physique and HP.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself. Effect is based on your intellegence.";
			Might.Implementor = MightImpl;
			Might.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Might.RequiresTarget = false;
			Might.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return target.lust() >= 50 && !target.hasStatusEffect("Might");
			}
			Might.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return (target.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_MIGHT) > 0;
			}
			a.push(Might);
			
			// Fox Fire - single target burning damage
			CleansingPalm = new SingleCombatAttack();
			CleansingPalm.ButtonName = "C. Palm";
			CleansingPalm.EnergyCost = 30;
			CleansingPalm.RequiresPerk = "Cleansing Palm";
			CleansingPalm.DisabledIfEffectedBy = [];
			CleansingPalm.TooltipTitle = "Cleansing Palm";
			CleansingPalm.TooltipBody = "Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.";
			CleansingPalm.Implementor = CleansingPalmImpl;
			CleansingPalm.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			CleansingPalm.RequiresTarget = true;
			CleansingPalm.ExtendedDisplayabilityCheck = function(target:Creature):Boolean {
				return kGAMECLASS.inMareth();
			}
			a.push(CleansingPalm);
			
			// Dragon Breath - AoE stun + damage
			DragonFire = new SingleCombatAttack();
			DragonFire.ButtonName = "Dragonfire";
			DragonFire.EnergyCost = 5;
			DragonFire.RequiresPerk = "Dragonfire";
			DragonFire.DisabledIfEffectedBy = ["Silence", "DragonfireCD"];
			DragonFire.TooltipTitle = "Dragonfire";
			DragonFire.TooltipBody = "Unleash fire from your mouth. This can only be done once a day. Damage is based on your level.";
			DragonFire.Implementor = DragonFireImpl;
			// It is not actually magic skill
			DragonFire.RequiresTarget = true;
			DragonFire.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return !target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT); // makes sense when you can't use breath attacks in sealed armor
			}
			a.push(DragonFire);
			
			// Whisper - single target stun
			Whisper = new SingleCombatAttack();
			Whisper.ButtonName = "Whisper";
			Whisper.EnergyCost = 15;
			Whisper.RequiresPerk = "Whispered";
			Whisper.DisabledIfEffectedBy = [];
			Whisper.TooltipTitle = "Whisper";
			Whisper.TooltipBody = "Whisper and induce fear in your opponent. To succeed you should break your enemy's will.";
			Whisper.Implementor = WhisperImpl;
			Whisper.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Whisper.RequiresTarget = true;
			a.push(Whisper);
			
			// Terrestrial Fire - single target burning damage
			FireBreath = new SingleCombatAttack();
			FireBreath.ButtonName = "Fire Breath";
			FireBreath.EnergyCost = 20;
			FireBreath.RequiresPerk = "Fire Lord";
			FireBreath.DisabledIfEffectedBy = ["Silence"];
			FireBreath.TooltipTitle = "Dragonfire";
			FireBreath.TooltipBody = "Unleash fire from your mouth. Damage is based on your level.";
			FireBreath.Implementor = FireBreathImpl;
			FireBreath.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			FireBreath.RequiresTarget = true;
			FireBreath.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return !target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT); // makes sense when you can't use breath attacks in sealed armor
			}
			a.push(FireBreath);
			
			// Hellfire - single target burning damage
			Hellfire = new SingleCombatAttack();
			Hellfire.ButtonName = "Hellfire";
			Hellfire.EnergyCost = 20;
			Hellfire.RequiresPerk = "Hellfire";
			Hellfire.DisabledIfEffectedBy = ["Silence"];
			Hellfire.TooltipTitle = "Hellfire";
			Hellfire.TooltipBody = "Unleash fire from your mouth. Damage is based on your level.";
			Hellfire.Implementor = HellfireImpl;
			Hellfire.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			Hellfire.RequiresTarget = true;
			Hellfire.ExtendedAvailabilityCheck = function(target:Creature):Boolean {
				return !target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT); // makes sense when you can't use breath attacks in sealed armor
			}
			a.push(Hellfire);
			
			// Fox Fire - single target burning damage
			KitsuneFoxFire = new SingleCombatAttack();
			KitsuneFoxFire.ButtonName = "Fox Fire";
			KitsuneFoxFire.EnergyCost = 20;
			KitsuneFoxFire.RequiresPerk = "Enlightened Nine-tails";
			KitsuneFoxFire.DisabledIfEffectedBy = [];
			KitsuneFoxFire.TooltipTitle = "Fox Fire";
			KitsuneFoxFire.TooltipBody = "Unleash an ethereal blue flame at your opponent for high burning damage. Damage is based on your intellegence.";
			KitsuneFoxFire.Implementor = KitsuneFoxFireImpl;
			KitsuneFoxFire.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			KitsuneFoxFire.RequiresTarget = true;
			a.push(KitsuneFoxFire);
			
			// Illusion - AoE blind
			KitsuneIllusion = new SingleCombatAttack();
			KitsuneIllusion.ButtonName = "Illusion";
			KitsuneIllusion.EnergyCost = 15;
			KitsuneIllusion.RequiresPerk = "Enlightened Nine-tails";
			KitsuneIllusion.DisabledIfEffectedBy = [];
			KitsuneIllusion.TooltipTitle = "Illusion";
			KitsuneIllusion.TooltipBody = "Warp the reality around your opponents, lowering their accuracy. To succeed you should have successfull intellegence or willpower roll against target's ones.";
			KitsuneIllusion.Implementor = KitsuneIllusionImpl;
			KitsuneIllusion.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			KitsuneIllusion.RequiresTarget = false;
			a.push(KitsuneIllusion);
			
			// Corrupted Fox Fire - single target burning damage
			KitsuneCorruptFoxFire = new SingleCombatAttack();
			KitsuneCorruptFoxFire.ButtonName = "Fox Fire";
			KitsuneCorruptFoxFire.EnergyCost = 20;
			KitsuneCorruptFoxFire.RequiresPerk = "Corrupted Nine-tails";
			KitsuneCorruptFoxFire.DisabledIfEffectedBy = [];
			KitsuneCorruptFoxFire.TooltipTitle = "Corrupted Fox Fire";
			KitsuneCorruptFoxFire.TooltipBody = "Unleash an ethereal purple flame at your opponent for high burning damage. Damage is based on your intellegence.";
			KitsuneCorruptFoxFire.Implementor = KitsuneCorruptFoxFireImpl;
			KitsuneCorruptFoxFire.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			KitsuneCorruptFoxFire.RequiresTarget = true;
			a.push(KitsuneCorruptFoxFire);
			
			// Terror - single target stun
			KitsuneTerror = new SingleCombatAttack();
			KitsuneTerror.ButtonName = "Terror";
			KitsuneTerror.EnergyCost = 15;
			KitsuneTerror.RequiresPerk = "Corrupted Nine-tails";
			KitsuneTerror.DisabledIfEffectedBy = [];
			KitsuneTerror.TooltipTitle = "Terror";
			KitsuneTerror.TooltipBody = "Instill fear into your opponent with eldritch horrors. To succeed you should have successfull intellegence or willpower roll against target's ones.";
			KitsuneTerror.Implementor = KitsuneTerrorImpl;
			KitsuneTerror.SetAttackTypeFlags(SingleCombatAttack.ATF_MAGIC);
			KitsuneTerror.RequiresTarget = true;
			a.push(KitsuneTerror);
			
			// debug instakill weapon
			AFL = new SingleCombatAttack();
			AFL.ButtonName = "AFL";
			AFL.ExtendedDisplayabilityCheck = function():Boolean {
				return kGAMECLASS.pc.hasKeyItem("AFL") || kGAMECLASS.debug;
			}
			AFL.TooltipTitle = "AFL";
			AFL.TooltipBody = "Bring out your final argument.";
			AFL.Implementor = AFLImpl;
			AFL.RequiresTarget = false;
			a.push(AFL);
		}
		
		/**
		 * This is a SINGLE ranged attack with no "before" or "after" stuff.
		 * It does not call or repeat itself- this is a single application of damage
		 * following basic ranged attack rules.
		 * @param	attacker
		 * @param	target
		 */
		public static function SingleRangedAttackImpl(attacker:Creature, target:Creature, asFlurry:Boolean = false, special:String = "ranged"):Boolean
		{
			if (rangedCombatMiss(attacker, target))
			{
				if (target.customDodge.length > 0)
				{
					if (attacker is PlayerCharacter) output("You " + attacker.rangedWeapon.attackVerb + " at " + target.a + target.uniqueName + ". " + target.customDodge);
					else output(attacker.capitalA + attacker.uniqueName + " takes a "+ attacker.rangedWeapon.attackVerb +" at " + target.a + target.uniqueName + ". " + target.customDodge);
				}
				else if (attacker is PlayerCharacter) output("You " + attacker.rangedWeapon.attackVerb + " at " + target.a + target.uniqueName + " with your " + attacker.rangedWeapon.longName + ", but just can't connect.");
				else if (target is PlayerCharacter) output("You manage to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.attackNoun + ".");
				else output(target.capitalA + target.uniqueName + " manages to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.attackNoun + ".");
				return false;
			}
			
			if ((attacker.hasStatusEffect("Blinded") || attacker.hasStatusEffect("Smoke Grenade")) && rand(4) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind-fired shot doesn't manage to connect.");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind "+ attacker.rangedWeapon.attackNoun +" fails to connect!");
				return false;
			}
			
			if (asFlurry && rand(100) <= 45 && !target.isImmobilized() && !attacker.rangedWeapon.hasFlag(GLOBAL.ITEM_FLAG_EFFECT_FLURRYBONUS))
			{
				if (target.customDodge.length > 0)
				{
					if (attacker is PlayerCharacter) output("You take a " + attacker.rangedWeapon.attackVerb + " at " + target.a + target.uniqueName + ". " + target.customDodge);
					else output(attacker.capitalA + attacker.uniqueName + " takes a "+ attacker.rangedWeapon.attackVerb +" at " + target.a + target.uniqueName + ". " + target.customDodge);
				}
				else if (attacker is PlayerCharacter) output("You " + attacker.rangedWeapon.attackVerb + " at " + target.a + target.uniqueName + " with your " + attacker.rangedWeapon.longName + ", but just can't connect.");
				else if (target is PlayerCharacter) output("You manage to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.attackNoun + ".");
				else output(target.capitalA + target.uniqueName + " manages to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.attackNoun + ".");
				return false;
			}
			
			// We made it here, the attack landed
			
			if (attacker is PlayerCharacter) output("You land a hit on " + target.a + target.uniqueName + " with your " + attacker.rangedWeapon.longName + "!");
			else if (attacker.isPlural) output(attacker.capitalA + attacker.uniqueName + " connects with their " + plural(attacker.rangedWeapon.longName) + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " hits you with " + attacker.mfn("his", "her", "its") + " " + attacker.rangedWeapon.longName + "!");
			else output(attacker.capitalA + attacker.uniqueName + " connects with " + attacker.mfn("his", "her", "its") + " " + attacker.rangedWeapon.longName + "!");
			
			var damage:TypeCollection = attacker.rangedDamage();
			damageRand(damage, 15);
			applyDamage(damage, attacker, target, special);
			return true;
		}
		
		public static function SingleMeleeAttackImpl(attacker:Creature, target:Creature, asFlurry:Boolean = false, special:String = "melee"):Boolean
		{
			if (combatMiss(attacker, target))
			{
				if (target.customDodge.length > 0)
				{
					if (attacker is PlayerCharacter) output("You " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName + ". " + target.customDodge);
					else output(attacker.capitalA + attacker.uniqueName + " takes a "+ attacker.meleeWeapon.attackVerb +" at " + target.a + target.uniqueName + ". " + target.customDodge);
				}
				else if (attacker is PlayerCharacter) output("You " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName + " with your " + attacker.meleeWeapon.longName + ", but just can't connect.");
				else if (target is PlayerCharacter) output("You manage to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.meleeWeapon.attackNoun + ".");
				else output(target.capitalA + target.uniqueName + " manages to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.meleeWeapon.attackNoun + ".");
				return false;
			}
			
			if ((attacker.hasStatusEffect("Blinded") || attacker.hasStatusEffect("Smoke Grenade")) && rand(2) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind strike doesn't manage to connect.");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind " + attacker.meleeWeapon.attackNoun + " fails to connect!");
				return false;
			}
			
			if (asFlurry && rand(100) <= 45 && !target.isImmobilized() && !attacker.meleeWeapon.hasFlag(GLOBAL.ITEM_FLAG_EFFECT_FLURRYBONUS))
			{
				if (target.customDodge.length > 1)
				{
					if (attacker is PlayerCharacter) output("You " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName + ". " + target.customDodge);
					else output(attacker.capitalA + attacker.uniqueName + " takes a "+ attacker.meleeWeapon.attackNoun +" at " + target.a + target.uniqueName + ". " + target.customDodge);
				}
				else if (attacker is PlayerCharacter) output("You " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName + " with your " + attacker.meleeWeapon.longName + ", but just can't connect.");
				else if (target is PlayerCharacter) output("You manage to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.meleeWeapon.attackNoun + ".");
				else output(target.capitalA + target.uniqueName + " manages to avoid " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.meleeWeapon.attackNoun + ".");
				return false;
			}
			
			if (target is PlayerCharacter && kGAMECLASS.mimbraneFeetBonusEvade(target))
			{
				output("You’re taken by surprise as your [pc.foot] suddenly acts on its own, right as you’re about be attacked. The action is intense enough to slide you right out of the face of danger. Seems your Mimbrane is even more attentive than you are!\n");
				return false;
			}
			
			if (target is ZilFemale) kGAMECLASS.flags["HIT_A_ZILGIRL"] = 1;
			
			if (attacker is PlayerCharacter) output("You land a hit on " + target.a + target.uniqueName + " with your " + attacker.meleeWeapon.longName + "!");
			else if (attacker.isPlural) output(attacker.capitalA + attacker.uniqueName + " connects with their " + plural(attacker.meleeWeapon.longName) + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " hits you with " + attacker.mfn("his", "her", "its") + " " + attacker.meleeWeapon.longName + "!");
			else output(attacker.capitalA + attacker.uniqueName + " connects with " + attacker.mfn("his", "her", "its") + " " + attacker.meleeWeapon.longName + "!");
			
			var d:TypeCollection = attacker.meleeDamage();
			damageRand(d, 15);
			applyDamage(d, attacker, target, special);
			return true;
		}
		
		/**
		 * This is a "regular" ranged attack.
		 * It handles various statuses that can cause a total failure (Disarm, Gunlock)
		 * and handles Multiple Shots by default. It should NOT be called by special attacks-
		 * they should call the SingleRangedAttackImpl themselves _directly_, which makes no
		 * assumptions.
		 * @param	attacker
		 * @param	target
		 */
		public static function RangedAttack(attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			// Tutorial hook
			if (target is Celise)
			{
				output("Celise takes the hit, the wound instantly closing in with fresh, green goop. Her surface remains perfectly smooth and unmarred afterwards.");
				return;
			}
			
			if (attacker.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to attack until you remember that you’ve been disarmed!");
				else output(attacker.capitalA + attacker.uniqueName + " scrabbles about, trying to find " + attacker.mfn("his", "her", "its") + " missing weapon.");
				return;
			}
			
			if (attacker.hasStatusEffect("Gunlock"))
			{
				if (attacker is PlayerCharacter) output("Your " + attacker.rangedWeapon.longName + " is currently disabled and unable to be used!");
				else output(attacker.capitalA + attacker.uniqueName + " + fiddles fruitlessly with " + attacker.mfn("his", "her", "its") + " disabled weapon.");
				return;
			}
			
			var numShots:int = 1;
			if (attacker.hasPerk("Shoot First") && !attacker.hasPerk("Multiple Shots") && CombatManager.getRoundCount() == 1 && attacker.rangedWeapon.attackImplementor == null)
			{
				output("<b>Shot first!</b>\n");
				numShots++;
			}
			
			if (attacker.hasPerk("Multiple Shots")) numShots = attacker.perkv1("Multiple Shots");
			
			var numFlurries:int = 0;
			if (attacker.hasPerk("Second Shot")) numFlurries++;
			
			var totalShots:int = numShots + numFlurries;
			for (var n:int = 0; n < totalShots; n++)
			{
				var asFlurry:Boolean = false;
				if (n != 0)
				{
					output("\n");
					if (numFlurries > 0)
					{
						numFlurries--;
						asFlurry = true;
					}
				}
				
				// concentratedFire(true) was buried in calculate damage- moved here
				// as makes way more sense to control it from here.
				concentratedFire(attacker, target, SingleRangedAttackImpl(attacker, target, asFlurry));
			}
			
			kGAMECLASS.playerMimbraneCloudAttack();
		}
		
		public static function MeleeAttack(attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (target is Celise)
			{
				output(target.customBlock);
				return;
			}
			
			if (attacker.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to attack until you remember you got disarmed!");
				else output(attacker.capitalA + attacker.uniqueName + " scrabbles about, trying to find " + attacker.mfn("his", "her", "its") + " missing weapon.");
				return;
			}
			
			if (attacker.hasPerk("Riposte") && !attacker.hasStatusEffect("Riposting"))
			{
				attacker.createStatusEffect("Riposting", 0, 0, 0, 0, true, "", "", true, 0);
			}
			
			var numSwings:int = 1;
			
			var numFlurries:int = 0;
			if (attacker.hasPerk("Second Attack")) numFlurries++;
			
			var numHits:int = 0;
			if (attacker.hasPerk("Multiple Attacks")) numSwings = attacker.perkv1("Multiple Attacks");
			
			var totalSwings:int = numSwings + numFlurries;
			for (var i:int = 0; i < totalSwings; i++)
			{
				var asFlurry:Boolean = false;
				if (i != 0)
				{
					output("\n");
					if (numFlurries > 0)
					{
						numFlurries--;
						asFlurry = true;
					}
				}
				
				if (SingleMeleeAttackImpl(attacker, target, asFlurry)) numHits++;
			}
			
			if (attacker.hasPerk("Cleave"))
			{
				var others:Array = CombatManager.getCreaturesGroup(target);
				
				for (i = 0; i < others.length; i++)
				{
					if (!others[i].isDefeated() && others[i] != target)
					{
						//if (numHits > 0 || i != 0) output("\n");
						output("\n");
						if (SingleMeleeAttackImpl(attacker, others[i], false)) numHits++;
					}
				}
			}
			
			if (attacker.hasPerk("Myr Venom") && target.isLustImmune == false)
			{
				output("\n");
				if (combatMiss(attacker, target))
				{
					if (attacker is PlayerCharacter) output("You can't manage to sneak in a bite!");
					else if (target is PlayerCharacter) output("You narrowly avoid " + attacker.a + possessive(attacker.uniqueName) + " lunging bite!");
					else output(target.capitalA + target.uniqueName + " narrowly avoids " + attacker.a + possessive(attacker.uniqueName) + " lunging bite!");
				}
				else
				{
					if (attacker is PlayerCharacter) output("To finish off your attack, you lean in and deliver a surprise bite, injecting a healthy dose of your red myrmedion venom!");
					else if (target is PlayerCharacter) output("A spike of pain lances through your arm as " + attacker.a + attacker.uniqueName + " clamps their jaws around your bicep, venom quickly coursing through your veins!");
					else output(target.capitalA + target.uniqueName + " " + target.mfn("growls", "squeals", "grunts") + " aloud as " + attacker.a + attacker.uniqueName + " clamps their jaws around a limb!");
					
					applyDamage(new TypeCollection( { tease: 3 + rand(3) } ), attacker, target, "minimal");
				}
			}
			
			if (numHits > 0)
			{
				if (attacker.hasPerk("Bloodthirsty"))
				{
					attacker.energy(2 + rand(3));
				}
			}
			
			if (attacker is PlayerCharacter)
			{
				kGAMECLASS.mimbraneHandBonusAttack(target);
				kGAMECLASS.playerMimbraneCloudAttack();
			}
		}
		
		//{ region Item Attack Implementors
		public static function DroneAttack(attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("Your");
			else output(attacker.capitalA + possessive(attacker.uniqueName));
			output(" drone repeatedly zaps ");
			if (target is PlayerCharacter) output("you");
			else output(target.a + target.uniqueName);
			output(".");
			applyDamage(attacker.droneDamage(), attacker, target, "minimal");
		}
		
		public static function TamwolfAttack(attacker:Creature, target:Creature):void
		{
			output("<i>“Enemy detected, " + attacker.mf("master", "mistress") + " " + attacker.uniqueName + "! I will defend you!”</i> Tam-wolf announces, leaping into the fray. He hits, biting ");
			if (target is PlayerCharacter) output(" you!");
			else output(target.a + target.uniqueName + ".");
			applyDamage(attacker.droneDamage(), attacker, target, "minimal");
			if (attacker is PlayerCharacter) output(" Good boy!");
		}
		
		public static function TamwolfDamagedAttack(attacker:Creature, target:Creature):void
		{
			if (rand(10) <= 2)
			{
				output("Tam-wolf leaps forward at " + target.a + target.uniqueName + "... but his bum leg catches, and he goes tumbling into the ground. Dammit, Tam-wolf!");
			}
			//Attack!
			else
			{
				output("<i>“ENEMY DETECTED, MISTRESS TAM! I WILL DEFEND YOU,”</i> Tam-wolf loudly announces as he lunges at " + target.a + target.uniqueName + ". He hits!");
				applyDamage(attacker.droneDamage(), attacker, target, "minimal");
				if (attacker is PlayerCharacter) output(" Good boy!");
			}
		}
		
		public static function TamwolfIIAttack(attacker:Creature, target:Creature):void
		{
			output("<i>“Enemy detected, " + attacker.mf("master", "mistress") + " " + attacker.uniqueName + "! I will defend you!”</i> Tam-wolf announces, leaping into the fray. He hits, biting ");
			if (target is PlayerCharacter) output(" you!");
			else output(target.a + target.uniqueName + ".");
			
			var d:Number = attacker.untypedDroneDamage();
			var dmg:TypeCollection = new TypeCollection( { kinetic: d, electric: d * 0.25 }, DamageFlag.PENETRATING);
			
			applyDamage(dmg, attacker, target, "minimal");
			if (attacker is PlayerCharacter) output(" Good boy!");
		}
		
		public static function ACECannonAttack(attacker:Creature, target:Creature):void
		{
			output("The gun on " + (attacker is PlayerCharacter ? "your" : possessive(attacker.uniqueName)) +" shoulder tracks towards " + (target is PlayerCharacter ? "you" : target.uniqueName) +", charging up with power. As " + (attacker is PlayerCharacter ? target.uniqueName : attacker.uniqueName) +" moves, it works on its own, targeting and firing at " + (target is PlayerCharacter ? "you" : target.mfn("him", "her", "it")) +".");
			
			if (target.reflexes() / 2 + rand(20) + 1 >= 35)
			{
				output(" The shot goes wide!");
			}
			else
			{
				output(" The shit hits!");
				
				var dmg:TypeCollection = new TypeCollection( { burning: attacker.untypedDroneDamage() * 1.33 }, DamageFlag.LASER);
				applyDamage(dmg, attacker, target, "minimal");
			}
		}
		
		public static function TamedVarmintAttack(attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("Your pet varmint hoots and hisses at " + target.a + target.uniqueName + ",");
			else output(attacker.mfn("His", "Her", "Its") + " pet varmint hoots and hisses at you,");
			if (attacker.isGrappled()) output(" pacing about defensively near " + (attacker is PlayerCharacter ? "you" : attacker.mfn("him", "her", "it")));
			else output(" standing protectively in front of " + (attacker is PlayerCharacter ? "you" : attacker.mfn("him", "her", "it")));
			output(" and raising its spiky hackles.");
			if (rand(10) <= 2)
			{
				output(" It lunges into battle, but it can’t find purchase on " + (attacker is PlayerCharacter ? "your foe" : "you") + "!");
			}
			else
			{
				if (attacker is PlayerCharacter) output(" It lunges towards " + target.a + target.uniqueName + ", shrieking like a banshee. Its fangs sink into your enemy, rending viciously at " + target.mfn("him", "her", "it") + "!");
				else output(" Shrieking like a banshee, it lunges towards you and its fangs sink in, rending at you viciously!");
				applyDamage(attacker.droneDamage(), attacker, target, "minimal");
			}
		}
		
		public static function GoovolverAttackImpl(attacker:Creature, target:Creature):void
		{
			if (attacker.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to attack until you remember that you’ve been disarmed!");
				else output(attacker.capitalA + attacker.uniqueName + " scrabbles about, trying to find " + attacker.mfn("his", "her", "its") + " missing weapon.");
				return;
			}
			
			SingleRangedAttackImpl(attacker, target, false, "goovolver");
		}
		
		public static function SlutRayAttackImpl(attacker:Creature, target:Creature):void
		{
			if (attacker.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to attack until you remember that you’ve been disarmed!");
				else output(attacker.capitalA + attacker.uniqueName + " scrabbles about, trying to find " + attacker.mfn("his", "her", "its") + " missing weapon.");
				return;
			}
			
			SingleRangedAttackImpl(attacker, target, false, "slut ray");
		}
		//} endregion
		
		
		public static var Headbutt:SingleCombatAttack;
		public static function HeadbuttImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter)
			{
				output("You lean back before whipping your head forward in a sudden headbutt.\n");
			}
			else
			{
				output(attacker.capitalA + attacker.uniqueName + " leans back before whipping " + attacker.mfn("his","her","its") + " head forward in a sudden headbutt.\n");
			}
	
			if (combatMiss(attacker, target))
			{
				if (attacker is PlayerCharacter)
				{
					if(target.customDodge.length == 0) output("You miss!");
					else output(target.customDodge);
				}
				else
				{
					output(attacker.mfn("He","She","It") + " misses.");
				}
			}
			//Extra miss for blind
			else if (attacker.hasStatusEffect("Blinded") && rand(2) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind strike fails to connect.");
				else output(attacker.mfn("His","Her","Its") + " blind strike fails to connect.");
			}
			//Attack connected!
			else
			{
				if (attacker is PlayerCharacter) output("You connect with your target!");
				else output(attacker.mfn("He", "She", "It") + " connects with you.");
		
				applyDamage(damageRand(new TypeCollection( { kinetic: attacker.physique() / 2 + attacker.level } ), 15), attacker, target, "headbutt");

				if (attacker.physique() / 2 + rand(20) + 1 >= target.physique() / 2 + 10 && !target.hasStatusEffect("Stunned") && !target.hasStatusEffect("Stun Immune")) 
				{
					if(target is PlayerCharacter) output("\n<b>You are stunned.</b>");
					else
					{
						if (target.isPlural) output("\n<b>" + target.capitalA + target.uniqueName + " are stunned.</b>");
						else output("\n<b>" + target.capitalA + target.uniqueName + " is stunned.</b>");
					}
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for a turn.", true, 0,0xFF0000);
				}
				else
				{
					if(attacker is PlayerCharacter) output("\nIt doesn't look to have stunned your foe!");
					else output("\nIt didn't manage to stun you.");
				}
			}
		}
		
		public static var RapidFire:SingleCombatAttack;
		private static function RapidFireImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			// Do regular attack (including multi-attack and additional flurry shots)
			RangedAttack(attacker, target);
			
			// Two bonus shots using flurry mechanics
			SingleRangedAttackImpl(attacker, target, true);
			SingleRangedAttackImpl(attacker, target, true);
		}
		
		public static var PowerStrike:SingleCombatAttack;
		private static function PowerStrikeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (combatMiss(attacker, target))
			{
				if (target.customDodge.length > 0) output(target.customDodge);
				else if (attacker is PlayerCharacter) output("You draw back your weapon and " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName + ", but just can't connect.");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " draws back their weapon and " + attacker.meleeWeapon.attackVerb + " at you, but just can't connect.");
				else output(attacker.capitalA + attacker.uniqueName + " draws back their weapon and " + attacker.meleeWeapon.attackVerb + " at " + target.a + target.uniqueName +", but just can't connect.");
				return;
			}
			
			if (attacker.hasStatusEffect("Blinded") && rand(10) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind power strike missed.");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind power strike missed.");
				
				return;
			}
			
			if (attacker is PlayerCharacter) output("You draw back your " + attacker.meleeWeapon.longName + " and land a hit on " + target.a + target.uniqueName + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " draws back " + attacker.mfn("his", "her", "its") + " " + attacker.meleeWeapon.longName + " and lands a hit on you!");
			else output(attacker.capitalA + attacker.uniqueName + " draws back " + attacker.mfn("his", "her", "its") + " " + attacker.meleeWeapon.longName + " and lands a hit on " + target.a + target.uniqueName + "!");
			
			var d:TypeCollection = attacker.meleeDamage();
			d.multiply(2);
			damageRand(d, 15);
			applyDamage(d, attacker, target);
		}
		
		public static var TakeCover:SingleCombatAttack;
		private static function TakeCoverImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You seek cover against ranged attacks.");
			else output(attacker.capitalA + attacker.uniqueName + " hunkers behind cover, defending themselves against ranged attacks!");
			
			attacker.createStatusEffect("Taking Cover", 4, 0, 0, 0, false, "DefenseUp", "Taking cover! Ranged attacks will almost always miss!", true);
		}
		
		public static var CarpetGrenades:SingleCombatAttack;
		private static function CarpetGrenadesImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You sling an array of microgrenades at everything in the area!");
			else output(attacker.capitalA + attacker.uniqueName + " throws out an array of microgrenades!");
			
			var d:int = 10 + (attacker.level * 2.5) + (attacker.intelligence() / 1.5);
			var damage:TypeCollection = new TypeCollection( { burning: d } );
			
			if (target is Cockvine)
			{
				kGAMECLASS.adultCockvineGrenadesInEnclosedSpaces(damage, true, false, false);
				//(damageValue:TypeCollection, pluralNades:Boolean = false, usedLauncher:Boolean = false, isLustGas:Boolean = false):void
			}
			
			for (var x:int = 0; x < hGroup.length; x++)
			{
				output("\n" + hGroup[x].capitalA + hGroup[x].uniqueName + " is caught in the explosion!");
				applyDamage(damageRand(damage, 15), attacker, hGroup[x], "minimal");
			}
		}
		
		public static var DetonationCharge:SingleCombatAttack;
		private static function DetonationChargeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You toss a bundle of explosives in the direction of " + target.a + target.uniqueName + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " throws a bundle of explosives in your direction!");
			else output(attacker.capitalA + attacker.uniqueName + " throws a bundle of explosives in " + target.a + possessive(target.uniqueName) + " direction!");
			
			var d:int = 15 + (attacker.level * 4) + attacker.intelligence();
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d } ), 15);
			
			if (target is Cockvine)
			{
				kGAMECLASS.adultCockvineGrenadesInEnclosedSpaces(damage, false, false, false);
				//(damageValue:TypeCollection, pluralNades:Boolean = false, usedLauncher:Boolean = false, isLustGas:Boolean = false):void
			}
			
			applyDamage(damage, attacker, target);
		}
		
		public static var SecondWind:SingleCombatAttack;
		private static function SecondWindImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			attacker.energy(Math.round(attacker.energyMax() / 2));
			attacker.HP(Math.round(attacker.HPMax() / 2));
			attacker.createStatusEffect("Used Second Wind", 0, 0, 0, 0, true, "", "", true, 0);
			
			if (attacker is PlayerCharacter) output("You draw on your innermost reserves of strength, taking a second wind!");
			else output(attacker.capitalA + attacker.uniqueName + " visibly focuses for a moment, finding themselves a second wind!");
		}
		
		public static var ParalyzingShock:SingleCombatAttack;
		private static function ParalyzingShockImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (target.hasStatusEffect("Paralyzed"))
			{
				if (target is PlayerCharacter) output("You're already paralyzed!");
				else output(target.capitalA + target.uniqueName + " is already paralyzed!");
				return;
			}
			
			if (attacker is PlayerCharacter) output("You launch a paralyzing shock at " + target.a + target.uniqueName + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " fires a paralyzing shock at you!");
			else output(attacker.capitalA + attacker.uniqueName + " fires a paralyzing shock at " + target.a + target.uniqueName + "!");
			
			if (attacker.intelligence() / 2 + rand(20) + 1 >= target.physique() / 2 + 10)
			{
				output("\nThe effect is immediate! ");
				if (target is PlayerCharacter) output(" You shudder and stop, temporarily paralyzed!");
				else output(target.capitalA + target.uniqueName + " shudders and stops, temporarily paralyzed.");
				target.createStatusEffect("Paralyzed", 2 + rand(2), 0, 0, 0, false, "Paralyze", "Cannot act!", true, 0);
			}
			else
			{
				output("\nIt has no effect!");
			}
		}
		
		public static var Volley:SingleCombatAttack;
		private static function VolleyImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			RangedAttack(attacker, target);
			SingleRangedAttackImpl(attacker, target, true);
			
			if (attacker.aim() / 2 + rand(20) + 1 >= target.reflexes() / 2 + 10 && !target.hasStatusEffect("Blinded") && attacker.hasRangedEnergyWeapon() && !target.hasBlindImmunity())
			{
				if (target is PlayerCharacter) output("\n<b>You are blinded by flashes from " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.longName + ".</b>");
				else if (attacker is PlayerCharacter) output("<b>" + target.capitalA + target.uniqueName + " is blinded by your " + possessive(attacker.rangedWeapon.longName) + " flashes.</b>\n");
				else output("<b>" + target.capitalA + target.uniqueName + " is blinded by flashes from " + attacker.a + possessive(attacker.uniqueName) + " " + attacker.rangedWeapon.longName + ".</b>");
				
				target.createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0,0xFF0000);
			}
		}
		
		public static var Overcharge:SingleCombatAttack;
		private static function OverchargeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (!(attacker is PlayerCharacter))
			{
				output(attacker.capitalA + attacker.uniqueName + " smiles as a high-pitched whine emanates from " + attacker.mfn("his", "her", "its") + " " + attacker.rangedWeapon.longName + "!");
			}
			
			if (rangedCombatMiss(attacker, target))
			{
				if (target.customDodge.length > 0) output(target.customDodge);
				else if (attacker is PlayerCharacter) output("You overcharge your weapon and " + attacker.rangedWeapon.attackVerb + " at " + target.a + target.uniqueName + ", but just can't connect.");
				else if (target is PlayerCharacter) output(" You manage to avoid the overcharged " + attacker.rangedWeapon.attackNoun + ".");
				else output(" " + target.capitalA + target.uniqueName + " manages to avoid the overcharged " + attacker.rangedWeapon.attackNoun + ".");
				return;
			}
			
			if ((attacker.hasStatusEffect("Blinded") || attacker.hasStatusEffect("Smoke Grenade")) && rand(10) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind-fired, overcharged shot missed!");
				else if (target is PlayerCharacter) output(attacker.capitalA + possessive(attacker.uniqueName) + " blind-fired, overcharged shot misses you!");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind-fired, overcharge shot narrowly avoids hitting anything!");
				return;
			}
			
			if (attacker is PlayerCharacter) output("You overcharge your " + attacker.rangedWeapon.longName + " and land a hit on " + target.a + target.uniqueName + "!");
			else output(" " + attacker.capitalA + attacker.uniqueName + " connects with " + attacker.mfn("his", "her", "its") + " overcharged " + attacker.rangedWeapon.attackNoun + "!");
			
			var d:TypeCollection = attacker.rangedDamage();
			
			if (attacker is PlayerCharacter)
			{
				if (attacker.hasPerk("Heroic Reserves")) d.multiply(2);
				else d.multiply(1.5);
			}
			else d.multiply(1.75);
			
			damageRand(d, 15);
			applyDamage(d, attacker, target, "minimal");
			
			if (attacker.intelligence() / 2 + rand(20) + 1 >= target.physique() / 2 + 10 && !target.hasStatusEffect("Stunned") && !target.hasStatusEffect("Stun Immune"))
			{
				output("\n");
				if (target is PlayerCharacter) output("<b>You are stunned!</b>");
				else output("<b>" + target.capitalA + target.uniqueName + " is stunned!</b>");
				target.createStatusEffect("Stunned", 1, 0, 0, 0, false, "Stun", "Cannot act for a turn.", true, 0,0xFF0000);
			}
		}
		
		public static var DeflectorRegeneration:SingleCombatAttack;
		private static function DeflectorRegenerationImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You fiddle with your shield, tuning it to regenerate over the next few turns.");
			else output(attacker.capitalA + attacker.uniqueName + " leans down to fiddle with their shield generator. The field responds, visibly bolstering as the emitters work harder to replenish the depleted field.");
			
			attacker.createStatusEffect("Deflector Regeneration", 4, Math.ceil((attacker.intelligence() * 1.5 + rand(attacker.level) + attacker.shieldsMax() * 0.25) / 4), 0, 0, false, "DefenseUp", "Recovering shields every round.", true, 0);
		}
		
		public static var PowerSurge:SingleCombatAttack;
		private static function PowerSurgeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You channel a surge of power into your shield generator, instantly restoring a portion of the emitters lost energy.");
			else output(attacker.capitalA + attacker.uniqueName + " channels a surge of power into " + attacker.mfn("his", "her", "its") + " shield generator, instantly restoring a portion of the lost energy.");
			
			var a:int = Math.ceil(attacker.intelligence() * 1.5 + rand(attacker.level) + attacker.shieldsMax() * 0.25);
			if (a + attacker.shields() > attacker.shieldsMax()) a = attacker.shieldsMax() - attacker.shields();
			
			attacker.shields(a);
			output(" (" + a + ")");
		}
		
		public static var ThermalDisruptor:SingleCombatAttack;
		private static function ThermalDisruptorImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("Raising the disruptor, you unleash a wave of burning fire on " + target.a + target.uniqueName + ".");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " spins a long device around from their back, levelling it squarely in your direction. In the blink of an eye it unleashes a wave of burning fire directly at you!");
			else output(attacker.capitalA + attacker.uniqueName + " spins a long device around from their back, levelling it at " + target.a + target.uniqueName + ", unleashing a wave of burning fire!");
			
			if (CombatManager.multipleEnemies())
			{
				output(" The flames surge, licking at your targets compatriots!");
			}
			
			var targetDamage:int = Math.round(20 + attacker.level * 4 + attacker.intelligence());
			var baseDamage:TypeCollection = new TypeCollection( { burning: targetDamage } );
			var pluralDamage:TypeCollection = new TypeCollection( { burning: targetDamage * 2 } );
			var totalDamage:DamageResult;
			
			totalDamage = applyDamage(damageRand((target.isPlural == true ? pluralDamage : baseDamage), 15), attacker, target, "suppress");
			
			baseDamage.multiply(0.33);
			pluralDamage.multiply(0.33);
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				if (hGroup[i] != target && !hGroup[i].isDefeated())
				{
					totalDamage.addResult(applyDamage(damageRand((target.isPlural == true ? pluralDamage : baseDamage), 15), attacker, hGroup[i], "suppress"));
				}
			}
			
			outputDamage(totalDamage);
		}
		
		public static var GravidicDisruptor:SingleCombatAttack;
		private static function GravidicDisruptorImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("Raising the disruptor, you unleash a targeted gravitic disruption on " + target.a + target.uniqueName);
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " spins a long device around from their back, levelling it squarely in your direction. Your limbs suddenly feel heavy, a crushing weight bearing down on you from all sides!");
			else output(attacker.capitalA + attacker.uniqueName + " spins a long device around from their back, levelling it at " + target.a + target.uniqueName + ", unleashing a targeted gravitic disruption in " + target.mfn("his", "her", "its") + " direction!");
			
			if (CombatManager.multipleEnemies())
			{
				output(" The disruption spreads to encompass a small, localized area neatly surrounding your enemies!");
			}
			
			var targetDamage:int = Math.round(15 + attacker.level * 2.5 + attacker.intelligence() / 1.5);
			var baseDamage:TypeCollection = new TypeCollection( { unresistablehp: targetDamage } );
			var pluralDamage:TypeCollection = new TypeCollection( { unresistablehp: targetDamage * 2 } );
			
			var totalDamage:DamageResult;
			
			totalDamage = applyDamage(damageRand((target.isPlural == true ? pluralDamage : baseDamage), 15), attacker, target, "suppress");
			
			baseDamage.multiply(0.33);
			pluralDamage.multiply(0.33);
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				if (hGroup[i] != target)
				{
					totalDamage.addResult(applyDamage(damageRand((target.isPlural == true ? pluralDamage : baseDamage), 15), attacker, hGroup[i], "suppress"));
				}
			}
			
			outputDamage(totalDamage);
		}
		
		public static var ShieldHack:SingleCombatAttack;
		private static function ShieldHackImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (target.shields() <= 0)
			{
				if (attacker is PlayerCharacter) output("You attempt to hack the nonexistent shield protecting " + target.a + target.uniqueName + "! It doesn't work - <b>there's no shield there.</b>");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " attempts to hack your shield! It doesn't work - <b>there's no shield there.</b>");
				else output(attacker.capitalA + attacker.uniqueName + " attempts to hack " + target.capitalA + possessive(target.uniqueName) + " shield! It doesn't work - <b>there's no shield there.</b>");
				return;
			}
			
			if (attacker is PlayerCharacter) output("You attempt to wirelessly hack the shield protecting " + target.a + target.uniqueName + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " attempts to wirelessly hack your shield!");
			else output(attacker.capitalA + attacker.uniqueName + " attempts to wirelessly hack the shield protecting " + target.a + target.uniqueName + "!");
			
			var d:TypeCollection = damageRand(new TypeCollection( { electric: Math.round(25 + attacker.level * 2.5 + attacker.intelligence() / 1.5) } ), 15);
			d.addFlag(DamageFlag.ONLY_SHIELD);
			
			var dr:DamageResult = calculateDamage(d, attacker, target, "suppress");
			
			if (target.shields() > 0)
			{
				if (target is PlayerCharacter) output(" Your shield crackles but holds.");
				else output(" " + target.capitalA + target.uniqueName + " crackles but holds.");
			}
			else
			{
				if (target is PlayerCharacter) output(" There is a concussive boom and a tingling aftershock of energy as your shield is breached.");
				else output(" There is a concussive boom and a tingling aftershock of energy as " + target.a + possessive(target.uniqueName) + " shield is breached.");
			}
			
			outputDamage(dr);
		}
		
		public static var WeaponHack:SingleCombatAttack;
		private static function WeaponHackImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (target.hasStatusEffect("Disarm Immune"))
			{
				if (attacker is PlayerCharacter) output("You try to hack " + target.a + possessive(target.uniqueName) + " weapon but can't. <b>It's physically impossible!</b>");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to hack your weapon but can't!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to hack " + target.a + possessive(target.uniqueName) + " weapon but can't. <b>It's physically impossible!</b>");
				return;
			}
			
			if (target.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to hack " + target.a + possessive(target.uniqueName) + " weapon but can't. <b>You've already hacked it!</b>");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to hack your weapon but can't!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to hack " + target.a + possessive(target.uniqueName) + " weapon but can't. <b>It's already been hacked!</b>");
				return;
			}
			
			if (!target.hasEnergyWeapon())
			{
				if (attacker is PlayerCharacter) output("You try to hack " + target.a + possessive(target.uniqueName) + " weapon but " + target.mfn("he", "she", "it") + " has no energy weapons to shut down!");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to hack your weapon but you don't have an energy weapon for them to shut down!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to hack " + target.a + possessive(target.uniqueName) + " weapon but " + target.mfn("he", "she", "it") + " has no energy weapons to shut down!");
				return;				
			}
			
			if (rand(20) + 1 + attacker.intelligence() / 2 < target.intelligence() / 2 + 10)
			{
				if (attacker is PlayerCharacter)
				{
					output("You try to hack " + target.a + possessive(target.uniqueName) + " weapon, but they're too smart and too quick!");
					if (attacker.intelligence() > target.intelligence() - 5) output(".. this time.");
				}
				else if (target is PlayerCharacter)
				{
					output(attacker.capitalA + attacker.uniqueName + " tries to hack your weapon, but you're quick to defend against the remote intrusion.");
					if (attacker.intelligence() > target.intelligence() - 5) output(".. this time.");
				}
				else
				{
					output(attacker.capitalA + attacker.uniqueName + " tries to hack " + target.a + possessive(target.uniqueName) + " weapon, but they react quickly and defend against the attack!");
				}
				return;
			}
			
			// Successful
			
			if (attacker is PlayerCharacter) output("You hack " + target.a + possessive(target.uniqueName) + " weapon, disarming them.");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " hacks your weapon, disarming you temporarily!");
			else output(attacker.capitalA + attacker.uniqueName + " hacks " + target.a + possessive(target.uniqueName) + " weapon, disarming " + target.mfn("him", "her", "it") + ".");
			
			target.createStatusEffect("Disarmed", 4 + rand(2), 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", true, 0,0xFF0000);
		}
		
		public static var PocketSand:SingleCombatAttack;
		private static function PocketSandImp(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var aTarget:Creature = GetBestPotentialTarget(hGroup);
			
			output("With a cry of <i>“Pocket sand!”</i> you produce a handful of sand and throw it at " + aTarget.a + aTarget.uniqueName + ".");
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				if (hGroup[i].isDefeated()) continue;
				
				var cTarget:Creature = hGroup[i] as Creature;
				
				if (attacker.aim() / 2 + rand(20) + 6 >= cTarget.reflexes() / 2 + 10 && !cTarget.hasStatusEffect("Blinded") && !cTarget.hasBlindImmunity())
				{
					cTarget.createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0,0xFF0000);
					
					output("\n<b>" + cTarget.capitalA + cTarget.uniqueName + " is blinded by the coarse granules.</b>");
				}
				else
				{
					output("\n" + cTarget.capitalA + cTarget.uniqueName + " manages to keep away from the blinding particles.");
				}
			}
		}
		
		public static var FlashGrenade:SingleCombatAttack;
		private static function FlashGrenadeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var aTarget:Creature = GetBestPotentialTarget(hGroup);
			
			if (attacker is PlayerCharacter) output("You produce one of your rechargeable flash grenades and huck it in the direction of " + aTarget.a + aTarget.uniqueName + ".");
			else if (aTarget is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " produces a flash grenade and hucks it in your direction!");
			else output(attacker.capitalA + attacker.uniqueName + " produces a flash grenade and hucks it in the direction of " + aTarget.a + aTarget.uniqueName + "!");
			
			for (var i:int = 0; i < hGroup.length; i++)
			{	
				if (hGroup[i].isDefeated()) continue;
				
				var cTarget:Creature = hGroup[i];
				
				if (attacker.aim() / 2 + rand(20) + 6 >= cTarget.reflexes() / 2 + 10 && !cTarget.hasStatusEffect("Blinded") && !cTarget.hasBlindImmunity())
				{
					cTarget.createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0,0xFF0000);
					
					if (cTarget is PlayerCharacter) output("\n<b>You're blinded by the luminous flashes.</b>");
					else output("\n<b>" + cTarget.capitalA + cTarget.uniqueName + " is blinded by the luminous flashes.</b>");
				}
				else
				{
					if (cTarget is PlayerCharacter) output("\nYou manage to avoid the blinding projectile.");
					else output("\n" + cTarget.capitalA + cTarget.uniqueName + " manages to avoid the blinding projectile.");
				}
			}
		}
		
		public static var LowBlow:SingleCombatAttack;
		private static function LowBlowImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You swing low, aiming for a sensitive spot.");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " swings low at you, aiming for a sensitive spot.");
			else output(attacker.capitalA + attacker.uniqueName + " swings low at " + target.a + target.uniqueName + ", aiming for a sensitive spot.");
			output("\n");
			
			if (combatMiss(attacker, target))
			{
				if (target.customDodge.length > 0) output(target.customDodge);
				else if (attacker is PlayerCharacter) output("You miss!");
				else output("You narrowly avoid the attack!");
			}
			else if (attacker.hasStatusEffect("Blinded") && rand(2) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind strike fails to connect.");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind strike fails to connect.");
			}
			else
			{
				if (attacker is PlayerCharacter) output("You connect with your target!");
				else if (target is PlayerCharacter) output(attacker.capitalA + possessive(attacker.uniqueName) + " strike connects with you!");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " strike connects with " + target.a + target.uniqueName + "!");
				
				applyDamage(damageRand(new TypeCollection( { kinetic: attacker.physique() / 2 } ), 15), attacker, target, "minimal");
				
				if ((attacker.physique() / 2 + rand(20) + 1 >= target.physique() / 2 + 10 && !target.hasStatusEffect("Stunned") && !target.hasStatusEffect("Stun Immune")) || target is Kaska)
				{
					if (target is Kaska)
					{
						output("\nKaska's eyes cross from the overwhelming pain. She sways back and forth like a drunken sailor before hitting the floor with all the grace of a felled tree. A high pitched squeak of pain rolls out of her plump lips. <b>She's very, very stunned.</b>");
						target.createStatusEffect("Stunned", 3 + rand(2), 0, 0, 0, false, "Stun", "Cannot act for a while. You hit her balls pretty hard!", true, 0,0xFF0000);
					}
					else
					{
						if (target is PlayerCharacter)
						{
							output("\n<b>You are stunned!</b>");
						}
						else
						{
							output("\n<b>" + target.capitalA + target.uniqueName + " is stunned.</b>");
						}
						
						target.createStatusEffect("Stunned", 2 + rand(2), 0, 0, 0, false, "Stun", "Cannot act for a while.", true, 0,0xFF0000);
					}
				}
				else
				{
					if (attacker is PlayerCharacter)
					{
						output("\nIt doesn't look like you accomplished much more than hitting your target.");
					}
					// potential outputs for other targets/the player not getting stunned
				}
			}
		}
		
		public static var DisarmingShot:SingleCombatAttack;
		private static function DisarmingShotImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (target.hasStatusEffect("Disarm Immune"))
			{
				if (attacker is PlayerCharacter) output("You try to disarm " + target.a + target.uniqueName + " but can't. <b>It's physically impossible!</b>");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to disarm you but can't!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to disarm " + target.a + target.uniqueName + " but can't. <b>It's physically impossible!</b>");
				return;
			}
			
			if (target.hasStatusEffect("Disarmed"))
			{
				if (attacker is PlayerCharacter) output("You try to disarm " + target.a + target.uniqueName + " but can't. <b>They've already been disarmed!</b>");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to disarm you but can't!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to disarm " + target.a + target.uniqueName + " but can't. <b>They've already been disarmed!</b>");
				return;
			}
			
			if (rangedCombatMiss(attacker, target))
			{
				if (attacker is PlayerCharacter) output("You try to disarm " + target.a + target.uniqueName + " but miss.");
				else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tries to disarm you but they narrowly miss the opportunity!");
				else output(attacker.capitalA + attacker.uniqueName + " tries to disarm " + target.a + target.uniqueName + " but they miss the shot!");
				return;
			}
			
			if ((attacker.hasStatusEffect("Blinded") || attacker.hasStatusEffect("Smoke Grenade")) && rand(10) > 0)
			{
				if (attacker is PlayerCharacter) output("Your blind-fired shot fails to connect.");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " blind-fired shot fails to connect.");
				return;
			}
			
			// Hits
			if (attacker is PlayerCharacter) output("You land a crack shot on " + target.a + possessive(target.uniqueName) + " weapon, disarming them.");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " shoots your weapons away with well-placed shots!");
			else output(attacker.capitalA + attacker.uniqueName + " shoots " + target.a + possessive(attacker.uniqueName) + " weapons away with well-placed shots!");
			
			target.createStatusEffect("Disarmed", 4, 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", true, 0,0xFF0000);
		}
		
		public static var StealthFieldGenerator:SingleCombatAttack;
		private static function StealthFieldGeneratorImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var rounds:int = 0;
			
			if (attacker is PlayerCharacter)
			{
				output("You activate your stealth field generator, fading into nigh-invisibility.");
				rounds = 3;
			}
			else
			{
				output(attacker.capitalA + attacker.uniqueName + " activates a stealth field generator, fading into nigh-invisibility.");
				rounds = 4;
			}
			
			attacker.createStatusEffect("Stealth Field Generator", rounds, 0, 0, 0, false, "DefenseUp", "Provides a massive bonus to evasion chances!", true, 0);
		}
		
		public static var Grenade:SingleCombatAttack;
		private static function GrenadeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var aTarget:Creature = GetBestPotentialTarget(hGroup);
			
			if (attacker is PlayerCharacter) output("Tossing an explosive in the general direction of your target, you unleash an explosive blast of heat on " + aTarget.a + aTarget.uniqueName + "!");
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " hucks a small device in your direction, unleashing an explosive blast scant inches from your body!");
			else output(attacker.capitalA + attacker.uniqueName + " hucks a small device in " + aTarget.a + possessive(aTarget.uniqueName) + " direction, unleashing an explosive blast scant inches from " + aTarget.mfn("his", "her", "its") + " form!");
				
			var d:int = Math.round(7.5 + attacker.level * 2 + attacker.intelligence() / 2);
			var totalDamage:DamageResult = new DamageResult();
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				var cTarget:Creature = hGroup[i];
				if (cTarget.isDefeated()) continue;
				
				var damage:TypeCollection = damageRand(new TypeCollection( { kinetic: d, burning: d } ), 15);
				
				if (cTarget is Cockvine)
				{
					kGAMECLASS.adultCockvineGrenadesInEnclosedSpaces(damage, false, false, false);
				}
				
				totalDamage.addResult(applyDamage(damage, attacker, cTarget, "suppress"));
			}
			
			outputDamage(totalDamage);
		}
		
		public static var GasGrenade:SingleCombatAttack;
		private static function GasGrenadeImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var aTarget:Creature = GetBestPotentialTarget(hGroup);
			
			if (attacker is PlayerCharacter) output("Tossing a hissing grenade in the general direction of your target, you watch the gaseous stuff do its trick.");
			else if (aTarget is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " tosses a small device in your direction, great clouds of thick, gaseous vapour pouring from within its body.");
			else output(attacker.capitalA + attacker.uniqueName + " tosses a small device in " + aTarget.a + possessive(aTarget.uniqueName) + " direction, a thick trail of gasous vapour hanging heavily in the air to demark the arcing path taken.");
			
			var d:int = 14 + attacker.level * 2;
			var totalDamage:DamageResult = new DamageResult();
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				var cTarget:Creature = hGroup[i] as Creature;
				
				if (cTarget.isDefeated()) continue;
				
				var damage:TypeCollection = damageRand(new TypeCollection( { drug: d } ), 15);
				
				if (cTarget is Cockvine)
				{
					kGAMECLASS.adultCockvineGrenadesInEnclosedSpaces(damage, false, false, true);
				}
				
				totalDamage.addResult(applyDamage(damage, attacker, cTarget, "suppress"));
			}
			
			outputDamage(totalDamage);
		}
		
		public static var SmuggledStimulant:SingleCombatAttack;
		private static function SmuggleStimulatImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("Used Smuggled Stimulant", 3, 0, 0, 0, true, "", "", true, 0);
			
			if (attacker is PlayerCharacter) output("You inject yourself with a smuggled stimulant.");
			else output(attacker.capitalA + attacker.uniqueName + " jams a small injector deep into their thigh, the stature visibly filling with energy!");
		}
		
		public static var BurstOfEnergy:SingleCombatAttack;
		private static function BurstOfEnergyImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			attacker.energy(60);
			attacker.createStatusEffect("Used Burst of Energy", 0, 0, 0, 0, true, "", "", true, 0);
			
			if (attacker is PlayerCharacter) output("You dig deep and find a reserve of energy from deep within yourself!\n");
			else output(attacker.capitalA + attacker.uniqueName + " visibly steels " + attacker.mfn("himself", "herself", "itself") + ", reaching deep and finding a reserve of energy!");
		}
		
		public static var ConcussiveShot:SingleCombatAttack;
		private static function ConcussiveShotImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) output("You nock one of your concussive arrows and draw your bowstring back, taking careful aim at the space just ahead of " + target.a + target.uniqueName + ".");
			else throw new Error("Concussive Shot does not support a non-player attacker!");
			
			if (rangedCombatMiss(attacker, target, 0))
			{
				if (attacker is PlayerCharacter) output(" You let fly, but the arrow sails clean past your intended target.");
			}
			else if (attacker.hasStatusEffect("Blinded") && rand(10) > 0)
			{
				if (attacker is PlayerCharacter) output(" Your blind <b>concussion shot</b> missed.");
			}
			else
			{
				if (attacker is PlayerCharacter) output(" You let fly, and a moment later, the arrow explodes in a shockwave of force");
				
				if (target.physique()/2 + rand(20) + 1 >= attacker.aim()/2 + 10)
				{
					output(" though " + target.a + target.uniqueName + " resists the blast. Your stun-shot failed!");
				}
				else
				{
					output(", stunning your enemy!");
					
					var rounds:int = 1 + rand(2);
					target.createStatusEffect("Stunned",rounds,0,0,0,false,"Stun","Cannot act for "+ rounds +" turns.",true,0,0xFF0000);
				}
				
				// Add some burning damage for the explosion
				var damage:TypeCollection = attacker.rangedDamage();
				damage.add(new TypeCollection( { burning: 10 } ));
				damage = damageRand(damage,15);
				applyDamage(damage, attacker, target, "ranged");
			}
		}
		
		public static var GoozookaAttack:SingleCombatAttack;
		private static function GoozookaAttackImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			attacker.destroyItem(new GrayMicrobots(), 1);
	
			output("You pull the goo launcher from over your shoulder and slam a vial of Gray Goo into the back. You brace yourself, sighting in on your target and flipping the ON switch. The launcher beeps, and you pull the trigger, sending a great big blob of gray goop hurtling toward your opponent!");
			
			if (rangedCombatMiss(attacker, target, 0))
			{
				// Missed
				output("\n\nHowever the goo sample goes wide, splattering on the ground a little ways away. A moment later, a miniature gray googirl congeals from the mess, looks around, and starts hauling ass away from the fight. Whoops.");
			}
			else
			{
				var damage:TypeCollection;
				var damageResult:DamageResult
				
				// Hit
				if (target is GrayGoo)
				{
					output("\n\nAlthough you probably should have thought this plan through a little better before actioning it; firing Gray Goo samples <i>at a Gray Goo</i> might not have been the smartest choice. All you seem to have achieved is bolstering the strength of your foe!\n");
					
					var heal:Number = target.HPMax() * 0.2;
					if (target.HP() + heal > target.HPMax()) heal = target.HPMax() - target.HP();
					
					damage = new TypeCollection( { tease: 5 } );
					damageResult = applyDamage(damage, attacker, target, "suppress");
					
					output("The Gray Goo absorbs her smaller twin on contact.");
					output(" (Heals " + heal + ")");
					
					target.HP(heal);
				}
				else
				{
					output("\n\nThe gray goo splatters across " + target.a + target.uniqueName + ", quickly congealing into a miniature googirl who quickly goes to work, attacking your enemy's most sensitive spots with gusto. ");
				
					damage = new TypeCollection( { tease: 33 } );
					damageResult = applyDamage(damage, attacker, target, "suppress");
					output("\n");
					output(CombatContainer.teaseReactions(damageResult.lustDamage, target));
				}
				
				outputDamage(damageResult);
			}
		}
		
		public static var WrenchAttack:SingleCombatAttack;
		private static function WrenchAttachImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			//Charged attack!
			if(!attacker.hasStatusEffect("Wrench Charge"))
			{
				output(attacker.capitalA + attacker.uniqueName + " hefts her wrench up over her head, readying a powerful downward stroke. If you act quickly, you can interrupt her!");
				attacker.createStatusEffect("Wrench Charge", attacker.HP(),0,0,0);
			}
			//Already charged, lets do this!
			else
			{
				//Interrupted
				if(attacker.statusEffectv1("Wrench Charge") > attacker.HP()) output(attacker.capitalA + attacker.uniqueName + " staggers, dropping her heavy weapon down from its striking posture. She looks less than pleased by this development!");
				//Miss
				else if(combatMiss(attacker, target))
				{
					output(attacker.capitalA + attacker.uniqueName + " brings her weapon down in a vicious two-handed strike but fails to connect!");
				}
				//Hit
				else
				{
					//[enemy.short][capital]
					output(attacker.capitalA + attacker.uniqueName + " slams down her wrench in a heavy blow. It connects solidly, and your head is ringing from the brutal hit.");
					//{Stun chance}
					if (!target.hasStatusEffect("Stunned") && target.physique() + rand(20) + 1 < 40)
					{
						output("<b> The hit was hard enough to stun you!</b>");
						target.createStatusEffect("Stunned",1,0,0,0,false,"Stun","You are stunned and cannot move until you recover!",true,0,0xFF0000);
					}
					var damage:TypeCollection = attacker.meleeDamage();
					damage.multiply(2);
					damageRand(damage, 15);
					applyDamage(damage, attacker, target);
				}
				attacker.removeStatusEffect("Wrench Charge");
			}
		}
		
		public static var TripAttack:SingleCombatAttack;
		private static function TripAttackImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			output(attacker.capitalA + attacker.uniqueName + " tries to trip you! ");
			if (target.reflexes()/2 + rand(20) + 1 >= attacker.physique()/2 + 10) output("You neatly hop over the misguided attempt.");
			else
			{
				output("You go down to the ground! <b>You're going to have a difficult time fighting from down here!</b>");
				target.createStatusEffect("Tripped", 0, 0, 0, 0, false, "DefenseDown", "You've been tripped, reducing your effective physique and reflexes by 4. You'll have to spend an action standing up.", true, 0);
				
				applyDamage(new TypeCollection( { kinetic: 1 } ), attacker, target);
			}
		}
		
		public static var AphrodisiacDarts:SingleCombatAttack;
		private static function AphrodisiacDartsImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			var damage:int = 0;
			var hit:Boolean = true;
			//Hacky-ass solution for male raskvel. Will need tweaked if a proper mob ever uses the attack
			if(attacker is RaskvelMale) output("<i>“Boo! Raaaaar!”</i> shouts the big raskvel, waving his arms at you. At the same time, one of the others pulls an injector gun from his belt and fires three needles at you near soundlessly.")
			else output(attacker.capitalA + attacker.uniqueName + " pulls a gun off her hip, levels it, and pulls the trigger. The only reports are a trio of near-silent hisses as three injectors fly through the air toward you.");
			//Blocked
			if(target.shields() > 0) 
			{
				output("\nThe needles break apart uselessly on contact with your defenses.");
				hit = false;
			}
			//Miss (can't be completely dodged)
			else if(rangedCombatMiss(attacker, target)) 
			{
				output("\nYou manage to avoid most of the projectiles, but one still impacts your arm, stinging you with a pinprick of pain. You yank it out, but its payload is already spent, injected inside you.");
				applyDamage(new TypeCollection( { tease: 3 + rand(3) } ), attacker, target, "minimal");
			}
			//Medium hit
			else if(rangedCombatMiss(attacker, target))
			{
				output("\nTwo needles slam into your body, imparting bursts of searing pain when they penetrate your flesh. You yank them out in irritation, but whatever they contained is inside you now.");
				applyDamage(new TypeCollection( { tease: 7 + rand(3) } ), attacker, target, "minimal");
			}
			//Full Hit
			else
			{
				output("\nAll three needles hit you before you can react.");
				applyDamage(new TypeCollection( { tease: 11 + rand(3) } ), attacker, target, "minimal");
			}
			//Reactions
			if(hit)
			{
				output("\n\n");
				if(target.lust() < 33) output("An unwelcome heat suffuses your body as the chemicals do their work.");
				else if(target.lust() < 45) output("Your heart beats faster as you look at your foe's body." + attacker.mf("","Her outfit seems a bit more revealing, and her movements seem more sexually enticing than ever before."));
				else if(target.lust() < 55) 
				{
					if(target.hasCock()) 
					{
						output("[pc.EachCock] pulsates as it fills with burgeoning tumescence.");
						if(attacker is RaskvelFemale) output(" You find yourself wondering what it would be like to slip into her puffy, double-clitted box.");
					}
					else if(target.hasVagina()) output("[pc.EachVagina] grows sensitive and moist as you ponder the merits of fucking this fetching little lizard-" + attacker.mf("man","woman") + ".");
					else output("Your [pc.nipples] harden as you idly consider forcing " + attacker.mf("him","her") + " to lick you while suckling on " + attacker.mf("his reptilian tool.","her twin clits."));
				}
				else if(target.lust() < 65) output("You groan out loud as the aphrodisiacs surges through your bloodstream, rousing you into a " + target.rawmf("rut","heat") + " that you have have a hard time suppressing.");
				else if(target.lust() < 75) output(target.mf("Grunting","Whimpering") + " in anticipation of what is to come, you ball your hands into fists as you try to endure the rising need as it spreads through your body. It feels like your brain is oozing down into your crotch, fixating utterly on sex. You want to fuck right now. You NEED to fuck soon.");
				else if(target.lust() < 85) output("You stagger as the lust hits you, stirring your already aroused body to new heights of need. Your [pc.legs] tremble, and the desperate, animal need to copulate thrums through your quivering muscles, filling them with an artificial desire.");
				else if(target.lust() < 95) 
				{
					output("The payload has its way with your aroused body as it rushes through your veins. It acts quickly, like other intravenious drugs, turning you on with each beat of your heart.");
					if(target.hasCock() || target.hasVagina()) output(" Your genitals drip with need as y");
					else output(" Y");
					output("ou idly consider throwing the fight for a quick fuck.");
				}
				else output("You whimper as the drugs pour through your body and melt your resistance into a bubbling puddle of distilled fuck. Your body is hot, feverish even, and you lose the will to resist as the absolute need to tend to your state asserts itself.");
			}
			if(target.lust() < target.lustMax() && attacker is RaskvelMale)
			{
				target.createStatusEffect("Attempt Seduction", 0, 0, 0, 0, true, "", "", true, 0);
			}
		}
		
		/////////////////////////
		////    CoC magic    ////
		/////////////////////////
		
		public static var ChargeWeapon:SingleCombatAttack;
		private static function ChargeWeaponImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			kGAMECLASS.clearList();
			if (attacker.hasMeleeWeapon()) kGAMECLASS.addToList(attacker.meleeWeapon.longName);
			if (attacker.hasRangedWeapon()) kGAMECLASS.addToList(attacker.rangedWeapon.longName);
			var weapon:String = kGAMECLASS.formatList();
			if (weapon.length == 0) weapon = attacker.meleeWeapon.longName;
			
			if (attacker is PlayerCharacter) {
				output("You utter words of power, summoning an electrical charge around your " + weapon + ".  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.");
			}
			else output(attacker.capitalA + attacker.uniqueName + " utters words of power, summoning an electrical charge around " + target.mfn("his", "her", "its") + " " + weapon + ".");
			
			attacker.createStatusEffect("Charge Weapon", attacker.intelligence() / 1.5 + 20, 0, 0, 0, false, "OffenseUp", "Infused with power of lightning!", true, 0, 0xFFFF00);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Blind:SingleCombatAttack;
		private static function BlindImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			var aTarget:Creature = GetBestPotentialTarget(hGroup);
			
			if (attacker is PlayerCharacter) output("You glare at " + aTarget.a + aTarget.uniqueName + " and point at " + aTarget.mfn("him", "her", "it") + ".  A bright flash erupts before " + aTarget.mfn("him", "her", "it") + "!")
			else if (aTarget is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " points point at you.  A bright flash erupts before your eyes!")
			else output(attacker.capitalA + attacker.uniqueName + " points at " + aTarget.a + aTarget.uniqueName + ".  A bright flash erupts before " + aTarget.mfn("him", "her", "it") + "!");
			
			for (var i:int = 0; i < hGroup.length; i++)
			{	
				if (hGroup[i].isDefeated()) continue;
				
				var cTarget:Creature = hGroup[i];
				
				if (cTarget.hasStatusEffect("Blinded"))
				{
					if (cTarget is PlayerCharacter) output("\nYou are already blinded.");
					else output("\n" + cTarget.capitalA + cTarget.uniqueName + " is already blinded.");
				}
				else if(attacker.intelligence() / 2 + rand(20) + 6 >= cTarget.reflexes() / 2 + 10)
				{
					cTarget.createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
					
					if (cTarget is PlayerCharacter) output("\n<b>You're blinded by the luminous flash.</b>");
					else output("\n<b>" + cTarget.capitalA + cTarget.uniqueName + " is blinded by the luminous flash.</b>");
				}
				else
				{
					if (cTarget is PlayerCharacter) output("\nYou manage to close your eyes just in time.");
					else output("\n" + cTarget.capitalA + cTarget.uniqueName + " blinked!");
				}
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Whitefire:SingleCombatAttack;
		private static function WhitefireImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (attacker is PlayerCharacter) {
				output("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + target.a + target.uniqueName + " is enveloped in a flash of white flames!  ");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " throws a white flame flame at you!  ");
			else output(attacker.capitalA + attacker.uniqueName + " throws a white flame at " + target.a + target.uniqueName + "!  ");
			
			var d:int = 10 + attacker.intelligence() + rand(attacker.intelligence());
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d * attacker.spellMod() } ), 15);
			
			applyDamage(damage, attacker, target);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Arouse:SingleCombatAttack;
		private static function ArouseImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) {
				output("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!  ");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " makes a series of arcane gestures, drawing on " + attacker.mfn("his", "her", "its") + " own lust to inflict it upon you!  ");
			else output(attacker.capitalA + attacker.uniqueName + " makes a series of arcane gestures, drawing on " + attacker.mfn("his", "her", "its") + " own lust to inflict it upon " + target.a + target.uniqueName + "!  ");
			
			
			if (target.isLustImmune) {
				output("It has no effect!  Your foe clearly does not experience lust in the same way as you.  ");
				return;
			}
			
			var lustDmg:Number = attacker.intelligence() / 2.5 * attacker.spellMod() + rand(target.libido() - target.intelligence() + target.cor()) / 5;
			
			if (lustDmg <= 0) {
				output("It has no effect!  ");
				return;
			}
			
			var damage:TypeCollection = new TypeCollection( { psionic : lustDmg } );
			var damageResult:DamageResult = applyDamage(damage, attacker, target, "suppress");
			
			output("\n");
			var reaction:String = CombatContainer.teaseReactions(damageResult.lustDamage, target);
			if (reaction == "ABORT") return;
			output(reaction);
			
			outputDamage(damageResult);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Heal:SingleCombatAttack;
		private static function HealImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) {
				output("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.  ");
			}
			else output(attacker.capitalA + attacker.uniqueName + " visibly focuses for a moment, trying to draw on " + attacker.mfn("his", "her", "its") + " own lust to close " + attacker.mfn("his", "her", "its") + " wounds. ");
			
			var backfire:int = 25 + attacker.lustQ() - attacker.WQ();
			if (rand(100) < backfire) {
				if (attacker is PlayerCharacter) {
					output("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
					if (!attacker.hasGenitals()) output("[pc.asshole] tingles with a desire to be filled as your libido spins out of control.  ");
					else if (attacker.isHerm()) output("[pc.vagina] and [pc.cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.  ");
					else if(attacker.hasCock()) {
						if (attacker.cockTotal() == 1) output("[pc.cocks] twitches obscenely and drips with pre-cum as your libido spins out of control.  ");
						else output("[pc.cocks] twitch obscenely and drip with pre-cum as your libido spins out of control.  ");
					}
					else if (attacker.hasVagina()) output("[pc.vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it.  ");
					attacker.slowStatGain("l", 0.25);
				}
				else {
					output(attacker.capitalA + attacker.uniqueName + " has failed miserably!  ");
				}
				applyDamage(new TypeCollection( { truelust : 15 } ), attacker, attacker, "minimal");
			}
			else {
				if (attacker is PlayerCharacter) output("You flush with success as your wounds begin to knit.  ");
				else output(attacker.capitalA + possessive(attacker.uniqueName) + " wounds begin to knit!  ");
				var hp:Number = int(attacker.level + (attacker.intelligence() / 1.5) + rand(attacker.intelligence()))
				hp *= attacker.spellMod();
				attacker.HP(Math.round(hp));
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Might:SingleCombatAttack;
		private static function MightImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) {
				output("You flush, drawing on your body's desires to empower your muscles and toughen you up.  ");
			}
			else output(attacker.capitalA + attacker.uniqueName + " visibly focuses for a moment, trying to draw on " + attacker.mfn("his", "her", "its") + " own lust to toughen up.  ");
			
			var backfire:int = 25 + attacker.lustQ() - attacker.WQ();
			if (rand(100) < backfire) {
				if (attacker is PlayerCharacter) {
					output("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
					if (!attacker.hasGenitals()) output("[pc.asshole] tingles with a desire to be filled as your libido spins out of control.  ");
					else if (attacker.isHerm()) output("[pc.vagina] and [pc.cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.  ");
					else if(attacker.hasCock()) {
						if (attacker.cockTotal() == 1) output("[pc.cocks] twitches obscenely and drips with pre-cum as your libido spins out of control.  ");
						else output("[pc.cocks] twitch obscenely and drip with pre-cum as your libido spins out of control.  ");
					}
					else if (attacker.hasVagina()) output("[pc.vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it.  ");
					attacker.slowStatGain("l", 0.25);
				}
				else {
					output(attacker.capitalA + attacker.uniqueName + " has failed miserably!  ");
				}
				applyDamage(new TypeCollection( { truelust : 15 } ), attacker, attacker, "minimal");
			}
			else {
				if (attacker is PlayerCharacter) output("The rush of success and power flows through your body.  You feel like you can do anything!");
				else output(attacker.capitalA + attacker.uniqueName + " is now stronger!  ");
				// +physique, +HP
				attacker.createStatusEffect("Might", Math.max(attacker.intelligence() / 2, 10), Math.max(attacker.intelligence(), 20), 0, 0, false, "OffenseUp", "Infused with power of desire!", true, 0, 0x00FF00);
				attacker.HP(Math.max(attacker.intelligence(), 20));
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var CleansingPalm:SingleCombatAttack;
		private static function CleansingPalmImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			var corruptionMulti:Number = (target.personality - 20) / 25;
			if (corruptionMulti > 1.5) {
				corruptionMulti = 1.5;
				corruptionMulti += (target.personality / 100); //The increase to multiplier is diminished.
			}
			
			if (attacker is PlayerCharacter) {
				if (target is CoCJojo && target.personality == 0) {
					output("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out.");
					output(kGAMECLASS.onSpellCast(attacker));
					return;
				}
				if (target is CoCLivingStatue) {
					output("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue- to no effect!");
					output(kGAMECLASS.onSpellCast(attacker));
					return;
				}
				if (corruptionMulti == 0) {
					output("You thrust your palm forward, causing a blast of pure energy to slam against " + target.a + target.uniqueName + ", which " + (target.isPlural ? "they" : target.mfn("he", "she", "it")) + " ignore. It is probably best you don’t use this technique against the pure.");
					output(kGAMECLASS.onSpellCast(attacker));
					return;
				}
				output("You thrust your palm forward, causing a blast of pure energy to slam against " + target.a + target.uniqueName + ", tossing " + (target.isPlural ? "them" : target.mfn("him", "her", "it")) + " back a few feet.");
				if (kGAMECLASS.silly && corruptionMulti >= 1.75) output(" It's super effective!");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " thrusts " + target.mfn("his", "her", "its") + " palm forward, causing a blast of pure energy towards you!");
			else output(attacker.capitalA + attacker.uniqueName + " thrusts " + attacker.mfn("his", "her", "its") + " palm forward, causing a blast of pure energy towards " + target.a + target.uniqueName + "!");
			
			
			// 10+(player.inte/3 + rand(player.inte/2)) * spellMod()
			var d:int = attacker.intelligence() / 4 + rand(attacker.intelligence() / 3);
			d *= attacker.spellMod();
			d *= corruptionMulti;
			var damage:TypeCollection = damageRand(new TypeCollection( { truedamage : d } ), 15);
			
			applyDamage(damage, attacker, target, "minimal");
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var DragonFire:SingleCombatAttack;
		private static function DragonFireImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			attacker.createStatusEffect("DragonfireCD", 0, 0, 0, 0, true, "Blocked", "Dragonfire is not available yet.", false, 24 * 60);
			
			if (attacker is PlayerCharacter) {
				output("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + target.a + target.uniqueName + "!");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling tornado of fire directly at you");
			else output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling tornado of fire directly at " + target.a + possessive(target.uniqueName) + "!");
			
			if (rangedCombatMiss(attacker, target, -1, 0.33)) {
				if (target is PlayerCharacter) output("You manage to sidestep the flames in the nick of time.  ");
				else if (attacker is PlayerCharacter) output("  Despite the heavy impact caused by your roar, " + target.a + target.uniqueName + " manages to take it at an angle and is ready to keep fighting.");
				else output("  Despite the heavy impact caused by " + attacker.a + possessive(attacker.uniqueName) + " roar, " + target.a + target.uniqueName + " manages to take it at an angle and is ready to keep fighting.");
				return;
			}
			
			var d:int = 25 + attacker.level * 8 + rand(10);
			if (attacker.hasStatusEffect("DragonBreathBoost")) d *= 1.25;
			
			if(target.hasStatusEffect("Sandstorm")) {
				output("  <b>Breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
				d *= 0.2;
			}
			
			var damage:TypeCollection = damageRand(new TypeCollection( { kinetic : d }, DamageFlag.EXPLOSIVE, DamageFlag.BYPASS_SHIELD ), 15);
			
			if (attacker is PlayerCharacter) output("  " + target.capitalA + target.short + " reels as your wave of force slams into " + target.mfn("him", "her", "it") + " like a ton of rock!  ");
			else if (target is PlayerCharacter) output("  You reel as " + attacker.a + possessive(attacker.uniqueName) + " wave of force slams into you like a ton of rock!  ");
			else output("  " + target.capitalA + target.short + " reels as " + attacker.a + possessive(attacker.uniqueName) + " wave of force slams into " + target.mfn("him", "her", "it") + " like a ton of rock!  ");
			
			if(!target.hasStatusEffect("Stun Immune") && (attacker.hasStatusEffect("DragonBreathBoost") || rand(5) != 0)) {
				output("  The impact sends " + target.mfn("him", "her", "it") + " crashing to the ground, too dazed to strike back.  ");
				target.createStatusEffect("Stunned", attacker.hasStatusEffect("DragonBreathBoost") ? 3 : 2, 0, 0, 0, false, "Stun", "Cannot take a turn.", true, 0, 0xFF0000);
			}
			
			applyDamage(damage, attacker, target);
			attacker.removeStatusEffect("DragonBreathBoost")
		}
		
		public static var Whisper:SingleCombatAttack;
		private static function WhisperImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (target.intelligence() == 0 || target.originalRace == "robot" || target.originalRace == "Automaton") {
				output("You reach for " + target.capitalA + possessive(target.uniqueName) + " mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.");
				return;
			}
			
			if (attacker is PlayerCharacter) {
				output("You reach for your enemy's mind");
			}
			else if (target is PlayerCharacter) output("You hear whispers in your head, which are trying to confuse you mind");
			else output(attacker.capitalA + attacker.uniqueName + " fills " + target.a + possessive(target.uniqueName) + " mind with dark whispers");
			
			if (attacker.intelligence() >= target.intelligence() && attacker.willpower() >= target.willpower() && !target.isPlural && !target.hasStatusEffect("Stun Immune") && rand(10) != 0)
			{
				if (target is PlayerCharacter) output(", and you cower in horror!");
				else output(target.capitalA + target.uniqueName + ", watching as its sudden fear petrifies " + target.uniqueName + ".");
				
				if (!target.hasStatusEffect("Stunned")) {
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cowed in horror and cannot act.", true, 0, 0xFF0000);
				} else {
					target.getStatusEffect("Stunned").tooltip = "Cowed in horror and cannot act.";
					target.addStatusValue("Stunned", 1, 2);
				}
			}
			else
			{
				output(", but can't break through.");
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var FireBreath:SingleCombatAttack;
		private static function FireBreathImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (rand(5) == 0) {
				output("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat. ");
				applyDamage(damageRand(new TypeCollection( { burning: 10 + rand(20) }, DamageFlag.BYPASS_SHIELD ), 15), attacker, attacker);
				return;
			}
			
			if (attacker is PlayerCharacter) {
				output("A growl rumbles deep with your chest as you charge the terrestrial fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant green conflagration at " + target.a + target.uniqueName + "!");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling ball of green fire directly at you!");
			else output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling ball of green fire directly at " + target.a + possessive(target.uniqueName) + "!");
			
			var d:int = attacker.level * 8 + 15 + rand(10);
			
			if(target.hasStatusEffect("Sandstorm")) {
				output("  <b>Breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
				d *= 0.2;
			}
			
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d * attacker.spellMod() / 2, kinetic : d * attacker.spellMod() / 2 } ), 15);
			
			if (attacker is PlayerCharacter) output("  " + target.capitalA + target.short + " is burning!  ");
			else if (target is PlayerCharacter) output("  You are " + attacker.a + possessive(attacker.uniqueName) + " burning!  ");
			else output("  " + target.capitalA + target.short + " is burning!  ");
			
			// TODO: on fire debuff instead of part of the damage?
			
			applyDamage(damage, attacker, target);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var Hellfire:SingleCombatAttack;
		private static function HellfireImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (attacker is PlayerCharacter) {
				output("A growl rumbles deep with your chest as you charge your inner fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant conflagration at " + target.a + target.uniqueName + "!");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling ball of  fire directly at you!");
			else output(attacker.capitalA + attacker.uniqueName + " roars, exhaling a swirling ball of fire directly at " + target.a + possessive(target.uniqueName) + "!");
			
			var d:int = attacker.level * 4 + rand(10) + attacker.intelligence() / 2 + attacker.cor() / 5;
			
			if(target.hasStatusEffect("Sandstorm")) {
				output("  <b>Breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
				d *= 0.2;
			}
			
			//var lustPercent:Number = (target.isLustImmune || target.intelligence() < 2 || target.libido < 5 || target.originalRace == "robot" || target.originalRace == "Automaton" ? 0 : target.libido()) / 100.;
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d * attacker.spellMod() } ), 15);
			
			if (attacker is PlayerCharacter) output("  " + target.capitalA + target.short + " lets out a shriek as their form is engulfed in the blistering flames!  ");
			else if (target is PlayerCharacter) output("  You let out a shriek as your form is engulfed in the blistering flames!  ");
			else output("  " + target.capitalA + target.short + " lets out a shriek as their form is engulfed in the blistering flames!  ");
			
			// TODO: on fire debuff instead of part of the damage? change to define lust percent on caster's stat?
			
			applyDamage(damage, attacker, target);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var KitsuneFoxFire:SingleCombatAttack;
		private static function KitsuneFoxFireImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (attacker is PlayerCharacter) {
				output("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at " + target.a + target.uniqueName + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " throws an ethereal blue flame at you!");
			else output(attacker.capitalA + attacker.uniqueName + " throws ethereal blue flame at " + target.a + possessive(target.uniqueName) + "!");
			
			// 10+(player.inte/3 + rand(player.inte/2)) * spellMod()
			var d:int = 10 + attacker.intelligence() + rand(attacker.intelligence());
			//d *= 0.66 + target.cor() * 0.66 * 0.01; // 66% damage to fully pure, 132% to fully corrupt
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d * attacker.spellMod() } ), 15);
			
			applyDamage(damage, attacker, target);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var KitsuneCorruptFoxFire:SingleCombatAttack;
		private static function KitsuneCorruptFoxFireImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker.hasCombatDrone())
			{
				attacker.droneTarget = target;
			}
			
			if (attacker is PlayerCharacter) {
				output("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at " + target.a + target.uniqueName + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.  ");
			}
			else if (target is PlayerCharacter) output(attacker.capitalA + attacker.uniqueName + " throws an ethereal purple flame at you!  ");
			else output(attacker.capitalA + attacker.uniqueName + " throws ethereal purple flame at " + target.a + possessive(target.uniqueName) + "!  ");
			
			// 10+(player.inte/3 + rand(player.inte/2)) * spellMod()
			var d:int = 10 + attacker.intelligence() + rand(attacker.intelligence());
			//d *= 0.66 + (100 - target.cor()) * 0.66 * 0.01; // 66% damage to fully corrupt, 132% to fully pure
			var damage:TypeCollection = damageRand(new TypeCollection( { burning: d * attacker.spellMod() } ), 15);
			
			applyDamage(damage, attacker, target);
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var KitsuneIllusion:SingleCombatAttack;
		private static function KitsuneIllusionImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter) {
				output("The world begins to twist and distort around you as reality bends to your will.");
			}
			else output(attacker.capitalA + attacker.uniqueName + " twists reality around!");
			
			for (var x:int = 0; x < hGroup.length; x++)
			{
				if (hGroup[x].intelligence() == 0 || hGroup[x].originalRace == "robot" || hGroup[x].originalRace == "Automaton") {
					output("You reach for " + hGroup[x].capitalA + possessive(hGroup[x].uniqueName) + " mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.");
					continue;
				}
				
				if (attacker.intelligence() / 2 + rand(attacker.intelligence() / 2) > hGroup[x].intelligence() || attacker.willpower() / 2 + rand(attacker.willpower() / 2) > hGroup[x].willpower())
				{
					if (!hGroup[x].hasStatusEffect("Blinded")) {
						output("\n" + hGroup[x].capitalA + possessive(hGroup[x].uniqueName) + " mind blanketed in the thick fog of your illusions.");
						hGroup[x].createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Confused by illusions. Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
					} else {
						output("\n" + hGroup[x].capitalA + hGroup[x].uniqueName + " stumble humorously to and fro, unable to keep pace with the shifting illusions.");
						hGroup[x].getStatusEffect("Blinded").tooltip = "Unable to keep pace with the shifting illusions. Accuracy is reduced, and ranged attacks are far more likely to miss.";
						hGroup[x].addStatusValue("Blinded", 1, 2);
					}
				}
				else {
					output("\nLike the snapping of a rubber band, reality falls back into its rightful place as " + hGroup[x].capitalA + hGroup[x].uniqueName + " resist illusory conjurations.");
					if (hGroup[x].getStatusEffect("Blinded") != null && hGroup[x].getStatusEffect("Blinded").tooltip.indexOf("illusions") != -1)
						hGroup[x].removeStatusEffect("Blinded");
				}
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var KitsuneTerror:SingleCombatAttack;
		private static function KitsuneTerrorImpl(fGroup:/*Creature*/Array, hGroup:/*Creature*/Array, attacker:Creature, target:Creature):void
		{
			if (target.intelligence() == 0 || target.originalRace == "robot" || target.originalRace == "Automaton") {
				output("You reach for " + target.capitalA + possessive(target.uniqueName) + " mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.");
				return;
			}
			
			if (attacker is PlayerCharacter) {
				output("The world goes dark, an inky shadow blanketing everything in sight as you fill " + target.a + possessive(target.uniqueName) + " mind with visions of otherworldly terror that defy description.");
			}
			else if (target is PlayerCharacter) output("The world goes dark, an inky shadow blanketing everything in sight as " + attacker.capitalA + attacker.uniqueName + " fills your mind with visions of otherworldly terror that defy description!");
			else output(attacker.capitalA + attacker.uniqueName + " fills " + target.a + possessive(target.uniqueName) + " mind with visions of otherworldly terror that defy description!");
			
			if ((attacker.intelligence() / 2 + rand(attacker.intelligence() / 2) > target.intelligence() || attacker.willpower() / 2 + rand(attacker.willpower() / 2) > target.willpower()) && !target.hasStatusEffect("Stun Immune"))
			{
				output("\nThe effect is immediate! ");
				if (target is PlayerCharacter) output(" You cower in horror!");
				else output(target.capitalA + target.uniqueName + " cower in horror as they succumb to illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.");
				
				if (!target.hasStatusEffect("Stunned")) {
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cowed in horror and cannot act.", true, 0, 0xFF0000);
				} else {
					target.getStatusEffect("Stunned").tooltip = "Cowed in horror and cannot act.";
					target.addStatusValue("Stunned", 1, 2);
				}
			}
			else
			{
				output(" The dark fog recedes as quickly as it rolled.");
			}
			
			output(kGAMECLASS.onSpellCast(attacker));
		}
		
		public static var AFL:SingleCombatAttack;
		private static function AFLImpl(fGroup:Array, hGroup:Array, attacker:Creature, target:Creature):void
		{
			output("Your pull out your AFL out of nowhere to finish it here and now. ");
			
			var totalDamage:DamageResult = new DamageResult();
			
			for (var i:int = 0; i < hGroup.length; i++)
			{
				var cTarget:Creature = hGroup[i];
				if (cTarget.isDefeated()) continue;
				
				var damage:TypeCollection = new TypeCollection( { truedamage : 1000000 } );
				
				totalDamage.addResult(applyDamage(damage, attacker, cTarget, "suppress"));
			}
			
			outputDamage(totalDamage);
		}
	}
}