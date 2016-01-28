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
	output("<i>\"Welcome to my jewelry store. Here, I sell rings and necklaces. They can make you look great but not only that, I also have special jewelry that may have magical effect on you. The effect stays on until you take them off,\"</i> the lizan says.");

	jewelShopInside();
}

public function jewelShopInside():void {
	clearOutput();
	showName("\nJEWELRY");
	output("<i>So what will it be?</i>", false);
	clearMenu();
	addButton(0, "Normal rings", jewelShopPageI);
	addDisabledButton(1, "Magic rings", "Magic rings", "Not implemented");
	//addButton(1, "Enchanted rings", jewelShopPageII);
	addDisabledButton(2, "Jewelry box", "Jewelry box", "Not implemented");
	//addButton(2, "Jewelry box", jewelShopBuyBox);
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

//public function jewelShopPageII():void {
	//choices(jewelries.CRIMRNG.shortName, createCallBackFunction(jewelBuy, jewelries.CRIMRNG),
			//jewelries.ICE_RNG.shortName, createCallBackFunction(jewelBuy, jewelries.ICE_RNG),
			//jewelries.FERTRNG.shortName, createCallBackFunction(jewelBuy, jewelries.FERTRNG),
			//jewelries.LIFERNG.shortName, createCallBackFunction(jewelBuy, jewelries.LIFERNG),
			//jewelries.POWRRNG.shortName, createCallBackFunction(jewelBuy, jewelries.POWRRNG),
			//jewelries.PURERNG.shortName, createCallBackFunction(jewelBuy, jewelries.PURERNG),
			//jewelries.MYSTRNG.shortName, createCallBackFunction(jewelBuy, jewelries.MYSTRNG),
			//"", null,
			//"", null,
			//"", null);
	//addButton(14, "Back", jewelShopInside);
//}	

//public function jewelShopBuyBox():void {
	//clearOutput();
	//if (pc.hasKeyItem("Equipment Storage - Jewelry Box") >= 0)
	//{
		//output("<b>You already own a jewelry box!</b>", true)
		//doNext(jewelShopInside);
		//return;
	//}
	//output("You look around for a while until you see something that catches your eyes. A finely-polished jewelry box sits on table.  You approach the jewelry box and examine it.  The box comes complete with a hinged lid and several small drawers.  The price tag says that it costs 500 gems.\n\n", false);
	//output("The lizan then walks over to you and asks \"<i>See something you'd like to buy?</i>\" You then ask him about the jewelry box. \n\n", false);
	//output("\"<i>We have plenty of them. This is a finely crafted box. It's designed to hold nine different rings and amulets. Of course, it's secure! It has combination lock. With the right code, you can unlock it. And it can be yours for only 500 gems!</i>\"\n\n", false);
	//output("Do you buy it?", false);
	//if (pc.gems >= 500)
	//{
		//doYesNo(jewelShopBuyBoxYes, jewelShopBuyBoxNo);
	//}
	//else
	//{
		//output("\n\nYou count out your gems and realize it's beyond your price range.", false);
		//doNext(jewelShopInside);
	//}
//}	
//
//public function jewelShopBuyBoxYes():void {
	//pc.gems -= 500;
	//statScreenRefresh();
	//output("You hand over five hundred gems to the lizan. ", true);
	//output("He then exclaims\"<i>Sold!</i>\" as he hands over the jewelry box to you. You take your time to set the combination and memorize it should you need to access your jewelry box.\n\n", false);
	//output("<b>Gained Key Item: Jewelry Box!</b>", false)
	//pc.createKeyItem("Equipment Storage - Jewelry Box", 0, 0, 0, 0);
	//doNext(jewelShopInside);
//}	
//public function jewelShopBuyBoxNo():void {
	//output("\"<i>No thanks,</i>\" you tell him. \n\n", true);
	//output("\"<i>Very well. Let me know if you've changed your mind,</i>\" he says.", false);
	//doNext(jewelShopInside);
//}	
//
//private function jewelBuy(itype:ItemType):void {
	//clearOutput();
	//output("The lizan escorts you and opens the case to retrieve the ring. He shows you the ring. He says \"<i>That will be... uh... " + itype.value + " gems.</i>\"", false);
	//if(pc.gems < itype.value) {
		//output("\n\nYou count out your gems and realize it's beyond your price range.", false);
		////Goto shop main menu
		//doNext(jewelShopInside);
		//return;
	//}
	//else output("\n\nDo you buy it?\n\n", false);
	////Go to debit/update function or back to shop window
	//doYesNo(curry(debitJewel, itype), jewelShopInside);
//}
//private function debitJewel(itype:ItemType):void {
	//pc.gems -= itype.value;
	//statScreenRefresh();
	//inventory.takeItem(itype, jewelShopInside);
//}