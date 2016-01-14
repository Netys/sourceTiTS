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
	
	public class CoCBlueEgg extends ItemSlotClass
	{
		public function CoCBlueEgg() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "BlueEg";
			//Regular name
			this.longName = "blue and white mottled egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a blue and white mottled egg";
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
			
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			output("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Kill pussies!
				if (pc.vaginas.length > 0) {
					output("\n\nYour vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it! <b> Your vagina is gone!</b>");
					pc.removeVagina(0, 1);
					if(!pc.hasVagina())	pc.clitLength = .5;
				}
				//Dickz
				if (pc.cocks.length > 0) {
					//Multiz
					if (pc.cocks.length > 1) {
						output("\n\nYour [pc.cocks] fill to full-size... and begin growing obscenely.");
						temp = pc.cocks.length;
						while (temp > 0) {
							temp--;
							temp2 = pc.increaseCock(rand(3) + 2, temp);
						}
						Mutator.lengthChange(pc, temp2, pc.cocks.length);
						pc.libido(1);
						pc.lust(20);
						//dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (pc.cocks.length == 1) {
						output("\n\nYour [pc.cocksLight] fills to its normal size... and begins growing... ");
						temp2 = pc.increaseCock(rand(3) + 2, 0);
						Mutator.lengthChange(pc, temp2, 1);
						pc.libido(1);
						pc.lust(20);
						//dynStats("lib", 1, "sen", 1, "lus", 20);
					}

				}
			}
			//LARGE
			else {
				//New lines if changes
				if (pc.bRows() > 1 || pc.buttRating() > 5 || pc.hipRating() > 5 || pc.hasVagina()) output("\n\n");
				//Kill pussies!
				if (pc.vaginas.length > 0) {
					output("Your vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it!\n\n");
					if (pc.bRows() > 1 || pc.buttRating() > 5 || pc.hipRating() > 5) output("  ");
					pc.removeVagina(0, 1);
					pc.clitLength = .5;
				}
				//Kill extra boobages
				if (pc.bRows() > 1) {
					output("Your back relaxes as extra weight vanishes from your chest.  <b>Your lowest " + pc.breastDescript(pc.bRows() - 1) + " have vanished.</b>");
					if (pc.buttRating() > 5 || pc.hipRating() > 5) output("  ");
					//Remove lowest row.
					pc.removeBreastRow((pc.bRows() - 1), 1);
				}
				//Ass/hips shrinkage!
				if (pc.buttRating() > 5) {
					output("Muscles firm and tone as you feel your [pc.ass] become smaller and tighter.");
					if (pc.hipRating() > 5) output("  ");
					pc.buttRating( -2);
				}
				if (pc.hipRating() > 5) {
					output("Feeling the sudden burning of lactic acid in your [pc.hips], you realize they have slimmed down and firmed up some.");
					pc.hipRating( -2);
				}
				//Shrink tits!
				if (pc.biggestTitSize() > 0)
				{
					Mutator.shrinkTits(pc);
				}
				if (pc.cocks.length > 0) {
					//Multiz
					if (pc.cocks.length > 1) {
						output("\n\nYour [pc.cocks] fill to full-size... and begin growing obscenely.  ");
						temp = pc.cocks.length;
						while (temp > 0) {
							temp--;
							temp2 = pc.increaseCock(temp, rand(3) + 5);
						}
						Mutator.lengthChange(pc, temp2, pc.cocks.length);
						pc.libido(1);
						pc.lust(20);
						//dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (pc.cocks.length == 1) {
						output("\n\nYour [pc.cocksLight] fills to its normal size... and begins growing...");
						temp2 = pc.increaseCock(0, rand(3) + 5);
						Mutator.lengthChange(pc, temp2, 1);
						pc.libido(1);
						pc.lust(20);
						//dynStats("lib", 1, "sen", 1, "lus", 20);
					}
				}
			}
			if (rand(3) == 0) {
				output(pc.modFem(large ? -8 : -3));
			}
			
			return false;
		}
	}
}