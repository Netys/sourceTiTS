import classes.Characters.CoC.CoCHarpyQueen;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Melee.CoCEldritchStaff;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get harpyQueen():CoCHarpyQueen {
	return new CoCHarpyQueen();
}

//HARPY QUEEN -- PC DEFEATED
public function harpyQueenBeatsUpPCBadEnd():void {
	clearOutput();
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	//HARPY BREEDING SLUT BAD END
	output("You collapse in front of the Harpy Queen, sitting upon her throne.  She isn't particularly tall or menacing looking, but her hips are truly inhuman, thrice as wide as she is at the least, and her pillowy ass, seated upon her cushions, seems canyon-like in her nudity, the type of butt you could lose yourself in forever.  The harpy matron wields a tall whitewood staff, held in the crook of her arm.");
	output("\n\n\"<i>Well, well, what do we have here?</i>\" the harpy croons, licking her lips as she stares down at you.  Defeated, you are utterly helpless.  A pair of her brood step from the shadows and bind you, tying your arms and [pc.legs] in thick leather straps.");
	output("\n\n\"<i>So, an interloper wanders into my nest.  Tell me, fool, are you working for the demons?  Surely you must be.  No one else would dare come here...</i>\"");
	output("\n\n\"<i>Mother!</i>\" a harpy calls, stepping up to the throne. Behind her come another dozen sisters, struggling to keep Hel bound between them.  The salamander screams and curses and cries, but it is useless - she cannot escape, any more than you can.  Hel is pushed down onto her knees beside you, still defiant, but, at seeing you already captured... the fight goes completely out of her eyes.");
	output("\n\n\"<i>Ah, another salamander?  Well well, what a coincidence.  I don't believe our other specimen is going to last much longer.  You seem a healthy girl; with a bit of... modification... you'd make a fine replacement.</i>\"");
	output("\n\n\"<i>And you,</i>\" the queen says, looking back to you.  \"<i>I could always use another ");
	if (pc.hasCock()) output("sperm bank");
	else output("incubator");
	output(" in my harem.  Yes, you'll do nicely...</i>\"");
	output("\n\n<b>SIX MONTHS LATER...</b>\n");
	output("You groan, your wrists chafing in the manacles hanging overhead.  The harpy slut riding your huge, engorged dick crosses her eyes, screams, and cums.  Another wave of seed lurches out of your cripplingly-large balls, so massive that they drag on the floor between your [pc.legs].  You shudder slightly, but the act of ejaculation has lost all meaning");
	if (!pc.hasCock()) output(", even if the sudden new sensations nearly broke your mind when the harpies used their magics to grow these huge male implements on your body");
	output(".  Indeed, as soon as that slut's gotten her fill, one of her sisters pushes her roughly off your shaft and mounts you, bending over and backing into your massive schlong.  A little shudder of pleasure courses up your body as the twenty-ninth slut you've serviced today starts to milk you for your magically-enhanced seed.  The tubes pumping enchanted drugs directly into the flesh of your testes goes into overtime, flooding your system with lust and the strange concoction that creates the Phoenixes.");
	output("\n\nYou slump as another orgasm plows through you, swelling the harpy's womb until she looks nine months pregnant.  You barely feel it, though your skin flushes hotly as the woman plants a lust-stick kiss on your lips in thanks... Another salamander male was what the Queen needed; you weren't it, but with Hel and the captive that turned out to be her father around, she found use for you, too: breeding harpies to continue her bloodline while the phoenixes go off to war against the demons.");
	output("\n\nYou gaze across the subterranean breeding chamber, over tables and toys covered in gallons of spent semen, to where Helia and Hakon the salamanders are chained.  Hakon has long since passed out, his age and years of abuse weakening him to the point where he can only function a small part of the day.  Beside him, though, Hel is awake and kicking, struggling futilely under the huge girth of the Harpy Queen's hips which pin her to the wall in place of chains.");
	output("\n\nHel cries out, a full-body orgasm rocking through her tall frame, ending in the magically-endowed pecker between her legs, just like yours, buried to the hilt inside the broodmother harpy.  The Queen coos, rubbing the gaping hole of her twat as a waterfall of salamander cum oozes out of her, pooling on the floor with the leavings of the last dozen of Hel's orgasms.  Despite the orgasm subsiding from your once-lover, the Harpy Queen remains firmly impaled on Hel's giant wang, grinding her hips around in wide circles, her breeding tunnel slurping up every drop of salamander sperm it can.  Finally, she pulls herself off in a long, languid motion, slowly working off the cunt-stretching tool inside her until it flops groundward, still leaking a tiny dribble of cum.  Eagerly, a half-dozen lesser harpies jump toward Hel's used cock, lapping up the leftovers from the Queen's use in hopes of birthing a phoenix of their very own.");
	output("\n\nThe Harpy Queen stretches her wings wide as she steps away from Hel, now already being mounted by one of the Queen's daughters, and saunters over to you, salamander seed still freely leaking from her gaping egg-hole. She cups your cheek, sliding her long fingers across your sensitive, thoroughly drugged skin. Your entire body tingles as she smiles upon you, barely aware of the half-dozen sluts slurping at your spent seed as one of her daughters forces herself onto your enhanced member.");
	output("\n\n\"<i>You've been a good stud since you came to me, [pc.name],</i>\" the Queen laughs airily, patting your swollen nuts.  \"<i>The size of my brood has quadrupled since you and Hel 'volunteered' to help us.  Mmm, a free Mareth will surely have you to thank for the army that will liberate it from the demons.  You might even be something of a hero, if you want. The Champion of Free Mareth, if you will.  That wouldn't be so bad, would it?  After all, that's why you came here...</i>\"");
	output("\n\nBefore you can respond, another orgasm washes over you, and a huge load of seed explodes into the thirty-first slut to claim your seed today.  And over her shoulders, you can see dozens more harpies, half of them your own spawn, waiting their turn.");
	badEnd();
}

//HARPY QUEEN -- PC VICTORIOUS
public function harpyQueenDefeatedByPC():void {
	clearOutput();
	output("With a final, loud gasp, the Harpy Queen collapses into her throne, unable to oppose you further.  Seeing their broodmother defeated, the other harpies that had been swarming around the room suddenly break off their attack and retreat, edging back to the fringes of the throne room.  Behind you, Hel stumbles out of the melee, covered in little cuts and bruises, but seeming otherwise unhurt.");
	output("\n\n\"<i>Y-you'll ruin everything,</i>\" the Harpy Queen groans, trying futilely to stand.  Before she can recover, Hel walks over and plants her clawed foot right on the bitch's chest, pinning her down.  From a small hook on the side of the throne, you take her key-ring for the prisoner down below.");
	//(Acquired Key Item: \"<i>Harpy Key B</i>\")
	pc.createKeyItem("Harpy Key B");
	flags["COC.HEL_HARPY_QUEEN_DEFEATED"] = 1;
	flags["COC.TOOK_QUEEN_STAFF"] = 1; // in loot now
	//(PC moves to Throne Room Main Menu:)
	
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//Throne Room -- [Helia]
public function HeliaThroneRoom():void {
	clearOutput();
	clearMenu();
	output("You turn your attentions to the salamander, who is currently pinning down the harpy bitch to prevent her from flying off or doing something drastic.");
	output("\n\n\"<i>Hey, [pc.name],</i>\" Hel says as you approach.  She grabs you roughly by the [pc.gear] and pulls you into a long kiss, only breaking it to wrap her arms and tail around you.  \"<i>Thank you, lover.  From the bottom of my heart.  I couldn't have done it without you.</i>\"");
	
	output("\n\nYou pat her on the head and tell her it was your pleasure.");
	
	output("\n\nShe grins.  \"<i>So, what's the plan, lover mine?  Teach this bitch a lesson she'll never forget?</i>\"");
	//(Display Options: [Hakon](if PC knows this) [Kiri] [Queen](If not dead/gone))
	processTime(2);
	clearMenu();
	if (flags["COC.HEL_PC_TALKED_WITH_HAKON"] != undefined) addButton(0, "Hakon", heliaHakonTalk, undefined, "Hakon", "Ask Helia about Hakon, the salamander you've found in the dungeon.");
	addButton(1, "Kiri", heliaKiriTalk, undefined, "Kiri", "Ask Helia about Kiri, the half-breed girl.");
	if (flags["COC.HARPY_QUEEN_EXECUTED"] == undefined) addButton(2, "Queen", heliaQueenTalk, undefined, "Queen", "Ask Helia about the Harpy Queen.");
	addButton(14, "Back", mainGameMenu);
}

//Throne Room -- [Helia] -- [Hakon]
public function heliaHakonTalk():void {
	clearOutput();
	output("You decide to tell Hel who, exactly, is chained up downstairs.  When you do, she simply stares at you, wide-eyed.");
	output("\n\n\"<i>Wha... what. No, that's not... It can't be...</i>\"");
	output("\n\nYou assure her that it's true. The salamander she came here to rescue is none other than father, Hakon.");
	output("\n\n\"<i>I don't believe it,</i>\" Hel says, rubbing at the corners of her eyes.  \"<i>I thought all these years... I was sure he was dead.  How... No.  It doesn't matter,</i>\" she says, turning to the broodmother beneath her.");
	if (flags["COC.HARPY_QUEEN_EXECUTED"] == undefined) output("  \"<i>You're going to pay for what you did to my father, you bitch.  I promise you that.</i>\"");
	flags["COC.HEL_KNOWS_ABOUT_HAKON"] = 1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", HeliaThroneRoom);
}

//Throne Room -- [Helia] -- [Kiri]
public function heliaKiriTalk():void {
	clearOutput();
	output("You ask Hel about the half-breed girl that helped the two of you find this place, and offered you information below.");
	output("\n\n\"<i>Oh! You met Kiri? That's great, [pc.name].</i>\" With a little chuckle, Hel adds, \"<i>She's a cutie, isn't she?  Nice ass, too.</i>\"");
	output("\n\nYou smack your face with your palm and ask for something a little more concrete about her.");
	output("\n\n\"<i>Oh, right.  I met her a couple years back, when she was just a little shit.  Momma bird here hadn't quite gotten the phoenix formula down, I guess.  Anyway, some minotaur had gotten a hold of her, was gonna drag her back home and pump her full of minitaurs or whatever.  Probably 'cause she's so red, you know?  'Taurs hate that color for some reason.</i>\"");
	output("\n\n\"<i>So, I bopped the bull on the head and saved her.  More to keep down the 'taur population than actually help her, but hey.  She certainly appreciated it.  Been friends ever since.</i>\"");
	output("\n\nWith a knowing look, you ask if they're more than just friends.");
	output("\n\n\"<i>" + pc.mf("Dude","Babe") + ", come on, you know me.  Give me SOME credit, will ya?  I'm not letting an ass like that go to waste.</i>\"");
	output("\n\nYou roll your eyes and laugh with her.");
	processTime(2);
	clearMenu();
	addButton(0, "Next", HeliaThroneRoom);
}

//Throne Room -- [Helia] -- [Queen]
public function heliaQueenTalk():void {
	clearOutput();
	output("You nod your head toward the great big-booty broodmother.  \"<i>Ah, the queen cunt herself,</i>\" Hel says ruefully, cracking her knuckles.  \"<i>We're gonna have some fun with you, little birdie...  Aren't we, [pc.name]?</i>\"");
	output("\n\nYou ask Hel exactly what she thinks you ought to do with the 'queen cunt.'");
	output("\n\n\"<i>Well, we can start by me shoving my tail so far up her twat that she'll never have kids again.  That's a goddamn start.</i>\"");
	//[If PC has already told her about Hakon: 
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == 1) output("  \"<i>Maybe snap her neck afterwards.</i>\"");
	processTime(2);
	clearMenu();
	addButton(0, "Next", HeliaThroneRoom);
}

//Throne Room -- [Harpy Queen]
public function harpyQueenAdvantage():void {
	clearMenu();
	clearOutput();
	output("You loom over the defeated Harpy Queen, who squirms underneath Hel's foot on her chest.");
	output("\n\n\"<i>Fool!</i>\" she spits.  \"<i>Kill me and be done with it! I'll not be used by the likes of you, demon-lover!</i>\"");
	output("\n\nWhat.");
	//(Display Options: [Fuck Her] [Interrogate] [Kill Her] [Let Her Go])
	processTime(1);
	clearMenu();
	addDisabledButton(0, "Fuck Her", "Fuck Her", "This scene requires you to have cock and sifficient arousal.");
	if (pc.lust() > 33 && pc.hasCock()) addButton(0, "Fuck Her", fuckHarpyQueen, undefined, "Fuck Her", "Fuck the Harpy Queen with your penis. You're sure Helia can join you as well.");
	addButton(1, "Interrogate", harpyQueenInterrogate, undefined, "Interrogate", "Ask the Harpy Queen why she kidnapped a salamander.");
	addButton(2, "Kill Her", killHarpyQueen, undefined, "Kill Her", "Finish the Harpy Queen off for once." + (silly ? " Give her the Bad End!" : ""));
	addButton(3, "Let Her Go", letHarpyQueenGo, undefined, "Let Her Go", "Let the Harpy Queen go.");
	addButton(14, "Back", mainGameMenu);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go]
public function letHarpyQueenGo():void {
	clearOutput();
	output("You tell Hel to let up. You're letting the bitch go.");
	output("\n\n\"<i>What.</i>\" Hel says, deadpan.");
	output("\n\n\"<i>Move your damn foot!</i>\"");
	output("\n\n\"<i>What's this?</i>\" the broodmother asks, \"<i>Mercy? Why?</i>\"");
	output("\n\nYou tell her that you're no demon-loving bastard. To prove it, you're going to let her go.");
	output("\n\n\"<i>Just... like that?</i>\"");
	output("\n\nJust like that.");
	output("\n\nYou nod for Hel to get off.  She does so grudgingly, letting the Harpy Queen stand and roll her shoulders, spreading her great wings wide.");
	output("\n\n\"<i>Hmm. You're a fool, Champion,</i>\" she says, \"<i>But perhaps I was wrong about you.  Come, my children!  We are leaving this place!</i>\"");
	//[If you told Hel about Hakon:]
	processTime(4);
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == 1) {
		output("\n\nThe harpies beat their wings and croon happily, eager to be away from you.  As the Harpy Queen is ready to take off, she gives you an appreciative nod, with what might have even been a smile.  It looks as though you've made a friend tod-- OH FUCK!");
		output("\n\nYou try and yell out, but too late. Hel has lunged forward and, grabbing the broodmother by the neck, spins around.  The sound of neck bones snapping echoes through the tower as the queen falls, hitting the floor with a wet thump.");
		output("\n\n\"<i>Bullshit,</i>\" Hel snaps, wringing the dead queen's neck under her arm.  The other harpies around you shriek in outrage, pain, and fear.  \"<i>Do you have ANY IDEA what this bitch did?  To my father--to me?  There was no fucking way I was going to just let her walk off.  No, [pc.name]. No way.</i>\"");
		//awardAchievement("Accomplice", kACHIEVEMENTS.DUNGEON_ACCOMPLICE, true, true);
		//(Display Options: [Forgive] [Berate])
		clearMenu();
		addButton(0, "Forgive", harpyQueenLetHerGoForgive, undefined, "Forgive", "Forgive Helia for slaying the Harpy Queen.");
		addButton(1, "Berate", harpyQueenLetHerGoBerate, undefined, "Berate", "What the hell? You want to let the Harpy Queen go but Helia killed her! Berate Helia for her deeds.");
		flags["COC.HARPY_QUEEN_EXECUTED"] = 1;
	}
	//[Else; did not tell about Hakon]
	else {
		output("\n\nYou stand aside and watch the harpies beat their wings and croon happily, eager to be away from you.  As the Harpy Queen is ready to take off, she gives you an appreciative nod, with what might have even been a smile.  It looks as though you might have made a friend - or at least, lost an enemy.  With a wave, the Harpy Queen commands her children to fly!");
		output("\n\nShe turns to you, and says, \"<i>For better or worse, [pc.name], we will meet again.</i>\"");
		output("\n\nWith that, the harpies take flight.");
		//(Return PC to Room Menu)
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		flags["COC.HARPY_QUEEN_EXECUTED"] = -1;
	}
	pc.cor( -5);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go] -- [Forgive]
public function harpyQueenLetHerGoForgive():void {
	clearOutput();
	output("You and Hel stare each other down, the dead harpy's body the only thing separating you.  Two dozen enraged harpies screech and caw around you, demanding justice for their fallen queen.");
	output("\n\n\"<i>Alright, Hel. Fine.</i>\"");
	output("\n\nHer eyes light up.  Not the reaction she was expecting, it seems.  \"<i>So... we're good?</i>\"");
	output("\n\nYou nod.");
	output("\n\nShe stands up from the body and wraps you in a tight hug. \"<i>...Thank you.</i>\"");
	output("\n\nYou pat Helia on the head and with a shout, tell the harpies to get lost.  They do so reluctantly, too afraid to fight you, but still outraged at the murder.  They take flight, hurtling out the hole in the ceiling crying curses and epitaphs behind them.");
	output("\n\n\"<i>Alright. You've got the key, so go break ");
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == 1) output("Dad ");
	else output("that poor salamander ");
	output("out of the dungeon.  I'll make sure the phoenixes and harpies don't give you two trouble on the way out.</i>\"");
	output("\n\nWith that, Hel trots out the door and down the stairs, leaving you alone in the room.");
	if(flags["COC.TOOK_QUEEN_STAFF"] == undefined) output(" You notice that the queen's staff has fallen beside her body.");
	//(Return to Room Menu)
	processTime(4);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go] -- [Berate]
public function harpyQueenLetHerGoBerate():void {
	clearOutput();
	output("You and Hel stare each other down, the dead harpy's body the only thing separating you.  Two dozen enraged harpies screech and caw around you, demanding justice for their fallen queen.");
	output("\n\n\"<i>Hel, what the fuck!?</i>\" you yell.  That was NOT okay--you told the bitch she could leave, and then Hel just MURDERS her; what the FUCK?");
	output("\n\n\"<i>Of course you wouldn't understand,</i>\" Hel snaps, dropping the dead queen as she stands.  \"<i>Your parents are probably safe and snug back in wherever the fuck you're from.  Me?  I had to live my whole life thinking my dad was dead; I had to watch a gang of gnolls drag my mother off to be raped to death.  Fuck you anyway, [pc.name].  What do you know?</i>\"");
	output("\n\nBefore you can say another word, the salamander runs out the door, back downstairs.  Aw, shit.");
	if(flags["COC.TOOK_QUEEN_STAFF"] == undefined) output("\n\nYou notice the queen's staff has fallen beside her body.");
	//(Remove all options but [Go Downstairs]; add [Take Staff]); (Remove Kiri from Stairwell)
	flags["COC.FOUGHT_WITH_HEL_IN_DUNGEON"] = 1;
	processTime(4);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Throne Room -- [Harpy Queen] -- [Kill Her]
public function killHarpyQueen():void {
	clearOutput();
	output("You look from Hel to the Harpy Queen.  This bitch could have bred an entire army - and might try it again. You can't allow that.");
	output("\n\nYou reach down and, with one quick stroke, snap her neck.  It twists easily, no harder than popping the cork of a wine bottle.  The sound of bones breaking is drowned out by the screams of harpies, screeching and cawing in horror."); 
	output("\n\nHel blinks at you for a second, nods approvingly.  She turns to the aghast brood and shoos them off with her sword.  The winged bitches yell and curse, but don't dare to resist the two of you.");
	output("\n\n\"<i>Well then. I guess that's that, then,</i>\" Hel says, swinging her sword over her shoulder into its sheath.");
	output("\n\nYou nod your agreement.");
	output("\n\n\"<i>Alright. You've got the key, so go break ");
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == 1) output("Dad ");
	else output("that poor salamander ");
	output("out of the dungeon.  I'll make sure the phoenixes and harpies don't give you two trouble on the way out.</i>\"");
	output("\n\nWith that, Hel trots out the door and down the stairs, leaving you alone in the room. You notice that the queen's staff has fallen beside her body.");
	flags["COC.HARPY_QUEEN_EXECUTED"] = 1;
	//(Remove all options but [Go Downstairs]; add [Take Staff]) (Remove Kiri from Stairwell)
	processTime(4);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Throne Room -- [Take Staff]
public function takeQueensStaff():void {
	clearOutput();
	output("You pick up the Harpy Queen's staff.  It is a tall whitewood staff, nearly six feet in length, and covered in glowing eldritch runes, with a singular shimmering sphere of crystal at its head, which seems to have a swirling mist within.");
	//(New Weapon: EldritchStaff)
	//Similar stats to the Wizard's Staff, but with a better Fatigue reduction and a bonus to Magic damage/effect.
	flags["COC.TOOK_QUEEN_STAFF"] = 1;
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCEldritchStaff()]);
}

//Throne Room -- [Harpy Queen] -- [Fuck Her]
public function fuckHarpyQueen():void {
	clearOutput();
	output("You decide that the queen bitch deserves to be taught a lesson and you'll use her to get you off in the process.  You whisper this to Hel, who seems quite amused by the idea.");

	output("\n\n\"<i>Oh, I was hoping you'd say that. So, what's the plan?</i>\"");
	//(Display Options:
	//If Male: [Anal](Needs big cock. Changed to any size because some people don't like hyper.) [Vaginal](Basically any size)
	//If Female: [?]
	//If Herm: All Above
	//If Genderless: \"<i>You don't really see how this is going to work out...</i>\" (NO SMUT 4 U)
	clearMenu();
	if (!pc.hasGenitals())
	{
		output("\n\n<b>Unfortunately, you lack the endowments needed to perform this action.</b>");
		if (silly) output("<b> Another reason not to be genderless.</b>");
	}
	if (pc.hasCock()) {
		addButton(0, "Anal", harpyQueenSexAnal);
		addButton(1, "Vaginal", vaginalHarpyQueenSex);
	}
	addButton(14, "Back", mainGameMenu);
}
//Harpy Queen Sex -- [Dick in Anal]
public function harpyQueenSexAnal():void {
	clearOutput();
	var x:int = pc.cockThatFits(harpyQueen.analCapacity());
	if (x == -1) x = pc.smallestCockIndex();
	
	output("Hel grabs the queen bitch by the shoulders and roughly tosses her onto the floor.  The gathered crowd of harpies gasp as Hel shoves the queen onto all fours for you.  You disrobe, tossing your [pc.gear] aside and stroking your [pc.cockNoun " + x + "] to full hardness.  You kneel down behind the Harpy Queen's massive flanks, so wide that you feel you could stuff your torso between her cheeks.  With great effort, you peel her jiggling ass apart, revealing the tight ring of her pucker and her loose, gaping cunt.");
	output("\n\nAs you position yourself behind the broodmother, Hel strips out of her skimpy bikini-mail and, grabbing the bitch by her hair, shoves her slick pussy into the harpy's face.  The queen struggles against Hel's grasp, making her inhuman hips and ass shake and jiggle seductively.  Your cock goes rock hard with the display before you, and you roughly push it into the harpy's buttcheeks.  You let her ass go, and shudder as the queen's soft flesh wraps around your [pc.cock " + x + "], as tight as a virgin pussy, but at the same time so soft and giving..."); 
	output("\n\nYou wrap your arms around her broodmotherly hips and start to thrust into her crack, hotdogging the harpy bitch.  Your dick sinks in and out of her squishy flesh, seeming to swallow your length like quicksand; you feel yourself drawn inexorably inwards, your shaft brushing against her slick pussy and tightly clenched ass.");
	output("\n\nYou give Hel a little wink, and though occupied by forcing the harpy to eat her out, she just manages to return it.  With that, you press the head of your [pc.cock " + x + "] against the harpie's sphincter.  Though much of your length is eaten up by her tremendous ass cheeks, her anus still clenches frightfully at your insistent prodding.  Scowling, you rear your hand back and give the harpy bitch a forceful slap on the butt.");
	output("\n\nThough her pillowy cheeks absorb much of the blow, she still lets out a pitiful yelp into Hel's pussy, and loosens up for a split second.  You plunge your shaft in, grunting at the incredible tightness of her anal passage.  She must have been a virgin back here before you took her; she screeches and writhes as your force your cock into her immensely tight bumhole, fighting for every inch you can stuff her with.");
	output("\n\nYou swat the harpy again to shut her up, but all that does is make her vice-like ass squeeze on your cock, painfully compressing the head.  You growl in pain, and in revenge slam yourself into her ");
	if (pc.cockVolume(x) <= harpyQueen.analCapacity()) output("until your hips sink into her pillowy ass");
	else output("until your massive " + pc.cockDescript(0) + " can go no further inside her");
	output(".  Sunk in as far as you'll go, you leave your cock where it is and instead give the broodmother a hard slap.  She screeches and clamps down, wringing your [pc.cockNoun " + x + "] hard.  But it's more pleasurable this time, now that she's nice and stretched by your anal intruder.");
	output("\n\nYou give her another swat, and another, spanking the harpy bitch until she's outright milking your [pc.cock " + x + "] inside her.  Laughing, Hel starts telling the queen what a good slut she is, taking your [pc.cockNoun " + x + "] up her ass and squeezing it like a whore as she tongue-fucks another woman.  The queen tries to protest, but you give her another hard slap to teach her some manners.");
	output("\n\nShe squeezes down so hard on your cock you feel like it's ready to burst.  Instead, though, you feel a sudden surge in your loins.  You have only enough time to sink your hands into the queen's cheeks and let out a powerful roar of pleasure as you cum, shooting a great big rope of hot [pc.cumNoun] right up her ass.  The queen screeches as you unload inside her, and the sudden motion of the queen's mouth sets Hel right off.  The salamander grabs the queen's head and crushes it against her hips, burying the harpy's nose inside her snatch as she cums over the bitch's face.");
	output("\n\nSpent, you pull out of the broodmother's now-gaping asshole.  Her huge asscheeks, however, bottle up your load inside her, preventing it from pooling out.  Laughing, you squeeze her squishy ass one last time before Hel rolls her over and pins her again.");
	//(Return to normal room menu)
	pc.orgasm();
	processTime(20);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Harpy Queen Sex -- [Vaginal]
public function vaginalHarpyQueenSex():void {
	clearOutput();
	var x:int = pc.cockThatFits(harpyQueen.vaginalCapacity());
	if (x == -1) x = pc.smallestCockIndex();
	
	output("You roughly toss the harpy queen to the floor and, grinning, tell her that since you're wrecking her plans to breed phoenixes, you'll just give her a brood of champion-spawn instead.  She gapes at you, wide-eyed in confusion and fear. Hel keeps her pinned down for you as you toss your [pc.gear] aside, revealing your [pc.cock " + x + "].");

	output("\n\nHel swings her leg around, planting herself firmly over the Harpy Queen's face. She crouches down, planting her cunt just an inch above the queen's nose, her long fiery tail swishing just above her cunt.  \"<i>You should feel honored, whore,</i>\" Hel growls, grabbing the queen by the hair.  \"<i>One egg fathered by my friend's seed is worth a thousand of your weakling sluts. Go on, thank " + pc.mf("him", "her") + "!</i>\"");
	output("\n\nThe harpy struggles against Hel's firm grasp, until she gets a good slap from the salamander.  \"<i>Gah! Thank you!  Thank you for the honor of bearing your eggs!</i>\" she pleads, still squirming.  You laugh and grab her massive thighs, pulling them apart to reveal your prize.  Her cunt is a voluminous gash between her legs, gaping and drooling lubricant, stretched beyond human possibility by the dozens - hundreds, even - of eggs she's birthed over her long life."); 

	output("\n\nYou kneel down between her legs and experimentally stick your [pc.cockNoun " + x + "] into her; she seems to simply suck it up, swallowing your entire shaft in a heartbeat.  Gods, she's immense!  You feel like you're sticking your shaft into a black hole, a cavern that has no ending.  She groans slightly at the penetration, but has easily taken your entire length with room to spare.  You shift around a bit, pushing her legs together to contract her gaping cunt.");

	output("\n\nFinally, you feel her slick walls around your [pc.cock " + x + "]. The queen shudders, but now seeing that you mean to pump her full of your seed, visibly relaxes. Still, she's just too loose to give you the pleasure you're seeking...");

	output("\n\nA wicked grin spreads across your face.  You reach forward and grab Hel's tail, wincing at its heat, and drag it back between the Harpy Queen's loins.  Hel looks at you over her shoulder and, grinning, takes over for you.  You brace yourself as her prehensile tail slithers back and, curling once around your [pc.cockNoun " + x + "], slips inside the queen with you.  You and the broodmother both gasp at once as her burning-hot tail crawls along your cock's shaft and into her gaping cunt until the harpy lets out a little scream into Hel's own crotch.  You guess the salamander found her womb and is wriggling her tail into it.");
	if (pc.cocks[x].cLength() >= 18) output("  Not to be outdone, you slam your hips forward, ramming your [pc.cockNoun " + x + "] into the queen's depths until you catch up with Hel, pounding the entrance to her womb.");
	output("\n\nNow that you have a second shaft inside the harpy's birth canal, it seems a lot less roomy. You start to piston your hips into the queen bitch; your shaft runs along three slick walls and Hel's hot tail with each thrust, leaving your [pc.cockNoun " + x + "] feeling like it's in a liquid inferno, and it feels wonderful.  You start to fuck the queen faster, already feeling your own orgasm rising.  Her juices spill freely from her loose cunt, pooling between her thighs as you and Hel fill her utterly, giving her what's probably the first satisfying fuck she's been able to get in years.");
	output("\n\nYou aren't surprised when the harpy gets off, rolling her head back and screeching as she climaxes. Laughing, Hel starts to thrash her tail around inside her, nearly managing to wrap it around your [pc.cock " + x + "] inside her.  With the sudden contractions and extra motion around your cock, you aren't able to last any longer; ");
	if (pc.cumQ() < 300) {
		output("you slam your [pc.hips] into the harpy's groin and ejaculate, launching [pc.cumVisc], sperm-filled globs right into her waiting womb.\n\nYou cum and cum, filling the queen with all your seed until your ");
		if (pc.balls > 1) output("[pc.balls] feel");
		else output("[pc.balls] feels");
		output(" hollow and empty.  Shuddering, you and Hel both withdraw, your cock and her tail a spunk--and juice-covered mess.");
	}
	else {
		output("you slam your [pc.hips] into the harpy's groin and ejaculate, releasing a massive torrent of spunk deep inside the queen's womb, causing the harpy to shudder at the sheer amount of sperm you let out.  You continue to coat the harpy's walls for a minute, until your ");
		if (pc.balls > 1) output("[pc.balls] feel");
		else output("[pc.balls] feels");
		output(" hollow and empty.  You and Hel slowly withdraw, causing some of your semen to leak out of the harpy's massive canal, leaving your cock and Hel's tail a spunk-and-juice-covered mess.");
	}
	if(pc.virility() > 0) output("\n\nAfter a fuck like that, the broodmother will be laying a clutch of your eggs in no time.");
	pc.orgasm();
	processTime(20);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Throne Room -- [Harpy Queen] -- [Interrogate]
public function harpyQueenInterrogate():void {
	clearOutput();
	output("Leaning over the defeated Harpy Queen, you decide to get some answers.  First, you ask her why, exactly, she kidnapped a salamander in the first place.  That's what brought you here, after all.");
	output("\n\nGrunting under Hel's foot, the queen spits at you, narrowly missing your face. \"<i>What the fuck kind of question is that? I stole him to steal his seed, foolish " + pc.mf("boy","girl") + ".</i>\"");
	output("\n\nWell, you suppose you had that one coming.  Next.  How did she get the phoenixes in the first place? Harpies usually don't birth half-breeds.");
	output("\n\n\"<i>Ha!  Goblin alchemy.  My true-born daughters brought me all that they could.  I experimented for years trying to get it right.  A bit of this potion and that poison... But I did it.  I created the ultimate race of warriors.  You might kill me, but you cannot erase my creation!</i>\"");
	output("\n\nYou roll your eyes. We'll see about that.  You ask her why she went to all that trouble of making a race of 'ultimate warriors' anyway.  Since when did a harpy want to rule the world?");
	output("\n\n\"<i>Rule the world? FOOL! That was not my intention - far from it.</i>\"");
	output("\n\nOh really?");
	output("\n\n\"<i>It is the truth.  I saw what the demons did to our world... What they wreaked upon my beautiful daughters... And I could not turn my back.  So one man had to suffer!  A pittance of a sacrifice to drive back the demons.  With the salamander's seed, and my magic and mighty womb...  An army was not beyond our reach.  The phoenixes were to be the demons' downfall.  Yet you seek to doom us, all for the sake of one.</i>\"");
	output("\n\nWait, what.");
	output("\n\n\"<i>You heard me, fool! I meant to breed an army to turn back the demons.  And I was so close!  My daughters, you fought them below; were they not beautiful? And so... so very deadly.</i>\"");
	output("\n\n\"<i>You bitch!</i>\" Hel snaps, grinding her foot into the harpy's chest.  \"<i>What the fuck is wrong with you people?  Did you even think, for one fucking second, actually THINK to maybe ask one of us?  Just fly down and ask any horny salamander boy, 'Wanna fill me with your seed till my eggs pop and make an army?' Guess what - he'd say yes! Any man in Mareth who's still pure at heart would say YES!</i>\"");
	output("\n\nThe harpy queen turns her gaze toward Hel. \"<i>This one did not.</i>\"");
	//[If PC told Hel about Hakon:
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == 1) output("\n\n\"<i>That's because he was MARRIED, YOU BITCH!</i>\" Hel screams, her tail practically blazing behind her. The queen recoils, but falls silent.");
	else output("\n\n\Hel scowls, but says nothing. It doesn't seem like you'll get anything further from the queen.");
	//(Return PC to room menu)
	processTime(10);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}