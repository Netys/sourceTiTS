import classes.Characters.PlayerCharacter;
import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.GameData.TooltipManager;
import classes.GLOBAL;
import classes.ItemSlotClass;
import classes.StringUtil;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "../coc/coc.as"; // all other includes are there

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
	output("You can swear you feel VR pod is <i>calling</i> you. Promising something. Something... Different.");
	
	if (flags["COC_VR_INTRO_SEEN"] == undefined) {
		flags["COC_VR_INTRO_SEEN"] = 1;
		output("\n\nPod is filled with strange viscous liquid, which smells like... Blood? According to manual, you can actually breath in it. ");
		if(pc.hasKeyItem("Key of the Twillight")) {
			output("Instruction said you have to strip naked and put your gear inside specail section of the pod. Wait... That section is full of liquid too. You open instruction again.\n\n");
			output("<i>“Yes, you actually should do it. Liquid is there for purpose. It is safe for any equipment.”</i>");
			output("Looks like your confusion were expected. ");
		}
		output("Here goes nothing... You lay inside and watch capsule lid closing.");
		
		if (pc.gills) output("\n\nAt least, you don't actually have to <i>breath</i>, thanks to your gills. Inhaling liquid is far from pleasant, and perspective of coughing it out after is even less appealing.\n\n");
		else output("\n\nFirst inhale of liquid is quite an experience. Not pleasant one, but not as bad as you've expected.");
		
		output("\n\nYou feel like inside sensory deprivation chamber — liquid is surprisingly good at dampening any sounds and vibrations, and you feel yourself floating in nowhere. Few seconds after VR system kicks in and you've found yourself in a dark cave in front of glowing purple-pink portal. Simulation ia amazingly realistic - you can feel air flows caressing your [pc.skinFurScales], stone floor texture under your [pc.legs], humming and light of portal... And, suddenly, holo-screen, totally misplaced here, appears.");
		
		output("\n\nWelcome to Corruption of Champions. Running init sequence...");
		output("\nHardware: E.22.5 Prototype/R2, feedback system status: full/extended, auto-ajust mode.");
		output("\nSoftware: M.15.12 R1 Legacy, running in failsafe/minimal mode.");
		output("\nUser sync system: fully functional.");
		output("\nUser sync level: 87%, stable.");
		if(pc.hasKeyItem("Key of the Twillight"))
			output("\nPlayer avatar: scan-based. Manual configuration is not available.");
		else
			output("\nPlayer avatar: pending creation.");
		output("\nWorld init... ");
		initCoCJunk();
		output("Ready. Pre-defined world file loaded. Manual configuration is not available.");
		output("\n\n");
		output("World rules:");
		output("\nAcces to user interface is limited.");
		if(pc.hasKeyItem("Key of the Twillight"))
			output("\nLocal and real currency transitions would be done seamlessly. Exchange rate: 1 \"gem\" = 10 credits.");
		output("\nExit is possible from entry point only. Warning: this means you will remain inside until you reach entry point.");
		if(pc.hasKeyItem("Key of the Twillight"))
			output("\nFeedback power is not limited. Warning: this can include permanent physical and mental changes.");
		else
			output("\nFeedback power is high. Warning: this can include permanent mental damage.");
		if(pc.hasKeyItem("Key of the Twillight"))
			output("\nUser's personal memory is suppressed during simulation.");
		output("\n\nWould you kindly enter the portal to launch main sequence?");
		processTime(20);
	}
	else if (flags["COC.PLOT_END"] == 1 && flags["COC_VR_INTRO_SEEN"] == 1) {
		flags["COC_VR_INTRO_SEEN"] = 2; // first enter after plot end - there are some changes here...
		output("Repaired pod is still filled with same strange viscous liquid with faint smell of blood. You lay inside and watch capsule lid closing again.");
		output("\n\nSame familiar holo-screen.");
		output("\n\nWelcome to Corruption of Champions simulation. Running init sequence...");
		output("\nHardware: E.22.5 Prototype/R2.1, feedback system status: full/extended, auto-ajust mode.");
		output("\nSoftware: undefined.");
		output("\nUser sync system: online.");
		output("\nUser sync level: NaN, stable.");
		output("\nWorld init... Saved state loaded.");
		output("\nWarning: previous session was aborted.");
		output("\nProcessing recovery protocol... Done. Warning: partial data loss registered. Rollback to stable state executed. Potentially corrupt module blocked.");
		output("\nProcessing world changes... Done.");
		output("\n\nWould you kindly enter the portal to launch main sequence?");
		processTime(10);
		
	} else {
		output("You lay inside and watch capsule lid closing. Few seconds, and familiar portal is ahead...");
		processTime(5);
	}
	
	clearMenu();
	addButton(0, "Enter portal", EnterVRIAmYourBloodyChampionYouVapidCunt, null, "Enter portal", "Bring it on!");
	addButton(4, "Abort", abortIAmNotBloodyChampion, null, "Abort", "You are not ready now.");
}

public function abortIAmNotBloodyChampion():void {
	updatePCStats();
	author("Etis");
	showName("\nVR POD");
	clearOutput();
	
	output("System shutdown...\n\n");
	output("Pod lid is opened, and you are free to get out.");
	output("\n\n");
	
	if (pc.hasKeyItem("Key of the Twillight") && flags["COC_VR_OUTRO_SEEN"] == undefined && flags["COC_INTRO_SEEN"] != undefined /*&& chars["PC"] == chars["PC_COC"]*/) { // have no idea how comparation works in AS3
		flags["COC_VR_OUTRO_SEEN"] = 1;
		output("Wait, what... Your body is by one hundred percent like one you had upon exiting simulation! And... Why you are not surprised? Contents of an item box are exactly like your possessions from simulation, too.\n\n");
		output("Who knew that remark about \"not limited feedback\" should be taken so literally?\n\n");
		output("And... Was it REALLY just simulation?\n\n");
	}
	
	if (!pc.hasKeyItem("Key of the Twillight")) {
		switchToTiTSSteele();
	}
	
	processTime(5);
	
	clearMenu();
	addButton(0, "Next", move, "SHIP INTERIOR");
}

public function EnterVRIAmYourBloodyChampionYouVapidCunt():void {
	author("Etis");
	clearOutput();
	clearMenu();
	
	if (pc.hasKeyItem("Key of the Twillight")) {
		if (flags["COC_INTRO_SEEN"] == undefined) {
			cocMainIntroScene0();
		} else {
			move("COC_CAMP");
		}
		return;
	}
	
	if (chars["PC_COC"] != undefined || pc.characterClass == GLOBAL.CLASS_ADVENTURER) move("COC_CAMP");
	switchToCoCChampion();
}

public function switchToCoCChampion():void
{
	if (pc.characterClass == GLOBAL.CLASS_ADVENTURER) return;
	
	if (chars["PC_COC"] == undefined) createYourChampion();
	else {
		chars["PC_TITS"] = chars["PC"];
		chars["PC"] = chars["PC_COC"];
	}
}

public function switchToTiTSSteele():void
{
	if (chars["PC_TITS"] == undefined || pc.characterClass != GLOBAL.CLASS_ADVENTURER) return;
	
	chars["PC_COC"] = chars["PC"];
	chars["PC"] = chars["PC_TITS"];
}

//////////////////////////////////////////
////    {location=STELLAR FURNACE}    ////
//////////////////////////////////////////

public function showNemo():void {
	showName("\nNEMO");
	showBust("NEMO");
}

// note: he totally can talk normally, he just having some fun
public function guildEmbassyBonusFunction():Boolean {
	author("Etis");
	showName("STELLAR\nFURNACE");
	showBust("NEMO");
	
	if (flags["COC.NEMO_INTRODUCED"] == undefined)
	{
		flags["COC.NEMO_INTRODUCED"] = 1;
		output("Lead by curiosity, you enter Stellar Furnace. It doesn't look like a proper shop inside as well as outside, being pretty messy, with strange devices scattered around. It's owner, white-furred kitsune-morph, seems to be oblivious to your presence, but greets you when you come closer. <i>“So, this is [pc.fullName]? Interesting... This one has no name for now, so you can call me ‘nemo.’ Or don't. It's not like there is someone else here, so what is the point of using names? By how confused you are, I can say you have no idea where you are. Let me enlighten you: this is an Embassy of the Guild. Stellar Furnace, the largest OEM manufacturer in the U.G.C. space. Usually, we act as a contract manufacturer, hidden under the shadows of many well-known brands. But we have some own brand lines as well. If you need a power core to feed a capital ship or a capital city - it's our specialty! Not that this is exactly much known, most people only know that power origins from the power sockets. We also have a small sideline of transformatives, which are mostly my own pet project. And, sometimes, weapons of mass destruction. Not exactly high sales last millennia, U.G.C. is not happy when we sell such things freely, and we don't want to be government lapdogs, so we using them to rig out our own ships.”</i>");
		if (!CodexManager.entryViewed("Stellar Furnace"))
		{
			output("\n\n<i>“But why did you call this place an Embassy?”</i> you ask.");
			output("\n\nHe grins widely, strange sight on his vulpine muzzle. <i>“So, Steele's heir has no idea about political situation with one of [pc.hisHer] biggest contractors? Nice. Long story short: we are independent. It can happen when you have an army.”</i>");
		}
		processTime(3);
		clearMenu();
		addButton(0, "Next", approachNemo);
	}
	else
	{
		output("Once again you visit the familiar mix of a shop, exhibition, museum, and junkyard. Nemo greets you with a flick of a tail.");
		clearMenu();
		addButton(0, "Next", approachNemo);
	}
	return true;
}

public function approachNemo():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("Nemo smiles subtly. <i>“So, I don't think you want to place an order for a capital ship, right?</i>”");
	
	processTime(1);
	clearMenu();
	addDisabledButton(0, "Order", "Order", "You have no use for his wares for now.");
	addButton(1, "Collection", nemoCollection, undefined, "Collection", "Look at his collection of things which are not exactly for sale.");
	addButton(2, "Talk", nemoTalk, undefined, "Talk", "Ask him about things.");
	addButton(10, "Appearance", nemoAppearance, undefined, "Appearance", "Examine him.");
	
	addButton(14, "Leave", move, rooms[currentLocation].northExit);
}

public function nemoAppearance():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("Nemo is an arctic kitsune, and very animalistic one - exquisitely fluffy, snowy white fur, lean vulpine muzzle, perky ears, and a wriggling bunch of fluffy tails behind. His eyes are celestial blue and slitted vertically, and glowing azure lines mark his body with mystical patterns. His body is lean and short, well below 5\".");
	
	output("\n\nHe wears only a toolbelt and a cloth collar, but you barely can accuse him in a public indecency, considering how well his fur coat covers him. He apparently doesn't mind his exposure at all, neither covering nor showing himself.");
	
	output("\n\nYou can't exactly descry his genitals, but you are pretty sure that he has an animalistic sheath.");
	
	clearMenu();
	addButton(0, "Next", approachNemo);
}

// one can understand why he have no hopes to get license within 100 years after one look on his wares... not that he actually want it, he just mocking authorities
public function nemoCollection():void {
	clearOutput();
	clearMenu();
	author("Etis");
	showNemo();
	
	output("Nemo shrugs and waves his tail. <i>“Feel free to look, but most of the things that worth buying are not for sale.</i>”");
	
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
	tmp.tooltip = "Heavy kinetic cannon, using plain tungsten slugs as ammo. Beware of projectile ablation in the atmosphere, recommended to limit initial velocity to 5 km/s.";
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
	tmp.tooltip = "This huge and immensely massive contraption is really a weapon of mass destruction. Grenade launcher pushed to concept's limit; it throws tiny portions of an anti-matter contained inside of a hardlight trap as projectiles. There is only one word for its power: devastating.";
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
	tmp.tooltip = "This thing is a bit misplaced in this collection since it is not intended to be handheld. It is specialized equipment for boarding party shuttle, designed to suppress even fortress shields.";
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
	tmp.tooltip = "This little thing is far from impressive - little more than a foot long, with a short wooden butt and a short, heavily reinforced barrel. Quite weighty, though - nearly 14 pounds. Ultimate handheld weapon, the automatic fission laser have a logarithmic slider to control it's output power, from 'cut neat little hole' at 1 to 'evaporate this city, and that mountain too' at 10.";
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
	tmp.tooltip = "This tool is nothing more than a simple rangefinder. The real ‘gun’, orbital cannon, would be somewhere above.";
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
	tmp.tooltip = "The Heart of Power, implantable anti-matter power battery for undefeated fighter. Contains enough energy to power any weapons and gadgets you are using as long as you are able to fight. Contains enough energy to wipe a city during mandatory self-destruction protocol on a loss. Either way, you always have a guaranteed draw.";
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
	tmp.tooltip = "An advanced suit designed for infiltrators and diversionists. While costumes constructed from a gray goo are not a new concept, this particular model is honed to perfection. It can take a form of any outfit suitable for the situation. Even if quite thin, the layer of nanobots is more then able to create a hard exoskeleton with all benefits conventional power armor could provide, including thermal management and life support. Highly advanced mimicry software can imitate any species of appropriate body configuration or act as chameleon camouflage, allowing it's owner to blend in with the crowd or hide in a plain sight. Needless to say about functions like forming a great variety of tools, weapons, and gadgets.";
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
	tmp.tooltip = "The weapon of singular destruction. Of singular planet, to be precise. This device will burrow through a planet's surface and detonate at the core. This will destabilize a planet, and will shatter that world in many cases.";
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
		tmp.tooltip = "Archaic and seemingly overcomplicated virtual reality pod with long-term life support system. Surely stands out from other merchandise. Maybe you should ask about it?";
		TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
		TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
		addOverrideItemButton(btn++, tmp, tmp.shortName, nemoTalkVRPod);
	}
	
	addButton(14, "Back", approachNemo);
}

public function nemoTalk(arg:Function = undefined):void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("Nemo arches his brow. <i>“Some personal questions, I guess? Ask, but I can't promise to answer.</i>”");
	
	clearMenu();
	var btn:int = 0;
	
	if (flags["COC.NEMO_STOCK_SEEN"] != 1) addDisabledButton(btn++, "VR Pod", "VR Pod", "You should look at his collection before asking about it.");
	else if (flags["COC.NEMO_VR_POD_TAKEN"] != undefined) addDisabledButton(btn++, "VR Pod", "VR Pod", "You've already got it.");
	else addButton(btn++, "VR Pod", nemoTalkVRPod);
	
	addButton(14, "Back", approachNemo);
}

public function nemoTalkVRPod():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("<i>“Is this a derelict VR pod?</i>” you ask.");
	output("\n\nNemo nods. <i>“Yep. Bought it on a strange occasion, and trying to fix it. Actually, it works, but it looks like safety protocols are not responding, and I have no idea what would happen if anyone tries to use it. I have no idea how it would work with my mods as well, so it has no use for me. If you wish, you can take it. No fee, no warranty.”</i>");
	
	processTime(1);
	clearMenu();
	addButton(0, "Take", nemoTakeVRPod);
	addButton(1, "Decline", nemoTalk, nemoTalkVRPod);
}

public function nemoTakeVRPod():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("<i>“An ancient artifact of unknown origin and unknown quirks? Wrap it up!</i>”");
	output("\n\nNemo grins. <i>“Feeling adventurous? Good luck with it.”</i>");
	
	output("\n\n<b>You have a VR POD installed in your ship! You can access it from the storage menu.</b>");
	
	flags["COC.NEMO_VR_POD_TAKEN"] = 1;
	flags["COC.VR_POD_INSTALLED"] = 1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", nemoTalk);
}

public function abortVRAfterVictory():void {
	author("Etis");
	clearOutput();
	
	output("Wait, what? Portal? World? You are [pc.fullName], not some Champion! With all possible speed you rush to your camp. Usually travels here are astoundingly quick, but this time it feels like eternity sor some reason. To your relief, portal is still faintly glowing...");
	
	processTime(3 * 24 * 60 + rand(24 * 60));
	switchToTiTSSteele();
	clearMenu();
	addButton(0, "Next", abortVRAfterVictoryII);
}

public function abortVRAfterVictoryII():void {
	updatePCStats();
	author("Etis");
	showName("\nVR POD");
	clearOutput();
	
	output("SYSTEM FAILURE, PLEASE LEAVE IMMEDIATELY.");
	output("\n\nPod lid is opened, and you are free to get out.");
	
	processTime(5);
	clearMenu();
	addButton(0, "Next", abortVRAfterVictoryIII);
}

public function abortVRAfterVictoryIII():void {
	author("Etis");
	showNemo();
	shipLocation = "TAVROS HANGAR";
	currentLocation = "GUILD EMBASSY"; // not using move to prevent events
	generateMap();
	showLocationName();
	clearOutput();
	
	output("<i>\"Look who has honored us with a visit!\"</i>. Familiar place, familiar voice. And you are pretty sure that your entry point was in another place. <i>\"Don't look at me that way. Yes, I know, you think that I owe you few answers. Problem is... I don't think so. I've already done too much for you.\"</i>");
	
	output("\n\nLooks like he is not really in a mood for a talk. But this could be your chance to actually inquire something. Or you could ask for something...");
	
	processTime(2);
	clearMenu();
	addButton(0, "Fix VR", abortVRAfterVictoryFixIt, undefined, "Fix VR", "It is just a piece of tech, and broken machines are meant to be fixed.");
	addButton(1, "Recompense", abortVRAfterVictoryRecompense, undefined, "Recompense", "You feel that it would never be the same. Time to move on.");
	// maybe add option to change pod into controllable body transformation system? it can do this, just change firmware...
}

public function abortVRAfterVictoryFixIt():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("You make your choice and ask him to fix the pod.");
	
	//output("\n\n<i>\"So, no way back?\"</i> you ask in confusion. <i>\"Not in this reality branch. And I'm not going to fiddle with such matters without some really good reason.\"</i>");
	output("\n\n<i>\"Fix. This. Fix. You... Fine. If you are asking for it you either know what you are asking for and ready for it or have no idea and that is only your problem, not mine. Fine. I'll do my best. Just go. You'll find your ship in hangar, as usual.\"</i>");
	
	output("\n\nLooks like you are dismissed...");
	
	output("\n\n<b>You still have VR POD installed in your ship.</b>");
	
	processTime(2);
	clearMenu();
	addButton(0, "Leave", move, rooms[currentLocation].northExit);
}

public function abortVRAfterVictoryRecompense():void {
	clearOutput();
	author("Etis");
	showNemo();
	
	//output("<i>\"Now, I'm taking this thing back. You really don't want to use it anymore. Unless you want to be torn apart by glitched reality, of course. No? Thought so. Bifurcation point is left behind.\"</i> Well, if he is taking your favorite toy, he can give you something instead of it, right?");
	output("<i>\"Now, I'm taking this thing back. You really don't want to use it anymore. Unless you want to be torn apart by glitched reality, of course. No? Thought so.\"</i> Well, if he is taking your favorite toy, he can give you something instead of it, right?");
	
	output("\n\n<i>\"Not asking to get it back? Good. There are things to leave behind. Can offer a trinket from my private collection as souvenir. Not from the showcase, you'll have more problems with those anyways. And not all of them are actually working, to be honest. And about collection... I'll offer you a real treasure. One of the old implants produced by Mechanist's Guild.\"</i>");
	
	output("\n\n<i>\"Stop there! Mechanist's Guild?\"</i> You snap vaguely familiar word. <i>\"You said that this is Guild embassy, and now this. Aren't it just an old, old myth?\"</i>");
	
	output("\n\nHe sighs and scowls. <i>\"Not myth. Legend. Old, old legend, from the times when Terra was the only known inhabited pebble in a sky. Legend about technological singularity...\"</i> for a moment his piercing gaze faded. <i>\"I've been alone for too long,\"</i> he mutters. <i>\"Let me drop this. Old and sad stories from long forgotten past are not relevant to current situation.\"</i> He braced himself, putting on presumptuous trickster's fasade back. <i>\"I can offer you one. It would help you improve one of your abilities. Not really top tier stuff, to be honest, but still quite good. Better than anything on the legal market, that's for sure, and totally without side effects, no less! I'll attune your nanosurgeons to work with it seamlessly. Now, your choise...\"</i>");
	
	processTime(5);
	clearMenu();
	addButton(0, "Intelligence", applyGuildImplant, "intelligence", "Intelligence", "Grants an extra potential for Intelligence training.");
	addButton(1, "Physique", applyGuildImplant, "physique", "Physique", "Grants an extra potential for Physique training.");
	addButton(2, "Reflexes", applyGuildImplant, "reflexes", "Reflexes", "Grants an extra potential for Reflexes training.");
	addButton(3, "Aim", applyGuildImplant, "aim", "Aim", "Grants an extra potential for Aim training.");
	addButton(4, "Willpower", applyGuildImplant, "willpower", "Willpower", "Grants an extra potential for Willpower training.");
	//addButton(5, "Lust", applyGuildImplant, "lust", "Lust", "Grants a bit of extra control over your sexual urges.");
}

public function applyGuildImplant(arg:String):void {
	clearOutput();
	author("Etis");
	showNemo();
	
	output("<i>\"This one? Your choise. Now...\"</i> Suddenly he appears right before your [pc.face], and you feel his paw-like palm on your forehead, soft and surprisingly hot. Your vision hazes for a moment, then everything snaps back, and you see him is on his usual place again. That's all? You are not feeling any different, right? Seems like your Codex knows you better than youself - it already reports about <b>potential for improvement in your " + arg + "</b>.");
	
	flags["COC.NEMO_COMPENSATION"] = arg;
	
	// flat bonus of 5 and 1,25 per character level to chosen stat cap
	if (arg == "physique" && !pc.hasPerk("Implant: Iron Body"))					pc.createPerk("Implant: Iron Body",				5, 0.25, 0, 0, "Increases your physique.");
	if (arg == "reflexes" && !pc.hasPerk("Implant: Wired Reflexes"))			pc.createPerk("Implant: Wired Reflexes",		5, 0.25, 0, 0, "Increases your reflexes.");
	if (arg == "aim" && !pc.hasPerk("Implant: Optical Analyzer"))				pc.createPerk("Implant: Optical Analyzer",		5, 0.25, 0, 0, "Increases your aim.");
	if (arg == "intelligence" && !pc.hasPerk("Implant: Cognitive Coprocessor"))	pc.createPerk("Implant: Cognitive Coprocessor",	5, 0.25, 0, 0, "Increases your intellegence.");
	if (arg == "willpower" && !pc.hasPerk("Implant: Mental Shield"))			pc.createPerk("Implant: Mental Shield",			5, 0.25, 0, 0, "Increases your willpower.");
	// flat 35 to min and max lust
	if (arg == "lust" && !pc.hasPerk("Implant: Hormonal Controller"))			pc.createPerk("Implant: Hormonal Controller",	35,  35, 0, 0, "Grants a bit of extra control over your sexual urges.");
	
	output("\n\nFeeling suddenly empty inside, you turn to exit and leave without saying goodbye. It somehow feels right that way.");
	
	flags["COC.NEMO_VR_POD_TAKEN"] = -1;
	
	output("\n\n<b>You no longer have VR POD installed in your ship.</b>");
	
	processTime(60 + rand(60));
	updatePCStats();
	clearMenu();
	addButton(0, "Leave", move, rooms[currentLocation].northExit);
}