import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCOvipositionElixir;
import classes.Items.Transformatives.CoCEggs.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//\"<i>Chicken Harpy</i>\" by Jay Gatsby and not Savin he didn't do ANYTHING
//Initial Intro
public function chickenHarpy():void
{
	clearOutput();
	//spriteSelect(90);
	if (IncrementFlag("COC.TIMES_MET_CHICKEN_HARPY") == 1) {
		output("Taking a stroll along the mountains, you come across a peculiar-looking harpy wandering around with a large wooden cart in tow.  She's far shorter and bustier than any regular harpy you've seen before, reaching barely 4' in height but managing to retain some semblance of their thick feminine asses.  In addition to the fluffy white feathers decorating her body, the bird-woman sports about three more combed back upon her forehead like a quiff, vividly red in color.");
		output("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be a chicken harpy!");
		output("\n\nAs you take a look inside of the cart you immediately spot a large hoard of eggs stacked clumsily in a pile.  The curious collection of eggs come in many colors and sizes, protected by a sheet of strong canvas to keep it all together.");
		output("\n\nThe chicken harpy - rather unnerved by the unflattering narration of her appearance you've accidentally shouted out loud - decides to break the ice by telling you about the cart currently holding your interest.");
		output("\n\n\"<i>Heya traveller, I noticed you were interested in my eggs here - they're not for sale, but perhaps we can come to some sort of agreement?</i>\"");
		output("\n\nYou put a hand to your chin and nod.  You are travelling, that's correct. The chicken harpy takes the gesture as a sign to continue.");
		output("\n\n\"<i>Well you see, these eggs don't really grow from trees - in fact, I've gotta chug down at least two or three ovi elixirs to get a good haul with my body, y'know?  Since it's tough for a lil' gal like me to find a few, I like to trade an egg over for some elixirs to those willing to part with them.</i>\"");
		output("\n\nSounds reasonable enough, you suppose.  Two or three elixirs for an egg? Doable for sure.");
		output("\n\n\"<i>So whaddya say, do y'have any elixirs you can fork over?</i>\"");
	}
	else {
		//Repeat Intro
		output("Taking a stroll along the mountains, you come across a familiar-looking shorty wandering around with a large wooden cart in tow.");
		output("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be the chicken harpy!");
		output("\n\nYou run towards her as she waves a 'hello', stopping the cart to allow you to catch up.  Giving out her usual spiel about the eggs, she giggles and thrusts out a hand.");
		output("\n\n\"<i>Hey sunshine, do y'have any elixirs you can give me today?</i>\"");
		//[Give Two][Give Three]	[No, I Must Now Return To My People]
	}
	//[Give Two][Give Three]		[Not Really, No]
	clearMenu();
	
	addDisabledButton(0, "Give Two", "Give Two", "You need 2 bottles of Ovi Elixir.")
	addDisabledButton(1, "Give Three", "Give Three", "You need 3 bottles of Ovi Elixir.")
	
	if (pc.hasItem(new CoCOvipositionElixir(), 2)) addButton(0, "Give Two", giveTwoOviElix);
	if (pc.hasItem(new CoCOvipositionElixir(), 3)) addButton(1, "Give Three", giveThreeOviElix);
	addButton(14, "Leave", leaveChickenx);
}

//If Give Two
public function giveTwoOviElix():void
{
	clearOutput();
	//spriteSelect(90);
	pc.destroyItem(new CoCOvipositionElixir(), 2);
	output("You hand over two elixirs, the harpy more than happy to take them from you.  In return, she unties a corner of the sheet atop the cart, allowing you to take a look at her collection of eggs.");
	//[Black][Blue][Brown][Pink][Purple]
	clearMenu();
	//addButton(0, "Black", getHarpyEgg, consumables.BLACKEG);
	addDisabledButton(0, "Black", "Black", "Black eggs are not implemented.");
	addButton(1, "Blue", getHarpyEgg, new CoCBlueEgg());
	addButton(2, "Brown", getHarpyEgg, new CoCBrownEgg());
	addButton(3, "Pink", getHarpyEgg, new CoCPinkEgg());
	addButton(4, "Purple", getHarpyEgg, new CoCPurpleEgg());
	addButton(5, "White", getHarpyEgg, new CoCWhiteEgg());
}

//If Give Three
public function giveThreeOviElix():void
{
	clearOutput();
	//spriteSelect(90);
	pc.destroyItem(new CoCOvipositionElixir(), 3);
	output("You hand over three elixirs, the harpy ecstatic over the fact that you're willing to part with them.  In return, she unties a side of the sheet atop the cart, allowing you to take a look at a large collection of her eggs.");
	//[Black][Blue][Brown][Pink][Purple]
	clearMenu();
	//addButton(0, "Black", getHarpyEgg, consumables.L_BLKEG);
	addDisabledButton(0, "Black", "Black", "Black eggs are not implemented.");
	addButton(1, "Blue", getHarpyEgg, new CoCBlueEggLarge());
	addButton(2, "Brown", getHarpyEgg, new CoCBrownEggLarge());
	addButton(3, "Pink", getHarpyEgg, new CoCPinkEggLarge());
	addButton(4, "Purple", getHarpyEgg, new CoCPurpleEggLarge());
	addButton(5, "White", getHarpyEgg, new CoCWhiteEggLarge());
}

//All Text
public function getHarpyEgg(itype:ItemSlotClass):void
{
	clearOutput();
	//spriteSelect(90);
	IncrementFlag("COC.EGGS_BOUGHT")
	output("You take " + itype.longName + ", and the harpy nods in regards to your decision.  Prepping her cart back up for the road, she gives you a final wave goodbye before heading back down through the mountains.\n\n");
	
	processTime(20 + rand(10));
	itemScreen = chickenHarpy;
	lootScreen = chickenHarpy;
	useItemFunction = chickenHarpy;
	itemCollect([itype]);
}

//If No
public function leaveChickenx():void
{
	clearOutput();
	//spriteSelect(90);
	output("At the polite decline of her offer, the chicken harpy gives a warm smile before picking her cart back up and continuing along the path through the mountains.");
	output("\n\nYou decide to take your own path, heading back to camp while you can.");
	processTime(10 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}