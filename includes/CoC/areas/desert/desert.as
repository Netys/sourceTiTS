import classes.GLOBAL;
import classes.Items.Melee.CoCWizardStaff;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function exploreDesert():void
{
	if (helSexualAmbush()) return;
	
	showName("\nDESERT");
	IncrementFlag("COC.EXPLORED_DESERT");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	////BUILD LIST OF CHOICES
	var choice:Array = [];
	var chance:Array = [];
	
	if(flags["COC.EXPLORED_DESERT"] % 20 == 0 && (flags["COC.TEL_ADRE_KNOWN"] == undefined || flags["COC.TEL_ADRE_KNOWN"] == 0))
	{
		discoverTelAdre();
		return;
	}
	
	//Ant colony debug chances
	if (pc.level >= 5 && flags["COC.ANT_WAIFU"] == undefined && flags["COC.EXPLORED_DESERT"] % 8 == 0 && int(flags["COC.ANTS_PC_FAILED_PHYLLA"]) == 0 && flags["COC.ANT_COLONY_KEPT_HIDDEN"] == undefined) {
		antColonyEncounter();
		return;
	}
	
	if ((pc.level >= 4 || flags["COC.EXPLORED_DESERT"] > 45) && Flag("COC.DISCOVERED_WITCH_DUNGEON") == 0) {
		choice.push(TravelToDesertCave);
		chance.push(5);
	}
	
	//int over 50?  Chance of alice encounter!
	if (pc.intelligence() >= 15 && flags["COC.FOUND_WIZARD_STAFF"] == undefined) {
		choice.push(encounterAliseInDesert);
		chance.push(4);
	}
	
	//Possible chance of boosting camp space!
	if (flags["COC.CAMP_STORAGE_CONSUMABLES"] == undefined && (rand(100) < 10)) {
		output("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.  You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand.  Overcome with curiosity, you dig it out, only to discover that it's empty, but somehow ice cold inside.  It would make a nice addition to your campsite.\n\nYou decide to bring it back to your campsite.  ");
		flags["COC.CAMP_STORAGE_CONSUMABLES"] = 10;
		output("<b>You now have " + flags["COC.CAMP_STORAGE_CONSUMABLES"] + " storage slots for consumables at camp.</b>");
		processTime(60 + rand(60));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	//temp = 10 + (pc.longestCockLength() - pc.tallness) / 24 * 10;
	//if (temp > 30) temp = 30;
	//if (temp > rand(100) && pc.longestCockLength() >= pc.tallness && pc.totalCockThickness() >= 12) {
		//bigJunkDesertScene();
		//return;
	//}

	//Encounter Sandwitch
	if (Flag("COC.SAND_WITCH_LEAVE_ME_ALONE") == 0) {
		choice.push(sandWitchSceneEncounter);
		chance.push(1);
	}
	
	if (flags["COC.CUM_WITCHES_FIGHTABLE"] > 0) {
		choice.push(fightCumWitch);
		chance.push(1);
	}

	//Encounter Marcus
	choice.push(wandererRouter);
	chance.push(2);

	choice.push(walkingDesertStatBoost);
	chance.push(1);

	choice.push(mirageDesert);
	chance.push(2);

	if(pc.level >= 2) {
		choice.push(oasisEncounter);
		chance.push(2); }

	choice.push(nagaEncounter);
	chance.push(1);
	
	choice.push(encounterASandTarp);
	chance.push(2);
	
	choice.push(fountainEncounter);
	chance.push(20);
	
	//MAKE YOUR CHOICE
	WeightedRandom(choice, chance, true)();
}

private function mirageDesert():void
{
	clearOutput();
	output("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.\n\n");
	processTime(25 + rand(10));
	pc.lust( -15);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function walkingDesertStatBoost():void
{
	clearOutput();
	output("You walk through the shifting sands for an hour, finding nothing.\n\n");
	//Chance of boost == 50%
	if (rand(2) == 0) {
		//50/50 strength/toughness
		if (rand(2) == 0 && pc.PQ() < 50) {
			output("The effort of struggling with the uncertain footing has made you stronger.");
			pc.slowStatGain("p", 0.5);
		}
		//Toughness
		else if (pc.WQ() < 50) {
			output("The effort of struggling with the uncertain footing has made you tougher.");
			//dynStats("tou", .5);
			pc.slowStatGain("w", 0.5);
		}
	}
	doNext(returnToCampUseOneHour);
}

private function encounterAliseInDesert():void
{
	clearOutput();
	output("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n");
	output("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n");
	output("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n");
	flags["COC.FOUND_WIZARD_STAFF"] = 1;
	processTime(15);
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCWizardStaff()]);
}

public function bigJunkDesertScene():void
{
	clearOutput();
	var x:Number = pc.longestCockIndex();
	//PARAGRAPH 1
	output("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + pc.cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.");

	if (pc.cocks.length == 1) output("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your [pc.cockNoun " + x + "].");
	else if (pc.cocks.length >= 2) output("  With all of your [pc.multiCocks] dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(pc.cockTotal()) + " different monstrous animals were slobbering over each one.");
	output("\n\n");

	//PARAGRAPH 2

	//FOR NON-CENTAURS]
	if (!pc.isTaur()) {
		output("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [pc.cocks], which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + pc.hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene [pc.multiCocks].");

		//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
		if (pc.biggestTitSize() >= 35)  output("  Your " + pc.allBreastsDescript() + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your [pc.nipples] mercilessly as they grind in the sand.");
		//IF CHARACTER HAS A BALLS ADD SENTENCE
		if (pc.balls > 0) output("  Your [pc.sack] rests beneath your raised " + pc.buttDescript() + ".  The fiery warmth of the desert caresses it, causing your [pc.balls] to pulse with the need to release their sperm through your [pc.multiCocks].");
		//IF CHARACTER HAS A VAGINA ADD SENTENCE
		if (pc.hasVagina()) {
			output("  Your [pc.vagina] and " + pc.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + pc.buttDescript() + " above.");
			//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
			if (pc.isSquirter()) output("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ");
		}
	}
	//FOR CENTAURS
	else {
		output("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [pc.multiCocks], which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your [pc.hips] to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hindquarters until you rest atop your [pc.multiCocks].");
		//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
		if (pc.biggestTitSize() >= 35)  output("  Your " + pc.allBreastsDescript() + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your [pc.nipples] incessantly.");
		//IF CHARACTER HAS A BALLS ADD SENTENCE
		if (pc.balls > 0) output("  Your [pc.sack] rests beneath your raised " + pc.buttDescript() + ".  The airy warmth of the desert teases it, causing your [pc.balls] pulse with the need to release their sperm through your [pc.multiCocks].");
		//IF CHARACTER HAS A VAGINA ADD SENTENCE
		if (pc.vaginas.length >= 1) {
			output("  Your [pc.vagina] and " + pc.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + pc.buttDescript() + " above.");
			//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
			if (pc.isSquirter()) output("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.");
		}
	}
	output("\n\n");
	//PARAGRAPH 3
	output("You realize you are effectively trapped here by your own body.");
	//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
	if (pc.cor() < 33) output("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!");
	else if (pc.cor() < 66) output("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.");
	else output("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you're exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.");

	//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
	if (pc.canFly()) output("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.");
	//SCENE END IF CHARACTER HAS CENTAUR BODY
	else if (pc.isTaur()) output("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your " + pc.feet() + " have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.");
	//SCENE END = FOR ALL OTHER CHARACTERS
	else output("  You struggle and push with your [pc.legs] as hard as you can, but it's no use.  You do the only thing you can and begin stroking your [pc.multiCocks] with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later [pc.eachCock] softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.");
	processTime(50 + rand(20));
	pc.lust(25 + rand(pc.cor() / 5));
	pc.energy( -5);
	addNextButton();
}