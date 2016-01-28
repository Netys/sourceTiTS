import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Armor.*;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//-----------------
//-- ARMOUR SHOP
//-----------------

public function showYvonne():void {
	userInterface.showName("\nYVONNE");
}

public function TelAdreArmorShop():void {
	clearOutput();
	showYvonne();
	output("The interior of the armory is blisteringly hot, filled with intense heat from the massive forge dominating the far side of the shop.  The bellows are blowing hard as a tall german-shepherd woman works the forge.  Incredibly, she's wearing nothing aside from a ragged leather apron.  It bulges from the front, barely containing her obscene proportions as it protects them from the heat of her forge.  She pulls a piece of metal from the forge and strikes it a few times with a hammer bigger than your head, then tosses it in a bucket filled with water, steam boiling out of it from the hot metal.  At last, the sweating forgemistress notices you and turns around, her breasts jiggling wildly.\n\n");
	//output("\"<i>Vat can Yvonne make for you?  Ze platemail?  Or someting a bit lighter?</i>\" she asks you.", false);
	output("\"<i>What can I make for you?  Platemail?  Or something that breathes a little easier?</i>\" Yvonne asks, fanning herself.");
	
	clearMenu();
	addButton(0, "Buy", yvonneShopList);
	addButton(1, "Flirt", yvonneFlirt);
	
	//var egg:Function =null;
	//if(pc.hasKeyItem("Dragon Eggshell") >= 0) {
		//output("\n\nThough the pieces on display have their arguable attractions, none of them really interest you.  Yvonne taps her foot impatiently.  \"<i>Well, I could make you something to order... if you have any decent materials, cutie.  200 gems.</i>\"");
		//if(pc.gems < 200) {
			//output("\n\nYou can't afford that!");
		//}
		//else addButton(10, "Eggshell", kGAMECLASS.emberScene.getSomeStuff);
	//}
	addButton(14, "Leave", telAdreMenu);
}


private function yvonneShopList():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Yvonne";
	shopkeep.keeperBuy = "<i>What can I make for you?  Platemail?  Or something that breathes a little easier?</i>\" Yvonne asks, fanning herself.\n\n";
	shopkeep.sellMarkup = 1.0;
	shopkeep.buyMarkdown = .5;
	shopkeep.typesBought = [GLOBAL.ARMOR];
	shopkeep.inventory = [new CoCChainmailBikini(), new CoCFullChainmail(), new CoCFullPlatemail(), new CoCIndecentSteelArmor(), new CoCLeatherRobes(), new CoCScaleMail()];
	shopkeepBackFunctor = TelAdreArmorShop;
	buyItem();
}

//[Flirt]
private function yvonneFlirt():void {
	showYvonne();
	clearOutput();
	output("You step closer, glancing from her bulging, barely contained tits to her pouting lips and expressive, violet eyes.  A shock of sweat-matted auburn hair obscures part of her face, but the tall, buxom blacksmith nervously brushes it aside as she watches.  Once you're close enough to touch, you quietly and sincerely proclaim, \"<i>You're the most beautiful piece of craftsmanship in this entire store.</i>\"");
	output("\n\nYvonne steps back, and you swear you can see a blush blooming through her fur, a fiery glow of embarrassment that spreads to the upper curve of her immense mammaries.  She folds her arms over her apron, unintentionally smushing those gigantic tits closer together and deepening her cleavage into a canyon. An immense sigh causes the plush plateau to sway pendulously as Yvonne answers, \"<i>");
	pc.lust(10 + pc.libido() / 10);
	
	// Brain no want to work out the boolean logic shit here, broken out to ensure it will work as intended.
	if (pc.cockThatFits(75) == -1 || pc.tallness > 65)
	{
		output("Sorry, but you don't look like you'd be much fun.");
		output("</i>\"");
		clearMenu();
		addButton(0, "Next", TelAdreArmorShop);
		return;
	}
	
	if(IncrementFlag("COC.YVONNE_FUCK_COUNTER", false) == 0) output("Well, I could use a quick fuck.  If you meant what you said, go change the sign to say 'out' please.");
	else output("You want to go again, huh?  I do love working up a sweat...");
	output("</i>\"");
	//[Fuck] [Nevermind]
	clearMenu();
	addButton(0, "Fuck Her", fuckYvonneInZeBlacksmith);
	addButton(1, "Nevermind", backOutOfYvonneFuck);
}

//[Nevermind]
private function backOutOfYvonneFuck():void {
	showYvonne();
	clearOutput();
	output("You politely decline, not wanting to interrupt her work.  Yvonne sighs and begins to pump the bellows, muttering, \"<i>Then you'd better be buying something!</i>\"");
	clearMenu();
	addButton(0, "Next", TelAdreArmorShop);
}

//[Fuck]
private function fuckYvonneInZeBlacksmith():void {
	showYvonne();
	clearOutput();
	//X = cock that fits!
	var x:Number = pc.cockThatFits(75);
	if(x < 0) x = 0;
	output("You walk over to the door and find a sign hanging in front of the window.  The side facing indoors has 'out' on it.  There's also a 'closed' sign hanging to the side of the doorframe.  You take the simple wood plaque in hand and flip it over - can't have anybody walking in on your sexual hijinks, can you?");
	output("\n\nA fuzzy, calloused hand grabs you by the scuff of the neck, lifts you off the ground and pushes you against the wall, slamming you into it forcefully enough that some weapons hanging nearby rattle dangerously.  A hot puff of breath hits your cheek, Yvonne's wet, canine nose bumping against your [pc.ear] as she pants in your [pc.face].  She closes, and you feel her bare, sweat-soaked breasts sliding up and down your back, holding you up as firmly as her iron grip.  Yvonne's long, smooth tongue licks you from collarbone to chin, lapping up the sweat that's already starting to bead, the heat of the simmering forge-fires and your companion's well-warmed, powerful frame long since getting to you.");
	output("\n\nA distinctly feminine scent wafts up to your nostrils, intermingled with the blacksmith's own pungent body-odor, strong enough to make your head swim.  Yvonne's free hand begins removing your [pc.gear], the blacksmith's confident motions suggesting she's had plenty of experience at this.  The aroma of the super-stacked bitch's estrus increases to the point where it nearly overpowers her salty sweat-smell, her nipples pressing hard into your back.  [pc.EachCock] grows hard from the forceful attention, pinned between the wall and your [pc.belly].  Finished with your gear, Yvonne nips your neck and says, \"<i>Nice package, ");
	if (pc.cockVolume(x) < 15) output("runt");
	else if (pc.cockVolume(x) < 30) output(pc.mf("boy", "girl"));
	else if (pc.cockVolume(x) < 45) output("big " + pc.mf("boy", "girl"));
	else output(pc.mf("stud", "breeder"));
	output(".</i>\"");
	output("\n\nThe forge-mistress abruptly releases you and steps away, the supporting cushion of her breasts no longer there to help balance you.  After a moment of confused stumbling, you catch yourself and turn around, curious as to just what the buxom bitch is doing.");
	output("\n\nYvonne is on the ground on all fours.  Her tail is sticking nearly straight up, waving back and forth excitedly as she presents her curvy rump to you.  Surprisingly, her ass is much less muscular than her upper body, with a pair of pillowy buttcheeks that nearly conceal her soaked cunny from view.  You aren't sure if it's lubricant from her arousal, or sweat from working the forge all day, but Yvonne's thighs are absolutely drenched with moisture; a veritable slip n' slide of wetness that beckons you to bury your bone in the canine's feminine entrance.  She glances back over her shoulder, a submissive glint in her eyes as she begs, \"<i>Come on, be my alpha.  This bitch needs a hot, wet fuck.  Do it!</i>\"  What an odd dichotomy - one moment she's throwing you around, the next, begging to be mounted.  For all her power, it seems Yvonne still wants to be taken as a meek bitch.");
	output("\n\nYou sidle up to the large woman and begin aligning [pc.oneCock] with her mammoth buns, the sweltering, pheromone-laced stink pouring from her body making it difficult not to fall on top of her and rut.  Her huge tits are squished against the floor, squeezing out obscenely to either side of the blacksmith's lithe, muscular torso.  When you push inside, her slick wet cunt squeezes your [pc.cock " + x + "] powerfully but affectionately.  Her potent vaginal muscles work your [pc.cock " + x + "] over, tightly embracing your turgid dickflesh as you begin to fuck her properly, plowing her sweat and love-juice soaked folds even while you struggle to reach up for her incredible breasts.");
	output("\n\nYou get a handhold on the soft chest-flesh and begin to massage at what you can find, releasing appreciative moans from your partner.  Unfortunately, her furiously-wagging tail bludgeons you across the nose over and over, and you're forced to block it with one arm so that you can ream her snatch unimpeded by the woman's canine instincts.  She growls, but doesn't stop you.  You can see the muscles in her arms quivering, shaking, struggling to maintain her posture in spite of the overwhelming pleasure your [pc.cock " + x + "] is inflicting upon her poor womanhood.");
	output("\n\nA shiver runs through the dog-morph's entire body, culminating in a cock-wringing contraction that ripples through her cunt, milking you with her slippery twat.  It works, and you lean over her prostrate form as you bottom out inside her, her sweat-matted fur smearing your face with her scent as you cum.  ");
	if (pc.hasKnot(x)) {
		output("Your knot fills, locking you inside her, securely blocking any escape for the [pc.cumNoun] you're now filling her depths with.  Yvonne sighs dreamily, \"<i>Just right...</i>\" while spunk slides into her birth canal to infiltrate her womb.");
		if (pc.cumQ() > 500)
			output("  The [pc.cumColor] goop spatters into her womb with egg-inseminating force, filling her beyond her wildest expectations.");
		if (pc.cumQ() > 1000)
			output("  The blacksmith cries out in pain and pleasure, her belly rounding with your liquid, taking on a more pregnant, stuffed-silly look.");
		if (pc.cumQ() > 2000)
			output("  Thanks to your knot, not a single drop escapes, and soon Yvonne's belly is as fat as her tits, [pc.cumNoun]-bloated in the extreme, a sloshing auburn tub packed with [pc.cumColor] sperm.");
	}
	else {
		output("Your [pc.cumNoun] bubbles out to fill her depths, the spunk surging through her as it moves towards her womb.  Yvone sighs dreamily, \"<i>Ahhhh...</i>\" while you empty your [pc.balls] inside her unprotected womanhood.");
		if (pc.cumQ() > 500)
			output("  The [pc.cumColor] goop spatters into her uterus with egg-inseminating force, filling the bitch beyond her wildest expectations.");
		if (pc.cumQ() > 1000)
			output("  The blacksmith cries out in pain and pleasure, her belly rounding with your liquid, looking positively pregnant.  Her twat begins to dribble [pc.cum], creampied beyond belief.");
		if (pc.cumQ() > 2000)
			output("  Unfortunately, as your virility makes itself known, Yvonne's body hits its limit, and jets of spooge squirt from all sides of her cunny, dribbling into " + indefiniteArticle(pc.cumColor()) + " puddle on the floor.");
	}
	//still no new pg
	output("  With a thoroughly [pc.cumNoun]-stuffed twat beneath you, you ");
	if(pc.hasKnot(x)) output("pop");
	else output("pull");
	output(" out, accompanied by a exhalation of female pleasure.");
	output("\n\nYvonne staggers up on her footpaws, groaning the whole time, a trail of [pc.cumColor] [pc.cumNoun] dribbling on the floor behind her.  Her tail wags happily, and she grabs you, pulling you into her sweaty bosom as she affectionately squeezes your [pc.butt].  You aren't released until you feel dizzy, half-suffocated by her preponderance of breast-tissues and potent pheromones.");
	output("\n\nYvonne tosses you your gear, and you dress in a daze.  Before you've completely finished, she's pushing you out into the street, covered in sex-stink and stumbling over your own [pc.feet].  She calls out after you, \"<i>Thanks babe, I gotta mop this mess up!</i>\"");
	processTime(25);
	pc.orgasm();
	//dynStats("sen", -1);
	IncrementFlag("COC.YVONNE_FUCK_COUNTER");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}