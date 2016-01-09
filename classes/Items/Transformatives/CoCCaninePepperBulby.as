package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCCaninePepperBulby extends CoCCaninePepper
    {
        public function CoCCaninePepperBulby(dataObject:Object=null)
        {
            this._latestVersion = 1;
			
            //Used on inventory buttons
            this.shortName = "BulbyPp";
            //Regular name
            this.longName = "Bulby canine pepper";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a bulbous pepper";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
                        
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			CaninePepper(5, pc);
			return false;
		}
	}
}