import classes.Creature;
import classes.GLOBAL;
import classes.Items.Transformatives.Catnip;
import classes.Items.Transformatives.CoCReptilum;
import classes.ItemSlotClass;
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

public function cocCampMenu():void {
	if (campEvent()) return;
	
	showLocationName(); // force validation, since mainGameMenu does not always do it
	
	output("Your campsite is fairly simple at the moment.  Your tent and bedroll are set in front of the rocks that lead to the portal.  You have a small fire pit as well.  "); // there are no actual counter for time in Mareth...
	output("You have a number of traps surrounding your makeshift home, but they are fairly simple and may not do much to deter a demon.  ");
	output("The portal shimmers in the background as it always does, looking menacing and reminding you of why you came.");
	if (flags["COC.ANT_KIDS"] > 1000) outputText("  Really close to the portal there is a small entrance to the underground maze created by your ant children. And due to Phylla wish from time to time one of your children coming out this entrance to check on the situation near portal. You feel a little more safe now knowing that it will be harder for anyone to go near the portal without been noticed or...if someone came out of the portal.");
	output("\n\n");
	
	showExplorationButton(); // as well as places
	
	campFollowersButton(); campFollowersMenu(true);
	//campLoversButton();
	//campSlavesButton();
	
	//addButton(5, "Debug", doDebugFunction);
	
	// TODO: camp stash
	if (hasShipStorage()) addButton(3, "Stash", shipStorageMenuRoot);
	else addDisabledButton(3, "Stash");
	
	addButton(4, "Stream", swimInStream, undefined, "Stream", "Swim in nearby stream."); // COC:TODO: stream scene
	addButton(7, "Portal", abortIAmNotBloodyChampion, undefined, "Portal", "Exit simulation.");
}

public function doDebugFunction():void {
}

public function inCamp():Boolean
{
	return currentLocation == "COC_CAMP";
}

public function hasCompanions():Boolean {
	return companionsCount() > 0;
}
public function companionsCount():Number {
	return followersCount() + slavesCount() + loversCount();
}
public function followersCount():int {
	var counter:Number = 0;
	if(followerEmber()) counter++;
	//if(flags[kFLAGS.VALARIA_AT_CAMP] == 1) counter++;
	if(flags["COC.JOJO_IN_CAMP"] == 1) counter++;
	if(flags["COC.RATHAZUL_IN_CAMP"] == 1) counter++;
	if(flags["COC.ANEMONE_KID"] > 0) counter++;
	//if(followerShouldra()) counter++;
	if(sophieFollower() && int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) counter++;
	//if(helspawnFollower()) counter++;
	return counter;
}
public function campFollowersButton():void {
	if (followersCount() > 0) addButton(11, "Followers", campFollowersMenu);
	//else addDisabledButton(11, "Followers", "Followers", "You have no followers.");
}

public var followerCampMenuBlurb:/*Function*/Array = []; // Container for self-declaring listeners. Functions here must accept showInteractButton:Boolean argument.
public var followerBtnNum:int = 0;
public function campFollowersMenu(descOnly:Boolean = false):void {
	if (!descOnly) {
		clearMenu();
		clearOutput();
		addButton(14,"Back",mainGameMenu);
	}
	followerBtnNum = 0;
	for each (var name:* in followerCampMenuBlurb) 
	{
		name(!descOnly);
		if (followerBtnNum == 14) followerBtnNum++;
	}
	
	// TODO: separate followers/slaves/lovers?
	for each (var name2:* in loverCampMenuBlurb)
	{
		name2(!descOnly);
		if (followerBtnNum == 14) followerBtnNum++;
	}
	for each (var name3:* in slaveCampMenuBlurb) 
	{
		name3(!descOnly);
		if (followerBtnNum == 14) followerBtnNum++;
	}
}

public function loversCount():int {
	var counter:Number = 0;
	if(arianFollower()) counter++;
	if(followerHel()) counter++;
	//Izma!
	if(izmaFollower()) counter++;
	//if(isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
	//if(player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
	if(amilyFollower() && !amilyCorrupt()) counter++;
	if(followerKiha()) counter++;
	//if(flags[kFLAGS.NIEVE_STAGE] == 5) counter++;
	if(phyllaWaifu()) counter++;
	return counter;
}
public function campLoversButton():void {
	if (loversCount() > 0) addButton(10, "Lovers", campFollowersMenu);
	//else addDisabledButton(10, "Lovers", "Lovers", "Not implemented");
}

public var loverCampMenuBlurb:/*Function*/Array = []; // Container for self-declaring listeners. Functions here must accept showInteractButton:Boolean argument.
public var loverBtnNum:int = 0;
public function campLoversMenu(descOnly:Boolean = false):void {
	campFollowersMenu(descOnly);
	return;
	
	if (!descOnly) {
		clearMenu();
		clearOutput();
		addButton(14,"Back",mainGameMenu);
	}
	loverBtnNum = 0;
	for each (var name:* in loverCampMenuBlurb) 
	{
		name(!descOnly);
		if (loverBtnNum == 14) loverBtnNum++;
	}
}

public function slavesCount():int {
	var counter:Number = 0;
	//if(latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) counter++;
	if(vapulaSlave() && int(flags["COC.FOLLOWER_AT_FARM_VAPULA"]) == 0) counter++;
	if(campCorruptJojo() && int(flags["COC.FOLLOWER_AT_FARM_JOJO"]) == 0) counter++;
	if(amilyFollower() && amilyCorrupt() && flags["COC.FOLLOWER_AT_FARM_AMILY"] == undefined) counter++;
	////Bimbo sophie
	if(bimboSophie() && int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) counter++;
	if(ceraphIsFollower()) counter++;
	if(milkSlave() && int(flags["COC.FOLLOWER_AT_FARM_BATH_GIRL"]) == 0) counter++;
	return counter;
}
public function campSlavesButton():void {
	if (slavesCount() > 0) addButton(12, "Slaves", campFollowersMenu);
	//else addDisabledButton(12, "Slaves", "Slaves", "Not implemented");
}

public var slaveCampMenuBlurb:/*Function*/Array = []; // Container for self-declaring listeners. Functions here must accept showInteractButton:Boolean argument.
public var slaveBtnNum:int = 0;
public function campSlavesMenu(descOnly:Boolean = false):void {
	campFollowersMenu(descOnly);
	return;
	
	if (!descOnly) {
		clearMenu();
		clearOutput();
		addButton(14,"Back",mainGameMenu);
	}
	slaveBtnNum = 0;
	for each (var name:* in slaveCampMenuBlurb) 
	{
		name(!descOnly);
		if (loverBtnNum == 14) slaveBtnNum++;
	}
}

private function swimInStream():void {	
	clearOutput();
	output("You ponder over the nearby stream that's flowing. Deciding you'd like a dip, ");
	if (pc.inSwimwear()) output("you are going to swim while wearing just your swimwear. ");
	else if(!pc.isNude()) output("you strip off your [pc.gear] until you are completely naked. ");
	output("You step into the flowing waters. You shiver at first but you step in deeper. Incredibly, it's not too deep. ");
	if (pc.tallness < 60) output("Your [pc.feet] aren't even touching the riverbed. ");
	if (pc.tallness >= 60 && pc.tallness < 72) output("Your [pc.feet] are touching the riverbed and your head is barely above the water. ");
	if (pc.tallness >= 72) output("Your [pc.feet] are touching touching the riverbed and your head is above water. You bend down a bit so you're at the right height. ");
	output("\n\nYou begin to swim around and relax. ");
	pc.shower();
	//Blown up factory? Corruption gains.
	if (flags["COC.FACTORY_SHUTDOWN"] == 2 && pc.cor() < 50)
	{
		output("\n\nYou feel a bit dirtier after swimming in the tainted waters. \n\n");
		pc.cor(0.5);
		pc.lust(15);
	}
	output("\n\nEventually, you swim back to the riverbank and dry yourself off");
	if (!pc.inSwimwear() && !pc.isNude()) outputText(" before you re-dress yourself" );
	output(".")
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function campEvent():Boolean
{
	if (flags["COC.EDRYN_PREGNANCY_TAOTH"] < timeAsStamp)
	{
		urtaAndEdrynGodChildEpilogue();
		return true;
	}
	if (flags["COC.URTA_INCUBATION"] <= timeAsStamp)
	{
		preggoUrtaGivingBirth();
		return true;
	}
	if (flags["COC.NEED_URTA_LETTER"] <= timeAsStamp)
	{
		getUrtaLetter();
		return true;
	}
	if (!pc.hasKeyItem("Super Reducto") && milkSlave() && flags["COC.RATHAZUL_IN_CAMP"] == 1 && flags["COC.RATHAZUL_DAYS_IN_CAMP"] >= 4) {
		ratducto();
		return true;
	}
	if (flags["COC.JOJO_EGGS_INCUBAATION"] <= timeAsStamp)
	{
		jojoLaysEggs();
		return true;
	}
	if (followerKiha() && flags["COC.KIHA_CHILD_MATURITY_COUNTER"] == 144) {
		kihaTellsChildrenStory();
		return true;
	}
	if (followerEmber() && int(flags["COC.EMBER_NAPPING"]) <= 0 && int(flags["COC.EMBER_FUCK_COOLDOWN"]) <= 0) {
		//Ember get's a whiff of fuckscent and knocks up PC!
		if (pc.hasVagina() && pc.hasStatusEffect("Heat") && pc.findEmptyPregnancySlot(Creature.PREGSLOT_VAG) >= 0 && rand(10) == 0 && ember.hasCock()) {
			emberRapesYourHeatness();
			return true;
		}
		else if (pc.hasCock() && pc.hasStatusEffect("Rut") && flags["COC.EMBER_INCUBATION"] == undefined && rand(10) == 0 && ember.hasVagina()) {
			emberRapesYourHeatness();
			return true;
		}
	}
	//Amily and/or Jojo freakout about Vapula!!
	if (vapulaSlave() && ((flags["COC.JOJO_IN_CAMP"] == 1 && int(flags["COC.KEPT_PURE_JOJO_OVER_VAPULA"]) <= 0) || (amilyFollower() && !amilyCorrupt() && int(flags["COC.KEPT_PURE_AMILY_OVER_VAPULA"]) <= 0))) {
		//Jojo but not Amily (Must not be bimbo!)
		if ((flags["COC.JOJO_IN_CAMP"] == 1) && !(amilyFollower() && !amilyCorrupt()) && flags["COC.KEPT_PURE_JOJO_OVER_VAPULA"] == 0)
			mouseWaifuFreakout(false, true);
		//Amily but not Jojo
		else if ((amilyFollower() && !amilyCorrupt()) && flags["COC.JOJO_IN_CAMP"] != 1 && flags["COC.KEPT_PURE_AMILY_OVER_VAPULA"] == 0) {
			mouseWaifuFreakout(true, false);
		}
		//Both
		else
			mouseWaifuFreakout(true, true);
		return true;
	}
	if (flags["COC.VAPULA_FOLLOWER"] >= 2.5 && hours == 6 && int(flags["COC.FOLLOWER_AT_FARM_VAPULA"]) == 0) {
		femaleVapulaRecruitmentPartII();
		return true;
	}
	if (hours == 2 && vapulaSlave() && int(flags["COC.FOLLOWER_AT_FARM_VAPULA"]) == 0 && flags["COC.VAPULA_DAYS_SINCE_FED"] >= 5 && (pc.hasCock() || (pc.hasKeyItem("Demonic Strap-On") && pc.hasVagina()))) {
		vapulaForceFeeds();
		return true;
	}
	return false;
}