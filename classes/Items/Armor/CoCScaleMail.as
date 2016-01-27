package classes.Items.Armor
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCScaleMail extends ItemSlotClass
	{
		public function CoCScaleMail()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "ScaleMl";
			
			//Regular name
			this.longName = "scale-mail armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a set of scale-mail armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 1700;
			this.attack = 0;
			this.defense = 6;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 2;
			
			resistances.kinetic.resistanceValue = 5.0;
			resistances.addFlag(DamageFlag.ABLATIVE);
			
			this.version = _latestVersion;
		}
	}
}