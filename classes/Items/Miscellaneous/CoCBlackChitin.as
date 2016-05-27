package classes.Items.Miscellaneous
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCBlackChitin extends ItemSlotClass
	{
		public function CoCBlackChitin()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 20;
			this.type = GLOBAL.QUESTITEM;
			
			//Used on inventory buttons
			this.shortName = "B.Chitn";
			
			//Regular name
			this.longName = "black chitin";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a large shard of chitinous plating";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.";
			
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
