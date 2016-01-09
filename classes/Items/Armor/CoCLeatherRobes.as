package classes.Items.Armor
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCLeatherRobes extends ItemSlotClass
	{
		public function CoCLeatherRobes()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "Lthr Robes";
			
			//Regular name
			this.longName = "concealing leather armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a suit of concealing leather armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a suit of flexible leather armor with a voluminous set of concealing black robes.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 1000;
			this.attack = 0;
			this.defense = 6;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = -4;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = _latestVersion;
		}
	}
}