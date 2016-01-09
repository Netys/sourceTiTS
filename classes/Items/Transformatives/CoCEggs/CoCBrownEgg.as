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
	
	public class CoCBrownEgg extends ItemSlotClass
	{
		public function CoCBrownEgg() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "BrownEg";
			//Regular name
			this.longName = "brown and white mottled egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a brown and white mottled egg";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
			
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
			
			output("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				output("You feel a bit of additional weight on your backside as your [pc.ass] gains a bit more padding.");
				pc.buttRating(1);
			}
			else {
				output("Your [pc.ass] wobbles, nearly throwing you off balance as it grows much bigger!");
				pc.buttRating(2 + rand(3));
			}
			if (rand(3) == 0) {
				output(pc.modThickness(large ? 8 : 3));
			}
			
			return false;
		}
	}
}