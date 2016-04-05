import classes.Characters.PlayerCharacter;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// Main places
include "BakeryScene.as";
include "Gym.as";
include "Library.as";
include "Pawn.as";
include "WetBitch.as";

// Shops
include "Armor.as";
include "Jewels.as";
include "Piercing.as";
include "Tailor.as";
include "UmasShop.as";
include "Weapon.as";

// NPCs
include "Katherine.as";

public function discoverTelAdre():void {
	clearOutput();
	clearMenu();
	if (flags["COC.TEL_ADRE_KNOWN"] == undefined) {
		showName("DESERT\nCITY");
		output("The merciless desert sands grind uncomfortably under your " + pc.feet() + " as you walk the dunes, searching the trackless sands to uncover their mysteries.  All of a sudden, you can see the outline of a small city in the distance, ringed in sandstone walls.  Strangely it wasn't there a few moments before.  It's probably just a mirage brought on by the heat.  Then again, you don't have any specific direction you're heading, what could it hurt to go that way?");
		output("\n\nDo you investigate the city in the distance?");
	}
	else {
		showName("\nTEL'ADRE");
		output("While out prowling the desert dunes you manage to spy the desert city of Tel'Adre again.  You could hike over to it again, but some part of you fears being rejected for being 'impure' once again.  Do you try?");
	}
	addButton(0, "Yes", encounterTelAdre);
	addButton(1, "No", function():*{ processTime(10 + rand(5)); mainGameMenu(); });
}

//player chose to approach the city in the distance
private function encounterTelAdre():void {
	clearOutput();
	clearMenu();
	if (flags["COC.TEL_ADRE_KNOWN"] == undefined) {
		showName("DESERT\nCITY");
		output("You slog through the shifting sands for a long time, not really seeming to get that close.  Just when you're about to give up, you crest a large dune and come upon the walls of the city you saw before.  It's definitely NOT a mirage.  There are sandstone walls at least fifty feet tall ringing the entire settlement, and the only entrance you can see is a huge gate with thick wooden doors.  The entrance appears to be guarded by a female gray fox who's more busy sipping on something from a bottle than watching the desert.\n\n");
		output("As if detecting your thoughts, she drops the bottle and pulls out a halberd much longer than she is tall.\n\n");
		output("\"<i>Hold it!</i>\" barks the fox, her dark gray fur bristling in suspicion at your sudden appearance, \"<i>What's your business in the city of Tel'Adre?</i>\"\n\n");
		output("You shrug and explain that you know nothing about this town, and just found it while exploring the desert.  The girl stares at you skeptically for a moment and then blows a shrill whistle.  She orders, \"<i>No sudden moves.</i>\"\n\n");
		output("Deciding you've nothing to lose by complying, you stand there, awaiting whatever reinforcements this cute vulpine-girl has summoned.  Within the minute, a relatively large-chested centauress emerges from a smaller door cut into the gate, holding a massive bow with an arrow already nocked.\n\n");
		output("\"<i>What's the problem, Urta?  A demon make it through the barrier?</i>\" asks the imposing horse-woman.\n\nUrta the fox shakes her head, replying, \"<i>I don't think so, Edryn.  " + pc.mf("He's","She's") + " something else.  We should use the crystal and see if " + pc.mf("he","she") + "'s fit to be allowed entry to Tel'Adre.</i>\"\n\n");
		output("You watch the big centaur cautiously as she pulls out a pendant, and approaches you.  \"<i>Hold still,</i>\" she says, \"<i>this will do you no harm.</i>\"\n\n");
		output("She places one hand on your shoulder and holds the crystal in the other.  Her eyes close, but her brow knits as she focuses on something.  ");
		telAdreCrystal();
	}
	else {
		showName("\nTEL'ADRE");
		output("Once again you find the gray fox, Urta, guarding the gates.  She nods at you and whistles for her companion, Edryn once again.  The centauress advances cautiously, and you submit herself to her inspection as she once again produces her magical amulet.  ");
		telAdreCrystal();
	}
}

//Alignment crystal goooooo
private function telAdreCrystal():void {
	flags["COC.TEL_ADRE_KNOWN"] = 0;
	showName("\nTEL'ADRE");
	//-70+ corruption, or possessed by exgartuan
	if (/*pc.findStatusAffect(StatusAffects.Exgartuan) >= 0 || */pc.cor() >= 70 + corruptionTolerance()) {
		output("The crystal pendant begins to vibrate in the air, swirling around and glowing dangerously black.  Edryn snatches her hand back and says, \"<i>I'm sorry, but you're too far gone to step foot into our city.  If by some miracle you can shake the corruption within you, return to us.</i>\"\n\n");
		output("You shrug and step back.  You could probably defeat these two, but you know you'd have no hope against however many friends they had beyond the walls.  You turn around and leave, a bit disgruntled at their hospitality.  After walking partway down the dune you spare a glance over your shoulder and discover the city has vanished!  Surprised, you dash back up the dune, flinging sand everywhere, but when you crest the apex, the city is gone.");
		addButton(0, "Next", function():*{ processTime(15 + rand(5)); mainGameMenu(); } );
		return;
	}
	//-50+ corruption or corrupted Jojo
	else if(pc.cor() >= 50 /*|| kGAMECLASS.monk >= 5*/) {
		output("The crystal pendant shimmers, vibrating in place and glowing a purple hue.  Edryn steps back, watching you warily, \"<i>You've been deeply touched by corruption.  You balance on a razor's edge between falling completely and returning to sanity.  You may enter, but we will watch you closely.</i>\"\n\n");
	}
	//-25+ corruption or corrupted Marae
	else if(pc.cor() >= 25 || flags["COC.FACTORY_SHUTDOWN"] == 2 || pc.hasPerk("Corrupted Nine-tails")) {
		output("The crystal pendant twirls in place, glowing a dull red.  Edryn takes a small step back and murmers, \"<i>You've seen the darkness of this land first hand, but its hold on you is not deep.  You'll find sanctuary here.  The demons cannot find this place yet, and we promise you safe passage within the walls.</i>\"\n\n");
	}
	//-Low corruption/pure characters
	else if(pc.cor() >= 1 || !(pc.hasPerk("Enlightened") || pc.hasPerk("Purity Blessing") || pc.hasPerk("Enlightened Nine-tails"))) {
		output("The crystal shines a pale white light.  Edryn steps back and smiles broadly at you and says, \"<i>You've yet to be ruined by the demonic taint that suffuses the land of Mareth.  Come, you may enter our city walls and find safety here, though only so long as the covenant's white magic protects us from the demons' lapdogs.</i>\"\n\n");
	}
	else {
		output("The crystal shines a dazzling white light!  Edryn steps back staring at you with shocked expression and says, \"<i>Whoa...  Are you fucking saint?  Anyway, you are definitely welcome here.  Come, you may enter our city walls and find safety here, though only so long as the covenant's white magic protects us from the demons' lapdogs.</i>\"\n\n");		
	}
	output("The vixen Urta gestures towards the smaller door and asks, \"<i>Would you like a tour of Tel'Adre, newcomer?</i>\"\n\n");
	output("You remember your etiquette and nod, thankful to have a quick introduction to such a new place.  Urta leaves Edryn to watch the gate and leads you inside.  You do notice her gait is a bit odd, and her fluffy fox-tail seems to be permanently wrapped around her right leg.  The door closes behind you easily as you step into the city of Tel'Adre...");
	processTime(5 + rand(3));
	addButton(0, "Next", telAdreTour);
}

private function telAdreTour():void {
	flags["COC.TEL_ADRE_KNOWN"] = 1;
	clearOutput();
	showName("\nTEL'ADRE");
	//kGAMECLASS.urta.urtaSprite();
	output("Urta leads you into the streets of Tel'Adre, giving you a brief run-down of her and her city, \"<i>You see, about two decades back, the demons were chewing their way through every settlement and civilization in Mareth.  The covenant, a group of powerful magic-users, realized direct confrontation was doomed to fail.  They hid us in the desert with their magic, and the demons can't corrupt what they can't find.  So we're safe, for now.</i>\"\n\n");
	output("The two of you find yourselves in the center of a busy intersection.  Urta explains that this is the main square of the city, and that, although the city is large, a goodly portion of it remains empty.  Much of the population left to assist other settlements in resisting the demons and was lost.  She brushes a lock of stray hair from her eye and guides you down the road, making sure to point out her favorite pub - \"The Wet Bitch\".  You ");
	if(pc.cor() < 25) output("blush", false);
	else output("chuckle", false);
	output(" at the rather suggestive name as Urta turns around and says, \"<i>With how things are, we've all gotten a lot more comfortable with our sexuality.  I hope it doesn't bother you.</i>\"\n\n");
	output("A bit further on, you're shown a piercing parlor, apparently another favorite of Urta's.  A cute human girl with cat-like ears peeks out the front and gives you both a friendly wave.  It's so strange to see so many people together in one place, doing things OTHER than fucking.  The whole thing makes you miss your hometown more than ever.  Tears come to your eyes unbidden, and you wipe them away, glad to at least have this one reminder of normalcy.  Urta politely pretends not to notice, though the tail she keeps wrapped around her leg twitches as she wraps up the tour.\n\n");
	output("She gives you a friendly punch on the shoulder and says, \"<i>Okay, gotta go!  Be good and stay out of trouble, alright?</i>\"\n\n");
	output("Before you can answer, she's taken off back down the street, probably stopping off at 'The Wet Bitch' for a drink.  Strange, her departure was rather sudden...");
	processTime(25 + rand(15));
	addButton(0, "Next", telAdreMenu);
}

public function telAdreMenu():void {
	clearOutput();
	userInterface.setLocation("TEL'ADRE\nSTREETS", "TEL'ADRE", "PLANET: MARETH");
	//if(flags[kFLAGS.VALENTINES_EVENT_YEAR] < date.fullYear && pc.balls > 0 && pc.hasCock() && flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4 && flags[kFLAGS.TIMES_MET_SCYLLA_IN_ADDICTION_GROUP] > 0 && isValentine()) {
		//kGAMECLASS.crazyVDayShenanigansByVenithil();
		//return;
	//}
	if(/*!kGAMECLASS.urtaQuest.urtaBusy() &&*/ Flag("COC.PC_SEEN_URTA_BADASS_FIGHT") == 0 && rand(15) == 0 && hours > 15 && hours < 20) {
		urtaIsABadass();
		return;
	}
	//if (!kGAMECLASS.urtaQuest.urtaBusy() && kGAMECLASS.urta.pregnancy.event > 5 && rand(30) == 0) {
		//kGAMECLASS.urtaPregs.urtaIsAPregnantCopScene();
	   //return;
	//}
	switch (flags["COC.KATHERINE_UNLOCKED"]) {
		case undefined:
		case -1:
		case  0: //Still potentially recruitable
			if (flags["COC.KATHERINE_LAST_AMBUSH"] != days && flags["COC.KATHERINE_RANDOM_RECRUITMENT_DISABLED"] == undefined && pc.credits >= 350 && rand(20) == 0) {
				flags["COC.KATHERINE_LAST_AMBUSH"] = days; // can happen once a day
				if (flags["COC.KATHERINE_UNLOCKED"] == undefined)
					ambushByVagrantKittyKats()
				else repeatAmbushKatherineRecruitMent();
				return;
			}
		case  1: //In alley behind Oswald's
		case  2: //You are training her
		case  3: //You and Urta are training her
			break;
		case  4: //Employed
			//if (!kathIsAt(KLOC_KATHS_APT) && flags["COC.KATHERINE_TRAINING"] >= 100) {
				//katherineGetsEmployed();
				//return;
			//}
		default: //Has given you a spare key to her apartment
			//if (hours >= 5 && hours < 10 && rand(12) == 0) { //If employed or housed she can sometimes be encountered while on duty
				//katherineOnDuty();
				//return;
			//}
	}
	if(!(flags["COC.ARIAN_PARK"] > 0) && rand(10) == 0 && flags["COC.NOT_HELPED_ARIAN_TODAY"] != days) {
		meetArian();
		return;
	}
	//Display Tel'adre menu options//
	//Special Delivery☼☼☼
	//Has a small-ish chance of playing when the PC enters Tel'Adre.
	//Must have Urta's Key.
	//Urta must be pregnant to trigger this scene.
	//Play this scene upon entering Tel'Adre.
	//if (kGAMECLASS.urta.pregnancy.event > 2 && rand(4) == 0 && flags[kFLAGS.URTA_PREGNANT_DELIVERY_SCENE] == 0 && pc.hasKeyItem("Spare Key to Urta's House") >= 0) {
		//kGAMECLASS.urtaPregs.urtaSpecialDeliveries();
		//return;
	//}
	if(flags["COC.BAKERY_MADDIE_STATE"] == -1) {
		runAwayMaddieFollowup();
		return;
	}
	//spriteSelect(-1);
	//output(images.showImage("location-teladre"));
	output("Tel'Adre is a massive city, though most of its inhabitants tend to hang around the front few city blocks.  It seems the fall of Mareth did not leave the city of Tel'Adre totally unscathed.  A massive tower rises up in the center of the city, shimmering oddly.  From what you overhear in the streets, the covenant's magic-users slave away in that tower, working to keep the city veiled from outside dangers.  There does not seem to be a way to get into the unused portions of the city, but you'll keep your eyes open.\n\n");
	output("A sign depicting a hermaphroditic centaur covered in piercings hangs in front of one of the sandstone buildings, and bright pink lettering declares it to be the 'Piercing Studio'.  You glance over and see the wooden facade of Urta's favorite bar, 'The Wet Bitch'.  How strange that those would be what she talks about during a tour.  In any event you can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand, and a foppishly-dressed dog-man with large floppy ears seems to be running some kind of pawnshop in his stand.  Steam boils from the top of a dome-shaped structure near the far end of the street, and simple lettering painted on the dome proclaims it to be a bakery.  Perhaps those shops will be interesting as well.");
	//if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && !kGAMECLASS.raphael.RaphaelLikes()) {
		//output("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
	//}
	telAdreMenuShow();
}

public function telAdreMenuShow():void { //Just displays the normal Tel'Adre menu options, no special events, no description. Useful if a special event has already played
	var homes:Boolean = false;
	clearMenu();
	addButton(0, "Shops", armorShops, undefined, "Shops", "Check local shops.");
	addButton(1, "Bakery", bakeryuuuuuu, undefined, "Bakery", "Visit bakery.");
	addButton(2, "Bar", enterBarTelAdre, undefined, "Bar", "Visit \"Wet Bitch\" bar.");
	addButton(3, "Gym", TelAdreGymDesc, undefined, "Gym", "Visit gym.");
	addButton(4, "Homes", TelAdreHouses, undefined, "Homes", "If you have friends here, you can visit them.");
	addDisabledButton(5, "Park", "Park", "You have nothing to do in park.");
	if (Flag("COC.ARIAN_PARK") > 0 && Flag("COC.ARIAN_PARK") < 4 && Flag("COC.ARIAN_PARK_VISITED_TODAY") != days) addButton(5, "Park", arianSceneVisitThePark, "Arian is likely there, why not visit him?");
	addButton(6, "Pawn", oswaldPawn, undefined, "Gym", "You can always get rid of some junk here.");
	addButton(7, "Tower", visitZeMagesTower, undefined, "Tower", "Mages tower is main landmark of Tel'Adre. Maybe you can find something useful there?");
	addButton(14, "Leave", function():*{ processTime(15 + rand(5)); mainGameMenu(); }, undefined, "Leave", "Return to camp.");
}

private function armorShops():void {
	clearOutput();
	userInterface.setLocation("TEL'ADRE\nMERCHANTS", "TEL'ADRE", "PLANET: MARETH");
	clearMenu();
	output("The shopping district of Tel’adre happens to be contained in a large dead end street, with a large set of doors at the entrance to protect it from thieves at night, you’d assume from a higher elevation it would look like a giant square courtyard. Due to the cities shopping area being condensed into one spot, most if not every visible wall has been converted into a store front, in the center of the area are some small stands, guess not everyone can afford a real store.");
	output("\n\nRight off the bat you see the ‘Piercing Studio’, its piercing covered centaur sign is a real eye catcher. You can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand. As well as other shops lining the walls, perhaps those shops will be interesting as well.");
	addButton(0, "Blacksmith", TelAdreArmorShop);
	addButton(1, "Piercing", piercingStudio);
	addButton(2, "Tailor", tailorShoppe);
	addButton(3, "Weapons", TelAdreWeaponShop);
	addButton(4, "Jewelry", jewelShopEntry);
	if (flags["COC.LOPPE_PC_MET_UMA"] == 1)
		addButton(5, "Clinic", umasShopEnterClinic);
	//if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 4)
	//{
		//addButton(6, "Carpenter", carpentryShopEntry);
	//}
	addButton(14, "Back", telAdreMenu);
}

public function TelAdreHouses():void {
	clearOutput();
	userInterface.setLocation("TEL'ADRE\nAPARTMENTS", "TEL'ADRE", "PLANET: MARETH");
	clearMenu();
	output("Whose home will you visit?");
	//var orphanage:Function = null;
	//if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2) {
		//if(kGAMECLASS.raphael.RaphaelLikes())
		//{
			//orphanage = kGAMECLASS.raphael.orphanageIntro;
		//}
		//else {
			//output("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
		//}
	//}
	clearMenu();
	if (flags["COC.ARIAN_PARK"] >= 4 && !arianFollower()) addButton(0, "Arian's", visitAriansHouse);
	//addButton(1,"Orphanage",orphanage);
	//if (kGAMECLASS.urtaPregs.urtaKids() > 0 && pc.hasKeyItem("Spare Key to Urta's House") >= 0)
		//addButton(2, "Urta's House", (katherine.isAt(Katherine.KLOC_URTAS_HOME) ? katherine.katherineAtUrtas : kGAMECLASS.urtaPregs.visitTheHouse));
	//if (flags["COC.KATHERINE_UNLOCKED"] >= 5) addButton(3, "Kath's Apt", katherineVisitAtHome);

	switch (flags["COC.KATHERINE_UNLOCKED"]) {
		case 1:
		case 2: addButton(3, "Kath's Alley", visitKatherine); break;
		//case 3: addButton(3, "Safehouse", katherineTrainingWithUrta, undefined, "Safehouse", "Check Kath's training progress."); break;
		//case 4: addButton(3, "Kath's Alley", postTrainingAlleyDescription); break; //Appears until Kath gives you her housekeys
		//case 5: addButton(3, "Kath's Apt", katherineVisitAtHome); break;
	}
	
	addButton(14, "Back", telAdreMenu);
}

private function urtaIsABadass():void {
	flags["COC.PC_SEEN_URTA_BADASS_FIGHT"] = 1;
	userInterface.setLocation("\nURTA", "TEL'ADRE", "PLANET: MARETH");
	clearOutput();
	output("There's a commotion in the streets of Tel'Adre.  A dense crowd of onlookers has formed around the center of the street, massed together so tightly that you're unable to see much, aside from the backs the other onlookers' heads.  The sound of blows impacting on flesh can be heard over the crowd's murmuring, alerting you of the fight at the gathering's core.");
	processTime(1);
	clearMenu();
	addButton(0, "Investigate", watchUrtaBeABadass);
	addButton(1, "Who cares?", telAdreMenu);
}

//[Invetigate]
private function watchUrtaBeABadass():void {
	clearOutput();
	userInterface.setLocation("\nURTA", "TEL'ADRE", "PLANET: MARETH");
	//kGAMECLASS.urta.urtaSprite();
	output("You shoulder past the bulky centaurs, ignore the rough fur of the nearby wolves and hounds as it brushes against you, and press your way through to the center of the crowd.  Eventually the throng parts, revealing the embattled combatants.  A snarling wolf, nearly eight feet tall, towers over Urta.  The comparatively diminutive fox-woman is girded in light leather armor and dripping with sweat.  The larger wolf-man is staggering about, and his dark brown fur is matted with blood.\n\n");

	output("The bigger canid charges, snarling, with his claws extended.  Urta sidesteps and pivots, her momentum carrying her foot around in a vicious kick.  Her foot hits the side of the beast's knee hard enough to buckle it, and the wolf goes down on his knees with an anguished cry.  Urta slips under his arm and twists, turning his slump into a fall.  A cloud of dust rises from the heavy thud of the beast's body as it slams into the cobblestone street.\n\n");

	output("Now that it's immobile, you get can get a better look at the defeated combatant, and you're ");
	//if(pc.findStatusAffect(StatusAffects.Infested) >= 0) output("aroused", false);
	//else 
	if(pc.cor() < 50) output("horrified");
	else output("confused");
	output(" by what you see.  A pair of thick, demonic horns curve back over the beast's head, piercing through the bottoms of its wolf-like ears.  Its entire body is covered in rippling muscle, leaving you in no doubt of its strength.  Even with a broken knee, the wolf-man is clearly aroused: protruding from a bloated sheath, his massive dog-dick is fully erect, solid black in color, with an engorged knot.  Small white worms crawl over the surface of his penis, wriggling out of the tip and crawling down the length, leaving trails of slime behind them.\n\n");

	output("Urta kneels down onto the corrupted wolf's throat, cutting off its air as it foams and struggles under her.  With grim determination, she holds the weakening, demonically-tainted wolf underneath her, leaning all of her body-weight into her knee to keep it down.  It struggles for what seems like ages, but eventually the tainted wolf's eyes roll closed.  Urta nods and rises, watching closely as the beast's breathing resumes.\n\n");

	output("She barks, \"<i>Get this one outside the walls before he wakes.  I won't have this corrupted filth in our city, and make sure you get the wards updated.  If he manages to find his way back, you sorry excuses for guards will be going out with him.</i>\"\n\n");
	output("A few dog-morphs in similar armor to Urta approach and lash ropes around the wolf's legs.  They hand a line to a centaur, and together the party begins dragging the unconscious body away.  With the action over, the crowd begins dispersing.  More than a few males nod to Urta respectfully.  She keeps her expression neutral and excuses herself to resume her rounds, wiping her hands off on her armor-studded skirt as she leaves.");
	
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}