import classes.Characters.CoC.CoCSandMother;
import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Resources.StatusIcons;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;


//Sand Mother
//*Notes:
//8'3" tall.
//Dark Tan, almost white-bleached hair.
//Sky blue eyes
//Four gigantic breasts that nearly obscure her belly button.
//Amused the PC made it to her, but Angry.
//Uses a scepter as a weapon
//*Encounter:

private function sandWitchMotherShow():void {
	if (enemy == null || !(enemy is CoCSandMother)) {
		setEnemy(new CoCSandMother());
	}
	userInterface.showName("SAND\nMOTHER");
}

private function sandWitchMotherPrepare():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCSandMother());
	CombatManager.victoryScene(defeatTheSandMother);
	CombatManager.lossScene(loseToTheSandMother);
	CombatManager.displayLocation("SAND\nMOTHER");
}

public function sandWitchMotherFriendlyMenu():void {	
	clearMenu();
	if (flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] != 1) addButton(0, "StopAttacking", leaveAloneSendLackeysToggle, null, "Talk: Stop Attacking", "You've had enough with the Sand Witches. They should leave you alone.");
	else addButton(0, "StartAttacking", leaveAloneSendLackeysToggle, null, "Talk: Start Attacking", "Tell the Sand Mother that you want to encounter the Sand Witches again.");
	addButton(1, "SandMothers", askHowSandMothersAreChosen, null, "Talk: Sand Mothers", "Ask the Sand Mother about how she's chosen.");
	addButton(2, "Cum Witches", discussCumWitches, null, "Talk: Cum Witches", "Ask the Sand Mother about the Cum Witches.");
	addButton(3, "CovenStatus", currentStateOfInterwebs, null, "Talk: Coven Status", "Ask the Sand Mother about the status of the coven.");
	addButton(4, "History", sandWitchHistory, null, "Talk: History", "Ask the Sand Mother about the history of the Sand Witches.");
	//if(flags["COC.SAND_WITCH_LOOT_TAKEN"] < 5) {
		//addButton(5, "Get LaBova", getLaBova, null, null, null, consumables.LABOVA_.description);
		//addButton(6, "Get Lactaid", getLactaidFromWitches, null, null, null, consumables.LACTAID.description);
	//}
	if((flags["COC.ESSY_MET_IN_DUNGEON"] > 0 && flags["COC.TOLD_MOTHER_TO_RELEASE_ESSY"] != 1) /*|| (flags["COC.MET_MILK_SLAVE"] > 0 && flags["COC.MILK_NAME"] == undefined)*/)
		addButton(7, "Free Slaves", slavesDiscussion, null, "Free Slaves", "Request the Sand Mother to release a slave.");
	if (pc.lust() >= 33) addButton(8, "Sex", sexWithFriendlySandMother, null, "Sex", "Have some sexy time with the Sand Mother.");
	
	addButton(14, "Leave", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}

public function slavesDiscussion():void {
	clearMenu();
	if (flags["COC.ESSY_MET_IN_DUNGEON"] > 0 && flags["COC.TOLD_MOTHER_TO_RELEASE_ESSY"] != 1) 
		addButton(0, "Essrayle", askMotherToReleaseEssy, null, "Essrayle", "Request the Sand Mother to release Essrayle.");
	//if(flags[kFLAGS.MET_MILK_SLAVE] > 0 && flags[kFLAGS.MILK_NAME] is Number) addButton(1,"Milk-Slave",freeSlaves, null, null, null, "Request the Sand Mother to release the milk slave you've found in the bathroom.");
	addButton(14, "Back", sandWitchMotherFriendlyMenu);
}

//Getting a Milk Slut, Purity Style
//{Having beat the Sammiches, and made Momma Witch your friend, add a button labeled [Free Slaves] to Momma's menu. Needs to have met Milk Slut.}
//private function freeSlaves():void {
	//clearOutput();
	//output("Thinking back to the poor, mind-broken tittymonster of a bath girl you met here in the witches' coven, you tell the Sand Mother it's about time to free her and any other slaves she's got hidden away.");
//
	//output("\n\nThe Sand Mother cocks an eyebrow at you, and makes a rather haughty scoff from atop her throne.  \"<i>You may have beaten my guardians, but what makes you think you can just order something like that, outsider?  The slaves are vital to the workings of the coven; we can't simply </i>release<i> them.</i>\"");
//
	//if(pc.inte <= 20) {
		//output("\n\nYou start to respond, stop, and have to think for a moment.  You spend a good long minute contemplating, before shrugging.  You're sure there's a convincing argument against this, but can't think of it at the moment.");
		////[Back to menu
		//doNext(mainGameMenu);
		//return;
	//}
	//// Else:
	//output("\n\nYou shake your head. The witches claim to be opposed to the demons, yet what do they do?  They attack travelers who don't submit, enslave those who resist, and Marae knows what else.  This cannot stand.  The Sand Mother's no better than the demons if she's a slaver, keeping people like the poor milk girl as little more than cattle.");
//
	//output("\n\nThe Sand Mother scowls, and rises from her throne.  \"<i>Come with me,</i>\" she says, ushering you from the room and through the many corridors of her subterranean haven.  Eventually, she brings you to the bath chamber.  Huddled in the corner is the huge-breasted girl, dozing lightly until the elder witch clears her throat.  In an instant, the girl's up and crawling meekly over, hands supporting her massive teats as she mewls, \"<i>Bath time, Mistress?</i>\"");
//
	//output("\n\n\"<i>No, girl,</i>\" the witch says, eliciting a confused look from the slave girl.  \"<i>Why don't you tell your friend here just how much you want to be free, girl. Use your words.</i>\"");
//
	//output("\n\n\"<i>M-mistress?</i>\" the slave girl says, head cocked to the side.  \"<i>I...</i>\" she whines, visibly struggling to form a few simple words before giving up and repeating her milky mantra: \"<i>Bath time?</i>\"");
//
	//output("\n\nThe Sand Mother shakes her head and turns back to you.  \"<i>She's addled, [pc.name].  Even if I were to let her go, she'd just be snatched up by the demons or some wandering pervert.  Gods know there's no shortage of either.  Releasing her into the wilds is more cruel than keeping her penned, where at least she's cared for - and useful, too.  She fulfils a function amongst us, dear [pc.name], and for that she is honored and tended to.  All her needs are met, and she wants for nothing.  Can you in good conscious demand her release, dooming her to rape and torment and corruption?</i>\"");
//
	////[Yes] [No] [Gimme her]
	//menu();
	//addButton(0,"Yes",yesDemandMilkRelease);
	//addButton(1,"No",noDemandMilkRelease);
	//addButton(2,"Gimme Her",gimmeDatDeliciousMilkWaifuINeedMoreWaifusCauseTheTwoCowslutsWerentEnoughForMyInsatiableLacticLustandDesire, null, null, null, "Ask the Sand Mother if she's willing hand over the milk slave to you.");
//}

//Yes (No Change)
//private function yesDemandMilkRelease():void {
	//clearOutput();
	//output("You tell the Sand Mother that everyone deserves freedom, even if they're addle-minded, or useful.  She can't just <i>keep people</i> because she feels like they're better off in her care.");
	//output("\n\nShe sighs, shaking her head sadly as she starts back toward the throne room.  \"<i>You're a bleeding heart idealist, [pc.name].  You'd condemn the girl to torment for the sake of your petty morality.  There's no room for sentimentality these days.  Every soul I keep from becoming a demon, even if I keep them in chains, is on my conscious.  Yet I bear that weight gladly, [pc.name].  Perhaps one day, when you're ready to take on that same responsibility, you'll understand.</i>\"");
	////[PC is left in Milk Room]
	//kGAMECLASS.dungeonLoc = 33;
	//doNext(mainGameMenu);
//}

//No (No Change)
//private function noDemandMilkRelease():void {
	//clearOutput();
	//output("You suppose not, when she puts it that way.  The poor girl's probably better off here than in the clutches of the demons.  Seeing you relent, the Sand Mother smiles and pats your shoulder.  \"<i>I'm glad you can see things my way, [pc.name].  There is wisdom in you.  Come, let us speak of other things,</i>\" she says, leading you back to her throne room.");
	//doNext(mainGameMenu);
//}

//Gimme her (Gimme dat delicious milk slut)
//private function gimmeDatDeliciousMilkWaifuINeedMoreWaifusCauseTheTwoCowslutsWerentEnoughForMyInsatiableLacticLustandDesire():void {
	//clearOutput();
	//output("You have a better idea: give the girl to you.  You can care for and protect her in your camp, but also give her at least as much freedom as is safe in these dire times.");
//
	//output("\n\nThe Sand Mother sighs, shaking her head sadly.  \"<i>You're an idealist, [pc.name].  But there is wisdom in your words.  Perhaps...  perhaps you are correct.  However, she is quite useful to our coven.  Perhaps I could be persuaded to part with her, if certain recompense was made.  Two thousand gems should be sufficient.</i>\"  The sorceress looks at you, awaiting your answer.");
//
	//if(pc.gems < 2000) {
		//output("\n\n<b>You haven't got that much.</b>");
	//}
	//menu();
	////[2 Expensive][Buy Her]
	//addButton(0,"2 Expensive",TwoExpensive4Me, null, null, null, "She's too expensive! Turn down the offer.", "Too Expensive");
	//if(pc.gems >= 2000) addButton(1,"Buy Her",BuyHer, null, null, null, "Buy the Milk Slave for 2000 gems?");
//}

//private function TwoExpensive4Me():void {
	//clearOutput();
	//output("You explain that you can't afford that much.");
	//output("\n\nThe Sand Mother shrugs and says, \"<i>Then ask after her when you do.</i>\"  She doesn't stick around long enough for you to reply, leaving you standing there with the milk girl.");
	//output("\n\n\"<i>Bath time?</i>\"");
	//kGAMECLASS.dungeonLoc = 33;
	//doNext(mainGameMenu);
//}

//private function BuyHer():void {
	//clearOutput();
	//pc.gems -= 2000;
	//output("You hand over two thousand of your hard-earned gems.");
//
	//output("\n\nThe Sand Mother quips, \"<i>Very well, take the girl.  Give her freedom, and keep her safe.  She has more than earned a life of ease after years of faithful service.  The others we keep...  there is a city not far from here.  I will deliver my other servants there in the night.  Perhaps they will find solace in the arms of the last free city in Mareth.</i>\"");
//
	//output("\n\n\"<i>Mistress?</i>\" the milk girl says, looking between you and the Sand Mother.");
//
	//output("\n\nSmiling beatifically, the Mother kneels down and pats the slave's cheek.  \"<i>You're free now, daughter.  [pc.name] will take you from here, to someplace where you can be free and safe.  Do you understand, darling?  I'm no longer your mistress.</i>\"");
//
	//output("\n\nA confused moment later, the idea seems to dawn on her milk-addled mind.  The slave girl turns to you, trying desperately to stand under the weight of her gigantic udders.  \"<i>[Master]?</i>\"");
//
	//output("\n\n\"<i>No, no,</i>\" you say, moving to support her tremendous teats' weight, \"<i>Not [master], [pc.name].  Understand?  I'm [pc.name].</i>\"");
//
	//output("\n\n\"<i>[pc.name]!</i>\" she echoes with childish glee, finally able to stand upright with your aid.");
//
	//output("\n\nOpening the chamber's door for you, the Sand Mother adds, \"<i>I will send a few of my daughters to your camp with her... trappings.  You'll need to milk her frequently, and that deluge of lactation must go somewhere; a big bowl, if you like.  If nothing else, your camp and any other followers you accrue will never lack for milk.</i>\"");
//
	//output("\n\nYou thank the Sand Mother for her understanding, and the kindness she's shown your milky friend.  She nods, a wry smile on her dusky lips as you steady the milkmaid, helping her out of the room she's called home for gods know how long, and out into the desert sands - to camp.  To her new home.");
//
	////[Next] (To Arriving At Camp)
	//menu();
	//addButton(0,"Next",kGAMECLASS.milkWaifu.arriveWithLacticWaifuAtCamp);
//}

public function sexWithFriendlySandMother():void {
	clearMenu();
	//friendly cunt fuck:
	if (pc.hasVagina() && pc.lust() >= 33) addButton(0, "GetMilkFill", lesboMilkFilling, null, "Get Milk Fill", "Get into female sex with the Sand Mother and get your vagina stuffed with milk!");
	//dick fucking, must fit!
	if(pc.hasCock() && pc.lust() >= 33) {
		if (pc.cockThatFits(enemy.vaginalCapacity()) >= 0) addButton(1, "Fuck Her", friendlySandMotherFuck, null, "Fuck Her", "Fuck the Sand Mother's cunt with your penis.");
	}
	addButton(4,"Back",sandWitchMotherFriendlyMenu);
}


public function sandMotherPOMenu():void {
	clearMenu();
	//toggle withc attacking
	if (flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] == 0) addButton(0, "StopAttacking", unfriendlyWitchToggle, null, "Talk: Stop Attacking", "You've had enough with the Sand Witches. They should leave you alone.");
	else addButton(0, "StartAttacking", unfriendlyWitchToggle, null, "Talk: Start Attacking", "Tell the Sand Mother that you want to encounter the Sand Witches again.");
	if(pc.lust() >= 33) {
		if (pc.hasVagina()) addButton(1, "Scissor", scissorAndDrink, null, "Scissor", "Get into some female-on-female action and drink some milk.");
		if (pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 5) addButton(2, "TentacleBang", tentacleGangBang, null, "Tentacle Bang", "Fuck the Sand Mother with your tentacle cocks.");
		if(pc.hasCock()) {
			if (pc.cockThatFits(enemy.vaginalCapacity()) >= 0) addButton(3, "Fuck Her", fuckTheSandMothersCunt, "Fuck the Sand Mother's cunt with your cock.");
		}
	}
	//if(flags[kFLAGS.SAND_WITCH_LOOT_TAKEN] < 5) {
		//addButton(5,"Get LaBova",takeLaBovaOrLactaid, false, null, null, consumables.LABOVA_.description);
		//addButton(6,"Get Lactaid",takeLaBovaOrLactaid, true, null, null, consumables.LACTAID.description);
	//}
	//if(flags[kFLAGS.ESSY_MET_IN_DUNGEON] > 0 && flags[kFLAGS.TOLD_MOTHER_TO_RELEASE_ESSY] == 0) addButton(7,"Essrayle",kGAMECLASS.forest.essrayle.askMotherToReleaseEssy, null, null, null, "Request the Sand Mother to release Essrayle.");
	//addButton(14,"Leave",mainGameMenu);
}



public function sandMotherStuffGOA():void {
	sandWitchMotherShow();
	clearOutput();
	//*Encounter Repeat: Friendly:
	if(flags["COC.SAND_WITCHES_FRIENDLY"] > 0) {
		output("The Sand Mother slightly inclines her head in your direction as you enter her throne room.  She is every bit as imposing as you recall, or at least as imposing as a woman with four watermelon-sized jugs on her chest can be.  \"<i>You have returned to us, far traveler.  Is there something you desire from the coven of the sands?  Simply ask for what you need, and we shall aid you against the demon Queen.</i>\"  The lactation-obsessed arch-enchantress idly pushes a whitish-blonde curl out of her eyes as she awaits your reply.");
		//Display Friendly Choices
		sandWitchMotherFriendlyMenu();
		return;
	}
	//*Encounter Repeat: Cowed
	else if(flags["COC.SAND_WITCHES_COWED"] > 0) {
		output("The Sand Mother glares down at you from atop her throne, but does not dare lift a finger against you, not after her previous defeat.  She hisses, \"<i>You've already plundered my coven!  What more do you want from us?</i>\"  even as her chest heaves in a panic.  Four mountainous peaks jut from the witch's silken robe... you have a few ideas, and the Queen Witch seems to have some of her own.");
		//Resisting Options
		output("\n\nThe Sand Mother cringes back in her throne, eyeing you warily.  It appears you've made an enemy, however, at least it is an enemy that fears you.  There's a chest full of potions of La Bova and Lactaid behind her throne");
		if(flags["COC.SAND_WITCH_LOOT_TAKEN"] >= 5) output(", though right now it sits empty.  You'll need to wait for them to restock it");
		else output(", and noone could stop you from taking them");
		output(".");
		sandMotherPOMenu();
	}
	//Encounter Repeat: Undecided
	//The Sand Mother gazes at you uncertainly as you return, her defeat at your hands still fresh in her memory.  The bleach-blond matriarch looks to have recovered from the fight, but she lamely queries, \"<i>Well, you've proven yourself mightier than my magic.  All that remains is a choice.  Do you show your true colors, pawn of demons, or do you tread the path of virtue?</i>\"  Sure, she puts on a brave face, but the nervous tics at the taut corners of her mouth reveal her worry. 
	else {
		output("Reclining atop an intricately carved throne is what can only be described as the Queen Sand Witch.  The imposing, statue-esque woman must be over eight feet tall when standing, with a quartette of watermelon-sized tits and proud, three-inch long nipples that clearly show through her fine, silken robe.  Platinum blonde tresses hang down to her shoulders, so bleached they're nearly white.  She glares down at you imperiously with unusual, glowing eyes.  Her irises are solid white and luminant, leaving only the black of her pupils to eye you with.  She inquires, \"<i>So, you are the one to get my girls' skirts in a bunch.</i>\"");
	
		output("\n\nThe Witch Queen steeples her fingers and considers you above them.  \"<i>Well, what brings on your intrusion of my coven?  ");
		if(pc.cor() >= 66) output("You stink of corruption, but I still sense a soul within you.  You are not a demon... yet.");
		else output("You do not stink of corruption over-much, like many in this land, but that does not mean you are not an agent of the Lethice's.");
		output("  Explain your actions, heathen, or be scourged from this chamber like one of Lethice's demons.</i>\"");
		
		output("\n\nThis woman... she seems poised to attack.  You had best choose your actions carefully.  Do you simply explain your situation?  Do you just fight her and explain later?");
		
		//[Explain] [Fight]
		clearMenu();
		addButton(0, "Explain", explainYourSelfToZeSandBitch, null, "Explain", "Try to explain the Sand Mother that you're not a demon.");
		addButton(1, "Fight", fightTheSandWitch, null, "Fight", "Fuck this. Fight the Sand Mother!");
	}
}

//*Explain to Sand Mother
public function explainYourSelfToZeSandBitch():void {
	clearOutput();
	output("You explain that you came here through a portal from a place called Ingnam, sent as a champion to defend your land from the demons.  Recounting your travels and experiences here, you confidently explain your discovery of this coven, and your misconceptions about the sand witches.  They seemed as lust crazed as the rest of the lands, and you had assumed them to be in league with the demons you found so frequently.");
	
	output("\n\nThe Queen Witch listens with rapt attention to your tale, but when you finish, all she does is close her eyes, seemingly lost in thought.  You pause, awaiting her reply.  Seconds tick by, then merge into minutes.  You idly tap your [pc.foot].  Will she ever get done mulling over your words?");
	
	output("\n\nSuddenly, the Queen jerks up, looking you in the eye with her strange, white-irised gaze.");
	//(No new PG.  Corrupt version)
	if(pc.cor() > pc.IQ() || isBeyondMoralHorizon()) {
		output("  \"<i>There is some truth to your tale, [pc.name], but I am a Sand Mother.  We are schooled in the art of sussing out the corrupt or unclean.  If we could not detect disguised demons and demonic agents, we would not flourish as we do now, and this great desert would not be on the cusp of resurrection.</i>\"");
		output("\n\nThe Sand Mother steps out of her throne, brandishing a shining scepter as she rises.  Her lips curve into a cruel smile and she challenges, \"<i>Fight me, [pc.name], and fall like every demonic agent before you.  Do not fear, for when you lose, you shall be reborn to serve a just cause.  Your taint may yet be exorcised.</i>\"");
		output("\n\nThere's no way out, it's a fight!");
		//(start combat)
		sandWitchMotherPrepare();
		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
	}
	//(No new PG. Corruption is less than intellect and no major asshole moves made:) 
	else {
		output("  \"<i>Your tale has the ring of truth to it, [pc.name].  I am the Sand Mother of this coven, and it seems we are not enemies after all.  If you like I can instruct my daughters to let you pass through the sands unhindered.</i>\"  She spreads her arms graciously and asks, \"<i>Was there anything you would like to discuss?  It has been an age since I've had a new arrival to converse with.</i>\"");
		//(Award XP)
		//pc.XP += 200;
		//dynStats("lust", 0, "resisted", false); //Forces up arrow.
		//xpUp.visible = true;
		//statScreenRefresh();
		//(Set friendly)
		flags["COC.SAND_WITCHES_FRIENDLY"] = 1;
		//Options: Turn off Sand Witches, Turn on Sand Witches, Fuck (if PC is male or fem), Discuss history, Discuss Coven's Current State
		//friendly menu!
		sandWitchMotherFriendlyMenu();
	}
}

//*Fight
public function fightTheSandWitch():void {
	clearOutput();
	output("You [pc.readyWeapon] and advance threateningly.  The Sand Witch Queen slowly rises, pulling a scepter from beneath her robes with a resolute look in her eyes.  \"<i>You shall regret this action for a time, until we've corrected your diseased way of thinking.  Now, taste the power of a Sand Mother!</i>\"");
	sandWitchMotherPrepare();
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//*Defeat the Sand Mother
public function defeatTheSandMother():void {
	clearOutput();
	flags["COC.SAND_MOTHER_DEFEATED"] = 1;
	output("Panting ");
	if(pc.HP() <= 1) output("in exhaustion");
	else output("with lust");
	output(", the Sand Mother sinks back into her throne with sweat and milk staining her silky robes.  She groans softly, the milk-stains slowly spreading as you consider your options.  This woman dared to stand against you.  What do you do?");
	//[Fuck Her Cunt] [ScissorAnDrink] [Talk Her Down]
	clearMenu();
	addButton(0, "TalkHerDown", talkDownTheMother, null, "Talk Her Down", "Talk the Sand Mother down. Convince her that you're not a demon.");
	if (pc.hasVagina()) addButton(1, "Scissor", scissorAndDrink, null, "Scissor", "Get into female sex and drink your fill.");
	if (pc.hasCock() && pc.cockThatFits(enemy.vaginalCapacity()) >= 0) addButton(2, "Fuck Her", fuckTheSandMothersCunt, null, "Fuck Her", "Fuck the Sand Mother's cunt with your cock.");
	if (pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 5) addButton(3, "TentacleFuck", tentacleGangBang, null, "Tentacle Fuck", "Fuck the Sand Mother with your tentacle cocks.");
}

public function loseToTheSandMother():void {
	clearOutput();
	//DUDALICIOUS
	if(pc.hasCock()) loseToSandMotherBadEnd();
	//Chicks/neuters
	else loseToSandMother();
}


//Talk Her Down
public function talkDownTheMother():void {
	clearOutput();
	output("Calmly, you approach the Sand Mother's throne, saying, \"<i>I am no demon, witch.  I am [pc.name], and I am ");
	if(pc.cor() < 33) output("a champion");
	else if(pc.cor() < 66) output("beholden to no-one");
	else output("unstoppable");
	output(".  No demon's yoke holds me.</i>\"  You grab her by her shoulders with firm but gentle pressure to drill the point home, looking into her sky blue eyes as you make your proclamations of innocence.  The Queen Witch nods dumbly and visibly calms, though she remains shaken from the recent combat.  Hesitantly, she nods at you and smooths her robes, slowly reasserting her dominant, royal persona.");
	
	output("\n\n\"<i>Very well.  You are either not a demon agent or the most clever spy this side of Marae's Lake,</i>\" the regal enchantress admits, quietly fixing her hair.  \"<i>Either way, it seems I have no choice but to take you at your word until your actions prove otherwise.</i>\"  She finishes with her hair and idly folds her hands across her lap, which only serves to strain her silken robe tighter around her double-bust.");
	
	output("\n\n\"<i>Is there something you would like to discuss, or aid you would request?  It has been a great deal of time since I have had the pleasure of discourse with an outsider.</i>\"\n\n");
	//pc.XP += 200;
	//mainView.statsView.showStatUp( 'xp' );
	// xpUp.visible = true;
	//statScreenRefresh();
	//(Set friendly)
	flags["COC.SAND_WITCHES_FRIENDLY"] = 1;
	
	processTime(3 + rand(3));
	CombatManager.genericVictory();	
	//sandWitchMotherFriendlyMenu();
}
//*Tentacle Gangbang
public function tentacleGangBang():void {
	clearOutput();
	//>Requires 5+ tentacles.  Every hole is plowed.
	output("Grinning, you discard your [pc.gear] with glee, releasing your wriggling bunch of genital appendages to wave in the air, slithering over each other's spongy, sweat and pre slicked skin.  They wave in the air menacingly, an orgy of glistening green cocks just waiting to be let loose upon the formidable female flesh before you.  Fearfully, the Sand Mother pushes herself against the wall, stammering, \"<i>No... ");
	if(flags["COC.TIMES_TENTACLED_SAND_MOTHER"] == undefined) output("it can't be like this!  W-we were going to free Mareth!");
	else output("not again!");
	output("</i>\"");
	
	if(flags["COC.TIMES_TENTACLED_SAND_MOTHER"] == undefined) output("\n\nThe dumb cunt still thinks you're working with the demons!");
	else output("\n\nThe dumb cunt still thinks she has a say in this!");
	output("  Well, no sense in disabusing her of that mistaken notion.  You unleash your array of hungry tentacles, allowing them to stretch out, lengthening beyond their normal, meager sizes to slide under the witch's hem.  The silken fabric tickles your fleshy shafts delightfully as they slide up into it, gliding between it and the trembling slut's flawless skin.  She tries to shake your questing members, but you twine them around her legs, methodically wiggling them higher.");
	
	output("\n\nWhen the first one slides across her upper thighs, you're happy to find a complete lack of undergarments.  Your tip touches against a pair of smooth hairless lips and a moment later, a second, identical set.  Slippery moisture lubricates both pairs, and two prominent clitties prod and stab at your shaft as it feels around.  Inspired by this, you set your verdant cock-flora wild, climbing up the enchantress's torso and between her four watermelon-sized breasts.  You can see it disappear into the mammary valley through the milk-whetted cloth, utterly devouring your length, at least, until it pops back out the top, pleasantly pulsing.");
	
	output("\n\nThe Sand Mother gasps as she's firmly wrapped up with dick, subsumed in squirming cocks that rapidly immobilize her arms and legs.  The one between her tits arcs around the side of one, then zips through the tits again, horizontally.  It continues its voyage, squirming and sliding around the quad-breasts until all four are tightly bound in tentacle, massaged by its every motion and squeezed just hard enough to make them squirt and leak their bountiful milk.  The rest of your cock-tentacles aren't idle, and at the same time, they encircle her neck and hips, a pair of them poising above the slick openings below.  Tiring of having a sub-par view of the action, you flex one of your members and easily tear the supple fabric, ripping it from the large matron's frame.");
	
	output("\n\nNow fully exposed, you're treated to the magnificent sight of the dark-skinned enchantress all trussed up with green cock.  The swollen, purple heads of your many members leave behind smears of shining pre-cum as they move, turning the queen of the sand witches into little more than a cock-stained slut.  While the view and sensation of her glossy skin combine to make you dizzy, you crave more.  [pc.EachCock] is achingly hard and ready to go, and you desperately need something to sheath them in.  You pause long enough to judge your target's readiness.  She's gasping, blushing and squirming in your restraints, not in panic but in lust.  Her nipples are hard, milk-squirting bullets.  You flick one to test its firmness and get rewarded with a thick gout of creme.  She's ready.");
	
	output("\n\nAs one, you take your twin, cunt-hungry tentacle cocks and thrust them forward.  A cacophony of liquid squelches signal your successful penetration, and each cock can feel the other through the narrow divide.  The twin shafts gleefully double-penetrate the witch without even touching her anus... yet.  Even after a foot of cock is inside her, you keep pushing further, pushing past cervixes in order to curl your penises about in the warm, welcoming wombs.  You shudder from feeling the tight cervical ring around yourself and nearly cum, but you hold back, waiting until you can tend to all of your needs.");
	
	output("\n\nHigher up, you try to press a tool through the Sand Mother's nicely plumped lips, glossing them with your cock-juice.  The puckered gateway remains steadfastly closed to you, blocked by a barrier of gleaming white teeth that no amount of dick pressure will move you.  Growling, you pull back and whip your vine-like dick to and fro, smacking her cheeks punishingly hard.  The impact sends stinging lances of pain through your marvelous member, but you endure it, punishing her until her cheeks are rosy red and slimed.  Once she gasps in pain, you retract and thrust with one sinuous motion, burying nine inches of dick-flesh down her unprotected throat.  Her reaction is a muted gurgle, any words of protest turning into a vibrating staccato of pleasure for your forced blowjob.");
	
	output("\n\nNot to be outdone, your fifth cock crawls down the blonde bitch's back towards the gentle swell of her posterior where it knows the last unviolated hole remains.  It squishes through the cushiony butt-cheeks and kisses past the puckered asshole.  The witch immediately clenches tight, something you can feel in the dicks already double-stuffing her twats.  Your teasing tendril slowly hotdogs its way through the taut anal valley, allowing those tight muscles to relax.  The tip gently circles her anus at the culmination of each stroke, bumping the clenching hole gently as it encourages it to relax.  That resistant hole puts up a valiant fight, but after a minute or so of being fucked in three holes, the Sand Mother's fourth hole begins to relax, first accepting a portion of the tip, then the whole thing with a wet pop.");
	
	if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 6) {
		output("\n\nYou still have ");
		if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 7) output("untended serpentine shafts to please");
		else output("an untended serpentine shaft to please");
		output(", but all the holes are full!  You take the ");
		if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) == 6) output("leftover one and thread it");
		else output("leftover ones and thread them");
		output(" through the dick-dominated enchantrix's fingers.  By now, her body has completely and utterly betrayed her, and she grabs hold like a cock-hungry slut, immediately stroking up and down, jacking it like a pro.  A muffled sigh of contentment shivers up your throat-fucking cock, alerting you to your depraved foe's prick-addled state.  You begin to pump your quartette of buried cocks into their respective holes with renewed vigor.  The titty-fucking vine pistons through its curvy path along with them, sending the witch's tits jiggling and squirting wildly.  The only thing");
		if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) == 6) output(" held still is the one getting a hand job, and you only hold it still");
		else output("s held still are the two getting hand jobs, and you only hold them still");
		output(" so that part of you can relax and enjoy your captive Queen's enthusiastic wanking.");
	}
	//(10+)
	if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 10) {
		output("\n\nThat accounts for seven of your myriad members, but you are endowed to the extreme.  Three of your dongs have been lurking in the back, hidden behind their more enthusiastic brothers.  Now that she has become a willing participant, supine in a bed of penis, the Cum Witch is assaulted by those same tentacles.  One thrusts down towards the dick-stuffed anal star and jams itself in beside, doubling the dilation and allowing you to experience bliss - twice the anal sex AND frotting, all at the same time.  The other two penises jump into the orgy with a vengeance, snaking into the pair of cunts alongside their buried brethren.");
	}
	output("\n\nNow fully enveloped, you lean over your happily gurgling prey, admiring her swollen, milk-engorged bust as you take her in every way imaginable.  You wordlessly command your multitude of dongs to fuck faster, then, lean down for a sip of sweet breast milk.  Drinking happily, you allow your body to whip into a sexual frenzy, pumping and pounding, sliding and squeezing, fucking with the relentless power of a champion-turned-tentacle-beast.  Every ounce of exposed skin and every orifice is liberally slicked with your pre-cum, and as your one man orgy winds to a fever pitch, you let the milky tit pop free and bellow out in bliss, cumming hard.");
		
	output("\n\nA bevy of bulges work their way up your shafts as you orgasm, dozens of them quickly traveling from base to tip, stretching cunnies and gaping anuses as they go.  When they reach your large, throbbing tips, your cum slits stretch wide and unleash matching waves of white.  Both cunts are creamed from womb to lips.  Your new favorite slut's anus is given an alabaster enema.  All four tits get a frothing jizz-bath.");
	if(pc.totalCocks(GLOBAL.TYPE_TENTACLE) >= 6) output("  Bubbling seed soaks her frantically jerking hands.");
	output("  That was just the first explosions of relief.  You orgasm drags on as you squirt like a firehose, drenching the poor witch with white from head to toe.  Her belly rounds obscenely, stuffed from her throat, ass, and wombs, filled to absolute capacity until all four of the aforementioned holes are squirting torrents of sticky white man-milk into thick puddles.");
		
	output("\n\nYou pull out as your pleasure dies down, aiming all " + num2Text(pc.totalCocks(GLOBAL.TYPE_TENTACLE)) + " of your cum-nozzles above her like an obscene shower, and drench her from head to toe again, a salty white wreck of a cumslut.  With her throat free for the first time in a long time, she swallows and whimpers, \"<i>Oooooh... gods.</i>\"  The cum-drunk fuck-slut begins to clean herself the only way she can right now - with her mouth.  She's so fucked out that she couldn't channel her magic if she tried.  You get dressed with a satisfied swagger.");
	if(flags["COC.SAND_WITCHES_COWED"] == undefined) {
		output("\n\nThe witches are suitably cowed, but you've ruined any chance at a friendly peace with them.");
		flags["COC.SAND_WITCHES_COWED"] = 1;
	}
	else output("\n\nThey may not think much of you, but turning the Sand Witch Queen into a mewling slut never gets old.");
	IncrementFlag("COC.TIMES_TENTACLED_SAND_MOTHER", true);
	pc.orgasm();
	//dynStats("cor", 1);
	pc.cor(1);
	if (!inCombat()) {
		clearMenu();
		addButton(0, "Next", function():*{
			setEnemy(null);
			clearMenu();
			mainGameMenu();
		});
	}
	else CombatManager.genericVictory();
}
//*Fuck Her Cunt
//>Sets to resisting with options for repeat rapes.
public function fuckTheSandMothersCunt():void {
	clearOutput();
	sandWitchMotherShow();
	var x:int = pc.cockThatFits(enemy.vaginalCapacity());
	var y:int = pc.cockThatFits2(enemy.vaginalCapacity());
	output("You admire your prize for a moment, reveling triumphantly in your victory as you hastily disrobe.  The Sand Mother, defeated and weak, declares, \"<i>Fine then, do as you will.  You won't break me.</i>\"  The venom in her voice takes you off-guard - she still thinks you're a demonic agent!  You shrug and roll her over, pulling her up onto her hands and knees.  She can think what she wants, but you're going to tap her super-curvy body regardless.  You smack the weakened Queen through her sheer robes and admire the ripple that moves from one side of her well-endowed tush to the other.");
	if(silly) output("  Dat booty be poppin', yo!");
	output("  Another slap, this time from the other side, sends waves of motion back across, and you cannot help but give the supple cheeks a tight squeeze immediately after.");
	
	output("\n\n\"<i>Just... just get it over with already!</i>\" implores the queen witch, glaring daggers back at you over her shoulder.  Her skin is warm to the touch, even through the fabric of her robe, and a slight blush is visible on her cheeks.  Whatever she says, she must be enjoying this to some degree.  You lift the hem of her robe to expose the reddened derriere, gently caressing it.  Dipping a finger lower, you find her womanly folds and casually test them.  Two pairs of simmering snatches slick your fingers with her copious lady-lube, so thick it feels ready to drip and ooze out in long strings.");
	
	output("\n\nYou laugh and ask her why she's pretending not to want this - her pussy is wet enough to flood the deserts!  Shamed by your discovery, the Sand Mother casts her eyes down and shudders in shame, her juices beginning to spatter wetly on the floor.  You stand up from underneath her and wipe your fingers off ");
	if(pc.tallness >= 90) output("at the nape of her neck,");
	else output("on her stomach,");
	output(" then shift position to cup her swollen mammaries.  The super-soft, fluid-filled breasts seem to devour your fingers with their softness, and you begin to roughly grope and knead them, expressing a few drops of milk as you maul her tits.  Her nipples grow hard under your less-than-gentle ministrations, engorging to near double their original size.  You flick one and smile when the huge-breasted Queen of the desert lets out a little moan of a whimper.");
	
	output("\n\nYou go back to grabbing her ass with one hand and fondling her pussy with the other until your digits are soaked with the slobbery lady-lube.  Now that she's nice and ready, you smear her juices across your [pc.cock " + x + "], mixing it in with your own bubbling pre.  She starts to push back into you, hungry for stimulation now that you've left her womanhood untended.  You smirk and aim your slippery member at one of the approaching holes");
	if(y >= 0) output(", grabbing a second cock as well, intent on penetrating both of her sopping entrances");
	output(".  The moment her labia caress your ");
	if(y >= 0) output("cockheads");
	else output(pc.cockHead(x));
	output(", she freezes as she realizes what she's doing, and she tries to pull away.");
	
	output("\n\nIntent on penetration, you grab hold of the witch's well-developed hips and drag her weakened body down, smoothly impaling her on your ");
	if(y >= 0) output("tools");
	else output(pc.cockDescript(x));
	output(".  She moans out loud, throwing her bleached tresses around wildly in pleasure while inch after inch of cock snakes into her passage");
	if(y >= 0) output("s");
	output(".  Your [pc.hips] clap against her jiggly butt when you bottom out, rocking her whole body forward from the impact and setting all four breasts bouncing and swaying beneath her, painting trails of milk across the floor.  Gradually, you draw back, exposing your sex-slicked length, and thrust back in, leaving no time for her to pull away.  As soon as you hilt yourself to the [sheath], you bounce away, pushing in and out, back and forth, a slow, steady fuck that leaves the Sorceress little time to do anything but roll her hips in your palms and moan like a whore in heat.");
	
	output("\n\nThe tall, statue-esque lady is little more than putty in your hands and around your penis");
	if(y >= 0) output("es");
	output(", her pulsing, slick oven quivers in anticipation of the next stroke every time you leave her vacant.  You really work her over, spanking her encouragingly whenever you feel she isn't into it enough.  She's blatantly, unashamedly moaning by this point, and she lowers herself to the floor so she can begin to squeeze her breasts with her hands, squirting out puddles of milk from one pair then the other, bouncing back and forth until the resulting four puddles turn into one small lake.  The Witch's twin cunnies are gushing out fem-lube with every motion, and as you feel both of your orgasms approaching, you pull completely out, leaving her achingly empty and gaped.");
	
	output("\n\nThe Sand Mother begs, \"<i>Put it back in!  Please, fuck me!  I neeeeeed it!</i>\"  She tries to crawl back into you, aiming to pin you between the wall and her sizeable ass.  You easily shift to the side and let her smash her butt into the stone, squeezing her plump cheeks obscenely as she moans disconsolately.  When she crawls away, there's two cunt-shaped stains on the wall, dripping long rivulets to the ground.  Gods in heaven, she's wet!");
	
	output("\n\nYou tell her that if she wants to be fucked like a bitch, she needs to beg like a bitch - face down, ass up, and whimpering like the needy slut that she is.  Hope sparks in her eyes, warring with suppressed pride, and she gingerly lowers her face to the ground, not daring to meet your gaze as she lifts her rump high and spreads her legs.  A pitiful whine so quiet that you can barely hear it squeaks from her lips.  Not good enough.  You tell her that you aren't convinced.  She doesn't sound like a horny bitch just begging to be plugged full of cock.  Again, the witch whines, but this time, it's high and keening, a plaintive wail that's part moan and part encouragement.  Juices drip freely down her legs as she gives in completely, her knees twitching, her twin pussies opening, blooming like flowers and pulsing with hungry dilations, still slightly gaped from your fuck.");
	
	output("\n\nWatching her debase herself like this, [pc.EachCock] grows even harder, oozing and aching to cum.  You congratulate the simpering excuse for a sorceress on her proper mewling by pushing back inside her sweltering snatch");
	if(y >= 0) output("es");
	output(".  Fucking her hard and fast, you pay little heed to her pleasure and simply mount her, rutting her roughly.  She doesn't even stop her begging either, and every now and then you can actually pick out words like, \"<i>Please,</i>\" and \"<i>Cum.</i>\"  You grab a fistful of her hair and pull her head back, commanding her to cum for you, even as you feel your orgasm rising, welling up within you.");
	
	output("\n\nThrusting hard enough to clap your loins to her ass audibly, you erupt, spurting wildly into the convulsing, snug love tunnel");
	if(y >= 0) output("s");
	output(".  Semen floods out of you from the force of your orgasm, creaming the juicy cunt");
	if(y >= 0) output("s");
	output(" as ");
	if(y < 0) output("it clamps down");
	else output("they clamp down");
	output(", squirting femlube and leftover spunk across your [feet].");
	if(pc.cumQ() >= 500) {
		output("  Again and again, you flood the poor spellcaster's twat");
		if(y >= 0) output("s");
		output(", shooting so much that it bubbles out in thick globs to fall wetly on the ground.");
		if(pc.cumQ() >= 2000) output("  They fall faster and faster as you cum, the witch's belly bloating, rounding out to a ridiculous degree.  Her legs are drenched with the leaking spooge.");
	}
	output("  Once you've pumped every ounce of your virile fluid into the waiting receptacle");
	if(y >= 0) output("s");
	output(", you pull, admiring the salty, mark you've left on the once proud woman.");
	
	output("\n\n\"<i>Ahhhh,</i>\" she sighs, slumping down into the puddles of sex, \"<i>Told... told you... you couldn't - mmmm... break me...</i>\"");
	
	if(flags["COC.SAND_WITCHES_COWED"] != 1) {
		output("\n\nThe witches are suitably cowed, but you've ruined any chance at a friendly peace with them.");
		flags["COC.SAND_WITCHES_COWED"] = 1;
	}
	else output("\n\nThey may not think much of you, but turning the Sand Witch Queen into a mewling slut never gets old.");
	pc.orgasm();
	//dynStats("cor", 1);
	pc.cor(1);
	if (!inCombat()) {
		clearMenu();
		addButton(0, "Next", function():*{
			setEnemy(null);
			clearMenu();
			mainGameMenu();
		});
	}
	else CombatManager.genericVictory();
}

//*ScissorAnDrink
public function scissorAndDrink():void {
	clearOutput();
	//>Sets to resisting with options for repeat rapes.
	output("Looking at the Sand Mother, you can't help but feel a flutter of heat swim through your nethers, and as you close in, you can feel the moisture gathering on your mons in anticipation.  The ultra-curvy witch's teats have turned her robe into a set of four soaked tents, and you can tell from the scent she's giving off that she's as ready for a little womanly love as you are.  You squeeze one of her breasts until the exceedingly well-endowed woman is moaning, squirting milk through her silken robes to dribble down the curvature of her bust's underside.  You collect some on a fingertip before roughly thrusting it into her protesting lips to silence the insipid complaints she's started voicing.");
	
	output("\n\n\"<i>Shut up.  You and your ilk have done nothing but cause me trouble.  The least you can do is cooperate and enjoy it while I get off on you,</i>\" you growl, giving her heavy chest a firm squeeze in warning.");
	
	output("\n\nThe witch queen pants as you withdraw the finger, \"<i>You won't break me, demon-slave!  ...But I can't fight you any longer.  Just know that you will not break me!</i>\"");
	
	output("\n\nWhatever.  You grope the top two tits until rivers of milk are running onto her bottommost bosom, the creamy milk sheeting down the thin, fabric covering, turning it semi-transparent and clingy.  The Sand Mother's dusky cheeks color slightly as she watches her breast's creamy issue spill out in rivers, undoubtedly dripping down the interior of her garments in even greater quantities.  You grab one of her plump nipples and squeeze it from base to tip, spraying a gout of milk into your waiting mouth.  Finally starting to enjoy it, the Sand Mother moans and arches her back, pressing her milk-laden chest into your hand.  You lick the lactose-bearing juice from your lips.  She tastes great!");
	
	output("\n\nYou make derogatory comments on her productivity until the tall woman's eyebrows knit together in anger.  She purses her lips to retort, and you swoop in, grabbing her platinum tresses as you smash your mouth against hers, hungrily jamming your tongue into her oral cavity until the anger-stiffened muscles relax into quiet, lusty complacence.  Her eyes drift closed as her tongue hesitantly extends to dance with your own.  In no time, the two of you are swapping spit almost non-stop.   Your hands gleefully caress her sodden, milk-slicked fleshed, peeling away her coverings until you can feel the smooth flesh giving under your probing fingers, her heavy tits compressing and sloshing at your feverish touches.");
	
	output("\n\nGuiding one of her hands to your [pc.gear], you pull back long enough to whisper, \"<i>Help-</i>\"  You muffle yourself by diving back into the kiss with ardent gusto.  Your reluctant lover hesitantly fumbles with your [pc.gear] for a few seconds before you threateningly tweak one of her leaky nipples, causing her to groan.  Her vocalizations are muffled by your own lusty maw, but she gets the idea and begins to peel away your gear with shaking hands, only stopping when your lascivious lip-lock grows overwhelmingly passionate.  It takes another tweak to get her going.  Soon, you're naked and cradled against the");
	if(pc.tallness < 85) output(" larger");
	else if(pc.tallness > 105) output(" smaller");
	output(" woman, moist, slick bodies entwined as you both grope and grind.");
	
	output("\n\nYou nip at the enchanting blond's lower lip just hard enough to make her gasp.  Her eyes show hurt and anger along with an unquenchable, fiery resolve.  That's fine.  She can have her resolve so long as she gets you off and lets you get at that milk!  Kissing down her vulnerable neck, you nestle your face square into the middle of her quartet of melon-sized breasts, licking and kissing your way through the quad-cleavage until a fat teat drips against your cheek.  You tilt your face to the side until it's sliding across your mouth, trailing milk in its wake, and you gleefully suck it in, smirking around the fat nipple as its owner's hands squeeze down on your [pc.butt] uncontrollably.");
	
	output("\n\nHer doubled labias have grown so hot that they're almost steaming against your [leg].  She keeps shifting to press them against you, leaving hot, slippery, cunt-shaped stamps of clear moisture on your " + pc.skinFurScales() + ".  Groaning with your own unfulfilled needs, you drink a deep draught of delectable milk and bring your own burning-hot furnace of need to bear on your once-foe.  Her creamy thigh feels like heaven against your vulva, and you lewdly grind your [pc.clit] against her supple leg until you can feel her moisture starting to drip into your honeypot.  Your traitorous muscles lurch your sordid snatch straight into the Sand Mother's copious, clenching crotch, and both of your minds are buried under the avalanche of raw, sensuous pleasure.");
	
	output("\n\nYou drag your slippery vulva across the twin twats, fold slipping over fold and [pc.clit] bumping clit after clit.  This obscene scissoring is an exquisite symphony of sensation that your [pc.vagina] is all to happy to drink down.  Gushes of hot fem-cum froth around each set of clinging lips as they're pressed against their opposite pair, setting off fireworks in your brain that make it impossible to do anything but moan and gurgle around the milk-seeping teat in your mouth in between swallows.  Shuddering, the platinum-haired enchantress seems to be trying to hold back from her own orgasm, but your hedonistic, pleasure-seeking loins seem intent on making her pussies melt.");
	
	output("\n\nSuddenly, the milk-flow intensifies, the three remaining nipples gushing hot fountains of creamy delight across your nubile form, and waves of sticky girl-goo explode across your [pc.vagina], [pc.hips], and thighs, the hot love-syrup bursting across your nerves in an explosion of heat so warm that it feels like it sets off some kind of aphrodisiac orgasm-bomb in your fluttering canal.  The white-hot explosion causes your muscles to lock and relax in senseless paroxysms of pleasure.  Your slick fem-cum ");
	if(pc.wetness() >= 5) output("explodes out in a cunt-shattering spray");
	else if(pc.wetness() >= 4) output("gushes out in a heavy spray");
	else if(pc.wetness() >= 3) output("pours out in a thick, wet river");
	else if(pc.wetness() >= 2) output("drools out in a steady trickles");
	else output("drips out during the cunt-shattering convulsions");
	output(".  Bulging obscenely, your cheeks barely contain the flood of milk, and you swallow it without thinking, acting entirely on instinct.");
	//pc.refillHunger(40);
	output("\n\nTwo strong arms encircle the back of your head and press your " + pc.face() + " deeper into the gushing chest-flesh until you're left but no choice but to suckle and swallow while the fluttering cooches finish bathing each other in liquified orgasm.  You hum in super-sensitive bliss - well fed and sated, trembling every few seconds whenever your [pc.clit] catches on a fold or the other two rigid buttons.  The Sand Mother's sculpted body slowly goes limper and limper under your attentions until she's on her back and your grinding draws a few, last trembling sparks of pleasure from her body.");
	
	output("\n\nA few minutes later, you separate from her drained teat and wipe the white from your chin.  That hit the spot.");
	
	output("\n\n\"<i>Ahhhh,</i>\" the Cum Witch sighs, slumping down into the puddles of sex, \"<i>Told... told you... you couldn't - mmmm... break me...</i>\"");
	
	if(flags["COC.SAND_WITCHES_COWED"] != 1) {
		output("\n\nThe witches are suitably cowed, but you've ruined any chance at a friendly peace with them.");
		flags["COC.SAND_WITCHES_COWED"] = 1;
	}
	else output("\n\nThey may not think much of you, but turning the Sand Witch Queen into a mewling slut never gets old.");
	pc.orgasm();
	//dynStats("cor", 1);
	pc.cor(1);
	if (!inCombat()) {
		clearMenu();
		addButton(0, "Next", function():*{
			setEnemy(null);
			clearMenu();
			mainGameMenu();
		});
	}
	else CombatManager.genericVictory();
}
	
//*Lose Male Loss
//>Get turned into breeder or sumthin.
public function loseToSandMotherBadEnd():void {
	clearOutput();
	output("Stumbling back into a wall, you try to hold your ");
	if(pc.HP() <= 1) output("battered body aloft, but your wounds are too great, robbing you of strength.");
	else output("rebellious body aloft, but your lust is too great, turning your body into a quivering wreck.");
	output("  You ");
	if(pc.HP() <= 1) output("spitefully watch the Sand Mother approach, only able to admire her sculpted form as she towers over your prone form.");
	else output("hungrily watch the Sand Mother approach, only able to touch yourself as you gaze up at her sculpted form");
	output(".  She sniffs in disdain as she looks down at you.  \"<i>Disappointing.  Lethice sends a weakling like you after us, and the sisters do not even slow you.  Their atonement shall be severe.</i>\"  Her eyes, blue as the desert sky, consider you again, and she mutters, \"<i>First, there is the matter of you, isn't there?</i>\"");
	
	output("\n\nA manicured, shoeless foot peeks from beneath the swishing silken robes to prod your [pc.gear], deftly peeling open the crotch to expose your ");
	if(pc.HP() <= 1) output("rapidly-swelling erection");
	else output("turgid, pre-cum slathered boner");
	if(pc.cockTotal() > 1) output("s");
	output(".  \"<i>Oh, what have we here?  Were you thinking impure thoughts, my little demon agent?</i>\" the towering sorceress asks.  You protest, decrying your innocence, even though your throbbing manhood pulses fitfully, bouncing on your belly.  The silk-robed queen snorts and gently plants her foot atop you, dragging her soft sole along your sensitive urethral bulge, her toes curling down to either side of it.  \"<i>Oh, there's no need to keep up the pretense of innocence now, though I must admit, it is amusing to watch you cry out so,</i>\" she says with a smile.  \"<i>Whatever you were, that is at an end.  You will serve the sands and revere me as your Queen, just like the sisters.</i>\"");
	output("\n\nNo!  You try to squirm out from under her, but with her deft caresses and your recent combat, your muscles are as weak as a babe's.  You can't even roll over to make a crawl for it.  The best you manage is a weak rocking from side to side and pushing yourself an inch or two towards the exit, which seems further away than ever.  Your [pc.hips], reacting to a particularly skillful squeeze, lurch upward, and a weak whimper escapes your mouth.  A dollop of clear pre oozes out of your tip onto the Sand Mother's soft arch, acting as lubricant for the gentle, forced footjob.  Gasping in between guttural whimpers, you slump down and submit to the insistent caresses of her toes.");
	
	output("\n\nWhile you may have given in bodily to the pleasure, some part of your mind is still resisting.  You're being treated like a demonic agent, when all you had wanted to do was save your village.  It's not right!  Blushing from the inexplicably enjoyable cock-rub, you manage to stop moaning long enough to utter a weak protest.  You tell her that you ");
	if(cor() < 66) output("aren't corrupt");
	else output("don't serve the demons");
	output(", looking up at her pleadingly ");
	if(pc.cockTotal() == 1) output("while she gleefully pumps you, smearing your leaky juices all over your shaft.");
	else output("while she gleefully moves to your second cock, smearing it with your first dick's pre-cum, messing your [pc.cocksLight] with each penis's leaky drippings.");
	
	output("\n\nThose torturous strokes slow, eventually stopping entirely, leaving you achingly hard, tremblingly tumescent and ready to pop, but unable without any stimulation.  The imposing sand witch considers you, adjusting a free-flowing lock of her bleached crown behind her shoulder as she thinks.  At last, she murmurs, \"<i>...the ring of truth.</i>\"  Hope surges through you, warring with disappointment at the sudden halt of your carnal pleasure.  The Sand Mother lazily slides her big toe across the pre-glazed length of your cock as she proclaims, \"<i>It doesn't matter.  I cannot let you go with your knowledge and weakness, or you'll give us up to the demons.</i>\"  Your dream of freedom shatters, while a dark, feral part of you rejoices at the return of the teasing touches.");
	
	output("\n\n\"<i>SISTERS!  Fetch the Cum Witch!</i>\" your captor bellows, never slowing in her dick-focused manipulations.  A chorus of assents echoes back, and the doubly-buxom beauty returns her focus to you, pressing down with her foot, gently dragging your dick through the puddle of pre-cum you've made over your belly-button.  The scent of sex is growing heavier in the air, mostly from your own productions");
	if(pc.hasVagina()) output(" and ignored womanhood");
	output(", but there is a hint of foreign female musk that you can detect as well.  Four bullet-like nipples are visible in the Sand Mother's thin silk robe, pressing out lewdly and staining it with damp, milky moisture.  The sight sends a pleasant tingle to your overloaded groin, adding to the heavy heat that's been building under the practiced fondling.");
	
	output("\n\n[pc.EachCock] thickens in anticipation, flexing hard enough to lift clear of your middle.  Internal muscles clench and quiver, pumping slick warmth through your middle, a bubbling load just ready to burst.  Without warning, the enchantress pushes her foot down harder, squeezing [oneCock] back into your pre-puddle.  \"<i>Go on, let it out,</i>\" she encourages, quickly sliding up and down while keeping up the pleasure.  \"<i>I promise, I'll make your new life enjoyable.</i>\"  The agonizingly intense sensation triggers an gigantic wave of hot bliss inside you, and you arch your back, pinned as you are.  Lewdly pumping your [cock biggest] into the slippery arch, you cum, [pc.EachCock] bouncing and dilating as it fires ribbons of fresh, salty cream across your body.");
	if(pc.cumQ() >= 500) output("  Wave after wave of jism washes across you, thoroughly drenching you with your spooge, the alabaster spunk soaking you from crown to waist with sticky slickness.");
	if(pc.cumQ() >= 3000) output("  A puddle pools around you, deepening nicely as your boundless virility does its work, inching up your body until you feel as if you'll float away in your own pearly jism.");
	
	output("\n\nJust as you're finishing, dribbling out a few weak spurts of cum, another robed figure enters the chamber.  Despite the penetrating scent of your ropey orgasmic goo filling the room, the smell of jizz intensifies at the new arrival, doubling in magnitude as the robed woman approaches you.  The Sand Mother wipes her foot off on your [leg] and whispers, \"<i>Good " + pc.mf("boy","girl") + ".  Now relax, we'll make this feel good.</i>\"  She turns away from you to greet the ebony sister.  This one isn't just dark-skinned or well-tanned... she's virtually midnight black.  Worse, her robes are spattered with whitish stains, and a protrusion that would put most men's erections to shame tents them with unabashed eagerness.  ");
	if(flags["COC.CUM_WITCH_DEFEATED"] > 0) output("The Cum Witch is here, and she seems to have recovered from her defeat!");
	else output("This must be the Cum Witch!");
	
	output("\n\nThe two women exchange a few whispered words, too quiet for you to make out.  From the little bits you do here, it sounds like they're almost arguing over something... you.  The Sand Mother frowns and shakes her head, speaking just loud enough for you to hear, \"<i>I don't think we need it, but you're right.  It would be a waste.</i>\"  They both nod at that and turn back to your orgasm-wrecked form, admiring your heaving [pc.chest] and thick coat of glaze.");
	
	output("\n\nThe chocolate woman tosses her robe away with a flourish, revealing a surprisingly normal form (aside from her rather gifted maleness) with only two breasts.  \"<i>This won't do,</i>\" she tuts, poking and prodding your body with her foot, \"<i>But the body can wait.  We need to fix you up here.</i>\"  The Cum Witch pokes a finger to your forehead for emphasis as she mounts you, mashing her drooling ebon cock over your half-hard, cum-coated maleness.  Still over-sensitive from your ");
	if(pc.balls > 0) output("testes");
	else output("prostate");
	output(" emptying orgasm, you shudder and try to pull away, but there's nowhere to go.  Gentle hands place themselves to either side of your head, immobilizing you, and the lusty hermaphrodite begins to chant, punctuating her arcane words with slow pumps of her body across your cum-slicked middle");
	if(pc.balls > 0) {
		output(", two sets of slippery balls bouncing and sliding across each other");
		if(silly) output(".  Great, now it's gay");
	}
	output(".");
	
	output("\n\nA quiet hum buzzes in your ears along with a gradual, growing tingle in your temples.  A pinkish glow can be seen from the edges of your vision as the chant finishes, and the droning intensifies, thrumming through your head powerfully.  Between the sensations from your loins and the potent magics seeping into your mind, your thoughts are scattered, shattering apart even as you try to scrape the pieces together into meaningful consciousness.  You aren't accustomed to anything like this, and you keep trying to think, to react, to do anything, but every single time, the half-born cogitation vibrates apart, melting away into a syrupy soup of nothingness.  After a while, you just give up.  Feeling... experiencing the here and now... that becomes your whole world.");
	
	output("\n\nYou don't react when your memories begin to fragment, vibrating apart into little pieces.  They slip into the pink morass in the bottom of your skull, dissolving into the pink sea of pleasure one by one.  That time you got caught stealing fades, along with a year or two of your childhood, replaced by a rising tide of sensational, unthinking bliss.  [pc.EachCock] erupts again, spurting fitfully at the Cum Witch's command, each jet timed perfectly to the tempo of her dark, pistoning member.  With every spurt, more memories and knowledge melt away into sludge.  Soon, even your purpose is gone.  Your eyes roll back as you continue to cum unceasingly, an empty vessel of nothing but orgasmic pleasure.");
	
	output("\n\nThe midnight-hued magician abruptly pulls away, the pink light fading from your vision.  She's fully erect, her glans huge and engorged, shuddering with every beat of her heart as she struggles not to cum.  Even without her touches, you continue to orgasm, subsumed in bliss that doesn't end, not even when your [pc.balls] ");
	if(pc.balls > 0) output("empty");
	else output("empties");
	output(" and the pearly flow fails.  The Sand Mother, who has watched this whole time, has a hand up her robes, meticulously probing her crotch.  You can easily make out her masturbation through the utterly soaked, silken robes, which only grow wetter thanks to her other hand's squeezing, milking white flows out of each of her four tits, one after another.");
	
	output("\n\n\"<i>Now that you are empty, it is time to fill you,</i>\" a silky voice solemnly proclaims.  You feel a pressure at your [pc.vagOrAss], smoothly sliding into you without warning or resistance.  The sheer amount of cum covering the cock makes its passage easy, and the entire length quickly slips into you with only the sloppy squish of wet balls on your [pc.butt] to announce the full penetration.  Moaning, the dark chocolate spellcaster chants, her words tinged with pleasure and gleeful, inarticulate exhalations.  Her thick length, immobile inside your tightly-clenching ");
	if(!pc.hasVagina()) output("innards");
	else output("folds");
	output(" thickens slightly, and the heaving balls below jiggle with liquid weight, swelling larger against you.  They grow heavier and heavier, until they slosh with audible, barely contained need, each as large as one of your butt-cheeks and three times as soft.");
	
	if (!pc.hasVagina()) pc.buttChange(12, true, true);
	else pc.cuntChange(0,12, true, true);
	
	output("\n\nThe swollen cockhead inside you widens, forming a perfect, penetrative seal inside you.  Then, the thick shaft belches out its hot load, forcefully injecting warmth into your very core.  A second pair of hands grace your temples, and a familiar but unremembered voice takes up the chant.  The buzzing returns, and information begins to enter your mind to the tempo of the free-flowing semen.  You gurgle out a happy noise, your tongue lamely hanging from the corner of your mouth as you cum again to the unnatural fullness.  Jism floods your ");
	if(!pc.hasVagina()) output("bowels");
	else output("womb");
	output(", pumping into you with enough force to audible splash and churn about, gently thickening your middle.  A crystalline lattice-work erects from the mental syrup, climbing higher into a brand new frame of reference, filled with the thoughts and experiences of others - no, of your past.  New memories fill in the gaps while your gut rises, forming a small bump that would be easily mistaken for pregnancy.");
	
	output("\n\nDissonant thoughts gradually begin to gather, and you blink through the confusing pink haze as comprehension reasserts itself.  Your belly-bump jiggles with fluid weight, and your belly button pops out, visible for all to see.  Above you, your best friend, the Cum Witch, is smiling down at you, shuddering as she blasts a last few flows of her seed into your jam-packed ");
	if(!pc.hasVagina()) output("[pc.butt]");
	else output("uterus");
	output(".  She gives a contented sigh and slides out, followed by a noisily-spurting torrents of her virile seed.  Gods, even though she fucks you like this all the time, it feels as good as the first time she stuffed you full.  You're so lucky she's willing to give you so much after sharing with the coven all day!  You cradle your pregnant-feeling middle and giggle out a thank you, slumping back into the puddling spooge.  With heavy eyelids, you bid farewell to wakefulness, slumbering fitfully after your ordeal.");
	pc.orgasm();
	//[Next]
	clearMenu();
	addButton(0,"Next",menLoseToQueenMotherVolI);
}
//Epilogue:
public function menLoseToQueenMotherVolI():void {
	clearOutput();
	output("The champion woke to a body changed.  " + pc.mf("He","She") + " now looked every bit the mirror image of the Cum Witch - a thick, girthy cock, two swollen balls, a pair of pendulous breasts, and skin as dark as the blackest night.  She had become one of them, a futanari witch with an insatiable libido.  As best as she could remember, she had been born a scant ten years earlier, and aged to maturity in five.  She volunteered to be a cum witch when the call went out and beat out over two dozen of her lusty sisters for the vaunted position.  Now, the elder Cum Witch was her best friend, and the two gleefully spent their days dick-deep in double-cunts, knocking up their sisters with reckless abandon.  In their free time, they studied spells and practiced stuffing each other with increasingly large seminal deposits.");
	
	output("\n\nTwo years later, at the call of the Great Mother, the sand witches went to war.  ");
	if(flags["COC.HEL_HARPY_QUEEN_DEFEATED"] != 1) output("Their harpy and phoenix allies allowed them to approach Lethice's fortress unhindered, and i");
	else output("I");
	output("n the bloodiest battle ever to take place on Mareth, the demons were defeated, wiped from the world in a blaze of white fire.  In the years that followed, the covens worked to undo all that had been wronged in the world.  Many demons remained, but their influence was on the wane.  The world moved on, and those that remained wisely hid.");
	
	output("\n\nThe sand witches turned the deserts into a jungle paradise, and though they lacked the taint of corruption, they never stopped their policies of aggressively bringing in blood.  Many were brainwashed into service, like the champion, but peace was brought to Mareth.  The unanswered question... is a world ruled by lusty milk witches any better than the corrupt one that preceded it?");
	badEnd();
}
	
//*Lose Female Loss
//>Get turned into sand witch.
//Additional Sand Witch Entry (BY XODIN)
public function loseToSandMother():void {
	clearOutput();
	output("The world grows dizzy as your ");
	if(pc.HP() <= 1) output("heavily punished and aching body is filled with too much agony to continue.");
	else output("hot and aroused body fills with unbearable urges that finally distract you from fighting any further.");
	output("  Instead, you fall backwards against the wall ");
	if(pc.HP() <= 1) output("and grit your teeth in anger as the Sand Mother approaches.");
	else output("panting deeply, and your blood races as the Sand Mother approaches.");
	output("  You can not help but admire her incredible physique as she towers over you, looking down upon your body with disdain in her fierce eyes.  \"<i>Lethice should have known better than to send such a pathetic imbecile like you to battle us.  I can hardly believe you managed to get by so many of our sisters.</i>\"  She sighs.  \"<i>Though I suppose it'd be a greater waste if we just killed you.</i>\"");
	
	output("\n\nWith an intricate gesture of her fingers, your [pc.gear] begins stripping away as if undone by invisible hands.  In moments, your flesh is laid bare before her and subject to her judgments.  ");
	if(!pc.hasVagina()) {
		output("Remarkably, a divot appears on your groin, slowly dividing into two puffy lips with a moist crease between.  The fresh mons of your new pussy glistens with immediate arousal as the Sand Mother's magic molds your flesh with a simple spell.  ");
		pc.createVagina();
		pc.clitLength = 0.25;
	}
	output("Your [pc.vagina] is eyed momentarily as it ");
	if(pc.wetness() <= 2) output("grows moist.");
	else if(pc.wetness() <= 4) output("drips with arousal.");
	else output("drools obscenely.");
	output("  \"<i>We can certainly improve upon this.</i>\"  You attempt to voice opposition but she quickly silences you.  \"<i>No! Understand here and now, you live by our mercy.  Your body belongs to the sand.  Your old life is over.  From now on, your failed life will serve a greater purpose.</i>\"");
	
	output("\n\nYou try to resist but ");
	if(pc.HP() <= 1) output("the pain of your abused body");
	else output("lustful urges fill your senses and");
	output(" hinders all of your attempts to fight back.  You try to argue that you aren't a servant of the demons, that you were fighting against them for your own people just as she is, but every time you open your mouth she forces it closed again with her magic.  \"<i>I am not interested in the lies of a demonic servant.  It is time we dealt with you once and for all.</i>\"");
	
	output("\n\nShe kneels and prods your slick pussy with her fingers, forcing sensations that rise up through your body and exit your lips as moans.  \"<i>You'll need an extra one of these of course.</i>\"  The Sand Mother reaches forwards with her free hand to grope your tits.");
	if(pc.bRows() == 1) {
		output("  Plus an extra set of these to ensure you produce as much milk as the rest of your soon-to-be sisters.");
		pc.createBreastRow();
	}
	//if player has four breasts
	else if(pc.bRows() == 2) output("  Thankfully you're already endowed with enough breasts to begin immediate production of milk.");
	//if player has six breasts
	else output("  Hmmm. We've never had a sister blessed with more than four breasts. I wonder if perhaps we can use your unusual anatomy to our advantage.");
	output("  She squeezes a [nipple] and a yelp of pleasure escapes you.  \"<i>I see you like that idea. Excellent.</i>\"");
	//if breasts are smaller than a normal sand witch's
	if(pc.biggestTitSize() < 3) output("  \"<i>Of course we'll have to grow them a bit to suit our needs.</i>\"");
	//if breasts are larger than a normal sand witch's
	else if(pc.biggestTitSize() >= 14) output("  \"<i>Mmmm, and with such massive ones I'm sure we can expect you to produce more than most of our sisters could.</i>\"");
	
	output("\n\nThe Sand Mother's fingers slide around your labia, teasing them, occasionally fingering your entrance and thumbing your clit.  A light sweat breaks out all over your " + pc.skinFurScales() + ".  \"<i>Yes, you're really starting to enjoy that idea, aren't you?</i>\"  You start to nod before regaining your senses. \"<i>I see.  You still need persuasion.</i>\"  She pinches your clit and an orgasm starts shivering inside your [pc.hips].  \"<i>Of course that was never in doubt.  I could never completely trust you, even if I could bring you around to our way of thinking.</i>\"");
	
	output("\n\n\"<i>SISTERS! Fetch the Cum Witch!</i>\"  The Sand Mother smiles as she gives the command.  She watches your body flinch and your breasts ");
	if(pc.biggestTitSize() < 5) output("jiggle");
	else if(pc.biggestTitSize() < 10) output("bounce");
	else output("quake");
	output(" with every twitch of her fingers inside you.");
	if(pc.lactationQ() >= 50) output("  Streams of milk are already starting to pour down the swells of your tits.");
	output("  Her fingers start pressing deeper, playing upon your erogenous zones like an instrument, strumming your body's sense of pleasure to new heights.  She plays your cunt until you cum again and again around palm and gush your juice down her arm.  Everything below your waist abandons your control and submits itself to her administrations.  You cum and all you can do is grope your own tits as you ride the waves of pleasure that saturate your flesh.");
	
	output("\n\nBy the time the Sand Mother has finished reducing the pleasure centers of your brain to mush, a robed figure has entered the room.  Through an erotic haze, you squint and make out the features of an ebony-skinned woman clad in a robe covered in fresh white stains. It fails to hide the sizable erection that she bears; one large enough to shame most normal men.");
	if(flags["COC.CUM_WITCH_DEFEATED"] == 1) output("  It is obviously the Cum Witch you encountered, and she has clearly regained her strength!");
	else output("This must be the Cum Witch the Sand Mother sent for!");
	
	output("\n\nShe and the Sand Mother whisper back and forth, and they seem to disagree about something.  From the stares the Cum Witch gives you, you infer that their discussion concerns you.  Finally, the Cum Witch frowns and speaks loud enough to be heard, \"<i>I don't think we need it, but you're right.  It would be a waste.</i>\"  She bows to the Sand Mother and then approaches you");
	if(pc.bRows() <= 2) output(", admiring the extra set of breasts you already possess");
	else output(", admiring how you've managed to grow " + num2Text(pc.bRows()) + " rows of breasts instead of just two on your panting torso");
	output(".");
	
	output("\n\nThe chocolate skinned woman tosses aside her robe dramatically and lowers her incredibly toned body between your thighs.  Despite the presence of an overly endowed human cock that's already rising beyond your expectations, her overall figure is quite feminine and normal - just one pair of breasts.  She pokes your thoroughly soaked vagina and says, \"<i>This'll have to change.  Just one simply won't do, but right now, the body is the lesser priority.</i>\"  She angles her cock between the folds of your pussy and immediately spears your, shoving her length inside you as if testing your depths.  Once comfortable she raises her hands to either side of your head while her cock thrusts with a steady rhythm into your cunt.  \"<i>Up here...</i>\"  She taps your head with her fingers while she angles your face to stare her in the eyes, \"<i>...is what we have to fix first.</i>\"");
	pc.cuntChange(0,12, true, true);
	output("\n\nThe dark hermaphrodite begins chanting in time with her steady thrusts.  You try to struggle but it's useless in your weakened and aroused state.  All you can do is look into her eyes and listen to her, the words filling your head.  The incantations force themselves into your mind, just as her engorged manhood is forcing itself into your body.  Your brain seems to hum as it fills up with her words, and your pussy quivers while it fills up with her cock.  So much filling, but not enough space.");
	
	output("\n\nYou feel crowded within your own skin.  The sensation of being stuffed to the point of bursting fills you.  There's not enough room for both of you inside this body.  \"<i>Feeling full?</i>\" she coyly asks.  \"<i>No more room left?</i>\"  You can't help but to nod.  \"<i>Not enough room for both of us is there?  But what's going to happen when I cum?</i>\"  The thought sends shivers down your spine.  You feel uncomfortably full, and the notion of being filled even a little bit more makes your belly ache with the thought of bursting.");
	
	output("\n\n\"<i>I'm, ung... going to cum soon little one.  You'd better make room for it.</i>\"  Panic starts to creep through your foggy mind.  You're going to burst if you don't make space, but how?  \"<i>Let go, little one.  It's so crowded inside you, and you want my cum, right?</i>\"  That did sound like it made sense.  If the Cum Witch is inside you, and you're inside you, then one of you has to leave, and since you loved having cum inside you, it makes sense that you should be the one to leave... right?");
	
	output("\n\nThe ebony shaft of the Cum Witch throbs thicker as gooey gobs of her seed fill it up.  With the first hot spurts of jism inside your cunt, you feel your mind slipping away.  Thoughts fall apart to make way for the cum.  Memories are tossed aside to make way for the precious spunk the Cum Witch has to give you.  Dreams, hopes, ambitions, all break down, discarded to make more room for her.  \"<i>Yes, little one.  Just let go.  Let me take you, fill you, have you...</i>\"  That sounds sensible.  The Cum Witch already filled you, so just letting her have your body is probably for the best. She's the one using it anyways.  All you really wanted to do was fill it with cum anyways, and she can do that for you.  She can do everything for you... you just have to let her... you just have to give in... just give in... give... in...");

	output("\n\nPale streams of cum pour from your [pc.vagina] as the Cum Witch finishes her orgasm.  Every muscle in your slutty flesh tenses as you climax again and again, each orgasm slowly hollowing out your mind.  A vacant stare overcomes your expression as pleasure becomes the only thing you comprehend.  The only thing you want.  Ever...");
	
	output("\n\n\"<i>Is it done?</i>\" The Sand Mother asks with a hand between her own thighs, rubbing herself lewdly as she watches the spectacle.");
	
	output("\n\nThe chocolate witch stands up with her somewhat-stiff cock hanging between her thighs and dripping the collective juices of your cunt and her cum, \"<i>I have filled her with a new purpose.</i>\"  She stares down at your sweat-stained body that tingles with the afterglow of sex.  \"<i>Now to the matter of her flesh.</i>\"");
	
	pc.orgasm();
	clearMenu();
	addButton(0,"Next",sandMotherBadEndsLadiesEpilogue);
}

//Epilogue:
public function sandMotherBadEndsLadiesEpilogue():void {
	clearOutput();
	output("The Champion awoke to a body changed. " + pc.mf("His","Her") + " body had been transformed in to that of a Sand Witch's.");
	//if player had six breasts
	if(pc.bRows() > 2) output("  Although unlike the other Sand Witches, this one sported extra breasts which she used to her utmost advantage.");
	//if player had gigantic breasts
	if(pc.biggestTitSize() >= 22) output("  She was unrivaled in her ability to produce milk thanks to the natural enormity of her breasts that her other sisters couldn't come close to.  They were so large that they often impeded her movement, which she admittedly didn't mind so much.");

	output("\n\nAs best as she could remember, her life had begun only a decade ago, aging quickly to become ready for service in her Sand Mother's coven at the age of five.  She'd been eager to give her milk and use her two wombs to breed as many new sisters as possible.");
	//if player had the broodmother perk
	if(pc.hasPerk("Brood Mother")) output("  She'd immediately shown a unique propensity for rapid pregnancies, birthing new sisters at twice the rate of any other Sand Witch.  Her surprisingly fertile wombs helped give an extra edge to the Sand Mother's plans.");
	
	//if player had broodmother and gigantic breasts
	if(pc.hasPerk("Brood Mother") && pc.biggestTitSize() >= 22) output("  As a result, the champion who could no longer remember her true past became little more than a giant pregnant belly surrounded by " + num2Text(pc.bRows()) + " breasts so massive that the other sand witches often used her tits as comfortable cushions to sit upon, their thighs tightly gripping each giant nipple against their aching cunts for pleasure.");
	
	output("\n\nTwo years later, at the call of the Great Mother, the sand witches went to war.  ");
	if(flags["COC.HEL_HARPY_QUEEN_DEFEATED"] != 1) output("Their harpy and phoenix allies allowed them to approach Lethice's fortress unhindered, and i");
	else output("I");
	output("n the bloodiest battle ever to take place on Mareth, the demons were defeated, wiped from the world in a blaze of white fire.  In the years that followed, the covens worked to undo all that had been wronged in the world. Many demons remained, but their influence was on the wane.  The world moved on, and those that remained wisely hid.");
	
	output("\n\nThe sand witches turned the deserts into a jungle paradise, and though they lacked the taint of corruption, they never stopped their policies of aggressively bringing in new blood.  Many were brainwashed into service, like the champion, but peace was brought to Mareth.  The unanswered question remains: is a world ruled by lusty milk witches any better than the 'corrupt' one that preceded it?");
	badEnd();
}


//Friendly Options
//(Alt(More complex options above): The Sand Mother sits atop her throne, smiling benevolently at you as you approach.  It appears you've made an ally.
//*Friendly Fuck (Optional?)
//>Fuck her friendly style.
public function friendlySandMotherFuck():void {
	clearOutput();
	sandWitchMotherShow();
	var x:int = pc.cockThatFits(enemy.vaginalCapacity());
	var y:int = pc.cockThatFits2(enemy.vaginalCapacity());
	//First Time:
	if(IncrementFlag("COC.TIMES_FRIENDLY_FUCKED_SAND_MOTHER", false) == 0) {
		output("Casting your gaze around to ensure privacy, you lower your brows conspiringly and inquire into the Sand Mother's love life.");
		
		output("\n\nThe Sand Mother blushes slightly, her hand idly fanning at her reddened cheek before pushing a strand of white-blonde hair out of her face.  She bites her lower lip nervously before admitting, \"<i>Not that it is any business of yours, Champion, but no, my duties are quite demanding.  I am much too busy to saddle myself with offspring, and the milkers provide all the... stimulation that I require.</i>\"  Her large nipples are slowly stiffening, lifting her silken robes away from her breasts as they erect needily.  You swear you can hear the liquid bounty sloshing around inside her immense orbs as she shifts position, crossing her legs, and then you smell the unmistakable aroma of an aroused woman.");
		
		output("\n\nLooking at her stiff, moist teats, you comment that she seems to have been left wanting in more ways than one.  She squirms visibly when she traces your gaze down to her breasts, and she gasps, \"<i>Why... I... I don't...</i>\"  Her glowing eyes flick towards your crotch, taking in the swelling bulge as you approach her throne.  She licks her lips without meaning to and disentangles an idle finger that had been twirling her shimmering hair.");
		output("\n\nShe sighs and admits, \"<i>I do... um... I do have some needs.  Perhaps a coupling would be beneficial after all.</i>\"");
	}
	//Repeat
	else {
		output("Casting your gaze around to ensure privacy, you lower your brows conspiringly and you ask if she'd like you to tend to her baser needs.  The Sand Mother looks at your crotch and licks at her lips, her nipples erecting her robes into stiff little tents.  She twirls a lock of hair around her finger and purrs, \"<i>Well, a little copulation to clear my head might be just what I need.</i>\"");
	}
	output("  The dark-skinned sorceress makes an arcane gesture, hand glowing with power, and a glowing blue rune spreads out around her belly-button, the intricate webs of illuminated tracery forming a hexagonal pattern that makes you dizzy just to look at.  \"<i>While I am the Sand Mother, I am not ready to be a mother just yet.</i>\"  The glow is already fading, vanishing as fast as it appeared.");
	
	output("\n\n\"<i>Undress,</i>\" she tuts, gesturing at your [pc.gear].");
	
	output("\n\nYou start to disrobe, watching and waiting for her to get naked as well, but she doesn't.  Sure, she's shifted position so that she's sitting on the edge of her throne, but she hasn't even slipped an arm out of the silky, masterfully crafted robe that she wears.  You teasingly ask her if she's planning to make you fuck her through her dress.");
	
	output("\n\nThe Sand Mother giggles, slowly lifting the hem of her vestments to expose her knees, smooth thighs, and the steamy delta between them.  Her feminine juices are already visible even from this far away, slowly dripping in sinuous streams to puddle beneath her, squishing softly under her bubble bottom when she shifts position under your lusty gaze.  The doubled pussies have four puffy lips peeking out through their vulvas, reddish and inflamed with ardor.  You can't quite see her clits, but the slight distortion of her hoods are visible, glistening softly.  You're sure a little stimulation would bring the sensitive buzzers out to play.");
	
	output("\n\n\"<i>Surely you don't mind servicing me while I rule from my throne?</i>\" the Sand Mother asks, tugging the robe up high enough that it will be out of the way, the fabric bunched up around her hips and behind her.  One hand traces in lazy circles around her puffy, large nipple, and milk answers almost immediately, steadily trickling down her many breasts.  The other three grow moist as they begin to sympathetically lactate, soon turning her top into a wet, warm mess.  Her cheeks are blushing as deeply as a dark-skinned woman's can.  Gasping, she pleads, \"<i>Come take me, Champion.  I need it.  I need you inside me!</i>\"  The last word comes out half as a moan, her fingers pinching down on her nipple hard enough to send a spout of milk in a wet spray in front of her throne.");
	
	output("\n\nFeeling more than a little ready yourself, you step up to her, ");
	if(!pc.isTaur()) {
		output("holding [oneCock] in ");
		if(y >= 0) output("one");
		else output("your");
		output(" hand");
		if(y >= 0) output(" and another in the other");
		output(", the meaty cock-flesh wobbling, veins pulsing just under the surface as you nose ");
		if(y < 0) output("it");
		else output("them");
		output(" up against the twin, wet pussies.");
	}
	else {
		output("dick");
		if(y >= 0) output("s");
		output(" bobbing under your equine belly, the meaty cock-flesh wobbling with veins pulsing just under the surface as ");
		if(y < 0) output("it noses");
		else output("they nose");
		output(" up against the twin, wet pussies.");
	}
	if(pc.tallness >= 90) output("  You have to kneel down to make it work, tall as you are.  ");
	else if(pc.tallness <= 48) output("  You can barely reach her cunt standing, short as you are.  ");
	output("Her lube-glossed gates spread around your " + pc.cockHead(x));
	if(y >= 0) output(" and other cock-tip");
	output(", the hot moisture gobbling up your inches, clinging hot and wet to the oversensitive, pulsating dick");
	if(y >= 0) output("s");
	output(".  The large woman sighs with relief as you scratch her unspoken, hidden itch.  Your [pc.hips] push forward with such fervor that you doubt you could stop if you wanted, pressing hard on her sensitive, innermost folds with ");
	if(y >= 0) output("both your cocks");
	else output("your " + pc.cockDescript(x));
	output(".");
			   
	//HOARSES:
	if(pc.isTaur()) {
		output("\n\nWhinnying in delight, you rest your forelegs on ");
		if(pc.tallness < 78) output("her shoulders");
		else output("the top of her throne");
		output(" and thrust, pumping yourself hard into her with animalistic delight.  The Sand Mother shudders beneath your bestial bulk as her hands begin to tug at her nipples through her soaked, not-so-concealing robes.  She whimpers and begins to kiss at your human abdomen, tonguing your belly button as she's mounted on your bitch-breaking erection");
		if(y >= 0) output("s");
		output(".  Grabbing a lock of platinum in your fingers, you keep a firm hold on her while you let your lower half's inhuman ardor take control of your body.");
	}
	//NOTAHOARSE:
	else {
		output("\n\nGroaning in delight, you rest your hands on her ");
		if(pc.tallness < 60) output("bottom tits");
		else if(pc.tallness < 84) output("top tits");
		else output("shoulders");
		output(" and thrust, powerfully pumping your manhood through her lube-gilded channel");
		if(y >= 0) output("s");
		output(".  The Sand Mother shudders before you, hands tugging her nipples through her soaked, not-so-concealing robes.  She's whimpering needily, and ");
		if(pc.tallness < 72) output("you kiss her to silence her, tongue pumping to the same timing that drives your hips.");
		else output("you suckle one of the heavy, milk-laden tits to enhance her pleasure");
		output(".  Her fingers roam through your " + pc.hairDescript() + " as she allows her passion to overwhelm her.  Splattering noisily, her juices are dripping and squirting around your hard-thrusting dong");
		if(y >= 0) output("s");
		output(", replaced by fresh secretions as fast as you squeeze them out of her.");
	}
	
	//Both
	output("\n\nYou groan as the suckling heat around your rod");
	if(y >= 0) output("s");
	output(" lurches into convulsions, too hot, tight, and sensuous for you to endure.  For a moment, you try your damnedest to hold out, to ride the wave of pleasure for another few minutes before you release into the agonizingly sweet puss");
	if(y < 0) output("y");
	else output("ies");
	output(".");
	if(pc.hasVagina()) {
		output("  Your own [pc.vagina] quivers weakly, insides grinding against insides, squeezing every drop of juice from your ");
		if(pc.wetness() >= 4) output("squirting ");
		output("passage.");
	}
	if(pc.lactationQ() >= 200) {
		output("  Escaping from your [pc.nipples], milk ");
		if(pc.lactationQ() < 200) output("leaks");
		else if(pc.lactationQ() < 1000) output("drips");
		else output("erupts");
		output(", splattering the throne with a fresh, lactic offering.  If you weren't mindlessly jamming yourself into her cunt, you'd wonder if she approves of your offering, but every neuron is busy sending your body to a mind-blowing climax.");
	}
	output("  You grunt as the heat inside your clenching [pc.balls] radiates through your groin and towards [pc.EachCock].");
	//Newline
	output("\n\n");
	//More than 2 dongs or one doesn't fit
	if(pc.cockTotal() > 2 || (pc.cockTotal() == 2 && y < 0)) {
		output("White love-batter fires in thick ropes onto her robes from your unbound penis");
		if(pc.cockTotal() > 3 || (pc.cockTotal() == 3 && y < 0)) output("es");
		output(".  One after another, the syrupy strands mix in with the dripping milk to make an alabaster drapery of sex-juice.  ");
	}
	//light ejaculate
	if(pc.cumQ() < 250) {
		output("You spend your passion in numerous spurts, firing straight into the deepest depths of the Sand Mother's pussy.  Her slick walls squeeze you repeatedly, pulling you further inside, caressing you to encourage your orgasm to gift her with greater quantities of jism. As you continue to spurt, you realize that her hungry cunt");
		if(y >= 0) output("s are");
		else output(" is");
		output(" successful in some capacity, because you squirt until it's almost painful, finishing with ");
		if(y < 0) output("a fat white drop that's squeezed from your tip");
		else output("fat white drops that are squeezed from your tips");
		output(".");
	}
	//medium ejaculate
	else if(pc.cumQ() < 1000) {
		output("You spend your passion in heavy flows of fuck-batter.  Each lance of semen slides into the deepest depths of the Sand Mother's pussy where it can baste her sensitive tunnel and yielding cervix with thick jism.  Her sperm-gilded walls continue to squeeze you, encouraging you to give her even greater levels of virile juices, and you have no problem meeting that demand.  Your eyes roll partway back as your body rides out the unnaturally-long orgasm, unwilling to stop cumming until you feel drained and dry.  Goop is leaking out from her oozing, well-fucked lips in fat blobs.");
	}
	//high ejaculate
	else {
		output("You spend your passion in fountaining eruptions of jizz, the first one more than big enough to glaze the deepest depths of the Sand Mother's pussy.  The pressure from the second cumsplosion is enough to send your fuck-batter through her cervix, deep into her womb, and back out through her quivering cunt-lips in a drippy spunk-leak.  Her nethers squeeze emphatically around you in a way that encourages you to fill her fuller, the squeezing walls pulling you so deeply inside her that your next squirt");
		if(y >= 0) output("s go");
		else output(" goes");
		output(" straight into her womb");
		if(y >= 0) output("s");
		output(", rounding her belly to pregnant proportions.  She moans as she's filled beyond capacity with cum, only getting relief when the pressure in her packed womb");
		if(y >= 0) output("s grow");
		else output(" grows");
		output(" so high that jets of spooge spray out around you.  That doesn't stop you - you keep forcing more thick ejaculate into her until she's a nonsensical, babbling mess and you're totally spent.");
	}
	//END
	output("\n\nSeparating from her produces sensations so strong that your [pc.legs] nearly fold underneath you, peaking along with a wet 'schluuuuck'.  You stagger back, panting for breath as you admire the creampied prize ahead.  The Sand Mother is a panting, milky mess that's wallowing in a puddle of her own cum.  After a few moments, she stops fondling herself and moaning, gradually lowering the hem of her stained robe as a content, blissful expression settles on her face.");
	output("\n\n\"<i>Thank you, Champion.  Perhaps you wouldn't mind helping me again with this some time in the future...</i>\"");
	IncrementFlag("COC.TIMES_FRIENDLY_FUCKED_SAND_MOTHER");
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}

//*Friendly Milk-Ride (Optional?)
//>Lesbo milk-filling
public function lesboMilkFilling():void {
	clearOutput();
	
	IncrementFlag("kFLAGS.TIMES_FRIENDLY_FUCKED_SAND_MOTHER");
	//First Time:
	if(flags["COC.TIMES_FRIENDLY_FUCKED_SAND_MOTHER"] == 1) {
		output("Casting your gaze around to ensure privacy, you lower your brows conspiringly and inquire into the Sand Mother's love life.");
		output("\n\nThe Sand Mother blushes slightly, her hand idly fanning at her reddened cheek before pushing a strand of white-blonde hair out of her face.  She bites her lower lip nervously before admitting, \"<i>Not that it is any business of yours, Champion, but no, my duties are quite demanding.  I am much too busy to saddle myself with offspring, and the milkers provide all the... stimulation that I require.</i>\"  Her large nipples are slowly stiffening, lifting her silken robes away from her breasts as they erect needily.  You swear you can hear the liquid bounty sloshing around inside her immense orbs as she shifts position, crossing her legs, and then you smell the unmistakable aroma of an aroused woman.");
		output("\n\nLooking at her stiff, moist teats, you comment that she seems to have been left wanting in more ways than one.  She squirms visibly when she traces your gaze down to her breasts and she gasps, \"<i>Why... I... I don't...</i>\"  Her glowing eyes flick towards your [pc.chest], eying your supple form as you approach her throne.  She licks her lips without meaning to and disentangles an idle finger that had been twirling her shimmering hair.");
		output("\n\nShe sighs and admits, \"<i>I do... um... I do have some needs.  Perhaps a coupling would be beneficial after all.</i>\"");
	}
	//Repeat:
	else {
		output("Casting your gaze around to ensure privacy, you lower your brows conspiringly and you ask if she'd like you to tend to her baser needs.  The Sand Mother looks at your crotch and licks at her lips, her nipples erecting her robes into stiff little tents.  She twirls a lock of hair around her finger and purrs, \"<i>Well, a little copulation to clear my head might be just what I need.</i>\"");
	}
	//BOTH
	output("\n\nAllowing an eager, pleased expression to occupy your " + pc.face() + ", you peel the top of your armor down to expose your [pc.chest] and [pc.nipples], heaving with your excited, eager inhalations.  The Sand Mother watches you with a lecherous expression as she opens the top half of her robe.  Her four areolae are huge and moist with her creamy drippings, the pebbly texture shining dully in the unnatural light as fresh liquid beads on her enormous, lust-tightened nipples.  Shimmying out of your bottoms, you stretch your hands up high over your head and arch your back");
	if(pc.biggestTitSize() >= 10) output(", [pc.fullChest] swaying enticingly as you strike your seductive pose");
	output(".   Freeing your body from its bindings is almost as exciting as seducing the queen of the lactic sorceresses, and you ");
	if(pc.biggestTitSize() >= 2) output("cup your mammaries");
	else output("run your hands down your chest");
	output(" as you stride closer.");
	
	output("\n\n\"<i>Oh by the Great Mother,</i>\" the tanned spellcaster coos, \"<i>Come here...  I have all this milk pent up and a good idea where I can put it.</i>\"  She winks and grabs one of her teats around the base, expressing a thin stream of milk as she forces more into her bulging, three-inch long nipples.  Crooking a finger in your direction, she lifts the bottom of her robe and allows her free fingers to casually stroke across her swollen, sticky mons.  The Sand Mother whimpers softly as she begins to pleasure herself, but her eyes remain fixed on you, promising seductive pleasure and a thorough milk-filling.");
	
	//HOARSE
	if(pc.isTaur()) {
		output("\n\nPrancing up to her, you make to take a drink of her nipple, but she diverts the dribbling spout aside at the last moment.  \"<i>Tut tut, naughty [pc.boyGirl].  I didn't mean for you to drink it,</i>\" she says with a smile.  Her hand affectionately strokes your cheek, imploring you to turn, and you do, sudden realization hitting you - she's going to put her nipple in your [pc.vagina]!  Backing up, you push your equine hindquarters as close as you can.  Your hind legs bump into her knees and her throne, arresting your movement, but that's more than close enough to feel the heat of her pebbly, soaked skin pressing against your labia and even your [pc.clit].");
	}
	//NOT A HORSE
	else {
		output("\n\nClosing in on her, you make to take a drink of her nipple, but she diverts it away at the last moment.  \"<i>Tut tut, naughty [pc.boyGirl].  I didn't mean for you to drink my milk,</i>\" she says with a smile.  Her hand affectionately strokes your hip, leaving you to mull on that until she pries her lusty digits from her sticky box, diverting them to your own [pc.vagina].  She spreads your labia apart to reveal the glistening, inner slit, thumbing across your [pc.clit] as she lets the implication set in - she wants to fuck you with her nipple!  Releasing your achingly sensitive folds, she grabs hold of you by the [pc.hips] and lifts, smearing the mixed love-juice across your right side as she does.  She's amazingly strong, even for an eight-foot tall woman");
		if(pc.tallness > 72 || pc.isTaur()) output(", though judging by the glow around her hands, she used some magic to help");
		output(".  Sliding enticingly across your nethers, her pebbly, soaked tip drags perfectly up against your [pc.clit], just waiting to be jammed home and begin inseminating you with milk.");
	}
	//Both
	output("\n\nYou bite your own lip, trying to stifle a moan of delight when she presses herself harder against you, that remarkably firm nipple sliding inside you with only the slightest token of resistance.  It's so slippery with dribbling milk and your hot secretions that you almost wonder if she could press her whole, sordid breast inside you, but you know that's impossible.  Instinctively, you push back against the welcome, heated pressure, grinding your twat hard on her textured tit-skin.  Warm fluid rushes into your channel almost immediately, thicker and more copious than a minotaur's seed.  Some of it even squirts into your womb, while a few stray trickles leak out, dripping over your vulva and onto the creamy, chocolate skinned woman you're riding.");
	//CuntChange 3
	pc.cuntChange(0,3,true,true,false);
	
	output("\n\nYou ");
	if(pc.isTaur()) output("squeeze your own [pc.nipples]");
	else output("grab hold of her head");
	output(" as you begin to pull away and thrust back, languidly fucking yourself on her gushing spout while it floods your pouty, dripping pussy and eager womb with lactic moisture.");
	if(!pc.isTaur()) output("  Somehow, she's able to pull her hand away from your hip while still holding you aloft.  A glowing, arm-shaped silhouette remains, even as she diverts her attention elsewhere.");
	output("  'Schluck-schluck-schluck.'  You can hear her pushing her fingers deep into her neglected womanhoods, and judging by the doubled, wet sounds of penetration, she must be jamming two fingers in her doubled cunts.");
	output("\n\n\"<i>Ooohh yes, Champion, this IS what I needed,</i>\" she purrs, accompanied by the lewd sounds of her own self-pleasure.  A second, three-inch, mock-phallus starts to prod at your milky slit along with its brother, and with a pleasured moan, you feel it slide inside, stretching you twice as wide and wet.  Alternating back and forth, hot jets of alabaster cream lance deep inside you, one after another.  You can see the witch using her free hand to compress her breasts in turn, milking her gushing, over-productive breasts again and again.  ");
	if(pc.isPregnant()) output("Your poor womb is flooding with the stuff.  It's getting so full that you're starting to feel like you should be labelled 'cream-filled', and a tiny bump has begun to swell on your midsection in response.");
	else output("Your poor pregnant womb is battered with the stuff, but since you're already full, jets of hot cream are spraying out from your [pc.vagina] around nipple-shaped milk-injectors.");
	//CuntChange 6
	pc.cuntChange(0,6,true,true,false);
	output("\n\n\"<i>Yesssss,</i>\" you find yourself hissing, ");
	if(pc.isTaur()) output("wishing you could rub your swollen belly");
	else output("rubbing your swollen belly");
	output(".  Your [pc.vagina] feels like a living, breathing thing, taking in milk and producing nothing but lightning bolts of soul-filling pleasure.  Wracked by the erotic sensations, you shudder atop the Sand Mother, helplessly rutting her nipples.  She squeezes a third up against you, but fails to find purchase in your stuffed slit.  The extra teat merely hoses down your entrance, sloppily pressing itself against every moist, sexually-soaked fold.  Convulsing, your [pc.vagina] spasms, pulling the tit-tips deeper into itself, and just when it relaxes in between suctioning compressions, the third one finds purchase, disappearing into your slavering honeypot in an explosion of white fluid.");
	//Cuntchange 9
	pc.cuntChange(0,9,true,true,false);
	output("\n\nThe Sand Mother gasps, \"<i>So good.  How's the milk, Champion?  Is it good?  Your pussy is slurping it down so well!</i>\"");
	output("\n\nIt IS good.  You nod to her, noting the way her tongue is lolling out and the rapidly increasing pace of her mastubatory noises.  She's going to cum soon and probably fountain from her nipples just as hard as she will from her two twats.  Your thoughts are interrupted by a sudden intrusion in your packed delta - is that... is that a FOURTH nipple inside you?  The answering injection of cream confirms what your startled consciousness is struggling to come to terms with.  Four nipples are spraying almost continually into you.  Gods, you're getting so full!  ");
	if(pc.isPregnant()) output("You can feel your midsection going round, wobbling wildly.  POP!  Your belly-button has turned into an outie, accompanied by a wobbling, comforting weight inside you.  Four months... five, no - six... you give up on counting, but with every second that passes, you're getting bigger and bigger, visually matching any of the pregnant women you saw growing up.");
	else output("You can feel it fountaining out of you, backwashing out to splatter the witch with wetness, her skin going glossy under the tide of white.  If you weren't already pregnant, you'd probably be ballooning up with her lactic cargo, a rounded, milk-filled cream-balloon.");
	
	output("\n\n\"<i>Ungh, uhh... gonna c-c-u-uuuhhhhhhh!</i>\" the Sand Mother babbles, splattering wetness from her pussies onto your [pc.butt] in a shower of girl-goo.  She screeches, \"<i>FUCK YES!  SO GOOD!</i>\" before shutting down.  with her four tits cradled in her arm, she squeezes all of them at once, and you you're suddenly stuffed with what feels like gallons of gushing pleasure.  Your body was climbing towards orgasm already, but the explosive injection is just too potent for your ecstatic, quivering pussy-lips to endure.  You groan as orgasmic heat radiates through you, culminating in a cunt-clenching squeeze so strong that the nipples are forced to empty inside you a moment before they're popped out.  A milky creampie drips down your [pc.legs] as your twitching [pc.butt] falls into the witch's lap, leaking all over her.");
	output("\n\nThe sorceress queen dips her fingers into your milky snatch and gathers up a handful of the oozing sexjuice.  She brings it to her lips, humming in pleasure at the taste before she shares it with you.  You're too wrapped in ecstasy to care, and lewdly lick everything from her palm whenever she brings it to your lips, and she does, again and again.");
	
	output("\n\nSighing, you eventually disentangle yourself from the satisfied enchantress, but not before giving her a long, wet kiss.");
	output("\n\n\"<i>Perhaps we can tend to our needs the next time they get out of hand,</i>\" she suggests.  Yes, you just might have to. ");
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}
	
//*History
//>Learn about the origin of the sand witches.
public function sandWitchHistory():void {
	clearOutput();
	output("You inquire about the history of the sand witches, and how they came to be.  The Sand Mother gives you a benign smile and offers, \"<i>With pleasure.  It is so rare that I get to recount the story to one not of our order.</i>\"  She utters a few spidery words that seem to ring in your ears, and a luminous, floating illusion appears before her, all floating shapeless colors.  As she begins to talk, the blobs shift into the actors in her tale, allowing you to view the story as it happens.");
	
	output("\n\n\"<i>A little over a score of years in the past, Mareth was a different place.  The desert was a tiny fraction of its current size, and tribes of all sizes and descriptions were settled all over.  In some places, it would be difficult to walk anywhere without stumbling into some town, trading post, or village.  A small city of human mages had sprung up atop the mountain, the descendants of settlers from ages past.  From this stock, both Sand Witches and demons were born.</i>\"  The Sand Mother frowns as if she's swallowing a sour grape, clearly upset at sharing ancestry with such a repugnant foe.");
	output("\n\nIntrigued, you ask exactly how the two human factions came into being, and why these women wound up with doubled chests.  The Sand Mother nods and continues, \"<i>A worthy question, to be sure.  Details of the great fall are hazy, of course, but my mother, the Great Mother and some of my older sisters lived through it.  I have yet to pry a detailed account from one of them.  I do know that the fall was hailed as a discovery of immortality and immense magical power all in one.  Within the span of a few hours, most had gleefully abandoned their souls in exchange for additional power and freedom from the tyranny of old age.  The Great Mother did not.</i>\"");
	output("\n\nChuckling happily, the blue-eyed storyteller gleefully recounts, \"<i>She sent her daughters away when she saw how it changed her beloved, and she refrained from joining in on the debauchery, promising the newborn demons that she would join them once she was sure there were no drawbacks.  Back then, they were jubilant in their newfound power, and did not greatly care if a few fools took their time in coming to join them.  After all, they offered pleasure and power unending, who could resist?  My mother took advantage of this lapse to study their characteristics and magics, taking the knowledge with her when she fled.  She vanished into the trackless sands, with the wind to mask her family's passage through the dunes.  Once there, she changed her body using their black sorceries in order to provide for herself.  Her abilities molded the earth itself into a home, and the Sand Mother began to refine her craft, teaching her daughters all she knew.</i>\"");
	
	output("\n\nIntriguing.  So twenty years ago a mother and her daughters fled the newborn demons, and they've bred fast enough to be an army now?  It boggles the mind, and you say as much.");
	
	output("\n\n\"<i>Oh, I know, it sounds like a lot of inbreeding happened in a hurry, but that wasn't the case.  There were other dissidents that we sought out, though there weren't many of us.  They came to see things from Mother's perspective soon enough.  She can be... quite persuasive,</i>\" the regal witch says, her eyes taking on a far away cast.  She shivers and resumes, \"<i>In addition, portals had begun to open all over the world.  New people trickled in from most of them, and we saved those we could.  The first coven was bursting to capacity in two years time, and we were suitably diverse enough to begin breeding in earnest.</i>\"");
	
	output("\n\nA hand unconsciously dips to a smooth middle as the witch continues her tale, \"<i>A few of our number were chosen to become Cum Witches, the bearers of fertility for our tribe.  They learned magics of fertility and reproduction that allowed us to birth and mature with alarming rapidity.  The rest of us were to be vessels or gatherers, adding to our numbers by any means necessary.  Eventually, it was deemed wise that we split our numbers, and the second coven was born.  We spread like wildfire after that, breeding, hiding, and recruiting all that we could.  Of course, any demons we found were disposed of.</i>\"");
	
	output("\n\nWell, you suppose that kind of makes sense, but how did the witches resist corruption?");
	
	output("\n\nLaughing, the Sand Mother explains, \"<i>That one is easier than you would think.  The great bees of Mareth are highly resistant to corruption, to the point that their pure, undiluted honey actively combats it.  With proper treatment, the amber ambrosia can be distilled into a form that will not transform the imbiber but will still remove corruption from one's form.  We pursued a trading relationship with the bees, serving as incubators in exchange for honey.  It's a small indignity to suffer in exchange for maintaining sanity.  Sadly, our contacts with the fertile caste have gone silent, and we fear something may have happened to the hive.  We have enough ambrosia stockpiled for our own needs, but we must be careful how we ration it.</i>\"");
	
	output("\n\nNodding, you ask if they would be willing to distill any pure honey you would bring in for your uses.  The Sand Mother answers, \"<i>Of course.</i>\"  She inclines her head and finishes, \"<i>There is not much more to tell.  We grew, we spread, and there are many Sand Mothers now.  The demons took a coven or two, but our decentralized nature protected us.  We routinely wipe out patrols foolish enough to come hunting us, but that doesn't seem to stop them.  Was there something else you wanted, [pc.name]?</i>\"");
	
	sandWitchMotherFriendlyMenu();
}

//*Current State
//>Learn about the current state of the sand witches and their plans
public function currentStateOfInterwebs():void {
	clearOutput();
	output("You inquire as to the current state of the sand witches, and this coven in particular. The Queen Witch's brow creases in thought as she considers your request, tapping her chin and gazing into the intricate, swirling lights above.");
	
	output("\n\n\"<i>I suppose I would say that our situation is good, on the whole,</i>\" she admits, \"<i>We do not lack for nourishment, thanks to our magics.  Our caves shield us from the worst sandstorms and ensure we are never too cold or warm.  And until recently, we believed our dwellings to be well hidden and secure.</i>\"  The Sand Mother gives you a wry look and a knowing sigh.  \"<i>We both know we were wrong to think so.  Still, our defenses have not been breached by an agent of corruption yet, and this experience will give my sisters and I plenty to consider.  Better you broke down the front door than the Demon Queen's armies.</i>\"");
	
	output("\n\nGently adjusting herself on her throne, the sorceress recounts, \"<i>We are many, and the cum witch's magics only continue to swell our numbers.  Accelerated growth was one of the first things the great Mother pioneered, so it only takes a few years for a new witch to mature to adulthood and swell our numbers.  Goblins and imps outbreed us by a wide margin, but that's to be expected.</i>\"  A proud smile graces the Sand Mother's face as she brags, \"<i>Between the covens I know of, we should have the numbers to challenge the demons in a head-on assault in a year or two.</i>\"");
	output("\n\nReally?  That is quite a mighty force indeed!");
	output("\n\nThe dusky matriarch grins wolfishly as she says, \"<i>Really.  We have not been idle while corruption rises across the lands.  The Great Mother wisely set us upon this path, gathering us, moulding us, and grooming us for the time when we would resurface as saviors.  ");
	if(flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined) output("All that remains is to ready those still maturing and wait on our allies to finish growing their numbers.  We shall be carried into the Demon Queen's fortress on the wings of phoenixes, to fight as glorious a battle as has ever been fought!");
	else output("All that remains is for us to find new aerial allies or a method of easy, sustained flight.  The phoenixes were smashed apart by fiery demons, their lair raided and destroyed by an interloper.  If only things had been different... Calais was so close.");
	output("</i>\"");
	
	output("\n\nYou raise the question of their suitability for battle with the demons.  After all, when you encounter sand witches, they don't seem overly deadly.");
	
	output("\n\n\"<i>Hah!  That's an understandable conclusion, but ultimately they aren't trying to kill you, they're trying to recruit you.  Do you realize how much control it takes to form a flawless sphere of stone and vibrate it inside someone without causing harm?  Forming a vortex of flesh-rending sand is child's play next to that.  Hurling boulders with peerless precision barely stretches our mental muscles.  Trust me, when it comes to battle magics, we can match the abilities of the demons,</i>\" she assures you with a knowing smile.");
	
	output("\n\n\"<i>So there you have it, [pc.name].  We are mighty, we are somewhat secure, and if we can continue our plans, we may yet save Mareth.");
	if(flags["COC.HEL_HARPY_QUEEN_DEFEATED"] > 0) output("  Of course, this is all contingent on us finding an ally that can breach the mountaintop citadel's walls.");
	output("  Was there something else you needed to ask about?</i>\"");
	//[friendly options]
	sandWitchMotherFriendlyMenu();
}

//*Cum Witches
//(Requires met cum witch or had history chat)
//>Ask about the role of cum witches in the covens.
public function discussCumWitches():void {
	clearOutput();
	output("You inquire as to why they have cum witches.");
	output("\n\n\"<i>Oh, the Cum Witches?  Well, that order arose out of need rather than desire.  We needed to procreate, and just any old male would not suffice.  The Great Mother needed something beyond the ability of a normal human male - a body that knows what it is to be a woman combined with almost limitless virility and carefully engineered seed that would swell our numbers with exactly what we need.  She had learned how to shape bodies to her whims, so forming a phallus and specialized, high output gonads was something easily done.</i>\"");
	
	output("\n\nThe Sand Mother blushes a bit at this, fidgeting nervously in her chair.  With your curiosity piqued, you ask her, \"<i>Well, how are they chosen?</i>\"");
	
	output("\n\n\"<i>It's, errr... a rather grueling process.  The Sand Mother of the coven will judge when more cum witches are needed, and the selection process will begin.  Because the position of cum witch is rather... demanding physically, all who wish to become a cum witch must prove themselves capable of enduring the delivery of their duties.  To this end, the candidates are placed in a room to pleasure each other until fatigue takes its toll and all but one are unable to continue.  Being selected as a cum witch is being confirmed as a nymphomaniac by trial of sex, for the common good of course,</i>\" the bronzed queen recounts with a wistful smile.");
	
	output("\n\nIt sounds rather grueling");
	if(pc.cor() + pc.libido() > 100) output(", though potentially fun");
	output(".  With a little bit of a lecherous smile, you ask if she ever tried out for it.");
	
	output("\n\nThe Sand Mother grimaces, but blushes darker, \"<i>Yes, before I had a coven of my own, I tried out for that position as well.  I was young and foolish, believing it a position of power and glory.  Doubtless those who hold the station believe it so, but I see it for what it is now.  Slavery.  Slavery to the thrumming heat of one's own body and constant service of her sisters.  Sand witches can go free to roam the deserts, scouting or hunting for recruits.  Cum witches?  They fuck.  And fuck.  And fuck.  Their only real respite is studying magic, something they have little enough time for as is.</i>\"  Smiling ruefully, she admits, \"<i>I'm glad I did not become a cum witch.  I was allowed to become something more, and perhaps some day, I shall inherit my mother's mantle, to rule over a free Mareth.</i>\"");
	clearMenu();
	if(flags["COC.MORE_CUM_WITCHES"] == 1) {
		output("\n\nYou already convinced her to add more cum witches to her harem so that they might experience a little freedom.");
		if(flags["COC.CUM_WITCHES_FIGHTABLE"] != 1) {
			output("  If you asked her to send them out hunting for recruits, you could potentially fight and fuck them in the deserts sands in the future.");
			addButton(0,"Send Out",sendOutCumWitch, null, "Send Them Out", "Request the Sand Mother to send the Cum Witch out in search for new recruits.");
		}
		else {
			output("Many of them are prowling the desert sands even now, hunting for recruits.  You could wind up having to fight them if you go out.  It's possible she might keep them away from you, if you request it.");
			addButton(0,"KeepThemIn",keepCumWitchesIn, null, "Keep Them In", "Request the Sand Mother to keep the Cum Witch out of your way.");
		}
	}
	else {
		output("\n\nYou could ask her to bolster their numbers, allowing them some free time for a change, if you wanted to better their situation.");
		addButton(0,"Bolster Them",moreCumWitchesPlease, null, "Bolster Them", "Ask if the coven could bolster a few more Cum Witches.");
	}
	//[Send Them Out] [Back]
	//[Keep Them In] [Back]
	//[Bolster Numbers] [Back]
	addButton(4, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}

//Send them out:
public function sendOutCumWitch():void {
	clearOutput();
	output("You request she put the cum witches' boundless virility and desire to work for the coven, letting some of them out to venture the sands in search of new recruits.  (<b>From now on, there's a chance you'll encounter cum witches in the desert.</b>)");
	flags["COC.CUM_WITCHES_FIGHTABLE"] = 1;
	sendOutOrKeepInEnding();
}
//Keep Them In:
public function keepCumWitchesIn():void {
	clearOutput();
	output("You request she put a hold on sending out the cum witches.  Their aggressive, sexual recruitment methods are getting in your way, and for now, it would be best if they were out of your way.");
	flags["COC.CUM_WITCHES_FIGHTABLE"] = 0;
	sendOutOrKeepInEnding();
}

public function sendOutOrKeepInEnding():void {
	output("\n\nThe Sand Mother nods and graciously answers, \"<i>Very well.  I will honor your request, for now.  I cannot speak for the other covens, but you are unlikely to stray into their territory.  When our time of ascendance comes, do not expect me to honor your requests so freely.  We will stop the Demon Queen however we must, regardless of your wishes.</i>\"");
	clearMenu();
	addButton(0, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}

//Bolster Numbers:
public function moreCumWitchesPlease():void {
	clearOutput();
	//Bimbo version:
	if(pc.isBimbo()) {
		output("Wouldn't it be better if there were like, lots of cum witches, with yummy cocks that you could suck?");
		output("\n\n\"<i>No, it wouldn't,</i>\" the Sand Mother retorts, ending the conversation.");
		clearMenu();
		addButton(0, "Next", function():*{
			setEnemy(null);
			clearMenu();
			mainGameMenu();
		});
	}
	output("You ask her if it wouldn't be more humane to simply create a few more cum witches, allowing them to split their duties and actually have time to serve in other ways, either as normal sisters or perhaps helping with the recruitment.");
	output("\n\n\"<i>Doing so would reduce milk production and our breeding population somewhat,</i>\" the Dune Mother protests.  \"<i>We have done things this way for nearly two decades... it is the most efficient way.</i>\"");
	output("\n\nIt may be the most efficient way, but reducing someone in her charge to little more than a sex slave (even if it is a happy one) does not exactly make her compare favorably to the very demons she fights.");
	output("\n\nRocking back in her throne, the chocolate-hued matriarch considers your words with a flabbergasted expression.  \"<i>I never thought of it that way,</i>\" she says, stroking her chin as she mulls it over.  \"<i>Would they even want to, that's the real question.  Our cum witch seems to take a perverse pride in her work.</i>\"");
	output("\n\nWell, it wouldn't hurt to ask, right?");
	
	output("\n\nThe Sand Mother nods at that, visibly moved by your arguments.  She calls for her Cum Witch, who arrives in a hurry, soaked in sweat and her own cum.");
	
	output("\n\n\"<i>My lady, have you decided to bear a child of your own?</i>\" the ebony hermaphrodite questions.");
	
	output("\n\nSmiling serenely, the coven leader answers, \"<i>No, no my dear.  [pc.name] here had an idea.  " + pc.mf("He","She") + " suggested we add to your ranks, to give you more time to help the coven in ways besides reproduction.  Perhaps through magic, or even going out to patrol and recruit newcomers.  Would you have sisters to free up some of your time, or remain the only one to fill your sisters' wombs?</i>\"");
	
	output("\n\nGrinning devilishly the Cum Witch replies, \"<i>Oh, mother, that would be splendid.  With more cum witches, I would have time to further research the blessings that speed our youngs' growth.  Better still, I would get to teach my new sisters what it means to be a member of my order... first hand.</i>\"  She visibly quivers with excitement, a string of clear drool hanging from the tip of her visibly erect, pulsing erection.");
	
	output("\n\n\"<i>I see...  Well, I shall announce the trials at once, and before the day is out, you will have a few new sisters,</i>\" the Queen Witch proclaims, waving her hand to dismiss you both.");
	
	output("\n\n(<b>This coven now has numerous cum witches.  You can talk to the Sand Mother again and ask her to send them out in search of recruits if you want the chance to fight them in the future.</b>)");
	flags["COC.MORE_CUM_WITCHES"] = 1;
	sandWitchMotherFriendlyMenu();
	//Send them out, or back
}
	
//*Pick Mothers
//>Ask about how Sand Mothers are chosen.
public function askHowSandMothersAreChosen():void {
	clearOutput();
	output("You ask the Sand Mother how her people choose who will be a Sand Mother of a new coven.");
	
	output("\n\nThe statuesque woman smirks ruefully, \"<i>Politics, of course.</i>\"  Politics?  She sees the confused look on your face and explains, \"<i>It shouldn't surprise you.  You");
	if(pc.race() == "human") output("'re a human");
	else output(" were a human");
	output(".  Our people are notorious for forming gangs and cliques, groups focused around a leader's charisma.  It's only natural that has continued in Mareth.  It would not surprise me to learn that even the demons have their own factions and political malcontents, though I imagine they deal with them far more harshly than we.</i>\"");
	
	output("\n\nWaving her arm nonchalantly, the Sand Mother says, \"<i>When a coven grows a bit too big, the Sand Mother will announce the creation of a new coven.  Typically at this point, the more adventurous and ambitious witches will begin gathering the like-minded to their side, and they'll all try to curry favor with their Sand Mother in an attempt to secure the ascension of their chosen leader.</i>\"  She steeples her fingers before interlacing them.  \"<i>It doesn't always work out, even for the most popular groups.  Ultimately, it's up to the Great Mother or the Sand Mother's decision, and sometimes, she'll simply choose a favored daughter.</i>\"");
	output("\n\nWouldn't that result in anger from a potentially powerful rival?  You voice your query.");
	
	output("\n\n\"<i>Oh, that's a certainty.  However, discontent is not something that can be allowed to fester.  A few months being lavished with a cum witch's attentions and birthing fresh young has a way of smoothing out political differences.  In some ways, we are like the ant-girls of this world.  We must work together for the greater good, or we will fall.  Everyone has a place,</i>\" she declares perhaps a bit too proudly.");
	
	output("\n\nRubbing your chin in thought, you thank her for the information and mull over their strange practices.  They've given up every most personal agency and freedoms in exchange for a stronger, more cohesive whole.  You aren't so sure it's a great idea, but you have no alternative to offer.");
	//friendly menu
	sandWitchMotherFriendlyMenu();
}
//*Leave Alone/Send Lackeys
//>Request sand witches stop or start attacking you.
public function leaveAloneSendLackeysToggle():void {
	clearOutput();
	//Leave Alone
	if(flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] != 1) {
		output("You request that the scouts in the desert stop bothering you with their barbed offers of magic.  Fighting them is not something you want to have to do.  It's a waste of effort on both sides you that feel should come to an end.");
		output("\n\nThe Sand Mother's tanned visage remains impassive as she digests your request.  The silence is almost palpable, and the longer it stretches out, the more you wonder if you've committed some kind of faux pas.");
		output("\n\n\"<i>Fine,</i>\" she states with brevity so sharp it slightly startles you.  Her incandescent eyes fix your own as she continues, \"<i>My girls will not trouble you in your journeys, but know that doing so is no easy task - our covens are not used to being that discerning about potential recruits.</i>\"  She folds her arms across her bosom in an imperious gesture of finality.");
		output("\n\nWell, you guess that worked.");
		flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] = 1;
	}
	//Send Lackeys
	else {
		output("You mention that you wouldn't mind the witches trying to recruit you as they used to.");
		output("\n\n\"<i>Really?</i>\" the Sand Mother coos with a tinge of eagerness in her voice.  \"<i>You're not opposed to me taking the leash off my scouts and letting them try to... shape you?</i>\"");
		if(pc.cor() > 66) output("\n\nGrinning confidently, you answer that you welcome the challenge.");
		else if(pc.cor() > 33) output("\n\nSmiling ruefully, you tell her that it will be a good challenge to strengthen both sides.");
		else output("\n\nToeing the floor, you try to hide your blush at her words but tell her that it's good fighting practice.");
		output("\n\nThe queen of the coven smiles, her eyes burning with desire as she proclaims, \"<i>It will be so.  I hope you do not mind overmuch if the next time we meet your nipples are dragging the floor, leaking milk the whole way to the baths.</i>\"  Her nipples have noticeably stiffened through her thick robes, dampening the material with her own lactic lust.  Humming happily, she calls for one of the lesser witches to attend to her.  When the younger enchantress arrives, she's given the order to spread the message, but before she goes, she gives you a long, lecherous look.");
		output("\n\nYou're suddenly not so sure this was a great idea.");
		flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] = 0;
	}
	clearMenu();
	addButton(0, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}
//*Lactaid
//>Get lactaid
//public function getLactaidFromWitches():void {
	//clearOutput();
	//output("You ");
	//if(pc.cor() < 33) output("politely request");
	//else if(pc.cor() < 66) output("request");
	//else output("none-too-politely request");
	//output(" a dose of Lactaid from her coven.");
	//
	//output("\n\n\"<i>Are you thinking of joining us?  We could do the deed much more directly with our magics,</i>\" the Sand Mother offers.  \"<i>These dunes are as comfortable to us as a mother's bosom, and your place among us could be most pleasant.</i>\"");
	//
	//output("\n\nYou decline the offer and repeat your request for Lactaid, which sours the woman's expression slightly.  The corners of her mouth are still upturned in a half smirk when she procures a bottle and hands it to you.  After, she smooths her hand across her robed lap, and for a split second, you wonder if she's trying to beckon you to take a seat there...  You shake your head as you examine the bottle in your hand.  You got what you came for.\n\n");
	//flags[kFLAGS.SAND_WITCH_LOOT_TAKEN]++;
	////Receive one lactaid
	//inventory.takeItem(consumables.LACTAID, roomSandMotherThrone);
//}
//*Labova
//>Get Labova
//public function getLaBova():void {
	//clearOutput();
	//output("You ask for some La Bova");
	//if(cor() < 33) output(" with a blush");
	//else if(cor() < 66) output(" a little uncertainly");
	//else output(" with a knowing smile");
	//output(".");
	//output("\n\n\"<i>Oh?  You're not going to move into the mountains and try to woo the minotaurs into submission with milk are you?</i>\" the Sand Mother questions.  \"<i>That would be a sure descent into corruption.</i>\"");
	//output("\n\nYou shake your head");
	//if(cor() > 66) output(", though the idea does seem to nestle into your imagination quite alluringly");
	//output(".");
	//output("\n\n\"<i>That is good.  The ways of beasts offer many boons.  This one is quite useful for enhancing lactation, for instance.  However, there is great risk in reveling in such transformation.  Be sure that you don't lose yourself to it,</i>\" the statuesque sorceress warns.");
	//output("\n\nYou nod, and she gives you the La Bova.\n\n");
	//flags[kFLAGS.SAND_WITCH_LOOT_TAKEN]++;
	//inventory.takeItem(consumables.LABOVA_, roomSandMotherThrone);
//}
	
//TURN EM OFF!
public function unfriendlyWitchToggle():void {
	clearOutput();
	if(flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] != 1) {
		output("Imperiously, you fold your arms and tell the queen of the milky slatterns to cease her coven's constant, badgering attacks out on the sands.  Her face registers an incredulous expression at the decree, and she matches your confrontation pose, her forearms pressing deep into the recesses of her prodigious bust.  You await her response, and for a moment, you think you're going to have to fight her again.  Then, her stern gaze wavers as she sags into her throne, defeated before she could even start to resist.");
		output("\n\n\"<i>Fine.  I guess then...</i>\" she casts her incandescent gaze to the side, \"<i>...you won't be able to force yourself on them.</i>\"  You chuckle at that.");
		if(pc.cor() < 50) output("  You probably wouldn't do something like that, at least not without provocation!/  You could see how she would think that.");
		else output("  As if that would stop you.");
		output("  Slapping her on the shoulder, you congratulate her on seeing good sense.  Her eyes narrow dangerously as she twists away from your touch.");
		output("\n\n\"<i>Just... just, leave us be,</i>\" the Sand Mother's reedy voice pleads.");
		flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] = 1;
	}
	//TURN EM ON
	else {
		output("You smile and tell the Sand Mother that you'd like her lackeys to start pestering you again.  It's been awhile since you've gotten to show one of her pet witches her place, and mobile milk-dispensers are always a welcome treat out on the sands.  Her face grows livid at the suggestion, and she actually rises up out of her throne, shaking with rage.  Holding your [pc.weapon] ready, you cock your head to the side and dare her to oppose you.");
		output("\n\n\"<i>No,</i>\" the tanned enchantress mumbles, sitting back down.  \"<i>I can't... fine.  I'll tell them they can pursue you if they dare.  Do not expect us to fall before you without a struggle.</i>\"");
		output("\n\nYou reply, \"<i>I wouldn't dream of it.</i>\"");
		flags["COC.SAND_WITCH_LEAVE_ME_ALONE"] = 0;
	}
	clearMenu();
	addButton(0, "Next", function():*{
		setEnemy(null);
		clearMenu();
		mainGameMenu();
	});
}

//addButton(5,"Get LaBova",takeLaBovaOrLactaid, false);
//addButton(6,"Get Lactaid",takeLaBovaOrLactaid);
//*Raid LaBova/Lactaid
//public function takeLaBovaOrLactaid(lactaid:Boolean = true):void {
	//clearOutput();
	//output("Smirking, you circle around the Sand Mother's throne towards the secure chests behind her.  She stiffens when you come close but doesn't make a move.  The poor little witch is afraid of you, and with good reason.  You gather the item you came for, condescending patting the sorceress's platinum tresses on your way back in front of her throne.  She glares at you.\n\n");
	////New lines and take appropriate item.
	//if(lactaid) {
		//inventory.takeItem(consumables.LACTAID, roomSandMotherThrone);
	//}
	//else {
		//inventory.takeItem(consumables.LABOVA_, roomSandMotherThrone);
	//}
//
//}