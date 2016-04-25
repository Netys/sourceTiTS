import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function showJojo():void {
	userInterface.showName("\nJOJO");
}

public function followerCampMenuBlurbJojo(showInteractButton:Boolean):void {
	if (flags["COC.JOJO_IN_CAMP"] == 1) {
		output("There is a small bedroll for Jojo near your own");
		//if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText(" cabin");
		//if (!(hours > 4 && hours < 23)) outputText(" and the mouse is sleeping on it right now.\n\n");
		//else 
			output(", though the mouse is probably hanging around the camp's perimeter.\n\n");
		if (showInteractButton) addButton(followerBtnNum++, "Jojo", function():* { processTime(5); jojoCamp() } , null, "Talk", "Go find Jojo around the edges of your camp and meditate with him or talk about watch duty.");
	}
	//if (campCorruptJojo() && flags["COC.FOLLOWER_AT_FARM_JOJO"] == undefined) {
		//output("From time to time you can hear movement from around your camp, and you routinely find thick puddles of mouse semen.  You are sure Jojo is here if you ever need to sate yourself.\n\n");
		//if (showInteractButton) addButton(followerBtnNum++, "Jojo", corruptCampJojo, your, "Jojo", "Call your corrupted pet into camp in order to relieve your desires in a variety of sexual positions?  He's ever so willing after your last encounter with him.");
	//}
}

private var followerCampMenuBlurbJojoHook: * = followerCampMenuBlurbJojoGrapple();
private function followerCampMenuBlurbJojoGrapple():* {	
	followerCampMenuBlurb.push(followerCampMenuBlurbJojo);
}

public function jojoFollowerMeditate(clear:Boolean = true):void {
	showJojo();
	if(clear) clearOutput();	
	if (flags["COC.JOJO_LAST_MEDITATION"] == days) {
		output("Jojo smiles and meditates with you.  The experience is calming, but it's so soon after your last session that you don't get much benefit from it.");
	}
	else {
		output("The mouse monk leads you to a quiet spot away from the portal and the two of you sit down, him cross-legged and you mimicking to the best of your ability, back to back.  You close your eyes and meditate for half-an hour, centering your body and mind.  Afterwards, he guides you through stretches and exercises to help keep your bodies fit and healthy.\n\nWhen you are done, Jojo nods to you, and climbs back onto his rock, still thinking.");
		var cleanse:int = -2; //Corruption reduction - faster at high corruption
		if (pc.cor() > 80)
			cleanse -= 3;
		else if (pc.cor() > 60)
			cleanse -= 2;
		else if (pc.cor() > 40)
			cleanse -= 1;
		pc.cor(cleanse);
		//dynStats("cor", cleanse - pc.countCockSocks("alabaster"));
		
		//if (pc.str < 45) dynStats("str", 1); //Str boost to 45
		//if (pc.tou < 45) dynStats("tou", 1); //Tou boost to 45
		//if (pc.spe < 75) dynStats("spe", 1); //Speed boost to 75
		//if (pc.inte < 80) dynStats("int", 1); //Int boost to 80
		//if (pc.lib > 0) dynStats("lib", -1); //Libido lower to 15
		
		if (pc.PQ() < 45) pc.slowStatGain("physique", 0.5);
		if (pc.AQ() < 75) pc.slowStatGain("aim", 0.5);
		if (pc.RQ() < 75) pc.slowStatGain("reflexes", 0.5);
		if (pc.IQ() < 80) pc.slowStatGain("intelligence", 0.5);
		if (pc.WQ() < 80) pc.slowStatGain("willpower", 0.5);
		if (pc.libido() > 5) pc.slowStatGain("libido", -1);
	
		flags["COC.JOJO_LAST_MEDITATION"] = days;
		IncrementFlag("COC.JOJO_MEDITATION_COUNT");
	}
	processTime(50 + rand(20));
	//Reduces lust
	pc.lust( -30);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function jojoDefenseToggle():void {
	showJojo();
	clearOutput();
	if (flags["COC.JOJO_NIGHT_WATCH"] > 0) {
		flags["COC.JOJO_NIGHT_WATCH"] = 0;
		output("You tell Jojo that you no longer need him to watch the camp at night.  He nods, then speaks.  \"<i>Alright.  Please let me know if you require my help again.</i>\"");
	}
	else {
		flags["COC.JOJO_NIGHT_WATCH"] = 1;
		output("You ask the monk if he could guard the camp for you at night.  He smiles politely.  \"<i>Certainly, [pc.name].</i>\"");
	}
	processTime(2);
	clearMenu();
	addButton(0, "Next", jojoCamp);
}

// JOJO: THE EXPANSIONING
//Alternative Recruitment by LukaDoc 
//Note: Since you are not corrupt here Jojo cannot sense you. 
//Requirements: Level 4, Corruption < 20
public function lowCorruptionJojoEncounter():void
{
	clearOutput();
	showJojo();

	output("Tired of exploring the forest for the moment, you decide to head back to camp.  Not feeling like taking the scenic route, you move to step through some bushes, but immediately your mind registers a yelp.  The instant you move to look at the source of the noise, a white blur smacks you right on your head.");

	if (pc.PQ() >= 50 && pc.isBiped() == true)
	{
		output("  You take a few steps back, momentarily dazed.  Shaking it off, you ready your [pc.mainWeapon] and assume a fighting stance.\n\n");
	}
	else if (pc.PQ() < 50 && pc.isBiped() == false)
	{
		output("The force of the blow knocks you flat on your [pc.ass].  Shaking it off, you immediately climb to your feet and take on a fighting stance.\n\n");
	}
	else if (pc.isTaur())
	{
		output("The blow does little more than leave you momentarily dazed but isn’t enough to knock you over.  You shake it off and ready your [pc.mainWeapon] as you assume a fighting stance.\n\n");
	}
	else // Was originally isNaga() only, but this will also cover Drider just as well
	{
		output("You recoil as you are struck, but the force of the blow does little more than leave you momentarily dazed. You assume a fighting stance, ready to defend yourself.\n\n");
	}

	output("To your surprise you are greeted with the visage of a rather surprised mouse.\n\n");

	output("“<i>Oh... erm... I’m sorry.  You spooked me,</i>” he says apologetically, rubbing the back of his neck in embarrassment.\n\n");

	output("Do you accept his apology?\n\n");

	processTime(3);
	clearMenu();
	addButton(0, "Yes", acceptJojosApology);
	addButton(1, "No", refuseJojosApology);
}

// Yes
public function acceptJojosApology():void
{
	clearOutput();
	showJojo();

	output("You forgive him for hitting you and apologize for spooking him yourself, prompting a relieved sigh.\n\n");

	output("“<i>Thanks, it’s a relief to meet a friendly face,</i>” he says, his mouth breaking into a smile. “<i>Oh, where are my manners!</i>”\n\n");

	processTime(1);
	lowCorruptionIntro();
}

//No
public function refuseJojosApology():void
{
	clearOutput();
	showJojo();

	output("With a smile you curl up a fist and knock the unsuspecting mouse morph upside the head, causing him drop his staff and rub the spot where you slugged him.  As he looks up at you you give his angry expression a shrug, telling him that now the two of you are even.\n\n");

	output("“<i>O-Kay</i>” The mouse says slowly, suddenly watching your movements very closely with those quick little eyes of his, “<i>But I guess it’s fair, no harm done right?</i>”\n\n");
	output("It’s all water under the bridge to you now; after all you did slug him real good. The two of you agree to start over.\n\n");

	processTime(1);
	lowCorruptionIntro();
}

//Intro
public function lowCorruptionIntro():void
{
	output("He extends a hand, which you gladly shake. “<i>My name is Jojo, pleased to meet you.</i>” You introduce yourself in kind.\n\n");

	output("Now that you have the opportunity to take a good look at him, you notice that he is dressed in simple garbs reminiscent of a monk. A light-blue robe covers his flat chest, tied with a simple sash around his waist. His pants, similar to his robes, fit him snugly as well.\n\n");

	output("His build is lithe, though you detect he isn’t weak by any means. His handshake is firm and transmits confidence; it’s clear that this mouse has trained well, though you can’t see any hint of muscles with his robes covering him. His hair is short and as white as his fur, you’d guess he’s an albino if not for his brown eyes. Surprisingly, he doesn’t seem to be carrying anything on his person, save for a necklace made of beads.\n\n"); // Can't really presume that they're holy without knowing much more about him, rite?

	output("He smiles knowingly, “<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>”\n\n");

	output("Jojo sighs sadly, “<i>Enough of my woes.  Though I ");
	if (pc.cor() <= 5) output("don't ");
	else output("barely ");
	output("feel any corruption within you, it’s always best to be prepared.  Would you care to join me in meditation?</i>”\n\n");
	//Choices time!
	processTime(3);
	clearMenu();
	addButton(0, "Meditate", meditateInForest); // OH GOD NO SEND HELP
	addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	addDisabledButton(2, "Rape", "Rape", "Not implemented");
}

public function highCorruptionJojoEncounter():void {
	showJojo();
	clearOutput();
	output("While marvelling at the strange trees and vegetation of the forest, the bushes ruffle ominously.  A bush seems to explode into a flurry of swirling leaves and movement.  Before you can react you feel your [pc.feet] being swept out from under you, and land hard on your back.\n\n");
	output("The angry visage of a lithe white mouse gazes down on your prone form with a look of confusion.");
	output("\n\n\"<i>I'm sorry, I sensed a great deal of corruption, and thought a demon or monster had come to my woods,</i>\" says the mouse, \"<i>Oh, where are my manners!</i>\"\n\nHe helps you to your feet and introduces himself as Jojo.  Now that you have a good look at him, it is obvious this mouse is some kind of monk, dressed in robes, holy symbols, and draped with prayer beads.\n\nHe smiles knowingly, \"<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>\"");
	output("\n\nJojo sighs sadly, \"<i>Enough of my woes.  You are very corrupted.  If you cannot be sufficiently purified you WILL become one of them in time.  Will you let me help you?");
	//Choices time!
	processTime(3);
	clearMenu();
	addButton(0, "Accept", meditateInForest);
	addButton(1, "Decline", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	addDisabledButton(4, "Rape", "Rape", "Not implemented");
}

//Repeat encounter
public function repeatJojoEncounter():void {
	showJojo();
	clearOutput();
	if (pc.hasStatusEffect("Infested")) {
		output("As you approach the serene monk, you see his nose twitch, disturbing his meditation.\n\n");
		output("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body.</i>\", Jojo says flatly. \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may leave lasting impressions upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n");
		//Choices time!
		clearMenu();
		addButton(0, "Meditate", meditateInForest);
		addButton(1, "Purge", jojoWormRemoval, null, "Purge", "Request him to purge the worms from your body.");
		addDisabledButton(4, "Rape", "Rape", "Not implemented");
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
		return;
	}
	output("Jojo the monk appears before you, robes and soft white fur fluttering in the breeze.  He asks, \"<i>Are you ready for a meditation session?</i>\"");
	//Choices time!
	processTime(2);
	clearMenu();
	addButton(0, "Accept", meditateInForest);
	addButton(1, "Decline", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	addDisabledButton(4, "Rape", "Rape", "Not implemented");
}

public function meditateInForest():void {
	showJojo();
	clearOutput();
	output("Jojo smiles and leads you off the path to a small peaceful clearing.  There is a stump in the center, polished smooth and curved in a way to be comfortable.  He gestures for you to sit, and instructs you to meditate.\n\nAn indeterminate amount of time passes, but you feel more in control of yourself.  Jojo congratulates you, but offers a warning as well.  \"<i>Be ever mindful of your current state, and seek me out before you lose yourself to the taints of this world.  Perhaps someday this tainted world can be made right again.</i>\"");
	
	//dynStats("str", .5, "tou", .5, "int", .5, "lib", -1, "lus", -5, "cor", (-1 - pc.countCockSocks("alabaster")));
	processTime(100 + rand(40));
	if(pc.libido() > 5) pc.slowStatGain("libido", -1);
	pc.lust( -30);
	pc.cor( -1);
	
	if (IncrementFlag("COC.JOJO_MEDITATION_COUNT") % 5 == 0)
	{
		output("\"<i>It seems you have quite a talent for this.  We should meditate together more often.</i>\"");
		output("\n\nYou ponder and get an idea - the mouse could stay at your camp.  There's safety in numbers, and it would be easier for the two of you to get together for meditation sessions.  Do you want Jojo's company at camp?");
		clearMenu();
		addButton(0, "Yes", acceptJojoIntoYourCamp);
		addButton(1, "No", mainGameMenu);
		return;
	}
	
	output("\n\nHe bows his head sadly and dismisses you.");
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function acceptJojoIntoYourCamp():void {
	showJojo();
	//if (pc.findStatusAffect(StatusAffects.EverRapedJojo) >= 0 || flags["COC.JOJO_MOVE_IN_DISABLED] == 1) {
		//output("You offer Jojo the chance to stay at your camp, but before you can finish your sentence he shakes his head 'no' and stalks off into the woods, remembering.");
	//}
	//else {
		clearOutput();
		output("You offer Jojo the chance to stay at your camp.  He cocks his head to the side and thinks, stroking his mousey whiskers.\n\n\"<i>Yes, it would be wise.   We would be safer together, and if you like I could keep watch at night to keep some of the creatures away.  I'll gather my things and be right there!</i>\"\n\nJojo scurries into the bushes, disappearing in a flash.  Knowing him, he'll be at camp before you!");
		flags["COC.JOJO_IN_CAMP"] = 1;
	//}
	processTime(2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Jojo In Camp
// Player approaches pure Jojo in camp, gets offer to mediate if > 10 cor -- responses
//[Yes]
public function acceptOfferOfHelp():void
{
	clearOutput();
	showJojo();

	output("<i>“Thank Marae.  You’re much stronger than I, my friend... to hold so much corruption and still retain your will.  But let us not tempt fate,”</i> he says before the two of you get to it.\n\n");
	processTime(1);

	jojoFollowerMeditate(false);
}

//[No]
public function refuseOfferOfHelp():void
{
	clearOutput();
	showJojo();

	output("You assure Jojo you're fine, and that you'll consider his offer.  “<i>But... I... we...</i>” he stammers. “<i>Alright, but please do not let the corruption get the better of you.  You’re my friend and I couldn't bear to lose you to its vile influence.</i>”  He recomposes himself and asks, “<i>So... is there anything I can assist you with?</i>”\n\n");
	jojoCampMenu();
}

public function campCorruptJojo():Boolean {
	return false;
}

public function jojoCamp():void {
	clearOutput();
	showJojo();
	if (flags["COC.AMILY_MET_PURE_JOJO"] == undefined && flags["COC.AMILY_FOLLOWER"] == 1 && amilyFollower()) {
		amilyMeetsPureJojo();
		return;
	}
	if (flags["COC.JOJO_RATHAZUL_INTERACTION_COUNTER"] == 1 && rand(2) == 0) {
		catchRathazulNapping();
		return;
	}
	if (pc.hasStatusEffect("Infested")) { // Worms overrides everything else
		output("As you approach the serene monk, you see his nose twitch.\n\n");
		output("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body,</i>\" Jojo says flatly, \"<i>This is a most unfortunate development.  There is no reason to despair as there are always ways to fight the corruption.  However, great effort will be needed to combat this form of corruption and may have a lasting impact upon you.  If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n");
		jojoCampMenu();
		return;
	}
	if (pc.cor() > 10 && flags["COC.JOJO_LAST_MEDITATION"] != days) { //New "offer of help" menu
		if (pc.cor() >= 40) {
			output("You walk toward the boulder where Jojo usually sits, and as soon as you're close Jojo approaches you with urgency.  \"<i>By Marae! [pc.name], we must do something! I feel the corruption surrounding you like a dense fog.  We need to meditate or I’m going to lose you!</i>\" Jojo pleads.\n\n");
		}
		else {
			output("You walk up to the boulder where Jojo usually sits, and see him sitting cross legged with his eyes closed.  He seems to be deep in meditation, but when you approach his eyes open suddenly and he gets up appearing slightly distressed, “<i>Uh... [pc.name], I can feel a bit of corruption within you.  It is not much, but I think you should be concerned about it before it gets out of hand and you do something you might regret.  If you want to I'd be happy to meditate with you as you rid yourself of it.</i>” he offers with a concerned look on his face.\n\n");
		}
		output("Do you accept Jojo's help?\n\n");
		clearMenu();
		addButton(0, "Yes", acceptOfferOfHelp);
		addButton(1, "No", refuseOfferOfHelp);
		addDisabledButton(4, "Rape", "Rape", "Not implemented");
		//addButton(2, "Rape", jojoAtCampRape);
	}
	else { //Normal shit
		if (cor() > 10)
			output("You walk up to the boulder where Jojo usually sits, and see him sitting cross legged with his eyes closed.  He seems to be deep in meditation, but when you approach his eyes open suddenly and he gets up appearing slightly distressed, “<i>Uh... [pc.name], " + (cor() >= 40 ? "I feel the corruption surrounding you like a dense fog.  We need to meditate more or I’m going to lose you!" : "I still can feel a bit of corruption within you.  It is not much, but I think you should be concerned about it before it gets out of hand and you do something you might regret.") + "  If you want to I'd be happy to meditate with you as you rid yourself of it.</i>” he offers with a concerned look on his face. \n\n");
		else {
			switch (rand(3)) {
				case 0: output("You walk toward the boulder where Jojo usually sits, and see him cross legged with his eyes closed.  At first he seems to be deep in meditation, but when you approach his mouth curls into a smile; he gets up and opens his eyes regarding you with a welcoming expression.  “<i>Greetings [pc.name], is there anything I can assist you with?</i>”\n\n");
						break;
				case 1: output("You walk up to the boulder where Jojo usually sits and find him a few paces behind it. He is standing and practicing his form, gracefully moving from one pose to the next. As you approach him you see his ears visibly perk and he turns his head towards you without breaking his stance, saying, “<i>Greetings [pc.name], is there anything I can assist you with?</i>”\n\n");
						break;
				default: output("You find Jojo sitting cross-legged on a flat rock with his staff leaning against his shoulder, thinking.  He looks to you and nods, \"<i>Greetings, " + pc.short + ".  Is there something I could do to assist you?</i>\"\n\n");
			}
		}
		jojoCampMenu();
	}
}

private function jojoCampMenu():void {
//Normal Follower Choices
//[Appearance] [Talk] [Train] [Meditate] [Night Watch toggle]
	clearMenu();
	addButton(0, "Appearance", jojoAppearance, null, "Appearance", "Examine Jojo's appearance.");
	addButton(1, "Talk", talkMenuJojo, null, "Talk", "Discuss with him about topics.");
	
	if (flags["COC.UNLOCKED_JOJO_TRAINING"] == 1) addButton(2, "Train", apparantlyJojoDOESlift, null, "Train", "Join him in a training session.");
	else addDisabledButton(2, "Train", "Train", "You should talk to him more!");
	
	if (flags["COC.JOJO_LAST_MEDITATION"] != days) addButton(3, "Meditate", jojoFollowerMeditate, true);
	else addDisabledButton(3, "Meditate", "Meditate", "Already done today.");
	
	addButton(4, flags["COC.JOJO_NIGHT_WATCH"] > 0 ? "N.Watch:ON" : "N.Watch:OFF", jojoDefenseToggle, null, "Night watch", (flags["COC.JOJO_NIGHT_WATCH"] > 0 ? "Request him to stop guarding the camp.": "Request him to guard the camp at night."));
	if (pc.hasStatusEffect("Infested")) addButton(5, "Purge", jojoWormRemoval, null, "Purge", "Request him to purge the worms from your body.");
	//if (cor() > 10 && pc.lust >= 33 && pc.gender > 0 && flags["COC.DISABLED_JOJO_RAPE"] <= 0) addButton(8, "Rape", jojoAtCampRape, null, null, null, "Rape the poor monk mouse-morph." + (cor() < 25 ? "  Why would you do that?": ""));
	addButton(14, "Leave", campFollowersMenu);
}

//Appearance
public function jojoAppearance():void
{
	clearOutput();
	showJojo();
	//output(images.showImage("jojo-appearance"));
	output("Jojo is a white furred mouse-morph with dish-like ears and a small muzzle below a sometimes twitchy nose. He watches you with striking blue eyes.\n\n");

	output("He's wearing pale blue monk robes that are form fitting yet loose enough to allow him to move freely if the need arises. He also wears prayer beads, a cloth sash that holds his robe close and baggy pants cover his legs all the way to his mouse-like footpaws; on the back of his pants a small hole is cut to allow his ropy pink tail freedom.\n\n");

	output("It's hard to estimate due to his clothing, but you can tell he is pretty lean and doesn't have much in the way of muscle; which makes sense since his martials arts rely more on speed than strength anyways.\n\n");

	output("His weapons of choice are his fists and a polished wooden staff he wields with practiced hands, right now it is tucked away in his bed roll.\n\n");
	clearMenu();
	addButton(0, "Next", jojoCamp);
}

public function talkMenuJojo():void
{
	if (flags["COC.TIMES_TALKED_WITH_JOJO"] == undefined) flags["COC.TIMES_TALKED_WITH_JOJO"] = 0;
	showJojo();
	clearOutput();
	clearMenu();
	output("“What's on yor mind, [pc.name]?”");
	addButton(0, "Village", jojoTalkVillage, null, "Village", "Ask him about the village he was raised in.");
	addButton(1, "Monks", jojoTalkJoiningTheMonks, null, "Monks", "Ask him about how and why he became a monk.");
	addButton(2, "MonksFall", jojoTalkFallOfTheMonks, null, "MonksFall", "Ask him about the demise of the monks.");
	addButton(3, "Forest", jojoTalkForestConvo, null, "Forest", "Ask him about how he ended up in the forest.");
	if (flags["COC.TIMES_TALKED_WITH_JOJO"] >= 4) addButton(4, "You", jojoTalkYourOrigin, null, "Your past", "Tell him about Ingnam and your history.");
	if (flags["COC.FACTORY_SHUTDOWN"] > 0) addButton(5, "Factory", jojoTalkFactory, null, "Demonic factory", "Tell him about how you've shut down the factory.");
	if (flags["COC.SAND_WITCHES_COWED"] == 1 || flags["COC.SAND_WITCHES_FRIENDLY"] == 1 || flags["COC.SAND_MOTHER_DEFEATED"] == 1) addButton(6, "SandCave", jojoTalkSandCave, null, "Sand Witches Cave", "Tell him about your encounter in the Sand Cave in the desert.");
	if (flags["COC.UNLOCKED_JOJO_TRAINING"] == undefined && flags["COC.TIMES_TALKED_WITH_JOJO"] >= 4) addButton(7, "Training", apparantlyJojoDOESlift, null, "Training", "Ask him if he's willing to train you.");
	//if (flags["COC.MINERVA_PURIFICATION_JOJO_TALKED"] == 1 && flags["COC.MINERVA_PURIFICATION_PROGRESS"] < 10) addButton(8, "Purification", kGAMECLASS.highMountains.minervaScene.minervaPurification.purificationByJojoPart1, null, null, null, "Ask him if he can exorcise the demonic parasite infesting Minerva.");
	//Sex button
	//if (cor() <= 10 && pc.lust >= 33) {
		//addButton(9, "Sex?", offerSexFirstTime, null, null, null, "Ask him if he's willing to have sex with you.");
		//if (flags["COC.TIMES_TALKED_WITH_JOJO] < 4) addLockedButton(9, "You should socialize with Jojo a bit more.");
		////if (pc.findStatusAffect(StatusAffects.EverRapedJojo) >= 0) addLockedButton(9, "You've raped Jojo in the past, now you can't ask him out.");
	//}
	//if (cor() <= 10 && pc.lust >= 33 && monk == -1) addLockedButton(9, "You need to spend more time with Jojo. \n\nTalk sessions: " + flags["COC.TIMES_TALKED_WITH_JOJO] + "/6 \nTraining sessions: " + flags["COC.TIMES_TRAINED_WITH_JOJO] + "/10 \nMeditation sessions: " + pc.statusAffectv1(StatusAffects.JojoMeditationCount) + "/10 \nYou must be pure enough and have sufficient lust as well.");
	//if (cor() <= 10 && pc.lust >= 33 && flags["COC.TIMES_TALKED_WITH_JOJO] >= 6 && flags["COC.TIMES_TRAINED_WITH_JOJO] >= 10 && pc.statusAffectv1(StatusAffects.JojoMeditationCount) >= 10 && monk > -3) addButton(9, "Sex?", offerSexFirstTimeHighAffection, null, null, null, "You've spent quite the time with Jojo, maybe you can offer him if he's willing to have sex with you?"); //Will unlock consensual sex scenes.
	//if (monk <= -3) removeButton(9);
	addButton(14, "Back", jojoCamp);
}

//Talk
//Jojo’s Past

//Village Convo
public function jojoTalkVillage():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You decide to ask Jojo about his village.\n\n");
	output("He speaks softly with a smile on his face and in his voice, “<i>It was a small village near a large beautiful lake. We were peaceful people who laughed and trusted one another, just good simple folk you know?”\n\n");
	output("“Most of the people of Belridge were either fishers or farmers with huge families that stayed near the village. There were a few hunters and a few craftsmen. We made enemies of no one and sought to do no harm to others,</i>” Jojo says, his smile fading.\n\n");
	output("Before you can muster a reaction to his sadness, his fuzzy cheeks spread again as he looks up at you with bright eyes.\n\n"); 
	output("“<i>My father was a fisherman.  He was this calm, strong man with a lot of silver whiskers that always smelled like fish.  I remember I used to go out on the boat with him and a few of my brothers and he’d always make sure to pick me up and put me on his shoulders... that is until I got too big. He always made everything look so easy, like the world was just there to shake his hand and make him smile. No one could cook seafood like he did, no one.</i>”\n\n");
	output("“<i>Then there was my mother who was a little high strung, but no one could hug you more fiercely or love you more dearly.  She was a small woman with a big soul who loved her family more than anything.  She was a seamstress before she met my dad and was always the brightest one in the room, which is hard when you have seventeen loud children clamoring for your attention.</i>”\n\n");
	output("“<i>Even with 19 people living under one roof my family wasn’t the biggest family in town, but there was always plenty work and plenty food.  It was a nice simple existence and I am thankful for the time I had with everyone in that village,</i>” he finishes with a serene smile.\n\n");

	if (pc.cor() < 40)
	{
		output("Looks like Jojo's childhood wasn't so bad... you thank the mouse morph monk for sharing his treasured memories with you now that the conversation is over.\n\n");
	}
	else
	{
		output("Looks like Jojo’s childhood wasn’t so bad. A little sickly sweet and void of wet pussies and drooling dicks but not bad. You tell him you’re happy to have him near you and he smiles for ear to ear, ignorant of your thoughts.\n\n");
	}

	processTime(5);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Joining the Monks convo
public function jojoTalkJoiningTheMonks():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You decide to ask Jojo why he decided to become a monk in the first place.\n\n");
	output("He gives you a warm smile as he speaks, “<i>Well I grew up in a big family of 19 so when I was younger I was always the quiet one.  I guess I was just introverted but being quiet meant that I didn’t always get a lot of attention.  It didn’t bother me, quite the opposite actually, I enjoyed quiet introspection but with so many brothers and sisters it was next to impossible to get a quiet moment at home.</i>”\n\n");
	output("“<i>So I would sneak out. My father understood but it drove my mother crazy.  Whenever she noticed I had slipped away she would stop everything in the house and take my two oldest brothers to come find me.  I never understood why it was such a big deal.  We were in a small village near a prestigious monastery, we were safe.  Parents let their kids go out and play and run and explore because everyone knew everyone but not my mom.  She had to know where you were going, what you were doing and how long until you got back. I would’ve told her but saying I wanted to explore wasn’t a satisfactory answer.</i>”\n\n");
	output("“<i>Whenever she found me she would yell for a bit and then hold me close like she’d just watched me dodge a charging rhinoceros.  Whenever she asked why I did it I just told her the truth, it was too loud and crowded at home.  After a few weeks of this she suggested a compromise.  She said I could leave if I had one of my older brothers walk me to the temple and I stayed there where the clergy could see me and keep me safe and fed.  Honestly I think my dad came up with the idea, he was always good at compromising and keeping the peace.</i>”\n\n");
	output("“<i>The temple became very important to me.  I read about the world, I spoke to the clergy and I sat and thought.  I was enraptured with learning but I didn’t want to be a priest, I don’t know why... I guess it just didn’t appeal to me.  When I first saw the monks visiting the temple, it was like dawn breaking.  After that I waited until I was old enough to join and made the short pilgrimage to the Monastery of the Celestial Lotus.</i>”\n\n");
	output("Jojo wears this quiet little smile as he finishes.  Then he chuckles and says, “<i>Thank you for the memories, [pc.name].  I enjoy our talks.</i>”\n\n");

	processTime(5);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Fall of the Monks convo
public function jojoTalkFallOfTheMonks():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You decide to ask Jojo if he'd be willing to tell you exactly what happened to the monks of his order.\n\n");
	output("Jojo speaks with eyes downcast and a voice soft as feathers landing on fallen soldiers, “<i>Truthfully?...  I don’t know exactly how it happened... or why... but my order was wiped out.  Though I've looked for my brothers and sisters of the Celestial Lotus ever since then, I'm the only survivor, as far as I can tell.  You see the demons attacked the monastery while I was away with one of the senior brothers.  I was a mere novice and he was one of the more fun teachers so we lost track of time.  The sun was setting and we were halfway back to the monastery when we saw what we thought was a huge column of smoke rising from the central building.  When we got closer we saw the cloud for what it truly was, a billowing tower of those imps.  We were spotted and several of them came flying at us - they crossed the distance far faster than we could have.</i>”\n\n");
	output("“<i>Senior Brother Logray didn't hesitate - he leapt in front of me, staff twirling, shattering skulls and breaking limbs with each sweep.  As he barred their path, he cried out to me to flee, to run for the safety of the village... and I did.  Overwhelmed by the bitter-sweet stink of corruption wafting off the demons, I ran like a frightened little field mouse.  I was a coward and I left my masters and all my friends to face the horde one mouse short.</i>”\n\n");
	output("You watch as Jojo bows his head in shame for a moment. Yet when he looks back up there’s fire in his eyes.\n\n");
	output("“<i>Never again....</i>”\n\n");
	output("You try to comfort Jojo, telling him he couldn’t have made a difference being but a single mouse, but he waves you off.  He tells you he is fine and thanks you for your concern.\n\n");
	output("You can tell the story has affected him, but you’re surprised to hear the resolve in his voice and see the defiant strength in his eyes. Excusing yourself, you rise and leave him to do as he will.\n\n");

	processTime(5);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Forest Convo
public function jojoTalkForestConvo():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You think for a while and decide to ask Jojo how he ended up in the forest.\n\n");
	output("He looks at you with suddenly tired eyes as he says, “<i>Well, I was training in the fields with one of the senior brothers when we saw the monastery was under attack.  He sent me to the village to save me since I was a novice.  I decided to rally the people there.  I figured that I had ran like a coward, I wasn’t going to hide like one.  It was the village where I was born and a home to many of my brothers and sisters, both figuratively and literally.  I ran towards the village with everything I had, hoping to redeem my cowardice by returning with a militia of mice to aid the members of my order.</i>”  His voice catches and he looks away, obviously struggling to form words.\n\n");
	output("When you open your mouth to speak he raises his hand, asking for a moment with a single furry finger.\n\n");
	output("“<i>I was too late.  The demons had struck there first, then moved on to my monastery once they were finished.  I spent hours searching the streets; every basement, every alley, every attic, every place I could think of where somebody might have hidden.  Nothing but ruined buildings, smears of assorted tainted bodily fluids, and the occasional corpse - some demons, many more mice.</i>”\n\n");

	if (pc.cor() < 35)
	{
		output("That's terrible... you can only imagine what you'd feel like if you returned to Ignam and saw it destroyed... your family, your friends... You put a hand on the monk's shoulder, intent on comforting him for the moment.\n\n");
	}
	else if (pc.cor() >= 35 && pc.cor() <= 75)
	{
		output("Tough luck... thankfully your village still stands and you doubt any demons would dare attack on your watch...  You feel like you should do something for the monk though, so you put a hand on his shoulder, comforting him for the moment.\n\n");
	}
	else
	{
		output("Mice... must've been a village of wimps if a few demons could take them out... The monk is obviously distressed... maybe you should comfort him for the moment, if only to make him stop.  You put a hand on his silent shoulder...\n\n");
	}

	output("“<i>Thank you [pc.name].  I was born there and seeing that...</i>”  The monk falls silent again.\n\n");

	if (pc.cor() < 35)
	{
		output("You slide an arm around Jojo’s shoulders in an attempt to reassure the monk.  He manages a smile in response as he looks up at you.  A single tear manages to slide down his muzzle as he says, “<i>Thank you, my friend.</i>”\n\n");
	}
	else if (pc.cor() >= 35 && pc.cor() <= 75)
	{
		output("You try to further console the distressed monk by moving your hand to his back and giving him a few friendly taps.  Jojo visibly pulls himself together. “Thank you, I’m alright now,” he tells you as he looks up and gives you a weak smile.\n\n");
	}
	else
	{
		output("Seeing an opportunity, you wrap your arms around the monk as he silently tries to reign in his emotions.  Holding him close you can feel the mouse morph’s lean muscles as you rub his back ‘accidentally’ going too low and feeling the base of his tail and the top of his tight little pert ass.  As you ‘hug’ the mouse you make sure he doesn’t notice your true intentions and when you release him he actually thanks you.\n\n");
		pc.lust(10);
	}

	output("After you’ve comforted the monk you ask him what he did next.\n\n");

	output("When he answers you his shoulders are squared and his voice has regained some of its former volume, “<i>I did what anyone looking at the shattered remains of their life would.  I buried them.  For the next few hours I took the time to lay each and every villager to rest before praying over them all.  Then I went back to my monastery, praying with all my heart that they had managed to hold out, at least long enough to escape rather than to be captured and twisted into perverse shells of their former selves.  Yet the monastery was another graveyard.  I found many bodies there.  Some were of the order but there were also countless imps and more than a few demons.  The place was defiled with semen and milk reeking of corruption.</i>”\n\n");
	output("You see anger in the monk’s eyes as he clenches his fists, “<i>They had utterly defiled the monastery and there was nothing I could do about it but honor its memory.  I labored for what felt like days; burying the fallen; seeking out survivors; gathering what few items of my faith had escaped demonic desecration.</i>”  He touches the large beads around his neck meaningfully.\n\n");
	output("“<i>Then, I burned the monastery to the ground and set fire to all the fields...  Since that day, I have eked out a meager existence in the wilderness; I study the texts I can, train my body as best I can, and seek to fortify my soul against demonic blandishments.  Though I have technically progressed far along my path, with no master and only a pale echo of a fraction of my order’s texts at my disposal, I may never be a true master in my own right.</i>”\n\n");
	output("He gives you an appraising look before looking away, “<i>Until I met you, [pc.name], my only purpose had been to find the demons who destroyed my order and make them pay for the lives they took.  That is why I was in the forest, I was in the middle of a harsh training regimen to increase my power and skill so that I may seek out those evil brutes who took everything I loved away from me... but vengeance is not the way of the Celestial Lotus.  The Celestial doesn’t train bullies or assassins.  Finding you and aiding in your quest to protect your village from these demonic creatures of perversion gave me new purpose and would make my departed brothers and sisters proud.  I can’t honestly say I’ve given up on having my vengeance but... I will aid you in your quest first if for nothing more than to honor our friendship and honor the memory of the order and its teachings.</i>\n\n");
	output("Looking renewed and at peace despite the emotional storm you know must be raging within his tiny frame Jojo returns to what he was doing after thanking you for giving him new purpose.\n\n");

	processTime(10);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Yourself
//Origin
public function jojoTalkYourOrigin():void // Prob tack on some interaction count or something to unlock this
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");
	
	output("As you start up a conversation with Jojo, the two of you speak at length about nothing really important or noteworthy, just small talk.  That is until the monk brings up the subject of your background.  You tell him about Ingnam and your family there, and the tradition of sending a champion through the portal.  When he asks why anyone would choose to come here, you tell him how legends say that in years a champion wasn’t sent through the portal, terrible things happened to the village.\n\n");
	output("“<i>That portal?</i>” Jojo asks, pointing to the very portal you stumbled through. You nod and he asks, “<i>So... what were you like in Ingnam?</i>”\n\n");

	if (pc.hasPerk("History: Alchemist"))
	{
		output("You tell Jojo that you were the assistant to Riku, an alchemist residing in your village.  He asks questions about your time with the alchemist and how you family felt about you taking up alchemy.  You tell him that you were just about to go into advanced studies when it was announced that you were the next champion and all you really learned was how to increase the potency of certain types of items.\n\n");
	}
	else if (pc.hasPerk("History: Fighter"))
	{
		output("You tell Jojo about how, growing up, you got into fights a lot.  You name names and tell him why and how each of those little brats had got what was coming to them. You tell him how you had planned to join the village guard, but that became a pipe dream when it was announced that you were the next champion.\n\n");
	}
	else if (pc.hasPerk("History: Healer"))
	{
		output("You tell Jojo about how you spent a lot of your time at the side of Dende, the village healer. You talk about why you wanted to spend time with the older man as he looked after the sick and infirm and the skills you learned there. You let him know how you had just decided to train to become an official healer when you were announced to be the next champion.\n\n");
	}
	else if (pc.hasPerk("History: Religious"))
	{
		output("You tell Jojo about how you spent most of your time in the temple. He seems to really like hearing about the differences in religious practices between the Celestial Lotus and your village. You tell him about the various clergy of your hometown and how Sister Esther took time to teach you about meditation.\n\n");
	}
	else if (pc.hasPerk("History: Scholar"))
	{
		output("You tell Jojo about your insatiable thirst for knowledge and how you spent a lot of time in school. You tell him the story about how you ‘convinced’ Mr. ");
		if (silly) output("Savin");
		else output("Sellet");
		output(" to let you read some of the rare books in his collection, skipping over how much begging and pleading was actually involved.\n\n");
	}
	else if (pc.hasPerk("History: Slut"))
	{
		output("You tell Jojo about how you spent time... making friends.  Jojo looks at you weirdly and when you tell him you had a lot of friends....\n\n");
		output("“<i>That’s nice I guess [pc.name] but didn’t you have aspirations beyond being, erm... popular?</i>” he questions.\n\n");
		output("You laugh and tell him that you were just really good and making friends, instead of the truth about how much of a slut you actually were.\n\n");
	}
	else if (pc.hasPerk("History: Slacker"))
	{
		output("You tell Jojo about how you spent your time basically relaxing with your fiends.  You gloss over how big of a lazy bum you were with stories of the times you generally made a nuisance of yourself.  You don’t tell him that you’re pretty sure you were chosen as the next champion in order to be gotten rid of.\n\n");
	}
	else if (pc.hasPerk("History: Smith"))
	{
		output("You tell Jojo about how you spent your time training to become a blacksmith.  Not knowing much about smithing he asks questions about the things you learned and you answer them to the best of your ability.  To finish you describe the process of fitting armor in great detail and how you were going to start learning advanced techniques but were announced to be the next champion.\n\n");
	}
	else if (pc.hasPerk("History: Whore"))
	{
		output("You tell Jojo about how you spent a lot of your time... making money.  When the naive little monk asks how, you just smile as you fondly remember the older whore, Poison, showing you the ropes and teaching the tricks of the trade.  Regardless of how it made people think of you, it was certainly good money.  In an attempt to hide some of the messier details of your past from the monk, you explain how you accepted... odd jobs for people, important work that not many others in the village would be willing to accept.  He seems confused but shrugs it off.\n\n");
	}
	else if (pc.hasPerk("History: Fortune"))
	{
		output("You tell Jojo about how you're lucky and you've made quite a bit of money.  When the monk asks how, you shrug and tell him it's just plain luck.\n\n");
	}
	else
		output("Somehow, you don’t seem to have a defined history...\n\n");

	output("Jojo smiles now that he has gotten to know you a little better. After a little bit more small talk, the two of you decide the conversation is over and part ways.\n\n");

	processTime(10);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Dungeon Convo: Factory
//Requirements: Completed Demon Factory -- flags["COC.FACTORY_SHUTDOWN] > 0
public function jojoTalkFactory():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You tell Jojo about your having successfully found and stopped the demonic factory.  You tell him how you found out the factory was there and how you defeated the demons inside. He seems impressed.\n\n");

	if (flags["COC.FACTORY_SHUTDOWN"] == 2)
	{
		output("His ears perk at the news as you continue, telling him that you destroyed the factory controls, which permanently shut down the factory - but released an enormous quantity of corrupted fluids into the environment.\n\n");

		output("Jojo cocks his head to the side as he considers his words carefully before speaking, “<i>I guess it seems like the right move.  Permanently disabling the factory would not only deal a heavy blow to the demons, but also give the rest of us time to reclaim the forest... but I don’t know.  If the release of fluids was as much as you say it was then there’s a chance that it’ll do more harm than good.  I’ve seen what corruption does to this world and that much corrupted fluid flooding out all at once could really hurt our cause. I’m not saying it was the wrong thing to do, or lessening your accomplishment, but you have to be careful.  The demons aren’t just powerful, they’re deceptive.</i>”\n\n");

		output("You listen to the monk’s council and despite his concerns he seems genuinely happy to hear you’ve struck a blow against the demonic regime.\n\n");
	}
	else
	{
		output("His ears perk at the news as you continue, telling him that you shut down the factory and destroyed the controls, for the sake of the surrounding environment.\n\n");
		output("Jojo’s chest swells with pride as he looks at you with new eyes before saying, “<i>Wow [pc.name], I don’t know what to say.  I know it uprooted your life and took you away from the ones you love but I sincerely believe that the day you came through that portal was a good day for all of Mareth.  I am proud of you and humbled by the fact that I can call you my friend.</i>”  He rises and gives you a hug of fierce devotion and friendly affection before pulling away and saying, “<i>We’ll have to watch the factory though... the demons can’t be allowed to reopen that evil place.</i>”\n\n");
	}

	output("Once the two of you are done discussing the demonic factory Jojo excuses himself to think on what you’ve told him.\n\n");

	processTime(4);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Dungeon Convo: Sand Cave
//Requirements: Completed Sand Witch Dungeon
public function jojoTalkSandCave():void
{
	clearOutput();
	showJojo();
	IncrementFlag("COC.TIMES_TALKED_WITH_JOJO");

	output("You tell Jojo about your discovery of a cave that served as a base for the sand witches of the desert. You tell him about the whole ordeal, and he listens with wide eyes and jaw agape. When you tell him about meeting the Sand Mother Jojo gasps.\n\n");
	output("“<i>Wait... so you mean to tell me that these sand witches a-are... allies of Marae?  But they’re s-so... sexual.</i>”  He seems genuinely confused, but you tell him that sex is part of nature after all, and that there is nothing wrong or shameful about it.  He agrees with you, but decries the way the sand witches use their power.\n\n");

	//if PC raped Sand Mother
	if (flags["COC.SAND_WITCHES_COWED"] == 1)
	{
		output("You describe your battle with the Sand Mother in an animated blow by blow and when you get to the end where you raped the Sand Mother you look at Jojo and... lie.  You completely gloss over the fact that you sexually assaulted the Sand Mother because despite his interest he is a little naive and offended by the world of sexual conquest.  He appraises your actions, ignorant of what actually occurred.\n\n");
	}
	//if PC spoke to Sand Mother after Fighting her
	// FRIENDLY is the overall victory flag (theres a separate flag used to indicate you dun wanna be attacked by sandbitches in the desert anymore)
	else if (flags["COC.SAND_WITCHES_FRIENDLY"] == 1 && flags["COC.SAND_MOTHER_DEFEATED"] == 1)
	{
		 output("You describe your battle with the Sand Mother in an animated blow by blow. When you get to the end you tell him about how reasonable the Sand Mother actually was after you beat her.\n\n");
		 output("Jojo’s head tils to the side as he says, “<i>Maybe the whole thing didn’t need to come to an altercation in the first place, a little diplomacy on both sides....</i>”  He gives you a pointed look, “<i>Might have gone a long way.</i>”\n\n");
	}
	//if PC just spoke to the Sand Mother
	else if (flags["COC.SAND_WITCHES_FRIENDLY"] == 1 && flags["COC.SAND_MOTHER_DEFEATED"] != 1)
	{
		output("You tell Jojo about how the Sand Mother spoke with you once you had battled your way to her.  You tell him she was reasonable and how the whole thing was, in the end, a simple misunderstanding.\n\n"); 
		output("He marvels at the way you handled the situation, “<i>Many would have expected her trying to talk to them to be a trap [pc.name] and hurried to attack her but not you... that is... wow [pc.name], you are truly a great individual.</i>”\n\n");
	}
	
	//[if {PC met bath slut} 
	if (flags["COC.MET_MILK_SLAVE"] == 1)
	{
		output("You tell Jojo about the poor mind addled thing you found sitting in a tub of milk acting as a slave to the sand witch coven.\n\n");
		output("He shudders like a child being told a scary story and asks, “<i>What did you do?</i>”\n\n");

		//[if {PC hasn’t spoken to Sand Mother about Bath Slut yet} 
		// Can't differentiate this
		// All I have is HAS_MET and HAS_RECRUITED effectively
		if (flags["COC.MILK_NAME"] == undefined)
		{
			output("You tell Jojo about how the Sand Mother told you the bath girl was unfit to be free and how they care for her because she can’t care for herself.\n\n");
			output("Jojo reacts by putting his chin in his hands and thinking, “<i>Well... I guess that’s the human thing to do, especially since she doesn’t seem to be corrupted.  Maybe these sand witch covens aren’t all bad, still hard to believe that they’re on our side though....”  He looks up and shrugs, “<i>Any act of charity though is a good thing.  I do hope the poor girl will be alright.</i>”\n\n");
		}
		// [if {PC has bath slut in camp}
		else
		{
			output("As the question leaves his lips you give Jojo a confused look and, with a glance, direct his gaze toward " + flags["COC.MILK_NAME"] + ".\n\n");
			output("He slaps his own forehead and says, “<i>Oh... yeah... right.</i>” Obviously embarrassed by not putting two and two together. He smiles good naturedly though, “<i>I don’t know I guess I just assumed you found some poor mind addled soul and decided to save her.</i>” Jojo says as he looks over at " + flags["COC.MILK_NAME"] + ".\n\n");

			//[if (bathSlutStage1 - unaltered)
			if (flags["COC.MILK_SIZE"] == undefined)
			{ 
				output("“<i>She’ll fare much better in our care than in the coven’s,</i>” he states with conviction.\n\n");
			}
			//[if (bathSlutStage2 - HHH) 
			else if (flags["COC.MILK_SIZE"] == 1)
			{
				output("“<i>She’s already much better than she was when she got here,</i>” he says with a grin.\n\n");
			}
			//[if (bathSlutStage3 - DD) 
			else
			{
				output("“<i>The coven wouldn’t have done what you’ve done for her.  You’ve given her a much, much better life and even aided in fixing her condition, you truly are a champion, [pc.name],</i>” he says, giving you a fond smile and a pat on the back.\n\n");
			}
		}	
	}

	// There's an untracked gap here, where the player doesn't accept a blessing from the Cum Witch, but there's no other existing tracking for this shit.
	//[if {PC met Cum Witch} 
	if (flags["COC.CUM_WITCH_DEFEATED"] == 1 || flags["COC.BEEN_BLESSED_BY_CUM_WITCH"] == 1)
	{
		output("You tell Jojo about the cum witch, the herm witch responsible for inseminating the witches there, acting as a father to the others.  When you do he scratches his ear, “<i>Like I said, I don’t get why sex is so overly important to these creatures but whatever, continue.</i>”\n\n");

		//[if {PC allowed Cum Witches to increase their numbers}
		if (flags["COC.MORE_CUM_WITCHES"] == 1)
		{
			output("You tell him how you tried to remedy the current cum witch’s situation by asking the Sand Mother to make more cum witches.\n\n");
			output("He whistles low, “<i>That’s a bold move [pc.name].  It seems like they would want that though, it’d allow them to, er, you know... more often, and make more sand witches in the long run wouldn’t it?</i>” As the question sound rhetorical you plow on ahead.\n\n");
		}
		//[if {PC allowed Cum Witches to rome}
		else if (flags["COC.CUM_WITCHES_FIGHTABLE"] == 1)
		{
			output("You describe to him how you convinced the Sand Mother to allow her cum witches to rome the desert along with the sand witches and he looks at you with astonishment, “<i>You are a generous spirit [pc.name] and this Sand Mother doesn’t seem entirely unreasonable.</i>”\n\n");
		}
		//[if {PC did nothing to help Cum Witch} 
		else
		{
			output("“You tell Jojo that you’re actually done. He says, “<i>Oh... well that’s weird.</i>” and after an awkward silence, the two of you burst out laughing.\n\n");
		}
	}

	output("Having concluded the conversation the two of you stand and Jojo gives you an appreciative pat on the shoulder, seeming more fond of you.\n\n");

	processTime(10);
	clearMenu();
	addButton(0, "Next", talkMenuJojo);
}

//Training
// Initiate first time as a talk option, and then display as a "base menu" option?
public function apparantlyJojoDOESlift():void
{
	clearOutput();
	showJojo();
	
	//{First Session only}
	if (flags["COC.UNLOCKED_JOJO_TRAINING"] == undefined)
	{
		flags["COC.UNLOCKED_JOJO_TRAINING"] = 1;
		output("You ask Jojo if he can teach you how to fight like a monk.\n\n");
		output("Jojo considers you for a moment before saying, “<i>Yes I can teach you the forms, skills and techniques I was taught by my order. Plus...</i>” Jojo gazes off into the distance, his attention drifing for a moment before he continues, “<i>since I am all that is left, it is up to me to bestow this knowledge upon a worthy soul.</i>”\n\n");

		if (pc.cor() >= 25)
		{
			output("Jojo frowns, “<i>I am willing to teach you [pc.name], when I can.  However I am no master, therefore I am unworthy of taking a disciple.  But as your friend, I will teach you what I know so that you may protect yourself.  I believe our time would be better spent meditating.  There is very little you can do with these techniques without first finding your center.</i>”\n\n");

			// Kick back to previous menu
			processTime(2);
			clearMenu();
			if (flags["COC.JOJO_LAST_MEDITATION"] != days) {
				addButton(0, "Meditate", jojoFollowerMeditate, null, "Meditate", "Accept offer and meditate now.");
				addButton(1, "Postpone", jojoCamp, null, "Postpone", "You have no time right now.");
			} else {
				addButton(0, "Next", jojoCamp);
			}
			return;
		}
		else
		{
			output("Jojo smiles, “<i>I am not a master, therefore I am unworthy of taking you on as a disciple... but as a friend I can teach you all I know.  Whenever you are ready, just ask.</i>.”\n\n");

			// Sounds like this should kick back to menu
			processTime(1);
			clearMenu();
			addButton(0, "Next", jojoCamp);
			return;
		}
	}
	// {Repeatable Generic Training Session Stuffs}
	else
	{
		if (pc.energy() < 60)
		{
			output("You ask the monk to continue your training; but he shakes his head.\n\n");
			output("“<i>Not yet [pc.name]. Your body must be fit and rested before our training sessions. Rest first, and come back to me later.</i>”\n\n");

			processTime(1);
			clearMenu();
			addButton(0, "Next", jojoCamp);
			return;
		}

		if (pc.cor() >= 25)
		{
			output("You ask the monk to continue your training; but he shakes his head.\n\n");
			output("“<i>I fear that your time would be better spend meditating before we continue your training. Would you like to do so now?</i>”\n\n");
			
			processTime(1);
			clearMenu();
			addButton(0, "Meditate", jojoFollowerMeditate, null, "Meditate", "Accept offer and meditate now.");
			addButton(1, "Postpone", jojoCamp, null, "Postpone", "You have no time right now.");
			return;
		}
	}

	IncrementFlag("COC.TIMES_TRAINED_WITH_JOJO");
	pc.energy( -60);

	// {If everything is cool}
	if (!pc.hasPerk("Controlled Breath"))
	{
		output("Jojo gives you a bright cheerful smile, “<i>Alright [pc.name]... let’s begin.</i>”\n\n");
		output("Jojo’s teaching style periodically switches between lecture and sparring.  When he explains a concept or a strike, he guides you through it before asking you to try it on him. He is patient but firm.  He doesn’t punish you when you make a mistake, instead, corrects you and asks you to try again.  He doesn’t allow you to give up, and his teaching style stops you from feeling frustrated.\n\n");
		output("The entire session is intense, and each brief lecture or demonstration serves as a quick break to stop your body from giving out, and help you build endurance.\n\n");
		output("By the end of the training session you are covered in sweat, your lungs heaving for breath.\n\n");
		output("As you bow to Jojo he bows back and says, “<i>Go get some rest [pc.name], you’ve earned it.</i>”\n\n");
		
		if (flags["COC.TIMES_TRAINED_WITH_JOJO"] >= 5)
		{
			output("“<i>Breathing is key.</i>”\n\n");
			output("Jojo’s constantly repeated words resonate within you as you realize you’ve learned to control your breathing. It takes you less time to rest than normal and you feel as though you are bursting with energy because of it.  Your [pc.fullChest]");
			if (pc.biggestTitSize() == 0) output(" rises and falls");
			else output(" rise and fall");
			output(" smoothly even in the heat of battle.  From now on you know you’ll recover more quickly.\n\n");

			output("<b>(Perk Gained: Controlled Breath -</b> Increases rate of energy regeneration.<b>)</b>");
			pc.createPerk("Controlled Breath", 0, 0, 0, 0, "Increases rate of energy regeneration.");
		}
	}
	//{after the PC has gained the controlled breath perk}
	else if (!pc.hasPerk("Cleansing Palm"))
	{
		output("Jojo gives you a big toothy grin, “<i>Alright [pc.name]... let’s begin.</i>”\n\n");
		output("Jojo switches up the way he is instructing you.  Largely due to your increased endurance, the two of you spend more time moving through forms together and practicing strikes and maneuvers.  When it comes time for a brief lecture, he breaks out one of the few scrolls he has from his order and tells you what he knows about the contents.\n\n");
		output("Before too long, the two of you are up again and practicing forms and mock strikes, even sparring briefly from time to time.  By the end of the intense training session you are covered in sweat... but so is Jojo, and neither of you are out of breath. As you bow to Jojo he returns the gesture and says, “<i>Go get some rest [pc.name], you’ve earned it.</i>”\n\n");
		
		if (flags["COC.TIMES_TRAINED_WITH_JOJO"] >= 10)
		{
			output("The repeated movements are slowly starting to sink in, your muscles becoming accustomed to Jojo’s training.\n\n");
			output("By the end of the training session with the mouse, you think that you may have picked up something that might help against the denizens of this world.\n\n");

			output("<b>(Ability Gained: Cleansing Palm -</b> A ranged fighting technique of Jojo’s order, allows you to blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.<b>)</b>")
			pc.createPerk("Cleansing Palm", 0, 0, 0, 0, "Blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.");
		}
	}
	//{after the PC has gained the Cleansing Palm attack}
	else if (!pc.hasPerk("Enlightened"))
	{
		output("Jojo gives you a big smile brimming with pride, “<i>Alright [pc.name]... let’s begin.</i>”\n\n");
		output("Largely due to your increased endurance and improved technique the two of you spend more time sparring and dancing through the forms Jojo knows.  When it comes time for a brief lecture, Jojo pants as he sits with you, taking a minute to regain his breath.  Jojo’s lectures, instead of dealing with how to strike and defend oneself, deal with the nature of the soul.  You learn much about individuality, willpower and determination and after the lecture the two of you meditate on what you’ve learned for a few silent moments.\n\n");
		output("Then the two of you are back up, sweeping gracefully through forms and striking invisible enemies with fierce blows.  By the end of the intense training session both you and Jojo are tired, having trained to both of your limits.\n\n");
		output("As the two of you give each other decidedly shaky bows, Jojo says, “<i>Great effort [pc.name], you are... wow... I need a rest. I’ve earned it.</i>”  The two of you share a laugh and end you training.\n\n");
		
		if (flags["COC.TIMES_TRAINED_WITH_JOJO"] >= 16 && pc.IQ() >= 70 && !pc.isBimbo() && !pc.isBro()) // no enlightment for you, mindless slut!
		{
			//{text shows after generic 16th technique training session}
			output("As you finish training you decide to meditate alone; you close your eyes and begin to breathe.  Then the world around you begins to sing.\n\n");
			output("The camp is alive with the sounds of voices on the wind, of the ominous sizzling of the great scar between worlds that is the portal that brought you here.  You feel open to the universe as if it were a lady in a dress sitting next to you, that you could easily reach out and touch.  You feel liberated and free despite the fact that you are not moving a muscle.  You are ready for anything but expecting nothing.  You are neither thinking nor dreaming, you simply are.\n\n");

			output("<b>(Perk Gained: Enlightened -</b> Grants the ability to meditate alone. White magic threshold reduced.<b>)</b>");
			pc.createPerk("Enlightened", 0, 0, 0, 0, "Grants the ability to meditate alone. White magic threshold reduced.");
		}
	}
	//{after PC has gained the Enlightened Perk}
	else
	{
		output("Jojo smiles, “<i>In all honesty [pc.name], I should be asking you to teach me, but I’ll do my best.</i>”\n\n");
		output("There are no lectures.  Neither you nor Jojo are masters, but as of right now, the two of you have exhausted the small store of knowledge available to you from the Celestial Lotus.  You and Jojo instead practice to exhaustion, heaving and panting for breath, whilst still finding time to enjoy each others company.\n\n");
		
		//{each scene only shows if the follower is there}
		var enlightenedBlurbs:Array = new Array();

		enlightenedBlurbs.push("You can hear Jojo’s feet move through the campsite as he heads toward his rock, seeking rest after your training session.")

		//// Lookit all these different ways followers are tracked! fml.
		//if (pc.findStatusAffect(StatusAffects.CampMarble) >= 0) enlightenedBlurbs.push("You can hear Marble humming a song to herself you can’t place.");
		if (flags["COC.AMILY_FOLLOWER"] > 0) enlightenedBlurbs.push("You can hear Amily changing the bedding to her nest.");
		//if (kGAMECLASS.emberScene.followerEmber()) enlightenedBlurbs.push("You can hear Ember cleaning" + emberScene.emberMF("his", "her") + "scales.");
		if (flags["COC.RATHAZUL_IN_CAMP"] > 0) enlightenedBlurbs.push("You can hear Rathazul experimenting with surprisingly nimble fingers.");
		//if (sophieFollower()) enlightenedBlurbs.push("You can hear Sophie breathing as she sleeps.");
		//if (flags["COC.UNKNOWN_FLAG_NUMBER_00238] > 0) enlightenedBlurbs.push("You can hear Izma flipping through the pages of a book."); // TODO: (if Izmael gets put in) you can hear Izmael doing push ups to stay fit.
		//if (kGAMECLASS.helScene.followerHel()) enlightenedBlurbs.push("You can hear Helia throwing her fists at nothing.");

		output(enlightenedBlurbs[rand(enlightenedBlurbs.length)] + "\n\n");
	}
	//Boost attributes!
	
	if (pc.PQ() < 50) pc.slowStatGain("physique", 0.5);
	if (pc.PQ() < 80) pc.slowStatGain("physique", 0.5);
	if (pc.IQ() < 50) pc.slowStatGain("intelligence", 0.5);
	if (pc.IQ() < 80) pc.slowStatGain("intelligence", 0.5);
	
	processTime(45 + rand(30));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function ControlledBreathTimePassedNotify():void {
	if (pc.hasPerk("Controlled Breath")) {
		pc.energy(1.0 / 15);
	}
}
private var ControlledBreathTimePassedNotifyHook: * = ControlledBreathTimePassedNotifyGrapple();
private function ControlledBreathTimePassedNotifyGrapple():* { timeChangeListeners.push(ControlledBreathTimePassedNotify); }

public function jojoWormRemoval():void {
	showJojo();
	clearOutput();
	output("\"<i>Excellent, young one,</i>\" Jojo continues. \"<i>Your dedication to purification is admirable. Relax and know that the parasites will leave you soon.</i>\"\n\n");
	output("Jojo gets up and walks over to a backpack hidden in the bushes. He removes a lacquered box. He removes and combines a rather noxious combination of herbs, oils and other concoctions into a mortar and grinds it with a pestle. After a few minutes, he ignites the mixture and uses a feathered fan to blow the fumes over you. The smell of the mix is nauseating and repugnant. Your stomach turns and you fight the urge to vomit. Eventually, you are no longer able to resist and you purge yourself onto the ground. Cramping from your vomiting fits, you wrack with discomfort, which slowly builds to genuine pain. As the pain sets in, you feel a stirring deep in your crotch. The worms inside you are stirring and thus are compelling another unwanted orgasm. Unable to control your body, your cock explodes, launching cum and worms everywhere. Jojo begins fanning faster as he sees the worms leave your body.\n\n");
	output("\"<i>Further endurance is needed, young one,</i>\" Jojo says. \"<i>The root of your problem must leave before you may pursue further purification. Healing is always twice as uncomfortable as the illness requiring attention.</i>\"\n\n");
	output("Your body cramps up as you feel the fat worm struggle. You feel it pushing up your urethra, fighting to escape your fumigated body. The worm rapidly peeks from the end of your penis. With expedience, Jojo quickly grabs the worm and pulls it out of you, triggering one last orgasm. The monk casts the fat worm to the ground and strikes it dead with his staff.\n\n");
	output("\"<i>The culprit has been exorcised and will no longer trouble you. Rest here for a while and join me in some meditation to heal your exhausted body and soul.</i>\"\n\n");
	output("Being too tired for anything else, you join Jojo in meditation, which does much to relive you of your former woes.");
	//Infestation removed. HP reduced to 50% of MAX. Sensitivity reduced by -25 or reduced to 10, which ever is the smaller reduction.
	//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
	if (pc.HPQ() > 50) pc.HPRaw = pc.HPMax() / 2;
	pc.removeStatusEffect("Infested");
	//dynStats("sen", -1, "lus", -99, "cor", -15);
	pc.energy( -20);
	processTime(90 + rand(60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}