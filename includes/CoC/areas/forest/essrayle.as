import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function essrayleMeetingI():void {
	clearOutput();
	if(Flag("COC.MET_ESSY") == 0) {
		output("You blunder along through the thick foliage, swatting aside stray branches and the long grasses that try to impede your progress.  A clearing appears up ahead, giving you a goal to reach.  Honestly, you could use a brief break.  Forging through the brush, tromping, and causing a general ruckus, you practically burst into the glen in no time.");
		output("\n\nYou realize you're not alone.  The other occupant looks at you a bit startled, and you look back with more awe than anything.  It is a woman, isn't it?  You can't be fully sure.  Her body is slender, soft green in hue, and she has an elfish, noseless face.  Green, grassy hair cascades down her back, and a large, wooden horn rises from her forehead, ornamented like something you would see on a beetle rather than a person.");
		output("\n\nThe first thing to catch your gaze are her eyes; rich, deep amethyst things.  ");
		if(pc.cor() < 33) output("Despite however chivalric you think yourself");
		else if(pc.cor() < 66) output("Despite your better sense");
		else output("Perhaps best of all");
		output(", your attention falls to her chest.  This emerald maiden sports a pair of breasts that'd make even a demon blush, gorgeous green globes that look like small watermelons resting upon her upper belly, capped with purple areolae.  Four, thick, teat-like nipples dangle a good three or four inches from each.");
		
		output("\n\nLikewise, four slender, green arms grace her form.  Instead of legs, a single, serpentine, smooth stalk rises from what looks like a giant flower bulb resting on the grassy ground. With her movement it seems to quiver slightly, though not nearly as much as those gigantic breasts do.");
		
		output("\n\nSeeing how you stare, the plant woman doesn't try to cover herself in shame, but thrusts her chest out a bit more, causing the pair to jiggle temptingly.  \"<i>Like what you see?</i>\" she coos, winking coyly and giggling to herself.  You fumble for the right words, ");
		if(pc.cor() < 33) output("hastily looking away from her nude body");
		else if(pc.cor() < 66) output("looking away out of courtesy");
		else output("letting your eyes roam over her as you search for even more depraved features on her nubile body");
		output(".");
		
		output("\n\nA soft, sweet-smelling hand rests under your chin and directs you to look back to her once more.  \"<i>Don't be so shy,</i>\" she coos, pressing those large, squishy things firmly against your ");
		if(pc.biggestTitSize() >= 10) output("own");
		else output("[pc.chest]");
		output(".  \"<i>You must be one of those adventurers I've been hearing about, am I right?</i>\"");
		
		output("\n\nYou nod, her beautiful eyes seeming to capture and hold yours the moment your gazes meet.");
		
		output("\n\n\"<i>Mmm-hmm, thought so. Well, it's nice to meet another not from around here.</i>\"  You blink, and she seems to smile, as if guessing your thoughts.  \"<i>I know, I know, I look like a regular, but I just kinda stumbled in here on mistake!  Not that I mind, mind you,</i>\" she winks, grinning.  \"<i>I just LOVE it here!</i>\" she exclaims, throwing out her arms (the top pair) to indicate the forest about you two.  \"<i>This place is absolutely perfect,</i>\" she grins and murmurs, \"<i>perfect for someone like me,</i>\" before speaking up once more, \"<i>I just want to see and befall- er, experience more!</i>\"");
		
		output("\n\nSlowly, you nod, trying to focus on your words, but it's rather humid here, and very hard to focus.  With how she keeps moving about, undulating and rippling that base, it seems like every action she makes is designed to intrigue and arouse any who behold her.");
		
		output("\n\nAbruptly she stops, cheeks turning a gentle purple as she looks to you.  \"<i>Oh, I'm sorry.  I 'm so excitable lately.  My name is Essrayle - Essy for short.  It's quite a pleasure to meet you.</i>\"  Though spoken sweetly, you can't help but feel a warm twinge as she enunciates the word 'pleasure,' or was that your imagination?  It's so warm here, hot and heavy about your body.");
		
		output("\n\nEssy smiles, bulb rippling as she nears you again.  \"<i>Say, you're a hero, right?  Do you think you could do a girl a favor?~</i>\"");
		
		output("\n\nWith the way she moves and seems to saturate the air around with her sexual tension, you're sure that helping her will lead to something sexual.  Do you help her?");
		pc.lust(5);
	}
	else {
		output("During your travels through the forest, you stumble upon a familiar face once again.  \"<i>Oh, hello!</i>\ Essrayle cheerily waves to you, causing her ample tits to jiggle slightly.  \"<i>I was wondering if you'd be back.</i>\"  She moves closer, massive melons wobbling mere inches away from you, \"<i>I had a feeling you would though.</i>\"  Cooing warmly, she brushes a lock of hair aside with enough of an exaggerated motion to set the bouncy pair to bobbing.");
		output("\n\n\"<i>So, did you come back just to say hi, or might there be some other reason?</i>\"  Those slender, green hands fall upon her shapely hips as her gorgeous amethyst eyes peer deeply into yours.  \"<i>If you came to give me a feeding, I simply must thank you this time, I insist.</i>\"  Abruptly, those tits squish against your chest as she leans in close, asking seductively, \"<i>So, feeling up for some gardening?</i>\"");
	}
	IncrementFlag("COC.MET_ESSY");
	//[Yes] [No]
	clearMenu()
	addButton(0,"Yes",plantsForMe);
	addButton(1,"No",noPlantsForMe);
	
}
 
//>If No
private function noPlantsForMe():void {
	clearOutput();
	output("Essy pouts, ears flattening to the sides a bit.  \"<i>I see,</i>\" she nods, looking at you with thinly masked disappointment.  She seems to instantly put on a false smile and move aside, gesturing to the path ahead with a sweep of the arm.  \"<i>Well, in that case, you must be going somewhere important.  Best not keep you waiting.  I do wish you luck in your adventures!</i>\" She continues to beam as you head on off, leaving her behind you in no time.  Though as you leave, you swear you hear a mumbled, \"<i>Leave it to me to find the prudish ones.</i>\"");
	flags["COC.TURNED_DOWN_ESSY_FIRST_MEETING"] = 1;
	doNext(returnToCampUseOneHour);
}
 
//>If Yes
private function plantsForMe():void {
	clearOutput();
	if(flags["COC.ACCEPTED_ESSY_FIRST_MEETING"] == undefined) {
		flags["COC.ACCEPTED_ESSY_FIRST_MEETING"] = 1;
		output("Essrayle giggles, sending ripples through her ample breasts.  \"<i>Oh, why thank you!  It's nothing major - I doubt it'll be much of a burden to you.  But in my travels, I've grown wilted and depleted of the energy to go on.  I'm soooo hungry!  Would you please-?</i>\"  She leaves the question hanging, looking to you imploringly.  Hastily your hand goes to where your supplies are housed, but you stop as she waves a hand dismissively.  \"<i>No, no, I don't mean biscuits or the like.</i>\"  Confused, you frown, but soften as you feel her hand rest upon your [pc.chest].  \"<i>I require a special kind of food to do what I do, one that won't exhaust your supplies in the least.</i>\"\n\n");
	}
	//(If breasts
	if(pc.biggestTitSize() > 1) output("Your nipples stiffen, breasts puffing out with a heated breath");
	else output("You arch your back gently, unconsciously pressing into her slender fingers a bit further");
	output(" as her hand begins to circle your chest.  \"<i>Though you, that's another story.</i>\"  She grins seductively as the air around you seems to thicken with a gentle pink mist.  Out of instinct, you look around, trying to discern the source - could she be one of the demons?");
	output("\n\nAgain you hear Essy's laugh, sweet and playful, feeling her suddenly hug you tight into her ample bosom.  Her skin is so soft, smelling so sweet and rather floral, and those tremendous breasts squish as they cover the lower half of your [pc.face], silencing any protests you might have.  \"<i>Shhh, just relax,</i>\" she coos, a hand caressing your back tenderly, \"<i>just breathe deeply, cutie.</i>\"");
		
	output("\n\nNot in a position to argue, you take a deep, albeit shaky, breath.  The air smells sweet as well, like you're amidst a sea of wildflowers in full bloom.  Your eyelids flutter gently.  It's so aromatic, so soothing.  Essy smiles to you.  \"<i>That's right, you're safe here, helping Essy out in her need.</i>\"  Taking another deep breath you feel your muscles relaxing, just wanting to get to the next breath as you exhale in order to take in more of the fragrance.");
		
	output("\n\nShe continues her work, keeping you soothed and at peace as she works.  Her hands steadily remove your [pc.gear], sliding it off of your unyielding body with great ease.  Each piece lands almost silently behind you as it's discarded to the grass until you stand completely naked, just like her.");
		
	output("\n\n\"<i>Such silly things.  It always puzzles me why you mortals wear so much.</i>\"  Your eyes scan about her body, searching for any clue of demonic nature.  She lacks the horns, her own being more majestic and beautiful than any you've seen, and she lacks the muscles you'd expect from a threat.");
		
	output("\n\nUpon her back, apparently blooming from it, is a large, pink flower from which streams that pink mist,  blanketing the area.  Abruptly, Essy lifts you up, tilting your head gently as she presses her dainty, green lips to yours.  It doesn't take long before the two of you begin to passionately make out, as if you'd cared for one another for years.  Her tongue pushes into your mouth, feeling unusually soft, a bit ticklish, and tasting of... mint?");
		
	output("\n\nSlowly, you two separate, Essy sliding her leaf-like tongue over your lips, leaving them with a cool tingle for a time.  \"<i>I'm sooooo hungry... so very, very hungry,</i>\" she whispers to you, her face touching your nose once more.  One of her hands begins to trail down your front, grasping and squeezing your nipples.");
	
	//(If breasts present)
	if(pc.breastRows[pc.biggestTitRow()].breastRating() >= 1) {
		output("\n\n\"<i>Oooh, how I adore these,</i>\" she coos to you, taking your breasts into two hands and beginning to squeeze and knead firmly into the pillowy flesh");
		if(pc.bRows() > 1) output(" of your uppermost pair");
		output(".  You moan, and this only seems to encourage her, as she takes your nipples between thumb and forefinger, twisting and turning them this way and that.  She giggles at how your moans seem to fluctuate by coincidence, continuing to tease them");
		if(pc.bRows() > 1) output(", steadily working over the multitude of fleshy mounds on your body");
		output(".");
		if(pc.hasFuckableNipples()) output("  Her fingers play with your nipples and press gently to tease at them.  She seems quite surprised as they sink in with minimal effort.  A grin spreads over her face as she begins to steadily thrust those digits in and out of your nipples, fingers swirling about the interiors all the while.");
		output("  \"<i>You certainly have a lovely pair, but they could always be better, don't you think?</i>\"");
		//[Yes] [No]
		clearMenu()
		addButton(0,"Yes",plantsForMe2,1);
		addButton(1,"No",plantsForMe2,2);
	}
	//Else
	else {
		//[Next]
		clearMenu()
		addButton(0,"Next",plantsForMe2,0);
	}
}

private function plantsForMe2(BE:int = 0):void {
	clearOutput();
	//Yes
	if(BE == 1) output("Essy grins, nodding.  \"<i>Precisely.  I don't doubt they'll be even more fun given enough exposure here.</i>\"\n\n");
	 //If No= 
	 else if(BE == 2) output("\"<i>Heh, suit yourself.</i>\"\n\n");

	//Regardless of tit forks, merge back in to this
	output("Essy's upper hands continue their work about your chest, toying around as one of her lower arms moves about your belly, snaking downward slowly all the while.  As you wiggle and writhe under her sensual ministrations, one of those hefty breasts abruptly plants itself in your face.  \"<i>Why should you have all the fun?</i>\" Essy coos, directing your mouth to one of her puffy nipples.  Without hesitation, you latch on and slide down its length with your lips.");
	
	output("\n\nBeing rather large, it takes a moment to reorient yourself, but you manage to almost deepthroat the entirety of it.  Essy squeaks in surprise, moaning out as you take her nipple all the way and more as one hand kneads and squeezes through the almost doughy flesh of her other breast.  Clamping down with your lips, you begin to tug and suck as hard as you can.  You're briefly surprised when a long, loud, pleasured 'Moo' comes from the plant girl, and thick, syrupy, milky sap spills into your mouth almost instantly.");
	
	output("\n\nHer milk is a delightful substance, tasting like sweet cream, and you eagerly gulp it down, nursing hungrily for more.  The bovine utterances continue as Essy's lowest hand moves further down your waist, eventually coming to rest upon your crotch.  Though she's obviously highly distracted by your attentions to her breast, those lithe fingers ");
	if(pc.hasCock() && pc.hasVagina()) output("find the dual sexes there.  Another hand joins the first, one gripping and tugging on your hardening cock as the other cups and squeezes over your pussy.");
	else if(pc.hasCock()) {
		output("circle about ");
		if(pc.cockTotal() > 1) output("one of ");
		output("your shaft");
		if(pc.cockTotal() > 1) output("s");
		output(", beginning to squeeze and slide about its length until your nursing is interrupted by moans of your own delight");
	}
	else output("stroke about the puffy, now-inflamed lips of your own flower, taking the lips between two fingers and stroking up and down across their length fully before switching to your moist core.");
	
 	output("\n\nA firm hand cups your ");
	if(pc.isTaur()) output("back");
	else output("butt");
	output(" and pulls you close, forcing your [pc.legs] against her bulb.  They sink in slightly as you go down, reluctantly relinquishing her nipple from your mouth.  As it springs free, a thick glob of sap splatters over your lips and nose.  Essy giggles softly as she wipes them off with a hand.");
	
	output("\n\n\"<i>I'm glad you enjoy me, sweetie, I really want to enjoy more with you, but I need it so bad right now!</i>\" Essy whines, her shivering, fat breasts jiggling about as she does.  A multitude of vine-like tentacles burst from her back flower and arc about her, coiling about your arms, waist, ");
	if(pc.hasTail()) output("tail, ");
	output("and [pc.legs], ");
	if(!pc.isTaur()) output("lifting you slowly into the air");
	else output("forcing you to rear up");
	output(".  Her lower hands grasp you, helping to raise you up until you're at the proper height, whence she abruptly plants her lips upon your crotch.");
	
	//Cock=
	if(pc.hasCock()) {
		output("\n\nEssy drags her thin tongue over the length of [pc.oneCock], flowing over every inch of it, bending about its curve as she licks from base to tip before engulfing it with her lips. Without a moment's hesitation, she slides down to the hilt, giving amazing pleasure from the surreal tightness, hitting you as you feel the plant's throat rippling and actually milking at your length.");
		
		output("\n\nEssy just smiles as she begins to bob her head, slowly at first, but with increasing speed as your moans of delight egg her on.  Two tentacles rise up, funneling wide at the tips and engulfing your [pc.nipples]");
		if(pc.breastRows[0].breastRating() >= 1) output(" and " + pc.breastCup(0) + " breasts");
		output(".  The opaque cups pump and suck, Essy humming to herself as the base of her tongue continues to skillfully tease over every hot spot near the [pc.cockHeadBiggest] of your [pc.cockBiggest], her length slithering about it skillfully.");
	}
	//(Pussy=
	else {
		output("\n\nSmiling as she inspects your now juicy folds first hand, her lips close over yours, tongue snaking and squirming into your quivering pussy.  The plant gives you a royal tongue-lashing, slurping away lewdly, lips plucking at your throbbing clit with amazing expertise.");
	}
	//[if breasts then also=
	if(pc.biggestTitSize() >= 1) {
		output("\n\nYour breasts bounce and quiver wildly as you bounce up and down, held tightly by those tentacles, Essy dining happily down below.  Those opaque coverings ripple and squeeze hard about your breasts, pumping them for ");
		if(pc.lactationQ() >= 400) output("your milk and ");
		output("your pleasure.  In time, their pumping increases in force and tempo just as her lips and tongue do.");
	}
	
	output("\n\nAnother tentacle momentarily rubs over her breast, growing slimy with the sap before it moves around behind you and abruptly shoves into your [pc.asshole].  Like a professional, she takes it slow to start, letting you adjust to the unique girth and contours of the tentacle as it plunges in deep.  It smoothly pulls nearly out only to pump in deeply once more.");
	pc.buttChange(10,true,true,false);
		
		
 	output("\n\nIt doesn't take long before you're screaming out in climax.  The pleasure swells and ebbs steadily, your planty friend making it sound like she's enjoying a four-course meal fit for a queen.  She continues to pump you on all fronts, not daring to stop until she's certain she's drained you for every drop she can get.");
	if(pc.cumQ() >= 500 && pc.cumQ() < 2000) output("  It takes some time for her to completely drain your virile reserves, humming happily as splurt after splurt bulges her cheeks and forces her throat to work.  By the time you start to go dry, you can swear the bulb that is her base looks a little bit bigger, and perhaps her breasts as well.");
	else if(pc.cumQ() >= 2000) output("  This is a bit hard, as your virile cum-spout renders her trim belly bloated, and the bulb that forms her base rapidly swells with growth thanks to your fecund deposits.  The seed even trickles out around the corners of her mouth as she greedily attempts to devour it all, sighing around each cheek-stretching ejaculation.");
	
	output("\n\nYou hang limply in her tentacles as she sucks firmly on you, a final pull before she pops off wetly.  Licking her lips to get every stray drop, she lowers you to the ground, tentacles disengaging and pulling back to where they came from.  She shivers gently, squishing her fat bosom in a self-hug.");
	
	output("\n\n\"<i>Oooh yes,</i>\" she grins, \"<i>this will do me quite nicely for a time.</i>\"  She looks over to you as you lay there, spent, panting hotly as you struggle to regain your composure.  Smiling softly, she moves over and extends the stalk from her bulb, stretching with naga-like ease out to 'sit' at your side.   Her hand slides over your brow, wiping it dry and gently brushing through your [pc.hair].");
	
	output("\n\n\"<i>I thank you for your kindness, stranger,</i>\" she coos softly with each caress, the mist slowly dissipating.  \"<i>I'd love to stay and enjoy you for a week or two, but I really should get going; so much to see and do here still.</i>\"  Essy grins, leaning down and kissing you tenderly once more, lingering a bit before pulling back up, still smiling at you.  \"<i>But hey, maybe we'll run into each other some time, you never know.</i>\"  She winks, giggling as she returns to her usual position in her bulb.");
	
	output("\n\n\"<i>Good luck on the whole adventure thing, but don't forget to take some you time.</i>\"  She grins, waving before heading off, hips swaying seductively as she leaves the area.");
	
	//(BE Reward scene, result of answering Yes to breasts being better)
	if(BE == 1) {
		output("\n\nEssy suddenly stops before leaving the clearing. Slowly, she pivots on the spot, smiling.  \"<i>Say, it'd be pretty rude of me to just dine and dash.  Why don't I give you a little reward for your kindness?</i>\" Giggling softly, she draws close to you once more, mashing her green breasts to your own, overtaking them with her squishy girth.  You begin to speak when her finger falls upon your lips. \"<i>Shhh,</i>\" she silences you with a smile.");
		
		output("\n\nThose massive tits begin to grind about your own, puffy nipples feeling warm against your flesh as they move up, down, and around in slow circular motions, their owner smiling knowingly all the while. It begins to grow soothing indeed, almost playful when a sudden pressure grips about your [pc.nipples] tightly.  It feels almost as if they were being enclosed in some tight tubes, squeezed upon tightly but never painful.");
		output("\n\nCurious, you look down to the source of the compression.  Gone are the flopping faux teats, and further down, a single massive, purple nipple seems to fatly squeeze about your own smaller one, engulfing it with ease.  A quick glance confirms the other");
		if(pc.totalNipples() > 2) output("s have");
		else output(" has");
		output(" been swallowed up as well.");
		
		output("\n\nBefore your eyes, the planty maiden's breasts seem to suddenly expand, a pleasured sigh coming from Essy as they shrink just as suddenly, and a warm pressure abruptly floods into your chest.  Amazingly, your own breasts seem to puff up a bit following this sensation, not simply shrinking back to normal as hers just did.  Rational thought is obliterated when her two upper hands move to your enlarged teats, beginning to squeeze into the sensitized flesh, kneading at them firmly.");
		
		output("\n\nOnce more your [pc.legs] shake some as the surreal experience continues. The pressure only grows with each throb of those fragrant, green breasts, your own only increasing in size with every pulse they give.  A third hand combs along your cheek, Essrayle cooing sweetly to you. \"<i>Relax,</i>\" she whispers, \"<i>relax and enjoy.</i>\"");
		output("\n\nAs the weight in your chest steadily increases, her hands take hold of you, keeping you standing through the pleasurable procedure.");
		if(pc.bRows() > 1) output("  She eventually dislodges with a wet pop, setting your new breasts to wobbling about as she moves down your body, repeating the gestures upon each set of breasts in return.");
		
		output("\n\nWeak from the pleasure, the last thing you see is her smiling face before you fall forward into her embrace.  The next thing you know, you're alone in the glade, staring at the canopy above.  There's a heavy weight on your chest and you struggle to sit up.  " + num2Text(pc.bRows() * 2) + " massive breasts jiggle and sway upon your chest, all full and aching to be milked");
		if(pc.bRows() > 1) output(", the top pair being largest, descending in size with each subsequent pair");
		output(".");
		//Boost size, set lactation quantity.
		Mutator.growTits(pc, 7, pc.bRows(), false, 2);
        output("\n\nYou sit there for the next hour or two, milking your bloated bosom and giving the flora a generous watering in the process.  When all is taken care of, you stumble back upright with a brief struggle and don your gear once more.  The smell of fresh-cut flowers seems to linger on your [pc.gear] as you depart.");
	}
	if (pc.hasBreasts() && pc.isLactating()) {
        pc.milked();
        pc.boostLactation(5);
    }
	pc.orgasm();
	//dynStats("lib", 1);
	//Slimefeed!
	//pc.slimeFeed();
	pc.libido(1);
	pc.slowStatGain("l", 1);
	doNext(returnToCampUseOneHour);
}


//Look Closer
public function approachTrappedEssy():void {
	clearOutput();
	if(Flag("COC.ESSY_DUNGEON_FUCKED") == 0) {
		output("Where once the leafy maiden sported two enormous, watermelon sized breasts, she now is host to four mammoth jugs that put her former bust to shame.  The heaving tits glisten with moisture and almost seem to swell with every exhausted breath she takes.  Her hips - what you can see of them beyond the plant's gigantic udders - are immersed in a black, rich soil that fills the pot to its lip.  A glaze is prominent in her purple eyes, and she seems quite exhausted from something.");
		
		output("\n\nAs you draw nearer she bolts upright, sending oceanic ripples through her bloated breasts that gives a liquid jiggle to her whole body.  \"<i>Who's there?  It can't be time already!</i>\" she blurts out frantically, before noticing you.  A violet blush stains her emerald cheeks as she recognizes you and her panic is swiftly replaced by a gentle smile.  \"<i>Oh, hey, it's you again.</i>\"");
		
		output("\n\nYou ask the potted girl what happened to her, bringing an even deeper tinge to her cheeks.  \"<i>Oh, uhh, well I was travelling about and when I reached the edge of the forest, I found this very attractive lady walking out of the desert.</i>\"  Essy coos softly to herself, grinning at the memory.  \"<i>And of course, we had some fun, she seemed to enjoy my breasts and especially my sap, so she suggested I come back with her and share it with her sisters.  I thought it'd be fun to visit them, buuuut I guess they had other ideas.</i>\"");
		
		output("\n\nShe titters a bit as if this situation doesn't seem to be bothering her much at all.  \"<i>Well, I guess my adventure could have ended worse, right?</i>\" she shrugs her shoulders, jiggling her milky quad breasts in the process.  \"<i>I mean, they take good care of me - they seem to absolutely love my sap. I think it's some kind of delicacy to them.</i>\"");
		
		output("\n\nYou can't help but stare at your leafy friend's oversized melons as she talks, but you can hardly be blamed since their heavy bulk covers most of her body.  Every word makes the chartreuse udders wobble and every laugh sends quivering shakes down the woman's evergreen form.  Eventually, you realize she's stopped talking and you can feel her bemused gaze on you. Awkwardly, you try to clear the air by asking why she doesn't just leaf, err, leave since there don't appear to be any guards.  Essy just smirks, shaking her head.  \"<i>They've taken steps to make sure I can't.</i>\"");
		
		output("\n\nShe takes several deep, heaving breaths and demonstrates by planting all four arms on the lip of her pot and attempting to rise.  Several strange runes appear and begin to glow across the surface of her ceramic prison.  Spectral, translucent hands wink into existence and go to work on the plant, rubbing, kneading and groping her massive melons.  Essrayle moans heatedly and slumps back down into the soil.  One of the hands stops working over the soft, squishy, almost doughy breast and begins to squeeze and tug at the thumb-thick, purplish teats topping her fertile tits.");
		
		output("\n\nIt doesn't take long before she begins moaning in ecstasy (a curiously bovine sound that strikes you more as a 'moo' than anything else) as her syrupy sap begins to spurt forth in a torrential spray.  The milking intensifies and Essy writhes in orgasmic throes, gurgling with submissive glee as her nectar cascades through the air like a pale amber rain.  Occasionally, as those over-inflated breasts are roughly fondled, you catch sight of a strange, bulbous red bud with a pair of puffy, green lips upon it.  The plant-girl's curious pussy gleams with a lacquer-sheen as it quivers and you realize it is absolutely soaked with her glistening juices.");
		
		output("\n\nA pair of ethereal hands deepens their kneading strokes as they pump the girl's enormous, gushing breasts, the flush of her lilac blush spreading from her cheeks all the way down to her chest. The hyacinth hue purples her green skin and brings a deep, violet blush to Essrayle's spasming nipples, her bovid moaning becoming louder, shorter, and higher pitched.  Amidst this wanton display she manages to gasp out a word now and then, trying to communicate through the suffocating haze of her lactation-induced climaxes.  It takes some time - punctuated by keening sounds of bliss, the constant torrent of fountaining milk, and gushing spray of femme-cum from the bulbous, scarlet bud between her legs - but you gather that she's explaining how too much stimulation leaves her too weak to escape her pot.");
		
		output("\n\nThe ensorcelled hands eventually fade away, allowing the plant to slump in utter exhaustion, skin shimmering with the milk-like sap she's covered herself in. The soil around her hips shifts and she slowly rouses, her breasts already refilling before your eyes. You can understand why the Sand Witches would want to keep the plant girl - the bounty of her vernal breasts seems endless! They must've planted her and gone to get help moving the leafy cow, safe in the knowledge she wouldn't be leaving on her own power any time soon.")
	
		output("\n\nThe two of you sit there and try to figure a way out of the mess she's gotten herself into, though you can't be sure if there's an ulterior motive to your lingering or not.  Talking is slow as she has to fight through lingering waves of pleasure - the ghostly hands tenderized her titanic tits so thoroughly that even a light breeze is enough to send orgasmic bliss through her loins.  Thankfully, none of the sand witches comes to investigate all the noise, though judging by the tracks on the ground around you, more than a few of them have paid Essy a social call before you found her.");
		
		output("\n\nEventually the two of you decide that maybe by defeating the head witch, the one who put this spell on her, she'll be able to leave safely.  \"<i>That w-w-would be g-g-great,</i>\" she sighs, just before another trembling aftershock sends her jiggling in blind delight, adding to the small lake of lady cum slowly filling her pot and dribbling over the lip into the grass beneath her.  You rise and begin to set off, but the heat in your own body is burning quite bright by now from this entire display.");
	}
	else {
		output("Essrayle sits here in her pot just like you left her.  She seems to be a bit out of it once more, not realizing you're there.  Her heavy breasts jiggle and ripple with the least amount of movement, apparently drawing nutrients from her soil to refill themselves.  Just watching the oblivious girl pant and swell with bovine surplus is oddly arousing, and having sampled her sap already... no wonder the sand witches keep her here.  Judging by the steady leak coming from her four breasts, it seems likely the ethereal hands have recently given her a good milking, but you're sure she wouldn't mind a more personal touch.");
	}
	//dynStats("lus", 10+pc.lib/10);
	applyDamage(new TypeCollection( { tease : 10 + pc.libido() / 10 } ), pc, pc);
	clearMenu();
	//Option: [Feed her] [leave]
	if (pc.hasGenitals()) addButton(0, "Feed Her", feedTrappedEssy);
	addButton(14, "Leave", mainGameMenu);
}

//[Feed Her]
private function feedTrappedEssy():void {
	clearOutput();
	output("Well, it's not like she's going anywhere right now, and she probably would love a good fuck from a friend anyway.");
	output("\n\nYou approach Essrayle once more, taking advantage of her dazed state to disrobe and sidle up to the enchanted flower pot before she realizes your intentions.  From this angle you can clearly see that her hands are sunk deep into the soil around her bubbly hips.  She blinks, confused by your sudden forwardness, but soon moans out loudly as your palms sink into the girl's recently massaged teats, fingers sinking deeply into the tender flesh.");
	
	IncrementFlag("COC.ESSY_DUNGEON_FUCKED");
	
	if(pc.isHerm()) {
		output("  How best to make use of this floral beauty?");
		clearMenu();
		addButton(0,"Cock",hasCockFeedEssy,true);
		addButton(1,"Pussy",hasPussyFeedEssy,true);
	}
	if(pc.hasVagina()) hasPussyFeedEssy(false);
	if(pc.hasCock()) hasCockFeedEssy(false);
}

//(Cock)
private function hasCockFeedEssy(newPage:Boolean = true):void {
	if(newPage) clearOutput();
	else output("\n\n");
	output("[pc.EachCock] stands erect as you grind it against her belly, enormous tits squishing wonderfully around it.  The udder-like melons squeeze [pc.oneCock] with every hot breath the plant girl takes, taut skin soaked with the sweat of her afterglow wetly suckling at your length.  Determined to use such productive breasts to the fullest, you move forward, your [pc.cockBiggest]'s mass easily slipping between the bottom pair, her leaking, jade pillows snugly engulfing your girth as tightly as if she were holding them together with all four arms.");
	
	output("\n\nAs pliant as her mammaries are, a little extra lubrication couldn't hurt.  Grabbing two of her puffy, fist-sized teats, you begin to squeeze and tug at them as if you were milking a cow.  Essy pants with heated, bovine moans as syrupy, white sap gushes from her spouting nipples in thick, cascading gouts.  For being used so thoroughly by the sand witches, she seems remarkably receptive to your milking, as if her body's needed a more personal touch.  Not wanting to disappoint, you tighten your wringing grip and pump even harder.");
	
	output("\n\nHer otherworldly, amethyst eyes lose their usual depth and become dull and dazed as the shadow of docility settles over her, Essy's expression softening to a blissful, cow-like contentment.  \"<i>Mooooo,</i>\" she languidly moans as her huge tits heave in oceanic jiggles.  They pulse under your siphoning caress, as if struggling to produce more sap.  While the oblivious girl seems lost in some private, torpid trance of delirious euphoria, her breasts almost appear to be swelling as if to embody her budding, enraptured exhilaration.");
	
	output("\n\nAs appealing as it may be to have the plant girl water herself to a glossy shine, you're reluctant to let her fountaining ivory go to waste.  Taking care to keep the steady pace of your pumping, you lubricate your now hard cock in the thick, syrupy \"milk.\"  Slick with the nourishing warmth of her nectar, you abandon all restraint, enjoying those verdant, pillowy, green breasts for all they're worth.  The wet sounds of squelching fill the air as you fuck ");
	if(pc.biggestCockLength() < 20) output("her lower pair of wobbling udders");
	else output("both sets of milk-bloated breasts");
	output(" faster and faster, the hot slapping of her bountiful bosom against your [pc.cock]");
	if(pc.balls > 0) output(" and your swollen, heavy balls against her fecund belly");
	output(" setting an inspiring drum beat to your feverish pace.");

	output("\n\nIt doesn't take long before the gushing, milky embrace of Essy's flowering breasts coaxes you to paint the green girl's emerald flesh white with your ivory seed.  As you cum, her shuddering udders seem to experience their own release, massive teats bulging between your fingers as they swell with a tremendous, liquid weight.  Then, in a strangely synchronized discharge, surging gouts of milky sap shower out in pressured geysers that rain down around the two of you in a sticky deluge of rich passion.  The floor teems with sprouting undergrowth while the plant girl's shapely ass jiggles with orgasmic delight as the soil she's planted in turns a deep black, instantly enriched by her fertile cream.");
	
	output("\n\nExhausted anew, Essy reclines in her pot, already dozing with an expression of happy contentment.  Though she's still imprisoned, you've at least set her at ease.  While you might like to move her somewhere more private, the sheer weight of her pot is more than enough to frustrate any attempt you might make.  Best to just leave her and check in later.");
	pc.orgasm();
	doNext(mainGameMenu);
}

private function hasPussyFeedEssy(newPage:Boolean = true):void {
	if(newPage) clearOutput();
	else output("\n\n");
	output("Repositioning one of Essy's massive tits, you opt to try something new, something different.  Essy's long, fat nipples glisten with plump promise as you climb up, over the lip of her ensorcelled flowerpot.  The soil is soft and moist with her milk as you gently push her back, leaning the girl's pliant form against the bulging swell of her pronounced ass.  She reclines, woozy and unable to process what it is that you're doing as you move over her ponderous bosom.  It takes almost no effort to guide one of the pert, fist-thick nipples into your womanly folds, sliding it into your [pc.vagina] with ");
	if(pc.looseness() < 2) output("a gasping grunt of effort");
	else if(pc.looseness() < 4) output("little resistance");
	else output("virtually no resistance at all");
	output(".  With some effort, you take the plant girl's peak to its leaf-green hilt, the soft skin of her pliant breast squeezed against your [pc.hips], teat-like nipple a pulsing cock-like shaft inside your [pc.vagina].");
	
	output("\n\nEssrayle, squeaking at the sensation of your clenching loins, begins to ask what you're doing, but the moment your inner muscles tighten around her nipple, coherent speech falls by the wayside.  Slowly, you rock back and forth against her mammary, savoring the feel of her bulging udder against your loins while grinding into her supple flesh to coax the sensitive nub deeper.  Your [pc.hips] pound against her bust, the pliable pillows yielding and cushioning your insistent ardor, the taut surface bouncing you back upward with each ass-slapping buffet.  The unexpected but not unappreciated elasticity of the plant girl's mammoth milkers leaves you off-balance and grasping for something to steady yourself.  Reaching out, your palms inadvertently seize two of her unoccupied teats, clamping down so strongly that you roughly tug her fat nipples, bringing spurting sap to their taxed tips.");

	output("\n\nUp and down, back and forth you go, setting a steady rhythm and lactation and startled moos from the verdant girl as you go.  The intensity of her pleasure robs her udders of all moderation, the dairy-burdened tits letting loose heavy flows of creamy sap that ooze and spurt over the bloated swell of her milk-laden tits, dripping into the soil beneath her.  During your ride, you take note of the girl's eager, leaking nipples around you, and make a point of alternating your pumping grip to each teat in turn, squeezing splattering gouts of nectar in alabaster fountains, ensuring that the two of you are utterly soaked in her warm, rich sap.  With the squelching, moaning, flesh-slapping din the two of you are raising, it's simply amazing no one's come to check on the commotion.  Though, you suppose, the planty slut's orgasmic moos are likely to be the least weird noise in this cave.");
	
	output("\n\nYour lewd, tit-humping labor swells to a fever pitch as her over-stimulated udder plumps inside you, fattening with her blossoming lust.  The cock-like knob inside you becomes swollen with milk, ballooning longer and thicker until your suckling inner walls strain to bear the girl's bloated nipple.  Feeling the trembling clench of your orgasm building, you tighten your grip and thrust yourself as deeply as you can on the cunny-stuffing mammary.  Her breast, unable to resist your peaking squeeze, gushes with pressurized jets of fertile sap, flooding your pussy with a warmth a bit too fluid to be cum, but still thick enough to send a shiver of fulfillment down your spine.  You watch your tummy grow pudgy, then plump, and finally obese as your womb is flooded with her tingling, fertile milk.  The two of you cry out in orgasmic bliss and, positively swollen with the plant-girl's bounty, you collapsing into her very soaked cleavage, still gripping her lactating nipples.  You lay there, panting softly with her for a time, just soaking in the stimulating thrill of your ponderous belly, giving Essy's tits a tender squeeze now and then just to hear her moo with delight.");
	
	output("\n\nIt takes you a while, but you extricate yourself and clean off the best you can, leaving her with a friendly kiss on the cheek before you head on your way once more.  With visitors like you, she hardly seems like she'll mind being trapped in the enchanted flower pot.");
	pc.orgasm();
	if (pc.fertility() < 1.5) pc.fertilityRaw += 0.01;
	doNext(mainGameMenu);
}

//(After defeating the Cum Witch)
public function essyWitchVictory():void {
	clearOutput();
	output("As before, you find Essrayle in the glade, but now she appears to be freed from her restraints.  The rune-engraved flower pot is turned over, damp soil spilled out over the ground.  The plant-girl giggles as she folds her arms between both her upper and lower sets of breasts.  \"<i>I guess this means you were successful and I should show a hero some gratitude,</i>\" she coos warmly.  With a rippling of her hefty bulb, she approaches, tits bouncing and jiggling with voluptuous abundance.");
	
	output("\n\n\"<i>I've gotta say, though, I did have a lot of fun there, and I even got some awesome souvenirs out of it!</i>\"  She grins as she shakes all four breasts from side to side, their taunt green skin flush and swollen with their bulging bounty.  \"<i>I love 'em!  It was a great idea to come here!</i>\"  Again she moves her chest, somehow managing to roll her milk-inflated breasts in wide, wobbling circles.  She pauses playing with herself, perhaps remembering that she hasn't rewarded you yet, and gives a big, welcoming smile when she notices that your attention seems fixated on her out-thrust tits.");
	
	output("\n\nWith beaming delight she leans closer to you, exposing the full depth of her doubled cleavage, and puts a finger beneath your chin.  \"<i>My eyes are up here,</i>\" she remarks teasingly. \"<i>Now, how to best reward you?</i>\" She frowns in thought, idily tracing a finger about her top-left tit in circles, squishing into the yielding, almost fluid surface.  \"<i>Well, a seasoned adventurer like you would probably love some big shiny sword or magical armor or whatnot, but I don't tend to carry such things.</i>\"");
	
	output("\n\nHer fingers continue to move, sliding to that gorgeous, purple areola and dragging the tip of her thumb and index finger over the puffy nipple, back and forth, from base to tip over and over again.  \"<i>Perhaps some gems?  You guys seem to love those a lot.</i>\"  Essy's lower arms settle on her broad hips while her free upper hand rests on one of her breasts, fingers drumming idly and sending quivering ripples through her milk-filled flesh.  The simple, fluid motions are almost hypnotic and your gaze once more fixates on the plant-girl's buxom bust.");
	
	output("\n\nNoticing your drooping stare, a sly smile creeps over her lips.  \"<i>But I think I've got an idea that would make you very happy.</i>\"  Both of her upper hands go to her cleavage, pulling her fat, squishy tits apart before releasing them, letting the girl's mammary mountains slap together in quivering wobbles.  \"<i>Yes, something we could both be very happy with, that you'd truly enjoy.</i>\"  Her lower hands cup the bottoms of her lower breasts and begin to leisurely bounce them in her palms.  \"<i>After all, that's the important thing: enjoying yourself.</i>\"");
	
	output("\n\n\"<i>Now, I may be a visitor to this world, but I've learned some things.</i>\"  She grins and crosses her other two arms atop those jiggling, swaying, lush beauties.  \"<i>Since you seem to like these four so much, perhaps you'd like to join the club?</i>\"  Essrayle winks coyly, \"<i>How about it?</i>\"");
	flags["COC.ESSRAYLE_ESCAPED_DUNGEON"] = 1;
	flags["COC.ESSY_IN_DUNGEON"] = 0;
	clearMenu();
	addButton(0,"Yes",acceptEssyPrizes);
	addButton(1,"No",declineEssyPrizes);
}

//[No]
private function declineEssyPrizes():void {
	clearOutput();
	output("Essy sighs and shakes her head.  \"<i>What a let down!</i>\"  She shrugs, throwing all four arms into the air helplessly, and digs about in the pouch she keeps on her vine belt.  \"<i>Here, hope this tickles your fancy.</i>\"  She reaches out and places a number of glittering gems into your hand.  \"<i>They don't do me much good anyway.</i>\"");
	
	//(Player gains some more gems)
	pc.credits += 100 + rand (70);
	//statScreenRefresh();
	
	output("\n\n\"<i>Well, maybe in the future you'll change your mind and find another way to do it on your own.  But I guess for now I'll just see you around!  Thanks for the save, hun!</i>\"  The planty beauty blows you a kiss before she heads off, bulging breasts jiggling and bouncing steadily all the way.");
	doNext(mainGameMenu);
}

//[Yes]
private function acceptEssyPrizes():void {
	clearOutput();
	output("Essrayle beams.  \"<i>That's what I thought!  You know a good thing when you see it!</i>\"  She takes you by the hand and guides you to sit on the side of the overturned pot.  Shuffling backwards, she pokes her leafy, green tongue out of the corner of her mouth while tapping the side of her head with a finger.  \"<i>Now... how did that go?</i>\"  She frowns in scatterbrained thought, trying to remember for a time before her expression lights up with ditzy delight once more.  \"<i>Oh, wait, I know! You stay right there, my little sprout.</i>\"");
	
	output("\n\nShe hurries out of the glade, a rather impressive feat for one with such an over-burdened bust, much less a bulb for legs!  Just as you're getting bored, she finally returns, bouncing into sight with a giddy air.  \"<i>Sorry!</i>\" she giggles, licking some pale, creamy fluid from her lips, \"<i>I had to do a bit of negotiation.</i>\"  She settles back next to you once more and produces a small scroll, opening it up and chanting in the tongue of the sand witches.");
	
	output("\n\n\"<i>Ytnuob ruoy htiw sdnas eht doolf. Edit yklim eht wolf tel!</i>\"");
			   
	output("\n\nYou feel a sweltering heat fall over you. With a sudden urge you thrust your chest out as ");
	if(pc.biggestTitSize() <= 1) {
		output("four bulging tits erupt from your chest");
		pc.breastRows[0].breastRatingRaw = 4;
		if(pc.bRows() == 1) pc.createBreastRow();
		pc.breastRows[1].breastRatingRaw = 4;
	}
	//if two breasts:
	else if(pc.bRows() == 1) {
		output("two more bulging tits erupt from your chest");
		if(pc.breastRows[0].breastRatingRaw < 4) {
			output(" while your top row expands");
			pc.breastRows[0].breastRatingRaw = 4;
		}
		if(pc.bRows() == 1) pc.createBreastRow();
		pc.breastRows[1].breastRatingRaw = pc.breastRows[0].breastRatingRaw;
	}
	//if four+ breasts: 
	else {
		output("your [pc.fullChest] swell larger and larger under the expanding magic of the spell");
		Mutator.growTits(pc, 6, pc.bRows(), false, 2);
	}
	pc.boostLactation(pc.bRows());
	output(", filling with warm, fluid weight.  They jiggle and wobble against each other and your belly as they adjust to their brimming plumpness.  You now proudly sport [pc.fullChest].");

	output("\n\nGrinning, Essrayle nods happily, rolling the scroll back up.  \"<i>Yes, that looks veeerry good on you!</i>\”  She ogles your chest for a while before glancing down at her own.  \"<i>But I think I could do you one better, since you've been so sweet to me,</i>\" the all-natural beauty coos happily.  \"<i>As a special bonus to you, how'd you like to have these too?</i>\" she moos, running her finger about her four, plump nipples, giving you a seductive smile.");
	//dynStats("lus", 10);
	pc.lust(10);
	clearMenu();
	addButton(0,"Yes",yesGimmeGiantNipplesEssy);
	addButton(1,"No",noGimmeGiantNipplesEssy);
}

//[Yes]
private function yesGimmeGiantNipplesEssy():void {
	clearOutput();
	output("She smiles knowingly and, reaching into her pouch once more, Essy produces a strange looking fruit.  It seems almost like a plum-colored eggplant, but it feels soft and rubbery to the touch.  \"<i>Here ya go!  Whenever you'd like, enjoy this!</i>\"  She places the strange thing in your hands.  \"<i>Call it my gift to another chest connoisseur.</i>\"");
	
	essyRewardEpilogueOUTTIES();
	//[gain purple fruit] [Next]
	//inventory.takeItem(consumables.PRFRUIT, returnToCampUseOneHour);
	pc.nipplesPerBreast = 4;
	pc.nippleWidthRatio = 3;
	doNext(returnToCampUseOneHour);
}

//[No]
private function noGimmeGiantNipplesEssy():void {
	clearOutput();
	output("She shrugs her shoulders, giving one bundle of milk-drooling nipples a soft squeeze.  \"<i>Eh, to each their own, I suppose.</i>\"");
	essyRewardEpilogueOUTTIES();
}

//[Either choice]
private function essyRewardEpilogueOUTTIES():void {
	output("\n\nAbruptly, she pushes in and kisses you deeply, shoving her moist, leafy tongue deep into your mouth.");
	output("\n\nThe passionate kiss goes on for a while before she releases it, sticky strands of saliva still clinging to both of your mouths.  Separating, she leans back and puffs herself out once more, smiling to you.  \"<i>Do enjoy yourself a bit, Hero.  Here's hoping we meet again.</i>\"  She places the back of her hand conspiratorially against the side of her mouth and lowers her voice.  \"<i>After you get a chance to enjoy your improved chest a bit, I'd love to get my shot at playing with those lovely melons!</i>\"");
	output("\n\nWith a shameless giggle, she kisses the peak of one of your breasts while groping the one next to it.  \"<i>Mmm, yes, I'd ravish them hard and drain you dry right now, but out of respect I'll let you have the first crack at it.</i>\"  With a dainty wave, she shuffles towards the exit and is gone once more.\n\n");
	//[End Encounter]
	doNext(mainGameMenu);
}

public function askMotherToReleaseEssy():void {
	clearOutput();
	if(flags["COC.SAND_WITCHES_COWED"] != 1) {
		output("You point out that the witches have a friend of yours trapped here with magic and you'd like her released.");
		output("\n\nThe Sand Mother cocks her head to the side before understanding dawns on her luminescent eyes.  \"<i>The plant-woman?  She seeks pleasure like a demon, yet lacks the corruption we would expect.  I can give the order to turn her loose, but see her out, and should she return, I cannot promise her freedom again.</i>\"");
		output("\n\nThat'll have to do.");
	}
	else {
		output("You command the Sand Mother to release your friend, Essrayle from her magical bondage.  The sorcerous queen looks about to protest, but after a brief pause, she admits, \"<i>Fine, I'll see her released.  You can go pick her up.</i>\"  She practically spits the last sentence.");
		output("\n\nThat'll do.");
	}
	flags["COC.TOLD_MOTHER_TO_RELEASE_ESSY"] = 1;
	processTime(5);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

