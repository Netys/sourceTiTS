import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;


public function findSwordInStone():void 
{
	clearOutput();
	clearMenu();
	if (flags["COC.FACTORY_SHUTDOWN"] != 2)
	{
		//Encounter it!
		output("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [pc.mainWeapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a sword lodged hilt-deep in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
		
		//Describe it!
		output("The tree is thick enough to encapsulate the entire blade.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the sword.  The hilt itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this sword must have been here for the tree to grow so thoroughly around it.\n\n");
	
		output("You suppose you could try to pull it free, do you?");
	
		addButton(0, "Yes", tryToTakeSwordInStone);
		addButton(1, "Leave", returnToCampUseOneHour);
	}
	else 
	{
		output("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken sword scattered around the trunk, completely covered in rust.");
		
		flags["COC.SWORD_IN_A_STONE"] = 2;
		processTime(10);
		addButton(0, "Next", mainGameMenu);
	}
}

private function tryToTakeSwordInStone():void 
{
	clearOutput();
	//if corrupted...
	if (pc.cor() >= 25) 
	{
		output("You grip the handle with both hands and ");
		
		if (pc.PQ() > 70) output("pull mightily, making the tree strain and groan from the force, ");
		if (pc.PQ() <= 70 && pc.PQ() >= 40) output("pull hard, feeling your muscles tighten from the strain, ");
		if (pc.PQ() < 40) output("pull as hard as you can, ");
		
		output("but the sword remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
		
		processTime(10);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
	//If not corrupted...
	else 
	{
		output("You grip the handle with both hands and ");
	
		if (pc.PQ() > 70) output("pull so hard you fall on your ass when the sword slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
		if (pc.PQ() <= 70 && pc.PQ() >= 40) output("give a mighty pull and nearly fall over as the sword easily slides free from the tree.  ");
		if (pc.PQ() < 40) output("easily pull the sword free, surprising yourself with how easy it was to remove.  ");
		
		output("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
	
		output("The blade itself is three and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful blade.\n\n");

		flags["COC.SWORD_IN_A_STONE"] = 1;
		pc.libido( -(pc.libido() / 3));
		pc.lust( -15);
		processTime(10);
		
		itemScreen = mainGameMenu;
		lootScreen = mainGameMenu;
		useItemFunction = mainGameMenu;
		itemCollect([new CoCBeautifulSword()]);
	}
}