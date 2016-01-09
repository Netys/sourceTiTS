package classes.Items.Armor
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCBeeArmor extends ItemSlotClass
	{
		public function CoCBeeArmor()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "BeeArmr";
			
			//Regular name
			this.longName = "sexy black chitin armor-plating";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a set of chitinous armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A suit of armor cleverly fashioned from giant bee chitin. It comes with a silken loincloth to protect your modesty.";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 2000;
			this.attack = 0;
			this.defense = 8;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			resistances.addFlag(DamageFlag.PLATED);
			
			this.version = _latestVersion;
		}
	}
}