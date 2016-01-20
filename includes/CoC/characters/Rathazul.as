import classes.Characters.CoC.CoCTrader;
import classes.Creature;
import classes.GLOBAL;
import classes.Items.Apparel.CoCDragonScaleRobes;
import classes.Items.Apparel.CoCSpiderSilkRobes;
import classes.Items.Armor.CoCBeeArmor;
import classes.Items.Armor.CoCDragonScaleArmor;
import classes.Items.Armor.CoCGelArmor;
import classes.Items.Armor.CoCSpiderSilkArmor;
import classes.Items.Miscellaneous.*;
import classes.Items.Transformatives.*;
import classes.Items.Transformatives.CoCDyes.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function followerCampMenuBlurbRathazul(showInteractButton:Boolean):void {
	if (flags["COC.RATHAZUL_IN_CAMP"] == 1) {
		output("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  ");
		//if (!(hours > 4 && hours < 23)) outputText("The alchemist is absent from his usual work location. He must be sleeping right now.");
		//else 
		if (flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + 24 * 60 >= timeAsStamp && flags["COC.RATHAZUL_ARMOR_TYPE"] > 0)
			output("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work on the silken equipment you've commissioned him to craft.\n\n");
		else if(flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + 24 * 60 < timeAsStamp && flags["COC.RATHAZUL_ARMOR_TYPE"] > 0) output("  Some kind of spider-silk-based equipment is hanging from a nearby rack.  <b>He's finished with the task you gave him!</b>");
		else output("The alchemist Rathazul looks to be hard at work with his chemicals, working on who knows what.");
		output("\n\n");
		//else  
		if(showInteractButton) addButton(3, "Rathazul", campRathazul, true, "Rathazul", "Visit with Rathazul to see what alchemical supplies and services he has available at the moment.");
	}
	else
	{
		if (flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + 24 * 60 < timeAsStamp && flags["COC.RATHAZUL_ARMOR_TYPE"] > 0)
		{
			output("There is a note on your ");
			//if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("bed inside your cabin.");
			//else 
			output("bedroll");
			output(". It reads: \"<i>Come see me at the lake. I've finished your spider-silk gear. -Rathazul</i>\".\n\n");
		}
	}
}

private var followerCampMenuBlurbRathazulHook: * = followerCampMenuBlurbRathazulGrapple();
private function followerCampMenuBlurbRathazulGrapple():* {	
	followerCampMenuBlurb.push(followerCampMenuBlurbRathazul);
}

public function RathazulTimePassedNotify():void {
	if (hours == 0) {
		if (flags["COC.RATHAZUL_MET"] == 1) IncrementFlag("COC.RATHAZUL_DAYS_KNOWN");
		if (flags["COC.RATHAZUL_IN_CAMP"] == 1) IncrementFlag("COC.RATHAZUL_DAYS_IN_CAMP");
	}
}
private var RathazulTimePassedNotifyHook: * = RathazulTimePassedNotifyGrapple();
private function RathazulTimePassedNotifyGrapple():* { timeChangeListeners.push(RathazulTimePassedNotify); }

// TODO: rewrite all that messy shit for good
public function encounterRathazul():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	if (flags["COC.RATHAZUL_BOUGHT"] == undefined) flags["COC.RATHAZUL_BOUGHT"] = 0;
	
	//if(flags["COC.MARBLE_PURIFICATION_STAGE"] == 2 && flags["COC.RATHAZUL_MET"] != undefined)
	//{
		//marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		//return;
	//}
	var offered:Boolean;
	//Rat is definitely not sexy!
	if (pc.lust() > 30) pc.lust( -10);
	//Introduction
	//output(images.showImage("rathazul-lake"));
	if(flags["COC.RATHAZUL_MET"] != undefined) {
		if(flags["COC.RATHAZUL_IN_CAMP"] == 1)
			output("You walk over to Rathazul's corner of the camp.  He seems as busy as usual, with his nose buried deep in some tome or alchemical creation, but he turns to face you as soon as you walk within a few paces of him.\n\n");
		else
			output("You spy the familiar sight of the alchemist Rathazul's camp along the lake.  The elderly rat seems to be oblivious to your presence as he scurries between his equipment, but you know him well enough to bet that he is entirely aware of your presence.\n\n");
	}
	else {
		output("You encounter a hunched figure working as you come around a large bush.  Clothed in tattered robes that obscure most his figure, you can nontheless see a rat-like muzzle protruding from the shadowy hood that conceals most of his form.  A simple glance behind him confirms your suspicions - this is some kind of rat-person.  He seems oblivious to your presence as he stirs a cauldron of viscous fluid with one hand; a neat stack of beakers and phials sit in the dirt to his left.  You see a smile break across his aged visage, and he says, \"<i>Come closer child.  I will not bite.</i>\"\n\nApprehensive of the dangers of this unknown land, you cautiously approach.\n\n\"<i>I am Rathazul the Alchemist.  Once I was famed for my miracle cures.  Now I idle by this lake, helpless to do anything but measure the increasing amounts of corruption that taint its waters,</i>\" he says as he pulls back his hood, revealing the entirety of his very bald and wrinkled head.\n\n");
		flags["COC.RATHAZUL_MET"] = 1;
	}
	//Camp offer!
	if (rathazulMoveToCampOffer()) return;
	rathazulWorkOffer();
}

private function rathazulMoveToCampOffer():Boolean {
	if (flags["COC.RATHAZUL_IN_CAMP"] != 1 && flags["COC.RATHAZUL_DAYS_KNOWN"] >= 3 && pc.cor() < 75) {
		clearMenu()
		output("\"<i>You know, I think I might be able to do this worn-out world a lot more good from your camp than by wandering around this lake.  What do you say?</i>\" asks the rat.\n\n(Move Rathazul into your camp? You are quite sure this is one-time offer.)");
		addButton(0, "Yes", rathazulMoveToCamp);
		addButton(1, "No", rathazulMoveDecline);
		return true;
	}
	return false;
}

private function rathazulMoveToCamp():void {
	clearOutput();
	output("Rathazul smiles happily back at you and begins packing up his equipment.  He mutters over his shoulder, \"<i>It will take me a while to get my equipment moved over, but you head on back and I'll see you within the hour.  Oh my, yes.</i>\"\n\nHe has the look of someone experiencing hope for the first time in a long time.");
	flags["COC.RATHAZUL_IN_CAMP"] = 1;
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function rathazulMoveDecline():void {
	clearOutput();
	flags["COC.RATHAZUL_IN_CAMP"] = -1;
	output("Rathazul wheezes out a sigh, and nods.\n\n\"<i>Perhaps I'll still be of some use out here after all,</i>\" he mutters as he packs up his camp and prepares to head to another spot along the lake.");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function campRathazul(first:Boolean = true):void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	if (flags["COC.RATHAZUL_IN_CAMP"] != 1) {
		encounterRathazul();
		return;
	}
	if (rathazulMoveToCampOffer()) return;
	//if(flags["COC.MARBLE_PURIFICATION_STAGE"] == 2)
	//{
		//marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		//return;
	//}
	if(flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + 24 * 60 < timeAsStamp && flags["COC.RATHAZUL_ARMOR_TYPE"] > 0) {
		collectRathazulArmor();
		return;
	}
	//Special rathazul/follower scenes scenes.
	//if(rand(6) == 0 && flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] == 0) {
		//flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] = 3;
		////Pure jojo
		//if(flags[kFLAGS.JOJO_RATHAZUL_INTERACTION_COUNTER] == 0 && pc.findStatusAffect(StatusAffects.PureCampJojo) >= 0 && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
			//finter.jojoOffersRathazulMeditation();
			//return;
		//}
		//if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			//finter.AmilyIntroducesSelfToRathazul();
			//return;
		//}
		//if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 1 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			//finter.amilyIngredientDelivery();
			//return;
		//}
		//if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 2 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			//finter.amilyAsksAboutRathazulsVillage();
			//return;
		//}
	//}
	//Rat is definitely not sexy!
	if(first) {
		if (pc.lust() > 50) pc.lust( -1);
		if (pc.lust() > 65) pc.lust( -5);
		if (pc.lust() > 80) pc.lust( -5);
		if (pc.lust() > 90) pc.lust( -5);
	}
	//Introduction
	//output(images.showImage("rathazul-camp"));
	output("Rathazul looks up from his equipment and gives you an uncertain smile.\n\n\"<i>Oh, don't mind me,</i>\" he says, \"<i>I'm just running some tests here.  Was there something you needed, [pc.name]?</i>\"\n\n");
	//pc.createStatusAffect(StatusAffects.metRathazul,0,0,0,0);
	rathazulWorkOffer();
}

private function rathazulWorkOffer():void {
	//spriteSelect(49);
	var totalOffers:int = 0;
	var spoken:Boolean = false;
	var showArmorMenu:Boolean = false;
	var purify:Boolean = false;
	var dyes:Boolean = false;
	var debimbo:Boolean = false;
	var reducto:Boolean = false;
	clearMenu();
	if(flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + 24 * 60 < timeAsStamp && flags["COC.RATHAZUL_ARMOR_TYPE"] > 0) {
		collectRathazulArmor();
		return;
	}
	//if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 1 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		//purificationByRathazulBegin();
		//return;
	//}
	if(pc.hasItemByName("BlackEg") || pc.hasItemByName("L.BlkEg")) {
		flags["COC.PC_KNOWS_ABOUT_BLACK_EGGS"] = 1;
		spoken = true;
		output("He eyes the onyx egg in your inventory and offers a little advice.  \"<i>Be careful with black eggs.  They can turn your skin to living latex or rubber.  The smaller ones are usually safer, but everyone reacts differently.  I'd get rid of them, if you want my opinion.</i>\"\n\n");
	}
	//Item crafting offer
	if(pc.hasItem(new CoCGreenGel())) {
		if(flags["COC.RATHAZUL_ARMOR"] == undefined) output("He pipes up with a bit of hope in his voice, \"<i>I can smell the essence of the tainted lake-slimes you've defeated, and if you'd let me, I could turn it into something a bit more useful to you.  You see, the slimes are filled with the tainted essence of the world-mother herself, and once the taint is burned away, the remaining substance remains very flexible but becomes nearly impossible to cut through.  With the gel of five defeated slimes I could craft you a durable suit of armor.</i>\"\n\n", false);
		else output("He pipes up with a bit of excitement in his voice, \"<i>With just five pieces of slime-gel I could make another suit of armor...</i>\"\n\n", false);
		spoken = true;
		if (pc.hasItem(new CoCGreenGel(), 5)) {
			showArmorMenu = true;
			totalOffers++;
		}
		else {
			output("You realize you're still a bit short of gel.\n\n", false);
		}
	}
	//Item crafting offer
	if(pc.hasItem(new CoCBlackChitin())) {
		output("The elderly rat looks at you intently and offers, \"<i>I see you've gathered a piece of chitin from the giant bees of the forests.  If you bring me five pieces I could probably craft it into some tough armor.</i>\"\n\n");
		spoken = true;
		if(pc.hasItem(new CoCBlackChitin(), 5)) {
			showArmorMenu = true;
			totalOffers++;
		}
		else {
			output("You realize you're still a bit short of chitin.\n\n");
		}
	}
	//SPOIDAH
	if (pc.hasItem(new CoCToughSpiderSilk()) && !(flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + flags["COC.RATHAZUL_ARMOR_TYPE"] > 0)) {
		showArmorMenu = true;
		spoken = true;
		totalOffers++;
		output("\"<i>Oooh, is that some webbing from a giant spider or spider-morph?  Most excellent!  With a little bit of alchemical treatment, it is possible I could loosen the fibers enough to weave them into something truly magnificent - armor, or even a marvelous robe,</i>\" offers Rathazul.\n\n");
	}
	//Dragonscale
	if (pc.hasItem(new CoCDragonScale())) {
		showArmorMenu = true;
		totalOffers++;
		output("\"<i>Oooh, is that dragon scale? If you happen to have five of these, I can work them into armor,</i>\" Rathazul says.\n\n");
	}
	//Marae bark armor
	if (pc.hasKeyItem("Tentacled Bark Plates") >= 0 || pc.hasKeyItem("Divine Bark Plates") >= 0) showArmorMenu = true;
	var pCounter:int = 0;
	//Item purification offer
	if (pc.hasItem(new CoCIncubiD()) 
		|| pc.hasItem(new CoCSucMilk()) 
		|| pc.hasItem(new CoCSucDelight()) 
		|| pc.hasItem(new CoCLaBova()) 
		|| pc.hasItem(new CoCMinotaurCum())) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	//Single Offer
	if(pCounter == 1) {
		output("The rat mentions, \"<i>I see you have tainted item on you... for 20 gems I could remove most of the taint, making it a good deal safer to use.  Of course, who knows what kind of freakish transformations it would cause...</i>\"\n\n", false);
		spoken = true;
		totalOffers++;
	}
	if(pCounter > 1) {
		output("The rat mentions, \"<i>I see you have a number of demonic items on your person.  For 20 gems I could attempt to remove the taint from one of them, rendering it a good deal safer for consumption.  Of course it would not remove most of the transformative properties of the item...</i>\"\n\n", false);
		spoken = true;
		totalOffers+=2;
	}
	//Offer dyes if offering something else.
	if(pc.credits >= 500) {
		output("Rathazul offers, \"<i>Since you have enough gems to cover the cost of materials for my dyes as well, you could buy one of my dyes for your hair.  ");
		if (flags["COC.RATHAZUL_DAYS_KNOWN"] >= 8) output("I should be able to make exotic-colored dyes if you're interested.  ");
		//output("Or if you want some changes to your skin, I have skin oils and body lotions.  I will need 50 gems.</i>\"");
		output("\n\n");
		spoken = true;
		totalOffers++;
		dyes = true;
	}
	//Bee honey
	if (pc.hasItemByName("BeeHoney")) {
		output("Rathazul offers, \"<i>If you're in need of a pure honey, I can distill the regular bee honey. You'll also need 25 gems.</i>\"\n\n");
	}
	//Pro Lactaid & Taurinum
	if (flags["COC.RATHAZUL_MET"] >= 5) {
		output("The rat mentions, \"<i>You know, I could make something new if you're willing to hand over two of vials labeled \"Equinum\", one vial of minotaur blood and one hundred gems. Or five bottles of Lactaid and two bottles of purified LaBova along with 250 gems.</i>\"\n\n");
	}
	//Reducto
	if(flags["COC.RATHAZUL_DAYS_IN_CAMP"] >= 4) {
		output("The rat hurries over to his supplies and produces a container of paste, looking rather proud of himself, \"<i>Good news everyone!  I've developed a paste you could use to shrink down any, ah, oversized body parts.  The materials are expensive though, so I'll need 100 gems for each jar of ointment you want.</i>\"\n\n");
		totalOffers++;
		spoken = true;
		reducto = true;
	}

	
	//Vines
	//if(pc.keyItemv1("Marae's Lethicite") > 0 && pc.findStatusAffect(StatusAffects.DefenseCanopy) < 0 && pc.findStatusAffect(StatusAffects.CampRathazul) >= 0) {
		//output("His eyes widen in something approaching shock when he sees the Lethicite crystal you took from Marae.  Rathazul stammers, \"<i>By the goddess... that's the largest piece of lethicite I've ever seen.  I don't know how you got it, but there is immense power in those crystals.  If you like, I know a way we could use its power to grow a canopy of thorny vines that would hide the camp and keep away imps.  Growing such a defense would use a third of that lethicite's power.</i>\"\n\n");
		//totalOffers++;
		//spoken = true;
		//lethiciteDefense = growLethiciteDefense;
	//}
	if(flags["COC.RATHAZUL_IN_CAMP"] > 0) {
		if(Flag("COC.RATHAZUL_DEBIMBO_OFFERED") == 0 && (pc.isBimbo(true) || pc.isBro(true)) /*(sophieBimbo.bimboSophie())*/) {
			rathazulDebimboOffer();
			return;
		}
		else if(Flag("COC.RATHAZUL_DEBIMBO_OFFERED") > 0) {
			output("You recall that Rathazul is willing to make something to cure bimbo effects for 250 gems and five Scholar's Teas.");
			if(pc.hasItem(new CoCScholarsTea(), 5) && pc.credits >= 2500) {
				totalOffers++;
				debimbo = true; 
			}
			else if(!pc.hasItem(new CoCScholarsTea(), 5)) output("  You should probably find some if you want that...");
			else output("  You need more gems to afford that, though.");
			output("\n\n");			
		}
		//Purification potion for Minerva
		//if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10 && pc.hasKeyItem("Rathazul's Purity Potion") < 0) {
			//output("The rodent alchemist suddenly looks at you in a questioning manner. \"<i>Have you had any luck finding those items? I need pure honey and at least two samples of other purifiers; your friend’s spring may grow the items you need.</i>\"");
			//output("\n\n");	
		//}
		//if (pc.hasItem(consumables.LACTAID, 5) && pc.hasItem(consumables.P_LBOVA, 2)) {
			//output("The rodent sniffs your possessions. \"<i>You know, I could make something with five bottles of Lactaid and two bottles of purified LaBova. I'll also need 250 gems.</i>\"");
			//output("\n\n");
		//}
	}
	
	if(totalOffers > 0) {
		output("Will you take him up on an offer or leave?");
	}
	
	//In camp has no time passage if left.
	if (showArmorMenu) addButton(0, "Armor", rathazulArmorMenu, null, "Armor", "Ask Rathazul to make an armour for you.");
	addButton(1, "Shop", rathShop, null, "Shop", "See what he can offer.");
	//if (dyes) {
		//addButton(1, "Buy Dye", buyDyes, null, "Buy Dye", "Ask him to make a dye for you. \n\nCost: 50 Gems.");
		//addButton(2, "Buy Oil", buyOils, null, "Buy Oil", "Ask him to make a skin oil for you. \n\nCost: 50 Gems.");
		//addButton(3, "Buy Lotion", buyLotions, null, "Buy Lotion", "Ask him to make a body lotion for you. \n\nCost: 50 Gems.");
	//}
	addButton(2, "Alchemy", rathPurify, null, "Alchemy", "Ask him to purify any tainted potions or make something from your ingridients. \n\nCost: 20 Gems.");
	
	if (debimbo > 0) addButton(5, "Debimbo", makeADeBimboDraft, null, "Debimbo", "Ask Rathazul to make a debimbofying potion for you. \n\nCost: 250 Gems \nNeeds 5 Scholar Teas.");
	//if (flags["COC.RATHAZUL_BOUGHT"] >= 5) addButton(7, "ProLactaid", rathazulMakesMilkPotion, null, null, null, "Ask him to brew a special lactation potion. \n\nCost: 250 Gems \nNeeds 5 Lactaids and 2 Purified LaBovas.");
	
	//if (lethiciteDefense != null) addButton(10, "Lethicite", lethiciteDefense, null, null, null, "Ask him if he can make use of that lethicite you've obtained from Marae.");
	//if (pc.hasItem(consumables.PURHONY, 1) && pc.hasItem(consumables.C__MINT, 1) && pc.hasItem(consumables.PURPEAC, 1) && pc.hasKeyItem("Rathazul's Purity Potion") < 0 &&(flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10)) {
		//addButton(11, "Pure Potion", rathazulMakesPurifyPotion, null, null, null, "Ask him to brew a purification potion for Minerva.");
	//}

	if(flags["COC.RATHAZUL_IN_CAMP"] > 0)
		addButton(14, "Leave", campFollowersMenu);
	else
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function rathShop():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Rathazul";
	shopkeep.keeperBuy = "What would you want to buy?\n\n";
	shopkeep.inventory = [];
	shopkeep.sellMarkup = 2;
	if (flags["COC.RATHAZUL_DAYS_IN_CAMP"] >= 4)
		shopkeep.inventory.push(new CoCReducto());
	shopkeep.inventory.push(new CoCDyeAuburn(), new CoCDyeBlack(), new CoCDyeBlond(), new CoCDyeBrown(), new CoCDyeRed(), new CoCDye(), new CoCDyeGray());
	if (flags["COC.RATHAZUL_DAYS_KNOWN"] >= 8)
		shopkeep.inventory.push(new CoCDyeBlue(), new CoCDyeGreen(), new CoCDyeOrange(), new CoCDyePurple(), new CoCDyePink());
	if (flags["COC.RATHAZUL_DAYS_KNOWN"] >= 12)
		shopkeep.inventory.push(new CoCDyeRainbow());
	shopkeepBackFunctor = campRathazul;
	buyItem();
}

public function rathPurify():void {
	clearOutput();
	clearMenu();
	output("Rathazul asks, \"<i>What would you like me to make?</i>\"\n");
	//if(pc.credits < 200) output("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"\n\n");
	
	addButton(14, "Back", campRathazul);
	
	function checkIngridients(arg:Object):Boolean {
		var ret:Boolean = true;
		output("\n	Gems x" + arg["gems"]);
		if (pc.credits < arg["gems"] * 10) ret = false;
		for (var key:* in arg) {
			if (key != "gems") {
				output("\n	" + key + " x" + arg[key]);
				if(!pc.hasItemByName(key, arg[key])) ret = false
			}
		}
		return ret;
	}
	
	var counter:int = 0;
	function add(from:Object, to:ItemSlotClass):void {
		output("\n" + to.longName + ":");
		if (checkIngridients(from))
			addButton(counter, to.shortName, rathPurifyGo, [from, to]);
		else
			addDisabledButton(counter, to.shortName);
		counter++;
	}
	
	add({ "IncubiD" : 1, "gems" : 20 }, new CoCIncubiDPure());
	add({ "SucMilk" : 1, "gems" : 20 }, new CoCSucMilkPure());
	add({ "S. Delight" : 1, "gems" : 20 }, new CoCSucDelightPure());
	add({ "LaBova" : 1, "gems" : 20 }, new CoCLaBovaPure());
	add({ "MinoCum" : 1, "gems" : 20 }, new CoCMinotaurCumPure());
	add({ "BeeHony" : 1, "gems" : 25 }, new CoCBeeHoneyPure());
	
	if (flags["COC.RATHAZUL_DAYS_KNOWN"] >= 5)
		add({ "MinoBlo" : 1, "Equinum" : 2, "gems" : 100 }, new CoCTaurinum());
}

public function rathPurifyGo(args:/*ItemSlotClass*/Array):void {
	var from:Object = args[0];
	var to:ItemSlotClass = args[1];
	
	pc.credits -= 20 * 10;
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	clearOutput();
	output("It should be much safer now, but still, be careful...\n\n");
	
	for (var key:* in from) {
		if (key != "gems") {
			pc.credits -= from[key] * 10;
		} else {
			pc.destroyItemByName(key, from[key]);
		}
	}
	
	processTime(5 + rand(5));

	itemScreen = rathPurify;
	lootScreen = rathPurify;
	useItemFunction = rathPurify;
	itemCollect([to]);
}

//For Minerva purification.
public function purificationByRathazulBegin():void {
	output("Hoping the rodent-morph alchemist can assist you, you waste no time in approaching him. Rathazul looks up when he sees you, raising an eye curiously. \"<i>Is something the matter, " + pc.short + "?</i>\"");
	output("\n\nYou nod, and ask him if he knows anything about either killing pests or purifying the corruption from people as well as objects. At his bemused expression, you explain about Minerva and her conditions, repeating your query if he could possibly help you. Rathazul looks downcast and shakes his head.");

	output("\n\n\"<i>I am afraid that I have never truly succeeded in my efforts to create a potion to purify the corrupted themselves.</i>\" The rat alchemist explains sadly. \"<i>The problem is there is very little, if anything, in this world that is capable of removing corruption from a consumer... But, I do have a theoretical recipe. If you can just find me some foodstuffs that would lower corruption and soothe the libido, and bring them to me, then I might be able to complete it. I can suggest pure giant bee honey as one, but I need at least two other items that can perform at least one of those effects. You said that the spring was able to keep your friend's corruption in check? Maybe some of the plants that grow there would be viable; bring me some samples, and a fresh dose of pure honey, and we’ll see what I can do.</i>\" He proclaims, managing to shake off his old depression and sound determined.");

	output("\n\nWith that in mind, you walk away from him; gathering the items that could cure Minerva is your responsibility.");
	flags["COC.MINERVA_PURIFICATION_RATHAZUL_TALKED"] = 2;
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function rathazulMakesPurifyPotion():void {
	clearOutput();
	//pc.destroyItem(consumables.PURHONY, 1);
	//pc.destroyItem(consumables.C__MINT, 1);
	//pc.destroyItem(consumables.PURPEAC, 1);
	output("You hurry over to Rathazul, and tell him you have the items you think he needs. His eyes widen in shock as you show them to him, and he immediately snatches them from you without a word, hurrying over to his alchemical equipment. You watch, uncertain of what he’s doing, as he messes around with it, but within minutes he has produced a strange-looking potion that he brings back to you.");

	output("\n\n\"<i>Have her swallow this, and it should kill the parasite within her at the very least.</i>\"");

	output("\n\nYou take it gratefully, but can’t help asking what he means by ‘should’.");

	output("\n\nRathazul shrugs helplessly. \"<i>This formula is untested; its effects are unpredictable... But, surely it cannot make things worse?</i>\"");

	output("\n\nYou concede he has a point and take the potion; all you need to do now is give it to Minerva and hope for the best.");
	pc.createKeyItem("Rathazul's Purity Potion", 0, 0, 0, 0);
	clearMenu();
	addButton(0, "Next", campRathazul);
}

private function rathazulDebimboOffer():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	if(IncrementFlag("COC.RATHAZUL_DEBIMBO_OFFERED") == 1) {
		//if(sophieBimbo.bimboSophie()) {
			//output("Rathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me, [pc.name], do you truly enjoy having that vacuous idiot around, lusting after you at all hours of the day?</i>\" he asks, shaking his head in frustration.  \"<i>She's clearly been subjected to the effects of Bimbo Liqueur, which as you can plainly see are quite indeed potent.  However, like most things in Mareth, it can be countered - at least partially.</i>\"  Rathazul folds his long, clawed fingers together, his tail lashing behind him as he thinks.  \"<i>Perhaps with a sufficient quantity of something called Scholar's Tea... I could counter the stupefying effects of the elixir... oh my, yes... hmm...</i>\"  Rathazul nods, stroking at the few long wisps of fur that hang from his chin.");
			//output("\n\nYou await");
			//if (silly) output(" getGoodPost()"); // C# await joke ;_; http://msdn.microsoft.com/en-gb/library/hh156528.aspx
			//output(" further clarification, but the old rat just stands there, staring off into space.  Coughing politely, you reacquire his attention, causing him to jump.");
			//output("\n\n\"<i>Oh?  Nmm, YES, bimbos, that's right!  As I was saying, five Scholar's Teas along with 250 gems for other reagents should give me all I need to create a bimbo-beating brew!  Oh my, the alliteration!  How absurd.</i>\"  Rathazul chuckles slowly, wiping a drop from his eye before he looks back at you fiercely, \"<i>It is a worthwhile goal - no creature should be subjected to a reduced intellect.  Let me know when you have acquired what is needed.</i>\"");
		//}
		//else {
			//Notification if the PC is the one bimbo'ed*
			if (pc.isBimbo(true)) {
				output("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me [pc.name], do you truly enjoy living your life under the debilitating effects of that cursed potion?  Even now the spark of intelligence has all but left from your eyes.  Do you even understand what I'm saying?</i>\"");
				output("\n\nYou twirl a lock of hair around your finger and giggle.  This silly old rat thinks you're like, dumb and stuff!  He just doesn't know how great it is to have a rocking body and a sex-drive that's always ready to suck and fuck.  It's so much fun!  You look back at the rat, realizing you haven't answered him yet, feeling a bit embarrassed as he sighs in disappointment.");
				output("\n\n\"<i>Child, please... bring me five Scholar's Teas and 250 gems for reagents, then I can fix you!  I can help you!  Just... get the tea!</i>\" the alchemist pleads, counting off to five on his clawed fingers for extra emphasis while shaking his gem pouch profusely.  You bite your lower lip— he seems really really mad about this or something.  Maybe you should like, get the tea?");
			}
			else if (pc.isBro(true)) {
				output("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>I see you happen to have drank a can of Bro Brew in the past. If you ever need me to restore your intelligence capabilities, bring me five scholar teas and 250 gems. Thanks Marae you're not a bimbo; that would have been worse.</i>\"");
			}
		//}
	}
	//Rath menu
	addButton(0, "Next", campRathazul);
}

//Creation Of The Draft:*
private function makeADeBimboDraft():void {
	clearOutput();
	//spriteSelect(49);
	output("Rathazul takes the teas and the gems into his wizened palms, shuffling the glittering jewels into a pouch and the teas into a large decanter.  He promptly sets the combined brews atop a flame and shuffles over to his workbench, where he picks up numerous pouches and vials of every color and description, adding them to the mix one after the other.  The mixture roils and bubbles atop the open flame like a monstrous, eerie thing, but quickly simmers down to a quiet boil.  Rathazul leaves it going for a while, stirring occasionally as he pulls out a smaller vial.  Once most of the excess liquid has evaporated, he pours the concoction into the glass container and corks it, holding it up to the light to check its coloration.");
	output("\n\n\"<i>That <b>should</b> do,</i>\" he mutters to himself.  Rathazul turns, carefully handing you the mixture.  \"<i>This should counter the mental-inhibiting effects of the Bimbo Liqueur, but I have no idea to what extent those who imbibe it will retain of their time spent as a bimbo...</i>\"\n\n");
	//Take items
	pc.credits -= 2500;
	pc.destroyItem(new CoCScholarsTea(), 5);
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	itemScreen = campRathazul;
	lootScreen = campRathazul;
	useItemFunction = campRathazul;
	itemCollect([new CoCDeBimbo()]);
}
	
public function rathazulArmorMenu():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	output("Which armor project would you like to pursue with Rathazul?");
	
	if(pc.hasItem(new CoCGreenGel(), 5)) {
		addOverrideItemButton(0, new CoCGelArmor(), "GelArmor", craftOozeArmor);
	} else 
		addDisabledButton(0, "GelArmor", "Gel Armor", "You need 5 portions of green gel to make this armor.");
	
	if(pc.hasItem(new CoCBlackChitin(), 5)) {
		addOverrideItemButton(1, new CoCBeeArmor(), "BeeArmor", craftCarapace);
	} else 
		addDisabledButton(1, "BeeArmor", "Bee Armor", "You need 5 chitin plates to make this armor.");
	
	if(pc.hasItem(new CoCToughSpiderSilk(), 5) && !(flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] + flags["COC.RATHAZUL_ARMOR_TYPE"] > 0)) {
		addButton(2, "SpiderSilk", craftSilkArmor);
	} else 
		addDisabledButton(2, "SpiderSilk", "Spider Silk", "You need 5 bundles of top-quality spider silk for this.");
		
	if(pc.hasItem(new CoCDragonScale(), 5)) {
		addButton(3, "Dragonscale", craftDragonscaleArmor);
	} else 
		addDisabledButton(3, "Dragonscale", "Dragonscale", "You need 5 dragon scales for this.");
		
	//if (pc.hasKeyItem("Tentacled Bark Plates") >= 0) {
		//addButton(5, "T.Bark Armor", craftMaraeArmor, false);
	//}
	//if (pc.hasKeyItem("Divine Bark Plates") >= 0) {
		//addButton(6, "D.Bark Armor", craftMaraeArmor, true);
	//}
	addButton(14, "Back", campRathazul, false);
}

private function craftSilkArmor():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	output("You hand the bundled webbing to Rathazul carefully, lest you damage the elderly mouse.  He gives you a bemused smile and snatches the stuff from your grasp while he mutters, \"<i>I'm not falling apart you know.</i>\"\n\n", false);
	//(Not enough webs: 
	if(!pc.hasItem(new CoCToughSpiderSilk(), 5)) {
		output("The rat shakes his head and hands it back to you.  \"<i>This isn't enough for me to make anything with.  I'll need at least five bundles of this stuff total, so you'll need to find more,</i>\" he explains.\n\n", false);
		//(optional spider bonus: 
		if(pc.hasTail(GLOBAL.TYPE_ARACHNID)) {
			output("You show him your spider-like abdomen in response, offering to produce more webbing for him.  Rathazul chuckles dryly, a sound that reminds you of hot wind rushing through a dead valley.  \"<i>Dear child, this would never do.  Silk this tough can only be produced by a true-born spider.  No matter how you change yourself, you'll always be a human at heart.</i>\"\n\n", false);
			output("The old rat shakes his head and adds, \"<i>Well, now that I think about it, the venom of a red widow might be able to transform you until you are a spider to the core, but I have absolutely no idea what that would do to you.  If you ever try such a dangerous, reckless idea, let me know.  I want to have my notebooks handy, for SCIENCE!</i>\"\n\n", false);
		}
		//if (pc.hasItem(new CoCToughSpiderSilk(), 2)) {
			//output("\"<i>But this should be enough for undergarments if you want,</i>\" Rathazul adds.");
			//doYesNo(commissionSilkArmorForReal,declineSilkArmorCommish);
			//return;
		//}
		doNext(campRathazul, false);
		return;
	}
	output("The rat limps over to his equipment, spider-silk in hand.  With efficient, practiced motions, he runs a few tests.  As he finishes, he sighs and explains, \"<i>This will be harder than I thought.  The webbing is highly resistant to most of my alchemic reagents.  To even begin to work with such material I will need a number of rare, expensive elements.  I would need 500 gems to even start such a project.</i>\"\n\n", false);
	output("You can't help but sigh when he names such a sizable figure.  Do you give him the 500 gems and spider-silk in order for him to create you a garment?", false);
	if(pc.credits < 5000) {
		output("  <b>Wait... you don't even have 500 gems.  Damn.</b>", false);
		doNext(campRathazul, false);
		return;
	}
	//[Yes] [No]
	clearMenu();
	addButton(0, "Yes", commissionSilkArmorForReal);
	addButton(1, "No", declineSilkArmorCommish);
}

private function commissionSilkArmorForReal():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	output("You sort 500 gems into a pouch and toss them to Rathazul, along with the rest of the webbing.  The wizened alchemist snaps the items out of the air with lightning-fast movements and goes to work immediately.  He bustles about with enormous energy, invigorated by the challenging task before him.  It seems Rathazul has completely forgotten about you, but as you turn to leave, he calls out, \"<i>What did you want me to make?  A mage's robe or some nigh-impenetrable armor?  Or undergarments if you want.</i>\"\n\n");
	
	if (pc.hasItem(new CoCToughSpiderSilk(), 5)) {
		addOverrideItemButton(0, new CoCSpiderSilkArmor(), "Armor", chooseArmorOrRobes, 1);
		addOverrideItemButton(1, new CoCSpiderSilkRobes(), "Robes", chooseArmorOrRobes, 2);
	}
	//addButton(2, "Bra", chooseArmorOrRobes, 3, null, null, undergarments.SS_BRA.description);
	//addButton(3, "Panties", chooseArmorOrRobes, 4, null, null, undergarments.SSPANTY.description);
	//addButton(4, "Loincloth", chooseArmorOrRobes, 5, null, null, undergarments.SS_LOIN.description);
	addButton(14, "Back", declineSilkArmorCommish);
}

private function declineSilkArmorCommish():void {
	//spriteSelect(49);
	clearOutput();
	output("You take the silk back from Rathazul and let him know that you can't spend 500 gems on a project like that right now.  He sighs, giving you a crestfallen look and a slight nod of his hooded muzzle.");
	clearMenu();
	addButton(0, "Next", campRathazul, false);
}

public function chooseArmorOrRobes(robeType:int):void {
	clearOutput();
	//spriteSelect(49);
	if (robeType == 1 || robeType == 2) { //Armor or robes
		pc.destroyItem(new CoCToughSpiderSilk(), 5);
	}
	else { //Undergarments
		pc.destroyItem(new CoCToughSpiderSilk(), 2);
	}
	pc.credits -= 5000;
	output("Rathazul grunts in response and goes back to work.  ");
	if (flags["COC.RATHAZUL_IN_CAMP"] == 1)
	{
		output("You turn back to the center of your camp");
	}
	else
	{
		output("You head back to your camp");
	}
	output(", wondering if the old rodent will actually deliver the wondrous item that he's promised you.");
	flags["COC.RATHAZUL_ARMOR_TYPE"] = robeType;
	flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] = timeAsStamp;
	trace("274: " + flags["COC.RATHAZUL_ARMOR_COUNTDOWN"]);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function collectRathazulArmor():void {
	//spriteSelect(49);
	clearOutput();
	
	output("Rathazul beams and ejaculates, \"<i>Good news everyone!  Your ");
	if(flags["COC.RATHAZUL_ARMOR_TYPE"] == 1) output("armor");
	else if (flags["COC.RATHAZUL_ARMOR_TYPE"] == 2) output("robe");
	else output("undergarment");
	output(" is finished!</i>\"\n\n");
	
	var itype:ItemSlotClass;
	switch(flags["COC.RATHAZUL_ARMOR_TYPE"]) {
		case 1: //Armor
			//output(images.showImage("rathazul-craft-silkarmor"));
			output("A glittering white suit of armor sits atop a crude armor rack, reflecting the light that plays across its surface beautifully.  You definitely didn't expect anything like this!  It looks nearly identical to a set of light platemail, though instead of having a cold metal surface, the armor feels slightly spongy, with just a little bit of give in it.\n\n");
			
			output("While you marvel at the strange equipment, Rathazul explains, \"<i>When you said you wanted armor, I realized I could skip a few of the alchemical processes used to soften material.  The savings let me acquire a cheap metal set of armor to use as a base, and I molded half the armor around each piece, then removed it and created the outer, defensive layers with the rest of the webbing.  Unfortunately, I didn't have enough silk for a solid codpiece, but I did manage to make a you thin loincloth from the leftover scraps  - for modesty.</i>\"\n\n");
			itype = new CoCSpiderSilkArmor();
			break;
		case 2: //Robes
			//output(images.showImage("rathazul-craft-silkrobes"));
			output("Hanging from a small rack is a long, flowing robe.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  There's a hood with a golden border embroidered around the edge.  For now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer's eyes from harsh sunlight or rainy drizzle.  The sleeves match the cowl, circled with intricate threads laid out in arcane patterns.\n\n");
			
			output("Rathazul gingerly takes down the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  This robe is tougher than many armors, and the spider-silk's properties may even help you in your spell-casting as well.</i>\"\n\n");
			itype = new CoCSpiderSilkRobes();
			break;
		//case 3: //Bra
			//output(images.showImage("rathazul-craft-silkbra"));
			//output("On a table is a pair of white bra.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			//
			//output("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  These bras are very durable and should be comfortable as well.</i>\"\n\n", false);
			//itype = undergarments.SS_BRA;
			//break;
		//case 4: //Panties
			//output(images.showImage("rathazul-craft-silkpanties"));
			//output("On a table is a pair of white panties.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			//
			//output("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  These panties are very durable and should be comfortable as well.</i>\"\n\n", false);
			//itype = undergarments.SSPANTY;
			//break;
		//case 5: //Loincloth
			//output(images.showImage("rathazul-craft-silkloincloth"));
			//output("On a table is a white loincloth.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			//
			//output("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  This loincloth is very durable and should be comfortable as well.</i>\"\n\n", false);
			//itype = undergarments.SS_LOIN;
			//break;
		default:
			output("Something bugged!");
			itype = new CoCSpiderSilkRobes();
	}
	//Reset counters
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	flags["COC.RATHAZUL_ARMOR_TYPE"] = 0;
	flags["COC.RATHAZUL_ARMOR_COUNTDOWN"] = 0;

	itemScreen = campRathazul;
	lootScreen = campRathazul;
	useItemFunction = campRathazul;
	itemCollect([itype]);
}

private function craftOozeArmor():void {
	//spriteSelect(49);
	clearOutput();
	clearMenu();
	//output(images.showImage("rathazul-craft-gelarmor"));
	output("Rathazul takes the green gel from you and drops it into an empty cauldron.  With speed well beyond what you'd expect from such an elderly creature, he nimbly unstops a number of vials and pours them into the cauldron.  He lets the mixture come to a boil, readying a simple humanoid-shaped mold from what you had thought was piles of junk material.  In no time at all, he has cast the boiling liquid into the mold, and after a few more minutes he cracks it open, revealing a suit of glistening armor.\n\n");
	
	pc.destroyItem(new CoCGreenGel(), 5);
	
	if (flags["COC.RATHAZUL_ARMOR"] == undefined) flags["COC.RATHAZUL_ARMOR"] = 1;
	processTime(60 + rand(30));
		
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	itemScreen = campRathazul;
	lootScreen = campRathazul;
	useItemFunction = campRathazul;
	itemCollect([new CoCGelArmor()]);
}

private function craftCarapace():void {
	//spriteSelect(49);
	clearOutput();
	//output(images.showImage("rathazul-craft-chitinarmor"));
	output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the armor.  ");
	output("The plates shine and shimmer like black steel.  He has used the yellow chitin to add accents and embroidery to the plates with a level of detail and craftsmanship rarely seen back home. A yellow fur neck lining has been fashioned from hairs found on the pieces.  The armor includes a breastplate, shoulder guards, full arm guards, and knee high boots");
	if (!pc.isBiped()) {
		output(" which are not really useful for you now. You notice there are no pants. \"<i>I'm sorry, but I have no idea how to make something to fit your body. And, since I've never seen a ");
		if (pc.isTaur() || pc.isDrider()) output("taur");
		else if (pc.isNaga()) output("naga");
		else if (pc.isGoo()) output("goo");
		output(" in pants, I'm not only one. Never seen bothered one, though.</i>\"");
	}
	else
	{
		output(".  You notice there are no pants.  As you turn to ask him where the pants are, you see him scratching his head and hastily rustling in drawers.  He mutters under his breath, \"<i>I'm sorry, I'm sorry, I got so focused on working on the pauldrons that I forgot to make any leg coverings!  Here, this should look good with it, and it won't restrict your movements.</i>\"  He hands you a silken loincloth");
		if (pc.mf("m", "f") == "f") output(" with stockings and garters");
		output(".");
	}
	output("  He still manages to look somewhat pleased with himself in spite of the blunder, even bragging a little bit, ");
	output("\"<i>Let me show you the different lengths of string I used.</i>\"\n\n");
	if((pc.longestCockLength() >= 16 && !pc.hasFullSheaths() || pc.balls > 0 && pc.ballSize() > 20) && !pc.hasStatusEffect("Genital Slit")) output("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n");
	if(pc.biggestTitSize() >= 8) output("Your [pc.fullChest] barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n");
	
	pc.destroyItem(new CoCBlackChitin(), 5);
	
	processTime(100 + rand(40));
			
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	itemScreen = campRathazul;
	lootScreen = campRathazul;
	useItemFunction = campRathazul;
	itemCollect([new CoCBeeArmor()]);
}

private function craftDragonscaleArmor():void {
	//spriteSelect(49);
	clearOutput();
	output("The rat looks at the sheets of dragon scales you're carrying and says, \"<i>I could work these into armor. Or if you want, undergarments. I have the necessary supplies.</i>\"");
	clearMenu();
	if (pc.hasItem(new CoCDragonScale(), 5)) {
		addOverrideItemButton(0, new CoCDragonScaleArmor(), "Armor", craftDragonscaleArmorForReal, 1);
		addOverrideItemButton(1, new CoCDragonScaleRobes(), "Robes", craftDragonscaleArmorForReal, 2);
	}
	//else output("\n\nYou realize you're still a bit short on dragonscales for the armor but you can have undergarments made instead.");
	//addButton(2, "Bra", craftDragonscaleArmorForReal, 3, null, null, undergarments.DS_BRA.description);
	//addButton(3, "Thong", craftDragonscaleArmorForReal, 4, null, null, undergarments.DSTHONG.description);
	//addButton(4, "Loincloth", craftDragonscaleArmorForReal, 5, null, null, undergarments.DS_LOIN.description);
	addButton(14, "Nevermind", rathazulArmorMenu);
}
private function craftDragonscaleArmorForReal(type:int = 0):void {
	//spriteSelect(49);
	if (type == 1 || type == 2) { //Armor or robes
		pc.destroyItem(new CoCDragonScale(), 5);
	}
	else { //Undergarments
		pc.destroyItem(new CoCDragonScale(), 2);
	}
	clearOutput();
	var itype:ItemSlotClass;
	switch(type) {
		case 1: //Armor
			//output(images.showImage("rathazul-craft-dragonscalearmor"));
			output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the armor.  ");
			output("The armor is red and the breastplate has nicely decorated pauldrons to give an imposing looks. You touch the armor and feel the scaly texture. \"<i>It's quite flexible and should offer very good protection,</i>\" Rathazul says.");
			itype = new CoCDragonScaleArmor();
			break;
		case 2: //Robes
			//output(images.showImage("rathazul-craft-dragonscalerobes"));
			output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the robes.  ");
			output("The robe is red and appears to be textured with scales.  You touch the robes and feel the scaly texture. \"<i>It's quite flexible and should offer very good protection,</i>\" Rathazul says.");
			itype = new CoCDragonScaleRobes();
			break;
		//case 3: //Bra
			//output(images.showImage("rathazul-craft-dragonscalebra"));
			//output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the bra.  ");
			//output("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			//itype = undergarments.DS_BRA;
			//break;
		//case 4: //Thong
			//output(images.showImage("rathazul-craft-dragonscalethong"));
			//output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the thong.  ");
			//output("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			//itype = undergarments.DSTHONG;
			//break;
		//case 5: //Loincloth
			//output(images.showImage("rathazul-craft-dragonscaleloincloth"));
			//output("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the loincloth.  ");
			//output("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			//itype = undergarments.DS_LOIN;
			//break;
		default:
			output("Something bugged!");
			itype = new CoCDragonScaleRobes();
			break;
	}
	IncrementFlag("COC.RATHAZUL_BOUGHT");
	processTime(50 + rand(20));
	itemScreen = campRathazul;
	lootScreen = campRathazul;
	useItemFunction = campRathazul;
	itemCollect([itype]);
}

//private function craftMaraeArmor(divine:Boolean = false):void {
	//clearOutput();
	//if (!divine) {
		//output(images.showImage("rathazul-craft-barkarmor-corrupt"));
		//output("You show him the pieces of thick bark with tentacles attached. \n\n \"<i>My, my. That's definitely the strangest thing I've ever seen. But as you've requested, I'll make armor for you,</i>\" the old rat says. He takes the pile of bark, taking care to avoid touching the still-alive tentacles. He works on his bench for an hour while you wait. \n\n")
		//output("Once he has finished, Ratzhul is beaming with both pride and shame, \"<i>I think you'll be pleased. Go ahead and take a look. I'm not working on this type of armor again. I nearly got surprised by tentacles.</i>\"\n\nHe hands you the armor. \n\n", false)
		//output("The plates are white like snow. Green tentacles grow from the shoulderpads. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots. You realize the armor is missing pants. \n\n", false);
		//output("\"<i>Something wrong? Nothing to protect your modesty? Surprise!</i>\"  He hands you a silken loincloth", false);
		//if(pc.mf("m", "f") == "f") output(" with stockings and garters", false);
		//output(". You thank him for the armor.\n\n", false)
		//if(pc.cockTotal() > 0 && pc.biggestCockArea() >= 40) output("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n", false);
		//if(pc.biggestTitSize() >= 8) output("Your " + biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n", false);
		//pc.removeKeyItem("Tentacled Bark Plates");
		//inventory.takeItem(armors.TBARMOR, returnToRathazulMenu);
	//}
	//else {
		//output(images.showImage("rathazul-craft-barkarmor-pure"));
		//output("You show him the pieces of glowing white thick bark attached. \n\n \"<i>My, my. I heard a voice from Marae instructing me to make the armor for you,</i>\" the old rat says. He takes the pile of bark and works on his bench for an hour while you wait. \n\n")
		//output("Once he has finished, Ratzhul is beaming with both pride and shame, \"<i>I think you'll be pleased. Go ahead and take a look. I'm not working on this type of armor again. It took me many attempts to bend the bark plates to get them right.</i>\"\n\nHe hands you the armor. \n\n", false)
		//output("The plates are white like snow. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots. You notice there are no pants.  As you turn to ask him where the pants are, you see him scratching his head and hastily rustling in drawers.  He mutters under his breath, \"<i>I'm sorry, I'm sorry, I got so focused on working on the pauldrons that I forgot to make any leg coverings!  Here, this should look good with it, and it won't restrict your movements.</i>\"  He hands you a silken loincloth", false);
		//if (pc.mf("m", "f") == "f") output(" with stockings and garters", false);
		//output(".  He still manages to look somewhat pleased with himself in spite of the blunder, even bragging a little bit, \"<i>Let me show you the different lengths of string I used.</i>\"\n\n", false);
		//if(pc.cockTotal() > 0 && pc.biggestCockArea() >= 40) output("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n", false);
		//if(pc.biggestTitSize() >= 8) output("Your " + biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n", false);
		//pc.removeKeyItem("Divine Bark Plates");
		//inventory.takeItem(armors.DBARMOR, returnToRathazulMenu);
	//}
//}

////Skin Oils
//private function buyOils():void {
	////spriteSelect(49);
	//clearOutput();
	//output("Rathazul smiles and pulls forth several bottles of skin oil.  Which type of skin oil would you like?");
	//output("\n\n<b>(-50 Gems)</b>");
	//pc.gems -= 50;
	//statScreenRefresh();
	//menu();
	//addButton(0, "Dark", buyOil, consumables.DARK_OL);
	//addButton(1, "Ebony", buyOil, consumables.EBONYOL);
	//addButton(2, "Fair", buyOil, consumables.FAIR_OL);
	//addButton(3, "Light", buyOil, consumables.LIGHTOL);
	//addButton(4, "Mahogany", buyOil, consumables.MAHOGOL);
	//addButton(5, "Olive", buyOil, consumables.OLIVEOL);
	//addButton(6, "Russet", buyOil, consumables.RUSS_OL);
	//addButton(14, "Nevermind", buyOilNevermind);
//}
//
//private function buyOil(oil:ItemType):void {
	////spriteSelect(49);
	//clearOutput();
	//output(images.showImage("rathazul-buy-oil"));
	//inventory.takeItem(oil, returnToRathazulMenu);
	//statScreenRefresh();
	//pc.addStatusValue(StatusAffects.MetRathazul, 2, 1);
//}
//
//private function buyOilNevermind():void {
	////spriteSelect(49);
	//clearOutput();
	//output("You change your mind about the oil, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	//pc.gems += 50;
	//statScreenRefresh();
	//doNext(returnToRathazulMenu);
//}
//
////Body Lotions
//private function buyLotions():void {
	////spriteSelect(49);
	//clearOutput();
	//output("Rathazul smiles and pulls forth several vials of body lotion.  Which type of body lotion would you like?");
	//output("\n\n<b>(-50 Gems)</b>");
	//pc.gems -= 50;
	//statScreenRefresh();
	//menu();
	//addButton(0, "Clear", buyLotion, consumables.CLEARLN);
	//addButton(1, "Rough", buyLotion, consumables.ROUGHLN);
	//addButton(2, "Sexy", buyLotion, consumables.SEXY_LN);
	//addButton(3, "Smooth", buyLotion, consumables.SMTH_LN);
	//addButton(14, "Nevermind", buyLotionNevermind);
//}
//
//private function buyLotion(lotion:ItemType):void {
	////spriteSelect(49);
	//clearOutput();
	//output(images.showImage("rathazul-buy-lotion"));
	//inventory.takeItem(lotion, returnToRathazulMenu);
	//statScreenRefresh();
	//pc.addStatusValue(StatusAffects.MetRathazul, 2, 1);
//}
//
//private function buyLotionNevermind():void {
	////spriteSelect(49);
	//clearOutput();
	//output("You change your mind about the lotion, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	//pc.gems += 50;
	//statScreenRefresh();
	//doNext(returnToRathazulMenu);
//}
//
////Turn several ingredients into a special potion/consumable.
//private function rathazulMakesPureHoney():void {
	//clearOutput();
	//if (pc.gems < 25) {
		//output("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		//doNext(returnToRathazulMenu);
		//return;
	//}
	//pc.destroyItem(consumables.BEEHONY, 1);
	//pc.gems -= 25;
	//statScreenRefresh();
	//output("You hand over a vial of bee honey and the 25 gems.");
	//output("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the bee honey and begin brewing something. ");
	//output("\n\nA few minutes later, he comes back with the crystal vial that contains glittering liquid.  \"<i>It's ready. The honey should be pure now,</i>\" he says. He hands you over the vial of honey and goes back to working.  ");
	//inventory.takeItem(consumables.PURHONY, returnToRathazulMenu);
//}
//
//private function rathazulMakesMilkPotion():void {
	//clearOutput();
	//if (pc.gems < 250) {
		//output("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		//doNext(returnToRathazulMenu);
		//return;
	//}
	//else if (!(pc.hasItem(consumables.LACTAID, 5) && pc.hasItem(consumables.P_LBOVA, 2))) {
		//output("\"<i>I'm sorry but you don't have the materials I need. I need five bottles of Lactaid and two bottles of purified LaBova,</i>\" Rathazul says.");
		//doNext(returnToRathazulMenu);
		//return;
	//}
	//pc.destroyItem(consumables.LACTAID, 5);
	//pc.destroyItem(consumables.P_LBOVA, 2);
	//pc.gems -= 250;
	//statScreenRefresh();
	//output("You hand over the ingredients and 250 gems.");
	//output("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the ingredients and begin brewing something. ");
	//output("\n\nA few minutes later, he comes back with the potion.  \"<i>It's ready. If you have some issues with lactation or you want to produce milk forever, drink this. Keep in mind that it might be irreversible,</i>\" he says. He hands you over the potion and goes back to working.  ");
	//inventory.takeItem(consumables.MILKPTN, returnToRathazulMenu);
//}
//
//private function rathazulMakesTaurPotion():void {
	////spriteSelect(49);
	//clearOutput();
	//if (pc.gems < 100) {
		//output("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		//doNext(returnToRathazulMenu);
		//return;
	//}
	//else if (!(pc.hasItem(consumables.EQUINUM, 2) && pc.hasItem(consumables.MINOBLO, 1))) {
		//output("\"<i>I'm sorry but you don't have the materials I need. I need two vials of Equinum and one vial of minotaur blood,</i>\" Rathazul says.");
		//doNext(returnToRathazulMenu);
		//return;
	//}
	//pc.destroyItem(consumables.EQUINUM, 2);
	//pc.destroyItem(consumables.MINOBLO, 1);
	//pc.gems -= 100;
	//statScreenRefresh();
	//output("You hand over two vials of Equinum, one vial of Minotaur Blood and one hundred gems to Rathazul, which he gingerly takes them and proceeds to make a special potion for you.");
	//output("\n\nAfter a while, the rat hands you a vial labeled \"Taurinum\" and nods.");
	//pc.addStatusValue(StatusAffects.MetRathazul, 2, 1);
	//inventory.takeItem(consumables.TAURICO, returnToRathazulMenu);
//}

private function buyReducto():void {
	//spriteSelect(49);
	clearOutput();
	var cost:int = (flags["COC.AMILY_MET_RATHAZUL"] >= 2 ? 500 : 1000);
	if (pc.credits >= cost) {
		//output(images.showImage("rathazul-buy-reducto"));
		output("Rathazul hands you the Reducto with a nod before returning to his work.\n\n");
		pc.credits -= cost;
		
		IncrementFlag("COC.RATHAZUL_BOUGHT");
		itemScreen = campRathazul;
		lootScreen = campRathazul;
		useItemFunction = campRathazul;
		itemCollect([new CoCReducto()]);
	}
	else {
		output("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.");
		doNext(campRathazul, false);
	}
}

//private function growLethiciteDefense():void {
	////spriteSelect(49);
	//clearOutput();
	//output("Rathazul asks, \"<i>Are you absolutely sure?  Growing this thorn canopy as a defense will use one third of the crystal's power.</i>\"\n\n(Do you have Rathazul use the crystal to grow a defensive canopy?)");
	//doYesNo(growLethiciteDefenseYesYesYes, growLethiciteDefenseGuessNot);
//}
//
//private function growLethiciteDefenseYesYesYes():void {
	////spriteSelect(49);
	//clearOutput();
	//output("Rathazul nods and produces a mallet and chisel from his robes.  With surprisingly steady hands for one so old, he holds the chisel against the crystal and taps it, easily cracking off a large shard.  Rathazul gathers it into his hands before slamming it down into the dirt, until only the smallest tip of the crystal is visible.  He produces vials of various substances from his robe, as if by magic, and begins pouring them over the crystal.  In a few seconds, he finishes, and runs back towards his equipment.\n\n\"<i>You may want to take a step back,</i>\" he warns, but before you have a chance to do anything, a thick trunk covered in thorny vines erupts from the ground.  Thousands of vine-like branches split off the main trunk as it reaches thirty feet in the air, radiating away from the trunk and intertwining with their neighbors as they curve back towards the ground.  In the span of a few minutes, your camp gained a thorn tree and a thick mesh of barbed vines preventing access from above.");
	//pc.createStatusAffect(StatusAffects.DefenseCanopy, 0, 0, 0, 0);
	//pc.addKeyValue("Marae's Lethicite", 1, -1);
	//doNext(playerMenu);
//}
//
//private function growLethiciteDefenseGuessNot():void {
	////spriteSelect(49);
	//clearOutput();
	//output("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.");
	//doNext(returnToRathazulMenu);
//}