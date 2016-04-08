import classes.Characters.CoC.CoCZetaz;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Apparel.CoCBondageStraps;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "FungalPodScene.as"
include "ImpHordeScene.as"
include "SeanScene.as"
include "ValaScene.as"
include "ZetazScene.as"

// TODO: Vala
public function ZetazCaveEnter():void {
	clearOutput();
	clearMenu();
	//output(images.showImage("dungeon-entrance-deepcave"));
	
	processTime(20 + rand(20));
	
	if (flags["COC.ZETAZ_CAVE_FOUND"] == undefined) {		
		output("While you explore the deepwoods, you do your best to forge into new, unexplored locations.  While you're pushing away vegetation and slapping at plant-life, you spot a half-overgrown orifice buried in the side of a ravine.  There's a large number of imp-tracks around the cavern's darkened entryway.  Perhaps this is where the imp, Zetaz, makes his lair?  In any event, it's past time you checked back on the portal.  You make a mental note of the cave's location so that you can return when you're ready.");
		output("\n\n<b>You've discovered the location of Zetaz's lair! You can visit anytime from the dungeons menu in Places tab.</b>");
		flags["COC.ZETAZ_CAVE_FOUND"] = 1
	
		clearMenu();
		addButton(0, "Enter", move, "COC_ZETAZ_ENTRACE");
		addButton(1, "Leave", ZetazCaveGetOut);
	}
	else 
	{
		output("You make your way back to the cave entrance.\n\n");
		clearMenu();
		addButton(0, "Next", move, "COC_ZETAZ_ENTRACE");
	}
}

private function ZetazCaveGetOut():void {
	clearOutput();
	clearMenu();
	output("You leave the cave behind and take off through the deepwoods back towards camp.");
	processTime(15 + rand(5));
	addButton(0, "Next", move, "COC_CAMP");
}

//ROOMS
public function ZetazCaveEntrace():Boolean {
	output("The entrance to this cave is far bigger than the cave itself.  It looks to be a totally natural formation.  Outside, to the south, is a veritable jungle of plant-life.  There are massive trees, vines, and ferns everywhere.  The cave grows narrower the further north you go, until it's little more than a claustrophobic tunnel burrowing deep into the earth.");
	
	//Zetaz gone?  Alchemist shits!
	if(flags["COC.DEFEATED_ZETAZ"] != undefined) {
		if(flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] == undefined) {
			output("\n\nThere's a demon lazing around outside the cave entrance.  Judging by his size and apparent gender, he must be an incubus.  You try to stay hidden for now, but all he's doing is throwing darts at a dartboard he's set up across the way from himself.  What kind of demon sits around playing darts?");
			addButton(0, "Investigate",  ZetazCaveInvestigateIncubus);
		}
		else if(flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] > 0) {
			output("\n\nThe incubus known as Sean has set up a small stall around the cave entrance, and is busy tending to his shelves and wares.  He's dressed in an incredibly modest, three-piece suit, and nods to you as you approach, \"<i>Let me know if you want to buy anything.  I haven't done much with the cave, so feel free to poke around if you missed anything on your first pass.  I barely use the first room.</i>\"");
			addButton(0, "Sean", ZetazCaveIncubusShop);
		}
	}
	
	addButton(7, "Leave", ZetazCaveGetOut);
	return false;
}

public function ZetazCaveTunnel():Boolean {
	output("This cave tunnel slants downwards to the north, and upwards to the south.  You can see sunlight and feel a fresh breeze from the latter direction, though the walls and air around you are damp with moisture.  You realize that the floor of this cave is fairly smooth and even, as if some attempt had been made to level it out.  You can see a bricked up wall along the north end of the tunnel.  It has a crudely fashioned wooden door in the center of it.");

	return false;
}

public function ZetazCaveGatheringHall():Boolean {
	output("This room is clearly some kind of dining or gathering hall.  The chamber's shape has been hewn from the surrounding stone, and judging by the visible tool-marks, it wasn't done with a great deal of care.  Two long wooden tables fill out the room.  They're surprisingly well made, though it appears that part of their legs were hacked off with axes to lower their overall height.  You can't help but wonder where they were stolen from.  The tables haven't been cleaned in ages, as evidenced by their many stains and a number of half-rotten bones that still rest on their battered surfaces.  Two rows of crudely crafted chairs flank their better-made brethren, made to accommodate very short beings.");
	
	if(flags["COC.ZETAZ_IMP_HORDE_DEFEATED"] == undefined) { //[Imp Mob Fight]
		output("\n\nThe place is swarming with two dozen imps, and none of them look happy to see you.  A number of them take flight while the rest form a ring around you, trapping you!  It looks like you'll have to fight your way out!");
		
		fightImpHorde();
		return true;
	}
	
	return false;
}

public function ZetazCaveFungusCavern():Boolean {
	output("This cavern is huge!  Though you can see the edge of a large stalactite to the west, the rest of the cave disappears into darkness beyond twenty or thirty feet away.  The floor is covered in spongy, leaf-shaped fungus.  They're huge, shiny, and purple, and they cover the cavern floor for as far as the illumination will reach.  ");
	
	if(flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] == undefined) {
		output("A strange, sweet smell hangs in the cavern's humid air, probably coming from the copious fungal flora.  At the edge of your vision you can see a humanoid skeleton propped up against a stalagmite.  There's a rapier laying a few feet in front of it, and it still looks as good as new.  What do you do?");
	}
	//Fungus creature dealt with!
	else {
		output("The familiar, sweet smell of them hangs in the cavern's humid air, but you're fairly certain they won't trouble you again.");
	}

	//Had to place the button.
	if (flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] == undefined) {
		addButton(0, "Get Sword", EncapsulationPodGetSwordAndGetTrapped);
	}
	
	return false;
}

public function ZetazCaveTortureRoom():Boolean {
	output("You step into a dank room, outfitted somewhere between a prison cell and a torture chamber. The ceiling of the sulfur-lined room is hung with an inventive variety of shackles, chains, and devices whose intent are not clear to you. Against the north wall, there appears to be an alchemy lab, laden with a dizzying collection of vials, flasks, and beakers. Against the south, there is a long, sinister-looking wooden rack bearing a sequence of progressively larger and thicker devices, carved to resemble monstrous cocks.\n\n");

	//Vala here?
	if(flags["COC.FREED_VALA"] != 1) {
		//spriteSelect(85);
		//Not yet defeated zetaz
		if(flags["COC.DEFEATED_ZETAZ"] != 1) {
			//Intro:
			output("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n");
			output("It isn't until you get closer that you notice the large, dragon-fly wings attached to her back and the ephemeral glow of sunlight faintly radiating from her pale skin. If the girl wasn't almost 4' tall, you'd swear she was a fairy, like the ones you've met in the forest. If the cum-clogged drain in the center of the room is any indication, the imps must be using her for their perverted desires. You begin to get an appreciation for what she's endured when you get near enough to see the small, black marks staining her luminance. On her right shoulder blade, the imps have tattooed \"pussy\" and on the left, \"ass.\" All along her back, the imps have tattooed two columns of hash marks, from her shoulders all the way down her ribs, over her ass, down her legs, and even onto the soles of her feet.\n\n");
			output("You step around her and are startled to see that while the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat. If she weren't chained to the ceiling, you suspect she wouldn't even be able to stand under her own power. Her eyes are open, but she's staring blankly ahead, unaware of the world around her, pupils constricted to pinpricks amid the ocean of her dulled pink irises. Like this, she's no threat to anybody. You suppose you could let her go, though it's unclear if she's self-aware enough to even move. Alternately, you could blow off a little steam.\n\n");
			//[Free] [Use] [Leave]
			
			addDisabledButton(0, "Free", "Free", "You have no use for this slut now, you have no genitals!");
			if (pc.hasGenitals()) {
				addButton(0, "Free", freeValazLooseCoochie)
			}
			//if (pc.lust >= 33 && shouldraFollower.followerShouldra()) {
				//addButton(1, "ShouldraVala", shouldraFollower.shouldraMeetsCorruptVala);
			//}
		}
		//Zetaz defeated 
		else {
			output("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n");
			//Option to investigate her
			addButton(0, "Faerie", leftValaAlone);
		}
	}
	//Not here
	else output("In the far corner, there are a set of empty manacles, originally set up to contain Vala, who you've long since freed.\n\n");
	
	flags["COC.ZETAZ_DOOR_USED_PASSAGE"] = undefined;
	
	return false;
}

public function ZetazCaveSecretPassage():Boolean {
	output("This passage is the least livable area that you've seen out of the entire cave.  The walls and floor are little more than dirt and rocks, and explosions of dust burst from the ceiling with each tentative movement you make.  For a moment, a wave of claustrophobia threatens to rob you of your nerve, but you blink the pervasive particles from your eyes and focus on why you're here.  ");
	//If zetaz not yet defeated
	if(flags["COC.DEFEATED_ZETAZ"] == undefined) output("You're going to find Zetaz and pay him back for drugging you on your first day here.  ");
	output("A crude door on the southern edge of the tunnel leads back to the imp's sleeping chambers, but the tunnel continues away, curving sharply to the west where a far more lavish door marks the far side of the subterranean passage.");
	
	//(Item: sexy bondage straps/a set of sexy bondage straps/B.Straps? - Seduce ability?)
	//(Possible effect: +lust every round in combat if afflicted with Ceraph's bondage!)

	if(flags["COC.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS"] == undefined) {
		output("\n\nA set of fetishy, discarded straps lies on the floor, half obscured by dust.  It looks like something a goblin would wear.  Sexy!");
		addButton(0, "B.Straps", ZetazCaveBondageStraps)
	}
	flags["COC.ZETAZ_DOOR_USED_PASSAGE"] = 1;
	
	return false;
}

private function ZetazCaveBondageStraps():void {
	clearOutput();
	clearMenu();
	flags["COC.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS"] = 1;
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCBondageStraps()]);
}

public function ZetazCaveZetazChamber():Boolean {
	if (flags["COC.ZETAZ_DOOR_UNLOCKED"] == undefined && flags["COC.ZETAZ_DOOR_USED_PASSAGE"] == undefined) 
	{
		clearOutput();
		clearMenu();
		output("The door is locked from the other side.");
		addButton(0, "Next", move, rooms[currentLocation].southExit);
		return true;
	}
	
	output("You've stepped into the most lavish room in the entire cave system, and marvel at the difference between this magnificent abode and your own crudely constructed campsite.  The stone walls are covered in stolen tapestries that each look to have been liberated from a unique source.  Judging by the variety of depictions and art styles in this one room, you've barely met a fraction of the races that once inhabited the lands of Mareth.  A pair of bright, smokeless lanterns hang from each wall, lit from within by obviously magical spheres of luminescence.  Various pieces of stolen furniture decorate the room, surrounding a four-post bed decorated with masterfully done carvings of various carnal acts.");
	
	if(flags["COC.ZETAZ_DOOR_UNLOCKED"] == undefined) {
		output("  <b>There's a bolt holding a door to the south closed, but you give it a gentle tug and it comes unlocked.</b>");
		flags["COC.ZETAZ_DOOR_UNLOCKED"] = 1;
	}
	output("\n\n");
	
	if(flags["COC.DEFEATED_ZETAZ"] == undefined) {
		output("A familiar imp is looking at you with a bewildered expression painted across his face.  You recognize his face immediately – this is Zetaz!  Oddly, he seems to have grown much larger in the time since your previous meeting.  He's over four feet tall and much more solidly built!\n\n");
		output("Zetaz whines, \"<i>Seriously?  You show up here!?  First you make me lose my job, and now you beat up my friends and track dirt in my bedroom!?  I've had enough!</i>\"");
		
		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCZetaz());
		CombatManager.victoryScene(ZetazCaveDefeatZetaz);
		CombatManager.lossScene(ZetazCaveLoseToZetaz);
		CombatManager.displayLocation("ZETAZ");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	
	return false;
}

public function ZetazCaveCleared():Boolean {
	return flags["COC.DEFEATED_ZETAZ"] != undefined
		&& flags["COC.FREED_VALA"] != undefined
		&& flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] != undefined;
}

public function ZetazCaveUpdateNotify():void {
	if(flags["COC.DEFEATED_ZETAZ"] != undefined)
	{
		rooms["COC_ZETAZ_ENTRACE"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_ZETAZ_TUNNEL"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_ZETAZ_GATHERING_HALL"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_ZETAZ_TORTURE_ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_ZETAZ_SECRET_PASSAGE"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_ZETAZ_CHAMBER"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
	}
	
	rooms["COC_ZETAZ_GATHERING_HALL"].removeFlags(GLOBAL.OBJECTIVE);
	rooms["COC_ZETAZ_CHAMBER"].removeFlags(GLOBAL.OBJECTIVE);
	if (flags["COC.ZETAZ_IMP_HORDE_DEFEATED"] == undefined) rooms["COC_ZETAZ_GATHERING_HALL"].addFlag(GLOBAL.OBJECTIVE);
	else if (flags["COC.DEFEATED_ZETAZ"] == undefined) rooms["COC_ZETAZ_CHAMBER"].addFlag(GLOBAL.OBJECTIVE);
	
	rooms["COC_ZETAZ_ENTRACE"].removeFlags(GLOBAL.NPC, GLOBAL.COMMERCE);
	if (flags["COC.DEFEATED_ZETAZ"] != undefined) {
		if (flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] == undefined) rooms["COC_ZETAZ_ENTRACE"].addFlag(GLOBAL.NPC);
		else if (flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] == 1) rooms["COC_ZETAZ_ENTRACE"].addFlag(GLOBAL.COMMERCE);
	}
	
	if (flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] == undefined) rooms["COC_ZETAZ_FUNGUS_CAVERN"].addFlag(GLOBAL.PLANT_BULB);
	else {
		rooms["COC_ZETAZ_FUNGUS_CAVERN"].removeFlags(GLOBAL.PLANT_BULB, GLOBAL.HAZARD);
	}
	
	rooms["COC_ZETAZ_TORTURE_ROOM"].removeFlags(GLOBAL.NPC);
	if (flags["COC.FREED_VALA"] != 1) rooms["COC_ZETAZ_TORTURE_ROOM"].addFlag(GLOBAL.NPC);
	
}
private var ZetazCaveUpdateNotifyHook: * = ZetazCaveUpdateNotifyGrapple();
private function ZetazCaveUpdateNotifyGrapple():* { variableRoomUpdateListeners.push(ZetazCaveUpdateNotify); }