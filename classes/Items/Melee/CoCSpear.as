package classes.Items.Melee 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCSpear extends ItemSlotClass
	{
		public function CoCSpear() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			this.shortName = "Spear";
			this.longName = "deadly spear";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a deadly spear";
			
			this.tooltip = "A staff with a sharp blade at the tip designed to pierce through the toughest armor.";
			this.attackVerb = "piercing stab";
			attackNoun = "piercing stab";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.basePrice = 4500;
			this.attack = 0;
			
			baseDamage.kinetic.damageValue = 8;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 15;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = _latestVersion;	
		}	
	}
}