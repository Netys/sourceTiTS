import classes.Characters.CoC.CoCTrader;
import classes.GLOBAL;
import classes.Items.Drinks.CoCFuckDraft;
import classes.Items.Drinks.CoCLustDraft;
import classes.Items.Miscellaneous.CoCOvipositionElixir;
import classes.Items.Transformatives.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function lumiEncounter():void {
	clearOutput();
	clearMenu();
	if(flags["COC.LUMI_MET"] == undefined) {
		userInterface.showName("STRANGE\nDOOR");
		output("You spot an anomaly in the barren wastes; a door that seems to be standing out in the middle of nowhere. Somehow, you figure that it must lead to some other part of the world, and the only reason it's here is because you can't get to where the door should be right now.\n\n", false);
		output("Do you open it?", false);
		addButton(0, "Yes", lumiLabChoices);
		addButton(1, "No", function():*{ 
			processTime(10 + rand(5));
			mainGameMenu();
		} );
	}
	else {
		userInterface.showName("LUMI");
		output("You spot the door standing in the middle of nowhere again, and you guess that it will lead you back to Lumi's laboratory.  It swings open easily...");
		addButton(0, "Next", lumiLabChoices);
	}
}

public function lumiLabChoices():void {
	userInterface.showName("LUMI");
	//spriteSelect(37);
	clearOutput();
	//First time meeting
	if(flags["COC.LUMI_MET"] == undefined) {
		//Set Lumi met flag 
		flags["COC.LUMI_MET"] = 1;
		output("You open the door and carefully check inside for any enemies that may be trying to ambush you. The room seems to be some kind of alchemical lab, with shelves full of apparatuses all along the walls, a desk on one side of the room, and a long table across the room from you that is full of alchemical experiments in progress, many give off lots of smoke, and others are bottles of bubbling fluids.  A goblin wearing an apron and some kind of headband is sitting on a tall, wheeled stool; she is otherwise nude and seems to be watching at least 3 experiments right now. She suddenly turns around and looks straight in your direction.  It's hard to tell thanks to the dark goggles that hide her eyes from view, but you're fairly certain she's watching you.  After a few seconds she yells \"<i>Cuths-tohmer!</i>\" in a thick lisp. She looks harmless enough, so you step inside while she fiddles with her experiments, reducing the bubbling smoke.  She jumps down from her stool, tears off her apron, bounds over to the desk, and scrambles on top of it.\n\n");

		output("She's about 3 feet tall, with yellow-green skin, and wears her orange hair in a long ponytail that reaches to her knees.  Her breasts are about B cup, with average nipples that have been colored orange. All of her nails have been painted orange to match. She doesn't seem to ever stop moving, and while the majority of her face looks cute, it's a little hard to be sure while she's wearing those thick goggles.  The solid black lenses of her goggles make her look quite unsettling, stifling any appeal her form could inspire in you.\n\n");

		output("\"<i>Stho, what can Lumi, Gobin Aochomist Extwaordinaire, do fo you today?</i>\" asks the unusual goblin.\n\n");
		
		output("You explain that it's a little hard to understand her.  She sticks her tongue out at you, showing a VERY large stud in the middle of it, instantly explaining her lisp.  Rather than pushing the point, you ask her what she can do for you.  She pulls open a hatch on the top of the desk and pulls out a bottle of something and shakes it, \"<i>Lumi can sell you some of her finely cwafted poetions fo a good pwice, ore, if you've alweady got some nice poetions or reagents, Lumi can make them even bettar. But tha cost a whole lot. If you were one of dee Followers, den maybe Lumi could make a special deal wit you; but the boss don't want me playin wit outsiders. Wat will it be?</i>\"\n\n");
	}
	//Repeat Meetings
	else {
		output("Once more, you step into Lumi's lab.  She's still working on her experiments. Before you even have a chance to call out to her, she has already pivoted to watch you.  In a flash her apron hits the floor and she is standing on her desk, asking, \"<i>Stho, what can Lumi the Aochomist Extwaordinaire do fo you today?</i>\"");
	}
	
	clearMenu();
	addButton(0, "Shop", lumiShop);
	addButton(1, "Enhance", lumiEnhance);
	addButton(14, "Leave", function():*{ 
		processTime(10 + rand(5));
		mainGameMenu();
	} );
}

private function lumiShop():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Lumi";
	shopkeep.keeperBuy = "She smiles at you and pulls out several bottles from her desk and shows them to you. <i>Gawantied qwality, made by Lumi herself,</i> she says proudly.\n\n";
	shopkeep.inventory = [new CoCGoblinAle(), new CoCOvipositionElixir(), new CoCLustDraft(), new CoCFuckDraft()];
	shopkeepBackFunctor = lumiLabChoices;
	buyItem();
}

public function lumiEnhance():void {
	//spriteSelect(37);
	clearOutput();
	clearMenu();
	output("\"<i>Do you have 100 gems for de enhancement?</i>\" asks Lumi.\n\n"); 
	//If (player has less than 100 gems)
	if(pc.credits < 1000) {
		output("You shake your head no, and Lumi gives you a disappointed look and says, \"<i>Den Lumi can do no enhancement for you. Anyfing else?</i>\"\n\n");
		//Return to main Lumi menu
		addButton(0, "Next", lumiLabChoices);
		return;
	}
	
	addButton(14, "Back", lumiLabChoices);
	
	var counter:int = 0;
	function add(from:ItemSlotClass, to:ItemSlotClass):void {
		if (pc.hasItem(from))
			addButton(counter, to.shortName, lumiEnhanceGo, [from, to]); // , "Enchance", "Lumi can enchant " + from.longName + " and transform it into more potent " + to.longName + "."
		else
			addDisabledButton(counter, from.shortName);
		counter++;
	}
	
	add(new CoCFoxBerry(), new CoCVixenVigor());
	add(new CoCFoxJewel(), new CoCMysticJewel());
	add(new CoCGoldenSeed(), new CoCMagicSeed());
	add(new CoCKangaFruit(), new CoCKangaFruitEnchanced());
}
	//var laBova:Function =null;
	//if(pc.hasItem(consumables.LABOVA_))
		//laBova = lumiEnhanceLaBova;
	//var succuDelight:Function =null;
	//if(pc.hasItem(consumables.SDELITE))
		//succuDelight = lumiEnhanceSDelight;
	//var oviElix:Function =null;
	////if(pc.hasItem(consumables.OVIELIX))
	////	oviElix = lumiEnhanceOviElix;
	//var kitsune:Function =null;
	//var pigTruffle:Function = null;
	//if(pc.hasItem(consumables.PIGTRUF))
		//pigTruffle = lumiEnhancePigtailTruffle;
	//var pureHoney:Function = null;
	//if(pc.hasItem(consumables.PURHONY))
		//pureHoney = lumiEnhancePureHoney;
	//if(justCheck) {
		//return fox != null || kanga != null || seed != null || laBova != null || succuDelight != null || oviElix != null || lustDraft != null || kitsune != null || pigTruffle != null || pureHoney != null;
	//}
	//else {
		//output("You nod and Lumi gives an excited yell, \"<i>Yay! Lumi loves to do enhancement, what you want to be bettar?</i>\"\n\n", false);
		////The player chooses an item that can be enhanced from a list, regardless of which is chosen, the text for the next part is the same.
		//choices(consumables.FOXBERY.shortName, fox,
				//consumables.FOXJEWL.shortName, kitsune,
				//consumables.GLDSEED.shortName, seed,
				//consumables.KANGAFT.shortName, kanga,
				//consumables.L_DRAFT.shortName, lustDraft,
				//consumables.LABOVA_.shortName, laBova,
				//consumables.OVIELIX.shortName, oviElix,
				//consumables.SDELITE.shortName, succuDelight,
				//consumables.PIGTRUF.shortName, pigTruffle,
				//consumables.PURHONY.shortName, pureHoney);
		//return true;
	//}
//}
private function lumiEnhanceGo(args:/*ItemSlotClass*/Array):void
{
	var from:ItemSlotClass = args[0];
	var to:ItemSlotClass = args[1];
	
	//spriteSelect(37);
	pc.credits -= 100 * 10;
	//statScreenRefresh();
	clearOutput();
	output("Lumi grabs the item from you and runs over to her table, stopping for only a second to put her apron on.  ");
	//start list of possible enhancement texts
	temp = rand(3);
	//if(itype == consumables.GLDSEED) output("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing seed with a gloved hand.\n\n", false);
	//else 
	if(from as Class is CoCFoxJewel) output("Lumi stares wide-eyed into the fathoms of its depths.  She remains like that for several moments before you clear your throat, and then hurries off to work.  Flitting back and forth between the various beakers and test tubes that litter the workshop, she mixes chemicals seemingly at random, many of which bubble or explode rather violently.\n\nAfter several minutes of this, she pours all of the reagents into a large beaker over an open flame.  The contents boil up through the neck of the flask and drip slowly down the condenser.  A ponderously large drop of black liquid builds up at the tip of the condenser, wobbling precipitously for a moment before finally falling onto the jewel with a splash.\n\nThe jewel soaks up the black fluid like a sponge, veins of sickening purple spreading across the surface like a spider's web.  A few moments later, the jewel is entirely purple, the mystic flames inside glowing a bright violet.\n\nYou reach out hesitantly and place the mystically enhanced teardrop-shaped jewel into your pouch.\n\n");
	//else if(itype == consumables.KANGAFT) output("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing fruit with a gloved hand.\n\n", false);
	else if(temp == 0) output("She starts grabbing things from around the table, seemingly at random, and adds them to " + from.longName + ".  To your alarm, there is soon a large cloud of smoke coming off it! There is a strong smell to the smoke and it makes it hard to breathe.  Lumi grabs a mask out of a drawer and puts it on, continuing with her work unperturbed.  She suddenly stops and you wonder if she is done, but she takes off her mask and inhales deeply of the smoke, then keels over!  As you go over to help her she suddenly stands up, waves away some of the smoke, and says, \"<i>All dun!</i>\"\n\n");
	else if(temp == 1) output("Taking hold of one of the bottles that were sitting where she put the tray, she seems to think for a moment before tossing the bottle into one of the corners of the room.  It shatters just behind the table, and a small puff of smoke goes up into the air.  You're a little nervous about that bottle, but before you have a chance to say anything, two more bottles fly off and join it; this time causing a small explosion. You ask her what she is thinking tossing those aside, and she simply responds, \"<i>Dey were in my way.</i>\"\n\n\"<i>What?!  So you just toss things that explode to the side?</i>\"\n\n<i>\"Don worry, I'll put counter agents in dere at de end of de day.  An I never throw stuff da'll do any damage.  Done!</i>\"\n\n");
	else if (temp == 2) output("She adds a few things to the tray before moving down the table.  She adds some reagents to a bubbling chemical reaction, and then adds some more ingredients to that.  You wonder why she just left " + from.longName + " there to work on something else.  Then Lumi moves back across the table, past where " + from.longName + " sits, to start adding things to something else.  Before you have a chance to complain, she moves back to " + from.longName + " and continues.  You decide that it's probably best not to ask about her work ethic and just let her do her thing; she has more experience than you, after all.\n\nPOP! You look over in surprise as the first thing she worked on makes a small explosion.  POW! Now the second experiment has blown up!  You start to move in alarm, wondering if Lumi really knows what she's doing; just before " + from.longName + " seems to explode with an incredible BOOM.  Lumi stops moving for a moment, looking straight ahead before saying, \"<i>Dat was a gud one, Lumi dun!</i>\"\n\n");
	pc.destroyItem(from);
	processTime(5 + rand(5));

	itemScreen = lumiEnhance;
	lootScreen = lumiEnhance;
	useItemFunction = lumiEnhance;
	itemCollect([to]);
}