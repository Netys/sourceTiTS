import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Introduction Scene -- Helia's Discovery
//Requirements: 
//-PC has achieved \"<i>Fuckbuddy</i>\" status with Helia.
//-HelAffection >= 70
public function heliaDiscovery():void {
	//clearOutput();
	//(Scene proc's the first time all requirements are met and the player chooses [Sleep] at camp.)
	output("Before bedding down for the night, you make one last check of your camp's perimeter, making sure all your traps and defenses are still in place and primed in the event of a surprise nighttime assault.  As you come to the outermost parts of your makeshift camp, you notice a cloaked stranger approaching out of the evening darkness.  You're about to ready your [pc.mainWeapon], but you recognize the shapely figure of Hel the salamander walking towards you, hips a-sway underneath her loose traveling cloak.");

	//(If Hel has never been to camp before (ie, no Isabella threesome at camp)
	if (flags["COC.HEL_ISABELLA_THREESOME_ENABLED"] == undefined) {
		output("\n\n\"<i>[pc.name]!</i>\" the salamander shouts, waving emphatically as she approaches.  \"<i>Shit, do you have any idea how hard you are to track down? I've been looking for you everywhere!</i>\"  You ");
		//[(pussy)
		if (pc.cor() < 50) output("quickly rush over and stop Hel before she loses a leg to one of your traps");
		//(dick)
		else output("lazily point out your traps to the not-quite-intruder");
		output(", and guide her over to the camp proper.");
	}
	//(Else)
	else {
		output("\n\n\"<i>Hey there, [pc.name]!</i>\" the salamander calls, handily picking her way through your maze of traps. She gives you a quick embrace and, taking your hand in hers, leads you back to the camp proper.");
	}
	//(Resume All)
	output("\n\nYou sit the salamander down near your campfire and ask her what brought her all the way from the plains to your humble abode.  She shrugs lightly and says, \"<i>Maybe I just wanted some company tonight.</i>\"");
	//[If not Centaur: 
	if (!pc.isTaur()) output("  Her hand slides over to rest on your thigh.");
	else output("  \"<i>She gives your flank a slow, affectionate stroke.</i>\"");
	output("  You ask her if that's true. With a little wink, she answers, \"<i>Well, it's not entirely untrue...</i>\"");

	output("\n\n\"<i>Actually, champ, I wanted to... um, well...  ask a favor, I guess.</i>\"  Hel says awkwardly, suddenly avoiding eye contact.  \"<i>I wouldn't ask if it wasn't important, or something I could do on my own, or...  Ah, shit.</i>\"  From inside her cloak, Hel produces a dirty, dented flask and takes a long swig of what smells like pure grain alcohol.  While she drinks, you urge her to tell you what's on her mind.");

	output("\n\nShe belches thunderously, shakes it off, and sighs. \"<i>It's like this, Champ: a little birdie told me that there's this tremendous roost of harpies up in the high mountains, dozens of the bitches all packed together. That's bad enough, right? But now, some of them have been showing up with red scales all over their arms and legs... and fire on their tails.</i>\"");

	output("\n\nYou ask her why that's piqued her interest so much; she lives some ways away from the mountains after all.");

	output("\n\n\"<i>Normally I wouldn't give two shits about what a bunch of feather-bitches are doing. But scales and fire?  Sound like someone you know?</i>\"  Before you can answer, you feel Hel's warm tail curl around your shoulders, hugging you right up against her.  She takes another long swig from her flask.  It's starting to smell like someone lit a brewery on fire next to you.  \"<i>What I'm saying is that there's a chance that there's a poor, abused salamander tied up in this roost of theirs, being used as breeding stock for years and years now, fathering a whole new generation of harpies.  Even if you don't give a shit about the birds, it would... mean a lot to me if you'd help me break him out.  Look, [pc.name], I'm a mean bitch in a fight - you know that - but even I can't take on a whole roost of harpies solo.  And, well, you're the only person I trust one-hundred percent.  To have my back, you know?</i>\"");

	output("\n\nYou spend the next few minutes getting the rest of her information out in the open - they live in an old abandoned watchtower, she says, and number perhaps two dozen.  As she talks, you note a desperate tone in Hel's voice, and more than once she repeats that she can't do it by herself, or trust anyone but you to help.");

	output("\n\nDo you agree to help Helia?  She'd probably be <b>very</b> grateful...");
	//(Display Options: [Yes] [No])
	processTime(10);
	clearMenu();
	addButton(0, "Yes", agreeToHelpHeliaDungeon);
	addButton(1, "No", noHeliaDungeon);
}

//Intro Scene -- No
public function noHeliaDungeon():void {
	clearOutput();
	output("You consider for a few moments, but ultimately decide that this is a venture you'd rather not participate in.");
	output("\n\n\"<i>W-What? Why not?</i>\" Hel stammers, suddenly glowering at you.");
	output("\n\nYou try to explain your reasons, but it seems Hel isn't having any of it.");
	output("\n\n\"<i>Well fuck you anyway!</i>\" she shouts, jumping to her feet and waving her scaly arms emphatically, nearly clawing your face off with her sharp talons.  \"<i>I don't need you or your bullshit excuses! I'll just go do it my own goddamn self--see if I don't!</i>\"");
	output("\n\nBefore you can even try to calm her down, Hel is running away from the camp and back into the night from whence she came.");
	output("\n\nWell then.");
	//(In-Game effect: Reduce Hel's encounter rate, end fuckbuddy mode. Will fight player in plains.)
	flags["COC.HEL_REDUCED_ENCOUNTER_RATE"] = 1;
	flags["COC.HEL_FUCKBUDDY"] = 0;
	flags["COC.HEL_AFFECTION"] = 0;
	//kGAMECLASS.helFollower.helAffection(-70);
	processTime(6);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Intro Scene -- Yes
public function agreeToHelpHeliaDungeon():void {
	clearOutput();
	output("You mull the salamander's proposition over and eventually agree to assist her.  Not only will you be stopping a new race of monsters from spawning into the mountains, but you'll be getting into the lovely Helia's good graces - a win-win if ever there was one.");
	output("\n\nHel breaks out into a great big smile and leaps at you, pulling you into a hug and squeezing until you damn near choke.  You return her tight embrace, and are eventually rewarded by Hel relaxing in your arms");
	//[if has lap: 
	if (!pc.isTaur()) output(" and cuddling up in your lap");
	output(".  She nuzzles your neck and whispers, \"<i>Thanks, Champ. It means a lot to know I can count on you to... watch my back.</i>\"");
	output("\n\nYou run a hand through Hel's hair and tell her that you've got her back no matter what.  You give her muscular ass a playful little grope; and she immediately wraps her tail around you, pinning your arms to your chest.  Doesn't look like you're going anywhere now.  With a little smirk, the salamander whispers, \"<i>Let's stay like this 'till morning - what do you say?</i>\"");
	output("\n\nResigned to your fate, you curl up with Helia; who throws her cloak over the two of you.");
	
	//[If Marble is in camp:]
	if (flags["COC.MARBLE_FOLLOWER"] && silly) {
		output("\n\nJust as you and Hel start to get intimate, you hear a familiar clopping of hooves. You poke your head out of the blanket, rather alarmed to see Marble standing over you.");
		output("\n\n\"<i>S-Sweetie?</i>\" Marble says, aghast at Hel's presence in your arms.  \"<i>What... just what do you think you're doing!?</i>\"");
		output("\n\nThis could be ba--");
		output("\n\n\"<i>Back off, cow-slut!</i>\" Hel growls, baring her talons at the bovine girl. \"<i>[pc.name]'s mine tonight. GOT IT!?</i>\"");
		//(IF SILLYMODE:)
		if (silly) output("\n\nMarble stammers and starts, struggling to find a rebuke against the salamander.  Before she can, though, Hel leaps to her feet and rushes her!  You don't even have a chance to intervene before Marble goes flying with a kick right to her cow-cunt, sending her hurtling toward the swamp.  As Hel settles back into your arms, you're almost certain you hear a rather draconic scream of rage in the distance.");
	}
	//PROC NEXT FUNCTION AT 6AM.  OVERRIDES OTHER SHIIIIITE
	flags["COC.HEL_FOLLOWER_LEVEL"] = -1;
	
	clearMenu();
	addButton(0, "Next", morningAfterHeliaDungeonAgreements);
}
	
public function morningAfterHeliaDungeonAgreements():void {
	clearOutput();
	output("When your eyes flicker open at the crack of dawn, you're pleased to see Helia is lying on your chest, ");
	//[If PC has >C Cups, \"<i>
	if (pc.biggestTitSize() > 3) output("her head nestled between your soft tits and ");
	output("snoring boorishly.  The air around you smells like hot booze and sex, yet you awaken feeling as spirited and lively as you ever have.  You give Hel a little shake, waking her.");

	output("\n\n\"<i>Huh, wha?</i>\" she groans, rubbing her head.  \"<i>Oh, hey there, lover mine,</i>\" she adds after a moment, giving you a long kiss on the lips.  The two of you untangle yourselves, giving each other the occasional tease and playful slap on the ass, flirting shamelessly as you dress and ready yourselves for the coming day.");
	output("\n\nWhen you're dressed and organized, Hel asks, \"<i>So, what's the plan, [pc.name]?</i>\"");

	output("\n\nYou tell the salamander you just need to get your affairs in order and you're off to the harpies' nest. She nods, reminding you that each moment you spend waiting around is another moment that poor man suffers.  You tell her you'll be quick, and set about preparing.");
	//(Display: 
	output("\n\n(<b>Helia can now be found in your camp! (For Now!)</b>)");
	
	//(Decrease Player Lust to minimum, increase HP to maximum, etc. etc. You're sleeping, but also fucking. Figure it out.)
	sleep(false);
	if (pc.timesCum > 0) pc.orgasm(); //Never calls if you never orgasmed before.
	pc.energy(pc.energyMax());
	
	flags["COC.HEL_FOLLOWER_LEVEL"] = 1;
	processTime(10);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function heliaTempFollowerMenu():void {
	clearOutput();
	//spriteSelect(68);
	
	output("You approach Hel as she's pacing around camp.  She's clad in her normal field attire: a simple scale bikini top and leather thong which supports her scimitar's scabbard.  Her cloak is loosely thrown over her shoulders, giving her a slight measure of protection from the mountain's harsh environs.");
	output("\n\n\"<i>Heya, [pc.name]! Ready to hit the road?</i>\"");
	//(Display Options: [Dungeon] [Not Yet])
	clearMenu();
	addButton(0, "Dungeon", goToHeliaDungeon);
	addButton(1, "Not Yet", notDungeonMoodYet);
}


//Introduction -- Not Yet.
public function notDungeonMoodYet():void {
	clearOutput();
	output("You tell Hel you were only checking on her, and that you've still got some things to do.  She sighs and quietly asks you to hurry.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Introduction -- Dungeon
public function goToHeliaDungeon():void {
	clearOutput();
	output("You tell Helia that yeah, you're as ready as you'll ever be.  She beams and grabs you in a tight hug.  \"<i>Thanks again, [pc.name].  You're a real goddamn champion, you know that?</i>\"  You laugh it off, but the salamander gives you a sultry wink and starts off toward the mountains.  You're quick to follow her.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", goToHeliaDungeon2);
}

public function goToHeliaDungeon2():void {
	clearOutput();
	//output(images.showImage("dungeon-entrance-phoenixtower"));
	output("Within the hour, you and Helia are hiking up the narrow ledges and crevices of the high mountains, slowly but steadily climbing toward a snow-capped peak.  Hel certainly seems to know where she's going - she blazes a certain and steady trail, as if she knew every path and shortcut up the mountain.  By the time you near the peak, you're convinced she's been up here before - many times, even.");
	output("\n\nEventually, you see the crest of a squat, thick stone tower on the mountainside.  Hel easily guides you toward it, giving you a helping hand over an unusually wide gorge that would have kept most stray minotaurs well away from the solitary spire.  As you scramble onto the tower's plateau, Hel grabs your shoulders and pins you to the ground - just in time to avoid the gaze of a low-flying harpy.");
	output("\n\n\"<i>Quiet,</i>\" she hisses, lying atop you so that you can't jump up and expose your position.  \"<i>We can't take them all at once out in the open... This is going to be a sneaking mission, got it?</i>\"");
	output("\n\nYou quietly nod, and the two of you begin making your way toward the tower, hopping from one rocky outcropping to the next to avoid the harpies' sights.  Eventually, you come to the base of the looming structure.  Now sheltered in its shadow, you can clearly see the bird-women in great numbers, flying through the air to and fro.");
	output("\n\nNow safe from the watchful eyes of flying harpies and their sentries, Hel whispers, \"<i>Okay, so here's the plan.  I'm going to climb up the tower and hit them from the top; you go in through the main gates here,</i>\" she says, pointing to a rotting wooden door that seems to have been in disuse for a decade.  \"<i>Divide and conquer, right?  There are three floors, so... meet in the second, as soon as we can.  Yeah?</i>\"");
	output("\n\nYou nod again, and give Helia a little boost as she starts to scale the high walls of the aging tower.  You, however, steel yourself and make your way through an opening in the main gates."); 
	//(NEXT)
	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", move, "COC PHOENIX GUARD HALL");
}

//[Prisoner] (First Time)
public function helDungeonPrisonerTalk():void {
	clearOutput();
	if (flags["COC.HEL_PC_TALKED_WITH_HAKON"] == undefined) {
		output("You approach the Salamander strapped to the table.  He looks at you with his one good eye, warily gauging you as you approach.");
		output("\n\n\"<i>Well, aren't you a sight for sore eyes,</i>\" he laughs, his voice little more than a rasp.  \"<i>About time somebody put a boot up that punk bitch's ass.  Ha!  Hey, the name's Hakon.  I'd shake your hand, but, uh, I'm a bit tied up at the moment as it were.  So, what brings an outsider all the way up here?</i>\"");
		output("\n\nYou tell him that you're here to rescue him as it happens.");
		output("\n\n\"<i>What!?</i>\" he says, wide-eyed.  \"<i>Hey, I'm not complaining, mind you, but pardon me for being surprised.  I've been locked up in this shithole for... Marae, must have been fifteen, twenty years now.  Why now?  Who sent you?  My wife?</i>\"");
		output("\n\nYou shake your head and tell him that it was Helia who sent you.");
		output("\n\n\"<i>H... Helia? My little Hel?</i>\" he asks in disbelief. With a slight grin, you tell him that 'little' Hel isn't so little anymore.  He laughs, but for an instant you think he might be about to cry.  \"<i>Of... of course she is.  My little girl's all grown up.  Oh, what I wouldn't give to meet her...</i>\"");
		output("\n\nYou tell him that she's not far away at all... just a few floors up, in fact.");
		output("\n\n\"<i>WHAT!?</i>\" He yells, straining against the chains that bind him.  \"<i>You brought Hel here!?  What were you thinking?  Go and get her out of here.  NOW!</i>\"");
		flags["COC.HEL_PC_TALKED_WITH_HAKON"] = 1;
		processTime(3);
	}
	//[Prisoner] (Repeat)
	//[IF PC HAS HARPY KEY A & B]
	else if (pc.hasKeyItem("Harpy Key A") && pc.hasKeyItem("Harpy Key B")) {
		output("You smile as you approach Hakon the Salamander.  He starts to yell at you again, but you snap at him to hush.  You explain that Hel and Kiri are waiting outside and that the broodmother has been defeated.  Both sets of keys jingling in your hands.  He watches you approach silently, his eyes wary but hopeful.  You quickly undo his bonds, freeing him for the first time in years.  He struggles to sit, but nearly collapses. You catch him before he hurts himself and, throwing his arm over your shoulder, help the old salamander toward the stairs...");
		//(Go to DUNGEON END scene)
		processTime(2);
		clearMenu();
		addButton(0, "Next", towerOutro);
		return;
	}
	//[Else]
	else {
		processTime(1);
		output("You approach Hakon the Salamander.  He strains against his bonds, yelling at you to get Hel and get out before it's too late.  You roll your eyes and carry on.");
	}
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Tower of the Phoenix: Outro
//(Play when the PC interacts with Hakon, in the dungeon, while possessing both HARPY KEY key items)
public function towerOutro():void {
	clearOutput();
	if (flags["COC.HARPY_QUEEN_EXECUTED"] == undefined) flags["COC.HARPY_QUEEN_EXECUTED"] = -1;
	//[IF PC DID NOT TELL HEL ABOUT HAKON BEFORE]
	if (flags["COC.HEL_KNOWS_ABOUT_HAKON"] == undefined) {
		output("With Hakon's arm slung over your shoulder, you help the long-imprisoned salamander up the stairs and, with great effort, out the ancient doors of the tower.  Outside, you see Helia and her pseudo-phoenix half-sister Kiri.  Hakon recoils as the evening sunlight hits his eyes, his first taste of the sun in years.");
		output("\n\nHel and Kiri turn to you, smiling from ear to ear as you bring Hakon outside.");
		output("\n\n\"<i>Hel,</i>\" Kiri says, taking the salamander by the hand.  \"<i>I've got someone you might want to meet.</i>\"");
		output("\n\nThe elder salamander manages a weak grin as his unknowing daughter walks over to him and extends a hand.  \"<i>Hey there, old scales.  Name's Helia - Hel for short - and I... Why is everyone looking at me like that?</i>\"");
		output("\n\n\"<i>Hel,</i>\" Kiri says, \"<i>this is... our dad. Hakon.</i>\"");
		output("\n\n\"<i>Old scales, is it?</i>\" Hakon says, grinning ear to ear.  \"<i>Lemme tell you something, little girl.  I - OOF!</i>\"");
		output("\n\nBefore 'old scales' can finish his thought, Hel leaps into his arms, hugging him tightly.  You can see tears streaming down her face - and, you think, his too - streaming off them as the two salamanders embrace.");
		output("\n\n\"<i>Is it... really you? Dad?</i>\"");
		output("\n\n\"<i>It is, little Hel.  And I'm never leaving you again.</i>\"");
		output("\n\nYou spend the next few hours sitting on the stoop of the tower, watching as the long-estranged family has a chance to get to know each other again.  You smile the entire time as Hel, Hakon, and Kiri are soon teasing and playing with each other as if they had always been together.");
		output("\n\nEventually, it's time to go.  With an arm around his daughters, Hakon steps up to you. \"<i>" + pc.mf("Son", "Sweetheart") + ", I can't thank you enough.  Not for freeing me, but for... For reintroducing me to my family.  If you ever need anything, you don't hesitate to ask.  If by my life or sword I can help you, I will, without hesitation.</i>\"");
		output("\n\n\"<i>Yeah,</i>\" Hel says, grinning.  \"<i>You did all right, lover mine.  Don't worry, I'll drop by soon to show you just how much I appreciate it.</i>\"");
		output("\n\n\"<i>Lover mine?</i>\" Hakon says, chuckling. \"<i>I think we have a lot to talk about on the way down, little girl.</i>\"");
		output("\n\n\"<i>Well, shit.</i>\"");
		output("\n\nYou laugh, shake your head, and start your way down the mountain.");
		//(PC returns to Camp)
		//(If PC has Valeria: add \"<i>Valeria</i>\" to Followers menu)
	}
	//[IF PC DID TELL HEL ABOUT HAKON]
	else {
		output("With Hakon's arm slung over your shoulder, you help the long-imprisoned salamander up the stairs and, with great effort, out the ancient doors of the tower.  Outside, you're treated to a sweeping expanse of mountain; it's a gorgeous vista, with the great rocky spires and crags surrounding you until the sun is just a glimmer in the distant.  Hakon squints, covering his eyes as he is bathed in daylight for the first time in years.");
		output("\n\nBehind you, you hear a sudden, gleeful cry: \"<i>DADDY!</i>\"");
		output("\n\nHakon turns just in time as Hel leaps into his arms, followed shortly by her phoenix half-sister Kiri.  You can see tears streaming down the girls' faces -- and, you think, Hakon's too -- streaming off them as a father is finally reunited with his daughters...");
		output("\n\n\"<i>Is it.. really you?  Dad?</i>\" Hel asks, openly crying.  You don't think she's ever seen her father before.");
		output("\n\n\"<i>It is, little Hel.  And I'm never leaving you again.</i>\"");
		output("\n\nYou spend the next few hours sitting on the stoop of the tower, watching as the long-estranged family has a chance to get to know each other again.  You smile the entire time as Hel, Hakon, and Kiri are soon teasing and playing with each other as if they had always been together.");
		output("\n\nEventually, it's time to go.  With an arm around his daughters, Hakon steps up to you. \"<i>" + pc.mf("Son", "Sweetheart") + ", I can't thank you enough.  Not for freeing me, but for... For reintroducing me to my family.  If you ever need anything, you don't hesitate to ask.  If by my life or sword I can help you, I will, without hesitation.</i>\"");
		output("\n\n\"<i>Yeah,</i>\" Hel says, grinning.  \"<i>You did alright, lover mine. Don't worry, I'll drop by soon to show you just how much I appreciate it.</i>\"");
		output("\n\n\"<i>Lover mine?</i>\" Hakon says, chuckling.  \"<i>I think we have a lot to talk about on the way down, little girl.</i>\"");
		output("\n\n\"<i>Well, shit.</i>\"");
		output("\n\nYou laugh, shake your head, and start your way down the mountain.");
	}
	//(PC returns to Camp)
	//(If PC has Valeria: add \"<i>Valeria</i>\" to Followers menu)
	flags["COC.CLEARED_HEL_TOWER"] = 1;
	pc.removeKeyItem("Harpy Key A");
	pc.removeKeyItem("Harpy Key B");
	processTime(100 + rand(40));
	clearMenu();
	addButton(0, "Next", move, "COC_CAMP");
}