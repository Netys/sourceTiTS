package classes.Items.Guns
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCWingstick extends ItemSlotClass
	{
		public function CoCWingstick()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.RANGED_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Wingstick";
			
			//Regular name
			this.longName = "wingsticks";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "the wingsticks";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "The whole bunch of tri-bladed throwing javelins. You can collect them after combat to use again."
			this.attackVerb = "throw";
			attackNoun = "javelin";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 2000;
			
			baseDamage.kinetic.damageValue = 6;			
			
			this.attack = 0;
			this.critBonus = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.evasion = 2;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}