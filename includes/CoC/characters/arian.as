import classes.Characters.CoC.CoCArian;
import classes.GLOBAL;
import classes.Items.Miscellaneous.*;
import classes.Items.Transformatives.*;
import classes.Items.Transformatives.CoCEggs.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// ARIAN_FOLLOWER:int = 933;
// ARIAN_PARK:int = 934; //-1 = disabled, 1 = helped.
// ARIAN_HEALTH:int = 935; //Higher is better.
// ARIAN_ANAL_XP:int = 936;

// ARIAN_CAPACITY:int = 937;
// ARIAN_COCK_SIZE:int = 938;
// ARIAN_DOUBLE_COCK:int = 939;
// ARIAN_VAGINA:int = 940;
// ARIAN_BREASTS:int = 941;
// ARIAN_TIMES_SEXED:int = 942;

// ARIAN_S_DIALOGUE:int = 943;
// ARIAN_HERM_CHAT:int = 944;
// ARIAN_ASS_CHAT:int = 945;
// ARIAN_LESSONS:int = 946;
// ARIAN_DOUBLE_PENETRATION_CHAT:int = 947;
// ARIAN_FIRST_REPTILUM:int = 948;
// ARIAN_TREATMENT:int = 949;
// ARIAN_EGG_CHAT:int = 952;
// ARIAN_EGG_EVENT:int = 953;
// ARIAN_EGG_COLOR:int = 954;
// ARIAN_EGG_COUNTER:int = 955;

// ARIAN_HAS_BLOWN:int = 950;
// ARIAN_MORNING:int = 951;
// TIMES_ARIAN_DILDOED:int = 983;

/*Design Notes
Arian has a \"<i>health</i>\" stat that goes from 0 to 100. Where 0 equals very sick and 100 equals healthy. This also works as a sort of affection meter.
Interacting with the PC will improve Arian's health; be it talking, giving items or sex.

Talking improves Arian's health by 1. Sex improves it by 2 and giving him Vitality T. improves it by 4.

At 100 health Arian insists on joining the PC's camp as a follower, you can deny him that and invite him later when you feel like it.

Talking to Arian can improve the PC's intelligence (Up to 100) and teaches white spells at 35, 50 and 75 intelligence. Arian must also be at health level 30 or greater in order to teach spells.

Boon and Laika cannot be interacted with directly, at least for now.

AnalXP increases with buttsecks and reduces with reducto. Necessary to measure how much Arian loves it up the ass.

Flags and variables:
ArianHealth: Arian's current \"<i>health</i>\", the bigger the better!
ArianAnalXP: How experient Arian is with anal sex (on the receiving end only!). Depending on how experient he is, you might get scene variations. (Anal Capacity is always 50!)
ArianVirgin: If you had sex with Arian at any point and talked about it. 0 = virgin, 1 = not a virgin.
ArianCockSize: What is Arian's current cock(s) size. He only has 4 sizes, starting at 1 and up to 3. 0 = no cock(s), 1 = 6</i>\" long, 1.5</i>\" thick cock(s), 2 = 8</i>\" long, 2</i>\" thick cock(s), 3 = 12</i>\" long, 3</i>\" thick cock(s).
ArianGirlHermChat: If you had Boon and Laika speak to you after modifying Arian's gender. 0 = didn't modify Arian's gender, 1 = Modified Arian's Gender, 2 = already spoke with Boon and Laika.
ArianDblCock: Flag to verify if Arian has 2 cocks or not. 0 = 1 cock, 1 = 2 cocks. Second cock is always the same size as the first one.
ArianVagina: Flag to verify if Arian has a vagina, starts at 0. 0 = no vag, 1 = has a vag. (Capacity of 50!)
ArianBreasts: Arian's breast size, 4 sizes. 0 = flat, 1 = B-cup, 2 = D-cup, 3 = DD-cup. (Nipples match breast size.)
ArianSDialogue: Controls which Special Dialogues PC has already gone through, they're supposed to only happen once. Numerical value starting at 0, up to 6 (disabled).
ArianFollower: If Arian is a follower or not. 0 = not a follower, 1 = is a follower.
ArianMLesson: How many times Arian has taught the PC that day. Resets every day. 0 up to 4.
ArianHasBlown: Boolean to see if player has gone through Get Blown once already. 0 = false, 1 = true.
ArianAssChat: Boolean to see if player has already fucked arian at >66 AnalXP.  0 = false, 1 = true.
ArianTreatment: Checks if PC has already treated corruption with Arian that day, resets everyday. 0 = false, 1 = true.
ArianFirstRept: If PC gave Arian some Reptilum already. 0 = false, 1 = true.
ArianDblPenChat: If PC had the chat after Double Pen already. 0 = false, 1 = true.
ArianEggEvent: Flag to verify the state of the Egg Event. Set it to 1 every 30 days. 0 = inactive, 1 = active, can pick color now. 2-7 = Color has been picked, number indicates which color. 8 = Fertilized Eggs, for reference in case of an expansion.
ArianEggChat: If PC has already talked to Arian about her egglaying. 0 = false, 1 = true.
ArianPark: Originally set to 0, it will be set to 1 if the PC chooses to help him in the first meeting. otherwise set to -1 and disable him.  Increases each subsequent visit in order to determine when their relationship should evolve.  Max = 3.

Note: Will need something to verify which pronoun to use, he or she. You'll probably want to use a function for that Fen.

Health Thresholds:
0 health: You may only Talk.
10 health: You may start giving him Vitality Tincture.
20 health: You may give him TF items & sex him if you want.
30 health: Arian will start teaching the PC spells, will start preparing something special for the PC.
50 health: Arian completes the Talisman and gives it to PC, unlocks Imbue Talisman option.
75 health: Arian is healthy enough to start giving the PC magical therapy to reduce Corruption. (Limit of one per day.)
100 health: Arian joins as a follower. Can imbue the talisman with more spells.

AnalXP Thresholds:
0: Anal Virgin. Same as <33, except there is a virgin blurb.
< 33: Tight, sensitive enough to orgasm. (It hurts... but feels good)
< 66: Loose, sensitive enough to make Arian scream in pleasure. (It's like a tight vagina, feels like one too, minor pain)
<= 100: Very Loose, sensitive enough to make Arian cum just from insertion. (Feels better than anything else. Yep, Arian really becomes a buttslut at this point)
Planned expansions:
Naga TF
Corruption Path (Arian's body is drastically altered, but [arian.eir] personality only suffers minor alterations.)
(Unlikely) Boon and Laika
*/
	//public class ArianScene extends NPCAwareContent implements TimeAwareInterface
	//{
		//public function ArianScene()
		//{
			//CoC.timeAwareClassAdd(this);
		//}
//
		////Implementation of TimeAwareInterface
		//public function timeChange():Boolean
		//{
			//if (flags[kFLAGS.ARIAN_EGG_COUNTER] > 0) flags[kFLAGS.ARIAN_EGG_COUNTER]++;
			//if (model.time.hours > 23) {
				//if (arianScene.arianFollower() && arian.hasVagina()) flags[kFLAGS.ARIAN_EGG_EVENT]++;
				//flags[kFLAGS.ARIAN_LESSONS] = 0;
				//flags[kFLAGS.ARIAN_TREATMENT] = 0;
			//}
			//return false;
		//}
	//
		//public function timeChangeLarge():Boolean {
			//return false;
		//}
		////End of Interface Implementation

public function followerCampMenuBlurbArian(showInteractButton:Boolean):void {
	if (!arianFollower()) return;
	
	outputText("Arian's tent is here, if you'd like to go inside.\n\n");
	
	if (showInteractButton) addButton(followerBtnNum++, "Arian", function():* { processTime(3); visitAriansHouse() } );
}

private var ArianSceneHook: * = ArianSceneGrapple();
private function ArianSceneGrapple():* { 
	loverCampMenuBlurb.push(followerCampMenuBlurbArian);
}

public function get arian():CoCArian
{
	return chars["COC.ARIAN"];
}

public function arianFollower():Boolean {
	return flags["COC.ARIAN_FOLLOWER"] > 0;
}

public static const ARIAN_COCK_SIZE_1:int = 6;
public static const ARIAN_COCK_SIZE_2:int = 12;
public static const ARIAN_COCK_SIZE_3:int = 18;
public static const ARIAN_BREASTS_SIZE_1:int = 1;
public static const ARIAN_BREASTS_SIZE_2:int = 3;
public static const ARIAN_BREASTS_SIZE_3:int = 5;

//Initial Meeting
//Happens randomly while visiting Tel'Adre. If player doesn't choose to help, Arian is removed from the game.
//If you don't help, Arian is removed from the game.
public function meetArian():void {
	clearOutput();
	output("As you wander Tel'Adre's streets, you pass by one of the many dark alleys that litter the half-empty city; you hear the sound of hacking, rasping coughs.  Following your ears, you see a hooded figure wrapped in a form-concealing cloak slumped against the wall, bent over and coughing loudly, wheezing for breath.  They really don't sound very well at all... on the other hand, it could be a setup for muggers or something.  Maybe you shouldn't try playing the good samaritan here...");
	//[Help] [Don't Help]
	
	clearMenu();
	addButton(0,"Help",helpArianWhenYouMeetHim);
	addButton(1,"Don't Help",dontHelpArianWhenYouMeetHim);
	addButton(2,"Never Help",dontHelpArianWhenYouMeetHim,true);
}

//[=Don't Help=]
private function dontHelpArianWhenYouMeetHim(never:Boolean = false):void {
	clearOutput();
	output("Not liking the risks it presents - after all, they could be a mugger, or have something nasty and highly contagious - you keep on walking.  You've not gone too far before a pair of figures, elegantly dressed ferret-morphs, nearly slam into you, running quickly.  You shout at them to watch where they're going, but they ignore you, instead heading straight for the alleyway you just passed.  You watch as they grab the hooded figure and pull them to their feet.  The ferrets start chattering at their target; though you can't make out precisely what they're saying, it sounds like a scolding, even as they take a bottle from a pouch they're carrying and make the hooded figure drink it.  The cloaked man's coughs start to subside, and they promptly take an arm each and half-lead, half-carry him away.  You wonder what that was all about, but decide it doesn't matter and press on.");
	//Disable the bitch if appropriate.
	if (never) {
		flags["COC.ARIAN_PARK"] = -1;
	}
	else {
		flags["COC.NOT_HELPED_ARIAN_TODAY"] = days;
	}
	//Player enters Tel'Adre main screen
	clearMenu();
	addButton(0,"Next",telAdreMenu);
}

//[=Help=]
private function helpArianWhenYouMeetHim():void {
	clearOutput();

	flags["COC.ARIAN_PARK"] = 1;
	flags["COC.ARIAN_COCK_SIZE"] = 1;
	flags["COC.ARIAN_CAPACITY"] = 50;
	
	output("You approach the hooded figure with caution, asking if they're all right; it feels a little silly to say that, but you can't think of much else to say.");
	
	output("\n\n\"<i>Just... help me up,</i>\" a masculine voice asks, between coughs.");
	
	output("\n\nYou lean down and offer the stranger your shoulder, letting them place their arm across your neck before you stand upright, helping pull them to their feet.  Once the hooded figure is standing, the hood slides off [arian.eir] head, to reveal a reptilian muzzle that could only belong to some sort of lizard.  His scales are white, almost absurdly so, and he takes deep breaths, trying to calm down his coughing fit.");
	//if (flags[kFLAGS.CODEX_ENTRY_LIZANS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_LIZANS] = 1;
		//output("\n\n<b>New codex entry unlocked: Lizans!</b>")
	//}		
	output("\n\nOnce it seems like he's calmed down, he looks at you and you gaze at his auburn slitted eyes.  \"<i>Thank you very much.</i>\"  He politely nods at you.  \"<i>Would you mind helping me one more time though?  I'm trying to avoid some people and I'd really appreciate it if you could help me go to a park nearby.</i>\"");
	
	output("\n\nYou ask him if he's in some kind of trouble first.  \"<i>No, of course not.  My aides are just a tad overprotective, that's all,</i>\" he insists, coughing a bit.");

	output("\n\nYou consider your options, then decide it can't hurt to take him, conveying your decision to the sickly lizard-man.");
	
	output("\n\nIt doesn't take long before you arrive at what looks like a small abandoned park; the grass has grown wild in some patches, while in others it is dry and withered.  The lizan points at a nearby bench and you help him sit.  With a sigh the lizan slumps back and closes his eyes with a smile.");
	
	output("\n\n\"<i>Thank you very much for helping me get here.  If I had to stay in bed even for a second longer, I swear I would have gone mad.</i>\"");
	
	output("\n\nStay in bed?  You noticed the coughing; has he caught some kind of sickness?");
	
	output("\n\n\"<i>Err, not really.  I'm just going through some health problems right now...</i>\" He trails off.  You wonder if maybe it has something to do with the whiteness of his scales - they look so abnormally pale - but leave the matter.  Instead, you ask who he is and why he was in that alley where you found him.");
	
	output("\n\nThe lizan gasps and covers his mouth, startled.  \"<i>Oh, forgive me.  How rude, I should have introduced myself before.</i>\"  He clears his throat and starts, \"<i>My name is Arian, and as you can see, I'm a lizan.  I just wanted to go out for a little while, but my aides are intent on keeping me in bed; they say I'm not well enough to be going out... but I say if anyone knows my body, that would be me!  And if I feel like going out, then so the gods help me, I will!</i>\"  He finishes forcefully, before realizing he's rambling.  \"<i>Oh, forgive me... this really isn't your problem, sorry for troubling you,</i>\" he says, letting his head hang.");

	output("\n\nYou tell him it's all right.  It sounds like he's been cooped up by his aides for a long time.  \"<i>Yes, sometimes I just feel like getting a bit of fresh air, so I just come to this park.</i>\"  He smiles to himself.  \"<i>I shouldn't keep you though.  Thank you for your help... err?</i>\"  You tell the lizan your name.  \"<i>I will be fine now, so I'll be seeing you.</i>\"  He smiles at you in a friendly way.");
	
	output("\n\nYou decide to leave him for the moment, and head back to the camp.");
	//(Park added to TA's Menu.  It will later be replaced by Arian's house.)
	output("\n\n(<b>The park has been added to Tel'Adre's menu.</b>)");

	arian.health(1);
	flags["COC.ARIAN_PARK_VISITED_TODAY"] = days;
	processTime(35 + rand(10));
	clearMenu();
	addButton(0,"Next",telAdreMenu);
}

//Further Park Visits
//You need to get through the entirety of Arian's park dialogue before you can do anything meaningful with him.
//But you can just spam it if you want, there is no schedule and Arian will magically be at the park whenever you go there.
//Use variable ArianPark to determine the number of visits.
public function arianSceneVisitThePark():void {
	clearOutput();
	//output(images.showImage("arian-park"));
	output("As you enter the ragged remnants of the park, you spot the sickly lizan, Arian, sitting at his usual bench, and greet him.  \"<i>Oh, hello there [pc.name].  Good to see you.</i>\"  He waves lazily.");
	
	//Visit 1
	if (flags["COC.ARIAN_PARK"] == 1) {
		output("\n\nFeeling ");
		if (pc.cor() < 50) output("curious");
		else output("bored");
		output(", you decide to ask him what his story is.");
		
		output("\n\nHe gives you an apologetic smile.  \"<i>I guess I should start at the beginning; it's a bit of a long story though, so why don't you take a seat?</i>\"  He motions for you to sit beside him.");
		
		output("\n\nYou do as he says.");
		
		output("\n\n\"<i>I'm actually a mage; I've been training in the magical arts ever since I was a kid.  If you're wondering about my strange white scales, I have them because I was born with something called albinism, some kind of hereditary disease... I'm not really sure, but that's beside the point.  I spent most of my youth inside, stuck at home, studying the white arts.  People always said I had a way with magic, some even called me a genius.  Some genius, huh?  I can't even walk a few blocks without help.</i>\"  He finishes with a cough, as if for emphasis.");
		
		output("\n\nYou ask if he's really a mage - you thought all the mages in Tel'Adre were kept away from the general populace, projecting the spells that keep the city safe from the demons.");
		
		output("\n\n\"<i>Oh, yes, I really am a mage.  But I don't belong to the covenant that protects this town... You see, I'm not fit for the job.  And besides that, with my magic... it would kill me....</i>\"");
		
		output("\n\nHow is that so?");
		//(PC has at least 1 Black or White Magic spell:)
		if (hasSpells()) {
			output("  You thought spellcasting merely took energy and the proper mindset, not life force, and you express that sentiment to the lizan.");
		}
		
		output("\n\n\"<i>Ah...  Now we're getting to why I'm in such a miserable state.  You see I've found a new way to use white magic; one that results in far more powerful spells;  problem is it is very unhealthy for the caster.</i>\"  [arian.ey] smiles at you weakly.  \"<i>In order to achieve a state of complete concentration, I stop all my bodily functions.  My heart stops beating, I stop breathing, I dedicate all of my being to the spell I wish to cast.  This is very dangerous, but thanks to this I am able to achieve a degree of concentration that no other mage can.</i>\"  He gauges your reaction.  \"<i>So what would you say?  Impressive?  Reckless?  Stupid?</i>\"");
		output("\n\nYou admit that's an impressive feat to pull off... but, can't he just cast magic the usual way?  Wouldn't that be better for him, if his technique is so much more draining and physically challenging than the conventional style?");
		
		output("\n\n\"<i>Yes, you are correct my friend.  And while I do use my magic in the traditional fashion now, that simply was not an option.</i>\"  He coughs.  \"<i>But that is a story for another time, I think I've held you enough for now.</i>\"  He closes his eyes and leans back.");
		
		output("\n\nYou excuse yourself and head back to camp.");
	}
	//Visit 2
	else if (flags["COC.ARIAN_PARK"] == 2) {
		output("\n\nAfter you make yourself comfortable, you suggest that he continue his story.  He looks at you in surprise at first, but he smiles shortly afterwards.  \"<i>Very well, where was I?</i>\"  He rubs his chin in thought.  \"<i>Ah, yes.</i>\"");
		
		output("\n\nHe clears his throat.  \"<i>I had to use my power to help my friends.  You see, our academy had been overrun by demons and I tried to fight them.  But... of course I was not strong enough to defeat all of them or save everyone.  All I could do was protect my pupils and myself.</i>\"  He coughs, but smiles all the same.");
		
		output("\n\nSo, he's not originally from Tel'Adre?  You suggest he should go into details, tell you about his academy.");
		
		output("\n\nArian smiles.  \"<i>Very well.  The academy was a place of study, where mages of all kinds gathered.  It was renowned for its extensive library and for being one of the best academies to learn about white magic.  It was pretty far from this city, but since the demons attacked I wouldn't expect it to still be standing.  Things got pretty ugly before my pupils and I made our escape.</i>\"");
		
		output("\n\nYou indicate you understand and he should go on.");
		
		output("\n\n\"<i>The demons caught us by surprise... they covered the academy in their corrupt black magic, and turned some of the best and most powerful mages into mindless fucktoys.  If I hadn't been to one of the warded practice rooms I would have been taken too.</i>\"  He coughs.  \"<i>There were so many of them... my pupils were in their room, and by the time I fought my way over they were on the verge of being taken by a pair of incubi.  They were affected by the initial wave of black magic, but thankfully my white magic was enough to set them free.</i>\"");
		
		output("\n\nYou show that you're still paying attention and he continues.");
		
		output("\n\n\"<i>After saving them, I quickly realized that there was no way we could fight the demons off, so we ran as far and as fast as we could.  By the time we made it far enough that I could relax I had already used too much of my magic; and as a result... well... you're looking at it.</i>\"  He coughs for emphasis.");
		
		output("\n\nYou tell him that you've heard enough for this time, so it's probably best if he saves his strength and calls it quits there.  \"<i>Very well.  I'll be seeing you then, [pc.name].</i>\"  He waves you off.");
	}
	//Visit 3
	else if (flags["COC.ARIAN_PARK"] == 3) {
		output("\n\nYou bring up the last conversation you had with Arian and ask him whatever happened to his apprentices.");
		
		output("\n\nHe smiles.  \"<i>You see... my apprentices are actually my aides now.  They swore to live their lives in my service as my aides.</i>\"  So, he's been avoiding his apprentices?");
		
		output("\n\n\"<i>They are worried about me all the time.  Maybe too worried... and it's not like I don't appreciate their concern, but sometimes I feel smothered.  Make no mistake, I love them like family, but I like to get out sometimes too.</i>\"  You give a nod in response, figuring it's what he wants to see.");
		output("\n\n\"<i>Anyway, there is not much more to my story.  We made our escape and wandered about the desert, until we found Tel'Adre.  They were nice enough to take us in and so here we are.</i>\"  He motions to the area surrounding the two of you.");
		
		output("\n\n\"<i>So, [pc.name]?</i>\"  You look at him in response.  \"<i>Can I interest you in a magical demonstration?</i>\"  You answer in the positive.");
		
		output("\n\nHe holds his hands apart from each other, palm facing palm.  \"<i>Here's what you can normally do with White Magic.</i>\"  He closes his eyes and focus.  You watch as arcs of electrical energy, like a tiny current of lightning, sparkles and crackles from one hand to the next.  You comment that's quite a sight");
		if (pc.cor() > 66) output(", whilst privately thinking to yourself how useless that looks - no wonder they can't fight the demons if this is the best they're capable of");
		output(".");
		
		output("\n\n\"<i>Now let me show you what I can do with my technique.</i>\"  He closes his eyes once more and focuses.  His white scales begin glowing as his power increases and you gasp as energy virtually explodes from hand to hand, a cascade of lightning coruscating between his hands with enough fury to consume anything that falls between them.  He stops when he racks and begins coughing.  Now, that is more impressive, you have to admit to yourself.");
		
		output("\n\n\"<i>I guess I might have overdone it.</i>\"  He smiles at you goofily, then coughs in what is obviously meant to cover his embarrassment.  \"<i>Thanks for keeping me company, I enjoy our chats a lot, [pc.name].  You've been a great friend for me.</i>\"  You accept the compliment and tell him that it was nothing");
		if (pc.cor() >= 66) output(", keeping your real reasons for bothering with him to yourself");
		output(".");
		
		output("\n\n\"<i>Could I bother you one more time though?</i>\" Arian asks shyly.  \"<i>Would you mind helping me home?  My aides are probably pestering the guard to come and find me right about now, and I feel like I got my share of fresh air for the moment.</i>\"");
		
		output("\n\nYou decide that it wouldn't be too much trouble, and tell Arian that you'll give him a hand to get home.");
		
		output("\n\nArian leads you to the doorsteps of his house, and unhooking his arm from around your shoulder he takes your hands in [arian.eir] own and smiles at you.  \"<i>Thank you for the help, and for listening to my story.</i>\"  Then looking into you eyes expectantly, he asks, \"<i>Listen [pc.name].  I would love it if you could visit me once in awhile.  It can be very lonely here and although my aides are always by my side there are things I simply can't talk about with them.  So... could you find time to visit a sickly mage?</i>\"");
		
		output("\n\nYou assure him you'll think about it; it's time he went inside and had some rest.  \"<i>Thank you, I'll be seeing you then.</i>\"  He releases your hand and slowly walks inside, barely getting the door open before two pairs of arms grab him and drag him in, closing the door behind him.  You shrug it off and head back towards camp; that diversion was nice, but you have other things to do.");
		//Player returns to (Tel'Adre / camp).
		//Arian's House replaces Park in Tel'Adre menu.
		output("\n\n(<b>The park has been removed from Tel'Adre's menu.  Arian's house has been added to the homes submenu.</b>");
		arian.health(5);
	}
	arian.health(1);
	IncrementFlag("COC.ARIAN_PARK");
	flags["COC.ARIAN_PARK_VISITED_TODAY"] = days;
	processTime(55 + rand(10));
	clearMenu();
	addButton(0,"Next",telAdreMenu);
}
	
//First Visit
public function visitAriansHouse():void {
	clearOutput();
	if (arian.health() < 29 || flags["COC.ARIAN_TIMES_SEXED"] == 1) arian.health(1);
	if (arianFollower()) {
		//if (arian.mf("m", "f") == "f")
			//output(images.showImage("arianfemale-tent"));
		//else
			//output(images.showImage("arianmale-tent"));
		output("You approach the enchanted tent and slip easily inside the doors to the luxurious interior.  ");
		var temp:int = rand(10);
		if (temp == 0) {
			output("However, Arian isn't here right now, so you instead make yourself comfortable on the couch.  After a few minutes, Arian [arian.em]self walks in through the entrance.  \"<i>Oh, [pc.name].  I wasn't aware you were here... have you been waiting for long?</i>\" [arian.ey] asks.  You tell [arian.em] not very long.  \"<i>That's good to hear.  So, what can I do for you?</i>\" [arian.ey] asks, with a smile.");
		}
		else if (temp == 1) {
			output("Inside, the lizan is sitting at a table, fastidiously drinking from a cup of something hot while pouring over an arcane-looking text.  You politely cough to draw [arian.eir] attention and [arian.ey] looks at you, smiling.  \"<i>Hello, [pc.name].  I was just catching up on my studies.  Can I offer you a cup of tea, or maybe something else?</i>\" [arian.ey] asks.");
		}
		else if (temp <= 2) {
			output("The lizan is currently busy tinkering with some occult-looking paraphernalia when you find [arian.em].  You politely cough to attract [arian.eir] attention, then do so again when [arian.ey] fails to heed that.  It's only on the third attempt that [arian.ey] looks up apologetically from [arian.eir] work.  \"<i>Ah, [pc.name]; I'm sorry, but I was preoccupied with something.</i>\" [arian.ey] states in an apologetic tone, indicating the mess on [arian.eir] desk.  \"<i>Was there something you wanted?</i>\" [arian.ey] asks.");
		}
		else if (temp <= 4) {
			output("The smell of fresh cooking fills the air and you can see Arian happily sitting down at his couch with a plate of something just cooked.  \"<i>Oh, [pc.name]; I was just about to eat, can I offer you a dish?  Or if you'd rather do something else, this can wait,</i>\" the lizan tells you with a smile.");
		}
		else if (temp <= 6) {
			output("You don't have to look far to find Arian; [arian.ey]'s currently curled up and asleep on the couch.  As you contemplate whether or not to wake [arian.em], [arian.ey] suddenly stirs and uncoils himself, stretching and yawning hugely in a way that lets you see every last needle-like tooth in [arian.eir] mouth.  [arian.ey] then sees you and gives you a smile. \"<i>Ah, [pc.name]; I was just having a little nap.  Something on your mind?</i>\"");
		}
		else if (temp <= 8) {
			output("A strange smell hits your nose as you enter the tent; it takes you a few moments, but then you place it, your ears pricking as you hear Arian letting out some very familiar groans of release.  With a smirk, you sneak up and lean over the couch, looking right into the eyes of Arian, [arian.eir] fingers still glistening with ");
			if (arian.hasCock()) {
				if (arian.hasVagina()) output("mixed sexual fluids");
				else output("jizz");
			}
			else output("femjizz");
			output(" and, indeed, still hovering over [arian.eir] ");
			if (arian.hasCock()) {
				if (arian.hasVagina()) output("twin sexual slits");
				else {
					output("cock");
					if (arian.cockTotal() > 1) output("s");
				}
			}
			else output("pussy");
			output(".  For a long moment, [arian.ey] just stares back at you; if lizans could blush, you're certain [arian.ey]'d be red as a beet.  \"<i>[pc.name]! I was- I was just....  Oh, this is embarrassing,</i>\" [arian.ey] mutters, looking at [arian.eir] feet.");
			
			output("\n\nYou flash the flustered lizan a knowing smile, telling [arian.em] not to worry; there is nothing you haven't seen before under [arian.eir] robes.  Arian shivers in a way that just speaks volumes about [arian.eir] embarrassment.  You ask if, perhaps, [arian.ey] would like you to step outside while [arian.ey] makes [arian.em]self decent?  Not that you mind the sight....");
			output("\n\n\"<i>P-please.</i>\" Arian stammers, still unable to meet your gaze.  You gently tap [arian.em] on the nose and move outside.  A short while later you hear [arian.em] yell, \"<i>C-come in!</i>\"");
			output("\n\nYou can't wipe the smirk off your face, as you return and see that Arian is, indeed, decent and there doesn't seem to be any trace of the mess [arian.ey]'s made earlier.  You walk up to the, still flustered, lizan and tell [arian.em] that if [arian.ey]'s feeling edgy, you'd be happy to help [arian.em] deal with it.");
			output("\n\n\"<i>Th-that's all right....  So, um, you wanted something, [pc.name]?</i>\" [arian.ey] asks, desperately trying to change the topic.");
		}
		arianHomeMenu();
	}
	else {
		//if (arian.mf("m", "f") == "f")
			//output(images.showImage("arianfemale-tent"));
		//else
			//output(images.showImage("arianmale-tent"));
		if (flags["COC.ARIAN_PARK"] == 4) {
			IncrementFlag("COC.ARIAN_PARK");
			output("Deciding to visit the sickly, Lizan mage, Arian, you promptly start walking.  The house is fairly large, at least two stories tall, but it looks pretty ordinary; there's nothing about it to make it really stand out from the other buildings in the neighborhood.  It's only the small brass plate on the door that says \"<i>Arian, Magus</i>\" that provides any clue that a wizard lives here.  There is a knocker on the front door, solid brass, carved in the shape of a leering grotesque, and you take hold of the handle and loudly bang it against the door to announce your presence.");
			
			output("\n\n\"<i>One minute!</i>\"  You hear a feminine voice yell from inside.  After hearing the clicking of a latch the door slowly opens to reveal what looks like a tan-furred female ferret looking at you with bespectacled brown eyes; she is not very tall, and her body is clad in loose comfortable robes that hide her curves well.  She adjusts her glasses and asks, \"<i>How may I help you, " + pc.mf("sir","ma'am") + "?</i>\"");
			
			output("\n\nYou explain you're an acquaintance of Arian the wizard, and you came to see him.  With a smile the ferret steps aside.  \"<i>Please come in.</i>\"  You promptly step inside, getting your first look at Arian's home.  The exterior and the interior match quite well; it looks very normal in here.  Aside from a few nice vases and potted flowers, nothing else stands out.");
			
			output("\n\nThe ferret girl slowly closes the door behind you, closing the latch before she dusts her robes and turns to you.  \"<i>I'm afraid we haven't been properly introduced just yet, " + pc.mf("sir","ma'am") + ".  My name is Laika and I'm one of master Arian's aides.</i>\"  She curtsies with a smile and adds, \"<i>Pleased to meet you... umm....</i>\"  You smile and tell her your name.  She closes her eyes and nods.  \"<i>Ah, yes, [pc.name]....</i>\"  Suddenly she opens her eyes wide open.  \"<i>Wait a moment... [pc.name]!?</i>\"  She advances on you, threatening you with a wooden spoon.  \"<i>You! You're the one who helped master Arian get away!</i>\"  She yells with a frown, poking your [pc.chest] with her spoon.");
			
			output("\n\nYou ask if that's really such a big deal; all he wanted was to go and sit in a park.  Laika points an accusing finger at you and is about to say something when a masculine voice interrupts her.  \"<i>Sis! What's the problem?</i>\" Slowly, another tan-furred ferret emerges from the hallway nearby, clad in robes much like his sister's.  If Laika were to remove her spectacles, they would look like identical twins.");
			
			output("\n\n\"<i>Boon, this is the....</i>\"  Boon raises his hands, stopping Laika mid-sentence.  \"<i>Yes, sister.  Half the neighborhood knows by now.</i>\"  He walks up to his sister and slowly pushes her back towards the kitchen.  \"<i>Let me handle this, sis.  Just finish doing the dishes and cool your head down, I've already finished with my chores, so I can attend to our visitor.</i>\"");
			
			output("\n\nLaika glares at both you and her brother, but complies.  Sighing, Boon turns to you.  \"<i>Hello, [pc.name].  I'm Boon, Laika's brother and master Arian's apprentice.  You'll have to forgive my sister, she's rather... passionate... when it comes to our master, but she does have a point.  What if master Arian had collapsed?  Or needed his medicine?</i>\"");

			output("\n\nBefore you can protest he stops you.  \"<i>You know what, it doesn't matter.  He would've found a way to run off whether you were there or not.  So, thanks for keeping him company.</i>\"  You accept the thanks with your usual grace, then ");
			if (pc.cor() < 33) output("curiously");
			else if (pc.cor() < 66) output("casually");
			else output("indifferently");
			output(" ask why he's thanking you.");
			
			output("\n\nBoon smiles and motions for you to follow, leading you upstairs.  \"<i>You see... master Arian didn't always enjoy taking long walks... I don't really know what made him suddenly take a liking for long walks around the city, but his condition does not allow him to do so, and he's just too stubborn to admit it.  So we kinda have to reel him in, or he will end up passing out in one of the rough parts of the city.</i>\"  Boon explains, turning on a hallway.  \"<i>Still, master looked really happy when he came back.  I'm glad he wound up meeting someone nice like you, instead of a mugger or a thief.</i>\"  Boon smiles at you.");
			
			output("\n\nHe stops at a wooden door and turns the knob.  \"<i>Of course!</i>\"  Once he does open the door, you're treated to a surprising sight.  Boon slaps his forehead with an open palm and groans.  Arian is standing on his bed, halfway out of the window, a surprised look plastered on his white face.");
			
			output("\n\n\"<i>Master Arian... I'm going to close this door and pretend I didn't just catch you trying to run away again.  I hope that when I open this door again I'll see you back in bed, or I'll sic Laika on you.</i>\"  At the mention of Laika, Arian shudders.  You just stand behind Boon, looking at the scene play out. Boon closes the door and waits a few moments before opening the door once again and motioning you in.  \"<i>Master Arian, you have a visitor.</i>\"");
			
			output("\n\nYou head inside at the ferret's gesture, wondering if Arian has stayed or not.  To your pleasant surprise, he is seated inside his bed, tucked somewhat sulkily under the covers.  You tell him that you wanted to come and visit, apologizing if you're interrupting something important.");
			
			output("\n\nArian smiles at you.  \"<i>Not at all.  Boon, you may leave us for now.</i>\"  Boon bows and leaves, closing the door behind him.  Arian sighs, removing his covers to sit up properly on the bed and motioning towards a nearby chair.  \"<i>Just make yourself at home; I'm really glad you came to see me.  I was wondering if I'd ever get to see you again.</i>\"");
			
			output("\n\nYou tell him that you couldn't resist coming to see him, even as you ");
			if (!pc.isTaur()) output("pull up a chair");
			else output("seat your tauric body on the floor");
			output(".  You rack your brains for polite conversation, and finally ask how he's been since you saw him last.");
			
			output("\n\n\"<i>Well, I had to take some extra medicine after that little stunt at the park.  But that aside, I've been well.</i>\"  Arian smiles.  \"<i>What about you, my friend?  How have you been?  Have you done anything interesting between now and our last meeting?  I don't get to go out much, so I'd love to hear about whatever you can tell me about the world outside.</i>\"  Arian awaits your reply expectantly.");
			
			output("\n\nYou rack your brains; what can you tell him? Finally, you shrug and start talking about your travels in the wilderness beyond Tel'Adre.  Seeing how much exploration excites him, you take particular care to detail the many different places you've seen, how hard it is to know what you'll find with the strange \"<i>shifting</i>\" that the demons seem to have caused across the land, and all the many sex-mad monsters you've encountered in your travels.");
			
			output("\n\nArian listens attentively, like a child being told a story.  When you're done Arian smiles at you.  \"<i>Wow, you must be really busy.  And you still found time to be with a sickly mage.  Thank you so much for coming; it really means a lot to me.</i>\"  Arian takes your hand between his.  Despite yourself, you feel a swell of pride at the attention he's showing you; you squeeze his hand gently and promise him that you'll make sure and come back again if he's always going to be this attentive a listener.  It's nice to hear people are interested in your stories.");
			
			output("\n\nYou two continue to chatter for a while longer, but eventually you feel you must leave.  Arian looks visibly disappointed, but smiles at you all the same.  \"<i>Okay, I hope to see you soon, [pc.name].</i>\"  Clearing his throat, Arians yells, \"<i>Boon!</i>\"  Mere moments later Boon opens the door.  \"<i>Yes, master Arian?</i>\"");
			
			output("\n\n\"<i>Boon, would you please escort [pc.name] out?</i>\"  Boon nods and smiles.  \"<i>Of course, master.  Please come with me, [pc.name].</i>\"  You say one last farewell to the smiling lizan and start on your way out of the house.  Once at the doorsteps, Boon stops you.  \"<i>Hey, [pc.name].  You're an adventurer right?</i>\"");
			
			output("\n\nYou confirm that you are, yes.  Boon takes your hand in his and bows.  \"<i>Please! If you find a potion or herb or any other kind of medicine that could help, bring it for our master!  We've looked all over Tel'Adre but have been unable to find anything effective.  So please!  If you find something, bring it to us!</i>\"");
			
			output("\n\nYou promise to keep an eye out.  You then head back out to check up on your camp.");
			//PC returns to Tel'Adre menu screen
			//PC begins Arian romance quest
			//1 hour passes.
			processTime(55 + rand(10));
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
		else {
			//Subsequent Visits
			//His health affects the greeting you receive when seeing him.
			//If you modified Arian's gender, skip this intro once.
			//If you turned Arian into a girl/herm:
			//This plays at your next visit to Arian's place if you had him become a herm/girl.
			//Occurs only once, and after this intro plays as usual.
			//Don't increment ArianGirlHermChat yet!
			if (arian.hasVagina() && flags["COC.ARIAN_HERM_CHAT"] == 1) {
				output("Figuring that Arian would enjoy your company, you make your way with confidence through the streets leading to the lizan's home.  Soon enough, you find yourself standing before the stately home in which [arian.ey] and [arian.eir] ferret associates dwell. You pound heartily on the knocker to announce your presence.");
				output("\n\n\"<i>Coming!</i>\"  You hear Laika yell.  Shortly after the ferret girl opens the door.  Once she sees it's you, she doesn't bother greeting you; she drags you in and slams the door behind you.");
				output("\n\n\"<i>You!  What did you do to master Arian!?</i>\"  She threatens you with a duster.  Boon rushes in to check on the commotion, drying his wet hands with a piece of cloth.  \"<i>Sis, what's going... on...</i>\"  He looks at the scene and sighs.");
				output("\n\n\"<i>This... this... pervert had the nerve to come back after...</i>\"  Boon raises his hands in an attempt to silence his sister, not bothering to let her finish.  \"<i>Yes, yes, I know.  But it was master... uum... mistress Arian's decision, sis.  She told us herself.</i>\"");
				output("\n\nLaika's angry stare turns to her brother.  \"<i>Boon! I can't believe you're okay with this! I swear I should....</i>\"  Boon glares at Laika, obviously taking the role of big brother.  \"<i>Sis, we already spoke with mas... mistress Arian about this.  She likes [pc.name], so much that she was willing to go through with her... umm... transformation.  Besides that, ever since [pc.name] started visiting, mistress Arian's health has only gotten better, and you can't deny that, sis.</i>\"");
				output("\n\nLaika turns her angry glare back at you.  \"<i>You... you got lucky this time!</i>\"  She storms out of the entryway.");
				output("\n\nBoon looks at you apologetically.  \"<i>Sorry about that, [pc.name].  But don't worry, I'm sure my sis will come around eventually; just give her some time.</i>\"  He smiles at you.  \"<i>If you'll excuse me, I have some chores that need doing; do you mind heading off to mistress Arian's room on your own?</i>\"");
				output("\n\nHaving watched the display in silence, you give him a friendly smile and assure him you'll be fine.  \"<i>Great! See you later.</i>\"  He turns and leaves you.");
				output("\n\nRemembering where Arian's room is from the last time you visited, you proceed to make your way to it, finding the door to be closed, as usual.  You slowly rap your knuckles on the closed door, trying to announce your presence without being a nuisance at the same time.");
			}
			else {
				output("Figuring that Arian would enjoy your company, you make your way with confidence through the streets leading to the lizan's home.  Soon enough, you find yourself standing before the stately home in which he and his ferret associates dwell.  You pound heartily on the knocker to announce your presence.");
				output("\n\n\"<i>Coming!</i>\"  You hear Laika yell.  Shortly after the ferret girl opens the door and greets you.  \"<i>Hello [pc.name].  Came to visit " + arian.mf("master","mistress") + " Arian?  Please come in!</i>\"  She motions for you to enter the house.  You thank her for the polite invitation and step through the doorway.  The sound of dishes being washed draws your attention to the nearby kitchen, where you see Boon diligently washing a pan.  He looks up and waves at you with a soapy hand.  You return the gesture.");
				output("\n\n\"<i>Sorry to leave you unattended [pc.name], but we're kinda busy; do you think you can make the way to " + arian.mf("master","mistress") + " Arian's room by yourself?</i>\"  Laika asks.");
				output("\n\nYou assure the ferrets that it's fine, and you understand how busy they are.  Remembering where Arian's room is from the last time you visited, you proceed to make your way to it, finding the door to be closed, as usual.  You slowly rap your knuckles on the closed door, trying to announce your presence without being a nuisance at the same time.");
			}
			//(if ArianGirlHermChat == 1)
			if (flags["COC.ARIAN_HERM_CHAT"] == 1) {
				output("\n\nBefore you can say anything, you hear the distinct sound of Laika's yell.  It seems Boon and Laika are still engaged in a heated argument.  Arian winces and immediately apologizes to you.");
				output("\n\n\"<i>Sorry about that, [pc.name].  I guess I should've been more considerate of the shock it would be to change like this.</i>\"");
				output("\n\nYou don't say anything, and just listen in as Boon and Laika stop their quarreling.  Arian smiles at you.  \"<i>They may argue, but they're good people.  Usually it only takes a moment before they settle their differences.</i>\"");
				output("\n\nYou're inclined to agree, it's not often you see siblings getting along like that.  Something's been bothering you though...  You ask Arian if she regrets changing.");
				output("\n\nArian gasps and quickly adds.  \"<i>No!  Of course not!  Sure everything feels different now... and I find myself having urges and desires I didn't have before.</i>\"");
				output("\n\nCurious, you ask what kind of urges.");
				output("\n\nThe transgendered lizard blushes in embarrassment.  \"<i>Well... I've been thinking about laying eggs a lot, recently,</i>\" Arian says nervously.");
				output("\n\nYou laugh, well that's certainly something she wouldn't be doing as a male.");
				output("\n\nArian quickly changes the subject though.  \"<i>So... what do you want to do today?</i>\"");
				//ArianGirlHermChat++;
				IncrementFlag("COC.ARIAN_HERM_CHAT");
			}
			//0-9 health:
			else if (arian.health() < 10) {
				output("\n\nYou hear a faint cough through the door.  \"<i>Come in.</i>\"  You hear a tired voice say.  Gently clasping the doorknob, you slowly open the door, careful of startling the sickly lizan.");
				output("\n\nArian smiles at you as you enter.  \"<i>Oh, hello [pc.name].  I'm glad you came.</i>\"  He slowly sits up and motions to a chair nearby.  \"<i>Make yourself at home.</i>\"");
				if(pc.isTaur()) output("\n\nYou seat your tauric body on the floor");
				else output("\n\nYou pull the offered chair and sit");
				output(" next to his bed, smiling at [arian.em].");
				output("\n\n\"<i>So, is there anything you'd like to do?  Maybe talk?</i>\"  Arian asks.  You reply that talking is fine.");
			}
			//10-19 health:
			else if (arian.health() < 20) {
				output("\n\nYou hear the distinct groan of someone stretching from behind the door.  \"<i>Come in,</i>\" you hear a tired voice say.  Quietly but calmly you open the door and slip gently inside.");
				output("\n\nArian smiles as you enter, sitting on his bed.  \"<i>Hello, [pc.name].  I'm glad to see you.</i>\"  He motions to a nearby chair.  \"<i>Please, make yourself at home.</i>\"");
				if(pc.isTaur()) output("\n\nYou seat your tauric body on the floor");
				else output("\n\nYou take the nearby chair and sit");
				output(" next to his bed.  With a smile you ask how he is.");
				output("\n\n\"<i>I'm fine, thanks.  So... to what do I owe the pleasure of your visit today?</i>\"");
				//Display options
			}
			//20-29 health:
			else if (arian.health() < 30) {
				//Repeat this until the PC decides to sex Arian up somehow.
				if (int(flags["COC.ARIAN_TIMES_SEXED"]) == 0 && flags["COC.ARIAN_S_DIALOGUE"] == 2) {
					output("\n\nYou hear a faint moan.  \"<i>Oh... [pc.name].</i>\"");
					output("\n\nIs he... no, he couldn't be.  Arian's still too sickly to get horny... isn't he?  You wonder if you should try and spy on him - or maybe listen at the keyhole?  Then again, you could just barge on in - after all, it's not like he's really playing with himself, right?");
					//[Eavesdrop] [Peep] [Barge In] [Leave]
					clearMenu();
					addButton(0,"Eavesdrop",eavesDropOnArian);
					addButton(1,"Peep",peepOnArian);
					addButton(2,"Barge In",bargeInOnArian);
					addButton(3,"Leave",leaveFappingArian);
					return;
				}
				//(else)
				else {
					output("\n\n\"<i>Come in!</i>\"  You hear Arian say, detecting a slight pep to [arian.eir] voice.  You step inside and smile at Arian as you close the door behind you.  [arian.ey] smiles back at you and motions towards a nearby chair.");
					if (!pc.isTaur()) output("\n\nYou pull the chair and sit next to [arian.eir] bed.");
					else output("\n\nYou simply sit beside [arian.eir] bed.");
					output("\n\nArian smiles at you and asks, \"<i>So... what do you want to do today?</i>\"");
				}
				
			}
			//30-49 health:
			else if (arian.health() < 50) {
				output("\n\nYou hear the sound of drawers being pulled open and forcefully closed.  \"<i>C-come in!</i>\"  You hear Arian announce.  Curious as to what [arian.ey]'s up to, you open the door  and step inside to see Arian sitting on [arian.eir] work desk.  [arian.ey] slowly turns on [arian.eir] swivel chair to gaze at you with a smile.  \"<i>Hello, [pc.name]!</i>\"  [arian.ey] motions to a nearby chair.  \"<i>I was just working on a little project, nothing important.  So, make yourself at home!</i>\"  [arian.ey] smiles happily at you.");
				output("\n\nYou enter the room, wondering what [arian.ey] might have been working on, but decide it's probably nothing.  You note [arian.ey]'s made quite an improvement in health since you first met [arian.em].");
				output("\n\nYou pull the chair and sit next to [arian.em], asking why [arian.ey]'s thanking you;  [arian.ey] did all the hard work and made  [arian.em]self get better, you merely provided the incentive to try, you tell  [arian.em].  \"<i>You've given me much more than that, and for that I thank you.</i>\"");
				output("\n\nYou stop and consider a moment, wondering what you should do now that you're here with the lizan.");
			}
			//50-74 health
			else if (arian.health() < 75) {
				output("\n\n\"<i>[pc.name], is that you?  Come in!</i>\"  You hear Arian happily say.  You open the door and step in to find Arian sitting by [arian.eir] table, a book is laying on the table and a mug of tea in [arian.eir] hand.  [arian.ey] motions to a chair nearby as [arian.ey] sips [arian.eir] tea.  \"<i>Pull up a chair. May I offer you some tea?</i>\"");
				output("\n\nYou politely decline the tea and ");
				if (!pc.isTaur()) output("take the offered chair");
				else output("the offered chair");
				output(".");
				output("\n\nArian sets [arian.eir] mug down and smiles at you.  \"<i>So, to what do I owe the pleasure of your visit?</i>\"");
			}
			//75-100 health:
			else {
				output("\n\nArian opens the door, smiling brightly at you.  \"<i>Hello [pc.name]!  Come in!</i>\"  [arian.ey] says, stepping back and holding the door for you.  You step in and Arian closes the door behind you and embraces you in a friendly hug.  You return [arian.eir] hug with one of your own.");
				output("\n\nBreaking the hug Arian leads you to [arian.eir] table");
				if (!pc.isTaur()) output(" and offers you the chair nearby");
				output(".  Taking another for [arian.em]self.  \"<i>I love when you come visit, [pc.name].  So, what are we going to do today?</i>\" [arian.ey] asks, expectantly.");
			}
			//(Display Options)
			arianHomeMenu();
		}
	}
}

private function arianHomeMenu():void {
	clearMenu();
	if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 0 && arian.health() >= 10) addButton(0,"Next",arianStoryDialogue1);
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 1 && arian.health() >= 20) addButton(0,"Next",arianStoryDialogue2);
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 2 && arian.health() >= 30) addButton(0,"Next",arianDialogue3);
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 3 && arian.health() >= 50) addButton(0,"Next",arianImbue);
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 4 && arian.health() >= 75) addButton(0,"Next",arianPlot4);
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 5 && arian.health() >= 100) addButton(0,"Next",arianPlot5);
	//If no story dialogue
	else {
		addButton(0,"Talk",talkToArianChoices);
		if (int(flags["COC.ARIAN_S_DIALOGUE"]) >= 2) addButton(1, "Sex", arianSexMenu);
		if (int(flags["COC.ARIAN_S_DIALOGUE"]) >= 1) addButton(3, "Give Item", giveArianAnItem);
		if (pc.hasKeyItem("Arian's Talisman") >= 0 || pc.hasKeyItem("Arian's Charged Talisman") >= 0)
			addButton(2, "Talisman", imbueTalisman);
		if (int(flags["COC.ARIAN_S_DIALOGUE"]) >= 5) {
			if (flags["COC.ARIAN_TREATMENT"] == days) addDisabledButton(4, "Treat Corr.", "Treat Corruption", "Arian can help you only once per day.");
			else addButton(4,"Treat Corr.",treatCorruption);
		}
		if (hours >= 17 && arianFollower()) addButton(8, "Sleep With", sleepWithArian, true);
		if (flags["COC.SLEEP_WITH"] == "Arian") addButton(8, "NoSleepWith", dontSleepWithArian);
		if (!arianFollower()) addButton(14, "Leave", telAdreMenu);
		else addButton(14, "Back", campLoversMenu);
	}
}

private function dontSleepWithArian():void {
	clearOutput();
	output("You decide not to sleep with Arian at night, for now.");
	flags["COC.SLEEP_WITH"] = "";
	arianHomeMenu();
}

//[=Eavesdrop=]
private function eavesDropOnArian():void {
	clearOutput();
	//output(images.showImage("arian-fap"));
	output("You sidle up to the door, pressing your ear against the wood and start to listen intently.");
	output("\n\n\"<i>Curse my illness... curse my dreams... oh, [pc.name]... if only you knew....</i>\"  Arian pants and moans, the distinct fapping sound of a hand slapping reaches your ears.  \"<i>Ah! The things you do to me... the things I wish you would do to me... ah....</i>\"");
	pc.slowStatGain("i", 1);
	clearMenu();
	addButton(0,"Barge In",bargeInOnArian);
	addButton(4,"Leave",leaveFappingArian);
}

//[=Peep=]
private function peepOnArian():void {
	clearOutput();
	//output(images.showImage("arian-fap"));
	output("Curious, you decide to take a little peek through the lock; you press yourself against it as best you can, looking through into the bedroom beyond.  True to what your ears heard, the sickly albino's health has improved enough for him to focus on more... carnal matters.  Naked from the waist down, he sits on the edge of his bed, groinal slit disgorging a single, average-sized phallus.  Maybe 6 inches long, it's a bright purple-red color, covered in strange lumps");
	if (pc.cockTotal(GLOBAL.TYPE_SNAKE) > 0) output(" just like yours");
	output(", though this isn't stopping him from enthusiastically stroking himself off.");
	
	output("\n\n\"<i>Curse my illness... curse my dreams... oh, [pc.name]... if only you knew....</i>\"  Arian pants and moans, the distinct sound of fapping quite audible from where you are.  He whimpers softly and bites his lip, clearly nearing the brink.  \"<i>Ah! The things you do to me... the things I wish you would do to me... ah....</i>\"  He groans to himself.");
	
	output("\n\nYou ponder this curious development.  So, the reptile has developed a crush on you?  He thinks you're attractive?  Well, now... should you give him the chance to finish himself off, or should you head in now - either to tell him off, or offer him something a bit better than his hand to play with?");
	pc.slowStatGain("i", 1);
	//[Barge In - Leads on to \"<i>Barge In</i>\" scene from first choice] [Leave]
	clearMenu();
	addButton(0,"Barge In",bargeInOnArian);
	addButton(4,"Leave",leaveFappingArian);
}

//[=Leave=]
private function leaveFappingArian():void {
	clearOutput();
	output("You decide to let Arian have some privacy and leave for the moment... after all, what the lizan mage does in his free time is not really your business....");
	output("\n\nAs you make your way back to the entryway, Boon sees you and asks, \"<i>Leaving already? Usually you stay with master Arian for at least an hour... what happened?</i>\"");
	output("\n\nYou tell Boon that Arian seems to be a bit busy at the moment, so you'll just come back later.");
	output("\n\n\"<i>Busy, huh?  Well if you want I could call him for you; master Arian is always happy to see you any time.</i>\"  Boon smiles starting on his way towards Arian's bedroom.  You quickly stop him though, explaining that it's best to let Arian have some privacy for now. \"<i> Are you sure, [pc.name]?  It's no trouble at all, I assure you.</i>\"  You insist that he shouldn't bother Arian right now.  Boon shrugs.  \"<i>If you say so... anyways, do come visit later.  Ever since you started visiting master Arian, he has been a lot less rebellious, not to mention he seems to be getting healthier and happier.</i>\"");
	output("\n\nYou promise to return later and bid him farewell.  You step outside and make your way back to your camp.");
	//Return to camp
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[=Barge in=]
private function bargeInOnArian():void {
	clearOutput();
	//output(images.showImage("arian-fap"));
	output("With a wry smirk you turn the knob and find that Arian's door is unlocked; without missing a beat, you open the door and step in right in time to see a sticky rope of pre paint Arian's slender belly as he scrambles to cover himself up.");
	output("\n\n\"<i>[pc.name]!  W-Wait, I can explain!  I swear I... I... oh, Marae!</i>\"  He hides himself under the covers of his bed, his white-scaled face red with shame.");
	output("\n\nSlowly you approach the hiding lizard, and sit on his bed.  You let him know you're flattered to be his object of desire, and that there's no need to hide himself.  If he felt this way about you he should just have said so.");
	output("\n\nArian peeks from under his covers.  \"<i>Y - You mean you're not mad at me?</i>\"  You smile and tell him you aren't.  Arian visibly relaxes, letting his covers fall on his chest.");
	//(if PC is male)
	if (pc.hasCock() && !pc.hasVagina()) {
		output("\n\n\"<i>I just assumed... since we're both male....</i>\" He explains himself, fidgeting.  \"<i>I didn't know if you... well... if you would mind that....</i>\"");
		output("\n\nYou raise your eyebrow; it seems that Arian is not opposed to some male on male.... What do you tell him?");
		//[Don't mind] [Like Girls]
		clearMenu();
		addButton(0,"Don't Mind",youDontMindBeingGayForArian);
		addButton(1,"Like Girls",youLikeGirlsNotSickLizardDudes);
	}
	//(else if PC is genderless)
	else if (!pc.hasCock() && !pc.hasVagina()) {
		output("\n\n\"<i>I just assumed... since we're both male....</i>\"  He fidgets with his hands.  \"<i>I didn't know if you... well... if you would mind that....</i>\"");
		output("\n\nYou stop him in his tracks, and tell him you're not exactly male.  You strip your undergarments and let Arian gaze in fascination at your crotch - your clean, smooth, genderless crotch.  Not believing what he is seeing Arian crawls forward to touch your crotch, mesmerized.  \"<i>How?  You... I... we can't....</i>\"  You silence him with a finger, and tell him there's plenty you two can do.");
		//(Display Sex Menu)
		arianSexMenu(false);
	}
	//(else if PC is female)
	else if (!pc.hasCock() && pc.hasVagina()) {
		output("\n\n\"<i>It's just that... well... you're so beautiful and I'm... I didn't think you....</i>\"  He trails off.");
		output("\n\nYou tell him he looks adorable, especially when he's acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils.  Surprised by this development, you ask him if he really is a virgin.");
		output("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
		output("\n\nYou pull the covers off his face and say, \"<i>Well... we'll have to fix that then.</i>\"  You slip off his bed and begin stripping off your [pc.gear].  Arian shyly does the same, stripping off his robes until he is laying in his bed, completely naked.");
		//(Proceed to Get Penetrated)
		clearMenu();
		addButton(0,"Next",getPenetratedByArianAndHisHitlerMustache);
	}
	//(else) //if PC is a herm
	else {
		output("\n\n\"<i>It's just that... well... you're so beautiful and I'm... I didn't think you....</i>\"  He trails off.");
		output("\n\nYou tell him he looks adorable, especially when he's acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils, surprised by this development you ask him if he really is a virgin.");
		output("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
		output("\n\nYou pull the covers off his face and say, \"<i>Well... we'll have to fix that then.</i>\"  You slip off his bed and begin stripping off your [pc.gear].  Arian shyly does the same, stripping off his robes until he is laying in his bed, completely naked.");
		output("\n\nOnce you toss your [pc.gear] on the floor, however, Arian's eyes widen as he realizes you're not entirely female; he eyes your [pc.crotch] between your legs with equal parts wonder and arousal.");
		output("\n\n\"<i>I... you... I never... wow....</i>\"  You call Arian's name, breaking his trance.  \"<i>S-Sorry for staring,</i>\" he quickly apologizes, but you just chuckle at his reaction and tell him he doesn't have to worry about this.");
		output("\n\n\"<i>I never imagined you would have both... err... genders,</i>\" [arian.ey] says nervously.  You just smile at him and ask if he has a problem with that.");
		output("\n\nArian quickly blurts out, \"<i>No!  Of course not!  Never!  I just... well... to be honest I don't mind that you have extra... umm... parts; in fact I think that is... kinda... sexy.</i>\"  He looks at you, cheeks red in shame over his admission.  ");
		output("\"<i>So... umm... my point is... I don't mind if you....</i>\"  Arian swallows audibly.  \"<i>If you decide to penetrate me... that is if you don't mind me being male... I don't mean to offend you or anything!  I just heard that some girls like you prefer... other girls....</i>\"  He looks away in shame.");
		output("\n\nYou rub your chin in thought....");
		//[Like Male] [Prefer Female]
		clearMenu();
		addButton(0,"Like Male",hermsLikeMaleArian);
		addButton(1,"Like Female",hermsLikeFemaleArian);
	}
}

//[=Like Male=]
private function hermsLikeMaleArian():void {
	clearOutput();
	output("You tell him that's not the case for you; you don't have a problem with him being a guy.  In fact, you think he looks very cute, earning you a nervous smile.  Arian relaxes, letting you look over his body and decide what you want to do....");
	//(Should you penetrate him or mount him?)
	//Penetrate - (Proceed to appropriate scene)
	//Get Penetrated - (Proceed to appropriate scene)
	clearMenu();
	if (pc.cockThatFits(arian.analCapacity()) >= 0) addButton(0, "Pitch Anal", giveArianAnal);
	else addDisabledButton(0, "Pitch Anal", "Pitch Anal", "This scene requires you to have fitting cock.");
	addButton(1,"Get Penetrated",getPenetratedByArianAndHisHitlerMustache);
}

//[=Prefer Female=]
private function hermsLikeFemaleArian():void {
	clearOutput();
	output("You tell him that while you do like to play with guys once in a while, you prefer girls.");
	output("\n\n\"<i>So... you'd prefer if I was a girl... right?</i>\"");
	output("\n\nYou scratch your chin in thought, and imagine how he would look as a girl; then you tell him you'd love it if he was a girl.  \"<i>Okay then... I... I'll do it!</i>\"");
	output("\n\nYou raise your eyebrows in surprise.  What is he planning on doing?");
	output("\n\nArian gets up and off the bed, not minding that he's exposing himself completely; then slowly walks toward his work desk and opens a drawer.  Reaching inside, he pulls out a mysterious bottle labelled with a pink egg.  He turns to look at you as he uncorks the bottle and then downs its contents.");
	output("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom and you feel your blood surging to your [pc.cocks].");
	output("\n\nThe transformation is not over yet though; a throaty feminine moan precedes the appearance of a pair of small perky breasts, complete with sensitive little nipples.  You watch in a daze as the transformation finishes, Arian's face growing softer, rounder, girly; the same happens to her body, her hips grow larger, as does her butt, becoming fuller and attractive, giving her a beautiful, if slender, figure.");
	output("\n\nWith a nervous smile, she asks, \"<i>S-So? How do I look now...?</i>\"");
	output("\n\nYou don't bother replying; you walk up to her and gently help her up.  Then you push her gently towards the bed and begin stripping.  Arian smiles and lays down.");
	//(Proceed to Penetrate)
	flags["COC.ARIAN_HERM_CHAT"] = 1;
	
	arian.removeCocks();
	arian.createVagina();
	arian.shiftVagina(0, GLOBAL.TYPE_SNAKE);
	arian.breastRows[0].breastRatingRaw = 1;
	
	clearMenu();
	addButton(0,"Next",penetrateArian);
}

//[=Don't mind=]
private function youDontMindBeingGayForArian():void {
	clearOutput();
	output("You tell him that you don't have a problem with males, as long as they're cute.  You smile at him.  \"<i>You... do you really think I'm cute?</i>\"");
	output("\n\nYou nod, it's not everyday you see a grown man acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils.... Surprised by this development you ask him if he really is a virgin.");
	output("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
	output("\n\nWell, we'll have to fix that then.  You pull the covers off his face.  Slipping off his bed, you begin stripping off your [pc.gear].  Arian shyly does the same, stripping out of his robes until he is laying in his bed, completely naked.\n\n");
	//(Proceed Give Anal)
	
	// Redirecting the scene if the players cock is too big for the anal scene... not ideal, but its a QWIKFIX™
	clearMenu();
	if (pc.cockThatFits(arian.analCapacity()) >= 0) addButton(0, "Anal - Pitch", giveArianAnal);
	else addDisabledButton(0, "Anal - Pitch", "Anal - Pitch", "This scene requires you to have fitting cock.");
	addButton(1, "Anal - Catch", getButtWreckedByArian);
}

//[=Like Girls=]
private function youLikeGirlsNotSickLizardDudes():void {
	clearOutput();
	output("You tell him that you prefer females.... Arian looks at you expectantly.  \"<i>So... if I was a girl... then you wouldn't mind?</i>\"");
	output("\n\nYou scratch your chin in thought; and let him know that if he was a girl, then you wouldn't mind at all.  \"<i>Okay then... I... I'll do it!</i>\"");
	output("\n\nYou raise your eyebrows. What is he planning on doing?");
	output("\n\nArian gets up and strips off his robes, exposing himself completely, then slowly walks toward his work desk and opens a drawer.  Reaching inside, he pulls out a mysterious bottle labelled with a pink egg.  He turns to look at you and uncorks the bottle, then downs the whole bottle.");
	output("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom, and you feel your blood surging to your [pc.cocks].");
	output("\n\nThe transformation is not over yet though; a throaty feminine moan precedes the appearance of a pair of small perky breasts, complete with sensitive little nipples.  You watch in a daze as the transformation finishes, Arian's face growing softer, rounder, girly; the same happens to her body, her hips grows larger as does her butt, becoming fuller and attractive, giving her a beautiful, if slender, figure.");
	output("\n\nWith a nervous smile, she asks, \"<i>S-So? How do I look now...?</i>\"");
	output("\n\nYou don't bother replying; you walk up to her and help her up then gently push her towards the bed as you begin stripping.  Arian smiles and lays down. ");
	//(Proceed to Penetrate)
	clearMenu();
	flags["COC.ARIAN_HERM_CHAT"] = 1;
	
	arian.removeCocks();
	arian.createVagina();
	arian.shiftVagina(0, GLOBAL.TYPE_SNAKE);
	arian.breastRows[0].breastRatingRaw = 1;
	
	clearMenu();
	addButton(0,"Next",penetrateArian);
}

//Story Dialogue
//Story Dialogue precedes all other interactions with Arian if the PC qualifies for any.
//They should happen whenever Arian reaches a new threshold.
//All of them occur only once.
//((if ArianHealth >= 10) && (ArianSDialogue == 0))//May give Vitality T. and Arian will accept it.
private function arianStoryDialogue1():void {
	arian.health(1);
	clearOutput();
	output("You feel like you'd like to know a bit more about Arian, so you ask if he would mind sharing some of [arian.eir] history with you.  After all, as a survivor from at least the early days of the demon war, and a wizard to boot, he's got to have some stories up [arian.eir] voluminous sleeves.");
	output("\n\nArian nods.  \"<i>I guess it isn't fair that I'm the only one that gets to hear your stories... but before we start....  How long ago do you think this whole demon trouble started?</i>\"");
	output("\n\nYou shrug your shoulders; ");
	//PC has met Marae: 
	if (flags["COC.MET_MARAE"] >= 1) output("Marae herself told you they showed up about, what, 20-30 years ago?");
	else output("you'd guess a long while ago given the general mess they seem to have made of the world.");
	
	output("\n\nArian nods.  \"<i>Good guess....  And how old do I look?</i>\"");
	
	output("\n\nYou look the reptilian wizard up and down, contemplating. Then you profess you aren't really familiar with people covered in scales, but you'd guess somewhere in [arian.eir] mid-20s?");
	output("\n\nArian nods and smiles.  \"<i>I'm actually 23 years old....  So I can't tell you much about how this whole trouble started, I was only a child back then... and my parents made sure to keep me sheltered from all that as well....</i>\"  Arian stares in the distance.  \"<i>Sheltered, I guess that word defines me pretty well.  I've been sheltered from the world for most of my life.</i>\"");
	output("\n\nYou ask why; what made [arian.eir] parents shelter him from the world outside?");
	
	output("\n\nArian looks back at you.  \"<i>Well, the world was a mess, so they thought it best if I just stayed in the academy; they told me stories of young lizans walking outside who were dragged away by demons to take part in terrible rituals.  They weren't entirely wrong I guess, but that was a really cruel thing to say to a child.  Although, they were just looking after me, in the end, and as curious as I am....  Well, let's not dwell on that.</i>\"  Arian clears [arian.eir] throat.  \"<i>So, I've been at the academy for as long as I can remember.  I told you about how I used to live buried in books right?</i>\"");
	
	output("\n\nYou nod your head and admit that he did indeed tell you that.");
	output("\n\n\"<i>Well, what I didn't tell you is that books used to be the only thing I cared about as well.</i>\"");
	output("\n\nYou comment that it does seem kind of odd that a self-professed bookworm would be so desperate to get out and stretch [arian.eir] legs, now that he mentions it.  Arian laughs at that.  \"<i>Yes, quite a change wouldn't you say?</i>\"  Then, with a sigh, he says, \"<i>It's ironic actually.  Since I couldn't go outside, all I had were the books; and the books had become my world: I read them, loved them, lived in them, and mastered them. With the time I spent reading, it was quite an easy path towards wizardhood.  As soon as I was of age, I joined the academy formally, and during my testing I was shown to have skills greater than or on par with my testers. In the end, they didn't see a need to instruct me, so they declared me a master of the art and assigned me my pupils: Laika and Boon.</i>\"");
	output("\n\nDid he enjoy having students of [arian.eir] own to teach?");
	output("\n\nArian's eyes light up in recollection.  \"<i>Enjoy it?  I loved it!  These two... they became much more than mere pupils; they were my friends.  I can even say they're part of my family.  Having grown up alone, ignored by my elders, who were too busy with their next research project to pay any attention to me, and with nothing but books to keep me entertained.  Can you imagine how many friends I had?</i>\"");
	output("\n\nYou must confess that the situation he's describing sounds quite lonely.");
	
	output("\n\n\"<i>So you can imagine how thrilled I was to get not one, but two people who would have to pay attention to every single instruction I gave them.</i>\"  Arian looks down, a slight tinge of regret on [arian.eir] face.  \"<i>I was pretty mean at first.  I wound up taking my frustrations out on them, but thankfully they found it in their hearts to forgive me.  We've been very close ever since.</i>\"  Arian smiles.");
	output("\n\nYou tell him that it's good to hear they got to know each other properly; is that why Arian gave particular attention to ensuring they escaped when [arian.eir] academy was attacked?");
	output("\n\nArian shakes [arian.eir] head.  \"<i>Not exactly.  It was my intention to defeat all of the invading demons; I was arrogant and it cost me greatly.  I only managed to save Boon and Laika because they were the closest to me when the wave of dark magic hit us.  I used much of my power and concentration to resist the wave's effects... it was brutal.</i>\"");
	
	output("\n\nDoes that have something to do why he's so frail now - the stress of shielding himself and [arian.eir] apprentices from the demons' black magic?");
	
	output("\n\n\"<i>Yes, actually. I'm not going to get into any specifics right now, but my method of casting spells causes damage to the caster's body, which is why I'm in such a miserable state.</i>\"  Arian sighs.  \"<i>Now I can't even go for a walk....</i>\"");
	output("\n\nYou reach out a hand and pat him on the shoulder; you don't really think it'll make him feel any better, but it's what they always used to do when people got like this back in your village.  As you pat [arian.eir] shoulder, you realize he still hasn't told you what made him change [arian.eir] attitude so much.  Even as you continue giving him comforting touches, you ask why it bothers him being bedridden now if he was an antisocial stay-at-home bookworm before.");
	output("\n\n\"<i>Oh, yes.  I got sidetracked, sorry.</i>\" Arian grins at you and says, \"<i>I escaped the academy.</i>\"  You scratch the back of your neck; this isn't much of an explanation.  Noticing the confusion in your face, Arian explains, \"<i>The academy didn't have any windows.  Something about preserving our privacy and ensuring no external elements would interrupt our studies.  It doesn't matter now.  So, before escaping the academy with Boon and Laika in tow, I hadn't even gazed at the sky.</i>\"");
	
	output("\n\nYou blink in surprise; he'd never even seen the sky?  How could they keep anyone so constrained?  What - did he hatch indoors and was never allowed outside?");
	output("\n\nArian sighs.  \"<i>Well, I did tell you my parents kept me inside the academy at all times.</i>\"  He sighs once again.  \"<i>I never knew the world was so big, or so beautiful.  I'd been missing out.  I want to go out and see more.  All the good and the bad.</i>\"  Arian looks down.  \"<i>But the truth is I can't, not like this.</i>\"  He sighs in exasperation.");
	
	output("\n\nYou try to cheer the depressed lizan up, exhorting that he needs to be optimistic about things; after all, amongst all the crazy potions and tonics, surely there's something that can make a drinker healthier and stronger?");
	output("\n\nArian sighs.  \"<i>I have tried so many already.  Boon and Laika have been all over Tel'Adre trying to find something to help me get better, but nothing seems to work....</i>\"");
	output("\n\nYou press the subject and ask him if he really doesn't know or have heard about anything that could help at all.");
	
	output("\n\nArian furrows [arian.eir] brows in deep thought.  \"<i>I think... I heard there might be something after all.  Something... vitality... I don't recall its name right now.  It's some kind of tonic or tea that is supposed to help you get tougher and stronger.</i>\"");
	output("\n\nAll right, it's settled then.  You tell Arian you're going to help him out, but he must promise to behave and stay in bed; if he keeps going out like when you first met him he's never going to get better.");
	output("\n\nArian sighs.  \"<i>I know I shouldn't go out, but sometimes I feel like I'm going insane if I stay cooped up in here.  I've spent so much time inside at the academy, and besides that, you have no obligation to help me at all.  I couldn't trouble you by sending you to look after some kind of medicine I don't even know where to find.</i>\"");
	output("\n\nYou tell him that you understand how that must make him feel.  Still, running around all the time clearly isn't doing him any good.  Furthermore, it's no trouble at all; you want to help.  Hmm... what if you promise to drop in now and then - share some of your stories about life in the wasteland, let him live vicariously through your actions?  Will that encourage him to stay in bed and avoid overexerting himself?");
	output("\n\nArian smiles at your offer.  \"<i>Well, that would certainly help.  I enjoy your company; there's something about you that.  Well... I guess you help me relax, and hearing about the world is not so bad either.  But I really wanted to see it.</i>\"");
	
	output("\n\nAnd see it he will, but only if he listens to you and gives himself a real chance to recover!  You insist that he start relaxing; it's probably the tension as well as the punishment he puts himself through in the name of boredom that's keeping him from making any major recovery.");
	output("\n\n\"<i>Maybe you're right.  All right then, I'll trust you [pc.name].  I've been stuck inside the academy for many years... I guess I can hold out for a few weeks longer, as long as you come visit me.</i>\"  He extends [arian.eir] hand.  \"<i>Deal?</i>\"");

	output("\n\nYou give him a firm handshake, pronouncing that it's a deal.  Arian smiles at you before opening [arian.eir] maw into a wide yawn.  \"<i>Sorry about that, [pc.name].  I guess I'm a bit sleepy....</i>\"");
	output("\n\nYou smile, and tell him that it's all right and he needs [arian.eir] sleep, so he had best get into bed. Arian nods and tucks himself in.  \"<i>Thank you, [pc.name].</i>\"  You bid him goodnight and gently close [arian.eir] door behind you.  On your way out you let Boon and Laika know Arian is sleeping, then you make your way back to camp.");
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	//player returns to camp.
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

////((if ArianHealth >= 20) && (ArianSDialogue == 1)) 
//Can sex Arian.
private function arianStoryDialogue2():void {
	clearOutput();
	arian.health(1);
	output("You look Arian over, remarking that he seems to be getting better after all.");
	output("\n\n\"<i>Thanks to you.</i>\" Arian smiles, then he looks down and sighs.  You ask him what's wrong.");
	output("\n\n\"<i>I've been having... erm, confusing dreams lately.</i>\" Arian explains. Curious, you ask him what sorts of dreams; not bad ones, you hope.");
	output("\n\nArian quickly says, \"<i>No! Not bad ones! Just... unusual I'd say....</i>\"");
	output("\n\nYou look at him questioningly.  \"<i>Maybe it's best if I tell you....</i>\"");
	output("\n\nArian clears [arian.eir] throat and begins explaining, \"<i>First I'm standing somewhere - I don't know where - in Tel'Adre.  I'm all alone, but I'm happy; I'm expecting someone.  When the person I'm expecting arrives, we talk - I don't remember the subject now.</i>\" Arian fidgets.");
	output("\n\nYou tell him he needs to try and remember what happened if he wants to really hear what you think, but so far it doesn't sound so strange.");
	output("\n\n\"<i>You see, the strange part is... it's what happens later.</i>\"  Arian blushes in embarrassment.  \"<i>We go to my room and I... I'm sorry I can't talk about it!</i>\"  Arian blushes even more.");
	output("\n\nIt doesn't take you long to figure out what kind of dreams he's been having.  With a faint smile on your lips, you give him a comforting pat on the shoulder and tell him that there's nothing to worry about in having such dreams.");
	output("\n\nArian looks at you, still embarrassed.  \"<i>But the person I meet... I don't know if it would be appropriate.... Maybe the corruption is getting to me?</i>\"");
	output("\n\nYou ask him why he feels like that - what's wrong with [arian.eir] dream lover?  ...Is he worried because [arian.eir] lover is a boy?  Or maybe a girl with a cock?");
	output("\n\nArian swallows audibly.  \"<i>No, that's not the point....  I mean... maybe... just... just forget about it....  I'm feeling a bit tired.... Do you mind if we talk some other time?</i>\"");
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	//[Drop It] [Pry]
	clearMenu();
	addButton(0,"Drop It",arianStory2DropIt);
	addButton(1,"Pry",arianStoryPry);
}

//=Drop It=
private function arianStory2DropIt():void {
	clearOutput();
	output("Though you do feel a little curious, you decide to stop making him uncomfortable, and tell him that it's okay, you'll let him get some sleep now.");
	output("\n\n\"<i>Thanks, [pc.name].  I'll see you later then.</i>\"  Arian tucks himself in.  You watch until he's settled in, and then start the trek back to your home-away-from home in the Marethian wilderness.");
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//=Pry=
private function arianStoryPry():void {
	clearOutput();
	output("Oh, no, you're not letting him wriggle out of this that easily.  You playfully tap [arian.eir] nose and tell him he should come clean and confess");
	if (pc.cor() < 40) output("; he'll sleep better with the burden off [arian.eir] conscience");
	output(".");
	output("\n\nArian closes [arian.eir] eyes and admits.  \"<i>It's someone close!</i>\"  He blurts out, hiding himself under the covers.");
	output("\n\nWell, now, that's intriguing... still, no matter how you try, he won't say anything more and he won't come out.  It's quite clear what's going on so all you can do is sigh, do your best to pat [arian.eir] head through the covers, and tell him you'll come back another day and that you're sorry for being so nosey.  You then turn and walk out the door, heading down the stairs and back to camp.");
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//((if ArianHealth >= 30) && (ArianSDialogue == 2))
 //Will Teach Magic
private function arianDialogue3():void {
	clearOutput();
	arian.health(1);
	output("Before you can say anything, Arian asks you, \"<i>[pc.name], I've been wondering....  Do you have any interest in magic?  You've done so much for me; I believe I should return the favor somehow.</i>\"");
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	//[Yes] [No]
	clearMenu();
	addButton(0,"Yes",yesArianShouldMagicTeach);
	addButton(1,"No",noArianShouldntMagicTeach);
}

//=Yes=
private function yesArianShouldMagicTeach():void {
	clearOutput();
	output("You tell [arian.em] that sounds fascinating.  You'd love to learn how to cast spells the way [arian.ey] can, and you're grateful [arian.ey] wants to take you on as an apprentice.  Especially when [arian.ey]'s already so busy with the ones [arian.ey] already has.  Arian rubs the back of [arian.eir] neck.  \"<i>Sorry, [pc.name].  But I can't actually teach you how to cast spells the same way I do....  That would take years to teach, not to mention it's very dangerous; I mean, look at what it's done to me....</i>\"  [arian.ey] smiles at you.  \"<i>But I could still teach you about magic in general - how to cast more spells, how to make them more powerful, the principles behind every spell....  Basically, theory that might help you in the pursuit of magical studies.  I spent my whole childhood buried in books, so I'm sure I could help you out somehow.</i>\"");
	
	output("\n\nYou smirk and point out that's basically what you meant, but you're definitely still interested either way.  Arian nods happily.  \"<i>Okay, then, where to start....</i>\"");
	
	//(Go to Talk about Magic)
	clearMenu();
	addButton(0,"Next",arianMagicLessons);
}

//=No=
private function noArianShouldntMagicTeach():void {
	clearOutput();
	output("You think it over for a moment, and then tell Arian that while you are flattered by the offer and willing to consider it, you can't say that you want to study magic right this moment.  You'd like to discuss it at some other time, please.");
	output("\n\nArian nods happily.  \"<i>Certainly, I'd be happy to be of some help to you.  So... is there something you'd like to do today?</i>\"");
	
	//(display options) 
	arianHomeMenu();
}

//((if ArianHealth >= 50) && (ArianSDialogue == 3))
//Give Talisman, Imbue unlocked.
private function arianImbue():void {
	clearOutput();
	arian.health(1);
	output("Before you can say anything, Arian gasps, \"<i>Oh, [pc.name].  I have a surprise for you.</i>\"  Arian says with a smile.");
	
	output("\n\nA surprise?  What is it?");
	output("\n\nArian opens a drawer in [arian.eir] work desk and removes a small package, neatly wrapped and adorned with a small ribbon.  \"<i>For you.</i>\"  Arian says, handing over the gift.");
	
	output("\n\nYou reach out and gently take it from [arian.em], carefully opening the package.  A part of you briefly wonders if it might be an engagement ring, then dismisses the thought - surely not, not even here in Tel'Adre.  Once the package is open, you gaze upon a silver necklace: the design is intricate and exotic - very beautiful.  Held by its unusual chain lies a small silver plate with a rune adorning the center, although you don't recognize the rune.");
	output("\n\nArian smiles at you.  \"<i>Do you like it?  I made it myself.</i>\"");
	
	output("\n\nYou study the fascinating piece, and tell [arian.em] the honest truth: it's beautiful.  You never would have expected [arian.em] to be such a crafts[arian.manWoman].  Arian blushes at your flattery.  \"<i>Thanks, I'm glad you like it.  But let me explain - that is not a common necklace; it's actually a magical talisman.  I wanted to give you something that would be useful in your adventures,</i>\" Arian explains.");
	
	output("\n\nYou smile at [arian.em], and promptly hang the necklace around your neck, telling [arian.em] it's as thoughtful as it is attractive.  Arian blushes.  \"<i>There is just a... well, a tiny problem.</i>\"");
	
	output("\n\nYou freeze nervously.  Problem...?  You wonder if putting it on was such a good idea now.  Arian nods.  \"<i>I haven't actually imbued the talisman with any spell, since I don't have any ingredients to do so.  Sorry, [pc.name].</i>\"  Arian looks down disappointed.");
	
	output("\n\nYou heave a sigh of relief; is that all?  Well, what if you just bring [arian.em] some ingredients next time you drop in, hmm?  Would that help [arian.em] put the finishing touches on it?");
	
	output("\n\nArian smiles and nods.  \"<i>Of course.  But I should warn you that the talisman can only hold one spell, although once it's been imbued with a spell you may use it to your heart's content... I mean... as long as you don't get too tired doing so....  I have a list of spells and things that I need to complete a spell; all you have to do is bring the ingredients and tell me which spell you want.</i>\"");
	
	output("\n\nYou thank Arian; such a gift is bound to be useful in your travels.");
	
	output("\n\nArian bites [arian.eir] lower lips.  \"<i>So... is there anything you'd like to do?  Maybe....</i>\" Arian blushes.  \"<i>You could thank me properly... for the gift.</i>\" [arian.ey] eyes you up and down, resting [arian.eir] gaze on the floor as [arian.ey] fidgets.");
	
	output("\n\nOh-hooo....  Your smoldering eyes burn holes in the nervously embarrassed lizan, and you give [arian.em] your sexiest glare as you ask whatever [arian.ey] means by \"<i>thanking [arian.em] properly</i>\"...?  You reach out and stroke the side of [arian.eir] face to emphasize your words, watching [arian.em] shudder anticipatorily at your touch.");
	
	output("\n\nArian swallows audibly.  \"<i>I... I... I want you!</i>\" Arian blurts out, averting [arian.eir] gaze in embarrassment, fidgeting even more in what you've come to recognize as a sign [arian.ey] is aroused.");
	
	output("\n\nDo you have sex with Arian?");
	pc.createKeyItem("Arian's Talisman", 0, 0, 0, 0, "Not charged now.");
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	//[Yes] [No]
	clearMenu();
	addButton(0,"Yes",yesPlotSexArian);
	addButton(1,"No",noPlotSexNauArian);
}

//=Yes=
private function yesPlotSexArian():void {
	clearOutput();
	output("You approach the awkwardly amorous lizan and place your arms around [arian.eir] neck.  Leaning in close, you whisper into [arian.eir] ear that [arian.ey] only had to ask.");
	//(Display Sex Menu)
	arianSexMenu(false);
}

//=No=
private function noPlotSexNauArian():void {
	clearOutput();
	output("You apologize to the lizan, telling [arian.em] that you aren't in the mood right now....");
	output("\n\nArian looks a bit disappointed, but doesn't press the issue.  \"<i>Oh... Okay then, but... maybe, next time?</i>\" [arian.ey] asks hopefully, smiling nervously despite [arian.eir] embarrassment....");
	
	output("\n\n Maybe next time, you agree. Arian grins at you.  \"<i>Okay, then.  Is there something else you'd like to do?</i>\"");
	
	//(Display Options)
	arianHomeMenu();
}

//((if ArianHealth >= 75) && (ArianSDialogue == 4))
 //Will treat Corruption.
private function arianPlot4():void {
	clearOutput();
	arian.health(1);
	output("Before you can say anything, Arian says, \"<i>Oh, I have good news, [pc.name]!</i>\"");
	output("\n\nGood news?  What is it?");
	output("\n\n\"<i>I'm feeling well enough that I think I can channel my magic through you and help you if you feel you're getting overwhelmed by this world's corruption.  But due to the intensity of the treatment, I don't think I'd be able to do it more than once per day....</i>\"");
	
	output("\n\nYou tell [arian.em] that, even if it's only once every 24 hours, that could be a very useful trick, and thank [arian.em] for being willing to make such a sacrifice on your behalf.");
	
	output("\n\nArian smiles brightly at you.  \"<i>No problem.  I'd do anything for you.</i>\"  [arian.ey] gazes into your eyes in silence... perhaps a bit too long....  You clear your throat and Arian seems to snap out of [arian.eir] trance.  \"<i>Oh!  Umm... is there something you want to do?</i>\"  [arian.ey] fidgets.");
	
	//(Display Options)
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	arianHomeMenu();
}

//((if ArianHealth == 100) && (ArianSDialogue == 5))
private function arianPlot5():void {
	clearOutput();
	arian.health(1);
	output("Before you can say anything, Arian stops you.  \"<i>I've been meaning to ask you something, [pc.name].  I've been feeling a lot better lately; in fact, I may be even better than I was before.</i>\"  Arian blushes.");
	
	output("\n\n\"<i>I wanted to ask you if we could... well... live together?</i>\"  Arian bites [arian.eir] lower lip.");

	output("\n\nYou explain to Arian about the portal, and your mission as the champion - how due to your duties, you cannot just move here and live with [arian.em].");
	
	output("\n\nArian quickly adds, \"<i>Oh... no....  You wouldn't be moving here.  I would be the one moving in with you....");
	if (companionsCount() > 1) output("  There are other people living with you already, so what's one more?  Right?");
	output("</i>\"");
	
	output("\n\nYou ponder [arian.eir] request...  On one hand, having someone who understands magic would be of great help for your quest, and you've come to enjoy Arian's company, but what about Boon and Laika?");
	
	output("\n\n\"<i>I've spoken with them already and I believe they are ready to pursue their magical studies on their own.  They've been caring for me for a long time; I think it's time they lived their lives for themselves.  Besides, we won't be separated for good; I'll come and visit every once in a while.</i>\"  Arian smiles hopefully at you.");
	
	output("\n\nWell... when [arian.ey] puts it that way... what should you do?");
	//ArianSDialogue++;
	IncrementFlag("COC.ARIAN_S_DIALOGUE");
	//[Accept] [Deny]
	clearMenu();
	if(allowFollowers()) addButton(0, "Accept", acceptArianMovingIntoCamp);
	else addDisabledButton(0, "Accept", "Accept", "You can't invite [arian.em] when you have no idea how often you'll be there!");
	addButton(1,"Deny",denyAriansMoveIn);
}

//[=Accept=]
private function acceptArianMovingIntoCamp():void {
	clearOutput();
	output("You tell Arian you'd be delighted to have [arian.em] move in with you.  Arian's face lights up like a kid's who's been given a bucket of candy.  \"<i>Really!?  Great!  I'll pack my stuff and we can go right away!</i>\"");
	
	//(Skip to ‘Invite to Camp')
	clearMenu();
	addButton(0,"Next",inviteArianToCamp);
}

//[=Deny=]
private function denyAriansMoveIn():void {
	clearOutput();
	output("You tell Arian you'd like some time to think about it.  Arian looks disappointed at first, but smiles at you all the same.  \"<i>I understand... no pressure....  So, what are we going to do today?</i>\"");
	
	//(Display Options)
	arianHomeMenu();
}

//Talk
private function talkToArianChoices():void {
	clearOutput();
	output("You tell Arian you'd like to talk to [arian.em].  Arian smiles at the prospect of chatting with you.  \"<i>I love talking with you; so what do you want to talk about?</i>\"");

	clearMenu();
	if (flags["COC.ARIAN_TIMES_SEXED"] > 0) addButton(0,"Sexy Talk",arianSexingTalk);
	if (flags["COC.ARIAN_S_DIALOGUE"] >= 3) addButton(1,"Teach Magic",arianMagicLessons);
	if (!arianFollower() && flags["COC.ARIAN_S_DIALOGUE"] >= 6) {
		if(allowFollowers()) addButton(4, "Invite2Camp", inviteArianToCamp);
		else addDisabledButton(4, "Invite2Camp", "Invite to camp", "You can't invite [arian.em] when you have no idea how often you'll be there!");
	}
	if (int(flags["COC.ARIAN_TIMES_SEXED"]) == 0 && int(flags["COC.ARIAN_S_DIALOGUE"]) < 3) output("\n\n<b>Arian doesn't have much to talk about right now.  Maybe you ought to just visit him from time to time or find him an item that would help combat [arian.eir] sickness.</b>");
	addButton(14,"Back",arianHomeMenu);
}

//Magic:
//Magic Lessons, teaches white magic and increases int. Up to 100.
//Gain a pretty nice boost, 4 lessons per day, only.
private function arianMagicLessons():void {
	clearOutput();
	arian.health(1);
	output("You ask Arian if [arian.ey] wouldn't mind giving you some magic lessons.");
	
	//(if ArianMLesson >= 4)
	if (flags["COC.ARIAN_LESSONS_LAST"] == days) {
		output("\n\nArian raises [arian.eir] hand, stopping you in your tracks.  \"<i>I appreciate your enthusiasm, [pc.name].  But first you must rest and let the lessons of the day sink in.  I promise I'll teach you more tomorrow.</i>\"  Arian smiles at you.");
		
		output("\n\nMaybe [arian.ey]'s right... you tell [arian.em] you'll ask [arian.em] to teach you more tomorrow.");
		processTime(2);
		clearMenu();
		addButton(0, "Next", arianHomeMenu);
		return;
	}
	output("\n\nArian nods.  \"<i>Of course!  Now where do I begin....</i>\"");
	
	if (!pc.hasPerk("Magic Affinity")) pc.createPerk("Magic Affinity", 0, 0, 0, 0, "Grants you insight into mysteries of magic.");
	
	//(else if PC int < 50 //Teach Charge Weapon if PC doesn't know.
	if (pc.intelligence() >= 15 && flags["COC.ARIAN_LESSONS"] == 1) {
		output("\n\nYou tell Arian you've got the fundamentals down, so why not cover something a bit more advanced?");
		output("\n\nArian taps [arian.eir] chin in thought, then smiles.  \"<i>I know!  Let's talk about channeling.</i>\"");
		output("\n\nChanneling? You ask.");
		output("\n\n\"<i>Yes, the art of focusing your spell within a conduit - in short, enchanting objects.</i>\"");
		output("\n\nYou smile and tell Arian this sounds like an interesting subject....");
		output("\n\n\"<i>So remember: don't overcharge your conduit or the results could be disastrous....  Just ask Boon,</i>\" Arian chuckles.");
		output("\n\nYou wonder whatever could have happened that was so funny.  But for the moment the lesson has tired you, so you thank Arian for the lesson and excuse yourself ");
		if (!arianFollower()) output(", making your way back to camp.");
		else output(", exiting [arian.eir] tent and going about your business.");
		
		//(if PC doesn't know Charge Weapon)
		if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_CHARGE) == 0) {
			output("\n\nAs you ");
			if (!pc.isNaga()) output("walk");
			else output("slither");
			output(" away, you start pondering Arian's lesson of the day.  You wonder if you could perhaps apply the channeling principle to strengthen your [pc.mainWeapon] in combat.");
			output("\n\nThat would be very helpful; you'll have to try it sometime.");
			pc.setPerkValue("Magic Affinity", 1, pc.perkv1("Magic Affinity") | KBIT_SPELL_CHARGE);
		}
		if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_CHARGE) == 0) flags["COC.ARIAN_LESSONS"] = 2;
	}
	else if (pc.intelligence() >= 20 && flags["COC.ARIAN_LESSONS"] == 2) {
		//output("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		//Teach Blind if PC doesn't know.
		output("\n\nYou say you have a pretty good understanding of how magic works now, so you'd like [arian.em] to get started on the more complex theories.");
		output("\n\nArian rubs [arian.eir] chin in thought.  \"<i>Hmm.... Aha!  Let's discuss conjuration.  This is where we start getting to the more complex theories and methods.  I know I don't have to say it, but pay attention.  Conjuration is an important art for any mage.</i>\"");
		output("\n\nYou nod as Arian begins lecturing you on the finer points of the art of conjuration.");
		output("\n\nArian wasn't kidding; this is quite a complex subject...");
		output("\n\n\"<i>Now to finish our lesson, I'll give you a practical example of how to effectively use conjuration to defend yourself.  So pay attention, [pc.name].  Conjured objects are generally weaker than real objects, so conjuring a shield or a suit of armor or even a weapon is no good.  Not to mention it's quite complicated.  A suit of armor is made not only of metal, but of other components as well - you'd have to conjure and maintain each individually.  Instead, conjure a simple element that can turn the tide of the battle in your favor.</i>\"");
		//(if PC doesn't know Blind)
		if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_BLIND) == 0) {
			output("\n\nLike what?  You ask in curiosity.");
			output("\n\nArian lifts a closed fist.  \"<i>Mind your eyes.</i>\"  You nod.  Arian points [arian.eir] fist towards a nearby wall and opens [arian.eir] hand.  A bright flash of light shoots out of [arian.eir] hand to hit the wall harmlessly.  \"<i>This was the element of light.  I produced a bright light capable of temporarily blinding whomever happens to be looking at it when it's exposed.</i>\"");
			output("\n\nYou note how such a spell could be useful for you in combat.  Arian grins at you.  \"<i>I'm glad this lesson was helpful, [pc.name].  Come here and I'll teach you how to properly conjure it.</i>\"");
			output("\n\nYou spend a few minutes learning how to properly use the spell, and after some practice you can reliably use the spell whenever you want to.  You thank Arian for the lesson and for teaching you a new spell.  Then bidding farewell to the grinning lizan, you leave, promising to visit [arian.em] again soon.");
			pc.setPerkValue("Magic Affinity", 1, pc.perkv1("Magic Affinity") | KBIT_SPELL_BLIND);
			//Return to camp.
		}
		else {
			output("\n\nYou understand what Arian's talking about.  [arian.ey] means that rather than conjuring a barrier, it's best to conjure something akin to a bright light to try and blind your foe.");
			output("\n\nArian nods pridefully.  \"<i>Very well, [pc.name]!  That's exactly what I mean.</i>\"");
			output("\n\nYou spend a few more minutes talking to Arian before  thanking [arian.em] for the lesson and bidding farewell to the grinning lizan, you promise to visit [arian.em] again soon.");
		}
		if((pc.perkv1("Magic Affinity") & KBIT_SPELL_BLIND) == 0) flags["COC.ARIAN_LESSONS"] = 3;
	}
	else if (pc.intelligence() >= 25 && flags["COC.ARIAN_LESSONS"] == 3) {
		//Teach Whitefire if PC doesn't know.
		//output("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		output("\n\nYou ask Arian if [arian.ey] wouldn't mind hearing some of your own theories about magic; you've been giving the subject a lot of thought lately.");
		output("\n\nArian looks at you, eyes alight with interest at what you have to say.  \"<i>Please, do share your thoughts.</i>\"  You explain that if you are able to use magic to conjure elements, with a little concentration it might also be possible to alter these elements on the fly; you convey the method you theorized to the lizan mage.");
		output("\n\nIf you can conjure elements at will, would it be possible to also alter them?  You could have one element start out as a non-volatile substance within your hands and then hurl it towards a target whilst also focusing upon changing its nature, thus creating an explosive reaction.  For instance, you can start out with a small gathering of dust and quickly change it into a highly combustible element and make it look like as if you made the air explode.");
		output("\n\nOnce you're done, Arian grins at you.  \"<i>That's very good, [pc.name].  Indeed, alteration is another art a mage must master in order to be considered a true master; let me give you a more detailed explanation....</i>\"");
		output("\n\nYou listen attentively to the lizan....");
		output("\n\n\"<i>And that's about it.  There were mages researching this subject at the academy, but then the whole trouble with the demons happened... maybe someday we can resume our research in this area.</i>\"");
		output("\n\nYou let Arian know that this conversation was very interesting; the knowledge [arian.ey] shared with you today is bound to be useful in your adventures.");
		output("\n\nArian grins happily at you.  \"<i>I'm glad to be of use, [pc.name].  Please come back soon; I would love to discuss more of it with you.</i>\"");
		output("\n\nYou thank Arian and promise to return sometime soon.  You excuse yourself and ");
		if (!arianFollower()) output("begin the trek home.");
		else output("exit [arian.eir] tent.");
		//(if PC doesn't know Whitefire)
		if ((pc.perkv1("Magic Affinity") & KBIT_SPELL_WHITEFIRE) == 0) {
			output("\n\nAs you walk, you ponder what you discussed with Arian and conclude that by combining conjuration with alteration, you could quickly and easily create an expanding conflagration of flames, burning your foes in combat.");
			output("\n\nYou should put that into practice sometime soon.");
			pc.setPerkValue("Magic Affinity", 1, pc.perkv1("Magic Affinity") | KBIT_SPELL_WHITEFIRE);
		}
		if((pc.perkv1("Magic Affinity") & KBIT_SPELL_WHITEFIRE) > 0) flags["COC.ARIAN_LESSONS"] = 4;
	}
	//(if PC int < 25) //Basics!
	else {
		output("\n\nYou let Arian know you're actually pretty new to magic in general, so maybe [arian.ey] could teach you a few basics?  Arian nods.  \"<i>Very well...</i>\"  Arian clears [arian.eir] throat.");
		output("\n\n\"<i>The basis of all magic is mental strength, or more appropriately, your willpower - the desire, the wish, the passion to make something that is not... be.  Which is the reason mages study so hard to begin with.</i>\"");
		output("\n\nYou pay attention to Arian's every word, making mental notes of the more important lessons....");
		
		output("\n\n\"<i>And that is all; any questions?</i>\"  Arian patiently awaits your reply.  You sigh, tired after a long lesson on the fundamentals of magic and spellcasting.  You tell Arian that you don't have any questions for now... but you'd like to repeat the lesson some other time.");
		output("\n\nArian smiles at you.  \"<i>Of course, [pc.name].  If you have any doubts or would like me to repeat, all you have to do is ask.  I'll make sure to always have time for you.</i>\"");
		output("\n\nYou thank the lizan for the lesson and ");
		if (!arianFollower()) output("make your way back to your camp.");
		else output("return to your duties.");
		if(int(flags["COC.ARIAN_LESSONS"]) == 0) flags["COC.ARIAN_LESSONS"] = 1;
	}
	flags["COC.ARIAN_LESSONS_LAST"] = days;
	pc.slowStatGain("i", 1);
	if (pc.IQ() < 75) pc.slowStatGain("i", 0.5);
	if (pc.IQ() < 50) pc.slowStatGain("i", 0.5);
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
//Sex:
//Available after the first time you have sex. (ArianVirgin > 0)
private function arianSexingTalk():void {
	clearOutput();
	arian.health(1);
	output("You smirk knowingly at [arian.em] and ask how [arian.ey] feels about sex now that [arian.ey]'s had [arian.eir] first time?");
	
	output("\n\nArian bites [arian.eir] lower lip in embarrassment.  \"<i>I... umm... can't we talk about something else?</i>\"  You shake your head and tell [arian.em] there's nothing to be ashamed of.  The two of you have already shared intimacy after all; and you'd like to know [arian.eir] kinks and wishes as well.");
	output("\n\nArian blushes, and takes a deep breath.  \"<i>Okay....</i>\"");
	//Block about penis. Should only show up if Arian has a cock at all.
	if (arian.hasCock()) {
		//Arian talks about his lack of a second penis.
		if (arian.cockTotal() == 1) {
			output("\n\n\"<i>I've always resented my lack of a second dick,</i>\" Arian admits.");
			output("\n\nReally?");
			output("\n\n\"<i>Well, lizans like me usually have two, and I only have one....  I've always thought I was freakish and usually avoided any kind of sexual contact, not that it was hard to avoid it, since I usually had my muzzle buried in a book.  Maybe I wasn't as social because of that... or... I don't know.  The point is, I never hoped to find someone who'd... you know....</i>\"  Arian fidgets, smiling nervously at you.");
			
			output("\n\nYou smile right back at [arian.em].  You happen to find Arian is adorable, especially when [arian.ey] gets all shy like that.  But if [arian.eir] lack of a matching dick is such a big problem, maybe you could find something in your journey to help [arian.em] remedy that.  Would [arian.ey] like that?");
			output("\n\n\"<i>Oh... I suppose there might be something that can do that.  Although I suppose it doesn't matter that much now.  Unless you'd like me to get a second one?</i>\"");
			output("\n\nYou ponder the idea, but decide that Arian is fine just the way [arian.ey] is; maybe someday though...");
		}
		//Arian has 2 penis, thankful for the PC's help in that department.
		else 
		{ 
			output("\n\n\"<i>I had always resented my lack of a second dick,</i>\" Arian admits.  \"<i>But I guess I don't have to worry about this anymore, thanks to you.</i>\"  Arian smiles at you.");
			output("\n\nYou tell [arian.em] that it was no trouble; double the pleasure, double the fun, right?");
			output("\n\nArian blushes.  \"<i>I guess....</i>\"");
			output("\n\nAlthough... that means [arian.ey]'d have double the work if [arian.ey] intends to masturbate.  \"<i>Umm... why would you say that?</i>\"  Arian asks nervously.");
			output("\n\nYou chuckle, and tell [arian.em] you haven't forgotten that time you caught [arian.em] masturbating.");
			output("\n\nArian laughs nervously.");
		}
		output("\n\nWhat about [arian.eir] size though?  In this world it's quite easy to do something about that, if size is a problem.");
		//Now deal with Cock Sizes, properly.
		//Regular Cock.
		if (arian.biggestCockLength() == ARIAN_COCK_SIZE_1) {
			output("\n\n\"<i>Well, I don't have any complaints, personally.  I feel good no matter what we do.");
			if(arian.cockVirgin) output("  Even if you don't touch me there.");
			output("  But if you want me to grow bigger, or maybe want me to get rid of it... I don't have any objections.</i>\"");
		}
		//Big Cock.
		else if (arian.biggestCockLength() == ARIAN_COCK_SIZE_2) {
			output("\n\n\"<i>I'm certainly a lot bigger than I hoped to ever get.  Sometimes it's a tight fit... in my slit I mean... but I kinda like it, and that also means it'll feel better for you if we... I mean... if you want to...  Not that I mind, I'm happy just being with you.  And if you want to change it somehow... I wouldn't mind.</i>\"");
		}
		 //Huge Cock.
		else if (arian.biggestCockLength() == ARIAN_COCK_SIZE_3) {
			output("\n\n\"<i>It's a lot bigger than I'm comfortable with, to be honest.  But you said you liked it, so I'm keeping it.</i>\"  You see [arian.eir] robes beginning to tent, and can't help but tease the shy lizan.  It seems that despite [arian.eir] complaints, [arian.ey] enjoys having a monster between [arian.eir] legs... one that [arian.ey] can't hope to hide.");
			output("\n\nArian blushes.  \"<i>I... okay, I admit it... it feels pretty good... and is kinda kinky, too... Still, if you think I should be smaller... I wouldn't mind.</i>\"");
		}
		output("\n\nYou tell Arian you'll think about it....");
	}
	//End of Cock Block. Innuendos ahoy!
	//(if ArianVagina > 0) //Talk about Arian's new oviposition perk
	if (arian.hasVagina()) {
		output("\n\nArian sighs and flushes; the distinct smell of an aroused female begins to permeate the room.  That and the lizan's cute fidgeting are a dead giveaway of [arian.eir] current state.");
		output("\n\nArian sighs and licks [arian.eir] lips.  \"<i>I never imagined I would ever turn into a girl... much less that I would know what being a girl is like....  Everything feels different... but not in a bad way... just weird, I guess.</i>\"");
		output("\n\nYou tell [arian.em] that's understandable, and ask how [arian.ey]'s feeling about that.");
		output("\n\n\"<i>I feel sick for no apparent reason.  I have the strangest urges I didn't have.  My chest feels heavy.  And above all else....</i>\"  Arian looks at you and blushes.");
		output("\n\nAnd above all else?  You ask.");
		output("\n\nArian averts [arian.eir] eyes.  \"<i>Just being close to you makes me... hot....</i>\"");
		output("\n\nReaaaally?  You smirk at [arian.em].  Arian flushes even more.  \"<i>T-there's also the eggs... so many eggs....</i>\"");
		output("\n\nEggs?");
		output("\n\n\"<i>Yes, eggs.  Lizan females lay eggs throughout their entire fertile period... I... have to deal with this monthly... and whenever the time to lay comes around I find myself thinking....</i>\"");
		output("\n\nThinking?");
		output("\n\n\"<i>About you.</i>\"  Arian admits.");
		output("\n\nIf that's the case, maybe you should help [arian.em] lay sometime.");
		output("\n\n\"<i>I think, I'd like that... sometime,</i>\" Arian replies.");
		if (arianFollower()) output("\n\nYou tell [arian.em] you'll make sure to stop by when [arian.ey]'s close to laying then.\n\n\"<i>I'll be waiting for you.</i>\"  Arian smiles.");
		else output("\n\nAs much as you'd like that, Boon and Laika, especially, are bound to berate you if they see you leaving [arian.eir] room with an egg in hand.\n\nArian giggles, \"<i>That's true.  Maybe we can find a way to be alone then?</i>\"\n\nMaybe....");
	}
	output("\n\nYou look Arian over, and decide to ask what [arian.eir] preferred form of sex is.");
	//Finally discuss Arian's preferred sex acts. [arian.ey] slowly takes a liking for anal.
	if (arian.analExp() < 33) {
		//No preference... yet.
		output("\n\nArian rubs [arian.eir] chin in thought, but in the end [arian.ey] simply shrugs and says, \"<i>I guess I don't really have a preference... so I'm good with whatever you feel like doing.</i>\"  Arian smiles at you.");
		output("\n\nMaybe [arian.ey]'s not sure yet because you haven't played with [arian.em] enough yet.... Perhaps you should try doing more... stuff?");
		output("\n\nArian smiles nervously at you and slowly nods in agreement.");
	}
	else if (arian.analExp() < 66) { 
		//Kinda like anal, thought it was going to hurt but it feel nice...
		output("\n\nArian rubs [arian.eir] chin in thought.  \"<i>To be honest... ever since you... umm... put it back there....</i>\"  Arian blushes.  \"<i>I've been thinking that anal is not so bad... I was scared that it might hurt at first... and while it does hurt a bit, it also feels nice.</i>\"");
		output("\n\nYou're surprised to hear that.  Not everyone enjoys anal sex.");
		output("\n\nArian averts [arian.eir] eyes.  \"<i>I'm not saying I enjoy it... but I don't mind if it's you....</i>\"");
	}
	//Anal feels good, just as good as any other action if not better
	//(else if (ArianAnalXP <= 100))
	else if (arian.analExp() <= 100) {
		output("\n\nArian blushes.  \"<i>I'm... I like it when you use my ass... it feels really good,</i>\" Arian admits.");
		output("\n\nOh, really?  You ask.  It's rare to find someone who actually enjoys anal sex, much less someone willing to admit it openly.  This is something you certainly didn't expect from the shy lizan.");
		output("\n\nArian bites [arian.eir] lower lip and smiles nervously at you.  \"<i>I guess that makes me a pervert for liking it?</i>\"");
		output("\n\nYou chuckle.  Maybe... considering the things you've seen in this world, you'd be hard pressed to find what kind of rule defines a pervert.  But that doesn't matter; you enjoy using [arian.eir] ass too.  Arian smiles at you.");
	}
	else {
		//Anal is definitely what Arian prefers, although [arian.ey] likes other stuff too, [arian.ey] prefers anal.
		output("\n\nArian blushes and averts [arian.eir] eyes.  \"<i>I can't stop thinking about when you use my ass... it feels really good... and if I had to say if there's anything I like... then it's that.... I hope it feels good for you, too.</i>\"  Arian smiles at you, nervously.");
		output("\n\nThat's... quite forward of [arian.em]... you didn't expect an admission like that.  But you like it; [arian.eir] ass certainly feels good, and you're glad it is pleasurable and that Arian likes it so much.");
		output("\n\nArian takes a glance at your crotch.");
		
		//if PC has no cock)
		if (!pc.hasCock()) {
			output("\n\nBut sighs in disappointment when [arian.ey] sees no bulge.  \"<i>Maybe... you could grow your dick back and... nevermind....</i>\"  Arian averts [arian.eir] eyes.");
			output("\n\nYou tell [arian.em] you'll think about it.");
		}
		else {
			output("\n\n[arian.ey] smiles nervously at you and begins fidgeting.  \"<i>Perhaps... you'd like to... well... use me again?  Please?</i>\" Arian asks hopefully.");
			//[Yes][No]
			clearMenu();
			addButton(0,"Yes",yesYouButtslutIllFuckYou);
			addButton(1,"No",goddamnitNoYouButtSlut);
			return;
		}
	}
	sexTalkFinish();
}

		
//[=Yes=]
private function yesYouButtslutIllFuckYou():void {
	clearOutput();
	output("How could you refuse such a request?  You tell [arian.em] to strip and get ready.");
	output("\n\nArian jumps to the task and eagerly strips, laying down in bed and swaying [arian.eir] tail back and forth as [arian.ey] waits for you to do the same.");
	//(Go to Give Anal)
	clearMenu();
	addButton(0,"Next",giveArianAnal);
}

//[=No=]
private function goddamnitNoYouButtSlut():void {
	clearOutput();
	output("You apologize, but you really can't do that right now.  Arian looks a bit disappointed, but smiles at you all the same.  \"<i>Oh... okay.  Next time then?</i>\"");
	output("\n\nYou nod.");
	sexTalkFinish(false);
}

private function sexTalkFinish(newl:Boolean = false):void {
	if (newl) clearOutput();
	else output("\n\n");
	output("Satisfied with your little chat, you pat the lizan's head and excuse yourself, heading back to camp.");
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Invite to Camp:
//Only available if ArianHealth == 100.
private function inviteArianToCamp():void {
	clearOutput();
	output("You ask the lizan if [arian.ey] still really wants to leave [arian.eir] comfortable home in the city and come out to live with you in your little camp in the wastelands?");
	output("\n\n\"<i>Of course I do!</i>\" Arian says enthusiastically.");
	output("\n\nWell, if [arian.ey] really wants to do that... though why [arian.ey] would want to do that escapes you... [arian.ey] can come and move in.  But [arian.ey] will need to bring [arian.eir] own tent and sleeping bag and stuff like that, you warn the overenthusiastic lizard-");
	if (arian.hasCock()) {
		if (!arian.hasVagina()) output("man");
		else output("herm");
	}
	else output("woman");
	output(".");
	
	output("\n\n\"<i>Great! I'll pack up and we can go right away!</i>\" Arian announces happily.");

	//(Story Dialogue Links here.)
	output("\n\nArian opens a small closet and brings out a pair of small bags.  One of them is tightly closed and seems close to bursting, the other looks completely empty.  Arian takes a few neatly folded spare sets of clothes and gently packs them inside [arian.eir] bag, then turns and walks to [arian.eir] work desk where [arian.ey] picks up a few more trinkets and bags them all.");
	
	output("\n\nHaving done that, Arian grabs both bags in [arian.eir] hands and happily announces, \"<i>All done!</i>\"");
	output("\n\nYou look at the bags skeptically and ask what kind of joke the lizan is trying to pull over you.");
	
	output("\n\nArian looks at you in confusion.  \"<i>Joke?  What do you mean by joke?</i>\"");

	output("\n\n[arian.ey] can't seriously expect you to believe that's all [arian.ey] intends on taking.");
	output("\n\nArian looks at [arian.eir] bags and shrugs.  \"<i>Everything I need is in here.  I packed some stuff in advance, plus a few more clothes and some things I've been working on.  It's really all I need, trust me.</i>\"  Arian smiles.");
	output("\n\nYou sigh softly, and resign yourself to having to come back and fetch the stuff [arian.ey] forgot in a day or so.  You tell [arian.em] to say goodbye to [arian.eir] apprentices; you're leaving now.");
	output("\n\nArian nods and tails you down the stairs towards the entryway.  \"<i>Boon!  Laika!</i>\"  Arian calls.  Within moments the twin ferrets present themselves, and upon seeing the bags in Arian's hands Boon smiles and Laika begins tearing up.");
	output("\n\nArian drops [arian.eir] bags and opens [arian.eir] arms, inviting the twins into a hug, which they happily accept.");
	output("\n\n\"<i>I'm happy for you, " + arian.mf("master","mistress") + ", I really am,</i>\" Boon says.");
	output("\n\n\"<i>Make sure you're taking care of yourself, " + arian.mf("master","mistress") + ".  Don't forget to bathe regularly and eat well... and contact us once in awhile... and visit on the holidays,</i>\" Laika says, sniffing.");
	
	output("\n\nArian smiles at [arian.eir] pupils.  \"<i>I'm not your " + arian.mf("master","mistress") + " anymore.  From now on you're full-fledged mages.  Remember all that you learned, and I'm sure you'll be okay.</i>\"");
	output("\n\nBoon is the first to break the hug, followed shortly by Laika.  The twins then turn to you.");
	
	output("\n\n\"<i>Please, [pc.name], take good care of the " + arian.mf("mas","mis") + "... err... Arian.  [arian.ey] might be a handful sometimes, but [arian.ey]'s a really good person,</i>\" Boon says with a bow.");
	
	output("\n\n\"<i>If " + arian.mf("master","mistress") + "... I mean... if Arian gives you any trouble call us and we'll come running to give [arian.em] a good scolding,</i>\" Laika says with a bow.");
	output("\n\n\"<i>Please don't sic Laika on me!</i>\" Arian pleads.");
	output("\n\nYou smile and laugh softly at the three; they really are just like family, aren't they? You promise that you'll take good care of their teacher and that you'll call them if [arian.ey] needs them to spank [arian.em].");
	
	output("\n\n\"<i>Come on, I'm not that bad, am I?</i>\" Arian protests.  Boon and Laika look at each other, then look at you, wearing expressions identical to your own.  Finally you all nod in unison.  Arian sighs....");
	output("\n\nHaving said your farewells, you begin the long trek back home... bringing with you a new ally (and lover) in tow.");
	clearMenu();
	addButton(0,"Next",takeYerLizardHomePartII);
}

private function takeYerLizardHomePartII():void {
	clearOutput();
	output("Upon arriving at the camp, the first thing Arian notices is the shimmering portal.  \"<i>Is this... where you came from?</i>\" Arian asks.");
	output("\n\nYou nod your head and confirm that, yes, this was your doorway from your world into Mareth.");
	output("\n\n\"<i>I heard that sometimes people from other worlds wandered into Mareth through portals, but I have never seen one up close before.</i>\"  Arian stares deeply at the portal.  \"<i>It's beautiful... and menacing, too.</i>\"  Shaking [arian.em]self out of [arian.eir] reverie, Arian takes an open spot close to your tent.");
	output("\n\n[arian.ey] sets [arian.eir] overfull bag down and asks, \"<i>Is it okay if I stay here?</i>\"");
	output("\n\nYou tell the reptilian wizard that should be fine.  But surely even someone with [arian.eir] scaly hide can't just sleep out in the open on bare earth?");
	output("\n\nArian laughs.  \"<i>Of course not, silly.  I'm going to set up my own tent here.</i>\"");
	output("\n\nTent? You repeat.  You tell [arian.em] that you never saw [arian.em] bring a tent here.");
	output("\n\n\"<i>Oh, I see... you might want to take a step back then,</i>\" Arian warns you with a wry smile.");
	output("\n\nYou wonder what the weird wizard has in mind, but do as [arian.ey] says; you're not stupid enough to ignore a warning like that.");
	output("\n\nArian snaps [arian.eir] fingers and the overfull bag bursts into an explosion of cloth.  You watch in amazement as a rather simple yet sturdy tent erects itself without any help.  It takes only a minute or so until the tent is set up in its appropriate spot, a small tarp covering the opening that leads inside.");
	output("\n\n\"<i>In case you have forgotten, [pc.name], I happen to be a master mage,</i>\" Arian says with a proud smile.");
	output("\n\nYou look at the surprise tent and shake your head.  Truly, you hadn't forgotten... but you didn't know magic could be used for something as mundane as this.  [arian.ey] really surprised you this time.");
	output("\n\nArian slowly walks towards the entrance and holds the tarp for you.  \"<i>Care to take a peek inside?</i>\"  You nod and follow the lizan into the tent.");
	
	output("\n\nAs you walk inside you can't help but gasp in amazement... clearly you have underestimated the lizan.  The inside of the tent is pretty big comparing to the outside, and you see all the tools and facilities one would need to live in the wilderness with relative comfort.");
	
	output("\n\nIn one corner you see what looks like a small kitchen of sorts, complete with a wide assortment of utensils.  In the opposite corner you see a work desk much like the one Arian had set up in [arian.eir] house.  Sitting in the middle of the room is a comfy-looking couch with a small table in front of it.  Further inside you see a comfortable looking bed with a few bookshelves and a small wardrobe sitting nearby.  A soft rug covers the floor of the tent and looking up you see what looks like a small magic lamp, lighting up the whole tent so you can clearly see how comfortable Arian is going to be compared to you");
	if (followersCount() > 1) output(" and your other companions");
	output(".");
	
	output("\n\n\"<i>So what do you think?  Cozy?</i>\" Arian asks.");
	output("\n\nYou tell [arian.em] it looks very cozy indeed. In fact, you jest, you just might bring your sleeping roll in here and sleep with the lizan instead of in your own tent.  Arian averts [arian.eir] eyes and then smiles at you nervously.  \"<i>T-there's no need for you to bring your sleeping bag.... </i>");
	output("<i>If you want to stay in here I'd be happy to share my bed with you.</i>\" ");
	output("\n\nYou tell the lizan it was just a jest... still, you drawl, you'll keep that in mind. Maybe you will drop by some night.");
	
	output("\n\nArian nods.  \"<i>You're always welcome here whenever you want.</i>\"");
	
	output("\n\nYou politely excuse yourself, saying you should let the lizan make [arian.em]self comfortable in [arian.eir] new home, and step back outside.");
	//flag arian as follower
	flags["COC.ARIAN_FOLLOWER"] = 1;
	processTime(55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Sex
//ArianHealth must be at least 20 before you can even pick Sex as an option.
public function arianSexMenu(showOutput:Boolean = true):void {
	if (showOutput) {
		clearOutput();
		output("You ask Arian if [arian.ey] feels strong enough to do a little lovemaking.");
		//(if ArianHealth < 30)
		if (arian.health() < 30) {
			output("\n\nArian smiles nervously at you.  \"<i>I... of course.  I'd love to.  What do you feel like doing?</i>\"");
		}
		else if (arian.health() < 50) {
			output("\n\nArian smiles nervously and averts [arian.eir] eyes.  \"<i>Of course.  I want to learn more about you: your body, your thoughts, everything.  So... what do you want to do?</i>\"");
		}
		//(if ArianHealth < 75)
		else if (arian.health() < 75) {
			output("\n\nArian smiles and averts [arian.eir] eyes.  \"<i>I would love to.  This isn't just thanks for my gift is it?</i>\"");
			output("\n\nYou assure [arian.em] that's not the case; you just feel in the mood.");
			output("\n\nArian looks at you happily.  \"<i>Okay... what do you feel like doing?</i>\"");
		}
		//(if ArianHealth < 100)
		else if (arian.health() < 100) {
			output("\n\nArian smiles tenderly at you.  \"<i>I always have enough strength for lovemaking, [pc.name].  What do you feel like doing?</i>\"");
		}
		//(if ArianHealth == 100) //Also used for follower Arian.
		else {
			output("\n\nArian smiles and strokes your [pc.face].  \"<i>Do you even need to ask?</i>\"");
		}
		output("\n\nYou smile at your lizan lover and begin shedding your [pc.gear].  Arian follows in suit, settling down on [arian.eir] bed and watching you enraptured as [arian.ey] awaits your decision.  Once you're naked, much to the lizan's delight, you smile at [arian.em] and consider your options....");
	}
	//(Display Options)
	clearMenu();
	addDisabledButton(0, "Anal - Pitch", "Anal - Pitch", "This scene requires you to have fitting cock.");
	addDisabledButton(1, "Anal - Catch", "Anal - Catch", "This scene requires Arian to have cock.");
	addDisabledButton(2, "Get Blown", "Get Blown", "This scene requires you to have cock.");
	addDisabledButton(3, "Blow " + arian.mf("Him","Her"), "Blow " + arian.mf("Him","Her"), "This scene requires Arian to have cock.");
	addDisabledButton(4, "Fuck Vagina", "Fuck Vagina", "This scene requires you to have fitting cock and Arian to have vagina.");
	addDisabledButton(5, "Get Fucked", "Get Fucked", "This scene requires you to have vagina and Arian to have cock.");
	addDisabledButton(6, "Dildo Fun", "Dildo Fun", "This scene requires both you and Arian to have vagina.");
	addDisabledButton(7, "Docking", "Docking", "This scene requires both you and Arian to have not overly large cocks.");
	addDisabledButton(8, "Double Pen", "Double Pen", "This scene requires you to have two fitting cocks and Arian to have vagina.");
	
	if (pc.hasCock()) {
		//PC must have a cock that fits (cock area 50 or less)
		if (pc.cockThatFits(arian.analCapacity()) >= 0) addButton(0,"Anal - Pitch",giveArianAnal);
		//Get Blown:
		//PC must have a cock.
		addButton(2,"Get Blown",getBlownByArian);
		//Penetrate:
		//Arian must be herm/female.
		//PC must have a cock that fits (cock area 50 or less)
		if (pc.cockThatFits(arian.vaginalCapacity()) >= 0 && arian.hasVagina()) 
			addButton(4,"Fuck Vagina",penetrateArian);
		//Double Pen Arian:
		//PC must have at least 2 cocks that fit. That means two cocks with a cock area of <= 50.
		//This isn't meant to give AnalXP, but given the fact that Arian's ass will get pen'd it would also be justified. Up to you Fen!
		if (pc.cockThatFits(arian.analCapacity()) >= 0 && pc.cockThatFits2(arian.vaginalCapacity()) >= 0 && arian.hasVagina()) addButton(8,"Double Pen",doublePenetrateArian);
		//Docking
		//ArianCockSize needs to be below 3. (ArianDblCock does not affect this decision.) 
		//PC cock area must be <= 30.
		if (pc.cockThatFits(cockVolume(30)) >= 0 && arian.biggestCockLength() < ARIAN_COCK_SIZE_3 && arian.hasCock()) addButton(7,"Docking",arianDocking);
	}
	//Get Anal:
	//Arian must have a cock.
	if (arian.hasCock()) addButton(1,"Anal - Catch",getButtWreckedByArian);
	//Blow:
	//Arian must have a cock.
	if (arian.hasCock()) addButton(3,"Blow " + arian.mf("Him","Her"),suckAriansDick);
	
	//PC must have a vagina.
	if (pc.hasVagina()) {
		//Get Penetrated:
		//Arian must have a cock.
		if (arian.hasCock()) addButton(5,"Get Fucked",getPenetratedByArianAndHisHitlerMustache);
		if (arian.hasVagina() && (pc.hasKeyItem("Dildo") || pc.hasKeyItem("Deluxe Dildo"))) {
			addButton(6,"Dildo Fun",arianDildoFun);
		}
	}
	addButton(14,"Back",arianHomeMenu);
}

//Give Anal:
//Modified by AnalXP.
//PC must have a cock that fits (cock area 50 or less)
private function giveArianAnal():void {
	var x:int = pc.cockThatFits(arian.analCapacity());
	clearOutput();
	arian.health(3);
	
	arian.analExp(10);
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	
	//if (arian.mf("m", "f") == "f")
		//output(images.showImage("arianfemale-home-giveArianAnal"));
	//else	
		//output(images.showImage("arianmale-home-giveArianAnal"));
	
	// This breaks the capacity-restriction, but it's a quickfix to make the scene stop crashing in lieu of writing new 
	// content to work around the player not being able to call this scene from earlier interactions with Arian.
	if (x == -1)
	{
		x = pc.smallestCockIndex();
	}
		
	output("You tell Arian that, if [arian.ey]'s willing, you'd like to take [arian.em] from behind.");
	//AnalXP < 33
	//Tight, sensitive enough to orgasm. (It hurts... but feels good)
	if (arian.analExp() < 33) {
		output("\n\n[arian.Ey] fidgets, biting [arian.eir] lower lip.  \"<i>I... okay.  J - Just be gentle, ok?  I'm still tight back there.</i>\"  Arian hesitantly rolls onto [arian.eir] hands and knees, lifting [arian.eir] tail out of the way to give you a glimpse of [arian.eir] puckered hole.");
		output("\n\nYou promise [arian.em] that you will, sidling yourself onto [arian.eir] bed behind [arian.em].  You reach out with one hand and stroke the base of [arian.eir] tail, gently admiring its cool, smooth-textured surface before running your hand down to rub across [arian.eir] asscheeks.  Mmm... [arian.ey] has a very nice ass, you tell [arian.em], groping [arian.em] in an effort to display your admiration for the lush, full, surprisingly soft cheeks.  Yes, for someone who was born male, [arian.ey] truly has a wonderful ass, so deliciously full and round and soft.");
		//(if ArianVagina < 1)
		if (!arian.hasVagina()) {
			output("\n\n\"<i>I - I can't help it, I was born this way... that isn't a bad thing is it?</i>\" Arian asks, fidgeting and shuddering as you stroke [arian.eir] behind.  From [arian.eir] tone, it's clear that [arian.ey]'s torn between being flattered and being embarrassed at your evident approval of [arian.eir] butt.  You don't bother answering [arian.eir] question, instead you just firmly grip [arian.eir] scaly buttcheek, eliciting a gasp from the flustered lizan.");
		}
		else {
			output("\n\n\"<i>Y - Yes... I was born like this... and being a ");
			if (!arian.hasCock()) output("girl");
			else output("herm");
			output(" isn't going to make it any smaller either.</i>\"  Arian fidgets and shudders as you stroke [arian.eir] behind.");
		}
		output("\n\nYou tell [arian.em] that you don't know why [arian.ey] was born with it, but you certainly appreciate it.  Your wandering eyes close in on ");
		if (arian.hasVagina()) {
			output("the puffy lips of [arian.eir] drooling vagina");
			if (arian.hasCock()) output(" and ");
		}
		if (arian.hasCock()) {
			output(arian.mf("his","her") + " erecting ");
			if (arian.cockTotal() > 1) output("pair of reptilian pricks");
			else output("reptilian prick");
		}
		output(".  Oh, someone's excited about this.  Why, you almost half expect [arian.eir] ass to start drooling like a pussy, [arian.ey]'s obviously that turned on by the idea of you fucking [arian.eir] ass.  You emphasize your point by gently worming one probing finger into the virgin-like tightness of [arian.eir] anus.  Wow, [arian.ey]'s so tight....");
		
		output("\n\n\"<i>Ow!  B-be gentle... please,</i>\" Arian protests, but despite that you feel [arian.em] gently pushing against your intruding digit.  You tell [arian.em] that you'll try, but [arian.ey] is making this hard on you; [arian.ey]'s so eager for you to start fucking [arian.eir] ass, isn't [arian.ey]?  It's hard to control yourself when [arian.ey]'s just begging for it.  You gently grind your [pc.cock] under the base of [arian.eir] tail, in between [arian.eir] girly asscheeks, to emphasize your point.");
		
		output("\n\n\"<i>I... yes....  I-I want it, too.  It's going to hurt, but I want it.... I-I want you to do it,</i>\" Arian admits, burying [arian.eir] face in the covers in an attempt to hide [arian.eir] shameless admission.  [arian.ey] braces [arian.em]self, holding [arian.eir] pillow tightly in [arian.eir] clawed hands and bracing [arian.em]self for the next step.");
		
		output("\n\nYou begin jerking yourself off, using slow, careful strokes to bring precum dribbling from your cock, smearing it across your shaft in an effort to lube it for your lizan lover.  Finally deciding you've made yourself slick enough, unable to resist making your move, you take hold of [arian.eir] butt for support and begin pushing your [pc.cock " + x + "] against [arian.eir] virginal back door.  Arian lets out a girly yelp and [arian.eir] sphincter suddenly clenches up, halting your entry.  You ask what's wrong.");
		output("\n\n\"<i>N-nothing... you just surprised me... that's all.</i>\"  Even though [arian.ey]'s not admitting it, you can tell that Arian is very tense.  You lean over the nervous lizan and envelop [arian.em] in a soft hug, telling [arian.em] it's okay; you're not going to hurt [arian.em], you're going to make [arian.em] feel very good, but first [arian.ey] needs to relax or this will be painful when it shouldn't be.");
		
		output("\n\nArian sighs and relaxes, loosening [arian.eir] sphincter enough to allow an easier penetration.  You don't risk delaying any more and promptly, but carefully, slide yourself into [arian.em] before [arian.ey] can tense up again.  Damn, but [arian.ey]'s so tight back here!  You have to push hard to make any progress, and it takes a lot of care to ensure you don't hurt the lizan in your press to penetrate [arian.eir] bowels.  \"<i>Ah!  It's in!</i>\"  Arian shudders, struggling to remain relaxed while you plow into [arian.eir] depths.  Finally, after a few more careful thrusts, you feel yourself bottom out in your shuddering lizan lover.");
		
		pc.cockChange(true, true);
		arian.buttChange(pc.cockVolume(x), true, true, true);
		
		output("\n\nArian trembles and moans in pained pleasure as [arian.ey] finally feels your [pc.hips] resting flush against [arian.eir] backside.  [arian.ey] pants in obvious pleasure as [arian.eir] watertight little rosebud adjusts to your girth and length.  \"<i>H-how does it feel?  G-good?</i>\"");
		
		output("\n\nYou tell [arian.em] that it feels wonderful; [arian.ey]'s so tight and firm back here... to be honest, [arian.ey]'s almost too tight; you can feel [arian.eir] heartbeat with every involuntary contraction of [arian.eir] anal walls, squeezing your cock like it's trying to wring it off and swallow it.  Arian chuckles.  \"<i>I'm not going to lie, [pc.name].  It hurts, but it also feels good.  I think... maybe you should start moving?</i>\"");
		
		output("\n\nOh, and suddenly [arian.ey]'s an expert on this, hmm?  You agree [arian.ey] has a point.  You start to withdraw yourself from [arian.em], fighting against the squeezing walls and intense suction all the way, then painstakingly pushing yourself back in, worming your way in inch by inch until you have plunged yourself all the way into [arian.eir] depths, only to start again.  Arian moans and groans with each movement.  \"<i>It's starting to feel good now... really good.  Don't stop.</i>\"");
		
		output("\n\nTime fades away as you continue to squeeze your shaft in and out of Arian's tight, delicious little ass.  Soon - all too soon - the unmistakable feeling of orgasm starts boiling up from ");
		if (pc.balls == 0) output("the base of your cock");
		else output("the bottom of your balls");
		output(" and you warn Arian that you're going to cum inside [arian.em] if you keep going.  Arian drools in pained pleasure, for a moment you wonder if [arian.ey] even heard you.  \"<i>Cum.  Cum inside me.  I want it... all of it! Ah!</i>\"");
		
		output("\n\nYou groan and cry out as you promptly fulfill [arian.eir] request.");
		
		//(Low Cum Amount)
		if (pc.cumQ() < 250) {
			output("\n\nEven though your load might pale in comparison to other creatures native to Mareth, you have no doubt that you're more than enough to fill Arian's tight ass flush with [pc.cumNoun].  You unload inside [arian.em] with short, controlled thrusts.");
		}
		//(Medium Cum Amount)
		else if (pc.cumQ() < 1000) {
			output("\n\nYou begin dumping your prodigious amount of [pc.cum] inside your willing lizan lover.  The more you unload into [arian.eir] tight ass the more pleasurable [arian.eir] slick muscle spasms feel, milking you for more and more [pc.cumNoun], such a lewd little hole this puckered rosebud of Arian's.  You sigh as [arian.eir] belly inflates and some of your spent seed begins dripping from around Arian's little hole.");
		}
		//(High Cum Amount)
		else {
			output("\n\nFor a moment you hesitate....  Arian is clearly inexperienced and you know your load is nothing if not enormous; you worry if the inexperienced lizan will be able to handle you, but your worries are soon forgotten; it's much too late to worry about it now.  Your spunk jets inside the moaning lizan like a fire hose, dowsing both your and [arian.eir] flames of lust with its immense output of [pc.cumColor], [pc.cumVisc] goodness.  Arian's belly protrudes like a gravid woman's belly - no, actually, it's even wider, and yet the lizan's lewd little hole never tires as it milks you, even though by now Arian is beyond full - copious amounts of [pc.cumNoun] leak from around your " + pc.cockDescript(x) + " as [arian.eir] ass fails to contain it all.");
		}
		output("\n\nYour orgasm triggers the lizan's own, and [arian.ey] bites into the pillow, groaning with ecstasy as [arian.ey] cums [arian.em]self, ");
		if (arian.hasCock()) output("spewing forth large gobs of cum of [arian.eir] own");
		if (arian.hasCock() && arian.hasVagina()) output(" and ");
		if (arian.hasVagina()) output("wetting both your and [arian.eir] legs with a healthy serving of lizan pussy juice");
		output(".  You shudder and gasp until, utterly spent, you can't resist sinking down atop Arian and bearing [arian.em] into the comforting embrace of the bed.  You lay there, recovering your strength from your most delightful exertions, wriggling to give the lizan a proper snuggling while you lay there.");
		
		output("\n\nArian pants tiredly.  \"<i>[pc.name], was I any good?</i>\" [arian.ey] asks hopefully.");
		
		output("\n\nYou tell [arian.em] that [arian.ey] was wonderful, though you can't resist a wry smirk and a note that [arian.ey] was wonderful for an amateur.  With a little practice though, well....");
		
		output("\n\nArian turns [arian.eir] head to look at you with a tired, but happy smile.  \"<i>I'm glad you liked it.  It hurt, and I'll probably be sore later.... But it was worth it.  I liked it....</i>\"  Then [arian.ey] laughs.  \"<i>If all I need is some practice, I'm hoping you will help me with that?</i>\"");
		
		output("\n\nYou laugh and reply that you'll consider it, but right now you're quite sated, thank you.  \"<i>Great....</i>\"  Arian's maw opens into a huge, lazy yawn.  \"<i>I think I'll take a nap now....</i>\"");
		output("\n\nYou pat the lizan playfully on the head and tell [arian.em] to get some rest.  You watch as [arian.ey] settles down to sleep off the excitement of your sex, then carefully redress yourself and leave [arian.em] to rest.");
		//PC returns to camp menu
	}
	//AnalXP < 66
	//Loose, sensitive enough to make Arian scream in pleasure. (It's like a tight vagina, feels like one too, minor pain)
	else if (arian.analExp() < 66) {
		output("\n\n[arian.Ey] fidgets, smiling at you nervously.  \"<i>Okay, but don't be too rough.  I might have gotten a bit used to it, but you're still capable of giving me quite a stretch.</i>\"  Arian rolls onto [arian.eir] hands and knees, tail waving excitedly as you catch a glimpse of [arian.eir] stretched hole.  [arian.ey] looks back at you, shooting you [arian.eir] best seductive look and wiggling [arian.eir] hips side to side.");
		output("\n\nYou smile at [arian.em] and gently stroke [arian.eir] swaying tail.  Arian sighs and lays down on the bed, reaching behind with [arian.eir] hands to spread [arian.eir] buttcheeks apart for you; [arian.eir] tail strokes your side lovingly.  Your hands reach down and gently bat [arian.eir] hands away, then begin to caress [arian.eir] luxurious ass, even as you tell [arian.em] that [arian.ey]'s got a very sexy rear and you're going to enjoy fucking [arian.eir] back passage oh so very much.");
		output("\n\nArian raises [arian.eir] behind, giving you better access, then looks at you with a glimmer in [arian.eir] eyes.  \"<i>I'm going to enjoy this, too.</i>\"");
		
		output("\n\nYou slick your fingers up with some saliva, noisily smacking your tongue around the digits to make it as lewd as possible, and then gently start to probe at Arian's black pucker, seeking entry in an effort to gauge how stretched [arian.ey] is.  Your digits slide in easily enough, meeting only a token resistance as you slowly invade Arian's bowels.\n\n\"<i>Ah... this feels good....</i>\"\n\nYou raise an eyebrow, though you know [arian.ey] can't really see you from this position, and ask if [arian.ey]'s really getting to be such a buttslut that even this feels good?");
		output("\n\nArian turns as much as [arian.ey] can to look at you.  \"<i>Lizan females have assholes that are as sensitive as vaginas to accommodate their mate's dual penises.</i>\"  [arian.ey] stops [arian.eir] explanation momentarily to moan in pleasure as you begin stroking [arian.eir] insides.");
		//(if ArianVagina < 1)
		if (!arian.hasVagina()) {
			output("\n\n\"<i>This shouldn't apply to me, since I'm male.  Ah!  But I guess I'm starting to develop some sensitivity back there.  It really feels good... hmm....</i>\"");
			output("\n\nYou smile and comment that you wouldn't be surprised; if it's natural for [arian.eir] kind to enjoy taking it up the ass, well, it makes sense that a male would quickly grow to like it, too... especially with all the practice the two of you have been doing....");
		}
		else {
			output("\n\n\"<i>This didn't apply to me, since I was originally male.  Ah!  B-but I guess since I'm a girl now, I'm starting to develop some sensitivity back there.  It really feels good....  Hmm....</i>\"");
			output("\n\nYou smile and comment that since [arian.ey]'s a girl now, should [arian.eir] ass have gotten the sensitivity boost by default if that's the case?");
			output("\n\n\"<i>I don't know... maybe so... but then again, lizan females don't have these either,</i>\"  Arian replies, lifting herself off the mattress to show you [arian.eir]");

			if (arian.breastRows[0].breastRatingRaw <= ARIAN_BREASTS_SIZE_1) output(" perky");
			else if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_2) output(" rounded");
			else output(" pillowy");
			output(" mounds.");
			
			output("\n\nYou can't resist sneaking an admiring grope of the lizan's presented bosom, admitting that gaining breasts in exchange for anal affinity sounds like a fair trade, but you aren't complaining about Arian's bust either.  Arian gasps and drops chest-first onto the bed.  \"<i>They are sensitive, too.</i>\"  Arian smiles nervously at you.");
		}
		output("\n\nYou sneak a probing hand under and up between Arian's legs.  Oh ho!  You grin as");
		if (arian.hasCock()) {
			output(" a");
			if (arian.cockTotal() > 1) output(" pair of dripping cocks");
			else output(" dripping cock");
			if (arian.hasVagina()) output(" and");
		}
		if (arian.hasVagina()) output(" a sopping wet pussy");
		output(" greet");
		if ((!arian.hasVagina() && arian.cockTotal() < 2) || (arian.hasVagina() && !arian.hasCock())) output("s");
		output(" your touch.  What a little slut Arian is turning into; [arian.ey]'s already raring to go, and even knowing it's going to be [arian.eir] ass that's getting fucked, too!");
		
		output("\n\nArian pants and moans.  \"<i>[pc.name], please. Stop teasing me.  I want you.</i>\"  [arian.ey] looks back at you with eyes full of desire.  [arian.Ey] humps against your intruding fingers in [arian.eir] ass in obvious excitement.");
		
		output("\n\nWell, if [arian.ey]'s that eager to get started....  You deliver a playful slap on [arian.eir] ass, which ripples delightfully at the impact and sends a crack echoing through the lizan's ");
		if (arianFollower()) output("tent");
		else output("bedchamber");
		output(".  You sink your fingers into the smoothly scaled skin of [arian.eir] butt, and promptly thrust your " + pc.cockDescript(x) + " into [arian.eir] back passage; not with the gentleness you showed Arian as an anal virgin, but not with brutal force, either.  The practice the lizan's had with pleasuring your cock with [arian.eir] ass is obvious - you slide in as if it's been lubed, with what little resistance it poses quickly giving way under the insistent pressure of your thrusts.  It's not as painfully tight as it was, the looseness letting you move more freely without fear of hurting your lover, but at the same time it grips you like a well-trained pussy, holding you deliciously tight and eagerly sucking you into its depths.");
		
		pc.cockChange(true, true);
		arian.buttChange(pc.cockVolume(x), true, true, true);
		
		output("\n\nArian moans lewdly at your intrusion.  \"<i>Ah, I can feel you inside me.  I love this feeling... so full....  Do you like my ass, [pc.name]?  Does it feel good when you use me like this?</i>\"");
		
		output("\n\nYes, you hiss, yes it feels good... does [arian.ey] really enjoy this so much?  You never stop your thrusts, relentlessly pounding into [arian.eir] greedy little ");
		if (!arian.hasVagina()) output("boypussy");
		else output("nether-pussy");
		output(".  \"<i>Yesssss.... Oh, sometimes it hurts a bit, but the feeling, the pleasure, the pain.... It's heavenly.</i>\"");
		output("\n\nSmiling wryly, you lean over Arian's back and whisper into [arian.eir] ear, that if [arian.ey] likes this so much... you'll just have to fuck [arian.em] more.  Having said that, you quicken your pace, drawing a pleasured, shuddering moan from your lizan lover.  \"<i>Ah!  [pc.name]!  If you keep this up you're going to make me - Ah!</i>\"  Make [arian.em] what now?  \"<i>C-cuuuuum~</i>\"");
		
		output("\n\nArian's ass tightens around your " + pc.cockDescript(x) + " as [arian.eir] ");
		if (arian.hasCock()) {
			if (arian.cockTotal() < 2) output("cock spews its load");
			else output("twin cocks spew their loads");
			output(" on the bedsheets");
			if (arian.hasVagina()) output(" and [arian.eir] ");
		}
		if (arian.hasVagina()) output(" contracting pussy paints your lower body with lizan femcum");
		output(".  Arian is only capable of moaning and shuddering as [arian.eir] powerful orgasm rocks the poor lizan to [arian.eir] core.  The extra tightness of [arian.eir] contracting butthole increases the friction on your " + pc.cockDescript(x) + ", pushing you ever closer to the climax.");
		
		output("\n\nSeeing no point in holding back yourself, you cry out as you give yourself over to the feeling of climax, orgasm ripping its way through you from the ");
		if (pc.balls == 0) output("base of your spine");
		else output("depths of your balls");
		output(".  Arian, completely blissed out, lays limply on [arian.eir] bed, [arian.eir] butt held up by your gripping hands.  With a final deep thrust you finally go over the edge.");
		
		//(Low Cum Amount)
		if (pc.cumQ() < 250) output("\n\nYou pump Arian's insides with as much [pc.cumNoun] as you can muster, filling [arian.em] with your liquid love while the lizan gasps, moans, and grips you tightly with [arian.eir] distended sphincter.  You are quickly spent though, and after a couple more tugs, you feel the lizan's contracting rosebud relax to let you pull out of [arian.eir] depths.");
		//(Medium Cum Amount)
		else if (pc.cumQ() < 1000) output("\n\nArian's butt feels so good that you can't help but paint it in white.  Gob after gob of searing hot [pc.cumNoun] flows from your [pc.cockHead " + x + "] and into the lizan's willing bowels.  You can't help but continue thrusting inside [arian.eir] deliciously slick insides, even as Arian's distended sphincter tries its best to hold you in place.  By the time you're done, Arian looks like [arian.ey]'s three months pregnant; after a few final thrusts, you're confident you've given [arian.em] all that you can muster for the moment and pull out of the lizan's hungry ass.");
		//(High Cum Amount)
		else {
			output("\n\nYou bury yourself as deep as you can into the lizan's behind and brace yourself, holding onto [arian.eir] hips as the first of many jets of cum finally escapes your throbbing " + pc.cockDescript(x) + ".  You can feel the groaning lizan shudder with each blast that you pump into [arian.eir] inviting interior; each of your [pc.cumVisc] ropes of [pc.cumNoun] filling [arian.em] up until [arian.eir] belly looks as big as a beach ball.  Arian's contracted sphincter tries its best to hold your prodigious load in, but it can't hope to contain it all; soon [pc.cumColor] jism explodes from around the seal of your cock.  Trails of your pleasure run down the lizan's legs to soak the bedsheets along with the lizan's own fluids.  One final jet pushes Arian off your shaft, and you gaze at the messy results of your recent activities.");
		}
		
		output("\n\nFor a moment you admire your handiwork, but all too soon the exhaustion of your recent tryst catches up to you and you collapse atop the lizan, almost as blissed out as [arian.ey] is....");
		
		output("\n\n\"<i>That... that was the best, [pc.name].  I never hoped that sex could feel this good,</i>\" Arian remarks between pants.  Arian rolls around, looking at you with a smiling face, then yawns widely, displaying [arian.eir] sharp teeth to you.  \"<i>So sleepy... could use a nap now....</i>\"");
		
		output("\n\nYou smile and pet the lizan's head, telling [arian.em] that you wish you could understand how a talking lizard could be just so adorable.  You watch [arian.em] as [arian.ey] drifts off to sleep, then quietly slide from [arian.eir] bed, get dressed and leave the ");
		if (!arianFollower()) output("room");
		else output("tent");
		output(".");
	}
	//AnalXP <= 100
	//Very Loose, sensitive enough to make Arian cum just from insertion. (Feels better than anything else. Yep, Arian really becomes a buttslut at this point)
	else {
		output("\n\n[arian.Ey] fidgets and moans as [arian.ey] eagerly rolls onto [arian.eir] hands and knees, lifting [arian.eir] tail out of the way and spreading [arian.eir] cheeks to give you a glimpse of [arian.eir] throbbing, loose, puckered hole.  Arian pants and looks back at you in excitement.  \"<i>I'm all ready for you, [pc.name].  Just go ahead and fill me up.</i>\"  [arian.Ey] grins at you.  It's clear to see that Arian likes the idea of being taken, but there really is no need to rush... you'd rather savor this, plus teasing your eager lizan lover is always a bonus.");
		
		output("\n\nYou smirk fiercely and ask teasingly if this is really the proud, independent mage Arian lying before you with [arian.eir] tail in the air and [arian.eir] ass up, a buttslut yearning and anxious to be fucked like an animal.  Arian looks back at you, pleadingly.  \"<i>Aww, come on, don't tease me.  Can't you see how much I need this?</i>\"");
		
		output("\n\nHow much does [arian.ey] need it, you ask?  Enough to beg for it, like the little buttslut [arian.ey] is, hmm?  If [arian.ey] can convince you [arian.ey] wants it enough, you'll give it to [arian.em], you tell [arian.em].  Arian's tail encircles your waist, and pulls you towards [arian.eir] quivering rosebud.  \"<i>Come on... fill me up.  I'm so hot it feels like I'm on fire!  Fill me up, please?</i>\"");
		
		output("\n\nWhat a naughty, naughty little buttslut [arian.ey] is, you croon, and deliver a playful slap to [arian.eir] ass, before squeezing the luscious round buttock, fingers creeping into [arian.eir] crevice to probe at [arian.eir] back passage.  To your surprise, the slight pressure you're exerting makes [arian.eir] orifice ripple and flex; [arian.ey]'s trained [arian.eir] ass so well [arian.ey] can even try to deliberately grab you with it and suck you in.");
		
		output("\n\nArian moans and bucks against your fingers, eager to get more of you inside.  \"<i>Ah... yessss... more...</i>\"  [arian.ey] groans.  Looking under [arian.em], you can see that [arian.eir] ");
		if (arian.hasVagina()) output("wet gash is positively leaking lizan juices");
		if (arian.hasVagina() && arian.hasCock()) output(" and [arian.eir] ");
		if (arian.hasCock()) output("erect cock is already leaking pre like a sieve");
		output(".  You can hardly believe how far Arian has come; you ask [arian.em] if it really feels that good?  \"<i>More than you can... ah... imagine, now fill me up!</i>\" [arian.ey] demands with a sense of urgency.");
		
		output("\n\nSeeing no reason to delay any longer, and figuring [arian.ey] must be well-trained enough now that you don't need to be gentle, you promptly extract your fingers from the lizan's greedy ass and then slam your shaft home in one fierce thrust, asking if this is what [arian.ey] wanted.");
		
		pc.cockChange(true, true);
		arian.buttChange(pc.cockVolume(x), true, true, true);
		
		output("\n\nArian gasps and opens [arian.eir] maw in a silent scream.  [arian.eir] ass contracts, milking you; ");
		if (arian.hasVagina()) output("[arian.eir] pussy clenches, spilling a flood of juices; ");
		if (arian.hasVagina() && arian.hasCock()) output(" and ");
		if (arian.hasCock()) output("his cock throbs and shoots rope after rope of cum onto the bedsheets");
		output(". Overwhelmed by your sudden intrusion, Arian collapses forward, burying [arian.eir] face on [arian.eir] pillow and dragging you on top of [arian.em].  \"<i>Ah... [pc.name], you feel so good.  It's amazing.  I never thought buttsex could ever feel this good.</i>\"");
		
		output("\n\nYou almost blink in surprise; you were just throwing the term buttslut around as a joke, you didn't think Arian was really like that.  Still, there are far more important matters - like digging your way into the depths of Arian's greedy little ass with your " + pc.cockDescript(x) + "!  You squeeze the lizan's scaly butt and begin to rut [arian.em] like an animal, thrusting your way in and out of [arian.eir] back passage with all the eagerness you can muster.");
		
		output("\n\nArian screams in pleasure, muffled by [arian.eir] pillow.  [arian.eir] ass strives to pull you in as far as you can go, contracting, milking, gripping; even though Arian's just climaxed, you can see [arian.eir] ");
		if (arian.hasCock()) {
			if (arian.cockTotal() > 1) output("cocks are still rock hard, and surprisingly, still leaking ropes of cum");
			else output("cock is still rock hard, and surprisingly, still leaking ropes of cum");
			if (arian.hasVagina()) output(", and [arian.eir]");
		}
		if (arian.hasVagina()) output(" pussy squirting juices against your [pc.legs] with each shuddering impact of your [pc.hips]");
		output(".  \"<i>Ah!  Yes!  More, give me more!  Harder!  Faster!</i>\" Arian pleads, before biting on [arian.eir] pillow in pleasure.");
		
		output("\n\nYou see no reason not to give it to [arian.em] how [arian.ey] wants, and keep thrusting - it's surprisingly difficult to pull out, though, as the lizan's hungry nethers keep trying to stubbornly hold you in.  Greedily [arian.eir] inner walls ripple and flex, caressing and squeezing in an effort to milk you into giving up your precious seed.");
		
		output("\n\nYou can feel the pressure on [arian.eir] sphincter increasing and guess Arian must be close to another orgasm; you're not very far yourself, and if [arian.ey] keeps squeezing and massaging your " + pc.cockDescript(x) + " like this, you feel you'll blow any moment now.  Before you finally reach the inevitable abyss of your orgasm, you decide to lean over [arian.em], hugging [arian.eir] midriff just so you can pound [arian.em] harder.  It's surprising that Arian only seems to be feeling pleasure, others would be screaming in pain with how rough you're being, yet Arian bucks back against you with all [arian.eir] might, trying to get you deeper.  You ask [arian.em] if [arian.ey]'s really okay, if it doesn't hurt [arian.em] even a bit?");
		
		output("\n\n\"<i>No! Ah, yes!  Cum inside me, [pc.name]!  I need your seed inside my naughty ass.  I need to feel you filling me up, using me like the buttslut I am!  I want to cum with you!</i>\"  You lift a brow, of all the people you know, Arian is the last one you'd expect to hear this from... what would [arian.eir] apprentices say if they heard their " + arian.mf("master","mistress") + " begging to be used like that?  \"<i>Ah... I don't care, just fill me up with your hot, slimy spunk!</i>\"  It would seem the lizan mage is too far gone to give you a straight answer.  You'll have to talk to [arian.em] after this.");
		
		output("\n\nWith that in mind, you give yourself over to the pleasures of your reptilian lover and [arian.eir] naughty little ass, allowing the building orgasm to finally reach its climax and boil from your body in a gush of [pc.cumFlavor] spooge.");
		
		//(Low Cum amount)
		if (pc.cumQ() < 250) {
			output("\n\nYou spill your load, deep into Arian's bowels, [arian.eir] ass working overtime to ensure not even a single drop of seed is left in you.  \"<i>Ah!  I can feel it!  Yes!</i>\"  [arian.ey] screams, in ecstasy.  Gob after gob of [pc.cum] travels down your urethra and into Arian's blooming rosebud, you almost feel bad when you run dry and are unable to give [arian.em] anymore; even as [arian.eir] ass continues to impatiently milk you. \"<i>...Aww. No more?</i>\" [arian.ey] jokes.");
		}
		//(Medium Cum amount)
		else if (pc.cumQ() < 1000) {
			output("\n\nYou dig deep into [arian.eir] ass, intent on delivering your load as far inside the lizan's slutty ass as you can.  \"<i>Ah!  You feel so good!  Give it to me!  Yesss!</i>\" [arian.ey] screams in ecstasy.  You can feel your [pc.cum] travelling down your urethra, forcing Arian's sphincter to loosen up enough so you can finally cum inside [arian.em] with the force of hose.  You reach down to massage the blissed out lizan's belly, feeling it inflate and expand with each potent jet.  By the time you're done, Arian has formed a small pot belly.  \"<i>Already over?  No more?</i>\"  [arian.ey] jokes.  You give [arian.em] a wry smile and pound into [arian.em] one last time, spilling one last jet into [arian.eir] belly.  \"<i>Aaaah, yesss...</i>\"");
		}
		//(High Cum amount)
		else {
			output("\n\nYou have no doubt Arian will appreciate your prodigious load, so you make sure to press as deep as you can into [arian.eir] ass to ensure [arian.ey] will keep it all inside, then finally let your [pc.cum] flow out of you and into the cock and cum hungry ass, eagerly massaging your shaft.  \"<i>I can feel it!  It's going to be a big one!  Shoot it!</i>\" [arian.ey] screams in ecstasy.  You groan and begin dumping obscene amounts of seed into your lizan lover.  The first few jets inflate [arian.eir] belly slightly, and you dart a hand to feel it expand with every subsequent blast of [pc.cumVisc] jism.  \"<i>So much cum!  So good... more!</i>\"  Arian demands, blissed out by your pumping appendage.  [arian.eir] ass never stops its assault on your " + pc.cockDescript(x) + " intent on massaging you as you orgasm, even as you fill Arian beyond full and some [pc.cum] begins backflowing out of [arian.eir] ass.  \"<i>Hmm, yesss... so full....</i>\"  You pound into [arian.em] a few more times, ensuring you spill every last drop of [pc.cumNoun].");
		}
		output("\n\nPleased and pleasured, Arian holds you still with [arian.eir] tail and rolls around on [arian.eir] back, your dick still buried inside [arian.em].  You gasp with the sudden friction and fall on top of the lizan, just in time to receive a kiss from your lizan lover.  [arian.ey] grips you with both [arian.eir] hands and legs, then finally quakes as [arian.eir] second orgasm overtakes [arian.em].");
		if (arian.hasVagina()) {
			output("  [arian.eir] cunt grips the air and blasts one last jet of wetness at your crotch.");
		}
		if (arian.hasCock()) output("  [arian.eir] throbbing cock flexes and shoots one last rope of lizan-cum against your belly.");
		output("  [arian.eir] ass grips you forcefully, forming a vacuum and finally loosens.  \"<i>That... that wash da best,</i>\"  Arian slurs, before finally collapsing on [arian.eir] bed.");
		
		output("\n\nYou find yourself collapsing on top of the collapsed lizan, heaving to regain your breath after such a vigorous fuck.  Finally, you regain sufficient energy to pull yourself free of the absent-minded sucking of [arian.eir] ass, which wetly slurps shut afterwards to hold your seed inside.  \"<i>I feel so empty when you're not inside,</i>\" Arian utters tiredly.");
		
		//(ArianAssChat == 0)
		if (int(flags["COC.ARIAN_ASS_CHAT"]) == 0) {
			output("\n\nYou shake your head slowly in disbelief, telling Arian [arian.ey]'s really let [arian.em]self go.  Arian averts [arian.eir] gaze in embarrassment.  \"<i>I... sorry.  It's just that it feels so good, and I can't... sorry.</i>\"  [arian.ey] looks away, moving [arian.eir] tail into [arian.eir] hands. You sigh softly and stroke [arian.eir] scaly face, telling him it's not a bad thing that [arian.ey] enjoys himself, it's just you're surprised at how \"<i>into it</i>\" [arian.ey] gets.  [arian.ey] doesn't need to debase himself for you, this is supposed to be good for both of you.");
			
			output("\n\n\"<i>I... I'm not really trying to debase myself.  I guess I lose a bit of control when it comes to anal, because it really feels that good for me.  You're not mad at for being like that... for liking being fucked from behind.  Are you?</i>\"");
			
			output("\n\nYou tell [arian.em] you certainly aren't; you were just making sure that [arian.ey] was really enjoying himself, that [arian.ey]'s not under the conception [arian.ey] has to act that way for you to do this to [arian.em].  Arian breaths a sigh of relief.  \"<i>No, I... sorry if my being like that offends you.  I thought you enjoyed it too, since you were teasing me, but maybe I should change?</i>\"");
			
			output("\n\nYou shake your head; [arian.ey] is who [arian.ey] is, and you're quite comfortable with it.  If you really didn't enjoy playing with [arian.em] like that, well, you'd stop sexing [arian.eir] ass, wouldn't you?  Arian bites [arian.eir] lower lip and smiles nervously at you. \"<i>So, you like my ass?</i>\"");
			
			output("\n\nYes.  Yes you do, you declare.  \"<i>Good, because I like you in my ass, so I don't have to change?</i>\"");
			
			output("\n\nYou still have to confess it was a shock that someone as respectable as Arian is would get so enthusiastically into anal - and on the receiving end, no less - but you don't want [arian.em] to change just for your sake.");
			
			output("\n\n\"<i>This is all new to me.  I'd never been with anyone before you came, so there is no problem if I act like... well, like that?  Because I could change if it really bothers you...</i>\"");
			

			output("\n\nNo, there's nothing about [arian.eir] behavior you want to change");
			//(any physical TFs made to Arian:
			if (9999 == 9999) output(" as hypocritical as that may be");
			output("... besides, you think [arian.ey]'s kind of sexy when [arian.ey] gets like that.  At that Arian perks up.  \"<i>Really?</i>\"  Yes, really, you reply.  Arian smiles happily at you.  \"<i>So... do you want to go again?</i>\"");
			
			output("\n\nYou chuckle. Not right this moment, no, you tell [arian.em]; the two of you just had a pretty intense session, you need a few moments to recover; besides that you have other matters that need your attention.  Arian looks down in disappointment, pouting.  Now, now, there's no need for that, you can always have some fun another time.  \"<i>All right then... see you later?</i>\"  You nod.  \"<i>Ok... I'll be waiting.</i>\"");
			
			output("\n\nYou promptly gather your clothes and quietly make your way ");
			if (!arianFollower()) output("back to Tel'Adre's streets, and from there back to camp.");
			else output("out of [arian.eir] tent.");
			flags["COC.ARIAN_ASS_CHAT"] = 1;
		}
		else {
			output("\n\nYou pat Arian gently on [arian.eir] ass and comment playfully that [arian.ey] is such an unabashed buttslut, isn't [arian.ey]?  Still, did [arian.ey] get enough cock up [arian.eir] ass for a while?");
			
			output("\n\nArian smiles wryly at you.  \"<i>I guess I've got enough to hold me for a while now, but I could always use another dose.</i>\"");
			
			output("\n\nWell, this greedy little lizard of yours will have to wait until you're ready.  But if [arian.ey]'s good, maybe you'll come back later, you tell [arian.em], playfully tapping [arian.em] on the snout for emphasis.  \"<i>Okay, I'll be waiting.</i>\"  [arian.ey] grins happily.");
			output("\n\nSmiling back at [arian.em] you gather your clothes and quietly make your way ");
			if (!arianFollower()) output("back to Tel'Adre's streets, and from there back to camp.");
			else output("out of [arian.eir] tent.");
		}
	}
	//dynStats("sen", -2);
	processTime(arianFollower() ? 35 : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Get Blown:
//PC must have a cock.
private function getBlownByArian():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//if (arian.mf("m", "f") == "f")
		//output(images.showImage("arianfemale-home-getbj"));	
	//else	
		//output(images.showImage("arianmale-home-getbj"));
	output("You trail your hand down your belly, pondering what to do.  Arian doesn't seem to notice, instead staring with anticipation at your erection.  You idly swing your hips from side to side, and notice with amusement that the lizan seems to follow it.  Building on that train of thought, you ask if [arian.ey] would be willing to suck you off.");
	
	//(if ArianHasBlown == 0)
	if (int(flags["COC.ARIAN_HAS_BLOWN"]) == 0) {
		output("\n\nThe lizan averts [arian.eir] eyes, snapping out of [arian.eir] reverie.");
		if (arian.longestCockLength() == ARIAN_COCK_SIZE_3) output("  You notice Arian's exposed shaft slowly hardening at your invitation.");
		output("  \"<i>I... Can I really?</i>\"");
		
		output("\n\nYou smile and note [arian.ey] almost sounds eager to do that, though you admonish [arian.em] to be careful; it's a sensitive body part and, while you don't doubt [arian.eir] affections, that doesn't make [arian.eir] teeth any less sharp.");
		
		output("\n\nArian nods eagerly.  \"<i>I promise I will be careful.  I wouldn't dream of hurting you, [pc.name].</i>\"  You nod in return, and tell the lizan that you'll trust [arian.em], settling on [arian.eir] bed and giving [arian.em] full access to what's between your [pc.legs].");
	}
	else {
		output("\n\nThe lizan smiles at you and licks [arian.eir] lips.  \"<i>I would love to!</i>\" [arian.ey] replies eagerly.  You smile and remind [arian.em] to be careful with [arian.eir] teeth.");
		
		output("\n\nArian acknowledges your concern by nodding emphatically.  \"<i>Sure, I would never hurt you, [pc.name].</i>\"");
		
		output("\n\nSatisfied with [arian.eir] reply, tell [arian.em] you'll trust [arian.em] and settle on [arian.eir] bed and giving [arian.em] full access to what's between your legs.");
	}
	
	output("\n\nArian rolls on top of you and reaches for your [pc.cock " + pc.biggestCockIndex() + "], caressing it almost reverently.  Looking at Arian's face, you see [arian.em] eyeing your cock up and down, sizing it up.  Arian looks at you and smiles; then without breaking eye contact [arian.ey] extends [arian.eir] tongue to lick at your [pc.cockHead " + pc.biggestCockIndex() + "] and slowly take your cock in, careful to purse [arian.eir] lips so [arian.eir] teeth won't hurt you.");
	
	output("\n\nYou shudder in pleasure at the sensation; the interior of Arian's mouth is warmer than you expected, but smooth in texture and silky soft.  Something long and wet wriggles around your [pc.cock " + pc.biggestCockIndex() + "]; for a heartbeat, you'd almost think it's a slimy snake, but then logic hits and you realize it's Arian's long, prehensile tongue, which [arian.ey] is using to coil around and entangle your intruding shaft.");
	
	output("\n\nWith one powerful slurp, Arian coaxes a small jet of pre out of your [pc.cock " + pc.biggestCockIndex() + "], which Arian is only too happy to drink down, moaning at the first taste of your seed; this in turn sends wonderful vibrations along your length, coaxing even more pre into Arian's hungry maw.");
	
	//(If ArianHasBlown == 0)
	if (int(flags["COC.ARIAN_HAS_BLOWN"]) == 0) {
		output("\n\nAs you gasp in pleasure, you cannot help but wonder when did Arian get so skillful with [arian.eir] mouth; you thought [arian.ey] said [arian.ey] was a virgin before you came along.");
		output("\n\nYou ask if Arian's sure [arian.ey] was a virgin until [arian.ey] met you.");
		output("\n\nArian lets go of your cock, kissing its [pc.cockHead " + pc.biggestCockIndex() + "] before replying, \"<i>Yes, I'm sure... but I practiced a lot on myself...</i>\"");
	
		output("\n\nOn [arian.em]self?!  You blurt out; just how flexible is [arian.ey]?!");
		
		output("\n\nArian smiles nervously and bites [arian.eir] lower lip.  \"<i>I'm a mage, remember?  There's a lot of things you can do with magic, but this isn't about me, [pc.name].  It's about you... so let me show you what I learned.</i>\"  Arian plants a kiss on your [pc.cockHead " + pc.biggestCockIndex() + "] before slowly wrapping around it with [arian.eir] tongue and sucking you right back into [arian.eir] cock-hungry maw.");
		
		output("\n\nYou moan, agreeing that, yes, this is far more important.");
	}
	else {
		output("\n\nAs you gasp in pleasure, you cannot help but ask if Arian's been practicing by [arian.em]self while you were away.");
		output("\n\nArian lets go of your cock, kissing its [pc.cockHead " + pc.biggestCockIndex() + "] before replying, \"<i>No, I don't need to practice on myself anymore.  I got you to help with that now, right?</i>\"  Arian plants a kiss on your [pc.cock " + pc.biggestCockIndex() + "], before slowly wrapping it around [arian.eir] tongue and sucking you right back into [arian.eir] cock-hungry maw.");
		output("\n\nYou moan and tell [arian.em] that as long as [arian.ey] keeps giving you great head, you're more than happy to help [arian.em] practice.");
	}
	
	output("\n\nYou thrust your [pc.cock " + pc.biggestCockIndex() + "] as deeply into the lizan's eager little mouth as [arian.ey] will let you... oooh, what would they say, if they could see a proud spellcaster like [arian.em] sucking you off like this?");
	
	output("\n\nArian doesn't bother replying, not that [arian.ey] could with a mouthful of cock.  [arian.ey] braces [arian.em]self on your [pc.hips] and begins truly blowing you; intent on draining you of your seed with strong, wet, slurping sucks that resound from the small cracks of the lizan's maw not filled with your [pc.cock " + pc.biggestCockIndex() + "].");
	
	output("\n\nYou groan and gasp and hump the lizan's face for all you're worth.  You can feel the familiar pressure of seed building up deep inside you, sparks of pleasure becoming the budding crescendo of orgasm, and you wonder if you should warn Arian of what's coming...");
	
	output("\n\nArian never slows down, even as [arian.ey] looks up to you, trying to catch a glimpse of your face to make sure [arian.ey]'s pleasuring you well.  When your eyes meet, you swear you can see the lizan mage smiling at you, even thought [arian.eir] mouthful of cock prevents you from catching a good glimpse of [arian.eir] face.  [arian.ey] moans with delight as you take hold of [arian.eir] head and begin guiding [arian.em].");
	
	output("\n\nWith a few last huffs and gasps, it finally comes.  Orgasm rips through your flesh and sends your cum cascading from out of your [pc.cock " + pc.biggestCockIndex() + "] into Arian's suckling mouth - no point worrying about whether or not [arian.ey] wants it in the mouth now, it's here and [arian.ey]'ll just have to deal with it.");
	
	output("\n\nArian is surprised when the first jet of [pc.cumNoun] hits [arian.em] straight in [arian.eir] throat, but never stops sucking.  Somehow Arian manages to drink your cum as fast as you can pump it into [arian.eir] eager maw; by the time you're done, Arian has developed a ");
	if (pc.cumQ() < 250) output("small");
	else if (pc.cumQ() < 1500) output("big");
	else output("huge");
	output(" pot belly.  [arian.ey] lets go of your dick with a sigh of pleasure and lays back on the bed.  \"<i>Ah... I'm full.</i>\"");
	
	output("\n\nYou tell [arian.em] that [arian.ey] looks full");
	if (pc.cumQ() >= 1500) output(", in fact, you're amazed [arian.ey] didn't pop with how much [arian.ey] drank");
	output("; is [arian.ey] sure [arian.ey]'s all right?");
	
	output("\n\nArian yawns, revealing [arian.eir] toothy maw.  \"<i>Yes, I just need a nap.</i>\"  You chuckle and tell [arian.em] that [arian.ey] should at least get under the covers.  \"<i>Too... tired to bother.</i>\"  Arian replies with a second yawn.  Seeing no reason not to be gallant, you step forward and help Arian climb to [arian.eir] feet");
	if (pc.cumQ() >= 1000) output(" which, considering the fact [arian.ey] looks like a mother ready to birth a toddler from the size of [arian.eir] belly, isn't as easy as you'd think");
	output(".  Letting the lizan use your shoulder, you pull [arian.eir] sheets up and help [arian.em] back in the bed, where [arian.ey] flops down with a protest of springs");
	if (pc.cumQ() >= 250) output(", [arian.eir] gut audibly sloshing as the cum inside is churned by the impact");
	output(".");
	
	output("\n\n\"<i>Thanks, [pc.name].</i>\"  Arian yawns once more and closes [arian.eir] eyes.  You smile and give the sleeping lizan an affectionate pat on the head; then dress yourself and make your way");
	if (!arianFollower()) output(" back to camp, stopping only to notify Laika and Boon that Arian is sleeping.");
	else output(" out of Arian's tent.");
	IncrementFlag("COC.ARIAN_HAS_BLOWN");
	processTime(arianFollower() ? 35 : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Penetrate:
//Arian must be herm/female.
//PC must have a cock that fits (cock area 50 or less)
private function penetrateArian():void {
	var x:int = pc.cockThatFits(arian.vaginalCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);

	//output(images.showImage("arianfemale-home-penetrate"));
	output("You admire the transgendered lizan's body, from [arian.eir] feminized features, down past [arian.eir] [arian.chest], all the way to [arian.eir] shapely thighs.  You tell Arian that the change looks very good on [arian.em]; few boys would really be so naturally pretty when turned into a ");
	if (arian.hasCock()) output(arian.mf("maleherm.", "dickgirl."));
	else output("girl.");
	
	output("\n\nArian smiles and averts [arian.eir] eyes, rubbing one arm.  \"<i>You really think so?</i>\"  [arian.ey] bites [arian.eir] lower lip in nervousness.");
	
	output("\n\nYou nod your head, insisting that you do think so.  With a lustful purr, you ask just how [arian.ey] would like to try out [arian.eir] girl parts, maybe see just how pretty [arian.ey] can feel with the right... encouragement?");
	
	output("\n\n\"<i>Of course!  I would love it.  So what should I do?</i>\" [arian.ey] asks, tail waving lazily behind [arian.eir] as [arian.ey] awaits further instructions.  \"<i>Should I help you get ready first?</i>\"  [arian.ey] looks down between your legs to see your half-erect cock");
	if (pc.cockTotal() > 1) output("s");
	output(".  \"<i>Err... readier?</i>\"  [arian.ey] asks, smiling nervously.");
	
	output("\n\nYou smile, and tell [arian.em] that, seeing as how this is fairly new to [arian.em], you'll try and let [arian.em] take charge.  You sashay over to [arian.eir] bed and lay down on your back, [pc.eachCock] jutting proudly into the air, before telling Arian you want [arian.em] to straddle you.");
	
	output("\n\nArian nods, [arian.eir] liquid lust dropping over your [pc.legs] as [arian.ey] straddles you");
	if (arian.longestCockLength() == ARIAN_COCK_SIZE_3) {
		output(", [arian.eir] exposed cock");
		if (arian.cockTotal() > 1) output("s");
		output(" hardening at what [arian.ey]'s about to do");
	}
	else if (arian.hasCock()) {
		output(", [arian.eir] bulbous cock");
		if (arian.cockTotal() > 1) output("s peeking out of their");
		else output(" peeking out of its");
		output(" hiding place, already at full mast in anticipation");
	}
	output(".  Arian swallows audibly.  \"<i>What now?</i>\" [arian.ey] asks, already panting in lust.");
	
	output("\n\nYou gently reach up and take hold of the lizan's hips, telling [arian.em] that first, you need to connect, slowly guiding [arian.em] down, feeling [arian.eir] all-too-human folds parting around the tip of your cock.");
	
	output("\n\nArian moans and tries to speed things up by impaling herself on [pc.oneCock], but the pleasure of the insertion makes [arian.em] lose [arian.eir] balance and [arian.ey] falls face down on your [pc.chest].  \"<i>Ah!  S-sorry!</i>\"  [arian.ey] smiles nervously at you.");
	
	output("\n\nYou smile at [arian.em] and pat [arian.em] on the cheek, telling [arian.em] to take it easy; there's no need to rush this.  With painstaking deliberation, you continue gently inserting yourself into the ");
	if (!arian.hasCock()) output("female");
	else output("herm");
	output(" lizan, until you have managed to hilt yourself inside of [arian.em].");
	
	pc.cockChange(true, true);
	arian.cuntChange(0, pc.cockVolume(x), true, true, true);

	output("\n\nArian shudders, rubbing [arian.eir] stretched pussy lips against your groin.  \"<i>This feels so good.  I never thought I'd ever feel something like this.  Your cock is filling me up, and I love it.  I can feel everything... every little twitch, every little vein, the texture... everything.</i>\"");
	
	output("\n\nYou whisper to [arian.em] that the best is yet to come, and then start to slowly buck your hips up and down, gradually increasing the tempo, murmuring in pleasure as you feel [arian.eir] slick, wet netherlips hungrily kissing you in response.");
	
	output("\n\nArian moans throatily, gyrating [arian.eir] hips against your intruding shaft, until [arian.ey] starts to slowly rise and fall, trying [arian.eir] best to keep up with your rhythm.  \"<i>So wet... I'm so wet, and the sounds!  I feel so hot... sexy... wanted.  Oh, [pc.name] fuck me!  Take me!</i>\" [arian.ey] says, supporting herself on either side of your head, looking down at you with half-lidded, lust-driven eyes, panting hotly down at you as [arian.ey] bucks [arian.eir] hips against your thrusts.");
	if (arian.hasCock()) {
		output("  [arian.eir] ");
		if (arian.cockTotal() > 1) output("twin shafts");
		else output("shaft");
		output(" bobbing just out of your field of vision, leaking pre all over your belly.");
	}
	output("\n\nYou smile at the lizan, who is clearly adjusting to [arian.eir] new gender with aplomb, and procede to pick up the pace, trying to match the increasing tempo of [arian.eir] thrusts and ensure [arian.ey] enjoys herself as much as possible.  It's no sacrifice, after all, especially given the way [arian.eir] cunt is sucking hungrily on your cock, grinding with walls that ripple harder and harder as you thrust into [arian.eir] more and more vigorously.");
	
	output("\n\nArian smiles down at you, licking [arian.eir] lips.  \"<i>[pc.name], please,</i>\" [arian.ey] moans throatily, half to show [arian.ey]'s paying attention, half from pleasure. \"<i>My breasts... please?</i>\"  [arian.ey] asks, panting, never stopping [arian.eir] bucking against you.");
	output("\n\nYou unthinkingly reach up and take the lizan's [arian.breastCup] bosom in your hands, caressing the small, cherry-like nubs of [arian.eir] nipples, caressing the so-so-smooth scales that cover it, creating a texture at once alien and erotic.  Arian sighs in pleasure as you continue to massage [arian.eir] breasts.  \"<i>Do you like them?  My breasts?  Does it feel weird that I have breasts, despite being a lizan?</i>\"  You hoarsely whisper to [arian.eir] that you love them, and while it was strange at first, there's certainly many odder things about this world, and you think they're part of [arian.eir] natural charms.");
	
	output("\n\nArian moans appreciatively and grinds [arian.eir] hips against you.  \"<i>I'm so happy to hear you say that; you really know how to make a girl feel appreciated.</i>\"  You note that it feels a little strange to hear Arian so easily referring to \"<i>herself</i>\" as a girl.  Arian fidgets and averts [arian.eir] eyes.  \"<i>I-I can't help it.  When you're buried in my pussy I just... feel girly - pretty.</i>\"  That might be because [arian.ey] is so very pretty, you can't resist saying, even as you continue to thrust into [arian.eir].  \"<i>Oh [pc.name]... F-fuck me.  Make me feel beautiful!  Make me cum!  I want you to fuck me as hard as you can.  Please....</i>\"");

	output("\n\nYou promise [arian.em] you will, but with [arian.eir] on top, you can't really exert that much control.  Swinging [arian.eir] tail to the side along with [arian.eir] body, Arian quickly rolls over, never breaking contact, nor stopping bucking against you, even as [arian.eir] legs close behind you and [arian.ey] loops [arian.eir] arms around your neck.  [arian.ey] looks up at you, panting, with half-lidded eyes, then [arian.ey] smiles.  \"<i>What about now?</i>\"");
	if (arian.hasCock()) {
		output("  [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s twitch as they spurt ");
		else output(" twitches as it spurts ");
		output("a small rope of pre over [arian.eir] belly, anticipating what's to come as [arian.ey] braces herself for the inevitable pounding you're about to give [arian.em].");
	}
	output("\n\nNow, you tell [arian.em], you can really start, and you do your best to live up to your promise, pounding [arian.em] as hard and fast as you can, without being so rough that you hurt [arian.em] in the process.  \"<i>Ahm... yesssss... so good.  Fuck me raw!  Oh!  Paint my walls with your hot cum!</i>\"");
	
	output("\n\nArian has quite the dirty mouth on [arian.em], you manage to joke, even as you pound [arian.em] with all you have.");
	output("\n\n\"<i>That's... Ah!</i>\"  Arian's words catch in [arian.eir] throat, and instead [arian.ey] moans, \"<i>J-just cum!  Please!  I need it!</i>\"");
	
	output("\n\nWell, it's rude to cum before a " + arian.mf("maleherm", "lady") + ", so you're not giving in, not until [arian.ey] cums first, you manage to gasp, though in truth you're struggling to keep from blowing.  \"<i>Oh!  Cum!  Cum with meeeee!</i>\"");
	
	output("\n\n");
	if (arian.hasCock()) {
		output("Arian's ");
		if (arian.cockTotal() > 1) output("twin cocks throb");
		else output("cock throbs");
		output(" as [arian.ey] splashes [arian.eir] [arian.chest] and face with [arian.eir] own futa-lizan seed.  ");
	}
	output("[arian.eir] walls grip you tightly, almost painfully, as a flood of juices hit the [pc.cockHead " + x + "] of your " + pc.cockDescript(x) + " with the force of a tidal wave, only to spill around [arian.em] spread nethers and run down your lower body.  [arian.eir] sopping wet pussy works overtime, trying its best to pull you in as deep as possible, intent on sucking all the cum out of ");
	if (pc.balls == 0) output("you");
	else output("your [pc.balls]");
	output(".");
	
	output("\n\nFinally having kept your promise, you give yourself over to the inevitable. ");
	if (pc.hasVagina()) output(" A wash of fluids spills down your body from your cunt as it spasms in release and y");
	else output("Y");
	output("ou unleash your essence right into the lizan's burning womb.");
	
	//(Low Cum amount)
	if (pc.cumQ() < 250) {
		output("\n\nArian's pussy is clamping down so hard on your dick, that you can feel it as the [pc.cumNoun] stretches your urethra, gathering at the tip, and exploding outwards.  Contracting walls carrying the seed deep into the awaiting womb that lies beyond.  You hug the shuddering lizan tightly as you thrust against [arian.em] a few more times, delivering the last few ropes of [pc.cum] and collapsing atop [arian.em].");
	}
	//(Medium Cum amount)
	else if (pc.cumQ() < 1000) {
		output("\n\nYou forcible stretch Arian's wet pussy with the sheer volume of the load traversing your cum-sleeve.  You imagine yourself, covering the lizan's canal in [pc.cumColor]... all the way to [arian.eir] cervix.  The weak barrier barely containing the enormous load that forces it open, to spatter and sit inside [arian.eir] womb.  \"<i>Ahh... so full,</i>\" Arian says, tongue lolling out.  You hug [arian.em] tightly against you, an action [arian.ey] happy to return, and slowly you feel it.  [arian.eir] slender belly gains volume, sloshing with the [pc.cumNoun] you just deposited in it.  Once spent, you collapse and sigh.");
	}
	//(High Cum amount)
	else {
		output("\n\nYou threaten to blow the poor lizan straight off your " + pc.cockDescript(x) + " with the sheer force of your [pc.cumNoun].  Hosing down [arian.eir] walls to the point [arian.ey] can't hope to contain all of your powerful jets, you draw [arian.em] close, and Arian groans, returning the gesture with a tight hug of [arian.eir] own.  \"<i>Ugh, my belly... so much... so good,</i>\" [arian.ey] moans, and you continue to torment [arian.eir] body with your prodigious load.  The sheets under the two of you have since turned into a wet mess of mixed juices, covering both of your lower bodies in the aftermath of you tryst; and it's not until you thrust into [arian.em] a couple more times, to ensure you're completely spent, that you collapse on top of [arian.em], slightly propped up by the protruding, pregnant-looking belly you've given [arian.em].");
	}
	
	output("\n\n\"<i>Aaahhhh...</i>\"  Arian sighs.  \"<i>Sex... feels so good.</i>\"  Caressing the back of your head, [arian.ey] gently pulls you into a quick kiss.  \"<i>If this is how it'll feel every time we do this, then I have no regrets about turning into a girl,</i>\" [arian.ey] says, one hand snaking it's way between the two of you to rub [arian.eir] ");
	if (pc.cumQ() < 250) output("lean");
	else if (pc.cumQ() < 1000) output("full");
	else output("overfilled");
	output(" belly.  \"<i>Stay with me, like this, a little longer?</i>\" Arian asks.");
	
	output("\n\nYou take [arian.eir] free hand in your own and tell [arian.em] that, if [arian.ey] wants you to, you can stay for at least a little while longer.  \"<i>I'd like that... just a while.</i>\"  Arian does [arian.em] best to nuzzle you.  With no compelling reason not to, you nuzzle [arian.em] back and content yourself with laying there, enjoying the mutual afterglow.");
	
	output("\n\nEventually, though, you announce that you should probably get going.  As nice as it is to stay here with [arian.em], you have duties to attend to.  Arian smiles at you, and gives you a little peck on the lips.  \"<i>I understand, but come see me again soon, please.</i>\"  You promise [arian.em] you will and extract yourself from the affectionate lizan's embrace.  You quickly find your clothes and get dressed, then leave.");
	
	//arian.loadInAss(pc);
	processTime(arianFollower() ? 35 : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Get Anal:
//Arian must have a cock.
private function getButtWreckedByArian():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//if (arian.hasVagina())	
		//output(images.showImage("arianfemale-home-getArianAnal"));	
	//else	
		//output(images.showImage("arianmale-home-getArianAnal"));
	
	output("With a lick of your lips with your tongue, you ask how Arian would like to be on the pitching end of anal?");
	//(if AnalXP < 33)
	if (arian.analExp() < 33) output("\n\n\"<i>I don't know... won't it hurt, are you sure?</i>\"");
	//(if AnalXP < 66)
	else if (arian.analExp() < 66) output("\n\n\"<i>I like it when you use my ass, but if you want me to use yours, I would gladly comply.  That is, if you're sure you want me to...?</i>\"");
	//(if AnalXP <= 100)
	else output("\n\n\"<i>I really love it when you fill me up, and personally I'd prefer we do it that way, but if you're really sure you want me to, I'll try and make you feel as good as you feel inside me.</i>\"");
	
	output("\n\nYou smile seductively and nod, telling [arian.em] that you're sure you want [arian.em] to do you that way.");
	
	output("\n\n\"<i>Okay, then.  How should we do this?  I don't want to do something wrong and end up hurting you...</i>\"");
	
	output("\n\nYou smirk and reach out a hand to caress the lizan's [arian.chest], stage-whispering to [arian.em] that [arian.ey] just needs to lie down on [arian.eir] bed and you'll take care of things from there...");
	
	output("\n\nArian swallow audibly, but complies.  Slowly [arian.ey] lets [arian.em]self fall back onto [arian.eir] bed, fidgeting as [arian.eir] ");
	if (arian.biggestCockLength() == ARIAN_COCK_SIZE_3) {
		output("exposed cock");
		if (arian.cockTotal() > 1) output("s harden");
		else output(" hardens");
		output(" to full mast.");
	}
	else {
		output(arian.mf("his","her") + " cock");
		if (arian.cockTotal() > 1) output("s peek out of their");
		else output(" peeks out of its");
		output(" hiding place, rising to full mast.");
	}
	
	output("\n\nYou sashay yourself towards the prone lizan, straddling [arian.eir] legs and reaching out to grasp [arian.eir] ");
	if (arian.cockTotal() > 1) output("primary ");
	output("cock.  Slowly and gently you begin to stroke its strange, knobbly surface, your fingers eliciting moans and gasps from Arian as [arian.ey] shudders under your touch.  Precum begins to ooze from the reptilian prick's head, and you purposefully rub it into [arian.eir] shaft as a kind of makeshift lubricant.");
	
	output("\n\n\"<i>Ohm... T-this feels great, [pc.name], b-but if you keep this up, I won't be able to hold back!</i>\" Arian pants, [arian.eir] shaft");
	if (arian.cockTotal() > 1) output("s");
	output(" throbbing against your hands.");
	
	output("\n\nWell, that would be a shame; it might be a little rough, but you'll have to make do with what you've got.  With that in mind, you cease your stroking, and start sliding yourself up Arian's body, until your [pc.ass] is positioned above [arian.eir] jutting prick.  With slow, deliberate motions, you slowly start to impale yourself upon it...");
	
	arian.cockChange(true, true);
	pc.buttChange(arian.biggestCockVolume(), true, true, false);
	
	output("\n\n\"<i>Argh!  T-this is too much!</i>\"  With a groan of pleasure Arian shoots [arian.eir] cum into your bowels, lubricating it enough to allow you to easily slide down onto [arian.eir] shaft.");
	if (arian.cockTotal() > 1) {
		output("  [arian.eir] other shaft twiches and sprays your ");
		if (!pc.hasTail()) output("back");
		else output("[pc.tails]");
		output(".");
	}
	
	output("\n\nYou sigh and cluck your tongue; Arian really needs to work on [arian.eir] stamina - [arian.ey] loses [arian.em]self to the pleasure too easily, which you gently point out to [arian.em].");
	
	output("\n\n\"<i>S-sorry...</i>\"  Well, it can't be helped.  You'll just have to try again some other time... \"<i>No!  Wait!</i>\"  Arian grabs your hips.  \"<i>I-I can still go on!</i>\"  Really?  Because you're pretty sure you can feel [arian.em] going soft right this instant...  \"<i>Y-yes... just give me a moment.</i>\"");
	
	output("\n\nArian looks up at you, panting; [arian.eir] hands begin roaming your body, caressing your [pc.hips], your [pc.butt], your [pc.chest].  For a moment, you actually feel [arian.eir] bulbous shaft throb within you, but maybe [arian.ey] needs a little push to make things go faster?  You smirk.");
	
	output("\n\nWith that, you bend over and kiss [arian.em], slipping your tongue into [arian.eir] mouth to wrestle with [arian.eir] own long, dexterous tongue.  Withdrawing, you send a hand reaching down between [arian.eir] legs, squeezing [arian.eir] ass, ");
	if (arian.cockTotal() > 1) output("stroking [arian.eir] other cock and sliding it between your ass cheeks, ");
	output("caressing the base of [arian.eir] tail.  With a devious grin, you begin to gently but insistently slide your finger into [arian.eir] ");
	if (arian.analExp() > 66) output("eager ");
	output("ass, probing for [arian.eir] prostrate...");
	
	output("\n\nThe reaction is almost instantaneous; Arian moans into your kiss and you feel [arian.eir] ");
	if (arian.cockTotal() > 1) output("pair of lizan-cocks practically jump");
	else output("lizan-cock practically jump");
	output(" back to full mast, even surprising you with Arian's eagerness.");
	
	output("\n\nYou grin and coyly muse to yourself that maybe Arian makes up for [arian.eir] quickness at climaxing with the speed with which [arian.ey] can recover.");
	
	output("\n\nArian bites [arian.eir] lower lip nervously.  \"<i>I can't help myself if you keep touching me like that.</i>\"  [arian.ey] closes [arian.eir] eyes and turns to the side, [arian.eir] hands clutching your [pc.hips] and [arian.eir] toes curling behind you.  You can't help but gently pat [arian.em] on [arian.eir] head and tell [arian.em] that [arian.ey] looks really cute when [arian.ey] acts like an embarrassed virgin, especially after having already cum inside you.  Arian just turns to smile nervously at you.  \"<i>I... can we... start moving now?</i>\"");
	
	output("\n\nYes, yes you can, you tell [arian.em], and for emphasis you begin to rise and fall, ");
	if (arian.cockTotal() > 1) output("sliding [arian.eir] neglected prick through your ass-cheeks, ");
	output("clenching your inner walls to grip and feel the excitingly unusual lumpy, bulbous texture of [arian.eir] shaft inside you.  You moan and gasp, telling [arian.em] that [arian.ey] feels so unique, and yet [arian.ey] stimulates you so wonderfully.");
	
	output("\n\nThe lizan mage can barely contain [arian.em]self as [arian.ey] tosses and turns on [arian.eir] bed, gasping and moaning at your ministrations.  You lick your lips as you continue to ride [arian.em], ");
	if (pc.hasVagina()) output("cunt dripping with arousal");
	if (pc.hasCock() && pc.hasVagina()) output(" and ");
	if (pc.hasCock()) {
		output("cock");
		if (pc.cockTotal() > 1) output("s");
		output(" drooling precum onto [arian.eir] belly");
	}
	output(".  You're so close now, you can feel it.  You tell Arian you're going to cum, and beg [arian.em] to cum with you.");
	
	output("\n\nAs if on cue, Arian gasps and [arian.eir] shaft");
	if (arian.cockTotal() > 1) output("s twitch");
	else output(" twitches");
	output(", signaling [arian.eir] oncoming orgasm.  [arian.ey] grabs the sheets on [arian.eir] bed and curls [arian.eir] toes.  \"<i>...[pc.name]!</i>\"  Jet after jet of lizan spunk paints your bowels white");
	if (arian.cockTotal() > 1) output(", as well as your butt");
	output(", as Arian climaxes");
	if (arian.hasVagina()) output(", [arian.eir] own pussy clenching and drizzling juices on the matted sheets beneath the two of you.");
	else output(".");
	
	output("\n\nWith a cry of glee, you orgasm, giving yourself over to the pleasures of the act.  Your ass clenches around the bulbous shaft intruding in your bowels, trying to wring it of all its delicious load.");
	if (pc.hasCock()) output("  [pc.EachCock] spasms and shoots rope after rope of [pc.cum], painting Arian's [arian.chest] [pc.cumColor], as well as the groaning lizan's face.");
	if (pc.hasVagina()) output("  Your [pc.vagina], though unattended, joins in the perverted display, leaking copious amount of fluids on top of the prone lizan.");
	
	output("\n\n\"<i>Ahhhhh...</i>\"  Arian sighs, going limp on [arian.eir] bed.  You follow shortly, laying down on top of [arian.em], embracing [arian.em] as [arian.ey] does the same.  \"<i>[pc.name], you're amazing.</i>\"");
	
	output("\n\nWith a pleased grin, you tell [arian.em] that [arian.ey]'s not too shabby [arian.em]self, either.  So, how did [arian.ey] like being the pitcher?");
	
	pc.loadInAss(arian);
	
	processTime(25 + rand(5));
	pc.orgasm();
	
	//(if AnalXP < 33)
	if (arian.analExp() < 33) {
		output("\n\n\"<i>Wow, that felt really good.  Did it feel good for you too, [pc.name]?  I hope it did... wow,</i>\"  Arian pants.");
		
		output("\n\nYou smile and pat your lover on the head, assuring [arian.em] that it was good for you, too.");
		
		output("\n\n\"<i>I'm glad,</i>\" [arian.ey] replies, nuzzling you in affection.");
	}
	//(if AnalXP < 66)
	else if (arian.analExp() < 66) {
		output("\n\n\"<i>You ass feels so good on my cock, [pc.name].  I can only hope it feels this good when you're inside me.  Though to be honest, I think I like it best when our roles are reversed.</i>\"");
		output("\n\nYou insist that it does, though you can't resist grinning and warning Arian [arian.ey] might be getting too much into catching when it comes to this situation.");	
		output("\n\n\"<i>It just feels so good when you're doing me from behind, but doing you is good too.</i>\"  [arian.ey] smiles.");
	}
	//(if AnalXP <= 100)
	else {
		output("\n\n\"<i>That was great!  Now why don't you return the favor and use me instead?  After watching you sit on my shaft like that, I want to be fucked too.</i>\"  [arian.ey] bites [arian.eir] lower lip, tail waving as best as it can underneath the two of you.");
		output("\n\nYou laugh; Arian, you are such a greedy little buttslut, aren't you?  That's what you say to him.");
		
		output("\n\nGrinning nervously, [arian.ey] says, \"<i>I can't help it.  It feels really good.  Besides, you made me that way, so take some responsibility.</i>\"  Then [arian.ey] swallows.  \"<i>Not that I mean to imply I didn't like it... or anything of the sort.</i>\"");
		
		output("\n\nAnd what if you want to be the catcher sometimes, huh?  [arian.ey]'s got such a wonderful cock, how can [arian.ey] deny you the pleasure of taking it up the ass?  [arian.ey]'s so greedy, you tell him, playfully tapping him on the nose.  [arian.ey] whimpers.  \"<i>Okay, I like being the pitcher too, but can you do me now?  Please?</i>\"  [arian.ey] asks, eagerly wiggling [arian.eir] hips.");
		output("\n\nYou contemplate it...");
		
		//(if PC has a cock){
		if (pc.cockThatFits(arian.analCapacity()) >= 0) {
			//[Yes: Play the \"<i>PC fucks Arian's ass</i>\" scene]
			//[No: You tell Arian you've had enough fun for now; maybe later, after you've both recovered.]
			clearMenu();
			addButton(0, "Yes", giveArianAnal);
			addButton(1, "Not now", function():*{ processTime(arianFollower() ? 0 + rand(5) : 15 + rand(10)); mainGameMenu(); } );
			return;
		}
		else {
			output(".  You're too big to fit inside Arian's ass, though.");
			output("\n\nYou chuckle at [arian.eir] eagerness, but point out you're not properly equipped to help [arian.em] at the moment, so maybe later.");
			output("\n\nArian whimpers in disappointment.");
		}
		output("\n\n\"<i>I guess I need a nap now.  Care to join me?</i>\" [arian.ey] asks, yawning widely.  You tell him the offer is tempting, but you really need to get going and attend to other things.  You stroke [arian.eir] cheek and tell [arian.em] to get some rest to build [arian.eir] strength back up - after all, it wasn't really that long ago that [arian.ey] was so sick.  Arian nods.  \"<i>Okay, see you soon?</i>\"");
		output("\n\nYou promise [arian.ey] will, and plant a quick kiss on [arian.eir] brow.  As the lizan settles down to rest, you quietly redress yourself and leave [arian.em] to [arian.eir] slumbers.");
	}
	processTime(arianFollower() ? 0 + rand(5) : 15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Blow:
//Arian must have a cock.
private function suckAriansDick():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//if (arian.hasVagina())	
		//output(images.showImage("arianfemale-home-suckariandick"));	
	//else	
		//output(images.showImage("arianmale-home-suckariandick"));
	output("You make a show of lewdly licking your lips and ask Arian if [arian.ey]'d be willing to let you have a little taste of lizan essence...?");
	output("\n\n\"<i>Are you sure?  I could do something for you if you feel like,</i>\" Arian offers.");
	
	output("\n\nYou shake your head insistently; you want to do something for [arian.em] this time, you tell your reptilian lover.");
	output("\n\n\"<i>Ok... if that's what you really want to do.  So... what should I do?</i>\" the lizan mage asks, fidgeting in barely contained excitement, tapping [arian.eir] fingers in anticipation.");
	
	output("\n\nJust get on the bed, you instruct [arian.em]; you're certain you can take care of the rest.");
	
	output("\n\n\"<i>All right,</i>\" Arian replies nervously, [arian.eir] ");
	if (arian.biggestCockLength() == ARIAN_COCK_SIZE_3) {
		if (arian.cockTotal() > 1) output("exposed cocks hardening to full mast");
		else output("exposed cock hardening to full mast");
	}
	else {
		output("cock");
		if (arian.cockTotal() > 1) output("s emerging from their");
		else output(" emerging from its");
		output(" hiding place, already fully erect");
		output(".");
	}
	output("\n\nYou approach [arian.em] and position yourself before [arian.em], contemplating how to begin.  You reach out with one hand and start to stroke [arian.eir] ");
	if (arian.cockTotal() > 1) output("uppermost ");
	output("cock, marveling at the strange textures of its bumpy, knobbly, bulbous surface.  It feels so strange to you, and you continue to stroke it eagerly.");
	
	output("\n\nArian can only moan at your ministrations, eagerly humping your hand, desperate for your touch.  \"<i>Oh, my... it... it feels so good when it's someone else's hand...</i>\" [arian.eir] ");
	if (arian.cockTotal() > 1) output("twin ");
	output("shaft");
	if (arian.cockTotal() > 1) output("s tremble");
	else output(" trembles");
	output(" and throb");
	if (arian.cockTotal() < 2) output("s");
	output(" against your hand; pre quickly forming on the tip");
	if (arian.cockTotal() > 1) output("s");
	output(" only to slowly slide down the bulbous surface of Arian's lizan prick");
	if (arian.cockTotal() > 1) output("s");
	output(".  You continue to slide your hand along the increasingly slick surface, playfully asking if your hand really feels that good to [arian.em]?");
	
	output("\n\n\"<i>Yesssss... Oh!  If you keep this up I won't be able to last long.</i>\"  Arian pants, [arian.eir] three-toed feet curling with each stroke, hands gripping the sheets tightly.");
	
	output("\n\nYou smile at [arian.em] with an innocent expression quite out of place for what you're doing, and then lean in to give [arian.eir] cock");
	if (arian.cockTotal() > 1) output("s");
	output(" a long, loving, slurpy lick.  The taste is surprising; a sort of sugary-tinted spice, not the usual salt of another creature.  It's actually quite pleasant, and you find yourself running your tongue up and down [arian.eir] prick as if it were some kind of candied stick, eagerly sucking and slobbering as you coax more of [arian.eir] yummy goo from its strangely-shaped tip.");
	
	output("\n\nArian contorts with each loving lick, grunting and groaning in pleasure.  \"<i>[pc.name], I'm going to cum!</i>\"  [arian.ey] warns you, and judging by the way [arian.eir] shaft is throbbing [arian.ey] looks just about ready.");
	
	output("\n\nIn other circumstances, you'd probably tease [arian.em] about having no staying power, but, seeing how the wind's blowing, you instead put your mouth to better use and envelop [arian.eir] cock, suckling and slurping like a baby on a nipple as more of that strange spicy-sweet cum trickles steadily into your mouth.");
	
	output("\n\nUnable to hold back any longer, Arian's hands pull on the sheets as [arian.eir] ");
	if (arian.cockTotal() > 1) output("twin cocks throb");
	else output("cock throbs");
	output(" one more time and erupts into your waiting mouth");
	if (arian.cockTotal() > 1) output(" and chin");
	output(".  [arian.eir] legs close around your back, effectively keeping you from moving too far away as [arian.ey] finishes giving you all of [arian.eir] load.");
	
	output("\n\nYou simply go with what [arian.ey] wants and focus on guzzling down every last drop, continuing to lick and tease even as you swallow mouthful after creamy mouthful");
	if (arian.cockTotal() > 1) output(", oblivious to the second cock spewing cum all over your [pc.chest] in your eagerness");
	output(".  ");
	pc.loadInMouth(arian);
	//pc.refillHunger(15);
	output("After [arian.ey] finally finishes, you continue to lick and suckle for a few minutes longer, making sure you've lapped up every last drop.  Then and then alone do you lift your head, flirtatiously licking your lips to tease the now-spent lizan.");
	
	output("\n\nArian watches you slack jawed and panting.  \"<i>That... that was great!</i>\"  [arian.ey] exclaims happily.  \"<i>I hope I didn't taste too bad.  I mean, I heard there is food that can make it taste better, but... well....</i>\" [arian.ey] smiles nervously.");
	
	output("\n\nYou confess that, truthfully, the taste was unusual, but hardly unpleasant.  So, did your little lizard like the way you licked [arian.eir] lolly to reach the creamy center?  You jest.");
	
	output("\n\n\"<i>Yes, I liked it very much!  Though I hope you'll let me return the favor... somehow,</i>\"  [arian.ey] says, releasing you from between [arian.eir] legs, while [arian.eir] tail lazily curls to gently massage your neck in a sign of affection.");
	
	//[NoCock: 
	if (!pc.hasCock()) output("\n\nYou tell [arian.ey] you'll think of some way [arian.ey] can return the favor,");
	else output("\n\nWell, you happen to have a creamy lolly of your own that [arian.ey] could lick, you tease,");
	output(" rolling your neck in pleasure as [arian.ey] rubs it with [arian.eir] reptilian tail.");
	
	output("\n\nArian bites [arian.eir] lips and twirls [arian.eir] fingers.  \"<i>Well, I hope I can do something... anything... for you soon.  I really enjoy spending time with you, [pc.name].</i>\" [arian.ey] smiles at you.");
	
	output("\n\nSmiling wryly, you jokingly tell the lizan mage that the only reason [arian.ey] happens to enjoy your company is because of all the sex [arian.ey]'s getting.  Arian gasps and immediately blurts out, \"<i>No! Of course not!  I would love to be in your company even if we didn't do anything!</i>\"  [arian.ey] gasps once more and shamefully hides [arian.eir] face when [arian.ey] realizes [arian.ey]'s sporting another erection.  \"<i>S-sorry!  I can't help it!</i>\" [arian.ey] fumbles, trying to cover [arian.em]self.");

	output("\n\nYou just smile and pat [arian.em] on the cheek, telling [arian.em] that [arian.ey]'s adorable when [arian.ey] blushes.  You give [arian.eir] newly-stiffened cock a good firm stroke");
	if (arian.hasVagina()) output(" and tickle [arian.eir] cunt with a finger");
	output(" for emphasis, kiss [arian.em] gently on the tip of [arian.eir] nose, and then get your clothes together, planning on getting dressed and heading back out again.");
	
	output("\n\n\"<i>Uuuh... see you soon?</i>\"");
	output("\n\nYou throw [arian.em] a smirk over your shoulder, shake your [pc.ass] for [arian.eir] benefit, and head on out.");
	
	pc.lust(10 + pc.libido() / 5);
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Get Penetrated:
//PC must have a vagina.
//Arian must have a cock.
private function getPenetratedByArianAndHisHitlerMustache():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//if (arian.hasVagina())	
		//output(images.showImage("arianfemale-home-getpenetrated"));	
	//else	
		//output(images.showImage("arianmale-home-getpenetrated"));
	
	output("You look at Arian's ");
	if (arian.biggestCockLength() < ARIAN_COCK_SIZE_3) output("slit, and think of what it's hiding in there");
	else {
		output("exposed cock");
		if (arian.cockTotal() > 1) output("s");
	}
	output("; then you turn to look at Arian and ask [arian.em] how would [arian.ey] feel about giving [arian.eir] ");
	if (arian.cockTotal() > 1) output("twin cocks");
	else output("cock");
	output(" a bit of a workout?");
	
	output("\n\nArian swallows audibly.  \"<i>Are you suggesting that we... and that I... put it in?</i>\"  Grinning, you nod in affirmation, telling [arian.em] that there's no need to be shy about it... at least not since your relationship escalated to the current level.");
	
	output("\n\n\"<i>Ok... how do you want to do this?</i>\"  You motion for the lizan to get up.  Arian eagerly complies and gets off [arian.eir] bed.  You teasingly take [arian.eir] place on the bed, looking up at [arian.em] as you ");
	if (pc.isBiped()) output("spread your [pc.legs] and ");
	output("expose your [pc.vagina] to [arian.eir] viewing pleasure.  The reaction is almost instantaneous; Arian's ");
	if (arian.biggestCockLength() >= ARIAN_COCK_SIZE_3) output("exposed");
	else output("hidden");
	if (arian.cockTotal() > 1) output(" twin shafts immediately fill");
	else output(" shaft immediately fills");
	output(" with blood, growing fully erect in ");
	if (arian.cockTotal() > 1) output("their");
	else output("its");
	output(" bulbous, throbbing glory.");
	
	output("\n\nWith a smile, you tell [arian.em] that despite [arian.eir] initial bout of shyness, [arian.eir] body seems to know exactly what to do.  Arian simply laughs in nervousness.  You wait for a short while, until finally you tell [arian.em] that [arian.ey] should position [arian.em]self at your opening");
	if (arian.cockTotal() > 1) output("s");
	output(" and get ready to thrust in; otherwise neither of you are going to be feeling good any time soon.");
	
	output("\n\nSnapping to [arian.eir] senses, Arian quickly ");
	output("kneels between your [pc.legs]");
	output(", aligning the tip of ");
	if (arian.cockTotal() > 1) output("each of ");
	output(arian.mf("his","her") + " ");
	output("shaft");
	if (arian.cockTotal() > 1) output("s");
	output(" with your [pc.vagina]");
	if (arian.cockTotal() > 1) output(" and [pc.asshole]");
	output(".  [arian.ey] looks at you, waiting for you to confirm that [arian.ey] should indeed get going.  You smile and nod");
	if (pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output(", looping your tail around [arian.eir] waist");
	output(".");
	
	output("\n\nArian smiles right back at you and finally begins easing [arian.em]self inside you.");
	
	//(if ArianDblCock == 1) //DP PC
	if (arian.cockTotal() > 1) {
		output("\n\nHesitantly, the lizan tries to fit both of [arian.eir] cocks into your [pc.vagina] and [pc.asshole] at the same time.  You sigh at the intrusion and look at [arian.eir] face; Arian has a look of absolute bliss on [arian.eir], you can even see that the lizan is beginning to drool a bit.  The texture of Arian's twin cocks might be very similar, but they feel entirely different on both your ass and pussy.");
		
		output("\n\nThe bulbous orbs dotting the length work somewhat like beads, as they work over your resistance, each time one of them presses in, you moan and brace yourself for the next, larger bulb.  Gently but insistently Arian presses forward, quite happy to try and take both of your holes at the same time.  \"<i>This isn't hurting you, is it?</i>\" [arian.ey] asks, still understandably nervous about your relationship.");
		
		output("\n\nYou shake your head and tell [arian.em] that you're fine.  [arian.eir] cocks just feel... different... from what you're used to seeing around; you remark that they seem built to rub against your most sensitive spots inside both your ass and your vagina.  Still, if [arian.ey] doesn't hurry up and fill you up, you might have to take matters into your own hands.  It's not nice to keep a girl waiting.");

		output("\n\nArian fumbles and begins penetrating you with more gusto.  \"<i>S-sorry, I just don't want to hurt you...</i>\"  You sigh and tell [arian.em] that you aren't made of glass.  [arian.ey] can be a little rough, though if [arian.ey] overdoes it you'll have to stop [arian.em].  Still, you can take something like this!");
		
		output("\n\nYou take hold of [arian.eir] arms and pull [arian.em] up towards you, making the lizan lose [arian.eir] balance and fully penetrate you.");
		//(Enlargement/Virginity loss messages)
		arian.cockChange(true, true);
		pc.cuntChange(0, arian.biggestCockVolume(), true, true, false);
		pc.buttChange(arian.biggestCockVolume(), true, true, false);
		
		output("\n\nThe lizan moans in shock at the deed, as if [arian.ey] still can't believe this is actually happening.  [arian.eir] fingers clutch you tightly, but [arian.ey] doesn't make any further motions - more likely [arian.ey] can't bring himself to thrust just yet, still full of that nervous virgin behavior.");
	}
	else 
	{ //Only one pole for that hole.
		output("\n\nArian nervously begins to thrust [arian.eir] strange, bumpy cock into your cunt, timidly inserting an inch or two and then withdrawing, as if unable to bring [arian.em]self to fully penetrate you.");
		
		output("\n\nYou moan at the initial intrusion, and sigh as [arian.ey] pulls out.  Impatient and bothered by [arian.eir] impromptu teasing, you ask what's gotten into [arian.em] to make [arian.em] withdraw?  You're already more than ready for this.");
		
		output("\n\n\"<i>I-I'm sorry, it's just....  Well, I'm not used to this, you know.</i>\"  Arian's eyes are downcast, and you're certain you can see a faint tinge of red around [arian.eir] face, [arian.eir] albinism allowing [arian.em] to blush in a way you're not sure a normal lizan could.  \"<i>It... it's so overwhelming to finally be with a woman, never mind a woman like you.</i>\"");
		
		output("\n\nSighing at the lizan's inexperience, you gently take [arian.eir] hands in yours and guide them around you, telling [arian.em] to hug you");
		if (pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output(", further encouraging [arian.em] to do so, by looping your [pc.tails] around [arian.eir] waist");
		output(".  The lizan doesn't need much encouragement to comply, easily snuggling against you, breast to breast, and sighing softly.  \"<i>I'm sorry.  Sometimes I wonder why you bother doing something like this, with someone like me,</i>\" [arian.ey] says, a hint of sadness in [arian.eir] voice.");
		
		output("\n\nYou reply that you bother because Arian is cute and you happen to like [arian.em].  [arian.ey] should forget about [arian.eir] insecurities and give [arian.em]self some credit.  Still, you are horny, and judging by the prodding you feel on your [pc.leg], so is Arian.  You don't bother saying anything more, gently reaching down to align [arian.eir] shaft with your [pc.vagina] and then pinch on the base of [arian.eir] tail.");
		
		output("\n\nArian lets out a tiny squeak of shock at the pinching sensation, which instinctively makes [arian.em] thrust [arian.em]self forward, embedding [arian.em]self in you to the hilt.");
		//(Enlargement/Virginity loss messages)
		arian.cockChange(true, true);
		pc.cuntChange(0,arian.biggestCockVolume(),true,true,false);
		
		output("\n\nYou gasp in pleasure at the sudden intrusion; then hug your lizan lover closer, stroking [arian.eir] back.  You ask if that was so difficult?");
		
		output("\n\n\"<i>N-not difficult, no.  But hard, all the same,</i>\" Arian replies.  Did [arian.ey] just make a joke?");
	}
	
	output("\n\nSmiling, you gently tap [arian.em] on the nose and tell [arian.em] that unless [arian.ey] expects you to do all the work, the two of you won't get anything done if [arian.ey] just lets [arian.eir] shaft");
	if (arian.cockTotal() > 1) output("s");
	output(" sit inside you.");
	
	output("\n\nThe lizan promptly makes [arian.em]self busy, awkwardly thrusting in and out, pumping in a clumsy attempt to pleasure you both.  While you appreciate [arian.eir] enthusiasm, just randomly thrusting inside you won't give you the pleasure you so crave.  You tell Arian to stop for a moment.");
	
	output("\n\nArian does so, blinking curiously at you.  \"<i>Did I hurt you?  Am I doing something wrong?  I'm sorry!</i>\" the lizan blurts you.  Laughing, you tell [arian.em] to calm down.  [arian.ey] didn't do anything wrong, and [arian.ey] certainly didn't hurt you.  \"<i>So, what's wrong then?</i>\" Arian asks.  [arian.ey] then blinks in realisation and pouts.  \"<i>I'm not doing that badly, am I?</i>\"  Rubbing [arian.eir] back, you tell [arian.em] that just thrusting [arian.em]self inside you without any technique won't make you feel good.");
	
	output("\n\n\"<i>I'm sorry,</i>\" [arian.ey] sighs.  It's ok, you tell [arian.em], you'll just have to guide [arian.em] through the process.  Grasping on the base of [arian.eir] tail, you begin guiding the inexperienced lizan, using [arian.eir] tail like a control stick.");
	
	output("\n\nArian moans and shivers at the pleasure, but it doesn't stop [arian.em] from catching on; indeed, [arian.ey] proves [arian.em]self a quick study and starts to preempt your ‘instructions'.  \"<i>I-I can't tell you how incredible this is, [pc.name].  You're so warm and wet inside,</i>\" [arian.ey] murmurs to you, too caught up in the sensations of sex to really flatter you.");
	
	output("\n\nYou moan alongside your lizan lover, replying that [arian.ey] feels just as good.  [arian.eir] ");
	if (arian.cockTotal() > 1) output("twin bulbous shafts feel");
	else output("bulbous shaft feels");
	output(" exquisite, and ");
	if (arian.cockTotal() > 1) output("their");
	else output("its");
	output(" bumps massage your entrance");
	if (arian.cockTotal() > 1) output("s");
	output(" unlike anything else.  You praise the lizan on being a quick study, letting go of [arian.eir] tail and grabbing onto [arian.eir] scaly shoulders instead, giving [arian.em] a few more directions so [arian.ey] can catch your most sensitive spots.");
	
	output("\n\nArian suddenly clenches and gasps, moaning several times and arching [arian.eir] back before [arian.ey] can't hold it back anymore and climaxes inside of you, filling your [pc.vagina] ");
	if (arian.cockTotal() > 1) output("and [pc.ass] ");
	output("with [arian.eir] sticky wet seed.");
	
	output("\n\nYou moan as [arian.ey] fills you with [arian.eir] lizan seed, then immediately sigh in disappointment as [arian.ey] slumps down on top of you, nuzzling against you tenderly.  \"<i>That was incredible.  Hey, what's wrong?  Why didn't you cum?</i>\" Arian asks, curious yet sated.  Well, you just didn't have time to, but it's okay.  You'll find some way to relieve yourself, and it did feel good for the time it lasted.  You pat Arian's head, smiling at the lizan, despite being annoyed at not being able to climax.");
	
	output("\n\n\"<i>You mean, I didn't...?  No, no that's not acceptable!</i>\"  Arian growls.  To your surprise, you suddenly feel [arian.eir] flaccid member");
	if (arian.cockTotal() > 1) output("s");
	output(" swelling inside you, the lizan grabbing your shoulders and starting to thrust [arian.em]self back into you once more.");
	
	output("\n\nYou groan in as much surprise as pleasure, bracing yourself against Arian as [arian.ey] begins fucking you with as much enthusiasm as when you two started.  You are genuinely impressed.  This is not something a newcomer to sex would be able to pull off.  You decide to thank and congratulate the lizan for [arian.eir] dedication with a kiss.");
	
	output("\n\nArian promptly redoubles [arian.eir] efforts, while trying to kiss you back in appreciation of the gesture.  You lose yourself in the pleasure and closeness of the act, fucking and kissing.  Slowly you feel a familiar pressure build in your loins, and you know it won't be long before you finally achieve your so, so desired, orgasm.");
	
	output("\n\nArian [arian.em]self lets out a cry of relief; having finally achieved [arian.eir] goal in helping you orgasm means [arian.ey] can give in to the sensations ");
	if (!arian.hasVagina()) output("[arian.ey] himself ");
	else output("[arian.ey] ");
	output("is being overwhelmed by, spraying your ");
	if (arian.cockTotal() < 2) output("cavity");
	else output("cavities");
	output(" with a second helping of lizan spunk, dredging up every last drop of jizz left in [arian.eir] internal balls before, with a groan, [arian.ey] sinks down atop you.  Arian's orgasm pushes you over the edge, and you find your pussy ");
	if (arian.cockTotal() > 1) output("and ass ");
	output("contracting, trying ");
	if (arian.cockTotal() < 2) output("its");
	else output("their");
	output(" best to milk the poor lizan of all [arian.ey] is worth, until finally with one last spasm, you slump down and release the lizan shaft");
	if (arian.cockTotal() > 1) output("s");
	output(" deeply embedded inside you, some of your mixed juices running down to mat Arian's bed.");
	
	output("\n\n[arian.ey] lays there, panting softly from the exertion, then somehow finds the strength to give you a weak yet cheeky grin.  \"<i>So, how was I this time?</i>\" [arian.ey] asks.  Panting, you tell [arian.em] that [arian.ey] was great.  You didn't expect [arian.em] to be able to get a second erection so quickly, especially after having just cum.  \"<i>Well, I've learned a few tricks at the academy from some of the more, uh, restricted tomes, shall we say?  Not enough that I can do anything major, or even worth teaching, but enough for... something like this....</i>\"");
	
	output("\n\nGrinning at [arian.em], you question just why would [arian.ey] have picked up this one particular spell?  Arian does that weird pseudo-blush of [arian.eirs] again.  \"<i>A fellow can dream of finding someone special someday, can't they?</i>\"  That's all [arian.ey]'ll say on the subject, despite your coaxing.");
	
	output("\n\nYou decide to drop the subject for the moment and tell [arian.em] that as enjoyable as it was to spend time with [arian.em], you must return to your duties now.  Arian simply nods, wearing [arian.eir] best stoic expression.  \"<i>I understand... but, please, come back when you can, all right?</i>\"  You smile and tell [arian.em] you will, caressing [arian.eir] scaly cheek, then with a cheeky grin, let [arian.em] know that next time you expect at least four more performances from [arian.em].  Arian's eyes bulge at your suggestion, half in fear and half in lust.  \"<i>I... I can't possibly do that!  I mean, I don't have the energy,</i>\"  [arian.ey] declares, swallowing audibly and averting [arian.eir] eyes.");
	
	output("\n\nGrinning, you pull [arian.em] into a final kiss, telling [arian.em] this is just something for [arian.em] to think about.  Having said that, you quickly redress and excuse yourself, leaving one flustered lizan behind to rest.");
	
	pc.loadInCunt(arian);
	if (arian.cockTotal() > 1) pc.loadInAss(arian);
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Double Pen Arian:
//PC must have at least 2 cocks that fit. That means two cocks with a cock area of <= 50.
//This isn't meant to give AnalXP, but given the fact that Arian's ass will get pen'd it would also be justified. Up to you Fen!
private function doublePenetrateArian():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//output(images.showImage("arianfemale-home-doublepenetrate"));	
	var x:int = pc.cockThatFits(arian.vaginalCapacity());
	var y:int = pc.cockThatFits2(arian.analCapacity());
	output("You look over your feminine lizard lover, and feel your [pc.multiCocks] starting to stir in your [pc.gear].  Since you have enough tools for the job, and Arian has enough holes, you ask if Arian would be willing to let you fuck [arian.em] in both [arian.eir] ass and pussy at the same time?");
	
	output("\n\nArian bites [arian.eir] lower lip, fidgeting a bit at your suggestion.  \"<i>Sure.  I mean... that's the way sex is supposed to be with lizan females, and I do have the parts now.</i>\"");
	
	output("\n\nArian rolls around, laying face down on [arian.eir] bed, [arian.eir] rump held high to allow you easy access to both [arian.eir] ");
	if (arian.analExp() <= 33) output("tight");
	else if (arian.analExp() <= 66) output("loose");
	else output("throbbing");
	output(" ass and dripping wet vagina; a pair of clawed hands reach behind to spread [arian.eir] butt open for you.  \"<i>Okay, I'm ready.</i>\"  Arian says, looking behind at you.");
	
	output("\n\nYou sidle gently into the bed behind [arian.em] and gently squeeze [arian.eir] full, round cheeks, rubbing them before moving your hand into [arian.eir] crack in an effort to massage both anus and pussy at the same time.  You roll the palm of your hand against [arian.eir] back passage and stroke [arian.eir] softly scaled vulva lips with your fingers, asking how that feels.  \"<i>G-good,</i>\" Arian replies, shuddering.");
	
	//(if ArianAnalXP < 33)
	if (arian.analExp() < 33) {
		output("\n\nYou slide your finger inside of Arian's pussy, getting it nice and slick with [arian.eir] juices, and then remove your hand; lining the finger up with [arian.eir] ass, you start pressing insistently against [arian.eir] back hole; it takes some effort, but finally [arian.eir] back passage yields and Arian moans as your finger presses past [arian.eir] sphincter and into [arian.eir] warm innards.  You smile and tell Arian [arian.ey]'s really tight back here.");
		
		output("\n\n\"<i>Hmm... we don't get to use my ass much, so of course it'll be tight.  Just try not to be too rough, please?  It kinda hurts.</i>\"");
		
		output("\n\nYou assure [arian.em] that you'll be gentle; and with [arian.eir] pussy getting some as well, it should be easier for [arian.em] to adjust.  That said, you carefully align your shafts and start to press them home.  It takes some effort to push inside [arian.eir] ass, but [arian.eir] pussy readily accepts you into its warm, wet embrace.");
		
		pc.cockChange(true, true);
		arian.cuntChange(0, pc.cockVolume(x), true, true, true);
		arian.buttChange(pc.cockVolume(y), true, true, true);
		
		output("\n\n\"<i>Ooohhh!</i>\" Arian's initial cry of pain turns into a deep moan of pleasure as you finally make your way inside.  You stop to give [arian.em] some time to adjust.  \"<i>I feel so stuffed... it hurts, but feels good at the same time.  Hhmmm... keep moving, please.</i>\"  You do as [arian.ey] asks, and slowly push yourself to the hilt.");
	}
	//(else if ArianAnalXP < 66)
	else if (arian.analExp() < 66) {
		output("\n\nYou know Arian's no stranger to anal sex, but you still figure it's polite to lube your finger up to some extent first.  Your fingers stroke and caress, sliding in and out of [arian.eir] moist depths, and you remove your hand to begin probing into [arian.eir] tailhole.  The well-trained orifice happily accepts you, posing little resistance as you begin sliding your femcum-slick digits inside.");
		
		output("\n\n\"<i>Aah, that feels nice.  I feel like such a girl, being treated like that...</i>\"");
		
		output("\n\nWell, of course, [arian.ey] is a girl, you grin.  Why shouldn't you treat [arian.em] like this, especially if it makes [arian.em] happy?  \"<i>W-well, I'm not really a girl.  I mean... not originally, but it does make me happy.  Why don't you stick it in?</i>\"  [arian.ey] smiles nervously back at you.");
		
		output("\n\nWell, if [arian.ey]'s really so interested.  You quickly align yourself and start to press forward, gently inserting yourself into the two eager holes your lover has.  \"<i>Yesssss... don't stop until I'm fully stuffed,</i>\" Arian says, [arian.eir] tail wagging lazily above.  With a chuckle, you tap it away so you can finish pressing [arian.em], all the way to the hilt.");
		
		pc.cockChange(true, true);
		arian.cuntChange(0, pc.cockVolume(x), true, true, true);
		arian.buttChange(pc.cockVolume(y), true, true, true);
	}
	else {
		output("\n\nFor politeness' sake more than anything, you painstakingly rub and massage Arian's dripping wet cunny with your fingers, getting them nice and lubed before you start poking at the greedy little hole under Arian's tail.  You don't meet any resistance at all; indeed, it seems to deliberately wrinkle itself in order to slurp your fingers inside, the muscles squeezing in an effort to hold you in there.  You smile to yourself, telling Arian that [arian.eir] little rosebud is indeed a naughty little thing, and you didn't expect any less.");
		
		output("\n\nArian shudders in pleasure, pushing back to allow [arian.eir] ass to suck more of your finger in.  \"<i>Hmm... it's like that thanks to you.  Not that I'm complaining.  I love it when you take me from behind.</i>\"");
		
		output("\n\nDoes [arian.ey] really, now, you ask?  Are both of [arian.eir] greedy little holes anxious for a nice sausage to stuff themselves with, hmm?  \"<i>Yesss.... I need you.  Please... make me feel good... like a girl,</i>\" Arian begs.");
		
		output("\n\nWell, if that's what [arian.ey] wants, who are you to deny [arian.em]?  You promptly position yourself and begin slowly sliding yourself home.");
		
		output("\n\n\"<i>Hmm... come on, [pc.name].  You know you can go faster than that, don't tease me!</i>\"  Arian protests, pushing back at you, while [arian.eir] tail wraps itself around your waist to pull you inside.");
		
		output("\n\nWell, both [arian.eir] holes need a little tenderness, you point out.  Still, you hasten your pace, pushing inside [arian.eir] hungry holes until you've hilted yourself.");
		
		pc.cockChange(true, true);
		arian.cuntChange(0, pc.cockVolume(x), true, true, true);
		arian.buttChange(pc.cockVolume(y), true, true, true);
	}
	
	output("\n\nYou moan and squeeze Arian's scaly yet luscious asscheeks, asking how [arian.ey] enjoys [arian.eir] double-serve of stuffing?  Rolling [arian.eir] hips against your own, [arian.ey] replies, \"<i>Let's just say that I'm beginning to get why we lizans are built the way we are.  Take me now!</i>\" [arian.ey] demands.");
	
	output("\n\nYou deliver a slap to [arian.eir] perky little butt, the crack of flesh on flesh ringing out as you then tell [arian.em] not to get greedy; there's no race to be won here.  \"<i>Ow!  B-but... I want you!</i>\"  [arian.ey] pushes back at you insistently.  And you want [arian.em] as well, you tell [arian.em], but still, no need to be so bossy.  Arian pouts.  \"<i>Sorry...</i>\"");
	
	output("\n\nThat's better, you say.  With that, you start to thrust yourself into [arian.eir] two holes.  Penetrating both of Arian's holes is a unique feeling; [arian.eir] ass hugs your " + pc.cockDescript(y) + " tightly, trying to prevent you from moving as it does its best to keep you hilted deeply within; while [arian.eir] pussy, so slick and moist, massages your shaft expertly. For a moment you wonder if you even have to move.");
	
	output("\n\n\"<i>Oooh, [pc.name]... you have no idea how wonderful this feels.  I feel so full... so good... so wanted... I love you!  Fertilize my eggs!</i>\"  You groan and smirk, commenting that maybe Arian's getting a bit too caught up in this, unless [arian.ey]'s telling you that this ex-boy really wants to be a mother?  \"<i>Me... a mother... d-don't stop!  I want you as deep inside me as possible!</i>\"  You moan as [arian.eir] two holes ripple around your intruding shafts, striving to suck you deeper and deeper inside of [arian.eir].  You allow them to lead, but warn [arian.em] that you just might end up making [arian.em] a mother whether [arian.ey] wants to be or not if [arian.ey] doesn't temper [arian.eir] enthusiasm.");
	
	output("\n\n\"<i>What do you think I'm trying to do!?  Now get in here and paint my womb white!</i>\" Arian snaps, bracing [arian.em]self on [arian.eir] bed and allowing [arian.eir] ass and pussy both to suck you in with surprising force.  As soon as you're hilted within both holes, [arian.eir] ass clamps shut on your " + pc.cockDescript(y) + ", while [arian.eir] pussy's contractions begin truly milking you for all you're worth.  Stuck as you are, you have no option but to sit back and enjoy [arian.eir] contractions as you feel yourself nearing the edge of an inevitable orgasm.");
	
	output("\n\nYou still can't quite drown your surprise at how this is making [arian.em] act, but if that's what [arian.ey] wants.  Besides, with the vice-like grip [arian.eir] holes have on your cocks, it's not as if you have a choice, right?  You thrust two, three more times with all the ferocity you can muster, grab [arian.eir] ass and holler as your climax finally erupts from your twin dicks.");
	
	//(Low Cum Amount)
	if (pc.cumQ() <= 250) {
		output("\n\nYour [pc.cocks] explode inside Arian's eager holes, giving them the liquid warmth they so crave.  The massage that your two cocks are receiving only enhance the intense feeling, and you find yourself cumming more than usual.  They don't stop massaging you for more, even as you stop unloading.");
		
		output("\n\n\"<i>More, I need more for my eggs!</i>\" Arian demands, yet you are truly spent...");
	}
	//(Medium Cum Amount)
	else if (pc.cumQ() <= 1000) {
		output("\n\nLiquid lust floods Arian's insides, as your [pc.multiCocks] do their best to relieve ");
		if (pc.balls == 0) output("themselves");
		else output("your [pc.balls]");

		output(" of their load; a load Arian is not only pleased to accept, but also eager to relieve you of every single stray drop off.  The tightness of [arian.eir] ass, pressing down on your " + pc.cockDescript(y) + ", [arian.eir] pussy milking on your " + pc.cockDescript(x) + ".  How could anyone refuse such an invitation?  You let yourself go, stuffing the eager lizan with more cum than you thought yourself capable of producing.");
		
		output("\n\n\"<i>M-more,</i>\" Arian pleads, even as [arian.eir] belly starts to distend.");
	}
	//(High Cum Amount)
	else {
		output("\n\nYou cum with such force, that if Arian's ass wasn't clamping down on your " + pc.cockDescript(y) + " so tightly, you'd be sure [arian.ey] was going to get pushed off.  \"<i>So much cum!  Yesssss!</i>\" Arian moans, as you quickly give [arian.eir] usually lithe belly a very blatant bump.  Even though your prodigious amount of cum is enough to completely fill the eager lizan-girl, [arian.eir] ass and pussy work overtime to ensure you're completely spent; and you have no desire to resist.");
		
		output("\n\nBy the time you're finished, Arian's belly is positively bulging.  \"<i>Ahhh... eggs... cum... yes...</i>\" [arian.ey] states in a stupor.");
	}
	output("\n\nArian's ass goes slack around your " + pc.cockDescript(y) + ", and Arian slowly slides off your shaft to plop on [arian.eir] bed; eyes closed in bliss, as [arian.ey] takes a short nap.");
	
	//(if ArianDblPenChat == 0)
	if (int(flags["COC.ARIAN_DOUBLE_PENETRATION_CHAT"]) == 0) {
		flags["COC.ARIAN_DOUBLE_PENETRATION_CHAT"] = 1;
		output("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that you didn't expect [arian.em] to be so eager to lay a batch of fertilized eggs, and you certainly didn't expect [arian.em] to be so... bossy.");
		
		output("\n\nArian's eyes snap open and [arian.ey] quickly rolls around to look you in the eyes.  \"<i>Oh my!  Please, forgive me, [pc.name].  I swear I don't know what came over me.  It was... sorry!</i>\"  [arian.ey] bows [arian.eir] head down in shame.");
		
		output("\n\nYou just laugh.  So, it looks like [arian.ey] wasn't really in control, huh?  Well, you should have figured [arian.ey]'d have problems with it; this is a situation [arian.ey] was never really supposed to be in, after all.");
		
		output("\n\n\"<i>I'm really sorry...</i>\"");
		
		output("\n\nYou tell [arian.em] that [arian.ey] doesn't need to apologise, but you do need to know; are you going to be a father now?  Is [arian.ey] really pregnant as a result of the sex you just had with [arian.em]?");
		
		output("\n\nArian shakes [arian.eir] head.  \"<i>Not really.  I didn't have a clutch of eggs for you to fertilize, so the answer is no,</i>\" [arian.ey] says, with a slight tinge of disappointment.");
		
		output("\n\nYou ask why [arian.ey] sounds so disappointed; [arian.ey] lived [arian.eir] life as a male before [arian.ey] met you - does [arian.ey] really want to embrace womanhood so thoroughly as to lay a clutch of eggs?");
		
		output("\n\nArian covers [arian.eir] face and shakes [arian.eir] body in a way that you can only describe as... girly.  \"<i>Sorry, I have all these urges, and... well... I wouldn't be opposed to laying a clutch fathered by you, to be honest.</i>\"");
		
		output("\n\nYou're not sure what to say about that, so you simply ask if [arian.ey] enjoyed herself.");
		
		output("\n\n\"<i>Very much!</i>\"  Arian grins happily.  You smile and pat [arian.em] on the head, telling [arian.em] that's good to hear; maybe you should do this again sometime?");
		
		output("\n\n\"<i>I'd like it if we did.</i>\"");
		
		output("\n\nYou tell [arian.em] you'll remember that, then politely redress and make your way out of [arian.eir] ");
		if (!arianFollower()) output("bedchambers");
		else output("tent");
		output(".");
	}
	else {
		output("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that it's always a surprise how [arian.ey] acts bossy when you're having sex like that.");
		
		output("\n\nArian lazily opens [arian.eir] eyes and rolls around to face you, rubbing [arian.eir] belly.  \"<i>Hmm, I don't know why I act like that.  I just can't control it.</i>\"");
		
		output("\n\nYou tell [arian.em] it's actually funny to see [arian.em] change like that, since normally [arian.ey] would never demand anything of you.  You would never have guessed [arian.ey] had that... bossy side to [arian.eir].  Arian bites [arian.eir] lower lip.  \"<i>Sorry about that by the way.</i>\"");
		
		output("\n\nYou shake your head, telling [arian.em] it's no trouble then gently pat [arian.em] on [arian.eir] head and re-dress, excusing yourself out of [arian.eir] ");
		if (!arianFollower()) output("bedchambers");
		else output("tent");
		output(".");
	}
	//arian.loadInCunt(pc);
	//arian.loadInAss(pc);
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Docking
//ArianCockSize needs to be below 3. (ArianDblCock does not affect this decision.) 
//PC cock area must be <= 30.
private function arianDocking():void {
	clearOutput();
	IncrementFlag("COC.ARIAN_TIMES_SEXED");
	arian.health(3);
	//if (arian.hasVagina())	
		//output(images.showImage("arianfemale-home-docking"));	
	//else	
		//output(images.showImage("arianmale-home-docking"));
	output("You set your eyes on Arian's genital slit, and then smile at [arian.em].  You ask how [arian.ey]'d feel about ‘hiding' your cock, rather than [arian.eirs], inside [arian.eir] slit?");
	
	output("\n\nArian shudders a bit.  \"<i>That... would feel kinda weird, I think, but it's not unheard of among certain lizan couples.  If you want to try that, I'm okay with it.</i>\"");
	
	output("\n\nYou tell [arian.em] that, yes, you want to try it - you're sorry, but it just sounds so kinky; and besides that, ");
	//(if ArianDblCock == 0)
	if (arian.cockTotal() < 2) {
		output("didn't [arian.ey] always want to have two dicks?  Well, now it's [arian.eir] chance to find out what it'd be like.");
	}
	else {
		output("[arian.ey]'s already hiding two in there... an extra cock won't make such a huge difference, would it?");
	}
	
	output("\n\n\"<i>I suppose you're right.  Okay then, let's try.</i>\"  Arian lays on [arian.eir] back, spreading [arian.eir] legs to give you access to [arian.eir] genital slit, gently touching the soft folds that hide [arian.eir] ");
	if (arian.cockTotal() > 1) output("pair of ");
	output("pecker");
	if (arian.cockTotal() > 1) output("s");
	output(" from your prying eyes.");
	
	output("\n\nYou gently push away [arian.eir] hands, running your fingers over the strange, almost woman-like folds, rubbing against the soft, smooth scales that cover [arian.em] there.  You gently massage [arian.em], making [arian.em] groan softly at the stimulation, before working up the courage to begin gently probing inside.  It's wet and slick, the muscles squeezing your fingers tightly, and you don't have too far to go before you can feel yourself touching the bulbous, unmistakable shape");
	if (arian.cockTotal() > 1) output("s");
	output(" of Arian's dick");
	if (arian.cockTotal() > 1) output("s");
	output(".  You brush your fingers against the tip");
	if (arian.cockTotal() > 1) output("s");
	output(", seeing what kind of reaction that will elicit from your scaly lover.");
	
	output("\n\nArian groans.  \"<i>Hmm, if you keep doing that, I won't be able to keep it inside for you.</i>\"");
	
	output("\n\nYou tell [arian.em] that would be a crying shame, and gently remove your fingers.  Arian whimpers in disappointment.  \"<i>Awww, I was fine with having a handjob instead.</i>\"  [arian.ey] smiles mischievously at you.");
	
	output("\n\nOh no, you tell [arian.em]; you started out with something more unusual in mind, and you're going to finish it.  Quickly giving your own [pc.cock " + pc.smallestCockIndex() + "] a few strokes to help coax it into the right mindset, you aim it into Arian's cock-slit and, looping your arms around [arian.eir] neck for balance, begin to press forward and gently feed it into the literal boy-pussy.");
	
	output("\n\nThe fit is so very tight, warmer than the rest of [arian.em] for reasons you don't care enough to contemplate at this moment, and slick with lubricating fluids.  It's so strange, yet so hot... and once you have your [pc.cock " + pc.smallestCockIndex() + "]");
	if (arian.cockTotal() < 2) output(" brushing up against [arian.eir] own lizan pecker");
	else output("sandwiched between [arian.eir] two lizard dicks");
	output(", the friction is absolutely incredible, sending sparks of pleasure cascading along your shaft.  You moan in delicious lust and tell Arian that this is absolutely incredible.");
	
	output("\n\nArian's expression is difficult to read; you can tell there is an obvious discomfort in the lizan's face, but at the same time, [arian.ey]'s panting in excitement.  \"<i>Ugh, It feels stuffed... but also good.  Your cock rubbing against my own... t-try moving your hips.</i>\"");
	
	output("\n\nYou shift your arms from around [arian.eir] neck to around [arian.eir] waist and do as [arian.ey] asks, pulling your hips back and then inserting them forward, just like you were trying to fuck a pussy.  The slimy, knobbly, bulbous texture of [arian.eir] ");
	if (arian.cockTotal() > 1) output("twin cocks ");
	else output("cock ");
	output("slides across your intruding shaft as you go, and [arian.eir] sheathe-walls grip and squeeze as best they can, leaving you moaning and panting like a bitch in heat.  Arian's moans of pleasure join yours, [arian.eir] twitching bulbous shaft");
	if (arian.cockTotal() > 1) output("s");
	output(" massaging your [pc.cock " + pc.smallestCockIndex() + "] almost like a vagina would.  Shaky hands grab a hold of your shoulders, helping you down and up on Arian's male slit.  \"<i>Oh, Marae!  It feels like I'm getting an internal handjob... it feEels so... so good!  H - harder... almost cumming!</i>\" [arian.ey] pleads, as [arian.ey] breathes hotly on your face; panting like a bitch in heat.");
	
	output("\n\nNot, you gasp back, if you don't come first... with that desperate promise (warning? Plea? Who cares?) you piston yourself back and forth four more times and then howl at the ceiling above as you cum into Arian's makeshift vagina.");
	
	//(Low Cum Amount)
	if (pc.cumQ() < 250) {
		output("\n\nEven if your load is not that big to begin with; there is little room inside Arian's cramped genital slit, and you soon find yourself overflowing the little crevice.");
	}
	//(Medium Cum Amount)
	else if (pc.cumQ() < 1000) {
		output("\n\nYour load is big enough to give females a bit of a potbelly, but Arian's slit being so shallow by comparison, means your [pc.cum] practically erupts out of [arian.eir] overfilled crevice.");
	}
	//(high Cum Amount)
	else {
		output("\n\nYour prodigious load is so huge, not even goblins can hope to hold all of it inside.  So it's no wonder all it takes is a single jet to make Arian's little crevice erupt with backflow of your [pc.cumNoun], painting your belly as well as Arian's with a perverted geyser of [pc.cumColor].");
	}
	
	output("\n\nSpent, you slump down on the lizan's [arian.chest].  With a sense of urgency Arian looks pleadingly at you, feebly pushing your shoulders away.  \"<i>P-pull out, please!</i>\"");
	
	output("\n\nYou ask [arian.em] what's wrong, too caught up in the feelings of your release to obey [arian.em] immediately. \"<i>Need... to cum... no room!</i>\" [arian.ey] says, groaning.  Realizing what's wrong, you hasten to obey - you don't want [arian.em] to burst!  You pull your [pc.cumNoun]-slick shaft from [arian.eir] cock-slit, waiting to see if [arian.ey]'ll manage to poke [arian.eir] own cock");
	if (arian.cockTotal() > 1) output("s");
	output(" out before cumming.");
	
	output("\n\nArian groans in relief as a small [pc.cumColor] eruption comes out of [arian.eir] [pc.cumNoun]-filled slit, soaking [arian.eir] white scales in your combined jism.  Then, a ");
	if (arian.cockTotal() > 1) output("pair of cummy masts emerge");
	else output("cummy mast emerges");
	output(" to feebly shoot a couple more ropes of jism, before returning limply to ");
	if (arian.cockTotal() > 1) output("their");
	else output("its");
	output(" hiding place.  \"<i>Ahhh,</i>\" is all Arian says, before slumping down.");
	
	output("\n\nYou pat [arian.em] on the shoulder in a friendly fashion and, with a wicked grin on your face, ask if [arian.ey] enjoyed that too.");
	
	output("\n\nArian sighs and looks at you.  \"<i>It was good.  Weird... but good.  Though, I don't think I'd ever felt so much pressure inside before; if you hadn't pulled out in time, I might have busted a nut.</i>\"  [arian.ey] smiles tiredly.");
	
	output("\n\nYou draw [arian.em] into a deep kiss, holding [arian.em] tight and kissing [arian.em] until [arian.eir] need for air forces you to disengage. Cocking your head to the side, you stroke [arian.eir] face gently, telling [arian.em] that you're glad [arian.ey] wasn't hurt. After all, you need your little lap-lizard in tiptop shape.");
	
	output("\n\nArian gives you a winning grin.  \"<i>I wonder why,</i>\"  [arian.ey] says, rubbing at [arian.eir] used slit.");
	
	output("\n\nYou tell [arian.em] the sex is nice, but there's other things in [arian.eir] favor too.  Then, you kiss [arian.em] again before [arian.ey] can ask what those are.  While [arian.ey]'s left reeling, blissed out and goofy from the sexual overwhelm, you quietly slip out of [arian.eir] bed, pull your clothes back on and slip away, blowing [arian.em] a kiss before you depart.");
	
	//Player returns to camp
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Give Item
private function giveArianAnItem():void {
	clearOutput();
	output("Thinking about the many items in your possession, you ask if Arian would be willing to take something for you?");
	
	//(if ArianHealth < 10) //May not give anything.
	if (int(flags["COC.ARIAN_S_DIALOGUE"]) < 1) {
		output("\n\n\"<i>Uhh... I'd rather not.  I'm not feeling very well, and I don't think it's wise for me to be drinking anything, well... strange.</i>\"");
		
		output("\n\nYou nod your head in understanding and change the subject; if you want to give Arian any of the potions you've found, you'll need to nurse him back to strength first.");
		//Display other Arian interaction options
		arianHomeMenu();
		return;
	}
	else if (arian.health() < 20) { //May only give Vitality T.
		output("\n\n\"<i>Is it medicine you've brought me?  If so I'll be happy to take it; otherwise I think we should wait until I'm better; especially after that scolding you gave me earlier...</i>\"");
		
		//If PC has Vitality T. go to Give VT section. Otherwise, play below:
		if (!pc.hasItem(new CoCVitalityTincture())) {
			output("\n\nYou admit you don't have any medicine on you at the moment, and change the subject.");
			arianHomeMenu();
			return;
		}
		//Display other Arian interaction options
	}
	else { //Anything goes baby.
		output("\n\n\"<i>Well, I guess it's okay.  I don't think you'd ever give me anything harmful, and if you have anything to... err... spice up the sex, I'd be happy to take it.</i>\"  Arian blushes.");
		//Display PC inventory
	}
	
	clearMenu();
	if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 0 && arian.health() >= 10) arianStoryDialogue1();
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 1 && arian.health() >= 20) arianStoryDialogue2();
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 2 && arian.health() >= 30) arianDialogue3();
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 3 && arian.health() >= 50) arianImbue();
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 4 && arian.health() >= 75) arianPlot4();
	else if (int(flags["COC.ARIAN_S_DIALOGUE"]) == 5 && arian.health() >= 100) arianPlot5();
	else {
		addDisabledButton(0, "Vital Tinct", "Vitality Tincture", arian.health() < 100 ? "You don't have any." : "Arian don't need them anymore.");
		if (pc.hasItem(new CoCVitalityTincture()) && arian.health() < 100) addButton(0,"Vital Tinct",arianVitalityTincture);
		if (arian.health() >= 20) {
			addDisabledButton(1, "P. Incubi D");
			addDisabledButton(2, "P. Suc.Milk");
			addDisabledButton(3, "Lactaid");
			addDisabledButton(4, "Reducto");
			addDisabledButton(5, "Reptilum");
			if (pc.hasItem(new CoCIncubiDPure())) addButton(1,"P. Incubi D",giveIncubusDraftToArian);
			if (pc.hasItem(new CoCSucMilkPure())) addButton(2,"P. Suc.Milk",succubiMilkForArian);
			if (pc.hasItem(new CoCLactaid())) addButton(3,"Lactaid",giveArianLactaid);
			if (pc.hasItem(new CoCReducto())) addButton(4,"Reducto",giveArianReducto);
			if (pc.hasItem(new CoCReptilum())) addButton(5,"Reptilum",giveArianReptilum);
		}
		addButton(14,"Back",arianHomeMenu);
	}
}

//Vitality Tincture:
//increases ArianHealth by 4.
//Remove this option once Arian's health hits 100.
private function arianVitalityTincture():void {
	clearOutput();
	output("Fishing around amongst your pockets, you withdraw a vial of that strange potion Giacomo peddles and offer it to the sickly lizan, explaining it will bolster [arian.eir] constitution and fill [arian.em] with permanent vitality.");
	
	output("\n\nArian smiles gratefully at you.  \"<i>Thanks for doing this for me, [pc.name].</i>\"");
	
	output("\n\nYou tell [arian.em] it's no trouble, then smirk and note it's not as if that sleazy peddler's hard to find out there in the wasteland, anyway.  You see the look on the lizan's face and hasten to assure [arian.em] that you're certain the potion works, you just don't trust that weasely merchant as far as you can throw him.");
	
	output("\n\n\"<i>If you say so...</i>\" Arian takes the potion and uncorks the vial.  \"<i>Here goes.</i>\"  [arian.ey] chugs the potion down at once, making a face once [arian.ey]'s done.  \"<i>Ugh... If I didn't know better I'd say you're trying to murder my taste buds.</i>\"");

	output("\n\nSurely it's not that bad?  The potion smelled vaguely like cherries, it can't be as bad as Arian is making it to be...");
	
	output("\n\nArian shakes [arian.eir] head.  \"<i>It's medicine... medicine is never good.  And it has cherries.  I hate cherries,</i>\" Arian notes in disgust.");
	
	output("\n\nYou apologize, but, hey, medicine just tends to taste nasty anyway.  Still, it's doing [arian.em] the world of good, now isn't it?");
	
	output("\n\n\"<i>I guess I do feel better.  Thank you [pc.name].</i>\" Arian smiles at you, already looking a bit better.");
	
	output("\n\nYou smile and stroke the lizan gently on [arian.eir] head, telling [arian.em] that [arian.ey]'s welcome.  Now, you think it's time [arian.ey] laid [arian.em]self back down and got some rest; give the medicine time to work.  You promise you'll try and come back to see [arian.em] later, but right now, [arian.ey] needs to get some more rest.  Arian nods and settles [arian.em]self on [arian.eir] bed.");
	
	pc.destroyItem(new CoCVitalityTincture());
	arian.health(10);
	clearMenu();
	addButton(0,"Next",giveArianAnItem);
}

//P. Incubus Draft:
//Increase Cock(s) size. Gives one cock if Arian lacks any.
//If cock(s) size is maxed, next dose reduces breast size.
//If at min breast size, next dose reverts Arian to male. (Lose breasts and vagina.)
private function giveIncubusDraftToArian():void {
	clearOutput();
	pc.destroyItem(new CoCIncubiDPure());
	
	output("Fishing around in your pockets, your hand closes on the vial of purified incubus draft.  You offer this to Arian, asking ");
	if (arian.hasCock()) output("if [arian.ey] would like to make [arian.eir] cock bigger");
	else output("if [arian.ey]'d like to have a touch of [arian.eir] old malehood back");
	output(".");
	
	output("\n\nArian blushes.  \"<i>I don't mind the way I am now, but if you want me to take it I'd be happy to.</i>\"  Arian smiles nervously at you.");
	
	output("\n\nYou tell [arian.em] that you would like [arian.em] to take it, and hold it out to the lizan with greater emphasis.  Arian takes the draft, uncorks it and chugs it down.");
	
	if (!arian.hasCock()) {
		arian.createCock();
		arian.shiftCock(0, GLOBAL.TYPE_SNAKE);
		arian.cocks[0].cLengthRaw = ARIAN_COCK_SIZE_1;
		arian.femininity = 50;
		output("\n\nThe changes start at once.  Arian shudders as a wave of arousal hits [arian.em] and quickly opens [arian.eir] robes to watch in awe as a slit appears above [arian.eir] juicy feminine cunt.  It overflows with natural lubricant, and for a moment you think Arian is growing a second vagina.  The thought is quickly forgotten as you watch a reptilian, bulbous, purple dick emerge from its depths; it grows to an average size before Arian moans and cums, spraying herself with [arian.eir] newly acquired tool.");
		
		output("\n\nYou make a show of smirking and shaking your head.  My, but Arian needs to work on [arian.eir] control, now doesn't [arian.ey]?  To think [arian.ey]'d cum just from growing a sweet little cock like this.  You reach out and stroke the hermaphroditic member, gently trailing your fingers across its reptilian bumps and nodules.  A tiny part of you shivers in anticipation of it plumbing into your ");
		if (pc.hasVagina()) output("[pc.vagina] and ");
		output("[pc.asshole].");
		
		output("\n\n\"<i>Wait!  I'm still sensi-Ahhh!</i>\"  Arian's shaft throbs and another jet of cum arches through the air to hit [arian.em] squarely on [arian.eir] face.  Panting, Arian says, \"<i>I-I think I need a rest now...</i>\"  [arian.ey] collapses on [arian.eir] bed, prehensile, reptilian tail waving about in a display of enjoyment.");
		
		output("\n\nA part of you wonders if maybe [arian.ey]'s hoping you'll join [arian.em] in bed, but then you take a closer look and concede that [arian.ey] is genuinely tired.  You stroke [arian.em] affectionately on [arian.eir] scaly cheek and politely excuse yourself, heading back to camp.");
		pc.lust(10 + pc.libido() / 20);
	}
	else if (arian.longestCockLength() < ARIAN_COCK_SIZE_3) {
		
		pc.lust(10 + pc.libido() / 20);
		arian.cocks[0].cLengthRaw = arian.cocks[0].cLengthRaw = ARIAN_COCK_SIZE_1 ? ARIAN_COCK_SIZE_2 : ARIAN_COCK_SIZE_3;
		if (arian.cockTotal() > 1) arian.cocks[1].cLengthRaw = arian.cocks[0].cLengthRaw;
		
		output("\n\nThe changes start at once. Arian shudders as a wave of arousal hits [arian.em] and quickly opens [arian.eir] robes to watch [arian.eir] ");
		if (arian.cockTotal() < 2) output("shaft emerges from its hiding place.  It throbs and grows, settling in its");
		else output("pair of shafts emerge from their hiding place.  They throb and grow, settling in their");
		output(" new size as Arian moans and cums all over [arian.em]self.");
		
		output("\n\nYou gently flick a strand of cum off of the lizan's belly.  So, how does [arian.ey] like the new and improved lizard cock?  Arian swallows audibly and tries to retract [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s back into their");
		else output(" back into its");
		output(" slit.");
		if (arian.longestCockLength() == ARIAN_COCK_SIZE_2) {
			output("\n\n[arian.ey] manages to tuck it in, although you have the impression you wouldn't have to reach too far inside to feel its tip.");
			
			output("\n\n\"<i>It's a tight fit, but I think I can still keep it inside,</i>\" Arian sighs in pleasure.  \"<i>It did feel good though; thank you, [pc.name].</i>\"");
			
			output("\n\nYou smirk and tell [arian.em] that maybe you'll ask [arian.em] to show you how it feels in an up-close and private demonstration later, but, for now, you'll let [arian.em] get some sleep.  Arian nods, blushing.  \"<i>I'm looking forward to it.</i>\"  [arian.ey] smiles nervously at you.");
			
			output("\n\nYou smirk and pat [arian.eir] head, tell [arian.em] you'll come back for it when you can, and then politely excuse yourself.");
		}
		else {
			output("\n\n[arian.ey] manages to retract ");
			if (arian.cockTotal() > 1) output("them");
			else output("it");
			output(" until two thirds are inside, then it doesn't looks like [arian.ey] can take in anymore.");
			
			if (arian.cockTotal() > 1) output("\n\n\"<i>W-Wow, they're so big I can't even manage to hide them,</i>\" Arian pants as the tip of [arian.eir] cocks hang limply, exposed for all to see.");
			else output("\n\n\"<i>W-Wow, it's so big I can't even manage to hide it,</i>\" Arian pants as the tip of [arian.eir] cock hangs limply, exposed for all to see.");

			output("\n\nYou can't resist reaching down and gently tweaking the exposed tip.  Mmm... your little " + arian.mf("boy-toy","herm-toy") + " is going to be a very naughty thing from now on, you tease, unless [arian.ey] intends to start wearing a loincloth?");
			
			output("\n\nArian shudders at your touch.  \"<i>I-I'd have to ask Boon for one of [arian.eir].  I don't have any here.</i>\"  Arian blushes.");
			
			output("\n\nYou smile playfully at [arian.em] and ask if [arian.ey] would like you to go and fetch one now?");
			
			output("\n\n\"<i>N-No!  I couldn't stand it if Boon and Laika found out I look like this,</i>\" Arian says, pointing towards [arian.eir] exposed shaft");
			if (arian.cockTotal() > 1) output("s");
			output(".");
			
			//if ArianHerm:
			if (arian.hasVagina()) {
				output("\n\nYou can't resist quirking an eyebrow and asking if this is really more embarrassing than revealing that [arian.ey]'d grown an egg-filled womb and a pussy to use with it?  \"<i>Well, yes!  They'll give you a hard time too for getting me to do this, you know?</i>\" Arian protests.");
				
				output("\n\nYou smile and tap [arian.em] playfully on the nose, pointing out the difference between you and [arian.em] is that you don't care what two overprotective ferrets have to say about how [arian.ey] looks.  You think [arian.ey]'s hot like this.  Arian blushes at that.  \"<i>Then... I'll go without wearing a loincloth?</i>\"  You tell [arian.em] that'd be very naughty, but you think it'd be kind of sexy, too.  Arian smiles nervously, \"<i>Ok, then that's what I'll do... c-can't wait to use it...</i>\" [arian.eir] tip");
				if (arian.cockTotal() > 1) output("s");
				output(" starts hardening, no longer able to hide Arian's excitement inside [arian.eir] protective slit.");
			}
			else {
				output("\n\nYou admit it probably would be a bit embarrassing, especially if Boon's bigger than Arian is now.  Arian blushes.  \"<i>Well, [arian.ey] really isn't. If anything it might be tight.  I might have to go without one...</i>\"");
				
				output("\n\nYou raise an eyebrow, and ask if [arian.ey]'s not secretly at least a little happy about that?  After all, big dicks seem to be pretty admired in this sex-mad world.  Arian looks away in embarrassment, but smiles all the same.  \"<i>It is pretty big isn't it?  I guess it's not that bad.</i>\"");
				
				output("\n\nYou point out you wouldn't have given the lizan such a big dick if you didn't think they were sexy.  To be honest, you'd kind of like to know [arian.ey] was going around with this impressive monster hanging out under [arian.eir] robes; it's very flattering.  \"<i>T-then I won't use one.</i>\"  Arian's cock hardens a bit.  \"<i>Although it might be hard to hide my... urges.</i>\"  Arian looks at you nervously.");
			}
			output("\n\nYou give the lizan a kiss on the cheek, and ask if [arian.ey]'s sure [arian.ey] doesn't want to give it a test run before you go.  Arian's cock hardens, pointing at you and throbbing at the idea, even as a small droplet of cum gathers on [arian.eir] tip; Arian fumbles and makes an attempt to hide [arian.eir] excitement.  \"<i>T-this is going to take some getting used to...</i>\"");
			
			output("\n\nYou apologize and tell the lizan you've teased [arian.em] enough; you'll give [arian.em] a chance to calm down, and politely excuse yourself to head back to camp.");
		}
	}
	//(else if ArianBreasts > 1) //Boob shrinkage.
	if (arian.breastRows[0].breastRatingRaw > 1) {
		arian.breastRows[0].breastRatingRaw -= 2;
		output("\n\nArian shudders as [arian.ey] feels the changes sweep through [arian.em], but rather than settling on [arian.eir] huge lizan shaft, the warmth that precedes change settles on [arian.eir] breasts.  Arian moans and kneads [arian.eir] mounds as they shrink to a smaller size.");
		output("\n\n\"<i>Well, at least my chest won't feel so heavy anymore.  I hope you're not disappointed?</i>\" Arian asks, panting.");
		output("\n\nYou just smile back at [arian.em] and tell [arian.em] you can live with it.  Arian sighs.  \"<i>Good, they did feel kinda nice, though.</i>\"  You detect a hint of disappointment in [arian.eir] voice.");
		output("\n\nConfused, you comment that Arian was hatched as a boy; you'd have thought [arian.ey]'d be more comfortable to be flatter up there.  Arian blushes. \"<i>I-....  You've convinced me there are... perks related to that.</i>\"  Arian bites [arian.eir] lower lip.  \"<i>Not that I miss having big breasts.  My back will also thank me, but they did feel nice and....</i>\"  Arian giggles.  \"<i>Laika would always give me the funniest looks, since her's kinda... flat.</i>\"");
		
		output("\n\nYou wonder if maybe Laika had ulterior motives for those looks, but keep that thought to yourself. You ask if Arian would like to do something, or if you should leave [arian.em] to get on with [arian.eir] work? Arian looks at you expectantly. \"<i>I wouldn't refuse if you wanted to do anything.</i>\", [arian.eir] dick growing hard at your suggestion.");
		//Display sex menu
		arianSexMenu(false);
		return;
	}
	else if (arian.breastRows[0].breastRatingRaw == 1) { //Now you are male again.
		output("\n\nArian shudders as [arian.ey] feels the changes sweep through [arian.em], but rather than settling on [arian.eir] huge lizan shaft, the warmth that precedes change settles on [arian.eir] breasts.  Arian moans and kneads [arian.eir] mounds as they shrink until they are completely gone.  [arian.eir] nipples follow suit, being replaced by smooth scales.");
		
		output("\n\nArian moans as another change happens below; [arian.ey] spreads [arian.eir] legs and watch in wonder as the lips [arian.eir] wet fuckhole join together, becoming smooth scales as well.  A few more subtle changes occur as Arian's body shift towards the masculine and finally settles down.  Arian breaths a sigh of relief.");

		output("\n\n\"<i>I guess I'm male now?</i>\" Arian's voice sounds more masculine as well.");
		arian.breastRows[0].breastRatingRaw = 0;
		arian.removeVaginas();
		output("\n\nYou note that seems to be the case.  So, is [arian.ey] going to miss being even half-girl?  Arian rubs [arian.eir] chin.  \"<i>Well, it was weird, but it was kinda nice too.</i>\"  [arian.ey] looks at you, smiling nervously.  \"<i>I'd spend some time in the mornings looking in the mirror.  I guess I didn't look so bad as a girl?</i>\"");
		output("\n\nYou note that [arian.ey] was quite pretty, but you think [arian.ey]'s just as handsome now.  Besides, being all-guy means no more dealing with eggs, right?");
		output("\n\nArian blushes, averting [arian.eir] eyes in embarrassment.  \"<i>It wasn't that bad... the whole deal with the eggs I mean.</i>\"");
		output("\n\nHe can really say that?  After actually going through the painful process of laying them?  Because, if [arian.ey] can, well, you think you'd have to call Arian one of the manliest men you've met in this world.");
		
		output("\n\nArian smiles at you.  \"<i>It didn't hurt that much.</i>\"  Then [arian.ey] blushes.  \"<i>It felt kinda nice... actually.</i>\"");
		
		output("\n\nYou just shake your head and clap him on the shoulder.  Well, maybe you'll give him [arian.eir] vagina back, if [arian.ey] really didn't mind being half-girl that much.  But, right now, you think [arian.ey] should try and get used to being all-man again.");
		
		output("\n\nArian averts [arian.eir] eyes.  \"<i>Of course.  If that's what you think.</i>\"");
		
		output("\n\nYou reply that is what you think.  So, does [arian.ey] feel up to doing anything else, or should you leave him to get some rest?");
		
		output("\n\nArian's cock begins hardening.  \"<i>Well, I wouldn't mind doing anything else... if you want to.</i>\"");
		
	}
	else { //Nothing happens.
		output("\n\nArian moans and you can see [arian.ey]'s getting turned on, if the hardening tip of [arian.eir] exposed shaft is any indication, but you don't detect any change besides that.");
		output("\n\n\"<i>I guess this is my limit?</i>\" Arian pants.");
		output("\n\nYou admit that seems to be the case, and ask if [arian.ey]'d be willing to do something else, seeing as how that was a bust?  \"<i>Uhh... Sure.  What do you want to do?</i>\"");
	}
	//Back to Arian's Menu
	clearMenu();
	addButton(0,"Next",giveArianAnItem);
}



//P. Subbi's Milk:
//Gives Vagina and Breasts, also feminine curves if Arian was male.
//Extra doses increase breasts size.
//If breasts is at maximum size, extra doses reduce Cock Size. Removing first the second cock and then the first one if necessary.
private function succubiMilkForArian():void {
	clearOutput();
	pc.destroyItem(new CoCSucMilkPure());
	
	output("Fishing out the bottle of purified demon's milk, you ask if Arian is willing to get ");
	if (arian.hasVagina()) output("further ");
	output("in touch with [arian.eir] feminine side.  For you?");
	
	output("\n\nArian bites [arian.eir] lower lip.  \"<i>For you?  Of course I wouldn't mind it.</i>\"  You pass over the bottle, and watch as [arian.ey] removes the cork and drinks its contents.");
	
	//(if ArianVagina == 0) //Arian... you look so pretty!
	if (!arian.hasVagina()) {
		if (arian.breastRows[0].breastRatingRaw == 0)
			arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_1;
		arian.femininity = 50;
		arian.createVagina();
		arian.shiftVagina(0, GLOBAL.TYPE_SNAKE);
		
		output("\n\nArian gasps and moans, a throaty, girly moan. [arian.ey] opens [arian.eir] robes to watch as the changes sweep through [arian.eir].  First the smooth scales of [arian.eir] chest begin flaking off, making way for a pair of erect nipples; following the growth of said nipples, [arian.eir] previously flat chest begins inflating, growing into perky scaly breasts.  Down below, Arian feels a wave of heat gather between [arian.eir] legs; once [arian.ey] spreads them, [arian.ey] gasps.  A slit appears, the surrounding scales become smaller and softer, forming what looks like a tight little pussy.  Arian's newly formed labia puff up and juices begin flowing freely from the moist passage, even as Arian's little pleasure buzzer appears to slightly part [arian.eir] labia in a clear invitation for you to explore its depths.");
		output("\n\nYou drag your eyes away from Arian's new vagina and look the newly hermified lizan in the eyes, asking if [arian.ey] feels all right.  Arian pants, questing hands wandering towards [arian.eir] breasts to gently grope them. \"<i>Hot... so hot...</i>\" Arian's shaft hangs fully out of its hiding place, rock hard and throbbing.");
		output("\n\nYou tell [arian.em] you'll get [arian.em] something cold to drink, turning towards the door.  \"<i>H-hurry, please!</i>\"  You need no further encouragement and quickly race to the kitchen, where you grab a jug of water from the coldbox and run back with it, as quickly as you dare.");
		
		output("\n\nAs soon as you enter Arian's room, [arian.ey] sweeps the jug from your hands and begins downing the water.  You watch in amazement as Arian drains the jug of all its water, some stray droplets falling on [arian.eir] exposed scales, forming small rivulets that trace Arian's increasingly feminine curves.  Once Arian is done [arian.ey] sighs with relief, quietly handing you the jug and wiping [arian.eir] lips with a forearm.  \"<i>Thanks, [pc.name].  I really needed that.</i>\"  Arian smiles at you, no longer hot to the point of boiling.  [arian.eir] previously erect cock");

		if (arian.cockTotal() > 1) output("s");
		output(" having already softened and retracted");
		//if ArianCockSize >= 3:
		if (arian.longestCockLength() == ARIAN_COCK_SIZE_3) output(" as far as it'll go");
		output(" into its protective slit.");
		
		output("\n\nYou cautiously ask if Arian is feeling okay; [arian.ey]'s just undergone quite the dramatic change.  Arian looks herself over, running [arian.eir] hands across [arian.eir] newly feminized body.  \"<i>I guess I'm fine.  I certainly feel fine, at least.</i>\"");
		
		output("\n\nYou can't help noting [arian.ey] looks pretty fine, too.  Arian blushes at your comment.  \"<i>Umm... thanks.</i>\"  One of Arian's questing hands find [arian.eir] newly formed slit, and [arian.ey] gasps in pleasure as [arian.ey] circles [arian.eir] soft labia with a clawed finger, smearing some of [arian.eir] juices on [arian.eir] finger.  [arian.ey] lifts the finger to [arian.eir] face and watch the moisture drip from [arian.eir] digit; then, without sparing a thought, [arian.ey] takes the finger into [arian.eir] mouth and begin lightly sucking on the digit.");
		
		output("\n\nYou pointedly cough and tell [arian.em] that, while you're not necessarily minding if [arian.ey] wants to try out [arian.eir] new body, does [arian.ey] really want to put on a show for you, or would [arian.ey] rather you leave?  Arian snaps out of [arian.eir] trance, blushing in embarrassment.  \"<i>Oh! Sorry!</i>\"  Arian attempts to cover [arian.eir] breasts and crotch with [arian.eir] arms. [arian.ey] fidgets a bit, then smiles nervously at you.  \"<i>Umm, Maybe you'd like to help me get used to my new body?</i>\" Arian averts [arian.eir] eyes, blushing furiously at what [arian.ey] just said.");
		output("\n\nYou step forward and gently run your hands over [arian.eir] newfound breasts. Well, if that's what [arian.ey]'s in the mood for, you're game.");

	}
	else if (arian.breastRows[0].breastRatingRaw < ARIAN_BREASTS_SIZE_3) {
		output("\n\nWarmth sweeps through Arian's body, eliciting a gasp and a moan.  Soon the warmth settles on Arian's mounds, and [arian.ey] opens [arian.eir] robes to gaze at the change that is taking place.");
		arian.breastRows[0].breastRatingRaw = arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_1 ? ARIAN_BREASTS_SIZE_2 : ARIAN_BREASTS_SIZE_3
		
		//(if ArianBreasts == 2)
		if (arian.breastRows[0].breastRatingRaw  == ARIAN_BREASTS_SIZE_2) {
			output("\n\nArian's perky breasts inflate into perfect, soft-looking mounds.  Arian gropes [arian.eir] newly enlarged breasts tentatively and gasps in pleasure at their softness and sensitivity.  \"<i>It feels nice.</i>\"  Looking at you with a blush, Arian asks, \"<i>Would you like to touch them?</i>\"");
			
			output("\n\nSeeing no reason to pass up the opportunity, you reach out and gently take hold of them, rolling their weight around in your hands.  You make a show of remarking to Arian that you had no idea scaly boobs could be so wonderfully soft and perky.");
			
			output("\n\nArian gasps and sighs as you gently massage [arian.eir] breasts.  \"<i>[pc.name]... this feels good.</i>\"");
			
			output("\n\nYou note it feels pretty nice for you as well.  Still, does Arian maybe want to turn things up a notch in the intimacy department?  Arian blushes.  \"<i>You won't hear me complain.</i>\"  [arian.ey] starts fidgeting");
			if (arian.longestCockLength() >= ARIAN_COCK_SIZE_3) output(" and [arian.eir] exposed shaft begins to grow hard");
			output(".");
		}
		else {
			output("\n\nArian's generous mounds inflate once more.  Arian gasps in pleasure, their growth also enhancing the lizan's sensitivity.  Once their expansion is finished, Arian lifts the huge orbs in awe.  \"<i>T-they're huge... and so heavy.</i>\"  [arian.ey] rolls the breasts in [arian.eir] hands, gently touching [arian.eir] soft scales and sensitive nipples, gasping and panting in pleasure.");
			
			output("\n\nYou note they look pretty big as well; why, [arian.ey] must be the bustiest lizan you've ever seen.  Arian blushes, and bites [arian.eir] lower lip.  \"<i>Do you like them?</i>\"  You give [arian.em] a flat look and reach out to caress the breasts.  If you didn't like big breasts, well, why would you have asked [arian.em] to grow them this big?  But is [arian.ey] comfortable with them being like this?");
			output("\n\nArian shudders at your touch.  \"<i>They are kind of heavy, but if you really like them, I don't mind keeping them.</i>\"  Arian smiles nervously at you.  \"<i>I hope you will help me carry them?</i>\"  [arian.ey] fidgets");
			if (arian.longestCockLength() >= ARIAN_COCK_SIZE_3) output(" and you see [arian.eir] exposed shaft slowly rising to point at you");
			output(".");
			
			output("\n\nYou cup the bountiful scaly bosom in your hands and tell [arian.em] that's something you're quite willing to do.  Still, perhaps [arian.ey]'d rather... take the weight off of [arian.eir] feet, mm?  You finish, leaning in to dart a playful lick across the tip of [arian.eir] snout to make your insinuations more obvious.");
			output("\n\nArian blushes furiously, but smiles at you all the same.  \"<i>I... would love to.</i>\"");
		}
	}
	//(else If ArianCockSize > 1) //Dick shrinkage.
	else if (arian.longestCockLength() > ARIAN_COCK_SIZE_1){
		output("\n\nWarmth flows throughout Arian's body, and [arian.ey] moans in obvious pleasure.  Then, [arian.ey] opens [arian.eir] robes and looks at [arian.eir] rock-hard bulbous shaft.  It throbs as if edging a massive orgasm, but much to Arian's surprise it starts to shrink, until it finally grows limp and hides itself in its protective slit.  \"<i>I... didn't expect that,</i>\" Arian remarks.");
		
		output("\n\nYou note it's not that surprising; the potion in question is a feminizer, so it must be shrinking away the only trace of [arian.eir] masculinity left - [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s");
		output(".  \"<i>Oh... that's good.  Right?</i>\" Arian looks at you nervously.  You think it over, and confess that while you are more attracted to women than men, you won't force Arian to become fully female if [arian.ey] doesn't want to.");
		output("\n\nArian smiles at your consideration.  \"<i>Thank you, [pc.name], but if you'd prefer me to be a girl... err... completely female, I wouldn't object.  I'm fine either way.</i>\"  Arian grins.");
		
		output("\n\nYou ask, then, if Arian's so comfortable with [arian.eir] girly side, maybe [arian.ey]'d like to try out [arian.eir] more female parts?  Arian blushes and averts [arian.eir] eyes, nodding lightly.");
		
		arian.cocks[0].cLengthRaw = arian.cocks[0].cLengthRaw == ARIAN_COCK_SIZE_3 ? ARIAN_COCK_SIZE_2 : ARIAN_COCK_SIZE_1;
		if(arian.cockTotal() > 1) arian.cocks[1].cLengthRaw = arian.cocks[0].cLengthRaw;
	}
	else if (arian.cockTotal() > 1) {
		arian.removeCock(1);
		output("\n\nWarmth flows throughout Arian's body, and [arian.ey] moans in obvious pleasure.  Then [arian.ey] opens [arian.eir] robes and looks at [arian.eir] pair of rock-hard bulbous shafts.  They throb as if edging a massive orgasm, but much to Arian's surprise they begin to merge, until only one reptilian dick remains; finally it grows limp and recedes into its hiding place.  \"<i>They fused into one,</i>\" Arian remarks.");
		
		output("\n\nMaybe it's because of the increasingly high femininity the milk is bestowing on [arian.em], you suggest?");
		
		output("\n\n\"<i>Maybe... that's good, right?</i>\" Arian asks.  You simply meet [arian.eir] gaze levelly and tell [arian.em] that it's good if [arian.ey] wants it to be good; if [arian.ey]'s uncomfortable with what you're doing to [arian.em], [arian.ey] needs to tell you and you'll stop, you promise.");
		
		output("\n\n\"<i>No!  I'm fine!</i>\" Arian insists.  \"<i>I'm just not used to, well... reshaping my body like this.  But if you think I look better this way, then I'm happy to comply.</i>\"  Arian smiles.");
		
		output("\n\nYou tell [arian.em] that, for what it's worth, you do think [arian.ey]'s beautiful, then give [arian.em] a lustful grin and ask if [arian.ey]'d like you to show [arian.em] just how beautiful?");
		output("\n\nArian blushes.  \"<i>I... show me...</i>\"");
	}
	else if (arian.longestCockLength() == ARIAN_COCK_SIZE_1) {
		arian.removeCocks();
		output("\n\nWarmth flows throughout Arian's body, and [arian.ey] moans in obvious pleasure.  Then, [arian.ey] opens [arian.eir] robes and look at [arian.eir] rock-hard bulbous shaft.  It throbs and slowly recedes back into its hiding place.  An indignant rope of cum shoots into the air, splashing on [arian.eir] belly as the slit containing the last of [arian.eir] malehood finally closes up, leaving only smooth scales in its wake.  Arian pants, \"<i>Looks like I'm completely female now.</i>\"");
		
		output("\n\nYou agree with [arian.eir] summary, and then note [arian.ey]'s taking this quite calmly.  You mean, it had to be a shock just growing a pussy and laying eggs all the time, but now [arian.ey] doesn't even have [arian.eir] cock to go with it.");
		
		output("\n\nArian looks at you, blushing.  \"<i>Do you think I'm pretty?</i>\"");
		
		output("\n\nYou tell [arian.eir] that, yes, [arian.ey] makes a very pretty girl.");
		
		output("\n\nArian fidgets.  \"<i>Then, that's all I need.</i>\"  [arian.ey] smiles at you.");
		
		output("\n\nYou just look at [arian.em] steadily; is [arian.ey] really sure about that?  You did this to [arian.eir], surely you can bring [arian.em] something to undo it, if only partially?");
		
		output("\n\nArian shakes [arian.eir] head.  \"<i>I'm fine, [pc.name].  Really. If I didn't want or wasn't okay with anything I'd have said so by now.  So trust me when I say I'm fine.  Besides, this doesn't feel half bad, and I get to have you.</i>\"  [arian.ey] blushes.");
		
		output("\n\n\"<i>Get to have you.... or perhaps,</i>\" you grin, \"<i>the proper question should be how, hmm?</i>\"");
		
		output("\n\nArian bites [arian.eir] lower lip.  \"<i>Umm, we could do something I guess.  If you're up for it?</i>\"  Arian fidgets.");
	}
	else { //Nothing happens.
		output("\n\nWarmth flows throughout Arian's body, and [arian.ey] moans in obvious pleasure.  But suddenly, the warmth goes away, and Arian opens [arian.eir] robes to inspect the changes.  Nothing seems changed.  \"<i>I guess I can't get any more girly than being an actual girl,</i>\" Arian remarks.");
		 
		output("\n\nYou note that's the obvious imposition.  Still, if [arian.ey] wants to at least grow [arian.eir] penis back, you're sure you can find [arian.em] something, you offer; [arian.ey]'s clearly devoted to you, a little token kindness won't hurt you, you think.");
		
		output("\n\nArian shakes [arian.eir] head.  \"<i>No, I'm fine.  Unless you want me to have a penis?</i>\"");
		
		output("\n\nYou tell [arian.em] that you'll think about it; right now, you want to take the all-new, all-girl [arian.em] out for a spin... if [arian.ey]'ll let you, of course?");
		
		output("\n\nArian smiles and fidgets. \"<i>I could go for a spin...</i>\"");
	}
	//Display Sex Options.
	arianSexMenu(false);
}
//Lactaid:
//Triggers Scene with temporary lactation
//If Arian has breasts, Increases breasts size by 1.
private function giveArianLactaid():void {
	clearOutput();
	pc.destroyItem(new CoCLactaid());
	output("Your hand closes around the vial of lactation-inducing potion that is Lactaid.  You almost reject it automatically, but then you stop and think.  There's odder things in this world, after all.  You remove the vial and ask Arian if [arian.ey] would be willing to let you see what lizan milk tastes like.");
	
	output("\n\n\"<i>I don't know.  Lizans don't actually lactate, since we lay eggs, so I don't know if this...</i>\"  Arian squints [arian.eir] eyes to read the label on the vial you're holding.  \"<i>...Lactaid will even work.  But if you want to try, I suppose it couldn't hurt... right?</i>\"  Arian smiles nervously.");
	
	output("\n\nYou assure the lizan that, at worst, it'd just fail to do anything, and hand the vial of lactaid to [arian.em].  [arian.ey] takes the offered bottle and smiles at you.  \"<i>All right.</i>\"");
	
	output("\n\nArian removes the cork and downs thick milky liquid, passing you the emptied vial.  \"<i>That tasted kinda nice...</i>\"");
	
	output("\n\nThe two of you sit in awkward silence awaiting for anything to happen.");
	
	if (arian.breastRows[0].breastRating() == 0) {
		output("\n\nAfter some time, Arian sighs and opens [arian.eir] robes, rubbing [arian.eir] chest.  \"<i>I don't think it worked.  At least... I don't feel any different.</i>\"");
		
		output("\n\nYou note that's strange, and wonder what could have stopped it working.  You shrug and suggest maybe it was Arian's lack of existing breasts?  Still, no harm done; would Arian maybe like to do something else instead?");
		
		output("\n\nHe shrugs and closes [arian.eir] robes.  \"<i>I'm sorry it didn't work, [pc.name].  If you want to do something else, just say so.</i>\"  Arian smiles at you.");
		clearMenu();
		addButton(0,"Next",giveArianAnItem);
	}
	else { //Lizard milk! Recover some HP and fatigue.
		pc.energy(15);
		pc.HP(pc.maxHP() * 0.2);
		output("\n\nAfter some time, Arian begins panting, sweating as [arian.eir] body temperature goes up.  \"<i>I feel... hot.</i>\"  In an attempt to lower [arian.eir] body temperature, Arian discards [arian.eir] robes and lays down on [arian.eir] bed, fanning herself with [arian.eir] clawed hands.");
		
		output("\n\nYou approach [arian.em] cautiously, asking if [arian.ey]'s okay.");
		
		output("\n\n\"<i>My breasts feel ticklish.</i>\"  Suddenly, Arian gasps in pleasure");
		if (arian.longestCockLength() == ARIAN_COCK_SIZE_3) output(", [arian.eir] exposed cock growing hard as [arian.ey] flushes with arousal");
		output(".  [arian.eir] hands grip the sheets and you watch [arian.eir] ");
		if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_1) output("perky");
		else if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_2) output("luscious");
		else output("pillowy");
		output(" breasts grow before your eyes.  \"<i>My breasts... d-do something, [pc.name]!</i>\" Arian pleads.  Unsure of what you should be doing, you grab [arian.eir] breasts and begin kneading them as they grow in your hands; [arian.eir] erect nipples poking your palms.  \"<i>Ah... that feels good!  Don't stop!</i>\"");
		
		output("\n\nYou can't resist a wry comment asking if this was maybe a ploy by Arian to get you to massage [arian.eir] breasts?  Because [arian.ey] seriously didn't need to play games if that's what [arian.ey] wanted.  [arian.eir] only reply is a moan of pleasure.  You chuckle and shake your head, continuing the massage, and that's when you notice dampness growing across your palms; lifting your hand up, you visually confirm and report to Arian that it worked; [arian.ey]'s making milk.  That must be why [arian.eir] breasts grew; to make room for the milk.");
		
		output("\n\n\"<i>G-great.  So, I guess it worked.  What do we do now?</i>\" Arian asks, still panting.");
		
		output("\n\nDoes [arian.ey] really have to ask?  You tease.  Giving [arian.eir] newly bountiful breasts a squeeze, you bend down and kiss [arian.eir] right nipple, softly sucking it between your lips.  The first few drops are not what you might have expected; it's surprisingly warm, with a taste reminiscent of sweet milk and herbal tea that you find tasty and relaxing all at once.  You need no further incentive to start suckling in earnest, rolling your reptilian lover's nipple around with your tongue to coax forth more yummy lizan milk.");
		
		output("\n\nArian moans and begins caressing the back of your head.  \"<i>Hmm, this is so weird, but not bad weird.  I never dreamed I would ever have breasts, much less nurse someone... with my own milk that is.  How does it taste?  Is it good?</i>\"  Arian asks, softly stroking your [pc.hair].");
		
		output("\n\nRather than answer verbally, you take a particularly deep suckle and release [arian.eir] nipple, holding the milk in your mouth as you pull the surprised lizan into a kiss, letting [arian.em] literally taste [arian.eir] own medicine as you pass the milk from your mouth to " + arian.mf("his", "hers") + ".  Arian is too stunned to do anything but gulp down the offered milk.  [arian.ey] drops [arian.eir] hands and focuses only on sucking down the offered milk.  Once you've run out of milk, you break the kiss, playfully lick a stray droplet from the corner of [arian.eir] mouth, then return your attention to [arian.eir] breast.  The lizan mage hugs your head to [arian.eir] breast, still stunned.  \"<i>D-drink all you want,</i>\" [arian.ey] says in a daze.");
		
		output("\n\nYou need no further encouragement and start thirstily draining Arian of all the milk [arian.ey] has to offer, the lizan moaning and sighing as [arian.ey] writhes gently underneath you.  Finally, any questions about whether or not the effects of this Lactaid are permanent are answered; you've drunk [arian.em] dry, and with a quiet burp you get off of [arian.em], somewhat gingerly touching your strained belly.");
		//pc.refillHunger(10 + (10 * flags[kFLAGS.ARIAN_BREASTS]));		
		output("\n\nArian sighs in relief.  \"<i>That felt nice.  Maybe we can do it again sometime?</i>\"");

		output("\n\nIf [arian.ey]'s willing, then certainly, you tell [arian.em], but you'll need to track down another vial first.  You think Arian should have a rest before then.  [arian.ey] nods and kneads [arian.eir] now emptied breasts.");
		
		//(if ArianBreasts < 3)
		if (arian.breastRows[0].breastRating() < ARIAN_BREASTS_SIZE_3) {
			
			if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_2) arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_3;
			if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_1) arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_2;
			if (arian.breastRows[0].breastRatingRaw == 0) arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_1;
			
			output("\n\n\"<i>Is it me or... are they bigger?</i>\" Arian asks curiously, looking at you and holding [arian.eir] scaly orbs.");
			output("\n\nYou look at them curiously, and then decide (and tell [arian.em]) that, yes, they have gotten bigger.  Probably a side effect of expanding to contain and produce the milk [arian.ey] just fed you.");
		}
		output("\n\nArian smiles tiredly.  \"<i>I think I'll rest for a little bit now... maybe you should too?</i>\"  [arian.ey] suggests, pointing at your bloated belly.");
		
		output("\n\nYou agree, and ask if [arian.ey]'ll be okay if you show yourself out.  Arian nods and yawns.  \"<i>I'll see you later then, [pc.name].</i>\"");
		
		output("\n\nYou leave [arian.em] to get some sleep and quietly show yourself out, planning to work off your meal elsewhere.");
		doNext(returnToCampUseOneHour);
	}
}

//Reducto:
//Reduces the size of a part
//Has a Back option, it displays no text, just cancels the interaction and goes back to previous menu.
private function giveArianReducto():void {
	clearOutput();
	output("Eyeing Arian up and down, you fish your pouches for a tube of Reducto.  Once you've found it, you hand it over to Arian and tell [arian.em] you'd like [arian.em] to reduce something for you.");
	output("\n\n\"<i>Umm... sure, which part?</i>\"");
	//(Display Options)
	clearMenu();
	if (arian.breastRows[0].breastRating() > 0) addButton(0,"Breasts",useReductoOnAriansBreasts);
	if (arian.hasCock()) addButton(1,"Cock",useReductoOnArianCocks);
	addButton(2,"Asshole",useReductoOnAriansAsshole);
}

//Breasts:
//Cannot go flat (NOT ANYMORE! Maleherms FTW!)
private function useReductoOnAriansBreasts():void {
	clearOutput();
	pc.destroyItem(new CoCReducto());
	output("You point at Arian's ");
	if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_1) output("small");
	else if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_2) output("generous");
	else output("pillowy");
	output(" breasts.  \"<i>Okay... I suppose it would be good to lose a bit of weight up here and spare my back.</i>\"  Arian smiles, opening the tube of Reducto and [arian.eir] robes; then squeezing the contents of the paste [arian.eir] hands.");
	
	output("\n\nArian kneads [arian.eir] breasts, lathering the paste all over [arian.eir] breasts.  You can't help but note that this is kinda sexy.  Arian's breasts glisten in the light of the room.  Once [arian.ey] is done, [arian.ey] cleans [arian.eir] hands with a piece of cloth that was laying nearby and waits for the Reducto's effect.");
	
	//(if ArianBreasts > 1)
	if (arian.breastRows[0].breastRating() > ARIAN_BREASTS_SIZE_1 || (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_1 && rand(2) == 0)) {
		output("\n\nArian gasps and the two of you watch as [arian.eir] breasts slowly shrink, setting into a smaller size.  You reach forward and feel [arian.eir] breasts; it's a much better fit for your hands now.");
		output("\n\nArian sighs.  \"<i>So... better now?</i>\"  You nod in response.  \"<i>Great!  Is there something else you'd like to do?</i>\"");
		
		if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_1) arian.breastRows[0].breastRatingRaw = 0;
		if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_2) arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_1;
		if (arian.breastRows[0].breastRatingRaw == ARIAN_BREASTS_SIZE_3) arian.breastRows[0].breastRatingRaw = ARIAN_BREASTS_SIZE_2;
	}
	else {
		output("The two of you watch Arian's breasts, but nothing seems to be changing.  You reach forward to feel them, and indeed they haven't shrunk down at all.");
		output("\n\n\"<i>Umm... I...</i>\"  Before Arian can continue, you tell [arian.em] that it's fine, you'll just have to find another way to get rid of [arian.eir] breasts.  \"<i>Okay.  So, is there anything else you'd like to do?</i>\"");
	}
	//(Back to Options menus)
	clearMenu();
	addButton(0,"Next",giveArianAnItem);
}
//Cock(s):
//Removes 2nd cock if at minimum size.
//Cannot remove cocks.
private function useReductoOnArianCocks():void {
	clearOutput();
	pc.destroyItem(new CoCReducto());
	output("You point at [arian.eir] crotch, mentioning that you'd like [arian.em] to be smaller.");
	output("\n\n\"<i>Oh, ok then.</i>\"  Arian opens [arian.eir] robes and squeezes the tube of Reducto on an open palm.");
	
	if (arian.biggestCockLength() >= ARIAN_COCK_SIZE_3) {
		arian.cocks[0].cLengthRaw = ARIAN_COCK_SIZE_2;
		if (arian.cockTotal() > 1) arian.cocks[1].cLengthRaw = arian.cocks[0].cLengthRaw;
		
		output("\n\nThen, [arian.ey] slowly teases [arian.eir] ");
		if (arian.cockTotal() > 1) output("pair of exposed lizard cocks");
		else output("exposed lizard cock");
		output(" into full erection.  Finally [arian.ey] begins applying the paste.");
		
		output("\n\nThe changes are almost immediate; Arian groans and watches as [arian.eir] oversized dick");
		if (arian.cockTotal() > 1) output("s");
		output(" slowly shrink");
		if (arian.cockTotal() < 2) output("s");
		output(" to a more manageable size.  Once the transformation is complete Arian tries to fully retract [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s back into their");
		else output(" back into its");
		output(" hiding place; it's a tight fit, but it fits.");
		
		output("\n\n\"<i>Phew.  I won't say I didn't enjoy being that size, but it feels a lot more natural and comfortable now that I don't have to walk about exposed.</i>\"  You nod in agreement.  \"<i>So, is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else if (arian.biggestCockLength() == ARIAN_COCK_SIZE_2) {
		arian.cocks[0].cLengthRaw = ARIAN_COCK_SIZE_1;
		if (arian.cockTotal() > 1) arian.cocks[1].cLengthRaw = arian.cocks[0].cLengthRaw;
		
		output("\n\nThen, [arian.ey]slowly teases [arian.eir] slit, coaxing [arian.eir] serpentine shaft");
		if (arian.cockTotal() > 1) output("s from their tight hiding place");
		else output(" from its tight hiding place");
		output(", and into full erection.  Finally [arian.ey] begins applying the Reducto.");
		
		output("\n\nIt takes mere moments for the changes to occur; Arian groans in slight discomfort as [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s return to their");
		else output(" returns to its");
		output(" original size.  Once the transformation is complete, [arian.ey] retracts ");
		if (arian.cockTotal() > 1) output("them");
		else output("it");
		output(" back into [arian.eir] genital slit.");
		
		output("\n\n\"<i>Well, it seems I'm back to being average sized,</i>\" Arian says with a tinge of disappointment.   You tell [arian.em] that average can be good too, in fact you happen to like average.  The lizan instantly cheers up and smiles at you.  \"<i>Thanks, [pc.name].  Is there anything else you'd like to do, now?</i>\"");
	}
	else if (arian.cockTotal() > 1) {
		arian.removeCock(1);
		
		output("Then, [arian.ey] coaxes [arian.eir] twin reptilian-peckers out of their hiding place.  Finally [arian.ey] applies the paste to both shafts in turn.");
		
		output("\n\nIt takes a short while for anything to happen, but when it does Arian groans.  \"<i>S-something feels different.  Ugh, this feels weird.</i>\"  You two watch as [arian.eir] shafts slowly reduce in size, then to your surprise merge together forming one average-sized cock, much like the one Arian sported before.");
		
		output("\n\n\"<i>I guess I'm back to begin a lizan with a single cock,</i>\" Arian says with a slight tinge of regret.  You cheer [arian.em] up by saying that's the way you prefer it, besides is it really that bad, having only one cock?  Arian smiles at you.  \"<i>I guess it isn't too bad, just unusual for my species, but if you like me like this, then I'm okay with it.</i>\"  You nod and pat [arian.em] gently on the head.  \"<i>So... is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else
	{ //Nothing happens
		output("\n\nThen coaxes [arian.eir] snake-dick out of its hiding place.  Finally [arian.ey] applies the paste on [arian.eir] dick and wait patiently for the changes to begin.");
		
		output("\n\nThe two of you wait for a while, but when no change happens Arian speaks up, \"<i>I guess... nothing changed?</i>\"  You're inclined to agree, something should've happened already.  Well that doesn't matter, you'll just have to try something else.  \"<i>Okay... so, anything else you'd like to do?</i>\"");
	}
	//(Back to Options menus)
	clearMenu();
	addButton(0,"Next",giveArianAnItem);
}

//Sphincter:
//Lose AnalXP, can't reduce it past 1.
//How much AnalXP should be lost per use is up to Fen.
private function useReductoOnAriansAsshole():void {
	clearOutput();
	pc.destroyItem(new CoCReducto());
	output("You ask Arian to hand the tube of reducto back over to you, telling [arian.em] that you want to make [arian.em] a little tighter when you do [arian.em] from behind.  The lizard-");
	if (arian.hasCock()) {
		if (arian.hasVagina()) output("man");
		else output("herm");
	}
	else output("woman");
	output(" does as you ask, allowing you to smear your fingers generously with the shrinking cream, even as [arian.ey] anticipates your next request and removes [arian.eir] clothes before lying down, bum up in the air and tail slowly swishing to and fro, [arian.eir] anus exposed and waiting for your ministrations.");
	//(if AnalXP == 1)
	if (arian.analExp() <= 1) {
		output("\n\n\"<i>I don't know if I can get any tighter than this, but... go ahead,</i>\" Arian says, smiling nervously at you.");
		output("\n\nYou poke and prod gently but insistently at Arian's ass, but are forced to concede the truth; you can barely get one of your fingers inside [arian.eir] tight anus, and you have little reason to suspect that it would do much good even if you could get it inside.");
		
		output("\n\n\"<i>I guess it's no use after all,</i>\" Arian chuckles.  \"<i>I imagine if you did manage to apply it you'd make my ass disappear.  Now that would be weird.</i>\"");
		
		output("\n\n[arian.ey]'s not wrong there, you agree.  Still, would [arian.ey] maybe like to do something else, seeing as how that was a bust?  Arian nods.  \"<i>Of course.  What would you like to do?</i>\"");
		arian.ass.loosenessRaw = 1;
	}
	//(else if AnalXP < 33)
	else if (arian.analExp() <= 33) {
		output("\n\n\"<i>I think I'm still pretty tight back there, but if you want me to be tighter, go ahead,</i>\" Arian says, smiling nervously at you.");
		
		output("\n\nYou gently press your fingers against the hole in question; like Arian noted, it's tight and resists your effort, but you manage, with some difficulty, to slide first one finger and then the other inside, allowing you to start coating the inner walls with Reducto cream.  You can feel the walls growing taut as you work - indeed, it promptly shrinks down almost painfully around your fingers, and you have to struggle as hard to pull them out as you had to push them in to begin with.");
		
		output("\n\nArian groans as you finally manage to pull your fingers out.  \"<i>I don't think it'll feel that much different when you decide to put it back there again, but I hope it'll feel good for you anyway.  Just promise you'll be gentle, ok?</i>\"");
		
		output("\n\nYou promise [arian.em] that you'll take care of [arian.em].  \"<i>So, anything else you'd like to do?</i>\"");
		arian.analExp( -33);
		arian.ass.loosenessRaw = 1;
	}
	else if (arian.analExp() < 66) {
		arian.analExp( -33);
		if(arian.ass.loosenessRaw > 1) arian.ass.loosenessRaw = 1;
		output("\n\n\"<i>To be honest, I had kind of gotten used to the feeling... sorta.  It will be a bit painful to go back to being that tight back there, but if that's what you'd like, go ahead,</i>\" Arian says, smiling at you.");
		
		output("\n\nYou slide two fingers easily inside [arian.eir] stretched out back passage, rubbing the interior of [arian.eir] anus with the magical shrinking cream.  You end up applying a third finger for ease of application; [arian.ey]'s certainly loose enough to take it.  You can feel it shrinking around you as you work, but you still have little difficulty sliding your fingers back out.");
		
		output("\n\nArian moans as you pull out your fingers.  \"<i>And I was just getting used to being taken from behind.  Somehow I get the feeling it won't feel just as good, but I'm glad to make a little sacrifice for you.</i>\"  [arian.ey] smiles at you.");
		
		output("\n\nYou smile back, thanking [arian.em] for catering to your wishes, even though [arian.ey] doesn't have to.  Arian grins at you.  \"<i>Don't worry about that.  I want to make you feel good...</i>\"  Stroking [arian.eir] exposed ass, you tell [arian.em] that [arian.eir] efforts are appreciated and promise to make [arian.em] feel just as good in return.  Arian smiles.  \"<i>Okay, it's a deal.  So, anything else you'd like to do?</i>\"");
	}
	else {
		arian.analExp( -33);
		if(arian.ass.loosenessRaw > 2) arian.ass.loosenessRaw = 2;
		output("\n\n\"<i>I just know it won't feel quite as good back there if you shrink my ass, but maybe this is for the best?  Perhaps I might have let the feeling get to me.  Maybe I did become too much of a buttslut...</i>\"  Arian lowers [arian.eir] head.");
		
		output("\n\nYou can't resist patting the lizan's head and assuring [arian.em] that, yeah, [arian.ey] is a slut when it comes to [arian.eir] ass, but the way [arian.ey] goes about being a slut is honestly kind of cute.  You just want to see if tightening [arian.em] back up will make things even better, now [arian.ey]'s got the experience of loving a great assfuck.");
		
		output("\n\nYou push your way into Arian's butt and almost find your whole hand sliding down [arian.eir] well-trained 'boyslut pussy', which prompts a lewd moan from the anal-loving lizan");
		if (arian.hasCock()) {
			output(", [arian.eir] cock");
			if (arian.cockTotal() > 1) output("s suddenly jolting from their sheathe");
			else output(" suddenly jolting from its sheathe");
			if (arian.hasVagina()) output(" and ");
		}
		if (arian.hasVagina()) {
			if (!arian.hasCock()) output(", ");
			output("[arian.eir] pussy growing wet from the stimulation");
		}
		output(".  You playfully shake your head and slap [arian.em] on the butt, then use it for balance as you start to pump the blade of your fist inside and out, smearing the cream copiously around to restore some of [arian.eir] once-virginal anal tightness to him.  Eventually, you've used up all the cream and [arian.eir] ass definitely feels tighter, so you decide to pull out.");
		
		output("\n\nArian whimpers.  \"<i>It feels a bit less sensitive now, but I'm sure it'll still feel pretty good when you do me from behind.</i>\"  Arian smiles.  \"<i>Anything else you'd like to do?</i>\"");
	}
	//Back
	clearMenu();
	addButton(0,"Next",giveArianAnItem);
}

//Reptilum:
//Makes Arian horny and high, like giving catnip to a cat in some ways. 
//Chance to make Arian grow a second dick, if [arian.ey] has only one. (high chance: 50%)
private function giveArianReptilum():void {
	clearOutput();
	pc.destroyItem(new CoCReptilum());
	
	output("Fingering the vial of reptilium, you smirk to yourself.  Quickly wiping it off your face, you instruct Arian to close [arian.eir] eyes and open [arian.eir] mouth, as you have a special surprise for [arian.em].");
	
	output("\n\nArian, quickly complies.  \"<i>Okay, but can you at least tell me what is this about?</i>\"  [arian.ey] asks in curiosity.");
	
	output("\n\nYou cluck your tongue in a disappointed tone and point out that a surprise isn't a surprise if you tell [arian.em] what it is.");
	
	output("\n\n\"<i>Aww, fine then, but I hope this isn't a practical joke... not that I don't trust you, [pc.name].</i>\"  [arian.ey] smiles nervously.");
	
	output("\n\nYou assure [arian.em] that [arian.ey]'ll enjoy this, but first, to make sure [arian.ey] doesn't go peeking... you grab a handy strip of cloth and wind it about [arian.eir] face, covering [arian.eirs] eyes in a makeshift blindfold.");
	
	output("\n\n\"<i>Aww, come on, you can trust me.  I promise not to peek!</i>\"");

	output("\n\nYou tell [arian.em] it's more fun this way, popping the bottle of Reptilium open as you do so and following your words up by tipping it into the lizan's carelessly open mouth.");
	
	output("\n\n\"<i>I sweagrlpff-</i>\" the lizan's protests are cut short by the stream of cool reptilum being poured down [arian.eir] throat.  [arian.ey] chokes a bit, but quickly adapts, drinking eagerly.  When you finish tipping the bottle and remove it from [arian.eir] lips, Arian coughs a bit and licks [arian.eir] lips.  \"<i>Hmm... that tasted good, what was it?</i>\"");
	
	output("\n\nYou tell [arian.em] [arian.ey]'ll just have to wait to find out, taking off [arian.eir] blindfold and smiling wryly at [arian.em].  \"<i>Umm... ok...</i>\"");
	//(if ArianFirstRept == 1)
	if (int(flags["COC.ARIAN_FIRST_REPTILUM"]) == 0) {
		output("\n\nThe two of you sit there in wait... but oddly nothing happens.  You ask Arian if [arian.ey]'s feeling any different.");
		output("\n\n\"<i>No. I feel fine.</i>\"");
		output("\n\nThat's weird... was it a bust then?");
	}
	else {
		output("\n\nYou chuckle inwardly, any time now...");
	}
	output("\n\nArian suddenly shakes [arian.eir] head, blinking as if trying to focus; then [arian.ey] turns to look at you, and gives you a silly smile.  \"<i>Hey, [pc.name].  Did you know you have a very beautiful aura?  All the colors.  I wonder what it tastes like.</i>\"");
	IncrementFlag("COC.ARIAN_FIRST_REPTILUM");
	//(if ArianFirstRept == 1)
	if (flags["COC.ARIAN_FIRST_REPTILUM"] == 1) output("\n\nYou blink; aura?  What is the lizan talking about?  And what would make [arian.em] think colors are tasty - or even edible?");
	else output("\n\nChuckling, you tell [arian.em] that if [arian.ey]'s so curious, [arian.ey] should try it.");
	
	output("\n\nArian suddenly gets up and takes a lick off your cheek.  \"<i>Yum... didn't know rainbows tasted like cloud ice-cream.</i>\"  [arian.ey] begins laughing uncontrollably.  You wipe [arian.eir] saliva off your cheek and look in amazement as [arian.ey] continues to laugh for no apparent reason.");
	
	output("\n\n\"<i>Hey [pc.name], cats are flexible right?  Think I would turn into one if I could lick my butt?  I'd be a sexy kitten!</i>\"  Arian does away with [arian.eir] robes, tossing them around and bending over as far as [arian.ey] can in an attempt to lick at [arian.eir] butt.  \"<i>J-just a bit more....  Help me here, [pc.name]!  I want to turn into a cat so we can roleplay!  I'll be Mittens and you can be Fishbreath!</i>\"");
	
	//(if ArianFirstRept == 1)
	if (flags["COC.ARIAN_FIRST_REPTILUM"] == 1) {
		output("\n\nFeeling a touch nervous, you ask if [arian.ey]'s feeling all right.  \"<i>All right?  I'm super!</i>\" [arian.ey] replies, gigling madly.");
	}
	else output("\n\nYou were kinda waiting for this part.  [arian.ey] might not know it, but Arian's flexibility is truly impressive for a non-feline.  Just a few extra inches of tongue and [arian.ey] actually manages to lick [arian.eir] belly!");
	
	output("\n\nAt one point the bending lizan gives up and falls flat on [arian.eir] back then gets right up eyeing you with a glow in [arian.eir] eyes.  \"<i>That was a stupid idea!  I know just how to make it!  I can lick your butt instead!  Do you think it tastes like cloud ice-cream like your rainbow aura?</i>\"");
	
	output("\n\nYou shake your head and tell [arian.em] you'd rather [arian.ey] didn't lick your butt.  Why don't you go and get [arian.em] some candy instead?  \"<i>Candy!?  I love candy!  You can smear chocolate on yourself and I could lick it clean! Then we'd get chocolate flavored cloud ice-cream with " + pc.race() + " musk!  What a great idea!  Get your undies off so I can get started!</i>\"  [arian.ey] pounces on you, effectively removing your underpants and exposing your [pc.crotch].  \"<i>Hmm, that looks much tastier than candy actually.</i>\"  [arian.ey] licks your ");
	if (pc.hasCock()) output("cock from base to tip");
	else if (pc.hasVagina()) output("pussy all the way from the back to the tip of your [pc.clit]");
	else output("your sweaty crotch");
	output(".  \"<i>Yummy!  I could use seconds, but roleplay time is over; let's... masturbate each other!</i>\"  [arian.ey] begins stroking [arian.eir] ");
	
	//if (arian.hasVagina())	
		//output(images.showImage("arianfemale-home-mutualmasturbation"));	
	//else	
		//output(images.showImage("arianmale-home-mutualmasturbation"));
	
	if (arian.hasCock()) {
		output("quickly erecting lizan cock");
		if (arian.cockTotal() > 1) output("s");
		if (arian.hasVagina()) output(" and [arian.eir] ");
	}
	if (arian.hasVagina()) output("slavering vagina");
	output(".");
	
	output("\n\nArian must be high; normally [arian.ey] needs a little encouragement to put on a show like this.  Still, who are you to pass up on a free show from your lizan lover?");
	
	output("\n\nLaughing and moaning uncontrollably Arian says, \"<i>Wow, [pc.name].  Your hands feel really good!  Kind of familiar too!</i>\"");
	
	output("\n\n[arian.ey]'s clearly so daffy that [arian.ey] doesn't realize [arian.ey]'s the one touching [arian.em]self.  Still, this is amusing, rather than scary, so you're content to watch and let the show play out.  It's kind of a turn on...");
	pc.lust(5 + pc.libido() / 10);
	
	var tfed:Boolean = false;
	output("\n\nArian's giggling suddenly stops as [arian.ey] finally orgasms, ");
	if (arian.hasCock()) {
		output("shooting thick ropes of cum up into the air to land on [arian.eir] ");
		if (arian.breastRows[0].breastRating() == 0) output("chest");
		else if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_1) output("perky little breasts");
		else if (arian.breastRows[0].breastRating() == ARIAN_BREASTS_SIZE_2) output("soft breasts");
		else output("pillowy breasts");
		if (arian.hasVagina()) output(" while ");
	}
	if (arian.hasVagina()) output("[arian.eir] vagina doing its best to soak [arian.eir] bed with lizan femcum");
	output(".");
	
	output("\n\nLooking at you dizzily, Arian smiles and says, \"<i>That was fun, [pc.name].  You have truly gifted hands!</i>\"  You repress a laugh; this was just too much fun, and tell Arian that credit is due where it's due.  You leave it to the dazed lizan to eventually decipher if you're saying you were the one with the gifted hands or you were encouraging [arian.em] to recognize that [arian.ey] is the one with the gifted hands.");
	
	//(if (random <= 50%) && (ArianDblCock == 0) && (ArianCockSize != 0)
	if (rand(2) == 0 && arian.cockTotal() < 2 && arian.hasCock()) {
		output("\n\n\"<i>Ugh... something feels weird...</i>\"  Arian looks down at [arian.eir] crotch.  You follow [arian.eir] eyes and see a second cock growing.  It grows until it's the same size as Arian's original cock, and once the transformation is over, Arian bursts out in uncontrollable laughter.");
		
		output("\n\n\"<i>Look, [pc.name]!  You did me so hard I'm seeing double!</i>\"  [arian.ey] moves [arian.eir] hands to touch [arian.eir] sensitive twin members.  \"<i>Whoa! I'm feeling double too!</i>\"  Eventually the laughter dies down and the lizan collapses on [arian.eir] back, snoring in a quick nap.");
		tfed = true;
	}
	else {
		output("\n\nArian's mouth opens into a wide yawn.  \"<i>Hmm... nappy time...</i>\"  [arian.ey] flops on [arian.eir] back and begins snoring in a quick nap.");
	}
	
	output("\n\nYou chortle quietly to yourself.  Talk about your anticlimactic finishers.   Still, you can't resist stroking Arian gently on the head; looks like [arian.ey] quite enjoyed [arian.em]self with that.  You remove your hand in surprise when Arian suddenly gets up, rubbing at [arian.eir] eyes.  \"<i>Wha... hey [pc.name].  Sorry, I guess I fell asleep.</i>\"  Looking down at [arian.em]self, [arian.ey] realizes the state [arian.ey]'s in.  For a moment [arian.ey] looks confused... but then smiles.  \"<i>I guess we wound up having sex, right?  Was it good?  Sorry, but I'm a bit dizzy and can't recall exactly what happened.</i>\"");
	output("\n\nYou tell [arian.em] it was definitely interesting.  [arian.ey] really seemed to get wired up off of your little surprise.");
	
	if (tfed) {
		output("\n\n\"<i>Hmm... I still feel sensitive all over...</i>\"  [arian.eir] hand absently touches [arian.eir] still half-erect twin dicks.  \"<i>Wha?</i>\"  Looking down at [arian.eir] crotch, Arian finally realizes [arian.ey] has two dicks.");
		
		output("\n\n\"<i>Two... but, I was....  Was that you, [pc.name]?</i>\"");
		
		output("\n\nYou smile and nod your head; does [arian.ey] like them?");
		
		output("\n\n\"<i>Like them?  I love them!  You have no idea how much I longed to... to... to actually have two dicks like most of my people.  Thank you so much for this wonderful suprise [pc.name]!</i>\"  [arian.ey] grins happily at you.");
		
		arian.createCock();
		arian.shiftCock(1, GLOBAL.TYPE_SNAKE);
		arian.cocks[1].cLengthRaw = arian.cocks[0].cLengthRaw;
	}
	else {
		output("\n\n\"<i>I guess I did...</i>\"  [arian.ey] smiles tiredly at you.  \"<i>Thank you for the wonderful surprise, [pc.name].</i>\"");
	}
	output("\n\nYou laugh lightly and tell [arian.em] that you should be the one thanking [arian.em].");
	
	output("\n\nThe lizan looks at you in confusion, and is about to ask you something when a yawn interrupts [arian.eir] line of thought.  \"<i>Ok... I'm glad you liked whatever we did...  -gonna take a nap now.</i>\"");

	output("\n\nYou gently pull the covers up over the tired lizan, stroke [arian.eir] head fondly, and quietly excuse yourself from [arian.eir] sleeping quarters.");
	
	//Player gains Lust.
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Treat Corruption
//Not with the power of friendship, but with magic!
//Balancing it is up to Fen.
//Reduce corruption, maybe libido, once per day.
private function treatCorruption():void {
	clearOutput();
	output("You ask Arian if [arian.ey] thinks [arian.ey] can help you reduce some of the taint that has infected your soul.");
	
	if (flags["COC.ARIAN_TREATMENT"] == days) {
		output("\n\nArian solemnly shakes [arian.eir] head.  \"<i>Sorry, [pc.name].  But I have already treated you once today, and if I did it again it could be hazardous to you... sorry.</i>\"");
		
		output("\n\nYou apologize.  You had forgotten how much that taxes [arian.em], and you will come back for further treatments tomorrow.  However, there is something else [arian.ey] can help you with...");
		arianHomeMenu();
		//Back to previous menu.
	}
	else {
		output("\n\nArian nods.  \"<i>Of course!  Just hold my hands.</i>\"  [arian.ey] extends [arian.eir] hands, waiting for you to get into position.");
		
		output("\n\nYou take hold of [arian.eir] smoothly-scaled hands with your own, and wait patiently for [arian.em] to begin.");
		
		output("\n\n\"<i>Now I need you to close your eyes, and focus on breathing... deeply and calmly.  You should feel a weird electric sensation, but try to relax.</i>\"");
		
		output("\n\nYou nod your head, close your eyes, and begin to slowly, rhythmically inhale and exhale, calming yourself down as instructed.");
		
		output("\n\nIt takes a while, but eventually you begin to feel the strange sensation Arian told you about.  It courses through your arms, and spreads throughout your body.  After a moment, you feel your body going numb with the sensation, and that's when you notice something else....  For a moment, it feels like you're being hugged tightly by a ghost.  It feels like it's there and isn't at the same time.  Invisible hands roam your body, and slowly, you feel like pieces of you are being removed.  It's not a bad sensation, and it certainly doesn't hurt, but it's... uncomfortable.");
		
		output("\n\n\"<i>That's enough.  You can open your eyes now,</i>\" Arian says, as all the strange sensations coursing through your body abruptly stop.  You release the lizan mage's clawed hands and realize that you're panting... as if you had exerted some sort of physical activity.");
		
		output("\n\nNoticing your concern Arian smiles.  \"<i>Don't worry, [pc.name].  Just take a few moments to regain your breath and you should feel better.</i>\"");
		
		output("\n\nYou do as you are instructed, and note that, once you do feel better, you literally feel better; your thoughts are less clouded by corruption than they were before");
		pc.cor( -1);
		pc.energy( -20);
		if (pc.cor() == 0) output(" - in fact, you're quite sure that Arian has purified you entirely");
		output(".  You thank the lizan for [arian.eir] magical treatment.");
		
		output("\n\n\"<i>You're welcome,</i>\" [arian.ey] replies with a smile.  \"<i>Just remember that we can only do this once per day.  Any more and it would be hazardous, for both of us.</i>\"");
		
		output("\n\nYou acknowledge what [arian.ey] is saying, promise you'll try and be more careful in the future, thank [arian.em] once more, and then excuse yourself.");
		flags["COC.ARIAN_TREATMENT"] = days;
		processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Imbue Talisman
//Make it as generic as possible, so more stuff can be added or removed without compromising too much time.
//if PC doesn't have the sufficient materials, option doesn't show up.
//Perhaps introduce a cooldown to the talisman?
//Ultimately, balance is in Fen's hands.
private function imbueTalisman():void {
	clearOutput();
	output("You tell Arian that, if it's not too much trouble, you'd like [arian.em] to ");
	if (pc.hasKeyItem("Arian's Talisman") >= 0) output("place a spell in the enchanted talisman [arian.ey] created for you");
	else output("change the spell in the talisman [arian.ey] created for you");
	
	output(".\n\n\"<i>Of course.</i>\"  Arian goes to [arian.eir] work desk to fetch a small parchment and present it to you.  \"<i>Here's all the spells I can Imbue your talisman with and the materials needed.</i>\"");
	
	output("\n\nYou start observing the parchment, contemplating your choices.  So, what spell will you have [arian.em] place in the talisman?");
	
	/*The list:
	Healing Spell: 2x Wet Cloth and 2x Vitality T. - Heals the PC, no chance for failure.
	Lust Reduction Spell: 2x Lust Draft and 1x Fuck Draft. - Reduces the PC's current lust, no chance for failure. 
	Shielding Spell: 2x Black Chitin and 1x Tough Silk. - Increases defense for the duration of the battle.
	Dispelling Spell: 1x White Book and 1x Black Book - Cancels all magical and alchemical effects currently affecting the PC, beneficial or not. (Does not cancel the effects of demon's lust aura.)
	Immolation Spell: 2x Goblin Ale and 1x Sweet Gossamer. - Deals damage over time.
	//Back is also present as an option, and returns PC to previous menu.
	*/
	output("\n\n<b>Shielding Spell:</b> 2x Black Chitin and 1x Tough Silk - Increases defense for the duration of the battle.");
	output("\n<b>Immolation Spell:</b> 2x Goblin Ale and 1x Sweet Gossamer - Deals damage over time.");
	clearMenu();
	if (pc.hasItem(new CoCBlackChitin(), 2) && pc.hasItem(new CoCToughSpiderSilk())) addButton(0, "Shielding", arianSpellPlace, "Shielding Spell");
	else addDisabledButton(0, "Shielding", "Shielding", "You need specific reagents for this spell.");
	if (pc.hasItem(new CoCGoblinAle(), 2) && pc.hasItem(new CoCSweetGossamer())) addButton(1, "Immolation", arianSpellPlace, "Immolation Spell");
	else addDisabledButton(1, "Immolation", "Immolation", "You need specific reagents for this spell.");
	addButton(14, "Back", arianHomeMenu);
}

private function arianSpellPlace(spell:String):void {
	clearOutput();
	output("You tell Arian that you want [arian.em] to place the " + spell + " spell in your talisman for you.");
	
	output("\n\n\"<i>Okay. Please, hand me the ingredients and I'll have it imbued in a moment.</i>\"  [arian.ey] smiles at you.  Fishing around amongst your belongings, you gather the necessary items and hold them out to the lizan.");
	
	output("\n\nArian eagerly nabs the offered ingredients and moves to [arian.eir] work desk.  [arian.ey] takes a nearby bowl and fills it with water, then looks around.  \"<i>Hmm... I'm forgetting something... oh, right!  I'm going to have to ask you for your talisman, too, [pc.name].</i>\"  [arian.ey] extends a hand to you.");
	
	output("\n\nYou can't resist noting you were expecting [arian.em] to say that, plucking it from your neck and passing it to the reptilian wizard.");
	
	output("\n\n\"<i>Erm... right.  Now I need to focus.</i>\"  [arian.ey] places your talisman in the bowl, submerging it in water, then closes [arian.eir] eyes and begins focusing [arian.eir] magic.  Shortly after, the ingredients you offered suddenly burst into flames, burning until only their ashes are left; the ashes float into the bowl and mix with the water inside.");
	
	output("\n\nA soft hum emanates from within the bowl and the water begins glowing.  It doesn't take long for the humming to fade; Arian reaches inside the bowl and lifts your talisman for you to see.  \"<i>Here you go, [pc.name].</i>\"");
	
	output("\n\nYou thank [arian.em] and accept the talisman, feeling the pulsating energies within for a few moments before placing it back around your neck.  You thank Arian for [arian.eir] help, assuring [arian.em] that this will surely help you in your travels through these lands.");
	
	output("\n\n(<b>Your talisman has been imbued with the " + spell + ". You can use it from the M. Specials menu in combat.</b>)\n\n");

	pc.removeKeyItem("Arian's Talisman");
	if (spell == "Shielding Spell") {
		pc.createKeyItem("Arian's Talisman", 1, 0, 0, 0, "Charged with Shielding Spell.");
		//Shielding Spell: 2x Black Chitin and 1x Tough Silk. - Increases defense for the duration of the battle.
		pc.destroyItem(new CoCBlackChitin(),2);
		pc.destroyItem(new CoCToughSpiderSilk());
	}
	if (spell == "Immolation Spell") {
		pc.createKeyItem("Arian's Talisman", 2, 0, 0, 0, "Charged with Immolation Spell.");
		//Immolation Spell: 2x Goblin Ale and 1x Sweet Gossamer. - Deals damage over time.
		pc.destroyItem(new CoCGoblinAle(),2);
		pc.destroyItem(new CoCSweetGossamer());
	}
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
public function clearTalisman():void {
	pc.removeKeyItem("Arian's Talisman");
	pc.createKeyItem("Arian's Talisman", 0, 0, 0, 0, "Not charged now.");
}

//Follower Stuff:
//Camp Modifier
/*9999
The small tent that Arian dwells in is in its usual place in a quiet corner of the camp. You're not sure if he's inside, taking advantage of its uncannily larger interior, or out on one of his usual strolls outside of the camp.
*/
//Approach Arian


//Sleep With Arian
public function sleepWithArian(newl:Boolean = false):void {
	if (newl) clearOutput();
	flags["COC.SLEEP_WITH"] = "Arian";
	output("Tired after a whole day of adventuring, you decide to retire and catch some shut-eye.  While going through the day's events, you recall Arian had offered to let you stay in [arian.eir] tent and sleep with [arian.em] in [arian.eir] bed.  Your tired body could surely use a soft bed today, and maybe a certain lizan to keep you company too.  With that in mind, you head to [arian.eir] tent.");
	
	output("\n\nInside, you find the " + arian.mf("male","girly") + " lizan standing naked before [arian.eir] bed, stretching [arian.eir] arms and tail as widely as they can and groaning with satisfaction as [arian.eir] joints pop.  Apparently not having noticed you arrive, [arian.ey] hums to [arian.em]self as [arian.ey] busies [arian.em]self with the covers of [arian.eir] bed, bending over and letting you get a good look at [arian.eir] sweet ass.  You appreciate the view for a few moments, and then gently cough to announce your presence.");
	
	output("\n\nStartled, Arian tries [arian.eir] best to cover [arian.eir] privates and finally notices you standing just inside.  \"<i>Oh, hello [pc.name].  S-sorry, I'm not decent... I was just getting ready to turn in.  Can I help you with something?</i>\"");
	
	output("\n\nYou smile at [arian.em] and ask if that invitation to join [arian.em] in bed for the night still stands.  You just don't really feel like going to bed alone tonight, you explain.");
	
	output("\n\nArian nods enthusiastically.  \"<i>Of course!  Let me just put some comfortable robes on.  Usually I just sleep naked, but since you're here....</i>\"");
	
	output("\n\nYou quickly interject that if that's how [arian.ey] prefers to sleep, well, [arian.ey] doesn't need to change that for you.  If it'll make [arian.em] more comfortable, in fact, you'll sleep naked with [arian.em] as well.");
	
	output("\n\n\"<i>Really?  Umm... well, they say it's easier to share body heat with skin contact, so...</i>\"  Arian trails off twirling [arian.eir] fingers, no longer bothering to cover [arian.em]self up.");
	
	output("\n\nYou make no secret of your visual appreciation, telling [arian.em] that the view is definitely nice, and then you start to strip down, making a little show out of it for your lizan lover.");
	
	output("\n\nArian fidgets and watches enraptured as you peel off each piece of your [pc.gear].  ");
	if (arian.hasCock()) {
		output("You can clearly see [arian.eir] exposed cock");
		if (arian.cockTotal() > 1) output("s");
		output(" stiffening at the sight.  ");
	}
	else if (arian.hasVagina()) output("You can tell that [arian.ey] is aroused by the little show, despite [arian.eir] body doing a good job of hiding it.  ");
	output("You just let [arian.em] squirm, pretending you don't see [arian.eir] reactions, and then, indicating the bed, you ask which of you should get in first.");
	
	output("\n\nArian steps aside and motions for you to hop in first.  \"<i>Don't worry, I've cleaned the sheets recently, so there shouldn't be a problem... in case you're worried.</i>\"");
	
	output("\n\nWorried?  You smirk and ask whatever you could be worried about, even as you saunter over and slide yourself onto the bed.  You smile and wiggle with appreciation, telling Arian how wonderful [arian.eir] sheets and soft mattress feel after so long sleeping in a bedroll on the hard ground.");
	
	output("\n\nArian smiles at you.  \"<i>I'm glad you're comfortable.  Just know that I'll always have a spot for you under my bedsheets.</i>\"  Oh?  Is that a proposal of a little... light exercise before bed, hmm?  You tease the lizan.  Averting [arian.eir] gaze and biting [arian.eir] lower lip, Arian quickly blurts out.  \"<i>No!  I mean... I wouldn't mind... but I, umm....  I'll just be getting in under the covers, if you don't mind.</i>\"  You chuckle and motion for [arian.em] to come hither.");

	output("\n\nArian lays down beside you, and scoots over, trying to get as close as possible to you.  You promptly wrap your arms around [arian.eir] waist, and then wrap your [pc.legs] around [arian.em] for good measure, nuzzling yourself against [arian.eir] smooth scales.");
	
	output("\n\nArian sighs in happiness at your close contact.  \"<i>It feels so good to have your " + pc.skinFurScales() + " against my scales.  So warm...</i>\" [arian.ey] sidles up against you, [arian.eir] tail draping over your waist as [arian.ey] sinks into your embrace.  You just squeeze [arian.em] a little tighter and hold [arian.em] close, saying nothing aside from a quiet whisper to sleep well.  \"<i>Good night, [pc.name],</i>\" [arian.ey] whispers back, before extending a hand toward the globe illuminating the tent and snapping [arian.eir] fingers, shutting down the light.");
	//awardAchievement("My Tent's (not) Better Than Yours", kACHIEVEMENTS.GENERAL_MY_TENT_NOT_BETTER, true, true);
	//(if AnalXP <33)
	if (arian.analExp() < 33) {
		output("\n\nA strange sensation, combined with a soft sound, stirs you from your sleep.  You realize that Arian is stirring in [arian.eir] sleep, softly mumbling to [arian.em]self as [arian.eir] tail gently swishes to and fro under the covers, sometimes accidentally running its warm length over your " + pc.skinFurScales() + ".");
		
		output("\n\nAt first you think the lizan might actually be awake, but under further inspection you realize that [arian.ey] is just sleep-talking.  Should you listen in or just go back to sleep?");
		clearMenu();
		addButton(0,"Listen",listenToLowAnalXPArian);
		addButton(1,"Sleep",dontListenToLowAnalXPArian);
	}
	//(else if AnalXP <66)
	else if (arian.analExp() < 66) {
		output("\n\nYou awaken blearily to the sound of soft whimpering, the feeling of hips rubbing softly and repeatedly against your groin, and the sensation of a long, smoothly-scaled tail flickering across your [pc.chest].  Looks like Arian is dreaming something... probably something erotic, too.");
		output("\n\nShould you listen in, and perhaps tease [arian.em]?  Or just go back to sleep?");
		//[Listen][Sleep]
		clearMenu();
		addButton(0,"Listen",listenToMediumAnalXPArian);
		addButton(1,"Sleep",dontListenToMediumAnalXPArian);
	}
	else { //AnalXP <= 100
		output("\n\nYou wake up, confused and wondering what's disturbing your sleep.  When you wake up, you almost think Arian's also awake; [arian.ey]'s insistently moaning in pleasure, grinding [arian.eir] ass feverishly against your crotch, tail thrashing around wildly.  Why, that little cheeky lizard; [arian.ey]'s having a wet dream!");
		output("\n\nShould you tease [arian.em] a bit?  Or try to calm [arian.em] down and go back to sleep?");
		//[Tease][Sleep]
		clearMenu();
		addButton(0,"Tease",TeaseHighAnalXPArian);
		addButton(1,"Sleep",dontTeaseHighAnalXPArian);
	}
}

//[=Sleep=]
private function dontListenToLowAnalXPArian():void {
	clearOutput();
	output("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian.eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian.ey] was having have faded and [arian.ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	clearMenu();
	addButton(0, "Next", sleep);
}

//[=Listen=]
private function listenToLowAnalXPArian():void {
	clearOutput();
	flags["COC.ARIAN_MORNING"] = 1;
	output("You turn you head to try and catch what Arian might be dreaming about.");
	output("\n\n\"<i>In my ass?  Are you sure?</i>\"");
	output("\n\nWell, now; looks like Arian might be dreaming about anal sex.  You wonder what to do....  Well, since it's basically [arian.eir] fault that you are awake, you feel a little payback is in order.  You whisper in [arian.eir] ear that you are sure.");
	output("\n\n\"<i>But sausages belong inside breads,</i>\" Arian whimpers.  \"<i>But... if you're sure... okay....</i>\"  Under the covers you feel Arian wiggling [arian.eir] butt against you, [arian.eir] tail lifting to make room for the \"<i>sausage</i>\".");
	//(if PC has a cock)
	if (pc.hasCock()) {
		output("\n\nYou wonder for a moment if maybe this is fair, but decide that, if [arian.ey]'s obviously dreaming about it eagerly....  Your hand slips under the covers to start stroking your [pc.cock " + pc.smallestCockIndex() + "], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
	}
	else {
		output("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; they should be close enough for someone new to anal like [arian.em], right?  Copiously lubricating your middle finger with saliva, you wriggle it between [arian.eir] soft asscheeks and begin gently pushing it into [arian.eir] tight little pucker.");
	}
	output("\n\nBefore you can even drive an inch in, Arian suddenly says, \"<i>No!  Wait!  I'm not ready yet!  I need to bake for a few more minutes before you can put the sausage in... and add more milk...</i>\"");
	output("\n\n...Okay, this is getting weird enough.  You're not really sure you can stay in the mood to fuck [arian.eir] ass.");
	output("\n\n\"<i>[pc.name]... just let me bake overnight.  I'll be ready tomorrow.  G'night...</i>\"  Having said that, Arian finally calms down.");
	output("\n\nYou wonder if maybe Arian always dreamed of being a baker instead of a wizard... or if [arian.ey] just had a midnight craving for pastries  With a soft sigh, you make yourself settle down and try to get back to sleep.");
	pc.lust(15);
	clearMenu();
	addButton(0,"Next", sleep);
}

//[=Sleep=]
private function dontListenToMediumAnalXPArian():void {
	clearOutput();
	output("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian.eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian.ey] was having have faded and [arian.ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	clearMenu();
	addButton(0, "Next", sleep);
}
//[=Listen=]
private function listenToMediumAnalXPArian():void {
	clearOutput();
	flags["COC.ARIAN_MORNING"] = 1;
	output("You turn you head to try and catch what Arian might be dreaming about.");
	output("\n\n\"<i>Hmm... no, not my muffins.</i>\"");
	output("\n\n...Muffins?  [arian.ey]'s kicking and squirming like that... over a dream about muffins?  Feeling mischievous, and maybe a little insulted, you lean over [arian.eir] ear and whisper that you've got some very special muffins for him.");
	output("\n\n\"<i>Really?  What flavor?</i>\"");
	output("\n\nYou tell [arian.em] it's a surprise.");
	output("\n\n\"<i>Hmm, okay then.  Shove it in.</i>\"  Arian lifts [arian.eir] tail out of the way, wiggling [arian.eir] hips against you.");
	
	//(if PC has a cock)
	if (pc.hasCock()) {
		output("\n\nWell, if this is what [arian.ey] wants, you're happy to oblige.  Your hand slips under the covers to start stroking your [pc.cock " + pc.smallestCockIndex() + "], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
		output("\n\nArian moans.  \"<i>Such a familiar flavor.  Why didn't you tell me you were [pc.name] flavored?  I love muffins.  I love [pc.name] muffins.</i>\"");
		output("\n\nYou blink in surprise; is Arian really asleep, you wonder?  No, [arian.ey]'s got to be awake, otherwise how could [arian.ey] realize you're actually fucking [arian.eir] ass?  \"<i>Hmm... tasty...</i>\"  You lean over the lizan, ");
		if (pc.hasCock()) output("cock");
		else output("finger");
		output(" still worming its way into [arian.eir] fuckable ass, but it really does look like [arian.ey]'s fast asleep.  Weird.  \"<i>So many muffins... all [pc.name] flavored...</i>\"  [arian.ey] calms down and begins snoring lightly.");
		output("\n\nUnbelievable... if you didn't know better you'd think that Arian is the one doing the teasing here.  Still... [arian.ey]'s fast asleep right now, and you don't feel like fucking [arian.em] in [arian.eir] sleep");
		if (pc.cor() >= 66) output(", despite the silly lizan being deserving of it");
		output(".  But as payback, [arian.ey]'s going to sleep with you inside, not that it seems like it'll be much of a problem to [arian.em]... Too bad you can't hold an erection all the time while asleep, so you know eventually you'll slip out...");
	}
	else {
		output("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; it is what [arian.ey] wants, right?  Copiously lubricating your middle finger with saliva, you wriggle it between [arian.eir] soft asscheeks and begin gently pushing it into [arian.eir] tight little pucker.");
		output("\n\nArian moans.  \"<i>Such a familiar flavor... why didn't you tell me you were [pc.name] flavored?  I love muffins... I love [pc.name] muffins...</i>\"");
		output("\n\nYou blink in surprise; is Arian really asleep, you wonder?  No, [arian.ey]'s got to be awake, otherwise how could [arian.ey] realize you're actually fucking [arian.eir] ass?  \"<i>Hmm... tasty...</i>\"  You lean over the lizan, finger still worming its way into [arian.eir] fuckable ass, but it really does look like [arian.ey]'s fast asleep.  Weird.  \"<i>So many muffins... all [pc.name] flavored....</i>\"  [arian.ey] calms down and begins snoring lightly.");
		output("\n\nUnbelievable... if you didn't know better you'd think that Arian is the one doing the teasing here.  Still... [arian.ey]'s fast asleep right now, and you don't feel like fucking [arian.em] in [arian.eir] sleep");
		if (pc.cor() >= 66) output(", despite the silly lizan being deserving of it");
		output(".");
	}
	pc.lust(15);
	clearMenu();
	addButton(0, "Next", sleep);
}

//[=Sleep=]
private function dontTeaseHighAnalXPArian():void {
	clearOutput();
	output("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian.eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian.ey] was having have faded and [arian.ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	clearMenu();
	addButton(0, "Next", sleep);
}

//[=Tease=]
private function TeaseHighAnalXPArian():void {
	clearOutput();
	
	//if (arian.hasVagina())
		//output(images.showImage("arianfemale-camp-dreamingArian"));
	//else	
		//output(images.showImage("arianmale-camp-dreamingArian"));
	flags["COC.ARIAN_MORNING"] = 1;
	output("\n\nFirst, you decide to check what exactly is Arian dreaming about...");
	output("\n\n\"<i>...[pc.name]... no... don't stuff that turkey... stuff me....  I wanna be tasty too.</i>\"");
	output("\n\nIs [arian.ey] dreaming about food, or sex?");
	//(if PC has a cock)
	if (pc.hasCock()) {
		output("\n\nAh well, why not indulge a little?  You take one hand and begin to sensuously stroke your shaft, aiming to get yourself nice and erect, while with the fingers of the other you slide into the lizan's tailhole, seeing if your teasing will get a reaction and prove [arian.ey] wants [arian.eir] butt fucked.");
		output("\n\n\"<i>Hmm... hehe.  It's so little... [pc.name]... you can do better.</i>\"");
		output("\n\nOkay, it seems there's no need to hesitate any more.  Your cock rock-solid with anticipation, you wriggle yourself into the proper position and thrust yourself bluntly up [arian.eir] ass.  Arian moans lewdly in [arian.eir] sleep, [arian.eir] well-trained pucker easily, nay, eagerly taking you in a single thrust, the hungry muscles sliding wetly across your length and then clamping down in an effort to suck you inside.");
		output("\n\n\"<i>Oooh... that's what I'm talking about... make me tasty...</i>\" Arian's hips eagerly begin thrusting against you in an attempt to force you even deeper into [arian.eir] contracting rosebud; every time you push inside, the flesh surrounding your [pc.cock " + pc.smallestCockIndex() + "] yields, allowing you easy access; and every time you pull out, Arian's sphincter grips you tightly, as if trying to prevent you from leaving its tight embrace.  It feels good, despite being a bit difficult to get into proper rhythm.");
		output("\n\nStill, you persevere despite the awkwardness, leaning over and whispering into Arian's ear, asking if [arian.ey] wants to be stuffed nice and full.");
		output("\n\n\"<i>More than full... I want to be as big as Miss Turkey...</i>\"");
		output("\n\nIs that so, you ask?  Does [arian.ey] really want a big squishy belly, stuffed full of hot, [pc.cumFlavor] " + pc.mf("man","herm") + "-goo?");
		output("\n\n\"<i>Hmm, yessss... put the sauce inside me,</i>\" Arian hisses in obvious pleasure.");
		output("\n\nAlready hot and bothered, you don't need much more encouragement.  A few final thrusts, brutal in your eagerness, and you give yourself over to climax, cumming as long and hard as you can into Arian's greedy little butt.");
		output("\n\nYou cum as hard as you can, but find yourself unable to cum as much you're used to, due to the fact you're still half-asleep.  \"<i>Hmm, no... more stuffing.  I need it for my muffins...</i>\"  You try your best, but just can't dredge up anything more of note, and tell Arian that [arian.ey]'ll need to get some sleep and you'll stuff [arian.em] in the morning.  Arian whimpers, but seems to calm down for the time being... now maybe you can get some proper sleep.");
		output("\n\nYou try to pull out of the lizan's trained ass, but find yourself unable to.  Well, this is not exactly how you saw yourself spending the night today, but you're too tired to put much of an effort extracting your [pc.cock " + pc.smallestCockIndex() + "] from the lizan's greedy butthole.  You get as comfortable as you can, given your current position, and close your eyes...");
		pc.orgasm();
	}
	else {
		output("\n\nPity you don't have the necessary parts to play with [arian.em], though.  Still, maybe if you do something a little special for him, [arian.ey]'ll calm down and let you get some sleep...?");
		output("\n\nWith anyone else, you'd probably lube your fingers up first; given what a total buttslut Arian's turned [arian.em]self into, though, you doubt [arian.ey] needs it.  Gently, you begin pressing against [arian.eir] puckered tailhole with two fingers; eagerly it slips open, allowing you access with what you'd swear was a soft slurping sound. The interior is wet and slick, more like an aroused pussy than a normal anus, and you start to slowly thrust your fingers in and out of the warm, wet depths.");
		output("\n\nPulling your hand out becomes increasingly difficult as Arian's ass basically sucks you in like a vacuum.  \"<i>Ohh... not stuffing... but feels good too....</i>\"");
		
		output("\n\nYou wonder if maybe you should grow a cock... that, or try to tighten up Arian's ass so [arian.ey] stops being so obsessed with getting it stuffed full of cock.  As you ponder this deep conundrum, you continue pistoning your fingers into the buttslut lizan's ass; you wonder if you can make [arian.em] cum with just this alone...?");
		
		output("\n\n\"<i>Hmm, you missed a spot.</i>\"  Arian begins humping your fingers eagerly, trying to shove them as deep inside [arian.eir] greedy ass as [arian.ey] can.");
		output("\n\nYou continue pumping inside of the clearly pleased lizan for a while, but eventually you grow bored; as much as [arian.ey] might be enjoying this, it's not really doing anything for you, and you still want to get some sleep.  You give [arian.em] one last, deep thrust, and then try to withdraw your fingers only to find that you can't.  The greedy lizard-ass won't let you go!");
		output("\n\n\"<i>No, if you remove the stuffing the bagels won't be tasty...</i>\" Arian mutters, still asleep.");
		output("\n\nYou give a few more tugs, then sigh in disgruntlement.  Looks like you'll just have to put up with this; you're too sleepy to wake [arian.em] up.  Still, Arian's in for a tongue-lashing in the morning, you note to yourself, even as you drift off to sleep.");
		pc.lust(15);
	}
	clearMenu();
	addButton(0, "Next", sleep);
}
//Waking up
//Always happens the morning after sleeping with Arian.
//Outcome slightly modified by AnalXP.
public function wakeUpAfterArianSleep():void {
	clearOutput();
	if (pc.hasCock()) {
		//if (arian.mf("m", "f") == "f")
			//output(images.showImage("arianfemale-camp-dreamingArian"));	
		//else	
			//output(images.showImage("arianmale-camp-dreamingArian"));
		//(if AnalXP < 33)
		if (arian.analExp() < 33) {
			//(PC tried but didn't manage to get their cocks in. Even tho you slept with it inside, you do go flaccid at some point in the night.)
			output("Your eyes open, and you suddenly realize that whatever dreams you were having... are now gone.  You make note of the still sleeping lizan right next to you and recall last night's events.  You wonder if Arian will remember any of that...");
			output("\n\nGetting yourself out of bed, you start to stretch your muscles, cracking joints and generally waking yourself up.  While you are doing this, the lizan yawns loudly, slowly coming awake as well.  Rubbing the sleep out of [arian.eir] eyes, Arian utters.  \"<i>Morning, [pc.name].  Sleep well?</i>\"  [arian.ey] turns to look at you and suddenly hides [arian.em]self under the covers.");
			output("\n\nYou give [arian.em] a wide grin and repeat the sentiment, assuring [arian.em] that you did indeed sleep well.  Aww, why's [arian.ey] being so shy?  It's far too late for either of you to be worried about being naked around each other.");
			output("\n\nArian's head pokes from under the covers.  \"<i>I suppose you're right... but that's still an impressive sight,</i>\"  [arian.ey] says pointing at your erect cock");
			if (pc.cockTotal() > 1) output("s");
			output(".");
			
			output("\n\nWell, Arian gives you quite an incentive to sprout it.  Even in [arian.eir] sleep, [arian.ey]'s a masterful tease, you tell [arian.em].");
			output("\n\nArian grins apologetically.  \"<i>Sorry... didn't mean to tease you or anything, [pc.name].  Do you want me to help you with that?</i>\"");
			output("\n\n\"<i>Well, if you're so inclined</i>\", you tell [arian.em], though the grin on your face makes it obvious you'd welcome a little attention from your reptilian playmate.");
			output("\n\n\"<i>All right!  Sit down,</i>\" [arian.ey] says, getting up and motioning towards [arian.eir] bed.");
			
			output("\n\nYou easily catch on to what the lizan has in mind and, with a smile, do as you are told, baring your crotch so to give [arian.em] the best access.");
			
			output("\n\nArian promptly nuzzles your [pc.multiCocks], rubbing [arian.eir] face all over ");
			if (pc.cockTotal() == 1) output("it");
			else output("them");
			output(" shamelessly until a dollop of pre forms on the tip of your [pc.cock " + pc.biggestCockIndex() + "].  \"<i>[pc.name]?</i>\"  You give a deliberate groan, playing up how much you're enjoying this for Arian's benefit and smiling at [arian.em].  \"<i>Thanks for the breakfast,</i>\"  [arian.ey] says with a smile, then proceeds to take the entirety of your [pc.cock] past [arian.eir] lips and down [arian.eir] throat.  You can't resist chuckling and patting [arian.em] on the head.");
			
			output("\n\nThe lizan mage looks up as best as [arian.ey] can while bobbing on your shaft, trying to gauge your reaction and making sure [arian.ey]'s doing a good job of blowing you.  You smile and make it quite clear that you're enjoying this, then let out a hollow moan as your morning wood goes soft with a decent-sized explosion of cum into the lizan's sucking mouth.");
			output("\n\nArian's eyes bulge with surprise and [arian.ey] begins drinking down in earnest, moaning in enjoyment, which proves to be a mistake... shortly after a particularly lengthy moan, [arian.ey] tries to swallow and winds up choking.  Some cum escapes [arian.em] through [arian.eir] nose and [arian.ey] quickly pulls away, coughing.  Unfortunately for [arian.em], you're still cumming, and the result that even as [arian.ey] gags and splutters, you keep on spurting cum all over [arian.eir] face until you've emptied yourself.  You sigh in relief, then, with a hint of guilt, ask Arian if [arian.ey]'s all right?");
			output("\n\nWiping your seed off [arian.eir] eyes, [arian.ey] says, \"<i>I'm fine... should have been more careful... and don't worry about the facial either, all I need is a few moments to clean myself up.</i>\"  [arian.ey] gets up and walks towards a jug filled with water [arian.ey] keeps nearby.");
			output("\n\nYou quietly get up, pull your clothes on and start heading off to another busy day as Champion.  As you go, you can't help but notice your reptilian lover is licking [arian.eir] face clean of cum and washing it down with the water, rather than washing [arian.em]self off.");
		}
		else if (arian.analExp() < 66) {
			output("With a wide yawn, you open your eyes and realize your dreams have been chased away by your sudden bout of wakefulness.  Arian seems to still be asleep; you take a short moment to snuggle up to the curled lizan, rubbing your erect cock up [arian.eir] butt crack.  Despite going soft and slipping out of the lizan's warm innards, you still have to contend with a morning wood... so you dutifully hump yourself between the lizan's buttcheeks, poking the base of [arian.eir] tail with your protruding shaft.");
			
			output("\n\n\"<i>Hmm, I'm awake already, stop poking me,</i>\" Arian protests, rubbing the sleep off [arian.eir] eyes and turning to look at you over [arian.eir] shoulder.  \"<i>Morning, [pc.name].  You don't have to keep poking me under the tail to wake me up,</i>\" [arian.ey] says, a bit grumpy.  Then [arian.ey] realizes that your hands are still occupied hugging [arian.em], so what's poking [arian.em] is...  \"<i>Oh!  Sorry about that, [pc.name]!  I thought you wanted something... I mean, maybe you do want something?</i>\"  [arian.ey] smiles nervously at you.");
			
			output("\n\nYou make a show of pursing your lips.  The question might be, you decide, does Arian want to do something?  After all, those were rather mixed signals [arian.ey] sent you last night...");
			output("\n\n\"<i>Mixed signals?  Did I do something in the night!?</i>\" [arian.ey] asks worried.");
			output("\n\nWell, you tell [arian.em], first [arian.ey] started acting like [arian.ey] really, really wanted you to fuck [arian.eir] ass.  Then, just when you were getting all steamed up and ready to start, [arian.ey] suddenly stopped.  So you were left to try and get back to sleep despite a raging hard-on.  It was really rather annoying, you tell [arian.em].");
			output("\n\n\"<i>Oh... umm... sorry.  I was probably sleep talking.  Doesn't happen too often, but well....  Sorry, I had no intention of getting you all worked up for nothing.</i>\"");
			
			output("\n\nYou tell [arian.em] that's a start.  Still, you think Arian might want you to work off this morning wood with [arian.em], hmm?  Would [arian.ey] like it if you held [arian.em] close and gave [arian.eir] ass a good hard fuck?");
			output("\n\nArian scratches [arian.eir] chin, smiling nervously.  \"<i>Well, I wouldn't be opposed, if you want to.</i>\"");
			output("\n\nYou promptly seize the lizan in a tight embrace, already guiding your [pc.cock " + pc.smallestCockIndex() + "] towards " + arian.mf("his naughty boy-pussy","her tail-hole") + " with a smile on your face.  You teasingly muse aloud about who was saying you were giving [arian.em] the choice to say no?");
			output("\n\nArian jumps a bit at being suddenly grabbed, but doesn't resist, instead, [arian.ey] positions [arian.em]self to give you easy access to [arian.eir] rosebud.  \"<i>Drat!  And here I thought I would be able to escape punishment from getting you all worked up,</i>\"  Arian replies with a smile.");
			output("\n\nYou waste no further time, pushing your way firmly inside the hole that has so captivated you.  The lizan's tight muscles grip and squeeze you most wonderfully, and you thrust yourself back and forth as quickly and firmly as you can manage without actually hurting [arian.em].");
			output("\n\n\"<i>Ah... [pc.name], you really know how to work my ass, don't you?  Hmm... if anyone told me anal feels this good back then I would have said they're insane, but - Oh!... this wonderful dick of yours feels so good.</i>\"  Arian sighs and begins humping back at you.  \"<i>There's no better way to get ready for a full day ahead of us than having sex with you like this,</i>\" [arian.ey] says dreamily.");
			output("\n\nYou thrust and moan and groan, losing yourself in the pleasures of sex with your reptilian lover of ass-fucking.  Eventually, the inevitable happens and, with one final cry, you release your steaming spunk up Arian's tailhole.");
			output("\n\n\"<i>Haaa... I can feel your seed filling me up, washing my ass with your wonderful cream!  Ah, [pc.name]... I love you.  We should do this more often!</i>\"  Arian says in delight as you finish pumping [arian.eir] ass full of jism with a few more thrusts.");
			output("\n\nMaybe we should do this more often, you tell Arian.  The two of you stay locked in an embrace for a little while longer, enjoying this morning's afterglow until Arian decides to break the silence.  \"<i>Maybe we should get ready for the day ahead?  Not that I mind staying like this all day.</i>\"");
			output("\n\nYou agree, and messily pull yourself free of the lizan's tight ass, getting off of your lover's back and stretching out your stiff muscles.  Arian does the same, taking care to keep [arian.eir] ass closed as tightly as possible, to avoid losing any of your earlier deposit.  \"<i>Say, [pc.name].  If you put your clothes on now, they're going to get all dirty.  So, why not get that cleaned up?</i>\" the lizan mage comments, pointing at your cum-slickened shaft.");
			output("\n\nYou agree with the lizan, and start looking around for a convenient rag to clean yourself off with.  But before you can spot one, you feel a familiar lizan's mouth encompass your shaft and begin sucking earnestly, making sure to get your shaft squeaky clean, even as you begin sporting another erection.  With a slurp, Arian pulls free of your shaft, leaving it to bob in the cool air of the morning as [arian.ey] grins at you, wiping [arian.eir] mouth with the back of [arian.eir] arm.  \"<i>There.  I cleaned you up.</i>\"  [arian.ey] grins.");
			
			output("\n\nYou chuckle and tap the sneaky little lizard on [arian.eir] nose, pointing out that [arian.ey] did do so, but now [arian.ey] got you hard again.  So, what are you supposed to do like this?  As pleasant as it sounds, you can't spend the day buried in [arian.eir] tight little ass.  For emphasis, you spank the lizan sharply on the closest ass-cheek, producing a gobbet of cum trickling from [arian.eir] used tailhole.");
			
			output("\n\nArian yelps, moving [arian.eir] hands to plug [arian.eir] behind.  [arian.ey] looks at you and smiles nervously.  \"<i>Sorry, [pc.name].  I couldn't contain myself.  It looked so tasty,</i>\"  [arian.ey] licks [arian.eir] lips for emphasis.");
			
			output("\n\nYou smile and chuckle; for a respected mage, Arian really has such a perverted side, and you tell [arian.em] this.  As [arian.ey] looks embarrassed, you sigh and declare you'll just have to put up with it, and start to redress yourself.");
			
			output("\n\n\"<i>Sorry about that.  I'll make it up to you later, if you want,</i>\"  [arian.ey] offers, walking towards a small closet to fetch a towel.  You tell [arian.em] that you'll hold [arian.em] up to that, finish redressing, and head outside to start your day.");
		}
		else { // AnalXP <= 100
			//(PC fucked and came inside Arian, couldn't pull out. Wake up with a morning wood and surprisingly... still inside the lizan.)
			output("\n\nYou feel a sudden urge to hump and wake up, only to find yourself still deeply lodged inside the greedy lizan's wanton rosebud.  Recalling the previous night and your little quickie in the night, you smile.  It's no wonder you're feeling particularly rested this morning.  [arian.eir] greedy butt is as clingy as it was during the night... refusing to yield and let your shaft go.");
			output("\n\nWell, if [arian.ey]'s really that desperate for a buttfuck... you wrap your arms around your reptilian lover's waist, both affectionately and as a way to maintain your position, and start to thrust your pelvis, pistoning your morning wood inside the insatiable asshole you've encouraged in your lover.");
			output("\n\nArian moans and begins bucking back; then after a couple pumps [arian.ey] opens [arian.eir] eyes.  \"<i>Oh... [pc.name]?  Oh!  This feels good...  W-what are you doing?</i>\"");
			output("\n\nJust giving [arian.em] what [arian.ey] clearly wants so badly, you reply in a distracted tone; you're starting to get into a nice rhythm here and you don't want to lose it.");
			output("\n\nArian moans, and begins humping back at you eagerly.  \"<i>Oh... you might feel more comfortable in this position.</i>\"  [arian.ey] rolls around on the bed, until [arian.ey] is face down on [arian.eir] pillow, while [arian.eir] butt and tail are high up in the air to give you full access to [arian.eir] eager butt.");
			output("\n\nIf you weren't already buried inside of [arian.em], you'd pounce right into [arian.eir] ass.  Instead, you redouble your efforts, savoring the delicious interior of your little buttslut's ass and [arian.eir] now-deliberate efforts to milk your cock of its cum.");
			output("\n\n\"<i>Hmm... harder... faster,</i>\"  Arian begs, in between moans of pleasure.  Seeing no reason to deny [arian.em], you pick up the pace, roughly pounding [arian.em] for all you're worth.");
			output("\n\nWith a groan, you feel [arian.eir] sphincter contract, pulling you even deeper inside.  Looking down, you realize ");
			if (arian.hasVagina()) {
				output(arian.mf("his","her") + " pussy is squirting [arian.eir] juices all over your lower body");
				if (arian.hasCock()) {
					output(" and ");
				}
				else output("; ");
			}
			else if (arian.hasCock()) {
				output(arian.mf("his","her") + " ");
				if (arian.cockTotal() > 1) output("twin shafts are");
				else output("shaft is");
				output(" squirting white ropes of lizan cum all over the bedsheets;");
			}
			output(" what a naughty little lizan.");
			
			output("\n\nYou can't resist playfully teasing Arian that [arian.ey] is such a buttslut.  ");
			if (!pc.hasVagina()) output("Did [arian.ey] always know [arian.ey] wanted a man to top [arian.em], or is this development new to [arian.em]?");
			else output("Does [arian.ey] really get off on having a girl with a dick all [arian.eir] own fuck [arian.em] like a girl, hmm?");
			
			output("\n\n\"<i>No... but I love it regardless!  Fill me with your seed, please!</i>\"  Arian begs, moaning and eagerly awaiting your deposit.");
			output("\n\nYou thrust into [arian.em] thrice more, then, with a hollow cry, let out all the seed you can to sate your lovely little buttslut's thirst.  And this time, you can properly focus on cumming, too.");
			//(Low cum amount)
			if (pc.cumQ() <= 200) output("\n\nThe first jet of [pc.cumNoun] of the day spurts forth from your tip to paint the eager lizan's insides.  \"<i>Ahhh... that's the way you do it,</i>\"  Arian says, tongue lolling out in pleasure as your cock finishes throbbing and shooting inside.");
			//(Medium cum amount)
			else if (pc.cumQ() <= 750) {
				output("\n\nString after string of [pc.cumNoun] leaves your tool to paint the lizan's bowels white with the results of your morning escapade, even swelling [arian.eir] belly a bit.  \"<i>Oh, yessss... breakfast.... Hah,</i>\"  Arian says, tongue lolling out in pleasure as [arian.ey] anally devours your pent up [pc.cumNoun].");
			}
			//(High cum amount)
			else output("\n\nA veritable eruption explodes from within your cock and out of your tip, flooding the lizan's buttslut with the results [arian.ey] craved.  \"<i>Yesssss!  Best... morning... ever,</i>\"  [arian.ey] says, completely blissed out, tongue lolling out, as your prodigious amount of [pc.cumNoun] inflates [arian.em] like a balloon.");
			
			output("\n\n\"<i>Hmm... [pc.name], I loved waking up like this.  How about sleeping with me again tonight,</i>\"  Arian suggests, smiling in [arian.eir] afterglow.");
			
			output("\n\nYou are silent for a moment, instead concentrating on pulling your cock out of the lizan's ass.  Once you are free, you slap [arian.em] playfully on the butt and tell [arian.em] you'll think about it.");
			output("\n\n\"<i>Hmm... please do...</i>\"  Arian's mouth opens in a wide yawn.  \"<i>Still a bit sleepy.  I think I'll take a nap now, if you'll excuse me.</i>\"");
			output("\n\nYou chuckle and tell Arian [arian.ey]'s such a lazy little lizard, stroking [arian.eir] head affectionately before getting dressed and leaving to start your day.");
		}
		pc.orgasm();
	}
	else { //PC has no cock
		//These do not link to a sex scene. No cocks, no sex in the morning, sorry girls/genderless.
		//(if AnalXP < 33)
		if (arian.analExp() < 33) {
			output("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [arian.eir] own, rubbing the sleep off [arian.eir] eyes, [arian.ey] looks about until [arian.ey] spots you.  \"<i>Good morning, [pc.name]!</i>\"  [arian.ey] says cheerfully, getting up and lazily stretching [arian.em]self as well.  \"<i>Sleep well?</i>\"");
			output("\n\nYou tell [arian.em] that you did, and ask if [arian.ey] enjoyed having you in [arian.eir] bed as well?  \"<i>I did!  I really enjoyed having you spend the night with me.</i>\"  [arian.ey] grins, prehensile tail swishing lazily behind.");
			output("\n\nWell, if that's the case, you reply, you might just consider sleeping with [arian.em] more often.  You wink as you tell [arian.em] this, kind of hoping [arian.ey]'ll blush - it's such an odd sight to see.  Arian doesn't disappoint, fidgeting a bit as [arian.eir] cheeks get slightly rose-tinted.  \"<i>I hope you will come more often,</i>\" [arian.ey] replies, always grinning.  \"<i>Maybe we should get ready for the day?</i>\"");
			output("\n\nYou tell [arian.em] that's a good idea, and start fishing for your clothes.  Without shame, you start getting dressed in front of [arian.em], wondering if [arian.ey]'ll appreciate the views you're giving [arian.em].  Arian starts dressing up [arian.em]self stopping every once in awhile to appreciate your body... though you know [arian.ey]'s looking [arian.ey] shyly averts [arian.eir] eyes.  You smile and give [arian.em] an appreciative shake of your booty, just to know you like the attention, before focusing on getting dressed.");
			output("\n\nOnce you're both fully dressed, Arian smiles at you.  \"<i>[pc.name], have a nice day... and please come visit me soon.</i>\"  You promise you will, and start heading out.");
			output("\n\n\"<i>Wait!  Before you go, could you... never mind...</i>\"  The lizan fidgets a bit and turns away, walking towards [arian.eir] work desk.  With a knowing smirk on your face, you walk back and grab [arian.em] shoulder, forcefully spinning [arian.em] around and kissing [arian.em] witless.  You pause for a moment to admire the blissfully stunned, dopey look on your lover's face, then walk off to begin yet another day.");
			pc.lust(10);
		}
		else if (arian.analExp() < 66) {
			output("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [arian.eir] own, rubbing the sleep off [arian.eir] eyes, [arian.ey] looks about until [arian.ey] spots you.  \"<i>Good morning, [pc.name]!</i>\" [arian.ey] says cheerfully, getting up and lazily stretching [arian.em]self as well.  \"<i>Sleep well?</i>\"");
			
			output("\n\nYou did and ask if [arian.ey] also slept well.  Rather than replying, the lizan bites [arian.eir] lower lip and begins fidgeting in what appears to be embarrassment.  You ask what the matter is, your expression making it clear you aren't going anywhere until [arian.ey] talks about it.");
			output("\n\n\"<i>Well, I did sleep well.  It's just that I also had the strangest... dream.</i>\"  [arian.ey] swallows audibly.  Oh?  And what was this dream about?  You ask in a playful tone, but you think you have an idea already...");
			output("\n\n\"<i>Uhh... well, I was... and then... I... had things... done to me...</i>\" [arian.ey] explains nervously.");
			
			output("\n\nYou shake your head and tell [arian.em] that you didn't understand a word of that.  Fidgeting, the lizan recomposes [arian.em]self and begins explaining once more.  \"<i>I-I dreamt I was... well... a muffin and... uhh... I needed my fillings, but the baker kept teasing me by putting the wrong needles in my... bottom... and... well... there was no cream... so... uuh...</i>\"  Embarrassed beyond belief, the lizan just stops talking and just fiddles [arian.eir] fingers, white cheeks tinted with the distinct rosy-pink tone that comes with embarrassment.");
			output("\n\nYou smile and can't resist stroking your fingers across the lizan's still naked ass, squeezing the round plumpness of [arian.eir] cheeks and stroking [arian.eir] slutty butt-pucker, just to see how [arian.ey]'ll] react.  Arian whimpers, ");
			if (arian.hasCock()) {
				output(arian.mf("his","her") + " ");
				if (arian.biggestCockLength() >= ARIAN_COCK_SIZE_3) output("exposed ");
				output("bulbous shaft");
				if (arian.cockTotal() > 1) output("s begin");
				else output(" begins");
				output(" sporting an erection");
				if (arian.biggestCockLength() < ARIAN_COCK_SIZE_3) {
					output(", poking ");
					if (arian.cockTotal() > 1) output("its tip");
					else output("their tips");
					output(" out of Arian's genital slit");
				}
				output(".");
			}
			else if (arian.hasVagina()) output("and [arian.eir] moist pussy, begins forming a stream of juices that gently run its course through the inside of Arian's thighs, evaporating before hitting the floor due to the lizan's currently elevated body heat.");
			output("  [arian.ey] pants, eyes glazed.  \"<i>Uhh... [pc.name]...</i>\"");
			
			output("\n\nYou smile at [arian.em] gently and step back, pulling on your clothes and giving [arian.em] a tender kiss on the cheek before you slap [arian.eir] bum and head off to start another day.  \"<i>[pc.name].  Visit me soon... please?</i>\" you hear Arian say as you leave, still panting and flustered due to [arian.eir] arousal.");
			pc.lust(10);
		}
		else { // AnalXP <= 100
			output("You yawn quietly as you find yourself waking up to another new day.  You note that your hand doesn't feel as cramped as you'd expected; in fact, it turns out that your little buttslut must have let your fingers go sometime after you'd gone back to sleep.  You sigh gently and pat Arian on the back; the thought slips into your mind that maybe [arian.ey] would like it more if you'd grow a new cock, so you can fuck [arian.em] up the ass the way [arian.ey] clearly enjoys so much...");
			output("\n\nArian yawns widely, licking [arian.eir] lips and turning to the side to greet you with a sleepy smile.  \"<i>Morning, [pc.name],</i>\" [arian.ey] says, rubbing the sleep off [arian.eir] eyes; [arian.eir] tail slowly creeps its way over your midriff.  \"<i>Sleep well?</i>\"");
			
			output("\n\nYou tell [arian.em] that you did, though there was a little problem in the middle of the night, a knowing smirk on your features as you say this.  Concerned, Arian asks, \"<i>What happened.</i>\"");
			
			output("\n\nOh, nothing that probably couldn't be solved by your regrowing a cock, you joke.  Arian looks confused.  \"<i>Whatever do you mean by that?</i>\"");
			
			output("\n\nYou just smile at [arian.em] and tell [arian.em] not to worry [arian.eir] pretty little head, or [arian.eir] cute little butt.  You pat [arian.em] on the ass playfully, then swing your [pc.legs] off of the bed and get up, ready to start getting dressed.  Arian still looks mildly confused, but decides to get off bed and start getting dressed as well.  During the whole process [arian.ey] keeps shooting you longing glances.");
			
			output("\n\nYou finish pulling your clothes on and, unable to resist your curiosity, ask your little love-lizard why [arian.ey] keeps looking at you like that?");
			
			output("\n\nArian fiddles [arian.eir] fingers.  \"<i>What you said earlier.  I... would really appreciate it if you grew a nice, big, thick cock... full of cum...</i>\"  Arian trails off, licking [arian.eir] lips dreamily and fidgeting slightly.");
			
			output("\n\nYou teasingly ask if [arian.ey]'s really gotten that used to your reaming [arian.eir] ass like that - why, you would have thought [arian.ey]'d prefer if it you stopped.  Arian averts [arian.eir] eyes and bites [arian.eir] lower lip.  \"<i>No, I mean....  I didn't like it... much... at first.  But, I guess the feeling kinda grew on me, and... well... I've been feeling just so empty lately.</i>\"  [arian.ey] swallows audibly.  \"<i>What I mean to say is... yes, I like it when you poke me back there.</i>\"  [arian.ey] hides [arian.eir] face in embarrassment, though [arian.ey] fidgets in what you've come to recognize as an indication [arian.ey] is aroused.  You can't resist smiling, then stepping over to clasp the still-naked lizan's bum, fingers slipping around to gently tease the entrance of [arian.eir] well-trained back pucker, which flexes and tries to entice your fingers inside.  You tell him you'll consider growing a cock back, tap him on the nose with the very fingers you were just teasing him with, and then leave to start a new day.");
			pc.lust(10);
		}
	}
	
	flags["COC.ARIAN_MORNING"] = undefined;
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Egging Event
//Only if Arian has a vagina.
//Every 30 days, ArianEggEvent is set to 1. Allowing this event happen.
//It always happens the first time you visit Arian, every 30th day.
//If you don't visit Arian, you miss this event, and the eggs [arian.ey] would be laying.
public function arianEggingEvent():void {
	clearOutput();
	flags["COC.ARIAN_EGG_EVENT"] = 1;
	if (int(flags["COC.ARIAN_EGG_CHAT"]) == 0) {
		flags["COC.ARIAN_EGG_CHAT"] = 1;

		output("As you are about to enter Arian's tent, you hear a moan emanate from within.  Those aren't moans of pleasure though.  They are moans of discomfort.  Wondering if the lizan is all right, you decide to enter [arian.eir] tent.");
		
		output("\n\nArian is laying on [arian.eir] bed, naked, as [arian.ey] rubs [arian.eir] belly in a slow circular motion.  You rush to [arian.eir] side and ask what happened?");
		
		output("\n\n\"<i>Uh?  Oh, hello [pc.name].  Just feeling a bit sick, that's all.</i>\"  Arian smiles, somewhat embarrassed, and adds, \"<i>You see... it's that time... when girls... y'know.</i>\"  [arian.ey] giggles.");
		
		output("\n\nYou sigh in relief, for a moment you thought [arian.eir] health problems might have returned.  So... this means [arian.ey]'s growing a clutch of eggs inside [arian.eir]?");
		
		output("\n\nArian nods in confirmation.  \"<i>That's right.  Lizan females grow unfertilized eggs inside them and must lay those every 30 days.  Today just happens to be my day.  This is the time when a male would... fertilize... the eggs and then the female would lay a clutch of fertile eggs.</i>\"");
		
		output("\n\nYou listen attentively, then a question hits you.  Wouldn't lizans overpopulate if they lay eggs in clutches?  Or are those clutches particularly small?");
		
		output("\n\nArian shakes [arian.eir] head.  \"<i>No. Usually we lay clutches of 10 or so eggs, but despite all the eggs being fertilized, not all of them will mature into a healthy baby.  Usually only one or a couple manage to mature.</i>\"  That's sad to hear, you comment.  Arian smiles and shrugs.  \"<i>It's just the way we're built...</i>\"");
		
		output("\n\nYou ask if anyone could fertilize [arian.eir] egg.  Arian, fidgets and bites [arian.eir] lower lip.  \"<i>Well... yes.  Why do you ask?  Are you... maybe... interested?</i>\"  You give it some thought... and tell [arian.em] that you were just curious, but who knows... maybe in the future.");
		
		output("\n\nArian averts [arian.eir] eyes, smiling happily.  \"<i>Maybe, but I have to say this is not the way I saw myself having a family.  I always thought I'd be the one helping lay... you know?</i>\"  You nod, does that make [arian.em] uncomfortable?  Arian shakes [arian.eir] head.  \"<i>Not at all, if there's anyone I'd pick to father my children, that would certainly be you, [pc.name].</i>\"  [arian.ey] smiles at you, and you smile right back at [arian.em].");
		
		output("\n\nSo... unless you plan on having a family with [arian.em]... sex is out of the question.  Arian blurts out, \"<i>No!</i>\"  You recoil in surprise at [arian.eir] sudden outburst; [arian.ey] covers [arian.eir] mouth and smiles nervously.  \"<i>S-sorry... must be the hormones making me moody... regardless... no.  I have placed an enchantment on myself, and you won't be able to impregnate me unless we remove that.  So... someday when we're both ready and willing... hehe.</i>\"  [arian.ey] fidgets, laughing nervously.");
		
		output("\n\nYou tell [arian.em] that it's reassuring to hear that [arian.ey]'s being careful about this matter.");
		output("\n\n\"<i>Of course, parenthood is a big responsibility,</i>\" Arian notes.");
		
		output("\n\nYou nod your head.  Then, curious, you ask what [arian.ey]'ll do with the eggs after [arian.ey]'s laid them, if there's going to be nothing inside of them?");
		
		output("\n\n\"<i>Usually we'd just eat them, since they're rich in protein and good for the health of the mother, but I think I can try and create something useful for you.  You know how there are magical colored eggs that are said to have transformative effects, right?  I could try to use my magic and grow a few eggs with the color of your choosing.</i>\"");
		
		output("\n\nYou tell [arian.em] that could be very helpful in your quest, but you don't want [arian.em] to strain [arian.em]self; can [arian.ey] do it without hurting [arian.em]self?");
		
		output("\n\nArian puffs [arian.eir] chest out proudly.  \"<i>Of course I can!  Though magic can be unpredictable sometimes, I am a master mage, and something as simple as imbuing my own eggs with magic is no trouble at all...  but I appreciate your concern all the same.</i>\"  [arian.ey] smiles at you.");
		
		output("\n\nIf that's the case, you tell [arian.em], then you would appreciate it if [arian.ey] could try creating colored eggs for you from [arian.eir] unfertilized eggs.");
		
		output("\n\n\"<i>Sure!  Which color do you want?</i>\"");
	}
	else {
		output("As you are about to enter Arian's tent, you hear a moan emanate from within.  Seems like it's that time of the month again...");
		output("\n\nAs you enter the tent, you are greeted with the sight of Arian laying on [arian.eir] bed, naked, as [arian.ey] rubs [arian.eir] belly in a slow circular motion.  [arian.ey] spots you walking towards [arian.em] and greets you with a smile.  \"<i>Hello, [pc.name].  I have a new clutch of eggs growing inside me, would you like me to try and create a colored egg for you?</i>\"");
	}
	//(Display Color Options, in the future you will also have the option of telling her you want to fertilise her eggs.) (Also include a leave option.)
	clearMenu();
	addButton(0,"Brown",pickAnEggArian,"brown");
	addButton(1,"Purple",pickAnEggArian,"purple");
	addButton(2,"Blue",pickAnEggArian,"blue");
	addButton(3,"Pink",pickAnEggArian,"pink");
	addButton(4,"White",pickAnEggArian,"white");
	addButton(5,"Rubber",pickAnEggArian,"rubbery black");
	addButton(6,"No Thanks",leaveEggs);
}

//Pick a color
private function pickAnEggArian(color:String = "pink"):void {
	clearOutput();
	flags["COC.ARIAN_EGG_COLOR"] = color;
	output("You tell Arian you'd like [arian.em] to make you a " + color + " egg.");
	output("\n\n\"<i>All right,</i>\" Arian replies, closing [arian.eir] eyes and beginning to focus [arian.eir] magic.");
	output("\n\nYou watch in wonder as a " + color + " light seems to gather within Arian's belly, slowly fading away.  The lizan mage smiles and opens [arian.eir] eyes, tail waving lazily behind [arian.eir] in happiness.  \"<i>It's done.  I tried to get all my eggs imbued, but I won't know if I was successful or not until they're laid.</i>\"");
	
	output("\n\nYou thank [arian.em] for [arian.eir] efforts, give [arian.eir] a quick peck on the cheek, and then encourage [arian.em] to get some rest.  Arian nods.  \"<i>I should be ready to lay tomorrow, so don't forget to visit.</i>\"");
	output("\n\nYou nod in understanding and wave to [arian.em] as you leave [arian.eir] tent.");
	flags["COC.ARIAN_EGG_COUNTER"] = 1;
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
//Leave
private function leaveEggs():void {
	clearOutput();
	output("You tell [arian.em] that you don't want any colored eggs from [arian.em] this month.  The lizan nods, deciding it's not necessary for [arian.em] to spell out that this means [arian.ey]'ll just produce ordinary eggs and eat them for breakfast after [arian.ey]'s laid them.  \"<i>So, do you want something?</i>\" [arian.ey] asks.");
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Display Arian options
//Arian Lays Colored Eggs
//Happens the day after Egging Event, always happens the first time the PC visits.
//Even if you miss, trigger it the next visit anyways, so as long as you don't miss the egging event, you don't miss out on your colored eggs.
//Randomly decide between small or large egg, I'd say 50% chance of either.
public function arianLaysEggs():void {
	clearOutput();
	var color:String = flags["COC.ARIAN_EGG_COLOR"];
	flags["COC.ARIAN_EGG_COLOR"] = undefined;
	flags["COC.ARIAN_EGG_COUNTER"] = 0;
	output("As you approach the tent, you wonder if Arian's ready to lay those eggs...  Your contemplations are promptly interrupted as you hear a pained moan coming from inside.  Seems like Arian is in labor!  Without delay, you rush inside, to be greeted by the sight of naked lizan-");
	if (arian.hasCock()) output("herm");
	else output("girl");
	output(" squatting over a wooden basin, one hand between [arian.eir] legs, massaging [arian.eir] dripping treasure, while the other is rubbing [arian.eir] belly to try and coax the eggs out of [arian.em].");
	
	output("\n\nYou see [arian.em] sway momentarily, too focused on the task at hand to even notice you.  Fearing [arian.ey] might lose [arian.eir] balance and fall, you quickly move behind [arian.em], hugging and steadying [arian.em].");
	
	output("\n\nThe lizan ");
	if (arian.hasCock()) output("herm" + arian.mf("-boy", ""));
	else output("female");
	output(" is sucking in great lungfuls of air, slowly hissing them out as [arian.ey] soldiers on through the contractions of [arian.eir] womb.  So intent on [arian.eir] labors is [arian.ey] that [arian.ey] doesn't recognize your presence, at first.  After a few moments, however, [arian.eir] eyes finally recognize you're there and [arian.ey] gives you a brave smile.  \"<i>Ah, hello, [pc.name]; sorry you had to catch me like this - I was hoping I'd have this over and done before you saw it,</i>\" [arian.ey] notes apologetically.");
	
	output("\n\nYou scold [arian.em], telling [arian.em] [arian.ey] should've called you when [arian.ey] was getting ready to lay; you would have gladly helped.  You tighten the hug, bringing [arian.em] closer to your chest, one hand moving to meet hers as [arian.ey] slowly massages [arian.eir] belly.  You entwine your fingers with hers and help [arian.em] massage [arian.eir] belly.");
	
	output("\n\n\"<i>Mmm... thank you, [pc.name], that does feel nicer when it's someone else.  This wouldn't be so bad if I knew it was going to be a baby at the end of it, but I go through all this for nothing more than a quick snack.  I can kind of understand why harpies have always been so nuts about getting fertilized when they're full of eggs, now: it's not so much that they - or I - want to be moms so badly as it is just so annoying to go through this for absolutely no reward at the end of it,</i>\" the lizan notes, sighing heavily and leaning against you for support.");

	output("\n\nStill, you are very thankful for [arian.em] doing this for you.  Then you note that [arian.ey] seems to really have fallen into [arian.eir] role as a " + arian.mf("hermboy","girl") + ".  You would never expect to hear this kind of comment from someone who was a man before... but it's cute that Arian is acting this way, and you enjoy [arian.em] the way [arian.ey] is now.  You give [arian.em] a peck on the cheek for emphasis.  Now, [arian.ey] has a clutch to lay, and you'll be here during all the steps necessary to do so.  You take [arian.eir] hand off [arian.eir] belly and place it against your midriff, then proceed to rub [arian.eir] belly by yourself.  Your other hand, releases [arian.em] and does the same with the hand massaging [arian.eir] pussy lips, replacing [arian.eir] hand shortly as you tease and massage the contracting opening to [arian.eir] depths.");

	output("\n\nThe lizan moans throatily.  \"<i>Mmm... you really do have magic fingers, don't you?</i>\"  [arian.ey] says, then winces.  \"<i>Ahg, that was a nasty one - they'll be coming out any minute now,</i>\" [arian.ey] notes in a surprisingly level tone, moaning softly as [arian.eir] abdominal muscles flex and contract.");

	output("\n\nNever stopping your ministrations, you ask what you should do?  Arian doesn't have time to answer though, as you feel one of the egg shaped lumps beginning its journey down the lizan's birth canal.  You feel [arian.eir] pussy dilating, far faster than it should on any woman, and for a moment you worry as the egg passes quickly, falling into your waiting hand.  You barely have time to safely place it on the basin as another egg soon falls into your hand.  Arian's belly vibrates with the rapid contractions, rapidly reducing in size as the eggs make their way out.");

	output("\n\n\"<i>Nnng... once it finally starts, it's over quick, so don't worry, [pc.name].  I'll be done in a minute,</i>\" [arian.ey] promises you.");
	
	output("\n\nYou nod, though [arian.ey] can't see you from this position.  You whisper that [arian.ey] is a very brave girl to face this kind of ordeal... and you can't deny that seeing [arian.eir] laying eggs like this has a certain appeal.  [arian.ey] looks very sexy.  You tell [arian.em] that this is good practice for when [arian.ey]'s laying fertile eggs.  You hope [arian.ey]'ll look as sexy as [arian.ey] looks now, once the time comes.");

	output("\n\nThe lizan laughs, a rather pitch-switching sound as [arian.eir] uterus continues flexing.  \"<i>If you really think I'm sexy like this, [pc.name], then I sure hope we'll end up doing this for real sooner rather than later.  Oooh... not more left in me now,</i>\" [arian.ey] says, closing [arian.eir] eyes and continuing to push.  As [arian.ey] said, within moments, [arian.eir] belly is flat as normal, while the last few eggs have clattered into the straw-lined basin [arian.ey]'s been squatting over.  With a hissing sigh of relief, [arian.ey] gingerly straightens up and steps over it.  \"<i>I... can you please get me some cool water, [pc.name]?  I have a jug over there?</i>\" [arian.ey] asks, pointing in the appropriate direction.");
	
	output("\n\nOf course you can, you reply.  You gently help [arian.em] down on the floor from [arian.eir] squat, and head towards the jug [arian.ey] indicated.  Looking about, you quickly spot a mug and fill it with water, bringing the cool liquid back to the panting lizan.  [arian.ey] takes it from you and gulps down a sizable mouthful of it, then pours some over [arian.eir] head.  \"<i>Ohhh... that feels better.  Why don't you check the eggs, see if our little experiment worked?  I'm just going to regain my strength,</i>\" [arian.ey] suggests.");
	
	output("\n\nYou nod your head, and begin sorting through the eggs.  Most of them look like common eggs, not that much different from large chicken eggs.  Eventually, you find one that seems to be appropriate.  Separating this egg from the others, you check one more time and find out that Arian only managed to lay one " + color + " egg.  Still, that's good enough for you.  You take the egg and turn to place it gently on the nearby counter.  When you turn to check up on Arian though you spot the lizan, casually lifting one of the \"<i>normal</i>\" eggs, sizing it up.");
	
	output("\n\nArian pays no attention to you, instead hungrily inspecting [arian.eir] just-laid egg.  A trickle of drool oozes out of the corner of [arian.eir] mouth and is lapped up with a quick flick of a long tongue before [arian.ey] opens [arian.eir] jaws and crams the whole egg inside.  [arian.ey] mouths it around before [arian.ey] manages to puncture it, audibly sucking out the insides before spitting the crushed but still-intact eggshell out into [arian.eir] hand.  [arian.ey] grabs another and gobbles it down with the same eagerness as before, spitting out the shell after sucking out the contents.");
	
	output("\n\nYou cough, trying to remind the hungry lizan before you, that you're still in the room...");

	output("\n\nShe pauses, just about to cram another egg into [arian.eir] mouth, and looks sheepish.  \"<i>Ah... sorry, [pc.name].  I'm just so hungry and, well, it's not like there's anything else in these things, right?  Or did you want to try one?</i>\" [arian.ey] suddenly suggests, offering [arian.eir] latest 'treat' to you.");

	output("\n\nYou politely refuse, telling [arian.em] that [arian.ey] probably needs it more than you do, since [arian.ey] just went through labor.  Anyways you should probably be going.  You thank the lizan for the " + color + " egg and tell [arian.em] to enjoy [arian.eir]... meal... and point out that, while you personally appreciate the view, [arian.ey] should probably put on some clothes later.");
	output("\n\nArian gasps and quickly covers [arian.em]self, smiling nervously to you.  \"<i>Thank you for pointing that out, [pc.name].  Although,</i>\" [arian.ey] giggles nervously.  \"<i>If you'd rather I stay naked, I'm willing to do that for you...</i>\"  You give the idea some thought... but decide to tell [arian.em] that you'd prefer [arian.ey] put on some clothes next time you visit.  Otherwise you miss out on having [arian.em] sensuously strip for you, you laugh.");
	
	output("\n\n\"<i>Well, that's one way to look at it, I guess.</i>\"  Arian laughs.  \"<i>So, if you don't want to join me, a lady needs to have [arian.eir] breakfast,</i>\" [arian.ey] tells you, then swallows another egg whole, letting out a very unladylike belch.  \"<i>Okay, that was a bit too much to swallow,</i>\" [arian.ey] admits, blood flushing the pale scales of [arian.eir] face in one of [arian.eir] pseudo-blushes.");
	
	output("\n\nYou laugh at Arian's reaction, telling [arian.em] that you don't mind.  You should go right now.  You turn to pocket the egg and leave Arian's tent, bidding the lizan farewell before you do.\n\n");
	
	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	//(PC obtains (Large) Egg of the [color] asked message.)
	var itype:ItemSlotClass;
	if (color == "brown") itype = new CoCBrownEggLarge();
	else if (color == "purple") itype = new CoCPurpleEggLarge();
	else if (color == "blue") itype = new CoCBlueEggLarge();
	else if (color == "pink") itype = new CoCPinkEggLarge();
	else if (color == "white") itype = new CoCWhiteEggLarge();
	else if (color == "rubbery black") itype = new CoCBlackEggLarge();
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([itype]);
}
//DildoFun
private function arianDildoFun():void {
	//As usual, nothing we write is centaur compatible.
	//Cocks are going to be more or less forgotten here.
	//PC must have the dildo sex toy from Giacomo to access this scene
	//PC and Arian must both have vaginas to access this scene
	clearOutput();
	//1st time:
	if (int(flags["COC.TIMES_ARIAN_DILDOED"]) == 0) {
		output("Looking over your reptilian girlfriend, your eyes go down [arian.eir] body");
		if (arian.hasCock()) {
			output(", past [arian.eir] cock");
			if (arian.cockTotal() > 1) output("s");
		}
		else output(",");
		output(" to [arian.eir] dripping wet pussy, clearly yearning for some action.  Reflecting that your own love-lips feel the same way, you decide to try something fun and present to Arian the dildo that you ");
		if (pc.hasKeyItem("Dildo") >= 0) output("bought from Giacomo");
		else output("got from Tamani");
		output(", asking if [arian.ey]'s willing to give this a try.");
		
		output("\n\nThe lizan averts [arian.eir] eyes in embarrassment.  \"<i>Umm... I guess I'm okay with it?</i>\"  [arian.ey] fidgets a bit.  \"<i>But I've never used anything when... much less something like that.</i>\"");
		
		output("\n\nYou shush [arian.em] gently, assuring [arian.em] that it'll be all right; you'll be here to help [arian.em] get comfortable with it and to show [arian.em] how to use it right.  Besides, it's much better than [arian.eir] fingers....");
		
		output("\n\n\"<i>A-All right then.</i>\"  [arian.ey] smiles nervously.");
	}
	else {
		output("You present your dildo to Arian again, telling [arian.em] that this time, you want to play with your toys - after all, [arian.ey] enjoyed it so much the first time.");
		
		output("\n\nArian fidgets in embarrassment.  \"<i>Okay.</i>\"");
	}
	IncrementFlag("COC.TIMES_ARIAN_DILDOED");
	
	output("\n\nYou carefully put the dildo down beside the pillow before turning to Arian and pulling [arian.em] into an embrace, arms around [arian.eir] waist, before spinning [arian.em] around, sweeping [arian.em] off [arian.eir] feet, and dropping [arian.em] flat on the bed.  [arian.ey] giggles nervously as you slide yourself into position, straddling [arian.em] and pinning [arian.eir] wrists to the bed beside [arian.eir] head, leaving [arian.em] helpless.  Your tongue slides out of your lips in a lecherous gesture before you bend your head down and kiss [arian.em] first on one dark nipple, and then on the other.  Arian wriggles and squirms underneath you as you start to plant quick, soft, gentle kisses up [arian.eir] torso and towards [arian.eir] neck, diligently kissing your way towards [arian.eir] lips.  Once there, you plant a butterfly kiss on [arian.eir] lips, but that's not enough; you release your grip on [arian.eir] wrists and instead place a soft but authoritative palm on each of [arian.eir] cheeks, pinning [arian.em] in place as you passionately consume [arian.eir] lips with your own.");
	
	output("\n\nYour lizan lover reciprocates your kiss, [arian.eir] scaled arms wrapping around you as [arian.ey] hugs you tightly, legs instinctively spreading to allow you access.  You continue to suckle at [arian.eir] lips, forcefully probing at them with your tongue to see if [arian.ey] will allow you access.  Even as you do this, you settle yourself more comfortably upon [arian.eir] body and slide a hand down [arian.eir] torso, over [arian.eir] belly until you reach between [arian.eir] legs.  ");

	if (arian.hasCock()) {
		output("Ignoring [arian.eir] cock");
		if (arian.cockTotal() > 1) output("s");
		output(", y");
	}
	else output("Y");
	output("ou slide first one finger into [arian.eir] slick pussy and then another, gently caressing [arian.eir] inner labia to see if you can find [arian.eir] sweet spots.  Arian's eyes open in surprise as the first pang of pleasure hits [arian.em], [arian.ey] moans into your kiss.  [arian.eir] tongue darts to dance with your own in excitement.");
	
	output("\n\nYou allow [arian.eir] tongue to wrestle with yours, suckling lewdly upon it and watching as Arian writhes and moans underneath you, totally in your thrall.  But, enough is enough when it comes to a warm up; you break the kiss and remove your hand from [arian.eir] cunt.  Arian protests feebly, but you shush [arian.em], caressing [arian.eir] cheek as you declare that the time for warming up is over.  With your other hand, you reach for the nearby dildo and then slap it between [arian.eir] [arian.chest].  It's time [arian.ey] put on a little show for you....");
	
	output("\n\nThe lizan mage swallows nervously, but nods in understanding.  You give [arian.em] one last kiss for being so obedient, squeeze [arian.eir] breasts in passing, and then drag yourself off of [arian.em], deliberately scraping your [pc.vagina] over [arian.eir] belly as you go and shivering with pleasure at the sensations [arian.eir] smoothly scaly skin sends through your cunt.  You hop off of the bed and reposition yourself sitting upright at the base, where you have a perfect seat for whatever [arian.ey] plans on doing next.");
	
	output("\n\nArian takes the dildo in hand, gripping and releasing it to watch the rubber shift under [arian.eir] touch.  [arian.ey] looks nervously at you one more time and then opens [arian.eir] mouth wide.  [arian.ey] slips the dildo between [arian.eir] lips, suckling softly, wetting it with [arian.eir] saliva.  Not bad, not bad at all for a beginner, and you nod your head, encouraging [arian.em] that [arian.ey]'s getting off to a good start.  Arian blinks in understanding and continues to lather the rubber shaft in saliva.");
	
	output("\n\nShe pops the dildo out of [arian.eir] mouth, satisfied with its current wetness.  With one hand, [arian.ey] cups a breast and rubs the tip of the dildo on [arian.eir] erect nipple, moaning at the stimulation.  [arian.eir] eyes glance at you to see if [arian.ey]'s pleasing you.  You shift so that [arian.ey] can see your naked form, letting [arian.em] watch as your hands slip teasingly down to your love canal's entrance.  You moan softly, starting to frig yourself in excitement at the show [arian.ey]'s putting on.  Emboldened by your display, Arian smiles and licks the tip of the dildo once more.  [arian.ey] moans as [arian.ey] strokes [arian.eir] other nipple, setting the dildo between [arian.eir] breasts to run its length along [arian.eir] cleavage.  Whenever the dildo grows dry, [arian.ey] takes it back to [arian.eir] mouth to lather it again with a drawn out slurp.  [arian.ey]'s starting to get in the mood, you notice.");
	
	output("\n\nYou clap your hands all of a sudden, startling Arian out of [arian.eir] oral ravishing.  You crawl your way up to [arian.em], your motions smooth and seductive, gently taking the dildo from [arian.eir] unresisting fingers as you coil yourself around [arian.em].  [arian.ey]'s been putting on a very nice show, you stage whisper to [arian.em], but this isn't really what you wanted to see.  You're going to give [arian.em] a hand and show [arian.em] just how good this can really be....");
	
	output("\n\nYou start by seductively wrapping your own tongue around the dildo, sloppily kissing it and slurping on it, sucking eagerly at the taste of [arian.eir] saliva and making sure it's good and sodden with both your mixed juices.  Then, you hold the dripping wet toy up to [arian.em] for [arian.eir] inspection.  [arian.ey] looks at the dildo enraptured, panting in excitement.  Then, now that [arian.ey]'s good and excited, you bring the dildo down to the junction of [arian.eir] legs, ");
	if (arian.hasCock()) {
		output("brushing it tantalizingly across the sensitive skin of [arian.eir] pre-oozing cock");
		if (arian.cockTotal() > 1) output("s");
		output(" before");
	}
	output(" brushing it against [arian.eir] outer lips, stroking it up and down each labia, rubbing it against [arian.eir] clitoris, gently pushing the very tip of it into [arian.eir] cunt only to then withdraw it before it can really start to stretch [arian.eir] cunt.");
	
	output("\n\nArian moans and fidgets as you play with [arian.eir] body, moaning and gasping at the friction generated by the rubber dildo.  \"<i>Oh, [pc.name].  T-that feels great!</i>\" [arian.ey] moans in delight, bucking against the dildo in an attempt to find purchase.");
	
	output("\n\nIf it feels so good, then why doesn't [arian.ey] prove it, you ask [arian.em], continuing to tease [arian.em] with the dildo but refusing to put it in, your free hand stroking your [pc.clit] and fingerfucking your [pc.vagina] at an excited pace.  Isn't [arian.ey] just dying to have this fake-cock between [arian.eir] legs, spreading [arian.eir] pussy wide and stretching out [arian.eir] gut until [arian.ey]'s a helpless puddle of fuck?  Why doesn't [arian.ey] show you that's what [arian.ey] wants?");
	
	output("\n\nArian looks at you in confusion.  \"<i>Prove it? ...Ah!</i>\" [arian.ey] moans loudly, bucking wildly against your teases.  Yes, prove it... and with that, you take a firm grip on the dildo and roughly thrust it as far into Arian's cunt as the horny lizan will let it enter!  The " + arian.mf("", "she-") + "lizan's maw opens in a look of surprise; instead of a scream, all [arian.ey] can manage is a gasp.  You make sure to commit the image to memory for moments.  Arian closes [arian.eir] eyes and moans - a throaty moan, a moan of pleasure.  [arian.eir] face contorts as [arian.eir] vaginal walls clamp down on the rubbery intruder.  ");
	if (arian.hasCock()) {
		output("[arian.eir] cock");
		if (arian.cockTotal() > 1) output("s throb");
		else output("throbs");
		output(" throb as a jet of whiteness escape them.  ");
	}
	output("You can feel it... the suddenness of your penetration brought the poor lizan mage to an instant orgasm.");
	
	output("\n\nGrinning wickedly to yourself, you sprawl yourself across your reptilian girlfriend, hungrily kissing [arian.em] and sucking [arian.eir] long, prehensile tongue into your mouth to play with it - and to muffle any further screams of ecstasy.  With one hand, you grope [arian.eir] [arian.chestDesc], while with the other you continue to plunge the dildo back and forth inside of [arian.em], sliding it out - not easy, with how tightly [arian.ey] grips it in [arian.eir] cunt - before roughly pounding it home again, a repetitive motion to burrow for [arian.eir] cervix and to leave [arian.eir] a quivering pile under you.  The poor lizan is helpless against your relentless assault.  All Arian manages is squeals of pleasure and wanton moans of desperate lust.");
	
	output("\n\nYou keep this up for minute after delightfully entertaining minute, before you decide that [arian.ey]'s had [arian.eir] fun; now it's your turn.  You try to tug the dildo free of [arian.eir] clenching cunt, but [arian.ey] just quakes and moans as another orgasm rips through [arian.eir] body - [arian.ey]'s holding the toy so tightly inside [arian.eir] that you can't get it out!  You let go of it and pat [arian.eir] cheek, tauntingly complaining that [arian.ey]'s not being fair.");
	
	output("\n\nArian groans, opening [arian.eir] eyes slightly to look at you.  \"<i>W-What do you... mean by that?</i>\" [arian.ey] asks, clearly not recovered after [arian.eir] climax.");
	
	output("\n\nWhy, [arian.ey]'s hogging the dildo all to [arian.em]self, you reply, making another failed attempt at pulling it free for emphasis.  [arian.ey] gets to get off, but you get no fun for yourself - now, does that seem fair to [arian.em]?  Hmm?  Arian pants, shaking [arian.eir] head.  \"<i>Sorry...</i>\"  [arian.ey] attempts to even out [arian.eir] breathing enough to at least speak normally.");

	output("\n\n\"<i>Sorry, [pc.name].  I don't think you can pull the dildo out of me yet.  That would... well... it would be too much for me.  So please.  Just don't, at least for now.</i>\"  You crawl off of [arian.em] slightly, so [arian.ey] can move more freely and so you can watch [arian.em] at work.  \"<i>I think I can help you with your problem though.</i>\"  Interested, you give [arian.em] the signal to go ahead.  [arian.ey] begins chanting a spell and within moments you watch in amusement.  Your dildo's base begins extruding itself, growing into a familiar phallic shape.  Soon enough you're looking at an exact replica of the dildo currently buried in your lizan girlfriend.  Clever girl....");

	output("\n\nArian smiles tiredly.  \"<i>There.  Forgive me, [pc.name], but I'm too tired to move right now.</i>\"  That's all right; you can move for [arian.em], you reply, already shifting yourself into position, bringing your [pc.vagina] into alignment to start impaling yourself on your now double-ended dildo.");
	
	output("\n\nYou shift and thrash, moaning lewdly as you stroke every spot that you know will bring you pleasure; in your aroused state, it's easy to get into things.  Each thrust you make earns an ecstatic groan from your girlfriend as it shifts the dildo inside [arian.eir] over-aroused pussy.  You hump and you grind and you squeeze, a tug of war between your two netherlips as you and Arian fight for possession of your favorite toy.  You can feel the pleasure overwhelming you, sparks of arousal setting your brain on fire; you're close... oh, gods, you're so close!");
	
	output("\n\nWith one mighty clench and tug, you pull the dildo free of Arian's love-hole, throwing your head back and crying out as you climax, the waves of orgasm washing through you, your whole body quaking in pleasure.  When at last it ends, you let yourself fall limply back on the bed with a sigh of relief, your pussy slackening and letting your dildo fall free.");
	
	output("\n\nOnce you catch your breath, you absently reach down and bring your favorite toy up to your face, you watch as it slowly reverts back to its original form, though still dripping with your mixed juices.  Smiling openly, you inform Arian that you may just be the luckiest " + pc.mf("boy", "girl") + " in Mareth, to have a " + arian.mf("herm-boy", "girl") + "friend like [arian.em].");
	
	output("\n\nArian pants, still winded, though [arian.eir] breathing seems to have returned to a more normal level.  [arian.ey] can't help but grin at your compliment.  \"<i>Don't be silly, [pc.name].  I'm the lucky one.  But I'm really glad you think so highly of me.</i>\"  Why shouldn't you?  [arian.ey] gave up [arian.eir] birth-gender, just to better please you - why, any girl who passed up a chance to snap up someone as sweet as Arian was a fool, but they'll never amend their mistake, because [arian.ey]'s all yours now.  With that you slither around in the bed so that you can glomp onto your " + arian.mf("herm-boy", "girl") + "friend, rubbing your " + pc.skinFurScales() + " cheek against [arian.eir] own smooth scales, hugging [arian.eir] tightly to you.");

	output("\n\nArian rubs [arian.em]self back at you affectionately.  \"<i>I love you, [pc.name].</i>\"  You just hold [arian.em] and let [arian.em] feel your warmth.  Then, you realise you're still holding a sopping wet dildo in one hand, and you casually present it to Arian, holding it in front of [arian.eir] face and telling [arian.em] to clean it.  Before [arian.ey] can protest, you point out that <b>[arian.ey]</b> got the most fun out of it, and <b>[arian.ey]</b> made most of the mess, so that makes it <b>[arian.em]</b> responsibility to clean it up.  You waggle it in front of [arian.eir] snout for emphasis.");
	
	output("\n\nArian blinks at your words, but concedes with a smile.  \"<i>Of course.</i>\"  [arian.ey] opens [arian.eir] mouth and lets [arian.eir] tongue roll out, inviting you to place the dildo into [arian.eir] open mouth.  You promptly slide the fake-cock gently home, letting [arian.em] start at [arian.eir] own pace.");
	
	output("\n\nShe cleans it diligently, and from the looks of it, [arian.ey]'s also enjoying [arian.em]self immensely.  Arian's eyes are closed most of the time, but you notice that [arian.ey] opens them to glance at you and smile to [arian.em]self.  Whatever's going through [arian.eir] head must be very pleasant.  It takes only a couple minutes before you pull the dildo out to inspect it.  Lizan spit shines in the light of the ambience, and from what you can see... there's not a single trace of your, or Arian's, juices left on the dildo.  With a smile, you pat your lizan on the head, congratulating [arian.em] on a job well done.");
	
	output("\n\n\"<i>Thank you, but I'm not done yet.</i>\"  You look at [arian.em], wondering what [arian.ey] has in mind.  Arian slithers along your body, until [arian.eir] face is hovering your [pc.vagina].  A knowing smirk crosses your lips and you relax, eager to let [arian.em] get to work.  [arian.ey] gently spreads your legs and begins licking, making sure to drink in all of your juice.");
	
	output("\n\nYou gasp and shudder, moaning softly as [arian.ey] pleasures your oversensitive love canal.  It doesn't take long, maybe a minute or two, before you are writhing in a mini-orgasm, your female fluids gushing into your lover's eager mouth, bathing [arian.eir] probing tongue.  [arian.ey] makes sure to lap it all, not keen on letting even a single drop be wasted.  \"<i>Hmm, delicious,</i>\" Arian says as [arian.ey] licks [arian.eir] lips clean of leftovers.");
	
	output("\n\nYou heave a sigh of contentment and authoritatively drag your little lizan slut into your arms, wrapping yourself around [arian.em] in a cuddle and making it quite clear you don't intend to let [arian.em] go anywhere any time soon.  Fortunately, [arian.ey] seems quite eager to be there, and so you shut your eyes and allow yourself to slowly drift off to sleep.  Before you fully embrace unconsciousness, though, you place a gentle hand on Arian's pussy, stroking [arian.em] softly - not to arouse [arian.em] yet again, but just to let [arian.em] feel a loving touch there, in the place that brings you both such pleasures....");

	processTime(arianFollower() ? 35 + rand(5) : 55 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}