import classes.Characters.CoC.CoCBasilisk;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCEggs.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "DopplegangerScenes.as";
include "DriderIncubusScenes.as";
include "HermCentaurScenes.as";
include "IncubusMechanicScenes.as";
include "JeanClaudeScenes.as";
include "LethiceScenes.as";
include "LivingStatueScenes.as";
include "MinotaurKingScenes.as";
include "SuccubusGardenerScenes.as";

public function discoverD3():Boolean
{
	if (Flag("COC.D3_DISCOVERED") == 0 && pc.hasKeyItem("Zetaz's Map") && rand(5) == 0)
	{
		Flag("COC.D3_DISCOVERED", 1);
		
		clearOutput();
		output("During your exploration, you come across a familiar looking patch of ground. In fact... you pull out Zetaz’s map, your eyes widening as they realize what you’ve just found: Lethice’s Keep. You follow a concealed trail past several harpy nests directly to an almost invisible cave entrance. You never would’ve found it without the map.");
		output("\n\n<b>You’ve discovered a hidden entrance to Lethice’s lair. It can be accessed from the Dungeons submenu in the future.</b>");
		output("\n\nDo you step inside, or wait until you’re better prepared?");
		
		clearMenu();
		addButton(0, "Enter", move, "COC FORTRESS ENTRACE");
		addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		
		return true;
	}
	return false;
}

public function TravelToLethiceFortress():void {
	processTime(15 + rand(5));
	move("COC FORTRESS ENTRACE"); 
}

public function TravelFromLethiceFortress():void {
	processTime(15 + rand(5));
	move("COC_CAMP"); 
}

private function LethiceFortressEntranceRoomFunc():Boolean
{
	addButton(7, "Leave", TravelFromLethiceFortress);
	return false;
}

private function LethiceFortressMirrorsRoomFunc():Boolean
{
	output("The metal door opens soundlessly onto a fairly large, unlit room, shabby and grey with disuse. It is cluttered with a great quantity of mirrors. Round hand mirrors are stacked on shelves, square wall mirrors are leant against walls, a large,"); 
	if (Flag("COC.D3_MIRRORS_SHATTERED") == 1) outputText(" now shattered,");
	output(" ornate standing mirror dominates the center of the room, and a number of broken, jagged specimens are stacked near the back. They reflect the dull trappings of this place back at you emptily. You guess as self-centred a race as the demons probably has quite a large use for these.");
	
	if (pc.hasKeyItem("Laybans"))
	{
		output("\n\nThe place feels hollow and creepy, even after the ad hoc exorcism you performed here. There is no reason to linger.");
	}
	else
	{
		output("\n\nNear the back, next to the broken stack is a white stand, displaying what appear to be a number of dark shades.");
		if (Flag("COC.D3_ENTERED_MAGPIEHALL") == 1) output("  Your spirits rise. They look like they may very well be made of the same material as the screen in the basilisk hall.");
		if (pc.intelligence() >= 35 || pc.aim() >= 35) output("  Disquiet edges down your spine. Something about this place doesn’t feel right. The room seems faded at the corners, as if it’s not quite there.");
		
		addButton(0, "Glasses", getDemGlasses);
	}
	
	return false;
}

private function LethiceFortressMagpieHallSRoomFunc():Boolean
{
	if (Flag("COC.D3_JEAN_CLAUDE_DEFEATED") == 0)
	{
		if (Flag("COC.D3_ENTERED_MAGPIEHALL") == 0)
		{
			Flag("COC.D3_ENTERED_MAGPIEHALL", 1);
			output("You creep through the archway. The sound of movement and bustle is closer here; it seems to be coming from directly below you. Ahead is the screen, a large window made from tinted glass. Cautiously you peer through it. You have entered a vast hall, near the very top of it; this seems to be some sort of observation booth set high in the stone wall. It’s designed in the grand, classical tradition, fluted balustrades flanking the walls, each decorated at the top by a carved magpie in flight. Below is - well. You blink, trying to take it all in.");

			output("\n\nMany feet below the hall swarms with activity: tall, thin, grey-green reptiles sliding sinuously around each other and the long tables that run the length of the room. There must be hundreds, no, at least a thousand basilisks down there, carrying, analyzing, sorting the vast amount of junk the tables are heaped with.");
			if (Flag("COC.BENOIT_AFFECTION") == 100) output("  This can only be the hall that " + benoitMF("Benoit", "Benoite") + " once worked in."); 
			output("  You get the fright of your life when you think you see a number of depthless pools of grey revolve up to meet yours- but they don’t freeze you, you note as you reflexively turn away. The tinted glass must carry some sort of anti-petrifying charm, and further it must be reflective on the other side, because no one below seems to realize you’re standing there. Relaxing a bit, you continue to absorb the massive room. At the end furthest away from you two huge piles have been created- one of eggs, a massed assortment of every color and size imaginable, and one of pure junk, presumably everything the basilisks have found whilst scavenging and considered worth keeping. The detritus of a dozen collapsed civilizations must be down there, collected for the demons’ perusal by their scaly custodians. Directly below you, you can see archways like the one you just passed under, through which the basilisks ebb and flow.");

			output("\n\nYour heartbeat quickens as you consider. There is a grid gantry running from where you are right around the room to the other side, where you can see a matching observation booth, presumably containing another exit. But it’s quite a distance, there are stairs leading down to the ground level, and outside the protective glass you would surely be spotted and apprehended");
			if (pc.canFly()) output(", even if you tried to fly it"); 
			output(". Wouldn’t you? You can’t outrun the gaze of a thousand basilisks... could you?"); 
			if (pc.hasKeyItem("Laybans")) output("  You take the Laybans out of your pouch and hold them up against the glass. It’s exactly as you hoped - they are made of the same material, and are almost certainly what the demons wear when they themselves interact with the basilisks. They would surely help you get across the hall, if you were crazy enough to try.");
		}
		else
		{
			output("Again you creep up to the tinted glass, again you take in the vast hall with the army of basilisks below hard at work, and again you stare out at the metal gantry, with the exit tantalizingly visible on the other side."); 
			if (!pc.hasKeyItem("Laybans")) output("  Are you going to try this?");
			else output("  You take the Laybans out of your pocket, turning them around in your hands as you consider. Are you going to try this?");
		}
		
		clearMenu();
		addButton(0, "Go!", gogoFuckTheseBasilisks);
		addButton(1, "Fall Back", fallbackFromMagpieHallS);
		if(CoCBasilisk.canLookIntoEyes(false)) addButton(2, "Attack!", challengeBasilisksGo);
			
		return true;
	}
	
	output("You are back in the southern end of the Magpie Hall.  Without the bustle of activity below it is a gapingly empty and quiet place, the only sound the murmur of activity from elsewhere. There is a vast amount of collected junk below but it would take, well, an army of basilisks to sort through it to find anything worthwhile. You could check out the massive pile of eggs, though.");
	
	if (eggsAvailable() > 0)
	{
		addButton(0, "Eggs", goToEggPile);
	}
	
	return false;
}

public static const BLACK:int = 1 << 0;
public static const BLUE:int = 1 << 1;
public static const WHITE:int = 1 << 2;
public static const PINK:int = 1 << 3;
public static const BROWN:int = 1 << 4;
public static const PURPLE:int = 1 << 5;

private function eggsAvailable():int
{
	if (flags["COC.D3_EGGS_AVAILABLE"] == undefined) flags["COC.D3_EGGS_AVAILABLE"] = 0;
	var flagNum:int = flags["COC.D3_EGGS_AVAILABLE"];
	
	var eggs:int = 0;
	
	if (!(flagNum & BLACK)) eggs++;
	if (!(flagNum & BLUE)) eggs++;
	if (!(flagNum & WHITE)) eggs++;
	if (!(flagNum & PINK)) eggs++;
	if (!(flagNum & BROWN)) eggs++;
	if (!(flagNum & PURPLE)) eggs++;
	
	return eggs;
}

private function goToEggPile():void
{
	clearOutput();
	output("You head down the stairs into the hall proper to inspect the ramble hoard of eggs the basilisks collected. They’re mostly unfertilised harpy ovum, but you quickly pick out a number of differently coloured transformative eggs stolen from Gods know who.");
	if (flags["COC.D3_EGGS_AVAILABLE"] == undefined) flags["COC.D3_EGGS_AVAILABLE"] = 0;
	
	clearMenu();
	
	var flagNum:int = flags["COC.D3_EGGS_AVAILABLE"];
	
	if (!(flagNum & BLACK)) addButton(0, "Black", takeEgg, BLACK);
	if (!(flagNum & BLUE)) addButton(1, "Blue", takeEgg, BLUE);
	if (!(flagNum & WHITE)) addButton(2, "White", takeEgg, WHITE);
	if (!(flagNum & PINK)) addButton(3, "Pink", takeEgg, PINK);
	if (!(flagNum & BROWN)) addButton(4, "Brown", takeEgg, BROWN);
	if (!(flagNum & PURPLE)) addButton(5, "Purple", takeEgg, PURPLE);
	
	addButton(14, "Back", mainGameMenu);
}

private function takeEgg(eggMask:int):void
{
	var item:ItemSlotClass;
	
	if (eggMask == BLACK) item = new CoCBlackEggLarge();
	if (eggMask == BLUE) item = new CoCBlueEggLarge();
	if (eggMask == WHITE) item = new CoCWhiteEggLarge();
	if (eggMask == PINK) item = new CoCPinkEggLarge();
	if (eggMask == BROWN) item = new CoCBrownEggLarge();
	if (eggMask == PURPLE) item = new CoCPurpleEggLarge();
	
	//menuLoc = 9999;
	// Should actually be handled by the fallthrough of doNext(1) in the takeItem shit
	
	clearOutput();
	output("You pluck out " + item.longName + " ");
	
	flags["COC.D3_EGGS_AVAILABLE"] += eggMask;
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([item]);
}

private function fallbackFromMagpieHallS():void
{
	clearOutput();
	output("No, there has to be a better way.");
	if (!pc.hasKeyItem("Laybans") && pc.intelligence() >= 30) output("  Surely the demons themselves are not immune to the basilisks’ glares - the darkened screen is proof of that. How do they interact with the creatures, then? Maybe if you keep poking around, you might find an answer.");
	output("\n\nYou head back through the archway into the gloomy antechamber.");
	
	clearMenu();
	addButton(1, "Next", move, "COC FORTRESS ANTECHAMBER");
}

private function LethiceFortressMagpieHallNRoomFunc():Boolean
{
	if (Flag("COC.D3_JEAN_CLAUDE_DEFEATED") == 0)
	{
		output("You find yourself back in the small booth, with the locked door leading out into the Magpie Hall. Just like the one on the opposite side, there is a darkened screen here through which you can see hundreds of basilisks milling down below, sorting through the vast amount of junk and eggs they have collected from the mountainside. They don’t seem to have taken any extra precautions following your narrow escape of them- the gantry remains free of any guards, and the door on the other side looks open.");
		
		clearMenu();
		
		addButton(0, "Go!", gogoFuckTheseBasilisksNorth);
		addButton(1, "Stronghold", move, "COC FORTRESS TUNNEL 2");
		if(CoCBasilisk.canLookIntoEyes(false)) addButton(2, "Attack!", challengeBasilisksGo);
		
		return true;
	}
	
	output("You are back in the northern end of the Magpie Hall. Without the bustle of activity below it is a gapingly empty and quiet place, the only sound the murmur of activity from elsewhere. There is a vast amount of collected junk below but it would take, well, an army of basilisks to sort through it to find anything worthwhile. You could check out the massive pile of eggs, though.");
	
	if (eggsAvailable() > 0)
	{
		addButton(0, "Eggs", goToEggPile);
	}
	
	return false;
}

private function LethiceFortressSouthWestWalkRoomFunc():Boolean
{
	output("The bushes surrounding the path have given way here to a mass of tentacles, some still bedecked in the flowers that surround the air. They twist and writhe but seem content to stay in their place for now. Besides, if you hang back along the edge of the walk, you should be out of their reach. The path heads north and south... if the wall of oily-looking tendrils leaves you alone.");
	
	if (Flag("COC.D3_GARDENER_DEFEATED") == 0)
	{
		output("\n\nThe slick foilage parts just ahead, revealing a lissom leg clad in green hosiery that resembles the spiderwork patterns of leafy veins more than any garment. Its owner follows but a moment later, so perfectly, wonderfully shapely that you freeze in place, compelled by biology to take notice. Her expansive bosom, womanly hips, and gentle, soft curves invite you to fall into her embrace. Her lips, full and pouting, beckon for you to taste them. Her hair's lustrous shine glitters like an angler fish's lure, just out of reach and oh so foolish to pursue. The smooth, twists of her ram-like horns keep her coiffure stylish while simultaneously jolting you out of your reverie.");
		
		output("\n\nYou shake your head to regain your focus. This is a demon, and you won't fall for her tricks this easily");
		
		if (pc.lustQ() <= 75) // I'm not sure what this variation was supposed to point at specifically.
		{
			output("!");
		}
		else
		{
			output(".... You grope yourself absentmindedly as you consider just how long you'll hold out before submitting. It won't be long.");
		}

		output("\n\n<i>\"Why hello there,\"</i> the corrupt temptress says with a tone that's the auditory equivalent to a pat on the head. <i>\"You must be [name]. Did you come all this way just to join my garden?\"</i> The corner of the succubus' mouth curls ever so slightly, her lips gleaming invitingly. <i>\"Or perhaps you could be my first non-floral pet. Would you like that?\"</i> She arches her back to present her breasts to you, held aloft by their own incredible, perfect shape and framed by a skimpy underbust covering that only serves to highlight her hard, perky nipples. They gleam with moisture - milk you suppose.");
		
		output("\n\nShe smiles encouragingly. <i>\"What'll it be?\"</i>");
		
		//[Surrender] [Fight]
		clearMenu();
		addButton(0, "Fight", fightTheGardener);
		addButton(1, "Surrender", surrenderToTheGardener);

		return true;
	}
	
	return false;
}

private function LethiceFortressWestWalkRoomFunc():Boolean
{
	output("Pollen clings to you, released by the many flowering bushes in the area. They only grow thicker to the south, too. To the east, you can");
	if (Flag("COC.D3_STATUE_DEFEATED") == 0) output(" see a massive statue with an immense hammer");
	else output(" a mound of rubble, the scattered remains of the animated statue that you slew");
	output(". The warm, sandstone bricks underfoot fork in a T-intersection, leading north, east, and south. The thick castle walls prevent passage to the west.");
	
	return false;
}

private function LethiceFortressNorthCourtyardRoomFunc():Boolean
{
	output("You stand before what can only be the entrance to Lethice’s throne room. It is unlabelled, but the immense door is unlike any you’ve seen in this world or the last. Constructed from some kind of pink-tinged metal and polished to a mirror sheen, this portal has had a lifetime of care poured into it. What’s more, intricate locking mechanisms overlap the edges of it, each one culminating in an intricately worked seal. Fortunately, each of the seals has been left over. Security must not be much of a concern for the demon queen at this point in time. ") 
	if (Flag("COC.D3_GARDENER_DEFEATED") > 0 && Flag("COC.D3_CENTAUR_DEFEATED") > 0 && Flag("COC.D3_STATUE_DEFEATED") > 0) {
		output("The seal appears to be broken. You could move north and attempt to defeat Lethice for once and for all. Or you can move east and west through the courtyard, if you like.");
	}
	else {
		output("If only the door would open. For some reason, it’s still sealed closed. You can still move east and west through the courtyard, if you like.");
	}
	return false;
}

private function LethiceFortressNorthEastCourtyardRoomFunc():Boolean
{
	output("This particular corner of the courtyard feels remarkably cramped, even a little claustrophobic. To the north, a stone wall rises, dwarfing the smaller one to the east, and to make matters worse, the hedges to the southwest are high and square, virtually a wall in their own right. The only avenues of travel available are to the south or west, following the red sandstone bricks as they bend around the corner.");
	
	if (Flag("COC.D3_CENTAUR_DEFEATED") == 0)
	{
		encounterThePony();
		return true;
	}
	
	return false;
}

private function LethiceFortressEastWalkRoomFunc():Boolean
{
	output("The smooth, almost flawlessly laid stones split into a T-intersection here, heading north, south, and west. The bushes that hem in the paths are likewise split, though they have been maintained with the same sense of care you’ve seen elsewhere in the garden. One particularly interesting shrub has been trimmed into the shape of a large bust, complete with erect nipples. You shake your head and glance west, where you can spot");
	if (Flag("COC.D3_STATUE_DEFEATED") == 0) output(" a massive statue with an immense hammer.");
	else output(" a mound of rubble, the scattered remains of the animated statue that you slew.");
	return false;
}

// 9999 - Check this
private function LethiceFortressCourtyardSquareRoomFunc():Boolean
{
	//Statue not exploded - mossy - 30’ high
	output("A circle of polished stone wraps around a colossus here in the center of the courtyard, ringed by cushioned benches that would be a delight to sit on were they not stained with bodily fluids of all colors and sexes. You didn’t think pink cum was possible, but the demons’ endless sexual creativity doesn’t seem to be bound by such notions. You can leave east and west from here.");

	if (Flag("COC.D3_STATUE_DEFEATED") == 0)
	{
		output("\n\nWait... what’s that?");

		clearMenu();
		addButton(0, "Next", livingStatueEncounter);
		return true;
	}

	output("Two disembodied, marble feet and a field of rubble are all that remains of the once proud statue that stood in the center of the courtyard. You dealt with the animated monstrosity but can’t help but feel a little shame at the destruction you’ve so openly wrought. Many of the bushes are torn in half by two ton slabs, and the path is scarred in a dozen places by chips and smashed divots. You can go east and west from here, if you move carefully around the more jagged pieces of stone.");
	
	return false;
}

private function LethiceFortressGreatLiftRoomFunc():Boolean
{
	output("Intricate stonework supports this precarious platform as it juts from the side of Lethice's fortress, hanging over a sheer cliff that must go down for hundreds of feet. The harpies appear to have moved away from the area immediately below, whether by choice or by demonic action, though you can still spot a few of their nests in other places on the mountainside. A complicated looking machine sits on the side of the platform, attached to a cage that dangles over the edge, supported by a lowly metal cable. It must be some kind of mechanical lift - a way to come and go as one would please.");
	
	incubusMechanicMeetAtElevator();
	
	return false;
}

private function LethiceFortressThroneRoomFunc():Boolean 
{
	if (!(Flag("COC.D3_GARDENER_DEFEATED") > 0 && Flag("COC.D3_CENTAUR_DEFEATED") > 0 && Flag("COC.D3_STATUE_DEFEATED") > 0)) {
		output("If only the door would open. For some reason, it’s still sealed closed. You can still move east and west through the courtyard, if you like.");
		addButton(1, "Next", move, "COC FORTRESS NORTH COURTYARD");
		return true;
	}
	
	if (Flag("COC.DRIDERINCUBUS_DEFEATED") == 0) {
		encounterDriderIncbutt();
		return true;
	}
	if (Flag("COC.MINOTAURKING_DEFEATED") == 0) {
		encounterMinotaurKing();
		return true;
	}
	if (Flag("COC.LETHICE_DEFEATED") == 0) {
		encounterLethice();
		return true;
	}
	
	output("The throne room is intricately designed. Purple carpet with red highlights line the floor from the door to the throne. The throne appears to be carved in marble and dotted with lethicite. Along the way, there are beautifully carved marble columns and cum fountains. You blush just by looking at the fountains. ");
	//if (flags[kFLAGS.LETHICITE_ARMOR_TAKEN] <= 0 && player.newGamePlusMod() > 0) {
		//outputText("\n\nThere is still a suit of lethicite armor Lethice worn when you battled her, in good condition. You could take it if you like. ");
		//addButton(0, "Take Armor", lethice.takeLethiciteArmor, null, null, null, armors.LTHCARM.description);
	//}
	
	return false;
}

public function checkLethiceStrongholdClear():Boolean {
	return flags["COC.LETHICE_DEFEATED"] > 0 && flags["COC.D3_JEAN_CLAUDE_DEFEATED"] > 0;
}