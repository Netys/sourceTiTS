import classes.Characters.CoC.CoCKatherine;
import classes.GLOBAL;;
import classes.Items.Apparel.MilitaryUniform;
import classes.Items.Transformatives.CoCCaninePepper;
import classes.Items.Transformatives.CoCCaninePepperBulby;
import classes.Items.Transformatives.CoCCaninePepperDouble;
import classes.Items.Transformatives.CoCCaninePepperKnotty;
import classes.Items.Transformatives.CoCCaninePepperLarge;
import classes.Items.Transformatives.CoCReducto;
import classes.Items.Transformatives.CoCWhiskerFruit;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get kath():CoCKatherine
{
	return chars["COC.KATH"];
}

public function katherineSprite(naked:Boolean = false):void {
	showName("\nKATH");
}

public static const KLOC_STREETS:int                    =     0; //Sex happens in a non-descript alleyway, possibly behind the Wet Bitch
public static const KLOC_KATHS_APT:int                  =     1; //At her own home. After sex she will generally stay there
public static const KLOC_URTAS_APT:int                  =     2; //Kath may stay here if she and Urta are fuckbuddies or lovers
public static const KLOC_URTAS_HOME:int                 =     3; //Kath may stay here if she and Urta are fuckbuddies or lovers. They will stay all night.
public static const KLOC_BAR:int                        =     4; //At the Wet Bitch. Returns here unless it's after 14:00 or you were last at her place, Urta's apt or Urta's home.
																	//During sex scenes this indicates the bar or a backroom at the bar depending on the scene.
public static const KLOC_BAR_DRUNK:int                  =     5; //At the Wet Bitch. You got her to drink a lot of booze.
public static const KLOC_BAR_URTA_REFUSED:int           =     6; //At the Wet Bitch. She's drunk and Urta has refused to have sex with her right now.
public static const KLOC_LAKE:int                       =     7; //You take her out to the lake, either for training or for a date
public static const KLOC_DESERT:int                     =     8; //You take her out into the desert for training

public static const KDATE_LITTLE:int                    =     0; //Have sex together only in threesomes with you
public static const KDATE_WHENEVER:int                  =     1; //Have sex together whenever they like
public static const KDATE_LOTS:int                      =     2; //Have lots of sex together

public function kathLocation(allowOverride:Boolean = true):int {
	if (allowOverride && flags["COC.KATHERINE_LOCATION"] != undefined) return flags["COC.KATHERINE_LOCATION"]; // for forced location override by events
	
	if (flags["COC.KATHERINE_UNLOCKED"] < 4) return KLOC_STREETS; // Before employment always returns to the alleyway behind Oswald’s after sex.
	
	if (hours >= 5 && hours < 10) return KLOC_STREETS; // On duty
	if (hours >= 10 && hours < 14) return KLOC_BAR; // after duty in bar
	
	return KLOC_KATHS_APT; // at home
}

public function KatherineTimePassedNotify():void {
	if (minutes == 0 ) { // called every hour
		if (flags["COC.KATHERINE_UNLOCKED"] < 4) { //Before employment always returns to the alleyway behind Oswald’s after sex.
			flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS;
			return; //She only has tattered clothes, so no need to deal with clothing either.
		}
		
		if (hours == 5) {
			flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS; //On duty
			if (flags["COC.KATHERINE_URTA_DATE"] == KDATE_WHENEVER) {
				if (days % 4 == 0) katherineAndUrtaHadSex(false); //Roughly twice a week
			}
			else if (flags["COC.KATHERINE_URTA_DATE"] == KDATE_LOTS) katherineAndUrtaHadSex(false); //They fuck at least once a day
			if (flags["COC.KATHERINE_VALA_DATE"] == KDATE_WHENEVER) {
				if (days % 4 == 0) katherineAndValaHadSex(); //Roughly twice a week
			}
			else if (flags["COC.KATHERINE_VALA_DATE"] == KDATE_LOTS) katherineAndValaHadSex(); //They fuck at least once a day
		}
		
		if (hours >= 14) {
			//Once employed Kath goes home from any encounter after 14:00 hours, unless they happened at either Urta’s apartment or Urta’s house.
			switch (flags["COC.KATHERINE_LOCATION"]) {
				case KLOC_KATHS_APT:
				case KLOC_URTAS_HOME: break; //Already at final destination for the night
				case KLOC_URTAS_APT:
					if (flags["COC.KATHERINE_URTA_AFFECTION"] > 31) {
						if (rand(4) != 0) { //A three in four chance that Kath will stay with Urta once they've hooked up
							if (pc.hasKeyItem("Spare Key to Urta's House") >= 0) flags["COC.KATHERINE_LOCATION"] = KLOC_URTAS_HOME;
							break; //If Urta doesn't have a home to return to then she and Kath stay at the apartment
						}
					}
					else if (flags["COC.KATHERINE_URTA_AFFECTION"] >= 11 && flags["COC.KATHERINE_URTA_DATE"] != KDATE_LITTLE) {
						if (rand(3) != 0) { //A two in three chance that Kath will stay with Urta if they're fuckbuddies
							if (pc.hasKeyItem("Spare Key to Urta's House")) flags["COC.KATHERINE_LOCATION"] = KLOC_URTAS_HOME;
							break; //If Urta doesn't have a home to return to then she and Kath stay at the apartment
						}
					} //else fall through to the default case, Kath goes home
				default: flags["COC.KATHERINE_LOCATION"] = KLOC_KATHS_APT;
			}
		}
		else if (hours >= 10) {
			//Any time after 10:00 but before 14:00 Kath returns to the bar after encounters, though she will stay at her home if the encounter happened there.
			switch (flags["COC.KATHERINE_LOCATION"]) {
				case KLOC_BAR:
				case KLOC_KATHS_APT: break;
				default: flags["COC.KATHERINE_LOCATION"] = KLOC_BAR;
			}
		}
		
		return;
	}
}

private var KatherineTimePassedNotifyHook: * = KatherineTimePassedNotifyGrapple();
private function KatherineTimePassedNotifyGrapple():* { timeChangeListeners.push(KatherineTimePassedNotify); }

public function kathIsAt(location:int):Boolean { return kathLocation() == location; }

public function kathClothes():void { //Produces a few sentences which describe what Katherine is currently wearing
	output("She wears [kath.armor].");
}

public function kathPlayerText():String
{	//For the simplest case. Will not work properly at the start of sentences.
	if (flags["COC.KBIT_SUB_CALL_MASTER"] != undefined) return("[pc.master]");
	return("[pc.name]");
}

public function kathSubmissiveness():int {
	var subCount:int = 0;
	if (flags["COC.KBIT_SUB_HIGH_CUM"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_BED_BOND"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_ORGASM_DENIAL"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_GROW_KNOT"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_CAT_DICK"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_GROW_BIG_BOOBS"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_GROW_BIG_DICK"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_CAT_GIRL"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_HIGH_LACTATION"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_REM_BALLS"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_GROW_BIG_BALLS"] != undefined) subCount++;
	if (flags["COC.KBIT_SUB_PUBLIC_EXHIBITION"] != undefined) subCount++; //Worth double
	if (flags["COC.KBIT_SUB_REM_COCK"] != undefined) subCount++;
	if (subCount < 4 && flags["COC.KBIT_SUB_START_LACTATION"] != undefined) subCount++;
	return subCount;
}

public function initKathFlags():void
{
	flags["COC.KATHERINE_LOCATION"] = 0;
	flags["COC.KATHERINE_MILK_OPTIONS"] = 0;
	pc.removeKeyItem("Silver Kitty-Bell"); //Silver Bell key item removed so any partial recruitment down the Scylla route is cancelled
}

//Katherine Appearance:
private function katherinesAppearance(clear:Boolean = true):void {
	if (clear) clearOutput();
	//output(images.showImage("katherine-examine-her-appearance"));
	
    if (flags["COC.KATHERINE_UNLOCKED"] < 4) { //Still unemployed
		output("Katherine stands before you, nervously watching as you scrutinize her form.  “<i>Um... do you like what you see?</i>”  Nervously trying to break the ice and amateurishly trying to flaunt her body, she strikes what might be a sexy pose... in her mind.\n\n");
	}
	else if (hours >= 10) { //She’s off duty (on duty doesn’t need intro text)
		//She’s at home (appearance function doesn’t get used at the bar)
		output("Katherine stands before you, beaming with pride.  She moves her fingers across her body, hoping to give you ideas.  “<i>Is there anything you’d like to do?</i>” she purrs.\n\n");
	}

	output("Katherine is a lean-built hermaphroditic cat ");
	if (kath.hasFur()) {
		output("morph, standing maybe 5' 2\" tall.  ");
		if (kath.hairColor == "jet black")
			output("Both her fur and");
		else output("Her fur is black, but");
	}
	else output("girl, standing maybe 5' 2\" tall.  She has a pair of cat ears and a tail, both covered in black fur.  Her skin is milky white and");
	output(" her shoulder-length hair, often worn forward and obscuring one of her leaf-green eyes, " + (kath.hasFur() && kath.hairColor == "jet black" ? "are " : "is "));
	if (!kath.hasFur() && kath.hairColor == "jet black")
		output("just as black as the fur on her ears and tail.\n\n");
	else output(kath.hairColor + ".\n\n");
	
	kathClothes(); //Outputs a full description of the clothes she’s currently wearing
	output("  Before you can even ask she begins to strip off her clothes to give you a better look");
	output(".\n\n");

	output("Two " + kath.breastCup() + " breasts" + (kath.isLactating() ? ", laden with cream," : "") + " sit on her chest" + (kath.milkFullness >= 100 ? ".  Her nipples stand at attention, ready for milking" : ""));
	if (kath.hasCock()) {
		output(", while just below her belly button sits the unmistakable form of an animalistic penis sheath.  Shyly, her " + (kath.cockTotal() == 1 ? "phallus begins " : "phalli begin ") + "to slip from its length; a " + kath.multiCockDescript() + ", " + formatFloat(kath.cocks[0].thickness(), 1) +"\" thick and " + kath.cocks[0].cLength() + "\" long reveal" + (kath.cockTotal() == 1 ? "s itself, with a " : " themselves, with ") + formatFloat(kath.cocks[0].knotMultiplier * kath.cocks[0].thickness(), 0) + "\" thick knot" + (kath.cockTotal() == 1 ? " at its base.  " : "s at their bases.  "));
		if (kath.balls == 0)
			output("Just beneath Kath’s " + (kath.cockTotal() == 1 ? "cock is" : "twin cocks is"));
		else output("A pair of " + formatFloat(kath.ballDiameter(), 1) + "\" wide balls sway below her cock" + (kath.cockTotal() == 1 ? "" : "s") + ", hanging just above");
	}
	else output(" and between her legs rests");
	output(" her wet, eager cunt.\n\n");
    
    if (flags["COC.KATHERINE_UNLOCKED"] < 4) { //Still unemployed
		output("When you're finished looking at her she quickly redresses herself, flaunting her rear at you as if by accident and waiting to see what else you want, reassured by your lack of comments.");
		katherineMenu(); //Display default Katherine options
	}
	else if (hours >= 10) { //She’s at home (appearance function is never called at the bar). If time < 10 then she is on duty. See katherineOnDuty() for end of conversation & menu
		output("Totally naked, tail waving with pleasure, Katherine stretches, giving you a very good show of all her most private parts.  “<i>Like what you see, dearest?</i>” she purrs.\n\n");
		output("Oh yes, you tell her.  The clothes look good on her and what they hid is even better.  “<i>I do like the sound of that,</i>” she replies, “<i>but it is a bit chilly in here.</i>”  Her tail twitches with pent up energy and she slides her hands down her sides, " + (!kath.hasFur() ? "stroking her milky white skin" : "smoothing her shiny fur coat") + " before asking, “<i>Can you think of a way to keep me warm?</i>”\n\n");
		output("She starts to collect her clothes, putting them back on almost as seductively as she removed them.\n\n");
		katherineMenu();
	}
}

//Main menu for Kath while she lives in the alley behind Oswald's
private function katherineMenu():void {
	clearMenu();
	addButton(14, "Leave", telAdreMenu); // failsafe
	//One menu to rule them all (so the code never gets confused about what it should go back to
	if (flags["COC.KATHERINE_UNLOCKED"] < 4) { //Behind Oswald's pawn shop
		//[Sex] [Talk] [Appearance] [Give Item]
		addButton(0, "Sex", katherineSex);
		addButton(1, "Talk", talkToKatherine);
		addButton(2, "Appearance", katherinesAppearance)
		addButton(3, "Give Item", giveKatherineAnItem);
		addButton(14, "Leave", telAdreMenu);
	}
	else if (kathLocation() == KLOC_KATHS_APT) {
		addButton(0, "Appearance", katherinesAppearance);
		addButton(1, "Sex", katherineSex);
		addButton(2, "Give Item", giveKatherineAnItem);
		addButton(3, "Talk", talkToKatherine);
		//addButton(4, "Date", katherineDate);
		//addButton(14, "Leave", katherineApartmentLeave);
	}
	else { // wet bitch
		if(!kath.isPregnant()) addButton(0, "Drink", katherineDrinkUp);
		addButton(1, "Sex", katherineSex);
		addButton(3, "Talk", talkToKatherine);
		addButton(4, "Date", katherineDate);
		addButton(14, "Leave", barTelAdre);
	}
}

//Seeing Katherine
public function visitKatherine():void {
	clearOutput();
	katherineSprite();
	//output(images.showImage("katherine-visit-alley"));
	if (flags["COC.KATHERINE_UNLOCKED"] == 1) {
		if (initiateTraining()) return;
	}
	//If Back Alley button is selected
	output("The back alley behind Oswald's pawnshop is quite unremarkable, except that it's reasonably clean.  A number of empty crates, old blankets and torn strips of cloth have been assembled into a makeshift “<i>nest</i>”, the kind of place that a homeless vagrant would use as a resting place.\n\n");
	katherineVisitNormal();
}

public function katherineVisitNormal(checkTraining:Boolean = true):void
{
	trace("Kath location: " + kathLocation(false));
	flags["COC.KATHERINE_LOCATION"] = kathLocation(false); // to ensure current location is set right
	output("Katherine the cat is currently ");
	switch (rand(5)) {
		case  0: output("sitting in a corner"); break;
		case  1: output("pacing back and forth"); break;
		case  2: output("sipping furtively at a bottle of milk"); break;
		case  3: output("yawning and stretching"); break;
		default: output("waking up from a cat-nap");
	}
	
	if (flags["COC.KATHERINE_UNLOCKED"] == 1) { //Regular menu
		output(", and she smiles when she sees you.  “<i>[pc.name]!  Did you come to see me?</i>”");
		if (checkTraining && flags["COC.KATHERINE_TRAINING"] > 2) { //You have talked to at least one of Edryn, Urta or the desk sargeant
			talkToKath();
			return;
		}
		katherineMenu();
	}
	else { //You are training her alone
		output(".\n\n");
		if (flags["COC.KATHERINE_TRAINING"] >= 100)
			katherineTrainingComplete();
		else if (flags["COC.KATHERINE_TRAINING"] >= 66)
			katherineTrainingStage3();
		else if (flags["COC.KATHERINE_TRAINING"] >= 33)
			katherineTrainingStage2();
		else katherineTrainingStage1(false);
	}
}

//Sex
public function katherineSex():void {
	clearOutput();
	//if (getGame().urta.drainedByKath) {
			//output("There are certainly a few things you can think to do with your horny kitten, especially after that display, so you lead her toward the rear exit.  Katherine paws at your belt, but you keep her under control until you're both out of sight of the other patrons.  You give Kath a quick kiss and realize you have only a moment to decide what you want to do with her before she takes matters into her own hands.");
	//}
	//else 
	if (kathIsAt(KLOC_BAR)) {
		output("You ask Kath if she’s in the mood to have a little fun.\n\n");
		output("“<i>What ever could you mean by that " + kathPlayerText() + "?</i>” she asks playfully.\n\n");
		output("You point out that there’s an alleyway behind the bar.  If she needed a refresher course on catching miscreants you could give her a hand." + (flags["COC.KATHERINE_URTA_AFFECTION"] > 10 ? "  You glance over at Urta’s table and add that maybe you could go and talk to captain Urta about improper procedures." : "") + "\n\n");
	}
	else {
		output("You ask Katherine if she's in the mood to have sex.\n\n");
		output("The cat herm is visibly startled by your directness, then rallies and gives you an ear-to-ear grin.  “<i>Mmm...  am I ever...  Any particular preference?</i>” she asks, swishing her tail languidly from side to side.");
	}
	katSexMenu();
}

private function katSexMenu():void {
	katherineSprite(true);
	
	addButton(14, "Back", katherineMenu);
	addDisabledButton(0, "Penetration", "Penetration", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(1, "GetPenetrated", "Get Penetrated", "This scene requires Kath to have cock and you to have sufficient arousal.");
	addDisabledButton(2, "DoubleHelix", "Double Helix", "This scene requires both you and Kath to be herms and you to have sufficient arousal.");
	addDisabledButton(5, "Suckle", "Suckle", "This scene requires either you or Kath to lactate.");
	
	if (pc.lust() >= 33) { //No penetration or helix if you’re at low lust
		if (pc.hasCock()) {
			if (pc.cockThatFits(kath.vaginalCapacity()) >= 0) addButton(0, "Penetration", katPenetrate);
		}
		if (kath.hasCock()) {
			addButton(1, "GetPenetrated", letKatKnotYou);
			if (pc.hasCock() && pc.hasVagina() && pc.cockThatFits(kath.vaginalCapacity()) >= 0)
				addButton(2, "DoubleHelix", katDoubleHelixCraziness);
		}
	}
	
	if (pc.lactationQ() > 250 && pc.biggestTitSize() >= 1) {
		if (kath.lactationQ() > 250) addButton(5, "Suckle", suckleMenu, undefined, "Suckle", "Both of you can have some extra weight in your chests...");
		else addButton(5, "Suckle", suckleTacularKats, undefined, "Suckle", "Let her help you relieve some weight from you chest.");
	}
	else if (kath.lactationQ() > 250) addButton(5, "Suckle", suckleFromKath, undefined, "Suckle", "Help her relieve some weight from her chest.");
	
	addButton(3, "Oral", oralKatherineChoices);
	addButton(4, "Handjob", handjobbiesFurrDemCatFurries, undefined, "Handjob", "Give her a hand!");
	addButton(6, "To the Lake", dateKathBath);
	
	if (kathIsAt(KLOC_KATHS_APT)) {
		addDisabledButton(6, "Bed Bondage", "Bed Bondage", "You should have 40 gems to buy some extra equipment for this scene.");
		if (flags["COC.KBIT_SUB_BED_BOND"] != undefined || pc.credits >= 400) addButton(6, "Bed Bondage", bedroomBondage);
	}
	else { //Not yet employed or at the bar. Kath can't be on duty, since there's a special sex menu for on duty encounters
		if (kathIsAt(KLOC_BAR)) { //Check to see if her partners are comfortable fucking her sober
			if (flags["COC.KATHERINE_URTA_AFFECTION"] > 10 && urtaAtBar() && urtaAvailableForSex()) {
				addButton(3, "See Urta", katherineSeeUrta);
			}
			if (flags["COC.KATHERINE_VALA_AFFECTION"] > 10 && isValaAtBar()) {
				addButton(4, "See Vala", katherineSeeVala);
			}
		}
		else if (kathIsAt(KLOC_BAR_DRUNK)) {
			addDisabledButton(5, "Suckle", "Suckle", "This scene requires either you or Kath to lactate."); //If she's drunk she wants sex, not suckling
			if (urtaAtBar() && urtaAvailableForSex() && flags["COC.URTA_TIME_SINCE_LAST_CAME"] < timeAsStamp) {
				addButton(3, "See Urta", katherineDrunkSeeUrta); //Different conversation if Kath is sloshed
			}
			if (isValaAtBar() && flags["COC.URTA_TIME_SINCE_LAST_CAME"] < timeAsStamp)
				addButton(4, "See Vala", katherineSeeVala);
			addDisabledButton(14, "Back"); //Kath won't take no for an answer if she's sauced
		}
		else if (kathIsAt(KLOC_BAR_URTA_REFUSED)) {
			if (isValaAtBar()) addButton(4, "See Vala", katherineSeeVala);
			addDisabledButton(14, "Back"); //Kath won't take no for an answer if she's sauced
		}
	}
}

//Penetrate
private function katPenetrate():void {
	clearOutput();
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		output("You take her hand and lead her outside, to " + (flags["COC.TIMES_FUCKED_URTA"] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		output("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
		flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS;
	}
	output("You suggest that maybe you could try penetrating one of Katherine's holes.  Without further ado, she strips herself off until she's wearing nothing but a lecherous grin.  She then turns around and " + (kathIsAt(KLOC_KATHS_APT) ? "perches on the edge of her bed" : "leans on a crate") + ", waving her tail to freely show off both her tailhole and her already-dripping cunt" + (kath.hasBalls() ? " above her dangling balls" : "") + ".  “<i>So, come on in,</i>” she purrs.\n\n");
	
	clearMenu();
	addDisabledButton(1, "Anus", "Anus", "This scene requires you to have fitting cock.");
	addDisabledButton(2, "Both", "Both", "This scene requires you to have second fitting cock.");
	addDisabledButton(3, "SucknFuck", "SucknFuck", "This scene requires her to have cock with not overly large knot.");
	
	addButton(0, "Vagina", penetrateKatsVag);
	if (pc.cockThatFits(kath.analCapacity()) != -1) addButton(1, "Anus", pcPenetratesKatAnally);
	if (pc.cockThatFits2(kath.analCapacity()) != -1) addButton(2, "Both", pcPenetratesKatDoubly);
	if(kath.hasCock() && (kath.cocks[0].knotMultiplier * kath.cocks[0].thickness() < 4)) addButton(3, "SucknFuck", suckNFuck);
	addButton(14, "Back", katSexMenu);
}

//PC Penetrates Kath: Vaginal (doin' a cat doggy-style)
public function penetrateKatsVag():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	var x:Number = pc.cockThatFits(kath.vaginalCapacity());
	clearOutput();
	//output(images.showImage("katherine-fuck-her-vagoo"));
	output("You don't even need to think about it.  Your eyes are locked on the cat-herm's silken, sopping wet pussycat pussy, which is already dribbling femlube down her ");
	output((kath.hasBalls() ? " [kath.balls]" : (!kath.hasFur() ? "milky white" : "black, furry") + " thighs") + " and puddling it onto the ground in anticipation.  Slipping off your garments, you saunter forward and gently stroke her damp lips, stage-whispering to her that it seems an obvious choice which hole you should take.  Katherine gives a playful giggle, a mewl of arousal, and ");
	if (kathIsAt(KLOC_STREETS))
		output("positions herself over a nearby barrel");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("kneels at the edge of her bed");
	else //At the lake
		output("gets down on all fours");
	output(" so that it's easier for her to support the two of you.\n\n");

	output("As soon as she's ready, you waste no time in sliding your [pc.cock " + x + "] home, causing her to yowl in delight at being filled.");
	pc.cockChange();
	output("  Her slippery walls, soft and slick like greased velvet, seem to ripple as if to purposefully swallow your cock, eager to have you bury yourself to the hilt.  Sopping wet as they are they pose no resistance, allowing you to glide in smooth as butter, yet they grip you and try in vain to hold you in.  Your thrusts and surges elicit the lewdest squelches and slurps, her slobbering cunny drooling all over your shaft and ");
	if (pc.balls > 0)
		output((kath.hasBalls() ? "both sets of " : "") + "balls");
	else output((kath.hasBalls() ? "her balls" : "her thighs"));
	output(".\n\n");

	output("“<i>Oh, yeah!  Yes - AH!  It feels so good!</i>” Katherine yowls mindlessly, babbling in her delight at your penetrations.  You, for your part, just grab her " + (!kath.hasFur() ? "supple skin" : "silken fur") + ", hold onto her narrow hips and keep on thrusting.  While you may have started out firmly in charge, as the pace picks up the cat-herm is the one to take the lead; she pushes back against you, bucking and thrashing so wildly you find yourself having to hang on for dear life as she fucks you senseless.  If it weren't for how wet she is, she'd be rubbing your cock raw from friction and the vice-like grip around your shaft.  " + (kath.hasCock() ? "You can just make out the way her cock" + (kath.cockTotal() == 1 ? " flails" : "s flail") + " around, stiff as iron with knot" + (kath.cockTotal() == 1 ? "" : "s") + " swollen to full size - she" : "She") + " can't be much further from climax...\n\n");

	output("And, indeed, she's not.  Arching her back in a way that would break a human spine, she lets out an ear splitting scream of ecstasy, making you unconsciously recall nights of being woken up by courting cats back in Ingnam.  " + (kath.hasCock() ? "Cum gushes like a river from her cock" + kath.CockMultiple("", "s") + " and her" : "Her") + " cunny floods over with femspray, splattering you and soaking " + (kath.hasCock() ? "the ground and" : "") + " everything from your waist down.  As if signalled by her orgasm, your own climax seizes you by surprise.  ");
	if (pc.hasVagina()) output("Your [pc.vagina] releases its own girl-cum in sympathy, even as y");
	else output("Y");
	output("our cock discharges into her depths, flooding her inviting nethers with your spunk, her pussy-lips drinking every last drop you have to give with insatiable greed.");
	if (pc.cumQ() >= 1500) output("  Her belly puffs up and out, swelling like an advancing pregnancy, until finally you have finished, leaving her with a barrel-sized balloon of a gut, cum audibly sloshing inside her as her motions churn the liquid.");
	output("  Gasping, having spent yourself, you pull out, letting her nethers drool their sexual fluids onto the ground undisturbed.\n\nKatherine ");
	if (kathIsAt(KLOC_STREETS))
		output("sprawls against the barrel");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("sprawls across her bed");
	else //At the lake
		output("collapses onto the soft grass");
	output(", flicking her tail lazily and purring loudly.  “<i>Mmm... you have no idea how good you are, lover,</i>” she tells you, before patting her belly and giggling softly.  “<i>I'm not saying I want to be a mom just yet");
	if (pc.cumQ() >= 1500) output(" - though, honestly, you may not give me much of a choice - ");
	output(" but I think your little boys and girls and herms will make people very, very happy when they come of age.</i>”\n\n");

	output("With a smile, you scratch her behind the ears in a way that the cats in your village loved, enjoy her contented purr, clean yourself ");
	if (kathIsAt(KLOC_STREETS))
		output("off with some old rags that the cat laid aside, and then politely say goodbye, redressing yourself and heading back out into Tel'Adre.");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("off in Kath’s washbasin, and then politely say goodbye, redressing yourself and heading back out into Tel'Adre.");
	else { //At the lake
		output("and Kath off with some lake water and a towel Kath brought.  You would like to stay longer and enjoy the view but it’s much safer to head back to Tel’Adre before something investigates all the noise you two just made.");
		if (pc.cumQ() >= 1500) output("\n\nOn the journey back to the city both you and Kath rub her cum bloated belly, leaving a trail of juices that stretch from the shores of the lake to the edge of the desert.");
		processTime(10 + rand(10));
	}
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(25);
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//PC Penetrates Kath: Anal
public function pcPenetratesKatAnally():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	var x:Number = pc.cockThatFits(kath.analCapacity());
	clearOutput();
	//output(images.showImage("katherine-fuck-her-bungholio"));
	output("Thinking it over, your gaze falls upon the cat's " + (!kath.hasFur() ? "inviting" : "ebony") + " pucker, and you smile to yourself before telling Katherine that you want a shot at her back door.  ");
	if (flags["COC.KBIT_TRIED_RECEIVE_ANAL"] != undefined)
		output("Kath smirks and her tail raises a little.  “<i>Mmmm... it is kind of fun.  Naughty too.</i>”");
	else output("Her eyes widen and she swallows hard, then she nods.  “<i>O-Okay... if you're into that sort of thing...</i>”");

	output("\n\nShe turns her head back and around and repositions herself so that ");
	if (kathIsAt(KLOC_STREETS))
		output("she's properly supporting herself on the crate, timidly waiting");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("her hips are pressed firmly against the side of her bed frame and she timidly waits");
	else //At the lake
		output("her head is pressed against the grass and her ass and tail are raised high in the air. She looks back at you, timidly waiting");
	output(" for your approach.  Confidently you saunter up behind her, taking the opportunity to appraise your partner.  It's true that she's nothing to write home about in terms of ass size or perkiness, but her lean butt is solidly muscled and covered ");
	if (flags["COC.KATHERINE_UNLOCKED"] < 4)
		output("in surprisingly luxurious-looking fur considering her probably-irregular diet");
	else output(kath.catGirl("with inviting pale flesh", "in luxurious-looking fur"));
	output(", and you take this opportunity to run your hands appreciatively " + kath.catGirl("over that smooth bottom", "through the soft hair") + ".  She coos and wriggles in delight, drawing your attention back to the matter at hand.  Katherine's vagina is already drooling in anticipation, despite her nervousness, and it's a simple matter for you to expose yourself and gather up some of her juices in the palm of your hand.  You painstakingly rub the juices into your [pc.cock " + x + "], bringing it to full mast even as you get it nice and slick.  Then, you start massaging what's left of your handful of girl-lube into Katherine's tight asshole, making her squeak and moan as you get her wet.  Finally, you ask if she's ready.\n\n");

	output("“<i>I-I am!</i>” she insists, visibly trying to relax.  “<i>Just... j-jam it in!</i>”\n\n");

	output("No further encouragement needed, you press forward and begin sinking yourself into her tight" + kath.catGirl("", " black") + " tailhole.  She moans like a virgin, her " + (kath.hasCock() ? kath.cockAdj() + kath.cockType(" dog-cock", " kitty-cock") + kath.CockMultiple("", "s") + " visibly jolting and her " : "") + "empty kitty-cunt clenching in sympathy as you slide yourself in.  Her anal walls lock around you like a vice of heated silk, gripping you and squeezing as if already trying to wring every last drop of cum out of you.  But you forge on, sliding inch after inch into her bowels until you can slide no more.");
	pc.cockChange();
	output("  Then, slowly, you try to extract yourself - fighting every inch of the way, as her virgin-tight ass tries to suck you back.  Finally drawing out most of what you put inside, you slide yourself home again, slamming harder and faster into her hips, then pulling out, repeating this over and over.\n\n");

	output((kath.hasCock() ? "Your kitty" : "The herm cat") + " gasps and moans, thrusting her sparsely-fleshed ass back to try and meet your hips as you continue to push, her inner walls milking and squeezing.  “<i>Ah!  Do you - oh! - know what the - yeah, yeah, fuck me like that, fuck me there! - advantage of a " + (kath.hasCock() ? "herm - yesyesyes! - girlfriend" : "- yesyesyes! - girlfriend who was a herm") + " is, " + kathPlayerText() + "?</i>” she manages to gasp out.\n\n");

	output("You grunt and hiss as you abuse her insides, but manage to spare the breath to admit you don't.\n\n");

	output("“<i>The advantage is - oh! ah! - " + (kath.hasCock() ? "I've got both sets of bits, so - ah! ah! AH! - it's good for me, like it'd be good for a guy" : "I had the same bits, so - ah! ah! AH! - I know exactly what you like") + "!</i>”  She lets out an excited yowl of bliss as you thrust particularly hard.  “<i>Ohh... ");
	if (kath.hasCock())
		output("You're squeezing my prostate, rubbing all the parts in my ass that make my cock" + kath.CockMultiple("", "s") + " jump, it's so good back there... so hard, so hot!  Fuck me, fuck me like an animal!</i>” she screams, starting to jerk her own hips, knot-swollen cock" + kath.CockMultiple("", "s") + " spewing pre-cum as she mock-humps");
	else output("it's so good back there... so hard, so hot!  Fuck me, fuck me like an animal!</i>” she screams, starting to jerk her hips, mock-humping");
	output(" the air.  She's gonna blow any second now...\n\n");
	output("But you beat her to the punch and, with a howl of your own, you cum inside her, flooding her bowels with your spunk");
	if (pc.cumQ() >= 500) output(" until her belly begins to bulge from all you've dumped in her");
	if (pc.cumQ() >= 1500) output(", swelling out and out until she looks like she could give birth soon and a part of you wonders if maybe she's going to start spouting your cum from her mouth");
	output(".  In the midst of your orgasm, her own yowling cry goes unnoticed as her cunt spasms, ");
	if (kathIsAt(KLOC_STREETS))
		output("raining femcum down onto the ground below" + (kath.hasCock() ? " and her " +kath.CockMultiple("cock sprays", "cocks spray") + " cum all along the crate and ground" : ""));
	else if (kathIsAt(KLOC_KATHS_APT))
		output("the rain of femcum " + (kath.hasCock() ? "mixing with the sprays of semen from her cock" + kath.CockMultiple("", "s") + ", soaking her belly," : "soaking her") + " sheets and bed");
	else //At the lake
		output("raining femcum down onto the ground below" + (kath.hasCock() ? " and her " + kath.CockMultiple("cock sprays", "cocks spray") + " cum all over the grass" : "") + ".  It gathers into a slow moving stream that flows to the shore and mixes with the already polluted waters of the lake");
	output(".  Finally, you are spent, and pull yourself wetly from your gasping lover's ass.\n\n");

	output("She slinks bonelessly to the ground, still quivering from the afterglow, then smiles dreamily up at you");
	if (pc.cumQ() >= 1500) output(", absently cradling her distended belly");
	output(".  “<i>What a fuck... can't say I don't prefer it in my pussy, but I'll always be up for " + (flags["COC.KBIT_TRIED_RECEIVE_ANAL"] != undefined ? "more of that" : "another go") + " if you want.</i>”");
	if (pc.cumQ() >= 1500) output("  She looks at her gut and shakes her head in disbelief.  “<i>Sheesh... if they ever figure out a way to let folks get pregnant by taking it up the ass, you're gonna knock up every damn person you meet, aren't you, stud?</i>”");

	output("\n\nWith a smirk at her flattery, ");
	if (kathIsAt(KLOC_STREETS))
		output("you give her a hand getting dressed, then dress yourself and head back out into the street.");
	else if (kathIsAt(KLOC_KATHS_APT)) {
		if (pc.cor() < 25)
			output("you roll Kath off her cum soaked bed and change the sheets for her while she cleans herself up.  When you’re done you give Kath a long kiss and tell her you hope to see her soon.  She beams with happiness as you leave.");
		else if (pc.cor() < 75)
			output("you give Kath a kiss and tell her you hope to see her soon.  She moans as she stretches and pulls herself to her feet.  She’s got quite the cleanup ahead of her.");
        else
			output("you tell Kath that you want her to lick up all that " + (kath.hasCock() ? "" : "fem") + "cum she just sprayed.  You’ve heard it’s good for keeping her " + kath.catGirl("her skin soft and smooth", "fur nice and shiny") + ".  She looks unsure, but starts licking the sheets.  You rub the back of her neck to encourage her and soon Katherine is lapping away at her own juices.  Leaving Kath to her meal, you walk back out onto the streets of Tel’Adre.");
	}
	else { //At the lake
		output("you help Katherine to her feet and collect all your things.  You have a long walk back to Tel’Adre waiting for you");
		if (pc.cumQ() >= 1500) output(" and it will be even longer for Katherine thanks to her sperm stuffed colon.  Still, judging how Kath holds you tight on the trip back to Tel’Adre you don’t think she’d have it any other way");
		output(".");
		processTime(10 + rand(10));
	}
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(25);
	kath.loadInAss(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_RECEIVE_ANAL"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

public function pcPenetratesKatDoubly():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	clearOutput();
	var x:Number = pc.cockThatFits(kath.analCapacity());
	var y:Number = pc.cockThatFits2(kath.vaginalCapacity());
	output("You unfasten your [pc.gear], exposing [pc.eachCock]");
	if (kathIsAt(KLOC_KATHS_APT))
		output(".  You toss your clothes on the floor and lift an eager Katherine onto her bed");
	else {
		if (hours < 12)
			output("to the morning breeze");
		else if (hours < 18)
			output("to the warm afternoon air");
		else
			output("to the cool evening air");
		if (kathIsAt(KLOC_LAKE)) output("of the lakeshore");
	}
	output(".  While stroking Kath’s " + kath.catGirl("soft skin", "fur") + " you tell her that she has two delectable holes and you want to fill them both.\n\n");

	output("Her eyes open wide but so do her thighs.  " + (kath.hasCock() ? "Her cock" + kath.CockMultiple(" strains", "s strain") + " against her clothes.  You" : "You tease her by rubbing them gently, then you") + " pull the clothes off your horny kitty and tell her you want her down on all fours.  Kath eagerly complies, kneeling ");
	if (kathIsAt(KLOC_STREETS))
		output("in the soft dirt of the alley");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("on top of her bed");
	else //At the lake
		output("in the sand at the water’s edge");
	output(" and presenting her pussy and ass.\n\n");
	
	output("You start by stroking Katherine’s tail.  It swishes back and forth, seeming more excited than the rest of her.  When you probe her hot little pussy you find it dripping wet.  You slide your uppermost dick between Kath’s thighs, coating it with the copious supply of lube.\n\n");

	output("Kath’s hands ");
	if (kathIsAt(KLOC_STREETS))
		output("dig into the dirt and s");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("tighten, bunching up her sheets. S");
	else //At the lake
		output("dig into the sand and s");
	output("he lets out a low, feral meow.  Taking that as your cue you raise your hips slightly and press your slick cockhead against her pucker. " + (pc.cocks.length == 2 ? "Your lower cock" : "One of your other cocks") + " nestles between the pink folds of her pussy.\n\n");

	output("As soon as Kath feels both cocks seating against their targets she tries to push back.  You’re having none of it though.  You tighten your hands on her " + kath.catGirl("smooth", "fuzzy") + " hips, stopping her and making it clear this fucking is going to happen at your pace.  Kath’s head sinks until her forehead rests on her balled up hands and she mewls plaintively, like a kitten begging for cream.\n\n");

	output("Your " + (pc.balls > 0 ? "balls twitch" : "prostate twitches") + ", letting you know there’s plenty of cream for this sex kitten.\n\n");

	output("You ");
	if (pc.cor() < 25) {
		output("fight against your base urges and work to make sure Katherine enjoys this completely.  Ever so slowly you slide both your cocks into her waiting holes.");
		pc.cockChange();
		output("  You shift your hips so the cock in her pussy is pressed hard against her clit.\n\n");

		output("Then, with tiny strokes - each only a little deeper than the last, you gently pry open Kath’s most sensitive parts.  As you do her mewling continues and you feel her whole body getting warmer.  You begin to increase the pace, never quite fast enough for Katherine’s liking, though you know that thanks to the slow speed she’s enjoying it immensely.");
	}
	else if (pc.cor() < 75) {
		output("press against Kath until both cockheads are inside her.");
		pc.cockChange();
		output("  You stop, enjoying the feeling of being inside your lover twice over.  Then, in one slow continuous stroke you force both cocks in until they’re buried to the root.\n\n");

		output("Kath tries to make you go faster, both by trying to push her hips back and by whispering “<i>Yes, yes. More!</i>”  After the first stroke you’re willing to accommodate her.  You begin to increase the pace until you’re pistoning into Katherine’s moist holes.  Her loud mewls and screams of “<i>Yes!</i>” are testament to how much she’s enjoying this.");
	}
	else {
		output("make sure your grip is solid and your rock hard cocks are lined up perfectly.  Then you yank back on Kath while thrusting forward.");
		pc.cockChange();
		output("  A piercing yelp fills the air, bringing a smile to your lips.  You want this to be a fucking Kath will remember.\n\n");

		output("You don’t give your feline fucktoy a chance to recover or adjust.  If she wants to present both her holes to you then you are going to fuck her twice as hard!  At first she tries to pull away, then she tries to slow you down.  You ignore it all, jackhammering into her most sensitive parts at the pace you desire.  After countless strokes you hear a long moan and you know Kath is finally into it.");
	}

	output("\n\nYou’re about to " + (kath.hasCock() ? "reach down and give Kath’s cock" + kath.CockMultiple("", "s") : "give Kath's nipples") + " some attention when you feel her tense and hear a squirting noise.  Looks like she managed to cum before you did.  ");
	if (kath.hasCock())
		output("Against your uppermost cock you can feel the pounding of Kath’s prostate as " + (kath.hasBalls() ? "she empties her balls" : "it forces out her load"));
	else output("Both Kath's holes attempt to crush your cocks, her inner folds pulsing and squeezing in a very pleasant way");
	output(".  Katherine’s body goes limp and only your hands on her hips and your cocks inside keep her ass in the air.\n\n");

	if (kath.hasCock()) {
		if (kathIsAt(KLOC_STREETS))
			output("The dirt beneath her is already turning into a sticky mud puddle");
		else if (kathIsAt(KLOC_KATHS_APT))
			output("The bed sheets are soaked" + (kath.cumQ() > 1500 ? ".  In fact Kath’s cum is pooling on the floor too," : ""));
		else //At the lake
			output("A good amount of gritty semen slides down the beach and into the lake");
		output(" so there’s no sense in stopping now.  In fact you hope you can " + (pc.cor() < 50 ? "encourage" : "force") + " your " + kath.catGirl("pet cat girl", "feline friend") + " to add another helping to the mess.\n\n");
	}

	output("You continue to pound your cocks into Katherine’s slack body.  The only reason you know she’s still conscious is the soft purring that vibrates through her whole body.  You feel it in your hands and, more acutely through your cocks and that gives you an idea.\n\n");

	output("You thrust and thrust until you’re right on the edge of cumming.  Then you jamb both cocks deep inside Kath.  The resonance of her purring makes it feel like your cocks are rubbing against one another inside her.\n\n");

	var wombShot:Boolean = pc.cocks[x].cLength() > 14 && !kath.isPregnant(); //Only available if you’re huge and she doesn’t have a bun in the oven
	if (wombShot) {
		var cockLength:int = Math.round(pc.cocks[x].cLength());
		output("You feel something amazing.  Inside Kath’s pussy there’s a tightness right at the tip of your cock.  It’s like a tiny donut is sliding over your cock head.  Then it gives way.  You hear a sharp intake of breath as your cock springs forward.  You realize " + (cockLength <= 16 ? "your cockhead is" : "the first " + (cockLength - 14) + " inches of your cock are") + " now nestled inside Katherine’s womb.\n\n");
	}

	output("The sensation overcomes you and your " + (pc.balls > 0 ? "balls pull tight against your groin" : "engorged prostate squeezes") + " firing the first of many salvos into Katherine’s limp body.\n\n");

	output("You fire your load into both Kath’s holes");
	if (pc.cocks.length > 2) output(" while at the same time your other cock" + (pc.cocks.length > 3 ? "s " : " ") + (kath.hasCock() ? (pc.cocks.length > 3 ? "add" : "adds") + " to the" : "create a") + " mess beneath her");
	if (pc.cumQ() < 500)
		output(".  The eruption is soon over, and with no outward signs.  Only your cocks, deep inside Kath’s " + (wombShot ? "womb" : "pussy") + " and colon can feel the pools of your sticky deposits.");
	else if (pc.cumQ() < 1500)
		output(".  The eruption is soon over, and Kath’s belly bulges from your twin deposits.  Your cocks, deep inside Kath’s " + (wombShot ? "womb" : "pussy") + " and colon can feel the pools of hot, sticky liquid.  They’re under pressure, but still sealed in by your erections.");
	else {
		output(".  Again and again your " + (pc.balls > 0 ? "balls contract" : "prostate contracts") + ", fighting ever greater resistance as every void inside Kath is packed with your juices.  You no longer have to support Katherine’s hips - her cum stuffed belly rests against the ");
		if (kathIsAt(KLOC_STREETS))
			output((kath.hasCock() ? "spermy" : "femcum soaked") + " mud");
		else if (kathIsAt(KLOC_KATHS_APT))
			output((kath.hasCock() ? "" : "fem") + "cum soaked sheets");
		else //At the lake
			output((kath.hasCock() ? "spermy" : "femcum soaked") + " sand of the beach");
		output(".  Anyone would take her to be pregnant, days from delivering twins or triplets.\n\n");

		if (pc.cumQ() >= 3000) {
			output("Even your iron erections are unable to hold back the flood from your unnaturally bountiful " + (pc.balls > 0 ? "balls" : "prostate") + ". Kath’s skin is so taut " + kath.catGirl("you can see stretch marks developing", "that her belly fur begins to lighten.  Looking closely you can see that each hair is being forced to stand on end") + ".\n\n");

			output("Then you feel the first trickles running back along your cocks.  Your " + (pc.balls > 0 ? "balls pump" : "prostate pumps") + " again and the trickle becomes a torrent.  You now have to hold on to Kath’s hips just so she doesn’t launch off of you.\n\n");
		}

		processTime(25);
		output("Finally the torrent stops and ");
		if (wombShot) {
			if (flags["COC.KBIT_SUB_HIGH_CUM"] == 1) { //Repeats of this scene are allowed regardless of corruption
				output("you recall there's a fun way to ‘help’ her.");
				clearMenu();
				addButton(0, "Squeeze", pcPenetratesKatDoublyHighCumCorrupt);
				addButton(1, "Cuddle", pcPenetratesKatDoublyNormalEnd);
				return;
			}
			if (pc.cor() >= 75 || !pc.isNice()) { //First time you have to be corrupt
				output("your perverse mind comes up with a way to ‘help’ her.");
				clearMenu();
				addButton(0, "Help", pcPenetratesKatDoublyHighCumCorrupt);
				addButton(1, "Cuddle", pcPenetratesKatDoublyNormalEnd);
				return;
			}
		}
		if (pc.cor() >= 25)
			output("you rub Kath’s back until she lets out a less than lady like burp.");
		else
			output("you gently massage Kath’s sides until her belly gurgles and she lets out a small belch.");
	}
	clearMenu();
	addButton(0, "Next", pcPenetratesKatDoublyNormalEnd); //If, for any reason, you don't qualify for the high cum corrupt ending then jump to this ending automatically
}

private function pcPenetratesKatDoublyNormalEnd():void {
	clearOutput();
	output("You’re not done with Kath yet.  With some effort you pull her up until she’s sitting on your lap" + (pc.cumQ() >= 1500 ? ", her belly wobbling obscenely in front of you both" : "") + ". When you " + (kath.hasCock() ? "take hold of " + kath.CockMultiple("her flaccid cock", "both her flaccid cocks") : "firmly grip her clit") + " it snaps her out of her reverie.\n\n");

	output("“<i>Oh, that was so good,</i>” she says dreamily.  “<i>We have to do that again sometime.</i>”\n\n");

	output("You begin to work her " + (kath.hasCock() ? "softening shaft" + kath.CockMultiple("", "s") : "nub back and forth") + " and Kath squirms.  “<i>No, I didn’t mean now.  " + (kath.hasCock() ? "I’m empty!" : "I just came!") + "</i>”\n\n");

	output("You keep " + (kath.hasCock() ? "stroking her cock" + kath.CockMultiple(",", "s,") : "playing with her clit, rolling it around ") + " faster and faster.  Kath pants and moans but she's too tired to get away.  " + (kath.hasCock() ? "Her prick" + kath.CockMultiple(" grows", "s grow") + " hard and hot in your hands" : "You feel the heat developing within her pussy and her ass") + ".\n\n");

	output("It takes many minutes of furious stroking to build Kath back to a point where she can cum.  All the while she writhes in your arms, lost in a mixture pain and pleasure.  When she does finally cum her hips thrust forward, " + (kath.hasCock() ? "trying to bury her cock" + kath.CockMultiple(" in an imaginary pussy", "s in a pair of imaginary pussies") + " but succeeding only in " : "") + "pulling her free of your cocks.\n\n");

	output("Kath lands in the puddle of " + (kath.hasCock() ? "spooge" : "fluids") + " and begins to add to it" + (kath.hasCock() ? " in almost every way possible.  Her cock" + kath.CockMultiple(" blasts a stream", "s blast twin streams") + " into the air while" : ",") + " her pussy and pucker discharg" + (kath.hasCock() ? "e" : "ing") + " the loads you provided earlier.\n\n");

	if (kathIsAt(KLOC_STREETS))
		output("Completely spent, Kath falls to the muddy ground with a massive wet splat.  You give her a little pat on the head and promise you’ll see her soon.  All you get in reply is a contented murmur.");
	else if (kathIsAt(KLOC_KATHS_APT))
		output("Completely spent, Kath collapses back onto the bed with a massive wet splat.  You give her a little pat on the head and promise you’ll see her soon.  All you get in reply is a contented murmur followed by some snoring.");
	else {	//At the lake
		output("When she recovers Kath washes herself off in a nearby stream and then the two of you begin the long march back to Tel’Adre.  When you reach the gates you put your arms around Kath, give her a long kiss and promise you’ll see her soon.");
		processTime(10 + rand(10));
	}
	processTime(10);
	kath.loadInAss(pc);
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function pcPenetratesKatDoublyHighCumCorrupt():void {
	clearOutput();
	var firstTime:Boolean = flags["COC.KBIT_SUB_HIGH_CUM"] == undefined;
	if (firstTime) {
		output("You grip her belly and squeeze hard, increasing the pressure even as Kath’s uncoordinated limbs flop around, trying to find some escape.  Kath wheezes in pain as you force the air from her lungs.\n\n");

		output("You enjoy her discomfort so much that your cocks stay hard, plugging the holes she’s desperate to open.  When you force your hands even deeper into her flesh, kneading her overfilled belly, you finally feel something give way.\n\n");

		output("The pressure in her gut lessens and you hear Kath cough wetly.  You laugh and give her a good slap on the ass as she coughs up several more mouthfuls of your seed.\n\n");

		output("Kath takes a few shallow breaths before angrily saying, “<i>I can’t believe you just did that.</i>”\n\n");

		output("You rub her sides and tell her that you know how much she loves the taste of your cum.  This way she doesn’t have to wait.\n\n");

		output("“<i>I... I don’t like the taste that much.  I like to suck your cock because it pleases you.</i>”\n\n");

		output("You tell her that this did please you and you hope she can please you like this again.  As you continue to rub her sides you tell her this is the best feeling for you.  The idea that you’ve filled her, end to end.  The feeling of being inside her - the hot, sticky full feeling, is so good you almost want to cum again.\n\n");

		output("“<i>Oh please don’t!  I couldn’t take it.</i>”\n\n");

		output("She doesn’t sound as pissed off as she did before.  You smile to yourself and begin tracing your fingers seductively " + kath.catGirl("over her silky skin", "through her soft fur") + ".  Time to heap on some more praise.  You tell her you’ve never felt as satisfied as you do right now.  The sight of her cum filled form makes you want her all the more.  You press against her belly once again; Kath lowers her head and takes shallow breaths while she waits for you to finish.");
		flags["COC.KBIT_SUB_HIGH_CUM"] = 1;
	}
	else { //Repeat business
		output("You grip her belly and squeeze, ratcheting up the pressure that you know will overcome the involuntary resistance of her innards.  Kath mewls in a mixture of pain and pleasure, wiggling her hips and inadvertently keeping your cocks hard.  When you force your hands even deeper into her flesh, kneading her overfilled belly, you feel the familiar sensation of her inner sphincter giving way.\n\n");

		output("The pressure in her gut lessens.  Looking over Kath’s shoulder you can see her drooling thick ropes of your [pc.cum] onto the " + (kathIsAt(KLOC_KATHS_APT) ? "bed" : "ground") + ".  She smacks the ground with her fist a few times and you ease up, giving her a chance to recover.\n\n");

		output("Kath sucks in a lungful of air and you squeeze her once more.  Already weakened, her innards give way more easily and once again your cum bubbles out of her throat.  You repeat this a few more times, allowing her to breathe then forcing more of your sperm through her digestive tract in the wrong direction.\n\n");

		output("You only stop when your cocks soften enough that the load in her womb starts to leak out, relieving the pressure.  Kath coughs to clear her throat and you tell her she did well, she let you fill her whole body with cum like a good girl.  After catching her breath Kath replies, “<i>I’m glad you enjoyed it " + kathPlayerText() + ".  It’s such a strange ride for me.</i>”\n\n");

		output("As you continue to rub her sides you tell her again that this is the best feeling you’ve ever experienced.  The feeling of being inside her - of knowing how completely you filled her, is so good you almost want to cum again.\n\n");

		output("“<i>I don’t know - I’m already so full.  I probably won’t even eat dinner tonight.</i>”\n\n");

		output("You smile to yourself and begin tracing your fingers seductively " + kath.catGirl("over her silky skin", "through her soft fur") + ", telling Kath that if she keeps talking like that she’ll get an encore for sure.  She purrs in reply - you can’t tell if she’s asking for another helping or just enjoying what your fingers are doing.");
	}
	output("\n\nWhen your cocks finally go completely soft you pull out and get dressed, waiting for your bloated ");
	if (pc.cor() < 25) output("mate");
	else if (pc.cor() < 75) output("partner");
	else output("cum dump");
	output(" to recover");
	if (kathIsAt(KLOC_LAKE)) {
		output(", which takes far longer than you’d like.\n\n");
		output("Kath washes herself off in a nearby stream before the two of you begin the long march back to Tel’Adre.  When you reach the gates");
		processTime(10 + rand(10));
	}
	else {
   		output(".  Finally Kath stands on rubbery legs and");
	}
	output("you put your arms around her.  Katherine gives you a delighted smile and you tell her " + (firstTime ? "that it will be much easier and much sexier for her" : "you’re already looking forward to") + " next time.\n\n");
	
	output("She blushes and gives you a kiss.  On the way back to camp you wonder what other tricks you can teach your submissive " + kath.catGirl("cat girl.", "kitty."));
	kath.loadInAss(pc);
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Suck 'n' Fuck (unavailable if knot > 4")
public function suckNFuck():void {
	//Scene can happen in the streets or at Kath's apartment
	var x:Number = pc.cockThatFits(kath.vaginalCapacity());
	clearOutput();
	//output(images.showImage("katherine-fuck-and-suck"));
	output("You think it over, then find your gaze drifting to Katherine's sheath and the " + kath.cockType() + " cockflesh within.  ");
	if (flags["COC.KBIT_TRIED_RECEIVE_SUCK_N_FUCK"] != undefined)
		output("It's quite the sight when she curls up and swallows her own shaft, so you ask her if she'd like another suck 'n fuck.\n\nHer eyes light up and her cock" + kath.CockMultiple("", "s") + " jump at the suggestion.  She absentmindedly runs a finger around her knot" + kath.CockMultiple("", "s") + " and says, “<i>Sure, I'm game.</i>”");
	else output("Recalling how you helped the poor herm shrink down her monster knot" + kath.CockMultiple("", "s") + ", and remembering the flexibility of the cats you've seen, you find a very kinky idea coming to you.  You ask Katherine if she'd be willing to try a suck 'n fuck.\n\n“<i>Excuse me?</i>” she asks, raising an eyebrow.  You quickly explain the idea: that you penetrate her vagina at the same time that she performs oral sex on her own cock, at which her eyes light up.  “<i>Sounds kinky - but also genius!  Sure, I'm game.</i>”");
	output("  She smiles, and ");
	if (kathIsAt(KLOC_STREETS))
		output("turns around so that she is sitting on the crate instead of leaning on it");
	else //Kath’s Apartment
		output("sits down on her bed and spreads her legs");

	output(".\n\nStill smiling, she begins to gently stroke her sheath" + (kath.hasBalls() ? ", balls" : "") + " and pussy, coaxing out her " + kath.cockType("dog", "cat") + " cock" + kath.CockMultiple("", "s") + ".  Making sure she's positioned so that she's not going to tumble off in mid-fuck, she takes hold of her thighs and bends over... and over... until she has practically pressed her nose into her own crotch.");
	if (!pc.hasPerk("Flexibility") && pc.felineScore() <= 3) output("  The sight is enough to make your spine wince in sympathy.");
	//(player has Feline Flexibility:
	else if (flags["COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY"] != undefined)
		output("  You know well, that you can bend like that too. Maybe you should try recieving next time?");
	else output("  You watch how she does it, resolving to test your body and see if you can bend like that.")
	output("  Having loosened up, she straightens her back until her mouth is hovering in front of the tip of her " + kath.CockMultiple("", "topmost ") + kath.cockType("dog", "cat") + " cock.  Her cat-like tongue, long, flat, and bristly looking, reaches out to stroke the " + kath.cockType("rubbery, conical", "narrow, barbed") + " tip, slurping around it and getting it nice and slick.  Then, she opens her mouth and starts bending forward again, gulping down all " + kath.longestCockLength() + " inches of " + kath.cockType("dog", "cat") + " cock until she reaches the knot.  A moment's hesitation, to muster her courage, and then she engulfs it as well, pressing her nose flat against her own " + (kath.hasBalls() ? "ballsack" : "taint") + ".\n\n");

	output("This is your moment, and you step forward, gently but firmly taking hold of her thighs, positioning your [pc.cock " + x + "] against her slavering cunt.  Certain you are in position, you slide it home.");
	pc.cockChange();
	output("  She shudders and audibly slurps on her cock as you sheathe yourself in her slick, velvety, burning hot nether lips.  You pull back and thrust home again, even as she begins to bob her head.\n\n");

	output("It is awkward, at first, the two of you trying to set up mutually complementary rhythms.  She hums and rumbles in her throat, striving to coax the most pleasure from her male genitalia, even as your thrusts and bucks make her cunt slurp and squelch, her copious lubricants slopping across your dick");
	if (pc.balls > 0) output(", your balls,");
	output(" and your inner thighs.  But, as you keep going, you get into the rhythm and it becomes more pleasurable.\n\n");

	output("It's impossible to describe just how kinky this is; her hot, wet walls wrapped like a silken vise around your cock, her head bobbing and gurgling on her own right in front of you" + kath.CockMultiple("", ", and her lower shaft waving in the air between you as if to conduct the performance") + ".  You thrust into her harder and harder; you can feel your climax coming... but she's the one who comes first.  With a muffled yowl, she squirts femcum from her cunt, splattering your belly in her juices.  The cry is cut off and her lips and cheeks visibly bulge as her knot suddenly inflates, trapping her cock in her own mouth and forcing her to drink every last drop as her balls release their cargo into her.  ");
	//This was previously based on Kath's ball size
	var kathCum:Number = kath.cumQ();
	var playerCum:Number = pc.cumQ();
	if (kathCum <= 500)
		output("She gulps several times, loudly drinking until her balls are empty, but even so she remains locked in place, her knot trapping her until she's fully climaxed.");
	else if (kathCum <= 1500)
		output("She has to drink quickly to avoid choking on her own copious discharge, but finally, belly beginning to bulge, she's drunk it all.");
	else output("With a frantic look she swallows and swallows, and you can't help the frightening thought she may drown in her own spunk.  But, as her belly swells and she looks verifiably pregnant, her balls stop trembling and she's done, panting and taking deep, grateful breathes through her nose.");
	output("\n\n");

	output("And now, at last, it's your turn to cum, and with a loud moan you release into her.  ");
	if (playerCum <= 250)
		output("You spray everything you have into her sloppy, sopping-wet cunt, allowing it to join the other fluids already dripping from her gash.");
	else if (playerCum <= 750) {
		if (kathCum <= 500)
			output("  Her belly bulges as you flood her womb with your sperm, visibly distended from your efforts.");
		else output("  She looks heavily pregnant by the time you are done, her bellybutton beginning to brush against her chin.");
	}
	else {
		if (kathCum <= 500)
			output("  Your unnatural orgasm leaves her visibly bloated and distended, stomach swollen and round in the curve of her body.");
		else {
			output("  The cat herm looks panicked as you just keep pouring jet after jet into her body, her womb swelling and her skin already distended from her own massive discharge into her stomach.  Her belly swells out and out until it is visibly pushing against her neck and upper torso, her own body forming an impenetrable barrier that leaves it with nowhere to expand to, the pressure making your cum squirt out in jets that splatter all over the ");
			if (kathIsAt(KLOC_STREETS))
				output("alley.");
			else //Kath’s Apartment
				output("floor of her apartment.");
		}
	}
	output("\n\n");

	output("Your climax finished, you pull out");
	if (playerCum > 250) output(", allowing a cascade of jism to flow like a perverse waterfall in miniature from her cunt,");
	output(" and step back to catch your breath.  Your smile at her, initially one of pleased relief, turns to wry grin as you realize she's still knotted up and plugged inside her own mouth.  She looks at you as best she can and blinks.  With a gentle expression you step close and reach out to stroke her ears; nothing sexual, just gentle and relaxing.  She closes her eyes and visibly leans into the caresses.\n\n");

	output("You stay like that until her knot shrinks down and, with a wet popping sound, she uncurls herself.  “<i>" + (flags["COC.KBIT_TRIED_RECEIVE_SUCK_N_FUCK"] != undefined ? "By Marae, was that ever good" : "Boy, that was really something") + ",</i>” she declares in an amazed tone");
	if (kathCum > 500 || playerCum > 250) {
		output(", slapping her ");
		if (kathCum > 1500 || playerCum > 750) output("hugely ");
		output("swollen, cum-filled gut for emphasis");
	}
	output(".  “<i>I'm ready to try that again if ever you are.</i>”\n\n");

	output("You promise her you'll remember that.  Redressed, you bid her farewell and head back out into the streets of Tel'Adre.\n\n");
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(45);
	kath.loadInMouth(kath);
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_RECEIVE_SUCK_N_FUCK"] == 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Get Penetrated
private function letKatKnotYou():void {
	var x:Number;
	clearOutput();
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("As you wait for Katherine to finish off her drink you start rubbing " + (pc.isNaga() ? "the tip of your tail" : "your toe") + " up and down her leg.\n\n");
		output("Kath shivers as you go over all the things you'd like to do with her, but you notice she's most excited when you talk about letting her feed her " + kath.cockType() + " cock" + kath.CockMultiple("", "s") + " into your body.\n\n");
	}
	else letKatKnotYouCommonDialogue(false); //Either at her apartment or behind Oswald's
	//[pc.vagina] [Anus] [Double Penetrate] [Sucked 'n' Fucked]
	clearMenu();
	
	addDisabledButton(0, "Vagina", "Vagina", "This scene requires you to have vagina.");
	addDisabledButton(2, "DblPenetr", "Double Penetration", "This scene requires you to have vagina and Kath to have two cocks.");
	addDisabledButton(3, "SuckNFuckd", "Sucked & Fucked", "This scene requires you to have cock and some sexual experience with Kath.");
	addDisabledButton(4, "Backroom", "Backroom", "This scene is only available in bar.");
	
	if (pc.hasVagina()) addButton(0, "Vagina", letKatKnotYourCuntPussyFuck);
	addButton(1, "Anus", getPenetratedByKath);
	if (kath.cockTotal() > 1 && pc.hasVagina()) addButton(2, "DblPenetr", getDoublePennedByKat);
	if (pc.hasCock() && flags["COC.KATHERINE_TIMES_SEXED"] > 1) addButton(3, "SuckNFuckd", suckedNFuckedByKat);
	//if (kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) addButton(4, "Backroom", drunkFuckKath);
	
	addButton(14, "Back", katSexMenu);
}

private function letKatKnotYouCommonDialogue(inAlleyBehindBar:Boolean):void {
	if (inAlleyBehindBar) {
		output("Kath glups down the last of her drink, grabs your hand and drags you toward the alley.\n\n");
		output("Once outside she gives you a big hug, her whole body flushed with excitement.  “<i>Now what was it you were saying back in the bar?  I was a little distracted.</i>”\n\n");
		flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS;
	}
	var hasPenetrated:Boolean = flags["COC.KBIT_TRIED_GIVE_VAGINAL"] != undefined || flags["COC.KBIT_TRIED_GIVE_ANAL"] != undefined || flags["COC.KBIT_TRIED_GIVE_DOUBLE_PEN"] != undefined || flags["COC.KBIT_TRIED_GIVE_SUCK_N_FUCK"] != undefined;
	output("You ask Katherine if she'd like to penetrate you.  She " + (hasPenetrated ? "" : "looks startled, then " ) + "grins like the proverbial cat that ate the canary.  “<i>Well, all right then...</i>” she declares, swiftly stripping off her clothes.  “<i>Get undressed, turn around and kneel on the " + (kathIsAt(KLOC_KATHS_APT) ? "bed" : "ground") + ".</i>”  Her " + kath.cockType() + " cock" + kath.CockMultiple(" is", "s are") + " already starting to peek out of her sheath, as if to echo her instructions.\n\n");
	output("You do as you are told, but you can't resist teasing her about wanting 'doggy-style' sex.\n\n");
	output("The " + kath.cockType("mismatched ", "") + "herm steps up behind you and gives you a playful slap on your [pc.ass].  “<i>Well, I");
	if (kath.cockTotal(GLOBAL.TYPE_CANINE) > 0)
		output("'ve got " + kath.CockMultiple("a dog dick", "dog dicks"));
	else output(" had " + kath.CockMultiple("a dog dick", "dog dicks") + " for a long time");
	output(", so I'm just doing it the way nature intended,</i>” she cracks.");
	//(if player has anus & vagina:
	if (pc.hasVagina()) output("  “<i>So, which hole do you want me to use?</i>”");
}

//Get Penetrated (Vaginal)
public function letKatKnotYourCuntPussyFuck():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	//output(images.showImage("katherine-fucks-you-knottily-in-the-vagoo"));
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	output("You indicate to Katherine that you want it in your [pc.vagina].\n\n");

	output("Her furry hands promptly begin to rub possessively over your [pc.ass], slowly moving up to take hold of your [pc.hips].  “<i>Well, all right... if that's what you want...</i>”  You feel her running " + kath.CockMultiple("her ", "the topmost ") + kath.biggestCockLength() + "\" cock against your sensitive pussy lips, letting you feel its " + kath.cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts it home without any hesitation.");
	if (kath.cockTotal() > 1) {
		output("  Her second cock slaps lewdly against your ");
		if(pc.hasCock()) output("[pc.multiCocks]");
		else if(pc.balls > 0) output("[pc.sack]");
		else output("[pc.belly]");
		output(".");
	}
	var cunt:Number = pc.vaginas[0].looseness();
	//(hymen check and stretching)
	pc.cuntChange(0, kath.biggestCockVolume(), true, true, false);
	output("\n\n");

	if (cunt < pc.vaginas[0].looseness()) {
		output("You can't help but yelp in shock and look back over your shoulder at Katherine, who has the grace to appear apologetic.  “<i>Sorry!  But I need to penetrate fast - or would you rather wait until my knot's fully swollen?</i>”  You concede she has a point, but ask her to remember to be more gentle next time.\n\n");
	}

	output("Fingers digging into your hips, she begins to thrust back and forth inside of you");
	if (kath.cockTotal() > 1) output(", her second cock still slapping wetly against you and smearing trickles of pre-cum that stretch and dangle as it bounces");
	output(".  She grunts and groans.  “<i>Oh- Oh yeah, you're unbelievable!");
	if (pc.harpyScore() >= 4 || pc.felineScore() >= 4 || pc.canineScore() >= 4 || pc.bunnyScore() >= 4) output("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha, huh?  Katherine's your alpha - go on, say it!</i>” she yells, pounding herself into you with greater force, her claws extending just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.");
	else output("</i>”");
	output("\n\n");

	output("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking");
	if (pc.isNaga() || pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_PREHENSILE)) output(", snaking your tail up between her breasts and playfully stroking her cheek,");
	output(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n");

	output("“<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>” Katherine moans, her knot growing to its maximum size inside of you, anchoring you together so that she can no longer pull out.");
	//(stretch check again)
	cunt = pc.vaginas[0].looseness();
	pc.cuntChange(0, kath.biggestCockVolume(), true, true, false);
	output("  She lunges forward and grabs your shoulders, trying to push her way in deeper.");
	//(if stretched:
	if (cunt < pc.vaginas[0].looseness()) output("  The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's pleasure that fills you.");
	else output("  Thanks to the glovelike fit your pussy has on her knot, it feels nothing but good to be plugged up like this.");
	output("\n\n");

	output("You shudder and gasp as your own climax suddenly rocks through you, [pc.girlCum] splashing from your [pc.vagina]");
	if (pc.hasCock()) {
		output(" and your cocks spurting ");
		if(pc.cumQ() < 25) output("drops");
		else if(pc.cumQ() < 100) output("splashes");
		else if(pc.cumQ() < 250) output("puddles");
		else output("a veritable lake of spunk " + (kathIsAt(KLOC_KATHS_APT) ? "onto the bed" : "into the alleyway"));
	}
	output(".\n\n");

	output("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you");
	if (kath.cockTotal() > 1) output(", with more spurting from her second cock to glaze your belly and the " + (kathIsAt(KLOC_KATHS_APT) ? "sheets" : "ground") + " below");
	output(".  ");
	//These cum volumes were previously based on Kath's ball size
	if (kath.cumQ() <= 500)
		output("She makes a surprisingly large amount of cum for " + (kath.hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (kath.cumQ() <= 1500)
		output("Jet after jet of cum sprays inside you," + (pc.isPregnant() ? "" : " flooding all the way up into your womb;") + " by the time the " + kath.cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all she's given you.");
	else {
		output("She cums and she cums and she cums; how can she hold this much spooge inside her " + (kath.hasBalls() ? "balls" : "prostate") + "?  Your " + (pc.isPregnant() ? "pussy" : "womb") + " is flooded until by the time she finishes, you look certifiably pregnant and ");
		if (kath.knotThickness() >= 6)
			output("only her huge knot is keeping everything plugged inside you.");
		else output("some of it actually starts leaking out around her knot.");
	}
	output("  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n");

	output("“<i>Oops.  Sorry,</i>” Katherine apologises.  ");
	if (kath.knotThickness() >= 6) output("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (kath.knotThickness() >= 4) output("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else output("“<i>If you pull hard enough, I should pop right out of you.");
	output("</i>”\n\n");

	//[(PC is very loose)
	if (pc.vaginalCapacity() >= new CockClass(kath.longestCockLength(), kath.cocks[0].knotMultiplier).volume() && kathIsAt(KLOC_STREETS)) {
		output("Nonplussed by the idea of waiting naked and penetrated in a back alley");
		if (kath.knotThickness() >= 4) output(", and eager to see the look on Katherine's face,");
		output(" you pull apart anyway; your thoroughly stretched-out pussy relinquishes the knot with no more than a long sucking noise.");
		if (kath.knotThickness() >= 4) output("  Free of her, you look back over your shoulder.  As you guessed, Katherine is sitting there wordlessly with her mouth open, staring alternately at the abused, cum-drooling lips of your pussy and at the enormous mass of flesh you just managed to pass through it.");
	}
	else output("You tell her that it's all right; you'll stay here with her until nature takes its course.  Even though you can't really see her, given your respective positions, you know she's smiling.");
	output("\n\n");

	if (pc.vaginalCapacity() < new CockClass(kath.longestCockLength(), kath.cocks[0].knotMultiplier).volume() || !kathIsAt(KLOC_STREETS)) {
		output("About an hour later, she's deflated and y");
		processTime(25 + rand(10));
	}
	else output("Y");
	output("ou get dressed, thank her, and head out.");
	//minus lust, slimefeed, Player returns to camp
	processTime(20 + rand(10));
	pc.loadInCunt(kath);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_GIVE_VAGINAL"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Get Penetrated (Anal)
public function getPenetratedByKath():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	//output(images.showImage("katherine-fucks-you-knottily-in-the-bungholio"));
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	output("You indicate to Katherine that you want it in your [pc.asshole].\n\n");

	output("“<i>Well, I can't say I'm a big fan of the idea, but okay...</i>”  Her" + kath.catGirl("", " furry") + " hands promptly begin to rub possessively over your [pc.ass], slowly moving up to take hold of your [pc.hips].  “<i>... if that's what you want.</i>”  You feel her rubbing her " + kath.CockMultiple("", "bottom-most ") + "cock against your anus, letting your cheeks feel its " + kath.cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts it between them without any hesitation" + kath.CockMultiple("", ", as her upper cock bounces along your back") + ".\n\n");

	output("“<i>Gonna - mmm - need just a bit of lube here...</i>” she mumbles, dragging her cock" + kath.CockMultiple("", "s") + " between your buttcheeks.  As she says it, her body matches deed to her word and the " + kath.cockType("puppy pecker", "kitty cock") + " begins drooling a slick, warm fluid into your asscrack" + kath.CockMultiple("", ", as well as onto your cheeks, with the other bouncing around above them") + ".  With soft hands, she rubs the goo into your pucker and all over her pointed shaft, then there's a void of sensation as she pulls it from your asscheeks.  Before you can react, she pushes them open again and rams her cock into your anus!");
	//(butt hymen check + stretch check)
	var butts:Number = pc.ass.looseness();
	pc.buttChange(kath.biggestCockVolume(), true, true, false);
	output("\n\n");

	if (butts > pc.ass.looseness()) output("You can't help but yelp in shock and look back over your shoulder at Katherine, who appears genuinely apologetic.  “<i>Sorry!  But I need to penetrate sooner rather than later - or would you rather wait until my knot's fully swollen?</i>”  You concede she has a point, but beg her to be more gentle if there's a next time.\n\n");

	output("Fingers digging into your hips, she begins to thrust back and forth inside you" + kath.CockMultiple("", ", her secondary cock slapping wetly against your back") + ".  She grunts and groans, “<i>Oh- Oh yeah, you're unbelievable!");
	//[(player has high harpy/shark/cat/dog/bunny score)
	if(pc.harpyScore() >= 4 || pc.felineScore() >= 4 || pc.canineScore() >= 4 || pc.bunnyScore() >= 4)
		output("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha bitch, huh?  Katherine's your alpha - go on, say it!</i>” she yells out, pounding herself into you with greater force and her " + kath.catGirl("sharp nails dig in", "claws extend") + " just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.\n\n");
	else output("</i>”\n\n");

	output("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking");
	if(pc.isNaga() || pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_PREHENSILE)) {
		output(",  snaking your tail up between her breasts and playfully stroking her cheek,");
	}
	output(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n");

	output("“<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>” Katherine moans, her knot filling to its maximum size inside of you, anchoring you together so that she can no longer pull out.  She lunges forward and grabs your shoulders, trying to push her way in deeper.  ");
	if (kath.knotThickness() >= 6)
		output("It feels like she's trying to shove a melon inside you; and you cry out in equal parts pain and pleasure at being stuffed so full.");
	else if (kath.knotThickness() >= 4)
		output("The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's sheer pleasure that fills you.");
	else output("Thanks to her relatively normal-sized knot, it feels nothing but good to be plugged up like this.");
	output("\n\n");

	output("You shudder and gasp as your own climax suddenly rocks through you");
	if (pc.hasVagina()) output(", [pc.femCum] splashing from your [pc.vagina]");
	if (pc.cockTotal() > 0) {
		output((pc.hasVagina() ? " and " : ", ") + "[pc.multiCocks] spurting ");
		if(pc.cumQ() < 25) output("drops");
		else if(pc.cumQ() < 100) output("splashes");
		else if(pc.cumQ() < 250) output("puddles");
		else output("a veritable lake of spunk" + (kathIsAt(KLOC_KATHS_APT) ? "onto the bed" : "into the alleyway"));
	}
	output(" as your asshole wrings the invader.\n\n");

	output("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you");
	if (kath.cockTotal() > 1) output(", with more spurting from her second cock to glaze your back and drool off onto the " + (kathIsAt(KLOC_KATHS_APT) ? "sheets" : "ground") + " below you");
	output(".  ");
	//These cum volumes were previously based on Kath's ball size
	if (kath.cumQ() <= 500)
		output("She makes a surprisingly large amount of cum for " + (kath.hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (kath.cumQ() <= 1500)
		output("Jet after jet of cum sprays inside you, flooding all the way up into your bowels; by the time the " + kath.cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all the cum she's given you.");
	else {
		output("She cums and she cums and she cums; how can she hold this much spooge inside her " + (kath.hasBalls() ? "balls" : "prostate") + "?  Your stomach is flooded with cum until, by the time she finishes, you look certifiably pregnant and ");
		if (kath.knotThickness() >= 6) output("only her huge knot is keeping everything plugged inside you");
		else output("some of it actually starts leaking out around her knot");
		output("; you stifle a belch and taste her salty spunk on the back of your tongue");
	}
	output(".  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n");

	output("“<i>Oops.  Sorry,</i>” Katherine apologizes.  ");
	if (kath.knotThickness() >= 6)
		output("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (kath.knotThickness() >= 4)
		output("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else output("“<i>If you pull hard enough, I should pop right out of you.");
	output("</i>”\n\n");

	//[(PC is very loose)
	if (pc.analCapacity() >= new CockClass(kath.longestCockLength(), kath.cocks[0].knotMultiplier).volume() && kathIsAt(KLOC_STREETS)) {
		output("Nonplussed by the idea of waiting naked and penetrated in a back alley");
		if (kath.knotThickness() >= 4) output(", and eager to see the look on Katherine's face,");
		output(" you pull apart anyway; your thoroughly stretched-out asshole relinquishes the knot with no more than a long sucking noise.");
		if (kath.knotThickness() >= 4) output("  Free of her, you look back over your shoulder.  As you guessed, Katherine is sitting there wordlessly with her mouth open, staring alternately at the abused, cum-drooling ring of your sphincter and at the enormous mass of flesh you just managed to pass through it.");
	}
	else output("You tell her that it's all right; you'll stay here with her until nature takes its course.  Even though you can't really see her, given your respective positions, you know she's smiling.");
	output("\n\n");

	if (pc.analCapacity() < new CockClass(kath.longestCockLength(), kath.cocks[0].knotMultiplier).volume() || !kathIsAt(KLOC_STREETS)) {
		output("About an hour later, she's deflated and y");
		processTime(25 + rand(10));
	}
	else output("Y");
	output("ou get dressed, thank her, and head out.");
	
	//minus lust, slimefeed, Player returns to camp
	processTime(20 + rand(10));
	pc.loadInAss(kath);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_GIVE_ANAL"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Get Penetrated (Double)
public function getDoublePennedByKat():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	var doneBefore:Boolean = flags["COC.KBIT_TRIED_GIVE_DOUBLE_PEN"] == 1;
	
	//output(images.showImage("katherine-fucks-you-knottily-in-all-the-holes"));
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	output("You indicate to Katherine that you want it in both holes.\n\n");

	output((doneBefore ? "She grins from ear to ear and says, " : "She starts in shock at the proposal, then slowly, she nods her head.  ") + "“<i>All right... if that's what you want.</i>”  " + (doneBefore ? "Her " : "Despite her tone, her ") + kath.catGirl("soft", "furry") + " hands promptly begin to rub possessively over your [pc.ass], slowly moving up to take hold of your [pc.hips].  “<i>Hmm... this is so kinky" + (doneBefore ? "" : ", but I think it just might work") + "...</i>” she murmurs, mostly to herself, and you feel her running her " + kath.cockAdj() + "cocks against your sensitive pussy lips and your tingling anus, letting you feel their " + kath.cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts the bottom one home without any hesitation.  The other slides along your asscrack harmlessly.");
	pc.cuntChange(0, kath.biggestCockVolume(), true, true, false);
	//[check vag hymen and stretch it]
	output("\n\n");

	output("You can't help but look back over your shoulder at Katherine, who appears rapt with concentration.  “<i>Sorry!  But this will be tricky... I need to penetrate fast, but I need some lube, too - unless you want to try and take my other knot completely dry!</i>”  She looks down and pushes the upper shaft between your buttcheeks.\n\n");

	output("Fingers digging into your hips, she begins to thrust back and forth inside of you, dragging one shaft through your pussy and the other through your cheeks.  “<i>Mmm, you're so good... I could come from this alone,</i>” she moans.  As if to echo the sentiment, a slow stream of pre-cum infiltrates your asscrack.  “<i>Ahh, here it comes...</i>”  She pulls her shafts out just as you feel a minute stiffening of the knots at their bases, and you can hear her smearing her pre-cum and your copious girl-lube along her lengths.  Your [pc.asshole] does not go neglected either; after she's done rubbing herself to slickness, a palmful of warm gooeyness is pushed into it.  She must already be drooling a huge amount if she's got this much to donate!  Almost on cue, she confirms your hunch with a moan.  “<i>Ahhh, gotta put it in now!  I can't hold back anymore, I'm sorry!</i>”  A hot pressure on both holes is the only warning you get before her twin talents are forced into you, sliding easily into your already wet vagina and pushing past your ring by virtue of the tapered shape and the slickness.");
	pc.buttChange(kath.biggestCockVolume(), true, true, false);
	output("\n\n");

	output("She begins thrusting at once, grunting and groaning as if she were already near her peak.  “<i>Oh- Oh yeah, you're unbelievable!  " + (doneBefore ? "" : "It's so weird, ") + "I'm fucking two holes at once" + (doneBefore ? "; it's like I was born to do this" : ", but it's so good") + "!</i>” she cries out.  Her usually firm grip is shaky and unreliable, further evidence of the trouble she's having in controlling her climax.\n\n");

	output("You thrust your ass back toward your feline lover's midriff with an unseen, malicious smile, intent on forcing her to finish shamefully quickly, and cry out her name in your best bedroom voice.  You can feel her knots starting to swell inside you even as she picks up the pace, hammering into you.\n\n");

	output("“<i>Ohhh!  G-gonna plug you up; fill you fu-full...!</i>” Katherine moans distractedly, her knots filling to their maximum size inside of you and anchoring you together so that she can no longer pull out.  She lunges forward and grabs at your shoulders to push her way in deeper, but slips off weakly as her orgasm arrives.\n\n");

	output("She suddenly arches her back and lets out a yowl of pleasure as it ripples through her and she cums inside you.  ");
	//These cum volumes were previously based on Kath's ball size
	if (kath.cumQ() <= 500)
		output("She makes a surprisingly large amount of cum for " + (kath.hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (kath.cumQ() <= 1500)
		output("Jet after jet of cum sprays inside you, flooding all the way " + (pc.isPregnant() ? "inside, splattering against your cervix and filling your" : "up into your womb and") + " bowels; by the time the " + kath.cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all the cum she's given you.");
	else {
		output("She cums and she cums and she cums; how can she hold this much spooge inside her " + (kath.hasBalls() ? "balls" : "prostate") + "?  Your " + (pc.isPregnant() ? "pussy" : "womb") + " and your stomach are flooded with cum until, by the time she finishes, you look certifiably pregnant and ");
		if (kath.knotThickness() >= 6) output("only her huge knots are keeping everything plugged inside you.");
		else output("some of it actually starts leaking out around her knots.");
	}
	output("  Her load spent, she collapses bonelessly onto her back - thanks to her knots, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward until you're sitting on her.\n\n");

	output("“<i>Oops.  Sorry,</i>” Katherine apologises.  ");
	if (kath.knotThickness() >= 6)
		output("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (kath.knotThickness() >= 4)
		output("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else output("“<i>If you pull hard enough, I should pop right out of you.");
	output("</i>”\n\n");

	output("You tell her that it's no matter if she can't pull out; you haven't gotten your own orgasm yet.  As you watch her face over your shoulder, her feline eyes widen.  “<i>Oh!  I'm so sorry... gods, I wasn't even thinking.  What... what are you gonna do?</i>”\n\n");

	output("Turning back to hide your wicked grin, you begin to bounce up and down on her knotted, still-hard shafts.");
	if (kath.cumQ() > 500) output("  Her cum sloshes fluidly inside you, adding to the sensations assaulting your cervix and bowels.");
	output("\n\n");

	output("“<i>O-oh Marae!  It's too much!  Please stop, they're so sensitive right now!</i>” cries the cat-girl as you continue to ride her knotted shafts, reverse cowgirl style.  She paws at your hips as if to gain respite, but her slack, spent muscles can't keep you from completing your orgasm.  Fueled by her whimper-like moaning and the sensations inside you, it follows soon; as your anus and vagina squeeze her dicks in the throes of climax, a second burst from her follows, stretching your belly");
	if (kath.cumQ() > 1500) output(" to its limit");
	output(" as she fills you with a smaller, second load of jizz.");
	if (pc.hasCock()) output("  [pc.EachCock]" + (pc.cocks.length > 1 ? " celebrate with arcs of their" : " celebrates with arcs of its") + " own semen, spraying them in a patter on her legs and the ground in front of you.");
	output("  The cat-woman gasps and twitches as her new ejaculation reverberates through her body, but forms no words, only looking up at the " + (kathIsAt(KLOC_STREETS) ? "walls overhead." : "ceiling with a glazed expression."));
	output("\n\n");

	output("About an hour later, she's deflated and you are finally able to rise off of her, get dressed, and head out.\n\n");
	//minus lust, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(50 + rand(20));
	pc.loadInAss(kath);
	pc.loadInCunt(kath);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_GIVE_DOUBLE_PEN"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Sucked 'n' Fucked
//This scene requires the PC has a penis and has fucked Kat at least once since moving her
public function suckedNFuckedByKat():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	var doneBefore:Boolean = flags["COC.KBIT_TRIED_GIVE_SUCK_N_FUCK"] == 1;
	var x:Number = pc.biggestCockIndex();
	//output(images.showImage("katherine-suck-and-fucks-you"));
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	output("As you crouch, trying to figure out how you want your herm lover to take you, you start when you feel Katherine's fingers suddenly caressing your [pc.cock " + x + "].\n\n");
	
	output("“<i>Hmm... I think you deserve a special treat, my sweet.  " + (kathIsAt(KLOC_KATHS_APT) ? "Lie back on the bed" : "Roll over onto your back") + "...</i>” Katherine purrs, giving you a stroke to make you as stiff as possible before releasing you.\n\n");
	
	output((doneBefore ? "Knowing" : "Wondering") + " what she has in mind, you do as you are told, " + (kathIsAt(KLOC_KATHS_APT) ? "lying back on the bed with your head on the pillow, your cock pointing at the ceiling" : "rolling onto your back and lying there with your prick aimed at the sky") + " and your " + (pc.isNaga() ? "[pc.legs] flat" : "[pc.legs] spread") + ".  Katherine advances toward you and kneels down, reaching over your stomach and petting your [pc.chest] with a smile.  “<i>You're very special to me, you know that?  Well, to prove it, I'm going to show you a real good time...</i>”  She grins, passing her tongue over her lips with exaggerated anticipation.\n\n");
	
	output("As you watch, she bends over from where she's sitting until she can lick your [pc.cock " + x + "], her long, feline tongue running up and down its length, tickling the head.  The sensation is strange; bristly, but not sharp, so it's like being stroked by lots of little tongues at the same time.  Pre-cum begins flowing from your cock-tip like water bubbling from an underground spring, and your feline lover visibly savors the taste before leaning back upright, smacking her lips and smiling at your protest.\n\n");
	
	output("“<i>Naughty, naughty; have you forgotten who's fucking whom, this time?</i>” she purrs at you, one hand slipping forward to caress ");
	if (pc.hasVagina()) output("your [pc.vagina]");
	else output("between your asscheeks");
	output(".  Taking hold of your [pc.hips], she slides her cock" + kath.CockMultiple("", "s") + " forward until she's hovering at the entrance to your ");
	if (kath.cockTotal() > 1 && pc.hasVagina())
		output("[pc.vagina] and [pc.asshole]");
	else output("[pc.vagOrAss]");
	output(".  Taking a bit of the pre-cum drooling from your prick, she slathers it over her cock" + kath.CockMultiple("", "s") + ".  Then, without further ado, she slides herself into you.");
	if (pc.hasVagina()) {
		if (kath.cockTotal() > 1) pc.buttChange(kath.biggestCockVolume(), true, true, false);
		pc.cuntChange(0, kath.biggestCockVolume(), true, true, false);
	}
	else pc.buttChange(kath.biggestCockVolume(), true, true, false);
	output("\n\n");

	output("“<i>Now, then, let's give this a shot...</i>” she murmurs to herself, beginning to slowly rock back and forth within you, sliding her cock" + kath.CockMultiple("", "s") + " out and then thrusting home, her knot" + kath.CockMultiple("", "s") + " starting to swell and stretching you out in all the right ways... if only she wasn't going so slow, this would be so great.  But any complaints about the pace are lost when she bends over again and starts to lap at your [pc.cock " + x + "], running her tongue over and around it several times before she takes it into her mouth, swallowing inch after inch of your shaft until her nose is pressed flat into the base of your belly.  She lets out a muffled grunt that might be “<i>right</i>”, then tries to manage the task of picking up the pace of her thrusts while sucking and slurping on your [pc.cock " + x + "] at the same time.\n\n");
	
	output("You're in no position to complain.  This feels... incredible!  Her mouth around your cock is so hot and wet, her tongue sliding along the underside of your shaft and stroking in a sensation that no human could ever match, greedily sucking on you and hungry for everything you have.  At the same time, she's stretching your hole");
	if (pc.hasVagina() && kath.cockTotal() > 1) output("s");
	output(" so deliciously full, knot");
	if(pc.hasVagina() && kath.cockTotal() > 1) output("s");
	output(" flaring inside you and anchoring you together.  You rock back and forth, thrusting your hips awkwardly in an effort to fuck and be fucked as hard as possible, and feel the oh-so-sweet sensation of release boiling away ");
	if (pc.balls > 0) output("in your [pc.balls]");
	else output("at the base of your spine");
	output("...\n\n");

	output("But it's Katherine who cums first.  With a muffled yowl of delight she floods your hole");
	if (pc.hasVagina() && kath.cockTotal() > 1) output("s");
	output(" with her spunk, gushing hot kitty-kum into your depths.  Your belly begins to swell from the spunk, bulging into a visible paunch");
	if (kath.cumQ() > 500) output(" and it doesn't stop, growing and growing until you look pregnant and ready to deliver");
	if (kath.cumQ() > 1500) output(" and her " + (kath.hasBalls() ? "swollen balls keep on going; by the time they finally run" : "massive prostate keeps on going; by the time it finally runs") + " dry, your belly is so heavy with deposited cum that you look like you're having triplets");
	output(".  She slumps forward with a groan of blissed-out relief, spent from her climax.\n\n");

	output("And then it's your turn to cum, flooding the startled, oblivious cat's mouth with your remembrance and making her swallow rapidly to keep it down.  ");
	//(Low/Normal:
	if (pc.cumQ() <= 250) output("She drinks every last drop with gusto, popping wetly off of your cock and licking her lips as she audibly purrs with delight.");
	//(High:
	else if (pc.cumQ() <= 600) output("She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.");
	//(Very High:
	else output("You can see a hint of panic at the titanic cascade of fluids coming from your [pc.cock " + x + "], but it's drowned out by sudden steely-eyed determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to avoid pulling your cock out until you're finished.  Then she weakly manages to detach herself and gives you a triumphant expression, and a faint burp.\n\n");

	output("With a groan she allows herself to collapse atop you, ");
	if (kath.cumQ() <= 500 ) {
		if (pc.cumQ() <= 250) output(" leaving you lying belly-to-belly");
		else output(" her cum-bloated belly squishing audibly against your own flat torso");
	}
	else {
		if (pc.cumQ() <= 250) output(" making your cum-swollen gut squelch wetly from the pressure");
		else output(" your mutually swollen bellies churning and rippling as they cushion the impact");
	}
	output(".  “<i>Quite an experience, wasn't it?</i>”  She grins, her hand tentatively inching towards yours.\n\n");

	output("You entwine her fingers with your own and agree that it was.\n\n");

	output("Once her knot");
	if (kath.cockTotal() > 1 && pc.hasVagina()) output("s");
	output(" deflate and you detach, you clean yourself off, get dressed, and head back out" + (kathIsAt(KLOC_KATHS_APT) ? ", leaving Kath passed out on her bed." : " into the street."));
	//lust -100, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(50 + rand(20));
	if (pc.hasVagina()) pc.loadInCunt(kath);
	if (kath.cockTotal() > 1 && pc.hasVagina() || !pc.hasVagina()) pc.loadInAss(kath);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_GIVE_SUCK_N_FUCK"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Double Helix
private function katDoubleHelixCraziness():void {
	//Scene can happen in the streets or at Kath's apartment
	var x:Number = pc.cockThatFits(kath.vaginalCapacity());
	if (x < 0) x = 0;
	clearOutput();
	//output(images.showImage("katherine-double-helix-fuck"));
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		output("You take her hand and lead her outside, to " + (flags["COC.TIMES_FUCKED_URTA"] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		output("She looks a little worried about getting caught, but she's too excited to refuse you.\n\nAs you stand there in the alley you ");
		flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS;
	}
	else output("You");
	//PC must have a cock and a vagina and not be a centaur
	output(" give the matter some thought... your partner here has both male and female sexual organs; which to choose...?  ");
	if (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1)
		output("That double helix maneuver was a lot of fun, so you jokingly ask Kath if she's still flexible enough to give it a shot.");
	else output("Then, recalling you have the same sort of sex arrangement, you feel a kinky idea coming on.  Gently, you ask if Katherine thinks she's flexible enough to use both her parts at the same time.");

	output("\n\nKatherine grins and " + (kathIsAt(KLOC_KATHS_APT) ? "stretches out on her bed" : "sits on the ground") + "; then bends over in a way that looks like she could lick her butt.  “<i>Flexible enough for you?</i>”\n\n");

	output("You can't resist a laugh; it looks like she is.  Carefully removing and setting your [pc.gear] aside, ");
	if (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1) {
		output("you position yourself the same as last time; Kath's legs wrapped around your lower body, her honeypot aligned with your own.  She carefully slides " + kath.CockMultiple("one of ", "") + "her " + kath.cockType() + "-pecker" + kath.CockMultiple("", "s") + " towards your [pc.vagina].  You do the same, pointing the tip of your [pc.cock " + x + "] to her drooling cunt.  You can hear her breathing softly, keeping herself calm, and you try to do the same.\n\n");
		output("Kath moans as the tips of both your cock and hers slip into place.  In a worried tone she says, “<i>um... after last time I don't think I'll be able to hold back.  We're probably going to wind up knotted like this.</i>”  Rather than replying you just shove your cock a little deeper.\n\nKatherine gives you a quick hug, then she");
	}
	else {
		output("you then realize the problem, and voice it aloud: how are you supposed to penetrate each other's pussy at the same time?\n\n");
		output("Katherine gets the cue and begins undressing herself.  “<i>Just lay down on your side and spread yourself for me.</i>”\n\n");
		output("You do as she says, ");
		if (pc.isNaga()) output("curling your naga tail back");
		else if (pc.isGoo()) output("shifting your gooey blob");
		else output("lifting your " + pc.leg() + " up");
		output(" so she has access to both your [pc.vagina] and your [pc.cock " + x + "].\n\n");
		output("Katherine lies down across from you and wraps her legs around your own lower body, her honeypot aligned with your own.  “<i>Okay... now push your dick down like this...</i>” she says, shoving " + kath.CockMultiple("one of ", "") + "her own " + kath.cockType() + "-pecker" + kath.CockMultiple("", "s") + " towards your [pc.vagina], slowly teasing you with the tip.\n\n");

		output("You repeat the gesture, pointing the tip of your [pc.cock " + x + "] to her drooling cunt.  You can hear her breathing softly, keeping herself calm, and try to do the same... which is when something occurs to you, and you ask her what the two of you are supposed to do about her knot.  You're not sure that the two of you tying yourselves in this position would be such a good idea, after all.\n\n");

		output("“<i>Oh, um... I guess it would be pretty awkward, yes... all right, I promise I won't push my knot in,</i>” she replies.\n\nKatherine");
	}
	output(" flexes her legs and pulls you inside her, penetrating you as well.  She yowls in pleasure as she feels the simultaneous pleasure of penetrating and being penetrated.  “<i>Ah... just move your hips - mmm - with me.</i>”\n\n");

	output("Shivering with delight as her hot, soaking wet walls envelop your [pc.cockNoun " + x + "] and her " + kath.cockType("rubbery, pointy dog", "narrow, barbed kitty") + "-cock slides into your [pc.vagina], you need no further encouragement, eagerly pumping your hips against hers, trying to push into her and push her into you without letting either cock slip free of its appointed hole.  Katherine gyrates her hips, attempting to stimulate both your parts, panting in pleasure.\n\n");

	output("You whine and whimper at the stimulus, moving your own hips likewise in an effort to intensify the sensations without accidentally enveloping her knot in your cunt.  Katherine mewls and yowls in pleasure in response, voicing her approval and pulling you dangerously close to her knot in an attempt to feel more of you.  Barely comprehending what's happening, your world shrinks down to the feeling of cock in cunt... then with a wet SCHLUCK Katherine's half-swollen knot slips inside your pussy and your hips collide.");
	pc.cuntChange(0, kath.biggestCockVolume(), true, true, false);
	output("\n\n");

	output("You gasp as you find yourself filled so full, with your cock sheathed to the hilt in her hot, wet depths.  The sensations are almost overwhelming... but you manage to stave them off and gasp out that she's knotted you.\n\n");

	output("“<i>" + (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1 ? "Mmmm" : "S-Sorry") + "...</i>” Katherine replies, holding back a moan and a thrust.  She pushes herself away just enough to let her knot slip free and continues gyrating her hips.  You resume working yours in turn, matching her pace so that her cock slides fully inside you and you can slide your cock fully inside her - at least, as fully as possible without once again taking in her knot... or not.  Katherine gasps and pulls you all the way inside her once more, once again slipping her knot inside you.  You cry out in pleasure; you can't bring yourself to care that you've been knotted once again, you're just too delighted to be truly full at last, to be fully sheathed at last - it's indescribable!\n\n");

	output("“<i>S-Sorry " + pc.short + (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1 ? ", but I'm not pulling out" : ", I just can't... ah... I promise I'll pull out before we tie") + ",</i>” Katherine says, doing her best to bump against you with all the strength she can muster.  You just automatically tell her it's all right, too lost in thrusting back against her with all your strength, mashing pelvis against pelvis with bestial desire, spurred on by instincts older than humanity.  With a final yowl of pleasure, you feel Katherine's knot swell inside you and her pussy clench around your [pc.cock " + x + "].  Then a flood of feline cum and juices splashes in and against you, prompting a cry of your own; you surrender to your own climax, cum ");
	if (pc.cumQ() <= 50) output("surging");
	else if (pc.cumQ() <= 250) output("gushing");
	else output("thundering");
	output(" from your cock and femcum ");
	if (pc.wetness() <= 3) output("drizzling");
	else if (pc.wetness() <= 4) output("spurting");
	else output("gushing");
	output(" from your cunt, striving to milk your " + kath.catGirl("cat girl", "anthropomorphic") + " lover and be milked by her in turn.\n\n");

	if (kath.cumQ() <= 500)
		output("You feel your belly beginning to bloat slightly as Katherine dumps her load inside you.");
	else if (kath.cumQ() <= 1500)
		output("You feel your belly beginning to bloat while Katherine fills you with her jism.  Her knot works to keep all of her cum inside you and as a result, by the time she's stopped you look at least a few months pregnant.");
	else
		output("You feel your belly beginning to rapidly bloat while Katherine fills you with her jism.  Not even her knot is equal to the task of keeping all of her cum inside you, as the backflow stretches your lips even wider to spill gouts of semen against Katherine's crotch.  By the time she's stopped cumming, you look like you're carrying multiple litters of kittens.");
	output("  ");
	//PC Medium Cum Amount)
	if (pc.cumQ() <= 500) output("You pay Katherine back in kind though, dumping your considerable load inside the eager cat and giving her a round belly of her own as you spurt thick gobs of semen inside her.");
	//(PC High Cum Amount)
	else if (pc.cumQ() <= 1500) output("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a few months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.");
	//(PC Very High Cum Amount)
	else output("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a several months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.  Yet it doesn't seem likely to stop anytime soon; if it weren't for Katherine's knot you're pretty sure you'd have sent the cat rocketing straight off of your cock.  Katherine trembles and her pussy walls clench as if to hold more of your cum inside her, and indeed she inflates beyond her capacity for a while, until she relaxes and your load pours out of her.");
	output("\n\n");

	output("You gasp for breath, mind still reeling from the earth-shaking pleasure you've experienced.  Your first instinct is to try to move, but you find you can't get up");
	if (kath.cumQ() > 1500) output(", and not because your swollen stomach is weighing you down, either");
	output(".  Katherine's knotty cock has locked her into your [pc.vagina], leaving you tied together like a dog and his bitch.  ");
	if (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1) {
		output("You gently rub one of Kath's nipples and ask her how she intends to make up for knotting you like this.\n\n");
		
		output("Kath pats your belly and says, “<i>I didn't hear you say 'Stop', and don't pretend you didn't enjoy it.  Anyway, you just wait 'til my knot shrinks down and I'll pay you back in spades.</i>”\n\n");
	}
	else {
		output("With roughly equal parts exasperation and amusement, you comment that you thought she'd promised to slip free before her knot bound you both together.\n\n");

		output("Katherine gulps audibly.  “<i>S-Sorry [pc.name].  It's just that... it felt so good... and I got carried away... sorry...</i>”  You tell her it's a bit disappointing, but you'll both live.  Besides, it's not as if it wasn't enjoyable.\n\n");

		output("Katherine smiles and says, “<i>Sorry... I promise I'll make it up to you somehow.</i>”  Propping yourself up on an elbow, you ask her with sincere curiosity what she has in mind.  “<i>Just wait for a while and let my knot shrink,</i>” she says, with a sly glance.  Seeing that she isn't going to talk, you settle back down and wait for just that to happen.\n\n");
	}
	output("With the sensation of your full pussy as your guide, it's easy to know when it's finally possible for her to slip free without hurting you; Katherine pulls away and stands on shaky feet.  The jism contained within you spills out in a satisfying cascade of white, that's when you feel a pair of lips touch your sensitive snatch.  Moments later a cat's tongue licks your labia and latches onto it, sucking the jism straight out of you.  You gasp in delight, but keep still, wondering what your lover has in mind.\n\n");

	output("Once she's done with your pussy, she moves on to your [pc.cock " + x + "], taking the tip into her mouth and suckling on it to drain the last bits of cum from your shaft, then she lets go of your [pc.cockHead " + x + "] and begins licking the shaft, cleaning you all the way from the base up");
	if (pc.balls > 0) output(", and even licking your [pc.balls] clean");
	output(".  You moan and shudder and buck your hips at her ministrations; your ");
	if (pc.balls > 0) output("balls are still depleted");
	else output("cock is still almost totally empty");
	output(", but you're confident she could coax another orgasm from you if she keeps this up.\n\n");

	output("Realizing your cock is hardening up again, Katherine gives you a mischievous grin and opens her maw to take in all of you deep into her throat, giving your [pc.cock " + x + "] a loud, wet slurp before sucking on you sharply.\n\n");

	output("You voice a hollow groan; you didn't know she had this in her!  Reaching out with your hands, you take hold of her head just below the ears; too weak to push her down (not that it's necessary anyway), you settle for just holding her in place.\n\n");

	output("Of course, with the state you're in, it's barely minutes before you explode again, cum rushing from your oversensitive cock and into her suckling maw.  Katherine drinks you up, drawing all of your cum in and releasing your cock with a POP; leaving your throbbing mast sparkling with saliva.  “<i>So I take it you liked my little tongue-bath?</i>” she teases, licking her lips.\n\n");

	output("You can only nod weakly at her.\n\n");

	output("“<i>Want me to give you a more thorough one?</i>”\n\n");

	output("You nod again unthinkingly.\n\n");

	output("Katherine rolls you on your back and begins licking your belly, cleaning you of the sweat produced by your vigorous fucking earlier.  She moves through your [pc.chest], stopping shortly to give each of your [pc.nipples] a little peck.  Then she continues to your neck and face.\n\n");

	output("You simply lie back and enjoy her attentions; while pleasurable, they aren't as sexual as her previous efforts, and you find the experience more soothing than arousing. It takes a while, but finally with one last lick on ");
	if(pc.isNaga() || pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_PREHENSILE)) output("the tip of your tail");
	else output("your [pc.ass]");
	output(", she finishes.  Katherine grins and happily declares, “<i>There you go, you're clean now!" + (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1 ? "" : " Sorry for breaking my promise and knotting you.") + "</i>”\n\n");

	output("Sitting up, you can't resist reaching over and ruffling her ears in a way that the cats you've met always liked, telling her that if this is how she'll apologize for " + (flags["COC.KBIT_TRIED_DOUBLE_HELIX"] == 1 ? "knotting you, you don't mind her doing so again and again" : "it, you don't mind her doing so again") + ".\n\n");

	output("She leans against your hand, purring.  “<i>Hmm... I'll keep that in mind.</i>”\n\n");

	output("Righting and redressing yourself, you say goodbye to the charming kitty, then head back to camp, still feeling rather drained.\n\n");
	//Player returns to camp without his lust, slimefeed
	processTime(50 + rand(20));
	pc.loadInCunt(kath);
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_DOUBLE_HELIX"] = 1;
	pc.slowStatGain("l", -1);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Oral
private function oralKatherineChoices():void {
	clearOutput();
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		output("You take her hand and lead her outside, to " + (flags["COC.TIMES_FUCKED_URTA"] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		output("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
		flags["COC.KATHERINE_LOCATION"] = KLOC_STREETS;
	}
	output("With a smirk, you suggest a taste test.  Katherine blinks, then smiles. “<i>Fine by me... but who's going to be the taster?</i>”\n\n");
	clearMenu();
	
	if (kath.hasCock())
		addButton(0, "PC Sucks", giveKatOralPenisWingWang);
	else addButton(0, "PC Laps", giveKatOralPussyLicking);
	if (pc.hasGenitals()) addButton(1, "Kath Laps", katherineGivesPCOralAllDayLongDotJPG);
	else addDisabledButton(1, "Kath Laps", "Kath Laps", "This scene requires you to have genitals.");
	
	addButton(14, "Back", katSexMenu);
}

//Give Katherine Oral scene, single cock
public function giveKatOralPenisWingWang():void {
	//Scene can happen in the streets, at Kath's apartment or in the Desert
	clearOutput();
	var doneBefore:Boolean = flags["COC.KBIT_TRIED_RECEIVE_ORAL"] == 1;
	//output(images.showImage("katherine-give-her-blowjobs"));
	output("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n");
	if (doneBefore)
		output("“<i>Alright, I mean, if you're okay with the knot" + kath.CockMultiple("", "s, and the twin cocks,") + " I'm okay with you giving me head...  I just feel bad leaving you with nothing.</i>”\n\n");
	else output("“<i>But... [pc.name], are you sure?  I mean, with the knot" + kath.CockMultiple("", "s... I mean, now that I have two cocks") + ", that's a lot to work with...  And I don't want to leave you with nothing, either...</i>”\n\n");
	output("You reassure her that you don't mind at all - in fact, you want to do this and probably will like doing it.\n\n");

	output("Avoiding eye contact and " + kath.catGirl("blushing bright red", "apparently blushing under the fur") + ", Katherine answers, “<i>Okay.  " + (doneBefore ? "If you want another dose, who am I to argue?  Just be careful," : "If this is really what you want.  Just please, be careful, especially") + " for your own good, okay?</i>”\n\n");

	if (kathIsAt(KLOC_KATHS_APT)) {
		output("You motion for her to sit on ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("the edge of her bed"); //Non-centaurs who are 8'6 or shorter
		else output("top of her dresser"); //Centaurs and those 8'6 or taller
	}
	else if (kathIsAt(KLOC_DESERT)) {
		output("You motion for her to sit ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("on top of a large sand dune"); //Non-centaurs who are 8'6 or shorter
		else output("near the top of a small sand dune"); //Centaurs and those 8'6 or taller
	}
	else { //Alleyway
		output("You motion for her to half-sit on a nearby ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("empty crate"); //Non-centaurs who are 8'6 or shorter
		else output("broad stone wall"); //Centaurs and those 8'6 or taller
	}
	output(".  Contrary to what she said, she seems pretty eager and, in just a few moments, you have clear vision and access to " + kath.CockMultiple("her cock and", "both her cocks as well as") + "her already-wet vagina" + (kath.ballDiameter() >= 5 ? " although her pendulous testicles obscure your view of it somewhat" : "") + ".\n\n");

	if (kath.cockTotal() == 1) {
		output("The puss' pussy is your first target, as you approach her sitting position; as your tongue slowly licks " + (kath.hasBalls() ? "her balls you gently pull them upwards and to the side" : "the underside of her cock it rises higher and higher") + ", completely revealing her increasingly moist pussy.  You tease her about getting so excited but work to please nevertheless");
		if (pc.cor() >= 70) output(" - if only to prove your skill and make the kitten ever more dependent on you for release");
		output(".\n\n");

		output("With a teasing lick, you circle around her clit and slowly move away, then back towards it.  Her cock seems to grow even harder and starts to drip pre-cum, threatening to dirty " + (kath.longestCockLength() < 10 ? "your face" : "your hair") + ".  A loud, frustrated mewl from above prompts you to start gently sucking on her clit, rewarding you with a stifled moan and the twitching of the small cat-morph's thighs.  You continue your attentions without pause, slipping the tip of your tongue inside her pussy to taste the generously flowing juices.\n\n");

		output("Deciding this part had enough attention for the moment, y" + (kath.hasBalls() ? "ou slowly move up to her balls, gently sucking each one inside your mouth.  Y" : "") + "ou allow your tongue to slide out and wrap about the lower part of her member, just below the barely recognizable thickening of her penis that marks the place where her knot will soon bulge" + (kath.knotThickness() >= 6 ? " enormously" : "") + ".  ");
		output("Katherine moans again as you slowly trace the bottom side of her penis up towards the " + kath.cockType("conical, pointy", "narrow, bumpy") + " head.  You gently suck on the tip before slipping one of your fingers inside the cat-morph's pussy.  She can't help herself and you feel her squirming, her thighs reflexively wrapping around your hand before she forcibly parts them.  Slowly, you bob your head up and down her cock" + (kath.longestCockLength() >= 14 ? ", experiencing minor problems actually deepthroating the thing" : "") + ".  All the while, you finger her pussy - your hands are positively soaked by her secretions.  Grabbing her cock with the same hand that is now coated in her own juices, you start to jerk her off as you go back down on her clit; your other hand slips inside the cat-morph.\n\n");
		output("She mewls again, clearly doing her best to resist and prolong the pleasure.  After a while of molesting her clit and cock simultaneously, you decide it's time to get somewhat more serious.\n\n");
		output("Deciding the girl's vagina is sufficiently teased for now, you move back to her erection, opening your mouth and slipping her inside.\n\n");

		//[Naga tongue]
		if (pc.tongueType == GLOBAL.TYPE_SNAKE)
			output((kath.hasBalls() ? "The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection.  You" : "You slowly move your tongue down and down her erection and") + " gently hum into it before going nearly all the way down to the base, Katherine's eyes opening wide.  Your long, flexible forked tongue slips out and down" + (kath.hasBalls() ? ", sliding along the side of her left testicle" : "") + " before finding your target: the cat-girl's clitoris.  Your other hand starts to gently tease her lower lips as you slowly move it, mostly pleasing her with your throat muscles and long, flexible tongue.\n\n");
		// [Demonic tongue]
		else if (pc.hasTongueFlag(GLOBAL.FLAG_LONG))
			output((kath.hasBalls() ? "The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection.  Stopping just before the place" : "You slowly move your [pc.tongue] down and down her erection.  When it reaches the spot") + " where her knot usually pops out, you decide to give the girl a treat.  Slowly, your incredibly long flexible tongue moves towards your kittenish partner's pussy, giving it a long, sloppy lick.  Katherine's hips shiver and she only barely stops herself from pushing them forward.  Rewarding that show of self-control, you move your tongue up to wrap it around the very base of her penis just as the entire length of your inhuman muscle slips from your mouth; you manage to get the tip of it down, then brush it against the cat-girl's vagina.  Katherine just stares at you wide-eyed as you slip your [pc.tongue] inside her pussy, effectively pleasing nearly all of her lower's body erogenous zones at once.\n\n");
		//([Normal tongue]
		else output("Your hand remains in her pussy, however, adding to the multiple ways with which you please your lover.\n\n");

		output("After a while of slurping on her cock and ");
		if (pc.tongueType == GLOBAL.TYPE_SNAKE) output("molesting her clit with your tongue");
		else if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("penetrating her with your [pc.tongue] as you give her head");
		else output("fingering her");
		if (!kath.hasBalls())
			output(", you pull away for a moment and");
		output(", you decide it's time to slightly change tactics in order not to humiliate the girl by making her blow her load too quickly.  The cat-herm's balls have been largely ignored so far, and you decide to amend that, slowly withdrawing from your blowjob and sinking your mouth down to her testicles.  You lick them softly before sucking one inside your mouth.\n\n");
		//([Snake tongue]
		if (pc.tongueType == GLOBAL.TYPE_SNAKE) {
			output("Balls or no balls in the way, you find it pretty easy to mercilessly toy with the girl's pussy using your long tongue.  You can easily tease her clit and even slip the tip inside, flicking at the sides of her inner walls as she purrs with delight at the gentler attentions and occasionally releases a silent moan.  You stroke her cock at the base - this thing will have to wait for more attention.\n\n");
			output("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n");
		}
		//[Demon Tongue]
		else if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) {
			output("You can feel Katherine shiver with helpless desire once she feels your excessively long tongue sliding over her balls.  You slide it upwards, teasing the knot area of her member, and then back down, oozing it over the poor kitten's clitoris and completely smothering it with your tongue.  Finally, you slip it inside as Katherine releases a loud scream of pleasure, then bites her own hand to silence herself.\n\n");

			output("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n");
		}
		//{([Normal Tongue]
		else {
			if (kath.ballDiameter() <= 1) output("You find it pretty easy to slip your tongue out further and gently lick her clit almost all the time while you're doing it.");
			else if (kath.ballDiameter() <= 2) output("You can sometimes reach her pussy while toying with her balls, teasing it with your tongue.");
			else output("You hoped to play with her pussy too, but the cat-girl's balls are too sizeable to do so with your tongue.  You can almost feel, maybe even hear the semen sloshing inside the big things, ready to shoot out any second.");

			output("\n\nYou gently slide your fingers over the tip of her cock while teabagging her, but you don't want to give her an overload of sensations yet.\n\n");
		}

		output("After molesting her with your tongue you pull away for a moment and announce that the cat-girl is very welcome to cum soon, " + (doneBefore ? "as you're happy to do this to her again and again" : "since this probably won't be a one time offer and she doesn't have to postpone things so desperately") + ".\n\n");

		output("“<i>Thank you,</i>” she gasps before mewling, a small trickle of drool running down her chin.  Somehow, she looks too adorable for you to point that out.  “<i>Ummm... I don't know how you want to finish, but... watch the knot, okay?  This is really amazing and it'd be such a waste if you were to harm yourself... I get the feeling that it'll start to bulge out really soon.</i>”\n\n");

		output("You nod, before considering how exactly you will seal the deal and have the cat-girl get off.\n\n");

		//([Naga tongue]
		if (pc.tongueType == GLOBAL.TYPE_SNAKE) {
			output("With a smirk, you grab her cock around the base and lick your lips as Katherine shivers in anticipation.  Without much care for safety, you dive in, deep-throating the kitten up to the point where your lips meet your fingers.  It isn't the easiest thing you've ever done, but while having her deep down your throat you can extend your tongue far enough to lick her clit again.  The cat-girl is ecstatic at your simultaneous attentions.\n\n");

			output("Soon, you feel the telltale signs of her orgasm appearing.  Katherine is panting loudly, unable to control herself; her knot is bulging out and her pussy is getting wetter and wetter.");
			//([Katherine's knot is 6 inches wide]
			if (kath.knotThickness() >= 6) output("  Regrettably, the cat-girl's bulging knot makes it a lot harder to please her pussy with your long tongue in this position than you'd hoped, and you have to give it up once she's completely swollen.");
			//([Player has a naga tail]
			if (pc.isNaga()) output("  You decide to play the part of the snake to the very end and, not content to leave her pussy unattended, you slip the tip of your long tail inside her.  She groans in ecstasy, finally reaching orgasm.");
			else output("  Not content to let her pussy remain unattended, you slip two of your fingers inside her while teasing her clit with your knuckle.  She seems greatly pleased at your attention, as she shivers in orgasm moments afterwards.");

			output("\n\nYour " + (pc.isNaga() ? "tail" : "fingers") + " get squeezed and drenched while you feel her erection twitch and pulse within your mouth.  You complete your motion, diving to the very verge of her knot and sucking on her intensely as she blows her seed into your mouth and down your throat.\n\n");

			output("You greedily swallow your hermaphrodite lover's semen; ");
			if (kath.cumQ() <= 500) output("its quite a large amount given " + (kath.hasBalls() ? "the size of her balls" : "that she doesn't have testicles") + ", substituting for a decent warm drink at least.");
			else if (kath.cumQ() <= 1500) output("you can feel thick, generous ropes of her jizz flow into your mouth and down your throat between smaller trickles.  Her orgasm is rather intense and leaves you quite full.");
			else output((kath.hasBalls() ? "as suggested by the size of her testicles," : "her prostate must have been working overtime, as") + " Katherine cums - a lot.  Wave after wave of semen gushes down your throat, filling your belly to the point of stretching.");
			output("  Slowly, you pull her cock out of your mouth while Katherine smiles at you and purrs gratefully.");
		}
		//(Demon tongue)
		else if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) {
			output("You separate the place where the knot should appear with your own fingers and dive down her shaft.  You're going to pleasure most of her anyway, as you repeat your trick, wrapping your [pc.tongue] around the base of her cock with your other hand as your long appendage slides out to lick and play with her " + (kath.hasBalls() ? "balls.  Sliding it along her testicles" : "clit.  That") + " seems to start igniting her orgasm - the bulge of her knot gets bigger, although it looks like you have a few moments.  You slide down further, " + (kath.hasBalls() ? "rolling her balls and then lifting them to push" : "pushing") + " the tip of your tongue inside her pussy.  You can taste her feminine juices dripping out as her vagina starts to clench, her inner walls twitching and her knot bulging to full size");
			//([If 6 inches knot]
			if (kath.knotThickness() >= 6) output(", even making it hard for you to keep your tongue buried all the way inside");
			output(".\n\n");

			output("With a loud yowl, she cums, her pussy clenching around your [pc.tongue] and her penis twitching in your mouth.\n\n");

			if (kath.cumQ() <= 500) output("She practically thrashes around in orgasm as you tease her " + (kath.hasBalls() ? "balls" : "clit") + " with your tongue, your mouth milking her and devouring the cum she releases quite easily.");
			else if (kath.cumQ() <= 1500) output("Your tongue has no problems sliding across and teasing her " + (kath.hasBalls() ? "balls" : "clit") + " as your mouth drinks her dick-milk.  There is quite a lot of it, but you don't complain.");
			else output("Katherine's " + (kath.hasBalls() ? "large testicles quiver on your tongue as they discharge their" : "prostate must have been working overtime to produce such a massive") + " load.  You can feel it seeping inside you, slightly stretching your belly as you struggle to swallow it all.");
			output("  All the while, her pussy rhythmically squeezes your tongue and covers it with girl-cum.\n\n");

			output("Once she's done climaxing, you allow her member to slide out of your mouth before rolling your tongue along her pussy, drinking her feminine juices.  Her initial yowl turns into soft purring as you delicately finish her up.");
		}
		//([Normal tongue]
		else {
			output("Deciding to follow her advice, you dive down to the girl's soaking-wet vagina" + (kath.hasBalls() ? ", gently fondling her testicles as you softly roll them in your hand" : "") + ".  You start eating her out, licking her insides, and teasing her clit as your other hand jerks your hermaphrodite cat lover off.\n\n");

			output("You can feel your hand starting to hit some resistance and you realize her knot is starting to surge with blood.  Taking advantage of the moment while you can, you drink her copious feminine juices while your tongue explores the inner walls of the kitty-cunt, then slightly increase your pace above.  With a lot of panting, a mewl and then a growl of ecstasy the cat-girl drenches your face as her pussy wraps tighter around your tongue, her semen flying out of her cock and landing all over your hair and your backside.  Her thighs shiver as she closes them around your head, unable to let you go.");
			if (kath.cumQ() > 1500) output("  You can't help but giggle into the cat-girl's pussy as you feel her drench you with her seed, painting you white.");
		}
	}
	//Double Cock Scene
	else {
		output("Seeing one of her cocks bob and twitch as your face gets closer you decide to reward the eagerness and start with it.  You open your lips and lick the tip before slowly sliding down her crown and then lower, onto the shaft and down to the base.  Then, you pull your lips up, assaulting her with your tongue all along the way.  Her " + kath.cockType() + " cock leaves your mouth with a loud slurp and you quickly go down the other one.  Katherine strokes your [pc.hair], very gently helping push you down her shaft.\n\n");

		output("Her hands are actually in the way of what you have planned; with a glare you quickly tell her to let you do it your way.  Katherine mewls apologetically as you grab her erections with both hands and rub them up, down, and together, licking the touching tips with your tongue.");
		if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("  Said tongue wraps around one erection and then the other, stroking gently with its long, flexible length.");
		output("\n\n");

		output("Next you move down from her erections, ");
		if (kath.hasBalls()) {
			output("giving her balls a teasing lick before sucking one of them inside your mouth.");
			if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("  Your long, flexible tongue once again slides out as you gently lift her testes up, easily dipping inside her wet pussy and stroking her inner walls as you suck.");
			output("  You continue to minister to her balls, wrapping your fingers around her straining cocks, jerking them off slowly before nudging the balls up and diving into her wet pussy.\n\nYour");
		}
		else output("your");
		output(" work here starts with soft kisses on her lower lips, and then slowly moves up to her clit.  Katherine's thighs gently bend as her feet rest on your shoulders, egging you on to give more attention to her drenched pussy.  You humor her, tongue sliding inside her as you suck on her clit while slowly jerking off both of her erections.  Her feminine juices start flowing even more freely - you find yourself suffused with almost as much taste as sound from her soft panting and moaning.\n\n");

		//([Demon tongue]
		if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("The opportunity for some extra service doesn't escape you; you suck her clit in with your lips as the long, prehensile organ you house in your mouth slides up against " + (kath.hasBalls() ? "her balls, rolling them and assaulting " : "") + "the base of one of her erections, slowly wrapping around it.  After getting a good tongue-grip on it, you slither further around and past it to do the same to her other cock.  Then, slowly, you start to stroke the twin canine penises with the wet muscle, causing Katherine to shake with helpless pleasure.  Continuing to suck on her clit meanwhile, your large flexible tongue also gives her twin penises a dream jerk-off.\n\n");

		output("Slowly, you draw away from her, admiring your handiwork.  Katherine's erections are leaking pre-cum generously, while her pussy is drenching her seat and trickling copious fluid onto " + (kath.hasBalls() ? "the underside of her balls.  Her thighs" : "her thighs.  Those") + " are gently shaking and her stare lacks focus.\n\n");

		output("“<i>Umm... please, continue.  I'm so close...</i>”\n\n");

		output("You press your fingers against her pussy and start to finger her, at first gently, then at an increasing pace.  Then, you bend down to again suck on a throbbing erection as you gently stroke her members, alternating between one and the other.  You lift your lips from one penis and then dive down the other, going down and down, massaging her member with your throat muscles while sliding your tongue across the back of her penis.  While deepthroating, you suddenly feel something press against your jaw.  Quickly, you withdraw before the knot bulges out of control.  It swells as you pull out, but slows down, lacking the stimulation to reach ejaculation and therefore maximum size.\n\n");

		output("She pants and whimpers at the lost stimulation, hands barely restrained from grabbing the reins herself and capping your efforts.  “<i>P... please!  I'm almost there!</i>”  Not willing to make her suffer, you decide to finish the job and make your kitten cum.\n\n");

		//([Normal/Naga Tongue]
		if (!pc.hasTongueFlag(GLOBAL.FLAG_LONG)) {
			output("You wrap both your hands around her members just above the knot and start stroking her off, aiming them both at your mouth as you lick the tips.  Her knots swell to full size as she starts panting.");
			//([If the character has a naga lower body or a demon tail]
			if (pc.isNaga() || pc.tailType == GLOBAL.TYPE_DEMONIC || pc.hasTailCock()) output("  Wanting to grant her maximum stimulation and complete release, you slip the tip of your tail inside the cat-girl, feeling her pussy gratefully squeeze it.");
			output("\n\n");

			output("Moments later, Katherine finally ejaculates, over your face and inside your mouth.");
			if (kath.cumQ() > 1500) output("  There's quite a lot of it, so you manage to get both a kinky bath and a decent warm drink.");
		}
		else {
			output("Your tongue quickly slides out of your mouth, twitching sinuously as Katherine's eyes go wide at the sight of it easily wrapping around both her erections.  You" + (kath.hasBalls() ? "r hand starts playing with her balls as the other fingers" : " start fingering") + " her dripping wet cunt, pumping in and out as you feel her knots swell larger under your tongue.\n\n");

			output("Her erections release in unison, and thick rivulets of semen cover your face, tongue and even the inside of your mouth.  Her " + (kath.hasBalls() ? "testicles twitch and pulse in your hand as her" : "") + " cunt grabs tightly at your fingers, covering them with her girlcum.");
			if (kath.cumQ() > 1500) output("  The two of you are liberally coated with her spunk, your stroking tongue unable to catch all of it as she shoots off.");
		}
	}
	// All scenes (both single and double cock) end here
	output("\n\nThe deed done, you straighten your back and wink at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.\n\n");
	output("“<i>You were amazing!</i>” she exclaims, still short on breath.  ");
	if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("She runs her fingers along your lips.  “<i>I think I might be falling in love with the monster inside that pretty cave.</i>”\n\n");
	else output("“<i>I hope that if I ever get to repay the favor, I can do as well as you.</i>”\n\n");

	output("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately; separating yourself from the cat-herm with a kiss, " + (kathIsAt(KLOC_DESERT) ? "you pack up the supplies and prepare for the trip back to Tel’Adre." : "you go your separate ways."));
	processTime(15);
	pc.loadInMouth(kath);
	kath.orgasm(); //minus lust, slimefeed, Player returns to camp
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_TRIED_RECEIVE_ORAL"] = 1;
	pc.lust(25);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

public function giveKatOralPussyLicking():void { //This version assumes Kath has no cock
	//Scene can happen in the streets, at Kath's apartment or in the Desert
	clearOutput();
	output("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n");
	output("“<i>Alright, I mean, it's not like I'm going to refuse.</i>”\n\n");

	if (kathIsAt(KLOC_KATHS_APT)) {
		output("You motion for her to sit on ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("the edge of her bed"); //Non-centaurs who are 8'6 or shorter
		else output("top of her dresser"); //Centaurs and those 8'6 or taller
	}
	else if (kathIsAt(KLOC_DESERT)) {
		output("You motion for her to sit ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("on top of a large sand dune"); //Non-centaurs who are 8'6 or shorter
		else output("near the top of a small sand dune"); //Centaurs and those 8'6 or taller
	}
	else { //Alleyway
		output("You motion for her to half-sit on a nearby ");
		if (!pc.isTaur() && pc.tallness < 102)
			output("empty crate"); //Non-centaurs who are 8'6 or shorter
		else output("broad stone wall"); //Centaurs and those 8'6 or taller
	}
	output(".  She seems pretty eager and, in just a few moments, you have clear vision and access to her already-wet vagina.\n\n");

	output("You attack the puss' pussy, your tongue slowly licking her outer lips, relaxing her increasingly moist pussy.  You tease her about getting so excited but work to please nevertheless");
	if (pc.cor() >= 70) output(" - if only to prove your skill and make the kitten ever more dependent on you for release");
	output(".\n\n");

	output("With a teasing lick, you circle around her clit and slowly move away, then back towards it.  A loud, frustrated mewl from above prompts you to start gently sucking on her clit, rewarding you with a stifled moan and the twitching of the small cat-morph's thighs.  You continue your attentions without pause, slipping the tip of your tongue inside her pussy to taste the generously flowing juices.\n\n");
	
	output("Your fingers pry open her thighs and then her tender pink passage, allowing you to push your tongue even deeper.  As her head rolls back and forth you slide your hands up her belly and gently massage her breasts.\n\n");

	output("She mewls again, clearly doing her best to resist and prolong the pleasure.  You decide it's time to get somewhat more serious.\n\n");

	if (pc.hasTongueFlag(GLOBAL.FLAG_LONG))
		output("You finally make full use of your long, flexible tongue.  You tighten the abnormal muscles and slip it all the way in, the tip bumping against the back of her vagina even as the base of your [pc.tongue] undulates against the underside of her clit.\n\n");
	else output("You press your [pc.tongue] against the underside of her clit and rock it from side to side, your tastebuds dragging against her most sensitive flesh.\n\n");

	output("After molesting her clit with your tongue you pull away for a moment and announce that the cat-girl is very welcome to cum soon, as you're happy to do this to her again and again.\n\n");

	output("“<i>Thank you,</i>” she gasps before mewling, a small trickle of drool running down her chin.  Somehow, she looks too adorable for you to point that out.</i>”\n\n");

	output("Deciding it's time to finish her off, you dive down to the girl's soaking-wet vagina.  You start eating her out, licking her insides, and teasing her clit as your hands go back to rubbing her nipples.\n\n");

	output("With a lot of panting, a mewl and then a growl of ecstasy the cat-girl drenches your face as her pussy wraps tighter around your tongue.  Her thighs shiver as she closes them around your head, unable to let you go.");

	output("\n\nThe deed done, you straighten your back and wink at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.\n\n");
	output("“<i>You were amazing!</i>” she exclaims, still short on breath.  ");
	if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("She runs her fingers along your lips.  “<i>I think I might be falling in love with the monster inside that pretty cave.</i>”\n\n");
	else output("“<i>I hope that if I ever get to repay the favor, I can do as well as you.</i>”\n\n");

	output("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately; separating yourself from the cat-herm with a kiss, " + (kathIsAt(KLOC_DESERT) ? "you pack up the supplies and prepare for the trip back to Tel’Adre." : "you go your separate ways."));
	processTime(15);
	pc.girlCumInMouth(kath);
	kath.orgasm(); //minus lust, slimefeed, Player returns to camp
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	pc.lust(25);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Katherine performs Oral on PC:
private function katherineGivesPCOralAllDayLongDotJPG():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	output("You tell Katherine you'd like to see what she can do with her [kath.tongue].  The black cat blinks in surprise, then grins widely.  “<i>Well, that can be arranged...</i>”  She purrs, taking you by the arm and " + (kathIsAt(KLOC_KATHS_APT) ? "guiding you to her bed" : "leading you around to a specific crate") + ".  Once you are seated and both of you are naked, she kneels in front of you.  “<i>Now, let's see what you have, my dear...</i>” she says, tail waving in the way that only a happy cat's does.\n\n");
	clearMenu();
	if (pc.hasCock() && (!pc.hasVagina() || rand(2) == 0)) addButton(0, "Next", katherineLicksAllTheBoyPenises);
	else addButton(0, "Next", katherineGoesDownOnTheGirlsOhYahBabyLesbo);
}

//[Female]
private function katherineGoesDownOnTheGirlsOhYahBabyLesbo():void {
	clearOutput();
	//output(images.showImage("katherine-eats-out-your-vagoo"));
	output("She gently strokes the lips of your [pc.vagina], then leans in and gives it a deep, wet lick.  You can't restrain a shiver at the sensation; Katherine's tongue is unlike anything you've seen in this world so far, broad and bristly, but not so hard that it hurts.  It's like lots of little tongues all licking you at the same time.\n\n");

	output("Without hesitation, she licks you again, and again, deep strokes that slide up from the very base of your cunny all the way to the tip, lingering on your [pc.clit] and teasing your lovebutton.  You can't help but wrap your " + pc.legs() + " around her head and pull her into your crotch, thrusting her face right into your cunt.\n\n");

	output("If this bothers Katherine, though, she gives no sign; she just keeps licking and lapping, eagerly slurping her way into your depths.  You buck and thrash at her ministrations; the sensations of that rough tongue all over your insides are indescribable; like rough fingertips but hundreds of times more probing!  Finally, you can't hold it any more and cry out as orgasm washes through you, deluging femcum into Katherine's thirsty maw, even as she strives to lap it up like a cat with a bowl of cream.\n\n");
	
	if (pc.cocks.length > 0)
		output("At the same time your cock" + (pc.cocks.length > 1 ? "s release their" : " releases its") + " load into the air, causing semen to rain down on the pair of you.\n\n");

	output("Your pleasure finished, you release her, gasping for breath as she daintly wipes her face clean with her fingers.  “<i>Was it good for you?</i>” she asks, mischief in her eyes.  When you reply, she smirks.  “<i>Did you expect a pussy to be good at eating a pussy?</i>”\n\n");

	output("You simply groan at the absolutely terrible pun and get back up, redressing yourself and heading back into the streets after a quick peck to thank her for the time.");
	processTime(15);
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	kath.girlCumInMouth(pc);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[Male/Herm]
private function katherineLicksAllTheBoyPenises():void {
	var x:Number = pc.biggestCockIndex();
	clearOutput();
	//output(images.showImage("katherine-gives-you-blowjobs/"));
	output("She takes your shaft eagerly, gently stroking it with her fingers to coax it erect, then leaning in to lick the head with her softly bristled tongue, caressing and suckling at the [pc.cockHead " + x + "].");
	if(pc.hasVagina()) {
		output("  One of her hands slides down your shaft");
		if(pc.balls > 0) output(", past your [pc.balls],");
		output(" and gently begins to stroke your cunny, twiddling her fingers to heighten your pleasure by manipulating both sets of organs at once.");
	}
	output("\n\n");

	output("Once your pre starts to flow, she fully leans in and swallows as much of your shaft as she can, her inhuman tongue stroking and caressing in ways you couldn't have imagined.");
	if(pc.hasVagina()) {
		output("  She plunges her fingers into your cunt at the same time, to heighten the experience.");
	}
	output("  With a surprising amount of skin in her mouth, she starts to bob and suckle, confining your member in the hot, tight, wetness, her tongue keeping up its ministrations.  She starts to purr with delight, sending the most delicious vibrations rippling through your member.");
	if(pc.hasVagina()) {
		output("  Her fingers stroke and piston inside you with the synchronicity only another hermaphrodite could have perfected, rolling your [pc.clit] and sending further sparks of pleasure coursing through your brain.");
	}
	output("\n\n");

	output("Your resistance is minimal in the face of such pleasure; all too soon, you feel your ");
	if(pc.balls == 0) output("cock tingling");
	else output("balls tightening");
	output(" as your release becomes imminent.  Without further ado, you erupt inside the eager cat-herm's mouth, making her hungrily gulp down as much of your seed as she can.");
	if(pc.cumQ() <= 250) output("  She drinks every last drop with relief, popping wetly off of your cock and licking her lips, audibly purring with delight.");
	else if(pc.cumQ() <= 600) output("  She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.");
	else output("  You can see a hint of panic in her eyes at the titanic cascade of fluids coming from your [pc.cock " + x + "], but it's drowned out by her determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to hold on without taking the cock out of her mouth before you're finished.  Afterward, she detaches herself breathlessly from your cock and gives you a triumphant expression, and a faint burp.");
	output("\n\n");

	output("Weakly, she collapses onto her " + kath.catGirl("smooth", "furry") + "  behind on the ground, smiling up at you.  “<i>I take it you enjoyed that?</i>” she teases.  You admit she did very well, " + (kathIsAt(KLOC_KATHS_APT) ? "gently stroking her hair in thanks" : "helping her up and to her own 'bed'") + ", then get dressed and head back out into Tel'Adre's streets.");
	//lust -100 regardless of sex, return to wherever
	processTime(15);
	kath.loadInMouth(pc);
	pc.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Suckle
private function suckleMenu():void {
	clearMenu();
	addButton(0, "She Suckles", suckleTacularKats);
	addButton(1, "You Suckle", suckleFromKath);
	addButton(14, "Back", katSexMenu);
}

private function suckleFromKath():void {
	//Scene can happen in the streets, in a backroom at the bar or at Kath's apartment
	clearOutput();
	output("You give Kath a smile and ask if there's anything she'd like to 'get off her chest'.\n\n");
	if (kathIsAt(KLOC_BAR)) {
		output("She understands instantly and smiles back, her hands shifting subconsciously to cup her ");
	}
	else if (kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) {
		output("It takes a few seconds for her booze addled mind to figure out what you mean, at which point she grabs her ");
	}
	else if (kathIsAt(KLOC_KATHS_APT)) {
		output("She grins and makes a show of cupping her ");
	}
	else { //She must have been on patrol
		output("She looks up and down the alley before sitting on a convenient crate.  Her hands shift subconsciously to cup her ");
	}
	
	if (!kath.canLactate()) {
		output(" [kath.breasts].\n\n");
		if (flags["COC.KBIT_MILK_TOLD_PLAYER_SHES_DRY"] == undefined) {
			output("“<i>I'm sorry " + kathPlayerText() + ", I've kind of run out.  I didn't even notice I was drying up and then one day my breasts just didn't feel as full.</i>”\n\n");
			output("She looks worried, probably afraid you'll be unhappy with her, but then she brightens up and adds, ");
			flags["COC.KBIT_MILK_TOLD_PLAYER_SHES_DRY"] = 1; //Now she's apologized
		}
		output("“<i>I'm sure that if you suckle from me enough my breasts will get the hint and I'll start making cream for you again.</i>”\n\n");
	}
	else if (kath.milkFullness >= 100) {
		if (kath.milkMultiplier >= 100) {
			output(" [kath.breasts].\n\n");
			output("You can see the telltale stains from where Katherine's breasts have leaked some of their massive load.  Your favorite " + kath.catGirl("cat girl", "kitty") + " even smells like cream.\n\n");
			output("“<i>Yes, yes, yes!  Oh, " + kathPlayerText() + " I'm so full.  I'm stuffed with cream and it's all because of you.  Please " + (flags["COC.KBIT_SUB_CALL_MASTER"] == 1 ? "drain me, [pc.master], don't leave me like this." : "help me.") + "</i>”\n\n");
		}
		else {
			output(" [kath.breasts].\n\n");
			output("“<i>Oh thank you!  I need this, I'm always so full.  If I had any more milk saved up I'd almost need to feed it to someone.</i>”\n\n");
		}
	}
	else if (kath.milkFullness > 50) {
		output(" [kath.breasts].\n\n");
		output("“<i>Mmmm - I've been hoping you'd stop by.  When my breasts fill up my nipples get stiff and sensitive, like they want some attention.</i>”\n\n");
	}
	else {
		output(" [kath.breasts].\n\n");
		output("“<i>I don't really <b>need</b> a milking... but I'll never turn you down" + (flags["COC.KBIT_SUB_CALL_MASTER"] == 1 ? ", [pc.master]" : "") + " - especially when you're offering to suck on my nipples.</i>”\n\n");
	}
	
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) {
		output("You get up and move to Katherine's side of the booth.  Before you can even sit down Kath has begun removing her top.  The flicking of Kath's tail tells you how excited she is as she finally removes her bra and exposes her chest.\n\n");
	}
	else if (kathIsAt(KLOC_KATHS_APT)) {
		output("Kath puts on a little show as she removes her top.  The flicking of Kath's tail tells you how excited she is as she finally removes her bra and exposes her chest.\n\n");
	}
	else { //She must have been on patrol
		output("Kath pulls off her breastplate and gives you another smile.  You can tell she's a little worried at being caught feeding you, even though this can't even be close to the raunchiest thing Tel'Adre's citizens have seen on their streets.  At last her bra comes off and her breasts hang free in the open air.\n\n");
	}
	
	if (pc.cor() < 25) {
		output("Gently, you guide Kath's hands to her sides.  She leans back, content to let you take the lead.  You hold her breasts in your hands and stroke her nipples with your thumbs.  They were erect to begin with, but now they turn a deeper pink, begging for more attention.  When you seal your lips against her " + (rand(2) == 0 ? "left" : "right") + " nipple Kath closes her eyes and purrs.\n\n");
		output("You massage her [kath.breasts], ");
		if (!kath.canLactate()) {
			output("sucking gently.  If you keep this up then hopefully someday soon Kath's breasts will fill with even more cream.");
		}
		else if (kath.lactationQ() > 500) {
			output("coaxing them to relax and release their thick, creamy treasure.  You keep drinking and drinking, amazed at the quantities of cream Katherine can produce.");
			if (kath.lactationQ() > 750) output("  Sure that you'll be unable to drink it all you switch to her other nipple before the first has run dry.");
		}
		else {
			output("coaxing them to relax and release their thick, creamy treasure.  You keep drinking and drinking, trying to enjoy every drop Katherine can produce.");
		}
		output("\n\nFor her part Kath just purrs and enjoys your ministrations, oblivious to the world around her.\n\n");
	}
	else if (pc.cor() < 75) {
		output("Eager to begin you push Kath's hands away and replace them with your own.  She leans back, her eyes begging for more.  You rub her nipples and give her breasts a little squeeze" + (kath.isLactating() ? ", watching the creamy droplets cascade from her bosom.  You give her a devilish grin and fix" : " before fixing") + " your lips to her " + (rand(2) == 0 ? "left" : "right") + " nipple.  Kath sighs as you begin to suckle.\n\n");
		output("You stroke her [kath.breasts]");
		if (!kath.canLactate()) {
			output(" and suck vigorously, keen to bring back her heavenly cream.\n\n");
		}
		else if (kath.lactationQ() > 500) {
			output(" and suck vigorously, keen to draw out every bit of her creamy goodness.  Katherine's heavy teats give you more than you can handle.");
			if (kath.lactationQ() > 750) output("  Sure that you'll be unable to drink it all you switch to her other nipple before the first has run dry.");
		}
		else {
			output(" and suck vigorously, keen to draw out every bit of her creamy goodness.  Katherine's heavy teats give you all you desire and you use your tongue to show your appreciation.");
		}
		output("\n\nFor her part Kath just lets out little 'Oh's and 'Ah's when you're less gentle.  She's definitely enjoying herself and seems oblivious to the world around her.\n\n");
	}
	else {
		output("You grab her hands and press them against her sides, letting Kath know you're in charge.  ");
		if (!kath.canLactate()) {
			output("So her body decided to stop making cream, did it?  You know how to fix that!  You start rolling her nipples between your thumbs and fingers, yanking and pinching hard enough to draw little mewls from Katherine.  You knead her titflesh to remind her what it's for.  Finally you latch on to her " + (rand(2) == 0 ? "left" : "right") + " nipple and begin to suck - hard.\n\n");
			output("You kneed her [kath.breasts], hoping that with enough abuse you can force them to start producing again.\n\n");
		}
		else if (kath.lactationQ() > 500) {
			output("You cup her heavy breasts and give them a squeeze to get things moving.  ");
			if (kath.lactationQ() > 750) {
				output("A surprisingly large cascade of cream flows over your hands and dribbles down her front.  Kath mewls and you decide to see what these mammaries can do.  A harder and more deliberate squeeze yields another flood of cream, drenching Kath and her clothes.  You laugh and latch");
			}
			else {
				output("A decent stream of cream flows over your hands and dribbles down her front.  Kath mewls and you try a harder and more deliberate squeeze, but the results are no more impressive than before.  Still, it smells nice, so you give Kath's nipples a good hard pinch before latching");
			}
			output(" onto her " + (rand(2) == 0 ? "left" : "right") + " nipple, ready to begin your feast in earnest.\n\n");
			output("You kneed her [kath.breasts] to force the creamy goodness into your mouth.");
			if (kath.lactationQ() > 750) output("  You're pleased by Kath's milk production, her overactive mammaries hold more cream than you can handle.  You let the cream run from the corners of your mouth, draining every drop, encouraging Kath's breasts to keep up their good work.");
		}
		else {
			output("You cup her breasts and give them a squeeze to get things moving.  A few drops of kitty cream appear on the tips of her nipples which you lick off with your tongue.  Katherine sighs contentedly, so you give her nipples a good hard pinch to remind her who she's dealing with.  She lets out a cute little mewl and you latch onto her " + (rand(2) == 0 ? "left" : "right") + " nipple, ready to begin your feast in earnest.\n\n");
			output("You kneed her [kath.breasts] to force the creamy goodness into your mouth and Kath's succulent nipples do not disappoint.");
		}
		output("\n\nKath squirms and mewls plaintively, but you won't slow down.  She needs to learn her place and besides, you know that feelings of pain and pleasure are intertwined.  After a while Kath relaxes and the tone of her mewls shifts down an octave.  You submissive kitten is finally enjoying herself, so you nibble on her teat to show your approval.\n\n");
	}
	
	var wasntLactating:Boolean = !kath.canLactate();
	kath.boostLactation(5);
	if (kath.canLactate() && wasntLactating) {
		output("Just as you're winding down you taste a hint of cream on your tongue.  After suckling a little longer you're sure; Katherine has started producing milk again.\n\n");
		output("In a drowsy, blissful tone Kath says, “<i>Mmmm, you wanted my cream?  I'm happy to oblige.</i>”\n\n");
		output("To make sure she doesn't dry up you suckle for a few more minutes, switching from nipple to nipple while your fingers tease the sensitive undersides of her [kath.breasts].");
	}
	
	output("When you finally pull away Kath sighs contentedly.  “<i>Thank" + (flags["COC.KBIT_SUB_CALL_MASTER"] == 1 ? " you [pc.master]" : "s [pc.name]"));
	if (!kath.canLactate()) {
		output(", I hope I start making milk again, it's a shame you don't get a reward for all that effort,</i>” she says, rubbing her sore nipples" + (kathIsAt(KLOC_KATHS_APT) ? "" : " before covering herself up") + ".");
		if (kathIsAt(KLOC_KATHS_APT)) output("It doesn't take long before her head starts to droop and her whole body follows it toward the mattress.\n\n");
	}
	else if (kath.lactationQ() > 750) {
		output(", that was just what I needed,</i>” she mumbles before falling asleep.");
		if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) {
			if (pc.cor() < 75)
				output("  You hug Kath close so she's not flashing her assets to everyone in the wet bitch.");
			else output("  You leave her breasts exposed and shift her shoulders so her chest is on display for all to see.  You get a few appreciative smiles and some raised glasses as the patrons commit Kath's [kath.breasts] to memory.");
			output("  After a little catnap she comes around and takes in the bar.  She puts her top back on" + (pc.cor() < 75 ? "" : ", looking a little sheepish") + ".\n\n");
		}
		else if (kathIsAt(KLOC_KATHS_APT)) {
			output("\n\n");
		}
		else { //Alleyway, on duty
			output("  Since she's on duty you have to nudge her awake.  She looks confused and disoriented until you press her breastplate into her hands.  Realization dawns and Katherine quickly redresses in her uniform.\n\n");
		}
	}
	else if (kath.lactationQ() > 500) {
		output(", that was just what I needed,</i>” she says, sounding tired but happy none the less.");
		if (!kathIsAt(KLOC_KATHS_APT)) output("  After about a minute she remembers her modesty and covers herself up.\n\n");
	}
	else {
		output(", that was just what I wanted,</i>” she says, as she " + (kathIsAt(KLOC_KATHS_APT) ? "" : "covers up and ") + "snuggles up against you.\n\n");
		if (kathIsAt(KLOC_KATHS_APT)) output("It doesn't take long before her head starts to droop and her whole body follows it toward the mattress.\n\n");
	}
	
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) {
		if (hours >= 8 && hours <= 16 && flags["COC.NIAMH_STATUS"] == undefined)
			output("You notice " + (Flag("COC.MET_NIAMH") == 0 ? "the huge breasted cat girl" : "Niamh") + " rubbing her own mammaries enviously.  ");
		output("Unfortunately you have places to be, portals to check on.  You give Katherine a kiss and her tail a little stroke before heading back to camp.");
	}
	else if (kathIsAt(KLOC_KATHS_APT)) {
		output("You smile as your lover, still partially naked, slowly uncurls onto the bed.  She looks so peaceful and innocent.\n\n");
	}
	else { //Alleyway, on duty
		output("When she sees one of the other members of her patrol at the end of the alley she hops to her feet, grabs her stuff and gives you a quick peck on the cheek.  As she leaves she says, “<i>Gotta run - but thanks again.  Stop by at the bar, my place, somewhere, just please see me again soon.</i>”\n\n");
	}
	processTime(15);
	pc.milkInMouth(kath);
	kath.milked();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//PC must lactate to have this option
private function suckleTacularKats():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	//output(images.showImage("katherine-suckles-you"));
	output("Feeling your [pc.chest] and the milky goodness within, you ask Katherine if she likes milk the way her fellows do.  When the cat-morph gives you a puzzled look, you remove the upper part of your [pc.gear] and, fondling your tits with a smirk, tell her that you could use a little relief.\n\n");

	output("Katherine's eyes widen with shock, and she smiles in disbelieving delight, ");
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("moving to your side of the bench.  She cups your breasts and lifts them to get a sense of how much milk you've got stored up.  “<i>Of course I love milk.  What a silly question - and you know I love your milk most of all, " + kathPlayerText()  + "</i>”\n\n");
		output("Katherine starts to play with your nipples and runs her " + kath.catGirl("smooth fingers", "finger pads") + " over your breasts, causing a trickle of [pc.milk] to leak out.\n\n");
		output("Not wanting to wait any longer you");
	}
	else {
		output("quickly striding over and waiting, impatiently, as you " + (kathIsAt(KLOC_KATHS_APT) ? "position yourself on her bed" : "find a comfortable position and sit down") + ".  Once you have, she wastes no time in plopping down in front of you.  She nuzzles her cheek against your breast but then, to your amazement, shyly backs away.\n\n");
		output("“<i>I... um... is this really okay?</i>” she asks, her voice barely above a whisper.  With a hint of exasperation you roll your [pc.eyes] and");
	}
	output(" gently take her by the cheeks, insistently bringing her head close so that her lips are bumping right against your [pc.nipples].  She takes the obvious hint and eagerly swallows it, eyes closing as she leans in and starts to suckle.  Purring with contentment, she sends the most delicious vibrations into your breasts, her rough, bristly tongue stroking and caressing to help coax your body into giving up its [pc.milk].\n\n");

	output("You're not sure how long you sit there with her in your arms, just listening to her purr as she quietly sucks and slurps, drinking everything you have to give.  She ");
	if (pc.lactationQ() < 1000) output("empties");
	else output("does her best to empty");
	output(" your first breast, and then moves to the next one.  Finally, she's drunk ");
	if (pc.lactationQ() < 1000) output("you dry");
	else output("so much of your seemingly inexhaustible supply of milk that she's physically incapable of drinking any more");
	output(", and she lets your nipple go with a loud pop.");
	if (pc.lactationQ() < 500) {}
	else if (pc.lactationQ() < 1000) output("  She is sporting an unmistakable milk-belly from all she's drunk.");
	else if (pc.lactationQ() < 2000) output("  She looks almost pregnant with how much she's drunk, but she doesn't seem to care.");
	else output("  Katherine looks more like a balloon than a cat, her belly swollen hugely from her titanic liquid repast.  You can hear her stomach's contents sloshing softly around inside her when she moves and thusly jostles them.");
	output("  With a smirk, you ask if she feels good from having helped you with your little milk problem.\n\n");

	output("The cat herm stirs herself from your grip and cuddles up to you, nuzzling against your neck and tucking her chin into your shoulder.  Then she lets out a burp that echoes off the ");
	if (kathIsAt(KLOC_KATHS_APT))
		output("bedroom walls");
	else if (kathIsAt(KLOC_STREETS))
		output("alley walls");
	else { //At the bar
		output("walls of the bar");
		if (hours >= 8 && hours <= 16 && flags["COC.NIAMH_STATUS"] == undefined)
			output(".  You notice " + (Flag("COC.MET_NIAMH") == 0 ? "the huge breasted cat girl" : "Niamh") + " rubbing her own mammaries enviously");
	}
	output(".  “<i>I feel great,</i>” Katherine tells you, totally unabashed.  “<i>I must say, I've drunk from people before... but nobody makes milk as wonderful as yours");
	if(flags["COC.KATHERINE_MET_SCYLLA"] == 1)
		output("... except maybe that nun");
	output("!</i>”\n\n");

	output("Smiling at the flattery, you help the very well-fed cat out of your lap, then quietly put your top back on and head out into the streets.\n\n");
	//some lust loss, satisfy feeder, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(25);
	pc.lust( -40);
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	pc.milked(pc.milkFullness);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

public function dateKathBath():void {
	output("\n\nYou ask Kath what she thinks of taking a trip out to the lake.\n\n");
	output("“<i>Oh, but I have nothing to wear,</i>” she says in a playful, seductive tone.  ");
	if (kathIsAt(KLOC_STREETS))
		output("She hops up off her crate in a way that causes her breasts to bounce.  She");
	else if (kathIsAt(KLOC_URTAS_APT) || kathIsAt(KLOC_URTAS_HOME))
		output("She goes outside with you and");
	else ((kathIsAt(KLOC_KATHS_APT) ? "She jumps up off the bed" : "She sucks up the last of her drink and hops out of her seat") + " in a way that causes her breasts to bounce.  She");
	output(" gets up close to you before adding, “<i>But I bet you knew that.  I’d love a naked swim, especially if it’s with you.</i>”");
	flags["COC.KATHERINE_LOCATION"] = KLOC_LAKE;
	processTime(10 + rand(10));
	clearMenu();
	addButton(0, "Next", bathTime);
}

public function bathTime():void {
	clearOutput();
	output("You don’t want to dive into the lust polluted lake but you do feel that Kath needs a little swim.  You just smile at Katherine and " + (pc.isNaga() ? "slither" : pc.mf("walk", "strut")) + " towards the nearest stream of clean mountain water.  On the way you peel off each piece of equipment and clothing in turn.  You can sense Kath’s eyes staring at you the whole way.\n\n");

	output("Now disrobed you enter the cold, clean water and turn around to see Katherine madly struggling out of her clothes.  She kicks off the last garment and then charges you with lust in her eyes.\n\n");

	output("Cats back in Ingnam weren’t too keen on water but Kath doesn’t seem to care.  She launches off the shore in a graceful arc and crashes into you in what is at once both flying tackle and hug.\n\n");

	output("The impact knocks you straight into the drink.  There’s cold, there’s water and when you break the surface for a breath there’s a grinning Kath right next to you.  She hugs you again, gently this time, providing the only source of heat in this glacial water.\n\n");

	output((pc.balls > 0 ? "Your balls try to retract, y" : "Y") + "our nipples harden and you can tell Kath’s are doing the same.");
	if (kath.hasCock()) {
		output("  Her cock" + kath.CockMultiple(" refuses to go soft - it grinds ", "s refuse to go soft - they grind "));
		if (pc.isNaga())
			output("against your underbelly");
		else output("between your " + (pc.isTaur() ? "front " : "") + " legs");
		output(" like a red hot poker.");
	}
	processTime(10);
	clearMenu();
	if (pc.isTaur()) {
		if (!pc.hasCock()) //Female or genderless
			addButton(0, "Next", bathTimeCentaurPenetrated);
		else {
			addButton(0, "Ride", bathTimeCentaurRide);
			addButton(1, "GetPenetrated", bathTimeCentaurPenetrated);
		}
	}
	else {
		if (!pc.hasCock()) //Female or genderless
			addButton(0, "Next", kath.hasCock() ? bathTimePenetrated : bathTimeFrustrated);
		//Herm or Male
		else if (!kath.hasCock()) addButton(0, "Next", bathTimeFuckKath);
		else {
			addButton(0, "Penetrate", bathTimeFuckKath);
			addButton(1, "GetPenetrated", bathTimePenetrated);
		}
	}
}

private function bathTimeCentaurRide():void {
	clearOutput();
	output("Kath holds you for a while, just grinding against you slowly and laying kiss after kiss on your lips and neck.  Finally she lets go and walks along your flank.  She stops beside you, pets your side and jumps onto your back.  She reaches around your torso and " + (pc.hasBreasts() ? "starts to play with your breasts" : "runs her hands over your [pc.chest]") + ".  Not satisfied with just that Kath begins grinding against you, " + (kath.hasCock() ? "the " + kath.CockMultiple("tip of her cock", "tips of her cocks") : "her pussy") + " grinding against what would be your ass if you were a human.  As a centaur it’s the sensitive spot where your spine curves.  Her " + (kath.hasCock() ? "cockhead" + kath.CockMultiple(" keeps", "s keep") : "groin keeps") + " rubbing against the small depression there, creating lovely sensations that travel in both directions.  At one end of your body your cock" + (pc.cocks.length > 1 ? "s grow" : " grows") + " even harder, at the other your throw your head back and start to moan.\n\n");
	
	output("Katherine puts a hand on your cheek and draws your head back for a deep kiss.  The angle is a bit difficult for both of you, so she releases you, her hands going back to tweaking your nipples.  Kath leans forward and her rough tongue begins to lick the nape of your neck, driving you wild.\n\n");
	
	output("You can feel Kath’s ");
	if (kath.hasCock())
		output(kath.cockAdj() + "prick" + kath.CockMultiple(" ", "s ") + (kath.hasBalls() ? "and her " + kath.ballAdj() + " balls" : "") + " pressing against your back,");
	else output("pussy growing wetter");
	output(" as she gets closer and closer to cumming.  Meanwhile your own cock" + (pc.cocks.length > 1 ? "s are resting" : " is resting") + " ignored in the glacial river water.  You hear a purr and then two warm feet close around your " + (pc.cocks.length > 1 ? "upper " : "") + "shaft.  Kath is using her feline flexibility to give you a footjob while at the same moment she grinds her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") : "vulva") + " against your spine, strokes your chest and licks your neck.\n\n");

	output("Katherine’s feet begin to stroke your " + (pc.cocks.length > 1 ? "cocks" : "manhood") + " rapidly; if it weren’t for the river she would probably be rubbing you raw.  Then you feel her ");
	if (kath.hasCock())
		output((kath.hasBalls() ? "balls contract" : "her thighs clench") + " and her cock" + kath.CockMultiple(" sprays a copious load", "s spray copious loads") + " of hot cum");
	else output("thigh muscles tighten and her pussy releases a spray of hot femcum");
	output(" against your back.  Kath’s legs pump furiously, trying to drive you to orgasm before she runs out of energy.\n\n");

	output("She only just succeeds.  As she collapses forward onto your back" + (kath.hasCock() ? ", slapping wetly into her own spunk," : "") + " her feet weakly slide down towards the base of your " + (pc.cocks.length > 1 ? "largest " : "") + " cock one last time.  You’re so close that’s all you needed.\n\n");

	if (pc.cumQ() <= 500)
		output("You stand there as your cock" + kath.CockMultiple(" fires", "s fire") + " a few streams of your seed into the river" + (kath.hasCock() && (pc.cumQ() + 500 < kath.cumQ()) ? ".  Compared to Kath’s excessive load your performance seems almost emasculating" : "") + ".\n\n");
	else if (pc.cumQ() <= 1500)
		output("Jet after jet erupts into the river.  It leaves you feeling a little weak.  You reach behind you and give Kath’s ears a little scratch.\n\n");
	else if (pc.cumQ() <= 3000)
		output("Your cum launches out of your cock" + (pc.cocks.length > 1 ? "s" : "") + " so forcefully that you can feel its warmth licking against the backs of your front knees.  With nothing to contain " + (pc.cocks.length > 1 ? "them your cocks bounce back and forth like out of control firehoses" : "it your penis bounces back and forth like an out of control firehose") + ".\n\n");
	else
		output("Your overproductive " + (pc.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (pc.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (pc.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.\n\n");
	
	output("When you recover from your ‘bath’ you wake Katherine up.  It’s probably not safe to stick around, so the two of you collect your things and start the long walk back to Tel’Adre.  Katherine is smiling and giggling through most of the trip back.");
	if (flags["COC.KBIT_TRIED_BATH"] == undefined) output("  In fact she enjoyed this trip so much that you have a feeling these ‘baths’ will become quite popular.");
	processTime(25 + rand(10));
	pc.orgasm();
	kath.orgasm();
	flags["COC.KBIT_TRIED_BATH"] = 1;
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function bathTimeCentaurPenetrated():void {
	clearOutput();
	output("Kath holds you for a while, just grinding slowly and laying kiss after kiss on your lips and neck.  Finally she lets go and walks along your flank, stroking your flesh with her fingers.  The water resists your movements, giving Katherine the edge.  For now she is the one controlling the pace.  She gets to your rear and strokes your tail.  It rises into the air all on its own, letting Kath know just how much your body wants this.\n\n");

	if (kath.hasCock())
		output("You can feel her cock" + kath.CockMultiple("", "s") + " sliding against your inner thighs while Kath’s fingers tease your [pc.vagOrAss].  She waits until your legs begin to tremble before sinking " + kath.CockMultiple("", "one of ") + "her " + kath.cockAdj() + "shaft" + kath.CockMultiple("", "s") + " into your [pc.vagOrAss].\n\n");
	else output("She waits until your legs begin to tremble before gently forcing her fingers deep into your [pc.vagOrAss].\n\n");

	output("Once Katherine’s " + (kath.hasCock() ? "cock" : "fist") + " is inside you there’s no stopping her.  She starts to pound you and only the fact that she has to push the water from between your bodies keeps her from hurting you.  Your knees begin to quiver as Kath delivers a savage " + (kath.hasCock() ? "fucking you thought only a minotaur could manage" : "fisting, almost as if she's trying to prove she can still fuck you") + ".  Perhaps this stream is a little bit more lust polluted than you first thought.\n\n");

	output("She’s so lost in lust that she doesn’t talk or moan, though you are moaning enough for both of you.  At last you collapse forward, powerless to stop her as she drives home with one last thrust, her " + (kath.hasCock() ? "knot" : "arm") + " sinking into your [pc.vagOrAss]" + (kath.hasCock() ? "" : "all the way up to the elbow") + ".\n\n");

	if (kath.hasCock()) {
		output("Your belly expands with each squirt as her " + (kath.hasBalls() ? kath.ballAdj() + "testicles empty" : "bountiful prostate empties") + " into your ");
		if (pc.hasVagina() && pc.isPregnant()) {
			output("vagina, her semen gushing against your sealed cervix.  The pressure is so great you feel streams of it seeping out around her knot, jetting into the waters around you." + (kath.cumQ() > 500 ? "  Her cum is under such pressure that you can feel a small second bump forming above your belly as the uppermost part of your vagina swells up with Kath’s cum." : ""));
		}
		else { //Can use common text for when Kath has big balls
			if (pc.hasVagina()) //Non-pregnant female/herm
				output("vagina, her semen forcing its way into your womb.");
			else //Male or genderless
				output("rectum, her semen inflating inch after inch of your intestines.");
			if (kath.cumQ() > 500) output("Your belly is soon pressed against the cool stream bed, inflated with your girlfriend’s cum." + (kath.cumQ() > 1500 ? "  It starts to get painful as Kath’s titanic orbs do their best to fill her mate.  Any more and you’re sure the muscles of your abdomen would give out." : ""));
		}
		if (kath.cockTotal() > 1) output("  Katherine’s other cock, still rubbing between your legs, releases its share of the load, coating your belly with a layer of her hot sperm.");
	}

	output("\n\nThe sensation of your girlfriend’s ");
	if (kath.hasCock())
		output("hot cock throbbing inside you");
	else output(pc.hasVagina() ? "knucles grinding against the entrance to your womb" : "fingers flexing deep inside your colon");
	output(" is too much.  You gasp as your own orgasm overtakes you, your [pc.vagOrAss] clenching on Kath’s " + (kath.hasCock() ? "cock, milking out the last few drops." : "forearm."));
	if (pc.hasCock()) {
		if (pc.cumQ() <= 500)
			output("  Your own cock" + kath.CockMultiple(" fires", "s fire") + " a few streams of your seed into the river." + ((pc.cumQ() + 500 < kath.cumQ()) ? "  Compared to Kath’s excessive load your performance seems almost emasculating." : ""));
		else if (pc.cumQ() <= 1500)
			output("  Jet after jet erupts from your own cock" + kath.CockMultiple("", "s") + " into the river.  It leaves you feeling a little weak.");
		else if (pc.cumQ() <= 3000)
			output("  Your cum launches out of your cock" + (pc.cocks.length > 1 ? "s" : "") + " so forcefully that you can feel its warmth licking against the backs of your front knees.  With nothing to contain " + (pc.cocks.length > 1 ? "them your cocks bounce back and forth like out of control firehoses." : "it your penis bounces back and forth like an out of control firehose."));
		else output("  Your overproductive " + (pc.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (pc.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (pc.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.");
	}
	
	if (kath.hasCock()) {
		output("\n\nAfter depositing her load Kath loses almost all her strength, only keeping her head above water by grabbing hold of your back with her hands.\n\n");
	
		output("You know that staying here after producing that kind of racket is unwise.  Using the strength inherent in your centaur body you force yourself back to your feet.  It’s hard to walk with your cum-stuffed belly; harder still when you have to climb out of the river and the water no longer supports your " + (kath.cumQ() > 500 ? "bulging stomach" : "weight") + ".\n\n");
	
		output("Katherine is no help at all.  She’s still locked to your [pc.vagOrAss] and still in a post-orgasmic stupor.  You have to carefully bend down and collect all your clothes and equipment, and hers as well." + (kath.cumQ() > 500 ? "  With every bend your overstuffed belly gurgles and complains." : "") + "\n\n");
	
		output("It’s only when you’ve begun walking back to Tel’Adre that Kath’s knot finally deflates enough to grant you some relief.  You haul her forward and get her dressed, then you both lean on each other for the rest of the trip back.");
	}
	else {
		output("\n\nAfter bringing you to orgasm Kath pulls her arm from your twitching [pc.vagOrAss] and, after cleaning it off in the stream, walks around your body and gives you a hug.  She nibbles gently on one of your nipples and asks, “<i>Did I do a good job?</i>”\n\n");
		
		output("You have to laugh.  Here you are, your [pc.vagOrAss] still tingling from the enthusiastic fisting she just gave you and she needs to ask?\n\n");
		
		output("You bend down and collect all your clothes and equipment, noticing the bounce in Kath's step as she pulls her clothes back on.  The funny thing is that even though Kath didn't cum she's so happy at having done well that it doesn't seem to matter - or perhaps it's just that the cold water has numbed her needy pussy.\n\n");
	}
	if (flags["COC.KBIT_TRIED_BATH"] == undefined) output("  In fact she enjoyed this trip so much that you have a feeling these ‘baths’ will become quite popular.");
	processTime(35 + rand(10));
	if (kath.hasCock()) {
		if (pc.hasVagina()) pc.loadInCunt(kath);
		else pc.loadInAss(kath);
	}
	pc.orgasm();
	kath.orgasm();
	pc.energy(-15 * kath.fullBodyWeight() / (pc.bodyStrength() - pc.fullBodyWeight())); //Some extra fatigue for dragging your girlfriend's ass halfway home
	flags["COC.KBIT_TRIED_BATH"] = 1;
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function bathTimeFuckKath():void {
	clearOutput();
	output("The sensation causes your " + (kath.hasCock() ? "own " : "") + "cock" + (pc.cocks.length > 1 ? "" : "s") + " to prod Kath’s belly" + (kath.hasCock() && pc.hasVagina() ? " and you roll your hips so that Kath’s cock sinks into your folds" : "") + ".  " + (kath.hasCock() ? "She purrs and tries to drive her shaft deeper but you have other plans.\n\n" : ""));

	output("You turn Kath around and slip your cock between her legs, nestling it between her steaming inner thighs.  She tries to turn back around, but you seize her hips and ");
	if (pc.cor() < 75)
		output("let her know that for now you are going to lead");
	else
		output("make it clear that you are the one in charge here");
	output(".  Once Kath stops fighting back you turn your attention to her chest.  In this cold water her [kath.breasts] are slippery, firm and topped with hardened nubs.  You tweak her nipples and Kath’s tail wraps itself around " + (pc.isNaga() ? "your tail" : "your [pc.leg]") + ", begging for more.\n\n");

	output("The cold stream is starting to affect even your lust fueled shaft.  Before you go soft you slide your shaft into Kath’s hot little tunnel.  Immediately your prick springs back to life, your body feeding it a steady supply of hot blood and slippery precum.\n\n");

	output("Kath flexes the muscles of her perky ass and wonderful cunt and you enjoy every sensation as your " + kath.catGirl("", "feline "));
	if (pc.cor() < 25)
		output("mate and lover");
	else if (pc.cor() < 75)
		output("partner");
	else
		output("fucktoy");
	output(" does her best to make you cum using only her love canal.\n\n");

	output((pc.balls > 0 ? "Your balls have retracted as far as they will go and you decide it’s time.  " : "") + "You take Kath’s hands and place them on her head, lacing her fingers together.  You whisper to her that she has to stay perfectly still.  Then your hands slide down her body, over her soft " + kath.catGirl("skin", "black fur") + ".  In turn you massage tha back of her neck, fondle her breasts and stroke her belly before firmly taking hold of her shapely hips once again.\n\n");

	output("Kath mewls and purrs, desperate for you to start fucking her.  You nibble at her ear and begin to slowly stroke in and out of her sex.  The pace isn’t enough to satisfy either of you, but you keep things slow, watching Kath’s knuckles tighten as she tries not to move.\n\n");

	output("The muscles inside her vagina do their level best to entice you, but you wait until Kath starts to plead for your cock.  “<i>Please" + (kath.playerMaster() ? " [pc.master]" : "") + " - take me, use me, fuck me!</i>” she moans.  Then she repeats it again and again as if it’s some kind of mantra.\n\n");
	
	if (pc.cor() < 25)
		output("You smile to yourself.  You’ve already driven your lover to the edge and she hasn’t cum yet.  With luck you’ll give her several orgasms before releasing your seed inside her.");
	else if (pc.cor() < 75)
		output("It’s a lovely sound.  You’re getting close to release yourself and you want Kath to enjoy this as much as you.  You start to time your thrusts with her calls.");
	else
		output("You have your slut right where you want her.  Right now she’s willing to do anything for another inch of cock.  You feel another blob of pre squirt from your cock as you dream of all the ways you can take advantage of this submissive bitch.");
	
	output("\n\nWhen you can hold back no longer you start to rut like a wild animal.  The sudden change of pace catches Kath by surprise and you feel her body tense as her first orgasm hits.  Once her legs give out it’s only your hands that hold her hips in place.  You take advantage of that, pulling her against you even faster.  The water provides some cushioning, but it’s still a violent, hard fuck.\n\n");
	
	output("Then you feel it, ");
	if (pc.balls == 0)
		output("deep inside your body your warped prostate begins contracting");
	else output("your pc.balls] start to retract");
	
	output(" and the first stream of your boiling hot cum forces its way into Katherine’s pussy.  Her sex mantra ends abruptly as she feels your seed filling her.\n\n");

	if (pc.cumQ() <= 500)
		output("You stand there as your cock fires a few more streams into her pussy.  Kath’s vagina milks you thoroughly and you feel her shudder with a second orgasm.  When it’s over you feel the hot liquid seeping out and warming the stream.");
	else if (pc.cumQ() <= 1500)
		output("Jet after jet fires into Kath’s waiting pussy.  It leaves you feeling a little weak but Kath seems pleased.  Her body convulses as she cums a second time.  Quite a bit of your sperm must have forced its way deeper, as you can feel her belly expand slightly.");
	else {
		if (pc.cumQ() > 3000)
			output("Your overproductive " + (pc.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  ");
		output("Your cum launches out of your cock so forcefully that you have to hold Kath’s hips tightly to keep the two of your from being forced apart.  Your cum hammers against Kath’s cervix");
		if (kath.isPregnant())
			output(", but with nowhere to go it forces her vagina open and then coats both " + (pc.isNaga() ? "her legs and your tail" : "your [pc.legs] and hers") + " with warm, sticky semen");
		else
			output(" and forces it open.  Your hands can feel the flesh on Kath’s hips stretch and pull, trying to provide more skin for her rapidly expanding belly");
		output(".  Kath mewls at the feeling of being filled by so much seed." + (pc.cumQ() > 3000 ? "  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum." : ""));
	}

	output("\n\nUntil you get too cold to stay in the water you just stand there, running your hands over Katherine’s ");
	if (kath.isPregnant())
		output("pregnant");
	else if (pc.cumQ() >= 1500)
		output("cum stuffed");
	else
		output("taut");
	output(" belly and enjoying the sensation of her pussy wrapped around your slowly deflating cock.  Once it’s over you haul Katherine to the shore and she smiles at you contentedly.\n\n");

	output("On the long walk back to Tel’Adre she playfully asks when you’re going to take her for another swim.\n\n");
	processTime(35 + rand(10));
	kath.loadInCunt(pc);
	pc.orgasm();
	kath.orgasm();
	flags["COC.KBIT_TRIED_BATH"] = 1;
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function bathTimeFrustrated():void { //You took away her cock. This is your fault
	clearOutput();
	output("Kath hugs you tight and you feel her fingers sliding across your " + (pc.hasVagina() ? "clit" : "nipples") + ".  You return the favor, eager to please your lusty cat " + kath.catGirl("girl", "morph") + ".\n\n");
	output("The two of you grind your breasts together and your fingers race to see who will jill the other off first.\n\n");
	output("Seconds become minutes and there's no end in sight.  You realize that the glacial stream is hindering your efforts.  You're so cold you can barely feel Kath's body pressing against yours.  Her fingers are still rubbing you" + (pc.hasVagina() ? "r clit but even that bundle of nerves" : ", but every bit of your skin") + " is growing numb.  Your own hand is starting to cramp up and the only reason you're certain it's still rubbing against her pussy is that her thighs are keeping it in place.\n\n");
	output("You look at Kath's face and see that the lust in her eyes has faded - for once - and her lips are starting to turn blue.  From her expression you guess you're in no better shape.\n\n");
	output("By the time you drag yourself and Kath out of the frigid water and towel yourselves off any thoughts of lovemaking are pushed aside in favor of warmth.  You wrap your arms around Kath and the two of you shiver until you can sense your fingers and toes once more.\n\n");
	output("The sun has moved a decent distance across the sky and you decide that despite the unsatisfying expedition there's nothing for it but to return Kath to Tel'Adre and then head back to camp.\n\n");
	processTime(35 + rand(10));
	pc.lust(20 + pc.libido() / 20);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function bathTimePenetrated():void {
	clearOutput();
	if (!pc.hasVagina()) { //Genderless or Male - get this out of the way since it will be a little different
		if (pc.hasCock()) {
			output("Kath's " + kath.CockMultiple("staff slides", "staves slide") + (pc.isNaga() ? " against your scaly behind" : " between your legs") + ", leaving little streaks of precum" + (pc.isNaga() ? "." : " on your inner thighs."));
			if (pc.balls > 0) output("  " + (pc.isNaga() ? "Her hands slide down your side and she wraps her fingers around" : "She slides her cock" + kath.CockMultiple("", "s") + " back and forth, rubbing " + kath.CockMultiple("it", "them") + " against") + " your scrotum, teasing you with her sharp " + kath.catGirl("nails", "claws") + " until your cock" + (pc.cocks.length > 1 ? "s are" : " is") + " standing fully erect.");
		}
		else
			output("Maddened by the " + (pc.isNaga() ? "lack of genitals on your snake half you grind the upper part of your tail against" : "sensations from your flat, nearly featureless crotch you close your legs around") + " Kath’s " + kath.CockMultiple("staff", "staves") + ".");
		output("  She purrs deeply and kisses you, then " + (pc.isNaga() ? "her hands slide up and down your hips, tickling your scales" : "she shifts her hips, driving her cock" + kath.CockMultiple("", "s") + " between your thighs") + " while her tail whips around your rear, almost as if it’s seeking out your asshole.\n\n");

		output("Kath presses herself against you and the feeling of her ");
		if (kath.hasFur())
			output("slick fur rubbing against your " + (pc.hasFur() ? "own" : "[pc.skinFurScales]"));
		else
			output("wet skin " + (pc.hasFur() ? "rubbing against your fur" : "sliding over your body"));
		output(" overloads your senses.  " + (pc.cor() < 75 ? "You close your eyes and lose yourself in the sensual feelings, the icy water forgotten." : "Your ability to fight back drains away and you curse your lack of planning - you’re so aroused that you can’t take advantage of Kath.  In fact she’s the one taking the lead!"));

		output("\n\nFor a while you and Kath just enjoy the feeling of the water lazily drifting past and the slow and steady grinding.  When every part of you seems infused with desire you feel your asshole begin to loosen, your body begging for something to fill your needy hole.");

		output("\n\nThen " + kath.CockMultiple("that lovely hot cock of hers disappears", "those lovely hot cocks of hers disappear") + (pc.isNaga() ? ", no longer grinding against your tail" : " from between your legs") + ".  You open your eyes just as Kath wraps her arms around you tightly.  She spoons you and the tip of her " + kath.CockMultiple("", "upper ") + "cock plants itself against your anus.\n\n");

		if (kath.cockTotal(GLOBAL.TYPE_CANINE)) {
			output("Katherine starts to move her hips and cock" + kath.CockMultiple("", "s") + " in small circular motions.  Gradually your [pc.asshole] is forced open and finally Kath gets the head inside.  Wasting no time she tightens her grip on you, pulling your body back and forcing " + kath.CockMultiple("her cock", "one of her cocks") + " deep into your colon");
			if (kath.cockTotal() > 1) output(" while the other continues to grind " + (pc.isNaga() ? "against your scales" : "between your [pc.legs]"));
		}
		else //Feline cock
			output("Katherine must have felt you relax.  She presses the narrow tip of her kitty cock against your [pc.asshole].  In one slow stroke she drives it inside you.  You feel every little barb as it tickles the inside of your ass");
			
		output(".\n\nYou’re so relaxed and so horny that you don’t realize her whole cock is inside until you feel her partially inflated knot bumping against your cheeks.\n\n");

		output("You realize there’s a real danger.  You beg Kath not to knot you out here in the wild - who knows what might find you.  You feel her purr deeply and she thrusts a few times.  She whispers “<i>I’ll try</i>” before she drives her cock into you again.\n\n");

		output("Her hands alternate between teasing your hard nipples and stroking " + (pc.isNaga() ? "the lower part of your belly" : "your groin") + ".  Sometimes she teases your pisshole with the tip of her finger.  It doesn’t take long before you forget all about the monsters that live in the lake.\n\n");

		output("She draws her cock back until only the head remains inside you, then she forces its hot length up your colon again" + kath.cockType("", "its tiny barbs teasing your rectum") + ".  When she takes hold of your hips and yanks back hard you realize that the only reason she isn’t fucking you harder is that with each stroke she needs to push the water out of the way.\n\n");

		output("When Kath bottoms out her knot presses against your sphincter and you start to get off on the risk of being tied to your favorite cat " + kath.catGirl("girl", "morph") + " out here.  You can feel her pounding heartbeat through her cock" + kath.CockMultiple("", "s") + " and know she’s about to cum.\n\n");

		output("As Katherine’s cock withdraws you give it a little squeeze, trying to hold her inside you a little longer.  She gasps and you feel her legs lock up.  Streams of hot cum fill your rectum, courtesy of Kath’s ");
		if (kath.hasBalls())
			output(kath.ballAdj() + ((kath.ballDiameter() <= 3 && kath.cumQ() > 500) ? "but prolific " : "") + "balls");
		else
			output("overactive prostate");
		output(".  Kath tries to force her knot inside, but your ass is already packed with her cream.\n\n");

		output("The throbbing sensation as each load of Kath’s cum forces its way past your sphincter drives you over the edge.");
		if (kath.cumQ() > 500) {
			output("  You feel your belly expanding as your intestines stretch to accommodate the load Kath is depositing inside you.");
			if (kath.cumQ() > 1500) output("  It’s painful and it seems like it takes forever before you feel Kath’s cum starting to leak out around the sides of her shaft.");
		}
		
		if (pc.hasCock()) {
			output("\n\n");
			if (pc.cumQ() <= 500)
				output("Your own cock" + kath.CockMultiple(" fires", "s fire") + " a few streams of your seed into the river." + ((pc.cumQ() + 500 < kath.cumQ()) ? "  Compared to Kath’s excessive load your performance seems almost emasculating." : ""));
			else if (pc.cumQ() <= 1500)
				output("Jet after jet erupts from your own cock" + kath.CockMultiple("", "s") + " into the river.  It leaves you feeling a little weak.");
			else if (pc.cumQ() <= 3000)
				output("Your cum launches out of your cock" + (pc.cocks.length > 1 ? "s" : "") + " so forcefully that " + (pc.cocks.length > 1 ? "your cocks bounce back and forth like out of control firehoses." : "your penis bounces back and forth like an out of control firehose."));
			else
				output("Your overproductive " + (pc.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (pc.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (pc.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.");
		}
		
		output("\n\nHer knot presses against your ass but try as she might Kath just can’t force it in.  She cries in frustration, unable to tie herself to her mate.  Exhausted, she lets her arms slip from your hips and rests her head on your shoulder.\n\n");

		output("Without a knot to hold it in place Kath’s cock slides free, allowing her copious load to flow from your gaping asshole.  You feel the warmth dissipate as the cloud of cum is slowly washed downstream.  Soon enough it will join with all the other fluids that pollute the lake.\n\n");
	
		output("“<i>" + (kath.playerMaster() ? "Thank you [pc.master], I’m sorry if I got a bit carried away" : "Thanks [pc.name], you’re the best") + ",</i>” she purrs.  You drag your sex kitten back to the river bank and gather your clothes in case you need to make a run for it." + (pc.hasCock() ? "" : "  Despite your lack of endowments you feel sated.") + "  Kath is so relaxed she might qualify as a liquid");
		if (flags["COC.KBIT_TRIED_BATH"] != undefined)
			output(" and you know she'll always be up for another trip to the lake.");
		else
			output(", so you suspect these ‘baths’ will always be popular.");
		processTime(45 + rand(10));
		pc.loadInAss(kath);
		pc.orgasm();
		kath.orgasm();
		flags["COC.KBIT_TRIED_BATH"] = 1;
		IncrementFlag("COC.KATHERINE_TIMES_SEXED");
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
	else { //Female or Herm
		output("In response you roll your hips so that Kath’s " + kath.CockMultiple("", "uppermost ") + " cock sinks into your folds.  She purrs and tries to drive her shaft deeper but you hold her still and smile at her.  You fully intend to take the reigns on this little outing and Kath is going to have to fall in line.\n\n");

		output("She gives you big lusty kitten eyes and tries to push again.  A few strokes of your fingers against Katherine’s hot pussy makes her far more cooperative.  She throws her head back and pants.  You wait until her knees lock up, then you take her hips and slowly draw your pussy down her throbbing shaft.\n\n");

		output("Now that she’s cooperating you decide it’s time to reward Katherine.  You turn your attention to her chest.  In this cold water her [kath.breasts] are slippery, firm and topped with hardened nubs.  You tweak her nipples and Kath’s tail wraps itself around " + (pc.isNaga() ? "your tail" : "one of your legs") + ", begging for more.\n\n");

		if (pc.hasCock()) {
			output("The cold stream is starting to affect even your lust fueled shaft" + (pc.cocks.length > 1 ? "s" : "") + ".  It’s almost as if your body understands that right now your pussy is going to be doing all the work.  Your masculine member" + (pc.cocks.length > 1 ? "s flag" : " flags") + " as more and more blood is diverted to the muscles of your love tunnel" + (pc.isPregnant(0) ? "" : ", your estrogen soaked ovaries and the walls of your fertile womb") + ".\n\n");
		}

		output("Kath tenses the muscles of her hips and her cock" + kath.CockMultiple(" rocks and shifts", "s rock and shift") + " inside you in a pleasing manner.  In return you run your fingers around the base of " + kath.CockMultiple("her cock", "each of her cocks in turn") + " and then " + (kath.hasBalls() ? "cup her " + kath.ballAdj() + " balls.  Katherine sighs as you roll them between your fingers and gently tug them away from her body." : "slide your index and middle fingers inside her ass.  You find her cum-stuffed prostate and begin to massage the hot bump.  You swear you can almost feel it building up a larger load in response."));

		output("Your other hand clasps around " + kath.CockMultiple("Kath’s heavy knot", "the heavy knot Kath has aimed at your pussy") + ".  Out here in the wild you just can’t afford to let her knot you, fun as it might be.  You kiss Kath deeply and start to grind your clit against the top of her knot.  Her tongue dives into your mouth as if it too is desperate to pull you closer.\n\n");

		output("With your hand in the way her cock can go no deeper.  You try to make it up to her by flexing your muscles, gently milking her " + kath.cockAdj() + "erection.  Katherine throws her head back and starts to beg.  “<i>Oh please " + kathPlayerText() + "!  Please let me go, let me fuck you.  I need to go deeper.</i>”  Her cock" + kath.CockMultiple(" is", "s are") + " throbbing and leaking globs of warm pre into your cunt" + kath.CockMultiple(".", " and the stream."));
		
		processTime(35);
		clearMenu();
		if (flags["COC.KATHERINE_UNLOCKED"] >= 4 && (pc.cor() >= 75 || pc.isAss() || flags["COC.KBIT_SUB_ORGASM_DENIAL"] != undefined)) {
			output("\n\nYou lick your lips.  Your poor little slut is so horny she can’t even move.  She’s so close to cumming, but she can’t make it there on her own.  You could hold her like this for hours and probably drive her out of her mind.  Or you could pull away and give her a nasty case of blue balls.");
			addButton(0, "Let Her Cum", bathTimePenetratedNormalEnd);
			addButton(1, "Denial", bathTimePenetratedDenial);
		}
		else addButton(0, "Next", bathTimePenetratedNormalEnd);
	}
}

private function bathTimePenetratedNormalEnd():void {
	clearOutput();
	output("You’ve got Kath right on the edge of orgasm.  She can’t move, her legs are locked up and she needs you to help her finish.  You play with her a bit longer, keen to give her more of the wonderful sensations that must be coming from the cock she’s buried in your pussy.\n\n");

	output("You look into her dilated and lust filled pupils and decide that it’s time.  Holding your pussy and Katherine’s knot perfectly still you use your hands to make her cum.  You " + (kath.hasBalls() ? "stroke her balls more vigorously than before while your" : "slip another finger inside her ass and start to milk her prostate with more energy than before.  Your") + " other hand rolls her inflated knot" + kath.CockMultiple("", "s") + " from side to side.\n\n");

	output("Kath’s eyes roll back and you feel her " + (kath.hasBalls() ? "balls yank upwards" : "prostate jump beneath your fingers") + ".  You press your sex against the front of Kath’s knot, knowing the first load is on the way.\n\n");

	output("Your sex kitten doesn’t disappoint.  Your " + (pc.isPregnant() ? "cunt" : "cervix") + " is forced open as torrents of cum flow into you, " + (pc.isPregnant() ? "rebounding off you sealed cervix and fountaining from your sex" : "filling your womb" + kath.fertileText(" and seeking out your eggs", "")) + kath.CockMultiple(".", ".  Her other dick coats your thighs in spunk as it squirts its seed into the stream.") + "\n\n");

	if (kath.cumQ() <= 500)
		output("After a few blasts Kath goes limp in your arms. You");
	else if (kath.cumQ() > 500)
		output("Kath goes limp in your arms after filling you with a hefty deposit" + (pc.isPregnant() ? "" : " that makes you look like you’re four months pregnant") + ".  You");
	else if (kath.cumQ() > 1500)
		output("Kath’s " + (kath.hasBalls() ? "balls just keep" : "prostate just keeps") + " contracting, forcing buckets of sperm into your pussy.  The backflow " + kath.CockMultiple("", "mixes with the stream from her free cock and ") + "warms the water around you" + (pc.isPregnant() ? "" : " and your belly is stretched until you look seven months pregnant.  As the last of her load is forced inside your belly button pops out") + ".  With the eruption over, you");
	else if (kath.cumQ() > 3000)
		output("You have to hold on to Kath to keep from being forced off by her high pressure cum.  " + (pc.isPregnant() ? "" : "Kath’s huge load seems to fill your womb in an instant.  Then it expands your belly still further, forcing the air from your lungs.  In moments you look nine months pregnant and your belly button has become a hard nub that rubs against the " + kath.catGirl("skin", "fur") + " of Katherine’s belly.  ") + "An amazing amount of Kath’s seed spills from your pussy" + kath.CockMultiple("", ", mixing with the stream from her free cock") + ".  It doesn’t just warm the stream around you but makes it feel slightly sticky and colors the water downstream.  With the eruption over, you");
	output(" carry your spent " + (pc.cor() < 75 ? "girlfriend" : "fucktoy") + " to the shore and wait for her to recover.\n\n");

	if (pc.hasCock())
		output("It's only when you flop onto the sandy ground that you realize your cock" + (pc.cocks.length > 1 ? "s" : "") + " never fired a shot.  The icy water and lack of stimulation resulted in only your female half cumming.  You " + (pc.balls > 0 ? "feel your balls.  Although they're" : "insert a finger and massage your prostate.  Although it's") + " still filled with cum you feel no particular desire to get off.  How strange.  Perhaps in future you'll find some way to take advantage of this weird situation.  ");
	output("Katherine purrs and hugs you close, asking, “<i>Did you like it?  Did it feel great for you too?</i>”\n\n");

	output("You assure her it was good for you too" + (pc.hasCock() ? ", despite the fact you didn't cum" : "") + ", then you both get dressed and head back to Tel’Adre.");

	if (flags["COC.KBIT_TRIED_BATH"] == undefined)
		output("  It looks like Kath enjoyed her bath, so you suspect if you ever ask her to come out to the lake she'll jump at the chance.");
	
	pc.loadInCunt(kath);
	pc.lust(pc.lustMin(), true);
	kath.orgasm();
	
	flags["COC.KBIT_TRIED_BATH"] = 1;
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function bathTimePenetratedDenial():void {
	clearOutput();
	output("With your fingers you slowly and carefully squeeze the cock inside you just beyond its knot.  You can feel her " + (kath.hasBalls() ? "balls twitching, but they don’t fire" : "prostate twitching, but it doesn’t fire") + ".\n\n");

	output("You start to draw away from Kath, allowing her cock to slide out of your cunt and into the cold water.  She mewls and begs “<i>I’m sooo close.  Please" + (kath.playerMaster() ? "[pc.master]" : "") + "!</i>”\n\n");

	output("You have to laugh.  It’s such a beautiful sight.  Your lover is desperate, you hold the key to her ecstasy and she’s about to realize you aren’t planning to use it.\n\n");

	output("“<i>Please, please, please,</i>” is all she can say.  Through " + (kath.hasBalls() ? "your hand you can feel her balls descending again" : "your fingers you can feel the muscles around her prostate softening") + ".  The glacial stream is doing its work quickly.  Her knot" + kath.CockMultiple(" recedes", "s recede") + " and her cock" + kath.CockMultiple(" starts", "s start") + " to shrivel.  Kath crosses her legs and clutches her " + (kath.hasBalls() ? "balls" : "crotch") + ", rubbing desperately to try and make the pain of her aborted orgasm go away.\n\n");

	output("You take her by the shoulders and tell her that you’ve decided she has to wait.  But not to worry, sometime soon you’ll let her know she can cum.  You want her to build up a nice big load for you.\n\n");

	output("You drag Kath out of the stream and then ‘help’ her by " + (kath.hasBalls() ? "rolling her " + kath.ballAdj() + " balls around with your hands.  You think they’re a little heavier than they were before.  You keep rubbing" : "slipping your fingers back inside her ass.  You think her prostate has become slightly heavier than it was before.  You keep massaging it") + " until she starts to develop another " + kath.CockMultiple("erection", "pair of erections") + ", then you stop.  Kath slams her fist into the ground in frustration and whimpers.\n\n");

	output("You hold her down until she’s got her lust under control, then you both get dressed and head back to Tel’Adre.  Only when the gates of the city are in view do you slip a hand inside her clothes and free her cock" + kath.CockMultiple("", "s") + ".  You grab Katherine’s waist with your other hand and start " + kath.CockMultiple("stroking her cock", "alternately stroking her cocks") + " furiously.\n\n");

	output("She whines and pants at the unexpected attention.  In seconds her cock" + kath.CockMultiple(" is", "s are") + " rock hard.  You whisper in her ear that now she can cum for you.  Kath’s knees lock up again and you point her cock" + kath.CockMultiple("", "s") + " at the desert sands.  ");
	if (kath.cumQ() <= 500)
		output("After a few blasts Kath goes limp in your arms.  When she’s done there’s a small puddle of sandy cum a few foot in front of her.");
	else if (kath.cumQ() <= 1500)
		output("Kath goes limp in your arms but her cock" + kath.CockMultiple("", "s") + " continue to discharge their overdue payload.  Numerous shots of cum splatter the ground ahead, producing a large cum puddle.");
	else if (kath.cumQ() <= 3000)
		output("Kath’s " + (kath.hasBalls() ? "balls just keep contracting" : "prostate seems to produce an unending supply") + ", launching buckets of sperm onto the dry desert sand.  By the time she’s finished the cum has formed a pool on the sand, a pool that’s slowly sliding towards lower ground.");
	else
		output("Katherine’s sperm just keeps flowing from her cockhead" + kath.CockMultiple(" in one continuous stream", "s in two continuous streams") + ".  You could probably have got her a job with Tel’Adre’s fire department, no training required.  When she finally finishes there’s a river of cum flowing across the dry sand.");

	output("\n\nYou have to carry her the rest of the way, but when you reach the gates Katherine gives you a kiss and tells you she wants you to come and see her soon.  You grin and shake your head - this girl is insatiable.\n\n");
	
	pc.lust(10 + pc.libido() / 20);
	kath.orgasm();
	flags["COC.KBIT_SUB_ORGASM_DENIAL"] = 1;
	flags["COC.KBIT_TRIED_BATH"] = 1;
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Talk
private function talkToKatherine():void {
	clearOutput();
	output("You tell Katherine that you'd like to talk.  ");
	if (kathIsAt(KLOC_STREETS)) {
		output("The pink-haired black cat looks shy, but excited at that.  “<i>Okay... what do you want to talk about?</i>” she asks, nervously looking at her feet.");
		clearMenu();
		
		addButton(0, "RacialTension", katherineDefur);
		addButton(1, "Her History", katherinesHistory);
		addButton(2, "Gang", askKatherineAboutGang);
		addButton(3, "Dog Cock", askKatherineAboutDogCock);
		addButton(4, "Vagrancy", askKatherineAboutVagrancy);
		addButton(5, "LoveAndLust", askKatherineAboutLoveAndLust);
		if (flags["COC.KATHERINE_UNLOCKED"] == 1 && flags["COC.KATHERINE_TRAINING"] == 1) addButton(6, "Employment", employmentTalk);
		
		addButton(14, "Back", katherineMenu);
		return;
	}
	output((kathIsAt(KLOC_KATHS_APT) ? "She sits on the edge of the bed" : "She leans back in her chair") + " and says “<i>I’d love to talk.  What’s on your mind?</i>”");
	
	clearMenu();
	addButton(0, "Gangs", talkGangs);
	addButton(1, "The Watch", talkWatch);
	addButton(2, "Her Home", talkHome);
	addButton(3, "The Bar", talkWetBitch);
	//if (doneSubmissive(KBIT_SUB_CAT_GIRL)) addButton(4, "Cat Girl", talkCatGirl);
	//if (kathIsAt(KLOC_KATHS_APT) && flags[kFLAGS.KATHERINE_CLOTHES] >= 4) addButton(5, "Clothes", talkClothes); //All the special clothes have a value of 4 or more
	//if (playerLovers() > 0) addButton(6, "Lovers", talkLovers);
	//if (kathSubmissiveness() >= 4) addButton(7, "Master", talkMaster);
	//if (kath.isLactating()) addButton(8, "Her Milk", talkMilk);
	addButton(14, "Back", katherineMenu);
}

//Talk Scenes
//Racial Tension
private function katherineDefur():void {
	clearOutput();
	output("You comment to Katherine that you can't help but notice that she and all of her... ah, 'friends' are cats, and the city seems to be mainly populated by dogs.  Does that have anything to do with her basically being a vagrant?\n\n");

	output("“<i>Ah... well, I wouldn't go so far as to say it's entirely to blame for us being on the streets, but I confess that it's definitely had a role to play.  Most of the watch are canines of some description and, well, they do tend to think the worst of any cats they suspect of causing trouble.</i>” Katherine shrugs.\n\n");

	output("You comment that you would have thought the demonic threat would make people forget about prejudices like that.\n\n");

	output("“<i>We're a lot more united now than we were before, but, honestly, old beliefs die hard, you know?  Horses are dumb, sex-crazed brutes, centaurs are horses with big egos and bad attitudes, dogs are dull-witted, wolves are savage, cats are lazy, mice are cowardly, foxes are shiftless... Well, you can see how it goes.</i>”  The herm cat-morph delivers this proclamation while airly waving one furry hand.  “<i>Besides, it's not as if there are demons beating on the walls day in and day out to remind us all of the greater threat every morning, you know?</i>”\n\n");

	output("You click your tongue reflexively.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(3);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

//Her History
private function katherinesHistory():void {
	clearOutput();
	output("You tell Katherine you're curious about her.  How did she end up on the streets?  Was she born there - or did she simply lose her family?\n\n");

	output("“<i>No, no, nothing quite so dramatic as that.</i>”  The cat-woman laughs.  “<i>My people basically all moved to Tel'Adre before I was born - mother used to complain I was kicking in her womb all the way - when our own cities were ransacked by the demons.  We had to settle in the bad parts of the city - we were lucky Tel'Adre had already lost a lot of people, or they might have turned us away.   I was born in the streets, and I've grown up here,</i>” she explains.\n\n");

	output("You ask if that means Katherine's entire family are street-people like she is?\n\n");

	output("“<i>No, no, nothing of the sort.</i>”  She looks sheepishly at her hands for a moment.  “<i>I... uh... it's actually kind of embarrassing.  All right, well... my mother and father always had a talent for dealing with people, getting them what they want and what they need for bargain prices.  So, it didn't take them long to set up and run this little shop together, off the main street.  I grew up living there; a bit cramped, but cozy - it was a quiet, safe life.  Unfortunately, I was what you'd call a rebellious teen; I used to hang out on the street all day long, and refused to go to school or learn a trade.  Then, one night, I decided I'd run away and live in the street full-time, because I heard them talking about sending me to join the Watch as a new recruit.</i>”\n\n");

	output("She grins.  “<i>Unfortunately, that means I've had to be a vagrant ever since; I don't dare go home as I have no intention of ever joining the Watch, but, well, I don't have a single way of earning myself an honest coin.</i>”\n\n");

	output("She sees the look you're giving her and hastily anticipates your reaction.  “<i>But don't worry, I actually like my life!  Nobody telling me what to do, I make my own hours... really, it's not so bad.</i>”\n\n");

	output("You're skeptical, but reason there's nothing you can do about it right now.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(3);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

//Gang
private function askKatherineAboutGang():void {
	clearOutput();
	output("You ask Katherine if she can tell you anything about the gang of cats you found her running with.\n\n");

	output("She looks around, as if expecting them to suddenly appear.  “<i>Okay... just, promise me you won't tell them anything I tell you?</i>”  When you give your word, she sighs softly.  “<i>Well, we're basically just what we look like; a bunch of homeless cats who figured out there was strength in numbers.  We're not really friends, exactly, we just know we can trust each other and we band together to do what we need to do.</i>”\n\n");

	output("You ask her just what they actually do");
	if (flags["COC.KATHERINE_UNLOCKED"] == 1)
	{
		output(" after all, you did first meet them when they ambushed you ");
		if(flags["COC.KATHERINE_MET_SCYLLA"] == 1)
			output("and Scylla ");
		output("to get at some milk.\n\n");
		
		output("Katherine flushes with embarrassment.  “<i>Yes, well... that's honestly not the first time they've done that.  ");
	} 
	else
	{
		output(".");
		output("\n\nKatherine flushes with embarrassment.  “<i>Well...  ");
	}

	output("We all like milk and sometimes have problems getting food, and so we go after lactating women and herms to feed on them - we don't usually mug people,</i>” she hastily appends, “<i>so the Watch aren't chasing us constantly.  Much as they may complain, milk thefts with no actual monetary damages generally aren't important enough for them to bother with.</i>”\n\n");

	output("You point out that, either way, attacking people for what is basically their bodily fluid has got to be a dangerous risk to take in this city.  A lot of the people around look like they can take care of themselves.\n\n");

	output("“<i>You're not wrong there,</i>” Katherine agrees.  “<i>We actually used to have another male cat named Joey in our gang, 'til he fell afoul of a 'victim' of ours.</i>”  Curious, especially by the way she's smiling at the recollection, you ask her to share the tale.\n\n");

	output("“<i>Well, he sees this mouse woman one day, dolled up in a long dress with milk seeping from nipples attached to breasts as big as her head, and decides to go after her without the rest of us.  He stumbled back to the gang later that day, gut swollen, face smeared with white, and looking very shocked.</i>”  She grins wickedly.  “<i>Turns out she was a hermaphrodite; had a horsecock this big,</i>”  Here she touches first her elbow, then the tip of her middle finger.  “<i>And two inches thick.  She apparently led him to a quiet place, acting like she was going to give him the milk he wanted, then she whipped out her dick, knocked him down and tied him up, then made him suck her off - and as she had balls as big and full as her tits under the dress, well...</i>”\n\n");

	output("You can't help but picture that in your head and chuckle softly, then ask what happened to him.\n\n");

	output("“<i>The others gave him such hell: mocking him for losing to a mouse, teasing him about liking dickgirls, and jeering that at least he got a meal anyway, that he vowed he'd get even; he went back after her again.  And again.  And kept losing.  He didn't always come home with a gut full of dick-milk, but she played with him sexually whenever she won, which was as often as he'd challenge her.  Funny thing was, she never actually raped him, per se - never tried sticking that horsecock up his ass... at least, not if he didn't want her to.  She seemed to think it was all a game and, to be honest, I think he started thinking that way too.  One day, he never came back; he's just shacked up with her permanently, I think.</i>”\n\n");

	output("<b>That</b> certainly wasn't the sort of ending you were expecting.  You press her to explain; did they really just move in together?\n\n");

	output("“<i>I've actually seen them a few times; they both look very happy, and he's even wearing a little heart tag with her name on it at his neck.</i>”  The cat-herm shakes her head and sighs.  “<i>The other cats never talk about him except to call him a wimp and a sellout.  Personally, I can't help but think he was the smart one.</i>”\n\n");

	output("Mulling that over, you remember what you were originally talking about and ask her what the gang does aside from milk-muggings.\n\n");

	output("She shrugs.  “<i>Panhandling, a little pickpocketing, some stall-robbing...  Mostly we're urban scavengers - you know, sneaking into abandoned homes and things to pick up stuff we can pawn for money.  It's not as easy as it sounds, and the law really cracks down on it, so if they catch us... it won't go easy.  We do that only when we're sure we can get away with it.</i>”\n\n");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(6);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

//Dog Cock
private function askKatherineAboutDogCock():void {
	clearOutput();
	output("You confess to Katherine that you're curious about her dog cock.  How did a cat end up with a canine penis?\n\n");

	output("Katherine sighs softly.  “<i>I knew you would ask this eventually.  Well, to answer the obvious question right away, I was born a herm - and no, I never got any grief over it.  The other part happened not too long after I ran away from home to become a street-cat; I was starving hungry, and I was hanging around the markets - one of the traders had managed to bring a load of produce through, so I snuck in and grabbed the first crate of food I could carry on my own before running away.</i>”  She shrugs.  “<i>It was full of canine peppers, but my belly was growling, so I started tucking in... Unfortunately, I was too naive to realize that raw canine peppers have their transformative effects, and these were raw peppers. Native Marethians are resistant to interspecies transformation, but that didn't stop me from changing in my most vital part.</i>”\n\n");

	output("Your eyes unthinkingly go to her waist, and she nods.  “<i>I was scared, at first... but it felt so good. Plus, well...</i>”  She blushes.  “<i>It made me grow a bit bigger.</i>”  As you look questioningly, she sheepishly explains, “<i>You have to understand, big dicks aren't really what we cats are known for, and in this city, where a foot long seems to be the new average, well...</i>”  She wriggles in embarrassment.  “<i>So, I hit on what at the time seemed to be a great idea; eat canine peppers until I got as big as I wanted to be, then just steal and eat a whisker fruit to give myself a cat penis back.</i>”  She sighs.  “<i>Unfortunately, I didn't realize they weren't just any old peppers - they were knotty canine peppers. They don't make your canine penis grow, they make your knot grow. I ate the whole crate and all I ended up with for my troubles was an eight inch dick - double what I'd originally had, but entirely due to the initial transformation - a bellyache, and, as I was all too quick to find out, a knot so huge that even whores won't fuck me because it'd rip them apart.</i>”  She sighs lamely.\n\n");

	output("You ask why she never went with her plan and used a whisker fruit to change it back.\n\n");

	output("“<i>Because, soon afterwards, I found out the last trader who regularly brought whisker fruit into the city vanished.  We still get some in, but the big bakeries and restaurants snap them up - you never see them on sale in the market any more.</i>”  She then looks aside.  “<i>To be honest, I've kinda grown to like the cock itself... I just wish I could shrink the knot down.  But that would take Reducto salve, and that's incredibly rare and expensive.</i>”  This last remark is accompanied with a weak shrug.\n\n");

	output("Curious, you prod her with another question; would she ever change her dog-dick for something else, given the opportunity?\n\n");

	output("She shakes her head.  “<i>No... like I said, I'm accustomed to the dog-dick now, I even rather like it.  I just want to change the knot.  I'm not saying I want to get my hands on bulbous peppers or double peppers or anything like that.  Actually, I don't think I'd mind the bulbous peppers, and a double pepper might be interesting.  I definitely would like to get my hands on an overly large pepper or two...</i>”  She trails off murmuring, half to you, half to herself.\n\n");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(5);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

//Vagrancy
private function askKatherineAboutVagrancy():void {
	clearOutput();
	output("You ask Katherine to explain to you how exactly she and her friends can be vagrants; with all the empty houses left in the city, you'd think it would be easy for them to find a house in.\n\n");

	output("Katherine scowls.  “<i>It's the government's idea.  Basically, they've repossessed all of the houses that are empty, and you can't get into them until and unless you prove you can make enough money to pay taxes and buy a lease.  No money, no house - that's why we, and many others like us, live on the street.  The Watch spends more time cracking vagrants over the head and expelling us from perfectly good empty houses than doing anything useful.</i>”\n\n");

	output("You can't help wondering how much of that is true and how much of that is prejudice.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	if(int(flags["COC.KATHERINE_TRAINING"]) == 0) flags["COC.KATHERINE_TRAINING"] = 1; //Now you can talk about Kath getting a job
	processTime(3);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

//Love & Lust
private function askKatherineAboutLoveAndLust():void {
	clearOutput();
	output("Trying to phrase your question politely, you ask why it was that Katherine wanted to see you again, particularly given the circumstances under which you met.\n\n");

	output("The dog-dicked herm cat blushes and scrapes one foot nervously along the ground in embarrassment.  “<i>Well, I... uh...  Truth be told?  You're basically the only person I've ever had sex with.</i>”\n\n");

	output("Automatically, your eyes are drawn to her crotch and you can't help asking if her canine member is really that off-putting to others.\n\n");

	output("“<i>It is, yeah.  Most cats can't get over it, most dogs can't get over the fact the rest of me is still a cat, and even centauresses are wary of letting me shove what is basically a melon in their cunts.</i>”  Katherine nods, sadly.  “<i>But then, you came along... I don't know why you did what you did, but I'm too happy to care.</i>”  A beatific expression covers her face.\n\n");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	processTime(3);
	clearMenu();
	addButton(0, "Next", katherineMenu);
}

private function talkGangs():void {
	clearOutput();
	output("You ask Kath what she thinks of the city’s gangs now that she’s on the other side of the law.\n\n");
	output("She shakes her head and says, “<i>It can be really weird sometimes.  I know why the different gangs are doing what they do and I know why the watch does what it does.  I mean the law about not living in any of the abandoned houses - that makes no sense to anyone living on the street.  But it makes a lot of sense to someone working in the Watch.  Years ago some gangs fortified buildings and kept the watch out.  The leaders got drunk on power, some became corrupt - or maybe they were a little corrupt to begin with.  Anyway, they had to bring in some of the mages to clear them out and lots of innocent people got hurt.</i>”\n\n");
	output("She gets up and paces back and forth.  “<i>All the problems are like that.  I can understand why captain Urta drinks and I know why all the city aldermen go gray.  Limited food and water, dangerous items that can get into the city, people so lost in lust that they forget to eat - and those are just everyday problems.  The city needs people to pull their weight, otherwise the whole place will just turn into a huge orgy and everyone will die of thirst because nobody fixed the pumps that bring water up from the deep aquifer.</i>”\n\n");
	output("She walks over and cuddles against you.  “<i>Problem is I know what it looks like from the other side.  A bunch of stuck up assholes who ruin everyone’s day just cause they were here before the refugees arrived.  Mages who tell everyone what to do but won’t tell anyone what they’re doing - heck, they barely ever talk to anyone outside the watch and the aldermen.</i>”\n\n");
	output("Kath sighs and then continues, “<i>There’s a reason everyone says something difficult is like herding cats.  We, along with a few other races, tend to be a lot more independent.  We’re even a little proud that we don’t listen to someone just because they say they’re in charge.  New gangs are always forming because we’d rather follow someone we can see and deal with.  Sure, the gang leaders play favorites and take the best food and so on, but at least we know who they are any where it goes.  We know who to complain to when things go wrong.</i>”\n\n");
	output("“<i>The short version is that there are no easy answers, at least to Tel’Adre’s troubles.</i>”  She lets go of you and flops back " + (kathIsAt(KLOC_KATHS_APT) ? "onto the bed" : "into her chair") + ".  “<i>Now that you’ve got me all wound up thinking about the city I hope you’re going to help me take my mind off it.</i>”");
	processTime(5);
	clearMenu();
	katSexMenu();
}

private function talkWatch():void {
	clearOutput();
	output("You ask Kath how things are going for her in the Watch.\n\n");
	output("She seems to give it some thought, then says, “<i>It’s been hard getting used to the early morning shift, but my sleep schedule was messed up before I joined.  It’s really strange walking around in uniform, seeing all the eyes out there trying not to look like they’re looking at me.  It’s kinda like getting checked out, except they’re worried about what I might see or what I’m about to do.</i>”\n\n");
	output("She puts her arms behind her head and stretches, giving you a great view.  “<i>Before you helped me get into the Watch I always thought most officers were thugs who liked pushing people around.  Now I’ve had a chance to meet them up close and it’s so different.  There are always bad apples, but their squad-mates keep them in line.</i>”\n\n");
	output("“<i>Oh, and the stuff some people pull!  One of the centaurs got a week old chamberpot thrown at him.  The perp was high up in a gang and they caught him - literally with his pants down.  He was visiting a herm he knew.  Since he knew he wasn’t getting away he tried to piss off the biggest guy there.  He wanted to get beaten.</i>”\n\n");
	output("“<i>I never heard about this before I got into the Watch, but if we beat someone up enough then it looks bad.  The gang leaders play it up, more people join the gang for protection and the perp’s boss makes sure he gets treated better in jail and pays off the fines fast so he gets to go free sooner.  They make it so it pays for their lieutenants to get beaten up.  How messed up is that?</i>”\n\n");
	output("Before you can answer Kath presses on.  “<i>I thought I would have a lot more trouble from other officers.  I’m probably the only cat of any kind in the watch.  Most of the officers are dog and fox morphs, there are a few lizards, horses and centaurs and I’ve met one bunny-morph who’s really built; but no cats.  So I was a little surprised.  Just a few comments here and there, and nothing really nasty.  I think everyone’s hoping I’m the first but not the last.  We really could use more recruits.  The fact I’m out there means somebody else doesn’t need to work overtime.</i>”\n\n");
	output("Katherine cuddles against you and says, “<i>I think I’m starting to settle in.  I was really dumb when I was younger; I should have listened to my parents when they tried to get me to join.  Thank goodness I finally did listen to you.  Thank you again for helping me.</i>”\n\n");
	if (kathIsAt(KLOC_KATHS_APT))
		output("She presses");
	else if (pc.isTaur())
		output("She gets up, walks slowly around the table and wraps her arms around your waist, rubbing your back right where it curves sharply. She presses");
	else output("She gets up, walks slowly around the table and sits " + (pc.isNaga() ? "atop your tail" : "on your knee") + ". She wraps her arms around your neck, pressing");
	output(" her body up against yours and asks, “<i>Would you like me to show you just how much I appreciate you?</i>”");
	processTime(6);
	clearMenu();
	katSexMenu();
}

private function talkHome():void {
	clearOutput();
	output("You ask Kath about her home and she just beams.\n\n");
	output("“<i>It’s wonderful.  It’s everything I didn’t have out on the street.  I have a bed - my own bed!  I have a table where I can put together a meal, a wardrobe for my clothes, a big washbasin I can use to bathe whenever I want.  But the best thing of all is my door.  I can sleep without worrying if someone is going to try to steal my things or worse.\n\n");
	output("I know it’s just two little rooms, but it’s a slice of paradise next to an alleyway under the open sky.</i>”  ");
	if (kathIsAt(KLOC_KATHS_APT))
		output("She gets up and walks around the room, drawing her hand across the freshly whitewashed walls.  “<i>This place is great and I owe it all to you.</i>”");
	else output("She leans back further and her foot brushes against your " + (pc.isNaga() ? "tail" : "[pc.leg]") + ".  “<i>You know, we could be there right now.  Just say the word and we could start testing how tight the cords under my bed are.</i>”");
	processTime(3);
	clearMenu();
	katSexMenu();
}

private function talkWetBitch():void {
	clearOutput();
	output("You ask Katherine why she hangs out at the Wet Bitch after work.\n\n");
	output("She smiles and replies that they make a mean plate of fries.  Then more seriously she says, “<i>There are a few other bars in Tel’Adre, but since Urta " + (kathIsAt(KLOC_KATHS_APT) ? "goes there it's" : "comes here this is") + " sort of the unofficial watch bar.  For average people it means starting fights or robbing drunks is a bad idea but for Watch officers it means " + (kathIsAt(KLOC_KATHS_APT) ? "it's" : "this is") + " a good place for gossip and stories or for just hanging out after work.</i>”\n\n");
	output((kathIsAt(KLOC_KATHS_APT) ? "She scoots closer to you and says" : "She takes a sip from her mug and adds") + ", “<i>when I joined up I thought I would just head home and sleep after shifts but sometimes it helps, talking to people who have the same job as you.  Besides, it turns out it’s hard to get drinks at home in Tel’Adre.  The city worries so much about demonic liquors that only a few merchants can sell the stuff legally and they charge nearly as much as the bars.</i>”");
	katherineMenu();
}

//Give Item:
private function giveKatherineAnItem():void {
	clearOutput();
	output("You tell Katherine that you have a present for her.\n\n");
	output("The cat-morph's face lights up, but then she guiltily lowers her eyes.  “<i>I can't - you're too good to me already...</i>”  You cut her off, insisting that you want to give it to her.  “<i>Okay, if you're sure... what is it?</i>”\n\n");
	var button:int = 0;
	clearMenu();
	//Transformatives
	if (pc.hasItem(new CoCCaninePepper())) addButton(button++, "Canine Pep", giveKatACaninePepper);
	if (pc.hasItem(new CoCCaninePepperBulby())) addButton(button++, "BulbPepper", giveKatABulbousPepper);
	if (pc.hasItem(new CoCCaninePepperDouble())) addButton(button++, "DblPeppr", giveKatADoublePepper);
	if (pc.hasItem(new CoCCaninePepperKnotty())) addButton(button++, "KnotPepp", giveKatAKnottyPepper);
	if (pc.hasItem(new CoCCaninePepperLarge())) addButton(button++, "LrgPepp", giveKatAOverlyLargePepper);
	if (pc.hasItem(new CoCReducto())) addButton(button++, "Reducto", useReductoOnKat);
	if (pc.hasItem(new CoCWhiskerFruit())) addButton(button++, "W. Fruit", giveKatWhiskerFruit);
	addButton(14, "Back", katherineMenu);
}

//Reducto
private function useReductoOnKat():void {
	clearOutput();
	var dickMin:int = (flags["COC.KATHERINE_UNLOCKED"] >= 4 ? 6 : 8); //If she's employed she'll go as low as 6 inches
	
	if (kath.longestCockLength() <= dickMin && (kath.balls == 0 || kath.ballSizeRaw <= Math.PI) && (!kath.hasCock() || kath.cocks[0].knotMultiplier <= 1.5) && kath.biggestTitSize() <= 1) {
		//If min size on all Kat parts reached:
		output("She looks at the jar and then visibly thinks about it, but shakes her head.  “<i>I'm sorry, " + kathPlayerText() + ", but I don't think it's possible for that stuff to make any of my remaining parts shrink any more...");
		if (flags["COC.KBIT_SUB_CALL_MASTER"] == 1)
			output("</i>”\n\nYou sigh and put the jar away.  ");
		else output("  Or rather, I should say I don't want to get any smaller than I am now, thank you.</i>”\n\nYou nod in understanding and put the jar away.  ");
		output("She looks apologetic.  “<i>Did you maybe want to do something else?</i>” she asks.");
		clearMenu();
		addButton(0, "Next", giveKatherineAnItem); //Display main Kat item menu
	}
	else {
		output("You extract the small jar of salve and offer it to her.   Her face lights up in delight.  “<i>Reducto?!  For me?  It's so expensive!</i>”  At your nod, she yowls happily and snatches it up, rapidly discarding her clothes.  All of a sudden, she stops abruptly and looks up at you, a dangerous gleam in her eye.  “<i>Would you like to... help me apply it?</i>” she asks, softly.  You nod your head");
		if (pc.slut() > 50) output(" with a salacious grin");
		output(" and she happily plunks down on ");
		if (kathIsAt(KLOC_STREETS))
			output("a nearby crate, holding the precious jar of ointment and waiting for you to begin.\n\n");
		else //Kath is at her apartment
			output("her bed and strips off the rest of her clothes in a seductive little dance.  Then she hands you the precious jar of ointment and waits for you to begin.\n\n");
		output("You kneel before her, looking at her naked body ");
		if (pc.slut() > 50)
			output("and planning exactly what you're going to do to it.");
		else output("and wondering how to begin.");
		
		clearMenu();
		addDisabledButton(0, "Knot", "Knot", "Her knot should be disproportionally large for her to shrink it.");
		addDisabledButton(1, "Length", "Length", "Her cock should be long enough for her to shrink it.");
		addDisabledButton(2, "Balls", "Balls", "Her balls should be large enough for her to shrink them.");
		addDisabledButton(3, "Breasts", "Breasts", "Her breasts should be large enough for her to shrink them.");
		
		if (kath.hasCock() && kath.cocks[0].knotMultiplier > 1.5) addButton(0, "Knot", useRedoctoOnKatsKnot);
		if (kath.hasCock() && kath.cocks[0].cLength() > dickMin) addButton(1, "Length", useReductoOnKatsKock);
		if (kath.balls > 0 && kath.ballSizeRaw > Math.PI) addButton(2, "Balls", reductoBallSize);
		if (kath.biggestTitSize() > 1) addButton(3, "Breasts", useRreductoOnKatsBreasts);
		
		addButton(14, "Back", giveKatherineAnItem);
    }
}

private function useRedoctoOnKatsKnot():void {
	clearOutput();
	output("You gently reach out and start to stroke her sheath up and down, feeling the long bone of ");
	if (kath.cockTotal() > 1)
		output("each of her " + kath.multiCockDescript() + ", and rubbing one finger across the exposed tips.  The cat wriggles and squirms, and quickly blooms under your care, until all " + kath.longestCockLength() + " inches of both shafts are exposed.  Her knots just barely visible as a bulge at the base of each cock, you start to stroke them next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like red, hard balloons.  They puff up and up, swelling to full size, " + formatFloat(kath.cocks[0].thickness() * kath.cocks[0].knotMultiplier, 1) + " inches in diameter.  With the subjects prepared, you stop, leaving Katherine hovering at the edge of release.\n\n");
	else output("her " + kath.cockType() + " cock, and rubbing one finger across the exposed tip.  The cat wriggles and squirms, and quickly blooms under your care, until all " + kath.longestCockLength() + " inches of her shaft is exposed.  Knot just barely visible as a bulge at the base of her cock, you start to stroke it next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like a red, hard balloon.  It puffs up and up, swelling to full size, " + formatFloat(kath.cocks[0].thickness() * kath.cocks[0].knotMultiplier, 1) + " inches in diameter.  With the subject prepared, you stop, leaving Katherine hovering at the edge of release.\n\n");

	output("She is, however, too wound up to do anything, so you are forced to take the Reducto from her slack fingers and smear the foul-smelling gunk across her knot");
	if (kath.cockTotal() > 1) {
		output("s.  She gasps and suddenly lets out a yowl, her cocks visibly spasming as her knots shrink... and then promptly begins spurting cum, which you ");
		if (pc.slut() > 50) output("joyously attempt to catch in your mouth like rain");
		else output("narrowly dodge in surprise");
		output(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width of each knot has dropped by third, at which point the salve's effects wear off and her climax finishes... though, given that her knots remain swollen and her cocks remain erect, you think she could probably go again.\n\n");
	}
	else {
		output(".  She gasps and suddenly lets out a yowl, her cock visibly spasming as her knot shrinks... and then promptly begins spurting cum, which you ");
		if (pc.slut() > 50) output("joyously attempt to catch in your mouth like rain");
		else output("narrowly dodge in surprise");
		output(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width has dropped by third, at which point the salve's effects wear off and her climax finishes... though, given that her knot remains swollen and her cock remains erect, you think she could probably go again.\n\n");
	}

	output("She rewards you with a glowing, orgasmic smile.  “<i>That was... incredible.  Thank you so much for the present... did you want to do anything else?  Maybe... have a little fun?</i>” she asks, her voice low and husky with desire.\n\n");
	//use 1x Reducto, reduce Kat knot size by 2, increase PC lust value, go to Kat sex menu
	kath.cocks[0].knotMultiplier -= 0.55;
	if (kath.cocks[0].knotMultiplier < 1.25) kath.cocks[0].knotMultiplier = 1.25;
	if (kath.cockTotal() > 1) kath.cocks[1].knotMultiplier = kath.cocks[0].knotMultiplier;
	
	pc.lust(10 + pc.libido() / 20);
	pc.destroyItem(new CoCReducto());
	katSexMenu();
}

//[Cock Length] (unavailable unless Kat cocklength is >8, or >6 if she's employed)
private function useReductoOnKatsKock():void {
	clearOutput();
	output("With a gesture, you indicate for her to expose herself.  In obedience, she begins to stroke her sheath and expose its contents, bashfully at first but with increasing vigor as her erection takes hold.  Soon she's masturbating happily with her eyes closed and her head rolled back on her neck, having nearly forgotten what she was doing in the first place.  You ");
	if (pc.slut() > 50) output("allow her to continue until " + (kath.balls > 0 ? "her scrotum tightens up and " : "") + "it looks like she'll blow her load with one more touch, and then ");
	output("clear your throat noisily to regain her focus.  Blushing " + (!kath.hasFur() ? "a brilliant red" : "red underneath her sable fur") + ", she guiltily withdraws her hand from her shivering cock" + (kath.cockTotal() == 1 ? "" : "s") + ".\n\n");

	output("With a playful eyebrow, you take a knee in front of the throbbing-hard member" + (kath.cockTotal() == 1 ? "" : "s") + " and uncap the salve.  As if to tease, you dip into it and then, at a glacial pace, draw the paste closer to her shaft" + (kath.cockTotal() == 1 ? "" : "s") + " while remarking how cold it is compared to the desert air.  She quivers at the comment, setting her " + (kath.cockTotal() == 1 ? "cock" : "twin cocks") + " to bobbing");
	if (pc.slut() > 50) output(", then quivers again as the movement brings her a hair closer to her climax");
	output(".\n\n");

	output("Gingerly, you lift your unemployed hand up and tilt her " +  kath.multiCockDescript() + " toward her face and chest; she shivers as you touch the sensitive underside" + (kath.cockTotal() == 1 ? "" : "s") + ".  As you hold her in that position, ");
	if (pc.slut() > 50) output("staring at Katherine with a lewd smirk as she trembles and tries to maintain control, ");
	output("you bring the occupied hand up and begin rubbing the paste into the shaft" + (kath.cockTotal() == 1 ? "" : "s") + " proper with brisk up-and-down strokes.");
	if (pc.slut() > 50) output("  Barely any time has passed before Katherine, with a husky groan of protest and acquiescence mingled, begins unloading her steamy cargo; the first squirt  " + (kathIsAt(KLOC_STREETS) ? "stains her shirt" : "coats her chest") + " while the later and more energetic ones after it reach all the way to her neck and spatter on her chin.");
	output("  Katherine trembles ");
	if (pc.slut() > 50) output("and her orgasm continues ");
	output("as you apply a goodly amount of paste, smearing it over every inch of the twitching cock" + (kath.cockTotal() == 1 ? "" : "s") + " and mingling it with the copious pre-cum from her errant masturbation.  Suddenly a gasp interrupts the chorus of low moans from your felid companion, as the effects begin.  Her shaft" + (kath.cockTotal() == 1 ? " spasms and shrinks, " : "s spasm and shrink, "));
	if(pc.slut() > 50) output("still pushing out the aftershocks of her climax onto her belly, ");
	output("ending up two inches shorter than before.\n\n");

	output("“<i>God, that was... uughh,</i>” Katherine groans, wiping her [kath.skinFurScales].  “<i>I'm still so hard and horny, too... feels like I'll never go soft now.  Do you maybe... wanna help me with that?</i>”  She turns a hopeful");
	if (pc.slut() > 50) output(", if fatigued,");
	output(" look on you.\n\n");

	//remove 2 inches from Kat's length, use 1x Reducto, increase PC lust value, go to Kat sex menu
	var dickMin:int = (flags["COC.KATHERINE_UNLOCKED"] >= 4 ? 6 : 8); //If she's employed she'll go as low as 6 inches
	kath.cocks[0].cLengthRaw -= 2;
	if (kath.cocks[0].cLengthRaw < dickMin) kath.cocks[0].cLengthRaw = dickMin;
	if (kath.cockTotal() > 1) kath.cocks[1].cLengthRaw = kath.cocks[0].cLengthRaw;
	
	pc.lust(10 + pc.libido() / 20);
	pc.destroyItem(new CoCReducto());
	katSexMenu();
}

//[Ball Size](unavailable until Kat balls > 1")
private function reductoBallSize():void {
	clearOutput();
	if (kathIsAt(KLOC_STREETS)) output("With a little help from you, she discards her clothes, exposing her swollen testes.  ");
	output("You wonder for a moment if the " + (!kath.hasFur() ? "hair" : "fur") + " on her " + (kath.ballDiameter() > 3 ? "distended" : "") + " sack will interfere with the process, then decide it can't hurt to try.  Uncertainly, you open the jar and begin smearing your fingers with the salve, which you then start painting across Katherine's balls.  The hermaphrodite " + (!kath.hasFur() ? "cat girl" : "feline") + " shivers at your touch, but bites her lip and says nothing as you massage the shrinking cream into her semen-factories, rolling the globular orbs around in the palm of your hand to ensure a thorough, even coating.\n\n");

	output("You finish applying the salve and watch as they visibly shrink, contracting in on themselves until they have lost two inches in diameter.  It's at that point you realize the man-meat above them is jutting straight up from her sheath, pre-cum starting to bubble from the pointy tip" + (kath.cockTotal() == 1 ? "" : "s") +".  “<i>Uh... I think shrinking my balls put their contents under pressure.  You wanna help me vent some?</i>” she meekly suggests, coloring and biting her lip in either embarrassment or anticipation.\n\n");
	//use 1x Reducto, reduce Kat ball size by two inches, increase PC lust by small value, go to Kat sex menu
	kath.ballSizeRaw -= 2 * Math.PI;
	if (kath.ballSizeRaw < Math.PI) kath.ballSizeRaw = Math.PI;
	
	pc.lust(10 + pc.libido() / 20);
	pc.destroyItem(new CoCReducto());
	katSexMenu();
}

private function useRreductoOnKatsBreasts():void {
	clearOutput();
	output("You get next to Kath and place the jar on her belly.  As you coat your hands with the cool cream Kath closes her eyes and begins to purr.  There seems to be no change as you rub the ointment into her " + kath.breastDescript(0) + ".  Only when the jar is nearly exhausted do they start to firm up and contract.");
	if (kath.isLactating()) {
		output("  Kath's tail goes rigid and puffs up as her breasts shrink and you soon understand why.  ");
		if (kath.milkFullness >= 100)
			output("Her cream is forced from her newly shrunken chest in long streams that almost reach the ceiling.  The whole bed is soggy and you have to wonder how many people can say they've had their girlfriend's milk rain down on them.  She seems to be fixed in place until it's over, then she unclenches her fists and lets out a deep sigh.");
		else if (kath.milkFullness > 50)
			output("Her cream is forced from her newly shrunken chest in little squirts, drizzling onto Kath and the bed.  She grits her teeth and when it's over she unclenches her fists and lets out a deep sigh.");
		else output("Drops of cream fall from her newly shrunken bosom, leaving little trails on her chest.");
	}
	kath.breastRows[0].breastRatingRaw--;
	
	output("\n\nKath sits up and begins to play with her smaller and lighter rack.\n\n");
	if (kath.breastRows[0].breastRatingRaw == 1)
		output("“<i>These are so small people might think I’m a boy.  Guess I’ll just have to act even more girly to make up for it, right?</i>”");
	else if (kath.breastRows[0].breastRatingRaw == 2)
		output("“<i>Back to my natural size.  Nice, I’ve missed the balance I had when they were this big.  Thank you so much " + kathPlayerText() + ".</i>”");
	else if (kath.breastRows[0].breastRatingRaw == 6)
		output("“<i>Oh, that’s better.  They’re a lot lighter.  It doesn’t feel like I’ve got a pair of watermelons tied to my chest anymore.</i>”");
	else if (kath.breastRows[0].breastRatingRaw > 6)
		output("“<i>Oh thank Marae.  And thank you too " + kathPlayerText() + ".  I can feel some of the muscles in my lower back starting to relax.</i>”");
	else output("“<i>Yes, I think I’ll get used to these smaller sweater puppies pretty quickly.</i>”");
	output("\n\nShe lies back on the bed and spreads her legs wide");
	if(kath.hasCock()) output(", her cock" + (kath.cockTotal() == 1 ? "" : "s") + " aimed at the ceiling");
	output(".  “<i>Now since you’ve pawed my breasts and got me all excited I hope you aren’t planning on leaving anytime soon.</i>”");
	pc.lust(10 + pc.libido() / 20);
	pc.destroyItem(new CoCReducto());
	katSexMenu();
}

private function giveKatACaninePepper():void {
	clearOutput();
	output("You offer Katherine a canine pepper and ask if she'd like to have one for old times sake.\n\n");
	if (kath.hasCock(GLOBAL.TYPE_CANINE) || !kath.hasCock()) {
		output("“<i>I don't know.  I don't want to push my luck with those things.  I've already got a lot of them in my system and maybe just a few more would have me barking at the moon.</i>”\n\n");
		output("She takes your hand and says, “<i>It was a nice thought, and I do like the taste and smell.</i>”  At this she starts to sniff along the pepper's length.  “<i>They make me horny... do they make you horny?</i>”  She nuzzles against you and asks, “<i>Can you guess what's on my mind, love?</i>”\n\n");
	}
	else {
		output("“<i>It's sure to give me a " + (kath.cockTotal() == 1 ? "dog cock" : "set of dog cocks") + " again.  That doesn't mean I'm saying no, I kinda got used to having one" + (kath.cockTotal() == 1 ? "" : " and then two of 'em") + ".</i>”  At this she starts to sniff along the pepper's length.  “<i>I guess what I means is I like having a nice " + (kath.cockTotal() == 1 ? "hard cock" : "pair of hard cocks") + " and somewhere to stuff " + (kath.cockTotal() == 1 ? "it" : "them") + ".  Maybe that makes me a slutty herm, but I could care less.</i>”\n\n");
		
		output("You feed the canine pepper into her mouth and Kath rolls it around before snapping her jaws shut and giving you a spicy peck on the cheek.  Quickly, she exposes her " + kath.multiCockDescript() + ".\n\n");
		
		var oldKnot:Number = kath.cocks[0].knotMultiplier;
		kath.shiftCock(0, GLOBAL.TYPE_CANINE);
		kath.cocks[0].knotMultiplier = oldKnot;
		kath.cocks[0].cThicknessRatioRaw = 1;
		if (kath.cockTotal() > 1) {
			kath.shiftCock(1, GLOBAL.TYPE_CANINE);
			kath.cocks[1].knotMultiplier = oldKnot;
			kath.cocks[1].cThicknessRatioRaw = 1;
		}
		
		output("The pepper doesn't disappoint and you watch the magic stretch her cock" + (kath.cockTotal() == 1 ? "" : "s") + " outwards, absorbing " + (kath.cockTotal() == 1 ? "its" : "their") + " barbs.  Kath once again sports a " + kath.multiCockDescript() + " and a happy, horny grin to go with " + (kath.cockTotal() == 1 ? "it" : "them") + ".");
		pc.destroyItem(new CoCCaninePepper());
	}
	katSexMenu();
}

//Bulbous Pepper
private function giveKatABulbousPepper():void {
	clearOutput();
	output("You hold out your bulbous canine pepper and ask if she'd like to eat it.\n\n");
	var oldKnot:Number;
	if (!kath.hasCock()) {
		output("“<i>I'm pretty sure that won't have any effect on me,</i>” she replies.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she rapidly discards her clothes and starts rubbing her clit.\n\n");
		output("“<i>Oh please " + kathPlayerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		pc.destroyItem(new CoCCaninePepperBulby());
		pc.lust(10 + pc.libido() / 20);
		katSexMenu();
	}
	else if (kath.balls == 0) {
		output("“<i>Funny, I was just getting used to not having them</i>” she replies.  She gives you a friendly wink and then takes the pepper, munching it down.  She moans and clutches her groin through her clothes; as you watch her hand is forced away from her body as her testes regrow and descend.");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output("\n\nKath rubs her newly formed balls and you see a bulge developing as her " + (kath.cockTotal() == 1 ? "cock stands" : "twin cocks stand") + " to attention.  She gives you a toothy smile and asks, “<i>So... you wanna give them a test run?</i>”\n\n");
		kath.balls = 2;
		kath.ballSizeRaw = Math.PI;
		kath.createStatusEffect("Uniball");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperBulby());
		
		katSexMenu();
	}
	else if (kath.ballSizeRaw < 5 * Math.PI) {
		output("“<i>Oh, sure, why not?  Bigger balls have got to be better, right?</i>” she replies.  Her tone is sarcastic, but she gives you a friendly wink and then takes the pepper, munching it down.  With a moan she reveals her crotch to show her balls visibly growing.  They roughly double in size, then stop, leaving the cat herm panting.  ");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output("She throws you a sultry look.  “<i>So... you wanna give them a test run?</i>” she purrs.\n\n");
		kath.ballSizeRaw += 2 * Math.PI;
		if (kath.ballSizeRaw > 5 * Math.PI) kath.ballSizeRaw = 5 * Math.PI;
		kath.removeStatusEffect("Uniball");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperBulby());
		
		katSexMenu();
    }
	else if (kathSubmissiveness() >= 4 && kath.ballDiameter() < 9) {
		output("She looks at the bulbous pepper and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess as it is.  Thank you for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
		output("You give Kath a big grin and tell her you’d like to see her grow larger.  Lots of people in Mareth have balls bigger than her and they can still move around.  You move closer and start to fondle her " + kath.ballsDescript(false, true) + " through her clothes.\n\n");
		output("Kath pants as her " + (kath.cockTotal() == 1 ? "cock begins" : "cocks begin") + " to swell.  “<i>I... I suppose I could try it.  As long as you still think I’m pretty.</i>”\n\n");
		output("You continue to massage her nuts and tell her that’s not enough.  She agreed so quickly that she must secretly want this.\n\n");
		output("Kath twists and turns in place, as if part of her wants to escape.  Finally, after a sharp intake of breath your obedient little " + (!kath.hasFur() ? "cat girl" : "kitty") + " says, “<i>Yes.  Yes, " + kathPlayerText() + ", I want it.  If you want me to have bigger balls then I want them too.</i>”\n\n");
		output("You just smile and use your free hand to push the fat little pepper between Kath’s lips.  She tries to take it but you slide it in and out as if it’s a tiny cock.  You tell her to suck on it and she does.  When you finally release your grip Kath sucks the pepper into her mouth and munches on it hungrily.\n\n");
		output("It doesn’t take long before you feel her scrotum expand.  It throbs and pushes your fingers apart, each of her testes growing by about two inches.  ");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output("Katherine wraps her arms around you for support.  When the change seems to have run its course she spreads her legs to accommodate her " + kath.ballsDescript(false, true) + " and whispers in your ear, “<i>So... you wanna give them a test run?</i>”\n\n");
		flags["COC.KBIT_SUB_REM_BALLS"] = 1; //Have made her supersize her balls at least once
		kath.ballSizeRaw += 2 * Math.PI;
		if (kath.ballSizeRaw > 9 * Math.PI) kath.ballSizeRaw = 9 * Math.PI;
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperBulby());
		
		katSexMenu();
	}
    else { //Too big
		if (kathSubmissiveness() >= 4) { //Too big even for submissive Kath
			output("She gets down on her knees and begs you.  “<i>Please " + kathPlayerText() + " - I already have problems whenever I try to chase criminals.  If they get any bigger I might lose my job.  Thank you for offering, but don’t these monsters make enough cum for us both?  Please can’t we do something else?</i>” she adds with a worried smile, trying to be diplomatic.");
			if (pc.cor() >= 75) {
				output("\n\nIt certainly would be fun to give your " + (!kath.hasFur() ? "cat girl" : "feline") + " fucktoy such enormous balls that she wouldn’t be able to move.  On the other hand if she loses her job then you’ll have to take care of her.  Screw that - you still get all the sex you want from her as is and you don’t have to pay.\n\n");
				output("You scratch her ear and assure her it’s all right.  Kath purrs and presses against you, her cock" + (kath.cockTotal() == 1 ? " beginning to slide from its sheath." : "s beginning to slide from their sheaths."));
			}
		}
		else {
			output("She looks at the bulbous pepper and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess now as it is.  Thank you for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
			output("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		}
		katherineMenu();
	}
}

private function giveKatAKnottyPepper():void {
	//Kath can now regrow her knot. At first she’s willing to regrow it to 4", at submissiveness 1 she //will regrow it to its original 6" size.
	clearOutput();
	var oldKnot:Number;
	output("You show Kath the knotted canine pepper and ask if it brings back any memories.\n\n");
	if (!kath.hasCock()) {
		output("“<i>I'm pretty sure that won't have any effect on me,</i>” she says.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she rapidly discards her clothes and starts rubbing her clit.\n\n");
		output("“<i>Oh please " + kathPlayerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperKnotty());
	}
	else if (kath.cocks[0].knotMultiplier >= 4) { //Original size - it won’t grow any further
		output("Kath gestures towards her " + kath.multiCockDescript() + " and says, “<i>I don’t think it can get any bigger.  I ate a ton of those peppers all at once and they never pushed me past this.</i>”\n\n");
		output("She takes the pepper and examines it more closely and then pops it in her mouth.  Once she’s finished chewing she adds, “<i>They do taste good.</i>”  She looks at you again and says, “<i>Thank you " + kathPlayerText() + "; even though I’m not starving that sure hit the spot.</i>”\n\n");
		if (kath.hasCock(GLOBAL.TYPE_CANINE))
			output("Kath sits there and you watch for a short while, but the only indication that she just ate a magic imbued pepper " + (kath.cockTotal() == 1 ? "is her rock solid erection." : "are her rock solid twin erections."));
		else {
			output("Just as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + kath.multiCockDescript() + ".");
			else output("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
		}
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperKnotty());
	}
	else if (kath.cocks[0].knotMultiplier >= 2,35) { //Need submissiveness 1+ to grow
		output("Kath takes the pepper a little uncertainly.  “<i>It brings back some good memories, from after I met you; it also brings back memories of being an outcast among my own kind.</i>”\n\n");
		output("She tries to give the pepper back but you close your hand around hers and tell her to concentrate on the good memories.  She knows you won’t think she’s ugly.  The two of you got along just fine when she had a massive knot.  In a way it’s what brought you two together." + (flags["COC.KATHERINE_URTA_AFFECTION"] > 10 ? "  Besides, wouldn’t it be fun to share it with Urta?" : "") + "\n\n");
		if (kathSubmissiveness() < 1) {
			output("Kath shakes her head and says, “<i>I don’t know if I’m ready for that.  I spent so long hating my giant knot.</i>”\n\n");
			output("You tease her knot" + (kath.cockTotal() == 1 ? "" : "s") + " with your fingers.  Kath’s body wriggles and she smiles at you but she pushes the pepper back into your free hand.\n\n");
			output("“<i>Maybe some other time love,</i>” she says, “<i>right now I’ve got something else on my mind.</i>”\n\n");
			output("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		}
		else {
			output("Kath takes the pepper and then hugs you close.  “<i>Okay " + kathPlayerText() + ", I’m doing this for you.  If you think I’m more fun with a giant size knot...</i>” she slowly bites into the pepper and swallows it down, “<i>... then so be it.</i>”");
			if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
				output("Just as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
				oldKnot = kath.cocks[0].knotMultiplier;
				kath.shiftCock(0, GLOBAL.TYPE_CANINE);
				kath.cocks[0].knotMultiplier = oldKnot;
				kath.cocks[0].cThicknessRatioRaw = 1;
				if (kath.cockTotal() > 1) {
					kath.shiftCock(1, GLOBAL.TYPE_CANINE);
					kath.cocks[1].knotMultiplier = oldKnot;
					kath.cocks[1].cThicknessRatioRaw = 1;
				}
				if (kath.cockTotal() > 1)
					output("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + kath.multiCockDescript() + ".");
				else output("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			}
			output("\n\nIt takes almost a minute before Kath’s knot" + (kath.cockTotal() == 1 ? " reacts" : "s react") + " to the pepper.  When the change comes it happens quickly - her knot" + (kath.cockTotal() == 1 ? " just inflates" : "s just inflate") + " without any fanfare, gaining a few inches.\n\n");
			output("Kath watches it happen almost without any reaction.  You would guess she’s eaten so many her body has developed a resistance to the effects.  Apart from the knot" + (kath.cockTotal() == 1 ? ", which is throbbing slowly, the only indication that she just ate a magic imbued pepper is her rock solid erection." : "s, which are throbbing slowly, the only indications that she just ate a magic imbued pepper are her rock solid twin erections."));
			kath.cocks[0].knotMultiplier += 0.55;
			if (kath.cocks[0].knotMultiplier > 4) kath.cocks[0].knotMultiplier = 4;
			if (kath.cockTotal() > 1) kath.cocks[1].knotMultiplier = kath.cocks[0].knotMultiplier;
			flags["COC.KBIT_SUB_GROW_KNOT"] = 1; //Have regrown her knot to full size at least once
			pc.lust(10 + pc.libido() / 20);
			pc.destroyItem(new CoCCaninePepperKnotty());
		}
	}
	else { //Knot is < 4", Always willing to grow if you ask
		output("Kath takes the pepper and laughs.  “<i>How could I forget?  I don’t even remember how many of these I ate trying to make my cock just a bit bigger.</i>”  She rubs the base of " + (kath.cockTotal() == 1 ? "her cock" : "one cock then the other") + " and says, “<i>You want me to fill out a bit more?  Does it feel good when I knot you?</i>”\n\n");
		output("You just smile and Kath licks the pepper experimentally.  “<i>I never thought I’d eat another one of these,</i>” she says.  She shakes her head before popping the pepper into her mouth.  Apart from her cock" + (kath.cockTotal() == 1 ? "" : "s") + " standing to attention nothing seems to happen but Kath smiles and says, “<i>Yeah, I can feel it.  When " + kath.CockMultiple("this bad boy kicks in my knot is", "these bad boys kick in my knots are each") + " going to puff out to the size of an apple.</i>”\n\n");
			if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
				output("Just as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
				oldKnot = kath.cocks[0].knotMultiplier;
				kath.shiftCock(0, GLOBAL.TYPE_CANINE);
				kath.cocks[0].knotMultiplier = oldKnot;
				kath.cocks[0].cThicknessRatioRaw = 1;
				if (kath.cockTotal() > 1) {
					kath.shiftCock(1, GLOBAL.TYPE_CANINE);
					kath.cocks[1].knotMultiplier = oldKnot;
					kath.cocks[1].cThicknessRatioRaw = 1;
				}
				if (kath.cockTotal() > 1)
					output("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + kath.multiCockDescript() + ".");
				else output("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			}
		output("It takes almost a minute before Kath’s knot" + (kath.cockTotal() == 1 ? " reacts" : "s react") + " to the pepper.  When the change comes it happens quickly - her knot" + (kath.cockTotal() == 1 ? " just inflates" : "s just inflate") + " without any fanfare, gaining a few inches.\n\n");
		output("Kath watches it happen almost without any reaction.  You would guess she’s eaten so many her body has developed a resistance to the effects.  Apart from the knot" + kath.CockMultiple(", which is slowly shrinking, the only indication that she just ate a magic imbued pepper is her rock solid erection.", "s, which are slowly shrinking, the only indications that she just ate a magic imbued pepper are her rock solid twin erections."));
		kath.cocks[0].knotMultiplier += 0.55;
		if (kath.cocks[0].knotMultiplier > 2.35) kath.cocks[0].knotMultiplier = 2.35;
		if (kath.cockTotal() > 1) kath.cocks[1].knotMultiplier = kath.cocks[0].knotMultiplier;
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperKnotty());
	}
	if (kath.hasCock()) output("\n\nHer tail flicks against your leg.  She looks down at her erection" + (kath.cockTotal() == 1 ? "" : "s") + ", looks to you and then looks back at her erection" + (kath.cockTotal() == 1 ? "" : "s") + " again.");
	katSexMenu();
}

//Double Pepper
private function giveKatADoublePepper():void {
	clearOutput();
	var oldKnot:Number;
	if (!kath.hasCock()) {
		output("You hold out your double canine pepper and ask if she'd like to eat it.\n\n");
		output("“<i>I'm pretty sure that won't have any effect on me,</i>” she replies.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she rapidly discards her clothes and starts rubbing her clit.\n\n");
		output("“<i>Oh please " + kathPlayerText() + ", don't leave me to deal with this feeling on my own.</i>”");
	}
	else if (kath.cockTotal() == 1) {
		output("You hold out your double canine pepper and ask if she'd like to eat it.\n\n");
		output("“<i>Double your fun, huh?  Okay... this is a really weird thing, but if it makes you happy,</i>” she notes.  She takes the pepper and, pausing only to slip off her clothes to expose her sheath, polishes the pepper off with a smack of her lips for good measure.  “<i>Mmm... Not bad.  Oh!</i>”  She gasps and then arches her back suddenly.\n\n");
		output("Your gaze goes to her crotch, where her " + kath.cockNounComplex(0) + " slides free with deceptive slowness, crowning itself at " + kath.cocks[0].cLength() + " inches and filling its knot to " + formatFloat(kath.cocks[0].thickness() * kath.cocks[0].knotMultiplier, 1) + " inches thick as it pops free.");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output(" Then the sheath's opening stretches even wider as a second distinctive tip pops up, sliding up and out until she is sporting two bulging dog-cocks, each exactly the same size as the other.  She reaches down and gently strokes one with each hand, casting you a come hither look.\n\n");
		kath.cocks.push(kath.cocks[0]); // dirty...
	}
	else {
		output("Katherine looks at the twinned peppers with a puzzled expression.  ");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			output("“<i>You want me to go back to the way I was?</i>”\n\n");
			output("You tell her you think she looks good with either cat cocks or dog cocks and right now you’re in the mood for doggystyle - in a manner of speaking.  Besides, you know she loves peppers.  Kath takes the pepper and gives you a big smile.");
		}
		else {
			output("“<i>Uh... you do know that it won't make me grow any more cocks, right?  Two's the limit from this thing, as far as I know.</i>”\n\n");
			output("You tell her you think she could use a good meal, and you know how much she likes peppers.  The cat gives you a nervous smile and accepts the double pepper.");
		}
		output("She eats it daintily, swallows, and then develops a peculiar expression.  As she pants loudly, you can see her cocks starting to rise");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output(".\n\n“<i>Oh dear...  I think that was maybe a bit too spicy.  You want to help me out with this?</i>” she purrs, already starting to stroke her twin shafts.\n\n");
	}
	pc.lust(10 + pc.libido() / 20);
	pc.destroyItem(new CoCCaninePepperDouble());
	katSexMenu();
}

//Overly Large Pepper
private function giveKatAOverlyLargePepper():void {
	clearOutput();
	var oldKnot:Number;
	var kathSubEnough:Boolean = kathSubmissiveness() >= 4 || (kathSubmissiveness() >= 2 && flags["COC.KATHERINE_URTA_TIMES_SEX"] > 0); //May as well test this just once
	if (!kath.hasCock()) {
		output("You wave an overly large canine pepper in front of Katherine's nose and she drinks in the spicy scent.\n\n");
		output("“<i>I'm pretty sure that won't have any effect on me,</i>” she says.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she rapidly discards her clothes and starts rubbing her clit.\n\n");
		output("“<i>Oh please " + kathPlayerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperLarge());
		katSexMenu();
	}
	else if (kath.longestCockLength() < 16) {
		output("You ask if Katherine would really like to make her cock bigger, holding up the overly large canine pepper from your inventory.\n\n");
		output("“<i>Yes!  Please!</i>” she says, clearly excited.  She snatches it from your hands and wolfs it down noisily, licking her fingers and then pulling her pants down with obvious excitement.  Her cock" + (kath.cockTotal() == 1 ? "" : "s") + " immediately thrust" + (kath.cockTotal() == 1 ? "s" : "") + " from her sheath, growing to full size and then a full two inches further before stopping.  ");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			if (kath.cockTotal() > 1)
				output(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
			else output(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + kath.multiCockDescript() + ".");
        }
		output("She moans softly, licks her lips and smiles at you.  “<i>Care to have a test run?  Be a shame to let the chance go to waste...</i>” she purrs.\n\n");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCCaninePepperLarge());
		kath.cocks[0].cLengthRaw += 2;
		if (kath.cocks[0].cLengthRaw > 16) kath.cocks[0].cLengthRaw = 16;
		if (kath.cockTotal() > 1) kath.cocks[1].cLengthRaw = kath.cocks[0].cLengthRaw;
		katSexMenu();
	}
	else if (kath.longestCockLength() < 20 && kathSubEnough) {
		output("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical,</i>” she says.\n\n");
		output("You step forward, putting a finger on her lips to silence her.  You trace that finger down her body, slowly dragging it between her breasts and over her navel until it reaches the " + (kath.cockTotal() == 1 ? "root of her prick. A bit of gentle rubbing and her shaft begins" : "little hollow between the roots of her pricks.  A bit of gentle rubbing and her shafts begin") + " to rise, drawing moans of pleasure from your lover.\n\n");
		if (flags["COC.KATHERINE_URTA_TIMES_SEX"] > 0) {
			output("You ask Katherine if she thinks you love Urta.\n\n");
			output("She wriggles under your finger and answers, “<i>Yes, of course.  But I don’t need to be as big as Urta.</i>”\n\n");
			output("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her Urta could use a friend in the Watch, someone who really understands what it’s like to have such a huge... burden.\n\n");
			output("Kath’s tail flicks against the wall.  She opens her mouth to say something and your free hand pops the pepper between her lips.  She freezes and you remind her how good it will taste, how nice it will feel when her " + (kath.cockTotal() == 1 ? "dick gets" : "dicks get") + " even bigger.\n\n");
		}
		else {
			output("You tell Katherine that you've been right so far.  Every extra inch of cock has made her sexier.  You love that cute, embarrassed look on her face when she tries to hide her huge schlong" + (kath.cockTotal() == 1 ? "" : "s") + " from view.\n\n");
			output("She wriggles under your finger and finally says, “<i>I guess I can do it... I'll do it for you.</i>”\n\n");
			output("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her that you want her to do this for <b>her</b>.  You want her to see how much fun a " + (kath.cockTotal() == 1 ? "massive cock" : "pair of massive cocks") + " can be.  Then you press the pepper against her lips until she opens her mouth and allows you to rub it against her tongue.\n\n");
		}
		output("She stares into your eyes and you say, “<i>I love you.</i>”\n\n");
		output("Kath crunches down on the pepper, pulls it from your fingers and wolfs it down.  Beneath her clothes you see the " + (kath.cockTotal() == 1 ? "bulge" : "twin bulges") + " expanding.  Kath gives you a pained smile as her genitals balloon inside her panties.\n\n");
		output("With the transformation complete Kath quickly disrobes to get a better look at her new cock" + (kath.cockTotal() == 1 ? ".  It is" : "s.  They are") + " indeed larger, having gained a good two inches in length.");
		if (!kath.hasCock(GLOBAL.TYPE_CANINE)) {
			oldKnot = kath.cocks[0].knotMultiplier;
			kath.shiftCock(0, GLOBAL.TYPE_CANINE);
			kath.cocks[0].knotMultiplier = oldKnot;
			kath.cocks[0].cThicknessRatioRaw = 1;
			if (kath.cockTotal() > 1) {
				kath.shiftCock(1, GLOBAL.TYPE_CANINE);
				kath.cocks[1].knotMultiplier = oldKnot;
				kath.cocks[1].cThicknessRatioRaw = 1;
			}
			output("  The effects of the pepper have also changed " + (kath.cockTotal() == 1 ? "it" : "them") + " back into canine cocks.");
		}
		output("  Kath smiles and strokes her " + kath.multiCockDescript() + " with one hand while straightening her tail with the other.\n\n");
		output("“<i>I wasn’t sure I wanted this, but it feels good.  Do you like it?</i>” she asks, " + (kath.cockTotal() == 1 ? "pointing her cock" : "leveling both her cocks") + " at you.  “<i>Maybe you could show me how much, hmmm?  Be a shame to let the chance go to waste...</i>” she purrs.\n\n");
		pc.lust(10 + pc.libido() / 20);
		flags["COC.KBIT_SUB_GROW_BIG_DICK"] = 1; //Have made her supersize her cock(s) at least once
		pc.destroyItem(new CoCCaninePepperLarge());
		kath.cocks[0].cLengthRaw += 2;
		if (kath.cocks[0].cLengthRaw > 20) kath.cocks[0].cLengthRaw = 20;
		if (kath.cockTotal() > 1) kath.cocks[1].cLengthRaw = kath.cocks[0].cLengthRaw;
		katSexMenu();
	}
	else if (kathSubEnough) { //Too big, even for submissive Kath
		output("She looks at the pepper and then looks down at her already enormous package.  “<i>Please " + kathPlayerText() + "</i>” she cries, getting to her knees.  “<i>I can’t get any bigger. I know you want me to have " + (kath.cockTotal() == 1 ? "a massive cock" : "a pair of massive cocks") + " but I’m already so big.  I have to be careful when I stretch - otherwise I’ll topple forward into the ground.  If I smell whisker fruit or a woman in heat I start to feel faint!  I already grew as big as " + (flags["COC.KATHERINE_URTA_TIMES_SEX"] > 0 ? "Urta" : "most centaurs") + " for you " + kathPlayerText() + ", please don’t make me grow any more.</i>”\n\n");
		output("She puts her arms around your legs and adds, “<i>I know I can satisfy you.  Let me show you.</i>”");
		katSexMenu();
	}
	else if (flags["COC.KATHERINE_UNLOCKED"] >= 4) {
		output("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and I’m almost as long as Urta.  I mean I like Urta, I just don’t think I need a cock quite that big,</i>” she says.\n\n");
		output("“<i>It is nice to know you’re thinking of me,</i>” she adds, quickly trying to make nice with you.");
		//if (urtaFuckbuddy()) output("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		katherineMenu();
	}
	else {
		output("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and if I get much longer I'll be like that poor sap who leads the guard - can't get a date because there's nobody big enough for me to stick my cock in,</i>” she declares, crossing her arms and looking firm.\n\n");
		output("“<i>Though if you have anything else you're thinking of giving, I'm sure we can salvage the gesture.  Otherwise, thank you for thinking of me,</i>” she adds, quickly trying to make nice with you.");
		katherineMenu();
    }
}

private function giveKatWhiskerFruit():void {
	clearOutput();
	output("You offer Katherine the small, fuzzy fruit with a smile.  Kath’s pupils begin to dilate and you notice ");
	if (kath.hasCock())
		output("a telltale swelling beneath her clothes.\n\n");
	else output("her nipples have grow as hard as diamonds.\n\n");
	if (!kath.hasCock() || !kath.hasCock(GLOBAL.TYPE_CANINE)) {
		output("She takes the fruit and gives you a big grin as she bites into it, sucking up all the juices.  Kath leans back on the bed and thrusts her chest toward you.  “<i>Oh Marae, do those ever put me in the mood.</i>”  She licks her lips seductively, closes her eyes and shudders with pent up energy.  In a barely controlled whisper she asks, “<i>How do you want me?</i>”");
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCWhiskerFruit());
		katSexMenu();
		return;
	}
	var doneBefore:Boolean = flags["COC.KBIT_SUB_CAT_DICK"] == 1;
	output("Kath steps back and waves the fruit away.  “<i>Even the smell makes me horny, but if I eat one of those whisker fruits I’ll probably lose my dog cock");
	if (doneBefore)
		output((kath.cockTotal() == 1 ? "" : "s") + ".  Is that what you want, " + kathPlayerText() + "?</i>”");
	else {
		output((kath.cockTotal() == 1 ? ".  It’s been with me so long I’ve really gotten used to having this big smooth tip and a knot to go with it" : "s.  It... well, they’ve been with me so long I’ve really got used to having these big smooth tips and the knots to go with them") + ".</i>”\n\n");
		output("She rubs at her crotch absentmindedly as she continues.  “<i>When I first ate those peppers I thought of my cock, or at least the knot, as a curse.  You were the first person who didn’t run away screaming when you saw it.</i>”  She gives you a big smile and says, “<i>" + (kath.cockTotal() == 1 ? "It’s a" : "They’re") + " part of me now.  Added by strange magic produce, but part of me nonetheless.</i>”\n\n");
		output("Her cock" + (kath.cockTotal() == 1 ? " has" : "s have") + " surely swollen to full size by now and Kath lets out a deep, rolling purr.  “<i>Now how about you put that fruit away and I show you once again just how much you mean to me?</i>”");
	}
	//if (submissiveness() >= 1) {
		output("\n\nYou walk toward Kath, holding the fruit up under her nose.  She sniffs at it and begins to pull off her clothes.  Once she’s naked she sits on the edge of the bed, her legs spread wide and her cock" + (kath.cockTotal() == 1 ? "" : "s") + " bouncing in time with her heartbeat.\n\n");
		if (!doneBefore) output("You remind her that eating any kind of pepper could give her a canine cock again.  ");
		output("As you wave the fruit under her nose her head starts to sway, almost like a pendulum, her dilated eyes following its every movement.");
		if (!doneBefore) output("  Doesn’t she want to try out a kitty cock?  See what sex is like with the cock nature intended her to have?");
		output("\n\nKath’s purring gets lower and lower in pitch.  Finally she bites down on the fruit, gently tugs it from your fingers and sucks on its juicy pulp.  When only the hard pit is left Kath flings it into the waste bin.  It sails right in and Kath pumps her fist.  She says, “<i>Nailed it,</i>” and then doubles over, clutching at her " + (kath.cockTotal() == 1 ? "member" : "twin members") + ".\n\n");
		output("You watch, amazed, as Kath’s cock" + (kath.cockTotal() == 1 ? " narrows along its entire length.  The tip  becomes" : "s narrow along their entire length.  The tips become") + " more and more pointed and little protrusions form, developing into the barbs that will bring her mates ecstasy.  Her dick" + (kath.cockTotal() == 1 ? " is" : "s are") + " now have only about a half of their former thickness.\n\n");
		output("Then the changes reach her knot");
		if (kath.cockTotal() > 1) {
			output("s.  They shrink down to nothing, then inflate again.  They do this several times, eliciting a deep moan of pleasure from Katherine each time.  Finally they stabilize, having lost half of their previous girth as well");
		}
		else {
			output(".  It shrinks down to nothing, then inflates again.  It does this several times, eliciting a deep moan of pleasure from Katherine each time.  Finally it stabilizes, having lost half of its previous girth as well");
		}
		output(".\n\n");
		output("When it's over Kath feels up and down her shaft" + (kath.cockTotal() == 1 ? "" : "s") + ".  ");
		if (!doneBefore)
			output("“<i>That’s so weird.  How come I still have " + (kath.cockTotal() == 1 ? "a knot" : "knots") + "?</i>”  She traces her " + (!kath.hasFur() ? "nails" : "claws") + " along the soft bulge of her knot" + (kath.cockTotal() == 1 ? "" : "s") + " and then smiles at you.  “<i>Guess I ate so many of those peppers that I get to keep " + (kath.cockTotal() == 1 ? "it" : "them") + ".</i>”\n\n");
		output("She puts her arms around you and kisses you hard.  “<i>And now " + kathPlayerText() + ", do you feel like trying out your new pussy cat?  " + (doneBefore ? "Nubs and knot" + (kath.cockTotal() == 1 ? "" : "s") + ", all in one" : "She’s got an all new kind of prick for you to test out") + ".</i>”");
		var oldKnot:Number = kath.cocks[0].knotMultiplier;
		kath.shiftCock(0, GLOBAL.TYPE_FELINE);
		kath.cocks[0].knotMultiplier = oldKnot;
		kath.cocks[0].cThicknessRatioRaw = 2 / 3;
		if (kath.cockTotal() > 1) {
			kath.shiftCock(1, GLOBAL.TYPE_FELINE);
			kath.cocks[1].knotMultiplier = oldKnot;
			kath.cocks[1].cThicknessRatioRaw = 2 / 3;
		}
		flags["COC.KBIT_SUB_CAT_DICK"] = 1; //Have given her a cat dick at least once
		pc.lust(10 + pc.libido() / 20);
		pc.destroyItem(new CoCWhiskerFruit());
	//}
	katSexMenu();
}

//Ambush by Vagrant Cats
public function ambushByVagrantKittyKats():void
{
	clearOutput();
	output("As you walk through Tel’Adre, taking in the sights, you catch a glimpse of some cat morphs part way down an alley.  It looks like three cat morph men have a younger cat morph woman backed into a corner.  None of the men look to be armed.  The girl is wearing a tattered dress that could once have been white and she looks worried.");
	//[Get Help] [Intervene] [Leave]
	//Can’t leave if below 25 corruption - you’re a champion after all.
	//Can’t get help if at or above 75 corruption - you’re a perverted monster after all.
	clearMenu();
	addButton(0, "Get Help", getHelpVsKittyKats);
	addButton(1, "Intervene", interveneWithKittyKats);
	addButton(14, "Leave", leaveKittyKatsLikeANeeeeeerrrrd);
}

//Get Help:
private function getHelpVsKittyKats():void
{
	clearOutput();
	output("Fighting three people at once is a lot harder than dealing with one opponent.  Still, from the look of them you could probably mop the floor with these three.  Out there in the wastes that would be the right thing to do, but Tel’Adre has its own laws and its own watch.  Since you’re an outsider you decide you’d be better off finding a patrol.");
	output("\n\nYou race to the nearest intersection and call out.  A tall lizard morph in a watch uniform pushes through a throng of people and asks you, “<i>What seems to be the problem?</i>”");
	output("\n\nYou explain what you saw and lead him back to the mouth of the alleyway.  It’s empty.  The lizard takes down your description of the situation and thanks you for doing the right thing.  He says, “<i>We’ve had a few similar reports in the past, though strangely it’s always the same woman.  I’ll get the description back to the Watch houses and all the officers will keep a sharp eye open.</i>”");
	output("\n\nFeeling you’ve done a good deed today you press on.");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Intervene:
private function interveneWithKittyKats():void
{
	clearOutput();
	output("Fighting three people at once is a lot harder than dealing with one opponent.  Still, from the look of them you could probably mop the floor with these three.  You square your shoulders and march down the alley.  If you look intimidating enough maybe they’ll just scatter.");
	output("\n\nAs you pass a few wrecked packing crates and barrels you see something leap up out of the debris that covers the earth in this alley.  Too late you recognize it to be a loop of thick cord.  You try to jump but the cord snaps tight around your ankles.");
	output("\n\nYou fall to the ground and the air is knocked out of you as half a dozen bodies land on top of you.  Something smacks the back of your skull and you see stars.  Half a brick lands in front of you and as the haze closes in your brain pieces together a single thought: “<i>Well this is embarrassing.</i>”");
	//[Next]
	//Leads Intervene (Part 2)
	clearMenu();
	addButton(0, "Next", interveneWithKittyKats2);
}

//Intervene (Part 2):
private function interveneWithKittyKats2():void
{
	clearOutput();
	output("You blink your eyes.  Ugh - even that hurts!  You can’t see anyone in front of you, but then you hear someone take a step towards you.  A male cat morph, perhaps even one of the ones who was threatening the younger woman, stands over you with a wooden plank in one hand.");
	output("\n\nA soft voice calls out, “<i>Don’t! You hit " + pc.mf("him", "her") + " awfully hard last time.  Evelyn will give you the boot if you kill " + pc.mf("him", "her") + ".</i>”");
	output("\n\nHe rolls his eyes, tosses the plank to the side and says, “<i>Fine - But if " + pc.mf("he", "she") + "’s awake " + pc.mf("he", "she") + " could get away.  You stay here and watch " + pc.mf("him", "her") + ".</i>”");
	output("\n\n“<i>You’ll put some milk aside for me, right?</i>” the voice asks, worried but hopeful.");
	output("\n\n“<i>Don’t worry, we’ll save you some,</i>” he says as he walks away.");
	output("\n\n“<i>Yeah, like last time,</i>” she mutters under her breath.");
	output("\n\nYou find that in addition to your feet you hands have been bound in front of you.  They didn’t gag you, presumably they expected you to stay unconscious a bit longer.");
	output("\n\nRolling onto your other side, you expect to see the young cat morph from before, but this girl is different.  Slightly more than 5 feet tall, she’s got jet black fur over her body and a mane of shoulder length hair that’s been dyed neon pink.  Her B-cup breasts stand out nicely on her lithe frame.  There’s a small silver bell attached to a collar around her neck.  It’s hard to gauge her age, but you think she has to be around 18 or 20.  Or rather, she would be if she were human.");
	output("\n\nYou can tell she’s a bit nervous thanks to the twitching of her slender tail.  It swishes back and forth the same way that a feral cat's might when agitated.  Since you can speak, you try to strike up a conversation with the girl.");
	//[Next]
	//Leads to Intervene (Part 3) 
	clearMenu();
	addButton(0, "Next", interveneWithKittyKats3);
}

//Intervene (Part 3):
private function interveneWithKittyKats3():void
{
	clearOutput();
	output("You ask her why she’s worried about the milk.  She looks down at you, seems to decide you aren’t much of a threat right now and sits down on the edge of a crate.");
	output("\n\n“<i>I probably shouldn’t be talking to you, but what’s the harm in it?</i>” she says, almost to herself.  Her stomach contributes to the conversation with some long, painful sounding gurgling noises.  She rubs her belly and sighs before continuing.");
	output("\n\n“<i>We need to eat, just like everyone else, and milk is the best kind of food.  All of us love milk.</i>”  Once again she stops to quiet a rumble from her stomach.  “<i>But milk goes off fast.  Last time they saved me some milk but it was almost cheese by the time it got to me.</i>”");
	//(remove 25 gems from inventory)
	pc.credits -= 250;
	output("\n\nYou ask her why she’s the one guarding you.  “<i>I’m new at this so I get all the jobs from the bottom of the barrel.</i>”  She pulls a bundle up from inside the crate she’s sitting on.  “<i>All your stuff’s here except for a few gems.  Just enough for all of us to get a meal.</i>”  She lowers the bundle back into the crate.");
	output("\n\nYou ask her why the cats don’t just take everything.  Her response is almost a panic.  “<i>Then we’d get in real trouble! No, no, no.</i>”  She calms herself down and continues.  “<i>Most people won’t go all the way to a Watch house to report a handful of missing gems.  For a thousand gems or even a hundred?  Sure.  But with us they still have all their valuable stuff - armor, weapons, anything personal.  They know the Watch isn’t going to be able to find a handful of gems, so why bother?</i>”");
	output("\n\n“<i>Lots of gangs have stripped people bare.  They always get caught.  Other gangs killed their marks so they couldn’t tell the Watch who robbed them.  The Watch <b>really</b> stomped on them.  That’s why Evelyn’s plan works so well.  We’re not enough trouble for anyone to go after and we’re never the worst people on the street.</i>”");
	//[Next]
	//Leads to Intervene (Part 4) 
	clearMenu();
	addButton(0, "Next", interveneWithKittyKats4);
}

//Intervene (Part 4):
private function interveneWithKittyKats4():void
{
	clearOutput();
	output("For a while you lie still and she stares off into space.  She’s obviously distracted by her hunger, but how can you use that?  A plan forms and you ask her why, if cats love milk, did they just leave you here?");
	output("\n\nShe gives you a confused look and asks, “<i>What do you mean?</i>”");

	output("\n\nYou shift on the ground and reply that you’re lactating.  She gets up and kneels beside you, stomach growling once again.");
	//(if flat chested)
	if (pc.biggestTitSize() < 3) output("\n\n“<i>But you barely even have breasts,</i>” she says, resting her hand gently on your chest.  You ask her if that means anything in Mareth.");
	else output("\n\nShe presses her hand gently against your chest and her pupils dilate.  “<i>No.  They... they must have checked, must have sniffed for it.</i>”");

	output("\n\nShe starts to fumble with your [pc.gear], her hunger clearly overriding her better judgement.  That’s your opening.  You punch upward with your bound hands, catching her in the gut and knocking the wind out of her.");
	output("\n\nShe’s not much of a fighter, and in one move, the situation is reversed.  She’s flat on her back, gasping for air, and you’re sitting on top of her, ");
	if (pc.isBiped()) output("holding her tightly between your knees"); 
	else if (pc.isNaga()) output("your snake-like coils wraped around her");
	else output("holding her tightly");
	output(".  If she gets her wits about her she might still be able to escape, so you put your hands over her mouth and tell her to untie you in your most commanding tone.");
	output("\n\nShe freezes in place, staring into your eyes.  Then her fingers reach up and, after some fumbling, free your hands.  You remind her that considering she just robbed you calling out isn’t a good idea.  Then you take your hands away and ask what her name is.");
	//[Next]
	//Leads to Intervene (Part 5) 
	clearMenu();
	addButton(0, "Next", interveneWithKittyKats5);
}

//Intervene (Part 5):
private function interveneWithKittyKats5():void
{
	clearOutput();
	output("“<i>Kath - Katherine,</i>”  she blurts out.  That’s when you feel something growing between you.  A hot bump seems to have developed.  It dawns on you that this very feminine kitty is actually a herm, and from the size and pressure of that bump you’re guessing she’s packing a real monster down there.");
	output("\n\n“<i>P - Please - nooo!</i>” she cries, but it’s too late.  Her belt can’t cinch tight enough and her cock snakes through the gap between her tattered pants and her belly.  You suspect she’d be turning bright red if it weren’t for her fur.  Speaking of red, the cock is bright red and doesn’t belong on any kind of cat.  The continued swelling near the base confirms it.  Katherine has the cock of a canine, and that cock has a huge knot.");
	output("\n\nShe whimpers, “<i>I just wanted food,</i>” and tries to hide her cock by curling into a ball under you. ");
	output("\n\nIf you help Kath, it might pay off in more than karma... if you're into that sort of thing.  You could also turn your back on her, likely forever.");
	clearMenu();
	addButton(0, "Help", helpKathAfterInterruptu);
	addButton(1, "Leave", leaveKathYouDontWantThatNastyHermCock);
}

private function leaveKathYouDontWantThatNastyHermCock():void
{
	clearOutput();
	output("You decide you’re better off not getting involved with some weird sort of hermaphroditic chimera.  She's obviously more trouble than she's worth and best avoided.");
	output("\n\nPutting it out of your mind you walk deeper into the city.  You’ve got things to take care of.");
	flags["COC.KATHERINE_RANDOM_RECRUITMENT_DISABLED"] = 1;
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function helpKathAfterInterruptu():void
{
	clearOutput();
	//(corruption <25)
	if(pc.cor() < 25) output("You feel you just have to do something for her.  She needs food and she’s ashamed of her own body.  That’s rare in this land, but it’s not a good way to live your life.");
	else if(pc.cor() < 75) output("Right now she needs food, no question.  If you help her out maybe she’ll be more willing to talk to you in future.  Maybe you can become a friend to her, maybe more.");
	else output("You could take her here and now, but her ‘friends’ might come back and help her.  Or a member of the Watch might find you.  Better to play the long game with this very fuckable kitty.");
	//(Set KATHERINE_UNLOCKED to -1)
	flags["COC.KATHERINE_UNLOCKED"] = -1;
	
	//(remove 10 gems from inventory)
	pc.credits -= 100;
	output("\n\nYou free your [pc.legs], go to the crate, and collect your gear.  Katherine remains on the ground, eyes squeezed shut.  She’s tucked her erection inside her shirt and she’s clutching it to herself, seemingly trying to force it to die down.  You count out 10 gems and press them into her hand.");
	output("\n\nHer eyes pop open and she stares at the gems.  “<i>But... but I... we... robbed you.</i>”  You give her a pat on the shoulder and tell her to get something to eat.  She springs up from the ground and hugs your [pc.legs], whispering, “<i>Thank you thank you thank you.  I won’t tell anyone, thank you so much.</i>”");
	output("\n\nYou stride out of the alley, hoping that you’ll meet Katherine again.");
	//[Next]
	//Proceed to normal Tel’Adre menu
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Leave:
private function leaveKittyKatsLikeANeeeeeerrrrd():void
{
	clearOutput();
	output("You decide you’re better off not getting involved.  After all, who knows what she’s done?  She’s obviously a stray and could have stolen something from one of the others.  Heck, with all the perverts you’ve seen in this land she could have a rape fetish.  Surely she would scream to attract the guard if she were in real trouble.");
	output("\n\nPutting it out of your mind you walk deeper into the city.  You’ve got things to take care of.");
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Second Ambush - First time with Katherine
//This only happens if you intervened the first time (KATHERINE_UNLOCKED == -1)
//Otherwise you would just run into the first ambush once again. As with the first ambush this one should not trigger if the PC has less than 35 gems.
public function repeatAmbushKatherineRecruitMent():void
{
	clearOutput();
	output("As you walk the streets of Tel’Adre, a familiar sight catches your eye.  In a nearby alley, a young looking cat-morph is being backed into a corner by three larger cat-morph men.  Though you still don’t know the girl’s name you remember the setup.");
	output("\n\nYes, there are just enough dilapidated crates to conceal three or four more cats in ambush positions.  You can’t see Kath, but you");
	if(pc.cor() < 75) output(" hope she’s here so you can get to know her better.");
	else 
	{
		if(pc.hasCock() && pc.hasVagina()) output("r dick swells and your pussy moistens");
		else if(pc.hasCock()) output("r dick swells");
		else if(pc.hasVagina()) output("r pussy moistens");
		else output("r sphincter twitches");
		output(" at the thought of her flexible body and perky tits.");
	}
	output("  You’re a lot less keen about the idea of getting whacked across the head again.");

	output("\n\nWith that in mind you run into the alley but skid to a stop just short of the crates.  The snare pops up from the debris and snaps to the side.  Someone hiding inside one of the barrels says, “<i>Shit!</i>”  Speaking loudly enough that everyone in the alleyway should be able to hear, you let them know that they might as well come out.  You’ve seen this trick once before.");
	output("\n\nSince you haven’t drawn a weapon and don’t sound too angry, some cat morphs start coming out from inside different crates and barrels.  Some look wary, others a little sheepish.  Kath stands up, recognizes you, and tries to hide it.  She drops the cord she was holding and stares at her feet.");
	output("\n\nYou ask who’s in charge.  A middle-aged woman steps forward.  She’s got ginger colored fur and decent sized muscles for a cat morph.  She must be the Evelyn that Kath mentioned last time.  Her blue eyes study you carefully.");
	output("\n\nYou could try to bargain for some time with Kath, you could donate some gems to feed them, or you could try threatening her.");
	//[Bargain] [Donate] [Threaten]
	clearMenu();
	addButton(0, "Bargain", bargainForKittahKatPussah);
	addButton(1, "Donate", donateToCatSlutsYouCatSlut);
	addButton(2, "Threaten", threatenCatSluts);
}

//Bargain:
private function bargainForKittahKatPussah():void
{
	clearOutput();
	output("Since sex is so prevalent in this land, you decide to try something that would have got you in a load of trouble back in Ingnam.  You tell Evelyn that you’d be willing to give the rest of them some gems in exchange for a little time with one of her friends.");
	output("\n\nEvelyn’s expression doesn’t change.  There are some murmurs from the cat morphs behind her, so you press on.  You look over the small crowd, letting your eyes linger here and there.  The younger girl in the tattered dress shrinks back under your gaze.");
	output("\n\nYou point at Katherine and hold out 25 gems.  You point out that it’s how much they would have taken anyway.  This way they don’t have to rush because nobody’s going to call the Watch, nobody’s going to report a theft.");
	//(remove 25 gems from inventory)
	pc.credits -= 250;
	output("\n\nEvelyn seems to consider for a moment, then takes the gems.  She growls that it’s cruel to prey on people’s hunger, and she points at Kath, telling you she’d better not get hurt.  Then she and the others take off, probably making a beeline to the nearest milk vendor.");
	//[Next]
	//Leads to Bargain (Part 2)
	clearMenu();
	addButton(0, "Next", bargainForKittahKataPussah2);
}

//Bargain (Part 2):
private function bargainForKittahKataPussah2():void
{
	clearOutput();
	output("Kath’s shoulders sag, and she sits down heavily on a crate.  She looks up at you and says, “<i>I joined the vagrant cats so I wouldn’t have to sell myself.  Not that most people want me.  And now my ‘friends’ just sold my ass for a drink of milk.</i>”  She sniffs a little and adds, “<i>I won’t fight, there’s no point.  Just do whatever you want.</i>”");
	//(corruption <25)
	if(pc.cor() < 25) output("\n\nIt really breaks your heart.  She’s so crushed right now that you have got to find some way to help her, some way to lift her spirits.");
	else if(pc.cor() < 75) output("\n\nYou’re sure that right now Kath needs a shoulder to cry on.  A nastier part of you, a part with a strong connection to your groin, whispers that vulnerable girls love heroes.");
	else output("\n\nYou promised yourself you’d play the long game with this pussy.  It takes all you’ve got not to tear her clothes off and rape her every way possible.  You have visions of her violated body curled in a ball and covered in your seed.  Finally you snap out of it.");
	output("  She tenses as you put an arm around her shoulders.");

	output("\n\nYou point out that all you asked for was a little time with her.  Next, you ask if she’d like to take a walk with you.  You’re sure you saw a restaurant just down the street that would be a great place to take her on a date.  Her jaw opens and closes but no words come out.  Her stomach rumbles, trying to answer for her.");
	output("\n\nShe jumps to her feet and wipes the hint of tears from her eyes.  “<i>You really want to take <b>me</b> on a date?</i>”");
	output("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You can’t see her blush, but you can feel the warmth right through her fur.");
	//[Next] //Leads to Second Talk with Katherine
	clearMenu();
	addButton(0, "Next", secondTalkWithKatherine);
}

//Donate:
private function donateToCatSlutsYouCatSlut():void
{
	clearOutput();
	output("You tell the cat morphs that you know they’re just doing this because they’re hungry.  You say that last time they needed 25 gems and you stick your hand into your coinpurse, pulling out a handful of stones.");
	//(remove 25 gems from inventory)
	pc.credits -= 250;

	output("\n\nEvelyn steps forward and takes the gems you’re offering.  She takes a long look at you and the gems, probably trying to decide if this is some strange kind of trap or trick.");
	output("\n\n“<i>Thank you stranger,</i>” she says, and you can tell she isn’t used to saying those words.  “<i>Now just to make sure you don’t run into any more trouble I’ll have one of my friends escort you wherever it is you’re going.</i>”  Of course that also means that if you went to the Watch someone could warn the others to lie low.");
	output("\n\nYou see Katherine is just about to pipe up when one of the others says, “<i>It’s Kath’s turn.</i>”  With milk on the menu, watching someone is the last thing most of them want to do.  She spins around, looking like she’s about to argue.  Her jaw snaps shut as she remembers that even if this is unfair it happens to be what she wants.");
	output("\n\nEvelyn nods and says, “<i>I suppose it is.  Just remember that makes it Reth’s turn next time.</i>”  Then she and the others take off, probably making a beeline to the nearest milk seller.");
	//[Next]
	//Leads to Donate (Part 2)
	clearMenu();
	addButton(0, "Next", donateToCatSlutsYouCatSlutPt2);
}

//Donate (Part 2):
private function donateToCatSlutsYouCatSlutPt2():void
{
	clearOutput();
	output("Kath leans against the wall and tries to flick some grime off her shirt.  Once the other cat morphs are out of the alley she quietly asks where you’re going.  You say that on the way here you saw a restaurant just down the street.  Would she like to accompany you?");
	output("\n\nHer head sinks a little and says, “<i>I don’t have any money.</i>”");
	output("\n\nYou walk over to her and take her hand, telling her that you’re buying.");
	output("\n\n“<i>Wait - doesn’t that almost make it a date?</i>” she asks.");
	output("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You can’t see her blush, but you can feel the warmth right through her fur.");
	output("\n\nShe pounces on you, wrapping her arms around you.  “<i>You really want to take <b>me</b> on a date?</i>” she asks, her voice filled with hope. ");
	//(corruption <25)
	if(pc.cor() < 25) output("You tell her that of course you want to.  She seems like a nice person, and you want to get to know her better.");
	else if(pc.cor() < 75) output("You say that yes, you would love to take her out on a date.  You don’t say that you’d like even more to press her vulnerable body against the wall and have your way with her.");
	else output("You promised yourself you’d play the long game with this pussy.  She already defers to you so quickly - with just a little work up front you could have a really submissive little fuck toy.");
	//[Next]
	//Leads to Second Talk with Katherine
	clearMenu();
	addButton(0, "Next", secondTalkWithKatherine);
}

//Threaten:
private function threatenCatSluts():void
{
	clearOutput();
	output("You cross your arms and tell Evelyn that her little ambush isn’t going to work a second time.  They can either scram, now, and set up in some other alley, or they can try and take you.");
	output("\n\nSome of the cats look like they’re sizing you up but Evelyn speaks quickly to keep them in line.  “<i>This one’s more trouble than " + pc.mf("he", "she") + "’s worth.  Grab the stuff and we'll set up somewhere else.  There’s more fish in the sea.</i>”");
	output("\n\nWhile she’s talking you see Kath wink at you.  You wait for the cat morph gang to clear out then walk out onto the street.  Soon enough you hear some footsteps behind you. Katherine is there, alone.  “<i>Hi,</i>” she says.  “<i>I, um, was wondering if I’d see you again.</i>”");

	//(corruption <25)
	if(pc.cor() < 25) output("The poor girl is desperate for a friend.  You hope you can be a good enough person and help her out.");
	else if(pc.cor() < 75) output("It’s a real shame Katherine is so lonely.  She shouldn’t be willing to trust a virtual stranger like you, but here she is and here you are.");
	else output("You can’t wait to twist this submissive thing around your finger.  She’s got almost no one, and that means almost no one to tell her what a bad influence you will be.  With just a little work up front you could have a really submissive little fuck toy.");
	output("  You give her a smile and take her hand, asking her if she might like any of the dishes at the restaurant just down the street.  It seemed like a good place for a date.");
	output("\n\nShe must be blushing because you can feel the warmth through her fur.  She tries to speak, but for a while no words come out.  Then finally she says, “<i>You really want to take <b>me</b> on a date?</i>”");
	output("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You didn’t walk into that ambush a second time for yourself.  You did it because you wanted to see her.  Katherine’s eyes light up and she squeezes you tight as though she wants to make sure this is real.");
	//[Next]
	//Leads to Second Talk with Katherine
	clearMenu();
	addButton(0, "Next", secondTalkWithKatherine);
}

//Second Talk with Katherine:
private function secondTalkWithKatherine():void
{
	clearOutput();
	output("A short walk takes you to the restaurant where you grab a table and ask Katherine what she’d like.  Without hesitation she says, “<i>A milkshake!  Oh, it’s been soooo long since I had one.</i>”");
	//(remove 10 gems from inventory)
	pc.credits -= 100;
	output("You had hoped that you might be able to talk to her over food, but when the milkshake arrives Kath drinks it with gusto.  In under a minute the whole thing is gone and Kath looks at you sheepishly while rubbing away the little milk mustache she gave herself.  “<i>Sorry, I really needed that.</i>”  She looks around and adds, “<i>Besides, maybe we could talk somewhere else.</i>”");
	output("\n\nLooking around the restaurant you see what she means.  Her scruffy clothes are as distinctive as a watch badge.  Katherine and other vagrants aren’t really welcome, the restaurant is only putting up with her because you look respectable.");
	output("\n\nYou pay the bill quickly and Katherine leads you back into the streets.  For some reason she seems excited and nervous, though you aren’t sure why.  She soon finds a quiet corner in a bricked off alleyway between two buildings.  She sits on the edge of a broken desk and fidgets.");
	//[Next]
	//Leads to First Time with Katherine
	clearMenu();
	addButton(0, "Next", firstTimeWithKatherineUTerribleScrub);
}

//First Time with Katherine:
private function firstTimeWithKatherineUTerribleScrub():void
{
	clearOutput();
	output("You ask Katherine what’s wrong.  She looks at her feet and asks, “<i>Why are you being so nice to me?  I like you, but I don’t know why you like me and - and I don’t want to screw up.</i>”");
	output("\n\nYou sit next to her and tell her you like her because she seems nice; she’s really pretty and you want to give her a hand.");
	output("\n\n“<i>I’m pretty?</i>” she says.  “<i>You keep saying things like that but-</i>” she waves in the general direction of her crotch “<i>-you know what I am.  You know what I have down there.  I’ve got a knot bigger than any boy I’ve ever seen and I don’t even have the right <b>kind</b> of... penis.</i>”");

	if(pc.cor() < 25) 
	{
		output("\n\nYou tell her that love is blind.  So she has a dog cock.  If that bothered you then you wouldn’t be here, would you?  You want to get to know her because you like her, all of her.");
		output("\n\nKath just leans against you, not responding to any of what you’re saying.  She must think everyone secretly hates her cock, and she’ll never be able to get over the risk of rejection on her own.  You get the feeling that if you don’t take the lead, she will never be able to believe she’s worth anything.");
		output("\n\nYou ask her if she trusts you.  She nods ever so slightly, and you kiss her.  Her lips are trembling and her eyes are screwed shut.  You kiss her lips slowly and gently until you feel her begin to respond.");
		output("\n\nHer hand moves to her pants, trying to contain her growing erection.  Again you ask her to trust you, and you pull her hand away, letting the tip of her cock snake out into the open.");
		output("\n\nYou tell her that right now she needs to lie still and let you show her that you love her.  You take each of her hands in yours and press them against the wall on either side of her head.  She lets you and then you begin to run your hands up and down her sides, over her breasts, and across her belly.");
		output("\n\nWith each stroke, you see her cock slip further out of its sheath.");
	}
	else if(pc.cor() < 75)
	{
		output("\n\nYou tell her that you’ve travelled outside Tel’Adre.  You’ve seen many weird and wonderful things.  Is she really that terrible?  She’s clearly no demon, you would recognize that and so would the Watch.");
		output("\n\nKath just leans against you, not responding to any of what you’re saying.");
		output("\n\nYou tell her you can prove it to her.  You [pc.arm] goes around her back and you start to gently rub the nape of her neck.  She tries to argue but you press a finger to her lips and wink.");
		output("\n\nThe excitement and nervousness from before boil over.  It’s like her mind just can’t decide what to do.  Her body, on the other hand, knows exactly what to do.  You see that python-sized cock begin to tent her pants.");
		output("\n\nShe reaches down, attempting to contain it, but you block her and take hold of her wrist.  The rest of her canine cock bursts free and you blow gently on the head, encouraging it to poke even further out of its sheath.");
	}
	else
	{
		output("\n\nYou tell Kath that you’re about to prove that you want her, and not just as a friend.  You use one [pc.arm] to press her against the wall, taking the opportunity to grope those perky breasts.  Before she can react, you use your other hand to reach down into her pants and rub her big flaccid cock.");
		output("\n\nKath moans, and in seconds, her cock begins to slide from its sheath.  You make room so that it can escape from her trousers and stand proud in the open air.  She looks shocked and her mouth is slightly open, so you press your lips to hers.  She closes her eyes as you slide your [pc.tongue] into her mouth, wrestling with Katherine’s own rough tongue for position.");
		output("\n\nMeanwhile, your hands have done their work.  Her nipples have begun to poke through the thin fabric of her shirt.  Her cock feels warm and hard; through your fingers you can feel her rapidly increasing heartbeat.");
		output("\n\nYou break the kiss and tell her, “<i>Kath - <b>you</b> want this.</i>”");
	}
	output("\n\nKatherine lets out a quiet, “<i>Yes,</i>” and that’s all you need.");
	//[Next]
	//Leads to the new handjob scene, described later in this document
	initKathFlags();
	clearMenu();
	addButton(0, "Next", handjobbiesFurrDemCatFurries);
}

//Handjob Scene
//This is used in the new recruitment path and is also available as a repeatable scene once
//Katherine is accessible in the alley behind the pawn shop. At the pawn shop I think this scene //should be available even if lust < 33, since you’re doing this for and to her.
//Makes use of katKnot(), a new helper function which is listed under implementation details.
public function handjobbiesFurrDemCatFurries():void
{
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	if (kathIsAt(KLOC_BAR) || kathIsAt(KLOC_BAR_DRUNK) || kathIsAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		output("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		output("You take her hand and lead her outside, to " + (flags["COC.TIMES_FUCKED_URTA"] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		output("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
	}
	output("You pull Kath into your lap and she purrs.  Both your hands slide under her shirt and begin to ");
	if (pc.cor() < 25) output("slowly caress her tender breasts");
	else if (pc.cor() < 75) output("tease her lovely breasts");
	else output("roughly manhandle her knockers");
	if (kath.milkFullness >= 100) output(".  Your fingers are soon coated in her cream and you offer them to Kath, who eagerly licks them clean");
	output(".  Her tail, trapped between your body and hers, flicks back and forth");
	if (pc.hasCock()) output(", causing your [pc.multiCocks] to rise to the occasion.");
	else if (pc.hasVagina()) output(", teasing your hot little slit.");
	//(genderless)
	else output("in a seductive manner.");

	output("\n\nOnce Kath’s nipples are rock hard you slide your fingers down the soft [kath.skinFurScales] of her belly until they find ");
	if (!kath.hasCock()) {
		output("her hot, moist snatch.  A few strokes and you’ve spread her soft, wet lips.  While one hand slips inside to plumb her depths the other latches onto her clit and starts massaging the little nub.");
		output("\n\nThe heat is intense and Kath’s pussy dribbles at your ministrations.  Kath’s hips jerk forward, her body begging for a cock to fill her up.");
	}
	else if (kath.cockTotal() > 1) {
		output("the tips of her hot shafts.  A few strokes and you’ve spread her copious precum over both of her cocks.  While one hand continues to pleasure her pricks the other goes lower, slipping " + (flags["COC.KATHERINE_UNLOCKED"] < 1 ? "under her belt and into her pants." : "into her moist snatch."));
		output("\n\nThe heat is intense and Kath’s " + kath.knotAdj() + " knots swell at your ministrations.  Kath’s hips jerk forward, looking for a pussy or two to pack them into.");
	}
	else {
		output("the tip of her hot shaft.  A few strokes and you’ve spread her copious precum over most of her cock.  While one hand pleasures her prick the other goes lower, slipping " + (flags["COC.KATHERINE_UNLOCKED"] < 1 ? "under her belt and into her pants." : "into her moist snatch."));
		output("\n\nThe heat is intense and Kath’s " + kath.knotAdj() + " knot swells at your ministrations.  Kath’s hips jerk forward, looking for a pussy to pack it into.");
	}
	if (kath.hasCock()) {
		output("\n\nKath’s next moan comes from the bottom of her lungs.  Thanks to you she’s already horny and now you decide to overload her senses.  Your fingers " + (kath.balls > 0 ? "cup her balls" : "tease her clit") + " for just a moment before slipping " + (kath.cockTotal() < 2 ? "back " : "") + "into her dripping cunt.");
		output("\n\nHer head tilts back, and she tries to find your mouth with her own.  As your tongues entwine, you begin to slide your fingers in and out of her slit, making sure to rub hard against her tiny nub.  Your other hand ");
		if (kath.cockTotal() > 1) {
			output("works up and down her " + kath.cockAdj() + "shafts, alternating from one to the other.  Soon you can feel them both twitching, ready to fire their loads into a pair of fertile pussies.");
			output("\n\nYou aim Katherine’s dicks");
		}
		else {	
			output("works up and down her " + kath.cockAdj() + "shaft.  Soon you can feel it twitching, ready to fire its load into a fertile pussy.");
			output("\n\nYou aim Katherine’s dick");
		}
		output(" at the " + (kathIsAt(KLOC_DESERT) ? "ground" : "wall") + ".  You pull your fingers from her pussy and rub her wetness over " + (kath.balls > 0 ? "her fuzzy balls" : "her growing knot") + ".  Pulling your head back you tell Kath to cum for you.  She gasps and you feel " + (kath.balls > 0 ? "that [kath.balls] contract" : "her [kath.cocksLight] twitch and harden") + " as Kath lets loose with who knows how much pent up cum.");
		output("\n\nYou’re not done with her yet.  As the first shot splatters against the ");
		if (kathIsAt(KLOC_DESERT))
			output((hours > 7 && hours <= 18 ? "hot" : "cool") + " sand");
		else output(kathIsAt(KLOC_KATHS_APT) ? "plaster" : "brickwork");
		output(" you slip your fingers back to her cunt and attack her clit.  Despite already being in the midst of one orgasm, Kath’s body tenses up even more.  It feels like a cup of water gushes from her pussy and the next blast from her [kath.cocksLight] is even stronger, " + (kathIsAt(KLOC_DESERT) ? "arcing a good six inches further " : "hitting the wall a good six inches higher") + " than the first.");
	}
	else output("\n\nHer head tilts back, and she tries to find your mouth with her own.  As your tongues entwine, you push deeper than ever, massaging her inner walls and rubbing hard against her tiny nub.  Pulling your head back you tell Kath to cum for you.  She gasps and you feel a deluge inside her pussy.  Her muscles vice down on your fingers as if they want to keep them inside forever.");

	output("\n\nKath turns to liquid in your arms as several more orgasms wash over her like the aftershocks of an earthquake.  All she can do is look up into your eyes and smile.  ");
	if (pc.cor() < 25) output("You hold her in your arms while she recovers.  You really enjoy seeing the happiness and contentment in her face.");
	else if (pc.cor() < 75) output("While you wait for her to recover you pull her shirt up and play with her breasts a bit more.  By the time she can move again her nipples are sticking out like little berries.  She blushes, but clearly enjoys the attention.");
	else {
		output("Not one to pass up a helpless young " + (kath.hasCock() ? "herm" : "girl") + " you " + (flags["COC.KATHERINE_UNLOCKED"] < 1 ? "strip all Katherine’s clothes off.  You" : "") + " play with her tail, eventually growing bored and pushing the tip deep inside her pussy.\n\n");
		if (kath.hasCock())
			output("Next you run your hand" + (kathIsAt(KLOC_DESERT) ? (kath.cockTotal() == 1 ? " along her cock" : "s along her cocks") : " over the wall") + ", collect some of her still warm spunk");
		else output("Next you collect some of her [kath.femCum] on your fingers");
		output(" and offer it to her.  Kath’s rough tongue licks every drop from your hand while you think of all the things you’d like to do with her body.");
	}
	if (kathIsAt(KLOC_DESERT)) {
		processTime(15 + rand(10));
		output("\n\nWith training over for now you get Katherine to pack up her equipment and lead her back to Tel'Adre.  When you reach her alley Kath throws herself on the pile of softer scraps she's collected and says <i>“Please come back soon [pc.name], I'll do better next time.”</i>");
	}
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	pc.lust(33);
	processTime(15);
	clearMenu();
	if (flags["COC.KATHERINE_UNLOCKED"] == - 1) addButton(0, "Next", firstTimeWithKatherinePartTwoUltraChampionshipEditionHyperTurbo);
	else addButton(0, "Next", telAdreMenu);
}

//First Time with Katherine (Part 2):
private function firstTimeWithKatherinePartTwoUltraChampionshipEditionHyperTurbo():void
{
	clearOutput();
	output("You help Kath get to her feet and she gives you a big hug.  A few sniffles lead to some sobs before she pulls herself together enough to say, “<i>I didn’t believe anyone cared about me.</i>”");
	//(corruption <25)
	if(pc.cor() < 25) output("\n\nYou assure her that you do, and that you want to see her again.  In fact you hope to see her often and you would love to get to know her better.");
	//(corruption < 75)
	else if(pc.cor() < 75) output("\n\nYou assure her that you do, and that you want to see her again.  In fact, you hope to see her often, and you would love to get to know her better.  What you don’t add is that you mean ‘get to know her’ both in terms of friendship and carnally.");
	//(corruption >= 75)
	else output("\n\nYou debate just crushing her spirits right here and now, but she’s so delightfully submissive.  You can find (or make) an abused fucktoy just about anywhere in Mareth, but what are the chances of finding a naturally submissive, needy young herm with no friends or family?\n\nTickling her clit once more, you assure her that you want to see a lot more of her and you would love to introduce her to some new experiences.");
	output("\n\nKath beams and says, “<i>I don’t want you to risk getting ambushed every time you want to see me.  I know another gang got captured by the Watch.  They used to hang out behind one of the pawn shops.  It’s run by a retriever named Oswald.  I don’t know for how long, but right now nobody’s living there, so if you’re looking for me I’ll be there.  Besides, Oswald is a good guy, he doesn’t try to cheat people like me just cause we can’t sell things very easily.</i>”");
	output("\n\nYou ask her about her gang.  “<i>The vagrant cats?</i>”  She shakes her head.  “<i>They’ve always treated me like the runt of the litter because I don’t like hurting people or selling myself.  The only other person who they treat almost as bad is Helena.  You’ve seen her, she’s the young-looking one they put in the dress.</i>”");
	output("\n\nShe kicks aside a stone and says, “<i>I managed on my own for a while before I started running with a gang.  It wasn’t that I couldn’t find enough food, I was just lonely.</i>”");
	output("\n\nYou agree to meet up with her later, though you say that with your duties at the portal you don’t know how often or when you’ll be able to see her.");
	output("\n\n“<i>That’s okay, it’s more the fact I know you’ll come back... for me.</i>”  Then she says with a start, “<i>Oh, hey! I don’t even know your name.</i>”");
	output("\n\nYou smile and tell her.");
	output("\n\n“<i>[pc.name]</i>” she says");
	if(InCollection(pc.short, "Kath", "Katherine", "Helena", "Evelyn", "Oswald")) output(".  “<i>Well isn’t that a coincidence! All right, ");
	else output(", rolling the foreign word around in her mouth. “<i>Well, ");
	output("[pc.name], that was an amazing first date.  I hope we can do some more things like that - and believe me, I’ve got some ideas!");
	
	//(Set KATHERINE_UNLOCKED to 1)
	flags["COC.KATHERINE_UNLOCKED"] = 1; //If Kath was recruited through Scyllia then KATHERINE_MET_SCYLLA will be set to 1
	
	output("\n\n(<b>Kath's alley is now added to homes!</b>)");
	processTime(15);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

public function kathNeedIntroductionFromScylla():Boolean {
	return hours > 8 && hours < 18 && pc.hasKeyItem("Silver Kitty-Bell");
}

//If player has Silver Bell key item and is at Wet Bitch when Scylla is not busy with her Addicts Anonymous group
public function catMorphIntr():void {
	output("\n\nThe cum-drinking nun Scylla is here, apparently resting up between one of her missions.  Recalling the last 'mission' you went on, your hand unthinkingly touches the silver bell you received from that strange herm cat-morph.  Scylla could probably help you find her again.");
}

public function katherineGreeting():void {
	clearOutput();
	//[If Player chooses 'Scylla' button]
	output("Scylla smiles when she sees you approaching, and politely greets you.  “<i>Why, hello, " + pc.short + "; it's good to see you.  Do you need something?</i>”\n\n");

	output("You tell her that you do, and, showing her the bell you have, you ask her if she remembers that little mission the two of you went on where she ended up ministering to those milk-hungry cats.\n\n");

	output("Scylla nods, a pleased expression and a soft blush blooming on her features.  “<i>Yes.  Poor things... to be so hungry as to do something like that.</i>”  Then she stops and her eyes focus on the bell, glittering with mirth.  “<i>I take it you want to see the friendly dear who gave you that bell again?</i>” she asks.  When you admit that is what you hoped she'd help you with, she promptly stands up, decisively.  “<i>Well then, let's go and re-introduce you two.</i>”  She smiles softly as she turns and walks away at a brisk pace, forcing you to hurry to catch up.\n\n");

	output("Scylla takes you on a very different route from the last time you 'encountered' the cat-morphs in question, leading you to a surprisingly seedy part of the city.  Strangely, despite all of the houses you know are empty and uninhabited from the people lost to the demons, there are myriad people around who are quite clearly vagrants.  Centaurs, dog-morphs, cat-morphs, mouse-morphs, fox-morphs, wolf-morphs, and stranger things beside - you think you see something that looks vaguely like a centaur/wolf-morph hybrid at one point.  Curious, you can't help but ask Scylla what you're doing here.\n\n");

	output("The towering nun suddenly calls out.  “<i>I did a little asking around after that first incident.  They told me that those cats in particular like to hang out in this part of town.  In fact... there!  Hello!  Mr. Kitty?  I want to talk with you and your friends...  Maybe, if you're thirsty, I can offer you a drink?</i>”\n\n");

	output("You're caught off-guard by Scylla's actions, but then spot a familiar-ish feline face peeking warily out from behind a corner.  You make a point of walking away from Scylla, and one of the male cats who basically mugged Scylla for her milk promptly slips out of hiding, the other eleven or so males and females quickly joining him.  The mutated nun, smiling with all three lips, is already innocently removing her habit to expose her huge, milk-filled breasts.  The cats barely hesitate before swarming towards her, pushing and shoving to be the first to start making out with her lipples and drinking their fill of creamy nun-milk.  You watch the situation dispassionately - it is, after all, a lot more voluntary on Scylla's part than it was the first time - and then pull out the silver bell, which you start idly jingling.\n\n");

	output("“<i>...Is that really you?  You actually came?</i>”  A voice from just off to the side sounds; quiet, hesitant, filled with hope, doubt and fear in equal parts.\n\n");

	output("Looking around, you quickly spot the lonely herm cat-morph, the reason behind your coming here.  Still dressed in her ragged clothes, her too-large shirt covers up her B-cup breasts, while her too-tight pants make her canine sheath and small balls stand out to a casual observer.  Under these calmer conditions, you can make out her eyes, a rather pretty shade of green, while her shoulder-length hair is neon pink, a stark contrast to her black fur.  Funny, you don't recall it being that color before... finally remembering that she's addressed you, you smile and agree.\n\n");

	output("She looks from you to the small milk-drinking orgy and then shyly indicates an alleyway nearby.  “<i>Do you want to talk somewhere more privately?</i>” she asks.  When you indicate your assent, she gives a relieved smile and leads you away.  Once you're out of sight of the other cats, she suddenly hugs you fiercely.  “<i>I can't believe you actually came!  Oh, I dreamed that this would happen!</i>”  She purrs, happily rubbing her cheek against you, then pulls away timidly, blushing brightly.  “<i>I'm sorry... It's just,  I've never had anyone show interest in me before.  Not with this...</i>”  She strokes the bulge of her puppy pecker meaningfully.  Then, a thought seems to occur to her and she turns a fearful look at you.  “<i>You - are - interested in me, aren't you?  You didn't come here just to tell me off for liking you?</i>”  From the tone of her voice, this last question was more a plea than an icebreaker.\n\n");

	output("You smile and assure her that you are interested... though you have to confess that more intimate conversations may have to wait for another time.  As if on cue, the happy purring of other cat-morphs reaches you in the alleyway as they start to finish up with Scylla.\n\n");

	output("The dog-dicked cat nods.  “<i>Right.... hey, there's a pawnshop in the main street - run by a golden retriever named Oswald?  You know it?</i>”  When you nod your head, she continues, “<i>Well, Oswald's a pretty nice guy, he buys things I find sometimes and always gives me a fair price even though it's obvious how desperate I am; these guys don't really care whether I'm here or not, so I'll start hanging around in the back alley behind his place.  We can meet up there - is that okay with you?</i>”\n\n");

	output("You tell her that sounds much better than needing to get Scylla to come here as a distraction each time.  The silver bell you return to her, with a coy remark that it looks better on her anyway.  Giving you a heartfelt smile, she gently takes it, then reattaches it to her leather collar.\n\n");

	output("As you walk away, she realizes something.  “<i>Oh!  My name's Katherine!  What's yours?</i>” she asks.  With another smile, you tell her. She mouths the name to herself, her eyes a-twinkle with happiness.\n\n");

	output("The other cats are lying sprawled in the street, swollen with the milk they've drunk from Scylla, who is merrily pulling her habit back on.  She gives you a knowing look but doesn't speak as she leads you back toward the main street.");
	output("\n\n<b>(Kath's Alley unlocked in Oswald's Pawn shop menu!)</b>");

	initKathFlags();
	//Player can now encounter Katherine by using the Back Alley button at the Pawn Shop
	flags["COC.KATHERINE_UNLOCKED"] = 1;
	processTime(16);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}


/////////////////////////// Kath post-employment content

private function bedroomBondage():void {
	//If this is the first time then the player needs to have at least 40 gems to buy stuff (10g per scarf)
	clearOutput();
	if (flags["COC.KBIT_SUB_BED_BOND"] != undefined) {
		output("You walk over to Katherine’s wardrobe and soon find what you’re looking for.  You take the silk scarves in hand and walk back to Kath.  She’s got a big grin on her face and as you approach she turns her back to you, walking away so slowly you’re sure to catch up.\n\n");

		output("When you grab her and lock her arm behind her back she pretends to struggle and improvises a little roleplay, saying, “<i>Hey!  I know I was making eyes at you back at the bar, but what kind of girl do you think I am?</i>”  You laugh as you tie up your compliant pussy - it seems she likes this little game.\n\n");
	}
	else {
		output("You give Katherine a quick kiss and tell her to wait here, you have an idea.  You race through Tel’Adre’s streets, searching for one of the many vendors of sex toys and other items for the bedroom.\n\n");

		output("Not far from Kath’s you find a shop with what you need.  You pick out some silk scarves, quickly pay the merchant and make your way back to Kath’s.  She’s sitting on the edge of the bed, but springs to her feet as you return.\n\n");
		processTime(10);
		pc.credits -= 400;

		output("“<i>What’s up " + kathPlayerText() + "?</i>” she asks, her ears swivelling toward you.\n\n");

		output("Rather than answering you walk up to her, spin her around and lock her arms behind her.\n\n");

		output("“<i>Oh!  " + kathPlayerText() + " - what are you doing?</i>”\n\n");

		output("You start tying her wrists together with one of the silk scarves.  Kath wriggles, but she’s not really trying to escape.  Her tail is flicking back and forth, smacking against your [pc.legs], so she’s definitely excited.\n\n");
	}

	output("You push her onto the bed and flip her on her back.  It doesn’t take much effort to pull her clothes off.  She keeps struggling playfully but you’ve soon tied her legs to opposite sides of the bedframe.  If she weren’t a cat " + kath.catGirl("girl", "morph") + " doing the splits like this would be mildly uncomfortable.  Katherine obviously doesn’t mind and you can feel the heat radiating " + kath.catGirl("from her skin", "through her fur") + " as she grows flushed with excitement.  At last you untie her wrists just long enough to re-tie them to the head of the bed.\n\n");

	output("You take a moment to appreciate what lies before you.  Katherine is spread - eagled on the bed, her legs and hips naked" + (kath.hasCock() ? ", her hard cock" + kath.CockMultiple("", "s") + " aimed at the ceiling" : "") + " and her pussy wet and glistening.  You can see her chest rising and falling, her nipples poking against the fabric.  ");
	if (flags["COC.KBIT_SUB_BED_BOND"] != undefined) {
		output("You grin at Kath as she pretends to struggle.  You know this is one of her favorite bedroom games.\n\n");

		output("Keeping to her character Kath pants, “<i>Just cause I brought you home doesn’t mean I put out on the first date.  You seem like a nice " + pc.mf("guy", "girl") + ", let’s talk about this, huh?</i>”\n\n");
	}
	else output("If Kath doesn’t already have a fetish for getting tied up like this you plan to give her one.\n\n");

	output("You laugh and blow on her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") : "clit") + ", causing Kath to strain against her bonds.  You tell her that she should consider her position.  She’s bound hand and foot to her own bed and only you can help her reach orgasm.  You take her tail and start gently stroking the underside.  Kath rolls her hips and purrs.  Then you stop, moving to stroke her still covered breasts and give her a kiss.  You ask her how it feels, being completely at your mercy.\n\n");

	if (flags["COC.KBIT_SUB_BED_BOND"] != undefined)
		output("“<i>Oh " + pc.mf("mister", "miss") + " - that feels good.  I never sleep with someone on the first date but I think I’ll make an exception for you.</i>”");
	else output("Kath just sighs.  Her pupils are fully dilated and you doubt you’re going to hear anything coherent from her until this is over.");

	output("\n\nAt first you barely touch her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") + " or " : "") + "pussy.  Instead you tease her by stroking her breasts and running your hands over her belly and thighs.  Kath wriggles in place and the bedframe creaks but the silk scarves are strong enough to hold her.\n\n");

	output("When you finally get back to blowing on her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") : "clit") + " Kath starts to beg for more.  You stop everything and sit next to her on the bed.  You stroke her ear and tell her that she’s broken your concentration - you can't even remember what you were doing just now.  Kath whimpers and bites her tongue.  After giving her another quick kiss you start over.\n\n");

	output("This time it’s even harder for Kath.  When you start blowing on her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") + " you see precum oozing from the tip" + kath.CockMultiple("", "s") : "clit you see femcum oozing from her pussy") + " like a fountain.  " + (kath.hasCock() ? "You could take her pulse by watching her knot" + kath.CockMultiple("", "s") + " expanding and contracting.  " : "") + "Katherine must love being tied up - she’s so close to cumming that when you start massaging " + (kath.hasCock() ? "the base of her knot" + kath.CockMultiple(" it inflates and hardens", "s they inflate and harden") : "her inner labia her legs start to shiver") + " almost immediately.\n\n");

	output("You slow your pace once again and whisper in Katherine’s ear that you aren’t going to play with her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") + (kath.hasBalls() ? ", her balls" : "") + " or her " : "") + "pussy.  You’re going to prove how much she loves this by making her cum some other way.  She whimpers and you see tears forming at the corners of her eyes.\n\n");

	output("You go back to her ears and start teasing them with your fingers.  " + (kath.hasCock() ? "With every heartbeat her cock" + kath.CockMultiple("", "s") + " jump but she doesn’t cum" : "Each time she takes a breath you hear her pussy dripping juice onto the sheets") + ".  You switch to rubbing her nipples and Kath lets out a deep moan.");
	if (kath.isLactating())
		output("  In no time her breasts are soaked with rich, sugary cream and");
	else output("  By now");
	output(" her " + (kath.hasCock() ? "cock" + kath.CockMultiple(" is", "s are") : "pussy is") + " glazed from top to bottom with a thick coat of " + (kath.hasCock() ? "pre" : "fem") + "cum." + (kath.hasCock() ? "  " + kath.CockMultiple("It continues to leak like a lazy volcano", "They continue to leak like lazy volcanoes") : "") + ".\n\n");

	output("If her ears won’t do it and her breasts don’t cut it there’s one part of Kath’s body you know will set her off.  You take her tail and start to stroke it.  When you rub the muscles near the base Kath’s hips launch upwards and you hear a " + (kath.hasCock() ? "sound like a bucket of water being poured onto a wood floor.  The stream" + kath.CockMultiple(" she fires is so powerful it hits the ceiling and spatters", "s she fires are so powerful they hit the ceiling and spatter") + " all over the place like a cum sprinkler system" : "scream that starts at high pitched before passing out of the range of human hearing") + ".\n\n");

	output((kath.hasCock() ? "It takes several more shots to drain Katherine’s " + (kath.hasBalls() ? kath.ballAdj() + " balls" : "unnatural prostate") + ".  When it’s over the whole apartment is soaked in cum" : "Kath goes through several more orgasms before she's drained of energy.  When it's over the bedsheets are drenched") + " and Kath is panting and laughing like a crazy person.  " + (kath.hasCock() ? "Her body, directly beneath the rain of cum dripping from the ceiling, is coated head to toe.  " : "") + "When she recovers enough to be sensible she looks over at you and says ");
	if (flags["COC.KBIT_SUB_BED_BOND"] != undefined)
		output("“<i>Oh baby!  No one’s ever made me cum like that.  Just give me a few minutes to recover.  I want to pay you back, you’re a keeper.</i>”");
	else
		output("“<i>Oh " + kathPlayerText()  + ", that was amazing.  I’m so... spent.  Let me up and I’ll try to find the strength to do something for you.</i>”");

	var x:int = pc.cockThatFits(kath.vaginalCapacity());
	if (pc.hasCock() && x > -1) { //Males and herms (with small enough junk to fit)
		var pcLen:int = pc.cocks[x].cLength();
		output("  You sit down astride Kath and ask her why she thinks you’re going to stop?  You’ve only just warmed her up.  Now she’s ready for the main course.  Her eyes go wide and she pulls at the scarves but there’s no escape.\n\n");
		
		output("You position yourself on the bed and line " + (pc.cocks.length > 1 ? "up one of your dicks" : "your cock") + " with Kath’s slit.  " + (kath.hasCock() ? "Her cum is still dripping on your back when you push inside her.  " : "") + "She’s incredibly wet and her pussy opens itself before you, " + (kath.hasCock() ? "almost like it’s jealous of the treatment her male side received" : "begging for more even though she's shaking her head") + ".\n\n");

		output("Unlike Katherine you haven’t cum yet and your [pc.cocks] are aching for release.  You stroke her ");
		if (!kath.isPregnant()) {
			output("flat tummy and ask her where she wants your seed.\n\n");
			if (flags["COC.KBIT_SUB_BED_BOND"] != undefined)
				output("“<i>That’s what you wanted all along, isn’t it?  You want to knock up a dumb slut you found at the bar.  Well I can’t stop you, so do your best stud!</i>”");
			else output("“<i>Oh yes!  Fuck me!  Cum inside me, please!  I need it so bad,</i>” she whines.");
		}
		else { //Is pregnant
			output("pregnant belly and ask her if she does this often.\n\n");

			output("Her hips buck and some drool runs from the corner of her mouth.  ");
			if (flags["COC.KBIT_SUB_BED_BOND"] != undefined)
				output("“<i>You know I do stud.  I love getting knocked up and parading my big belly around town.  I’m sure not going to bars for the drinks right now.  Mommy needs so much cum!</i>”");
			else output("“<i>Oh " + kathPlayerText()  + ", don’t stop now.  I need that cum.  I need your hot love inside me.</i>”");
		}
		output("  With your feline lover so wet and ready you waste no time and start to hammer into her hot cunt.  Kath goes wild and even tied up she does everything she can to try and force a little more of your cock inside.\n\n");

		output("You force it as deep as you can, " + (pcLen < 15 ? "trying to make it as good for her as it is for you" : "rubbing the tip against Kath’s cervix and causing her eyes to roll back in her skull") + ".  When you cum ");
		if (pc.cumQ() <= 500)
			output("you feel a small pool of sperm form around the tip of your cock." + (!kath.isPregnant() ? "  You’re sure you can feel Kath’s cervix sucking some of it in." : ""));
		else if (pc.cumQ() <= 1500)
			output("your sperm streams from your cock and starts to pool inside Katherine.  " + (!kath.isPregnant() ? "Her belly starts to swell and you give her formerly flat belly a little rub while Kath purrs." : "With her cervix blocking the way forward most of your cum bubbles back out of Kath’s pussy."));
		else if (pc.cumQ() <= 3000) {
			output("your seed flows into Kath like a river.  ");
			if (!kath.isPregnant()) {
				output("Her cervix is forced open ");
				if (pcLen < 15)
					output("and the pressure around your cock lessens as your seed flows unimpeded into her womb");
				else
					output("and you sink into her a bit further as the " + (pcLen == 15 ? "tip" : "first " + (pcLen - 15) + " inches") + " of your cock slide into her womb");
				output(".  Kath’s belly grows larger and larger, taking all the cum you can give her until she looks five months pregnant and her belly button pops out, signaling that she can hold no more");
			}
			else output("Since her womb is already filled with a child it’s her vagina that takes the brunt of it.  Before your eyes a small hard bulge forms just above her cock" + kath.CockMultiple("", "s") + " as the upper end of her birth canal is forced wide open by the flood from your " + (pc.balls > 0 ? "balls" : "prostate"));
			output(".  The rest of your [pc.cum] flows back around your cock, pouring out onto the bed.");
		}
		else {
			output("your " + (pc.balls > 0 ? "overactive balls" : "unnatural prostate") + ", fueled by the strange magic of this world, inject" + (pc.balls > 0 ? "" : "s") + " an impossible amount of sperm into your cat " + kath.catGirl("girl", "morph") + " lover.  The breath is forced from Kath’s lungs and ");
			if (!kath.isPregnant()) {
				output("in an instant her cervix is forced open.  ");
				if (pcLen < 15)
					output("The pressure around your cock lessens as your seed flows unimpeded into her womb");
				else output("You sink into her a bit further as the " + (pcLen == 15 ? "tip" : "first " + (pcLen - 15) + " inches") + " of your cock slide into her womb");
				output(".  Kath’s belly grows larger and larger, taking in all the [pc.cumNoun] you can give her and growing by leaps and bounds.  She soon looks five or six months pregnant and her belly button pops out.  But your cum " + (pc.balls > 1 ? "factories aren't" : "factory isn't") + " done.\n\n");

				output("Your " + (pc.balls > 0 ? "balls fire" : "prostate fires") + " even higher pressure blasts, overcoming all resistance from Kath’s tortured belly and inflating her taut tummy until she looks nine months pregnant.   ");
				if (pc.cor() < 25)
					output("You hope you aren’t doing any permanent damage to Katherine with such a big load.");
				else if (pc.cor() < 75)
					output("You hope Kath is enjoying this as much as you are.");
				else
					output("Secretly you want to see just how far you can stretch out your kitty’s belly.  Even more, you want to see if you can get her addicted to the feeling of being overfilled.");

				output("\n\nKath whimpers, but her tail is wagging.  You’re pretty sure she’s enjoying herself - and if not, well she can’t do anything about it anyway.");
			}
			else
				output("the top of her birth canal balloons under the strain.  Somehow her cervix remains closed, protecting her offspring.  It feels like you stuck your cock in a waterfall.  There’s a powerful stream of [pc.cum] blasting backward and hitting your groin hard enough that it almost forces you to pull out.");
		}

		output("\n\nWhen it’s over you collapse on top of your cat " + kath.catGirl("girl", "morph") + " lover.  You feel completely spent and you enjoy the feeling of your sperm leaking slowly from inside her body.\n\n");

		output("As you lie there you " + (kath.hasCock() ? "realize there’s a " + kath.CockMultiple(" hot, hard bulge", "pair of hot, hard bulges") + " between the two of you.  " : "notice that Kath's nippes are rock hard once again") + "It looks like Kath enjoyed herself so much that she " + (kath.hasCock() ? "wants round two" : "needs to cum again") + ".  You don’t want to disappoint so you roll off her and start to " + (kath.hasCock() ? "stroke her cock" + kath.CockMultiple(" and her knot", "s and knots") : "massage her throbbing clit") + ".\n\n");

		output("Kath realizes what you’re up to and starts to beg weakly - “<i>I don’t know if I can.  Let me rest for a minute, please.</i>”\n\n");

		if (pc.cor() < 25)
			output("You consider it, but you know Kath will end up loving it." + (flags["COC.KBIT_SUB_BED_BOND"] != undefined ? "" : "  She’s obviously turned on from being tied up, from letting you take control.") + "  You give her a smile and continue to stroke her gently");
		else if (pc.cor() < 75)
			output("Of course she can.  And she’ll love it.  You’re about to prove that to her");
		else output("How does she think this works?  She’s tied to the bed, you’ve got her " + (kath.hasCock() ? "cock" + kath.CockMultiple("", "s") + " in hand" : "clit between your fingers") + ".  If you want her to cum then she’s going to cum!  You stop just long enough to give Kath a wicked smile and then you start to " + (kath.hasCock() ? "jerk her cock" + kath.CockMultiple("", "s") : "work her clit") + " in earnest");
		output(".  Kath moans and tries to escape but her tail sweeps from side to side, showing you she couldn’t be happier.  When her hips launch off the bed you " + (kath.hasCock() ? "aim her cock" + kath.CockMultiple("", "s") + " at the ceiling and once again she gets coated in a shower of her own cum" : "lean in and give her a long deep kiss") + ".\n\n");

		output("After that marathon Katherine is so tired that within a minute or two she starts to snore.  You gently untie her arms from the bed without waking her.  Cats need their naps after all.  She looks so content that you leave her soaking in a puddle of her own cum and let yourself out.");
	}
	//else if (!hasCock()) { //She has no cock and you either don't have one or it's too big
		//output("You stroke her hair and tell her not to worry.  You had lots of fun tying her up.  Kath laughs and says she can't wait to try this again, anytime you want.  Still, after that marathon Katherine is so tired that within a minute or two she starts to snore.  You gently untie her arms from the bed without waking her.  Cats need their naps after all.  She looks so content that you leave her be and let yourself out.");
	//}
	else { //Female, Genderless or your cock is too big
		var dPen:Boolean = pc.hasVagina() && kath.cockTotal() > 1;
		output("  You sit down astride Kath and ask her why she thinks you’re going to stop?  You’ve only just warmed her up.  Now she’s ready for the main course.  Her eyes go wide and she pulls at the scarves but there’s no escape.\n\n");
		
		output("You position yourself above Katherine and slowly lower your " + (pc.hasVagina() ? "pussy" : "ass") + " onto her " + (dPen ? "upper shaft.  A moment later you feel her lower shaft start to force its way into your ass" : "shaft") + ".  Kath mewls as her oversensitive cock" + (dPen ? "s disappear into your holes" : " disappears into your cunt") + ".\n\n");

		if (flags["COC.KBIT_SUB_BED_BOND"] != undefined)
			output("“<i>Oh " + pc.mf("mister", "miss") + ", I’m never going to have to pick up at that bar again.  It’s love at first fuck but please, no more.</i>”");
		else output("“<i>" + kathPlayerText() + ", please don’t.  Not so soon.  I can’t cum anymore.  Just let me recover or my " + (kath.hasBalls() ? "balls are" : "prostate is") + " going to turn inside out.</i>”");

		output("\n\nYou put an end to her babbling by kissing her while you allow your " + (dPen ? "holes to swallow her cocks" : (pc.hasVagina() ? "pussy" : "rectum") + " to swallow up her cock") + ".  Kath’s hips weakly try to push more inside, but her hot and solid knot" + (dPen ? "s prevent" : " prevents") + " it.\n\n");

		output("You rock forward and back, enjoying the feeling of Katherine’s " + (dPen ? "staves grinding against one another inside you" : "staff probing your depths") + ".  Your hands roam over Kath’s breasts, the sperm soaked top doing little to conceal her " + kath.breastCup() + " mounds.\n\n");

		output("Kath soon forgets her complaints and starts trying to move beneath you.  Although it’s difficult you pull yourself off her shaft" + (dPen ? "s" : "") + " and remind her that you and only you are going to decide when she gets to cum.  Kath lets out the most needy moan you’ve ever heard, but when you lower yourself again you find her hips have locked in place.\n\n");

		output("You’re starting to feel that familiar throbbing as you rock against Katherine’s knot" + (dPen ? "s" : "") + " and you decide it’s time to make this kitty blow her load.  Reaching underneath her cock you first rub your palm gently against her pussy.  Then you " + (kath.hasBalls() ? "slide your hand upwards and take hold of her " + kath.ballAdj() + " balls.  They’re" : "push your fingers past her sphincter and start to massage her prostate.  It’s") + " boiling hot - probably working overtime to rebuild Kath’s supplies of sperm.\n\n");

		output("As your fingers expertly massage her sperm " + (kath.hasBalls() ? "factories" : "factory") + " you innocently ask, “<i>You said you couldn’t cum again.  Does it still feel that way, or was I right after all?</i>”  Kath seems to be lost in a dream world, so you try something else and yell out a command: “<i>Kath - CUM!</i>”\n\n");

		output("At that her body stiffens and her " + (kath.hasBalls() ? "balls try to pull toward her body" : "prostate contracts") + ".  You decide to make things a little more intense and you " + (kath.hasBalls() ? "hold her balls in place" : "pinch one end of her prostate") + ", making it harder for her to pump out her latest load.  Kath’s head starts thrashing from side to side and you feel her " + (kath.hasBalls() ? "balls'" : "prostate’s") + " contractions go into overdrive as she fights for the chance to fill you.\n\n");

		pc.loadInAss(kath);
		if (dPen) pc.loadInCunt(kath);
		kath.orgasm(); //Kath has already cum once, so reduce her load to the minimum amount.
		output("Your belly starts to swell with Kath’s red hot seed but since she’s already emptied her " + (kath.hasBalls() ? "balls" : "prostate") + " once tonight you don’t end up as completely stuffed as usual.  Kath gasps and pants like a fish out of water and with the last of your strength you untie her and press her hands to your " + (kath.cumQ() > 500 ? "swollen " : "") + "belly.\n\n");

		output("“<i>It’s so hot,</i>” she says.  As she rubs your belly Kath mumbles, “<i>I must have just made all this.  You’re full of my fresh, hot cum.</i>”  You kiss her and tell her you really enjoy the feeling.  If there’s ever a chilly night you’ll have to remember this trick for keeping warm.\n\n");

		output("Katherine giggles and pulls you into a hug.  She’s so tired that within a minute or two she starts to snore.  She looks so content that you leave her soaking in a puddle of her own cum and let yourself out.");
	}
	
	processTime(25 + rand(10));
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	flags["COC.KBIT_SUB_BED_BOND"] = 1;
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function katherineBarApproach():void {
	clearOutput(); 
	katherineSprite();
	output("Kath sits up as you approach, preening herself and adjusting her blouse as you navigate your way to her table." + (kath.isLactating() ? "  Her hands subconsciously move to her breasts and you note the damp spots over her nipples." : "") + "\n\n");
	output("When you sit down Kath asks you what you want to do and takes a sip of her drink.");
	katherineMenu();
}

private function katherineSeeUrta():void {
	clearOutput();
	if (urtaDrunk()) {
		output("Katherine looks over at Urta’s table and sees that the captain is obviously sloshed.  She finishes off her drink and whispers, “<i>Now " + kathPlayerText() + ", I think we both know that if I go over there Urta is going to pound me into the floor.</i>”\n\n");
		output("You smile and say, “<i>Only if you ask nicely.</i>”\n\n");
		output("Kath stands up and offers you her hand.  “<i>I guess I’d better bring you along.  I might need help and besides, you always have some fun ideas.</i>”\n\n");
		output("Urta looks up as the two of you cross the open floor, her horse cock rising rapidly.");
		clearMenu();
		addButton(0, "Watch", watch, true);
		if (kath.hasCock()) addButton(1, "Pin & Fuck", pinAndFuck);
		else addDisabledButton(1, "Pin & Fuck", "Pin & Fuck", "This scene requires kath to have cock.");
	}
	else {
		output("Katherine looks over at Urta’s table.  Urta catches her looking and gestures for both of you to come over.\n\n");
		output("Kath offers you her hand and says, “<i>I guess we’d better get over there.  It looks like Urta’s really horny and I wouldn’t want to disappoint her.</i>”\n\n");
		output("Given the warmth you feel from Katherine’s body you think that she’s projecting some of her own feelings onto Urta.  It doesn’t matter much to you.  No matter how you play this you’re likely to wind up with a pair of hot, naked herms on your hands.  Life as the champion can be so tough sometimes.\n\n");
		clearMenu();
		if (!pc.hasGenitals()) {
			if (kath.hasCock()) addButton(0, "Roast You", kathRoastYou);
			else addButton(0, "Watch", watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
		}
		else {
			addButton(0, "Circlejeck", kathCirclejerk);
			addButton(1, "Roast Kath", spitroastKath);
			if (kath.hasCock()) addButton(2, "Roast You", kathRoastYou);
			if (pc.hasCock()) addButton(3, "369", threeSixtyNine);
		}
	}
}

private function katherineDrunkSeeUrta():void {
	clearOutput();
	output("Now that you’ve lowered Kath’s inhibitions you suggest the two of you should go and talk to Urta.\n\n");
	output("“<i>Yeah, the captain looks like she could use some company.</i>”\n\n");
	output("You have to help Katherine get to Urta’s table, but once there Kath plops down into the seat next to Urta and gives her a big hug.\n\n");
	if (urtaDrunk()) {
		output("Urta hugs Kath back and says, “<i>Hey there cutie,</i>” before groping Kath’s behind.\n\n");
		output("Kath purrs and buries her head in Urta’s bosom.\n\n");
		output("You get the feeling you are going to have to intervene quickly if you don’t want them to fuck right here and now.");
		var button:int = 0;
		clearMenu();
		if (kathSubmissiveness() < 3) {
			addButton(button++, "Orgy", kathOrgy);
			output("\n\nYou");
		}
		else output("  On the other hand everyone enjoys an orgy.\n\nOtherwise you");
		if (!pc.hasGenitals()) {
			output(" could let the two of them fuck.  Unfortunately, you really aren't equipped for more than that.");
			addButton(button++, "Watch", kathWatchNoIntro, true);
		}
		else {
			output(" could let the two of them fuck and then help yourself or you and Urta could work together to fill Kath's needy holes.");
			addButton(button++, "Let 'em fuck", doubleStuffKath);
			if (pc.hasCock()) addButton(button++, "Dbl Pen Kath", doublePenetrateKath);
			else addDisabledButton(button++, "Dbl Pen Kath", "Dbl Pen Kath", "This scene requires you to have cock.");
		}
	}
	else if (flags["COC.KATHERINE_URTA_AFFECTION"] > 10) { //Willing to bang Kath (when sober)
		output("Urta hugs her back and asks, “<i>" + pc.short + ", Kath - Looking to get in a little trouble?</i>” before scratching behind Kath’s ears.\n\n");
		output("Kath winks at you, gives Urta a kiss and says, “<i>only the best kind of trouble,</i>” in a slightly slurred voice.");
		clearMenu();
		addButton(0, "Lick Out", kathLicksOutUrta);
		if(kath.hasCock())
			addButton(1, "Sandwich", kathSandwich);
		else addDisabledButton(2, "Sandwich", "Sandwich", "This scene requires Kath to be herm.");
		
		if(kath.hasCock() && pc.hasGenitals()) //Do not show knothole button for genderless
			addButton(2, "Knothole", kathKnothole);
		else addDisabledButton(2, "Knothole", "Knothole", "This scene requires Kath to be herm and you to have genitals.");
	}
	else { //Not willing to bang Kath (while sober) just yet
		output("Urta pushes Kath back gently.  “<i>Whoa - " + pc.short + " I think someone’s had a bit much.</i>”\n\n");
		output("Kath smiles and her eyes wander downward, clearly checking out Urta’s chest and then her cock.  Her voice slightly slurred Kath says, “<i>I like you cap'n,</i>” before Urta can lift her up, haul her back to her booth and dump Katherine in her usual seat.\n\n");
		output("Urta turns to you and whispers, “<i>You’d better do something about her.  She’s going to start humping a table leg if you don’t give her some relief.  It’s a real shame, 'cause I could go for some relief from you too.</i>”" + (flags["COC.URTA_INCUBATION"] != undefined ? "  She rubs her pregnant belly absentmindedly as she stares at you and Kath." : "") + "\n\n");
		output("As she walks away Kath props her head up on her hands and looks at you dreamily.");
		flags["COC.KATHERINE_LOCATION"] = KLOC_BAR_URTA_REFUSED; //Shows the same options as when you get her drunk, except no option to see Urta
		katSexMenu();
	}
}

private function katherineSeeVala():void {
	clearOutput();
	output("Kath looks like she’s ready for some fun but before you get started something else catches your eye.  You note that Vala is sitting at one end of the bar, her tray propped up beside her.  It looks like a slow night and Vala seems bored.  " + (flags["COC.KATHERINE_VALA_AFFECTION"] < 5 ? "You decide it’s time to expand their horizons and" : "You know they enjoy each other’s company so you") + " motion for her to come over.\n\n");
	output("Vala flies over quickly.  When she arrives you pat the seat next to you. You’re sitting between your submissive cat " + kath.catGirl("girl", "morph") + " on one side and your supersized faerie on the other.  You certainly walked a strange path to wind up here.");
	clearMenu();
	addButton(0, "Fist Them", fistKathAndVala);
	addDisabledButton(1, "Eat Out", "Eat Out", "This scene requires Kath to be herm.");
	addDisabledButton(2, "Dbl Stuff", "Dbl Stuff", "This scene requires Kath to be herm and you to have cock. It does not accomodate taurs.");
	if (kath.hasCock()) { //All but the fisting scene require Kath be a herm
		addButton(1, "Eat Out", kathEatOutVala);
		if (!pc.isTaur() && pc.hasCock()) addButton(2, "Dbl Stuff", doubleStuffVala);
	}
}

private function drunkFuckKath():void {
	output("The waitress brings over one last drink and Kath slams it back in one shot.  She’s got an obvious bulge under her clothes and she gives you a crooked smile as she gets up.\n\n");

	output("You take her hand, but instead of heading for the alley as you expected Kath pulls you toward one of the empty backrooms.  She’s so excited she's practically skipping.  You get inside, lock the door and Kath pounces you.  She uses the very techniques you " + (flags["COC.KATHERINE_TRAINING"] == 1 ? "and Urta " : "") + "taught her to pin your arm behind your back while she relieves you of your clothes, all the while giggling to herself.\n\n");

	output("Once you’re naked she " + (pc.hasVagina() ? "starts roughly playing with your clit" : "jabs a finger and then two inside your ass") + ".  She’s not gentle, aiming only to get you hotter and hotter.  Kath leans in close and whispers, “<i>It’s my turn now.  You wanted me - so for now I’m callin the shots.</i>”  She ");
	if (pc.hasVagina())
		output("keeps attacking your clit until you feel your juices running down your leg");
	else if (pc.hasCock())
		output("keeps milking your prostate until you feel like you’re about to cum");
	else
		output("gets her whole hand inside your ass and rolls it around, knowing how much it takes to drive a genderless lover to distraction");

	output(".\n\nOnly when you’re having trouble even standing does Kath release your arm");
 	if (!pc.hasVagina()) output(" and yank her " + (pc.hasCock() ? "fingers" : "fist") + " from your ass");
	output(", and that’s just so she can undo her pants, pull aside her panties and grab your hips with both hands.  Just a moment later your ");
	var dPen:Boolean = kath.cockTotal() > 1 && pc.hasVagina();
	if (dPen)
		output("cunt and ass get");
	else if (pc.hasVagina())
		output("cunt gets");
	else output("ass gets");
	output(" split wide open as Kath pulls you back onto her shaft" + (dPen ? "s, burying herself to the hilt in both your holes" : ", burying herself to the hilt") + ".\n\n");

	output("You’ve never seen Kath acting this aggressive!  She doesn’t say anything; she concentrates entirely on dominating your ");
	if (dPen)
		output("pussy and your ass, making them");
	else if (pc.hasVagina())
		output("pussy, making it");
	else output("ass, making it");
	output(" hers.  She bangs you against the door hard enough that everyone in the bar must know what’s going on in here.  ");
	if (pc.hasCock())
		output("The constant battering overcomes you and " + (pc.cocks.length > 1 ? "your cocks start" : "your cock starts") + " to spray, coating the door " + (pc.cumQ() > 1000 ? "and then the floor " : "") + "with your sticky semen");
	else if (pc.hasVagina())
		output("All that thrusting " + (pc.bellyRating() > 30 ? "along with the bouncing of your huge belly " : "") + "overcomes you and the walls of your pussy " + (dPen ? "and ass " : "") + "clamp down on Kath’s spear");
	else output("All the nerves in your rectum start to fire and your sphincter spasms furiously, trying to expel the invader");
	
	output(".\n\nKath laughs like a madwoman and starts to hammer you even harder.  You feel her swollen knot" + (dPen ? "s" : "") + " fighting against your spasming passage" + (dPen ? "s, trying to force their" : ", trying to force its") + " way inside.  Katherine lets out a yowl and pulls back with all her strength.  Her knot" + (dPen ? "s, already near their final size, smash through your defenses, your muscles unable to hold them" : ", already near its final size, smashes through your defenses, your muscles unable to hold it") + " at bay.  At last Kath stops moving.  She must be enjoying the feeling as your ");
	if (dPen)
		output("pussy and rectum ripple");
	else if (pc.hasVagina())
		output("pussy ripples");
	else output("ass ripples");
	output(" along the length of her shaft" + (dPen ? "s" : "") + ".\n\n");

	output("In a whisper so quiet you almost miss it Kath says, “<i>My turn!</i>”  Your knees buckle as your kitten’s cock" + (dPen ? "s discharge" : " discharges") + " a tidal wave of spooge into your ");
	if (pc.hasVagina())
		output((pc.isPregnant() ? "pussy" : "vacant womb") + (dPen ? " and colon" : ""));
	else output("colon");
	output((!dPen && kath.cockTotal() > 1) ? ".  Her other member, nestled between your thighs, spurts a stream of seed onto the floorboards" : "");
	output(".  After several long, hard blasts your belly has swollen up as Kath’s turbocharged " + (kath.hasBalls() ? "testicles do their" : "prostate does its") + " best to change you into a balloon.  When she’s spent Kath falls backwards, dragging you with her.  You wind up " + (pc.isTaur() ? "with your belly on the ground, all four legs splayed out," : "sitting in Kath’s lap") + " still feeling her heartbeat through the veins of her knot" + (dPen ? "s" : "") + ".\n\n");

	output("From behind you come a worried voice.  “<i>I’m sorry " + kathPlayerText() + ", I really went out of control there.  I shouldn’t have, but you got me so drunk and horny... anyway, I’m sorry.</i>”\n\n");

	if (pc.cor() < 25)
		output("You know it was your fault.  You look over your shoulder and smile, telling Kath that it’s all right, you wanted to enjoy yourself and you did.  She beams at the praise.");
	else if (pc.cor() < 75)
		output("You’d have a much easier time being mad or punishing your cat " + kath.catGirl("girl", "morph") + " if that hadn’t been so enjoyable.");
	else
		output("It was fucking good.  It’s been a while since you got dominated like that and it’s so unlike Kath.  Secretly you wonder if you could get her to do this again, but out loud you tell her that you’re going to come up with some appropriate punishment for this.  Kath just nods her head.  Apparently fading alcohol and the orgasm have turned her back to her usual submissive self.");

	output("\n\nWhen the knot" + (dPen ? "s finally come" : " finally comes") + " free you get up, get dressed and walk out into the bar.  Several patrons, many sporting erections, give you applause.  Kath, still lying on the floor in a puddle of cum, tries to shrink down to nothing.  Even though she’s almost fully clothed she pulls a broken chair in front of her to try and hide from the bar.\n\n");

	if (pc.cor() < 25)
		output("You blow Kath a kiss, resulting in a few more cat calls.  Then you close the door mouthing ‘later’ to her.  She nods and starts to collect herself, happy to be out of the public eye right now.");
	else if (pc.cor() < 75)
		output("You take a bow and blow Kath a kiss.  The other patrons love it and you prop the door wide open so that Kath will be embarrassed long after you leave.");
	else {
		output("You give Katherine an evil grin and stride back into the room.  The other patrons watch, some stroking their erections or slipping fingers into their pussies.  “<i>" + kathPlayerText() + " - what are you doing?</i>” she asks, quite worried.  You pull her up in front of you and stand behind her, much as she stood behind you moments ago." + (pc.hasCock() ? "  Your partially deflated cock rubs against her backside, but that’s not what she should be worried about." : ""));

		output("You put your arms under hers and start to unbutton her blouse, exposing her bra.\n\n");

		output("Kath goes stiff in your arms, transfixed by all the stares from the bar patrons.  Meanwhile you start rolling her breasts around in your hands, enjoying your lover’s titflesh and embarrassment.  You say, “<i>Sorry Kath, I should have done this earlier - I completely neglected your lovely breasts.</i>”\n\n");

		output("“<i>No, no, no,</i>” she squeaks out.  ");
		if (kathSubmissiveness() < 6) {
			output("After a few minutes of playing with her you finally let Kath go.  There’s a definite feeling of disappointment from the bar, but you don’t think you could get Kath to do something in front of other people.  Maybe someday you’ll have her so enthralled that she’ll do it.\n\n");

			output("You give her a quick kiss and leave the bar, whistling.");
		}
		else {
			output("You ignore her of course.  " + (flags["COC.KBIT_SUB_PUBLIC_EXHIBITION"] != undefined ? "You know your pet loves it when you force her to do things." : "It’s time for Kath to learn a new trick.  You’ve always thought her body could please a crowd, but after today’s behavior you’ve decided to prove it!"));

			output("\n\nYou step back and tell Kath this won’t do at all.  She pants and reaches to readjust her clothes.  Then you tell her, “<i>These people just applauded your performance Kath.  They expect an encore.</i>”  She freezes in place and then you tell her, “<i>They can’t get a good view with all those clothes in the way... you’re going to have to strip.</i>”\n\n");

			output("That gets some hoots and hollers from the crowd and you see a few patrons kicking off their pants or skirts in preparation for the show.  Katherine shudders but knows better than to argue when you use that tone of voice.  She starts to quickly take off her clothes until you tell her to stop.\n\n");

			output("She looks back, perhaps wondering if you’re about to tell her you were just kidding.  Instead you explain, “<i>Give them a show, strip like you’re doing this for money.</i>”\n\n");

			output("Kath gulps but turns back to the crowd and starts unbuttoning her blouse slowly.  The crowd loves it and Kath, perhaps feeling a little bold thanks to the booze still in her system, starts to get into it and starts to sway back and forth, her cat-like flexibility allowing her hips to move through a hypnotic pattern that silences the crowd." + (isValaAtBar() ? "  You even see a certain faerie waitress paused mid-flight with a tray of drinks.  You see her eyes following every move that Kath’s hips make." : ""));

			output("\n\nYou have to smile watching Katherine dancing in front of all these people.  This is something she would never have done before you met her.  As her hips gyrate Kath pulls off her blouse and starts to play with her breasts.  After a few cheers and cries of “<i>More!</i>” she removes the bra as well.\n\n");

			output("With every eye in the place locked on her body Kath lets out a sexy purr , loosens her skirt and slowly slides it over her hips.  She poses before kicking off her panties, leaving herself totally naked in front of the crowd.\n\n");

			output("With Katherine nude and distracted you sneak up behind her and grab " + kath.CockMultiple("her cock with both hands", "both her cocks") + ".  She lets out a surprised meow as you fondle her member" + (kath.hasBalls() ? ", her balls" : "") + " and her dripping pussy.\n\n");

			output("The crowd starts to cheer as you smear Kath’s cock" + kath.CockMultiple("", "s") + " with her own pussy juice.");
			if (isValaAtBar())
				output("   You notice Vala has put down her tray.  One of her hands is under her skirt and she has a zoned out happy look on her face as she watches you molest your " + kath.catGirl("cat girl.", "feline lover."));
			output("  Katherine starts playing with her own breasts and grins at her audience" + (kath.isLactating() ? ".  Every time she gives them a little squeeze some cream leaks out and dribbles down her front.  She" : ".  Then she") + " closes her eyes and leans back against you, losing herself in the feeling of her fingers and yours as they pleasure the most sensitive areas of her body.\n\n");

			output("Having cum recently Kath is able to put on quite the show.  Even with your hands working her shaft" + kath.CockMultiple("", "s") + " and occasionally dipping into her cunt it still takes minutes before you feel " + kath.CockMultiple("that knot", "those knots") + " of hers firming up.  Kath’s hips jerk forward and you aim " + kath.CockMultiple("her shaft toward the ceiling.  When Kath cums a thick stream of semen under high pressure blasts from the tip of her cock, striking the wall above the door and raining down in thick, heavy droplets", "her upper cock to the left and her lower cock to the right.  When Kath cums twin streams of semen under high pressure blast from the tips of her cocks - one striking the wall on the left of the door, one striking the wall on the right") + ".  The whole bar applauds as Katherine unloads.  As the final squirts bubble from her member" + kath.CockMultiple("", "s") + " Kath falls to her knees and her tongue hangs from the side of her mouth.\n\n");

			output("You’re sure everyone in the bar appreciated that show but you don’t intend to leave a naked and near comatose Katherine in their hands.  You step out of the room and tell Kath you’ll see her later.  She makes a happy gurgling noise that you assume was an “<i>Okay!</i>” and then you close the door, making sure to slam it so the locking bar drops down on the inside.\n\n");

			output("You stride out of the bar" + (isValaAtBar() ? ", pausing only to pull Vala into your arms to quickly kiss her and grope her ass. She sighs, winks and tells you to come back later. You" : " and") + " head for home, knowing you’ve " + (flags["COC.KBIT_SUB_PUBLIC_EXHIBITION"] != undefined ? "once again helped Kath see how much fun showing off can be." : "opened Kath up to some new possibilities."));
			flags["COC.KBIT_SUB_PUBLIC_EXHIBITION"] = 1;
		}
	}
	processTime(35 + rand(5));
	if (!pc.hasVagina() || kath.cockTotal() > 1) pc.loadInAss(kath);
	if (pc.hasVagina()) pc.loadInCunt(kath);
	pc.orgasm();
	kath.orgasm();
	IncrementFlag("COC.KATHERINE_TIMES_SEXED");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function katherineAndUrtaHadSex(drunkSex: Boolean):void {
	//Every time they have sex they get a little closer, but this is limited to a max of 30
	//while still in training. Once Kath has a job they can tell you they love each other.
	//Only the two of them having sex sober can cause them to gain the last point.
	IncrementFlag("COC.KATHERINE_URTA_TIMES_SEX");
	if (flags["COC.KATHERINE_URTA_AFFECTION"] >= 31) return;
	if (flags["COC.KATHERINE_URTA_AFFECTION"] == 30 && (drunkSex || flags["COC.KATHERINE_UNLOCKED"] < 4 || flags["COC.KATHERINE_URTA_DATE"] == KDATE_LITTLE)) return;
	//Kath and Urta can’t gain that last point and become lovers if Kath has not yet
	//completed her training, if this was alcohol fueled sex or if you told them to only
	//fuck each other when you were around.
	IncrementFlag("COC.KATHERINE_URTA_AFFECTION");
}

public function katherineAndValaHadSex():void {
	//Every time they have sex they get a little closer, but this is limited to a max of 11.
	IncrementFlag("COC.KATHERINE_VALA_TIMES_SEX")
	if (flags["COC.KATHERINE_VALA_AFFECTION"] > 11) return;
	IncrementFlag("COC.KATHERINE_VALA_AFFECTION");
}

public function katherineBarDescription():void {
	output("\n\nYou see Katherine sitting alone in her usual booth, nursing something that " + (!kath.isPregnant() ? "looks like a cream liqueur" : "is probably a milkshake") + ".  She’s wearing " + kath.clothesChoice("a matching blouse and skirt", "her sheer bodysuit", "the elegant long dress", "her spider silk robe", "that revealing tube top", "the sexy nurse’s outfit") + ".");
}

public function katherineBarFirstEncounter():void {
	output("\n\nYou see a familiar feline lounging at one of the tables.  When she sees you Kath leaps up, nearly spilling her drink, and tackles you with a hug and a flurry of kisses.\n\n");
	output("She finally regains some composure and says, “<i>I’ve been waiting for you to turn up!  It feels like so much has happened these last few days.  Oh, I’m such a screwup - I told you I had an apartment but I didn’t say where.</i>”\n\n");
	output("She pulls a key and a scrap of paper out and hands them to you.  “<i>There we go.  A key to my place and directions.  Please come over and see me " + kathPlayerText() + ", I’ll be lonely if you don’t.</i>”\n\n");
	output("You laugh, give her a scratch behind the ear and let her lead you back to her table.");
	//Show the same menu options you would normally see if sitting with Kath
	flags["COC.KATHERINE_UNLOCKED"] = 5; //She’s met you at the wet bitch and given you her apt key
	katherineMenu();
}

public function barKathUrtaLoveAnnounce():void {
	//Special event that happens on entering the bar when KATHERINE_URTA_AFFECTION == 31
	//and both Kath and (sober) Urta should be present in the bar at this time normally
	clearOutput();
	output("When you walk into the Wet Bitch you see Kath and Urta sitting together at Urta's table.  As soon as Kath spots you she waves you over enthusiastically.\n\n");
	output("Urta offers you the seat next to her and Kath shifts over so she's on your other side.  “<i>So your big plan worked,</i>” says Urta with a grin that runs from ear to ear.  “<i>You got us fucking, " + (flags["COC.KATHERINE_URTA_DATE"] == KDATE_LOTS ? "hell you encouraged us to fuck every chance we got!  So" : "so") + " it should be no surprise that we’ve become close.</i>”\n\n");
	output("“<i>Really close,</i>” says Katherine, grinding her hip up against yours.\n\n");
	output("“<i>So anyway,</i>” Urta continues, “<i>we both still love you, especially since we only met each other because of you.  But now we love each other too.  I figure you must have expected this, so don’t pretend to be surprised.</i>”\n\n");
	output("“<i>How do you want to celebrate?</i>” asks Kath.  You can see the matching pair of " + (kath.hasCock() ? "bulges" : "smiles") + ", one to each side.  They both put their arms around you, pressing their breasts against you deliberately.  But hey, who are you to argue?  A threesome seems like an awfully good idea.");
	flags["COC.KATHERINE_URTA_AFFECTION"] = 32;
	var button:int = 0;
	clearMenu();
	if (pc.hasCock()) addButton(button++, "369", threeSixtyNine);
	else addDisabledButton(button++, "369", "369", "This scene requires you to have cock.");
	
	if (kath.hasCock()) addButton(button++, "Roast You", kathRoastYou);
	else addButton(button++, "Watch", watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
	
	if (pc.hasCock() || pc.hasVagina()) addButton(button++, "Spitr Kath", spitroastKath);
	else addDisabledButton(button++, "Spitr Kath", "Spitroast Kath", "This scene requires you to have genitals.");
}

public function katherineOnDuty():void {
	clearOutput();
	output("As you walk through the streets of Tel’Adre you notice a small group of Watch officers out on patrol.  One of them looks your way and you see a familiar face.  Kath says something to one of the other officers.  Soon enough Kath is headed your way while the others walk to a nearby cafe.\n\n");
	if (flags["COC.KATHERINE_UNLOCKED"] == 4) { //First encounter since training
		output("“<i>" + pc.short + "!</i>” she calls out, running straight into your arms.  “<i>I’ve been hoping to run into you - here,</i>” she says, thrusting a key into your hand.  “<i>I was so excited when I saw you at the gate; I completely forgot to give you this.  It's a key to my new place.</i>”  She beams proudly as she speaks the words.\n\n“<i>Please come by any time, that way we can get up to anything we want,</i>” she adds before kissing you and wrapping her tail around your waist.  She whispers the directions to her new place in your ear, then releases you and steps back.\n\n“<i>Now, as for right now, y");
		flags["COC.KATHERINE_UNLOCKED"] = 5;
	}
	else { //Normal introduction
		output("When she reaches you Katherine skids to a stop.  “<i>" + (kath.playerMaster() ? "[pc.Master]" : "Hi " + pc.short) + "!</i>” she says, grinning ear to ear.  “<i>Y");
	}
	output("ou’ve got good timing.  We were due to take a break anyway.</i>”  Before she says any more Katherine stands up straight, casually places her hands behind her back and shifts her body to emphasize her breasts and the " + (kath.hasCock() ? "bulge of her crotch" : "curve of her hips") + ".  “<i>So... how do I look?</i>” she asks with a purr.\n\n");

    katherinesAppearance(false); //This will output most of the encounter text
	output("Totally naked, tail waving with pleasure, Katherine stretches, giving you a very good show of all her most private parts.  “<i>Like what you see, my love?</i>” she purrs.\n\nYes, you do, you tell her.  Her uniform suits her just fine, and you can certainly appreciate her new flirty attitude.  You motion for her to give a little twirl.  The cat" + kath.catGirl(" girl", "-morph") + " does as you indicate, pirouetting with surprising elegance in a slow circle, grinning at you as she resumes facing you.  “<i>You should really come and see me after work.</i>” she winks, even as she bends down and, with a wiggle of her ass, starts gathering her clothes up again.  You can’t help but feel a bit disappointed as she begins to redress.\n\n“<i>But... I still got a little time, if you maybe want to do something else...?</i>” she purrs with a sultry wink.\n\n");
	
	flags["COC.KATHERINE_LAST_AMBUSH"] = days;
	
	//[Give Oral] [Kath Laps] [Fuck Her] [Anal] [Leave]
	processTime(6);
	clearMenu();
	addButton(0, "Give Oral", giveKatOralPenisWingWang);
	if (pc.hasGenitals()) addButton(1, "Kath Laps", katherineGivesPCOralAllDayLongDotJPG);
	else addDisabledButton(1, "Kath Laps", "Kath Laps", "This scene requires you to have genitals.");
	
	if (pc.hasCock() && (pc.cockThatFits(kath.vaginalCapacity()) >= 0))
		addButton(2, "Fuck Vag", penetrateKatsVag);
	else
		addDisabledButton(2, "Fuck Vag", "Fuck Vag", "This scene requires you to have fitting cock.");
	
		if (pc.hasCock() && (pc.cockThatFits(kath.vaginalCapacity()) >= 0))
		addButton(3, "Fuck Ass", pcPenetratesKatAnally)
	else
		addDisabledButton(3, "Fuck Ass", "Fuck Ass", "This scene requires you to have fitting cock.");
	
	addButton(14, "Leave", katherineOnDutyLeave);
}

private function katherineOnDutyLeave():void {
    output("It’s probably best that you don’t get Kath in trouble.  You bid her farewell, promising that you’ll come and see her once she’s off duty.\n\n");
	processTime(2);
	addNextButton(telAdreMenu);
}

public function katherineVisitAtHome():void { //You go to Kath's place alone - she may or may not be home
	clearOutput();
	if (kathIsAt(KLOC_KATHS_APT)) {
		if (flags["COC.KATHERINE_URTA_AFFECTION"] == 31) { //Special event that happens only once
			katherineSprite();
			output("When you open the door to Kath’s place you see Kath and Urta both sitting together on the bed.  As soon as they spot you Kath crooks her finger and scoots over, leaving a space between her and Urta.\n\n");
			output("Once you’re seated Urta laughs and says, “<i>so your big plan worked.  You got us fucking, " + (flags["COC.KATHERINE_URTA_DATE"] == KDATE_LOTS ? "hell you encouraged us to fuck every chance we got!  So" : "so") + " it should be no surprise that we’ve become close.</i>”\n\n");
			output("“<i>Really close,</i>” says Katherine, grinding her hip up against yours.\n\n");
			output("“<i>So anyway,</i>” Urta continues, “<i>we both still love you, especially since we only met each other because of you.  But now we love each other too.  I figure you must have expected this, so don’t pretend to be surprised.</i>”\n\n");
			output("“<i>How do you want to celebrate?</i>” asks Kath.  You can see the matching pair of " + (kath.hasCock() ? "bulges" : "smiles") + ", one to each side.  They both put their arms around you, pressing their breasts against you deliberately.  But hey, who are you to argue?  A threesome seems like an awfully good idea.");
			flags["COC.KATHERINE_URTA_AFFECTION"] = 32;
			var button:int = 0;
			clearMenu();
			if (pc.hasCock()) addButton(button++, "369", threeSixtyNine);
			else addDisabledButton(button++, "369", "369", "This scene requires you to have cock.");
			
			if (kath.hasCock()) addButton(button++, "Roast You", kathRoastYou);
			else addDisabledButton(button++, "Roast You", "Roast You", "This scene requires Kath to have cock.");
			
			if (pc.hasCock() || pc.hasVagina()) addButton(button++, "Spitr Kath", spitroastKath);
			else addDisabledButton(button++, "Spitr Kath", "Spitr Kath", "This scene requires you to have genitals.");
			
			if(!pc.hasGenitals()) addButton(button++, "Watch", watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
		}
		else {
			katherineSprite();
			output("It looks like Kath heard you coming.  You find her waiting in her bedroom with a sexy smile that suggests she’s up for anything.");
			kathClothes();
			output("\n\nShe stands next to her bed, waiting for you to " + (kath.playerMaster() ? "tell her what to do." : "make the first move."));
			katherineMenu();
		}
	}
	else if (hours < 10) {
		output("Kath's apartment is empty.  That shouldn't be surprising to you, at this time of the morning she's got to be out patrolling the market.\n\n");
		katherineApartmentEmptyLeave();
	}
	else if (kathIsAt(KLOC_URTAS_APT) || kathIsAt(KLOC_URTAS_HOME)) {
		output("The apartment is empty.  Unusual, but maybe Kath is staying over at Urta's place - you could always check for her there.");
		clearMenu();
		addButton(0, "Go to Urta's", katherineAtUrtas);
		addButton(1, "Leave", katherineApartmentEmptyLeave);
	}
	else {
		output("It looks like Kath is out somewhere.  She's probably still at the Wet Bitch.");
		addNextButton(telAdreMenu);
	}
}

private function katherineApartmentLeave():void {
	clearOutput();
	output("You sigh and tell Kath that you just stopped by to see her.  Unfortunately you have to get going.  She gives you a sad look but nods and says “<i>");
	if (kath.playerMaster()) output("Yes [pc.master].  Please come back soon.</i>”\n\n");
	else output("Alright " + pc.short + " but next time I want to have some fun.</i>”\n\n");
	
	addNextButton(telAdreMenu);
}

private function katherineApartmentEmptyLeave():void {
	output("You lock up and walk back toward the market, looking for something else to do while you wait for Katherine to finish her shift.");
	addNextButton(telAdreMenu);
}

public function katherineAtUrtas():void {
	output("You lock up and walk over to Urta's ");
	if (kathIsAt(KLOC_URTAS_APT)) { //This option happens if you and Urta have no children
		output("apartment.  A few knocks on the door and " + (kath.hasCock() ? "a sheepish looking pair of herms" : "your sheepish lovers") + " answer the door.\n\n");
		output("“<i>" + pc.short + ", speak of the devil,</i>” Urta says, sounding relieved.  “<i>For a second there I thought we had actually been loud enough that a neighbour came over to complain.</i>”\n\n");
		output("Kath says, “<i>We just finished cleaning up, so I was just about to head home for the night.  Where did you want to go?</i>”");
		clearMenu();
		addButton(0, "To Kath's", dateGotoKaths);
		addButton(1, "To the Lake", dateKathBath);
		addButton(2, "To the Bar", dateGotoBar);
		addButton(14, "Leave", telAdreMenu);
	}
	else { //At Urta's House
		switch (rand(4)) {
			case 0:
				output("house.  Letting yourself in with the spare key you sneak upstairs and peek into the master bedroom.\n\n");
				output("You can smell the sex from the doorway.  On the bed you can see both your girls, " + (kath.hasCock() ? "each bloated with the other's cum" : "Urta's horsecock still buried inside Kath; Kath's belly still bloated with Urta's seed") + ".  They're hugging each other tight and their tails are moving back and forth lazily.\n\n");
				output("You could say hello or you could just let yourself out quietly.");
				clearMenu();
				addButton(0, "Say Hello", urtaPlusKathCuddle);
				addButton(14, "Leave", telAdreMenu);
				break;
			case 1:
				output("house.  Letting yourself in with the spare key you sneak upstairs and peek into the master bedroom.\n\n");
				output("You see Urta sitting with Kath in front of a large mirror.  It looks like she's helping dry Kath's hair with a towel while Katherine " + kath.clothesChoice("finishes adjusting her blouse", "finishes strightening out her sheer bodysuit", "does up the last few buttons on her long dress", "fiddles with her spider silk robe, seemingly trying to find a way to show off more of her skin", "adjusts her tube top, making sure the outline of her bra shows through the tight fabric", "adjusts the sexy nurse's outfit you gave her and plays with the little white hat that's sitting on her lap") + ".\n\n");
				output("Kath spots you in the mirror and waves you in happily, trying to jump up and hug you.\n\n");
				output("Urta holds Kath in her seat while she picks up a comb and finishes working on Kath's " + kath.hairColor + " locks.  “<i>Hold still you horny pussy, I'm almost done.  You want to look your best for " + pc.short + ", don't you?</i>”\n\n");
				output("Urta gives each of you a kiss and shakes her head when Kath wraps herself around you.  “<i>Where do you get the energy Kath?</i>” she asks.  “<i>You want sex even more than I do.</i>”  You feel Kath blush a little at Urta's comment, but a quick scratch of her ears and she goes back to snuggling in your arms.\n\n");
				output("Urta walks over and hugs her from the other side, kissing each of you.  “<i>Much as I'd love to join you I need to rest up for tomorrow.  Have fun, but don't do anything I wouldn't do.</i>”\n\n");
				output("Kath snickers at the tired old saying and Urta swats her bum, then pushes both of you out the door.  “<i>Make sure to come by sometime soon.  I might not be in the mood now, but I guarantee it'll be a different story by tomorrow morning.</i>”");
				clearMenu();
				addButton(0, "To Kath's", dateGotoKaths);
				addButton(1, "To the Lake", dateKathBath);
				addButton(2, "To the Bar", dateGotoBar);
				break;
			default:
				output("house.  You step inside and find Kath sitting on the floor with ");
				var kids:int = urtaKids();
				if (kids == 1)
					output("your child.  " + (flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "He" : "She") + "'s sitting in Katherine's lap, head mashed against her breasts like " + (flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "he" : "she") + " hasn't got a care in the world.\n\n");
				else output((kids > 5 ? "a few of your kids" : "a pile of your children") + ".  They're lying all over Kath, playing with her ears and tail while she scratches their heads and gives them little kisses.");
				output("When Kath spots you she gives you a big smile and you hear “<i>" + pc.mf("Daddy", "Mommy") + "!</i>” from your offspring, who " + (kids > 1 ? "run over and hug" : "runs over and hugs") + " your [pc.legs].\n\n");
				output("Kath comes over and hugs you too, whispering, “<i>");
				if (kids == 1) 
					output(flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "He's" : "She's");
				else output("They're");
				output(" so cute,</i>” in your ear.\n\n");
				output("Urta walks down from upstairs and tells ");
				if (kids == 1) 
					output(flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "him" : "her");
				else output("them");
				output("them, “<i>Okay, you've " + (kids == 1 ? "" : "all ") + "had fun with aunt Katherine, now move it.  Chores don't do themselves and I'm not going to raise a " + (kids == 1 ? "lazy fox" : "pack of lazy foxes") + ".</i>”  There's little grumbling as ");
				if (kids == 1) 
					output(flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "he races off to his room" : "she races off to her room");
				else output("they race off in different directions");
				output(" with the energy of youth.\n\n");
				output("Urta gives you both a quick hug and says “<i>Listen, I need to go check on some stuff - duty calls and all that.  Lianna's just had a break thanks to Kath, so she'll be able to keep up.</i>”  She gives you both a quick kiss and heads off towards the watch headquarters with a spring in her step.</i>”");
				clearMenu();
				addButton(0, "To Kath's", dateGotoKaths);
				addButton(1, "To the Lake", dateKathBath);
				addButton(2, "To the Bar", dateGotoBar);
				break;
		}
	}
}

private function urtaPlusKathCuddle():void {
	if (pc.reflexes() >= 40) {
		output("\n\nYou creep over to the bed and stroke Kath's tail.  She and Urta both nearly jump out of their skin.  Urta gives you a good smack in the shoulder as soon as she realizes who you are and what you just did.  “<i>" + pc.short + "!  Are you a frigging ghost or something?  Ow, gods, you just made Kath ");
		if (kath.hasCock())
			output("yank her knot right out of me.</i>”\n\n");
		else output("dig her " + kath.catGirl("nails", "claws") + " in.</i>”\n\n");
		output("Kath looks sheepish and says, “<i>Sorry, sorry, I thought it was ");
		if (urtaKids() == 1) 
			output(flags["COC.URTA_FIRSTBORN_GENDER"] == 1 ? "your son" : "your daughter");
		else output("one of your kids");
		output(",</i>” while gently stroking Urta's ears.\n\n");
		output("Urta lets out a big sigh and returns the favour, garnering a constant deep purr from Kath as she relaxes again.\n\nKath mumbles, ");
	}
	else {
		output("\n\nYou creep over to the bed and stroke Kath's tail.  She and Urta both start giggling and Urta pats your hand, saying, “<i>Hey baby, nice try, but you're not as quiet as you think you are.  Care to join us?</i>”\n\n");
		output("Kath " + (kath.hasCock() ? "gently removes her knot from Urta's pussy" : "slides off Urta's cock") + " and rolls on her back so she can see you.  “<i>I hope you don't mind - we've been taking care of each other.</i>”\n\n");
		output("As if you couldn't tell.  Still, you take a seat on the edge of the bed and give each of them scratches.\n\n");
		output("Kath twists and turns under your touch and says, ");
	}
	output("“<i>I'm feeling really good right now " + kathPlayerText() + ", but if you want to do something, I'm game.</i>”\n\n");
	output("Urta laughs and says, “<i>Oh yeah, and leave me with this mess, huh?</i>”  She scoops a little cum up from the bed and rubs it between her fingers.  “<i>I suppose I could take care of it tomorrow morning if it means you get a good dose of pussy, " + pc.short + ".</i>”");
	clearMenu();
	addButton(0, "Back to Kath's", dateGotoKaths);
	addButton(1, "To the Lake", dateKathBath);
	addButton(2, "Back to the Bar", dateGotoBar);
	addButton(14, "Leave", telAdreMenu);
}

private function katherineDate():void {
	clearOutput(); //Urta's Place and Camp are not available in this expansion
	output("You decide that it might be an idea to lead Katherine somewhere.  Who knows what kind of fun you could get up to?");
	clearMenu();
	if (kathIsAt(KLOC_KATHS_APT)) {
		addButton(0, "The Bar", dateGotoBar);
		addButton(1, "Bath", dateKathBath);
		addButton(14, "Back", katherineMenu);
	}
	else {
		addButton(0, "Kath's Place", dateGotoKaths);
		addButton(1, "Bath", dateKathBath);
		addButton(14, "Back", katherineMenu);
	}
}

private function dateGotoKaths():void {
	if (kathIsAt(KLOC_URTAS_APT)) {
		output("\n\nYou offer to walk her home.  Kath smiles at you, but before she steps out the door Urta grabs her from behind, giving the cat " + kath.catGirl("girl", "morph") + " a big hug.  Then Urta steps out and gives you a hug too.\n\n");
		output("As she goes back inside Urta says, “<i>You take care of each other - and don't do anything I wouldn't do.</i>”");
	}
	else if (kathIsAt(KLOC_URTAS_HOME)) {
		output("\n\nYou have to wait while Kath cleans herself up, but she tries to be quick about it.  You sit on the edge of the bed and rub the back of Urta's neck.  Urta groans and lies down flat in the puddle of cum, saying, “<i>Thanks " + pc.short + ", I'll be fine.  I'm really comfy.</i>”\n\n");
		output("As Kath tracks down the last piece of her clothing you hear gentle snoring from Urta.  You and Kath tiptoe out, leaving Urta to her well deserved rest.");
	}
	else {
		output("\n\nYou ask Kath if she feels like going back to her place.\n\n");
		output("She downs the last of her drink and replies, “<i>Mmmm, I hope you have something in mind.  Preferably something naughty.</i>”");
	}
	processTime(4);
	addNextButton(takeKathHome);
}

private function takeKathHome():void { //You are bringing her home for sexy times
	output("\n\nThe two of you race through the streets heading for Kath's apartment.  You let her stay ahead of you most of the way so you get a nice view of her tight little ass.\n\n");
	output("Kath just about attacks the lock with her key.  As soon as the door opens she pulls you through eagerly, locking it behind you and leading you to the bedroom.\n\n");
	kathClothes();
	output("\n\nShe stands next to her bed, waiting for you to " + (kath.playerMaster() ? "tell her what to do." : "make the first move."));
	flags["COC.KATHERINE_LOCATION"] = KLOC_KATHS_APT;
	processTime(4);
	katherineMenu();
}

private function dateGotoBar():void {
	if (kathIsAt(KLOC_URTAS_APT)) {
		output("\n\nYou offer to take Kath back to the Wet Bitch.  Kath smiles at you, but before she steps out the door Urta grabs her from behind, giving the cat " + kath.catGirl("girl", "morph") + " a big hug.  Then Urta steps out and gives you a hug too.\n\n");
		output("As she goes back inside Urta says, “<i>You take care of each other - and don't do anything I wouldn't do.</i>”");
	}
	else if (kathIsAt(KLOC_URTAS_HOME)) {
		output("\n\nYou have to wait while Kath cleans herself up, but she tries to be quick about it.  You sit on the edge of the bed and rub the back of Urta's neck.  Urta groans and lies down flat in the puddle of cum, saying, “<i>Thanks " + pc.short + ", I'll be fine.  I'm really comfy.</i>”\n\n");
		output("As Kath tracks down the last piece of her clothing you hear gentle snoring from Urta.  You and Kath tiptoe out, leaving Urta to her well deserved rest.");
	}
	else {
		output("\n\nYou ask Kath if she feels like wandering back to the bar.\n\n");
		output("She says, “<i>There are fun things we could do right here.</i>”  Before you can reply she’s hopped into your arms and says, “<i>Of course I’m sure you’ve got something fun in mind when you suggested going there." + (!kath.isPregnant() ? "  Or are you just planning to get me toasted so you can have your way with me?" : "") + "</i>”");
	}
	processTime(3);
	addNextButton(takeKathToTheBar);
}

private function takeKathToTheBar():void { //You are bringing her to the Wet Bitch
	output("\n\nThe two of you walk through the streets of Tel'Adre arm in arm.  Kath enjoys the walk while you think about what you'd like to do with her once you reach the bar.\n\n");
	output("When you walk through the doors of the Wet Bitch Kath stops at the bar and buys a " + (kath.isPregnant() ? "milkshake" : "brown, creamy looking drink with ice cubes in it") + ", which she starts sipping luxuriously.\n\n");
	output("Since it happens to be free you both take a seat at her usual booth and you feel Kath's leg rub against " + (pc.isNaga() ? "yours." : "your tail."));
	flags["COC.KATHERINE_LOCATION"] = KLOC_BAR;
	processTime(3);
	katherineMenu();
}

private function katherineDrinkUp():void {
	clearOutput();
	output("You sit across from Kath and ask her what she’s drinking.\n\n");
	output("She shows you a tumbler with some opaque light brown liquid in it.  “<i>They have this cream liqueur called Venusia.  It’s like drinking milk and booze at the same time.  It’s pretty strong but also girly - kinda like me.  I guess that’s why I like it a lot.</i>”\n\n");
	output("You ask if it’s strong enough to get drunk on.\n\n");
	output("“<i>I’ve already got drunk from this stuff by accident.  Like I said, it’s pretty strong.  My first day in the Watch lots of people bought me drinks.  I found out the hard way that I get a little horny when I’m drunk.  Urta spotted it and got me home before I did anything stupid, but now I make sure to only have one or two of these at a time.</i>”\n\n");
	output("You grin and tell Kath that since you’re here she can indulge.\n\n");
	output("She gives you a smile and waves over the waitress.  When the next tumbler arrives she takes a sip and says, “<i>I bet you’re just trying to get me drunk cause you think I’ll get horny.</i>”  You rub " + (pc.isNaga() ? "the tip of your tail" : "your [pc.toes]") + " against the inside of Katherine’s leg.  She tips back the tumbler, swallows, smiles and orders another.\n\n");
	output("In no time you see the telltale signs that your girlfriend is now wasted.");
	processTime(20 + rand(10));
	flags["COC.KATHERINE_LOCATION"] = KLOC_BAR_DRUNK;
	katSexMenu();
}