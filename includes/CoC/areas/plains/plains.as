import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCOvipositionElixir;
import classes.Items.Transformatives.CoCKangaFruit;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Sheila encounter
// Kaanga fruit
// Hel encounter
// Isabella encounter
// Isabella/Hel interactions
// Owca
public function explorePlains():void { 
	IncrementFlag("COC.EXPLORED_PLAINS");
	
	var choice:Array = [];
	var chance:Array = [];
	
	//Dem Kangasluts!  Force Sheila relationship phase!
	//if (flags["COC.SHEILA_DEMON"] != 1 && flags["COC.SHEILA_XP"] == 3 && hours == 20 && flags["COC.SHEILA_CLOCK"] >= 0) {
		//sheilaXPThreeSexyTime();
		//return;
	//}
	
	//Add some holiday cheer
	//if (isHolidays() && date.fullYear > flags["COC.CANDY_CANE_YEAR_MET"] && rand(5) == 0) {
		//kGAMECLASS.candyCaneTrapDiscovery();
		//return;
	//}
	//if (isHolidays() && date.fullYear > flags["COC.POLAR_PETE_YEAR_MET"] && rand(4) == 0 && silly) {
		//kGAMECLASS.polarPete();
		//flags["COC.POLAR_PETE_YEAR_MET"] = date.fullYear;
		//return;
	//}
	
	//Helia monogamy fucks
	//if (flags["COC.PC_PROMISED_HEL_MONOGAMY_FUCKS"] == 1 && flags["COC.HEL_RAPED_TODAY"] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	//Find Niamh
	if (flags["COC.NIAMH_MOVED_OUT_COUNTER"] < timeAsStamp - 24 * 60) {
		niamhPostTelAdreMoveOut();
		return;
	}
	//Find Owca
	//if ((pc.level >= 8 || flags["COC.EXPLORED_PLAINS"] > 50) && flags["COC.EXPLORED_PLAINS"] % 25 == 0 && flags["COC.OWCA_UNLOCKED"] == 0) {
		//kGAMECLASS.owca.gangbangVillageStuff();
		//return;
	//}
	//Bazaar!
	if (flags["COC.EXPLORED_PLAINS"] % 10 == 0 && flags["COC.BAZAAR_ENTERED"] != 1) {
		findBazaar();
		return;
	}
	//Chance of threesomes!
	//if (flags["COC.UNKNOWN_FLAG_NUMBER_00256"] != 0 && flags["COC.UNKNOWN_FLAG_NUMBER_00257"] != 0 && flags["COC.HEL_FUCKBUDDY"] == 1 && flags["COC.UNKNOWN_FLAG_NUMBER_00260"] == 0 && !kGAMECLASS.isabellaFollowerScene.isabellaFollower() && flags["COC.EXPLORED_PLAINS"] % 21 == 0 && !(pc.tallness > 78 && flags["COC.UNKNOWN_FLAG_NUMBER_00258"] == 0)) {
		////Hell/Izzy threesome intro
		//if (flags["COC.HEL_ISABELLA_THREESOME_ENABLED"] == 0) {
			//kGAMECLASS.helScene.salamanderXIsabellaPlainsIntro();
			//return;
		//}
		////Propah threesomes here!
		//else if (flags["COC.HEL_ISABELLA_THREESOME_ENABLED"] == 1) {
			//kGAMECLASS.helScene.isabellaXHelThreeSomePlainsStart();
			//return;
		//}
	//}
	
	choice.push(plainsLoot);
	chance.push(1);
	
	//choice.push(bunnbunbunMeet);
	//chance.push(1);
	
	choice.push(satyrEncounter);
	chance.push(1);
	
	//choice.push(gnollEncounter);
	//chance.push(2);
	//
	//choice.push(gnoll2Encounter);
	//chance.push(2);

	//if (flags["COC.ISABELLA_PLAINS_DISABLED"] == 0) {
		//choices[choices.length] = kGAMECLASS.isabellaScene.isabellaGreeting;
		//choices[choices.length] = kGAMECLASS.isabellaScene.isabellaGreeting;
	//}
	//if (!kGAMECLASS.helScene.followerHel() && (flags["COC.HEL_REDUCED_ENCOUNTER_RATE"] == 0 || rand(2) == 0)) {
		//choices[choices.length] = kGAMECLASS.helScene.encounterAJerkInThePlains;
		//choices[choices.length] = kGAMECLASS.helScene.encounterAJerkInThePlains;
	//}
	
	//if (flags["COC.SHEILA_DISABLED"] != 1 && flags["COC.SHEILA_CLOCK"] >= 0) { //Aparently Sheila was supposed to be disabled after certain events - now fixed
		//choice.push(sheilaEncounterRouter);
		//chance.push(1);
	//}	
	
	WeightedRandom(choice, chance, true)();
}

private function plainsLoot():void {
	clearOutput();
	
	processTime(20 + rand(20));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	
	if (rand(2) == 0) {
		output("While exploring the plains you nearly trip over a discarded, hexagonal bottle.  ");
		itemCollect([new CoCOvipositionElixir()]);
	}
	else {
		output("While exploring the plains you come across a strange-looking plant.  As you peer at it, you realize it has some fruit you can get at.  ");
		itemCollect([new CoCKangaFruit()]);
	}	
}