package classes.Items.Miscellaneous
{
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
    
    public class CoCTatteredScroll extends ItemSlotClass
    {
        public function CoCTatteredScroll(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "TScroll";
            //Regular name
            this.longName = "tattered scroll";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a tattered scroll";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This tattered scroll is written in strange symbols, yet you have the feeling that if you tried to, you could decipher it.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			output("Your wobbly [pc.legs] give out underneath you as your body's willpower seems to evaporate, your mouth reading the words on the scroll with a backwards sounding sing-song voice.\n\n");
			if (pc.hairColor == "sandy blonde") {
				output("Your mouth forms a smile of its own volition, reading, \"<i>Tresed eht retaw llahs klim ruoy.</i>\"\n\n");
				if (pc.breastRows.length == 0 || pc.biggestTitSize() == 0) {
					output("You grow a perfectly rounded pair of C-cup breasts!  ");
					if (pc.breastRows.length == 0) pc.createBreastRow();
					pc.breastRows[0].breasts = 2;
					pc.breastRows[0].breastRatingRaw = 3;
					if (pc.nipplesPerBreast < 1) pc.nipplesPerBreast = 1;
				}
				if (pc.biggestTitSize() > 0 && pc.biggestTitSize() < 3) {
					output("Your breasts suddenly balloon outwards, stopping as they reach a perfectly rounded C-cup.  ");
					pc.breastRows[0].breastRatingRaw = 3;
				}
				if (pc.nipplesPerBreast < 1) {
					output("A dark spot appears on each breast, rapidly forming into a sensitive nipple.  ");
					pc.nipplesPerBreast = 1;
				}
				//dynStats("sen", 2, "lus", 1);
				pc.lust(1);
				
				if (pc.isLactating()) {
					output("A strong pressure builds in your chest, painful in its intensity.  You yank down your top as ", false);
					if (pc.milkStorageMultiplier < 2) output("powerful jets of milk spray from your nipples, spraying thick streams over the ground.  You moan at the sensation and squeeze your tits, hosing down the tainted earth with an offering of your milk.  You blush as the milk ends, quite embarassed with your increased milk production.  ", false);
					if (pc.milkStorageMultiplier >= 2 && pc.milkStorageMultiplier <= 2.6) output("eruptions of milk squirt from your nipples, hosing thick streams everywhere.  The feeling of the constant gush of fluids is very erotic, and you feel yourself getting more and more turned on.  You start squeezing your breasts as the flow diminishes, anxious to continue the pleasure, but eventually all good things come to an end.  ", false);
					if (pc.milkStorageMultiplier > 2.6 && pc.milkStorageMultiplier < 3) output("thick hoses of milk erupt from your aching nipples, forming puddles on the ground.  You smile at how well you're feeding the earth, your milk coating the ground faster than it can be absorbed.  The constant lactation is pleasurable... in a highly erotic way, and you find yourself moaning and pulling on your nipples, your hands completely out of control.  In time you realize the milk has stopped, and even had time to soak into the dirt.  You wonder at your strange thoughts and pull your hands from your sensitive nipples.  ", false);

					if (pc.milkStorageMultiplier >= 3) output("you drop to your knees and grab your nipples.  With a very sexual moan you begin milking yourself, hosing out huge quantities of milk.  You pant and grunt, offering as much of your milk as you can.  It cascades down a hill in a small stream, and you can't help but blush with pride... and lust.  The erotic pleasures build as you do your best to feed the ground all of your milk.  You ride the edge of orgasm for an eternity, milk everywhere.  When you come to, you realize you're kneeling there, tugging your dry nipples.  Embarrassed, you stop, but your arousal remains.  ", false);

					if (pc.milkStorageMultiplier < 4) {
						pc.milkStorageMultiplier += 0.5;
						if (pc.milkStorageMultiplier > 4) pc.milkStorageMultiplier = 4;
						output("Your breasts feel fuller... riper... like your next milking could be even bigger.  ", false);
					}
					//dynStats("lib", 1, "sen", 4, "lus", 15);
					pc.slowStatGain("l", 1);
					pc.lust(15);
				} else {
					output("A pleasurable release suddenly erupts from your nipples!  Twin streams of milk are spraying from your breasts, soaking into the ground immediately.  It stops all too soon, though a voice in your head assures you that you can lactate quite often now.  ", false);
					if (!pc.canLactate())
						pc.milkMultiplier = 75;
					pc.milkFullness = 50;
					//dynStats("lib", .5, "sen", 1, "lus", 10);
					pc.slowStatGain("l", 0.5);
					pc.lust(10);
				}
				output("\n\nYour mouth curls into a sick smile and, with a voice that isn't your own, speaks, \"<i>I ALWAYS get what I want, dear...</i>\"");
				kGAMECLASS.processTime(15);
			}
			else {
				output("Your mouth forms a smile of its own volition, reading, \"<i>nuf erutuf rof riah ydnas, nus tresed eht sa ydnas.</i>\"\n\nYou feel a tingling in your scalp, and realize your hair has become a sandy blonde!");
				pc.hairColor = "sandy blonde";
				output("\n\nYour mouth curls with a sick smile, speaking with a voice that isn't your own, \"<i>I ALWAYS get what I want, dear...</i>\"");
				kGAMECLASS.processTime(5);
			}

			output("\n\nYou hear the soft impact of clothes hitting the ground behind you, and turn to see that the sand witch has found you! You cannot resist a peek at your uninvited guest, beholding a curvy dark-skinned beauty, her form dominated by a quartet of lactating breasts.  Somewhere in your lust-fogged mind you register the top two as something close to double-Ds, and her lower pair to be about Cs.  She smiles and leans over you, pushing you to the ground violently.\n\nShe turns around and drops, planting her slick honey-pot firmly against your mouth.  Her scent is strong, overpowering in its intensity.  Your tongue darts out for a taste and finds a treasure trove of sticky sweetness.  Instinctively you tongue-fuck her, greedily devouring her cunny-juice, shoving your tongue in as far as possible while suckling her clit.  Dimly you feel the milk spattering over you, splashing off you and into the cracked earth.  Everywhere the milk touches feels silky smooth and sensitive, and your hands begin stroking your body, rubbing it in as the witch sprays more and more of it.  You lose track of time, orgasming many times, slick and sticky with sexual fluids.");
			pc.orgasm();
			pc.slowStatGain("l", 1);
			//dynStats("lib", 1, "sen", 5);
			
			return false;
		}
	}	
}
