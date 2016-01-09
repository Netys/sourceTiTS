package classes.Items.Melee 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCMinotaurAxe extends ItemSlotClass
	{
		public function CoCMinotaurAxe() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "L. Axe";
			
			//Regular name
			this.longName = "large axe";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an axe large enough for a minotaur";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This massive axe once belonged to a minotaur. It'd be hard for anyone smaller than a giant to wield effectively. The axe is double-bladed and deadly-looking.";
			
			this.attackVerb = "cleave";
			attackNoun = "chop";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 1000;
			this.attack = -4;
			
			baseDamage.kinetic.damageValue = 15;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = -6;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}