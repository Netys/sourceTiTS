package classes.Items.Transformatives 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	import classes.Util.*;
	
	public class CoCSucDelightPure extends ItemSlotClass
	{
		public function CoCSucDelightPure() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "PS.Delight";
			//Regular name
			this.longName = "untainted \"Succubi's Delight\"";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an untainted bottle of \"Succubi's Delight\"";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 200;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			CoCSucDelight.useIt(false);
			return false;
		}
	}
}