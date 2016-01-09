package classes.Items.Miscellaneous
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
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
    
    public class CoCVitalityTincture extends ItemSlotClass
    {
        public function CoCVitalityTincture(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Vital T";
            //Regular name
            this.longName = "Vitality Tincture";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vitality tincture";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This potent tea is supposedly good for the strengthening the body.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 150;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			output("You down the contents of the bottle. The liquid is thick and tastes remarkably like cherries. Within moments, you feel much more fit and healthy.");
			if (pc.HP() < pc.maxHP()) {
				pc.HP(pc.maxHP() / 3);
				output("  Any aches, pains and bruises you have suffered no longer hurt and you feel much better.");
			}
			if (rand(3) == 0 && pc.tone < 95) output(pc.modTone(3));
			
			pc.slowStatGain("p", 1);
			pc.slowStatGain("r", 1);
			return false;
		}
	}	
}
