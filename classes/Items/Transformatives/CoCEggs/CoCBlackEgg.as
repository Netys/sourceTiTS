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
	
	public class CoCBlackEgg extends ItemSlotClass
	{
		public function CoCBlackEgg() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "BlackEg";
			//Regular name
			this.longName = "rubbery black egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a rubbery black egg";
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
			
			output("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//If hair isn't latex yet
				if(!pc.hasStatusEffect("Latex Hair"))
				{
					if(pc.hasHair()) {
					output("\n\nYour scalp tingles and your " + pc.hairDescript() + " thickens, the strands merging into shiny latex hair.");
					output("\n\n<b>You have latex hair!</b>");
					} else
						output("\n\nYour scalp tingles, but you can't see any changes.");
					pc.createStatusEffect("Latex Hair");
					//{player gains the Latex Hair trait}
				}
				
				//Change skin to latex if smooth.
				if(pc.skinType != GLOBAL.SKIN_TYPE_LATEX)
				{
					output("\n\nYour " + pc.skinFurScales(false, false, true) + " tingles delightfully as it shifts and changes into flawless smooth skin. It becomes shinier as its texture changes subtly.  You gasp as you touch yourself and realize your skin has become a layer of pure latex.");
					//{if the player had fur, they lose it. Tail descriptors also gain the latex descriptors}
					pc.skinType = GLOBAL.SKIN_TYPE_LATEX;
					//Clear out old latex skin rank counter if PC reset his skin
					pc.removeStatusEffect("Latex Skin");
					pc.libido(1+rand(3));
				}
			}
			//LARGE
			else
			{
				//If hair isn't latex yet
				if(!pc.hasStatusEffect("Latex Hair"))
				{
					if(pc.hasHair()) {
					output("\n\nYour scalp tingles and your " + pc.hairDescript() + " thickens, the strands merging into shiny latex hair.");
					output("\n\n<b>You have latex hair!</b>");
					} else
						output("\n\nYour scalp tingles, but you can't see any changes.");
					pc.createStatusEffect("Latex Hair");
					//{player gains the Latex Hair trait}
				}
				
				//Change skin to latex if smooth.
				if(pc.skinType != GLOBAL.SKIN_TYPE_LATEX)
				{
					output("\n\nYour " + pc.skinFurScales(false, false, true) + " tingles delightfully as it shifts and changes into flawless smooth skin. It becomes shinier as its texture changes subtly.  You gasp as you touch yourself and realize your skin has become a layer of pure latex.");
					//{if the player had fur, they lose it. Tail descriptors also gain the latex descriptors}
					pc.skinType = GLOBAL.SKIN_TYPE_LATEX;
					//Clear out old latex skin rank counter if PC reset his skin
					pc.removeStatusEffect("Latex Skin");
					pc.libido(1+rand(3));
				}
			}
			
			return false;
		}
	}
}