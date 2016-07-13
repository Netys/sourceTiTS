import classes.Characters.CoC.CoCIsabella;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Isabella Flags:
//256	PC decided to approach Isabella's camp yet? 1
//257	Met Isabella?
//258	Is Isabella okay with tall folks?
//259	Has Isabella ever met the PC while PC is short?
//260	Isabella angry counter
//261  Times Izzy sleep-raped the PC?
//-Has PC raped her?

public function get isabella():CoCIsabella {
	return new CoCIsabella();
}

private var checkedIsabella:int; //Make sure we test this event just once in timeChangeLarge

//Implementation of TimeAwareInterface
public function timeChange():Boolean
{
	checkedIsabella = 0;
	if (flags["COC.ISABELLA_ANGRY"] > 0) { //Isabella is angry at the player
		flags["COC.ISABELLA_ANGRY"]--;
		if (flags["COC.ISABELLA_ANGRY"] > 300) flags["COC.ISABELLA_ANGRY"] = 300;
		if (flags["COC.ISABELLA_ANGRY"] < 0) flags["COC.ISABELLA_ANGRY"] = 0;
	}			
	if (flags["COC.ISABELLA_MILK_COOLDOWN"] > 0) {
		flags["COC.ISABELLA_MILK_COOLDOWN"]--;
		if (flags["COC.ISABELLA_MILK_COOLDOWN"] < 0) flags["COC.ISABELLA_MILK_COOLDOWN"] = 0;
	}
	if (flags["COC.ISABELLA_ACCENT_TRAINING_COOLDOWN"] > 1) {
		flags["COC.ISABELLA_ACCENT_TRAINING_COOLDOWN"]--;
	}
	if (hours == 0) {
		if (flags["COC.FOUND_ISABELLA_AT_FARM_TODAY"] == 1) flags["COC.FOUND_ISABELLA_AT_FARM_TODAY"] = 0;
		if (isabellaFollower() && flags["COC.ISABELLA_MILKED_YET"] >= 0 && int(flags["COC.FOLLOWER_AT_FARM_ISABELLA"]) == 0) {
			flags["COC.ISABELLA_MILKED_YET"]++;
		}
	}
	return false;
}

public function timeChangeLarge():Boolean {
	if (hours == 6 && isabellaFollower() && flags["COC.FOLLOWER_AT_FARM_ISABELLA"] == 0 && flags["COC.ISABELLA_BLOWJOBS_DISABLED"] == 0 && pc.hasCock() && (days % 2 == 0 || !pc.hasPerk("Marble's Milk")) && pc.shortestCockLength() <= 9) {
		isabellaMorningWakeupCall();
		return true;
	}
	return false;
}
//End of Interface Implementation

public function isabellaGreeting():void {
	Flag("COC.ISABELLA_ANGRY"); // init?
	Flag("COC.ISABELLA_TALLNES_ACCEPTED"); // init?
	Flag("COC.ISABELLA_MET_AS_SMALL"); // init?
	Flag("COC.ISABELLA_FOLLOWER_ACCEPTED"); // init?
	Flag("COC.ISABELLA_CAMP_DISABLED"); // init?
	Flag("COC.ISABELLA_TIMES_OFFERED_FOLLOWER"); // init?
	
	clearOutput();
	clearMenu();
	//Not approached yet - the prequel!
	if (flags["COC.ISABELLA_MET"] == undefined) {
		//isabellaSprite(); // we don't know her yet
		output("While walking through the high grasses you hear a rich, high voice warbling out a melodious tune in a language you don't quite understand.  Do you approach or avoid it?");
		//[Approach – to meeting] [Avoid – camp] – dont flag as met yet
		//Approach - sets flags["COC.ISABELLA_MET"] to 1 and calls this function
		clearMenu();
		addButton(0, "Approach", function():*{ flags["COC.ISABELLA_MET"] = 0; isabellaGreeting(); } );
		addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	//CAMP MEETING – UMAD BRAH!?
	if(flags["COC.ISABELLA_ANGRY"] > 0) {
		output("You unintentionally wind up in Isabella's camp, and the cow-girl still seems pretty steamed at you.  She charges towards you, sliding her arm through the straps on her shield as she approaches.  It's a fight!");
		if(!isabellaFollower()) isabellaAffection(-4);
		isabellaSprite();
		addNextButton(isabellaStartFight);
		return;
	}
	//[Camp Meeting First Time]
	if (flags["COC.ISABELLA_MET"] == 0) {
		isabellaSprite();
		flags["COC.ISABELLA_MET"]++;
		output("You stumble through a break in the tall foliage to discover a small, barren clearing.  While it looks like grass once grew here, it's long since been trampled into the dirt.  Looking closer, it reminds you of some of the old straw that was constantly packed into the hard earth of your neighbor's barn when you were growing up.  There are a few sizable chests secured with heavy iron locks and draped with comfortable-looking blankets.  The heavy boxes are grouped in a half-circle surrounding a chair that currently holds the camp-owner's sizable backside.  It reminds you of a cruder version of your own camp.\n\n");
		
		output("Even seated, the occupant of this unsheltered settlement is imposing.  Standing up she'd have to be at least seven feet tall, maybe even eight.  You're looking at her from the back, and aside from the obvious femininity of her figure and lilting voice, all you see is the red tangles of her unruly red locks.  The woman's voice peaks, finishing her unusual song with such a high-pitched tone that you expect the iron locks and rivets on her chests to crack.  Thankfully her song's crescendo is quite brief, and her voice drops to a quiet warble before trailing off into silence.  She stands up, glances over her shoulder, and jumps back with her eyes wide in shock as she notices you.\n\n");
		output("She's a cow-girl!  Well, not completely anyways.  ");
		if(flags["COC.MARBLE_MET"] > 0) output("She's like Marble - she has a human face with horns and cow-like ears.");
		else output("She has a human face, but the top of her head is also adorned with a pair of stubby, bovine horns and floppy cow-ears.");
		output("  Her skin is tanned dark, practically milk-chocolate brown, but a few rounded spots of white, pearly skin break up the uniformity.  The cow-girl is wearing a diaphanous silk shirt supported by a black leather corset and red lace.  She also wears a plain, olive-toned skirt that barely protects her modesty, and nearly fails in its purpose with every subtle breeze.  Her wide hips flare into spacious thighs before disappearing under a layer of shaggy, auburn fur that grows thicker and thicker the closer it gets to her hooves.\n\n");
		//(tall PC's 6'6</i>\"+)
		if(pc.tallness > 78) {
			output("The cow-girl narrows her eyebrows in irritation as she sizes up your impressively large form.  She speaks with a strange accent, \"<i>Who are you and vat are you doing here?</i>\"\n\n");
			output("You answer and begin to explain yourself, but she interrupts, \"<i>Get out!  Zis is mein camp and I vill not tolerate you here!</i>\"\n\n");
			output("A bit taken aback by her violent reaction, you blink in confusion as she pulls a titanic shield from behind her chair and slides her arm comfortably into the strap.  What do you do?\n\n");
			//[Talk] [Fight] [Leave]
			clearMenu();
			addButton(0, "Try to Talk", tryToTalkDownAngryCow);
			addButton(1, "Fight", unwelcomeFightCowGal);
			addButton(4, "Leave", leaveAngryIzzy);
		}
		//(Shorter PC's) 
		else {
			if(int(flags["COC.ISABELLA_MET_AS_SMALL"]) == 0) IncrementFlag("COC.ISABELLA_MET_AS_SMALL");
			output("The cow-girl's big brown eyes soften as she regards your relatively diminutive form.  She smiles and coos, \"<i>Awww, you're zuch a cutey!  Izabella could never turn avay someone like you.  Come here, vould you like a drink?</i>\"");
			output("\n\nYou approach and exchange introductions with the friendly woman, still a bit taken aback by her eagerness.");
			//(Male PC's) 
			if(pc.hasCock()) {
				output("  She sniffs the air and immediately glances towards your groin.");
				if(pc.shortestCockLength() < 9) {
					output("The cow's eyes practically fog with lust when she sees the size of your diminutive bulge.  Isabella begs, \"<i>V-vould you come closer?  I-ah have a fondness for 'small' lovers, and I like to... 'lick'.</i>\"  To emphasize, she rolls out her tongue, showing you nearly eight inches of flat, wide, and pink flesh.");
					addButton(2, "Get Licked", izzyGivesSmallWangsFreeOral);
				}
				else {
					output("  The cow's eyes close, disappointment visible on her face when she sees the sheer size of your bulge.");
					addDisabledButton(2, "Get Licked", "Get Licked", "She is not into large cocks, apparently...");
				}
			}
			//[Talk – real conversations] [Drink – leads to breastfeeding] [Get Licks – leads to oral for small fries] [Rape?]
			clearMenu();
			addButton(0, "Talk", talkWithIsabella);
			addButton(1, "Drink", nomOnMommaIzzysTits);
			addButton(3, "Fight", fightIsabella);
			addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		return;
	}
	//Camp Meeting – Repeat Unwelcome
	else if (pc.tallness > 78 && flags["COC.ISABELLA_TALLNES_ACCEPTED"] == 0 && flags["COC.ISABELLA_MET_AS_SMALL"] == 0) {
		isabellaSprite();
		output("You stumble through the grass, nearly tripping as it parts to reveal the now-familiar sight of Isabella's camp.  The cow-girl spots you instantly and snarls, \"<i>Begone!  I varned you once already!</i>\"");
		//[Talk] [Fight] [Leave]
		//Leave goes to special variation, see below.
		clearMenu();
		addButton(0, "Try to Talk", tryToTalkDownAngryCow);
		addButton(1, "Fight", unwelcomeFightCowGal);
		addButton(14, "Leave", leaveAngryIzzy);
		return;
	}
	//Camp Meeting – Was welcome tall, but not short yet!
	else if (flags["COC.ISABELLA_TALLNES_ACCEPTED"] > 0 && int(flags["COC.ISABELLA_MET_AS_SMALL"]) == 0 && pc.tallness <= 78) {
		isabellaSprite();
		IncrementFlag("COC.ISABELLA_MET_AS_SMALL");
		output("You stumble through a wall of tall grasses back into Isabella's camp!  It's amazing how much taller they've become since your last visit.  Or perhaps it just seems that way due to the change in height.  You look for Isabella, and the fiery, red-headed cow-girl is charging right at you, bellowing, \"<i>Awwww, you're so much cuter!  Iz vonderful to have such tiny, adorable friends!  Did you come back for one of mein special drinks?</i>\"  She envelops you in a hug that crushes you against jiggling breast-flesh, and in seconds you're cradled in her arms as she marvels at your new size.");
		output("\n\nThe cow-girl's dusky cheeks color pink with embarrassment before she sets you down and apologizes, saying, \"<i>I am so sorry.  It iz so lonely here in ze plains, and well, feeding someone is how do you say... more fun when you can cuddle them in your arms!</i>\"");
		//simpleChoices("Talk",0,"Drink",0,"Get Licked",suck,"Rape Attempt",0,"Leave",13);
	}
	//Camp Meeting – Welcomed Short but Not Tall
	else if (int(flags["COC.ISABELLA_MET_AS_SMALL"]) > 0 && int(flags["COC.ISABELLA_TALLNES_ACCEPTED"]) == 0 && pc.tallness > 78) {
		isabellaSprite();
		output("You easily brush through the tall grasses and stride into Isabella the cow-girl's camp.  It looks like she was sitting in her chair mending a blanket when you arrived, and you take a moment to watch her hunched posture squeeze her breasts tightly against the gauzy silk top she's so fond of wearing.  The outline of a single areola is clearly visible through the diaphanous material, but most striking is that each areola has four VERY prominent nipple-tips.  She looks at you, first in fright, and then in embarrassment as she recognizes you AND realizes what you were doing in a single instant.\n\n");
		//(+lust!)
		pc.lust(10 + rand(10));
		
		output("Isabella complains, \"<i>Vere you just checking me out?  Vell I must confess, I liked you better ven you were shorter.  Maybe if you ask nicely I might give you a peak and a drink.  That vould be nice, nein?\n\n");
		IncrementFlag("COC.ISABELLA_TALLNES_ACCEPTED");
		if(pc.hasCock()) {
			output("She sniffs and gives your crotch a glance ");
			if (pc.shortestCockLength() >= 9) {
				output("before sighing wistfully.");
				addDisabledButton(2, "Get Licked", "Get Licked", "She is not into large cocks, apparently...");
			}
			else {
				output("before offering something else.  \"<i>Perhaps you could undress?  I like to play vith my tongue if you know vat I mean.</i>\"");
				addButton(2, "Get Licked", izzyGivesSmallWangsFreeOral);
			}
		}
		//simpleChoices("Talk",0,"Drink",0,"Get Licked",suck,"Rape Attempt",0,"Leave",13);
	}
	//Follower go!
	else if (int(flags["COC.ISABELLA_CAMP_DISABLED"]) == 0 && int(flags["COC.ISABELLA_FOLLOWER_ACCEPTED"]) == 0 && isabellaAffection() >= (50 + int(flags["COC.ISABELLA_TIMES_OFFERED_FOLLOWER"]) * 15)) {
		isabellaSprite();
		isabellaMoovesInGreeting();
		return;
	}
	//[Standard welcome options]
	//Camp Meeting – Standard Repeat
	else {
		isabellaSprite();
		if(int(flags["COC.ISABELLA_MET_AS_SMALL"]) <= 0) IncrementFlag("COC.ISABELLA_MET_AS_SMALL");
		output("While making your way through the tall grasses you hear a familiar voice lilting in a high-pitched foreign song.  It sounds like Isabella the cow-girl is at it again.  You meander towards the melodic tune, smiling as it rises in pitch and volume through your journey.  A short time later you break through the edge of the grasses in time to watch Isabella finish her song and the curvy cow-girl seems completely oblivious to your presence, enraptured by the music of her homeland.\n\n");
		output("You wait patiently, watching her curvy body shift and her large, milk-swollen breasts wobble dangerously inside her near-transparent shirt.  Her quad-tipped areolas are plainly on display, clearly engorged and ready to leak.  If you weren't here, in this strange place, you'd be amazed by how her breasts are basically humanized udders.  In this place, it's just another thing that adds to her exotic appeal.\n\n");
		output("Isabella finishes her song and turns to you with a twinkling smile as she asks, \"<i>Did you come back for some of ze milk?</i>\"");
	}
	
	if(pc.hasCock()) {
		output("\n\nHer nose twitches and ");
		if(pc.shortestCockLength() < 9) {
			output("she glances down at your small bulge.  Isabella's lips curl into a lewd smile as her voice grows husky.  \"<i>Maybe you could... pull it out for me?  I just vant to lick it a little.</i>\"");
			addButton(2, "Get Licked", izzyGivesSmallWangsFreeOral);
		}
		else {
			output("she glances down at your ");
			if(pc.shortestCockLength() < 20) output("large");
			else output("gigantic");
			output(" bulge.  Isabella sighs and mumbles something about it being too big to be any fun.");
			addDisabledButton(2, "Get Licked", "Get Licked", "She is not into large cocks, apparently...");
		}
	} else addDisabledButton(2, "Get Licked", "Get Licked", "She prefers to lick cocks, apparently...");
		
	addButton(0, "Talk", talkWithIsabella);
	addButton(1, "Drink", nomOnMommaIzzysTits);
	// 2 - get licked
	addButton(3, "Fight 4 Rape", fightIsabella);
	addButton(4, "Offer Oral", volunteerToSlurpCowCunt);
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function isabellaStartFight():void 
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCIsabella());
	CombatManager.victoryScene(defeatIsabella);
	CombatManager.lossScene(isabellaDefeats);
	CombatManager.displayLocation("ISABELLA");
	CombatManager.beginCombat();
}

//Leave]	
public function leaveAngryIzzy():void {
	isabellaSprite();
	clearOutput();
	output("You shrug and make it quite clear you're leaving.  Crazy cow.  She shouts, \"<i>And stay avay, demon!  Izabella has no need of your foul tricks!</i>\"");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Fight]
public function unwelcomeFightCowGal():void {
	isabellaSprite();
	clearOutput();
	output("You [pc.readyWeapon] and adopt a fighting pose.  No cow is going to chase you away!");
	if(!isabellaFollower()) isabellaAffection(-5);
	flags["COC.ISABELLA_ANGRY"] += 72;
	addNextButton(isabellaStartFight);
}

//Fuck-fight
public function fightIsabella():void {
	isabellaSprite();
	clearOutput();
	if(!isabellaFollower()) isabellaAffection(-5);
	output("You smirk at Isabella, and [pc.readyWeapon], telling her you intend to have you way with her.  She turns beet red and grabs her shield, announcing, \"<i>You von't find me such easy prey, and I vill punish you for being so naughty!</b>\"");
	flags["COC.ISABELLA_ANGRY"] += 72;
	addNextButton(isabellaStartFight);
}

//[Talk] 
public function tryToTalkDownAngryCow():void {
	isabellaSprite();
	clearOutput();
	//(int below 25)
	if(pc.intelligence() < 10) {
		output("You open your mouth and tell her you won't be leaving until she understands that you aren't her enemy.  She snorts and taunts, \"<i>You zink Izabella vould fall for zuch trickery? HAH!</i>\"\n\n");
		output("Your reply is blotted out by the thundering of her hooves as she lowers her shield and charges.\n\n");
		if(!isabellaFollower()) isabellaAffection(-2);
		addNextButton(isabellaStartFight);
	}
	//(int below 50)
	else if(pc.intelligence() < 25) {
		output("You start to try to explain your reasons for coming here, stuttering slightly in haste as the angry cow-girl looks to be paying less and less attention.  She snorts and lowers her shield, shouting, \"<i>You zink Izabella vould fall for zuch nonzense? HAH!  Prepare to face mein fury!</i>\"");
		if(!isabellaFollower()) isabellaAffection(-2);
		//(start combat)
		addNextButton(isabellaStartFight);
	}
	//(Int below 75) 
	else if(pc.intelligence() < 40) {
		output("You do your best to explain the situation, but even giving her such a concise, well-explained argument doesn't seem to help you.  She snorts dismissively and says, \"<i>Shut up.  I have no patience for ze mutants of this land.  Now, if you truly mean no harm, you'd best find a way out of mein clearing before Izabella's shield breaks your noggin!</i>\"");
		if(!isabellaFollower()) isabellaAffection(-2);
		//(Start combat)
		addNextButton(isabellaStartFight);
	}
	//(Else) 
	else {
		if(pc.hasWeapon()) output("You toss aside your [pc.weapon] and");
		else output("You");
		output(" hold your hands up in a gesture of peace and calmly state that you mean her no harm, but you would like to at least speak with her.  She looks you up and down and snorts, \"<i>Very vell, Izabella vill listen to your words.</i>\"\n\n");
		output("You sit down in the dirt and impart your tale, explaining how you came here as a 'champion', chosen by your village.  You go on to speak of your encounters and how strange everything is here, and Isabella nods quite knowingly as you go on and on.  Now that you've begun to tell your tale, the words fall out of your mouth, one after another.  Like an unbroken chain, they spool out of your maw until nearly an hour later, you finally run out of things to say.  You rub your jaw, your throat a little sore from the diatribe, and look on to Isabella to see how she reacts.\n\n");
		output("The busty cow-girl has moisture glimmering in the corners of her big brown eyes, and she nods emphatically to you as she vocalizes her feelings, \"<i>I, too, know how you feel, Champion [pc.name].  Mein own story is similar, though mein fate vas not thrust upon me so.  Perhaps I vill tell you sometime, but for now, ve should part.  You are velcome to return in ze future.</i>\"\n\n");
		output("You smile to yourself, glad to have made a friend.\n\n");
		if(!isabellaFollower()) isabellaAffection(10);
		flags["COC.ISABELLA_TALLNES_ACCEPTED"]++;
		clearMenu();
		addButton(0, "Next", function():*{ processTime(30 + rand(20)); mainGameMenu(); } );
	}
}


public function nomOnMommaIzzysTits():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.cockThatFits(cockVolume(20));
	//[Voluntary Nursing – PC is a big one or taur]
	if(pc.tallness > 78 || pc.isTaur()) {
		output("Isabella's face lights up when you let her know that you could use a drink.  She grabs one of her blankets from atop a chest and throws it out over the ground.  The fabric of her intricately-patterned spread settles over the dirt, amazing you with its quality and size.  It's well over 10 feet from edge to edge and does a fantastic job of making the patch of dirt feel a lot more comfortable.  The busty cow-girl walks onto it, almost like a carpet, but then she lies down on her side and begins casually unlacing the red cord from her black corset.  Her mountainous mammaries wobble dangerously with each tug, and then she's tossing the corset aside.  With it out of the way, there's nothing between you and the cow-girl's glistening, sun-kissed skin except for a gauzy layer of silk.\n\n");
		
		output("You approach, salivating slightly in anticipation of the taste of the cow-girl's milk and unintentionally growing more and more aroused by her 'concealed' and yet totally exposed breasts.  ");
		if(pc.hasCock()) {
			output("Your [pc.gear] tents ");
			if(pc.biggestCockVolume() > cockVolume(40)) output("hard, barely constraining [pc.eachCock].");
			else output("visibly from [pc.eachCock].");
			output("  ");
		}
		if(pc.hasVagina()) {
			if(pc.hasCock()) output("Even y");
			else output("Y");
			output("our [pc.vagina] ");
			if(pc.wetness() < 3) output("glistens with ");
			else if(pc.wetness() < 5) output("drips ");
			else output("streams ");
			output("moisture, reacting to the erotic vision.  ");
		}
		output("Isabella's weighty chest heaves with each heavy breath she takes, and she motions for you to lie down next to her.  Her dusky lips part to say, ");
		if(isabellaAccent()) output("\"<i>Come closer, I do not bite.  Ve both know how very thirsty you are. Izabella vill sate you,</i>\" as she pulls the tightly stretched silk over the curve of her deliciously bronzed mounds.\n\n");
		else output("\"<i>Come closer, I don't bite.  We both know how thirsty you are.  Isabella will sate you,</i>\" as she pulls the tightly stretched silk over the curve of her deliciously bronzed mounds.\n\n");
		
		output("Her areolae are large, maybe two or three inches across, though perched as they are atop such glorious globes, they still seem small.  Each of them has four nipples protruding nearly an inch up from the surface, and each of them is starting to bead with tiny drops of milk.  You lean closer, a little hesitantly, and watch the beads slowly grow to droplets before they roll down the dark-skinned arc of the cow-girl's chest.  It smells very sweet... sweeter than you'd expect, but there is another smell in the air coming from lower on Isabella's body that indicates a whole other type of need.  There are faint, muffled wet squelches at the edge of your hearing, and it's then that you notice one of her hands has disappeared below her skirt.\n\n");
		
		output("Before you can comment, her other hand is grabbing ");
		if(pc.hasHorns() && pc.hornLength >= 4) output("your [pc.horns]");
		else output("the back of your head");
		output(" and smashing your face into her leaky milk-spouts.  You react fast enough to open wide, and all four of the nipples slide into your mouth.  Their tips press together and leave a steady stream of milk on your tongue as you lick and slurp around the needy nipples, relieving Isabella's desire to breastfeed while sating your own thirst.  The surface of the large, rounded breast wraps around most of your head, practically molding to your face from how hard Isabella's pulling on you.  Without light, you close your eyes and drink, sucking deeply as the flow intensifies.  It even seems to get sweeter with each gulp of the cow-girl's breast-milk.\n\n");
		
		output("You get rather absorbed in your task and lose track of time as you pull harder, trying to see just how far her supply of the stuff goes.  A flood of creamy sweetness nearly drowns you in response, and you're forced to chug for a few seconds to keep up with the flood.  Even without your suction, the flow of milk is much stronger than before, and it slakes your thirst quite effectively.  Isabella's song-strengthened voice begins moaning out loud, and though you can't make out the exact words due to her thick accent and lapses into a strange tongue, the meaning is quite clear: \"<i>Good " + pc.mf("boy", "girl") + "... (unintelligable moans)... yes, keep drinking... (more moaning)</i>\"\n\n");
		
		output("You're roughly yanked away from the milk spouting breast and pulled up to Isabella's face.  The cow-girl's bronzed visage is flushed darker, and even one of the white patches on her neck is crimson-tinged with lust.  She licks the creamy milk from your lips with an exceptionally wide, smooth tongue and then passionately french-kisses you, squirting more of her milk onto your [pc.chest] the entire time.");
		if(pc.hasCock()) output("  [pc.EachCock] twitches and drips from the intensity of the kiss, but you had completely forgotten about your sexual needs while you were drinking.");
		else if(pc.hasVagina()) output("  Your [pc.vagina] aches with need and desire from the intensity of the kiss, but you had completely forgotten it during the feeding.");
		output("  The kiss doesn't last long anyway.  Once her strangely flexible tongue has lapped the milk residue from your mouth, you're pulled towards the other, leaky tit.\n\n");
		
		output("Milk runs down the curvature of the unused tit in a slow waterfall until your lips are sealed around the 'spring'.  Just like before, she pushes harder and harder until her milk is squirting into your throat and the blushing bronzed tit is wrapped around you.  The cow-girl's delicious nectar is better than you remember, and it's still getting sweeter!  Her flared hips and curvy thighs keep bumping you, getting faster and harder as the noise of Isabella's masturbation grows louder.  Yet rather than being roused by the racket, you block it out and continue to drink deeply, savoring the thickening milk as it blasts into your throat.\n\n");
	
		output("Isabella lets out a thunderous scream of pleasure, but you just sigh in between swallows, devouring the thick, candy-sweet cream she's pouring into you.  Her arms wrap around your shoulders");
		if(pc.hasWings()) output(" and stroke your [pc.wings]");
		output(", lulling you into a state of peaceful relaxation where the only things you feel are her soft flesh enveloping you and her wonderful cream filling your belly until it's fit to burst.  You pop off with a sigh and snuggle into her neck, starting to doze as she croons hypnotically into your ear.\n\n");
		
		//(Male and it fits end)
		if(pc.hasCock() && x >= 0) {
			output("You wake after an hour of highly erotic dreams to find yourself snuggled against Isabella, held tightly in the crook of her arm.  She's snoring soundly, so you quietly extricate yourself from underneath her limb and cover her back up with her blanket.  As you stretch, you realize you're completely naked, your crotch is sore, and you absolutely reek of feminine lust.");
			if(flags["COC.ISABELLA_SLEEP_RAPED_YOU"] == 0) output("  S-she fucked you in your sleep?  That explains how good your dreams were.  On one hand you feel a little violated, but on the other you have to wonder how long this woman has held her camp against the demons with nothing to please her.");
			else output("  It looks like she fucked you in your sleep again.  You wish you wouldn't fall asleep so soundly after drinking her milk so that you could contribute to the sex, but you wake so COMPLETELY SATED in every way that you know it's going to be hard to ever turn her down.");
			//(no lust!, minus 50 fatigue)
			pc.orgasm();
			pc.energy(50);
			//increment sleep rape counter
			flags["COC.ISABELLA_SLEEP_RAPED_YOU"]++;
		}
		//(Generic End)  
		else {
			output("You wake an hour later snuggled into a few of Isabella's blankets and feeling quite content.  The cow-girl is sitting in her chair, honing the bottom edge of her shield into a razor-sharp cutting surface.  She looks back at you and smiles, pausing her work to ask, ");
			if(isabellaAccent()) output("\"<i>Did you enjoy mein snack?  I think ve both needed ze drink, no?</i>\" You nod, stand up stretch, feeling energized and awake.");
			else output("\"<i>Did you enjoy the snack?  I think we both needed the drink, no?</i>\" You nod, stand up stretch, feeling energized and awake.");
			//(-65 fatigue)
			pc.energy(65);
		}
	}
	//Voluntary Nursing (Small Characters)
	else {
		output("You are quite thirsty, and make no secret of it to Isabella, whose face broadens into a knowing smile as she replies, ");
		if(isabellaAccent()) output("\"<i>Vell, you are in luck then!  I have ze most delicious milk you'll find anywhere.  Come here little one, and Isabella vill give you all you need.</i>\"\n\n");
		else output("\"<i>Well, you're in luck then!  I have the most delicious milk you'll find anywhere.  Come here little one, and Isabella will give you all you need.</i>\"\n\n");
		
		output("The large-chested cow-girl carelessly begins to unlace her corset, jiggling her barely-covered melons with each hard tug.  You lurch forward, licking slightly chapped lips, already ensnared in Isabella's inadvertent strip-tease.  With one final, sharp tug, the dark-skinned beauty removes the offending garment, setting it on a nearby blanket.  Her breasts bounce and sway pendulously without the corset's added support, dragging a multitude of hard, damp nipples across the silken prison of her top.  A moment later, tanned olive-toned hands are pulling the offending garment up and out of your view.  There's nothing left between you and Isabella's exquisite mammaries but empty air.\n\n");
		
		output("You stop and look at them, just look, leaving nothing in the air but a long, pregnant pause that seems to go on and on.  Isabella coughs, snapping you from your reverie – you're standing a foot away from those sweat-glazed orbs, and you jerk your head back.  If you leaned any further forward, her prominent, quad-tipped areola would be in your mouth.  The cow-girl laughs and scoops you up in her arms before you can hesitate further.  Your cheek is crushed against a white spot on the side of her left tit, and your [pc.ass] comes to rest on the short fur that sprouts from her thick thighs.  Isabella coos, \"<i>Relax, [pc.name], and let Izabella sate your thirst.  You vill love it.</i>\"\n\n");
		
		output("She forcefully shifts your position, angling her left arm to cradle your back as you're dragged off the creamy part of her chest and onto the darker portions of her mounds.  A three inch wide nipple looms at the bottom of your vision, and moist sweetness brushes over your lips.  You're struck by how very much this entire situation is out of your control.  Confident hands have you locked in their embrace while you curl on Isabella's lap in the most helpless way, and there's not a lot you can do to stop it, even if you wanted to.  Your mouth yields to her insistently pressing nipples, letting all four tips slide through your puckered gateway and press together over your tongue.\n\n");
		
		output("Perhaps it's your thirst, the large cow-girl's aura, or some hidden instinct, but you find yourself starting to swirl your tongue about the grouped nipples and suckle.  Isabella groans happily and rewards your hunger with a steady flow of sweet, warm milk.  The flow is still slow - more a constant trickle from all four nipples that combines into a decent stream - but, thirsty as you are, you suckle and swallow all the same.  The cradling arm shifts slightly, pressing you harder against her bronze skin until you're practically smothered in smooth brown tit-flesh.  You suckle a little harder and the trickle becomes a stream, easily filling your mouth with such speed that you barely have to suck.  With the caramel mound blocking your vision, you go ahead and close your eyes, letting them rest as you gulp down another mouthful of increasingly sweet breast-milk.\n\n");
		
		output("You sigh and nuzzle Isabella affectionately, drinking calmly of her milk, unaware of the increasing warmth and pink tinges that bloom on her skin.  Nectar-flavored milk and the constant rhythm of sucking, swallowing, and breathing become your world as you let yourself lean harder on the pillowy cow-tits.  The air grows hot and humid from having two bodies entwined so close together, and a tangy, familiar smell bubbles up in the air, accompanied by the faint squish of Isabella's free hand.  You can feel it brushing your [pc.ass] with each pumping motion, masturbating the cow-girl's lust-swollen snatch with powerful strokes.\n\n");
		
		output("The ordinarily arousing noises don't have much of an effect on you, busy as you are.  In fact, the repeated schlicking is soothing in its own way, a constant background thrum that lulls your troubled mind.  Through rapidly fading thirst, you start to suck hard, curious how long it'll take her milk-squirting cow-tits to drain.  The white fluid gushes over your tongue and into your throat, nearly drowning you and forcing you to gulp it down in huge swallows or let go, and you don't want to let go.  Your fingers dig into the soft breast, squeezing it as you truly latch on and ride the tidal wave of white until it finally exhausts itself and slows to a trickle.\n\n");
		
		if (isabellaAccent())
		{
			output("Isabella pants as she pulls you back, giving you your first glimpse of just how rosy her tanned skin has gotten, but then you're moving across her chest towards an untapped reservoir of pale nectar.  You start to mention that you've had enough, but Isabella shushes you in between low, lurid moans.  \"<i>Nein, drink up mein friend.  We don't vant you to suffer heat-stroke");
			
			if (!isabellaFollower()) output(" on the vay back!");
			else output(" vhile you are aus und über!");
			
			output("Ooooh... </i>\" she groans as she presses your mouth into the milk - dripping waterfall that is her other breast.  You mumble a reply, but it turns into a messy burble as nipples and milk fill your opened mouth.  Immediately you begin to suckle anew, your protests washed away in syrupy - sweetness.\n\n");
		}
		else 
		{
			output("Isabella pants as she pulls you back, giving you your first glimpse of just how rosy her tanned skin has gotten, but then you're moving across her chest towards an untapped reservoir of pale nectar.  You start to mention that you've had enough, but Isabella shushes you in between low, lurid moans.  \"<i>No, drink up my friend.  We don't want you to suffer heat-stroke");
			
			if (!isabellaFollower()) output(" on the way back!")
			else output(" while you're out and about!");
			
			output(" Ooooh...</i>\" she groans as she presses your mouth into the milk-dripping waterfall that is her other breast.  You mumble a reply, but it turns into a messy burble as nipples and milk fill your opened mouth.  Immediately you begin to suckle anew, your protests washed away in syrupy-sweetness.\n\n");
		}
		
		output("The cow-girl's dusky flesh mashes against you as her constant groin-pumping increases in tempo.  Coupled with an increase in the pitch and volume of her wanton moans, you can tell she's about to orgasm.  The milk gets sweeter, then thicker.  It changes in seconds to a rich, heavy cream that makes your tongue sing and your overfilled belly gurgle.  You suck harder, lost in the moment and the comfort of Isabella's plush embrace, and her moaning, moo-studded orgasm floods your mouth with even more cream.  Lost in swallowing ambrosia, you guzzle it down for as long as it flows and zone out completely.  The constant milk-filling swells your belly until it feels close to bursting, but you keep drinking anyway.\n\n");
	
		output("Sometime later you burp loudly and snuggle against the perfect, soft chest in front of you, sighing with happiness as a hand strokes your [pc.hair].  Isabella croons soft nothings into your ear and you drift into a dreamless, restful slumber.\n\n");
		
		//(Mandiggity!)
		//(Male and it fits end)
		if(pc.hasCock() && x >= 0) {
			output("You wake up an hour later in a massive sprawl of blankets.  There's a soft pillow below you and another one above, and you struggle to dig your way out until a pair of arms wrap around you.  Those aren't pillows – you're trapped between the cow-girl's breasts!  You carefully slide downwards, giving her large, leaking nipples a longing look as you extricate yourself from the embrace with care.  She snores on, blissfully ignorant of your departure as you find your [pc.gear] and re-dress.  There's a hint of tight soreness in your groin, and after reaching down to adjust yourself, your hand comes up reeking of feminine cow-girl.  ");
			if(flags["COC.ISABELLA_SLEEP_RAPED_YOU"] == 0) {
				output("S-she raped you in your sleep?  You aren't sure how she pulled it off, but your ");
				if(pc.balls > 0) output("balls feel");
				else output("body feels");
				output(" so empty and sated you must have gotten off a few times.  Well, all things considered you feel quite rested, even if you got a bit more than you asked for.  Maybe next time you'll at least stay awake for the fun parts!");
			}
			else {
				output("She sleep-fucked you again!  You sigh and wipe your hand off on your " + pc.leg() + ", bemused by the cow-girl who seems too shy to sleep with someone who's awake.  Still, you feel completely sated in every way.  It's going to be a good ");
			   if(hours < 12) output("day");
				else if(hours < 4) output("afternoon");
				else output("evening");
				output(".");
			}
			//(no lust!, minus 50 fatigue)
			pc.orgasm();
			pc.energy(50);
			//increment sleep rape counter
			flags["COC.ISABELLA_SLEEP_RAPED_YOU"]++;
		}
		//(GENERIC) 
		else {
			if(isabellaAccent()) output("You wake an hour later in a pile of blankets on the ground, feeling quite sated and rested.  Isabella is humming a pretty tune a few feet away and sharpening the bottom edge of a massive shield with a whetstone.  She stops when she notices you and sets the massive metal object aside with a noisy 'thunk'.  She reaches down for you with surprising quickness and lifts you up to kiss you on the forehead, saying, \"<i>Did you have a gud nap?  Ya?  Thanks for being such a thirsty drinker, I haven't felt this light in days.</i>\"  Isabella sets you back on your feet and you stretch, feeling remarkably energized.");
			else output("You wake an hour later in a pile of blankets on the ground, feeling quite sated and rested.  Isabella is humming a pretty tune a few feet away and sharpening the bottom edge of a massive shield with a whetstone.  She stops when she notices you and sets the massive metal object aside with a noisy 'thunk'.  She reaches down for you with surprising quickness and lifts you up to kiss you on the forehead, saying, \"<i>Did you have a good nap?  Ya?  Thanks for being such a thirsty drinker, I haven't felt this light in days.</i>\"  Isabella sets you back on your feet and you stretch, feeling remarkably energized.");
			//(-65 fatigue)
			pc.energy(65);
		}
	}
	//Follower stuff
	if(!isabellaFollower()) isabellaAffection(4);
	//Decrease 'time since milked' count
	else if(flags["COC.ISABELLA_MILKED_YET"] > 0) flags["COC.ISABELLA_MILKED_YET"] = 0;
	pc.loadInMouth(isabella);
	//(Chance of thickening body to 75, chance of softening body if PC has a vag)
	if (rand(2) == 0 && pc.thickness < 75) Mutator.modThickness(pc, 75, 4);
	if (rand(2) == 0 && pc.hasVagina()) Mutator.modTone(pc, 0, 4);
	processTime(60 + rand(20));
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[GET ORAL'ED AS A SMALL MALE]
public function izzyGivesSmallWangsFreeOral():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.smallestCockIndex();
	output("You ");
	if(pc.slut() < 33) output("blush hard and tell Isabella that she can lick if she wants to.");
	else if(pc.slut() < 66) output("blush and tell Isabella that she can definitely give you a lick.");
	else output("pose lewdly and trace a finger over your bulge as you inform Isabella just how happy you'd be to feel her tongue on your [pc.cock " + x + "].");
	output("  The cow-girl blushes hard enough to color her dusky cheeks with a hint of rose, but her chest heaves with barely-contained excitement.  She drops out of the chair onto her knees and licks her lips hungrily, like a child eying a favorite treat.  Her hands dart forward and grab you by the [pc.hips], dragging you into a breast-padded hug.\n\n");
	
	output("Isabella goes to work immediately, undoing the lower portions of your [pc.gear] with strong, forceful motions that shake your [pc.ass] as she forcibly disrobes you.  Free at last, your [pc.cock " + x + "] flops out");
	if(pc.cockTotal() > 1) {
		output(" along with the rest of your unusual package, though Isabella ");
		if(pc.biggestCockVolume() > cockVolume(50)) {
			output("shoves the larger, less desirable member");
			if(pc.cockTotal() > 2) output("s");
			output(" to the side");
		}
		else {
			output("pushes the extra");
			if(pc.cockTotal() > 2) output("s");
			output(" to the side");
		}
	}
	else output(", trembling weakly in the cow-girl's strong fingers");
	if(isabellaAccent()) output(".  The busty redhead gleefully squeals, \"<i>Oooh it's so cute!  Even ven it's hard like this, it looks sort of like something that vould go on a girl.</i>\"  She pulls on it, leading you around by your [pc.cock " + x + "] until you're in front of her chair, and then she pushes you back onto the seat, still warm from the cow-girl's bountiful ass.  She asks, \"<i>How long do you think it vill last, hrmm?  I vonder what its milk tastes like...</i>\"\n\n");
	else output(".  The busty redhead gleefully squeals, \"<i>Oooh it's so cute!  Even when it's hard like this, it looks sort of like something that would go on a girl.</i>\"  She pulls on it, leading you around by your [pc.cock " + x + "] until you're in front of her chair, and then she pushes you back onto the seat, still warm from the cow-girl's bountiful ass.  She asks, \"<i>How long do you think it will last, hrmm?  I wonder what its milk tastes like...</i>\"\n\n");
	
	output("The cow-girl pulls down on her neckline, giving you a tantalizing view of her cream and caramel cleavage.  She leans forwards and presses her milk-swollen tits against your " + pc.legs()  + ", rocking up and down so that you can feel each of the soft orbs squeezing around you.  Isabella's tongue slides out... and out... and out, until you see at least seven inches of tongue hovering over your [pc.cock " + x + "].  Her warm spittle drips from the pulsing, smooth pink exterior of her tantalizing tongue while it lashes back and forth, less than an inch away from your [pc.cockHead " + x + "].  Each drop of fallen cow-girl spit that lands on your [pc.cockHead " + x + "] only turns you on more, until you're grunting and panting at her, begging like an animal with a needy expression on your face.\n\n");
	
	output("Isabella smirks knowingly and caresses the sensitive underbelly of your [pc.cock " + x + "] while she coos, \"<i>");
	if(isabellaAccent()) output("You like, yes?  Mmmmhmm, Izabella knows.  I can see it on your face.  You aren't one of those perverts, are you?  I think you might be, but ve vill have to see, yes?  If you are one of them you'll be squirting all over Isabella's tongue in no time.  I dearly hope you'll prove me wrong.");
	else output("You like, yes?  Mmmmhmm, Izabella knows.  I can see it on your face.  You aren't one of those perverts, are you?  I think you might be, but we will have to see, yes?  If you're one of them you'll be squirting all over my tongue in no time.  I dearly hope you'll prove me wrong.");
	output("</i>\"  To emphasize her point, the well-endowed cow-girl leans down and shows you just how flexible she can be.  The hot, wet slipperiness of her oral organ turns sideways, mashing against the side of your [pc.cockHead " + x + "].  A split-second later, it slides down, and her tongue makes another loop around your [pc.cock " + x + "].  The process continues on and on, girding your manhood in wide, spit-lubed cow-tongue until the entire thing is cocooned inside Isabella's velvet embrace.\n\n");
	
	output("It feels so damned good!  You groan out loud ");
	if(pc.slut() < 50) output("before blushing, ashamed by your wanton behavior but not really wanting it to end.");
	else output("before sighing blissfully, absorbed in the feel of her tongue, never wanting it to end.");
	output("  The strength ebbs from your body while Isabella corkscrews her tongue around you, and the warm, sticky wetness that envelops your [pc.cock " + x + "] grows hotter and hotter.  The contentment you've been feeling melts away like ice-cream on a sunny day while you adjust to the sensation.  Your body craves more, and Isabella obliges, opening her lips wide to engulf you wholly with her mouth.\n\n");
	
	output("The feeling is something like a strange hybrid between a vagina and a blowjob, bathing your entire length with syrupy, warm sensations.  ");
	
	//(Low sensitivity success!)
	if(pc.willpower() >= 30) {
		output("You moan happily, hips rocking instinctively against the cow-girl's vacuum-tight tongue-job as she cranks up her efforts to the maximum in an effort to make you blow already.  Panting lustily, you grab her horns and pull her face partway back, then slam it down while your [pc.cock " + x + "] drips pre-cum onto the top of her tongue.  She flaps it back and forth, smearing your [pc.cockHead " + x + "] with the slippery stuff and torturing you with exquisite sensations that would have lesser individuals spurting in seconds.\n\n");
		if (isabellaAccent()) output("Isabella grunts and pulls back, pulling her horns from your pleasure-weakened fingers and panting heavily.  She groans, \"<i>Nein, I cannot believe it!  Such a small, hard little cock and I couldn't make it spurt, not even vith mein special techniques!</i>\"  She looks up at you with her flushed, breathy face and coos, \"<i>You are NOT a pervert after all.  Not a " + pc.mf("boy", "maid") + ", but a " + pc.mf("man", "woman") + " with a beautiful, succulent little cock for Isabella to suck.  How lucky I am!</i>\"\n\n");
		else output("Isabella grunts and pulls back, pulling her horns from your pleasure-weakened fingers and panting heavily.  She groans, \"<i>No, I can't believe it!  Such a small, hard little cock and I couldn't make it spurt, not even with my special techniques!</i>\"  She looks up at you with her flushed, breathy face and coos, \"<i>You aren't a pervert after all.  Not a " + pc.mf("boy", "maid") + ", but a " + pc.mf("man", "woman") + " with a beautiful, succulent little cock for Isabella to suck.  How lucky I am!</i>\"\n\n");
		output("The cow-girl returns to her task with gusto, snaring your [pc.cock " + x + "] with her tongue, but instead of going all-out with her corkscrew technique, she's pumping it, sliding her hot wetness up and down your shaft with practiced ease.  ");
		if(pc.balls > 0) output("She cups your [pc.balls] and begins caressing the twitching orbs, giving them gentle squeezes each time the pleasure forces them to involuntarily contract towards your groin.");
		else if(pc.hasVagina()) {
			output("She probes your [pc.vagina] with her fingers, running them over your engorged lips and giving your [pc.clit] ");
			if(pc.clitLength < 3) output("gentle squeezes");
			else output("firm pumps");
			output(".");
		}
		else {
			output("She runs one finger from the ");
			if(pc.hasSheath()) output("sheath");
			else output("base");
			output(" of your [pc.cock " + x + "] to your [pc.asshole], teasing the sensitive skin with light touches of her fingernail.");
		}
		output("  You latch onto her horns again and pull her back into position, and the sultry cow-maid wastes no time adding the suction of her puckered lips back to the mix.\n\n");
		
		output("Isabella doesn't protest as you force her to take different positions, using her horns to guide the orally fixated cow-girl's lips up and down, face-fucking her even while she gives you a lewd-sounding tongue-fuck.  The entire time she's looking up at you with delight, perhaps turned on by being used in such a base manner by one with such a small implement of pleasure.  Her eyes sparkle with amusement even as the rest of her countenance blushes with lust, and you pick up the pace, trying to surprise her.  It doesn't work, she just continues to watch you while you brutally face-fuck her and fill the air with the sloppy sounds of oral sex.\n\n");
		
		output("It continues like this for who knows how long, until you're both breathing hard and covered in a fine sheen of sweat.  Isabella finally closes her eyes, and at once her tongue goes crazy, corkscrewing and stroking at the same time.  It's pure heaven!  With strength born of orgasmic need, you pull hard on her horns, mashing her puckered lips into your ");
		if(pc.hasSheath(x)) output("sheath");
		else output("body");
		output(" while her tongue spins and pumps your [pc.cock " + x + "] to an inevitable release.  Your eyes cross as you try to hold out, but in seconds the telltale warmth begins to build inside you.  Finally, you give in and submit, feeling the cum welling in the cow-girl's suckling fuck-hole.\n\n");
		
		output("Isabella pulls her tongue tight, squeezing against you even as ");
		if(pc.cumQ() >= 500) output("fat ");
		output("bulges of [pc.cumNoun] squeeze through your urethra.  With such vise-like tightness squeezing down, release seems nigh impossible, and it feels like more and more cum is backing up inside your urethra.  Isabella looks up, winks, and relaxes, and at once you blow the biggest cum-rope you can possibly produce down her throat.  The sultry cow-girl puts her tongue back to work, pumping it up and down your length as ");
		if(pc.cumQ() < 100) output("spurts");
		else if(pc.cumQ() < 1000) output("torrents");
		else output("eruptions");
		output(" of jism splatter from your spasming cum-tube.  You ");
		if(pc.cumQ() < 250) output("empty the last of your load all over her tongue and pull out.");
		else if(pc.cumQ() < 500) output("empty the last of your load into her belly and leak all over her waiting tongue as you pull out.");
		else if(pc.cumQ() < 1500) output("empty huge batches of spunk into her belly until it's gurgling and full, and as you pull out you dribble enough to completely soak her tongue.");
		else output("empty enough cum inside the cow-girl for it to fill her belly and back up her throat.  By the time you pull out, she's got runners of [pc.cum] leaking from both sides of her mouth and dripping onto her tits, staining her dusky skin [pc.cumColor].");
		output("\n\n");
		
		output("Isabella pulls back and licks her lips, leaving you to realize that your " + pc.legs() + " have been completely soaked with the cow-girl's own sweet cream.  ");
		//if(pc.isGoo()) pc.slimeFeed();
		if(isabellaAccent()) {
			output("She sighs and looks up at the sky, uttering a completely contented 'moo'.  Your own exhalation of pleasure is a bit more muted, but truly, you feel utterly satiated.  Isabella looks over and gleefully says, \"<i>You aren't a pervert!  Oh Izabella is so happy for you!  It's so much fun having someone who knows how to handle my tongue, particularly when they have such a succulent... compact little package for me to suck!</i>\"\n\n");
	
			output("The feisty redhead happily helps you back into your [pc.gear] and gives you an unceremonious smack on the [pc.ass] before saying her goodbyes, \"<i>Come back soon, [pc.name]!  You are quite ze " + pc.mf("man","woman") + ", even if your tasty penis is tiny.  Oh don't look like zat, it makes such [pc.cumFlavor] milk!  I'll lick it up any time.  Now go, I'm sure you have much to do!</i>\"\n\n");
		}
		else {
			output("She sighs and looks up at the sky, uttering a completely contented 'moo'.  Your own exhalation of pleasure is a bit more muted, but truly, you feel utterly satiated.  Isabella looks over and gleefully says, \"<i>You aren't a pervert!  Oh I'm so happy for you!  It's so much fun having someone who knows how to handle my tongue, particularly when they have such a succulent... compact little package for me to suck!</i>\"\n\n");
	
			output("The feisty redhead happily helps you back into your [pc.gear] and gives you an unceremonious smack on the [pc.ass] before saying her goodbyes, \"<i>Come back soon, [pc.name]!  You are quite the " + pc.mf("man", "woman") + ", even if your tasty penis is tiny.  Oh don't look like that, it makes such [pc.cumFlavor] milk!  I'll lick it up any time.  Now go, I'm sure you have much to do!</i>\"\n\n");
		}
		processTime(10);
	}
	//(High sensitivity fail!) 
	else {
		output("You try to fight the heaven around your [pc.cock " + x + "], but it's too much for your poor, sensitive body to endure.  Giving up, you relax, hips pistoning instinctively into her mouth as the warm tightness of an orgasm rises inside you.  Isabella's eyes stare up at your face, watching intently while she keeps her lips wrapped tightly ");
		if(pc.hasSheath(x)) output("around your sheath");
		else if(pc.balls > 0) output("above your balls");
		else output("around your base");
		output(".  She keeps her position, rocking with each of your involuntarily movements, ");
		if(pc.balls > 0) output("her hand stroking and gently squeezing at your [pc.balls] as if she could milk a bigger load from them that way.");
		else if(pc.cockTotal() > 1) output("her hand stroking and squeezing your neglected " + pc.cockDescript(x == 0 ? 1 : 0) + " almost as an afterthought.");
		else output("her hand stroking in an effort to milk your load from you.");
		output("\n\n");
		
		output("Isabella pulls her tongue tight, squeezing against you even as ");
		if(pc.cumQ() >= 500) output("fat ");
		output("bulges of cum squeeze through your urethra.  With such vice-like tightness squeezing down, release seems nigh impossible, and it feels like more and more cum is backing up inside your urethra.  Isabella winks and relaxes, and at once you blow the biggest cum-rope you can possibly produce into her throat.  The sultry cow-girl puts her tongue back to work, pumping it up and down your length as ");
		if(pc.cumQ() < 100) output("spurts");
		else if(pc.cumQ() < 1000) output("torrents");
		else output("eruptions");
		output(" of jism splatter from your spasming cum-tube.  You ");
		if(pc.cumQ() < 250) output("empty the last of your load all over her tongue and pull out.");
		else if(pc.cumQ() < 500) output("empty the last of your load into her belly and leak all over her waiting tongue as you pull out.");
		else if(pc.cumQ() < 1500) output("empty huge batches of spunk into her belly until it's gurgling and full, and as you pull out you dribble enough to completely soak her tongue.");
		else output("empty enough cum inside the cow-girl for it to fill her belly and back up her throat.  By the time you pull out, she's got runners of [pc.cum] leaking from both sides of her mouth and dripping onto her tits, staining her dusky skin [pc.cumColor].");
		output("\n\n");
		
		output("Isabella pulls back and licks her lips, leaving you to realize that your " + pc.legs() + " have been completely soaked with the cow-girl's own sweet cream.  ");
		//if(pc.isGoo()) pc.slimeFeed();
		if(isabellaAccent()) {
			output("You sigh nervelessly as the cow-girl waggles her tongue at you teasingly, making your [pc.cock " + x + "] jump from the memory of pleasure.  The redhead moans, \"<i>Oooh I knew it!  You are a pervert!  I just vanted to do a little licking and you got me all vet with your [pc.cumFlavor]... mmm... cream.</i>\"  She pauses to lick her lips again before giving a gentle moo of contentment.  At least she doesn't seem mad at you!\n\n");
		
			output("The tanned woman looks down at you with disappointment and says, \"<i>You should get going, my tiny-cocked, pervert friend.  Perhaps you vill have some sex and learn how not to submit at ze first hint of pleasure?</i>\"  You go red with indignation, but she fondles your half-limp [pc.cock " + x + "] the entire time, a knowing smile spread across her lips.  Isabella helps you get dressed and gives you a firm smack on the [pc.ass] as she says goodbye, \"<i>Don't change too much " + pc.mf("boy", "maid") + "!  I just hope ven you come back you've learned how not to cum ven I touch your buttons!</i>\"\n\n");
		}
		else {
			output("You sigh nervelessly as the cow-girl waggles her tongue at you teasingly, making your [pc.cock " + x + "] jump from the memory of pleasure.  The redhead moans, \"<i>Oooh I knew it!  You are a pervert!  I just wanted to do a little licking and you got me all wet with your [pc.cumFlavor]... mmm... cream.</i>\"  She pauses to lick her lips again before giving a gentle moo of contentment.  At least she doesn't seem mad at you!\n\n");
		
			output("The tanned woman looks down at you with disappointment and says, \"<i>You should get going, my tiny-cocked, pervert friend.  Perhaps you will have some sex and learn how not to submit at the first hint of pleasure?</i>\"  You go red with indignation, but she fondles your half-limp [pc.cock " + x + "] the entire time, a knowing smile spread across her lips.  Isabella helps you get dressed and gives you a firm smack on the [pc.ass] as she says goodbye, \"<i>Don't change too much " + pc.mf("boy", "maid") + "!  I just hope when you come back you've learned how not to cum when I touch your buttons!</i>\"\n\n");
		}
	}
	if (!isabellaFollower()) isabellaAffection(2);
	processTime(20 + rand(10));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Give Isy Oral]
public function volunteerToSlurpCowCunt():void {
	isabellaSprite();
	clearOutput();
	output("You indicate to Isabella that you're actually more interested in tasting HER, not her milk.  The dusky cow-girl looks at you dumbly, not comprehending what you mean.  Before you can explain, her cheeks bloom with crimson - she finally figured out what you meant.  The red-head quietly asks, ");
	if(isabellaAccent()) output("\"<i>You mean to lick me, down zere?</i>\"  Once again, Isabella preempts your words, though this time she does it with an uplifted skirt-hem and slowly-spreading thighs.  The shadow of the garment conceals the treasure inside, but a faint, feminine smell hits your nose, assuring you that she's looking forward to it as much as you.\n\n");
	else output("\"<i>You mean to lick me there?</i>\"  Once again, Isabella preempts your words, though this time she does it with an uplifted skirt-hem and slowly-spreading thighs.  The shadow of the garment conceals the treasure inside, but a faint, feminine smell hits your nose, assuring you that she's looking forward to it as much as you.\n\n");
	
	output("Isabella pulls the trappings of her clothing higher still, folding the skirt back against her corset to give you a completely unimpeded view at her womanhood.  Her sex is framed by the bronzed skin of her curvy thighs, displaying her femininity perfectly.  A thatch of bright red pubic hair sits above it, trimmed into a neat little teardrop shape that compliments the puffy, arousal-flushed skin of her vulva perfectly.  As you lower yourself down and slide in-between her legs, you're treated to the sight of her nether-lips growing puffier, and then slowly parting with each lusty gasp the cow-girl makes.  The slightly sticky juice she's starting to leak hangs between the parting lips like a slowly-stretching gossamer veil.\n\n");
	
	if(pc.slut() < 33) output("Hesitantly, you start to lean closer and closer until you're mere inches from the cow-girl's slick box.  The air practically fogs with her anticipation.  A strong, impatient hand grabs you by the back of the head and pushes you forward, burying your nose and lips into her wet, squelching lips.");
	else if(pc.slut() < 66) output("Eagerly, you start to lean further and further forward until you're less than an inch from the cow-girl's slick folds, and the air fogs with lusty anticipation.  Before you can dive in, her hand grips the back of your head and FORCES you inside her.  Her greedy lips swallow your nose and lips with one wet squelch.");
	else output("Unabashedly, you dive right into the cow-girl's lust-slicked snatch.  Her greedy lips swallow your nose and lips with one wet squelch, but the cow-girl doesn't seem quite satisfied until her hand is on the back of your head, mashing your " + pc.face() + " roughly over her sex.");
	output("  You smile against her quivering labia and open up, swallowing her love-button into your mouth and letting your tongue begin to rove drunkenly through her channel.  The red-head's thighs provide the perfect place for you to curl your arms and hands around, and as your fingers dig into the supple flesh, you fall into a rhythm of alternating slurps, licks, and humming over her growing clitty.\n\n");
	
	if(isabellaAccent()) {
		output("Isabella moans out, \"<i>Ohhhh ja... you're good at zis.  Mmmm, keep licking, ");
		if(pc.tallness < 60) output("little ");
		else if(pc.tallness > 80) output("big ");
		output(pc.mf("boy","girl") + ".</i>\"  As if you needed any encouragement.  Her taste is surprisingly sweet and fresh, with only a hint of the tang one would expect from such a powerfully built woman.  Her hand relaxes its grip on you as you tongue more aggressively, pressing your lips hard against her vulva and letting your tongue explore the crevices of her labia.  The cow-girl's budding clit continues to expand in your maw throughout, and you suck on it every chance you get until it reaches its full one-and-a-half-inch size.\n\n");
	
		output("\"<i>Don't stop!  Yes, lick momma Izabella's clitty! Ja-yes! YES!</i>\" grunts the dark-skinned woman.  Her thick thighs scissor shut, locking you into your position with soft but vice-like pressure.  Rivulets of honeyed female cum trickle into your tongue with every slurp you give her plus-sized feminine organ.  It pulsates between your lips, and Isabella's legs pull tight with each trembling grunt or barely-articulated moan that escapes the cow-girl's lips.  She pants, \"<i>Such a good tongue-fucker... I – oooohhhhh... I think I shouldn't let you go, ja?  Keep you vhere you belong, right between Izabella's thighs – an oral tongue-pet.</i>\"\n\n");
	}
	else {
		output("Isabella moans out, \"<i>Ohhhh yeah... you're good at this.  Mmmm, keep licking, ");
		if(pc.tallness < 60) output("little ");
		else if(pc.tallness > 80) output("big ");
		output(pc.mf("boy","girl") + ".</i>\"  As if you needed any encouragement.  Her taste is surprisingly sweet and fresh, with only a hint of the tang one would expect from such a powerfully built woman.  Her hand relaxes its grip on you as you tongue more aggressively, pressing your lips hard against her vulva and letting your tongue explore the crevices of her labia.  The cow-girl's budding clit continues to expand in your maw throughout, and you suck on it every chance you get until it reaches its full one-and-a-half-inch size.\n\n");
	
		output("\"<i>Don't stop!  Yes, lick momma Izabella's clitty! Yes! YES!</i>\" grunts the dark-skinned woman.  Her thick thighs scissor shut, locking you into your position with soft but vice-like pressure.  Rivulets of honeyed female cum trickle into your tongue with every slurp you give her plus-sized feminine organ.  It pulsates between your lips, and Isabella's legs pull tight with each trembling grunt or barely-articulated moan that escapes the cow-girl's lips.  She pants, \"<i>Such a good tongue-fucker... I – oooohhhhh... I think I shouldn't let you go, huh?  Keep you where you belong, right between Izabella's thighs – an oral tongue-pet.</i>\"\n\n");
	}
	
	if(pc.cor() < 33) output("You blush at her words and hope she's just talking dirty.");
	else if(pc.cor() < 66) output("You blush at her words and wonder what it would be like if she wasn't talking dirty.");
	else output("Despite knowing she's probably just getting into the moment, you see the appeal of the idea, but perhaps it would be hotter if the roles were reversed?");
	output("  Something splatters over your [pc.gear] and runs down your back.  It's warm, body temperature, and wet.  Is she starting to leak milk just from a little cunnilingus?  Curious about just how much she's going to drip on you, you turn back to your task.  She's nearly as juicy down below as above, and you find yourself having to swallow mouthfuls of her fem-cum from time to time while you work her box over.\n\n");
	
	output("Isabella's heavily accented voice cries out in pleasure, jumping to near-painful octaves as her thighs and pussy begin spasming around you.  It isn't quite painful, but the disconcerting notion of being surrounded by heaving bronze oceans comes unbidden to your mind.  Incredibly thick milk splatters over your head and back, pouring out like water from a faucet.  Meanwhile, the scent of her need grows even stronger, making you dizzy while steady flows of girl-juice force you to swallow or drown.  So lost are you in the steady swallowing that you barely notice when the milk splatters trail off and the thighs disengage themselves from your ears.\n\n");
	
	output("The strong hand on your head gives you one last push forward, smearing your face with cow-girl cum before you're pulled back and hauled to your feet.  Isabella's eyes are lidded and tired.  Her top is completely soaked with thick, sweet-smelling cream, and you can even see small lakes of the stuff that can't escape her jiggling cleavage.  The cow-girl pulls you forward and mashes her lips into yours, kissing you roughly and wetly, her long, flat tongue sliding over your lips and face to clean her juices from it.  She lets you go, giggling as you stumble back with a strand of cummy-spit dangling between your mouths.\n\n");
	
	if(!isabellaAccent()) {
		output("Isabella sighs contentedly and says, \"<i>Thank you, [pc.name].  You're a vonderful licker of the pussy.  Perhaps one of zese times I vill keep you for myself, ja?  I kid, I kid.</i>\"  She blushes heavily, as if realizing what she just said and turns to busy herself with cleaning up.  You get dressed, having some difficulty hiding the lust the act inspired in you.\n\n");
	}
	else {
		output("Isabella sighs contentedly and says, \"<i>Thank you, [pc.name].  You're a wonderful pussy licker.  Perhaps one of these times I will keep you for myself, huh?  I kid, I kid.</i>\"  She blushes heavily, as if realizing what she just said and turns to busy herself with cleaning up.  You get dressed, having some difficulty hiding the lust the act inspired in you.\n\n");
	}
	//(+lots of lust)
	processTime(20 + rand(10));
	pc.lust(15 + pc.libido() / 10);
	if(pc.hasCock()) {
		output("The cow-girl suddenly glances back at your crotch ");
		if(pc.shortestCockLength() >= 9) output("before sighing wistfully.");
		else {
			output("before offering something else.  \"<i>Perhaps you could undress?  I ");
			if(isabellaAccent()) output("vould like to return ze favor.</i>\"");
			else output("would like to return the favor.</i>\"");
			clearMenu();
			addButton(0, "Yes", izzyGivesSmallWangsFreeOral);
			addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
			return;
		}
	}
	isabellaAffection(2);
	if(!isabellaFollower() || !pc.hasVagina() || pc.isMasculine()) {
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	}
	else {
		//(Change the ending of the \"Service Her\" option on an affectionate Isabella to the following; PC must NOT have a dick that suits her and MUST have a vagina)
		if(!isabellaAccent()) output("Seeing the ardent desire your sexual service has so visibly inspired in your body - in your slick, ready cunt and erect nipples - the cow-girl smiles slightly, and asks, \"<i>Perhaps you would like me to return the favor?  It seems only fair...</i>\"");
		else output("Seeing the ardent desire your sexual service has so visibly inspired in your body - in your slick, ready cunt and erect nipples - the cow-girl smiles slightly, and asks, \"<i>Perhaps you vould like me to return ze favor?  It seems only fair...</i>\"");
		//[Leave] [Get Cowlicked]
		clearMenu();
		addButton(0, "Get Licked", receiveAllTheCowTOngues);
		addButton(1, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	}
}

public function IsabellaWinsAndSpanks():void {
	isabellaSprite();
	clearOutput();
	processTime(90 + rand(30));
	//[Lose and get Spanked - Small]
	if(pc.tallness <= 78) {
		if(pc.HP() <= 1) output("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
		else output("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
		output("  A hand grabs hold of the back of your [pc.gear] and lifts you up, placing you firmly over the cow-girl's fur-covered knee.  You can feel the transition from fur to skin underneath your belly, at the midpoint of her thigh.  ");
		if(pc.lustQ() >= 100) output("You start trying to hump and grind, but the angry cow will have none of it.  ");
		output("SMACK!  A powerful impact slams into your [pc.ass], making you gasp out in pain");
		if(pc.hasPerk("Masochist")) output(" and pleasure");
		output(".  The next blow follows shortly after, equally hard but placed upon your other, yet-unbruised butt-cheek.");
		if(pc.hasPerk("Masochist")) {
			output("  You gasp and ");
			if(pc.hasCock()) output("squirt pre-cum ");
			else if(pc.hasVagina()) output("slick your thighs ");
			else output("tremble ");
			output("with masochistic pleasure.");
		}
		output("\n\n");
		
		if (isabellaAccent()) output("Isabella grunts, \"<i>Look at you, acting like one of ze demons!  Now Izabella vill have to beat ze corruption out of you!</i>\"  You groan ");
		else output("Isabella grunts, \"<i>Look at you, acting like one of the demons!  Now I will have to beat the corruption out of you!</i>\"  You groan ");
		if(pc.hasPerk("Masochist")) output("excitedly, wondering just how many more smacks you'll get to take");
		else output("piteously");
		output(" while Isabella cocks her elbow for another spank.  SLAP!  It hits hard enough to send ripples through every soft part of your body.  A bird takes flight somewhere in the distance");
		if(pc.hasPerk("Masochist")) output(" while you swoon and moan, wiggling your rump");
		output(".  The cow-girl picks up the pace, scolding you in between each heavy-handed hit to your bottom.\n\n");
	
		output("\"<i>Bad <SMACK> " + pc.mf("boy", "girl") + "! <CRACK> Learn <SLAP> your <SWAT> lesson!</i>\"  Her sentence is punctuated with one bone-jarring blow that ");
		if(!pc.hasPerk("Masochist")) output("draws a scream from your lips, pushing you past the bounds of consciousness.  Isabella hefts your limp form like a wet noodle and grasses sway behind you as you're carried off.");
		else {
			output("pushes you past your limit.");
			if(pc.hasCock()) {
				output("  You cum like a cannon, blasting your [pc.cum] all over Isabella's fuzzy knee");
				if(pc.cumQ() >= 50) output(", moistening the fur");
				if(pc.cumQ() >= 250) output(" and dripping down to her hooves");
				if(pc.cumQ() >= 1000) output(" until you've created a puddle underneath her");
				output(".");
			}
			if(pc.hasVagina()) {
				output("  Your [pc.vagina] quivers and ");
				if(pc.wetness() < 5) output("drips");
				else output("squirts, splashing [pc.girlCum] over the cow's ankle and hoof");
				output(".");
			}
			output("  The feeling of climaxing from pain alone leaves you weak and exhausted.  Your eyes drift closed as Isabella hefts you and begins to carry you somewhere.");
		}
		output("\n\n");
		output("<b>Some time later...</b>\n");
		
		output("You crack your eyes to the sound of noisy swallowing.  The dark, tanned skin of Isabella's left breast completely fills your view, just as her quad-tipped nipple completely fills your mouth.  She's rubbing your cheek with a knuckle, and you're swallowing down her oh-so-sweet milk.  The warmth of her breast-milk fills your battered and bruised body, but from the gurgling of your belly, it's been filling you for some time already.  From how badly your [pc.ass] is smarting, you're thankful she's cradling you the way she is.  The cow-girl coos,"); 
		if (isabellaAccent()) output("\"<i>Zere zere little one, just lie zere and drink.  Ve'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone to be brutalized and raped by some monster!</i>\"\n\n ");
		else output("\"<i>There there little one, just lie there and drink.  we'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone to be brutalized and raped by some monster!</i>\"\n\n ");
		
		output("In spite of your better judgment, you find yourself continuing to suckle, your arms reaching up to grab the swell of her mountainous orb and cuddle against it.  Isabella titters but even that turns into a pleasured gasp as you start suckling harder, pulling more and more milk from her heavy breast.  She shifts her grip on you slightly, but you lie there and continue to drink.  Your eyes slowly drift closed, though you stay awake for a time, sucking and tasting the milk as it grows ever sweeter.  Something begins squelching wetly nearby, but you're too intent on the cream-like taste in your maw and too tired to find out what it is.\n\n");
	
		output("You go back to sleep, your backside bruised and your belly full of Isabella's milk.\n\n");
		//(+4 sensitivity, -100 lust if masochist, -40 fatigue)
		pc.energy(40);
		//dynStats("sen", 4);
		if(pc.hasPerk("Masochist")) pc.orgasm();
	}
	//[Lose And Get Spanked – Tall]
	else {
		if(pc.HP() <= 1) output("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
		else output("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
		output("  A hand grabs hold of the back of your [pc.gear] and props you up, ass in the air.  ");
		if(pc.lustQ() >= 100) output("You start trying to masturbate yourself, but the angry cow will have none of it.  ");
		output("SMACK!  A powerful impact slams into your [pc.ass], making you gasp out in pain");
		
		if(pc.hasPerk("Masochist")) output(" and pleasure");
		output(".  The next blow follows shortly after, equally hard but placed upon your other, yet-unbruised butt-cheek.");
		if(pc.hasPerk("Masochist")) {
			output("  You gasp and ");
			if(pc.hasCock()) output("squirt pre-cum");
			else if(pc.hasVagina()) output("slick your thighs");
			else output("tremble");
			output(" with masochistic pleasure.");
		}
		output("\n\n");
		
		if (isabellaAccent()) output("Isabella grunts, \"<i>Look at you, acting like one of ze demons!  Now Izabella vill have to beat ze corruption out of you!</i>\"  You groan ");
		else output("Isabella grunts, \"<i>Look at you, acting like one of thee demons!  Now I will have to beat the corruption out of you!</i>\"  You groan ");
		if(!pc.hasPerk("Masochist")) output("piteously");
		else output("excitedly, wondering just how many more smacks you'll get to take");
		output(" while Isabella cocks her elbow for another spank.  SLAP!  It hits hard enough to send ripples through every soft part of your body and grind your chin into the dirt.  A bird takes flight somewhere in the distance");
		if(pc.hasPerk("Masochist")) output(" while you swoon and moan, wiggling your rump");
		output(".  The cow-girl picks up the pace, scolding you in between each heavy-handed hit to your bottom.\n\n");
		
		output("\"<i>Bad <SMACK> " + pc.mf("boy","girl") + "! <CRACK> Learn <SLAP> your <SWAT> lesson!</i>\"  Her sentence is punctuated with one bone-jarring blow that");
		if(pc.hasPerk("Masochist")) output(" draws a scream from your lips, pushing you past the bounds of consciousness.  Isabella hefts your limp form heavily, dragging you through the dirt as your eyes close.");
		else {
			output(" pushes you past your limit.");
			if(pc.hasCock()) {
				output("  You cum like a cannon, blasting your [pc.cum] all over your neck and [pc.face]");
				if(pc.cumQ() > 100) output(", moistening your hair");
				if (pc.cumQ() > 250) {
					output(" and dripping down to the ground");
					applyCumSoaked(pc);
				}
				if(pc.cumQ() > 1000) output(" until you've created a puddle around yourself");
				output(".");
			}
			else if(pc.hasVagina()) {
				output("  Your [pc.vagina] quivers and ");
				if(pc.wetness() < 5) output("drips");
				else output("squirts, splashing [pc.girlCum] over the dirt");
				output(".");
			}
			output("  The feeling of climaxing from pain alone leaves you weak and exhausted.  Your eyes drift closed as Isabella grabs you by the ankles, rolls you over, and starts dragging you through the grass.");
		}
		output("\n\n");
		output("<b>Some time later...</b>\n");
		output("You crack your eyes to the sound of noisy swallowing.  The dark, tanned skin of Isabella's left breast completely fills your view, just as her quad-tipped nipple completely fills your mouth.  She's rubbing your cheek with a knuckle, and you're swallowing down her oh-so-sweet milk.  The warmth of her breast-milk fills your battered and bruised body, but from the gurgling of your belly, it's been filling you for some time already.  From how badly your [pc.ass] is smarting, she gave you quite the beating earlier, and you wish you weren't sitting on such rough ground.  The cow-girl coos,");
		if (isabellaAccent()) output("\"<i>Zere zere big " + pc.mf("boy", "girl") + ", just lie zere and drink.  Ve'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone – you'd probably turn into one of ze monsters!</i>\"\n\n");
		else output("\"<i>There there big " + pc.mf("boy","girl") + ", just lie there and drink.  we'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone – you'd probably turn into one of the monsters!</i>\"\n\n");
		
		output("In spite of your better judgment, you find yourself continuing to suckle, your arms reaching up to grab the swell of her mountainous orb and cuddle against it.  Isabella titters but even that turns into a pleasured gasp as you start suckling harder, pulling more and more milk from her heavy breast.  She shifts her grip on you slightly, but you lie there and continue to drink.  Your eyes slowly drift closed, though you stay awake for a time, sucking and tasting the milk as it grows ever sweeter.  Something begins squelching wetly nearby, but you're too intent on the cream-like taste in your maw and too tired to find out what it is.\n\n");
	
		output("You go back to sleep, your backside bruised and your belly full of Isabella's milk.");
		//(+4 sensitivity, -100 lust if masochist, -40 fatigue)
		pc.energy(40);
		//dynStats("sen", 4);
		if(pc.hasPerk("Masochist")) pc.orgasm();
	}
	if(pc.hasCock()) {
		if(pc.shortestCockLength() < 9) {
			addNextButton(IsabellaPostSpankFeedSex);
			return;
		}
	}
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//[Isabella rapes you with her ass]
public function isabellaRapesYouWithHerAss():void {
	output("", true);
	var x:Number = pc.cockThatFits(cockVolume(38));
	if(x < 0) x = pc.smallestCockIndex();
	
	
	if(pc.HP() <= 1) output("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
	else output("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
	output("  The cow-girl plants a hoof on your chest, pinning you into the dusty sod of her camp while she looks you up and down.  The victorious redhead leers at your groin while she begins to tear off your [pc.gear].  It doesn't take her more than a few seconds to expose your [pc.cocksLight].");
	if(pc.lustQ() >= 100) 
	{
		output("  Your twitching hardness brings a smile to Isabella's face as she coos, \"");
		if(isabellaAccent()) output("<i>Oooh, so eager to be taught a lesson, ja?  Very vell, Izabella vill give you your punishment!</i>\"\n\n");
		else output("<i>Oooh, so eager to be taught a lesson, huh?  Very vell, I'll give you your punishment!</i>\"\n\n");
	}
	else 
	{
		output("  Her bronzed skin caresses your flesh, quickly teasing it to full hardness.  A knowing, almost cruel smile grows on Isabella's face as she asks, \"<i>");
		if(isabellaAccent()) output("Already you vant your lesson, ja?  Very vell, Izabella can punish the naughty little [pc.boyGirl].</i>\"\n\n");
		else output("Already want your lesson, huh?  Very vell, I can punish you, you naughty little [pc.boyGirl].</i>\"\n\n");
	}
	
	output("What's she going to do with you?  She seemed so mad earlier, but this... this just sounds like you're about to get laid.  The cow-girl steps over you, her olive skirt rustling like the nearby plains grasses, barely concealing the treasures it conceals from your sight while she positions herself above your groin.  With her hips swiveling slightly, the busty redhead flexes her thick thighs and lowers herself down.  Each second of waiting is agonizing, and the feel of her sweat-slicked bubble-butt brushing your [pc.cockHead " + x + "] is maddening.");
	if(pc.cockTotal() > 1) {
		if(pc.cockTotal() > 2) 
		{
			output("  The bovine bitch reaches down to swat at some of your [pc.cocksLight], pushing them out of the way.  \"<i>So gross.  Why ");
			if(isabellaAccent()) output("vould you vant so many penises?</i>\"");
			else output("would you want so many penises?</i>\"");
		}
		else 
		{
			output("  The bovine bitch reaches down to stroke your [pc.cock " + x + "].  \"<i>So ready, ");
			if(isabellaAccent()) output("ja?  Vhy are you so eager to be punished?</i>\"");
			else output("huh?  Why are you so eager to be punished?</i>\"");
		}
	}
	output("\n\n");
	
	output("Isabella drops an inch lower, mashing your [pc.cockHead " + x + "] against the tight ring of her pucker.  She grinds and flexes, squeezing her butt-cheeks to surround your member in a sweat-slickened vice.  You moan out loud and reach up to squeeze a handful of bronzed heaven, but the thick-thighed victor is having none of it.  One hard slap effectively rings your bell and nearly dislocates your jaw.  Isabella scolds, \"<i>");
	if(isabellaAccent()) output("Nein!  You are being punished!");
	else output("No! You're being punished!");
	output("</i>\"  You drop your hand and groan miserably, leaking pre over the slutty cow-girl's asshole while she continues to deny you penetration.\n\n");
	
	output("What is she doing!?  Her ass is just squeezing and bouncing along your shaft, teasing you with thoughts of penetration while her tight, pre-glazed sphincter stays closed to your [pc.cock " + x + "].  The cow abruptly changes the tempo, beginning to alternate each flex of her feminine ass-cheeks, using them to caress each side of your [pc.cock " + x + "] with alternating strokes, bending and flexing it slightly from the ever-changing pressure. It feels good, great even, but it's not enough – not enough to make you cum.  Isabella laughs at your pained, hungry expression as she titters, \"<i>Are you sorry for being a naughty, evil [pc.boyGirl]?</i>\"\n\n");
	
	output("It's not fair!  You cry out plaintively, asking her just what she wants you to do, but Isabella looks more disappointed than ever.  \"<i>Isn't it obvious?</i>\" she questions, \"<i>");
	if(isabellaAccent()) output("I vant you to apologize for being so wicked and nasty from the bottom of your heart.  Until you do, I'll keep squeezing and rubbing with mein heiny!");
	else output("I want you to apologize for being so wicked and nasty - from the bottom of your heart! Until you do, I'll keep squeezing and rubbing!");
	output("</i>\"  You close your eyes and try to focus on the limited pleasure she's giving you – maybe you can get off without having to apologize?  The cow-girl will have none of it, and each time you feel the telltale warmth of an approaching orgasm");
	if(pc.balls > 0 && !pc.hasStatusEffect("Uniball")) output(" or the tightening of your [pc.sack] as it pulls your [pc.balls]");
	output(", she eases up, denying you your sloppy prize.  You try to earn more friction with subtle lifts of your hips, but that gets you another ear-ringing slap.\n\n");
	
	output("There's no choice.  You're getting so hard it hurts, and Isabella is a relentless tease.  Whenever you close your eyes, she squirts your face with milk, and by the time you blink her cream from your eyes, she's pulled her gauzy top back into place.  Still, you can see the outline of her quad-tipped areola through the milk-wet fabric, and it only enhances the flow of blood to your already painfully-erect prick.  There's no way around it.  You swallow your pride, trying to ignore the teardrops running from your eyes, and beg as earnestly as you can, \"<i>Okay okay, I'm sorry!  I'll be good. I promise.  Just let me cum!  It hurrrrts!</i>\"\n\n");
	
	output("Isabella looks thoughtful, but she shakes her head with disdain.  \"<i>");
	if(isabellaAccent()) output("No, zat is not sorrow.  You are sorry you can't cum, not sorry for being such a beast.  You must convince me!");
	else output("No, that's not sorrow. You're sorry that you can't cum, not for being such a beast.");
	output("</i>\" she commands.  You stick out your lower lip and look up pathetically, determined to earn your orgasm from the cruel cow.  You whine, \"<i>Please Isabella, I've been a very bad [pc.boyGirl]!  My naughty");
	if(pc.cockThatFits(cockVolume(38)) >= 0) output(" little");
	else output(", nasty");
	output(" cock is so hard and swollen and I promise to be good for you if you just let me cum.  Please! I'll drink your milk and lick your cunt whenever you want.  I'll do anything!</i>\"\n\n");
	
	output("The cow-girl grins like a cat with a mouthful of cream, though in this case the 'cat' makes plenty of her own.  She coos, \"<i>Mmmm, that's a good [pc.boyGirl], and I like to give my good [pc.boyGirl]s lots of treats.  Are you ready for momma Izabella to make you feel so good?</i>\"  You nod with enough enthusiasm to strain your neck, getting a cute giggle from the redhead.  ");
	//(FORK – too big or small enough)
	//[GOOD FIT]
	if(pc.cockThatFits(cockVolume(38)) >= 0) {
		output("She slides her plump ass back down, arching her back to press your [pc.cockHead " + x + "] firmly against her tight, pre-moistened anus.  The cow-girl relaxes slowly, letting her muscles dilate to allow your member inside. The tight ring of muscle slides over your tip, clenching just under the head for a moment before the tension oozes back out of her muscles.  Her large, rounded ass-cheeks flex involuntarily as inch after inch of your [pc.cock " + x + "] is devoured by her anal passage.  The process is excruciating, but eventually the redhead is pressing her plush bottom against your groin");
		if(pc.cockTotal() > 1) output(", smushing against your other dick");
		if(pc.cockTotal() > 2) output("s");
		output(".\n\n");
		
		output("After a brief period of accommodation, Isabella begins to rock up and down, panting and grunting as your [pc.cock " + x + "] coats her inner walls with drippy pre-cum.  The rounded, bronzed cow-butt slaps against you with every lewd, cock-slurping butt-fuck.  You groan, delirious from the crushing tightness of the muscular cow-woman's back-door and the torturous foreplay.  For her part, the bovine broad is busy licking her lips and tugging her nipples, splashing you with a constant downpour of mother's milk that ebbs and flows in time with her bouncing butt.\n\n");
		
		output("You can't hold back – not after all that teasing!  The tightness in your loins is palpable, surging to newer, greater heights with each passing second.  ");
		if(pc.balls > 0 && !pc.hasStatusEffect("Uniball")) output("Involuntary muscles contract, tugging your [pc.sack] up against your crotch while your [pc.balls] visibly contract, loading your body full of liquid lust that's about to explode.");
		else output("Involuntary muscles contract, clenching inside you as your prostate loads your urethra with liquid lust that's about to explode.");
		output("  In one violent, cock-swelling twitch, you blast the first thick ropes of seed into the cow-girl's waiting hole.  Her tail, displaying a surprising amount of control, curls around your ");
		if(!pc.hasSheath(x)) output("base");
		else output("sheath");
		output(", squeezing it affectionately as you pump out the next dollop of love-cream.  You grunt, moan, and sigh as her body's tight orifice milks your cum from you.");
		if(pc.cumQ() >= 1000) {
			output("  It goes on for some time, even making Isabella grunt in fluid-filled discomfort");
			if(pc.cumQ() >= 1500) output(", but your [pc.cock " + x + "] won't let up.  She cries and moans, [pc.cum] pouring out around your shaft");
			if(pc.cumQ() >= 2500) output(", yet you manage to keep going, drooling [pc.cumVisc] spunk until even the ground is soaked with it");
		}
		output(".");
		if(pc.cockTotal() > 1) {
			output("Meanwhile, your chest is glazed by the poor, pinned prick");
			if(pc.cockTotal() > 2) output("s");
			output(" trapped under the cow-cunt's sweaty body.");
		}
		output("\n\n");
		
		output("Isabella sighs, panting lightly from the effort as she pulls off, dripping gobs of goopey spooge all over.  She smiles as she watches the tension drain from your face and says, \"<i>Such a good [pc.boyGirl] to let it all out.  All that nasty, vile stuff just pouring out of your body for me... yes, you are my good boy.</i>\"  The cow-girl kisses you full on the lips, slipping her wide, flat tongue through your own.  You sigh, but she breaks it and stretches languidly.  Overcome by exhaustion, you slip into a restful slumber, interrupted only by the feel of your body swaying as it's moved.");
	}
	//[TOOBIG]
	else {
		output("She slides her plump ass all the way down to your ");
		if(!pc.hasSheath(x)) output("base");
		else output("sheath");
		output(", getting a nice low moan to slip from your lips.  Then she flexes her thighs and pulls up, dragging the dusky, sweaty butt-cheeks back up your length, squeezing her muscles to tighten and loosen the grip of her cheek-fucking. Up and down she goes, clenching and bouncing her plush bottom for your [pc.cock " + x + "].");
		if(pc.cockTotal() > 1) {
			if(pc.cockTotal()) output("Even though they're being ignored, each time her cheeks crush against your other cocks, they squeeze out a few spurts of pre-cum.");
			else output("Even though they're being ignored, each time her cheeks crush against your other cock, it squeezes out a spurt of pre-cum.");
		}
		output("\n\n");
		
		output("After so much teasing and torture, you cum brutally hard.  ");
		if(pc.balls > 0 && !pc.hasStatusEffect("Uniball")) output("Your [pc.sack] pulls tight against your body, each of your [pc.balls] quivering and pushing its load through you.");
		else output("Your body seems to pull tight, like a violin string, and you feel your organs quivering and working to push your load through you.");
		output("  Warm pressure builds higher and higher, and then at once you're shooting, spraying ropes of jism a half-dozen feet into the air.  Your urethra bulges, and you spurt out the next batch to splatter on Isabella's back.  Some of it lands on her black leather corset, glazing it with a [pc.cum].");
		if(pc.cockTotal() > 1) {
			output("  Semen sprays onto your chest, fired by your forgotten extra cock");
			if(pc.cockTotal() > 2) output("s");
			output(", but it's weaker, almost an afterthought.  ");
		}
		output("You keep squirting until your body is completely empty, leaving your [pc.cock " + x + "] to twitch and clench, trying to unload phantom seed.\n\n");
		
		output("You uncross your eyes and look at your handy-work. Isabella's clothes are smeared with a thick layer of slime.  It drips down her bronzed butt and oozes over your ");
		if(pc.balls == 0) output("crotch");
		else output("balls");
		output(", pooling around your " + pc.legs() + " on the ground.");
		if(pc.cumQ() >= 1000) output("  Ropes of it drip from Isabella's crimson locks, plastering her hair to her neck and dripping onto her shirt.  All around you the dirt has turned to a slimy, soupy mud, nearly [pc.cumColor] in color from your copious leavings.");
		if(pc.cumQ() >= 2000) output("  The spooge completely soaks you both, surprising even you with its volume and quantity.");
		output("\n\n");
		
		output("Isabella sighs, panting lightly from the effort as she watches the tension drain from your face.  \"<i>Such a good [pc.boyGirl] to let it all out.  All that nasty, vile stuff just pouring out of your body for me... yes, you are my good boy.</i>\"  The cow-girl kisses you full on the lips, slipping her wide, flat tongue through your own.  You sigh, but she breaks it and stretches languidly.  Overcome by exhaustion, you slip into a restful slumber, interrupted only by the feel of your body swaying as it's moved.");
	}
	if (!isabellaFollower()) isabellaAffection(4);
	processTime(25 + rand(10));
	pc.orgasm();
	//dynStats("sen", 2);
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//[OPTIONAL GET RAPED AFTER SPANKING/FEEDING]
public function IsabellaPostSpankFeedSex():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.smallestCockIndex();
	output("<b>Squish... squish... squish...</b>\n");
	output("<i>Waaa?</i>  You groan, cracking your eyes as something rouses you from your slumber.  Something's slapping you, and you're so warm and WET.  Something else is off – you feel good, very very good.  You try to sit up, but sweat-soaked flesh slams into your gut, leveling you while simultaneously knocking the wind from your lungs.  Your eyes finally open wide from the sudden onset of pressure and pain, revealing the source of your disorientation even as a jolt of lust travels to your soaked groin.\n\n");
	
	output("Sweat beads on naked, milk-swollen melons while they bounce and squirt above you, occasionally blocking your view of everything but the four milk-dripping nipple-tips.  Attached to the glorious orbs is a delirious-looking Isabella, tongue hanging down past her chin as she grunts and rides you with you a far-away look in her eyes.  Her pussy is completely exposed; hairless, cum-slicked lips, puffy as they slide over your [pc.cock " + x + "], devouring it like a snake engulfing its prey.  The teardrop-shaped tuft of red hair above her prominent button is equally soaked with white-tinged love-mess, making it quite clear that you've already gotten off once.\n\n");
	
	output("Isabella's eyes are tiny, insane pin-pricks that focus on you as she realizes you're awake.  She moans,");
	if (isabellaAccent()) output(" \"<i>Das is good [pc.boyGirl]!  Don't move!  Iz impolite to interrupt your elder's pleasure, and your tiny cock is so small and unique.  You vill lie there until momma has had her fill, ja?</i>\" To emphasize her point she puts a hand ");
	else output(" \"<i>There's a good [pc.boyGirl]!  Don't move!  Its impolite to interrupt your elder's pleasure, and your tiny cock is so small and unique.  You will lie there until momma has had her fill, yes?</i>\" To emphasize her point she puts a hand ");
	if(pc.biggestTitSize() < 1) output("on your chest");
	else output("in between your " + pc.allBreastsDescript());
	output(", pushing your torso so hard it sinks an inch or two into mud that reeks of Isabella's sex-juices.  You lie there, immobilized and defeated while you're forcibly raped, used like a small, disposable dildo.\n\n");
	
	output("The cow-girl lets some of the pressure off in order to tweak one of your [pc.nipples], but as you gasp, her tongue is forced into your mouth, smothering your ");
	if(!pc.hasLongTongue()) output("smaller");
	else output("longer");
	output(" one with the slippery smoothness of her cow-like organ.  It slides over the top, curls around squeezing, and then it's underneath yours, beckoning you to venture past Isabella's naturally darker lips.  Her fingers find her way into your hair, pulling on it to keep you exactly where she wants you, like a dog on a leash.  You groan helplessly into her mouth, your voice melding with her frenzied moans as she splatters mud, milk, and girl-cum from each thigh-jiggling impact.\n\n");
	
	output("It feels so good, so very good, but you struggle with the pleasure.  It SHOULDN'T feel this good to be held down by and raped until you're sinking into sex-scented mud, yet your [pc.cock " + x + "] is twitching inside Isabella's muscular folds, growing so hard you feel like a nail being driven through butter.  The cow-girl's milk-fountains don't help, soaking your belly and [pc.chest] with sweet, thickening cream and adding more whorls of white to the dirty slurry.  Isabella's back arches and she screams,");
	if (isabellaAccent()) output("\"<i>MooooOOOOOooooooh jaaaaaaaaaaa!</i>\"");
	else output("\"<i>MooooOOOOOooooooh yeeeeeeesssss!</i>\"");
	output(" Thick waves of white burst from her blushing milk - spouts, rolling over your body.  A few droplets even land in your recently vacated mouth to remind you of a chilled treat your parents sometimes made during the spring thaw, while ice was still in the river.\n\n");
	
	output("Her pussy tightens, clamping down and feeling smaller and smaller.  It's inhuman, squeezing more than a clenched fist - only this grip is made of syrupy-slipperiness and velvet cushions.  You can't resist the pleasure any longer, and you arch your back, digging yourself deeper into the mud in order to push your [pc.cock " + x + "] a tiny bit further into Isabella's spasming embrace.  Spooge boils up from your [pc.balls], ");
	if(pc.cumQ() < 50) output("spurting into Isabella's hungry, constricting snatch.");
	else if(pc.cumQ() < 250) output("spurting into Isabella's suddenly-tight cunny with such thick streams that drops of it run from her lips.");
	else if(pc.cumQ() < 1000) output("bursting into Isabella's constricting cunny and soaking every inch of her passage with your copious spooge.");
	else if(pc.cumQ() < 2000) output("bursting into Isabella's constricting cunt, filling her womb, and leaving her belly with a little bit of a spunk-paunch.");
	else output("exploding into Isabella's constricting cunt in huge waves.  You feel her passage fill around you, then her womb, and then the next pump bulges her belly, giving her a spunk-paunch.  She moans as each successive deposit of seed fills her until her belly is pregnant with spooge, and her nether-lips are glazed white and dripping.");
	if(pc.cumQ() >= 10000) output("So much leaks out that the mud lightens and thickens, taking on a [pc.cumNoun]-like viscosity.");
	output("\n\n");
	
	output("Once you've emptied the last of your submission into Isabella, she rolls off of you, panting heavily.");
	if (isabellaAccent()) output("\"<i>Das vas a very good [pc.boyGirl]!  I hope I taught you some manners.  Maybe come visit me some time, but be polite for me or I'll have to give you another spanking!</i>\"");
	else output("\"<i>You're a very good [pc.boyGirl]! I hope I taught you some manners. Maybe you should come and visit me some time, but be polite for me or I'll have to give you another spanking!</i>\"")
	output(" She climbs up on woozy legs and walks off, leaving you to doze in the defiled well of earth like a discarded tissue.\n\n");
	if (!isabellaFollower()) isabellaAffection(3);
	processTime(25 + rand(10));
	pc.orgasm();
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//LOSS
public function isabellaDefeats():void {
	//if(monster.statusAffectv1(StatusAffects.Sparring) <= 1) {
		if(pc.hasCock() && rand(2) == 0) isabellaRapesYouWithHerAss();
		else IsabellaWinsAndSpanks();
	//}
	//else {
		//cleanupAfterCombat();
	//}
}

public function isabellaDefeatsSpar():void {
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//[VICTORY!]
public function defeatIsabella():void {
	isabellaSprite();
	clearOutput();
	output("You push the ");
	if(enemy.HP() <= 1) output("damage-dazed");
	else output("arousal-addled");
	output(" cow-bitch, feeling your hand sink into one of her pillowy tits for a half-second before she tips and falls squarely onto her wide ass.  Isabella ");
	if(enemy.HP() <= 1) output("gr");
	else output("m");
	output("oans, \"<i>");
	if (enemy.HP() <= 1)
	{
		if (isabellaAccent()) output("Vhy must you be so like them?  You act like a demon!  Stay away from mein milk!");
		else output("Why must you be so like them? You act just like a demon! Stay away from my milk!");
		
	}
	else
	{
		if (isabellaAccent()) output("I didn't vant this!  ...but, please, I have so much milk... drink my moOOOO-ilk!");
		else output("I didn't want this! Please, I have so much milk... dink my moOOO-ilk!");
	}
	output("</i>\"  ");
	if(enemy.HP() <= 1) output("She acts so haughty, but she can't hide how her nipples are tenting her sheer top.");
	else output("She acts like all she needs is a milking, but you can smell the dampness she's trickling from 'down under'.");
	/*
	2962	victoryLactation69()
	2963	PCVictoryOnIzmaButtsex()
	2964	victoryAgainstIzzzzzySixtyNine()
	2965	tooBigVictoryTittyFuckingFuntimesWithMilk()
	2966	vaginalProdNPokeIsabella()
	2967	tinyVictoryTittyFuckingFuntimesWithMilk()*/
	clearMenu();
	addDisabledButton(0, "Lactation69");
	addDisabledButton(1, "Buttsex");
	addDisabledButton(2, "Sixty-Nine");
	addDisabledButton(3, "Vaginal");
	addDisabledButton(4, "Big Titfuck");
	addDisabledButton(5, "Small Titfuck");
	
	if (pc.lactationQ() >= 300) addButton(0, "Lactation69", victoryLactation69);
	if (pc.lust() >= 33) {
		if(pc.hasGenitals()) addButton(2, "Sixty-Nine", victoryAgainstIzzzzzySixtyNine);
		if(pc.hasCock()) {
			if(pc.cockThatFits(enemy.analCapacity()) != -1) addButton(1, "Buttsex", PCVictoryOnIsabellaButtsex);
			if(pc.cockThatFits(enemy.vaginalCapacity()) != -1) addButton(3, "Vaginal", vaginalProdNPokeIsabella);
			if(pc.cockVolume(pc.biggestCockIndex()) > cockVolume(70)) addButton(4, "Big Titfuck", tooBigVictoryTittyFuckingFuntimesWithMilk);
			if(pc.shortestCockLength() < 9) addButton(5, "Small Titfuck", tinyVictoryTittyFuckingFuntimesWithMilk);
		}
	}
	
	addButton(14, "Leave", function():*{ processTime(15 + rand(10)); CombatManager.genericVictory(); } );
}

public function defeatIsabellaSpar():void {
	//if(monster.statusAffectv1(StatusAffects.Sparring) == 2) {
		output("You give the ");
		if(enemy.HP() <= 1) output("damage-dazed");
		else output("arousal-addled");
		output(" cow-girl a push, and she immediately slumps down, defeated.  Since this was just a light-hearted sparring match, you help her up and back to camp, where she can ");
		if(enemy.HP() <= 1) output("recuperate.");
		else output("take care of her needs (or be taken care of).");
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
		//return;
	//}
}

//[LACTATION 69]
public function victoryLactation69():void {
	isabellaSprite();
	clearOutput();
	output("Well, now that she's mentioned milk, your [pc.fullChest] do feel a little full, swollen with the weight of your own lactic cargo.  Even your [pc.nipples] feel bloated and ready to be suckled.  With a devilish grin, you pace around the prone, bovine belle and taunt her, suggesting quite lewdly how you'll drain her tits dry while forcing her to guzzle your own [pc.milk].  Her eyes go wide, first with shock, then with increasing lust.  The cow-girl's features soften into submissive acceptance when you stop at her head and undo the bindings of your [pc.gear].\n\n");
	
	output("Isabella mumbles, ");
	if (isabellaAccent()) output("\"<i>Moo-milk?  Vell, it does sound kind of ni...</i>\"");
	else output("\"<i>Moo-milk? Well it does sound kind of ni...</i>\"");
	output(" A bovine tongue slides over her dusky lips, cutting off her rambles while it whets her lips for her coming feast.  This cow - cunt feigns modesty, but she's every bit the hungry slut underneath – just look at her spit-lubed lips, heaving, barely-concealed chest, and needy, begging eyes.  She wants this.  You pull at her top, but it stretches rather than rips.  Inspired by the flexible fabric, you pull it down, loosening her corset as you bunch her shirt up underneath the swell of Isabella's plush tits.\n\n");
	
	output("Unbidden, drops of milk begin to form at the tips of your [pc.nipples], and you take this for a sign that your body is ready to teach Isabella her place.  Leaning down, you let your ");
	if(pc.breastRows.length > 1) output("top row of ");
	output(pc.breastDescript(0) + " hang around Isabella's head, but her horns poke and prod at your tits uncomfortably.  You arch your back a little and reposition yourself so that just one of your rounded melons is pressing down on the bovine broad's face, the nipple leaking milk down her cheek.  Her well-rounded tit is an inch or two below you, smelling pleasantly of sweetness and cream.\n\n");
	
	output("Isabella latches on almost immediately, suckling hard to get your milk flowing and drinking deeply.  One of her hands squeezes her bronzed mammary to push her areola higher, right into the surprised 'o' of your mouth.  It tastes warm and sweet, just like the milk that starts to squirt from the four nipple-tips into your throat.  You swallow it easily, instinctively even, and you start to suck after each swallow, refilling your mouth with larger and larger volumes of creamy cow-milk.  The busty redhead's lips suck and suck, only pausing for her tongue to slurp the milk from your [pc.nipple].\n\n");
	
	output("You feel like you've lost control of the situation, or at least given some of it up in exchange for shared lactic bliss. Oh well, there're worse things than having your mouth wrapped around bloated nipples while a hungry milk-slut drains that aching pressure from your swollen mammary.  You can feel the ebb and flow as it escapes your [pc.nipple], slowly replacing bottled-up discomfort with a sensual, almost erotic release.  Heavy eyelids flutter closed as you fixate completely on your mouth and chest, sucking and squirting in a perfect, milky rhythm with your 'victim'.\n\n");
	
	output("The air grows thick with the aroma of cream and lust.  Isabella squirms underneath you, the human parts of her thighs getting slick and slippery with sweat and girl-cum.  She squirms, digging her free hand up under the hem of her fluid-darkened skirt to seek release.");
	output("  You follow her lead, reaching back to ");
	if(pc.hasCock()) output("squeeze [pc.eachCock] gently, feeling the heavy, turgid mass pulsating with each beat of your heart.");
	else if(pc.hasVagina()) output("rub your fingers over the puffy lips of your pussy, feeling your vulva spread to give the juice-lubed digits access.");
	else output("rub your fingers up your taint to your clenched pucker, circling the clenching asshole with a digit before you bury it inside.");
	output("\n\n");
	
	output("The increasingly sugary taste of Isabella's milk cuts off just as your chest is emptied, and the two of you switch to the next tit simultaneously, synchronized by some unspoken cooperation.\n\n");
	
	output("With your bellies filling, the conflict that started it all seems like a distant dream that's washing away with each burst of sexual relief and swallow of pearlescent milk.  Isabella's moos of pleasure vibrate your [pc.nipple], adding to your own");
	if(pc.breastRows.length > 1) output(", while your other " + pc.breastDescript(1) + " plasters her crimson hair into her scalp");
	output(".  Her hips buck and writhe off the ground, the squelching of her masturbation filling the air just as her pumping digits fill her box.");
	if(pc.hasVagina()) output("  Of course, you're pumping at your own quim nearly as hard, but the messy cow-girl's efforts still manage to drown you out.");
	else if(pc.hasCock()) output("  Of course, you're pumping at [pc.eachCock] just as hard, but the sounds of your fapping are easily drowned out by the enthusiastic cow-girl.");
	else output("  Of course, you're fingering your [pc.asshole] just as hard, but that muscular hole barely makes a sound as you violate it.");
	output("  The cow-girl shudders from head to toe with her climax, the milk thickening into sweet-cream as she sprays it from all four of her nipple-tips onto your tongue.\n\n");
	
	output("After a few moments of guzzling Isabella's orgasmic cream, your own climax starts to build, radiating from your squirting [pc.nipple] and ");
	if(pc.hasCock()) output(pc.cocksDescriptLight());
	else if(pc.hasVagina()) output(pc.vaginaDescript());
	else output(pc.assholeDescript());
	output(".  You arch your back, crushing the cow-girl's face with the swell of your jiggling breast while you drain the last of your milky reserves into her, using her as your personal breast-pump.");
	
	//(Cuntnips) 
	if(pc.hasFuckableNipples()) output("  Isabella thrusts her tongue at your [pc.nipple], burrowing it deep into the unusual passage to get at the last of your liquid bounty and inadvertently intensifying your pleasure.  Your arm gives out and you drop on top of her, burying her in tit while hers serve as your pillows.");
	//(Cock & Puss)
	if(pc.isHerm()) {
		if(pc.isSquirter()) output("  The juices that splatter from your [pc.vagina] almost seems an afterthought, but when you cum, you cum <i>allll</i> over.");
		else if(pc.wetness() > 3) output("  The juices that drip from your [pc.vagina] almost seems an afterthought, but when you cum, you cum all over.");
		else output("  The clenching of your [pc.vagina] almost seems an afterthought, but when you cum you cum all over.");
	}
	//(Cock)
	if(pc.hasCock()) {
		output("  With a few more solid pumps [pc.eachCock] goes rock hard");
		if(pc.balls > 0) output(", your [pc.balls] pulling tight against your groin");
		output(".  Warmth spreads from your groin as ropes of [pc.cum] shoot and spray over the dirt, a few even hitting Isabella's head.  She doesn't give any sign of knowing or caring, so intent is she on your milk.");
		if(pc.cumQ() >= 1000) output("  You squirt and drip for ages, making a nice big puddle around both of you.");
	}
	//(Puss only)
	if(pc.hasVagina() && !pc.isHerm()) {
		output("  The constant fingering of your [pc.vagina] accomplishes its goal, making your velvet tunnel clench vise-tight against the intruding digit.  ");
		if(pc.isSquirter()) output("[pc.GirlCum] squirts from your hole, splattering onto the dirt.");
		else if(pc.wetness() >= 2) output("[pc.GirlCum] drips from the hole, absorbing into the dirt.");
		else output("[pc.GirlCum] soaks your lips, filling the air with female lust.");
		output("  Your [pc.clit] pulses and jumps with each brush of your thumb, and you nearly lose yourself in the hedonistic self-pleasure.");
	}
	//(butt)
	if(!pc.hasGenitals()) output("  The constant fingering of your [pc.asshole] finally comes to fruition, sending bolts of pleasure from your anal passage.  The star clenches tight around your digits, contracting involuntarily around the invader.");
	output("\n\n");
	
	output("Empty and sore-nippled, you roll sideways and lie with Isabella on the dirt");
	if(!isabellaFollower()) output(" of her camp");
	output(".  The two of you look each other over, licking the last of the milk from your lips and sharing a moment.  She speaks first, mouthing, ");
	if (isabellaAccent()) output("\"<i>Zat vas nice... a good way to cool down angry hearts.  Let's... do zis next time ve fight!</i>\"");
	else output("\"<i>That was nice... a good way to cool down angry hearts. Let's... do this next time we fight!</i>\"");
	output(" You nod as the blissed-out cow-girl closes her eyes, contented and cradling the slight paunch you've given her.  A moment later you've regained your strength, but you have trouble fitting back into your [pc.gear] with all the milk in your system.");
	if(!isabellaFollower()) isabellaAffection(8);
	//(slimefeed, -lust, +thickness & -tone?)
	pc.milkInMouth(isabella);
	//You've now been milked, reset the timer for that
	//pc.addStatusValue(StatusAffects.Feeder,1,1);
	//pc.changeStatusValue(StatusAffects.Feeder,2,0);
	pc.milked();
	//Reset anger
	flags["COC.ISABELLA_ANGRY"] = 0;
	processTime(10 + rand(5));
	pc.orgasm();
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[VICTORY BUTTSEX]
public function PCVictoryOnIsabellaButtsex():void {
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	var y:Number = pc.cockThatFits2(enemy.vaginalCapacity());
	isabellaSprite();
	clearOutput();
	output("Milk, huh?  No, that won't do.  You tell the ");
	if(enemy.lustQ() > 99) output("horny ");
	output("cow-slut to roll over and get on all fours.  ");
	if(enemy.HP() <= 1) output("She struggles to comply, heaving her hefty body until she's wobbling on all fours, nearly falling into the dirt.");
	else output("She struggles to comply, pulling her hands away from her erogenous zones as she wobbles onto shaky hands and knees.");
	output("  You circle her, eyeing her like a predator salivating over a raw steak.  She shivers, sending ripples of motion through her plump, sun-kissed backside and swinging melons.  Her skirt rides high, ruffled and pushed up on her back, but Isabella dares not lower it under your watchful gaze.\n\n");
	
	output("You shrug out of your [pc.gear] and expose [pc.eachCock] to the warm, breezy air");
	if(pc.lust() < 70) {
		output(", allowing ");
		if(pc.cockTotal() == 1) output("it ");
		else output("them ");
		output("to harden precipitously.  The turgid flesh of [pc.eachCock] grows harder and harder, egged on by the sight of Isabella's dark pucker and juicy, leaking cunt");
	}
	else {
		output(", the wind teasing over the hardness of your length");
		if(pc.cockTotal() == 1) output(".  It seems");
		else output("s.  They seem");
		output(" to grow harder and harder, the tumescent flesh engorging beyond measure while you eye the sight of Isabella's dark pucker and juicy, leaking cunt");
	}
	output(".  Isabella looks back with a mixture of fear and primal lust.  She doesn't seem to realize she's begun to wiggle her hips back and forth, teasing you with the plump, sweat-soaked curves of ass and the snake-like motions of her tail.\n\n");
	
	output("Isabella moans");
	if(enemy.HP() <= 1) output(", forgetting her wounds between the sight of your naked body and her lewd, compromised position");
	else output(" lustily, begging to be penetrated with her body while her voice tries to make love to your ears");
	if (isabellaAccent()) output(".  \"<i>Vould you... put it inside me?  Please, I'm so sorry I didn't let you ravish me.  Take me, violate me vith your spear of lust!</i>\"");
	else output(".  \"<i>Would you... put it inside me? Please, I'm so sorry I didn't let you ravish me. Take me, violate me with your spear of lust!</i>\"");
	output(" she pleads.  Her attempt to talk dirty is so bad it nearly makes you cringe.  She was better off moaning and mooing like a beast in heat, and perhaps it would be best to treat her like one.\n\n");
	
	output("You advance and grab her tail, yanking the bovine appendage back to pull those glorious ass-cheeks closer to your [pc.cock " + x + "].  ");
	if(pc.cockTotal() > 1) {
		output("It's probably the best suited to the task, out of your [pc.cocksLight]");
		if(y >= 0) output(", and your " + pc.cockDescript(y) + " may as well go into that sloppy cow-cooch");
		output(".  ");
	}
	output("Isabella's eyes widen with from the sudden pressure of your " + pc.cockHead(x));
	if(y >= 0) output(" and other " + pc.cockHead(y) + " pressing against her holes");
	else output(" pressing against her dark pucker");
	output(", and she voices a moo of discomfort when you slap her moist backside.  You ignore it and pull harder on her tail, forcing her anus to devour your entire [pc.cock " + x + "] in a single stroke");
	if(y>= 0) output(" while her pussy sheaths your other member in dick-melting warmth");
	output(".\n\n");
	
	output("The over-endowed redhead shudders underneath you, her muscles clamping involuntarily with such force that you're immobilized mid-thrust.  Somehow she holds you like that, squeezing with enough force that your " + pc.cockHead() + " feels like it could pop.  You slap her ass hard enough to leave a handprint on her plump posterior, the spreading shock pursing Isabella's lips just as it dilates her anal ring.  She grunts wordlessly, too far gone to give voice to her complaints.  You slam back into her sweltering embrace");
	if(y >= 0) output("s");
	output(" hard enough to make the clap echo off some distant landmark.\n\n");
	
	output("Milk audibly 'drip-drip-drip's in the dirt, disgorged by the cow's wobbling udders.  Isabella's loud grunts begin to change with each prick-sheathing thrust, adding a low whimper of lust to her voice until the cow-girl is letting out long moos of contented desire.  You let go of her tail and grab hold of her waist.  Fingers dig into the red lace of her corset with every pull, dragging the red-head's near-heifer-sized cheeks into your [pc.hips].  She still squeezes around your ");
	if(y >= 0) output("members");
	else output(pc.cockDescript(x));
	output(" but not with the dick-crushing tension she exerted before.\n\n");
	
	output("You pull on her hair, twisting the short red tangles in your finger to arch her neck and hold her still.  Her pussy ");
	if(y>= 0) output("contracts around your " + pc.cockDescript(y) + " and squeezes a flow of heated pussy-juice over the penis, cocooning it with enough warm heat and wetness to make you feel as if you're melting.");
	else output("spews out a few strands of girl-juice that cling to your " + pc.legs() +", hanging and stretching with every sticky slap against her body.");
	output("  The rising pitch and volume of Isabella's moo is the only warning you have, and even that doesn't prepare you for the force of her orgasm.  Her body convulses from hoof to crown, starting with her bronzed thighs, and then moving to her sweat-soaked ass-pillows.  Finally it spreads through her arms and swinging udders, unleashing a torrent of sweet-smelling breast-cream.\n\n");
	
	output("The twitching, squeezing spasms of the cow-girl's passage");
	if(y >= 0) output("s");
	output(" shoot fireworks of pleasure up your spine to burst in your brain.  You grunt and rut, pounding Isabella's pre-cum oozing hole");
	output(" and feeling the cum build up inside your [pc.balls].");
	if(y < 0) output("  Though you could never impregnate such an orifice, your instinct to fill her tightness with male essence has taken over, and you won't be satisfied until her asshole is leaking your seed.");
	else output("  Though you know that at least half your load will be wasted, your instinct to fill her has taken over, and you won't be satisfied until every single one of the cow-cunt's vacancies are leaking sperm.");
	output("  Heat wells up from your [pc.balls], signaling the time to teach the haughty broad a lesson, at last.\n\n");
	
	output("Isabella's short red hairs slip through your climax-weakened fingertips, but focused as you are in the feeling of orgasm boiling from your urethra, you don't care.  Jism erupts inside her, spouting from your dilated cum-slit into the cow-girl's deepest, darkest recesses.  ");
	if(y >= 0) output("Your " + pc.cockDescript(y) + " emulates its brother, shooting ropes of semen into the cow-girl's drippy pussy.  ");
	output("Isabella's full-body orgasm had been winding down, but the feel of being packed with your spooge sets her off all over again.  Her arms give out and she lies down in a milky puddle of her own creation, squirting mud and cream from the edges of her now-pressurized tits.");
	if(pc.cumQ() >= 750) {
		output("  You keep at it, packing her bottom");
		if(y >= 0) output(" and drippy puss");
		output(" with more spunk, enough to balloon her back-door and remove most of the sensation from your [pc.cock " + x + "].");
		if(pc.cumQ() < 2000) {
			output("  Her belly distends slightly by the time you finish, but her exhausted, half-crossed eyes don't seem to mind.");
		}
		else output("  White goo sprays out from her flooded backside, forced out by the pressure of your incessant jizz-jets.  By the time you finish, her belly looks pregnant with your goo, but her blissful, cross-eyed expression shows just how little she minds.");
	}
	output("\n\n");
	
	output("Spent at last, you give her rump a solid smack and draw back from her sloppy, smutted sheath");
	if(y >= 0) output("s");
	output(".  Isabella slumps down and closes her eyes, though her rump stays pointed up in the air, displaying the seed you left puddling in her rectum.  Amazingly, the milk she was leaking in the mud seems to have been absorbed already, leaving the earth dry and dusty once again.\n\n");
	
	output("You get dressed and set off, feeling quite proud of how you handled the haughty foreign bovine.");
	if(!isabellaFollower()) isabellaAffection(3);
	processTime(15 + rand(5));
	pc.orgasm();
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[Victory 69]
public function victoryAgainstIzzzzzySixtyNine():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.cockThatFits(cockVolume(38));
	if(x < 0) x = pc.smallestCockIndex();
	output("You aren't interested in her milk though.  You came for a different sort of relief, and Isabella should be thankful you plan to share it.  The confused, beaten cow watches you with wide, helpless eyes as you disrobe, dropping your [pc.gear] heavily on some of her rugs.  Her skirt shouldn't pose a problem; a quick push has it bunched up around Isabella's waistline.  With the offending garment moved, you can get a good look at a sight you plan to get <b>intimately</b> familiar with for the next fifteen minutes or so.\n\n");
	
	output("Before you are the ");
	if(int(flags["COC.EDRYN_AFFECTION"]) <= 0) output("plumpest, juiciest set of pussy lips you've ever had the chance to lick.");
	else output("plumpest, juiciest vulva you've seen on a pussy since you met Edryn.");
	output("  It doesn't surprise you that they glisten, or that her nethers are slowly parting to reveal her pinky-sized clit and moist canal, but what does surprise you is the sweet, pleasant scent the red-head's lips exude.  After watching the teasing display with such rapt attention, you finally notice the teardrop-shaped thatch of red pubes above her entrance.  It seems to match her blooming 'flower' perfectly, undulating with the cow-cunt's incessant, nervous squirming.\n\n");
	
	output("You twist sinuously, sliding your [pc.hips] over Isabella until your groin is hovering over her mouth and your " + pc.legs() + " are brushing her ears.  She tentatively opens her mouth, spreading her dusky lips wide as her tongue licks them.  The cow-girl grabs hold of your [pc.ass], knowing full well what's expected of her, and pulls up to ");
	if(pc.hasVagina() && !pc.hasCock()) output("nuzzle your [pc.vagina], smearing your vulva with her lips even she spreads the folds to access your " + pc.clitDescript());
	else if(pc.cockThatFits(cockVolume(38)) != -1) output("swallow your [pc.cock " + x + "] whole, plying her smooth, spit-covered tongue over every inch of it");
	else output("lick your [pc.cock " + x + "], fondling it with her long, smooth tongue in ways that no human could");
	output(".\n\n");
	
	output("The bovine beauty pauses her attentions, blowing hot air on your genitals as she awaits reciprocation.  For someone who just lost a fight, she sure is full of herself.  You dive down on her muff, feeling the surprisingly soft hairs above her pubic mound tickling on your chin.  The velvet folds draw back like a curtain, and you lash your tongue over them, just barely sinking the tip into her channel to taste her.  She tastes as sweet as she smells, with only a hint of tang that clings to your tongue.  For now you avoid her swollen clit – this bitch is going to have to earn whatever pleasure that big bud is going to get.\n\n");
	
	//(VAGOOZLES) 
	if(pc.hasVagina() && !pc.hasCock()) {
		output("Isabella returns to her task with gusto, muff-diving deep and hard to plant her exquisitely long tongue far inside you.  Her lips circle your [pc.clit], ");
		if(pc.clitLength >= 5) output("struggling with the cock-like appendage");
		else if(pc.clitLength >= 2) output("suckling the large button with slow, measured inhalations");
		else output("devouring the tiny bud");
		output(" even as the smooth skin of her tongue inadvertently caresses it.  You writhe against her with your juices ");
		if(pc.wetness() < 3) output("coating her tongue");
		else if(pc.wetness() < 4) output("sloppily leaking everywhere");
		else output("squirting each time she hits a particularly sensitive spot");
		output(".  Curling into a tube-like shape, Isabella's tongue begins pistoning in and out of you, fucking you as hard as any cock while still maintaining the flexibility to arch inside and press every button you've got.  You tremble from her masterful technique, bombarded with hellish levels of sensation.");
	}
	//(WANGS - fits)
	else if(pc.cockThatFits(cockVolume(38)) != -1) {
		output("Isabella resumes her task with gusto, wrapping her lips around your ");
		if(pc.hasSheath(x)) output("sheath");
		else output("base");
		output(" and suckling until her cheeks hollow from the vacuum.  Meanwhile, her tongue lashes around [pc.cock " + x + "], slurping even as it curls around your manhood.  It circles it slowly, gradually building a tight, tongue-based cocoon that squeezes even as it slides around you, throwing off hellish amounts of pleasure.");
		if(pc.cockTotal() > 1) {
			output("  She ignores your other dick");
			if(pc.cockTotal() > 2) output("s as they smear her cheeks, focusing on this one, perfectly-matched specimen.");
			else output(" as it smears her cheeks, focusing on this one, perfectly-matched specimen.");
		}
	}
	//(WANGS – no fit)
	else {
		output("Isabella resumes her task with gusto, wrapping her tongue around the ");
		if(pc.hasSheath(x)) output("sheath");
		else output("base");
		output(" numerous times before bobbing her head up and down.  She's using her tongue like some kind of onahole, and the warm, slippery pressure makes your [pc.cock " + x + "] want to melt with pleasure.  The cow-girl slides all the way to the tip");
		if(pc.hasKnot(x)) output(", struggling with the knot");
		else if(pc.cocks[x].cType == GLOBAL.TYPE_EQUINE) output(", getting stuck at the medial ring");
		else if(pc.cocks[x].cType == GLOBAL.TYPE_FELINE) output(", slowed by all the spines");
		else if(pc.cocks[x].hasFlag(GLOBAL.FLAG_NUBBY)) output(", slowed by all the nubs");
		else if(pc.cocks[x].hasFlag(GLOBAL.FLAG_FLARED)) output(", stopping under the flared head");
		else if(pc.cocks[x].hasFlag(GLOBAL.FLAG_STINGER_BASED)) output(", giggling from the 'stings' your anemone-like prick gave her");
		else output(", rubbing her mouth against your urethral bulge");
		output(" before she plants a kiss on your opening.  She tenderly kisses the cum-slit, all the while keeping her tongue-sheath securely around your member.  You tremble from her masterful technique, bombarded with hellish levels of sensation.");
	}
	output("\n\n");
	
	output("With such talent working your groin, you're scared she might get you off first – who knows what sort of revenge her clever mind would concoct while you're weakened by orgasm!  You redouble your efforts, licking over her labia, suckling her clit, and pressing your entire face against her hard enough to feel her folds part around your nose.  ");
	if(pc.hasMuzzle()) output("It gives you an idea, and you shift and close your mouth.  A moment later you plunge down, burying your muzzle deep inside the sloppy cunt.  It stretches pleasantly around you, and you feel moans vibrate through your crotch.  ");
	else output("Her clit bumps your nose, and you decide it's time to subdue Isabella once and for all.  You suck the bulb into your mouth and raise one hand.  Then, with a simultaneous blur of motion, you plunge your fist into her open gash and attack her clit with a frenzied series of licks.  You feel moans vibrate through your groin in response.  ");
	output("Thick, viscous cream fountains from under you, sliming your belly with the first few blasts before the fountains turn into milky fire-hoses.\n\n");
	
	//(Vagoo)
	if(pc.hasVagina() && !pc.hasCock()) {
		output("Even as you exult in victory, the humming pleasure-squeals of Isabella's orgasm vibrate through her lips and tongue, straight up your [pc.clit].  Orgasm hits you hard enough to knock the strength from your arms, and you collapse on top of the cow-girl, reflexively grinding your [pc.hips] into her face.  Your [pc.vagina] ripples and clenches, squeezing Isabella's tongue as if it could milk some kind of cum from it.  The mouthful of pussy you have doesn't stop you from giving voice to your climax, and as you ");
		if(pc.wetness() < 5) output("squirt");
		else output("drip");
		output(" into Isabella's mouth, she's screaming into yours with equal intensity.  It takes some time for your sweaty bodies to stop shaking with pleasure.");
	}
	//(Dick Fitzwell) 
	else if(pc.cockThatFits(cockVolume(38)) != -1) {
		output("Even as you exult in your victory, the humming pleasure-squeals from Isabella vibrate your entire [pc.cock " + x + "].  The tongue-sleeve tremors and convulses, losing cohesion as you lose control.  Seed bubbles from your tip, slathering Isabella's tongue, throat, and cheeks with the stuff before she can gulp it down.  One long swallow later, she's devoured ");
		if(pc.cumQ() >= 250) {
			output("it, but you're just warming up.  The next rope fills the cow-girl's mouth with cream, and the one after nearly chokes her.  She devours every salty drop");
			if(pc.cumQ() >= 500) output(", but you keep cumming, pumping more and more spooge inside her oral cavity with every eruption");
			if(pc.cumQ() >= 1000) output(".  She gives up after her belly fills and pulls back to let you blow the rest on her face");
			if(pc.cumQ() >= 1500) output(".  Her tan visage is coated in a generous helping of spunk when you finish");
		}
		else output("your entire load");
		output(".");
	}
	//(Dick + No fit)
	else {
		output("Even as you exult in victory, the humming pleasure-squeals of Isabella's orgasm vibrate through her lips and tongue, spreading down your shaft.  The effect is profound and immediate, and even as Isabella loses control of her oral onahole, orgasm wracks your [pc.cock " + x + "].  It trembles and pulsates a second before the first load bursts from the tip and splatters on Isabella's thin, white blouse.  The next doesn't fly as far, and drops on her neckline.  After that, you pour a few bursts onto her face.");
		if(pc.cumQ() > 250) {
			output("  Far from finished, you dump enough spooge on her chest and head to glaze them both equally");
			if(pc.cumQ() > 500) {
				if(pc.cumQ() > 1000) output(", and somehow, your orgasm drags on, creating a lake of spunky mud for Isabella to lie in");
				else output(".  Her top clings to her, revealing every curve of her chest and the many tips of her exotic nipples");
			}
			output(".");
		}
	}
	//(Extra dicks? - no new pg)
	if(pc.cockTotal() > 1) {
		output("  Throughout it all you feel like a one-man bukkake show, spurting jism from your [pc.cocksLight] over the cumming cow-girl.");
	}
	output("\n\n");
	
	output("Finally and completely sated, you roll off, ");
	if(pc.hasCock()) output("twitching as your member disentangles itself from her tongue.");
	else output("twitching weakly as your clit catches her tongue one last time.");
	output("  It takes you a moment to catch your breath, but once you do, you stand with renewed vigor and satisfaction – Isabella is delirious and panting.  You lean down to listen and she whispers, \"<i>..love you.  Lick lick lick slurp slurp cum cum! Fun fun cum cum...</i>\"  The poor girl is completely blissed out!  Hell, it sounds like she's already forgiven you for the rough treatment, just as she should.\n\n");
	output("You get dressed and leave with a smile.");
	//(slimefeed + izzy unmad!)
	processTime(20 + rand(5));
	pc.orgasm();
	pc.girlCumInMouth(isabella);
	applyPussyDrenched(pc);
	if(!isabellaFollower()) isabellaAffection(9);
	flags["COC.ISABELLA_ANGRY"] = 0;
	//pc.slimeFeed();
	if (inCombat()) {
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	}
	else addNextButton();
}

//['Too Big' Victory Titfucking Funtimes With Milk]
public function tooBigVictoryTittyFuckingFuntimesWithMilk():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.biggestCockIndex();
	output("You toss aside your [pc.gear] to reveal your [pc.cock " + x + "] to the ");
	if(enemy.lustQ() > 99) output("lusty");
	else output("weakened");
	output(" cow-girl.  Her eyes go wide as she beholds the full, revealed length, watching it ");
	if(pc.lust() > 70) output("pulsate with your raging lust");
	else output("slowly fill with blood from your growing lust");
	output(".  You stroke with each closing movement until you're standing over her and looking down the cleavage of her gratuitous bosom.  Isabella begins to pout while you explain her task to her – she's going to tit-fuck you with those tremendous tits");
	if(pc.cockThatFits(enemy.vaginalCapacity()) == -1) output(" since there's no way you'll be able to cram it in her cunt or asshole.\n\n");
	else output(".\n\n");	
	
	if(isabellaAccent()) output("The cow-girl whines, \"<i>B-but I don't vant it in mein milkers!  Your thing... it is big and gross and nasty, like a demon's!</i>\"\n\n");
	else output("The cow-girl whines, \"<i>B-but I don't want that!  Your cock... it's big and gross... and nasty, like a demon's!</i>\"\n\n");
	
	output("\"<i>");
	if(pc.cor() < 33) output("I'm sorry, but you're too hot to resist, and it's better I do this than try to force it in a hole that could never accept it,");
	else if(pc.cor() < 66) {
		output("This isn't up for discussion.  ");
		if(enemy.lustQ() > 99) output("You're so drippy that you want this anyway,");
		else output("You lost and you've got to deal with the consequences,");
	}
	else output("Tough shit,");
	output("</i>\" you answer.  To emphasize your point, you reach down to her corset and pop the laces, one at a time.  Each snapping string starts an avalanche in Isabella's massive tits, bouncing the two mountainous mounds with every sudden release of pressure.  She shudders with an expression of disgust on her face, but you can see her nipples straining her transparent top even tighter.\n\n");
	
	output("Isabella is getting off on being disrobed!  You don't stop at her corset either; every bit of clothing above her waist is pulled off and discarded, saving the silken shirt for last.  ");
	if(pc.cor() < 33) output("You take care to remove it without damaging the garment, as if respect for property will make up for slaking your lusts on her unwilling body.");
	else if(pc.cor() < 66) output("You remove the garment without much care for its condition, not damaging it too much as you wrench it free.");
	else output("You tear off the offending garment without a single care for the cow-girl's property.");
	output("  She looks up at you with teary brown eyes and asks, \"<i>Please be gentle with me");
	if(isabellaAccent()) output(", ja?");
	else output(".");
	output("</i>\"\n\n");
	
	output("Your gaze is so intently focused on the quad-tipped areolae that you barely acknowledge her request.  A slight grunt escapes your lips while you fondle your shaft, squeezing it gently with both hands.  You take a half-step forward and aim your [pc.cockHead " + x + "] between Isabella's breasts.  The first dollop of pre-cum oozes from the tip just in time to smear into the valley of cleavage, lubricating the sweaty skin even further.  Her body is hot from the recent combat, and the warm, wet embrace of the cow-girl's bosom feels absolutely heavenly as you slide home through the valley of chest.\n\n");
	
	output("Sighing blissfully, you grab hold of Isabella's breasts by the prominent nipples and pull them together, finishing the titillating encapsulation of your member.  She moans loudly at the forceful tug as she watches you violating her tits.  The [pc.cockHead " + x + "] of your [pc.cock " + x + "] bursts from between the pillowy mounds to leak on the cow-girl's chest, and the bovine beauty can only manage a dark blush in response.  You're already leaking a steady trickle of pre-cum from your crown from the hot tightness of Izzy's tits; orgasm isn't too far.\n\n");
	
	output("The cow-girl utters a pleasured moo in response to the tight nipple tension.  Holding tightly, you roll the four tips between your fingers as you slowly begin to fuck the cow-girl, ignoring the wetness that begins to squirt between them.  Isabella's hips seem to squirm of their own volation, and the cow-girl's legs spread wide to grind her skirt-girded loins against your " + pc.legs() + ".  You respond by turning your gentle thrusts into rough, pistoning motions that shake the jiggling melons violently around your [pc.cock " + x + "], but it only seems to please the milk-spurting cow.\n\n");
	
	output("Isabella grinds against you in a frenzy, thrashing wildly against your " + pc.legs() + ".  Her motions only exacerbate the tightness of the tit-sleeve milking your [pc.cock " + x + "], and as you look down at the convulsing cow-girl's blissful expression, you feel a telltale welling of pressure in your [pc.balls].  You wait for her mouth to gape particularly wide before thrusting forward, ");
	if(pc.cocks[x].cLength() < 50) output("burying the top few inches of your length into her mouth");
	else output("pushing your cock across her puckered lips and past her forehead");
	output(".  Milk splatters off your palms, spraying out in a fan that drenches the titty monster in her own cream.  You try to ignore it, but the sight before you is so utterly erotic that you know you have no chance of holding back your orgasm.\n\n");
	
	output("Your [pc.cock " + x + "] is laid out over a busty, milk-spewing cow-girl, pressing up all the way ");
	if(pc.cocks[x].cLength() < 50) output("to her mouth");
	else output("to smother her face in heavy dick-flesh");
	output(".  Meanwhile, Isabella's expression is one of unthinking, overwhelming pleasure.  Even her eyes seem unfocused and slightly crossed - she's getting off on being titty-fucked!  There's actually a growing  puddle of slippery girl-jizz deepening around your " + pc.foot() + " as it leaks from Isabella's plush-lipped pussy.");
	if(pc.balls > 0 && !pc.hasStatusEffect("Uniball")) output("  Your balls pull tight to your loins, accompanied by a burst of warmth");
	else output("  A bubble of warmth grows in your loins");
	output(", and you know there's no stopping your climax now.\n\n");
	
	output("Starting at the ");
	if(pc.hasSheath(x)) output("sheath");
	else output("base");
	output(", a distorted bulge plumps up your urethra as it presses forward, pausing at the tight valley of Isabella's cleavage before it squeezes into the sweaty breast-embrace.  You groan loud enough to drown out the cow-girl's moans of exquisite pleasure, and the next pump of cum begins its journey towards release, even before you release the first.  She ");
	if(pc.cocks[x].cLength() < 50) output("leans forward to swallow more of your cock just before");
	else output("leans back to swallow your [pc.cockHead " + x + "] and lick it, just before");
	output(" it explodes in her mouth.  ");
	if(pc.cumQ() < 25) output("A single gulp demolishes your meager output.");
	else if(pc.cumQ() < 150) output("A slight change in the shape of her cheeks is the only reaction you get to the size of your load.  A noticeable swallow empties her maw.");
	else if(pc.cumQ() < 250) output("A runnel of cum escapes from the bovine beauty's mouth while her distended cheeks slowly narrow. She audible gulps down the heavy load.");
	else output("A torrent of seed runs down her chin, but the bovine beauty gulps and swallows, trying her best to keep up.");
	output("  The next pulse is even larger than the first, and Isabella's eyes give you an unfocused but loving look while she devours your seed. Her erupting milk's consistency thickens to a heavy cream, and you gently pull her four-pointed nipples up and down while the two of you cum together.\n\n");
	
	output("Like all good things, your climax eventually ends.  As you admire your handiwork, however, you feel a happy throb from your [pc.cocksLight].  It was a truly magnificent coupling of penis and breast.  Isabella's hefty mounds still bear traces of your seed - after the first few spurts you pulled out and allowed the rest of your load to ");
	if(pc.cumQ() < 500) output("spurt on");
	else output("soak");
	output(" her breasts.  She's mooing contentedly and tugging on her teats now, squeezing the last of her cream out while you watch.  The cow-girl barely seems conscious of your presence at this point.\n\n");
	if(!isabellaFollower()) isabellaAffection(3);
	output("Shrugging, you wipe [pc.eachCock] off on her lips and get dressed.  This cow is one marvelous cum-dump.");
	processTime(20 + rand(5));
	pc.orgasm();
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[VAGINAL PROD N' POKE]
public function vaginalProdNPokeIsabella():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.cockThatFits(enemy.vaginalCapacity());
	if(x < 0) x = pc.smallestCockIndex();
	output("You smirk down at Isabella as you tell her that milk is the least of your concerns.  The ");
	if(enemy.lustQ() > 99) output("lusty");
	else output("defeated");
	output(" cow-girl pales and asks, ");
	if (isabellaAccent()) output("\"<i>But vhy not?  Mein milk is so gooood.</i>\"");
	else output("\"<i>But why not? My milk is so goood.</i>\"");
	output(" The last word emphasizes the 'o's so much that it comes out almost like a moo.  You push her legs apart and flip up her skirt to reveal the cleft of her womanhood.  She didn't even bother with panties, so there's nothing to protect her ");
	if(enemy.HP() <= 1) output("slowly-engorging");
	else output("juice-slicked");
	output(" pussy-lips.  You look up at her and comment on the state of her vagina, asking if she's sure she didn't want it this way.\n\n");
	
	if (isabellaAccent()) output("\"<i>Nein! I... I never vanted to have to fight you!  And I definitely didn't vant to vind up on my keister vith my legs spread while a handsome " + pc.mf("man","woman") + " ogles my vagina!</i>\" exclaims the cow-girl.\n\n");
	else output("\"<i>No! I... I never wanted to have to fight you!  And I definitely didn't want to wind up on my butt with my legs spread while a handsome " + pc.mf("man","woman") + " ogles my vagina!</i>\" exclaims the cow-girl.\n\n");
	
	output("You reach down to touch the skin around her loins, circling her puffy pussy-lips without actually touching any part of her moist slit.  Isabella moans out loud and spreads her softly-furred thighs apart, subconsciously welcoming your probing ministrations.  The dewy muff visibly plumps with each teasing circle your fingers make, until her vagina gradually begins to bloom like a flower; if flowers were pulsating pink tunnels of sweltering lust. Still, the spreading of her labia is an entrancing, if arousing sight.  A pudgy, fat little clit sprouts near the top and gradually swells until it reaches its full size.  Throughout it all, you deny her pussy the touch it so craves, circling a digit around the circumference of her box with constant, even strokes.\n\n");
	
	output("\"<i>Are you sure?</i>\" you ask.  Isabella bites her lip petulantly, but you brush the sensitive skin of her inner thigh and the dusky cow-girl moans, ");
	if (isabellaAccent()) output("\"<i>Fine!  I-I vant it in my pussy!  Fuck me!  Fuck mein cunt...</i>\"");
	else output("\"<i>Fine!  I-I want it in my pussy!  Fuck me!  Fuck my cunt...</i>\"");
	output(" She trails off into half-cries, half-moans in between shudders of inadvertent pleasure.  Her hips twitch at you, begging for more stimulation, more pleasure; anything to satisfy the aching need you've stoked betwixt her thighs.\n\n");
	
	output("You step back to undress. Isabella takes the opportunity to reach for her sodden snatch, but you brush her questing fingers away with your " + pc.foot() + ".  She glares at you a moment before she resumes her slutty gyrations, the need for satisfaction overwhelming her irritation at being denied.  You " + pc.mf("chuckle", "giggle") + " down at her as you pull out your [pc.cocksLight].  Wide-eyed, the red-head watches you stroke [pc.eachCock] and licks her lips.\n\n");
	
	output("Approaching with as much sensual exaggeration as possible, you lean over the busty bitch and let [pc.oneCock] prod at the dilated quim.  Isabella moos at the hint of vaginal penetration while milk begins to bead atop her nipples, soaking through the taut fabric of her chemise.  You smirk and squeeze one of the dusky tits, expressing four small squirts of milk simultaneously.  Amazingly, the creamy pulses continue even once you release the sloshing cow-teat.  You press on anyway, hilting yourself in the girl-cum-oozing tunnel with one smooth movement while the lactating woman's soaked top starts to cling to her well-endowed torso.\n\n");
	
	output("\"<i>");
	if (isabellaAccent())
	{
		if(pc.cockVolume(x) > enemy.vaginalCapacity()) output("Oh! Ze cock! It is too big for meeee!  I... am being stretched so mooo-uch!");
		else if(pc.cockVolume(x) > cockVolume(13)) output("Oh, such a nice cock you have!  It is rubbing mein pussy so good!");
		else output("Oh, what a surprise!  Ze cock, it is nice and comfortable in my pussy.  I love cute little dicks ze best!");
		output("</i>\" screams Isabella with heavily-accented, awkward words.\n\n");
	}
	else
	{
		if(pc.cockVolume(x) > enemy.vaginalCapacity()) output("Oh! The cock! It's too big for me!  It's... stretching me so mooo-uch!");
		else if(pc.cockVolume(x) > cockVolume(13)) output("Oh, such a nice cock you have!  It's rubbing my pussy so well!");
		else output("Oh, what a surprise!  Your cock is nice and comfortable in my pussy.  I love cute little dicks the best!");
		output("</i>\" screams Isabella with lightly-accented, awkward words.\n\n");
	}
	
	
	output("You smirk and slap at one of the cow-girl's breasts in response, setting off a geyser of lactic fluid that rains down on both of you.  Now that Isabella's tits have started to let down her milk, there's no stopping the alabaster flow.  Her spray of lactation covers her, you, and her belongings, unfettered by the sopping-wet shirt plastered tightly to her chocolate-toned mounds.  You lick a few droplets from your lips and marvel at the sweetness.  She's absolutely delicious.\n\n");
	
	output("In spite of the distracting milk-fountains, your main focus remains on her cunt, and how wonderful that hot little box feels around your [pc.cock " + x + "].  ");
	if(pc.totalCocks() > 1) {
		output("You wish you had room for ");
		if(pc.totalCocks() > 2) output("another [pc.oneCock]");
		else output("your other penis");
		output(" inside her, but her arousal-slicked lips are squeezing too tightly on you for you to cram anything else into that hole, and at this angle, anal sex would be nigh impossible.  ");
	}
	output("Isabella's cunt squelches wetly every time her hips rock against you, bubbling and frothing her copious fem-cum while her prominent love-button bumps into your loins at the apex of each motion.  You return the favor, grunting and hilting yourself harder and harder, spurred on by half-understood male instincts that drive you to bury every inch of your cock into her squishy honeypot.\n\n");
	
	output("A spurt of cow-cream catches you in the eye.  Thankfully it doesn't sting; you blink the offending fluid away and glare down at your conquest for a moment before deciding to take matters into your own hands.  Reaching down to the cow's heaving bosom, you grab her multifaceted nipples in your hands and pinch hard, shutting down the flow of milk with intense pressure.  Isabella throws back her head and cums instantly from the powerful stimulation, but as she begins to thrash underneath you, your grip locks around her teats in spite of the milk hammering against you, trying to squirt out.  You can actually hear her tits sloshing with every second that passes, growing larger and larger in your hands.\n\n");
	
	output("Her legs wrap around you and squeeze so tightly ");
	if(pc.physique() > 40) output("that they'd damage a lesser person");
	else if(pc.physique() > 25) output("that it actually hurts");
	else output("that you worry she'll crush your pelvis");
	output(".  Your [pc.cock " + x + "] is wrung with equal tightness, nearly crushed inside Isabella's muscular pussy as her blissfully hot cunt convulses wildly.  The painful tightness is unpleasant, but at the same time your dick feels harder than ever.  Rippling, muscular contractions pull on your dick repeatedly, milking your poor member as if it were simple livestock, and you give in to the powerful pulses after only a few moments, throwing your head back and ramming yourself into her with all your strength.\n\n");
	
	output("Cum bubbles up [pc.eachCock], robbing you of your tension. As you lose your grip on the cow-woman's nipples, milk erupts from the dark-skinned teats in a torrential outpouring of white fluid.  It rains over you in heavy drops, and at least one such drop manages to land in your mouth.  It's thick and sweet as candy, a heavenly cream that makes your head swim with its flavor while your whole body clenches in orgasmic bliss.  Your release is stymied by the tightly contracting velvet sheath, and the waves of jism stop up inside you, almost painfully, before she finally relaxes and allows you to fill her with one long, hip-humping ejaculation.");
	if(pc.cumQ() >= 1000) {
		if(pc.cumQ() < 1500) output("  Isabella's belly pudges out from all the semen in her womb by the time you finish; visible proof of your fertility.");
		else if(pc.cumQ() < 2500) output("  Isabella's belly distends massively by the time you finish, showing visible proof of your obscene fertility.");
		else output("  Isabella's massively distended belly and cum-squirting cunt are all the proof of your fertility you would ever need.");
		if(pc.cumQ() >= 1500) output("  The huge puddle you leave behind is a nice bonus though.");
	}
	output("  You pull out with a happy sigh, barely noticing how completely covered in Isabella's creamy milk you are.  Glancing back at her, you note her glazed expression and still-dripping nipples.  She still wears a dopey grin, and you doubt she'll get too mad about this once she remembers how good she felt.  You toss on your [pc.gear] and stop at the lake to clean up on your way back, though for most of the trip you're busy licking up her tasty milk-deposits.\n\n");
	//Reset anger
	processTime(25 + rand(5));
	flags["COC.ISABELLA_ANGRY"] = 0;
	if(!isabellaFollower()) isabellaAffection(7);
	pc.orgasm();
	applyPussyDrenched(pc);
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[Small dick tit-fucking] (Dicks less than 9 inches)
public function tinyVictoryTittyFuckingFuntimesWithMilk():void {
	isabellaSprite();
	clearOutput();
	var x:Number = pc.smallestCockIndex();
	output("You toss aside your [pc.gear] to reveal your [pc.cock " + x + "] to the ");
	if(enemy.lustQ() > 99) output("lusty");
	else output("weakened");
	output(" cow-girl.  She squeals in delight at the sight of your [pc.multiCocks]");
	if(pc.cockTotal() > 1) output(", singling the smallest one out for some reason");
	if (isabellaAccent()) output(".  \"<i>Is zat vant you vanted from me?  Oooh baby, you could have just asked!  Mamma Isabella loves sucking on cute little penises like yours, particularly ones like zat little guy, right zere.</i>\"\n\n");
	else output(".  \"<i>Is that what you wanted from me?  Oooh baby, you could have just asked!  Momma Isabella loves sucking on cute little dicks like yours, particularly ones like that little guy, right there.</i>\"\n\n");
	
	output("The cow-girl grabs hold of your [pc.cock " + x + "] for emphasis and begins to stroke it enthusiastically.  Having her large (but still feminine) hand wrapped around you makes your dick look positively tiny in comparison, ");
	if(pc.cor() < 33) output("bringing a shameful blush to your cheeks");
	else if(pc.cor() < 66) output("bringing a tiny blush to your cheeks");
	else output("but you aren't really bothered by it in the slightest");
	output(".  You clear your throat and try to regain control of the situation by demanding that she service you with her breasts.  Isabella happily accedes, even going so far as to clap excitedly as she sheds her top.  She seems to genuinely relish the idea, to a degree that makes her forget ");
	if(enemy.lustQ() > 99) output("her own needs.");
	else output("her wounds.");
	output("\n\n");
	
	output("Pulling herself up to lean against your groin, Isabella holds her hefty breasts in her hands and presses them around your [pc.cock " + x + "].  The squishy-soft mammaries utterly envelops your penis in their warm, sweat-lubricated embrace");
	if(pc.cockTotal() > 1) {
		output(", but she completely ignores the other one");
		if(pc.cockTotal() > 2) output("s");
	}
	output(".  Isabella smirks up at you as she begins to jiggle her boobs back and forth while saying,");
	if (isabellaAccent()) output(" \"<i>Does your cute little cock like zis?  Ooooh, I zink it does.  It vants to squirt into my cleavage like a good little dick, ja?</i>\"");
	else output(" \"<i>Does your cute little cock like this?  Ooooh, I think it does.  It wants to squirt into my cleavage like a good little dick doesn't it?</i>\"");
	output(" You start to nod before you catch yourself and arrest the motion.  You're the one in control, not her!\n\n");
	
	output("Isabella doesn't even seem to notice your conflict, as she's become utterly transfixed by the feeling of your [pc.cock " + x + "] pulsing inside her tits, drooling pre-cum obediently as if trying to make her words a reality.  You slowly slump down to the ground and begin to pant weakly, allowing Isabella to utterly dominate your tiny dick with her tits.  Sweat and beads of milk drip from her nipples as she works, and you begin to smell the scent of her arousal growing ever more pungent in the air.\n\n");
	
	output("Your whole body starts to blush before long, your tiny cock unable to cope with the teasing cow-girl's ministrations.  She looks you in the eye and begins to bob her whole body up and down, shaking her tits while she asks,");
	if (isabellaAccent()) output(" \"<i>Are you going to cum for me soon?  I vant zat tiny cock to spurt all its meek little cum over my breasts until it's limp.  Isn't zat vat you want?</i>\"");
	else output(" \"<i>Are you going to cum for me soon?  I want that tiny cock to spurt all of your meek little load of cum over my breasts until it's limp.  Isn't that what you want?</i>\"");
	output(" Her sultry teases arouse you past the tipping point, and you feel your cock begin to release ");
	if(pc.cumQ() < 50) output("its pathetic little load");
	else if(pc.cumQ() < 250) output("a nice gooey load");
	else if(pc.cumQ() < 500) output("its hefty, tit-drenching load");
	else output("its massive, body-soaking load");
	output(" into Isabella's cleavage.");
	if(pc.cumQ() >= 1000) output("  It pumps and pumps, blotting out her chest and face, turning her expression to one of ecstatic shock.");
	if (isabellaAccent()) output(" \"<i>Oh my!  Such an obedient little cock!  Zat's right; cover me vis your seed, my adorable little weenie!</i>\"");
	else output(" \"<i>Oh my!  Such an obedient little cock!  That's right; cover me with your seed, my adorable little dick!</i>\"");
	output("  You shake and squirm against her, your body going weak with every pump of seed until you fall flat on your back and spurt the last of your cum onto your belly.\n\n");
	
	output("Isabella dutifully cleans you with her tongue before delving back into her chest and beginning to scoop the seed from her milk-dripping tits.  You watch her for a time until you feel recovered, then get dressed and depart, wobbling unsteadily on your " + pc.legs() + ".  Isabella's noisy swallows are followed by a catcall.");
	if (isabellaAccent()) output("  \"<i>Come back soon!  You have ze tastiest little dick and I vant to play with it more, ja?</i>\"");
	else output("  \"<i>Come back soon!  You have the tastiest little dick and I want to play with it more!</i>\"");
	processTime(15 + rand(5));
	//Reset anger
	if(!isabellaFollower()) isabellaAffection(8);
	flags["COC.ISABELLA_ANGRY"] = 0;
	pc.orgasm();
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[Discuss Isabella]
public function talkWithIsabella():void {
	isabellaSprite();
	clearOutput();
	IncrementFlag("COC.ISABELLA_TIMES_TALKED");
	if(flags["COC.ISABELLA_TIMES_TALKED"] == 1) {
		output("You tell Isabella your own tale before asking if she'd share how she came to be in her present situation. The normally feisty red-head sighs and responds, \"<i>Yes, it is only fair I suppose.</i>\"\n\n");
		output("She clears her throat nervously before she begins, \"<i>I vas an adventurer in mein homeland. I vould roam the vilds vith nothing but mein shield, mein skills, and mein viits to back me up. It vas vunderbar. I had amassed a small fortune between doing mercenary vork and dungeoneering, but one day I delved too deep. There was a fluttering pink portal, and with the thought of riches filling mein noggin, I stepped through.</i>\"\n\n");
		output("Isabella looks at you with tears welling in her eyes. \"<i>The portal vouldn't let me back through. I got stuck here, away from mein friends and family, vith nothing but sex-perverts for company. Zankfully, most of zem couldn't handle mein shield.</i>\"\n\n");
		output("You look at her curiously, asking if she was always so... bovine in appearance. She smirks and replies, \"<i>I suppose I had zat one coming. Still, I vas not always as you see. Some of ze foes I defeated dropped some potions. And... ze bova ones were sooo delicious. I couldn't help meinself. I even mixed a few different kinds together to see vhat vould happen. It made mein m-m-milk so strange und sweet.</i>\"\n\n");
		output("Isabella brightens as she continues, \"<i>But I've made a nice little home here, and from time to time, I do manage to make some friends.</i>\"\n\n");
		output("The busty cow-girl leans forward to crush you in a tight hug, squeezing you against her tits before informing you she's got some work to do around her camp. You nod and leave.\n\n");
		if(!isabellaFollower()) isabellaAffection(10);
	}
	//[Discuss Isabella Repeat]
	else {
		output("You sit down with Isabella and share tales of your recent adventures.  While the companionship is nice, after an hour or so of discussion you decide to go your separate ways.");
		if(!isabellaFollower()) isabellaAffection(2);
	}
	processTime(50 + rand(20));
	addNextButton();
}