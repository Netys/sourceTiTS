import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Demonic fountain in desert
//300 xp
//When drank from, rewards 300 xp, a sizable random growth

public function fountainEncounter():void {
	showName("\nFOUNTAIN");
	clearOutput();
	output("While roaming the shifting sands of the desert, you begin to feel a change in the air.  The bone-dry atmosphere shifts, becoming more and more humid as you press on.  At last you crest a dune and discover the source of the moisture – a huge onyx fountain, spraying crystal clear water into the air.  The center of the fountain is a magnificent sculpture of two entwined demonic forms, nude and over-proportioned to the extreme.  The water is spraying out from some rather... unconventional places.  You blush, feeling a bit parched, but wary of the fountain's nature.\n\n");
	output("You come closer and discover a placard.  It reads, \"Fountain of Endowment\".  Well, clearly it's supposed to enhance something, but at what cost?\n\n");
	output("Do you drink from the fountain?");
	
	//[Yes] [No]
	clearMenu();
	addButton(0, "Yes", drinkFountainEndowment)
	addButton(1, "No", function():* { processTime(10 + rand(10)); mainGameMenu(); } );
}

private function drinkFountainEndowment():void {
	clearOutput();
	output("You cup your hands and bring the clear water to your lips, taking a long drink.  It's cool and refreshing, going down quite easily.  Weird.  You thought it would make you feel different somehow.");
	
	var temp:Number = 0;
	var options:Array = [];
	
	options.push(function():* {
		output("\n\nA sense of... wisdom and clear-headedness emerges, making you feel far more sure of yourself.");
		pc.XP(pc.XPMax() / 4);
	});
	
	if (!pc.hasStatusEffect("Exgartuan") && rand(2) == 0) {
		if (pc.hasCock() && pc.cockVolume(pc.biggestCockIndex()) >= cockVolume(100)) options.push(exgartuanInfestDick);
		if (pc.biggestTitSize() >= 12) options.push(exgartuanInfestTits);
	}
	
	//(+Big Tits)
	if (pc.biggestTitSize() >= 1 && pc.smallestTitSize() < 30)
		options.push(function():* {
			output("\n\nYour [pc.fullChest] balloon, each growing about four bra-sizes larger... they feel so... jiggly and sensitive.  Even your nipples seem to grow with them!  Your [pc.gear] feels tighter than ever!");
			pc.nippleLengthRatio += .3;
			Mutator.growTits(pc, pc.breastRows.length * 4, pc.breastRows.length, false, 1, 30);
		});
	
	//(+Big dick)
	if (pc.hasCock() && pc.shortestCockLength() < 48)
		options.push(function():* {
			output("\n\nYour [pc.cocksLight] feels tighter");
			if (!pc.isCrotchExposed()) output(" inside your [pc.lowerGarments]");
			output(", even when flaccid.  You shudder and realize you've probably gained more than a few inches in total length.");
			temp = pc.cocks.length;
			while(temp > 0) {
				temp--;
				if (pc.cocks[temp].cLengthRaw < 48) pc.cocks[temp].cLengthRaw = Math.min(pc.cocks[temp].cLengthRaw + 4, 48);
			}
		});
	
	//(+Big Clit)
	if (pc.hasClit() && pc.clitLength < 12)
		options.push(function():* {
			output("\n\nYour [pc.clits] plumps up, visibly parting your lips even when you aren't turned on.  It probably ");
			pc.clitLength += 2;
			if (pc.clitLength > 12) pc.clitLength = 12;
			if (pc.clitLength < 6) output("gets as big as a cock");
			else output("gets bigger than most cocks");
			output(" now!");
		});
	
	RandomInCollection(options)();
	
	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}