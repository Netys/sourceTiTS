import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Halloween event
// Hel ambush
public function exploreDeepwoods():void { 
	clearOutput();
	//Increment deepwoods exploration counter.
	flags["COC.EXPLORED_DEEPWOODS"]++;
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	////BUILD LIST OF CHOICES
	var choice:Array = [];
	var chance:Array = [];
	
	
	//Every 5th exploration encounters d2 if hasnt been met yet and factory done
	if (flags["COC.ZETAZ_CAVE_FOUND"] == undefined && flags["COC.EXPLORED_DEEPWOODS"] % 5 == 0 && flags["COC.FACTORY_SHUTDOWN"] > 0) {
		ZetazCaveEnter();
		return;
	}
	
	// nothing!
	choice.push(deepwoodsWastedTime);
	chance.push(1);
	
	//Tentacle Beast
	if (pc.level >= 2) {
		choice.push(forestTentaBeast);
		chance.push(3);
	}
	
	 //Corrupted Glade
	choice.push(forestCorruptedGlade);
	chance.push(1);
	
	if (encounterTamaniPosible()) {
		choice.push(encounterTamani);
		chance.push(2);
	}
	
	if (flags["COC.FAERIE_ENCOUNTER_DISABLED"] == undefined)
	{
		choice.push(encounterFaerie);
		chance.push(1);
	}
	
	//Akbal
	choice.push(supahAkabalEdition);
	chance.push(1);
	
	//Kitsunes
	choice.push(enterTheTricksterKitsune);
	chance.push(1);
	choice.push(kitsuneShrine);
	chance.push(2);
	
	if (flags["COC.ERLKING_DISABLED"] == undefined)
	{
		choice.push(encounterWildHunt);
		chance.push(2);
	}
	
	//if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 4 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < 100 && rand(2) == 0) choice[choice.length] = 6; //Gather woods
	
	//Every tenth exploration finds a pumpkin if eligible!
	//if (pc.statusAffectv1(StatusAffects.ExploredDeepwoods) % 10 == 0 && isHalloween()) {
		////If Fera isn't free yet...
		//if (pc.findPerk(PerkLib.FerasBoonBreedingBitch) < 0 && pc.findPerk(PerkLib.FerasBoonAlpha) < 0) {
			//if (date.fullYear > flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE]) {
				//awardAchievement("Pump-kin-kin-kin", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_I);
				//kGAMECLASS.pumpkinFuckEncounter();
				//return;
			//}
		//}
		////Fera is free!
		//else {
			//if (flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] == 0) {
				//if (date.fullYear > flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR]) {
					//kGAMECLASS.feraSceneTwoIntroduction();
					//return;
				//}
			//}
		//}
	//}
	//Hel jumps you for sex.
	//if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	
	WeightedRandom(choice, chance, true)();
};

public function deepwoodsWastedTime():void {
	clearOutput();
	output("You enjoy a peaceful walk in the deepwoods.  It gives you time to think over the recent, disturbing events.");
	pc.slowStatGain("p", 0.5);
	pc.slowStatGain("i", 1);
	doNext(returnToCampUseOneHour);
}