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
	var variousCount:int = 1;
	
	//=====GENERAL STATS=====//
	output2("\n\n" + blockHeader("General Statistics", false));
	// Crew
	output2("\n<b><u>Camp</u></b>");
	output2("\n<b>* Companions: </b>" + companionsCount());
	
	var totalOffspring:Number = StatTracking.getStat("coc/pregnancy/total births");
	var totalProduce:Number = 0;
	totalProduce += StatTracking.getStat("coc/pregnancy/unfertilized eggs");
	variousCount += (totalOffspring + totalProduce);
	if((totalOffspring + totalProduce) > 0)
	{
		output2("\n\n" + blockHeader("Reproduction Statistics", false));
		if(totalOffspring)
		{
			output2("\n<b><u>Offspring</u></b>");
			output2("\n<b>* Total: </b>" + totalOffspring);
			
			// Mother
			if(StatTracking.getStat("coc/pregnancy/imps birthed") > 0)
				output2("\n<b>* Births, Imp Litters: </b>" + StatTracking.getStat("coc/pregnancy/imps birthed"));
			if(StatTracking.getStat("coc/pregnancy/mice") > 0)
				output2("\n<b>* Births, Amily Litters: </b>" + StatTracking.getStat("coc/pregnancy/mice"));
			if (StatTracking.getStat("coc/pregnancy/anemones birthed") > 0)
				output2("\n<b>* Births, Anemone: </b>" + StatTracking.getStat("coc/pregnancy/anemones birthed"));
			if (StatTracking.getStat("coc/pregnancy/pc cotton") > 0)
				output2("\n<b>* Births, Cotton Children: </b>" + StatTracking.getStat("coc/pregnancy/pc cotton"));
			if (StatTracking.getStat("coc/pregnancy/pc sharkgirls") + StatTracking.getStat("coc/pregnancy/pc tigersharks") > 0)
			{
				output2("\n<b>* Births, Izma Daughters: </b>");
				enum.clear();
				if (StatTracking.getStat("coc/pregnancy/pc sharkgirls") > 0)
					enum.push(StatTracking.getStat("coc/pregnancy/pc sharkgirls") + " shark-girls");
				if (StatTracking.getStat("coc/pregnancy/pc tigersharks") > 0)
					enum.push(StatTracking.getStat("coc/pregnancy/pc tigersharks") + " tigersharks");
				output2(enum.toString() + ".");
			}
			
			// Father
			if(StatTracking.getStat("coc/pregnancy/imps sired") > 0)
				output2("\n<b>* Fathered, Imp Litters (Total): </b>" + StatTracking.getStat("coc/pregnancy/imps sired"));
			if(StatTracking.getStat("coc/pregnancy/amily") > 0)
				output2("\n<b>* Fathered, Amily Litters: </b>" + StatTracking.getStat("coc/pregnancy/amily"));
			if (StatTracking.getStat("coc/pregnancy/cotton") > 0)
				output2("\n<b>* Fathered, Cotton Children: </b>" + StatTracking.getStat("coc/pregnancy/cotton"));
			if (StatTracking.getStat("coc/pregnancy/izma sharkgirls") + StatTracking.getStat("coc/pregnancy/izma tigersharks") > 0)
			{
				output2("\n<b>* Fathered, Izma Daughters: </b>");
				enum.clear();
				if (StatTracking.getStat("coc/pregnancy/izma sharkgirls") > 0)
					enum.push(StatTracking.getStat("coc/pregnancy/izma sharkgirls") + " shark-girls");
				if (StatTracking.getStat("coc/pregnancy/izma tigersharks") > 0)
					enum.push(StatTracking.getStat("coc/pregnancy/izma tigersharks") + " tigersharks");
				output2(enum.toString() + ".");
			}
			if(StatTracking.getStat("coc/pregnancy/tamani daughters") > 0)
				output2("\n<b>* Fathered, Tamani Daughters: </b>" + StatTracking.getStat("coc/pregnancy/tamani daughters"));
			if(StatTracking.getStat("coc/pregnancy/sheila joeys") > 0)
				output2("\n<b>* Fathered, Sheila Joeys: </b>" + StatTracking.getStat("coc/pregnancy/sheila joeys"));
			if(StatTracking.getStat("coc/pregnancy/sheila imps") > 0)
				output2("\n<b>* Fathered, Sheila Imps: </b>" + StatTracking.getStat("coc/pregnancy/sheila imps"));
		}
		if(totalProduce)
		{
			output2("\n<b><u>Produce</u></b>");
			output2("\n<b>* Total: </b>" + totalProduce);
			if(StatTracking.getStat("coc/pregnancy/unfertilized eggs") > 0)
				output2("\n<b>* Births, Unfertilized Eggs, Total: </b>" + StatTracking.getStat("coc/pregnancy/unfertilized eggs"));
		}
	}
	
	if(flags["COC.TEL_ADRE_KNOWN"] > 0) {
		output2("\n\n" + blockHeader("Encounters: Tel Adre", false));
		
		output2("\n<b><u>Urta</u></b>"); // if you know Tel Adre you know Urta
		if (int(flags["COC.TIMES_FUCKED_URTA"]) > 0)
			output2("\n<b>* Times sexed: </b>" + int(flags["COC.TIMES_FUCKED_URTA"]));
		if (int(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"]) > 0)
			output2("\n<b>* Confidence: </b>" + int(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"]));
		if (int(flags["COC.URTA_PC_AFFECTION_COUNTER"]) > 0)
			output2("\n<b>* Affection: </b>" + int(flags["COC.URTA_PC_AFFECTION_COUNTER"]));
		if(int(flags["COC.DISCUSSED_URTA_ALCOHOLISM"]) == 1) {
			output2("\n<b>* Alcohol: </b>");
			if (int(flags["COC.URTA_ALCOHOL_HABIT"]) == -1) output2(" Little");
			if (int(flags["COC.URTA_ALCOHOL_HABIT"]) == 0) output2(" Average");
			if (int(flags["COC.URTA_ALCOHOL_HABIT"]) == 1) output2(" Lots");
		}
		output2("\n<b>* Attitude: </b>");
		if (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] == -1) output2(" Upset");
		else if (urtaJustFriends()) output2(" Friend");
		else if (urtaLove()) output2(" Lover");
		else if (urtaFuckbuddy()) output2(" Fuckbuddy");
		else  output2(" Undecided");
	}
	
	if(flags["COC.EXPLORED_PLAINS"] > 0) {
		output2("\n\n" + blockHeader("Encounters: Plains", false));
		if(flags["COC.HEL_TIMES_ENCOUNTERED"] > 0) {
			output2("\n<b><u>Helia</u></b>");
			output2("\n<b>* Times met: </b>" + flags["COC.HEL_TIMES_ENCOUNTERED"]);
			output2("\n<b>* Times sexed: </b>" + flags["COC.HEL_FUCK_COUNTER"]);
			output2("\n<b>* Affection: </b>" + helAffection());
			output2("\n<b>* Attitude: </b>");
			if (flags["COC.HEL_REDUCED_ENCOUNTER_RATE"] == 1) output2(" Upset");
			else if (flags["COC.HEL_FUCKBUDDY"] == 1 && flags["COC.PC_PROMISED_HEL_MONOGAMY_FUCKS"] == 1) output2(" Stalker");
			else if (flags["COC.HEL_FUCKBUDDY"] == 1) output2(" Fuckbuddy");
			else if (followerHel() && flags["COC.HEL_FOLLOWER_LEVEL"] == 2) output2(" Lover");
			else  output2(" Undecided");
		}
	}
	
	output2("\n\n" + blockHeader("Encounters: Other", false));
	if(flags["COC.AMILY_MET"] > 0) {
		output2("\n<b><u>Amily</u></b>");
		output2("\n<b>* Affection: </b>" + flags["COC.AMILY_AFFECTION"]);
		if (flags["COC.AMILY_FUCK_COUNTER"] > 0) output2("\n<b>* Times sexed: </b>" + flags["COC.AMILY_FUCK_COUNTER"]);
		if ((StatTracking.getStat("coc/pregnancy/amily") + StatTracking.getStat("coc/pregnancy/mice")) > 0)
			output2("\n<b>* Litters: </b>" + (StatTracking.getStat("coc/pregnancy/amily") + StatTracking.getStat("coc/pregnancy/mice")));
	}
	
	if(flags["COC.COTTON_MET_FUCKED"] > 0) {
		output2("\n<b><u>Cotton</u></b>");
		output2("\n<b>* Status: </b> ");
		if (flags["COC.COTTON_MET_FUCKED"] >= 1) output2("Met");
		if (flags["COC.COTTON_MET_FUCKED"] >= 2) output2(", Sexed");
		if (flags["COC.PC_IS_A_DEADBEAT_COTTON_DAD"] == 1) output2(", Upset");
		if (flags["COC.COTTON_UNUSUAL_YOGA_BOOK_TRACKER"] != undefined) {
			output2("\n<b>* Special book: </b> ");
			if (flags["COC.COTTON_UNUSUAL_YOGA_BOOK_TRACKER"] == 1) {
				if (pc.hasKeyItem("Yoga Guide")) output2("Found");
				else output2("Not Found");
			}
			else output2("Given");
		}
		
		if (StatTracking.getStat("coc/pregnancy/cotton") + StatTracking.track("coc/pregnancy/pc cotton") > 0)
		{
			output2("\n<b>* Children: </b>");
			enum.clear();
			if (StatTracking.getStat("coc/pregnancy/cotton") > 0)
				enum.push(StatTracking.getStat("coc/pregnancy/cotton") + " sired");
			if (StatTracking.getStat("coc/pregnancy/izma tigersharks") > 0)
				enum.push(StatTracking.getStat("coc/pregnancy/pc cotton") + " born");
			output2(enum.toString() + ".");
		}
	}
	
	if(flags["COC.IZMA_MET"] > 0) {
		output2("\n<b><u>Izma</u></b>");
		if (flags["COC.IZMA_TIMES_FOUGHT_AND_WON"] != undefined && flags["COC.IZMA_TIMES_FOUGHT_AND_WON"] != 0)
			output2("\n<b>* Combat victories streak: </b>" + flags["COC.IZMA_TIMES_FOUGHT_AND_WON"]);
		
		if (StatTracking.getStat("coc/pregnancy/izma sharkgirls") + StatTracking.track("coc/pregnancy/pc sharkgirls") + StatTracking.getStat("coc/pregnancy/izma tigersharks") + StatTracking.track("coc/pregnancy/pc tigersharks") > 0)
		{
			output2("\n<b>* Daughters: </b>");
			enum.clear();
			if (StatTracking.getStat("coc/pregnancy/izma sharkgirls") > 0)
				enum.push((StatTracking.getStat("coc/pregnancy/izma sharkgirls") + StatTracking.getStat("coc/pregnancy/pc sharkgirls")) + " shark-girls");
			if (StatTracking.getStat("coc/pregnancy/izma tigersharks") > 0)
				enum.push((StatTracking.getStat("coc/pregnancy/izma tigersharks") + StatTracking.getStat("coc/pregnancy/pc tigersharks")) + " tigersharks");
			output2(enum.toString() + ".");
		}
	}
	
	return variousCount;
}