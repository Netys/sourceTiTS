package classes.Items.Melee 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCSpellblade extends ItemSlotClass
	{
		public function CoCSpellblade() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "S.Blade";
			
			//Regular name
			this.longName = "inscribed spellblade";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an inscribed spellblade";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.";
			
			this.attackVerb = "slash";
			attackNoun = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 5000;
			this.attack = 0;
			
			baseDamage.kinetic.damageValue = 8;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			baseDamage.addFlag(DamageFlag.AMPLIFYING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 2;
			this.fortification = 0;

			this.version = _latestVersion;
		}
	}
}