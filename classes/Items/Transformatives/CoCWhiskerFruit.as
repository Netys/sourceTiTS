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
	
    public class CoCWhiskerFruit extends ItemSlotClass
    {
        public function CoCWhiskerFruit(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "W.Fruit";
            //Regular name
            this.longName = "Whisker fruit";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a piece of whisker-fruit";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
		
		public static var catFurColor:Vector.<String> = Vector.<String>(["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white"]);
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Text go!
			clearOutput();
			output("You take a bite of the fruit and gulp it down. It's thick and juicy and has an almost overpowering sweetness. Nevertheless, it is delicious and you certainly could use a meal.  You devour the fruit, stopping only when the hard, nubby pit is left; which you toss aside.");
			//Speed raises up to 75
			if (pc.RQ() < 75 && rand(3) == 0 && changes < changeLimit) {
				//low speed
				if (pc.RQ() <= 30) {
					output("\n\nYou feel... more balanced, sure of step. You're certain that you've become just a little bit faster.");
					pc.reflexes(2);
				}
				//medium speed
				else if (pc.RQ() <= 60) {
					output("\n\nYou stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.");
					pc.reflexes(1);
				}
				//high speed
				else {
					output("\n\nYou pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.");
					pc.reflexes(0.5);
				}
				changes++;
			}
			//Strength raises to 40
			if (pc.PQ() < 40 && rand(3) == 0 && changes < changeLimit) {
				if (rand(2) == 0) output("\n\nYour muscles feel taut, like a coiled spring, and a bit more on edge.");
				else output("\n\nYou arch your back as your muscles clench painfully.  The cramp passes swiftly, leaving you feeling like you've gotten a bit stronger.");
				pc.physique( 1);
				changes++;
			}
			//Strength ALWAYS drops if over 60
			//Does not add to change total
			else if (pc.PQ() > 60 && rand(2) == 0) {
				output("\n\nShivers run from your head to your toes, leaving you feeling weak.  Looking yourself over, your muscles seemed to have lost some bulk.");
				pc.physique( -1);
			}
			//Intelliloss
			if (rand(4) == 0 && changes < changeLimit && pc.intelligenceRaw >= 2) {
				//low intelligence
				if (pc.IQ() < 15 || pc.intelligenceRaw <= 2) output("\n\nYou feel like something is slipping away from you but can't figure out exactly what's happening.  You scrunch up your " + pc.face() + ", trying to understand the situation.  Before you can reach any kind of conclusion, something glitters in the distance, distracting your feeble mind long enough for you to forget the problem entirely.");
				//medium intelligence
				else if (pc.IQ() < 50) {
					output("\n\nYour mind feels somewhat sluggish, and you wonder if you should just lie down ");
					if (rand(2) == 0) {
						output("somewhere and ");
						output(RandomInCollection([
						"toss a ball around or something",
						"play with some yarn",
						"take a nap and stop worrying"]));
					}
					else output("in the sun and let your troubles slip away");
					output(".");
				}
				//High intelligence
				else output("\n\nYou start to feel a bit dizzy, but the sensation quickly passes.  Thinking hard on it, you mentally brush away the fuzziness that seems to permeate your brain and determine that this fruit may have actually made you dumber.  It would be best not to eat too much of it.");
				pc.intelligence(-1);
				changes++;
			}
			//Libido gain
			if (pc.libido() < 80 && changes < changeLimit && rand(4) == 0) {
				//Cat dicked folks
				if (pc.cockTotal(GLOBAL.TYPE_FELINE) > 0) {
					temp = pc.findFirstOfcType(GLOBAL.TYPE_FELINE);
					output("\n\nYou feel your " + pc.cockDescript(temp) + " growing hard, the barbs becoming more sensitive. You gently run your hands down them and imagine the feeling of raking the insides of a cunt as you pull.  The fantasy continues, and after ejaculating and hearing the female yowl with pleasure, you shake your head and try to drive off the image.  ");
					if (pc.cor() < 33) output("You need to control yourself better.");
					else if (pc.cor() < 66) output("You're not sure how you feel about the fantasy.");
					else output("You hope to find a willing partner to make this a reality.");
				}
				//Else –
				else {
					output("\n\nA rush of tingling warmth spreads through your body as it digests the fruit.  You can feel your blood pumping through your extremities, making them feel sensitive and surprisingly sensual.  It's going to be hard to resist getting ");
					if (pc.lust() > 60) output("even more ");
					output("turned on.");
				}
				//dynStats("lib", 1, "sen", .25);
				pc.libido(1);
				changes++;
			}
			
			//Sexual changes would go here if I wasn't a tard.
			//Heat
			if (rand(4) == 0 && changes < changeLimit) 
			{
				var intensified:Boolean = pc.hasStatusEffect("Heat");
        
				if (kGAMECLASS.goIntoHeat(false)) 
				{
					if (intensified) 
					{
						if (rand(2) == 0) output("\n\nThe itch inside your [pc.vagina] is growing stronger, and you desperately want to find a nice cock to massage the inside.");
						else output("\n\nThe need inside your [pc.vagina] grows even stronger.  You desperately need to find a mate to 'scratch your itch' and fill your womb with kittens.  It's difficult NOT to think about a cock slipping inside your moist fuck-tunnel, and at this point you'll have a hard time resisting ANY male who approaches.");
					}
					else 
					{
						output("\n\nThe interior of your [pc.vagina] clenches tightly, squeezing with reflexive, aching need.  Your skin flushes hot ");
						if (pc.hasFur()) output("underneath your fur ");
						output("as images and fantasies ");
						if (pc.cor() < 50 && pc.libido() < 50) output("assault ");
						else output("fill ");
						output(" your mind.  Lithe cat-boys with their perfect, spine-covered cocks line up behind you, and you bend over to present your needy pussy to them.  You tremble with the desire to feel the exotic texture of their soft barbs rubbing your inner walls, smearing your [pc.vagina] with their cum as you're impregnated.  Shivering, you recover from the fantasy and pull your fingers from your aroused sex.  <b>It would seem you've gone into heat!</b>");
					}
					changes++;
				}
			}
			
			//Shrink the boobalies down to A for men or C for girls.
			if (changes < changeLimit && rand(4) == 0) {
				temp2 = 0;
				temp3 = 0;
				//Determine if shrinkage is required
				//and set temp2 to threshold
				if (!pc.hasVagina() && pc.biggestTitSize() > 2) temp2 = 2;
				else if (pc.biggestTitSize() > 4) temp2 = 4;
				//IT IS!
				if (temp2 > 0) {
					//temp3 stores how many rows are changed
					temp3 = 0;
					for (var k:Number = 0; k < pc.breastRows.length; k++) {
						//If this row is over threshhold
						if (pc.breastRows[k].breastRatingRaw > temp2) {
							//Big change
							if (pc.breastRows[k].breastRatingRaw > 10) {
								pc.breastRows[k].breastRating(-2 - rand(3));
								if (temp3 == 0) output("\n\nThe " + pc.breastDescript(0) + " on your chest wobble for a second, then tighten up, losing several cup-sizes in the process!");
								else output("  The change moves down to your " + num2Ordinal(k + 1) + " row of " + pc.breastDescript(k) + ". They shrink greatly, losing a couple cup-sizes.");
							}
							//Small change
							else {
								pc.breastRows[k].breastRating(-1);
								if (temp3 == 0) output("\n\nAll at once, your sense of gravity shifts.  Your back feels a sense of relief, and it takes you a moment to realize your " + pc.breastDescript(k) + " have shrunk!");
								else output("  Your " + num2Ordinal(k + 1) + " row of " + pc.breastDescript(k) + " gives a tiny jiggle as it shrinks, losing some off its mass.");
							}
							//Increment changed rows
							temp3++;
						}
					}
				}
				//Count that tits were shrunk
				if (temp3 > 0) changes++;
			}
			//Cat dangly-doo.
			if (pc.cockTotal() > 0 && pc.cockTotal(GLOBAL.TYPE_FELINE) < pc.cockTotal() && (pc.earType == GLOBAL.TYPE_FELINE || rand(3) > 0) && (pc.tailType == GLOBAL.TYPE_FELINE || rand(3) > 0) && changes < changeLimit && rand(4) == 0) {
				//loop through and find a non-cat wang.
				for (var i:Number = 0; i < (pc.cockTotal()) && pc.cocks[i].cType == GLOBAL.TYPE_FELINE; i++) {}
				output("\n\nYour " + pc.cockDescript(i) + " swells up with near-painful arousal and begins to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your [pc.cockNoun " + i + "] and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.  ");
				if (!pc.hasSheath(i)) {
					output("Then, it begins to shrink and sucks itself inside your body.  Within a few moments, a fleshy sheath is formed.");
					if (pc.balls > 0) output("  Thankfully, your balls appear untouched.");
				}
				else output("Then, it disappears back into your sheath.");
				pc.cocks[i].cType = GLOBAL.TYPE_FELINE;
				pc.cocks[i].knotMultiplier = 1;
				pc.cocks[i].cockFlags = [GLOBAL.FLAG_NUBBY, GLOBAL.FLAG_TAPERED, GLOBAL.FLAG_SHEATHED];
				changes++;
			}
			//Cat penorz shrink
			if (pc.cockTotal(GLOBAL.TYPE_FELINE) > 0 && rand(3) == 0 && changes < changeLimit) {
				//loop through and find a cat wang.
				temp = 0;
				for (var j:Number = 0; j < (pc.cockTotal()); j++) {
					if (pc.cocks[j].cType == GLOBAL.TYPE_FELINE && pc.cocks[j].cLength() > 6) {
						temp = 1;
						break;
					}
				}
				if (temp == 1) {
					//lose 33% size until under 10, then lose 2" at a time
					if (pc.cocks[j].cLength() > 16) {
						output("\n\nYour " + pc.cockDescript(j) + " tingles, making your sheath feel a little less tight.  It dwindles in size, losing a full third of its length and a bit of girth before the change finally stops.");
						pc.cocks[j].cLength(pc.cocks[j].cLength() * .66);
					}
					else if (pc.cocks[j].cLength() > 6) {
						output("\n\nYour " + pc.cockDescript(j) + " tingles and withdraws further into your sheath.  If you had to guess, you'd say you've lost about two inches of total length and perhaps some girth.");
						pc.cocks[j].cLength(-2);
					}
					//Check for any more!
					temp2 = 0;
					j++;
					for (j; j < pc.cocks.length; j++) {
						//Found another cat wang!
						if (pc.cocks[j].cType == GLOBAL.TYPE_FELINE) {
							//Long enough - change it
							if (pc.cocks[j].cLength() > 6) {
								if (pc.cocks[j].cLength() > 16)
									pc.cocks[j].cLength(pc.cocks[j].cLength()*.66);
								else if (pc.cocks[j].cLength() > 6)
									pc.cocks[j].cLength(-2);
								temp2 = 1;
							}
						}
					}
					//(big sensitivity boost)
					output("  Although the package is smaller, it feels even more sensitive – as if it retained all sensation of its larger size in its smaller form.");
					//dynStats("sen", 5);
					//Make note of other dicks changing
					if (temp2 == 1) output("  Upon further inspection, all your [pc.cocks] have shrunk!");
					changes++;
				}
			}
			//Body type changes.  Teh rarest of the rare.
			//DA EARZ
			if (pc.earType != GLOBAL.TYPE_FELINE && rand(5) == 0 && changes < changeLimit) {
				//human to cat:
				if (pc..earType == GLOBAL.TYPE_HUMAN || pc..earType == GLOBAL.TYPE_HUMANMASKED || pc..earType == GLOBAL.TYPE_SYLVAN) {
					output(RandomInCollection([
					"\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have cat ears.</b>",
					"\n\nYour ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have cat ears.</b>"
					]));
				}
				//non human to cat:
				else {
					output(RandomInCollection([
					"\n\nYour ears change shape, morphing into pointed, feline ears!  They swivel about reflexively as you adjust to them.  <b>You now have cat ears.</b>",
					"\n\nYour ears tingle and begin to change shape. Within a few moments, they've become long and feline.  Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have cat ears.</b>"
					]));
				}
				pc.earType = GLOBAL.TYPE_FELINE;
				changes++;
			}
			//DA TAIL (IF ALREADY HAZ URZ)
			if (!pc.hasTail(GLOBAL.TYPE_FELINE) && pc.earType == GLOBAL.TYPE_FELINE && rand(5) == 0 && changes < changeLimit) {
				
				if(!pc.hasFur() && !InCollection(pc.furColor, catFurColor)) pc.furColor = RandomInCollection(catFurColor);
				
				if (!pc.hasTail()) {
					output(RandomInCollection([
					"\n\nA pressure builds in your backside. You feel under your [pc.gear] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of [pc.furColor] fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>",
					"\n\nYou feel your backside shift and change, flesh molding and displacing into a long, flexible [pc.furColor] tail! <b>You now have a cat tail.</b>",
					"\n\nYou feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [pc.furColor] fur. <b>You now have a cat tail.</b>"
					]));
				}
				else output("\n\nYou pause and tilt your head... something feels different.  Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy [pc.furColor] fur. <b>You now have a cat tail.</b>");
				
				pc.clearTailFlags();
				pc.tailType = GLOBAL.TYPE_FELINE;
				if(pc.tailCount > 6) pc.tailCount = 1;
				pc.addTailFlag(GLOBAL.FLAG_LONG);
				pc.addTailFlag(GLOBAL.FLAG_FURRED);
				changes++;
			}
			//Da paws (if already haz ears & tail)
			if (pc.hasTail(GLOBAL.TYPE_FELINE) && pc.earType == GLOBAL.TYPE_FELINE && rand(5) == 0 && changes < changeLimit && pc.legType != GLOBAL.TYPE_FELINE) {
				//hoof to cat:
				if (pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) {
					output("\n\nYou feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>");
				}
				//Goo to cat
				else if (pc.legType == GLOBAL.TYPE_GOOEY) {
					output("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into digitigrade legs, complete with soft, padded cat-paws.  <b>You now have cat-paws!</b>");
				}
				//non hoof to cat:
				else output("\n\nYou scream in agony as you feel the bones in your " + pc.feet() + " break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>");
				if (pc.isTaur()) output("  You feel woozy and collapse on your side.  When you wake, you're no longer a taur and your body has returned to a humanoid shape.");

				pc.clearLegFlags();
				pc.legType = GLOBAL.TYPE_FELINE;
				pc.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
				pc.addLegFlag(GLOBAL.FLAG_PAWS);
				pc.addLegFlag(GLOBAL.FLAG_FURRED);
				pc.legCount = 2;
				pc.genitalSpot = 0;
				changes++;
			}
			if (changes < changeLimit && pc.armType != GLOBAL.TYPE_FELINE && pc.hasFur() && rand(4) == 0) {
				output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms are changed!");
				pc.armType = GLOBAL.TYPE_FELINE;
				pc.armFlags = [GLOBAL.FLAG_FURRED];
				changes++;
			}
			//TURN INTO A FURRAH!  OH SHIT
			if (pc.hasTail(GLOBAL.TYPE_FELINE) && pc.earType == GLOBAL.TYPE_FELINE && rand(5) == 0 && changes < changeLimit && pc.legType == GLOBAL.TYPE_FELINE && !pc.hasFur()) {
				output("\n\nYour [pc.skin] begins to tingle, then itch. ");
				
                pc.skinType = GLOBAL.SKIN_TYPE_FUR;
                pc.clearSkinFlags();
				
				if(!InCollection(pc.furColor, catFurColor)) pc.furColor = RandomInCollection(catFurColor);
				
				output("You reach down to scratch your skin absent-mindedly and pull your fingers away to find strands of fur. Wait, fur?  What just happened?! You spend a moment examining yourself and discover that <b>you are now covered in glossy, soft " + pc.furColor + " fur.</b>");
				changes++;
			}
			//CAT-FACE!  FULL ON FURRY!  RAGE AWAY NEKOZ
			if (pc.hasTail(GLOBAL.TYPE_FELINE) && pc.earType == GLOBAL.TYPE_FELINE && rand(5) == 0 && changes < changeLimit && pc.legType == GLOBAL.TYPE_FELINE && (pc.hasFur() /*|| (pc.hasScales() && pc.dragonneScore() >= 4)*/) && pc.faceType != GLOBAL.TYPE_FELINE) {
				//Gain cat face, replace old face
				output(RandomInCollection([
				"\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>",
				"\n\nMind-numbing pain courses through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>",
				"\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>"
				]));
				
				pc.clearFaceFlags();
				pc.faceType = GLOBAL.TYPE_FELINE;
                pc..addFaceFlag(GLOBAL.FLAG_MUZZLED);
				
				if (!InCollection(pc.eyeColor, ["emerald", "amber", "green", "blue", "gold"]))
				{
					var color:String = RandomInCollection(["emerald", "amber", "green", "blue", "gold"]);
					if (pc.eyeColorUnlocked(color)) pc.eyeColor = color;
				}
					
				output("\n\nYour [pc.eyes] start to water, and no matter how much you blink, your vision just grows fuzzier and fuzzier for several moments before seeming to clear all of a sudden. You have <b>a pair of [pc.eyeColor] cat-eyes, slitted and brilliantly-bright!</b>");
                pc..eyeType = GLOBAL.TYPE_FELINE;
					
				changes++;
			}
			
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			
			//FAILSAFE CHANGE
			if (changes == 0) {
				output("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				pc.HP(50);
				pc.lust(3);
			}
			if (changes < changeLimit) {
				if (rand(2) == 0 && pc.thickness > 5) output(pc.modThickness(-3));
				if (rand(2) == 0 && pc.tone < 76) output(pc.modTone(3, true));
				if (rand(2) == 0) {
					var targetFem:int = pc.hasVagina() ? 85 : 65;
					if (pc.femininity < targetFem) output(pc.modFem(3));
				}
			}
			kGAMECLASS.flags["COC.TIMES_TRANSFORMED"] += changes;
			return false;
		}
	}	
}
