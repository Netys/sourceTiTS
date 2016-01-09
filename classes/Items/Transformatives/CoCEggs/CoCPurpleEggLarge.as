package classes.Items.Transformatives.CoCEggs 
{
	import classes.Engine.Interfaces.*;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Utility.rand;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCPurpleEggLarge extends ItemSlotClass
	{
		public function CoCPurpleEggLarge() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "L.PrpEg";
			//Regular name
			this.longName = "large purple and white mottled egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a large purple and white mottled egg";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is an oblong egg, not much different from a ostrich egg in appearance (save for the color).  Something tells you it's more than just food.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 50;
			
			this.version = this._latestVersion;
		}
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			CoCPurpleEgg.useIt(true);
			return false;
		}
	}
}