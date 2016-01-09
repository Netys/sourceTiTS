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
	
    public class CoCGoblinAle extends ItemSlotClass
    {
        public function CoCGoblinAle(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Gob.Ale";
            //Regular name
            this.longName = "Goblin Ale";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a flagon of potent goblin ale";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			if (rand(5) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			output("You drink the ale, finding it to have a remarkably smooth yet potent taste.  You lick your lips and sneeze, feeling slightly tipsy.");
			pc.lust(15);
			pc.imbibeAlcohol(35);
			////Stronger
			//if (pc.str > 50) {
				//dynStats("str", -1);
				//if (pc.str > 70) dynStats("str", -1);
				//if (pc.str > 90) dynStats("str", -2);
				//output("\n\nYou feel a little weaker, but maybe it's just the alcohol.", false);
			//}
			/////Less tough
			//if (pc.tou > 50) {
				//output("\n\nGiggling, you poke yourself, which only makes you giggle harder when you realize how much softer you feel.", false);
				//dynStats("tou", -1);
				//if (pc.tou > 70) dynStats("tou", -1);
				//if (pc.tou > 90) dynStats("tou", -2);
			//}
			//antianemone corollary:
			if (changes < changeLimit && pc.hairType == GLOBAL.HAIR_TYPE_TENTACLES && rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				output("\n\nAs you down the potent ale, your head begins to feel heavier - and not just from the alcohol!  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels smooth, silky, and fibrous; you watch as it dissolves into many thin, hair-like strands.  <b>Your hair is now back to normal!</b>");
				pc.hairType = GLOBAL.HAIR_TYPE_REGULAR;
				changes++;
			}
			//Shrink
			if (rand(2) == 0 && pc.tallness > 48) {
				changes++;
				output("\n\nThe world spins, and not just from the strength of the drink!  Your viewpoint is closer to the ground.  How fun!");
				pc.tallness -= (1 + rand(5));
			}
			////Speed boost
			//if (rand(3) == 0 && pc.spe < 50 && changes < changeLimit) {
				//dynStats("spe", 1 + rand(2));
				//output("\n\nYou feel like dancing, and stumble as your legs react more quickly than you'd think.  Is the alcohol slowing you down or are you really faster?  You take a step and nearly faceplant as you go off balance.  It's definitely both.", false);
				//changes++;
			//}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, canine pepps, demon items)
			if (changes < changeLimit && pc.armType != GLOBAL.TYPE_HUMAN && rand(4) == 0) {
				output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms are changing to normal human form.");
				pc.armType = GLOBAL.TYPE_HUMAN;
				pc.clearArmFlags();
				changes++;
			}
			//SEXYTIEMS
			//Multidick killa!
			if (pc.cocks.length > 1 && rand(3) == 0 && changes < changeLimit) {
				output("\n\n", false);
				kGAMECLASS.killCocks(1);
				changes++;
			}
			//Boost vaginal capacity without gaping
			if (changes < changeLimit && rand(3) == 0 && pc.hasVagina() && pc.vaginas[0].bonusCapacity < 40) {
				pc.vaginas[0].bonusCapacity += 5;
				output("\n\nThere is a sudden... emptiness within your [pc.vagina].  Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Boost fertility
			if (changes < changeLimit && rand(4) == 0 && pc.fertility() < 1.4 && pc.hasVagina()) {
				pc.fertilityRaw += (2 + rand(5)) / 100;
				changes++;
				output("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you're ready to be a mother.");
			}
			//Shrink primary dick to no longer than 12 inches
			else if (pc.cocks.length == 1 && rand(2) == 0 && changes < changeLimit) {
				if (pc.cocks[0].cLength() > 12) {
					changes++;
					var temp3:Number = 0;
					output("\n\n");
					//Shrink said cock
					if (pc.cocks[0].cLength() < 6 && pc.cocks[0].cLength() >= 2.9) {
						pc.cocks[0].cLength(-.5);
						temp3 -= .5;
					}
					temp3 += pc.increaseCock(0, (rand(3) + 1) * -1);
					kGAMECLASS.lengthChange(temp3, 1);
				}
			}
			//GENERAL APPEARANCE STUFF BELOW
			//REMOVAL STUFF
			//Removes wings and antennaes!
			if (pc.wingType != 0 && changes < changeLimit && rand(4) == 0) {
				if (pc.wingType == GLOBAL.TYPE_SHARK) output("\n\nYour back tingles, feeling lighter.  Something lands behind you with a 'thump', and when you turn to look, you see your fin has fallen off.  This might be the best (and worst) booze you've ever had!  <b>You no longer have a fin!</b>");
				else output("\n\nYour shoulders tingle, feeling lighter.  Something lands behind you with a 'thump', and when you turn to look you see your wings have fallen off.  This might be the best (and worst) booze you've ever had!  <b>You no longer have wings!</b>");
				pc.wingType = 0;
				changes++;
			}
			//Removes wings and antennaes!
			if (pc.hasAntennae() && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour [pc.hair] itches so you give it a scratch, only to have your [pc.antennae] fall to the ground.  What a relief.  <b>You've lost your antennae!</b>");
				changes++;
				pc.antennae = 0;
				pc.antennaeType = 0;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && pc.eyeType != GLOBAL.TYPE_HUMAN) {
				output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [pc.feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.  <b>You have normal, humanoid eyes again.</b>");
				pc.eyeType = GLOBAL.TYPE_HUMAN;
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && pc.bRows() > 1 && rand(3) == 0) {
				changes++;
				output("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most [pc.lowestBreasts] shrink down, disappearing completely into your ");
				if (pc.bRows() >= 3) output("abdomen");
				else output("chest");
				output(". The [pc.nipples] even fade until nothing but [pc.skinFurScales] remains. <b>You've lost a row of breasts!</b>");
				pc.removeBreastRow(pc.breastRows.length - 1, 1);
			}
			//Skin/fur
			if (pc.skinType != GLOBAL.SKIN_TYPE_SKIN && changes < changeLimit && rand(4) == 0 && pc.faceType == GLOBAL.TYPE_GABILANI) {
				if (pc.skinType == GLOBAL.SKIN_TYPE_FUR) output("\n\nYour [pc.skinFurScales] itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
				else if (pc.skinType == GLOBAL.SKIN_TYPE_SCALES) output("\n\nYour [pc.skinFurScales] itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
				else output("\n\nYour [pc.skin] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
				pc.skinAccent = "";
				pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
				pc.clearSkinFlags();
				changes++;
			}
			//skinTone
			if (!InCollection(pc.skinTone, "green", "grayish-blue", "dark green", "pale yellow") && changes < changeLimit && rand(2) == 0) {
				if (rand(10) != 0) pc.skinTone = "dark green";
				else {
					if (rand(2) == 0) pc.skinTone = "pale yellow";
					else pc.skinTone = "grayish-blue";
				}
				changes++;
				output("\n\nWhoah, that was weird.  You just hallucinated that your [pc.skinNoun] turned [pc.skinTone].  No way!  It's staying, it really changed color!");
			}
			//Face!
			if (pc.faceType != GLOBAL.TYPE_GABILANI && changes < changeLimit && rand(4) == 0 && pc.earType == GLOBAL.TYPE_SYLVAN) {
				changes++;
				pc.faceType = GLOBAL.TYPE_GABILANI;
				output("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look.  <b>You have a human looking face again!</b>");
			}
			//Ears!
			if (pc.earType != GLOBAL.TYPE_SYLVAN && changes < changeLimit && rand(3) == 0) {
				output("\n\nA weird tingling runs through your scalp as your [pc.hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
				changes++;
				pc.earType = GLOBAL.TYPE_SYLVAN;
				pc.earLength = 3;
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			//Nipples Turn Back:
			if (pc.nippleColor != "dark green" && changes < changeLimit && rand(3) == 0) {
				output("\n\nSomething invisible brushes against your [pc.nipples], making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned dark green.");
				changes++;
				pc.nippleColor = "dark green";
			}
			//Debugcunt
			//if (changes < changeLimit && rand(3) == 0 && pc.vaginaType() == 5 && pc.hasVagina()) {
				//output("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				//pc.vaginaType(0);
				//changes++;
			//}
			if (changes < changeLimit && rand(4) == 0 && (pc.ass.wetnessRaw > 1 || pc.ass.loosenessRaw > 1)) {
				output("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				if (pc.ass.wetnessRaw > 1) pc.ass.wetness(-1);
				if (pc.ass.loosenessRaw > 1) pc.ass.looseness(-1);
				changes++;
			}
			if (changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0 && pc.femininity < 85) pc.modFem(3);
				if (rand(2) == 0 && pc.thickness > 20) pc.modThickness(-3);
				if (rand(2) == 0 && pc.tone > 15) pc.modTone(-5);
			}
			return false;
		}
	}	
}
