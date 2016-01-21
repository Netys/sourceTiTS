package classes.Items.Transformatives
{
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.CombatManager;
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
    public class CoCReptilum extends ItemSlotClass
    {
        public function CoCReptilum(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Reptlum";
            //Regular name
            this.longName = "vial of Reptilum";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of Reptilum";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
			
			this.combatUsable = false;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//clear screen
			clearOutput();
			output("You uncork the vial of fluid and drink it down.  The taste is sour, like a dry wine with an aftertaste not entirely dissimilar to alcohol.  Instead of the warmth you'd expect, it leaves your throat feeling cold and a little numb.");

			//Statistical changes:
			//-Reduces speed down to 50.
			if (pc.RQ() > 50 && changes < changeLimit && rand(4) == 0) {
				output("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
				pc.slowStatGain("r", -1);
				changes++;
			}
			//-Reduces sensitivity.
			//if (pc.sens > 20 && changes < changeLimit && rand(3) == 0) {
				//output("\n\nThe sensation of prickly pins and needles moves over your body, leaving your senses a little dulled in its wake.");
				//dynStats("sen", -1);
				//changes++;
			//}
			//Raises libido greatly to 50, then somewhat to 75, then slowly to 100.
			if (pc.libido() < 100 && changes < changeLimit && rand(3) == 0) {
				output("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (pc.hasCock() && (!pc.isHerm() || rand(2) == 0)) {
					output("filling your [pc.eachCock] with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (pc.hasVagina()) output("puddling in your [pc.vagina].  An instinctive desire to mate and lay eggs spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else output("puddling in your featureless crotch for a split-second before it slides into your [pc.asshole].  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				pc.slowStatGain("l", 3);
				changes++;
			}
			//-Raises toughness to 70
			//(+3 to 40, +2 to 55, +1 to 70)
			//if (pc.tou < 70 && changes < changeLimit && rand(3) == 0) {
				////(+3)
				//if (pc.tou < 40) {
					//output("\n\nYour body and skin both thicken noticeably.  You pinch your " + pc.skinDesc + " experimentally and marvel at how much tougher your hide has gotten.", false);
					//dynStats("tou", 3);
				//}
				////(+2)
				//else if (pc.tou < 55) {
					//output("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.", false);
					//dynStats("tou", 2);
				//}
				////(+1)
				//else {
					//output("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your " + pc.skinDesc + " getting tough enough to make you feel invincible.", false);
					//dynStats("tou", 1);
				//}
				//changes++;
			//}

			//Sexual Changes:
			//-Lizard dick - first one
			if (pc.cockTotal(GLOBAL.TYPE_SNAKE) < pc.cockTotal() && pc.cockTotal(GLOBAL.TYPE_SNAKE) == 0 && changes < changeLimit && rand(4) == 0) {
				//Find the first non-lizzy dick
				for (temp2 = 0; temp2 < pc.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (pc.cocks[temp2].cType != GLOBAL.TYPE_SNAKE) break;
				}
				output("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your [pc.gear] to investigate.  Your [pc.cock " + temp2 + "] is changing!  It ripples loosely from ");
				if (pc.hasSheath(temp2)) output("sheath ");
				else output("base ");
				output("to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your [pc.cock " + temp2 + "] resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker ");
				if (pc.cor() < 33) output("horrifies you.");
				else if (pc.cor() < 66) output("is a little strange for your tastes.");
				else {
					output("looks like it might be more fun to receive than use on others.  ");
					if (pc.hasVagina()) output("Maybe you could find someone else with one to ride?");
					else output("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				output("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				pc.shiftCock(temp2, GLOBAL.TYPE_SNAKE);
				
				if (!pc.hasStatusEffect("Genital Slit")) {
					pc.createStatusEffect("Genital Slit", 0, 0, 0, 0);
					output("\n\nAnd seems like you can retract your genitals inside new genital slit!");
				}
				
				changes++;
				pc.slowStatGain("l", 3);
				pc.lust(10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (pc.cockTotal(GLOBAL.TYPE_SNAKE) < pc.cockTotal() && pc.cockTotal(GLOBAL.TYPE_SNAKE) > 0 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your [pc.gear].  As if operating on a cue, ");
				for (temp2 = 0; temp2 < pc.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (pc.cocks[temp2].cType != GLOBAL.TYPE_SNAKE) break;
				}
				if (pc.cockTotal() == 2) output("your other dick");
				else output("another one of your dicks");
				output(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  ");
				if (pc.cumQ() < 50) output("pre-cum oozes from the tip");
				else if (pc.cumQ() < 700) output("Thick pre-cum rains from the tip");
				else output("A wave of pre-cum splatters on the ground");
				output(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				pc.shiftCock(temp2, GLOBAL.TYPE_SNAKE);
				
				if (!pc.hasStatusEffect("Genital Slit")) {
					pc.createStatusEffect("Genital Slit", 0, 0, 0, 0);
					output("\n\nAnd seems like you can retract your genitals inside new genital slit!");
				}
				changes++;
				pc.slowStatGain("l", 3);
				pc.lust(10);
			}
			//-Grows second lizard dick if only 1 dick
			if (pc.cockTotal(GLOBAL.TYPE_SNAKE) == 1 && pc.cockTotal() == 1 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nA knot of pressure forms in your groin, forcing you off your [pc.feet] as you try to endure it.  You examine the affected area and see a lump starting to bulge under your [pc.skin], adjacent to your [pc.cock].  The flesh darkens, turning [pc.cockColor]");
				if (pc.hasFur() || pc.hasScales())
					output(" and shedding [pc.skinFurScales]");
				output(" as the bulge lengthens, pushing out from your body.  Too surprised to react, you can only pant in pain and watch as the fleshy lump starts to take on a penis-like appearance.  <b>You're growing a second lizard-cock!</b>  It doesn't stop growing until it's just as long as its brother and the same shade of [pc.cockColor].  A dribble of cum oozes from its tip, and you feel relief at last.");
				pc.cocks[1] = pc.cocks[0].makeCopy();
				
				if (!pc.hasStatusEffect("Genital Slit")) {
					pc.createStatusEffect("Genital Slit", 0, 0, 0, 0);
					output("\n\nAnd seems like you can retract your genitals inside new genital slit!");
				}
				
				changes++;
				pc.slowStatGain("l", 3);
				pc.lust(10);
			}
			//--Worms leave if 100% lizard dicks?
			//Require mammals?
			if (pc.cockTotal(GLOBAL.TYPE_SNAKE) == pc.cockTotal() && changes < changeLimit && pc.hasStatusEffect("Infested")) {
				output("\n\nLike rats from a sinking ship, worms escape from your body in a steady stream.  Surprisingly, the sensation is remarkably pleasant, similar to the pleasure of sexual release in a way.  Though they seem inexhaustible, the tiny, cum-slimed invertebrates slow to a trickle.  The larger worm-kin inside you stirs as if disturbed from a nap, coming loose from whatever moorings it had attached itself to in the interior of your form.  It slowly works its way up your urethra, stretching to an almost painful degree with every lurching motion.  Your dick bloats out around the base, stretched like the ovipositor on a bee-girl in order to handle the parasitic creature, but thankfully, the ordeal is a brief one.");
				if (pc.balls > 1) output("  The remaining " + num2Text(pc.balls - 1) + " slither out the pre-stretched holes with ease, though the last one hangs from your tip for a moment before dropping to the ground.");
				output("  The white creature joins its kin on the ground and slowly slithers away.  Perhaps they prefer mammals? In any event, <b>you are no longer infected with worms</b>.");
				pc.removeStatusEffect("Infested");
				changes++;
			}
			//-Breasts vanish to 0 rating if male
			if (pc.biggestTitSize() >= 1 && pc.hasCock() && !pc.hasVagina() && changes < changeLimit && rand(3) == 0) {
				//(HUEG)
				if (pc.biggestTitSize() > 8) {
					output("\n\nThe flesh on your chest tightens up, losing nearly half its mass in the span of a few seconds.  With your center of balance shifted so suddenly, you stagger about trying not to fall on your ass.  You catch yourself and marvel at the massive change in breast size.");
					//Half tit size
				}
				//(NOT HUEG < 4)
				else output("\n\nIn an instant, your chest compacts in on itself, consuming every ounce of breast-flesh.  You're left with a  smooth, masculine torso, though your nipples remain.");
				//(BOTH – no new PG)
				output("  With the change in weight and gravity, you find it's gotten much easier to move about.");
				//Loop through behind the scenes and adjust all tits.
				for (temp2 = 0; temp2 < pc.breastRows.length; temp2++) {
					if (pc.breastRows[temp2].breastRatingRaw > 8) pc.breastRows[temp2].breastRatingRaw /= 2;
					else pc.breastRows[temp2].breastRatingRaw = 0;
				}
				//(+2 speed)
				//dynStats("lib", 2);
				pc.slowStatGain("l", 2); // FIXME: libido or reflexes?
				changes++;
			}
			//-Lactation stoppage.
			if (pc.canLactate() && changes < changeLimit && rand(4) == 0) {
				if (pc.totalNipples() == 2) output("\n\nBoth");
				else output("\n\nAll");
				output(" of your nipples relax.  It's a strange feeling, and you pull back your top to touch one.  It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel when nothing ");
				if (pc.hasFuckableNipples()) output("but sexual fluid ");
				output("escapes it.  <b>You are no longer lactating.</b>  That makes sense, only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.");
				if (pc.hasPerk("Feeder") || pc.hasStatusEffect("Feeder")) {
					output("\n\n(<b>Feeder perk lost!</b>)", false);
					pc.removePerk("Feeder");
					pc.removeStatusEffect("Feeder");
				}
				pc.milkFullness = 0;
				pc.milkMultiplier = 0;
				changes++;
			}
			//-Nipples reduction to 1 per tit.
			if (pc.nipplesPerBreast > 1 && changes < changeLimit && rand(4) == 0) {
				output("\n\nA chill runs over your [pc.fullChest] and vanishes.  You stick a hand under your [pc.gear] and discover that your extra nipples are missing!  You're down to just one per ");
				if (pc.biggestTitSize() < 1) output("'breast'.");
				else output("breast.");
				pc.nipplesPerBreast = 1;
				changes++;
			}
			//-VAGs
			if (pc.hasVagina() && !pc.hasPerk("Oviposition") && changes < changeLimit && rand(5) == 0 && pc.lizardScore() > 3) {
				output("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n", false);
				output("(<b>Perk Gained: Oviposition</b>)", false);
				pc.createPerk("Oviposition", 0, 0, 0, 0, "Causes you to regularly lay eggs when not otherwise pregnant.");
				changes++;
			}

			//Physical changes:
			//-Existing horns become draconic, max of 4, max length of 1'
			if ((pc.hornType != GLOBAL.TYPE_DRACONIC || pc.horns < 4 || pc.hornLength < 12) && changes < changeLimit && rand(5) == 0) {
				//No dragon horns yet.
				if (!pc.hasHorns(GLOBAL.TYPE_DRACONIC) && !pc.hasHorns(GLOBAL.TYPE_LIZAN)) {
					//Already have horns
					if (pc.hasHorns()) {
						// horns
						if (pc.horns * pc.hornLength >= 36) {
							output("\n\nYour [pc.horns] condense, twisting around each other and merging into different, pointed protrusions.  By the time they finish you have four draconic-looking horns, each about twelve inches long.");
							pc.hornType = GLOBAL.TYPE_DRACONIC;
							pc.hornLength = 12;
							pc.horns = 4;
						}
						else {
							output("\n\nYou feel your [pc.horns] changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
							pc.hornType = GLOBAL.TYPE_LIZAN;
							pc.horns = 2;
							if (pc.horns > 12) {
								output("  The change seems to have shrunken the horns, they're about a foot long now.");
								pc.hornLength = 12;
							}
						}
						changes++;
					}
					//No horns
					else {
						//-If no horns, grow a pair
						output("\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horn sprout from your head before stopping.  <b>You have about four inches of dragon-like horn.</b>");
						pc.horns = 2;
						pc.hornLength = 4;
						pc.hornType = GLOBAL.TYPE_LIZAN;

						changes++;
					}
				}
				//ALREADY DRAGON
				else {
					if (pc.hornLength < 12) {
						if (rand(2) == 0) {
							output("\n\nYou get a headache as an inch of fresh horn escapes from your pounding skull.");
							pc.hornLength += 1;
						}
						else {
							output("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
							pc.hornLength += 2 + rand(4);
						}
						if (pc.hornLength >= 12) {
							output("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
							pc.hornLength = 12;
						}
						changes++;
					}
					//maxxed out, new row
					else if(pc.horns < 4 || pc.hornType != GLOBAL.TYPE_DRACONIC) {
						//--Next horn growth adds second row and brings length up to 12\"
						output("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a lizan can grow.</b>");
						pc.hornType = GLOBAL.TYPE_DRACONIC;
						pc.horns = 4;
						pc.hornLength = 12;
						changes++;
					}
				}
			}
			//-Hair stops growing!
			//if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0 && changes < changeLimit && rand(4) == 0) {
				//output("\n\nYour scalp tingles oddly.  In a panic, you reach up to your " + hairDescript() + ", but thankfully it appears unchanged.\n\n", false);
				//output("(<b>Your hair has stopped growing.</b>)", false);
				//changes++;
				//flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD]++;
			//}
			//Remove beard!
			if (pc.hasBeard() && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour [pc.beard] feels looser and looser until finally, falls out.  ");
				output("(<b>You no longer have a beard!</b>)");
				pc.removeBeard();
			}
			//Big physical changes:			
			//Make legs lizard-like. Ovir copypaste.
			var tfLowerBody:Boolean = (pc.legCount != 2 && pc.legCountUnlocked(2)) || (pc.legType != GLOBAL.TYPE_LIZAN && pc.legTypeUnlocked(GLOBAL.TYPE_LIZAN));
			if (tfLowerBody && (changes < changeLimit && rand(2) == 0))
			{
				output("\n\nA small twinge of pain hits you, then another one, and another. Suddenly your entire body is on fire. You double over and collapse. Your vision slowly slips away, and you black out. When you come to again, you stand up on shaky feet");
				if (pc.legCount != 2) output("... two shaky feet");
				output(". You look down, perplexed. It seems that when you were unconscious, your lower body has reshaped,");
				if (pc.legCount != 2 || !pc.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) output(" taking on a bipedal, digitigrade appearance!  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				else output(" gaining a lusiously scaled covering!");
				output("  <b>You have reptilian legs and claws!</b>", false);

				pc.genitalSpot = 0;
				pc.legCount = 2;
				pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_SCALED];
				pc.legType = GLOBAL.TYPE_LIZAN;

				changes++;
			}
			//-Tail – sinuous lizard tail
			if (!pc.hasTail(GLOBAL.TYPE_LIZAN) && pc.legType == GLOBAL.TYPE_LIZAN && changes < changeLimit && rand(5) == 0) {
				//No tail
				if (!pc.hasTail()) output("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your [pc.ass] to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>");
				//Yes tail
				else output("\n\nYou drop to the ground as your [pc.tail] twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>", false);
				pc.tailCount = 1;
				pc.tailType = GLOBAL.TYPE_LIZAN;
				pc.tailFlags = [GLOBAL.FLAG_SCALED, GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_THICK, GLOBAL.FLAG_TAPERED];
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && pc.eyeType != GLOBAL.TYPE_SNAKE) {
				output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [pc.feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				//if (pc.eyeType == EYES_FOUR_SPIDER_EYES) output("  Your multiple, arachnid eyes are gone!</b>", false);
				output("  <b>You have vertical slitted reptilian eyes.</b>");
				pc.eyeType = GLOBAL.TYPE_SNAKE;
				changes++;
			}
			//-Ears become smaller nub-like openings?
			if (pc.earType != GLOBAL.TYPE_LIZAN && pc.hasTail(GLOBAL.TYPE_LIZAN) && pc.legType == GLOBAL.TYPE_LIZAN && changes < changeLimit && rand(5) == 0) {
				output("\n\nTightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers.  <b>You have reptilian ears!</b>");
				pc.earType = GLOBAL.TYPE_LIZAN;
				changes++;
			}
			//-Scales – color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (pc.skinType != GLOBAL.SKIN_TYPE_SCALES && pc.earType == GLOBAL.TYPE_LIZAN && pc.hasTail(GLOBAL.TYPE_LIZAN) && pc.legType == GLOBAL.TYPE_LIZAN && changes < changeLimit && rand(5) == 0) {
				//(fur)
				if (pc.hasFur()) {
					//set new skinTone
					if (rand(10) == 0)
						pc.scaleColor = RandomInCollection("purple", "silver");
					//non rare skinTone
					else
						pc.scaleColor = RandomInCollection("red", "green", "white", "blue", "black");
					output("\n\nYou scratch yourself, and come away with a large clump of fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + pc.skinTone + " scales covering most of your body.  The rest of the fur is easy to remove.  <b>You're now covered in scales from head to toe.</b>");
				}
				//(no fur)
				else {
					output("\n\nYou idly reach back to scratch yourself and nearly jump out of your [pc.gear] when you hit something hard.  A quick glance down reveals that scales are growing out of your [pc.skinFurScales] with alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so well that they may as well be seamless.  You peel back your [pc.gear] and the transformation has already finished on the rest of your body.  <b>You're covered from head to toe in shiny ");					
					//set new skinTone
					if (rand(10) == 0)
						pc.scaleColor = RandomInCollection("purple", "silver");
					//non rare skinTone
					else
						pc.scaleColor = RandomInCollection("red", "green", "white", "blue", "black");
					output(pc.scaleColor + " scales.</b>");
				}
				
				pc.skinType = GLOBAL.SKIN_TYPE_SCALES;
				pc.skinFlags = [];
				changes++;
			}
			//-Lizard-like face.
			if (pc.faceType != GLOBAL.TYPE_LIZAN && pc.skinType == GLOBAL.SKIN_TYPE_SCALES && pc.earType == GLOBAL.TYPE_LIZAN && pc.hasTail(GLOBAL.TYPE_LIZAN) && pc.legType == GLOBAL.TYPE_LIZAN && changes < changeLimit && rand(5) == 0) {
				output("\n\nTerrible agony wracks your [pc.face] as bones crack and shift.  Your jawbone rearranges while your cranium shortens.  The changes seem to last forever; once they've finished, no time seems to have passed.  Your fingers brush against your toothy snout as you get used to your new face.  It seems <b>you have a toothy, reptilian visage now.</b>");
				pc.faceType = GLOBAL.TYPE_LIZAN;
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			//FAILSAFE CHANGE
			if (changes == 0) {
				output("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				pc.lust(3);
				pc.HP(50);
			}
			//pc.refillHunger(20);
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
