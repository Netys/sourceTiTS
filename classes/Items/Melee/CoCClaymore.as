package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCClaymore extends ItemSlotClass
	{
		public function CoCClaymore()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "L.Claymore";
			
			//Regular name
			this.longName = "large claymore";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a large claymore";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A massive sword that a very strong warrior might use.";
			this.attackVerb = "slash";
			attackNoun = "cleaving sword-slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 10000;
			this.attack = -2;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 15;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
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