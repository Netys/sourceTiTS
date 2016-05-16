package classes.Engine.Combat 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.kGAMECLASS;
	import classes.Engine.Utility.rand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateHPDamage(target:Creature, attacker:Creature, damageResult:DamageResult, special:String = ""):void
	{
		if (target.HP() <= 0) return;
		
		var tarResistances:TypeCollection = target.getHPResistances();
		
		if (target is PlayerCharacter && kGAMECLASS.easy && !damageResult.easyModeApplied)
		{
			tarResistances.addFlag(DamageFlag.EASY);
			damageResult.easyModeApplied = true;
		}
		
		var damageToHP:TypeCollection = damageResult.remainingDamage.makeCopy();
		
		var initialTotalDamage:Number = damageToHP.getTotal();
		
		damageToHP.applyResistances(tarResistances);
		
		var damageAfterResistances:Number = damageToHP.getTotal();
		if (attacker.hasPerk("Sadist") && !target.isLustImmune) damageAfterResistances *= 1.2; // let's consider that lust immune foes are not sexy enough to get a thrill from hitting them
		
		// Apply other defensive stats
		var defReduction:Number = target.defense();
		
		if (special == "ranged" && kGAMECLASS.pc.hasPerk("Armor Piercing") && !(target is PlayerCharacter))
		{
			if (defReduction > 0) defReduction -= (kGAMECLASS.pc.level + rand(3));
			if (defReduction < 0) defReduction = 0;
		}
		
		if (special == "melee" && attacker.hasPerk("Lunging Attacks") && target != attacker && defReduction > 0) defReduction /= 2;
		
		if (attacker.hasPerk("Precision") && target != attacker && defReduction > 0)
		{
			if (defReduction > 0) defReduction -= attacker.perkv1("Precision");
			if (defReduction < 0) defReduction = 0;
		}
		
		damageAfterResistances -= defReduction;
		damageAfterResistances = Math.round(damageAfterResistances);
		
		//If we're this far, damage can't be less than one. You did get hit, after all.
		if (damageAfterResistances < 1) damageAfterResistances = 1;
		
		// We can communicate overkill damage now, so we'll set the value approximately by unwinding a percentage of leftover damage after resistances.
		
		if (damageAfterResistances <= target.HP())
		{
			damageResult.typedHPDamage = damageToHP;
			damageResult.hpDamage = damageAfterResistances;
			
			damageResult.typedTotalDamage.add(damageToHP);
			damageResult.totalDamage += damageAfterResistances;
			
			damageResult.remainingDamage = new TypeCollection();
			
			if (target.hasPerk("Masochist") && !target.isLustImmune) damageResult.remainingLustDamage.add(new TypeCollection( { tease : Math.min(Math.max(damageAfterResistances / 10, 2), 20) } ));
			if (attacker.hasPerk("Sadist") && !target.isLustImmune) attacker.lust(Math.min(Math.max(damageAfterResistances / 10, 3), 30)); // isLustImmune is checked for target rather than for attacker intentionally
			
			target.HP( -damageAfterResistances);
			
			return;
		}
		else
		{
			var damDiff:Number = target.HP() / damageAfterResistances;
			
			damageResult.remainingDamage.multiply(1 - damDiff);
			
			damageResult.hpDamage = target.HP();
			damageResult.typedHPDamage = damageToHP;
			damageResult.typedHPDamage.multiply(damDiff);
			
			damageResult.totalDamage += target.HP();
			damageResult.typedTotalDamage.add(damageToHP);
			
			if (target.hasPerk("Masochist") && !target.isLustImmune) damageResult.remainingLustDamage.add(new TypeCollection( { tease : Math.min(Math.max(target.HP() / 10, 2), 20) } ));
			if (attacker.hasPerk("Sadist") && !target.isLustImmune) attacker.lust(Math.min(Math.max(target.HP() / 10, 3), 30)); // isLustImmune is checked for target rather than for attacker intentionally
			
			target.HP( -target.HP());
		}
	}

}