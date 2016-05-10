import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Ember? It's a follower, so big maybe
public function exploreSwamp():void {
	if (helSexualAmbush()) return;
	
	showName("\nSWAMP");
	IncrementFlag("COC.EXPLORED_SWAMP");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	var choice:Array = [];
	var chance:Array = [];
	
	//Discover 'Bog' at after 25 explores of swamp
	//if ((flags[kFLAGS.TIMES_EXPLORED_SWAMP] >= 25) && flags[kFLAGS.BOG_EXPLORED] == 0) {
		//output("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked!</b>)", true);
		//flags[kFLAGS.BOG_EXPLORED]++;
		//doNext(returnToCampUseOneHour);
		//return;
	//}
	
	/*  SPECIAL SCENE OVERWRITES */
	if (int(flags["COC.TOOK_EMBER_EGG"]) == 0 && int(flags["COC.EGG_BROKEN"]) == 0 && flags["COC.EXPLORED_SWAMP"] > 0 && (flags["COC.EXPLORED_SWAMP"] % 40 == 0)) {
		findEmbersEgg();
		return;
	}
	//KIHA X HEL THREESOME!
	if (!followerKiha() && pc.cor() < 60 && flags["COC.KIHA_AFFECTION_LEVEL"] >= 1 && flags["COC.HEL_FUCKBUDDY"] > 0 && pc.hasCock() && int(flags["COC.KIHA_AND_HEL_WHOOPIE"]) == 0) {
		kihaXSalamander();
		return;
	}
	
	/*  STANDARD SCENE SELECTION  */
	
	choice.push(SwampLootExplore);
	chance.push(1);
	
	choice.push(fSpiderMorphGreeting);
	chance.push(1);
	
	choice.push(greetMaleSpiderMorph);
	chance.push(1);
	
	choice.push(driderEncounter);
	chance.push(1);
	
	if(!followerKiha()) {
		choice.push(encounterKiha);
		chance.push(2);
	}
	
	if (flags["COC.ROGAR_DISABLED"] != 1 && !(flags["COC.ROGAR_PHASE"] >= 3)) {
		choice.push(encounterRogarSwamp);
		chance.push(4);
	}
	
	WeightedRandom(choice, chance, true)();
}