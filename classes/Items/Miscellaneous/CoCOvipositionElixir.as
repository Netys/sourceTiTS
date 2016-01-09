package classes.Items.Miscellaneous
{
	import classes.GameData.Pregnancy.PregnancyManager;
    import classes.ItemSlotClass;
    import classes.GLOBAL;
    import classes.Creature;
    import classes.kGAMECLASS;
    import classes.GameData.TooltipManager;
    import classes.StringUtil;
    import classes.Util.RandomInCollection;
    import classes.Util.InCollection;
	import classes.Engine.Utility.indefiniteArticle;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
    
    public class CoCOvipositionElixir extends ItemSlotClass
    {
        public function CoCOvipositionElixir(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "OviElix";
            //Regular name
            this.longName = "Ovi Elixir";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a hexagonal crystal bottle tagged with an image of an egg";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 300;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
		/* Notes on StatusAffects.Eggs
		 v1 = egg type.
		 v2 = size - 0 for normal, 1 for large
		 v3 = quantity
		 EGG TYPES-
		 0 - brown - ass expansion
		 1 - purple - hip expansion
		 2 - blue - vaginal removal and/or growth of existing maleness
		 3 - pink - dick removal and/or fertility increase.
		 4 - white - breast growth.  If lactating increases lactation.
		 5 - rubbery black
		 */
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			if (!pc.hasVagina()) {
				output("You pop the cork and prepare to drink the stuff, but the smell nearly makes you gag.  You cork it hastily.\n\n");
				return false;
			}
			
			this.quantity--; // ugh... where are .consume function?
			if (this.quantity <= 0 && pc.inventory.indexOf(this) != -1)
			{
				pc.inventory.splice(pc.inventory.indexOf(this), 1);
			}
			
			output("You pop the cork and gulp down the thick greenish fluid.  The taste is unusual and unlike anything you've tasted before.");
			var hasPreg:Boolean = false;
			for (var i:int = 0; i < pc.vaginas.length; i++) 
				if (pc.pregnancyData[i].pregnancyType != "")
				{
					hasPreg = true;
					if (pc.pregnancyData[i].pregnancyType == "CoCOviElixEggs") {
						var large:Boolean = pc.statusEffectv2("MagicColorfulEggs") == 1;
						
						//If eggs are small, chance of increase!
						if (!large && rand(3) == 0) {
							pc.setStatusValue("MagicColorfulEggs", 2, 1);
							large = true;
							pc.bellyRatingMod -= pc.pregnancyData[i].pregnancyBellyRatingContribution;
							pc.pregnancyData[i].pregnancyQuantity *= 1 / 3;
							pc.pregnancyData[i].pregnancyBellyRatingContribution = pc.pregnancyData[i].pregnancyQuantity * 4;
							pc.bellyRatingMod += pc.pregnancyData[i].pregnancyBellyRatingContribution;
							output("\n\nYour pregnant belly suddenly feels heavier and more bloated than before.  You wonder what the elixir just did.");
						}
						
						//Chance of quantity increase!
						if (pc.pregnancyData[i].pregnancyQuantity < (large ? 50 : 25) && rand(2) == 0) {
							output("\n\nA rumble radiates from your uterus as it shifts uncomfortably and your belly gets a bit larger.");
							pc.bellyRatingMod -= pc.pregnancyData[i].pregnancyBellyRatingContribution;
							pc.pregnancyData[i].pregnancyQuantity += rand(large ? 2 : 4) + 1;
							pc.pregnancyData[i].pregnancyBellyRatingContribution = pc.pregnancyData[i].pregnancyQuantity * (large ? 2 : 4);
							pc.bellyRatingMod += pc.pregnancyData[i].pregnancyBellyRatingContribution;
						}
					} else if(pc.pregnancyData[i].pregnancyIncubationMulti < 10) {
						output("\n\nYou gasp as your pregnancy suddenly leaps forwards, your belly bulging outward a few inches as it gets closer to time for birthing.");
						pc.pregnancyData[i].pregnancyIncubationMulti *= 1.4;
					}
				}
				
			
			if (!hasPreg) { //If the player is not pregnant, get preggers with eggs!
				output("\n\nThe elixir has an immediate effect on your belly, causing it to swell out slightly as if pregnant.  You guess you'll be laying eggs sometime soon!");
				PregnancyManager.findHandler("CoCOviElixEggs").tryKnockUp(pc, pc, 0);
				pc.createStatusEffect("MagicColorfulEggs", rand(6), 0, 0, 0);
			}
			return false;
		}
	}	
}
