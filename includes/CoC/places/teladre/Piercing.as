import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

private function piercingStudio():void {
	//spriteSelect(63);
	clearOutput();
	clearMenu();
	
	output("The interior of the piercing studio is earthy, leaving the stone floors and walls uncovered, though the windows are covered with woven blankets, sewn from multicolored threads.  There are a number of cushy chairs facing a wall of mirrors, along with a shelf covered in needles, piercings, and strong alcohols.  A brunette prowls about the place, tidying it up during a lull in business.  You dully notice that unlike everyone else in this town, she's mostly human.  Perhaps she came through a portal as well?  She approaches you, and you see a cat tail waving behind her, and a pair of fuzzy feline ears, both covered in piercings, perched atop her head.  Clearly she's been here long enough to pick up some of the local flavor.\n\n", false);
	output("She introduces herself, \"<i>Hello there " + pc.mf("sir","cutie") + ", my name is Yara.  Would you like to get a piercing?</i>\"", false);
	//if (!flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) {
	addDisabledButton(0, "Pierce", "Pierce", "Not implemented");
	addDisabledButton(1, "Remove", "Remove", "Not implemented");
	if (flags["COC.YARA_TALKED"] == undefined)
		addButton(3, "About Her", aboutYara);
	addButton(14, "Leave", telAdreMenu);
	//} else
	//{
		//output("\n\n(Low Standard mode!)\nAlternatively, she might be open to a quick fuck if you ask.");
		//choices("Pierce", pierceMenu,
		        //"Remove", piercingRemove,
		        //"", null,
		        //"AsFemale", createCallBackFunction(letsDoYaraSex,true),
		        //"AsMale", createCallBackFunction(letsDoYaraSex,false),
		        //"About Her", about,
		        //"", null,
		        //"", null,
		        //"", null,
		        //"Leave", telAdreMenu);
	//}
}
private function aboutYara():void {
	//spriteSelect(63);
	flags["COC.YARA_TALKED"] = 1;
	output("You introduce yourself and ask Yara about her past, noting that ");
	if(pc.humanScore() <= 2 && pc.originalRace == "human") output("you were once a human too.");
	else output("you haven't seen many other humans about.");
	output("\n\nShe blushes a little when she answers, her tail curling about her protectively, \"<i>My home city was built around a portal, and the Baron that ruled it insisted that we send a sacrifice through every year.  We were raised believing that if we didn't sacrifice SOMEONE, the gods would become angry and bring our city to ruin.  Of course the whole thing was a sham, but the families of those sacrificed get compensation.  My father tried to whore me out first, but when that didn't work, the bastard had me drugged and sacrificed.  I woke up next to a lake, ate some weird fruit when I got hungry, and I... well, I changed.  Thankfully I found my way here before I ran into any demons, or who knows what would have happened to me!  Tel'Adre has been good to me, and I'm sure it'll be good to you.  Now, how about getting a piercing?</i>\"");
	//dynStats("int", 2, "lus", -5, "cor", -1);
	pc.slowStatGain("i", 2);
	pc.cor( -1);
	pc.lust( -5);
	doNext(piercingStudio);
}
//private function pierceMenu():void {
	//spriteSelect(63);
	//hideUpDown();
	//var clit:Function = null;
	//if(pc.hasVagina())
	//{
		//if(pc.vaginas[0].clitPierced == 0)
		//clit = clitPierce;
	//}
	//var dick:Function = null;
	//if(pc.hasCock)
	//{
		//if(pc.cocks[0].pierced == 0)
			//dick = dickPierce;
	//}
	//var ears:Function = null;
	//if(pc.earsPierced == 0)
		//ears = earPierce;
	//var eyebrow:Function = null;
	//if(pc.eyebrowPierced == 0)
		//eyebrow = eyebrowPierce;
	//var lip:Function = null;
	//if(pc.lipPierced == 0)
		//lip = lipPierce;
	//var nipples:Function = null;
	//if(pc.nipplesPierced == 0)
		//nipples = nipplePierce;
	//var nose:Function = null;
	//if(pc.nosePierced == 0)
		//nose = nosePierce;
	//var tongue:Function = null;
	//if(pc.tonguePierced == 0)
		//tongue = tonguePierce;
	//var vulva:Function = null;
	//if(pc.hasVagina())
	//{
		//if(pc.vaginas[0].labiaPierced == 0) vulva = vulvaPierce;
	//}
	//output("Yara asks, \"<i>Ok then, what would you like pierced " + pc.mf("sir","cutie") + "?  Just keep in mind my piercings are special - they're permanent and CAN'T be removed.</i>\"", true);
	//if(clit != null || dick != null || ears != null || eyebrow != null || lip != null || nipples != null || nose != null || tongue != null || vulva != null)
		//choices("Clit",clit,"Dick",dick,"Ears",ears,"Eyebrow",eyebrow,"Lip",lip,"Nipples",nipples,"Nose",nose,"Tongue",tongue,"Labia",vulva,"Back",piercingStudio);
	//else
	//{
		//output("\n\nYou give yourself a quick once-over and realize there's nowhere left for her to pierce you.  Oh well.", false);
		//doNext(piercingStudio);
	//}
//}
//
//private function dickPierce():void {
	//spriteSelect(63);
	//if(pc.hasCock) output("\"<i>Ok, this is gonna hurt a LOT, but I've heard good things about it.  What kind of piercing do you want done?</i>\" Yara asks.", true);
	//else {
		//output("You realize you don't have a dick to pierce.  Whoops!  Better pick something else...", true);
		//doNext(pierceMenu);
		//return;
	//}
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "Ladder", chooseLadder, "Back", pierceMenu, "Nevermind", piercingStudio);
	//piercingLoc = 1;
//}
//
//private function clitPierce():void {
	//spriteSelect(63);
	//if(pc.hasVagina()) output("\"<i>Ohhh, that's going to be suckably cute!</i>\" exclaims Yara, blushing more than a little. \"<i>What kind of piercing would you like?</i>", true);
	//else {
		//output("You realize you don't have a clit to pierce.  Whoops!  Better pick something else...", true);
		//doNext(pierceMenu);
		//return;
	//}
	//piercingLoc = 0;
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function earPierce():void {
	//spriteSelect(63);
	//piercingLoc = 2;
	//output("\"<i>Okay, just let me get my supplies and we can get started.  What kind of jewelry do you want in them?</i>\" asks Yara.", true);
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "Hoop", chooseHoop, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function eyebrowPierce():void {
	//spriteSelect(63);
	//piercingLoc = 3;
	//output("\"<i>Ah, that's a good look!  What do you want there?</i>\" asks Yara.", true);
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function lipPierce():void {
	//spriteSelect(63);
	//piercingLoc = 4;
	//output("\"<i>Oh my, that'll be HAWT!  What kind of jewelry do you want there?</i>\" asks Yara.", true);
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function nipplePierce():void {
	//spriteSelect(63);
	//piercingLoc = 5;
	//output("\"<i>Yeah, sure I can do those!  What kind of jewelry do you want there?  I'm partial to nipple-chains myself,</i>\" admits Yara, blushing bright red.", true);
	//simpleChoices("Studs", chooseStud, "Rings", chooseRing, "Chain", chooseChain, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function nosePierce():void {
	//spriteSelect(63);
	//piercingLoc = 6;
	//output("Yara wrinkles her nose in distaste, \"<i>Really?  Well ok, what do you want there?</i>\"", true);
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//
//private function tonguePierce():void {
	//spriteSelect(63);
	//piercingLoc = 7;
	//output("Yara happily purrs, \"<i>Oh my, I bet that'll be fun!  I'm afraid I can only put a stud there though, ok?</i>\"", true);
	//simpleChoices("Ok", chooseStud, "", null, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//private function vulvaPierce():void {
	//spriteSelect(63);
	//piercingLoc = 8;
	//if(pc.hasVagina()) output("Yara explains, \"<i>This is gonna hurt a lot, but I think you'll love how it feels after.  I know I do!  Now what kind of jewelry do you want down-town?</i>\"", true);
	//else {
		//output("You realize you don't have a pussy to pierce.  Whoops!  Better pick something else...", true);
		//doNext(pierceMenu);
		//return;
	//}
	//simpleChoices("Stud", chooseStud, "Ring", chooseRing, "", null, "Back", pierceMenu, "Nevermind", piercingStudio);
//}
//private function chooseStud():void {
	//piercingType = 1;
	//chooseMaterials();
//}
//private function chooseRing():void {
	//piercingType = 2;
	//chooseMaterials();
//}
//private function chooseLadder():void {
	//piercingType = 3;
	//chooseMaterials();
//}
//private function chooseHoop():void {
	//piercingType = 4;
	//chooseMaterials();
//}
//private function chooseChain():void {
	//piercingType = 5;
	//chooseMaterials();
//}
//
//private function chooseMaterials():void {
	//spriteSelect(63);
	//output("Yara gathers up her materials and says, \"<i>Ok, now what type of material do you want it made from?  Don't worry about price, none of these are that rare, so the piercing will only be 100 gems.  Though I do have some rarer materials; you'll need 1,000 gems to spend if you want to check them out.</i>\"", true);
	//if(pc.gems < 100) {
		//output("\n\nYou realize you don't have enough gems to get a piercing.", false);
		//doNext(piercingStudio);
		//return;
	//}
	//var rare:Function = null;
	//if(pc.gems >= 1000) rare = chooseAdvancedMaterials;
	//choices("Amethyst",chooseAmethyst,"Diamond",chooseDiamond,"Gold",chooseGold,"Emerald",chooseEmerald,"Jade",chooseJade,"Onyx",chooseOnyx,"Ruby",chooseRuby,"Steel",chooseSteel,"Rare Menu",rare,"Nevermind",piercingStudio);
//}
//private function chooseAmethyst():void {
	//piercingMat = 1;
	//areYouSure();
//}
//private function chooseDiamond():void {
	//piercingMat = 2;
	//areYouSure();
//}
//private function chooseGold():void {
	//piercingMat = 3;
	//areYouSure();
//}
//private function chooseEmerald():void {
	//piercingMat = 4;
	//areYouSure();
//}
//private function chooseJade():void {
	//piercingMat = 5;
	//areYouSure();
//}
//private function chooseOnyx():void {
	//piercingMat = 6;
	//areYouSure();
//}
//private function chooseRuby(): void {
	//piercingMat = 7;
	//areYouSure();
//}
//private function chooseSteel():void {
	//piercingMat = 8;
	//areYouSure();
//}
//private function chooseLethite():void {
	//piercingMat = 9;
	//areYouSure();
//}
//private function chooseFertite():void {
	//piercingMat = 10;
	//areYouSure();
//}
//private function chooseFurrite():void {
	//piercingMat = 11;
	//areYouSure();
//}
//private function chooseCrimstone():void {
	//piercingMat = 12;
	//areYouSure();
//}
//private function chooseIcestone():void {
	//piercingMat = 13;
	//areYouSure();
//}
//
//private function areYouSure():void {
	//spriteSelect(63);
	//output("Yara says, \"<i>Ok, last chance to back out, are you sure you want to go ahead with this?  Remember, once I put it in, it's permanent.</i>\"", true);
	//doYesNo(normalPierceAssemble,piercingStudio);
//}
	////9. Lethite (Demon Lure)
	////10. Fertite (Fertility Booster)
	////11. Furrite (Attracts Furries)
	////12. Crimstone - + min lust
//private function chooseAdvancedMaterials():void {
	//spriteSelect(63);
	//output("Yara goes back into the back and comes out with a gilded tray full of exotic materials.  She hands you a brochure and asks, \"<i>Ok, now what am I going to be working with?</i>\"", true);
	//output("\n\nThere's a number of materials listed here:", false);
	//output("\n1. Lethite - Fake lethicite.  While beautiful, it's known to attract demons.", false);
	//output("\n2. Fertite - A green gem sometimes fished up from the bottom of Mareth's great lake, it is said to enhance the fertility of both genders.", false);
	//output("\n3. Furrite - This beautiful purple gem is actually crystalized from materials used in hunting lures.  It is said to enhance the wearer's appeal to beast-people.", false);
	//output("\n4. Crimstone - Crimstone is said to be formed from volcanic fires, and to keep the fires of one's desires burning brightly.", false);
	//output("\n5. Icestone - Found from the Glacial Rift, this rare gem is said to counter the effects of Crimstone and quell ever-burning desires. This will annihilate some of crimstone magic. Due to its rarity, this costs 2000 gems instead.", false);
	//output("\n\n<b>DISCLAIMER</b>: Yara's Piercing Studio is not responsible if the piercee's body absorbs any residual magic of these stones, and is not required to resolve any issues if the effects persist beyond removal.</b>", false);
	//choices("Lethite", chooseLethite, "Fertite", chooseFertite, "Furrite", chooseFurrite, "Crimstone", chooseCrimstone, "", null, "", null, "", null, "", null, "", null, "Back", chooseMaterials);
	//if (pc.gems >= 2000) addButton(4, "Icestone", chooseIcestone);
//}
//
//private function normalPierceAssemble():void {
	//spriteSelect(63);
	//output("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled and before you know it, your piercing is done!", true);
	////1. Amethyst (+1 int, +1 lib)
	////2. Diamond (+2 int, -1 cor)
	////3. Gold (+1 int, +1 sens)
	////4. Emerald (+1 spe)
	////5. Jade (+1 spe, -.5 tou)
	////6. Onyx (+1 tou, -1 spe)
	////7. Ruby (+1 lib, +1 sens)
	////8. Steel (+2 str, -2 int)
	////9. Lethite (Demon Lure)
	////10. Fertite (Fertility Booster)
	////11. Furrite (Attracts Furries)
	////12. Crimsonite (+Min Lust)
	////13. Icestone (-Min Lust)
	////var piercingMat:Number = 0;
	//var shortP:String = "";
	//var longP:String = "";
	//pc.gems -= 100;
	//if (piercingMat > 8) pc.gems -= 900;
	//if (piercingMat == 13) pc.gems -= 1000;
	//statScreenRefresh();
	////set up material description
	//switch(piercingMat) {
		//case 1:
			//shortP += "amethyst ";
			//dynStats("int", 1, "lib", 1);
			//longP += "Amethyst ";
			//break;
		//case 2:
			//shortP += "diamond ";
			//dynStats("int", 2, "cor", -1);
			//longP += "Diamond ";
			//break;
		//case 3:
			//shortP += "gold ";
			//dynStats("int", 1, "sen", 1);
			//longP += "Gold ";
			//break;
		//case 4:
			//shortP += "emerald ";
			//dynStats("spe", 1);
			//longP += "Emerald ";
			//break;
		//case 5:
			//shortP += "jade ";
			//dynStats("tou", -.5, "int", 1, "cor", -1);
			//longP += "Jade ";
			//break;
		//case 6:
			//shortP += "onyx ";
			//dynStats("tou", 1, "spe", -1);
			//longP += "Onyx ";
			//break;
		//case 7:
			//shortP += "ruby ";
			//dynStats("lib", 1, "sen", 1);
			//longP += "Ruby ";
			//break;
		//case 8:
			//shortP += "steel ";
			//dynStats("str", 2,"int", -2);
			//longP += "Steel ";
			//break;
		//case 9:
			//shortP += "lethite ";
			//if(pc.findPerk(PerkLib.PiercedLethite) < 0) pc.createPerk(PerkLib.PiercedLethite,0,0,0,0);
			//longP += "Lethite ";
			//break;
		//case 10:
			//shortP += "fertite ";
			//if(pc.findPerk(PerkLib.PiercedFertite) < 0) pc.createPerk(PerkLib.PiercedFertite,5,0,0,0);
			//else pc.addPerkValue(PerkLib.PiercedFertite,1,5);
			//longP += "Fertite ";
			//break;
		//case 11:
			//shortP += "furrite ";
			//if(pc.findPerk(PerkLib.PiercedFurrite) < 0) pc.createPerk(PerkLib.PiercedFurrite,0,0,0,0);
			//longP += "Furrite ";
			//break;
		//case 12:
			//shortP += "crimstone ";
			//if (pc.findPerk(PerkLib.PiercedIcestone) >= 0) {
				//pc.addPerkValue(PerkLib.PiercedIcestone, 1, -5);
				//if (pc.perkv1(PerkLib.PiercedIcestone) <= 0) pc.removePerk(PerkLib.PiercedIcestone);
			//}
			//else {
				//if (pc.findPerk(PerkLib.PiercedCrimstone) <= 0) pc.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
				//else pc.addPerkValue(PerkLib.PiercedCrimstone, 1, 5);
			//}
			//longP += "Crimstone ";
			//break;
		//case 13:
			//shortP += "icestone ";
			//if (pc.findPerk(PerkLib.PiercedCrimstone) >= 0) {
				//pc.addPerkValue(PerkLib.PiercedCrimstone, 1, -5);
				//if (pc.perkv1(PerkLib.PiercedCrimstone) <= 0) pc.removePerk(PerkLib.PiercedCrimstone);
			//}
			//else {
				//if (pc.findPerk(PerkLib.PiercedIcestone) <= 0) pc.createPerk(PerkLib.PiercedIcestone, 5, 0, 0, 0);
				//else pc.addPerkValue(PerkLib.PiercedIcestone, 1, 5);
			//}
			//longP += "Icestone ";
			//break;
	//}
	//switch(piercingLoc) {
		///*
		//0) **Clit (+2 sens)
		//1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		//2) **Ears
		//3) **Eyebrow (-.5 def)
		//4) **Lip (-.5 def)
		//5) **Nipples (+1 sens, +1 lib)
		//6) **Nose (+.5 attack)
		//7) **Tongue (+1 sens)
		//8) **Vulva (+1 sens)*/
		////var piercingLoc:Number = 0;
		//case 0:
			//shortP += "clit-";
			//longP += "clit-";
			//dynStats("sen", 2);
			//break;
		//case 1:
			//if(piercingType == 3) break;
			//shortP += "cock-";
			//longP += "cock-";
			//dynStats("lib", 2);
			//break;
		//case 2:
			//shortP += "ear";
			//longP += "ear";
			//break;
		//case 3:
			//dynStats("tou", -.5);
			//shortP += "eyebrow-";
			//longP += "eyebrow-";
			//break;
		//case 4:
			//dynStats("tou", -.5);
			//shortP += "lip-";
			//longP += "lip-";
			//break;
		//case 5:
			//dynStats("lib", 1, "sen", 1);
			//shortP += "nipple-";
			//longP += "nipple-";
			//break;
		//case 6:
			//dynStats("str", .5);
			//shortP += "nose-";
			//longP += "nose-";
			//break;
		//case 7:
			//dynStats("sen", 1);
			//shortP += "tongue-";
			//longP += "tongue-";
			//break;
		//case 8:
			//dynStats("sen", 1);
			//shortP += "labia-";
			//longP += "labia-";
			//break
	//}
	//switch(piercingType) {
		////studs
		//case 1:
			////multiples
			//if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				//shortP += "studs";
				//longP += "studs";
			//}
			//else {
				//shortP += "stud";
				//longP += "stud";
			//}
			//break;
		////2. Ring (Called prince albert on dick)
		//case 2:
			////multiples
			//if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				//shortP += "rings";
				//longP += "rings";
			//}
			//else {
				//shortP += "ring";
				//longP += "ring";
			//}
			//break;
		////3. Jacobs Ladder (dick only)
		//case 3:
			//shortP += "jacob's ladder";
			//longP += "jacob's ladder";
			//break;
		////4. Hoop (ears/nipples/clit)
		//case 4:
			////multiples
			//if(piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				//shortP += "hoops";
				//longP += "hoops";
			//}
			//else {
				//shortP += "hoop";
				//longP += "hoop";
			//}
			//break;
		////5. Chain (nipples only)
		//case 5:
			//shortP += "chain";
			//longP += "chain";
			//break;
	//}
	////Actually assign values to their real storage locations
	//switch(piercingLoc) {
		///*
		//0) **Clit (+2 sens)
		//1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		//2) **Ears
		//3) **Eyebrow (-.5 def)
		//4) **Lip (-.5 def)
		//5) **Nipples (+1 sens, +1 lib)
		//6) **Nose (+.5 attack)
		//7) **Tongue (+1 sens)
		//8) **Vulva (+1 sens)*/
		////var piercingLoc:Number = 0;
		//case 0:
			//pc.vaginas[0].clitPierced = piercingType;
			//pc.vaginas[0].clitPShort = shortP;
			//pc.vaginas[0].clitPLong = longP;
			//break;
		//case 1:
			//pc.cocks[0].pierced = piercingType;
			//pc.cocks[0].pShortDesc = shortP;
			//pc.cocks[0].pLongDesc = longP;
			//break;
		//case 2:
			//pc.earsPierced = piercingType;
			//pc.earsPShort = shortP;
			//pc.earsPLong = longP;
			//break;
		//case 3:
			//pc.eyebrowPierced = piercingType;
			//pc.eyebrowPShort = shortP;
			//pc.eyebrowPLong = longP;
			//break;
		//case 4:
			//pc.lipPierced = piercingType;
			//pc.lipPShort = shortP;
			//pc.lipPLong = longP;
			//break;
		//case 5:
			//pc.nipplesPierced = piercingType;
			//pc.nipplesPShort = shortP;
			//pc.nipplesPLong = longP;
			//break;
		//case 6:
			//pc.nosePierced = piercingType;
			//pc.nosePShort = shortP;
			//pc.nosePLong = longP;
			//break;
		//case 7:
			//pc.tonguePierced = piercingType;
			//pc.tonguePShort = shortP;
			//pc.tonguePLong = longP;
			//break;
		//case 8:
			//pc.vaginas[0].labiaPierced = piercingType;
			//pc.vaginas[0].labiaPShort = shortP;
			//pc.vaginas[0].labiaPLong = longP;
			//break;
	//}
	////Girls
	//if(piercingLoc == 8 || piercingLoc == 0) {
		//yaraSex();
		//return;
	//}
	////Dudes
	//else if(piercingLoc == 1 && (pc.cockThatFits(36) >= 0 || flags[kFLAGS.HYPER_HAPPY])) {
		//yaraSex(false);
		//return;
	//}
	////Piercing shop main menu
	//doNext(piercingStudio);
//}
//
//
//private function piercingRemove():void {
	//spriteSelect(63);
	//hideUpDown();
	//var clit:Function = null;
	//if(pc.hasVagina()) {
		//if(pc.vaginas[0].clitPierced > 0) clit = removeClitPierce;
	//}
	//var dick:Function = null;
	//if(pc.hasCock) {
		//if(pc.cocks[0].pierced > 0) dick = removeCockPierce;
	//}
	//var ears:Function = null;
	//if(pc.earsPierced > 0) ears = removeEarsPierce;
	//var eyebrow:Function = null;
	//if(pc.eyebrowPierced > 0) eyebrow = removeEyebrowPierce;
	//var lip:Function = null;
	//if(pc.lipPierced > 0) lip = removeLipPierce;
	//var nipples:Function = null;
	//if(pc.nipplesPierced > 0) nipples = removeNipplesPierce;
	//var nose:Function = null;
	//if(pc.nosePierced > 0) nose = removeNosePierce;
	//var tongue:Function = null;
	//if(pc.tonguePierced > 0) tongue = removeTonguePierce;
	//var vulva:Function = null;
	//if(pc.hasVagina()) {
		//if(pc.vaginas[0].labiaPierced > 0) vulva = removeVulvaPierce;
	//}
	//if(clit == null && dick == null && ears == null && eyebrow == null && lip == null && nipples == null && nose == null && tongue == null && vulva == null) {
		//output("Yara giggles, \"<i>You don't have any piercings, silly!</i>\"", true);
		//doNext(piercingStudio);
		//return;
	//}
	//output("\"<i>Really?</i>\" asks Yara, \"<i>I told you those piercings are permanent!  Well, I suppose they CAN be removed, but you're gonna hurt like hell afterwards.  If you really want me to, I can remove something, but it'll cost you 100 gems for the painkillers and labor.</i>\"", true);
	//if(pc.gems < 100) {
		//output("\n\n<b>You do not have enough gems.</b>", false);
		//doNext(piercingStudio);
		//return;
	//}
	//if(pc.tou <= 5.5) {
		//output("Yara looks you up and down before refusing you outright, \"<i>You don't look so good " + pc.short + ".  I don't think your body could handle it right now.</i>\"", true);
		//doNext(piercingStudio);
		//return;
	//}
	//choices("Clit",clit,"Dick",dick,"Ears",ears,"Eyebrow",eyebrow,"Lip",lip,"Nipples",nipples,"Nose",nose,"Tongue",tongue,"Labia",vulva,"Back",piercingStudio);
//}
//
//private function removeClitPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.vaginas[0].clitPierced = 0;
	//pc.vaginas[0].clitPShort = "";
	//pc.vaginas[0].clitPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeCockPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.cocks[0].pierced = 0;
	//pc.cocks[0].pShortDesc = "";
	//pc.cocks[0].pLongDesc = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeEarsPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.earsPierced = 0;
	//pc.earsPShort = "";
	//pc.earsPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeEyebrowPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.eyebrowPierced = 0;
	//pc.eyebrowPShort = "";
	//pc.eyebrowPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeLipPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.lipPierced = 0;
	//pc.lipPShort = "";
	//pc.lipPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeNipplesPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.nipplesPierced = 0;
	//pc.nipplesPShort = "";
	//pc.nipplesPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeNosePierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.nosePierced = 0;
	//pc.nosePShort = "";
	//pc.nosePLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeTonguePierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.tonguePierced = 0;
	//pc.tonguePShort = "";
	//pc.tonguePLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}
//
//private function removeVulvaPierce():void {
	//spriteSelect(63);
	//output("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	//pc.vaginas[0].labiaPierced = 0;
	//pc.vaginas[0].labiaPShort = "";
	//pc.vaginas[0].labiaPLong = "";
	//dynStats("tou", -5);
	//pc.gems -= 100;
	//statScreenRefresh();
	//doNext(piercingStudio);
//}



//private function yaraSex(girl:Boolean = true):void {
	//spriteSelect(63);
	//clearOutput();
	//output("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled. Before you know it, your piercing is done!  You move to rise, retaining a bit of modesty", false);
	//if(flags[kFLAGS.PC_FETISH] > 0) output(" despite the guilty thrill", false);
	//output(".  \"<i>Hold it,</i>\" Yara commands softly, pressing her hand against your " + chestDesc() + " and pushing you back in your chair.  \"<i>Do you think I'll let you get away without some... field testing?</i>\"\n\n", false);
//
	//output("She seems intent on getting some loving - would you like to turn her down, or will you let nature run its course?", false);
	////[not at all] [yeah baby]
	//if (girl)
		//simpleChoices("Turn down", piercingStudio, "Oh yeah!", createCallBackFunction(letsDoYaraSex, true), "", null, "", null, "", null);
	//else simpleChoices("Turn down", piercingStudio, "Oh yeah!", createCallBackFunction(letsDoYaraSex, false), "", null, "", null, "", null);
//}
//
//private function letsDoYaraSex(girl:Boolean = true):void {
	//spriteSelect(63);
	//clearOutput();
	//var x:Number = pc.cockThatFits(36);
	//if (flags[kFLAGS.HYPER_HAPPY])
	//{
		//x = pc.cockThatFits(50000);
	//}
	//else if ((x == -1) && !girl)  // No cock that fits
	//{
		//if (pc.hasVagina()) // But the PC has a vagoo! Swap over to female mode"
		//{
			//output("\"<i>Oh dear, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. \"<i>Oh well</i>\", she sighs. \"<i>I guess I'll just have to explore your feminine side instead</i>\"\n");
			//girl = true;
//
		//}
		//else
		//{
			//output("\"<i>I'm sorry, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. Maybe come back after you've shrunk it down to a reasonable size?");
			//return;
		//}
	//}
	//output("Her eyes widen as you begin to ", false);
	//if(pc.lust < 50) output("protest", false);
	//else output("speak", false);
	//output(", neatly silencing you with the lust-filled fires simmering in her eyes.  \"<i>Call it quality testing,</i>\" she purrs.  Her free hand runs up and down your inner thigh, the ticklish teasing nearly making your head spin.  Licking her lips in anticipation, Yara wiggles out of her clothes and clambers onto the chair, kneeling on the armrests.  Due to her awkward posture, you find your gaze drifting to her wide-spread legs.  Nestled there, twinkling with a radiant luster, is a golden ring, looped through her already-throbbing clit.  A blush darkens her cheeks as she notices your stare, but she seems almost empowered by it.\n\n", false);
//
	//output("Yara's free hand slides down her belly - past the stud in her navel - down to her box.  Using two fingers, she spreads her lips apart, giving you a great view of both her glistening button-piercing and the fleshy recesses past it.  She bites her bottom lip gently", false);
	//if(!girl && pc.hasCock()) output(" as your [pc.cock " + x + "] rises to attention, her eyes fixed upon the stiffened tool.  You resist the urge to grab her thin-yet-girlish hips and power into her right then and there, curious enough to allow her teasing.", false);
	//else output(" as a growing puddle of love stains the cushioned chair.  It takes most of your power to not drag her down and force her face into your box.", false);
	//output("\n\n", false);
//
	//output("She leans forward, planting you with a wet and lingering kiss.  She moves lower, kissing ", false);
	//if(pc.biggestTitSize() < 1) output("your chest", false);
	//else output("your nipples, one at a time", false);
	//output(" and smooching your belly.  Even with her racially characteristic flexibility, however, she's not able to get any lower from that angle.  \"<i>Hold this, dear,</i>\" she says somewhat snarkily, pivoting around and resting her ass against your " + chestDesc() + ".  In this new posture, Yara can easily have her way with your junk, and by the way her wagging tail keeps bopping you in the face you can tell she's excited.\n\n", false);
//
	//output("Not content with simple penetration, it seems, the cat girl gets to work.", false);
	//if(pc.balls > 0) output("  Her dexterous fingertips brush against your [pc.balls], light and fluttery strokes that send shivers coursing through you.  The near-lack of contact is at least as titillating as the less-subtle Marethians you've come across.", false);
	//output("  She scoots forward a bit, dragging her soaking cunt down your chest in an effort to reach your crotch.\n\n", false);
//
	////male
	//if(!girl && pc.hasCock()) {
		//output("Yara's pursed lips touch down upon your cockhead, her head tilting from side to side as she vexingly and repeatedly kisses your [pc.cock " + x + "].  However, she abruptly pauses, glancing sidelong at you expectantly.  When you don't immediately respond, she huffs a sigh - onto your dick - and raises her hips level with your nose.  After momentarily getting lost in the bouncing of her tight-yet-jiggly cheeks, you get the message, leaning forward and giving her puffy sex a long and lingering lick.  You're rewarded with a low-pitched and very satisfied groan.  Though you go in for another taste, the shining ring looped through her joy-buzzer attracts your oral attention like a magnet.  Gently as a newborn kitten, your teeth close down on the clit-embedded trinket.  Yara goes absolutely stiff as you begin to softly tug the piercing around, neatly paralyzed by the sensitivity.  Indistinguishable mewling tumbles from her mouth as she attempts to attune herself to your yanking antics.  Her lithe frame spasms in ecstasy, forcing you to release your grip on her, lest something unfortunate happen to her undercarriage.\n\n", false);
//
		//output("As soon as you release her from the mind-numbing grasp, she whips her hips forward - spattering your [pc.gear] with her downpour of girlcum in the process - and leaning back, hastily lining herself up with your [pc.cock " + x + "].  Only hesitating for a second to leak a bit of lubricant onto your eager shaft, she plummets downwards, not stopping until her ass slams against your pelvis.\n\n", false);
//
		//output("Yara takes total control, her death-grip on the armrests giving her full coital maneuverability.  Despite the easy entry, you can't believe how well her sopping-wet folds squeeze against you.  For a long while the only sounds heard are the slapping of her cheeks and the studded-up cat girl's halting pants of pleasure.  \"<i>I wanna say... your new piercing... works like a charm,</i>\" she mutters between throaty groans.\n\n", false);
//
		//output("Before you're even allowed to respond, Yara's pace quickens, her finish line in sight.  More than eager to help spur her on, your hands wrap around her slender waist.  She purrs in appreciation of your assistance.  It's not long before, with a victorious and primal scream, she throws all her weight downwards, splattering the mixture of pre-cum and femspunk and actually stinging you a bit with the force of her descent.\n\n", false);
//
		//output("The powerful motion is all the motivation your body needs.  Before either of you can even consider the ramifications of an internal ejaculation, your bodies seize up, caught in the familiar grasp of orgasmic bliss.  ", false);
//
		////([cum quantity time, normal L/M/H/S quantities {IT'S A MARVEL REFERENCE} <no new paragraph>]
		////light and medium
		//if(pc.cumQ() < 500) output("Yara's entire frame spasms as your load paints her private passage with snowy-white seed.  The cat girl writhes happily, arching her spine so far back your eyes nearly meet.\n\nYara dismounts your dick and hops to the ground in one fluid movement.", false);
		////heavy
		//else if(pc.cumQ() <= 1500) output("Yara's belly visibly plumps with the quantity of cum you pour into her, the extra weight bending her over to rest heavily against your " + pc.leg() + ".  She purrs happily, patting her distended gut even while the tremors of her own orgasm run through her.\n\nYara lifts herself off you, pressing a hand against her tummy as she somewhat ungracefully steps off the chair.", false);
		////special (super-big)
		//else output("Her low-pitched ecstatic moans swiftly escalate to piercing shrieks as her taut belly quickly balloons to roughly beach ball-sized in moments.  With a huge effort, she manages to haul herself off your semen-pumping staff, falling back against you.  Sighing contentedly, Yara nestles herself into your " + chestDesc() + ", getting comfortable despite the seed drizzling from her overstuffed nethers.  You just sit there for a few minutes, waiting patiently as your ejaculatory rampage ceases.\n\nYara makes a noble attempt to rise that is ultimately thwarted by her huge fluid-filled belly.  Casting a sidelong sheepish grin at you, she giggles nervously.  \"<i>Mind helping me out here, friend?</i>\" she says after a moment's hesitation.  With your assistance, she rises and stands on wobbling feet.  She tries her best to compose herself with your cum still streaming down her thighs, the flow only intensifying as she impatiently presses against the bloated belly.", false);
//
		//output("\n\n\"<i>Works like a charm,</i>\" she concludes as you both redress", false);
		//if(pc.cumQ() > 1500) output(", Yara trying her best to fit her clothes over the bump in her midsection", false);
		//output(".  \"<i>Come back whenever, okay?  I'm sure we can arrange another... appointment!</i>\"", false);
		////ZA ENDO
	//}
	////female
	//else {
		//output("A duo of errant forefingers run along the perimeter of your feminine fortress, your signal to prepare for a siege.  Yara reaches down off the side of your seat, pushing on a lever that sends the back of the chair down to about a 30º angle.  She grasps for the armrests of the chair next, promptly lifting her body up and going into what looks like a forward somersault.  Before you can complement the feat, her legs fly up either side of your head.   The only things to have made contact were her nimble feet, gently stroking their way up from your belly, past your chest, off of your shoulders and soaring beyond the back of the chair.  The feline acrobat calls for you to lay your hands open at the sides of the chair, an order you fulfill with due haste.  She wastes no time in seizing your upper arms, causing her body to slide forward off of you.  You return the favor by clasping onto her as well in the same manner, stopping her descent.\n\n", false);
//
		//output("Trying to parse out the scene at play here is a fool's errand.  Yara must have done this before as your two sprawled out bodies have stopped in just the right fashion to make both of your fleshy orifices in plain view of one another's faces.  Air escapes your pursed lips as the \"<i>quality testing</i>\" commences on your " + vaginaDescript() + ", your kitty comrade going in tongue first towards your silken fringes.  ", false);
		//if(pc.wetness() >= 3) output("She may as well be licking a melting popsicle with how wet your snatch is.", false);
		//else output("Your relatively dry perimeter makes for an easy target.", false);
		//output("  Not to be outdone, your ambitious tongue moves in as if it has everything to prove, mirroring your partner's efforts. Both of your lapping endeavors are periodically interrupted by moaning or slight gasps, your grasps on one another only growing more tense.\n\n", false);
//
		//output("Yara looks up - down in her case - at your " + clitDescript() + ", your feminine fragrance riling her up as if it were catnip. Your work on her box is interrupted as your pleasure buzzer gets the oral shebang of a lifetime, eliciting a knowing laugh from deep within your teammate's throat.  Yara's lucky you redouble your clamp on her arms rather than sending the poor woman sliding to the ground as your body writhes in satisfaction.  But this is war, and you'll be damned if you're weak enough to go straight for the crown jewel as she has. No, you go to town, redefining what it means to eat out a pussy.  Your laborious toil is rewarded as the kitten's assault on your button eases up.  Her hold begins to waver, however, forcing you to yank your prey towards you.  The movement pierces through her contentment, her armlock strengthening as the air fills with the sound of a duo of muffled moans.\n\n", false);
//
		//output("Judging by the contortionist's wobbly embrace, you decide it's the perfect time to go in for the kill.  Yara stands no chance as you pounce for her pierced clit, your tongue lodging itself between the loop and her love-button.  It takes all of her willpower to maintain the offensive on your nub nexus while standing firm in her grasp on your arms.  Your oral tugging and teasing proves to be the victor, however, marked by the femspunk making its way right onto your face.  The cocktail combined with the orgasmic-enhanced last ditch effort by Yara on your nether regions triggers your own satisfying outburst.  The chain reaction ends in both your couplings faltering, sending the feline sliding headfirst for the floor.\n\n", false);
//
		//output("Her head stops short, though.  Through your gasping relief, you managed to lock onto her legs.  \"<i>Nice... nice catch,</i>\" is about all Yara manages to share before resuming her purring contentment upside down, limp arms spread across the floor.  After a minute or so, the two of you regain some sort of composure, but the spectacular gymnast from before can only bare to slink around on the ground as she reorients herself.  The most you need to do is fix the back of your chair, lifting it to a more comfortable height.  \"<i>Can you spare one more helping hand here, friend?</i>\" Yara requests, now having at least managed to at least sit up straight.  The two of you exchange a knowing glance as you lift the metal-worker back to her feet.", false);
	//}
	//pc.orgasm();
	//doNext(piercingStudio);
//}