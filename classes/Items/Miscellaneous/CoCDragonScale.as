package classes.Items.Miscellaneous
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCDragonScale extends ItemSlotClass
	{
		public function CoCDragonScale()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 20;
			this.type = GLOBAL.ALL;
			
			//Used on inventory buttons
			this.shortName = "D.Scale";
			
			//Regular name
			this.longName = "freshly-shed dragonscale";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a freshly-shed dragonscale";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This sheet of dragon scale is incredibly strong and flexible. You've seen various legends about how the scales of a dragon can be worked into tough armor or used in alchemy.  No dragons were seriously harmed in the acquisition of this item.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 60;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			this.isUsable = false;
			
			this.version = _latestVersion;
		}
	}
}
