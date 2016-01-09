package classes.Items.Apparel 
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;

	public class CoCModestRobes extends ItemSlotClass
	{
		public function CoCModestRobes() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "M.Robes";
			
			this.longName = "modest robes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a set of modest robes";
			
			this.tooltip = "A set of modest robes, not dissimilar from what the monks back home would wear.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 1200;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = -3;
			this.critBonus = 0;
			this.evasion = 3;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
	}
}