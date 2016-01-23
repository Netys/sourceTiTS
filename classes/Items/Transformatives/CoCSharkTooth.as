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
	
    public class CoCSharkTooth extends ItemSlotClass
    {        
        public function CoCSharkTooth(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Shark.T";
            //Regular name
            this.longName = "shark tooth";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a sharp shark tooth";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A glinting white tooth, very sharp and intimidating.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			SharkTooth(0, pc);
			return false;
		}
		
		public function SharkTooth(type:Number, pc:Creature):void
		{
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			
			if (type == 0) output("You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.");
			else if (type == 1) output("You have no idea why, but you decide to eat the pointed, glowing tooth. To your surprise, it's actually quite brittle, crumbling into a fishy-tasting dust. Maybe it's just a tablet made to look like a shark's tooth.");
			//STATS
			//Increase strength 1-2 points (Up to 50) (60 for tiger)
			if (((pc.PQ() < 60 && type == 1) || pc.PQ() < 50) && rand(3) == 0) {
				pc.slowStatGain("p", (1 + rand(2)) / 3.);
				output("\n\nA painful ripple passes through the muscles of your body.  It takes you a few moments, but you quickly realize you're a little bit stronger now.", false);
				changes++;
			}
			//Increase Speed 1-3 points (Up to 75) (100 for tigers)
			if (((pc.RQ() < 100 && type == 1) || pc.RQ() < 75) && rand(3) == 0) {
				pc.slowStatGain("r", (1 + rand(2)) / 3.);
				changes++;
				output("\n\nShivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.", false);
			}
			//Reduce sensitivity 1-3 Points (Down to 25 points)
			//if (pc.sens > 25 && rand(1.5) == 0 && changes < changeLimit) {
				//dynStats("sen", (-1 - rand(3)));
				//changes++;
				//output("\n\nIt takes a while, but you eventually realize your body has become less sensitive.", false);
			//}
			//Increase Libido 2-4 points (Up to 75 points) (100 for tigers)
			if (((pc.lustQ() < 100 && type == 1) || pc.lustQ() < 75) && rand(3) == 0 && changes < changeLimit) {
				pc.slowStatGain("l", 1 + rand(2));
				changes++;
				output("\n\nA blush of red works its way across your skin as your sex drive kicks up a notch.", false);
			}
			//Decrease intellect 1-3 points (Down to 40 points)
			if (pc.IQ() > 40 && rand(3) == 0 && changes < changeLimit) {
				pc.intelligence( - 1);
				changes++;
				output("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.", false);
			}
			//Smexual stuff!
			//-TIGGERSHARK ONLY: Grow a cunt (guaranteed if no gender)
			if (type == 1 && (!pc.hasGenitals() || (!pc.hasVagina() && changes < changeLimit && rand(3) == 0))) {
				changes++;
				//(balls)
				if (pc.balls > 0) output("\n\nAn itch starts behind your [pc.balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your " + pc.sackDescript() + ", and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>", false);
				//(dick)
				else if (pc.hasCock()) output("\n\nAn itch starts on your groin, just below your [pc.cocksLight]. You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>", false);
				//(neither)
				else output("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [pc.gear] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>", false);
				pc.createVagina();
				//dynStats("sen", 10);
			}
			//WANG GROWTH - TIGGERSHARK ONLY
			if (type == 1 && (!pc.hasCock()) && changes < changeLimit && rand(3) == 0) {
				//Genderless:
				if (!pc.hasVagina()) output("\n\nYou feel a sudden stabbing pain in your featureless crotch and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of a new human-shaped penis", false);
				//Female:
				else output("\n\nYou feel a sudden stabbing pain just above your " + pc.vaginaDescript() + " and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of not only a " + pc.vaginaDescript() + ", but a new human-shaped penis", false);
				if (pc.balls == 0) {
					output(" and a pair of balls", false);
					pc.balls = 2;
					pc.ballSizeRaw = 2;
				}
				output("!", false);
				pc.createCock(7);
				//dynStats("lib", 4, "sen", 5, "lus", 20);
				pc.libido(4);
				pc.lust(20);
				changes++;
			}
			//(Requires the player having two testicles)
			if (type == 1 && (pc.balls < 4) && pc.hasCock() && changes < changeLimit && rand(3) == 0) {
				if (pc.balls == 0) {
					output("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>", false);
					pc.balls = 2;
					pc.ballSizeRaw = 2;
				}
				else
				{
					output("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your [pc.sack], your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>", false);
					pc.balls = 4;
				}
				//dynStats("lib", 2, "sen", 3, "lus", 10);
				pc.libido(2);
				pc.lust(10);
				changes++;
			}
			//Transformations:
			//Mouth TF
			if (pc.faceType != GLOBAL.TYPE_SHARK && rand(3) == 0 && changes < changeLimit) {
				output("\n\n", false);
				if (pc.hasFaceFlag(GLOBAL.FLAG_MUZZLED)) output("Your " + pc.face() + " explodes with agony, reshaping into a more human-like visage.  ", false);
				pc.faceType = GLOBAL.TYPE_SHARK;
				pc.faceFlags = [GLOBAL.FLAG_ANGULAR];
				output("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.", false);
				// \n(Gain: 'Bite' special attack)
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && pc.eyeType != GLOBAL.TYPE_HUMAN) {
				output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + pc.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.", false);
				//if (pc.eyeType == EYES_FOUR_SPIDER_EYES) output("  Your multiple, arachnid eyes are gone!</b>", false);
				output("  <b>You have normal, humanoid eyes again.</b>", false);
				pc.eyeType = GLOBAL.TYPE_HUMAN;
				changes++;
			}
			//Tail TF
			if (!pc.hasTail(GLOBAL.TYPE_SHARK) && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (!pc.hasTail()) output("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [pc.gear] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.", false);
				else output("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.", false);
				pc.tailType = GLOBAL.TYPE_SHARK;
				pc.tailCount = 1;
				pc.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK];
			}
			//Hair
			if (pc.hairColor != "silver" && rand(4) == 0 && changes < changeLimit) {
				changes++;
				output("\n\nYou feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!", false);
				pc.hairColor = "silver";
			}
			//Skin
			if (((pc.skinTone != "rough gray" && pc.skinTone != "orange and black striped") || pc.skinType != GLOBAL.SKIN_TYPE_SKIN) && rand(7) == 0 && changes < changeLimit) {
				output("\n\n", false);
				if (pc.skinType == GLOBAL.SKIN_TYPE_FUR || pc.skinType == GLOBAL.SKIN_TYPE_SCALES) output("Your [pc.skinFurScales] falls out, collecting on the floor and exposing your supple skin underneath.  ", false);
				else if (pc.skinType == GLOBAL.SKIN_TYPE_GOO) output("Your gooey skin solidifies, thickening up as your body starts to solidy into a more normal form. ", false);
				else output("Your [pc.skin] itches and tingles becoming slightly rougher and turning gray.  ", false);
				if (type == 0) {
					output("You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and changing into a shiny grey color. Your skin now feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.", false);
					pc.skinTone = "rough gray";
				}
				else {
					output("Your skin begins to tingle and itch, before rapidly shifting to a shiny orange color, marked by random black stripes. Your skin has morphed in appearance and texture to become more like a tigershark!", false);
					pc.skinTone = "orange and black striped";
				}
				pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
				pc.skinFlags = [GLOBAL.FLAG_THICK];
				changes++;
			}
			//FINZ R WINGS
			if (pc.wingType != GLOBAL.TYPE_SHARK && changes < changeLimit && rand(3) == 0) {
				output("\n\n", false);
				if (pc.hasWings()) output("Your wings fold into themselves, merging together with your back.  ", false);
				output("You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [pc.gear] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [pc.gear] to accommodate your new fin.", false);
				pc.wingType = GLOBAL.TYPE_SHARK;
				changes++;
			}
			if (changes == 0) {
				output("\n\nNothing happened.  Weird.", false);
			}
			//pc.refillHunger(5);
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
