package classes.Items.Drinks
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Interfaces.*;
	
	public class CoCBlackCatBeer extends ItemSlotClass
	{
		//constructor
		public function CoCBlackCatBeer()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "BC Beer";
			//Regular name
			this.longName = "Black Cat Beer";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a mug of Black Cat Beer";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 20;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = true;
			this.targetsSelf = true;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			if(target is PlayerCharacter) kGAMECLASS.blackCatBeerEffects(target as PlayerCharacter);
			return false;
		}
	}
}