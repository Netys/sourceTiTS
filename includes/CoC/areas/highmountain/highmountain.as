import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCOvipositionElixir;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// xmas event (rly?)
// Mino addict scene (IF addiction done)
public function exploreHighMountain():void {
	if (helSexualAmbush()) return;
	
	showName("HIGH\nMOUNTAIN");
	IncrementFlag("COC.EXPLORED_HIGH_MOUNTAIN");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	var choice:Array = [];
	var chance:Array = [];
	
	//Gats xmas adventure!
	//if (rand(5) == 0 && pc.gender > 0 && isHolidays() && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0 && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0 && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0 || pc.hasKeyItem("North Star Key") >= 0)) {
		//kGAMECLASS.gatsSpectacularRouter();
		//return;
	//}

	if (discoverD3())
		return;
	
	//10% chance to mino encounter rate if addicted
	//if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0 && rand(10) == 0) {
		//spriteSelect(44);
		////Cum addictus interruptus!  LOL HARRY POTTERFAG
		////Withdrawl auto-fuck!
		//if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
			//getGame().mountain.minotaurScene.minoAddictionFuck();
			//return;
		//}
		//getGame().mountain.minotaurScene.getRapedByMinotaur(true);
		//spriteSelect(44);
		//return;
	//}
	
	//Minerva
	if (flags["COC.EXPLORED_HIGH_MOUNTAIN"] % 8 == 0 && Flag("COC.MET_MINERVA") < 4) {
		encounterMinerva();
		return;
	}

	//Harpy odds!
	if (pc.hasItem(new CoCOvipositionElixir()) || IncrementFlag("COC.TIMES_MET_CHICKEN_HARPY", false) <= 0) {
		choice.push(chickenHarpy);
		chance.push(pc.hasItem(new CoCOvipositionElixir(), 2) ? 2 : 6);
	}
	
	if (PhoenixTowerCleared()) {
		choice.push(encounterPhoenix);
		chance.push(3);
	}
	
	// Basilisk!
	choice.push(basiliskGreeting);
	chance.push(1);
	
	// Generic harpy
	choice.push(harpyFight);
	chance.push(1);
	
	// Sophie
	choice.push(meetSophie);
	chance.push(2);
	
	// Izumi
	choice.push(izumiScenesEncounter);
	chance.push(3);
	
	// minotaur sons!
	if (flags["COC.MINOTAUR_LAST_SONS_ADULT"] >= 3 && pc.hasVagina()) {
		choice.push(meetMinotaurSons);
		chance.push(3);
	}
	
	WeightedRandom(choice, chance, true)();
}