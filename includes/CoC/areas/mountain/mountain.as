import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Hel hook
// goblin salon
// Ceraph
// worms
// xmas event
public function exploreMountain():void { 
	flags["COC.EXPLORED_MOUNTAIN"]++;
	var chooser:Number = rand(4);
	
	processTime(20 + rand(20));
	
	////BUILD LIST OF CHOICES
	var choice:Array = [];
	var chance:Array = [];
	
	//Helia monogamy fucks
	//if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	
	//Discover 'high mountain' at level 5 or 40 explores of mountain
	if ((pc.level >= 5 && rand(6) == 0 || flags["COC.EXPLORED_MOUNTAIN"] >= 40 && rand(2) == 0) && flags["COC.EXPLORED_HIGH_MOUNTAIN"] == undefined) {
		clearOutput();
		clearMenu();
		output("While exploring the mountain, you come across a relatively safe way to get at its higher reaches.  You judge that with this route you'll be able to get about two thirds of the way up the mountain.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>High Mountain exploration location unlocked!</b>)");
		flags["COC.EXPLORED_HIGH_MOUNTAIN"] = 0;
		processTime(15 + rand(30));
		addButton(0, "Next", mainGameMenu);
		return;
	}
	
	// First encounter of Demon Factory, if Marae encountered as not corrupt.
	if (rand(8) == 0 && flags["COC.MARAE_QUEST_START"] >= 1 && flags["COC.FACTORY_FOUND"] == undefined) {
		DemonFactoryEnter();
		return;
	}
	
	//if (isHolidays()) {
		////Gats xmas adventure!
		//if (rand(5) == 0 && pc.gender > 0 && isHolidays() && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0 && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0 && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] > 0 && pc.hasKeyItem("North Star Key") < 0)) {
			//kGAMECLASS.gatsSpectacularRouter();
			//return;
		//}
		//if (rand(6) == 0 && flags[kFLAGS.JACK_FROST_YEAR] < date.fullYear && silly()) {
			//kGAMECLASS.meetJackFrostInTheMountains();
			//return;
		//}
	//}
	
	//8% chance of hellhoundsplosions if appropriate
	if (flags["COC.HELL_HOUND_MASTER_QUEST"] < 3 && rand(15) == 0) {
		trace("CHANCE AT HELLHOUND GAO");
		//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
		if (pc.faceType == GLOBAL.TYPE_CANINE
			&& (pc.cockTotal(GLOBAL.TYPE_CANINE) == 2 && pc.cockTotal() == 2 || (pc.hasVagina() && pc.hasPregnancyOfType("Hellhound"))) 
			&& pc.cor() >= 60 
			&& pc.hasTail(GLOBAL.TYPE_CANINE) 
			&& (pc.legType == GLOBAL.TYPE_CANINE || pc.hasFur() && pc.furColor == "midnight black")) {
			trace("PASS BODYCHECK");
			if (flags["COC.HELL_HOUND_MASTER_QUEST"] == 0) {
				HellHoundMasterEncounter();
				return;
			}
			//Level 2 requires lethecite
			else if (flags["COC.HELL_HOUND_MASTER_QUEST"] == 1 && pc.hasKeyItem("Marae's Lethicite") && pc.keyItemv2("Marae's Lethicite") < 3) {
				HellHoundMasterEncounter();
				return;
			}
		}
	}

	//Rarer 'nice' Ceraph encounter
	//Overlaps half the old encounters once pierced.
	//if (!ceraphIsFollower() && pc.level > 2 && (pc.exploredMountain % 30 == 0) && flags["COC.PC_FETISH"] > 0) {
		//friendlyNeighborhoodSpiderManCeraph();
		//return;
	//}
	
	//15% chance of Ceraph
	//if (!ceraphIsFollower() && pc.level > 2 && (pc.exploredMountain % 15 == 0) && flags["COC.PC_FETISH"] != 1) {
		//encounterCeraph();
		//return;
	//}
	
	//10% chance of hairdresser encounter if not found yet
	if (flags["COC.GOBLIN_SALON_FOUND"] != 1) {
		choice.push(GoblinSalonEnter);
		chance.push(5);
	}
	
	//Boosts mino and hellhound rates!
	//if (pc.findPerk(PerkLib.PiercedFurrite) >= 0 && rand(3) == 0) {
		//if (rand(2) == 0) chooser = 1;
		//else chooser = 3;
	//}
	
	choice.push(encounterMinotaur);
	chance.push(1);
	
	//more chance to mino encounter rate if addicted
	if (flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] > 0) {
		choice.push(encounterMinotaur);
		chance.push(1);
	}
	
	//MORE chance for minos if uber-addicted, and also bad end chance
	//if (pc.hasPerk("Minotaur Cum Addict")) {
		//choice.push(encounterMinotaur);
		//chance.push(1);
		//choice.push(minoAddictionBadEndEncounter);
		//chance.push(50);
	//}
	
	// Worms. Not actually implemented, just placeholder and "nothing found" event
	choice.push(wormEncounter);
	chance.push(1);
	
	//Generic Goblin/Imp encounter
	choice.push(genericGobImpEncounters);
	chance.push(1);
	
	if(flags["COC.HELL_HOUND_MASTER_QUEST"] != 3) {
		choice.push(CoCHellhoundEncounter);
		chance.push(1);
	}
	
	WeightedRandom(choice, chance, true)();
}