import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function exploreBog():void {
	if (helSexualAmbush()) return;
	
	showName("\nBOG");
	IncrementFlag("COC.EXPLORED_BOG");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	var choice:Array = [];
	var chance:Array = [];
	
	/*  STANDARD SCENE SELECTION  */
	
	choice.push(BogLootExplore);
	chance.push(1);
	
	choice.push(encounterChameleon);
	chance.push(1);
	
	choice.push(findTheFrogGirl);
	chance.push(6);
	
	choice.push(phoukaEncounter);
	chance.push(2);
	
	WeightedRandom(choice, chance, true)();
}

public function BogLootExplore(clearScreen:Boolean = true):void {
	if(clearScreen) clearOutput();
	
	var foundLootItems:/*ItemSlotClass*/Array = new Array();
	
	if(rand(2) == 0) { // 50/50 to find something
		output("You wander around through the bog for a while, but you don't find anything.");
		processTime(20 + rand(10));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	
	output("While exploring, you find an item on the ground!  ");

	processTime(20 + rand(10));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([RandomInCollection(new CoCReducto(), new CoCGroPlus(), new CoCPhoukaWhiskey(), new CoCFuckDraft())]);
}