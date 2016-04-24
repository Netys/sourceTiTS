import classes.Characters.PregnancyPlaceholder;
import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCGroPlus;
import classes.Items.Transformatives.CoCIncubiD;
import classes.Items.Transformatives.CoCIncubiDPure;
import classes.Items.Transformatives.CoCMinotaurBlood;
import classes.Items.Transformatives.CoCReducto;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get edryn():PregnancyPlaceholder // since there are no TFs... screw making actual character
{
	var pp:PregnancyPlaceholder = new PregnancyPlaceholder();
	pp.legType = GLOBAL.TYPE_EQUINE; // ensure Centaur status
	pp.legCount = 4;
	if (!pp.hasVagina()) pp.createVagina();
	pp.vaginas[0].loosenessRaw = 4;
	pp.vaginas[0].wetnessRaw = flags["COC.EDRYN_PREGNANCY_INCUBATION"] == undefined ? 3 : 5;
	pp.vaginas[0].bonusCapacity = 100;
	pp.ass.wetnessRaw = 1;
	return pp;
}

public function showEdryn():void {
	//spriteSelect(14);
	userInterface.showName("\nEDRYN");
}

		//public function Edryn()
		//{
			//pregnancy = new PregnancyStore(kFLAGS.EDRYN_PREGNANCY_TYPE, kFLAGS.EDRYN_PREGNANCY_INCUBATION, 0, 0);
			//CoC.timeAwareClassAdd(this);
		//}
//
		////Implementation of TimeAwareInterface
		//public function timeChange():Boolean
		//{
			//pregnancy.pregnancyAdvance();
			//trace("\nEdryn time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
			//if (pregnancy.isPregnant && flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] == 0) {
				//flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION]++; //Pregnancy on hold until the PC discovers it
			//}
			//return false;
		//}
	//
		//public function timeChangeLarge():Boolean {
			//if (pregnancy.isPregnant && pregnancy.incubation == 0) {
				//if (pregnancy.type == PregnancyStore.PREGNANCY_TAOTH) {
					//kGAMECLASS.urtaQuest.urtaAndEdrynGodChildEpilogue();
					////Since these flag can't be in use prior to Taoth's arrival I abused them to store Edryn's previous pregnancy type and incubation
					////Did it so that if Edryn is someday made able to carry someone else's baby this will still work properly
					//pregnancy.knockUpForce(flags[kFLAGS.URTA_FERTILE], flags[kFLAGS.URTA_PREG_EVERYBODY]);
					//flags[kFLAGS.URTA_FERTILE] = 0;
					//flags[kFLAGS.URTA_PREG_EVERYBODY] = 0;
					//return true;
				//}
				//else if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
					//flags["COC.EDRYN_NUMBER_OF_KIDS"]++; //Add one kid
					//flags["COC.EDRYN_NEEDS_TO_TALK_ABOUT_KID"] = 1; //Set 'needs to talk to edryn about da kid
					//pregnancy.knockUpForce(); //Clear Pregnancy
				//}
			//}
			//return false;
		//}
		////End of Interface Implementation

public function EdrynNotify():void {
	if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] == undefined) return; // not pregnant
	if (flags["COC.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET"] == undefined) return; //Pregnancy on hold until the PC discovers it
	flags["COC.EDRYN_PREGNANCY_INCUBATION"]--;
	if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] > 0) return; // not ready yet
	
	flags["COC.EDRYN_PREGNANCY_INCUBATION"] = undefined; //Clear Pregnancy
	if (flags["COC.EDRYN_PREGNANCY_TAOTH"] != undefined) {
		flags["COC.EDRYN_PREGNANCY_TAOTH"] = undefined; //Clear Taoth flag
		//kGAMECLASS.urtaQuest.urtaAndEdrynGodChildEpilogue();
	} else {
		IncrementFlag("COC.EDRYN_NUMBER_OF_KIDS");
		flags["COC.EDRYN_NEEDS_TO_TALK_ABOUT_KID"] = 1; //Set 'needs to talk to edryn about da kid
	}
}

private var EdrynHook: * = EdrynGrapple();
private function EdrynGrapple():* { 
		timeChangeListeners.push(EdrynNotify);
	}

public function edrynBarTalk():void {
	showEdryn();
	flags["COC.EDRYN_BAR_TALK"] = 1;
	clearOutput();
	//output(images.showImage("edryn-bar-chat"));
	
	//Used for finding what cock to use!
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	//If no cocks fit, set to primary
	if(x < 0) x = 0;

	if (canTalkToEdryn()) { //Katherine training discussion
		talkToEdryn();
		return;
	}
	//Talk about latest birth
	if(flags["COC.EDRYN_NEEDS_TO_TALK_ABOUT_KID"] == 1) {
		var kidGender:Number = rand(2);
		if(rand(10) < 2) kidGender = 3;
		output("Edryn cracks into a beautiful smile and gushes, \"<i>We had a ");
		if(kidGender == 0) output("son");
		else if(kidGender == 1) output("daughter");
		else output("herm");
		output("!  You weren't in town, but the birth was easy, so don't worry about it.  Labor only lasted like, an hour tops.  You should've seen your ");
		if(kidGender == 0) output("son");
		else output("daughter");
		output(" trying to stand up for the first time.  It was incredible!  ");
		if(flags["COC.EDRYN_NUMBER_OF_KIDS"] == 1) {
			output("I'm going to have to spend less time around here so I can raise ");
			if(kidGender == 0) output("him");
			else output("her");
			output(" right, but I'd be more than happy to 'help' you with your needs if you can catch me during a free moment.");
		}
		else {
			output("I can't believe we've had " + num2Text(flags["COC.EDRYN_NUMBER_OF_KIDS"]) + " kids together!  You better come see me later on - ");
			if(flags["COC.EDRYN_NUMBER_OF_KIDS"] < 3) output("I miss the way you fill me");
			else output("I want you to make me pregnant again");
		}
		output(".</i>\"\n\n");

		output("You stay with her and chat, learning more about your newborn child and otherwise having a pleasant time with your quadruped lover.");
		flags["COC.EDRYN_NEEDS_TO_TALK_ABOUT_KID"] = undefined;
		processTime(45 + rand(30));
		clearMenu();
		addButton(0, "Next", barTelAdre);
		return;
	}
	//Mid-pregnancy talk
	else if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] != undefined) {
		output("Edryn smiles pleasantly as you approach, ");
		output("offering you a spot at the table across from her.  She pushes aside the piled-up dishes and shifts uncomfortably on her pregnant bulk.  You smile at her and enjoy a light chat for a while, until Edryn runs out of food.  She excuses herself, and rises to go to the restroom.\n\n");
		//Edryn pregnant offer
		clearMenu();
		addButton(0, "Next", pregdrynOffer);
		return;
	}
	//Post kids talk
	else if(flags["COC.EDRYN_NUMBER_OF_KIDS"] > 0) {
		output("Edryn gestures for you to take a seat, and motions for a waitress to bring you a drink.  You sit with the busty centaur and chat her up for a little bit, recounting your latest adventures and sexual exploits.  She laughs at some, blushes at others, and comforts you at times, but by the time you've finished her child-birth-enlarged nipples are like two hard bullets under her tunic and her face is flushed.  Edryn picks at her food for a moment and excuses herself, \"<i>Sorry dear, but I'm feeling a little flushed.  I'm going to head back to my room and lie down a while...</i>\"\n\n");

		//(NO WANGUUU)
		if(pc.totalCocks() == 0) {
			output("She looks down, eyes fixing on your crotch for a moment before she sighs, \"<i>Why did you get rid of your dick?  I like you a lot, but I don't really want to have sex with you like you are now.</i>\"\n\nIt looks like you won't get to have any fun with her right now.");
			processTime(5);
			clearMenu();
			addButton(0, "Next", barTelAdre);
			return;
		}
		//(WANG FITS)
		if(pc.cockVolume(x) < edryn.vaginalCapacity() && pc.cockVolume(x) > 24) {
			output("She winks at you as she gets up and trots off, giving her butt a sensual sway to draw your eyes.  Her potent scent hangs in the air, and your body reacts immediately and intensely, flooding you with arousal.  ");
			output("You look down at your [pc.cocksLight] and curse, irritated at how easily she can affect you.  There's no way you'll be turning her down this time.  You get up and follow her back to her room, intent on taking care of the need between your legs.\n\n");
			processTime(5);
			clearMenu();
			//Sex
			//addButton(0, "Next", pregdrynOffer);
			addButton(0, "Next", barTelAdre);
			return;
		}
		//(Too small)
		else if(pc.cockVolume(x) <= 24) {
			output("She looks down, eyes fixating on your crotch for a moment.  Edryn asks, \"<i>When did you get so small?  We can't fuck like this!  ");
			//(Chance of equinum,gro+(twice only),minotaur blood, or purified incubus draft)
			var itype:ItemSlotClass;
			if(Flag("COC.EDRYN_GIFT_COUNTER") < 2) {
				output("Here, take some of this stuff.  We confiscated it off one of the miscreants we kicked out the other day, and I KNOW it'll get you to be big enough for me.  Just don't go too nuts with it, okay?</i>\"\n\n");
				itype = new CoCGroPlus();
				IncrementFlag("COC.EDRYN_GIFT_COUNTER");
			}
			else if(Flag("COC.EDRYN_GIFT_COUNTER") < 5) {
				output("Here, take some of this stuff.  We confiscated it off one of the miscreants we kicked out the other day, and I KNOW it'll get you to be big enough for me.  Just don't go too nuts with it, okay?</i>\"\n\n");
				IncrementFlag("COC.EDRYN_GIFT_COUNTER");
				if(rand(2) == 0) itype = new CoCMinotaurBlood();
				else itype = new CoCIncubiD();
			}
			else {
				output("I'd love to help you, but I don't have any supplies for you.  I'm sure you'll find a way.</i>\"\n\n");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
				return;
			}
			processTime(15 + rand(10));
			
			itemScreen = mainGameMenu;
			lootScreen = mainGameMenu;
			useItemFunction = mainGameMenu;
			itemCollect([itype]);
			return;
		}
		//(Too big)
		else {
			output("She looks down and gasps, \"<i>Holy shit!  Why do you have a monster like that!?  When a centaur is shocked by how big you are it's time to go easy on the dick enlargement pills, dear.</i>\"\n\n");
			if(Flag("COC.EDRYN_GIFT_COUNTER") < 2) {
				output("Her eyes light up and she suggests, \"<i>Take some of this; it ought to take down some of that swelling.</i>\"\n\n");
				IncrementFlag("COC.EDRYN_GIFT_COUNTER");
				processTime(15 + rand(10));
				itemScreen = mainGameMenu;
				lootScreen = mainGameMenu;
				useItemFunction = mainGameMenu;
				itemCollect([new CoCReducto()]);
				return;
			}
			//(ALT)
			else {
				output("She says, \"<i>You should find some Reducto or something to shrink that down.  I haven't come across any more so you'll have to get it yourself.</i>\"\n\n");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
				return;
			}
		}
	}
	
	output("Edryn smiles pleasantly as you approach, ");
	if(pc.isTaur()) output("offering you a spot at the table across from her.  You realize your companion isn't on any kind of seat at all, and is instead 'sitting' on her lower half.  You do the same, settling down across from her, thankful this bar was made to accommodate centaurs.");
	else output("gesturing to a nearby stool.  You grab the seat and realize that your centaur companion isn't sitting still at all, but is instead 'sitting' on her lower half, which currently lies on the floor.");
	output("  Despite the oddity of the situation, you stay and enjoy a light conversation with her.  You find the conversation to be interesting, and the pair of you stay there to munch on a light meal of breads, cheeses, and a glass of wine.  While you find the time pleasant, you have a feeling that something is 'off'.\n\n");
	//New PG
	output("You take a close look at your dinner companion, trying to puzzle out what you're picking up on, but you just can't place it.  Edryn burps quietly, apologizing for her rudeness, and excuses herself to the girl's room.  As she turns away to leave, you get a good look at her backside.  Her horse-like sex is huge and puffy, and glistening with moisture.  The gentle flicking of her tail from side to side pushes her musky scent into you like a wave, ");
	if(pc.isTaur() && pc.hasCock()) {
		output("and the potent female scent works its way into your blood, making you dizzy as your [pc.cock] ");
		if(pc.hasSheath(pc.biggestCockIndex())) output("pours out of its sheath");
		else output("fills near instantaneously");
		output(", now rock-hard.  You breathe deeply, your mind subsumed in a sea of feral instincts.  The hard floor squeezes your [pc.cock] painfully underneath you, forcing you to rise up.  You can feel more than a few curious gazes sliding along your now fully exposed maleness, and it twitches as if it were happy for the attention.\n\n");
		output("Swaying back and forth, alternatively snorting and breathing deeply of the female's scent, your gaze immediately locks onto the returning mare.  Your [pc.cock] jumps and bounces underneath you, painfully hard and swollen.  A thick dollop of pre beads on your " + pc.cockHead() + ", as if the bar needed your display to be any more overtly sexual.  Edryn looks you over, walking alongside you she talks, \"<i>My my, someone liked what they saw.  Or was it smelled?  I can never tell what it is that gets you " + pc.mf("studs", "hotties") + " so worked up about me.</i>\"\n\n");
		output("A soft hand slides under your belly, hefting your [pc.cock] and smearing the bead of pre over it with long slick strokes.  She coos, \"<i>");
		pc.lust(70);
		edrynOffer();
		return;
	}
	else if(pc.hasCock()) {
		if(pc.hasCock(GLOBAL.TYPE_EQUINE)) {
			output("and the potent female scent makes you feel a bit dizzy and dazed.  ");
			if(pc.cocks[pc.findFirstOfcType(GLOBAL.TYPE_EQUINE)].cLength() >= 16) output("You barely register the thump of your hardening [pc.cock " + pc.findFirstOfcType(GLOBAL.TYPE_EQUINE) + "] as it smacks into the underside of the table.\n\n");
			else output("You squirm uncomfortably, feeling constrained by your [pc.gear] as you surge to erectness.\n\n");
			output("Swaying back and forth in a scent induced haze, you fail to notice Edryn's return.  She coughs noisily, drawing you back to the real world and pushing away the memory of her glistening snatch.  You start to fumble for words until you realize she's smiling knowingly at you.  Unexpectedly, caresses slide against your groin, hefting and measuring you through your [pc.gear].\n\n");
			pc.lust(60);
			edrynOffer();
			return;
		}
		//Non horsedick
		else {
			output("but the potent musky scent only reminds you of how different things are here.");
			if(pc.slut() > 50 || Flag("COC.EDRYN_AFFECTION") > 0) {
				output("  Unbidden, your mind wonders what her juicy horse-snatch would feel like, and your [pc.cock] responds immediately, thickening with readiness.  You squirm uncomfortably from how constricting your [pc.gear] feels.\n\n");
				output("You give the rapidly dissipating scent a sniff and note that it isn't unpleasant, just strong, and once again you find yourself imagining standing ");
				if(pc.tallness < 60) output("on a stool ");
				output("behind her, fucking her like the beast-woman she is.  Lost in your thoughts, you fail to notice Edryn's return.  She coughs noisily, rousing you from the impromptu fantasy as she gives you a knowing smile.  An unexpected caress slides against you groin, rubbing and hefting you carefully.");
				if (pc.findFirstOfcType(GLOBAL.TYPE_TENTACLE) != -1) output("  She smiles coyly when your [pc.cock " + pc.findFirstOfcType(GLOBAL.TYPE_TENTACLE) + "] wriggles, wrapping around her arm.");
				else if (pc.hasTailCock()) output("  She smiles coyly when your [pc.tailCock] wriggles, wrapping around her arm.");
				output("\n\n");
				pc.lust(40);
				edrynOffer();
				return;
			}
			else {
				output("\n\nYou wait until she returns, wishing for once that things could be normal.  Though the remaining conversation is pleasant, you have a hard time enjoying yourself, and eventually bid the pretty centaur farewell.");
				processTime(15);
				clearMenu();
				addButton(0, "Next", barTelAdre);
			}
		}
	}
	//Catch all
	else {
		//Turned on chicks can hit on her
		if(pc.hasVagina() && pc.lust() > 70) {
			output("and as wet as you are right now, you find her scent to be intriguing.  Some part of you is curious what it would taste like.  When the centauress returns you compliment her on her shapely backside, but she only smiles politely and informs you that she \"<i>doesn't swing for your team,</i>\" whatever that means.  The rest of the conversation is quite pleasant, but all good things must come to an end.");
			processTime(15);
			clearMenu();
			addButton(0, "Next", barTelAdre);
		}
		//Everybody else is all "BLEH"
		else {
			output("but the potent musky scent only reminds you of how different things are here.");
			output("\n\nYou wait until she returns, wishing for once that things could be normal.  Though the remaining conversation is pleasant, you have a hard time enjoying yourself, and eventually bid the pretty centaur farewell.");
			processTime(15);
			clearMenu();
			addButton(0, "Next", barTelAdre);
		}
	}
}

private function edrynOffer():void {
	showEdryn();
	var cost:Number = 0;
	switch(Flag("COC.EDRYN_AFFECTION")) {
		case 0:
			cost = 50;
			break;
		case 1:
			cost = 25;
			break;
		case 2:
			cost = 15;
			break;
		case 3:
			cost = 10;
			break;
		case 4:
			cost = 0;
			break;
		default:
			cost = 0;
			break;
	}
	//Pick most appropriate cock
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	//If no cocks fit, set to main.
	if(x < 0) x = 0;

	//(cont centaur)
	if(pc.isTaur() && pc.hasCock()) {
		//Too small
		if(pc.cockVolume(x) < 24) {
			output("Oh my, you're a little bit small for my tastes love.  Maybe you should try some of the local delicacies and trot back here so I can help you out, ok?</i>\"\n\n");
			output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
			processTime(5);
			clearMenu();
			addButton(0, "Next", barTelAdre);
			return;
		}
		//Too big
		if(pc.cockVolume(x) > edryn.vaginalCapacity()) {
			output("Oh wow, you're a little bit too big even for me to handle, love.  Maybe you should try to find something to shrink that down a little, not too much, and trot back here so I can help you out, ok?</i>\"\n\n");
			output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
			processTime(5);
			clearMenu();
			addButton(0, "Next", barTelAdre);
			return;
		}
		//Big enough
		output("Oh my, you're hot to trot aren't you?  I can feel just how tight and full it is, practically ready to explode. Well I've got good news for you " + pc.mf("stud", "Miss Hot-And-Bulgy") + ", I'm the best kind of mercenary – one that does ANYTHING for money, even satisfying horny equine " + pc.mf("studs", "breeders") + ".</i>\"\n\n");
		output("You groan, more turned on than ever by being fondled openly in public.  The centaur whore winks at you and offers, \"<i>So what do you say, is a roll in the hay with me worth ");
		if(cost > 0) output(num2Text(cost) + " gems?");
		else output("an hour of your time?");
		output("</i>\"\n\n");
		output("She releases your [pc.cock " + x + "] and looks expectantly at you.  Your body is ready to do anything for a chance to breed her.  What will you do?\n\n");
		if(cost > 0) output("(Do you pay " + num2Text(cost) + " gems to fuck her?)");
		else output("(Do you fuck her?)");
		clearMenu();
		if (pc.credits >= cost * 10 || cost == 0) addButton(0, "Yes", edrynSexSelecter);
		else addDisabledButton(0, "Yes", "Yes", "You can't afford this.");
		addButton(1, "No", barTelAdre);
	}
	else if(pc.cockTotal() > 0) {
		//(HORSE CONT)
		if(pc.cockTotal(GLOBAL.TYPE_EQUINE) > 0) {
			//Too bigsies
			if(pc.cockVolume(x) > edryn.vaginalCapacity()) {
				output("\"<i>Wow, that's huge!  Sweetheart, you'll need to be a bit smaller if you want to play with me.  Why not go out and find something to shrink it down to something a horse like me can handle, then maybe we can play, ok?</i>\"\n\n", false);
				output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
				return;
			}
			if(pc.cockVolume(x) >= 24) {
				output("\"<i>Mmmhmm, just as I thought.  You were daydreaming about my cunt, weren't you?</i>\" she asks.  Instinctively, you try to shake your head negatively, but she doesn't seem fooled.  Edryn releases your crotch and scolds you, \"<i>Don't lie, you got a whiff of my juicy cunt and all your reserve and fortitude melted into a puddle of fuck and breed.  Believe me, I've seen it happen before.</i>\"\n\n");
				output("She doesn't seem irritated, instead she seems quite... turned on.  Edryn explains, \"<i>" + pc.mf("Mr.", "Miss") + " thick and juicy, I'm more than muscle for hire.  I do a little 'wetwork' on the side, and I've yet to meet a horse-cock that doesn't jump at my scent.  Lucky for you, I think you're cute, and I'm feeling randy.  So, how about ");
				if (cost > 0) output(num2Text(cost) + " gems, ");
				else output("an hour of your time, ");
				output("and I'll let you get nice and personal with my juicy snatch?</i>\"\n\n");
				output("She stands up, and the scent returns, making your ");
				if(pc.balls > 0) output("balls tight and your ");
				output(pc.cockDescript(x) + " twitch.  Will you accept her proposition and give her what she wants?\n\n");
				if(cost > 0) output("(Do you pay " + num2Text(cost) + " gems to fuck her?)");
				else output("(Do you fuck her?)");
				clearMenu();
				if (pc.credits >= cost * 10 || cost == 0) addButton(0, "Yes", edrynSexSelecter);
				else addDisabledButton(0, "Yes", "Yes", "You can't afford this.");
				addButton(1, "No", barTelAdre);
			}
			//(HORSE TOO SMALL)
			else {
				output("\"<i>Ouch, is that all?  Sweetheart, you'll need to be a bit bigger if you want to play with me.  Why not go out and try some of the local delicacies, then maybe we can play, ok?</i>\"\n\n");
				output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
				return;
			}
		}
		//Normal Wingdangdoodle
		else {
			//Too bigsies
			if(pc.cockVolume(x) > edryn.vaginalCapacity()) {
				output("\"<i>Wow, that's huge!  Sweetheart, you'll need to be a bit smaller if you want to play with me.  Why not go out and find something to shrink it down to something a horse like me can handle, then maybe we can play, ok?</i>\"\n\n");
				output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
				return;
			}
			//(cont Normal)
			if(pc.cockVolume(x) >= 24) {
				output("\"<i>Was the sight of my backside that entrancing to you?</i>\" she teases, \"<i>Normally only the horsey-boys get this hard for me, but you... you want to take a ride on the wild side, don't you?</i>\"\n\n");
				output("Her words ring true, and a quick fuck to tamp down your rising lust wouldn't hurt would it?\n\n");
				output("Edryn keeps talking, \"<i>I do ALL kinds of mercenary work, even the sloppy wet kind, and lucky for you, I'm more than wet enough to let you satisfy your [pc.cock] in me.  ");
				if(cost > 0) output(num2Text(cost) + " gems ");
				else output("An hour of your time ");
				output("gets you the ride of a lifetime.  So what do you say " + pc.short + "?  Do you want to be my sex-toy?</i>\"\n\n");
				output("She stands up and turns, exposing her exotic hind-end to you.  A drop of fluid slips from her folds and splatters under the table, reminding you just how wet this trick would be.  Do you really want to do her?");
				if(cost > 0) output("\n\n(Do you pay " + num2Text(cost) + " gems to fuck her?)");
				clearMenu();
				if (pc.credits >= cost * 10 || cost == 0) addButton(0, "Yes", edrynSexSelecter);
				else addDisabledButton(0, "Yes", "Yes", "You can't afford this.");
				addButton(1, "No", barTelAdre);
			}
			//(rejected)
			else {
				output("\"<i>Wow, that's it?  I'm sorry but you'll have to be a bit bigger before you can play with me.  Why not try some of the local specialties and come back when you're a bit bigger?</i>\"\n\n");
				output("You're a bit disappointed with the outcome. It doesn't look like you'll be getting any centaur tail tonight.");
				processTime(5);
				clearMenu();
				addButton(0, "Next", barTelAdre);
			}
		}
	}
}

public function edrynSexSelecter():void {
	showEdryn();
	var cost:Number = 0;
	switch(Flag("COC.EDRYN_AFFECTION")) {
		case 0:
			cost = 50;
			break;
		case 1:
			cost = 25;
			break;
		case 2:
			cost = 15;
			break;
		case 3:
			cost = 10;
			break;
		case 4:
			cost = 0;
			break;
		default:
			cost = 0;
			break;
	}
	//Pay gems and update sidebar
	pc.credits -= cost * 10;
	//statScreenRefresh();
	//Actually choose the sex scene
	edrynFucktroduction();
	//Increment sex count
	IncrementFlag("COC.EDRYN_AFFECTION");
}

private function fuckEdrynTaur():void {
	showEdryn();
	clearOutput();

	//output(images.showImage("edryn-fuck-as-taur"));
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	if(x < 0) x = 0;
	output("Your " + (pc.isCentaur() ? "equine" : "tauric") + " body lurches forwards on its own, rearing up on your hind legs and lunging forwards.  Edryn whinnies as she is violently penetrated and forced to support most of your weight.  Her equine pussy is a wonder, able to stretch to a degree that would shame the raunchiest of human and demon sluts.  The velvet walls of her massive equine cunny clench tightly around you, trapping you completely inside her juicy depths.  She wiggles slightly, bending her body, teasing your [pc.cock " + x + "] inside her.\n\n");

	output("Edryn looks over her shoulder at you and winks as she relaxes her internal muscles.  Unprepared for the sudden release, you slide a few inches out of her before your hind-legs can steady you.  The centauress teases, \"<i>Are you sure you can handle fucking this way?  Like a rutting beast?  You look like you're about to fall over.  Here, grab onto the rings hanging from the ceiling and steady yourself.  You'll need all the leverage you can get to satisfy a horny girl like me.</i>\"\n\n");

	output("The rings aren't too high overhead, and you're able to stretch to reach them without much issue.  Grabbing them is easy, and the difference is immediate.  With more of your frontal weight being supported by your arms, controlling your body's motions should be much less difficult.  You heave backwards, sliding a bit further out, then thrust forwards with your hind legs, pulling hard with your arms to bury your [pc.cock " + x + "] to the hilt with a wet smack.\n\n");

	output("Edryn moans lewdly, rocking against you as you pull back for another mighty thrust.  You begin pounding in earnest, grunting with the effort of heaving your animal-body into the centaur's oozing black-lipped sex.  You marvel at the strange texture and inhuman warmth it gives off, and your body builds up a fine sheen of sweat as do your best to breed the mare underneath you.  ");
	if(pc.slut() < 75) output("You recoil for a second, scolding yourself for the strange thoughts, but you don't slow down the fucking in the slightest.");
	else output("You smile, realizing you hadn't meant to think of her as a mare and you as her stud, but that's exactly what you are right now.  Your thrusts speed up as you renew your determination to fill this cunt full of fillies.");

	output("\n\nShe twists around to look you in the eye as you work her drooling horse-cunt over.  You can hear her copious fluids splattering the floor and feel them dripping down your hind legs as she moans, leaning back into you and planting a sloppy kiss on your lips.  One of her hands ");
	if(pc.biggestTitSize() <= 1) output("strokes your chest");
	else output("caresses a breast");
	output(" while she caresses the side of your " + pc.face() + " with the other.  Your body pumps away while your tongues entwine, tracing saliva over each other's lips.  She pulls back and moans out again, trailing off into a whinny as she orgasms underneath you.\n\n");

	output("Her cunt locks tightly around you once again, clamping down in a series of rings from the base all the way to your [pc.cockHead " + x + "].  At once, they start sliding from the base towards the tip, new ones forming along the bottom of the shaft as her pussy milks your [pc.cock " + x + "] hard.  Trapped inside her, all you can do is groan and cum in response to her climax.  You throw back your head as you feel the warmth of your release building in your [pc.balls].\n\n");

	output("The rippling and squeezing of Edryn's cunt throws you past the point of no return.  Your eyes roll back as you unload into her musky tunnel, nearly losing your grip as your body gives up wave after wave of seed.  The contractions don't let up");
	if(pc.cumQ() < 100) output(" even after you've finished.");
	else {
		output(", squeezing more and more cum into her horse-sized womb.  ");
		if(pc.cumQ() > 250) output("Her body gurgles noisily from the massive fluid injection it's just taken, and her belly expands noticeably.  ");
		if(pc.cumQ() > 500) output("It keeps going as your body spends the last of its massive reserves, bloating her to the point that she'll have trouble walking.  ");
		output("Her cunt keeps milking you even after.");
	}

	if(Flag("COC.EDRYN_AFFECTION") <= 1) output("\n\nYou pull out with a wet pop, and watch the mixed centaur-cum pour from her puffy lips in a waterfall.  It splatters onto the floor wetly as Edryn at last relaxes, dropping herself heavily onto a pile of pillows.  She shakes her head and puts her palms on the floor alongside her body, steadying herself as she attempts to regain her balance.  Edryn gives you a tired smile and says, \"<i>Ohhhh that was nice.  Most of my customers can't get me off like that.  Don't worry about filling me full of fillies either, I take some herbs to prevent that.  You should come back sometime, okay?</i>\"");
	else if(Flag("COC.EDRYN_AFFECTION") <= 3) output("\n\nShe sighs happily and looks down at you, \"<i>Ooh " + pc.short + ", you're the best.  We should do this again soon.  Oh goddess, I can feel my juices starting just thinking about it.</i>\"");
	else if(Flag("COC.EDRYN_AFFECTION") == 4) output("\n\nShe sighs happily and says, \"<i>Oh baby, you know what?  I'm never charging you again.  Just keep getting me off like that and we can do it anytime.</i>\"");
	else output("\n\nShe sighs contentedly and says, \"<i>Mmm, never stop visiting, okay?</i>\"", false);
	output("\n\nThe two of you wipe up as best you can, redress, and head back out to the bar.  You're consciously aware of how strongly your groin reeks of centaur-slut.  Your body, happy with the scent and scrutiny of the bar's patrons, refuses to go soft, providing a wonderful view of your cum-slicked member.  Giggles and laughter break out around you as you leave, though more than a few of those taking notice have hard nipples or tents of their own.");
	if(Flag("COC.EDRYN_AFFECTION") >= 4) edrynPregChance();
	pc.orgasm();
	applyAinaMareMuskEffect();
	//dynStats("sen", -3);
	if (pc.lust() < 30) pc.lust(30, true);
	processTime(40);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function fuckEdrynNonTaur():void {
	showEdryn();
	clearOutput();
	//output(images.showImage("edryn-fuck-as-non-taur"));
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	if(x < 0) x = 0;
	output("She wiggles her more than ample backside towards you, squelching wetly against your ");
	if(pc.tallness < 48) output("[pc.face]");
	else output("body");
	output(".  She looks over her shoulder and says, \"<i>If you don't want your gear to smell like a horny centaur, you ought to shed it and get me warmed up with your tongue.</i>\"  You hastily remove it");
	if(pc.tallness > 72) output(" and drop down to your knees to better level yourself with her");
	output(", pressing your " + pc.face() + " into her slick folds and tasting her flavor.  Your nose easily slips into her gash as your tongue explores it, testing and tasting thick, liquid centaur lust.  It's tangy and sweet, surprisingly unlike the scent it gives off.  You easily find her large clit and suckle on it, listening to the wet squelches and whinnies of pleasure.\n\n");

	output("With a gasp you pull back, a thin coating of female slime clinging wetly to your face.  She leans over her hindquarters, her human-half rosy with the heat of her arousal as she hands you a towel.  You wipe off, and listen to the 'splat-splat-splat' of her animalistic pussy-juice as it drips to the floor.  She's completely soaked in a way that you doubt even a succubus could replicate.  She crooks a finger and waggles back and forth, making her puffy, black cunt-lips jiggle ever-so-slightly.  You don't need any more encouragement.\n\n")
	if(pc.tallness < 60) output("You grab a stool so you'll be tall enough to fuck her properly and climb onto it.  ");
	output("Supporting your");
	if(pc.cockVolume(x) > 200) output(" hefty package with both hands");
	else output("self with your hand");
	output(", you guide your [pc.cock " + x + "] towards the shining, black horse-cunt in front of you.  It parts easily, like a velvet curtain.  You slowly slide forward into Edryn's welcoming nethers, enjoying not having to fight to get your large [pc.cockNoun " + x + "] in for a change.  She trembles as you pass the halfway point, ");
	if(pc.cocks[x].cType == GLOBAL.TYPE_EQUINE) output("feeling your ring of prepuce slipping between her lips.  ");
	else output("squirting a little bit of fluid on the floor.  ");
	output("The further you push inside, the more aware of her warmth you become.  Her body temperature is higher than a human's, and it feels almost good enough to make you melt.\n\n");

	output("She whinnies and pushes back against you, forcing your entire [pc.cock " + x + "] to slip up her well-lubed passage.  You slap her ass, watching the furred flanks jiggle slightly.  Edryn looks over her shoulder again to and gives you a sultry look.  Before you can puzzle out what she's trying to tell you, her entire cunt contracts tightly, like a silken vise.  It wrings your [pc.cock " + x + "] tightly, immobilizing you inside the powerful centauress and making your " + pc.legs() + " feel wobbly and weak.\n\n");

	output("Edryn relaxes slightly, enough to allow you movement, and you happily begin fucking her hindquarters, grabbing her tail for leverage as you pound against her.  Her entire body sways with your motions, even jiggling her breasts.  She matches you, pushing back with equal fervor until her copious cunt-juice is all over your belly and thighs as every thrust is announced with a loud SLAP.  She whinnies happily, fucking harder and harder until you're struggling not to be knocked over by the overenthusiastic woman.\n\n");

	output("She moans and whinnies while her animal cunt noisily slurps up your [pc.cock " + x + "], rising to a feverish pitch.  Everything suddenly shifts and you're knocked off balance. Clutching tightly to her tail, you hang on for dear life as she bears you down onto the floor.  Hundreds of soft pillows cushion the fall, and ensure that you're not crushed by Edryn's hindquarters, but you are completely pinned under her.\n\n");

	output("You feel like you should be doing something, but there's nothing you can do.  She never misses a beat, lifting up her back end until you're about to pop free, and then slamming back down, occasionally swatting your face with her uncontrolled tail.  Helpless underneath hundreds of pounds of horse-flesh, you're forced to lie there and take it, fucked like a sex toy for who knows how long.\n\n");

	output("When she finally cums, you're battered and sore, and she doesn't seem to care a bit.  She whinnies and pushes down HARD, making it difficult for you to breathe.  Her pussy spasms and begins milking your dick.  It tightly contracts in a ring around your base that slides up to the tip, but the muscular contractions happen so quickly there are more rings of pleasure squeezing you than you can count.  Your heart beats madly in your chest while you try to breathe and orgasm simultaneously, but your cock is the only one having any luck.\n\n");

	output("Your eyes roll back as you unload into Edryn's musky tunnel, giving up on breathing as your body gives up wave after wave of seed.  The contractions don't let up, ");
	if(pc.cumQ() < 100) output("even after you've finished.\n\n");
	else {
		output("squeezing more and more cum into her horse-sized womb.  ");
		if(pc.cumQ() >= 250) output("Her body gurgles noisily from the massive fluid injection it's just taken, and her belly expands noticeably. ");
		if(pc.cumQ() >= 500) output("It keeps going as your body spends the last of its massive reserves, bloating her to the point that she'll have trouble walking.  ");
		output("Her cunt keeps milking you even after you've finished.\n\n");
	}
	output("As the edges of your vision start blacking out, Edryn ");
	if(pc.hasKnot(x)) output("tries to rise, lifting up enough for you to get a few good breaths in, but your knot keeps her locked to you, and the two of you are tied together for another minute or two while it deflates, emptying the very last dregs of your spunk into her.  You pop free, ");
	else output("slowly rises up off of you, ");
	output("and like a dam being broken, a wave of mixed sexual fluids dumps from her puffy lips onto you.  Edryn sighs happily, and you realize her tongue is hanging from her mouth with her eyes slightly rolled back.  You realize that though she endeavors to act restrained, her body is determined to be a wanton slut.\n\n");

	if(Flag("COC.EDRYN_AFFECTION") <= 1) output("She sighs happily and looks down at you, \"<i>Ohhhh that was nice.  Most of my customers can't get me off like that.  I hope you're ok!  Don't worry about me getting pregnant either, I take some herbs to prevent that sort of thing until I'm ready for it.</i>\"\n\n");
	else if(Flag("COC.EDRYN_AFFECTION") <= 3) output("She sighs happily and looks down at you, \"<i>Ooh " + pc.short + ", you're the best.  We should do this again soon.  Oh goddess, I can feel my juices starting just thinking about it.</i>\"\n\n");
	else if(Flag("COC.EDRYN_AFFECTION") == 4) output("She sighs happily and says, \"<i>Oh baby, you know what?  I'm never charging you again.  Just keep getting me off like that and we can do it anytime.</i>\"\n\n");
	else output("She sighs contentedly and says, \"<i>Mmm, never stop visiting ok?</i>\"\n\n");
	output("The two of you clean up as best you can, redress, and head back out to the bar.  You're consciously aware of how strongly you reek of centaur-slut.  Your body, happy with the scent and the scrutiny of the bar's patrons, refuses to go soft, providing a more-than-ample tent.  Giggles and laughter break out around you as you leave, though more than a few of those taking notice have hard nipples or tents of their own.");
	if(Flag("COC.EDRYN_AFFECTION") >= 4) edrynPregChance();
	pc.orgasm();
	applyAinaMareMuskEffect();
	//dynStats("sen", -3);
	if (pc.lust() < 30) pc.lust(30, true);
	processTime(40);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function edrynBar():Boolean {
	if(flags["COC.EDRYN_NEVER_SEE_AGAIN"] == undefined && hours >= 14 && hours <= 19 && (hours < 17 || flags["COC.EDRYN_NUMBER_OF_KIDS"] == undefined))
		return true;
	return false;
}
//Hel x Edryn Threesome
/*Sahvin
Requirements:
-Hel is in Fuckbuddy or Follower mode
-Edryn is giving herself for free
-PC has a cock that fits Edryn's standards
-PC must be tall enough so their head is over Edryn's ass -- (ie, 4ft + ?)

Scene proc's the first time the PC visits the Wet Bitch after all requirements are met, during Edryn's normal hours. Hel can be found in the Wet Bitch every third day from then on -- this does not disrupt her other functions or appearances.
*/

//Introduction -- Hel x Edryn -- Wet Bitch Entrance
//(PC goes to the Wet Bitch during Edryn's hours)

public function edrynHeliaThreesomePossible():Boolean {
	if (flags["COC.EDRYN_HELIA_LAST_THREESOME_CHECK"] == hours) //Only choose action once per visit to the bar
		return flags["COC.EDRYN_HELIA_LAST_THREESOME_CHECK_RESULT"] != 0;
		
	flags["COC.EDRYN_HELIA_LAST_THREESOME_CHECK"] == hours;
	if (!pc.hasGenitals() || hours < 14 || hours >= 20 || rand(2) == 0 || (!(flags["COC.HEL_FUCKBUDDY"] > 0)/* && !kGAMECLASS.helFollower.followerHel()*/)
	|| (flags["COC.HEL_FOLLOWER_LEVEL"] == 1 && flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined)) {
		flags["COC.EDRYN_HELIA_LAST_THREESOME_CHECK_RESULT"] = 0; //Make the saved time negative to indicate Helia is not at the bar right now
		return false;
	}
	flags["COC.EDRYN_HELIA_LAST_THREESOME_CHECK_RESULT"] = 1;
	return true;
}

public function helAppearance():void {
	output("\n\nTo your surprise, you see Hel the salamander sitting in a corner table, a pair of foxy fox-morph girls sitting on her lap.  When she sees you enter, the pretty reptile lifts her tankard and shouts, \"<i>Hey! " + pc.short + "! Over here!</i>\" over the loud noises of the bar.");
	//(\"<i>Hel</i>\" button added to the Wet Bitch menu)
}

//\"<i>Hel</i>\" in Wet Bitch Menu (First Time)
public function approachHelAtZeBitch():void {
	clearOutput();
	clearMenu();
	//output(images.showImage("hel-chat-at-bar"));

	if(edrynBar() && pc.cockThatFits(edryn.vaginalCapacity()) >= 0 && Flag("COC.EDRYN_AFFECTION") >= 4 && flags["COC.HEL_EDRYN_OFFER"] == undefined) {
		output("\"<i>Hey there, lover mine,</i>\" Helia says with a coy grin as you take a seat across from her.  The two fox-girls giggle drunkenly, prompting Hel to give them each a playful slap on the ass and send them on their way.  \"<i>Well, fancy meeting you here, " + pc.mf("handsome", "beautiful") + ".  In town for business... or pleasure?</i>\" she purrs with a little wink.\n\n");

		output("You spend a few minutes talking with the salamander, brushing off her question to ask her what she's doing in Tel'Adre.  With a little laugh, she says \"<i>Just found the place a couple of days ago.  How the hell did I not know there was an entire town of people out here?  Anyway, so I get here and this smoking hot centauress starts waving this gem all over me, and--</i>\"\n\n");

		output("\"<i>Centauress? You mean Edryn?</i>\"\n\n");

		output("\"<i>Yeah!  That's the one!  Oh man, I'd pay a pretty gem to stick my tail up her flanks!</i>\" she laughs, snaking her tail under the table to tickle your thighs.  You give her prehensile extremity a little slap until it comes to rest in your lap, snuggling up around your [pc.hips] as Hel nonchalantly chugs down the rest of her ale.\n\n");

		output("Sitting with the salamander, you notice across the crowded bar that Edryn is sitting at her table, sipping a little glass of wine.  Catching your eye, the centauress gives you a sultry wink.  An idea forms in your mind: you could easily introduce the two girls.  Do you?");
		IncrementFlag("COC.HEL_EDRYN_OFFER");
	}
	else {
		output("\"<i>Hey there, lover mine,</i>\" Helia says with a coy grin as you take a seat across from her.  The two fox-girls giggle drunkenly, prompting Hel to give them each a playful slap on the ass and send them on their way before swinging over and taking her place on your lap.  \"<i>Well, fancy meeting you here, " + pc.mf("handsome", "beautiful") + ".  In town for business... or pleasure?</i>\" she purrs with a little wink.\n\n");

		output("You spend a few minutes talking with the salamander, joking and laughing with your inebriated lover.  ");
		//Eventually, though, Hel gives a nod toward Edryn, sitting a ways away from you, and asks if you'd be up for a little threesome time.  Are you?\n\n", false);
		output("  Eventually, though, Hel gives you a sultry look and asks if you're up for a little group activity.  Are you?\n\n");
	}
	//(Display Options: [Threesome] [Leave]
	if (edrynBar() && pc.cockThatFits(edryn.vaginalCapacity()) >= 0 && Flag("COC.EDRYN_AFFECTION") >= 4 && flags["COC.HEL_EDRYN_OFFER"] == 1)
		addButton(0, "Edryn3Some", helEdrynThreeSomeStartYerEngines);
	addButton(1, "Fox Girls", heliaPlusFoxyFluffs);
	addButton(14, "Leave", leaveHelInZeBitch);
}

//First Time - Leave
private function leaveHelInZeBitch():void {
	clearOutput();
	if(flags["COC.HEL_EDRYN_OFFER"] == 1) {
		output("You decide against trying to set something up between the girls -- you like your lovers separate for now.  You spend the rest of the hour quietly chatting with Helia before giving her a friendly kiss goodbye and stepping away.");
	}
	else {
		output("You brush Helia's request off, saying you aren't much interested in a group right now.  She sighs dejectedly, but quickly recovers and gives you a knowing wink.  \"<i>Well, maybe later.  I know you like some group play as much as I do.</i>\"\n\n");

		output("You spend the rest of the hour quietly chatting with Helia before giving her a friendly kiss goodbye and stepping away.");
	}
	processTime(25);
	clearMenu();
	addButton(0, "Next", barTelAdre);
}

//First Time -- Threesome
public function helEdrynThreeSomeStartYerEngines():void {
	clearOutput();
	if(flags["COC.EDRYN_TIMES_HEL_THREESOMED"] == undefined) {
		output("Suddenly, an idea forms in your mind.  You ask Hel if she'd like to meet Edryn.\n\n");

		output("\"<i>Wh-- Really?</i>\" she gasps, eyebrows arching.  Her tail starts wagging excitedly in your lap until you stand, taking Hel's hand in yours and leading her over to Edryn's table.  The centauress waves amicably as your approach, though she cocks her head to the side as she notices the other girl on your arm.\n\n");

		output("\"<i>Hey, " + pc.short + ",</i>\" Edryn says with a half-smile. \"<i>Who's your friend?</i>\"\n\n");

		output("You introduce the girls, and with a nod from Edryn, you both sit at the centauress's table.  You spend a few minutes chatting amicably, and are gratified to see how wonderfully Hel and Edryn are getting on.  Within minutes they're comparing stories of Edryn's guard duty against Hel's adventures as a wandering berzerker.  You let them talk for a little while, but eventually you bring up your reason for bringing Hel over to meet the centauress.\n\n");

		output("Surprisingly for the salamander, Hel blushes brightly when you mention her little crush on Edryn.  The centauress gives a girlish giggle at the sight of Hel turning bright red, but quickly waves it off.  \"<i>Don't worry about it, cutie,</i>\" Edryn says, taking Helia's hand in hers.  \"<i>Looks like " + pc.short + " forgot to mention: I do a little 'wet work' on the side.  " + pc.mf("He", "She") + " and I have a little understanding, and since I'm horny and you're cute... What do you say we make your wish come true?</i>\"\n\n");

		output("Hel just about squeals with delight.  She nods her head emphatically, making both you and Edryn laugh.  With a knowing look, Edryn takes you and Hel by the hand and leads you into her private room.");
	}
	//Repeat -- Threesome
	else {
		output("You take Hel's hand and lead her over to Edryn's table.  The centauress smiles wide as you approach and invites you to sit.  You spend a few minutes in pleasant conversation before Hel eagerly asks if Edryn's in the mood for a little group fun.\n\n");

		output("\"<i>Well, normally I'm a twosome sort of girl, but... For you two, I can make an exception.</i>\"\n\n");

		output("Grinning, the three of you make your way up to Edryn's private chambers.");
	}
	processTime(5);
	clearMenu();
	addButton(0, "Next", threesomeEdrynAndHel);
}

//THREESOME SEX
private function threesomeEdrynAndHel():void {
	clearOutput();
	//output(images.showImage("edryn-hel-threesome"));
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	IncrementFlag("COC.EDRYN_TIMES_HEL_THREESOMED");
	output("You arrive in Edryn's private room, a small dark alcove in the bar with a healthy layer of pillows covering the floor.  You start to disrobe, watching as Hel is nearly crushed up against a wall by a sudden butt-bump from Edryn: \"<i>You better start warming me up with that long lizard tongue, cutie,</i>\" she says, herself yanking off her loose shirt.\n\n");

	output("Hel gets to work without further prompting, grabbing Edryn's wide flanks and burying her face into the centauress's horse-cunt. You grab your [pc.cock " + x + "], stroking yourself off to the show unfolding before you.  Edryn whinnies happily, wiggling her hips into Hel's face, crushing the salamander further and further into the wall.\n\n");

	output("Alright, alright.  You break the girls up before Edryn cums just from the oral assault.  It takes a moment of thought to figure out how to make this threeway work with Edryn's massive horse body.  You give Hel a leg up, getting her mounted on Edryn's back, and take up position behind the centauress.\n\n");

	output("Hel rolls over on her back, using her legs to steady on Edryn's back as you rub your [pc.cock " + x + "] against Edryn's gaping horsecunt, making the centauress shudder.  The shudder nearly throws Hel off her back, causing the salamander to dig her claws painfully into Edryn's sides.  She bucks back in surprise, impaling herself right on your [pc.cock].\n\n");

	output("Edryn clops back, forcing you to stumble until Edryn has taken your cock up to the hilt inside her.  Your back slams against the wall and your hips buck into the centauress's slick fuckhole.  The horse-girl's cunt contracts around your shaft like a hot, silken vice, already starting to milk you.  You start to pump into her, withdrawing until your cock's only just parting her vaginal lips before thrusting hard up to the hilt");
	if(pc.balls > 0) output(", your sack slapping wetly against the bottom of her cunny");
	output(".\n\n");

	output("Atop the centaur, Hel scrambles back until her ample ass is level with Edryn's.  Her tail snakes out, wrapping around your waist before its hot, narrow tip pokes up against Edryn's tight backdoor.  Now with Helia's meaty tail wrapped tight around you, you're restricted to shorter thrusts into the centaur, which you make up for by increasing your speed, slamming into her tight depths with enough force to badly bruise any human.  At the height of one of your thrusts, Hel finally gets the tip of her tail through Edryn's tight asshole, pushing in just an inch and already making her mount scream in ecstasy.\n\n");

	output("You decide to pull double-duty, and lean forward to bury your face between Hel's sexy thighs.  The salamander gasps as your tongue slides out, teasing her outer lips, flicking gently across her little clit before slipping into her boiling-hot slit.  You start to piston your hips and face in and out, picking up an unsteady rhythm as you fuck the centaur and salamander at once, assaulting their gaping cunts to the beat of Hel's slithering tail working in and out of Edryn's ass.\n\n");

	output("It seems the double-attack is too much for poor Edryn to handle, however, and you grin ear to ear as she grabs her tits and bucks her hips, her forelegs collapsing as pleasure overtakes her.  Hel yelps and tumbles back, right out of your reach until her back slams into Edryn's human half.  Not willing to let the salamander go without release, you leap onto Edryn's hefty ass and slide down after her, hefting up your [pc.cock " + x + "] like a spear and ramming it right into Hel's waiting cunt.  She screams with pleasure and pain as your shaft rams up into her cervix, leaving your face smooshed between her tits.  You're about to start fucking her in earnest, but before you can, your ass is suddenly penetrated by Hel's long tail.  You yell aloud, suddenly entrapped by the salamander's burning cunt and sudden tail-fuck.\n\n");

	output("You cum a moment later, grabbing Hel by the shoulders and thrusting as deep into her as you can.  You unleash the beast, spraying your cum into her womb with your last mighty blow.  Hel's head lolls back with the sensation of your cum filling her, and is soon moaning as she cums around you, milking the last of the cum out of your now-sore dick.\n\n");

	output("The three of you lay in a heap, all panting and gasping, engulfed in pleasure and exhaustion.  You lean over to check on the centauress you just used as a bed, and are gratified to see that Edryn looks to have been fucked silly, her eyes crossed and tongue hanging lewdly from her mouth.  Leaning against her back, Hel's own mouth is agape as she breathes heavily, slowly fingering a bit of your cum from her stuffed snatch.  You withdraw from her and clamber down from the pile to stick your cock in Edryn's open mouth, using her to clean your shaft.\n\n");

	output("When you're satisfied, you stumble and collapse against her horsebody, barely fighting off an intense urge to sleep.  The centauress moans contentedly, \"<i>Mmm, we should do this again sometime. You two were amazing.</i>\"\n\n");

	output("\"<i>Oh yeah. We... We gotta go again sometime,</i>\" Hel agrees, nearly falling off Edryn's back.  You give each of the girls a long kiss before collecting your [pc.gear] and walking off back to camp.\n\n");
	pc.orgasm();
	//kGAMECLASS.helFollower.helAffection(5);
	processTime(45 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

////Pregdryn:
public function findOutEdrynIsPregnant():void {
	showEdryn();
	clearOutput();
	output("Edryn is lying down at her table, pensively circling a finger around a glass of water and poking listlessly at her plate of greens.  Her eyes keep glancing down or to the side every time you meet her gaze.  You've never seen the shameless centaur bothered like this, and you grab her by the shoulders to ask, \"<i>What's wrong?</i>\"\n\n");

	output("She finally looks up at you, her large brown eyes wet with moisture, and explains, \"<i>I-I'm pregnant.  I saw the covenant about it and had them check with their magic.  You're the father.</i>\"\n\n");

	output("The centaur blushes fiercely, blurting everything out in a rush now that she's started to talk, \"<i>I don't know how it happened!  I've been taking herbs to prevent this kind of thing, and I've NEVER heard of someone getting pregnant while they're on these.</i>\"  She gives her flank a gentle pat as she keeps speaking, \"<i>There's just something about your cum I guess!  Our child will be a centaur, just like her mom, and I intend to keep her.</i>\"\n\n");

	output("<b>How do you react?</b>");

	processTime(3);
	//[Shocked] [Pleased] [Aroused (Requires Wang)]
	clearMenu();
	addButton(0, "Shocked", shockedByEdrynsPregnancy);
	addButton(1, "Pleased", pleasedbyPregdryn);
	if (pc.hasCock())
		addButton(2, "Aroused", arousedByPregdryn);
	else
		addDisabledButton(2, "Aroused", "Aroused", "This scene requires you to have cock.");
}

//Shocked
private function shockedByEdrynsPregnancy():void {
	showEdryn();
	clearOutput();
	output("You stammer for an answer, unsure of what to say in light of this startling revelation.  Edryn looks on the verge of tears and all you can do is struggle for words.  She grips the table, her knuckles turning white while her eyes flick from side to side in a panic.");

	output("\n\n<b>What do you do?</b>");
	processTime(1);
	//[Accept it] [Reject it]
	clearMenu();
	addButton(0, "Accept It", shockedByPregdrynThenAccept);
	addButton(1, "Reject It", beAnAssholeToPregdryn);
}

//Accept it
private function shockedByPregdrynThenAccept():void {
	showEdryn();
	clearOutput();
	output("Leaning forward, you grab hold of Edryn's hands and cradle them in your grip.  She looks back up at your eyes and reads your expression, breaking into a smile as she reads the feelings on your face.\n\n");

	output("\"<i>Thank you!  You had me really going for a moment there, you know that?  Wow, that is a weight off my chest,</i>\" exhales Edryn.  She climbs up onto her hooves and whispers, \"<i>I've got to use the little ponies' room, I'll be right back lover,</i>\" before she departs.\n\n");

	processTime(1);
	//[To Pregnant Offer]
	clearMenu();
	addButton(0, "Next", pregdrynOffer);
}

//Reject it
private function beAnAssholeToPregdryn():void {
	showEdryn();
	clearOutput();
	output("You look the panicked centauress dead in the eye and explain that what she does with her body is her business, and you want nothing to do with it.  She stares dumbfounded for a split-second before her face colors red with rage.  Edryn screams, \"<i>GET THE FUCK AWAY FROM ME THEN!</i>\"\n\n");

	output("Everyone in the bar turns to watch the commotion, and with an angry, hormonal centaur and this many eyes on you, it would be best to depart.\n\n");

	output("<b>(Edryn will no longer speak with you.)</b>");
	
	flags["COC.EDRYN_NEVER_SEE_AGAIN"] = 1;
	
	processTime(3);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}

//Pleased
private function pleasedbyPregdryn():void {
	showEdryn();
	clearOutput();
	output("You crack into a smile and congratulate the lusty centaur.  She giggles with relief at your words and wipes a bead of sweat from her brow as you finish.  Edryn exclaims, \"<i>I'm so glad you're happy about this!  I don't expect you to drop your quest and move in with me or anything like that, but it'll be wonderful to hear the clipper-clopper of little hooves in this town.</i>\"\n\n");

	output("Edryn pulls back from the table and stretches, her muscles visibly loosening as the tension oozes out of her imposing frame.  She whispers, \"<i>Be right back lover, I've got to make a stop at the little ponies' room,</i>\" before she departs.\n\n");

	processTime(3);
	//[To Pregger Offer]
	clearMenu();
	addButton(0, "Next", pregdrynOffer);
}

//Aroused
public function arousedByPregdryn():void {
	showEdryn();
	clearOutput();
	output("You break into a grin bordering on lecherousness and congratulate the lusty centaur.  Her eyes widen for a moment, shocked from your expression, then narrow into a sultry expression.  Edryn teases, \"<i>I think someone has a bit of a pregnancy fetish, hrmm?  Is it the thought of my tits getting swollen with milk or the idea of me being jiggly and randy all the time that does it for you?</i>\"  She shivers, the outlines of her prominent nipples straining against her already-tightly-stretched tunic.  Edryn's eyes drop down and a rueful smile works its way across her face as she admits, \"<i>Great, now I'm turned on too!  Let me go use the little ponies' room. Then, MAYBE, we can help take care of each other.</i>\"\n\n");

	processTime(3);
	//[To Pregger Offer]
	clearMenu();
	addButton(0, "Next", pregdrynOffer);
}

//Pregger Offer
private function pregdrynOffer(cs:Boolean = true):void {
	showEdryn();
	if(cs) clearOutput();
	//Used to call post birthing sexings.
	if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] == undefined) {
		//Actually choose the sex scene
		edrynSexSelecter();
		return;
	}
	//VERY Pregnant Offer
	if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] < 250 * 60) {
		output("Edryn struggles to move, practically waddling thanks to her swollen, pregnant belly.  As usual, the glistening black lips of her sex are on display, and with the hormones pouring through her, she's leaking a steady trail of slime.  The scent coming off her is unreal!  It's like it's reaching right into your brain and cranking the 'fuck' dial up to maximum.  ");
		if(pc.cockTotal() > 1) output("All of your [pc.multiCocks] fill in seconds, growing rock hard and actually aching with their need.  ");
		else if(pc.cockTotal() == 1) output("Your [pc.cock] fills in seconds, growing rock hard and actually aching with need.  ");
		output("You're totally dazed by the massive spike in arousal, and ");
		if(pc.slut() < 100 || pc.cockTotal() < 1) output("you struggle not to touch yourself.");
		else output("you can't stop yourself from grabbing [pc.oneCock] and stroking it under the table.");
		output("\n\n");

		output("You wouldn't notice her return if it wasn't for the increase in potent centaur pheromones hitting your nostrils.  It takes a hand slipping under the table to play with your ");
		if(pc.balls > 0) output(pc.ballsDescript());
		else if(pc.hasSheath()) output("sheath");
		else if(pc.cockTotal() > 0) output(pc.cockDescript(0));
		else output("crotch");
		output(" to rouse you from the incredible sexual haze.  ");
	}
	//Mildly pregnant offer
	else {
		output("As usual, when Edryn pivots to leave, she gives you a perfect view of her unusual vagina.  The glistening black lips of her sex practically ooze moisture, and the scent coming off her seems even more potent than usual, making your head swim.  ");
		if(pc.cockTotal() > 1) output("All of your [pc.cocksLight] fill in seconds, growing rock hard and actually aching with their need.  ");
		else if(pc.cockTotal() == 1) output("Your [pc.cock] fills in seconds, growing rock hard and actually aching with need.  ");
		output("You're a little bit dazed by the sudden spike in arousal, and ");
		if(pc.slut() < 100 || pc.cockTotal() < 1) output("you struggle not to touch yourself.");
		else output("you can't stop yourself from grabbing [pc.oneCock] and stroking it under the table.");
		output("\n\n");

		output("As usual, you're barely cognizant of her return.  It isn't until a hand sneaks under the table to surreptitiously fondle your ");
		if(pc.balls > 0) output(pc.ballsDescript());
		else if(pc.hasSheath()) output("sheath");
		else if(pc.cockTotal() > 0) output(pc.cockDescript(0));
		else output("crotch");
		output(" that you come out of your daze.  ");
	}
	
	//(NO WANGUUU)
	if(pc.cockTotal() == 0) {
		output("She looks down, eyes fixing on your crotch for a moment before she sighs, \"<i>Why did you get rid of your dick?  I like you a lot, but I don't really want to have sex with you like you are now.</i>\"\n\nEdryn leaves looking a little depressed.");
		//Bar menu?
		processTime(5);
		addButton(0, "Next", barTelAdre);
		return;
	}
	//(MEETS SIZE REQUIREMENTS)
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	//-1 = none fit.  Set x to 0 for big boys.
	if(x < 0) x = 0;
	if(pc.cockVolume(x) >= 24 && pc.cockVolume(x) < edryn.vaginalCapacity()) {
		output("Edryn is smiling radiantly as she continues to caress you under the table.  She asks, \"<i>");
		if(flags["COC.EDRYN_NUMBER_OF_KIDS"] == undefined) output("Does my scent have an even stronger effect on you now");
		else output("Are you going to cum just from sniffing at my cunt");
		output("?</i>\"  You try to deny it, but she pumps at your shaft and continues, \"<i>Don't lie dear, I can feel how hard you are now, and I DEFINITELY saw how dazed you were when I came back out.  Let's go back to my room so you can get another whiff, okay?</i>\"\n\n");

		output("The centaur doesn't wait for a reply, and takes off at a trot towards her quarters.  A few drips have splattered across the floor, leaving a trail for you to follow.  You get up, dazed with arousal and leaking pre-cum, and stagger through the bar to her room, practically lust-drunk.");
		applyDamage(new TypeCollection( { pheromone: 25, tease: 25 } ), edryn, pc, "minimal");
		
		//TO SEX!
		//doNext(fuckPregEdryn);
		output("\n\nHow do you want to handle this?  ");
		clearMenu();
		output("You could have some great, pregnant taur sex.");
		addButton(0,"Preg. Fuck", fuckPregEdryn);
		if(pc.biggestCockVolume() > edryn.vaginalCapacity()) {
			output("  Since at least part of you isn't acceptable to her, you could eat her out until you get off from her pheromones alone.");
			addButton(1, "NoFitEating", jizzFromEatingPregdrynOut);
		}
		output("  Or, you could go down on her until you're in a frenzy, then fuck her wildly.");
		addButton(2, "Eat,Rut,Fuck", eatEdrynPussyLikeABawss);
		return;
	}
	//(PC TOO BIG)
	else if(pc.cockVolume(x) > edryn.vaginalCapacity()) {
		output("Edryn brushes her hand over ALL of your [pc.cock] then jerks it back, startled.  She sighs, \"<i>Dear, that thing is a BEAST.  I mean, there's no doubt I'd love to get it inside me, but I promise it won't fit me.</i>\"\n\n");

		output("She looks at you pleadingly and practically begs, \"<i>Please, find a way to fit me.</i>\"  Edryn grabs you by the shoulders and whispers in your ear, \"<i>Being pregnant makes me so turned on ALL THE TIME.  I need you inside me.</i>\"\n\n");

		output("A thoughtful look crosses the centaur's face as she continues to pant in your ear, \"<i>Come on, lets go back to my room.  I'll find a way to tend to that monster if you'll eat me out.  Maybe the pheromones wafting off my cunt will get you off without me even touching you?  I've seen it happen before with some of my clients, and with how strong my scent is now...</i>\"\n\n");

		output("Edryn releases you and climbs up on all fours, making her way towards her room in the back of the establishment.  The smell of her need hangs heavy in the air, and you follow it like a lost puppy.  Of course, puppies don't have their massive, rock-hard maleness visible to everyone around them.  Thankfully, you reach her door quickly, and bolt inside.");
		applyDamage(new TypeCollection( { pheromone: 25, tease: 25 } ), edryn, pc, "minimal");
		
		//Go to 'too big or too small eat out'
		addButton(0, "Next", jizzFromEatingPregdrynOut);
		return;
	}
	//(PC TOO SMALL)
	else {
		output("Edryn giggles, \"<i>When did you get this small?  I've seen ponies with bigger kits!</i>\" but her hand continues to stroke you.  You squirm in her grasp, about ready to burst.  The pregnant centaur teases, \"<i>Dear, I don't think I'd notice something that small if you stuck it inside me.</i>\"\n\n");

		output("She laughs at the expression on your face and continues, \"<i>Oh don't be like that.  The truth is the truth.  You're still the father of my child.  Why don't we go back to my room?  You can eat me out till the centaur pheromones overpower your little dick and make it squirt, okay?</i>\"\n\n");

		output("The centaur doesn't wait for a reply, and takes off at a trot towards her quarters.  A few drips have splattered across the floor, leaving a trail for you to follow.  You get up, dazed with arousal and leaking pre-cum, and stagger through the bar to her room, practically drunk on lust.");
		
		applyDamage(new TypeCollection( { pheromone: 25, tease: 25 } ), edryn, pc, "minimal");
		//Go to 'too big or too small eat out'
		addButton(0, "Next", jizzFromEatingPregdrynOut);
		return;
	}
}


//Fucking
public function fuckPregEdryn():void {
	clearOutput();
	showEdryn();
	//output(images.showImage("edryn-preggo-fuck"));
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	if(x < 0) x = 0;
	clearOutput();
	//NONTAUR
	if(!pc.isTaur()) {
		output("Edryn lurches forwards as soon as the door closes behind you, slamming her powerful frame into you with enough force to propel you several feet back onto a large pile of pillows in the corner.  The feeling of her massive, milk-drooling teats ");
		if(pc.tallness < 60) output("bouncing against the top of your head");
		else if(pc.tallness < 84) output("battering your face");
		else output("crushed against your chest");
		output(" was totally worth the bruise-inducing impact.  Edryn pivots about, her hooves clattering noisily against the room's floorboards until she's presenting her hind end to you.  Her tail lifts of its own accord and displays the swollen, black lips of her sex.  A potent glaze of centaur-fluid drips from the gash in a steady trickle, splattering over your " + pc.feet() + " as your equine lover closes in.\n\n");

		output("You tear off your [pc.gear] in a flash, fully exposing your ");
		if(pc.cockTotal() > 1) output("chosen ");
		output(pc.cockDescript(x) + ".  It drips with anticipation, leaking drops of pre-cum with each inhalation of your mate's over-sexualized slit's scent.  Edryn looks over her shoulder to gauge the distance, but when she sees your state her face breaks into a happy smile.  She says, \"<i>Steady now, we wouldn't want you to miss your target, would we?</i>\" as her backside slowly descends, splattering hot sexual fluids over your length.\n\n");

		output("The centaur's gash devours your [pc.cock " + x + "] with a long, wet slurping noise.  Her body-heat is much warmer than your own, wrapping slippery heat around every sensitive inch of your fuck-pole.  The flesh around you squeezes and massages instinctively.  It feels so good that it seems as if your [pc.cock " + x + "] is going to melt under the onslaught of pleasure.  Edryn moans loudly and begins to pump her hips atop you, \"<i>Oooh yes, thats perfeeeect...</i>\"\n\n");

		output("Heavy thuds echo as hundreds of pounds of pregnancy-enhanced centaur backside are slammed into you over and over.  Were it not for the pillows absorbing some of the force, your pelvis would have been crushed with Edryn's first movement.  Her juices splatter with each rough fuck, soak your chest, and squirt up to your face.  You lie under her and moan, pumping back against her, but she doesn't even notice!  Her motions are backed up with more weight than your entire body, and her rough, pumping fuck only gets more and more intense.\n\n");

		output("You grab hold of her tail and pull yourself against her with all of your strength, slamming your body into her cunt as brutally as possible.  Your own orgasm is just a moment away, and Edryn's pleasured moans and whinnies reach an ecstatic crescendo.  Her cunt squeezes you tightly, the hot vice milking you hard, and forcing your climax on the spot.  It squeezes tightly at the base, then ripples pressure to the tip, drawing explosive bursts of cum from your sexually brutalized member.\n\n");

		output("Edryn sinks down, her whole body shaking and shuddering while milk fountains from her swollen breasts.  Her hands reach up to grab her nipples and tug on the milk-spouts.  They look longer now than before her pregnancy.  Her bloated milk-spouts are at least an inch or two long!  ");

		if(pc.cumQ() < 100) {
			output("Your [pc.cock " + x + "] dumps the last of its seed into her hungry cunt and softens slightly.  Her warm cunt's constant milking motions continue, still pleasurable, but they prevent you from going soft until the centaur's orgasm has concluded.");
		}
		else if(pc.cumQ() < 500) {
			output("Your [pc.cock " + x + "] spurts thick flows of seed into her hungry cunt, flooding her snatch with an abnormally large load of semen.  Her warm cunt's constant milking motions continue, forcing more and more of your spunk inside her until her own orgasm has concluded.");
		}
		else {
			output("Your [pc.cock " + x + "] erupts, pouring a thick wave of seed into the centaur's hungry cunt.  The constant milking motions don't let up while Edryn's orgasm continues, helping you flood her with even more spooge.  Even after your pregnant lover's orgasm has concluded, your [pc.cock " + x + "] keeps dumping more [pc.cum] into her until it's soaking and dripping from her huge, furry ass.");
		}

		output("\n\n");
		output("You give her over-sized ass a gentle squeeze, massaging it lightly while Edryn comes back down from the wonderful sex.  She looks back at you and pants, \"<i>By Marae I needed that.</i>\"\n\n");

		output("The centaur raises her back half up with a long wet 'schliiiiick'.  You pop free with a gasp and are given a perfect view of your work.  Her pussy's lips are slightly parted and glazed with a coating of white fluid.  The black-lipped cunt continues to drool sticky, sexual slime, but the color has gotten a bit more opaque thanks to your contributions.  The smell of sex fills the room, making your [pc.cock " + x + "] stiffen again.\n\n");

		output("Edryn leans against the wall, panting and looking back at you.  She gives an exhausted smirk but doesn't look like she could handle another round.  You start to shiver; without the warmth of her love-tunnel wrapped around you, the room seems that much colder.  Glancing over, you find your equipment and put it on.  It's difficult to dress with an audience's rapt attention, but you manage to pull it off.\n\n");

		output("After gathering your pouches, Edryn looks to have recovered.  She advances on you and wraps her arms around you, smashing your face squarely between her milk-filled tits.  You can smell the liquid dripping from her nipples.  It makes you happy to know your daughter will have such a bounty to feed on as she grows.  Edryn thanks you, \"<i>That was wonderful dear.  I'll probably be horny and soaked again in a few minutes, so please, come back soon.  I'm going to be a sopping wet mess until our child is born.</i>\"");
	}
	//TAURZILLA
	else {
		output("Edryn smiles at you as you close the door behind you.  She stretches and lays out on a large batch of pillows, using them to help support the added weight of her pregnancy.  Her hindquarters are facing towards you, and she twists back to give you a 'come-hither' gesture.  You hesitantly climb down into the soft, padded mass with her and align your body behind hers.  Her position is perfect, and you wrap your arms around her 'human' waist to drag your lower half into position.  Edryn grabs your [pc.face] and pulls you into a kiss, her archery-strengthened arms easily maintaining their grip as the two of you get settled into place.\n\n");

		output("You break the kiss and suck the bottom of her earlobe into your mouth, straining to keep your mouth steady as you pull your [pc.cock " + x + "] into position with her needy sex.  The [pc.cockHead " + x + "] slips into the hot folds, forcing a gasp from your lips that lets Edryn's earlobe escape its oral prison.  She smirks, then nibbles at your shoulder while you slide the rest of the way into her large, slippery channel.  It's a near perfect fit thanks to your similar body types, and the both of you sigh out whinnies of pleasure.\n\n");

		output("Edryn bites down harder, sending a jolt of pain through your shoulder.  Her hips wiggle against yours, and she begins rhythmically clenching and relaxing her entrance, squeezing you tightly ");
		if(!pc.hasSheath()) output("by the base");
		else output("just above your sheath");
		output(".  The lower half of your body arches, pulling your [pc.cock " + x + "] partway out, then lurches back forward to bury it deep inside her.  The impact jiggles her flesh from her ass to her shoulders, and you feel it underneath you as an instinctual, barely thought sign of sexual dominance.\n\n");

		output("The centauress pulls back and moans, \"<i>Oh gods yes, it feels so much better pregnant!  My pu-pu-ahhhh-ussy is so much WETTER.  It's like I've got a faucet back there!  And I'm soo-ohhhh sensitive!  Ung fuck " + pc.mf("stud", "dear") + " don't stop.  Please don't stop!</i>\"\n\n");

		output("You grunt from the force of your exertions and begin to fuck her a little more roughly.  Your arms squeeze tightly around her midsection with a mixture of affection and need as you fulfill her request.  You pound her swollen, dripping cunt with hard strokes that make your intertwined forms shiver, dislodging a few pillows.  Scrabbling noise fills the air.  Your legs are scrambling for purchase, but there's no traction.  Lying sideways in the pillows with your pregnant lover prevents you from fucking quite as hard as your body would like.\n\n");

		output("Her slippery, silken tunnel feels wonderful as it contracts and squeezes your maleness with vice-like tightness.  Edryn's mouth hangs open, and as her eyes start to cross, you can feel the passage intensifying its muscular twitches.  She's on the brink of orgasm, but you aren't too far behind her.  You pull one arm up to her head and kiss her, running your tongue over her lips before sliding it inside to tangle with hers.  She undulates underneath you, convulsing as she reaches her peak.  Her juices erupt, splattering over your thighs");
		if(pc.balls > 0) output(" and [pc.balls]");
		output(".  Her twat clutches you so tightly that you're immobilized for fear of hurting yourself, and the tight seal of her entrance acts as a cock-ring, actually bloating your [pc.cock " + x + "] inside her.\n\n");

		output("Your [pc.cock " + x + "] is milked from [pc.sheath " + x + "] to [pc.cockHead " + x + "], culminating in a tight squeeze at the tip. Then it releases and starts all over again.  Instinctively, you whinny and explode inside the warm, soaking wet tunnel.  The french-kiss turns into a feverish slobber-fest while the two of you mate, lost to orgasm.");
		if(pc.cumQ() < edryn.vaginalCapacity()) {}
		else if(pc.cumQ() < 1000) output("Your prodigious jism output soaks her sloppy tunnel and drips from the entrance with the centauress' girlcum.");
		else {
			output("Your body's cum-production easily fills her channel to capacity.  Each successive spurt blasts a wave of fluid out from her overstuffed cunt, soaking the pillows, Edryn's ass, and your crotch.");
			if(pc.cumQ() >= 4000) output("  By the time you calm down you've soaked all the pillows and [pc.cum] is puddling underneath.");
		}
		output("\n\n");

		output("Edryn breaks the kiss with a strand of spit hanging in the middle.  She giggles euphorically, \"<i>Wow.  Ummm, wow!  That was nice!  Now get off me you ");
		if(pc.tallness > 74) output("big ");
		output("lug!</i>\"  She playfully pushes you back and tries to drag herself out from under you.  You laugh with her and pull back, letting your softening [pc.cockNoun " + x + "] pull free from her [pc.cumNoun]-glazed twat.  It escapes with a wet squish, releasing a torrent of [pc.cum] from the unplugged opening.\n\n");

		output("After you both get a chance to stagger up to your feet and get dressed, Edryn thanks you, \"<i>That was wonderful dear.  I'll probably be horny and dripping again in a few minutes, so please come back soon.  I think I'm going to be a sopping wet mess until our child is born.</i>\"\n\n");
	}
	processTime(25);
	pc.orgasm();
	//dynStats("sen", -.5);
	applyAinaMareMuskEffect();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//EAT THE BITCH'S CUNT OUT
private function jizzFromEatingPregdrynOut():void {
	showEdryn();
	clearOutput();
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	if(x < 0) x = 0;

	output("You shut the door behind you and rub your eyes, trying to adjust to the darkness in the room.  All the lights are out, save for a single candle on the far wall.  You peer about uselessly for a few seconds until inspiration strikes.  Her potent scent will lead you to her!  You lean down and start turning from side to side, sniffing about.  You hear a feminine giggle, though with the unfamiliar room you can't tell where it's originating from.  It's fairly easy to scent out your 'prey', and you've already determined from the strength of pussy-musk which corner of the room Edryn's in.\n\n");

	output("The smell is potent, sexual, and thoroughly inhuman.  You take a step closer and continue taking little sniffs, barely noticing as your ");
	if(pc.cockVolume(x) < 24) output("small dick begins to twitch and leak.");
	else output("mammoth cock drags the ground, leaking pre-cum.");
	output("  The urge to find the juicy, potent pussy at the center of the musk-cloud overrides your thoughts.  Stalking forwards in a haze of desire, you take deeper and deeper breaths, inhaling ever-greater quantities of Edryn's heavenly scent.  You know you're almost there – you can hear her quiet breathing.\n\n");

	output("You're so lost in desperate need that your hurried steps get you in trouble.  Your " + pc.foot() + " catches on something, and you fall inexorably forwards.  In a panic, you windmill your arms.  One slaps into fur-covered flesh with a loud 'SLAP', the other disappears into a mass of soft, yielding fabrics.  The pillows catch you, absorbing the fall, but your face splats directly into something warm, wet and aroused.  Edryn gasps and exclaims, \"<i>No need to be so rough about it!  I thought you might like some hide and seek... your dick seemed to like it, and I needed a moment to catch my breath.  It's not easy carrying your child around!</i>\"\n\n");

	output("Her words fall on deaf ears.  You push yourself up onto your elbows and lean forward, feeling strands of female lubricant hanging from your face as you inhale deep lungfuls of her scent.  [pc.EachCock] ");
	if(pc.cumQ() < 100) output("drips pre-cum onto the pillows.");
	else if(pc.cumQ() < 500) output("leaks pre-cum in a steady stream, quickly soaking a few pillows.");
	else output("pours out enough pre-cum to soak a pillow, and in no time your overenthusiastic dick is doing its damnedest to dribble over everything.");
	output("  It's a powerful smell.  The centaur's heady musk already has you on the edge, and you haven't even tasted her slit yet!  Your heart beats hard, as you grab onto her flanks with each hand and prepare to service your pregnant lover.\n\n");

	output("After being in the dark room for so long, your eyes have adjusted to the dim light.  Mere inches in front of you is Edryn's massive slit.  Its black folds are coated in a thick layer of slime that trails down to her bulbous clit, collecting before dripping off.  You lean forward, take a long, deep breath, and then smash your face into the gash.  Your tongue darts out, practically of its own accord, lapping at her inner folds and tasting the sweet, tangy nectar she drips.  The warmth is palpable, and the air is practically steaming with the heat of Edryn's desire as  you rub your face up and down the slit.  You lick and slurp at the slippery sweetness of her desire, but it never seems to be enough for you or your drooling [pc.cocksLight].\n\n");

	output("Squirming and writhing, Edryn moans, \"<i>Yessssss... right-ahhh-there.  Mmmm... I think you're hooked on my cunt, aren't you?</i>\"  She stretches back to pat your head and coos, \"<i>Yes that's a good " + pc.mf("boy","girl") + ", lap it allll up.  Oh my, you're dripping like a sieve just from eating me out!  Oooh yeah, lower, lick my cliiiiit-yes yes-ooooh... Mmm I bet the smell is just overwhelming you isn't it?  Why don't you suckle my clit and take a quick breather.  I bet you'll be spurting helplessly in no time.</i>\"\n\n");

	output("You tremble as you pull away, licking her lust from your lips and gasping for air as you shift to lick at her clit.");
	if(pc.isTaur()) {
		output("  Your [pc.legs] twitch weekly on the floor, forgetten about as you focus entirely on your hands, mouth, and pulsating [pc.cocksNounSimple].");
	}
	output("  Her button, like her pussy, is many sizes larger than a human's, and it's as big around as a golfball and several inches long.  You suck it into your lips and plunge a hand inside her slippery channel, fisting her while you suckle and bob on her clit.  Edryn whinnies and clenches around the invading fist.  Her cunt erupts and splatters your face with fluid, soaking you with her fragrant scent.\n\n");

	output("Startled from your sexual fog, you jerk back and gasp.  The smell – it's like sex distilled into orgasm and fired straight into your brain.  Your [pc.hips] shake uncontrollably, spasming wildly as your scent-addled mind sets off a full-body orgasm.  ");
	if(pc.hasVagina()) {
		output("Your [pc.vagina] contracts and spasms with the rest of you, ");
		if(pc.isSquirter()) output("squirting");
		else output("leaking");
		output(" in a pale imitation of Edryn's box.  ");
	}

	output("[pc.Cum] begins to ooze from [pc.eachCock] in a steady stream.  Your urethra bulges and flexes, forcing you to waste your seed all over Edryn's pillows.");
	if(pc.cumQ() < 1000) {
		output("  The flow gets thicker and thicker.  Edryn even remarks, \"<i>Oh my, my baby's daddy is just full of cum!  Let it all out for me dear, you did such a good job on my clit that you deserve release.</i>\" You squirt and dribble, breathing airborne orgasm and squirting ");
		if(pc.cumQ() < 3000) output("out the last of your liquid pleasure.");
		else output("ever greater amounts of liquid peasure.  Jism drips through the floorboards as you create a puddle a few inches deep.");
	}
	output("\n\n");

	output("Edryn laughs and hauls you up to embrace a tight hug.  She whispers in your ear, \"<i>Thank you for being so understanding.  I'm not normally this... sensitive, or potent.  You can keep doing this while I'm pregnant, but you'll need to fit me if you want any more sex after our child is born.</i>\"\n\n");

	output("You nod and give her milk-dripping teat a squeeze.  A squirt of the white stuff escapes before Edryn pushes you away.  You chuckle and get dressed while she does the same, but before you can escape her room, she lifts her shirt, squeezes a teat, and catches you in the face with her milk.\n\n");

	output("\"<i>Turn-about is fair play!</i>\" she exclaims. You leave, unable to dispute the logic.");
	processTime(20 + rand(10));
	applyPussyDrenched(pc);
	pc.girlCumInMouth(edryn);
	pc.orgasm();
	applyAinaMareMuskEffect();
	//dynStats("lib", 1, "sen", 2);
	pc.slowStatGain("l", 1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function edrynPregChance():void {
	//Get out if already pregged.
	if (flags["COC.EDRYN_PREGNANCY_INCUBATION"] != undefined) return;

	//See if any of the scenarios get her preg
	var preg:Boolean = false;
	//1% chance per 500mLs of cum, max 5%
	var temp:Number = pc.cumQ() / 500;
	if(temp > 5) temp = 5;
	temp *= pc.virility();

	trace("Edryn Preg Check Virility Score: " + temp);
	if(pc.cumQ() > 250 && temp >= rand(100)) {
		preg = true;
		trace("Edryn knocked up!");
	}
	else trace("Edryn not knocked up!");
	if (preg) {
		//pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_CENTAUR + 80);
		flags["COC.EDRYN_PREGNANCY_INCUBATION"] = 500 * 60; // nearly 21 day
		flags["COC.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET"] = undefined;
	}
}

public function edrynisPregnant():Boolean {
	return flags["COC.EDRYN_PREGNANCY_INCUBATION"] != undefined;
}

//Male PC + Edryn, preferred at camp with preggo variance + bonus if some BJ, scent-induced rut
//have the Scene taking place in Tel'Adre instead of the PC's Camp.
//Cunt tastes tangy and sweat.
//Cunt is warmer than human
//Strong pussy that can squeeze tight enough to hold you still.
//During orgasm contracts into cock-milking rings that happen so fast and so frequently you can't even track them
//Intro:
private function edrynFucktroduction():void {
	clearOutput();
	showEdryn();
	clearOutput();
	var x:Number = pc.cockThatFits(edryn.vaginalCapacity());
	if(x < 0) x = 0;
	var cost:Number = 0;
	switch(Flag("COC.EDRYN_AFFECTION")) {
		case 0:
			cost = 200;
			break;
		case 1:
			cost = 100;
			break;
		case 2:
			cost = 50;
			break;
		case 3:
			cost = 25;
			break;
		case 4:
			cost = 0;
			break;
		default:
			cost = 0;
			break;
	}
	if(!pc.isTaur()) {
		if(cost > 0) output("Coins exchange hands and her arm finds its way back inside your [pc.gear], pulling you towards a back room.  A round of chuckles chases you through the bar room until they're silenced by the heavy thud of a door closing behind you.  You're pushed against the wall hard enough to make your teeth click.  The stars gradually clear from your view, revealing a massive gash, drooling with clear feminine slime.  The scent assails you, ");
		else if(flags["COC.EDRYN_NUMBER_OF_KIDS"] == undefined) output("Her arm finds its way back inside your [pc.gear], pulling you towards a back room.  A round of chuckles chases you through the bar room until they're silenced by the heavy thud of a door closing behind you.  You're pushed against the wall hard enough to make your teeth click.  The stars gradually clear from your view, revealing a massive gash, drooling with clear feminine slime.  The scent assails you, ");
		else output("A round of chuckles chases you through the bar room until they're silenced by the heavy thud of a door closing behind you.  You're pushed against the wall hard enough to make your teeth click.  The stars gradually clear from your view, revealing a massive gash, drooling with clear feminine slime.  The scent assails you, ");
		if(pc.cocks[x].cType == GLOBAL.TYPE_EQUINE) output("making your [pc.cock " + x + "] twitch and ache.  It floods your body with animalistic desires, overpowering any sense of propriety you might have once had.");
		else output("overpowering you with strange lust.  As turned on as you are, it's difficult not to enjoy this.");
	}
	//TAUR
	else {
		if(cost > 0) output("Coins exchange hands and she grabs you, pulling you back towards a darkened doorway in the rear of the bar.  A round of chuckles chases you through the bar room until they're silenced by the heavy thud of a door closing behind you.  Edryn turns away from you, exposing her massive gash, drooling with clear feminine slime.  The scent assails you, ");
		else output("She grabs you, pulling you back towards a darkened doorway in the rear of the bar.  A round of chuckles chases you through the bar room until they're silenced by the heavy thud of a door closing behind you.  Edryn turns away from you, exposing her massive gash, drooling with clear feminine slime.  The scent assails you, ");
		if(pc.cocks[x].cType == GLOBAL.TYPE_EQUINE) output("making your [pc.cock " + x + "] twitch and ache.  It floods your body with animalistic desires, overpowering any sense of propriety you might have once had.");
		else output("overpowering you with strange lust.  As turned on as you are, it's difficult not to enjoy this.");
	}
	//NEW
	output("\n\nHow will you have her?  You could fuck her.  Or, you could eat her out until you're going crazy with sexual need and completely lose control.");
	//[Fuck] [Eat Her Out]
	clearMenu();
	addButton(1, "Eat Her Out", eatEdrynPussyLikeABawss);
	if (pc.isTaur()) addButton(0, "Fuck", fuckEdrynTaur);
	else addButton(0, "Fuck", fuckEdrynNonTaur);
}

//Eat Her Out Till Shit Goes Crazy
public function eatEdrynPussyLikeABawss():void {
	clearOutput();
	//output(images.showImage("edryn-eat-her-out"));
	var x:int = pc.cockThatFits(edryn.vaginalCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	var y:int = pc.cockThatFits2(edryn.analCapacity());
	output("Edryn starts to say something, but you strip out of your [pc.gear] before she gets more than a half-dozen words out, your [pc.cocksLight] jutting proud and erect, leaking clear streams of pre-cum down ");
	if(pc.cockTotal() == 1) output("its underside");
	else output("their underside");
	output(".  You smile mirthfully when you realize Edryn is actually blushing, and beet red at that!  Her hindlegs prance nervously around as she studies you over her shoulder, and her tail won't stop the steady back-and-forth swish that sends more of the boner-fueling musk towards your nose.");
	//if (pregnancy.isPregnant) output("  You can tell that since she's gotten pregnant her pheromones have become more potent, but that's little more than a dim note on a forgotten chalkboard to your brain.  It's impossible to think about measuring the potency of anything that isn't your own tool in such a swelteringly hot atmosphere.");
	//else 
	output("  You note that the smell seems more powerful in an enclosed space, but that's little more than a dim note on a forgotten chalkboard to your brain.  It's nigh-impossible to think about anything but plunging yourself [pc.sheath] deep inside her when exposed to her scent this strongly.");

	output("\n\n\"<i>Are you going to fuck me, or just stare at my pussy all day?</i>\" the blushing centaur teases as she takes mincing steps towards you, back end first.  \"<i>I'm okay with either, provided you let me grind it on you until I'm satisfied.</i>\"");

	output("\n\nSmirking, you tell her that while you do intend to bury yourself in her massive, swollen gash, you don't intend to be a spectator in these sexual proceedings.  Her pussy better be ready for a thick creampie, because you're going to drink in her aroma until you can't help but pound her raw.  The slutty centauress raises an eyebrow at that suggestion, but you can see a ");
	if(flags["COC.TIMES_EATEN_EDRYN_PUSSY_RUT"] == undefined) output("smile tugging at the corners of her mouth at your bravado");
	else output("lecherous grin spreading across her face as she remembers the last time you did this");
	output(".");

	output("\n\nEdryn trots closer and says, \"<i>Then you'd best eat up hon, 'cause I got you a four course meal.</i>\"  Her swollen pussy is just inches away from you now.  The black lips part slightly before you, winking slowly as moisture begins to run from the bestial entrance, visibly fogging the air before you.  A web of girlish goo hangs across the slightly-spread entrance, and after one last inhalation of her almost sweet scent, you dive on in.  Your nose is the first casualty of your aggressive war on centaur-cunt, slurped down by the hungry folds as soon as you're pushing up against them.  You keep pushing until your mouth has slipped through the moist, sticky veil that hangs across her vagina, kissing her fat-lipped horse-pussy with gusto while you let your tongue slither out to play.");

	output("\n\nAt the first lick, Edryn gets palpably wetter.  Sloppy juice washes out from inside her, covering your cheeks and chin before dripping off onto your [pc.chest], leaving you marked with her feminine odor.  ");
	if(pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("She's not even begun to taste the fruits of your talents, and you let your long, long tongue spool out inside her, pressing hard on her walls and tenderly flicking across each sensitive fold inside her.  ");
	output("The busty, animalistic woman moans unashamedly, hands going to her breasts to squeeze them, her clit filling up to its full size.  You can feel the sensitive nodule plump up against the top of your mouth, so you open wide enough to give it a quick suck before returning to polishing her innards.  After that the equine pleasure-buzzer gets rock-hard and continues to bulge meaningfully against you, pulsing hotly in your mouth.");
	output("\n\nYou sway dizzily on your [pc.feet] as you try to focus on just basking in her pussy's delicious... potent... sexy aroma.  [pc.EachCock] is lifting needily with every passing second.  ");
	if(pc.cockTotal() == 1) output("It's");
	else output("They're");
	output(" so full that your hardness becomes almost painful, and each twitch of your girthy length makes you wish that you could just nestle it inside her - anything to assuage the hurtful levels of desire that have arisen within you.  Breathlessly, you pull back for a gulp of air.  It's so full of Edryn's scent that it's almost choking in strength, so sweet and wet... and utterly feminine.  You put a hand against the wall as you try to stay upright, whimpering with animalistic desire, so perfectly rigid and ready for a cunt.");

	output("\n\nSmashing right back into her sweet puss, you pull her rubbery horse-lips apart and begin a fresh assault on her pussy.  You're munching on her box like a wild" + pc.mf("man","woman") + ", utterly without concern for anything beyond your own rapacious and half-forgotten desire to lick her again and again.  She's a wet, ready mare, and you're a male");
	if(pc.isHerm()) output(", or close enough to it");
	output(".  A red, lusty haze has started to cling to the edges of your vision even when your eyes are closed, and you swear you can see the outline of her immense, onyx twat through your eyelids.");
	output("\n\nEdryn abruptly whinnies, and her cunt spasms on your tongue, clenching down with incredible, muscular tightness.  Rings of convulsing muscle run all over it, pulling from her entrance towards what can only be her womb, and as she splatters your face with her musky juices, all you can think about is how wonderful it would feel to have it doing that to your [pc.cock " + x + "].  You lap at the tangy fruit of your labor as a wave of it is washed over your head, drinking as much of her lady-spunk as your throat will allow, so fixated on cunt your brain can do nothing but dumbly force you harder against it, even though it isn't your dick doing the penetrating.  You've fallen into a thought-crushing rut, one that's steadily erasing every other concern from your consciousness.");

	output("\n\nEdryn trots away on wobbly legs after her long, wet cum finally finishes, saying, \"<i>Mmm, that WAS a good cum, but I thought you were going to-URK!</i>\"  She grunts as you slam your [pc.cock " + x + "] straight into her cunt");
	if(y >= 0) output(" and your " + pc.cockDescript(y) + " into her asshole");
	output(".  Her ");
	//if (pregnancy.isPregnant) output("milky tits, swollen from her pregnancy,");
	//else 
	output("big tits");
	output(" bounce around ludicrously, their owner too insensate from your forceful insertion to attempt to restrain them");
	//if (pregnancy.isPregnant) output(" as they drip milk everywhere");
	output(".  You grab hold of her gigantic, equine ass with one hand and her exotic tail with the other and push harder against her until her slick, welcoming moisture is wrapped around you on all sides");
	if(y >= 0) output(" and clenching tightness is wreathing your other erection");
	output(".  You growl savagely as you feel her inhuman warmth squeezing from all sides.  Flexing tightly, the myriad strong muscles that make up the girl's horse-like hindquarters all compress around you at once, utterly immobilizing you.");

	output("\n\nYou whine piteously - the need to fuck and breed her is overwhelming, but to move now only invites pain.  Edryn chuckles, \"<i>Baby, you can't surprise a girl like that.  Now, don't go too crazy, and I'll let you go, okay?</i>\"  You lean across her furry back, soaking up her warmth as you nod into her muscular animal-half.  Yes, anything... anything to fuck her again.  \"<i>Okay then.</i>\"");

	output("\n\nLike magic, the crushing pressure is gone, and you're free to plumb her depths with wanton abandon.  You groan throatily as you begin to hump her again, this time taking it slow enough not to rouse her ire, your hands wrapping halfway around her ");
	//if (pregnancy.isPregnant) output("baby-filled ");
	output("middle for support, [pc.legs] dangling slightly above the ground as you twist to ram your [pc.cocks]");
	output(" inside.  Slurps and squishes echo through the small room while you work Edryn's gushing, well-lubed gash.  Moaning excitedly, the horse-girl is starting to get into it, and you gradually pick up your tempo until your [pc.hips] are clapping wetly against her soaked haunches.  She whickers and glances back over her shoulder, blushing so red you briefly wonder if you're fucking a demoness.");

	output("\n\nWithout warning, her cunt abruptly squeezes down again, not as hard as before, but enough to cause you a modicum of pain as you saw through her drizzling nethers.  The 'splat-splat-splat' of her lusty moisture falling grows ever louder as you plow through her glittering gates.  She's getting wetter and wetter, soaked with girl-cum.  Her secretions combine with the increased tightness to overwhelm your endurance, and with her high body temperature, it feels like your dick is little more than a wax candle, melting into a puddle of white, orgasmic goo.");

	output("\n\nArching your back, you allow the palpable relief to wash through you, bubbling lust pumping out from your [pc.balls] to flood the poor centaur's slippery, equine slit.  You ejaculate with forceful lurches of your [pc.hips], matching each rope of creamy jism by burying your " + pc.cockDescript(x));
	if(y >= 0) output(" and "+ pc.cockDescript(y));
	output(" to the");
	if(y >= 0) output("ir");
	output(" hilt");
	if(y >= 0) output("s");
	output(".  The blissful relief that washes through you obliterates conscious thought and replaces it with creamy, placid warmth, causing your eyelids to droop heavily and your tongue to hang limply from your mouth while you pump the squirming centaur full of sperm.  You feel like a happy, bottomless well of semen, with immense, untapped reserves still left to dispense.  Clearly, your rutting body has gone into overdrive, and before long Edryn's ebony cunt is drizzling white cream onto the ground.");
	//if (!pregnancy.isPregnant) {
		output("  Her empty womb takes in the spermy deposits with aplomb, though you start to worry when you feel her sides bulge out thanks to her stretching middle.  Edryn's legs give out, and her pussy starts to constrict tighter, squeezing into concentric rings that move from her entrance towards her cervix, squeezing hot loads straight into that well-creamed womb.  You keep bouncing on her ass as best you can, too pleasured to care, not stopping until your dick goes dry and the jism is soaking Edryn's entire back half.");
		if(y >= 0) output("  Her ass is in a similar state.  It's so pressurized with jizz that it squirts out of her with each contraction.");
	//}
	//else {
		//output("  With her womb plugged with your offspring, the spermy deposits have nowhere to go.  Even when Edryn's cunt squeezes down into a series of concentric rings, all tugging your cum towards her cervix, there's nowhere for it to go, and it washes out around you, wasted.  The horse-girl's ass-half is soaked with the stuff, alabaster with cum and musky horse-jizz.");
		//if(y >= 0) output("  Her butthole gets a similar treatment, filled enough that it's squirting your jizz back out with each contraction the centauress makes.");
		//output("  Even after all that, she milks you until you're completely dry, and then some.");
	//}
	output("\n\nYou slump down upon her fuzzy back as Edryn rolls sideways onto some nearby cushions, lewdly moaning as her eyes flutter closed, drifting into an exhausted slumber.  Dipping down into closure, your eyelids decide that you should join her.  Her pheromones are still heavy in the air, however, and even in slumber, you feel your [pc.balls] refill and your [pc.hips] begin to pump your cock through that slippery channel once more.");
	output("\n\n'<b>Squish-squish-squish-squish-</b>' can be heard for several hours by anyone lucky enough to hold their ear to the door.");
	processTime(3 * 60 + rand(30));
	pc.orgasm();
	//dynStats("lib", .25, "sen", -3);
	pc.slowStatGain("l", 0.25);
	applyPussyDrenched(pc);
	applyAinaMareMuskEffect();
	//[Next]
	clearMenu();
	addButton(0, "Next", postEdrynEatOutRut);
}

private function postEdrynEatOutRut():void {
	clearOutput();
	output("When Edryn and you wake, your genitals are so sore and sensitive that getting cleaned up is almost painful.  The centauress even goes so far as to comment that she'll have to pay someone to mop up the mess, but there's a proud twinkle in her eye.  Somehow, your [pc.gear] got splattered with vaginal juices during the sexcapade, and as you put them back on, [pc.eachCock] regains its familiar hardness.  You chew on your lower lip as you slip out after saying goodbye, rock-hard and smelling totally of Edryn's lust.  A limited applause goes up at your departure, mixed with hooting and catcalls.  What a fuck!");
	//hideUpDown();
	//dynStats("lus", 20 + pc.lib / 5);
	pc.lust(20 + pc.libido() / 5);
	edrynPregChance();
	edrynPregChance();
	edrynPregChance();
	IncrementFlag("COC.TIMES_EATEN_EDRYN_PUSSY_RUT");
	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}