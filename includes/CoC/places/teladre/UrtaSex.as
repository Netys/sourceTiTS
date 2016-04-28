import classes.Characters.CoC.CoCUrta;
import classes.Characters.PregnancyPlaceholder;
import classes.GLOBAL;
import classes.Items.Accessories.CoCUrtaCollar;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get urta():CoCUrta
{
	var _urta:CoCUrta = new CoCUrta();
	_urta.vaginas[0].bonusCapacity = flags["COC.TIMES_RUT_FUCKED_URTAS_CUNT"] == undefined ? 0 : Math.min(flags["COC.TIMES_RUT_FUCKED_URTAS_CUNT"] * 5, 40);
	if (flags["COC.URTA_TENTACLE_GAPED"] > 0) _urta.vaginas[0].bonusCapacity = 500;
	_urta.ass.bonusCapacity = _urta.vaginas[0].bonusCapacity; // that's how it works originally...
	return _urta;
}

//[Under Table BJ]
internal function blowUrtaUnderTable():void {
	urtaSprite();
	//pc.slimeFeed();
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	urtaLove(1);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(4));
	clearOutput();
	//output(images.showImage("urta-bar-bj"), false);
	output("Urta's eyes widen in shock when you suggest taking her under the table.  She stammers, \"<i>Uh, okay...</i>\" and fills a glass with straight whiskey, fueling up on liquid courage while you crawl down.  You slip down under the table, pushing her legs apart");
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output(" and pulling down her fishnet to release the monster trapped inside it.  It snaps up immediately, bobbing before your face as it fills with Urta's booze-fueled lust.");
	else output(" and pushing up her tight leather skirt, smiling at the sight of her trembling balls and juicy pussy.  Her tail unfurls around the equine member and it snaps up immediately, hanging before your face.");
	output("  It actually wiggles in time with the beating of her heart, bouncing up as it gets harder and harder, until it smacks your nose.\n\n");

	output("You hear the sound of her shot-glass slamming into the table with authority as she finishes her drink.  A bead of pre-cum bubbles out from Urta's urethra, signaling her readiness.  The horse-like penis gives off a salty scent, unique and not unpleasant.  Before you have a chance to change your mind, you lunge forward, opening your jaw as far as it will go and just barely taking her first few inches into your mouth.  The fox gasps out loud at the pleasure before she remembers to relax.  You can hear her pouring another drink, and in an effort to embarrass her, you begin sucking and licking around the edges of her flare, swallowing the surge of sweet-tasting pre-cum as it begins to fill your mouth.\n\n");

	output("Urta writhes in her seat, noisily spilling alcohol over the table.  You smile around the intruder in your mouth, gripping it with both hands and stroking it with tender caresses.  The gray fox slams down the bottle; though you can't tell if it's in irritation or due to difficulty controlling her muscles, and begins chugging down what she managed to get into her glass.  It seems Urta intends to drink until she doesn't care about any embarrassment you can force upon her.\n\n");

	output("Deciding you've got to get her off before she can drink herself into a stupor, you ");
	if(pc.slut() < 70) output("do your best to suppress your gag reflex and shove forwards, ramming her cock as deeply into your throat as you can.");
	else output("shove forwards, ramming her massive cock so far down your throat you can feel it dribbling pre-cum into your belly.");

	output("  Urta grunts, doing her best to muffle the noise as it escapes her lips, but you can feel her twitch and thicken inside you, beginning to drip with proof of her complete and total submission to your mouth.\n\n");

	output("You can hear chuckles from the bar's other occupants as they realize what's going on, and you blush, wishing there was a tablecloth to hide your activities from prying eyes.  The distraction does little to divert you from your chosen task, and you close your eyes, tasting your lover's throbbing shaft as it fills your mouth.  With both hands stroking, you bob up and down, completely centering your world around the pulsating horse-prick as it fills your mouth.\n\n");

	output("Without warning, Urta's legs wrap around your back, squeezing with her soft fur as she vices them closed.  You're forced to take her even more deeply, until the folds of her sheath are bumping your nose and chin and filling your nostrils with her heady musk.  You can't even breathe with such a massive intruder blocking your throat, but you do your best to get her off, knowing it's the quickest way to end it.  You suck hard and squeeze her balls, gurgling noisily around the sweaty shaft as you feel Urta give in.\n\n");

	output("A wave-like motion passes through your throat obstruction, stretching you wider than ever before.  It passes, leaving behind a feeling of warm fullness.  You feel another working its way into your mouth, and realize Urta is cumming, filling your belly with direct injections of horsey fox-seed. You desperately need to breathe, but you're trapped on your lover's maleness, and with nothing else to do, you give her twitching balls a squeeze, feeling her body twitch in response as she dumps a particularly heavy batch of spunk into you.  Happy that you could at least control how hard she came, you begin blacking out, barely noticing as Urta's orgasmic contractions die off.");
	
	output("\n\nThumping down on your back, you're blissfully aware of the sweet air filling your lungs.  In a moment of reflection, you realize you can taste the salty flavor of Urta's seed on your lips and mouth, and the retracting horse-cock is ");
	if(pc.biggestTitSize() >= 2) output("dragging between your [pc.fullChest]");
	else output("dragging across your chest");
	output(" as it begins to soften.  You wipe as much of her leavings from your [pc.face] as you can, licking the slippery glaze from your lips.  Before you get up, you make sure to give Urta's member a firm squeeze, punishment for forcing you to take her so deep.\n\n");

	output("Once you've climbed out from under the table, you're VERY aware of the eyes of some of the nearby bar patrons on your back.  It seems your undercover act managed to draw more than a little attention.  Urta's cheeks burn bright-red under her gray fur, even though her eyes are a bit glassy and unfocused from the amount of alcohol she's ingested.  Sure that she'll remember the embarrassment, you give her a deep kiss, making her taste her residue on your lips.");
	pc.exhibitionism(0.5);
	pc.loadInMouth(urta);
	pc.lust(rand(10) + 5 + pc.libido() / 10);
	processTime(15);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[Public Buttfucking]
internal function takeUrtaInTheButtPublically():void {
	urtaSprite();
	clearOutput();
	var tooBig:Boolean = false;
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	urtaLove(2);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 5;
	//output(images.showImage("urta-public-fuck"), false);
	if(pc.slut() < 66 && pc.exhibitionism() < 66) output("You can't believe you're doing it, but you undo the lower half of your [pc.gear].  ");
	else output("You happily remove the lower half of your [pc.gear], more than a little excited at the prospect of putting on a show for the crowd.  ");
	output("Urta casually flips up her skirt and ");
	if(flags["COC.TIMES_FUCKED_URTA"] < 11) output("unwinds her tail from around the beast");
	else output("fishes the beast out of her fishnets");
	output(".  Watching in horror, your eyes never leave the equine pillar as it grows to its full size.  Amazingly, none of the bar's patrons seem to notice the trembling horse-cock, even though it's beginning to leak with pre-cum.\n\n");

	output("You carefully shift your position, climbing in front of Urta.  With care, you grab the sensitive member just below the flare and begin rubbing it over your [pc.ass] and ready ass-hole, lubing yourself up and trying to relax.  The impatient fox grabs you by your [pc.hips] and pulls you down, forcing herself against your pucker.  ");
	//[GO TOO SMALL OR FITS, NO NEW PG]
	//[FITS]
	if(pc.analCapacity() >= urta.cockVolume()) {
		output("It's a tight fit, even with a backdoor as roomy as yours.  You're thankful for your capacity as you slide down into her lap, and Urta signals her appreciation of your capacity with a throaty sigh, \"<i>Mmmm, you're good at this.</i>\"\n\n");
	}
	//[DOESN'T FIT]
	else
	{
		tooBig = true;
		output("It's far too big for you, but that doesn't stop Urta from pushing it inside you.  You can feel yourself stretched around the invader, and it hurts enough that you almost scream out in pain, but inexorably, you're drawn down until your [pc.ass] is resting on Urta's thighs.  Her thick prick keeps you stretched uncomfortably wide, and you can feel every twitch it makes.");
		//(STRETCH TEXT HERE)
		if (!pc.buttChange(urta.cockVolume(), true)) output("  ");
		output("Surprisingly, the over-endowed fox notices your discomfort and hands you a narrow bottle from the table, \"<i>Drink up, it'll help with the pain until you get used to me.</i>\"\n\n");

		output("You look at the bottle suspiciously, reading the faded yellow label, \"<i>Barkardi 151</i>\".  Wincing from the pain, you suppose it couldn't hurt and you tip back the bottle, taking a hearty swig.  It burns like hellfire, and you nearly retch up the massive swallow before you get it down.  Amazingly, the pain in your throat and the bonfire in your belly nearly drowns out what's going on in your [pc.asshole].  You actually start to relax, and Urta nibbles on your ear in between sips of ale.  She holds her mug up to your lips and invites you to share her drink and you do, grateful for any additional pain-killers.\n\n");
	}
	//[BOTH]
	if(pc.hasCock()) {
		output("You start to grow hard from the pressure inside you, and there's nothing you can do to stop [pc.eachCock] from swelling to full erectness.  A bead of pre forms at [pc.eachCockHead], and begins leaking down the shaft");
		if(pc.totalCocks() > 1) output("s");
		output(" of your [pc.cocksLight], squeezed out from your prostate.  ");
	}
	
	if(pc.hasVagina()) {
		output("Heat spreads through your loins as your [pc.vagina] engorges with blood, allowing your [pc.clit] to ");
		if(pc.clitLength < 2) output("peep out");
		else output("grow to its full size");
		output(".  ");
		if(pc.vaginas[0].wetness() < 3) output("Moisture beads on your lips, signaling just how turned on this total violation is making you.");
		else if(pc.vaginas[0].wetness() < 4) output("Moisture begins dripping onto Urta's thighs, signaling just how turned on this total violation is making you.");
		else output("Moisture puddles on the seat under Urta as your juices flood her thighs, revealing just how turned on this violation is making you.");
		output("  ");
	}
	
	//(NIPPLES:
	output("Your [pc.nipples] ");
	if (!pc.isChestExposed()) output("tent up under your [pc.upperGarmentOuter]");
	else output("engorge");
	if(pc.hasFuckableNipples() && pc.isLactating()) output(", leaking milky lubricants and aching to be penetrated.");
	else if(pc.hasFuckableNipples()) output(", aching to be penetrated.");
	else if(pc.isLactating()) output(", leaking thin streams of milk that rapidly become visible to everyone around you.");
	else output(".");
	output("\n\n");

	output("Soft-furred hands grip your [pc.hips] firmly and begin to lift you up, making you gasp as her flare is dragged through your hind-end, eliciting what Urta must think are cute gasps.  You hear a 'murrrr' of contentment in your ear and Urta releases you, twitching inside you as your weight slowly carries you back down into her lap.  Once your [pc.ass] smacks into her thighs she grabs you again, dragging you back up her massive pole until you're looking down on the tables around you.  She stops and withdraws her support, guiding you back down her shaft and moaning when you take her ring of prepuce half-way down.\n\n");

	output("The eyes of everyone in the place are locked onto you, and ");

	if(tooBig) output("you find yourself giggling drunkenly, barely feeling any pain and arching your back like a slut for the crowd.");
	else if(pc.slut() < 50  && pc.exhibitionism() < 50) output("you find yourself whimpering, regretting the decision to climb on top of her, but aroused in spite of it.");
	else {
		output("you find yourself sliding your hands");
		if (!pc.isChestExposed()) output(" under your [pc.upperGarmentOuter] and pinching");
		else output(" to pinch");
		output(" your [pc.nipples], putting on a show for the crowd.");
	}

	output("  Urta starts breathing hard into your [pc.ear], and you start flexing your [pc.legs] to help her lift you up.  Grateful for the effort, the fox-girl increases the pace by helping to pull you back down each time.  By now it's starting to feel pretty good, and her pre-cum is making your [pc.asshole] so wet and slippery that you can slide quite quickly along the column of horse-meat.\n\n");

	output("Wet squelches echo through the bar as you're slammed into Urta's lap harder and harder.");
	if(pc.biggestTitSize() >= 1) {
		output("  Your [pc.fullChest] are jiggling and bouncing wildly");
		if(pc.hasFuckableNipples()) output(", dripping lubricants");
		else if(pc.isLactating()) output(", spurting [pc.milk]");
		else if (!pc.isChestExposed()) output(", rubbing your tight nipples against your [pc.upperGarment]");
		output(".");
	}
	
	if(pc.cockTotal() > 0) output("  Steady drizzles of [pc.cum] begin dripping from [pc.eachCock] as she pounds away, rubbing hard against your prostate.");
	
	output("  You can't hold back, and start moaning quietly, trying your best to be silent and failing horribly.  For her part, your foxy lover seems equally incapable of suppressing her orgasm, and you feel her thick organ flexing inside you as it prepares to cum.\n\n");

	output("Her paws pull you down hard, crushing your [pc.ass] against her as her sheath presses into your [pc.asshole].  The invading flesh ripples from the base towards the tip, culminating in a flood of warmth that makes your belly gurgle, and at that moment you cum.  Your sphincter clamps down tightly around Urta's marvelous member, unintentionally providing the fox with an even better orgasm.  The next pulse of cum feels even larger, and you look down in shock when you realize you can see the outline of her shaft on the [pc.skinFurScales] of your belly.  As she cums you can see it getting less distinct as your body becomes more and more rounded.  A few blasts later you look positively pudgy, but you can feel her softening inside you.\n\n");

	output("Urta sighs and takes a sip of her drink, giving you a quick peck on the side of your neck.  You start to rise, but the drunken hermaphrodite grabs you and holds you down, \"<i>Let's just stay like this a little longer...</i>\"\n\n");

	output("You shrug and relax, cuddling with her while her massive load is plugged inside you.  She keeps you there for the better part of an hour, kissing you, nipping at your neck, and sharing her drinks with you.  When you finally do get a chance to leave, you're stumbling slightly from the alcohol and your asshole gapes and drips whiteness behind you.  You don't notice the trail of cum until you get back to your camp, and it brings a blush to your cheeks.");
	processTime(40);
	pc.exhibitionism(1);
	pc.orgasm();
	pc.loadInAss(urta);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[PUBLIC FACIAL]
internal function getAPublicFacialFromUrta():void {
	urtaSprite();
	//pc.slimeFeed();
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	urtaLove(2);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (3 + rand(3));
	clearOutput();
	//output(images.showImage("urta-public-facial"), false);
	output("Given the choices, it seems like just accepting the facial would be the best option.  Urta nods, grinning lasciviously as she pulls the table to the side, and gestures for you to get on the floor.  You kneel before her as she pulls back her ");
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 11) output("skirt ");
	else output("stockings ");
	output("and allows her horse-dick to flop free in front of you.  It pulses, growing bigger with each beat of the fox's heart as she watches you submit yourself to her arousal.  You feel the eyes of everyone around you as they watch the spectacle ");
	if(pc.slut() < 33 && pc.exhibitionism() < 33) output("and it makes you blush crimson");
	else if(pc.slut() < 66 && pc.exhibitionism() < 66) output("and it makes you uncomfortable but horny");
	else output("and it makes you randy as hell");
	output(".\n\n");

	output("Two dexterous fur-covered hands wrap around her mottled shaft and begin pumping it.  Almost immediately the flattened-tip begins flaring wide and produces a dollop of fragrant equine pre-cum.  Urta's balls quiver happily as she plays with herself, and as you look up at her and open wide, ");
	if(pc.slut() < 50 && pc.exhibitionism() < 50) output("doing your best to play your part in the scene.");
	else output("hoping to encourage her to absolutely soak you with cum.");
	output("\n\nUrta looks down with a surprisingly shy expression and asks, \"<i>Could you... lick the tip please?  For me?</i>\"\n\n");

	if(pc.slut() < 50 && pc.exhibitionism() < 50) output("Hesitantly, you extend your [pc.tongue] and lick the underside of her flat-tip.  ");
	else output("Eagerly, you lick around the outside edge of her flared tip, sticking your [pc.tongue] out as far as you can to lick the underside once you finish.  ");
	output("Your efforts are rewarded when Urta groans and spurts a dollop of pre-cum onto your tongue, and you can see her urethra twitching and pulsating as more of the clear fluid begins to leak out.  It drips down onto your tongue as the fox picks up her pace, feverishly masturbating her bloated shaft.  She says, \"<i>Swallow that pre and get ready slut, you'll need an empty mouth to hold all this.</i>\"\n\n");

	output("You swallow, tasting the sweet pre-cum as it slides down your throat.  Risking a glance to the side, you realize there's a crowd gathering around you, and more than a few dog-dicks and horse-cocks are being stroked.  ");
	if(pc.slut() < 50 && pc.exhibitionism() < 50) output("You shudder in shame, and hope that the crowd will disperse. It's humiliating enough waiting to have Urta soak you with cum.");
	else  output("You hope the show will be arousing enough to get them off on you as well, and with renewed determination you turn back to Urta and give her balls a squeeze.");
	output("  She trembles and her tip flares wide, and you know she's starting to cum.\n\n");

	output("Her urethra dilates before your eyes and time seems to slow down as the first blob of horse-semen is launched towards you.  Blinking at the last second, you feel it splatter over your [pc.face].  You open your mouth wider, keeping your eyes closed but knowing you're expected to swallow some of it.  Urta's aim improves with the next blast, and it does land in your mouth.  You nearly gag from the sudden salty intrusion, and due to the volume of the seed a fair portion of it leaks out the sides of your mouth as you keep it open, expecting more.  You feel more cum land in your hair, then on your cheek, and finally on your neck and ");
	if(pc.biggestTitSize() < 1) output("chest.  ");
	else output("cleavage.  ");
	output("Urta paints you with the stuff, until you're practically oozing cum.  It does eventually stop, and you wipe the jism from your eyes");
	if(pc.slut() > 60) output(", being sure to lick your fingers clean afterwards");
	output(".\n\n");
	pc.loadInMouth(urta);

	if(pc.slut() >= 50 || pc.exhibitionism() >= 50) {
		output("You could probably get the crowd to cover the rest of you.  Do you?");
		processTime(25);
		clearMenu();
		addButton(0, "Yes", optionalUrtaBukkake);
		addButton(1, "No", declineUrtaBukkake);
		return;
	}
	else {
		output("You blush and try to clean yourself up.  An embarrassed barmaid forces her way through the crowd to give you a towel, and starts shooing away the assembled masturbators.  You thank her and towel off Urta's thick seed, being more than a little aroused by the scene you caused.  The fox-girl is leaning back looking VERY satisfied as she ");
		if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("stuffs herself back into her fishnet");
		else output("curls her tail back around her member, concealing it from view");
		output(".");
		pc.lust(5 + rand(5) + pc.libido() / 10);
	}
	processTime(30);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function optionalUrtaBukkake():void {
	urtaSprite();
	//pc.slimeFeed();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp;
	urtaLove(-1);
	clearOutput();
	//output(images.showImage("urta-bukkake"), false);
	output("You");
	if (!pc.isNude()) output(" pause to tear off your [pc.gear] and expose the rest of your body, and you");
	output(" reach out into the crowd, grabbing the nearest cock and caressing it as you beg, \"<i>Come on and cum, she missed most of me!</i>\"\n\n");
	output("Urta leans back with a smile, toying with her softening member as a ring of horny studs and herms encircles you, jerking themselves off furiously.  You take turns touching and caressing them, murmuring enticing words as they start cumming on you, one or two at a time.  As those that finish step away, they're replaced by newcomers, turned on by the cum-hungry slut in front of them.  You do your best to greet them with a wink, a stroke, and a slurp, and then you present your ");
	if(pc.biggestTitSize() >= 1) output("[pc.fullChest]");
	else output("[pc.nipples]");
	output(" to a horny wolf just in time to take his hot load on your chest.\n\n");
	pc.lust(15 + rand(5) + pc.libido() / 10);
	output("An hour later you're totally drenched in cum.  It's dripping off you from your [pc.hair] down to your [pc.feet], and you love it.  You lick up the mixed spooge until you start to feel full, and a blushing barmaid comes forward to hand you a towel.  You give her a salty kiss on the lips, sending her running away before you towel off and dress yourself.");
	processTime(30);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function declineUrtaBukkake():void {
	urtaSprite();
	clearOutput();
	output("You blush and try to clean yourself up.  An embarrassed barmaid forces her way through the crowd to give you a towel, and starts shooing away the assembled masturbators.  You thank her and towel off Urta's potent seed, being more than a little aroused by the scene you caused.  The fox-girl is leaning back looking VERY satisfied as she ");
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("stuffs herself back into her fishnet");
	else output("curls her tail back around her member, concealing it from view");
	output(".");
	pc.lust(5 + rand(5) + pc.libido() / 10);
	processTime(5);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[TAKE HER HOME FOR TENDER LUVINZ]
internal function goBackToUrtasForLuvinz():void {
	urtaSprite();
	clearOutput();
	//output(images.showImage("urta-home-image"), false);
	if(flags["COC.URTA_PC_LOVE_COUNTER"] > 0) {
		output("Urta gives you a warm smile and grabs you by the hand, pulling you out the Wet Bitch's backdoor and into Tel'Adre's back-alleys.  Her dress does little to conceal the bulging mass underneath or the growing wet spot that forms at the tip of her impressive tent.  The long, body-hugging garment makes it difficult for Urta to walk in her current state, and you don't make it any easier for her, constantly teasing the fox as you navigate the back-alleys of Tel'Adre.\n\n");

		output("Every chance you get, you brush a hand or a hip against her sensitive nether-bulge or lust-tightened nipples.  For someone with such a bad-ass reputation, Urta's quite easy to tease, and she makes adorable gasps and shuddering shakes every time you brush against her flare or surprise her with a tender caress.  She lets out cute whimpers as she shuffles onward, but she doesn't protest as her 'male' half drenches her dress with more and more slimy pre-cum.\n\n");
		output("The door to her apartment looms before you and you push her inside.  You do your best to stifle an involuntary snicker as you close the door and see a trail of Urta's moist arousal on the street right up to the door.  The apartment is impeccably clean, though you see a few large sex-toys half-hidden about the place.  For someone as ashamed of her desires as Urta was, she sure is terrible at hiding her kinks.");
		if(flags["COC.URTA_PETPLAY_DONE"] == undefined && flags["COC.URTA_COLLAR_TAKEN"] == undefined && urtaLove()) output("  <b>A new, shiny leather collar lies half-concealed under a cushion, as though its owner haphazardly tried to bury it in a rush.</b>");
		output("  The busty fox has already retreated from the front-room, the half-soaked dress on the floor the only indication she was there with you a moment ago.\n\n");
		output("You follow a trail of pre-cum on the floor and the scent of copious female arousal deeper into the apartment, around a corner, and into Urta's relatively small bedroom.  Your vulpine lover is reclined on her bed, wearing nothing but lacy stockings and a latex cock-sheath.  ");
		if (pc.hasCock()) output("In her hand is another sheath, ready to gird your own equipment in a fashion similar to her own.  ");
		processTime(10);
		clearMenu();
		addButton(0, "Next", urtaHomeLuvLuvinsMenu);
		return;
	}
	output("Urta smiles broadly and gives you a grateful peck on the cheek.  She makes like she's going to rise, then stirs uncomfortably, her eyes flashing down towards her crotch.  The fox settles back down and asks, \"<i>Would you mind paying off my tab while I slip out of here?  You've gotten me a bit too exposed to stand around trying to pay,</i>\" as she fishes out a coin-purse.  Tossing a few gems and odd coins your way, your over-endowed lover gives you a longer kiss before pushing you away from the table.\n\n");

	output("Walking a little strangely, you make your way to a waitress and pay off Urta's tab, feeling a bit flushed from the kiss and the action you're expecting later on.  Once done with the onerous task, you turn and realize Urta has vanished, though the backdoor to the bar is swinging once again.  You head out after her, stumbling directly into her exposed member as you step out into the alley.  Urta blushes fiercely and shivers, stammering, \"<i>It hurt too much to keep it penned up.  I'm sorry.</i>\"\n\n");

	output("You assure her that you aren't offended");
	if(pc.slut() >= 50 || pc.exhibitionism() >= 50) output(" and are actually turned on by the thought of walking through the city with such a 'big' lover hanging off your arm");
	output(".  Urta smiles weakly and hooks her arm through yours, leading you towards her apartment, making sure to stick to the more abandoned back-roads.  Her caution doesn't stop the pair of you from giving a few free shows, and if anything, each brief encounter with a passerby seems to be making her bigger and harder, revealing a half-buried exhibitionist streak.\n\n");
	goBackToUrtasForLuvinzII();
}

internal function goBackToUrtasForLuvinzII():void {
	clearOutput();
	output("The journey is blessedly brief, and within minutes you arrive at Urta's house.  She fiddles with the lock anxiously for a moment before finally getting a -CLICK- and unlocking it.  You sweep inside behind your host and look around, mildly shocked at the spartan surroundings.  Urta's apartment is tiny, cramped, and nearly devoid of possessions beyond weapons, armor, and sex-toys.");
	if(Flag("COC.PC_SEEN_URTA_SEX_TOYS") == 0) {
		output("  The last group is the most numerous of those three.");
		if(flags["COC.GIACOMO_MET"] > 0) output("  You recognize some of the toys as Giacomo's wares, though there are a fair number that seem to be custom made, and others that are clearly living creatures.");
		output("  Looking over the things she had to use before she met you, it dawns on you just how lonely the poor fox has been.");
	}
	else output("  While the last group used to be the most numerous, it looks like Urta has cleaned house and only has a few of the toys left.  It seems that since meeting you she hasn't had to turn to her massive device collection like she used to.  It dawns on you just what a difference you've made in Urta's life, and it brings a loving smile to your [pc.face].");
	output("\n\n");

	output("\"<i>Sexy, are you going to come get some?</i>\" Urta calls out from the bedroom in the back.  You slap your forehead, angry for getting so distracted while a hot piece of ass is on the line.  Heading deeper into the apartment after her, you turn the corner to her bedroom and are floored by the sight.  Urta is totally nude save for a pair of black fishnet stockings and some kind of shining latex cock-sheath.  She's on all fours on top of a fur-lined bed, and wiggling her hind-end at you with her tail lifted in the air.  The scent of need pours off from her sex, and you find yourself as ");
	if(pc.hasVagina() && pc.hasCock()) output("hard and wet as you've ever been");
	else if(pc.hasCock()) output("hard as you've ever been");
	else if(pc.hasVagina()) output("wet as you've ever been");
	else output("ready as you've ever been to take such a monster");
	output(".\n\n");

	output("Urta is clearly looking to take a more passive role, and she begins stroking herself as she asks, \"<i>How do you want to fuck, lover?</i>\"");
	//[M: VAGINAL] [F: RIDE] [GENDERLESS/M: RIDE ANAL]
	processTime(10);
	clearMenu();
	addDisabledButton(0, "Fuck Vagina", "Fuck Vagina", "This scene requires you to have fitting cock.");
	addDisabledButton(1, "Vaginal Ride", "Vaginal Ride", "This scene requires you to have vagina.");
	if (pc.cockThatFits(urta.vaginalCapacity()) != -1) addButton(0, "Fuck Vagina", dudeFuckingUrtasCooch);
	if (pc.hasVagina()) addButton(1, "Vaginal Ride", rideUrtaTenderFemale);
	addButton(2, "Anal Ride", tenderTakeItUpTheAssFromUrta);
	addButton(3, "No Condoms", condomlessUrtaInHouseSmex);
	if (pc.isGoo() && pc.skinType == GLOBAL.SKIN_TYPE_GOO) addButton(4, "Goo (Weird)", urtaGooTesticleVoreRuinedOrgasms);
}

private function rideUrtaTenderFemale():void {
	urtaSprite();
	IncrementFlag("COC.PC_SEEN_URTA_SEX_TOYS");
	urtaLove(1.5);
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (3 + rand(2));
	clearOutput();
	//output(images.showImage("urta-home-female-ride"), false);
	output("You climb into bed and playfully roll Urta over.  Her tits and horse-cock flop and jiggle from the change in position, and you watch mesmerized for a moment until Urta giggles girlishly, drawing you out of your reverie.\n\n");

	output("\"<i>Do you like them that much?</i>\" she asks.\n\n");

	output("You nod ");
	if(pc.slut() < 50) output("sheepishly ");
	else output("eagerly ");
	output("and grab ahold of her latex-wrapped member, giving it gentle strokes along the underside.  Urta moans loudly and twitches her hips, already eager for more, and the ");
	if(pc.vaginas[0].wetness() < 3) output("growing moistness in your loins");
	else if(pc.vaginas[0].wetness() < 4) output("sopping wetness in your loins");
	else output("flood of moisture leaking from your crotch");
	output(" signals your readiness to take her.");
	if(pc.hasCock()) output("  [pc.EachCock] is raging hard and trembling, but ignored for now.");
	output("  Climbing atop the bed with her, you swivel your [pc.hips] about, positioning her at your entrance and straddling your [pc.legs] around her.\n\n");

	output("You can see a bubble already forming at the tip of her hardness, signaling the unbridled lust your form has brought to your lover and you lower yourself with a sigh, feeling it spread your lips apart with delicious slowness as her flared tip begins penetrating you.  The horse-cock is so big and thick that it ");
	if(pc.vaginalCapacity() < urta.cockVolume()) {
		output("hurts quite a bit as it pushes further and further inside.  ");
	}
	else {
		output("stretches you nice and wide, rubbing you tightly even though you're quite stretched already.  ");
	}
	pc.cuntChange(0, urta.cockVolume(), true);
	output("You gasp and sigh happily, sinking downwards slowly.\n\n");

	output("The ring of prepuce passes past your entrance ");
	if(pc.vaginalCapacity() < urta.cockVolume()) output("and you bottom out there, unable to take in any more of her equine shaft.");
	else output("and you keep going, sliding down along the marvelous member until your cunt-lips are rubbing her sheath against your [pc.clit].");
	output("\n\n");

	output("Urta growls and grabs you by the back of the neck, pulling your " + pc.face() + " down for a sloppy kiss.  Her smooth canine-like tongue forces its way into your mouth and curls around yours as the two of you swap spit.  Your hips, spurred on by the passion, begin to rise and fall to the tempo of the kiss, and in seconds you're both gasping and moaning against each other's lips, lost in the throes of passion.  Deep inside you, you can feel the condom filling with Urta's incredibly copious pre-cum, but every time your hips drop down the pressure squeezes some of it down along her length until it escapes around the condom's edge, dripping into her sheath.\n\n");

	//(Big Tits:
	if(pc.biggestTitSize() >= 5) {
		output("Your [pc.breasts] mash into the fox's own, your [pc.nipples] ");
		if(!pc.hasFuckableNipples()) output("rubbing over her black-skinned buds.");
		else output("parting as her prominent black nipples slip inside your own.");
		output("  You squeal at the sudden pleasure, arching your back and furthering the sensation from your over-burdened chest.");
		if(pc.hasCock()) {
			if(pc.cocks[0].cLength() > 15) {
				if(pc.totalCocks() == 1) output("  [pc.EachCock] pushes up between the jiggling breasts, slicking them with your pre-cum as it begins to get tit-fucked by both of your trembling forms.");
				else output("  [pc.EachCock] pushes up between the jiggling breasts, slicking them with your pre-cum as they begin to get tit-fucked by both of your trembling forms.");
			}
		}
		output("\n\n");
	}

	output("You both cry out in orgiastic pleasure as your shaking [pc.hips] force your tightly-stretched cunt over Urta's rubber-wrapped horse-prick again and again.  Your internal muscles spasm, clamping down tightly in sudden orgasm.  Urta's voice trembles in a low moan of satisfaction while her lower body twitches upwards with hard pumping motions.  Her dick trembles inside you, and you feel the latex around her girthy prick inflating with her seed and pressing against your cervix.\n\n");
	if(pc.hasCock()) {
		if(pc.cockTotal() == 1) {
			output("Your own [pc.cocksLight] cums as well, blasting seed over both your ");
			if(pc.cocks[0].cLength() > 15 && pc.biggestTitSize() >= 5) output("jiggling tits");
			else output("bellies");
			output(", glazing them in slippery goo.");
		}
		else {
			output("Each of your own [pc.cocksLight] cums as well, blasting seed over both your ");
			if(pc.cocks[0].cLength() > 15 && pc.biggestTitSize() >= 5) output("jiggling tits");
			else output("bellies");
			output(", glazing them in slippery goo.");
		}
		output("\n\n");
	}

	output("Lying down on top of her, the two of you cuddle while joined at the hips, snuggling happily");
	if(pc.hasCock()) {
		output(" and ignoring the hot, wet mess your [pc.cocksLight] ");
		if(pc.totalCocks() == 1) output("has");
		else output("have");
		output(" left between your nude bodies");
	}
	output(".  The fox-girl gives you a long, happy kiss and holds you tightly in her arms before she lets you go and begins to pull out.  The loud -SCHLLLIIIICK- of her fat member being dragged through your nethers makes you blush, and the feeling of it robs you of any strength below the waist.  The latex stretches, the cum-bubble still trapped inside you and stretching the condom obscenely for a moment, until it jerks out with a sudden 'pop'.  The relief is palpable, but your [pc.vagina] hangs open, with lips parted loosely after today's incredible violation.\n\n");

	output("Urta sighs and languidly pulls off her condom, nearly getting cum everywhere before she ties it off.  It looks like it'll pop at any moment – there's probably over a liter of cum stored in it.  She hefts it and mocks like she's going to throw it at you, but stops and giggles before setting it down beside the bed.  Your foxy lover says, ");
	if(flags["COC.TIMES_FUCKED_URTA"] <= 10 || flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 11)
		output("\"<i>Lovemaking is so much of a hassle to clean up if I don't use one of these!  At least I don't have to use them for the same reason as most of Tel'Adre.  It turns out I'm sterile or damn close to it, so all that fun-juice is just for show.</i>\"");
	else output("</i>\"<i>You're so good to me [pc.name].  I wish my little pony here was fertile enough for me to put a bun in your oven, if you wanted of course.</i>\"");
	output("\n\nShe blushes as if realizing what she's said and turns to start cleaning up.  You give the nervous fox a hug and squeeze her breasts mischievously before breaking it.  She smiles over her shoulder at you and says, \"<i>Thanks again.  You better get going though, I know you've got things that need doing.  Come by the Wet Bitch again soon and see me, OK?</i>\"\n\n");
	output("You nod before you leave, feeling satisfied and a warm glow from something other than lust.");
	//if(flags["COC.URTA_FERTILE"] == 1) pc.knockUp(21,515,80);
	processTime(35 + rand(20));
	pc.loadInCunt(urta);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[FUCK HER VAGINA]
private function dudeFuckingUrtasCooch():void {
	urtaSprite();
	clearOutput();
	//output(images.showImage("urta-home-male-fuck"), false);
	var cocks:Number = pc.totalCocks();
	var x:Number = pc.cockThatFits(urta.vaginalCapacity());
	var y:Number = pc.cockThatFits2(urta.analCapacity());
	IncrementFlag("COC.PC_SEEN_URTA_SEX_TOYS");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	urtaLove(1.5);
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 1) flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = 1;
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 2;

	output("You let her know that you want her just the way she is and climb into bed behind her.  She watches you apprehensively over her shoulder as you pull out [pc.cock " + x + "] and start lining yourself up to fuck her doggie-style.  ");
	if(cocks > 1 && y >= 0) output("Your secondary [pc.cock " + y + "] wobbles directly behind her back-door and Urta's eyes widen a bit when she realizes you're going to double-penetrate her.  ");
	if(cocks > 2) output("The remainder of [pc.eachCock] fan out, ready to rub themselves against her butt-cheeks once you push inside.  ");
	output("You can see your lover's condom starting to bloat at the tip as her horse-cock begins to flare within its confinement.  She trembles with anticipation before taking a deep breath and saying, \"<i>I'm ready... take me!</i>\"\n\n");

	output("Obligingly, you ease your hips forward, reeling at the heat of her cunt-lips as they welcome your [pc.cockHead " + x + "] with slippery moisture.  ");
	if(cocks > 1 && y >= 0) output("Your second [pc.cockNoun " + y + "] soon bumps against her pucker and strains against it, pushing ever-so-slowly into her tight hole as she gradually relaxes before you.  ");
	output("As you carefully breach the opening");
	if(cocks > 1 && y >= 0) output("s");
	output(", the going gets easier and easier for you.  You gently rock your [pc.hips] forwards, sliding deep inside her until she's taken you to the hilt.  Once you're fully embedded within her, Urta wriggles happily beneath you, and you reach around to caress her drooping member, relishing in her pleasured yelps and moans.\n\n");

	output("You rock back and forth, picking up the tempo gradually.  At first the gray fox is only gasping happily, but as you go faster and faster, her gasps turn into quiet moans, then transform into ecstatic squeals.  ");
	if(pc.balls > 0) output("Your balls loudly smack into her squelching-wet cunt and the soaked backside of HER balls");
	else output("Your crotch slaps loudly against her squelching-wet cunt and backside");
	output(" as you fuck her hard and fast.  Urta's cock twitches in your hand, and the pre-filled bubble hanging from her cock-tip is getting close to apple-sized.  Both of you are rutting like animals and riding on the edge of an orgasm.  Then, Urta throws her head up, arches her back, and starts howling like a well ridden bitch in heat.  Now that she's moving with you, her magnificent horse-cock fully engorges inside your grasping hand, and you slide it between your grasping fingers, masturbating her even while fucking her.\n\n");

	output("Urta cums first.  Her cries of pleasure are muffled as she shoves her face into a pillow, screaming in ecstasy.  The warmth around your [pc.cock " + x + "] seems to grow that much hotter as it squeezes you, wringing you tightly from root to tip.  ");
	if(cocks > 1 && y >= 0) output("The intensity and pressure in her back-door is even worse, and your [pc.cock " + y + "] is nearly in pain from her asshole's tight, pulsating grip.  ");
	output("Her equine member trembles in your grasp as it releases its sticky payload into the thick, latex condom.  You pump away at her shaft, feeling the spunk inside distort the tube-like appendage until your orgasm shocks you into releasing it.\n\n");

	output("You spurt into Urta's sloppy box, creaming it until her juices begin to run in an off-[pc.cumColor] color.  ");
	if(cocks > 1 && y >= 0) output("The [pc.cockNoun " + y + "] you've crammed in her ass does not disappoint either, matching its brother squirt for squirt as it spends your seed with reckless abandon.  ");
	if(cocks > 2) output("Her butt and tail are covered with the stuff as each of your remaining [pc.cocksLight] splatters her with spooge, covering her fur in [pc.cumColor] sludge.  ");
	output("The fox's internal muscles happily continue to squeeze and milk you, prolonging your orgasm beyond its normal duration.");
	if(pc.cumQ() >= 750) output("  Her body is quickly bloated thanks to your body's incredible fertility, but she seems able to take it just fine.");
	output("\n\n");

	output("The two of you collapse together in a shuddering pile of post-orgasmic bliss.  The shift in position frees your [pc.cocksLight] from Urta with a noisy -SHHHLLUUUCK-, but you're too wiped out to care.  The fox-girl sighs happily and rolls over, planting a kiss on your nose before she works at removing her over-filled condom.  It nearly bursts when she ties it off, but she manages to gently set it down to the floor without incident. She looks at you happily and gives you a big hug, crushing her hard nipples against ");
	if(pc.biggestTitSize() >= 1) output("your own [pc.breasts]");
	else output("your chest");
	output(" as she says, \"<i>Thank you so much, lover.  I forget how good it can be in my... vagina.  Maybe we could do this again?</i>\"\n\n");

	output("You give her a happy nod, and the two of you cuddle a bit longer before you leave to return to camp.");
	knockUpUrtaChance();
	urta.loadInCunt(pc);
	if (y >= 0) urta.loadInAss(pc);
	processTime(35+rand(20));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[RIDE HER COWBOY/NEUTER]
private function tenderTakeItUpTheAssFromUrta():void {
	urtaSprite();
	clearOutput();
	IncrementFlag("COC.PC_SEEN_URTA_SEX_TOYS");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	urtaLove(1);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(3));
	var cocks:Number = pc.totalCocks();
	//output(images.showImage("urta-home-anal"), false);
	output("You give Urta's backside a playful slap and ask her to roll over.  She does so with a hesitant look on her face, wondering what you're about.  When you spread her legs and work your way forward to straddle her, a beaming smile breaks across her face and she says, \"<i>You really want me inside you, don't you [pc.name]?</i>\"\n\n");
	
	output("Her cheeks color when you give her a nod and begin lowering your [pc.ass] towards her pillar of horse-flesh. She gasps quietly when the tip begins to push against your [pc.asshole].  ");
	if(pc.analCapacity() >= urta.cockVolume()) output("You sigh and begin sliding down it, your stretchy backdoor easily accepting the gigantic intruder as it fills you.");
	else output("You grunt and begin sliding down it, feeling painfully stretched by the gigantic intruder but pressing on anyway, knowing full-well you'll be a bit looser by the time you take her whole length.");
	pc.buttChange(urta.cockVolume());
	
	if(pc.hasCock()) output("  The bumps and veins keep rubbing against your prostate, and [pc.eachCock] hardens near instantly from the forced stimulation.");
	output("  Slowly but surely, it slips further and further inside you, until you've bottomed out and have miraculously taken her entire shaft.\n\n");
	
	//(IF DICKS)
	if(cocks > 0) {
		output("For a few moments you sit on her deeply penetrating thickness, and ");
		if(cocks > 1) output("each of ");
		output("your [pc.cocksLight] droops onto her belly, half-hard from the pressure on your prostate, but going a little soft from the lack of attention.");
		if(pc.cocks[pc.longestCockIndex()].cLength() >= 15) {
			output("  Urta winks and guides [pc.oneCock] between her tits");
			if(pc.cocks[pc.longestCockIndex()].cLength() >= 20 && pc.cocks[pc.longestCockIndex()].cLength() <= 28) output(", even taking time to lick and suck on the head");
			output(".");
			output("  She begins giving you a slow tit-fuck, trying to encourage you to pick up the pace and start riding her.  It does the trick as your [pc.hips] start rocking on their own in reaction to her efforts.  She licks harder, and you reward her by lifting yourself up and sliding back down.  Her massive girth squeezes a squirt of pre-cum from your prostate with every few strokes, splattering it on her muzzle.");
		}
		output("\n\n");
	}
	else {
		output("For a few moments you sit like that, trying to adjust to the pressure in your backside.  After a few moments you can feel your muscles relaxing, allowing Urta to rest more comfortably inside you.  Flexing your [pc.legs], you pull yourself up off of her until the flared tip is just barely inside you, then you plunge back down.  Urta's mouth hangs open and her tongue lolls out, and you can feel the warmth of her leaking fluid inside of you, letting you know just how good your [pc.asshole] feels to her.\n\n");
	}
	output("You bounce on top of your fox-lover's equine rod, spearing your [pc.asshole] on it over and over.  ");
	
	if(!pc.hasCock()) output("Strange pleasure spreads from your sensitive opening, and you know that somehow you're going to cum from this.  ");
	else output("Powerful pleasure spreads through you as it bumps and rubs your prostate. You know you'll cum from this, and soon.  ");
	output("Urta cries out and grabs you by the hips, yanking you down against her sheath.  Warmth blossoms inside you as her seed begins pumping into your bowels.  You can feel yourself filling up with her seed and you cum, clamping down around her intruder as it injects more and more foxy-horse-spunk into you.\n\n");

	//(DICKS)
	if(cocks > 0) {
		if(pc.cocks[pc.longestCockIndex()].cLength() < 15) output("Your orgasm erupts out onto her belly, splattering her fur with your [pc.cum].  ");
		else if(pc.cocks[pc.longestCockIndex()].cLength() < 20) output("Your orgasm erupts all over her tits, slicking them with your [pc.cum].  ");
		else output("Your orgasm erupts into her muzzle, filling her mouth with your [pc.cum].  ");
		output("  Urta groans underneath you and begins caressing and squeezing you, milking you of every drop.");
		if(pc.cumQ() >= 500) output("  Urta gulps down as much as she can but it begins leaking around her muzzle, and she eventually lets it pop free, giving up on swallowing it entirely.");
		if(pc.cumQ() >= 1000 && pc.cumQ() < 1500) output("  Your output easily soaks her, and she gathers it up and slops it over her nipples, pinching and pulling on them.");
		if(pc.cumQ() >= 1500) output("  Your output soaks her and the bed with seed, leaving the two of you in a warm gooey puddle in the very center of the bed.");
		output("\n\n");
	}
	output("Urta pulls you down onto her breasts and gives you a long hug and a happy lick.\n\n");

	output("\"<i>Thank you soooo much lover, I needed that,</i>\" she says, \"<i>Now you better go get back to your business, I've got to get cleaned up!");
	if (pc.cumQ() > 750) output("  You really are a messy, " + pc.mf("boy", "girl") + " aren't you?");
	output("</i>\"\n\n");
	output("She untangles herself from you, the filled end of her condom loudly popping free from your backside as she disengages herself from you.  The two of you do your best to clean up and get dressed, and you give her a quick but passionate kiss before ducking out the door to check up on your camp.");
	pc.loadInAss(urta);
	processTime(35+rand(20));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[EAT THE BITCH OUT]
public function eatUrtaOutNomNomPussy():void {
	urtaSprite();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 3;
	urtaLove(1);
	clearOutput();
	//output(images.showImage("urta-bar-vag"), false);
	output("Urta smiles and suggests the pair of you move to a more secluded booth before trying that.  The buxom fox doesn't give you time to react, dragging you away from your current table to a dark corner-booth.  She releases the death-like grip she has upon your wrist and throws herself into the booth's padded cushions.  Her body slowly slumps back as she slouches more and more, sliding her body until her ass is about to slip out of the seat.  Lifting a fold of the table's heavy cloth, she asks, \"<i>Care to join me, lover?</i>\"\n\n");

	output("Suppressing a chuckle of your own, you slip under the table, ");
	if(pc.exhibitionism() > 66) output("secretly hoping you were noticed");
	else output("hoping no one saw you disappear");
	
	output(".  Something wet and warm smears across your forehead, and with a start, you realize you've bumped directly into Urta's over-sized member.  With a disdainful snort you shove the beast aside and lean forward, groping blindly until you find the fox's thighs.  She gasps as your fingers run through her silky fur, sliding inexorably towards her moist groin.  Her legs spread of their own accord once your probing fingers discover her equally over-sized testes.  This time you lift the offending body-parts from your way, exposing your goal.\n\n");

	output("By now your eyes have adjusted to the lack of light under the table, and you're given a clear look at Urta's female parts.  The area surrounding her nether-lips is gilded in short, downy fur.  Moisture from lust soaks the entire region, leaving many of the soft hairs hanging with beads of sweat or lubricant, reminding you of dew on the grass at dawn.  The outer lips of her sex are solid black, and shining dully with moisture, even in the low light.  Experimentally you touch them, spreading them apart for a better look at your lover's interior.  Her sex's inner walls are as pitch-black as the exterior but somehow wetter.  Every exploratory touch makes her twitch, and you watch fascinated as the entrance to her depths contracts and relaxes every time you brush against it.\n\n");

	output("Urta scooches her hips forwards eagerly, and you're forced to allow her thick dick and bloated balls to rest atop your head, lest they obstruct your tongue's glistening target.  Starting slowly, you begin to lick over the moist outer surfaces of her womanhood, happily tasting the tangy scent of her arousal.  She gasps, clamping her legs around you passionately.  Muffled by the tablecloth, you can hear a faint 'oooooh' of pleasure escape Urta's lips.  Taking that as encouragement, you begin dipping your [pc.tongue] into the honeypot, noisily slurping at her hole.\n\n");

	output("The click of heels on wood approaches, but you ignore them and step up your efforts, hoping to embarrass Urta in front of the newcomer.  A faint voice asks, \"<i>Are you O.K. Ma'am?</i>\"\n\n");

	output("Urta's thighs clamp down harder, holding you in place as she replies, \"<i>Just ah-ah little thirsty...could you bring me ahhhnother drink?</i>\"\n\n");

	output("\"<i>Um sure thing miss, just give me a moment,</i>\" blurts the other voice as it hastily retreats into the bar's background noise.  A burst of light nearly blinds you and then a hand is wrapped around your head, yanking you forwards.  Her musky box crushes against your face, filling the air under the table with lewd squishing noises as she grinds her hips into you.  You don't even slow down, and every chance you get you swirl your [pc.tongue] around the hard bud of her clit, pausing to suckle it before her forceful face-fucking mashes your lips into another part of her sex.\n\n");

	output("Sucking, licking, slurping, you judge the successfulness of your oral efforts by just how much fluid you can get to soak into your [pc.face].  The bar's noises are completely indecipherable, muffled as they are by the furred thighs clamped around your head and blocking your ears.  The fragrant musk of her box fills every breath you take as you eat her out in a frenzy, tonguing her with wild desire and need as your world narrows to the gash between her legs.\n\n");

	output("Eventually, the vice-like pressure around your head releases, and you stagger back, blinking in confusion and allowing her balls to drop back into their normal place.  Her cock quivers on your [pc.hair], depositing a thick stream of warmth down the back of your head.  Her thighs are twitching and her balls pulsating as she cums, unloading a thick batch of herm-cream down your back.  You jerk to the side and stroke her as she unloads, reaching around to the top of the table and grabbing an empty glass.  Guiding the flared tip into the receptacle, you allow the unknowing hermaphrodite to fill the glass with her seed.\n\n");

	output("Finished at last, Urta's member rapidly deflates, the scent of her cum on your [pc.hair] and her juice on your [pc.face] lingers.  You slide up into the booth next to your blissed out lover.");
	//[Give Glass] [Drink Glass] [Set Aside] [(New) Take Some Home]
	pc.girlCumInMouth(urta);
	processTime(15);
	clearMenu();
	addButton(0, "Give Glass", giveUrtaCumGlass);
	addButton(1, "Drink Glass", drinkUrtasCumGlass);
	addButton(2, "Set Aside", setAsideUrtaCumGlass);
	//addButton(3, "TakeSomeHome", takeUrtasCumHomeWithYou);
}

//[GIVE GLASS]
private function giveUrtaCumGlass():void {
	urtaSprite();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 1;
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	clearOutput();
	output("You give her a kiss to distract her and push the glass into her hand.\n\n");
	output("\"<i>I think the waitress dropped this off while you were distracted,</i>\" you say.\n\n");

	output("Urta snuggles you and tips it back, taking a huge swig.  She quickly pulls it back and gives you a confused look.  Dawning comprehension slowly spreads over her face before morphing into a sultry expression.  Never taking her eyes off you, the fox tips back the glass and gulps down the remaining fluid.  She grabs you by the neck and forcefully kisses you, forcing you to taste her pussy and jizz at the same time.  Breaking away, she teases, \"<i>Good to the last drop.  Thanks again lover.</i>\"\n\n");

	output("You smile knowingly and leave, intent on cleaning up a little back at camp.");
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Drink Glass]
private function drinkUrtasCumGlass():void {
	urtaSprite();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 2;
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	//(+Bonus luv)
	urtaLove(1);
	clearOutput();
	output("You give her a good look at the full glass and tip it back, gulping down her thick goop, letting it run out of the corners of your mouth.  Urta looks on, dumbfounded while you guzzle her remaining seed from the cup.  You set it down and burp, leaning over to give her a wet kiss, letting her taste both her sexes on your tongue.  She breaks the kiss and says, \"<i>Oh by Marae, I love you [pc.name].  Thank you so much.</i>\"");
	
	output("\n\nYou smile knowingly and leave, intent on cleaning up a little back at camp.");
	pc.loadInMouth(); // too lazy to measure doze
	pc.lust(20);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Set Aside]
private function setAsideUrtaCumGlass():void {
	urtaSprite();
	//(+Lots of Bonus Luv)
	urtaLove(2);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 2;
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");

	clearOutput();
	output("You set aside the glass and cuddle with Urta, snuggling with your lover as the pair of you share a moment of peace.  The satisfied smile on Urta's face is all the thanks you need.  She breathlessly thanks you and kisses you over and over.  Eventually you do part from her, giving her a knowing wink as you head out the door and back to camp, intent on cleaning the girl-cum from your face and the spunk from your hair.\n\n");

	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function takeUrtasCumHomeWithYou():void {
	urtaSprite();
	urtaLove(0.5);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 2;
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	clearOutput();
	output("You give her a kiss and let her know that you're going to take her cum home with you.");
	output("\n\nUrta smiles at you and says, \"Okay, lover. I love you!\"");
	output("\n\nYou smile knowingly and leave, intent on cleaning up a little back at camp.");
	//inventory.takeItem(consumables.URTACUM, returnToCampUseOneHour);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Under Table BJ]
public function blowUrtaUnderTheTableLuv():void {
	urtaSprite();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(3));
	urtaLove(1);
	clearOutput();
	//output(images.showImage("urta-bar-bj"), false);
	output("Urta smiles happily when you suggest climbing under the table.  She giggles, \"<i>I hope you'll be able to keep up with me</i>\", and fills a glass with straight whiskey while you crawl under the table, sipping happily.  You slip down under the table, pulling up her dress and releasing the mammoth trapped underneath it.  It snaps up immediately, bobbing before your face as it fills with Urta's booze-fueled lust.  It actually wiggles in time with the beating of her heart, bouncing up as it gets harder and harder, until it smacks your nose.\n\n");

	output("You hear the sound of her shot-glass slamming into the table with authority as she finishes her drink.  A bead of pre-cum bubbles out from Urta's urethra, signaling her readiness.  The horse-like penis gives off a salty scent, unique and not unpleasant.  Before you have a chance to change your mind, you lunge forward, opening your jaw as far as it will go and just barely taking her first few inches into your mouth.  The fox gasps out loud at the pleasure before she remembers to relax.  You can hear her pouring another drink, and in an effort to embarrass her, you begin sucking and licking around the edges of her flare, swallowing the surge of sweet-tasting pre-cum as it begins to fill your mouth.\n\n");

	output("Urta writhes in her seat, noisily spilling a little of her drink over the table.  You smile around the intruder in your mouth, gripping it with both hands and stroking it with tender caresses.  The gray fox slams down the bottle; though you can't tell for sure, you guess it's irritation with the difficulty she's having controlling her muscles.  She begins trying to sip at what she's managed to get into her glass.  It seems Urta intends to savor her drink and her blowjob at the same time, and you're not making it easy for her.\n\n");

	output("Deciding you've got to get her off and make her spill her drink, you ");
	if(pc.slut() < 50) output("do your best to suppress your gag reflex and shove forwards, ramming her cock as deeply into your throat as you can.");
	else output("shove forwards, ramming her massive cock so far down your throat that you can feel it dribbling pre-cum into your belly.");
	output("  Urta grunts, doing her best to muffle the noise as it escapes her lips, but you can feel her twitch and thicken inside you, beginning to drip with proof of her complete and total submission to your mouth.\n\n");

	output("You can hear chuckles from the bar's other occupants as they realize what's going on, and you blush, ");
	if(pc.slut() < 50 && pc.exhibitionism() < 50) output("wishing there was a tablecloth to hide your activities from prying eyes");
	else output("wishing you had even more eyes watching your show");
	output(".  The distraction does little to divert you from your chosen task, and you close your eyes, tasting your lover's throbbing shaft as it fills your mouth.  With both hands stroking, you bob up and down, completely centering your world around the pulsating horse-prick as it fills your mouth.\n\n");

	output("Without warning, Urta's legs wrap around your back, squeezing with her soft fur as she vices them closed.  You're forced to take her even more deeply, until the folds of her sheath are bumping your nose and chin and filling your nostrils with her heady musk.  You can't even breathe with such a massive intruder blocking your throat, but you do your best to get her off, knowing it's the quickest way to end it.  You suck hard and squeeze her balls, gurgling noisily around the sweaty-shaft as you feel Urta give in.\n\n");

	output("A wave-like motion passes through your throat-obstruction, stretching you wider than ever before.  It passes, leaving behind a feeling of warm fullness.  You feel another working its way into your mouth, and realize Urta is cumming, filling your belly with direct injections of horsey fox-seed. You desperately need to breathe, but you're trapped on your lover's maleness, and with nothing else to do, you give her twitching balls a squeeze, feeling her body twitch in response as she dumps a particularly heavy batch of spunk into you.  Happy that you could at least control how hard she came, you begin blacking out, barely noticing as Urta's orgasmic contractions die off.");
	pc.loadInMouth(urta);
	output("\n\nThumping down on your back, you're blissfully aware of the sweet air filling your lungs.  In a moment of reflection, you realize you can taste the salty flavor of Urta's seed on your lips and mouth, and the retracting horse-cock is ");
	if(pc.biggestTitSize() >= 1) output("dragging between your [pc.fullChest]");
	else output("dragging across your chest");
	output(" as it begins to soften.  You wipe as much of her leavings from your [pc.face] as you can, licking the slippery glaze from your lips.  Before you get up, you make sure to give Urta's member a firm squeeze, scolding it for its forceful treatment of your mouth.\n\n");
	output("Once you've climbed out from under the table, you're VERY aware of the eyes of some of the nearby bar patron's on your back.  It seems your undercover act managed to draw more than a little attention.  Urta's cheeks burn bright-red under her gray fur, though she has a loving smile on her face.  The pair of you share a tender kiss to hoots and catcalls from the audience.  Urta smiles and gushes, \"<i>You give the BEST blowjobs... I mean, WOW, but maybe next time we should go back to my place and do something a little more... fulfilling for both of us.</i>\"");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	pc.lust(20);
	processTime(25);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[RIDE VAGINAL]
private function rideUrtasCoochLoveyDovey():void {
	urtaSprite();
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(2));
	urtaLove(1);
	clearOutput();
	//output(images.showImage("urta-home-female-fuck"), false);
	output("Urta bursts into a wide smile at your suggestion and scooches over, making room for you on the bed.  ");
	if(pc.cockTotal() > 0) {
		output("She tosses you ");
		if(pc.cockTotal() == 1) output("a latex sheath");
		else output("some latex sheaths");
		output(" to cover [pc.eachCock] with, explaining that she doesn't want to have to mop up afterward, and you grudgingly agree.  ");
	}
	output("You climb in next to her, snuggling under the blankets and stroking her shaft, feeling yourself grow more and more ready as you tease your vulpine lover.  Urta doesn't move beyond rolling her eyes back and squirming her hips into your hand, trying to enhance the sensation.  She whines, \"<i>I thought you were going to fuck meee-</i>\"\n\n");

	output("Her cries are muted as you launch yourself over her, brutalizing her eager lips with a ferocious kiss.  You roughly tongue-fuck her as you adjust yourself, balancing yourself with one hand while your other guides her trembling shaft closer and closer to the entrance of your [pc.vagina].  You sigh happily and rub the pre-filled bulb against your opening, ");
	if(pc.vaginas[0].wetness() < 3) output("growing moist");
	else if(pc.vaginas[0].wetness() < 4) output("growing wetter and wetter as you lubricate the tip of her condom");
	else output("soaking her condom-covered cock with your copious cunt-secretions");
	output(".  Urta's body goes limp under your sexual assault, totally caving in to the feelings you're stoking inside her.  The only thing she manages to keep up is the twisting of her hips as she tries to enhance the sensations radiating through her massive, flared prick.\n\n");

	output("You end the kiss by pulling back, sucking her lower lip into your mouth, and then releasing it with a pop.  Nearly crying with need, your horse-endowed lover begs, \"<i>Ah, please don't stop!</i>\"\n\n");

	output("Never one to disappoint, you press onwards and downwards, sliding deeper into the bed as you work the wide, flared tip against yourself.  It slowly stretches you wide and bows under your weight, though Urta doesn't voice a word of complaint or displeasure.  You swivel slightly to the side and it works its way inside you, one half of the tip sliding inside at a time.  The fox's mouth opens into an 'O' of pleasure, letting her tongue escape as she begins panting from the pleasure.\n\n");

	output("Sinking down slowly and relishing the feeling of your passage being spread, you allow a low moan to escape your mouth.  Urta's hands lock onto her breasts and begin alternatively squeezing her soft mounds and fondling the black skin of her nipples.  The sensation of slow penetration is exquisite, growing within you while ever thicker horse-cock spears your womb.  You can feel the beat of Urta's heart racing through the shaft, swelling it slightly in time with each heartbeat.\n\n");

	output("You bottom-out, but immediately begin rocking your hips, working your lover's twitching rod deep inside your [pc.vagina].  ");
	//(LOOSENESS MESSAGES GO HERE AS APPROPRIATE)
	pc.cuntChange(0, 60, true);
	output("Urta's hands grab you firmly by the [pc.ass], reminding you just how strong the lithe fox is.  She begins working with you to lift your body up and slam it back down against her, alternating the feelings of emptiness and fullness within you.  Each time the little balloon that's formed on her flare gets larger, squishing each time she bottoms out.  As the pair of you rut faster and faster, the limited space inside you squeezes the excess pre-cum from the sheath, causing it to drip over her balls into the sheets.\n\n");

	output("Bending over, you plant another kiss full on her lips, and your vulpine lover just can't restrain herself anymore.  She moans into your mouth, her body shivering, her balls tightening up until you feel them press against your ass.  Her hands grip you hard and pull you down with incredible force, locking you against her as you feel her member swelling inside you, submitting to your [pc.vagina]'s swelteringly hot embrace.  A burst of tightness fills you, growing as Urta squirms, unloading her massive horse-pole's seed into the latex balloon she's stuffed inside you.\n\n");

	output("The filling seed balloon stretches tight inside of you, ");
	if(pc.vaginalCapacity() < 80) output("until there is no more room for cum and it's squirting out around the base of her cock, soaking Urta and the bed with fragrant horse-cum.");
	else output("filling your body with a large bubble of hot horse-cum.");
	output("  Watching your lover submit to your body's pleasure, the sight pushes you over the deep edge with her, and your body begins milking the thick shaft inside you, clenching around it as you spasm happily.  ");
	if(pc.cockTotal() > 0) {
		output("[pc.EachCock] spurts, unloading waves of cream into the ");
		if(pc.cockTotal() == 1) {
			output("condom Urta asked you to wear around it.");
			if(pc.cumQ() >= 250) {
				if(pc.cumQ() < 500) output("  The balloon inflates slightly, drooping down as your maleness empties its reserves.  ");
				else if(pc.cumQ() < 1000) output("  The balloon swells larger and larger as you pump it full, eventually wobbling around on Urta's belly as you finish filling it.");
				else {
					output("  The balloon swells larger and larger as you pump it full, wobbling obscenely on Urta's belly and slowly drooping down onto the sheets as the sheath reaches its maximum capacity.");
					if(pc.cumQ() > 1500) output("  Your potent seed pops the condom, splattering Urta with your [pc.cum] as it explosively fails.");
				}
			}
		}
		else {
			output("condoms Urta asked you to wear around them.");
			if(pc.cumQ() >= 250) {
				if(pc.cumQ() < 500) output("  The balloons inflate slightly, drooping down as your malenesses empty their reserves.  ");
				else if(pc.cumQ() < 1000) output("  The balloons swell larger and larger as you pump them full, eventually wobbling around on Urta's belly as you finish filling them.");
				else {
					output("  The balloons swell larger and larger as you pump them full, wobbling obscenely on Urta's belly and slowly drooping down onto the sheets as the sheaths reach their maximum capacity.");
					if(pc.cumQ() > 1500) output("  Your potent seed pops the condoms, splattering Urta with your [pc.cum] as they explosively fail.");
				}
			}
		}
	}
	output("\n\n");

	output("Urta's eyes roll back in her head as her body goes nerveless, devoting all its energy to cumming as much as possible inside you.  You grab onto her breasts and do your best to hang on for dear life, riding out your orgasm and trying not to drool onto the insensate fox.  She pumps away, weakly finishing her earth-shattering orgasm, her eyes half-rolled up and heavily lidded.  You slump down on top of her and slowly recover, trembling as muscle spasms work their way through your body.\n\n");

	output("Once you've recovered, you pull back with a long, wet sluuuuurrrrpPOP, and Urta's massive cum balloon slips out from between your nether-lips, pulling the rest of her shaft down onto her and bursting like a thrown water-balloon.  The splash of cum over her body rouses Urta from her orgasm-induced stupor, and the sexy fox moans with equal parts contentment and annoyance as she comes back to reality.\n\n");

	output("\"<i>Oooh, I'm going to need to do laundry AGAIN!</i>\" gripes Urta, lifting herself up to her elbows.  She continues, \"<i>But I'll be damned if cumming inside you isn't worth washing all the sheets in the world.</i>\"\n\n");

	output("Smiling, the two of you embrace, though you're careful not to get any of the cum on you.  Urta waves you out so she can get to cleaning, and by the time you leave you've got a spring in your step and a satisfied grin on your [pc.face].");
	//if(flags["COC.URTA_FERTILE"] == 1) pc.knockUp(21,515,80);
	processTime(45);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[RIDE ANAL]
private function rideUrtaInButtAtHomeLove():void {
	urtaSprite();
	urtaLove(1);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(2));
	clearOutput();
	//output(images.showImage("urta-home-anal-urta"), false);
	output("Urta raises an eyebrow at the suggestion and blushes, though her horse-like member thickens and stiffens noticeably.  You give it a gentle slap and tease, \"<i>Don't act like this isn't what you wanted!</i>\"\n\n");

	output("She squirms and smiles nervously, \"<i>It feels too good, even though it's dirty!  Besides, your sweet ass is irresistible!</i>\"\n\n");

	if(pc.hasCock()) {
		output("Even though you're going to be riding her, she insists you wear ");
		if(pc.totalCocks() == 1) output("a condom");
		else output("some condoms");
		output(" to help control the mess.  You grudgingly accept, girding your hardening shaft");
		if(pc.totalCocks() > 1) output("s");
		output(" in tight latex.\n\n");
	}

	output("You climb on to the bed, but fur-covered hands grab hold of your [pc.hips] and yank you down until something round and wide is knocking on your backdoor.  You can feel the latex sheath bubbling up, starting to give Urta's dick a more rounded tip and she begins pressing it into your backdoor.  The unexpected attempts at insertion surprised you and have kept you too tightly-clenched for the fox to batter her way inside.  She begs, \"<i>Please let me in!  I can't wait anymore!</i>\"\n\n");

	output("While giving her a knowing smile, you make a conscious attempt to relax your body's surprised rear-entrance.  Almost immediately you feel her slip inside, and then you're sliding down, sinking slowly towards your partner an inch at a time.  The expression on Urta's face is priceless – flitting between ecstasy and confusion as she struggles to deal with being engulfed by your ");
	if(pc.analCapacity() < urta.cockVolume()) output("tight");
	else output("welcoming");
	output(", warm hole.  A groan escapes your mouth as you sink down, feeling fuller and fuller until her real sheath is resting just between your ass-cheeks.");
	pc.buttChange(urta.cockVolume(), true, true, false);
	if(pc.hasCock()) {
		output("  You can feel tiny dribbles force their way out of ");
		if(pc.totalCocks() > 1) output("each of ");
		output("your urethra");
		if(pc.totalCocks() > 1) output("s");
		output(" as your prostate is compressed.");
	}
	output("\n\n");

	output("Urta recovers enough to meet your gaze and licks her lips hungrily.  Her hands release your [pc.hips] and rump, sliding up your sides and in towards your [pc.fullChest].  You shiver as she circles your [pc.nipple], teasing the flesh around them while managing to avoid providing them with any stimulation.  She looks up at you expectantly with a patient look, as if waiting on something from you.\n\n");

	output("You shift your hips and are rewarded by a caress over your left [pc.nipple], but it stops almost immediately.  Catching on, you flex your [pc.legs] and lift yourself up until her flare is the only thing connecting you before sliding back down the pulsating shaft, squeezing your muscles around it.  Urta's hands reward you by pinching and tugging on your [pc.nipples], ");
	if(pc.hasFuckableNipples()) output("even slipping a finger inside their slippery depths, ");
	output("spreading pleasure through the sensitive pleasure-buds.  Eager for more, you begin bouncing atop your vulpine lover, riding her as deeply as possible in return for a treasure-trove of sensation and lust.\n\n");

	output("Locked together by desire, love, and one swollen cock, you rut with her for what seems like forever.  You lose count of how many times your lover moans and screams in pleasure, and your own gasps of surprised enjoyment are too numerous to tabulate.  Urta's fur slowly becomes matted with sweat, and the salty scent of lovemaking fills the air.");
	if(pc.hasCock()) output(" [pc.EachCock] has filled its sheath with a golfball sized globule of pre-cum, and you can feel your body clenching and squeezing, your [pc.balls] aching to unload.");
	if(pc.hasVagina()) {
		output("  Neglected and unused, your [pc.vagina] ");
		if(pc.wetness() < 4) output("dampens");
		else output("floods");
		output(" the fox underneath you with moisture, puffy and aching for the slightest touch.");
	}
	output("\n\n");

	output("The lovemaking increases in tempo, slowly working its way to a feverish crescendo.  You're bouncing atop the fox wildly, and your lover cums hard.  As full as you felt with her inside you, it's nothing compared to being stuffed with her cock AND cum.  Each cum-filled contraction swells her member from base to flare, allowing you to feel it stretch your insides while it travels up your [pc.asshole].  It dumps the load into the bubble of cum inside you, filling you with a creamy jizz balloon.\n\n");

	//(GENDERLESS ORGAZM)
	if(!pc.hasGenitals()) {
		output("You cry out with pleasure, feeling the closest thing you can to an orgasm.  Your muscles clench around the invading rod, milking it while the rest of your body trembles.  The strength drains from your [pc.legs] and arms and you twitch there, completely impaled on your lover's thick cock, happily and completely penetrated.\n\n");
	}
	//(EVERYBODY ELSE)
	else {
		output("You cry out with pleasure, feeling your body cum from the invading warmth in your [pc.asshole].  Shivering as the strength drains from your arms and [pc.legs], you let the intruding and still cumming cock support your body.");
		if(pc.hasVagina()) {
			output("  Your [pc.vagina] clenches desperately, peaking without a single touch, but hungry for something to milk.");
			if(pc.wetness() > 2 && pc.wetness() < 4) output("  Fluids soak Urta's crotch with lust with feminine drool, though the fox barely seems to notice.");
			else if(pc.wetness() >= 4) output("  An explosion of feminine fluids spatters Urta's crotch and bed, completely soaking her groin in your need, but the distracted fox barely notices.");
		}
		if(pc.hasCock()) {
			output("  The warmth spreads deep inside you, firing off a series of contractions just inside your groin.  You can feel yourself about to cum, and look down just in time to see yourself squirting against your condom, deforming it from the pressure of the orgasm and slowly inflating it further.");
			if(pc.cumQ() >= 750 && pc.cumQ() < 1250) output("  By the time you're done the balloon is the size of a basketball and looking dangerously close to bursting.");
			else if(pc.cumQ() >= 1250) {
				output("  By the time you're done, the balloon is the size of a watermelon and wobbling dangerously, looking like it could fail at any time!");
				if(pc.cumQ() >= 1700) output("  You fill it fuller and fuller, until it's bigger than you thought possible.  All at once the material gives out, soaking Urta from the tits down in cum, while your [pc.cock] continues to pump even more onto her.  So much for not making a mess!");
			}
		}
		output("\n\n");
	}
	output("Exhausted, you drag yourself up, slowly feeling Urta and her sloshing deposit sliding out of you.  Her cock and its spooge and latex shrouded tip flops out with a loud 'schhhlurp', plopping down onto her.  The fox is completely insensate, and at a glance even her balls have shrunk from unloading so much thick cream.  You lean down and give Urta a quick kiss on her lips and a gentle squeeze on her nipple before you rise.\n\n");

	output("She comes out of her stupor and murmurs, \"<i>Mmmm, that was nice,</i>\" as she stretches.  With practiced motions she slides off her condom, ties it off, and tosses it into a waste-can half filled with the things.  ");
	if(pc.cumQ() >= 1700) output("Urta sighs at the mess and laughs, \"<i>I guess we got a mess anyways, huh?</i>\"");
	else output("Urta sighs contentedly and laughs, \"<i>I guess I don't have much of a mess to clean for once!</i>\"");

	output("\n\nThe fox staggers up on weak legs, her now flaccid but still huge member swinging between her knees as she redresses.  You do the same, and the two of you part with another tender kiss and a whispered, \"<i>I love you.</i>\"\n");
	processTime(45);
	pc.orgasm();
	pc.loadInAss();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[69]
private function oralFiestyUberExplosionUrta():void {
	urtaSprite();
	urtaLove(1.5);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(2));
	clearOutput();
	var x:Number = pc.cockThatFits(100);
	//output(images.showImage("urta-home-69","vert"), false);
	if(pc.hasVagina() && (x == -1 || rand(2) == 0)) {
		output("You smile and let Urta know you want to sixty-nine her.  She raises an eyebrow and teases, \"<i>I hope you don't mind having a full belly and a sore throat!</i>\" as you disrobe and climb atop her.  You turn about, straddling your legs across her face and exposing the hungry lips of your sex.  Smirking over your shoulder, you snatch her discarded dress from the floor and tie the shimmering fabric into an impromptu cock-ring.  The gray fox shudders with excitement and you watch, enraptured, as her mottled horse-cock grows larger and larger, even flaring wide at the tip.\n\n");

		output("The musky scent of Urta's forearm-sized horse-prick wafts into your nostrils as it wobbles just below your " + pc.face() + ", visibly twitching and throbbing from all the extra blood.  She whines plaintively, nuzzling her moist nose against your ", false);
		if(!pc.isSquirter()) output("equally wet");
		else output("sopping wet");
		output(" cunt.  Shivering from the air on your bare skin and the unexpected touches on your nethers, you open wide, extend your tongue, and give Urta's flare a long, slow lick.  You pause at her urethra, slip ever-so-slightly inside, and then pull out as you slather the flare in spit.\n\n");

		output("Urta eagerly gets to work, stabbing her tongue through your folds and into your [pc.vagina].  Her efforts bring her muzzle flush against you as she pauses to slurp your pussy-juices over your [pc.clit].  Her lips feel like liquid heat as they wrap around the incredibly sensitive bud, suckling it gently in between excursions into your passage.  Urta's slender fingers grab hold of your [pc.ass] to support her as she tongue-fucks your [pc.vagina] with abandon.\n\n");

		output("You do your best to stifle your moans with the fox's bloated horse-sausage, opening as wide as possible to encompass the flared head while avoiding your teeth.  It fills your mouth completely, and you marvel at just how much of her shaft is left to take.  A dollop of sweet cream rolls onto your tongue as you lick and slurp along her length.  Her skin tastes clean save for a hint of salt from the day's sweat.  You gurgle and ");
		if(pc.slut() > 50) {
			output("push forwards, feeling her shaft arch as it slides into your throat.  The medial ring slips past your lips and you can feel your throat bulging as you mouth-fuck the swollen horse-cock deep into your gut.  Warmth drips into your belly as the hermaphroditic fox's member closes on its sexual peak.\n\n");
		}
		else output("grab hold of her cock and begin jerking her off into your mouth.  An immediate and copious gush of pre drips onto your tongue, showing you just how much the hermaphroditic fox loves the feeling.\n\n");

		output("Not far from cumming yourself, you grind your [pc.hips] on Urta's face, smearing her fur with your fragrant pussy-juices.  Her own moans of pleasure turn into noisy wet blubbering that vibrates through your [pc.vagina], getting you off on the spot.  You squeal around the cock in your ");
		if(pc.slut() <= 50) output("mouth");
		else output("throat");
		if(pc.isBiped()) output(", clamping your [pc.legs] onto Urta's head");
		output(" as you orgasm.  ");
		if(pc.isSquirter()) output("Fluids rush from your folds, splattering her face with [pc.girlCum].  The fox opens wide, gulping it down like someone in a desert who has just found an oasis.");
		else output("Wetness slowly coats her muzzle as your canal squeezes and wriggles with involuntary pleasure-spasms.  Urta never lets up, sucking and licking your [pc.clit] in a rhythm that matches your own orgasmic contractions.");
		if(pc.hasCock()) {
			output("  [pc.EachCock] drools lamely, ");
			if(pc.cumQ() < 50) output("sputtering spunk onto Urta's neck.");
			else if(pc.cumQ() < 250) output("soaking Urta's neck and chest with your spooge.");
			else if(pc.cumQ() < 700) output("showering Urta's neck and body with spooge until her breasts are painted [pc.cumColor] and the bed has a small puddle soaking into it.");
			else if(pc.cumQ() < 1500) output("soaking Urta with a torrent of seed that drenches her from the neck down and totally soaks the bed.");
			else {
				output("soaking Urta with a torrent of seed that drenches her body and floods the bed, drips onto the floor, and slowly spreads into a puddle.");
				if(pc.cumQ() > 10000) output("  The puddle thickens as you cum until it's nearly a foot deep.");
			}
		}
		output("\n\n");

		output("Too drunk with pleasure to register the telltale thickening of Urta's cock, you keep licking and sucking while you cum, drinking a steady stream of pre-cum.  Suddenly, your improvised cock-ring snaps and the straps fail from the massive pressure.  A torrent of jism ");
		if(pc.slut() > 50) output("pours down your throat, bulging it into an obscene imprint of the horse-cock that's lodged inside.  Your eyes cross from pleasure and you slump down a bit, shoving your nose into Urta's sheath and allowing her to dump her sperm directly into your belly.  Gurgling noisily, your belly slowly expands outwards by about two inches, making you feel bloated and full.");
		else output("erupts into your mouth, instantly filling it with thick fox-cream.  You convulsively swallow in an attempt to keep up with it, but are quickly overwhelmed by the backed up semen-flood.  It drips from your mouth and forces open your throat, flowing directly into your belly.  Some even begins dripping out from your nose as you sway with a mixture of discomfort and pleasure atop your partner.  A few trembling squirts later you feel and look a little bloated, and your [pc.face] is thoroughly covered in foxy-horse-jizz.");
		output("\n\n");

		output("Both of you sputter for breath as you roll off of Urta.  She gasps and looks over at you with a smile, licking her sperm from your [pc.face] and nuzzling her pussy-soaked muzzle against your cheek.  She pants, \"<i>I suppose I should be mad at you for ruining the dress, but you got me off so hard that I think I gave you a few meals worth of my... um... cum.</i>\"\n\n");

		output("The fox giggles and returns to cuddling and licking you.  You rest with a happy smile plastered on your [pc.face] from the experience.  After all the snuggling, you both rise and get dressed.  Urta finds a new dress in the closet and with a long goodbye kiss, you go your separate ways.\n\n");
		processTime(35);
		pc.orgasm();
		pc.loadInMouth(urta);
		clearMenu();
		addButton(0, "Next", telAdreMenu);
		return;
	}
	//(DUDEZILLAZ)
	output("Urta sits up and practically screams, \"<i>Really,</i>\" and squeals excitedly.  She claps and lies back as you climb into the bed, stopping only to yank off her cock-sheath and toss it into a nearby waste-bin.  You swing your [pc.legs] over her and get into position, aligning ");
	if(pc.balls > 0) {
		output("your [pc.balls] and ");
	}
	else output("[pc.oneCock] with Urta's muzzle.  Her rather sizable 'addition' wobbles underneath you, blocking your vision as it wobbles back and forth under you.\n\n");

	output("Your foxy lover opens wide and slips her smooth, wide tongue all over your ");
	if(pc.balls > 0) output("[pc.balls].  Slithering over and around them, she bathes your sack in her spit before moving up to your [pc.cockNoun " + x + "].");
	else output("[pc.cockNoun " + x + "].");
	output("  Her tongue curves and slurps at your shaft, swelteringly warm, wet, and tantalizingly slippery.  She tastes you from [pc.sheath " + x + "] to [pc.cockHead " + x + "], stopping to suckle the sensitive end briefly before breaking away for another long lick along the underside.  Her hands stroke along the sensitive [pc.skinFurScales] of your inner thighs, making your hips shiver and nearly pulling your [pc.cock " + x + "] away from your lover's hungry mouth.\n\n");

	output("Whilst the fox is busy with your genitals, you begin to perform your duty, reciprocating the pleasure in turn.  You stretch your mouth wide, opening as far as you can to accommodate the mammoth beast before you.  It's difficult, but you manage to stretch wide enough to take her flare in your mouth.  It tastes vaguely salty like sweat, and in Urta's excited state it's easy to feel her flare widen and retract with each beat of her heart.  A dollop of pre-cum deposits itself on your tongue as the horny fox's nymphomaniac body reacts to you.  It tastes sweet, and you swallow as you work her deeper into your oral cavity.\n\n");

	output("Muffled, excited moans reach your ears as you work on your lover's pole.  The fox is clearly enjoying herself, and her sounds of pleasure cut off as she rams your [pc.cockNoun " + x + "] deep into her throat.  She gurgles noisily while her tongue slides as far down your shaft as possible, licking at your ");
	if(pc.balls > 0) output("[pc.balls]");
	else if(pc.hasVagina()) output("[pc.vagina]");
	else output("taint");
	output(" while her spittle froths around her lips.  She manages to start humming deep within her throat, vibrating your [pc.cock " + x + "].  The obstruction in your mouth stifles your moan, but Urta hears the startled gurgle and slides away, then plunges back down, humming the entire time in between gasps for air.\n\n");

	output("Not to be outdone, you pull back for a quick gasp of air before ramming her back inside your mouth.  You push forwards, taking her to the back of your throat");
	if(pc.slut() < 60) output(" until your gag reflex forces you back.  Not being able to deep-throat her, you shift your weight onto your right arm and grab her just below her medial ring with your left.  You start vigorously jacking her off, running your tongue around her flare and over her sensitive tip, even darting it into her urethra to get at her sweet-tasting pre-cum.");
	else output(".  You easily suppress your gag reflex and push forwards, feeling her cock arch slightly in the back of your mouth as it curves into your throat.  You extend your tongue as far past your lips as you can, licking down the shaft as you cram her further and further into your gullet.  Though you can't taste it, you can feel her urethra sending slow pulses of pre-cum inside of you, depositing it directly into your belly as you stuff your nose into her balls and tongue the skin around her sheath.");
	output("\n\n");

	output("If someone walked in on the both of you now they'd see a breathless fox and you, each with the other's cock rammed into their face.  They'd see each of you blushing bright and trembling, on the verge of orgasm and barely holding on as the other does their best to bring about an orgasm.  Wet slurps and panicked gasps fill the air while bodies twist and squirm together on the fur-covered bed.\n\n");

	output("You cum first, a victim of Urta's talented tongue and humming technique.  You'd cry out with pleasure were you not so thoroughly stuffed, and the fox slams her face into your groin after the first blast, pushing you into her throat and noisily beginning to gulp down your spooge.  ");
	if(pc.cumQ() >= 500) {
		output("She gurgles as she struggles to keep up with the flow, actually letting a bubbly [pc.cumColor] froth start to leak down the sides of her mouth.  ");
		if(pc.cumQ() >= 1000) output("It begins dripping from her nostrils as your explosive load overwhelms her ability to swallow spunk.  ");
	}
	if(pc.cumQ() >= 750 && pc.cumQ() < 1500) output("Her belly rounds out a little from all the cum as your orgasm begins to wind down.  ");
	if(pc.cumQ() >= 1500) output("Her belly rounds out a little before she pulls back and you spurt all over her, soaking her face and head with more spooge than she could ever handle.  ");
	output("Sated, you sigh, though Urta pushes back onto you and intently licks every ounce of jism from your body.\n\n");

	output("With only a few moments to recover from your own orgasm, you feel the fox stiffening, her apple-sized balls pulling up tightly against her body as she starts to orgasm.  A cock-bulging load of thick fox-cream forces your mouth wider before exploding ");
	if(pc.slut() < 60) output("in your mouth, forcing you to compulsively swallow if you don't want to drown in it.");
	else output("down your throat, directly injecting it into your belly.");
	output("  More and more of the salty cream is forced into you, leaving you feeling full and bloated, with a salty aftertaste in your mouth.  The fox-girl's horse-cock does eventually stop cumming, though rather than stopping all at once it slows to a trickle over the course of a minute or two, and you slurp it down until it softens in your mouth.\n\n");

	output("You climb off of her, panting and breathless as you flop into the bed next to her.  She snuggles up to you, cuddling you and kissing you on the lips and giving you a taste of your own lust.  Sinking into the soft bed, you relax with her for quite some time.  Eventually you've both recovered, and Urta playfully shoves you out of bed and onto the floor.  She springs out after you, her maleness still semi-erect as she gets dressed in her work uniform.\n\n");

	output("Urta blows you another kiss and says, \"<i>Gotta go!  Be good, and don't do anyone I wouldn't, OK?  Love you!</i>\"");
	processTime(35);
	pc.orgasm();
	pc.loadInMouth(urta);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

internal function urtaHomeLuvLuvinsMenu():void {
	clearOutput();
	urtaSprite();
	output("She caresses a nipple and visibly shivers as she says, \"<i>You teased me the whole way here, and I'm COMPLETELY ready for you, any way you could want.</i>\"\n\n");
	output("She blushes and continues, \"<i>So, what'll it be, lover?  A little injection of fox-cream or something else?</i>\"");
	//[Ride Vaginal] [Ride Anal] [69]
	output("\n\nHow do you want to fuck with the vixen?");
	clearMenu();
	addDisabledButton(0, "Ride Vag", "Ride Vag", "This scene requires you to have capable enough vagina.");
	addDisabledButton(2, "69", "69", "This scene requires you to have fitting cock or vagina.");
	addDisabledButton(3, "Vag Fuck", "Vag Fuck", "This scene requires you to have fitting cock.");
	addDisabledButton(4, "No Condoms", "No Condoms", "This scene requires you to have genitals.");
	addDisabledButton(5, "FuckAndLick", "Fuck And Lick", "This scene requires you to have fitting cock.");
	addDisabledButton(6, "Goo (Weird)", "Goo (Weird)", "This scene requires you to be goo-morph.");
	
	
	if(pc.hasVagina() && pc.vaginalCapacity() >= urta.cockVolume() * 0.66)
		addButton(0, "Ride Vag", rideUrtasCoochLoveyDovey, undefined, "Ride Vag", "She could fuck your vagina.");
	addButton(1, "Ride Ass", rideUrtaInButtAtHomeLove, undefined, "Ride Ass", "She could fuck your ass.");
	if (pc.cockThatFits(100) != -1 || pc.hasVagina())
		addButton(2, "69", oralFiestyUberExplosionUrta, undefined, "69", "Urta could 69 with you.");
	if (pc.hasCock() && pc.cockThatFits(urta.vaginalCapacity()) != -1) {
		addButton(3, "Vag Fuck", urtasCoochiNeedsFuckedLove, undefined, "Vag Fuck", "Urta could let you fuck her pussy.");
		addButton(5, "FuckAndLick", lickOutUrtaAtHome, undefined, "Fuck And Lick", "You could even fuck her cunt full of jizz and then lick her to a second cum.");
	}
	if(pc.hasGenitals())
		addButton(4, "No Condoms", condomlessUrtaInHouseSmex, undefined, "No Condoms", "There's always the option to ask her to go condomless for a bit of extra fun.");
	
	if (pc.isGoo() && pc.skinType == GLOBAL.SKIN_TYPE_GOO) addButton(6, "Goo (Weird)", urtaGooTesticleVoreRuinedOrgasms);
	
	if (flags["COC.URTA_PETPLAY_DONE"] != -1) {
		addDisabledButton(7, "Collar", "Collar", "This scene requires you to have genitals.");
		if (pc.hasGenitals()) addButton(7, "Collar", urtaPetPlayDeletedForeverBecauseThirdProovedMeWrongAboutDice);
		if (flags["COC.URTA_COLLAR_TAKEN"] == 1 && !pc.hasItemByType(CoCUrtaCollar) && !(pc.accessory is CoCUrtaCollar))
			addDisabledButton(7, "Collar", "Collar", "You should take collar with you if you want some petplay.");
	}
}

private function urtasCoochiNeedsFuckedLove():void {
	urtaSprite();
	urtaLove(1.5);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * (2 + rand(2));
	var x:Number = pc.cockThatFits(urta.vaginalCapacity());
	clearOutput();
	//output(images.showImage("urta-home-male-fuck"), false);
	output("Urta gives you a knowing look as she spreads her legs and lifts her bulging sack to expose the glistening black lips of her sex.  She asks with a sultry expression, \"<i>Is that what you need, lover, a slick, wet cock-sleeve to sheath yourself in?</i>\"\n\n");
	output("You nod eagerly and advance, dropping your [pc.gear] by the wayside as you jump into bed.  She reaches around her male endowments, stroking along her lips to her puffy black clit.  Urta shivers in pleasure, spreading her legs as far as she possibly can, watching you with a hungry look as she licks her lips.  A few long strands of cunny-juice leak from her waiting hole onto the bed, practically begging you to slide inside and feel her nether-lips' velvet embrace.  You sidle up to your lover, pressing [pc.oneCock] at the moist opening, shivering at the warmth and desire as it wets your tip.\n\n");
	output("You push forwards, slowly sliding into the moist tunnel, feeling its warmth covering every inch of your [pc.cockNoun " + x + "]. It caresses and squeezes you, surrounding you in perfect pleasure.  Urta stretches out languidly, her engorged horse-cock flopping down between her sizable breasts as it reaches a twitching, trembling hardness.  You bottom out, feeling the ");
	if(pc.hasSheath(x)) output("sensitive skin of your sheath rubbing her exterior pussy-lips");
	else output("wetness of her pussy rubbing against your groin");
	output(". Urta moans, \"<i>By Marae, you make my cunt feel good, lover.  I'm getting so wet... fuuuck, I'm going to need to change my furs and sheets again.</i>\"\n\n");

	output("Unthinking, your [pc.hips] begin to rock back and forth, sawing in and out of the fox's exotic pussy.  She wriggles and moans happily, losing her grip on her weighty balls and letting them slide over the top-side of your pussy-slicked [pc.cock " + x + "] with each movement.  You ignore it, increasing the tempo and watching as your lover's jiggling breasts shift and bounce around her flared penis, eliciting uncontrolled gasps of pleasure and causing pre to form a bubble at the tip of her latex cock-sheath.  Every thrust is met by a visible bulging of Urta's urethra and an increase in the size of the balloon hanging from her dick's flare.\n\n");

	output("Wet sounding 'schliiiicks' and noisy slaps fill the air as the sex takes on a violent, furious pace.  You slam yourself into the fox's hole, marveling at how nicely it accommodates and squeezes you.  The walls clench down on you from time to time, usually accompanied by a lewd moan as Urta's muscles involuntarily contract with pleasure.  She grabs her tits with both hands and squeezes them around her shaft, tit-fucking herself in perfect rhythm with your brutal thrusts.  Urta's condom starts filling faster – it's nearly the size of an apple now – and she's openly moaning and panting, on the verge of orgasm.\n\n");

	output("Your [pc.cock] is on the verge as well, ready to blow after fucking the dirty fox-girl so hard.  She cums first, shrieking in pleasure and throwing back her head, her hands clamping her jiggling breasts tightly around the rippling flesh of her massive horse-member as it begins unloading.  The surface of Urta's condom distorts as she fires a massive jet of her stuff into it, nearly doubling the size of the balloon.  Her hips wriggle and her pussy contracts around you, rippling along your length as the lusty fox's girl-cum squirts over your ");
	if(pc.hasSheath(x)) output("sheath");
	else if(pc.balls > 0) output("balls");
	else output("crotch");
	output(".  You grab her ass and slam in a final time, reaching your own peak.\n\n");

	//[DAWG]
	if(pc.hasKnot(x)) {
		output("Your knot flares wide, locking itself inside her convulsing cunt as your seed begins pumping into her womb.  Urta cries, \"<i>oooooooOOOOHHhhh YESSSS... You've plugged my cunt with your [pc.cockNoun " + x + "]!  It's squirting and pumping into my wooooomb...</i>\"\n\n");

		output("You rock back and forth, unable to pull out yet stimulating the sensitive bulb of your knot.  Your [pc.cock " + x + "] dumps its [pc.cumVisc] cargo directly into your lover's stopped-up sex with barely audible squishing noises.  ");
		if(pc.cumQ() < 250) {}
		else if(pc.cumQ() < 700) output("Her belly puffs up slightly by the time you finish, thanks to your body's copious cum production.  ");
		else if(pc.cumQ() < 1000) output("Her belly swells larger and larger as you continue to pump your seemingly endless seed into her.  Urta groans, looking a few months pregnant by the time your overproductive [pc.cockNoun " + x + "] stops spewing inside her.  ");
		else {
			output("Her belly swells larger and larger, bloating as you blast thick torrents of seed inside her, filling her completely thanks to the obstruction of your knot.  ");
			if(pc.cumQ() < 3000) output("By the time you finish, she looks VERY pregnant and is moaning with a mixture of pleasure and discomfort.  ");
			else {
				output("Your seemingly never-ending orgasm pumps her up until she looks on the verge of giving birth, and you just keep going.  The pressure builds and Urta moans in discomfort and pleasure.  Eventually the pressure is too much, and your [pc.cum] begins spraying out around your knot, soaking the pair of you as you both continue to cum hard.  ");
				if(pc.cumQ() > 5000) output("Not content with such an easy release, your [pc.cock " + x + "] unloads the last of its cream until the bed and floor are both covered under inches of your [pc.cumVisc] [pc.cumNoun].  ");
			}
		}
		output("You finally feel your " + possessive(pc.cockNoun2(pc.cocks[x], true)) + " knot shrinking and pull free with a loud and messy pop.  ");
		if(pc.cumQ() >= 2000) output("Spunk rushes out in a torrent, splattering everywhere.  ");
		output("Urta's glazed pussy-lips clench reflexively at their sudden emptiness and you hear a very satisfied sigh from the far end of the bed.\n\n");
	}
	//[HORSE]
	else if(pc.cocks[x].hasFlag(GLOBAL.FLAG_FLARED)) {
		output("You feel your flare filling with blood as it ");
		if(pc.cocks[x].cLength() >= 10) output("prods against Urta's cervix.");
		else output("seats itself deep inside Urta's passage.");
		output("  Your crotch muscles clench in an unconscious rhythm as orgasm wracks your body.  You begin spurting hard inside her, splattering it into her cervix, even allowing it to flow into her womb.  Urta cries, \"<i>ooooOOOHHHH YESSS... is this what you feel when I cum inside you?  YesYESYES- Ohhh I can feel the flare stroking and flexing inside me...</i>\"\n\n");

		output("You rock back forth, unable to resist dragging the sensitive, flared tip and textured ring of your cock all along her pussy-walls, squirting seed with reckless abandon into her hot, cum-slicked cunt.  Wet squishing noises fill the apartment as the two of you rock the bed in twinned orgasms.  ");
		if(pc.cumQ() < 250) {}
		else if(pc.cumQ() < 700) output("Her belly slowly rises as more and more cum slides into her womb, filling it.  Runners of the stuff leak down her thighs as it escapes around your [pc.cockNoun " + x + "].  ");
		else if(pc.cumQ() < 1000) output("Her belly swells larger and larger as you continue to pump your seemingly endless seed into her.  Urta groans, looking a few months pregnant by the time your over-productive [pc.cockNoun " + x + "] has finished spewing your seed inside her.  ");
		else {
			output("Her belly swells larger and larger, bloating out as you blast thick torrents of seed inside her, stuffing her completely.  Every squirt of the stuff is met with a leaking back-blast that soaks her thighs and bed in your jism.  ");
			if(pc.cumQ() < 3000) output("By the time you've finished, she looks heavily pregnant and [pc.cum] soaks the bed.  ");
			else output("Your seemingly endless orgasm pumps more and more into her until she looks ready to give birth, and  you just keep going.  She moans in pleasure and discomfort as each blast of your [pc.cum] forces thick runners to squirt from between her thighs.  ");
			if(pc.cumQ() > 5000) output("Not content with such an easy release, your [pc.cockNoun " + x + "] unloads the last of its cream until the bed and floor are covered in several inches of [pc.cumVisc] [pc.cumNoun].  ");
		}
		output("You finally feel your flare returning to normal and pull out with a prolonged 'sluuuuurp'.  ");
		if(pc.cumQ() >= 2000) output("Spunk rushes out in a torrent, splattering everywhere.  ");
		output("Urta's glazed pussy-lips clench reflexively at their sudden emptiness and you hear a very satisfied sigh from the far end of the bed.\n\n");
	}
	//[Everybody Else]
	else {
		output("Your [pc.cock] clenches, filling her convulsing cunt as your seed begins pumping into her womb.  Urta cries, \"<i>oooooooOOOOHHhhh YESSSS... It's so warm and wet.  Yes, lover!  Keep goo-oh-OH-innnngg!!</i>\"\n\n");

		output("You rock back and forth, sliding your shaft through her spasming muscles, reveling and panting in orgiastic bliss.  Your [pc.cock] dumps its gooey cargo deep into your lover's canal with barely audible squishing noises.  ");
		if(pc.cumQ() < 250) {}
		else if(pc.cumQ() < 700) output("Her belly puffs up slightly by the time you finish, thanks to your body's copious cum production.  ");
		else if(pc.cumQ() < 1000) output("Her belly swells larger and larger as you continue to pump your seemingly endless seed into her.  Urta groans, looking a few months pregnant by the time your overproductive [pc.cockNoun " + x + "] stops spewing inside her.  ");
		else {
			output("Her belly swells larger and larger, bloating as you blast thick torrents of seed inside her, filling her completely while leftover jism squirts out around your [pc.cock].  ");
			if(pc.cumQ() < 3000) output("By the time you finish, she looks VERY pregnant and is moaning with a mixture of pleasure and discomfort.  ");
			else output("Your seemingly never-ending orgasm pumps her up until she looks on the verge of giving birth, and you just keep going.  Jism sprays out from her dripping cunt as you release a torrent of semen, splattering you, her, and the bed.  ");
			if(pc.cumQ() > 5000) output("Not content with such an easy release, your [pc.cockNoun " + x + "] unloads the last of its cream until the bed and floor are both covered under inches of your [pc.cum].  ");
		}
		output("You finally feel your [pc.cockNoun " + x + "] deflating, and you pull free with a messy slurp.  ");
		if(pc.cumQ() >= 2000) output("Spunk rushes out in a torrent, splattering everywhere.  ");
		output("Urta's glazed pussy-lips clench reflexively at their sudden emptiness and you hear a very satisfied sigh from the far end of the bed.\n\n");
	}
	//[RESUME]
	output("Urta calms down at last, though her member is still throbbing weakly as she peels her condom off.  The bloated cum-bubble at the tip is the size of a basketball, and she struggles to get it tied off and disposed of.  The fox tosses it into a waste-basket already full of the things and gives you a toothy smile, \"<i>I think somebody's [pc.cockNoun " + x + "] loves my pussy almost as much as I love you!</i>\"\n\n");

	output("She pulls you into her arms and gives you a long, wet kiss before breaking away to clean up.  Urta blows you a kiss and says, \"<i>Thanks again, love!</i>\"\n\n");

	output("You and Urta go your separate ways after that, both stinking of sex and with a sense of deep satisfaction.");
	knockUpUrtaChance();
	processTime(35);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}


//Spank the Shit out of Urta and Make Her Cream Herself From Prostate Stimulation Alone Like the Horny Drunken Slut She Really Is
//(Needs: Drunk Urta, Tamani's Deluxe Dildo OR a dick that fits her butt)
internal function spankTheShitOutOfUrtaAndMakeHerCreamHerselfFromProstateStimulationAloneLikeTheHornyDrunkenSlutSheReallyIs():void {
	clearOutput();
	//output(images.showImage("urta-bar-male-spank"), false);
	output("You consider Urta's offers and, tempting as they are, decide they just aren't for you right now.");
	output("\n\n\"<i>Whaaa?</i>\" she snarls drunkenly.  \"<i>Ey, c'mon, lover,</i>\" she says, stumbling over and glomming onto you like a hammered harlot, \"<i>Gimme summin' here.  Or I might just take it personal,</i>\" she adds, and you suddenly feel a hard pressure against your thigh.  All right, no.  It used to be \"<i>save your ass for later</i>\" and now this? Time to teach Urta some manners.");
	output("\n\nYou grab the horny fox-girl and give her a rough shove towards the table.  She stumbles and nearly falls, only to catch herself on the table's edge.  With ease, you tear the back off her dress, exposing her silver fur, her tight little ass, and letting the beast below free.  Unrestrained, a loud 'THUNK' reaches you as Urta's erection whacks the underside of the table, spilling her half-finished glass all over.");
	output("\n\n\"<i>Whaddya think yer doiiiiEEE!</i>\" she yelps as you give her bare buttocks a harsh swat.");
	output("\n\n\"<i>Shut up,</i>\" you command, giving her other cheek a taste of your lesson.  Your palm's force is blunted somewhat by the thick, soft fur that covers the fox-girl's body, but you're still rewarded with a sharp gasp from your vulpine ");
	if(!urtaLove()) output("friend ");
	else output("lover ");
	output("with each swat.  \"<i>You're a rude bitch when you're drunk, Urta,</i>\" you add, giving her another swat on the ass.  She tries to stand, but you roughly push her back against the table.  You give her a fourth spank for her insolence, and can only grin when you hear her cock slam up against the table again.");
	output("\n\n\"<i>Oh, you like that, do you?</i>\" you ask, laughing, as you give the drunken fox-slut another stroke on the ass.  A little harder this time, so she winces - and the table jiggles from beneath.  By now, you're aware of quite a few onlookers, and more than a few are stroking themselves at the sight of Urta's half-naked form.  Her pronounced ass and pair of heavy, free-hanging breasts easily draw most of the attention, revealed as they are by the ruined tatters of her dress.");
	output("\n\n\"<i>I said,</i>\" you swat her again, this time grabbing her sexy hips to steady your target, \"<i>Do.  You.  LIKE IT?</i>\" and add another slap, making her tail stand up straight... and then brush against you.");
	output("\n\n\"<i>Ye... YEAH!</i>\" Urta yells, wiggling her ass, beet-red as it is.");
	output("\n\nOh come on, that was too easy.  You give the little slut a three-hit combo as punishment, but that just bounces the table up off the floor with the power of her erection.  \"<i>C-Come on, lover,</i>\" she moans, presenting herself as sexily as she can in her state, \"<i>just fuck my... my pusshy already... pleassshe?</i>\"");
	output("\n\nWell, at least she's learned SOME manners, but you aren't nearly done yet.");
	//{If PC HAS A DICK THAT CAN FIT UP URTA'S BUTTHOLE!}
	if(pc.cockThatFits(urta.analCapacity()) != -1) {
		var y:Number = pc.cockThatFits(urta.analCapacity());
		output("\n\nYou stride a little closer behind the drunken fox and free your own beast, dropping your [pc.cock " + y + "] between her cheeks.  She lets out a happy sigh, spreading her legs and gripping the table, seemingly without shame as half the bar starts rubbing itself to the show.  Her pussy's slick and oh-so-inviting, but you've got other plans!");
		output("\n\nYou line up and press your dick against Urta's tight little pucker.  She yelps, but you give her a hard spank as punishment.  \"<i>Desperate drunken sluts don't get to complain,</i>\" you say, giving her another reminder when she tries to open her mouth.  Silently, she digs her nails into the wood as you push in, slowly but forcefully, stretching out her vice-tight hole.  You hilt yourself, enjoying how tight, warm, and resisting her butt is.  Oh, she doesn't seem to want you back here - Urta makes a little whimper as you roll your dick across her prostate, feeling the little nub press against your shaft through her anal walls.");
		output("\n\nYou come to a rest and, rearing back, give Urta the hardest spank you've ever given.");
		output("\n\nShe cries out, and clamps down so hard on your dick that you feel like you're going to faint.  Urta's ass contracts all around you, her smooth, hot walls trying to clench but only serving to pleasure you.  You grin and notice that Urta's tongue has fallen out of her mouth, overwhelmed by pleasure.  Is she...  Oh, she's getting off on it, too!  You give her another spank, as she contracts and squirms... and her dick starts leaking.");
		output("\n\nThe little slut likes it on her prostate?  How cute!  Your roll your hips once, giving her a tantalizing bit of stimulation... and then another spank.  She squeezes hard on you again, hugging your dick to her prostate and pressing a geyser of pre-cum out of her huge horsecock.  You feel a bit leaking out of you as well, but that doesn't matter... you're just in there to show her who's boss, after all; to give her something to think about as you abuse her butt.");
		output("\n\nOn that note, you come down five times in rapid succession, swat after swat until her ass is vermilion.  \"<i>What a naughty, slutty girl you are,</i>\" you coo into her ear, slapping her again.  She cries out, squeezing you ever so tightly now, always in fear of the next strike of your open palm.  You ease up, giving her two gentle little swats, letting yourself bask in her tight contractions until you cum, releasing inside her until ");
		if(pc.cumQ() < 250) output("you've spent your load");
		else if(pc.cumQ() < 1000) output("filled her utterly");
		else output("streams of [pc.cumNoun] leak out of her ass, pooling at your [pc.feet]");
		output(".  Urta whines, desperate to cum, but you don't let her.  Not yet.");
		output("\n\nShe seems to get off from just the sensation of having your dick in her ass when you spank her.  You go to town on her ass, slapping her cheeks raw, as fast and as hard as you please, varying your pace so she can never relax.  \"<i>A-aaaah!  Yesh, yesh!</i>\" Urta cries drunkenly, her cock leaking so much that you're afraid she'll slip on her own pre as she scuffs her feet on the floorboards. You grab her tits with your free hand, savaging her little black nipples, reveling in the sensation running through your spent, deflating cock, still rubbing across her lewd ball of a prostate.");
		output("\n\n\"<i>Spank me harder!</i>\" she cries, eyes half-crossed from pleasure.  \"<i>Harder, [pc.name]!</i>\"");
		output("\n\nSo you oblige, until your hand stings and you can feel the orgasm bubbling up inside the fox-girl. She throws her head back and cries out a moment after your last, brutal swat, a jet of fox-cream spattering against the wall and table, soaking the Wet Bitch's furniture until it looks like it rained spunk around her.  You continue to pound her butt until she cries in agony, pleasure, and perhaps a little shame, as some of the bar's other patrons finally blow their loads too, creaming the floor until you don't think it'll be safe to walk out.");
		output("\n\nWhen your vulpine lover finally calms from her orgasm, you pull out of her stretched asshole with a wet pop, your [pc.cum] leaking out of her to join the mess on the floor.");
		output("\n\n\"<i>Ow,</i>\" Urta declares, before falling face-first onto the edge of the table - which promptly tips and dumps her into the nasty mix of spilled booze and cum.");
		output("\n\nYou give Urta one last palm on the ass before leaving, careful to edge around the huge mess on the floor.");
		processTime(15);
		pc.orgasm();
	}
	//{PC Don't Got the Dick but Do Got a Tamani Dildo Which is Almost as Good!}
	else {
		output("\n\nYou swing yourself into Urta's seat, dragging the half-naked fox-girl onto your lap, propping her up with her belly flat across your [pc.legs].  You yank off what remains of her dress, exposing her bare ass to the crowd of patrons.  With gusto, you give her a succession of swats on her defenseless rear, making the drunken fox squeal and squirm in your firm grasp, until you have to restrain her throbbing prick with your [pc.legs].  You give her a little squeeze, making sure she knows just who's in charge here.");
		output("\n\nSubmissively, Urta hangs her head and wiggles her butt, inviting you to spank her again.  Instead, you grab a big handful of ass-flesh and squeeze softly, distracting her with a little gentleness as you rummage through your pack... until your hand alights on something special.  You pull out the deluxe dildo, its pink plastic shimmering in the candlelight of the tavern, and pop the flexible head into your mouth, getting it nice and wet as your other hand alternates between gentle pats and rougher squeezes.  When you're satisfied, you give Urta a sudden, harsh swat, eliciting a yelp from her thin lips, then line the head of the dildo up with her tight little pucker - so innocent, so unsuspecting - and gently push inwards.");
		output("\n\n\"<i>Wh-whaaaa!?</i>\" she shrieks, squirming violently - though you can feel her dick start to squirt pre at the merest inches in her ass.  Gripping the table, you give her superior posterior another brutal smack, and though Urta yelps and clenches, your pink toy slides right into her in the wake of your spank.  Urta squeals as the dildo sinks further into her butthole, until just the flared back remains, pressed tightly between her reddened cheeks.  You grin as you feel her hard prick tensing more and more with every inch, until a large puddle of pre is forming under your [pc.feet].");
		output("\n\nNow that you've got something nice and hard wedged up her ass, you rear back and give Urta another series of quick, light spanks, working her ass over a dozen times.  She pants, groaning as her ass clenches hard around the toy inside her, trying desperately to force it out.  You just push it right back in, sinking an inch into her again before giving her one good, hard spank on her swollen asscheeks.  Urta cries out, clenching down so hard she almost pushes the dildo right out - but you catch it, and slide it back in, slowly and surely, making sure to work it into her colon nice and tight.");
		output("\n\nYou resume, alternating between spanking and pushing the toy back in, working up a regular rhythm until you're almost fucking her ass between strokes.  Urta moans lustily, wiggling her hips like a harlot and begging you for more - \"<i>Harder!  Faster!</i>\"  You oblige her, hammering her swollen butt with your palm and your toy until her cheeks are beet-red with the signs of your anal abuse; her ass is no longer trying to push the dildo back out, her slutty body utterly resigned to taking the fucking like a good bitch.  With each swat, you can feel reverberations through Urta's prick as your toy stimulates her prostate, running across her little inner bud until she's leaking pre-cum everywhere, just on the verge of orgasm.");
		output("\n\nWhen Urta cums, she cums HARD.  A scream is all the warning you get before a huge gush of fox-spunk splatters your [pc.legs], soaking your [pc.gear] with her spooge.  You recoil, nearly losing your grip on the fox as she creams herself, powerfully enough to squeeze the sodden dildo out of her ass. You give her crimson rump a devastating smack, forcing the last of her spunk out in a jet that coats the walls and table.");
		output("\n\nYou prop Urta up on your lap, giving her a good view of what she's done: the room full of people, half of whom have jerked themselves off onto the floor watching you abuse her ass, soaking the floor with spunk from a dozen different species.  You ask Urta, now shaky and panting from the ordeal, what she thinks about that.");
		output("\n\n\"<i>Ow,</i>\" Urta declares, before falling face-first onto the edge of the table - which promptly tips and dumps her into the nasty mix of spilled booze and cum.");
		output("\n\nYou give Urta one last slap on the ass before leaving, being careful to edge around the huge mess on the floor.");
		processTime(15);
		pc.lust(40);
	}
	pc.exhibitionism(1);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//*Urta starts on bed wearing condom and lacy stockings.  Holding condom for PC.
//*Nude and leaking.
//*New option: condomless
//*Give hint that virgins should do the cumflation scene?
//[Condomless]
private function condomlessUrtaInHouseSmex():void {
	clearOutput();
	output("You grab hold of the pre-filled bubble atop the fox's tip and yank, earning a moan as the latex sheath slides free, stretching it to an oblong mass before freeing her flare with an audible pop.  At the same time, you draw the second, unused condom from her unresisting grip and say, \"<i>Why don't we make a little mess?</i>\"");
	//non lover:
	if(!urtaLove()) output("\n\nUrta grumbles something about, \"<i>...can clean up the mess then,</i>\" and sulks, but a quick touch to the slippery equine flesh between her legs quiets her complaints.  She looks up at you quizzically, baffled as to just how much of a mess you plan to make.");
	//lover:
	else output("\n\nUrta rolls her eyes and declares, \"<i>Fine, but you'll help me clean up the mess, love.</i>\"  She's practically panting as she says so, cock jutting in the air as ribbons of pre dangle from that rigid tower.  Watching through lusty, half-hidden eyes, the vixen seems curious as to just how messy you want to get.");
	//[Peg Her Ass] [Fill Me Up]
	clearMenu();
	addDisabledButton(0, "Peg Her Ass", "Peg Her Ass", "You're too big to peg her ass and make her bust a nut all over herself.");
	addDisabledButton(1, "Fill Me Up", "Fill Me Up", "This scene requires you to have vagina.");
	addDisabledButton(2, "Tail Fun", "Tail Fun", "This scene requires you to have naga tail and genitals.");
	
	if (pc.hasCock() && pc.cockThatFits(urta.analCapacity() * 1.33) != -1) addButton(0, "Peg Her Ass", pegUrtasAssMessy);
	if (pc.hasVagina()) addButton(1, "Fill Me Up", fillMeUpPleaseUrta);
	if (pc.hasGenitals() && pc.isNaga()) addButton(2, "Tail Fun", nagaOnUrtaMess);
	
	addButton(14,"Back", goBackToUrtasForLuvinz);
}

//[Peg Her Ass]
private function pegUrtasAssMessy():void {
	clearOutput();
	//output(images.showImage("urta-home-pegurta"), false);
	var x:int = pc.cockThatFits(urta.analCapacity() * 1.33);
	output("Fondling the fox's apple-sized balls, you give her a hard but affectionate squeeze, rolling the heavy orbs around in your palm as you lift them high.  With her stuffed sack out of the way, Urta's oozing black-lipped gash is on full display, with engorged labia soaked in lubricants that had nowhere to go thanks to her smotheringly large scrotum.  Just below, you can see her anal star tightening and relaxing with each of the vixen's heavy breaths.  To you, it looks almost hungry, panting like an animal.");
	output("\n\nRemoving your [pc.gear] one-handed, you reveal your body and your intentions, flopping [pc.oneCock] down onto the sheets, a scant few inches from Urta's puckered asshole.  The fox ");
	if(urtaDrunk()) output("giggles drunkenly, \"<i>You're sho dirty!</i>\" while spreading those fishnet-clad legs further.");
	else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 11) output("softly begs, \"<i>Be gentle, please,</i>\" while spreading those fishnet-clad legs a little further apart.");
	else output("eagerly coos, \"<i>Feeling a little dirty, eh, lover?  Go on baby, you can fuck my ass anytime.</i>\"  She spreads her fishnet-clad legs so wide they almost form an unbroken, horizontal line from padded toe to padded toe, tying her soft, poofy tail around a leg to keep it out of the way.");
	output("  Scooting forward, you edge your [pc.cockHead " + x + "] up to her anus.  Her body heat washes over you as you enjoy the feel of her pucker's folded flesh pressing down on your most sensitive point, lubricated by the copious female fluid that drains from the sodden gash above.");
	output("\n\nYou begin to gently rock your [pc.hips] forward, giving little, gentle pushes against the resistant muscle.  At first, you make no progress, simply forcing her anal ring to dilate, little by little.  Then, after a particularly vigorous stroke, your [pc.cockHead " + x + "] slides through the clinging ring and into the tight embrace of her slick anus.  You stop to allow her to adjust, admiring her ");
	if(urtaDrunk()) output("drunken ");
	output("whimpers of pleasure.  However, you don't wait long, slowly pushing forward and exploring your vixen's every inner crevice with your eager rod.");
	output("\n\n\"<i>It's ");
	if(urtaDrunk()) output("sho");
	else output("so");
	output(" different than with a condom over a toy,</i>\" the vulpine lass wonders aloud in delight.  She licks her lips and ");
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] > 15) output("casually");
	else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] > 11) output("confidently");
	else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] > 4) output("a little nervously");
	else output("with a shaky hand");
	output(" strokes a padded fingertip down the bulging length of her urethra, shivering when it bumps across the sensitive medial ring.  A few inches in, you feel a rounded bulge bump into you, and as soon as you press against it, Urta's cock lifts up and thickens, flooded with blood.  The fox trembles for a second as you glide by the obstruction, and without any warning at all, her shaft belches a thick spurt of clear pre-cum with enough force to glaze the underside of her tits.");
	output("\n\nSmiling at the lascivious display, you gather a handful of the balmy animal cream and circle it around one of her perky nipples, admiring how the black nub perks up into a puckered, sensitive tower.  Then, while still pushing into her, you repeat the action on the other side, with identical result.  Your [pc.cock " + x + "] milks another heavy flow from the fox's prostate, this one tinged with just a little bit of off-white.  It puddles on her belly, already forgotten.  You're pushing forward without much worry for her comfort now, and blessedly, the fox doesn't seem to mind.  Indeed, with every lurch forward, her twat's drippings come faster and faster, matched by even larger discharges from the turgid member above.  ");
	if(pc.cockVolume(x) > urta.analCapacity()) output("The aching pressure around your [pc.cock " + x + "] doubles, and you realize she simply can't take any more.  Her anus is stretched wide, dilated to the extreme to accommodate this much of you.  There's little to do but plow her with what you can until she's fountaining white.");
	else if(pc.hasKnot(x)) output("The pleasure seems to double when your knot butts up against her furry rump, but her asshole isn't ready for that just yet.  This bitch needs a little more loving before you knot her.");
	else {
		output("The aching pleasure around your [pc.cock " + x + "] redoubles as you hilt her, smashing your ");
		if(!pc.hasSheath()) output("groin ");
		else output("sheath ");
		output("against her taut asshole with a heavy lurch.");
	}
	output("\n\nGroping the vixen's tits and thumbing her nipples, you have your way with her chest, torturously teasing her while your [pc.cock " + x + "] rests immobile in her ass.  Her pussy-slicked sack rests against you, lewdly bouncing and pulsating with need, fairly ready to explode; her cock is equally aroused.  The rigid length is so hard that it hovers over her smooth abdominals without touching them, bobbing up and down while it exudes a steady drizzle of lust.  The pre-spunk is so thick on Urta's belly that her fur is matted and glossy from her hips to the underside of her tits, and ribbons of the stuff run down her sides to lubricate the sheets below.  Her hands push yours into her chest harder, smashing her tits almost flat against her.  At the same time, her hips squirm and writhe, grinding in lewd little circles against you, swirling your dick up against every part of her sensitive tail-hole.");
	output("\n\nSimpering, the once-mighty guard-captain begs, \"<i>Don't... d-don't stop.  Please, I'm so close!</i>\"  You give her sack a slight swat, making her gasp, but hold still.  Smiling, you keep her like that - plugged full of cock, dripping, eager, and submissively begging.  Urta pinches one of her slick nipples as hard as she can, moaning like a whore in a heat as she desperately tries to encourage you.  She even grabs your hand and pulls your thumb into her mouth, placidly suckling your thickest digit while her eyes beg you to fuck her ass.  With her onyx lips in a seductive 'o' and her cheeks hollowed, fellating your hand, you know you can't resist.");
	output("\n\nYou lunge back, suddenly leaving Urta's asshole utterly empty.  The herm snaps back surprised, her dick drooping down slightly.  An angry glower takes over her visage, and just before she says anything, you leap forward.  Her pucker swallows ");
	if(pc.cockVolume(x) > urta.analCapacity()) output("most of you ");
	else output("your entire length ");
	output("before she can react, clinging to every inch of cock-flesh as it's forced deeper into her interior.  A wave of ecstasy washes through the fox, slackening her muscles in a ripple that travels from her waist to her lips in a second.  Her annoyance morphs into slack-jawed pleasure, and her protests deteriorate into babbling vocalizations of enjoyment.  Before she can recover, you pull back and thrust again, battering her sphincter repeatedly as you begin to truly pound the fox's ass.");
	output("\n\nUrta moans, \"<i>Fuck me!  Fuck my ass, [pc.name]!  Gods");
	if(urtaDrunk()) output("h");
	output(", why does it feel s");
	if(urtaDrunk()) output("h");
	output("o goooo-ooooooh yes!</i>\"  Her ass clutches and relaxes to your tempo, hugging your [pc.cock " + x + "] tight");
	if(pc.balls > 0) output(" while your [pc.balls] slap against her fuzzy buttcheeks.");
	else output(" while you slap your groin against her fuzzy buttcheeks.");
	output("\n\nMounting that tight tunnel over and over, you go back to thumbing at the vixen's nipples, ignoring the more obvious, turgid member below.  You even take the time to bat Urta's own hands away from her dick, wanting her to cum without the aid of her tremendous horse-cock.  Sawing in and out, you fuck the fox's ass with relentless energy, driven by your surging lust to pound that hole hard.");
	if(pc.hasKnot(x) && pc.cockVolume(x) < urta.analCapacity()) output("  You barely notice when your knot pops through the ebony ring, locking you inside her.  All you know is that while your strokes have gotten shorter, the pleasure has gotten even greater.");
	output("\n\nYou pinch the nipple you've been playing with and slam your [pc.cock " + x + "] home with rump-shaking force.  It slides the fox backward in her puddle of pre, slicking the underside of her legs with her sexual moisture as she's dragged through it.  Barely suppressing a moan of your own, you shimmy forward again and voraciously tackle her asshole, pegging Urta with short, brutal strokes.  Eager to see her blow, you shift your angle and press up, slamming your [pc.cockHead " + x + "] into her prostate so hard you swear you must be flattening it.  Urta screams, her balls contracting powerfully.  Her dick, already iron-hard, seems to swell thicker, looking like a flat-tipped, over-inflated sausage.  Bulging obscenely, the underside of her cock swells with lusty intent, the distention moving up with muscular contractions until the vulpine girl's cum-slit is wide and filled with white.");
	output("\n\nThe onyx asshole wringes you with every ounce of force its owner can apply, convulsing into a tight cock-ring that");
	if(pc.hasKnot(x) && pc.cockVolume(x) < urta.analCapacity()) output(" only makes your knot bigger and harder.");
	else {
		output(" works you so hard an irrational part of your mind worries your manhood will be pinched off.");
		if(pc.cockTotal() > 1) output("  Good thing you have more.");
	}
	output("  Then, the fox stops being a fox and turns into a fountain, spewing a wave of white up over her head and into the wall.  It hits with a wet 'splat', flinging alabaster globs in every direction that burst like little bombs.  Spunk rains down over Urta, staining her bed and her in equal measure.  A lock of gunked-up hair flops across her face, temporarily blinding your orgasm-inundated lover.  Just when the dripping jizz slows and you think the worst is over, Urta goes off again, though this fountain of white has a little less force than the preceeding cumsplosion.  A wave of semen as thick as your wrist spurts out to take the fox in the face, plastering the rest of her lustrous hair to her forehead and glazing her visage with ivory lust.  Ringlets of her ");
	if(flags["CO.URTA_QUEST_STATUS"] < 0) output("not-so-fertile ");
	output("fluid dangle precariously from her jawline as she tries to breathe, coughing and making bubbles from her white mask.");
	output("\n\nTight in your grip, Urta's nipple seems harder than ever.  You give it a gentle twist, milking another moan from the spasming body below as it lets loose a third torrent of seed.  The fox juice splatters between her tits, washing her upper body with slick bliss.  Rivers of it roll off her into the sheets; the mattress soaks it up like a sponge but still squishes and puddles with every shift and movement you make.  Unable to restrain herself any longer, the sperm-soaked fox grabs her dick with both hands, pumping from flaring tip down into her sheath.  Her asshole wrings you tighter through the next three blasts she unleashes.  She soaks herself, the headboard, and the wall until all three are covered in a uniform cum veneer.  Still, the productive fox isn't spent, and her drooping member continues to ejaculate more spunk.  Tendrils of hot jizz reach down to the floor, collecting there as the bed floods.  Her mouth opens to catch some of it, greedily gulping down a tiny portion of her own equine icing.");
	output("\n\nUnable to bear the tightness wringing at your [pc.cock " + x + "] you pull back");
	if(pc.hasKnot(x) && pc.cockVolume(x) < urta.analCapacity()) output(" with a lewd pop, freeing your knot");
	output(", exiting Urta's torturously squeezing anus.  With the pressure on her prostate relieved, the voluminously virile vixen finally relaxes, her cock belching only a few more 'small' loads over her reclining form.  She sags back into the drenched cushions, with every motion leaving a glittering web of spooge in its wake.  Exhaling in exhaustion, your cream-coated fox blinks cum from her eyelashes as she stirs to smile at you. [pc.EachCock], already rock hard from the fucking it was so recently dispensing, grows painfully erect.");
	output("\n\nYour eyes lock onto the slick valley between Urta's well-formed breasts and seeing the source of your release, you climb into the morass with her.  Before you can even mount her, you lose your grip on the spunk-slicked bedding and fall onto soaked fur.  Giggling, the vixen lamely pulls you into her, into the mess.  She's too weak to put up much of a fight, and you quickly fight your way up onto her chest, planting [pc.oneCock] right into her tits.  The salty fox-horse cream makes the perfect lubricant for tit-fucking.  Urta laughs happily, drunk on pleasure");
	if(urtaDrunk()) output(" and of course, alcohol");
	output(", kissing your [pc.cockHead " + x + "] every time it peeks past her tits, relishing the taste of her own lust all over it.");
	output("\n\nSoon, the sultry spunk-vixen has a breast in each hand, and she alternates bouncing them up and down.  To one side, your dick feels like it's sliding into a sopping twat.  On the other, it's thrusting in.  Above, you're treated to the sight of her chest heaving and bouncing, lewdly jiggling around your cock as she services you.  You groan in bliss as you climax, unable to endure the sight and sensation, let alone the musky, sexual smell that pervades Urta's bedroom.  She opens wide to catch your climax in her mouth");
	if(pc.cumQ() < 250) output(", swallowing with a smile and a wink.");
	else {
		output(", but she's forced to close it when her cheeks are puffed beyond reason.");
		if(pc.cumQ() > 750) output("  You go on to wash her face with your own [pc.cumColor] sauce.");
		if(pc.cumQ() >= 1200) output("  Your orgasm goes on and on, coating just about everything that Urta came on with yet another layer.");
		if(pc.cumQ() > 3000) {
			output("  She gasps in surprise when you flood the ");
			if(pc.cumQ() > 10000) output("first few feet of the ");
			output("room, looking up at you in admiration through [pc.cumNoun]-coated eyelashes.");
		}
	}
	output("\n\nAs you finish emptying your [pc.balls], you sag down into the fox's arms.  She plants a salty kiss on your lips ");
	if(urtaLove()) output("and nuzzles against your cheek, just holding you for a few moments, lover to lover.");
	else output("and sheepishly pulls back.");
	output("  Climbing out of the cum-painted bed is no easy task, but the two of you manage, laughing and leaning on each other's arms.  Urta leads you to a cabinet in another room, and bends over to open it.  You barely notice her pulling out mops, buckets, and cleansers.  Instead, your vision is riveted to her asshole, still gaped lewdly in the shape of your [pc.cock " + x + "].  When she comes up with an armload of cleaning supplies, you're ");
	if(pc.slut() < 50) output("blushing");
	else output("smiling devilishly");
	output(".");
	output("\n\nUrta smirks, glancing from your hardening groin up to your eyes, and says, \"<i>Come on, you horn-dog, let's go clean up your mess.  You can help me fill a few condoms later.</i>\"");
	processTime(40);
	pc.orgasm();
	pc.slowStatGain("l", 0.2);
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	urtaLove(2);
	//[Next]
	clearMenu();
	addButton(0, "Next", UrtaGetsPeggedCleanUp);
}

private function UrtaGetsPeggedCleanUp():void {
	clearOutput();
	if(pc.cor() >= 50 || pc.isAss()) output("You start to duck out, but the disapproving glare the fox gives you makes it clear that you won't be getting any more messy fun unless you stick around to clean it up this time.  Damnit.  ");
	output("With Urta's help, you slowly clean up the mess you two made, nearly clogging the plumbing a few times in the process.  New sheets, pillows, and furs are brought in, and you help her fix her bed.  The floor is mopped, the walls are scrubbed, and the shutters are opened to let in some fresh air.  Thankfully, just about everything is watertight and sealed, likely something she had done to ease situations such as this.  All told, between clean-up and sex, you spend a few hours with her.");
	output("\n\nTenting her apron (the only thing she's bothered to put on), Urta gives you a ");
	if(!urtaLove()) output("wave");
	else output("tender hug");
	output(" and sends you on your way.");
	processTime(90 + rand(60));
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[Get Filled Up At The Cum Pump Or Something This Was Supposed To Be A Joke]
private function fillMeUpPleaseUrta():void {
	clearOutput();
	//output(images.showImage("urta-home-female-fucked"), false);
	output("Lazily discarding the latex, you caress Urta's stocking-clad leg and coyly climb into bed.  She starts to reciprocate your affections, but you push her arm away, instructing, \"<i>Let me... let me have this.</i>\"");
	output("\n\nGingerly holding the beast between her thighs, you take a moment to admire the texture, the forgiving sponginess of the stiffening flesh and its smooth surface, broken only by a collection of pulsating veins and a thick ring that splits the middle.  You squeeze the musky fur of her snatch and pull it down, revealing another inch or two of moist dick for you to tease; Urta shivers at your touches on her sensitive flesh.  Looking up to meet her gaze, you bend down with glacial slowness, eventually laying the flat of your [pc.tongue] upon her turgid mass.  Lewdly, you kiss the underside, worshipping it with your lips as you trail moist affection up the horse-cock's gradual arch.  You nibble on her medial ring when you find it, lashing it with your tongue as you stop to harass her nerves.  Then, without warning, you resume your upward travels, watching the fox whimper and shake as your tongue tantalizes her equine member.");
	output("\n\nUrta's hips silently work, trembling slightly each time they start to lift up.  Of course, you force them down into stillness and return to lubricating the horse-like length before you.  Her tip flares a little as you near it, pulsing with pleasure at every idle oral affection you plant.  You stretch your jaw to fully encompass her tip, taking it into your mouth and looking up at the herm.  Her eyes are closed, her mouth open and panting.  Hanging to the side, Urta's tongue pulsates in time with her unrestrained panting.  You circle her urethra with your tongue and smile around the throbbing dick when a salty drop of pre-cum lands on your tongue.");
	output("\n\nYou release Urta from your oral embrace, laying her rod back down on her soft fur with great care.  Whining, she tries to grab your head and pull you back in place, but you twist to the side and slap her searching hands away, sliding up her body to hold them above her head.  You pin them to the headboard, leering over your prize with ardor, your [pc.vagina] heavy with lust and equally wet.");
	if(pc.wetness() > 3) output("  You're so utterly soaked thanks to this place that a steady stream of vaginal lubricant drizzles over the meaty tool below.");
	if(pc.hasCock()) output("  Hard and erect, [pc.eachCock] stands tall and proud, but ignored.  You have other plans.");
	output("  She's ready.  You're ready.  It's time.");
	output("\n\nReleasing the guardswoman's hands, you shift to grip her throbbing erection and lift it up, raising it until it stands vertically, the spongy-yet-hard tissue wobbling slightly under its own weight.  Giggling absurdly, you begin to lower yourself onto it, pressing your vulva up against the spit-slathered shaft.  Urta whimpers but holds her place, her hands still up against the headboard where you left them.  The exquisite texture of that hot flare pressing up against your labia sets your body ablaze with pleasure, and you grind your hips over it with unthinking adulation, worshipping the herm's heady cock with your cunt.  A burst of pre-cum distends the vulpine woman's cum-slit long enough to soak you further");
	if(pc.wetness() > 3) output(", though it's a drop in the bucket next to your copious moisture.  Hell, even now, rivers of your girl-goo are sliding down that spasming length, wreathing it in lady-spunk");
	else output(", deliciously staining your slit");
	output(".");
	//{Virgin PCs}
	if(pc.vaginas[0].hymen) {
		output("\n\nSmiling a little nervously after coming so far, you say, \"<i>You know I'm a virgin, right?</i>\"");
		output("\n\nThe vixen sits bolt upright, her face just inches from your ");
		if(pc.tallness > 80) output("[pc.clit]");
		else if(pc.tallness > 60) output("[pc.belly]");
		else output("[pc.chest]");
		output(" as she cranes her neck to meet you, eye to eye.  \"<i>Really?</i>\"  You nod, biting your lower lip as you continue your frenzied undulations upon her rod, working yourself up to taking her.");
		output("\n\nUrta wraps her arms around you, hugging you tight, though she doesn't take you away from her member.  Moisture beads at the corners of her eyes as she ");
		if(urtaDrunk()) output("drunkenly ");
		output("asks, \"<i>Are you s");
		if(urtaDrunk()) output("h");
		output("ure?  You don't have to...</i>\"");
		output("\n\nYou ruffle her hair and nod, slowly beginning to lower yourself.  Her tip, flared as it is, is simply too wide for your channel at first, and stubbornly refuses to slide into your lips.  Urta pries your womanhood wide and gently shifts her member, easing half her cocktip into you at a time.  Eventually, she goes in, and the vixen gasps, \"<i>So t-tight!</i>\" with her eyes crossing from pleasure.");
		output("\n\nTo you, the situation is almost painful, but you soldier on, determined to give the affectionate herm your maidenhead.  You squat lower, tearing something as you take the first few inches into your nethers.  It hurts, and there's a little blood, but as more and more of that shaft is sheathed in your sensitive slit, it begins to feel better and better, exquisitely pleasurable.");
		if(pc.hasCock()) output("  Drool begins to leak from [pc.eachCock], slicking the underside with pre-cum as the pleasure affects your maleness.");
		output("  Before long, you've taken Urta halfway, with her ring jutting up against your entrance.");
		//{cuntChange 30}
		pc.cuntChange(0, urta.cockVolume() / 2, true, true, false);
		output("\n\nUndaunted and spurred on by how good it feels, you ease yourself into your lover's hands, lowering your body an inch at a time, gradually widening your [pc.vagina] to handle her spear and magic helmet, stretching your nethers into a reverse mould of that affectionate prick-vixen's tool.  You doubt anything will ever fit you as perfectly or rightly again, or scrape every inch of your birth canal so flawlessly.  It hurts a little, stretching like this, but it's worth it to watch the fox's face slowly lose its reserve, splitting into a dopey, pleasured grin as you sink the whole way to her balls.");
		//{cuntChange 60}
		pc.cuntChange(0, urta.cockVolume(), true, true, false);
		output("\n\nYou rest in her lap and kiss her, bringing her out of her stupor.  Urta bashfully murmurs, \"<i>Thank you,</i>\" before kissing back, hugging you tightly for a few moments.  Bound up in each other, you share the tender expression of affection a little longer.");
		//{+15 Urta love}
		urtaLove(15);
	}
	//{NOT VIRGIN TEXT}
	else {
		output("\n\nWithout pausing, you squat down, lowering your [pc.vagina] to ensnare the stallion below, lassoing it with ease in your clingy, stretching lips.  Urta moans as you take her flare, lifting her hips slightly to meet you, driven beyond reason with lust.  You place a hand on her rising belly for support and ride her like a bucking bronco, sliding lower with every thrust, gradually spreading yourself around the welcoming heat of her throbbing member.  You can feel the ring around the middle of her mottled horsecock caressing your silky tunnel even as the flare presses harder on it, further in.  It's an exquisite sensation that you focus on as you work to fully enclose your rebellious lover, snaring her prick in your silky, lubricated twat.");
		output("\n\nUrta's eyes roll back and she lifts her hips powerfully one last time, and in the motion she takes you fully, embedding all twenty inches of her length inside you.  Her sheath grinds into your outer lips as she continues to push, but there is no further penetration to be had.  You're completely, utterly speared, penetrated fully by the vixen's horse half.  As if realizing this, Urta lowers herself down, twitching slightly as she adjusts to the slippery warmth of your [pc.vagina].");
		//{cuntChange 60}
		pc.cuntChange(0, urta.cockVolume(),true,true,false);
	}
	output("\n\nUrta grabs you by the hips, ready to go to town on you, but you stop her with a simple motion.  Shaking your head, you coo, \"<i>Let me.</i>\"");
	output("\n\nThe fox reluctantly nods, doing her best to hold still as you set to work.  You slowly raise yourself up, your wet lips clinging to every inch of the well-lubricated shaft as it exits your sodden pussy.  Once only the flare remains inside, you lower yourself back down, sliding slowly back into place just a little faster, assisted by gravity as you are.  It feels so good, so heavenly, that you just can't keep up the languid pace.  After a few simple strokes, you find your [pc.hips] beginning to move faster, pumping Urta in and out, slapping back down with lewd, wet smacks that can doubtless be heard from the street below.");
	if(pc.exhibitionism() >= 66) output("  An exhibitionist thrill runs through you at that, making you even wetter.");
	output("\n\nLeaning forward, you place your hands on Urta's bosom.  The fur on her chest is silky smooth, and seems to cradle your fingers as they knead her heavy orbs, unashamedly groping the well-endowed hermaphrodite as you plow yourself on her.  Her nipples dig furrows into your hands, hard as bullets, forcing you to change tack after a few seconds of enjoying those sweet tits.  You caress and tweak at the nubs, squeezing them between fingers and tugging slightly, never stopping the movement of your [pc.hips].");
	if(pc.hasCock()) output("  You don't even notice [pc.eachCock] dripping on Urta's belly.");
	//HERMS:
	if(pc.hasCock()) {
		output("\n\nUrta does, however, and takes [pc.oneCock] in hand to pump it, smearing you with your own pre-cum for lubricant.  You moan out loud at the surprise handjob, swiveling your hips around in an attempt to fuck her hand and cock at the same time.  It's a cacophony of bliss, an explosion of sensation, and you barely hang on for dear life as it flows through you.  Your body bounces atop Urta's like a jackhammer, wildly thrashing and undulating as pleasure overwhelms you.");
		output("\n\nThe first sign of your orgasm is a spurt of [pc.cumNoun] that fills the fox's hand");
		if(pc.cockTotal() > 1) output(", followed in short order by the untouched portion of your [pc.multiCocks]");
		output(".  The next is your [pc.vagina] going wild, convulsing from your entrance towards your womb with muscular contractions that milk Urta's cock relentlessly, causing it to grow bigger and harder inside you.  Urta whimpers slightly as you jizz over her belly");
		if(pc.cumQ() > 400) {
			output(", soaking her");
			if(pc.cumQ() > 1000) {
				if(pc.cumQ() < 2000) output(" and her bed");
				else output(", her bed, and damn near everything else");
			}
			output(" with your [pc.cum]");
		}
		output(".  There's a bloom of warmth from below as the vixen's orgasm rushes towards you, and all you can do is cum your brains out in anticipation of being filled.");
	}
	//NON-HERMS:
	else {
		output("\n\nMashing your glistening delta into the herm-fox's balls again and again, you begin to whimper with need, too hot and wet to care what you sound like.  Your body goes on autopilot, slamming harder and harder into Urta, riding her eagerly, desperately, mashing your [pc.clit] into her stomach fur without care for anything other than your own pleasure.");
		output("\n\nThe first sign of your orgasm is a cunt-clenching explosion of satisfaction that worms through your womanhood, sending your muscles into fluttering convulsions.  As you scream in exquisite enjoyment, you feel those contractions settling into a rhythm that squeezes the vixen's horse-prick from stern to stem, milking the thick cock, egging it on towards the heady rush of climax.  You can feel it thickening, becoming more rigid inside of you, and as Urta nears orgasm of her own, all you can do is cum your brains out in anticipation of being filled.");
	}
	output("\n\nThere's an odd, shivering motion beneath you, in the herm's taut nutsack.  A moment later, your spasming cunt is forced to open wider, stretched by a bulge of cum that visibly distends not just the cock it travels through");
	if(pc.thickness < 50 && pc.bellyRating() < 10) output(" but the outline on your abdomen as well");
	else output(" but your [pc.vagina] as well");
	output(".  It sets you aflutter all over again, just before it bursts against your cervix.  Urta's hands dig into your sides as she suddenly pulls you against her, somehow squeezing another inch of cock into you from somewhere, battering her tip directly against your inner opening.  The next slit-stretching pulse of jism erupts directly into your womb, filling you with salty horse seed in an explosion of warm indulgence.");
	output("\n\nYou bubble happily, a sense of motherly pride welling up in your breast as you continue to cum, your [pc.vagina] helplessly milking the equine invader with rapacious hunger.  Again, it cums, injecting another plus-sized load directly into your precious baby-maker.  It fills you with enough force to round your belly a little, giving you a nice, sperm-bloated paunch.  Urta's hands dig into your [pc.butt], holding you still and immobile, as if she were restraining you in order to fully breed.  The onrushing spunk expands your womb further, stretching your belly tight.  Rivulets of spooge squeeze out the sides of your clenching cunt as your jizz-packed body fails to hold it all in.");
	output("\n\nStill, that doesn't seem to concern the vixen as she continues to cream your twat further, stuffing you so full that your belly button pops out");
	if(pc.biggestTitSize() >= 4) output(" and your [pc.chest] rest heavily upon your cum-stuffed form");
	output(".");
	if(pc.isPregnant()) output("  You may have been pregnant before, but you're beyond pregnant now... with cum AND child.");
	//{Goo:
	if(pc.vaginalCapacity() > 9000) output("  Successive eruptions make you bigger, but your flexible cunt soon grows so bloated that the onrushing injections mostly squirt back out, painting Urta, the bed, and your [pc.legs] white with cum.");
	else output("  Successive eruptions do little to bloat you further - your body is stretched to capacity, so the onrushing injections only squirt back out through your entrance, painting Urta, the bed, and your [pc.legs] white with cum.");
	output("\n\nYour pussy, spent after cumming so long, gives up and goes slack, vacantly allowing fluid to flow in and out.  You're equally exhausted by the ordeal and your heavy womb.  Swaying to the side, you lose your balance and slide off, coming to rest next to the still-spurting fox.  She's pumping her tool hard, spraying semen into the air to rain down over both of you.  The fox revels in it, wildly moaning and thrashing, smearing it into her skin and yours.");
	output("\n\nEven after she finishes painting the walls and ceiling white, Urta flops her drooling member onto your ass and allows it to thoroughly cream your crack.  She rubs it all over your butt, squeezing and kneading your backside as she comes down.  After a while, you roll over and return the favor, massaging the fox with her own orgasmic goo.  You're both white messes, but thoroughly, delectably sated.");
	output("\n\nYou snuggle with the vixen a while, simply enjoying the comfort while your [pc.vagina] drains.  It doesn't completely empty, but your belly-button does pop back in.  You'll probably look ");
	if(pc.isPregnant()) output("even more ");
	output("pregnant for a while, at least until you can pass all that filling!  She plants a salty kiss on your lips ");
	if(urtaLove()) output("and nuzzles against your cheek, just holding you for a few moments, lover to lover.");
	else output("and sheepishly pulls back.");
	output("\n\nClimbing out of the cum-painted bed is no easy task, but the two of you manage, laughing and leaning on each other's arms.  Urta leads you to a cabinet in another room, and bends over to open it.  You barely notice her pulling out mops, buckets, and cleansers.  Instead, your vision is riveted to her cock, still soaked with your juices and oozing a trickle of sperm.  When she comes up with an armload of cleaning supplies, you're ");
	if(pc.slut() < 33) output("blushing");
	else if(pc.slut() < 66) output("grinning");
	else output("openly leering");
	output(".");
	output("\n\nUrta smirks, glancing from your slickening groin up to your eyes, and says, \"<i>Come on, you horn-dog, let's go clean up your mess.  You can help me fill a few condoms later.</i>\"");
	processTime(40);
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	urtaLove(2);
	//if(flags["COC.URTA_FERTILE"] == 1) pc.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
	pc.loadInCunt(urta);
	pc.orgasm();
	pc.slowStatGain("l", 0.2);
	//[Next]
	clearMenu();
	addButton(0, "Next", cleanUpAfterUrtaCreamInjectsYou);
}

private function cleanUpAfterUrtaCreamInjectsYou():void {
	clearOutput();
	if(pc.cor() >= 50 || pc.isAss()) output("You start to duck out, but the disapproving glare the fox gives you makes it clear that you won't be getting any more messy fun unless you stick around to clean it up this time.  Damnit.  ");
	output("With Urta's help, you slowly clean up the mess you two made, nearly clogging the plumbing a few times in the process.  New sheets, pillows, and furs are brought in, and you help her fix her bed.  The floor is mopped, the walls are scrubbed, and the shutters are opened to let in some fresh air.  Thankfully, just about everything is watertight and sealed, likely something she had done to ease situations such as this.  All told, between clean-up and sex, you spend about four hours with her.");
	output("\n\nTenting her apron (the only thing she's bothered to put on), Urta gives you a ");
	if(!urtaLove()) output("wave");
	else output("tender hug");
	output(" and sends you on your way.");
	processTime(90 + rand(60));
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//2. Tailjob/Coiling. This could be under \"<i>messy</i>\" scenes for Condomless Urta.
//Requirements :
//- Naga Body
//- Lover Urta
//- Any gender except for Genderless
//The scene:

private function nagaOnUrtaMess():void {
	clearOutput();
	//output(images.showImage("urta-naga-fuck"), false);
	output("You tell Urta that today, you intend to pleasure her a bit more thoroughly, intimately and in a slightly kinky way, and then maybe have her return the favor, condoms off, regardless of how messy it gets.  She raises an eyebrow, and then you ask her if she'd ever thought about getting off on both ends with the use of your coils.  Her eyes dart open a bit and she seems flustered.");
	output("\n\n\"<i>Ummm, well... You know every part of you is hot as far as I'm concerned, [pc.name], but... I'm worried.  Your tail is certainly a bit strong, and wrapping it around my body, and... and around my cock and pushing it inside me...</i>\"");

	output("\n\nYou calm her down and ask her to trust you, telling you that when you were human, you'd probably be a bit reluctant to do something like this with someone you didn't trust, either.");

	output("\n\n\"<i>Yes, you're right, love... I do trust you, so if you really want to do this, then... let's do it!</i>\"  She seems to ponder something.  \"<i>If we end up making a mess, though, you're helping me clean it...</i>\" she's quick to add, a bit to your dismay.");

	output("\n\nShe seems a bit more confident and eager now as you drop your [pc.gear] on the ground, stretching your coils as you instruct her to lie down.");

	output("\n\nCrawling onto the bed with Urta already on it, you move your [pc.face] close to her head and lean in for a reassuring kiss.");

	output("\n\n\"<i>[pc.name]... go ahead. I'll try to relax.</i>\"");

	output("\n\nSlowly, the serpentine tail wraps around her waist as you allow yourself the pleasure of fondling her breasts while re-initiating that kiss, feeling her lips on yours.  The sensation of her more-than-decent mounds in your hands is rather pleasant, and she seems quite excited with your touch, too, her nipples rapidly stiffening while her equine shaft loses even the hints of floppiness, becoming harder as your tail creeps closer to it.");

	output("\n\nMuch to Urta's surprise, though, your coils do not wrap around her cock immediately; no, they move around it and lower, binding her legs before making a return upwards, the tip of a serpentine tail meeting the flat tip of an equine shaft...");

	output("\n\nUrta gasps, feeling your touch, as slowly you slide your tail down her shaft, starting to wrap it up when you close it at the base.  Your fox lover moans as you start to move the tail up and down her shaft, alternating between the speed and strength of your squeezes and tugs.  Soon, Urta tries to thrust her hips gently as well, and you use the opportunity to grab both her hips and her breasts, squeezing them as you stroke her impressive member with your tail.  A few deeper grabs at her bum prompt her to gasp when you get to feel her wetness, proving that being in your coils is indeed exciting your hermaphrodite lover on all ends, as already suggested by her hard shaft and nipples.");

	output("\n\nYou gently run your hands over her body as you increase the pace of your strokes, before pulling her in for another kiss.  Urta moans into your mouth and you feel her drip more and more pre all over the two of you.  The vixen is the one to break the kiss, oddly, with a complaint.  \"<i>L... lover... neither my pussy nor you are getting any of it like that.  Come on, lemme return the favor...</i>\" she says, prompting you to slightly unbind her and raise before again starting to wrap your tail around her member.");

	output("\n\nUrta immediately bows down over to you, eager to return the pleasure she is receiving, and she runs her fingers along your genital slit, provoking you to open it and set your own sex free.");

	//[if (cocks = 0)
	if(pc.cockTotal() == 0) output("  Urta runs her fingers over and gently pushes into your now revealed female slit. \"<i>My lover's sweet, sweet pussy. The best in the whole world.</i>\"");
	//if (cocks = 1)
	else if(pc.cockTotal() == 1) output("  \"<i>And here is my favorite cock in the whole world... Probably including mine,</i>\" she giggles and winks at you.");
	//if (cocks = 2)
	else if(pc.cockTotal() == 2) output("  \"<i>Two delicious cocks, rather than just one...  You're trying to tell me you're the man here, aren't you, lover?</i>\" she giggles and winks at you.");
	else if(pc.cockTotal() == 3) output("  \"<i>You want to have a spare one just in case or something?</i>\" she giggles and winks at you.");
	//[if (cocks >= 4)]
	else output("  \"<i>Interesting.  It looks like a bouquet.  A beautiful bouquet of cocks just for me,</i>\" she giggles and winks at you.");

	output("  Without further ado, Urta leans towards your sex to return the favor, her mouth pleasuring you just as you wrap more and more of your slightly looser coils around her member, having released her legs to allow her to move... and to allow your tail's tip to reach her needy vulpine pussy more easily from that position.");

	output("\n\nThat, you do, your tail moving over her cum-filled, heavy balls, teasing them as the rest of your organ strokes your lover's impressive member, Urta's body slightly bent, partially laying on her back and partially on her side as she returns the attention given to her genitals back to you.  Without further ado, you press the tip of your tail against her clit, which causes her to yelp and lower her head, submitting to more of what you are providing...");

	output("\n\nFinally, sensing she's wet and aroused enough, the tip of your tail goes into her pussy, right below her balls, while your coils begin clenching, unclenching and rolling over her member, pleasuring in a more teasing manner than before.  Urta quickly regains her focus and attempts an assault of her own.");

	//[if (cocks = 0)]
	if(pc.cockTotal() == 0) output("\n\nYou can feel her tongue sliding all around and pushing its way inside your [pc.vagina], pleasure slowly spreading in your body as well as your hermaphrodite vixen girlfriend goes on to lick and slurp on your womanhood, pleasuring you further and further.");
	//[if (cocks > 0)]
	else if(pc.cockTotal() > 0) output("\n\nUrta grabs your [pc.cock " + pc.biggestCockIndex() + "] and immediately locks her lips around it, her tongue hitting your [pc.cockHead " + pc.biggestCockIndex() + "] and flicking all over it, searching to bring you more pleasure before shes slides her lips across your shaft, prompting you to moan gently in response.");
	//[if (cocks =2)
	if(pc.cockTotal() == 2) output("  After a while of sucking on your [pc.cock " + pc.biggestCockIndex2() + "], Urta lets your shaft leave her mouth with a wet slurp and moves over to pleasure your other cock instead.  Immediately, she starts sucking and then deepthroating your [pc.cock " + pc.biggestCockIndex2() + "], your precum starting to flow more freely into her mouth from that particular erection as well.  She starts to alternate between the two, giving them much needed attention.");
	//[if (cocks >=3)
	if(pc.cockTotal() >= 3) output("  While sucking and slobbering on your [pc.cock " + pc.biggestCockIndex() + "], your vulpine lover reaches out to start stroking two of your other shafts as well, making her best attempt to pleasure each and every one of your members.");

	output("\n\nYour ministrations on Urta become a bit more forceful and frantic, but she seems to be enjoying herself quite a lot, doing her best to intensify the oral and manual assault on your own genitals as you pleasure both of her sexes, the very tip of your tail sliding in and out of her black cunt while your coils work around her equine shaft, now twitching in your serpentine grasp.");

	//if (cocks = 0)
	if(pc.cockTotal() == 0) output("\n\nUrta's licking of your [pc.vagina] and manual teasing of your [pc.clit] is proving to be doing a pretty good job at getting you off.");
	//[if (cocks > 0)
	if(pc.cockTotal() > 0) output("\n\nUrta's manual and oral stimulation of your maleness is bringing the desired effect as you drip more and more precum into her loving, thirsty maw.  You can definitely get off on this....");
	//output("  However, it requires no justification that your herm lover is further on her way to an orgasm then you are.");

	output("\n\nIntensifying the coiling around of her member, squeezing her cock and rolling your tail all over her shaft as you tail-fuck her pussy, you prepare Urta for an intense orgasm she seems unable or unwilling to fight off anymore.  You putting one hand on her head to push her further into your crotch and another on her breast for an affectionate squeeze just seems to make her lose control further, and in a few moments, she explodes.  Her vixen box is wrapped tightly around the tip of your tail, convulsing and releasing liquid in a sloppy cascade.  Her balls are pulsing and churning in-between the two affections of your tail, and you can feel her cock distend and twitch in the embrace of your tail, as Urta comes with a loud groan that sends pleasure into you as well.  Her cum shoots out and flows in powerful waves, painting your tail, the bed, and whichever part of her room you direct the flow to white.  Enjoying the show and your feeling of power proves to be enough of an aphrodisiac to prompt your own orgasm...");

	//if (hasVagina = true)
	if(pc.hasVagina()) {
		output("\n\nYour own pussy is convulsing and twitching as well, Urta's attention proving enough for it to orgasm, drenching some of your tail...");
		//[if (isSquirter = true)]
		if(pc.isSquirter()) output("  After a few convulsions, your [pc.girlCum] starts to shoot out of your pussy quite violently, adding to the mess your lover is making.");
	}
	//if (cocks > 0)
	if(pc.cockTotal() > 0) {
		output("\n\nUrta's constant sucking of your [pc.cock " + pc.biggestCockIndex() + "] proves to be enough to push you over the edge, and you deliver your own offering right into her mouth... She drinks and gulps it, hungrily, eager to please you as well.");
		//[if (cumHigh = true)]
		if(pc.cumQ() >= 1000 && pc.cumQ() < 2500) output("  Her eagerness does end up giving her a swollen tummy, but she's loving and hungry for you until the end, swallowing as much as she can, as quickly as she can.");
		//(if [cumExtreme = True]
		else if(pc.cumQ() >= 2500) output("  Of course, your excessive load proves too much for the poor vixen to handle, and soon she is not only inflated, but painted in your [pc.cum] as well, the mess the two of you are making definitely nothing to be scoffed at.");
	}

	output("\n\nYou continue to stroke her cock and tailpump her pussy during her orgasm, forcing Urta to thrash in your embrace a bit before she finally comes down from her high, licking her lips to taste more of your own fluids.  \"<i>You were amazing, lover... I didn't think it'd feel so good!  But now... we have a mess to clean up... </i>\"");

	output("\n\nAfter a much more tender, if still affectionate couple activity, Urta lets you leave, but not before kissing you and sending you home with a blush.  \"<i>I guess I should let you do more unusual stuff to me more often...</i>\"  She trails off as you march back to your camp...");
	
	if(pc.hasCock()) {
		if(pc.cumMultiplierRaw < 50) pc.cumMultiplierRaw += 0.5;
		if(pc.cumMultiplierRaw < 150) pc.cumMultiplierRaw += 0.5;
		if(pc.cumMultiplierRaw < 500) pc.cumMultiplierRaw += 0.5;
		if(pc.cumMultiplierRaw < 2000) pc.cumMultiplierRaw += 0.5;
	}
	processTime(90 + rand(60));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Lets Lick Some Cum... I mean, uh, fuck pussies?
private function lickOutUrtaAtHome():void {
	clearOutput();
	var x:int = pc.cockThatFits(urta.vaginalCapacity());
	//output(images.showImage("urta-home-selfbj"), false);
	output("When you suggest what you have in mind, Urta ");
	if(urtaDrunk()) output("slurs, \"<i>You want to whaaat?");
	else output("asks, \"<i>You want to do what?!");
	output("</i>\"  She seems taken aback by the request at first, but as the idea slowly worms its way into her, you see her length begin to pulse a little longer and thicker, lifting away from her slightly with enhanced rigidity.  The hungry look in your eyes must be obvious to the herm, because she slowly, sensually lifts her hefty ballsack to show you just how moist her cunt is.  Rivulets of wet lubricants drip from her puffy, black lips onto her bed as she spreads herself open for you and asks, \"<i>You're going to stuff this full of cum?</i>\"");
	output("\n\nYou lick your chops and nod.");
	output("\n\n\"<i>Then I'd better make s");
	if(urtaDrunk()) output("h");
	output("ure I don't make too much of a mes");
	if(!urtaDrunk()) output("s");
	else output("h");
	output(", huh?</i>\" she says, reaching over to retrieve one of her condoms.  The immense latex sheath is extra, extra large but still dwarfed by the size of the dick-girl's lusty flare, already leaking its own special lubricants.  She wrestles with the prophylactic until she gets it rolled around her fat tip, wincing when part of it snaps against her sensitive dick-skin.  The reservoir at the tip wobbles as her pre pumps into it, accelerating in pace as the constricting cock-bondage is completed.  Shining dully in the dim, interior lighting, the massive horse-cock is let go, and it flops back onto Urta's furry belly, the tip landing squarely in her sizable bosom.");
	
	output("\n\nThe vixen purrs, \"<i>Take me already!</i>\" and hefts her large, apple-sized nuts up out of the way to display herself once more.  \"<i>Gimme that cum you promised me!</i>\"");
	
	output("\n\nYour [pc.gear] practically removes itself.  Urta lets her fingers play across her nether-lips as she watches, gathering the moisture and rubbing it over her smooth sack.  She groans aloud with barely contained enjoyment while her emerald eyes shine with affection.  You climb into bed after her, eyes flicking meaningfully towards your crotch where your ardor is on full display.");
	
	output("\n\nThe prick-vixen examines you before she demurs, \"<i>All that, just for little ol' me?</i>\"  Her fingertips hook just inside her labia, and she spreads them wide for you, supporting her slick sack with her thumbs so that you can see deeply into her twitching channel.  \"<i>I'm ready...</i>\"");
	
	output("\n\nYou climb overtop of Urta and allow your [pc.cock " + x + "] to press on into her pussy.  ");
	if (pc.cockVolume(x) >= urtaCapacity() / 2) output("It fits you like a lubricated, stretchy little glove, ensuring every movement will caress her folds.");
	else output("It's nice and roomy, allowing you full control over how you want to press on her inner folds.");
	output("  You push the rest of the way into her cunt and admire the velvety texture of her walls as they close in around you, inner muscles flexing and massaging your [pc.cock " + x + "] as she adjusts to your intrusion.");
	if(pc.cockVolume(x) >= 200) output("   Stretching ludicrously, her cunt dilates with surprising ease.  The elastic lips of her pussy cling oh-so-tightly to your girth as they're spread beyond reason.  Her hips even spread with only a modest bit of pressure and resistance as her passage is distorted, the shape of your [pc.cock " + x + "] visible through her stretched belly as it pushes towards her tits.  You can even make out some of the larger veins.");
	
	output("\n\nThe hermaphrodite lifts one of her ebony nipples up to her midnight-hued lips and suckles it eagerly, writhing in the delight.  You meet her hungry eyes as you gently begin to slide back and forth, reveling in the liquid-hot heat of the vulpine woman's snatch with a lusty moan, pumping your [pc.cockNoun " + x + "] in and out over and over.  Her secretions are running unchecked onto the bedsheets now, and neither of you care.  You grab hold of Urta's neck to pull her away from her nipple so that you can kiss her on the lips, and you flick your tongue into her mouth.  She demurely accepts the passionate tonguing before allowing her own to slide into yours, slithering to the tempo your [pc.hips] set.");
	
	output("\n\nThe bed creaks ominously under your aroused bodies, unable to handle the forceful fucking atop it without groaning in protest.  You're slapping into Urta's sex with such force that her ass is bouncing up off the bed when you pull back, and her tits are wobbling around so hard that she has a hand wrapped under them to keep them from hurting her.  Breaking the kiss, you pant for breath.  Keeping up such a reckless pace is slowly wearing you out, but at the same time, listening to the feminine grunts and moans of pleasure that come from Urta is immensely rewarding.  You grab hold of her condom-wrapped cock and begin to jack it off, gathering up moisture from her drooling box for lubricant.");
	
	output("\n\n\"<i>Ohhh, [pc.name]... I can't... can't hold it in!  Fuck yes, I can't hold it much longer!</i>\" the gray vulpine arches her back, her supporting hand grappling with her nipple like a drowning man would hold on to driftwood, fingertips squeezed so tight her arm shakes slightly.  No longer bouncing around, her balls cinch tight up under her fleshy, black sheath, the skin so taut and shiny with her lubricant that you can see them contracting slightly, trying to expel their load.  Urta's eyes cross, and she babbles, \"<i>Gonna... gonna cum so hard, [pc.name]! Can't... sto-oooohhh gods, here it coooomeessss!</i>\"");
	
	output("\n\nThe slutty fox's pussy clenches down on your [pc.cock " + x + "] the next time you're bottomed out inside her, spreading rippling waves of hot pleasure from one part of your erection to the next.  Her horse-like boner's flat head balloons almost cartoonishly to turn her condom into a tent.  It expands so much that you can hear the thin material stretching, but it holds, for now.  Her urethra expands big enough to push your thumb off of her shaft, huge fat globs pumping through it.  You shift position to hold her just below her bulging flare and slide your thumb back and forth across it.  Urta's eyes roll back, and she screams, \"<i>Ohgodsohgodsohgods, yesyesYES!</i>\"");
	
	output("\n\nSuddenly expanding, the condom's apple-sized pre-balloon doubles in size, with clouds of white cream slowly turning the bubble opaque.  You admire the way her huge loads distend her urethra as they journey through it towards release.  Urta's balls continue to pulse and contract, each time shooting a thick wad of spermy goo into the bulging containment of her condom.  It's grown to be the size of a grapefruit, and shows no sign of stopping its obscene growth.  Urta's screams of pleasure have already devolved into gutteral grunts, matched to the timing of her spurts.  As you thumb the sensitive ridge of her flare, her pussy's contractions become more and more violent.  It's almost like her muscles are clamping down harder to wring the last reserves of spunk from her draining ballsack and prostate.");
	
	output("\n\nThe cum-balloon is so heavy that it's resting between Urta's tits, bigger than either, and the shuddering, post-orgasmic fox abruptly slumps down, weak beneath you.  You lean down to kiss her on the lips, and meet her lidded gaze to say, \"<i>");
	if(pc.cor() < 66 && !pc.isAss()) output("You're wonderful");
	else output("You're the most amazing fuck");
	output("</i>\"");
	
	output("\n\nUrta gives you a dazzling smile, and you resume your hard fucking, teasing, \"<i>Are you ready for a creampie, my little vixen?</i>\"  She smiles wider and nods.  At the same time, she begins to work her muscles again, her exhausted pussy trying its damnedest to milk your dick.  The furry hussy's cock slowly sags inside its latex cocoon.  Shrinking faster than the rest, the flare receeds until it is barely any wider than the rest of her length, and some of the cum begins to leak out around her semi-turgid shaft, pooling in her sheath and on the sagging skin between her spent orbs.");
	
	output("\n\nYou squeeze her breast and hump her faster and faster, until you're plowing her sodden pussy as fast as you were before, causing the poor vixen to shake, her filled jizz-balloon sloshing wildly.  Her hot, silken tunnel squeezes you rhythmically as you fuck her, and in no time, you find yourself cresting the same fantastic hill your pet fox so recently climbed.  You squeeze Urta's breast affectionately as you hilt inside her one last time and release, spastically jerking your [pc.hips] as you pump your warm spooge straight into her puffy, soaked snatch.");
	if(pc.cumQ() >= 500) output("  Spermy juices run out of her pussy in [pc.cumColor] streams thick enough to obscure the black-lips they're travelling over.");
	if(pc.cumQ() >= 1500) output("  The fox gives a surprised grin when her belly rounds slightly, though she seems concerned at how it makes her cum-filled prize wobble.");
	if(pc.cumQ() >= 3000) output("  Your virile pecker just won't stop, and by the time you finish ejaculating, Urta is pregnant with sperm, her belly round with its belly-button protruding.");
	
	output("\n\nSharing an intimate moment with your ");
	if(urtaDrunk()) output("drunken ");
	output("lover, you kiss her again.  She returns it demurely, but midway through, you feel something slick and hard brushing up against you.  Urta whispers, \"<i>Sorry,</i>\" when you pull away to examine the sudden change.  Her pole is hardening again, surging up to rub the full prophylactic against your [pc.chest].  You glance back at her, and all Urta has to say for herself is, \"<i>Sorry, lover... feeling you cum inside me is wonderful, and well, I had time to recover.</i>\"  She slowly pulls the rubber off her cock, careful not to jostle it too hard.  A second later, it's tied off and set aside.  With you still ");
	if(pc.hasKnot(x)) output("knotted");
	else output("resting");
	output(" inside her juicy cunt, she asks if she needs another one, batting her eyelashes playfully.");

	output("\n\nShaking your head from side to side, you pull back");
	if(pc.hasKnot(x)) output(" in an attempt to withdraw.  Her entrance dilates slowly as your knot is pressed against her from inside, the pulsating flesh glistening with the mixed sexual lubricants.  You tug and tug, rocking your [pc.hips] slowly to loosen her up, and eventually, you manage to pop out, drawing a moan of mixed anguish and pleasure from Urta's maw.");
	else output(" and withdraw.");
	if(pc.cumQ() >= 1500) output("   [pc.Cum] runs out of her packed womb in a wave, spreading all over the sheets down to her knees.  She shakes slightly as the [pc.cumNoun] runs out of her, rubbing her full middle protectively.");
	else output("  [pc.Cum] drools out of her still-gaping slit in steady trickles, puddling on the sheets below.  She groans happily.  Clearly the fox is proud to have such a productive lover.");
	output("  You take hold of the puffy, dick-stretched pussy lips and spread them around two fingers, collecting some of the warm sex-juice on your fingertips, then, you pull the dripping, [pc.cumVisc] treat out and smear it over Urta's mouth.  She giggles as you apply the lip gloss to her and slowly runs her tongue across the shining coat of sex.  You respond by repeating the motion, this time laying it on thicker.");
	
	output("\n\n\"<i>This is all the lipstick you'll need today, babe,</i>\" you explain as you admire the way her [pc.cumNoun]-stained lips shine.  She's marked with your ejaculate and sure to have cock on her breath for hours.  Turning back to the glittering box below, you raise her balls and lean down under them, letting them fall into place on your [pc.hair] once you're in position.  You blow on the dripping cunny, and Urta moans lustily in response.  Then, you promise, \"<i>You're going to be satisfied after this.  Your dick and cunt are gonna cum so hard you won't be getting it up for days.</i>\"");
	
	output("\n\nUrta's thighs scissor around you affectionately.  She starts a snarky response, but you dive right in, silencing her objections by virtue of sloppy strokes with your [pc.tongue].  Her own feminine taste mixes with your [pc.cumFlavor] flavor on your taste buds as you service her pussy, bringing a hand up to rub across the sides of her puffy entrance, feeling the moist heat that radiates from her sodden snatch.  The scent of sex hangs heavily in the air as you service her, accompanied by panting, female moans from higher up.  After you find her clit and begin to lick it, her own juices begin to run more freely, and you feel her balls getting heavier above.");
	
	output("\n\nShifting position, you tip your head back and lick across the underside of her ballsack, smearing first one and then the other with your cunt-tainted saliva.  You suckle their huge, rounded surfaces, nearly dislocating your jaw as you attempt to handle their heavy bulk.  Reaching up, you wrap your fist around her boner and begin to caress up and down its length.  The slimy jizz that leaked out through her condom makes the handjob wet and slippery, allowing you to pump her hard and fast.  The herm's hips begin to lift with your caresses, and whenever her balls shift away, you tongue her clit rapaciously.");
	
	output("\n\n\"<i>Oh gods, I can feel it... you ARE gonna make me cum hard!</i>\" Urta pants breathily before pulling your face against her slick gash.  You take the opportunity to slide your tongue all around the insides of her velvet tunnel, smearing the sex-juices deep into every crevice, the hot passage fluttering around your skilled, oral pressure.  Jacking her off, you increase the speed of your strokes and start to slide your thumb back and forth across her urethral bulge.  Urta whimpers softly and pulls you harder against her mound.  Her black cunt-lips smush up around your lips and smear your [pc.face] with juice, leaving you to inhale the overwhelming aroma of a greatly aroused female.");
	
	output("\n\nYou take her sack in your free hand and squeeze softly on the whimpering fox's balls.  She squeals, and you feel the heavy weight shift in your hand.  Gushes of sweet moisture spray onto your tongue, and pinned as you are in her wet pussy, you're forced to gulp it down, barely keeping up with the outpouring of juicy girl-gunk.  A familiar pressure fills her cock's bulge, and her flare expands just in time for the onrushing cum to leap out of it.");
	
	output("\n\nThe lusty fox bends double, sweeping the blunt, spurting tip into her lips, swallowing down her load rather than letting it spray everywhere.  You squeeze her bulge again while tracing your other hand down into her sensitive sheath, smearing slippery cum around every crevice of her folded skin.  The result is an even bigger ejaculation, one that floods Urta's cheeks past capacity.  A river of it begins to roll out from her mouth, and it pools into her stretched sheath before rolling down across her balls.  Spasming with bliss, her thighs convulse apart far enough for you to escape the heated tunnel, just in time to get a mouthful of her jizz-drenched sack, tasting her cum while the odor of her pussy is fresh in your mind.");
	
	output("\n\nYou put both hands on her cock as you pump spurt after spurt into the fox's mouth.  Amazingly, she swallows down most of it, but not without leaking a few thick strands of jizz into the mess below.  Every stroke squeezes out a nice, fat wad into Urta's stuffed muzzle, forcing her to taste herself as her eyes roll with wild, orgasmic delight.  Her whole body is shaking, and her nipples look as hard as diamonds from down below.  You milk her long and hard, eventually darting back to polish her onyx snatch with your spit, depositing long, lewd licks all over her spasming womanhood.  She keeps gushing all over the bedsheets for what seems like ages, and you don't let up until every single drop of cum has been squeezed down the vixen's throat or dripped from between her legs.  Somehow, her vagina's drippings are still tinted white with your jizz, and you find yourself smiling when you realize how deeply you must have shot most of your load.");
	
	output("\n\nThe fat flare pops out of Urta's mouth abruptly, connected by a string of spunk for a split-second before it snaps back onto her tongue.  \"<i>You were right, [pc.name],</i>\" she pants out in exhaustion before flopping back.  \"<i>I don't think I have a drop left...</i>\"");
	
	output("\n\nYou rub her spent balls affectionately as you wipe your mouth, and tell her, \"<i>I told you so,</i>\" before climbing up next to her and snuggling with her while she comes down from her orgasmic high.  Urta smiles, her lips painted with a mixture of your cum and hers, and you realize she's really going to leave it on all day.  You tenderly hug her and fondle one of her breasts as you languish in the afterglow with her, only splitting up when you realize that you both have things to attend to.");
	//Urta no lust ALL day.
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 12;
	//Boost dick confidence
	Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY", 3, true);
	//Boost love
	urtaLove(3);
	//Drain lust, slimefeed, reduce libido
	processTime(40 + rand(15));
	pc.orgasm();
	pc.loadInMouth();
	pc.girlCumInMouth(urta);
	knockUpUrtaChance();
	pc.slowStatGain("l", -2);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

internal function slurpFawkesCocksForFunAndInflation():void {
	clearOutput();
	//output(images.showImage("urta-home-bj"), false);
	output("\"<i>Thanks, Lover! I need this. I've been so busy, I haven't had any relief in days!</i>\" Urta informs you as she lightly strokes herself to full erectness. It's a short trip, and in a few pumps, she's ready to go. You glance around the bar, making sure all possible prying eyes are occupied. Feeling satisfied with your findings, you slyly shuffle your way under the table.");
	
	output("\n\nYou sigh as you look at Urta's massive prick, half for the impending satisfaction, half for the challenge. You can smell a salty aura emanating from her organ, making your eyes heavy with need. A voice in the back of your mind reminds you of the taste of semen. The invisible texture rolls over your tongue, the saltiness tingles against your taste buds, the heat spreads to the walls of your mouth...");

	output("\n\nUrta throatily moans as you are hauled back to reality. As you open your eyes, you realize that you've taken the first several inches of her shaft and have been gulping down her pre. The rickety clink of a glass being placed on the table overhead reminds you that Urta is expecting some ecstasy too, so you begin bobbing down upon what's already found its way into your mouth. More of her pre-seed bubbles its way down your waiting throat as you slide deeper and deeper on to her, her head bumping the back of your throat with each thrust.");

	output("\n\nYou hear an audible gasp from Urta as she tries to disguise it by taking a loud gulp of her drink. Silly herm. You know better than that. You decide to not prolong her agony any further and with a deep breath, you push her down your throat. You can feel her knees on either side of you lock into place for a moment as she catches a gasp between her teeth and lower lip. As you continue to bob, you keep one hand locked around her base, pumping what you can't suck down. With your free hand, you reach past her testicles and give her clit a taunting flick, forcing her to lock up once again.");

	output("\n\nA shadow covers you, making your heart leap before realizing that it's a barmaid.  \"<i>Hey Urta, slammin' 'em back awful quick, aren't'cha?</i>\" the barmaid says, poking some fun at the guard, \"<i>Maybe I should bring 'em out in pairs, huh?</i>\"");

	output("\n\n\"<i>THANKS g-girl.  Maybe you shOULD!</i>\" Urta reels back, obviously too distracted to have a concise retort.  You mentally chuckle, taking her a bit deeper and moving further down her body, dipping three fingers deep into her soaking pussy.  A small, rippling quake starts at her loins and jostles its way slowly up her form, rebounding off the top of her scalp before trailing its way back through pleasure-charted territory.  When it reaches her tip, now lodged deep in your throat, all the seed that had previously occupied her urethra spills into your stomach.  Suddenly, you feel Urta's hand on the back of your head, forcing you to her base.  From your new vantage point you look up - directly into the waitresses eyes.  She gives you an alluring smile, winking and bringing a finger to her lips as if to say \"<i>Don't worry: I won't tell anyone,</i>\" before humming lightly to herself as she walks away.  You push against Urta's hand just enough to return your visage to your hiding spot in the shadow of the table.");

	output("\n\nYou begin to wonder why no one else has noticed you as you begin to move on Urta again.  Looking up at her frozen face makes you wonder if you have her so engrossed in pleasure that she can't do anything but sit there petrified.");

	output("\n\nAnother pulse dominates her body. Her mouth slowly moves open, further and further, enough to make anyone who looks her way think she's drunk or daft.  The hand on the back of your head forces you down once again and you can feel her urethra dilate.  \"<i>Here it comes,</i>\" you caution yourself seconds before the first jet pries your jaw open slightly more as her seed travels through her tube.  It erupts into your throat, propelling itself into your stomach, another jet right on its heels.");

	output("\n\nAs the tenth pump pierces your form, you begin to feel very full, but Urta shows no signs of stopping as she continues to squirt her saved-up storage into you.  You keep drinking her down, sucking lightly, wanting more. You feel a strange tickling at your waist.  You look down, as best you can, and realize your abdomen has slightly distended!   The eleventh pump extends it more, the twelfth even more...");

	output("\n\nYou begin to lose count, begging the gods not to let your belly burst as it crosses its fifth new inch of bloated liquid.  Urta slides out of your throat, forcing you to swallow the cloying jism it leaves behind.  Of course, as full as you are, you can't keep up, making some of it begin to run out the corners of your mouth and down your swelling form.  Eventually, she subsides, dribbling her last over your tongue.  Unable to swallow any more, it streams out, pooling between your [pc.legs].");

	output("\n\nYou survey your new condition, finding your stretched belly modeled more towards a nine-month pregnancy");

	if(pc.isPregnant() && pc.bellyRating() > 25) output(" than it already was");
	output(".  You slide your way back into your seat with some difficulty, fighting the wriggling, bouncing mass that is your stomach over the now shrinking room between the seat and table.  By now, some of the patrons have realized what has happened, pointing, whispering, rubbing their stomachs, and pulling their hands away from each other to symbolize your new... asset.");

	output("\n\nYou lift your equipment up off of your belly, making your breaths come a little fuller, but simultaneously showing off your cum-laden orb.  You glance at Urta, who blushes.  \"<i>Oh, honey!  I'm so sorry!  I just hadn't... I mean I never expected...</i>\"");

	output("\n\nYou reassure her that it's okay, you were pretty much asking for it, you laugh.  Her face lightens up as she gives you a soft, careful hug.  \"<i>Thanks, lover,</i>\" she whispers in your ear, \"<i>You're the best a girl could ask for.</i>\"");

	output("\n\nThe waitress approaches as Urta releases you, glancing around the bar at the commotion, \"<i>Quite a scene ya caused, " + pc.mf("cutey", "girly") + ",</i>\" she looks at your stomach, \"<i>Would you like anything to, uh... wash that down with?</i>\"");

	output("\n\nThe concept of taking in more fluids is a bit too much for you, making you cringe and nearly lose your... 'lunch'.  You shake your head and thank her, but refuse the drink.");
	output("\n\nYou say goodbye to Urta as you head back towards camp, your stomach sloshing with each step.");
	pc.lust(10 + pc.libido() / 10);
	pc.loadInMouth(urta);
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] += 3;
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 5;
	urtaLove(2);
	if (rand(2) == 0) Mutator.modThickness(pc, 100, 2, true);
	if (rand(2) == 0) Mutator.modTone(pc, 0, 2, true);
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//So I Heard You Don't Allow Vore in Your Game!
//Available from Urta at home menu "Goo Fuck"
//PC must have goo legs, goo skin, goo hair, etc.
//If Edryn is pregnant, Olivia the guardswoman takes her place
private function urtaGooTesticleVoreRuinedOrgasms():void {
	clearOutput();
	//output(images.showImage("urta-goo-fuck"), false);
	output("You tell your vixen lover that you've got something a bit... special in mind this time.  You surge up onto the bed and gently flip Urta onto her back.  Her horsecock bobs enticingly in front of you, already as hard as ");
	if(!silly) output("a steel rod");
	else output("Marethian algebra");
	output(".");

	output("\n\n\"<i>What do you have in mind?</i>\" she asks curiously.");

	output("\n\nYou tell her she'll find out in due time, but for now she should relax and let you work.  You wrap your gooey hands around her beastly cock, rubbing up and down the length of it.  You run your fingers all over its little bumps and ridges, while tracing the mottled patches of pink.  Your hermaphrodite lover shivers and squirms under you, her eyes meeting yours with a demanding look.");

	output("\n\nNot one to disappoint, you grip her sizeable horsecock firmly and furrow your brow.  You let your mind drift down, concentrating on the sensations coming from your hands.  Your fingers and thumbs begin to reshape, merging into one another, until they are nothing more than an amorphous blob wrapped around Urta's cock.  She looks a little surprised at this, but says nothing, so you continue.  You focus your energy, creating dozens, then hundreds of little cilia on the inside of your \"hands\".  The sudden surge of sensations you get from them makes you wobble uncertainly for a moment, and it feels as if the inside of your hands has become the inside of a very sensitive vagina. The cilia wiggle and caress the impressive chunk of horsemeat in front of you, up and down you stroke, getting little gasps of pleasure from both your vixen lover and yourself.");

	output("\n\nYour herm lover's hips buck softly against your gooey onahole, making you tremble just a little bit more with the sensation of being fucked.  This isn't the surprise, of course.  That is about to come.  You move your hands up further on Urta's turgid mass, until your goo flows over her flare, fully encompassing the tip of her cock.  You set to work, licking, stroking and pleasuring her with the tiny cilia.  The sensation of flavor suddenly spreads through you as you realize you can <i>taste</i> her cock, through your hands.  Just another benefit of being a goo-" + pc.mf("boy", "girl") + ", you figure.  You eagerly consume the pre-cum drooling from her, giggling when you see the clearish liquid floating around inside your hands.");

	output("\n\nUrta's groans grow louder now, more insistent, as though she's already getting ready to blow her load.  Well that just won't do.  If she can't hold it this long, she's going to need a little... assistance.  You concentrate again, urging the cilia around the horsecock's tip to converge on its center, on the winking hole leaking pre-cum.  They surge forth, plugging Urta's urethra so quickly she actually jumps, startled by this sudden action.");

	output("\n\n\"<i>What, what are you doing, [pc.name]?</i>\" Urta asks, her eyes widening as your goo inside her transforms into a plug.  \"<i>Ahh,</i>\" she gasps, \"<i>don't stop!</i>\"");

	output("\n\nYou chuckle to yourself.  If she likes that, you wonder, how far can you go?  You enlarge and deepen the plug, while having your goo-hands pulse around Urta's cock, as though she were fucking an ona-hole.  The fox writhes under you, biting her lip and whispering inscrutable words.  You allow more of your goo entry, pouring in several inches of it, delighting in the tight feeling you get.  You squeeze her shaft and rub, amazed that you can feel the pressure even from the inside.  You detach your hands from one another, letting one remain as a cilia-laden tube stroking up and down the length of Urta's horsey-member.  The other returns to normal, with your index finger lodged right in Urta's pee-hole.");

	output("\n\nAnother finger slips inside, widening the hole even further.  You slowly finger the herm this way, pulling back slowly before pushing in with your gooey digits.  Each movement elicits a whimper of pleasure from her.  As you add a third finger, Urta bites down on a knuckle, her eyes rolling back in her head.  Her equine shaft throbs and wobbles, balls tightening.  You know what's coming.  Or more accurately, WHO's coming.  You reshape your fingers into a plug just in time as Urta cries out, thrusting her hips forward.  You feel a splash of warm liquid against your fingers, and it still amazes you that you can <b>taste</b> her cum from where it is.");

	output("\n\nUrta's orgasmic cry is cut short and a look of frustration appears on her face.  As turned on as she is right now, she's not going to get any satisfaction with you lodged inside of her.  The hot cum bubbles and presses against your fingers, so you widen the plug, which only serves to turn Urta on even more.  Eventually the ruined orgasm begins to recede, and with it comes a wave of suction.  You relax your goo fingers, allowing them to be sucked further down into the sixteen inch column of cock.  A fourth finger disappears with this sudden pull, followed by your thumb.");

	output("\n\nThere's a look of trepidation that crosses your face, travels the intervening distance and plasters itself all over Urta's.  Your entire hand is inside her cock.  You wiggle your fingers around, which wipes away the look your vixen is giving you, replacing it with some cross between pleasure and torment.  Again, she mutters under her breath, \"<i>D-don't... stop...</i>\"  You don't plan on it.");

	output("\n\nYou pump your hand in and out, visibly distorting Urta's shaft.  It bulges obscenely, though it seems to be relatively painless.  With every push you go just a little bit deeper, just a little bit further.  You've almost reached the base of her dick when you get up to your elbow.  You have to reposition yourself, urging Urta to sit up and rest against the headboard of her bed.  This grants you a better angle; you can push forward, past your elbow.");

	output("\n\nThe mismatched woman squirms beneath your ministrations once more, cum splashing against your fist.  It feels bubblingly hot, this close to the source.  The surge presses against you, and it takes some effort to hold it back, but Urta eventually grunts with the frustration of another ruined orgasm.  The surge of warm baby-batter subsides, and once more it comes with a sudden vacuum, pulling you further in.  Before you can even brace yourself, you're sucked down to your shoulder.");

	output("\n\nThis sudden motion causes Urta to cry out in orgasmic ecstasy a third time.  Yet another ruined orgasm laps at your fingers before sucking you deeper.  Your fluidic body gives little resistance, and instead of simply stopping at your shoulder like the laws of physics would dictate, your body begins to reshape, getting pulled deeper into the cock.  You feel a little like a piece of jelly getting sucked through a straw, which suddenly seems incredibly accurate.  Your vision goes dark as a fourth ruined orgasm takes your head.  You're pulled deeper and deeper, your body getting hotter and wetter as you go.");

	output("\n\nA fifth.  A sixth.  Urta shudders and rolls as her body is wracked with rapid-fire orgasms, and each time she is denied the blissful release.  With a seventh ruined orgasm, the last licks of air disappear from your legs as your entire gooey body is enveloped.");

	output("\n\nIn the darkness, you can't tell what is what, so you simply relax, allowing your body to flow whatever way Urta wills it.  You feel your body settle down in two tight, spherical pouches, your waist bridging the space.  You're in Urta's testicles!  You can only imagine how she looks right now.  Her balls must be gigantic, and likely uncomfortably full.  Semen splashes around you, soaking into your gooey skin, letting you taste its salty-sweet flavor.");

	output("\n\nYou feel Urta's body shift around a few times, her legs bumping into your new \"home\" as she struggles to get comfortable.  Then, surprisingly, you can hear muffled snoring.  After being subjected to ruined orgasm after ruined orgasm, Urta just fell asleep!  Figuring there's not much you can do about it from in here, you relax your body as well.  As you calm down, you feel your body beginning to lose its shape.  If you think about it, you can regain your form, so rather than worry about it, you let yourself soften, mixing with Urta's spunk as you too drift off into a peaceful sleep.");

	pc.lust(pc.lustMax(), true);
	processTime(6 * 60 + rand(2 * 60));
	//Next
	clearMenu();
	addButton(0, "Next", urtasRuinedOrgasmsFromGooPartII);
}

private function urtasRuinedOrgasmsFromGooPartII():void {
	clearOutput();
	//This is just getting weird as fuck now. There will be no images for this... how could there be?
	output("You awaken the next morning to a panicked shout.  You bolt upright...  Or at least you try to.  Something is holding you tight, binding you in place.  You try to open your eyes, but nothing but blackness surrounds you.  Struggling, you try and wrench yourself free of your bindings.");

	output("\n\n\"<i>What the hell...  [pc.name]?!</i>\" comes the voice of Urta.  It's strange, as if it were somehow distant and at the same time right next to you.  You feel a soft patting sensation on your bindings, and then it hits you.  You're still inside Urta's balls!");

	output("\n\n\"<i>Well, this is certainly different,</i>\" Urta says, patting her engorged ball sack again.  The contact makes you shiver with a sudden burst of pleasure, as if your entire body had become an erogenous zone.  \"<i>Oooh. Ooooh, damn this feels good.</i>\"  She places a hand on her massively inflated balls, which you feel right above your crotch.  Urta traces little circles over the area with her fingers, bringing powerful sensations to your hyper-sensitive liquid body.");

	output("\n\nYour body feels warm and tingly, encased as it is in Urta's tender sack.  A deep <i>bump-bump... bump-bump</i> resonates within your body, confusing you for a moment until you realize it's Urta's heartbeat picking up.  The rhythmic beating relaxes you deeper, causing your body to sink further, filling every nook and cranny.  You're so relaxed by this, you barely notice the soft schlicking noise coming from somewhere above you.");

	output("\n\n<i>Schlick...  Schlick...</i> it goes.  With each wet noise you feel a bit more pressure surrounding you.  With each <i>schlick</i>, Urta's balls wrap more tightly around you.  But the heartbeat is so relaxing, so hypnotic that you can't seem to care.  The tighter it gets, the more your body aches for it, the more it <i>needs</i> it.  The pressure builds and builds around you, your temporary home growing tighter and tighter.  You realize, with some alarm, that it's not merely Urta's balls tightening, but also a bevy of fluids pouring in from somewhere that's constricting you.");

	output("\n\nYou feel your body absorbing this new liquid, tasting it, and recognizing it as your fox lover's cum.  The spooge continues to rush in, filling you up with her salty-sweet goodness.  The walls around you quaver, clutching you so tightly your sensitive body seems to alight with pleasure.  You hear a cry above you, stifled, you imagine, with a lip.  After a minute, the tightness seems to fade, and with it comes a sigh, half relief and half frustration.  A hand descends on your fleshy prison, rubbing through to your body, making your gooey body burn with passion again.");

	output("\n\n\"<i>I can't quite get off with you in there, [pc.name].  But I'll be damned if you're going to stay in there all day,</i>\" comes the voice of your foxy friend.  You wonder what she's planning, but then the shlicking noise returns.  It seems she intends to masturbate until you finally \"come\" out.");

	output("\n\n<b>Several hours later...</b>");

	output("\n\nUrta's sack tightens around you once more.  Orgasmic bolts of electricity fire throughout your amorphous form.  Your body swirls and quivers, trying to take on a form fit for release, but no matter how you twist, there simply isn't enough space for you to take on your normal form.  You simply can't get your release.  Again you feel a sucking sensation, attempting to pull you up and out of your fleshy prison, but as with the last dozen or so times, it simply doesn't have enough power to do so.");

	output("\n\nUrta gives a frustrated growl somewhere above you.  \"<i>Marae damn it!</i>\" she exclaims, putting her hands on either side of you.  \"<i>Get out of there!</i>\"  You try to give her a reassuring grunt, that you're trying to do your best, but without a face, let alone a mouth, it's impossible.  The horsecock-endowed girl sighs, and then the schlicking noise returns.");

	output("\n\nYour mind reels, how many times have you gone through this?  Twelve?  Fifteen?  Hours upon hours lost within these two balls.  Anything either of you try to do simply doesn't work.  Urta's tried masturbating with either hand, then both.  She's tried it in the shower, and though the warm water felt good running over your cage, it was no more useful.  She's tried every possible position, every possible method...");

	output("\n\nThere's a knock at the door and you hear a ");
	var edrynAvailable:Boolean = !edrynisPregnant();
	if (edrynAvailable) output("set of hoofsteps");
	else output("pair of footsteps");
	output(" enter whatever room you're in. \"<i>Hey, Urta, you haven't shown up for your shift today so...  Great googily moogily!  What happened to you?!</i>\" a voice you ");
	if (edrynAvailable) output("recognize as Edryn's");
	else {
		if(flags["COC.MET_OLIVIA"] != undefined) output("recognize as Olivia's");
		else output("don't recognize");
	}
	output(" shouts.");

	output("\n\nWait a second...  That's something you haven't tried yet.  You've tried every masturbation technique known to man, but not actual sex!  While Urta's explaining her predicament to her fellow guardsman, you start churning, sloshing this way and that trying to get her as excited as possible.  She gives you a soft slap mid-sentence, then gasps and says, \"<i>Ohhh, I get what you're trying to tell me now.  ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(", I'm going to need your help with this particular problem.</i>\"");

	output("\n\nThere's a moment of silence, and then, \"<i>");
	if (edrynAvailable) output("All right, but I'm still charging you for this one");
	else output("Uhm, yes Captain, whatever you need");
	output(".</i>\"  You hear armor falling to the ground while Urta rises from wherever she was sitting; you've been all over the house so many times it's hard to keep track of where you are.");

	output("\n\nUrta wastes no time sinking her huge horsecock right into ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output("'s cunt, if that wet squelching noise is any indication.  She thrusts all the way in inside in one go, making ");
	if (edrynAvailable) output("Edryn moan in pleasure");
	else output("Olivia shout with surprise");
	output(".  Clearly, Urta's not messing around anymore.  She pulls out and thrusts back in, and with that thrust you sway, slapping into ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output("'s underside.  The contact is electric.  The rough slap would have sent shivers down your spine, if you'd had one.  It makes your body quake and convulse with gusto.");

	output("\n\nAnother thrust, and there's the slap.  It lights your body with orgasmic fire, like you've never felt before!  It's so much more powerful than, say, your ");
	if(pc.hasCock()) output("cock");
	if(pc.isHerm()) output(" or ");
	if(pc.hasVagina()) output("pussy");
	if(!pc.hasGenitals()) output("asshole");
	output(".  Your entire, gooey body feels like one giant clitoris, so sensitive, so vulnerable to pleasure.  With every slap, your body begins to crave release even more.  The pleasure builds with every thrust and accompanying slap.  It grows to the brink of orgasm, and surges forward, with no end in sight.");

	output("\n\nIt's almost uncomfortable, your whole body wants to cum, <i>needs</i> to cum, but you can't.  Not stuck like this, you can't.  You feel as if you've been denied orgasm for weeks, or months.  You're just so worked up, you can't even think straight at this point.  You can't imagine Urta is much better right now either.  She's pumping in and out erratically, trying get that relief that you so desperately desire as well.");

	output("\n\nUrta's walls constrict you again, only adding to the blissful feelings infusing your body.  They grow tighter and tighter, pulsing around you, tightening in anticipation.  Your foxy friend gives a grunt somewhere in-between desperation and frustration, and with it you feel the familiar suction.  It pulls at you, and you push towards it, wanting the relief just as much as Urta does.  With one final thrust, the suction picks up and you have no choice but to go along with it this time.");

	output("\n\nYou're pulled, whether you want to or not, back up through Urta's cock, no doubt making it bulge obscenely along the way.  It pulses and spasms while your mind reels from the sensations.  You can't tell how long it takes, Urta's cock remains stationary, jerking wildly, cumming you out.  Your perceptions shift ever-so-slightly as what is likely your head seems to be the last to go.  It's uncomfortable and strange, but at least you'll be free of those balls.");

	output("\n\nThe last of your ooze-body spurts out with a moist popping sound, and with it comes relief.  Not orgasmic relief, unfortunately, as your body still seems to be in the throes of ecstasy, but relief of being free once again... Except, oh crap.  You forgot that Urta was balls-deep inside ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(".  Your eyes search around, seeing nothing but darkness once more.  You extend your gooey self, trying to tell where you are.  Wherever it is, it's tight... and there seems to be some sort of plug holding you in.");

	output("\n\n<b>You're inside ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output("'s womb!</b>");

	output("\n\nYou hear a muffled sigh of relief from Urta, followed by the sound of a couch creaking. \"<i>Oh thank Marae</i>\" she says thankfully.  \"<i>Oh damn. Are you going to be able to get out of there?</i>\"  You feel a pair of hands surrounding you, though this time the surge of pleasure you get is much smaller.  Perhaps the thicker walls are to blame.");

	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(" voices her displeasure, \"<i>What the... I look like I'm pregnant!  With septuplets!</i>\"");

	output("\n\nUrta lets out a nervous chuckle.  \"<i>Sorry about that.  But this should be easier to deal with.  ");
	if (edrynAvailable) output("All you need to do is push, right?");
	else output("Let's just sit you back, and then all you need to do is push.");
	output("</i>\"  Your new host grunts in discomfort");
	if (edrynAvailable) output(", but obliges, sitting back on something, perhaps a bed.  You feel yourself sloshing around oddly as she lies on her back");
	output(".  \"<i>Now push,</i>\" Urta says, encouragingly.");

	output("\n\nYou feel a sudden tightness around you, tighter than even Urta's balls got.  It clenches you, reigniting the pleasurable spark within your body.  The tightness wavers, and with it you hear panting from above, and then it returns just as quickly as it went. Breathe, breathe, push, it goes.  You push yourself towards the exit as well, trying to hurry this along as much as you can.  It takes several minutes, but soon her cervix dialates and you're able to squeeze yourself out, towards a soft pinkish light.");

	output("\n\nYou ooze out with every push from ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(".  The first thing out, thankfully is your head.  Bright light greets your eyes, almost stinging them.  You look around, seeing ");
	if (edrynAvailable) output("Edryn clutching Urta's hand");
	else output("Olivia lying back on the bed, clutching Urta's hand");
	output(", panting heavily.  You surge outwards, first your shoulders, followed by one arm, and then the next.  The rest of your body comes out like a flood with one last push from your former host, sending you splattering onto the ground beneath you.  An exasperated, but relieved, sigh comes from ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(", one that you share.");

	output("\n\nYou take a minute to collect yourself, letting your ooze-like body reform.  Slowly it comes back, naturally returning to its original state.  You twist your neck, spine and joints, relief washing over you.");

	output("\n\n\"<i>Look, ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(", it's a ");
	if(!pc.hasGenitals()) output("...THING");
	else output(pc.mf("boy", "girl"));
	output("!</i>\" Urta says with a laugh, clapping her companion on the shoulder.  You chuckle with her, though ");
	if (edrynAvailable) output("Edryn");
	else output("Olivia");
	output(" doesn't seem to find it as funny.");

	//First time seeing Olivia?)
	if(flags["COC.MET_OLIVIA"] == undefined && !edrynAvailable) {
		output("You turn your attentions to your new \"mother,\" sitting panting on the bed.  You've never seen her before, but the armor that sits nearby is similar to Urta's.  You figure she must be Urta's temporary partner while Edryn is on maternity leave.  Olivia's a canine morph, though only slightly.  Her legs end in wolf-like paws, a long fluffy tail sticks out from under her, and a pair of ears perch on top of her head.  As you look at her, she blushes bright scarlet and moves to retrieve her gear, obviously embarrassed to be seen in such a compromising position.");
		IncrementFlag("COC.MET_OLIVIA");
	}
	
	//(Goo skin not white?)
	if(pc.skinTone != "milky white") {
		output("\n\nThen you catch sight of your body...  You hold up a hand in surprise.  Your skin has changed color!  Your time inside Urta's balls has taken its toll, it seems.  <b>You now have milky white skin!</b>");
		pc.skinTone = "milky white";
	}
	pc.cumMultiplierRaw += 10;
	
	output("\n\nUrta and ");
	if (edrynAvailable) output("Edryn");
	else output("a newly dressed Olivia");
	output(" collapse onto the couch, exhausted.  \"<i>Gimme ten minutes, then we'll go on patrol,</i>\"  Urta says waving a hand tiredly.  You grin and take your leave, slipping out the front door and heading back to camp.  The sun blazes high in the sky, around noon, so you've lost about a day stuck inside one person or another.");
	
	processTime(3 * 60 + rand(60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	
	// load EVERYWHERE
	pc.loadInMouth(urta);
	pc.loadInMouth(urta);
	pc.loadInMouth(urta);
	pc.loadInAss(urta);
	pc.loadInAss(urta);
	pc.loadInAss(urta);
	if (pc.hasVagina()) pc.loadInCunt(urta);
	if (pc.hasVagina()) pc.loadInCunt(urta);
	if (pc.hasVagina()) pc.loadInCunt(urta);
	if (pc.hasTailCunt()) pc.loadInCuntTail(urta);
	if (pc.hasTailCunt()) pc.loadInCuntTail(urta);
	if (pc.hasTailCunt()) pc.loadInCuntTail(urta);
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Urta's Place
//Added just before the line "For someone as ashamed of her desires as Urta was, she sure is terrible at hiding her kinks."
//Urta must be at Lover status and completely comfortable with her cock. PC can't be a naga, centaur or drider.  This is the two-legs only club! PC must also have some kind of genitals.

//if(flags[kFLAGS.URTA_PETPLAY_DONE] == 0 && urtaLove()) output("  <b>A new, shiny leather collar lies half-concealed under a cushion, as though its owner haphazardly tried to bury it in a rush.</b>");

//Adds "Collar" to the sex menu.

//Collar
//Choosable from the main sex menu.
//Two different intros to this scene, one first-time and one repeat.
private function urtaPetPlayDeletedForeverBecauseThirdProovedMeWrongAboutDice():void {
	clearOutput();
	//First Time
	if(flags["COC.URTA_PETPLAY_DONE"] > 0) {
		wearZeCollar();
		return;
	}
	output("You hold up the leather collar you found in the previous room, asking when she picked it up.");

	output("\n\nUrta's eyes widen, briefly reminding you of dinner plates, and she immediately rolls off the bed, snatching the collar from your hands.  If she could blush, you're certain her face would be bright scarlet right now.  Her tail swishes swiftly between her legs and her ears point straight up, as alert as you've ever seen them.  \"<i>That?  Oh, it's nothing.  Delivered here by mistake.  I, ah, was going to return it tomorrow,</i>\" she says unconvincingly, before setting it aside.  Urta sits on the side of the bed and spreads her legs, giving you a good look at her ample horseshaft, and tries to change the subject with a casual wave of her hand, \"<i>Shall we get back to what you came for, then?</i>\"");

	output("\n\nYou retrieve the collar again and look it over.  It's well crafted, clearly a custom piece.  Someone went through a lot of trouble to get this made.  Her wide eyes remain fixed on you, watching as you turn it over and inspect it.  She bites her lip nervously, as if the collar might spring out of your hands and bite without warning.  Urta shifts on the bed uncomfortably while you look it over until she finally stands up, proclaiming, \"<i>OK, OK, I got it made!</i>\"  She shifts in place, hands clasped together in worry.  \"<i>I was a little drunk at the time, and I thought... well, I thought it might...</i>\" her voice trails off at the end, and you can't catch what she said.");

	output("\n\n\"<i>I thought it might look good on you!  You know, for some role playing,</i>\" she says when you press.  Your eyebrow automatically quirks upwards.  She wanted you to wear this?  It's certainly a nice collar, exquisitely made.  You don't think a collar like this would come cheap.  Seeing your face, Urta rises from the bed and takes the leather collar from your hands a second time, throwing it in a nearby trash can.  \"<i>Look, I was drunk when I got it...  don't worry about it, okay [pc.name]?  I love you just the way you are, and don't you dare think otherwise!  Now, are we going to get to it?</i>\" she asks, sitting on the edge of the bed once more.");

	output("\n\nWell?  Shall you ignore the collar and let it get thrown out with the trash?  Or you could show her you're interested in a little petplay...");

	//[Ignore (Takes you back to the sex menu, removes Collar from menus)] [Wear]
	processTime(4);
	clearMenu();
	addButton(0, "Wear", wearZeCollar);
	addButton(1, "Ignore", ignoreUrtasCollar);
	addButton(2, "Take", takeUrtasCollar, undefined, "Take", "You may be not into petplay, but you can take it as accessory.");
}

private function ignoreUrtasCollar():void {
	clearOutput();
	flags["COC.URTA_PETPLAY_DONE"] = -1;
	if(urtaLove()) urtaHomeLuvLuvinsMenu();
	else goBackToUrtasForLuvinzII();
}

private function takeUrtasCollar():void {
	clearOutput();
	flags["COC.URTA_COLLAR_TAKEN"] = 1;
	
	output("You reach down into the trashcan for the collar. <i>I'm not sure about roleplaying, but I'll take it.</i>\n\n");
	
	itemScreen = urtaLove() ? urtaHomeLuvLuvinsMenu : goBackToUrtasForLuvinzII;
	lootScreen = itemScreen;
	useItemFunction = itemScreen;
	
	itemCollect([new CoCUrtaCollar()]);
}

private function wearZeCollar():void {
	clearOutput();
	if (flags["COC.URTA_PETPLAY_DONE"] == undefined) {
		if (pc.hasItem(new CoCUrtaCollar())) output("You reach into your pocket, unclasp the collar and slip it on.  You tighten it until it fits snugly against your [pc.skinFurScales], but isn't otherwise uncomfortable.  With a satisfying <b>click</b>, the clasp snaps shut, so you know there's no going back.  ");
		else if (pc.accessory is CoCUrtaCollar) output("You stroke collar on your neck meaningly, asking Urta if she still want play with her \"pet\".  ");
		else output("You reach down into the trashcan, unclasp the collar and slip it on.  You tighten it until it fits snugly against your [pc.skinFurScales], but isn't otherwise uncomfortable.  With a satisfying <b>click</b>, the clasp snaps shut, so you know there's no going back.  ");
		output("Urta's mouth drops as she watches you do this, completely at a loss for words.  Her cock, on the other hand, hardens, knowing just what to do.");
		
		output("\n\nYou sink to your knees and then onto your hands in front of her, brazenly displaying your submission to the vixen goddess before you.  She leans back slightly, stunned by this action.  It takes her a minute to recover and pick her jaw up off the floor.  You dutifully wait, silently, until Urta issues a command.  She seems to sense this and clears her throat, clearly embarrassed and nervous.  \"<i>Oh, um, good " + pc.mf("boy", "girl") + ",</i>\" she murmurs, patting your head.  You rub your [pc.face] into her palm, which brings a smile to Urta's face.");
		
		output("\n\n\"<i>Well, since the girl at the store said this was a dog collar... you're going to be an obedient little puppy, aren't you pet?</i>\" Urta asks.  You bark an affirmative response.  \"<i>And that makes me your Owner, doesn't it?</i>\"  You bark again.  Urta's smile widens, and the dick between her legs twitches happily.  Your foxy lover stands up and gives you a once-over, her stocking-clad legs walking circles around you.  You remain stock still until you feel one soft, furry paw press up against your");
		if (!pc.isCrotchExposed()) output(" covered");
		output(" groin.");
		
		output("\n\n\"<i>You're a good little doggy, right?</i>\" Urta leans down and whispers in your ear from behind.  You nod and bark happily again.");
		
		if(!pc.isNude()) output("  \"<i>You don't look like a good doggy to me,</i>\" she murmurs, leaning back up and pressing that paw into your groin once more, slightly more insistent.");
		output("  You find yourself growing ");
		if(pc.hasCock()) output("harder");
		if(pc.isHerm()) output(" and ");
		if(pc.hasVagina()) output("wetter");
		output(" at the touch");
		if (!pc.isNude()) 
		{
			output(", but you can't help but wonder about her words.  What else is there to being a good dog?");
			output("\n\n\"<i>Your clothes, pet,</i>\" your Owner says, catching your puzzled look.  \"<i>Good doggies don't wear anything but their collars.</i>\"  Oh, of course!  You start to stand and take off your [pc.gear], but Urta places a hand on your shoulder.  \"<i>Stay on all fours, pet,</i>\" she warns, and you suddenly realize she's holding a rolled up copy of the Tel'Adre Times in her other hand.  You gulp, slightly scared but even more turned on at how she's taking charge.");
			output("\n\nYou struggle out of your [pc.gear].  It takes a good minute of work, but then");
		}
		else output(" while");
		output(" you sit on your hands and knees, bare naked except for the collar, in front of Urta.  You feel so vulnerable like this, like you're baring your soul to someone, but somehow it's okay because it's Urta, someone who started as a friend, bared her own soul to you, and became your lover.");
	}
	//(Jump down to Scene Proper)
	//Second Time
	else if (flags["COC.URTA_PETPLAY_DONE"] == 1) {
		if (pc.hasItem(new CoCUrtaCollar()) || pc.accessory is CoCUrtaCollar) output("You spy a shiny metal, heart-shaped tag sitting on a nearby dresser and pick it up.  Urta catches you checking out the tag and sits down at the edge of her bed.  \"<i>Go on then, [pc.name].  Read it,</i>\" she urges you with a soft whisper.");
		else output("You spy the collar sitting on a nearby dresser and pick it up.  It's still a marvelous piece of leather... although it looks different.  A shiny metal, heart-shaped tag dangles from it.  Urta catches you checking out the collar and sits down at the edge of her bed.  \"<i>Go on then, [pc.name].  Read it,</i>\" she urges you with a soft whisper.");
		output("\n\nThe little, shiny golden tag says '<i>Property of Urta</i>' in soft, flowing script.  Urta fidgets nervously as you run a finger over the engraved words, as though confirming they're real.  \"<i>It's not too much, is it?</i>\" she asks, pulling at the hem of her stockings fitfully.  \"<i>I just thought, since we were playing like this... we could make it official.  Just while we're 'playing' like this, of course.</i>\"");

		output("\n\nYou answer her question by ");
		enum.clear();
		if (!(pc.accessory is CoCUrtaCollar)) enum.push("snapping the collar on");
		else enum.push(" snapping the tag to collar");
		if (!pc.isNude()) enum.push("stripping down to your birthday suit");
		enum.push("kneeling in front of your Owner");
		output(enum.toString());
		enum.clear();
		if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output(", tail wagging");
		output(".  Urta beams at you and pats your head lovingly.");
	}
	//(Jump down to Scene Proper)
	//Repeats
	else {
		output("You spy the collar sitting on a nearby dresser and pick it up.  You run your fingers over the engraved words on the collar's tag that reads '<i>Property of Urta</i>'.  Slipping it on, you also strip down until you're as nude as the day you were born, and kneel in front of your Owner");
		if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output(", tail wagging");
		output(".");
	}
	//Scenes Join Up Here
	//(If PC has no tail)
	if(!pc.hasTail() || !pc.hasTailFlag(GLOBAL.FLAG_LONG)) {
		output("\n\n\"<i>Good, good. One last touch, though,</i>\" she says before turning to a dresser and retrieving some kind of fluffy tail attached to... a butt-plug!  \"<i>Since you don't have");
		if(pc.hasTail()) output(" proper");
		output(" one yourself, we'll have to improvise.  Turn around and be a good little puppy now, all right?</i>\"  You whimper at the thought of that thing going into your ass, but you dare not disappoint your new Owner.  Flipping yourself around, you lower your upper body all the way to the floor, raising your butt high into the air.");
		if(pc.ass.wetness() > 0) output("  Despite your embarrassment, or perhaps because of it, you find your asshole getting wet with desire, practically salivating in anticipation of that thick plug.");
		//(Cont. if PC has no tail)
		output("\n\nYour Owner slowly pushes the plug inside while you shiver, the cool plug feeling like ice against your flushed skin.  Your sphincter stretches a little uncomfortably as the invader goes deeper.  You actually groan audibly as you get to the widest part, there's just something about feeling so <b>full</b> inside that makes you feel so goddamn good. With one last little push, the plug slips into place, your asshole clutching it tightly.  Urta stands back and admires your new, temporary tail.  You trot around on all fours for a moment, getting used to the swishing of the tail against the back of your thighs.  It, like the collar, is a constant reminder of the situation you find yourself in.");
	}
	output("\n\nYou take a quick walk around the bedroom and then look up at Urta, wagging your tail expectantly at her.  She leans down and pats you on the head, saying, \"<i>Such a good little pet!</i>\"  You grin happily and sit on your haunches, staring up at your Owner.");

	output("\n\n\"<i>Hmm, what does my pet want to do with me today?</i>\" she asks with a mischievous look.");
	IncrementFlag("COC.URTA_PETPLAY_DONE");
	//[Doggystyle] ["Reward"] [Walkies! (Not available first time)]
	clearMenu();
	addButton(0, "Doggystyle", doggyStyleUrtaPetplay);
	addButton(1, "\"Reward\"", getAPetReward);
	addButton(2, "Walkies", urtaTakesPCOnWalkies);
}

//Doggystyle
private function doggyStyleUrtaPetplay():void {
	clearOutput();
	//output(images.showImage("urta-home-petplay-doggy"), false);
	output("\"<i>Hmm,</i>\" Urta wonders aloud, bringing a finger up to her mouth in mock-thoughtfulness.  \"<i>What should I do with my little pet now that " + pc.mf("he", "she") + "'s all collared up?</i>\"  Your Owner walks around you slowly, assessing your body.");
	
	output("\n\n\"<i><b>Sit</b>,</i>\" she says, a commanding voice coming easily.  Before you can even think about it, you immediately find your butt touching the smooth, cool floor.  Urta smirks and pats you on the head.  \"<i>Good pet.  <b>Down.</b></i>\"  Again, you follow her instruction immediately, lowering your front to the ground while simultaneously lifting your ass into the air.  She circles around and kneels alongside of you.  \"<i><b>Stay</b>,</i>\" she commands.  You don't dare move as she leans in, running a furry hand along the [pc.skinFurScales] of your back, which you can't help but arch, and over your [pc.butt].  Your ");
	if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("tail");
	else output("tailplug");
	output(" wags of its own accord, happily swishing back and forth.  Urta's hand dips between your buttocks, over your ");
	if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("asshole");
	else output("plugged asshole");
	output(", and between your thighs, ");
	if(pc.hasCock()) output("grasping your [pc.cock " + pc.biggestCockIndex() + "]");
	else output("her fingers slipping ever-so-slightly into the folds of your pussy");
	output(".");

	output("\n\nYou moan appreciatively as she runs her fingers along it, her fingers encircling your ");
	if(pc.hasCock()) output("[pc.cockHead " + pc.biggestCockIndex() + "]");
	else output("[pc.clit]");
	output(" while her other hand keeps your upper body firmly down.  With every stroke your body burns just a bit hotter, your breath coming a bit shorter.  ");
	if(pc.hasCock()) output("Her thumb rubs against the sensitive underside of your cock");
	else output("One finger slips into you, all the way down to the knuckle, and swivels around to caress your g-spot with expert accuracy");
	output(", making you bite your lip in ecstasy.  You want to cry out right now, but you know you can't break character right now.  Not this early in.  The strokes come faster, and you can feel the orgasmic flames coming on; your limbs tingle and your legs are already wobbling.");

	output("\n\nYour Owner, seemingly sensing this, backs off, retracting her hands completely.  You teeter on the edge of orgasm, but with nothing touching you, and without permission to touch yourself, the orgasm subsides, ruined, and your body slowly regains its strength.  Cocking your head, you look back at Urta, who was watching your reaction with gusto.");

	output("\n\n\"<i>Oh, we can't have you coming too soon,</i>\" she explains, slapping your ass lightly.  You flinch a little at the spanking, the erotic combination of pain and pleasure feeling oh-so good on your [pc.skinFurScales].  \"<i>A good pet will only cum after their owner, after all.</i>\"  You whine pitifully, hoping it won't take all that long at least.");

	output("\n\n\"<i><b>Roll over</b>,</i>\" she commands again.  You're on your back even before you process the words, holding your arms and legs in the air as though you were a real dog.  Your Owner giggles at seeing this, placing a hand on your belly and rubbing softly.  Her other hand, however, finds its way a bit further up, coming down on one of your nipples.  Fingers lightly swirl around it, and you find your [pc.nipples] hardening, while your ");
	if(pc.hasCock()) output("[pc.cock " + pc.biggestCockIndex() + "] does the same");
	else output("[pc.vagina] grows slicker");
	output(".  She really is going to tease you as long as she can, you think to yourself.");

	output("\n\nThe first hand drifts from your belly back towards your ");
	if(pc.hasCock()) output("cock");
	else output("pussy");
	output(", taking over where it left off just moments ago.  ");
	if(pc.hasCock()) output("She wraps her fingers around your shaft, slowly pumping up and down, taking a moment to tease your [pc.cockHead " + pc.biggestCockIndex() + "] every few strokes.");
	else output("She buries two fingers deep inside your cunt, followed by a third, each one twisting around to rub at your g-spot softly.");
	output("  The hand on your chest switches to ");
	if(pc.totalNipples() == 2) output("the ");
	else output("an ");
	output("other nipple, tweaking and teasing that one while she simultaneously ");
	if(pc.hasCock()) output("jerks you off");
	else output("rubs you from the inside out");
	output(".  Again comes the flame of orgasmic bliss, lapping at your tingling extremities.  Your body feels suddenly electric, so overcharged with sweet, sweet pleasure that you find it hard to think.  Low moans escape your throat, entirely unbidden, while ");
	if(pc.hasCock()) output("pre-cum dribbles from your dick like a leaky faucet");
	else output("your folds grow even more damp, constantly drizzling fluids that run down your ass crack, pooling on the floor like a lewd lake");
	if(pc.hasCock() && pc.hasLeg()) output(", and to top it all off, you find your [pc.leg] inexplicably kicking in mid-air");
	output(".");
	
	output("\n\nYou find yourself on the precipice of orgasm once more... and once again there's a sudden void as Urta's hands leave your body.  What started off as a moan of ecstasy soon turns into a frustrated whine as your second orgasm dissipates into the ether.  You look into Urta's eyes and realize she's enjoying this control over you, this new power over whether you can cum or not.  In a strange way, you are too, the knowledge that when you finally do cum, it's at Urta's wish sends a twitter of excitement up your spine.  She has such control right now, and you wouldn't have it any other way.");
	
	output("\n\n\"<i><b>Roll over</b>,</i>\" comes another command.  You do so, returning to your four-legged stance.  Urta, meanwhile, kneels behind you, grasping her thick horsecock which is already practically doused in precum.  You hadn't noticed just how aroused she was getting through all of this.  This whole situation must really turn her on.  Your Owner rubs the tip of her shaft against one asscheek, then the other");
	if(!(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG))) output(", while she grasps the plug in your ass firmly and pulls. It comes out easily with a wet <b>pop</b>, making your ass feel suddenly empty.  You guess it won't be empty for long, however");
	output(".  Finally she rubs it against your [pc.asshole], teasing you with every brush of skin against skin.");
	
	output("\n\n\"<i><b>Beg</b>,</i>\" she instructs softly.  \"<i>Beg me to fuck you, pet.  It's all right, you can talk.</i>\"");
	
	output("\n\nYou whine for a moment, unsure of what to say, but when that delicious shaft of horsecock makes the slightest contact with your ass again, words come from mouth without need to think.  \"<i>Fuck me,</i>\" you plead back your voice meek and submissive.  \"<i>Fuck me like your little puppy bitch.</i>\"");
	
	output("\n\nThat seems to be all the encouragement she needs, and, grasping your hips roughly, she sinks several inches of her torrid tool directly into your aching, needy ass.  The two of you let out loud, slutty moans in unison.  You find your upper body sinking to the floor, ");
	if(pc.biggestTitSize() <= 5) output("resting on your folded arms");
	else output("resting on your enormous boobs");
	output(", while your ass remains high in the air, all the better to be fucked by your hermaphroditic Owner.  Urta pulls out a few inches just to push in even deeper, and the feeling is exquisite as, with each thrust, you get the sensation of being filled just a little bit more.  By the time her large balls slap into your ");
	if(pc.balls > 0) output("own");
	else if(pc.hasCock()) output("painfully erect [pc.cocksLight]");
	else output("slit");
	output(", you are overwhelmed by the full, content feeling.  Your eyes roll back in their sockets, and it's hard to focus on anything but the twenty inch dick buried in your sensitive ");
	if(!silly) output("ass");
	else output("boypussy");
	output(".");
	pc.buttChange(urta.cockVolume(), true, true, false);

	output("\n\nSoon, Urta develops a good rhythm, thrusting in and out, her balls slapping your ");
	if(pc.hasCock()) output("[pc.cocksLight]");
	else output("cunt");
	output(" in such a way that it tingles powerfully, fueling your impending orgasm even more.  Locked in this cadence, she pounds your ass for what seems like hours.  The air grows damp and sweat drips from the two of you, only adding to your desire.  It's not long after until your nostrils are assaulted by the salty scent of sex.  Your ");
	if(pc.hasCock()) output("[pc.multiCocks] slaps against your belly roughly with every passing second, smearing thick globules of precum which drip down your belly, tickling your flesh like little balls of distilled pleasure");
	if(!pc.hasGenitals()) output(", while your");
	if(pc.hasVagina()) output(" unused pussy aches to be filled or touched, its lips puffy and red, sensitive to every hard slap of your foxy lover's balls");
	output(".");

	output("\n\nYour rough, doggystyle lovemaking increases its pace, until it reaches its crescendo.  Urta slams one last time into you, her flare suddenly spreading wide, opening up the deepest reaches of your bowels.  If you'd felt wonderfully full before, it's nothing compared to the sensations now running through your body.  With every pulse of her cock, it seems to stretch you wider, as jet after jet of warm, gooey seed fills your belly.");

	output("\n\nYou let loose a canine howl of pleasure as your ass clamps down on the impossibly wide tool.  You stand on the edge of orgasm, and the feeling of being so filled to the brim with cock and cum sends you right over.  Your body alights with electric passion, tingling in ways you rarely ever feel.  The lightning strikes at your ");
	if(pc.hasCock()) {
		output("groin, sending a wave of tremors down your [pc.cocksLight], which suddenly erupts, covering your belly and [pc.chest] in warm gooey goodness.");
		if(pc.cumQ() >= 500) output("  It continues to jerk on its own, unloading its massive load until you're laying in a puddle of your own semen.");
		if(pc.hasVagina()) output("  It then travels along to your ");
	}
	if(pc.hasVagina()) output("[pc.vagina], which, despite being devoid of cock, clamps down anyway, gushing with femcum, drenching your Owner's balls and legs in sticky, clear fluids.");

	output("\n\nYour body shivers constantly as the lightning arcs to every limb, every digit, and every pore of your body.  Everything you can feel feels like it's having an orgasm all at once.  Even your [pc.lips] and [pc.tongue] tingle, suddenly wanting a huge, thick cock to suck on.");

	output("\n\nExhausted, you slouch forwards, suddenly aware of the large, almost pregnant belly you're sporting as it makes contact with the slick, wet floor below.  You tentatively reach down with one weak hand, cradling your sloshing cum belly as you flop over onto your side, completely spent.  Urta curls up behind you, her cock still firmly inside, plugging all that warm seed inside.  You nuzzle back into her and drift off into a relaxing, orgasm-induced nap.");

	output("\n\n...");
	processTime(45);
	pc.orgasm();
	pc.loadInAss(urta);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 4;
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] += 2;
	clearMenu();
	addButton(0,"Next",partTwoOfDoggieStyle);
}

private function partTwoOfDoggieStyle():void {
	clearOutput();
	output("<b><u>Several hours later</u></b>\nYou awake in Urta's arms, tucked under the sheets of her bed.  You're free of your collar, which you can see now lays on a dresser nearby, but you're a little happy to see you still have a small, almost pregnant bulge in your belly where you know a large reservoir of cum now resides.  Urta gives you a shy smooch, saying, \"<i>Mm, I had so much fun, [pc.name].  I... I don't know what got into me there, but I kinda liked it.  And I just adore you for going along with it.</i>\"");

	output("\n\nYou chuckle, confirming you enjoyed it too, and that you're prepared to be her little doggy any time, if it gets you a reward like that.  Your vixen \"Owner\" gives you a giant grin and cuddles up closer, murmuring how happy she is to have found someone as great as you.");
	processTime(90 + rand(60));
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//"Reward"
private function getAPetReward():void {
	clearOutput();
	//output(images.showImage("urta-home-petplay-reward"), false);
	output("\"<i>Well, you've been a good little pet so far,</i>\" Urta says, patting you on the head. \"<i>I think a little... reward is in order.</i>\"  You quirk an eyebrow, wondering about that pause, but wag your ");
	if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("tail");
	else output("tailplug");
	output(" enthusiastically.");

	output("\n\nUrta holds up a hand at you and says in a quite commanding voice, \"<i>Sit.</i>\"  You immediately drop your butt to the floor, getting a little thrill from obeying.  \"<i>Good " + pc.mf("boy", "girl") + ".  Now stay.</i>\"  Once she's satisfied you're staying put, your Owner walks out of the room, her ass swaying tantalizingly as she disappears around the corner.  You wait, naked and with your legs and butt resting on the floor, for several minutes.  You find yourself actually getting a little ");
	if(pc.hasCock()) output("hard");
	if(pc.isHerm()) output(" and ");
	if(pc.hasVagina()) output("wet");
	output(", oddly enough, thinking of what your 'reward' could be.  Urta returns several minutes later, with one hand holding some kind of metal dish... a food bowl for a dog!");
	if(silly) output("  In her other hand is what looks to be a jar of peanut butter.  What use could that have?");

	output("\n\nUrta sits on the edge of her bed, her huge horsecock wobbling in a state of half-hardness, and sets the bowl down between her feet.  Thankfully, it's empty.  You couldn't imagine being forced to eat dog food");
	if(silly) output(", though you wonder if perhaps that's what the peanut butter is for");
	output(".  Your Owner stretches a foot out towards you, running her stocking-clad paw along your side.  The little tufts of fur protruding from the fishnet tickle your skin in a sensual fashion, and you can't stop your spine from stiffening at the contact.");

	output("\n\nYou start to move towards Urta, but she waggles a finger at you.  \"<i>Ah-ah, I told you to sit and stay, didn't I?</i>\"  You gulp and nod, remaining stock-still.  Smiling at this, Urta continues to run her foot across your [pc.skinFurScales], pulling her padded foot up and over one shoulder and dipping down ");
	if(pc.biggestTitSize() < 1) output("onto your chest");
	else output("between your breasts");
	output(".  She takes a moment to encircle one of your nipples, which stiffens to attention along with ");
	if(pc.totalNipples() == 2) output("its twin");
	else output("the others");
	output(", before sending the paw down further where it makes contact with your ");
	if(pc.hasCock()) output("[pc.multiCocks]");
	else output("[pc.vagina]");
	output(".  There's nothing you can do to stifle the moan of pleasure that escapes your lips as your Owner's paw travels the length of your ");
	if(pc.hasCock()) output("rapidly hardening shaft.");
	else output("moistening slit.");

	output("\n\nUrta keeps this up for a minute, lovingly stroking your ");
	if(pc.hasCock()) output("dick");
	else if(pc.hasVagina()) output("cunt lips");
	output(" with a paw, until you bite your lip and whine at her.  She gives you a little smirk and the foot retreats.  \"<i>All right then, pet, come and get your bone,</i>\" Urta gestures down at the half-erect cock sprouting from between her thighs");
	//silly:
	if(silly) output(", while she opens the jar of peanut butter and smears a dollop across the flat head.  Is... is that supposed to be enticement?  She really is treating you like a real dog");
	output(".  You crawl towards her nervously, and start to reach up to grasp her cock, but again she mutters, \"<i>Ah-ah, good doggies don't use their hands.</i>\"");

	output("\n\nNodding, you extend your [pc.tongue], running it along the length of her hardening shaft");
	if(silly) output(", licking all of the peanut butter off the tip");
	output(".  Urta shivers and lets out a \"<i>Mm,</i>\" while her pillar of horsecock reaches its full size, clocking in at what has to be a good twenty inches.  ");
	if(silly) output("  Your owner uses her fingers to smear another large dollop of peanut butter along her own shaft, giving you an almost sadistic smirk.");
	output("  You smooch and lick your way down her shaft, lapping at every little vein while Urta leans back and enjoys your ministrations.  Little gasps of pleasure escape from her lips, while moans leave yours as you smooch and suckle your way down to the base of that towering horsecock.");

	output("\n\nYour foxy Owner's prick glistens by the time you finally take it into your mouth");
	if(silly) output(", the peanut butter now long forgotten");
	output(", stretching your jaw wide.  ");
	if(pc.hasCock()) output("Your own cock remains almost painfully rock hard, bobbing awkwardly beneath you, dripping precum onto the floor and bowl.");
	if(pc.hasVagina()) {
	if(pc.isHerm()) output("  Not to mention");
	else if(pc.hasVagina()) output("  Meanwhile");
	output(", your pussy is as wet as it's ever been, constantly leaking juices that run down your legs, pooling on the floor.");
	}
	output("  You swirl your tongue around Urta's flare, paying homage to the horsecocked goddess.  Lapping at the slit for a moment, you slip your [pc.tongue] along the vixen's thick cumvein, which pulses lightly.  Urta groans and runs a hand through your [pc.hair], gripping it solidly.  You can't help as you're forced further onto the warm rod.");

	output("\n\nUrta's flare presses against the back of your throat for a moment before slipping down into your throat, bringing a groan up from your core.  The vibrations seem to please your lover, who shudders, and forces her massive cock further down your throat.  It's slightly uncomfortable, but it brings you such a thrill to know the kind of bliss you're giving your Owner.  You bob your head up and down, letting the cock penetrate your throat deeper with every thrust.  Urta's legs stiffen, and her breaths get quicker while the cock buried in your gullet twitches wildly. Clearly not wanting to cum in your mouth, she pulls out, leaving your maw with a wet <b>pop</b>, and aims her cock downwards... right towards the doggy bowl.");

	output("\n\nJet after jet of white, hot cum spurts forth from the mismatched vixen's flaring cock, splattering into the bowl messily.  Urta bites her lip, stifling a long groan.  The bowl fills, splashing over the edge and coating your front, and Urta's legs in a fine layer of spooge.  Finally, when little more than drops of semen dribble out, plopping lazily into the bowl below, Urta sits back with a sigh of orgasmic release.");

	output("\n\n\"<i>Mmm, by Marae that felt good...</i>\"  Urta stretches out for a moment and then quirks an eyebrow at you over her deflating member.  \"<i>Well, what are you waiting for?  There's your reward,</i>\" she nudges the dog bowl with a fishnet-clad, semen-splattered paw.  \"<i>Eat it all up, pet... you want to be a good puppy, don't you?</i>\"");

	output("\n\nYou gulp loudly.  You do want to be a good pet, so you lower your head down to the bowl and extend your [pc.tongue], lapping at the top layer and swallowing it down.  It's still warm, and quite salty with a bit of a sweet tang to it.  You quickly dive back into your 'reward', using your tongue as a spoon to consume every last drop in the bowl.  While you're busy doing that, Urta slides off the bed and takes up a position behind your body, ass high into the air, showing off all her goods.  The fox raises a paw, smearing some of her cum along your ");
	if(pc.hasCock()) output("shaft ");
	if(pc.isHerm()) output(" and ");
	if(pc.hasVagina()) output("slit ");
	output("tantalizingly.");

	output("\n\nWith every dollop of cum you consume, she gives your ");
	if(pc.hasCock()) output("[pc.cockHead " + pc.biggestCockIndex() + "]");
	else output("[pc.clit]");
	output(" a little twirl with a soft, padded toe.  You can't help but moan into the bowl as you go, your legs shivering and stomach twisting with desire.  You continue to lap at the bowl eagerly downing mouthful after mouthful and being rewarded with more pleasure.  Even when you've licked the bowl clean, you find yourself lowering your head further and slurping away the remnants that splattered onto the floor.  Urta seems to find this satisfactory, as she picks up the pace, ");
	if(pc.hasCock()) output("jerking off your cock between two toes");
	else output("rubbing your little love button like mad with one soft toe");
	output(", until you just can't handle any more. ");
	
	output("\n\nYou cry out and bite the side of the bed as a powerful orgasm washes over you.  It feels like a tidal wave of intense pleasure, centered in your groin and rippling outwards with the force of a hurricane.  Your arms and legs all wobble with instability while your muscles tense and relax, spasming uncontrollably.  ");
	if(pc.hasCock()) output("The cock between your [pc.legs], meanwhile, stiffens, briefly becoming harder than you've ever felt before, before blasting the floor with jet after jet of [pc.cum].");
	else output("Meanwhile, your vagina clamps on nothing, achingly, painfully empty.  Juices spray out onto Urta's foot and down your thighs, soaking the floor beneath you in yet more slippery femcum.");
	output("  Your Owner doesn't just let it end there, however, she continues her paw-assault on your crotch, stroking and rubbing until you become little more than a gibbering mess of orgasm-infused flesh laying in a puddle of your own sexy goo.");
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] += timeAsStamp + 60 * 2;
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] += 2;
	output("...");
	pc.orgasm();
	pc.loadInMouth(urta);
	clearMenu();
	addButton(0,"Next",feedTheBeastPartII);
}

private function feedTheBeastPartII():void {
	clearOutput();
	output("<b><u>Several hours later...</u></b>\nYou awake in Urta's arms, tucked under the sheets of her bed.  You're free of your collar, which you can see now lays on a dresser nearby.  Urta gives you a shy smooch, saying, \"<i>Mm, I had so much fun, [pc.name].  I... I don't know what got into me there, but I kinda liked it.  And I just adore you for going along with it.</i>\"");

	output("\n\nYou chuckle, confirming you enjoyed it too, and that you're prepared to be her little doggy any time, if it gets you a reward like that.  Your vixen \"<i>Owner</i>\" gives you a giant grin and cuddles up closer, murmuring how happy she is to have found someone as great as you.");
	processTime(90 + rand(60));
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Walkies!
private function urtaTakesPCOnWalkies():void {
	clearOutput();
	//output(images.showImage("urta-home-petplay-walkies"), false);
	output("\"<i>Ah, I know just what we should do!</i>\" She claps her hands together and rummages through her dresser.  Urta throws on a simple little yellow sundress and makes her way to the door.  \"<i>Come on, pet</i>\" she says with a mischevious smirk, patting her leg and holding up a leather leash. \"<i>It's time to go for a walk!</i>\"");

	output("\n\nYou blanch at the thought.  Walking around Tel'Adre... like this?!  Letting everyone see you on your hands and knees, following Urta around like a lost puppy?  It's just so... degrading!  But yet, as nude as you are, you can't hide your body's reaction to this idea. Your skin grows warm, while ");
	if(pc.hasCock()) output("[pc.eachCock] grows hard beneath you");
	if(pc.isHerm()) output(" and ");
	if(pc.hasVagina()) output("your [pc.vagina] moistens, ready to be on display");
	output(".");

	output("\n\nUrta gives your ass a playful little smack with a rolled-up newspaper, \"<i>Well now, someone likes this idea.</i>\"  Your Owner leans down and clips the leash onto your collar, whispering, \"<i>Excited for everyone to see what a good, well-behaved little <b>puppy</b> you are?</i>\"  You gulp.  Part of you wants to say no, to end this before it even starts, but the rest of you wants it, needs it even.  You at least know that with Urta there, nothing bad will happen.  You trust her to stop this game before anything goes too far.");

	output("\n\nYou swallow hard and nod your head, giving your ");
	if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("tail");
	else output("tailplug");
	output(" a nervous little shake.  Urta smiles and opens the door wide, making you squint in the bright daylight.  You feel a tugging at your neck, and realize Urta's already set off.  You scamper off after her on all fours, not wanting to disappoint your Owner.  The two of you travel through some back alleys, thankfully free of strangers, until you come out into the main thoroughfare of the city.");

	output("\n\nAll eyes turn to you as Urta leads you, sometimes tugging lightly on the leash to remind you to walk, into the crowd.  Your face glows red with embarrassment.  Here you are, the Champion of Ingnam, butt naked, being lead around on a leash, completely at the whims of your Owner.  You feel the stares of strangers burning into your flesh... but they're not looks of judgment or horror like you thought they would.  No, instead they're looks of lustful hunger.  Men and women both stare at ");
	if(pc.biggestTitSize() >= 5) output("the breasts hanging from your chest and ");
	output("your openly displayed rear end.  ");
	if(pc.hasCock()) output("Pre-cum drizzles from the end of your painfully erect cock");
	else output("Sweet juices flow from your cunt, drizzling down onto the ground");
	output(", creating a trail of horniness alongside Urta's.");

	output("\n\nYour Owner stops to chat with the occasional citizen every few minutes.  Although they initially seem shocked to see you, they quickly adapt, and you find yourself being ignored more than anything.  You're not sure how to react to that, whether you should be thankful they're not paying any more attention to you, or be angry that they're simply accepting you as a pet, a submissive <i>plaything</i> of Urta's.  Regardless, your horniness does not diminish.  If anything, you find yourself getting ");
	if(pc.hasCock()) output("harder");
	if(pc.isHerm()) output(" and ");
	if(pc.hasVagina()) output("wetter");
	output(".  You feel like you really are a pet, out for a walk with your Owner.  It's an odd, and slightly freeing revelation, and once you come to grips with it, your entire experience changes. You find yourself trotting ahead of Urta, happily displaying yourself to all who wish to see.");

	output("\n\nSome Tel'Adre citizens approach Urta, commenting on how well trained you are, and although you sense some sarcasm in some of their voices, you can't help but feel a little proud of yourself.  What more could a pet ask for, after all?");

	//Marking this spot off in case I want to add random NPC encounters later.
	output("\n\nFinally, however, the time comes to return to Urta's place, and you follow along the same back alleys so familiar to you by now.  You're unbearably horny at this point, and you can see Urta is having some real trouble keeping her dress from tenting up as well.  Thankfully, you both make it back and Urta leads you inside, shutting the door behind her with a relieved gasp.");

	output("\n\n\"<i>Oh, by Marae, I can't believe I actually did that,</i>\" she gasps, leaning down to unhook your leash and collar.  Urta pulls you up to your feet and gives you a hug, whispering, \"<i>That was such a rush, [pc.name].  Thank you </i>so<i> much for going along with it.  I fucking love you.</i>\"");

	output("\n\nYou " + pc.mf("laugh","giggle") + " and confirm you had a great time as well.  Urta gives you a sheepish look, before asking if you'd ever want to do that again.  You lean in for a kiss, and let that answer the question.");
	pc.lust(33);
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp;
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] += 5;
	if(pc.exhibitionism() >= 66) {
		output("  <b>You're so fucking turned on after exhibiting yourself in such a way that you're dripping EVERYWHERE.  Such a good doggie.</b>");
		pc.lust(pc.lustMax(), true);
	}
	processTime(35 + rand(20));
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Vixen & Cream (LONNNNNNNNNNNNNNNNGEST)
private function vixenAndCreamPart1(teased:Boolean = false):void {
	clearOutput();
	//output(images.showImage("urta-vixen-and-cream-part1"));
	output("With a twinkle of mischief in your eyes, you slide your arm around her narrow waist, and press Urta close to your [pc.chest]. At first she lets out a short gasp at your boldness, but it soon turns into a long, sensuous moan. ");
	output("\n\nYou hungrily seize those gorgeous, glossy black lips of hers. Your lips are intimately locked with your grey furred lover, and her delicately sweet flavor fills your mouth. She melts in your arms.");
	output("\n\nIt's not long before she's sliding her hands around you. Her fingertips lightly claw at your shoulderblades. She's desperately trying to pull you closer, simply unable to get enough of your kisses.");
	output("\n\nWhen you pull away, you both share a long, heated look. Her breathing is heavy, and her rich green eyes look positively drunk; not with alcohol, but with love and desire for you. Her scritchy fingers gently stroke your back and twirl in intimate little circles, causing electric shivers to run down your spine.");
	output("\n\n\"<i>Mmmm... that's more like it. If I could get a kiss like that every day, I could die happy.</i>\" Urta swoons a little and affectionately nuzzles your cheek. You can feel her racing heart through her chest and beautifully formed breasts, beating rapidly against your own. \"<i>... So, does that mean we're going to play...?</i>\"");
	output("\n\nWith a devilish gleam in your eye, you inform her that she'll just have to wait to 'play' until later. "); 
	//1st dynamic text of Vixen & Cream
	output("\n\n");
	if (teased) output("You want to have a few drinks");
	else output("You're here to enjoy a few drinks and chat");
	output(" with the love of your life ");
	//if (urtaPregs.urtaKids() > 0) { 
		//output("and the "); 
		//if (flags["COC.URTA_TIMES_BIRTHED"] > 0) output("mother");
		//if (flags["COC.URTA_TIMES_BIRTHED"] > 0 && flags["COC.URTA_TIMES_PC_BIRTHED"] > 0) output(" and ");
		//if (flags["COC.URTA_TIMES_PC_BIRTHED"] > 0) output("father");
		//output(" of your children");
	//}
	output(". You deliberately announce this out loud and cause her to flush as people look over. In response, she digs her claws pointedly into your back, though not hard enough to actually hurt.");
	//End of dynamic text
	output("\n\n\"<i>Alright, </i>later<i> then - but you better deliver. I'll go get us a more 'private' booth in case you change your mind. And you're paying!</i>\" She pokes out her tongue and you go to fetch the drinks. Urta requests a pitcher of beer and a bottle of 'Crafter's Stamp' - clearly she's making you pay for high end whisky for holding out on her. Just like whisky, however, you know the taste is better the longer you wait.");
	output("\n\nFilled with thoughts of Urta's pent up taste, you can't help but smile as you walk back to your vixen lover. In the end you didn't need to pay for the drinks at all - " + (auntNancy(false) ? "the bartender" : "Aunt Nancy") + " was quite happy to give a freeby to the esteemed guard captain and and her 'enviable " + pc.mf("boy", "girl") + "friend'.");
	output("\n\nWhen you place the drinks and pitcher down you dutifully relay this information to your furred flame. She has an amused look in her emerald hued eyes. A quick glance <i>is</i> shot in the direction of the bar, though she doesn't look in the least bit threatened by her interest.");
	output("\n\n\"<i>...She can look and long for you, my love, but tonight you're all mine.</i>\" she huskily informs you. This woman before you is leagues away from the self-doubting fox herm you found nursing her massive horse cock in an alleyway, seemingly alone in the world. You can't help but feel a sharp sense of pride in how far she's come since then.");
	output("\n\nUrta begins to heat up the longer you stare at her, but instead of shying away she slinks closer towards you. Soon she's snuggled right up against your side, nuzzling her muzzle affectionately into your neck. You drape your arm around her shoulder and pull her in tight.");
	output("\n\nTo anyone watching you both, there is little doubt how much the two of you are lovers. You both drink up and share stories of your day as you lavish each other with tiny but countless acts of affection. Each one is a truly precious and irreplaceable moment. ");
	output("\n\nIt is not long before you're both a little tipsy off the fresh beer you've been drinking and the pitcher you bought is almost completely empty. You can feel the pleasant warmth radiating from your [face]. Meanwhile, your entire side is nice and toasty where Urta is pressed up against you. ");
	output("\n\nGiven the provocative pressing of her sweater puppies against your arm, you're fairly sure her sizzling temperature has nothing to do with the pitcher of beer she's been drinking. You can feel her hot, tickling breath brushing against the [skinFurScales] of your neck as she snuggles suggestively close.");
	output("\n\n\"<i>Mmm, I love the smell of you. I could just bury my muzzle against you and inhale you forever...</i>\" She looks at you with dreamy eyes while her fingers reach up and stroke your cheek. The ashen fur on her fingers is so soft and the gesture so intimate that you can't help but smile.");
	output("\n\nIn your chest, your heart is filled with so much love it feels as if it will implode with sheer feeling. Staring into her beautiful, shimmering green eyes, everything else simply melts away. All that is left is the two of you, and nothing else. ");
	output("\n\nFurther down you notice a very visible straining against the scarlet fabric of her dress. While she litters small kisses and teasing bites across your jawline you slide your hand cheekily under her skirt and up, seeking out her sizable companion. ");
	output("\n\n\"<i>Yes, just like that. Touch me down there, please...</i>\" Urta practically begs and pushes her loins desperately against your roaming hand. It's a request that you're happy to oblige. ");
	output("\n\nThe second your fingers make contact with her equine length she lets out a breathy moan and the kisses on your face cease. She is utterly spellbound by your dancing digits as they caress her engorged sheath, literally paralyzed with pleasure. Her breathing hitches as you slowly jerk her off with light, teasing movements.");
	output("\n\n\"<i>Oooooohhh Marae, that feels so </i>goooood<i>...</i>\" Your grey furred lover positively purrs. Her hips wiggle uncontrollably as you pointedly squeeze her base. Your constricting fingers force a huffy, desperate noise from her midnight lips and her entire length to twitch and spasm. ");
	output("\n\nYou can feel her pooling pre-cum trying to surge up her impressive jutting length only to stop at the firm grip of your hand. Her spunk is trapped under your commanding grip, forcing her to bite her lower lip. The pressure of her pooled semen presses needily between your thumb and index finger just begging to be released.");
	pc.lust(pc.lustMax(), true);
	processTime(15);
	clearMenu();
	addButton(0, "Next", vixenAndCreamPart2);
}

private function vixenAndCreamPart2():void {
	clearOutput();
	//output(images.showImage("urta-vixen-and-cream-part2"));
	output("Trying to stifle her cries, Urta reaches up and bites down on one of her fingers. You give a little grin and know that you have her on the ropes, just inches away from crying out.");
	output("\n\nUpping the ante, you slip your second hand underneath her silky dress and gently fondle her hefty trembling balls. They feel so heavy and thick in your hands, throbbing and broiling with her glorious pent-up spunk. As you squeeze her sizable spheres she lets out a whimpering noise, clearly getting on the attention you are lavishing on her loins.");
	output("\n\nYou love having her nuts firmly encased in your grip and feeling their heaviness pressing into your palms. Her cute noises of pleasure cause a predatory sense of lust to seize your senses. You want to watch her squirm with delight and hear her carnal cries. It is a <i>need</i> that seizes you with unbridled intensity and sweeps every other thought aside. ");
	output("\n\nReleasing her spheres, you reach up and flip up her skirt so her herm bits and lower half are utterly exposed. Rather than push it back down, the renowned guard captain flushes and whimpers like a little girl; her equine rod flaring and jerking in your hand like a bucking bull. \"<i>You're so naughty! What if someone catches us--?</i>\"");
	output("\n\n\"<i>Let them.</i>\" You wickedly whisper, and then silence her protests with a long intimate kiss. Your tongues clash and her length swells fiercely in your hand, brazen evidence of her arousal.");
	output("\n\nWhile her guard is down, you sneakily slide one of your hands underneath her balls. You seek out her sensitive, black lipped sex and are met with smooth wet folds that effortlessly part to the touch. Urta moans into your locked lips, all the while spreading her legs further apart.");
	output("\n\nWith the slightest of presses you immerse your digits inside of her furry mound and wiggle them about. Immediately your fingers are encased in a wonderful squeezing warmth, her inner walls fiercely milking your fingers. ");
	output("\n\nYou continue to jerk her off and plumb her pussy as you make out in the booth, totally and utterly wrapped up in each other. Lewd squelching noises and the tangy scent of her pussy juice fill the air. It mixes with the musky scent of her pre-cum and forms a heady, intoxicating mix, spurring you both on to greater heights.");
	output("\n\nYou decide to deliver the coup-de-grace and slide your thumb under her weighty, sperm-filled balls. Seeking out her clit, you gently press against it and cause spasmodic shivers to wrack her entire body. Unable to suppress herself any longer, Urta pulls away from your lips and lets out a high pitched cry of pure, delirious joy. ");
	output("\n\nYour mission accomplished, you pull your hands back from between her thighs and watch her as she's left <i>just</i> short of reaching that glorious peak. Her liberated pre-cum immediately spills out from her released rod and gushes against the inside of her outfit, falling far short of the explosive orgasms your well-endowed lover is famed for.");
	output("\n\n\"<i>Wh-what? Why'd you stop...?</i> Urta's breathing is heavy and her glorious equine length is harder than ever. It's twitching and spasming against her silky dress while her rich, gooey cream dribbles onto her plump breasts. Her horse cock is so long it easily sits between her considerable cleavage. You watch her flat tip animalistically flare and squirt tiny gushes of her sticky seed on her own buxom chest.");
	output("\n\nYou lean over and lap up her steamy white seed from between her titanic tits, rolling it over your tongue lightly before serving it back. With one swift movement, you passions press your mouth against hers, scooping her naughty jism inside. She moans against your lips and suckles your tongue clean, pervertedly swallowing her own freshly squeezed herm spunk.");
	output("\n\nPulling away, she flops back with a truly delirious look in her eyes and her brain out to lunch. Her shiny black lips are utterly smeared with her own white jizz. If she was any more high on cum and kisses, you're certain her eyes would be rolling back into her head right now.");
	output("\n\nWhile she lies there in a blissed out daze, you tell her that you've decided not to finish her off after all. The look on her face is priceless as you casually empty the last of the pitchers contents out. Urta lets out a cutely incredulous noise; she's clearly unwilling to leave things at that.  ");
	output("\n\n\"<i>You're so very, very </i>mean<i>! You're just going to leave me like this? Not on </i>my<i> watch!</i> The captain of the guard exclaims. You've barely finished pouring the second glass when you notice Urta is unhooking the shoulder straps of her dress and letting her ample bosom spill out. ");
	output("\n\nHot damn! You love it when she takes her wonderful twins out to play, but what exactly does she have in mind? You can't help but stare cravingly at her jiggling bust and jet black nipples, utterly captivated by the glorious sight. ");
	output("\n\nUrta shoots you a wicked little grin and takes full advantage of your stunned state. She ");
	if(!pc.isCrotchExposed()) output("strips you of your lower garments and");
	output(" slinks down between your spread thighs. Her body is now almost completely naked, her dress doing little more than covering her midsection. ");
	output("\n\nLooking down between your legs you get the perfect down view of her magnificent furry melons. Her erect inky nipples jut out impressively as if pointing directly at your loins. As her chest swells with each husky breath you let out a low moan. ");
	output("\n\nWith a lusty look in her eyes, Urta gives the underside of your [pc.cock] a nice long lick from base to tip. Your undercarriage is thoroughly slickened in her sticky saliva, lathering it in a wonderfully warm and moist sensation. You can hear an exquisite moan as she lovingly laps your length, swooning from the the scent of your steadfast erection.");
	//2nd dynamic text of Vixen & Cream
	output("\n\nThe voluminous vixen applies so much pressure to your pole that when she removes her tongue it snaps back as if released from a spring. She secures it with one of her hands and looks up at you adoringly, ");
	if (pc.balls > 0) output("all the while kissing down your slickened shaft.");
	else output("all the while pointedly squeezing your shaft.");
	if (pc.balls > 0) {
		output("\n\n\"<i>I think your balls need some attention, my love.</i> Urta breathily purrs, struggling to contain her own excitement. Your [pc.balls] are soon being lavished in loving licks and kisses by your black-lipped lover.");
		output("\n\nEach kiss is a sweet tribute to your glorious [pc.balls], a sign of her affection and devotion, both to you and them. She suckles on the sensitive flesh of your scrotum and teases it in her mouth, making <i>sure</i> to leave her mark.");
		output("\n\nHer brilliant green eyes stare up at you from " + (pc.isBiped() ? "between your spread thighs" : "below your cock") + ", filled to the brim with love. At the same time she tenderly smooches your sensitive spheres, showing her utter adoration for you in every way she can.");
		output("\n\nHaving Urta, someone who truly loves and cares for you, going down on your junk is positively mind-blowing. You're in heaven as she uses her sweet mouth and tongue on your nuts, your thighs trembling with pent-up pleasure.");
		output("\n\nIn a brilliant act of delicious revenge, Urta pulls back with a mischievous look the moment you feel as if you're going to blow your load. \"<i>Uh, uh! Not just yet, and definitely not </i>there<i>.</i>\" She squeezes your shaft, literally holding you right on the brink!");
	}
	//End of dynamic text
	output("\n\nUrta stares up at you through her thick lashes and then, once you are watching, slowly slides your [pc.cockHeadBiggest] into her mouth. You're riveted with pleasure as she goes down on your raging length, both from her incredibly sexy behavior and her mind-blowing oral skills.");
	output("\n\nNo longer caring about the risk of onlookers, Urta goes down on your slickened cock like your own personal pet. You reel in how <i>natural</i> it looks for her to be on her knees like this, her head bobbing up and down on your jutting manhood.");
	output("\n\nHer hands reach up and stroke the base of your " + (pc.biggestCockLength() >= 12 ? "long" : "") + " shaft. All the while her black lips clamp gently around the tip of your sensitive glans, suckling it hungrily like a sipping straw, hungry for it to deliver the naughty cream she craves.");
	processTime(15);
	clearMenu();
	addButton(0, "Next", vixenAndCreamPart3);
}

private function vixenAndCreamPart3():void {
	clearOutput();
	//output(images.showImage("urta-vixen-and-cream-part3"));
	output("You groan and let your head rest back, your hips lightly jerking as your furry lover wonderously sucks you off. Each twitch of your lower body is met with a moan of satisfaction from your tentative lover, the vibrations of which travel through your bliss-filled shaft.");
	if (pc.balls > 0) {
		output("\n\nFrom below, her soft, furry fingers reach up and cradle your [pc.balls], even as she sensuously sucks you off. Soon she is squeezing and massaging your sensitive sack, shaking up your semen-filled milkshake before it spills between her lips.");
		output("\n\nYou can't be anything but a slave to her magical hands and mouth, pressing your cock and balls forward like some kind of primal offering. It seems to be a tribute to her liking, as Urta noisily sucks you off. ");
	}
	output("\n\nIt's not long before the first offerings of your \"special cream\" are delivered and your pre-cum is dribbling out into her mouth. The second your exquisite taste hits her tongue, she pulls back and smiles wickedly at the milky fluid gathering lewdly on your opening.");
	output("\n\nAt first you don't think she's going to do anything, but then Urta sensuously touches her tongue against it. She scoops it up and then pulls back, a long sticky string of your spunk lewdly linking your tip and her cum-coated tastebuds. ");
	output("\n\nUrta then stretches back until the slimy strand breaks, letting the severed length fall all over her bare breasts. Her black lips are also smattered with your pearly cream, her eyes dilated with drunken lust. Licking up the spoils of her victory, she dives back down on your shaft hungry for more.");
	output("\n\nYour vixen lover continues to suck you off like a needy cum whore in the bar, seemingly oblivious to anything but the existence of your delicious, spunk covered cock. Her lewdness propels you forward to the brink of ecstasy as the captain of the guard goes down on you like a cheap prostitute, sucking you off on her hands and knees.");
	output("\n\nEach bobbing movement causes your flexing glans to connect with the back of her throat and her saliva to liberally drool around your shaft, creating a sticky mess. Eager to take you all the way down her throat, Urta continues to try to take you deeper, trying to bury you deeper down her oral chasm. ");
	output("\n\nAt first she gags a little, but after a few more stubborn tries you feel her throat finally yield and your [pc.cockHeadBiggest] slip into her gullet. She immediately brings her jet black lips flush with the base of your member, looking up with you with pride in her striking green eyes.");
	output("\n\nYou tremble with delight as she lovingly slides your [pc.cockBiggest] back and forth in her throat. She gurgles noisily around your length and uses every trick she knows to secure your delicious cream, including stroking your sensitive scrotum and perineum."); //Originally, there were plans to put races but it was cut out due to complexity.
	output("\n\nThe second her finger rubs between your balls and ass, you let out a sharp cry and achieve blissful release. You feel a trail of fire washing through your body shortly before you spasmically shoot your hot cum into her mouth.");
	//3rd dynamic text
	if (pc.cumQ() < 250) {
		output("\n\nUrta shivers with pleasure as a geyser of your virile spunk erupts in her muzzle. Like an erupting volcano, your [pc.cockHeadBiggest] keeps shooting, filling it to the brim with your [pc.cum]. She swallows it eagerly only to have it replaced by another gooey load. ");
		output("\n\nUnwilling to let any go to waste, your vixen lover buries it deep down her gullet and lets your [pc.cockBiggest] pulse and spasm inside her throat. She nurses it deep in her neck and caresses your pulsing nuts, almost as if coaxing out your delicious cream.");
		output("\n\nUrta pulls back off your spurting length and grips your base, milking every drop of spunk from your pipes. With a cum drunk look in her eyes she lets it pool and collect on top of her tongue, utterly relishing in your delicious salty taste.");
		output("\n\nEven afterwards you are still painfully stiff and sensitive, no doubt due to her expert ministrations. Urta utterly relishes in this fact, sucking teasingly on your rod and watching you shiver deliciously in response. ");
		output("\n\nYour hips rise and you give her one last aching spurt of your glorious goo across her curling tongue. Afterwards you fall back in into the booth with both your mind and body engulfed in a wonderful, bliss-filled haze.");
	}
	else {
		output("\n\nLike an erupting volcano, your [pc.cockHeadBiggest] shoots geysers of molten milk inside Urta's muzzle.  She swallows it eagerly only to have it replaced by another gooey load. Soon her furry cheeks are billowing out as they are packed full of your creamy jism.");
		output("\n\nStruggling to reign in your raging beast, your experienced vulpine lover secures your [pc.cocks] in her hand. She squeezes it and forces your [pc.cum] to come out in powerful, controlled bursts, clearly a trick she learned from dealing with her own potent phallus. ");
		output("\n\nYour eyes roll back into your head as your explosive orgasm is repeatedly squeezed off and released. Your mind is utterly <i>destroyed</i> by the incredible sensory overload!");
		output("\n\nYou animalistically unload your milked jism into her furry mouth, all the while spasming and twitching. Each built-up burst is met with a rewarding, cum-coated lick of your [pc.cockHeadBiggest] and a whimper of unadulterated bliss from your lips. It's as if you're dying from pleasure, your entire existence swallowed in delirious ecstasy.");
		output("\n\nCompletely consumed by your heavenly state, your earthly body continues to splurge inside Urta's mouth with its thighs spread and trembling. It takes you a very long time to come back down, and even then both your mind and body are still engulfed in a wonderful, bliss-filled haze.");
		output("\n\nPulling your [pc.cockHeadBiggest] from her mouth, it seems even Urta couldn't swallow everything you had to give. Your cum gushes from her wet black lips and drools down her chin and ample cleavage, covering her in your steamy mess. She's not the only one as your spunk dribbles out and warmly bastes your stomach. ");
		output("\n\nIn the wake of your glorious orgasm, Urta grabs her delicious cans and massages them together, wet smacking noises filling the air as she smears your semen all over her grey furred breasts. The sensuous sight causes one more slimey rope to jump from your [pc.cockNounBiggest] and splatter her on the cheek, marking her even more with your jism. ");
		output("\n\nEven after all that, you're still painfully stiff and sensitive. Urta brings her slimy, spunk covered cleavage up to your rod and presses it between them, smearing it all over your staff. She then sucks it all off like you're a wonderful cum-flavored lollipop, watching you shiver deliciously in response. ");
	}
	output("\n\n");
	if (pc.cumQ() >= 250) output("Taking advantage of your post-orgasmic paralysis");
	else output("Seizing her chance");
	output(", your buxom lover slides cutely into your lap and wraps her arms around your neck. You can see [pc.cumColor] streaks smeared on her lips, face, and breasts, and the most beautiful, glittering look in her eyes. It's as if you have given her the most magnificent gift in the whole wide world.");
	//End of dynamic text
	output("\n\n\"<i>I simply adore the taste of your spunk. I was a good girl and lapped it all up" + (pc.cumQ() >= 250 ? " - and there was a LOT of it!" : "") + " Are you proud of me...?</i>\" Urta cutely asks, nuzzling your cheek. It seems she's seeking your approval.");
	output("\n\nYou reach up and run your hand through her head fur, telling her that she's been good. Your vulpine lover gives a gorgeous little blush and buries her [pc.cumNoun]-coated face in your shoulder. ");
	output("\n\nAs you caress her silky soft ears, Urta also makes another admission. \"<i>I was also really good and kept some for you, so you should be </i>extra proud<i>...</i>\" Pulling back, she opens her mouth and shows her her sperm covered tongue. Her tonsils have been literally bathed in your naughty spunk.");
	output("\n\nShe then shares this delightful present with you, leaning forward and pressing her stained lips passionately against yours. You return her affections and soon you are both feverishly making out, once again unable to keep your hands off each other.");
	processTime(25);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", vixenAndCreamPart4);
}

private function vixenAndCreamPart4():void {
	clearOutput();
	//output(images.showImage("urta-vixen-and-cream-part4"));
	output("The world seems to stop as you both share in the taste of each other's sweet saliva as well as your own deliciously unrefined seed. Not only does it feel loving and lewd, but also indescribably profound.");
	output("\n\nWhen you both pull back, there is a thin sticky strand linking your lips. Your eyes are lovingly locked together, simply gazing into each other's eyes. The soft string breaks and collects on her already " + (pc.cumQ() >= 250 ? "well" : "") + " battered breasts.");
	output("\n\nAfter such an amazing orgasm, you think it's only fair that you return the favor. With a light little smack on the height of her ass, you order your cum-glazed lover to get up on the table.");
	output("\n\nWithout the slightest hesitation Urta climbs up onto the table wearing nothing but her wine-colored dress bunched around her waist. Her massive udders hang beneath her, and her gloriously black nipples look puckered and stiff. ");
	output("\n\nBetween her grey furred thighs hangs her weighty apple-sized balls and her aching equine length. The pulsing veins in her sheathe show just how pent up she really is. Her usually well-hid pussy is completely exposed and glistening wet. ");
	output("\n\nNot only that, her naughty nectar has leaked down the back of her balls and thighs. The air is filled with the fragrant smell of her sweet girl juice and ball musk. ");
	output("\n\nHungry for both, you lean down and kiss one of her heavy orbs and suckle her lewd girl juice off of them. Her thighs and cock visibly quake with delight and she lets out an animalistic moan. ");
	output("\n\n\"<i>It's time I returned the favor, since you've been such a good girl.</i>\" You tell her, watching her fluffy tail flutter with delight at your words. \"<i>But first, we don't want to get the table wet, now do we...?</i>\"");
	output("\n\nInstead of responding she lets out a sweet little whimper and pushes her musky spheres insistently into your mouth. In turn you lovingly suckle and nibble on her low hanging fruit. They're definitely ripe and ready to eat!");
	output("\n\nWhile her produce truly is delicious, it's her tasty flower that you're more interested in. You slowly slide your tongue up the back of her equine sack, tracing upwards until reach her sopping wet slit.");
	output("\n\nUrta whimpers and instinctively arches her hips to match the caress of your tongue. With her tail held high she's acting like a vixen in heat, shamelessly displaying herself in her act of mating. Her primal womanly musk wafts from her pussy, inviting you to claim what is rightfully yours.");
	output("\n\nIt's a dizzying scent that immediately arouses your hunger, causing your manhood to ache with mating need. Seizing her thighs, you run your [pc.tongue] along her glistening black lips, caressing every inch. Your mouth is immediately rewarded with the succulent flavor of her arousal, tasting its proof on your tongue. ");
	output("\n\nThat single lick robs Urta of the ability to keep her torso upright. Her upper half falls to the table and her legs lewdly spread to take the weight. Meanwhile her cum-splattered breasts are pressed against the table and her horse cock is pointing at her face.");
	output("\n\n\"<i>How about I give your 'little stallion' some attention, hmm?</i> You tease, all the while sliding your fingers up the underside of her shaft. Her milky pre-cum drools out liberally from her flaring tip and she lets out a tiny little whimper.");
	output("\n\nYou forcibly grip the base of her naughty equine length and squeeze it, putting a stop to her free-flowing juices. Urta moans with the sudden pressure pooling in her shaft and balls and pushes her drooling muff instinctively into your mouth, desperately seeking release!");
	output("\n\nAssaulting both her sexes at once, you give her dick a few powerful jerks while teasing her vulnerable clit with your tongue. Her hips buck wildly as she lets out a liturgy of incoherent noise, truly trapped between your jerking hand and your ministrating mouth. ");
	output("\n\nEach movement causes your tightly gripping hand to slide up and down her shaft. Meanwhile you lovingly assault her pussy by softly biting and nibbling on her clit and labia, each tender pull and nibble causing her to positively melt with pleasure. You suck her nub into your mouth and lash it with your tongue, pushing her completely over the brink!");
	output("\n\nUrta's entire body goes into a spastic, stormy fit and she presses her face hard against the table, raising her hips up as high as they can go. Her lungs are emptied in a sinful howl that is no doubt heard by every person in the bar.");
	output("\n\nLower down you you can feel her hot cum gushing down her cock pipe and meeting at your tightly gripped hand. Unable to escape, Urta's eyes roll back into her head and she cries out in painfully exquisite pleasure. ");
	output("\n\nAs if to find another place to escape, she suddenly squirts and sprays your face with her warm girl juice. She marks your " + pc.faceDesc() + " like an animal, all the while gloriously arching in release.");
	output("\n\nWith an Urta-splattered face, you grab the empty pitcher and put it under her flaring head like a equine shaped beer tap. Finally releasing your grip, she lets out a sharp cry and unloads gooey torrents of her spunk into the glass, lewdly filling it up.");
	output("\n\nEven after the pitcher is half filled, your overproductive lover continues to shoot creamy gushes deep into the makeshift container. She unloads submerged shots in her own seed like dirty depth charges, forcing even more to pool upward.");
	output("\n\nUrta lets out a delighted moan as you gently grab her pulsing length. You then proceed to milk her fresh, piping hot spunk into the pitcher, tenderly squeezing it out of her length until she's completely spent.");
	output("\n\nWith her cunt sensitive from her sweet climax, you lean inward and bury your face in her musky black pussy lips. You then slide your tongue as deep inside of her heavenly pussy as it will go, and hungrily lap up her wetness from the inside.");
	output("\n\nEverything else is swept away but Urta and her mind-melting taste. You can feel her trembling and squealing with pleasure as you dart and lash her slick inner walls with your tongue, greedily stealing her ambrosial nectar for yourself. ");
	output("\n\nIt's not long before your open mouth is met with a second round of spurting girl cum. She liberally creams herself into your open mouth and you swallow it with relish, all the while swooning at the taste of her heavenly juice.");
	output("\n\nAfter you pull back, you sit down and slowly pull Urta into your lap. It's slow going as she's in a blissful trance, barely able to sit up let alone move. Finally you manage to get her there and pull her into a deep, passionate kiss, both showing your undying affection for her and giving her time to recuperate.");
	output("\n\nWhen she pulls back, her deep green eyes seem deliciously spacey, yet she's regained the ability to speak. \"<i>... That's... did I squirt on you?</i>\" She seems unable to recall the finer details of such a mind-blowing experience.");
	output("\n\n\"<i>You did, my love. Twice.</i>\" You happily inform her. She snuggles into you and presses her muzzle against your neck - it's hard to tell if she's delighted, embarrassed, or both!");
	pc.lust(pc.lustMax(), true);
	clearMenu();
	addButton(0, "Next", vixenAndCreamPartFinal);
}

private function vixenAndCreamPartFinal():void {
	clearOutput();
	//output(images.showImage("urta-vixen-and-cream-part5"));
	output((flags["COC.URTA_VIXEN_AND_CREAM_COUNTER"] == 0 ? "That's the first time I've ever done that." : "You're the only one who can get me to do that.") + " You're... you're just amazing.</i>\" Urta bashfully whispers, then lovingly kisses your neck. It's a little funny considering how incredibly loud and shameless she was not long ago.");
	output("\n\nShe kisses you, and you can feel her naughty pussy and hefty balls rubbing against your naked crotch. At the same time, her sticky equine length is caressing your stomach. It begins to get you quite hot and bothered.");
	output("\n\n[pc.EachCock] spring" + (pc.cockTotal() == 1 ? "s" : "") + " up and rub" + (pc.cockTotal() == 1 ? "s" : "") + " against her sex from below. Your lover moans and wiggles with delight; her snatch still slick and sensitive from her climax. \"<i>Oh! Quite a go getter, aren't you? How lucky of me to have a lover with as much stamina as I do,</i>\" Urta purrs out. Her compliment is followed by a soft suckling bite of your neck. You tell her you need a lot of stamina to keep up with her 'little stallion'.");
	output("\n\nUrta pulls back from your neck and gives you a meaningful look. You're marvellously lost in those brilliant green eyes of hers. Not another word is spoken and your lips inch closer together. It's not long before they are sweetly locked in unison and you are melting together. You are totally lost in each other's loving warmth.");
	output("\n\nBoth of you then begin to kiss each other with overwhelming need. It's as if you have both been seized by a maddening need for each other's taste, yet are unable to quench it. Your bodies needily rub against each other and create delicious friction. You can feel both " + pc.multiCockDescript() + " and hers rubbing and pressing achingly hard against each other.");
	if (flags["COC.URTA_FERTILE"] > 0) output("\n\nUrta breathily slips out words between each kiss, unwilling to part her lips from yours for more than an instant. \"<i>I want.</i>\" Kiss. \"<i>You.</i>\" Kiss. \"<i>Inside of me.</i>\" Kiss. \"<i>And I want.</i>\" Kiss. \"<i>You</i>\" Kiss. \"<i>To give me your child.\"</i.> Your vulpine lover rubs your " + pc.cockHead() + " against her slick velvety lips. You can feel her desperate yearning for you inside of her and your " + pc.cockDescript() + " filling her with your virile seed. ");
	output("\n\nUnable to restrain yourself a second longer, you grab her curvy thighs firmly between your hands, and lift her above your [pc.cockHeadBiggest]. She moans as it rubs against her slick velvety lips, and her slick wetness drools down your [pc.sheath].");
	output("\n\nYou lower her down on your [pc.cock], and at the same time, thrust up to meet her . Her moist folds gently caress your member. Soon you are gloriously sheathed inside of her, and her hot warmth radiates around your length.");
	output("\n\n“Fuck me!” she breathily whimpers, all the while grinding her hips and pussy against your base. You grind together in primal rhythm, pressing your [pc.cockHeadBiggest] deep into her snatch. Her full breasts and black nipples bounce in front of your eyes, adding more fuel to your carnal thrusts.");
	output("\n\nYour thighs slap against the underside of her furry ass as you bounce her in your lap. Her moist walls sloppily caress your [pc.cock] with each bounce, and you let out a guttural moan. Your pre-cum drools inside of her, and mixes with her slick juices. You are reeling with ecstasy, and you passionately dig your fingers into her supple rump.");
	output("\n\nUrta's eyes are glazed with pleasure, and her ears are flattened back. Her fingertips are digging into you. She's feverishly gyrating and grinding in your lap. Your [pc.cock] is stirring around inside her tightly clenching cunt, rubbing and stroking her sopping wet insides.");
	output("\n\n\"<i>Mate me--! Shoot your hot, sticky cum inside of my womb and fill me up, my love!</i>\" she cries out, begging to be fucked and impregnated by her stud. Her round, furry butt bounces in your lap. Her soaking wet cunt is smolderingly hot, more so with every passing second.");
	output("\n\nYou moan with delight as your [pc.cock] is milked and squeezed by her equine snatch. Your aching member is surrounded by slick, gripping warmth. It is wetly stroked as Urta bounces in your lap. She's uncontrollable right now, and you grab her furry waist, holding on for the ride!");
	output("\n\nHer black lipped sex is flaring, and her sex utterly 'reeks' like a needy bitch. She's in heat, and a intense breeding fever has claimed your vulpine lover. Moaning and bouncing in your lap, she won't be satisfied until you give her your fertile seed. ");
	output("\n\nHappy to help, you thrust up to meet her rocking hips, and your [pc.cockHeadBiggest] slides up and kisses the entrance to her womb. She lets out a whining sigh, the primal part of her mind rewarding her with a rush of endorphins, as you mate her with your [pc.cock]. You both grind madly against each other, the smacking sounds of your juices and thighs filling the air. ");
	output("\n\nYour vulpine lover whines and grips you hard. There's drool dribbling down her chin, and she's undulating her hips against you. Your [pc.cock] is stirring her warm, juices up, and she's whimpering with delight. Her own pearly spunk is drooling from her stallion head and all over your [pc.chest].");
	output("\n\nSuddenly she clenches your [pc.cock] with insane stiffness. Her stallion rod jerks back and slaps between her tits, and thick ropey spurts of white shoot out of her flaring head. It splashes all over her face; smearing her blissful expression with her gooey cream. Her pussy wildly squirts against your pelvis, and coats your [skinFurScales] in her girl juice.");
	output("\n\nHer spasmic clenching and delirious look pushes you over the edge. You grab her waist and thrust your [pc.cockHeadBiggest] right up to the mouth of her " + (flags["COC.URTA_FERTILE"] > 0 ? "fertile" : "welcoming") + " womb. With a carnal cry, you liberally unload and fill her up with your virile spunk, claiming your lover’s pussy as your own.");
	output("\n\nYou both shudder against each other in mutual release. She sprays her spunk all over her face as you give her pussy a glorious cream filling. Urta has a dreamy expression on her face. She looks like a sexy cum whore, with her face, breasts, and cunt absolutely battered with spunk.");
	//4th dynamic text
	output("\n\n");
	if (pc.cumQ() < 250) output("You passionately kiss each other, and then you pull out your [pc.cock]. As you do, a flood of your spunk comes pouring out of her parted black lips, and drools down between her furry buttocks.");
	else output("You passionately kiss each other, and then you pull out your [pc.cock]. As you do, a flood of your spunk comes pouring out of her parted black lips, and stream down her furry buttocks. Urta lets out a bittersweet sigh as you pull out, and dreamily looks up at you. Her delicious cream is pooled on her flat equine glans like a cock cup.");
	//End of dynamic text
	output("\n\nUrta’s gooey spunk overflows and runs down her pink and black length with each little spasmodic flare. Not one to let it go to waste, you lovingly go down on her stallion cock, and dip your tongue into her slick, sticky cream. The rich taste of her spunk teases your tastebuds as you lap it up, and you moan with pleasure.");
	output("\n\nWatching your sensuous lapping and your tongue tip on her sensitive glans is too much for Urta. She throws back her head and trembles with delight. You can hear her whimpering as you lap at her cock, and her thighs are madly trembling. Unable to cum again so soon, she’s being driven mad by the pleasure, and soon she’s letting out a gasping whine.");
	output("\n\nWith a mischievous smile, you lash her flaring glans with your tongue, relentless in your assault. You don’t stop until you’ve scooped up every delicious drip of her musky spunk, and then you slide up her cum splattered body. You passionately seize her and pull her close, before delivering the coup de grace; a long, feverish, tongue-filled kiss.");
	output("\n\nUrta moans into your mouth and wraps her arms around your neck. You can feel her trembling with delight as you share her spunk with her for the second time, and fill her mouth with her own lewd taste. When you pull away from each other there is a long cum strand linking your lips and her cheeks flush.");
	output("\n\n<i>\"I’m—um… </i>wow<i>,\"</i> she murmurs, lost for words. Neither of you need them anyway. Instead, you grab the pitcher full of her broiling spunk and her whisky, and pour each of you a lewd cum cocktail. She happily downs it with you, both of you savouring the rich and distinctive flavour of her love juice.");
	output("\n\nShe nuzzles into you, naked and sweaty, and tells you that she loves you. You stroke her head for a while, enjoying the moment, before you both make a futile attempt at cleaning up. You really made a mess of the booth!");
	output("\n\nWhen you finally walk out to the bar proper – utterly dishevelled - there are eyes on you both from every direction. They’re followed by cat calls and whistles; apparently you both made a <i>lot</i> of noise!");
	output("\n\nUrta becomes shy at the noise, especially since she wasn’t able to get all the cum out of her fur. Noticing this, you grab her in your arms, and look deep into her eyes. She stares back, captivated, and you give her a long and passionate kiss.");
	output("\n\nWith such a public display of affection – not to mention the noise you were making – there’s no doubt of the devotion you have for each other.");
	output("\n\nAfter what seems like a delightful eternity, Urta pulls back and looks wistfully into your eyes. \"<i>Um… drinks tomorrow, then?</i>\" Her voice is breathy and excited. It seems she likes being shown off.");
	
	processTime(45 + rand(10));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	if (pc.libido() < 60) pc.slowStatGain("l", 1);
	for (var i:int = 0; i < 3; i++) { //Attempt 3x
		knockUpUrtaChance();
	}
	IncrementFlag("COC.URTA_VIXEN_AND_CREAM_COUNTER");
	urtaLove(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}


public function chastityBeltFun(cameFromSexMenu:Boolean = true):void
{
	//The intro to this scene is for when you pick the scene from Urta usual sex menu. Previous scene has a different intro.
	//Becomes available as a Sex Scene for Urta when she’s alone.
	clearOutput();
	if (cameFromSexMenu) {
		output("Eyeing your foxy lover, you tell her to lose the condom, you have something else planned.\n\n");
		output("“<i>Lose it?  What do you have in mind?</i>” Urta asks.  She looks past you towards her cupboard.  “<i>Oh, no, not that belt!  ...Do you really enjoy seeing me make such a mess of myself when I finally get it off?</i>” she protests.\n\n");
		output("You nod your head in affirmation, telling her it’s always quite a sight seeing her melting into a pile of pent-up jism, ready to blow.  And the results are also fun to watch, it’s not everyday you get to see a literal geyser of fox-cum erupting out of a horse-cock.  You also add that you’re always happy to help her clean up afterwards.\n\n");
		output("“<i>And you ought to be, you cause the mess,</i>” Urta states, blushing fiercely and not able to look you in the eye. “<i>...Do you really find it that hot to watch me whimper and squirm and beg for you?</i>” she asks, so quietly it’s almost a whisper.\n\n");
		output("You walk towards her bed and stroke her cheek, telling her she makes the cutest ‘puppy eyes’ you’ve ever seen.  Urta trembles, and, almost despite herself, her tail starts to wag, allowing the hesitantly erect pillar that is her huge horse-prick to bob back and forth in front of you.\n\n");
		output("Smiling, you turn to pick up the belt and hand it over to her, uttering a single command, “<i>Put it on.</i>”  Urta discards her condom and hesitantly takes the offered belt, opening it; slowly she guides her erect shaft into the slot, stopping when her flared tip touches the padded entrance of the tube.  She looks at you, looking for some sort of guidance or confirmation that is really what you want.  You just shoot her a look of impatience.  With a sigh and a groan, she begins pushing her shaft into the rather tight tube.  Grinning mischievously you help her by going around her and pulling the belt all the way, eliciting a whimper from the herm-fox.\n\n");
		output("“<i>N-no fair...</i>” she whimpers to you.  “<i>This is already so hard to put up with...</i>”  You tell her you were merely trying to help her, since she seemed to be having such a hard time putting it on... if she wants you can finish up for her.  She swallows audibly and nods her head, reaching back with one trembling hand to offer you the keys.  You try to take the keys from her, but she refuses to let go.  You cough, indicating that you can’t continue unless she lets go of the keys.\n\n");
		output("“<i>Wha? Oh, sorry.</i>”  She blushes, hand trembling wildly before she visibly forces herself to drop the keys into your hand.  “<i>...Please don’t make me wait too long before using them, alright?</i>” she meekly asks.\n\n");
		output("You reply that you don’t intend to... then quickly snap the the belt shut, snugly against her soft furry buttcheeks and twist the key in the lock, sealing Urta in her metaphorical jail.  Getting up you dangle the keys in front of her eyes and smile triumphantly, teasing her by telling her this is a wonderful pair of panties she’s wearing.");
	}
	else { //Follow up from previous scene, Urta needs to undress!
		output("Swallowing hard, Urta gives you a pleading look as if hoping against hope that you’ll change your mind.  You suddenly tell her to stop!  Urta stares at you, expression changing to one of joy, a wide grin so thankful it’s almost silly spreading across her face at the prospect of avoiding this.\n\n");
		output("Seeing this, you laugh, telling her not to get her hopes up... you still want her to go on with it.  You just think the two of you should move into her bedroom.\n\n");
		output("Urta throws you a look that combines an obvious tone of “you bastard” with a strong undertone that she’ll get you back for this, somehow.  Still, it doesn’t stop her from heading into the bedroom.  Once there, she looks at you, still hoping for one more chance at a last-minute reprieve.  Seeing that it’s not forthcoming, she sighs and resigns herself to her fate.\n\n");
		output("Urta slowly and seductively peels off her dress until she’s standing naked before you.  When you make no effort to tell her to forget the belt, she sighs and turns around to step inside it; flashing you an excellent view of her ass and pussy as she pulls it up to her waist.  A little fidgeting and she manages to get her sizable yet still sheathed cock safely ensconced inside of it, clamping it shut and locking it, before flicking the keys to you, which you catch.\n\n");
		output("Dangling the keys before her eyes teasingly, you watch as she lowers her guard for a moment, before you lunge forward and deliver her a passionate kiss, straight to her lips.  Urta eagerly returns the kiss, moaning throatily into your mouth as she embraces you.\n\n");
		output("Stepping away with an evil grin, you tell her that she looks wonderful in her new ‘panties’.");
	}
	output("  Urta puts on a weak grin and tries to strike a pose, tail brushing low against the ground, one hand resting on an outstretched hip, ass flagrantly displayed at you despite its encumbering coverage.  “<i>Oh, do you think so?  It doesn’t make my bum look too big?</i>” she asks, blushing with embarrassment, which rather takes away from the air she’s trying to exude.\n\n");
	output("You walk around her, looking her over; then deliver an echoing slap on her butt, groping it roughly as you tell her that her bum looks just perfect - Urta lets out a very vulpine yelp at the sudden spanking you just gave her.  Your other hand goes to her bushy tail, lifting and stroking it lovingly, as you enjoy its silky, fluffy feel.  Yes... she looks just perfect like this... you finish your sentence with a second slap on her other asscheek.\n\n");
	output("Urta moans - is that a creak you hear from her chastity belt? - and then shivers.  “<i>You are such a flatterer,</i>” she says, looking abashed but unable to resist wagging her tail in delight at the compliments.\n\n");
	output("You comment that you’re feeling thirsty and that she should fetch you something to drink, while you get comfortable.  Urta looks for a moment like saying something, but then goes to get you something to drink - she walks away in quite a funny manner, somewhat hunched over and awkwardly shuffling.  Her cock must be really straining against the padded interior of her belt; it’s throwing off her balance.\n\n");
	output("While she’s away you proceed to strip off your clothes, fold them neatly and place then in a safe corner of the room.  While waiting for Urta to return, you strike a few poses on a nearby mirror, trying to find the best one for when your foxy lover returns.  Once satisfied, you lay on her bed and wait for her return.\n\n");
	output("Urta returns, wobbling a little less; her erection must have started to subside or else she somehow got herself a little under control while she was gone.  She offers you a thick, cheap-looking clay mug.  “<i>I only have water; is that okay?</i>” she asks nervously.  She then catches sight of you and her eyes bulge out; she almost drops the mug, but manages to catch it before she spills more than half of its contents.\n\n");
	output("You laugh inwardly... who knew teasing was so much fun?  You tell her water is fine and that she should bring it to you.  Urta just stares at you for a few moments, jolting back to reality when you repeat yourself.  Swallowing hard, she awkwardly advances towards you; you almost think you can see her meaty prick straining against the reinforced metal and leather of her chastity belt.  She really is hard-pressed to withstand temptation, even with that thing on.  Finally reaching you, she gingerly stretches out her hands to offer you the mug.\n\n");
	output("You take the mug and tip on your mouth, purposely letting some spill, forming rivulets of water across your " + pc.skin(true, false) + ", " + (pc.hasBreasts() ? "past your breasts and down" : "down your chest and over ") + " your belly.  With a look of mock disappointment, you tell Urta you seem to have spilled some water, maybe she should take care of it?  Urta nods her head and immediately starts to head for a closet to fetch you a towel.  But you quickly stop her, by telling her that you want her to lick you clean.\n\n");
	output("“<i>L-lick you!  What do I look like, an animal!?</i>” Urta snaps, indignantly, tail bristling in outrage.  You calmly remind her of her current predicament... and that you, alone, hold the keys to her freedom.  The fox-morph glares at you, growling deeply enough to remind you you’re basically teasing a fox the size of a human being.  You just smile back at her, confident she won’t hurt you.  She stares into your eyes levelly, but, seeing you won’t back down, finally gives in.  “<i>Oh, very well,</i>” she sighs, then tries her level best to sashay towards you.  “<i>You going to get on the bed? Or are you going to make me get down on my hands and knees?</i>” she huffs.  You merely ask her what does she think you’re going to do?\n\n");
	output("Urta heaves a long suffering sigh and kneels down before you.  Gently taking hold of your [leg], she leans her head in and sticks out her long, broad tongue, running it gently up one running trail of water.  Despite her initial protests, Urta is very thorough, making sure she gets every little bit of moisture from your [pc.skin], replacing the water with her saliva.  You enjoy both the treatment and the power you have over your fox-herm girlfriend immensely.  You congratulate her on her dedication by gently patting her head and stroking your hand along her hair and triangular ears.  At one point you realize that her tail is wagging... quite happily actually... making you question her earlier protests.\n\n");
	output("When she finally hikes her way all the way up to your chin, you take a hold of her head and pull her into another deep kiss, invading her mouth with your [pc.tongue], tangling and dancing with her own canine tongue, moaning into the kiss to excite Urta as best as you can.  Urta is eager to kiss you back, snaking her arms around the back of your neck in order to pull your face against hers.  Through the sounds of your kiss, you become aware of a faint but constant dripping sound.  Breaking the kiss, the two of you look at the floor; Urta’s cock might be physically restrained, but nothing’s stopping it from bubbling precum, which has pooled inside of her cock-tube and is now seeping through the padding and the leather to drip noisily onto the floor.  Urta blushes fiercely.  “<i>Well, I did say this wasn’t good for me - I’m too excited for it,</i>” she says, defending herself.\n\n");
	output("Thinking quickly, you put your mug under her to catch the droplets of pre and suggest the two of you move into the bathroom?  Should be easier to clean up than her bedroom... The vixen nods dumbly at you, then actually takes the mug from your hands, holding it under her steady flow of pre and begins leading you towards what passes for the bathroom in this cheap little apartment of hers.\n\n");
	output("Once there, you realize that the cup is close to overflowing and a wicked idea hits you.  Smiling smugly at Urta, you suggest that she should empty the cup... by drinking its contents!\n\n");
	output("If you were expecting a protest, though, Urta surprises you.  She gives you the most sultry grin she can manage, lifts the glass to her lips, and starts to chug it down, audibly gulping swallow after swallow of hot jizz until the sizable mug is empty.  She looks you right in the eyes as she licks a small trickle of cum from either corner of her mouth, burping softly and gently before placing her fingers to her lips with an exaggerated giggle.  “<i>Satisfied?</i>” she asks with the vulpine equivalent of a purr.  After this little display... you reply that no, you aren’t.  In fact you’re feeling pretty hot now... Urta could-\n\n");
	output("Urta interrupts you with a heave of exasperation.  “<i>If you want anything more from me, dear, you’re going to have to let me out of this thing before I explode,</i>” Urta tells you with a sense of urgency.  She taps one finger on the protrusion that holds her cock, which is now oozing a constant streamer of jizz to splat wetly onto the floor, for emphasis.  “<i>Lemme out of this thing before I wrestle you to the floor and take the keys - and if I gotta do that, I swear to Marae I will ram this cock of mine right up your ass and flood you with every last drop you’ve teased out of me!</i>” she vows.\n\n");
	output("Okay... judging by her look you can tell that she intends to do just that if you refuse... so you tell her that’s fine.  You’ve had your fun and Urta certainly earned her freedom; considering the amount of cum leaking from her cock-prison... perhaps she should get in the shower?\n\n");
	output("She nods eagerly and shuffles into the shower, pulling aside the cheap curtain and motioning you to follow her.  You quickly do and holding the extrusion containing her cock, you tell her to brace herself.\n\n");
	output("With a quick twist of the key, you pull the belt off her as fast as you can, causing her erection to spring up and slap her on the belly as it finally erupts into a veritable geyser of cum, painting the walls, the ceiling and you and Urta both, in thick, hot, fox-cum.  Urta sighs hugely, visibly slumping with relief even as her cock continues to bulge and then geyser gush after gush of cum.  “<i>Ohhh... that feels so, so good, [pc.name],</i>” she tells you.  She just hangs her head and lets the waves of orgasm ripple through her, visibly bloated balls shrinking before your very eyes as they empty themselves of the pent-up frustration you’ve helped Urta accumulate.\n\n");
	output("Wiping your face clean of the spunk, you tell Urta that this is indeed an impressive amount of cum... but perhaps a bath is in order now?  Urta nods, then puts a finger to her lips and thinks it over.  “<i>I oughta make you lick this off of me... but I’d rather a hot shower anyway,</i>” she declares.\n\n");
	output("With a smile you turn the faucet and let the initially cold water rinse most of the cum off of your bodies.  You help Urta wash by gently massaging her fur, even rubbing yourself against your hot fox lover; then slowly grasping her still sensitive shaft and giving it a few good pumps.  Urta moans and thrusts her cock into your pistoning hand, managing to dredge up a few last sizable spurts of goo that splat wetly into the floor and are swiftly washed away down the drain.  She says nothing, simply looking deeply into your eyes while you help her clean herself down.\n\n");
	output("Once done you ask her where you can get some towels?  “<i>In a cupboard, just there,</i>” Urta tells you, pointing to a small cupboard built into the wall of the bathroom.  Nodding, you quickly go fetch the towels, handing one to her as you begin drying yourself.  Once fully dried up, you look at Urta and realize that she’s still dripping wet.  You begin to form a question, when suddenly you realize the evil stare she’s giving you... before you can scream your protest, you watch as she braces herself on the wall and begins shaking herself, flinging wet droplets of water all over your, formerly, dry self.  Looking at you with as much innocence as she can muster, which is not much by the way, Urta says, “<i>What?  This is how I get dry!</i>”  You glare back at her as she does her best to stifle a laugh.\n\n");
	output("You quickly dry yourself... again.  And then help Urta.  Urta struggles and protests at your efforts to dry her off, but accepts it.  Finally, she laughs and whips the towel off.  “<i>I don’t know if I hate you or love you for what you just put me through... but, all in all, I do love you, so... no hard feelings, okay?</i>”  She asks, giving you her most winning smile even as she approaches a tiny sink and takes up a comb, which she starts running through the tangles of her fur.\n\n");
	output("Looking Urta over, her fur is in serious need of a good combing... especially her tail... you smile at her and ask if she has a spare comb?  Urta blinks, surprised, but takes up a second comb from the sink’s side and hands it over to you.  You gently take her tail in hand and begin combing through it, doing your best to deal with tangled fur without hurting Urta.  Urta lets out a quiet yelp of surprise, then growl-purrs in pleasure at your ministrations; she has to fight to keep from messing things up by wagging her tail.  She leans against you and combs her fur, allowing you sole responsibility for handling her tail.\n\n");
	output("Finally done, you ask Urta to give you a little twirl.  Urta does as you ask, giving a quiet giggle as she does so.  “<i>How do I look?</i>” she asks.  As lovely as ever, you reply with a thumbs up.  Sadly... you need to get going soon... so you give your vulpine lover one last kiss, redress and start on your way back to camp.");
	processTime(45 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

////Surprise Threesome Selected
////PC tells Urta to meet in a back room in 30 minutes, then pays runner to send a note to Raphael.
////PC leads Raph to the same back room, then comes in kissing him....
//internal function urtaAndRaphaelSurprise():void {
	//clearOutput();
	//output("Letting your lips split into a mischievious grin, you lean across the table and whisper into Urta's fluffy ear.  \"<i>Why don't you meet me in one of the back rooms with the lights off in about thirty minutes?  I'll see if I can get a friend, we can make a party of it.</i>\"");
//
	//output("\n\n\"<i>That shounds aweshome,</i>\" Urta purrs drunkenly as she stumbles into you, groping you unashamedly.  \"<i>I'm gonna be sho ready for you...</i>\"  She presses her semi-hard shaft against you in an unspoken promise of sensuous pleasure.  You're sure that if she wasn't drunk it would already be throbbing against you, and the way Urta's grinding, it might get that way in a hurry.  The inebriated vixen kisses you with alcohol-stained lips before turning away and sashaying towards one of the private rooms in the back.  She lifts her tail and wiggles her butt in your direction as she drunkenly wobbles her way towards a door.");
	//output("\n\nNow... for the other half of this plan.  You just need a certain rouge rogue to make his way over here so that you can drag him into an 'accidental' tryst with the captain of the guard.  Just thinking about it makes your [pc.vagina] moisten");
	//if(pc.hasCock()) output(" and [pc.eachCock] experience a twinge of excitement");
	//output(".  Grabbing a napkin and a pen from an accommodating waitress, you jot out a hasty missive:");
//
	//output("\n\n<i>Dearest Rogue,");
	//output("\nI find myself locked in the fondest of remembrances for the things you've taught me, both in the realm of fencing and love, and a certain light-headedness has set in.  I've been all alone, with nothing but my meal and this fine vintage of wine to keep me company.  Even Urta, who's usually here this time of day, isn't here to regale me with her lesser tales - something about important business to tend to, I hear.  Would you come call on me at the Wet Bitch?  I have need of your skills, if you catch my meaning.");
	//output("\n\n\t\tAwaiting the thief who stole my heart,");
	//output("\n\t\t\t-[pc.name]</i>");
	//output("\n\nThat should do it.  The ");
	//if(cor() > 66) output("pompous, ");
	//output("ginger fox can't resist an offer like that.  Stepping past a group of drunken canines, you make your way out into the city in search of a runner.  You're in luck!  One of the orphans that works for him is panhandling nearby.  You step closer, nearly doing a double take when you see the size of his take.  The little guy has made more money begging than most honest craftsman can make in a hard day's work.  Sighing, you pass him the note with instructions that he deliver it directly to Raphael.  At first, he feigns ignorance, but after he recognizes you, he nods solemnly.  Apparently being the consort of a master of thieves has its PerkLib.");
//
	//output("\n\nTurning back, you saunter confidently into the bar and get yourself that bottle of wine.  Deception is thirsty work after all.  The next fifteen minutes pass in a blur of grape-stained enjoyment and simple people watching.  There's a scout who's just returned from the outside a table over, cuddling with his crush.  They're all over each other, sharing the happiness of two long-separated lovers.  On the other side of you, two centaurs are trying to play poker, but one of them is apparently cheating, at least according to the younger stallion.  You take another swallow of the subtle brew and recline, just taking it all in before the real work starts.");
//
	//clearMenu();
	//addButton(0,"Next",raphaelAndUrtaPartTwo);
//}
//
//private function raphaelAndUrtaPartTwo():void {
	//clearOutput();
	//output(images.showImage("urta-raphael-3some","vert"), false);
	//output("Narrow, familiar paws suddenly encircle your waist, and a puff of hot breath exhales past your ear.  \"<i>Greetings, my supple swan.</i>\"");
//
	//output("\n\nSmiling, you turn your head so that you can see the familiar fox's lips, \"<i>Raphael, you rapscallion!  Couldn't you have just pulled up a seat?</i>\"");
//
	//output("\n\n\"<i>Ah, but that would not fit my style, my dove,</i>\" he confidently rebuts.  The hands squeeze your [pc.hips] affectionately as he slides around your side, hefting the bottle you've mostly emptied.  \"<i>Mon deiu! I've come just in time, it seems!</i>\"  He lifts the bottle and swallows the last few bits on his lonesome.  Wiping the excess from his fur, he says, \"<i>I must protect my lady's virtue.  It wouldn't do to have her drunk, horny, and alone in a strange place full of uncouth barbarians.</i>\"  His eyes flick back and forth, and he whispers, \"<i>Like these.  Surely there is somewhere more private we could go?</i>\"");
//
	//output("\n\nYou coyly ask him if he's propositioning a respectable lady like you, and a little of bit of a slur comes to your lips.  Urta's still vastly more hammered than you, but there is a bit of an airy buzz vibrating through your consciousness when you try to focus.  You rise, stretching languidly and pressing your [pc.butt] against Raphael's groin to further excite him.  The small bulge of his narrow erection digs into your [pc.gear] as you grind against him, as lithe and confident as the rest of the surly thief.");
//
	//output("\n\nTaking his soft, furred hand in your own, you lead him towards the back room you saw your other foxy ");
	//if(!urtaLove()) output("friend");
	//else output("lover");
	//output(" use.  He stays doggedly on your heels, so close that you can feel his rigidity as it bumps and grinds against your [pc.butt], and you make a point of arching your back so that he's forced to contact it again and again.  You smile as his face loses some of its stoic focus to the alluring motions your rear is making.  Raphael's steps are getting a little uneven by the time you get to the backroom door, and as you spin around and pull him into an embrace, you inform him, \"<i>I got us a friend to play with...</i>\"");
//
	//output("\n\n\"<i>Wha-?</i>\" Raphael tries to ask before you silence him with a kiss, crushing his mouth into your own and placing his upraised hand on your [pc.hips].  You flip the latch and drag him into the darkened room with you, barely remembering to kick the door closed before two sets of foreign hands start to strip you.  Raphael's own garments are no match for your frisky fingertips, and you disrobe the surprised thief with ease thanks to the hypnotic kiss you've got him trapped in.  If you're going to be honest with yourself, the slow, sloppy kiss is having a similar effect, and once the bottom of your [pc.gear] is off, the scent of your womanly desire clings damply in the air.");
	//output("\n\nStronger, more muscular arms wrap around you and Raphael, firmly compressing your bodies together.  His dagger-like erection narrowly misses your [pc.vagina], instead wetly grinding across your lips and [pc.clit], pressing on your belly where it can leak a trickle of liquid need onto your [pc.skinFurScales].  A slightly slurred voice demurely coos, \"<i>Your friend has a nice butt!</i>\" as a slimy, slippery horsecock is pressed against your back");
	//if(pc.tallness >= 60) output(", grinding through your [pc.butt]'s ass-cleavage without an ounce of hesitation");
	//output(".");
//
	//output("\n\nRaphael grunts as he's manhandled, but for once, he's rendered speechless.  Instead of trying to fight it, he tries to adapt to the situation.  His slender fingers traipse through your [pc.hair] and interlock on the other side of your head, one digit caressing the curve of your ear as he draws you back into a passionate kiss.  His tongue forcefully spears past your own with a dancer's grace and a swordsman's strength, and soon, you're on the defensive in an oral battle for the ages.  Raphael releases his left hand so that it can trawl down your shoulder towards your breast, and he begins to massage it in order to distract you, something that works all too well.");
//
	//output("\n\nYou whimper into Raphael's lips while your lust and alcohol inebriated brain struggles to come up with a counterattack.  It comes to you when you feel a trickle of foxy moisture flow into your belly-button, and your return strike is as swift as your cunt is wet.  Rocking your [pc.hips], you undulate against the crimson thief's pecker, smearing it with your juices.  Then, you lift yourself up with your [pc.legs] and abruptly drop onto the foxy phallus, impaling yourself on its bulbous length.  Raphael's skillful kiss collapses under the weight of the sensations you've forced him to experience.  The poor guy wasn't expecting you to take him then and there, and you take the opportunity to violently kiss him, enjoying his pliant mouth while he slowly gathers his wits and begins to kiss you back, this time not so competitively.");
	////CUNT STRETCH RAPHAEL GOOOAOOAOAOAOAOAOAOAOAO
	//pc.cuntChange(12,true,true,false);
//
	//output("\n\nUrta, perhaps feeling a bit ignored, suddenly forces a finger into Raphael's tight pucker as she crouches, using her free hand to line her blunt horse-cock up with your [pc.asshole].  You ");
	//if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("lift your tails and ");
	//output("try to relax with her thick slab of penis so close to your backdoor, hoping she'll be gentle.  A drunken twinge of arousal knifes through your [pc.vagina] as you imagine her forcefully raping your hind-end, and Raphael can certainly feel the convulsive fluttering of your love tunnel as you sink into your imaginings.  The gray vixen nips at your ear as she presses against your [pc.asshole]");
	//if(pc.analCapacity() < 30) output(", slowly stretching your tight sphincter with constant pressure.  You're not really loose enough back there for this to be entirely comfortable, but the incredible fullness her length provides has a way of muting the pain of stretching.");
	//else if(pc.analCapacity() < 60) output(", slowly sliding into your sphincter.  You groan into your other lover's mouth as your anus is claimed by the thick horse-pole, and you do your best to relax around the butthole-stretching shaft.");
	//else output(", easily slipping inside your well-practiced anus.  You groan into your other lover's mouth as the thick cock claims your ready asshole, and you're glad your butthole was so well prepared to handle having a hot meat pole injected into it.");
	//pc.buttChange(60,true,true,false);
	//output("\n\nRaphael breaks this kiss, his hips thrusting needfully against your mons with jerky, uncoordinated strokes, pumping to the timing Urta's wiggling finger forces his prostate to obey.  \"<i>S-señorita... w-who is your friend?  Oooh, mon dieu!</i>\" he cries.");
	//output("\n\nYou give him a reassuring peck on the lips as a few more inches of mammoth dick nestle into your [pc.butt], filling you full enough that you can feel your lovers' members sliding across each other through your dick-filled insides, Raphael's small, vulpine dong is smothered with the expansive, pre drooling horse-cock, and the smaller male seems almost afraid of the size of your companion.  You squeeze your inner muscles to caress the smaller fox-dick and answer, \"<i>Just a friend with a fun little package.  I hope you don't mind...</i>\"");
//
	//output("\n\nUrta's finger pushes a little harder on the rogue's tender rosebud, making him lurch against you harder.  His poor knot is already starting to swell inside you, and he's clearly trying his best to hold on.  This situation you've forced him into just isn't something he was ready for, for once, and it shows.  A thick ring of prepuce slides into your distended asshole fast enough to make your own confident expression twist into a dopey, whining grin, one that only widens as you take Urta all the way to her big, swollen balls, her sheath folded up around your [pc.asshole].");
//
	//output("\n\nThe situation spirals completely out of control at that point.  Raphael is lewdly moaning as he pistons in and out of you, his swelling knot popping and stretching your labia as it drags through them again and again, each time a little larger, a little harder, and a little more forcefully.  At the same time, Urta begins to crudely pound your [pc.asshole].  She ravages your backside with long, hard pumps of her hips, drunkenly mating your ass.  The thick, fat flare inside you scrapes along your walls as it slides through you, pressing down on every sensitive bundle of nerves as it goes, and by virtue of its own size, it forces Raphael's smaller erection to press up inside your [pc.vagina], rubbing a sensitive, hot little spot inside you that has your [pc.legs] shaking as your strength slowly ebbs out of your ecstasy-wracked frame.");
//
	//output("\n\nYou throw your head back to rest on Urta's shoulder as a shuddering explosion of bliss goes off in your womb, shivering through your tight channel to contract about the knotty fox-cock inside you.  Your undulating walls have the male meeting your orgasm with one of his own, and the bulb at the base rapidly inflates, immobilizing itself inside your clenching, cock-milking canal.  Warm semen flows out of him in long, thick spurts, exactly like you desire.  Hands, Urta's or his, you don't know or care which, pinch your nipples as climax wracks you.  The swollen flare expands as Urta bottoms out in your [pc.butt], and you feel her jizz pumping up through your well-stretched guts, filling you with so much liquid heat that you wonder if you're going to melt.  You let go and close your eyes, cradling your slowly-inflating belly as you're creamed from both sides, filled with thick spunk until your middle feels ready to pop, the whole time moaning and crying, panting out demands for more.");
//
	//output("\n\nThe two clueless sperm-pumps exhaust themselves in either side of you, spending their passion in thick gobs that you're all too happy to take.  Only after each dick is utterly drained and your pussy and asshole wear masks of dripping white goo, do you let them slide free of your imprisoning holes.  You pant for breath as you lean against a box, rubbing one hand over your middle.");
//
	//output("\n\n\"<i>Mademoiselle, I must confess, I did not enjoy that nearly so much as when we are alone, under the moonlight,</i>\" Raphael mutters disconsolately, as he stumbles in the dark, trying to get dressed.");
//
	//output("\n\nUrta slurs, \"<i>Well, it was fun.  Who cares if [pc.name] wants to be double-stuffed with fox?</i>\"  She squeezes your [pc.butt] as she's trying to get dressed, her limp cock dangling between her legs in the poorly lit room.  \"<i>Or is that horse?</i>\"");
//
	//output("\n\nYou get dressed too, though your [pc.gear] is sorely stressed by the size of your middle at this point, and the way it jiggles and wobbles makes you wonder how long you'll have to handle it before it passes.  Urta lights a lantern, before turning around, and the horrified expression on her face is mirrored by the one on Raphael's.");
//
	//output("\n\n\"<i>Him!?</i>\"\n\"<i>Her?!</i>\"");
	//output("\n\nThe door opens and closes with a slam as Raphael goes into full flight, and Urta stumbles after him before tripping into your arms.  You hold the snarling girl in your arms while she drunkenly tries to go after him, eventually rounding on you.");
	//output("\n\n\"<i>You made me have a threesome with... with him!</i>\" Urta growls.");
	//output("\n\nYou kiss her on the nose and press your cum-stuffed middle against her, pointing out that not only did she completely emasculate him in size alone, but she also got to make him dance on her fingertip like a puppet, all while cumming longer and harder than he could ever hope to.  The foxy fox curls her ebony lips in a rueful smile at that, running her hands over your middle in admiration of her work.  \"<i>I guess I did, huh?  Hopefully taught him a lesson!</i>\"");
	//output("\n\n(<b>Raphael probably won't fall for that again, but hey, it was fun!</b>)");
	////Slimefeed
	//pc.slimeFeed();
	////-3 sensitivity, reset lust.
	//pc.orgasm();
	//dynStats("sen", -3);
	//flags[kFLAGS.URTA_X_RAPHAEL_HAPPENED]++;
	//doNext(returnToCampUseOneHour);
//}