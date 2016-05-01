package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCDragonshellShield extends ItemSlotClass
	{
		public function CoCDragonshellShield()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "DrgnShl";
			
			//Regular name
			this.longName = "dragon-shell shield";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a dragon-shell shield";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A durable shield that has been forged from the remains of the dragon egg you found in the swamp.";
			this.attackVerb = "slam";
			attackNoun = "slam";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 15000;
			this.attack = -5;
			
			baseDamage = new TypeCollection();
			baseDamage.kinetic.damageValue = 15;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = -10;
			this.evasion = 20;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}