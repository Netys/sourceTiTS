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
			this.defense = 3;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = -2;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.kinetic.resistanceValue = 10;
			this.resistances.electric.resistanceValue = 30;
			this.resistances.burning.resistanceValue = 30;
			this.resistances.freezing.resistanceValue = 30;
			this.resistances.corrosive.resistanceValue = 20;
			this.resistances.poison.resistanceValue = 10;
			
			this.version = _latestVersion;
		}
	}
}