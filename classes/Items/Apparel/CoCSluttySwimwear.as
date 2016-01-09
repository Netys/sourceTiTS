package classes.Items.Apparel
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	public class CoCSluttySwimwear extends ItemSlotClass
	{
		public function CoCSluttySwimwear()
		{
			_latestVersion = 1;
			
			quantity = 1;
			stackSize = 1;
			
			type = GLOBAL.CLOTHING;
			
			shortName = "S.Swmwr";
			
			longName = "slutty swimwear";
			
			TooltipManager.addFullName(shortName, StringUtil.toTitleCase(longName));
			
			description = "a skimpy black bikini";
			
			tooltip = "An impossibly skimpy black bikini. You feel dirty just looking at it... and a little aroused, actually.";
			//tooltip += " Note that this will cover both your upper and lower under-region.";
			tooltip += " Note that this should cover both your upper and lower under-regions, so wearing undergarments with this before a swim is redundant.";
			
			TooltipManager.addTooltip(shortName, tooltip);
			
			attackVerb = "";
			
			basePrice = 60;
			attack = 0;
			defense = 0;
			shieldDefense = 0;
			sexiness = 6;
			critBonus = 0;
			evasion = 0;
			fortification = 0;
			
			itemFlags = [GLOBAL.ITEM_FLAG_SWIMWEAR];
			
			version = _latestVersion;
		}
	}
}
