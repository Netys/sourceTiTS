package classes.Items.Apparel 
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;

	public class CoCAdvClth extends ItemSlotClass
	{
		public function CoCAdvClth() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "G. Clothes";
			
			this.longName = "green adventurer's clothes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a green adventurer's outfit, complete with pointed cap";
			
			this.tooltip = "A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 2000;
			this.attack = 0;
			this.defense = 2;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 2;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
	}
}