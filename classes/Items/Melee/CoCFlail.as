package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCFlail extends ItemSlotClass
	{
		public function CoCFlail()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Flail";
			
			//Regular name
			this.longName = "flail";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a flail";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.";
			this.attackVerb = "smash";
			attackNoun = "smash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 2000;
			this.attack = -2;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 15;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 5;
			this.evasion = -2;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}