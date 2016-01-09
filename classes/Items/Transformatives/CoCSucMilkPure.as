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
	import classes.Engine.Utility.indefiniteArticle;
    
    public class CoCSucMilkPure extends ItemSlotClass
    {
        public function CoCSucMilkPure(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "P.S.Mlk";
            //Regular name
            this.longName = "untainted Succubi milk";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "an untainted bottle of Succubi milk";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 200;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			return CoCSucMilk.useIt(target, usingCreature, false);
		}
	}	
}
