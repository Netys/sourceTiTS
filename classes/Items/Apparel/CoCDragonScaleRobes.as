package classes.Items.Apparel 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;

	public class CoCDragonScaleRobes extends ItemSlotClass
	{
		public function CoCDragonScaleRobes() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "D.S. Robes";
			
			this.longName = "dragonscale robes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a dragonscale robes";
			
			this.tooltip = "This robe is expertly made from dragon scales. It offers high protection while being lightweight and should be comfortable to wear all day.\n\nWizard's Endurance: -20% Spell Cost.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 6000;
			this.attack = 0;
			this.defense = 6;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.kinetic.resistanceValue = 25;
			this.resistances.electric.resistanceValue = 25;
			this.resistances.burning.resistanceValue = 50;
			this.resistances.freezing.resistanceValue = 50;
			
			this.version = this._latestVersion;
		}
	}
}