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
	
    public class CoCSnakeOil extends ItemSlotClass
    {
        public function CoCSnakeOil(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "SnakOil";
            //Regular name
            this.longName = "vial of snake oil";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of snake oil";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.";
            
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
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var choices:Array;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//b) Description while used
			output("Pinching your nose, you quickly uncork the vial and bring it to your mouth, determined to see what effects it might have on your body. Pouring in as much as you can take, you painfully swallow before going for another shot, emptying the bottle.");
			//(if outside combat)
			output("  Minutes pass as you start wishing you had water with you, to get rid of the aftertaste.");
			//+ speed to 70!
			if (pc.RQ() < 70 && rand(2) == 0) {
				pc.slowStatGain("r", (2 - (pc.RQ() / 50)));
				output("\n\nYour muscles quiver, feeling ready to strike as fast as a snake!");
				if (pc.RQ() < 40) output("  Of course, you're nowhere near as fast as that.");
				changes++;
			}
			//Removes wings
			if (pc.hasWings() && rand(3) == 0 && changes < changeLimit) {
				if (pc.wingType == GLOBAL.TYPE_SHARK) output("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine.  After a moment the pain passes, though your fin is gone!");
				else output("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
				pc.wingType = 0;
				changes++;
			}
			//Removes antennae
			if (pc.hasAntennae() && rand(3) == 0 && changes < changeLimit) {
				output("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae have vanished!", false);
				pc.removeAntennae();
				changes++;
			}
			//9c) II The tongue (sensitivity bonus, stored as a perk?)
			if (changes == 0 && pc.tongueType != GLOBAL.TYPE_SNAKE && rand(3) == 0 && changes < changeLimit) {
				if (pc.tongueType == GLOBAL.TYPE_HUMAN) output("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.");
				else output("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.  By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.");
				pc.tongueType = GLOBAL.TYPE_SNAKE;
				pc.tongueFlags = [GLOBAL.FLAG_LONG];
				//dynStats("sen", 5);
				changes++;
			}
			//9c) III The fangs
			if (changes == 0 && pc.tongueType == GLOBAL.TYPE_SNAKE && pc.faceType != GLOBAL.TYPE_SNAKE && rand(3) == 0 && changes < changeLimit) {
				output("\n\nWithout warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid.  Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>");
				//output("  As the change progresses, your [pc.face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>");
				output("  As the change progresses, your [pc.face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a face that resembles a combination between a human’s and a snake’s.</b> Strange, Naga’s face was more human-like.");
				pc.faceType = GLOBAL.TYPE_SNAKE;
				pc.faceFlags = [GLOBAL.FLAG_ANGULAR];
				changes++;
			}
			//9c) I The tail ( http://tvtropes.org/pmwiki/pmwiki.php/Main/TransformationIsAFreeAction ) (Shouldn't we try to avert this? -Ace)
			//Should the enemy "kill" you during the transformation, it skips the scene and immediately goes to tthe rape scene. (Now that I'm thinking about it, we should add some sort of appendix where the player realizes how much he's/she's changed. -Ace)
			if (changes == 0 && pc.faceType == GLOBAL.TYPE_SNAKE && !pc.isNaga() && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight.");
				//(If used in combat, you lose a turn here. Half-corrupted Jojo and the Naga won't attack you during that period, but other monsters will)
				//FUCK NO
				output("\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle.");
				output("  The process continues through the length of your [pc.legs], eventually reaching your [pc.feet].  Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [pc.legs]: the bottom half of your body is like that of a snake's.");
				if (!pc.hasStatusEffect("Genital Slit")) {
					pc.createStatusEffect("Genital Slit",0,0,0,0);
					output("\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.");
				}
				if (pc.balls > 0 && pc.ballSize() > 10) output("  You're happy not to have to drag those testicles around with you anymore.");
				output("  But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.");
				pc.scaleColor = pc.hairColor;
				pc.legCount = 1;
				pc.genitalSpot = 0;
				pc.clearLegFlags();
				pc.addLegFlag(GLOBAL.FLAG_PREHENSILE);
				pc.addLegFlag(GLOBAL.FLAG_TAPERED);
				pc.addLegFlag(GLOBAL.FLAG_SMOOTH);
				pc.addLegFlag(GLOBAL.FLAG_TENDRIL);
				pc.addLegFlag(GLOBAL.FLAG_SCALED);
				pc.legType = GLOBAL.TYPE_NAGA;
				changes++;
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}

			//9e) Penis
			/*
			 if(pc.cockTotal() > 0) {
			 //(If multiple penis, insert "one of your")
			 output("\n\nAs the liquid takes effect, ", false);
			 //(if multicock)
			 if(pc.cockTotal() > 1) output("one of ", false);
			 output("your [pc.cocksLight] starts to throb painfully and swell to its full size.  With a horrifying ripping sensation, your cock splits down the middle, the pain causing you to black out momentarily.", false);
			 output("When you awaken, you quickly look down to see that where ", false);
			 //(if multicock)
			 if(pc.cockTotal() > 1) output("one of ", false);
			 output("your [pc.cocksLight] was, you now have two pointed reptilian cocks, still stiff and pulsing.", false);
			 }*/
			//Default change - blah
			if (changes == 0) output("\n\nRemakarbly, the snake-oil has no effect.  Should you really be surprised at snake-oil NOT doing anything?");
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
