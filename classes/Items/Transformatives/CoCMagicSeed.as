package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCMagicSeed extends ItemSlotClass
    {
        public function CoCMagicSeed(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "MagSeed";
            //Regular name
            this.longName = "enhanced golden seed";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a magically-enhanced golden seed";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CoCGoldenSeed.useGoldenSeed(pc, true);
			return false;
		}
	}	
}
