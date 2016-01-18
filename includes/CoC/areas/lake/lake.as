import classes.GLOBAL;
import classes.Items.Transformatives.CoCEquinum;
import classes.Items.Transformatives.CoCWhiskerFruit;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Pony April 1st event
// Helia monogamy encounter
// latexGirl
// Izma
// dick-dragging
public function exploreLake():void
{
	//Increment exploration count
	flags["COC.EXPLORED_LAKE"]++;
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	//if (kGAMECLASS.poniesYN()) return;

	//Helia monogamy fucks
	//if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && pc.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
		//kGAMECLASS.helScene.helSexualAmbush();
		//return;
	//}
	var choice:Array = [];
	var chance:Array = [];

	//Build choice list.
	//==================================================
	//COMMON EVENTS

	// No events, gain speed
	if (pc.level < 2 || pc.RQ() < 50) {
		choice.push(lakeQuickWalk);
		chance.push(1);
	}
	
	choice.push(meetWhitneyDuringExplorationMaybe);
	chance.push(1);
	
	choice.push(meetKaijuOrGetBored); // how can one be not bored without kaiju?
	chance.push(1);
	
	//Fetish cultist not encountered till level 2
	if (pc.level >= 2 && flags["COC.FACTORY_SHUTDOWN"] > 0) {
		choice.push(meetFetishCultistAndHaveFun);
		chance.push(1);
	}
	
	// semi-rare
	if(flags["COC.EXPLORED_LAKE"] >= 5) { 
		choice.push(calluSceneOttahGirl);
		chance.push(4);
	}
	
	//Slimes/Ooze = level >= 2
	if (pc.level >= 2) {
		choice.push(meetSomethingSlimyAndOoooozzzingAtTheShore);
		chance.push(1);
	}
	
	
	//Egg chooser
	if(pc.hasPregnancyOfType("CoCOviElixEggs")) {
		choice.push(eggChooseColorEncounter);
		chance.push(2);
	}		
		
	//Izma
	//if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00230] > 0 && (pc.exploredLake >= 10) && (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00233] == 0 || pc.findStatusAffect(StatusAffects.Infested) < 0) && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] <= 0)
		//kGAMECLASS.izmaScene.meetIzmaAtLake();
	//Rathazul
	if (flags["COC.RATHAZUL_IN_CAMP"] != 1) {
		choice.push(encounterRathazul);
		chance.push(1);
	}

	//UNCOMMON EVENTS
	//Goo finding!
	//if (rand(30) == 0 && flags[kFLAGS.GOO_TFED_MEAN] + flags[kFLAGS.GOO_TFED_NICE] > 0 && flags[kFLAGS.GOO_SLAVE_RECRUITED] == 0) {
		//kGAMECLASS.latexGirl.encounterLeftBehindGooSlave();
		//return;
	//}
	//Chance of dick-dragging! OLD:10% + 10% per two foot up to 30%
	//temp = 10 + (pc.longestCockLength() - pc.tallness) / 24 * 10;
	//if (temp > 0 && pc.longestCockLength() >= pc.tallness - 10 && pc.totalCockThickness() >= 8)
		//choice[choice.length] = 8;
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	//else if (select == 8) {
		////True sets to use lake scene!
		//kGAMECLASS.forest.bigJunkForestScene(true);
	//}

	//Encounter goblins and imps in NG+
	//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0)
		//choice[choice.length] = 12;
		
	//ONE TIME EVENTS
	//Amily Village discovery
	//if (flags["COC.AMILY_VILLAGE_ACCESSIBLE"] == undefined) { 
		//choice.push(discoverAmilyVillage);
		//chance.push(1);
	//}
	//Sword Discovery
	if (flags["COC.SWORD_IN_A_STONE"] == undefined) { 
		choice.push(findSwordInStone);
		chance.push(1);
	}
	//Pre-emptive chance of finding the boat
	if (flags["COC.BOAT_DISCOVERED"] == undefined) {
		choice.push(discoverBoat);
		chance.push(1);
	}
		
	//CHOOSE YOUR POISON!
	WeightedRandom(choice, chance, true)();
}

public function findLakeLoot():void {
	clearOutput();
	
	processTime(20 + rand(20));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
		
	if (rand(2) == 0) {
		output("You find a long and oddly flared vial half-buried in the sand.  Written across the middle band of the vial is a single word: 'Equinum'.\n");
		itemCollect([new CoCEquinum()]);
	}
	else {
		output("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n");
		itemCollect([new CoCWhiskerFruit()]);
	}	
}

public function lakeQuickWalk():void {
	clearOutput();
	output("Your quick walk along the lakeshore feels good.");
	
	if (pc.RQ() < 50) {
		output("  You bet you could cover the same distance even faster next time.\n");
		pc.slowStatGain("reflexes", 0.25);
	}
	
	processTime(20 + rand(20));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function meetKaijuOrGetBored():void {
	//No boat, no kaiju
	if (pc.level >= 5 && flags["COC.KAIJU_DISABLED"] != 1 && flags["COC.BOAT_DISCOVERED"] == 1) {
		kaijuMeeting();
		return;
	}
	var displayed:Boolean = false;
	clearOutput();
	output("Your stroll around the lake increasingly bores you, leaving your mind to wander.  ");
	if (pc.cor() > 30 || pc.lust() > 60 || pc.libido() > 40) output("Your imaginings increasingly seem to turn ");
	else pc.slowStatGain("intelligence", 0.25);
	if ((pc.cor() > 30 && pc.cor() < 60) || (pc.lust() > 60 && pc.lust() < 90) || (pc.libido() > 40 && pc.libido() < 75)) {
		output("to thoughts of sex.");
		pc.lust(5 + pc.libido() / 10);
		displayed = true;
	}
	if (((pc.cor() >= 60) || (pc.lust() >= 90) || (pc.libido() >= 75)) && !displayed) {
		output("into daydreams of raunchy perverted sex, flooding your groin with warmth.");
		pc.lust(pc.cor() / 10 + pc.libido() / 10);
	}
	
	processTime(20 + rand(20));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Find whitney or equinum
public function meetWhitneyDuringExplorationMaybe():void {
	//40% chance of item, 60 of whitney.
	if (flags["COC.WHITNEY_MET"] >= 3 || rand(10) < 4) {
		findLakeLoot();
	}
	//Find Whitney
	else {
		farmExploreEncounter();
	}
}

public function meetFetishCultistAndHaveFun():void {	
	clearOutput();
	if (IncrementFlag("COC.FETISH_CULTIST_MET") == 1) {
		output("While exploring, you notice something unusual on the lake.  This something is quickly moving towards you at a surprising rate, much faster than anything you've ever seen before.  Wary of meeting new things in this world after your previous experiences, you decide to slip behind a nearby hill and watch it while hidden.  Soon the object comes into view and you can see that it is a boat of some kind.  It looks almost like a large open box on the water with some kind of gazebo on it.  Despite how fast it is moving, you can't see any oars or means of moving the boat.  It slows somewhat when it gets close to the shore, but is still going about as fast as you can run when it hits the shore and extends some kind of gangplank onto the lake shore.  With a close up view, you estimate that it is six feet across, ten feet long, and doesn't actually seem to have very much of it underwater.  You guess that it must be magic in some way.  There are several robe-clad figures on board.\n\n", true);
		output("After a moment, a number of the figures disembark down the gangplank and immediately go off in different directions.  You count half a dozen of them, and guess that they are female when one of them passes by close to you and you see the hole in her outfit over her naughty bits.  You look back at the boat to see it close the gangplank, and move back onto the lake, with only one of the figures still on board.  Surprised to hear a sudden yell, you look to the side and see the clothing of the one who passed you earlier shift and twist before becoming some pink outfit that clings to her backside.  You are stunned for a moment as she disappears from sight before you shake your head and move on.  It seems there are new residents to the lake.\n\n<b>(Fetish Cultists can now be encountered!)</b>");
		//(increase player lust from the sights they saw)
		pc.lust(5);
		processTime(15);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	fetishCultistEncounter();
}

	
public function meetSomethingSlimyAndOoooozzzingAtTheShore():void {
	clearOutput();
	clearMenu();
	//Chance of seeing ooze convert goo!
	//More common if factory blew up
	if (flags["COC.FACTORY_SHUTDOWN"] == 2 && rand(10) == 0) {
		spyOnGooAndOozeSex();
		return;
	}
	//Else pretty rare.
	else if (rand(25) == 0) {
		spyOnGooAndOozeSex();
		return;
	}
	var girlOdds:Number = 50;
	//50% odds of slime-girl, 75% if shutdown factory
	if (flags["COC.FACTORY_SHUTDOWN"] == 1)
		girlOdds += 25;
	if (flags["COC.FACTORY_SHUTDOWN"] == 2)
		girlOdds -= 25;
	//Slimegirl!
	if (rand(100) <= girlOdds) {
		encounterGooGirl();
	}
	//OOZE!
	else {
		if (flags["COC.TIMES_MET_OOZE"] == undefined) flags["COC.TIMES_MET_OOZE"] = 0;
		flags["COC.TIMES_MET_OOZE"]++;
		//spriteSelect(25);
		//High int starts on even footing.
		fightGreenSlime();
		clearMenu();
		if (pc.IQ() >= 25) {
			output("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
			if (flags["COC.FACTORY_SHUTDOWN"] == 1) output("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
			addButton(0, "Next", CombatManager.beginCombat);
			return;
		}
		//High speed starts on even footing.
		if (pc.RQ() >= 30) {
			output("You feel something moist brush the back of your ankle and instinctively jump forward and roll, coming up to face whatever it is behind you.  The nearly silent, amorphous green slime that was at your feet surges vertically, its upper body taking the form of a humanoid with thick arms and wide shoulders, which attacks!");
			if (flags["COC.FACTORY_SHUTDOWN"] == 1) output("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
			addButton(0, "Next", CombatManager.beginCombat);
			return;
		}
		//High strength gets stunned first round.
		if (pc.PQ() >= 40) {
			output("Without warning, you feel something moist and spongy wrap around your ankle, nearly pulling you off balance.  With a ferocious tug, you pull yourself free and turn to face your assailant.  It is a large green ooze that surges upwards to take the form of humanoid with wide shoulders and massive arms.  It shudders for a moment, and its featureless face shifts into a green version of your own! The sight gives you pause for a moment, and the creature strikes!");
			if (flags["COC.FACTORY_SHUTDOWN"] == 1) output("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
			addButton(0, "Next", CombatManager.beginCombat);
			return;
		}
		//Player's stats suck and you should feel bad.
		output("Without warning, you feel something moist and spongy wrap around your ankle, pulling you off balance!  You turn and try to pull your leg away, struggling against a large green ooze for a moment before your foot comes away with a *schlorp* and a thin coating of green fluid.  The rest of the ooze rises to tower over you, forming a massive green humanoid torso with hugely muscled arms and wide shoulders.  Adrenaline rushes into your body as you prepare for combat, and you feel your heart skip a beat as your libido begins to kick up as well!");
		if (flags["COC.FACTORY_SHUTDOWN"] == 1) output("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
		pc.libido(1);
		pc.lust(10);
		addButton(0, "Next", CombatManager.beginCombat);
	}
}

public function eggChooseColorEncounter():void {
	clearOutput();
	clearMenu();
	output("While wandering along the lakeshore, you spy beautiful colored lights swirling under the surface.  You lean over cautiously, and leap back as they flash free of the lake's liquid without making a splash.  The colored lights spin in a circle, surrounding you.  You wonder how you are to fight light, but they stop moving and hover in place around you.  There are numerous colors: Blue, Pink, White, Black, Purple, and Brown.  They appear to be waiting for something; perhaps you could touch one of them?");
	addButton(0, "Blue", eggChooseColor, 2);
	addButton(1, "Pink", eggChooseColor, 3);
	addButton(2, "White", eggChooseColor, 4);
	addDisabledButton(3, "Black", "Black", "NOT IMPLEMENTED.");
	//addButton(3, "Black", eggChooseColor, 5);
	addButton(4, "Purple", eggChooseColor, 1);
	addButton(5, "Brown", eggChooseColor, 0);
	addButton(14, "Escape", eggChooseColorEscape);
}

public function eggChooseColor(eggType:int):void {
	clearOutput();
	output("You reach out and touch the ");
	switch (eggType) {
		case  0: output("brown"); break;
		case  1: output("purple"); break;
		case  2: output("blue"); break;
		case  3: output("pink"); break;
		case  4: output("white"); break;
		default: output("black"); break;
	}
	output(" light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.");
	pc.setStatusValue("MagicColorfulEggs", 1, eggType); //Value 1 is the egg type. If pregnant with OviElixir then status effect must exist
	
	processTime(20 + rand(20));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function eggChooseColorEscape():void {
	clearOutput();
	output("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.");
	
	processTime(20 + rand(20));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}