import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "AuntNancy.as";
include "Edryn.as";
include "Niamh.as";

private function enterBarTelAdre():void {
	//if(isThanksgiving() && flags[kFLAGS.PIG_SLUT_DISABLED] == 0) kGAMECLASS.pigSlutRoastingGreet();
	//else 
	barTelAdre();
}

public function barTelAdre():void {
	userInterface.showName("WET\nBITCH");
	// Dominka & Edryn both persist their sprites if you back out of doing anything with them -- I
	// I guess this is good a place as any to catch-all the sprite, because I don't think theres ever a case you get a sprite from just entering the bar?
	var button:int = 0;
	clearOutput();
	if(flags["COC.LOPPE_DISABLED"] != 1 && flags["COC.LOPPE_MET"] != 1 && rand(10) == 0) {
		loppeFirstMeeting();
		return;
	}
	//output(images.showImage("location-teladre-thewetbitch"));
	output("The interior of The Wet Bitch is far different than the mental picture its name implied.  It looks like a normal tavern, complete with a large central hearth, numerous tables and chairs, and a polished dark wood bar.  The patrons all seem to be dressed and interacting like normal people, that is if normal people were mostly centaurs and dog-morphs of various sub-species.  The atmosphere is warm and friendly, and ");
	if (pc.race() != "human") output("despite your altered appearance, ");
	output("you hardly get any odd stares.  There are a number of rooms towards the back, as well as a stairway leading up to an upper level.");
	
	//scylla.scyllaBarSelectAction(); //Done before anything else so that other NPCs can check scylla.action to see what she's doing
		//Thanks to this function and edryn.edrynHeliaThreesomePossible() the bar menu will always display the same possible options until the game time advances.
		//So it's safe to return to this menu, Helia or Urta can't suddenly disappear or appear just from leaving and re-entering the bar.

	clearMenu();
	var counter:int = 0;
	//AMILY!
	//if(flags[kFLAGS.AMILY_VISITING_URTA] == 1) {
		//button = anotherButton(button,"Ask4Amily",kGAMECLASS.followerInteractions.askAboutAmily);
	//}
	//DOMINIKA
	//if(hours > 17 && hours < 20 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] != -1) {
		//button = anotherButton(button, "Dominika", dominika.fellatrixBarApproach);
	//}
	//EDRYN!
	
	if (edrynBar()) {// && edryn.pregnancy.type != PregnancyStore.PREGNANCY_TAOTH) { //Edryn is unavailable while pregnant with Taoth
		//if (edryn.pregnancy.isPregnant) {
			//if (flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] == 0) {
				//flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] = 1;
				//if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] == 0) { //Edryn panic appearance! (First time mom)
					//output("\n\nEdryn smiles when she sees you and beckons you towards her.  Fear and some kind of frantic need are painted across her face, imploring you to come immediately.  Whatever the problem is, it doesn't look like it can wait.", false);
					//doNext(edryn.findOutEdrynIsPregnant);
					//return;
				//}
				//else { //Edryn re-preggers appearance!
					//output("\n\nEdryn smiles at you and yells, \"<i>Guess what " + pc.short + "?  I'm pregnant again!</i>\"  There are some hoots and catcalls but things quickly die down.  You wonder if her scent will be as potent as before?", false);				
				//}
			//}
			//else { //Mid-pregnancy appearance
				//output("\n\nEdryn is seated at her usual table, and chowing down with wild abandon.  A stack of plates is piled up next to her.  Clearly she has been doing her best to feed her unborn child.  She notices you and waves, blushing heavily.", false);
			//}
		//}
		//Edryn just had a kid and hasn't talked about it!
		//else 
		if (flags["COC.EDRYN_NEEDS_TO_TALK_ABOUT_KID"] == 1) {
			output("\n\nEdryn the centaur isn't pregnant anymore!  She waves excitedly at you, beckoning you over to see her.  It looks like she's already given birth to your child!");
		}
		//Appearance changes if has had kids
		else if(flags["COC.EDRYN_NUMBER_OF_KIDS"] > 0) {
			output("\n\nEdryn is seated at her usual place, picking at a plate of greens and sipping a mug of the local mead.  She looks bored until she sees you.  Her expression brightens immediately, and Edryn fiddles with her hair and changes her posture slightly.  You aren't sure if she means to, but her cleavage is prominently displayed in an enticing manner.");
		}
		else if(Flag("COC.EDRYN_AFFECTION") < 3) {
			output("\n\nEdryn, the centauress you met at the gate, is here, sitting down at her table alone and sipping on a glass of wine.  You suppose you could go talk to her a bit.");
		}
		else output("\n\nEdryn the centauress is here, sipping wine at a table by herself.  She looks up and spots you, her eyes lighting up with happiness.  She gives you a wink and asks if you'll join her.");
		addButton(counter++, "Edryn", edrynBarTalk);
	}
	//if (flags[kFLAGS.KATHERINE_LOCATION] == Katherine.KLOC_BAR) {
		//if (flags[kFLAGS.KATHERINE_UNLOCKED] == 4) { 
			//katherine.barFirstEncounter();
			//return;
		//}
		//if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 31 && kGAMECLASS.urta.urtaAtBar() && !kGAMECLASS.urta.urtaDrunk() && flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] == 0) {
			//katherine.barKathUrtaLoveAnnounce();
			//return;
		//}
		//katherine.barDescription();
		//button = anotherButton(button, "Katherine", katherine.barApproach);
    //}
	//trace("HEL FOLLOWER LEVEL: " + flags[kFLAGS.HEL_FOLLOWER_LEVEL] + " HEL FUCKBUDDY: " + flags[kFLAGS.HEL_FUCKBUDDY] + " HARPY QUEEN DEFEATED: " + flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]);
	//trace("REDUCED ENCOUNTER RATE (DISPLINED): " + flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE]);
	//HELIA
	//if(player.gender > 0 && model.time.hours >= 14 && rand(2) == 0 && model.time.hours < 20 && flags[kFLAGS.HEL_FUCKBUDDY] == 1 && (!kGAMECLASS.helFollower.followerHel() || flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1)) {
		//edryn.helAppearance();
		//hel = edryn.approachHelAtZeBitch;
	//}
	//NANCY
	if (auntNancy(false)) {
		auntNancy(true);
		if (Flag("COC.AUNT_NANCY_MET") > 0) addButton(counter++, "Nancy", interactWithAuntNancy);
		else addButton(counter++, "Barkeep", interactWithAuntNancy);
	}
	else output("\n\nIt doesn't look like there's a bartender working at the moment.");

	//NIAMH
	if (hours >= 8 && hours <= 16 && IncrementFlag("COC.NIAMH_STATUS", false) == 0) {
		telAdreNiamh();
		if (Flag("COC.MET_NIAMH") == 0) addButton(counter++, "Beer Cat", approachNiamh);
		else  addButton(counter++, "Niamh", approachNiamh);
	}
	
	//ROGAR #1
	if (flags["COC.ROGAR_PHASE"] == 3 && flags["COC.ROGAR_DISABLED"] != 1 && flags["COC.ROGAR_FUCKED_TODAY"] != days) {
		addButton(counter++, "HoodedFig", rogarThirdPhase);
		//Wet Bitch screen text when Ro'gar phase = 3:
		output("\n\nYou notice a cloaked figure at the bar, though you're quite unable to discern anything else as its back is turned to you.");
	}
	//ROGAR #2
	else if(flags["COC.ROGAR_PHASE"] >= 4 && flags["COC.ROGAR_DISABLED"] != 1 && flags["COC.ROGAR_FUCKED_TODAY"] != days) {
		addButton(counter++, "Rogar", rogarPhaseFour);
		//Wet Bitch bar text when Ro'gar phase = 4:
		output("\n\nRo'gar is here with his back turned to the door, wearing his usual obscuring cloak.");
	}

	//switch (scylla.action) { //Scylla - requires dungeon shut down
		//case Scylla.SCYLLA_ACTION_FIRST_TALK:
			//output("\n\nThere is one nun sitting in a corner booth who catches your eye.  She sits straight-backed against the dark, wood chair, her thin waist accentuating the supple curve of her breasts. She's dressed in a black robe that looks a few sizes too small for her hips and wears a black and white cloth over her head.");
			//button = anotherButton(button, "Nun", scylla.talkToScylla);
			//break;
		//case Scylla.SCYLLA_ACTION_ROUND_TWO:
			//scylla.scyllaRoundII();
			//return;
		//case Scylla.SCYLLA_ACTION_ROUND_THREE:
			//scylla.scyllaRoundThreeCUM();
			//return;
		//case Scylla.SCYLLA_ACTION_ROUND_FOUR:
			//scylla.scyllaRoundIVGo();
			//return;
		//case Scylla.SCYLLA_ACTION_MEET_CATS:
			//output("\n\nIt looks like Scylla is here but getting ready to leave.  You could check and see what the misguided nun is up to.");
			//button = anotherButton(button, "Scylla", scylla.Scylla6);
			//break;
		//case Scylla.SCYLLA_ACTION_ADICTS_ANON:
			//output("\n\nYou see Scylla's white and black nun's habit poking above the heads of the other patrons.  The tall woman seems unaware of her effect on those around her, but it's clear by the way people are crowding she's acquired a reputation by now.  You're not sure what she's doing, but you could push your way through to find out.");
			//button = anotherButton(button, "Scylla", scylla.scyllaAdictsAnonV);
			//break;
		//case Scylla.SCYLLA_ACTION_FLYING_SOLO:
			//output("\n\nIt looks like Scylla is milling around here this morning, praying as she keeps an eye out for someone to 'help'.");
			//button = anotherButton(button, "Scylla", scylla.scyllasFlyingSolo);
			//break;
		//default:
	//}
	//Nun cat stuff!
	//if (katherine.needIntroductionFromScylla()) {
		//katherine.catMorphIntr();
		//button = anotherButton(button,"ScyllaCats",katherine.katherineGreeting);
	//}
	//URTA
	//if (kGAMECLASS.urta.urtaAtBar()) {
		////Scylla & The Furries Foursome
		//if (scylla.action == Scylla.SCYLLA_ACTION_FURRY_FOURSOME)
		//{
			//trace("SCYLLA ACTION: " + scylla.action);
			//output("\n\nScylla’s spot in the bar is noticeably empty. She’s usually around at this time of day, isn’t she? Urta grabs your attention with a whistle and points to a back room with an accompanying wink. Oh... that makes sense. Surely the nun won’t mind a little help with her feeding...");
			//button = anotherButton(button,"Back Room",scylla.openTheDoorToFoursomeWivScyllaAndFurries);
		//}
		////Urta X Scylla threesome
		//if (scylla.action == Scylla.SCYLLA_ACTION_FUCKING_URTA) {
			//if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00143] == 0)
				//output("\n\n<b>Though Urta would normally be here getting sloshed, her usual spot is completely vacant.  You ask around but all you get are shrugs and giggles.  Something isn't quite right here.  You see an empty bottle of one of her favorite brands of whiskey still rolling on her table, so she can't have been gone long.  Maybe she had guard business, or had to head to the back rooms for something?</b>");
			//else
				//output("\n\nUrta's usual place is vacant, though her table still holds a half-drank mug of something potent and alcoholic.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...");
			//flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
			//button = anotherButton(button, "Back Room", kGAMECLASS.urta.scyllaAndUrtaSittingInATree);
		//}
		//else if (kGAMECLASS.urta.urtaBarDescript()) {
			//if (auntNancy.auntNancy(false) && flags[kFLAGS.URTA_INCUBATION_CELEBRATION] == 0 && kGAMECLASS.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
				//kGAMECLASS.urtaPregs.urtaIsHappyAboutPregnancyAtTheBar();
				//return;
			//}
			//button = anotherButton(button,"Urta",kGAMECLASS.urta.urtaBarApproach);
		//}
	//}
	//VALA
	if(purifiedFaerieBitchBar()) addButton(counter++, "Vala", chooseValaInBar);

	addButton(14, "Leave", telAdreMenu);
}