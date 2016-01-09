package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCCaninePepperDouble extends CoCCaninePepper
    {
        public function CoCCaninePepperDouble(dataObject:Object=null)
        {
            this._latestVersion = 1;
			
            //Used on inventory buttons
            this.shortName = "DblPepp";
            //Regular name
            this.longName = "Double canine pepper";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a double canine pepper";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This canine pepper is actually two that have grown together due to some freak coincidence.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
                        
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CaninePepper(2, pc);
			return false;
		}
	}
}