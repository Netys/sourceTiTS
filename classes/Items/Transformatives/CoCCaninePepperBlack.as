package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCCaninePepperBlack extends CoCCaninePepper
    {
        public function CoCCaninePepperBlack(dataObject:Object=null)
        {
            this._latestVersion = 1;
			
            //Used on inventory buttons
            this.shortName = "BlackPp";
            //Regular name
            this.longName = "Black canine pepper";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a solid black canine pepper";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
                        
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CaninePepper(3, pc);
			return false;
		}
	}
}