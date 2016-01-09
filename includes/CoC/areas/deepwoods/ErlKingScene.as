import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCPrincessPucker;
import classes.Items.Transformatives.CoCCaninePepper;
import classes.Items.Transformatives.CoCFoxBerry;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function encounterWildHunt():void
{
	if (flags["COC.WILD_HUNT_ENCOUNTERS"] == undefined)
	{
		firstWildHuntEncounter();
	}
	else if (!pc.hasKeyItem("Golden Antlers"))
	{
		repeatWildHuntEncounter();
	}
	else
	{
		encounterPrincessGwynn();
	}
	
	flags["COC.WILD_HUNT_ENCOUNTERS"]++;
}

public function playerHuntScore():int
{
	trace("Calculating Wild Hunt score.");
	trace("Int + Spd = " + String(pc.IQ() + pc.RQ()));
	trace("Base = " + String((pc.IQ() + pc.RQ()) - (100 - pc.energy())));
	var baseVal:int = (pc.IQ() + pc.RQ()) - (100 - pc.energy());

	/*
	Conditional modifiers: +20 for Evade
			+20 for Runner
			+20 for Drider Half
			+30 Enlightened/Corrupted Ninetails
			+10 for each Akbal Blessing
			+10 Fast Perk
			+10 Incorporeality.  (Increases to +20 if player has wings)
			+10 Lunging Attacks
			-20 for Kitsune traits
			-20 for Rabbit traits
			-20 for Harpy traits
			-10 for Goo Half
			-10 for Centaur Half
	*/

	//if (pc.findPerk(PerkLib.Evade) >= 0)
	//{
		//baseVal += 20;
		//trace("+20 for Evade");
	//}
	//if (pc.findPerk(PerkLib.Runner) >= 0)
	//{
		//baseVal += 20;
		//trace("+20 for Runner");
	//}
	if (pc.isDrider())
	{
		baseVal += 20;
		trace("+20 for Drider");
	}
	if (pc.hasPerk("Enlightened Nine-tails") || pc.hasPerk("Corrupted Nine-tails"))
	{
		baseVal += 30;
		trace("+30 For Ninetails");
	}

	// Akbal Blessings
	if (pc.hasPerk("Fire Lord"))
	{
		baseVal += 10;
		trace("+10 for Firelord");
	}
	if (pc.hasPerk("Whispered"))
	{
		baseVal += 10;
		trace("+10 for Whispered");
	}

	//if (pc.findPerk(PerkLib.Fast) >= 0)
	//{
		//baseVal += 10;
		//trace("+10 for Fast");
	//}
	if (pc.hasPerk("Incorporeality"))
	{
		baseVal += 10;
		trace("+10 for Incorporeal");
	}
	if (pc.hasPerk("Controlled Breath"))
	{
		baseVal += 10;
		trace("+10 for Controlled Breath");
	}
	if (pc.canFly())
	{
		baseVal += 10;
		trace("+10 for Flight");
	}
	
	// hunter bonus
	if (pc.catScore() > 0)
	{
		baseVal += (pc.catScore() * 10);
		trace("+10 for each cat part (" + String(pc.catScore() * 10) + ")");
	}
	if (pc.dogScore() > 0)
	{
		baseVal += (pc.dogScore() * 10);
		trace("+10 for each dog part (" + String(pc.dogScore() * 10) + ")");
	}
	if (pc.hasLegFlag(GLOBAL.FLAG_PAWS))
	{
		baseVal += 10;
		trace("+10 for paws");
		if (pc.isTaur())
		{
			baseVal += 10;
			trace("+10 extra for taur with paws");
		}
	}

	// Heavy penalty for prey features. The penalty is applied PER FEATURE.
	var score:int = pc.foxScore();
	if (pc.hasTail(GLOBAL.TYPE_VULPINE) && pc.tailCount > 1) score -= pc.tailCount;
	if (score > 0)
	{
		baseVal -= (score * 20);
		trace("-20 for each fox part (-" + String(score * 20) + ")");
	}
	//if (pc.bunnyScore() > 0) 							
	//{
		//baseVal -= (pc.bunnyScore() * 20);
		//trace("-20 for each Bunny part (-" + String(pc.bunnyScore() * 20) + ")");
	//}
	//if (pc.harpyScore() > 0)
	//{
		//baseVal -= (pc.harpyScore() * 20);
		//trace("-20 for each Harpy part (-" + String(pc.harpyScore() * 20) + ")");
	//}
	if (pc.gooScore() > 0)
	{
		baseVal -= (pc.gooScore() * 10);
		trace("-10 for each Goo part (-" + String(pc.gooScore() * 10) + ")");
	}

	if (pc.isTaur() && pc.hasLegFlag(GLOBAL.FLAG_HOOVES))
	{
		baseVal -= 10
		trace("-10 for centaur");
	}

	if (baseVal < 0) baseVal = 0;
	trace("Wild Hunt Points = " + baseVal);
	
	return baseVal;
}

public function firstWildHuntEncounter():void
{
	clearOutput();
	
	output("As you explore between the tall, ancient trees, you notice a thick fog beginning to spill out from between the trees and over the mossy ground. As the haze pours forth and flows past your [pc.feet], you notice the forest around you growing distinctly darker and colder. \n\n");

	output("A shiver of unnatural fear runs up your spine, just as a hunting horn sounds from the distance.  You gasp, your breath materializing as a puff of fine, white mist.  Just as the echoes of the horn fade, a chorus of canine howls breaks through the");
	if (hours >= 4 && hours <= 10) output(" chill morning");
	else if (hours >= 11 && hours <= 13) output(" unusually cold daytime");
	else if (hours >= 14 && hours <= 17) output(" brisk afternoon");
	else if (hours >= 18 || hours < 4) output(" freezing night");
	output(" air. Your eyes twitch and ears ring at the sound of hooves pounding through the forest.\n\n");

	output("The unholy choir of horns, hounds, and hooves shake the woods around you as the fog rises, shoulder-high.  Your heart pounds - you’re not sure <b>why</b> you’re frightened, only that you <b>are</b>.  Something is out there in the darkness, and it's coming for you!  Do you flee, or stand your ground?\n\n");

	clearMenu();
	addButton(0, "Wait", firstWildHuntChase, true);
	addButton(1, "Run", firstWildHuntChase, false);
}

protected function firstWildHuntChase(waited:Boolean = false):void
{
	clearOutput();

	if (waited == false)
	{
		output("You stumble your way through the woods, but no matter which way you turn, you are greeted by bone-chilling fog.  Soon, canine snarls come from all sides.\n\n");
		output("You’re surrounded.\n\n");
	}
	else
	{
		output("The baying of hounds fills the air, and the trees echo with the distant thunder of hooves as the first of the creatures bursts through the fog.  Stooped and low, this beast-man is mostly canine, with a sharp-toothed muzzle spread wide and panting.  His red-black tongue dangles with each breath, steam rising up from his jaws.  The hound’s pelt is midnight black, covering his muscular frame.  Strong arms hang low, almost touching the ground, muscles flexing as his surprisingly human hands open and close restlessly.  His legs are distinctly dog-like, ending in wide, black-clawed paws.  Between its stocky legs; you catch a glimpse of an arm-thick sheath and a heavy sack behind.  A broad tail wags behind him, swinging slowly and menacingly");
		if (flags["COC.WHITNEY_MET"] != undefined) output(", and for a moment all you can think of are Whitney’s canine peppers");
		output(".\n\n");

		output("His baleful red eyes glare at you from beneath a dark brow.  The hound takes in a deep breath, his nostrils flaring, then throws his head back to howl.  The deafening sound is answered instantly by the crashing of brush as another beast man leaps through the undergrowth.  The fog falls to shreds as he leaps out behind you, flanking you with his fellow Hound.\n\n");

		output("To your horror, you see flashes of red as their slick shafts slide out, the air thick with heavy, panting breaths.");
		if (pc.cor() >= 40)
		{
			if (pc.hasCock() && !pc.hasVagina())
			{
				output("  You can't help but stiffen, yourself, at the sight of their eagerness.");
			}
			else if (pc.hasVagina() && !pc.hasCock())
			{
				output("  As the air grows thick with their musk, your [pc.vagina] grows wet, despite your best efforts.");
			}
			else if (pc.hasVagina() && pc.hasCock())
			{
				output("  You feel a twitch from your [pc.multiCocks] and an answering shiver from your [pc.vagina] as you imagine those canine shafts being put to use.");
			}
			else
			{
				output("  Your [pc.asshole] twitches in response, aching to be filled.");
			} 
		}
		output("\n\n");
	}

	output("But before the dogs move, the curtain of fog parts, and a figure on horseback rides into view.  The hounds go silent, as the tall figure pulls back his hood to look at you.\n\n");

	output("He is tall, easily seven feet, and made more imposing by the massive, golden antlers arching upward from either side of his head.  He is clearly not human, and more closely resembles a black stag, sitting upright, watching you with the same piercing red eyes as the hounds.  His short, black fur rustles in a wind that is not there, his ears twitching in time to the beating of your heart.\n\n");

	output("Most of his body is covered with fine clothing.  A cloak of dark green, decorated with complex patterns of gold, drapes over a hunting outfit of black leather.  One arm holds the reins of his mount, but the other, wearing a heavy leather hunting glove, grips a thick cane of shiny, black wood.  His legs taper down into slim, graceful hooves, and they touch down silently on the mossy ground as he dismounts.\n\n");

	output("“<i>I am the Erlking, Master of the Wild Hunt,</i>” he says in a deep, hollow voice. “<i>and you... you are a very unusual [pc.race].  My hounds can scent it on you.</i>” He gestures toward the stock-still hounds surrounding you. \n\n");

	output("His gaze runs up and down your form, and despite yourself, you shiver at his attention.\n\n");

	if (waited)
	{
		//[If Stand Your Ground Selected] 
		output("“<i>You’re a brave one, aren’t you?  Standing your ground in the face of the Wild Hunt?  I applaud your audacity.  I’m going to enjoy hunting you....</i>”\n\n");
	}
	else
	{
		//[If Run Selected] 
		output("“<i>I’m afraid you’re going to have to learn to run faster if you hope to elude me in the future.  I do hope you won’t bore me.</i>”\n\n");
		pc.energy( -10);
	}

	output("Before you can say another word, the fog closes in, leaving nothing but the red glow from the eyes of the Erlking and his Hounds.  One by one, they vanish, the Erlking’s last, leaving you alone in the darkness, the mist, and the cold.\n\n");

	output("Within a few moments, the wind picks up, blowing the fog away, leaving no trace of the mysterious Huntsman, save for a small package on the ground.  You hurriedly pick it up, unable to shake the eerie feeling that you’re being watched.\n\n");

	processTime(20 + rand(10));
	var foundLootItems:Array = new Array();
	if (waited) foundLootItems.push(new CoCCaninePepper());
	else foundLootItems.push(new CoCFoxBerry());
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect(foundLootItems);
}

public function repeatWildHuntEncounter():void
{
	clearOutput();

	output("As you wander through the Deepwoods, a familiar chilly fog begins to gather around your [pc.feet], and in the distance, you hear the sound of a hunting horn and the baying of Hounds.\n\n");

	output("The Erlking is coming for you!\n\n");

	if (pc.canFly()) output("You quickly glance from side to side, realizing that the trees here grow too close together for your to spread your [pc.wings].\n\n");

	output("Do you make a run for it or stand your ground?\n\n");

	clearMenu();
	addButton(0, "Run", repeatWildHuntChase);
	addButton(1, "Wait", repeatWildHuntWait);
}

protected function repeatWildHuntWait():void
{
	clearOutput();

	output("The fog pours in like a wave, surrounding you and blurring the forest around you.  You hear the thunder of hooves approaching, followed by the baying of hounds.\n\n");

	output("Unfazed, you cross your arms and stand firm, staring down the menacing fog. \n\n");

	output("The sounds of the hunt grow louder and louder until the trees themselves appear to be shaking with the sounds of the approaching hunt.  You stand tall, refusing to play the Huntsman’s twisted game.\n\n");

	output("The Hunt’s deafening approach abruptly quiets.  Like a tide going out, the fog drains away from around you, leaving the forest clear and calm. Slowly, the sounds of birdsong and insects return to the woods around you.  \n\n");

	output("It seems the Erlking has no interest in chasing prey that won’t run.\n\n");

	pc.slowStatGain("i", 0.5);
	pc.slowStatGain("w", 0.5);
	
	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function repeatWildHuntChase():void
{
	var pScore:int = playerHuntScore();
	if (pScore > 150)
	{
		repeatWildHuntEscaped();
	}
	else
	{
		repeatWildHuntCaught(pScore);
	}
}

protected function repeatWildHuntEscaped():void
{
	clearOutput();

	output("The Erlking might be the Master of the Hunt, but you are no one’s prey.  You immediately begin running, moving like the wind through the Deepwoods, your heart beating hard in your chest.");
	if (pc.isGoo())  output(  "You move like quicksilver over the forest floor, your slimy bottom half flowing over all obstacles, oozing you faster and faster, ever onward.");
	else if (pc.isBiped()) output("  Your [pc.legs] pound against the mossy ground, deftly moving across the forest floor.");
	else if (pc.isNaga()) output("  You move like the wind across the mossy ground, your coils propelling you through the forest.");
	else if (pc.isDrider()) output("  Your multitude of legs skitter over the forest floor, propelling you between the trees at great speed.");
	else if (pc.isTaur()) output("  Your [pc.legs] send you rocketing through the forest, dodging between the trees and ducking below branches.");

	output("  Though the fog snakes through the undergrowth, ever at your heels, it never manages to surround you, and you hear the sounds of the Hunt growing more and more distant until they disappear altogether.\n\n");

	output("It looks like you’re in the clear... for now.\n\n");

	pc.energy( -10);

	pc.slowStatGain("p", 0.33);
	pc.slowStatGain("r", 0.33);
	pc.slowStatGain("a", 0.33);

	processTime(15 + rand(15));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function repeatWildHuntCaught(pScore:int):void
{
	clearOutput();

	// Player Hunt Score < 150.  The Erlking captures you. 
	//If your score is above 100, the Erlking has his way with you.  
	// If your score is below 100, Gangbang by his Hounds (canine anthros).  
	// If the PC is a kitsune, bunny, or harpy, disregard Wild Points because the Erlking will ALWAYS opt to do the PC personally.  
	// The Erlking leaves the PC a nicely-wrapped gift of foxberries or canine peppers,  The Hunt reverts to 0 points.

	output("You run through the woods, heart pounding so hard you feel it might leap out of your throat.  Despite your best efforts, though, the fog still closes in.  With it comes the sound of the hounds, running alongside you, hidden in the thick haze. \n\n");

	output("With the Hounds on your right, you juke left, nearly running into a tree, but stumble past it, only to hear the Hounds again on your left.  You turn right, still running, unable to shake the feeling that you’re being driven, but too panicked to figure a way out. \n\n");

	output("Your lungs are burning as you run at top speed, the Hounds driving you this way and that.  Something happens as you breathe the fog - it’s getting harder and harder to think.  You just need to run, <b>run</b> from the predators after you.\n\n");

	output("As you leap to clear a low bush, leaves explode around you, and the world flips upside down.  It’s a trap!  The net closes around you and hauls you up into the air, leaving you spinning, 15 feet up.  Hounds burst from the fog, barking and snarling from the ground below you.  Just out of arm’s reach is a thick rope, running from the ground up over the branch supporting you.\n\n");

	output("The ropes are thicker than your wrist, and you could probably untie them, given time, but the spin of the net, combined with the mind-bending terror of the fog has left you no room to think.  The hounds are snarling, the world is spinning, you’re prey, and you’ve been caught.\n\n");

	if (/*pc.bunnyScore() >= 4 ||*/ pc.foxScore() >= 4 || /*pc.harpyScore() >= 4 ||*/ pScore > 100) repeatWildHuntAWinnerIsYou();
	else repeatWildHuntGivenToTheHounds();
}

public function repeatWildHuntGivenToTheHounds():void
{
	output("“<i>How disappointing,</i>” drips the refined voice of the Erlking.  His horse’s hooves thud softly on the ground as he walks below you.  The cane at his side clicks against the forest floor with every other step.  You have just enough wherewithal to understand his words as your fingers grip the net.\n\n");

	output("“<i>This was but a few minutes’ diversion.  I had been hoping for more of a challenge,</i>” he says, the red glow in his eyes dimming.  “<i>You’re not particularly good at this, are you?</i>” he says, sighing.  His long face looks almost wistful.\n\n");

	output("“<i>Perhaps next time,</i>” he sighs.  He turns, his dark cloak flaring.  Is it your imagination or do his golden antlers seem a bit more dull?\n\n");

	output("You allow yourself a brief moment of relief as he turns his attention from you.\n\n");

	output("“<i>But it would be wrong to not reward my Hounds for a job well done.</i>”  His cane flashes with golden light as he slashes it against the support rope.\n\n");

	output("The fog swallows the Erlking as you drop to the ground.  The impact against the mossy forest floor doesn’t injure you, but it <b>does</b> knock the wind from you.  As you struggle to regain your breath, you inhale the icy fog, and a cascade of terror... and something else... runs through you.\n\n");

	output("This fear doubles as the two hounds waste no time.  They are on you in the space of a heartbeat, ripping the net from around you, their powerful hands shoving you to all fours as they snarl and bark.  Their red, shiny dog cocks slip from their heavy sheaths, throbbing with thin, purple veins.  The fog has definitely done something to you, because you can’t help but lick your lips at the sight.  \n\n");

	output("Growling, the first Hound grabs you by your [pc.ass], his muscular fingers sinking roughly into your flesh.  He roughly rips your [pc.gear] from you, growling.  You feel a rush of warmth as a canine mouth presses against your [pc.ass],");
	if (pc.hasVagina()) output(" long tongue touching the bottom edge of your [pc.vagina]");
	else if (pc.balls > 0) output(" long tongue lapping at the base of your [pc.balls]");
	else if (pc.hasCock()) output(" long tongue lapping at the base of your [pc.cock]");
	else output(" long tongue slapping warmly against your taint");
	output(" before running up to your [pc.asshole].\n\n");

	output("You shiver, the fog-born fear still controlling your body.  You feel a rush of strange gratitude— the hounds don’t want to eat you, they just want to sate a different hunger.  And with the mindbending fog inside you, you want desperately to satisfy them.  Your submissive mind even hopes that if you can do a good job, they’ll spare you any further domination.  You’d be repulsed by the idea of fucking two Hounds to exhaustion if you weren’t so damn scared of them.  An errant thought at the back of your mind hopes that the effects of this fog are only temporary.\n\n");

	output("You glance over your shoulder, wanting to make sure the Hound has no trouble getting into you,");
	if (pc.isTaur()) output(" and realizing that you’re too tall, you fold your legs beneath you, dropping all the way to the ground,");
	output(" when the other hound roughly grabs your");
	if (pc.femininity < 30) output(" strong jaw");
	else if (pc.femininity > 70) output(" delicate chin");
	else output(" chin");
	output(", turning it toward his massive, slimy dog cock.  You get a brief glimpse of a crystal-clear bead of pre before the tip is forced between your lips.\n\n");

	output("The Hound begins fucking your face roughly, leaving salty precum on your tongue, his cock throbbing between your lips.  You feel grateful that the Hound has chosen to simply fuck you, and you want nothing more than to do the best job possible for the Hound.\n\n");

	output("You groan around the Hound’s dick as you feel a pressure against your [pc.asshole].  The beast squeezes your [pc.ass] cheeks as he shoves his foot-long doggie cock into your rear. ");
	pc.buttChange(12 * 3, true, false, false);
	output(" You yelp, realizing what’s to come, and try to wriggle away, but, pinned between the two Hounds, there’s no escape.  The Hounds growl in unison and you freeze, cowed by the two powerful males who want their way with your frightened, vulnerable body.\n\n");

	output("After all, comes a thought in your fog-addled head, they’ve earned the right to do whatever they want to their prey.\n\n");

	output("It doesn’t take the two dog men long.  They rock back and forth, shoving their thick cocks in and out of your submissive, helpless body.  The one in front grabs your head, burying your [pc.face] into his crotch, so deep that your tongue licks against the throbbing bulge of his knot, your nose buried in the thick fur above his shaft.");
	if (pc.hasTail()) output("  The Hound behind grabs you by [pc.onetail], using it as a handhold as he thrusts over and over into your [pc.asshole].");
	else output("  The Hound behind grabs you by your [pc.ass], thrusting into you again and again.");
	output("  You tremble, completely dominated by the two powerful males as they make you their prey-bitch.\n\n");

	output("They cum within moments of each other, the one in front driving his huge knot into your mouth, leaving your jaw aching.  You groan in protest as his cock shoots hot seed down your throat.  Nearly gagging on the canine dick already, there’s little you can do but swallow the Hound’s cum.  As you gurgle it down, you feel the Hound behind you painfully shove his thick knot into your ass.  You try to scream, but with a mouth full of cock and cum, there’s little you can do but take it like prey.  Your body quakes, belly swelling as you’re filled with cum at both ends leaving you warm, bloated, and strangely satisfied.\n\n");
	
	output("You shiver, breathing in the cold, mind-altering fog, waiting obediently for the two Hounds to tire of you.  Oddly enough, with their seeds spent, they’re strangely affectionate, and you find your back, face, and ass covered in warm, languid licks from the savage men.  Eventually their knots shrink, and the two Hounds withdraw from you, letting you slump to the ground as they pad off into the woods.  \n\n");
	
	pc.orgasm();

	output("As the fog recedes, your mind quickly returns.  Blinking, you wobble to your [pc.feet], wiping cum from your lips and gathering your scattered gear from around the clearing before setting back for camp.  You find a shiny, red pepper in the clearing, but appear to have dropped some gems in your failed flight from the Hunt.\n\n");

	var gemLoss:int = (10 + rand(15)) * 10;
	if (pc.credits < gemLoss) gemLoss = pc.credits;
	pc.credits -= gemLoss;
	output("<b>You’ve lost " + gemLoss / 10 + " gems.</b>\n\n");
	
	//dynStats("sen-", 2, "lib+", 2, "cor+", 1, "lus=", 0);	
	pc.slowStatGain("l", 2);
	pc.cor(1);
	pc.energy( -10);
	
	processTime(60 + rand(30));
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCCaninePepper()]);
}

protected function repeatWildHuntAWinnerIsYou():void
{
	output("Spirited clapping fills the woods.  The Hounds fall silent, sitting obediently on their haunches as the Erlking walks into the clearing, dismounting and looking up at you.\n\n");

	output("“<i>A spirited chase,</i>” he says, his black-gloved hands still chipping a sharp staccato through the cold air.  “<i>I have not had such fun in ages.</i>” The clearing is awash with a dim glow - it seems the Erlking’s golden antlers are lit with their own inner fire.\n\n");

	output("“<i>And so, my hind, my prey, you have a choice,</i>” he says, his refined tones ringing through the air.  Through the net you can see the fog receding from the forest floor.  You take a few experimental breaths, and feel your head begin to clear.  \n\n");

	output("He grasps the rope holding you up, and with strength surprising for his slim frame, lowers you down to the forest floor.  “<i>You have my thanks for a grand hunt,</i>” he says as, hand-over-hand, you are returned to the ground.	\n\n");

	output("As you touch down on the moss, the net falls away from you, and the Erlking offers you a hand up.  “<i>I’d like to offer you something.</i>”\n\n");

	output("You look up to see the slim, elegant form of the Erlking looking down at you.  Under his hunting gear, you can see the outline of a thick, equine cock, complete with triple prepuce rings straining against the black leathers.\n\n");

	output("A reward for all this trouble would definitely be welcome, and as much as you would appreciate a gift, you’d even welcome the opportunity to unwind after the exertion of the hunt.  \n\n");

	output("You pause for a moment to consider his words and realize he might be offering you more. If you’re feeling brave, you could ask for him to stop the hunt once and for all.  Or, if the hunt has finally broken your will, you might just submit to the huntsman forever.\n\n");

	output("Even with so many of these thoughts crowding your mind, there’s still a tiny spark of resentment burning.  You could rush him and turn the tables on this cocky asshole.\n\n");

	//Sex	 	What’s my prize?		Stop the Madness 		Surrender Forever		How Dare You!
	processTime(30 + rand(30));
	pc.energy( -10);
	clearMenu();
	addDisabledButton(0, "Sex", "Sex", "This scene requires you to have genitals.");
	if(pc.hasGenitals()) addButton(0, "Sex", predatoryPrey);
	addButton(1, "Prize?", whatsMyPrize);
	addButton(2, "Stop", stopTheMadness);
	addButton(3, "Surrender", surrenderToTheHounds);
	addButton(4, "Revenge", howDareYou);

}

protected function whatsMyPrize():void
{
	clearOutput();
	
	output("You stand up, brushing yourself off, and ignore the Erlking’s clearly-visible dick, stating that you’d like some compensation for all the trouble.\n\n");

	output("“<i>Of course, of course!</i>” laughs the Erlking, reaching into one of his saddle bags, and retrieving a small bundle.  He tosses it to you.  “<i>Better luck to you on the next hunt!</i>”\n\n");

	output("“<i>Next hunt?</i>” you begin, but before you can get the words out, the Erlking is already on his horse, thundering away through the trees.\n\n");

	//[You gain: Gems + Fox berries / Canine Peppers / Neon Pink Egg ]	
	var gemFind:int = 10 + rand(15);

	output("<b>You found " + gemFind + " gems.</b>\n\n");
	pc.credits += gemFind * 10;
	// TODO: neon pink egg, golden ring
	
	processTime(10 + rand(5));
	var foundLootItems:Array = new Array();
	if (rand(2)==0) foundLootItems.push(new CoCCaninePepper());
	else foundLootItems.push(new CoCFoxBerry());
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect(foundLootItems);
}

protected function stopTheMadness():void
{
	flags["COC.ERLKING_DISABLED"] = 1;
	clearOutput();
	
	//[This ends all the Erlking Encounters]
		
	output("You have had enough of this maniac and his insane hunt.\n\n");
					
	output("Supremely irritated, you tell him to stop hunting you. \n\n");

	output("“<i>Stop?</i>” he asks, the red light in his eyes dimming.\n\n");

	output("Narrowing your eyes, you begin to tell him exactly how fed up you are with this never-ending hunt.\n\n");

	output("“<i>As you wish,</i>” says the Erlking.  The fog rolls in once more, engulfing the Erlking and his steed.  It clears a moment later, leaving you alone in the forest.\n\n");

	output("You get the feeling you won’t be seeing him anymore.\n\n");

	processTime(10 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function surrenderToTheHounds():void
{
	//[Bad End]
	clearOutput();

	output("You sit there, shivering, unable to shake off the effects of the fog, looking up in utter fear at the huntsman who has pursued you for so long.\n\n");

	output("In a quavering voice, you bow your head, and ask him to take you as his prey once and for all.\n\n");

	output("“<i>My poor hind,</i>” he mutters.  You feel his gloved hand on your head, running through your [pc.hair] as your shoulders slump.  “<i>Perhaps I hounded you too fiercely,</i>” he murmurs, cupping your cheek.\n\n");

	output("You shiver at his touch, completely broken.\n\n");

	output("“<i>Look at me,</i>” he commands.  Completely obedient to the Hunter’s words, you look up, meeting his red-ember eyes.  “<i>I shall make amends,</i>” he says softly. \n\n");

	output("The words rumble through you, and you feel a warm heat building in your stomach.  Something about your arms and legs feel... off... but you can’t take your eyes away from the Erlking’s, not even when pain lances through your body, your muscles swelling, your [pc.armor] tearing and falling away.  The Erlking releases his hold on you and you look down immediately at your body.\n\n");

	if (pc.hasFur()) output("Your fur turns jet black.");
	else output("Black fur runs down your body like a tide coming in.");
	output("  Your muscles bulge and swell beneath the midnight coat.");
	if (pc.hasBreasts()) output("  Your chest first flattens out, then swells, as");
	else output("  T");
	output(" taut muscles fill in your entire frame.");
	if (pc.legType == GLOBAL.TYPE_CANINE) output("  Your doggie paws tingle as muscles build there, rebuilding them as stocky, athletic hound legs.");
	else output("  Your [pc.legs] bend and crack, making you howl in pain as they rebuild themselves as onyx-clawed canine paws.");
	output("\n\n");

	output("Between your bestial legs, your genitals rearrange themselves.");
	if (pc.hasVagina() && !pc.hasCock())
	{
		output("  Your clit swells to incredible size, throbbing a dull red, run through with purple veins.  You pant heavily, your tongue hanging out of your mouth, as the rest of your pussy closes, sealing as if it were never there, only to be replaced a moment later with the swelling of two massive testicles.");
	}
	else if (pc.hasCock() && !pc.hasVagina())
	{
		if (pc.totalCocks() > 1)
		{
			output("  Your stomach lurches as your cocks slap together and begin melding into one swollen form.  It pulses and throbs, swelling at the base, pointing at the tip, becoming a single dog cock.");
		}
		else if (pc.cocks[0].cType != GLOBAL.TYPE_CANINE)
		{
			output("  Your cock begins to shift and mold like clay, aching dull red, the veins darkening to purple, tip pulling out to form a throbbing, new dog cock.");
		}
		else
		{
			output("  Your canine prick throbs painfully, leaving you panting and whining.");
		}
	}
	else if (pc.hasVagina() && pc.hasCock())
	{
		if (pc.totalCocks() > 1)
		{
			output("  You pant heavily, your tongue hanging out of your mouth, as your pussy closes, sealing as if it were never there, only to be occluded a moment later with the curve of your swelling, massive testicles.  Your stomach lurches as your cocks slap together and begin melding into one swollen form.  It pulses and throbs, swelling at the case, pointing at the tip, becoming a single dog cock.");
		}
		else
		{
			output("  You pant heavily, your tongue hanging out of your mouth, as your pussy closes, sealing as if it were never there, only to be occluded a moment later with the curve of your swelling, massive testicles.");

			if (pc.cocks[0].cType != GLOBAL.TYPE_CANINE) output("  Your cock begins to shift and mold like clay, aching dull red, the veins darkening to purple, tip pulling out to form a throbbing, new dog cock.");
			else output("  Your canine prick throbs painfully, leaving you panting and whining.");
		}
	}
	else if (!pc.hasVagina() && !pc.hasCock())
	{
		output("  The smooth curve of your crotch ripples and bulges, and a cherry-red tip pushes out from your fur.  The wind around you picks up, blowing across your new, smooth doggie prick as it pushes out.  The overwhelming sensation has you shuddering, and you tilt your head back and howl.")
	}
	output("\n\n");

	output("The black fur covers your");
	if (pc.balls == 0) output(" new");
	output(" balls and runs halfway up your shiny red pecker, forming a sheath.");
	if (pc.hasWings()) output("  You whine, rolling on your back and with a start, realize that your wings must have fallen off while you were distracted with your cock.");
	output("  You smile an open-mouthed doggie smile, feeling the warm churning of cum building in your throbbing balls.  You ache for release, wanting nothing more than to stroke yourself.  You raise your black-nailed hands to your cock, but stop short, knowing instinctively that masturbating is forbidden.\n\n");

	output("Instead, you curl your stomach, trying to reach your cock with your mouth.");
	if (pc.faceType != GLOBAL.TYPE_CANINE) output("  The world bends alarmingly as your nose pushes out, creating a black-furred muzzle where your mouth once was.");
	output("  You whine, looking directly at your pointed dog cock, and the trickle of pre running from its tip, but even your");
	if (pc.faceType != GLOBAL.TYPE_CANINE) output(" new");
	output(" muzzle and broad, flat tongue can’t reach it.\n\n");

	output("The Erlking... The Master, your mind corrects itself.  The Master murmurs softly to you.  “<i>Patience, Hound,</i>” he commands, pressing a strong, gloved hand against your chest, holding you down on the ground.  You go still, submissive to the Master as he kneels next to your prone form.  His other hand grasps your dick slowly, and your mind melts.\n\n");

	output("You’re in absolute heaven as the Master pins you down, stroking your dick.  His gloved fingers work your shaft with elegant efficiency, running down your length, and squeezing in a delicious rhythm.  The hand on your chest stays firm, but runs through your fur, petting your broad, muscular chest.\n\n");

	output("Your eyes roll back, tongue lolling as the Master squeezes the base of your cock.  Your");
	if (!pc.hasKnot()) output(" new");
	output(" knot swells, and his firm hand on it feels sooo good.  At some point the two other Hounds have appeared, and you can feel, rather than see, their presence nearby.\n\n");

	output("You whimper and groan in absolute bliss, and begin bucking without meaning to.  You want to stay still and submissive for the Master, but your body has other ideas.  You whine, wriggling and writhing against the Master’s hand.  He grunts, hand moving faster and faster, squeezing tighter around your doggie cock.\n\n");

	output("With a woods-shaking howl, you climax, spraying your belly and chest with cum.  Your limbs go wobbly, and your eyes cross, barely able to see the Master’s spooge-spattered hand in front of your face.  You know what he wants and you obediently clean his glove with your tongue, slurping down your own cum from his fingers.\n\n");

	output("The Master stands up, and as you wobble to your feet, the two other Hounds move forwards, their broad tongue licking your chest, stomach, and dick, cleaning the cum from your fur.\n\n");

	output("<b>The Master sounds his horn, and your ears perk up.  Astride his horse, he gallops off into the fog-haunted woods, and, like the rest of the Hounds, you follow.</b>\n\n");
	badEnd();
}

protected function predatoryPrey():void
{
	clearOutput();
	
	output("You stand, unable to take your eyes from the Erlking’s slim body and erect dick.\n\n");

	output("You smile seductively, asking the Erlking exactly what he’s offering.\n\n");

	output("“<i>Exactly what you’re thinking,</i>” rumbles the Erlking.  You feel the voice vibrating up through your arm.  Maybe it’s the lingering effects of the fog, but you need the Huntsman inside you, his arms around you, and as he slips one arm around at the small of your back, the other behind your head, fingers entwined in your [pc.hair], you melt into his embrace.  \n\n");

	output("His warm mouth presses against your neck, his fingers undoing your [pc.gear], letting it fall to the forest floor.  His touch sends warm shivers through you, and you moan as he walks you backward, pressing you firmly against a tree.\n\n");

	if (!pc.isTaur())
	{
		if (pc.hasVagina() && !pc.hasCock())
		{
			output("With your back against the tree, he guides your");
			if (pc.isBiped() || pc.isDrider() || pc.isGoo()) output(" [pc.legs] up, letting them wrap around his back.");
			else if (pc.isNaga()) output(" tail up, letting your coils wrap around his back.");
			output("  One hand grasps firmly under your [pc.ass], holding you up, while the other plays softly across your chest, squeezing and caressing each of your [pc.chest] in turn.  He tweaks your nipples, one by one, sending shockwaves of pleasure through your body.\n\n");

			output("“<i>Take me, Huntsman,</i>” you moan.  His shaft is already poised, his equine dick sliding up into your [pc.vagina], pushing deep inside you.");
			
			pc.cuntChange(0, 12 * 3, true, true, false);
			output("\n\n");

			output("You gasp, shuddering in delight as he begins to push in and out of you.  His hands shift, holding you under the arms, fucking you against the tree.  The rough bark scratches your back as he thrusts deep inside you.  You feel the triple rings of his prepuce rubbing against your inner walls.\n\n");

			output("His speed builds, and his strong arms lift you up, sliding you up and down his shaft, letting your own weight fuck you against his dick, over and over.  You moan, body quaking as you cum, his shaft grinding deep against your womb.  After several minutes of steady rhythm, he grunts, pushing you down, and a moment later, he climaxes inside you, pumping you full of hot, thick cum.  You shudder as he floods you with jet after jet of his thick seed.\n\n");

			output("You wrap your arms around him, clinging to him as he shifts his grip, bearing you up as you quake with aftershocks of pleasure.  One arm holds you up, close to his muscular chest, his other gloved hand strokes your [pc.hair], as the fog rolls in.\n\n");

			output("You feel drowsy as the air thickens with chill fog, though the Erlking’s body keeps you warm.  Despite your best efforts, you find yourself drifting to sleep in his arms.  \n\n");

			output("You wake up an hour later, head spinning, feeling slightly tougher for all of the... exercise.\n\n");
		}
		else if (pc.hasCock())
		{
			output("With your back against the tree, he guides your");
			if (pc.isBiped()) output(" [pc.legs] up, letting them wrap around his back.");
			else if (pc.isNaga()) output(" tail up, letting your coils wrap around his back.");
			output("  One hand grasps firmly under your [pc.ass], holding you up, while the other plays softly across your chest, tweaking each nipple before trailing down your stomach, grasping [pc.oneCock]\n\n");

			output("“<i>Take me, Huntsman,</i>” you groan.  His shaft is already at your [pc.ass].  His equine dick pushing up into your [pc.asshole], pushing deep inside you.");
			
			pc.buttChange(12 * 3, true, true, false);
			output("\n\n");

			output("You gasp, shuddering in delight as he begins to push in and out of you.  His hands shift, one at the small of your back, steadying you, fucking you against the tree.  The other squeezes tight around your dick, jacking you off, gloved hand stroking you roughly in time to his thrusts.  The coarse bark of the tree scratches at your back as you feel the triple rings of his prepuce rubbing against the inner walls of your [pc.asshole].  \n\n");

			output("You moan, body quaking as you cum, spurting cum over his chest and your own, his shaft grinding deep inside you.  He pushes you down, and a moment later, he climaxes inside you pumping you full of hot, thick cum.  He floods your bowels with jet after jet of his thick seed, your belly swelling slightly outward from the volume of cum.\n\n");

			output("You wrap your arms around him, clinging to him as he shifts his grip, holding you up as you quake with aftershocks of pleasure.  One arm holds you up, close to his now-sticky, muscular chest, his other gloved hand still slowly stroking your cock, as the fog rolls in.\n\n");

			output("You feel drowsy as the air thickens with chill fog, though the Erlking’s body keeps you warm.  Despite your best efforts, you find yourself drifting to sleep in his arms. \n\n");

			output("You wake up an hour later, head spinning, feeling slightly tougher for all of the... exercise.\n\n");
		}
	}
	else
	{
		output("The Erlking smiles at you, caressing your cheek.  “<i>I pride myself in keeping a proper stable,</i>” he says, delicately moving behind you.  With his strong hands on your flanks, he guides you to face up against a tree.\n\n");

		if (pc.hasVagina() && !pc.hasCock())
		{
			output("With your [pc.chest] against the rough bark, he lifts your [pc.tail], exposing your [pc.pussy] to the swelling head of his equine cock.  With a soft sound, he pushes between your lips, letting you feel each prepuce ring as they squeeze into you.");
			
			pc.cuntChange(0, 12 * 3, true, true, false);
			output("\n\n");

			output("You wrap your arms around the trunk of the tree as his hands grip your flanks.  His own equine legs begin thrusting him against you, his ribbed cock sliding in and out of your [pussy], the ridges of his horselike shaft massaging you from the inside.  The force of his fucking ginds your [pc.chest] against the tree.");
			if (pc.isLactating()) output("  The friction begins milking you, making you ooze milk down the trunk.");
			output("  The mild pain of abrasion couples with the pleasure of his forceful fucking and you feel your climax approaching.\n\n");

			output("With a moan, you cum, hugging the tree with all your might, thrusting back with your hindquarters.  With gentlemanly demeanor, the Erlking continues pumping his thick cock in and out of you until your orgasm recedes.  He then cums himself, filling your insides with his hot spunk. \n\n");

			output("He allows you a moment to catch your breath, the pulls out.  You hear his cock slap wetly against his thigh.  A strong hand takes yours, guiding you across the clearing to a fallen log. Dazed, you follow him, and he sits, guiding you to do the same next to him.  \n\n");

			output("Reaching into his belt pouch, he pulls out a small bottle of salve.  One hand strokes your hair as the other begins to work the cream into your scratched [pc.chest].  The cream is cool and soothing, and the Erlking is attentive.  You soon fall asleep, your head leaning against his chest.\n\n");

			output("You wake up an hour later in the clearing, the Erlking gone and your chest unmarred.  You blink, sleepily, still feeling the Erlking’s arms around you and shakily climb to your feet, making your way back to camp.\n\n");
		}
		else if (pc.hasCock())
		{
			output("With your [pc.chest] against the rough bark, he crouches at your side, taking your already stiffening [pc.oneCock] in his gloved hand.  From this angle, you feel, rather than see the cream he lathers on your [pc.cock], working you to full hardness. One hand strokes your flank soothingly as the other wraps around your [cock], stroking you in his strong grip.\n\n");

			output("You pant, fingertips gripping the bark of the tree as he jacks you off.  Your tongue lolls out as his gloved hand grips you firmly, moving faster and faster as he works his way up and down your length.  Whatever lube he used is incredible, and you feel a tingle on every down and up stroke.\n\n");
			
			output("You can’t get enough of this feeling - being milked by the Erlking.  He even seems to be humming under his breath as he strokes your side and works you with deft fingers.  It’s like he’s calming some rutting stallion!  Your [pc.leg] stamps reflexively, your [pc.tail] swishing as your body announces your intent to cum.\n\n");

			output("The Erlking responds by stroking you faster, his hand tightening, increasing the tingling pleasure from the cream.  You groan, gripping the tree trunk, rubbing your chest against it for extra stimulation, the rough bark scratching harshly against your [pc.nipples].  \n\n");

			output("The Erlking gives a final, tight squeeze, a fingertip pressed against the tip of your cock.  You moan, cumming in his hand, your cum jetting against his fingertips, spraying, hose-like, against the mossy forest floor.  \n\n");

			output("You pant, exhausted, and you feel a damp cloth against your softening cock.  He wasn’t kidding about taking care of his mounts - the Erlking is cleaning you off.  He wipes your cock clean, even catching stray drops that spattered your underside.  The huntsman is thorough, and you yawn softly, dozing under his careful ministrations.  \n\n");

			output("Sleepily, you’re only half aware as he guides you down to a grassy patch, where you quickly fall asleep.  You wake up an hour later in the clearing.  The Erlking is gone and but your cock gives a twitch as you remember his touch.  You shakily climb to your feet, making your way back to camp.\n\n");
		}
	}

	//[+10 Fatigue, +1 Toughness / +1 Strength, 100 hp healed]			
	//if (pc.tou < pc.str) dynStats("toughness+", 1, "fatigue+", 10, "health+", 100, "lust=", 0);
	//else (dynStats("strength+", 1, "fatigue+", 10, "health+", 100, "lust=", 0));
	pc.slowStatGain("p", 1);
	pc.energy(10);
	pc.HP(100);
	pc.orgasm();
	processTime(75 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function howDareYou():void
{
	clearOutput();
	
	//[ends the Hunt permanently, Opens Princess Option]
	output("You’ve had more than enough of the Erlking and his insane hunt.  You rise to your [pc.feet], slapping away his outstretched hand.  He frowns, but before he can react, you’ve charged forward and knocked the black wood cane out of his hand.  It spins off into the undergrowth, out of sight.  The light in his eyes dims, as does the glow from his antlers.\n\n");

	output("He stumbles backward, pained as if you’d struck him directly.  A look of confusion crosses his ridiculous deer face.  “<i>Wait - my cane - it fortifies me against the rigors of this land... </i>” he gasps, suddenly staggering.\n\n");

	output("You sneer and stalk forward, another well-placed shove to his shoulders knocking him from his feet.  He drops to his knees with a groan.  At the edge of the clearing, the Hounds sit silently, awaiting the outcome of the confrontation.\n\n");

	output("“<i>Please... my cane...</i>” he pleads.  On his knees, his trembling arms hold him up.  He seems to be telling the truth - without the cane, he’s as weak as a newborn.\n\n");

	output("“<i>You taunt me, you hunt me, and now you ask for favors?</i>”  you snort.  “<i>No, no, you’re about to be taught a very lasting lesson,</i>” you snarl.\n\n");

	output("“<i>What do yo-</i>” begins the Erlking, looking up at you.  You slap his face, cutting off the end of the question.\n\n");

	if (pc.hasVagina() && !pc.hasCock())
	{
		output("You grab his horns, shoving him over backwards.  He seems to be getting weaker by the moment.  He can barely pick himself up off the ground.  You look down at the prone huntsman with disdain, striding to his head, your [pc.feet] on either side of his head.\n\n");

		output("“<i>What are yo-</i>” he tries to ask, before you crouch down, burying his deer-muzzle in your muff.  You grab the forward prongs of his antlers, steering his mouth against your dripping vagina.\n\n");

		output("“<i>Lick it, Huntsman!</i>” you order, pulling on his antlers, his dark muzzle pushing hard against your pussy.  You snarl, feeling the timid push of his tongue against your pussy lips.\n\n");

		output("“<i>Deeper!</i>” you command.  You feel his tongue explore deeper into your wet snatch, and you guide his wet deer nose to rub against your clit. \n\n");

		output("“<i>Not a king anymore, are you?</i>” you growl, smiling.  “<i>You’re more like a Princess now.  A slutty, little Princess,</i>” you grin.  You see a tremble run down his chest and front, his cock straining against his tight leathers.  “<i>Eat my pussy, Princess,</i>” you order.\n\n");

		output("Your princess moans, shuddering and submissive, shoving his flat tongue into your pussy.  It might be a trick of the light, but you swear his fur just got a little lighter.  His hips writhe, drawing attention to how slim and girlish they really are.  He’s obviously responding very well to the abuse.\n\n");
		 
		output("You sigh in satisfaction, settling down on his face, holding tight to his antlers and steering his lapping tongue.  You ride the Erlking’s face for nearly half an hour.  Eventually you climax, moaning in ecstasy, covering the huntsman’s face with your pussy juices.  You grind down hard on his face, pulling up hard on his horns.  With a cracking noise, his golden antlers come loose in your hands\n\n");

		output("You stand, looking down at the disgraced forest lord.  He lies there, gasping, smeared with your pussy juices, dirt ground into his fur, his antlers broken.  From the wetness staining his leathers and hips, it looks like he came at some point, and it’s now slowly oozing out of his clothes, matting his fur.  Maybe it’s the spunk, but it looks as if his fur has an odd tint to it - slightly pink?  You shrug it off as some trick of the light as you gather yourself and prepare to leave.\n\n");

		output("As you turn away, the fog rolls in low, engulfing the prone huntsman.  You know he definitely won’t be bothering you anymore.\n\n");
	}
	else if (pc.hasCock())
	{
		output("You undo your [pc.armor], releasing your [pc.cock].  Narrowing your eyes at the fallen hunter, you grab him by the antlers, shoving your cock in his face.\n\n");

		output("“<i>Lick it, huntsman.  Make me good and wet,</i>” you growl.  \n\n");

		output("Strangely, the Erlking needs little encouragement, and almost eagerly takes your [pc.cock] into his long stag muzzle, his hot tongue running up and down the underside of your shaft.  Is it possible that the cane was reinforcing his mind as much as his body?  He moans in pleasure as you grip his antlers, driving yourself deep into his mouth.\n\n");

		output("What the Erlking lacks in skill, he makes up for in enthusiasm, licking and sucking noisily at your cock.  When the huntsman has sufficiently lubed up your cock you shove back on his antlers, pushing his mouth from your [pc.cock].  The force of the impact breaks his golden horns, and they come free in your hands.  The Erlking whimpers, hornless, looking up at you, reaching for your cock.\n\n");

		output("“<i>On all fours, slut,</i>” you smirk, shoving the huntsman back.  You throw his horns to the side as he stumbles to the mossy ground, visibly weakened without his cane.  Somehow, you don’t think it’s only the loss of his cane making him so submissive.  He looks more like a doe now with his horns gone.\n\n");

		output("The Erlking turns over on all fours, his cloak riding up over his shoulders.  Just above his taut buttocks is a tufted deer tail.  You smirk, grabbing the fluffy tail with one hand, and shoving down his leather pants around his knees.  He looks back over his shoulder at you.  The red light has gone out of his eyes, leaving them as wide, doe-brown eyes.  Heavy lashes blink hopefully at you as you spread his white-furred rump.\n\n");

		output("“<i>Not a king anymore, are you?</i>” you growl, smiling.  “<i>You’re more like a Princess now.  A slutty, little Princess,</i>” you grin.  You see a tremble run down his back, and his soft, fluffy tail twitches in your hand.  “<i>Say it,</i>” you order.\n\n");

		output("“<i>I... I’m a Princess,</i>” he mutters, his voice noticeably higher.  You smile, wondering what else the loss of his cane will do to your princess.\n\n");

		output("“<i>Good girl,</i>” you coo, pressing your [pc.cock] against his pucker.  The new princess moans, shuddering  as you do, shoving his ass back against you.\n\n");

		output("You push into him, and he moans, tossing his head back.  He’s ridiculously tight, but hungry for it.  As you begin fucking him, his voice grows higher and higher, much more girly than his earlier, thundering boom.  Thrust after thrust, you push into his supple ass.  It might be a trick of the light as the last tendrils of mist fade away, but it seems like his fur is less dark than before.\n\n");

		output("He shivers below you, tensing, as he grinds his hips back against you on every downstroke.  He bucks and moans, and you hear a splashing noise from beneath him.  From the looks of the sticky white pool growing, the slut is shooting his load HARD.\n\n");

		output("The sight of his total submission turns you on so much that you shudder, cumming deep inside his ass, filling him up with your hot, sticky seed.  As you grip his ass, you pant, driving in as deep as possible, marking him as your bitch forever.\n\n");

		output("He moans, slumping down, cheek to the ground, and you bend over him, grinding his face to the ground.\n\n");

		output("“<i>Dirty little slut,</i>” you growl.  “<i>Did you like that?</i>”\n\n");

		output("“<i>Y-yes...</i>” purrs the once-Lord.  “<i>I... I loved it...</i>” He shudders again, and you notice that the lighter fur is no illusion.  Your new doe princess is no longer midnight black, but a sandy-tan, and still slowly lightening.\n\n");

		output("“<i>I don’t expect we’ll have any more problems, will we?</i>” you ask, sliding out of him.  You rise, watching as his fur takes on a curiously pink hue.\n\n");

		output("“<i>No, my Lord,</i>” She croons, rising up to her knees, lapping at your dick.  Once she’s finished cleaning, she helps you with your [pc.gear].  You nod a goodbye to her and begin walking, smirking in amusement at the trickle of cum running down her taut cheeks and down her legs as she waves farewell.\n\n");
	}

	pc.createKeyItem("Golden Antlers", 0, 0, 0, 0);
	pc.orgasm();
	
	//if (flags["COC.ERLKING_CANE_OBTAINED"] == undefined) {
		//inventory.takeItem(weapons.HNTCANE, returnToCampUseOneHour);
		//flags[kFLAGS.ERLKING_CANE_OBTAINED] = 1;
		//return;
	//}
	processTime(45 + rand(15));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function encounterPrincessGwynn():void
{
	clearOutput();

	output("As you wander through the Deepwoods, you hear a rustling in the bushes.  You turn to see a flash of pink between the trees.  A slim, graceful figure steps out from behind a tree, wearing a dark green cloak and a small, leather shoulder bag.  It takes you a moment to recognize the Princess, the once-Erlking.  Her deer-like face and large, doe eyes peer timidly at you.\n\n");

	output("“<i>Muh-M’lord?</i>” she asks softly.  Her lithe arms push through the low branches and trees as she steps closer to you.  She’s timid and twitchy, quite different from the ominous and powerful huntsman she’d once been.  In a moment, you see why.\n\n");

	var selector:int = rand(6);

	if (selector == 0) output("The Princess’s pink fur is slathered in smears of saps and juices, and angry red stings pepper her body.  It’s very obvious that she’s fallen prey to the roaming tentacle monsters that haunt the forests.\n\n");
	else if (selector == 1) output("The Princess winces as low branches drag across her ass, and you can see angry red claw marks criss-crossing her pert ass.  It seems she’s run afoul of Akbal, the feline lord of the Deepwoods.\n\n");
	else if (selector == 2) output("The Princess coughs, a trickle of cum running down her lips and chin.  You see bruises on her throat and chin, and tiny claw marks across her body.  It looks like she was caught by a roving gang of imps.\n\n");
	else if (selector == 3) output("The Princess’ pink fur is stained with multicolored blotches, and she sways a little bit, apparently woozy.  Goblin attacks can leave a person that way for quite some time.\n\n");
	else if (selector == 4) output("The Princess’ neck and wrists bear bruises, as if someone had bound her up roughly and repeatedly.\n\n");
	else if (selector == 5) output("As she turns to squeeze between two trees, you see that the Princess has numerous claw marks up and down her back.  It looks like, since her transformation, her Hounds have turned on her.\n\n");

	output("Despite that, she looks very happy to see you.  She’s become more feminine since you last saw her.  Her hair is tufted up into a rose-colored pixie cut with two spritely pigtails at the nape of her neck. Her chest is still flat, but she’s lost muscle mass, making her tall, thin, and androgynous.  Her black leathers are gone, and her fur is mostly cotton-candy pink, accented by her white chest, stomach, and thighs.  Her cock swings with each careful movement, a mottled white and pink, matching her fur, with three prepuce rings.  She steps forward, her long, deer legs giving her hips an unintentional sway as she gingerly minces toward you.\n\n");

	output("“<i>Master!  It’s wonderful to see you again!</i>” she coos, throwing her arms around your shoulders, kissing you with pink, pouty lips.  “<i>I’ve been having so much </i>fun<i> as a Princess!  I can’t believe how much happier I am now!  Thank you </i>so<i> much!</i>”  Her voice sounds a bit slurred, as if she’s been mentally affected by slutting around in the Deepwoods.\n\n");

	if (flags["COC.TIMES_ENCOUNTERED_PRINCESS_GWYNN"] == undefined)
	{
		flags["COC.TIMES_ENCOUNTERED_PRINCESS_GWYNN"] = 0;
		output("“<i>I’m so happy you helped me get rid of that nasty old cane,</i>” she says, waving a pink-furred arm vaguely at the forest.  “<i>It may have kept out the corruption, but it was giving me a </i>weird<i> idea of fun,</i>” she bubbles.  “<i>No more hunting for me - no, sir!</i>”\n\n");
		output("She touches her white fingers to her chest and purrs demurely, “<i>You can call me Gwynn, now.  But I’ll still be your princess!</i>”\n\n");
	}

	flags["COC.TIMES_ENCOUNTERED_PRINCESS_GWYNN"]++;

	output("“<i>What can I do to repay you?</i>” Gwynn chirps cutely, kissing your cheek.  ");

	if (pc.hasCock()) output("“<i>I could suck your dick, or you could fuck my princess pussy, or ");
	else output("“<i>")
	if (pc.hasVagina()) output("I could eat your pussy, ");
	output(" or I could share some of my special potion with you,</i>” she counts the options off on her slim fingers.\n\n");

	output("You run through the options in your head, even briefly considering ‘getting some of her potion’ on your own terms.\n\n");

	//Suck My Dick  /  Fuck Her Ass  /  Eat My Pussy  /  Milk Her Dick  /  Gifts
	clearMenu();
	
	addDisabledButton(0, "Suck Me", "Suck Me", "This scene requires you to have cock.");
	addDisabledButton(1, "Assfuck", "Assfuck", "This scene requires you to have cock.");
	addDisabledButton(2, "Eat Me", "Eat Me", "This scene requires you to have vagina.");
	
	if (pc.hasCock()) {
		addButton(0, "Suck Me", gwynnSucksDicks);
		addButton(1, "Assfuck", gwynnGetsButtfuxed);
	}
	if (pc.hasVagina()) {
		addButton(2, "Eat Me", gwynnNomsDaCunts);
	}
	addButton(3, "Milk Dick", gwynnGetsDickmilked);
	addButton(4, "Gifts", gwynnGibsGifts);
	
	addButton(14, "Leave", function():*{
		processTime(15 + rand(5));
		clearMenu();
		mainGameMenu();});
}

protected function gwynnSucksDicks():void
{
	clearOutput();
	output("“<i>Yes, of course, M’Lord!</i>” Gwynn burbles, happily, dropping down to her knees.  In an instant, your [pc.cock] is in her wet mouth.  Her time in the woods has developed her skill as she moans around your [pc.cock], slurping wetly at it.\n\n");

	output("Her slim tongue rubs against the underside of your shaft, massaging it in time to the bobbing of her head.  Her index finger and thumb form a slim O at the base of your dick, pumping it counter to her head bobs, giving you continuous stimulation as she hums.\n\n");

	output("She hums as she works, sounding like the happiest little slut in the world.  She expertly works your cock, stroking and pumping your meat with her wet, hungry mouth and you feel yourself breathing heavily as her slurping grows louder and more eager.  \n\n");

	output("The vibration of her chirpy voice and pressure of her lips around your cock soon push you over the edge, and with a relaxed shudder, you cum in her mouth.  She takes the first jet down her throat, then pulls her mouth from your dick with a satisfied gasp, taking the next jet across her face.\n\n");

	output("“<i>Oooooo...</i>” she moans, shivering in delight, her tongue lapping at the dripping cum, her fingers delicately wiping the thick spooge from her cheeks and depositing it in her mouth.  You notice that she’s shoved two of her slim fingers up her cute, perky ass as she slurps away at your spilled seed.\n\n");

	output("Satisfied, you pat her head, ruffling her short, pink hair, leaving her happy and smiling.\n\n");

	output("“<i>Thank you, M’lord!</i>” she calls as you walk off.\n\n");

	//[Libido + 2]
	//dynStats("lib+", 2, "lus=", 0);
	pc.orgasm();
	pc.libido(2);

	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function gwynnGetsButtfuxed():void
{
	clearOutput();

	output("“<i>At once, M’Lord!</i>” she says, clapping her hands excitedly.  She bounces up in the air, then bounds low to the ground, pulling a small bottle from her purse, and dumping a liberal amount of raspberry-scented lube on your cock.  She works it in, her slim fingers massaging your cock to full attention before she hops around.\n\n");
			
	output("“<i>Princess Gwynn is always prepared!</i>” she chirps happily.\n\n");

	output("She drops her shoulders to the ground and raises her white rump in the air, her pink, tufted tail twitching excitedly.  “<i>Your Princess is ready for you, m’Lord!</i>”\n\n");

	output("You grin and grip her ass, pushing your slippery cock into her pink bud.  She’s a lot looser than she was before, and you slide easily into her.  She purrs as you sink in, inch after inch, your hands gripping her small, plush ass.  It seems like her time spent with the monsters in the woods has stretched her out immensely.  You just hope she won’t be too loose.\n\n");

	output("“<i>Oh Master, yes!  Fuck my lovely cunt!</i>” she moans as you bury yourself inside her.  Her hole twitches and tightens, and you realize you needn’t have worried.  As you begin thrusting in and out of her, her hole begins squeezing tighter and tighter around your cock.  Her ass milks your dick as you plunge deep inside her and draw out.\n\n");

	output("She moans and purrs, eyes rolled back and tongue hanging out as you have your way with her.  When you finally cum, her pink-and-white cock spills out her own load, strangely raspberry-scented, onto the forest floor.  Her hole doesn’t stop squeezing you, and continues to milk you until you’re completely spent.\n\n");

	output("You withdraw from her and she sits up, giggling, spinning on her knees to slurp at your cock, cleaning you off.  Just as when you first turned her, she cleans you completely, then helps you dress, giggling happily as you kiss her cheek farewell.\n\n");

	//[Sensitivity -2]
	//dynStats("sen-", 2, "lus=", 0);
	pc.orgasm();

	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function gwynnNomsDaCunts():void
{
	clearOutput();

	output("“<i>Yes Ma’am,</i>” she says, licking her lips.  She points to a nearby stump, gesturing for you to have a seat on the soft moss.  As you do, she wastes no time in dropping her pink muzzle to your pussy.  \n\n");

	output("Her tongue eagerly plunges between your folds, running up and down the length of your pussy. Each time her muzzle bobs up, her candy-pink nose rubs against your clit, and she purrs, closing her eyes and nuzzling it.  She slowly laps at your slit, gradually building speed.\n\n");

	output("You sigh happily, bracing yourself with your arms and leaning back.  Princess Gwynn slurps noisily at your muff, her tongue moving faster and faster.  You gasp, pleasure building in your whole body as she withdraws her tongue from your pussy, wrapping her lips around your pleasure button.\n\n");

	output("Two long, slim fingers slide into your pussy as she sucks on your love button.  Her tongue flickers and massages your clit as her finger pump in and out of your dripping snatch.  She hums, letting the vibrations from her lips travel in and buzz around your clitty.  Just as you shiver, on the edge of your orgasm, she closes her teeth lightly on your clitty, humming and buzzing them against your sensitive nub.  You cry out, gushing pussyjuices down her chin and chest.  She keeps licking, drawing another shivering orgasm on the heels of the first. \n\n");

	output("You slump back on the stump, trembling.  You glance down");
	if (pc.biggestTitSize() > 2) output(" between your breasts");
	output(" to see her smiling and elegantly licking her slim fingers clean. You shudder as she begins lapping at your pussy, cleaning you methodically.");

	output("When you can finally move again, Princess is kneeling next to you obediently.  She closes her eyes, smiling as you pat her head, ruffling her pink hair.  When you stand, she rises to help dress you, blowing you a kiss as you leave the forest behind.\n\n");

	//[Sensitivity -2, Libido +2]
	//dynStats("sen-", 2, "lib+", 2, "lus=", 0);
	pc.orgasm();
	pc.libido(2);

	processTime(25 + rand(15));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function gwynnGetsDickmilked():void
{
	clearOutput();

	output("“<i>My Lord, are you sure?</i>” she says, tilting her head to the side.\n\n");

	output("You assure her that this is what you want and order her onto her back, lying on the soft, mossy ground.  One lithe arm is draped over her head, the other crosses over her chest, as she bites her lip, looking up at you nervously.\n\n");
		
	output("Her dick is already rigid, a foot long and mottled pink and white, like clouds at dawn.  You kneel down next to her and grasp it slowly, your fingers finding natural handholds along her triple prepuce rings.\n\n");

	output("“<i>Master, I have lube in my bag... if you’d like to use it, that is,</i>” she says shyly, reaching into her purse and offering you a small, pink bottle.  You realized that this purse used to be one of her saddlebags.  As you uncork the bottle and pour out a liberal amount of lube over her massive, flat-headed equine cock, you idly wonder if she used to carry lube as the Erlking.\n\n");

	output("You begin stroking her thick cock, feeling her pulse through it as it throbs under your fingers.  You squeeze it roughly, drawing a squeal from Princess Gwynn as she bites her bottom lip.  Unsure of what to do with her hands, she runs them through her own hair, looking up at the canopy from under heavy lids.  Her long lashes flutter as she pants shallowly.\n\n");

	output("Faster and faster you pump her, until her breath comes in shallow gasps and her body trembles at the edge of orgasm.  You’re immediately seized by a wicked idea, and with your free hand, you pull her tail up, raising her ass in the air.  She squeaks in pain but you’re not done yet.  You curl her whole lower body over, and aim her heavy cock at her face.\n\n");

	output("“<i>Oh, nuh-nooo...</i>” she gasps, her knees now planted on either side of her head.\n\n");

	output("“<i>Oh, yes,</i>” you coo wickedly, shoving the lithe doe’s cock into her own mouth.  She blathers a muffled protest before you give her tufted tail another sharp tug, drawing out her orgasm..\n\n");

	output("Her cock spurts into her own mouth, immediately ballooning out her cheeks.  Her eyes roll back in her head as she gurgles around her cock.  Slightly-pink, raspberry-scented cum spills out from her pouty lips, as she coughs and nearly chokes on her own cum.  \n\n");

	output("You drop her tail, letting it thump to the ground, her hooves digging tiny furrows in the dirt as her cock arcs out a trail of thick spooge down her flat chest.  She moans, pink spooge drooling out from her mouth.  You watch, both amused and surprised, as her first act upon regaining her senses is to begin scooping up her own cum and licking it off her fingers.\n\n");

	output("Satisfied that she’ll be fine, you stand up, leaving the slutty doe to clean herself up.\n\n");

	//[Lust +20, Libido +2]
	//dynStats("lus+", 20, "lib+", 2);
	pc.lust(20);
	pc.libido(2);
	
	processTime(45 + rand(15));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

protected function gwynnGibsGifts():void
{
	clearOutput();

	output("“<i>Do you have any presents for your Master?</i>” you ask casually.\n\n");

	output("Princess Gwynn claps her hands, bouncing on one foot, then the other.  “<i>Yes I do, M’Lord!  Yes I do!</i>”  She stops bouncing long enough to rifle through her purse, pulling out a small, pink bottle. \n\n");

	output("“<i>This is my lube!</i>” she says with a smile.  “<i>Well, I use it for lube.  But you can also drink it to help control yourself when you don’t want to go crazy with lust,</i>” she babbles.  Her chirpy voice and new, even more bubbly attitude makes you unsure about this claim.  You give her a look and she blinks at you with wide eyes.  “<i>It’s yummy,</i>” she assures you with a bob of her head. \n\n");

	output("She minces up to you, placing the bottle in your hands and giving you a kiss on the cheek.  “<i>I only have one on me, but if my Lord gives me a little time, I can make more,</i>” she purrs, kissing you softly on the lips, biting lightly on your bottom lip as she presses and rubs her flat chest and cock against you.\n\n");

	output("“<i>I’ll get started on it right away!</i>” she says suddenly.  She pulls away from you, nods her head seriously, then bounds off into the woods.\n\n");

	output("Before you can stop her, she’s gone, and you pocket the small bottle for later.\n\n");

	//if (rand(4) > 0) inventory.takeItem(consumables.PRNPKR, returnToCampUseOneHour);
	//else inventory.takeItem(consumables.PRNPKR, goldenRindBonus);

	processTime(15 + rand(5));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCPrincessPucker()]);
}

//private function goldenRindBonus():void {
	//clearOutput();
	//output("“<i>Oh, I also had this left over from brewing my Pucker,</i>” she says, popping out of the brush behind you.  You yelp in surprise.  She’d vanished into the forest in front of you a moment ago.  How did she move so quickly?  “<i>Here you go!</i>” she pipes up, depositing a small item in your hand before disappearing back into the woods.  If she can move that quickly and quietly through the woods, it’s pretty likely that her falling prey to the forest predators has been entirely voluntary.\n\n");
	//inventory.takeItem(consumables.GLDRIND, returnToCampUseOneHour);
//}

//public function deerTFs():void {
	//var changes:int = 0;
	//var changeLimit:int = 2;
	//var temp:int = 0;
	//var x:int = 0;
	//if (rand(2) == 0) changeLimit++;
	//if (rand(3) == 0) changeLimit++;
	//if (pc.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
	//if (pc.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
	//// Main TFs
	////------------
	////Gain deer ears
	//if (rand(3) == 0 && changes < changeLimit && pc.earType != EARS_DEER) {
		//if (pc.earType == -1) output("\n\nTwo painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur.  ");
		//if (pc.earType == EARS_HUMAN) output("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears.  ");
		//if (pc.earType == EARS_DOG) output("\n\nYour ears change shape, morphing into from their doglike shape into deer-like ears!  ");
		//if (pc.earType > EARS_DOG) output("\n\nYour ears change shape, morphing into teardrop-shaped deer ears!  ");
		//output("<b>You now have deer ears.</b>");
		//pc.earType = EARS_DEER;
		//changes++;
	//}
	////Gain deer tail
	//if (rand(3) == 0 && changes < changeLimit && pc.earType == EARS_DEER && pc.tailType != TAIL_TYPE_DEER) {
		//output("\n\nYou feel a tightening just above your ass, as if a massive hand was pinching you.  It releases with a curious “pomf”-ing noise.  You turn this way and that, finally managing to crane your neck to see your <b>fluffy, flicking deer tail.</b>");
		//pc.tailType = TAIL_TYPE_DEER;
		//changes++;
	//}
	////Gain deer horns AKA antlers
	//if (rand(3) == 0 && changes < changeLimit && pc.hornType == HORNS_NONE) {
		//output("\n\nYou feel an immense pressure from your forehead, and you reach up, feeling the nubs of two new horns.");
		//pc.hornType = HORNS_ANTLERS;
		//pc.horns = 1;
		//changes++;
	//}
	//if (rand(3) == 0 && changes < changeLimit && pc.horns > 0 && pc.hornType != HORNS_ANTLERS) {
		//output("\n\nYou feel a strange twisting sensation from your horns as they extend outwards.  You reach up to feel them and realize that you’ve now got <b>pronged, stag-like horns.</b>");
		//pc.hornType = HORNS_ANTLERS;
		//pc.horns = 4;
		//changes++;
	//}
	////Increase points on deer antlers
	//if (rand(3) == 0 && changes < changeLimit && pc.hornType == HORNS_ANTLERS && pc.horns < 30) {
		//output("\n\nYou feel a strange twisting sensation from your antlers as they extend and split outwards.  You reach up to feel them and realize that your antlers are now even more branched out.");
		//if (pc.horns < 20 && rand(2) == 0) pc.horns += (1 + rand(4));
		//pc.horns++;
		//output("  After counting the number of points you have on your antlers, <b>you have " + pc.horns + " points.</b>");
		//if (pc.horns >= 30) output("<b>  It seems that your antlers can't get any more pointier.</b>");
		//changes++;
	//}
	////Gain fur
	//if (rand(4) == 0 && changes < changeLimit && pc.horns > 0 && pc.skinType != SKIN_TYPE_FUR) {
		//output("\n\nFor a moment, it looks like a ray of sunlight has shimmered through the canopy. You blink and realize that your fur has become dappled, with lighter, sun-speckled spots highlighting it.");
		//pc.skinType = SKIN_TYPE_FUR;
		//pc.skinAdj = "";
		//pc.skinDesc = "fur";
		//pc.furColor = "brown";
		//changes++;
	//}
	////Change face to normal
	//if (rand(3) == 0 && changes < changeLimit && pc.earType == EARS_DEER && (pc.faceType != FACE_HUMAN && pc.faceType != FACE_DEER)) {
		//output("\n\nYour face grows warm as suddenly your vision is engulfed in smoke, coughing and beating the smoke back you noticed a marked change in your features. Touching yourself you confirm you have a <b>normal human shaped face once again</b>.");
		//pc.faceType = FACE_HUMAN;
		//changes++;
	//}
	////Gain deer face
	//if (rand(4) == 0 && changes < changeLimit && pc.skinType == SKIN_TYPE_FUR && pc.earType == EARS_DEER && pc.tailType == TAIL_TYPE_DEER && pc.faceType != FACE_DEER) {
		//output("\n\nYou feel a grinding noise from your jaw, and a massive pressure in your sinuses, as your cheeks pinch in, followed immediately by a pointing of the lower half of your face.  You frantically (and gently) feel your face, discovering, to your surprise, that you’ve <b>gained the delicate facial features of a deer.</b>");
		//pc.faceType = FACE_DEER;
		//changes++;
	//}
	////Change legs to cloven hooves
	//if (rand(4) == 0 && changes < changeLimit && pc.earType == EARS_DEER && pc.tailType == TAIL_TYPE_DEER && pc.skinType == SKIN_TYPE_FUR && (pc.lowerBody != LOWER_BODY_TYPE_DEERTAUR && pc.lowerBody != LOWER_BODY_TYPE_CLOVEN_HOOFED)) {
		//if (pc.lowerBody == LOWER_BODY_TYPE_HOOFED) {
			//output("\n\nYou feel a sharp stinging sensation from your hooves, accompanied by a loud CRACK.  You look down in alarm, prancing from one hooved foot to another, realizing that your solid, heavy hooves have been replaced with delicate, cloven hooves.  You squint, also noting a subtle thinness across your legs in general--if you had to guess, you’d hazard that you’re looking <b>more deer-like than horse-like</b>.");
		//}
		//else {
			//output("\n\nYou feel a strange tightness from your feet and nearly topple over as your balance shifts.  You’re balancing on your toes for some reason.  You look down in amazement as your legs slim and lengthen, your feet elongating and darkening at the ends until you’re balancing on <b>two, graceful deer legs</b>.");
		//}
		//if (pc.isTaur()) pc.lowerBody = LOWER_BODY_TYPE_DEERTAUR;
		//else pc.lowerBody = LOWER_BODY_TYPE_CLOVEN_HOOFED;
		//changes++;
	//}
	//// Genital Changes
	////------------
	////Morph dick to horsediiiiick
	//if (rand(3) == 0 && changes < changeLimit && pc.cocks.length > 0) {
		//var selectedCockValue:int = -1; //Changed as selectedCock and i caused duplicate var warnings
		//for (var indexI:int = 0; indexI < pc.cocks.length; indexI++)
		//{
			//if (pc.cocks[indexI].cockType != CockTypesEnum.HORSE)
			//{
				//selectedCockValue = indexI;
				//break;
			//}
		//}
		//if (selectedCockValue != -1) {
			////Text for humandicks or others
			//if (pc.cocks[selectedCockValue].cockType == CockTypesEnum.HUMAN || pc.cocks[selectedCockValue].cockType.Index > 2) output("\n\nYour " + pc.cockDescript(selectedCockValue) + " begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
			////Text for dogdicks
			//if (pc.cocks[selectedCockValue].cockType == CockTypesEnum.DOG) output("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd...  You pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond its traditional size.  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.  <b>Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + "</b>, and you jerk yourself off, splattering thick ropes of cum with intense force.");
			//pc.cocks[selectedCockValue].cockType = CockTypesEnum.HORSE;
			//pc.increaseCock(selectedCockValue, 4);
			//dynStats("lib", 5, "sen", 4, "lus", 35);
			//output("<b>  You now have a");
			//if (pc.horseCocks() > 1) output("nother");
			//output(" horse-penis.</b>");
			//changes++;
		//}
	//}
	//// Body thickness/tone changes
	////------------
	//if (rand(3) == 0 && pc.tone > 20) {
		//if (pc.tone > 50) pc.modTone(20, 2 + rand(3));
		//else pc.modTone(20, 2);
	//}
	//if (rand(3) == 0 && pc.thickness > 20) {
		//if (pc.thickness > 50) pc.modThickness(20, 2 + rand(3));
		//else pc.modThickness(20, 2);
	//}
	//flags[kFLAGS.TIMES_TRANSFORMED] += changes;
//}