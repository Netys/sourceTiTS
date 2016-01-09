package classes.Items.Transformatives
{
	import classes.Characters.PlayerCharacter;
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
    public class CoCMysticJewel extends ItemSlotClass
    {
        public function CoCMysticJewel(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.PILL;
            //Used on inventory buttons
            this.shortName = "MystJwl";
            //Regular name
            this.longName = "Mystic Jewel";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a mystic jewel";
            //Displayed on tooltips during mouseovers
            this.tooltip = "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 200;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			CoCFoxJewel.useIt(true);
			return false;
		}
	}
}