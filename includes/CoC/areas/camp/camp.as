import classes.Engine.Combat.DamageTypes.DamageType;
import classes.GLOBAL;
import classes.Items.Apparel.*;
import classes.Items.Miscellaneous.*;
import classes.Items.Transformatives.*;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO: get rid of this wrappers
public function returnToCamp(timeUsed:int = 0):void {
	currentLocation = "COC_CAMP";
	if(timeUsed > 0) processTime(timeUsed * 60);
	clearMenu();
	mainGameMenu();
}
public function returnToCampUseOneHour():void { returnToCamp(1); } //Replacement for event number 13;		
public function returnToCampUseTwoHours():void { returnToCamp(2); } //Replacement for event number 14;		
public function returnToCampUseFourHours():void { returnToCamp(4); } //Replacement for event number 15;		
public function returnToCampUseEightHours():void { returnToCamp(8); } //Replacement for event number 16;

public function cocCampMenu():void {
	initCoCJunk();
	
	output("Your campsite is fairly simple at the moment.  Your tent and bedroll are set in front of the rocks that lead to the portal.  You have a small fire pit as well.  "); // there are no actual counter for time in Mareth...
	output("You have a number of traps surrounding your makeshift home, but they are fairly simple and may not do much to deter a demon.  ");
	output("The portal shimmers in the background as it always does, looking menacing and reminding you of why you came.\n\n");
	
	showExplorationButton(); // as well as places
	
	campFollowersButton(); campFollowersMenu(true);
	campLoversButton();	
	campSlavesButton();
	
	addButton(5, "Debug", doDebugFunction);
	
	// TODO: camp stash
	if (hasShipStorage()) addButton(3, "Stash", shipStorageMenuRoot);
	else addDisabledButton(3, "Stash");
	
	addButton(4, "Stream", swimInStream, undefined, "Stream", "Swim in nearby stream."); // COC:TODO: stream scene
	addButton(7, "Portal", abortIAmNotBloodyChampion, undefined, "Portal", "Exit simulation.");
}

public function doDebugFunction():void {
	meetFetishCultistAndHaveFun();
	//quickLoot(new CoCCentaurSaddle());
	new Catnip();
}

public function hasCompanions():Boolean {
	return companionsCount() > 0;
}
public function companionsCount():Number {
	return followersCount() + slavesCount() + loversCount();
}
public function followersCount():int {
	var counter:Number = 0;
	//if(emberScene.followerEmber()) counter++;
	//if(flags[kFLAGS.VALARIA_AT_CAMP] == 1) counter++;
	if(flags["COC.JOJO_IN_CAMP"] == 1) counter++;
	if(flags["COC.RATHAZUL_IN_CAMP"] == 1) counter++;
	if(flags["COC.ANEMONE_KID"] == 1) counter++;
	//if(followerShouldra()) counter++;
	//if(sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
	//if(helspawnFollower()) counter++;
	return counter;
}
public function campFollowersButton():void {
	if (followersCount() > 0) addButton(11, "Followers", campFollowersMenu);
	else addDisabledButton(11, "Followers", "Followers", "You have no followers.");
}

public var followerCampMenuBlurb:/*Function*/Array = []; // Container for self-declaring listeners. Functions here must accept showInteractButton:Boolean argument.
public function campFollowersMenu(descOnly:Boolean = false):void {
	if (!descOnly) {
		clearMenu();
		clearOutput();
	}
	for each (var name:* in followerCampMenuBlurb) 
		name(!descOnly);
	addButton(14,"Back",mainGameMenu);
}

public function loversCount():int {
	var counter:Number = 0;
	//if(arianScene.arianFollower()) counter++;
	//if(followerHel()) counter++;
	////Izma!
	//if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
	//if(isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
	//if(player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
	//if(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) counter++;
	//if(followerKiha()) counter++;
	//if(flags[kFLAGS.NIEVE_STAGE] == 5) counter++;
	//if(flags[kFLAGS.ANT_WAIFU] > 0) counter++;
	return counter;
}
public function campLoversButton():void {
	if (loversCount() > 0) addButton(10, "Lovers", campFollowersMenu);
	else addDisabledButton(10, "Lovers", "Lovers", "Not implemented");
}
public function campLoversMenu():void {
}

public function slavesCount():int {
	var counter:Number = 0;
	//if(latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) counter++;
	//if(vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) counter++;
	//if(campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) counter++;
	//if(amilyScene.amilyFollower() && amilyScene.amilyCorrupt() && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) counter++;
	////Bimbo sophie
	//if(bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
	//if(ceraphIsFollower()) counter++;
	//if(milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) counter++;
	return counter;
}
public function campSlavesButton():void {
	if (slavesCount() > 0) addButton(12, "Slaves", campFollowersMenu);
	else addDisabledButton(12, "Slaves", "Slaves", "Not implemented");
}
public function campSlavesMenu():void {
}

private function swimInStream():void {	
	outputText("You ponder over the nearby stream that's flowing. Deciding you'd like a dip, ", true);
	if (pc.inSwimwear()) outputText("you are going to swim while wearing just your swimwear. ", false);
	else if(!pc.isNude()) outputText("you strip off your [pc.gear] until you are completely naked. ", false);
	outputText("You step into the flowing waters. You shiver at first but you step in deeper. Incredibly, it's not too deep. ", false);
	if (pc.tallness < 60) outputText("Your feet aren't even touching the riverbed. ", false);
	if (pc.tallness >= 60 && pc.tallness < 72) outputText("Your feet are touching the riverbed and your head is barely above the water. ", false);
	if (pc.tallness >= 72) outputText("Your feet are touching touching the riverbed and your head is above water. You bend down a bit so you're at the right height. ", false);
	outputText("\n\nYou begin to swim around and relax. ", false);
	pc.shower();
	//Blown up factory? Corruption gains.
	if (flags["COC.FACTORY_SHUTDOWN"] == 2 && pc.cor() < 50)
	{
		outputText("\n\nYou feel a bit dirtier after swimming in the tainted waters. \n\n", false);
		dynStats("cor", 0.5);
		dynStats("lust", 15);
	}
	outputText("\n\nEventually, you swim back to the riverbank and dry yourself off", false);
	if (!pc.inSwimwear() && !pc.isNude()) outputText(" before you re-dress yourself" , false);
	outputText(".", false)
	doNext(returnToCampUseOneHour);
}