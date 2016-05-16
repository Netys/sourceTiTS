package classes.GameData 
{
	import adobe.utils.ProductManager;
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.GameData.PerkData;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Perks 
	{		
		private var _perkList:Vector.<PerkData>;
		
		public function Perks() 
		{
			_perkList = new Vector.<PerkData>();
			
			// Configure the class perk data
			ConfigureClassPerks();
		}
		
		private function ConfigureClassPerks():void
		{
			ConfigureMercenaryPerks();
			ConfigureSmugglerPerks();
			ConfigureEngineerPerks();
			ConfigureAdventurerPerks();
		}
		
		private function ConfigureMercenaryPerks():void
		{
			// Level 2 Perks
			var criticalBlows:PerkData = new PerkData();
			criticalBlows.classLimit = GLOBAL.CLASS_MERCENARY;
			criticalBlows.levelLimit = 2;
			criticalBlows.autoGained = true;
			criticalBlows.perkName = "Critical Blows";
			criticalBlows.perkDescription = "Your strikes and shots gain a 10% chance of inflicting double damage on normal melee and ranged attacks.";
			insertPerkData(criticalBlows);
			
			var bloodthirsty:PerkData = new PerkData();
			bloodthirsty.classLimit = GLOBAL.CLASS_MERCENARY;
			bloodthirsty.levelLimit = 2;
			bloodthirsty.perkName = "Bloodthirsty";
			bloodthirsty.perkDescription = "Melee attacks restore a few points of energy.";
			insertPerkData(bloodthirsty);
			
			var armorPiercing:PerkData = new PerkData();
			armorPiercing.classLimit = GLOBAL.CLASS_MERCENARY;
			armorPiercing.levelLimit = 2;
			armorPiercing.perkName = "Armor Piercing";
			armorPiercing.perkDescription = "Ranged attacks ignore the first few points of enemy defense.";
			insertPerkData(armorPiercing);
			
			// Level 3 Perks
			var tough:PerkData = new PerkData();
			tough.classLimit = GLOBAL.CLASS_MERCENARY;
			tough.levelLimit = 3;
			tough.autoGained = true;
			tough.perkName = "Tough";
			tough.perkDescription = "Resistance to Kinetic damage increased by 10%."
			tough.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.kinetic.resistanceValue += 10.0;
				kGAMECLASS.pc.baseShieldResistances.kinetic.resistanceValue += 10.0;
			}
			insertPerkData(tough);
			
			var powerStrike:PerkData = new PerkData();
			powerStrike.classLimit = GLOBAL.CLASS_MERCENARY;
			powerStrike.levelLimit = 3;
			powerStrike.perkName = "Power Strike";
			powerStrike.perkDescription = "Grants the ability to perform a single melee attack for 200% normal damage.";
			insertPerkData(powerStrike);
			
			var rapidFire:PerkData = new PerkData();
			rapidFire.classLimit = GLOBAL.CLASS_MERCENARY;
			rapidFire.levelLimit = 3;
			rapidFire.perkName = "Rapid Fire";
			rapidFire.perkDescription = "Grants the ability to perform a ranged attack with two extra, reduced-accuracy shots.";
			insertPerkData(rapidFire);
			
			// Level 4
			var juggernaut:PerkData = new PerkData();
			juggernaut.classLimit = GLOBAL.CLASS_MERCENARY;
			juggernaut.levelLimit = 4;
			juggernaut.autoGained = true;
			juggernaut.perkName = "Juggernaut";
			juggernaut.perkDescription = "Grants a 25% chance to overcome any paralysis or stun effect every combat round.";
			insertPerkData(juggernaut);
			
			var riposte:PerkData = new PerkData();
			riposte.classLimit = GLOBAL.CLASS_MERCENARY;
			riposte.levelLimit = 4;
			riposte.perkName = "Riposte";
			riposte.perkDescription = "Grants increased evasion after any melee attack made for the remainder of the combat round.";
			insertPerkData(riposte);
			
			var takeCover:PerkData = new PerkData();
			takeCover.classLimit = GLOBAL.CLASS_MERCENARY;
			takeCover.levelLimit = 4;
			takeCover.perkName = "Take Cover";
			takeCover.perkDescription = "Grants the ability to avoid nearly all incoming ranged attacks for 3 combat rounds.";
			insertPerkData(takeCover);
			
			// Level 5
			var secondWind:PerkData = new PerkData();
			secondWind.classLimit = GLOBAL.CLASS_MERCENARY;
			secondWind.levelLimit = 5;
			secondWind.autoGained = true;
			secondWind.perkName = "Second Wind";
			secondWind.perkDescription = "Grants the ability to recover half of your maximum HP and Energy once per combat encounter.";
			insertPerkData(secondWind);
			
			var carpetGrenades:PerkData = new PerkData();
			carpetGrenades.classLimit = GLOBAL.CLASS_MERCENARY;
			carpetGrenades.levelLimit = 5;
			carpetGrenades.perkName = "Carpet Grenades";
			carpetGrenades.perkDescription = "Grants the ability to toss out a handful of micro-grenades, damaging everything in a large area. Hits all enemies.";
			insertPerkData(carpetGrenades);
			
			var detCharge:PerkData = new PerkData();
			detCharge.classLimit = GLOBAL.CLASS_MERCENARY;
			detCharge.levelLimit = 5;
			detCharge.perkName = "Detonation Charge";
			detCharge.perkDescription = "Grants the ability to throw a focused detonation charge at an enemy for very high Burning damage. Focusing the charge restricts the blast radius to a single target.";
			insertPerkData(detCharge);

			//Level 6
			//Passive: Tough 2: Increases Tough's effectiveness to 15%.
			var tough2:PerkData = new PerkData();
			tough2.classLimit = GLOBAL.CLASS_MERCENARY;
			tough2.levelLimit = 6;
			tough2.autoGained = true;
			tough2.perkName = "Tough 2";
			tough2.perkDescription = "Increases Kinetic damage resistance provided by 'Tough' to 15% (+5%).";
			tough2.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.kinetic.resistanceValue += 5.0;
				kGAMECLASS.pc.baseShieldResistances.kinetic.resistanceValue += 5.0;
			}
			insertPerkData(tough2);

			var lowTechSolutions:PerkData = new PerkData();
			lowTechSolutions.classLimit = GLOBAL.CLASS_MERCENARY;
			lowTechSolutions.levelLimit = 6;
			lowTechSolutions.perkName = "Low Tech Solutions";
			lowTechSolutions.perkDescription = "Increases damage from Kinetic melee weapons by 20%.";
			insertPerkData(lowTechSolutions);

			var heavyWeapons:PerkData = new PerkData();
			heavyWeapons.classLimit = GLOBAL.CLASS_MERCENARY;
			heavyWeapons.levelLimit = 6;
			heavyWeapons.perkName = "Heavy Weapons";
			heavyWeapons.perkDescription = "Increases damage from Kinetic ranged weapons by 20%.";
			insertPerkData(heavyWeapons);

			//Level 7
			//Passive: Iron Will: Your physical fortitude makes up when your mental fortitude fails. Gain a bonus to Willpower saves and checks based on Physique (5:1 ratio). 
			var ironWill:PerkData = new PerkData();
			ironWill.classLimit = GLOBAL.CLASS_MERCENARY;
			ironWill.levelLimit = 7;
			ironWill.autoGained = true;
			ironWill.perkName = "Iron Will";
			ironWill.perkDescription = "Allows your physical fortitude to contribute slightly to your willpower, granting one point of willpower for every five points of physique.";
			insertPerkData(ironWill);

			//1. Cleave: Your melee attacks do bonus damage against groups of enemies. 
			var cleave:PerkData = new PerkData();
			cleave.classLimit = GLOBAL.CLASS_MERCENARY;
			cleave.levelLimit = 7;
			cleave.perkName = "Cleave";
			cleave.perkDescription = "Grants an extra, low-accuracy swing when fighting groups of enemies or \"plural\" type foes.";
			insertPerkData(cleave);

			//2. Concentrate Fire: When you land consecutive ranged attacks, you gain a slight bonus to damage. 
			var concentrateFire:PerkData = new PerkData();
			concentrateFire.classLimit = GLOBAL.CLASS_MERCENARY;
			concentrateFire.levelLimit = 7;
			concentrateFire.perkName = "Concentrate Fire";
			concentrateFire.perkDescription = "Allows consecutive ranged attacks to gain a bonus to damage.";
			insertPerkData(concentrateFire);

			//3. (Replaces #1 if Power Strike Chosen) Wounding Strike: Upgrades power strike to increase damage dealt by 5 and place a status effect on the target. The status effect reduces healing and shield recovery by 50%.
			//Leaving this one for Geddy!

			//Level 8
			//Passive: Heroic Reserves - boosts energy reserves by 33.
			var heroicReserves:PerkData = new PerkData();
			heroicReserves.classLimit = GLOBAL.CLASS_MERCENARY;
			heroicReserves.levelLimit = 8;
			heroicReserves.autoGained = true;
			heroicReserves.perkName = "Heroic Reserves";
			heroicReserves.perkDescription = "Raises your maximum energy reserves by 33, allowing you to use more special attacks before tiring.";
			insertPerkData(heroicReserves);

			//1. Second Attack - flurry attack on melee
			var secondAttack:PerkData = new PerkData();
			secondAttack.classLimit = GLOBAL.CLASS_MERCENARY;
			secondAttack.levelLimit = 8;
			secondAttack.perkName = "Second Attack";
			secondAttack.perkDescription = "Allows you to make a second, low-accuracy attack whenever you perform a melee attack. Can stack with \"Cleave.\"";
			insertPerkData(secondAttack);

			//2. Second Shot - flurry attack on ranged shot
			var secondShot:PerkData = new PerkData();
			secondShot.classLimit = GLOBAL.CLASS_MERCENARY;
			secondShot.levelLimit = 8;
			secondShot.perkName = "Second Shot";
			secondShot.perkDescription = "Allows you to make a second, low-accuracy attack whenever you shoot a ranged weapon.";
			insertPerkData(secondShot);
		}
		
		private function ConfigureSmugglerPerks():void
		{
			// Level 2
			var lucky:PerkData = new PerkData();
			lucky.classLimit = GLOBAL.CLASS_SMUGGLER;
			lucky.levelLimit = 2;
			lucky.autoGained = true;
			lucky.perkName = "Lucky Breaks";
			lucky.perkDescription = "Grants you an additional 10% evasion chance.";
			insertPerkData(lucky);
			
			var shootFirst:PerkData = new PerkData();
			shootFirst.classLimit = GLOBAL.CLASS_SMUGGLER;
			shootFirst.levelLimit = 2;
			shootFirst.perkName = "Shoot First";
			shootFirst.perkDescription = "When using a ranged attack during the first round of combat, gain an additional attack.";
			insertPerkData(shootFirst);
			
			var lowBlow:PerkData = new PerkData();
			lowBlow.classLimit = GLOBAL.CLASS_SMUGGLER;
			lowBlow.levelLimit = 2;
			lowBlow.perkName = "Low Blow";
			lowBlow.perkDescription = "Grants the ability to perform a melee strike with a high chance of stunning the target.";
			insertPerkData(lowBlow);
			
			// Level 3
			var escapeArtist:PerkData = new PerkData();
			escapeArtist.classLimit = GLOBAL.CLASS_SMUGGLER;
			escapeArtist.levelLimit = 3;
			escapeArtist.autoGained = true;
			escapeArtist.perkName = "Escape Artist";
			escapeArtist.perkDescription = "Converts the chance to escape from grapples to use your Reflexes stat rather than Physique. Conveys an additional minor chance to escape.";
			insertPerkData(escapeArtist);
			
			var sneakAttack:PerkData = new PerkData();
			sneakAttack.classLimit = GLOBAL.CLASS_SMUGGLER;
			sneakAttack.levelLimit = 3;
			sneakAttack.perkName = "Sneak Attack";
			sneakAttack.perkDescription = "Grants the ability to perform a melee attack with greatly increased damage against stunned or blinded targets. Higher intelligence provides additional bonus damage.";
			insertPerkData(sneakAttack);
			
			var aimedShot:PerkData = new PerkData();
			aimedShot.classLimit = GLOBAL.CLASS_SMUGGLER;
			aimedShot.levelLimit = 3;
			aimedShot.perkName = "Aimed Shot";
			aimedShot.perkDescription = "Upgrades ranged attacks with greatly increased damage against stunned or blinded targets. Higher intelligence provides additional bonus damage.";
			insertPerkData(aimedShot);
			
			// Level 4
			var agility:PerkData = new PerkData();
			agility.classLimit = GLOBAL.CLASS_SMUGGLER;
			agility.levelLimit = 4;
			agility.autoGained = true;
			agility.perkName = "Agility";
			agility.perkDescription = "Increases evasion granted via items by 50%, or provides a flat 10% evasion boost, whichever is higher.";
			insertPerkData(agility);
			
			var sfGen:PerkData = new PerkData();
			sfGen.classLimit = GLOBAL.CLASS_SMUGGLER;
			sfGen.levelLimit = 4;
			sfGen.perkName = "Stealth Field Generator";
			sfGen.perkDescription = "Grants the ability to massively increase evasion chance for two combat rounds.";
			insertPerkData(sfGen);
			
			var disarmS:PerkData = new PerkData();
			disarmS.classLimit = GLOBAL.CLASS_SMUGGLER;
			disarmS.levelLimit = 4;
			disarmS.perkName = "Disarming Shot";
			disarmS.perkDescription = "Grants the ability to disarm your target, rendering them unable to wield a weapon for four combat rounds.";
			insertPerkData(disarmS);
			
			// Level 5
			var sharpEyes:PerkData = new PerkData();
			sharpEyes.classLimit = GLOBAL.CLASS_SMUGGLER;
			sharpEyes.levelLimit = 5;
			sharpEyes.autoGained = true;
			sharpEyes.perkName = "Sharp Eyes";
			sharpEyes.perkDescription = "Decreases the time required to recover from blinding effects, reducing their duration by one combat round.";
			insertPerkData(sharpEyes);
			
			var gasGren:PerkData = new PerkData();
			gasGren.classLimit = GLOBAL.CLASS_SMUGGLER;
			gasGren.levelLimit = 5;
			gasGren.perkName = "Gas Grenade";
			gasGren.perkDescription = "Grants the ability to throw a grenade designed to emit a lust-inducing smog. Deals lust damage to all enemies in combat.";
			insertPerkData(gasGren);
			
			var grenade:PerkData = new PerkData();
			grenade.classLimit = GLOBAL.CLASS_SMUGGLER;
			grenade.levelLimit = 5;
			grenade.perkName = "Grenade";
			grenade.perkDescription = "Grants the ability to throw a grenade designed to emit high levels of thermal radiation. Deals Burning damage to all enemies in combat.";
			insertPerkData(grenade);

			//Level 6
			//Passive: Supply and Demand: You gain a 5% discount on items bought in stores, and make 10% more from items sold.
			var supplyAndDemand:PerkData = new PerkData();
			supplyAndDemand.classLimit = GLOBAL.CLASS_SMUGGLER;
			supplyAndDemand.levelLimit = 6;
			supplyAndDemand.autoGained = true;
			supplyAndDemand.perkName = "Supply And Demand";
			supplyAndDemand.perkDescription = "Reduces shopkeeper markups by 5% and markdowns by 10%.";
			insertPerkData(supplyAndDemand);
			//Double Passive: Improved Agility: Increases base evasion even higher.
			var improvedAgility:PerkData = new PerkData();
			improvedAgility.classLimit = GLOBAL.CLASS_SMUGGLER;
			improvedAgility.levelLimit = 6;
			improvedAgility.autoGained = true;
			improvedAgility.perkName = "Improved Agility";
			improvedAgility.perkDescription = "Increases your evasion by an additional 10%.";
			insertPerkData(improvedAgility);
			
			//1. Quickdraw: Changing weapons does not take your entire turn. 
			var quickDraw:PerkData = new PerkData();
			quickDraw.classLimit = GLOBAL.CLASS_SMUGGLER;
			quickDraw.levelLimit = 6;
			quickDraw.perkName = "Quickdraw";
			quickDraw.perkDescription = "Equipping a new weapon no longer consumes your turn in combat.";
			insertPerkData(quickDraw);
			
			//2. Leap Up: When you are knocked prone, you immediately stand back up at the start of your next turn. 
			var leapUp:PerkData = new PerkData();
			leapUp.classLimit = GLOBAL.CLASS_SMUGGLER;
			leapUp.levelLimit = 6;
			leapUp.perkName = "Leap Up";
			leapUp.perkDescription = "Allows you to easily and freely leap to your feet after being knocked prone.";
			insertPerkData(leapUp);

			//Level 7
			//Passive: Hidden Loot: You gain two additional inventory slots.
			var hiddenLoot:PerkData = new PerkData();
			hiddenLoot.classLimit = GLOBAL.CLASS_SMUGGLER;
			hiddenLoot.levelLimit = 7;
			hiddenLoot.autoGained = true;
			hiddenLoot.perkName = "Hidden Loot";
			hiddenLoot.perkDescription = "Increases inventory size by two slots.";
			insertPerkData(hiddenLoot);
			//Double Passive: +Sneak Attack/Backstab damage (every 6 levels, keeps them as DPS monsters we all know them to be)
			var takeAdvantage:PerkData = new PerkData();
			takeAdvantage.classLimit = GLOBAL.CLASS_SMUGGLER;
			takeAdvantage.levelLimit = 7;
			takeAdvantage.autoGained = true;
			takeAdvantage.perkName = "Take Advantage";
			takeAdvantage.perkDescription = "Increase sneak attack and aimed shot base bonuses by 100%.";
			insertPerkData(takeAdvantage);
			
			//1. Smuggled Stimulant: Gain 25 energy per round for 3 rounds, once per combat.
			var smuggledStimulant:PerkData = new PerkData();
			smuggledStimulant.classLimit = GLOBAL.CLASS_SMUGGLER;
			smuggledStimulant.levelLimit = 7;
			smuggledStimulant.perkName = "Smuggled Stimulant";
			smuggledStimulant.perkDescription = "Allows you to gain 25 energy per round for 3 rounds, once per combat encounter.";
			insertPerkData(smuggledStimulant);
			
			//2. Burst of Energy: Gain 60 energy, once per combat.
			var burstOfEnergy:PerkData = new PerkData();
			burstOfEnergy.classLimit = GLOBAL.CLASS_SMUGGLER;
			burstOfEnergy.levelLimit = 7;
			burstOfEnergy.perkName = "Burst of Energy";
			burstOfEnergy.perkDescription = "Allows you to recover 60 energy, once per combat encounter.";
			insertPerkData(burstOfEnergy);

			//Level 8
			//Passive: Heroic Reserves - boosts energy reserves by 33.
			var heroicReserves:PerkData = new PerkData();
			heroicReserves.classLimit = GLOBAL.CLASS_SMUGGLER;
			heroicReserves.levelLimit = 8;
			heroicReserves.autoGained = true;
			heroicReserves.perkName = "Heroic Reserves";
			heroicReserves.perkDescription = "Raises your maximum energy reserves by 33, allowing you to use more special attacks before tiring.";
			insertPerkData(heroicReserves);

			//1. Second Attack - flurry attack on melee
			var secondAttack:PerkData = new PerkData();
			secondAttack.classLimit = GLOBAL.CLASS_SMUGGLER;
			secondAttack.levelLimit = 8;
			secondAttack.perkName = "Second Attack";
			secondAttack.perkDescription = "Allows you to make a second, low-accuracy attack whenever you perform a melee attack.";
			insertPerkData(secondAttack);

			//2. Second Shot - flurry attack on ranged shot
			var secondShot:PerkData = new PerkData();
			secondShot.classLimit = GLOBAL.CLASS_SMUGGLER;
			secondShot.levelLimit = 8;
			secondShot.perkName = "Second Shot";
			secondShot.perkDescription = "Allows you to make a second, low-accuracy attack whenever you shoot a ranged weapon.";
			insertPerkData(secondShot);

		}
		
		private function ConfigureEngineerPerks():void
		{
			// Level 2
			var shieldTweaks:PerkData = new PerkData();
			shieldTweaks.classLimit = GLOBAL.CLASS_ENGINEER;
			shieldTweaks.levelLimit = 2;
			shieldTweaks.autoGained = true;
			shieldTweaks.perkName = "Shield Tweaks";
			shieldTweaks.perkDescription = "Grants your shield generator an additional 2 points of shield protection per level.";
			insertPerkData(shieldTweaks);
			
			var attackDrone:PerkData = new PerkData();
			attackDrone.classLimit = GLOBAL.CLASS_ENGINEER;
			attackDrone.levelLimit = 2;
			attackDrone.perkName = "Attack Drone";
			attackDrone.perkDescription = "Grants an attack drone that will automatically fire on your enemies every combat round as long as your shields are up. The drone will also bolster your shields with its own, raising your maximum shielding by one point per level.";
			insertPerkData(attackDrone);
			
			var shieldBooster:PerkData = new PerkData();
			shieldBooster.classLimit = GLOBAL.CLASS_ENGINEER;
			shieldBooster.levelLimit = 2;
			shieldBooster.perkName = "Shield Booster";
			shieldBooster.perkDescription = "Grants a further increase to your shield generator, providing an additional eight points of protection per level.";
			insertPerkData(shieldBooster);
			
			// Level 3
			var enhancedDampeners:PerkData = new PerkData();
			enhancedDampeners.classLimit = GLOBAL.CLASS_ENGINEER;
			enhancedDampeners.levelLimit = 5;
			enhancedDampeners.autoGained = true;
			enhancedDampeners.perkName = "Enhanced Dampeners";
			enhancedDampeners.perkDescription = "Grants a 50% vulnerability reduction to damage absorbed by your shield generator.";
			insertPerkData(enhancedDampeners);
			
			var overcharge:PerkData = new PerkData();
			overcharge.classLimit = GLOBAL.CLASS_ENGINEER;
			overcharge.levelLimit = 3;
			overcharge.perkName = "Overcharge";
			overcharge.perkDescription = "Grants the ability to perform a single ranged attack for 150% normal damage. If the target's shields have been depleted, the shot may stun the target. Requires an energy weapon.";
			insertPerkData(overcharge);
			
			var volley:PerkData = new PerkData();
			volley.classLimit = GLOBAL.CLASS_ENGINEER;
			volley.levelLimit = 3;
			volley.perkName = "Volley";
			volley.perkDescription = "Grants the ability to perform an extra ranged attack with reduced accuracy, but a chance of causing blindness regardless. Requires an energy weapon.";
			insertPerkData(volley);
			
			// Level 4
			var armorTweaks:PerkData = new PerkData();
			armorTweaks.classLimit = GLOBAL.CLASS_ENGINEER;
			armorTweaks.levelLimit = 4;
			armorTweaks.autoGained = true;
			armorTweaks.perkName = "Armor Tweaks";
			armorTweaks.perkDescription = "Grants a 20% bonus to defense values provided by equipped armor.";
			insertPerkData(armorTweaks);
			
			var powerSurge:PerkData = new PerkData();
			powerSurge.classLimit = GLOBAL.CLASS_ENGINEER;
			powerSurge.levelLimit = 4;
			powerSurge.perkName = "Power Surge";
			powerSurge.perkDescription = "Grants the ability to restore a moderate amount of shielding for 33 energy.";
			insertPerkData(powerSurge);
			
			var deflectorRegen:PerkData = new PerkData();
			deflectorRegen.classLimit = GLOBAL.CLASS_ENGINEER;
			deflectorRegen.levelLimit = 4;
			deflectorRegen.perkName = "Deflector Regeneration";
			deflectorRegen.perkDescription = "Grants the ability to restore a moderate amount of shielding over four combat rounds for 20 energy.";
			insertPerkData(deflectorRegen);
			
			// Level 5
			var staticBurst:PerkData = new PerkData();
			staticBurst.classLimit = GLOBAL.CLASS_ENGINEER;
			staticBurst.levelLimit = 3;
			staticBurst.autoGained = true;
			staticBurst.perkName = "Static Burst";
			staticBurst.perkDescription = "Grants the ability to briefly overload your shield emitter. The burst shocks any enemies in close proximity, freeing you from grapples for a small energy cost.";
			insertPerkData(staticBurst);
			
			var gDisrupt:PerkData = new PerkData();
			gDisrupt.classLimit = GLOBAL.CLASS_ENGINEER;
			gDisrupt.levelLimit = 5;
			gDisrupt.perkName = "Gravidic Disruptor";
			gDisrupt.perkDescription = "Grants the ability to deal Unresistable damage to targetted enemies.";
			insertPerkData(gDisrupt);
			
			var tDisrupt:PerkData = new PerkData();
			tDisrupt.classLimit = GLOBAL.CLASS_ENGINEER;
			tDisrupt.levelLimit = 5;
			tDisrupt.perkName = "Thermal Disruptor";
			tDisrupt.perkDescription = "Grants the ability to deal Burning damage to your foes. Deals higher base damage than Gravidic Disruptor, but some enemies may be resistant to Burning damage.";
			insertPerkData(tDisrupt);

			//Level 6
			//Passive: Shield Regen: Once per fight, regenerate 25% of shields the turn after they drop.
			var shieldRegen:PerkData = new PerkData();
			shieldRegen.classLimit = GLOBAL.CLASS_ENGINEER;
			shieldRegen.levelLimit = 6;
			shieldRegen.autoGained = true;
			shieldRegen.perkName = "Shield Regen";
			shieldRegen.perkDescription = "Builds a redundancy into your shields that can reactivate them at 25% capacity once per fight after they drop.";
			insertPerkData(shieldRegen);
			
			//1. Gun Tweaks: Thanks to your after-market modifications, you do more damage with energy guns.
			var gunTweaks:PerkData = new PerkData();
			gunTweaks.classLimit = GLOBAL.CLASS_ENGINEER;
			gunTweaks.levelLimit = 6;
			gunTweaks.perkName = "Gun Tweaks";
			gunTweaks.perkDescription = "Allows you to do 20% additional damage with energy guns thanks to after-market modifications.";
			insertPerkData(gunTweaks);
			
			//2. Weapon Tweaks: Thanks to your after-market modifications, you do more damage with melee energy weapons.
			var weaponTweaks:PerkData = new PerkData();
			weaponTweaks.classLimit = GLOBAL.CLASS_ENGINEER;
			weaponTweaks.levelLimit = 6;
			weaponTweaks.perkName = "Weapon Tweaks";
			weaponTweaks.perkDescription = "Allows you to do 20% additional damage with melee energy weapons thanks to after-market modifications.";
			insertPerkData(weaponTweaks);

			//Level 7
			//Passive: Less Gay Passive: Precise Shot: Gain a bonus to ranged attack damage based off your Intelligence. (5:1 ratio maybe?)
			//Or, Vital Strike: You can pick out weak points when enemies get up close. Intelligence is now used for melee attack accuracy, rather than Physique (though Physique still applies to damage). 
			var fightSmarter:PerkData = new PerkData();
			fightSmarter.classLimit = GLOBAL.CLASS_ENGINEER;
			fightSmarter.levelLimit = 7;
			fightSmarter.autoGained = true;
			fightSmarter.perkName = "Fight Smarter";
			fightSmarter.perkDescription = "Improves melee and ranged accuracy by a small portion of your intelligence.";
			insertPerkData(fightSmarter);
			
			//Weapon Hack: Hack an enemy's energy weapons, locking them! {Inflicts Disarm. Obviously has no effect on kinetic-based foes.}
			var weaponHack:PerkData = new PerkData();
			weaponHack.classLimit = GLOBAL.CLASS_ENGINEER;
			weaponHack.levelLimit = 7;
			weaponHack.perkName = "Weapon Hack";
			weaponHack.perkDescription = "Allows you to spend 15 energy to hack the enemy's energy weapons, preventing their use for four to five rounds";
			insertPerkData(weaponHack);
			
			//Shield Hack: Hack an enemy's shields, weakening them! {Deals heavy damage to shields}
			var shieldHack:PerkData = new PerkData();
			shieldHack.classLimit = GLOBAL.CLASS_ENGINEER;
			shieldHack.levelLimit = 7;
			shieldHack.perkName = "Shield Hack";
			shieldHack.perkDescription = "Allows you to spend 25 energy to hack an enemy's shield, dealing very high shield damage.";
			insertPerkData(shieldHack);

			//Level 8
			//Passive: Heroic Reserves - boosts energy reserves by 33.
			var heroicReserves:PerkData = new PerkData();
			heroicReserves.classLimit = GLOBAL.CLASS_ENGINEER;
			heroicReserves.levelLimit = 8;
			heroicReserves.autoGained = true;
			heroicReserves.perkName = "Heroic Reserves";
			heroicReserves.perkDescription = "Raises your maximum energy reserves by 33, allowing you to use more special attacks before tiring.";
			insertPerkData(heroicReserves);

			//1. Second Attack - flurry attack on melee
			var secondAttack:PerkData = new PerkData();
			secondAttack.classLimit = GLOBAL.CLASS_ENGINEER;
			secondAttack.levelLimit = 8;
			secondAttack.perkName = "Second Attack";
			secondAttack.perkDescription = "Allows you to make a second, low-accuracy attack whenever you perform a melee attack.";
			insertPerkData(secondAttack);

			//2. Second Shot - flurry attack on ranged shot
			var secondShot:PerkData = new PerkData();
			secondShot.classLimit = GLOBAL.CLASS_ENGINEER;
			secondShot.levelLimit = 8;
			secondShot.perkName = "Second Shot";
			secondShot.perkDescription = "Allows you to make a second, low-accuracy attack whenever you shoot a ranged weapon.";
			insertPerkData(secondShot);
		}
		
		
		private function ConfigureAdventurerPerks():void
		{
			var ThunderousStrikes:PerkData = new PerkData();
			ThunderousStrikes.classLimit = GLOBAL.CLASS_ADVENTURER;
			ThunderousStrikes.perkName = "Thunderous Strikes";
			ThunderousStrikes.perkDescription = "+20% 'Attack' damage while physique is at or above 80%.";
			ThunderousStrikes.levelLimit = 6;
			ThunderousStrikes.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 80; };
			insertPerkData(ThunderousStrikes);
			
			// There are no weapon types in TiTS...
			//var WeaponMastery:PerkData = new PerkData();
			//WeaponMastery.classLimit = GLOBAL.CLASS_ADVENTURER;
			//WeaponMastery.perkName = "Weapon Mastery";
			//WeaponMastery.perkDescription = "You choose the 'Weapon Mastery' perk, doubling the effectiveness of large weapons.";
			//WeaponMastery.levelLimit = 6;
			//WeaponMastery.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 60; };
			//insertPerkData(WeaponMastery);
			
			// TODO: inlict debuff on each hit
			//var BrutalBlows:PerkData = new PerkData();
			//BrutalBlows.classLimit = GLOBAL.CLASS_ADVENTURER;
			//BrutalBlows.perkName = "Brutal Blows";
			//BrutalBlows.perkDescription = "Reduces enemy armor with each hit.";
			//BrutalBlows.levelLimit = 6;
			//BrutalBlows.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 75; };
			//insertPerkData(BrutalBlows);
			
			// There are no brawl in TiTS...
			//var IronFists:PerkData = new PerkData();
			//IronFists.classLimit = GLOBAL.CLASS_ADVENTURER;
			//IronFists.perkName = "Iron Fists";
			//IronFists.perkDescription = "Hardens your fists to increase attack rating by 5.";
			//IronFists.levelLimit = 6;
			//IronFists.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 50; };
			//insertPerkData(IronFists);
			
			var Parry:PerkData = new PerkData();
			Parry.classLimit = GLOBAL.CLASS_ADVENTURER;
			Parry.perkName = "Parry";
			Parry.perkDescription = "Increases evasion chance by up to 10% while wielding a melee weapon.";
			Parry.levelLimit = 6;
			Parry.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 50 && kGAMECLASS.pc.RQ() >= 50; };
			insertPerkData(Parry);
			
			// TODO: implement ability
			//var Berzerker:PerkData = new PerkData();
			//Berzerker.classLimit = GLOBAL.CLASS_ADVENTURER;
			//Berzerker.perkName = "Berzerker";
			//Berzerker.perkDescription = "Grants 'Berserk' ability.";
			//Berzerker.levelLimit = 12;
			//Berzerker.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 75; };
			//insertPerkData(Berzerker);
			
			var HoldWithBothHands:PerkData = new PerkData();
			HoldWithBothHands.classLimit = GLOBAL.CLASS_ADVENTURER;
			HoldWithBothHands.perkName = "Hold With Both Hands";
			HoldWithBothHands.perkDescription = "Gain +20% physique modifier with melee weapons when not using a ranged weapons.";
			HoldWithBothHands.levelLimit = 12;
			HoldWithBothHands.accessFunction = function():Boolean { return kGAMECLASS.pc.PQ() >= 80; };
			insertPerkData(HoldWithBothHands);
			
			var Tank:PerkData = new PerkData();
			Tank.classLimit = GLOBAL.CLASS_ADVENTURER;
			Tank.perkName = "Tank";
			Tank.perkDescription = "Raises max HP by 50.";
			Tank.levelLimit = -1;
			Tank.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 25; };
			insertPerkData(Tank);
			
			var Regeneration:PerkData = new PerkData();
			Regeneration.classLimit = GLOBAL.CLASS_ADVENTURER;
			Regeneration.perkName = "Regeneration";
			Regeneration.perkDescription = "Regenerates 2% of max HP/hour and 1% of max HP/round.";
			Regeneration.levelLimit = -1;
			Regeneration.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 50; };
			insertPerkData(Regeneration);
			
			var Tank2:PerkData = new PerkData();
			Tank2.classLimit = GLOBAL.CLASS_ADVENTURER;
			Tank2.perkName = "Fortitude";
			Tank2.perkDescription = "+1 extra HP per point of willpower.";
			Tank2.levelLimit = 6;
			Tank2.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 60 && kGAMECLASS.pc.hasPerk("Tank"); };
			insertPerkData(Tank2);
			
			var Regeneration2:PerkData = new PerkData();
			Regeneration2.classLimit = GLOBAL.CLASS_ADVENTURER;
			Regeneration2.perkName = "Regeneration 2";
			Regeneration2.perkDescription = "Regenerates further 2% of max HP/hour and 1% of max HP/round.";
			Regeneration2.levelLimit = 6;
			Regeneration2.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 70 && kGAMECLASS.pc.hasPerk("Regeneration"); };
			insertPerkData(Regeneration2);
			
			var ImmovableObject:PerkData = new PerkData();
			ImmovableObject.classLimit = GLOBAL.CLASS_ADVENTURER;
			ImmovableObject.perkName = "Immovable Object";
			ImmovableObject.perkDescription = "Grants 20% physical damage reduction.";
			ImmovableObject.levelLimit = 6;
			ImmovableObject.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 75; };
			ImmovableObject.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.kinetic.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.electric.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.burning.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.freezing.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.corrosive.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.poison.resistanceValue += 20.0;
			}
			insertPerkData(ImmovableObject);
			
			var Resolute:PerkData = new PerkData();
			Resolute.classLimit = GLOBAL.CLASS_ADVENTURER;
			Resolute.perkName = "Resolute";
			Resolute.perkDescription = "Grants immunity to stuns and some statuses.";
			Resolute.levelLimit = 12;
			Resolute.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 75; };
			insertPerkData(Resolute);
			
			var IronMan:PerkData = new PerkData();
			IronMan.classLimit = GLOBAL.CLASS_ADVENTURER;
			IronMan.perkName = "Iron Man";
			IronMan.perkDescription = "Reduces the fatigue cost of physical specials by 50%.";
			IronMan.levelLimit = 12;
			IronMan.accessFunction = function():Boolean { return kGAMECLASS.pc.WQ() >= 60 };
			insertPerkData(IronMan);
			
			var Evade:PerkData = new PerkData();
			Evade.classLimit = GLOBAL.CLASS_ADVENTURER;
			Evade.perkName = "Evade";
			Evade.perkDescription = "Increases chances of evading enemy attacks by 10%.";
			Evade.levelLimit = -1;
			Evade.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 25; };
			insertPerkData(Evade);
			
			var Runner:PerkData = new PerkData();
			Runner.classLimit = GLOBAL.CLASS_ADVENTURER;
			Runner.perkName = "Runner";
			Runner.perkDescription = "Increases chances of escaping combat.";
			Runner.levelLimit = -1;
			Runner.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 25; };
			insertPerkData(Runner);
			
			var DoubleAttack:PerkData = new PerkData();
			DoubleAttack.classLimit = GLOBAL.CLASS_ADVENTURER;
			DoubleAttack.perkName = "Double Attack";
			DoubleAttack.perkDescription = "Allows you to perform two melee attacks per round, but halves physique bonus to damage.";
			DoubleAttack.levelLimit = -1;
			DoubleAttack.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 50 && kGAMECLASS.pc.hasPerk("Runner") && kGAMECLASS.pc.hasPerk("Evade"); };
			insertPerkData(DoubleAttack);
			
			var SpeedyRecovery:PerkData = new PerkData();
			SpeedyRecovery.classLimit = GLOBAL.CLASS_ADVENTURER;
			SpeedyRecovery.perkName = "Speedy Recovery";
			SpeedyRecovery.perkDescription = "Regain fatigue 50% faster.";
			SpeedyRecovery.levelLimit = 6;
			SpeedyRecovery.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 60 && kGAMECLASS.pc.hasPerk("Evade"); };
			insertPerkData(SpeedyRecovery);
			
			// Using TiTS version of perk, there are no armor classes in TiTS anyways
			var Agility:PerkData = new PerkData();
			Agility.classLimit = GLOBAL.CLASS_ADVENTURER;
			Agility.perkName = "Agility";
			Agility.perkDescription = "Increases evasion granted via items by 50%, or provides a flat 10% evasion boost, whichever is higher.";
			Agility.levelLimit = 6;
			Agility.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 75 && kGAMECLASS.pc.hasPerk("Runner"); };
			insertPerkData(Agility);
			
			// There are no weapon classes in TiTS...
			//var LightningStrikes:PerkData = new PerkData();
			//LightningStrikes.classLimit = GLOBAL.CLASS_ADVENTURER;
			//LightningStrikes.perkName = "Lightning Strikes";
			//LightningStrikes.perkDescription = "Increases the attack damage for non-heavy weapons.";
			//LightningStrikes.levelLimit = 6;
			//LightningStrikes.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 60; };
			//insertPerkData(LightningStrikes);
			
			var LungingAttacks:PerkData = new PerkData();
			LungingAttacks.classLimit = GLOBAL.CLASS_ADVENTURER;
			LungingAttacks.perkName = "Lunging Attacks";
			LungingAttacks.perkDescription = "Grants 50% armor penetration for melee attacks.";
			LungingAttacks.levelLimit = 12;
			LungingAttacks.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 75; };
			insertPerkData(LungingAttacks);
			
			//var Blademaster:PerkData = new PerkData();
			//Blademaster.classLimit = GLOBAL.CLASS_ADVENTURER;
			//Blademaster.perkName = "Blademaster";
			//Blademaster.perkDescription = "Gain +5% to critical strike chance when wielding a sword and not using a shield.";
			//Blademaster.levelLimit = 12;
			//Blademaster.accessFunction = function():Boolean { return kGAMECLASS.pc.RQ() >= 80 && kGAMECLASS.pc.PQ() >= 60; };
			//insertPerkData(Blademaster);
			
			var Precision:PerkData = new PerkData();
			Precision.classLimit = GLOBAL.CLASS_ADVENTURER;
			Precision.perkName = "Precision";
			Precision.perkDescription = "Reduces enemy armor.";
			Precision.levelLimit = -1;
			Precision.setStorageValues(10);
			Precision.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 25; };
			insertPerkData(Precision);
			
			var Spellpower:PerkData = new PerkData();
			Spellpower.classLimit = GLOBAL.CLASS_ADVENTURER;
			Spellpower.perkName = "Spellpower";
			Spellpower.perkDescription = "Increases base spell strength by 50%.";
			Spellpower.levelLimit = -1;
			Spellpower.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 50 && kGAMECLASS.hasSpells(); };
			insertPerkData(Spellpower);
			
			var Mage:PerkData = new PerkData();
			Mage.classLimit = GLOBAL.CLASS_ADVENTURER;
			Mage.perkName = "Mage";
			Mage.perkDescription = "Increases base spell strength by 50%.";
			Mage.levelLimit = -1;
			Mage.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 50 && kGAMECLASS.pc.hasPerk("Spellpower"); };
			insertPerkData(Mage);
			
			var Tactician:PerkData = new PerkData();
			Tactician.classLimit = GLOBAL.CLASS_ADVENTURER;
			Tactician.perkName = "Tactician";
			Tactician.perkDescription = "Increases critical hit chance by up to 10%.";
			Tactician.levelLimit = 6;
			Tactician.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 50; };
			insertPerkData(Tactician);
			
			var Channeling:PerkData = new PerkData();
			Channeling.classLimit = GLOBAL.CLASS_ADVENTURER;
			Channeling.perkName = "Channeling";
			Channeling.perkDescription = "Increases base spell strength by 50%.";
			Channeling.levelLimit = 6;
			Channeling.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 60 && kGAMECLASS.pc.hasPerk("Spellpower") && kGAMECLASS.pc.hasPerk("Mage"); };
			insertPerkData(Channeling);
			
			// Poisons have too much different mechanics, especially ones with debuffs, can get lots of weirdshit here...
			//var Medicine:PerkData = new PerkData();
			//Medicine.classLimit = GLOBAL.CLASS_ADVENTURER;
			//Medicine.perkName = "Medicine";
			//Medicine.perkDescription = "Grants 15% chance per round of cleansing poisons/drugs from your body. Increases HP restoration on rest.";
			//Medicine.levelLimit = 6;
			//Medicine.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 60; };
			//insertPerkData(Medicine);
			
			var Archmage:PerkData = new PerkData();
			Archmage.classLimit = GLOBAL.CLASS_ADVENTURER;
			Archmage.perkName = "Archmage";
			Archmage.perkDescription = "Increases base spell strength by 50%.";
			Archmage.levelLimit = 12;
			Archmage.accessFunction = function():Boolean { return kGAMECLASS.pc.IQ() >= 75 && kGAMECLASS.pc.hasPerk("Mage"); };
			insertPerkData(Archmage);
			
			var ColdBlooded:PerkData = new PerkData();
			ColdBlooded.classLimit = GLOBAL.CLASS_ADVENTURER;
			ColdBlooded.perkName = "Cold Blooded";
			ColdBlooded.perkDescription = "Reduces minimum lust by up to 20, down to min of 20. Caps min lust at 80.";
			ColdBlooded.levelLimit = -1;
			ColdBlooded.accessFunction = function():Boolean { return kGAMECLASS.pc.lustMin() > 20; };
			insertPerkData(ColdBlooded);
			
			var HotBlooded:PerkData = new PerkData();
			HotBlooded.classLimit = GLOBAL.CLASS_ADVENTURER;
			HotBlooded.perkName = "Hot Blooded";
			HotBlooded.perkDescription = "Raises minimum lust by up to 20.";
			HotBlooded.levelLimit = -1;
			HotBlooded.accessFunction = function():Boolean { return kGAMECLASS.pc.libido() >= 50; };
			insertPerkData(HotBlooded);
			
			var WellAdjusted:PerkData = new PerkData();
			WellAdjusted.classLimit = GLOBAL.CLASS_ADVENTURER;
			WellAdjusted.perkName = "Well Adjusted";
			WellAdjusted.perkDescription = "You gain half as much lust as time passes.";
			WellAdjusted.levelLimit = 6;
			WellAdjusted.accessFunction = function():Boolean { return kGAMECLASS.pc.libido() >= 60; };
			insertPerkData(WellAdjusted);
			
			var Masochist:PerkData = new PerkData();
			Masochist.classLimit = GLOBAL.CLASS_ADVENTURER;
			Masochist.perkName = "Masochist";
			Masochist.perkDescription = "Take 20% less physical damage but gain lust when you take damage.";
			Masochist.levelLimit = 6;
			Masochist.accessFunction = function():Boolean { return kGAMECLASS.pc.libido() >= 60 && kGAMECLASS.pc.cor() >= 50; };
			Masochist.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.kinetic.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.electric.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.burning.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.freezing.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.corrosive.resistanceValue += 20.0;
				kGAMECLASS.pc.baseHPResistances.poison.resistanceValue += 20.0;
			}
			insertPerkData(Masochist);
			
			var CorruptedLibido:PerkData = new PerkData();
			CorruptedLibido.classLimit = GLOBAL.CLASS_ADVENTURER;
			CorruptedLibido.perkName = "Corrupted Libido";
			CorruptedLibido.perkDescription = "Reduces lust gain by 10%.";
			CorruptedLibido.levelLimit = -1;
			CorruptedLibido.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 25; };
			CorruptedLibido.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.psionic.resistanceValue += 10.0;
				kGAMECLASS.pc.baseHPResistances.drug.resistanceValue += 10.0;
				kGAMECLASS.pc.baseHPResistances.pheromone.resistanceValue += 10.0;
				kGAMECLASS.pc.baseHPResistances.tease.resistanceValue += 10.0;
			}
			insertPerkData(CorruptedLibido);
			
			var Seduction:PerkData = new PerkData();
			Seduction.classLimit = GLOBAL.CLASS_ADVENTURER;
			Seduction.perkName = "Seduction";
			Seduction.perkDescription = "Upgrades your tease attack, making it more effective.";
			Seduction.levelLimit = -1;
			Seduction.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 50; };
			insertPerkData(Seduction);
			
			var Nymphomania:PerkData = new PerkData();
			Nymphomania.classLimit = GLOBAL.CLASS_ADVENTURER;
			Nymphomania.perkName = "Nymphomania";
			Nymphomania.perkDescription = "Raises minimum lust by up to 30.";
			Nymphomania.levelLimit = -1;
			Nymphomania.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 75 && kGAMECLASS.pc.hasPerk("Corrupted Libido"); };
			insertPerkData(Nymphomania);
			
			var Acclimation:PerkData = new PerkData();
			Acclimation.classLimit = GLOBAL.CLASS_ADVENTURER;
			Acclimation.perkName = "Acclimation";
			Acclimation.perkDescription = "Reduces lust gain by 15%.";
			Acclimation.levelLimit = -1;
			Acclimation.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 50 && kGAMECLASS.pc.hasPerk("Corrupted Libido") && kGAMECLASS.pc.lustMin() >= 20; };
			Acclimation.applicationFunction = function():void {
				kGAMECLASS.pc.baseHPResistances.psionic.resistanceValue += 15.0;
				kGAMECLASS.pc.baseHPResistances.drug.resistanceValue += 15.0;
				kGAMECLASS.pc.baseHPResistances.pheromone.resistanceValue += 15.0;
				kGAMECLASS.pc.baseHPResistances.tease.resistanceValue += 15.0;
			}
			insertPerkData(Acclimation);
			
			var Sadist:PerkData = new PerkData();
			Sadist.classLimit = GLOBAL.CLASS_ADVENTURER;
			Sadist.perkName = "Sadist";
			Sadist.perkDescription = "Deal 20% more damage, but gain lust at the same time.";
			Sadist.levelLimit = 6;
			Sadist.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 60 && kGAMECLASS.pc.hasPerk("Corrupted Libido"); };
			insertPerkData(Sadist);
			
			var ArousingAura:PerkData = new PerkData();
			ArousingAura.classLimit = GLOBAL.CLASS_ADVENTURER;
			ArousingAura.perkName = "Arousing Aura";
			ArousingAura.perkDescription = "Exude a lust-inducing aura, making your lust attacks more effective.";
			ArousingAura.levelLimit = 6;
			ArousingAura.accessFunction = function():Boolean { return kGAMECLASS.pc.cor() >= 70 && kGAMECLASS.pc.hasPerk("Corrupted Libido"); };
			insertPerkData(ArousingAura);
		}
		
		public function getPlayerClassPerksList():Vector.<PerkData>
		{
			return _perkList.filter(classFilter);
		}
		
		public function getPerksList():Vector.<PerkData>
		{
			return _perkList.filter(nonClassFilter);
		}
		
		public function getAvailablePerksList():Vector.<PerkData>
		{
			return _perkList.filter(availablePerksFilter);
		}
		
		private function classFilter(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean
		{
			if (item.isClassLimited == true && item.classLimit == (kGAMECLASS.pc as PlayerCharacter).characterClass) return true;
			return false;
		}
		
		private function nonClassFilter(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean
		{
			if (item.isClassLimited == false) return true;
			return false;
		}
		
		private function availablePerksFilter(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean
		{
			if (item.isLevelLimited == false) return true;
			if (item.isLevelLimited == true && item.levelLimit <= (kGAMECLASS.pc as PlayerCharacter).level) return true;
			return false
		}
		
		private function insertPerkData(perkData:PerkData):void
		{
			_perkList.push(perkData);
		}
		
		public function getPerksForLevel(perkData:Vector.<PerkData>, level:int):Vector.<PerkData>
		{
			return perkData.filter(function(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean {
				if ((item as PerkData).autoGained == true) return false;
				if ((item as PerkData).levelLimit == level) return true;
				return false;
			});
		}
		
		public function getAutoPerkForCreature(creature:Creature):PerkData
		{			
			var filterPerk:Vector.<PerkData> = _perkList.filter(function(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean {
				if ((item as PerkData).autoGained == true
					&& (item as PerkData).levelLimit == creature.level
					&& ((item as PerkData).isClassLimited == false || ((item as PerkData).isClassLimited == true && (item as PerkData).classLimit == creature.characterClass))) return true;
					return false;
			});
			
			if (filterPerk.length > 1) throw new Error("Found more than one potential autoperk, fuck.");
			
			if (filterPerk.length == 1) 
			{
				return filterPerk[0];
			}
			
			return null;
		}
		
		public function getAutoPerksForCreature(creature:Creature):Vector.<PerkData>
		{
			var filterPerks:Vector.<PerkData> = _perkList.filter(function(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean {
				if ((item as PerkData).autoGained == true
					&& (item as PerkData).levelLimit <= creature.level
					&& ((item as PerkData).isClassLimited == false || ((item as PerkData).isClassLimited == true && (item as PerkData).classLimit == creature.characterClass))) return true;
					return false;
			});
			
			return filterPerks;
		}
		
		private function getPerkDataByName(perkName:String):PerkData
		{
			var ff:Function = function(t_perkName:String):Function
			{
				return function(item:PerkData, index:int, vector:Vector.<PerkData>):Boolean
				{
					if (item.perkName == t_perkName) return true;
					return false;
				}
			}(perkName);
			
			var filterPerks:Vector.<PerkData> = _perkList.filter(ff);
			
			if (filterPerks.length == 0) return null;
			
			// attempt to class filter if more than 1 perk
			if (filterPerks.length > 1) filterPerks = filterPerks.filter(classFilter);
			
			if (filterPerks.length == 1) return filterPerks[0];

			throw new Error("Found multiple perks for the provided search key! (" + perkName + ")");
		}
		
		public function getDescriptionForPerk(perkName:String):String
		{
			var tPerk:PerkData = getPerkDataByName(perkName);
			
			if (tPerk == null)
			{
				return "";
			}
			
			return tPerk.perkDescription;
		}
	}

}