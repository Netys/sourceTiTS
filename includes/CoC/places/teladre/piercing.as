import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function showYara():void {
	//spriteSelect(63);
	userInterface.showName("\nYARA");
}

private function piercingStudio():void {
	showYara();
	clearOutput();
	clearMenu();
	
	output("The interior of the piercing studio is earthy, leaving the stone floors and walls uncovered, though the windows are covered with woven blankets, sewn from multicolored threads.  There are a number of cushy chairs facing a wall of mirrors, along with a shelf covered in needles, piercings, and strong alcohols.  A brunette prowls about the place, tidying it up during a lull in business.  You dully notice that unlike everyone else in this town, she's mostly human.  Perhaps she came through a portal as well?  She approaches you, and you see a cat tail waving behind her, and a pair of fuzzy feline ears, both covered in piercings, perched atop her head.  Clearly she's been here long enough to pick up some of the local flavor.\n\n", false);
	output("She introduces herself, \"<i>Hello there " + pc.mf("sir", "cutie") + ", my name is Yara.  Would you like to get a piercing?</i>\"");
	
	if (pc.credits >= 1000) addButton(0, "Pierce", pierceMenu);
	else addDisabledButton(0, "Pierce", "Pierce", "You can't afford it.");
	
	if (pc.credits >= 1000) addButton(1, "Remove", piercingRemove);
	else addDisabledButton(1, "Remove", "Remove", "You can't afford it.");
	
	if (flags["COC.YARA_SEXED"] != undefined && pc.lust() >= 33) {
		if (pc.hasVagina()) addButton(2, "Female Sex", letsDoYaraSex, true);
		else addDisabledButton(2, "Female Sex", "Female Sex", "This scene requires you to have vagina.");
		
		if (pc.cockThatFits(36) != -1) addButton(3, "Male Sex", letsDoYaraSex, false);
		else addDisabledButton(3, "Male Sex", "Male Sex", "This scene requires you to have fitting cock.");
	}
	
	if (flags["COC.YARA_TALKED"] == undefined)
		addButton(4, "About Her", aboutYara);
	
	addButton(14, "Leave", telAdreMenu);
}

private function aboutYara():void {
	showYara();
	clearOutput();
	flags["COC.YARA_TALKED"] = 1;
	output("You introduce yourself and ask Yara about her past, noting that ");
	if(pc.humanScore() <= 2 && pc.originalRace == "human") output("you were once a human too.");
	else output("you haven't seen many other humans about.");
	output("\n\nShe blushes a little when she answers, her tail curling about her protectively, \"<i>My home city was built around a portal, and the Baron that ruled it insisted that we send a sacrifice through every year.  We were raised believing that if we didn't sacrifice SOMEONE, the gods would become angry and bring our city to ruin.  Of course the whole thing was a sham, but the families of those sacrificed get compensation.  My father tried to whore me out first, but when that didn't work, the bastard had me drugged and sacrificed.  I woke up next to a lake, ate some weird fruit when I got hungry, and I... well, I changed.  Thankfully I found my way here before I ran into any demons, or who knows what would have happened to me!  Tel'Adre has been good to me, and I'm sure it'll be good to you.  Now, how about getting a piercing?</i>\"");
	//dynStats("int", 2, "lus", -5, "cor", -1);
	pc.slowStatGain("i", 2);
	pc.cor( -1);
	pc.lust( -5);
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function pierceMenu():void {
	showYara();
	clearOutput();
	clearMenu();
	output("Yara asks, \"<i>Ok then, what would you like pierced " + pc.mf("sir", "cutie") + "?  Just keep in mind my piercings are special - they're permanent and CAN'T be removed.</i>\"");
	
	var btn:int = 0;
	
	if (pc.hasClit()) {
		if (pc.vaginas[0].clitPierced == 0) addButton(btn++, "Clit", clitPierce);
		else addDisabledButton(btn++, "Clit", "Clit", "Your clit is already pierced.");
	} else addDisabledButton(btn++, "Clit", "Clit", "Your have no clit.");
	
	if (pc.hasVagina()) {
		if (pc.vaginas[0].labiaPierced == 0) addButton(btn++, "Labia", vulvaPierce);
		else addDisabledButton(btn++, "Labia", "Labia", "Your labia is already pierced.");
	} else addDisabledButton(btn++, "Labia", "Labia", "Your have no vagina.");
	
	if (pc.hasCock()) {
		if (pc.cocks[0].pierced == 0) addButton(btn++, "Dick", dickPierce);
		else addDisabledButton(btn++, "Dick", "Dick", "Your dick is already pierced.");
	} else addDisabledButton(btn++, "Dick", "Dick", "Your have no dick.");
	
	if (pc.earsPierced == 0) addButton(btn++, "Ears", earPierce);
	else addDisabledButton(btn++, "Ears", "Ears", "Your ears are already pierced.");
	
	if (pc.eyebrowPierced == 0) addButton(btn++, "Eyebrow", eyebrowPierce);
	else addDisabledButton(btn++, "Eyebrow", "Eyebrow", "Your eyebrows are already pierced.");
	
	if (pc.lipPierced == 0) addButton(btn++, "Lip", lipPierce);
	else addDisabledButton(btn++, "Lip", "Lip", "Your lips are already pierced.");
	
	if (pc.hasNipples()) {
		if (pc.nipplesPierced == 0) addButton(btn++, "Nipples", nipplePierce);
		else addDisabledButton(btn++, "Nipples", "Nipples", "Your nipples are already pierced.");
	} else addDisabledButton(btn++, "Nipples", "Nipples", "Your have no nipples.");
	
	if (pc.nosePierced == 0) addButton(btn++, "Nose", nosePierce);
	else addDisabledButton(btn++, "Nose", "Nose", "Your nose is already pierced.");
	
	if (pc.tonguePierced == 0) addButton(btn++, "Tongue", tonguePierce);
	else addDisabledButton(btn++, "Tongue", "Tongue", "Your tongue is already pierced.");
	
	addButton(14, "Back", piercingStudio);
}

private function dickPierce():void {
	showYara();
	clearOutput();
	output("\"<i>Ok, this is gonna hurt a LOT, but I've heard good things about it.  What kind of piercing do you want done?</i>\" Yara asks.");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [1, 1]);
	addButton(1, "Ring", chooseMaterials, [1, 2]);
	addButton(2, "Ladder", chooseMaterials, [1, 3]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function clitPierce():void {
	showYara();
	clearOutput();
	output("\"<i>Ohhh, that's going to be suckably cute!</i>\" exclaims Yara, blushing more than a little. \"<i>What kind of piercing would you like?</i>");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [0, 1]);
	addButton(1, "Ring", chooseMaterials, [0, 2]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function earPierce():void {
	showYara();
	clearOutput();
	output("\"<i>Okay, just let me get my supplies and we can get started.  What kind of jewelry do you want in them?</i>\" asks Yara.");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [2, 1]);
	addButton(1, "Ring", chooseMaterials, [2, 2]);
	addButton(2, "Hoop", chooseMaterials, [2, 4]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function eyebrowPierce():void {
	showYara();
	clearOutput();
	output("\"<i>Ah, that's a good look!  What do you want there?</i>\" asks Yara.");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [3, 1]);
	addButton(1, "Ring", chooseMaterials, [3, 2]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function lipPierce():void {
	showYara();
	clearOutput();
	output("\"<i>Oh my, that'll be HAWT!  What kind of jewelry do you want there?</i>\" asks Yara.");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [4, 1]);
	addButton(1, "Ring", chooseMaterials, [4, 2]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function nipplePierce():void {
	showYara();
	clearOutput();
	output("\"<i>Yeah, sure I can do those!  What kind of jewelry do you want there?  I'm partial to nipple-chains myself,</i>\" admits Yara, blushing bright red.");
	clearMenu();
	addButton(0, "Studs", chooseMaterials, [5, 1]);
	addButton(1, "Rings", chooseMaterials, [5, 2]);
	addButton(1, "Chain", chooseMaterials, [5, 5]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function nosePierce():void {
	showYara();
	clearOutput();
	output("Yara wrinkles her nose in distaste, \"<i>Really?  Well ok, what do you want there?</i>\"");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [6, 1]);
	addButton(1, "Ring", chooseMaterials, [6, 2]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function tonguePierce():void {
	showYara();
	clearOutput();
	output("Yara happily purrs, \"<i>Oh my, I bet that'll be fun!  I'm afraid I can only put a stud there though, ok?</i>\"");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [7, 1]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}
private function vulvaPierce():void {
	showYara();
	clearOutput();
	output("Yara explains, \"<i>This is gonna hurt a lot, but I think you'll love how it feels after.  I know I do!  Now what kind of jewelry do you want down-town?</i>\"");
	clearMenu();
	addButton(0, "Stud", chooseMaterials, [8, 1]);
	addButton(1, "Ring", chooseMaterials, [8, 2]);
	
	addButton(4, "Back", pierceMenu);
	addButton(14, "Nevermind", piercingStudio);
}

private function chooseMaterials(arg:Array):void { // Array contents here: spot, type
	showYara();
	clearOutput();
	output("Yara gathers up her materials and says, \"<i>Ok, now what type of material do you want it made from?  Don't worry about price, none of these are that rare, so the piercing will only be 100 gems.  Though I do have some rarer materials.</i>\"\n");

	//output("\n1. Lethite - Fake lethicite.  While beautiful, it's known to attract demons.", false);
	//output("\n2. Fertite - A green gem sometimes fished up from the bottom of Mareth's great lake, it is said to enhance the fertility of both genders.", false);
	//output("\n3. Furrite - This beautiful purple gem is actually crystalized from materials used in hunting lures.  It is said to enhance the wearer's appeal to beast-people.", false);
	output("\nCrimstone - Crimstone is said to be formed from volcanic fires, and to keep the fires of one's desires burning brightly. Due to its rarity, this costs 1000 gems instead.");
	output("\nIcestone - Found from the Glacial Rift, this rare gem is said to counter the effects of Crimstone and quell ever-burning desires. This will annihilate some of crimstone magic. Due to its rarity, this costs 2000 gems instead.");
	output("\n\n<b>DISCLAIMER</b>: Yara's Piercing Studio is not responsible if the piercee's body absorbs any residual magic of these stones, and is not required to resolve any issues if the effects persist beyond removal.</b>");
	
	clearMenu();
	
	addButton(0, "Amethyst", function():* { arg.push(1); areYouSure(arg); } );
	addButton(1, "Diamond", function():* { arg.push(2); areYouSure(arg); } );
	addButton(2, "Gold", function():* { arg.push(3); areYouSure(arg); } );
	addButton(3, "Emerald", function():* { arg.push(4); areYouSure(arg); } );
	addButton(4, "Jade", function():* { arg.push(5); areYouSure(arg); } );
	addButton(5, "Onyx", function():* { arg.push(6); areYouSure(arg); } );
	addButton(6, "Ruby", function():* { arg.push(7); areYouSure(arg); } );
	addButton(7, "Steel", function():* { arg.push(8); areYouSure(arg); } );
	
	if (pc.credits >= 10000) addButton(8, "Crimstone", function():* { arg.push(12); areYouSure(arg); } );
	else addDisabledButton(8, "Crimstone", "Crimstone", "You can't afford it.");
	
	if (pc.credits >= 20000) addButton(9, "Icestone", function():* { arg.push(13); areYouSure(arg); } );
	else addDisabledButton(9, "Icestone", "Icestone", "You can't afford it.");
	
	addButton(14, "Nevermind", piercingStudio);
}

private function areYouSure(arg:Array):void { // Array contents here: spot, type, matherial
	showYara();
	clearOutput();
	output("Yara says, \"<i>Ok, last chance to back out, are you sure you want to go ahead with this?  Remember, once I put it in, it's permanent.</i>\"");
	clearMenu();
	addButton(0, "Yes", normalPierceAssemble, arg);
	addButton(1, "No", piercingStudio);
}

private function normalPierceAssemble(arg:Array):void { // Array contents here: spot, type, matherial
	showYara();
	clearOutput();
	output("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled and before you know it, your piercing is done!");
	var piercingLoc:int = arg[0];
	var piercingType:int = arg[1];
	var piercingMat:int = arg[2];
	
	//1. Amethyst (+1 int, +1 lib)
	//2. Diamond (+2 int, -1 cor)
	//3. Gold (+1 int, +1 sens)
	//4. Emerald (+1 spe)
	//5. Jade (+1 spe, -.5 tou)
	//6. Onyx (+1 tou, -1 spe)
	//7. Ruby (+1 lib, +1 sens)
	//8. Steel (+2 str, -2 int)
	//9. Lethite (Demon Lure)
	//10. Fertite (Fertility Booster)
	//11. Furrite (Attracts Furries)
	//12. Crimsonite (+Min Lust)
	//13. Icestone (-Min Lust)
	//var piercingMat:Number = 0;
	var shortP:String = "";
	var longP:String = "";
	pc.credits -= 1000;
	if (piercingMat > 8) pc.credits -= 9000;
	if (piercingMat == 13) pc.credits -= 10000;
	
	//set up material description
	switch(piercingMat) {
		case 1:
			shortP += "amethyst ";
			pc.slowStatGain("i", 1);
			pc.slowStatGain("l", 1);
			longP += "Amethyst ";
			break;
		case 2:
			shortP += "diamond ";
			pc.slowStatGain("i", 2);
			pc.cor( -1);
			longP += "Diamond ";
			break;
		case 3:
			shortP += "gold ";
			//dynStats("int", 1, "sen", 1);
			pc.slowStatGain("i", 1);
			longP += "Gold ";
			break;
		case 4:
			shortP += "emerald ";
			pc.slowStatGain("r", 1);
			longP += "Emerald ";
			break;
		case 5:
			shortP += "jade ";
			//dynStats("tou", -.5, "int", 1, "cor", -1);
			pc.slowStatGain("i", 1);
			pc.slowStatGain("w", -0.5);
			pc.cor( -1);
			longP += "Jade ";
			break;
		case 6:
			shortP += "onyx ";
			//dynStats("tou", 1, "spe", -1);
			pc.slowStatGain("w", 1);
			pc.slowStatGain("r", -1);
			longP += "Onyx ";
			break;
		case 7:
			shortP += "ruby ";
			//dynStats("lib", 1, "sen", 1);
			pc.slowStatGain("l", 1);
			longP += "Ruby ";
			break;
		case 8:
			shortP += "steel ";
			//dynStats("str", 2,"int", -2);
			pc.slowStatGain("p", 2);
			pc.slowStatGain("i", -2);
			longP += "Steel ";
			break;
		case 9:
			shortP += "lethite ";
			//if(pc.findPerk(PerkLib.PiercedLethite) < 0) pc.createPerk(PerkLib.PiercedLethite,0,0,0,0);
			longP += "Lethite ";
			break;
		case 10:
			shortP += "fertite ";
			//if(pc.findPerk(PerkLib.PiercedFertite) < 0) pc.createPerk(PerkLib.PiercedFertite,5,0,0,0);
			//else pc.addPerkValue(PerkLib.PiercedFertite,1,5);
			longP += "Fertite ";
			break;
		case 11:
			shortP += "furrite ";
			//if(pc.findPerk(PerkLib.PiercedFurrite) < 0) pc.createPerk(PerkLib.PiercedFurrite,0,0,0,0);
			longP += "Furrite ";
			break;
		case 12:
			shortP += "crimstone ";
			if (pc.hasPerk("Pierced: Icestone")) {
				pc.addPerkValue("Pierced: Icestone", 1, -5);
				if (pc.perkv1("Pierced: Icestone") <= 0) pc.removePerk("Pierced: Icestone");
			}
			else {
				if (!pc.hasPerk("Pierced: Crimstone")) pc.createPerk("Pierced: Crimstone", 5, 0, 0, 0, "You've been pierced with Crimstone and your lust seems to stay a bit higher than before.");
				else pc.addPerkValue("Pierced: Crimstone", 1, 5);
			}
			longP += "Crimstone ";
			break;
		case 13:
			shortP += "icestone ";
			if (pc.hasPerk("Pierced: Crimstone")) {
				pc.addPerkValue("Pierced: Crimstone", 1, -5);
				if (pc.perkv1("Pierced: Crimstone") <= 0) pc.removePerk("Pierced: Crimstone");
			}
			else {
				if (!pc.hasPerk("Pierced: Icestone")) pc.createPerk("Pierced: Icestone", 5, 0, 0, 0, "You've been pierced with Icestone and your lust seems to stay a bit lower than before.");
				else pc.addPerkValue("Pierced: Icestone", 1, 5);
			}
			longP += "Icestone ";
			break;
	}
	
	switch(piercingLoc) {
		/*
		0) **Clit (+2 sens)
		1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		2) **Ears
		3) **Eyebrow (-.5 def)
		4) **Lip (-.5 def)
		5) **Nipples (+1 sens, +1 lib)
		6) **Nose (+.5 attack)
		7) **Tongue (+1 sens)
		8) **Vulva (+1 sens)*/
		//var piercingLoc:Number = 0;
		case 0:
			shortP += "clit-";
			longP += "clit-";
			//dynStats("sen", 2);
			pc.slowStatGain("l", 2);
			break;
		case 1:
			if(piercingType == 3) break;
			shortP += "cock-";
			longP += "cock-";
			//dynStats("lib", 2);
			pc.slowStatGain("l", 2);
			break;
		case 2:
			shortP += "ear";
			longP += "ear";
			break;
		case 3:
			//dynStats("tou", -.5);
			pc.slowStatGain("w", -0.5);
			shortP += "eyebrow-";
			longP += "eyebrow-";
			break;
		case 4:
			//dynStats("tou", -.5);
			pc.slowStatGain("w", -0.5);
			shortP += "lip-";
			longP += "lip-";
			break;
		case 5:
			//dynStats("lib", 1, "sen", 1);
			pc.slowStatGain("l", 2);
			shortP += "nipple-";
			longP += "nipple-";
			break;
		case 6:
			//dynStats("str", .5);
			pc.slowStatGain("p", 0.5);
			shortP += "nose-";
			longP += "nose-";
			break;
		case 7:
			//dynStats("sen", 1);
			pc.slowStatGain("l", 1);
			shortP += "tongue-";
			longP += "tongue-";
			break;
		case 8:
			//dynStats("sen", 1);
			pc.slowStatGain("l", 1);
			shortP += "labia-";
			longP += "labia-";
			break
	}
	
	switch(piercingType) {
		//studs
		case 1:
			//multiples
			if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "studs";
				longP += "studs";
			}
			else {
				shortP += "stud";
				longP += "stud";
			}
			break;
		//2. Ring (Called prince albert on dick)
		case 2:
			//multiples
			if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "rings";
				longP += "rings";
			}
			else {
				shortP += "ring";
				longP += "ring";
			}
			break;
		//3. Jacobs Ladder (dick only)
		case 3:
			shortP += "jacob's ladder";
			longP += "jacob's ladder";
			break;
		//4. Hoop (ears/nipples/clit)
		case 4:
			//multiples
			if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "hoops";
				longP += "hoops";
			}
			else {
				shortP += "hoop";
				longP += "hoop";
			}
			break;
		//5. Chain (nipples only)
		case 5:
			shortP += "chain";
			longP += "chain";
			break;
	}
	
	//Actually assign values to their real storage locations
	switch(piercingLoc) {
		/*
		0) **Clit (+2 sens)
		1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		2) **Ears
		3) **Eyebrow (-.5 def)
		4) **Lip (-.5 def)
		5) **Nipples (+1 sens, +1 lib)
		6) **Nose (+.5 attack)
		7) **Tongue (+1 sens)
		8) **Vulva (+1 sens)*/
		//var piercingLoc:Number = 0;
		case 0:
			pc.vaginas[0].clitPierced = piercingType;
			pc.vaginas[0].clitPShort = shortP;
			pc.vaginas[0].clitPLong = longP;
			break;
		case 1:
			pc.cocks[0].pierced = piercingType;
			pc.cocks[0].pShort = shortP;
			pc.cocks[0].pLong = longP;
			break;
		case 2:
			pc.earsPierced = piercingType;
			pc.earsPShort = shortP;
			pc.earsPLong = longP;
			break;
		case 3:
			pc.eyebrowPierced = piercingType;
			pc.eyebrowPShort = shortP;
			pc.eyebrowPLong = longP;
			break;
		case 4:
			pc.lipPierced = piercingType;
			pc.lipPShort = shortP;
			pc.lipPLong = longP;
			break;
		case 5:
			pc.nipplesPierced = piercingType;
			pc.nipplesPShort = shortP;
			pc.nipplesPLong = longP;
			break;
		case 6:
			pc.nosePierced = piercingType;
			pc.nosePShort = shortP;
			pc.nosePLong = longP;
			break;
		case 7:
			pc.tonguePierced = piercingType;
			pc.tonguePShort = shortP;
			pc.tonguePLong = longP;
			break;
		case 8:
			pc.vaginas[0].labiaPierced = piercingType;
			pc.vaginas[0].labiaPShort = shortP;
			pc.vaginas[0].labiaPLong = longP;
			break;
	}
	//Girls
	if(piercingLoc == 8 || piercingLoc == 0) {
		yaraSex(true);
		return;
	}
	//Dudes
	else if(piercingLoc == 1 && (pc.cockThatFits(36) != -1 || pc.hasVagina())) {
		yaraSex(pc.cockThatFits(36) == -1);
		return;
	}
	//Piercing shop main menu
	processTime(10 + rand(5));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}


private function piercingRemove():void {
	showYara();
	clearOutput();
	output("\"<i>Really?</i>\" asks Yara, \"<i>I told you those piercings are permanent!  Well, I suppose they CAN be removed, but you're gonna hurt like hell afterwards.  If you really want me to, I can remove something, but it'll cost you 100 gems for the painkillers and labor.</i>\"");
	
	clearMenu();
	if(pc.HPQ() < 75) {
		output("Yara looks you up and down before refusing you outright, \"<i>You don't look so good [pc.name].  I don't think your body could handle it right now.</i>\"");
		addButton(0, "Next", piercingStudio);
		return;
	}
	
	var btn:int = 0;
	
	if (pc.hasClit()) {
		if (pc.vaginas[0].clitPierced > 0) addButton(btn++, "Clit", removeClitPierce);
		else addDisabledButton(btn++, "Clit", "Clit", "Your clit is not pierced.");
	} else addDisabledButton(btn++, "Clit", "Clit", "Your have no clit.");
	
	if(pc.hasVagina()) {
		if (pc.vaginas[0].labiaPierced > 0) addButton(btn++, "Labia", removeVulvaPierce);
		else addDisabledButton(btn++, "Labia", "Labia", "Your labia is not pierced.");
	} else addDisabledButton(btn++, "Labia", "Labia", "Your have no vagina.");
	
	if (pc.hasCock()) {
		if (pc.cocks[0].pierced > 0) addButton(btn++, "Dick", removeCockPierce);
		else addDisabledButton(btn++, "Dick", "Dick", "Your dick is not pierced.");
	} else addDisabledButton(btn++, "Dick", "Dick", "Your have no dick.");
	
	if (pc.earsPierced > 0) addButton(btn++, "Ears", removeEarsPierce);
	else addDisabledButton(btn++, "Ears", "Ears", "Your ears are not pierced.");
	
	if (pc.eyebrowPierced > 0) addButton(btn++, "Eyebrow", removeEyebrowPierce);
	else addDisabledButton(btn++, "Eyebrow", "Eyebrow", "Your eyebrows are not pierced.");
	
	if (pc.lipPierced > 0) addButton(btn++, "Lip", removeLipPierce);
	else addDisabledButton(btn++, "Lip", "Lip", "Your lips are not pierced.");
	
	if(pc.hasNipples()) {
		if (pc.nipplesPierced > 0) addButton(btn++, "Nipples", removeNipplesPierce);
		else addDisabledButton(btn++, "Nipples", "Nipples", "Your nipples are not pierced.");
	} else addDisabledButton(btn++, "Nipples", "Nipples", "Your have no nipples.");
	
	if (pc.nosePierced > 0) addButton(btn++, "Nose", removeNosePierce);
	else addDisabledButton(btn++, "Nose", "Nose", "Your nose is not pierced.");
	
	if (pc.tonguePierced > 0) addButton(btn++, "Tongue", removeTonguePierce);
	else addDisabledButton(btn++, "Tongue", "Tongue", "Your tongue is not pierced.");
	
	addButton(14, "Back", piercingStudio);
}

private function removeClitPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.vaginas[0].clitPierced = 0;
	pc.vaginas[0].clitPShort = "";
	pc.vaginas[0].clitPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeCockPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.cocks[0].pierced = 0;
	pc.cocks[0].pShortDesc = "";
	pc.cocks[0].pLongDesc = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeEarsPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.earsPierced = 0;
	pc.earsPShort = "";
	pc.earsPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeEyebrowPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.eyebrowPierced = 0;
	pc.eyebrowPShort = "";
	pc.eyebrowPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeLipPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.lipPierced = 0;
	pc.lipPShort = "";
	pc.lipPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeNipplesPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.nipplesPierced = 0;
	pc.nipplesPShort = "";
	pc.nipplesPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeNosePierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.nosePierced = 0;
	pc.nosePShort = "";
	pc.nosePLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeTonguePierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.tonguePierced = 0;
	pc.tonguePShort = "";
	pc.tonguePLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function removeVulvaPierce():void {
	showYara();
	clearOutput();
	output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
	
	pc.vaginas[0].labiaPierced = 0;
	pc.vaginas[0].labiaPShort = "";
	pc.vaginas[0].labiaPLong = "";
	
	pc.HP( -pc.HPMax() / 2);
	pc.credits -= 1000;
	processTime(50 + rand(20));
	clearMenu();
	addButton(0, "Next", piercingStudio);
}

private function yaraSex(girl:Boolean = true):void {
	showYara();
	clearOutput();
	output("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled. Before you know it, your piercing is done!  You move to rise, retaining a bit of modesty");
	if(pc.exhibitionism() >= 66) output(" despite the guilty thrill");
	output(".  \"<i>Hold it,</i>\" Yara commands softly, pressing her hand against your [pc.chest] and pushing you back in your chair.  \"<i>Do you think I'll let you get away without some... field testing?</i>\"\n\n");

	output("She seems intent on getting some loving - would you like to turn her down, or will you let nature run its course?");
	
	processTime(10 + rand(5));
	clearMenu();
	
	//[not at all] [yeah baby]
	addButton(0, "Turn down", piercingStudio);
	addButton(1, "Oh yeah!", letsDoYaraSex, girl);
}

private function letsDoYaraSex(girl:Boolean = true):void {
	showYara();
	clearOutput();
	
	var x:Number = pc.cockThatFits(36);
	
	// this block actually never used - all checks are outside
	if ((x == -1) && !girl)  // No cock that fits
	{
		if (pc.hasVagina()) // But the PC has a vagoo! Swap over to female mode"
		{
			output("\"<i>Oh dear, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. \"<i>Oh well</i>\", she sighs. \"<i>I guess I'll just have to explore your feminine side instead</i>\"\n");
			girl = true;
			x = pc.biggestCockIndex();
		}
		else
		{
			output("\"<i>I'm sorry, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. Maybe come back after you've shrunk it down to a reasonable size?");
			return;
		}
	}
	
	if (IncrementFlag("COC.YARA_SEXED") == 1) {
		output("Her eyes widen as you begin to ");
		if(pc.lust() < 33) output("protest");
		else output("speak");
		output(", neatly silencing you with the lust-filled fires simmering in her eyes.  \"<i>Call it quality testing,</i>\" she purrs.  ");
	}
	
	output("Her free hand runs up and down your inner thigh, the ticklish teasing nearly making your head spin.  Licking her lips in anticipation, Yara wiggles out of her clothes and clambers onto the chair, kneeling on the armrests.  Due to her awkward posture, you find your gaze drifting to her wide-spread legs.  Nestled there, twinkling with a radiant luster, is a golden ring, looped through her already-throbbing clit.  A blush darkens her cheeks as she notices your stare, but she seems almost empowered by it.\n\n");

	output("Yara's free hand slides down her belly - past the stud in her navel - down to her box.  Using two fingers, she spreads her lips apart, giving you a great view of both her glistening button-piercing and the fleshy recesses past it.  She bites her bottom lip gently");
	if(!girl && pc.hasCock()) output(" as your [pc.cock " + x + "] rises to attention, her eyes fixed upon the stiffened tool.  You resist the urge to grab her thin-yet-girlish hips and power into her right then and there, curious enough to allow her teasing.");
	else output(" as a growing puddle of love stains the cushioned chair.  It takes most of your power to not drag her down and force her face into your box.");
	output("\n\n");

	output("She leans forward, planting you with a wet and lingering kiss.  She moves lower, kissing ");
	if(pc.biggestTitSize() < 1) output("your [pc.chest]");
	else output("your [pc.nipples], one at a time");
	output(" and smooching your [pc.belly].  Even with her racially characteristic flexibility, however, she's not able to get any lower from that angle.  \"<i>Hold this, dear,</i>\" she says somewhat snarkily, pivoting around and resting her ass against your [pc.chest].  In this new posture, Yara can easily have her way with your junk, and by the way her wagging tail keeps bopping you in the face you can tell she's excited.\n\n");

	output("Not content with simple penetration, it seems, the cat girl gets to work.");
	if(pc.balls > 0) output("  Her dexterous fingertips brush against your [pc.balls], light and fluttery strokes that send shivers coursing through you.  The near-lack of contact is at least as titillating as the less-subtle Marethians you've come across.");
	output("  She scoots forward a bit, dragging her soaking cunt down your chest in an effort to reach your crotch.\n\n");

	//male
	if(!girl && pc.hasCock()) {
		output("Yara's pursed lips touch down upon your cockhead, her head tilting from side to side as she vexingly and repeatedly kisses your [pc.cock " + x + "].  However, she abruptly pauses, glancing sidelong at you expectantly.  When you don't immediately respond, she huffs a sigh - onto your dick - and raises her hips level with your nose.  After momentarily getting lost in the bouncing of her tight-yet-jiggly cheeks, you get the message, leaning forward and giving her puffy sex a long and lingering lick.  You're rewarded with a low-pitched and very satisfied groan.  Though you go in for another taste, the shining ring looped through her joy-buzzer attracts your oral attention like a magnet.  Gently as a newborn kitten, your teeth close down on the clit-embedded trinket.  Yara goes absolutely stiff as you begin to softly tug the piercing around, neatly paralyzed by the sensitivity.  Indistinguishable mewling tumbles from her mouth as she attempts to attune herself to your yanking antics.  Her lithe frame spasms in ecstasy, forcing you to release your grip on her, lest something unfortunate happen to her undercarriage.\n\n");

		output("As soon as you release her from the mind-numbing grasp, she whips her hips forward - spattering your [pc.skinFurScales] with her downpour of girlcum in the process - and leaning back, hastily lining herself up with your [pc.cock " + x + "].  Only hesitating for a second to leak a bit of lubricant onto your eager shaft, she plummets downwards, not stopping until her ass slams against your pelvis.\n\n");

		output("Yara takes total control, her death-grip on the armrests giving her full coital maneuverability.  Despite the easy entry, you can't believe how well her sopping-wet folds squeeze against you.  For a long while the only sounds heard are the slapping of her cheeks and the studded-up cat girl's halting pants of pleasure.  \"<i>I wanna say... your new piercing... works like a charm,</i>\" she mutters between throaty groans.\n\n");

		output("Before you're even allowed to respond, Yara's pace quickens, her finish line in sight.  More than eager to help spur her on, your hands wrap around her slender waist.  She purrs in appreciation of your assistance.  It's not long before, with a victorious and primal scream, she throws all her weight downwards, splattering the mixture of pre-cum and femspunk and actually stinging you a bit with the force of her descent.\n\n");

		output("The powerful motion is all the motivation your body needs.  Before either of you can even consider the ramifications of an internal ejaculation, your bodies seize up, caught in the familiar grasp of orgasmic bliss.  ");

		//([cum quantity time, normal L/M/H/S quantities {IT'S A MARVEL REFERENCE} <no new paragraph>]
		//light and medium
		if(pc.cumQ() < 500) output("Yara's entire frame spasms as your load paints her private passage with [pc.cumColor] seed.  The cat girl writhes happily, arching her spine so far back your eyes nearly meet.\n\nYara dismounts your dick and hops to the ground in one fluid movement.");
		//heavy
		else if(pc.cumQ() <= 1500) output("Yara's belly visibly plumps with the quantity of [pc.cum] you pour into her, the extra weight bending her over to rest heavily against your [pc.leg].  She purrs happily, patting her distended gut even while the tremors of her own orgasm run through her.\n\nYara lifts herself off you, pressing a hand against her tummy as she somewhat ungracefully steps off the chair.");
		//special (super-big)
		else output("Her low-pitched ecstatic moans swiftly escalate to piercing shrieks as her taut belly quickly balloons to roughly beach ball-sized in moments.  With a huge effort, she manages to haul herself off your [pc.cumNoun]-pumping staff, falling back against you.  Sighing contentedly, Yara nestles herself into your [pc.chest], getting comfortable despite the [pc.cum] drizzling from her overstuffed nethers.  You just sit there for a few minutes, waiting patiently as your ejaculatory rampage ceases.\n\nYara makes a noble attempt to rise that is ultimately thwarted by her huge fluid-filled belly.  Casting a sidelong sheepish grin at you, she giggles nervously.  \"<i>Mind helping me out here, friend?</i>\" she says after a moment's hesitation.  With your assistance, she rises and stands on wobbling feet.  She tries her best to compose herself with your [pc.cum] still streaming down her thighs, the flow only intensifying as she impatiently presses against the bloated belly.");

		output("\n\n\"<i>Works like a charm,</i>\" she concludes as you both redress");
		if(pc.cumQ() > 1500) output(", Yara trying her best to fit her clothes over the bump in her midsection");
		output(".  \"<i>Come back whenever, okay?  I'm sure we can arrange another... appointment!</i>\"");
		//ZA ENDO
	}
	//female
	else {
		output("A duo of errant forefingers run along the perimeter of your feminine fortress, your signal to prepare for a siege.  Yara reaches down off the side of your seat, pushing on a lever that sends the back of the chair down to about a 30° angle.  She grasps for the armrests of the chair next, promptly lifting her body up and going into what looks like a forward somersault.  Before you can complement the feat, her legs fly up either side of your head.   The only things to have made contact were her nimble feet, gently stroking their way up from your [pc.belly], past your [pc.chest], off of your shoulders and soaring beyond the back of the chair.  The feline acrobat calls for you to lay your hands open at the sides of the chair, an order you fulfill with due haste.  She wastes no time in seizing your upper arms, causing her body to slide forward off of you.  You return the favor by clasping onto her as well in the same manner, stopping her descent.\n\n");

		output("Trying to parse out the scene at play here is a fool's errand.  Yara must have done this before as your two sprawled out bodies have stopped in just the right fashion to make both of your fleshy orifices in plain view of one another's faces.  Air escapes your pursed lips as the \"<i>quality testing</i>\" commences on your [pc.vagina], your kitty comrade going in tongue first towards your silken fringes.  ");
		if(pc.wetness() >= 3) output("She may as well be licking a melting popsicle with how wet your snatch is.");
		else output("Your relatively dry perimeter makes for an easy target.");
		output("  Not to be outdone, your ambitious [pc.tongue] moves in as if it has everything to prove, mirroring your partner's efforts. Both of your lapping endeavors are periodically interrupted by moaning or slight gasps, your grasps on one another only growing more tense.\n\n");

		output("Yara looks up - down in her case - at your [pc.clit], your feminine fragrance riling her up as if it were catnip. Your work on her box is interrupted as your pleasure buzzer gets the oral shebang of a lifetime, eliciting a knowing laugh from deep within your teammate's throat.  Yara's lucky you redouble your clamp on her arms rather than sending the poor woman sliding to the ground as your body writhes in satisfaction.  But this is war, and you'll be damned if you're weak enough to go straight for the crown jewel as she has. No, you go to town, redefining what it means to eat out a pussy.  Your laborious toil is rewarded as the kitten's assault on your button eases up.  Her hold begins to waver, however, forcing you to yank your prey towards you.  The movement pierces through her contentment, her armlock strengthening as the air fills with the sound of a duo of muffled moans.\n\n");

		output("Judging by the contortionist's wobbly embrace, you decide it's the perfect time to go in for the kill.  Yara stands no chance as you pounce for her pierced clit, your tongue lodging itself between the loop and her love-button.  It takes all of her willpower to maintain the offensive on your nub nexus while standing firm in her grasp on your arms.  Your oral tugging and teasing proves to be the victor, however, marked by the femspunk making its way right onto your face.  The cocktail combined with the orgasmic-enhanced last ditch effort by Yara on your nether regions triggers your own satisfying outburst.  The chain reaction ends in both your couplings faltering, sending the feline sliding headfirst for the floor.\n\n");

		output("Her head stops short, though.  Through your gasping relief, you managed to lock onto her legs.  \"<i>Nice... nice catch,</i>\" is about all Yara manages to share before resuming her purring contentment upside down, limp arms spread across the floor.  After a minute or so, the two of you regain some sort of composure, but the spectacular gymnast from before can only bare to slink around on the ground as she reorients herself.  The most you need to do is fix the back of your chair, lifting it to a more comfortable height.  \"<i>Can you spare one more helping hand here, friend?</i>\" Yara requests, now having at least managed to at least sit up straight.  The two of you exchange a knowing glance as you lift the metal-worker back to her feet.");
	}
	processTime(25);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", piercingStudio);
}