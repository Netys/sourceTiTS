import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.GameData.TooltipManager;
import classes.GLOBAL;
import classes.ItemSlotClass;
import classes.StringUtil;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "../CoC/CoCGame.as"; // all other includes are there

// This is deprecated function. It can be removed and is only left to not screw saves within removed VR Pod room.
public function cockyVrJunctionMenu():Boolean {	
	author("Etis");
	setLocation("SHIP\nINTERIOR", rooms[rooms["SHIP INTERIOR"].outExit].planet, rooms[rooms["SHIP INTERIOR"].outExit].system);
	
	//addButton(5, "Enter pod", enterCocVrPod);
	addButton(0, "Next", move, "SHIP INTERIOR");
	return true;
}

public function enterCocVrPod():void {
	author("Etis");
	showName("\nVR POD");
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
	//addDisabledButton(9, "Reset", "Reset", "Not implemented yet."); // not sure ever would be, since resetting would allow recollection of unique loot
}

public function abortIAmNotBloodyChampion():void {
	updatePCStats();
	author("Etis");
	showName("\nVR POD");
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
	addButton(0, "Next", move, "SHIP INTERIOR");
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

//////////////////////////////////////////
////    {location=STELLAR FURNACE}    ////
//////////////////////////////////////////

public function showNemo():void {
	author("Etis");
	showName("\n{ nemo }");
	showBust("NEMO");
}

// note: he totally can talk normally, he just having some fun
public function guildEmbassyBonusFunction():Boolean {
	author("Etis");
	showName("{ STELLAR		\nFURNACE }");
	
	if (flags["COC.NEMO_INTRODUCED"] == undefined)
	{
		flags["COC.NEMO_INTRODUCED"] = 1;
		output("Lead by curiocity, you enter Stellar Furnace. You look ar^#R*&\n\n");
		output("{ location: name 'Stellar Furnace'; function 'shop (presumably)' }\n\n");
		//output("{status: embassy=enabled; shop=disabled}\n");
		output("*@#&%#hat the? It feels a bit like direct condection with holodeck interface, but such things can only work with direct contact. It is hard to think in norm&^@%#$*\n\n");
		output("{ protocol: verbose deprecated; stream/representation enabled }\n\n");
		output("{ connection request: from object; id vendor; race 'arctic fox morph (presumably)'; gender unclear; location 'behind counter'; position 'chair (presumably); hind paws on counter; arms (presumably, possibly paws) behind head' }\n\n");
		output("{ input from vendor: welcome; this name undefined; this id nemo; notify { shop state disabled; embassy state enabled }; request response }\n\n");
		output("{ output to nemo; greeting; this name '[pc.fullName]'; request { protocol; shop state extended; embassy faction; nemo race } }\n\n");
		output("{ input from nemo: protocol 'mind connection, limited'; shop state 'trading license pending, expected time over 100 years'; embassy faction { name undefined; id { guild, 'stellar furnace' } one of }; this race { kitsune; action 'jumps over counter to show nine fluffy tails' }; request response }\n\n");
		processTime(6);
	}
	else
	{
		output("{ protocol: verbose deprecated; stream/representation enabled }\n\n");
		output("{ location: name 'Stellar Furnace'; function embassy }\n\n");
		output("{ interactions: nemo; exit }\n\n");
		processTime(1);
	}
	clearMenu();
	addButton(0, "{ next }", approachNemo);
	return true;
}

public function approachNemo():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ input from nemo: welcome; request input }\n\n");
	
	addDisabledButton(0, "{ buy }", "{ buy }", "{ shop closed }");
	
	addButton(1, "{ stock }", nemoCollection, undefined, "{ stock }", "{ request: stock examine }");
	addButton(2, "{ talk }", nemoTalk, undefined, "{ talk }", "{ request: conversation }");
	addButton(4, "{ look }", nemoLook, undefined, "{ look }", "{ action: nemo examine }");
	
	addButton(14, "{ leave }", leaveNemo);
}


public function leaveNemo():void {
	clearOutput();
	clearMenu();
	author("Etis");
	showName("{ STELLAR		\nFURNACE }");
	output("{ input from nemo: bye }\n\n");
	output("^%$@$adache after this chat. No doubts, little prankster is mocking you.");
	
	addButton(0, "Next", move, rooms[currentLocation].northExit);
}

public function nemoLook():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{\n");
	output("	nemo {\n");
	
	output("		species: kitsune;\n");
	output("		size: { height: 4' 9\"; weight: 66 lb };\n");
	output("		color: { fur: white; skin: white; accents: azure; eyes: azure };\n");
	if (flags["COC.NEMO_GENDER_KNOWN"] == undefined) output("		gender: ambiguous;\n");
	else output("		gender: male;\n");
	output("		age: '800+ (presumably)';\n");
	output("		form: 'semi-anthropomorphic vulpine';\n");
	output("		tails: fluffy;\n");
	
	output("	}\n");
	output("}\n");
	
	addButton(0, "{ next }", approachNemo);
}

// one can understand why he have no hopes to get license within 100 years after one look on his wares... not that he actually want it, he just mocking authorities
public function nemoCollection():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ input from nemo: display enabled; shop disabled }\n\n");
	
	flags["COC.NEMO_STOCK_SEEN"] = 1;
	
	var tmp:ItemSlotClass;
	var btn:int = 0;
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.MELEE_WEAPON;
	tmp.shortName = "Vorpal Blade";
	tmp.longName = "Vorpal Blade";
	tmp.description = "a vorpal blade";
	tmp.tooltip = "Just a handle while disabled, it appears to be some sort of energy blade. It can cut through anything within reach.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.unresistable_hp.damageValue = 100;
	tmp.baseDamage.addFlag(DamageFlag.BYPASS_SHIELD);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.attackVerb = "cut";
	tmp.attackNoun = "clean cut";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "Mass Driver";
	tmp.longName = "mass driver";
	tmp.description = "a mass driver";
	tmp.tooltip = "Heavy kinetic cannon, using simple tungsten slugs as ammo. Beware of projectile ablation in atmosphere, recommended to limit initial velocity to 5 km/s.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.kinetic.damageValue = 1000;
	tmp.baseDamage.addFlag(DamageFlag.BULLET);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_POWER_ARMOR);
	tmp.attackVerb = "shoot";
	tmp.attackNoun = "penetrate";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "Ultimatum";
	tmp.longName = "Ultimatum";
	tmp.description = "an anti-material cannon";
	tmp.tooltip = "This huge and immensely massive contraption is actually a weapon of mass destruction. Grenade launcher pushed to concept's limit, it throws tiny portions of an anti-matter contained inside of a hardlight trap as projectile. There are only one word for it's power: devastating.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.burning.damageValue = 500;
	tmp.baseDamage.kinetic.damageValue = 500;
	tmp.baseDamage.addFlag(DamageFlag.EXPLOSIVE);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_POWER_ARMOR);
	tmp.attackVerb = "shoot";
	tmp.attackNoun = "annihilate";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "Pwr. Punch";
	tmp.longName = "Power Puncher";
	tmp.description = "a power puncher";
	tmp.tooltip = "This thing is a bit misplaced in this collection, since it is not intended to be handheld. It is special equipment for boarding party shuttle, intended to suppress even fortress shields.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.unresistable_hp.damageValue = Number.POSITIVE_INFINITY;
	tmp.baseDamage.addFlag(DamageFlag.ONLY_SHIELD);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_POWER_ARMOR);
	tmp.attackVerb = "shoot";
	tmp.attackNoun = "punch";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "AFL";
	tmp.longName = "automatic fission laser";
	tmp.description = "an automatic fission laser";
	tmp.tooltip = "This little thing is far from impressive - little more than a foot long, with a short wooden butt and a short, heavily reinforced barrel. Quite weighty, though - nearly 14 pounds. Ultimate handheld weapon, the automatic fission laser have logarithmic slider to control it's output power, from 'cut neat little hole' at 1 to 'evaporate this city, and that mountain too' at 10.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.unresistable_hp.damageValue = Number.POSITIVE_INFINITY;
	tmp.baseDamage.addFlag(DamageFlag.LASER);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.attackVerb = "shoot";
	tmp.attackNoun = "wipe";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "Designator";
	tmp.longName = "designator";
	tmp.description = "a designator";
	tmp.tooltip = "This tool is nothing more than simple rangefinder. The real ‘gun’, orbital cannon, would be somewhere above.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.addFlag(0);
	tmp.attackVerb = "trigger";
	tmp.attackNoun = "smite";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.RANGED_WEAPON;
	tmp.shortName = "Portal Gun";
	tmp.longName = "portal gun";
	tmp.description = "a portal gun";
	tmp.tooltip = "This gun-like tool is actually a handheld exit-only Warp Gate unit. While quite useless by itself, it can be used to channel whatever you have on the other side, be it candy dispenser or star destroyer's main caliber.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.addFlag(0);
	tmp.attackVerb = "shoot";
	tmp.attackNoun = "shot";
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.ACCESSORY;
	tmp.shortName = "P.Heart";
	tmp.longName = "Heart of Power";
	tmp.description = "the Heart of Power";
	tmp.tooltip = "The Heart of Power, implantable anti-matter power battery for undefeated fighter. Contains enough energy to power any weapons and gadgets you are using as long as you are able to fight. Contains enough energy to wipe a city during mandatory self-destruction protocol on loss. Either ways, you always have guaranteed draw.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.ACCESSORY;
	tmp.shortName = "Fin Funnels";
	tmp.longName = "set of fin funnels";
	tmp.description = "a set of fin funnels";
	tmp.tooltip = "Set of 4 autonomous drones, equipped with heavy tachyon beam cannons and shield generators. While intended to be used as heavy support for heavy armour, their tremendously long operational time allows them to be used as standalone units.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.electric.damageValue = 10;
	tmp.baseDamage.burning.damageValue = 25;
	tmp.baseDamage.kinetic.damageValue = 15;
	tmp.baseDamage.unresistable_hp.damageValue = 25;
	tmp.baseDamage.addFlag(DamageFlag.LASER);
	tmp.baseDamage.addFlag(DamageFlag.ENERGY_WEAPON);
	tmp.baseDamage.addFlag(DamageFlag.PENETRATING);
	tmp.shields = 500;
	tmp.addFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON);
	tmp.addFlag(GLOBAL.ITEM_FLAG_EFFECT_FLURRYBONUS);
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.DRUG;
	tmp.shortName = "Tabula Rasa";
	tmp.longName = "container of Tabula Rasa";
	tmp.description = "a container of Tabula Rasa";
	tmp.tooltip = "The ultimate transformative. Breaks down user's body to atoms and builds it anew, using Guild's mainframe to temporary store user's mind. Creates new and absolutely flawless body with any desired features. Guild gives warranty to fix ANY conditions, from wrong splices to natural aging.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.ARMOR;
	tmp.shortName = "Lotus Suit";
	tmp.longName = "Lotus Suit";
	tmp.description = "a Lotus suit";
	tmp.tooltip = "Advanced suit designed for infiltrators and diversionists. While suits constructed from a gray goo are not really new concept, this particular model is honed to perfection. It can take form of any outfit suitable for the situation. Even if quite thin, layer of nanobots is more than able to form a hard exoskeleton with all benefits usual power armor could provide, including thermal management and life support. Highly advanced mimicry software can imitate any species of appropriate body configuration or act as chameleon camouflage, allowing it's owner to blend in with the crowd or hide in a plain sight. Needless to say about functions like forming high variety of tools, weapons and gadgets.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.defense = 25;
	tmp.sexiness = 6;
	tmp.evasion = 5;
	tmp.resistances.kinetic.resistanceValue = 50;
	tmp.resistances.electric.resistanceValue = 50;
	tmp.resistances.burning.resistanceValue = 50;
	tmp.resistances.freezing.resistanceValue = 50;
	tmp.resistances.corrosive.resistanceValue = 100;
	tmp.resistances.poison.resistanceValue = 100;
	tmp.resistances.psionic.resistanceValue = 0;
	tmp.resistances.drug.resistanceValue = 100;
	tmp.resistances.pheromone.resistanceValue = 100;
	tmp.resistances.tease.resistanceValue = 0;
	tmp.resistances.addFlag(DamageFlag.GROUNDED);
	tmp.resistances.addFlag(DamageFlag.MIRRORED);
	tmp.addFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
	tmp.addFlag(GLOBAL.ITEM_FLAG_SWIMWEAR);
	tmp.addFlag(GLOBAL.ITEM_FLAG_POWER_ARMOR);
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	tmp = new ItemSlotClass();
	tmp.stackSize = 1;
	tmp.type = GLOBAL.EXPLOSIVECONSUMABLE;
	tmp.shortName = "Cyclonic Torp.";
	tmp.longName = "Cyclonic Torpedo";
	tmp.description = "a Cyclonic Torpedo";
	tmp.tooltip = "The weapon of singular destruction. Of singular planet, to be precise. This device will burrow though a planet's surface and detonate at the core. This will destabilize a planet, and will shatter that world in many cases.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	addOverrideItemButton(btn++, tmp, tmp.shortName);
	
	if (flags["COC.NEMO_VR_POD_TAKEN"] == undefined)
	{
		tmp = new ItemSlotClass();
		tmp.stackSize = 1;
		tmp.type = GLOBAL.GADGET;
		tmp.shortName = "VR Pod";
		tmp.longName = "virtual reality pod";
		tmp.description = "a virtual reality pod";
		tmp.tooltip = "Archaic and seemingly overcomplicated virtual reality pod with long-term life support system. Definitely stands out from other merchandise. Maybe you should ask about it?";
		TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
		TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
		addOverrideItemButton(btn++, tmp, tmp.shortName, nemoTalkVRPod);
	}
	
	addButton(14, "{ back }", approachNemo);
}

public function nemoTalk():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ input from nemo: request topic }\n\n");
	var btn:int = 0;
	
	if (flags["COC.NEMO_STOCK_SEEN"] == 1) addButton(btn++, "{ stock }", nemoTalkStock);
	else addDisabledButton(btn++, "{ stock }", "{ stock }", "{ subject unknown }");
	
	if (flags["COC.NEMO_STOCK_SEEN"] == undefined) addDisabledButton(btn++, "{ 'vr pod' }", "{ 'vr pod' }", "{ subject unknown }");
	else if(flags["COC.NEMO_VR_POD_TAKEN"] == undefined) addButton(btn++, "{ 'vr pod' }", nemoTalkVRPod);
	else addDisabledButton(btn++, "{ 'vr pod' }", "{ 'vr pod' }", "{ subject exhausted }");
	
	if (flags["COC.NEMO_GENDER_KNOWN"] == undefined) addButton(btn++, "{ gender }", nemoTalkGender);
	else addDisabledButton(btn++, "{ gender }", "{ gender }", "{ subject exhausted }");
	
	addButton(14, "{ back }", approachNemo);
}

public function nemoTalkGender():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ input from nemo: gender male }\n\n");
	
	flags["COC.NEMO_GENDER_KNOWN"] = 1;
	addButton(0, "{ next }", nemoTalk);
}

public function nemoTalkStock():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ output to nemo: stock wmd; legality }\n\n");
	output("{ input from nemo: illegal }\n\n");
	output("{ output to nemo: illegal; license }\n\n");
	output("{ input from nemo: hopeless }\n\n");
	output("{ output to nemo: license; declined }\n\n");
	output("{ input from nemo: stock wmd; action 'mischievous smile' }\n\n");
	output("{ output to nemo: reason }\n\n");
	output("{ input from nemo: bored }\n\n");
	// yep, he totally can appear with fuckton of WMD in cargo hold and innocently ask if he can sell them to civilians just to see what happens...
	// of course, he would decline any offers to trade with U.G.C. only - all or nothing
	
	addButton(0, "{ next }", nemoTalk);
}

public function nemoTalkVRPod():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ output to nemo: 'vr pod'; info }\n\n");
	output("{ input from nemo: not stock; unknown origin; possibly alive; confusion; offer; barter; payment telemetry }\n\n");
	
	addButton(0, "{ accept }", nemoTakeVRPod);
	addButton(1, "{ decline }", nemoTalk);
}

public function nemoTakeVRPod():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ output to nemo: 'vr pod'; trade; accept }\n\n");
	output("{ input from nemo: sold; delivered; installed; enjoy }\n\n");
	
	output("<b>You’ve a VR POD installed in your ship! You can access it from the storage menu.</b>");
	
	flags["COC.NEMO_VR_POD_TAKEN"] = 1;
	flags["COC.VR_POD_INSTALLED"] = 1;
	addButton(0, "{ next }", nemoTalk);
}