package classes.Items.Transformatives.CoCEggs 
{
	import classes.Engine.Interfaces.*;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Utility.rand;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCWhiteEgg extends ItemSlotClass
	{
		public function CoCWhiteEgg() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "WhiteEg";
			//Regular name
			this.longName = "milky-white egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a milky-white egg";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 50;
			
			this.version = this._latestVersion;
		}
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			useIt(false);
			return false;
		}
		
        public static function useIt(large:Boolean):Boolean
        {
			clearOutput();
			var pc:PlayerCharacter = kGAMECLASS.pc;
			kGAMECLASS.flags["COC.ATE_COLORED_EGG"] = 1;
			
			var temp:Number = 0;
			var temp2:Number = 0;
			output("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Grow nipples
				if (pc.nippleLengthRatio < 3 && pc.biggestTitSize() > 0) {
					output("\n\nYour nipples engorge, prodding hard against the inside of your [pc.gear].  Abruptly you realize they've gotten almost a quarter inch longer.");
					pc.nippleLengthRatio += .2;
					pc.lust(15);
				}
			}
			//LARGE
			else {
				//Grow nipples
				if (pc.nippleLengthRatio < 3 && pc.biggestTitSize() > 0) {
					output("\n\nYour nipples engorge, prodding hard against the inside of your [pc.gear].  Abruptly you realize they've grown more than an additional quarter-inch.");
					pc.nippleLengthRatio += (rand(2) + 3) / 10;
					pc.lust(15);
				}
				//NIPPLECUNTZZZ
				temp = pc.breastRows.length;
				//Set nipplecunts on every row.
				while (temp > 0) {
					temp--;
					if (!pc.breastRows[temp].fuckable() && pc.nippleLength(temp) >= 2) {
						pc.breastRows[temp].nippleType = GLOBAL.NIPPLE_TYPE_FUCKABLE;
						//Keep track of changes.
						temp2++;
					}
				}
				//Talk about if anything was changed.
				if (temp2 > 0) output("\n\nYour [pc.fullChest] tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>");
			}
			
			return false;
		}
	}
}