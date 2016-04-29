package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCWizardStaff extends ItemSlotClass
	{
		public function CoCWizardStaff()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "W.Staff";
			
			//Regular name
			this.longName = "wizard's staff";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a wizard's staff";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.";
			this.attackVerb = "smack";
			attackNoun = "smack";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 3500;
			this.attack = 4;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 1;
			baseDamage.burning.damageValue = 5;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
			baseDamage.addFlag(DamageFlag.AMPLIFYING);
			addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
			
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