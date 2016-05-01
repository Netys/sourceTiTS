import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Apparel.*;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//-----------------
//-- TAILOR SHOPPE
//-----------------

public function showVictoria():void {
	userInterface.showName("\nVICTORIA");
}

public function tailorShoppe():void {
	clearOutput();
	showVictoria();
	output("The inside of the tailor's shop is far cleaner than anything else you've seen in the city.  The walls are painted muted gray, and the floor is carpeted with a sprawling, royal blue rug.  After glancing around, you realize WHY the walls and floor are so muted – the quiet backdrop makes the merchandise look even more amazing.  There are racks and racks of clothing, but much of it is plain comfortable clothing, and not worth spending much time investigating.  A high-pitched voice pipes up, \"<i>Can I help you?</i>\"\n\n");
	if(IncrementFlag("COC.VICTORIA_MET") == 1) {
		output("You turn around, ");
		if(pc.tallness > 60) output("looking for the source, eventually looking down and at a short but busty Corgi dog-girl.  ");
		else output("coming face to face with a busty Corgi dog-girl.  ");
		output("She's clearly the tailor judging by her stylish, low-cut clothing and poofy hat.  A monocle perches on her nose, giving her a rather distinguished appearance.  The fashionable wench arches her back, showing off what she's got as she introduces herself, \"<i>Ello love, welcome to my shop.  My name's Victoria, though if you like, you can call me Vicky.  You'll find my clothing to be a cut above the rubbish sold elsewhere.</i>\"");
	}
	else {
		output("You turn around to look ");
		if(pc.tallness > 60) output("down ");
		output("at Victoria the Corgi Tailor.  As usual, she's dressed in a stylish low-cut dress and sporting her feathery hat.");
	}
	
	clearMenu();
	addButton(0, "Buy", victoriaShopList);
	addButton(1, "Flirt", flirtWithVictoria);
	addButton(14, "Leave", telAdreMenu);
}

private function victoriaShopList():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Victoria";
	shopkeep.keeperBuy = "<i>Ello love, welcome to my shop.  My name's Victoria, though if you like, you can call me Vicky.  You'll find my clothing to be a cut above the rubbish sold elsewhere.</i>\n\n";
	shopkeep.sellMarkup = 1.0;
	shopkeep.buyMarkdown = .5;
	shopkeep.typesBought = [GLOBAL.UPPER_UNDERGARMENT, GLOBAL.LOWER_UNDERGARMENT, GLOBAL.CLOTHING];
	shopkeep.inventory = [new CoCSuitclothes(), new CoCRubberClothes(), new CoCAdvClth(), new CoCTubeTop(), new CoCOveralls(), new CoCLongDress(), new CoCTransparentBodysuit(), new CoCModestRobes(), new CoCLthrPnt(), new CoCBimboSkirt(),
	new CoCBra(), new CoCPanties(), new CoCLoincloth(), new CoCFurLoin(), new CoCGarters(), new CoCLatexBra(), new CoCLatexShorts(), new CoCLatexThong()];
	shopkeepBackFunctor = tailorShoppe;
	buyItem();
}

//[Flirt]
private function flirtWithVictoria():void {
	clearOutput();
	showVictoria();
	var x:Number = pc.cockThatFits(cockVolume(70));
	//if(x < 0) x = pc.smallestCockIndex();
	output("You take the clothes from her and give them a look over.  Setting them on the counter, you tell her that they're quite nice, but if she's interested you might have something that could fit her quite nicely as well in the back.");

	if(x < 0) {
		output("\n\nVictoria smirks and answers, \"<i>I measured your inseam, and what you're packing in there won't fit anywhere in a girl like me.  Maybe some other time, " + pc.mf("studmuffin", "sweet thing") + ".  Did you actually want to buy something?</i>\"\n\nDo you still want to buy something?");
		addButton(0, "Next", tailorShoppe);
		return;
	}
	
	output("\n\nIt takes her a moment to realize just what it is you're suggesting before her face splits into a wide grin.  <i>\"That right?  Well now, you can't say things like that without backin' 'em up, can you?\"</i>  she says with a low chuckle, pressing her curvy body into you.  <i>\"What do you say I close the shop up quick, and you can show me just 'ow nicely you can fit, mm?\"</i>");

	output("\n\nGiving your [pc.butt] a squeeze, she hops off to turn the shop's open sign around and locks the door before closing all of the curtains.  Turning back to you, she pushes her ample cleavage up into ");
	if(pc.tallness >= 65)
		output("your [pc.stomach].");
	else if(pc.tallness >= 55)
		output("your [pc.chest].");
	else
		output("your [pc.face].");
	output("  <i>\"Now then,  let's see what you've got!");
	if (!pc.isCrotchExposed()) output("\"</i>  With practiced ease she works the bottom of your [pc.gear] off, revealing [pc.eachCock].< i >\"");
	output(" Well, well. Looks like I was right about you from the start,\" </i> she says, licking her lips again.  <i>\"Just a taste first, I think...\"</i > Sticking her tongue out once more, she gives your rapidly stiffening cock a long, slow lick from the [pc.base " + x + "] up to the tip.  She closes her mouth just around your [pc.cock " + x + "], giving it a few rapid licks before pulling off with a pop.");

	output("\n\n<i>\"Oh yes,  I think you'll do rather nicely.  In fact, I think I'm going to give you a special treat.\"</i>  Smirking up at you, the busty dog-girl unbuttons her top just beneath her ample chest.  Before you can puzzle out what it is she's doing, she takes your [pc.cock " + x + "] and stuffs it into the hole and up through her cleavage");
	if(pc.cocks[x].cLength() >= 5)
		output(" until the tip is poking out the top");
	output(".");
	if(pc.cocks[x].thickness() > 3)
		output("  Her face scrunches up uncomfortably for a moment, your girth straining the seams of her shirt.  With a series of loud pops, her buttons all go flying in different directions, letting her ample, creamy flesh bounce free with a bountiful jiggle.  <i>\"Bloody hell, that was my favorite top...\"</i> she whines for a moment before squeezing her chest back together with her hands.");
	else output("  She presses her arms inward to increase the pressure on your cock even further, and gives you another wide smile.  <i>\"Ready for this, love?\"</i>");

	output("\n\nShe begins to slowly move her disproportionately massive chest up and down your cock, ");
	if(pc.cocks[x].cLength() > 5)
		output("making sure to give the [pc.cockHead " + x + "] a quick suck every time it breaches her mounds.");
	else
		output("pressing her mouth down into her ample cleavage so as to give your hidden tip a quick lick every time it draws near.");

	output("\n\n<i>\"Hvvng fnn?\"</i>  she asks, pausing her pillowy assault to lick over the end of your pecker once again.  You can only moan in response from the wonderful wet, squishy feeling washing over your sensitive organ.  <i>\"That's what I thought,\"</i> she says, releasing you with a wet pop.");

	output("\n\nVicky continues her marshmallowy assault for what feels like hours, slowing down every time you give even the slightest indication that you're about to cum.  <i>\"You might hate me for this now, love, but trust me.  It'll feel so much better once you finally do cum.\"</i>  She may be right, but it's agony to get so close to orgasm only to back away, and then draw close once more.  She's practically driving you crazy with lust with her tantalizingly slow tit-fuck.  As you feel your [pc.cumNoun] nearly boiling away in your [pc.balls], only to have her back away once again, something inside of you snaps.");

	output("\n\nYou wrench your dick free of the confines of her pillowy mounds, and grab her around her plush middle.  She gives a surprised yelp as you nearly throw her against the counter and lift her butt up into the air.  <i>\"Ooooh, someone's excited!\"</i>  she nearly cheers, looking over her shoulder and wagging her plush rear up at you as her tail swishes back and forth, showing that she's nearly as consumed with lust as you are.  Flipping her long skirt up over her back, you violently pull her panties aside before you force your [pc.cock " + x + "] deep within her gushing folds.");

	output("\n\nShe squeals in surprise and pleasure as she's penetrated, thrusting her ample hips back at you as you begin to pound into her.  Her ass jiggles violently with every thrust, sending ripples through her creamy flesh.  You grip her around her soft middle as you slam against her hips, barely noticing every squeak she makes as her thick thighs are pounded into the side of the counter.  <i>\"Ah!  Oh, Marae, that feels incredible!\"</i>  she nearly screams as her monocle finally loses its grip on her face and goes flying, thankfully landing safely on a pile of cloth.  If you were more sound of mind, you'd probably have dreaded the cost of repairing the broken eyepiece.");

	output("\n\nSomehow, miraculously, you're able to hold back long enough to work your hands up her soft body and grip onto her enormous tits, mashing them in your hands as you find her rock-hard nipples.  She seems to be enjoying the rough treatment - quite a bit in fact - as the moment you give her hard nubs a quick tweak you feel her already rather tight pussy clamp down on your [pc.cock " + x + "] HARD.  It becomes nearly impossible to move as she cums explosively, screaming incoherently as she sprays your lower body with her liquid pleasure.");

	output("\n\nThe sudden resistance is all it takes to finally bring you over the edge, as with a loud roar of your own, you bury yourself deep inside of her still tightly clutching cunt and release.  ");
	
	if(pc.cumQ() < 25)
		output("It would seem that what she said earlier was correct.  Your pent-up need surges up through your [pc.cock " + x + "], firing your fertile seed straight into her unprotected womb.  She lets out a submissive whimper as your spurting dick triggers aftershocks within her exhausted body.  At last, her body relaxes, freeing your softening dick.  ");
	else if(pc.cumQ() < 100)
		output("Thick, sticky, ropes of your [pc.cumNoun] fire deep within her grasping pussy, attempting to extinguish the fire you lit within her with your frantic rutting.  She whimpers beneath you as your ejaculation sends another wave of pleasure through her body, which clamps down even harder onto you than before.  Thankfully, it's not long before she releases you once again, going limp on the counter and breathing raggedly.  ");
	else if(pc.cumQ() < 500)
		output("Your urethra distends as it funnels your [pc.cumVisc], potent [pc.cumNoun] into the tightly gripping walls of Victoria's pussy.  She clenches down as the [pc.cumColor] torrent sends her into yet another orgasm, shuddering beneath you as her already thick stomach begins to distend with its load.  Her pussy continues to milk your dick of its load even as she rides the high of her last orgasm, her body desperate to draw out more of your [pc.cumVisc] [pc.cumNoun].  Finally she releases you, your softening dick forced back out with a thick stream of your jizz, which begins to pool out onto the floor.  ");
	else if(pc.cumQ() < 1500)
		output("You feel your [pc.cock " + x + "] swell as it nearly explodes within her, pouring thick streams of your [pc.cumNoun] deep into her fertile womb.  She lets out another loud squeal as her body clenches down into yet another orgasm, gripping your dick tighter than you ever thought possible as it tries to milk you for all you have.  Her plush stomach visibly distends with its contents as you dump your load within her, lifting her small body up from the surface of the counter somewhat.  Thankfully, her body soon relaxes, releasing your softening prick, which is followed by a thick, [pc.cumColor] fountain of jizz that soaks your [pc.legs] and pools out onto the floor.  ");
	else {
		output("You groan loudly as your [pc.cock " + x + "] pours gallon after gallon of [pc.cumNoun] deep into her spasming pussy.  She screams as another powerful orgasm wracks her body, triggered by the enormous amount of jizz you're shooting into her.  Her belly audibly sloshes with each of her movements as it continues to expand from the enormous amount of fluid you're pumping into her.  ");
		if (silly)
			output("She attempts to clutch down on you as tightly as she can, trying to retain your enormous load; but the moment she releases even a little bit, she shoots forward from the enormous pressure of jizz within her, flopping down face-first onto some clothes on the other side of the counter.  Your [pc.cumVisc] [pc.cumNoun] continues to shoot up from between her limp legs, almost like a fountain, before gravity pulls it back down and it splatters all over the interior of the store.");
		else 
			output("Thick streams of your [pc.cum] shoot out all around your dick as she continues to squeeze down on you, trying to keep as much of it inside her massively pregnant-looking belly as possible before she finally releases, squirting your dick back out of her with a pop, followed by a veritable geyser of [pc.cumColor]. Your entire lower body is painted [pc.cumColor] as it gushes out, soaking into your clothes and covering the floor as she visibly deflates.");
	}

	output("\n\nFinally, your strength gives out and you fall backwards onto the floor, exhausted.  A few seconds later, Vicky slips backward off of the counter and lands on top of you.  Like you, she's completely unable to move, however unlike you it's more because she is completely insensate.  Her eyes have rolled back into her head and her tongue hangs out as she occasionally mutters something incoherent.");

	output("\n\nA few seconds later your body finally gives out completely and you pass out.  You wake up about an hour later, still on the floor with Vicky on the ground near you, leaning up against the counter with her legs splayed, [pc.cum] still dripping from her used pussy.  <i>\"I uh... s'pose you wanna leave now?\"</i>  She asks, still sounding a bit loopy.  She climbs unsteadily to her feet, and walks, a bit bowlegged to the door, unlocking it before slumping back down the wall.  <i>\"Do come back for a visit, love!\"</i>  You pull your pants back up and crawl back out into the street.  Climbing back to your [pc.feet], you notice a few passersby chuckling at you before you close the door.  Before you leave, you think you can make out Victoria muttering, <i>\"Gonna have to clean this place up...\"</i>");

	//dynStats("sen", -1);
	processTime(45 + rand(5));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}