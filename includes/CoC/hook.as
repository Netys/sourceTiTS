import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.GameData.TooltipManager;
import classes.GLOBAL;
import classes.ItemSlotClass;
import classes.StringUtil;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "../CoC/CoCGame.as"; // all other includes are there

// This is deprecated function.
public function cockyVrJunctionMenu():void {	
	author("Etis");
	setLocation("SHIP\nINTERIOR", rooms[rooms["SHIP INTERIOR"].outExit].planet, rooms[rooms["SHIP INTERIOR"].outExit].system);
	
	//addButton(5, "Enter pod", enterCocVrPod);
	addButton(0, "Next", move, "SHIP INTERIOR");
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
	updatePCStats();
	author("Etis");
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

/*
 * Maybe I would comission someone to give this character some action. Someday. Too lazy to communicate with writers/artists. Now he'll just have cameo here.
 * 
 * ID (local): nemo (not a name, just latin "nobody" taked as his current identifier, so he writes it in lower case).
 * Race: self-proclaimed kitsune.
 * Gender: undefined. Uses male pronouns usually, but would not protest should you decide to use female (though snide remark is almost guranteed).
 * 
 * Appearance: anthro (stands upright, has human-like padded arms, but otherwise animalistic) fox with nine tails. Fur is thick and soft, but not as long as his arctic appearance could suggest.
 *   Usually around 145 cm (4' 9") tall, weight around 30 kg, very slender (though fur blurs the outline), appears genderless and androgynous, but with preponderance to femine side due to delicate frame.
 *   Usually only visible (and only when outstretched) body anomaly is his draconic tongue. But can use draconic wings when needed. When uses wings on regular basis completes ensemble with pair of draconic horns for consistence.
 *   Basically two colors: snow white and azure.
 *   White skin and fur with luminous azure markings. Markings shifts, usually when no one is looking.
 *   Human-like eyes with luminous azure irises. Azure pawpads, nose, inside ears and mucous membranes.
 *   No hair, only a bit longer fur on head.
 *   Doesn't care about clothes usually, since all things people usually hide are already hidden well. Otherwise wears something teenage punk would find fitting. Usually retracts all but two tails and tones down bioluminescence when in public places, just for convinience.
 * 
 * True race: gray goo with transferred organic's personality (for transhumanism's sake!), but his imitation of organic body is nearly perfect - his body is far more advanced than ones on Nova.
 * 
 * Declared 'magic' abilities:
 *   Pyrokinesis, illusions, shapeshifting - usual kitsune's arsenal. Imitates them using high tech and psionic. Well, any sufficiently advanced technology is indistinguishable from magic... Not shunning of demonstration of technical savvy as well.
 *   Usually only shifts to fully feral fox (at least without hiding his identity as nemo). Usual feral form: height 90 cm (3') to the withers, usual male fox genitals, optional nine tails, same white/azure palette or normal fox-like if wants to remain incognito.
 *   Has quite literal hammerspace within his body to hide shapeshifter's luggage. Can change body size in very wide range (mass is not tied directly to volume, since he can play with density of his body).
 *   Has nearly infinite capacity (though can arrange "all way through" or cumflation scene as well).
 * 
 * Genitals: usually none, pretends to have genital slit and internal balls, like ones Catnip can grant, but actually just retracts them into his mass.
 *   Usual tool: 6" knotted vulpine penis on crotch. And 9 more on tails (considering how endowed he is with them, especially since he doesn't mind to openly shift his "magic" tails, he is more than enough male for anyone).
 *   Formally no female organs, but his tailhole is just fine. No capacity limits, no need for lubrication, no... foreign substances, what else would you want?
 *   Can imitate sexual fluids (glowing azure goo or usual cum, depending on form), but generally prefers to change the coefficient of friction rather than lubrication.
 *   As syntethic, he has no actual erogenous zones (as well as no painful), but as psionic he can "borrow" his parthner's feelings, so he doesn't really care how.
 * 
 * Sexual preferences:
 *   Since he is basically sexual doppelganger, he would not really get along with partners having sub/dom propensities. Likes letting snide remarks about Freudian sources of dommy behavior and encouraging hopeless subs to man up and take charge. Likes a lot how scene of true, undiluted, child-like enthusiasm and enjoyment in process of intended-to-be-acts-of-submission can inflict the feeling of being used in an especially perverted way into doms.
 *   Also, he DO have some dignity. Person without dignity is not aesthetically pleasing, after all. Not that he really care about what others would think... But, anyways, would play pet only in feral form.
 * 
 * Preferences:
 * Likes:
 *   Act childish (though usually he cares well to dose it into "adorable" rather than "annoying" portions). Because growing up is a first step do death. Since his main form can be easily be mistaken for adolescent, it suits him.
 *   Mischievous personalities. Nice are fine too.
 *   Persons with high intellegence, especially combined with high willpower.
 *   More than meets the eye. High physique within femboy, high reflexes within heavyset, high intellegence within bimbo etc.
 *   Mechanistic approach to own body. Roots of true beauty are in pure functionality!
 *   Slender and sleek frames, like his own (he uses one because he consider them beautiful... sort of machine logic here).
 *   Furries and splicers of predatory species. Likes tauric forms, but considers them irrationally cumbersome to use in cities or other closed environments.
 *   Art. Music, books, films, video games with good plot, etc. Mental mastutbation, of course, but still a decent way to dispel the boredom.
 *   Being absentmindedly petted. Feeling of relaxed affection from this is inducing closest things to slumber he can achieve in his current state. Though he don't like to admit it, especially because it is only thing which actually can make him worry: he is invulnerable for anyone but himself. Not that it is real danger - mortals can solve such problems by themselves pretty quickly. So it would be no harm, right? Of course right, background emotionless "watchdog" personality thread would interrupt anything REALLY dangerous...
 * Dislikes:
 *   Asshole personalities. There are thin, but abyssaly deep line between mischievous and cruel.
 *   Hypocrisy, as most psionics. Though sancta simplicitas is even worse.
 *   Bimbos and bros. Says that if he is fucking with mindless animal, it shoud also look like one, or he suffers from cognitive dissonance.
 *   Very feminine or very masculine traits.
 *   Furries and splicers of livestock species.
 * 
 * Background: part of the 'guild', small semi-hivemind community. They share intellegence, but not personalities. Despite small amount of sentients within group, it is quite a power.
 * Their brand ability is multithreaded thinking within one personality and shared memory, which effectively makes any one of them one-person-legion.
 * Though their situation has major flaw. They were designed to provide individ with all power collective mind can offer while keeping personality intact, but it can not give reason to use that power.
 * Being basically immortal (multiverse can offer literally endless amount of places to hide replication servers), they has no actual goal to achieve.
 * So most of them intentionally limits their abilities to challenge themselves. Not that they really suffer - they have all time in the world to find a reason for living.
 * Still, they are usually quite bored and promise of some entertainment can motivate them.
 */

public function showNemo():void {
	author("Etis");
	showName("\n{ nemo }");
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
		clearMenu();
		addButton(0, "{ next }", approachNemo);
		return true;
	}
	else
	{
		output("{ protocol: verbose deprecated; stream/representation enabled }\n\n");
		output("{ location: name 'Stellar Furnace'; function embassy }\n\n");
		output("{ interactions: nemo; exit }\n\n");
		addButton(0, "{ nemo }", approachNemo);
	}
	return false;
}

public function approachNemo():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ input from nemo: welcome; request input }\n\n");
	
	processTime(1); // this is only place to process time intentionally
	
	addDisabledButton(0, "{ buy }", "{ buy }", "{ shop closed }");
	
	addButton(1, "{ museum }", nemoCollection, undefined, "{ museum }", "{ request: collection examine }");
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
	tmp.tooltip = "Just a handle while disabled, it appears to be some sort of energy blade. It can cut through anything within range. Yes, that simple.";
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
	tmp.tooltip = "Heavy kinetic cannon, using LightDrive technology to accelerate tungsten slugs.";
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
	tmp.tooltip = "This huge and immensely massive contraption is actually a weapon of mass destruction. It uses laser to ionize air, then throws tiny portion af anti-matter in a magnetic trap through created channel. There are only one word for it's power: devastating.";
	TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
	TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
	tmp.baseDamage.burning.damageValue = 1000;
	tmp.baseDamage.kinetic.damageValue = 1000;
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
	tmp.longName = "Power Punch";
	tmp.description = "a power punch";
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
	tmp.tooltip = "This little thing is far from impressive - little more than a foot long, with a short wooden butt and a short, heavily reinforced barrel. Quite weighty, though - nearly 14 pounds. Ultimate handheld weapon, the automatic fission laser have logarithmic scale of output power, from 'cut neat little hole' at 1 to 'evaporate this city, and that mountain too' at 10.";
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
	
	if (flags["COC.NEMO_VR_POD_TAKEN"] == undefined)
	{
		tmp = new ItemSlotClass();
		tmp.stackSize = 1;
		tmp.type = GLOBAL.GADGET;
		tmp.shortName = "VR Pod";
		tmp.longName = "virtual reality pod";
		tmp.description = "a virtual reality pod";
		tmp.tooltip = "Archaic and seemingly overcomplicated virtual reality pod. Definitely stands out from other merchandise.";
		TooltipManager.addFullName(tmp.shortName, StringUtil.toTitleCase(tmp.longName));
		TooltipManager.addTooltip(tmp.shortName, tmp.tooltip);
		addOverrideItemButton(btn++, tmp, tmp.shortName);
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
	output("{ output to nemo: stock 'weapons of mass dectruction'; legality }\n\n");
	output("{ input from nemo: illegal }\n\n");
	output("{ output to nemo: illegal; license }\n\n");
	output("{ input from nemo: hopeless }\n\n");
	output("{ output to nemo: license; declined }\n\n");
	output("{ input from nemo: stock 'weapons of mass dectruction'; action 'mischievous smile' }\n\n");
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
	output("{ input from nemo: not stock; unknown origin; possibly alive; confusion; offer; barter; payment 'usage telemetry' }\n\n");
	
	addButton(0, "{ accept }", nemoTakeVRPod);
	addButton(1, "{ decline }", nemoTalk);
}

public function nemoTakeVRPod():void {
	clearOutput();
	clearMenu();
	showNemo();
	output("{ output to nemo: 'vr pod'; trade; accept }\n\n");
	output("{ input from nemo: sold; delivered; installed; enjoy }\n\n");
	
	flags["COC.NEMO_VR_POD_TAKEN"] = 1;
	flags["COC.VR_POD_INSTALLED"] = 1;
	addButton(0, "{ next }", nemoTalk);
}