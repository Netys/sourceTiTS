import classes.Characters.CoC.CoCHarpy;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Kiri -- [Talk]
public function talkToKiri():void {
	clearOutput();
	output("You ask Kiri if she wouldn't mind sharing a bit of information with you.");
	output("\n\n\"<i>Of course,</i>\" she says pleasantly, \"<i>that's what I'm here for!  What do you want to know?</i>\"");
	processTime(1);
	//(Display Options: [Hel] [Harpies] [Salamander] [Kiri])
	clearMenu();
	addButton(0, "Hel", askKirkAboutHel, undefined, "Hel", "Ask Kiri how she knows Helia.");
	addButton(1, "Harpies", askKiriAboutHarpies, undefined, "Harpies", "Ask Kiri about the harpies in the tower.");
	addButton(2, "Salamander", askKiriAboutSalamander, undefined, "Salamander", "Ask Kiri about the salamander prisoner.");
	addButton(3, "Kiri", askKiriAboutKiri, undefined, "Kiri", "Ask Kiri if she can tell you a bit about herself.");
	addButton(14, "Back", mainGameMenu);
}

//Kiri -- [Talk] -- [Hel]
public function askKirkAboutHel():void {
	clearOutput();
	output("You ask the harpy girl how she knows Hel, exactly.");
	output("\n\n\"<i>Oh, uh,</i>\" she starts nervously, obviously taken aback by your question.  \"<i>I've known Miss Helia for quite a while now. She saved my life a couple of years ago, and, well, we've been friends ever since.  When I realized what was going on here - who the salamander in the dungeon was - I couldn't help but try and tell her what's up.</i>\"");

	output("\n\nKnowing Hel as well as you do, you venture to ask Kiri if she and Hel are just friends.");
	output("\n\n\"<i>Wha - what!?</i>\" she stammers, aghast.  \"<i>I, we, uh, I mean... Gah.</i>\"  She slumps her shoulders.  \"<i>Yeah, I guess you could say that. It's not like we're in love or anything, but, you know...</i>\" The harpy trails off with a light shrug.  \"<i>She's been good to me.</i>\"");
	processTime(2);
	clearMenu();
	addButton(0, "Next", talkToKiri);
}

//Kiri -- [Talk] -- [Harpies]
public function askKiriAboutHarpies():void {
	clearOutput();
	output("You ask Kiri about the harpies remaining in the tower and their relative strength and position - anything to give you an advantage.");
	output("\n\n\"<i>Right, yeah, Hel asked me to scout around and remember that stuff.  Uh... Oh yeah!</i>\" she clears her throat and begins to recite:  \"<i>Dungeon Level: Brigid the Jailer, salamander prisoner.  Mezzanine: Phoenix Heavy Infantry unit, trained but inexperienced.  Second Floor: Honor Guard, elite bodyguards; and our Broodmother, Calais, queen of the tower.</i>\"");
	output("\n\nYou nod, then ask, \"<i>Phoenixes?</i>\"");
	output("\n\n\"<i>Oh, yes... That's what Hel is here to stop, I think.  They're the half-breeds mother has made with the salamander prisoner down below.</i>\"");
	processTime(2);
	clearMenu();
	addButton(0, "Next", talkToKiri);
}

//Kiri -- [Talk] -- [Salamander]
public function askKiriAboutSalamander():void {
	clearOutput();
	output("You ask her about the salamander prisoner you're here to help free.");
	output("\n\n\"<i>Oh, yeah...</i>\" Kiri says nervously \"<i>About that...</i>\"");
	output("\n\nUh-oh.");
	output("\n\n\"<i>No, no!  He's fine! Er, well, as fine as he can be, all things considered.  I just... uh... thought you should know: his name is Hakon en Kahlesin.  He's Hel's dad.  And mine.</i>\"");
	output("\n\nWell, shit.");
	output("\n\n\"<i>Hel doesn't know yet... I didn't want her to lose her head or do something reckless.  But, yeah, that's dad down there.  I just wish... I could have done something more to help him.</i>\"");
	output("\n\nYou ask how you can free him.");
	output("\n\n\"<i>Mother keeps the key to his hand shackles on her at all times.  Brigid has the one for his legs.  You'll need to defeat both to free him.</i>\"");
	processTime(2);
	clearMenu();
	addButton(0, "Next", talkToKiri);
}

//Kiri -- [Talk] -- [Kiri]
public function askKiriAboutKiri():void {
	clearOutput();
	output("You ask Kiri to tell you a little about herself.");
	output("\n\n\"<i>Who, me? Oh, I'm nobody special, really...</i>\" she says with a self-conscious chuckle.");
	output("\n\nYou urge her to tell you something anyway.");
	output("\n\n\"<i>Well, I guess you could say I'm a half-breed, of sorts.  My dad's the salamander downstairs, mom's the broodmother you're going to fight in a bit.  Mom hadn't quite figured out the magic she needed to produce the phoenixes when I was born - I didn't turn out quite right.  I'm really just a harpy.  Nothing special.</i>\"");
	output("\n\nShe doesn't seem to want to say more, so you shrug and carry on.");
	processTime(2);
	clearMenu();
	addButton(0, "Next", talkToKiri);
}

// Kiri -- [Sex] (Intro)
public function kiriSexIntro():void {
	clearOutput();
	clearMenu();
	output("You ask Kiri if she could help you blow off some steam.");
	if (flags["COC.HEL_TOWER_KIRI_SEXED"] == undefined) {
		output("\n\n\"<i>Wha-WHAT!?</i>\" she yelps, recoiling.  \"<i>Hey, look, I owe Hel big time, but I never agreed to do... to do that!  You... no way!</i>\"");
		output("\n\nYou remind Kiri that here in Mareth an errant tease or stroke of skin can mean the difference between victory and being raped if you're too horny.  And, she promised Hel she'd help you...");
		output("\n\n\"<i>I... but... that's not fair!</i>\" she groans.  She hangs her head and sighs.");
		output("  \"<i>I guess I wouldn't want you getting raped and imprisoned as a breeding slut hanging over my head all my life.  Fine!  Just... use me however you need to.  But be gentle, okay?</i>\"");
	} else {
		output("\n\n\"<i>What, again?</i>\" she chuckles. \"<i>I guess it wasn't bad last time. But be gentle, okay?</i>\"");
	}
	//if (!pc.hasGenitals()) output("Unfortunately, there's not much she can do for you...");
	//(Display Options:
	//If Male: [Anal]
	//If Female [Get Licked]
	//If Genderless: \"<i>Unfortunately, there's not much she can do for you...</i>\"
	clearMenu();
	if (pc.hasCock()) addButton(0, "Anal", kiriSexAnal, undefined, "Anal", "Put your [pc.oneCock] into Kiri's ass!");
	else addDisabledButton(0, "Anal", "Anal", "This scene requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "Get Licked", kiriSexGetLicked, undefined, "Get Licked", "Have Kiri lick your [pc.vagina].");
	else addDisabledButton(1, "Get Licked", "Get Licked", "This scene requires you to have vagina.");
	addButton(14, "Back", talkToKiri);
}

//Kiri -- [Sex] -- [Anal]
public function kiriSexAnal():void {
	var capacity:Number = new CoCHarpy().analCapacity();
	clearOutput();
	var x:Number = pc.cockThatFits(new CoCHarpy().analCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	output("You whip your [pc.cock " + x + "]");
	if(!pc.isCrotchExposed()) output(" out of your [pc.lowerGarmentOuter]");
	output(" and tell Kiri to get on all fours.  She grimaces, but does as you ask.  You hike up her shift to reveal her large, egg-laying pussy and her tight little pucker.");
	output("\n\n\"<i>Just make sure you pull out, all right? I don't wanna get pregnant - EEEP!</i>\" she shrieks as your [pc.cock " + y + "] pokes against her backdoor.  Her wings beat furiously around you, nearly lifting you both off the ground.  You give her a swat on the ass to help her get a grip as you take hold of her inhumanly wide hips.  She wriggles around for a bit before finally calming down and trying to relax as best she can.");
	output("\n\nIt takes some doing, but you eventually manage to push your prick in past her tight sphincter.  With a relieved sigh, you start to push into her ass, slowly but steadily feeding her inches of your [pc.cock " + x + "] until ");
	if (pc.cockVolume(x) > capacity) output("you can fit no more in");
	else output("you are buried to the hilt");
	output(".  Beneath you, Kiri writhes and groans in pained pleasure as you stuff her ass full of your cock.  When you've finally buried yourself as far as you'll go, you give her lush ass cheeks a little squeeze and start to rock your hips.  Kiri gasps, suddenly feeling empty as you withdraw from inside her - and screams when you slam yourself back in.");
	output("\n\nSinking your hands into her soft, plush butt, you start to hammer her asshole, fucking her hard and fast until you're both moaning like whores.  Your combined pre-cum and juices are staining the floor and her inner walls.  To your surprise, Kiri lifts herself off the ground and presses her back to your chest, letting her wings wrap around you.  Grinning, you grope her perky breasts as you continue to ream her ass.  She puts her hands on yours, pinching her nipples and guiding you to all her most sensitive spots.");
	output("\n\nYou cum quickly, grunting into her ear and ramming yourself until you're ");
	if (pc.cockVolume(x) > capacity) output("as far in as you can manage");
	else output("filling her completely");
	output(".  Your cock squirts a thick load inside her, shooting [pc.cumVisc] ropes of jizz deep into her bowels ");
	//[if High Cum Production: 
	if (pc.cumQ() > 500) output("until your [pc.cumNoun] squelches back out around your cock and onto the floor");
	output(".  With a scream of delight, Kiri clamps down on your [pc.cock " + x + "] and climaxes too, leaking a pool of fem-spunk onto the ground.  She starts to bounce on your cock, riding out her anal orgasm until she's exhausted and you're deflated inside her.");

	output("\n\nYou pull out with a POP, letting a stream of [pc.cum] leak out her butt.  You clean your cock off and stick it back in your [pc.gear].");
	flags["COC.HEL_TOWER_KIRI_SEXED"] = 1;
	processTime(20);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Kiri -- [Sex] -- [Get Licked]
public function kiriSexGetLicked():void {
	clearOutput();
	output("You ask Kiri to eat you out. She grimaces but drops to her knees and undoes the bottom of your [pc.gear], revealing your [pc.crotch].  With a word of encouragement from you, she leans forward and presses her face into your groin, letting her tongue loose to explore your lower lips.");
	output("\n\nThe girl's tongue is surprisingly skilled.  She quickly teases it across your clitty, making you moan with unexpected pleasure.  She begins to tease and play with your pleasure buzzer, using the flat of her tongue to tickle the sensitive flesh around it; you urge her on with little pats of the head and shoulders, even reaching down to cup one of her perky breasts beneath her loose shift or stroke one of her great orange wings.");
	output("\n\nShe finally slips her tongue in and starts to caress the walls of your [pc.vagina], running her soft, warm tongue along your innermost depths with delightful speed and gentleness.  You smile and run your hands through her short orange hair, stroking her as she grips your hips and buries her face in your twat.");
	output("\n\nYou begin to grind your slit into her face as she eats you out, rubbing your cunt along her nose and forehead to the beat of her tongue's skillful ministrations.  She makes a slow, steady progression inward, slipping her long tongue further and further into your cunny until you can feel her flicking around your cervix.");
	output("\n\nYou cannot resist her skillful tongue-fuck for long.  Grabbing Kiri's head, you force her face into your crotch, getting every last bit of her tongue inside you as you can as you climax, spraying your [pc.girlCum] all across her face.");
	output("\n\nUtterly satisfied, you stagger back from Kiri, letting her whip her head around to flick off your [pc.girlCumNoun].  You clean yourself off and suit up again.");
	flags["COC.HEL_TOWER_KIRI_SEXED"] = 1;
	processTime(20);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}