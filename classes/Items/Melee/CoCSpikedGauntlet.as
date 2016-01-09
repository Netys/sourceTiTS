package classes.Items.Melee 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCSpikedGauntlet extends ItemSlotClass
	{
		public function CoCSpikedGauntlet() 
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "S.Gauntlet";
			
			//Regular name
			this.longName = "spiked gauntlet";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a spiked gauntlet";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This single metal gauntlet has the knuckles tipped with metal spikes.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "spiked punch";
			attackNoun = "spiked punch";
			
			//Information
			this.basePrice = 4000;
			this.attack = 2;
			
			baseDamage.kinetic.damageValue = 5;
			baseDamage.addFlag(DamageFlag.CRUSHING);
			
			this.defense = 2;
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