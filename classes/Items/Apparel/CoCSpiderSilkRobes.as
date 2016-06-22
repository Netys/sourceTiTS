package classes.Items.Apparel 
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;

	public class CoCSpiderSilkRobes extends ItemSlotClass
	{
		public function CoCSpiderSilkRobes() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "SS.Robes";
			
			this.longName = "spider-silk robes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a spider-silk robes";
			
			this.tooltip = "This robe looks incredibly comfortable. It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.\n\nWizard's Endurance: -30% Spell Cost.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 9500;
			this.attack = 0;
			this.defense = 4;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.electric.resistanceValue = 50;
			this.resistances.freezing.resistanceValue = 15;
			this.resistances.corrosive.resistanceValue = 50;
			
			this.version = this._latestVersion;
		}
	}
}