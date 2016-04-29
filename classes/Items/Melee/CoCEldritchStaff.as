package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCEldritchStaff extends ItemSlotClass
	{
		public function CoCEldritchStaff()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "E.Staff";
			
			//Regular name
			this.longName = "eldritch staff";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an eldritch staff";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This eldritch staff once belonged to the Harpy Queen, who was defeated by your hands.  It fairly sizzles with magical power.";
			this.attackVerb = "thwack";
			attackNoun = "thwack";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 10000;
			this.attack = 6;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 3;
			baseDamage.freezing.damageValue = 14;
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