import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GLOBAL;
import classes.Items.Miscellaneous.CoCBlackChitin;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Tamani preg
// Tamani daughters
// Jojo corruption, rape and combat
// Marble meeting
// dick-dragging
public function exploreForest():void
{ 
	if (helSexualAmbush()) return;
	
	showName("\nFOREST");
	//Increment forest exploration counter.
	IncrementFlag("COC.EXPLORED_FOREST");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	//Chance to discover deepwoods
	if (flags["COC.EXPLORED_FOREST"] >= 20 && flags["COC.EXPLORED_DEEPWOODS"] == undefined) {
		flags["COC.EXPLORED_DEEPWOODS"] = 0;
		output("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n<b>Deepwoods exploration unlocked!</b>");
		processTime(30);
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	
	var choice:Array = [];
	var chance:Array = [];
	
	//Build choice list!
	
	//General Goblin and Imp Encounters
	choice.push(forestEventGoblin);
	chance.push(1);
	
	// Jojo
	if ((pc.cor() >= 25 || pc.level >= 4) && int(flags["COC.JOJO_IN_CAMP"]) == 0 && !campCorruptJojo()) {
		choice.push(forestEventJojo);
		chance.push(1);
	}
	
	//Tentacle Beast
	if (pc.level >= 2) {
		choice.push(forestTentaBeast);
		chance.push(3);
	}
	
	//if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100 && rand(100) >= Math.round(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] * 0.75)) choice[choice.length] = 3;
	 //Corrupted Glade
	choice.push(forestCorruptedGlade);
	chance.push(2);
	
	choice.push(forestRootTrip); //Trip on a root
	chance.push(2);
	
	choice.push(beeEncounter); //Bee-girl encounter
	chance.push(2); // semi-rare
	
	choice.push(forestLoot); // just find chitin plate
	chance.push(5); // rare
	
	//if (rand(2) == 0) choice[choice.length] = 6; //Pigtail Truffle
	//if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 4 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < 100 && rand(2) == 0) choice[choice.length] = 7; //Gather woods
	
	choice.push(forestWastedTime); //Peaceful walk in woods
	chance.push(1);
	
	//Essy is rare
	if (pc.hasGenitals() && int(flags["COC.ESSY_IN_DUNGEON"]) == 0) {
		choice.push(essrayleMeetingI);
		chance.push(25);
	}
	
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	//temp = 10 + (pc.longestCockLength() - pc.tallness) / 24 * 10;
	//if (temp > 30) temp = 30;
	//if (temp > rand(100) && pc.longestCockLength() >= pc.tallness && pc.totalCockThickness() >= 12) {
		//bigJunkForestScene();
		//return;
	//}
	//Marble randomness
	//if (pc.exploredForest % 50 == 0 && pc.exploredForest > 0 && pc.findStatusAffect(StatusAffects.MarbleRapeAttempted) < 0 && pc.findStatusAffect(StatusAffects.NoMoreMarble) < 0 && pc.findStatusAffect(StatusAffects.Marble) >= 0 && flags[kFLAGS.MARBLE_WARNING] == 0) {
		////can be triggered one time after Marble has been met, but before the addiction quest starts.
		//clearOutput();
		//output("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
		//output("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
		//output("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
		////end event
		//doNext(returnToCampUseOneHour);
		//return;
	//}
	
	WeightedRandom(choice, chance, true)();
}
	
public function forestEventGoblin():void {
	if (rand(4) <= 0 && encounterTamaniPosible()) {
		encounterTamani();
		return;
	}
	//Determines likelyhood of imp/goblins
	genericGobImpEncounters();
}

public function forestTentaBeast():void {
	clearOutput();
	//Oh noes, tentacles!
	//Tentacle avoidance chance due to dangerous plants
	if (pc.hasKeyItem("Dangerous Plants") && pc.intelligence() > rand(50)) {
		output("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
		clearMenu();
		addButton(0, "Continue", tentacleBeastSceneEncounter);
		addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
		return;
	}
	else {
		tentacleBeastSceneEncounter();
		return;
	}
}

public function forestEventJojo():void {
	clearOutput();
	if (flags["COC.JOJO_MET"] == undefined) 
	{
		if (pc.cor() < 25)
		{
			if (pc.level >= 4)
			{
				flags["COC.JOJO_MET"] = 1;
				lowCorruptionJojoEncounter();
				return;
			}
		}
		else 
		{
			flags["COC.JOJO_MET"] = 1;
			highCorruptionJojoEncounter();
			return;
		}
	}
	else if (flags["COC.JOJO_STATE"] == 1) {
		repeatJojoEncounter();
		return;
	}
	else if (flags["COC.JOJO_STATE"] >= 2) { //Angry/Horny Jojo
		corruptJojoEncounter();
		return;
	}
	// failsafe
	forestWastedTime();
}

public function forestCorruptedGlade():void {
	if (rand(4) == 0) {
		corruptedGladeTrappedSatyr();
	} else introCorruptedGlade();
}

public function forestRootTrip():void {
	clearOutput();
	output("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.");
	applyDamage(new TypeCollection( { kinetic : 5 }, DamageFlag.BYPASS_SHIELD).rand(50), pc, pc, "minimal");
	clearMenu();
	addButton(0, "Next", function():* { processTime(10 + rand(10)); mainGameMenu(); } );
}

public function forestWastedTime():void {
	clearOutput();
	if (pc.cor() < 80) {
		output("You enjoy a peaceful walk in the woods, it gives you time to think.");
		//dynStats("tou", .5, "int", 1);
		pc.slowStatGain("i", 1);
	}
	else {
		output("As you wander in the forest, you keep ");
		if (pc.isHerm()) output("stroking alternatively [pc.eachCock] and your [pc.vagina] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
		else if (pc.hasCock()) output("stroking your half-erect [pc.cocks] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.");
		else if (pc.hasVagina()) output("idly toying with your [vagina] as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
		else if (!pc.hasGenitals()) output("daydreaming about sex-demons with huge sexual attributes, and how you could please them.");
		//dynStats("tou", .5, "lib", .25, "lus", pc.lib / 5);
		pc.slowStatGain("l", 0.25);
		pc.lust(pc.libido() / 5);
	}
	processTime(30 + rand(20));
	addNextButton();
}

private function forestLoot():void {
	clearOutput();
	
	processTime(20 + rand(20));
	itemScreen = function():*{ processTime(10 + rand(10)); mainGameMenu(); };
	lootScreen = itemScreen;
	useItemFunction = itemScreen;
	
	output("You find a large piece of insectile carapace obscured in the ferns to your left. It's mostly black with a thin border of bright yellow along the outer edge. There's still a fair portion of yellow fuzz clinging to the chitinous shard. It feels strong and flexible - maybe someone can make something of it.\n\n");
	itemCollect([new CoCBlackChitin()]);
}