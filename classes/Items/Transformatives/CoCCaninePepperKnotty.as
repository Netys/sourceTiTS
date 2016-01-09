package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCCaninePepperKnotty extends CoCCaninePepper
    {        
        public function CoCCaninePepperKnotty(dataObject:Object=null)
        {
            this._latestVersion = 1;
			
            //Used on inventory buttons
            this.shortName = "KnottyP";
            //Regular name
            this.longName = "Knotty canine pepper";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a knotty canine pepper";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This knotted pepper is very swollen, with a massive, distended knot near the base.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
                        
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CaninePepper(4, pc);
			return false;
		}
	}
}