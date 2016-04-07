import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Urta variables
//flags["COC.TIMES_FUCKED_URTA"] = times fucked
//flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = urtas horsecock comfort level
	//-1 = PC pissed her off
	//0 = first timern
	//1-10 = slightly comfortable
	//11+ = flaunt it
//flags["COC.URTA_TIME_SINCE_LAST_CAME"] = hours turned off
	//0 = ready to rock!

//Urtas horsey bits =
	//LxW = 20x3
//Luv Lock - flags["COC.URTA_PC_LOVE_COUNTER"]:
//0 = normal, 1 = love, -1 = never love, flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] -1 = hate
/*Luv rating! - flags["COC.URTA_PC_AFFECTION_COUNTER"]
-Increased by 1-2 per sex.  Increased by 1 for visiting off duty
-Drops hugely if you go to her house and leave.
-Small drop if you come to her table and leave.
-Drops by 1 per day.
*/


//const URTA_FAMILY_TALK_ATTEMPTS:int = 442;
//const URTA_OPEN_ABOUT_EDRYN:int = 443;
//const PC_DISLIKES_URTA_AND_EDRYN_TOGETHER:int = 444;
//const DISCUSSED_URTA_ALCOHOLISM:int = 445;
//const URTA_EGGS:int = 582;
//const URTA_FERTILE_EGGS:int = 583;
//const URTA_EGG_FORCE_EVENT:int = 584;
//const URTA_TIMES_EGG_PREGGED:int = 585;
//const URTA_EGG_INCUBATION:int = 586;
//const URTA_FLATBELLY_NOTICE:int = 587;
//const URTA_SCYLLA_BIG_DICK_TIMES_DONE:int = 633;
//const URTA_FERTILE:int = 723;
//const URTA_PREG_EVERYBODY:int = 724;
//const URTA_CUM_NO_CUM_DAYS:int = 782;
//const URTA_X_RAPHAEL_HAPPENED:int = 783;
//const MET_OLIVIA:int = 822;
//const URTA_PETPLAY_DONE:int = 857;

//Implementation of TimeAwareInterface
public function timeChange():void
{
	//var needNext:Boolean = false;
	//drainedByKath = false; //This var will only be set true after Kath licks Urta out - it stops you from going back immediately for more Urta sex
	//pregnancy.pregnancyAdvance();
	//trace("\nUrta time change: Time is " + hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
	//if (flags["COC.NEED_URTA_LETTER"] == 1 && model.time.hours == 6) urtaPregs.getUrtaLetter(); //Urta Letters
	//if (pregnancy.incubation == 0 && (pregnancy.type == PregnancyStore.PREGNANCY_BEE_EGGS || PregnancyStore.PREGNANCY_DRIDER_EGGS)) {
		//pregnancy.knockUpForce(); //Silently clear Urta's egg pregnancy
		//flags["COC.URTA_EGGS"] = 0;
		//flags["COC.URTA_FERTILE_EGGS"] = 0;
	//}
	//if (flags["COC.URTA_TIME_SINCE_LAST_CAME"] > 0) Flag("COC.URTA_TIME_SINCE_LAST_CAME", -1, true); //Count down timer for urta's lust
	//if (flags["COC.URTA_EGG_FORCE_EVENT"] > 0) flags["COC.URTA_EGG_FORCE_EVENT"]--; //Countdown to urta freakout
	//Urta egg freak out
	//if (flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] > 1) {
		//flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"]--;
		//if (flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] < 1) flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] = 1;
	//}
	if (hours == 0) {
		if (Flag("COC.URTA_TIME_SINCE_LAST_CAME") == 0) IncrementFlag("COC.URTA_CUM_NO_CUM_DAYS");
		else flags["COC.URTA_CUM_NO_CUM_DAYS"] = 0;
		if (flags["COC.URTA_PC_AFFECTION_COUNTER"] > 0) {
			flags["COC.URTA_PC_AFFECTION_COUNTER"] -= .5;
			if (flags["COC.URTA_PC_AFFECTION_COUNTER"] < 0) flags["COC.URTA_PC_AFFECTION_COUNTER"] = 0;
		}
	}
}

public function urtaIsPregnant(byPc:Boolean):Boolean {
	return false;
}

public function urtaSprite():void {
	userInterface.showName("\nURTA");
}

public function urtaCapacity():Number {
	var bonus:int = flags["COC.TIMES_RUT_FUCKED_URTAS_CUNT"] * 5;
	if(bonus > 40) bonus = 40;
	if(flags["COC.URTA_TENTACLE_GAPED"] > 0) return 500;
	return 60 + bonus;
}

public function urtaLove(love:Number = 0):Boolean {
	if(flags["COC.URTA_PC_LOVE_COUNTER"] == -1) return false;
	if(love == 0) {
		return flags["COC.URTA_PC_LOVE_COUNTER"] == 1;
	}
	if(love > 0) {
		Flag("COC.URTA_PC_AFFECTION_COUNTER", love, true);
	}
	if(love < 0) {
		Flag("COC.URTA_PC_AFFECTION_COUNTER", -love, true);
	}
	//if(flags["COC.URTA_PC_LOVE_COUNTER"] == 1) {
		////Queue up Amily madness
		////Only happens if freakout hasn't happened yet.
		//if(love > 0 && flags["COC.AMILY_VISITING_URTA"] == 0 && amilyScene.amilyFollower() && flags["COC.AMILY_FOLLOWER"] == 1) flags["COC.AMILY_NEED_TO_FREAK_ABOUT_URTA"] = 1;
		//return true;
	//}
	//else 
	return false;
}

public function urtaAvailableForSex():Boolean { return urtaFuckbuddy() /*&& telAdre.scylla.action != Scylla.SCYLLA_ACTION_FUCKING_URTA*/ && Flag("COC.URTA_ANGRY_AT_PC_COUNTDOWN") == 0; }

public function urtaFuckbuddy():Boolean { //Returns true if Urta is either the player's fuckbuddy or lover
	if (/*kGAMECLASS.urtaQuest.urtaBusy() ||*/ flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] == -1) return false;
	if (urtaJustFriends()) return false;
	return (flags["COC.TIMES_FUCKED_URTA"] > 0);
}

public function urtaJustFriends():Boolean { return Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") == 0 && flags["COC.URTA_PC_LOVE_COUNTER"] == -1; }

public function urtaAtBar():Boolean { //Is Urta physically at the Wet Bitch?
return (/*!kGAMECLASS.urtaQuest.urtaBusy() && flags["COC.AMILY_VISITING_URTA"] != 1 &&*/ hours > 4 && hours < 15 && flags["COC.KATHERINE_UNLOCKED"] != 3);
}

public function urtaDrunk():Boolean {
	//Preg = no drinking!
	//if (pregnancy.isPregnant) return false;
	if (flags["COC.URTA_ALCOHOL_HABIT"] == -1) return false;
	if (hours > 12 && flags["COC.URTA_ALCOHOL_HABIT"] < 1) return true;
	if (hours > 8 && flags["COC.URTA_ALCOHOL_HABIT"] >= 1) return true;
	else return false;
}

private function urtaOpenAboutEdryn():Boolean {
	//Did it come out from the scylla threesome?
	//if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00145] > 0) return true;
	//Did it come out from marble?
	//if(flags[kFLAGS.URTA_KNOWS_PC_HAS_MARBLE_FOLLOWER] > 0) return true;
	//Did it come out from discussions?
	if(flags["COC.URTA_OPEN_ABOUT_EDRYN"] > 0) return true;
	return false;
}

public function knockUpUrtaChance():void { //Moved here from UrtaPregs since it needs to be accessed from outside Urta
	////GTFO IF PREGGO
	//if (pregnancy.isPregnant) return;
	////GTFO IF NOT FERTILE
	//if (flags["COC.URTA_FERTILE"] != 1) return;
	////10% + up to 40% @ 1000mLs of cum, with bonus virility!
	//var chance:Number = 10;
	//temp = pc.cumQ() / 25;
	//if (temp > 40) temp = 40;
	//chance += temp;
	////Bonus virility time!
	//temp = pc.virilityQ() * 100;
	//if (temp > 50) temp = 50;
	//chance += temp;
	////FINAL ROLL!
	//if (chance > rand(100)) {
	//pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, 384);
	//flags[kFLAGS.URTA_PREGNANT_DELIVERY_SCENE] = 0;
	//}
}

public function urtaBarDescript():Boolean {
	output("\n\n");
	//Urta PISSED
	if(flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] > 1) {
		output("Urta is sitting at a table, swishing a bottle around and looking forlorn.  She glances up and sees you, then immediately turns away.", false);
		return false;
	}
	//	[PISSED URTA TALK]
	//	Urta looks up at you and growls, \"<i>Do I look like I want to talk to you right now? Fuck off.</i>\"
	//[Post Pissed Talk]
	if(flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] == 1) {
		output("Urta is sitting at a table, swishing a bottle around and looking forlorn.  She looks up at you and sighs, \"<i>Look, I still don't think we'll ever be the same, but to be frank, we're great in the sack and I've been lonely.  For now, I'll put the past behind me.</i>\"");
		flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] = 0;
		return true;
	}
	//Raphael betrayed reward
	if(flags["COC.RAPHEAL_COUNTDOWN_TIMER"] == -1 && flags["COC.UNKNOWN_FLAG_NUMBER_00148"] == 0) {
		output("Urta has an ecstatic grin plastered across her muzzle, and it only gets wider when she sees you.  Perhaps you should see what all the fuss is about?");
		return true;
	}
	if(flags["COC.UNKNOWN_FLAG_NUMBER_00350"] == 1) {
		output("Urta is sitting at her usual table, holding her head in her hands.  She doesn't even seem to notice you.");
		return true;
	}
	//[URTA ASHAMED]
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] == -1) {
		output("You see Urta on a bench in the corner with her legs crossed nervously.  Her tail is curling tightly around her leg, hiding the massive surprise between her legs.  In her hand is a mostly empty bottle of whiskey.  She's wobbling back and forth in her seat, and keeping her head down, refusing to meet your gaze any time you spare a glance her way.  It looks like she wants nothing to do with you.", false);
		return true;
	}
	//Post Scylla Appearance
	if(flags["COC.UNKNOWN_FLAG_NUMBER_00145"] == 0 && flags["COC.UNKNOWN_FLAG_NUMBER_00143"] > 0) {
		output("Urta's at her normal table, nursing a glass of water with nary a bottle of alcohol around.  She's fidgety and constantly glancing your way, but she never meets your eyes or acknowledges that she saw you.  Something is eating away at her.", false);
		return true;
	}
	//PREGNANT URTA
	//if (pregnancy.isPregnant) {
	//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
		//urtaPregs.urtaPregAppearance();
	//}
	//else { //Egg-Stuffed Urta:
		////This replaces the normal "display" for Urta in the Wet Bitch screen
		/////This scene lasts for the duration of Urta's egg pregnancy, whatever that is
		////Egg Level 1:
		//if (flags["COC.URTA_EGGS"] < 20) output("Urta is sitting quietly at her usual seat, sipping a mug of some non-alcoholic beer.  Though her clothes are still in place, you can just make out the bulging midriff stretching them taut, a consequence of all the eggs in her womb.");
		//else if (flags["COC.URTA_EGGS"] < 40) output("Urta is sitting rather uncomfortably at her usual seat.  Her swollen stomach is so large it keeps her from wearing her usual outfit, instead forcing her into a mini-shirt and a skirt bottom, allowing her midriff to be bare.  She occasionally runs a hand over the expanse, as if she can't believe it's actually there.");
		////Egg Level 3:
		//else output("Urta's bloated belly forces her to sit side-saddle at her usual table, the lumpy, egg-stuffed mass ballooning out in front of her.  Forced into a midriff-baring ensemble, she frequently touches it, occasionally seeming to trace an egg through the taut skin.");
	//}
	//return true;
	//}
	//Eggs Laid:
	//This replaces the normal "display" for Urta in the Wet Bitch Screen
	//This scene only appears once, after Urta's "pregnancy" is over
	//if (flags[kFLAGS.URTA_TIMES_EGG_PREGGED] > 0 && !pregnancy.isPregnant && flags[kFLAGS.URTA_FLATBELLY_NOTICE] == 0) {
	//output("Urta is seated at her usual spot in her usual dress, eagerly chugging down mug after mug of booze; her belly is washboard-flat again, and she's clearly making up for lost time after having given up alcohol for her 'pregnancy'.");
	//flags[kFLAGS.URTA_FLATBELLY_NOTICE] = 1;
	//return true;
	//}
	//[Love Urta Bar Appearance]
	if(flags["COC.URTA_PC_LOVE_COUNTER"] == 1) {
		if(flags["COC.URTA_ALCOHOL_HABIT"] == -1 || !urtaDrunk()) output("Urta is sitting at her usual table, sipping a glass of wine and wearing a form-fitting evening gown of shimmering black.  She looks up at you, happiness filling her eyes when she notices you entering the bar.");
		//(DRUNK)
		else output("Urta is sitting at her usual table wearing a shimmering black dress.  She's pretty clearly sloshed judging by her bleary gaze as she looks up at you.  The front of her dress visibly tents, and she waves you over with a lecherous grin.", false);
		return true;
	}
	if(Flag("COC.TIMES_FUCKED_URTA") == 0 && Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") > -1) {
		output("You see Urta on a bench in the corner with her feet propped up on a stool.  Her tail is coiled tightly around her left leg, just like every other time you've seen her.  The pretty gray fox gives you a slight nod before turning her attention back to the large square bottle of whiskey in front of her.");
		return true;
	}
	//[URTA FUCKBUDDIED]
	if(flags["COC.TIMES_FUCKED_URTA"] > 0) {
		output("You see Urta on a bench in the corner with her feet propped up on a stool.  She has a small mug on a table, quite different from the swill she chugged when you first met.  Her clothing is... far more risqué.  The top she's chosen for the moment is sheer to the extreme, making her proud black nipples visible to anyone who glances her way, and the short skirt she's wearing is nearly revealing her cunny.  ");
		if(Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") < 11) output("Thankfully she still has her other addition trapped under her tail, for now.");
		else output("Her half-hard horse-cock is plainly visible to anyone who spares her a glance, barely contained by a pair of tightly woven fishnet stockings.  She's looking at you and wiggling a finger your way...");
		return true;
	}
	trace("URTA Error: Bar descript encountered unexpected scenario.");
	return false;
}

public function urtaBarApproach():void {
	urtaSprite();
	//Images are handled by ImageManager now. This was the old way of doing things.
	//showImage(0);
	var temp:Function = null;
	clearOutput();
	//Raphael Reward
	if(flags["COC.RAPHEAL_COUNTDOWN_TIMER"] == -1 && flags["COC.UNKNOWN_FLAG_NUMBER_00148"] == 0) {
		flags["COC.UNKNOWN_FLAG_NUMBER_00148"] = 1;
		pc.credits += 10000;
		//statScreenRefresh();
		//output(images.showImage("urta-bar"), false);
		output("Urta claps as you walk up to her with an exuberant smile spread across her vulpine face.  She proudly announces, \"<i>You really turned in the Russet Rogue?!  I almost can't believe it.  Do you know how many women that rascal has fleeced out of their possessions?  The last count I made was over three dozen, and he even had the audacity to try it with me.  I'm ashamed to admit it nearly worked, but once he saw ALL of me, well he couldn't keep up the facade.  I nearly caught him that night.</i>\"\n\n");

		output("You smirk at her tale.  Knowing Raphael, seeing a horny Urta would've made him white as a ghost.  She goes on to list some of his crimes, \"<i>He's guilty of petty theft, disturbing the peace, robbery, lewd public behavior, lying under oath, defacing a public structure, destroying a public structure... I'd probably have to get the paperwork to remember the rest.  In truth his shenanigans aren't usually a big deal individually, but they've added up and garnered him a fairly sizable bounty.  He'll serve his punishment, and I hope he learns his lesson for a change.</i>\"\n\n");

		output("Urta fishes out a rather sizable pouch and tosses it onto the table, the numerous gems inside tinkling loudly as it plops down in front of you.  You untie the silken cord that holds the leather bag closed and see hundreds of sparkling gems, perhaps even a thousand.  Wow!  Raphael must have pissed off the wrong people!\n\n");

		output("The gray fox knocks back a swig from her bottle and sighs as if you've just removed one of the many weights hanging from her shoulders.  She looks back at you with a twinkle in her eyes, and you realize you've definitely improved her opinion of you.  Sadly there isn't time for more chit-chat, and you head back to camp, your gem-pouch heavy with new weight.");
		//(+love score!)
		urtaLove(3);
		processTime(45);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//Post Amily Sad Shit
	//if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00350] == 1) {
		//amilyXUrtaUrtaFallout();
		//return;
	//}
	if (urtaJustFriends()) { //You are friends with Urta, can talk about stuff not related to romance
		friendsTalkExpack();
		return;
	}
	//[URTA ASHAMED APPROACH]
	if(Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") == -1) {
		output("You approach Urta, but she slams her bottle down on the table hard enough to make it rattle.  She slurs, \"<i>Jusht... stay away from me.  I don't want any company right now.</i>\"\n\n");
		output("There's nothing to do but leave....");
		processTime(1);
		clearMenu();
		addButton(0, "Next", barTelAdre);
		return;
	}
	//Post Scylla discussion
	//if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00145] == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00143] > 0) {
		//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00145] = 1;
		//output("The apprehensive fox-morph's gaze lurches up at the sound of your approach, eyes going wide with nervousness.  Clearly she remembers her inebriated encounter with Scylla and is a little worried about the implications.  You sidle up to the table and look her in the eye questioningly – she must have something to say.\n\n", false);
//
		//output("\"<i>I... I want to apologize for the other night.  ", false);
		////(variant I: Love)
		//if(urtaLove()) output("I got drunk, I got horny, and Scylla kept offering.  I've turned her away so many times, but she looked so... hungry, like, sexually ravenous, and I lost control.  I love you [pc.name].  I've never had a relationship like this and it's hard being apart from you – so very hard.  I-I'd understand if you didn't want to see me anymore, but if you think about it, we could have a LOT of fun together.  If you want I'd do everything possible to avoid this happening again, even cutting back on my drinking.  Please, I love you.", false);
		////(variant II: Comfortable Fuckbuddies)
		//else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("I got really drunk, and well, Scylla is very, very sexy.  In this day and age having multiple partners doesn't raise that many eyebrows, but I know where you're from and I'd understand if you didn't like what happened.  It doesn't excuse my actions though, I definitely should've brought this up before now, and I-I'd understand if its made you doubt my judgement enough to never want to see me again.  Before you say anything, being with you... it changed my life.  You've given me back confidence and comforted me in ways no one has before.  If I have to cut back on my drinking and have someone drag me out of the room every time Scylla is around to stay with you, I will.  Please, don't leave me.", false);
		////(variant III: Still Nervous)
		//else output("I was so drunk and horny, and Scylla... she's very persuasive.  Y-you've been the only one to like me for me, even with this... this thing between my legs.  Having someone else want it when you're drunk and horny... I couldn't say no.  S-sometimes I just... NEED to cum.  And she said you'd let her help you before so I thought you'd be okay with it.  But now that I've had a chance to think on it... are you okay with it?  Please, don't just walk away from me... from us.  I'll curb my drinking if I have to.  I'll even pay someone to keep an eye on me while I drink if I have to.  Just.. what do you want me to do?", false);
		//output("</i>\"\n\n", false);
//
		//output("She snaps her mouth shut and looks at you ", false);
		//if(urtaLove()) output("with a worried expression", false);
		//else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 12) output("anxiously", false);
		//else output("nervously", false);
		//output(" while she awaits your reply.  It seems you could tell her to stay away from Scylla, enjoy Scylla, or just tell her you don't want to see her again.  What do you do?", false);
		////[No Scylla] [Scylla Okay] [Leave Her]
		//simpleChoices("No Scylla", tellUrtaNoMoreScylla, "Scylla Okay", tellUrtaMoreScyllaIsFine, "Leave Her", leaveUrtaAfterScyllaConfrontation, "", null, "", null);
		//return;
	//}
	//TO ZE FLIPOUT!
	//if(flags["COC.URTA_EGG_FORCE_EVENT"] > 0) {
		//urtaChewsOutPC();
		//return;
	//}
	//if (telAdre.katherineEmployment.canTalkToUrta()) { //Katherine training discussion
		//telAdre.katherineEmployment.talkToUrta();
		//return;
	//}
	//PREGNANT URTA
	//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
	//urtaPregs.urtaPreggoApproached();
	//return;
	//}
	//HERE WE GOEZ!
	//if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 5 && ((pc.inRut && pc.hasCock()) || (pc.inHeat && pc.hasVagina() )))
	//{
		//if(urtaDrunk()) urtaHeatRut.approachDrunkenUrta();
		//else urtaHeatRut.approachSoberUrtaHeatRutProc();
		//return;
	//}
	//[URTA FRIEND FUCKBUDDY BUT UNHORNY]
	if(flags["COC.URTA_TIME_SINCE_LAST_CAME"] > timeAsStamp && !urtaDrunk()) {
		//output(images.showImage("urta-bar"), false);
		//Twu wuv talk
		if(flags["COC.URTA_PC_AFFECTION_COUNTER"] >= 30 && flags["COC.URTA_PC_LOVE_COUNTER"] == undefined) {
			UrtaTwuWuvOffer();
			return;
		}
		//output("You approach Urta, who gives you a friendly smile and begins talking with you.  Thanks to her unusual endowments, it's easy to tell she's not quite in the mood.  The conversation is still pleasant though, and the two of you knock back a few ales while Urta recounts some of the wilder scenarios she's encountered as the captain of Tel'Adre's guard.", false);

		QBsTalkExpack();
		//doNext(barTelAdre);
		return;
	}
	//[Horny Urta Talk – Lovey]
	if(flags["COC.URTA_PC_LOVE_COUNTER"] == 1)
	{
		//Sworn off drinking, up till noon, or up to 8 if 'drink more'
		if(flags["COC.URTA_ALCOHOL_HABIT"] == -1 || !urtaDrunk()) {
			//output(images.showImage("urta-bar-drunk"), false);
			output("You walk up to Urta and you see her pivot herself to the side.  Her dress visibly tents at the sight of you, and you smirk as you realize she shifted in position to avoid slamming her hardening cock into the bottom of the table.  You cuddle close and wrap an arm around your lover, giving her a quick kiss on the lips and fondling her through her dress.  The tent immediately darkens as a rush of pre soaks into the material, and Urta half-pants, half-asks, \"<i>Oooh, lover, what do you have in mind today?</i>\"\n\n");
			output("You could go back to her place, suck her off under the table, or eat her out under the table.");
			//if(pc.canOviposit()) {
				//if(flags[kFLAGS.URTA_TIMES_EGG_PREGGED] == 0) output("\n\nYou contemplate asking Urta to help you take a load off your abdomen, but decide against it; Urta's probably too shy and pent up to let you fill her with your eggs. Maybe when she's gotten herself drunk and is more pliable, though...");
				//else output("\n\nYou don't think it's likely Urta would agree to host your eggs in her present state; wait until she's turned down her inhibitions before asking.");
			//}
			//[URTAZ PLACE] [Suck Off] [Eat Out] [Vixen & Cream]
			//simpleChoices("Her Place",goBackToUrtasForLuvinz,"Suck Off",blowUrtaUnderTheTableLuv,"Eat Out",eatUrtaOutNomNomPussy,"",0,"",0);
			clearMenu();
			addButton(0, "Her Place", goBackToUrtasForLuvinz, null, "Her Place", "Go to Urta's apartment for sex.");
			if (flags["COC.URTA_CUM_NO_CUM_DAYS"] >= 5) 
				addButton(1,"Suck Off",slurpFawkesCocksForFunAndInflation, null, "Suck Off", "Suck Urta's dick until she cums! \n\nNote: Given how long she hasn't relieved, this is most likely going to fill your belly.");
			else addButton(1, "Suck Off", blowUrtaUnderTheTableLuv, null, "Suck Off", "Suck Urta's dick until she cums!");
			
			addButton(2, "Eat Out", eatUrtaOutNomNomPussy, null, "Eat Out", "Get a taste of Urta's vagina! (And optionally, drink a glass of her cum.)");
			if (pc.hasCock() && !pc.isTaur()) addButton(3, "Vixen & Cream", vixenAndCreamPart1, false, "Vixen & Cream", "Try something special! \n\nNOTE: This is very long! Don't select this if you have ADHD.");
			
			addButton(14, "Leave", barTelAdre);
			return;
		}
		//[Horny Urta Talk – Drunk]
		else {
			//output(images.showImage("urta-bar-drunk"), false);
			output("You walk up to Urta and chuckle as the sloshed fox-girl latches onto you.  She squeals happily and crushes you into a tight hug.  Her hard cock rubs against you under the silken covering of her dress, slowly soaking it through with pre-cum.  She purrs drunkenly under your ear, \"<i>Mmmm, I was hoping you'd show up, lover.  Would you mind if I blew a load over your face while everyone watched?  Or maybe you could just crawl up into my lap and let me pump you full of cum?</i>\"\n\n");
			output("You could let her make a show of you sucking her off, try to ride her discreetly, or walk out and leave her disappointed.");
			//As per normal drunk-fawks
			clearMenu();
			addButton(0, "Jerkoff", getAPublicFacialFromUrta);
			if (pc.slut() < 33 && pc.exhibitionism() < 33) addDisabledButton(1, "Anal Ride", "Anal Ride", "No way!  You're not going to do that in front of EVERYONE.");
			else addButton(1, "Anal Ride", takeUrtaInTheButtPublically);
			
			if((pc.hasCock() && pc.cockThatFits(urtaCapacity()) >= 0) || pc.hasKeyItem("Deluxe Dildo") >= 0)
				addButton(3, "Spank Her", spankTheShitOutOfUrtaAndMakeHerCreamHerselfFromProstateStimulationAloneLikeTheHornyDrunkenSlutSheReallyIs);
			
			//if(flags["COC.RAPHEAL_COUNTDOWN_TIMER"] == -2 && RaphaelLikes() && flags[kFLAGS.URTA_X_RAPHAEL_HAPPENED] == 0) {
				//output("\n\nYou know Urta and Raphael get along about as well as cats and dogs, but it might be fun to have them double-team you in the dark.");
				//addButton(8,"3SomeSurprise",urtaAndRaphaelSurprise);
			//}
			
			addButton(14, "Leave", barTelAdre);
			return;
		}
	}
	
	//[Approach sloshed Urta 1st time]:
	if(Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") == 0 && Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") > -1) {
		//output(images.showImage("urta-bar-drunk"), false);
		output("Urta smiles broadly and noisily slurps a few dribbles of whiskey from her shiny black lips, watching you approach.  She gives you a smoking-hot 'come-hither' look and slurs, \"<i>I didn't think I'd get a chance to bump into you here, cutie.  Wanna dance?</i>\"\n\n");
		output("Before you can answer, something thumps the table hard enough to shake it.  You look at Urta quizzically, and she shrugs through a blush so bright it's visible through her fur.  The lithe fox squirms in her seat, panting and gasping, \"<i>Ummm, maybe later, I just realized I have to- OH MY GOD WHAT IS THAT?</i>\"\n\n");
		output("You spend a moment looking over your shoulder, but can't for the life of you figure out what she was freaking out about.  She must be really drunk!  You turn back to scold her, but Urta has vanished!  She must have left in a hurry – she left her bottle of \"<i>John Doe</i>\" behind, and still half-full.  The bar's back-door swings closed, maybe she went that way.  What do you do?");

		//(LEAVE HER TABLE) (DRINK HER BOOZE) (BACKDOOR)
		clearMenu();
		addButton(0, "Backdoor", urtaFollowedOutBack);
		addButton(1, "Drink Booze", drinkUrtasBooze);
		addButton(14, "Leave", barTelAdre);
		return;
	}
	//[URTA FRIEND APPROACH]

	//[URTA DRUNK AND NOT TAKING NO FOR AN ANSWER] You approach Urta, but as you get closer you can smell the alcohol cloying the air around her.  Sizing you up with bleary eyes, Urta reaches out and grabs you, pulling you down onto her lap.  You can feel her heartbeat through her 'addition' as it hardens and your butt-cheek.
	if(flags["COC.URTA_ALCOHOL_HABIT"] != -1 && urtaDrunk()) {
		//output(images.showImage("urta-bar-drunk"), false);
		output("The drunken fox roughly gropes you and whispers in your ear, \"<i>I NEED a good fuck right now, and it feels like someone wants a piece of Urta.  I can guess just which piece you're wanting too.  The only question is do I ");
		//CUT FOR NOW output("throw you over the table and fuck you,", false);
		output("let the beast loose and bounce you on my lap while we drink, ");
		output("jerk off onto your face in front of everyone, or have to remember your ass for later when you bolt for the door.  What'll it be, hun?</i>\"");
		//temp = null;
		//if(pc.canOviposit()) {
			//if(flags[kFLAGS.URTA_TIMES_EGG_PREGGED] == 0) output("\n\nHmm... sounds like she wants to fuck almost as badly as you want to get these eggs out of you.  Besides, didn't Urta say to you once that she's basically barren and sterile?  You'd be doing her a favor by letting her carry your eggs, wouldn't you?  Let's see if she's drunk enough to let you fill her full...");
			//temp = giveTheFoxSomeEggs;
		//}
		//simpleChoices("Jerkoff",getAPublicFacialFromUrta,"Anal Ride",takeUrtaInTheButtPublically,"Lay Eggs",temp,"Spank Her",spank,"Leave",barTelAdre);
		clearMenu();
		addButton(0, "Jerkoff", getAPublicFacialFromUrta);
		if (pc.slut() < 33 && pc.exhibitionism() < 33) addDisabledButton(1, "Anal Ride", "Anal Ride", "No way!  You're not going to do that in front of EVERYONE.");
		else addButton(1, "Anal Ride", takeUrtaInTheButtPublically);
		//addButton(2,"Lay Eggs",temp);
		if((pc.hasCock() && pc.cockThatFits(urtaCapacity()) >= 0) || pc.hasKeyItem("Deluxe Dildo") >= 0)
			addButton(3,"Spank Her",spankTheShitOutOfUrtaAndMakeHerCreamHerselfFromProstateStimulationAloneLikeTheHornyDrunkenSlutSheReallyIs);
		//if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && RaphaelLikes() && flags[kFLAGS.URTA_X_RAPHAEL_HAPPENED] == 0) {
			//output("\n\nYou know Urta and Raphael get along about as well as cats and dogs, but it might be fun to have them double-team you in the dark.");
			//addButton(8,"3SomeSurprise",urtaAndRaphaelSurprise);
		//}
		addButton(14, "Leave", barTelAdre);
		return;
	}
	
	//[URTA COMFORTABLE WITH HOR-COCK]
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11 && rand(2) == 0 ) {
		//output(images.showImage("urta-bar"), false);
		output("You approach Urta, who gives you a naughty wink and asks, \"<i>Would you like to play with my little pony?</i>\"  One of her hands is trailing along her leg, caressing her member as it hardens under her tight fishnet stockings.\n\n(You can suck her off under the table or go back to her place to fuck.)");
	}
	else {
		//output(images.showImage("urta-bar"), false);
		output("You approach Urta, who gives you a lascivious grin ");
		if(Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") < 11) output("moments before you hear her horse-cock thump into the bottom of the table.  ");
		else output("and pets her already-growing horse-cock through her fishnet stockings.  ");
		if(rand(2) == 0) {
			output("Urta asks, \"<i>I'm really horny, do you think you could help me get off?  I guess we could go fuck at my place, or you could always just help me out under the table.</i>\"  A blush colors her face through the gray fur as she suggests the latter option.");
		}
		else output("She asks, \"<i>Would you like to go back to my place and help me play with my 'little' friend again?  Or maybe you could climb under the table and give me some relief?</i>\"");
	}
	//if(pc.canOviposit()) {
		//if(flags[kFLAGS.URTA_TIMES_EGG_PREGGED] == 0) output("\n\nYou contemplate asking Urta to help you take a load off your abdomen, but decide against it; Urta's probably too shy and pent up to let you fill her with your eggs. Maybe when she's gotten herself drunk and is more pliable, though...");
		//else output("\n\nYou don't think it's likely Urta would agree to host your eggs in her present state; wait until she's turned down her inhibitions before asking.");
	//}
	//[Under Table BJ] [Public Jerkoff onto your face] [Public Buttfucking (Receiver)] [Tender lovemaking @ Urtas] [Minotaur Cum-Addict Special?] [TABLE FUCK]
	//simpleChoices("Hidden BJ",blowUrtaUnderTable,"Urta's Place",goBackToUrtasForLuvinz,"",0,"",0,"Leave",barTelAdre);
	clearMenu();
	addButton(0, "Urta's Place", goBackToUrtasForLuvinz, null, "Urta's Place", "Go to Urta's apartment for sex.");
	if (flags["COC.URTA_CUM_NO_CUM_DAYS"] >= 5) addButton(1, "Hidden BJ", slurpFawkesCocksForFunAndInflation, null, "Hidden BJ", "Suck Urta's dick until she cums! \n\nNote: Given how long she hasn't relieved, this is most likely going to fill your belly.");
	else addButton(1, "Hidden BJ", blowUrtaUnderTable, null, "Hidden BJ", "Suck Urta's dick until she cums!");
	addButton(4, "Leave", barTelAdre);
}

private function drinkUrtasBooze():void {
	urtaSprite();
	clearOutput();
	output("You grab the bottle and take an experimental swig.  WOW, this stuff is STRONG.  It goes down smooth, but leaves a blacksmith's forge burning in your belly.  Kicking back, you take a few more sips, relaxing and enjoying watching the crowds of strangers mingle, flirt, and drink.  You set the bottle down and nearly miss the table, coming dangerously close to falling over.  You eye the bottle and realize it's nearly empty.  Damn that shit was good, but you've got to piss like a racehorse now.  Standing up in a hurry, you wobble around, looking for a bathroom and failing.  A waitress recognizes your expression, and with a knowing smile points towards the back door.\n\n");
	output("You rush out to the alley...");
	//dynStats("int", -2, "lus", 30);
	processTime(15);
	pc.imbibeAlcohol(75);
	pc.lust(35);
	//to part 2!
	clearMenu();
	addButton(0, "Next", drinkUrtasBoozePtTwo);
}

//[NEXT]
private function drinkUrtasBoozePtTwo():void {
	urtaSprite();
	clearOutput();
	output("With a happy sigh you ");
	if(!pc.hasCock()) output("squat down and ");
	output("open up your [pc.gear], releasing the pressure onto a patch of grass.  ");
	output("\n\nIt takes forever to stop, but when it does you feel like a million bucks.  You turn and start to close up your kit when you realize you aren't alone.  Urta is watching you, her lips parted hungrily.  She's still peeing, but what's truly shocking is the mammoth package she's got hanging between her legs.  It's a massive horse-shaft, patterned black and pink, slung down from between a pair of apple-sized balls.  Before your eyes the equine beast begins hardening, forcing the distracted fox to empty the last of her urine against a building's wall.  She blushes furiously, but the drunken fox doesn't seem to care about her shame...\n\n");
	output("She shakes her massive horse-meat more than a few times, shuddering lightly with pleasure as her tip flares a bit in response.  Urta stumbles over moaning, \"<i>This ish all your fault!  You damned... sexy... mmm... letsh fuck!</i>\"\n\n");
	output("The stumbling hermaphrodite is openly rubbing herself as she closes in on you.  What do you do?");
	//[RUN!] [LET HER]
	processTime(4);
	clearMenu();
	addButton(0, "Run!", drinkUrtasBoozeRun);
	addButton(1, "Let Her", drinkUrtasBoozeLetHer);
}

private function drinkUrtasBoozeRun(): void{
	urtaSprite();
	clearOutput();
	output("You turn about and run, nearly smacking into the door frame in your haste to get away.  You hear a half-strangled sob behind you as the door swings closed.");
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(5);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function drinkUrtasBoozeLetHer():void {
	urtaSprite();
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 5;
	//[LET HER]
	clearOutput();
	//output(images.showImage("urta-behindbar-fuck"), false);
	output("You nod at Urta, feeling a bit relaxed from all the whiskey and more than a little intrigued by the beast between the slender fox's legs.  She's on you before you know it, her softly furred hand squeezing one of your ");
	if(pc.balls > 0) output("[pc.balls]");
	else if(pc.biggestTitSize() > 1) output("[pc.breasts]");
	else output("[pc.nipples]");
	output(", as her tongue spears between your lips.  She practically mouth-rapes you as her trembling member grinds against your " + pc.legs() + ", smearing them with a generous helping of foxy horse-pre.  The horny drunk slurs into your ear, \"<i>Gawdsh above, are you this much of a schlut for everyone with one of these?</i>\"\n\n");

	output("With surprising strength, the inebriated fox pushes you against an old bench, flat onto your ");
	if(pc.biggestTitSize() > 1) output("tits");
	else output("belly");
	output(".  She pulls at your [pc.gear] until your crotch is completely exposed and vulnerable, revealing your [pc.vagOrAss]");
	if(pc.cockTotal() > 0) output(" and [pc.eachCock]");
	output(".  Urta snuggles close, brushing her nose along your thighs before plunging her tongue deep into your [pc.vagOrAss] in one powerful, drunken lick.  She slurps and licks, humming away until you're ");
	if(pc.hasVagina()) output("wet");
	else if(pc.hasCock()) output("suitably lubricated and leaking pre");
	else  output("suitably lubricated");
	output(".\n\n");

	output("With a quick shift in position, she forces herself inside, her arms supporting her jiggling chest as she leans over you, dragging her nipples up your back.  Her fat shaft forces your body to spread wide.  The fat head and ring of prepuce strokes your inner walls, squeezing grunts of pleasure from you as the drunken fox forcefully begins fucking you, rutting like a beast.  You can feel her nipples harden, digging into your back and eliciting moans from their owner as they're repeatedly smashed against you.  Urta starts licking your neck where it joins your shoulder, gently nipping at your tender flesh as her tip begins to flare wider inside you.");
	if (pc.hasVagina()) pc.cuntChange(0, 60, true, true, false);
	else pc.buttChange(60, true);
	output("\n\n");

	output("\"<i>Mmmm I shhoulda ushed a condom, you're gonna be a messssss!</i>\" she cries as she climbs atop her sexual peak, mounting it just like she's mounting your [pc.vagOrAss].  You're spread wide, the equine member rammed tightly ");
	if(pc.hasVagina()) output("against your cervix as the tip presses firmly against it");
	else output("into your rectum");
	output(", unloading a thick batch of cream directly into your ");
	if(pc.hasVagina()) output("waiting womb");
	else output("abused asshole");
	output(".");
	
	if(pc.isPregnant()) output("  Whatever's growing inside you is probably bathing in the stuff now.");
	else if(pc.hasVagina()) output("  You briefly wonder if she's capable of knocking you up, and what the baby would look like.");
	else output("  Your backside fills with warmth as her spunk seeps deep inside you.");
	output("  Another blast fills you to capacity, and you're mortified by the sensation of your body being shifted by your growing belly.\n\n");

	output("Urta sucks on the edge of your ear, still pumping away as she pours a bit more spooge into your now equine-sized cavity.  Your alcohol-dulled mind reels as your body caves in to the sticky fluid assault, cumming hard and wriggling around her shaft, moaning repeatedly as you clamp down tightly.  ");
	if(pc.hasCock()) {
		if(pc.totalCocks() > 1) output("[pc.EachCock] squirts hard, unloading a batch of [pc.cumVisc] jism under your [pc.belly], making you squish with each brutal thrust of your oversized lover's rod.");
	}
	else {
		if(pc.hasVagina()) output("Your pussy dribbles and clenches, leaking Urta's whiteness as she claims it for her own.");
		else output("Your [pc.asshole] clamps down tightly, spasming in pleasure around the invader.");
	}
	if(pc.hasCock()) output("  As you cum, more and more whiteness dribbles out until a puddle forms underneath you, showing Urta just how much you enjoyed the rough, drunken fuck.\n\n");
	else output("\n\n");

	output("She pulls out, dripping everywhere.  The fox leans down and proceeds to give your still quivering hole a tongue-bath, thoroughly cleaning her fluids from the entrance and teasing you until you clamp down, locking the rest inside.  With a gentle slap on your [pc.ass] Urta says, \"<i>Thankss for the quick fuck.  Maybe shometime you can ");
	if(pc.cockTotal() > 0) output("stick it in me");
	else output("come back for an even bigger load");
	output(".</i>\"\n\n");
	output("The fox helps you to your feet and the two of you get dressed, stumbling a bit over each other and giggling happily.  Urta gives you a quick peck on the lips and whispers, \"<i>Thanksh... for everything,</i>\" before the two of you make your way back into the bar and go your separate ways.\n\n");
	
	processTime(25);
	pc.orgasm();
	if (pc.hasVagina()) pc.loadInCunt();
	else pc.loadInAss();
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[BACKDOOR]
private function urtaFollowedOutBack():void {
	urtaSprite();
	clearOutput();
	//output(images.showImage("urta-behindbar-masti"), false);
	output("The backdoor opens out into a narrow alley.  Surprisingly, the alleyway is covered in dirt and grass.  Awnings from the buildings above cover the alley in shadow, making it difficult to see anything out here.  You can hear quiet gasps and a wet, repetitive sound.  Quietly approaching the source of the noise, you eventually spot the dark-colored fox.  Her tail is no longer wrapped around her leg.  Instead, it's splayed out behind her and her skirt is pressed up over her legs.  Urta's totally exposed, and it's plain to see that between the fox-girl's legs there's more than a little horse.  Both her hands are wrapped tightly around the quivering column of horse-flesh, stroking the pre-cum dribbling fuck-stick relentlessly as her apple-sized balls bounce under her, occasionally revealing a feminine gash drooling with clear nectar.\n\n");
	output("Urta moans and cries, \"<i>Ooh, just go down! Please cum and go down!  Why won't you go awayyyyyy...</i>\" eventually breaking off into blubbering sobbing, interrupted by the occasional involuntary gasp of pleasure.\n\n");
	//[Sneak away] [Watch] [Masturbate With Her] [Fuck Her]
	output("(You could fuck her, masturbate with her, watch, or leave her like that.)");
	pc.lust(5 + pc.libido() / 20);
	clearMenu();
	addButton(0, "Fuck Her", urtaFuckHer);
	addButton(1, "MutualMast", dualUrtaMasturbation);
	addButton(2, "Watch", watchUrtaJerkIt);
	addButton(14, "Leave", urtaSneakAwayFromMasturbate);
}

//[Sneak Away]
private function urtaSneakAwayFromMasturbate():void {
	urtaSprite();
	clearOutput();
	output("You sneak away from the depressing sight, and decide to head back to camp.");
	pc.lust( -10);
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(5);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[Watch]
private function watchUrtaJerkIt():void {
	urtaSprite();
	clearOutput();
	//output(images.showImage("urta-behindbar-masti-solo"), false);
	output("With both hands pumping away busily, the distraught fox quickly brings her massive member up between her breasts, sandwiching the equine shaft tightly into her ample chest.  In fact, it's so big that you can clearly see she's not just able to tit-fuck herself, she's even long enough to be able to lick the end of her stiffening monster!  Crying, she takes the tip into her mouth and begins slurping and sucking, noisily trying to get her male half off.  Her efforts seem to be working, if the churning action in her balls as they tighten up to her crotch is any indicator.  Her cries and moans are muffled into frantic gasps as ribbons of white cream leak out around her muzzle, sliding down the shaft and staining her lighter gray chest-fur with drippy goop.\n\n");

	output("She pulls back, red-eyed and gasping, her seed splattering everywhere as the beast between her legs contracts and pulses rhythmically, erupting again and again to shower a few more sticky blasts over her chest and head.  Fairly dripping with spunk, Urta sighs in humiliation and leans back against the wall, too wiped out by the powerful orgasm to do anything but smile when the beast finally starts to deflate towards her swollen sheath.  She begins licking herself clean, sniffling as she attempts to remove the thick layer of goop from her body.  The fox murmurs and pats the strange dick gently, as if it was a rebellious pet rather than a part of her, \"<i>Maybe someday we'll be able to find someone besides Edryn that'll accept you... Maybe the rest of that bottle will do a better job of keeping you down.</i>\"\n\n");

	output("Urta stands up and pushes her skirt back down, though her massive equine shaft still hangs well past the bottom of it, defying all of her attempts to conceal it.  With a sigh resignation and a practiced twirl of her tail, it's bound tightly against her thigh, concealed by her plentiful tail-fur.  She walks your way, wiping the tears from the corner of her eyes and pulling a new top over her large chest.  You're forced to duck behind a trash-can when she staggers past.  After she's gone, you spot her old top – it's drenched in her cum and totally unsalvageable, and there seems to be more than a few similar garments piled in the trash-can.  This must not have been the first time she's had to duck out like that.  Poor girl.\n\n");
	output("You guess you'd better head back into the bar...");
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(15);
	clearMenu();
	addButton(0, "Next", barTelAdre);
}

//[MASTURBATE WITH HER]
private function dualUrtaMasturbation():void {
	urtaSprite();
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 5;

	clearOutput();
	//output(images.showImage("urta-behindbar-masti-dual"), false);
	output("You come out of the shadows, shedding your [pc.gear].  ");
	if(pc.exhibitionism() < 50 && pc.slut() < 50) output("You blush furiously at exposing yourself in such a way");
	else output("Smiling seductively, you revel in exposing yourself so suddenly");
	output(".  Urta looks up at you in shock, blinking tears from her eyes and stammering, \"<i>B-b-b-ut I have th-thish hideoush thing... Aren't you scared of it?</i>\"\n\n");

	output("Gently wiping a tear from her muzzle, you comfort the distraught fox and sit down across from her, giving her a perfect view of your [pc.crotch].  ");
	
	if(pc.hasCock()) {
		output("The situation gives you all the spark you need to rise to your full size, ");
		if(pc.longestCockLength() < 12) output("even if Urta's member dwarfs you.");
		else if(pc.longestCockLength() < 18) output("showing Urta you're just as big.");
		else output("proving to Urta just who has the bigger burden.");
		output("  ");
	}
	
	if(pc.hasVagina()) {
		if(pc.vaginas[0].wetness() >= 4) output("A trickle of wetness escapes your nether-lips, starting to puddle underneath you.");
		else output("Quickly engorging, your lower lips begin to part around your [pc.clit].");
		output("  ");
	}
	
	output("The heat coursing through you quickly shows itself on your [pc.fullChest] as your [pc.nipples] become full and sensitive.\n\n");

	output("Urta relaxes, leaning against a wall as she returns to pleasuring her mismatched member.  Her eyes lock onto your groin as you join her, and she lets out a sigh that's equal parts relieved and inebriated.  Together, the two of you pleasure your bodies, each watching the other's squirming form and blissful expression.  ");
	if(pc.totalCocks() == 1) output("Your hands caress your [pc.cock] feverishly, tweaking every ounce of pleasure from the bloated rod.  ");
	if(pc.totalCocks() > 1) output("Your hands caress your [pc.cocks] in turn, dancing back and forth from rod to rod as you attempt to play with every available pleasure outlet.  ");
	if(pc.hasVagina()) output("Delving deeply between your thighs, you press forward into the source of your feminine pleasures, touching and rubbing, caressing your swollen button as you get closer and closer to orgasm.\n\n");
	if(!pc.hasGenitals()) output("Delving down between your thighs, rubbing along your taint before you slowly penetrate your [pc.asshole], pleasuring yourself in the only way possible.\n\n");

	output("The cute fox-girl reaches her peak, crying out in a loud moan that echoes around the alley.  Her equine shaft trembles, the medial ring becoming more pronounced while the flat head flares wide mid-orgasm.  A blast of cum launches into the air, fans out overhead, and splatters down over you.  Urta looks horrified, and yanks herself back, succeeding only in depositing the next blast of spoogey goodness into her own face.  The situation would be comical if the foxy horse-goo wasn't such a great lubricant for your hands, and with that thought in your mind, you cum too.\n\n");

	if(pc.hasCock()) {
		if(pc.cumQ() < 250) {
			output("Jism spurts out onto the alley floor, forming a nice little puddle as ");
			if(pc.totalCocks() > 1) output("each of ");
			output("your [pc.cocksLight] empties itself.  ");
		}
		else if(pc.cumQ() < 500) output("Jism pours out onto the alley floor as your body releases the copious amount of [pc.cum] it can produce.  It puddles before you, running off the stone into the grass.  ");
		else if(pc.cumQ() < 1000) {
			output("Jism erupts from ");
			if(pc.totalCocks() > 1) output("each of ");
			output("your [pc.cocksLight], blasting into the air before splattering onto the ground between you and Urta.  It forms a massive puddle, spreading as you pump gob after gob of [pc.cum] into it until the [pc.cumVisc] spooge is soaking your " + pc.legs() + " and Urta too.");
		}
		else {
			output("Jism fountains from ");
			if(pc.totalCocks() > 1) output("each of ");
			output("your [pc.cocksLight], flooding the small alleyway with an unholy amount of [pc.cum].  In no time you've painted Urta and yourself from head to toe, and the alleyway sloshes with the stuff as your production overwhelms the ground's ability to absorb liquid.  ");
		}
	}
	
	if(pc.hasVagina()) {
		output("Your sex squishes wetly around a finger, clenching down tightly");
		if(pc.isSquirter()) output(" and gushing everywhere");
		output(".  ");
	}
	else output("Your sphincter clenches down tightly around your invading digit as you get off, and the rapt attention of your audience certainly helps.  ");
	
	output("Sighing happily, you give your nipple a tweak as Urta finally finishes cumming, ");
	if(pc.cumQ() >= 1000) output("adding to the massive pool on the ground after ");
	output("drenching herself thoroughly.\n\n");

	output("Urta lets out a VERY relieved-sounding sigh and murmurs, \"<i>Oh godsh, thank you.  You don't know how hard it ish to hide thish beasht from EVERYONE.  You're a good friend for helping me with thish... let'sh do thish again sometime, ok?</i>\"\n\n");
	output("She staggers up to her feet and rapidly discards her sodden clothes.  With a resigned sigh, Urta pulls a loose stone out of the side of a building and removes a sheer skirt and diaphanous top from the cubby.  They slip on easily, though the new clothes look a bit more 'slutty' than her previous pair, easily displaying her hard black nipples.  Urta replaces the stone, wobbling a bit unsteadily before she ");
	if(pc.cumQ() >= 1000) output("tip-toes through the spunk");
	else output("gets her balance and heads for the bar's backdoor");
	output(".  Her tail curls up around the softening horse-cock, hiding it from view as she blows you a sloppy kiss and disappears inside.\n\n");

	output("You waste no time cleaning up and stagger back inside after her, sated and happy with your new friend and her 'benefits'.");
	processTime(15);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", barTelAdre);
}

//[FUCK HER]
public function urtaFuckHer(afterBefriending:Boolean = false):void {
	urtaSprite();
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	IncrementFlag("COC.TIMES_FUCKED_URTA");
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp + 60 * 5;
	var cocks:Number = pc.cockTotal();
	if (!afterBefriending) clearOutput();
	
	//(FUCK HER FEMALE/GENDERLESS)
	if (!pc.hasCock()) {
		//output(images.showImage("urta-behindbar-female-fuckurta"), false);
		//pc.slimeFeed();
		output("You come out of the shadows, shedding your [pc.gear].  ");
		if (pc.exhibitionism() < 50 && pc.slut() < 50) output("You blush furiously at exposing yourself in such a way");
		else output("Smiling seductively; you revel in exposing yourself so suddenly");
		output(".  Urta looks up at you in shock, blinking tears from her eyes and stammering, \"<i>B-b-b-ut I have th-thish hideoush thing... Aren't you scared of it?</i>\"\n\n");

		output("Gently wiping a tear from her muzzle, you answer, \"<i>Not at all, but I think you'd have more luck with a nice warm hole to slide that monster into.</i>\"\n\n");

		output("Urta nods, numbed by the unexpected and forward nature of your offer.  She looks up hopefully and pries her hands away from the twitching behemoth in her loins, waiting to see how you intend to deal with it.  You approach her and turn, straddling your " + pc.legs() + " over her, watching her expression as you lower yourself down, ");
		if(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("swishing [pc.oneTail] across her taut nipples");
		else output("making her wait");
		output(".  Eventually the blunted tip of Urta's horse-cock presses against your [pc.vagOrAss].  Agonizingly, you force yourself to relax and lower yourself down on the mottled pink and black shaft.\n\n");

		output("The horse-cock spreads you wide, filling you past the point of fullness as you sink further and further along its length.  Urta groans happily, her hips twitching involuntarily and forcing more of the monster-sized cock inside you.");
		if(pc.hasVagina()) {
			if(pc.vaginalCapacity() >= urta.cockVolume()) {
				output("  You sigh and sink down, taking it until the folds of her sheath are rubbing your entrance.");
			}
			else {
				output("  You nearly cry out as you sink down, taking it until the folds of her sheath are rubbing your entrance, even though it hurts to accommodate it.");
			}
			pc.cuntChange(0, urta.cockVolume(), true, true, false);
		}
		else {
			if(pc.analCapacity() >= urta.cockVolume()) {
				output("  You sigh and sink down, taking it until the folds of her sheath are rubbing your entrance.");
			}
			else {
				output("  You nearly cry out as you sink down, taking it until the folds of her sheath are rubbing your entrance, even though it hurts to accommodate it.");
			}
			pc.buttChange(urta.cockVolume(), true, true, false);
		}
		output("  Urta babbles, \"<i>Oh godsh yesh thank you so much-ohmigod it's SO HOT inside you.</i>\"\n\n");

		output("You smirk over your shoulder and start bouncing up and down on her, slapping her balls with your [pc.ass] each time you bottom out on the thick shaft.  You can feel her ring of prepuce rubbing your inner walls, pressing on nerves normally ignored.  Urta grunts underneath you and you feel her flare growing wider inside you, stretching you further and further with every bounce atop the equine-endowed slut.  Suddenly warmth is flooding into your ");
		if(pc.hasVagina()) output("womb");
		else output("rectum");
		output(", and Urta's tongue is lolling out from her muzzle, drooling down the side of her face as she loses herself in orgasm.\n\n");
		
		if (pc.hasVagina()) pc.loadInCunt(urta);
		else pc.loadInAss(urta);
		
		output("The substantial flare forms a perfect plug inside you and your belly distends slightly as you're packed full of foxy-horse-cum.  Your own lusts keep your hips moving, grinding and squeezing the shaft inside you as it packs you full of Urta's seed.  Your orgasm explodes through your hips and your " + pc.legs() + " give out underneath you, dropping you down onto the fox-girl as the pair of you cum together.  Whiteness begins squirting out around her shaft as her prick begins softening inside you.  You sigh happily, content but too nerveless to stand for the moment.  Peeking over your shoulder and seeing Urta's satisfied expression, you guess she feels about the same.\n\n");

		output("Once the horse-dick inside you has sufficiently softened, you stand up, gasping as a rush of spooge escapes from your [pc.vagOrAss] now that the 'plug' is removed.  Urta gives you a cocky grin as she's soaked with her fluids, moments before she starts staggering back to her feet.  She wipes up with her clothes and tosses them into the garbage, then wobbles up to a loose brick in the wall and pulls it free, revealing a hidden compartment filled with sets of replacement clothes.  She removes a tight skirt and sheer top, both a bit more revealing than what she wore in the bar earlier, and hurriedly dresses herself.\n\n");

		output("Urta blows you a kiss as you put your own gear back together and flounces back to the bar, calling out, \"<i>We should do thish again shoon!</i>\"\n\n");

		output("\"<i>Yes indeed,</i>\" you muse - the sooner the better.");
	}
	else {
		var x:Number = pc.cockThatFits(urta.vaginalCapacity());
		var y:Number = pc.cockThatFits2(urta.analCapacity());
		if (x < 0) x = 0;
		//output(images.showImage("urta-behindbar-male-fuckurta"), false);
		output("You come out of the shadows, shedding your [pc.gear].  ");
		if (pc.exhibitionism() < 50 && pc.slut() < 50) output("You blush furiously at exposing yourself in such a way");
		else output("Smiling seductively; you revel in exposing yourself so suddenly");
		output(".  Urta looks up at you in shock, blinking tears from her eyes and stammering, \"<i>B-b-b-ut I have th-thish hideoush thing... Aren't you scared of it?</i>\"\n\n");

		output("Gently wiping a tear from her muzzle, you answer, \"<i>Not at all, but I think you'd have more luck with something stuffed in your feminine half.</i>\"\n\n");

		output("Urta gives you a shocked look, but nods and turns around, bending over an old bench and exposing her well-toned ass and glistening, black-lipped sex.  The invitation is all you need.  You wrap your arms around her, squeezing the downy-soft fur on her breasts and leveraging ");
		
		if(pc.cockTotal() > 2) output("a pair of [pc.eachCock] against her pussy and asshole.  ");
		else if(pc.cockTotal() == 2) output("[pc.eachCock] against her pussy and asshole.  ");
		else if(pc.cockTotal() == 1) output("your [pc.cock] against her pussy.  ");
		
		//DOES IT FITZ
		if(pc.cockVolume(x) < urta.vaginalCapacity()) {
			output("The wet entrance yields before you, accepting you like a velvet glove.  It grips you tightly, though the grip is meaningless with the flood of lubricant slipping over your shaft.  ");
			if(y != -1) output("Her backdoor was rougher going – the tightly muscled entrance held you back for a moment until Urta relaxed completely, but now the tighter hole is nearly as easy to penetrate as her pussy.  ");
			output("The fox is openly moaning and stroking her disproportional cock, dripping pre-cum everywhere as you do your level best to violate her ");
			if(y == -1) output("hole");
			else output("holes");
			output(".\n\n");

			output("She begins grinding against you, begging, \"<i>Oh godsh yeeeessss don't shtop fucking me!  Give me more please!  PLEASE!</i>\"\n\n");

			output("Nodding, you release one of her bouncing breasts in order to smack her back-side.  It barely jiggles, but the surprised moan that slips from the fox-herm's lips is all the encouragement you need.  You release the other breast and grab her hips and ass with both hands, slamming her back against you, only pausing to deliver another smack to one of her cheeks.  Urta wiggles happily, squealing after every slap, trying her best to steady her body while you brutally ");
			if(y == -1) output("fuck");
			else output("double-penetrate");
			output(" her.\n\n");

			output("\"<i>Yesh oh yessssssSSSAHHHCUMMING,</i>\" cries Urta as her body goes nerveless underneath you, held up entirely by your hands");

			if(cocks > 1 && y >= 0) output(" and [pc.cocks].");
			else output(" and [pc.cockNoun " + x + "].");
			output("  Both her hands are locked tightly around her behemoth as it unloads onto the alley floor and walls.  The juicy tunnel clamps down on top of you, squeezing your [pc.cockNoun " + x + "] as if Urta's life depended on it.  It's as if every ounce of her being was focusing on clamping down on the invader, massaging, squeezing, and milking it, while the rest of her body goes entirely limp.");
			if(cocks > 1 && y >= 0) output("  Your [pc.cockNoun " + y + "] feels like it's about to explode inside her asshole when her sphincter clamps down tightly, acting like the world's tightest cock-ring.");
			output("\n\n");

			output("You fuck her savagely, abusing her spasming hole");
			if(cocks > 1 && y >= 0) output("s");
			output(" with every thrust until your own climax bursts over you like a wave.  Urta's drooling cunt ");
			if(cocks > 1 && y >= 0) output("and tightly clenched ass seem");
			else output("seems");
			output(" to be trying to milk your body of every ounce of [pc.cumNoun].  ");

			if(pc.cumQ() < 250) {
				output("After a few passionate thrusts, you're spent, and you pull free, admiring the [pc.cumColor] glaze that remains on her cunt-lips");
				if(cocks > 1 && y >= 0) output(" and slowly-closing pucker");
				output(".");
			}
			else if(pc.cumQ() < 500){
				output("After a few passionate thrusts, you can feel your [pc.cumNoun] packing Urta's womb ");
				if(cocks > 1 && y >= 0) output("and gut ");
				output("full of spooge, but all great things come to an end eventually.  You pull free, admiring the [pc.cumColor] glaze that remains on her cunt-lips");
				if(cocks > 1 && y >= 0) output(" and slowly-closing pucker");
				output(".");
			}
			else {
				output("After a few passionate thrusts, Urta's womb ");
				if(cocks > 1 && y >= 0) output("and belly are ");
				else output("is ");
				output("so full of spooge that she looks positively pregnant, and you're expelled from her body by the sheer force of your orgasm.  You pause to admire your handiwork, watching [pc.cum] drip from ");
				if(cocks > 1 && y >= 0) output("both her holes.");
				else output("her abused hole.");
			}

			output("\n\nUrta moans, \"<i>Mmmm... letsh do this again shometime.  Please, you've no idea how hard thish thing is for me,</i>\" as she rubs the mixed fluids against her sensitive nether-lips and staggers around.  She tears off her sodden skirt, tossing it into the rubbish.  With a resigned sigh, Urta pulls a loose stone from the side of a building and removes a sheer skirt and top from the cubby.  They slip on easily, though the new clothes look a bit more 'slutty' than her previous pair, easily displaying her hard, black nipples.  Urta replaces the rock, wobbling a bit unsteadily before she ");
			if(pc.cumQ() > 1000) output("tip-toes through the spunk");
			else output("gets her balance and heads for the bar's backdoor");
			output(".  Her tail curls up around the softening horse-cock, hiding it from view as she blows you a sloppy kiss and disappears inside.\n\n");

			output("You waste no time cleaning up and you stagger back inside after her, sated and happy with your new friend and her 'benefits'.");
			knockUpUrtaChance();
		}
		//(TOO BIG)
		else {
			if(cocks == 1) {
				output("Urta's hole is just way too small to handle what you're packing, so you're forced to back off, much to her lament.  She moans, \"<i>Noooo! Fuck me!</i>\"\n\n");
				output("You pull her down into the grass and throw her on her back.  She looks confused and a little afraid, but that melts away when you");
				if (pc.isBiped()) output(" spread your [pc.legs] across her and");
				output(" begin grinding your [pc.cocksLight] against her sensitive dick.  Happy, the drunken fox begins pistoning against you, gathering her copious pre and smearing it over [pc.eachCock].  The two of you grind together, groin to groin, coating each other in a slippery mess.\n\n");
				output("Urta pants out, \"<i>Ah ahhh ahhhh,</i>\" and cums, her flare ballooning out until it's twice as wide as her shaft, a wave of white jism escaping from her horse-cock.  You gather some in your hand and slather it over your own [pc.cocks], and after a few moments of fevered masturbation, you start cumming with her.  Urta happily squirms against you, painting herself with jism and soaking her clothes with the stuff.  ");

				if(pc.cumQ() < 250) output("You join in, though your own contribution seems meager by comparison.");
				else if(pc.cumQ() < 500) output("You join in, and manage to match her spurt for spurt, until she's lying in a thick puddle of the stuff.");
				else  output("You join in, and make her orgasm look like a trickle compared to the flood of spunk you unleash onto her.  By the time the pair of you finish, she's soaked from head to toe, and lying in a nicely sized puddle of the stuff.");

				output("\n\nThe drunken fox groans and continues spurting weakly, \"<i>Oh godsh, letsh do this again sooon.  You don't know how much I needed thish!</i>\"\n\n");
				output("After a few moments she picks herself up and wipes herself up as much as she can with her sodden clothes.  Urta quickly gives up and removes a loose brick from the wall, revealing a hidden compartment with clothes and a few towels.  It seems she's quite prepared to make a mess in this alley.  She towels the worst of it off and gets dressed in a sheer tank-top and tight skirt before staggering back towards the bar.  Urta pauses and looks over her shoulder to blow you a sloppy kiss before she goes inside.\n\n");

				output("You waste no time cleaning up and mosey back inside after her, sated and happy with your new friend and her 'benefits'.");
			}
			if(cocks > 1) {
				output("Urta's holes are just way too small to handle what you're packing, so you're forced to back off, much to her lament.  She moans, \"<i>Noooo! Fuck me!</i>\"\n\n");

				output("You pull her down into the grass and throw her on her back.  She looks confused and a little afraid, but that melts away when you");
				if (pc.isBiped()) output(" spread your [pc.legs] across her and");
				output(" begin grinding [pc.eachCock] against her sensitive dick.  Happy, the drunken fox begins pistoning against you, gathering her copious pre and smearing it over your [pc.cocksLight].  The two of you grind together, groin to groin, coating each other in a slippery mess.\n\n");

				output("Urta pants out, \"<i>Ah ahhh ahhhh,</i>\" and cums, her flare ballooning out until it's twice as wide as her shaft, a wave of white jism escaping from her horse-cock.  You gather some in your hand and slather it over your own [pc.cocksLight], and after a few moments of fevered masturbation, you start cumming with her.  Urta happily squirms against you, painting herself with jism and soaking her clothes with the stuff.  ");
				if(pc.cumQ() < 250) output("You join in, though your own contribution seems meager by comparison.");
				else if(pc.cumQ() < 500) output("You join in, and manage to match her spurt for spurt, until she's lying in a thick puddle of the stuff.");
				else output("You join in, and make her orgasm look like a trickle compared to the flood of spunk you unleash onto her.  By the time the pair of you finish, she's soaked from head to toe, and lying in a nicely sized puddle of the stuff.");

				output("The drunken fox groans and continues spurting weakly, \"<i>Oh godsh, letsh do this again sooon.  You don't know how much I needed thish!</i>\"\n\n");
				output("After a few moments she picks herself up and wipes herself up as much as she can with her sodden clothes.  Urta quickly gives up and removes a loose brick from the wall, revealing a hidden compartment with clothes and a few towels.  It seems she's quite prepared to make a mess in this alley.  She towels the worst of it off and gets dressed in a sheer tank-top and tight skirt before staggering back towards the bar.  Urta pauses and looks over her shoulder to blow you a sloppy kiss before she goes inside.\n\n");

				output("You waste no time cleaning up and mosey back inside after her, sated and happy with your new friend and her 'benefits'.");
			}
		}
	}
	processTime(45);
	pc.orgasm();
	clearMenu();
	//doNext(afterBefriending ? camp.returnToCampUseFourHours : returnToCampUseOneHour);
	addButton(0, "Next", barTelAdre);
}

//This is intended to be a \"<i>tree</i>\" style conversation scene that replaces the default dialogue scene for Urta//
//The option to go through these dialogue trees is played whenever the PC approaches Urta and she is not horny//
//These scenes all use 1 hour and return the PC to the main Tel'adre menu screen when finished//
//Approaching Urta:
//(Regular Urta)
private function QBsTalkExpack():void {
	clearOutput();
	urtaSprite();
	//(Lover Urta)
	if(urtaLove()) output("When you approach Urta, she smiles to see you.  However, there is no rapid swivelling in her seat to avoid banging her horse-cock against the table; evidently she's not in the mood for some sex right now.  You sit down beside her, and she happily loops her arm around you, planting a tender kiss on your lips, before almost apologetically stating, \"<i>Hey there, lover.  Want to talk for a change?</i>\" with a twinkle of good-natured mirth in her eyes.");
	else output("When you approach Urta, you are almost surprised at the lack of an audible 'thump'.  Seeing your confusion, the herm fox quips, \"<i>What's with the look?</i>\" while raising an eyebrow.  When you indicate that you had expected to hear her demonstrating her excitement to see you, she blushes and looks embarrassed.  \"<i>Well... you do a pretty good job of letting my little pony blow off some steam, ya know, [pc.name]?</i>\"");
	//[Urta] [Edryn] [The Watch] [Back]
	urtaDialogueMenu();
}

private function friendsTalkExpack():void {
	clearOutput();
	urtaSprite();
	output("You approack Urta's table and she motions for you to take a seat.  She finishes writing something on one of the pieces of paperwork scattered over the table, takes a sip of her drink and leans back in her chair.  “<i>Nice to see you again [pc.name].  What can I do for you?</i>”");
	urtaDialogueMenu();
}

public function urtaDialogueMenu():void {
	//choices("Urta",urtaDiscussesSelf,"Edryn",urtaDiscussesEdryn,"The Watch",urtaDiscussesTheWatch,"Alcoholism",urtaDiscussesAlcholism,"",0);
	clearMenu();
	addButton(0, "Urta", urtaDiscussesSelf);
	addButton(1, "Edryn", urtaDiscussesEdryn);
	addButton(2, "The Watch", urtaDiscussesTheWatch);
	if (!urtaJustFriends()) addButton(3, "Alcoholism", urtaDiscussesAlcholism);
	//if (flags["COC.KATHERINE_UNLOCKED"] >= 4) addButton(5, "Katherine", urtaDiscussessKatherine);
	//if(urtaPregs.urtaKids() > 0 && pc.hasKeyItem("Spare Key to Urta's House") < 0)
	//addButton(4,"Visit Kids",urtaPregs.visitKidsFirstTime);
	//else
	//if(flags[kFLAGS.FIRST_TIME_AT_URTA_HOUSE] > 0) addButton(4,"Her House",urtaPregs.talkToUrtaAboutHerHouse);
	addButton(14, "Leave", barTelAdre);
}

//[=Urta=]
private function urtaDiscussesSelf():void {
	clearOutput();
	urtaSprite();
	output("You tell Urta you'd like to talk about her a little.");
	if (!urtaLove())
	output("“<i>You wanna talk about me?</i>” she asks" + (urtaJustFriends() ? "" : ", blushing softly") + ".  “<i>Well, there isn't THAT much to tell, but what do you want to know?</i>”   She seems surprisingly pleased to have the chance to talk.");
	else output("“<i>Well, I don't think there's that much to tell,</i>” she says with a smile.  She idly blows a bang out of her face and exhales, “<i>Well, lover, I'm an open book for you, what do you want to know?</i>”");
	//[Family] [Sex/Romance] [Employment] [Prejudice]
	processTime(1);
	clearMenu();
	if (urtaJustFriends()) {
		addButton(0, "Flirt", flirtWithUrta);
		addButton(1, "Employment", urtaDiscussesEmployment);
		addButton(2, "Prejudice", urtaDiscussesPrejudice);
		addButton(14, "Back", urtaDialogueMenu);
	}
	else if (flags["COC.URTA_QUEST_STATUS"] == .5) {
		//addButton(0, "Infertility", kGAMECLASS.urtaQuest.infertilityQuestions);
		addButton(1, "Romance&Sex", urtaDiscussesSexAndRomance);
		addButton(2, "Employment", urtaDiscussesEmployment);
		addButton(3, "Prejudice", urtaDiscussesPrejudice);
		addButton(14, "Back", urtaDialogueMenu);
	}
	else if (flags["COC.URTA_QUEST_STATUS"] == 1) {
		addButton(0, "Fertility", urtaFertilityDiscussion);
		addButton(1, "Romance&Sex", urtaDiscussesSexAndRomance);
		addButton(2, "Employment", urtaDiscussesEmployment);
		addButton(3, "Prejudice", urtaDiscussesPrejudice);
	}
	else {
		addButton(0, "Family", urtaDiscussesFamily);
		addButton(1, "Romance&Sex", urtaDiscussesSexAndRomance);
		addButton(2, "Employment", urtaDiscussesEmployment);
		addButton(3, "Prejudice", urtaDiscussesPrejudice);
	}
	
	addButton(14, "Back", urtaDialogueMenu);
}

public function flirtWithUrta():void {
	clearOutput();
	if (flags["COC.URTA_PC_LOVE_COUNTER"] == -1) { //In friends mode
		output("You ask Urta if, living in Tel'Adre, it's easier to resist the powerful feelings that come from living in this world.\n\n");
		output("“<i>I've lived here my whole life, so I don't have anything else to compare with.  What do you mean by 'feelings'?</i>”\n\n");
		output("You tell her that in your world you never felt a deep urge to strip off all your clothes and " + (pc.cor() < 75 ? "make sweet love to" : "slake your lust on") + " the nearest person.\n\n");
	}
	else {
		output("You tell her that you don’t have any problem with herms, in fact you find some of them quite attractive.\n\n");
		output("Urta gulps down a bit more of her booze and you decide to have a little fun.  ");
	}
	output("You quietly slide your [pc.foot] across under the table and rub it against the inside of her leg.  Urta practically jumps out of her seat, then tries to pretend nothing happened.\n\n");
	output("You’re pretty sure most of the bar noticed, but you don’t care.  You keep rubbing and feel a thump as something large smacks against the underside of the table.  Urta drains the last of her drink and whispers, “<i>" + (flags["COC.URTA_PC_LOVE_COUNTER"] == -1 ? "What about Kath?  I... I wouldn't..." : "Please - it’s so hard...") + "</i>”\n\n");
	output("You never find out exactly what she was going to say.  When you start to rub your [pc.foot] in little circles against the root of her huge cock Urta loses her train of thought and just leans back in her chair, trying to keep from spraying her pent up cum across the floor.\n\n");
	output("You ease up so she has a chance of understanding what you’re saying.  “<i>" + (flags["COC.URTA_PC_LOVE_COUNTER"] == -1 ? "I'll explain everything to Kath.  You want this as much as I do, right?" : "Yes, some chicks, with their big dicks, just do it for me.") + "</i>”  You slide [pc.toes] a little lower and start moving it in little circles against her balls.\n\n");
	output("Before Urta pops you get up from the table and tell her to meet you out back, right where things went off the rails that first time.  Urta nods eagerly and the edge of the table rises slightly.\n\n");
	output("You wait outside, hiding in a shadowy corner.  You got Urta so excited that it’s a good fifteen minutes before she throws open the back door of the bar.  She looks hungry, yet unsure.  You’re guessing she’s had such terrible experiences with people in the past that despite your obvious interest she still can’t believe you want her.\n\n");
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = 0; //urtaFuckHer will raise it to 1
	flags["COC.URTA_PC_LOVE_COUNTER"] = undefined; //Reset both flags to put Urta back to her 'never met you before' state, ready for her first fuck
	urtaFuckHer(true); //Call urtaFuckHer() to put you on track for much Urta loving
}

private function urtaFertilityDiscussion():void {
	clearOutput();
	output("Urta traces a finger around the corner of her drink, \"<i>So, what do you think, [pc.name]?");
	if(flags["COC.URTA_FERTILE"] == 1) output("  Should I stay fertile?");
	else output("  How about I cut loose and go fertile?  Can you imagine me with a nice, round pregnant belly and a cock virile enough to get you pregnant just from looking at it?");
	if(flags["COC.URTA_PREG_EVERYBODY"] == 1) output("  Or did you come to ask me not to be fertile and virile around anyone else?");
	else {
	output("  Would you mind me being able to put a bun in Edryn's oven?  Imagine all the lil foxtaurs running around!");
	if(flags["COC.EDRYN_NUMBER_OF_KIDS"] > 0) output("  After all, you already had a turn!  Fair's fair!");
	}
	output("</i>\"  She winks at you before blowing you a playful raspberry.\n");
	processTime(1);
	clearMenu();
	if(flags["COC.URTA_FERTILE"] == 1) {
	output("\n<b>Urta is currently fertile.</b>");
	addButton(0, "No Fertile", urtaFertilityToggle);
	}
	else {
	output("\n<b>Urta can not currently get pregnant (or inseminate anyone, let alone you).</b>");
	addButton(0, "Go Fertile", urtaFertilityToggle);
	}
	if(flags["COC.URTA_PREG_EVERYBODY"] == 1) {
	output("\n<b>Urta thinks you're okay with her 'sharing the love (and kids)' with any other sexual partners she might have.</b>");
	addButton(1, "No Preg", urtaPregOthersToggle);
	}
	else {
	output("\n<b>Urta will not knock up or be knocked up by anyone else unless you tell her otherwise.</b>");
	addButton(2, "Share Preg", urtaPregOthersToggle);
	}
	output("\n\n<b>(Note: There is no content for Urta to impregnate or be impregnated by other NPCs, yet.)</b>");
	addButton(4, "Back", urtaDialogueMenu);
}

private function urtaFertilityToggle():void {
	clearOutput();
	if(flags["COC.URTA_FERTILE"] == 1) {
		output("\"<i>Well, I guess that's okay.  But you better make it worth my while later, okay?</i>\" Urta says with a half-hidden sigh.");
		flags["COC.URTA_FERTILE"] = 0;
	}
	else {
		output("Urta throws her hands up and cheers, \"<i>Yesss!</i>\"  Realizing that everyone is looking over at the two of you now, she gives a sheepish smirk and glances back at you.  \"<i>I can't wait!</i>\"");
		flags["COC.URTA_FERTILE"] = 1;
	}
	processTime(1);
	clearMenu();
	addButton(0, "Back", urtaFertilityDiscussion);
}

private function urtaPregOthersToggle():void {
	clearOutput();
	if(flags["COC.URTA_PREG_EVERYBODY"] == 1) {
		output("\"<i>Awww, are you sure?  Wouldn't you like ");
		if(pc.hasCock())
			output("to help me make Edryn's belly bloat with our seed, and then play 'Guess Who Is The Father'?");
		else
			if(pc.hasVagina())
				output("to have me get the both of you pregnant at the same time, so we can all enjoy it together?");
			else
				output("see me put this thing to work in the way that it's meant to?");
		output("</i>\" Urta says, giving you a playful pinch.");
		flags["COC.URTA_PREG_EVERYBODY"] = 0;
	}
	else {
		output("Urta smiles salaciously, like a cat that got the cream.  Then, without warning, she kisses you square on the lips, passionately frenching you.  After nearly a full minute of frenzied kissing, she says, \"<i>This is gonna be fun!</i>\"");
		flags["COC.URTA_PREG_EVERYBODY"] = 1;
	}
	processTime(1);
	clearMenu();
	addButton(0, "Back", urtaFertilityDiscussion);
}

//[=Edryn=]
private function urtaDiscussesEdryn():void {
	clearOutput();
	urtaSprite();
	output("You think for a moment, then tell her that you have questions about Edryn.");
	if (!urtaLove())
	output("\n\nUrta glances at you, eyes growing a little dark.  \"<i>Sure, I guess I can tell you some things, but you really should just ask her,</i>\" she says" + (urtaJustFriends() ? "." : ", sounding... well, you think she sounds a little jealous."));
	else
	output("\n\n\"<i>I don't need to worry about her stealing you away from me, do I, lover?</i>\" the gray fox teases.  She smirks knowingly and continues, \"<i>I'm joking, though she is a hottie, isn't she?  What do you want to know?</i>\"");
	//[History Together] [Working Together] [Romance?]
	processTime(1);
	clearMenu();
	addButton(0, "History", urtaDiscussesEdrynHistory);
	addButton(1, "Working", urtaDiscussesWorkingWithEdryn);
	if (!urtaJustFriends()) addButton(2, "Romance", urtaDiscussesEdrynRomance);
	addButton(14, "Back", urtaDialogueMenu);
}

//[=The Watch=]
private function urtaDiscussesTheWatch():void {
	clearOutput();
	urtaSprite();
	output("You tell Urta that you have a few questions about the Tel'Adre city watch.");
	if(!urtaLove()) output("\n\nUrta perks up at that, her spine stiffening with obvious pride as she takes a hearty swig of her drink.  \"<i>What do you want to know?</i>\" she asks happily.");
	else output("\n\nUrta stiffens proudly, unintentionally thrusting her chest forward before realizing the show she's making of her own cleavage.  She colors and asks, \"<i>What do ya wanna know?</i>\"");
	//[Membership] [Role in the city] [Crime & Punishment] [Reach of the Watch] [Interesting Cases]
	processTime(1);
	clearMenu();
	addButton(0, "Membership", urtaDiscussesWatchMembership);
	addButton(1, "Role", urtaDiscussesWatchRole);
	addButton(2, "Crime", urtaDiscussesCrimeAndPunishment);
	addButton(3, "Reach", urtaDiscussesTheWatchsReach);
	addButton(14, "Back", urtaDialogueMenu);
}

//[=Alcoholism=]
//To get this scene, the player must have spoken to Urta at 13 or 14 hours at least once; agreeing to the sex is not necessary//
//This dialogue can only be had once//
private function urtaDiscussesAlcholism():void {
	clearOutput();
	urtaSprite();
	if(Flag("COC.DISCUSSED_URTA_ALCOHOLISM") == 0 && Flag("COC.UNKNOWN_FLAG_NUMBER_00145") == 0) {
		output("You quietly inform Urta that you and she need to talk about her drinking habit.  She swallows nervously and insists, \"<i>I - I only drink to try and keep my cock under control.</i>\"");
		output("\n\nYou point out that her actions clearly belie that statement - she would never ask you to jerk her off in public or let her fuck your ass in the middle of the bar when sober.  Urta flinches at your words, ");
		if(pc.cor() < 33 && pc.isNice())
			output("and you feel a little bad for putting her through this");
		else
			if(pc.cor() < 66)
				output("and you would feel bad if this talk weren't necessary");
			else
				output("but you don't let up for a moment");
		output(".  You insist that you aren't upset with her, that you're not blaming her for anything, but you need to talk to her about this matter.");
		output("\n\nUrta refuses to meet your eye for several long minutes.  Nervously, she begins tapping one clawed finger on the table.  \"<i>I... okay.  The truth is that I did start drinking originally in the hopes it would make my erections subside and make me harder to arouse.  As you've seen, it doesn't work like that - truth be told, I'm kind of a horny drunk.</i>\"");
		output("\n\nYou ask why, then, she does it - why does she keep drinking?");
		output("\n\n\"<i>Because it's an excuse for me to cut loose, alright?</i>\" she barks indignantly.  Now she meets your eyes, staring into them with defiance.  \"<i>I work day in and day out to keep this city from falling apart, and the whole time, I have to deal with this... this thing between my legs, undermining everything I say.  ");
		if(urtaLove())
			output("Lover");
		else
			output("Cutey");
		output(", you don't know what I've been through.  In here, when I'm off the clock, I can just have a bottle, hang out with my friends, and kind of... just... bask in everyone else's happiness.  It's not much, but it's better than sitting at home, bored and lonely.</i>\"");
		output("\n\nShe finally ceases her rambling dialogue and sighs loudly, shaking her head.  \"<i>Maybe it was a bad idea, but it was my idea, you know?</i>\"  Then, she looks up at you, gently.  \"<i>Besides, I got to meet you, didn't I?  Even with all the bad, I gained you for a ");
		if(!urtaLove())
			output("friend.</i>\"");
		else
			output("lover.  I don't think I've ever had anyone accept me like you have - even Edryn kind of holds back from me.  You... you're different.  Maybe it's because you're an off-worlder, I don't know, but meeting you has been the best thing to happen to me since I joined the guard.  Honestly... I feel like I could probably stop - I don't really need it anymore, though I do seem to wind up having a lot of fun when I do.</i>\"");
		output("\n\nUrta falls silent, waiting for you to speak.  Will you tell her to start drinking less?  Will you tell her that you are fine with her drinking habits, now that she's explained her startling change in behavior and her reasons for doing so?  Will you break up with her if she's that much of an alcoholic? Or do you want her to drink even more - perhaps you find her so much more fun to be with when she's blink stinking drunk?");
		//[Drink More] [Drink Less] [No Change] [Break Up]
		processTime(5);
		clearMenu();
		addButton(0, "Drink More", urtaDiscussAlcoholDrinkMore);
		addButton(1, "Drink Less", urtaDiscussAlcoholDrinkLess);
		addButton(2, "Be Yourself", urtaDiscussAlcoholNoChange);
		addButton(4, "Break Up", breakUpWithTheBitchOverAlcoholism);
	}
	else {
		output("You tell Urta that you want to discuss her newfound drinking habits.  The grey-furred fox-morph meets your gaze calmly.  \"<i>Really?  What more do you have in mind?</i>\" she asks.");
		if(flags["COC.URTA_ALCOHOL_HABIT"] == 1)
			output("  \"<i>I can't drink any more than I already do - I'm kind of pushing the laws to drink as much as I do already.</i>\"  She burps loudly, then starts on another bottle.");
		else
			if(Flag("COC.URTA_ALCOHOL_HABIT") == 0)
				output("  \"<i>You said you didn't mind me drinking as much as I do... are you going to ask me to cut down?</i>\" she asks, calmly and clearly assuming that's what you intend.");
			else
				output("  \"<i>I said it before, I'll say it again, I'm not going to stop drinking entirely - there's nothing wrong with a few cold ones to take the edge off.  I don't drink myself stupid any more; that should be enough for you,</i>\" she replies, defensively.");
		processTime(2);
		clearMenu();
		addButton(0, "Drink A Lot", urtaDiscussAlcoholDrinkMore);
		addButton(1, "Drink A Little", urtaDiscussAlcoholDrinkLess);
		addButton(2, "Be Yourself", urtaDiscussAlcoholNoChange);
	}
}

//[=Drink More=]
private function urtaDiscussAlcoholDrinkMore():void {
	clearOutput();
	urtaSprite();
	output("You blush a little bit and ask why she thinks you want her to drink LESS.  She stares at you quizzically and your blush deepens as you explain that when she gets drunk, lets her guard down, and gets so aggressive, you... well, you like it.  A lot.  Her ears perk up at your words, though her expression is a little uncertain while you explain it.  By the time you finish, something warm brushes by your leg and gently 'thunks' the table.  Clearly, she's as into the idea of encouraging her unrestrained, carefree self as you are.");
	//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
		//output("\n\nUrta smiles, gently at first, though it carries a bit of a predatory glint by the time she waves down a waitress and orders a full bottle of non-alcholic beer.  You give her a rueful smile, a stroke under the table, and a kiss just bursting with tongue before you conclude the conversation.  Urta's chuckles, \"<i>After the baby I'll be sure to have a little liquid motivation on hand.</i>\"");
	//}
	//else {
		output("\n\nUrta smiles, gently at first, though it carries a bit of a predatory glint by the time she waves down a waitress and orders a full bottle of Barkardi 151.  You give her a rueful smile, a stroke under the table, and a kiss just bursting with tongue before you conclude the conversation.  Urta's already half-way through the bottle of alcohol by the time you reach the door - you have a feeling the fox-herm's going to be a lot of fun from now on...");
	//}
	//{clear Urta sex cooldown}
	//{Boozehound Urta tag flagged}
	flags["COC.URTA_ALCOHOL_HABIT"] = 1;
	flags["COC.DISCUSSED_URTA_ALCOHOLISM"] = 1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

//[=Drink Less=]
private function urtaDiscussAlcoholDrinkLess():void {
	clearOutput();
	urtaSprite();
	output("You sigh and explain that her alcoholism isn't helping anyone – not her and certainly not her relationships with others.  You're not going to hold what she does when she's that drunk against her, but you really don't think it's healthy for her to get like that.  You promise her you'll try and be more supportive as well.  She nods, her expression knowing and somber, and she promises you that she'll cut back - enough that you won't see her get drunk like she used to anymore. She does warn you again that she doesn't intend to stop entirely - a few cold brews from time to time won't hurt anyone");
	//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
		//output(", once she's not pregnant anymore, of course");
	//}
		output(".  Her eyes glitter with steely resolve, and she leans over the table to kiss you on the lips.  The two of you wrap up the conversation, with you hoping that you've seen the last of drunken Urta.");
	//{Sober Urta tag flagged}
	flags["COC.URTA_ALCOHOL_HABIT"] = -1;
	flags["COC.DISCUSSED_URTA_ALCOHOLISM"] = 1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

//=No Change=]
private function urtaDiscussAlcoholNoChange():void {
	clearOutput();
	urtaSprite();
	output("You smile and ask her; why you would ever want her to change?  You like everything about her, including whatever she thinks she should drink.  You merely wanted to know why she changes so much when drunk - indeed, you think it's actually kind of thrilling to see her like that; you just prefer to know which is the real her.  She blushes hard when you tell her that, clearly enjoying the flattery and thrilled to hear that you're okay with how she chooses to blow off steam when she's not on the job.  The two of you joke around for a little longer, but before long, it's time you were on your way.  Urta's STILL blushing as she gives you a goodbye kiss – you must have earned some points with her today!");
	//{bonus wuv points}
	if(flags["COC.DISCUSSED_URTA_ALCOHOLISM"] == 0) urtaLove(1);
	flags["COC.DISCUSSED_URTA_ALCOHOLISM"] = 1;
	//{No new tags flagged}
	flags["COC.URTA_ALCOHOL_HABIT"] = 0;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

//[=Break Up=]
private function breakUpWithTheBitchOverAlcoholism():void {
	clearOutput();
	urtaSprite();
	output("You sigh, letting her know that her behavior isn't something you'd want from someone you're in a relationship with.  You need someone you can trust.  Someone you can count on.  Someone who isn't so ruled by their body's lusts.  Tears well up in the fox's eyes as you go on, barely held back by her desire not to cause a scene.  When you finish, she can't even meet your gaze.  She stares down at her drink, a tear rolling softly down her muzzle and dripping forlornly onto the table, and whispers, \"<i>Goodbye...</i>\"");

	output("\n\nThe bar seems eerily quiet as you step away from her, but it had to be done.");
	//{Urta is Heartbroken}
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", barTelAdre);
}

//[TWU WUV TALK]
private function UrtaTwuWuvOffer():void {
	urtaSprite();
	clearOutput();
	output("Urta looks nervously at you, fidgeting and shifting her sizable addition under the table.  She starts talking meekly, but her voice rises in confidence and intensity as she goes, \"<i>I've been thinking [pc.name], we've known each other for a while now.  When we're together, I don't have to worry about someone seeing something they shouldn't, or being made fun of, because it doesn't bother you and you don't care.  And what do I have to care about if you don't care about it?</i>\"\n\n");
	output("She leans over and puts her hands on your shoulders, looking you in the eye as she continues, \"<i>I've never felt this comfortable around ANYONE before, and well, I think I love you.  Please, do you feel the same way about me?</i>\"\n\n");
	output("Given how much time you've spent with her, and the amazing sex, her declaration doesn't really surprise you.  Do you love her back?");
	//[Yes] [No]
	processTime(1);
	clearMenu();
	addButton(0, "Yes", TwuWuvIsBeautifulUrta, undefined, "Love", "You love her!");
	addButton(1, "No", noUDontLoveUrta, undefined, "No love", "You are just friends.");
}

//[No]
private function noUDontLoveUrta():void {
	urtaSprite();
	clearOutput();
	//(LUV BLOCKED)
	flags["COC.URTA_PC_AFFECTION_COUNTER"] = 0;
	flags["COC.URTA_PC_LOVE_COUNTER"] = -1;
	output("You gently remove her hands from your shoulders and let Urta know that you enjoy being around her, but that you aren't in love with her.  Her eyes choke up with tears, but she nods as you explain, wiping her eyes with a napkin.  Urta cries softly and murmurs, \"<i>...I didn't want to hear that, but I understand.  Do you want to keep on as we have been though?</i>\"\n\n");
	//[Yes] [No]
	processTime(1);
	clearMenu();
	addButton(0, "Friends", stayFuckbuddiesAfterShootingDown, undefined, "Friends", "Stay friends.")
	addButton(1, "Break", turnDownFuckbuddiesANDLove, undefined, "Break", "Turn her down.");
}

//[yes]
private function stayFuckbuddiesAfterShootingDown():void {
	urtaSprite();
	output("Urta gives you a warm smile and a kiss on the cheek, \"<i>Good.  Come see me soon, ok?</i>\"\n\n");
	//(READY TO GO NEXT TIEM)
	flags["COC.URTA_PC_AFFECTION_COUNTER"] = 0;
	flags["COC.URTA_PC_LOVE_COUNTER"] = -1;
	flags["COC.URTA_TIME_SINCE_LAST_CAME"] = timeAsStamp;
	processTime(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[no]
private function turnDownFuckbuddiesANDLove():void {
	urtaSprite();
	clearOutput();
	output("Urta bursts into tears and pushes back from the table.  She runs out of the bar, sobbing wildly.  It looks like you've totally burned that bridge.  You may as well head back to camp...");
	//(BURN BRIDGES MOFO)
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Yes]
private function TwuWuvIsBeautifulUrta():void {
	urtaSprite();
	clearOutput();
	output("You nod and break into a wild smile.  You lean forward and the two of you embrace in a warm hug as you admit to loving the shy fox-herm.  She pulls back and kisses you passionately on the lips, and the pair of you spend an hour cuddling contentedly in a dark corner, happy to have taken things to the next level.  It passes in a flash, but you know you need to get back to check on camp, and you leave her with another quick kiss on the lips.  You " + pc.mf("chuckle", "giggle") + " when you hear her cock harden and thunk against the table again behind you.  Oh Urta...");
	//set wuv fwags
	flags["COC.URTA_PC_LOVE_COUNTER"] = 1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaBarApproach);
}

//Talk About Urta dialogue scenes:
//[=Family=]
private function urtaDiscussesFamily():void {
	clearOutput();
	urtaSprite();
	//if(!urtaLove()) {
		//output("You tell Urta that you'd like to learn about her family.  What are her parents like?  Does she have any siblings?  Is she the only hermaphrodite in the family?");
	////(Regular
	//if(!urtaLove()) {
		//if(flags["COC.URTA_FAMILY_TALK_ATTEMPTS"] == 0)
			//output("\n\nUrta winces, eyes starting to grow damp with unshed tears.  However, then she stares at you fiercely.  \"<i>I don't want to talk about them,</i>\" she growls.");
		//else
			//output("\n\nShe gives you a cold stare, making it quite clear she's still not inclined to discuss them.  Whatever the story is, it must be pretty painful.");
	//}
	////(Lover, First Time:
	//else {
		if(flags["COC.URTA_FAMILY_TALK_ATTEMPTS"] == 0) output("\n\nUrta sighs softly, closing her eyes sadly.  She stares fixedly into her glass.  \"<i>Please... not that. I'll talk about anything else, but not that,</i>\" she tells you.");
		//(Lover, Subsequent:
		else output("\n\nUrta shakes her head slowly.  \"<i>No.  It's... a painful topic - one I'd rather forget than relive.</i>\"");
	//}
	output("\n\nYou apologize and change the topic.");
	//[The other Urta dialogue option buttons appear at the bottom of the screen]
	urtaDialogueMenu();
	//}
	//else {
		//kGAMECLASS.urtaQuest.talkWithUrtaAboutFamFam();
	//}
}


//[=Sex/Romance=]
private function urtaDiscussesSexAndRomance():void {
	clearOutput();
	urtaSprite();
	output("You ask Urta if she'll tell you her romantic & sexual history.");
	if(!urtaLove()) output("\n\n\"<i>What?</i>\" Urta asks, stalling for time.  She casts her eyes back and forth nervously before teasing you with feigned confidence, \"<i>I guess you want to make sure that you're just not another notch on my bedpost, huh?</i>\".");
	else output("\n\n\"<i>Lover, you fuck me 'til I'm satisfied, and then, you want me to recount my sexual exploits?  I thought I had a one track mind!</i>\" Urta jokes with you.");
	output("\n\nYou smile it off and then insist that you want to know the details, all the same.");
	output("\n\nUrta goes to drink her glass, realizes it's empty, then sighs and fills it up, gently swishing the contents from side to side.  \"<i>Honestly... there's not really that much to say.  I just don't have a lot of experience in that department.  Not until I met you.</i>\"");
	output("\n\nYou tell her that you can't believe that; how can someone as popular as her not have a list of conquests?");
	//(Regular:
	if(!urtaLove()) output("\n\nUrta looks at you in pleased shock, blushing fiercely.");
	else output("\n\nUrta gives a startled laugh. \"<i>You really are too sweet, you know?</i>\"");
	output("  She takes a small sip from her glass, then speaks.  \"<i>In spite of that, the truth is... I've always been an outcast in the romance department...  I mean, I've had my share of crushes, but they've always wound up biting me in the ass.  Being a herm growing up wasn't easy.</i>\"  She sighs wistfully.  \"<i>I still remember my first crush.  He was a fox-morph, like me, only he had gorgeous red fur.  I'd been able to hide my... 'extra' parts from the other kids up until then, but, well, I didn't exactly have much in the way of tits yet, you know?  So, I got the shock of my life when he asked me out on a date - ME! It wasn't anything fancy, he just took me out for lunch and a little walk around, but it was still so wonderful nice.  It was lovely, at first...</i>\"");
	output("\n\nShe takes a big swig from her glass this time, holding it aloft as she swallows a bit of liquid courage.  You ask, politely, when it was that she shared her secret.");
	output("\n\n\"<i>I didn't - IT did.</i>\"  She scowls and mutters, \"<i>The date was over, and when he pushed me against a wall for a kiss... I was so surprised, and he was so pretty!  Not to mention, it was my first kiss, so, well... I lost control of myself, you know, like I do.  I popped the biggest boner of my young life, jabbed him right in the belly with my dick.  He jumped back from me like I was a demon, demanding to know what it was.  I tried to explain things, but he wouldn't hear it...</i>\"  Her expression sinks, sorrowfully.  \"<i>He started insulting me, my mother, and... and... I was crying so hard I barely heard him. It wrecked me.  I must have thrown up four or five times in that alley before I could stop crying and get out of there.  I... I never wanted to go through that again.</i>\"");
	output("\n\nUrta manages to give you a sad smile.  \"<i>I guess, in the end, I'm better off - I think I can appreciate having someone like you that much more thanks to assholes like him.</i>\"");
	output("\n\nShe fortifies herself with another drink.  \"<i>Things only got worse after that - he wasted no time in letting the other guys know about my 'maleness'.  I didn't exactly have a lot of friends before that, but after they found out I was a hermaphrodite, no guy would dare come near me.  Even the other girls stayed away.  I was one of the first herms, so there wasn't anyone else like me, and no one really knew how to handle people like me.  The few boys who did get interested got chased off by the other guys taunting them about being gay, or perverts, or whatever.  There was one guy who didn't seem to care...</i>\"  She scowls fiercely and grumbles, \"<i>It turned out he was gay, and when he found out I had a pussy and burgeoning breasts, he left me for some butch, bulldog-looking dude.  Fucking sissy bitch.</i>\"  She angrily slams down the remnants of her drink, then pours herself a new one.");
	output("\n\nYou ask if she ever thought of trying it with girls after that, seeing as how the boys didn't seem to want her.");
	output("\n\n\"<i>Well, I guess,</i>\" Urta mumbles. She idly traces the rim of her glass with one fingertip. \"<i>I suppose you could call me a bisexual, now at least, but that's mostly because I've learned to take what I can get when it comes to pleasure.  I've always liked guys, and them being a forbidden fruit for so long certainly hasn't helped.  Having both sets of parts though... it makes it hard.  Some folks just find it hard to like both parts equally in general, guys generally don't want to suck me off, and girls usually aren't keen on servicing my pussy, not with my balls on their forehead...</i>\"  She looks embarrassed.  \"<i>Sorry, it's easy to get sidetracked about this stuff, you know?  Anyway, girls!  I've had a few dalliances, but by then I had this... this monster-cock.  It interested a few, but nobody ever actually wanted to take it INSIDE them once they saw just how big it really was in person.  Can't say I blame them that much, I gotta admit I got a real pussy-stretcher here...  I got a few handjobs, maybe a blowjob or two, but that was it.  Most of my girlfriends didn't stick around.</i>\"");
	//IF ADMITTED TO EDRYN BONING:
	if(urtaOpenAboutEdryn()) output("\n\nThe pensive fox-girl trails off and then looks at you, contemplatively, before beginning to speak again.  \"<i>I have to admit... Edryn... she took my cock's virginity.  She's really been my only friend that's equipped to handle it, and from time to time... we take care of each other.  Even then, we're more friends with benefits than anything else.  We get along great, but we just don't click romantically.  The sex is good, but we roll apart and get back to work.</i>\"");
	output("\n\nShe looks at you, then, her eyes fixed on yours.  \"<i>When I saw you walk into the city, alone and vulnerable, I thought you might be a kindred spirit, and well, I thought you were kind of cute too.  I had to hurry away to the Wet Bitch because I couldn't stop thinking about having sex with you, throwing you against the wall and fucking you.  I didn't want to scare you away like all the others by showing you my cock.  Yet, you followed me, and you didn't care that I was a herm, and, well, you were there for the rest.</i>\"");
	output("\n\nIt's quite clear that she's finished telling you everything she has to say on the subject.  You could just leave it at that and go, or you could take advantage of what she's been talking about and see if you can get her all hot and bothered under the collar.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	//[Leave] [Tease]
	processTime(6);
	clearMenu();
	addButton(0, "Tease Her", urtaDiscussionTeaseAfterRomance)
	addButton(1, "Leave", urtaDiscussionLeaveAfterRomance);
}

//[==Leave==]
private function urtaDiscussionLeaveAfterRomance():void {
	clearOutput();
	urtaSprite();
	output("You thank her for sharing such personal information with you.\n\n\"<i>No problem, [pc.name].  It's good to be able to talk about it for a change,</i>\" the herm fox-morph replies.  As you get up to leave, she picks up her glass, drains it, and starts to pour herself another one.");
	processTime(2);
	clearMenu();
	addButton(0, "Next", barTelAdre);
}

//[==Tease==]
private function urtaDiscussionTeaseAfterRomance():void {
	clearOutput();
	urtaSprite();
	output("You thank her for telling you about her past like this but follow it up by asking her what she likes in the bedroom, doing your best to hide a mischievous grin.");
	output("\n\nUrta rocks back in her chair and blinks in confusion as she tries to answer, \"<i>Uh...?  Well... I... ummm, it's hard to say, to be honest.  I get around a lot less than most people in this city.</i>\"");
	output("\n\nYou smirk back at her.  Surely, you tell her, that doesn't mean she doesn't have the occasional fantasy about what she'd like to do with a willing partner.  At this, Urta blushes, and you press on mercilessly.  She said that she always liked males, but what does she like best about them?  Does she like the idea of some handsome man sinking his cock into her needy pussy, filling her tightly with his own symbol of masculinity and fucking her?  Does she want to be fucked soft and slow, made to feel like a woman in every way?  Or does she want to be pounded hard and raw; brutal, wild sex to make her scream her pleasure until the roof rattles from the sound of her ecstasy?  Or is it the idea of penetrating men that she likes - the image of taking some pretty little boy and having him meekly suck on her long, hot, throbbing horse-cock, or pushing over a man and making him moan and whine and claw at the sheets while she relentlessly pushes herself ever deeper into his back passage, sinking herself in to the hilt in his bowels?");
	output("\n\nUrta gives out a surprisingly small and wordless squeak, her eyes glazing over and making it very clear that your words are striking home.  You press on by asking her if she's really so reluctant to share her \"embarrassment of inches\" with girls who like a challenge, or does she just not like the idea of having her huge, powerful maleness tightly wrapped inside the warm, wet depths of a straining pussy working hard to accommodate her magnificent length and throbbing thickness?  Of hearing a woman screaming her name in lustful joy as the fox floods her with boiling spunk?  Doesn't she like feeling tits pillow and squish under her hands, or her face?  Or sliding her cock into them and feeling their softness all around them?");
	output("\n\nThe table suddenly jolts visibly as Urta's erection slams into it, the engorged flesh audibly crashing against the wood.  She gives you a flat look.  \"<i>Now look what you've gone and done,</i>\" she says, trying to sound stern, but coming off as a little amused.  \"<i>I hope you're going to take responsibility for this...</i>\"");
	urtaLove(1);
	//Appropriate sex scene options are given; Hidden Blowjob and Urta's Place for regular Urta and Urta's Place, Suck Off and Eat Out for lover mode Urta
	pc.lust(15);
	clearMenu();
	if (!urtaLove()) {
		addButton(0, "Urta's Place", goBackToUrtasForLuvinz, null, "Urta's Place", "Go to Urta's apartment for sex.");
		addButton(1, "Hidden BJ", blowUrtaUnderTable, null, "Hidden BJ", "Suck Urta's dick until she cums!");
	}
	else {
		addButton(0, "Her Place", goBackToUrtasForLuvinz, null, "Her Place", "Go to Urta's apartment for sex.");
		addButton(1, "Suck Off", blowUrtaUnderTheTableLuv, null, "Suck Off", "Suck Urta's dick until she cums!");
		addButton(2, "Eat Out", eatUrtaOutNomNomPussy, null, "Eat Out", "Get a taste of Urta's vagina! (And optionally, drink a glass of her cum.)");
		if (pc.hasCock() && !pc.isTaur()) addButton(3, "Vixen & Cream", vixenAndCreamPart1, true, "Vixen & Cream", "Try something special! \n\nNOTE: This is very long! Don't select this if you have ADHD.");
		//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) removeButton(1); //Disables button.
	}
	addButton(14, "Leave", barTelAdre);
}

//[=Employment=]
private function urtaDiscussesEmployment():void {
	clearOutput();
	urtaSprite();
	output("You ask how and when it was that Urta came to be part of the Tel'Adre watch.");
	output("\n\nUrta blinks at you in surprise.  \"<i>Well, that's a strange question to ask... damn, it must have been around four or five years ago, now.  I was... well, let's be honest, I was basically a homeless street punk at the time, and the Watch was desperate for warm bodies to fill uniforms.  I marched up to the recruiter and told him I wanted in.  It helped that I had a bit of a reputation for taking on bullies and winning.  He snapped me up,</i>\" she says, shrugging and taking a casual slug from her glass.");
	output("\n\nYou nod in understanding, and ask how things went for her once she was recruited.");
	output("\n\n\"<i>Honestly?  I finally felt I had a place to belong.  Being in the Watch gave me a sense of purpose.  A few weeks into the training, I met Edryn, and we became fast friends.  Sure, there were some who objected to someone 'demon-touched' being in the Watch.</i>\"  One of her hands slips under the table and audibly pats her penis to give you an idea of why they would have called her such a thing.  \"<i>I stood up for myself, for once, and challenged anybody that dared call me that.  I was bullied a LOT growing up, so this time, I didn't take shit from anyone.  The higher-ups took notes as I fought, and as the war dragged on and , I stopped being such an odd case.  Once being a herm wasn't a huge stigma, I had an easy time climbing the ranks, and well, I became Captain of the Guard before I knew it.</i>\"");
	output("\n\nAs she triumphantly drains her glass in honor of her achievement, you are reminded of something that has been bothering you.  Delicately, you ask her; if she's a Guard Captain... then how come she always seems to be in here drinking?");
	output("\n\nShe just grins at you in response.  \"<i>Well, most of my duties involve filling out paperwork, and because I'm the one in charge, well... so long as the paperwork gets filled out, it doesn't matter where I fill it out from, understand?  Besides, I'm not in here ALL day.  I spend a lot of time out in the streets, keeping my ear to the ground.  You're just lucky enough to catch me whenever I drop in to wet my whistle.</i>\"");
	output("\n\nAlmost as if to punctuate her words, a centaur suddenly comes racing into the Wet Bitch.  \"<i>Captain Urta!</i>\" he cries out.");
	output("\n\nUrta shrugs.  \"<i>See what I mean?  Duty calls, it's been nice chatting with you,</i>\" she says, standing up and racing off, easily leaping up onto the startled centaur's back, who rears up and spins around before galloping off.  Seeing that Urta obviously has her hands full, you leave the bar.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Prejudice=]
private function urtaDiscussesPrejudice():void {
	clearOutput();
	urtaSprite();
	output("Hesitantly, you ask Urta if she has ever faced prejudice for her hermaphroditic nature.");
	output("\n\n\"<i>...Why would you ask that?</i>\" Urta finally responds, warily.");
	output("\n\nYou note that you had never seen - had never even heard - of someone being both female and male at the same time before you came to Mareth, and Urta's own attempts to hide it suggest that she's not exactly comfortable with it.  That itself implies that others may be even less so.");
	output("\n\nUrta looks at you, seeming to peer into your soul, then heaves a heavy sigh.  She snatches up her glass and drains it in one shot, silently pouring herself a refill and staring melancholically into it. Finally, she begins to speak, \"<i>Yeah... when I was younger, at least.  I... I don't know if I was the very first hermaphrodite to be born in Tel'Adre, but I was one of the first.  The demon war was just starting, then, and the only herms that anybody had seen or heard of by that point were in the demon ranks.  Things were... unpleasant.</i>\"");
	output("\n\nShe drinks until her glass is empty, refills it, and then drains it again.  By the time it's once again empty, you've mustered the nerve to ask if things have improved since then.");
	output("\n\n\"<i>Of course it's better now, though old wounds linger.  Sure, you still get the odd bigot, but you don't have people calling herms 'demon-touched' anymore,</i>\" she agrees.");
	output("\n\nYou ask what changed that.");
	output("\n\n\"<i>Ironically enough, the demons.  All the pollutants and toxins they dump into the ground, the water, the air; it's messed with a lot of races, so even technically pure men and women started giving birth to the odd hermaphrodite.  Combine that with all the people who accidentally got turned into herms - or changed themselves on purpose - and then didn't run away to join the demon army because they weren't complete idiots, and, well...</i>\"  She shrugs.");
	output("\n\nYou nod in understanding, thank her for being willing to talk about something so personal, and then leave her, still nursing her empty glass.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Talk About Edryn dialogue scenes:
private function urtaDiscussesEdrynHistory():void {
	clearOutput();
	urtaSprite();
	//[=History Together=]
	output("You ask Urta what her past with Edryn is.");
	output("\n\nUrta simply shrugs at you. \"<i>To be honest?  We never knew each other until we started working on the Watch together.  I can't recall why it was she joined - maybe something about her father hoping it'd teach her to curb her lust? - but she signed up a few weeks after I did.  We got sent on patrol with each other a few times, started talking and, well, we hit it off.  Edryn's my best friend, and she's been a rock of support since she entered my life.</i>\"");
	output("\n\nSeeing that there isn't much more she knows than that, you thank Urta for answering your question and excuse yourself.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Working Together=]
private function urtaDiscussesWorkingWithEdryn():void {
	clearOutput();
	urtaSprite();
	output("You tell Urta that you're curious about her working relationship with Edryn.  Do they work together often?");
	output("\n\n\"<i>All the time,</i>\" Urta responds.  \"<i>Standard operating procedure in the guard is to work in teams of two or three, and a centaur always has to have a morph or other biped working with them.</i>\"");
	output("\n\nCurious about the arrangement, you ask why that is.");
	output("\n\n\"<i>Centaurs are big and strong, but they're not really maneuverable - oh, they can run like anything when they want, but they suck at making tight turns or getting around in narrow spaces.  Plus, that four-on-the-floor configuration of theirs means they have a hard time defending their entire body,</i>\" Urta explains.  \"<i>We're not just a good team, we're good friends, so we prefer to work with each other; we've got good chemistry on the job, and our skills complement each other well, so the Covenant doesn't mind us being assigned together.</i>\"  She smirks at you.  \"<i>The others in the Watch refer to Edryn as my right-hand mare.</i>\"");
	output("\n\nYou thank Urta for her time and let her get back to her drinking.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Romance? =]
private function urtaDiscussesEdrynRomance():void {
	clearOutput();
	urtaSprite();
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	processTime(10);
	clearMenu();
	//Regular
	//This scene only plays if the player has not had to talk to Urta about Marble, and has not had to talk to Urta about Scylla
	if(!urtaLove()) {
		if(!urtaOpenAboutEdryn()) {
			flags["COC.URTA_OPEN_ABOUT_EDRYN"] = 1;
			output("You tell Urta that you've noticed she and Edryn seem to hang out together a lot.  Furthermore, as a centauress, you figure Edryn's probably capable of handling what Urta has hanging between her legs.  You're curious; are they a couple?");
			output("\n\nUrta splutters the drink of whiskey she was taking all over the table, wiping half-heartedly at the stains as she regains control of herself.  \"<i>W-Why on earth would you ask something like that?</i>\" she asks, wary.");
			output("\n\nYou shrug your shoulders, saying it was just an honest question, and the two of you are honest with each other, after all.");
			output("\n\nIt's so quick you almost miss it, but Urta winces when you say that.  She bows her head, refusing to look you in the eye, but then visibly comes to a decision.  \"<i>Since you ask... we're not a couple in the sense that we're romantically involved.  But we do... have sex.</i>\"");
			output("\n\nShe pauses there and waits for your reaction, sipping nervously at her glass.  For whatever reason, your head doesn't explode and you indicate she should continue; you want the whole story before you trust your reaction.");
			output("\n\n\"<i>Edryn... was the first woman I'd ever had sex with.  ");
			//(If player has vagina and has sexed Urta:
			if(pc.hasVagina()) output("Until you, she was the only woman who didn't freak out and insist it was handjobs or nothing when she saw how big I was.  ");
			output("Apparently, I'm bigger than even the average centaur stallion, and Edryn likes that in a fuck.  I was young, naive... hurting.  I was a virgin in almost every sense of the word, back then; I'd jerked off a few times, used a few toys, but never anything with an actual person.  Combine that with Edryn's pheromones, that can make anyone rock-hard in seconds... I was putty in her cunt, if you know what I mean.</i>\"");
			output("\n\nShe sighs, softly, \"<i>Edryn doesn't want us to be anything more than friends with benefits.  I don't think she's got anything against me being a herm, but she's alluded to wanting a stud to settle down with, some day, if this war ever ends.  In all honesty, I understand.  We make great friends, but I don't think we really click right as lovers.  She was the only one I'd ever had, though, and I was racking my brain to try to make it work... until you walked through the doors to this bar and into my life.  I really do think we could have something special together, but... I... when I really get going, I NEED to do something, and I'd rather it be with Edryn than some stranger, or alone in an alley.  It doesn't help that Edryn loves to tease me with her scent until I can't stand it.  Only when we're off duty, of course - one of the reasons I'm sitting so far away from her when we're in here at the same time.  I want to be with you, but I don't think I'll ever be able to stop seeing Edryn entirely - not unless we live together.</i>\"");
			output("\n\nShe shakes her head.  \"<i>But I owed you this truth, at the least.  So... what'll be?  Can we be honest, polygamous lovers?   Or is that too weird for you?</i>\"  She stares at you and takes a fortifying drink of whiskey, shuddering nervously as she awaits your response.");
			output("\n\nYou ponder what you should do for a moment.  Will you accept Urta's little indiscretions?  Or will you refuse to have anything to do with her if she can't be faithful to you alone?");
			//[Accept] [Reject]
			addButton(0, "Accept", urtaDiscussesEdrynNonLoveAccept)
			addButton(1, "Reject", urtaDiscussesEdrynNonLoveREJECT);
		}
		//Subsequent Regular Variant:
		else {
			output("You give Urta a thoughtful look, and then ask how things are with Edryn these days.");
			output("\"<i>Good,</i>\" the fox-morph replies freely.  \"<i>She'll never compare to you, but she is a truly wonderful fuck... I swear, there is nothing quite like feeling a mare-cunt juice itself around you...</i>\"  She smirks at you, obviously enjoying the chance to make you squirm, but ");
			if(pc.cor() < 66) output("her manner is playful");
			else output("her expression sobers when you make no response");
			output(".");
			//(If player can now sleep with Edryn for free:
			if(flags["COC.EDRYN_AFFECTION"] >= 4) {
				output("  \"<i>Of course, you know that firsthand, don't you?</i>\" she grins.  \"<i>Did hearing that I was having sex with her make you curious about what it was like?");
				//(If player has fathered at least 1 child on Edryn:
				if(flags["COC.EDRYN_NUMBER_OF_KIDS"] > 0) output("  Still, I can't believe you actually knocked her up - I had to pick my jaw up off the floor when she told me that the foal kicking inside her ballooning gut was yours.  I mean, those herbs are supposed to be foolproof...</i>\" She shakes her head, half in disbelief of your sheer virility, half in awe of it.");
				else output("</i>\"");
				if(flags["COC.URTA_FERTILE"] == 0) output("  \"<i>Still, I hope you don't have any idle thoughts in your head about knocking me up; there's a difference between overwhelming contraceptives and sowing seed where the field's barren,</i>\" she states, patting her flat belly for emphasis.  Despite how flippant she tries to sound when she says this, you can tell that it's something of a sore subject for her.");
			}
			output("\n\nYou shake your head with a half-grin and apologize for trying to tease her about it.");
			output("\n\n\"<i>It's all right... uh, [pc.name]?</i>\" Urta asks, as you stand up, causing you to turn back to face her.  As you wait for an answer, she shakes her head. \"<i>No, nothing, never mind, forget I said anything.</i>\"");
			output("\n\nWondering what that was about, you bid her goodbye and leave the tavern.");
			
			urtaLove(.5);
			addButton(0, "Next", telAdreMenu);
		}
	}
	//Lover
	else {
		//First time!
		//This scene only plays if the player has not had the Regular version of this dialogue, has not had to talk to Urta about Marble, and has not had to talk to Urta about Scylla
		if(!urtaOpenAboutEdryn()) {
			flags["COC.URTA_OPEN_ABOUT_EDRYN"] = 1;
			output("\n\nYou tell Urta that you've noticed she and Edryn seem to hang out together a lot.  Furthermore, as a centauress, you figure Edryn's probably capable of handling what Urta has hanging between her legs.  You're curious; are they a couple?");
			output("\n\nUrta looks a little sheepish.  \"<i>Ah... that's, not exactly a straight question.  I guess... yes and no?</i>\" she replies.");
			output("\n\nYou ask her to explain.");
			output("\n\n\"<i>Okay... well, Edryn and I do have sex now and then, but we aren't together.  Edryn... Edryn's pussy gives off pheromones that can drive anybody even a LITTLE equine mad with desire, and I'm no exception.  We're good friends, and before I met you I was so pent up; combine that with my being a satisfactory size, and we'd wind up fucking from time to time.  It was always casual - she's said she's not interested in being anything more than friends with benefits, and, honestly, I'm fine with that - now.  I try to avoid fooling around with her now that I have you, but... well, sometimes you're not here and she gives me a bit more of a whiff than I can handle.  Even when she doesn't, sometimes I... I just can't control myself.  [pc.name], I... I have the libido of a slut in heat and a rutting bull, added together,</i>\" Urta explains, looking down in shame.");
			output("\n\n\"<i>I didn't want to keep it secret from you, but I was scared you'd hate me for not telling you this to start with,</i>\" Urta suddenly blurts out, looking up at you with wet eyes.  \"<i>I... I won't blame you if you do anyway, but I love you, [pc.name], more than anyone else in the world,</i>\" she states desperately.  \"<i>It's just a matter of physical relief for me - you're the one I love, the only one I love, and she's happy for me to be with you.  I just... I just can't stop having sex entirely, because I'd never be able to stay sane - you aren't here often enough for me to release my pent-up urges, and you'll never be there while you're still out there fighting the demons.  I want YOU and only you, but with our lives like they are now, I can't.  Please tell me you understand,</i>\" she begs.");
			output("\n\nIt's quite clear that she means what she's saying.  Can you accept this arrangement, maybe even be happy about it, or will you break up with her over this breach of trust?");
			//[Happy] [Tolerate] [Breakup]
			addButton(0, "Happy", urtaDiscussesEdrynLoveHappy)
			addButton(1, "Tolerate", urtaDiscussesEdrynLoveTolerate);
			addButton(1, "Break Up", urtaDiscussesEdrynLoveBreakup);
		}
		else {
			output("With a smirk, you ask Urta how things have been between her and Edryn lately.");
			output("\n\nUrta blushes brightly with embarrassment. \"<i>It's not my fault!</i>\" she protests, misinterpreting your question.  \"<i>I've told her that I want to break things off sexually between us now that I have you, and she says she approves of you, but she just loves to tease me until I lose it and mount her!  I'm trying to be faithful to you, really!</i>\"");
			output("\n\nYou burst out laughing.  Urta simply slumps into her seat and stares fixedly at her drink, clearly sulking. You sling an arm around her shoulders and kiss her until she kisses you back, then apologize for teasing her like that.");
			output("\"<i>Hmph!  So you should be!</i>\" Urta says, sticking her nose up in the air in an indignant huff... but she can't keep a straight face for more than a few moments.  \"<i>I still can't believe you took it so well when I told you - I really am a lucky girl to have someone like you, aren't I?</i>\" she says.");
			//(If Edryn is doing the player for free:
			if(flags["COC.EDRYN_AFFECTION"] >= 4) output("  \"<i>Though I have to admit I was still a little jealous when Edryn told me you were having sex with her too.  Still, I guess that's just another thing we have in common, yeah?  A mutual taste in sexy ladies.</i>\"  She laughs, and mockingly shapes her hands through the air as if caressing Edryn's sizable boobs.");
			//(If Edryn has had at least one baby:
			if(flags["COC.EDRYN_NUMBER_OF_KIDS"] > 0) {
				if(flags["COC.URTA_QUEST_STATUS"] == 1) {
					//if(urtaPregs.urtaKids() == 0) output("  \"<i>...I still can't believe that you actually get her pregnant, though.  It's just not fair that Edryn's got little hooves running around, and after everything I went through, I don't have kits of my own... yet.</i>\" She gives you a slightly predatory smile along with the last word.");
					//else 
					output("  \"<i>...I still can't believe that you actually got her pregnant, though.  I guess I'll have to keep you busy in the sack if we're going to keep up, huh?</i>\" She gives you a slightly predatory smile along with the last word.");
				}
				else output("  \"<i>...I still can't believe that you actually got her pregnant, though. It's just not fair that Edryn's got little hooves running around, and you and I can't have any.</i>\"  Urta sighs.");
			}
			//[If fertility quest is done: "At least... not while those damn demons are still out there, keeping us both busy.  I know it's selfish of me, but... try and put an end to them? For me?  I want to start a family with you."  Urta looks deeply into your eyes.])
			output("\n\nYou nod and tell her it was good to see her again, and it's nice that the two of you have this out in the open.  As you politely get up and get ready to leave, it almost looks like Urta wants to say something to you, but then she shakes her head and lets you go.  You wonder what she may have had on her mind.");
			
			urtaLove(.5);
			addButton(0, "Next", telAdreMenu);
		}
	}
}

//[=Accept=]
private function urtaDiscussesEdrynNonLoveAccept():void {
	clearOutput();
	urtaSprite();
	output("You think about it long and hard, and you finally decide that you can't hold Urta's dalliances with Edryn against her.  From the sound of it, Urta honestly has more reason to be interested in the centauress than in you - she's known Edryn longer, she lost her virginity to her, they're partners and friends.  Yet, despite this, she insists she feels more of a connection to you, and she was honest about what she's been doing and why.  Plus it's not as if you can't understand how she feels about the temptation.  Most creatures you've met in this weird world have either been very sexually tempting, or outright tried to make you have sex with them.");
	output("\n\nYou give the fox-morph a gentle smile and tell her that you understand what she's told you and you accept it.  Urta's eyes widen in shock and gratitude.  \"<i>Thank you, [pc.name]!</i>\" she cries, smiling happily.  \"<i>Please, believe me, I don't feel this way about anyone else,</i>\" she says - so happy that she unwinds her tail and starts wagging it behind her.");
	output("\n\nThe two of you share a drink and then you politely excuse yourself; Urta seems so much happier now she has the weight of that secret off her shoulders.");
	urtaLove(1.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Reject=]
private function urtaDiscussesEdrynNonLoveREJECT():void {
	clearOutput();
	urtaSprite();
	output("No matter how you look at it, you can't help but feel betrayed - Urta's been sleeping around behind your back.  If she didn't want this relationship to be monogamous, she should have told you before, and you tell her as much.");
	output("\n\nThe fox-morph looks hurt, but then develops a stony expression.  \"<i>I.. I understand.  I won't bother you any more.</i>\"");
	output("\n\nYou declare that suits you fine and get up from your seat, heading away.  Urta doesn't call you back, disappointing you a bit; she stoically watches as you leave, never once making a sound.");
	//{Urta is now Heartbroken}
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Happy=]
private function urtaDiscussesEdrynLoveHappy():void {
	clearOutput();
	urtaSprite();
	output("When you think about it, you decide to look on the positive side of things.  You trust Urta when she says she loves you - if she needs to \"vent\" when you aren't around to help, well, it's okay.  You smile at her and assure her that you're not upset; indeed, you're happy that she would be honest with you about this, and happy to know that she has a good friend like Edryn.  She beams a thankful smile back and kisses you passionately before you excuse yourself and leave.");
	urtaLove(5);
	processTime(3);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Tolerate=]
private function urtaDiscussesEdrynLoveTolerate():void {
	clearOutput();
	urtaSprite();
	output("Thinking about it long and hard, you sigh as you realize you couldn't blame her, even if you wanted to try.  It's hard enough for you to avoid being tempted by all of the sexy creatures this world has to offer - Urta must be in the same boat.  Still, you add, you would prefer that Urta not go rubbing the fact that she sometimes has to have sex with Edryn in your face.");
	output("\n\nUrta considers for a while before speaking again.  \"<i>I... yeah.  Thanks, [pc.name].  For understanding.</i>\"");
	output("\n\nSeeing as there's nothing else for either of you to say to each other now, you politely get up and leave.");
	//{Choosing this option should probably disable both the Romance? discussion topic and the ability to have threesomes with Urta & Edryn - if you can't accept that she needs to fuck mare-cunt when you're not around, then you're probably not the sort of guy who's going to take kindly to the idea of doing her from behind even as she pounds Edryn.}
	flags["COC.PC_DISLIKES_URTA_AND_EDRYN_TOGETHER"] = 1;
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Breakup=]
private function urtaDiscussesEdrynLoveBreakup():void {
	clearOutput();
	urtaSprite();
	output("No matter how you look at it, you can't help but feel betrayed - Urta's been sleeping around behind your back.  If she didn't want this relationship to be monogamous, she should have told you before, and you tell her so.");
	output("\n\nThe fox-morph looks hurt, but then develops a stony expression.  \"<i>Fine.  If that's the way you feel about it, then it's over,</i>\" she tells you.");
	output("\n\nYou declare that suits you fine and get up from your seat, heading away.  Urta doesn't call you back, disappointing you a bit; she stoically watches as you leave, never once making a sound.");
	//{Urta is now Heartbroken}
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(2);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Membership=]
private function urtaDiscussesWatchMembership():void {
	clearOutput();
	urtaSprite();
	output("You tell Urta that you're curious about the Watch's membership.");
	output("\n\n\"<i>Membership, huh?  Like... how many members, joining requirements, things like that?</i>\" Urta asks, prompting a confirmatory nod from you.");
	output("\n\n\"<i>All right... well, getting in is pretty simple.  All you have to do is prove you're willing to follow orders, and that you can kick ass, and you're in.  If you're not tough enough, you wash out on your own, but the Watch doesn't discriminate - not now.  We'll take any able-bodied person we can get, and we don't care what gender you are, were born as, or self-identify as.  We don't care what you look like. We're not even that concerned with possible criminal records - within reason.  I mean, we don't take any drug-dealer or murderer trying to use us as a cover, and breaking the law when you're in the Watch winds up being way worse than if you weren't a member.  However, we can't afford to be picky, you know?</i>\"");
	output("\n\n\"<i>As for numbers... that's a bit trickier to answer.  Suffice to say, we're big.  We're still the old city guards, but now we're also the town's army and militia - we're the last line of defense if the demons ever manage to find us and breach the walls.  So we get a lot more recruits now then we used to, back in the day.  Of course, with how the city's population has shrunk...</i>\" Urta shrugs her shoulders meaningfully, and you nod your head in understanding.");
	output("\n\n\"<i>All in all, we don't lack for recruits.  Everyone in this city knows that we're the ones who put our necks on the line to keep the city from dissolving into one endless demon-ruled orgy.  Being a Watchman or Watchwoman has attained a certain glamor, these days,</i>\" Urta finishes.  Then she smiles at you.  \"<i>Why the questions?  Thinking of joining?</i>\"");
	output("\n\nYou answer in the negative.");
	output("\n\n\"<i>Ah well.  Still, if you ever decide you'd like to serve under me... or serve <b>under</b> me...</i>\" she adds, giving you a lecherous leer, \"<i>...you know where to find me.</i>\"");
	output("\n\nYou smirk back at her, and tell her that's what you figured.  Then, sincerely curious, you ask her; would it be possible for you actually join?  And how would your... relationship... be regarded by the Watch, especially if you did join?");
	output("\n\nUrta smiles at you.  \"<i>Joining's easy, but you'd have to give up that adventuring business - you can't serve the city when you never spend any time in the city.  As for us...</i>\" she taps her clawed fingers idly on the table, clearly trying to remember precedent.  \"<i>So long as you don't let it interfere with work - like, blowing off a case to fuck in an alley - nobody will bat an eye.  'Course, it means you'll need to work a little harder than the others, or else they'll say I'm going softer on you because we're in each others' pants.  And if they aren't leery about that, they'll be teasing you about us.  So...</i>\" she trails off, shrugging her shoulders, unable to articulate any more because of the nebulousness of the subject.");
	output("\n\nYou thank her for the explanation, and note you don't think you'll be able to seriously consider signing up at the present time.  Out of things to talk about, you thank her for her time, and leave her to nurse her drink.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(8);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Role In The City=]
private function urtaDiscussesWatchRole():void {
	clearOutput();
	urtaSprite();
	output("You tell her that you're curious about what it is that the Watch actually does, on a day to day basis.");
	output("\n\nUrta looks thoughtful for a moment, and takes a drink.  \"<i>Well,</i>\" she finally says. \"<i>I guess you could say we're like a mixture of the police and the army.  We still handle all of the old crimes, but we're also responsible for protecting this city from corruption in particular.  We stand watch at the gates and screen entrants for possible corruption - we have to fight off or otherwise turn away those who are too corrupt or who look like they'd pose the risk of contaminating our city, and even if they do get through, we keep tabs on the particularly corrupt.  We also have to keep our eyes and ears open for corrupt individuals sneaking in or people being corrupted - by accident or on purpose - then we've got to flush them out of hiding and either rehabilitate them or exile them,</i>\" she explains.  \"<i>I guess, all in all, our most important role is making sure nothing and nobody gets at the magi.</i>\"");
	//(uncorrupt PC:
	if(pc.cor() < 66) output("\n\nYou agree that it sounds like the Watch does very important work, and Urta should feel proud of being part of their ranks.  The fox-morph puffs out her chest with pride, and on that high note you leave her to her drinking.");
	//(PC is too corrupt:
	else output("\n\nYou simply nod your head in understanding; maybe having Urta wrapped around your finger was a smarter move than you thought.  Last thing you need is a bunch of misguided killjoys taking you down.  You change the subject and make small talk for a while longer, and then see yourself out.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(8);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Reach=]
private function urtaDiscussesTheWatchsReach():void {
	clearOutput();
	urtaSprite();
	output("You ask Urta just how far the Watch's authority spans from the city.");
	output("\n\n\"<i>Not sure what you mean... are you asking if we chase people outside the walls?</i>\" Urta asks.  When you nod, she shrugs.  \"<i>It depends on your crime and if we think it's worth the effort. Generally, once somebody has escaped the city, we just update the wards and leave it be; it's as good as a death sentence to be beyond these walls for most people.</i>\"");
	output("\n\nYou can certainly understand that viewpoint, and ask if the Watch ever sends patrols out into the wilderness.");
	output("\n\n\"<i>Sometimes.  Very rarely.  And always volunteers,</i>\" Urta states immediately.  \"<i>What I said about it being a death sentence?  That applies to us, too.  We've lost a lot of people over the years, and even with our attractiveness to recruits, we can't afford to just keep sending people out to disappear. Our watchmen are only sent out to scout out possible threats to the city, and they're under orders to avoid being seen or to fight anything.</i>\"");
	output("\n\nYou digest that for a few moments, then cautiously ask if Urta's ever been outside of the city in person.");
	output("\n\n\"<i>...A few times,</i>\" she admits at last.  \"<i>I prefer to avoid it if I can.  I went on my first patrol only a few weeks after I had joined the Watch - thought it would be a great way to prove myself.  We... we were ambushed.  Demons attacked us, started throwing black magic around.  I don't know why, but it just sort of... washed off of me.  I was the only one who managed to get away - I looked back, and the others were fucking demons or being fucked by the demons.  I had to leave them behind and flee with my tail between my legs.</i>\"");
	output("\n\nShe morosely finishes off her drink and starts pouring herself another.  You wait for her to take the first sip before warily asking if she was, perhaps, blamed for the attack because of her sex.  She looks at you and then shakes her head.  \"<i>No.  I got an extensive debriefing... understandable, but they didn't accuse me of anything.  In the end, I got the notoriety I was after... but not in a way I wanted it.</i>\"  She sighs softly and drinks again.  \"<i>When I became captain, the first thing I did was order all teams to focus on stealth, and to run rather than fight whenever possible.  We normally only patrol into the desert, as far as the badlands - most critters don't want anything to do with either place, so we don't run into the big nasties I hear are in lusher places.  When we need outside supplies, we send out specific procurement teams who've been to our sources before and can get back there quickly and quietly.</i>\"");
	output("\n\nYou thank Urta for the explanation and politely excuse yourself, leaving Urta to drink off her depression.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(8);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//[=Crime & Punishment=]
private function urtaDiscussesCrimeAndPunishment():void {
	clearOutput();
	urtaSprite();
	output("You explain to Urta that you're curious about the law in Tel'Adre - what is a crime here, and what are the punishments that the Watch is likely to deal to a criminal?");
	output("\n\nUrta looks at you with, perhaps, a trace of suspicion, but then relaxes and takes a thoughtful sip of her whiskey.  \"<i>Well... we've had to change a few laws, but, mostly we're still the same city we always were, legally.  We won't put up with burglary, pickpocketing, mugging, rigging gambling games, swindling, short-changing, stuff like that.  You know what I mean?</i>\"");
	output("\n\nCurious, you press her on what she means by some of the laws changing.  Are some things not against the law anymore?  Have they had to come up with new laws?");
	output("\n\n\"<i>A bit of both, to be honest,</i>\" Urta explains.  \"<i>I think the laws on rape are the biggest ones - we're really supposed to crack down on that now.</i>\"  She reads the look on your face and doesn't wait for your question before launching into an explanation.  \"<i>Rape is an act that's gotten heavily associated with corruption - liking sex is fine, indulging in your kinks is fine, but going out and just attacking someone for the sake of getting yourself off?  That's how a demon thinks.  Using magic or alchemy to make the victim want it only makes things worse - even if you don't actually do anything, if a person reports you used black magic or something to make them hornier, we can charge you as a rapist and punish you accordingly.</i>\"");
	output("\n\nYou nod your head in understanding, then ask what's legal now that wasn't before.");
	output("\n\n\"<i>...Mostly some of the public decency laws, I'd guess.</i>\"  Urta says after some thought.  \"<i>Like, it's not against the law to walk around naked now - you might get some funny looks or people calling after you, but the Watch won't get on your case unless you start rubbing one out into a fountain or something.  Or prostitution - it's legal to exchange sex for money in Tel'Adre, now.  It's actually something of a booming business.</i>\"");
	output("\n\n\"<i>As for new crimes... well, it basically all falls under a single category: 'Aiding and abetting the demonic hordes'.  Anything that weakens Tel'Adre against the demons or strengthens the demons.  Spreading corruption, mind control, selling people into demonic slavery, betraying the city to the demons - you get the idea.</i>\"  Urta shrugs.");
	output("\n\nShe takes another slug of whiskey and then idly comments, \"<i>I think the black and gray marketing is the worst.</i>\"  At your confused expression, she elaborates.  \"<i>The demons make a lot of stuff that is designed to tempt people with pleasure - incubi drafts and succubi milk are very popular with people who want to make their 'fun bits' grow, or who'd like to 'see how the other side lives'.  For example... I have this one watchman who bought a lot of succubus milk and drank it, so he ended up turning completely into a girl.</i>\"");
	output("\n\nYou smirk and note that must have given his girlfriend quite a shock.");
	output("\n\n\"<i>Not as much as he got when he found out that incubus drafts can't turn a girl completely into a guy.  Or when his girlfriend promptly got herself a cock with incubus drafts and started using it on him - he's given birth three times since then.</i>\"  Urta grins back.  \"<i>But, in their raw state, most of those items poison the soul - they fill you with corruption, make you start acting and thinking like a demon.  The black market is the underground market for that sort of stuff - I think the Watch spends more time on uprooting it and stomping it out than we do on anything else.  Eventually, we figured out it's possible to actually alchemically purify some of that stuff, and so we set up the gray market - you get and keep your license by proving that you've taken the effort to purify the items that can be purified, and that you don't stock the stuff that's simply too dangerous.  No license?  You're just a black marketeer, and we have to stop you.</i>\"");
	output("\n\nThat reminds you, and you promptly ask Urta just what sorts of punishments Tel'Adre has for lawbreakers.");
	output("\n\n\"<i>Well... corruption and demon-related crimes are the big ones, these days.  Sometimes, in exceptional circumstances, we'll try and rehabilitate the criminals, but usually we just exile them.</i>\" Urta replies.");
	output("\n\nFurrowing your brow, you ask if that isn't dangerous to Tel'Adre's safety; couldn't an exile lead demons back to the city?");
	output("\n\n\"<i>Not a chance,</i>\" Urta answers confidently.  \"<i>The Watch and the Council both work together closely on that; when somebody is exiled from the city, the Council updates the warding - that person can never find their way back to Tel'Adre.  Certainly not at the head of a demonic army; that much corruption would set even the weakest wards ringing and the whole Council would turn up the power and make the city vanish.</i>\"");
	output("\n\nShe looks puzzled for a few moments, lost in thought.  \"<i>I'm sure we do still have the death penalty, but in all my years of service I can't remember it ever being carried out.  I think that would require the most extreme treachery to be committed against the city.</i>\"  She shrugs and then carries on.  \"<i>For lesser crimes, we have more mild punishments - fines, time in prison mixed with public service, even things like whippings or the stocks if need be.</i>\"");
	output("\n\nYou thank her for the informative discussion and politely excuse yourself.");
	if(pc.IQ() < 60) pc.slowStatGain("i", 1);
	urtaLove(.5);
	processTime(10);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

private function urtaDiscussessKatherine():void {
	clearOutput();
	var affection:int = flags["COC.KATHERINE_URTA_AFFECTION"];
	if (affection == 0) { //They’re just co-workers
		output("You ask Urta how her new recruit is doing.\n\n");
		output("“<i>Oh Katherine?</i>” she asks.  “<i>Really well.  I mean she still needs to brush up on the laws of the land and a few other things, but she’s doing fine.  Plus it’s nice to have a cat in the watch.  I had thought about saving her for undercover work, but I figure it’s better for everyone to see a cat who’s a good upright citizen.  There really aren’t that many and maybe some of the ones in gangs will rethink things when they see her on patrol.</i>”");
	}
	else if (affection == 1) { //They’ve never had sex together but each is aware you’re sleeping with the other if you're not in friends mode with Urta
		output("“<i>Heh, you really have a thing for ");
		//+ (telAdre.katherine.hasCock() ? "herms" : "girls in need") + 
		output(", don’t ya?</i>” she says with a smile.  “<i>Not that I’m complaining.  Anyway, in terms of her work she still needs to brush up on the laws of the land and a few other things, but she’s doing fine.  Plus it’s nice to have a cat in the watch.  I had thought about saving her for undercover work, but I figure it’s better for everyone to see a cat who’s a good upright citizen.  There really aren’t that many and maybe some of the ones in gangs will rethink things when they see her on patrol.</i>”");
	}
	else if (affection < 11) { //They’ve had drunken sex with you (can't get to this point in friend mode)
		output("“<i>Yeah Kath.  Well I can see why you like her.  Hot girl");
		//+ (telAdre.katherine.hasCock() ? " with a decent sized cock" : "") + 
		output(", gets a bit horny when she’s drunk.  What’s not to like?</i>”\n\n");
		output("She takes a swig of her drink and gives you a hug.  “<i>So, I just want to say I’m not unhappy having sex with you.  I mean that’s always great.  But, um, I gotta admit it’s really fun when you get the three of us together.  If you decide to do that again ... I’m in.</i>”");
	}
	else if (affection < 32) { //Willing to have sober sex
		output("“<i>Mmmm yeah Kath,</i>” she says dreamily, then shakes her head and laughs.  “<i>Guess that about sums things up, huh?  Yeah I like Kath, I like her quite a bit.  She’s a good watch officer and she’s a good lover in a threesome.</i>”  Urta looks a little nervous, but presses on.  “<i>So... what do you think of the two of us, when you’re not around, you know?</i>”\n\n");
		output("You could tell Urta not to have sex with Katherine except when you’re around, tell her it’s alright for them to have sex whenever they want or encourage them to fuck each other’s brains out.");
		processTime(2);
		clearMenu();
		addButton(0, "Don't Fuck", urtaKathSexDont);
		addButton(1, "Whenever", urtaKathSexWhenever);
		addButton(2, "Encourage", urtaKathSexEncourage);
		return;
	}
	else { //Lovers
		output("“<i>[pc.name], I can honestly say I never expected to have this much sex.  I love you, I love Katherine.  It’s a bit weird, but I’m not complaining and neither is she and I hope neither are you.  I’m not the same girl you found sitting alone in the bar.  I’m so happy now.</i>”");
	}
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

private function urtaKathSexDont():void {
	clearOutput();
	output("You give Urta a smile tell her that while you’re happy for her you’d really prefer if she waited for you to be around before banging Katherine.  You feel a little left out.\n\n");
	output("Urta gives you a weak smile and says, “<i>Alright [pc.name], I understand.  I’ll keep it in my pants.  Course I hope you’re up for a lot of three ways.  Girl’s got to get her fix.</i>”");
	//flags[kFLAGS.KATHERINE_URTA_DATE] = Katherine.KDATE_LITTLE;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

private function urtaKathSexWhenever():void {
	output("You put your arm around Urta and tell her that you don’t mind if your favorite girls need to blow off a little steam together.  As long as they don’t wear each other out that is.\n\n");
	output("Urta lets out a relieved laugh and says, “<i>That’s good.  That’s good.  I’ll make sure not to wear our kitten out.</i>”");
	//flags[kFLAGS.KATHERINE_URTA_DATE] = Katherine.KDATE_WHENEVER;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}

private function urtaKathSexEncourage():void {
	output("You ask Urta what she would say if you told her you flat out expect them to have sex when you’re not around.\n\n");
	output("“<i>Are you sure [pc.name]?  I mean I love the idea, I’m sure Kath will love it too, but you know what my appetite’s like.</i>”\n\n");
	output("You give her a kiss and tell her you know very well.  Since you’re not in town all the time you expect Urta to see to Kath’s needs and Kath to hers.\n\n");
	output("“<i>Carte blanche?  Ok [pc.name], but I’m warning you - your sex kitten is going to be very well fucked whenever you see her.</i>”");
	//flags[kFLAGS.KATHERINE_URTA_DATE] = Katherine.KDATE_LOTS;
	processTime(2);
	clearMenu();
	addButton(0, "Next", urtaDialogueMenu);
}