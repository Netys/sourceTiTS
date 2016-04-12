import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function displayQuestLogCoCMain():int {
	// Main Questline:
	var mainCount:int = 0;
	// Tavros
	if(flags["COC.NEMO_INTRODUCED"] != undefined)
	{
		output2("\n<b><u>Tavros Station</u></b>");
		output2("\n<b>* Status:</b> Met nemo");
		if (flags["COC.NEMO_VR_POD_TAKEN"] != undefined) output2(", Acquired VR pod");
		if (flags["COC.NEMO_VR_POD_TAKEN"] == -1) output2(", Returned VR pod");
		if (flags["COC.NEMO_COMPENSATION"] != undefined) output2(", Acquired " + flags["COC.NEMO_COMPENSATION"] + " implant");
		mainCount++;
	}
	
	// VR Pod
	if(flags["COC.NEMO_VR_POD_TAKEN"] != undefined)
	{
		output2("\n<b><u>VR Pod</u></b>");
		output2("\n<b>* Status:</b>");
		if (flags["COC_VR_INTRO_SEEN"] != undefined) output2(" Used");
		else output2(" <i> Not Used</i>");
		if (flags["COC_VR_INTRO_SEEN"] == 1) {
			if (flags["COC_INTRO_SEEN"] == undefined)  output2(", Aborted immediately");
			if (flags["COC_INTRO_SEEN"] == 1)  output2(", Entered main sequence");
			if (flags["COC_INTRO_SEEN"] == 2)  output2(", Broken");
			if (flags["COC_INTRO_SEEN"] == 2 && flags["COC.NEMO_VR_POD_TAKEN"] == 1)  output2(", Fixed");
			if (flags["COC_INTRO_SEEN"] == 2 && flags["COC.NEMO_VR_POD_TAKEN"] == -1)  output2(", Left behind");
		}
		mainCount++;
	}
	
	// Main questline
	if(flags["COC_INTRO_SEEN"] != undefined)
	{
		output2("\n<b><u>Main Quest</u></b>");
		output2("\n<b>* Status:</b> Met Zetaz");
		if (flags["COC.MET_MARAE"] != undefined) output2(", Met Marae");
		if (flags["COC.MET_MARAE"] != undefined) output2(", Met Marae");
		if (flags["COC.FACTORY_SHUTDOWN"] == 1) output2(", Disabled Factory");
		if (flags["COC.FACTORY_SHUTDOWN"] == 2) output2(", Destroyed Factory");
		if (flags["COC.DEFEATED_ZETAZ"] != undefined) output2(", Defeated Zetaz");
		if (flags["COC.PLOT_END"] != undefined) output2(", Defeated Lethice");
		mainCount++;
	}
	
	return mainCount;
}

public function displayQuestLogCoCSide():int {
	// Side questsint
	var sideCount:Number = 0;
	
	return sideCount;
}

public function displayEncounterLogCoCVarious():int
{
	var variousCount:int = 0;
	
	return variousCount;
}