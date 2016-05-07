import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//-----------------
//-- CARPENTRY SHOP
//-----------------
public function carpentryShopEntry():void {
	output("You enter the shop marked by a sign with hammer and saw symbol painted on it. There are array of tools all hung neatly. A human shopkeeper stands behind the counter. He appears to be wearing typical lumberjack outfit.\n\n", true);
	output("\"<i>Welcome to my hardware shop. Feel free to look around,</i>\" the shopkeeper says. \n\n", false);
	doNext(carpentryShopInside);
}

public function carpentryShopInside():void {
	clearOutput();
	output("<i>So what will it be?</i>", false);
	menu();
	addButton(0, "Toolbox", carpentryShopBuySet);
	addButton(1, "Buy Nails", carpentryShopBuyNails);
	addButton(2, "Buy Wood", carpentryShopBuyWood);
	addButton(3, "Sell Wood", carpentryShopSellWood);
	addButton(14, "Leave", telAdreMenu);
}
//Buy toolbox
public function carpentryShopBuySet():void {
	if (pc.hasKeyItem("Carpenter's Toolbox") >= 0)
	{
		output("<b>You already own a set of carpentry tools!</b>", true)
		doNext(carpentryShopInside);
		return;
	}
	output("You walk around for a while until you see a wooden toolbox. It's filled with assorted tools. One of them is a hammer. Another one is a saw. Even another is an axe. There is a measuring tape. There's even a book with hundreds of pages, all about how to use tools and it even has project instructions! There's also a compartment in the toolbox for nails. Just what you need to build your cabin. \n\n", true);
	output("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
	output("Do you buy it?", false);
	if (pc.gems >= 200)
	{
		doYesNo(carpentryShopBuySetYes, carpentryShopBuySetNo);
	}
	else
	{
		output("\n\nYou count out your gems and realize it's beyond your price range.", false);
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuySetYes():void {
	pc.gems -= 200;
	output("You hand over two hundred gems to the shopkeeper. ", true);
	output("\"<i>Here you go,</i>\" he says. You feel so proud to have your own tools for building stuff! \n\n", false);
	output("<b>Gained Key Item: Carpenter's Toolbox!</b>", false)
	pc.createKeyItem("Carpenter's Toolbox", 0, 0, 0, 0);
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuySetNo():void {
	output("\"<i>No thanks,</i>\" you tell him. \n\n", true);
	output("\"<i>Suit yourself,</i>\" he says as you put the box of tools back where it was.", false);
	doNext(carpentryShopInside);
}	
//Buy nails
public function carpentryShopBuyNails():void {
	if (pc.hasKeyItem("Carpenter's Toolbox") >= 0)
	{
		output("You ask him if he has nails for sale. He replies \"<i>Certainly! I've got nails. Your toolbox can hold up to two hundred nails. I'll be selling nails at a price of two gems per nail.</i>\" \n\n", true);
		if (pc.hasKeyItem("Carpenter's Toolbox") >= 0) output("Nails: " + pc.keyItemv1("Carpenter's Toolbox") + "/200", false)
		else output("Nails: " + 0 + "/200", false)
		addButton(0, "Buy 10", carpentryShopBuyNailsAmount, 10);
		addButton(1, "Buy 25", carpentryShopBuyNailsAmount, 25);
		addButton(2, "Buy 50", carpentryShopBuyNailsAmount, 50);
		addButton(3, "Buy 75", carpentryShopBuyNailsAmount, 75);
		addButton(4, "Buy 100", carpentryShopBuyNailsAmount, 100);
		addButton(14, "Back", carpentryShopInside)
	}
	else
	{
		output("You ask him if he has nails for sale. He replies \"<i>I do. But I'm sorry, my friend. You don't have a toolbox. How are you going to carry nails safely?</i>\" ", true);
		doNext(carpentryShopInside);
	}
}

private function carpentryShopBuyNailsAmount(amount:int):void {
	nails = amount;
	output("You ask him for " + amount + " nails. He replies \"<i>That'll be " + (amount * 2) + " gems, please.</i>\" \n\nDo you buy the nails?", true);
	doYesNo(carpentryShopBuyNailsYes, carpentryShopBuyNails);
}

private function carpentryShopBuyNailsYes():void {
	clearOutput();
	if (pc.gems >= (nails * 2))
	{
		pc.gems -= (nails * 2);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] += nails;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
		pc.addKeyValue("Carpenter's Toolbox", 1, nails);
		output("You hand over " + (nails * 2) + " gems. \"<i>Done,</i>\" he says as he hands over bundle of " + nails +" nails to you.\n\n");
		if (pc.keyItemv1("Carpenter's Toolbox") > 200)
		{
			output("Unfortunately, your toolbox can't hold anymore nails. You notify him and he refunds you the gems.\n\n", false);
			pc.gems += ((pc.keyItemv1("Carpenter's Toolbox") - 200) * 2);
			pc.addKeyValue("Carpenter's Toolbox", 1, -(pc.keyItemv1("Carpenter's Toolbox") - 200));
		}
		output("Nails: " + pc.keyItemv1("Carpenter's Toolbox") + "/200");
	}
	else output("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"", true);
	statScreenRefresh();
	doNext(carpentryShopBuyNails);
}

//Buy wood
public function carpentryShopBuyWood():void {
	output("You ask him if he has wood for sale. He replies \"<i>Certainly! I've got extra supply of wood. I'll be selling wood at a price of 10 gems per wood plank.</i>\" \n\n", true);
	output("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "", false);
	addButton(0, "Buy 10", carpentryShopBuyWoodAmount, 10);
	addButton(1, "Buy 20", carpentryShopBuyWoodAmount, 20);
	addButton(2, "Buy 30", carpentryShopBuyWoodAmount, 30);
	addButton(3, "Buy 40", carpentryShopBuyWoodAmount, 40);
	addButton(4, "Buy 50", carpentryShopBuyWoodAmount, 50);
	addButton(14, "Back", carpentryShopInside)
}	

private function carpentryShopBuyWoodAmount(amount:int):void {
	wood = amount;
	output("You ask him for " + amount + " wood planks. He replies \"<i>That'll be " + (amount * 10) + " gems, please.</i>\" \n\nDo you buy the wood?", true);
	doYesNo(carpentryShopBuyWoodYes, carpentryShopBuyWood);
}

private function carpentryShopBuyWoodYes():void {
	if (pc.gems >= (wood * 10))
	{
		pc.gems -= (wood * 10);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += wood;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
		output("You hand over " + (wood * 10) + " gems. \"<i>I'll have the caravan deliver the wood to your camp as soon as you leave my shop,</i>\" he says.\n\n", true);
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 999)
		{
			output("Unfortunately, your wood supply seem to be full. You inform him. He refunds you the gems.\n\n", false);
			pc.gems += ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 999) * 10);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 999);
		}
		output("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]);
	}
	else output("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"", true);
	statScreenRefresh();
	doNext(carpentryShopBuyWood);
}

//Buy wood
public function carpentryShopSellWood():void {
	output("You ask him if he's willing to buy wood from you. He says, \"<i>Certainly! I'll be buying wood at a rate of five gems per piece.</i>\" \n\n", true);
	output("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100", false);
	menu();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellWoodAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellWoodAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellWoodAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellWoodAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 0) addButton(4, "Sell All", carpentryShopSellWoodAmount, flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]);
	addButton(14, "Back", carpentryShopInside)
}	

private function carpentryShopSellWoodAmount(amount:int):void {
	wood = amount;
	output("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood. He replies \"<i>I'll buy that for " + (amount * 5) + " gems.</i>\" \n\nDo you sell the wood?", true);
	doYesNo(carpentryShopSellWoodYes, carpentryShopSellWood);
}

private function carpentryShopSellWoodYes():void {
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= wood)
	{
		pc.gems += (wood * 5);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= wood;
		output("You sign the permission form for " + num2Text(wood) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood to be unloaded from your camp. \"<i>Deal. Here are " + (wood * 5) + " gems,</i>\" he says.\n\n", true);
		output("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100");
	}
	else output("\"<i>I'm sorry, my friend. You do not have enough wood.</i>\"", true);
	statScreenRefresh();
	doNext(carpentryShopSellWood);
}