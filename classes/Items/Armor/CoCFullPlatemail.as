package classes.Items.Armor
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCFullPlatemail extends ItemSlotClass
	{
		public function CoCFullPlatemail()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "Full Plate";
			
			//Regular name
			this.longName = "full platemail";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a suit of full-plate armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 2500;
			this.attack = 0;
			this.defense = 21;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = -5;
			this.critBonus = 0;
			this.evasion = -6;
			this.fortification = 0;
			
			resistances.electric.resistanceValue = -10.0;
			resistances.addFlag(DamageFlag.PLATED);
			
			this.version = _latestVersion;
		}
	}
}