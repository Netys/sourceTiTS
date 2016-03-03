package classes.Engine.Combat 
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Utility.rand;
	import classes.Characters.PlayerCharacter;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateLustDamage(target:Creature, attacker:Creature, damageResult:DamageResult, special:String = ""):void
	{
		if (target.isLustImmune)
		{
			damageResult.remainingLustDamage = new TypeCollection();
			damageResult.lustDamage = 0;
			damageResult.lustResisted = true;
			return;
		}
		
		var tarResistances:TypeCollection = target.getLustResistances();
		
		if (target is PlayerCharacter && kGAMECLASS.easy)
		{
			tarResistances.addFlag(DamageFlag.EASY);
			damageResult.easyModeApplied = true;
		}
		
		if (target.lustRaw >= target.lustMax()) return;
		
		// Apply bonuses to specific damage types.
		var lustDamage:TypeCollection = damageResult.remainingLustDamage.makeCopy();
		
		if (lustDamage.tease.damageValue > 0 && attacker != null) lustDamage.tease.damageValue += attacker.sexiness() / 2;
		if (lustDamage.tease.damageValue > 0 && attacker != null && (attacker.hasPerk("Bimbo Body") || attacker.hasStatusEffect("Bimbo Champagne") || attacker.hasPerk("Bro Body") || attacker.hasPerk("Futa Form"))) lustDamage.tease.damageValue *= 1.1;
		if (lustDamage.tease.damageValue > 0 && attacker != null && attacker.hasPerk("Pheromone Cloud")) lustDamage.pheromone.damageValue += 1 + rand(4);
		if (lustDamage.tease.damageValue > 0 && target != null && target.hasCock() && attacker.hasStatusEffect("Cum Soaked")) 
		{
			var spunkBonus:Number = attacker.statusEffectv1("Cum Soaked");
			if (spunkBonus > 5) spunkBonus = 5;
			lustDamage.tease.damageValue += spunkBonus;
		}
		if (lustDamage.tease.damageValue > 0 && target != null && target.hasVagina() && attacker.hasStatusEffect("Pussy Drenched")) 
		{
			var slutsauceBonus:Number = attacker.statusEffectv1("Pussy Drenched");
			if (slutsauceBonus > 5) slutsauceBonus = 5;
			lustDamage.tease.damageValue += slutsauceBonus;
		}
		//25% dam multiplier
		if (lustDamage.tease.damageValue > 0 && target != null && target.hasStatusEffect("Red Myr Venom")) lustDamage.tease.damageValue *= 1.25; 
		
		// Apply any defensive modifiers
		var damMulti:Number = 1;
		if (target.hasStatusEffect("Blue Balls")) damMulti += 0.25;
		if (target.hasStatusEffect("Sex On a Meteor")) damMulti += 0.5;
		if (target.hasStatusEffect("Tallavarian Tingler")) damMulti += 0.5;
		//New status: "Red Myr Venom" replaces this.
		//if (target.hasStatusEffect("Myr Venom")) damMulti += 0.25;
		if (target.hasPerk("Easy")) damMulti += 0.2;
		
		if (target.hasPerk("Omnibus' Gift")) damMulti *= 0.85;
		if (target.hasPerk("Bimbo Body") || target.hasStatusEffect("Bimbo Champagne") || target.hasPerk("Bro Body") || target.hasPerk("Futa Form")) damMulti *= 0.75;
		if (target.hasPerk("Purity Blessing")) damMulti *= 0.85; // originally 0.75 but it is kinda op for perk without side effect
		
		if (damMulti != 1) lustDamage.multiply(damMulti);
		
		// Apply resistances
		lustDamage.applyResistances(tarResistances);
		var damageAfterResistances:Number = Math.round(lustDamage.getTotal());
		
		// Clamp damage done to 1 > Damage > DamageToCap
		if (damageAfterResistances < 1) damageAfterResistances = 1;
		if (damageAfterResistances > (target.lustMax() - target.lust()))
		{
			var damDiff:Number = (target.lustMax() - target.lust()) / damageAfterResistances;
			damageAfterResistances = target.lustMax() - target.lust();
			
			damageResult.lustDamage = damageAfterResistances;
			damageResult.typedLustDamage = lustDamage.makeCopy();
			damageResult.typedLustDamage.multiply(damDiff);
			
			damageResult.totalDamage += damageAfterResistances;
			damageResult.typedTotalDamage.add(damageResult.typedLustDamage);
		}
		else
		{
			damageResult.typedLustDamage = lustDamage.makeCopy();
			damageResult.lustDamage = damageAfterResistances;
			
			damageResult.totalDamage += damageAfterResistances;
			damageResult.typedTotalDamage.add(damageResult.typedLustDamage);
		}
		
		target.lust(damageAfterResistances);
	}

}