import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCFishFillet;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Just want to do a quick Ottergirl event submission after you mentioned it!
public function calluSceneOttahGirl():void
{
	clearOutput();
	//output(images.showImage("callu-intro"));
	//First Time
	if (flags["COC.MET_OTTERGIRL"] == undefined) {
		flags["COC.MET_OTTERGIRL"] = 0;
		output("Your exploration of the lakeside takes you further than you've gone before.  The water here is almost completely still, its waters ");
		if (!flags["COC.FACTORY_SHUTDOWN"] == 1) output("crystal clear, giving you a stunning view of the lakebed");
		else output("only slightly clouded, giving you an obscured view of the lakebed");
		output(".  Fish dart to and fro within the waters, caring little for your explorations above the waves.");

		output("\n\nYou watch the fish for a few minutes until you notice that you're not alone on the shoreline. Further down the sandy beaches sits a solitary, feminine figure, her legs parted and arched.  A fishing rod is held lazily in her hands.  You trace the fishing line with your eyes, seeing a little piece of flotsam bobbing up and down a fair distance into the water.");

		output("\n\nYou decide to approach this figure, who notices your advance. You spot her subtly shift her position, as though she's readying her body to bolt if you turn out to be hostile.  But still, she lets you approach.  The closer you get, the more of her features you can make out.  Her skin appears to be covered with damp, brown fur.  A long, thick tail sticks out from behind her, at least as wide-around as her leg, narrowing down into a rounded tip.  A short mop of sun bleached blonde hair, barely reaching down to her chin, frames a human-like face with a cute, upturned button nose. Her body, which is lithe and toned like that of a champion swimmer, is covered only by a two-piece bikini.  Her chest is surprisingly small, perhaps only A-cups, though she looks physically mature.  Identifying this person as an otter-girl, you'd guess larger breasts would make it harder to swim.");

		output("\n\nYou stop a few feet away from her. She gives you a friendly smile.  \"<i>Well hey there, friend. You don't smell like one of them demon fellers,</i>\" she says with a light accent, reminding you of the farmers' daughters back in Ingnam. Her eyes travel up and down your body.  \"<i>So,</i>\" she says cheerfully, \"<i>you wanna fish'n'fuck?</i>\"");

		output("\n\nYou can't help your eyebrow from quirking upwards.  What did she say?");

		output("\n\n\"<i>Fish'n'fuck,</i>\" she replies, simply.  \"<i>I fish, you fuck. Ya ain't dense, are you " + pc.mf("boy", "girl") + "?</i>\"");

		output("\n\nThat's it?  She doesn't even know you and she's just offering it up like that?");
		//Silly Mode:
		if (silly) output("  No tragic backstory to go through? No annoying combat encounter? Just meet and fuck?  My god, what has this world come to?");
		output("  You don't even know her name!");

		output("\n\n\"<i>Name's Callu.  Don't worry darlin', I don't plan on stickin' nothin' where it don't belong,</i>\" her soft voice chimes, \"<i>Unlike damn near everything else around here.</i>\"");

		output("\n\nWell, how about it?");

		//[Facesitting] [Fuck Her] [Skedaddle]
	}
	//Repeats
	else {
		output("Your explorations of the lake lead you back to Callu, the otter girl. She sits lazily on the beach; fishing rod in hand, as usual. She gives a friendly wave as you approach, and pats the sandy patch of lakeside next to her.");
		output("\n\n\"<i>Well ain't you a sight for sore eyes.</i>\"  You sit down next to her and relax, just sitting and watching the makeshift bobber tip and sway in the water.  \"<i>You up for a fish'n'fuck then?</i>\" she asks suddenly, brushing a strand of her sun bleached blonde hair out of her face.");

		output("\n\nWell, are you?");


		//[Facesitting] [Fuck Her] [Fish] [Skedaddle]
	}
	flags["COC.MET_OTTERGIRL"]++;
	clearMenu();
	if (pc.lust() < 33) output("\n\nYou aren't aroused enough to fuck her.");
	else {
		//(If cocksize above 48")
		if (pc.hasCock()) {
			if (pc.shortestCockLength() > 48) {
				output("\n\nUnfortunately, you don't think she can quite handle your cock.");
				addDisabledButton(0, "Fuck Her", "Fuck Her", "Your cock is too long even for her.");
			}
			else addButton(0, "Fuck Her", ottergirlLikesDongs);
		}
		if (pc.hasVagina() || !pc.hasCock()) addButton(1, "Facesitting", ottersForGals);
	}
	if (flags["COC.MET_OTTERGIRL"] > 1) addButton(2, "Get Fish", getSomeFishYaFatty);
	addButton(14, "Leave", avoidZeOtterPussy);
}

//For Dicks
private function ottergirlLikesDongs():void
{
	clearOutput();
	//output(images.showImage("callu-sex-fuck"));
	output("The moment you agree, a sly smile spreads across her face.  She jams the end of her fishing pole into the sand like a post, to prevent it from going anywhere, and stands up.  There's no tease, no ceremony as she strips out of her bikini bottoms and tosses them aside.  Her newly revealed mound has only the barest tuft of pubic hair, a little wisp of blonde hair amongst the sparse brown fur.");

	output("\n\nYou move forward, intent on groping Callu's little breasts still hidden beneath the bikini top, but she holds up a hand and says, \"<i>Whoa there darlin', that ain't how a fish'n'fuck works.  You just lay down, and I'll take care of everything. And make sure you're as naked as a newborn babe.</i>\"");

	output("\n\nStrange, but you oblige, stripping off your [pc.gear]. Callu instructs you to lay down on the beach next to her fishing pole, which you likewise oblige.  The otter-girl straddles your stomach, facing away from you, though her thick, heavy tail is thankfully kept away from your face.");
	
	var x:int = pc.cockThatFits(48, "length");

	//(Under 6")
	if (pc.cocks[x].cLength() < 6) output("\n\n\"<i>Well butter my buns and call me a biscuit, ain't this a cute little thing,</i>\" she remarks, inspecting your tiny cock.  \"<i>I ain't never seen one this small.  I just wanna wrap it up in a little bow and cuddle with it.  You sure it ain't a clit, darlin'?</i>\"");
	//(6"-10")
	else if (pc.cocks[x].cLength() < 10) output("\n\n\"<i>Just packin' the average model, eh?  Nothin' wrong with that,</i>\" she remarks while inspecting your cock.");
	//(10"-24")
	else if (pc.cocks[x].cLength() < 24) output("\n\n\"<i>Oh my, now that's a manly piece of meat right there,</i>\" she remarks, inspecting your oversized cock.  \"<i>I could enjoy that bad boy all day.</i>\"");
	//(24"-48")
	else output("\n\n\"<i>Whoa nellie,</i>\" she says, her eyes going wide as they feast upon your giant cock.  \"<i>That.  That right there, darlin', is one grade-A trouser snake.  I've seen centaurs that'd look like geldings next to you.</i>\"");
	output("  She leisurely stretches out across your stomach and chest, letting her cunt come to rest right in front of your face.");

	output("\n\nYou feel slender but powerful fingers wrap around your cock, followed shortly after by a pair of lips. They encircle your [pc.cockHead " + x + "] and suck, creating a delightful tingling sensation that travels down your cock and into your core.");

	output("\n\n\"<i>Hey darlin', better get to lickin', we want this ");
	//{(lil dicks)
	if (pc.cocks[x].cLength() < 6) output("little, wanna-be cock");
	else output("bad boy");
	output(" to slip right in, don't we?</i>\"  Callu murrs back at you.  You most certainly do, so you lean your head forward ever-so-slightly, extending your tongue and lapping at her delicate pussy lips.  In no time at all they become puffy and flushed, blossoming outwards like a perverse flower.  You run your tongue up and down each and every fold, occasionally stopping to flick over her rapidly hardening clitoris.");

	output("\n\nLikewise, her tongue and lips dance over your [pc.cock " + x + "] like a trio of dancers. They spin, twist, hop and tease, ensuring that no inch is left untouched.");
	output("  She pays particularly close attention ");


	//[equine]
	if (pc.hasCockFlag(GLOBAL.FLAG_FLARED,x)) output("to your flare, sucking, teasing and ");
	//[canine]
	else if (pc.hasKnot(x)) output("to the base of your cock, planting sloppy kisses on your knot, ");
	//[demonic]
	else if (pc.hasCockFlag(GLOBAL.FLAG_NUBBY,x)) output("to the nubs ringing your cock, ");
	//[anemone]
	else if (pc.cocks[x].cType == GLOBAL.TYPE_ANEMONE) output("to the little wriggling tentacles ringing the head and base of your cock, ");
	else output("to the sensitive little spot on the underside of the head, ");
	output("lavishing it with attention.  Precum and saliva practically pour down the length of your shaft, tickling your ");
	if (pc.balls > 0 && pc.hasVagina()) output("balls and cunt");
	else if (pc.balls > 0) output("balls");
	else if (pc.hasVagina()) output("cunt");
	else output("ass");
	output(" as they dribble down and form a small puddle between your [pc.legs].");

	output("\n\nAfter several minutes of this, Callu relinquishes her hold on your member and says, \"<i>Mm, I reckon that'll work just fine.</i>\"  She sits up and positions herself over your [pc.cock " + x + "].  Slowly she lowers herself, first taking your [pc.cockHead " + x + "].  Her cunt, slick and aroused as it is, offers no resistance despite its tightness.  Its walls pulse and quiver around you, as though the otter has complete control over it.  Inch by inch she sinks down further, ");
	//(dicks 10" or less)
	if (pc.cocks[x].cLength() < 10) output("until she comes to rest on your lap");
	//(10"-24")
	else if (pc.cocks[x].cLength() < 24) output("slowly devouring your entire cock, until she finally comes to rest on your lap");
	else output("an excruciatingly long process as feet worth of hard cockmeat disappear into her snatch. There's a small moment of resistance, followed by a soft squelch and a sudden \"<i>Oooh</i>\" from Callu.  With no small amount of trepidation, you realize you've just penetrated into her womb.  You can't tell from the way she's facing, but you're certain her stomach has to be bulging outwards at this point");
	output(".");
	pc.cockChange();

	output("\n\nWith your entire ");
	if (pc.cocks[x].thickness() >= 3) output("impressive ");
	output("girth within her she settles down on your lap, stretching her legs out before retrieving her fishing rod.  \"<i>Now don't you go movin' about, darlin',</i>\" Callu says over her shoulder.  \"<i>Don't wanna go scarin' the fish away.  I'll let ya go after I catch a few good ones.</i>\"");

	output("\n\nSurprisingly, you can still feel a throbbing around your [pc.cock " + x + "], reaffirming your belief that she can somehow control the muscles buried within her abdomen.  Even as you lay stock-still on the sandy beach, you feel the sensation of thrusting, as though you were actively fucking this little slut sitting atop you.  The feeling is extremely pleasant, not to mention a little hypnotic.  You reach your hands up to grasp Callu's hips lightly.  She doesn't seem to mind, though as you start squeezing her in time with your phantom thrusts a quick swat to your hand lets you know that you're crossing an unspoken boundary.");

	output("\n\nWith nothing else to do, you close your eyes and relax.  The rhythmic pulsing of this otter-girl's tight pussy seems to deepen your relaxation, though your dick remains as hard as it's ever been. Minutes pass, and the thrusting sensation doesn't appear to be dying down.");

	output("\n\nA sudden, strange high-pitched sound suddenly rings out and your head bolts upright, only to see Callu reeling in a fish.  She looks it over, nods once to herself and tucks it away in an ice chest cleverly buried under the sand right next to the two of you.  Afterwards she stands up, letting your dick fall out of her.  Your [pc.cock " + x + "] feels strange, and uncomfortably naked somehow, especially as a cool wind blows over its saliva and femcum-covered skin.");

	output("\n\nIt doesn't have to suffer long, at least, as Callu casts a new line and positions herself over your cock once more. Inch by delicious inch sinks into her, making you shiver all over.  However, this time she doesn't sit all the way down.  Instead she straddles your waist, standing on the balls of her feet.  The now-familiar pulsing returns, but in addition she gyrates her hips, circling them around and around.  With each rotation it feels as though your cock is being squeezed tighter and tighter, but this time you can't simply relax and close your eyes, not with that captivating bubble butt swaying in front of your face.");

	output("\n\nHer rear swings and swivels, spins and pirouettes, but the entire time her focus on the fishing line remains constant.  It's as if you're a side-note to her day; as though sex like this, with such mind-blowing sensations, was an everyday occurrence.  The movement of her hips intensifies, as does the pulsing within that sweet, hot snatch.  In no time at all your vision begins to go hazy, your body tensing as it's wracked with pleasurable, orgasmic electricity.");

	output("\n\nYour body arches, thrusting your cock fully inside Callu, your hips meeting with a lewd, wet smack.  Your cock jerks, spurting jet after jet of seed into the otter-girl's greedy cunt.");
	//(Cum quantity high enough)
	if (pc.cumQ() >= 250) {
		output("  There's so much of it, ");
		if (pc.cumQ() < 500) output("some of it begins to dribble down your cock, forming a puddle right under your ass cheeks");
		else if (pc.cumQ() < 1000) output("it begins to spray out of the edges of your cock, like water coming out of a blocked faucet");
		else if (pc.cumQ() < 2000) output("Callu's stomach begins to visibly inflate, even from your point of view");
		else output("Callu's stomach inflates to a huge degree. She suddenly looks to be about eight months pregnant, though she doesn't seem bothered by this in the least");
		output(".");
	}
	output("  Her womb greedily takes everything it can, until you fall back onto the ground, exhausted.");

	output("\n\nTo your surprise, Callu simply picks up where she left off");
	if (pc.cumQ() >= 2000) output(", despite the huge belly she now sports");
	output(".  Gyrations, thrusts and the constant cadence of her cunt work together to keep you unbearably hard.  Apparently she's not satisfied.");

	output("\n\nIt takes at least three more orgasms and seven caught fish before Callu relaxes; securing her fishing rod and setting it aside.  She lays backwards, pressing her back into your stomach and chest, and swivels her head to kiss you on the lips.  \"<i>Mmmm, you're such a good sport darlin',</i>\" she murrs, still clenching down on your cock.  \"<i>I ain't never had a fish'n'fuck like you before.</i>\"  The fisherwoman moves to stand up, and ");
	if (pc.hasKnot(x)) output("fails, held fast by the knot tying the two of you together. She looks at you in surprise, but eventually smiles and leans back down. The two of you cuddle for half an hour, until your knot deflates enough to let her *pop* off of it. She stands and ");
	output("slips her bikini bottoms into a canvas bag.");

	output("\n\nFrom the same bag she pulls out a delicious smelling piece of cooked fish, wrapped in a large green leaf.  She hands it to you, saying simply, \"<i>Fish and a fuck, darlin'.  I got mine and you get yours.</i>\"  You nod absently, taking the piece of wrapped fish.  Callu gives your rapidly limpening cock a little pat on the head, before gathering up her things and heading off down the beach, leaving behind a trail of cum and other love juices.");

	output("\n\nYou take a minute to recover before doing the same.  ");
	pc.orgasm();
	//dynStats("sen", -1);
	
	processTime(20 + rand(10));
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCFishFillet()]);
}

//For Chicks
private function ottersForGals():void
{
	clearOutput();
	//output(images.showImage("callu-sex-facesit"));
	output("The moment you agree, a sly smile spreads across her face.  She jams the end of her fishing pole into the sand like a post, to prevent it from going anywhere, and stands up.  There's no tease, no ceremony as she strips out of her bikini bottoms and tosses them aside.  Her newly revealed mound has only the barest tuft of pubic hair, a little wisp of blonde hair amongst the sparse brown fur.");

	output("\n\nYou move forward, intent on groping Callu's little breasts still hidden beneath the bikini top, but she holds up a hand and says, \"<i>Whoa there darlin', that ain't how a fish'n'fuck works.  You just lay down, and I'll take care of everything. And make sure you're as naked as a newborn babe.</i>\"");

	output("\n\nStrange, but you oblige, stripping off your [pc.gear].  Callu instructs you to lay down on the beach next to her fishing pole, which you likewise oblige.  The otter-girl straddles your stomach, facing away from you, though her thick, heavy tail is thankfully kept away from your face.");

	output("\n\nCallu leans down, laying her body across yours so that her warm, sweet-smelling cunt is positioned just in front of your face.  Meanwhile, you feel delicate, powerful fingers probing at your [pc.vagOrAss].  A long wet tongue licks over your ");
	if (pc.hasVagina()) output("folds");
	else output("pucker");
	output(", and you feel compelled to do the same to her.  You let your tongue extend and lap at her delicate pussy lips.  In no time at all, they become puffy and flushed, blossoming outwards like a perverse flower.  You run your tongue up and down each and every fold, occasionally stopping to flick your tongue over her rapidly hardening clitoris.");

	output("\n\nLikewise, her tongue and lips dance across your flesh like a trio of dancers.  They twirl, spin, hop and tease.  Not one inch is left untouched.  From your ");
	if (pc.hasVagina()) output("clit");
	else output("unnatural bare crotch");
	output(" down to your pucker, she leaves a trail of sloppy smooches.  You mirror her movements, attempting to give her the same experience she's giving you.  A low murr escapes her lips, and she squirms above you slightly as your tongue hits the right spots.");

	output("\n\nAfter several minutes of this tasty sixty-nine Callu gives your mound one last kiss and sits up, practically burying your face in her snatch.  \"<i>Ya'll just sit tight and put that tongue to work, kay?  Key ingredient in a fish'n'fuck, is of course, the fish.</i>\"  You voice your disapproval, though all that comes out is a garbled \"<i>mmmrrrrppphh.</i>\"  Callu ignores your protests, instead retrieving her fishing pole and sitting back further, pressing herself even harder against your face.  With her fantastic behind blocking your view, you can't see anything that's going on, and are only able to hear the quiet \"<i>tick-tick</i>\" of her fishing pole.");

	output("\n\nYou know full well that you could get out of this if you wanted to, however the scent of the girl's musky mustelid muff is just too powerful, too intoxicating, too heavenly to ignore.  Instead of struggling you go to town, rubbing your face in it as you lick, slurp and suck at the lips pressed against your mouth.  Up and down your tongue goes, in and out, teasing her soft, swollen lips and pressing hard against her hard, aching clit as you gorge yourself on her pussy.");

	if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("\n\nYou extend your abnormal tongue, plunging it deep into Callu's depths. This actually elicits a little squeak from the fisherwoman, who shifts from side to side in shock.  You let your tongue push further in, as if it were a cock.  Spreading her as you delve deep, you taste the otter from the inside out, reveling in the taste of her sweet, tight hole.  Eventually your tongue comes to an obstruction, a tight ring that bars your way forward.  You grin, or at least try as hard as you can to do so, what with the weight of an otter-girl sitting on your face and all that inches of tongue sticking out of your mouth.  The tip of your tongue whirls around her cervix before finding the center and slowly pushing inside.  Another \"<i>eep</i>\" arises from Callu, though this one turns into a contented sigh.  With the tip of your tongue in her womb, you begin to slather her walls with saliva.  Every tender flick of your tongue makes the girl riding your face shiver with pleasure.  All good things must come to an end, however, and your tongue eventually gets so tired you have no choice but to draw it back in.");

	output("\n\nThis goes on for the better part of an hour.  You find yourself hunting for the little spots that make your sexy little friend jump and squeal, all while she reels in fish after fish.  Several orgasms, half a dozen fish and one extremely messy face later, you hear Callu reel in her line for the last time before setting it off to the side with a clatter.  She rises from your face, allowing you to breathe the fresh air once more.");

	output("\n\nGrinning down at you, your face plastered in girlcum, the fisherwoman leans down and gives you a great big kiss.  \"<i>Mmm, ain't that a tasty treat,</i>\" she notes.  \"<i>Now since ya been so good to me, I just wanna return the favor.</i>\"  Callu gets back in the sixty-nine position that started this all off, but grabs hold of you and flips over onto her back.");

	output("\n\nYou sit up, straddling her face this time, as she dives nose first into your ");
	if (pc.hasVagina()) output("quivering quim");
	else output("rump");
	output(".  Her lips are like magic as they go, sucking and lavishing your entire crotch with delightful attention.  You find your entire body shivering with pleasure as she attends to you, your body quickly heating up as her tongue presses all of your buttons.  Everything from your fingertips down to your toes tingles and shudders under Callu's ministrations, leaving you squirming and undulating on her face, a deeply satisfied growl rising in your throat.");

	output("\n\nGrabbing hold of your [pc.nipples], you start playing with them while Callu does her thing.  Your fingers deftly tweak and tease them, knowing all the right techniques to really get you going.  ");
	if (pc.hasFuckableNipples()) output("You even slip a finger or two inside, stretching your nipple-cunts out with deliciously pleasurable results.  ");
	output("Combined with Callu's tender tongue ");
	if (pc.hasVagina()) output("paying lip service to your wet cunt");
	else output("doing a cave dive in your rear");
	output(", you can't hold out much longer.  All the tingling in your body seems to get forced through your veins, coalescing in a single spot within your groin.  The pressure builds and builds as orgasmic energies begin overflowing.  Your [pc.legs] and arms tremble, your head wobbles uncertainly, and you can't even guess at what your spine is attempting to do.");

	output("\n\nThe pleasure within you finally bursts outwards, shooting through every nerve, inflaming every fiber of your being.  ");
	if (pc.hasVagina()) output("Your snatch clenches and clamps down on thin air, flooding Callu's face with your feminine juices in a tasty, refreshing spray.");
	else output("Your asshole clenches and spasms randomly, aching to be filled by something, anything in your quest for release.");
	output("  The orgasmic bliss makes you collapse forwards, dropping you onto all fours. However, your blonde lover grips your thighs firmly, clearly intent on fully repaying her debt.");

	output("\n\nSeveral orgasms later, you're little more than a quivering mass of flesh riding atop the fisherwoman's face.  She wriggles out from underneath you and licks her lips, happy to guzzle down the last of your juices.  Callu gives your back a little rub down, saying, \"<i>Well that sure was a refreshing break, darlin'.</i>\"  You can only groan in response, your body too sore from back-to-back orgasms to really form any kind of coherent response.");

	output("\n\nThe blonde otter sets all her gear up in one pile, and tucks away her bikini bottoms into a canvas bag.  From the same bag she pulls out a delicious smelling piece of cooked fish, wrapped in a large green leaf.  She sets it beside your still-trembling body, saying simply, \"<i>Fish and a fuck, darlin'.  I got mine and you get yours.</i>\"  You nod absently, reaching out to touch the wrapped up piece of fish.  Callu gives your back another quick rub down, before gathering up her things and heading off down the beach, completely naked from the belly down.");

	output("\n\nYou take several minutes to recover before doing the same.  ");

	pc.orgasm();
	
	processTime(20 + rand(10));
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCFishFillet()]);
}

//For Pansies
private function avoidZeOtterPussy():void
{
	clearOutput();
	output("You shake your head and explain you can't.  She simply shrugs, \"<i>Ain't no skin off my back.</i>\"");

	output("\n\nThe two of you sit in silence for a little while.  It doesn't feel like an awkward silence, just a serene, relaxing void of noise.  The gentle lapping of the water almost puts you to sleep.  Eventually, you stand, say your goodbyes and leave.  As you're leaving, Callu shouts, \"<i>Come round any time, ya hear?</i>\"  You nod absently, then make your way back to camp.");
	processTime(10 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//For Fatties
private function getSomeFishYaFatty():void
{
	clearOutput();
	output("You tell Callu you're a little more interested in the fish than the fuck, at least for today.  She shrugs once before jamming the end of her fishing pole into the sand like a post and turning towards her pack.");

	output("\n\nShe retrieves a delicious-smelling slab of roasted fish, properly salted and wrapped in a large green leaf.  \"<i>Here ya're, fresh as it comes 'less you want it still walkin' and talkin'.</i>\"");

	output("\n\nYou thank Callu for the food and take your leave.  ");

	//(You have gained Fish Fillet!)
	
	processTime(10 + rand(5));
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCFishFillet()]);
}
