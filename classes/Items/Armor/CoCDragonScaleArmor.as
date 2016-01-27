package classes.Items.Armor
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCDragonScaleArmor extends ItemSlotClass
	{
		public function CoCDragonScaleArmor()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "D.S. Armor";
			
			//Regular name
			this.longName = "dragonscale armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a suit of dragonscale armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This armor is cleverly fashioned from dragon scales. It offers high protection while at the same time, quite flexible.";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 6000;
			this.attack = 0;
			this.defense = 8;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.kinetic.resistanceValue = 30;
			this.resistances.electric.resistanceValue = 30;
			this.resistances.burning.resistanceValue = 60;
			this.resistances.freezing.resistanceValue = 60;
			
			this.version = _latestVersion;
		}
	}
}