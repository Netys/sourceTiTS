package classes.Items.Armor 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	public class CoCIndecentSteelArmor extends ItemSlotClass
	{
		public function CoCIndecentSteelArmor() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			this.shortName = "IndecSt";
			
			this.longName = "practically indecent steel armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a suit of practically indecent steel armor";
			
			this.tooltip = "This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 8000;
			this.attack = 0;
			this.defense = 3;
			this.shieldDefense = 0;
			this.sexiness = 6;
			this.critBonus = 0;
			this.evasion = 1;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}		
	}
}