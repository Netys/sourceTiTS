import classes.Characters.CoC.CoCBrigid;
import classes.Characters.CoC.CoCHarpyMob;
import classes.Characters.CoC.CoCHarpyQueen;
import classes.Characters.CoC.CoCPhoenixPlatoon;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Apparel.CoCBondageStraps;
import classes.Items.Drinks.CoCGodMead;
import classes.Items.Melee.CoCLustDagger;
import classes.Items.Melee.CoCSuccubusWhip;
import classes.Items.Melee.CoCWizardStaff;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "brigidScene.as";
include "valeria.as";
include "harpyMob.as";
include "harpyQueen.as";
include "helia.as";
include "kiri.as";
include "phoenixPlatoon.as";

public function TravelToPhoenixTower():void {
	processTime(15 + rand(5));
	move("COC PHOENIX ENTRACE"); 
}

public function TravelFromPhoenixTower():void {
	processTime(15 + rand(5));
	move("COC_CAMP"); 
}

private function PhoenixTowerEntranceRoomFunc():Boolean
{
	if (flags["COC.CLEARED_HEL_TOWER"] != undefined) {
		output("\n\nYou have already cleared this tower. You can leave if you like to.");
		addButton(7, "Leave", TravelFromPhoenixTower);
	}
	return false;
}

public function PhoenixTowerGuardHallRoomFunc():Boolean {
	output("You stand in what might have been a guard room once upon a time.  Now it is a ruined, ransacked mess.  It seems not to have been used in years, and the table, chairs, and spears lined up against the wall have all rotted away to almost nothing.");
	//[If Armor has not been taken/fought with: 
	if (flags["COC.WON_GOO_ARMOR_FIGHT"] == undefined && flags["COC.LOST_GOO_ARMOR_FIGHT"] == undefined) {
		if (flags["COC.CLEARED_HEL_TOWER"] == undefined) {
			output("  However, a suit of half-plate armor has been left up against the eastern wall, hanging loosely on a rack; it seems to be in usable shape.");
			addButton(0, "Armor", takeGooArmor, undefined,"Armor", "Approach the armor. You're sure the armor might be useful.");
		}
		else output("  You recall there was a suit of half-plate armor.  The rack appears to be empty.");
	}
	output("  You see a pair of heavy iron doors leading northward, though they seem so rusty and heavy that opening them is sure to alert anyone nearby, and a small trapdoor leading down.");
	//(Display Options: [North Door] [Trapdoor] [pc.gear])
	//addButton(7, "Trapdoor", roomCellar);
	return false;
}

public function PhoenixTowerCellarRoomFunc():Boolean {
	//(Accessed from the Trapdoor button)
	output("You've dropped down into a small underground hidey-hole, with ");
	if (pc.tallness < 60) output("just enough room to stand up in");
	else output("a ceiling so low you have to crouch");
	output(".  To your surprise, nothing horrifying jumps out and tries to rape you.");
	
	//Display Options: [GodsMead] [Climb Up]
	//clearMenu();
	if(flags["COC.HEL_DUNGEON_MEAD_LOOTED"] > 0) {
		if (flags["COC.HEL_DUNGEON_MEAD_LOOTED"] < 5) {
			output("\n\nYou see a few horns of mead slung up in a wine rack - they smell a bit pungent, but alcohol improves with age they say... ");
			output("There " + (flags["COC.HEL_DUNGEON_MEAD_LOOTED"] == 4 ? "is" : "are") + " " + num2Text(5 - flags["COC.HEL_DUNGEON_MEAD_LOOTED"]) + " God's Mead " + (flags["COC.HEL_DUNGEON_MEAD_LOOTED"] == 4 ? "horn" : "horns") + " here to take.");
			addButton(0, "GodMead", PhoenixTowerTakeMead);
		} else {
			output("The wine rack is empty. You have already looted all the horns of mead.");
			addDisabledButton(0, "GodMead", "God Mead", "The wine rack is empty. You have already looted all the horns of mead.");
		}
	}
	else {
		output("\n\nYou see a few horns of mead slung up in a wine rack - they smell a bit pungent, but alcohol improves with age they say... ");
		addButton(0, "GodMead", PhoenixTowerTakeMead);
	}
	//addButton(1, "Climb Up", move, "COC PHOENIX GUARD HALL");
	return false;
}

public function PhoenixTowerStairwellRoomFunc():Boolean {
	if (flags["COC.HEL_HARPIES_DEFEATED"] == undefined) {
		output("You open the heavy double doors and cringe as a loud \"<i>SCREECH!</i>\" echoes out and up the next room - a wide open stairwell, it seems, with minimal cover.  The perfect place for a harpy to fight... Oh, shit!");
		output("\n\nYou [pc.readyWeapon] as a wing of harpies looks up from eating at a small table in the center of the stone stairwell, all staring at you with wide, astonished eyes.  Another few harpies peer down from above, poking their heads down the stairs to get a look at the intruder.  Almost in unison, they jump to their feet and bare their claws.");
		output("\n\nIt's a fight!");
		
		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCHarpyMob());
		CombatManager.victoryScene(pcDefeatsHarpyHorde);
		CombatManager.lossScene(pcLosesToHarpyHorde);
		CombatManager.displayLocation("HARPY MOB");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	else {
		if (flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined) {
			output("There's a pile of drugged, unconscious harpies you've already defeated on the floor, as well as Kiri, the only one that didn't attack you.  You recall that she knows Hel and is here to help the both of you.");
			//(Display Options: [Talk] [Sex] [Valeria](If Encountered) [Go Upstairs] [Go Downstairs])
			var valeria:Number = 0;
			//if (pc.armorName == "goo armor") addButton(1, "Valeria", talkToValeria, null, null, null, "Talk to Valeria about the current situation.");
			//addButton(0, "Kiri", kiriInteraction, undefined, "Kiri", "Approach Kiri, the half-breed girl.");
			addButton(0, "Talk", talkToKiri, undefined, "Talk", "Have some talk with Kiri.");
			if (pc.hasGenitals()) addButton(1, "Sex", kiriSexIntro, undefined, "Sex", "Use Kiri to sate your lusts. After all, your lust can make a difference between your success and failure.");
			else addDisabledButton(1, "Sex", "Sex", "Unfortunately, there's not much she can do for you...");
		}
		else {
			if (flags["COC.CLEARED_HEL_TOWER"] != undefined)
				output("You're in a large room. There is a wide open stairwell. Ever since your last visit, the room is awfully empty. To the south is a pair of large, open double doors. You can go downstairs into the dungeon or climb up the stairs to the mezzanine.");
			else 
				output("There's a pile of drugged, unconscious harpies you've already defeated on the floor.  Kiri appears to have left.");
		}
	}
	return false;
}

public function PhoenixTowerDungeonRoomFunc():Boolean {
	//(Intro -- Before Fight)
	if (flags["COC.HEL_BRIGID_DEFEATED"] == undefined) {
		output("You make your way downstairs into a small, smoky stone room.  A thick smell of steam and burnt meat hangs over the room, making you cough as you descend the stairs.  As you make your way into the tower's little dungeon, you quickly notice the salamander chained to a table.  He's a great big man, nearly eight feet tall and covered in scars.  He has short, spiky red hair, the same color as his tail and limb scales, and a black eyepatch covers his left socket.  He looks like hell, emaciated and exhausted, covered in thick cum-stains from being used an untold number of times by the harpies of the tower.");
		output("\n\nBeside him, though, is the tallest harpy you've ever seen.  A foot over most of her sisters, she stands stark naked save for a red-hot iron poker in her hand and a heavy iron shield in the other.  Her pink hair is shaved down to a mohawk, and her face is covered with a dozen iron studs and rings.");
		output("\n\n\"<i>'Bout time you made it down here, you " + pc.mf("bastard", "bitch") + ".  Mama Brigid's been waiting a loooong time for someone to try and break out one of her toys.</i>\"  She pats the hefty keyring on the underside of her shield and leers at you.");
		output("\n\nYou [pc.readyWeapon] and prepare to take the keys from her!");
		
		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCBrigid());
		CombatManager.victoryScene(pcDefeatsBrigid);
		CombatManager.lossScene(pcDefeatedByBrigid);
		CombatManager.displayLocation("BRIGID");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	else {
		if (flags["COC.CLEARED_HEL_TOWER"] == undefined) {
			output("You're standing in a small dungeon room, nearly gagging on the smells of burnt meat and smoke.  A number of nasty torture devices hang on the walls, and a table sits in the middle of the room, ");
			if (flags["COC.HEL_PC_TALKED_WITH_HAKON"] == undefined) {
				output("on which the salamander prisoner lies");
				addButton(0, "Prisoner", helDungeonPrisonerTalk, undefined, "Prisoner", "Talk to the salamander prisoner.")
			}
			else {
				output("on which Hakon lies");
				addButton(0, "Hakon", helDungeonPrisonerTalk, undefined, "Hakon", "Talk to Hakon.")
			}
			output(".");
			if (pc.hasKeyItem("Harpy Key A") && pc.hasKeyItem("Harpy Key B")) output("\n\n<b>You have the keys to release the prisoner.  You may be able to return in the future by choosing \"Phoenix Tower\" from the dungeons submenu.</b>");
		}
		else {
			output("You're standing in a small dungeon room, nearly gagging on the smells of burnt meat and smoke.  A number of nasty torture devices hang on the walls, and an empty table sits in the middle of the room.");
		}
		//(Display Options: [Go Upstairs](Back to Stairwell & Kiri) [Prisoner] [Torture Gear]
		addButton(1, "Torture Gear", tortureGear, undefined, "Torture Gear", "There are some kinky equipment, ripe for the picking.");
	}
	return false;
}

//[Torture Gear]
public function tortureGear():void {
	clearMenu();
	clearOutput();
	output("You walk up to the torture rack.  ");
	if (flags["COC.HEL_DUNGEON_TAKEN_WHIP"] == undefined || flags["COC.HEL_DUNGEON_TAKEN_STRAPS"] == undefined || flags["COC.HEL_DUNGEON_TAKEN_DAGGER"] == undefined) {
		output("The rack contains: ");
		enum.clear();
		if (flags["COC.HEL_DUNGEON_TAKEN_WHIP"] == undefined) {
			enum.push("A whip");
			addButton(0, "SucWhip", takeWhip);
		}
		if (flags["COC.HEL_DUNGEON_TAKEN_STRAPS"] == undefined) {
			enum.push("some leather straps");
			addButton(1, "BonStrp", takeStraps);
		}
		if (flags["COC.HEL_DUNGEON_TAKEN_DAGGER"] == undefined) {
			enum.push("a lust-draft coated dagger");
			addButton(2, "L.Daggr", takeDagger);
		}
		output(enum.toString());
		output(".  ");
	}
	else output("The rack is empty.");
	//(PC can take a Succubus Whip, Bondage Straps, and a Lust Dagger)
	addButton(14, "Back", mainGameMenu);
}

public function takeWhip():void {
	quickLoot(new CoCSuccubusWhip());
	flags["COC.HEL_DUNGEON_TAKEN_WHIP"] = 1;
}

public function takeStraps():void {
	quickLoot(new CoCBondageStraps());
	flags["COC.HEL_DUNGEON_TAKEN_STRAPS"] = 1;
}

public function takeDagger():void {
	quickLoot(new CoCLustDagger());
	flags["COC.HEL_DUNGEON_TAKEN_DAGGER"] = 1;
}

public function PhoenixTowerMezzanineRoomFunc():Boolean {
	//(Intro; Before Battle)
	if (flags["COC.HEL_PHOENIXES_DEFEATED"] == undefined) {
		output("You ascend the heavy stone steps, circling the tower's walls as you ascend.  You are stopped perhaps half-way to the second main floor on a small terrace level with a wide open view overlooking the vale beneath the high mountains.  As you step onto the mezzanine, you watch with a scowl as a number of tall, muscular hermaphrodites step out from the shadows.  Each is clad in heavy chainmail and wields a scimitar and a blood-red shield, but is otherwise nude, revealing their reptilian pricks and slick pussies.  The soldiers standing before you look like harpies, but they have scaled, humanoid legs, long, fiery tails and their wings are the darkest crimson.  These are phoenixes - the dread half-breed warriors you and Hel are here to stop!");
		
		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCPhoenixPlatoon());
		CombatManager.victoryScene(phoenixPlatoonLosesToPC);
		CombatManager.lossScene(phoenixPlatoonMurdersPC);
		CombatManager.displayLocation("PHOENIXES");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	else {
		if (flags["COC.CLEARED_HEL_TOWER"] == undefined) output("You're standing in the Mezzanine of the tower, a small terrace with a magnificent view of the High Mountains and the valleys below.  There are stairs leading up and down from here, as well as a pile of defeated phoenixes that don't look like they'll be recovering for a bit.");
		else output("You're standing in the Mezzanine of the tower, a small terrace with a magnificent view of the High Mountains and the valleys below.  There are stairs leading up and down from here.");
		//(Display Options: [Go Upstairs] [Go Downstairs] [Phoenixes])
		if (flags["COC.CLEARED_HEL_TOWER"] == undefined) addButton(0, "Phoenixes", checkOutDemBirdBitches, undefined, "Phoenixes", "Examine the phoenixes and possibly sate your baser needs.");
		//(Go Downstairs returns you to the Stairwell; Go Up takes you to the throne room)
	}
	return false;
}

public function PhoenixTowerThroneRoomRoomFunc():Boolean {
	//Throne Room Descript (Before Combat!)
	if (flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined) {
		output("Ascending the stairs, you are stopped by a pair of heavy double doors.  They're covered with rotting, chipped purple paint and laurels that look years old.  The sharp, screeching sounds of metal on metal ring out in the next room - the sounds of a fight!  You kick the door open, and charge into what must be some kind of throne room; a large carpet dominates your view, leading up to a towering throne surrounded by pillows and cushions, currently vacant.");

		output("\n\nIn the center of the throne room stand Helia the Salamander and a harpy that could only be described as a broodmother.  She isn't particularly tall or menacing looking, but her hips are truly inhuman, thrice as wide as she is at the least, and her pillowy ass seems canyon-like in her nudity, the type of butt you could lose yourself in forever.  The harpy matron, wielding a staff, is currently locked in a fierce battle against Hel's red-hot scimitar.");

		output("\n\nSeeing you in the corner of her eye, Hel spins out of the contest and comes to stand beside you, blade raised toward the harpy broodmother.");

		output("\n\n\"<i>[pc.name]!</i>\" she says, giving you a teasing slap on the ass with her tail.  \"<i>Took your sweet time, didn't you? Here I was starting to think I'd get this bitch all to myself!</i>\"");

		output("\n\nYou give Hel a reassuring nod and start to circle toward the Harpy Queen, taking the left flank while Hel heads right.  The queen looks from one of you to the other, a ball of white-hot magic fire conjured in her hand.");

		output("\n\n\"<i>You fools!</i>\" the queen hisses, backing away from you as best she can.  \"<i>You know not what you do!  My children... Their sole purpose was for the good of Mareth! You have ruined everything! Now the demons will have us all.</i>\"");

		output("\n\nYou ignore her, focusing on getting into position for a quick take-down with the help of your salamander lover.  However, before you can back the Harpy Queen into a corner, you hear an explosive BOOM from above.  You look up in time to see a hole erupt in the tower's ceiling, and a great brood of harpies pour in, dozens of them at the least.");

		output("\n\n\"<i>Oh well, fuck me!</i>\" Hel screams, dodging a hail of blows as the harpies swarm the throne room.  You can only just hear the broodmother laughing, bidding her children onwards over the sound of screeching and beating wings.");
		output("\n\n\"<i>FUCK! [pc.name]!</i>\" Hel yells, cleaving a harpy in two with her scimitar, \"<i>Take a piece of the action; get the queen.  I've got these bitches!</i>\"");

		output("\n\nBefore you can say a word, Hel grabs a pair of harpies and, using them like human battering rams, dives into the swirling maelstrom of talons and claws.  You turn, [pc.mainWeapon] raised, to face down the queen.");

		output("\n\nShe now sits upon her throne, her staff laid across her bird-like legs.  \"<i>Idiot,</i>\" she sneers, just loud enough to be heard over the din of battle.  \"<i>You've doomed us all.  So many of my daughters dead or beaten or fled... No, I will not allow you to go unpunished, even if it means my life.</i>\"");
		output("\n\nShe stands, grabbing her great whitewood staff.  A ball of magical whitefire forms in her hand, ready to sear you alive.");
		output("\n\n<b>An unseen force slams the door shut, preventing you from escape. It's a fight!</b>");
		
		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCHarpyQueen());
		CombatManager.victoryScene(harpyQueenDefeatedByPC);
		CombatManager.lossScene(harpyQueenBeatsUpPCBadEnd);
		CombatManager.displayLocation("HARPY QUEEN");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	else {
		//Room Description:
		if (flags["COC.CLEARED_HEL_TOWER"] == undefined) output("You stand in the harpy throne room - a long, circular room dominated by a high throne surrounded by cushions and drapes.  A single long carpet flows from the heavy double doors to the throne, reminding you of a castle's great hall in days gone by.  A number of harpies cower in the shadows, afraid to oppose you further now that their mighty leader is defeated.");
		else output("You stand in the harpy throne room - a long, circular room dominated by a high throne surrounded by cushions and drapes.  A single long carpet flows from the heavy double doors to the throne, reminding you of a castle's great hall in days gone by.  ");
		
		//[if PC hasn't executed the queen: 
		if (flags["COC.HARPY_QUEEN_EXECUTED"] == undefined) {
			output("  The Harpy Queen slumps in her throne, insensate.");
			clearMenu();
			addButton(0, "Helia", HeliaThroneRoom);
			addButton(1, "Harpy Queen", harpyQueenAdvantage);
			return true;
		}
		//if (flags["COC.HARPY_QUEEN_EXECUTED"] == 1 && flags["COC.TOOK_QUEEN_STAFF"] == undefined) {
			//addButton(0, "Take Staff", takeQueensStaff);
		//}
	}
	return false;
}

public function PhoenixTowerTakeMead():void {
	clearOutput();
	clearMenu();
	IncrementFlag("COC.HEL_DUNGEON_MEAD_LOOTED");
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCGodMead()]);
}

public function PhoenixTowerCleared():Boolean {
	return flags["COC.CLEARED_HEL_TOWER"] > 0;
}

public function PhoenixTowerRoomUpdateNotify():void {
	if(PhoenixTowerCleared())
	{
		rooms["COC PHOENIX ENTRACE"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX GUARD HALL"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX WINE CELLAR"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX STAIR WELL"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX DUNGEON"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX MEZZANINE"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC PHOENIX THRONE ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
	}
	
	rooms["COC PHOENIX GUARD HALL"].removeFlags(GLOBAL.NPC);
	if (flags["COC.CLEARED_HEL_TOWER"] == undefined && flags["COC.WON_GOO_ARMOR_FIGHT"] == undefined && flags["COC.LOST_GOO_ARMOR_FIGHT"] == undefined) rooms["COC PHOENIX GUARD HALL"].addFlag(GLOBAL.NPC);
	
	rooms["COC PHOENIX STAIR WELL"].removeFlags(GLOBAL.OBJECTIVE, GLOBAL.NPC);
	if (flags["COC.HEL_HARPIES_DEFEATED"] == undefined) rooms["COC PHOENIX STAIR WELL"].addFlag(GLOBAL.OBJECTIVE);
	
	rooms["COC PHOENIX DUNGEON"].removeFlags(GLOBAL.OBJECTIVE, GLOBAL.NPC);
	if (flags["COC.CLEARED_HEL_TOWER"] == undefined) rooms["COC PHOENIX DUNGEON"].addFlag(GLOBAL.OBJECTIVE);
	
	rooms["COC PHOENIX MEZZANINE"].removeFlags(GLOBAL.OBJECTIVE, GLOBAL.NPC);
	if (flags["COC.HEL_PHOENIXES_DEFEATED"] == undefined) rooms["COC PHOENIX MEZZANINE"].addFlag(GLOBAL.OBJECTIVE);
	
	rooms["COC PHOENIX THRONE ROOM"].removeFlags(GLOBAL.OBJECTIVE, GLOBAL.NPC);
	if (flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined) rooms["COC PHOENIX THRONE ROOM"].addFlag(GLOBAL.OBJECTIVE);
	else if (flags["COC.HARPY_QUEEN_EXECUTED"] == undefined) rooms["COC PHOENIX THRONE ROOM"].addFlag(GLOBAL.NPC);
	
}
private var PhoenixTowerRoomUpdateNotifyHook: * = PhoenixTowerRoomUpdateNotifyGrapple();
private function PhoenixTowerRoomUpdateNotifyGrapple():* { variableRoomUpdateListeners.push(PhoenixTowerRoomUpdateNotify); }