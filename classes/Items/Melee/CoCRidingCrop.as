package classes.Items.Melee
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCRidingCrop extends ItemSlotClass
	{
		public function CoCRidingCrop()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "RidingC";
			
			//Regular name
			this.longName = "riding crop";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a riding crop";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "whip";
			attackNoun = "whip";
			
			//Information
			this.basePrice = 500;
			this.attack = 2;
			
			baseDamage.kinetic.damageValue = 5;
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 1;
			this.critBonus = 0;
			this.evasion = 1;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}
