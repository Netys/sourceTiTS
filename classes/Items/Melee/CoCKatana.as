package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCKatana extends ItemSlotClass
	{
		public function CoCKatana()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Katana";
			
			//Regular name
			this.longName = "katana";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a katana";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A curved bladed weapon that cuts through flesh with the greatest of ease.";
			this.attackVerb = "keen cut";
			attackNoun = "keen cut";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 5000;
			this.attack = 0;
			
			baseDamage.kinetic.damageValue = 10;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 5;
			this.evasion = 2;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}