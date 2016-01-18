import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCOvipositionElixir;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Hel hook (meh... she is everywhere... who were complaining about creepy Arian?)
// Letice fortress exploration (not before final CoC update)
// xmas event (rly?)
// Minotaur sons (IF pregs done)
// Mino addict scene (IF addiction done)
// Phoenix scene (IF follower hel done)
public function exploreHighMountain():void {
	IncrementFlag("COC.EXPLORED_HIGH_MOUNTAIN");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	var choice:Array = [];
	var chance:Array = [];
	
	//Helia monogamy fucks
	//if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	
	//Gats xmas adventure!
	//if (rand(5) == 0 && pc.gender > 0 && isHolidays() && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0 && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0 && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0 || pc.hasKeyItem("North Star Key") >= 0)) {
		//kGAMECLASS.gatsSpectacularRouter();
		//return;
	//}

	//if (kGAMECLASS.d3.discoverD3() == true)
	//{
		//return;
	//}
	
	//25% minotaur sons!
	//if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 3 && rand(4) == 0 && pc.hasVagina()) {
		//spriteSelect(44);
		//minotaurMobScene.meetMinotaurSons();
		//return;
	//}
	
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
	
	//if (kGAMECLASS.dungeons.checkPhoenixTowerClear() && rand(4) == 0) {
		//phoenixScene.encounterPhoenix();
		//return;
	//}
	
	//Minerva
	if (flags["COC.EXPLORED_HIGH_MOUNTAIN"] % 8 == 0 && flags["COC.MET_MINERVA"] < 4) {
		encounterMinerva();
		return;
	}

	//Harpy odds!
	if (pc.hasItem(new CoCOvipositionElixir()) || IncrementFlag("COC.TIMES_MET_CHICKEN_HARPY", false) <= 0) {
		choice.push(chickenHarpy);
		chance.push(pc.hasItem(new CoCOvipositionElixir(), 2) ? 2 : 6);
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
	
	
	WeightedRandom(choice, chance, true)();
}