package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	// public const PIPE   :Weapon = new Weapon("Pipe   ","Pipe","pipe","a pipe","smash",5,25,"");
	public class CoCPipe extends ItemSlotClass
	{
		public function CoCPipe()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Pipe";
			
			//Regular name
			this.longName = "pipe";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pipe";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.";
			this.attackVerb = "smash";
			attackNoun = "smash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 250;
			this.attack = 0;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 5;
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