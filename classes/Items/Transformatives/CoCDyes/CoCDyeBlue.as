package classes.Items.Transformatives.CoCDyes
{
	import classes.Engine.Interfaces.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.StringUtil;
	
	public class CoCDyeBlue extends CoCDye
	{		
		//constructor
		public function CoCDyeBlue()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "BlueD";
			//Regular name
			this.longName = "vial of blue hair dye";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of blue hair dye";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This bottle of blue dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 250;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}
	}
}