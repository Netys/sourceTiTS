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
	
    public class CoCLaBova extends ItemSlotClass
    {
        public function CoCLaBova(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "LaBova";
            //Regular name
            this.longName = "LaBova";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a bottle containing a misty fluid labeled \"LaBova\"";
			
            //Displayed on tooltips during mouseovers
            this.tooltip = "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			LaBova(pc, true, false);
			return false;
		}
		
		/*Purified LaBova:
		 This will be one of the items that the player will have to give Marble to purify her, but there is a limit on how much she can be purified in this way.
		 Effects on the player:
		 Mostly the same, but without animal transforms, corruption, and lower limits on body changes
		 Hips and ass cap at half the value for LaBova
		 Nipple growth caps at 1 inch
		 Breasts cap at E or DD cup
		 Raises lactation to a relatively low level, reduces high levels: \"Your breasts suddenly feel less full, it seems you aren't lactating at quite the level you where.\"  OR  \"The insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.\"
		 Does not apply the addictive quality
		 If the player has the addictive quality, this item can remove that effect

		 Enhanced LaBova:
		 Something that the player can either make or find later; put it in whenever you want, or make your own item.  This is just a possible suggestion.  If it is given to Marble, she only gains the quad nipples.
		 Effects on the player
		 Mostly the same, but some of the effects can be more pronounced.  Ie, more str gain from one dose, or more breast growth.
		 If the player's nipples are larger than 1 inch in length, this item is guaranteed to give them quad nipples.  This applies to all their breasts; seems like it ould be a good compromise on whether or not cowgirls should have 4 breasts.
		 Very small chance to increase fertility (normally this increase would only happen when the player forces a creature to drink their milk).
		 */
		public static function LaBova(pc:Creature, tainted:Boolean, enhanced:Boolean):void
		{
			clearOutput();
			//Changes done
			var changes:Number = 0;
			//Change limit
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			if (enhanced) changeLimit += 2;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//LaBova:
			//ItemDesc: "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.  "
			//ItemUseText:
			output("You drink the ");
			if (enhanced) output("Pro Bova");
			else output("La Bova");
			output(".  The drink has an odd texture, but is very sweet.  It has a slight aftertaste of milk.");
			//Possible Item Effects:
			//STATS
			//Increase player str:
			if (changes < changeLimit && rand(3) == 0) {
				temp = 60 - pc.PQ();
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) == 0) output("\n\nThere is a slight pain as you feel your muscles shift somewhat.  Their appearance does not change much, but you feel much stronger.");
					else output("\n\nYou feel your muscles tighten and clench as they become slightly more pronounced.");
					pc.slowStatGain("p", temp / 10);
					changes++;
				}
			}
			//Increase player tou:
			//if (changes < changeLimit && rand(3) == 0) {
				//temp = 60 - pc.tou;
				//if (temp <= 0) temp = 0;
				//else {
					//if (rand(2) == 0) output("\n\nYou feel your insides toughening up; it feels like you could stand up to almost any blow.", false);
					//else output("\n\nYour bones and joints feel sore for a moment, and before long you realize they've gotten more durable.", false);
					//dynStats("tou", temp / 10);
					//changes++;
				//}
			//}
			//Decrease player spd if it is over 30:
			if (changes < changeLimit && rand(3) == 0) {
				if (pc.RQ() > 30) {
					output("\n\nThe body mass you've gained is making your movements more sluggish.");
					changes++;
					temp = (pc.RQ() - 30) / 10;
					pc.slowStatGain("r", -temp);
				}
			}
			//Increase Corr, up to a max of 50.
			if (tainted) {
				temp = 50 - pc.cor();
				if (temp < 0) temp = 0;
				pc.cor(temp / 10);
			}
			//Sex bits - Duderiffic
			if (pc.cocks.length > 0 && rand(2) == 0) {
				//If the player has at least one dick, decrease the size of each slightly,
				output("\n\n");
				temp = 0;
				temp2 = pc.cocks.length;
				temp3 = 0;
				//Find biggest cock
				temp = pc.biggestCockIndex();
				//Shrink said cock
				if (pc.cocks[temp].cLength() < 6 && pc.cocks[temp].cLength() >= 2.9) {
					pc.cocks[temp].cLength(-.5);
					temp3 -= .5;
				}
				temp3 += pc.increaseCock((rand(3) + 1) * -1, temp);
				kGAMECLASS.lengthChange(temp3, 1);
				if (pc.cocks[temp].cLength() < 2) {
					output("  ");
					if (pc.cockTotal() == 1 && !pc.hasVagina()) {
						output("Your [pc.cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.");
						if (pc.balls > 0) output("  At the same time, your [pc.balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.");
						output("  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>", false);
						pc.balls = 0;
						pc.ballSizeRaw = 1;
						pc.createVagina();
						pc.clitLength = .25;
						pc.removeCock(0, 1);
					}
					else {
						kGAMECLASS.killCocks(1);
					}
				}
				//if the last of the player's dicks are eliminated this way, they gain a virgin vagina;
				if (pc.cocks.length == 0 && !pc.hasVagina()) {
					pc.createVagina();
					pc.clitLength = .25;
					output("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [pc.vagina]</b>!");

					changes++;
					pc.lust(10);
				}
			}
			//Sex bits - girly
			var boobsGrew:Boolean = false;
			//Increase player's breast size, if they are HH or bigger
			//do not increase size, but do the other actions:
			if (((tainted && pc.biggestTitSize() <= 11) || (!tainted && pc.biggestTitSize() <= 5)) && changes < changeLimit && (rand(3) == 0 || enhanced)) {
				if (rand(2) == 0) output("\n\nYour " + pc.breastDescript(0) + " tingle for a moment before becoming larger.");
				else output("\n\nYou feel a little weight added to your chest as your " + pc.breastDescript(0) + " seem to inflate and settle in a larger size.");
				kGAMECLASS.growTits(1 + rand(3), 1, false, 3);
				changes++;
				//dynStats("sen", .5);
				boobsGrew = true;
			}
			//-Remove feathery hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && pc.hairType != GLOBAL.HAIR_TYPE_REGULAR && rand(4) == 0) {
				//(long):
				if (pc.hairLength >= 6) output("\n\nA lock of your [pc.hair] droops over your eye.  Before you can blow the offending down away, you realize it is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is now human-like!</b>");
				//(short)
				else output("\n\nYou run your fingers through your [pc.hair] while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your locks.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is now human-like!</b>");
				changes++;
				pc.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			}
			//If breasts are D or bigger and are not lactating, they also start lactating:
			if (pc.biggestTitSize() >= 4 && !pc.canLactate() && changes < changeLimit && (rand(3) == 0 || boobsGrew || enhanced)) {
				pc.boostLactation(75);
				output("\n\nYou gasp as your " + pc.breastDescript(0) + " feel like they are filling up with something.  Within moments, a drop of milk leaks from your " + pc.breastDescript(0) + "; <b> you are now lactating</b>.");
				changes++;
				//dynStats("sen", .5);
			}
			//Quad nipples and other 'special enhanced things.
			if (enhanced) {
				//QUAD DAMAGE!
				if (pc.nipplesPerBreast == 1) {
					changes++;
					output("\n\nYour [pc.nipples] tingle and itch.  You pull back your [pc.gear] and watch in shock as they split into four distinct nipples!  <b>You now have four nipples on each side of your chest!</b>");
					pc.nipplesPerBreast = 4;
					output("  <b>You have a total of " + num2Text(pc.totalNipples()) + " nipples.</b>");
				}
				else if (pc.canLactate()) {
					if (rand(2) == 0) output("\n\nA wave of pleasure passes through your chest as your " + pc.breastDescript(0) + " start leaking milk from a massive jump in production.");
					else output("\n\nSomething shifts inside your " + pc.breastDescript(0) + " and they feel MUCH fuller and riper.  You know that you've started producing much more milk.");
					pc.boostLactation(10);
					if ((pc.nippleLengthRatio < 4 && tainted) || (!tainted && pc.nippleLengthRatio < 2)) {
						output("  Your [pc.nipples] swell up, growing larger to accommodate your increased milk flow.");
						pc.nippleLengthRatio += .25;
						//dynStats("sen", .5);
					}
					changes++;
				}
			}
			//If breasts are already lactating and the player is not lactating beyond a reasonable level, they start lactating more:
			else {
				if (tainted && pc.isLactating() && pc.milkMultiplier < 300 && changes < changeLimit && (rand(3) == 0 || enhanced)) {
					if (rand(2) == 0) output("\n\nA wave of pleasure passes through your chest as your " + pc.breastDescript(0) + " start producing more milk.");
					else output("\n\nSomething shifts inside your " + pc.breastDescript(0) + " and they feel fuller and riper.  You know that you've started producing more milk.");
					pc.boostLactation(20);
					if ((pc.nippleLengthRatio < 4 && tainted) || (!tainted && pc.nippleLengthRatio < 2)) {
						output("  Your [pc.nipples] swell up, growing larger to accommodate your increased milk flow.");
						pc.nippleLengthRatio += .25;
						//dynStats("sen", .5);
					}
					changes++;
				}
				if (!tainted) {
					if (pc.isLactating() && pc.milkMultiplier < 150 && changes < changeLimit && rand(3) == 0) {
						if (rand(2) == 0) output("\n\nA wave of pleasure passes through your chest as your " + pc.breastDescript(0) + " start producing more milk.");
						else output("\n\nSomething shifts inside your " + pc.breastDescript(0) + " and they feel fuller and riper.  You know that you've started producing more milk.");
						pc.boostLactation(10);
					if ((pc.nippleLengthRatio < 4 && tainted) || (!tainted && pc.nippleLengthRatio < 2)) {
							output("  Your [pc.nipples] swell up, growing larger to accommodate your increased milk flow.");
							pc.nippleLengthRatio += .25;
							//dynStats("sen", .5);
						}
						changes++;
					}
					if (pc.milkMultiplier > 200 /*&& pc.findStatusAffect(StatusAffects.Feeder) >= 0 || pc.breastRows[0].lactationMultiplier > 5*/) {
						if (rand(2) == 0) output("\n\nYour breasts suddenly feel less full, it seems you aren't lactating at quite the level you were.");
						else output("\n\nThe insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.");
						changes++;
						//dynStats("sen", .5);
						pc.boostLactation(-10);
					}
				}
			}
			//If breasts are lactating at a fair level
			//and the player has not received this status,
			//apply an effect where the player really wants
			//to give their milk to other creatures
			//(capable of getting them addicted):
			//if (pc.findStatusAffect(StatusAffects.Feeder) < 0 && pc.biggestLactation() >= 3 && rand(2) == 0 && pc.biggestTitSize() >= 5 && cor() >= 35) {
				//output("\n\nYou start to feel a strange desire to give your milk to other creatures.  For some reason, you know it will be very satisfying.\n\n<b>(You have gained the 'Feeder' perk!)</b>", false);
				//pc.createStatusAffect(StatusAffects.Feeder, 0, 0, 0, 0);
				//pc.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
				//changes++;
			//}
			//UNFINISHED
			//If player has addictive quality and drinks pure version, removes addictive quality.
			//if the player has a vagina and it is tight, it loosens.
			if (pc.hasVagina()) {
				if (pc.vaginas[0].loosenessRaw < 4 && changes < changeLimit && rand(2) == 0) {
					output("\n\nYou feel a relaxing sensation in your groin.  On further inspection you discover your [pc.vagina] has somehow relaxed, permanently loosening.");
					pc.vaginas[0].loosenessRaw++;
					//Cunt Stretched used to determine how long since last enlargement
					//if (pc.findStatusAffect(StatusAffects.CuntStretched) < 0) pc.createStatusAffect(StatusAffects.CuntStretched, 0, 0, 0, 0);
					//Reset the timer on it to 0 when restretched.
					//else pc.changeStatusValue(StatusAffects.CuntStretched, 1, 0);
					pc.vaginas[0].loosenessRaw++;
					changes++;
					//dynStats("lus", 10);
					pc.lust(10);
				}
			}
			//General Appearance (Tail -> Ears -> Paws(fur stripper) -> Face -> Horns
			//Give the player a bovine tail, same as the minotaur
			if (tainted && !pc.hasTail(GLOBAL.TYPE_BOVINE) && changes < changeLimit && rand(3) == 0) {
				if (!pc.hasTail()) output("\n\nYou feel the flesh above your [pc.ass] knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				else output("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				
				pc.tailCount = 1;
				pc.tailType = GLOBAL.TYPE_BOVINE;
				pc.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FLUFFY];
				changes++;
			}
			//Give the player bovine ears, same as the minotaur
			if (tainted && pc.earType != GLOBAL.TYPE_BOVINE && changes < changeLimit && rand(4) == 0 && pc.hasTail(GLOBAL.TYPE_BOVINE)) {
				output("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
				pc.earType = GLOBAL.TYPE_BOVINE;
				pc.earLength = 1;
				changes++;
			}
			//If the player is under 7 feet in height, increase their height, similar to the minotaur
			if (((enhanced && pc.tallness < 96) || pc.tallness < 84) && changes < changeLimit && rand(2) == 0) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (pc.tallness > 74) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) output("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) output("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) output("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				pc.tallness += temp;
				changes++;
			}
			//Give the player hoofs, if the player already has hoofs STRIP FUR, copypaste from Bovinium
			if (tainted && (pc.legType != GLOBAL.TYPE_BOVINE || !pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) && pc.earType == GLOBAL.TYPE_BOVINE) {
				if (changes < changeLimit && rand(3) == 0) {
					//PC was a naga:
					if (pc.isNaga())
					{
						output("\n\nA strange sensation runs through your serpentine lower body, followed by a wracking pain. You double over, hugging yourself to your coiling snake-body as the Bovinium decides to rob you of your serpent-half. The transformation is quick, but thoroughly unpleasant: your [pc.leg] splits apart wholesale, its outer parts flaking off to reveal taut, [pc.skinColor] skin. <b>You now have bipedal legs!</b>");

						output("\n\nThat’s not enough for the drug, though. Not by a long shot! After a few moments, you see <b>thick, curly fur starts to grow on your new-grown legs</b>, covering them up to the upper thighs. At least you’ll be warm in the winter!");

						output("\n\nThe bottoms of your legs take form: <b>rather than feet, they mutate into distinctly animalistic hooves.</b> You spend a good long while standing up and adjusting to your new gait, wobbling around until you get your footing. Or hoofing, as the case may be.");
						
						pc.legCount = 2;
						pc.genitalSpot = 0;
						pc.legType = GLOBAL.TYPE_BOVINE;
						
						pc.legFlags = [];
						pc.addLegFlag(GLOBAL.FLAG_HOOVES);
						pc.addLegFlag(GLOBAL.FLAG_FURRED);
					}
					//PC was a taur:
					else if (pc.isTaur())
					{
						output("\n\nYour bestial lower body is wracked with pain, and the mass of it starts convulsing, breaking apart at the seams. From the waist down, your body changes, becoming more and more humanoid as the minutes pass. When the transition ends, <b>you’re left with bipedal legs,</b> distinctly human in appearance.");
						
						if (pc.legType != GLOBAL.TYPE_BOVINE || !pc.hasLegFlag(GLOBAL.FLAG_FURRED))
						{
							output("\n\nThat’s not enough for the drug, though. Not by a long shot! After a few moments, you see <b>thick, curly fur starts to grow on your new-grown legs</b>, covering them up to the upper thighs. At least you’ll be warm in the winter!");
							pc.legType = GLOBAL.TYPE_BOVINE;
							pc.addLegFlag(GLOBAL.FLAG_FURRED);
						}
						pc.genitalSpot = 0;					
						pc.legCount = 2;
						pc.legFlags = [];
						pc.addLegFlag(GLOBAL.FLAG_PLANTIGRADE);

						if (pc.hasLegFlag(GLOBAL.FLAG_HOOVES))
						{
							output("\n\nThe bottoms of your legs take form: <b>rather than feet, they mutate into distinctly animalistic hooves.</b> You spend a good long while standing up and adjusting to your new gait, wobbling around until you get your footing. Or hoofing, as the case may be.");
							pc.addLegFlag(GLOBAL.FLAG_HOOVES);
						}
					}
					//PC was bipedal already:
					else
					{
						output("\n\nYou feel your [pc.legOrLegs] shifting, the [pc.skinFurScales] on them squirming and moving. After a few tense moments, <b>a thick coating of curly fur sprouts from your [pc.legOrLegs], covering them to the upper thigh</b>.");
						//if not already hooves: 
						if(!pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) output(" Your feet curl in, starting to become covered by a thick, black covering. You grunt and moan, rubbing your transforming body as your feet change. When they’re done, <b>you have a pair of cow-like hooves!</b>.");
						pc.legType = GLOBAL.TYPE_BOVINE;
						pc.legFlags = [];
						pc.addLegFlag(GLOBAL.FLAG_PLANTIGRADE);
						pc.addLegFlag(GLOBAL.FLAG_HOOVES);
						pc.addLegFlag(GLOBAL.FLAG_FURRED);
					}
					changes++;
				}
			}
			//If the player's face is non-human, they gain a human face
			if (!enhanced && pc.legType == GLOBAL.TYPE_BOVINE && pc.faceType != GLOBAL.TYPE_HUMAN && changes < changeLimit && rand(4) == 0) {
				//Remove face before fur!
				output("\n\nYour visage twists painfully, returning to a normal human shape.  <b>Your face is human again!</b>");
				pc.faceType =  GLOBAL.TYPE_HUMAN;
				changes++;
			}
			//enhanced get shitty fur
			if (enhanced && (pc.skinType != GLOBAL.SKIN_TYPE_FUR || pc.furColor != "black and white spotted")) {
				if (pc.skinType != GLOBAL.SKIN_TYPE_FUR) output("\n\nYour [pc.skinFurScales] itches intensely.  You scratch and scratch, but it doesn't bring any relief.  Fur erupts between your fingers, and you watch open-mouthed as it fills in over your whole body.  The fur is patterned in black and white, like that of a cow.  The color of it even spreads to your hair!  <b>You have cow fur!</b>");
				else output("\n\nA ripple spreads through your fur as some patches darken and others lighten.  After a few moments you're left with a black and white spotted pattern that goes the whole way up to the hair on your head!  <b>You've got cow fur!</b>");
                pc.skinType = GLOBAL.SKIN_TYPE_FUR;
                pc.clearSkinFlags();
				pc.furColor = "black and white spotted";
			}
			//if enhanced to probova give a shitty cow face
			else if (enhanced && pc.faceType != GLOBAL.TYPE_BOVINE) {
				output("\n\nYour visage twists painfully, warping and crackling as your bones are molded into a new shape.  Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>");
				pc.faceType = GLOBAL.TYPE_BOVINE;
				pc.faceFlags = [GLOBAL.FLAG_MUZZLED, GLOBAL.FLAG_LONG];
				changes++;
			}
			//Give the player bovine horns, or increase their size, same as the minotaur
			//New horns or expanding mino horns
			if (tainted && changes < changeLimit && rand(3) == 0 && (pc.faceType == GLOBAL.TYPE_BOVINE || pc.faceType == GLOBAL.TYPE_HUMAN)) {
				//Get bigger or change horns
				if (pc.hasHorns(GLOBAL.TYPE_BOVINE) || !pc.hasHorns()) {
					//Get bigger if player has horns
					if (pc.hasHorns(GLOBAL.TYPE_BOVINE)) {
						if (pc.hornLength < 5) {
							//Fems horns don't get bigger.
							output("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
							pc.hornLength += 1 + rand(2);
							changes++;
						}
					}
					//If no horns yet..
					if (!pc.hasHorns()) {
						output("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
						pc.hornType = GLOBAL.TYPE_BOVINE;
						pc.hornLength = 1;
						pc.horns = 2;
						changes++;
					}
					//TF other horns
					if (pc.hasHorns() && !pc.hasHorns(GLOBAL.TYPE_BOVINE)) {
						output("\n\nYour horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.");
						pc.hornType = GLOBAL.TYPE_BOVINE;
						pc.hornLength = 1;
						pc.horns = 2;
					}
				}
				//Not mino horns, change to cow-horns
				if (pc.hasHorns() && !pc.hasHorns(GLOBAL.TYPE_BOVINE)) {
					output("\n\nYour horns vibrate and shift as if made of clay, reforming into two small bovine nubs.");
					pc.hornType = GLOBAL.TYPE_BOVINE;
					pc.hornLength = 1;
					pc.horns = 2;
					changes++;
				}
			}
			//Increase the size of the player's hips, if they are not already childbearing or larger
			if (rand(2) == 0 && pc.hipRating() < 15 && changes < changeLimit) {
				if (!tainted && pc.hipRating() < 8 || tainted) {
					output("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					pc.hipRating(1 + rand(4));
					changes++;
				}
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			//Increase the size of the player's ass (less likely then hips), if it is not already somewhat big
			if (rand(2) == 0 && pc.buttRating() < 13 && changes < changeLimit) {
				if (!tainted && pc.buttRating() < 8 || tainted) {
					output("\n\nA sensation of being unbalanced makes it difficult to walk.  You pause, paying careful attention to your new center of gravity before understanding dawns on you - your ass has grown!", false);
					pc.buttRating(1 + rand(2));
					changes++;
				}
			}
			////Nipples Turn Back:
			//if (pc.findStatusAffect(StatusAffects.BlackNipples) >= 0 && changes < changeLimit && rand(3) == 0) {
				//output("\n\nSomething invisible brushes against your [pc.nipple], making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				//changes++;
				//pc.removeStatusAffect(StatusAffects.BlackNipples);
			//}
			////Debugcunt
			//if (changes < changeLimit && rand(3) == 0 && pc.vaginaType() == 5 && pc.hasVagina()) {
				//output("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				//pc.vaginaType(0);
				//changes++;
			//}
			if (rand(3) == 0 && pc.femininity < 80) output(pc.modFem(3));
			if (rand(3) == 0 && pc.thickness < 70) output(pc.modThickness(4));
			if (rand(5) == 0 && pc.tone > 10) output(pc.modTone(-5));
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
