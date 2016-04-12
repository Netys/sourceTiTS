package classes.Items.Melee 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCHookedGauntlet extends ItemSlotClass
	{
		public function CoCHookedGauntlet() 
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "H.Gauntlets";
			
			//Regular name
			this.longName = "hooked gauntlets";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a hooked gauntlets";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This pair metal gauntlets has the knuckles tipped with metal hooks.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "hooked punch";
			attackNoun = "hooked punch";
			
			//Information
			this.basePrice = 4000;
			this.attack = 2;
			
			baseDamage.kinetic.damageValue = 5;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			
			this.defense = 2;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}