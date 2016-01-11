import classes.Creature;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;
import classes.VaginaClass;

public var timeChangeListeners:/*Function*/Array = [];

public function notifyTimeProcessListeners():void {
	for each (var name:* in timeChangeListeners) name();
}

// AREAS
include "areas/intro.as";
include "areas/camp/camp.as";
include "areas/exploration.as";
include "areas/exploration/ImpScene.as";
include "areas/exploration/GoblinScene.as";
include "areas/exploration/Giacomo.as";
include "areas/exploration/Lumi.as";
include "areas/deepwoods/deepwoods.as";
include "areas/deepwoods/AkbalScene.as";
include "areas/deepwoods/ErlKingScene.as";
include "areas/deepwoods/Faerie.as";
include "areas/deepwoods/KitsuneScene.as";
include "areas/desert/desert.as";
include "areas/desert/Wanderer.as";
include "areas/desert/SandTrapScene.as";
include "areas/desert/SandWitchScene.as";
include "areas/desert/NagaScene.as";
include "areas/forest/forest.as";
include "areas/forest/BeeGirlScene.as";
include "areas/forest/CorruptedGlade.as";
include "areas/forest/Essrayle.as";
include "areas/forest/TamaniScene.as";
include "areas/forest/tentacleBeastScene.as";
include "areas/lake/lake.as";
include "areas/lake/CalluScene.as";
include "areas/lake/FetishCultistScene.as";
include "areas/lake/GooGirlScene.as";
include "areas/lake/GreenSlimeScene.as";
include "areas/lake/Kaiju.as";
include "areas/lake/SwordInStone.as";
include "areas/mountain/mountain.as";
include "areas/mountain/HellhoundScene.as";
include "areas/mountain/MinotaurScene.as";
include "areas/mountain/WormsScene.as";
include "areas/mountain/GoblinSalon.as";
include "areas/boat/boat.as";
include "areas/boat/MaraeScene.as";
include "areas/boat/SharkGirlScene.as";
include "areas/boat/FetishZealotScene.as";

// PLACES
include "places/Farm.as";
include "places/bazaar/bazaar.as";
include "places/teladre/TelAdre.as";
include "places/factory/factory.as";
include "places/deepCave/ZetazCave.as";
include "places/desertCave/DesertCave.as";

// FOLLOWERS
//include "characters/AmilyScene.as";
include "characters/AnemoneScene.as";
include "characters/JojoScene.as";
include "characters/Rathazul.as";

public function initCoCJunk():void {
	if (flags["COC.CORRUPTION"] == undefined) flags["COC.CORRUPTION"] = int(pc.personality / 2.1) + 10;
	//flags["COC.PC_GEMS"] = 0;
	if (flags["COC.IN_MARETH"] == undefined) flags["COC.IN_MARETH"] = 0;
	if (flags["COC.TIMES_TRANSFORMED"] == undefined) flags["COC.TIMES_TRANSFORMED"] = 0;
}
public function inMareth():Boolean {
	return rooms[currentLocation].system == "PLANET: MARETH";
}
//public function gems(val:int = 0, force:Boolean = false):Boolean {
	//return coc_gems(val, force);
//}
//public function coc_gems(val:int = 0, force:Boolean = false):Boolean {
	//if (flags["COC.PC_GEMS"] == undefined) flags["COC.PC_GEMS"] = 0;
	//
	//if (force) flags["COC.PC_GEMS"] = val; 
	//else if (val != 0) flags["COC.PC_GEMS"] += val; 
	//
	//if (flags["COC.PC_GEMS"] < 0) flags["COC.PC_GEMS"] = 0;
	//
	//return flags["COC.PC_GEMS"];
//}
//
public function cor(arg:Number = 0, apply:Boolean = false): Number 
{
	if (flags["COC.CORRUPTION"] == undefined) flags["COC.CORRUPTION"] = 0;
	if (apply) 
		flags["COC.CORRUPTION"] = arg;
	else if (arg != 0) 
	{
		flags["COC.CORRUPTION"] += arg;
		if (flags["COC.CORRUPTION"] > 100)
			flags["COC.CORRUPTION"] = 100;
		if (flags["COC.CORRUPTION"] < 0) 
			flags["COC.CORRUPTION"] = 0;
	}
	return flags["COC.CORRUPTION"];
}

public function dynStats(...args:*):void {
	if (args.length % 2 > 0)
		trace("dynStats: " + args);

	for (var i:int = 0; i <= args.length / 2; i++) {
		var stat:String = args[i];
		var mod:Number = args[i + 1];
	}
}

public function dynStat(stat:String, arg:Number):void {
	if (stat == "cor")
		pc.cor(arg);
	else if (stat == "lus")
		pc.lust(arg);
	else if (stat == "lib")
		pc.libido(arg);
	else trace("dynStat: " + stat + " " + arg);
}

// TODO: use weightedRand
public function WeightedRandom(options:Array, weights:Array, inverted:Boolean = false):* {
	if (options.length != weights.length)
		trace("WeightedRandom call with uneven lists!");
	if (options.length == 0) return null;
	if (options.length == 1) return options[0];
	
	var sum:Number = 0;
	for (var i:int = 0; i < weights.length; i++) {
		if (inverted) weights[i] = 1 / weights[i];
		sum += weights[i];
	}
	
	var roll:Number = Math.random() * sum;
	
	for (i = 0; i < weights.length; i++) {
		if (roll <= weights[i]) return options[i];
		roll -= weights[i];
	}
	
	return null; // failsafe
}

// done something awful
public function isBeyondMoralHorizon():Boolean {
	return pc.cor() >= 100; //kGAMECLASS.monk >= 5 || pc.findStatusAffect(StatusAffects.Exgartuan) >= 0 || kGAMECLASS.amilyScene.amilyCorrupt() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.NIAMH_STATUS] > 0
}

public function get timeAsStamp():uint {
	return GetGameTimestamp(); }

// legacy wrappers
public function doNext(param:Function, arg:*=null):void {
	clearMenu();
	addButton(0, "Next", param, arg);
}
public function outputText(text:String, param:Boolean = false):void {
	if (param) { clearOutput(); clearMenu(); }	
	output(text);
}
public function playerMenu():void {	returnToCamp(); }
public function corruptionTolerance():int { return 0; }

public function takeDamage(arg:Number):void {
	var afterShield:Number = arg - pc.shields();
	pc.shields(arg);
	if (afterShield > 0) pc.HP( -afterShield);
}

public function getKnownFireMagic():String {
	if (flags["COC.SPELL_WHITEFIRE"] != undefined) return "whitefire";
	if (pc.hasPerk("Enlightened Nine-tails")) return "fox fire";
	if (pc.hasPerk("Corrupted Nine-tails")) return "ghostly flame";
	if (pc.hasPerk("Fire Lord")) return "terrestreal fire";
	if (pc.hasPerk("Hellfire")) return "hellfire";
	return null;
}

public function getKnownFireBreath():String {
	if (pc.hasPerk("Fire Lord")) return "terrestreal fire";
	if (pc.hasPerk("Hellfire")) return "hellfire";
	if (pc.hasPerk("Dragonfire")) return "dragonfire";
	return null;
}

// imma lazy
public function lengthChange(temp2:Number, ncocks:Number):void {
	//DIsplay the degree of length change.
	if(temp2 <= 1 && temp2 > 0) {
		if(pc.cocks.length == 1) output("Your [pc.cock] has grown slightly longer.");
		if(pc.cocks.length > 1) {
			if(ncocks == 1) output("One of your [pc.cocksLight] grows slightly longer.");
			if(ncocks > 1 && ncocks < pc.cocks.length) output("Some of your [pc.cocksLight] grow slightly longer.");
			if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] seem to fill up... growing a little bit larger.");
		}
	}
	if(temp2 > 1 && temp2 < 3) {
		if(pc.cocks.length == 1) output("A very pleasurable feeling spreads from your groin as your [pc.cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
		if(pc.cocks.length > 1) {
			if(ncocks == pc.cocks.length) output("A very pleasurable feeling spreads from your groin as your [pc.cocksLight] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
			if(ncocks == 1) output("A very pleasurable feeling spreads from your groin as one of your [pc.cocksLight] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
			if(ncocks > 1 && ncocks < pc.cocks.length) output("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [pc.cocksLight] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
		}
	}
	if(temp2 >=3){
		if(pc.cocks.length == 1) output("Your [pc.cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
		if(pc.cocks.length > 1) {
			if(ncocks == 1) output("Your [pc.cocksLight] feel incredibly tight as one of their number begins to grow inch after inch of length.");
			if(ncocks > 1 && ncocks < pc.cocks.length) output("Your [pc.cocksLight] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
			if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] feel incredibly tight as inch after inch of length pour out from your groin.");
		}
	}
	//Display LengthChange
	if(temp2 > 0) {
		if(pc.cocks[0].cLength() >= 8 && pc.cocks[0].cLength()-temp2 < 8){
			if(pc.cocks.length == 1) output("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
			if(pc.cocks.length > 1) output("  <b>Most men would be overly proud to have one cock as long as yours, let alone [pc.cocks].</b>");
		}
		if(pc.cocks[0].cLength() >= 12 && pc.cocks[0].cLength()-temp2 < 12) {
			if(pc.cocks.length == 1) output("  <b>Your [pc.cock] is so long it nearly swings to your knee at its full length.</b>");
			if(pc.cocks.length > 1) output("  <b>Your [pc.cocksLight] are so long they nearly reach your knees when at full length.</b>");
		}
		if(pc.cocks[0].cLength() >= 16 && pc.cocks[0].cLength()-temp2 < 16) {
			if(pc.cocks.length == 1) output("  <b>Your [pc.cock] would look more at home on a large horse than you.</b>");
			if(pc.cocks.length > 1) output("  <b>Your [pc.cocksLight] would look more at home on a large horse than on your body.</b>");
			if (pc.biggestTitSize() >= 3) {
				if (pc.cocks.length == 1) output("  You could easily stuff your [pc.cock] between your breasts and give yourself the titty-fuck of a lifetime.");
				if (pc.cocks.length > 1) output("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
			}
			else {
				if(pc.cocks.length == 1) output("  Your [pc.cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
				if(pc.cocks.length > 1) output("  Your [pc.cocksLight] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
			}
		}
		if(pc.cocks[0].cLength() >= 20 && pc.cocks[0].cLength()-temp2 < 20) {
			if(pc.cocks.length == 1) output("  <b>As if the pulsing heat of your [pc.cock] wasn't enough, the tip of your [pc.cock] keeps poking its way into your view every time you get hard.</b>");
			if(pc.cocks.length > 1) output("  <b>As if the pulsing heat of your [pc.cocksLight] wasn't bad enough, every time you get hard, the tips of your [pc.cocksLight] wave before you, obscuring the lower portions of your vision.</b>");
			if(pc.cor() > 40 && pc.cor() <= 60) {
				if(pc.cocks.length > 1) output("  You wonder if there is a demon or beast out there that could take the full length of one of your [pc.cocksLight]?");
				if(pc.cocks.length ==1) output("  You wonder if there is a demon or beast out there that could handle your full length.");
			}
			if(pc.cor() > 60 && pc.cor() <= 80) {
				if(pc.cocks.length > 1) output("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [pc.cocksLight] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
				if(pc.cocks.length ==1) output("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [pc.cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
			}
			if(pc.cor() > 80) {
				if(pc.cocks.length > 1) output("  You find yourself fantasizing about impaling nubile young champions on your [pc.cocksLight] in a year's time.");
			}
		}
	}
	//Display the degree of length loss.
	if(temp2 < 0 && temp2 >= -1) {
		if(pc.cocks.length == 1) output("Your [pc.cocksLight] has shrunk to a slightly shorter length.");
		if(pc.cocks.length > 1) {
			if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] have shrunk to a slightly shorter length.");
			if(ncocks > 1 && ncocks < pc.cocks.length) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] have shrunk to a slightly shorter length.");
			if(ncocks == 1) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] has shrunk to a slightly shorter length.");
		}
	}
	if(temp2 < -1 && temp2 > -3) {
		if(pc.cocks.length == 1) output("Your [pc.cocksLight] shrinks smaller, flesh vanishing into your groin.");
		if(pc.cocks.length > 1) {
			if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
			if(ncocks == 1) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
			if(ncocks > 1 && ncocks < pc.cocks.length) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
		}
	}
	if(temp2 <= -3) {
		if(pc.cocks.length == 1) output("A large portion of your [pc.cocksLight]'s length shrinks and vanishes.");
		if(pc.cocks.length > 1) {
			if(ncocks == pc.cocks.length) output("A large portion of your [pc.cocksLight] receeds towards your groin, receding rapidly in length.");
			if(ncocks == 1) output("A single member of your [pc.cocksLight] vanishes into your groin, receding rapidly in length.", false);
			if(ncocks > 1 && pc.cocks.length > ncocks) output("Your [pc.cocksLight] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
		}
	}
}
public function killCocks(deadCock:Number):void
{
	//Count removal for text bits
	var removed:Number = 0;
	var temp:Number;
	//Holds cock index
	var storedCock:Number = 0;
	//Less than 0 = PURGE ALL
	if (deadCock < 0) {
		deadCock = pc.cocks.length;
	}
	//Double loop - outermost counts down cocks to remove, innermost counts down
	while (deadCock > 0) {
		//Find shortest cock and prune it
		temp = pc.cocks.length;
		while (temp > 0) {
			temp--;
			//If anything is out of bounds set to 0.
			if (storedCock > pc.cocks.length - 1) storedCock = 0;
			//If temp index is shorter than stored index, store temp to stored index.
			if (pc.cocks[temp].cLength() <= pc.cocks[storedCock].cLength()) storedCock = temp;
		}
		//Smallest cock should be selected, now remove it!
		pc.removeCock(storedCock, 1);
		removed++;
		deadCock--;
		if (pc.cocks.length == 0) deadCock = 0;
	}
	//Texts
	if (removed == 1) {
		if (pc.cocks.length == 0) {
			output("<b>Your manhood shrinks into your body, disappearing completely.</b>");
			//if (findStatusAffect(StatusAffects.Infested) >= 0) output("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
		}
		if (pc.cocks.length == 1) {
			output("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [pc.cock].</b>");
		}
		if (pc.cocks.length > 1) {
			output("<b>Your smallest penis disappears forever, leaving you with just your [pc.cocks].</b>");
		}
	}
	if (removed > 1) {
		if (pc.cocks.length == 0) {
			output("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
			//if (findStatusAffect(StatusAffects.Infested) >= 0) output("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
		}
		if (pc.cocks.length == 1) {
			output("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [pc.cock].");
		}
		if (pc.cocks.length > 1) {
			output("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [pc.cocks].");
		}
	}
	//remove infestation if cockless
	//if (cocks.length == 0) removeStatusAffect(StatusAffects.Infested);
	if (pc.cocks.length == 0 && pc.balls > 0) {
		output("  <b>Your [pc.sack] shrink and disappear, vanishing into your groin.</b>");
		pc.balls = 0;
		pc.ballSizeRaw = 1;
	}
}

public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
{
	if(pc.breastRows.length == 0) return;
	//GrowthType 1 = smallest grows
	//GrowthType 2 = Top Row working downward
	//GrowthType 3 = Only top row
	var temp2:Number = 0;
	var temp3:Number = 0;
	//Chance for "big tits" perked characters to grow larger!
	//if(pc.hasPerk("Big Breasts") >= 0 && rand(3) == 0 && amount < 1) amount=1;

	// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
	var temp:Number = pc.breastRows.length;
	if(growthType == 1) {
		//Select smallest breast, grow it, move on
		while(rowsGrown > 0) {
			//Temp = counter
			temp = pc.breastRows.length;
			//Temp2 = smallest tits index
			temp2 = 0;
			//Find smallest row
			while(temp > 0) {
				temp--;
				if(pc.breastRows[temp].breastRatingRaw < pc.breastRows[temp2].breastRatingRaw) temp2 = temp;
			}
			//Temp 3 tracks total amount grown
			temp3 += amount;
			trace("Breastrow chosen for growth: " + String(temp2) + ".");
			//Reuse temp to store growth amount for diminishing returns.
			temp = amount;
			//if (!flags[kFLAGS.HYPER_HAPPY])
			//{
				//Diminishing returns!
				if(pc.breastRows[temp2].breastRatingRaw > 3)
				{
					if(!pc.hasPerk("Big Breasts"))
						temp /=1.5;
					else
						temp /=1.3;
				}

				// WHy are there three options here. They all have the same result.
				if(pc.breastRows[temp2].breastRatingRaw > 7)
				{
					if(!pc.hasPerk("Big Breasts"))
						temp /=2;
					else
						temp /=1.5;
				}
				if(pc.breastRows[temp2].breastRatingRaw > 9)
				{
					if(!pc.hasPerk("Big Breasts"))
						temp /=2;
					else
						temp /=1.5;
				}
				if(pc.breastRows[temp2].breastRatingRaw > 12)
				{
					if(!pc.hasPerk("Big Breasts"))
						temp /=2;
					else
						temp  /=1.5;
				}
			//}

			//Grow!
			trace("Growing breasts by ", temp);
			pc.breastRows[temp2].breastRatingRaw += temp;
			rowsGrown--;
		}
	}

	//if (!flags[kFLAGS.HYPER_HAPPY])
	//{
		//Diminishing returns!
		if(pc.breastRows[0].breastRatingRaw > 3) {
			if(!pc.hasPerk("Big Breasts")) amount/=1.5;
			else amount/=1.3;
		}
		if(pc.breastRows[0].breastRatingRaw > 7) {
			if(!pc.hasPerk("Big Breasts")) amount/=2;
			else amount /= 1.5;
		}
		if(pc.breastRows[0].breastRatingRaw > 12) {
			if(!pc.hasPerk("Big Breasts")) amount/=2;
			else amount /= 1.5;
		}
	//}
	/*if(breastRows[0].breastRatingRaw > 12) {
		if(hasPerk("Big Tits") < 0) amount/=2;
		else amount /= 1.5;
	}*/
	if(growthType == 2) {
		temp = 0;
		//Start at top and keep growing down, back to top if hit bottom before done.
		while(rowsGrown > 0) {
			if(temp+1 > pc.breastRows.length) temp = 0;
			pc.breastRows[temp].breastRatingRaw += amount;
			trace("Breasts increased by " + amount + " on row " + temp);
			temp++;
			temp3 += amount;
			rowsGrown--;
		}
	}
	if(growthType == 3) {
		while(rowsGrown > 0) {
			rowsGrown--;
			pc.breastRows[0].breastRatingRaw += amount;
			temp3 += amount;
		}
	}
	//Breast Growth Finished...talk about changes.
	trace("Growth ammout = ", amount);
	if(display) {
		if(growthType < 3) {
			if(amount <= 2)
			{
				if(pc.breastRows.length > 1) outputText("Your rows of [pc.fullChest] jiggle with added weight, growing a bit larger.", false);
				if(pc.breastRows.length == 1) outputText("Your [pc.fullChest] jiggle with added weight as they expand, growing a bit larger.", false);
			}
			else if(amount <= 4)
			{
				if(pc.breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of [pc.fullChest] expand significantly.", false);
				if(pc.breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your [pc.fullChest] expand significantly.", false);
			}
			else
			{
				if(pc.breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your [pc.fullChest] tingle strongly, growing disturbingly large.", false);
				if(pc.breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your [pc.fullChest] intensifies as they continue to grow at an obscene rate.", false);
			}
		}
		else
		{
			if(amount <= 2) {
				if(pc.breastRows.length > 1) outputText("Your top row of [pc.fullChest] jiggles with added weight as it expands, growing a bit larger.");
				if(pc.breastRows.length == 1) outputText("Your row of [pc.fullChest] jiggles with added weight as it expands, growing a bit larger.");
			}
			if(amount > 2 && amount <= 4) {
				if(pc.breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of [pc.fullChest] expand significantly.", false);
				if(pc.breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your [pc.fullChest] expand significantly.", false);
			}
			if(amount > 4) {
				if(pc.breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of [pc.fullChest] tingle strongly, growing disturbingly large.", false);
				if(pc.breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tinglng in your [pc.fullChest] intensifies as they continue to grow at an obscene rate.", false);
			}
		}
	}
}

public function shrinkTits():void
{
	if(pc.breastRows.length == 1) {
		if(pc.breastRows[0].breastRatingRaw > 0) {
			//Shrink if bigger than N/A cups
			var temp:Number;
			temp = 1;
			pc.breastRows[0].breastRatingRaw--;
			//Shrink again 50% chance
			if(pc.breastRows[0].breastRatingRaw >= 1 && rand(2) == 0 && !pc.hasPerk("Big Tits")) {
				temp++;
				pc.breastRows[0].breastRatingRaw--;
			}
			if(pc.breastRows[0].breastRatingRaw < 0) pc.breastRows[0].breastRatingRaw = 0;
			//Talk about shrinkage
			if(temp == 1) output("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + pc.breastCup(0) + "s.");
			if(temp == 2) output("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + pc.breastCup(0) + "s.");
		}
	}
	else if(pc.breastRows.length > 1) {
		//multiple
		output("\n", false);
		//temp2 = amount changed
		//temp3 = counter
		var temp2:Number = 0;
		var temp3:Number = pc.breastRows.length;
		while(temp3 > 0) {
			temp3--;
			if(pc.breastRows[temp3].breastRatingRaw > 0) {
				pc.breastRows[temp3].breastRatingRaw--;
				if(pc.breastRows[temp3].breastRatingRaw < 0) pc.breastRows[temp3].breastRatingRaw = 0;
				temp2++;
				output("\n", false);
				if(temp3 < pc.breastRows.length - 1) output("...and y", false);
				else output("Y", false);
				output("our " + pc.breastDescript(temp3) + " shrink, dropping to " + pc.breastCup(temp3) + "s.", false);
			}
			if(pc.breastRows[temp3].breastRatingRaw < 0) pc.breastRows[temp3].breastRatingRaw = 0;
		}
		if(temp2 == 2) output("\nYou feel so much lighter after the change.");
		if(temp2 == 3) output("\nWithout the extra weight you feel particularly limber.");
		if(temp2 >= 4) output("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
	}
}

// Attempts to put the player in heat (or deeper in heat).
// Returns true if successful, false if not.
// The player USUALLY cannot go into heat if she is already pregnant or have no vagina.
// 
// First parameter: boolean indicating if function should output standard text.
// Second parameter: intensity, an integer multiplier that can increase the duration and intensity. Defaults to 1.
// Third parameter: boolean indicating if this heat will end with pregnancy. If true, nothing would ever end it until it is gone over time.
// Fourth parameter: boolean indicating if this heat is necessarily requires vagina. If true, males/genderless can go into heat unless butt-pregnant (usually eggs).
public function goIntoHeat(out:Boolean, intensity:int = 1, forced:Boolean = false, mpreg:Boolean = false):Boolean {
	var canVagPreg:Function = function():Boolean {
		for (var i:int = 0; i < pc.vaginas.length; i++)
			if (!pc.isPregnant(i)) return true;
		return false;
	}
	if(!forced && !canVagPreg() && !(mpreg && !pc.isPregnant(3))) {
		return false; // No vagina or already pregnant, can't go into heat.
	}
	
	//Already in heat, intensify further.
	if (pc.hasStatusEffect("Heat")) {
		if(out) {
			output("\n\nYour mind clouds as your [pc.vagina] moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
		}
		pc.setStatusValue("Heat", 1, pc.statusEffectv1("Heat") + 5 * intensity); // fertility bonus
		pc.setStatusValue("Heat", 2, pc.statusEffectv2("Heat") + 5 * intensity); // libido bonus
		if(forced) pc.setStatusValue("Heat", 3, 1); // forced means it would not end if pregnant
		if(forced) pc.setStatusValue("Heat", 4, 1); // mpreg means it would not end if vagina lost
		pc.addStatusMinutes("Heat", 48 * 60 * intensity);
		pc.libido(5 * intensity);
	}
	//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is forced (would not end by any means), v4 is mpreg (would apply to males and not gone with vagina)
	else {
		if(out) {
			output("\n\nYour mind clouds as your [pc.vagina] moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
		}
		pc.createStatusEffect("Heat", 10 * intensity, 15 * intensity, forced ? 1 : 0, mpreg ? 1 : 0, false, "LustUp", "You are aching to be on recieving end of a good fuck due to your animal heat!", false, 48 * 60 * intensity);
		pc.libido(15 * intensity);
	}
	return true;
}


// Attempts to put the player in rut (or deeper in rut).
// Returns true if successful, false if not.
// The player cannot go into rut without male genitals.
// 
// First parameter: boolean indicating if function should output standard text.
// Second parameter: intensity, an integer multiplier that can increase the 
// duration and intensity. Defaults to 1.
public function goIntoRut(out:Boolean, intensity:int = 1):Boolean {
	if (!pc.hasCock()) {
		// No cocks, can't go into rut.
		return false;
	}
	
	//Has rut, intensify it!
	if (pc.hasStatusEffect("Rut")) {
		if(out) {
			output("\n\nYour [pc.multiCocks] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
		}
		
		pc.setStatusValue("Rut", 1, pc.statusEffectv1("Rut") + 100 * intensity); // virility bonus
		pc.setStatusValue("Rut", 2, pc.statusEffectv2("Rut") + 5 * intensity); // libido bonus
		pc.addStatusMinutes("Rut", 48 * 60 * intensity);
		pc.libido(5 * intensity);
	}
	else {
		if(out) {
			output("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
		}
		
		//v1 - bonus cum production
		//v2 - bonus libido
		pc.createStatusEffect("Rut", 10 * intensity, 15 * intensity, 0, 0, false, "LustUp", "You desperately want to fuck someone due to your animal rut!", false, 48 * 60 * intensity);
		pc.libido(15 * intensity);
	}
	
	return true;
}

public function HeatTimePassedNotify():void {
	if (pc.hasStatusEffect("Heat") && pc.statusEffectv3("Heat") == 0) {
		if (pc.isPregnant()) {
			eventBuffer += "\n\n<b>Your heat is suddenly gone.</b>";
			pc.removeStatusEffect("Heat");
		}
		if (!pc.hasVagina() && pc.statusEffectv4("Heat") == 0) {
			eventBuffer += "\n\n<b>Your heat is gone with your vagina.</b>";
			pc.removeStatusEffect("Heat");
		}
	}
	if (pc.hasStatusEffect("Rut") && !pc.hasCock()) {
		eventBuffer += "\n\n<b>Your rut is gone with your male genitals.</b>";
		pc.removeStatusEffect("Rut");
	}
}
private var HeatTimePassedNotifyHook: * = HeatTimePassedNotifyGrapple();
private function HeatTimePassedNotifyGrapple():* { timeChangeListeners.push(HeatTimePassedNotify); }