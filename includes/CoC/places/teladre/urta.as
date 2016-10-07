import classes.Characters.CoC.CoCUrta;
import classes.CockClass;
import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.DamageTypes.TypeCollection;
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
public function UrtaTimePassedNotify():void
{
	//var needNext:Boolean = false;
	//drainedByKath = false; //This var will only be set true after Kath licks Urta out - it stops you from going back immediately for more Urta sex
	//pregnancy.pregnancyAdvance();
	//trace("\nUrta time change: Time is " + hours + ", incubation: " + pregnancy.incubation + ", event: " + urtaPregnancyEvent());
	//if (flags["COC.NEED_URTA_LETTER"] == 1 && model.time.hours == 6) urtaPregs.getUrtaLetter(); //Urta Letters
	//if (pregnancy.incubation == 0 && (pregnancy.type == PregnancyStore.PREGNANCY_BEE_EGGS || PregnancyStore.PREGNANCY_DRIDER_EGGS)) {
		//pregnancy.knockUpForce(); //Silently clear Urta's egg pregnancy
		//flags["COC.URTA_EGGS"] = 0;
		//flags["COC.URTA_FERTILE_EGGS"] = 0;
	//}
	//if (flags["COC.URTA_TIME_SINCE_LAST_CAME"] > 0) Flag("COC.URTA_TIME_SINCE_LAST_CAME", -1, true); //Count down timer for urta's lust
	//if (flags["COC.URTA_EGG_FORCE_EVENT"] > 0) flags["COC.URTA_EGG_FORCE_EVENT"]--; //Countdown to urta freakout
	if (flags["COC.URTA_INCUBATION_EGGS"] < timeAsStamp) {
		flags["COC.URTA_INCUBATION_EGGS"] = undefined;
		flags["COC.URTA_INCUBATION_EGGS_TYPE"] = undefined;
	}
	
	if (hours == 0) {
		//if (Flag("COC.URTA_TIME_SINCE_LAST_CAME") == 0) IncrementFlag("COC.URTA_CUM_NO_CUM_DAYS");
		//else flags["COC.URTA_CUM_NO_CUM_DAYS"] = 0;
		if (flags["COC.URTA_PC_AFFECTION_COUNTER"] > 0 && flags["COC.URTA_PC_AFFECTION_COUNTER"] < 30) {
			flags["COC.URTA_PC_AFFECTION_COUNTER"] -= .5;
			if (flags["COC.URTA_PC_AFFECTION_COUNTER"] < 0) flags["COC.URTA_PC_AFFECTION_COUNTER"] = 0;
		}
	}
	if (minutes == 0) {
		//Urta egg freak out
		if (flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] > 1) {
			flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"]--;
			if (flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] < 1) flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] = 1;
		}
	}
}

private var UrtaTimePassedNotifyHook: * = UrtaTimePassedNotifyGrapple();
private function UrtaTimePassedNotifyGrapple():* { timeChangeListeners.push(UrtaTimePassedNotify); }

public function get urta():CoCUrta
{
	var _urta:CoCUrta = new CoCUrta();
	_urta.vaginas[0].bonusCapacity = flags["COC.TIMES_RUT_FUCKED_URTAS_CUNT"] == undefined ? 0 : Math.min(flags["COC.TIMES_RUT_FUCKED_URTAS_CUNT"] * 5, 40);
	if (flags["COC.URTA_TENTACLE_GAPED"] > 0) _urta.vaginas[0].bonusCapacity = 500;
	_urta.ass.bonusCapacity = _urta.vaginas[0].bonusCapacity; // that's how it works originally...
	return _urta;
}

public function urtaIsPregnant(byPc:Boolean = true):Boolean {
	return flags["COC.URTA_INCUBATION"] != undefined;
}

public function urtaSprite():void {
	userInterface.showName("\nURTA");
}

public function urtaCapacity():Number {
	return urta.vaginalCapacity();
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
	if(flags["COC.URTA_PC_LOVE_COUNTER"] == 1) {
		//Queue up Amily madness
		//Only happens if freakout hasn't happened yet.
		if(love > 0 && int(flags["COC.AMILY_VISITING_URTA"]) == 0 && amilyFollower() && flags["COC.AMILY_FOLLOWER"] == 1) flags["COC.AMILY_NEED_TO_FREAK_ABOUT_URTA"] = 1;
		return true;
	}
	else return false;
}

public function urtaAvailableForSex():Boolean { return urtaFuckbuddy() && scyllaAction != SCYLLA_ACTION_FUCKING_URTA && int(flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"]) == 0; }

public function urtaFuckbuddy():Boolean { //Returns true if Urta is either the player's fuckbuddy or lover
	if (urtaBusy() || flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] == -1) return false;
	if (urtaJustFriends()) return false;
	return (flags["COC.TIMES_FUCKED_URTA"] > 0);
}

public function urtaJustFriends():Boolean { return Flag("COC.URTA_COMFORTABLE_WITH_OWN_BODY") == 0 && flags["COC.URTA_PC_LOVE_COUNTER"] == -1; }

public function urtaAtBar():Boolean { //Is Urta physically at the Wet Bitch?
	return (!urtaBusy() && flags["COC.AMILY_VISITING_URTA"] != 1 && hours > 4 && hours < 15 && flags["COC.KATHERINE_UNLOCKED"] != 3);
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
	if(flags["COC.UNKNOWN_FLAG_NUMBER_00145"] > 0) return true;
	//Did it come out from marble?
	if(flags["COC.URTA_KNOWS_PC_HAS_MARBLE_FOLLOWER"] > 0) return true;
	//Did it come out from discussions?
	if(flags["COC.URTA_OPEN_ABOUT_EDRYN"] > 0) return true;
	return false;
}

public function knockUpUrtaChance():void { //Moved here from UrtaPregs since it needs to be accessed from outside Urta
	//GTFO IF PREGGO
	if (flags["COC.URTA_INCUBATION"] != undefined) return;
	if (flags["COC.URTA_INCUBATION_EGGS"] != undefined) return;
	//GTFO IF NOT FERTILE
	if (flags["COC.URTA_FERTILE"] != 1) return;
	if (pc.virility() <= 0) return;
	//10% + up to 40% @ 1000mLs of cum, with bonus virility!
	var chance:Number = 10 + Math.min(pc.cumQ() / 25, 40);
	//Bonus virility time!
	chance = Math.min(chance * pc.virility(), 75);
	//FINAL ROLL!
	if (chance > rand(100)) {
		//pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, 384);
		flags["COC.URTA_INCUBATION"] = timeAsStamp + 384 * 60;
		flags["COC.URTA_PREGNANT_DELIVERY_SCENE"] = undefined;
		trace("Urta preg!");
	} else trace("Urta NO preg!");
}

public function urtaBarDescript():Boolean {
	output("\n\n");
	//Urta PISSED
	if(flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] > 1) {
		output("Urta is sitting at a table, swishing a bottle around and looking forlorn.  She glances up and sees you, then immediately turns away.");
		return false;
	}
	//	[PISSED URTA TALK]
	//	Urta looks up at you and growls, \"<i>Do I look like I want to talk to you right now? Fuck off.</i>\"
	//[Post Pissed Talk]
	if(flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] == 1) {
		output("Urta is sitting at a table, swishing a bottle around and looking forlorn.  She looks up at you and sighs, \"<i>Look, I still don't think we'll ever be the same, but to be frank, we're great in the sack and I've been lonely.  For now, I'll put the past behind me.</i>\"");
		flags["COC.URTA_ANGRY_AT_PC_COUNTDOWN"] = undefined;
		return true;
	}
	//Raphael betrayed reward
	if(flags["COC.RAPHEAL_COUNTDOWN_TIMER"] == -1 && flags["COC.UNKNOWN_FLAG_NUMBER_00148"] == 0) {
		output("Urta has an ecstatic grin plastered across her muzzle, and it only gets wider when she sees you.  Perhaps you should see what all the fuss is about?");
		return true;
	}
	// something with Amily
	if(flags["COC.UNKNOWN_FLAG_NUMBER_00350"] == 1) {
		output("Urta is sitting at her usual table, holding her head in her hands.  She doesn't even seem to notice you.");
		return true;
	}
	//[URTA ASHAMED]
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] == -1) {
		output("You see Urta on a bench in the corner with her legs crossed nervously.  Her tail is curling tightly around her leg, hiding the massive surprise between her legs.  In her hand is a mostly empty bottle of whiskey.  She's wobbling back and forth in her seat, and keeping her head down, refusing to meet your gaze any time you spare a glance her way.  It looks like she wants nothing to do with you.");
		return true;
	}
	//Post Scylla Appearance
	if(flags["COC.UNKNOWN_FLAG_NUMBER_00145"] == 0 && flags["COC.UNKNOWN_FLAG_NUMBER_00143"] > 0) {
		output("Urta's at her normal table, nursing a glass of water with nary a bottle of alcohol around.  She's fidgety and constantly glancing your way, but she never meets your eyes or acknowledges that she saw you.  Something is eating away at her.");
		return true;
	}
	//PREGNANT URTA
	//if (pregnancy.isPregnant) {
	if (flags["COC.URTA_INCUBATION"] != undefined) {
		urtaPregAppearance();
		return true;
	}
	else if(flags["COC.URTA_INCUBATION_EGGS"] != undefined) { //Egg-Stuffed Urta:
		//This replaces the normal "display" for Urta in the Wet Bitch screen
		///This scene lasts for the duration of Urta's egg pregnancy, whatever that is
		//Egg Level 1:
		if (flags["COC.URTA_EGGS"] < 20) output("Urta is sitting quietly at her usual seat, sipping a mug of some non-alcoholic beer.  Though her clothes are still in place, you can just make out the bulging midriff stretching them taut, a consequence of all the eggs in her womb.");
		else if (flags["COC.URTA_EGGS"] < 40) output("Urta is sitting rather uncomfortably at her usual seat.  Her swollen stomach is so large it keeps her from wearing her usual outfit, instead forcing her into a mini-shirt and a skirt bottom, allowing her midriff to be bare.  She occasionally runs a hand over the expanse, as if she can't believe it's actually there.");
		//Egg Level 3:
		else output("Urta's bloated belly forces her to sit side-saddle at her usual table, the lumpy, egg-stuffed mass ballooning out in front of her.  Forced into a midriff-baring ensemble, she frequently touches it, occasionally seeming to trace an egg through the taut skin.");
		return true;
	}
	//Eggs Laid:
	//This replaces the normal "display" for Urta in the Wet Bitch Screen
	//This scene only appears once, after Urta's "pregnancy" is over
	if (flags["COC.URTA_TIMES_EGG_PREGGED"] > 0 && flags["COC.URTA_INCUBATION"] == undefined && flags["COC.URTA_INCUBATION"] == undefined && flags["COC.URTA_FLATBELLY_NOTICE"] == 0) {
		output("Urta is seated at her usual spot in her usual dress, eagerly chugging down mug after mug of booze; her belly is washboard-flat again, and she's clearly making up for lost time after having given up alcohol for her 'pregnancy'.");
		flags["COC.URTA_FLATBELLY_NOTICE"] = 1;
		return true;
	}
	//[Love Urta Bar Appearance]
	if(flags["COC.URTA_PC_LOVE_COUNTER"] == 1) {
		if(flags["COC.URTA_ALCOHOL_HABIT"] == -1 || !urtaDrunk()) output("Urta is sitting at her usual table, sipping a glass of wine and wearing a form-fitting evening gown of shimmering black.  She looks up at you, happiness filling her eyes when she notices you entering the bar.");
		//(DRUNK)
		else output("Urta is sitting at her usual table wearing a shimmering black dress.  She's pretty clearly sloshed judging by her bleary gaze as she looks up at you.  The front of her dress visibly tents, and she waves you over with a lecherous grin.");
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
	if(flags["COC.RAPHEAL_COUNTDOWN_TIMER"] == -1 && int(flags["COC.UNKNOWN_FLAG_NUMBER_00148"]) == 0) {
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
	if(int(flags["COC.UNKNOWN_FLAG_NUMBER_00145"]) == 0 && flags["COC.UNKNOWN_FLAG_NUMBER_00143"] > 0) {
		flags["COC.UNKNOWN_FLAG_NUMBER_00145"] = 1;
		output("The apprehensive fox-morph's gaze lurches up at the sound of your approach, eyes going wide with nervousness.  Clearly she remembers her inebriated encounter with Scylla and is a little worried about the implications.  You sidle up to the table and look her in the eye questioningly – she must have something to say.\n\n");

		output("\"<i>I... I want to apologize for the other night.  ");
		//(variant I: Love)
		if(urtaLove()) output("I got drunk, I got horny, and Scylla kept offering.  I've turned her away so many times, but she looked so... hungry, like, sexually ravenous, and I lost control.  I love you [pc.name].  I've never had a relationship like this and it's hard being apart from you – so very hard.  I-I'd understand if you didn't want to see me anymore, but if you think about it, we could have a LOT of fun together.  If you want I'd do everything possible to avoid this happening again, even cutting back on my drinking.  Please, I love you.");
		//(variant II: Comfortable Fuckbuddies)
		else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("I got really drunk, and well, Scylla is very, very sexy.  In this day and age having multiple partners doesn't raise that many eyebrows, but I know where you're from and I'd understand if you didn't like what happened.  It doesn't excuse my actions though, I definitely should've brought this up before now, and I-I'd understand if its made you doubt my judgement enough to never want to see me again.  Before you say anything, being with you... it changed my life.  You've given me back confidence and comforted me in ways no one has before.  If I have to cut back on my drinking and have someone drag me out of the room every time Scylla is around to stay with you, I will.  Please, don't leave me.");
		//(variant III: Still Nervous)
		else output("I was so drunk and horny, and Scylla... she's very persuasive.  Y-you've been the only one to like me for me, even with this... this thing between my legs.  Having someone else want it when you're drunk and horny... I couldn't say no.  S-sometimes I just... NEED to cum.  And she said you'd let her help you before so I thought you'd be okay with it.  But now that I've had a chance to think on it... are you okay with it?  Please, don't just walk away from me... from us.  I'll curb my drinking if I have to.  I'll even pay someone to keep an eye on me while I drink if I have to.  Just.. what do you want me to do?");
		output("</i>\"\n\n");

		output("She snaps her mouth shut and looks at you ");
		if(urtaLove()) output("with a worried expression");
		else if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 12) output("anxiously");
		else output("nervously");
		output(" while she awaits your reply.  It seems you could tell her to stay away from Scylla, enjoy Scylla, or just tell her you don't want to see her again.  What do you do?");
		//[No Scylla] [Scylla Okay] [Leave Her]
		clearMenu();
		addButton(0, "No Scylla", tellUrtaNoMoreScylla);
		addButton(1, "Scylla Okay", tellUrtaMoreScyllaIsFine);
		addButton(2, "Leave Her", leaveUrtaAfterScyllaConfrontation);
		return;
	}
	//TO ZE FLIPOUT!
	if(flags["COC.URTA_EGG_FORCE_EVENT"] < timeAsStamp && flags["COC.URTA_EGG_FORCE_EVENT"] != -1) {
		urtaChewsOutPC();
		return;
	}
	if (canTalkToUrta()) { //Katherine training discussion
		talkToUrta();
		return;
	}
	//PREGNANT URTA
	if (flags["COC.URTA_INCUBATION"] != undefined) {
		urtaPreggoApproached();
		return;
	}
	//HERE WE GOEZ!
	if(flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 5 && ((pc.hasStatusEffect("Rut") && pc.hasCock()) || (pc.hasStatusEffect("Heat") && pc.hasVagina())))
	{
		if(urtaDrunk()) approachDrunkenUrta();
		else approachSoberUrtaHeatRutProc();
		return;
	}
	//[URTA FRIEND FUCKBUDDY BUT UNHORNY]
	if(flags["COC.URTA_TIME_SINCE_LAST_CAME"] > timeAsStamp && !urtaDrunk()) {
		//output(images.showImage("urta-bar"), false);
		//Twu wuv talk
		if(flags["COC.URTA_PC_AFFECTION_COUNTER"] >= 30 && flags["COC.URTA_PC_LOVE_COUNTER"] == undefined) {
			UrtaTwuWuvOffer();
			return;
		}
		//output("You approach Urta, who gives you a friendly smile and begins talking with you.  Thanks to her unusual endowments, it's easy to tell she's not quite in the mood.  The conversation is still pleasant though, and the two of you knock back a few ales while Urta recounts some of the wilder scenarios she's encountered as the captain of Tel'Adre's guard.");

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
			if (flags["COC.URTA_TIME_SINCE_LAST_CAME"] + 3 * 24 * 60 < timeAsStamp) 
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
		//CUT FOR NOW output("throw you over the table and fuck you,");
		output("let the beast loose and bounce you on my lap while we drink, ");
		output("jerk off onto your face in front of everyone, or have to remember your ass for later when you bolt for the door.  What'll it be, hun?</i>\"");
		clearMenu();
		addButton(0, "Jerkoff", getAPublicFacialFromUrta);
		if (pc.cor() < 33 && pc.exhibitionism() < 33) addDisabledButton(1, "Anal Ride", "Anal Ride", "No way!  You're not going to do that in front of EVERYONE.");
		else addButton(1, "Anal Ride", takeUrtaInTheButtPublically);
		
		if(pc.canOviposit() && pc.eggs >= 10) {
			if(int(flags["COC.URTA_TIMES_EGG_PREGGED"]) == 0) output("\n\nHmm... sounds like she wants to fuck almost as badly as you want to get these eggs out of you.  Besides, didn't Urta say to you once that she's basically barren and sterile?  You'd be doing her a favor by letting her carry your eggs, wouldn't you?  Let's see if she's drunk enough to let you fill her full...");
			addButton(2, "Lay Eggs", giveTheFoxSomeEggs);
		} else addDisabledButton(2, "Lay Eggs", "Lay Eggs", "This scene requires you to have ovipositor and eggs.");
		
		if((pc.hasCock() && pc.cockThatFits(urtaCapacity()) >= 0) || pc.hasKeyItem("Deluxe Dildo"))
			addButton(3, "Spank Her", spankTheShitOutOfUrtaAndMakeHerCreamHerselfFromProstateStimulationAloneLikeTheHornyDrunkenSlutSheReallyIs);
		else addDisabledButton(3, "Spank Her", "Spank Her", "This scene requires you to have fitting cock or Tamani's dildo.");
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
	if(pc.canOviposit()) {
		if(int(flags["COC.URTA_TIMES_EGG_PREGGED"]) == 0) output("\n\nYou contemplate asking Urta to help you take a load off your abdomen, but decide against it; Urta's probably too shy and pent up to let you fill her with your eggs. Maybe when she's gotten herself drunk and is more pliable, though...");
		else output("\n\nYou don't think it's likely Urta would agree to host your eggs in her present state; wait until she's turned down her inhibitions before asking.");
	}
	//[Under Table BJ] [Public Jerkoff onto your face] [Public Buttfucking (Receiver)] [Tender lovemaking @ Urtas] [Minotaur Cum-Addict Special?] [TABLE FUCK]
	//simpleChoices("Hidden BJ",blowUrtaUnderTable,"Urta's Place",goBackToUrtasForLuvinz,"",0,"",0,"Leave",barTelAdre);
	clearMenu();
	addButton(0, "Urta's Place", goBackToUrtasForLuvinz, null, "Urta's Place", "Go to Urta's apartment for sex.");
	if (flags["COC.URTA_TIME_SINCE_LAST_CAME"] + 3 * 24 * 60 < timeAsStamp) addButton(1, "Hidden BJ", slurpFawkesCocksForFunAndInflation, null, "Hidden BJ", "Suck Urta's dick until she cums! \n\nNote: Given how long she hasn't relieved, this is most likely going to fill your belly.");
	else addButton(1, "Hidden BJ", blowUrtaUnderTable, null, "Hidden BJ", "Suck Urta's dick until she cums!");
	addButton(14, "Leave", barTelAdre);
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
	if (flags["COC.KATHERINE_UNLOCKED"] >= 4) addButton(5, "Katherine", urtaDiscussessKatherine);
	if(urtaKids() > 0 && !pc.hasKeyItem("Spare Key to Urta's House"))
	addButton(4, "Visit Kids", visitKidsFirstTime);
	//else
	if (flags["COC.FIRST_TIME_AT_URTA_HOUSE"] > 0) addButton(4, "Her House", talkToUrtaAboutHerHouse);
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
		addButton(0, "Infertility", infertilityQuestions);
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
	//if(flags["COC.URTA_PREG_EVERYBODY"] == 1) {
		//output("\n<b>Urta thinks you're okay with her 'sharing the love (and kids)' with any other sexual partners she might have.</b>");
		//addButton(1, "No Preg", urtaPregOthersToggle);
	//}
	//else {
		//output("\n<b>Urta will not knock up or be knocked up by anyone else unless you tell her otherwise.</b>");
		//addButton(2, "Share Preg", urtaPregOthersToggle);
	//}
	//output("\n\n<b>(Note: There is no content for Urta to impregnate or be impregnated by other NPCs, yet.)</b>");
	addButton(1, "Back", urtaDialogueMenu);
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
	if (!urtaLove()) {
		output("You tell Urta that you'd like to learn about her family.  What are her parents like?  Does she have any siblings?  Is she the only hermaphrodite in the family?");
		//(Regular
		if (!urtaLove()) {
			if (int(flags["COC.URTA_FAMILY_TALK_ATTEMPTS"]) == 0)
				output("\n\nUrta winces, eyes starting to grow damp with unshed tears.  However, then she stares at you fiercely.  \"<i>I don't want to talk about them,</i>\" she growls.");
			else
				output("\n\nShe gives you a cold stare, making it quite clear she's still not inclined to discuss them.  Whatever the story is, it must be pretty painful.");
		}
		//(Lover, First Time:
		else {
			if (int(flags["COC.URTA_FAMILY_TALK_ATTEMPTS"]) == 0) output("\n\nUrta sighs softly, closing her eyes sadly.  She stares fixedly into her glass.  \"<i>Please... not that. I'll talk about anything else, but not that,</i>\" she tells you.");
			//(Lover, Subsequent:
			else output("\n\nUrta shakes her head slowly.  \"<i>No.  It's... a painful topic - one I'd rather forget than relive.</i>\"");
		}
		output("\n\nYou apologize and change the topic.");
		//[The other Urta dialogue option buttons appear at the bottom of the screen]
		urtaDialogueMenu();
	}
	else {
		talkWithUrtaAboutFamFam();
	}
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
	flags["COC.KATHERINE_URTA_DATE"] = KDATE_LITTLE;
	processTime(2);
	urtaDialogueMenu();
}

private function urtaKathSexWhenever():void {
	clearMenu();
	output("You put your arm around Urta and tell her that you don’t mind if your favorite girls need to blow off a little steam together.  As long as they don’t wear each other out that is.\n\n");
	output("Urta lets out a relieved laugh and says, “<i>That’s good.  That’s good.  I’ll make sure not to wear our kitten out.</i>”");
	flags["COC.KATHERINE_URTA_DATE"] = KDATE_WHENEVER;
	processTime(2);
	urtaDialogueMenu();
}

private function urtaKathSexEncourage():void {
	clearMenu();
	output("You ask Urta what she would say if you told her you flat out expect them to have sex when you’re not around.\n\n");
	output("“<i>Are you sure [pc.name]?  I mean I love the idea, I’m sure Kath will love it too, but you know what my appetite’s like.</i>”\n\n");
	output("You give her a kiss and tell her you know very well.  Since you’re not in town all the time you expect Urta to see to Kath’s needs and Kath to hers.\n\n");
	output("“<i>Carte blanche?  Ok [pc.name], but I’m warning you - your sex kitten is going to be very well fucked whenever you see her.</i>”");
	flags["COC.KATHERINE_URTA_DATE"] = KDATE_LOTS;
	processTime(2);
	urtaDialogueMenu();
}

//[Back Room]
public function scyllaAndUrtaSittingInATree():void {
	urtaSprite();
	clearOutput();
	//Increment 'times caught with Scylla'
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00143");
	
	if (!urtaDrunk()) {
		urtaAndScyllaBoningLikeBitchesSober();
		return;
	}
	
	clearMenu();
	
	if (int(flags["COC.UNKNOWN_FLAG_NUMBER_00147"]) == 0 && flags["COC.UNKNOWN_FLAG_NUMBER_00145"] > 0)
	{
		output("You meander towards the back-rooms and a canine waitress springs forward with a key clutched in her paw.  She blushes furiously and explains that she was tipped generously to hand it to you if you arrived.  You accept the proffered tool and smile.  It must be cheaper to pay someone to wait with a key than to fix the door each time the three of you meet up!  You snicker to yourself as you plunge the key into the lock's waiting receptacle, turn it, and push your way inside.  The scene in front of you is as arousing as it is familiar.\n\n");

		output("Urta is sitting down on a crate with her legs splayed and her torso leaning drunkenly in your direction.  Her tongue is hanging out and her eyes are lidded from alcohol as she notices you and gives another high-pitched whine, not of pain, but pleasure.  The source of her 'distress' is a black-robed figure with curly black locks of hair that hang around her head like a halo and thick, glossy red lips.  Those same lips are currently wrapped firmly around Urta's twitching, lust-swollen horse-cock just above her sheath.  You can clearly see the slight bulge of Urta's medial ring highlighted through the corrupted nun's neck as she bobs up and down, so absorbed in feeding her addiction that she failed to notice your entrance.\n\n");

		output("The fox is giving you a lewd look as she cradles Scylla's head in her hands and pushes down.  She slurs, \"<i>Oooooh YEAH!  Mmmmm, you made it " + pc.short + "!  It seems like each time Scylla does... does... oooh... this I cum bigger and harder.  MMmmmm so good... wanna watch?</i>\"\n\n");

		output("Throughout the conversation she's weakly twitching her pelvis, rocking her hips against Scylla's face while her balls start to swell and churn in the nun's hands.  You close the door behind you carefully and drop the key on a crate.  It's time for some fun.\n\n");

		// Butans
		if (pc.cockThatFits(urtaCapacity()) != -1 && !pc.isTaur())
			addButton(0, "Lap", makeUrtaSitOnYourLapWithScylla, undefined, "Lap", "You could make Urta sit on YOUR lap for a change.");
		else addDisabledButton(0, "Lap", "Lap", "This scene does not accomodate taurs.");

		addButton(1, "Jerk", watchTwoHotBitchesAndJerkIt, undefined, "Jerk", "You could jerk off and watch.");
		addButton(2, "LippleBond", lippleBondUrtaScylla, undefined, "Lipple Bond", "Bonding with the use of Scylla's lipples is also an option.");
	}
	else
	{
		output("You meander by the Wet Bitch's back rooms, trying not to look like a creeper as you listen for ");
		if (!urtaLove()) output("Urta");
		else output("your love");
		output("'s voice.  The first few doors are silent and the next one sounds to have a spirited game of strip-poker going on inside it.  Judging by the grunts and occasional mewling moan of pleasure, some poor girl has already lost.  One of the barmaids gives you a warning glance and you keep moving, sure to avoid the lewd game of chance as you hunt for the stray, well-endowed fox.\n\n");

		output("At first, the following entryway is silent, though you can see light underneath.  You're just about to move on from the portal when you hear Urta's voice give out a strained grunt.  Did some ");
		if (pc.cor() < 40) output("corrupted ruffians");
		else output("demon agents");
		output(" somehow get the drop on her?  She whines, high-pitched and plaintive, almost as if she was wounded, and you cannot wait a moment later.  You lunge to the door, twist the handle, and find it locked.  Without a second thought, you throw your weight into the flimsy wood paneling and crash through to the last thing you expected to see!\n\n");

		output("Urta's sitting down on a crate with her legs akimbo and her torso leaning drunkenly in your direction.  Her tongue is hanging out and her eyes are lidded from alcohol as she notices you and gives another high-pitched whine, not of pain, but pleasure.  The source of her 'distress' is a black-robed figure with curly black locks of hair that hang around her head like a halo and thick, glossy red lips.  Those same lips are currently wrapped firmly around Urta's twitching, lust-swollen horse-cock just above her sheath.  You can clearly see the slight bulge of Urta's medial ring highlighted through the corrupted nun's neck as she bobs up and down, so absorbed in feeding her addiction that she failed to notice you bursting through the door.\n\n");

		output("The fox is ");
		if (urtaLove()) output("weakly protesting");
		else if (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("giving you a lewd look");
		else output("blushing hard");
		output(" as she cradles Scylla's head in her hands and pushes down.  She slurs, \"<i>");
		if (urtaLove()) output("I'm... ahhhh... s-sorry love, but we both know she's been suuuu - oh yeah, keep licking - sucking you off before, and the hungry slut just couldn't take her eyes off my cock.  Why didn't you tell me ho - OH YES!  RIGHT THERE! - h-how good she was?");
		else if (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 11) output("Ohhh, you showed up a little late... mmmhmm yes, now lick... Oh, why didn't you tell me ho - OH YES!  RIGHT THERE! - h-how good of a cock-sucker this lewd-bodied bitch was?");
		else output("H-hi " + pc.short + "... I didn't think I'd get to see you to- Oh yeah, like that!  Mmmm... OH!  I guess since we've been intimate before you can watch...");
		output("</i>\"\n\n");

		output("Throughout the conversation she's weakly twitching her pelvis, rocking her hips against Scylla's face while her balls start to swell and churn in the nun's hands.  Thankfully the doorway is at such an angle that the bulk of the bar can't see inside, and it helps that no one seems inclined to bother the three of you for now.  What do you do?\n\n");

		// Butans
		if (pc.cockThatFits(urtaCapacity()) != -1 && !pc.isTaur())
			addButton(0, "Lap", makeUrtaSitOnYourLapWithScylla, undefined, "Lap", "You could make Urta sit on YOUR lap for a change.");
		else addDisabledButton(0, "Lap", "Lap", "This scene does not accomodate taurs.");

		addButton(1, "Jerk", watchTwoHotBitchesAndJerkIt, undefined, "Jerk", "You could jerk off and watch.");
		addButton(2, "LippleBond", lippleBondUrtaScylla, undefined, "Lipple Bond", "Scylla also has two pairs of lips unoccupied - playing with them could lead to something interesting.");
		addButton(3, "Heartbreak", heartBreakHotelInTelAdre, undefined, "Heartbreak", "You could tell Urta you never want to see her again.");
		addButton(4, "Leave", flipUrtaTheBird, undefined, "Leave", "You could throw them the finger and leave.");
	}
}

//Sober repeat Urta x Scylla
private function urtaAndScyllaBoningLikeBitchesSober():void {
	clearOutput();
	output("You meander towards the back rooms and a canine waitress springs forward with a key clutched in her paw.  She blushes furiously and explains that she was tipped generously to hand it to you if you arrived.  You accept the proffered tool and smile.  It must be cheaper to pay someone to wait with a key than to fix the door each time the three of you meet up!  Snickering to yourself as you plunge the key into the lock's waiting receptacle, you turn it and push your way inside.  The scene in front of you is as arousing as it is familiar.");
	output("\n\nUrta is leaning back against a wall for support, her breasts heaving as she gulps in deep lungfuls of air, ebony nipples hard and puckered with lust.  Her eyes have the bright glimmer of sobriety this time, though it's hard to pick out under her heavy lids and eyelashes.  An onyx-robed figure blocks your view of your foxy lover's well-endowed groin, though the two ram-like horns that curl around the crotch-height head clearly mark the second party as the tainted nun, Scylla.  She's bobbing up and down with practiced ease, even though her plump, ruby lips are smushed up against the vixen's loins.  Her throat must be absolutely stuffed with horse-dick, and indeed, as you walk closer, you can see the thick medial ring bulging the nun's neck obscenely.");
	output("\n\nUrta shudders as she notices you, her black lips curling back into a happy grin at your appearance.  \"<i>Oh, [pc.name], you made it!</i>\"");
	output("\n\nScylla's blue eyes crane up to you, and she gleefully gurgles, \"<i>Mrmmmphh hrmmppphh!</i>\"  ");
	if (silly) output("For some reason, it makes you think of mythical balloonicorns.  ");
	output("Drool bubbles out the corner of her inhumanly-plump, practically-inflated lips as she tries to vocalize her happiness at seeing you here; long strands of it sway with her unceasing motions.  The creamy, alabaster skin on the nun's cheeks colors the bright red of embarrassment as you admire her dedication to dick-sucking.  Hollowing, that same skin forms into deep divots as the nun starts to suck, eyes crossing to admire the trembling column of horse-cock before her when she pulls back.  Urta's strong fingers involuntarily seek out the nun's horns, and she pulls the suckling blow-job slut's crimson cock-hole back into place, flush against her fur once more.");
	output("\n\nThe gray-furred fox moans, \"<i>Oh yeahhh, you like that, don't you, hungry girl?</i>\"  She giggles nervously after the declaration and looks your way, embarrassed at her own forwardness.  You grin at your vulpine ");
	if (!urtaLove()) output("fuck-buddy");
	else output("lover");
	output("'s lusty slip-up and skittish responses, pinching her booty for good measure while you decide just how to get involved in the potential <i>ménage à trois</i>.");
	applyDamage(new TypeCollection( { tease : 10 + pc.libido() / 5 } ), urta, pc);
	output("\n\nWhat do you do?  With Scylla involved, it's sure to get out of hand.");
	
	//[Fuck Nun Nipple] [Fuck Urta] [Get Worshipped]
	if (pc.cockThatFits(urtaCapacity()) >= 0)
		addButton(0, "Fuck Fox", fuckUrtaWhileScyllaSucksSober, undefined, "Fuck Fox", "You could fuck the fox while she gets her oral pleasure.");
	//Get worshipped requires gigantic dong
	if (pc.biggestCockVolume() > urtaCapacity())
		addButton(1, "Worshipped", dockWithUrtaUnderScyllasSoberSupervision, undefined, "Worshipped", "You could whip out your gigantic cock and let the blowjob queen worship a REAL dick.");
	addButton(14, "Leave", barTelAdre, undefined, "Leave", "Just leave them alone.");
}

//Fuck Urta while scylla sucks sober
private function fuckUrtaWhileScyllaSucksSober():void {
	clearOutput();
	var x:int = pc.cockThatFits(urtaCapacity());
	output("You peel out of your straining equipment to free your [pc.multiCocks]");
	if (pc.balls > 0) output(" and [pc.balls]");
	output(", hauling out your sweaty, engorged meat.  Scylla, absorbed as she is with cum-thirst, doesn't seem to notice, though her nose twitches as the scent of your musky aroma mingles with the sex-stained air.  You gently squeeze behind the fox, folding her bushy, soft tail to the side and giving you something firm to support yourself when you let her flop back into you.  Her smooth fur feels wonderful on your [pc.chest] and she squirms and gyrates against Scylla's sucking mouth.  Fairly dripping with moisture, the fox's black-lipped sex grinds on you, resting atop [pc.oneCock], and your length is soon soaked with her heady, animalistic fem-spunk.");
	output("\n\nUrta pants, \"<i>Go on... nnn... j-just put it in already!</i>\"  You readily oblige the over-endowed beast-woman by guiding your length into the clutching vice of her nethers, shivering at the onslaught of electric bliss that rockets up your " + pc.cockDescript(x) + ".  You hilt inside her");
	if (pc.cocks[x].cLength() > 15) output(", clearly bulging her stomach with your sizeable cock");
	output(", sliding up into the slick, welcoming passage as if you always belonged.  Rivulets of liquid desire trickle from the stretched lips to run down ");
	if (pc.balls > 0) output("the front of your [pc.sack]");
	else output("your [pc.legs]");
	output(".  The gray-furred femme reaches back in an awkward hug, trying to hold you against her, speared together in the most intimate of embraces.");
	output("\n\nScylla, on her knees and forgotten, stops her happy gurgles as the fox's prodigious flow of potent pre-cum thickens perceptibly.  The salty tang on the nun's tongue awakens something lost within her, buried and hidden deep inside.  Her beautiful blue eyes darken, the sclera going black around her azure irises, entrapping them in a sea of all-consuming onyx.  The very tips of the corrupted nun's horns glow midnight purple, and almost imperceptibly, they grow longer, curling around to prod Urta's delicate, unsuspecting balls.  Two sharp divots form in the furry sack as the glow fades.  Urta's pleasure-drunk moans jump an octave at the same time, leaving you to wonder at what's going on.");
	output("\n\n\"<i>Ow!  Wha-what are you DOING!?</i>\" the confused vixen stutters, trapped between ");
	if (silly) output("a cock and a sharp place.");
	else output("your lusty bodies.");
	output("  The velvet glove clasping your " + pc.cockDescript(x) + " tightens without warning, accompanied by a full-body quake.  Urta's eyes roll back as some invisible force works through her, culminating in a muscular clench that you feel will pop your " + pc.cockDescript(x) + " clean off your body.  You grunt, grabbing hold of the fox's tits for stability and wince from the almost painful tightness of her snatch.  The moment seems to drag on forever, but then, the vixen slumps back into your arms, allowing you to support her sagging weight.");
	output("\n\nBeyond your sight, the fox-girl's soft-furred sack begins to round out, growing larger in spite of the sharp tip prodding hard at her balls. The delicate, plush nuts swell bigger, big enough to pull the skin around them tight, big enough to pull Urta harder onto your " + pc.cockDescript(x) + ", big enough to be painfully poked, on the verge of being pierced.  Urta's vocalizations take on a keening, banshee-like quality, but before any harm can be done, a rosy glow envelops the fox-herm's poor, brutalized sack.  Stranger still, the nun's ram-like protrusions shorten in response, actually withdrawing back into her skull, pushed back by your lover's impressive, seemingly magical testes.");
	output("\n\nScylla gasps when the fat nuts drape down onto her corruption-swollen tits.  Barely audible, wet sucking sounds can be heard, and you quickly realize that Scylla's lipples are kissing the swelling sack with obscene fervor, mouthily making love to her mistress's over-sized balls.  A long, rapturous gasp escapes Scylla's upper lips, and the nun looks up at the fox with confusion.  Wasn't she stretching her puffy cock-suckers into a delicious 'o' hard enough to make her jaw ache mere moments before?  Looking down, the habit-garbed blowjob-queen watches in horror as the equine thickness diminishes for every growth of the sloshing cum-jugs below.  The receding sheath escapes from its crimson prison, followed by a few inches of shortening shaft.");
	output("\n\nFor your part, you're oblivious to most of this.  All you notice is a flash of reddish light and an upsurge in your furry partner's tightness.  Indeed, her pussy seems to be going crazy, squeezing in waves that go from your [pc.sheath " + x + "] to your [pc.cockHead " + x + "].  She's moaning so hard and fast that there's barely time for her to gasp in fresh lungfuls of air, and she begins to saw her hips back and forth with reckless abandon, splattering your groin with slick wetness and face-fucking the hungry nun wildly, lost to her passion.");
	output("\n\nScylla seems confused by the magical mishap and attacks the diminishing horse-cock with ardor, slurping and suckling, her cheeks hollowing from the intense suction.  At the same time, Urta's balls swing down past her calves, and even though her muscles lock tight, she can no longer support the overmastering weight of her engorged cum-factories.  She lowers them the last few inches to the ground, relaxing atop her stretched sack while the growth continues unhindered.  Scylla grunts in irritation as the tiny horse-cock, barely nine inches long, pulls out of her throat, and she sticks out a strangely serpentine tongue in response.  It wraps the sheath like the world's slipperiest cock-ring, then slithers back up the animal endowment's length into her own mouth, twisting and slipping around to further the fox's pleasure.");
	output("\n\nMoaning, Urta whimpers, \"<i>S-so full... I - ungh - I... I can't hold it!  C-cuuuummmiiiiinnng!</i>\"  Her hips jerk forward hard and fast enough that it nearly pulls the gushing pussy off your " + pc.cockDescript(x) + ", but Scylla isn't so lucky.  Her nose is squished almost flat into the fox's sweaty middle-fur, chin deep in ballsack.  She doesn't seem to mind; in fact, when drizzles of frothing fluid appear at the crinkled corners of the nun's ruby lips, her eyes roll back, exposing the whites.  Meanwhile, Urta's less-than-colt-sized dong swells, but not as a return to its former glory.  No, if anything, her musky dick is still shrinking.  The sheer size of the cum-globs pumping through her urethra are visibly stretching her horse-cock, giving the illusion of increased size.");
	output("\n\nThe high pressure streams of alabaster goo splatter their way into the hungry nun's throat, and she drinks it down without complaint, seeming to orgasm just from the act of swallowing the salty jizz.  The pale woman's tongue disentangles itself from the horny herm's tiny, slick tool and wiggles back into her mouth, drawn back as she struggles to cope with it all.  Seeing the rapturous looks and feeling the silken-furred sack on your [pc.legs], you give in to the massaging vixen-cunt, seizing and shaking from head to [pc.foot] as you");
	if (pc.balls > 0) output("r [pc.balls]");
	output(" give the warm snatch a dose of virile medicine.  Urta, perhaps stirred from her own orgasm by the jets of hot fluid flooding her nethers, reaches back to squeeze your butt and whimpers, \"<i>Give it to me.</i>\"");
	output("\n\nYour body responds with a healthy squirt of fresh goo, pumping a wad of [pc.cumNoun] so fat from [pc.eachCock] that you have to wonder if you have any left.");
	if (pc.cockTotal() > 1) output("  The unbound portion of your package bobs in the air before coming to rest in Urta's ass-crack.  A second later, the vulpine butt is coated with [pc.cumVisc] [pc.cumColor] icing.");
	if (pc.lactationQ() > 50) output("  Your sensitive nipples let down, releasing their own heady flows to compliment your climactic pleasure, spraying into the gray fur relentlessly.");
	output("  Throughout it all, your " + pc.cockDescript(x) + " continues to do its level best to fill the fox.  Fireworks of uncontrollable pleasure go off one after the other, alternatively numbing and locking your muscles as you release all of your pent-up lusts, desires, and needs into the welcoming cunt.");
	if (pc.cumQ() >= 500) {
		output("  Urta's belly bloats from the thick deposit");
		if (pc.cumQ() >= 2000) output(", rounding more and more, a taut cum-tank that jiggles with your thick seed.");
		else if (pc.cumQ() >= 1200) output(", rounding out into a swollen cum-bank that jiggles under the weight of your seed.");
		else if (pc.cumQ() >= 750) output(", rounding out into a gravid bump that jiggles with liquid weight.");
		else output(", rounding out into a nicely-sized bump.");
		output("  You run your hands across it as you give a last few pumps.");
	}
	output("\n\nWhen your orgasm finally concludes, you slump back, limp but pinned in place by the liquid weight of the fox's sloshing ballsack and shaking femgasm.  Scylla is attached to her front like a sucking parasite, somehow keeping up with the unholy flow.  From around your lover's ");
	if (pc.tallness >= 78) output("head");
	else if (pc.tallness >= 48) output("narrow middle");
	else output("curvy hips");
	output(" you watch the nun's throat bulge almost double wide with each swallow of seed.  Tremendous volleys of semen are pumping down her esophagus rapidfire, and yet the suckling woman barely shows any sign of being full.  A clear puddle has sprung up underfoot, centered below the cock-sucker's crotch, and you marvel at the evidence of Scylla's pleasure.  She must be cumming non-stop!");
	output("\n\nEventually, the prick-vixen's shrinking member plateaus, perhaps four or five inches long inside the robed woman's gullet, and the barrel-sized testes begin to shrink, dwindling with every tremor of spunk that they expel.  Throughout the sordid encounter, Scylla's hungry tit-mouths never stop their slobbering.  Indeed, as she drinks, the lips become progressively bigger and more visible through the austere fabric.  Urta babbles with unrepressed happiness, barely conscious at this point but clearly pleased at the minutes-long orgasm she's working through.");
	output("\n\nThe vixen's shrinking balls pull away from you as they empty, and as soon as you're free, you slip out from behind the jizz-junkie and her prey, gently resting the furry fox and her outrageously virile orbs on the wall.  Scylla's swallowing slows as her belly begins to round, and you have to wonder if perhaps she's hit some kind of limit.  Does the cum-hungry blowjob queen even have one?  The trickles of cum that slip free of her sucking mouth-hole thicken into small rivers, and her robes quickly turn into a ivory-glossed mess.  You admire the view as you recover, and before your eyes, the swollen nutsack returns to normal, just in time for an end to the multi-minute jizz session.  Scylla's breasts have grown beyond normal measure, so big they might still touch the ground if the statuesque nun were to attempt to rise.  Her lip-nips are actually still sucking on the fox's testes, hiding most of it from view, but once it becomes clear that no more fluid is forthcoming, all three of her mouths disengage with slimy pops.");
	output("\n\nUrta slides down the wall into the puddle of fem-spunk, barely conscious and gasping for breath.  As you stretch out to limber up, she blinks a few times, confused.  \"<i>Wh-wha?  How!?  I... oh gods, I feel so empty.</i>\"  Her green eyes glance your way, and she gives you a searching look, asking, \"<i>How did I get so small?  This is great!  It'll be so easy to hide this!</i>\"  The tiny pony-dick answers this statement by lengthening, gradually hanging lower and lower.  Its girth increases as well, a barely visible change, but a change nonetheless.  Urta groans out in disappointment, \"<i>Damnit!  I should've known it wasn't permanent.</i>\"");
	output("\n\nBurping, Scylla demurely covers her mouth as her own transformations fade into normalcy.  Of course, in her case normalcy is being utterly stacked with lipples that clearly show through her cum-soaked robes.  She looks down at herself and tumbles over backwards, tits jiggling.  \"<i>I'm sorry, Urta, [pc.name]!  I got so very hungry.</i>\"  The panicked blue eyes ease as she continues, \"<i>But I'm full now.  So full... thank you, noble Captain.</i>\"");
	output("\n\nThe nun jumps up and hugs the exhausted fox tight.  Then, blushing, she quickly changes into a fresh habit and flounces out the door, taking the old, soaked one with her, perhaps for a snack.  Urta grumbles, \"<i>Go on, it's mostly my mess, so I suppose I ought to pay for the clean up.</i>\"  She props herself against a box as her equine member spontaneously gains a few inches, dripping fresh drops of pre.  Her balls seem to be back to normal too.");
	if (urtaLove()) output("  You give your lover a wet kiss and a fondle before you go, snickering when it makes her even longer.");
	else output("  You give her a quick hug and depart, smiling when you realize the brief touch made her even longer.");
	knockUpUrtaChance();
	//-2 sens, -100 lust
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("sen", -2);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Dock With Urta Under Scyllas Sober Supervision
private function dockWithUrtaUnderScyllasSoberSupervision():void {
	clearOutput();
	var x:int = pc.biggestCockIndex();
	output("Unable to contain yourself, you sigh heavily and release your [pc.gear].  Your immense package grows bigger with each beat of your heart, the blood-swollen veins pulsing hotly as they pump your cock to its full, obscene proportions.  It slowly undulates in the air as it fills to capacity with your lusty lifeblood, and the unmistakable aroma of your masculine ");
	if (pc.hasVagina()) output("half's ");
	output("musk fills the air.");
	if (pc.balls > 0) output("  Your [pc.sack] swings free, bouncing off the back of [pc.oneCock] when it thickens precipitously.");
	output("  Sighing with relief, you gently stroke your length as you eye the two beauties meaningfully.");
	output("\n\nUrta whimpers at the view, and she whispers, \"<i>[pc.name], you aren't going to put that in me are you?  You'd rip me in half, " + pc.mf("hunk","babe") + "!</i>\"");
	output("\n\nScylla looks wide-eyed at you and actually backs off her spit-soaked equine toy to stammer, \"<i>S-s-soooo big...</i>\"  She looks almost hypnotized by your throbbing meat, and she reaches out in a daze, letting her fingers trace one of the pulsating veins.  The now neglected vixen reaches down and grabs you in a two-handed grip.  Her gentle fingers and fluffy, silk fur tickle you deliciously as she raises your tip and crudely smacks it into Scylla's cheek.  The fox's aim is off, and all she manages is to drag your tip into the cock-hypnotized nun's hair.  Your dick travels on and flops heavily onto her shoulder, nearly knocking her over.  The hit is enough to rouse her from her stupor, and with strength that borders on demonic, she pushes Urta away and claims your " + pc.cockDescript(x) + " for herself.");
	output("\n\nFurry breasts press into your back, and a thick horse-cock ");
	if (!pc.isBiped() && !pc.isDrider()) output("slips along");
	else output("slides through");
	output(" your [pc.legs].  From behind, Urta wraps her arms around your [pc.chest] and snuggles her black lips into the nape of your neck.  A soft, whispered voice mutters, \"<i>You stole my blowjob.</i>\"  Long canines take a nip at your ear, and it muses, \"<i>But I know that nun has more than one way to swallow my rebellious little colt...</i>\"");
	output("\n\nWith grace that borders on feline, the fox leaps out around you, pouncing on the distracted nun.  Her hands roughly grope one of the orally addicted woman's gigantic, succubi-shaming tits, and with a triumphant snarl, Urta tears through the fabric protecting it like paper.  A mountain of creamy breast-flesh rolls into the prick-vixen's paws, marked in the center by a pair of glossy, ruby-lacquered lips.  You can't imagine that Scylla takes the time to apply make-up to her breasts, but you can't really explain the oiled crimson look she sports either.  The tit-mouth opens and closes repeatedly, switching beneath a gaping 'O' and a puckered smile that seems to beg for dick.");
	output("\n\nDuring all this, Scylla's hands are stroking along your " + pc.cockDescript(x) + " with delight that borders on rapture");
	if (silly) output(".  She even mentions something about how you can be her big daddy");
	output(".  No matter how many touches and caresses they place upon your tender rod, it barely seems to sate you.  Indeed, for every push of hand against cock, there seems to be more sensitive skin left neglected.  A malicious gleam glitters in the holy woman's crystal-blue eyes, and her slender fingers grab you harder, accelerating your growth.  Cock spools out of your groin like line from a reel, though in your case, you're getting longer AND thicker.");
	if (pc.balls > 0) output("  Your [pc.sack] stretches tight, totally  filled by the burgeoning testes concealed within.");
	output("\n\nThe nun whispers, \"<i>Bigger,</i>\" with a voice as smooth as satin.  She shimmies back a bit when it becomes too heavy to support, and you moan at the sensation of your overly abundant tool dragging across the floorboards.  They feel less like rough wood grain and more like a ribbed surface of a masturbatory aid.  You'd be alarmed over it, but it feels too good to fret over.  Besides, if there's anything to be concerned about, it's your immense size.  The tainted nun's horns, once playful little things, are now over a foot long and bowed with a sinister curve.  Behind them, a second set has sprouted that reaches down to her neck.  There may be more, hidden in the forest of lush curls, but you really can't tell, and your vision keeps being drawn back to your " + pc.cockDescript(x) + ".");
	if (pc.balls > 0) output("  You shift to let your bloated ball-sack breathe a little better as well.");
	output("\n\nUrta has the sense to stop and step back in alarm.  ");
	if (flags["COC.URTA_SCYLLA_BIG_DICK_TIMES_DONE"] > 0) output("Just like last time, she adopts a panicked expression and lunges for the door, but she moves slowly and a gooey drop of pre-cum hangs from her flare as she moves.");
	else output("With a panicked expression on her face, she lunges for the door, her hard cock flopping awkwardly.");
	output("  Scylla's eyes glow black as she reaches for the guardswoman, but she's too far away to even catch the fleeing fox's tail.  An inexplicable black radiance glows from the holy woman-turned-succubus's eyes, and miraculously, Urta is lifted clear of the floor, her legs flailing uselessly.  She flies back to the corner of the room and lands in a confused pile, less than a foot from your carriage-sized erection.");
	output("\n\nMeanwhile, your erection continues to grow unimpeded, and it now reaches across the smallish room, easily as tall as your waist and utterly immobilizing.  The magically restrained fox struggles, but semi-transparent tendrils of inky energy keep her seated.  They twist around her ears and turn her face, forcing her to look at your tumescent, oozing penis.  Directly in the center of your giant [pc.cockHead " + x + "] lies your plus-sized cum-slit, as big as a centaur's cunt and stretched wide by a dollop of your fragrant cock cream.  Urta is forced to watch it slowly roll out to puddle on the floor.  Her own erection, infantile by your new standards, rises fitfully, the flare filling to a full erection as Urta's body betrays her, overpowering her fear.");
	output("\n\nThe curvy nun saunters over to where the action is, wiggling her ass for good measure.  As horny as you are, you really don't need the encouragement, but you squirt a fresh wave of pre onto the floor regardless. Urta whimpers as she watches, her eyes locked on the lubricated hole before her.  She shakes with pent-up need but remains held back by phantasmal tentacles that tug at her nipples and caress her skin, driving her into a frenzy.  Scylla kisses the fox-girl full on the lips, her exposed tit swallowing the massive horse-cock as if by magic.  The wet oral embraces fill the air with the sounds of sordid sucking, and when the nun pulls back, the captain of the guard is humping the air like an animal with nothing but lust in her emerald eyes.");
	output("\n\nScylla gestures at your " + pc.cockDescript(x) + " and commands, \"<i>Go on, fuck it.  You know you want to.</i>\"  The black restraints poof into phantasmal smoke.  At the same time, your lusty hermaphrodite ");
	if (!urtaLove()) output("friend");
	else output("lover");
	output(" lunges forward, scattering the smokey haze in the split second it takes her to slam face-first into your dick.  A flat-tipped spear plunges through the goop plugging your urethra and into your cock, scattering streamings of stringy sexual juice in a fan around it.  To you, the penetration isn't painful in the slightest.  Your " + pc.cockDescript(x) + " is so big that the fox's own thick prick is a nice fit, and it feels like the slippery shaft is stroking you from the inside out, massaging nerve endings you didn't even know you had.");
	output("\n\nUrta grabs around the edges of your [pc.cockHead " + x + "] and pulls herself down, her fuzzy balls slapping wetly against the underside of your boner before pulling away again.  She starts kissing the top of your " + pc.cockDescript(x) + " with wild, unrestrained enjoyment.  Moving with the subtlety of a jackhammer, she pistons your inner hole wildly, grunting and moaning as she throws herself completely into debauchery.  The reluctant captain is fucking your immense member with abandon and shows no signs of stopping.  Scylla watches with detached amusement and idly climbs atop the column of jiggling dickmeat.  Her heavy udders press down on either side of your cock, but all she does is prop her face up on her hand and watch Urta fuck you hard enough to splatter pre-cum on everything in a five foot radius.  Thankfully, the movements cause your cock to flex and shift enough that the nun's inertia-bound breasts feel as if they're bouncing along the sides of your boner, unintentionally giving you a tit-fuck while your cock-pussy is inelegantly plowed.");
	output("\n\nUrta's apple-sized nuts pull tight against her body as she works your urethra, and somehow, she remembers that she ought to warn you.  \"<i>Can't stop!  G-g-gonna cuuuUUUUUM!!!</i>\" she screams, slamming her dick down with enough force to distort your [pc.cockHead " + x + "].  A moment later, you feel her swollen sack drag against your underside, and a warm explosion blooms inside your member.  The rushing white river runs through your length and into your body, giving you the oddest sensation of pleasant fullness and complete violation.");
	if (pc.balls > 0) output("  Your [pc.balls] quiver a little when the rushing seed reaches them, and you swear you hear them slosh with the horse-spunk pouring into their own reservoirs.");
	else output("  Your innards gurgle slightly as the rushing seed travels through them, and you swear you can feel your prostate stretching to accommodate being suddenly stuffed with horse-spunk.");
	output("\n\nSmall trickles of white gush from your tip, but Urta's flare is so engorged that it effectively seals most of your cock-tunnel, making it the perfect tool for her cum injection.  Her emerald eyes cross as she unloads, and Scylla coos, \"<i>Yes...</i>\"  The fox trembles for well over thirty seconds, shaking and pumping your dick full of her animal spooge, dominating it with her tiny dick's gushing goo.  Once she seems about finished, Scylla pinches one of Urta's hard black nipples, which sets the fox back to cumming like a firehose for another few moments.  After all of that, Urta glances back up at you with apologetic eyes, her lids heavy and tired.  Then, she slumps back to the floor, her cock dragging out along with a splash of white.");
	output("\n\nScylla immediately bounces off your leaky cock and onto the exhausted herm.  Her ruby lips glide down the equine cock with ease, even though it distorts her neck into a plainly visible cock-tube.  When she pulls back off, Urta's pink and black member glistens with spit, but not a single glob of cum remains upon it.  The fox whimpers at the sensation so soon after her orgasm, but once freed, she sags back with a sigh.");
	output("\n\nAt this point, Scylla's horns no longer resemble horns but rather a crown of twisted, thorny ivory.  The sclera of her eyes has gone solid black, and the only blue that remains is contained within a pair of lizard-like slits.  The demonic woman rounds on you, though she drops to her knees before your " + pc.cockDescript(x) + "'s immense girth immediately.  Her lips crush against your white-dripping cum-slut and begin to suck, but those plump cock-suckers are up to so much more.  You're aware of an increase in sensation on your [pc.cockHead " + x + "], and eventually determine that it must be caused by the nun's thickening pillows.  Her plump puckers push out, enveloping more and more of your cock with oily smoothness and warm spit while a foot long tongue lovingly rubs your underside.");
	output("\n\nYour " + pc.cockDescript(x) + "'s interior is emptied of its equine payload with a few quick sucks, but your pre soon replaces it, mixed with traces of the foreign load that swirls in your [pc.balls].  Groaning from your size-based bondage and the erotic assault you've had to weather, you begin to rub yourself, eager to push yourself over the edge and feed the beast across the room every ounce of a double shot of cum.  The demon-blessed holy woman can barely be seen over the top of your erection, yet she remains busy.  Her hands lift into the air, glowing with the same phantasmal blackness she displayed before, and dozens of insubstantial tentacles burst from the floor.");
	output("\n\nThey loop around your cock in an inky net of tight restraint.  Part of each tentacle disappears into your skin, but they remain tangible enough to feel hot and wet, like fingers of bubbling goo that stretch tight into a web of erotic delight.  They pulsate around you, thickening as your arousal rises lockstep with Scylla's hunger.  Driven on by your enhanced needs, you desperately rock your [pc.hips], but your frantic motions are useless, doing little to aid you.  Your " + pc.cockDescript(x) + " is so large that it's beyond your command or control. Instead, you focus on the feeling of Scylla's obscene mouth as it plumbs your cum-slit for its treasure, and before you know it, the black lattice-work of shadow-tentacles has merged into an ebony cavity that feels softer than a woman's cunt and as slippery as honey.  The whole thing moves back and forth slightly, stroking you off with Scylla's tongue, and an involuntary clench deep inside you signals that you can take no more - orgasm is at hand.");
	output("\n\nLike a firework, something fires off deep inside you, but the explosion of pleasure that rattles in your skull is nothing to sneeze at.  Your bliss seems to have a kinetic force that hits you hard enough to cross your eyes.  Unthinkingly, you open your mouth and scream");
	if (pc.balls > 0) output(" while your enormous balls gurgle and begin to empty");
	output(".  The titanic, room-filling cock lifts up off the ground by a few inches, supported by the thick bulge of cum that rushes from [pc.sheath " + x + "] to tip in an instant. It passes through the tight crimson seal, distending the nuns neck for a moment before it settles in her belly.  She looks almost pregnant on a mix of horse and champion-spunk for a moment, but then her belly narrows and her tits swell - just in time to take the next gush of your demonically-blessed orgasm.  Scylla appears to be in heaven, and as she swallows, the darkness leaves her eyes.  What remains is wide-eyed irresistible pleasure, and the vibrations of orgasmic screams vibrate through your swollen [pc.cockHead " + x + "] as you dump wave after wave of spooge through the clinging orifice.  A shiny puddle of feminine fluid widens beneath the nun's orgasm-wracked frame, and just once, you wish you could stick your head under her robes and watch it happen.");

	output("\n\nBefore long, the mixed jizz inflates Scylla's tits to a tremendous size, big enough to completely wrap around your titanic cock.  They each leak their own white mixture, though it smells more of milk than your cum.  Regardless, you pump out more semen with abandon, gunking up the poor nun's throat with seed and causing twin streamers of jizz to spurt from her nose.  Through it all, she continually swallows, hungrily devouring every drop of Urta-tainted spunk that can feed her.  Her throat bobs with gleeful delight, and you lose track of how long you spend orgasming, eventually blacking out when your poor, frazzled nerves can handle no more.");
	IncrementFlag("COC.URTA_SCYLLA_BIG_DICK_TIMES_DONE");
	//{-100 lust,+1 corruption, }
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("cor", 1);
	pc.cor(1);
	if (pc.maxCum() < 5000) pc.cumMultiplierRaw += 2;
	if (pc.balls > 0) pc.ballSizeRaw += 1;
	clearMenu();
	addButton(0, "Next", dockWithUrtaUnderScyllasSoberSupervision2);
}

//Dock With Urta Under Scyllas Sober Supervision2
private function dockWithUrtaUnderScyllasSoberSupervision2():void {
	clearOutput();
	output("You wake up with something sweet in your mouth, and as you swallow, you crack your eyelids.  White.  A gently shrinking expanse of creamy flesh fills your view, and you realize a pair of crimson lips are kissed against your own, feeding milk to your dry mouth.  You swallow gratefully and glance around, quickly discovering your gray furred companion similarly engaged.  The two of you swallow your fill and detach, feeling a little confused and miraculously, still horny.");
	output("\n\nScylla smiles and burps while her breasts continue to dwindle, pausing when they're just large enough to be improbably big for the woman's large frame.  She gushes, \"<i>Thank you guys so much!  I don't know what I'd do if I had to have some... stranger to help me deal with this!</i>\"  She pulls a fresh habit up to cover herself and prances out, humming a forgotten hymn.");
	output("\n\nUrta waits until the other woman has left before stretching, her limp length wrapped tight against her leg by her tail.  \"<i>I worry about her, [pc.name].  The darkness inside her is growing, and I don't know how long her faith will stay her descent into depravity.</i>\"  She hugs you then, throwing herself against your body, clinging so tightly it hurts.  \"<i>I don't know how long any of us can last.  It seems like the whole world has fallen already, but she's in more danger than the rest of us.</i>\"");
	output("\n\nYou nod solemnly, weighing the gravity of her words.  After a moment in silence, she releases you and gets dressed.  The fox has more than a little spring in her step, and when she ");
	if (!urtaLove()) output("waves ");
	else output("kisses you ");
	output("goodbye, she says, \"<i>Thank you.</i>\"");
	output("\n\nYour dick has returned to its old size, but a few fresh drops of [pc.cum] dribble from it.  Did the encounter leave you a little more 'productive'?");
	if (pc.balls > 0) output("  Your balls definitely got a little bigger...");
	processTime(30 + rand(5));
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//[Never See]
private function heartBreakHotelInTelAdre():void {
	urtaSprite();
	clearOutput();
	output("You reach ");
	if (pc.tallness >= 52) output("down");
	else output("up");
	output(" and slap Urta across the face and tell her you never want to see her again.  As soon as the slap hits her face, her balls start to grow in Scylla's long, skilled fingers.  She's starting to cum from the pain and pleasure, even as her eyes begin to water with tears.  You tell her that she should've discussed it with you before slutting it up with the nun, and that your life with her is over forever.  She bawls and moans in equal measure, though her hips never stop twitching toward Scylla's vacuum-tight mouth.  The nun's belly starts to expand in time with the quivering of the fox-herm's ever-growing balls.  You walk out before you have to see or hear any more from either of them.");
	//(Urta heart broken + hate.)
	urtaLove(-100);
	flags["COC.URTA_PC_LOVE_COUNTER"] = -1;
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(4);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Bird and Leave]
private function flipUrtaTheBird():void {
	urtaSprite();
	clearOutput();
	output("You curl your hand into a fist and extend your middle finger at the alcoholic and cum-slut.  You've got better things to do than waste your time watching those two indulge their addictions.\n\n");
	//(lose urta love points.)
	urtaLove(-1);
	//(lose urta dick comfort points.)
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] -= 2;
	if (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 0) flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = 0;
	//(gain lust and lose corruption + libido)
	//dynStats("lib", -2, "lus", 35, "cor", -1);
	pc.slowStatGain("l", -2);
	pc.lust(35);
	pc.cor( -1);
	processTime(3);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Jerk Off And Watch]
private function watchTwoHotBitchesAndJerkIt():void {
	urtaSprite();
	clearOutput();
	//output(images.showImage("urta-scylla-masti"), false);
	output("You open your [pc.gear] and sit down on a crate no more than a few feet away from the orally fixated couple, fishing out [pc.eachCock]");
	if (pc.hasVagina()) output(" and exposing your [pc.vagina]");
	output(".  The nun's trademark demonic stubs commence sprouting, parting her hair until they rise up at least six inches from her forehead.  Meanwhile the poor, sexually frustrated vixen's balls are swelling up like balloons in Scylla's hands, growing so large that the fox's sack sags around the larger woman's hands.  The curly-haired oral slut tries to fellate and support Urta's growing size at the same time, and definitely appears to be struggling with it.\n\n");

	output("You stroke [pc.oneCock]");
	if (pc.hasVagina()) output(" and touch your [pc.vagina]");
	output(", watching the puffed-up, fire engine-red cock-suckers bob on the trembling horse-shaft.  They slide up and down, up and down, then you see the hint of a tongue sliding around the cock and darting through the sheath.  Urta moans appreciatively at the act, and she turns her head to watch you as you masturbate to the exceptional scene before you.  Her eyes meet yours while her hands curl around Scylla's horns and pull the nun deeper into the sheath.  The fox loses her focus, her tongue rolls out, and her balls tremble and rise tight against her body.  She's cumming!\n\n");

	output("Scylla's neck is pulled tight as heavy bulges of cum work their way up the vixen's mismatched meat-pole, through the puffy, cock-sucking lips, and down the nun's throat into her hungry gullet.  Though only a few seconds pass, you watch Scylla's remarkably elastic midsection begin to bloat with what looks like a 7-month pregnancy.  She keeps her eyes closed the entire time, just silently suctioning down each plus-sized cream deposit as it's spurted out.  The only sounds in the room are Urta's half-whined moans of pleasure and the rapid slaps of your self-stimulation.\n\n");

	output("The gray-furred hermaphrodite's balls are shrinking with each blast, contracting and pausing as her body launches each volley, but they've only lost about half their enhanced size and Scylla's getting rounder than she has any right to be.  The nun seems ready for this though, and hums in concentration.  Her belly stops growing immediately, but each of her already prodigious milkers begins to enlarge, sloshing noisily like a barrel being filled.  You nearly push yourself past the edge at the sight of the growing melons, but hold back – you don't want to blow until you see just how far this goes.\n\n");

	output("Urta's hands let go of the corrupted woman's horns and she slumps back against the wall, but the nun just wraps her arms around the blissed-out vixen and suckles harder.  You keep watching and stroking, entranced by the sight of the spooge bubbles vanishing into Scylla's neck and plumping up her tits.  Urta's eyes are rolled back and she's drooling a runnel of spittle down her tit, around one of her black nipples, and down her belly, but she keeps cumming, even though her balls are nearly back to normal.  The poor fox is utterly unable to cope with the sensations running through her drunken form, but she's clearly enjoying it.\n\n");

	output("Just as Scylla's tits start to drag against the floorboards, she pulls back, letting Urta blow a few long ropes of thick horse-cum over her face and hair.  The nun sighs happily and begins to gather it in her fingers, licking it up while the exhausted fox's cock slowly deflates, dripping a trail along the floor.  Urta recovers surprisingly quickly, blinking her eyes and pulling her tongue back into her mouth with a sigh of utter, sated contentment.  You held back for so long, but watching the nun pick pearly strands of animal cum from her hair and swallow it down like a whore is just too much.\n\n");

	output("You pump hard on [pc.eachCock]");
	if (pc.totalCocks() > 1) output(" in turn");
	output(", shooting hot ropes of semen that drape over the satisfied girls.  After so much edging, and such a hot scene, your orgasm is far more intense than any normal masturbation session.  Your whole body trembles while it spurts and squirts, making sure both of the addicts get at least a little bit of your [pc.cum] on their bodies.  ");
	if (pc.cumQ() >= 250) output("A particularly coherent blast of seed splatters over Urta's tits, glazing her gray fur and black nipples with a thick layer of dripping spunk.  ");
	if (pc.cumQ() >= 450) output("Another huge gout takes Scylla straight in the face, completely soaking her with yet more [pc.cumFlavor] mess that drools onto the curve of her pendulous, black-clad tits.  ");
	if (pc.cumQ() >= 700) output("A few more big blasts of the stuff fire off, spotting the pair with fat, [pc.cumVisc] blotches.  ");
	if (pc.cumQ() >= 1000) {
		output("Your body is so productive that it utterly drenches both participants in the stuff.  Runnels of it drip over their curves while fat droplets pool into a");
		if (pc.cumQ() >= 2000) output("n inches-deep");
		output(" puddle on the ground.  ");
	}
	output("Finally spent, you slump back and smile.\n\n");

	output("Scylla looks shocked, as if she's seeing you for the first time, but her nose twitches and she starts to shovel your seed into her mouth with greedy abandon.  Even so, her body rapidly 'digests' the fluid intake, and the nun starts to slim up before your eyes.  Urta wobbles up onto shaky legs and stumbles into you, giving you a wet kiss that tastes faintly of your [pc.cumFlavor] leavings and then passionately hugs you.  She breaks the embrace and slurs, ");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00143"] == 1) output("\"<i>We need to do thish again!</i>\"");
	else output("\"<i>You're the besht " + pc.mf("man", "woman") + " a girl could ashk for.</i>\"");
	output("  Before you can answer, she gives your ass a slap and finds a water barrel to wash up in.  Scylla finishes her 'meal' and looks up at you, her alabaster skin turning completely crimson before she too runs off to clean up.\n\n");
	output("You smile happily and pick up your [pc.gear].  It's past time you checked up on your camp.");
	if (urtaLove()) output("  You give your lover's back a wistful grin and muse over how good her taste in women is as you leave.");
	processTime(15 + rand(5));
	pc.orgasm();
	//+luv
	urtaLove(2);
	//+comfort
	IncrementFlag("COC.URTA_COMFORTABLE_WITH_OWN_BODY");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Lap Sittings!] - no taurs! (need size check also, to avoid implied analpocalypse -Z)
private function makeUrtaSitOnYourLapWithScylla():void {
	urtaSprite();

	// unlike most cases, x is for anal and y for vaginal here
	var x:Number = pc.cockThatFits(urtaCapacity());
	var y:Number = pc.cockThatFits2(urtaCapacity());

	clearOutput();

	//output(images.showImage("urta-scylla-lapfuck"), false);
	output("You smirk at the drunken fox and inform her in no uncertain words that you'll do more than watch.  She blinks at you, her inebriated mind unable to process new thoughts as you stalk forwards and sit behind her on the crate");
	if (pc.isNaga()) output(", snaking your tail around her legs");
	else if (pc.isGoo()) output(", enveloping her legs with your goo");
	else output(", straddling your " + pc.legs() + " around her hips");
	output(".  You grab her narrow waist and pull her up, dragging Scylla's cock-locked head up with her and aligning your " + pc.cockDescript(x) + " with her backdoor before you start to lower her back down.  ");
	if (y > -1) output("Your " + pc.cockDescript(y) + " even manages to get in line with her drooling, black-lipped pussy.  ");
	if ((pc.cockTotal() > 1 && y == -1) || pc.cockTotal() > 2) output("You allow your remaining, unused dickflesh to flop against her back, leaking pre-cum into her fur.  ");
	output("You aren't sure if it's the alcohol in her or her own anal talents, but she slides down without a complaint, pulling Scylla's vacuum-like mouth down with her");
	if (y != -1) output(" and squeezing you tightly with her sopping cunt");
	output(".\n\n");

	output("She grunts, \"<i>");
	if (x != -1 && y != -1) output("Oooh, and in both holes?  You naughty " + pc.mf("boy", "girl") + ", you!");
	else if (urtaLove()) output("Oooh yeah, fill me love!");
	else if (rand(2) == 0) output("Oooh, you know how to treat a lady!");
	else output("MMmm, that's nice!");
	output("</i>\"  She's actually trying to watch you over her shoulder now, completely ignoring the cock-addled nun as the latter bobs on her horse-meat.  You make the most of it and ");
	if (urtaLove() || pc.cor() <= 40) output("kiss her full on the mouth");
	else output("bite her neck");
	output(" while you grab her soft, furred asscheeks and lift her up, feeling the exquisite texture of her pucker ");
	if (y != -1) output("and twat ");
	output("massaging your manhood the whole way.  Before you go too high, you drop her, and let her weight impale her back on top of you.  Her rapidly expanding balls slap into your own and smear them with her pussy juice.\n\n");

	output("Urta's tail curls snugly around your waist, and the drunken fox takes over, lifting herself up even as Scylla's magic swells her balls past the size of grapefruits.  She openly moans when she reaches the apex, and smoothly lowers herself back down, squeezing and stroking you with her internal muscles while trying to endure the nun's incessant suckling.  The measured ");
	if (y != -1) output("double penetration");
	else output("anal fuck");
	output(" drives you wild, but being on the bottom as you are, there isn't much you can do aside from grabbing fistfuls of vixen-ass and slapping it for encouragement.  Urta gets the message and begins to bounce vigorously, mewling and moaning as her balls get large enough to reach the floor.  You lend a hand and play with her sheath, feeling the flesh underneath quake and tremble as the fox's orgasm hits.\n\n");

	output("Scylla's neck is pulled tight as Urta's urethra is stretched wide by huge bulges of cum.  You can actually feel them sliding past the fingers you've dug into her sheath.  No sooner than one squeezes past is another on its way.  You wonder how Scylla can handle such incredible volumes and the only answer you can think of is magic.  Whatever the case, her swallowing gets noisier and Urta starts bouncing even faster atop your " + pc.cockDescript(x), false);
	if (y != -1) output(" and " + pc.cockDescript(y), false);
	output(".  You pinch one of her shiny black nipples between your fingers as encouragement, and she actually howls with delight.  The herm vixen's cum-pumping cock starts spasming in your grip, the order of her previous cum blasts dissolving to turn her cock into a frenzied, constantly squirting spooge-hose.  Every spurt of jism that Scylla swallows is one less in the fox's magically-enhanced ballsack, and the unnatural, mighty orbs begin to shrink back towards their normal size with alarming rapidity.\n\n");

	output("Scylla's growing belly and tits smush around your " + pc.legs() + ", swelling further and further as she tries to devour all the creamy horse-spunk the fox is hosing into her.  Yet the touch of long, gentle fingers caressing your " + pc.sackDescript() + " and the gradual inflation of your [pc.balls] lets you know that the slutty nun's discovered another source of seed.  You groan as warmth and stimulation make your orbs churn and slosh, growing not just in size but also in raw, animal NEED.  Driven to near madness by the drunken fox's delicious backside and the building, backed-up cum in your sack, you grab hold of Urta with both hands and start jackhammering her asshole");
	if (y != -1) output(" and pussy");
	output(", pounding the lithe fox as if your life depended on your orgasm.\n\n");

	output("Scylla's fingers don't stop their assault, and as Urta's softening cock flops free of the nun's ruby lips, smearing them with jizz, the nun takes each of your distended nuts between her palms, one at a time, and rubs it until you can feel the cold floor pressing against their over-sized bulk.  Urta's flagging cock reacts to the repeated strikes you're giving her prostate by returning to full hardness, though you wonder if Scylla's magic had a part in it as well.  Regardless, the nun lifts her habit to expose one lipped, milk-leaking nipple and slides the fox's girth inside.  Urta's eyes roll back and she begins to babble incoherently, the massive orgasm, followed by anal penetration and nipple-fucking, just too much for her poor battered psyche.\n\n");

	output("You cum, hard enough to make you cross your eyes and slam Urta's hips into you with painful force, even through the padding of her supple buttcheeks.  The first ass-filling wave of jism completely packs her backdoor, surrounding you in a sea of your own sticky moisture.");
	if (y > -1) output("  Meanwhile, your other [pc.cockNoun " + y + "] utterly fills her womb, stuffing it so completely that the fox's belly rounds out.");
	if ((pc.cockTotal() > 1 && y == -1) || pc.cockTotal() > 2) output("  A wave of the stuff splatters her back, glazing her from the shoulder-blades to the crack of her ass and nearly catching you in the chin. Maybe there is such a thing as too many cocks?");
	output("  Scylla's hands rub the fox's belly tenderly as she humps away at the lewd nun, using whatever magic she has to ensure you won't damage the drunken vixen as you continue to push larger and larger amounts of semen into her.  After three more blasts, she runs out of room inside her, and it starts squirting back out with each fresh stroke, soaking your waist, " + pc.legs() + ", and rapidly shrinking balls.  You lose track of time, knowing only the pleasure of orgasm and the feeling of your own spooge pumping into your lover until the unholy cumsplosion finally ends.\n\n");

	output("You regain your wits to the sight of a very pregnant-looking Urta and Scylla leaning on each other and trying to make their way to a water barrel to clean up.  The vixen is so full she looks like a mother in her ninth month of pregnancy with triplets, but as she starts to clean up Scylla gently presses on the fox's belly and devours the cum she squeezes out.  Urta shakes, but doesn't emit a sound beyond a few strangled half-moans of pleasure.  If the fresh horse-cum soaking the nun's habit is any indicator, Urta must have gotten off again during your orgasm.  Wild!\n\n");

	output("You grab a rag and wipe up before donning your [pc.gear].  Urta saunters over, looking like she's sobered up quite a bit.  She's got ");

	if (urtaLove()) output("a contended smile on her face, and gives you a long, slow kiss that practically radiates her love for you.");
	else if (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] < 11) output("a nervous smile on her face, but gives you a quick peck all the same.");
	else output("a satisfied smile on her face, and crushes her lips against yours in a passionate kiss.");
	output("  She says, \"<i>I think I'll need to help Scylla to her room... somehow whatever she did to me must have pulled all the alcohol out of me and into my cum.  Don't worry, I'll ");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00143"] <= 1) output("pay for the door and ");
	output("make sure she's ok.</i>\"\n\n");

	output("Did her cock just twitch?  No, you scold yourself; it couldn't have, not after two orgasms like that.  Urta hooks her arm around the giggling nun's midsection and pulls the stumbling sister towards the doorway.  Scylla looks back at you and half-giggles, half-slurs, \"<i>Tee-hee, thish ish so much fun!  I love you guysh!</i>\"\n\n");

	output("You make your way out with your head low, but you do see Scylla and Urta walking up the stairs towards a truly private room.  They each look a little unsteady and neither of Scylla's hands can be seen, but you're sure they'll be ok.");
	processTime(15 + rand(5));
	pc.orgasm();
	//dynStats("lib", 1, "sen", 1, "cor", .5);
	pc.slowStatGain("l", 1);
	pc.cor(0.5);
	//+luv
	urtaLove(3);
	//+comfort
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] += 3;
	pc.cumMultiplierRaw += 2;
	pc.ballSizeRaw += 1;
	if (y >= 0) knockUpUrtaChance();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function lippleBondUrtaScylla():void {
	clearOutput();
	//output(images.showImage("urta-syclla-3some","vert"), false);
	output("With a grin, you approach the busty - bustier duo and lower yourself level with the woman doing most of the work.  Urta watches you with evident anticipation, probably thinking about whether you intend to join in on the oral assault on her - maybe give some attention to her overfilled balls, swelling bigger and bigger under Scylla's tender caresses, or the wet slit of a prize behind them, but you have a different thing in mind for them.");

	output("\n\nYou do reach out between Urta's legs just to avoid making her feel left out... or maybe it just goes with the spirit of the teasing you want to give her.  Her balls have already grown beyond their normal size and Scylla is intensely kneading them, so you have to reach around them to actually touch her pussy.  Sure enough, it's soaking wet and feeling the touches on both of her sexual organs causes Urta to moan loudly.  As you rub on her pussy lips gently, only giving the occassional flip to her clit, you direct your other hand elsewhere - to the nun's habit.  Slowly, you run your hand over one of her heaving, magnificent breasts, causing her eyes to dart to you rather than her 'meal'.  Scylla blushes as you press a single finger on the habit covering her mountainous cleavage, almost feeling the breath of her tit-lips on your arms as her breasts swell with air.  You increase the pressure and, surely enough, with her next breath in, the habit simply gives way, and your finger is suddenly inside the ripped folds.  Both you and Urta watch in amazement as you pull the increasingly-ripped dark cloth away, exposing Scylla's cream-filled, squishy jug of a left tit.  Your fingers purposely brush against her lipple, the ruby mouth trying to suck in a thumb as you feel the heat and wetness of it.  You pull the busty nun towards yourself, lowering your [pc.face] towards the leftmost of her lips, and pressing your own against hers.  Scylla squirms in your embrace, moaning into Urta's cock, whom in turns shivers herself from both the sensation and the sight, and you can feel her female sex squelch as it gushes some fluid over your fingers.");

	if (urtaLove()) output("\n\n\"<i>Hey, love, that's unfair... why's she the one getting the kisses? Trying to make me jealous?</i>\"\n\nYou smile, wondering if Urta even noticed where the lip that you're kissing is located.");
	else output("\n\n\"<i>I... guess she has more of these to kiss with, but... umm...</i>\"  Seeing you entranced with Scylla's tits and lipples, not to mention being interrupted by the nun's slurps, half-moans, and her own sensations, Urta stops mid-sentence.");

	output("\n\nYou slip the tip of your tongue inside Scylla's magnificent mound, tasting her rich cream and essentially making out with her breasts, feeling [pc.eachCock] harden completely from all the visual and mental stimulation accumulated from the act.");

	output("\n\nFinally, you break the kiss, separating from the nun, hearing something of a sigh and a few sounds of her left breast still sucking at the air.  Without any further ceremony to it, you reveal Scylla's other tit to the air, raise to full height and shed your [pc.gear], exposing your groin to the air of the back rooms.");

	output("\n\nYou gently pull at Scylla's small horns to get her away from Urta's cock, while helping your vulpine lover up to her feet.  The nun looks at you, puzzled, and then notices the head of your [pc.cock " + pc.biggestCockIndex() + "] almost prodding at her lipple.  She probably gets the idea by now, but you voice the opinion that since there's enough cock to go around, you should allow Scylla's 'extra' lips to get their own meal as well.");

	//[pg]
	output("\n\nUrta quivers with excitement as the nun leads the flared tip of her cock towards her other breast, with a heavy blush, but anticipation of the pleasure and feeding evident on her face.  You feel the tip of [pc.oneCock] pressed against Scylla's breast-lip and it's agonizingly slowly drawn and sucked inside, with Urta holding your hand anxiously as the same is done to her own cock.");

	output("\n\nYou feel Scylla's heartbeat pulsing through your member as it's drawn inside the hot and milky-moist tit, the pressure and said pulsing sensation making you let out your own sound of pleasure.");

	//[if (cocks > 1)
	if (pc.cockTotal() > 1) output("  Without much warning, you suddenly feel Urta's hand move away from your own palm, the sensation of your [pc.cock " + pc.smallestCockIndex() + "] being wrapped by her fingers also assaulting you as she squeezes and tugs at your second cock affectionately.");
	//[if (cocks > 2)
	if (pc.cockTotal() > 2) output("  The barrage of sensations is intensified when Scylla also gets a bit greedy, grabbing another tool and starting to jerk it off as well.");

	output("\n\nAs you're being sucked inside Scylla's breast, Urta moans loudly at the intense sensation of finding herself inside the overstuffed, warm, wet folds of Scylla's breast as her cock is being lapped at.  Both of you reflexively buck your hips, pushing through any resistance the tits may offer at a later point and lodge the two lucky cocks deep inside the nun's chest.  This causes her to throw her own head back and moan in ecstasy at the mind-blowingly filling intrustion into her chest.  [pc.EachCock] is stimulated with");
	//[if (cocks > 1)
	if (pc.cockTotal() > 1) output(" either");
	output(" the holy woman's ravenous lipples and inner, erotic tit-flesh in a mutually ecstatic, sensations-filled manner");
	if (pc.cockTotal() > 1) output(" or more delicately and less hungrily with a feminine hand");
	output(".");

	output("\n\nYou feel Scylla's breast tighten against your dick, trying to force it to give up your seed it as the flesh of and around her nipples reddens and swells from the strain, effort and arousal.  Scylla's entire soft body trembles and quakes as the inner muscles of her breasts lap against your shaft, covering it with her rich milk as it slightly spills around your [pc.cock " + pc.biggestCockIndex() + "], with the nun moaning ecstatically in what is apparently an intense orgasm.  Urta's back bends over, not used to such a new stimulation, and one of her hands reaches towards your [pc.chest] for support.");

	output("\n\nYou turn towards the orgasm-nearing fox woman, and she raises her head in understanding, seeking out your lips for an intense, passionate kiss.  Scylla's own hands move over her breasts, kneading the soft flesh stabbed repeatedly with hard cocks as the two of you begin to move your hips in unison, actively penetrating the two lustfully suckling breast-mouths as the nun runs her fingers over the swollen lipples, intensifying her own sensations, the rich cream mixing with the precum of your [pc.cock " + pc.biggestCockIndex() + "] and Urta's equine member, occasionally dripping out of the breast-lips and giving Scylla's underboobs an oily sheen.");

	output("\n\nThe increasing pressure of tit-flesh over your [pc.cock " + pc.biggestCockIndex() + "] starts to feel increasingly unbearable.  The three of you release a whimper of overwhelming pleasure in unison, you and the nymphomaniac herm vixen from the sensations of being drowned in Scylla's milk and tit-flesh and the nun from the stimulation of both her sensitive ruby lips and the tight, hungry inner folds of her immense breasts.  You're torn between wanting to grab the nun and fuck her mounds hard as the semen starts to boil inside you, wanting out, and allowing the duo of addicts to allow themselves their own pace, one that keeps you in an incredibly pleasuring, feverish arousal and almost causes you to squirm from the intensity of the multitude of sensations.  The next time you pull out for a bit, you can feel Scylla's lips slide down your cock just as her fingers travel over it, seeking the sensation of your body as she struggles against the increasingly overwhelming assault on her sensitive lipples and inside of her heaving magnificent orbs.");

	output("\n\nUrta starts to pant and almost howls as she recognizes Scylla's touch on her cock, traveling towards her swollen, cum-packed balls, probably to attempt to increase the nun's incoming meal.");

	output("\n\n\"<i>T...thish ish... just too awesome... My-my-my dick!  Marae'sh titsh, my dick's in paradise!  I'm gonna cum!  Gonna cum!  Gonna cum!</i>\"");

	////if (sensitivity < 29)
	//if (pc.sens < 29) output("  You can only tell so from her expression and from Scylla moaning and gasping sharply, but it appears Urta's cock is really just about ready to shoot off cum.");
	////if (sensitivity > 29)
	//else 
	output("  Scylla's titflesh slightly shifts from what is apparently the expansion of Urta's cock flare and the twitching of her massive shaft.  You're sensitive enough to notice.");
	//[if (sensitivity > 44)
	//if (pc.sens >= 44) output("  In fact, you can clearly feel the pressure inside Scylla's chest increasing as Urta's huge cock expands and twitches inside her next to your own, each such twitch sending a shiver of pleasure through both you and the nun.");

	output("\n\nSympathetic, you slide your hand down into the crevice of Urta's buttocks and lower, into her sopping wet cunt, fingering the vixen as her orgasm approaches.");

	//[pg]
	output("\n\nScylla turns a feverish gaze towards you as well, licking her lips in ravenous anticipation of her meal.  You notice her hand has already reached the [pc.sheath] of your member.");
	output("\n\n\"<i>You, too, [pc.name].  I want to feel you spurt your delicious... cream in my breast.  Cum together with her... let the pleasure of being with us both wash over you...  My breasts so thirst for my guardian angel's essence.</i>\"");

	//[Regular Urta]
	if (!urtaLove()) output("\n\n\"<i>This feelsh so good, [pc.name]!  I'm gunna cu-u-uhmmm in her titsh!  I'm gonna flood these freakishly huge titsh of yours, Sh-cc-cylla!</i>\"");
	//[Lover Urta]
	else output("\n\nUrta looks to you as she thrashes in pleasure.  \"<i>Fuck yes!  Love, cum with me.  Let's flood that horny nun's breasts with our mixed jizz!  I want to feel your sperm washing over my cock together with her milk after you spurt your thick load into this amazing boob!  I want to hear your pleasure-filled voice... Shoot it out for us!</i>\"");

	output("\n\nTheir encouragements ");
	if (pc.cockTotal() > 1) output("as well as the hands of both of them working your cocks ");
	output("are enough to push you close to the edge yourself as you start pumping your fingers in and out of Urta's feminine gash, causing her to buck sharply and moan loudly, incoherent words signaling her apparent orgasm flooding the air.  Scylla hums in a pleasure filled voice as she kneads the fox-woman's swelling, already massive balls and the [pc.sheath] of your cock, alternating between looking at you and your vulpine lover.  Finally, you fall completely under the spell of Scylla's hard-working hand and ravenous breasts, losing control over yourself as you feel your [pc.balls] swell, precum leaking in ridiculous amounts from your tip as you feel the incoming load being increased forcefully to an extreme amount by the nun's ever-demanding hunger for your sticky, gooey jizz. The magical sluttiness of the nun is only enhanced by the presence of the warm body to your left, already quivering with her own overdue orgasm preparing to gush out of her, as the wet sounds of Scylla's tit-lips sucking you both off as your precum mixes with her milk now leaking all over your shafts as well as the schlicks of Urta's black snatch slurping audibly on your fingers as you pump them in and out of her fill the air.");

	//[pg]
	output("\n\nScylla seems to lose her hazy, satisfied composure as the stimulation of her breasts and the perspective of being fed cum from two sources at once makes her quiver with want.");

	output("\n\n\"<i>Cum for me.  I want to feel both the fox-cream out of Urta's delicious shaft and the essence of my precious [pc.name]'s gorgeous [pc.cock " + pc.biggestCockIndex() + "] shooting off into me!</i>\"");

	//[if (sensitivity < 59)]
	//if (pc.sens < 59) output("\n\nThe sound of Urta's passionate voice crying out in climax is all you need to give in to Scylla's ministrations, the nun's hungry breast-flesh rapidly consuming the first spurt of your load as you release your own ecstatic cry.");
	//[if (sensitivity >59)]
	//else 
	output("\n\nIt's simply too much for you and you cum just before your vulpine lover, the hungry, raunchy looks of both beauties causing you to pump your load into Scylla's hungry tit.  With a smile, Urta also gives in to the pleasure delivered to both her cock and her pussy, creaming herself and the inside of Scylla's chest.");

	output("\n\nYou feel Urta's sloppy wet box squeezing your fingers as the two of you pump load after load into the nun's tit-flesh, the holy woman's unnaturally erotic, sperm-addicted body sent into quakes and spasms of satisfaction as she starts whimpering and yelling incoherently, occasionally calling your or Urta's name out as drool runs down her chin.  Thick milk mixed with cum flows down her swelling, growing tits, the ground under her kneeling form probably completely showered in the girl-cum of her still untouched womanhood.  The inner folds and muscle rings of Scylla's encompassing feminine mounds quiver, pulse and squeeze around your shaft, milking your extended, fluid-enriched orgasm as she takes her fill.");

	//[if (cocks > 1)]
	if (pc.cockTotal() > 1) output("\n\nUrta's hand quickens its movement over your [pc.cock " + pc.smallestCockIndex() + "], trying to extend the orgasm flowing through it as well, if not being exactly as pleasurable as Scylla's vacuum-like, jizz slurping tits.");
	//[if (cocks > 2)
	if (pc.cockTotal() > 2) output("\n\nYour own hand also travels down to your multiple members, trying to deliver as much stimulation to your [pc.eachCock] as possible.");

	//[if (cocks >1)
	if (pc.cockTotal() > 1) output("\n\nYour load spills over your two lovers as well; Scylla's ability to increase the intensity and fluid-production of orgasms causes you to give them quite the gooey shower.");

	output("\n\nYour mind almost drifts away from the pleasure washing over your as Urta and yourself are diligently, almost obsessively robbed of all seminal fluids your bodies seem capable of producing, Scylla's body swelling from the generous offering, her tits increasing to an amazing size, probably enough to use as either a pillow for a true giant or a bed for a small enough person.  Her tummy also bulges out slowly as her breasts drink your essence, her eyes rolled to the back of her head from the immense, sexual strain absorbing the jizz from the two of you puts on her body and mind.");

	//[if (cumExtreme = true)]
	if (pc.cumQ() >= 1000) output("\n\nYou suddenly realize that so far, you've only shot out a bit more than you usually would, and given Scylla's incredible ability to increase cum production in her \"<i>meals</i>\", she's bound to be stretched to the extreme by your full load.  Surge after surge, wave after wave floods from you into Scylla's own body, Urta giving the two of you a scared look as her own orgasm starts to subside.  Scylla's stomach expands into something you'd see on a naturally pudgy woman pregnant with quadruplets and after a generous meal; her butt grows in size to a voluminous, wet, jiggling, almost liquid-squishy piece of all-encompassing ass you'd only see on the most eroticized, well-knocked-up broodmothers of Mareth.  Her tits continue to grow, darkened ruby lips stretching almost as if they wanted to swallow you whole rather than just try and dry your semen-factories out.  Just as the vision starts to shift from sexily aberrant to scary, cum gushes out of Scylla's mouth and lipples, a wet spot on the back of what remains of her habit suggesting all her orifices may be leaking it, and her expansion stops.  Thankfully, it seems Scylla managed to nearly rationally measure how much she can increase your load before either of you three, or the room itself, breaks completely. The sensation was worth the freak-show, you believe.");

	output("\n\nWith a strained whimper, Urta pulls out of Scylla's well-fucked, stretched tit, cum leaking out of the breast before its lipples close down before your eyes, trying to keep it inside.  You also struggle to pull out of Scylla, but the sucking ruby-tipped mound simply doesn't want to let you go, gently lapping on your cock and drawing every single drop of fluid out of you, not to mention it seems Scylla is holding on to you.");

	//[If Cock type = Canine]
	if (pc.hasKnot(pc.biggestCockIndex())) output("  You're not making the problem any easier, in fact, your knot is halfway stuck inside her breast, surged and filled to full size right after your orgasm.");

	output("\n\nUrta saunters over to you, the sway of her hips somewhat ungraceful from the intensity of the previous sensation.");

	//[Regular Urta]
	if (!urtaLove()) output("\n\n\"<i>That was so fucking hot, [pc.name]!  We need to try this again!  Beats any regular titfuck OR blowjob I can imagine, for sure.</i>\"");
	//[Lover Urta]
	else output("\n\n\"<i>[pc.name], lover, that was... amazing.  Our loads... rushing into her!  The shuction!  You next to me, fingering my pussy, the s-shenshation of her tits suckling me...  Cumming around me...  Me fillin' them with my fox cream as you did the shame on the other side...</i>\"  Urta pauses for a moment, drooling, the alcohol and weariness from the pleasure both overcoming her.  \"<i>T-the pulsing of everything around me as she consumed our loads... I thought my mind was gonna break!  But...  I hope we can do this again.  Thanksh!  I luv you, [pc.name].</i>\"");

	output("\n\nIt apparently took all her focus to say it even that clearly in her alcohol and pleasure-drunk state, as moments later she suddenly falls into your arms, pushing you down onto the ground, your cock finally flopping free of Scylla's lipple");
	if (pc.hasKnot(pc.biggestCockIndex())) output(", your knot sufficiently deflated now");
	output(", now sucking desperately at the air, looking for the tasty dick.");

	output("\n\nWorried, you look at Scylla, who simply lies on the ground, completely filled and content as her body metabolizes the semen a bit too slowly for her to get up anytime soon.");

	output("\n\n\"<i>... No worries, [pc.name].  I'll be fine soon, and she should be too... you can get going, if you need to.  I... don't think I'll be needing another meal anytime soon...  In fact, this is the first time I think I might've gorged myself to the point of sinning and... illness...</i>\"");

	output("\n\nYou help the two women lie down safely and comfortably, waiting a bit to make sure Scylla will at least be able to move soon and help Urta get someplace to rest, before leaving the two of them to enjoy their afterglow.");
	pc.orgasm();
	//dynStats("sen", -2, "cor", .25);
	pc.cor(0.25);
	if (pc.maxCum() < 500) pc.cumMultiplierRaw += 2;
	if (pc.maxCum() < 1500) pc.cumMultiplierRaw += 2;
	if (pc.maxCum() < 5000) pc.cumMultiplierRaw += 2;
	if (pc.maxCum() < 20000) pc.cumMultiplierRaw += 2;
	processTime(40 + rand(10));
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[No Scylla]
private function tellUrtaNoMoreScylla():void {
	urtaSprite();
	clearOutput();
	flags["COC.UNKNOWN_FLAG_NUMBER_00147"] = 1;
	output("You let Urta know that you're willing to overlook this, but that Scylla is a slippery slope that's best avoided.  She nods, a sober expression on her vulpine face.  Once you finish, she replies, \"<i>I understand, but you need to know – when 'it' gets too much for me to handle... if you aren't around to help I'm going to see Edryn.  S-she helps... if it wasn't for her I probably would've given up and done something stupid a long time ago.  What we have is more important, but unless we can get together every couple days I'll NEED to visit her.  ");
	if (urtaLove()) output("Just please, don't doubt my love for you.  ");
	output("Do I need to stop drinking too?");
	//[Drink More] [Drink Less] [No Change] [Leave Her]
	processTime(2);
	clearMenu();
	addButton(0, "Drink More", tellUrtaToBeADrunkenHussy);
	addButton(1, "Drink Less", tellUrtaToStopBeingALush);
	addButton(2, "No Change", tellUrtaToStayTheSame);
	addButton(3, "Heartbreak", leaveUrtaAfterScyllaConfrontation);
}

//[Scylla Okay]
private function tellUrtaMoreScyllaIsFine():void {
	urtaSprite();
	clearOutput();
	output("You give Urta a raunchy, lewd smile and let her know that you're okay with her 'helping' Scylla, and vice-versa, so long as they don't mind you popping in.  She smiles and gives you a wink, but her expression darkens after a moment of thought.  Urta interrupts to mention, \"<i>There's something else.  If I can't find you or Scylla and I NEED to cum, I'll have to visit Edryn.  She's probably the only thing that's kept me sane, and if you aren't around to help with my needs I'll visit her.  ");
	if (urtaLove()) output("Just remember that YOU'RE the one I love, not her.  ");
	else output("Me and her, we've been partners in the guard for a long time, but the sex is just mechanical, to sate us.  You don't have to worry about her stealing me away.  ");
	output("But what about my drinking or how I get when I'm drunk?  It doesn't bother you, does it?");
	//[Drink More] [Drink Less] [No Change] [Leave Her]
	processTime(2);
	clearMenu();
	addButton(0, "Drink More", tellUrtaToBeADrunkenHussy);
	addButton(1, "Drink Less", tellUrtaToStopBeingALush);
	addButton(2, "No Change", tellUrtaToStayTheSame);
	addButton(3, "Heartbreak", leaveUrtaAfterScyllaConfrontation);
}

//[Leave Her]
private function leaveUrtaAfterScyllaConfrontation():void {
	urtaSprite();
	clearOutput();
	output("You sigh, letting her know that her behavior isn't something you'd want from someone you're in a relationship with.  You need someone you can trust.  Someone you can count on.  Someone who isn't so ruled by their body's lusts.  Tears well up in the fox's eyes as you go on, barely held back by her desire not to cause a scene.  When you finish she can't even look you in the eyes.  She stares down at her drink and whispers, \"<i>Goodbye...");
	if (urtaLove()) output(" my love.");
	output("</i>\"\n\n");

	output("The bar seems eerily quiet as you step away from her, but it had to be done.");
	urtaLove(-100);
	flags["COC.URTA_PC_LOVE_COUNTER"] = -1;
	flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] = -1;
	processTime(6);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Drink More]
private function tellUrtaToBeADrunkenHussy():void {
	urtaSprite();
	clearOutput();
	output("You ");
	if (pc.slut() < 33) output("blush a little bit");
	else if (pc.slut() < 66) output("smile nervously");
	else output("grin widely");
	output(" and explain that when she gets drunk, lets her guard down, and gets a little more aggressive... you like it.  A lot.  Her ears perk up at your words, though her expression is a little uncertain while you explain it.  By the time you finish, something warm brushes by your " + pc.leg() + " and gently 'thunks' the table.  Clearly she's as into the idea as you.\n\n");

	output("Urta smiles, lewdly at first, though it carries a bit of a predatory glint as she waves down a waitress and orders a full bottle of Barkardi 151.  You give her a rueful smile, a stroke under the table, and a kiss just bursting with tongue before you conclude the conversation.  Urta's going to be a lot of fun from now on...");
	flags["COC.URTA_ALCOHOL_HABIT"] = 1;
	//dynStats("lus", 5);
	pc.lust(5);
	processTime(6);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Drink Less]
private function tellUrtaToStopBeingALush():void {
	urtaSprite();
	clearOutput();
	output("You sigh and explain that her alcoholism isn't helping anyone – not her and certainly not her relationships with others.  She nods with a knowing, sober look on her face as you recount how much harder her drinking has made your relationship.  She promises you that she won't ever get that drunk again, though she warns that it will be hard to swear off alcohol entirely.  A look of resolve enters her eyes, and she leans over the table to kiss you on the lips.  The two of you wrap up the conversation knowing that you've probably seen the last of drunken Urta.\n\n");
	flags["COC.URTA_ALCOHOL_HABIT"] = -1;
	processTime(6);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Don't Change]
private function tellUrtaToStayTheSame():void {
	urtaSprite();
	clearOutput();
	output("You smile and ask her why you would ever want her to change?  You ");
	if (urtaLove()) output("love");
	else output("like");
	output(" everything about her.  She blushes hard when you tell her that, clearly enjoying the flattery and thrilled to hear that you're okay with how she chooses to blow off steam when she's not on the job.  The two of you joke around for a little longer, but before long, it's time you were on your way.  Urta's STILL blushing as she gives you a good-bye kiss – you must have earned some points with her today!");
	//(+love score)
	urtaLove(5);
	processTime(6);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Suggestion: One could either deposit the eggs inside urta (if drunk enough to agree:P) or Urta could help you fertilize them for someone else (Horsecock stretching yer Ovipositer)
//Urta's not fertile yet though
//Display Eggs option


//Eggs Option
public function giveTheFoxSomeEggs():void {
	clearOutput();
	if (flags["COC.URTA_TIMES_EGG_PREGGED"] > 0) {
		repeatUrtaEgging();
		return;
	}
	output("You give the drunken fox a winning smile and sashay towards her; the herm's eyes lock onto your body as you approach.  Gently you run your hand down her cheek, lean in close to her face and ask if she'd like to help both of you sort something out.  At her baffled but willing look, you whisper that you could make her a mommy if she likes.");

	output("\n\nUrta's eyes start to grow wet with tears, her lower lip wobbling sadly as one hand automatically snakes to her flat, toned belly.  \"<i>M-mommy?</i>\" she mumbles to you.");

	output("\n\nYou hasten to cut that off, telling her that you can show her what it's like to be pregnant - and to have a lot of fun doing so.  This makes the herm vixen stop sniffling and start snuggling against you, impatient to begin.  However, ");
	if (pc.exhibitionism() >= 66) output("as much fun as it might be, ");
	output("you don't think it's a good idea to throw her over a table and fill her full of eggs here in front of everyone.  So, you whisper into her ear that if she wants you, she'll need to come out back with you.  Promptly rising from your seat, you head out through the back door that leads to the alley where you and Urta had your first encounter, swinging your hips alluringly.  Urta hastens to follow, tongue lolling in lusty anticipation, cock blatantly bulging against her undergarments; you're almost surprised she doesn't leave a slug-like trail of mixed drool and pre-cum in her wake.");

	output("\n\nYou slip out through the door and playfully hide yourself behind the adjacent wall.  When the drunken vixen stumbles through, looking for you, you pounce, grabbing her from behind and gently shoving her towards a handy crate near the wall.  Urta is so far gone with lust and beer that she allows you to bend her over without fighting back.  Indeed, she giggles and wags her tail, brushing the fluffy appendage tantalizingly across your crotch.  You waste little time in tugging off first your [pc.gear], and then enough of her clothes to leave her bottom half exposed, rubbing your hand teasingly against her heavy, swaying balls and dripping wet cunt.");

	output("\n\nBut it's a far different need that is driving you now, and you can't be bothered to engage in much foreplay.  You straddle the sloshed fox, ");
	if (pc.isTaur()) output("positioning your [pc.lowerBody], ");
	else if (pc.isDrider()) output("[pc.lowerBody] over the bulk of her back, ");
	output("and release your ovipositor from its usual hiding slit, already dripping with ");
	if (pc.canOvipositSpider()) output("green slime");
	else if (pc.canOvipositBee()) output("honey");
	else output("[pc.girlCumNoun]");
	output(" in anticipation of laying.  The appendage droops down, curling around to slide its wet length against Urta's balls and the base of her cock.  \"<i>[pc.name], wha...?</i>\" she slurs at you, but you just gently shush her and tell her to relax.  With a little effort, you bring it slithering back up to pry at the dampness of her netherlips...");

	output("\n\nUrta moans like the slutty drunk she is as your tubular appendage worms its way inside of her.  You shiver in pleasure at her hot, wet depths as they embrace your strange phallic appendage, but keep sliding it forward, pushing deeper and deeper inside of her in pursuit of your ultimate goals.  Urta's cock jumps and waggles with each thrust of your ovipositor inside of her, pre-cum gushing forward and drooling wet and slick down her length, splatting moistly onto the ground.");
	if (pc.hasGenitals()) {
		output("  Your own ");
		if (pc.hasCock()) output("[pc.cock]");
		if (pc.isHerm()) output(" and ");
		if (pc.hasVagina()) output("[pc.vagina]");
		if (pc.isHerm()) output(" are ");
		else output(" is ");
		output("starting to grow wet with arousal, matting her back with your sexual fluids, but you ignore them, too caught up in your need of release to bother with conventional pleasures.");
	}
	else output("  The entirety of your sexual world begins and ends with your ovipositor, with the sensation of the mock-cock burrowing inexorably towards Urta's womb overwhelming you with pleasure.  Having no other sexual organs to distract you allows you to fully embrace it; you thrust harder and harder, desperate to ensure you have reached the womb before you start to lay.");

	output("\n\nFinally, blissfully, you reach the cervix; with one last mighty thrust, eliciting a shriek of arousal-tinged pain and an explosive gout of cum from your vulpine brood-host, you penetrate her all the way into the womb.  You both hover there, gasping as you recover from your mutual exertions, when the wonderful tingling of your eggs moving emanates from your insectile fuckspear.  You moan and groan as contractions push the first of your eggs down, pumping a steady stream of ");
	if (pc.canOvipositSpider()) output("spider-goo");
	else if (pc.canOvipositBee()) output("honey");
	else output("[pc.girlCumNoun]");
	output(" to keep Urta moist and slick and pliable.");

	output("\n\nThe drunken herm barks and whimpers with pleasure as your egg stretches your ovipositor - and by extension the walls of her pussy - on its passage, rubbing her in a way equivalent to the most wonderfully filling of cocks.  Her inner walls clamp down on your protruding organ, rippling and suckling as if anxious to pull your first egg inside of her - already, the stimulation makes the second of your eggs start pulsing down, a third close behind on its metaphorical heels.  Urta lets out a howl as the first egg pushes and finally explosively propels itself into her waiting womb, the stimulation pushing her to orgasm; frothy vixen-spooge fountains all over the ground, noisily splatting and drizzling under her.  When the second and third eggs push their way in, it's too much for both of you; Urta cums for a second time, while you cum for the first time, ");
	var wetness:Number = 0;
	if (pc.hasVagina()) wetness += pc.wetness() * 100;
	if (pc.hasCock()) wetness += pc.cumQ();
	if (wetness < 300) output("splattering");
	else if (wetness < 500) output("matting");
	else if (wetness < 1000) output("soaking");
	else output("flooding");
	output(" the fox with your gushing ");
	if (pc.hasCock() && !pc.hasVagina()) output("[pc.cum]");
	else if (!pc.hasCock() && pc.hasVagina()) output("[pc.girlCum]");
	else output("mixed sexual fluids");
	output(".");

	output("\n\nEgg after egg rolls down your ovipositor, each eliciting a gurgling splurt of cum from Urta's immense dick as it gushes into her, ensuring  the ground under her is soaked with sexual fluids");
	if (pc.hasGenitals()) output(" just as her back is from your own release");
	output(".");

	//[Egg Level 1:
	if (pc.eggs < 20) output("  Urta's stomach starts to swell as your clutch of eggs fills her once-empty womb, stretching into a noticeable bulge, though not one that she couldn't hide if she wanted.");

	//[Egg Level 2:
	else if (pc.eggs < 40) output("  As the eggs keep on coming, Urta's womb swells and bulges, crammed full of goo and eggs, growing larger and larger until Urta could easily pass for an expectant mother, ready to give birth any day now.");

	//[Egg Level 3:
	else output("  You stuff Urta with eggs until you're wondering how many either of you can hold. Her belly just keeps getting rounder and rounder even as your eggs keep coming; soon, not only does she look like a woman pregnant with multiples, her skin is visibly stretched over the eggs, giving it a distinctively lumpy look rather than the round, smooth bulge she might have if your load was smaller.");

	output("\n\nFinally, your eggs are all spent - you're not sure either of you could have lasted much longer.  You barely have the strength to wobble off of Urta and then topple onto your backside in the sodden earth, Urta's multiple orgasms having flooded the dusty alley and turned it into a boggy quagmire of jizz-mud.  Urta, meanwhile, barely has the strength to keep herself from falling face-first into her leavings, though she still sinks slowly to her knees and then flops into the boggy surface. After you have regained your wind, you smirk and ask if Urta enjoyed herself.");

	output("\n\n... You get no answer save a drunken snore.  It looks like it was all too much for the already drunk herm; she's passed out!");

	//[Corruption <50:
	if(pc.cor() >= 50 || pc.isAss()) output("\n\nWith a shrug, figuring Urta's probably slept more than one drunken debauch off in this very alley, you turn and start walking back to camp, whistling in pleasure.  A weight is off your abdomen, a certain itch has been scratched very pleasantly, and all is right with the world.");
	else {
		output("\n\nWell, you can't leave her here like this, ");
		if (pc.fertilizedEggs == 0) output("even if your eggs weren't fertile, ");
		output("and so you");
		if (pc.bodyStrength() < pc.fullBodyWeight() + urta.fullBodyWeight()) output(" painstakingly");
		else output(" easily");
		output(" heave the drunken, egg-swollen fox upright.  Supporting her on your shoulder, you awkwardly carry-drag her back to her house, stopping for the occasional orientations in the city's still-unfamiliar streets.  Once there, you gratefully lay her down on her bed, give her bloated belly a pat, and head back to camp, feeling much lighter now.");
	}
	flags["COC.URTA_EGGS"] = pc.eggs;
	flags["COC.URTA_FERTILE_EGGS"] = pc.fertilizedEggs;
	IncrementFlag("COC.URTA_TIMES_EGG_PREGGED");
	//if (pc.findPerk(PerkLib.BeeOvipositor) >= 0)
		//pregnancy.knockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, 72);
	//else
		//pregnancy.knockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, 72);
	flags["COC.URTA_INCUBATION_EGGS"] = timeAsStamp + 72 * 60;
	flags["COC.URTA_INCUBATION_EGGS_TYPE"] = pc.canOvipositBee() ? "bee" : "spider";
	flags["COC.URTA_FLATBELLY_NOTICE"] = 0;
	//First time, tag for triggering freakout!
	if (flags["COC.URTA_EGG_FORCE_EVENT"] != -1) flags["COC.URTA_EGG_FORCE_EVENT"] = timeAsStamp + 48 * 60;
	pc.dumpEggs();
	processTime(25 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//Urta Chews You Out:
//Play this scene automatically after PC impreggnates Urta for the first time
// This scene makes little sense post-quest... @Etis
public function urtaChewsOutPC(newScreen:Boolean = true):void {
	if (newScreen) clearOutput();
	else output("\n");
	output("Urta looks up at you and snorts fiercely; you almost expect steam to come flaring out of her nostrils, and her livid eyes are doing their best to burn holes straight through you.  \"<i>There you are, [pc.name]!  You have some nerve!</i>\"");

	output("\n\nYou casually pull up a seat and ask why that is.");

	output("\n\n\"<i>Why's that?  Are you blind?!  Look at me!  I look like a stuffed fowl ready for the oven, and you're the one who did the stuffing!</i>\" the fox hisses at you; looking almost as confused as she is angry.");

	output("\n\nWith the same nonchalance, you point out that Urta agreed to let you fill her with eggs in the first place; you asked, you didn't make her go along with it.");

	output("\n\n\"<i>I was drunk!  I do stupid shit when I'm drunk!</i>\" Urta hisses at you, fingers idly tapping at the dome of her gurgling belly.  She catches herself and stops with a nervous frown.");

	output("\n\nSo, she didn't enjoy it?  That she isn't actually enjoying herself now");
	if ((pc.cor() > 50 || pc.isAss()) && flags["COC.URTA_QUEST_STATUS"] != 1) output(", especially given this may be the closest she'll ever get to experiencing pregnancy");
	output("?");

	output("\n\nAt that, Urta does a full-body flinch, a faint hint of red blooming under the fur on her cheeks.  \"<i>Well... no, I guess I'm not saying that...</i>\" she admits.  She pats her belly with one hand, a faint smile perking her lips.  But then she looks upset again.  \"<i>But... what am I supposed to do when the eggs come out?");
	if (flags["COC.URTA_QUEST_STATUS"] != 1) output("  I CAN'T look after any babies - this city needs every able body it can watching for demons, not replacing pacifiers!");
	output("</i>\"");

	//[Unfertilised Eggs:
	if (flags["COC.URTA_FERTILE_EGGS"] == 0) {
		output("\n\nYou tell her that she doesn't need to worry about that; they're all blanks.  Nothing but shell and goo, no babies.  At this, Urta looks disgruntled.  \"<i>Terrific.  So you stuff me full of eggs and there're not even any babies in them?  Well, I guess I can sell them or throw them out or something when I lay them,</i>\" she proclaims.");
		if (pc.libido() > 49 && pc.hasVagina()) {
			output("  Raising an eyebrow, you lean closer and inform her that you could make babies for her - she just needs to find you a big cock dripping with, and this is the important part, <i>fertile</i> seed.");

			output("\n\nUrta shifts in her seat.  \"<i>Er, well.  I, ah... I'll keep... an eye out for one.</i>\"");
		}
	}
	//[Giant Bee:
	else if (flags["COC.URTA_INCUBATION_EGGS_TYPE"] == "bee") output("\n\nWell, you're pretty sure the eggs will just hatch into bee swarms; doesn't Tel'Adre have farms of some kind that could use them, you ask?  Urta looks thoughtful for a few moments, then nods.  \"<i>Yeah, and the farmers often complain that the crops don't produce so well because the drought means there's almost no insects to pollinate them any more.  They'd be happy to take in some swarms, even if they will grow up and move away after three years,</i>\" she mumbles, more to herself than to you.");
	//[Drider:
	else output("\n\nMaybe she could give them up to a tailor's guild or something?  After all, they'll be driders like you are now, so they could produce lots of silk for the city.  The fox-morph looks puzzled at the idea, then rubs her chin contemplatively.  \"<i>I guess that might work...</i>\" she mumbles.");

	output("\n\nIt seems like Urta has cooled down, and you ask if things are okay now.  Your vulpine lover and current surrogate looks at you with blank eyes for a few moments, again stroking the drum-taut fur of her midriff, then huffs in exasperation, resting her chin in the palm of one hand as she leans against the table.  \"<i>All right... it was kind of fun...  Just don't do this to me very often!  I have a job besides being a ready breeding womb for you!</i>\"");

	urtaLove(-10);
	output("\n\nYou kiss the embarrassed fox on the nose and tell her to take care before heading out.  She grabs you by the neck and kisses you back hard, whispering, \"<i>Don't try to make me do this sober, sneaky ");
	if (pc.canOvipositSpider()) output("spider");
	else output("little bee");
	output("...</i>\"\n");
	//(Technically finished, now, but waiting Fen's okay before adding repeatable version)
	flags["COC.URTA_EGG_FORCE_EVENT"] = -1;
	processTime(15);
	if (newScreen) addNextButton();
}


//Repeatable Eggs Option:
private function repeatUrtaEgging():void {
	clearOutput();
	//output(images.showImage("urta-egg-repeat"), false);
	output("With a smile, you ask if Urta would be willing to let you lay a few eggs in her womb again?");

	output("\n\nThe drunken vixen giggles and taps you playfully on the nose.  \"<i>Naughty, naughty [pc.name]... but, if you got eggs for me, I'll hatch 'em for yah, I guesh.  Jusht make sure you put them in the right hole, okay?  I don't want no eggs up da butt.</i>\"  She giggles again and gets up, heedless of the way her erection is ");
	if (!urtaLove()) output("blatantly hanging out of her stockings and drooling pre-cum everywhere");
	else output("vulgarly bulging her dress and rendering it sopping wet from her arousal");
	output(", before sashaying in a drunkenly exaggerated fashion out towards the alleyway where you and she first began your relationship- and where you first 'impreggnated' her.");

	output("\n\nYou follow close behind, striving to avoid slipping in the fox-goo trail she leaves in her wake.  By the time you catch up, she's already stripped down and is leaning over a crate for support, idly stroking her huge mare-prick with a free hand even as her tail wags in anticipation.  \"<i>Well, whatcha waiting for, lover?  Come 'n' geddit!</i>\"");

	output("\n\nYou waste little time in tugging off your [pc.gear] and then approaching the eager fox, who uses her tail to tease you by brushing it tantalizingly across your crotch.  You return the favor, rubbing your hand teasingly against her heavy, swaying balls and dripping wet cunt.");

	output("\n\nBut it's a far different need that is driving you now, and you can't be bothered to engage in much foreplay.  You straddle the sloshed fox, ");
	if (pc.isTaur() || pc.isDrider()) {
		if (pc.isTaur()) output("positioning your [pc.lowerBody]");
		else output("[pc.lowerBody] over the bulk of her back");
		output(", ");
	}
	output("and release your ovipositor from its usual hiding slit, already dripping with ");
	if (pc.canOvipositSpider()) output("green slime");
	else if (pc.canOvipositBee()) output("honey");
	else output("[pc.girlCumNoun]");
	output(" in anticipation of laying.  The appendage droops down, curling around to slide its wet length against Urta's balls and the base of her cock.  In her present state, there's no need to tell her to relax; indeed, she whimpers eagerly in anticipation of what's to come.  With a little effort, you bring it slithering back up to pry at the dampness of her netherlips...");

	output("\n\nUrta moans like the slutty drunk she is as your tubular appendage worms its way inside of her.  You shiver in pleasure at her hot, wet depths as they embrace your strange phallic appendage, but keep sliding it forward, pushing deeper and deeper inside of her in pursuit of your ultimate goals.  Urta's cock jumps and waggles with each thrust of your ovipositor inside of her, pre-cum gushing forward and drooling wet and slick down her length, splatting moistly onto the ground.");
	//((sexed)
	if (pc.hasGenitals()) {
		output("\n\nYour own ");
		if (pc.hasCock()) output("[pc.cock]");
		if (pc.isHerm()) output(" and ");
		if (pc.hasVagina()) output("[pc.vagina]");
		output(" are starting to grow wet with arousal, matting her back with your sexual fluids, but you ignore them, too caught up in your need of release to bother with conventional pleasures.");
	}
	else output("\n\nThe entirety of your sexual world begins and ends with your ovipositor, with the sensation of the mock-cock burrowing inexorably towards Urta's womb overwhelming you with pleasure.  Having no other sexual organs to distract you allows you to fully embrace it; you thrust harder and harder, desperate to ensure you have reached the womb before you start to lay.");

	output("\n\nFinally, blissfully, you reach the cervix; with one last mighty thrust, eliciting a shriek of arousal-tinged pain and an explosive gout of cum from your vulpine brood-host, you penetrate her all the way into the womb.  You both hover there, gasping as you recover from your mutual exertions, when the wonderful tingling of your eggs moving emanates from your insectile fuckspear.  You moan and groan as contractions push the first of your eggs down, pumping a steady stream of ");
	if (pc.canOvipositSpider()) output("spider-goo");
	else if (pc.canOvipositBee()) output("honey");
	else output("[pc.girlCumNoun]");
	output(" to keep Urta moist and slick and pliable.");

	output("\n\nThe drunken herm barks and whimpers with pleasure as your egg stretches your ovipositor - and by extension the walls of her pussy - on its passage, rubbing her in a way equivalent to the most wonderfully filling of cocks.  Her inner walls clamp down on your protruding organ, rippling and suckling as if anxious to pull your first egg inside of her - already, the stimulation makes the second of your eggs start pulsing down, a third close behind on its metaphorical heels.  Urta lets out a howl as the first egg pushes and finally explosively propels itself into her waiting womb, the stimulation pushing her to orgasm; frothy vixen-spooge fountains all over the ground, noisily splatting and drizzling under her.  When the second and third eggs push their way in, it's too much for both of you; Urta cums for a second time, while you cum for the first time, ");
	var wetness:Number = 0;
	if (pc.hasVagina()) wetness += pc.wetness()*100;
	if (pc.hasCock()) wetness += pc.cumQ();
	if (wetness < 300) output("splattering");
	else if (wetness < 500) output("matting");
	else if (wetness < 1000) output("soaking");
	else output("flooding");
	output(" the fox with your gushing ");
	if (pc.hasCock() && !pc.hasVagina()) output("[pc.cum]");
	else if (!pc.hasCock() && pc.hasVagina()) output("[pc.girlCum]");
	else output("mixed sexual fluids");
	output(".");

	output("\n\nEgg after egg rolls down your ovipositor, each eliciting a gurgling splurt of cum from Urta's immense dick as it gushes into her, ensuring  the ground under her is soaked with sexual fluids");
	if (pc.wetness() > 0) output(" just as her back is from your own release");
	output(".");

	//[Egg Level 1:
	if (pc.eggs < 20) output("  Urta's stomach starts to swell as your clutch of eggs fills her once-empty womb, stretching into a noticeable bulge, though not one that she couldn't hide if she wanted.");

	//[Egg Level 2:
	else if (pc.eggs < 40) output("  As the eggs keep on coming, Urta's womb swells and bulges, crammed full of goo and eggs, growing larger and larger until Urta could easily pass for an expectant mother, ready to give birth any day now.");

	//[Egg Level 3:
	else output("  You stuff Urta with eggs until you're wondering how many either of you can hold. Her belly just keeps getting rounder and rounder even as your eggs keep coming; soon, not only does she look like a woman pregnant with multiples, her skin is visibly stretched over the eggs, giving it a distinctively lumpy look rather than the round, smooth bulge she might have if your load was smaller.");

	output("\n\nFinally, your eggs are all spent - you're not sure either of you could have lasted much longer.  You barely have the strength to wobble off of Urta and then topple onto your backside in the sodden earth, Urta's multiple orgasms having flooded the dusty alley and turned it into a boggy quagmire of jizz-mud.  Urta, meanwhile, barely has the strength to keep herself from falling face-first into her leavings, though she still sinks slowly to her knees and then flops into the boggy surface. After you have regained your wind, you smirk and ask if Urta enjoyed herself.");

	//(Regular:
	if (!urtaLove()) output("\n\nUrta laughs drunkenly.  \"<i>Like, that's the weirdest fuck I've ever had... but, damn if it's not fun.  Maybe come and do that again, eh?</i>\" she suggests.");

	else output("\n\nShe gives you a dopey grin and nods, but then looks sad.  \"<i>I do like the sex, but... I kinda wish these were our babies for real, y'know?</i>\" She mumbles.");

	output("\n\nAwkwardly hauling her distended form to its feet, she gives you a sloppy kiss, grabs her clothes and starts waddling back home, clearly intending to sleep it off.  You watch her go, then pick yourself up and head back to camp.");
	flags["COC.URTA_EGGS"] = pc.eggs;
	flags["COC.URTA_FERTILE_EGGS"] = pc.fertilizedEggs;
	IncrementFlag("COC.URTA_TIMES_EGG_PREGGED");
	flags["COC.URTA_INCUBATION_EGGS"] = timeAsStamp + 72 * 60;
	flags["COC.URTA_INCUBATION_EGGS_TYPE"] = pc.canOvipositBee() ? "bee" : "spider";
	flags["COC.URTA_FLATBELLY_NOTICE"] = 0;
	pc.dumpEggs();
	processTime(20 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}