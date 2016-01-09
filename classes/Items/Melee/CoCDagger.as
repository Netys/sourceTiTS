package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	
	public class CoCDagger extends ItemSlotClass
	{
		public function CoCDagger()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Dagger";
			
			//Regular name
			this.longName = "dagger";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a dagger";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A small blade.  Preferred weapon for the rogues.";
			this.attackVerb = "stab";
			attackNoun = "stab";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 400;
			this.attack = 0;
			
			baseDamage.kinetic.damageValue = 4;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 2;
			this.evasion = 2;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}