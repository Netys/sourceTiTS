import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "../CoC/CoCGame.as"; // all other includes are there

// here shit starts
public function cockyVrJunctionMenu():void {	
	author("Etis");
	setLocation("SHIP\nINTERIOR", rooms[rooms["SHIP INTERIOR"].outExit].planet, rooms[rooms["SHIP INTERIOR"].outExit].system);
	
	addButton(5, "Enter pod", enterCocVrPod);
}

public function enterCocVrPod():void {
	author("Etis");
	clearOutput();
	output("You can swear you feel VR pod is <i>calling</i> you. Promising something. Something... Different.\n\n");
	
	if (flags["COC_VR_INTRO_SEEN"] == undefined) {
		flags["COC_VR_INTRO_SEEN"] = 1;
		output("Pod is filled with strange viscous liquid, which smells like... Blood. According to manual, you can actually breath in it.  ");
		output("Instruction said you have to strip naked and put your gear inside specail section of the pod. Wait... That section is full of liquid too. You open instruction again.\n\n");
		output("<i>“Yes, you actually should do it. Liquid is there for purpose. It is safe for any equipment.”</i>\n\n");
		output("Looks like your confusion were expected. Here goes nothing... You lay inside and watch capsule lid closing.\n\n");
		
		if (pc.gills) output("At least, you don't actually have to <i>breath</i>, thanks to your gills. Inhaling liquid is far from pleasant, and perspective of coughing it out after is even less appealing.\n\n");
		else output("First inhale of liquid is quite an experience. Not pleasant one, but not as bad as you've expected.\n\n");
		
		output("You feel like inside sensory deprivation chamber — liquid is surprisingly good at dampening any sounds and vibrations, and you feel yourself floating in nowhere.");
		output("Few seconds after VR system kicks in and you've found yourself in a dark cave in front of glowing purple-pink portal. Simulation ia amazingly realistic - you can feel air flows caressing your [pc.skinFurScales], stone floor texture under your [pc.legs], humming and light of portal...  ");
		output("And, suddenly, holo-screen, totally misplaced here, appears.");
		
		output("\n\nWelcome to Corruption of Champions simulation. Running init sequence...");
		output("\nHardware: E.22.5 R2 Prototype, feedback status: full/extended (not configurable).");
		output("\nSoftware: M.15.12 R1 Legacy, running in failsafe/minimal mode.");
		output("\nUser sync system: fully functional.");
		output("\nUser sync level: 87%, stable.");
		output("\nPlayer avatar: scan-based. Manual configuration is not available.");
		output("\nWorld init... ");
		initCoCJunk();
		output("Ready. Pre-defined world file loaded. Manual configuration is not available.");
		output("\n\n");
		output("World rules:");
		output("\nAcces to user interface is limited.");
		output("\nLocal and real currency transitions would be done seamlessly. Exchange rate: 1 \"gem\" = 10 credits.");
		output("\nExit is possible from entry point only. Warning: this means you will remain inside until you reach entry point.");
		output("\nFeedback power is not limited. Warning: this can include permanent physical and mental changes.");
		output("\nUser's personal memory is suppressed during simulation.");
		output("\n\n");
		output("Would you kindly enter the portal to launch main sequence?\n\n");
		processTime(20);
	} else {
		output("You lay inside and watch capsule lid closing. Few seconds, and familiar portal is ahead...\n\n");
		processTime(5);
	}
	
	clearMenu();
	addButton(0, "Enter portal", EnterVRIAmYourBloodyChampionYouVapidCunt, null, "Enter portal", "Bring it on!");
	addButton(4, "Abort", abortIAmNotBloodyChampion, null, "Abort", "You are not ready now.");
	addDisabledButton(9, "Reset", "Reset", "Not implemented yet.");
}

public function abortIAmNotBloodyChampion():void {
	author("Etis");
	move("VR_POD_ROOM");
	updatePCStats();
	clearOutput();
	
	output("System shutdown...\n\n");
	output("Pod lid is opened, and you are free to get out.");
	if (!pc.gills) output("  You just need some time to cough out this liquid...");
	output("\n\n");
	
	if (flags["COC_VR_OUTRO_SEEN"] == undefined && flags["COC_INTRO_SEEN"] != undefined) { // actually, this would be better to use when something is actually changed, but detection would be overcomplicated
		flags["COC_VR_OUTRO_SEEN"] = 1;
		output("Wait, what... Your body is by one hundred percent like one you had upon exiting simulation! And... Why you are not surprised? Contents of an item box are exactly like your possessions from simulation, too.\n\n");
		output("Who knew that remark about \"not limited feedback\" should be taken so literally?\n\n");
		output("And... Was it REALLY just simulation?\n\n");
	}
	
	processTime(5);
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function EnterVRIAmYourBloodyChampionYouVapidCunt():void {
	author("Etis");
	clearOutput();
	clearMenu();
	
	if (flags["COC_INTRO_SEEN"] == undefined) {
		flags["COC_INTRO_SEEN"] = 1;
		cocMainIntroScene0();
	} else {
		move("COC_CAMP");
	}
}