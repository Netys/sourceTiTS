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
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var choices:Array;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			//b) Description while used
			output("Pinching your nose, you quickly uncork the vial and bring it to your mouth, determined to see what effects it might have on your body. Pouring in as much as you can take, you painfully swallow before going for another shot, emptying the bottle.");
			//(if outside combat)
			output("  Minutes pass as you start wishing you had water with you, to get rid of the aftertaste.");
			//+ speed to 70!
			if (target.RQ() < 70 && rand(2) == 0) {
				target.slowStatGain("r", (2 - (target.RQ() / 50)));
				output("\n\nYour muscles quiver, feeling ready to strike as fast as a snake!");
				if (target.RQ() < 40) output("  Of course, you're nowhere near as fast as that.");
				changes++;
			}
			//Removes wings
			if (target.hasWings() && rand(3) == 0 && changes < changeLimit) {
				if (target.wingType == GLOBAL.TYPE_SHARK) output("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine.  After a moment the pain passes, though your fin is gone!");
				else output("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
				target.removeWings();
				changes++;
			}
			//Removes antennae
			if (target.hasAntennae() && rand(3) == 0 && changes < changeLimit) {
				output("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae have vanished!", false);
				target.removeAntennae();
				changes++;
			}
			//9c) II The tongue (sensitivity bonus, stored as a perk?)
			if (changes == 0 && target.tongueType != GLOBAL.TYPE_SNAKE && rand(3) == 0 && changes < changeLimit) {
				if (target.tongueType == GLOBAL.TYPE_HUMAN) output("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.");
				else output("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.  By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.");
				target.tongueType = GLOBAL.TYPE_SNAKE;
				target.tongueFlags = [GLOBAL.FLAG_LONG];
				//dynStats("sen", 5);
				changes++;
			}
			//9c) III The fangs
			if (changes == 0 && target.tongueType == GLOBAL.TYPE_SNAKE && target.faceType != GLOBAL.TYPE_SNAKE && rand(3) == 0 && changes < changeLimit) {
				output("\n\nWithout warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid.  Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>");
				//output("  As the change progresses, your [pc.face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>");
				output("  As the change progresses, your [pc.face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a face that resembles a combination between a human’s and a snake’s.</b> Strange, Naga’s face was more human-like.");
				target.faceType = GLOBAL.TYPE_SNAKE;
				target.faceFlags = [GLOBAL.FLAG_ANGULAR];
				changes++;
			}
			
			// Naleen copypaste
			var x:int = 0;
			var y:int = 0;
			//Female TFs
			choices = new Array();
			for(x = 0; x < target.totalVaginas(); x++) {
				if(target.vaginas[x].type != GLOBAL.TYPE_NAGA && target.vaginaTypeUnlocked(x, GLOBAL.TYPE_NAGA)) choices[choices.length] = x;
			}
			if(choices.length == 0) x = -1;
			else x = choices[rand(choices.length)];
			//Cunt -> Naleenslit TF
			if(x >= 0 && changes < changeLimit && rand(3) == 0) {
				output("\n\nA hot flash assaults your body, leaving you panting, sweating, and drooling from your [pc.vaginas]. ");
				if(target.vaginaTotal() > 1) output("Each");
				else output("It");
				output(" is near-instantly engorged and wanting");
				if(target.vaginas[x].clits > 0) output(", your [pc.clits] hard and easy to spot");
				output(". You gasp and double over, bringing your hand up to start masturbating when you see [pc.oneVagina] changing before your eyes. It's getting longer vertically while the vulva, even aroused, become less noticeable.");
				if(target.vaginas[x].clits <= 0) output(" A sensitive nub grows from the top, forming a pulsing, needy clit.");
				else if(target.vaginas[x].clits > 1) {
					if(target.vaginas[x].clits == 2) output(" A clit vanishes");
					else if(target.vaginas[x].clits == 3) output(" A couple of clits vanish");
					else if(target.vaginas[x].clits == 4) output(" A few clits vanish");
					else if(target.vaginas[x].clits == 5) output(" Some clits vanish");
					else output(" A number of clits vanish");
					output(", leaving only the one at the top.");
				}
				if(target.totalVaginas() == 2) output(" Your other entrance soon follows after the first, reshaping to match.");
				else if(target.totalVaginas() > 2) output(" Your other entrances soon follow after the first, reshaping to match.");
				if((target.hasCock() && target.hasStatusEffect("Genital Slit")) || target.vaginaTotal(GLOBAL.TYPE_NAGA)) output(" With more than one slit in your groin, you hope any future partners can find their target.");
				output("<b> You have a vagina that looks just like a naga's");
				if(target.skinType != GLOBAL.SKIN_TYPE_SCALES && target.legType != GLOBAL.TYPE_NAGA) output(", minus the scales around it");
				output(".</b>");
				//Loop through and set 'em all, baby!
				for(x = 0; x < target.totalVaginas(); x++)
				{
					target.vaginas[x].clits = 1;
					target.vaginas[x].type = GLOBAL.TYPE_NAGA;
				}
				changes++;
			}
			
			//See if any vaginas have less than 100 bonus capacity!
			choices = new Array();
			for(x = 0; x < target.totalVaginas(); x++) {
				if(target.vaginas[x].bonusCapacity < 100) choices[choices.length] = x;
			}
			if(choices.length == 0) x = -1;
			else x = choices[rand(choices.length)];
			//Bonus capacity up to 100 in increments of 25 - req's naleencunt and nagatail
			if(target.legCount == 1 && target.legType == GLOBAL.TYPE_NAGA && x >= 0 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour lengthy snake-body undulates nervously underneath you when a slight cramp works through you, right around ");
				if(target.vaginaTotal() > 1) output("one of your wombs");
				else output("your womb");
				output(". It fades after five or ten seconds of discomfort, but you just have to figure out what changed inside you! You pry yourself open and guide your fingers inside, finding that you can fit a little bit more inside than ever before. If you contort around and hold your lips apart, you can even tell that you've gotten a good bit deeper. <b>You can handle slightly bigger insertions without worry.</b>");
				target.vaginas[x].bonusCapacity += 25;
				if(target.vaginas[x].bonusCapacity > 100) target.vaginas[x].bonusCapacity = 100;
				target.lust(3);
				changes++;
			}
			
			//9c) I The tail ( http://tvtropes.org/pmwiki/pmwiki.php/Main/TransformationIsAFreeAction ) (Shouldn't we try to avert this? -Ace)
			//Should the enemy "kill" you during the transformation, it skips the scene and immediately goes to tthe rape scene. (Now that I'm thinking about it, we should add some sort of appendix where the player realizes how much he's/she's changed. -Ace)
			if (changes == 0 && target.faceType == GLOBAL.TYPE_SNAKE && !target.isNaga() && rand(4) == 0 && changes < changeLimit) {
				output("\n\nYou find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight.");
				//(If used in combat, you lose a turn here. Half-corrupted Jojo and the Naga won't attack you during that period, but other monsters will)
				//FUCK NO
				output("\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle.");
				output("  The process continues through the length of your [pc.legs], eventually reaching your [pc.feet].  Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [pc.legs]: the bottom half of your body is like that of a snake's.");
				if (!target.hasStatusEffect("Genital Slit")) {
					target.createStatusEffect("Genital Slit",0,0,0,0);
					output("\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.");
				}
				if (target.balls > 0 && target.ballSize() > 10) output("  You're happy not to have to drag those testicles around with you anymore.");
				output("  But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.");
				target.scaleColor = target.hairColor;
				target.legCount = 1;
				target.genitalSpot = 0;
				target.clearLegFlags();
				target.addLegFlag(GLOBAL.FLAG_PREHENSILE);
				target.addLegFlag(GLOBAL.FLAG_TAPERED);
				target.addLegFlag(GLOBAL.FLAG_SMOOTH);
				target.addLegFlag(GLOBAL.FLAG_TENDRIL);
				target.addLegFlag(GLOBAL.FLAG_SCALED);
				target.legType = GLOBAL.TYPE_NAGA;
				target.makeBallsInternal();
				changes++;
			}
			if (rand(4) == 0 && target.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				target.gills = false;
				changes++;
			}

			//9e) Penis
			/*
			 if(target.cockTotal() > 0) {
			 //(If multiple penis, insert "one of your")
			 output("\n\nAs the liquid takes effect, ", false);
			 //(if multicock)
			 if(target.cockTotal() > 1) output("one of ", false);
			 output("your [pc.cocksLight] starts to throb painfully and swell to its full size.  With a horrifying ripping sensation, your cock splits down the middle, the pain causing you to black out momentarily.", false);
			 output("When you awaken, you quickly look down to see that where ", false);
			 //(if multicock)
			 if(target.cockTotal() > 1) output("one of ", false);
			 output("your [pc.cocksLight] was, you now have two pointed reptilian cocks, still stiff and pulsing.", false);
			 }*/
			//Default change - blah
			if (changes == 0) output("\n\nRemakarbly, the snake-oil has no effect.  Should you really be surprised at snake-oil NOT doing anything?");
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
