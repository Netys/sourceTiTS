import classes.Characters.PlayerCharacter;
import classes.GLOBAL;
import classes.Items.Apparel.CoCBra;
import classes.Items.Apparel.CoCLoincloth;
import classes.Items.Apparel.CoCPanties;
import classes.Items.Apparel.ComfortableClothes;
import classes.Items.Melee.Rock;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function createYourChampion():void {
	clearOutput();
	output("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
	output("What is your name?");
	
	if(chars["PC_COC"] == undefined) {
		chars["PC_TITS"] = chars["PC"];
		chars["PC_COC"] = new PlayerCharacter();
		chars["PC"] = chars["PC_COC"];
	}
	
	pc.createStatusEffect("In Creation",0,0,0,0);
	pc.characterClass = GLOBAL.CLASS_ADVENTURER;
	
	pc.short = "Champion";
	pc.credits = 0;
	pc.personality = 0;
	
	pc.maxOutHP();
	
	CombatManager.TerminateCombat();
	userInterface.hideNPCStats();
	userInterface.leftBarDefaults();
	userInterface.resetPCStats();
	userInterface.hideTime();
	
	displayInput();
	userInterface.textInput.text = "";
	userInterface.textInput.maxChars = 33;
	
	clearMenu();
	addButton(0, "OK", chooseName);
}

private function chooseName():void {
	if(userInterface.textInput.text == "") {
		createYourChampion();
		output("\n\n\n\n<b>You must input a name.</b>");
		return;
	}
	
	// Illegal characters check. Just in case...
	if(hasIllegalInput(userInterface.textInput.text)) {
		createYourChampion();
		output("\n\n\n\n<b>To prevent complications, please avoid using code in the name.</b>");
		return;
	}
	if(userInterface.textInput.length > 16) {
		createYourChampion();
		output("\n\n\n\n<b>Please select a name no more than sixteen characters long.</b>");
		return;
	}
	
	pc.short = userInterface.textInput.text
	
	if(stage.contains(userInterface.textInput)) removeInput();
	genericGenderChoice();
}

private function genericGenderChoice():void {
	clearOutput();
	output("Are you a man or a woman?");
	clearMenu();
	addButton(0, "Man", genderSet, 1);
	addButton(1, "Woman", genderSet, 3);
	addButton(2, "Herm", genderSet, 2);
}

private function genderSet(sex:int = 1):void {
	//Genetalia
	if (sex == 1 || sex == 2) {
		pc.createCock();
		pc.balls = 2;
		pc.ballSizeRaw = 1.5;
		//MALE!
		if(sex == 1)
		{
			pc.tallness = 6 * 12;
			pc.femininity = 30;
			pc.hipRatingRaw = 1;
			pc.buttRatingRaw = 2;
			pc.tone = 65;
			pc.hairLength = 1;
		}
		//HERM!
		else
		{
			pc.tallness = 5 * 12 + 9;
			pc.femininity = 65;
			pc.hipRatingRaw = 6;
			pc.buttRatingRaw = 3;
			pc.tone = 45;
			pc.breastRows[0].breastRatingRaw = 3;
			pc.hairLength = 6;
		}
	}
	//Girls or herms? Cunt stuff
	if (sex >= 2) {
		pc.createVagina();
		if(sex == 3)
		{
			pc.tallness = 5 * 12 + 6;
			pc.femininity = 75;
			pc.hipRatingRaw = 6;
			pc.buttRatingRaw = 3;
			pc.tone = 45;
			pc.breastRows[0].breastRatingRaw = 3;
			pc.hairLength = 10;
		}
	}
	
	//Choices
	clearOutput();
	if(sex == 1) output("You are a man.");
	else if (sex == 2) output("You are a herm.");
	else output("You are a woman.");
	output("\n\nWhat type of build do you have?");
	
	if(sex == 1) {
		addButton(0, "F. Slender", buildSet, 0, "Feminine, Slender", "This option would make you shemale. Low thickness, tight butt, average hips, B-cup breasts.");
		addButton(1, "F. Average", buildSet, 1, "Feminine, Average", "This option would make you shemale. Average thickness, average butt, average hips, C-cup breasts.");
		addButton(2, "F. Curvy", buildSet, 2, "Feminine, Curvy", "This option would make you shemale. High thickness, large butt, curvy hips, D-cup breasts.");
		//addButton(3, "F. Tomboy", buildSet, 3, "Feminine, Tomboy", "This option would make you shemale. Low femininity, average thickness, tight butt, slender hips, A-cup breasts.");
		addDisabledButton(3, "F. Tomboy");
		
		addButton(5, "M. Lean", buildSet, 5, "Masculine, Lean", "High tone and low thickness.");
		addButton(6, "M. Average", buildSet, 6, "Masculine, Average", "Average tone and thickness.");
		addButton(7, "M. Thick", buildSet, 7, "Masculine, Thick", "Low tone and high thickness.");
		addButton(8, "M. Girly", buildSet, 8, "Masculine, Girly", "High femininity and low tone, A-cup breasts.");
	}
	else if(sex == 3) {
		addButton(0, "F. Slender", buildSet, 0, "Feminine, Slender", "Low thickness, tight butt, average hips, B-cup breasts.");
		addButton(1, "F. Average", buildSet, 1, "Feminine, Average", "Average thickness, average butt, average hips, C-cup breasts.");
		addButton(2, "F. Curvy", buildSet, 2, "Feminine, Curvy", "High thickness, large butt, curvy hips, D-cup breasts.");
		addButton(3, "F. Tomboy", buildSet, 3, "Feminine, Tomboy", "Low femininity, average thickness, tight butt, slender hips, A-cup breasts.");
		
		addButton(5, "M. Lean", buildSet, 5, "Masculine, Lean", "This option would make you cuntboy. High tone and low thickness.");
		addButton(6, "M. Average", buildSet, 6, "Masculine, Average", "This option would make you cuntboy. Average tone and thickness.");
		addButton(7, "M. Thick", buildSet, 7, "Masculine, Thick", "This option would make you cuntboy. Low tone and high thickness.");
		//addButton(8, "M. Girly", buildSet, 8, "Masculine, Girly", "This option would make you cuntboy. High femininity and low tone, A-cup breasts.");
		addDisabledButton(8, "M. Girly");
	}
	else {
		addButton(0, "F. Slender", buildSet, 0, "Feminine, Slender", "Low thickness, tight butt, average hips, B-cup breasts.");
		addButton(1, "F. Average", buildSet, 1, "Feminine, Average", "Average thickness, average butt, average hips, C-cup breasts.");
		addButton(2, "F. Curvy", buildSet, 2, "Feminine, Curvy", "High thickness, large butt, curvy hips, D-cup breasts.");
		addButton(3, "F. Tomboy", buildSet, 3, "Feminine, Tomboy", "Low femininity, average thickness, tight butt, slender hips, A-cup breasts.");
		
		addButton(5, "M. Lean", buildSet, 5, "Masculine, Lean", "This option would make you maleherm. High tone and low thickness.");
		addButton(6, "M. Average", buildSet, 6, "Masculine, Average", "This option would make you maleherm. Average tone and thickness.");
		addButton(7, "M. Thick", buildSet, 7, "Masculine, Thick", "This option would make you maleherm. Low tone and high thickness.");
		//addButton(8, "M. Girly", buildSet, 8, "Masculine, Girly", "This option would make you maleherm. High femininity and low tone, A-cup breasts.");
		addDisabledButton(8, "M. Girly");
	}
}

private function buildSet(type:int):void {
	switch(type) {
		case 0: // F. Slender
			pc.femininity = 66;
			pc.thickness = 30;
			pc.tone = 50;
			pc.breastRows[0].breastRatingRaw = 2;
			pc.buttRatingRaw = 3;
			pc.hipRatingRaw = 6;
			pc.tallness = 5 * 12 + 8;
			break;
		case 1: // F. Average
			pc.femininity = 70;
			pc.thickness = 50;
			pc.breastRows[0].breastRatingRaw = 3;
			pc.buttRatingRaw = 6;
			pc.hipRatingRaw = 6;
			pc.tallness = 5 * 12 + 8;
			break;
		case 2: // F. Curvy
			pc.femininity = 71;
			pc.thickness = 70;
			pc.breastRows[0].breastRatingRaw = 4;
			pc.buttRatingRaw = 8;
			pc.hipRatingRaw = 10;
			pc.tallness = 5 * 12 + 8;
			break;
		case 3: // F. Tomboy
			pc.femininity = 56;
			pc.thickness = 50;
			pc.tone = 50;
			pc.breastRows[0].breastRatingRaw = 1;
			pc.buttRatingRaw = 2;
			pc.hipRatingRaw = 2;
			pc.tallness = 5 * 12 + 9; // taller than most womans
			break;
		// no case 4 here
		case 5: // M. Lean
			pc.femininity = 34;
			pc.thickness = 30;
			pc.tone = 70;
			pc.breastRows[0].breastRatingRaw = 0;
			pc.buttRatingRaw = 2;
			pc.hipRatingRaw = 2;
			pc.tallness = 5 * 12 + 11;
			break;
		case 6: // M. Average
			pc.femininity = 30;
			pc.thickness = 50;
			pc.breastRows[0].breastRatingRaw = 0;
			pc.buttRatingRaw = 4;
			pc.hipRatingRaw = 4;
			pc.tallness = 5 * 12 + 11;
			break;
		case 7: // M. Thick
			pc.femininity = 29;
			pc.thickness = 70;
			pc.tone = 60;
			pc.breastRows[0].breastRatingRaw = 0;
			pc.buttRatingRaw = 6;
			pc.hipRatingRaw = 4;
			pc.tallness = 5 * 12 + 11;
			break;
		case 8: // M. Girly
			pc.femininity = 50;
			pc.thickness = 50;
			pc.tone = 26;
			pc.breastRows[0].breastRatingRaw = 1;
			pc.buttRatingRaw = 3;
			pc.hipRatingRaw = 2;
			pc.tallness = 5 * 12 + 9; // smaller than most men
			break;
	}
	chooseComplexion();
}

private function chooseComplexion():void {
	clearOutput();
	output("What is your complexion?");
	clearMenu();
	addButton(0, "Pale", setComplexion, "pale");
	addButton(1, "Fair", setComplexion, "fair");
	addButton(2, "Tan", setComplexion, "tan");
	addButton(3, "Olive", setComplexion, "olive");
	addButton(4, "Dark", setComplexion, "dark");
	addButton(5, "Ebony", setComplexion, "ebony");
}

private function setComplexion(choice:String):void { //And choose hair
	pc.skinTone = choice;
	clearOutput();
	output("You selected a " + choice + " complexion.\n\nWhat color is your hair?");
	clearMenu();
	addButton(0,"Black",setHair,"black");
	addButton(1,"Brown",setHair,"brown");
	addButton(2,"Dirty Blond",setHair,"dirty blond");
	addButton(3,"Blond",setHair,"blond");
	addButton(4,"Auburn",setHair,"auburn");
	addButton(5,"Red",setHair,"red");
	addButton(6,"Gray",setHair,"gray");
}

private function setHair(choice:String):void {
	pc.hairColor = choice;
	clearOutput();
	output("You have " + pc.hairDescript() + ". ");
	//chooseEndowment(false);
	eyeColorSelector();
}

private function eyeColorSelector():void {
	clearOutput();
	output("What is your eyes color?");
	clearMenu();
	addButton(0,"Blue",setEyeColor,"blue");
	addButton(1,"Green",setEyeColor,"green");
	addButton(2,"Hazel",setEyeColor,"hazel");
	addButton(3,"Brown",setEyeColor,"brown");
}

public function setEyeColor(eyeColor:String = "brown"):void {
	pc.eyeColor = eyeColor;
	chooseAffinity();
}

public function chooseAffinity():void {
	clearOutput();
	output("Every person is born with an affinity to certain ability.  What's yours?");
	
	clearMenu();
	addButton(0, "Intelligence", setAffinity, "intelligence", "Intelligence", "Increases the effectiveness of magic attacks.");
	addButton(1, "Physique", setAffinity, "physique", "Physique", "Increases your strength and endurance. It is especially useful for increasing the damage of any melee strikes you may land on an opponent.");
	addButton(2, "Reflexes", setAffinity, "reflexes", "Reflexes", "Increases your reaction time. Comes in handy when having to avoid a surprise attack or trap.");
	addButton(3, "Aim", setAffinity, "aim", "Aim", "Increases your accuracy and how well you can use ranged weapons.");
	addButton(4, "Willpower", setAffinity, "willpower", "Willpower", "Increases your ability to counter urges and addictions.");
	addButton(13, "None", setAffinity, "none", "No Affinity", "You will not have a natural affinity towards any certain attribute.");
}

public function setAffinity(arg:String = "intelligence"):void {
	pc.affinity = arg;
	chooseEndowment(true);
}

//-----------------
//-- STARTER PERKS
//-----------------
private function chooseEndowment(clear:Boolean):void {
	if (clear) clearOutput();
	output("Every person is born with a gift.  What's yours?");
	clearMenu();
	clearMenu();
	if(pc.hasPerk("Virile"))
	{
		//pc.cumQualityRaw -= 0.15;
		pc.removePerk("Virile");
	}
	if(pc.hasPerk("Potent"))
	{
		//pc.cumMultiplierRaw -= 1;
		pc.refractoryRate -= 1;
		pc.removePerk("Potent");
	}
	if(pc.hasPerk("Elasticity"))
	{
		pc.elasticity -= .5;
		pc.removePerk("Elasticity");
	}
	if(pc.hasPerk("Fertility"))
	{
		pc.fertilityRaw -= 0.15;
		pc.removePerk("Fertility");
	}
	if(pc.hasPerk("Milky"))
	{
		pc.removePerk("Milky");
	}
	if(pc.hasPerk("Incubator"))
	{
		//pc.pregnancyMultiplierRaw -= .5;
		pc.removePerk("Incubator");
	}
	if(pc.hasPerk("Hung"))
	{
		if(pc.hasCock()) {
			pc.cocks[0].cLengthRaw -= 2;
			pc.cocks[0].cThicknessRatioRaw = 1.0;
		}
		pc.removePerk("Hung");
	}
	if(pc.hasPerk("Mini"))
	{
		if(pc.hasCock()) {
			pc.cocks[0].cLengthRaw += 1;
		}
		pc.removePerk("Mini");
	}
	if(pc.hasPerk("Bulgy"))
	{
		pc.ballSizeRaw -= 4;
		if(pc.originalRace == "half kui-tan") pc.ballSizeRaw -= 5;
		pc.ballEfficiency -= 1;
		pc.removePerk("Bulgy");
	}
	if(pc.hasPerk("Extra Ardor"))
	{
		pc.removePerk("Extra Ardor");
	}
	if(pc.hasPerk("Ice Cold"))
	{
		pc.removePerk("Ice Cold");
	}
	addButton(0, "Virile", applyGift, "virile", "Virile", "Increases the quality, or impregnation chance, of the sperm you produce. <i>This perk also applies if your character is female and gains a penis in the future.</i>");
	addButton(1, "Potent", applyGift, "potent", "Potent", "Increases the quantity - the sheer amount - of sperm you produce. <i>This perk also applies if your character is female and gains a penis in the future.</i>");
	addButton(2, "Elasticity", applyGift, "elasticity", "Elasticity", "Allows you to take larger insertions, both vaginally and anally, with less chance of permanent orifice stretching.");
	addButton(3, "Fertility", applyGift, "fertility", "Fertility", "Increases your chances of getting pregnant. <i>This perk also applies if your character is male and gains a vagina in the future.</i>");
	addButton(4, "Milky", applyGift, "milky", "Milky", "Ensures that your lactation is more easily induced and much harder to stop.");
	addButton(5, "Incubator", applyGift, "incubator", "Incubator", "Shortens your pregnancy time, making pregnancies come to term quicker. <i>This perk applies to both vaginal and anal pregnancies.</i>");
	addButton(6, "Hung", applyGift, "hung", "Hung", "Increases the size of your male organs and causes them to be more receptive to future size-increasing modifications. <i>This perk also applies if your character is female and gains a penis in the future.</i>");
	addButton(7, "Mini", applyGift, "mini", "Mini", "Decreases the size of your male organs and causes them to be more receptive to future size-decreasing modifications. <i>This perk also applies if your character is female and gains a penis in the future.</i>");
	addButton(8, "Bulgy", applyGift, "bulgy", "Bulgy", "Increases the size of your testicles and causes them to be more receptive to future size-increasing modifications. <i>This perk also applies if your character is female and gains testicles in the future.</i>");
	addButton(9, "Extra Ardor", applyGift, "extra ardor", "Extra Ardor", "Ensures that you will have a higher sex drive than normal.");
	addButton(10, "Ice Cold", applyGift, "ice cold", "Ice Cold", "Ensures that you will have a lower sex drive than normal.");
	addButton(13, "None", applyGift, "none", "No Sexual Gift", "You will not begin with a natural sexual gift.");
}

private function applyGift(arg:String):void {
	if(arg == "virile") {
		pc.createPerk("Virile",1.15,0,0,0,"Increases the quality of your sperm.");
	}
	else if(arg == "potent") {
		//pc.cumMultiplierRaw += 1;
		pc.refractoryRate += 1;
		pc.createPerk("Potent",1,0,0,0,"Increases the size of your orgasms and the speed at which you produce ejaculate.");
	}
	else if(arg == "elasticity") {
		pc.createPerk("Elasticity",0,0,0,0,"Increases the elasticity of your orifices and renders them more resistant to stretching.");
		pc.elasticity += .5;
	}
	else if(arg == "fertility") {
		pc.fertilityRaw += 0.15;
		pc.createPerk("Fertility",0,0,0,0,"Increases your odds of getting pregnant.");
	}
	else if(arg == "milky") {
		pc.createPerk("Milky",0,0,0,0,"Causes lactation to be induced more easily and harder to stop.");
	}
	else if(arg == "incubator") {
		//(pc as PlayerCharacter).pregnancyIncubationBonusMotherRaw += 0.5;
		pc.createPerk("Incubator",1,0,0,0,"Increases the speed at which your pregnancies progress.");
	}
	else if(arg == "hung") {
		pc.createPerk("Hung",0,0,0,0,"Increases the size of your penis and how fast it grows.");
		if(pc.hasCock()) {
			pc.cocks[0].cLengthRaw += 2;
			if(pc.cocks[0].cThicknessRatioRaw < 1.1) pc.cocks[0].cThicknessRatioRaw = 1.1;
		}
	}
	else if(arg == "mini") {
		pc.createPerk("Mini",0,0,0,0,"Decreases the size of your penis and how fast it shrinks.");
		if(pc.hasCock()) {
			pc.cocks[0].cLengthRaw -= 1;
		}
	}
	else if(arg == "bulgy") {
		pc.createPerk("Bulgy",0,0,0,0,"Increase the size of any gonads and the speed at which they are enhanced.");
		pc.ballSizeRaw += 4;
		//HUEG BALLZ
		if(pc.originalRace == "half kui-tan") pc.ballSizeRaw += 5;
		pc.ballEfficiency += 1;
	}
	else if(arg == "extra ardor") {
		pc.createPerk("Extra Ardor",0,0,0,0,"Increases lust gain over time.");
	}
	else if(arg == "ice cold") {
		pc.createPerk("Ice Cold",0,0,0,0,"Slows lust gain over time.");
	}
	chooseHistory();
}

//-----------------
//-- HISTORY PERKS
//-----------------
public function chooseHistory():void {
	clearOutput();
	output("Before you became a champion, you had other plans for your life.  What were you doing before?");
	clearMenu();
	
	addButton(0, "Alchemy", confirmHistory, "History: Alchemist", "History: Alchemist", "You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.");
	addButton(1, "Fighting", confirmHistory, "History: Fighter", "History: Fighter", "You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical attacks.  You will also start out with 50 gems.");
	addButton(2, "Healing", confirmHistory, "History: Healer", "History: Healer", "You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.");
	addButton(3, "Religion", confirmHistory, "History: Religious", "History: Religious", "You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.");
	addButton(4, "Schooling", confirmHistory, "History: Scholar", "History: Scholar", "You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, and spellcasting uses 20% less energy.");
	addButton(5, "Slacking", confirmHistory, "History: Slacker", "History: Slacker", "You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your energy comes back 20% faster.");
	addButton(6, "Slutting", confirmHistory, "History: Slut", "History: Slut", "You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.");
	addButton(7, "Smithing", confirmHistory, "History: Smith", "History: Smith", "You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.");
	addButton(8, "Whoring", confirmHistory, "History: Whore", "History: Whore", "You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).");
	addButton(9, "Fortune", confirmHistory, "History: Fortune", "History: Fortune", "You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  You will also start out with 250 gems.");
}

private function confirmHistory(choice:String):void {
	switch(choice) {
		case "History: Alchemist":
			pc.createPerk(choice, 0, 0, 0, 0, "Alchemical items always seem to be more reactive in your hands.");
			break;
		case "History: Fighter":
			pc.createPerk(choice, 0, 0, 0, 0, "You do 10% more damage with physical attacks.");
			break;
		case "History: Healer":
			pc.createPerk(choice, 0, 0, 0, 0, "Healing items and effects are 20% more effective.");
			break;
		case "History: Religious":
			pc.createPerk(choice, 0, 0, 0, 0, "You can meditate, when corruption is at or below 66.");
			break;
		case "History: Scholar":
			pc.createPerk(choice, 0, 0, 0, 0, "You are much better at focusing, and spellcasting uses 20% less energy");
			break;
		case "History: Slacker":
			pc.createPerk(choice, 0, 0, 0, 0, "Your energy comes back 20% faster.");
			break;
		case "History: Slut": // no specific handler, start as non virgin, grants 0.5 to elasticity and 20 to initial capacity
			pc.createPerk(choice, 0, 0, 0, 0, "Your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.");
			break;
		case "History: Smith": // grants bonus to both armor and kinetic resistance
			pc.createPerk(choice, 0, 0, 0, 0, "You've learned how to fit armor for maximum protection.");
			break;
		case "History: Whore":
			pc.createPerk(choice, 0, 0, 0, 0, "You're more effective at teasing (+15% tease damage).");
			break;
		case "History: Fortune":
			pc.createPerk(choice, 0, 0, 0, 0, "You have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).");
			break;
			
	}
	
	if (choice == "History: Slut" || choice == "History: Whore") {
		if (pc.hasVagina()) {
			pc.vaginalVirgin = false;
			pc.vaginas[0].hymen = false;
			pc.vaginas[0].bonusCapacity = 20;
			if (choice == "History: Whore") pc.vaginas[0].loosenessRaw = 3;
		}
		if (pc.hasCock()) pc.cockVirgin = false;
		pc.analVirgin = false;
		pc.ass.bonusCapacity = 20;
		if (choice == "History: Whore") pc.ass.loosenessRaw = 2;
		if (choice == "History: Slut") pc.elasticity += 0.5;
	}
	if (choice == "History: Fighter" || choice == "History: Whore") {
		pc.credits += 500;
	}
	if (choice == "History: Fortune") {
		pc.credits += 2500;
	}
	
	completeCharacterCreation();
}

private function completeCharacterCreation():void {
	pc.cor(15);
	pc.meleeWeapon = new Rock();
	pc.rangedWeapon = new Rock();
	pc.armor = new ComfortableClothes();
	
	if(pc.hasVagina()) pc.lowerUndergarment = new CoCPanties();
	else pc.lowerUndergarment = new CoCLoincloth();
	if (pc.biggestTitSize() >= 1) pc.upperUndergarment = new CoCBra();
	
	pc.removeStatusEffect("In Creation");
	
	userInterface.showTime()
	cocMainIntroScene0();
}