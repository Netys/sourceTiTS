import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//faerie Encounter
public function encounterFaerie():void {
	//spriteSelect(17);
	if (flags["COC.FAERIE_FUCKED"] == undefined) flags["COC.FAERIE_FUCKED"] = 0;
	if (flags["COC.FAERIE_FUCKED_FEM"] == undefined) flags["COC.FAERIE_FUCKED_FEM"] = 0;
	clearOutput();
	
	output("A faerie slightly taller and thicker than your middle finger flits about the air. Her flat chest and girlish bob of hair make her look quite cute, but the solid black stockings and leather straps covering her chest show her slutty nature. Her wings are a light red, the color of aroused genitals.\n\n");
	
	if(pc.cockTotal() > 0 && (!pc.hasVagina() && pc.mf("m", "f") == "m" || rand(2) == 0 && !pc.hasStatusEffect("Genital Slit"))) {
		var smallCock:Number = pc.shortestCockIndex();
		output("She seems to notice you getting hard at the sight of her and looks down. \"<i>Ew, man parts!</i>\" the faerie exclaims, flying away like a frightened bird.");
		
		if (rand((pc.RQ() + pc.AQ()) / 3) + flags["COC.FAERIE_FUCKED"] > 15) {
			if(flags["COC.FAERIE_FUCKED"] < 5) {
				output("\n\nYou make a desperate lunge for the faerie girl and grab her before she can fly away.   She wriggles and squirms in your grasp, shouting, \"<i>Let me go you meanie!</i>\"\n\n");
				output("It would be cute if she wasn't dressed up like such a slut.  You bet you could get her to help pleasure you, but she might not like it.  Or you could be a nice " + pc.mf("guy", "girl") + " and let her go...\n\nDo you force her to pleasure you?");
			}
			else if(flags["COC.FAERIE_FUCKED"] < 10) {
				output("\n\nYou snatch her out of the air fairly easily.  She seems like she's slowed down a little.   She squirms and wriggles, begging you, \"<i>Please don't cover me in cum again... I get so drunk and feel even sluttier afterwards.  I don't want to be a slut!</i>\"\n\nShe pouts, but blushes.  Do you make her get you off again?");
			}
			else if(flags["COC.FAERIE_FUCKED"] < 15) {
				output("\n\nYou grasp the dizzy faerie out of the air with ease, smiling as you feel the flood of wetness between her thighs moistening your hand.  She wriggles and moans, \"<i>No, not again!  I want another cum-bath so bad... but I'm losing myself to it.  It's hard to keep flowers pollinated when you're jilling off half the day and waiting for a nice hard cock to wander your way...</i>\"\n\nShe wants to get you off almost as you do.  Do you make her service you again?");
			}
			else {
				output("\n\nYou lazily make a grab for her and easily snatch her out of the air.  Her body is sticky with a mix of desire and your last encounter.  You can feel her humping against your pinky while she begs, \"<i> Come on, let me ");
				if(pc.isCrotchGarbed()) output("crawl into your clothes and ");
				output("wrap myself around your shaft.  I promise I'll only drink a little pre-cum this time, just enough to let me get off.  I'll be a good faerie slut, just let me get you off ! </i>\"\n\n Do you let the faerie get you off?");
			}
			
			pc.lust(pc.libido() / 10 + 2);
			clearMenu();
			addButton(0, "Yes", faerieCaptureHJ);
			addButton(1, "No", letFaerieGo);
			if (flags["COC.FAERIE_FUCKED"] < 5) addButton(2, "Never", disableFaerieEncounterForGood);
			return;
		}

		pc.lust(pc.libido() / 10 + 2);
		if (pc.lustQ() >= 90) {
			output("\n\nYou groan miserably with frustration. Desperate for stimulation, you sink to your knees and start jacking off, the faerie's visage still fresh in your mind. You catch a fleeting glimpse of yourself tightly gripping the faerie's legs in each of your fists, dragging her toward ");
			output("your [pc.cock " + smallCock + "], ");
			if (pc.cocks[smallCock].cLength() > 3) output("too large for her tiny frame... ");
			else output("fitting her tiny frame... ");
			output("the depraved image overwhelms your mind's eye and you find yourself shooting all over the ground furiously.");
			pc.orgasm();
		}
		else output("\n\nYou try in vain to jump and catch her, but she's too high above you and much too fast.");

		processTime(5 + rand(5));
		clearMenu();
		addButton(0, "Next", mainGameMenu);	
		return;
	}
	
	output("The faerie slows the beating of her wings and hovers towards you. You dismiss your fearful notions, certain a small faerie is quite harmless to you.\n\n");
	output("How do you react?");
	//Shoo Away, Nothing, RAEP
	
	clearMenu();
	addButton(0, "Shoo Away", faerieShooAway);
	addButton(1, "Nothing", faerieDoNothing);
	
	addDisabledButton(2, "Rape", "Rape", "This scene requires you to have vagina.");
	if (pc.hasVagina()) addButton(2, "Rape", faerieRAEP);
}

private function faerieRAEP():void {
	//spriteSelect(17);
	//Count secksins
	flags["COC.FAERIE_FUCKED_FEM"]++;
	clearOutput();
	
	output("You let the tiny faerie buzz closer to investigate, then with an explosion of movement, snatch her out of the air.  She squirms in your palm, struggling futilely in your grasp.  You poke between her legs with a [pc.finger], noting the flushed redness of the faerie's skin.  ");
	//Changes based on times fucked
	if(flags["COC.FAERIE_FUCKED_FEM"] == 1) output("She juices herself and screams, \"<i>Let me goooooooo,</i>\" trying to sound outraged instead of turned on, but the tiny girl's body gives away the lie.\n\n");
	else if(flags["COC.FAERIE_FUCKED_FEM"] <= 5) output("She juices herself and moans, \"<i>Stop teasing meeeeee,</i>\" doing her best to wriggle back against you, as if she could somehow impale herself on your digit.\n\n");
	else output("She squeals, rocking her hips back against you and moaning, \"<i>Ohhhh I love it when you do that,</i>\" grinding her incredibly small love-button on your digit.\n\n");
	//Special Taurness
	if(pc.isTaur()) {
		output("You bop the tiny Faerie on the head to daze her briefly, then place her on a branch. You back yourself up against the tiny creature, lifting your tail so she can see your [pc.vagina]. The scent washes toward her and you hear a high pitched giggle; evidently that was more than enough to give her quite the contact high.  You feel a strange sensation in your slit as she slides her legs inside you and wraps her arms around your [pc.clit].\n\n");
		
		//[If cock-like clit:
		if(pc.clitLength >= 3) {
			output("The tiny fae begins jerking your [pc.clit] like a cock, squeezing her arms tightly around you and sliding in and out of your [pc.vagina]. Her motions are frenetic and unpredictable, but incredibly pleasurable.  She starts licking at your [pc.clit] as your [pc.girlcum] runs down it, which only serves to make her more excited. She gets so excited that her legs start kicking wildly as she screams \"<i>Swim! Swim! Swim! Swim!</i>\" over and over again.  ");
			//[Small amount of cum:
			if(pc.vaginas[0].wetness() <= 3) output("The fae giggles more and more as the fluid seeps about her and your [pc.vagina] ripples. She hugs your [pc.clit] tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your clit, sprawling to the ground into a small puddle of [pc.girlcum].\n\n");
			//[Normal amount of cum:
			else if(pc.vaginas[0].wetness() <= 4) output("The fae giggles more and more as the [pc.girlcum] squirts about her and your [pc.vagina] ripples. She hugs your [pc.clit] tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your [pc.clit], sprawling to the ground into a puddle of [pc.girlcum].\n\n");
			//[Huge amount of cum:
			else output("The fae giggles more and more as the [pc.girlcum] sprays about her and your [pc.vagina] ripples. She hugs your [pc.clit] tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your [pc.clit], sprawling to the ground into a huge puddle of [pc.girlcum], her giggling frame floating on the surface as her legs kick about erratically.\n\n");
		}
		//[All other clits:
		else {
			output("The tiny fae rubs her hands around your [pc.clit] as if entranced by it. Your body responds by pumping out more femcum, which she laps up happily.  She starts laughing maniacally and banging on your [pc.clit] like a drum, periodically yelling out \"<i>CONGA!</i>\" for some reason. The strange ministrations feel incredible though, and you feel your love canal squeezing down on the faerie's tiny body.  ");
			//[Small amount of cum:
			if(pc.vaginas[0].wetness() <= 3) output("You cum suddenly, and wetly. The fae giggles more and more as the fluid seeps about her and your [pc.vagina] ripples. Her giggles quickly become all-out laughter, and she loses her grip on your innards, sprawling to the ground into a small puddle of [pc.girlcum].\n\n");
			//[Normal amount of cum:
			else if(pc.vaginas[0].wetness() <= 4) output("You cum suddenly, and wetly. The fae giggles more and more as the fluid squirts around her and your [pc.vagina] ripples. Her giggles quickly become all-out laughter, and she loses her grip on your innards, sprawling to the ground into a puddle of [pc.girlcum].\n\n", false);
			//[Huge amount of cum:
			else output("You cum suddenly, and wetly. The fae tries desperately to hold on to your [pc.clit] but the amount of fluid overwhelms her and she's sent spiralling to the ground into a huge puddle of your [pc.girlcum], her giggling frame floating on the surface as her legs kick about erratically.\n\n", false);		
		}
	}
	//Non-Taurs
	else {
		if(pc.isCrotchGarbed()) output("You release your [pc.lowerGarments], revealing your aroused slit to the faerie.  ");
		if(flags["COC.FAERIE_FUCKED_FEM"] < 4) output("Her mood immediately shifts from panic to desire, and she licks her lips hungrily, locking her eyes onto your feminine folds.");
		else output("Her eyes open wide, like a junkie seeing a fix.  She licks her lips hungrily and humps the inside of your [pc.hand], ready for action.");
		
		output("  You release the faerie, letting the pussy-entranced fae buzz down to your sensitive nether-regions.  She lands softly, her tiny feet and hands prancing over your [pc.vagina].  You gasp in delight, ");
		if(pc.vaginas[0].wetness() >= 4) output("releasing a tiny squirt");
		else if(pc.vaginas[0].wetness() >= 3) output("dribbling juices");
		else if(pc.vaginas[0].wetness() >= 2) output("growing so slippery the faerie nearly loses her footing");
		else output("feeling yourself moistening with need");
		output(" from the tiny touches.\n\n");
		
		//(small) <= .50\"  
		if(pc.clitLength <= .5) {
			output("She pulls apart your lips, revealing your tiny bud and repositioning herself to plant her feet inside you.  The flawless skin of her thighs pulls another gasp of pleasure from your lips.  They squeeze tightly around your [pc.clit], scissoring her gash across its sensitive surface.   You squirm, too engrossed in the rough grinding your [pc.clit] is receiving to worry about the faerie.   She clings to you, hanging on for dear life as your crotch nearly throws her free.  During the gyrations, she's slammed back into the [pc.clit], instantly penetrated by the nub with a wet 'schlick'.\n\n"); 
			output("Squealing and bouncing as she hangs on tightly, the faerie noisily orgasms around your clit, squirting her own fluids into your aching [pc.vagina].  The fluid tingles, and you shove your fingers in, smearing the sticky-sweet faerie-cum through your passage.   Before you can get far with it, your own orgasm goes off, squeezing your fingers and rippling around them, trying to milk your hand as if it was a dick.  Your legs go weak and wobbly, forcing you down on your [pc.butt] as the waves of pleasure flow through you, soaking the faerie in girlcum.\n\n"); 
		}
		//(medium) <= .1.25\"
		else if(pc.clitLength <= 1.25) {
			output("She watches, entranced as your [pc.clit] hardens, poking between your lips, flushed with blood like a tiny cock.   The faerie swivels around, planting her dainty butt squarely on your snatch, sinking down a bit into the folds as she wraps her legs around the pulsating 'shaft'.   She hugs it, pressing it between her tiny breasts and licking it up and down, making you moan and squirm from unexpected stimulation of your most sensitive area.\n\n");
			output("You spread your [pc.legs], careful not to dislodge the faerie as she releases the [pc.clit] and stands up, placing her dripping gash against the tip.   A quick plunge later and she's bottomed out, pressing her hips into the opening of your [pc.vagina] her feet slipping over the outer folds as she tries to maintain her balance.   You start rocking back and forth happily, bouncing the faerie up and down.  She moans, cute and barely audible, but sexy in a way that makes your sopping fuckhole even wetter.\n\n");
			output("She orgasms on you, squirting copiously, drenching your [pc.clit] and [pc.vagina] in clear faerie-fluid.  It tingles, wicking into your button and soaking into your snatch, enhancing every sensation.  You can feel the cool forest air as it flows over your vulva, seeming to stroke you, and without any chance of holding yourself back, you plunge your fingers into your [pc.vagina], immediately orgasming from the penetration, not even noticing the exhausted faerie sliding off the large clit and slipping partway into your cunt.\n\n");
		}
		//(streeeetch – large) <= 4.5\"
		else if(pc.clitLength <= 4.5) {
			output("Entranced by the growing [pc.clit], the faerie caresses her body, watching your love-button swell up, not stopping until it looks too huge for her tiny frame.  She climbs in a circle around it, awestruck by the size and majesty of your cock-like button.    She looks up at you, aroused but worried, saying, \"<i>You're so... BIG.  Oh goddess, I want to feel it inside me!</i>\"\n\n");
			output("She grabs hold of its slippery surface with both hands and jumps, lifting her lower body up before gravity yanks it back down onto the tip of your [pc.clit].  The tip barely slips in, despite the slippery wetness of the faerie.   She screams, though in pleasure or pain you cannot be sure.  You reason that it must be pleasure, because the faerie is wiggling her hips and grabbing hold of the rest of your [pc.clit], straining to pull herself further down the fem-cock.  Her belly starts to distort, displaying the cylindrical bulge on her tummy, expanding and contracting slightly as each of your heart-beats works through your clit.\n\n"); 
			output("In time, she manages to fully impale herself, quivering in orgasm as she gets off from the vibrations your pounding heart sends through your [pc.clit].  Her tongue lolls out and her eyes roll back, shut down by the extreme penetration, pain, and pleasure of the act.  You feel her cum soaking into you, sliding down into your slit and making your sensitive slit tingle.  Watching her get off is all it takes to bring you to orgasm with her, and the walls of your [pc.vagina] clamp down hungrily, contracting and gushing fluids over the faerie as she lies there, impaled on your crotch like a perverted ornament.\n\n");
		}
		//(too big) (else – hump dat shit)
		else {
			output("Entranced by your swollen [pc.clit], the faerie watches it slowly erect, filling with blood like a smooth over-sensitive cock.  She tentatively touches it, gasping and pulling back when it twitches in response.   With a look of awe, she turns to you and says, \"<i>There's no way I could take this beautiful monster, but I know I can make it feel good!</i>\"\n\n"); 
			output("She jumps onto it, making it bounce in the air as it takes her relatively insubstantial weight.  Embracing it in a full-body hug, she starts grinding on it, smearing her thick faerie juices into the clit and giggling every time you twitch from the feeling.  You squirm, sinking down from the raw sensation, your [pc.legs] giving out underneath you.   Grabbing hold of a stump, you try to steady yourself, but the faerie humping your [pc.clit] is interfering with your motor ability, and you slump into the forest loam, happily twitching as orgasm washes over you.\n\n");
			output("Your [pc.clit] jumps, throwing the tiny woman off.  She slips and scrabbles across the surface of your [pc.vagina], sliding into your soaking gash.  She's squeezed tightly, sloshed around in the wetness of your orgasm.   The faerie's eyes cross, as she grows dizzy and battered in the sizzling whirlpool that is your groin.\n\n");
		}
	}
	//[OH SHIT ITS OVER, POOR BITCH CRAWLS OUT ALL STONE ON GIRLCUM]
	//[FIRST TIME] 
	if(flags["COC.FAERIE_FUCKED_FEM"] == 1) {
		output("Lying in the forest loam as you recover, you watch as the faerie stumbles out of your groin, holding her head and giggling nonstop.  She tries to put on a serious face but it's instantly overpowered by another fit of laughter, \"<i>Hehe, did you know I'd get stoned off your [pc.girlcum]?  Omigod I've never been this -heheheheheh- high before!  Like I can see EVERYTHING.  Puuhleeeease don't make me do this again...</i>\"\n\n");
		output("She flies off, hungry and looking for a flower to munch on.");
	}
	//[REPEAT LOW]
	else if(flags["COC.FAERIE_FUCKED_FEM"] <= 5) {
		output("The faerie slowly drags herself out of your [pc.vagina], smiling broadly with her eyes dilated wide.  She slips off you, dropping to the ground and giggling, \"<i>Everything feels so soft.  Mmmm that was fun!</i>\"\n\n");
		output("The little woman spins around happily, proclaiming, \"<i>The colors are like, so bright!  Oh gosh, I'm hungry!  See you and your [pc.clit] later, just don't let me fall in your snatch, it fucks me up so much.  I don't think I can handle much more or I'll be crawling in every chance I get!</i>\"\n\n");
		output("She flits away, calling out, \"<i>Bye sweetie!</i>\"");
	}
	//[SLUTTIN IT UP] 
	else {
		output("The faerie stumbles out of your snatch, giggling and scooping the slippery [pc.girlcum] off her body, licking it up.  She crawls up your body to your lips, giving you a cunt-flavored kiss and babbling happily, \"<i>Mmm your cunt makes me so warm and giggly!  I'm so fucking stoned!  Gawddess, I'm hungry too – I'm gonna grab some food, and then come back for another dip in your honeypot, ok?</i>\"\n\n");
		output("She flits away, a little unsteady and reeking of female sex and desire.");
	}
	pc.orgasm();
	//dynStats("lib", -2, "cor", .5);
	pc.libido( -2);
	pc.cor(0.5);
	
	processTime(25 + rand(15));
	clearMenu();
	addButton(0, "Next", mainGameMenu);	
}

private function faerieShooAway():void {
	//spriteSelect(17);
	clearOutput();
	output("You shake your hands, shooing away the tiny faerie.  She's clearly been touched by the magics of this land and you want nothing to do with her. With a pouting look, she turns and buzzes away.");
	
	processTime(5 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function faerieDoNothing():void {
	//spriteSelect(17);
	clearOutput();
	if (pc.nippleLength() > 4.5 && (pc.clitLength > 4.5 || !pc.hasClit()))
	{
		output("The faerie flies close to your ear and speaks in a volume that would be a whisper from another human, \"You've got some sexy parts girl, but you're too big for me. I hope you find someone to get you off so I can watch.\" Then she flies in front of you, cutely kisses the bridge of your nose, and flies off.");
		pc.lust(5);
		
		processTime(10 + rand(5));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
		
	if (pc.nippleLength() >= 1 && pc.nippleLength() <= 4.5) {		
		output("She looks you over, stopping at your upper torso and letting out a cry of glee. She lands on your chest, her exposed pussy coming to rest on your nipple. With one hand she grabs hold of you above her head and uses her other hand to guide the rapidly hardening nub between her legs. She sighs in delight as her tight confines squeeze your [pc.nipple] hard, the feeling somewhere between pinching fingers and suckling lips. You gasp in delight yourself, and you notice she can exercise amazing control with her groin muscles as a rippling feeling courses through your [pc.nipple].\n\n");
		output("Your [pc.nipple] starts to get sloppy and wet as if someone's tongue were around it, but it's really the faerie's love juices dribbling down, some running down your breast and some down her legs. She starts thrusting against you, and you notice her clit getting hard and pushing into your soft flesh. With a free hand you grab the area around your [pc.nipple] and squeeze it harder, forcing more into her.\n\n");
		if(pc.isLactating()) output("A squirt of [pc.milkNoun] shoots inside her, making the faerie moan. She looks up at you with lusty, slitted eyes, squeezing her legs together to draw more from you.\n\n");
		output("Eventually you both find a rhythm and soon she's moaning loudly.  ");
		if(pc.hasVagina()) output("With your other hand you start diddling your [pc.vagina], adding your own soft moans to hers.  ");
		output("A few blissful moments later, she shudders and you feel her uncontrolled spasms around your [pc.nipple].  ");
		if (pc.hasVagina()) {
			output("You join her shortly after.  ");
			pc.orgasm();
		}
		output("The faerie goes limp and spirals to the ground, crashing gently and still twitching in the afterglow. Stepping back carefully, you leave her.");
		if(pc.isLactating()) output("\n\nA copious gout of your [pc.milkNoun] escapes her rosy folds.");
		
		//dynStats("lib", -2);
		pc.libido( -2);
		
		processTime(25 + rand(10));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	
	if (pc.clitLength >= 1.0 && pc.clitLength <= 4.5 && pc.hasVagina() && pc.hasClit() && rand(2) == 0) {
		output("A smile crosses her face and she flutters down to your crotch. She starts by scissoring you despite the size difference, driving your [pc.clit] into her despite its erect state. Compared to her, it looks massive. She swings one leg over it and starts impaling herself on it. Your taut [pc.clit] barely fits inside her, and the tight confines on your sensitive nub are enough to make you weak in the [pc.legs]. Staggering to the ground, you grab hold of her frail body in your fist and thrust her roughly on your engorged button. She wails in both pain and pleasure, being crushed and stretched open at once. Her cries of pain combined with the intense stimulation on your most sensitive part bring you to a quick orgasm.\n\n");
		if(pc.isSquirter()) output("You drench the poor faerie completely in your [pc.girlcum], soaking her hair and body. Overwhelmed and spent, you drop her to the ground and catch your breath. She licks up what's around her face, but is too weak to do anything else but lie in the dirt.\n\n");
		else output("Shuddering, you maintain your composure and keep going, trying to ride the high for another. Eventually you look down and you can see the faerie's eyes have glazed over and rolled to the back of her head. Her cunt has started clamping down on you a lot harder, evidence of her state of near-constant orgasm. The random clenching brings you off again very quickly and you have an intense orgasm, joining your fae cohort.\n\n");
		output("Time skips a beat and you eventually come down, gently relaxing your grip and disengaging the worn out faerie from your softening female parts. The faerie regains consciousness slowly and thanks you before flying off.");
		pc.orgasm();
		//dynStats("lib", -1);
		pc.libido( -1);
		
		processTime(25 + rand(10));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	
	output("The faerie flies close to your [pc.nipple] and sucks it gingerly.  You pant in pleasure as you feel it pucker tight in her mouth, tingling with her saliva.  She lets it pop free, swollen with arousal.  Her hand flicks it playfully, the sudden sensation fluttering through you as you close your eyes in pleasure.  You recover and find she has flown high into the trees, waving playfully as she escapes.\n\nYou frown and begin to dress yourself, flushing irritably as your [pc.nipples] protrude further into your clothes than you remember.");
	
	if(pc.nippleLength() > 3 || pc.biggestTitSize() < 2) {
		output("  Thankfully it appears to be temporary.");
	} else {
		var before:Number = pc.nippleLength();
		while(pc.nippleLength() < before + 0.2)
			pc.nippleLengthRatio += .1;
	}
	
	//dynStats("sen", 1, "lus", 5);
	pc.lust(5);
	
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[No] *(let her go)
private function letFaerieGo():void {
	//spriteSelect(17);
	clearOutput();
	output("You apologize and release her, letting her fly away on gossamer wings.  She thanks you, buzzing up to your lips and planting a chaste kiss on your mouth.  She zips away into the woods without a glance back...");
	
	processTime(5 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
//Disable Faerie encounter
private function disableFaerieEncounterForGood():void {
	//spriteSelect(17);
	clearOutput();
	output("You apologize and release her, letting her fly away on gossamer wings.  She thanks you, buzzing up to your lips and planting a chaste kiss on your mouth.  She zips away into the woods without a glance back...");
	output("\n\nYou make a mental note and resolve to never catch her again.");
	flags["COC.FAERIE_ENCOUNTER_DISABLED"] = 1;
	
	processTime(5 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[YES] *make her pleasure you
private function faerieCaptureHJ():void {
	//spriteSelect(17);
	flags["COC.FAERIE_FUCKED"]++;
	clearOutput();
	
	var smallCock:Number = pc.shortestCockIndex();
		
	if(flags["COC.FAERIE_FUCKED"] < 15) {
		output("You hold her tightly and scold her, \"<i>If you don't like hard cocks, you shouldn't be dressed up like a such a slut, flying around and teasing me like that.  You should be ashamed of yourself.  Now you've got me all worked up - so you better make it up to me and take care of my little 'problem'</i>.\"\n\n");
		output("She looks up at you and gulps before nodding silently, unwilling or unable to resist your command.   ");
	}
	
	output("You let her loose and she hovers in place, as if pondering her one last chance to escape.  She sighs and looks back up, blushing fiercely as she lands on your [pc.hip] and gazes down at ");
	if(pc.isCrotchGarbed()) output("the bulge of ");
	output("your [pc.cock " + smallCock + "].  You can't help but laugh as she ");
	if (pc.isCrotchGarbed()) output("slips under your [pc.lowerGarments]")
	else output("climbs onto you");
	output(", crawling across your sensitive thigh towards your [pc.cocksLight].\n\n");
	
	//Taurs get a special scene!
	if(pc.isTaur()) {
		output("The tiny Faerie climbs on top of your [pc.cock " + smallCock + "] and crawls about on it for a while, getting used to its shape and taking in deep lungfuls of its musky odor. She wraps herself around you and begins rubbing herself up and down your hard length. As she moves around her tiny slit leaks cum in long streaks, teasing you with a cunt you can't penetrate. Pre begins to leak steadily from your [pc.cockHead " + smallCock + "] as the faerie continues to work her way around, moaning quietly and betraying her inner desire.\n\n");
		output("Your body begins to naturally jerk forward and backward, attempting to hump the mare that isn't there. You can feel the faerie sliding about until she clenches onto you tighter, which only serves to make you hump harder. Realizing her mistake too late, she attempts to loosen herself, but your wild bucking sends her flying forward.\n\n");
		output("She smashes onto the end of your [pc.cock " + smallCock + "] and grasps at it. Her face crushes into your urethra as her tiny legs wrap themselves around the [pc.cockHead " + smallCock + "]. Your wildly flailing cock starts to grow larger as your orgasm approaches, but the faerie doesn't notice as she happily drinks up your pre.\n\n");
		
		if(pc.cumQ() < 10) output("Your tiny globules of [pc.cum] go straight into her open mouth and she sucks them down gleefully before falling with a splat onto the pre soaked ground.\n\n");
		//[Small amount of cum:
		if(pc.cumQ() < 50) output("Your [pc.cum] splashes straight into her face and she's quick to suck it up. She falls with a splat onto the pre soaked ground while your member drips periodic droplets of [pc.cum] onto her head.\n\n");
		//[Normal amount of cum:
		else if(pc.cumQ() < 200) output("Your [pc.cum] washes into her face and she loses her grip on your [pc.cockHead " + smallCock + "]. She falls with a splat onto the pre soaked ground and you spray her with periodic spurts of fresh [pc.cum].\n\n");
		//[Huge amount of cum:
		else output("Your [pc.cum] collides with her face and she is propelled off of your cock onto the pre soaked ground. Your [pc.balls] continue pumping out cum like a hose until she's almost swimming in it.\n\n");
		pc.orgasm();
	}
	//Non-taurs
	else {
		output("The faerie reaches your swollen [pc.cock " + smallCock + "] and ");
		if(pc.hasKnot(smallCock)) output("climbs atop your knot, wrapping her legs around the narrower shaft to hold on.  You can feel her cheeks resting atop the 'bulb' of your anatomy, teasing you with feminine features you're far too large to penetrate.  ");
		else if(pc.cocks[smallCock].cType == GLOBAL.TYPE_EQUINE) output("climbs atop your [pc.cock " + smallCock + "], hanging onto your ring of prepuce and wrapping her legs as far around your horse-like maleness as she can.  ");
		else if(pc.cocks[smallCock].cType == GLOBAL.TYPE_DEMONIC) output("climbs atop your [pc.cock], hanging on to the corrupted nubs and nodules as she threads her legs between them, squeezing you tightly as she hangs on.  You can feel her wet gash sitting atop a particularly sensitive bump, teasing you with a tiny cunt you'll never be able to penetrate.  ");
		else if(pc.cocks[smallCock].hasFlag(GLOBAL.FLAG_PREHENSILE)) output("climbs onto your squirming [pc.cock " + smallCock + "], wrapping her legs tightly around it as it wiggles and writhes with excitement.  Unbidden, it curls around and rubs its [pc.cockHead " + smallCock + "] against her face like an animal.  She gives it a gentle squeeze and licks it.  ");
		else output("climbs on to your hardness, wrapping her legs tightly around it as she secures a perch against you.   You can feel her wet gash rubbing against your sensitive skin, teasing you with a tiny cunt you'll never be able to penetrate.  ");
		
		output("Your internal muscles clench unconsciously, squeezing out a dollop of pre that rolls down into the faerie's hair, soaking her head and face.  You can't see her reaction, but you can feel it oozing between her body and you, lubricating her as she humps and rubs against you.  Tiny muffled moans escape ");
		if (pc.isCrotchGarbed()) output("your [pc.lowerGarments]")
		else output("her mouth");
		output(", indicating that some part of her is enjoying the task.\n\n");
		
		output("Though she can only stimulate a few inches of you at a time, it feels really good – better than it should, and a budding warmth on the edge of release builds inside you.  ");
		
		if (pc.isCrotchGarbed()) output("Too late you realize you should have gotten at least partially undressed.  You cum before you can do anything about it, splattering your [pc.gear] with seed and leaving a wet patch on the crotch.  You can feel it dripping back onto you and the faerie as more [pc.cum] squirts out, soaking the tiny girl in spooge as the wet spot grows.  ");
		else("Good thing your junk is exposed as otherwise you would have ended up jizzing in your pants. You cum, splattering the faerie with [pc.cum]. This continues until the tiny girl is soaked in spooge.  ");
		
		if(pc.cumQ() > 250) {
			output("You cum uncontrollably, ");
			if (pc.isCrotchGarbed()) output("regretting your virility as your body paints the inside of your [pc.lowerGarments] with goopy [pc.cumColor].  ");
			else("painting the ground with goopy whiteness.  ");			
			if(pc.cumQ() > 500) output("  The proof of your release forms a puddle around you as your legs give out and y");
			else output("  Falling backwards as your legs give out, y");
		}
		else output("Y");
		output("ou watch your wet groin squirm as the faerie finishes releasing your built-up tension and crawls out.  She's covered from head to toe in sloppy [pc.cumColor] [pc.cumNoun], and is noisily slurping it up.\n\n");
		pc.orgasm();
		output("She rolls off of you, staggers, and plops down on her cute little ass next to you");
		
		if(pc.cumQ() > 500) output(" in the cum puddle");
		output(", giggling drunkenly.\n\n");

		//if(pc.findStatusAffect(StatusAffects.Jizzpants) < 0 && pc.armor.name != "nothing" && pc.armor != armors.LTHCARM && pc.armor != armors.GOOARMR) pc.createStatusAffect(StatusAffects.Jizzpants,1,0,0,0);
		if (!pc.isCrotchGarbed() || pc.hasArmor() && pc.armor.shortName == "Goo Armor") {
			output("Fortunately, your jizz gets absorbed into the goo covering your body.\n\n");
			//getGame().valeria.feedValeria(pc.cumQ() / 10);
		}
	}
	
	//dynStats("lib", -.5);
	pc.libido( -0.5);
	
	//Epilogue!
	if(flags["COC.FAERIE_FUCKED"] < 10) output("The faerie burps and giggles again before glaring up at you, accusing you with a mildly unfocused glare and asking, \"<i>Did you know we get drunk on cum?  Caushe I TRY SO HARRD not to get meshed up like this.</i>\"\n\n");
	else if(flags["COC.FAERIE_FUCKED"] < 15) output("The faerie burps and laughs drunkenly, patting the side of your [pc.leg] and slurring, \"<i>Oh by Marae's ripe titsh!  I needed that.  Do you thhink you could catsch me again?  I love feeling your [pc.cum] coating my body.</i>\"\n\n", false);
	else output("The faerie burps and begins openly masturbating, panting and slurring happily, \"<i>Yush I-gasp-uh feel great!  MMMmmmhm, it makesh my twat so sensitive.  I'm gonna fly home and schtuff it full, then play with my clit till I fall ashleep!</i>\"\n\n");
	if(flags["COC.FAERIE_FUCKED"] < 15) output("She licks her fingers and rolls around laughing, \"<i>Hehe, who caresh!  I'm happy! WHEEEEE!</i>\"\n\n");
	output("The faerie takes off, still dripping, and flying in something less than a straight line...");
	
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}