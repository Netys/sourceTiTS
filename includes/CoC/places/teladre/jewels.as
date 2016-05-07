import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Accessories.*;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//-----------------
//-- JEWELRY STORE
//-----------------
public function jewelShopEntry():void {
	clearOutput();
	output("You enter the jewelry store. There are large array of rings and necklaces, all stored in thick glass cases. A male lizan sits behind the counter, watching you as you look around the store. He is nude save for his gilded silken loincloth and a gold necklace. His chin is pierced with several gold ring piercings. He also wears a diamond ring on one of his fingers.\n\n");
	output("<i>\"Welcome to my jewelry store. Here, I sell rings and necklaces. They can make you look great,");
	//output(" but not only that, I also have special jewelry that may have magical effect on you. The effect stays on until you take them off,");
	output("\"</i> the lizan says.");

	jewelShopInside();
}

public function jewelShopInside():void {
	clearOutput();
	showName("\nJEWELRY");
	output("<i>So what will it be?</i>", false);
	clearMenu();
	addButton(0, "Jewelry", jewelShopPageI);
	//addDisabledButton(1, "Magic rings", "Magic rings", "Not implemented");
	if (flags["COC.CAMP_STORAGE_VALUABLES"] == undefined) addButton(4, "Safebox", jewelShopBuyBox);
	addButton(14, "Leave", telAdreMenu);
}

private function jewelShopPageI():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Lizan";
	shopkeep.keeperBuy = "<i>\"Welcome to my jewelry store. Here, I sell rings and necklaces.\"</i>\n\nWhat do you buy?";
	shopkeep.sellMarkup = 1.0;
	shopkeep.buyMarkdown = .5;
	shopkeep.typesBought = [GLOBAL.ACCESSORY, GLOBAL.GEM];
	shopkeep.inventory = [new CoCSilverRing(), new CoCGoldRing(), new CoCPlatinumRing(), new CoCDiamondRing(), new CoCLethiciteRing()];
	shopkeepBackFunctor = jewelShopInside;
	buyItem();
}

public function jewelShopBuyBox():void {
	clearOutput();
	if (flags["COC.CAMP_STORAGE_VALUABLES"] != undefined)
	{
		output("<b>You already own a jewelry box!</b>")
		addNextButton(jewelShopInside);
		return;
	}
	output("You look around for a while until you see something that catches your eyes. A finely-polished safebox sits on table.  You approach the safebox and examine it.  The box comes complete with a hinged lid and several small drawers.  The price tag says that it costs 100 gems.\n\n");
	output("The lizan then walks over to you and asks \"<i>See something you'd like to buy?</i>\" You then ask him about the jewelry box. \n\n");
	output("\"<i>We have plenty of them. This is a finely crafted box. It's designed to hold ten different rings and amulets. Of course, it's secure! It has combination lock. With the right code, you can unlock it. And it can be yours for only 100 gems!</i>\"\n\n");
	output("Do you buy it?");
	if (pc.credits >= 1000)
	{
		clearMenu();
		addButton(0, "Yes", jewelShopBuyBoxYes);
		addButton(1, "No", jewelShopBuyBoxNo);
	}
	else
	{
		output("\n\nYou count out your gems and realize it's beyond your price range.");
		addNextButton(jewelShopInside);
	}
}	

public function jewelShopBuyBoxYes():void {
	clearOutput();
	output("You hand over hundred gems to the lizan. ");
	output("He then exclaims\"<i>Sold!</i>\" as he hands over the safebox to you. You take your time to set the combination and memorize it should you need to access your jewelry box.\n\n");
	pc.credits -= 1000;
	flags["COC.CAMP_STORAGE_VALUABLES"] = 10;
	output("<b>You now have " + flags["COC.CAMP_STORAGE_VALUABLES"] + " storage slots for valueables at camp.</b>");
	
	processTime(60 + rand(30));
	addNextButton();
}	

public function jewelShopBuyBoxNo():void {
	clearOutput();
	output("\"<i>No thanks,</i>\" you tell him. \n\n");
	output("\"<i>Very well. Let me know if you've changed your mind,</i>\" he says.");
	addNextButton(jewelShopInside);
}