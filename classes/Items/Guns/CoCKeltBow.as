package classes.Items.Guns
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCKeltBow extends ItemSlotClass
	{
		//constructor
		public function CoCKeltBow()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.RANGED_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Kelt's Bow";
			
			//Regular name
			this.longName = "Kelt's bow";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "Kelt's longbow";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This massive longbow is very effective weapon... If you can draw it."
			this.attackVerb = "shoot";
			attackNoun = "arrow";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 10000;
			
			baseDamage.kinetic.damageValue = 15;			
			
			this.attack = 0;
			this.critBonus = 5;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.addFlag(GLOBAL.ITEM_FLAG_BOW_WEAPON);

			this.version = _latestVersion;
		}
	}
}