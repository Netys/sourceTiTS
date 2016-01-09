package classes.Items.Melee
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCSuccubusWhip extends ItemSlotClass
	{
		//constructor
		public function CoCSuccubusWhip()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "SucWhip";
			
			//Regular name
			this.longName = "succubi whip";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a succubi whip";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "whip";
			attackNoun = "whip";
			
			//Information
			this.basePrice = 4000;
			this.attack = 5;
			
			baseDamage.kinetic.damageValue = 9;
			baseDamage.psionic.damageValue = 1;
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 2;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}
