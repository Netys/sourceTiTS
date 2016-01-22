import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Miscellaneous.*;
import classes.Items.Transformatives.*;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function giacomoEncounter():void {
	//spriteSelect(23);
	userInterface.showName("\nGIACOMO");
	clearOutput();
	if (flags["COC.GIACOMO_MET"] == undefined) {
		giacomoFirstEncounter();
	}
	//else if (pc.findStatusAffect(StatusAffects.WormOffer) < 0 && pc.findStatusAffect(StatusAffects.Infested) >= 0) { //If infested && no worm offer yet
		//output("Upon walking up to Giacomo's wagon, he turns to look at you and cocks an eyebrow in curiosity and mild amusement.\n\n");
		//output("\"<i>Been playing with creatures best left alone, I see</i>,\" he chuckles.  \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here.  It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n");
		//output("You ask how he knows of your change and the merchant giggles heartily.\n\n");
		//output("\"<i>Do not look at me as if I am a mystic,</i>\" Giacomo heckles lightly.  \"<i>Your crotch is squirming.</i>\"\n\n");
		//output("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n");
		//output("\"<i>Fear not!</i>\" the purveyor jingles.  \"<i>I have something that will cure you of those little bastards.  Of course, there is also a chance that it will purge your system in general.  This potion is not cheap.  I will trade it for 175 gems.</i>\"\n\n");
		//pc.createStatusAffect(StatusAffects.WormOffer, 0, 0, 0, 0);
		//if (pc.gems < 175) { //Broke as a joke
			//output("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.");
		//}
		//else { //Can afford
			//output("Do you purchase his cure?");
			////Remove/No
			////doYesNo(wormRemoval, giacomoFirstEncounter);
			//return;
		//}
	//}
	else { //Normal greeting
		output("You spy the merchant Giacomo in the distance.  He makes a beeline for you, setting up his shop in moments.  ");
		output("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?");
	}
	//var deworm:Function = (pc.findStatusAffect(StatusAffects.WormOffer) >= 0 && pc.findStatusAffect(StatusAffects.Infested) >= 0 ? wormRemovalOffer : null);
	//simpleChoices("Potions", giacomoPotionMenu, "Books", giacomoBookMenu, "Erotica", giacomoEroticaMenu, "Worm Cure", deworm, "Leave", returnToCampUseOneHour);
	clearMenu();
	addButton(0, "Shop", giacomoShop);
	addButton(1, "Erotica", giacomoEroticaMenu);
	addButton(14, "Leave", function():* { 
		processTime(10 + rand(5));
		mainGameMenu();
	} );
}

private function giacomoFirstEncounter():void {
	output("As you travel, you see another person on the road.  He is tethered to a small cart that is overloaded with a hodgepodge of items.  He is dressed in a very garish manner, having a broad, multicolored hat, brocaded coat and large, striped pantaloons.  His appearance is almost comical and contrasts with his severe and hawkish facial features.  The man sees you, smiles and stops his cart.\n");
	output("\"<i>Greetings, traveler! My name is Giacomo.  I am, as you can see, a humble purveyor of items, curios and other accoutrements.  While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n");
	output("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving.  The merchant twists his way around to access a sack he has around his back.  After a moment, he swings the sack from his back to have better access to its contents.  Inquisitively, the merchant turns back to you.\n");
	output("\"<i>So stranger, be you interested in some drafts to aid you in your travels, some quick pamphlets to warn you of dangers on journeys or...</i>\"\n\n");
	output("Giacomo pauses and turns his head in both directions in a mocking gesture of paranoid observation.  His little bit of theatrics does make you wonder what he is about to offer.\n");
	output("\"<i>...maybe you would be interested in some items that enhance the pleasures of the flesh?  Hmmm?</i>\"\n\n");
	output("Giacomo's grin is nothing short of creepy as he offers his wares to you.  What are you interested in?");
	flags["COC.GIACOMO_MET"] = 1;
}


private function giacomoShop():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Giacomo";
	shopkeep.keeperBuy = "Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?\n\n";
	shopkeep.inventory = [new CoCVitalityTincture(), new CoCScholarsTea()];
	shopkeepBackFunctor = giacomoEncounter;
	buyItem();
}

//private function giacomoBookMenu():void {
	////spriteSelect(23);
	//clearOutput();
	//output("Which book are you interested in perusing?");
	//simpleChoices("Dangerous Plants", pitchDangerousPlantsBook, "Traveler's Guide", pitchTravellersGuide, "Hentai Comic", pitchHentaiComic,
		//"Yoga Guide", (flags[kFLAGS.COTTON_UNUSUAL_YOGA_BOOK_TRACKER] > 0 ? pitchYogaGuide : null), "Back", giacomoEncounter);
//}

private function giacomoEroticaMenu():void {
	//spriteSelect(23);
	clearOutput();
	output("Giacomo's grin is nothing short of creepy as he offers his wares to you.  What are you interested in?");
	clearMenu();
	if (!pc.hasKeyItem("Dildo")) addButton(0, "Dildo", pitchDildo);
	else addDisabledButton(0, "Dildo", "Dildo", "You already have one!");
	//if (pc.hasVagina()) addButton(1, "Stim-Belt", pitchSelfStimulationBelt);
	//if (pc.hasVagina()) addButton(2, "AN Stim-Belt", pitchAllNaturalSelfStimulationBelt);
	//if (pc.hasCock()) addButton(3, "Onahole", pitchOnahole);
	//if (pc.hasCock()) addButton(4, "D Onahole", pitchDeluxeOnahole);
	//if (pc.hasCock() && pc.hasVagina()) addButton(5, "Dual Belt", pitchDualStimulationBelt);
	//if (pc.hasCock() && pc.hasVagina()) addButton(6, "AN Onahole", pitchAllNaturalOnahole);
	//addButton(7, "Condom", pitchCondom);
	addButton(14, "Back", giacomoEncounter);
}

//private function pitchCeruleanPotion():void {
	////spriteSelect(23);
	//clearOutput();
	//output("Giacomo makes his comical over-the-shoulder search and holds up a sky-blue bottle.  He grins widely as he begins his pitch, \"<i>My friend, you truly have a discerning eye.  Even the most successful of men seek to attract more women for pleasure and status.  This, my friend, will attract the most discerning and aroused of women.  Women attracted by this fine unction will NEVER say no.  I GUARANTEE that she will want pleasure every time you demand pleasure!  A bit of a caution to you, brother.  Some say this works TOO well.  If you aren't man enough to handle the women this urn draws to you, you'd best say so now and I will offer something more to your liking.  However, if you have the heart for it, I can sell you this little gem for <b>75 gems</b></i>!\"  ");
	////doYesNo(buyCeruleanPotion, potionMenu);
//}
//
//private function buyCeruleanPotion():void {
	////spriteSelect(23);
	//if (pc.gems < 75) {
		//clearOutput();
		//output("\n\nGiacomo sighs, indicating you need " + String(75 - pc.gems) + " more gems to purchase this item.");
		//doNext(potionMenu);
	//}
	//else {
		//inventory.takeItem(consumables.CERUL_P, potionMenu);
		//pc.gems -= 75;
		//statScreenRefresh();
	//}
//}
//
//public function pitchCondom():void {
	////spriteSelect(23);
	//output("Giacomo holds up the packet and says, \"<i>Ah, yes! This is a condom. Just slip it on any cocks and have it penetrate any holes. It's guaranteed to prevent the spread of STDs and it will help to prevent pregnancy. I must warn you that it does not completely prevent pregnancy. Rarely, it will fail. However, it will work most of the time. So, <b>ten gems</b>. What do you say?</i>\"", true);
	////doYesNo(buyCondom, eroticaMenu);
//}
//
//public function buyCondom():void {
	////spriteSelect(23);
	//if (pc.gems < 10)
	//{
		//output("\n\nGiacomo sighs, indicating you need " + String(10 - pc.gems) + " more gems to purchase this item.", true);
		//doNext(giacomoEroticaMenu);
	//}
	//else
	//{
		//pc.gems -= 10;
		//inventory.takeItem(useables.CONDOM, giacomoEroticaMenu);
		//statScreenRefresh();
	//}
//}
//
//private function pitchDangerousPlantsBook():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Dangerous Plants") >= 0) {
		//output("<b>You already own the book 'Dangerous Plants'.</b>");
		//doNext(bookMenu);
		//return;
	//}
	//output("Giacomo proudly holds up a small text.  The cover is plain and unadorned with artwork.  \"<i>According to the scholars,</i>\" Giacomo begins, \"<i>knowledge is power.  It is one of the few things that scholars say that I agree with.  You cannot survive in today's world without knowing something of it.  Beasts and men are not your only problems.  This book specializes in the dangerous plants of the realm.  There exists flora the likes of which will chew you up and spit you out faster than any pack of wolves or gang of thieves.  For the small price of 10 gems, you can benefit from this fine book on the nastiest blossoms in existence.  Care to broaden your learning?</i>\"");
	////doYesNo(buyDangerousPlantsBook, bookMenu);
//}
//
//private function buyDangerousPlantsBook():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 10) {
		//output("\n\nGiacomo sighs, indicating you need " + String(10 - pc.gems) + " more gems to purchase this item.");
		//doNext(bookMenu);
	//}
	//else {
		//output("\n\nYou consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this book.  Obviously written by well-informed, but women-starved men, the narrative drearily states the various types of poisonous and carnivorous plants in the world.  One entry that really grabs you is the chapter on 'Violation Plants'.  The chapter drones on about an entire classification of specially bred plants whose purpose is to torture or feed off a human being without permanently injuring and killing them.  Most of these plants attempt to try breeding with humans and are insensitive to the intricacies of human reproduction to be of any value, save giving the person no end of hell.  These plants range from massive shambling horrors to small plant-animal hybrids that attach themselves to people.  As you finish the book, you cannot help but shiver at the many unnatural types of plants out there and wonder what sick bastard created such monstrosities. ");
		//doNext(bookMenu);
		//pc.gems -= 10;
		//pc.createKeyItem("Dangerous Plants", 0, 0, 0, 0);
		//statScreenRefresh();
	//}
//}
//
//private function pitchTravellersGuide():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Traveler's Guide") >= 0) {
		//output("<b>You already own the book 'Traveler's Guide'.</b>");
		//doNext(bookMenu);
		//return;
	//}
	//output("Giacomo holds up a humble pamphlet.  \"<i>While you may not find value in this as a seasoned traveler,</i>\", Giacomo opens, \"<i>you never know what you may learn from this handy, dandy information packet!  Geared to the novice, this piece of work emphasizes the necessary items and some good rules of thumb for going out into the world.  You may not need it, but you may know someone who does.  Why waste your time when the answers could be in this handy pamphlet!  I will offer the super-cheap price of 1 gem!</i>\"");
	////doYesNo(buyTravellersGuide, bookMenu);
//}
//
//private function buyTravellersGuide():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 1) {
		//output("\n\nGiacomo sighs, indicating you need 1 gem to purchase this item.");
		//doNext(bookMenu);
	//}
	//else {
		//output("The crazy merchant said you might not need this and he was right.  Written at a simple level, this was obviously intended for a city-dweller who never left the confines of their walls.  Littered with childish illustrations and silly phrases, the book is informative in the sense that it does tell a person what they need and what to do, but naively downplays the dangers of the forest and from bandits.  Were it not so cheap, you would be pissed at the merchant.  However, he is right in the fact that giving this to some idiot ignorant of the dangers of the road saves time from having to answer a bunch of stupid questions.");
		//doNext(bookMenu);
		//pc.gems -= 1;
		//pc.createKeyItem("Traveler's Guide", 0, 0, 0, 0);
		//statScreenRefresh();
	//}
//}
//
//private function pitchHentaiComic():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Hentai Comic") >= 0)
	//{
		//output("<b>You already own a Hentai Comic!</b>");
		//doNext(bookMenu);
		//return;
	//}
	//output("Giacomo takes out a colorfully written magazine from his bag.  The cover contains well-drawn, overly-endowed women in sexual poses.  \"<i>Perhaps your taste in reading is a bit more primal, my good " + pc.mfn("man", "lady", "...err, whatever you are") + "</i>,\" says Giacomo.  \"<i>Taken from the lands far to the east, this is a tawdry tale of a group of ladies seeking out endless pleasures.  With a half a dozen pictures on every page to illustrate their peccadilloes, you will have your passions inflamed and wish to join these fantasy vixens in their adventures!  Collectable and in high demand, and even if this is not to your tastes, you can easily turn a profit on it!  Care to adventure into the realm of fantasy?  It's only 10 gems and I am doing YOU a favor for such a price.</i>\"");
	////doYesNo(buyHentaiComic, bookMenu);
//}
//
//private function buyHentaiComic():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 10) {
		//output("\n\nGiacomo sighs, indicating you need " + String(10 - pc.gems) + " more gems to purchase this item.");
		//doNext(bookMenu);
	//}
	//else {
		//output("You peruse the erotic book.  The story is one of a group of sisters who are all impossibly heavy-chested and equally horny getting into constant misadventures trying to satisfy their lust.  While the comic was entertaining and erotic to the highest degree, you cannot help but laugh at how over-the-top the story and all of the characters are.  Were the world as it was in the book, nothing would get done as humanity would be fucking like jackrabbits in heat for the rest of their lives.  While certainly a tempting proposition, everyone gets worn out sometime.  You place the book in your sack, well entertained and with a head filled with wilder perversions than what you woke up with this morning.");
		//doNext(bookMenu);
		//pc.gems -= 10;
		//dynStats("lib", 2, "lus", 20);
		//pc.createKeyItem("Hentai Comic", 0, 0, 0, 0);
		//statScreenRefresh();
	//}
//}
//
//private function pitchYogaGuide():void {
	////spriteSelect(23);
	//clearOutput();
	//output("Giacomo holds up the book with a small degree of reverence.  The cover is leather, with the lettering stitched in by hand.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a strange book indeed.  I traded for it in the east, where they practice a form of exercise known as yoga.  This volume in particular deals with those of, shall we say, unusual body shapes.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your horizons?</i>\"");
	////doYesNo(buyYogaGuide, bookMenu);
//}
//
//private function buyYogaGuide():void {
	//clearOutput();
	//if (pc.hasKeyItem("Yoga Guide") >= 0) {
		//output("<b>You already own a yoga guide!</b>");
	//}
	//else if (pc.gems < 100) {
		//output("You cannot afford a yoga guide!");
	//}
	//else {
		//output("You exchange 100 gems for the tome.  Now you can finally enjoy a workout with Cotton!");
		//pc.createKeyItem("Yoga Guide", 0, 0, 0, 0);
		//pc.gems -= 100;
		//statScreenRefresh();
	//}
	//doNext(bookMenu);
//}

private function pitchDildo():void {
	//spriteSelect(23);
	clearOutput();
	output("Giacomo takes out a slender tube roughly over half a foot in length.  \"<i>Since you seek pleasure, this is as simple and effective as it gets.  This dildo is a healthy seven inches long and is suitable for most women and even adventurous men.  Pick a hole, stick it in and work it to your heart's content or your partner's pleasure.  The single-piece construction makes it solid, sturdy and straightforward.  For 20 gems, you can take matters into your own hands.  How about it?</i>\"");
	clearMenu();
	if (pc.credits >= 200) addButton(0, "Yes", buyDildo);
	else addDisabledButton(0, "Yes", "Yes", "You can't afford it!");
	addButton(1, "No", giacomoEroticaMenu);
}
	
private function buyDildo():void {
	//spriteSelect(23);
	clearOutput();
	output("After making the payment, Giacomo hands you the Dildo.");
	pc.credits -= 200;
	pc.createKeyItem("Dildo", 0, 0, 0, 0, "This dildo is a healthy seven inches long and is suitable for most women and even adventurous men.");
	//statScreenRefresh();
	clearMenu();
	addButton(0, "Next", giacomoEncounter);
}

//private function pitchSelfStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Self-Stimulation Belt") >= 0) {
		//output("<b>You already own a Self-Stimulation Belt!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("Giacomo holds up what appears to be a chastity belt.  However, this device has a dildo attached to the inside.  There is a small gearbox on the outside and a wind-up key is tethered to it.  The crazed merchant holds the contraption up and begins his liturgy.  \"<i>Ah! Someone who both appreciates pleasure AND the wonders of artifice.  This naughty little piece of jewelry is designed to pleasure any woman all at the push of a button!  All you do is take this key, wind up the gear box...</i>\"  Giacomo takes the key and inserts it into the box and winds it like a watch.  He then points to a switch.  \"<i>...you then press this button and enjoy yourself!</i>\"  Giacomo flips the switch and the dildo vibrates rapidly.  The distinct hum from the toy and the whirring of gears stirs your imagination.  Giacomo pipes up, breaking your train of thought.  \"<i>This belt is not cheap, but it is most certainly worth the investment of 30 gems!</i>\"");
	////doYesNo(buySelfStimulationBelt, eroticaMenu);
//}
//
//private function buySelfStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 30) {
		//output("\n\nGiacomo sighs, indicating you need " + String(30 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("After making the payment, Giacomo hands you the Self-Stimulation Belt");
	//pc.createKeyItem("Self-Stimulation Belt", 0, 0, 0, 0);
	//doNext(giacomoEroticaMenu);
	//pc.gems -= 30;
//}
//
//private function pitchAllNaturalSelfStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("All-Natural Self-Stimulation Belt") >= 0) {
		//output("<b>You already own an All-Natural Self-Stimulation Belt!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("The merchant places his bag on the ground.  He reaches into one of his purses and pulls out a pair of gloves.  After putting them on, he reaches into his bag and pulls out what appears to be a chastity belt.  The device has a clearly organic look to it.  In the center of the front cover is a nodule.  You have heard of similar devices.  They normally have a dildo attached to them to pleasure women.  ");
	//output("\"<i>This device is quite intriguing,</i>\" Giacomo begins, \"<i>This pleasure engine is NOT for the faint-of-heart.  Being constructed of materials from the workshops of biomechanical artificers, this device outperforms its mechanical cousin in every way.  Guaranteed to last longer than you do, this machine will give you as many mind-shattering orgasms as you can handle.  Unlike the mechanical belt, you do not need to wind it up.  It soaks up the power of the sun itself in an amazing feat of engineering.  Four hours a day is all it needs!  Keep in mind that if there is no sun for a couple of days, it will not work without a full day's sunshine.  You may wonder why I am wearing gloves.  Well, that is because of the pads on the belt.</i>\"  Giacomo points to a couple of small, amber pads on the belt.  \"<i>They are sensitive to human touch and activate the belt.  This is all yours for 40 gems and you get the gloves for free!  Again, this device offers ultimate pleasure.  If you can't handle it, I will not be offended if you turn it down.</i>\"");
	//if (pc.hasKeyItem("Dangerous Plants") >= 0 && pc.inte > 39) {
		//output("\n\nThe nodule and the base of the stimulator look vaguely like some of the things you have seen in the Dangerous Plant book.  You wonder if there is not something devious about this item.  Giacomo is also sweating.  It is too cool for that, this time of year.");
	//}
	//else {
		//if (pc.inte > 29) {
			//output("\n\nYou notice a change in Giacomo's attitude.  He REALLY wants to sell you this sex toy.  Something this exotic should cost much more than what he is offering.");
		//}
	//}
	//output("\n\nDo you buy the All-Natural Self-Stimulation Belt?");
	////doYesNo(buyAllNaturalSelfStimulationBelt, eroticaMenu);
//}
//
//private function buyAllNaturalSelfStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 40) {
		//output("\n\nGiacomo sighs, indicating you need " + String(40 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("After making the payment, Giacomo hands you the All-Natural Self-Stimulation Belt");
	//pc.createKeyItem("All-Natural Self-Stimulation Belt", 0, 0, 0, 0);
	//doNext(giacomoEroticaMenu);
	//pc.gems -= 40;
//}
	//
//private function pitchOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Plain Onahole") >= 0) {
		//output("<b>You already own a Plain Onahole!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("Giacomo takes out a pink cylinder from his bag.  It appears to be sealed at one end and the cap is topped with a piece of rubber that has a vertical slit.  \"<i>Friend</i>,\" Giacomo starts, \"<i>when you do not want to go through all of the shit to bag a woman, this is the thing for you.  It never says no, it never bitches and it never takes everything you own in a divorce.  All you do is get hard, slip your cock in the slit, work it at your pace and unload.  Simple is as simple does.  Take the top off for easy clean up and there you go!  As you can see it is portable and is much safer than risking some social disease from an errant barmaid.  I have plenty of these in stock and I can let it go for 20 gems.  What say you?</i>\"");
	////doYesNo(buyOnahole, eroticaMenu);
//}
//
//private function buyOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 20) {
		//output("\n\nGiacomo sighs, indicating you need " + String(20 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("After making the payment, Giacomo hands you the Plain Onahole");
	//pc.createKeyItem("Plain Onahole", 0, 0, 0, 0);
	//doNext(giacomoEroticaMenu);
	//pc.gems -= 20;
//}
	//
//private function pitchDeluxeOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Deluxe Onahole") >= 0) {
		//output("<b>You already own a Deluxe Onahole!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("Giacomo holds up a weirdly shaped lump of rubber.  One end is shaped and contoured like a woman's genitalia while the rest stretches out to almost a foot long.  \"<i>This thing right here is excellent!  While a standard onahole will get you off, this has the look and feel of the real thing!  As you can see, the outside orifice looks just like a woman's privates and,</i>\" Giacomo pauses to open the inside for you to view.  You see the inner folds and curves that are typical to the inside of a woman's womb, \"<i>as you can see, great care has been taken to make the inside feel as much like a real pussy as possible.  You hammer your cock with this thing a few times and you may never want the real thing again!  If nothing else, it won't whine about you running out the door first thing in the morning.  50 gems is more than reasonable for all of the satisfaction this will bring.</i>\"");
	////doYesNo(buyDeluxeOnahole, eroticaMenu);
//}
//
//private function buyDeluxeOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 50) {
		//output("\n\nGiacomo sighs, indicating you need " + String(50 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("After making the payment, Giacomo hands you the Deluxe Onahole");
	//pc.createKeyItem("Deluxe Onahole", 0, 0, 0, 0);
	//doNext(giacomoEroticaMenu);
	//pc.gems -= 50;
//}
//
//private function pitchAllNaturalOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("All-Natural Onahole") >= 0) {
		//output("<b>You already own an All-Natural Onahole!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("Giacomo reaches into his bag and pulls out what looks like an oblong coconut.  It is roughly seven inches in diameter.  There is a distinctive opening in one end that is just large enough for an erect penis.  Inside the opening you see what looks like two pink cushions.  There are multiple symmetrical depressions surrounding the outside hole of the thing.  Giacomo's smile fades and he takes on a much more serious attitude befitting his aquiline face.  \"<i>Miss,</i>\" Giacomo states, \"<i>without sounding too bold, it is no secret that members of the third gender are capable of sexual feats that force the other two genders into jealous fits.  Having bigger cocks than men, cumming more than an elephant and a pussy with the strength and coordination of a human hand, regular toys do not last long for you folk.  Hence, this little beasty.  I will tell you straightaway, only the third sex ");
	//output("can handle this toy.  The other two genders simply do not have the stamina for it.  This thing is all-natural, meaning that it powers itself and is made with the Artificers' organic methods.  It will cease functioning if it is not used or you fail to give the opening a few drops of this fluid once every three days.</i>\"  Giacomo pauses to hold up a small bottle.  He places the bottle down and continues his sales pitch, \"<i>If you plan on not using this thing regularly, do not buy it.  These items are very rare and this one will probably be the only one you'll ever see.  Normally I pitch my products like crazy.  However, with this I do not need to.  This thing DOES work too well, and you WILL cum, period.  It will work you until you do not want it to work anymore.  It will not stop until IT decides to stop.  However, for the extreme needs of a lovely example of the dual-sex, it may be the very thing you need.  Again, this is for the ultimate hardcore pleasure seeker amongst the ultimate hardcore.  It costs a humble 150 gems, but for superhuman thrills, who can put a price tag on that?</i>");
	//if (pc.hasKeyItem("Dangerous Plants") >= 0 && pc.inte > 35) {
		//output("\n\nWhile skillfully avoiding Giacomo's suspicion, you correctly surmise that the toy is not a toy at all.  It is the outer shell for a hybrid animal-plant.  The creature is very much alive.  While the technical name for this beast is in the usual unpronounceable scholastic gibberish, the common nickname for this is the \"All-Day Sucker\".  It gets its name due to the fact that its diet consists of high nutrient fluids, especially semen.  It was used both as a torture device and as a pleasure pet of the snobbish elite because it would clamp down upon the member of a person and not release until it has stimulated the person enough to ejaculate sufficiently to feed.  However, the All-Day Sucker swells up like fleas and ticks do, thus requiring hours of stimulation to have its fill.  There was something else about these things, but you cannot remember exactly what it was.");
		//if (pc.inte > 65) {
			//output("After a moment, you remember what it was you read.  Unlike many simple beasts, this creature has a male and a female gender.  The creature itself is similar to a tubeworm.  While the males are considered reasonably \"safe\", the females have a nasty habit of injecting its young inside the sex organs of the person using the thing, leaving the hapless person to convulse in endless, painful orgasms as the beasties wriggle around their insides until they are ready for birth.  The process takes about a week and recorded victims normally make full recoveries after a period of blindingly painful orgasms as they shoot out the young.  It is not a surprise to have people's hearts give out at the endless stimulation from the young.  The recovery time is quite long due to the stress on the body such overwhelming stimulus would generate.  Some ultra-extreme pleasure seekers actively look for these things just for this experience.\n\nHowever, the problem is there is NO WAY to tell if this is male or female by looking at it.");
		//}
	//}
	////doYesNo(buyAllNaturalOnahole, eroticaMenu);
//}
//
//private function buyAllNaturalOnahole():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 150) {
		//output("\n\nGiacomo sighs, indicating you need " + String(150 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("After making the payment, Giacomo hands you the All-Natural Onahole");
	//pc.createKeyItem("All-Natural Onahole", 0, 0, 0, 0);
	//doNext(giacomoEroticaMenu);
	//pc.gems -= 150;
//}
//
//private function pitchDualStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.hasKeyItem("Dual Belt") >= 0) {
		//output("<b>You already own a Dual Belt!</b>");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//output("Giacomo smiles widely as you look through his wares seeing a strange looking device sitting there.  \"<i>Ahh, I see you have spotted our latest piece of equipment.  Members of the third gender had a hard time finding enough pleasure to suit their special needs.  With this little device, you will never have to worry about satisfying your needs ever again.</i>\"  He grins widely at you.  \"<i>The deluxe dual belt will have you shaking in the throes of orgasm hours after a simple stim belt would leave you dry.  You will cum in this thing, and it will leave you running back to it anytime you need sexual gratification.  Everything else may as well be sandpaper on your skin.  Simply flick this switch here on the side to start it up and send yourself to heaven.  And you can have it for the low price of 50 gems.</i>\"  He smiles again at you.  \"<i>So, shall I hand it over to you?</i>\" he asks.");
	////doYesNo(buyDualStimulationBelt, eroticaMenu);
//}
//
//private function buyDualStimulationBelt():void {
	////spriteSelect(23);
	//clearOutput();
	//if (pc.gems < 50) {
		//output("\n\nGiacomo sighs, indicating you need " + String(50 - pc.gems) + " more gems to purchase this item.");
		//doNext(giacomoEroticaMenu);
		//return;
	//}
	//else {
		//output("You are a bit dubious at the pleasure it could offer you, but it would be better than being raped by the creatures constantly... maybe to even work out some excess lusts... hesitantly, you reach into your bag and grab 50 gems, handing it to him.  He greedily snatches it from your palm and hands you with the belt with a smile.  \"<i>I promise you won't be disappointed.</i>\"  He counts the gems and waves goodbye.\n\n(<b>Dual Belt acquired!</b>)");
		//pc.createKeyItem("Dual Belt", 0, 0, 0, 0);
		//pc.gems -= 50;
		//statScreenRefresh();
	//}
	//doNext(giacomoEroticaMenu);
//}