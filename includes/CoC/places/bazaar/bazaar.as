import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "BazaarEvents.as";
include "Benoit.as";
include "Cinnabar.as";
include "FapArena.as";
include "Greta.as";
include "Lilium.as";
include "Roxanne.as";
include "SlipperySqueeze.as";

public function showBazaar():void
{
	userInterface.showName("BIZZARE\nBAZAAR");
}

//[Find Travelling Bazaar]
public function findBazaar():void {
	clearOutput();
	showBazaar();
	if(IncrementFlag("COC.BAZAAR_ENCOUNTERED", false) == 0) {
		IncrementFlag("COC.BAZAAR_ENCOUNTERED");
		output("Warm, earthy breezes drift by as you explore the wind-blown grasses of the plains.  Though it seems you can see for miles, with the grasses subtly shifting between a few feet and over a dozen feet tall, it's impossible to tell what you'll stumble into next.  You trust your ears and your nose as much as your oft-blocked vision at this point, and before long you catch a whiff of blackened meat and aromatic spices.  There's some kind of camp not far away!\n\n");
		
		output("You [pc.readyWeapon] and cautiously creep through the towering vegetation, trying not to give your position away until you've ascertained just what type of people inhabit this camp.  Bright light flickers through the grass in front of you, and you part it to peek from between the blowing stalks.  There's a ring of brightly colored wagons set up here, with a tall, picketed fence erected around them.  Smoke curls up from the camp's center, twisting in the air like a viper in the grass.  Each of the wagons appears to be expanded, deployed into a small, self-contained structure.  Clearly this is some kind of traveling caravan or bazaar.\n\n");
		
		output("There's only one gap in the fence – a narrow gate watched by a ten-foot tall man with red skin and a pale, almost sky-blue turban.  He has a pair of scimitars that hang from a simple, leather belt.  The crimson-skinned man's clothing is a simple tunic and loose-fitting pants, but neither can conceal his obviously well-muscled frame.  He looks alert and attentive – a good sign since demons would have little need to post guards.");
	}
	else {
		output("Once again you smell a campfire through the tall grass, and as you close the distance you hear the familiar sounds of the traveling bazaar.  You peek through the weeds and behold the caravan's gate-keeper - a red-skinned, muscular giant of a man.");
	}
	output("\n\nDo you approach?", false);
	//[YES] [NOOOO]
	clearMenu();
	addButton(0, "Yes", approachBazaarGuard);
	addButton(1, "No", function ():* { processTime(10 + rand(10)); mainGameMenu(); } );
}

//[FUCK YES I WILL PUT IT IN YOUR BIZARRE ANUS]
private function approachBazaarGuard():void {
	clearOutput();
	showBazaar();
	output("You step from concealment and walk up to the strange man, calling out in greeting.  He folds his arms across his chest and looks you up and down, peering at you with intense, black eyes.  They aren't solid onyx, but his irises are just as dark as the seemingly bottomless depths of his pupils.  His appraising gaze watches you, unblinking as second after second ticks by.  Just when you start to wonder if he speaks your language, he interrupts you by saying, \"<i>");
	//if(pc.cor() < 33) output("Leave at once.  You are not yet ready for the wonders of the Bazaar.");
	//else 
	output("Welcome to the Bizarre Bazaar.  Enter, but be mindful of your actions within.");
	output("</i>\"");
	//if(cor() < 33) simpleChoices("FIGHT!",initiateFightGuard, "", null, "", null, "", null, "Leave",returnToCampUseOneHour);
	//else 
	clearMenu();
	addButton(0, "Enter", enterTheBazaar);
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function enterTheBazaar():void {
	flags["COC.BAZAAR_ENTERED"] = 1;
	processTime(10 + rand(10));
	
	if (hours >= 19 || hours <= 5) {
		IncrementFlag("COC.COUNTDOWN_TO_NIGHT_RAPE");
		if (flags["COC.COUNTDOWN_TO_NIGHT_RAPE"] % 4 == 0 && pc.hasCock() && pc.isMasculine()) { // why restrictions? scene itself supports anything
			nightBazaarButtfuck();
			return;
		}
	}
	
	enterTheBazaarAndMenu(true);
}

////Pure? You'll have to fight!
//public function initiateFightGuard():void {
	//output("You ready your " + pc.weaponName + " and assume a combat stance! He grabs his dual scimitars! It's a fight!", true);
	//startCombat(new BazaarGatekeeper());
//}	
//
//public function winAgainstGuard():void {
	//clearOutput();
	//output("With the gatekeeper defeated, you walk right past the unconscious guard and enter...", false);
	//cleanupAfterCombat(enterTheBazaarAndMenu);
//}

//[Enter]
public function enterTheBazaarAndMenu(demons:Boolean = false):void {
	//Make sure flags to allow entrance is set.
	flags["COC.BAZAAR_ENTERED"] = 1;
	clearOutput();
	showBazaar();
	//spriteSelect(-1);
	//output(images.showImage("location-bazaar"));
	output("You breeze past the crimson guard and enter the interior of the Bizarre Bazaar.  The ground is hard-packed, trampled as if walked over by hundreds of hooves, paws, and feet.  A massive bonfire rages in the center of the clearing, crackling and popping as it consumes its fuel gluttonously.  Surrounding the blazing behemoth are tiny, wheeled food-carts with vendors hawking everything from sausage to something called a 'marshmallow'.  Huge wagons ring the clearing, many set up to display exotic wares or services.  You can see everything from dancing centaurs to demons browsing the wares, but it seems an uneasy truce of sorts reigns here.  Then again, maybe the demons have just not had the chance to openly attack this place yet.");
	output("\n\nOne of the wagons proudly proclaims itself to be \"Greta's Garments,\" though both 'G's are emphasized with cute, stylized devil horns, and the 'S' is shaped in the form of a spaded, demonic tail.  Obviously it must some kind of clothing shop.");
	RoxanneAppearance();
	setBenoitShop();
	fapAppearance();
	//blackCock.blackCockDescription();
	//Set menu. The top row is always available.
	clearMenu();
	addButton(0, "Shops", shopMenu);
	addButton(1, (Flag("COC.FAP_ARENA_RULES_EXPLAINED") > 0 ? "Fap Arena" : "Tent"), fapArenaGOOOO);
	//addButton(2, "Food Tent", blackCock.enterTheBlackCock, null, null, null, "The incredible smell seems to come from that tent.", "The Black Cock");
	//addButton(4, "Back Alley", investigateBackAlley, null, null, null, "That back alley looks suspicious. Do you dare investigate?");
	//Cinnabar
	if (cinnabarAppearance(true) != null) addButton(5, (Flag("COC.CINNABAR_MET") > 0 ? "Cinnabar" : "Rat"), cinnabarGreeting);
	
	//Griping Demons
	if(Flag("COC.GRIPING_DEMONS_STATUS") == 0 && rand(4) == 0 && demons) {
		overHearDemonsAboutSyrena();
		return;
	}
	if((Flag("COC.GRIPING_DEMONS_STATUS") == 1 || Flag("COC.GRIPING_DEMONS_STATUS") == 2) && demons && rand(10) == 0) {
		//[Repeat Variant]
		outputText("\n\n<b>The familiar sounds of the two griping demons can be heard nearby.  Do you listen in again?</b>");
		addButton(6, "GripingDemons", overHearDemonsAboutSyrena, null, "Griping Demons", "Overhear the conversation of the two griping demons.");
	}
	
	//Lilium
	if (LiliumText(true) != null) addButton(7, (Flag("COC.UNKNOWN_FLAG_NUMBER_00267") > 0 ? "Lilium" : "Demon"), approachLilium);
	//Roxanne
	addButton(8, (Flag("COC.ROXANNE_MET") > 0 ? "Roxanne" : "Lizans"), (Flag("COC.ROXANNE_MET") > 0 ? RoxanneChooseApproachOrRepeat : Roxanne1stApproach));
	//Bimbo Niamh
	if (flags["COC.NIAMH_STATUS"] > 0 && flags["COC.NIAMH_MOVED_OUT_COUNTER"] == -1) {
		if (flags["COC.NIAMH_STATUS"] == 2) output("\n\nThe sounds of voices raised in song and girlish laughter makes it obvious where Niamh is holding a perpetual party.");
		addButton(9, "Niamh", bazaarNiamh);
	}
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function shopMenu():void {
	clearMenu();
	showBazaar();
	setBenoitShop(true);
	addButton(1, "G. Garments", gretasGarments);
	addButton(2, "S. Squeeze", theSlipperySqueeze);
	addButton(14, "Back", enterTheBazaarAndMenu);
}

////Prisoner mod!
//private function investigateBackAlley():void {
	//clearOutput();
	//output("Your curiousity draws you half way down a dark alleyway between two tents. In the gloom ahead you see what appears to be a cage wagon, and hear the sounds of guttural voices engaged in boisterous conversation. Inexplicably you find yourself struck by an unwholesome sense of foreboding. <b>Even from here that cage looks like it is designed to carry people off to somewhere very unpleasant, some place where your life could be turned upside down and the rules you have become accustomed to in this world may no longer apply.</b> You take a long moment to consider turning back. Do you throw caution to the wind and investigate further?");
	//doYesNo(getGame().prison.goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems, enterTheBazaarAndMenu);
//}