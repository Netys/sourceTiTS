import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//SPHINX RIDDLES for the Gentleman Gamer
//Accept the Riddle Challenge
public function riddleGameGo():void {
	clearOutput();
	output("\"<i>Oh!  You'll play my game?  Marvelous!  Well then, let's begin...</i>\"");
	//[NEXT]
	clearMenu();
	addButton(0, "Next", sphinxRiddlePicker, riddleGameReset());
}

public function riddleGameReset():/*Function*/Array {
	flags["COC.SANURA_RIDDLES_ANSWERED"] = 0;
	return [SphinxRiddle1, SphinxRiddle2, SphinxRiddle3, SphinxRiddle4, SphinxRiddle5, SphinxRiddle6, SphinxRiddle7, SphinxRiddle8, SphinxRiddle9, SphinxRiddle10, SphinxRiddle11, SphinxRiddle12];
}

public function sphinxRiddlePicker(/*Function*/riddles:Array):void {	
	var riddle:Function = riddles[rand(riddles.length)];
	riddles.splice(riddles.indexOf(riddle), 1);
	riddle(riddles);
}

//ANSWER A RIDDLE RIGHT (Like a Boss)
public function answerCorrectSmartAss(riddles:Array):void {
	clearOutput();
	flags["COC.SANURA_RIDDLES_ANSWERED"]++;
	if(flags["COC.SANURA_RIDDLES_ANSWERED"] < 3) {
		output("The sphinx-girl sighs, \"<i>That's... correct.  Not bad, I suppose.  Well, we're not done yet... I've still got some tricks up my sleeves.  Er, so to speak.</i>\"");
		clearMenu();
		addButton(0, "Next", sphinxRiddlePicker, riddles);
	}
	else {		
		//BEAT THE SPHINX AT HER OWN GAME (First Time)
		if(flags["COC.BEATEN_SANURA_COUNT"] == 0) {
			output("\"<i>W-what!?</i>\"  the sphinx gasps as you correctly answer the last of her riddles.   \"<i>I-I don't... but how?  No one's ever had the wits to answer all three riddles!</i>\"");
			output("\n\nShe takes a moment to collect herself, then shrugs her shoulders lightly, \"<i>Well, that <i>was</i> unexpected.  My apologies, but I never actually expected you to win... still, I did offer you recompense for your efforts.  I am Sanura,</i>\" she bows, and over her shoulder you suddenly see a small door in the face of a dune emerge.  \"<i>You may enter the lair of the Sand Witches at your leisure.  Or... if you so desire... my body is yours to do with as you will,</i>\" she adds playfully.");
		}
		//BEAT THE SPHINX AT HER OWN GAME (REPEAT)
		else {
			output("\"<i>Tsk, I lose again!</i>\" Sanura pouts, crossing her arms.  \"<i>I suppose you'll just have to give me a victory ravishing, won't you?  Go easy, though... you've already damaged my pride so....</i>\"");
		}
		IncrementFlag("COC.BEATEN_SANURA_COUNT");
		output("\n\nWhat do you do?");
		//(Display Options: [Fuck Her] [Door] [Leave])
		clearMenu();
		addButton(0, "Fuck Her", fuckDatSphinx, null, "Fuck Her", "Use Sanura to get off.");
		addButton(1, "Leave", mainGameMenu);
	}
}


//THE SPHINX BEAT YOU AT HER OWN -- WAIT A SECOND
public function answerWrongYouStupid():void {
	clearOutput();
	output("\"<i>That's... wrong, I'm afraid,</i>\" she says, a proud smile playing across her lips.  \"<i>Wrong, wrong, wrong.  Well, perhaps </i>I<i> was wrong about </i>you<i> after all...  Here I thought you'd be some fun.  Still, though, at least your body will serve me well, I think.  Yes, you'll do nicely.  Go on then, love, strip out of your [pc.gear] for me.  A deal's a deal, after all...</i>\"");
	//(Display Options: [Submit] [Fuck it, Attack])
	//(Submit goes to appropriate loss scene)
	clearMenu();
	addButton(0, "Submit", sphinxSubmissionOptions, null, "Submit", "Submit to the sphinx. A deal is definitely a deal, after all.");
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(1, "Uh, ATTACK!", fuckItAttackSphinx, null, "Attack", "Screw this! You may have lost the riddle but you'll NOT let Sanura have her way with you.");
}


//RIDDLE 1
public function SphinxRiddle1(riddles:Array):void {
	clearOutput();
	output("\"<i>Hmm, here's an old one, but a good one, I think.  One of my favorites, but stop me if you know the answer already: 'I walk on four legs in the morning, two in the afternoon, and three in the evening.  What am I?'</i>\"");
	clearMenu();
	//[A Sphinx] (if PC int < 50 add this: [A Centaur]) [A Man] (if PC int < 35 add this: [Stilts]) [Fuck it, Attack]
	addButton(0, "A Sphinx", riddleOneSphinx);
	addButton(1, "A Centaur", answerWrongYouStupid);
	addButton(2, "A Man", answerCorrectSmartAss, riddles);
	if (pc.intelligence() < 15) addButton(3, "Stilts", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}

//Special Occurrence: Pick [A Sphinx]
public function riddleOneSphinx():void {
	clearOutput();
	output("The sphinx narrows her eyes at you, crossing her arms over her chest.  \"<i>You don't say?  Come on, step it up, [pc.name].  Sorry, but that's wrong.  Let's try again.</i>\"");
	clearMenu();
	addButton(0, "Next", sphinxRiddlePicker, riddleGameReset());
}

//RIDDLE 2
public function SphinxRiddle2(riddles:Array):void {
	clearOutput();
	output("\"<i>Mmm, I've always been fond of this one.  Delightfully simple, really - don't overthink it, dear.  'I always run, yet never walk; I murmur often, yet never talk; and I've a bed, yet never sleep.  What am I?'</i>\"");
	//[A River] [A Whisper] (if PC int < 50 add this: [A Nail]) (if PC int < 35 add this: [A Bunny Girl]) [Fuck it, Attack]
	clearMenu();
	addButton(0, "A River", answerCorrectSmartAss, riddles);
	addButton(1, "A Whisper", answerWrongYouStupid);
	if (pc.intelligence() < 25) addButton(2, "A Nail", answerWrongYouStupid);
	if (pc.intelligence() < 15) addButton(3, "A Bunny-Girl", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}

//RIDDLE 3
public function SphinxRiddle3(riddles:Array):void {
	clearOutput();
	output("\"<i>Ooh, this is a morbid one: 'Whoever makes me, sells me.  He who buys me, never uses me. And he who uses me, well, they'll never know it.  What am I?'</i>\"");
	clearMenu();
	//[Poison] (if PC int < 50 add this: [A Condom]) (if PC int < 35 add this: [Arrows]) [A Coffin] [Fuck it, Attack]
	addButton(0, "Poison", answerWrongYouStupid);
	if (pc.intelligence() < 25) addButton(1, "A Condom", answerWrongYouStupid);
	if (pc.intelligence() < 15) addButton(2, "Arrows", answerWrongYouStupid);
	addButton(3, "A Coffin", answerCorrectSmartAss, riddles);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}

//RIDDLE 4
public function SphinxRiddle4(riddles:Array):void {
	clearOutput();
	output("\"<i>Here's a classic for you: 'I'm always hungry, and must be fed always, lest I flicker away.  Yet I will always bite the hand that feeds me, if it touches me.  What am I?'</i>\"");
	clearMenu();
	//(if PC int < 35 add this: [A Fairy]) [Fire] [A Dog] (if PC int < 50 add this: [Disease]) [Fuck it, Attack]
	if (pc.intelligence() < 15) addButton(0, "A Fairy", answerWrongYouStupid);
	addButton(1, "Fire", answerCorrectSmartAss, riddles);
	addButton(2, "A Dog", answerWrongYouStupid);
	if (pc.intelligence() < 25) addButton(3, "Disease", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}

//RIDDLE 5
public function SphinxRiddle5(riddles:Array):void {
	clearOutput();
	output("\"<i>A favorite of my dear Goblin friends: 'When young, I am sweet in the sun; in middle age, I make you gay; but when I'm old, I'm more valuable than gold.  What am I?'</i>\"");
	clearMenu();
	//(if PC int < 50 add this: [Men]) (if PC int < 35 add this: [Women]) [Wine] [Cheese] [Fuck it, Attack]
	if (pc.intelligence() < 25) addButton(0, "Men", answerWrongYouStupid);
	if (pc.intelligence() < 15) addButton(1, "Women", answerWrongYouStupid);
	addButton(2, "Wine", answerCorrectSmartAss, riddles);
	addButton(3, "Cheese", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}
//RIDDLE 6
public function SphinxRiddle6(riddles:Array):void {
	clearOutput();
	output("\"<i>This riddle always makes me a bit sad, but... 'My life lasts but hours, and in service I'm devoured.  Thin, I am quick, fat I am slow, and wind is ever my foe.  What am I?'</i>\"");
	
	//(if PC int < 35 add this: [A Goblin]) [A Candle] (if PC int < 50 add this: [A Boat]) [An Arrow] [Fuck it, Attack]
	clearMenu();
	if (pc.intelligence() < 15) addButton(0, "A Goblin", answerWrongYouStupid);
	addButton(1, "A Candle", answerCorrectSmartAss, riddles);
	if (pc.intelligence() < 25) addButton(2, "A Boat", answerWrongYouStupid);
	addButton(3, "An Arrow", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4, "Uh, ATTACK!", fuckItAttackSphinx);
}

//RIDDLE 7
public function SphinxRiddle7(riddles:Array):void {
	clearOutput();
	output("\"<i>In service to the Sand Witches, I can sympathize with this riddle's speaker: 'Each morning I appear to lie at your feet; all day I'll follow you no matter how fast you run, yet I'll nearly perish in the midday sun.  What am I?'</i>\"");
	
	//[A Shadow] [A Dog] (if PC int < 35 add this: [Water]) (if PC int < 50 add this: [The Breeze]) [Fuck it, Attack]
	clearMenu();
	addButton(0,"A Shadow",answerCorrectSmartAss, riddles);
	addButton(1,"A Dog",answerWrongYouStupid);
	if(pc.intelligence() < 15) addButton(2,"Water",answerWrongYouStupid);
	if(pc.intelligence() < 25) addButton(3,"The Breeze",answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//RIDDLE 8
public function SphinxRiddle8(riddles:Array):void {
	clearOutput();
	output("\"<i>Tsk, a sad tale this, fleeting as a melody on the breeze: 'You've heard me before, and will again, till fast I die - then you'll but summon me again.  What am I?'</i>\"");
	//(if PC int < 35 add this: [A Demon]) (if PC int < 50 add this: [Religion]) [An Idea] [An Echo] [Fuck it, Attack]
	clearMenu();
	if(pc.intelligence() < 15) addButton(0,"A Demon",answerWrongYouStupid);
	if(pc.intelligence() < 25) addButton(1,"Religion",answerWrongYouStupid);
	addButton(2,"An Idea",answerWrongYouStupid);
	addButton(3,"An Echo",answerCorrectSmartAss, riddles);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//RIDDLE 9
public function SphinxRiddle9(riddles:Array):void {
	clearOutput();
	output("\"<i>Like a cat comes this riddle of many lives: 'Three lives have I, gentle enough to sooth the skin, light enough to caress the sky, or hard enough to shatter stone.  What am I?'</i>\"");
	
	clearMenu();
	//(if PC int < 35 add this: [A Dick]) [Water] [A Voice] (if PC int < 50 add this: [Faith]) [Fuck it, Attack]
	if(pc.intelligence() < 15) addButton(0,"A Dick",answerWrongYouStupid);
	addButton(1,"Water",answerCorrectSmartAss, riddles);
	addButton(2,"A Voice",answerWrongYouStupid);
	if(pc.intelligence() < 25) addButton(3,"Faith",answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//RIDDLE 10
public function SphinxRiddle10(riddles:Array):void {
	clearOutput();
	output("\"<i>Devious, this: 'Whoever makes me, tells it not; he who takes me, knows it not; and he who knows me, takes me not.  What am I?'</i>\"");
	
	//[Disease] [Counterfeits] (if PC int < 35 add this: [Piss in a River]) (if PC int < 50 add this: [Tattered Scrolls]) [Fuck it, Attack]
	clearMenu();
	addButton(0,"Disease",answerWrongYouStupid);
	addButton(1,"Counterfeits",answerCorrectSmartAss, riddles);
	if(pc.intelligence() < 15) addButton(2,"Piss In A River",answerWrongYouStupid);
	if(pc.intelligence() < 25) addButton(3,"Tattered Scrolls",answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//RIDDLE 11
public function SphinxRiddle11(riddles:Array):void {
	clearOutput();
	output("\"<i>The lovely Naga that roams this desert knows my speaker well: 'A box without hinges, lock or key, yet I've golden treasure within me.  What am I?'</i>\"");
	
	//(if PC int < 35 add this: [A Treasure Chest]) (if PC int < 50 add this: [Pure Honey]) [Eggs] [Booze Bottles] [Fuck it, Attack]
	clearMenu();
	if(pc.intelligence() < 15) addButton(0,"Teasure Chest",answerWrongYouStupid);
	if(pc.intelligence() < 25) addButton(1,"Pure Honey",answerWrongYouStupid);
	addButton(2,"Eggs",answerCorrectSmartAss, riddles);
	addButton(3,"Booze Bottles",answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//RIDDLE 12
public function SphinxRiddle12(riddles:Array):void {
	clearOutput();
	output("\"<i>Here we've one that speaks to the stars and the earth at once: 'One by one we fall from the heavens, down into the depths of the past; our world is ever upturned, so that yet some time will last.  What are we?'</i>\"");
	
	//(if PC int < 50 add this: [Fallen Stars]) (if PC int < 35 add this: [Angels]) [Sand] [Rain] [Fuck it, Attack]
	clearMenu();
	if(pc.intelligence() < 25)addButton(0,"Fallen Stars",answerWrongYouStupid);
	if(pc.intelligence() < 15) addButton(1,"Angels",answerWrongYouStupid);
	addButton(2,"Sand",answerCorrectSmartAss, riddles);
	addButton(3, "Rain", answerWrongYouStupid);
	if(flags["COC.BEATEN_SANURA_COUNT"] == 0) addButton(4,"Uh, ATTACK!",fuckItAttackSphinx);
}

//FUCK IT, ATTACK (First Time)
public function fuckItAttackSphinx():void {
	clearOutput();
	output("To hell with this. You [pc.readyWeapon] to beat your way through the damned sphinx, but as soon as you make a threatening move, the half-lion makes a shrill \"<i>EEEP</i>\" and throws her hands up in surrender. \"<i>Please, th-there's no need for violence! I've no loyalty to these witches, they </i>force<i> me to guard the door. I've no desire to fight you; I'll not stop you if you wish to enter the lair.</i>\"");
	//[Options: Enter, Leave. Either way, Sanura won't be encountered again]
	flags["COC.SANURA_DISABLED"] = 1;
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Fuck Her
public function fuckDatSphinx():void {
	clearOutput();
	output("Grinning lustily at the pretty leonine girl, you tell her it's time to have some fun. With an easy grace, she slips the sky blue shift from her shoulders, exposing her pert, palmable breasts.  \"<i>Well, you did win my game, after all... I'm yours to do with as you wish, my brilliant " + pc.mf("handsome", "beautiful") + " friend.</i>\"");
	//Male Options: [Get Blown] [Pawjob]
	//Female Options: [Force Dildos]
	clearMenu();
	IncrementFlag("COC.TIMES_WINFUCKED_SANURA");
	//Req Cock
	addDisabledButton(0, "Fuck Her", "Fuck Her", "This scene requires you to have cock.");
	addDisabledButton(1, "Get Blown", "Get Blown", "This scene requires you to have cock.");
	addDisabledButton(2, "Pawjob", "Pawjob", "This scene requires you to have cock.");
	
	if(pc.hasCock()) {
		addButton(0,"Fuck Her",fuckDatLionPussah);
		addButton(1, "Get Blown", getBlownBySphinx, false);
		addButton(2, "Pawjob", getSphinxPawjob, false);
	}
	//Cunts & NoDicks
	addButton(3, "Magic Dildos", forceDildosSphinx);
	addButton(4, "Get Pegged", fenPutsHisShittyFetishInYoSphinx);
}

//Get Blown (Males & Herms)
public function getBlownBySphinx(submit:Boolean = false):void {
	clearOutput();
	output("You shed your armor, unleashing your [pc.cocksLight] into the dry heat of the desert.  Sanura licks her lips hungrily as you beckon her over, leaning back against the stone pillar to give her a good look at your fuckmeat.  The sphinx approaches, a sashay in her animalistic hips; soon she's running her small, delicate hands across your " + pc.skinFurScales() + ", brushing against all the right places.  Fingertips trace along your [pc.chest], circling your [pc.nipples] with slow, teasing strokes before descending, tracing along your belly and down to your [pc.hips]");
	if(pc.balls > 0) output(", one hand slipping down to cup your [pc.balls], rolling them in her palm until a white trickle escapes your [pc.cockHead " + pc.biggestCockIndex() + "]");
	output(".  The sphinx drops to her knees before you, leaning in to stroke her tongue along the side of your [pc.cock " + pc.biggestCockIndex() + "], caressing your manhood with a tongue that's rough, but surprisingly gentle on your most sensitive flesh.  She laps at the tip, eagerly drinking the first drops of sticky pre before turning her attentions elsewhere, letting the next drops stain the desert stands.");
	
	output("\n\nShe nuzzles against your crotch, slowly working [pc.eachCock], massaging your manhood until you feel ready to burst with pleasure.  Only then, with bright eyes looking up at you, locked with your own, does Sanura slip the [pc.cockHead " + pc.biggestCockIndex() + "] of your [pc.cock " + pc.biggestCockIndex() + "] into her mouth, wrapping her full lips around your throbbing erection.  You groan, [pc.legs] wobbling with need and desperation as she licks and teases your cockhead, brushing her slender digits along the underside.");
	
	output("\n\n\"<i>Hold on just a little longer, my friend,</i>\" the sphinx says, words muffled around the cock in her mouth.  \"<i>We've only just started....</i>\"");
	
	output("\n\nYou start to question her meaning when she suddenly releases your prick, letting it bob stiffly in the air; spit and copious streams of pre dangle like flags from your pole.  A few strands still connect the two of you, trailing from your tip to Sanura's lips, painting her two full lines a [pc.cumColor].  She grins up at you, even as her fingers begin to move in strange, arcane ways, weaving thin blue lines of magic in their wake as a spell takes shape.  In the blink of an eye, a pair of translucent hands appear just above Sanura's own, sparkling with eldritch light.  Your breath catches as the first of these magical hands brushes against your skin, a mind-numbing tingle rushing through your body from the point of contact.  Your mouth opens and closes wordlessly as your entire body seems to go slack, practically turning to liquid as the magical hands brush against your thighs and hips, tantalizingly far from your [pc.cocksLight], the tingling digits just out of reach of your most sensitive parts.");
	
	output("\n\nA finger brushes against your [pc.cock " + pc.biggestCockIndex() + "], just for the briefest moment.  You throw your head back and scream, your entire body convulsing as a thick rope of [pc.cum] spurts from your tip, smearing Sanura's face with your seed.  She releases you utterly, leaving you to writhe as your [pc.balls] empty out onto her eager face.  As you feel yourself winding down from the magically-induced orgasm, however, a strange blue sigil appears in the air, encircling [pc.eachCock].  \"<i>You do want to go again, yes?  I think I've got enough magic to keep that nice [pc.cock " + pc.biggestCockIndex() + "] hard for a little fun with my new hands....</i>\"");
	
	output("\n\nYou nod, then shudder as the sphinx's sex-magic works through you, her arcane symbols reinvigorating your spent manhood.  In moments, you're far harder than you were before, and thick ropes of [pc.cumNoun] spill out of your [pc.eachCockHead] - the [pc.cumFlavor] liquid flows freely onto the desert sands from Sanura's open mouth as your [pc.balls] churns out a seemingly endless supply of seed.  Your breath comes ragged as more and more spills out of you, your newly-potent manhood making you feel lightheaded as it expels an endless tide of [pc.cum].  Slowly, gently, Sanura leans in, wrapping her lips around the tip of your [pc.cock " + pc.biggestCockIndex() + "], lapping up the river of semen that pours into her mouth.");
	
	//If Multi-cock = 3
	if(pc.cockTotal() >= 3) {
		output("\n\nAs Sanura slurps up the tip of your [pc.cock " + pc.biggestCockIndex() + "], her ethereal hands grasp ");
		if(pc.cockTotal() == 2) output("your ");
		else output("two of your ");
		output("other " + num2Text(pc.cockTotal()-1) + " members, wrapping tightly around their meaty lengths.  You groan throatily as tingling digits slowly work their way up your shafts, making your heart flutter wildly with the alien sensation.");
		//AND If Multicock = 5
		if(pc.cockTotal() >= 5) output("  You barely have time to adjust to the eldritch hands jerking off your extra cocks when Sanura's own come into play, wading into the jumble of wangs growing from your crotch to grab another pair of pricks.  With five cocks encircled in hands, magic, and mouth, Sanura slowly begins to synchronize her movements, gently stroking your many cocks.");
	}
	
	output("\n\nAfter a few moments of her mouth and hands working wonders around your flesh, the sphinx-girl begins to pick up pace; in the span of a minute she ramps up from a gentle blowjob to a full-on face-fuck, going faster and faster with every beat of your heart and spurt of seed flowing from your magically stimulated [pc.balls].  Despite the sea of sperm you're creating, you can feel another orgasm approaching, rushing on despite the lingering aftershocks of the first.");
	
	output("\n\nWhen it hits, you almost lose consciousness, the sheer pleasure of the second orgasm throwing you onto your back in a writhing heap as your body convulses wildly with ecstasy.  You shudder and groan, your [pc.multiCocks] geysering into the air, raining back down in a pool around you and the now [pc.cumNoun]-covered sphinx.");
	
	output("\n\n\"<i>Enjoy yourself?</i>\" the [pc.cumColor] leonine girl asks, dropping to her knees beside you, a hand resting on your heaving chest.  You give her a weak thumbs-up, and stagger to your [pc.feet].");
	pc.orgasm();
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Force Dildos (CuntCommanders & Genderless)
public function forceDildosSphinx():void {
	clearOutput();
	output("You start to peel out of your [pc.gear], but a twirled finger from Sanura has you turn to face the stone pillar and brace yourself.  With silent grace, the half-cat slinks up to you, wandering hands moving to explore your body, her slender fingers tracing along the supple curves of your [pc.butt] and [pc.hips], slowly moving toward your [pc.chest] with slow, teasing motions, her every shift sending shivers up your spine.  Your breath catches as her fingers brush your [pc.nipples], gently squeezing them");
	//if MilkyTits:
	if(pc.isLactating()) output(" until a gentle trickle of your motherly fluids pours out across her hands.  With a girlish giggle, the sphinx slips her head under your arm, lapping at your milky teats.  A throaty purr escapes her lips before you give her a little push, getting her back to the task at hand");
	output(".");
	
	output("\n\nThe sphinx slips down onto her knees, leaning down to put her face on level with your [pc.butt].  You look back over your shoulder, watching as a lusty grin spreads across the leonine girl's lips.  She caresses your cheeks, slowly spreading them to give herself a good look at your waiting [pc.vagOrAss].  You bend yourself over a little more, waggling your ass in Sanura's face invitingly.  She pats your [pc.butt] and, looking you square in the eye, draws her tongue in a long, slow motion across your quivering hole, sending a spark of pleasure surging through your body.  Your [pc.legs] quiver as your lover lavishes you with another lengthy, sensuous lick.  Your [pc.vagOrAss] contracts powerfully as her feline tongue brushes it, begging for a cock to drain, to stuff it full to stretching and pump it full of warm, frothy cum.");
	
	output("\n\nInstead, the sphinx-girl teases you with another lick, and another; but as she does, you can see her fingers moving in arcane gestures, weaving thin blue lines of magic in their wake as a spell takes shape.  A long, wrist-thick pole of translucent blue light soon forms between her hands, the crown at its tip giving it the unmistakable shape of a phallus.  With a final lick across your sensitive flesh, the sphinx spreads your cheeks as wide as they'll go, letting your spit-slicked hole taste the dry desert air.  A moment later, you feel the tip of the spectral dildo against the mouth of your [pc.vagOrAss], the magical energies that form it sending electric currents through your body; every hair on your bare form jumps to attention as pleasure burns in you like a fire, even before the slightest penetration.");
	
	output("\n\nWhen the tip does slide in, you nearly cum on the spot.");
	if (pc.hasVagina()) pc.cuntChange(0, cockVolume(10), true, true, false);
	else pc.buttChange(cockVolume(10), true, true, false);
	output("\n\nEvery inch of your sensitive inner walls that the arcane pseudo-cock presses past explodes in a conflagration of pleasure, electrifying your every nerve as Sanura slowly sinks her summoned dildo into your [pc.vagOrAss].  You clench your teeth as you try to bear the orgasmic overload radiating from your fuck-hole, but the magical shock-wave soon spreads over your entire body.  Your [pc.legs] quiver as the half-lion sinks her rod deeper and deeper into you, reaming your innermost depths wide with inch after inch of mind-numbing stimulation.  Suddenly, though, her advance ceases, leaving you skewered on a gently-vibrating rod of arcane ecstasy.  Just as your sex-addled mind starts to question the lack of movement, you feel a sudden and overwhelming force pressing into your [pc.vagOrAss] atop the cock already embedded inside you, trying to stretch your hole even wider.  This second ethereal prick is even bigger than the first, slowly working and wedging itself into your abused hole, forcing you open until you're screaming in pleasure and pain.  Finally, the massive cock pops in, and relief spreads through you as Sanura starts gently working it in, cooing softly as she penetrates you once again.");
	
	if(pc.hasVagina()) {
		//if PC has Vagina
		output("\n\nAs your quivering cunt tries to adjust to the pair of massive intruders tearing it apart, the sultry sphinx conjures up a third rod, just as big as the last.  You grit your teeth, bracing for her attempt to cram THAT up your slit as well, but instead feel only a gentle, probing wetness against your [pc.ass].  You shiver from your very core as Sanura drags her tongue along your backdoor, pressing the tip in, seeking entrance.  Despite the static pleasure roiling in your cunt, you try your best to relax the muscles in your sphincter; eventually, after a few long moments of prodding, you feel the first inch of the magic dildo pierce your [pc.asshole], stretching you out to your limit and beyond as Sanura shapes its size to utterly fill your rear entrance.");
		pc.buttChange(cockVolume(10), true, true, false);
	}
	//If PC Ain't Got No Cunt
	else {
		output("\n\nWith two arcade implements tearing your anus apart, you barely even notice as the tip of a third conjured rod begins pressing into your hole, fervently intent on joining its fellows.  Suddenly, you feel the two shafts already stuck inside you shift, moving aside to accommodate a third magicock, that's just as big as the last two Sanura filled you with.  Your entire body convulses as your poor, abused asshole is stretched beyond anything you thought it could ever take, the three massive cocks sliding deep into your bowels.  Your muscles spasm around the tingling rods, inner walls contracting hard as if to milk them of whatever these things might have that passes for cum.");
	}
	
	//Recombine
	output("\n\nWith three huge dildos of pure energy fucking you, you don't have much hope of lasting long.  You dig your fingers into the hard, unyielding stone of the desert obelisk, groaning as Sanura slides her dildos in and out of you with unforgiving rhythm, the strange magic from which they're formed electrifying your sensitive depths with eldritch pleasure.  When you cum, you cum hard - a scream tears past your lips, echoing across the dunes.");
	
	output("\n\nAs you cum, you feel - something - shooting inside you, a flood of boiling liquid that sets your loins ablaze, spreading throughout you with orgasmic pleasure.  You shudder violently as a backwash of magical cum floods back out your [pc.vagOrAss] on onto Sanura's waiting face, your belly bloating to pregnant proportions before the orgasm finally subsides.");
	
	output("\n\nYou collapse as the dildos fade into nothing inside you, leaving you feeling empty to your very core.  \"<i>Enjoy yourself?</i>\" the spunk-covered leonine girl asks, dropping to her knees beside you, a hand resting on your heaving chest.  You give her a weak thumbs-up, and stagger to your [pc.feet].");
	//(DIsplay Options: Leave, Enter)
	pc.orgasm();
	clearMenu();
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Fuck Dat Lionpussy
//Written by Third. Available to those who BEAT Sanura's riddle challenge.
public function fuckDatLionPussah():void {
	clearOutput();
	output("You disrobe, tossing your [pc.gear] aside into a small pile.  You stretch your muscles in the dry desert air and exult in the warm rays beating down on your " + pc.skinFurScales() + " and [pc.cocksLight].  Sanura pads around you, taking in your appearance with her chestnut-colored eyes before clicking her tongue approvingly.  Her leonine tail swishes across the top of your [pc.cock " + pc.biggestCockIndex() + "], stroking it with the silky soft tuft of fur at its tip.  You shiver at the contact, unsure of what to think.  Your penis, on the other hand, has no such conflictions, and immediately begins to rise.");
	
	//(Small dicks) 
	if(pc.biggestCockVolume() < cockVolume(6)) output("\n\n\"<i>Aw, it's so cute and compact.  I didn't know these things came in women's sizes,</i>\" she giggles, flicking the [pc.cockHead " + pc.biggestCockIndex() + "] of your cock with her tail.  You blush brightly.  Even by Ingnam standards you're a little below average, and in Mareth, well, you're just plain tiny.  \"<i>Don't worry, love, it will suffice for what I have in mind.</i>\"");
	
	//(Normal-sized dicks)
	else if(pc.biggestCockVolume() < cockVolume(30)) output("\n\n\"<i>Hm, not the biggest I've seen out here, but it certainly looks delicious...</i>\" she purrs, wrapping her tail around your cock.  Sanura gives it a little squeeze and flicks her tail away with a giggle.");
	
	//(Large dicks)
	else if(pc.biggestCockVolume() < cockVolume(100)) {
		output("\n\n\"<i>Mmm, now that's what I'm talking about,</i>\" Sanura purrs, wrapping her tail around your large dick and teasing your ");
		if(pc.balls > 0) output("balls");
		else if(pc.hasVagina()) output("cunt");
		else output("asshole");
		output(" with the little tuft of fur.  \"<i>That bad boy will be just perfect.</i>\"");
	}	
	else output("\n\nSanura's eyes go wide upon seeing your monstrous cock.  She opens her mouth, attempting to speak, but no words come out.  Her tail reaches out, coiling around your dick in futility.  \"<i>By Marae's pillowy tits that thing is huge,</i>\" she says finally, regaining her voice.  \"<i>I don't know if I can take something that big... but goddamnit, I'm going to try.</i>\"");
	
	output("\n\nYour manhood spikes upwards at the attention, becoming painfully hard as the sphinx continues to survey your body.  Her tail flicks over your " + pc.skinFurScales() + " gently, stopping briefly to tantalize ");
	if(pc.totalNipples() == 2) output("both");
	else output("each");
	output(" of your nipples, which stiffen in response, just like your cock.  You can't help but think there's some sort of magic at work here.  Her tail passes between your thighs, gracefully tickling your ");
	if(pc.hasVagina()) output("damp cunt, which suddenly tightens up and practically gushes with slick juices.");
	else output("asshole, which reflexively tightens, sending a shiver up your spine.");
	
	output("\n\nFinally she stops and looks at you head on.  \"<i>All right then, lay down and let's do this,</i>\" she says casually, crossing her arms under her small breasts.  You quirk your eyebrow at her, questioningly.  \"<i>This is what you want, isn't it?</i>\" she asks,  turning her sensuous tauric body around to show off a moist, dripping cunt.  \"<i>Because that,</i>\" she says, pointing at your dick as she licks her lips, \"<i>is what I want.</i>\"");
	
	output("\n\nThe sight of that lionpussy is all the enticement you need.  You sink to your knees, and then flop onto your back, your cock standing tall and proud just like the stone pillar nearby.  The brilliant and ravishing sphinx strides over top of you, placing a soft leathery paw over your wrists gently.  \"<i>Mmm, don't worry about this, love, I just want to make sure you're not going anywhere.</i>\"  You gently struggle against the paws, not actually trying to free yourself, but rather testing her strength, and she is indeed strong.");
	
	output("\n\n\"<i>Let's start off with a bit of a warm up, shall we?</i>\" she asks with a mischievous grin.  Her leonine body lowers down towards yours, making you gasp sharply as your rigid rod contacts her feline folds.  But alas, there's no penetration.  Instead, Sanura rocks her body up and down your shaft, tantalizing and teasing it with her hot, wet folds.  You bite your lip while the sphinx above you moans with mild delight.  \"<i>O-ho,</i>\" she laughs, \"<i>you may have bested me intellectually, but I can still tease you.</i>\"");
	
	output("\n\nSanura grips one of her breasts, pinching the nipple roughly while she continues to slip up and down your pillar of cock.  You attempt to push your hips forward, aching to penetrate her pussy, but she merely mutters, \"<i>Tut-tut,</i>\" and waggles a finger at you disapprovingly.  You glower up at her for a moment, and then a plan alights in your brain.  As soon as the sumptuous sphinx turns her attentions back to her breasts, you concentrate on her hip motions, developing the rhythm in your head.");
	
	output("\n\nYou count out the rhythm, and when the time is right, thrust your hips up and forward, splitting Sanura's cunt wide.  A look of shock crosses her face, quickly replaced by an ecstatic look of bliss.  Her lips form an O-shape, allowing a long moan to escape.  \"<i>I... you're not supposed to...</i>\" she starts, looking down at you with a mixture of annoyance and pleasure.  \"<i>Oh fuck... so good!  Don't stop!</i>\"");
	
	output("\n\nYou grin and thrust into her again.  Her hips pick up the pattern and bounce along with your hips, making wet squelching noises as you plunge your [pc.cock " + pc.biggestCockIndex() + "] into her again and again.  Sanura's cunt squeezes you tightly, tighter than you'd imagine a tauric creature to be, while she plays with her pert little breasts, apparently lost in a sea of euphoric oblivion.  Small gasps leave her lips with every other thrust, escaping onto the warm desert breeze.  Your hips hammer away, your entire body becoming passionately hot, craving some form of release, but you don't give in just yet.");
	
	output("\n\nYou bring Sanura to her first screaming orgasm, then a second, and a third.  You don't stop until the sphinx is little more than a quivering mass of flesh wrapped in orgasmic rapture.  Her legs shake like jelly, barely holding your arms down, but that doesn't matter anymore.  You know who's in control of this situation, and it's certainly not the lioness atop you.  Thrust after thrust you bury your tool deeper within Sanura's cavern, bringing her to a fourth orgasm as her face distorts, showing little more than a climax-induced grin, her eyes rolled back in their sockets.");
	
	output("\n\nYou can't hold out much further either, and give one last push forward, embedding your cock as far as it will go");
	if(pc.hasKnot(pc.biggestCockIndex())) output(", your knot slipping into place with a moist <b>pop</b>, ensuring you'll be locked together for the foreseeable future");
	output(".  Jet after jet of cum erupts from your [pc.cock " + pc.biggestCockIndex() + "], painting the sphinx's inner walls [pc.cumColor].");
	
	//(low-average cum)
	if(pc.cumQ() < 250) output("\n\nSome of your spunk dribbles out the side and down your shaft before dripping into the hot desert sand below.");
	//(average-high cum)
	else if(pc.cumQ() < 750) output("\n\nA spurt of cum escapes Sanura's folds, splattering out onto your [pc.legs] and the hot desert sand.");
	//(high-really high cum)
	else if(pc.cumQ() < 3000) output("\n\nSanura's belly visibly enlarges with all the love spunk you're pumping into her, and several spurts of the stuff escape her folds, coating your [pc.legs] and the sand beneath you.");
	//(really high-woah there cum)
	else if(pc.cumQ() < 10000) output("\n\nSanura's belly distends, looking suddenly pregnant with an enormous cum-baby.  A veritable flood of spooge surges out of her abused cunt, absolutely coating your lower body and almost all the sand within several feet in the hot [pc.cumColor] fluid.");
	else output("\n\nSanura's belly expands outwards, as though she were suddenly nine months pregnant, but it doesn't stop there.  Her belly continues to inflate until it's resting on your stomach... and then it lifts her body off several inches of yours.  To top it all off, a [pc.cumColor] flood of biblical proportions flows out of her abused hole, coating your entire body, as well as most of the desert within ten feet, in semeny goodness.");
	
	output("\n\nFinally you collapse, letting all your muscles relax.  Sanura isn't far behind, falling to the side of you, ");
	if(pc.hasKnot(pc.biggestCockIndex())) output("which proves somewhat uncomfortable, given your knot is still lodged firmly within her, ");
	output("panting wildly.  It takes you several minutes to recover, the sphinx even longer, ");
	if(pc.hasKnot(pc.biggestCockIndex())) output("and even longer still for your knot to deflate enough to slip out of her, ");
	output("but you finally gather the strength to haul yourself up onto your [pc.feet].");
	
	output("\n\n\"<i>Well, that's certainly not what I had in mind,</i>\" Sanura says, recomposing herself after that vicious fucking.  \"<i>But I can't say I can complain.</i>\"  Neither can you, you smirk to yourself.");
	processTime(25 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Submission Options
public function sphinxSubmissionOptions():void {
	clearOutput();
	IncrementFlag("COC.TIMES_SUBMITTED_TO_SANURA");
	output("Having lost the Riddle Game, you do as the sphinx-girl commands: you pull off your [pc.gear], leaving yourself bare under the desert sun. \"<i>Now then, my dull little pet, what shall I do with you...</i>\"");
	clearMenu();
	//SUBMISSION:
	addButton(0, "Get Pegged", fenPutsHisShittyFetishInYoSphinx);
	//Reqs Penis
	addDisabledButton(1, "Get Blown", "Get Blown", "This scene requires you to have cock.");
	addDisabledButton(2, "Pawjob", "Pawjob", "This scene requires you to have cock.");
	if(pc.hasCock()) {
		addButton(1, "Get Blown", getBlownBySphinx, true);
		addButton(2, "Pawjob", getSphinxPawjob, true);
	}
}

//Horsecock Symphony
public function fenPutsHisShittyFetishInYoSphinx(submit:Boolean = true):void {
	clearOutput();
	output("Starting to disrobe, ");
	if(pc.hasCock()) {
		output("you flop your [pc.cocksLight] free in the dry desert heat, allowing ");
		if(pc.cockTotal() == 1) output("it");
		else output("them");
		output(" to sway back and forth");
	}
	else if(pc.hasVagina()) {
		output("you expose your [pc.vagina] to the hot desert air, allowing it to moisten");
	}
	else output("you expose your [pc.butt], allowing it to redden");
	output(" as the omnipresent heat and seductive sphinx have their way with your heightened libido.  Sanura snaps her palm up in front of your face as your [pc.gear] hits the ground, landing with a heavy thump.");
	
	output("\n\n\"<i>You don't need to seduce me, you know?  Just go ahead and assume the position,</i>\" she commands, wings fluffing the hot, dry air across her breasts, fanning her delicious tan mounds.");
	
	output("\n\nUmm, position?  You're not quite sure you follow, and you're sure to say as much.");
	
	output("\n\nSanura folds her arms across her perky tits and rolls her eyes.  \"<i>You know, bent over, on the ground, ass-up and open?</i>\"  She blows a strand of black hair air of the way with an exasperated sigh.  \"<i>Just how long have you been in Mareth?  You know what?  Never mind, just get that ass up so I can plow it.</i>\"");
	
	output("\n\nYou can't help but point out the obvious: she doesn't have a penis, at least not one you can see.");
	
	output("\n\n\"<i>So?</i>\"");
	
	output("\n\nWell, she can't really fuck your [pc.asshole] without one...");
	
	output("\n\nSanura laughs, \"<i>I'm a sphinx.  Reality is my plaything!  Go on...</i>\"  Her heavy forepaw falls on your shoulder, the soft, feline-like pads compressing soft and pillow-like against your " + pc.skinFurScales() + ", forcing you down.  You lean over " + (submit && pc.cor() < 33 ? "reluctantly" : "eagerly") + " and lift your [pc.butt] towards the assertive lioness, shivering at how open and exposed you are like this, your [pc.asshole] puckered and ready to be plowed.  Her other paw comes down on your right shoulder, and the shadow of her muscular, leonine lower body falls across you, causing her warm body heat to wash over you.  Sanura's soft underfur brushes across your back, tickling you sensually as she gets in position.  Curling over your shoulders, her toes extend deadly looking claws, but they do no more than press against the top of your chest, securing you in place with cushy paw-pads and pointed threats.");
	
	output("\n\nTilting your head to the side, you try to look up above, but all you can see past her brustling belly-fur are the pert swells of her cleavage and a few swirling, ephemeral hexagons floating around her wrists while her fingers swivel with inhuman dexterity.  There's a barely audible 'fwoomp' followed by a tingling against your [pc.asshole], abruptly carrying its magical effervescence into your sphincter as something flat and blunted butts up against it.  Your eyes open wide in surprise at the pressure on your backdoor, something Sanura takes absolute delight in seeing, bending her human-half over to take in your expression while her forepaws push you harder onto her magical spear.");
	
	//Big capable entrances 100+
	if(pc.analCapacity() >= cockVolume(100)) {
		output("\n\nYou will yourself to relax, and like magic, your [pc.asshole] stretches out to handle the elephantine force-cock with ease, devouring the flat, flared phallus straight into your rectum.  It distends your [pc.belly] slightly as it pushes deeper, Sanura grunting when a middle ring catches for a second before popping in, rapt with the ecstasy your welcoming asshole can provide.  She provides you with a lazy smile before straightening out and placing her hand on your head, stroking your " + pc.hairDescript() + " and lazily patting you as she finally bottoms out, accompanied by the feeling of sparking, tingling nuts slapping hard into your [pc.butt].");
		output("\n\n\"<i>Mmmm, I knew you'd be a good " + pc.mf("boy","girl") + ".</i>\"");
	}
	//Medium capacity! 40+!
	else if(pc.analCapacity() >= cockVolume(40)) {
		output("\n\nYou will yourself to relax, but even so, your [pc.asshole] is stretched to its limit even before Sanura's flared force-cock can pop inside.  Whimpering in discomfort, you try to endure her forceful attempts at buttfucking.  She doesn't seem to have any such plans, smashing her fat, butt-destroying horse-cock against you again and again, each time spreading your asshole further, pounding your sphincter's structural integrity down into that of a weak, accepting anus.  You feel it bow under the pressure.  Growling, Sanura holds it there, pressing with such insistent strength that your entrance yields all at once; her member's brutal, bulging tip pops into your rectum.  She doesn't stop there.  Inch after inch of tingling, phantasmal dong is pushed straight up your straining rectum, only pausing for a brief moment when the swollen middle ring catches for a half-second.");
		output("\n\nElectrically charged balls the size of large melons plop against your [pc.butt] as she bottoms out.  \"<i>Mmmm, I knew you'd be a good " + pc.mf("boy","girl") + ".</i>\" Sanura purrs, patting you on the head.");
	}
	//Lowish Capacity
	else {
		output("\n\nYou will yourself to relax, but you just aren't big enough back there to make much of a difference.  Just having such an immense dong pressing at your backdoor is enough to push you to your limits, but your sphincter hasn't even dilated enough to take a fraction of her girth.  Sanura growls in frustration and begins to hump at it, smacking the blunted tip into it again and again. The shocking sensation makes your anal muscles twitch, spasm, and relax as she works to plow her way through your more than token resistance.");
		//VIRGIN ALT: 
		if(pc.analVirgin) {
			output("\n\nShe grunts, \"<i>Don't tell me you're a virgin?</i>\"  You nod and bite your lip as you try to endure.  Sanura stops immediately at that news, mulling it over with a detached expression, a smile slowly spreading across her features.  \"<i>Really?</i>\" she asks as her hips begin to slowly work at your ass once more, slowly picking back up to their old tempo.  \"<i>Then it's a good thing you're getting to ride my magic cock and not some brute's.  It might hurt a little, but I promise this will be buttsex worth remembering....</i>\"");
		}
		//Non-virgin
		else output("\n\nShe grunts, \"<i>Gods, you're tighter than a virgin imp's asshole!</i>\"");
	}
	//Merge, no new PG
	output("\n\nThat's no small comfort to your poor, sore rectum.  It's going to be left gaped by this monstrous woman in short order, pounded into open, stretched submission, just like its owner.  The pain of being opened up this forcefully is enough to bring a tear to your eye and a strange surge of excitement through your crotch.  How can you be enjoying this?  You don't have long to ponder it, your muscles are caving in underneath Sanura's butt-battering fucking, slowly, inexorably stretching to handle her fat flare.  Gods!  You whimper as your [pc.asshole] abruptly gives up the ghost and allows Sanura's phantom member inside, inches of her tingly fuck-tool nestling inside you in seconds.");
	
	output("\n\nSanura straightens with an unseen smile, her hand playfully tangling with your " + pc.hairDescript() + " as she hilts the rest of the way into your abused anus, not stopping until jiggling, magical nuts slap into your [pc.butt].  \"<i>Atta " + pc.mf("boy","girl") + ".  I thought for a moment that this might have been a waste of magic.  Now just settle in and enjoy it.</i>\"  You wince with the knowledge that " + (submit || pc.cor() > 33 ? "somehow, " : "") + "you ARE enjoying it.  The pain seems to have faded with the magical buzzing in your butthole, and all that you're left with is a satisfied stretching and the friction that comes with it.");
	
	//END VARIATION
	//Buttchange 75
	pc.buttChange(cockVolume(75), true, true, false);
	
	output("\n\nSanura reluctantly changes direction and begins to pull the immense length out of you.  She actually yanks it back far enough that the top flops out of your gaped orifice, flopping lewdly against a [pc.leg] as she lines back up for a second push.  As the sphinx nudges her tree-trunk-like totem into you, you try to fathom the size of the thing.  It must be several feet long and at least four inches wide by the way it's distending your innards, maybe five inches across at the tip.  Moaning, you helplessly give yourself over to the unusual feelings her ephemeral erection installs in your plugged-up pucker.");
	
	output("\n\n\"<i>Yeah, I knew you'd like it,</i>\" Sanura drawls, \"<i>I had you pegged for some kind of butt-slut when I met you.</i>\"  She lurches her hips forward to bury herself the rest of the way inside.  \"<i>Now, I just have you pegged.</i>\"  She smirks and resumes a long, slow reaming of your bowels.");
	if(pc.cockTotal() > 0) output("  Pre-cum oozes from [pc.eachCock] in steady strings that dangle onto the dirt, painting a swirled pattern beneath you as your prostate is pushed hard enough to squeeze trickles of your [pc.cumFlavor] 'milk' from you.");
	
	output("\n\nMoving faster now, Sanura descends into sexual frenzy.  She ruts your butthole like a beast possessed, and given the phantasmal nature of her equine dick, you have to wonder if that isn't what happened.  The leonine beauty savagely pounds your [pc.asshole] with long, heavy strokes, leaving nothing but tingling excitement in her wake.");
	if(pc.cockTotal() > 0) output("  Whenever her flare slides past your prostate, the wide, blunt head squeezes it hard enough to express a huge strand of pre.");
	output("  After a few such thrusts, her bouncing, fake balls rise up in their faux, fleshy sack.  Her swollen dick-tip engorges more than you thought possible inside you, wide enough for you to touch through your belly and marvel at the size.  Quivering from head to four lion-like toes, Sanura cums.");
	
	output("\n\nThe butt-breaking horse-cock releases enough cum into you to make your middle audibly gurgle and your belly begin to distend, flooding your intestines with tingles and liquid warmth.  Thankfully, Sanura slowly begins to pull out, even as she's cumming, her cock flexing in your brutalized asshole for every inch it's pulled past, leaving enough goo in its wake that your innards never get to relax.");
	if(pc.cockTotal() > 0) output("  When she crosses the lump that is your well used prostate, you lose control and shudder with a nice, long cum of your own, your arms giving out and dumping you face-down on the ground while you spurt [pc.com] onto your chest, chin, and then the ground.");
	else output("  When she's almost out, you give in and cum, quivering around her magical breeding tool while it finishes inseminating your guts.");
	output("  The head is so swollen that she actually struggles to pop it back out of your [pc.asshole], bouncing her hips back a few times with little success");
	if(pc.cockTotal() > 0) output(" and dragging you through your fresh, [pc.cumColor] puddle");
	output(".  Eventually, she gives a mighty, sphincter-stretching lurch and ejects from your [pc.butt], painting it white on the way out.");
	output("\n\nYou collapse in a well-fucked heap while Sanura's extra addition fades away.  She lays down next to you, fanning her face with her wings as you try to recover.  Her arm rubs one of your cheeks, still sensitive from whatever magic was in her balls, and she says, \"<i>That was great fun.  Let's do it again sometime?</i>\"");
	output("\n\nYou muster the strength for a thumbs up, a dopey smile still painted on your face.");
	pc.orgasm();
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function getSphinxPawjob(skipped:Boolean = false):void {
	clearOutput();
	//[skip riddles, just request from menu (requires some event occurrence > 1)]
	if(skipped) {
		output("\"<i>Really, [pc.name]?</i>\"  Sanura smirks and shakes her head.  \"<i>I probably shouldn't do this sort of thing just because you ask for it, but your fascination with my paws is too cute to ignore.  Go on, then, strip for me and I'll get to it.</i>\"  You oblige, happily tossing aside your armor.  [pc.EachCock], already standing erect with anticipation, bounces freely before you.  The sphinx eyes ");
		if(pc.cockTotal() == 1) output("it");
		else output("them");
		output(" lustfully, momentarily entranced by the swaying motions of your member");
		if(pc.cockTotal() > 1) output("s");
		output(".");
	}
	//[player requests big fluffy paws on their dick after solving a riddle]
	//[if event occurrence == 0]
	else if (flags["COC.SPHINX_PAWJOBS"] == undefined) {
		output("Sanura raises her eyebrows at your demand, her expression somewhere between surprise and curiosity.  \"<i>Well, that's something of an odd request, but I suppose I'm obliged if it's your wish.</i>\"  Not bothering to give her a chance to consider your demand any further, you pull off your armor and cast it aside.  \"<i>Can't say I've even been asked for something like this before...  I apologize in advance for my inexperience, [pc.name].</i>\"  The sphinx looks down at her paws, obviously confused as to why you would ask for this in particular.");
	}
	//[if event occurrence > 0]
	else {
		output("\"<i>Again?</i>\" Sanura asks, cocking her head to the side.  \"<i>They must feel better than I imagine... well then, get out of your clothes and I'll do as you ask.");
		if(pc.biggestCockVolume() > cockVolume(100)) output("  It's not as if there's all that much else I can do for that monster of yours anyways.");
		output("</i>\" She raises a paw and examines it, as though trying to figure out just what it is about them that you enjoy so much.  You cough as a means of drawing her attention once you've stripped off the last bit of your armor, shaking her from her reverie.");
	}
		
	output("\n\nSanura asks that you kneel, and you eagerly comply.  ");
	//[if dick isn't already hard and PC knows what's coming]
	if(pc.lust() < 50 && flags["COC.SPHINX_PAWJOBS"] == undefined) {
		output("Even as you drop to your knees before Sanura, your cock");
		if(pc.cockTotal() > 1) output("s");
		output(" begin");
		if(pc.cockTotal() == 1) output("s");
		output(" to harden in anticipation while your mind wonders at just what this will feel like.  ");
	}
	output("The sphinx bends too, so that her head is level with your crotch.  With a little bounce, she throws her large paws around your hips and roughly pulls you closer.  The guardian wastes no time, licking along the shaft");
	if(pc.cockTotal() > 1) output("s");
	output(" of your ");
	if(pc.cockTotal() > 1) output("various ");
	output("prick");
	if(pc.cockTotal() > 1) output("s");
	output(" with a soft, skilled tongue.");
	//[if pc was soft before]
	if(pc.lust() < 50 && flags["COC.SPHINX_PAWJOBS"] == undefined) {
		output("  It isn't long before her oral ministrations have your cock");
		if(pc.cockTotal() > 1) output("s");
		output(" standing erect, throbbing with hunger for more sensation.  You wonder as to what exactly she has planned, but you think it's shaping up to be something good.");
	}
	//[continue]
	output("  Her long, expert strokes methodically coat your member");
	if(pc.cockTotal() > 1) output("s");
	output(" in a glistening veil of saliva. After a while, she pulls her head away and examines her work.");
	
	output("\n\nApparently deeming ");
	if(pc.cockTotal() > 1) output("them");
	else output("it");
	output(" sufficiently lubricated, Sanura lifts a foreleg and carefully guides her paw towards your crotch.");
	//[if PC doesn't expect it]
	if(pc.lust() < 50 && flags["COC.SPHINX_PAWJOBS"] == undefined) output("  You raise your eyebrows in surprise, but you're not in much of a position to do anything about her foot's advance.");
	output("  She playfully taps at your cock, purring sensually as she sets it bouncing with a light bat.  After watching it for a moment, she hesitantly pushes forward so that her paw gingerly rests against ");
	if(pc.cockTotal() > 1) output("one of ");
	output("your shaft");
	if(pc.cockTotal() > 1) output("s");
	output(", pushing your cock up against your waist and trembling with the effort of keeping her touch gentle.  The pad of her paw, made soft and warm by the sands of the desert, presses lightly around your cock.  Slowly, hesitantly, she begins to rub up and down, her paw gliding along your slickened skin.");
	//[if cockradius < xXXXX(most people should see this)]
	if(pc.smallestCockArea() < 100) output("  As she pushes onto you just a bit more forcefully, your member slips between two of her digits.  She continues her slow, rhythmic movements with just a bit more grip, and you're made quite thankful that her claws are so retractable as she brushes against your belly.");
	
	output("\n\nTan, fluffy fur tickles you as Sanura keeps stroking away, motions made perfectly smooth by the thick coat of saliva that still covers your cock.  The wide, cushiony embrace of her paw feels as though it might engulf your cock at any moment, so strongly do you feel the comfortable, pleasurable sensations.  ");
	//[if PC did not request da paws && event occurrence == 0]
	if(!skipped && flags["COC.SPHINX_PAWJOBS"] == undefined) output("It feels wonderful in a peculiar sort of way; though it's certainly not the treatment you expected to receive, you can definitely feel your arousal being pushed along and built up by her paw.  ");
	//[if PC has 2+ dicks]
	if(pc.cockTotal() > 1) output("Not content to leave your other cocks neglected, the sphinx leans in and starts to lick and suckle once again at the pricks not beneath her paw.  You shudder at the feeling of her tongue darting from shaft to shaft and teasing your heads, sharper sensations punctuating her foot's more constant pleasuring.  ");
	output("The fuzzy warmth clouding your mind dazes you, and you sway slightly in place, letting her rock you back and forth with her motions.");
	
	output("\n\nThough her attentions definitely feel nice, the shaky, imperfect nature of the pawjob leave you thirsting for more as the tension builds in your cock");
	if(pc.cockTotal() > 1) output("s");
	output(".  You suddenly grab her ankle, and she looks up at you confused, probably thinking you mean for her to stop.  You guide her back into steadier, quicker motions in short order though, eliciting a giggle from the playful sphinx.  She presses against you more confidently with your hand there to guide her, less fearful of causing you harm.  You slide her paw faster and faster, desperate to bring yourself more sensation and to orgasm.  Not feeling like it's quite enough, you take her other large paw from your hip and press its pad against your shaft too, using her feet like some odd sex toy to hug your [pc.cock " + pc.biggestCockIndex() + "].  Rather than being upset about being used in such an unusual manner, Sanura coos and grasps at your meat even tighter, reveling in the strange experience.  You buck your hips slightly in time with the strokes, and it's not long before you feel a familiar need and warmth well up inside.");
	
	//[if cum output is normal]
	if(pc.cumQ() < 250) output("\n\nWith a few final pushes you find release, spraying ropes of [pc.cum] along the length of her leg.");
	else {
		output("\n\nA torrent of [pc.cum] bursts forth from your cock");
		if(pc.cockTotal() > 1) output("s");
		output(" like a geyser, covering both you and Sanura in a flood of your semen.  The flow doesn't stop, cum churning and burning as it roils within you.  The sphinx pulls away in an effort to dodge the unexpected volume of man-milk, but to no avail: both halves of her body are painted [pc.cumColor] and your [pc.cumNoun] drips from her hair to her skin, fur, and wings. She tries to wipe her face at least clean, but manages only to smear more across her cheek.  With a sigh, she shakes what she can off her hands.");
		applyCumSoaked(pc);
	}
	output("  Exhausted from the orgasm, you let go of her, leaving the sphinx to milk out the last drops of cum with gentle pressure from her pad on her own.  Sanura stands back up and laughs.  \"<i>Look at the mess you made!</i>\"  She places her dirtied paw on your chest and pushes you back, easily making you fall on your [pc.ass].  \"<i>Well, that was... interesting");
	if(flags["COC.SPHINX_PAWJOBS"] != undefined) output(" as always");
	output(", [pc.name].  Now get your stuff back on, I've a temple to guard and a coat to clean.</i>\"  At that, she turns and pads away from you, lying down in front of the door and licking at her");
	//[if cum output is normal]
	if(pc.cumQ() < 250) output(" leg.");
	else output(" stained fur in a futile attempt to get some of your cum off.");
	
	if (flags["COC.SPHINX_PAWJOBS"] == undefined) flags["COC.SPHINX_PAWJOBS"] = 0;
	flags["COC.SPHINX_PAWJOBS"]++;
	
	pc.orgasm();
	//dynStats("sen", -2);
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
