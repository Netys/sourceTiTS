package classes.Items.Melee
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCWhip extends ItemSlotClass
	{
		public function CoCWhip()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Whip";
			
			//Regular name
			this.longName = "coiled whip";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a coiled whip";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "whip";
			attackNoun = "whip";
			
			//Information
			this.basePrice = 5000;
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
