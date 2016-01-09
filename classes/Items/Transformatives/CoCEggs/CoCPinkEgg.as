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
	
	public class CoCPinkEgg extends ItemSlotClass
	{
		public function CoCPinkEgg() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "PinkEg";
			//Regular name
			this.longName = "pink and white mottled egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pink and white mottled egg";
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
				//Remove a dick
				if (pc.cocks.length > 0) {
					kGAMECLASS.killCocks(1);
					output("\n\n");
				}
				//remove balls
				if (pc.balls > 0) {
					if (pc.ballSize() > 15) {
						pc.ballSize( -8);
						output("Your scrotum slowly shrinks, settling down at a MUCH smaller size.  <b>Your [pc.balls] are much smaller.</b>\n\n");
					}
					else {
						pc.balls = 0;
						pc.ballSizeRaw = 1;
						output("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
					}
				}
				//Fertility boost
				if (pc.vaginas.length > 0 && pc.fertilityRaw < 1.4) {
					output("You feel a tingle deep inside your body, just above your [pc.vagina], as if you were becoming more fertile.\n\n");
					pc.fertilityRaw += 0.05;
				}
			}
			//LARGE
			else {
				//Remove a dick
				if (pc.cocks.length > 0) {
					kGAMECLASS.killCocks(-1);
					output("\n\n", false);
				}
				if (pc.balls > 0) {
					pc.balls = 0;
					pc.ballSizeRaw = 1;
					output("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
				}
				//Fertility boost
				if (pc.vaginas.length > 0 && pc.fertilityRaw < 1.7) {
					output("You feel a powerful tingle deep inside your body, just above your [pc.vagina]. Instinctively you know you have become more fertile.\n\n");
					pc.fertilityRaw += 0.1;
				}
			}
			if (rand(3) == 0) {
				output(pc.modFem(large ? 8 : 3));
			}
			
			return false;
		}
	}
}