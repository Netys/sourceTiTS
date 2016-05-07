import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Melee.CoCSuccubusWhip;
import classes.Items.Transformatives.CoCGroPlus;
import classes.Items.Transformatives.CoCReducto;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;


//Sean the Incubus
private function ZetazCaveInvestigateIncubus():void {
	//spriteSelect(52);
	clearOutput();
	output("You try to sneak closer to get a closer look at him, but the demon immediately stops what he's doing and stares straight at you.  He laughs, \"<i>Well now I know what happened to all the demons inside.  I really would've expected a bunch of renegades like them to put up a better fight.</i>\"\n\n");
	output("Caught, you stand up and [pc.readyWeapon], taking up a defensive stance to ready yourself for whatever new attacks this demon has.  Strangely, he just starts laughing again, and he has to stop to wipe tears from the corners of his eyes before he talks, \"<i>Oh that's rich!  I'm not here to fight you, Champion.  I doubt I'd stand much of a chance anyways.  I heard there were some renegades around this area, so I thought I'd show up to offer my services.  You see, I'm a procurer of strange and rare alchemical solutions.  Of course you beat down everyone before I got here, but I thought I'd stick around and see if some scouts were still around before I high-tailed it out of here.</i>\"\n\n");
	output("You stare, blinking your eyes in confusion.  A demon of lust, and he's not interested in fighting or raping you?  He laughs again as he reads your expression and calmly states, \"<i>No, I'm far from your average incubus.  To tell the truth I enjoy a spirited debate or the thrill of discovery over sating my sexual appetite, though of course I do indulge that from time to time.</i>\"\n\n");
	output("The strange incubus flashes you a smile that makes you feel a tad uncomfortable before he finally introduces himself, \"<i>The name's Sean, and as you seem to be kicking the living shit out of Lethice's followers and enemies alike, I'd like to be on your side.  So I propose a mutually beneficial agreement – I'll sell you items you can't get anywhere else, and you let me live in this cave.  What do you say?</i>\"\n\n");
	clearMenu();
	addButton(0, "Deal", seanDeal);
	addButton(1, "No Deal", seanNoDeal);
	addButton(2, "Not Now", seanNotNow);
}

private function seanDeal():void {
	//spriteSelect(52);
	clearOutput();
	output("\"<i>Excellent!  Give me a few moments to gather my things and I'll be open for business!</i>\" exclaims the strange demon.  If his story is true it's no wonder he doesn't get along with the rest of his kind.");
	
	//[Next – to room]
	flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] = 1;
	processTime(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
	//doNext(roomEntrance);
}
private function seanNoDeal():void {
	//spriteSelect(52);
	clearOutput();
	flags["COC.ZETAZ_LAIR_DEMON_VENDOR_PRESENT"] = -1;
	output("Sean nods, grabs a pack, and takes off running before you have a chance to kill him.");
	processTime(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
	//doNext(roomEntrance);
}
private function seanNotNow():void {
	//spriteSelect(52);
	clearOutput();
	output("\"<i>Very well. Come back when you've changed your mind,</i>\" Sean sighs.");
	processTime(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
	//doNext(roomEntrance);
}
private function ZetazCaveIncubusShop():void {
	//spriteSelect(52);
	clearOutput();
	output("Sean nods at you and slicks his hair back into place, threading it carefully around the small nubs of his horns before asking, \"<i>What can I do for you?</i>\"");
	clearMenu();
	addButton(0, "Shop", SeanShopOpen);
	addButton(14, "Leave", mainGameMenu);
	//doNext(roomEntrance);
}

private function SeanShopOpen():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Sean";
	shopkeep.sellMarkup = 1.;
	shopkeep.buyMarkdown = .5;
	shopkeep.typesBought = [GLOBAL.ALL];
	shopkeep.keeperBuy = "Sean nods at you and slicks his hair back into place, threading it carefully around the small nubs of his horns before asking, \"<i>What can I do for you?</i>\"";
	shopkeep.inventory = [new CoCReducto(), new CoCGroPlus(), new CoCSuccubusWhip()];
	shopkeepBackFunctor = ZetazCaveIncubusShop;
	buyItem();
}

//private function buyItem(item:Number = 0):void
//{
	//spriteSelect(52);
	//if (item == 0) incubusBuy(consumables.NUMBROX);
	//if (item == 1) incubusBuy(consumables.SENSDRF);
	//if (item == 2) incubusBuy(consumables.REDUCTO);
	//if (item == 3) incubusBuy(weapons.SUCWHIP);
//}

//public function incubusBuy(itype:ItemType):void {
	////spriteSelect(52);
	//clearOutput();
	//output("The incubus lifts " + itype.longName + " from his shelves and says, \"<i>That will be " + (itype.value * 3) + " gems.  Are you sure you want to buy it?</i>\"", false);
	//if(pc.gems < (itype.value * 3)) {
		//output("\n<b>You don't have enough gems...</b>", false);
		//doNext(incubusShop);
		//return;
	//}
	//doYesNo(Utils.curry(incubusTransact,itype), incubusShop);
//}