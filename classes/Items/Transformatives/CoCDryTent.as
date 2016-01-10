package classes.Items.Transformatives
{
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
    public class CoCDryTent extends ItemSlotClass
    {
        public function CoCDryTent(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "DryTent";
            //Regular name
            this.longName = "Dry Tentacle";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a shriveled tentacle";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			output("You chew on the rubbery tentacle; its texture and taste are somewhat comparable to squid, but the half-dormant nematocysts cause your mouth to tingle sensitively.", false);
			var temp:Number = 0;
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;

			//possible use effects:
			//- toughess up, sensitivity down
			//if (rand(3) == 0 && pc.tou < 50 && changes < changeLimit) {
				//output("\n\nYour skin feels clammy and a little rubbery.  You touch yourself experimentally and notice that you can barely feel the pressure from your fingertips.  Consumed with curiosity, you punch yourself lightly in the arm; the most you feel is a dull throb!", false);
				//dynStats("tou", 1, "sen", -1);
				//changes++;
			//}
			//- speed down
			if (rand(3) == 0 && pc.RQ() > 40 && changes < changeLimit) {
				output("\n\nA pinprick sensation radiates from your stomach down to your knees, as though your legs were falling asleep.  Wobbling slightly, you stand up and take a few stumbling steps to work the blood back into them.  The sensation fades, but your grace fails to return and you stumble again.  You'll have to be a little more careful moving around for a while.", false);
				changes++;
				//dynStats("spe", -1);
				pc.reflexes( -1);
			}
			//- corruption increases by 1 up to low threshold (~20)
			if (rand(3) == 0 && pc.cor() < 20 && changes < changeLimit) {
				output("\n\nYou shiver, a sudden feeling of cold rushing through your extremities.", false);
				changes++;
				//dynStats("cor", 1);
				pc.cor(1);
			}
			//-always increases lust by a function of sensitivity
			//"The tingling of the tentacle

			//physical changes:
			//- may randomly remove bee abdomen, if present; always checks and does so when any changes to hair might happen
			if (rand(4) == 0 && changes < changeLimit && pc.hasTail(GLOBAL.TYPE_BEE)) {
				output("\n\nAs the gentle tingling of the tentacle's remaining venom spreads through your body, it begins to collect and intensify above the crack of your butt.  Looking back, you notice your abdomen shivering and contracting; with a snap, the chitinous appendage parts smoothly from your backside and falls to the ground.  <b>You no longer have a bee abdomen!</b>\n\n", false);
				pc.tailType = 0;
				changes++;
			}
			//-may randomly remove bee wings:
			if (rand(4) == 0 && (pc.wingType == GLOBAL.TYPE_SMALLBEE || pc.wingType == GLOBAL.TYPE_BEE) && changes < changeLimit) {
				output("\n\nYour wings twitch and flap involuntarily.  You crane your neck to look at them as best you are able; from what you can see, they seem to be shriveling and curling up.  They're starting to look a lot like they did when they first popped out, wet and new.  <b>As you watch, they shrivel all the way, then recede back into your body.</b>", false);
				pc.wingType = 0;
				changes++;
			}
			//-hair morphs to anemone tentacles, retains color, hair shrinks back to med-short('shaggy') and stops growing, lengthening treatments don't work and goblins won't cut it, but more anemone items can lengthen it one level at a time
			if (pc.gills && pc.hairType != 4 && changes < changeLimit && rand(5) == 0) {
				output("\n\nYour balance slides way off, and you plop down on the ground as mass concentrates on your head.  Reaching up, you give a little shriek as you feel a disturbingly thick, squirming thing where your hair should be.  Pulling it down in front of your eyes, you notice it's still attached to your head; what's more, it's the same color as your hair used to be.  <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, a gentle heat starts to suffuse your hand.  The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care to keep them from rubbing on your skin at all hours.  On the other hand, they're quite short and you find you can now flex and extend them as you would any other muscle, so that shouldn't be too hard.  You settle on a daring, windswept look for now.", false);
				pc.hairType = GLOBAL.HAIR_TYPE_TENTACLES;
				pc.hairLength = 5;
				//if (flags["COC.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD"] != 1) {
					//output("  <b>(Your hair has stopped growing.)</b>", false);
					//flags["COC.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD"] = 1;
				//}
				changes++;
				changes++;
				changes++;
				//(reset hair to 'shaggy', add tentacle hair status, stop hair growth)
				//appearance screen: replace 'hair' with 'tentacle-hair'
			}
			//-feathery gills sprout from chest and drape sensually over nipples (cumulative swimming power boost with fin, if swimming is implemented)
			if (rand(5) == 0 && !pc.gills && pc.skinTone == "aphotic blue-black" && changes < changeLimit) {
				output("\n\nYou feel a pressure in your lower esophageal region and pull your garments down to check the area.  <b>Before your eyes a pair of feathery gills start to push out of the center of your chest, just below your neckline, parting sideways and draping over your " + pc.nippleDescript(0) + "s.</b>  They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you hardly notice anything at all.  You redress carefully.", false);
				pc.gills = true;
				changes++;
			}
			//-[aphotic] skin tone (blue-black)
			if (rand(5) == 0 && changes < changeLimit && pc.skinTone != "aphotic blue-black") {
				output("\n\nYou absently bite down on the last of the tentacle, then pull your hand away, wincing in pain.  How did you bite your finger so hard?  Looking down, the answer becomes obvious; <b>your hand, along with the rest of your skin, is now the same aphotic color as the dormant tentacle was!</b>", false);
				pc.skinTone = "aphotic blue-black";
				changes++;
			}
			//-eat more, grow more 'hair':
			if (pc.hairType == 4 && pc.hairLength < 36 &&
					rand(2) == 0 && changes < changeLimit) {
				temp = 5 + rand(3);
				pc.hairLength += temp;
				output("\n\nAs you laboriously chew the rubbery dried anemone, your head begins to feel heavier.  Using your newfound control, you snake one of your own tentacles forward; holding it out where you can see it, the first thing you notice is that it appears quite a bit longer.  <b>Your head-tentacles are now " + num2Text(temp) + " inches longer!</b>", false);
				//(add one level of hairlength)
				changes++;
			}
			if (changes < changeLimit && rand(3) == 0 && pc.hasVagina() && pc.vaginas[0].type != GLOBAL.TYPE_SIREN) {
				output("\n\nSomething invisible brushes against your sex, making you twinge.  ");
				if (!pc.isCrotchExposed()) output("Undoing your clothes, y");
				else output("Y");
				output("ou take a look at your vagina and find that it has grown writhing tentacles over opening and phrodisiac-laced cilia inside!");
				pc.shiftVagina(0, GLOBAL.TYPE_SIREN);
				changes++;
			}
			//pc.refillHunger(20);
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
