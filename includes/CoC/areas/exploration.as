import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// giacomoEncounter, lumiEncounter
public function doExplore():void
{
	if (flags["COC.EXPLORED"] == undefined || flags["COC.EXPLORED"] == 1) {
		tryDiscover();
		return;
	} else if (flags["COC.EXPLORED"] > 1) outputText("You can continue to search for new locations, or explore your previously discovered locations.", true);

	/*if (flags[kFLAGS.EXPLORATION_PAGE] == 2) {
		explorePageII();
		return;
	}*/
	clearMenu();
	
	addButton(0, "Explore", tryDiscover, null, "Explore", "Explore to find new regions and visit any discovered regions.\n\nTimes explored: " + flags["COC.EXPLORED"]);
	
	if (flags["COC.EXPLORED_DESERT"] != undefined)
		addButton(1, "Desert", exploreDesert, null, "Explore desert", "Visit the dry desert. \n\nRecommended level: 2\n\nTimes explored: " + flags["COC.EXPLORED_DESERT"]);
		
	if (flags["COC.EXPLORED_FOREST"] != undefined)
		addButton(2, "Forest", exploreForest, null, "Explore forest", "Visit the lush forest. \n\nRecommended level: 1" + (pc.level < 6 ? "\n\nBeware of Tentacle Beasts!" : "") + "\n\nTimes explored: " + flags["COC.EXPLORED_FOREST"]);
	
	if (flags["COC.EXPLORED_LAKE"] != undefined) 
		addButton(3, "Lake", exploreLake, null, "Explore lake", "Visit the lake and explore the beach. \n\nRecommended level: 1\n\nTimes explored: " + flags["COC.EXPLORED_LAKE"]);
	
	if (flags["COC.EXPLORED_MOUNTAIN"] != undefined) 
		addButton(4, "Mountain", exploreMountain, null, "Explore mountain", "Visit the mountain. \n\nRecommended level: 5\n\nTimes explored: " + flags["COC.EXPLORED_MOUNTAIN"]);
	
	if (flags["COC.EXPLORED_PLAINS"] != undefined) 
		addButton(5, "Plains", explorePlains, null, "Explore plains", "Visit the plains. \n\nRecommended level: 10\n\nTimes explored: " + flags["COC.EXPLORED_PLAINS"]);
	
	if (flags["COC.EXPLORED_SWAMP"] != undefined) 
		addDisabledButton(6, "Swamp", "Swamp", "NOT IMPLEMENTED.");
		//addButton(6, "Swamp", exploreSwamp, null, "Explore swamp", "Visit the wet swamplands. \n\nRecommended level: 12\n\nTimes explored: " + flags["COC.EXPLORED_SWAMP"]);
	
	if (flags["COC.EXPLORED_DEEPWOODS"] != undefined) 
		addButton(7, "Deepwoods", exploreDeepwoods, null, "Explore deepwoods", "Visit the dark, bioluminescent deepwoods. \n\nRecommended level: 5\n\nTimes explored: " + flags["COC.EXPLORED_DEEPWOODS"]);
		
	if (flags["COC.EXPLORED_HIGH_MOUNTAIN"] != undefined) 
		addDisabledButton(8, "High Mountain", "High Mountain", "NOT IMPLEMENTED.");
		//addButton(8, "High Mountain", exploreHighMountain, null, "Explore high mountains", "Visit the high mountains. \n\nRecommended level: 10\n\nTimes explored: " + flags["COC.EXPLORED_HIGH_MOUNTAIN"]);

	//if (flags[kFLAGS.BOG_EXPLORED] > 0) addButton(9, "Bog", kGAMECLASS.bog.exploreBog, null, null, null, "Visit the dark bog. \n\nRecommended level: 14" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.BOG_EXPLORED] : ""));
	//if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0) addButton(10, "Glacial Rift", kGAMECLASS.glacialRift.exploreGlacialRift, null, null, null, "Visit the chilly glacial rift. \n\nRecommended level: 16" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] : ""));
	//if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0) addButton(11, "Volcanic Crag", kGAMECLASS.volcanicCrag.exploreVolcanicCrag, null, null, null, "Visit the infernal volcanic crag. \n\nRecommended level: 20" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] : ""));

	addButton(14, "Back", playerMenu);
}

// placeholders
public function exploreSwamp() { };
public function exploreHighMountain() { };

//Try to find a new location - called from doExplore once the first location is found
public function tryDiscover():void
{
	// kGAMECLASS.goblinAssassinScene.goblinAssassinEncounter();
	// return;

	//if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helFollower.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	
	if (cocGeneralAreasExplore()) return;
	
	flags["COC.EXPLORED"]++;
	
	if (rand(2) == 0) {
		genericGobImpEncounters();
		return;
	}

	var chance:Array = [];
	var events:Array = [];
	
	events.push(genericGobImpEncounters)
	chance.push(1)
	
	events.push(giacomoEncounter)
	chance.push(2)
	
	events.push(lumiEncounter)
	chance.push(2)
	
	//if (flags["COC.CATHEDRAL_FOUND"] == undefined) {
		//events.push(gargoylesTheShowNowOnWBNetwork);
		//chance.push(6);
	//}
	
	WeightedRandom(events, chance, true)();
	
	//else if (choosey == 3 && flags[kFLAGS.PRISON_CAPTURE_COUNTER] < 1 && rand(4) == 0) {
		//player.explored++;
		//clearOutput();
		//outputText("Your curiosity draws you towards the smoke of a campfire on the edges of the forest. In the gloom ahead you see what appears to be a cage wagon surrounded by several tents, and hear the sounds of guttural voices engaged in boisterous conversation. Inexplicably you find yourself struck by an unwholesome sense of foreboding. <b>Even from here that cage looks like it is designed to carry people off to somewhere very unpleasant, some place where your life could be turned upside down and the rules you have become accustomed to in this world may no longer apply.</b> You take a long moment to consider turning back. Do you throw caution to the wind and investigate further?");
		////outputText("\n\n(<b>NOTE:</b> Prisoner mod is currently under development and not all scenes are available.)");
		//doYesNo(kGAMECLASS.prison.goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems, camp.returnToCampUseOneHour);
		//return;
	//}
}

public function placesKnown():Boolean { //Returns true as soon as any known place is found
	return placesCount() > 0 || dungeonsKnown() > 0;
}

public function placesCount():int {
	var places:int = dungeonsKnown();
	//if (flags[kFLAGS.BAZAAR_ENTERED] > 0) places++;
	if (flags["COC.BOAT_DISCOVERED"] == 1) places++;
	//if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) places++;
	if (flags["COC.WHITNEY_MET"] >= 3) places++; 
	//if (flags[kFLAGS.OWCA_UNLOCKED] > 0) places++;
	//if (player.findStatusAffect(StatusAffects.HairdresserMeeting) >= 0) places++;
	if (flags["COC.TEL_ADRE_KNOWN"] >= 1) places++;
	//if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) places++;
	//if (flags[kFLAGS.MET_MINERVA] >= 4) places++;
	//if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) places++;
	return places;
}

public function dungeonsKnown():int {
	var dungeons:int = 0;
	if (flags["COC.ZETAZ_CAVE_FOUND"] > 0) dungeons;
	if (flags["COC.FACTORY_FOUND"] > 0) dungeons++;
	if (flags["COC.DISCOVERED_WITCH_DUNGEON"] > 0) dungeons++;
	//if (flags[kFLAGS.D3_DISCOVERED] > 0) return true;
	//if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) return true;
	return dungeons;
}

//All cleaned up!
public function showPlacesMenu():Boolean {
	clearMenu();
	clearOutput();
	output("Which place would you like to visit?");
	//Build menu
	
	//if (flags[kFLAGS.BAZAAR_ENTERED] > 0) addButton(0, "Bazaar", kGAMECLASS.bazaar.enterTheBazaar, null, null, null, "Visit the Bizarre Bazaar where the demons and corrupted beings hang out.");
	if (flags["COC.BOAT_DISCOVERED"] == 1) addButton(1, "Boat", boatExplore, null, "Boat", "Get on the boat and explore the lake. \n\nRecommended level: 4\n\nTimes explored: " + flags["COC.EXPLORED_BOAT"]);
	//if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) 
	//{
		//if (flags[kFLAGS.GAR_NAME] == 0) addButton(2, "Cathedral", kGAMECLASS.gargoyle.gargoylesTheShowNowOnWBNetwork, null, null, null, "Visit the ruined cathedral you've recently discovered.");
		//else addButton(2, "Cathedral", kGAMECLASS.gargoyle.returnToCathedral, null, null, null, "Visit the ruined cathedral where " + flags[kFLAGS.GAR_NAME] + " resides.");
	//}
	if (dungeonsKnown() > 0) addButton(4, "Dungeons", showDungeonsMenu, null, "Dungeons", "Delve into dungeons.");
	if (flags["COC.WHITNEY_MET"] >= 3) addButton(5, "Farm", farmExploreEncounter, null, "Farm", "Visit Whitney's farm.");
	//if (flags[kFLAGS.OWCA_UNLOCKED] == 1) addButton(6, "Owca", kGAMECLASS.owca.gangbangVillageStuff, null, null, null, "Visit the sheep village of Owca, known for its pit where a person is hung on the pole weekly to be gang-raped by the demons.");
	if (flags["COC.GOBLIN_SALON_FOUND"] > 0) addButton(7, "Salon", salonGreeting, null, "Salon", "Visit the salon for hair services.");
	if (flags["COC.TEL_ADRE_KNOWN"] >= 1) addButton(8, "Tel'Adre", telAdreMenu, null, "Tel'Adre", "Visit the city of Tel'Adre in desert, easily recognized by the massive tower.");
	//
	//if (flags["COC.AMILY_VILLAGE_ACCESSIBLE"] > 0) addButton(10, "Town Ruins", exploreVillageRuin, null, "Town Ruins", "Visit the village ruins.\n\nTimes explored: " + flags["COC.EXPLORED_AMILY_VILLAGE"]);
	//if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(11, "Oasis Tower", kGAMECLASS.highMountains.minervaScene.encounterMinerva, null, null, null, "Visit the ruined tower in the high mountains where Minerva resides.");
	//if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) addButton(12, "Prison", kGAMECLASS.prison.prisonIntro, false, null, null, "Return to the prison and continue your life as Elly's slave.");
	//if (debug) addButton(13, "Ingnam", kGAMECLASS.ingnam.returnToIngnam, null, null, null, "Return to Ingnam for debugging purposes. Night-time event weirdness might occur. You have been warned!");
	
	//addButton(13, "Next", placesPage2);
	addButton(14, "Back", playerMenu);
	return true;
}

public function showDungeonsMenu():Boolean {
	clearMenu();
	clearOutput();
	output("Which dungeon would you like to visit?");
	//Build menu
	
	if (flags["COC.FACTORY_FOUND"] > 0) 
		addButton(0, "Factory", DemonFactoryEnter, null, "Demon Factory", "Visit the demonic factory in the mountains." + (flags["COC.FACTORY_SHUTDOWN"] > 0 ? "\n\nYou've managed to shut down the factory." : "The factory is still running. Marae wants you to shut down the factory!") + (DemonFactoryCleared() ? "\n\nCLEARED!" : ""));
	
	if (flags["COC.ZETAZ_CAVE_FOUND"] > 0) 
		addButton(1, "Deep Cave", ZetazCaveEnter, null, "Deep Cave", "Visit the cave you've found in the Deepwoods." + (flags["COC.DEFEATED_ZETAZ"] > 0 ? "\n\nYou've defeated Zetaz, your old rival." : "") + (ZetazCaveCleared() ? "\n\nCLEARED!" : ""));
	
	//Turn on dungeon 3
	//if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(2, "Stronghold", kGAMECLASS.d3.enterD3, null, null, null, "Visit the stronghold in the high mountains that belongs to Lethice, the demon queen." + (flags[kFLAGS.LETHICE_DEFEATED] > 0 ? "\n\nYou have slain Lethice and put an end to the demonic threats. Congratulations, you've beaten the main story!" : "") + (kGAMECLASS.dungeons.checkLethiceStrongholdClear() ? "\n\nCLEARED!" : ""));
	//Side dungeons
	
	if (flags["COC.DISCOVERED_WITCH_DUNGEON"] > 0) addButton(5, "Desert Cave", TravelToDesertCave, null, "Desert Cave", "Visit the cave you've found in the desert." + (flags["COC.SAND_WITCHES_COWED"] + flags["COC.SAND_WITCHES_FRIENDLY"] > 0 ? "\n\nFrom what you've known, this is the source of the Sand Witches." : "") + (DesertCaveCleared() ? "\n\nCLEARED!" : ""));
	
	//if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) addButton(6, "Phoenix Tower", dungeonH.returnToHeliaDungeon, null, null, null, "Re-visit the tower you went there as part of Helia's quest." + (kGAMECLASS.dungeons.checkPhoenixTowerClear() ? "\n\nYou've helped Helia in the quest and resolved the problems. \n\nCLEARED!" : ""));
	
	addButton(14, "Back", playerMenu);
	return true;
}

public function canExplore():Boolean {
	var canExplore:Boolean = true;
	if(pc.lust() >= pc.lustMax()) {
		outputText("<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>\n\n", false);
		//canExplore = false;
	}
	if(hours < 6 || hours > 20) {
		outputText("It is dark out, made worse by the lack of stars in the sky.  A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave camp.\n\n", false);
		if (companionsCount() > 0 && !(hours > 4 && hours < 23)) {
			outputText("Your camp is silent as your companions are sleeping right now.\n\n", false);
		}
		//canExplore = false;
	} else {
		if (hours == 19) outputText("The sun is close to the horizon, getting ready to set. ", false);
		if (hours == 20) outputText("The sun has already set below the horizon. The sky glows orange. ", false);
		outputText("It's light outside, a good time to explore and forage for supplies with which to fortify your camp.\n\n", false);
	}
	return canExplore;
}

public function showExplorationButton():void {
	if (canExplore()) {
		addButton(0, "Explore", doExplore);
		if (placesKnown()) addButton(1, "Places", showPlacesMenu);
		else addDisabledButton(1, "Places", "Places", "You don't know any places to go! Try to explore some.");
	}
	else {
		addDisabledButton(0, "Explore");
		addDisabledButton(1, "Places");
	}
}

public function cocGeneralAreasExplore():Boolean {
	clearOutput();
	if (flags["COC.EXPLORED"] == undefined) {
		output("You tentatively step away from your campsite, alert and scanning the ground and sky for danger.  You walk for the better part of an hour, marking the rocks you pass for a return trip to your camp.  It worries you that the portal has an opening on this side, and it was totally unguarded...\n\n...Wait a second, why is your campsite in front of you? The portal's glow is clearly visible from inside the tall rock formation.   Looking carefully you see your footprints leaving the opposite side of your camp, then disappearing.  You look back the way you came and see your markings vanish before your eyes.  The implications boggle your mind as you do your best to mull over them.  Distance, direction, and geography seem to have little meaning here, yet your campsite remains exactly as you left it.  A few things click into place as you realize you found your way back just as you were mentally picturing the portal!  Perhaps memory influences travel here, just like time, distance, and speed would in the real world!\n\nThis won't help at all with finding new places, but at least you can get back to camp quickly.  You are determined to stay focused the next time you explore and learn how to traverse this gods-forsaken realm.", true);
		flags["COC.EXPLORED"] = 1;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	flags["COC.EXPLORED"]++;
		
	if (flags["COC.EXPLORED_FOREST"] == undefined) {
		output("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You've discovered the Forest!</b>", true);
		flags["COC.EXPLORED_FOREST"] = 0;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	if (flags["COC.EXPLORED_LAKE"] == undefined) {
		output("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides you find a lake so massive the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You've discovered the Lake!</b>");
		flags["COC.EXPLORED_LAKE"] = 0;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	if (flags["COC.EXPLORED_LAKE"] != undefined && rand(3) == 0 && flags["COC.EXPLORED_DESERT"] == undefined) {
		output("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand under your [pc.legs].\n\n<b>You've discovered the Desert!</b>");
		flags["COC.EXPLORED_DESERT"] = 0;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	if (flags["COC.EXPLORED_DESERT"] != undefined && rand(3) == 0 && flags["COC.EXPLORED_MOUNTAIN"] == undefined) {
		output("Thunder booms overhead, shaking you out of your thoughts.  High above, dark clouds encircle a distant mountain peak.  You get an ominous feeling in your gut as you gaze up at it.\n\n<b>You've discovered the Mountain!</b>");
		flags["COC.EXPLORED_MOUNTAIN"] = 0;
		flags["COC.EXPLORED"]++;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	if (flags["COC.EXPLORED_MOUNTAIN"] != undefined && rand(3) == 0 && flags["COC.EXPLORED_PLAINS"] == undefined) {
		output("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
		flags["COC.EXPLORED_PLAINS"] = 0;
		doNext(returnToCampUseOneHour);
		return true;
	}
	
	if (flags["COC.EXPLORED_PLAINS"] != undefined && rand(3) == 0 && flags["COC.EXPLORED_SWAMP"] == undefined) {
		flags["COC.EXPLORED_SWAMP"] = 0;
		clearOutput();
		output("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
		output("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
		output("<b>You've discovered the Swamp!</b>");
		doNext(returnToCampUseTwoHours);
		return true;
	}
	
	//Discover Glacial Rift!
	//if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] <= 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && rand(4) <= 0 && (player.level >= 10 || model.time.days >= 90) ) {
		//flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] = 1;
		//player.explored++;
		//clearOutput();
		//outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, a cool breeze suddenly brushes your cheek, steadily increasing in intensity and power until your clothes are whipping around your body in a frenzy. Every gust of wind seems to steal away part of your strength, the cool breeze having transformed into a veritable arctic gale. You wrap your arms around yourself tightly, shivering fiercely despite yourself as the hard pink dirt slowly turns to white; soon you’re crunching through actual snow, thick enough to make you stumble with every other step. You come to a stop suddenly as the ground before you gives way to a grand ocean, many parts of it frozen in great crystal islands larger than any city.\n\n", false);
		//outputText("<b>You've discovered the Glacial Rift!</b>", false);
		//doNext(camp.returnToCampUseTwoHours);
		//return;
	//}
	//Discover Volcanic Crag!
	//if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] <= 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && rand(4) <= 0 && (player.level >= 15 || model.time.days >= 90) ) {
		//flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
		//player.explored++;
		//clearOutput();
		//outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n", false);
		//outputText("<b>You've discovered the Volcanic Crag!</b>", false);
		//doNext(camp.returnToCampUseTwoHours);
		//return;
	//}
	return false;
}

public function genericGobImpEncounters(even:Boolean = false):void {
	var impGob:Number = 5;
	if (!even) {
		if (pc.totalCocks() > 0) impGob--;
		if (pc.hasVagina()) impGob++;
		if (pc.fertility() >= 30) impGob++;
		if (pc.cumQ() >= 200) impGob--;
		//if (pc.findPerk(PerkLib.PiercedLethite) >= 0) {
			//if (impGob <= 3) impGob += 2;
			//else if (impGob < 7) impGob = 7;
		//}
	}
	//Imptacular Encounter
	if (rand(10) < impGob) {
		encounterImp();
	}
	//Encounter Gobbalin!
	else {
		encounterGoblin();
	}
}