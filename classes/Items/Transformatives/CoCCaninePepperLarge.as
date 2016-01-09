package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCCaninePepperLarge extends CoCCaninePepper
    {
        public function CoCCaninePepperLarge(dataObject:Object=null)
        {
            this._latestVersion = 1;
			
            //Used on inventory buttons
            this.shortName = "LargePp";
            //Regular name
            this.longName = "Large canine pepper";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "an overly large canine pepper";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This large canine pepper is much bigger than any normal peppers you've seen.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
                        
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CaninePepper(1, pc);
			return false;
		}
	}
}