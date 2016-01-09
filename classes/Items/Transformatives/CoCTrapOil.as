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
	
    public class CoCTrapOil extends ItemSlotClass
    {
        public function CoCTrapOil(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "TrapOil";
            //Regular name
            this.longName = "vial of trap oil";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of trap oil";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			var temp:Number = 0;
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			output("You pour some of the oil onto your hands and ");
			if (pc.cor() < 30) output("hesitantly ");
			else if (pc.cor() > 70) output("eagerly ");
			output("rub it into your arms and chest.  The substance is warm, coating and ever so slightly numbing; it quickly sinks into your skin, leaving you feeling smooth and sleek.");

			//Speed Increase:
			if (pc.RQ() < 100 && rand(3) == 0 && changes < changeLimit) {
				output("\n\nYou feel fleet and lighter on your [pc.toes]; you sense you could dodge, dart or skip away from anything.");
				//dynStats("spe", 1);
				pc.slowStatGain("r", 1);
				changes++;
			}
			//Strength Loss:
			else if (pc.PQ() > 40 && rand(3) == 0 && changes < changeLimit) {
				output("\n\nA sense of helplessness settles upon you as your limbs lose mass, leaving you feeling weaker and punier.");
				pc.slowStatGain("p", -1);
				changes++;
			}
			//Sensitivity Increase:
			//if (pc.sens < 70 && pc.hasCock() && rand(3) == 0 && changes < changeLimit) {
				//output("\n\nA light breeze brushes over you and your skin tingles.  You have become more sensitive to physical sensation.");
				//dynStats("sen", 5);
				//changes++;
			//}
			//Libido Increase:
			if (pc.libido() < 70 && pc.hasVagina() && rand(3) == 0 && changes < changeLimit) {
				output("\n\nYou feel your blood quicken and rise, and a desire to... hunt builds within you.");
				pc.slowStatGain("l", 2);
				if (pc.libido() < 30) pc.slowStatGain("l", 2);
				changes++;
			}
			//Body Mass Loss:
			if (pc.thickness > 40 && rand(3) == 0 && changes < changeLimit) {
				output("\n\nYou feel an odd tightening sensation in your midriff, as if you were becoming narrower and lither.  You frown downwards, and then turn your arms around, examining them closely.  Is it just you or have you lost weight?");
				pc.modThickness(-3);
				changes++;
			}

			//Thigh Loss: (towards “girly”)
			if (pc.hipRating() >= 10 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou touch your thighs speculatively.  It's not just your imagination; you've lost a bit of weight around your waist.");
				pc.hipRating(-1);
				if (pc.hipRating() > 15) pc.hipRating(-(2 + rand(3)));
				changes++;
			}
			//Thigh Gain: (towards “girly”)
			if (pc.hipRating() < 6 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou touch your thighs speculatively.  You think you may have gained a little weight around your waist.");
				pc.hipRating(1);
				changes++;
			}
			//Breast Loss: (towards A cup)
			if (pc.biggestTitSize() > 1 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou gasp as you feel a compressing sensation in your chest and around your [pc.fullChest].  The feeling quickly fades however, leaving you feeling like you have lost a considerable amount of weight from your upper body.");
				temp = 0;
				while (temp < pc.bRows()) {
					if (pc.breastRows[temp].breastRating > 70) pc.breastRows[temp].breastRating(-(rand(3) + 15));
					else if (pc.breastRows[temp].breastRating > 50) pc.breastRows[temp].breastRating(-(rand(3) + 10));
					else if (pc.breastRows[temp].breastRating > 30) pc.breastRows[temp].breastRating(-(rand(3) + 7));
					else if (pc.breastRows[temp].breastRating > 15) pc.breastRows[temp].breastRating(-(rand(3) + 4));
					else pc.breastRows[temp].breastRating(-(2 + rand(2)));
					if (pc.breastRows[temp].breastRating < 1) pc.breastRows[temp].breastRating = 1;
					temp++;
				}
				changes++;
			}
			//Breast Gain: (towards A cup)
			if (pc.biggestTitSize() < 1 || pc.breastRows[0].breastRating < 1 && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou feel a vague swelling sensation in your [pc.fullChest], and you frown downwards.  You seem to have gained a little weight on your chest.  Not enough to stand out, but- you cup yourself carefully- certainly giving you the faintest suggestion of boobs.");
				pc.breastRows[0].breastRatingRaw = 1;
				if (pc.bRows() > 1) {
					temp = 1;
					while (temp < pc.bRows()) {
						if (pc.breastRows[temp].breastRatingRaw < 1) pc.breastRows[temp].breastRatingRaw = 1;
					}
				}
				changes++;
			}
			//Penis Reduction towards 3.5 Inches:
			if (pc.longestCockLength() >= 3.5 && pc.hasCock() && rand(2) == 0 && changes < changeLimit) {
				output("\n\nYou flinch and gasp as your [pc.cocksLight] suddenly become");
				if (pc.cockTotal() == 1) output("s");
				output(" incredibly sensitive and retract into your body.  Anxiously you pull down your underclothes to examine your nether regions.  To your relief ");
				if (pc.cockTotal() == 1) output("it is");
				else output("they are");
				output(" still present, and as you touch ");
				if (pc.cockTotal() == 1) output("it");
				else output("them");
				output(", the sensitivity fades, however - a blush comes to your cheeks - ");
				if (pc.cockTotal() == 1) output("it seems");
				else output("they seem");
				output(" to have become smaller.");
				temp = 0;
				while (temp < pc.cockTotal()) {
					if (pc.cocks[temp].cLength() >= 3.5) {
						//Shrink said cock
						if (pc.cocks[temp].cLength() < 6 && pc.cocks[temp].cLength() >= 2.9) {
							pc.cocks[temp].cLength(-.5);
						}
						pc.cocks[temp].cLength(-.5);
						pc.cocks[temp].growCock(Math.round(pc.cocks[temp].cLength() * 0.33) * -1);
					}
					temp++;
				}
				changes++;
			}
			//Testicle Reduction:
			if (pc.balls > 0 && pc.hasCock() && (pc.ballSizeRaw > 0.75 || !pc.hasStatusEffect("Uniball")) && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou feel a delicate tightening sensation around your [pc.balls].  The sensation upon this most sensitive part of your anatomy isn't painful, but the feeling of your balls getting smaller is intense enough that you stifle anything more than a sharp intake of breath only with difficulty.");
				pc.ballSizeRaw -= 1;
				if (pc.ballSizeRaw > 8) pc.ballSizeRaw--;
				if (pc.ballSizeRaw > 10) pc.ballSizeRaw--;
				if (pc.ballSizeRaw > 12) pc.ballSizeRaw--;
				if (pc.ballSizeRaw > 15) pc.ballSizeRaw--;
				if (pc.ballSizeRaw > 20) pc.ballSizeRaw--;
				//Testicle Reduction final:
				if (pc.ballSizeRaw < 0.75 && !pc.hasStatusEffect("Uniball")) {
					output("  You whimper as once again, your balls tighten and shrink.  Your eyes widen when you feel the gentle weight of your testicles pushing against the top of your [pc.hips], and a few hesitant swings of your rear confirm what you can feel - you've tightened your balls up so much they no longer hang beneath your [pc.cocksLight], but press perkily upwards.  Heat ringing your ears, you explore your new sack with a careful hand.  You are deeply grateful you apparently haven't reversed puberty, but you discover that though you still have " + num2Text(pc.balls) + ", your balls now look and feel like one: one cute, tight little sissy parcel, its warm, insistent pressure upwards upon the joining of your thighs a never-ending reminder of it.");
					//[Note: Balls description should no longer say “swings heavily beneath”.  For simplicity's sake sex scenes should continue to assume two balls]
					pc.ballSizeRaw = 0.75;
					pc.createStatusEffect("Uniball", 0, 0, 0, 0);
				}
				else if (pc.ballSizeRaw < 0.75) pc.ballSizeRaw = 0.75;
				changes++;
			}
			//Anal Wetness Increase:
			if (pc.ass.wetness() < 5 && rand(4) == 0 && changes < changeLimit) {
				if (pc.ass.wetness() < 4) output("\n\nYour eyes widen in shock as you feel oily moisture bead out of your [pc.asshole].  Your asshole has become wetter and more pliable.");
				//Anal Wetness Increase Final (always loose):
				else {
					output("\n\nYou moan as clear, odorless oil dribbles out of your [pc.asshole], this time in enough quantity to stain your ");
					output(pc.isAssExposed() ? "[pc.thighs]" : "[pc.lowerGarments]");
					output(".  Your back passage feels incredibly sensitive, wet and accommodating.  Your ass is ready to be plowed by anything, and always will be.");
				}
				pc.ass.wetness(1);
				//buttChange(30,false,false,false);
				if (pc.ass.looseness() < 3) pc.ass.looseness(1);
				changes++;
				//dynStats("sen", 2);
			}
			//Fertility Decrease:
			// FIXME: not sure how to calculate this now
			//if (pc.hasVagina() && rand(4) == 0 && changes < changeLimit) {
				//output("\n\nThe vague numbness in your skin sinks slowly downwards, and you put a hand on your lower stomach as the sensation centers itself there.  ");
				////dynStats("sen", -2);
				////High fertility:
				//if (pc.fertility() >= 1.3) output("It feels like your overcharged reproductive organs have simmered down a bit.");
				////Average fertility:
				//else if (pc.fertility() >= 1.05) output("You feel like you have dried up a bit inside; you are left feeling oddly tranquil.");
				////[Low/No fertility:
				//else {
					//output("Although the numbness makes you feel serene, the trap oil has no effect upon your ");
					//if (pc.fertility > 0) output("mostly ");
					//output("sterile system.");
					////[Low/No fertility + Trap/Corruption  >70:
					//if (cor() > 70) output("  For some reason the fact that you cannot function as nature intended makes you feel helpless and submissive.  Perhaps the only way to be a useful creature now is to find a dominant, fertile being willing to plow you full of eggs? You shake the alien, yet oddly alluring thought away.");
				//}
				//pc.fertility -= 1 + rand(3);
				//if (pc.fertility < 4) pc.fertility = 4;
				//changes++;
			//}
			//Male Effects
			if (pc.hasCock() && !pc.hasVagina()) {
				//Femininity Increase Final (max femininity allowed increased by +10):
				if (rand(4) == 0 && changes < changeLimit) {
					if (pc.femininity < 70 && pc.femininity >= 60) {
						output("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a girly giggle than anything else.  Feeling slightly more sober, you touch the soft flesh of your face prospectively.  The trap oil has changed you profoundly, making your innate maleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a girl now if you wanted to.");
						//if (pc.findPerk(PerkLib.Androgyny) < 0) {
							//pc.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							//output("\n\n(<b>Perk Gained: Androgyny</b>)");
						//}
						pc.femininity += 10;
						if (pc.femininity > 70) pc.femininity = 70;
						changes++;
					}
					//Femininity Increase:
					else {
						output("\n\nYour face softens as your features become more feminine.");
						pc.femininity += 10;
						changes++;
					}
				}
				//Muscle tone reduction:
				if (pc.tone > 20 && rand(4) == 0 && changes < changeLimit) {
					output("\n\nYou sink a finger into your arm inquiringly.  You seem to have lost some of your muscle definition, leaving you looking softer.");
					pc.tone -= 10;
					changes++;
				}
			}
			//Female Effects
			else if (!pc.hasCock() && pc.hasVagina()) {
				//Masculinity Increase:
				if (pc.femininity > 30 && rand(4) == 0 && changes < changeLimit) {
					pc.femininity -= 10;
					if (pc.femininity < 30) {
						pc.femininity = 30;
						//Masculinity Increase Final (max masculinity allowed increased by +10):
						output("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a boyish crow than anything else.  Feeling slightly more sober, you touch the defined lines of your face prospectively.  The trap oil has changed you profoundly, making your innate femaleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a boy now if you wanted to.");
						//if (pc.findPerk(PerkLib.Androgyny) < 0) {
							//pc.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							//output("\n\n(<b>Perk Gained: Androgyny</b>)");
						//}
					}
					else {
						output("\n\nYour face becomes more set and defined as your features turn more masculine.");
					}
					changes++;
				}
				//Muscle tone gain:
				if (pc.tone < 80 && rand(4) == 0 && changes < changeLimit) {
					output("\n\nYou flex your arm in interest.  Although you have become thinner, your muscles seem to have become more defined.");
					pc.tone += 10;
					changes++;
				}
			}
			//Nipples Turn Black:
			if (pc.nippleColor != "black" && rand(6) == 0 && changes < changeLimit) {
				output("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of [pc.nippleColor] tone disappear from your ");
				pc.nippleColor = "black";
				output("[pc.nipples].  They have turned an onyx black!");
				changes++;
			}
			//Remove odd eyes
			//if (pc.eyeType == EYES_FOUR_SPIDER_EYES && rand(2) == 0 && changes < changeLimit) {
				//output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + pc.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.", false);
				//if (pc.eyeType == EYES_FOUR_SPIDER_EYES) output("  Your multiple, arachnid eyes are gone!</b>", false);
				//output("  <b>You have normal, humanoid eyes again.</b>", false);
				//pc.eyeType = EYES_HUMAN;
				//changes++;
			//}
			//PC Trap Effects
			if ((pc.eyeType != GLOBAL.TYPE_BEE || pc.eyeColor != "black") && rand(4) == 0 && changes < changeLimit) {
				//Eyes Turn Black:
				output("\n\nYou blink, and then blink again.  It feels like something is irritating your eyes.  Panic sets in as black suddenly blooms in the corner of your left eye and then your right, as if drops of ink were falling into them.  You calm yourself down with the thought that rubbing at your eyes will certainly make whatever is happening to them worse; through force of will you hold your hands behind your back and wait for the strange affliction to run its course.  The strange inky substance pools over your entire vision before slowly fading, thankfully taking the irritation with it.  As soon as it goes you stride quickly over to the stream and stare at your reflection.  <b>Your pupils, your irises, your entire eye has turned a liquid black</b>, leaving you looking vaguely like the many half insect creatures which inhabit these lands.  You find you are merely grateful the change apparently hasn't affected your vision.");
				pc.eyeType = GLOBAL.TYPE_BEE;
				pc.eyeColor = "black";
				changes++;
			}
			//Vagina Turns Black:
			if (pc.hasVagina() && pc.vaginaColor(0) != "black" && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYour [pc.vagina] feels... odd.  You undo your clothes and gingerly inspect your nether regions.  The tender [pc.vaginaColor] color of your sex has disappeared, replaced with smooth, marble blackness starting at your lips and working inwards.");
				//(Wet:
				if (pc.wetness() >= 3) output("  Your natural lubrication makes it gleam invitingly.");
				//(Corruption <50:
				if (pc.cor() < 50) output("  After a few cautious touches you decide it doesn't feel any different- it does certainly look odd, though.");
				else output("  After a few cautious touches you decide it doesn't feel any different - the sheer bizarreness of it is a big turn on though, and you feel it beginning to shine with anticipation at the thought of using it.");
				output("  <b>Your vagina is now ebony in color.</b>");
				//dynStats("sen", 2, "lus", 10);
				pc.lust(10);
				pc.vaginas[0].vaginaColor = "black";
				changes++;
			}
			//Dragonfly Wings:
			if (pc.wingType != GLOBAL.TYPE_DRAGONFLY && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades.  After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back.  You clench the dirt as you slide what feel like giant leaves of paper into the open air.  Eventually the sensation passes and you groggily get to your feet.  You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful.  You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground.  What fun this is going to be!");
				//Wings Fall Out: You feel a sharp pinching sensation in your shoulders and you cringe slightly.  Your former dragonfly wings make soft, papery sounds as they fall into the dirt behind you.
				changes++;
				pc.wingType = GLOBAL.TYPE_DRAGONFLY;
			}
			if (changes == 0) {
				output("\n\nWell... that didn't amount to much.");
			}
			kGAMECLASS.flags["COC.TIMES_TRANSFORMED"] += changes;
			return false;
		}
	}	
}
