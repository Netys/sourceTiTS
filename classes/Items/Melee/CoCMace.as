package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCMace extends ItemSlotClass
	{
		public function CoCMace()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Mace";
			
			//Regular name
			this.longName = "mace";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a mace";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a mace, designed to be able to crush against various defenses.";
			this.attackVerb = "smash";
			attackNoun = "smash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 1000;
			this.attack = 3;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 9;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			
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