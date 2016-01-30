package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCTaurinum extends ItemSlotClass
    {
        public function CoCTaurinum(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Taurinum";
            //Regular name
            this.longName = "vial of Taurinum";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of Taurinum";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This is a long flared vial with a small label that reads, \"<i>Taurinum</i>\".  It is likely this potion is tied to centaurs in some way.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;

			output("You down the potion, grimacing at the strong taste.");
			if (changes < changeLimit && rand(2) == 0 && pc.RQ() < 100) {
				changes++;
				output("\n\nAfter drinking the potion, you feel a bit faster.");
				pc.slowStatGain("r", 1);
			}
			
			//classic horse-taur version
			if (changes < changeLimit && !pc.isTaur()) {
				if(pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) {
					changes++;
					output("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a centaur</b>.");
					if (pc.genitalSpot != 2) {
						if(pc.hasGenitals()) output("  After taking a moment to get used to your new body, you notice that your genitals now reside between the back legs on your centaur body.");
						pc.genitalSpot = 2;
					}
					pc.legCount = 4;
					pc.clearLegFlags();
					pc.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
					pc.addLegFlag(GLOBAL.FLAG_HOOVES);
					pc.legType = GLOBAL.TYPE_EQUINE;
					pc.slowStatGain("r", 3);
				}
				//generic version
				else {
					if (changes < changeLimit && rand(2) == 0) {
						changes++;
						if (pc.isNaga() || pc.isGoo()) {
							output("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
							pc.clearLegFlags();
							pc.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
							pc.addLegFlag(GLOBAL.FLAG_HOOVES);
							pc.legType = GLOBAL.TYPE_EQUINE;
						}
						//Catch-all
						else {	
							if (pc.hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) {
								pc.clearLegFlags();
								pc.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
								pc.addLegFlag(GLOBAL.FLAG_HOOVES);
								pc.legType = GLOBAL.TYPE_EQUINE;
							}
							output("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a feral beast!</b>");
						}
						if (pc.genitalSpot != 2) {
							if(pc.hasGenitals()) output("  After taking a moment to get used to your new body, you notice that your genitals now reside between the back legs on your body.");
							pc.genitalSpot = 2;
						}
						pc.slowStatGain("r", 3);
						pc.legCount = 4;
						changes++;
					}
				}
			}
			else if (changes < changeLimit && pc.isTaur() && pc.legCount == 4 && Mutator.changeLegs(pc, -1, 6, null, null, null, false)) {
				output("\n\nYou feel a rush of pressure hammering at the middle of your tauric body, between your two sets of legs. You grunt and stagger around as a new pair of legs begins to grow out of the center of your body, twisting muscles beginning to take shape. After a few minutes, they solidify into <b>a pair of " + plural(pc.leg(true, true, false)) + ". You've got six of them in total now!</b>");
				changes++;
			}
			else if (changes < changeLimit && pc.isTaur() && pc.legCount > 4 && Mutator.changeLegs(pc, -1, 2, null, null, null, false)) {
				output("\n\nYou feel your bones and organs changing place, steadily mutating until it no longer resembles the body of a beast, but a human. Your additional legs are absorbed, drawing into your vanishing lower body until <b>you have a bipedal humanoid figure</b>");
				changes++;
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
