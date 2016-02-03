import classes.GLOBAL;
import classes.Items.Melee.CoCWizardStaff;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// exgartuan
// Helia encounter
// camp chest
// bigJunkDesertScene
// Phylla
public function exploreDesert():void
{
	showName("\nDESERT");
	IncrementFlag("COC.EXPLORED_DESERT");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	////BUILD LIST OF CHOICES
	var choice:Array = [];
	var chance:Array = [];
	
	//Helia monogamy fucks
	//if (flags["COC.PC_PROMISED_HEL_MONOGAMY_FUCKS"] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	
	if(flags["COC.EXPLORED_DESERT"] % 20 == 0 && (flags["COC.TEL_ADRE_KNOWN"] == undefined || flags["COC.TEL_ADRE_KNOWN"] == 0))
	{
		discoverTelAdre();
		return;
	}
	
	if ((pc.level >= 4 || flags["COC.EXPLORED_DESERT"] > 45) && Flag("COC.DISCOVERED_WITCH_DUNGEON") == 0) {
		choice.push(TravelToDesertCave);
		chance.push(5);
	}
	
	//Ant colony debug chances
	//if (pc.level >= 5 && flags["COC.ANT_WAIFU"] == undefined && flags["COC.EXPLORED_DESERT"] % 8 == 0 && flags["COC.ANTS_PC_FAILED_PHYLLA"] == 0 && flags["COC.ANT_COLONY_KEPT_HIDDEN"] == undefined) {
		//antColonyEncounter();
		//return;
	//}
	
	//int over 50?  Chance of alice encounter!
	if (pc.intelligence() >= 15 && flags["COC.FOUND_WIZARD_STAFF"] == undefined) {
		choice.push(encounterAliseInDesert);
		chance.push(4);
	}
	
	//Possible chance of boosting camp space!
	//if (pc.hasKeyItem("Camp - Chest") < 0 && (rand(100) < 10)) {
		//output("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.  You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand.  Overcome with curiosity, you dig it out, only to discover that it's empty.  It would make a nice addition to your campsite.\n\nYou decide to bring it back to your campsite.  ", true);
		//for (var i:int = 0; i < 6; i++) {
			//inventory.createStorage();
		//}
		//pc.createKeyItem("Camp - Chest", 0, 0, 0, 0);
		//output("<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
		//doNext(returnToCampUseOneHour);
		//return;
	//}
	
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	//temp = 10 + (pc.longestCockLength() - pc.tallness) / 24 * 10;
	//if (temp > 30) temp = 30;
	//if (temp > rand(100) && pc.longestCockLength() >= pc.tallness && pc.totalCockThickness() >= 12) {
		//kGAMECLASS.exploration.bigJunkDesertScene();
		//return;
	//}

	//Encounter Sandwitch
	if (Flag("COC.SAND_WITCH_LEAVE_ME_ALONE") == 0) {
		choice.push(sandWitchSceneEncounter);
		chance.push(1);
	}
	
	if (flags["COC.CUM_WITCHES_FIGHTABLE"] > 0) {
		choice.push(fightCumWitch);
		chance.push(1);
	}

	//Encounter Marcus
	choice.push(wandererRouter);
	chance.push(1);

	choice.push(walkingDesertStatBoost);
	chance.push(1);

	choice.push(mirageDesert);
	chance.push(2);

	if(pc.level >= 2) {
		choice.push(oasisEncounter);
		chance.push(2); }

	choice.push(nagaEncounter);
	chance.push(1);
	
	choice.push(encounterASandTarp);
	chance.push(2);
	
	choice.push(fountainEncounter);
	chance.push(20);
	
	//MAKE YOUR CHOICE
	WeightedRandom(choice, chance, true)();
}

private function mirageDesert():void
{
	clearOutput();
	output("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.\n\n");
	processTime(25 + rand(10));
	pc.lust( -15);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function walkingDesertStatBoost():void
{
	clearOutput();
	output("You walk through the shifting sands for an hour, finding nothing.\n\n");
	//Chance of boost == 50%
	if (rand(2) == 0) {
		//50/50 strength/toughness
		if (rand(2) == 0 && pc.PQ() < 50) {
			output("The effort of struggling with the uncertain footing has made you stronger.");
			pc.slowStatGain("p", 0.5);
		}
		//Toughness
		else if (pc.WQ() < 50) {
			output("The effort of struggling with the uncertain footing has made you tougher.");
			//dynStats("tou", .5);
			pc.slowStatGain("w", 0.5);
		}
	}
	doNext(returnToCampUseOneHour);
}

private function encounterAliseInDesert():void
{
	clearOutput();
	output("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n");
	output("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n");
	output("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n");
	flags["COC.FOUND_WIZARD_STAFF"] = 1;
	processTime(15);
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCWizardStaff()]);
}