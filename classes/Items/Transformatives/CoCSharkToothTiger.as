package classes.Items.Transformatives
{
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
	
	public class CoCSharkToothTiger extends ItemSlotClass
	{
		public function CoCSharkToothTiger(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "TSTooth";
			//Regular name
			this.longName = "glowing tiger shark tooth";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a glowing tiger shark tooth";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This looks like a normal shark tooth, though with an odd purple glow.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 60;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
		{
			CoCSharkTooth.SharkTooth(1, pc);
			return false;
		}
	}
}
