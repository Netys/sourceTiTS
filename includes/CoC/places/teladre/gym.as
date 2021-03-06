import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "brooke.as";
include "cotton.as";
include "heckel.as";
include "ifris.as";
include "jasun.as";
include "loppe.as";
include "lottie.as";
include "sexMachine.as";

public function TelAdreGymDesc():void {
	showName("\nGYM");
	//PREGGO ALERT!
	if (flags["COC.PC_IS_A_GOOD_COTTON_DAD"] == undefined && flags["COC.PC_IS_A_DEADBEAT_COTTON_DAD"] == undefined && flags["COC.COTTON_PREGNANCY_INCUBATION"] != undefined) {
		cottonPregnantAlert();
		return;
	}

	clearOutput();
	clearMenu();
	output("Even though Ingnam, your hometown, was a large, prosperous village, you never saw a gym before coming to Tel'Adre.  The structure itself has numerous architectural differences from the surrounding buildings: short, waist-high walls, an arched ceiling supported by simple columns, and a sand-covered floor.  Perhaps the only 'normal' rooms inside are the changing stands and bathrooms, which ");
	if(pc.exhibitionism() > 66 || pc.slut() > 80) output("unfortunately ");
	else if(pc.exhibitionism() < 33 && pc.slut() < 35) output("thankfully ");
	output("have full sized walls to protect their users' privacy.  A breeze blows by, revealing that the open-air design provides great ventilation.  You note a wall of weights of different sizes and shapes, perfect for building muscle and bulking up.  There are also jogging tracks and even a full-sized, grass-covered track out back for centaurs to run on.  Though some of the equipment seems a bit esoteric in nature, you're sure you can make use of most of this stuff.\n\n");

	output("Though the gym sees heavy use by the city guard and various citizens, it's not too busy at present.");
	//(Add possible character descripts here)
	//(An extraordinarily well-muscled centaur male is by the weights, lifting some huge dumbbells and sweating like crazy.  In true centaur fashion, he's not wearing any clothes, but then again, male centaurs don't have much that regular clothes would hide.)
	//(There's a lizan girl jogging laps on one of the tracks.  She's quite thin, but her muscles have a lean definition to them.  She's wearing a one-piece, spandex leotard that hugs her tight ass and pert, b-cup breasts nicely.)
	output("  There's a centauress in a tank-top just inside the doorway with huge, rounded melons and perky nipples, but she merely coughs to get you to look up and says, \"<i>");
	if(flags["COC.LIFETIME_GYM_MEMBER"] != 1) output("10 gems an hour to use the facilities here, or 500 for a life-time membership.</i>\"  She has her hands on her hips, and it looks you'll have to pay ten gems to actually get to use any of this stuff.");
	else output("Oh, welcome back [pc.name].  Have a nice workout!</i>\"");

	if(pc.credits < 100 && flags["COC.LIFETIME_GYM_MEMBER"] != 1) {
		output("\n\n<b>You reach into your pockets for the fee and come up empty.  It looks like you don't have enough money to use the equipment or meet anyone.  Damn!</b>");
		//(back to tel'adre streets)
		processTime(5);
		addButton(0, "Next", telAdreMenu);
		return;
	}
	lottieAppearance();
	if(flags["COC.LOPPE_MET"] == 1 && flags["COC.LOPPE_DISABLED"] != 1) {
		output("\n\nYou spot Loppe the laquine wandering around, towel slung over her shoulder.  When she sees you, she smiles and waves to you and you wave back.");
	}
	if(hours > 9 && hours <= 15) heckelAppearance();
	TelAdreGymMenu();
}

private function TelAdreGymMenu():void {
	var but:int = 0;
	
	// physique training
	if (pc.energy() >= 50 && !pc.hasStatusEffect("Sore")) addButton(but++, "LiftWeights", TelAdreGymLift, undefined, "Lift Weights", "A hard workout that'll help you build muscle and strength.");
	else addDisabledButton(but++, "LiftWeights", "Lift Weights", "You're too tired for that workout.");
	
	// reflexes training
	if (pc.energy() >= 50 && !pc.hasStatusEffect("Sore")) addButton(but++, "Run", TelAdreGymJog, undefined, "Run", "Run around the track to burn some fat.");
	else addDisabledButton(but++, "Run", "Run", "You're too tired for that workout.");
	
	// Jasun
	// actually would be nice to have pool implemented for aim training...
	addButton(but++, "ChangeRoom", changingRoom);
	
	// Permanent membership
	if (flags["COC.LIFETIME_GYM_MEMBER"] != 1)
		if(pc.credits >= 5000)
			addButton(but++, "Life Member", buyGymLifeTimeMembership);
		else
			addDisabledButton(but++, "Life Member", "Life Member", "You can't afford it!")
	
	// Loppe
	if (flags["COC.LOPPE_MET"] == 1 && flags["COC.LOPPE_DISABLED"] != 1)
		addButton(but++, "Loppe", loppeGenericMeetings);
	
	// Ifris
	if(ifrisIntro()) addButton(but++, flags["COC.MET_IFRIS"] == undefined ? "Girl" : "Ifris", approachIfris);
	
	// Lottie
	if (lottieAppearance(false) != null) addButton(but++, flags["COC.LOTTIE_MET"] == undefined ? "Pig-Lady" : "Lottie", lottieAppearance(false));
	
	// Heckel
	if (hours > 9 && hours <= 15) addButton(but++, flags["COC.MET_HECKEL"] == 1 ? "Heckel" : "Hyena", greetHeckel);
	
	// Cotton
	if (flags["COC.PC_IS_A_DEADBEAT_COTTON_DAD"] == undefined && cottonsIntro())
		addButton(but++, flags["COC.COTTON_MET_FUCKED"] > 0 ? "Cotton" : "Horsegirl", cottonGreeting);
	
	addButton(14, "Leave", telAdreMenu);
}

private function buyGymLifeTimeMembership():void {
	clearOutput();
	//[Buy LifeTime Membership]
	if (silly) output("You tell \"<i>Shut up and take my gems!</i>\" as you pull out your gem-pouch. \n\n"); //Shut up and take my gems!
	output("You fish into your pouches and pull out 500 gems, dumping them into the centaur's hands.  Her eyes widen as she turns and trots towards a counter in the back.  She leans over as she counts, giving you a generous view down her low-cut top at the cleavage she barely bothers to conceal.");
	if(pc.hasCock()) {
		output("  It brings a flush to your face that has nothing to do with exercise.  Maybe you'll be able to con her into some alone time later?");
		pc.lust(10 + pc.libido() / 10);
	}
	flags["COC.LIFETIME_GYM_MEMBER"] = 1;
	pc.credits -= 5000;
	//statScreenRefresh();
	//[Bring up gym menu]
	processTime(5);
	clearMenu();
	addButton(0, "Next", TelAdreGymMenu);
}

private function TelAdreGymLift():void {
	clearOutput();
	//Too tired?  Fuck off.
	if(pc.energy() < 50) {
		output("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if(flags["COC.LIFETIME_GYM_MEMBER"] != 1) output("It'd be better to save your money and come back after you've rested.");
		addButton(0, "Next", telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if(flags["COC.LIFETIME_GYM_MEMBER"] != 1) {
		pc.credits -= 100;
	}
	//[Lift Weights] +25 fatigue!
	pc.energy( -50);
	//TEXTS!
	output("You walk up to the weights and begin your workout.  ");
	//(< 25 str)
	if(pc.PQ() < 25) output("You have to start out on the smaller weights to the left side of the rack due to your strength, but even so, you manage to work up a good burn and a modest sweat.");
	//(< 40 str)
	else if(pc.PQ() < 40) output("You heft a few of the weights and select some of the ones just to the left of the middle.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.");
	//(< 60 str)
	else if(pc.PQ() < 60) output("You smile when you grip a few of the heavier weights on the rack and start to do some lifts.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly an hour doing various strength-building exercises with the weights.");
	//(<80 str)
	else if(pc.PQ() < 80) output("You confidently grab the heaviest dumbbells in the place and heft them.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about an hour, but you feel you made some good progress today.");
	//(<90)
	else if(pc.PQ() < 90) output("You grab the heaviest weights they have and launch into an exercise routine that leaves you panting from exertion.  Setting the weights aside, you flex and marvel at yourself – you could probably arm wrestle a minotaur or two and come out victorious!");
	//(else)
	else output("This place barely has anything left to challenge you, but you take the heaviest weights you can get your mitts on and get to it.  By the time an hour has passed, you've worked up a good sweat, but without heavier weights you probably won't get any stronger.");
	processTime(60);
	//Stat changes HERE!
	//if (pc.str < 90) dynStats("str", .5);
	pc.slowStatGain("p", 1);
	soreDebuff(2);
	sweatyDebuff(2);
	//if(pc.tou < 40) dynStats("tou", .3);
	//Body changes here
	//Muscleness boost!
	Mutator.modTone(pc, 100, 3, true);
	TelAdreGymAfterTraining();
}

public function TelAdreGymJog():void {
	clearOutput();
	//Too tired?  Fuck off.
	if(pc.energy() < 50) {
		output("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if(flags["COC.LIFETIME_GYM_MEMBER"] != 1) output("It'd be better to save your money and come back after you've rested.");
		addButton(0, "Next", telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if(flags["COC.LIFETIME_GYM_MEMBER"] != 1) {
		pc.credits -= 100;
	}
	//[Jogging] +30 fatigue!
	pc.energy( -50);
	//Text!
	output("You hit the jogging track, ");
	//(<25 tou)
	if(pc.RQ() < 25) output("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to stay at a fast walk until you can run again.");
	//(<40 tou)
	else if(pc.RQ() < 40) output("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.");
	//(<60 tou)
	else if(pc.RQ() < 60) output("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat.  Even your [pc.legs] tingle and burn with exhaustion.");
	//(<80 tou)
	else if(pc.RQ() < 80) output("and it doesn't faze you in the slightest.  You run lap after lap at a decent clip, working yourself until you're soaked with sweat and fairly tired.");
	//(<90 tou)
	else if(pc.RQ() < 90) output("and you have a terrific time.  You can keep yourself just below your sprinting speed for the entire time, though you work up a huge amount of sweat in the process.");
	//else)
	else output("and it barely challenges you.  You run at a sprint half the time and still don't feel like you're improving in the slightest.  Still, you do manage to burn a lot of calories.");
	//Stat changes HERE!
	//if(pc.spe < 40) dynStats("spe", .3);
	//if(pc.tou < 90) dynStats("tou", .5);

	//If butt is over 15 guaranteed reduction
	if(pc.buttRating() >= 15) {
		output("\n\nAll that running must have done some good, because your [pc.ass] feels a little less bouncy.");
		pc.buttRating(-1);
	}
	else {
		if(pc.buttRating() >= 10 && rand(3) == 0) {
			output("\n\nThe jogging really helped trim up your [pc.ass].");
			pc.buttRating(-1);
		}
		else if(pc.buttRating() >= 5 && rand(3) == 0) {
			output("\n\nYour [pc.ass] seems to have gotten a little bit more compact from the work out.");
			pc.buttRating(-1);
		}
		else if(pc.buttRating() > 1 && rand(4) == 0) {
			output("\n\nYour [pc.ass] seems to have gotten a little bit more compact from the work out.");
			pc.buttRating(-1);
		}
	}//If hips is over 15 guaranteed reduction
	if(pc.hipRating() >= 15) {
		output("\n\nIt feels like your [pc.hips] have shed some pounds and narrowed.");
		pc.hipRating(-1);
	}
	else {
		if(pc.hipRating() >= 10 && rand(3) == 0) {
			output("\n\nIt feels like your [pc.hips] have shed some pounds and narrowed.");
			pc.hipRating(-1);
		}
		else if(pc.hipRating() >= 5 && rand(3) == 0) {
			output("\n\nIt feels like your [pc.hips] have shed some pounds and narrowed.");
			pc.hipRating(-1);
		}
		else if(pc.hipRating() > 1 && rand(4) == 0) {
			output("\n\nIt feels like your [pc.hips] have shed some pounds and narrowed.");
			pc.hipRating(-1);
		}
	}
	
	pc.slowStatGain("r",1);
	processTime(60);
	if(pc.thickness > 20) Mutator.modThickness(pc, 20, 3, true);
	soreDebuff(2);
	sweatyDebuff(2);
	TelAdreGymAfterTraining();
}

public function TelAdreGymAfterTraining():void {
	output("\n\nDo you want to hit the showers before you head back to camp?");
	clearMenu();
	
	addButton(0, "Leave", telAdreMenu);
	
	if (Flag("COC.BROOKE_MET") == 0)
		addButton(1, "Showers", meetBrookeFirstTime);
	else
		addButton(1, "Showers", repeatChooseShower);
	
	if (flags["COC.DISABLED_SEX_MACHINE"] != 1) {
		if (Flag("COC.SEX_MACHINE_KNOWN") == 0)
			addButton(1, "Showers", exploreShowers); // uses 1st slot and overrides Brooke for first time
		else if (Flag("COC.SEX_MACHINE_KNOWN") == 1)
			addButton(2, "Machine?", exploreShowers); // repeated encounters have own slot
		else if (Flag("COC.SEX_MACHINE_KNOWN") == 2)
			addButton(2, "\"Showers\"", useTheSexMachine);
	}
}