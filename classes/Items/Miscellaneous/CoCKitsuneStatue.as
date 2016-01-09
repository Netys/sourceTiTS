package classes.Items.Miscellaneous
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCKitsuneStatue extends ItemSlotClass
	{
		public function CoCKitsuneStatue()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 20;
			this.type = GLOBAL.ALL;
			
			//Used on inventory buttons
			this.shortName = "GldStat";
			
			//Regular name
			this.longName = "golden statue";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a golden statue";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 6000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			this.isUsable = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = _latestVersion;
		}
		
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("You pull out the gold statue and turn it around in your hands a few times, carefully examining the intricate filigree and inscriptions covering the masterfully crafted idol.  Whoever made this certainly put a lot of time and love into their craft." + ((target.cor() < 50) ? "  Examining the painstaking detail that went into it, you feel a slight pang of guilt for having stolen it from its rightful place.  You push the thoughts away, reasoning that it won't be missed - after all, the owner was long gone before you arrived." : "") + "\n\n");
			output("It's not much use to you other than decoration, but based on the craftsmanship alone you judge that you could get a fair price for it if you pawned it off.  ");
			return false;
		}
	}
}
