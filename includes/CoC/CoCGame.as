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
include "areas/boat/fetishZealot.as";
include "areas/boat/marae.as";
include "areas/boat/sharkGirl.as";
include "areas/camp/camp.as";
include "areas/deepwoods/akbal.as";
include "areas/deepwoods/deepwoods.as";
include "areas/deepwoods/erlking.as";
include "areas/deepwoods/faerie.as";
include "areas/deepwoods/kitsune.as";
include "areas/desert/desert.as";
include "areas/desert/fountain.as";
include "areas/desert/naga.as";
include "areas/desert/oasis.as";
include "areas/desert/sandTrap.as";
include "areas/desert/sandWitch.as";
include "areas/desert/wanderer.as";
include "areas/exploration.as";
include "areas/exploration/gargoyle.as";
include "areas/exploration/giacomo.as";
include "areas/exploration/goblin.as";
include "areas/exploration/goblinAssassin.as";
include "areas/exploration/imp.as";
include "areas/exploration/impLord.as";
include "areas/exploration/lumi.as";
include "areas/forest/beeGirl.as";
include "areas/forest/corruptedGlade.as";
include "areas/forest/essrayle.as";
include "areas/forest/forest.as";
include "areas/forest/tamani.as";
include "areas/forest/tamaniDaughters.as";
include "areas/forest/tentacleBeast.as";
include "areas/highmountain/basilisk.as";
include "areas/highmountain/chickenHarpy.as";
include "areas/highmountain/harpy.as";
include "areas/highmountain/highmountain.as";
include "areas/highmountain/izumi.as";
include "areas/highmountain/minerva.as";
include "areas/highmountain/phoenix.as";
include "areas/intro.as";
include "areas/lake/callu.as";
include "areas/lake/fetishCultist.as";
include "areas/lake/gooGirl.as";
include "areas/lake/greenSlime.as";
include "areas/lake/kaiju.as";
include "areas/lake/lake.as";
include "areas/lake/swordInStone.as";
include "areas/mountain/ceraph.as";
include "areas/mountain/hellhound.as";
include "areas/mountain/minotaur.as";
include "areas/mountain/mountain.as";
include "areas/mountain/salon.as";
include "areas/mountain/worms.as";
include "areas/plains/bunnyGirl.as";
include "areas/plains/gnoll.as";
include "areas/plains/gnollSpearThrower.as";
include "areas/plains/plains.as";
include "areas/plains/satyr.as";
include "areas/swamp/drider.as";
include "areas/swamp/rogar.as";
include "areas/swamp/spiderFemale.as";
include "areas/swamp/spiderMale.as";
include "areas/swamp/swamp.as";
include "areas/swamp/swampLoot.as";

// PLACES, note: sub-uncludes are usually inside places
include "places/bazaar/bazaar.as";
include "places/deepCave/zetazCave.as";
include "places/desertCave/desertCave.as";
include "places/factory/factory.as";
include "places/farm/farm.as";
include "places/fortress/fortress.as";
include "places/owca/owca.as";
include "places/phoenixTower/phoenixTower.as";
include "places/teladre/telAdre.as";

// CHARACTERS
include "characters/amily.as";
include "characters/anemone.as";
include "characters/arian.as";
include "characters/ceraphFollower.as";
include "characters/ember.as";
include "characters/exgartuan.as";
include "characters/followerInteractions.as";
include "characters/hel.as";
include "characters/helFollower.as";
include "characters/helspawn.as";
include "characters/holli.as";
include "characters/isabella.as";
include "characters/isabellaFollower.as";
include "characters/izma.as";
include "characters/jojo.as";
include "characters/jojoCorrupt.as";
include "characters/kiha.as";
include "characters/kihaFollower.as";
//include "characters/marble.as"; // maybe, one time... too many obsolete code to rewrite, and too little enthusiasm
include "characters/milkWaifu.as";
include "characters/phylla.as";
include "characters/rathazul.as";
include "characters/sheila.as";
include "characters/shouldra.as";
include "characters/shouldraFollower.as";
include "characters/sophie.as";
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
	if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_WHITEFIRE) > 0) return "whitefire";
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