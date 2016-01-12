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
include "areas/plains/plains.as";
include "areas/plains/SatyrScene.as";
include "areas/plains/GnollScene.as";
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