package classes.Items.Transformatives
{
    import classes.ItemSlotClass;
    import classes.GLOBAL;
    import classes.Creature;
    import classes.kGAMECLASS;
    import classes.GameData.TooltipManager;
    import classes.StringUtil;
    import classes.Util.RandomInCollection;
    import classes.Util.InCollection;
	import classes.Engine.Utility.num2Text;
	import classes.CockClass;
	
    public class CoCIncubiDPure extends ItemSlotClass
    {
        public function CoCIncubiDPure(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "P.Draft";
            //Regular name
            this.longName = "untainted Incubi draft";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "an untainted Incubi draft";
            //Displayed on tooltips during mouseovers
            this.tooltip = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 200;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			return CoCIncubiD.useIt(target, usingCreature, false);
		}
	}	
}
