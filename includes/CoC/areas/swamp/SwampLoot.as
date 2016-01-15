import classes.GLOBAL;
import classes.Items.Armor.CoCInquisitorsCorset;
import classes.Items.Armor.CoCInquisitorsRobes;
import classes.Items.Miscellaneous.CoCCoal;
import classes.Items.Miscellaneous.CoCToughSpiderSilk;
import classes.Items.Transformatives.CoCGroPlus;
import classes.Items.Transformatives.CoCReducto;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function SwampLootExplore(clearScreen:Boolean = true):void {
	if(clearScreen) clearOutput();
	//spriteSelect(72);
	
	if (flags["COC.KIHA_TOLL_DURATION"] > 0) flags["COC.KIHA_TOLL_DURATION"]--;
	
	var foundLootItems:/*ItemSlotClass*/Array = new Array();
	//Grabbin' Inquisitor Armor
	if(rand(10) == 0 && flags["COC.GOTTEN_INQUISITOR_ARMOR"] != 1) {
		inquisitorRobesDiscovery();
		return;
	}
	
	if(rand(2) == 0) { // 50/50 to find something
		output("You wander around through the swamp for a while, but you don't find anything.");
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
	itemCollect([RandomInCollection(new CoCReducto(), new CoCGroPlus(), new CoCToughSpiderSilk(), new CoCCoal())]);
}

//[INTRO]
public function inquisitorRobesDiscovery():void {
	clearOutput();
	output("Cutting your way through the swamps in the hopes of finding something that isn't a spider, you are pleasantly surprised when you actually succeed.  You discover what seems to be a mossy stone door in a low hillside, adorned with some sort of complex puzzle lock composed of multiple stone circles decorated with animal symbols.  You don't know what lurks beyond the door, but if adventuring has taught you nothing else it is that something cool is always behind a puzzle.\n\n");

	//[Intelligence less than 60]
	if(pc.IQ() < 60) {
		output("Unfortunately, try as you might, you cannot seem to figure the lock out.  You spin the stone circles around multiple times to try and discern the pattern to them, but find yourself continually disappointed.  Eventually you resort to trying to listen for the sound of tumblers behind the door indicating a shifting lock.  It is not as successful as you hope.  Disappointed but not undeterred, you resolve to return to the mysterious lock at a later point, when you are more capable of handling its clever riddle.");
		//[Player leaves, room can be re-encountered]
		processTime(30 + rand(10));
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//[Intelligence greater than 60] 
	output("While spinning the puzzle locks to try and determine the solution, you notice something curious about the repeated symbols adorning them.  Though initially you thought them to mean something in regards to where the locks were meant to sit, you begin to suspect that there is another trick to them.  Slowly working your way through the possibilities, your suspicions are confirmed: the symbols are a cipher, hiding the true answer to getting through the door.  Their rotation is a red herring, meant to obscure their nature.  If your translation is correct, the door is in fact magically sealed, and waiting for a spoken command to open: one that would never be casually spoken in its presence.\n\n");

	output("\"<i>Chastity,</i>\" you say.\n\n");

	output("The tumblers of the door spin, locking into a meaningless position.  Stone hinges scrape and rumble across the ground as the sealed entrance opens.  Stale air rushes out of the cavern.  Before you stone steps descend into the ground, and torches along the wall blaze into life.  This room may not have been touched in decades.\n\n");

	output("You descend, alert.  Dust along the floor makes it difficult to discern if there are traps within the room, but the caution is possibly unwarranted, for you reach the bottom of the stairs without incident.  A single table and a chest are the only adornments of the interior.  Upon the table a rolled piece of parchment sits.  Though you are curious about the chest, the question of what this place is remains in your mind.  You unroll the parchment and read.\n\n");

	output("<i>I have failed.\n\nI could have prevented all of the tragedy that will befall this land, if I were less arrogant.  It was my duty to root out corruption in the kingdom, and to ensure that no force could sully our name, or blaspheme against our queen.  But I was too certain of myself, too certain of what I thought to be true.  I believed that it was my duty to protect my queen from the dangerous and reckless thoughts of impure commoners and power-hungry mages.\n\n");

	output("Instead, I should have protected them from my queen.\n\n");

	output("When at last I reckoned the truth of Lethice's doings, the wheels turned too quickly to stop them.  The corruption spread through the kingdom like a famished beast.  Commoner and mage alike were swallowed by its depravity, and remade.  The demons were born, and had I possessed the foresight to watch my queen more carefully I could have stopped it.\n\n");

	output("Do not mistake me for a coward, merely a fool.  I stood against my queen when at last I opened my eyes.  I dared to raise arms against her, and call upon the brightest of white fires, blazing with the desperation of a man determined to save his nation.  I failed.  She had feasted on so many souls, gained so much disgraceful power.  Before I could even gain a foothold I had already expended my energy.\n\n");

	output("She mocked me.  Perhaps she was right to do so.  An infernal mark was seared into my body as punishment for my hubris.  \"<i>The Inedible Soul,</i>\" she declared me.  Stripped naked I was made to crawl through the city, spat and ejaculated upon, jeered at by the hedonists that now populated it.  None dared to try and change me, not with Lethice's mark upon me.  Such was my punishment.  Powerless, I watched as the land fell to the taint that it was once my duty to keep in check.\n\n");

	output("I failed to stop the demons, and Lethice.  But I am one man, and there are many more who will come after me.  Many - too many - will fall, their souls and very nature devoured by the land, and for them I will suffer.  It is not their fault that my inaction created a force greater than they.\n\n");

	output("But the demons - my former queen - are greedy.  They will expand, and conquer, and one day they will extend themselves too far.  One day a champion will challenge them.  Perhaps from another land, a stronger tribe, standing tall against the force that threatens it.  Perhaps from within our own kingdom, a hold-out, a child raised in hiding.  I do not know.\n\n");

	output("If you have found this chamber, then you are wise.  Wiser and cleverer than most.  Perhaps you have the ability to be that champion.  Though I have failed, I have taken steps to ensure that my mistakes will not be repeated.  My magic found itself limited.  Yours will not.\n\n");

	output("I have spent the last of my abilities to fashion attire suitable for a champion.  It is locked within the chest.  I am no fool - I know that it may be necessary to adapt this armor for  a body warped by corrupt powers.  It may also be necessary to deprave it, somewhat, to draw less attention to oneself in a society similarly changed.\n\n");

	output("Stand before the chest, and ask for 'Retribution' or 'Carnality'.  The last of my magic, imbued therein, will do the rest.\n\n");

	output("I dearly, sincerely hope with all my being that you are successful.  I name you the last Inquisitor of a defeated kingdom, and shed my power here.  If I am fortunate, I will live to see this land restored.  If not, it is worthy punishment for my hubris.\n\n");

	output("Marae bless.\n\n");

	output("-Inquisitor Zathul</i>\n\n");

	output("You replace the scroll and look to the chest.   Will you say one of the key words?\n\n");

	//if implying that Rathazul used to be an advisor to the queen before the fall, start by spelling his name correctly; else, proceed as normal
	//[Retribution] [Carnality] [No]
	clearMenu();
	addButton(0, "Retribution", retributionArmorIsCoolShit);
	addButton(1, "Carnality", carnalityArmorIsCoolShitToo);
	addButton(2, "NOPE!", noThankYouSirIDontWantAwesomeArmors);
}

//[No]
public function noThankYouSirIDontWantAwesomeArmors():void {
	clearOutput();
	output("Uninterested in the proffered reward, you turn and leave the way you came.  At the entrance, you replace the moss, doing your best to conceal the portal in the event you wish to return, or at least to keep any items of power inside from the hands of hostile swamp denizens.  You may as well not have spent the effort, for as you're walking away, you hear the stones grinding and shifting behind you.  Sure enough, an inspection affirms that the door has sealed itself again.\n\n", false);
	//allows player to find again later, like the B.Sword

	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Retribution]
public function retributionArmorIsCoolShit():void {
	clearOutput();
	output("With your word, the chest clicks.  Moving to lift the lid, you start when it does so of its own will.  Gleaming, brilliant light floods the room.  You had expected there to be a bit of showiness from the magic, yes, but having the robes actually rise up out of the chest seems excessive.  Dark red fabric stretches up as though on a mannequin - or a ghost.  Golden trim runs along its edges.  The back of the gloves feature clearly embroidered sigils that you do not recognize, but which you suspect meant something to a culture long forgotten.  It seems to be constructed primarily of two main portions - a sleeveless high-collared undershirt and skirt, and a hooded overcoat and mantle.  You gather the robes and place them in your pack to inspect further at camp.\n\n");

	output("Turning to leave, you're startled by apparitions standing between you and the stairwell.  Faceless, translucent figures wearing the same robes you just discovered watch you carefully.  You brace yourself for a fight, but one by one they step to the side.  Carefully, you continue forward.  Each one bows as you pass them.\n\n");

	output("The display makes you feel righteous.\n\n");
	//[Player receives: 1x Inquisitor's Robes]
	flags["COC.GOTTEN_INQUISITOR_ARMOR"] = 1;
	processTime(30 + rand(10));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCInquisitorsRobes()]);
}

//[Carnality]
public function carnalityArmorIsCoolShitToo():void {
	clearOutput();
	output("With your word, the chest clicks.  Moving to lift the lid, you start when it does so of its own will.  Gleaming, brilliant light floods the room.  You had expected there to be a bit of showiness from the magic, yes, but having the robes actually rise up out of the chest seems excessive.  A dark red posture collar attached to sleeves floats above it as though on a mannequin - or a ghost.  The corset that rises beneath it looks perfectly fitted to you");
	if(pc.biggestTitSize() < 1) output(", which strikes you as unusual given your flat chest");
	output(".  Red like dried blood, it looks devilishly tight.  A golden trim runs over the... well, the trim.  Similarly colored laces run down the back.  It connects naturally to a belt with a symbol you don't recognize emblazoned on the front, which in turn is affixed to a wavy skirt aligned to the side.  There don't actually seem to be any bottoms, and the skirt looks as though it will cover approximately nothing between your legs - but given your choice, that's probably to be expected.  A high pair of heeled boots completes the outfit, echoing a similar dark red lace along the side. You gather the ensemble and place them in your pack to inspect further at camp.\n\n");

	output("Turning to leave you're startled by the apparitions standing between you and the stairwell.  Faceless, translucent figures wearing red and gold hooded robes, similar to the outfit just discovered, watch you carefully.  You brace yourself for a fight, but one by one they step to the side.  Carefully, you continue forward.  Each one bows as you pass them.\n\n");

	output("The display makes you feel like a badass.\n\n");
	//[Player receives 1x Inquisitor's Corset]
	flags["COC.GOTTEN_INQUISITOR_ARMOR"] = 1;
	processTime(30 + rand(10));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCInquisitorsCorset()]);
}