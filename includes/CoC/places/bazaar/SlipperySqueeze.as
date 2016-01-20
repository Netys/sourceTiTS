import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function showSlipperySqueeze():void
{
	userInterface.showName("SLIPPERY\nSQUEEZE");
}

//Semen Bukkake and Massage Parlor
//-Femboi Bunny owner - Joey
//-Catboi (10%) assistants.  Some equipped with tentacles.
//-Optional Female Masseuse.
//--Bunnygal (10%) with horns and a similar addiction to Scylla.
//--Named Sara.
//(find/replace curly quotes/apo for straights -Z)
//[The Slippery Squeeze!]
private function theSlipperySqueeze():void {
	clearOutput();
	showSlipperySqueeze();
	output("You walk into one wagon whose sign clearly denotes it as 'The Slippery Squeeze'.  It's one of the largest contraptions in the bazaar, and with your first step inside you can see why.  It's built like a regular business, with a lobby in the front and numerous oak doors that lead to back rooms.  The walls are painted a soothing salmon color and a purple, fringed rug covers the wood floor.  It feels soft under your " + pc.feet() + " after so much walking, letting you loosen up and relax.  Incense burns on the counter, filling the air with strange, fragrant aromas that tickle at your nose.\n\n");
	
	IncrementFlag("COC.BAZAAR_SLIPPERY_SQUEEZE_VISITED");
	
	//(First time desc:
	if(Flag("COC.BAZAAR_SLIPPERY_SQUEEZE_VISITED") == 1) {
		output("A short, bunny-eared clerk leans on the counter, batting long eyelashes at you as you approach.  The rabbit is wearing a gauzy, sheer pink top and lots of make-up that accentuates her plump, red lips and curvy, cute features.  She doesn't have much in the chest department, but she's unmistakably cute.  You ask the little miss what kind of services this place offers, and she responds by covering her mouth with her hand and giggling girlishly.\n\n");
		output("It takes her a few moments for her to get over her humor, but she brushes a hand through her silken hair and replies, \"<i>Oh, I'm sorry if I gave the wrong impression " + pc.mf("mister", "miss") + ", but I'm not a girl at all.  I'm definitely a male - I just love looking cute and fuckable!  You've got to admit I'm a pretty hot little package!</i>\"  To emphasize 'his' point, the bunny-boy twirls in place, and you notice that all he wears below the waist is a tight, package-hugging thong.  His tail twitches happily from exhibiting himself so, but he doesn't seem to be too aroused yet.\n\n");
		output("Before you can comment on his odd mannerisms, he titters, \"<i>You're in 'The Slippery Squeeze', though some have called us 'The Happiest Ending' after a nice, HARD massage.</i>\"  The long-eared bunny-trap licks his gloss-coated lips enticingly before continuing. \"<i>We specialize in salty oil rubs and the complete release of all your tensions.  It's very therapeutic, both for the customer and the masseuse.  We specialize in creating our own, in-house massage lotions that are sure to make the tension ooze from your pores.</i>\"\n\n");
		output("Is he implying what you think?  It sounds like the gist of his entire speech is that they use cum for massage oil and specialize in getting everyone involved to orgasm.  The bunny hops and demurely introduces himself. \"<i>My name is Joey; just ask for me or my lovely assistant Sara if you ever want a rub-down.</i>\"");
		output("\n\n\"<i>I told you I'm not working until you give me a raise!  Do the damned massages yourself!</i>\" echoes a voice from the back.\n\nJoey blushes and apologies.  \"<i>I guess I'm the only one available for now.</i>\"\n\n");
	}
	//Big balls variant
	else if(rand(10) == 0) {
		joeyBigBalls();
		return;
	}
	//Cock Milker
	else if(!pc.hasKeyItem("Cock Milker") && Flag("COC.JOEY_OFFERED_MILKER") == 0 && flags["COC.COCK_MILKER_INSTALLED"] != 1) {
		output("You notice Joey leaning on the counter, lost in thought.  The bunny boy frowns, troubled by something.  He jolts upright when he notices you approaching, his expression lifting into a polite grin.  \"<i>Hey, welcome!  Always nice to see a familiar face.  So, do you have some 'tension' that needs relieving?</i>\"  His eyes travel down to your crotch.  Shameless as ever but with a hesitant offer buried in his eyes...\n\n");
		Flag("COC.JOEY_OFFERED_MILKER", 1);
	}
	//(Repeat visit: 
	else {
		output("Joey purses his glossed lips when you enter and coyly cocks one of his ears as he says, \"<i>Welcome back to 'The Slippery Squeeze', [pc.name].  Would you like me to give you a nice, salty rub-down?  Or would you prefer Sara do it?  Just remember, she can't make her own 'oil' like I can.</i>\"\n\n");
		//No scenes for Sara yet!
		output("\"<i>I told you I'm not working until you give me a raise!  Do the damned massages yourself!</i>\"\n\nJoey blushes and apologies.  \"<i>I guess I'm the only one available for now.</i>\"\n\n");
		output("The price list indicate it's 10 gems for a massage, though the gleefully illustrated 'oil' reminds you just what they plan to use on you.\n\n");
		
		if(!pc.hasPerk("Androgyny")) {
			output("There also appears to be an option for a special 'Androgyny Treatment' that costs 500 gems.  Joey catches you looking at it and mutters, \"<i>That treatment isn't fun like our massages.  It would unlock the full potential of your visage, allowing it to be as masculine or feminine as possible.</i>\"\n\n");
			Flag("COC.JOEY_OFFERED_ANDROGYNY", 1);
		}
		//You could have Joey or Sara give you one, though it's obvious they plan to use spooge as massage oil. (Sara needs an introduction before she gets a mention and a menu entry -Z)
	}
	
	processTime(3);
	//	[Joey] [Sara] [][] [Leave]
	clearMenu();
	if (pc.credits >= 100) addButton(0, "JoeyMassage", joeyMassage);
	else addDisabledButton(0, "JoeyMassage", "Joey Massage", "You can't afford this.");
	
	if(Flag("COC.JOEY_OFFERED_ANDROGYNY") == 1 && !pc.hasPerk("Androgyny")) {
		if (pc.credits >= 5000) addButton(1, "Adrogyny", joeyAndrogyny);
		else addDisabledButton(1, "Adrogyny", "Adrogyny", "You can't afford this.");
	}
	
	if (!pc.hasKeyItem("Cock Milker") && Flag("COC.JOEY_OFFERED_MILKER") == 1 && flags["COC.COCK_MILKER_INSTALLED"] != 1)
		addButton(2, "Joey'sOffer", askJoeyAboutOffer);
		
	if(isEaster()) { // function defined in BunnyGirl.as
		output("There's another option on the list, cheerfully presented with a pastel border and a little painted egg next to it.  'Sweet Massage' it says.  \"<i>That's our spring special,</i>\" Joey explains, \"<i>using our new chocolate-flavored massage oil.  It comes with a complimentary 'dessert.'</i>\"  He gives you a little wink at that last word, so you can be certain that it's no normal dessert.  <b>The price is 20 gems.</b>");
		
		if (pc.credits >= 200 && !pc.hasPerk("Androgyny") && Flag("COC.BAZAAR_SLIPPERY_SQUEEZE_VISITED") > 1) addButton(3, "SweetMassage", joeySweetMassage);
		else addDisabledButton(3, "SweetMassage", "Sweet Massage", "You can't afford this.");
	} 
	
	addButton(14, "Leave", enterTheBazaarAndMenu);
}

//[Ask]
private function askJoeyAboutOffer():void {
	clearOutput();
	showSlipperySqueeze();
	output("You ask the effeminate masseuse what had him so concerned a moment ago.  He grimaces.  \"<i>Well, I recently came in possession of a cock milker, one of the old magic-powered ones.  The trouble is, I obviously don't need one, and neither does anyone else.  Worse still, the thing takes up a fair bit of my room.  I guess they've already got 'alternatives',</i>\" he sighs.  \"<i>So now it's just collecting dust in the back room, and I hate seeing a nice piece of craftsmanship like that go to waste.  Even if my talents have rendered it defunct,</i>\" he murmurs with a trace of pride.");
	output("\n\nHe stares at you momentarily.  \"<i>Say, you wouldn't happen to want it, would you?  Maybe something for those long, lonely nights?  Heck, you could probably jury rig it to collect lots of semen.  Good quality cum fetches a decent price,</i>\" he says a little too knowingly.  \"<i>A sound investment, yeah?  I'll let it go for, oh, say, five hundred gems.</i>\"  What?  The cocky little f-  \"<i>Hah, just pulling your leg!</i>\" he laughs.  \"<i>It's yours for two hundred gems.  Because I'm such a nice guy.</i>\"");
	output("\n\nWhat do you think? Will you take the cock massager for 200 gems?");

	processTime(2);
	clearMenu();
	//[Yes] [No]
	if (pc.credits >= 2000) addButton(0, "Buy", buyCockMilker);
	else addDisabledButton(0, "Buy", "Buy", "You can't afford this.");
	
	addButton(1, "No", noMilkerPlzJoey);
}
//[No]
private function noMilkerPlzJoey():void {
	clearOutput();
	showSlipperySqueeze();
	output("You decline; it's not really the sort of thing you need in your camp.  \"<i>Ah well,</i>\" Joey shrugs, \"<i>I'll just have to hang onto it for now I guess.  Shame.  Anyway,</i>\" he resumes his usual grin, \"<i>is there something else you need?  A massage, perhaps?</i>\"");
	//return to normal options, scene is never brought up again
	processTime(1);
	clearMenu();
	addButton(0, "Next", theSlipperySqueeze);
}
//[Yes]
private function buyCockMilker():void {
	clearOutput();
	showSlipperySqueeze();
	output("\"<i>Fantastic, fantastic!  Let me get it from the back.</i>\"  Joey rushes behind a curtain, audibly rummaging through the storeroom.  Soon he comes back, carrying a bunch of tubes and nozzles.  \"<i>Here you go!</i>\"  He dumps the collection of junk in your arms, taking the gems from you in the same motion.  You hastily begin stuffing the contraption in your pack.  \"<i>Now, don't get too attached.  A machine's never gonna beat the real thing.</i>\"  He flexes his delicate fingers.  \"<i>Speaking of which, need something?</i>\"");
	output("\n\n(<b>Key Item Acquired: Cock Milker</b>)");
	pc.credits -= 2000;
	//statScreenRefresh();
	pc.createKeyItem("Cock Milker", 0, 0, 0, 0);
	processTime(5);
	clearMenu();
	addButton(0, "Next", theSlipperySqueeze);
}

private function joeyAndrogyny():void {
	clearOutput();
	showSlipperySqueeze();
	pc.credits -= 5000;
	//statScreenRefresh();
	output("Joey takes your hand in his and insistently pulls towards the back rooms.  \"<i>Once we have this all done ");
	if(pc.hasCock() && !pc.hasVagina()) output("you'll be able to be as cute as me!");
	else if(!pc.hasCock() && pc.hasVagina()) output("you'll be able to be as masculine as you want!");
	else output("you'll be able to be as cute as me or as masculine as you want!");
	output("</i>\" explains the bunny-eared fem-boy.   You allow yourself to be lead into a small back room, where you're guided into a soft, padded chair.  Joey turns about in the cramped interior, his shapely ass mere inches from your face, tail tickling your nose.  You struggle not to sneeze or stare too deeply at the curvy fem-boy's butt-cheeks, but it's hard to focus with that delicious target waggling in front of you.\n\n");
	
	output("At last he turns back around, holding a cork-stoppered vial of pink-hued liquid in his manicured finger-tips.  \"<i>This is the stuff!  Now just close your eyes, we gotta get this worked into your skin and it stings worse than an angry wasp-girl if it gets in your eyes,</i>\" says Joey.  You blink your eyelids closed, as instructed, and you feel the soft skin of the feminine bunny rubbing over your " + pc.face() + ", working something wet and tingly into your [pc.skinFurScales].  The delicate facial massage takes roughly an hour, but you feel fresh and relaxed once it's finished.\n\n");
	
	output("You ask for a mirror, but Joey just titters with a knowing smile on his succulent lips as he replies, \"<i>Oh, you haven't changed at all " + pc.mf("handsome", "dear") + ".  This will let you change it to whatever extreme you like, but those kinds of facials aren't a service we currently offer.  I do hear that there's a goblin salon in the mountains that might be able to help you finish up your look though!</i>\"\n\n");
	
	output("Thanking the cute bunny-boy for his help, you hand over the payment and head back to check on camp.");
	pc.createPerk("Androgyny", 0, 0, 0, 0, "No gender limits on facial masculinity or femininity.");
	pc.lust(5);
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}
//[Joey]
private function joeyMassage():void {
	clearOutput();
	showSlipperySqueeze();
	//pc.slimeFeed();
	pc.credits -= 100;
	//statScreenRefresh();
	output("Joey bounces on his feet excitedly, the little poof-ball above his exposed, heart-shaped ass twitching happily.  His soft hand takes yours and leads you towards one of the back rooms, dragging you inside just before the door is silently closed.  The small wooden chamber houses a single, padded bed that's clearly meant for you, and at Joey's insistence you disrobe to lie down on it.  You put your face through a rounded oval and lie down, taking the idle moment to glance around.  A small coal-fired steam-oven isn't far past the bed, and you can make out Joey's small, human feet as he stokes it.\n\n");
	output("One of your chosen masseuse's soft, demure hands rests on your shoulder while the oven starts and begins to vent warm steam through the room.  Joey starts by leaping atop you in a single bound to  straddle your back and rub your shoulders.  His small, skilled fingers work wonders, working out the constant tension this strange land has inspired in you since your arrival.  Each insistent, languid touch dissolves a knot of worry, sending shivers of contentment through you that make you feel as if you're melting into the bed.\n\n");
	output("Once he feels the tension from your upper body has been released, the girly bunny-boy slides himself lower, placing his taut, barely-covered rear atop your [pc.ass].  Joey's hands slide down along your spine, smoothing out every knotted muscle in your back as he goes.  You could swear his fingers are magic; you feel like a lump of clay being worked by a master sculptor.  Sighing dreamily, you lie there and groan while he finishes the small of your back, muscles rendered into goo-like softness.\n\n");
	output("Your masseuse moves up to your arms, squeezing and rubbing with practiced skill.  You're so tranquil that you barely react when he begins to grind his thong-covered bulge on your utterly-relaxed back.  Each slow, measured drag of his body is done to the tempo his fingertips set on your now-limp arms.  You sigh contentedly, letting the bunny dry-hump your lax muscles as if it were all part of the massage.  Even though he stops the massage, his hips keep pumping until you can feel his six inches of hardness threatening to escape his sweat-slicked thong.\n\n");
	output("Joey dismounts and gives your [pc.ass] a rough squeeze as he prances towards a nearby table with a large number of bottles.  You hear him drop a cork on the floor and watch it roll by your face.  The masseuse noisily gulps down whatever concoction he's just opened up, sighing contentedly and giving a cute, girlish burp once he's finished.  He leans down and breathes huskily into your ear, his hand roaming your body while he explains, \"<i>I just drank one of our house specials.  It's a nice little concoction that'll kick my prostate and balls into overdrive.  In a minute I'll start leaking my favorite lotion, and I won't stop for at least twenty minutes.  Just enough time to finish your massage.", false);
	if(pc.hasCock()) output("  Would you like one?");
	output("</i>\"");
	
	clearMenu();
	if(pc.hasCock()) {
		output("\n\nDo you accept Joey's potion?");
		addButton(0, "Yes", joeysMassageWithEXTRASpooge);
		addButton(1, "No", joeysMassageWifNoExtraJizz);
	}
	else addButton(0, "Next", joeysMassageWifNoExtraJizz);
}

private function joeysMassageWifNoExtraJizz():void {
	clearOutput();
	showSlipperySqueeze();
	//(Continue as NoWang)
	output("The rabbit-eared fem-boy climbs back onto the table and strokes himself a few times over your [pc.ass]; the first drops of his 'special oil' feel hot as they land on the curves of your butt cheeks.  He climbs over you, touching himself just enough to stay hard while his cum-drooling cock stops dripping and starts genuinely leaking.  A long trail of bunny-spunk is dripped onto your [pc.ass] until you're glazed with thick ropes of it.  You spot his discarded thong on the floor and giggle as you feel him flip around to put his cute bunny-butt on your shoulders.  His spunk immediately runs down your spine, even as his hands smear it all over your [pc.skinFurScales].\n\n");
	output("The massage heads back towards your [pc.ass]; Joey's hands fill with your flesh as he fondles and strokes, spreading the jism into every nook and cranny, even your [pc.asshole]");
	if(pc.hasVagina()) output(" and [pc.vagina]");
	output(".  The strange, slippery feeling would've made you jump if you weren't so thoroughly relaxed, but the warmth of the room and sureness of your masseuse's touch only serve to stoke your lust as effectively as he had the oven's fire.  You mewl happily when he slides his cum-soaked fingers up your back, spreading the sloppy mess over you like icing on a cake.\n\n");
	
	output("Joey stands and turns, his cum drooling into your [pc.hair] as he asks, \"<i>Would you roll over for me?</i>\"  Eager for more of his skilled massage and impelled by your own growing arousal, you roll over, letting his jism drip onto your face.  He sits down gently, resting his barely-felt weight atop your bellybutton, and in no time, his fingers are smearing more of his fragrant, constantly-leaking goo over your [pc.chest].  The long-eared fem-boy rubs around your [pc.nipples], trailing delicate circles that make the perky, pink flesh harden and glisten.\n\n");
	output("A soft, slippery hand takes your own and guides it to one of your [pc.nipples], bidding you to play with it.  You do enthusiastically, even while Joey's same hand gathers more of the salty white lotion to smear over the front of your shoulders and arms, working it into your pores as effectively as he works the tension from you.  Unable to deny your growing need, you lift your head to watch with perverse fascination.  Joey is blushing hard, but he holds himself immobile while the whitish goop continually pours from him.  While his dick would've been considered average back home, here, in this place, he's tiny.  He really does remind you of a lotion dispenser, pumping out globs of sticky whiteness to be rubbed into one's skin.\n\n", false);
	output("You catch a view of your hand as it ");
	if(!pc.hasFuckableNipples()) output("tweaks and teases");
	else output("sinks a finger deep inside");
	output(" your [pc.nipple], and you raise your other to match it.  Joey smiles and pants, \"<i>Yes, we need to get out allll your tension, even that... uh... naughty... ah... sexual tension.  Mmmmm, now just lie your head back.  I'm almost done, and we always give our clients a facial treatment while we ease their worries.</i>\"\n\n");
	
	output("The bed cradles you as you close your eyes and lie back, noting the slight change in darkness beyond your eyelids from Joey's new position.  Spunk begins to rain over your " + pc.face() + ", puddling seed around your eyes and forehead before it drips down your cheeks and bubbles on your lips.  You're quickly distracted from the salty, cummy facial when your personal leporid lotion-dispenser ");
	//(fork to male or genderless, no new PG)
	//(MALE)
	if(pc.hasCock()) {
		output("slides his warm, ruby lips over your [pc.cock], licking and slurping the " + pc.cockHead() + " like a treasured candy.  That hot, breathy embrace hugs tight to your urethral bulge, slobbering up the cock-tip.  The flexible, thin rabbit tongue swirls over your cum-slit to lap at the bubbling pre-cum, even as his quaking balls continue to bury your face in bunny-semen.");
		if(pc.totalCocks() > 1) {
			output("  He takes your " + pc.cockDescript(1) + " with his free hand and pulls it over, giving it an affectionate, loving smooch.");
			if(pc.totalCocks() > 2) {
				output("  The process is repeated");
				if(pc.totalCocks() > 3) output(" as necessary until [pc.eachCock] is coated with dick-drenching bunny spit.");
				else output(", coating your " + pc.cockDescript(2) + " with dick-drenching bunny spit.");
			}
		}
		output("  A moment later, ");
		if(pc.balls > 0) output("his hand firmly rubs your [pc.sack], and ");
		output("gentle fingertips are probing between your cheeks, rubbing his dripping seed against the pucker of your [pc.asshole].\n\n");
	}
	//(FEM/GENDERLESS) 
	else {
		if(pc.hasVagina()) output("presses his ruby lips into the glistening delta of your mons");
		else output("presses a finger against the semen-soaked ring of your [pc.asshole]");
		output(".  He skillfully works a free hand over your slippery butt-cheek, squeezing the supple flesh while he expertly rubs your interior, stroking it with semen-lubed touches.\n\n");
	}
	//Fems/Genderless cum+epilogue
	if(!pc.hasCock()) {
		//(Genderless orgasm)
		if(!pc.hasGenitals()) output("Though his single finger makes you burn with passion, Joey's second slides effortlessly after it, filling your [pc.asshole] with another of his cum-soaked digits.  His warm jism slides down the crack between the fingers, slowly pooling in your backdoor.  Once you've adjusted, he continues to the massage, stroking and bumping your interior with the confident, practiced strokes of a professional. You pull hard on your tortured [pc.nipples], egging up the gradual upwelling of pleasure while you lick the bunny-cream from your lips.  A moment later, the no-longer-offending digits press hard on a sensitive spot, and you're arching your back, screaming with pleasure.\n\n");
		//(Female orgasm)
		else {
			output("Though his spit and cum-lubed tongue is quite skilled, deftly tasting your labia and channel, the bunny adds a pair of fingers to the mix, pulling the musky tunnel wide and letting more of his slippery seed inside you.  He uses it like lube, sliding his digits around while he sucks your [pc.clit] ");
			if(pc.clitLength >= 4) output("like a practiced whore fellating a john.");
			else output("like a professional pussy-licker.");
			output("  You give your [pc.nipples] a hard tweak, torturing them as the building pleasure grows.  Aware of this, Joey curls a finger to press directly on a sensitive spot, deep inside you, and then you're arching your back and howling with unleashed release.\n\n");
		}
		//(continuing)
		output("You tremble and moan for some time, until you realize there's no more cum dripping onto your face and your pleasantly tingly hole is empty.   Joey pads around you, rubbing your neck sensually as you blink the spunk from your eyes and lick his flavorful spooge from your lips.  A towel is placed into your hand by the breathy masseuse.  He says, \"<i>There's a shower and more towels in the back if you want to clean up.</i>\"  You note that he's already got his thong back on, but the front is dark and nearly spherical from what he's leaking into it.  He turns to leave you, and you're given a better view – his thong is bulging from between his legs all the way around to his ass.  The feminine bunny-boy is still cumming, and his special thong seems to be directing it all into his back door.  Kinky.");
	}
	//(Dickgasms
	else {
		output("Though Joey's mouth is making you burn with passion, it's the feeling of a single, intruding fingertip against your [pc.asshole] that puts you on edge.  His warm jism slides down his finger, dripping into your violated backside with each slow pump.  Once you've adjusted, he continues the rectal massage, gently caressing the sides of your prostate while his mouth stays busy with your [pc.cock].  The bunny's tongue thrashes, twisting like a slippery eel over your length, his cheeks hollowing from the suction he's applying.  A moment later, Joey curls the digit inside you to press firmly against your prostate, squeezing the sensitive organ tightly enough to make your hips pump into the air.\n\n");
		output("Globules of spooge squirt in time to your motions, feeding those ruby lips the treat them seem to ache for.  The rain of slick, syrupy cum on your face intensifies, spurting heavier ropes of bunny-cream each time you make the poof-tailed fem-boy swallow.  He gasps hard in between each semen-sucking gulp, all while giving you an impressive facial.  If you could see yourself, you would probably look like you're wearing enough boy-sludge to knock up an entire village.  The perverse mental image sets off a whole new set of contractions, releasing a few more waves of bliss and 'tension'.\n\n");
		output("Joey climbs off once you've wound down and laps at the cum over your eyes, nose, and mouth, cleaning you enough to see properly.  The first thing you see is a girlish, cum-stained face.  He makes a show of cleaning the spunk from himself, but throws you a towel as he does so. You lick the last of his flavorful cum from your mouth, noting that while he's already put his thong back on, it's bulging obscenely and he's still squirting inside!");
		if(pc.cumQ() >= 700) {
			output("  A smile widens your " + pc.face() + " when you see the ");
			if(pc.cumQ() >= 2000) output("massive, jiggling belly you've given him.");
			else output("little paunch on his belly jiggle.");
			output("  He won't be hungry for some time.");
		}
		output("  Joey turns and prances away, saying, \"<i>There's a shower if you need to clean up, and be sure and visit me the next time you need help to squeeze out all that tension!</i>\"  You barely hear his words, so focused are you on his cum-darkened, distended thong.  You can see it bulging between his legs, and while his pert butt sways out the door, you can see that his cum-filled thong is designed to redirect all that fluid over his taint and into his backdoor. Kinky.");
	}
	//(reduces libido significantly if very high, reduces lust, and reduces sensitivity to 40)
	pc.orgasm();
	if(pc.libido() > 20) pc.slowStatGain("l", pc.libido() / -20);
	//if(pc.sens > 40) dynStats("lib", -.5); // ???
	processTime(40);
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}
	
//[CONTINUE – DRANK JOEY'S SPECIAL POTION]
private function joeysMassageWithEXTRASpooge():void {
	clearOutput();
	showSlipperySqueeze();
	output("The rabbit-eared fem-boy pulls the cork on another bottle and helps you to roll to your side to drink it.  He holds the lip of the bottle to your lips and raises the bottom slowly, giving you just enough time to guzzle it without drowning.  It's sweet and syrupy, though there's an undertone of spicy strangeness that you can't quite place.  Whatever the secret ingredients are, you'll never figure them out from taste alone.  You feel warmth once you've finished, and a tightness settles ");
	if(pc.balls == 0) output("inside you");
	else output("in your [pc.balls]");
	output(" that reminds you of the sensation just before orgasm.");
	if(pc.balls > 0) output("  They even feel a little bigger.");
	output("\n\n");
	
	output("Joey's fingertips brush along your shaft, squeezing it with tender touches that make it stiffen and thicken.  He starts slowly jacking you off while his other hand traces one of your nipples.  \"<i>We've got to get you nice and hard now so that you can let out all that nice, creamy lotion,</i>\" explains the fem-boy.  You nod in understanding, blushing hard while he fondles [pc.eachCock] with soft caresses.  He plays your manhood");
	if(pc.cockTotal() > 1) output("s like fiddles");
	else output(" like a fiddle");
	output(", expertly running his fingertip around the sensitive " + pc.cockHead() + " before tracing down along your rapidly filling urethra.  It feels good – better than it should, and the warmth inside you begins to leak into the bunny-boy's waiting hand in moments.\n\n");
	
	output("You're rolled back on to your front, crushing [pc.eachCock] between you and the sheets.  Joey leaps back atop you, straddling your back and facing your [pc.ass], his hands locking onto the steam-moistened cheeks.   He slides forward slightly, placing his hardness between them, and it's then that you notice his discarded thong on the floor.  A moment later the first drops of Joey's own hot seed are dripping over your exposed derriere.  He slides himself through your buns, hotdogging the rapidly-slickening surface of your ass while his hands massage the tense flesh a little more enthusiastically than they ought to.\n\n");
	
	output("Of course you don't complain, not with the growing puddle forming between you and the cum-soaked sheets.  Every time your masseuse shifts, the movement makes you slide in your sticky mess, the cum-lubed friction of the sheets helping the constant jizz-flow to thicken into a steady river of seed.  ");
	if(pc.balls > 0) output("Your balls pull and relax and pull tight, bouncing below you over and over, all while working hard to produce more juice for you to gush.  ");
	output("Even though you're draining spunk at an alarming rate, it doesn't feel like a normal orgasm.  There's no wave of pressure and subsequent release, just a constant, pulsing contraction that makes you melt with ever-increasing feelings of satisfaction.\n\n");
	
	output("Joey giggles, turning about to put his lotion-dispenser on the small of your back, and you feel the hot bunny-spoo pour onto you in a wave.   It's gathered up and pushed up your back.  Globs of it roll down your side, sliding over the semi-waterproofed sheets to mix with your growing spunk-lake.  With the slippery-seed aiding Joey's massage, he somehow manages to work out even more of your tension.  By this point your muscles feel like jello melting in the afternoon sun.  You feel like you could melt into your cum, and you sigh in bliss");
	if(pc.cumQ() >= 1500) output(".  The sound of your rivers of spooge splattering against the floor barely registers, but a part of you is proud to be so incredibly fertile");
	output(".\n\n");
	
	output("You're prodded insistently, the masseuse saying, \"<i>Come on, we've got so much more of your body to work on before you're completely emptied of all that nasty stress.  Now roll over, don't be shy about the mess.  I'll be making it messier.</i>\"  True to his word, Joey is still drooling his 'special lotion' over your " + pc.legs() + ".  You oblige and gingerly roll over, the cummy sheets squishing lewdly under you as your slime-slicked belly and cum-drooling crotch are revealed.");
	if(pc.cumQ() >= 1500) output("  Joey's jaw drops from the unexpectedly large volume you're producing, and he watches in awe as each huge globule of cum rolls off you towards the floor.");
	output("\n\n");
	
	output("The bunny-boy springs back atop you, landing hard just below your hips.  His dripping seed washes over [pc.eachCock], and the sudden onslaught of fresh, liquid warmth on your groin sets off a small explosion of jism that splatters into your chin, leaving a long trail of slime behind like a snail.  The long-eared girly-boy smiles and shifts to rub his small cock against your [pc.cock], frotting you aggressively while you both spray cum like faucets with the knobs torn off.  You don't mind that he seems to have forgotten the massage, and you run your hands up and down your[pc.chest] to smear the heavy loads ");
	if(pc.skinType != GLOBAL.SKIN_TYPE_FUR) output("over your [pc.skinFurScales]");
	else output("through your [pc.skinFurScales]");
	output(".\n\n");
	
	output("The special potion makes it so your orgasm is long and languid, oozing out for minutes instead of seconds, and the small chamber is filled with breathy, exultant cries of passion.  Joey leans forward and grabs hold of your [pc.nipples], ");
	if(!pc.hasFuckableNipples()) output("squeezing and tugging on them");
	else output("sliding cum-coated fingers into their slippery depths");
	output(" while he grinds and cums on your [pc.cock].  \"<i>Ungg... yes... gotta... squeeze... allofitooooouuuuut!</i>\" he pants.  He lets go of one tender nipple to reach underneath you, and before you can react, his cum-soaked finger is inside your [pc.asshole], pressing on your prostate.\n\n");
	output("Your eyes cross and you black out, twitching weakly as a regular orgasm bursts on top of your already-protracted potion-gasm.  A pleasant, heavily sexualized dream is interrupted by a finger poking your lotion-lubricated cheek and the best you can manage is an utterly contented \"<i>mmmm.</i>\"  A warm, moist towel is rubbed over your " + pc.face() + ", wiping away the spooge you blasted over it, and now that you can see him, Joey says, \"<i>You had me worried for a minute there!  Keep the towel, it's on the house, and if you need to clean up, there's a shower in the back!");
	if(pc.cumQ() >= 1500) output("  You really flooded the room though, so you'd best walk on your tip-toes until we can get a succubi or a goblin in here to clean up.");
	output("  Come back ANY time, [pc.name].  I'd love to help you release again.</i>\"\n\n");
	
	output("Joey leaves, his poofy tail bobbing back and forth.  You can see his thong is distended, virtually packed with his own still-pumping spooge, and you marvel at his perverse ingenuity when you realize his thong is waterproofed and shaped to guide all the jizz between his thighs and into his back-door.  Kinky.");
	pc.cumMultiplierRaw += 0.02;
	pc.orgasm();
	if(pc.libido() > 20) pc.slowStatGain("l", pc.libido() / -20);
	//if(pc.sens > 40) dynStats("lib", -.5); // ???
	processTime(40);
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}
private function joeyBigBalls():void {
	clearOutput();
	showSlipperySqueeze();
	IncrementFlag("COC.JOEY_BIG_BALLS");
	processTime(3);
	//(FIRST TIME)
	if(flags["COC.JOEY_BIG_BALLS"] == 1) {
		output("Before you can even clear the door-frame, Joey the bunny-boy masseuse launches himself into you, his hands clutching wildly at your [pc.gear].  You look down at him, and his wide, open eyes stare back with panic; namely, the look of someone in over their head with no idea how to save themselves.  Worse still, his trademark thong is bulging out obscenely, cum spilling down the sides while his immensely swollen gonads threaten to burst free of the garment's fraying threads.  Joey babbles, \"<i>Help!  I was testing the potions, and-and-and... I dunno what went wrong, b-b-but my balls are backing up faster than it dribbles out.  They feel like they're going to burst!!  Help meeeeee!</i>\"\n\n");
		output("You push the panicked lagomorph back a pace so that you can breathe and appraise the situation.  Joey's legs are drenched, soaked with sloppy spooge.  His thong is on the verge of bursting.  Most notable, his bloated balls look more like cantaloupes than testicles, and these melons are ripening to an unseen Demeter's power, swelling ever-so-slightly larger with each passing second.  You estimate that there's precious little time.\n\n");
		
		output("Why is it that no one ever desperately requires your assistance with a mundane task?  Sighing, you judge");
		if(pc.slut() > 60) output(", with no more than a bit of wishful thinking,");
		output(" that if someone were to apply suction to his member, it might help to vent the thick-flowing jism fast enough to help out Joey.  There doesn't seem to be anyone else around, so it would have to be you, but with how the parlor's potions work, you might be sucking for a long time...  Then again, if you made have him masturbate, it would probably stimulate his muscles to force all that fluid out.  Of course, if you tell him that, he'll probably run into a back room to try it and leave you be");
		if(pc.slut() > 70) output("; you won't get to watch him fountaining all that pearly spunk like a perverted statue");
		output(".  What do you decide?");
		//[SuckCumOut] [MasturbateOut]
		clearMenu();
		addButton(0, "SuckCumOut", suckOffJoeysGardenHose);
		addButton(1, "MasturbateOut", joeyWanksItOut);
	}
	//(Sucked Joey once) 
	else {
		output("As soon as you enter The Slippery Squeeze, you know somehow that something is amiss.  Joey staggers out from a back-room, his balls once again swollen huge and round.  He looks at you and admits, \"<i>Someone's <b>got</b> to be sabotaging me... gods, this hurts!  Could you help me, or should I go in the back and jerk it out myself?</i>\"\n\n");
		//[SuckCumOut] [MasturbateOut]
		clearMenu();
		addButton(0, "SuckCumOut", suckOffJoeysGardenHose);
		addButton(1, "MasturbateOut", joeyWanksItOut);
	}
}

//Masturbate It Out (work it out on the floor)
private function joeyWanksItOut():void {
	clearOutput();
	showSlipperySqueeze();
	processTime(1);
	clearMenu();
	IncrementFlag("COC.JOEY_BIG_BALLS_MASTURBATE");
	if(flags["COC.JOEY_BIG_BALLS_MASTURBATE"] == 1) {
		output("You tell Joey that if he masturbates to erectness, his body should be able to shoot it out faster.  He smacks his forehead and runs into a back room, his thong disintegrating around his growing testes as he runs. The door slams, leaving you in peace.  A little freaked out, you head back to camp for now.");
		addButton(0, "Next", function():* { processTime(10 + rand(10)); mainGameMenu(); } );
	}
	else addButton(0, "Next", function():* { processTime(10 + rand(10)); mainGameMenu(); } ); // too lazy to disable it for some time...
}

//Suck Cum Out (not your garden-variety hoes)
private function suckOffJoeysGardenHose():void {
	clearOutput();
	showSlipperySqueeze();
	output("Smiling impishly, you say \"<i>I'll just have to suck all that cum out then, won't I?</i>\"  Joey blushes, cheeks reddening to match his plump lips as you yank his rapidly disintegrating thong down to the ground.  Popping free, his half-hard member bobs before your eyes, trailing a thick trail of man-slime the whole way to the ground.  The semi-turgid mass starts at only about four and a half inches long, but as your hot breath washes over it, the twitching, slimy cock grows to its full six-inch size.  Joey moans as the flow from his cock thickens.  His balls keep right on growing, and you realize that they're at least as big as basketballs now.\n\n");
	output("You grab the bunny-boy's pert ass-cheeks and pull your mouth onto his cock, his member easily sliding along your tongue, lubricated by the unholy flow of dick-juice it drips.   Sealing your lips down on his base into a vacuum-tight O-ring, you start to suck, ever-so-slightly ratcheting up the pressure on Joey's poor, backed up penis.  Thanks to your oral cock-pump, he quickly swells beyond his normal max.   Seven inches of dick push towards your throat, and like a valve suddenly becoming unstuck, that cock's cumslit suddenly dilates wide, stretched out to handle the heavy flow.\n\n");
	output("Gurgling in surprise, you nearly choke from the deluge of spooge flooding your throat.  Your tongue tingles from the salty aftertaste while you gulp down the rest of the bunny-cream.  Joey pants and pleads, \"<i>Oooh... it's... it's... so good.  Feels so amazing... don't stop!  Please don't stop!</i>\"\n\n");
	output("You cup the fem-boy's heavy, swollen sack in your hands and keep up the pressure, and he rewards you with another languid eruption of goo.  His balls shrink ever-so-slightly in your hands with every pulsating pump.  You look up while your throat works, meeting Joey's dazed, relieved expression with your own sultry gaze.  He shivers, delivering the next creamy deluge to you on the spot, nearly making you gag.  It's even more voluminous than the pulse before, and if this keeps up, you won't be able to swallow it down.\n\n");
	output("Joey's rouged lips silently mouth, \"<i>Oh gods,</i>\" as he delivers the next, even bigger rope to your eager maw, stuffing your mouth so quickly that his jism squirts from the corners before you can react.  You shiver from the semen overload");
	//if(pc.minotaurAddicted()) output(" and find yourself wishing you had one of these potions to use on a minotaur.  It would be divine!");
	//else 
	output(" and keep at it.  The knowledge that you're helping a friend is almost as filling as his delicious cum.");
	output("  White goo drips down your chin towards the floor, but you note that his balls are now back down to the size of grapefruits.  You're making progress!\n\n");
	
	output("Giving the girly-boy a semen-leaking smile, you milk his cock with determination and enthusiasm, only letting dribbles escape from your mouth when you do too good a job.  Your belly gurgles unhappily as if you've just eaten a huge meal, but you've got to press on!  Lick and swallow, suck and slurp - you fall into a practiced rhythm as you accommodate the bunny's chemically-induced virility.  Soon, your bulging midsection forces you to abandon swallowing and alternate between sucking at Joey's shaft and spitting out his ungodly eruptions of cum.  It runs down your [pc.fullChest], makes a mess of your belly, glazes your " + pc.legs() + ", and eventually comes to rest in the growing, three foot wide spunk-puddle on the floor.\n\n");
	
	output("Joey moans, \"<i>You're so good at this!  B-but I still feel so pent up... so full.  I don't think it's slowing down yet!</i>\"\n\n");
	output("You pull back and gasp for air, ignoring the ropes of spooge splattering across your face and into your [pc.hair].  Determined not to lose your progress, you take his none-too-impressive cock in your hand and jack it, spurring his body to take over and propel even more eruptions of slick seed onto your " + pc.face() + ".  It's so messy, so decadent, but it's ");
	if(pc.slut() < 33) output("all for a good cause, right?");
	else if(pc.slut() < 66) output("also kind of fun, in a naughty way.");
	else output("exactly the kind of nasty stuff that gets your blood pumping.");
	output(" Still, his balls feel even heavier in your hands by the time you return to your post on his post.  You work him dutifully while your mind races, trying to think up a solution.\n\n");
	
	output("An idea bubbles up to your semen-sludged mind, and you act on it without thinking in your desperation.  You slowly squeeze Joey's balls in your hands and smile when his white goo pours from his cum-slit in a high-pressure wave, eventually leaking out your nose.  It takes a moment for you to cough out the salty seed.  You don't deviate from your task in the slightest while you see to your breathing - Joey's balls are kept compressed in your hands.  He wriggles and gasps, but his now-freed member flails around, squirting trails of white across you, the floor, the walls, and the ceiling.\n\n");
	output("Miraculously, his nuts shrink smaller, just a hair bigger than his original size as his seemingly-endless spray winds down.  You wipe his cum from your eyes and lap the stuff from your lips.  Joey sighs and futilely pumps his hips, ejaculating large ropes of seed all over your body, but his condition seems to have stabilized.  If you remember correctly, the potion probably has a few more minutes before it stops.  Time for some fun.\n\n");
	output("You pull Joey down into the puddle he made, instantly soaking his pink top into a salmon-tinged jizz-mess.  \"<i>What's going on?</i>\" he cries, flailing his arms through his rippling spunk-mess before he calms.  You aim his cock up towards his face and smile lewdly as his jizz starts to rain down across his body.  It doesn't have quite enough force to hit his ruby-painted lips, however.\n\n");
	output("\"<i>I'm just having a little fun with the situation,</i>\" you answer while gently pumping the bunny-boy's dick.  He moans beneath your touches, electric shivers of pleasure racing through him as his spurts shoot further and further, finally reaching his face.  In no time, his lips are as pink as his top, with a nice, salty shine.  Joey moans and lands a glob on his forehead.  The next creams his hair.  You gently swat his balls and watch the next shot go past his head to splatter on the side of the counter.  Purring, you muse, \"<i>Oooh, you're getting better at this.</i>\"\n\n");
	output("\"<i>I'm so sorry!</i>\" cries Joey as his hips grind against your hands, \"<i>Something was - ah - wrong wi... with this batch.  I didn't mean for any of this to happen!  I t-think the demons are trying to sabotage my business!</i>\"\n\n");
	output("You sigh at that, but it would make sense.  Even here, under a watchful eye, the demons can't seem to stop their scheming.  You rub Joey's balls as the last of his cum drains from his twitching, unused fuck-stick and stand up, the added weight of his jizz in your belly making it a little difficult.  The bunny-boy keeps moaning and wriggling on the floor, still coming down from his orgasmic high.\n\n");
	output("Pulling him up, you drag the both of you deeper into the trailer to find a shower, where you both clean up with a touch of good-natured teasing.  Once the cute 'trap' and you are free of his goo, you head back to the entrance.\n\n");
	output("\"<i>I cleaned out your balls; you can clean up the floor,</i>\" you joke as you leave, kissing him one last time on the mouth before you go.\n\n");
	output("Joey blushes again and begins looking for a mop.");
	pc.lust(70);
	processTime(40);
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}

///*At the Slippery Squeeze
//There's another option on the list, cheerfully presented with a pastel border and a little painted egg next to it.  'Sweet Massage' it says.  \"<i>That's our spring special,</i>\" Joey explains, \"<i>using our new chocolate-flavored massage oil.  It comes with a complimentary 'dessert.'</i>\"  He gives you a little wink at that last word, so you can be certain that it's no normal dessert.
//*/

//"Sweet Massage"
private function joeySweetMassage():void {
	clearOutput();
	showSlipperySqueeze();
	pc.credits -= 200;
	//statScreenRefresh();
	output("Joey claps excitedly, his little puffy tail bouncing happily.  \"<i>Great!  It's a customer favorite, so I'm sure you'll just love, love, love it!</i>\"  He takes your hand and leads you towards the back rooms, letting the door shut behind the two of you with a soft click.  As usual, in the center of the room is a padded bed meant for you, and at Joey's insistence you disrobe to lie down on it.  You put your face through the rounded oval and relax, taking the moment to watch Joey's bare feet with their cute painted nails prance in and out of sight as he bustles around the room.  He pauses briefly by the coal-fired steam-oven, stoking it for a minute before turning back towards you.");
	
	output("\n\nThe warm, steamy air caresses your " + pc.skinFurScales() + " even before Joey does, running down your back, butt and [pc.legs].  In no time at all, the air in the room is thick and warm, making you feel delightfully lazy with every breath, and a bead of sweat forms on your brow.  The bed shifts a bit as Joey leaps up onto it, straddling your waist, while he starts working his fingers over your shoulders.  His petite hands are surprisingly talented, finding every little knot you've accumulated in your journeys and unravelling them with one blissful touch.");
	
	output("\n\nAs usual, he works his way down your body, sliding his hairless body against yours as he goes.  His magic fingers work out a particularly troublesome knot in your lower back in no time, then he moves to your arms and legs.  He doesn't stop until you feel like putty, so relaxed you wonder if you're even capable of movement.  Afterwards he simply rubs you down, checking for any missed tension spots.  The whole while his little cock strains the little white thong he sports, occasionally pressing against your back, butt or leg.");
	
	output("\n\nJoey hops off of you and you notice his cute femboy feet round the table, heading towards a small counter nearby hosting a large number of bottles.  You hear the sounds of a cork being pulled from one such bottle, followed by the bunny-boy gulping down its contents.  Then, surprisingly, he bends over, letting his thong pool around his ankles and revealing his cute, pink asshole.  He retrieves something else from the table and pulls it into view... a large multihued egg!  Joey places the egg at his butthole, which contracts in anticipation.  Slowly he works it inside, a task that you're sure would put the average anal acrobat to the test, but Joey is clearly no amateur.  The egg disappears completely within a couple minutes, swallowed up by that sweet little pucker.  Joey pulls his thong back up and turns towards you, his modest erection raging right in front of your face.");

	output("\n\nRather than the usual stream of off-white jism, what starts pouring out the tip of his cock is a rich brown color.  It's viscous, and when it dribbles down onto the floor it forms a velvety pool.  Your masseuse scoops some of it up with two fingers and slips them into his mouth, closing his eyes as if he's enjoying an incredibly tasty treat.  \"<i>Mmm,</i>\" he moans, \"<i>chocolate.  This is what makes the sweet massage so sweet.  It's just as good as my creamy lotion, and twice as tasty.</i>\"  Joey turns away, retrieving another large egg from the table.  You wonder briefly if he has room for two of the two huge eggs in his ass, before he asks, \"<i>Would you like an egg too?  They don't have anything to do with the massage, but I just </i>love<i> feeling so full, don't you?</i>\"");
	pc.lust(25);
	//[Yes (gives the chocolate-egg stuffed ass from the Easter bunny)] [No (This just skips the "If Yes" paragraphs)]
	clearMenu();
	addButton(0, "Yes", eggsInButt, true);
	addButton(1, "No", eggsInButt, false);
}

private function eggsInButt(eggButt:Boolean = false):void {
	clearOutput();
	showSlipperySqueeze();
	if(eggButt) {
		output("You nod your head to the little femboy, who jumps with joy, splattering a little string of chocolate cum across the floor.  He walks around behind you and asks you to raise your butt.  You do so, surprised to find you can move after that initial massage, raising your ass high into the air and positioning your knees under you.  You can't see what he's doing back there, but when you feel a warm splash of liquid against your [pc.asshole], you let your mind's eye go to work.");
		output("\n\nJoey gathers up another dollop of the chocolatey cum and smears it across your butthole. Then he takes two fingers and gently prods inwards, sinking in knuckle-by-knuckle.  He works the two fingers in, pumping and sliding them around, coating your walls with his jizz.  When the bunny-boy retracts his fingers, you find yourself aching for his touch, wanting something, anything, inside you.  You don't want for long, of course, as Joey retrieves the giant painted egg and presses it up against your empty asshole.  He pushes it forward, your cum-lubed ass parting to make way.  It stretches you further and further outwards, nearing discomfort levels, but then you round the widest point and your [pc.asshole] devours it with a wet <i>schluck</i>.");
		output("\n\nJoey rubs your asshole some more, working his little masseuse fingers all over, helping it to relax once more.  You feel so deliciously full with that egg inside you, like you have a giant cock constantly fucking you.  It gives you a little thrill to know that both of you are packing this monster of an egg inside of you, and that he's feeling the same things you are.  You lower your legs and ass marveling at the sensations of the egg shifting around.\n\n");
	}
	//(Continue Here)
	output("The dainty little femboy hops back up onto the table, straddling your ass.  He gives his cock a few little strokes, pouring the warm chocolatey 'massage oil' right onto the small of your back.  Rivulets of the bunny-spunk cover your back, giving you goosebumps as they roll across you like velvety rivers.  His hands go to work once more, working the rich brown liquid into every pore, coating your back in chocolate.  He repeats his actions from before, his thumbs and knuckles working your flesh as though he were a master sculptor working clay.");
	output("\n\nWithout bothering to get off of you, Joey asks, \"<i>You want to turn over for me?</i>\"  You oblige, rotating around while the masseuse remains straddling your lower body.  His little cock presses against your ");
	if(pc.hasCock()) output("own");
	else if(pc.hasVagina()) output("cunt");
	else output("pitifully empty mound");
	output(", its candy-coated flesh slipping enticingly over yours.  To your surprise, Joey seems to be wearing some kind of cock ring for this massage.  It's multicolored, just like the eggs, encircling his small (by Mareth's standards) manhood.  As you watch his balls seem to twitch and inflate ever-so-slightly.  That thing is preventing him from cumming completely, whatever it is, everything coming out must be pre-cum!");
	
	output("\n\nJoey catches your gaze, \"<i>Oh yes.  This would be your dessert, I'm saving all this sweet chocolate just for you.  The ring is candy too.  Melts in your mouth, not on my dick.  But that 'comes' later, now we have to work out all that tension in your body.</i>\" He giggles, letting his cock drool its candy payload all over your groin, stomach and chest before getting to work, his fingers working the goo into your skin.  As he works on your stomach, groin and hips, he actually flips around, so that his dripping package is right over your face.  Chocolate drips onto your face, and you can't help but to lick your lips to sample this confectionary cum.  It's sweet and rich, just like real chocolate, but it still has the salty-sweet tang of semen.  All in all, it's an interesting combination that you're eager to get more of.");
	
	output("\n\nThe rabbit-eared boy's hands find your ");
	if(pc.hasCock()) output("[pc.cocks]");
	else if(pc.hasVagina()) output("[pc.vagina]");
	else output("[pc.asshole]");
	output(", spreading his sweet bounty all over.  His fingers to go work, rubbing up and down");
	if(!pc.hasCock()) output(", in and out");
	output(", removing all that pent up tension from inside you.  ");
	if(pc.hasCock()) output("[pc.EachCock] begins leaking pre-cum, mixing with Joey's on your belly to create what looks like a chocolate-white chocolate marbled confection.");
	else if(pc.hasVagina()) output("Your cunt grows ever wetter, and not just because of the new chocolate coating.  Despite Joey's femboy appearance, you've got to hand it to him, he does know his way around a pussy.");
	else output("Your asshole winks and clenches, aching for release that Joey is kind, and skilled, enough to give.");
	
	output("\n\nIn no time at all, your body is arching on the bed under Joey's ministrations.  You gasp as his fingers twirl around your groin, expertly bringing you to the edge.  More of his chocolate-flavored cum drizzles into your open mouth; you can't help but gulp it down eagerly.  Every mouthful of that rich, sweet cum seems better than the last.  Sadly, Joey switches positions, straddling your waist, leaving your chocolate-smeared mouth empty once more.  He ");
	if(pc.hasCock()) output("takes hold of [oneCock] and strokes gently, rubbing his thumb against the head");
	else if(pc.hasVagina()) output("reaches between his legs, slipping two fingers inside you while his thumb gently rubs your clit");
	else output("reaches between his legs, slipping two fingers inside your ass while his thumb rubs against your perineum");
	output(", and with his free hand he leans forward, tweaking a [pc.nipple] softly.");
	
	output("\n\nUnder his skilled hand, you're soon bucking and twitching, your candy-coated body aching for release.  \"<i>Let's... just... get all of this... naughty... tension... out,</i>\" he pants, emphasizing each word even though his voice barely rises above a whisper.  With one final twist of his fingers, you're sent over the edge.  Your body arches, lifting Joey up into the air with a gleeful shout, while ");
	if(pc.hasCock()) output("[pc.eachCock] pulses and spasms, loosing rope after rope of white jizz through the air, splattering against the wall and floor messily");
	else if(pc.hasVagina()) output("your pussy tightens around his fingers, suddenly releasing a flood of femcum that splatters messily against the table");
	else output("your asshole twitches and spasms, unable to do much more than grant you a vague half-orgasm");
	output(".  Your entire body tingles as you slowly descend back to the table, practically melting into it as if you were nothing more than the bunny-spunk covering your skin.");
	
	output("\n\nJoey giggles again, slipping off of you, landing on the floor with a wet slap.  The floor must be covered in various liquids by this point.  He raises his hand to his mouth, tasting the mixture of your juices on his fingertips.  You lean back on the bed, completely relaxed.  You try to raise a hand, but fail completely, your body is simply too loose to obey you right now.  Thankfully, you don't have to move for what Joey seems to have in mind.  He flips a lever on the headrest, lowering it down slightly so your head is almost hanging off the edge.  You see him upside down, his chocolate-glazed cock staring right down at you.  His sack, amazingly, has swelled up incredibly during the massage.  While he once sported an average set of balls, these are easily the size of basketballs now, filled with tasty candy goodness.");
	output("\n\n\"<i>Mmm, this is my favorite part!</i>\" Joey laughs, stroking his dick, \"<i>dessert!</i>\"  You gladly open your mouth just as Joey pushes forward, taking his entire member into your mouth.  Considering what else lives in Mareth, Joey is practically tiny");
	if(pc.hasCock()) {
		if(pc.biggestCockLength() >= 12) output(", especially compared to you.");
		else if(pc.biggestCockLength() < 4) output(", of course, if he's considered tiny, what does that make you?");
	}
	else output(".");
	output("  You suck and slurp, slipping your tongue up and down his length until not a trace of chocolate remains.  His penis continues to leak the chocolatey pre-cum, but the deeper you take him, the less it matters, until he's practically pumping the chocolate directly into your stomach.");
	
	output("\n\nYour lips eventually wrap around the cock ring keeping you from your 'dessert.'  You suck and lick at it, tasting the hard candy shell.  It takes several minutes of dedicated licking; all the while Joey continues to directly feed your gullet with his pre-cum.  Finally, the cockring snaps.  It's like a dam bursting: what was once a trickle of chocolate becomes a flood.  Joey's cock bulges unnaturally as what must be a gallon of rich, sweet chocolate is released into your mouth and throat.  You hungrily gulp it all down, not even taking the time to savor its taste, just wanting more and more of the velvety bunny spunk.");
	
	output("\n\nA strange bulge runs over your tongue, through Joey's cock.  You reflexively swallow, amazed to find it's something solid... he just laid a tiny egg in your mouth!  Another bulge presses up his cock, and this time you take it into your mouth, rolling the oblong chocolate around before swallowing that too.  Egg after egg flows into your mouth, leaving your head spinning as you struggle to take them all.  After what seems like hours, when in reality it was more like minutes, of sucking, swallowing and slurping, Joey pulls out of your mouth and leans against the wall, exhausted.  You take even longer to recover.  Your stomach gurgles happily, filled with Joey's jizz and his candy egg bounty.");
	
	output("\n\nJoey sets the headrest back up, pats you on the head and says, \"<i>Take as long as you want to recover, you sweet thing, you.  There's a towel on the table, and a shower in the back!  Come back ANY time, [pc.name].  I'd love to give you another 'dessert.'</i>\"");
	
	output("\n\nJoey leaves, his rabbit tail bobbing to and fro.  You see his thong is distended, practically packed to the brim with more of his still-drooling chocolatey cum.  As usual, the waterproof thong seems to be pumping it all between his soft thighs and right into his already egg-filled asshole.  He really does like feeling full back there.  Kinky.");
	pc.orgasm();
	//dynStats("lib", -2, "sen", -2);
	pc.slowStatGain("l", -2);
	processTime(40);
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}