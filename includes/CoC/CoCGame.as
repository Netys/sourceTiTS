import classes.CockClass;
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

public var variableRoomUpdateListeners:/*Function*/Array = [];

public function notifyVariableRoomUpdateListenerss():void {
	for each (var name:* in variableRoomUpdateListeners) name();
}

include "events.as";
include "gameStats.as";
include "masturbation.as";
include "rooms.as";

// AREAS
include "areas/boat/boat.as";
include "areas/boat/FetishZealotScene.as";
include "areas/boat/MaraeScene.as";
include "areas/boat/SharkGirlScene.as";
include "areas/camp/camp.as";
include "areas/deepwoods/AkbalScene.as";
include "areas/deepwoods/deepwoods.as";
include "areas/deepwoods/ErlKingScene.as";
include "areas/deepwoods/Faerie.as";
include "areas/deepwoods/KitsuneScene.as";
include "areas/desert/desert.as";
include "areas/desert/Fountain.as";
include "areas/desert/NagaScene.as";
include "areas/desert/Oasis.as";
include "areas/desert/SandTrapScene.as";
include "areas/desert/SandWitchScene.as";
include "areas/desert/Wanderer.as";
include "areas/exploration.as";
include "areas/exploration/Gargoyle.as";
include "areas/exploration/Giacomo.as";
include "areas/exploration/GoblinAssassinScene.as";
include "areas/exploration/GoblinScene.as";
include "areas/exploration/ImpLordScene.as";
include "areas/exploration/ImpScene.as";
include "areas/exploration/Lumi.as";
include "areas/forest/BeeGirlScene.as";
include "areas/forest/CorruptedGlade.as";
include "areas/forest/Essrayle.as";
include "areas/forest/forest.as";
include "areas/forest/tamaniDaughters.as";
include "areas/forest/TamaniScene.as";
include "areas/forest/tentacleBeastScene.as";
include "areas/highmountain/BasiliskScene.as";
include "areas/highmountain/ChickenHarpy.as";
include "areas/highmountain/HarpyScene.as";
include "areas/highmountain/highmountain.as";
include "areas/highmountain/IzumiScene.as";
include "areas/highmountain/MinervaScene.as";
include "areas/highmountain/phoenix.as";
include "areas/intro.as";
include "areas/lake/CalluScene.as";
include "areas/lake/FetishCultistScene.as";
include "areas/lake/GooGirlScene.as";
include "areas/lake/GreenSlimeScene.as";
include "areas/lake/Kaiju.as";
include "areas/lake/lake.as";
include "areas/lake/SwordInStone.as";
include "areas/mountain/CeraphScene.as";
include "areas/mountain/GoblinSalon.as";
include "areas/mountain/HellhoundScene.as";
include "areas/mountain/MinotaurScene.as";
include "areas/mountain/mountain.as";
include "areas/mountain/WormsScene.as";
include "areas/plains/BunnyGirl.as";
include "areas/plains/GnollScene.as";
include "areas/plains/GnollSpearThrowerScene.as";
include "areas/plains/plains.as";
include "areas/plains/SatyrScene.as";
include "areas/swamp/CorruptedDriderScene.as";
include "areas/swamp/FemaleSpiderMorphScene.as";
include "areas/swamp/MaleSpiderMorphScene.as";
include "areas/swamp/Rogar.as";
include "areas/swamp/swamp.as";
include "areas/swamp/SwampLoot.as";

// PLACES, note: sub-uncludes are usually inside places
include "places/bazaar/bazaar.as";
include "places/deepCave/ZetazCave.as";
include "places/desertCave/DesertCave.as";
include "places/factory/factory.as";
include "places/farm/Farm.as";
include "places/fortress/fortress.as";
include "places/owca/owca.as";
include "places/phoenixTower/phoenixTower.as";
include "places/teladre/TelAdre.as";

// CHARACTERS
include "characters/amily.as";
include "characters/AnemoneScene.as";
include "characters/ArianScene.as";
include "characters/ceraphFollower.as";
include "characters/ember.as";
include "characters/exgartuan.as";
include "characters/followerInteractions.as";
include "characters/Hel.as";
include "characters/IzmaScene.as";
include "characters/jojoCorrupt.as";
include "characters/JojoScene.as";
include "characters/kihaFollower.as";
include "characters/KihaScene.as";
include "characters/milkWaifu.as";
include "characters/phylla.as";
include "characters/Rathazul.as";
include "characters/SheilaScene.as";
include "characters/shouldra.as";
include "characters/shouldraFollower.as";
include "characters/Sophie.as";
include "characters/sophieBimbo.as";
include "characters/sophieFollower.as";
include "characters/valeria.as";
include "characters/vapula.as";

public function initCoCJunk():void {
	if (flags["COC.CORRUPTION"] == undefined) flags["COC.CORRUPTION"] = int(pc.personality / 2.1) + 10;
	if (flags["COC.TIMES_TRANSFORMED"] == undefined) flags["COC.TIMES_TRANSFORMED"] = 0;
}
public function inMareth():Boolean {
	return rooms[currentLocation].system == "PLANET: MARETH";
}
public function allowFollowers():Boolean {
	return true;
}

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
	return flags["COC.NIAMH_STATUS"] > 0 || flags["COC.JOJO_STATE"]  >= 5 || amilyCorrupt(); // || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || 
}

public function get timeAsStamp():uint {
	return GetGameTimestamp(); }

public function timeUntil(target:int):uint {
	var now:uint = hours * 60 + minutes;
	if (now < target) return target - now;
	return (24 * 60 - now) + target;
}

// legacy wrappers
public function doNext(param:Function, arg:*= null):void {
	addNextButton(param, arg);
}

public function outputText(text:String, param:Boolean = false):void {
	if (param) { clearOutput(); clearMenu(); }
	output(text);
}

public function gender(target:Creature):int {
	if (target.isHerm()) return 3;
	if (target.hasVagina()) return 2;
	if (target.hasCock()) return 1;
	return 0;
}

public const KBIT_SPELL_AROUSE:uint		= 1;
public const KBIT_SPELL_HEAL:uint		= 2;
public const KBIT_SPELL_MIGHT:uint		= 4;
public const KBIT_SPELL_CHARGE:uint		= 8;
public const KBIT_SPELL_BLIND:uint		= 16;
public const KBIT_SPELL_WHITEFIRE:uint	= 32;

public function getKnownFireMagic():String {
	if (pc.hasPerk("Enlightened Nine-tails")) return "ethereal fire";
	if (pc.hasPerk("Corrupted Nine-tails")) return "ghostly flame";
	if ((pc.perkv1("Psionic Affinity") & KBIT_SPELL_WHITEFIRE) > 0) return "whitefire";
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

public function hasSpells():Boolean {
	return spellCount() > 0 || isNineTails(pc);
}

public function spellCount():int {
	var counter:int = 0;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_AROUSE) > 0) counter++;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_HEAL) > 0) counter++;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_MIGHT) > 0) counter++;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_CHARGE) > 0) counter++;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_BLIND) > 0) counter++;
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_WHITEFIRE) > 0) counter++;
	return counter;
}

// convert CoC area to TiTS volume
public function cockVolume(area:Number):Number {
	return new CockClass(Math.sqrt(area * 6)).volume();
}

public function onSpellCast(caster:Creature):String {
	if (caster != pc) return "";
	
	// perk values: known spells mask / power mod / cost mod / cast counter
	if(!pc.hasPerk("Magic Affinity")) pc.createPerk("Magic Affinity", 0, 0, 0, 0, "Grants you insight into mysteries of magic.");
	
	pc.addPerkValue("Magic Affinity", 4, 1);
	
	if (pc.perkv4("Magic Affinity") >= 5 && pc.perkv3("Magic Affinity") < 20) {
		pc.setPerkValue("Magic Affinity", 3, 20);
		return "\n<b>You've become more comfortable with your spells, reducing energy cost of spells by 20%!</b>\n";
	}
	
	if (pc.perkv4("Magic Affinity") >= 15 && pc.perkv3("Magic Affinity") < 35) {
		pc.setPerkValue("Magic Affinity", 3, 35);
		return "\n<b>You've become more comfortable with your spells, reducing energy cost of spells by an additional 15%!</b>\n";
	}
	
	if (pc.perkv4("Magic Affinity") >= 45 && pc.perkv3("Magic Affinity") < 50) {
		pc.setPerkValue("Magic Affinity", 3, 50);
		return "\n<b>You've become more comfortable with your spells, reducing energy cost of spells by an additional 15%!</b>\n";
	}
	
	return "";
}