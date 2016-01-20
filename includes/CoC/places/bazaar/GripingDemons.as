import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

private function overHearDemonsAboutSyrena():void {
	clearOutput();
	if(flags["COC.GRIPING_DEMONS_STATUS"] == 0) {
		output("A whisper of conversation catches your ear while you're wandering the bazaar, and overcome by curiosity, you veer towards it.\n\n");
		output("As you're closing in on the voices, the dialogue grows clear enough to understand.\n\n");
		output("\"<i>-old him if he doesn't finish this week's experiments, she's going to drop him into a submission tank instead of the champion!</i>\" exclaims the first voice, sounding quite feminine.\n\n");
		output("A baritone response rings out, \"<i>You're shitting me!  Syrena's off her fucking rocker if she thinks Lethice will let her turn another of our researchers into a gibbering slut.  We've got enough of those.</i>\"\n\n");
		output("\"<i>Well, what do you expect?  She's more shark than demon... I'm amazed she gets anything done at all, with as much time as she spends fucking me.  Don't get me wrong, that double-thick dick makes my cunny fuckin' drool, ya know?  But, at the same time, if I could just get some more information on her research, I could have her job.  Then she'd be serving MY desires... yum,</i>\" trails off the sultry, seductive tone.\n\n");
		output("The male laughs and says, \"<i>You belong underneath a fat dick, bitch.  Look at you, you've got strings of lube trailing on the ground behind you.  You're too busy slutting it up to accomplish anything.  I'm thinking I had better head back to the lab, though.  I don't want to wind up looking like one of the escaped factory rejects - gotta keep this perfect bod, ya know?</i>\"\n\n");
		output("You get a good look at the two when the crowd parts, and wow, that incubus is right.  He's a curly-haired, chiseled Adonis of a man, with a bulge as over-the-top of the rest of him straining at his fashionable pants.  The demon fiddles with his collar, popping it up, and he turns to leave.  The other commiserating devil is a busty succubus in a lab coat... nothing else.  She's even wetter than her companion's words would indicate, painting a thick trail of slippery girl-slime in her wake as she moves.  The succubus' nipples are like two hard bullets, soaking two glorious wet patches into her coat as she argues back.\n\n");
		output("\"<i>S-shut up.  That cunt tested some of her prototype compounds on me, remember?  That stuff turned my pussy into an insatiable furnace.  If I can get some free time... I'll... I'll... oh screw it, let's go rent a room and fuck a few times before we go back.  I'll want to be thinking clearly when I face her.  Syrena won't get to gloat about me jumping on her fat... juicy... mmm... cock... this time!</i>\"  The succubus takes the incubus' hand and drags him away in a hurry.\n\n");
		output("Well, that explains a lot.  The demons seem to have an active research department, though the one called Syrena does not seem to please her underlings very much.  Then again, you doubt any demonic servants are pleased with their bosses.  You can't wait to put a stop to their labors, but for now, there's nothing to do but use the bazaar or go home.\n\n");
	}
	//[Listen in repeat]
	else if(flags["COC.GRIPING_DEMONS_STATUS"] == 1) {
		output("Just as before, you spot the collar-popping incubus and his lab coat-clad lover complaining about their boss.\n\n");
		output("\"<i>-still sore!  I can't believe she did that to me!</i>\" groans the male.\n\n");
		output("Smiling cruelly, the slick-pussied succubus says, \"<i>You deserved it.  Honestly, you turned in cum-stained reports to your boss, and you're surprised that she took your ass for a ride as punishment?  If you ask me, you planned all this.  Who do you think had to clean up the huge mess you left on the floor?</i>\"\n\n");
		output("For once, the incubus seems speechless.  He mutters, \"<i>Well, I didn't plan it.  I-I was just having fun with one of the new slaves - for inspiration - while I finished up the paperwork.</i>\"  He looks over and punches the leering female's arm.  \"<i>Besides, I thought you liked cleaning up my cum?  I've never seen you complain before.</i>\"\n\n");
		output("The succubus laughs and slaps his ass as she answers, \"<i>Don't worry, you taste great... just not as good as the boss.  I dunno what concoction she made that did it, but her spunk is heavenly.  I could just... mmm... swallow that delicious cream all day long.  Do ya think she's part minotaur?</i>\"\n\n");
		output("\"<i>Babe, you're sliming everywhere again.  Why don't we go blow off some steam?</i>\"  The two horny demons run off and disappear.\n\n");
	}
	//[Listen in Repeat 2]  
	else if(flags["COC.GRIPING_DEMONS_STATUS"] >= 2) {
		output("This time, the two chatty demons are seated near the fire, and the reason for their altered location seems clear.  The succubus' belly is gravid to an unusual degree, utterly packed with some kind of corrupted offspring.  She's rubbing both her hands over the stretched skin-dome and moaning in discomfort, the packed womb squirming beneath her touches.\n\n");
		output("Meanwhile, the male incubus is knocking back a beer, grumbling, \"<i>Could you take it down a notch?  It isn't like this is the first time you've had to lug around a load of imps - don't be so melodramatic.</i>\"\n\n");
		output("His pregnant companion growls and tugs at her undersized labcoat, failing to conceal the blueberry-colored bulge of her belly from him as she retorts, \"<i>You didn't have to get all these fucked into you, now did you?  Hell, she even shot me up with fertility-plus first!  It feels like there's two dozen of the little bastards packed in there!  I figure in another day or two I won't even be able to walk.</i>\"\n\n");
		output("\"<i>So does that mean you won't mind if I stop by whilst you're laid up?  I mean you can't get any more pregnant with imps, and it might pass the time,</i>\" suggests the well-muscled male.\n\n");
		output("Smirking, the demoness retorts, \"<i>Sure, but next time you fuck up, I'm loaning Syrena some of my girly stuff to make you suffer just like this.</i>\"  Her hands both point at the imp-engorged skin of her midsection for emphasis.\n\n");
		output("The incubus rises and taunts, \"<i>If I fucked up as often as you did, I'd be feeding the furnace in a factory somewhere or fed to the hellhounds.  Come on, let's get you home before I have to roll you back.</i>\"\n\n");
		output("Unwilling to allow herself to be helped, the succubus staggers up and begins waddling away.  The incubus keeps his distance, wearing a predatory grin.\n\n");
	}
	
	IncrementFlag("COC.GRIPING_DEMONS_STATUS");
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu, false);
}