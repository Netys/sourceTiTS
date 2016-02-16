package classes.Items.Transformatives
{
	import classes.Characters.CoC.CoCMinotaur;
	import classes.Characters.PlayerCharacter;
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.TooltipManager;
	import classes.Items.Miscellaneous.CoCMinotaurCum;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
    public class CoCMouseCocoa extends ItemSlotClass
    {
        public function CoCMouseCocoa(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "MouseCo";
            //Regular name
            this.longName = "handful of mouse cocoa";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a handful of mouse cocoa";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 200;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			if (!(target is PlayerCharacter)) {
				output(target.capitalA + target.short + " have no idea how to use " + longName + ".");
				return false;
			}
			
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			//use:
			output("You pop several of the beans in your mouth and suck; they immediately reward you by giving up an oily, chocolatey flavor with a hint of bitterness.  For several minutes you ");
			if (target.isBiped()) output("sit and ");
			output("enjoy the taste.");

			//stat changes:
			//lose height + gain speed (42" height floor, no speed ceiling but no speed changes without height change)
			if (target.tallness >= 45 && changes < changeLimit && rand(3) == 0) {
				//not horse
				if (target.isBiped()) output("\n\nYou tap your [pc.feet] idly against the ground as you enjoy the treat; it takes several minutes before you realize you don't reach as far down as you did when you sat down!  In shock, you jerk upright and leap off, nearly falling forward as your body moves more responsively than before!  Experimentally, you move in place as you look down at your now-closer [feet]; the sensation of a more compact agility stays with you.");
				//horse
				else output("\n\nYou trot idly in place as you eat, moving quicker and quicker as you become increasingly bored; on one step, the ground sneaks up on you and you hit it sharply, expecting a few more inches before contact!  Looking down, you notice better resolution than before - you can make out the dirt a bit more clearly.  It looks like you just shed some height, but... you're feeling too jittery to care.  You just want to run around.");
				target.slowStatGain("r", 1);
				
				target.tallness--;
				if (target.tallness > 60) target.tallness--;
				if (target.tallness > 70) target.tallness--;
				if (target.tallness > 80) target.tallness--;
				if (target.tallness > 90) target.tallness -= 2;
				if (target.tallness > 100) target.tallness -= 2;
				changes++;
			}
			//lose tough
			if ((target.PQ() > 50 || target.WQ() > 50) && changes < changeLimit && rand(3) == 0) {
				output("\n\nYou feel a bit less sturdy, both physically and mentally.  In fact, you'd prefer to have somewhere to hide for the time being, until your confidence returns.  The next few minutes are passed in a mousey funk - even afterward, you can't quite regain the same sense of invincibility you had before.");
				changes++;
				if (target.PQ() > 50) target.slowStatGain("p", -0.5);
				if (target.WQ() > 50) target.slowStatGain("w", -0.5);
			}

			//SEXYYYYYYYYYYY
			//vag-anal capacity up for non-goo (available after PC < 5 ft; capacity ceiling reasonable but not horse-like or gooey)
			if (target.tallness < 60 && (target.ass.bonusCapacity < 100 || (target.hasVagina() && target.vaginas[0].bonusCapacity < 100)) && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour ");
				if (target.hasVagina() && target.vaginas[0].bonusCapacity < 100) output("[pc.vagina]");
				else output("[pc.asshole]");
				output(" itches, and you shyly try to scratch it, looking around to see if you're watched.  ");
				if (target.isTaur()) output("Backing up to a likely surface, you rub your hindquarters against it, only to be surprised when you feel your hole part smoothly against the surface, wider than you're used to!");
				else output("Slipping a hand in your [pc.gear], you rub vigorously; your hole opens more easily and your fingers poke in farther than you're used to!");
				output("  It feels unusual - not bad, really, but definitely weird.  You can see how it would come in handy, now that you're smaller than most prospective partners, but... shaking your head, you ");
				if (target.isTaur()) output("back away from your erstwhile sedimentary lover");
				else output("pull your hand back out");
				output(".");
				//adds some lust
				target.lust(10 + target.libido() / 5);
				if (target.hasVagina() && target.vaginas[0].bonusCapacity < 100) {
					target.vaginas[0].bonusCapacity += 10;
				}
				else {
					target.ass.bonusCapacity += 10;
				}
				changes++;
			}
			
			//fem fertility up and heat (suppress if pregnant)
			//not already in heat (add heat and lust)
			if (target.statusEffectv2("Heat") < 30 && rand(2) == 0 && changes < changeLimit) {
				var intensified:Boolean = target.statusEffectv2("Heat") > 0;
				if(Mutator.goIntoHeat(target, false)) {
					if(intensified) {
							output("\n\nYour womb feels achingly empty, and your temperature shoots up.  Try as you might, you can't stop fantasizing about being filled with semen, drenched inside and out with it, enough to make a baker's dozen offspring.  ");
							//[(no mino cum in inventory)]
							if (!target.hasItem(new CoCMinotaurCum())) {
								output("<b>Your heat has intensified as much as your fertility has increased, which is a considerable amount!</b>");
							}
							else if (target.lustQ() < 100 || target.isTaur()) output("You even pull out a bottle of minotaur jism and spend several minutes considering the feasibility of pouring it directly in your [pc.vagina], but regain your senses as you're unsealing the cap, setting it aside.  <b>Still, your heat is more intense than ever and your increasingly-fertile body is practically begging for dick - it'll be hard to resist any that come near!</b>");
							//(mino cum in inventory and non-horse, 100 lust)
							else {
								output("Desperately horny, you pull out your bottle of minotaur jism and break the seal in two shakes, then lie down with your hips elevated and upend it over your greedy vagina.  The gooey seed pours into you, and you orgasm fitfully, shaking and failing to hold the bottle in place as it coats your labia.  <b>As a hazy doze infiltrates your mind, you pray the pregnancy takes and dream of the sons you'll bear with your increasingly fertile body... you're going to go insane if you don't get a baby in you</b>.");
								//(consumes item, increment addiction/output addict message, small chance of mino preg, reduce lust)]", false);
								//target.minoCumAddiction(5);
								//target.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR, 175);
								//target.consumeItem(consumables.MINOCUM);
								target.loadInCunt(new CoCMinotaur());
							}
					}
					else {
							output("\n\nYour insides feel... roomy.  Accomodating, even.  You could probably carry a whole litter of little [pc.name]s right now.  Filled with a sudden flush of desire, you look around furtively for any fertile males.  With a shake of your head, you try to clear your thoughts, but daydreams of being stuffed with seed creep right back in - it looks like your body is intent on probing the limits of your new fertility.  <b>You're in heat, and pregnable in several senses of the word!</b>");
					}
					target.fertilityRaw += 0.1;
					changes++;
				}
			}
			
			//bodypart changes:
			//gain ears
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeEars(target, GLOBAL.TYPE_MOUSE, 0, true)) {
				//output("\n\nYour ears pull away from your head, like they're being pinched, and you can distinctly feel the auricles taking a rounded shape through the pain.  Reaching up to try and massage away their stings, <b>you're not terribly surprised when you find a pair of fuzzy mouse's ears poking through your " + target.hairDescript() + ".</b>");
				changes++;
			}
			//gain tail
			//from no tail
			if (target.earType == GLOBAL.TYPE_MOUSE && changes < changeLimit && rand(4) == 0 && Mutator.changeTail(target, GLOBAL.TYPE_MOUSE, 1, [GLOBAL.FLAG_LONG, GLOBAL.FLAG_SMOOTH])) {
				//from other tail
				//if (target.tailType > TAIL_TYPE_NONE) {
					//output("\n\nYour tail clenches and itches simultaneously, leaving you wondering whether to cry out or try to scratch it.  The question is soon answered as the pain takes the forefront; looking backward is a horrible strain, but when you manage it, you can see your old appendage ");
					//if (target.tailType == TAIL_TYPE_HORSE) output("elongating");
					//else output("compressing");
					//output(" into a long, thin line.  With a shudder, it begins to shed until it's completely, starkly nude.  <b>Your new mouse tail looks a bit peaked.</b>");
				//}
				//else output("\n\nA small nub pokes from your backside, and you turn to look at it.  When you do, your neck aches as if whiplashed, and you groan as your spine shifts smoothly downward like a rope being pulled, growing new vertebra behind it and expanding the nub into a naked, thin, tapered shape.  <b>Rubbing at your sore neck, you stare at your new mouse tail.</b>");
				//target.tailType = TAIL_TYPE_MOUSE;
				changes++;
			}
			//get teeth - from human, bunny, coonmask, or other humanoid teeth faces
			if (target.earType == GLOBAL.TYPE_MOUSE && target.faceType != GLOBAL.TYPE_MOUSE && target.faceType != GLOBAL.TYPE_MOUSEMAN && rand(4) == 0 && changes < changeLimit && Mutator.changeFace(target, GLOBAL.TYPE_MOUSEMAN)) {
				//output("\n\nYour teeth grind on their own, and you feel a strange, insistent pressure just under your nose.  As you open your mouth and run your tongue along them, you can feel ");
				//if (target.faceType != FACE_HUMAN) output("the sharp teeth receding and ");
				//output("your incisors lengthening.  It's not long before they're twice as long as their neighbors and the obvious growth stops, but the pressure doesn't go away completely.  <b>Well, you now have mouse incisors and your face aches a tiny bit - wonder if they're going to keep growing?</b>");
				//target.faceType = FACE_BUCKTEETH;
				changes++;
			}
			//get mouse muzzle from mouse teeth or other muzzle
			if (target.hasFur() && target.faceType == GLOBAL.TYPE_MOUSEMAN && rand(4) == 0 && changes < changeLimit && Mutator.changeFace(target, GLOBAL.TYPE_MOUSE, [GLOBAL.FLAG_MUZZLED])) {
				//output("\n\nA wave of light-headedness hits you, and you black out.  In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn't taste like anything much.  For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken.  Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection.  <b>Your face has shifted to resemble a mouse's, down to the whiskers!</b>");
				//target.faceType = FACE_MOUSE;
				changes++;
			}
			//get fur
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeSkin(target, GLOBAL.SKIN_TYPE_FUR, ["brown", "brown", "brown", "brown", "white"])) {
				//from skinscales
				//if (target.skinType != SKIN_TYPE_FUR) {
					//output("\n\nYour " + target.skinFurScales() + " itch");
					//if (target.skinType > SKIN_TYPE_PLAIN) output("es");
					//output(" all over");
					//if (target.tailType > TAIL_TYPE_NONE) output(", except on your tail");
					//output(".  Alarmed and suspicious, you tuck in your hands, trying to will yourself not to scratch, but it doesn't make much difference.  Tufts of ");
					//temp = rand(10);
					//if (temp < 8) {
						//output("brown");
						//target.furColor = "brown";
					//}
					//else {
						//output("white");
						//target.furColor = "white";
					//}
					//output(" fur begin to force through your skin");
					//if (target.skinType == SKIN_TYPE_SCALES) output(", pushing your scales out with little pinches");
					//output(", resolving the problem for you.  <b>You now have fur.</b>");
				//}
				////from other color fur
				//else {
					//output("\n\nYour fur stands on end, as if trying to leap from your body - which it does next.  You watch, dumb with shock, as your covering deserts you, but it's quickly replaced with another layer of ");
					//temp = rand(10);
					//if (temp < 8) {
						//output("brown");
						//target.furColor = "brown";
					//}
					//else {
						//output("white");
						//target.furColor = "white";
					//}
					//output(" fuzz coming in behind it that soon grows to full-fledged fur.");
				//}
				//target.skinAdj = "";
				//target.skinDesc = "fur";
				//target.skinType = SKIN_TYPE_FUR;
				changes++;
			}
			
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeArms(target, GLOBAL.TYPE_HUMAN, [GLOBAL.FLAG_FURRED])) changes++;
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeLegs(target, GLOBAL.TYPE_HUMAN, 2, [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_FURRED])) changes++;
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
			
			return false;
		}
	}	
}
