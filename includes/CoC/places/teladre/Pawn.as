import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function oswaldPawn():void {
	//spriteSelect(47);
	clearOutput();
	clearMenu()
	userInterface.showName("\nOSWALD");
	if(flags["COC.MET_OSWALD"] == undefined) {
		output("Upon closer inspection, you realize the pawnbroker appears to be some kind of golden retriever.  He doesn't look entirely comfortable and he slouches, but he manages to smile the entire time.  His appearance is otherwise immaculate, including his classy suit-jacket and tie, though he doesn't appear to be wearing any pants.  Surprisingly, his man-bits are retracted.  ");
		if(pc.cor() < 75) output("Who would've thought that seeing someone NOT aroused would ever shock you?");
		else output("What a shame, but maybe you can give him a reason to stand up straight?");
		output("  His stand is a disheveled mess, in stark contrast to its well-groomed owner.  He doesn't appear to be selling anything at all right now.\n\n");
		output("The dog introduces himself as Oswald and gives his pitch, \"<i>Do you have anything you'd be interested in selling?  The name's Oswald, and I'm the best trader in Tel'Adre.</i>\"\n\n");
		output("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.)");
		flags["COC.MET_OSWALD"] = 1;
	}
	else {
		output("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + pc.mf("sir","dear") + "?</i>\"\n\n");
		output("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.  You can shift-click to sell all items in a selected stack.)");
	}
	oswaldPawnMenu();
	
	if(!pc.hasKeyItem("Carrot") && flags["COC.NIEVE_STAGE"] == 3)
	{
		output("\n\nIn passing, you mention that you're looking for a carrot.\n\nOswald's tophat tips precariously as his ears perk up, and he gladly announces, \"<i>I happen to have come across one recently - something of a rarity in these dark times, you see.  I could let it go for 50 gems, if you're interested.</i>\"");
		if (pc.credits < 500) {
			output("\n\n<b>You can't afford that!</b>");
			addDisabledButton(4, "BuyCarrot", "Buy Carrot", "You can't afford it!");
		}
		else {
			addButton(4, "BuyCarrot", buyCarrotFromOswald);
		}
	}
}

private function buyCarrotFromOswald():void {
	pc.credits -= 500;
	clearOutput();
	clearMenu();
	output("Gems change hands in a flash, and you're now the proud owner of a bright orange carrot!\n\n(<b>Acquired Key Item: Carrot</b>)");
	pc.createKeyItem("Carrot");
	addButton(0, "Next", oswaldPawn);
}

private function oswaldPawnMenu():void { //Moved here from Inventory.as
	//spriteSelect(47);	
	addButton(0, "Sell", oswaldPawnSell);
	if (pc.inventory.length == 0) addDisabledButton(0, "Sell", "Sell", "You have nothing to sell.");
	//switch (flags["COC.KATHERINE_UNLOCKED"]) {
		//case 1:
		//case 2: addButton(1, "Kath's Alley", visitKatherine); break;
		//case 3: addButton(1, "Safehouse", katherineTrainingWithUrta); break;
		//case 4: addButton(1, "Kath's Alley", postTrainingAlleyDescription); //Appears until Kath gives you her housekeys
		//default:
	//}
	addButton(14, "Back", telAdreMenu);
}

private function oswaldPawnSell():void {
	//spriteSelect(47);
	shopkeep = new CoCTrader();
	shopkeep.short = "Oswald";
	shopkeep.sellMarkup = 1;
	shopkeep.buyMarkdown = .5;
	shopkeep.typesBought = [GLOBAL.ALL];
	shopkeep.keeperSell = "I can buy anything of value!";
	shopkeepBackFunctor = oswaldPawn;
	sellItem();
}