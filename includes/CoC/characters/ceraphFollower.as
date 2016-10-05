import classes.Characters.CoC.CoCCeraph;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// CERAPH_ROLEPLAY_AS_DOMINIKA_COUNT:int = 389;
// CERAPH_HIDING_DICK:int = 288;
// TIMES_CERAPH_PORTAL_FUCKED:int = 438;
//Capacity = 115;

public function followerCampMenuBlurbCeraph(showInteractButton:Boolean):void {
	if (ceraphIsFollower()) {
		if (showInteractButton) addButton(followerBtnNum++, "Ceraph", function():* { processTime(1); ceraphFollowerEncounter() } );
	}
}

private var followerCampMenuBlurbCeraphHook: * = followerCampMenuBlurbCeraphGrapple();
private function followerCampMenuBlurbCeraphGrapple():* {
	slaveCampMenuBlurb.push(followerCampMenuBlurbCeraph);
}

public function get ceraph():CoCCeraph {
	if (enemy != null && enemy is CoCCeraph) return enemy as CoCCeraph;
	return new CoCCeraph();
}

//Is Ceraph a follower?
public function ceraphIsFollower():Boolean
{
	return flags["COC.CERAPH_FOLLOWER_PIERCING"] > 0 || flags["COC.CERAPH_FOLLOWER_TOKEN"] > 0;
}

public function ceraphFollowerEncounter(forceCeraph:Boolean = false):void
{
	if (forceCeraph)
	{
		ceraphFollowerAppearance();
		return;
	}
	
	if (rand(24) == 0 && pc.hasCock())
		catgirlEncounter();
	else if (rand(24) == 0 && flags["COC.CERAPH_DECLINE_CORRUPTION_SLAVES"] == undefined)
		carephCorruptionSlaves();
	else if (rand(24) <= 1 && pc.hasGenitals())
		encounterZetsuko();
	else
		ceraphFollowerAppearance();
}

public function ceraphSprite():void
{
	showName("\nCERAPH");
	//spriteSelect(87);
}

//[Actually Ceraph] - 
public function ceraphFollowerAppearance(display:Boolean = true):void
{
	//spriteSelect(87);
	if (display) {
		clearOutput();
		output("You move to a secluded portion of your camp and mentally call for your tamed Omnibus.\n\nCeraph strides from around a boulder, as if by magic.  The slave-demon wears her red-studded collar as always.  However, instead of prancing around naked like she used to, she's arrived wearing a scandalous latex outfit that's as concealing as it is titillating.  From the tips of her fingers all the way to her shoulders, she's sleeved in the glossy black material.  At her neck, the top opens up, exposing the purple curves of her breasts, even though her nipples are hidden away by a clingy, scandalous scarlet bra, also of latex.  It looks as though it would be effortless to tear away. A rubbery faux-corset hugs her waist, connected to the material over her arms and shoulders in the back. The crimson micro bikini bottom beneath it looks unfit for covering anything Ceraph has ever had between her legs, but it somehow seems to just barely be holding things together.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  Her demonic prick forms a ridge in the tight fabric, its head peeking ever-so-slightly over the top");
		else output("  Thankfully, she seems to have removed or hidden her demonic cock somehow, so as not to disrupt her fragile outfit with unfeminine bulges");
		output(".  Tight buckles link her corset to the long thigh high boots over her legs, the platforms and heels adding nearly a foot to her height.  Red stripes run right down the front of them and along the soles, as an imitation of laces.\n\n");

		output("Ceraph's liquid black eyes twist, the surfaces spiralling inward to the pinpricks of her pupils.  Her irises, now that you can see them, are purplish, like her skin, though they're glittery and as reflective as precious gems.  The omnibus drops onto her knees before you, not looking you in the eye without a command.  She whispers, \"<i>You called, " + pc.mf("Master", "Mistress") + "?</i>\"\n\n");
		output("Ceraph offhandedly mentions, \"<i>If you're into that sort of thing, [pc.Master], I could take one of your <b>delectable</b> body-parts and use it with my harem.  From what I understand, the original owner will often be able to experience the sensations of their gift while their consciousness is relaxed - while sleeping, usually.</i>\"\n\n");

		output("<b>What will you do with your slave?</b>  ");
		
		if (pc.lust() < 33) output("\n\n<b>You aren't turned on enough for sex.</b>");
	}
	
	clearMenu();
	addDisabledButton(0, "Sex", "Sex", "You are not aroused enough.");
	addDisabledButton(1, "Roleplay", "Roleplay", "You are not aroused enough.");
	addDisabledButton(2, "Get Fetish", "Get Fetish", "You already have all fetishes.");
	addDisabledButton(3, "RemoveFetish", "Remove Fetish", "You have no fetishes.");
	
	if (pc.lust() >= 33) {
		addButton(0, "Sex", ceraphSexMenu);
		addButton(1, "Roleplay", followerCeraphRoleplay);
	}
	
	if (int(flags["COC.PC_FETISH"]) < 3) addButton(2, "Get Fetish", CeraphHandsOutNewFetishesLikePervCandy);
	if (int(flags["COC.PC_FETISH"]) > 0) addButton(3, "RemoveFetish", unfetishifyYourselfWithFollowerCeraph);
	
	addButton(5, "Partswap", giveFollowerBodyBits);
	
	addButton(6, int(flags["COC.CERAPH_HIDING_DICK"]) == 0 ? "Go Female" : "Go Herm", cawkTawgle);
	
	addButton(14, "Leave", campSlavesMenu);
	
	//if (int(flags["COC.FOLLOWER_AT_FARM_CERAPH"]) == 0 && flags["COC.FARM_CORRUPTION_STARTED"] == 1) addButton(1, "Farm Work", helpWithFarm);
}

//private function helpWithFarm():void
//{
	//clearOutput();
	//ceraphSprite();
	//
	//output("You ask Ceraph if she can help you with the farm you recently acquired.");
//
	//output("\n\n“<i>You mean work on a farm? Don’t be ridiculous, [pc.name]!</i>” She chortles, before coughing as she catches your expression. “<i>I don’t think me or any of my pets are cut out for farming,</i>” she says, tapping her chin. “<i>Or at least not that kind you have in mind. But I could mark the place as being under demon protection if you like. I can only do it once,</i>” she warns. “<i>And it will wear off eventually.</i>”");
//
	//clearMenu();
	//addButton(0, "Do It", doFarmShit);
	//addButton(1, "Later", noFarmShitYet);
//}
//
//private function doFarmShit():void
//{
	//clearOutput();
	//ceraphSprite();
	//
	//output("“<i>I’ll go over there tonight then,</i>” she says. There’s a far-away gleam of excitement in her eyes as she tugs on a nipple; only now does it occur to you what ‘marked as being under demon protection’ might entail. “<i>Anything else, [pc.Master]?</i>”");
	//
	//flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] = 1;
	//kGAMECLASS.farm.farmCorruption.whitneyCorruption(10);
	//
	//ceraphFollowerAppearance(false);
//}
//
//private function noFarmShitYet():void
//{
	//clearOutput();
	//ceraphSprite();
	//
	//output("“<i>Very well,</i>” she smirks. “<i>Anything else?</i>”");
	//
	//ceraphFollowerAppearance(false);
//}

private function ceraphSexMenu():void
{
	clearOutput();
	clearMenu();
	addDisabledButton(0, "Fuck Pussy", "Fuck Pussy", "This option requires you to have cock.");
	addDisabledButton(1, "Get Tongued", "Get Tongued", "This option requires you to have vagina.");
	addDisabledButton(2, "Please All", "Please All", "This option requires you to be herm.");
	addDisabledButton(3, "NippleFuck", "NippleFuck", "This option requires you to have fuckable nipples.");
	addDisabledButton(4, "Penis Magic", "Penis Magic", "This option requires you to have fitting cock.");
	addDisabledButton(5, "Lay Eggs", "Lay Eggs", "This option requires you to have ovipositor.");
	
	if (pc.hasCock()) addButton(0, "Fuck Pussy", fuckFollowerCeraphsVagoo, undefined, "Fuck Pussy", "You could fuck her pussy.");
	if (pc.hasVagina()) addButton(1, "Get Tongued", followerCeraphTongueFucking, undefined, "Get Tongued", "You could make her lick your pussy.");
	if (pc.isHerm()) addButton(2, "Please All", ceraphTentacleGrape, undefined, "Please All", "You could command her to please all of your organs.");
	if (pc.hasFuckableNipples()) addButton(3, "NippleFuck", stuffSomeNippleCunts, undefined, "Nipple Fuck", "You could have your slave please your nipplecunts.");
	if (pc.hasCock() && pc.cockThatFits(cockVolume(100)) >= 0) addButton(4, "Penis Magic", portalFuckWithFollowerCeraph, undefined, "Penis Magic", "You could use your penis but see if Ceraph has some magic to mix it up.");
	if (pc.canOviposit()) addButton(5, "Lay Eggs", layEggsInSlaveCeraph);
	
	addButton(14, "Back", ceraphFollowerAppearance);
}


private function followerCeraphRoleplay():void
{
	clearOutput();
	output("You tell Ceraph you'd like to do a little roleplaying.  Her nipples turn hard under their latex bindings as she asks, \"<i>What will it be, " + pc.mf("Master", "Mistress") + "?  Shall I pretend you've just teased me into sexual submission, or would you like to switch things up and have your bottom play at being top again?  Or maybe... you'd like me to shapeshift into some other girl, and do all the dirty, depraved things she never would?</i>\"");
	output("\n\nShe makes a gesture, and the surroundings take on a mountainous look.  Of course, she can probably change that on a whim.  What do you have Ceraph roleplay?");
	
	clearMenu();
	addDisabledButton(0, "Defeat Her", "Defeat Her", "This option requires you to have genitals.");
	addDisabledButton(5, "Dominika");
	//addDisabledButton(6, "Marble Play", "Marble Play");
	addDisabledButton(7, "Urta Play", "Urta Play");
	
	if (pc.hasGenitals()) addButton(0, "Defeat Her", CoCCeraphPCVictory);
	addButton(1, "Lose to Her", ceraphRapesYouBADDAWGYODIGGITY);
	if (flags["COC.DOMINIKA_MET"] > 0 && pc.hasCock()) addButton(5, "Dominika", cerminika);
	//if (pc.hasCock() && pc.cockThatFits(cockVolume(70)) >= 0 && pc.findStatusEffect(StatusEffects.Marble) >= 0) addButton(6, "Marble Play", sweetieNOOOO);
	if (flags["COC.TIMES_FUCKED_URTA"] > 0 && pc.hasGenitals()) addButton(7, "Urta Play", ceraphUrtaRoleplay);
	if (pc.hasGenitals()) addButton(8, "Be A Pet", sumissivenessToCeraphFollower);
	
	addButton(14, "Back", ceraphFollowerAppearance);
}

//*Ceraph is Defeated #4 - Offers Funtimes (Zeddited)
public function submissiveCeraphOffer():void
{
	//spriteSelect(7);
	clearOutput();
	output("Once again, Ceraph ");
	if (enemy.HP() <= 1) output("drops on the ground in front of you, completely beaten.");
	else output("drops down and starts masturbating, practically fisting her drooling pussy while she pumps her demonic dick with reckless abandon.");
	output("  She ");
	if (enemy.HP() <= 1) output("looks up at you and asks");
	else output("manages to stop fapping long enough to look up at you and ask");
	output(", \"<i>Why do I even bother?</i>\"\n\n");

	output("You're a bit surprised by her tone - depression and defeat aren't exactly her style.  The only thing you manage to respond with is ");
	if (pc.cor() < 33) output("a nervous chuckle");
	else if (pc.cor() < 66) output("a surprised laugh");
	else output("a bemused smirk");
	output(".  Ceraph presses on, \"<i>This whole time I've been trying to bring you into my harem, but I've ignored the obvious.  Each time we've tangled, you come out on top... in more ways than one.</i>\"  The demon looks up at you with meek, hooded eyes and says, \"<i>Perhaps I've had it backwards all along... I belong in your harem.</i>\"\n\n");

	output("Letting your eyes play over the demon's exotic, sculpted skin, you can't help but be tempted by her offer... Ceraph sees you mulling it over and produces a collar as she purrs, \"<i>No pressure... " + pc.mf("Master", "Mistress") + ".  You could always just take me here like usual, and perhaps, the next time you'll stop being so lucky...</i>\"\n\n");
	
	//[Display Rape Options + Collar Option]
	clearMenu();
	if (pc.hasGenitals()) {
		output("Do you fuck her? (And if so, which of your body parts do you do it with?)\n\n");
		//Dickings ahoyu!
		addDisabledButton(1, "Fuck Her", "Fuck Her", "This scene requires you to have cock.");
		addDisabledButton(2, "Ride Her", "Ride Her", "This scene requires you to have vagina.");
		addDisabledButton(3, "FuckHerAss", "Fuck Her Ass", "This scene requires you to have fitting cock.");
		if (pc.hasCock()) {
			addButton(1, "Fuck Her", maleFuckCeraphsPussy);
			if (pc.cockThatFits(enemy.analCapacity()) != -1) addButton(3, "FuckHerAss", buttRapeCeraph);
		}
		if (pc.hasVagina()) addButton(2, "Ride Her", rideCeraphsCockLikeaBAWSSexclamation11eleven);
	}
	
	addButton(0, "Collar Her", collarCeraph);
	addButton(1, "Leave", function():* { processTime(20 + rand(10)); CombatManager.genericVictory(); } );
}

//Collar Ceraph After 4th Defeat + Rape: (Zeddited)
private function collarCeraph():void
{
	clearOutput();
	//spriteSelect(7);
	output("You reach down and snatch the collar from Ceraph's shaking hand.  Turning it over in your grip, you get a feel for the soft, supple leather.  Blood-red studs poke out around the black strap's surface, vaguely reminding you of a dog's collar, though with the aggression cranked up to max.  The snap mechanism looks simple enough to connect, but you can't see any way to release the latch.  It makes sense that Ceraph would have one-way collars; slaves shouldn't be able to remove the symbol of their station.\n\n");

	output("Leaning over, you slide the collar around your new slave's suddenly flush neck, feeling her heart hammering away just beneath the skin.  Snapping it closed, you muse ");
	if (pc.cor() < 33) output("that you never expected making a demon into your slave would factor into your quest.  On one hand it seems wrong, but... she's a demon.  The fewer you have opposing you, the easier it will be to end their threat completely.");
	else if (pc.cor() < 66) output("that taking a demon as a slave would've been abhorrent to you when you started this journey.  Now, it's just a means to a very pleasurable end.");
	else {
		output("on how much you'll enjoy using the former dom as your personal ");
		if (pc.hasCock()) output("cum-dump");
		else output("tongue-slave");
		output(".");
	}
	output("  Ceraph pulls herself up to her knees and kisses your " + pc.feet() + ", a show of absolute submission and obedience.\n\n");

	output("The defeated demon explains, \"<i>Though I am now and forever your slut, your slave, your bitch... those in my harem cannot be abandoned.  I am sad to say I cannot live with you, " + pc.mf("Master", "Mistress") + ".</i>\"  She sees the look forming in your eyes and hastily adds, \"<i>Oh, I'll still be at your beck and call, but if I can't make it, I'll be sure to send you one of my pets.  Just rub this charm whenever you want my services, " + pc.mf("Master", "Mistress") + ", and I'll be there.</i>\"  Ceraph holds out a tiny onyx bar tipped with rubies.  The gems shine and glitter with their own inner light, while the black shaft seems to drink in everything around it, leaving behind darkness.\n\n");

	output("Well, with a harem as large as hers, it makes sense that she'd have to keep them in her lair and tend to them.  There's no way you could foster the people in your camp, and besides, since their Mistress is your slave, they're <b>now yours by extension, as well</b>.  Ceraph reaches down to ");
	if (enemy.lustQ() >= 100) output("resume stroking");
	else output("stroke");
	output(" her nodule-studded demon-dick with her free hand.  She whimpers, \"<i>Would my " + pc.mf("Master", "Mistress") + " prefer to carry " + pc.mf("his", "her") + " slave's token, or wear it as a belly-button piercing?</i>\"\n\n");

	//[Carry] [Pierce]
	clearMenu();
	addButton(0, "Carry", carryCarephsToken);
	addButton(1, "Pierce", getCeraphFollowerPiercing);
}

//[Carry]
private function carryCarephsToken():void
{
	clearOutput();
	//spriteSelect(7);
	output("You inform your living property that you've heard quite enough about her piercings and snatch the token from her hand.  Ceraph's eyes go wide and she nods, more than a little fearfully.  Seeing the Omnibus so cowed brings a smile to your face.\n\n");

	output("Ceraph asks, \"<i>So, before my " + pc.mf("Master", "Mistress") + " leaves, would you like to fuck your new slut one of the old ways, one last time?</i>\"\n\n");

	output("<b>(Received Key Item: Onyx Token)</b>\n\n");
	flags["COC.CERAPH_FOLLOWER_TOKEN"] = 1;
	pc.createKeyItem("Onyx Token - Ceraph's", 0, 0, 0, 0);
	//[Display Rape Options + Collar Option]
	if (pc.hasGenitals()) {
		output("Do you fuck her as a disobedient demon, one last time? (And if so, which of your body parts do you do it with?)\n\n");
		//Dickings ahoyu!
		addDisabledButton(0, "Collar Her");
		addDisabledButton(1, "Fuck Her", "Fuck Her", "This scene requires you to have cock.");
		addDisabledButton(2, "Ride Her", "Ride Her", "This scene requires you to have vagina.");
		addDisabledButton(3, "FuckHerAss", "Fuck Her Ass", "This scene requires you to have fitting cock.");
		if (pc.hasCock()) {
			addButton(1, "Fuck Her", maleFuckCeraphsPussy);
			if (pc.cockThatFits(enemy.analCapacity()) != -1) addButton(3, "FuckHerAss", buttRapeCeraph);
		}
		if (pc.hasVagina()) addButton(2, "Ride Her", rideCeraphsCockLikeaBAWSSexclamation11eleven);
		
		addButton(4, "Leave", function():* { processTime(20 + rand(10)); CombatManager.genericVictory(); } );
	}
	else {
		output("  You don't really have the equipment to.  Oh well.\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	}
}

//[Pierce] 
private function getCeraphFollowerPiercing():void
{
	clearOutput();
	//spriteSelect(7);
	//Set belly button pierced as active
	flags["COC.CERAPH_FOLLOWER_PIERCING"] = 1;
	output("You bare your midriff to your new slut with ");
	if (pc.cor() < 40) output("a little hesitation.");
	else output("a smirk, secure in your knowledge of her defeat.");
	output("  Ceraph shimmies forward and holds the oily stud against your midriff, pressing it into you with her palm.  There's a moment of tingling warmth, followed by an ache of unholy numbness.  When the demoness removes her hand, your belly-button is studded with the magical jewelry, glowing and not at the same time.\n\n");

	output("There's no lingering compulsion, no mental assault, just a new piercing.  You're kind of awestruck by the gesture - even though she seemed sincere, a small part of you still believed the fetish-obsessed demon was using this whole thing as a setup to trick you.\n\n");

	output("Ceraph asks, \"<i>" + pc.mf("Master", "Mistress") + ", before you go, would you like to fuck your slut one of the old ways, one last time?</i>\"");
	//[Display Rape Options + Collar Option]
	if (pc.hasGenitals()) {
		output("\n\nDo you fuck her as a disobedient demon, one last time? (And if so, which of your body parts do you do it with?)\n\n");
		//Dickings ahoyu!
		addDisabledButton(0, "Collar Her");
		addDisabledButton(1, "Fuck Her", "Fuck Her", "This scene requires you to have cock.");
		addDisabledButton(2, "Ride Her", "Ride Her", "This scene requires you to have vagina.");
		addDisabledButton(3, "FuckHerAss", "Fuck Her Ass", "This scene requires you to have fitting cock.");
		if (pc.hasCock()) {
			addButton(1, "Fuck Her", maleFuckCeraphsPussy);
			if (pc.cockThatFits(enemy.analCapacity()) != -1) addButton(3, "FuckHerAss", buttRapeCeraph);
		}
		if (pc.hasVagina()) addButton(2, "Ride Her", rideCeraphsCockLikeaBAWSSexclamation11eleven);
		
		addButton(4, "Leave", function():* { processTime(20 + rand(10)); CombatManager.genericVictory(); } );
	}
	else {
		output("  You don't really have the equipment to.  Oh well.\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	}
}

//*Decision to Display Demonic Dick or Demur (pretty sure Fen mentioned wanting this -Z)
private function cawkTawgle():void
{
	clearOutput();
	//spriteSelect(87);
	//Off
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) {
		output("You tell Ceraph that you want her to hide her demonic cock when she's around you.  Your collared demoness nods, lowering her eyelids seductively.  She slides a hand up the front of her latex panties, stroking her defiled member through the material once before concealing its form with fingers pointed down.\n\n");

		output("She lets out a low hum, then suddenly arches her back as her hand sinks in an inch.  \"<i>O-oh-oh!</i>\" she moans, pulling it away with a small string of pre-cum tying it to her now-bulgeless panties.  Absently she licks the fluid from her fingers and asks, \"<i>Was there anything else, my " + pc.mf("Master", "Mistress") + "?</i>\"\n\n");

		//(set DemonDomDongDisplay to OFF)
		flags["COC.CERAPH_HIDING_DICK"] = 1;
	}
	else {
		output("You tell Ceraph that you want her to have her demonic cock on display when around you.  She nods, breaking into an eager smile, and slips a hand into the front of her latex panties.  The veneer of rapt concentration on her face is only dispelled when you glance down at her crotch and notice her vigorously fingering her clitoris under the fabric, bowing out the surface as she flexes and caresses.\n\n");

		output("A low moan gathers in intensity as Ceraph strokes, and then abruptly she jerks her hips forward as a bulge emerges between her fingertips and travels up the front of her undergarment.  It overreaches the panty line and the purple glans peeks out, smeared and dribbling with copious pre-cum.  She strokes the shaft almost automatically, as she addresses her next hopeful question to you.  \"<i>Was there anything <b>else</b> you'd like to do, " + pc.mf("Master", "Mistress") + "?</i>\"  Clearly, this particular magical feat is very enjoyable to her, on a personal level.");
		//set DemonDomDongDisplay to ON)
		flags["COC.CERAPH_HIDING_DICK"] = 0;
	}
	//To Ceraph follower menu
	processTime(2);
	addNextButton(ceraphFollowerAppearance);
}

//Volunteer for new fetishes!
private function CeraphHandsOutNewFetishesLikePervCandy():void
{
	clearOutput();
	//spriteSelect(87);
	//*Fetish level = 0
	if (int(flags["COC.PC_FETISH"]) == 0) {
		output("Ceraph comes forward on your command, whispering calmly as she ");
		if (pc.earsPierced == 0) output("pulls a pair of gleaming, green piercings from a pouch.  \"<i>Oh, don't worry " + pc.mf("Master", "Mistress") + "; you're going to love this so much.  These piercings are special, and they'll give you exactly what you want.</i>\"");
		else output("places her hands upon your pierced ears.  She whispers softly, \"<i>Don't worry " + pc.mf("Master", "Mistress") + ", I can easily use the piercings you already have.  It won't hurt.</i>\"");
		output("\n\n");
		//(NOT PIERCED) 
		if (pc.earsPierced == 0) output("The demon places a hand on your forehead and rubs your temples.  Numbness spreads through your body with every touch, until you can barely feel a thing.  She snaps an earring into your left ear, and dizziness washes over you.  A moment later she's piercing the other side, and the now-familiar vertigo that accompanies it seems to come and go quicker than before.  ");
		//(PIERCED) 
		else output("The demon rubs your ears in her hands, numbing them slightly.  A gradual buzz builds behind your eyes, accompanied by a wave of dizziness.  You blink and try to shake your head, but as numb as you are, it's quite difficult.  After a few moments, the odd sensations pass, returning normal feeling to your ears and " + pc.face() + ", much to your relief.  ");
		output("You hope she doesn't take your [pc.gear] while you're paralyzed, leaving you to roam the realm totally exposed.  Confusion and waves of new desire battle in your mind as you try to come to grips with the odd thought.\n\n");

		output("Ceraph watches your ");
		if (pc.cockTotal() > 0) output("cock bounce in time with your fluttering heartbeats");
		else if (pc.hasVagina()) output("vagina get wetter and wetter");
		else output("parted lips and confused expression");
		output(" as the new thoughts and desires settle themselves inside you.  She gives you a gentle pat and explains, \"<i>It's ok " + pc.mf("Master", "Mistress") + "; you're an exhibitionist now.  Would you like your piercing slave to give you even more?</i>\"\n\n");

		output("Ceraph is right – <b>you're an exhibitionist now.</b>");
		if (pc.earsPierced == 0) {
			pc.earsPierced = 1;
			pc.earsPShort = "green gem-stone ear-studs";
			pc.earsPLong = "Green gem-stone ear-studs";
		}
		flags["COC.PC_FETISH"] = 1;
		pc.lust(25);
		pc.cor(1);
	}
	//*Fetish level = 1
	else if (flags["COC.PC_FETISH"] == 1) {
		output("Ceraph giggles as she closes in on you once again.  Sighing, you lie there and allow your slave to massage your temples, using her magic to paralyze and numb your body.  ");
		if (pc.nipplesPierced == 0) {
			output("She's all too happy to build up the suspense as she pulls out a pair of shining black studs, \"<i>Oh, do you know what these are going to do?  Well, how about I slide them into your ");
			if (pc.hasFuckableNipples()) output("slutty");
			else if (pc.nippleLength(pc.biggestTitRow()) < 1) output("cute");
			else output("tight");
			output(" nipples, and you tell me all about your fetishes and which one makes you the hottest.  Oh, you'll love it " + pc.mf("Master", "Mistress") + "!</i>\"\n\n");
		}
		//If already pierced
		if (pc.nipplesPierced > 0) output("She's all too happy to build up the suspense as she lays  her hands on your pierced nipples, giving them a gentle tweak that you can barely feel.  \"<i>Don't worry, " + pc.mf("Master", "Mistress") + ".  Imbuing your new fetish into you through these will be easy.  Just tell me all about which fetishes make you hottest while I do it, and see if you can guess your new kink.</i>\"\n\n");
		//Business as usual!
		output("The demon doesn't give you a chance to reply; instead, she focuses on ");
		if (pc.nipplesPierced > 0) output("your " + pc.nippleDescript(0) + "s, circling her fingers all around the fleshy nubs.  Goosebumps run over your body in a wave, accompanied by a similar chill and a pressure behind your temples.  You shudder, but it quickly fades.");
		else output("aligning the business ends of the piercings with your sensitive nipple-flesh.  Your right " + pc.nippleDescript(0) + " is pierced in one smooth motion, nearly making you scream in pain.  As she fastens it on, you feel goosebumps spread over your body in a wave.  The second piercing doesn't seem to hurt as bad, but the sensation of spreading goosebumps is far more noticeable.");
		output("  Your eyes dart around, curious what fetish your demonic slave has given you this time.\n\n");

		output("Ceraph smiles down at you and whimpers, \"<i>I hope you're pleased with the new fetish " + pc.mf("Master", "Mistress") + ".  Just think about how similar being paralyzed is to being tied down and tell me if you like it.</i>\"\n\n");

		output("Your body goes beet-red as it suddenly tries to struggle against the invisible binding of her magic.  It... it feels good!  You nearly cry out with lust as the restraint turns you on more and more.  Ceraph's magic has given you a fetish for being tied up!  You nearly faint when you think of all the strange things in this land that might try to restrain you, and you know you have no hope of resisting if they ever catch you.  <b>Though somehow you think you might enjoy being a bondage fetishist...</b>");
		pc.lust(25);
		pc.cor(1);
		if (pc.nipplesPierced == 0) {
			pc.nipplesPierced = 1;
			pc.nipplesPShort = "seamless black nipple-studs";
			pc.nipplesPLong = "Seamless black nipple-studs";
		}
		flags["COC.PC_FETISH"] = 2;
	}
	//*Fetish level = 2
	else if (flags["COC.PC_FETISH"] == 2) {
		output("The demoness pulls out a diamond-studded piercing and closes in on you, her cock peeking out of her panties, her pussy moist, and her hips swaying seductively as she advances.  Ceraph gives you a serious look and warns you, \"<i>You realize you're not even going to be able to lift a hand against your foes after this?  You really love a challenge, don't you " + pc.mf("Master", "Mistress") + "?</i>\"\n\n");

		output("The idea of facing the denizens of this land without even so much as the ability to throw a punch turns you on immensely, and you pant and gasp as ");
		if (pc.hasCock()) {
			output("pre-cum oozes from ");
			if (pc.totalCocks() > 1) output("each of ");
			output("your [pc.cocks].");
		}
		else if (pc.hasVagina()) output("feminine moisture drools from between your lips and your " + pc.clitDescript() + " turns into a hard button.");
		else output("your body aches for release.");
		output("  With an amused grin, Ceraph yanks down your gear and ");
		//[dicks]
		if (pc.hasCock()) {
			output("grabs your " + pc.cockDescript(0), false);
			if (pc.cocks[0].pierced > 0) output(", the old piercing clattering to the ground as it slides out, ");
			output(" and snaps the diamond stud through your sensitive flesh, making your vision haze red in pain.\n\n");
			pc.cocks[0].pierced = 1;
			pc.cocks[0].pShortDesc = "diamond cock-stud";
			pc.cocks[0].pLongDesc = "Diamond cock-stud";
		}
		//[cunts]
		else if (pc.hasVagina()) {
			output("spreads your lips");
			if (pc.vaginas[0].clitPierced > 0) output(", the old piercing clattering to the ground as it slides out of your flesh, ");
			output(", getting ahold of the flesh around the base of your " + pc.clitDescript() + ".  With practiced ease, she snaps the piercing closed, attaching the diamond stud to you while the pain fuzzes your vision red.\n\n");
			pc.vaginas[0].clitPierced = 1;
			pc.vaginas[0].clitPShort = "diamond clit-stud";
			pc.vaginas[0].clitPLong = "Diamond clit-stud";
		}
		//[else]
		else {
			output("snaps the diamond stud into your eye-brow, piercing it");
			if (pc.eyebrowPierced > 0) output(" and discarding your old jewelry like a piece of garbage");
			output(".  It hurts more than it ought to, fuzzing your vision red.\n\n");
			pc.eyebrowPierced = 1;
			pc.eyebrowPShort = "diamond eyebrow-stud";
			pc.eyebrowPLong = "Diamond eyebrow-stud";
		}
		//Set fetish level
		flags["COC.PC_FETISH"] = 3;
		output("As she finishes, you get up and attempt to test your slut's work.  Raising your hand for a slap, you try to bring it down on Ceraph's face.  She flinches, but the blow stops a few inches away from her, melting into a gentle caress.  <b>You can no longer use basic physical attacks!</b>  She drops to her knees and asks, \"<i>Have I displeased you?  I can remove the compulsion in it if you like.</i>\"\n\n");

		output("You rub a hand through the demon's pitch-black hair and let her know that it's exactly what you asked for.\n\n");

		output("Ceraph gives an excited squeak and holds herself still, allowing you to pet her.  Once you stop, she gives a disappointed sigh, but holds her position.");
		pc.lust(25);
		pc.cor(2);
	}
	processTime(15);
	addNextButton(ceraphFollowerAppearance);
}

//*Request Ceraph Remove a Fetish. (Zeddited)
private function unfetishifyYourselfWithFollowerCeraph():void
{
	clearOutput();
	//spriteSelect(87);
	output("You ask Ceraph to remove one of the fetishes she generously donated earlier.  She sighs and nods, saying, \"<i>" + pc.mf("Master", "Mistress") + ", are you sure? It isn't that easy to do, and I love knowing my owner is aroused by my piercings!</i>\"\n\n");
	output("Growling in irritation, you tell her, \"<i>Yes, I would like a fetish removed.</i>\"\n\n");
	output("The demoness slumps her shoulders and nods.  She explains, \"<i>I have to do them in the reverse order that I added them... just hold still, okay?</i>\"\n\n");

	output("Do you go through with it?");
	//[Yes] [No] - back to follower menu
	processTime(2);
	clearMenu();
	addButton(0, "Yes", goThroughWithCeraphUnfetishification);
	addButton(1, "No", ceraphFollowerAppearance);
}

//*Ceraph Actually Removes The Fetish (Zeddited)
private function goThroughWithCeraphUnfetishification():void
{
	clearOutput();
	//spriteSelect(87);
	output("Ceraph steps closer, her shining outfit squeaking from the movement.  Her hands gently touch your forehead, though she tries to avoid meeting your gaze.  The submissive slut keeps her eyes downcast, as is proper for a slave, and she begins to rub at your temples, working her magic to undo her mischief.  Warmth surges out, rushing through your temples and leaving a slack looseness in its wake.  Ceraph grunts and lets go, staggering back and panting.  She mumbles, \"<i>So much harder... to take those without changing... something else.</i>\"\n\n");
	output("After a few moments, she seems to recover, and she asks, \"<i>Was there something else you needed me here for, " + pc.mf("Master", "Mistress") + ", or did you just want to waste my time?</i>\"\n\n");

	if (pc.cor() < 33) output("It seems there's still a spark of Ceraph's fire under all her submission.");
	else if (pc.cor() < 66) output("You sigh and wonder if you should punish her for giving you such lip.");
	else output("You slap her across the face for her temerity.");

	//dynStats("tou", -1, "cor", 1);
	pc.cor(1);
	if (flags["COC.PC_FETISH"] == 3) flags["COC.PC_FETISH"] = 2;
	else if (flags["COC.PC_FETISH"] == 2) flags["COC.PC_FETISH"] = 1;
	else if (flags["COC.PC_FETISH"] == 1) flags["COC.PC_FETISH"] = 0;
	//Back to follower menu
	processTime(10);
	addNextButton(ceraphFollowerAppearance);
}

//*Fuck Ceraph's Pussy (Zeddited)
private function fuckFollowerCeraphsVagoo():void
{
	var x:Number = pc.cockThatFits(cockVolume(115));
	if (x < 0) x = 0;
	var y:Number = pc.cockThatFits2(cockVolume(115));
	clearOutput();
	//spriteSelect(87);
	//*Summary: Bind Ceraph's arms behind her back and make her lie facedown in the dirt, then grab her ankles and wheelbarrow fuck her, with her face as the wheel.
	output("You let Ceraph know that you'll be using her pussy.  She sighs and says, \"<i>Yes, " + pc.mf("Master", "Mistress") + ",</i>\" unable to hide the disappointment in her tone.  Ceraph shifts, the panties of her outfit fading away to reveal her dripping cunny");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(" and half-erect, throbbing cock");
	output(".  ");
	if (pc.cor() < 33) output("She gets down on all fours, then lays her cheek in the dirt.  Her arms cross behind her back, suddenly bound there by the abrupt appearance of those same panties, tied in a knot.  Supported by only her knees, her tits, shoulders, and her face, she asks, \"<i>Grab me and fuck me " + pc.mf("Master", "Mistress") + ", please grind your slave's face in the dirt!</i>\"\n\n");
	else if (pc.cor() < 66) output("She gets down on all fours, then lays her cheek in the dirt.  Her arms cross behind her back, and you pin them there for her, smiling as her panties appear as if by magic, tied in a binding knot around her wrists.  With only her knees and upper body supporting her, Ceraph begs, \"<i>Be rough with me.</i>\"\n\n");
	else {
		output("You push her onto all fours, then grab her arms and fold them behind her back, grinding her face into the dirt.  The demoness groans, her pussy dripping ");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("and her dick releasing a squirt of pre-cum ");
		output("as she gets more turned on by the rough, sexual play.  Suddenly, as if by magic, her panties appear around her wrists, and you tie them tightly to bind her securely.  With only her knees and upper body supporting her, Ceraph begs, \"<i>Be rough with me.</i>\"\n\n");
	}

	if (pc.cor() < 33) output("Well, that wasn't quite what you would have thought of doing, but you've got a good idea what she wants, and you may as well go along with it.  The idea of taking her in such a rough, hard way stirs something primal within you, and you have an easy time slipping into a meaner, rougher persona.");
	else if (pc.cor() < 66) output("Well, with a request like that, you'll have no problem fucking her rough and hard.  The situation evokes something primal within you, and the inviting delta between Ceraph's thighs practically beckons you to ravage it.");
	else output("With an invitation like that, there's no way you'll decline.  Looking over her, a predatory thrill runs through you, urging you to utterly violate her.");
	output("  You grab Ceraph's thighs");
	if (pc.physique() < 30) output(" and heave, lifting her up off the ground and forcing her to straddle you.");
	else output(" and easily lift her, forcing her to straddle you.");
	output("  Dragging the demon back, you bring her slutty, sodden puss up to your " + pc.cockDescript(x));
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(", ignoring the rope of dangling pre-cum that hangs from her bumpy prick.");
	else output(", feeling the heat washing off her mons and onto your [pc.cockHead " + x + "].");
	output("  Yanking back, you bury all " + num2Text(Math.round(pc.cocks[x].cLength())) + " inches of your " + pc.cockDescript(x) + " into Ceraph's unholy, warm snatch, ");
	if (pc.cockVolume(x) > cockVolume(150)) output("distorting her body around the sheer bulk of your massive member.");
	else output("immersing yourself in the decadent wetness.");
	pc.cockChange();
	output("\n\n");

	output("For a moment, the two of you simply stay like that: you buried to the hilt and her moaning in the dirt.  Ceraph's arms are flexing against her bondage as if she could rip through the latex panties by sheer force; though she could free herself by magic, she's chosen to struggle in futility.  Perhaps she accepts her bondage as a true submissive slut should?  Deciding it's time to reward her, you squeeze her thighs again and languidly withdraw, gazing at the marvelous wetness now soaking your tool.  The demoness whimpers at the emptiness, her voice carrying only simpering, anguished desire.  Lazily, you slide back, gently rocking her body when your crotches clasp together, twisting Ceraph's face.\n\n");

	output("Your slut moans, \"<i>Ohhhh, yesssssss,</i>\" while you slide home, culminating in an inarticulate gurgle.  Heavy drops of drool hang from her lips, turning the earth below into a thin layer of viscous mud for your pet to pillow her head in while you rail her.  Starting slow, you gently work your whore's pussy over, gleefully watching her girlish lube drip from the puffy, purple lips of her sex.  ");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("Her cock dangles towards the ground, dripping thick ropes of pre-spunk as readily as her pussy.  ");
	output("Somehow, she feels as tight around your " + pc.cockDescript(x) + " as any virgin and three times as wet.  The gentle claps of genital against genital send ripples through Ceraph, smearing her cheek in the growing mud-puddle while her tits wobble dangerously inside the sheer latex bra.\n\n");

	output("\"<i>M-more!  Harder, " + pc.mf("Master", "Mistress") + "!</i>\" the demon pants as she crosses her legs behind your back, as if it could somehow stop you from pulling the whole way out.  You hold her one handed, just long enough to crack your palm against her tight, toned ass, and then you pick up the pace.  Now that you're fucking her faster, the slut isn't even trying to talk anymore.  Her hair is plastered against her scalp, stained brown by the mud, and her arms are slack in the restraints.  Ceraph gives every impression of being utterly resigned to being fucked like a toy, used without care for her own feelings or emotions.  Knowing that you've taken a powerful dominatrix and turned her into... this - it sends a chill up your back, invigorating your fast-pumping hips.\n\n");

	//(DOUBLE PENN!) 
	if (y >= 0) {
		output("A wicked idea crosses your mind, and you reach down to grab your " + pc.cockDescript(y) + ", aiming it at the flexing asshole just above the slave's squelching snatch.  Your next thrust plows it deep into Ceraph's anus, thankfully lubricated by the demon's constant squirting.  Growling at the mounting, doubling pleasure, you resume your tempo and slam both your cocks hilt-deep in Ceraph.  ");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("She squeals and sprays a thick rope of jizz from her bloated cock.  It seems a little prostate pressure was all it took to put her maleness over the edge.  ");
		output("Your slave's reaction is to wiggle her backside at you and curl her tail about your waist, trying to pull you even further into her body.  Delirious and high on pleasure, you " + pc.mf("chuckle", "giggle") + " and pound away, heedless of anything but your own pending climax.");
		if (pc.cockTotal() >= 3) {
			output("  Sadly, your extra penis");
			if (pc.cockTotal() > 3) output("es have nothing to do but slide across her cheeks, dripping pre-cum all over her smooth skin.");
			else output(" has nothing to do but slide across her cheeks, dripping pre-cum all over her smooth skin.");
		}
		output("\n\n");
	}
	//(Single Penn!) 
	else {
		output("Working the bitch harder and harder, you start slamming your " + pc.cockDescript(x) + " so violently into the captive puss that Ceraph's sliding a few inches through the mud with each push.  Her cunt starts squeezing and contracting, tightening even more than you would have thought imaginable.  With such a vice-like twat, you're having a hard time even pushing back inside.  Sighing, you hilt yourself and let the wringing, milking tightness work you.  Not wanting to let your slave assume control of the situation, you start spanking her, bringing your palm down hard enough on her ass to leave hand-prints behind from the blows.  Her tail curls about your waist protectively");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(" while her cock spews ropes of pre-cum into the dirt");
		output(".  Holding still for the sucking, squeezing embrace, there's little on your mind but punishing your slut and enjoying the feel of your coming climax.\n\n");
	}

	output("With a shuddering explosion of warmth, you cum.  Ceraph groans loud and low, her pussy happily caressing your " + pc.cockDescript(x) + " as it spews its potent load into her demonic womb.  ");
	if (y >= 0) output("Her asshole likewise gleefully devours the seed from your " + pc.cockDescript(y) + ", flexing wildly from the fluid injection.  ");
	output("You hold yourself there, deep inside the wanton hole");
	if (y >= 0) output("s");
	output(" and basting the corrupt slave's tunnel");
	if (y >= 0) output("s");
	output(" with sloppy spooge.  Ceraph screams, \"<i>Yes!  Yes!  Fuck me!  Fill me!  Use me " + pc.mf("Master", "Mistress") + "!  Pump me full of cum while you grind my whorish face in the dirt!</i>\"  Her voice goes ragged, high pitched and screaming");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(", and her cock starts pumping more demonic spunk into the mud");
	output(".  It trails off, though her pussy continues teasing your " + pc.cockDescript(x) + ", wringing the last of your seed from your [pc.balls].\n\n");

	output("Ceraph sighs, ");
	if (pc.cumQ() >= 700) output("rubbing her ");
	if (pc.cumQ() >= 1400) output("bloated, ");
	if (pc.cumQ() >= 700) output("bulging belly as she purrs, ");
	else output("purring, ");
	output("\"<i>Thank you... you're such a good dom for a horny bitch like me.</i>\"\n\n");

	output("You smirk and drop her into her own muddy cum-puddle, then help her up to her feet.  She's filthy, debased, and dripping ropes of your goo.  Ceraph gives you a kiss on your ");
	if (pc.tallness >= 80) output("chest");
	else if (pc.tallness >= 60) output("lips");
	else output("forehead");
	output(" and mouths, \"<i>Thank you.</i>\"\n\n");

	output("Nodding, you give her ass a slap and send her off, noting Ceraph has freed her hands at some point and returned them to their normal position.  She hasn't done anything about the sexual filth coating her body, but knowing her, she probably doesn't want to.");
	processTime(35 + rand(10));
	pc.orgasm();
	//dynStats("sen", -2, "cor", .25);
	pc.cor(0.25);
	addNextButton();
}

//*Ceraph TongueFucks The PC (Zeddited)
private function followerCeraphTongueFucking():void
{
	clearOutput();
	//spriteSelect(87);

	output("Desirous of being pleasured by your demonic slave, you spread out your " + pc.legs() + " to allow easy access to your [pc.crotch].\n\n");

	output("\"<i>Serve me with your tongue,</i>\" you command.\n\n");

	output("Ceraph nods, the barest hint of a twinkle in her eyes as she drops down to her knees in order to examine your vulva.  She meekly kisses your slit, planting her wet lips against your " + pc.vaginaDescript() + " for but a moment.  The demoness looks up you and licks you starting from your taint, through your labia, around your ");
	if (pc.lust() < 50) output("still-hooded");
	else output("engorged");
	output(" clit, and stops over your sensitive pubic skin.  Then, her tongue begins to extend from her mouth, hanging further and further down as if it were unspooling from a hidden reel in her throat.  Ceraph doesn't stop letting out more of the slippery organ until she's got three feet of tongue dangling between her tits.  Just looking at it there, undulating below your mons, makes you wet.\n\n");

	output("With a sharp intake of breath, she reels in the prodigious proboscis, shortening it down to a more usable ten or eleven inches.  Starting between her parted lips, the tongue thickens, becoming cylindrical in shape and widening until you're sure it's at least two inches across.  Veins pulsate and texture the demon's tongue as it fills, giving it a decidedly... phallic appearance.  The transformation finishes, capping Ceraph's cock-like tongue with a rounded, penile cap that completes the illusion.\n\n");

	output("The tainted slut winks and licks at you with the crown, coating it in moist, feminine wetness, letting you feel the warmth of her tongue-cock upon your flesh.  It feels wonderful, like being licked by a thick, flexible prick that's been slathered in saliva.  Slowly, agonizingly slowly, it works its way into your passage, pushing past your engorged outer lips to snuggle into your ");
	if (pc.wetness() < 3) output("moist");
	else if (pc.wetness() < 4) output("wet");
	else output("soaking");
	output(" canal.  She twists her flexible mouth-dick inside you, making sure to rub over your g-spot, and then she slides another few inches in, forcing what feels like half of it inside you.\n\n");

	output("Now breathing heavily, your " + pc.hipDescript() + " begin trembling, aching to mount the invading member, fuck it, mate with it; anything to sate your growing desires.  Ceraph gives you a knowing wink and sidles forward, sliding the last several inches through your spread nether-lips into the velvety embrace of your " + pc.vaginaDescript() + ".  You can feel it, squirming and rubbing inside you, twisting through your pussy with a slow, maddening purpose.  From time to time it brushes your cervix, but never hard, never painfully.  At the same time, it seems to always be in contact with your most sensitive places.  It makes you wonder if Ceraph has practiced this on herself at some point, and you briefly entertain the notion of the demon bent over, vigorously fucking her box with her perverted tongue-prick ravaging her purple pussy.\n\n");

	output("A jolt of pleasure blasts the image from your mind and nearly takes your " + pc.legs() + " out from under you.  With a start, you realize Ceraph has opened her lips wide enough to slurp your " + pc.clitDescript() + " into her mouth, and somehow, she's produced a second tongue to service it.  With the stimulation of a tentacular tongue constantly hitting your g-spot and a second oral organ ");
	if (pc.clitLength >= 3) output("fellating");
	else output("licking");
	output(" at your " + pc.clitDescript() + ", you start to shudder, trying to stave off what you know is coming.  You don't want Ceraph to get too uppity, thinking she can get you off this fast, but you're dangerously close, and her pumping, teasing mouth-cock is relentless.\n\n");

	output("You grab Ceraph's head and mash it against your sodden, constricting box, as you command, \"<i>Drink my cum, bitch.  Swallow all of your Mistress' slick leavings.  And don't think for a minute I won't punish you if you miss any.</i>\"\n\n");

	output("Ceraph closes her eyes and hums, her twin tongues redoubling their efforts inside you.  Every nerve ending inside your climaxing quim seems to explode at once, and with your back arched, you cum on your slave's face.  Ceraph gurgles in happiness, her voice muffled by the plush, feminine flesh quivering over her face.  She happily swallows every ounce of fluid you produce");
	if (pc.wetness() >= 5) output(", even though her cheeks are bulging and her throat struggles to devour all of the fountaining girl-spunk.");
	else if (pc.wetness() >= 4) output(", even though her cheeks are slightly bulged and she's gulping it down.");
	else if (pc.wetness() >= 3) output(", even though she has to gulp it down from time to time.");
	else if (pc.wetness() >= 2) output(", even though you produce enough for her to gulp.");
	else output(", even though your pussy doesn't gush like most of the corrupted creatures in this realm.");
	output("  Still shaking and clenching, you start to come down, still holding Ceraph in her proper place.  She doesn't show any sign of discomfort, and as a matter of fact, once you deign to look down at her, her eyes are twinkling happily and her face is flushed.  ");
	if (flags["COC.CERAPH_TONGUE_FUCKS"] == 0) output("Did she... get off with her tongue?\n\nSeeing the confusion on your face, Ceraph releases your spit-slathered genitals, her tongue returns to normal, and she says, \"<i>Mmm, of course, dear.  If only men knew what they were missing... tasting a woman's pussy while it climaxes on your cock is divine.</i>\"\n\n");
	else output("Shuddering, Ceraph returns her tongue to normal and slides it out of your tender quim with a knowing smile.\n\n\"<i>I'll never get tired of that, " + pc.mf("Master", "Mistress") + ",</i>\" she quips.\n\n");

	output("You pull her back to your " + pc.vaginaDescript() + " to lick the last of your lady-spunk from your nethers, then send her on her way with a smile on your face.  Your expression widens when you see Ceraph stagger, still a bit shaky from her own orgasm.");
	IncrementFlag("COC.CERAPH_TONGUE_FUCKS");
	processTime(35 + rand(10));
	pc.orgasm();
	//dynStats("sen", -2, "cor", .25);
	pc.cor(0.25);
	addNextButton();
}

//*Ceraph goes full tentacle and double penetrates herms (+ standard dick BJ if ceraph dick toggle is on) (Zeddited)
private function ceraphTentacleGrape():void
{
	clearOutput();
	//spriteSelect(87);

	output("You tear off your [pc.gear] and instruct Ceraph, \"<i>Please me.  All of me.</i>\"  To her credit, Ceraph only spends a moment eyeing you before she springs into action.  Her panties vanish into shreds of flying latex, utterly demolished by the sudden growth of a pair of purple, undulating tendrils, each tipped with a swollen cockhead.  Squeezing up behind them is a third, slower tentacle.  Unlike its brothers, this one is capped with a sucking orifice, drooling clear slime and ringed by nub-like nodules, peeking out from folds of skin that remind you of clitoral hoods.");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  You can vaguely see Ceraph's hard, demonic-dick underneath all the waving tentacles.  She must have taken your command to keep her dick out for your use quite literally, even though there's little chance you'll get to put it anywhere.");
	output("\n\n");

	output("The two amethyst cocks wind their way over your " + pc.legs() + " and lift you into the air with unholy strength, dangling you upside down while they crawl over your body, the smooth skin rubbing and stroking at your " + pc.skinFurScales() + ".  They curl up and slide through your hands, allowing you to feel the inhuman warmth of Ceraph's passion.  Smiling, you indulge your slave, marvelling at the incredible degree of control she has over her shape-shifting.  Ceraph slides the two phallic tendrils between your loins and butt-cheeks, threading one in from the front and the other from the back.  They grind on your " + pc.vaginaDescript() + " and " + pc.assholeDescript() + ", teasing you, giving time for you to get as wet as possible.\n\n");

	output("A warm, sucking orifice aligns itself with your [pc.multiCocks], making obscene squelching noises as it dilates to take ");
	if (pc.cockTotal() == 1) output("all of your girth");
	else output("in all of your members simultaneously");
	output(".  You arch your back in pleasure, trying to push even more of your tingling cock-flesh into the tentacle-pussy.  The interior is FLOODED with lube, so much that it leaks from the clit-ringed seal at your ");
	if (pc.hasSheath()) output("sheath");
	else output("base");
	output(".  Even better, there are what feels like thousands of wriggling cilia squirming in the syrupy tunnel, each of them caressing and licking at [pc.eachCock] repeatedly.  Like thousands of hungry tongues, they seem to set off every nerve in your [pc.cocks], nearly making you forget the rhythmic, pulsating suction of the tendril as it fellates you.\n\n");

	output("You get so distracted by this that you forget your " + pc.vaginaDescript() + " for a moment, at least until the two fat cock-heads pressing at your lips and pucker jerk your attention back.  They hesitate for but a moment, just long enough to drool pre-cum over your orifices before slithering inside.  Each enormous, bulbous head spreads you wide.  They stretch your holes loose until each of them pops inside, the undulating tentacles pushing their tips as deeply inside you as they can.  Feeling utterly violated, completely full, and mercilessly fucked, you gasp and drool, every sexual part of your body being attended to by Ceraph's perfectly crafted sex-tools.");
	pc.cuntChange(0, cockVolume(24), true, true, false);
	pc.buttChange(cockVolume(24), true, true, false);
	output("\n\n");

	output("Whipping through air increasingly humid with evaporating sweat and sexual juices, you find yourself suspended before Ceraph, hanging upside down.  Her eyes are low, lidded and filled with lust, much like you imagine your own must appear.  She's softly panting, small bursts of pleasure escaping her slightly parted lips with each thrust of the tentacles into your body and each pulsation of your trapped cock");
	if (pc.cockTotal() > 1) output("s");
	output(".  She exhales, \"<i>Might... might your slave... have a kiss, " + pc.mf("Master", "Mistress") + "?</i>\"\n\n");

	output("You smile and nod, licking your lips as the tentacles bring you lower and closer, still fucking you.  Ceraph latches onto your lips, her tongue making love to your mouth while you hang, suspended in her tendrils' grip.  Spit-slathered mouths press together harder, and you french-kiss your demonic slave as passionately as you can, trying to do to her mouth what her cocks are doing to your " + pc.vaginaDescript() + " and " + pc.assholeDescript() + ".  You swoon, lost in the fast-fucking, slow-sucking, and eager tongue-thrusting of each other's oral orifices.\n\n");

	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0 && int(flags["COC.CERAPH_THROAT_FUCK_PUNISHMENT"]) == 0) {
		output("Suddenly pulling you back, Ceraph lowers you down further, spearing her pulsating, pre-cum soaked prick into your throat.  You gurgle from the sudden intrusion and the slippery, sweet cream she's leaking.  She might need a punishment later, but for now, there's nothing to do but suck.  You slurp and lick, the motions coming easy to you thanks to the silken caresses of the sloppy cunt-tentacle's cilia around your own [pc.cocks].  Her nodules bulge out in your mouth, rippling in wave-like motions from her base up to the fat cock-tip, signalling that her orgasm is at hand.  The thick, textured cock explodes, pouring Ceraph's load straight into your mouth.  At the same time, the dick-tentacles in your pussy and ass release their own seed, stuffing your womb and rectal cavity so full of cum that you're left with a bit of extra pudge in your belly.  You swallow and gulp, trying to keep up with the demon's hot, spouting jizz.  After a moment, Ceraph's control loosens, and you're pulled up into the air, temporarily freeing your mouth.\n\n");
	}
	else output("Suddenly pulling you away, Ceraph throws her head back and moans.  You can feel the tentacles piston faster, and through your haze of arousal, you realize she's about to orgasm.  The warning does little to prepare you for what's coming, and as one, the twin tentacles blast cum deep into your nethers and asshole, stuffing both body cavities full of potent demon-sperm.  It's warm - hot even - and your innards tingle and soak in the corruptive spooge while they continue to pump more inside.  After a few spurts, you feel absolutely stuffed and even have a bit of extra pudge on your belly from the hefty fluid-filling.\n\n");

	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("Ceraph's cock sprays cum all over her belly as her climax winds on, her poor, ignored prick blasting seed with reckless abandon.\n\n");

	output("Your body seizes up and explodes with pleasure, spraying sexual fluids into and over Ceraph's new additions.  The cunt-tentacle ");
	if (pc.cumQ() >= 800) output("bulges wide from the sheer size, sucking");
	else output("sucks");
	output(" down your cum as it erupts from your [pc.multiCocks].  As it swallows every drop, you hazily wonder what she'll do with it all, but then the still-fucking tentacles move faster, spraying their cum out from your too-packed orifices to rain over both of you.  Your " + pc.vaginaDescript() + " and " + pc.assholeDescript() + " flutter and contract, involuntarily squeezing the purple-skinned invaders for even greater levels of sensations.  It's too much and too hard.  You black out with a moan of satiated pleasure.\n\n");

	output("You come to in a puddle of cum, both yours and Ceraph's.  The demoness is sitting down across from you, her appearance returned to normal.  She brightens when she wakes and kneels, saying, \"<i>Thank you for allowing me to serve you so... completely, " + pc.mf("Master", "Mistress") + ".  It was... thrilling.</i>\"\n\n");
	processTime(35 + rand(10));
	pc.orgasm();
	//dynStats("sen", -2, "cor", .25);
	pc.cor(0.25);
	
	//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 32, 61); //Ceraph causes faster pregnancies
	pc.loadInCunt(ceraph);
	
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0 && int(flags["COC.CERAPH_THROAT_FUCK_PUNISHMENT"]) == 0) {
		output("You smirk and wonder if you should punish her for stuffing her cock down your throat.  Do you?");
		addButton(0, "Punish", punishCeraphForSurpriseThroatFuck);
		addButton(1, "Leave", mainGameMenu);
	}
	//ELSE: 
	else {
		output("You nod graciously and begin to clean up, dismissing your personal demon... for now.");
		addNextButton();
	}
}

//[Punish Her]
private function punishCeraphForSurpriseThroatFuck():void
{
	//spriteSelect(87);
	flags["COC.CERAPH_THROAT_FUCK_PUNISHMENT"] = 1;
	clearOutput();
	output("You grab hold of Ceraph, bending the surprised demoness over a rock and laying into her ass.  She whimpers, but manages not to cry, even as you turn her purple butt into a black and blue canvas.  With each slap you deliver, you dictate that her cock is only allowed near your mouth at YOUR discretion, not a worthless slave's.  By the end, she's sniffling and nodding, murmuring, \"<i>Yes " + pc.mf("Master", "Mistress") + ",</i>\" over and over again.</i>\"\n\n");
	output("You let the demon go with her pride bruised.  There's little doubt to be had - she'll never make that mistake again.");
	processTime(4);
	addNextButton();
}

//Siamese Catgirl Twins - TDM (Zeddited, nya)
public function catgirlEncounter():void
{
	clearOutput();
	//requires that the PC have a cock, just to keep it simple, no centaurs and probably not slimes
	output("You call on Ceraph, but are a bit taken aback when she doesn't appear right away.  You look around to see if you might have missed her, then spot something else streaking towards you from the wastes.  It is kicking up so much dust that you don't have time to see what it is before it ");
	if (!pc.hasPerk("Evade") < 0 && pc.reflexes() / 3 + rand(20) < 22) output("flies into you, knocking you to the ground.  After a moment, you find yourself faced with a pair of overeager cat-morphs grinning down at you.");
	else output("just barely misses you and crashes into the ground behind you.  After a moment, two bodies disentangle themselves from the impact site.  Once they stand up, you can see that a pair of overeager cat morphs have arrived in your camp.");
	output("\n\n");

	//describing your new friends
	output("You study them for a few moments.  They have glossy, soft, and pliable fur covering most of their bodies, generally with a whitish or mother-of-pearl tone.  That color gives way to darker layers on their legs and face, giving them a mischievous, owlish look.  They have feline legs with paws, but their arms look more like fuzzy hands with pads.  Long, flexible tails swish behind them, and pointy cat ears adorn the tops of their heads.  Their chests bear generous E-cup breasts, with small bare patches further down where other pairs of nipples poke out.  They have kittenish, clear blue eyes that lend an air of innocence to them, but the small horns on their foreheads suggest anything but.  Being Ceraph's pets, they are predictably perforated with piercings on their ears and tails.  One thing that plays over and over in the back of your mind is that the two are completely identical; <b>you're facing a pair of siamese cat twins</b>!\n\n");

	output("As a chorus, the two start to speak.  \"<i>Mistress Ceraph couldn't come, so she has sent us to help you with your needs; the sisters are here for your pleasure.</i>\"  The choice is yours; do you play with these furry, eager, cat-faced girls, or send them away?\n\n");

	//player chooses sex, no sex(, extermination)
	clearMenu();
	addButton(0, "Sex", fuckCeraphsCatgirls);
	addButton(1, "Leave", declineCeraphsCatgirls);
}

//No sex
private function declineCeraphsCatgirls():void
{
	clearOutput();
	output("You shake your head at the kitty sisters and tell them that you aren't interested in fucking cats; you wanted the sexy demoness you were promised.  The two mewl meekly before slumping away.");
	//to camp menu
	addNextButton();
}

//SEX!
private function fuckCeraphsCatgirls():void
{
	clearOutput();
	var x:Number = pc.biggestCockIndex();
	output("You smile at them and say that you'd be happy to have them for your pleasure; their horns suggest that they'll be quite a trip.  The two purr happily and instruct you to lie on your back to start the fun.  You relax as directed and the cat slaves unfasten your [pc.gear] from your body.  As they work, they make sure to gently stroke every inch of your newly exposed flesh with their soft furry hands as it's revealed; all the while moving closer and closer to your most personal parts.  When your [pc.multiCocks] finally tastes the air, it gets even more attention.\n\n");

	//purrfect tit fuck
	output("You can't help but put your hands to their heads and start rubbing and scratching them behind their ears.  Suddenly, one of them steps back as the other moves down in front of your " + pc.cockDescript(x) + " and pulls it inside her breasts.  In response, both your hands end up on her head, forcing it down onto your cock, and you feel your manhood start to vibrate as the catgirl begins to purr.  You cry out in pleasure at your shaft being massaged by soft-furred breastflesh while she hums into the tip.\n\n");

	//play with da boobies
	output("The other sister has been looking for something else to rub herself on, and she seems to have decided on your " + pc.chestDesc() + ".  While your lower half is being covered by one cat (which is fine too), the other moves to your top half and drapes her breasts over your head while she gropes and plays with your [pc.nipples].");
	if (pc.isLactating()) output("  When some of your [pc.milk] seeps out, she leans forward and latches onto a nipple eagerly, alternating between sucking on the tip and licking the drops off of it.");
	else {
		output("  She seems to delight in playing with her chest, modest though it may be, pushing it into your face and tweaking the fuzzy nipples just past your nose.  You blow a raspberry and shake your face into her cleavage, ");
		if (rand(5) == 0) output(" but some of the fur tickles your nose a bit <i>too</i> deeply; you deliver a sudden sneeze into her bosom, causing it to heave and jiggle.");
		else output("vibrating it wildly back and forth.");
	}
	output("  Her sister, watching all this, shakes with muffled laughter delivered directly into your cockhead, sending rough jolts of sensation down the shaft and forcing out a drop of pre-cum.\n\n");

	output("The cat lying on your face sits up as her sister's eyes glimmer desirously upon tasting the drop; apparently she has recognized the expression, because she looks down at you and says, \"<i>Please, don't give all your rich, tasty cream to my sister.  She always steals my fair share, the bad kitty!</i>\"  Her meaning is obvious in context, moreso when she moves around to your groin, trying to shoulder her sibling aside and ");
	if (pc.cockTotal() == 1) output("sliding her hand between the furry tits, down the base of your " + pc.cockDescript(x) + ".");
	else output("grabbing the lonely, neglected dickflesh left outside the warm embrace of her sister's breasts and shoving them into her own while caressing the tip with her tongue.");
	output("\n\n");

	output("Thanks to all the stimulation from before, their expert tongues almost immediately bring your body to a shuddering orgasm, and [pc.eachCock] ");
	if (pc.cumQ() >= 1000) output("unleashes a torrent of ejaculate, coating the two girls liberally; each yowls in happiness, slurping at the nearby cock-head and swallowing mightily.");
	else if (pc.cumQ() >= 300) output("lets out a generous load of 'cream' which each girl sloppily gulps down, lapping at the jism and its source roughly.");
	else output("squeezes out a few immodest squirts of semen, which the girls push and fight over, each vying to be the one to gulp down the next stroke.");
	output("\n\n");

	output("You relax on your back, spent from the treatment and the orgasm; the kitty twins");
	if (pc.cumQ() >= 1000) output(" clean the remnants off of their fur eagerly, mollified by the sheer amount into actually helping lick each other clean with their tongues, and");
	output(" thank you for the 'cream'.  You nod weakly and they jump to their feet and swish their tails at you, then depart.\n\n");

	//lust to 0, corruption +0.5
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("lib", -1);
	pc.slowStatGain("l", -1);
	//end scene
	addNextButton();
}

private function ceraphUrtaRoleplay():void
{
	//kGAMECLASS.urta.urtaSprite();
	clearOutput();
	output("\"<i>Roleplay? My " + pc.mf("Master", "Mistress") + " is wonderfully exploitative with " + pc.mf("his", "her") + " pet's lewd body,</i>\" Ceraph purrs, lips curling into a sly smile. Holding your arms at your sides, you nod at the subjugated demon, indicating that she should strip you. Keeping her eyes averted, she obediently complies, removing your [pc.gear] piece by piece until you stand nude, in all your splendor. Turning upon her, you issue your curt command, briefly describing the form that she is to take. Surprisingly, she knows exactly who you're talking about. \"<i>Ah, the fox-bitch,</i>\" she muses, eyes flashing solid black again for a moment. \"<i>She's been such a thorn in my side for so long... letting you defile her will be a particularly intense pleasure, " + pc.mf("Master", "Mistress") + ".</i>\"\n\n");

	output("Breathing deeply, she shudders, her whole body shaking like a dog coming out of the rain. When she finishes her spasm, you see that her lavender skin is now covered by a fine coat of grey fur which grows and thickens in seconds until there is no trace of her smooth flesh or her latex outfit. She bites her lower lip and the long, thin appendage curling from the demon's ass puffs outward into a bushy fox tail while the hair on her scalp fades to a smoky, ashen color, streaked with black highlights. Seizing her curling horns, Ceraph strokes them languidly, the bone melting in her grasp like putty, allowing her to sculpt them into sharp, narrow ears that twitch uncertainly. Placing her fingers at the bridge of her nose and her thumb under her jaw, she cocks her head to one side and yanks forward, her skull deforming as the front of her face is pulled into a vulpine muzzle, lips thickening into a glistening black pucker as she blows you a kiss.\n\n");

	output("Sweeping her hands about in deference, Ceraph curtseys to you and raises her stolen face, eyes twinkling green behind her medium-length bangs. \"<i>With your permission, " + pc.mf("Master", "Mistress") + ", the final touch.</i>\" You nod, a grin already creeping at the sides of your mouth. Eagerly, the fiend takes hold of her demonic shaft- hard as much from the transformation as your lascivious stare- both hands wrapping around the demonic phallus gingerly. Licking a long, pink tongue over her inky lips, the shapeshifter begins to jerk herself off, sliding her palms up and down the pulsing, bumpy dick with quickening strokes. Her mouth hangs open and she rolls her eyes up as the frantic pace sends her furred chest wobbling and her lashing tail twitching frantically behind her. Gradually, you notice that her brutal pace seems to be lengthening the demon's organ, swelling firmness bloating it larger and longer, purplish hue darkening and darkening until it fades to a ruddy burgundy at the tip, fading to a velvet black at the base. \"<i>Oh " + pc.mf("Master", "Mistress") + ", your wish is my command</i>\" she gasps, her oily voice turning richer and huskier with every syllable, until it is an exact echo of Urta's. The resculpted horsecock throbbing in her hands lurches forward to its full 20 inches as her tip flares out, thick jets of ropey cum bursting from the fox-girl's equine member. As it jerks in her hands, a fuzzy, ebony sac drops from the puffy sheath of her jizzing cock, trembling balls dropping heavily into the scrotum. When she's finally done, the captain of Tel'Adre's City Guards stands before you, panting, her still-dripping cock in one hand, a tall bottle of whisky in the other, creamy pools of cum all around her.\n\n");

	output("\"<i>Oh! " + pc.short + "! I, um, didn't expect to find you here! This... this isn't what it looks like,</i>\" she apologizes, flushing deeply, nervous shame sending humiliated shivers through her shoulders. She longingly eyes the bottle in her hand and, without lifting her head, raises her eyes to yours, silently asking what she should do.");

	//[Drink][Sober]
	clearMenu();
	if (pc.hasCock()) addButton(0, "Sober", ceraphUrtaRoleplaySober);
	else addDisabledButton(0, "Sober", "Sober", "This option requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "Drunk", ceraphUrtaRoleplayDrunk);
	else addDisabledButton(1, "Drunk", "Drunk", "This option requires you to have vagina.");
}

//DRANK AS FCUK
//[Drunk] (female/herm only. No centaurs)
private function ceraphUrtaRoleplayDrunk():void
{
	clearOutput();
	//kGAMECLASS.urta.urtaSprite();
	output("You wish her a cheerful 'bottom's up,' relief washing over her face as she seeks shelter in the blissful oblivion of alcohol. Lifting the bottle's fluted neck to her polished lips, Urta throws back her head and begins swallowing. Her throat bulges in rhythmic gulps, air bubbling up through the liquor as the whiskey steadily vanishes into her shame-thirsty gullet. Her face flushes deeper, the bitter sting of booze taking her mind off of the embarrassment of her equine attributes. Her cock throbs in the open air with each noisy glug, dollops of cum still drooling from her engorged member. Finishing the entire bottle, the fox-morph wetly sucks down a fresh lungful of air, her expression floating somewhere between stimulated joy and dazed confusion. She looks closely at the bottle and blinks several times. \"<i>Wh- what did you put in this?</i>\"\n\n");

	output("With a shrug, you admit that you're impressed she noticed the little additive. It seemed unlikely she would've tasted much of anything with how quickly she slurped down her liquid vice.  Grinning, you ask her how the black egg tasted. Urta's mouth hangs open, inebriation sinking its talons into her brain one by one, but after a moment, the realization dawns on her. Before she can voice her outrage, the change begins, Urta's body cringing with twisting spasms. She drops the bottle and clutches at her stomach, but when she raises her hands again, strands of light grey fur scatter into the wind from between her fingers. Falling to her knees, she begins itching, frantically, more of her ashen hair sloughing off as if she were shedding uncontrollably. Watching the girl paw at herself wildly, you bend down, close to her face, and when her head turns up to speak, you give the vixen a flick across her nose. She snatches her sensitive muzzle with a whine, hands wrapping around it as she writhes on the ground, fur falling away with each trembling shake.\n\n");

	output("When Urta finally stops shuddering, the vulpine guard looks very different. The silken coat of grey fur that once patterned her lean, athletic torso has been removed, to reveal the soft caramel of her dusky-hued skin. While her lower legs and pawed feet retain their leaden pelt, they now more closely resemble stockings than natural body hair. Her tail seems unaffected as well, fluffy fur twitching from the junction just above her taut ass, raw sienna globes shining from the sweat of her transformation. Moving your gaze further along her dark amber body, you find two sharp, sliver fox ears poking out of the black-striped argentine hair on her head. Beyond these spots, however, it seems the girl has lost all of the fox hair that previously covered her, from her knees up to her eyebrows. Shaking her head, the Captain of Tel'Adre's city guard takes her hands from her face and almost leaps backward in surprise. Her muzzle is gone, replaced with a small, humanoid nose and plump, ebony lips just beneath it. Her startlingly human features cause the intoxicated girl to press her fingers against the burnt sugar of her skin, soft flesh highlighting the high cheekbones of her feminine face. She runs a hand through her hair, not sure what to think and too drunk to form an opinion.\n\n");

	output("Grasping her shoulders and lifting her gaze to yours, you stare into Urta's emerald eyes. With a signing breath, you whisper that she's never looked more beautiful, and press forward, your lips eagerly finding hers. She twists her head too far to the side, trying to compensate for a muzzle that's no longer there before giggling into your mouth and turning back too far, bumping her nose against yours. She lets out a brief bark of laughter and moistly kisses your forehead, running her hands unsteadily down your " + pc.skinFurScales() + ". \"<i>So, you like me this way, huh? Well, now it's my turn. Bottom's up!</i>\" She pushes you backwards harder than she'd intended, knocking your head against the soft ground before grabbing your " + pc.hipDescript() + " and flipping you onto your " + pc.allChestDesc() + ". Looking back over your shoulder, you see the girl tweaking her pale, pink nipples which stiffly rise from the generous swell of her olive breasts. A warm, firm thwack between your ass cheeks tells you that neither the alcohol nor her first orgasm has affected the herm's raging hardness. As she slides her cock up and down, between the pillowy orbs of your rump, you can feel every contour of her twenty inch horsecock- from its bulging veins to the ringed lip of her fleshy sheath to the smooth, cool skin of her refilling scrotum, heavily slapping against your inner thighs. You squeeze your " + pc.buttDescript() + " in time with her long strokes, stroking the shaft between your globes as she quickens the pace. She can't keep her hands off her new body, it seems, the guards-woman rubbing her palms over her breasts, belly, arms, and hips, feeling her flawless flesh as eagerly as she hotdogs your " + pc.buttDescript() + ".\n\n");
	//dynStats("lus", 125);
	processTime(10 + rand(5));
	pc.lust(pc.lustMax(), true);
	//[Next]
	addNextButton(ceraphUrtaRoleplayDrunk2);
}

private function ceraphUrtaRoleplayDrunk2():void
{
	clearOutput();
	//kGAMECLASS.urta.urtaSprite();
	output("The cock sliding up your backside throbs in anticipation and you realize that Urta's over-stimulated herself. Lips parting in a whorish moan, she climaxes, her fingers digging into her soft, smooth skin as her massive shaft flares thicker than you've seen before, gouts of thick jizz arcing from her head. You can feel the voluminous loads surging between your cheeks before bursting from her tip and cresting through the air before splattering down in cords of creamy cum. All along your back, neck, hair, and face, sticky wads of spunk douse you in the fox-girl's excitement and you squeeze your rear as tightly as you can to massage out every last ladle of her rich seed. She bathes you a pale off-white but to your surprise, she's still moaning and stroking the skin of her changed body. \"<i>It's not enough,</i>\" she mumbles, \"<i>I need more.</i>\" You start to rise, but the drunk girl slams her palms onto your shoulders, planting you back into the ground, body horizontal beneath her. Sliding backwards, her engorged cockhead presses insistently against the juncture of your hips, still bubbling with dollops of cum.  \"<i>It's too sensitive,</i>\" she whines, pinning your lower body between her muscled legs.  Your struggles to get out from under the drunk, horny girl are fruitless, so you turn your head and see that her throbbing sac is- if anything- even larger than before, her cock still rock hard as she guides it up against your " + pc.vaginaDescript() + ".\n\n");

	output("\"<i>Oh damnit, damnit, damnit,</i>\" Utra chants as she presses her erection against your drooling slit, the equine inches slipping along the sweat-oiled plumpness of your thighs. Inching forward, she presses the flared tip of her head against your tender lips, the distended flesh struggling against the tightness of your snatch, lubricated depths unwillingly parting bit by bit until finally, the bulbous cockhead slips into you, your cunt tightening down around it, firmly locking the guard captain inside you. \"<i>Ah! Ffffffuck!</i>\" she curses.  \"<i>How are you always so tight?</i>\" she groans, happily. Unable to restrain herself, she begins bucking in place, sliding the first three inches of her throbbing member back and forth inside you, savoring the ripples her rocking motion sends through your " + pc.buttDescript() + ", your hypnotic hips mesmerizing the girl riding you. Raising an amber hand, she cracks an open palm against your tender ass as she drives another two inches inside you, your gut lurching with the force. You try to ");
	if (pc.isGoo() || pc.isNaga()) output("wriggle to a wider stance");
	else output("spread your legs");
	output(" to make the penetration easier, but the vixen has your lower body firmly trapped between her knees, keeping your hips as tightly clenched as possible, heart-shaped rump throbbing at the fleshy weight within you. \"<i>Don't you love the long arm of the law?</i>\" she snickers, hiccupping  as she gives you another swat across your " + pc.skin() + ", this time plunging half her length into your " + pc.vaginaDescript() + ", stealing the breath from your lungs. Your squirting honey leaks from between your lips, lubricating the girl's shaft all the way to the ring of her sheath. You can feel the ten inches of her shaft inside you lifting your abdomen off the ground a few inches and it's all you can do to dig your fingers into the dirt as she thrusts rapidly, shallow pulses leaving every inch of your body jiggling under her.");
	pc.cuntChange(0, urta.cockVolume(), true, true, false);
	output("\n\n");

	output("Pounding you faster and faster, you can feel her cock swelling within you dangerously. Rutting frantically, she leans down, pressing her smooth sienna skin against your jizz-soaked back, her tits rubbing the fox-girl's spunk into your " + pc.skin() + ". Lowering her head, she whispers into your ear, \"<i>No condoms for sneaky bitches who spike drinks,</i>\" her husky voice right on the edge.  \"<i>Fur isn't the only thing I've lost. I'm potent again,</i>\" she drunkenly insists. \"<i>I can feel it in my big, swollen balls.");
	if ((amilyFollower() /*|| marbleFollower()*/ || izmaFollower()) && !pc.hasTail(GLOBAL.TYPE_VULPINE)) output("  After I knock you up, try explaining the fox tails on your kids to those other bitches.");
	output("</i>\"  Reaching out to brace herself, Urta grabs your shoulder with her left hand, but her right goes wild and she ends up hooking her fingers in your mouth, jerking your cheek to the side. With the added grip, she wriggles deeper, the remaining inches snaking into your uterus until the elephantine flare rubs against your cervix, the bottom ridge of her fleshy sheath teasingly flicking against your swollen clit. Sensations crash over you: the gentle curves of her fit abdomen stroking your ass, her wobbling chest pressing button-stiff nipples into your back, the sweet taste of your tongue stroking the fingers in your mouth. It is too much and your body clenches down in a gushing orgasm on the invading member, drool leaking from your gaping mouth as your heavily lidded eyes lose focus, allowing the fox-girl to use you to her heart's content.\n\n");

	output("When she cums for the third time, you can feel the blast directly on your cervix, the force of her load parting the muscled sphincter, ropes of newly virile seed flooding your womb.  The weight of her distended scrotum pulses between your thighs and your belly bulges under the impregnating torrent. Urta's body tenses as she inundates your depths with the excess of her loins, the influx cascading through your uterus to burst like a tide, your body flush with her pouring jizz.");
	if (pc.hasCock()) output("  [pc.EachCock] releases its own glut in a sympathetic climax that turns the dirt under your body into sticky mud as your inflating gut spreads out from either side of your belly. Still cumming, Urta presses her lips to the back of your neck, kissing you softly in a gesture that almost seems to convey a sense of ownership as much as tenderness.  When she finally withdraws from your over-filled pussy, the glut of her semen bubbles out of your body in rolling waves of alabaster cream.  She rises, unsteadily, to stand over you, her cock finally drooping, thick strands of spunk still dripping between her engorged urethra and your spasming cunt.  \"<i>Hey, I can finally take a shower without smelling like a wet dog afterwards,</i>\" she realizes, happily. She reaches a hand down to help you up, her expression one of blissful satisfaction, but the experience was too much for you and you pass out. The last thing you see is the warm halo of her caramel face and the caring sparkle of her leafy eyes.");
	output("\n\n");

	output("You wake up before long and find yourself cleaned, though still a little sticky, as if someone had used their tongue to wash the cum from your [pc.skinFurScales].");
	processTime(10 + rand(5));
	pc.orgasm();
	pc.loadInCunt(ceraph);
	//dynStats("lib", -1, "sen", -2, "cor", 2);
	pc.slowStatGain("l", -1);
	pc.cor(2);
	//Preggers chance!
	//if (pc.hasVagina() && pc.totalFertility() >= rand(45) && pc.pregnancyIncubation == 0) {
		//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 32, 61); //Ceraph causes faster pregnancies
		//trace("PC KNOCKED UP WITH CERAPH IMPS");
	//}
	addNextButton();
}

//[Sober]
private function ceraphUrtaRoleplaySober():void
{
	//kGAMECLASS.urta.urtaSprite();
	clearOutput();
	output("You tell Urta to put the bottle down. She won't need that, not any more. She looks at you in confusion, setting the whiskey to one side, curling her tail between her legs to cover her throbbing member. Closing the distance between the two of you, she stiffens when you wrap an arm around the small of her back and bring the other hand up to her chin. She doesn't have to be ashamed any more, you explain, because you know the cure for her curse. The fox-morph's eyes light up, her mouth parting but not daring to speak or even breathe. Stroking a thumb along the line of her jaw, you close your eyes and nod slowly, pulling her into an embrace tight enough for you to feel the fluttering pulse of her body heat sinking through your " + pc.skinFurScales() + ". You can tell by the wobbling of her lower lip that she is dying to ask how, but you merely brush the dappled-grey bangs from her eyes, staring into the guard's emerald irises. You can feel the soft intake of her breath as it catches in her throat and she leans toward you ever so slightly, blushing. You meet her halfway, obsidian-warm lips pressing against yours tentatively at first, before gaining confidence. She sinks deeper into the embrace, the tight tension knotting her back slowly easing as surrenders her self-conscious shame for unabashed passion, relishing the intimacy of your caress. When you draw back from the intoxicating fever of the fox girl, you whisper one word to her: \"<i>Love.</i>\"\n\n");

	output("Urta stares silently, her expression shocked at first, before her restraint crumbles, tears welling in her eyes. \"<i>Th-thank you " + pc.short + ". I love you too! From the moment I met you, I barely dared to hope, but... oh thank you!</i>\" She throws her arms around your shoulders and hugs you with all her might, body trembling with joy. A moment later, her strength gives out and she sinks to her knees. \"<i>Ah!</i>\" she gasps in surprise, her cock twitching in the air. The massive, rock-hard shaft begins to shrink, inches of flesh sinking upward into her midnight sheath while her throbbing balls recede upward, into her abdomen, growing smaller with each passing moment. The horsecock shrinks down to twelve inches, then six, then three, the flared tip barely poking above the fine, ebony fuzz of her groin before her sheath too is pulled between her legs. Her balls vanish, body sealing over the purified orbs, the skin of her sac pulled tight until there is no trace they ever existed. Her cock is similarly cleansed, flesh healing over the blight of her male organ in the blink of an eye, leaving her pussy untouched, glistening with excitement.\n\n");

	output("The herm, at last restored to a pure woman, rubs the healed expanse of her abdomen, unbelieving, before leaping to her feet and excitedly seizing both of your hands. \"<i>I'm normal! No longer a freak! Oh, " + pc.short + ", I can never repay you for this. You've given me a new life! Please... won't you,</i>\" she gazes at you with a flush of anticipation, \"<i>won't you make love to me?</i>\" Pulling your hands to her hips, she steps close enough to kiss, but merely presses her forehead against your own, viridian eyes no longer clouded with coarse lust. Instead, they practically glow with the girl's ardor, her smile authentic and honest. Unblinking, you gaze into her eyes for a moment that stretches into an eternity, cupping a hand around her cheek. She reads your acceptance as clearly as if you'd been yelling it from the mountaintops and she returns your gentle smile, nuzzling her nose against yours.\n\n");

	output("Drawing you back to your cot, Urta sits on the cushioned bedding, knees spread as she leans back and braces herself on her elbows. You sink between her muscled thighs, rubbing your palms up the dusky fur of her hips as you bring your head toward her leaking pussy. The delicate folds of her labia are as dark as her nose, but there is a certain elegance in their plush depths, like the petals of a black rose guarding the nectar of the flower. You trace your tongue around the edge of her vulva, warm skin tingling with the faintest trace of the athletic guardswoman's perfumed sweat, exciting the tip of your tongue and making you draw it back into your mouth to savor the untainted taste of the girl's body. Placing small kisses on the puffy lips of her sex, you draw the girl's skin into your mouth with a gentle sucking, nibbling at the fox's flesh with only your lips as you gradually, achingly work your way up to the polished nub of her clitoris, engorged from your teasing oral stimulation. You stroke the sensitive flesh with the tip of your nose, brushing the swell of your lower lip across Urta's joy-buzzer. She moans, her hips swaying back and forth in time to your movements.");
	if (pc.horns > 0) output("  Unable to keep her hands at her sides, but unwilling to stand between your mouth and her slit, the fox-girl takes hold of your horns, pulling your face tightly against her mound, her chest tight with a barely audible squeak of delight. Stroking the tip of your tongue at the curtain of her sex, you allow her the barest trace of penetration before drawing back and placing a wet kiss on her clit. Enough foreplay.");
	//dynStats("lus", 200);
	processTime(10 + rand(5));
	pc.lust(pc.lustMax(), true);
	//[Next]
	addNextButton(ceraphUrtaRoleplaySober2);
}

private function ceraphUrtaRoleplaySober2():void
{
	//kGAMECLASS.urta.urtaSprite();
	clearOutput();
	output("You rise and run your hands along the lighter fur of her toned abs. \"<i>Please,</i>\" she whispers, \"<i>I want to feel you inside me.</i>\"  Your " + pc.cockDescript(0) + " is all too willing, throbbing meat sliding up and down her lubricated lips as you slowly rock back and forth. Bracing your tip at the pucker of her honey-slick passage, you take one of her hands in yours, entwining your fingers with a squeeze as you push into her. Urta jolts with a sharp intake of breath before relaxing herself and closing her eyes to focus on the sensation of your inflamed shaft parting her inner walls. You push in deeper, amazed at how wet she is already, the strength of her love for you intensifying every motion. Despite all the sexual encounters she's had before this moment, in this single instant, it's as if she's experiencing pleasure for the first time. Aching bliss coursing through her limbs, it's all she can do to gasp and slowly toss her head side to side as you sink deeper into the girl, her recesses filling with the almost liquid heat of your throbbing member.");
	if (pc.cockVolume(0) > cockVolume(150)) output("  Even your tremendous size is no impediment to blessing the girl with your passion- every inch of her body gives way as you sink into her beyond the limits you would normally expect, as if her body were perfectly tailored to yours.");
	pc.cockChange();
	output("\n\n");

	output("When you finally bottom out, the two of you are already panting, the sheer rapture of the penetration coaxing the two of you to the precipice of orgasm. You stop moving, just drinking in the moist pressure of her body clenching around you. Urta, in turn, can only wordlessly move her lips at the ecstasy of being so utterly filled, her breasts heaving on her chest, shimmering onyx nipples glinting at the tips of her mammaries. When the two of you feel you have mastered yourselves, you begin to pull back out, her trembling cunny grasping at your " + pc.cockDescript(0) + " as if regretting every lost inch. With a steady pace, you begin to thrust into the guard captain, her hips matching your motions eagerly. She strokes the tips of her fingers along your " + pc.chestDesc() + ", wrapping her hand around the side of your neck as the two of you rock the cot back and forth.  The vixen's pussy splashes with each pounding advance of your engorged shaft, her twinkling honey running between her thighs in gleaming rivulets. She locks her ankles around your " + pc.buttDescript() + ", using her legs to speed up your pace until you find yourself fucking the vulpine woman at a frenzied pitch. The two of you noisily, wetly slam against one another hard enough for the sounds of your passion to carry all over your camp and into the surrounding forest, cries of moaning gratification piercing the air.\n\n");

	output("When the two of you reach the crest of your climax this time, neither of you has the strength to hold back, triumphantly surging toward your simultaneous orgasms. Urta squeezes your hand so tightly your knuckles crack in her hands while her legs pull your " + pc.hipDescript() + " into an iron embrace. Your " + pc.cockDescript(pc.biggestCockIndex()) + " releases its fertile load into the girl's depths, liquid weight flooding her ravished canal with the creamy testament of your love.  She holds you inside her desperately, her pliant, sable lips murmuring her devotion to you with shuddering whispers.  When you finally finish, she keeps you within her a minute longer, savoring the sensation of your shaft surrounded by the rapturous warmth of your seed, before finally releasing her grip, allowing you to withdraw.  Sighing happily, she rubs her pussy lips as you slip out, a pearl bead of your jizz bubbling from her stuffed uterus. She runs her fingertips through the spunk, massaging the cum against the folds of her glistening labia. \"<i>You know,</i>\" she playfully murmurs, \"<i>now that my curse is broken, I'm not barren anymore.</i>\" She closes her eyes and takes a deep breath, cooing about the feeling of your silken sperm pressing against her waiting womb. You smile, despite yourself.\n\n");

	output("Retrieving your [pc.gear], when you turn around again, Urta is gone, the moment vanishing like a drop of water in an endless sea. \"<i>Thank you, " + pc.mf("Master", "Mistress") + ",</i>\" Ceraph's voice demurely whispers, gratitude floating on the wind.");
	processTime(10 + rand(5));
	pc.orgasm();
	//dynStats("lib", -1, "sen", -2, "cor", 2);
	pc.slowStatGain("l", -1);
	pc.cor(2);
	addNextButton();
}

//Corrupting the Innocent with optional gangbang -Luka (Zeddited) (with Shake N' Bake) (and Shambles helped)

//Demon cock supplied for PCs without one.
//This probably does not fit Pure PCs either. This should probably give the PC massive Corruption increase too.
//PC gets to pick if they want to offer the girl to be gangbanged by the imps or not.
//You will be fucking her with an audience.

//NOTE: This will probably need an alternate version for centaurs. Goo and Nagas should be fine.
//NOTE2: Fen you might want to store the variable for the PC's cock type and cock size.
public function carephCorruptionSlaves():void
{
	clearOutput();
	output("You call on Ceraph, but rather than the familiar sight of the purple omnibus, you see a human girl being brought into the camp by a gang of imps.  They approach you and pull the girl's collar down, forcing her to kneel before you.\n\n");

	output("One of the imps steps forward and opens a letter, then begins reading.  \"<i>Lady Ceraph apologizes to her " + pc.mf("Master", "Mistress") + ", but she finds herself unable to service you.  So she has sent this human as an offering for the " + pc.mf("Master", "Mistress") + " to corrupt.  To this end, she has prepared a concoction for you.  Drinking this will provide you with what you need for the job, " + pc.mf("Master", "Mistress") + ".</i>\"\n\n");

	//(Very High Corruption)
	if (pc.cor() >= 75) {
		output("You glare at the imp, asking if Ceraph's implying you're not able to fuck this girl by yourself.\n\n");

		output("The imp recoils and offers a quick apology.  \"<i>No, of course not, " + pc.mf("Master", "Mistress") + ".  Forgive us, we did not wish to offend.</i>\"\n\n");

		output("Gruffly, you dismiss him with a wave of your hand.  The imp bows, thankful for your mercy.\n\n");
	}
	output("He closes the scroll and holds out a bubbling black vial labelled \"<i>Drink me!</i>\" to you.  The other imps form a line behind the girl.\n\n");

	output("Do you accept the 'offering' of the girl and drink the potion?");
	//[Yes][No]
	clearMenu();
	addButton(0, "Yes", ceraphLackeyCorruption);
	addButton(1, "No", makeCarephsLackeysLeave);
}

//[=No=]
private function makeCarephsLackeysLeave():void
{
	clearOutput();
	output("You wave the imps away and tell them that you're not interested.  One of the imps protests, \"<i>But, " + pc.mf("Master", "Mistress") + "-</i>\"  You cut him off before he has a chance to finish, saying that you wanted Ceraph, not some human girl!  Then, you toss the potion away and tell them to take the girl away.\n\n");

	output("\"<i>Y-Yes, " + pc.mf("Master", "Mistress") + "...</i>\" the imps reply meekly, pulling on the collar to drag the girl away.");
	addNextButton(campSlavesMenu);
}

//[=Yes=]
private function ceraphLackeyCorruption():void
{
	clearOutput();
	output("You grin and tell the imps that you will accept Ceraph's offering.  Then you circle the girl, appraising her.\n\n");

	output("She is quite beautiful... about 5'4\" tall, with shoulder-length blonde hair.  Her face is covered by a blindfold, which you forcefully yank from her.  She gasps in fear and looks at you; her eyes are blue like the ocean, while her lips are pink and full.\n\n");

	output("You gaze lower to appraise her breasts, guessing that they're at least a fair D-cup, and see that she's wearing a pair of nipple clamps connected by a chain. Her hands are held behind her by a pair of leather cuffs.\n\n");

	output("You reach down between her legs, spreading them to probe her pussy; she gasps as you do so. You feel her pussy and realize it's moist... ha! The bitch is enjoying her predicament! You show her your glistening fingers and she looks away in shame.\n\n");

	output("The vial of black fluid the imps offered you tastes sour and thick, and as it slides down your throat you can feel it burning a path of liquid heat through your throat.  The liquid settles in your belly and the heat spreads through your body; then focuses on your crotch.\n\n");

	//Cock obtained from this is human-looking, so you'd trigger the next paragraph too.
	//(if PC has no cock)
	if (!pc.hasCock()) {
		output("Intense pleasure overcomes you as you feel blood rush to your groin; ");
		if (pc.hasVagina()) output("your " + pc.clitDescript() + " swells");
		else output("a small bump forms on your mons");
		output(", then develops into a huge 16-inch long, 3-inch thick erection!  The tip practically explodes from the foreskin vainly trying to contain it.  ");
	}
	var x:Number = 0;
	var demon:Boolean = false;
	x = pc.biggestCockIndex();
	if (pc.hasCock()) {
		if (pc.cocks[x].cType == GLOBAL.TYPE_DEMONIC) demon = true;
	}
	//(else if PC's cock is below cock area 48)
	if (pc.cockVolume(pc.biggestCockIndex()) < cockVolume(48) && pc.hasCock()) {
		output("Your " + pc.cockDescript(x) + " throbs, veins bulging as it grows larger, ballooning to a generous 20-inch long, 3-inch thick size.  ");
	}
	//(if PC's cock is not demonic or pc has/had no cock prior)
	if (!pc.hasCock() || !demon) {
		output("A heady, musky scent emanates from your cock, then its color changes abruptly to a shiny inhuman purple hue and tiny sensitive nodules form along the length of the shaft; the crown develops a circle of rubbery protrusions that grow larger as you become more aroused.\n\n");
	}
	else {
		output("You stroke your demonic prick, bringing it to full mast; it throbs as if knowing what is coming.\n\n");
	}

	output("You admire the pulsating demonic member as pre-cum leaks from the tip, lubricating your shaft and dripping obscene gobs into the dirt; the girl looks at you, terrified.  The imps stare at your tainted dick and the girl's fearful expression, panting with arousal as their own cocks harden at the sight.\n\n");

	output("You order them to remove the girl's bindings and hold her down. They quickly oblige, removing the leather cuff and pinning the girl down, then spreading her legs to allow you better access to her moist tunnel.\n\n");

	output("You grab her hips and tease the poor girl by rubbing your nubbly shaft against her clit, forcing moans of unwanted pleasure out of her; moments later she screams in orgasm, her pussy juices already splashing against your ");
	if (pc.balls > 0) output("scrotum and ");
	output(pc.legs() + ".  The imps on her extremities laugh at the girl as she relaxes and her head slumps into the ground; you motion for the imps to release her and step back, then align yourself with her pussy.\n\n");

	//(if PC is above 60 cock area)
	if (pc.cockVolume(x) >= cockVolume(60)) {
		output("It's clear to see that if you push inside her with a member of your size, you will rip her apart; thankfully one of the imps step forward with a vial containing a bluish fluid and forces it down her throat.  She drinks without resistance, then gasps as she orgasms once more, juices splattering about as her cunt seemingly grows elastic and wet enough for you to push the tip of your massive demonic cock inside her effortlessly.\n\n");
	}
	output("You plunge into her warm depths, and she moans as your shaft forcibly forces her walls apart.  When your hips finally collide she screams, \"<i>Yessss!</i>\" and orgasms once more, milking your shaft with powerful contractions even as you begin pounding her in earnest.  Something in Ceraph's concoction must be playing havoc with your nerve endings; the newly-found sensitiveness of your shaft and the stimulation from her pussy are too much to contain and you burst inside her, shooting jet after jet of cum inside the girl's stretched pussy.\n\n");

	output("You empty ");
	if (pc.balls > 0) output("your balls");
	else output("yourself");
	output(", and yet your hips continue pounding the girl as if they had a mind of their own.  Her legs grab onto your waist as she lifts herself off the ground and into your arms with newfound strength.  She closes her eyes for a moment, then opens them with an almost desperate glare.  \"<i>More!</i>\" she demands hungrily.  Her previously ocean-blue eyes have turned into little neon pink pills of lust set on tableaux of darkness that used to be her white sclera. Looking into those eyes, you feel like you're only too happy to oblige her request.\n\n");

	output("You fuck her powerfully, the sweat dripping from your bodies mixing with each other as she does her best to rub herself on you, sending shocks of electric pleasure racing through both your bodies; the imps watch rapt, masturbating openly to the show you're putting on. With a groan and a powerful piston, you reach your second climax; this in turn triggers yet another orgasm within the girl.\n\n");

	output("Once again you're unable to stop your rabid pounding as the girl screams and her skin turns a light purple.  Neither of your unholy lusts sated, you fuck each other again in earnest, your thick demonic cock pounding into her abused fuckhole and pushing out little squelches of semen, while she gyrates her hips to coax more out of you to take its place.  The vicious cycle continues for many orgasms; each time you cum into her, she loses another part of her humanity to become more demon-like.  First new horns grow on her head, then her hair turns as pink as her irises, elongating to reach her lower back.  Her hands develop black claws that she uses to scratch at your skin, her feet growing demonic heels to further complete her lewd mien.  Her butt inflates and her breasts enlarge, filling out and giving her a hourglass figure most girls back in Ingnam would kill for; the clamps on her nipples break apart as they grow in size and milk explodes from their tips to join the pool of mixed fluids that's formed under the two of you.\n\n");

	output("Her tongue grows serpentine and undulates hypnotically, and she puts it to good use by invading your mouth and throat to leverage you into a wet french kiss.  Finally, with one last desperate thrust, you pump her with the final load of cum that completes her transformation.  Large bat-like wings sprout from her shoulders and a spade-tipped tail bursts from above her ass.  She closes her mouth around yours and screams in ecstasy as she finally releases you and slumps to the ground, panting.  You follow in suit, dropping on top her and resting your head on her breasts.\n\n");

	output("She strokes your head, giggling, \"<i>I hope you enjoyed our little tryst, " + pc.mf("Master", "Mistress") + ".  Lady Ceraph wasn't lying when she said you were one hell of a fuck.</i>\"  You lift your head in surprise; did she become a demon on purpose?\n\n");

	output("\"<i>No, silly!</i>\" she responds, seemingly reading your thoughts.  \"<i>I've been a succubus for years now.  It's just that I find the idea of being subdued and converted into a sex machine so hot... mmm... you can thank mistress Ceraph for this particular fetish,</i>\" she says, turning her head to the side to show you a small glowing black stud on her ear.\n\n");

	//(if PC's dick is not demonic naturally)
	if (!demon) output("You lift yourself off her and sit in the dirt; she grins and slowly crawls toward you to take your demonic prick into her mouth, sucking with so much pressure you fear she will swallow your cock whole.  Slowly, you feel something trickle out of your sensitive cock and into her mouth, then she pulls away with a <b>POP</b>. \"<i>This should take care of the medicine, " + pc.mf("Master", "Mistress") + ".</i>\"  True to her word, you watch as your cock slowly reverts its coloration");
	//[(if PC didn't have a cock)
	if (!demon && !pc.hasCock()) output(", then the temporary phallus shrinks and disappears back into your crotch");
	if (!demon) output(".\n\n");

	output("She smiles at you seductively, licking her lips.  A slapping sound along with multiple pants and gasps catches your attention; both you and the succubus look around for its source.  The imps that brought the succubus for you are still masturbating furiously.  She looks at you with an eyebrow raised and says, \"<i>There is only one more thing you have to do to completely subdue me.  Order me to pleasure those lowly imps.</i>\"\n\n");

	output("Do you?");
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("lib", -3, "cor", 5);
	pc.slowStatGain("l", -3);
	pc.cor(5);
	//[Yes][No][Never Again]
	clearMenu();
	addButton(0, "Yes", acceptMoreCeraphFauxCorruption);
	addButton(1, "No", declineCeraphFauxCorruption);
	addButton(2, "Never Again", iQuitCeraphCorruptionDemons);
}

//[=Never Again - Fuck this nerd shit=]
private function iQuitCeraphCorruptionDemons():void
{
	clearOutput();
	output("You tell her, loudly and in no uncertain terms, that you have no interest in playing make-believe with her, and that next time Ceraph can come herself or have an ACTUAL innocent brought for you to corrupt.\n\n");

	output("Chagrined, she unfurls her wings and flies off, the imps quickly wilting and following suit.");
	//(disable repeat of scene)
	flags["COC.CERAPH_DECLINE_CORRUPTION_SLAVES"] = 1;
	processTime(2);
	addNextButton();
}

//[=No=]
private function declineCeraphFauxCorruption():void
{
	clearOutput();
	output("You tell her you have no interest in granting release to lowly imps.  If they want pleasure, then they should earn it themselves.\n\n");

	output("\"<i>Sorry boys, " + pc.mf("Master's", "Mistress") + " orders.</i>\"  She extends her wings and flies away, and the horny imps follow suit, still busy masturbating.  A 'pit-pat-pat' sound follows them, the noise of their pre-cum hitting the dry dirt from on high.\n\n");
	processTime(2);
	addNextButton();
}

//[=Yes=]
private function acceptMoreCeraphFauxCorruption():void
{
	clearOutput();
	output("You smirk, seeing that this might be interesting... so you order her to pleasure the imps, all of them at the same time.\n\n");

	output("The imps' eyes glow at your command, and they only stop masturbating long enough to pounce on the succubus and drag her to the ground.  She just smiles, offering no resistance as the imps hurry to fill her mouth, pussy, and ass, not to mention keeping her hands busy.\n\n");

	output("The sight is arousing; the imps tug, grope and pull at the succubus, all while brutally fucking her.  The huge deposit you made inside her tight vagina splatters about with each wet slap of the imp fucking her pussy; the one inside her ass pushes brutally, as if trying to climb up her anus cockfirst; the one on her mouth makes use of her breasts whenever he pulls out; and finally the ones using her hands splatter pre on top of her, painting her purple skin white.\n\n");

	output("The show doesn't last long, however.  The imps quickly climax with echoing cries. The one using her mouth cums so hard that some ejaculate backflows out of the succubus' nose.  The ones using her ass and pussy fill their respective holes, pulling out in the last spurt to paint the succubus' body in spooge.  Her hands, of course, complete the job by painting whatever was left  with the last two imp dicks.  By the end of the ordeal, the succubus is coughing and sputtering.\n\n");

	output("\"<i>Look at what happened to me... used and transformed, then forced to service a bunch of dirty imps...  Thank you, " + pc.mf("Master", "Mistress") + ",</i>\" she moans with a lewd smile.\n\n");

	output("Licking the cum off her body, she sashays towards you to give you a little peck on the cheek.  \"<i>Hmm, you're such a good " + pc.mf("Master", "Mistress") + ", I might have to leave Ceraph's harem and join yours instead.  See you around, hot stuff.</i>\"  She rounds up the tired imps and extends her wings, setting off alongside them.");
	//dynStats("lus", 5, "cor", 2);
	processTime(12 + rand(5));
	pc.lust(5);
	pc.cor(2);
	addNextButton();
}

//(not optimized in any way for centaur)
//(should probably add a cock-limit of like, whatever you want, cuz you're fucking her butt)
private function sweetieNOOOO():void
{
	//spriteSelect(41);
	clearOutput();
	//requires PC to have Marble as follower or have removed Marble from game via rape attempt and confrontation
	output("\"<i>Aaaah, not satisfied with me, " + pc.mf("Master", "Mistress") + "?</i>\" Ceraph huffs, feigning exasperation.  She pointedly runs a hand along her muscular thigh, up her taut belly, and around one of her perfectly-formed lilac breasts.  \"<i>And what did you have in mind for our... playtime?</i>\"\n\n");

	output("After taking a moment to form your thoughts, you begin describing a tall country-style girl, with huge breasts and an aptitude for pet names.  Ceraph cuts you off with a high-pitched cackle, and she actually slaps her palm against her forehead in her excitement.  \"<i>Marble?</i>\" she asks between bouts of laughter.  \"<i>You want me to turn into that cow?  Oh, " + pc.mf("Master", "Mistress") + ", but you surely are a mystery to me.</i>\"  A sharp stare from you cuts off her reverie, and she sobers instantly, going so far as to cringe.  \"<i>My apologies, " + pc.mf("sir", "madam") + "... your wish is my command.</i>\"\n\n");

	output("First, she gestures once again at the environment, changing from a mountainous terrain to the inside of... Whitney's barn?  Sure enough, you look past her and see a milker ");
	if (pc.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) output("similar to the one you got from the factory.");
	else output("not too different from the ones you've seen in Ingnam, although modified for human use, it seems.");
	output("  Any more exploration of your environment is put on hold as your gaze falls back to Ceraph.  Her latex ensemble shimmers and slackens, the strategic peep-holes closing up with unremarkable cotton.  The material reforms until she's left with a pair of overalls and a button-up blouse that are both at least four sizes too big.  ");
	//([if first time]
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00294"] == 0) output("Seeing your confused stare, she simply answers with, \"<i>Ah, do be patient... sweetie,</i>\" and goes back to her work.");
	else output("You simply chuckle knowingly at the apparent size disparity of the garment.");
	output("  She reaches up and takes a tentative grasp of her curved, demonic horns, straightening and molding them into more bovine models.  The spade-tip of her tail shrinks, then puffs out with hair, and the whole appendage droops as it becomes remarkably more cow-like.  Almost as an afterthought, she paces up to you and slowly strips you of your [pc.gear].  She teases [pc.oneCock] a bit before gliding back to her previous position.\n\n");

	output("With a wink to you, Ceraph raises her hands, pinching the center of her left palm into a sharp syringe-like tip, then repeating the motion with her right.  Meticulously, she unbuttons her oversized blouse, lets her overalls drop to her waist, and releases a steadying breath.  She cups her breasts, lining the points up with her stiff, quivering nipples, and plunges them in, groaning excitedly in both pain and arousal.  Bulges form at her forearms, working their way down into her waiting hands.  The bulges, you discern, treat her new needle-palms as a funnel; they shrink and disappear from her arms as their mass is transferred to her breast.  A significant surge of growth in her squashed bosom supports the theory, and Ceraph winces in ecstasy from the feeling.  The new volume makes audible sloshing sounds.  More bulges begin, traveling in waves toward her waiting bosom.  Although already quite ponderous, the omnibus' former bust pales in comparison to the still-swelling rack she's pumping full of fluid.  The flesh begins pushing into her arm-cradle and the growth goes on until finally coming to a rest at roughly HH-sized measurements.  She retracts the tiny spikes from her suddenly and ponderously larger nubs, leaving only a dribble of - milk, it must be - in their wake.  The demoness struggles to pull her blouse over her bloated boobs, eventually managing to button it with a good amount of strain.\n\n");

	output("Ceraph plops down onto her beautiful bubble butt, removing her boots and grabbing up one of her feet.  She palms the demonic high-heel and pushes, a sharp crack accompanying the retreat of the bone back up into her foot.  She mirrors the process with the other, then begins massaging her perfectly normal feet roughly.  Her applications widen and shorten the extremities, shaping them into the cloven hooves of a cow.  She shudders, her knees knocking together as auburn fur sprouts from the bottom of the thigh down to her new hooves.  Ceraph attempts to stand, wobbling a bit.  \"<i>Getting used to hooves with no heel support at the same time... tricky,</i>\" she muses, regaining her footing on her now-digitigrade legs.  \"<i>Moving on...</i>\"\n\n");

	output("The increasingly cow-like omnibus takes a grip on either side of her hips and, with an ecstatic cry, tugs outward, widening her hips and throwing her gait off even more.  She sticks her thumb into her mouth and blows, and though you suspect that's simply for theatrics, her thighs thicken and her butt plumps up, filling up her overalls perfectly.  Ceraph reaches up and pinches her own cheeks, rounding her angled features off into a more rounded, softer visage.  With a snap of her fingers, a blossom of creamy-colored skin starts at her nose, running along her face and down her neck, enveloping the previously purple hue.  ");
	//([if real Marble has cock]
	if (flags["COC.MARBLE_DICK_LENGTH"] > 0 && int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("Her nubbly member presumably shifts its color from royal purple to a lighter, brownish tone as well, inflating to the familiar seven-inch measurement; at least, so you'd judge by the sudden bulge in the overalls.  ");
	output("A ruffle of her hair sparks a similar coloration shift to the same brown as her leg fur, and the black of her eyes shift to whites with brown irises.\n\n");

	output("\"<i>One last touch,</i>\" she moans as her whole frame begins to jostle about.  With a shake, her entire body leaps up a couple inches in height, and another, and another until she's roughly the same size as that familiar cowgirl.");

	processTime(15 + rand(5));
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00295"] == 1) addNextButton(postUdderChoice);
	else {
		output("  \"<i>Now then, " + pc.mf("Master", "Mistress") + "... or, should I say, Sweetie,</i>\" she breathes, her sultry tones smoothing into an earthy, slightly drawn-out accent, \"<i>there's one more detail that she - sorry, I - don't have; would you like me to have... an udder?</i>\"\n\n");
		output("The question strikes you as a curious one.  Do you want your make-believe Marble to make an udder, or is she better off without?");
		//[yep] [no way jose]
		addButton(0, "Udder", yesUdderPWEASE);
		addButton(1, "No Udder", noUdderPlz);
		addButton(2, "Never Udder", noUdderPlz, true);
	}
}

//[in a pig's eye, pal]  
private function noUdderPlz(perm:Boolean = false):void
{
	clearOutput();
	//spriteSelect(41);
	if (perm) flags["COC.UNKNOWN_FLAG_NUMBER_00295"] = 1;
	output("A sharp head-shake is the only declination she needs.  \"<i>Of course, Sweetie, that wouldn't be very... Marble-like, would it?</i>\"\n\n");
	flags["COC.NKNOWN_FLAG_NUMBER_00296"] = 0;
	postUdderChoice();
}

//[of course honey-buns] 
private function yesUdderPWEASE():void
{
	clearOutput();
	//spriteSelect(41);
	output("A brightening of your eyes and a slight part of your lips clues her in to your answer.  She pulls her blouse up over her belly, tucking it into her cleavage to keep it out of the way.  As you watch, Ceraph pinches two spots right above her belly button, and she moves her fingers away to reveal... nipples!  She repeats the process a few inches lower, then frames the four nubs with her thumb and forefinger, taking a deep breath in anticipation.  The demoness flexes her belly muscles, and a familiar bulge pops up, nipples lengthening to match.  Liquid can also be heard splashing around her pink protrusion, and she can't help but give the thing a little slap.  Both of you delight in the subsequent jostling and splashing of the milk inside.  Her cheeks bulge with exertion as the milk-sack grows, burgeoning larger and wider with more and more milk before finally flopping heavily down above her crotch.  She sighs in relief, then slips her top back over her new udder, taking apparent pride in the four small stains forming in the fabric.\n\n");
	flags["COC.NKNOWN_FLAG_NUMBER_00296"] = 1;
	postUdderChoice();
}

private function postUdderChoice(newl:Boolean = false):void
{
	//spriteSelect(41);
	if (newl) clearOutput();
	output("That out of the way, she pulls her overall back over her shoulders and turns her back to you, waiting several seconds before turning around.  \"<i>Sweetie!?</i>\" she exclaims in horror, eyes wide and arms flung in front of her as she cowers from you.  \"<i>What-... what are you doing...</i>\"\n\n");

	output("'Marble' backs up, tripping over a bucket and falling onto her spacious ass.  \"<i>Please, don't hook me up to that milker, sweetie... anything but that!</i>\"  An evil smirk graces your lips as you catch up to her intention; you regard the cowgirl omnibus, her face a mask of terror and her body all a-tremble.  She manages a small squeak of terror as you approach and take a handful of her voluminous hair, dragging her over to the indicated stall.  Her blubbering sobs don't cease as you ready the equipment");
	//([if udder] 
	if (flags["COC.NKNOWN_FLAG_NUMBER_00296"] == 1) output(", making sure to prep four extra tubes for her udder");
	output(".  You idly reach over and rip her strained blouse right off, sliding the overall straps off her shoulders and exposing her massive HH-cups.  Despite her protests, her sunken nipples quickly snap to attention, milk leaking freely from the excited things.  You reach over and flick the machine on, dragging 'Marble' across to it.  You're aware of the actual cowgirl's fear of bondage, so you take great pleasure in chaining her understudy's hands to two overhanging shackles and dangling the two cups in front of her huge tits.  The suction is just strong enough to draw her nipples towards the hoses.  Her scream of protest is stifled by a strangled cry as you jam the two cups home, the machine instantly kicking in.");
	//([if udder] 
	if (flags["COC.NKNOWN_FLAG_NUMBER_00296"] == 1) output("  The four others quickly follow, the udder-cups sucking onto the nubs like hungry children.");
	output("\n\n");

	output("Marble's entire frame is jostled with each alternating piston of the milkers, her eyes rolling back from the feeling of the rough milking.  \"<i>S-stop,</i>\" she pants, thighs twitching in barely-suppressed arousal.  You laugh as you raise her to her hooves, leaving her bent double with her bosom and its attachments nearly brushing the ground.  Her cow-sized butt is raised in front of you and swaying from side to side from her pent-up arousal.  Slowly, drawing out her high-pitched groans of protest, you slide her overalls down over her posterior, letting them drop to the floor.  Despite her continued pleadings, you ease your pointer and middle fingers into her dripping cunt, eliciting a gasp from the tied-up cowgirl.  \"<i>Please, d-don't... my vagina...</i>\" she moans, struggling in vain against her bindings as she tries to shake you away from her.  Marble's resistance only makes your [pc.cocks] harder, however, and you're about ready to punish her for her impudence.\n\n");

	output("You sink your fingers into Marble's butt flesh, jostling and kneading her rump like stubborn dough.  The bound-up bovine wiggles around, her arousal slowly enervating her natural disgust for such treatment.  Before long, her leaky fuck-box upgrades to a veritable downpour of fem-spunk, and her babble of protests is intermittently interrupted by a \"<i>Fuck me!</i>\" or a \"<i>Please, champion...</i>\"  A cackle rolls out of your throat as you regard your nearly mind-broken cum-slut.  With a particularly evil plan in mind, you grab up [pc.oneCock] and line it up with her tight pucker.  It's anal time!  \"<i>No, sweetie, no!</i>\" she pleads, trembling enough to cause a minor boobquake against her still-pumping milkers.  You pause, going so far as to release your grip on the cock, and she heaves a sigh of relief.  Before she can even finish the exhale, you dangle your newest find in front of her eyes; a large funnel, complete with a tube.  Her protest is interrupted when you jam the funnel down her throat, stopping just short of suffocating her.  Tears well up in her eyes as you produce another nearby accommodation: a flagon of a thick, creamy substance.  Judging from the potent smell, it's minotaur cum... and fresh, too.  Addictive fluid... well, perhaps she needs a taste of her own 'medicine'.\n\n");

	output("She can be <b>your</b> slave, for once.\n\n");

	output("Marble's eyes bulge as you begin pouring the cum-container into the funnel, filling it up to the brim with mino-spunk.  Reminiscent of an overzealous squirrel, her cheeks puff as the semen filters down her throat and flows back into her mouth.  With no outlet other than her stomach, she's forced to swallow the offending liquid, tears streaming down her face freely at your treatment.  You merely laugh and roughly squeeze her cheeks, causing her to momentarily choke on the stuff and dribble a bit out of the corner of her mouth.  Satisfied with the progress, you move back behind her wide-set booty and spread her cheeks once more.  Muffled screams aside, her exposed butt is all the invitation you need.  Once again snatching [pc.oneCock], you prod her a few times before simply jamming it in, taking perverse pleasure in her suddenly higher-pitched screams.  Remarkably, her anus yields to your penis in a wonderful way; not loose by any definition, but certainly not even impeding your progress.  You wonder how faithful Ceraph's representation is to the source material; are cowgirl colons such wonderful things?  Your crotch smacks against her luscious cheeks, and you waste no time in drawing back through her depths and ramming it home once more.\n\n");

	output("Marble, nipples reddened and elongated by the constant, ever-present milking and belly swollen from the minotaur seed she's still being forced to swallow, hums throatily.  Her mind must be completely gone, by now... she's your sexual tool, your slave, your fucktoy, and she's gone from protesting to outright encouraging it.  Her hips pump in time with yours, her sexual fluid spattering the front of your legs with the sheer amount of it.  Under such a willing, perfectly accommodating colon like this, you're not long in feeling ");
	if (pc.balls > 0) output("your [pc.balls] tightening");
	else output("a readiness in your body");
	output(", and you wind up for one last thrust into her depths.  ");
	var cum:Number = pc.cumQ();
	if (cum < 50) output("Her ass has no problem in taking your ejaculatory package, lapping it up like it was nothing.");
	else if (cum < 250) output("She groans a bit from the amount of seed you pump into her butt, but she doesn't seem overly concerned by it.");
	else if (cum < 750) output("Her belly actually bulges out a bit more as you shoot your sperm into her perfect butthole, but her only response is an approving grunt.");
	else if (cum < 2000) output("Normal girls might not be able to take this much cum at one time, but 'Marble' simply bucks her hips happily as her belly is stretched as least as large as her boobs to make room for the load.");
	else output("Her entire body writhes in ecstatic bliss as your gigantic load pumps into her, wave after wave of baby-batter inflating her gut so full of cum.  By the time you're done, her navel is an outtie; what's more, it's actually scraping the barn floor, and if her arms were free, you don't doubt she'd be rubbing happily at it.");
	if (cum >= 10000) output("  Marble's body convulses so hard it actually dislodges the funnel, dragging the tube free of her mouth.  \"<i>SWEETIE!</i>\" she screams, grinding herself against you as her stomach burgeons forward, filled with enough seed to propagate an entire city of goblins for months.  \"<i>MORE!</i>\"  You're able to give her just that, bloating her billowing belly obscenely, stretching the creamy skin to its near-breaking point with your virility.  Even if you wanted to pull out, you couldn't, not with her anal walls clamped onto your " + pc.cockDescript(0) + " like this.  Her belly actually gains enough mass to nearly fill up the stall, pushing her tits up into her chin.");
	if (pc.cockTotal() == 2) output("  Your other cock sprays ");
	else if (pc.cockTotal() > 2) output("  Your other cocks spray ");
	if (pc.cockTotal() > 1) {
		output("a ");
		if (cum < 50) output("gentle");
		else if (cum < 250) output("generous");
		else if (cum < 750) output("heady");
		else if (cum < 1500) output("wild");
		else output("massive");
		output(" amount of semen all over the nearby stalls and equipment");
		if (cum >= 250 && cum < 1000) output(", spattering the entire area");
		else if (cum >= 1000 && cum < 3000) output(", drenching the area in white");
		else if (cum >= 3000) output(", coating the area in a thick sheet of alabaster");
		output(".");
	}
	output("\n\n");

	output("Finally spent, you free yourself of Marble's butt and straighten, moving to the side to take in just how far the cowgirl has fallen.  The milkers' storage tanks are fit to bust from the amount of cream your cumslut has pumped into them, but Marble herself is staring at you with heavy-lidded eyes.  You don't even remove her restraints, just dismissively press a foot into her gut");
	if (cum >= 2000 && pc.cor() >= 66) output(" and chuckle at the drizzle of semen that issues from her butt and mouth");
	output(".  After a few more moments of observation, you turn away, planting your hands on your hips victoriously.  You simply thank the cowgirl, and she responds with a satisfied moan.  Suddenly, a massive splashing sound - as if gallons of liquid were suddenly released - reaches your ears, and the barn shimmers and fades into the familiar setting of your camp.  You feel a hand on your shoulder, and you glance down to see a creamy-colored hand, veins of purple creeping along the surface and inching up her fingers.  \"<i>Thank you, " + pc.mf("Master", "Mistress") + ",</i>\" Ceraph replies amiably, tittering to herself.  \"<i>You've got some kinks to work out, don't you?  I like that.</i>\"\n\n");

	output("Her grip fades, and you turn around to see... nothing.  She's simply gone, vanished without a trace.  No... not without a trace, you realize.  Right near where the milker used to lie sits a lone cowbell, lying in a pool of what you can only assume to be cum.  You reach for it, but it disappears as well, turned into a small puff of smoke and dispersing with the wind.  \"<i>Bye, sweetie,</i>\" the disembodied voice of your demonic slave whispers into your ear, mocking tones interspersed with a promise of further pleasure.");
	//end (stat changes?)
	processTime(15 + rand(5));
	pc.orgasm();
	//dynStats("lib", 1, "sen", -5, "cor", 3);
	pc.slowStatGain("l", 1);
	pc.cor(3);
	addNextButton();
}

//NOTES:
//Ceraph roleplay. [Dominika] option. There is text for the first time you do it, then transformation text that is intended to play at the front of every scene.
//After that is a scene tailored more specifically for the PC. Intention is to give nagas and centaurs and all that their own scene. Currently only scene is for PCs with a dick - should be naga-compatible.
private function cerminika():void
{
	//spriteSelect(58);
	clearOutput();
	//[first time]
	if (int(flags["COC.CERAPH_ROLEPLAY_AS_DOMINIKA_COUNT"]) == 0) {
		output("\"<i>Who?</i>\" Ceraph asks.\n\n");

		output("You explain about the dark-lipped witch to your demon whore.  \"<i>Mmm, tattoos, that's gonna be rough,</i>\" she muses, licking her lower lip in thought.  \"<i>Think about her for a moment?</i>\"  You were already thinking of Dominika given that you were explaining who she was to Ceraph, but you suppose dealing with her idiocy is the price you pay for the sex.  Still, you acknowledge that you are.  Ceraph places her hands on your forehead and closes her eyes for a few moments, before purring and grinning.  \"<i>Oo, she's cute. Ask her if she likes piercings.</i>\"\n\n");
	}

	output("Taking a deep breath, Ceraph closes her eyes.  When she opens them again their darkness has been replaced by bright white sclera, and brilliant blue irises.  Starting at the roots her hair brightens and blondes, pulling itself up into a stylized bun.  The demon's face shifts and squirms beneath the flesh, bones and muscle settling into subtle differences and adapting the cabalist's features.  Eyelashes adjust and shrink, losing the excessive glamour of the demonic and gaining a more down to earth and natural appearance.  Throughout the process her skin gradually shifts in hue to a more tanned shade, now resembling a color someone could actually be born with.\n\n");

	output("Her figure retracts somewhat, growing slighter and shorter.  Previously obscene breasts diminish in size, and Ceraph removes her outfit to prevent undue damage.  Before your eyes her areolae shrink and change, nipples becoming positively petite.  Arms slender, shifting to a physique more expected of a sorceress.  Her demonic heels pull into her feet, the soles paling far more than the rest of her skin.  Amusingly, her ass plumpens somewhat, achieving the jiggle of the non-athletic.  Between her legs Ceraph's pussy becomes dignified and neat");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(" while her cock shrinks to what looks approximately like six inches of meat, an outright tiny penis for Mareth");
	output(".\n\n");

	output("Though much of her shrinks, her lips grow.  While unsurprising, it remains very enjoyable to watch.  Her lower lip rounds and swells, while her upper grows further defined.  Like a bruise, they darken, until no color but a glossy void remains.  As though they were being drawn directly into her skin, the lines of her tattoos begin to spread, starting from a single circle across her breast until the latticework of ink covers her tanned body.\n\n");

	output("Dominika stands before you, nude and unrestricted. She licks her lips slowly.\n\n");

	//[Cock'd PC]
	if (pc.hasCock()) {
		output("\"<i>Champion,</i>\" those dark lips purr, \"<i>You have done everything I could have asked you for.</i>\"  She runs a hand along your cheek, stepping in close and caressing your arm.  \"<i>I owe you more than I can express.</i>\"  Her hand roams up into your hair, brushing through it before cupping the back of your head.  Dominika pulls you into a deep kiss, pressing her lips to yours in a breath-stealing passion.  Her tongue rolls into your mouth as though it intends to steal yours away, her leg eventually rising up and curling around you.");
		//[CERAPH COCK: 
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  Her dick presses up into your crotch.");
		output("  \"<i>I dare say,</i>\" she purrs between the kiss, pressing her forehead to yours, \"<i>You may have seduced me, champion.</i>\"\n\n");

		output("Pressing her hands on your shoulders she eases you down, straddling your lap.  \"<i>I linger in chastity out of fear that my dignity shall be taken from me in this land,</i>\" she purrs softly, tracing her hand across your chest.  ");
		if (pc.biggestTitSize() >= 0) output("She casually and playfully gives the gentlest squeeze to your " + pc.chestDesc() + ".  ");
		output("\"<i>But if I can rely on you – perhaps I do not need to worry.</i>\"  She pulls your [pc.gear] away, letting her hands roam hungrily across your body.  Blatantly turned on, her pussy rubs its juices against your crotch");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(", and her prick has remained firm and hard");
		output(".  Her tongue roams hungrily over her inky lips, and an almost predatory grin sets across her features as she pulls up your " + pc.cockDescript(0) + ".  Her fingernails cup under your head delicately and carefully tease you, rubbing her palm into the underside of your shaft.\n\n");

		output("\"<i>How long,</i>\" she purrs, \"<i>Have you wanted to really be inside me?</i>\"\n\n");

		output("Dominika slides her body back, rubbing the softness of her folds against your " + pc.cockDescript(0) + ".  ");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("The very base of her prick teases the veins of your own shaft, but she seems focused on the pleasure of her cunt for now.  ");
		output("She grins at you as she reaches the top of your cock, grinding back and forth across it.  \"<i>Mmm,</i>\" she muses quietly, biting her lower lip for a moment.  \"<i>It's been a long time since I let someone have me.  I forgot just how... warm a prick can feel down there.</i>\"  Her pussy casually clenches, brushing herself across your tip.  \"<i>You should feel honored.</i>\"\n\n");

		output("You grab her hips and pull her into your lap.  The warmth and wetness of her pussy engulfs your shaft immediately, clinging to you incredibly tightly.  She gives a surprised noise at the sudden aggression, placing her hands on your belly.  The holier-than-thou act is cute, but you're here to fuck and no amount of preening is going to keep you from that.  \"<i>I-I see that you've longed for this as well!</i>\" she gasps out, attempting to keep some dignity while her cheeks flush.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  The degree that her cock abruptly shoots straight up is perhaps the most amusing part of the act.");
		output("  You simply smirk at her, starting to bounce her into your lap and shoving your " + pc.cockDescript(0) + " deeper inside. Once more she bites her lip, fingers digging into your stomach. No matter how classy she wants to appear, you can quite easily feel how wet she is");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(", and the heat of her prick bouncing into your lap");
		output(".  \"<i>Hey,</i>\" she gasps, \"<i>Don't you want to savor it?</i>\"\n\n");

		output("You slap her tit.\n\n");

		output("The inability to frame her expression and hang it on a tree in your campsite is the greatest injustice the world has ever known.  Her black lips sit in a stunned part as she stares at you, even as you hump away at her sopping mound.  She blinks a few times, shakes her head once, the entire disbelief package.  Eventually her hands slide down her side to find your own, rubbing over your fingers as they hold her hips.  Then, sharply and surprisingly painfully, she digs her fingernails into your wrists, forcing you to let go.  \"<i>No,</i>\" she says with a wicked grin as she brings your hands to the side of your head, leaning forward and slowly undulating her hips in your lap.  \"<i>Really. Enjoy me.</i>\"\n\n");

		output("You give her a carefully crafted retort that demonstrates your intellectual superiority, but she just gives you a fake smile and pats your cheek.  Eyes half-closed she slowly slides herself along you, enjoying the sensation of each inch of your " + pc.cockDescript(0) + " as it brushes along her walls.  \"<i>Mmmm,</i>\" she lets herself purr out, \"<i>Worth... the wait.</i>\"  Her toes curl slightly, one of her legs shifting back slightly to alter the angle you enter her at.  It seems to work how she wants it to, as a deep, satisfied breath accompanies the next downward slide of her hips.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  A single bead of pre-cum forms slowly at the tip of her prick, growing larger until it finally slips down into the curve of her head, sliding down her shaft and into your lap.");
		output("  She brushes her hair back behind her ear, sitting up straighter. In her quest to indulge in and feel your prick against all the warm flesh inside, she's neglected to keep you pinned.\n\n");

		output("Grabbing her shoulders, you surprise her once more by twisting and rolling on top of her.  \"<i>No!</i>\" she shouts immediately, knowing your plot, \"<i>You " + pc.mf("bastard", "bitch") + "!  No one puts me on my own back!</i>\"  You remind her that facts need more proof than the assumption that things will never change.  She spits at you, but you take solace in the fact that your hands are over her wrists and your " + pc.cockDescript(0) + " is shoved so deep in Dominika there's a chance she could spit up cum when you're done rather than swallow it.  Presuming, of course, that her vagina is connected to her stomach, which it probably is not.\n\n");

		output("Yet.  You haven't decided what you'll make her put in her mouth now that she's here.\n\n");

		output("\"<i>F-fuck!</i>\"  Those dark lips manage to stammer out, \"<i>Stop fucking me! Let me ride you, you piece of shit!</i>\"  She manages to pull her hands free from the grip you have on them, only to beat on your chest a few times and push futilely against it.  ");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("Her prick bounces between her belly and yours as you take her.  ");
		output("For your part you have no interest in slowing down, gripping back onto her hips and pounding away at the delightfully tight cunt presently dominated by your " + pc.cockDescript(0) + ".  More in charge than you were before, you have a chance to truly appreciate the sensation of her labia being shoved apart for your needs.  Absolutely soaked with her needy juices, it's easy to penetrate the sorceress.  Forcing so much of her sopping nectar out is making a terrible mess of her thighs, but given how stuck up she's been about finally letting you take her, she could stand to get a little messy.  Her fingernails claw at your collarbone");
		if (pc.biggestTitSize() >= 1) output(" and slap at your own chest");
		output(", hissing bloody murder while at the same time trying not to groan so much that she completely reveals how much she's enjoying having you piston away into her nethers. In that regard, she is failing.\n\n");

		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("A light spurt of pre-cum from her prick warms the flesh where your hips meet.  ");
		output("Slowly her fingers trail up to your shoulders, gripping you tightly and gritting her teeth as you thrust.  Sweating and grunting in tempered exertion from the pounding you put her through, the bun in her hair begins to fall apart.  Some of her blonde locks cling to her forehead.  Her legs curl around you, rubbing against your body and clenching with each strangled gasp coming from her dark lips.  The backs of her heels dig into your backside, rubbing in as she pins you closer.  You think little of it, until you attempt to take a deep thrust only to be rudely tugged back in by her feet. Gripping you tighter with her hands and holding onto the back of your head, she hisses happily, rocking her hips against you to feel your " + pc.cockDescript(0) + " shift inside.  \"<i>I said enjoy me,</i>\" she hisses wickedly, licking her ebony lips and casually nipping at you.  \"<i>Stay here, " + pc.mf("handsome", "gorgeous") + ".</i>\"\n\n");

		output("You had no intentions of letting her control the pace before, and you aren't interested in letting her do so now.  Feigning acceptance of her authority for now, you allow her to settle you into a tight, intimate thrusting.  You pierce into her damp mound, deeper and deeper, letting her inner walls squeeze you harder than her hands.  Holding onto Dominika's back, you wait for the perfect moment.  The right shortness of breath, the proper shudder that rocks through her body.  It arrives, her eyes half-lidded as she gazes past you with a gasping moan, and you seize the opportunity.  A sorceress' grip is only so strong, and it takes a single firm movement to break her hold on you, pulling out in the process.  Her eyes open quickly, recognizing that you're doing something, but she's too late to stop you.  You grab her wrists and spin her in place, forcing her face and those dark lips into the dirt.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  You can practically hear her rock-hard cock kicking up the ground.");
		output("  \"<i>What the fuck are you-</i>\" she begins, before shouting \"<i>Don't you DARE!</i>\"\n\n");

		output("Grinding your prick between her dusky cheeks, you had already decided that you very much dared and didn't particularly care about her inevitable protests.  You calmly taunt her and her helplessness, pushing your fingers into her blonde locks as you hold her down and completely destroy any semblance of a nice, ordered hairdo.  \"<i>Stay away from my butt!</i>\" she eventually explicitly shouts, ruining the mystique of intruding upon it.\n\n");

		output("\"<i>No,</i>\" you respond.\n\n");

		output("It's surprisingly easy to spear yourself into the cabalist's plush posterior.  You had expected a woman of her nature to be tighter than she is, but the pussy juices soaking your " + pc.cockDescript(0) + " are sufficient for a slippery and enjoyable entry.  She grunts and gasps dissatisfaction, but there's a deepness in her breath that betrays the excitement building within.  At the same time, she seems curiously nervous, and shakes not just in pleasure.\n\n");

		output("\"<i>P-please,</i>\" she stammers out, even as her asshole clenches around you.  Though it was easy to force yourself into Dominika's puckered button, you're impressed at how well her colon squeezes your shaft.  There's no blown-out anal whore here, just a petite fucktunnel the perfect size to be broken by your " + pc.cockDescript(0) + ".  You part aside her bunghole, claiming her ass in your name – colonizing her colon.  The entire reason those cheeks exist is cushioning for your crotch as you pound away at her, the juices her cunt left on your cock squirting out as your prick dominates every inch of those fleshy walls.  \"<i>Please,</i>\" she gets out again, \"<i>I've held out... so long...</i>\" She turns her head to look at you.  Tucked just behind the part of her hair, two small horns push from her skull.  A moment of confusion takes you, before it is replaced by a knowing smirk.  Jeering at the corrupted sorceress, you mock her inability to defend herself.  Without her chastity belt to protect her from the pleasure of the demon realm, it is free to feed upon her body and devour what purity remained, leaving behind just another succubus.  \"<i>Don't... make me cum,</i>\" she gasps.\n\n");

		output("Under most circumstances you would have no opposition to denying a slut like her an orgasm, but considering the precipice she dangles over, you don't feel bad giving her a push.  Your " + pc.cockDescript(0) + " continues its obscene assault on her backside, splitting her juicy cheeks to either side as you bend her guts to your dick's will.  Dominika lets out a moan that seems as though she may have intended it to be a scream of frustration, but her body is too far gone into pleasure to protest.  Like ink running through paper a deep dark purple begins to spread from her tattoos.  The color runs into itself and grows larger, leaving behind no lines where it joins.  The tan of her skin begins to disappear under the corruption.  \"<i>You " + pc.mf("bastard", "bitch") + ",</i>\" she pants, shuddering as the horns grow larger.  \"<i>You would destroy my humanity... just for your pleasure?</i>\"\n\n");

		output("\"<i>Yes,</i>\" you answer calmly.\n\n");

		output("She wails in mixed frustration and pleasure, juices splattering against the ground as her hungry cunt grows hornier.  A darkness overtakes her eyes, and her nails grow long and sharp, and through it all your " + pc.cockDescript(0) + " continues to degrade her ass.  As though a heartbeat pumping blood through her body, each thrust spreads the color over her skin a little more.  Her feet push and scrabble lightly against the ground in tormented frustration, but she is helpless beneath you.  You go without stopping, only slowing when wings unexpectedly burst from her shoulder blades, dark and starry.\n\n");

		output("Grabbing your sorceress-cum-succubus fucktoy firmly around the hips, you go upright, lifting her off the ground and bouncing her against your body.  Moaning and squirting her juices against the ground, Dominika lifts her legs to help you, swelling indigo tits bouncing from your forceful thrusts.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  Her prick has become engorged and infernal, covered with abnormal bumps and veins. It practically spits up pre-cum, gurgling with a greatly increased supply.");
		output("  \"<i>Take it then,</i>\" she gasps, \"<i>Take me... j-just give me... moreeeee...</i>\"  Her long nails – more slutclaws than anything else – dig into your arms as you hold her up almost painfully.  Squealing ecstatically, a long demonic tongue slips past her full corrupted ebony lips, slapping against her collarbone as her eyes roll up in pleasure.  Blonder and fuller, her hair naturally pulls back into an exaggerated bimbo-esque bun, and her horns have grown large and sinister.\n\n");

		output("Satisfied with the ruined chastity of the former scholar, you wrap your arms around her hips and give a few final gut-wrenching slams into her dominated pucker.  Each one makes her squeal and gasp, and each one brings you one step closer to the shuddering eruption that is that slut's purpose.  Groping one of the whorish slutbags on her chest, you hold her to your body not out of intimacy, but dominance.  There is no mistaking your absolute control over her as the first thick blasts of cum spew into her abused ass and clog her cockhole.  Whimpering and clutching at you, all she can do is squeal and gasp your name, spitting your praises for destroying her dignity.");
		//[Player has large cum production: 
		if (pc.cumQ() >= 500) output("  You dump loads in her as though she's an addict who hasn't fed for days, bloating and humiliating her with the sheer volume of spunk that now inflates her belly.  Not as though the demon whore has much humility left to take.");
		else output("  She shudders as your " + pc.cockDescript(0) + " fills her guts with warmth, hips seizing as she rides out her assgasm.");
		output("  Her cunt nearly waterfalls her juices, squirting obscenely as she rides out the pleasure.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  The demonic prick placed between her legs stops bouncing only because of how rock-hard it is as it spews her own filthy fucksludge across her body, splattering onto her tits and across her face.  The volume of off-white cream it spews out takes even longer to finish than you do, painting her obscenely.");
		output("\n\n");

		output("Her hands drag across your chest as she slinks off you, moaning and shaking.  You shift back on your ass to sit down after the long fuck, only to smirk as she eventually crawls back up to you.");
		if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  Her own filthy jizz has already been licked clean by her hungry mouth, so as not to dirty your handsome prick.");
		output("  The demoness laps at your " + pc.cockDescript(0) + ", cleaning it of spunk, sweat, and all the various filth it accumulates, sucking and dragging her fat, midnight lips across them.  Dominika purrs her happiness, her joy at being forced into such a whorish form.\n\n");

		output("\"<i>Was that good?</i>\" Ceraph asks in her own voice, immediately ruining the illusion. \"<i>");
		//[Player has huge dick: 
		if (pc.cockVolume(0) >= cockVolume(75)) output("I doubt her ass could actually take you so well, but... I wanted my " + pc.mf("master", "mistress") + " to enjoy a perfect asshole.  Sue me.  ");
		output("I hope that little slut appreciates what she's missing out on.</i>\"  She laps at your dick a few more times in the corrupted cabalist's visage, eventually sitting upright and slipping around behind you to massage your shoulders.\n\n");

		output("\"<i>That said,</i>\" she whispers in your ear, \"<i>If you get a chance to do that to that cunt, do invite me.</i>\"");
	}
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("sen", -2, "cor", 2);
	pc.cor(2);
	IncrementFlag("COC.CERAPH_ROLEPLAY_AS_DOMINIKA_COUNT")
	addNextButton();
}

/*Ceraph's Harem: Zetsuko
 [Introduction]
 ▶[FuckVagina] requires penis
 ▶[GetTongued] requires vagina
 ▶[Banana?] silly mode
 ▶[Leave]
 [Introduction]*/

//(First Time):
public function encounterZetsuko():void
{
	clearOutput();
	var banana:Function =null;
	var vag:Function =null;
	var dick:Function =null;
	//First time
	if (IncrementFlag("COC.ZETSUKO_MET") == 1) {
		output("You call on Ceraph, but rather than the purple-skinned demoness you were expecting, you are surprised to see a fox-eared girl appear in a wash of corrupted violet flames.  She steps out of the portal and shakes off the flames as if they are water, and you take a moment to look her over.  The first thing you notice is that her arms are bound in a white straitjacket that is open at the chest, allowing her F-cup breasts to swing freely.  Four large fox tails twist erratically in the air behind her, and you can see a pair of small horns poking up from her hair in front of her large triangular ears.  Her body and face are covered in tribal tattoos, and her somewhat maniacal amber eyes are framed nicely by a head of messy auburn hair with black highlights.  Like many of Ceraph's harem members, she is adorned with numerous piercings and studs — almost too many to count them all — as well as a large studded collar.  Once you have had time to take it all in, she speaks.\n\n");
		output("\"<i>Zetsuko apologizes for Mistress's absence, " + pc.mf("Master", "other Mistress") + ".  Mistress wasn't able to be here, so she sent Zetsuko instead.  She hopes Zetsuko will be to your liking...</i>\"\n\n");

		output("She punctuates her sentence with a creepy grin that shows off her oversized canine teeth, an evil gleam in her eyes hinting at an inner turmoil boiling just under the surface.  As she licks her lips with an almost animalistic hunger, you see that her tongue is extremely long and sports a large stud as well.  You quirk your brow at her peculiar manner of speech, but try your best to parse the information.\n\n");

		output("\"<i>Zetsuko was wondering if " + pc.mf("Master", "Mistress") + " could perhaps... loosen her jacket?</i>\" she says, struggling in her straitjacket a bit.  \"<i>Mistress tied it a little too tightly...</i>\"\n\n");

		output("When she turns to offer you her bindings, you spot a small note pinned to her back, and reach out to take it.  It seems to have been written to you by Ceraph.\n\n");

		output("\"<i>" + pc.mf("Master", "Mistress") + ",\n\nI'm deeply sorry that I cannot be there to serve you in person, but I have sent Zetsuko here in my stead.  If you are reading this note, she has likely already tried to get you to release her bindings.  Respectfully, I would advise you that under no circumstances should you oblige her request.  Zetsuko has 'discipline' problems, as you may soon find out, and while my piercings suppress most of her more defiant tendencies, she has a frustratingly stubborn will.  She should not be able to raise a hand against you without your consent, but that would not stop her from trying, believe me.  Despite her 'difficulties,' she does have some enhancements that I think you'll really enjoy, as long as you don't fall for any of her tricks.\n\n");

		output("Your Loyal Servant,\nCeraph\n\nP.S. Just in case she does get out, the safety word is 'banana.'\nP.P.S. Don't stick anything important in her mouth.\nP.P.P.S. Just to clarify, I mean the one on her face.</i>\"\n\n");

		output("You give a confused blink, re-reading the last line.  As you begin to wonder what it means, Zetsuko spins around and plops down on her cushy rear, looking up at you indignantly.\n\n");

		output("\"<i>" + pc.mf("Master", "Mistress") + " isn't going to let Zetsuko out, is " + pc.mf("he", "she") + "? Hehe... Too smart... Zetsuko is a bad girl, yes... many bad habits, trying to trick " + pc.mf("Master", "Mistress") + ".  Mistress tries to teach her, but Zetsuko has far too much fun being bad.</i>\"\n\n");

		output("Her legs are splayed out lewdly, and at last you start to understand what Ceraph meant in her note as your eyes are drawn to Zetsuko's drooling cunt.  Drooling, in this case, being literal — as you watch, an obscenely long tongue lined with studs is slithering its way out of her vagina, licking along the outer edges of her labia and dripping with what appears to be a mixture of saliva and pussy juices.  Thankfully, there don't seem to be any teeth, but the way that enormous tongue is wriggling around is so disturbingly erotic that you can't seem to pull your eyes away long enough to check.\n\n");

		output("\"<i>Is Zetsuko's pussy to " + pc.mf("Master", "Mistress") + "'s liking?</i>\" she says, laying on her back and spreading her legs further to proudly display her freakish appendage to you, putting on a display as she begins to tongue her own clit, flicking her hood piercing gently.\n\n");

		output("Will you make use of Zetsuko now, or send her back to Ceraph?");
	}
	//(Subsequent times): 
	else {
		output("You call on Ceraph, but rather than the purple-skinned demoness you were expecting, Zetsuko appears in a wash of corrupted violet flames, turning to you with a wide, toothy grin.\n\n");

		output("\"<i>Zetsuko apologizes for Mistress's absence, " + pc.mf("Master", "other Mistress") + ".  Mistress wasn't able to be here, so she sent Zetsuko instead.  Zetsuko was hoping perhaps today " + pc.mf("Master", "Mistress") + " would deign to loosen Zetsuko's bonds?</i>\"\n\n");

		output("You tell her that you have no plans to let her loose today, which causes her to pout a little, though Ceraph's piercings seem to keep her from being actively defiant.  Your eyes are drawn down to watch as her obscenely long tongue unfurls from between the folds of her pussy, slathering slick juices along the insides of her thighs in anticipation.");

		output("Will you make use of Zetsuko now, or send her back to Ceraph?");
		if (silly) {
			output("  (You also remember Ceraph's note had mentioned something about a safety word... what was it again?)");
		}
	}
	//[FuckVagina] [GetTongued] [Banana?]silly mode — [Leave]
	processTime(8 + rand(2));
	clearMenu();
	
	if (pc.hasCock()) addButton(0, "FuckVagina", fuckZetsukosTonguepussy);
	else addDisabledButton(0, "FuckVagina", "Fuck Vagina", "This option requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "GetTongued", getTonguedByZetsuko);
	else addDisabledButton(1, "GetTongued", "Get Tongued", "This option requires you to have vagina.");
	if (silly) addButton(2, "Banana", zetsukoBanana);
	
	addButton(14, "Leave", noZetsukoLoveToday);
	
}

//▶[FuckVagina] requires penis
private function fuckZetsukosTonguepussy():void
{
	clearOutput();
	var x:Number = pc.biggestCockIndex();
	output("Your lust and curiosity get the best of you as the sight of that licentious tongue wriggling around between her legs sends a heat to your groin, blood rushing into your [pc.cocks].  Zetsuko lays flat on her back, grinning up at you as her pussy licks itself in anticipation, and as you lower yourself down, her tongue snakes out even more, beginning to wrap itself around [pc.oneCock] and slathering it with her saliva-like juices.  Your sensitive member can feel that the surface of her tongue is covered in hundreds of tiny bumps and nubs that massage your shaft, and the multiple studs that line it rub you sensually as the bizarre organ coils around your " + pc.cockDescript(x) + " like a snake, the very tip gently stimulating around the edges of your urethra.\n\n");

	output("You marvel at the incredible degree of control she seems to have over her tongue, watching as it begins to stroke and squeeze along your shaft, coating you in slick saliva from base to tip.  Its grip around you tightens up a bit, and you can feel it tugging you down gently, drawing your " + pc.cockDescript(x) + " ever closer to her entrance.  Her vagina lips spread open as you approach, gaping wide like a hungry mouth, and as it does so, you can see that the inner surface of her pussy has a number of soft bumpy nodules lining it in a downward spiral pattern.\n\n");

	output("\"<i>Zetsuko can't wait to have " + pc.mf("Master's", "Mistress's") + " dick in her pussy...  she knows " + pc.mf("Master", "Mistress") + " will just love it...</i>\" she says, wiggling her hips a bit as she pulls you up against her entrance, her lips sucking on the tip gently.");
	if (pc.cockVolume(x) >= cockVolume(100)) output("  You wonder just how she plans to fit you inside, but there's not much you can do about it at this point.  You'll just have to trust that she knows what she's doing, crazy or not.");
	output("  As you begin to grope her enormous jiggling breasts, you keep looking down to watch as her tongue slithers along your length, stretching out across it and then squeezing tight.  It begins to contract, the motion squeezing the first inch or so of your cock inside, and she sends up a moan, repeating the motion again and again, each time pulling a bit more of you inside.\n\n");

	output("In no time at all, you ");
	if (pc.cockVolume(x) >= cockVolume(100)) output("somehow ");
	output("find yourself up to the hilt inside the strangely-textured orifice, while her tongue slides along the underside of your cock.  It curls along underneath you, ");
	if (pc.balls > 0) output("slithering across your [pc.balls], ");
	else if (pc.hasVagina()) output("gently licking the outer edges of your labia, ");
	output("moving along to the back, ");
	if (pc.balls > 0 || pc.hasVagina()) output("and ");
	output("teasing your " + pc.assholeDescript() + " gently.  You gather up a mound of her soft tit flesh in each hand and begin squeezing along them lustfully, pushing on her pierced nipples with your thumbs gently while her tongue continues to lick and pleasure everything within its reach.\n\n");

	output("\"<i>Ooo-oohh! " + pc.mf("Master's", "Mistress's") + " cock tastes so good in Zetsuko's pussy!</i>\" she moans, rolling her eyes back as you feel her begin to \"<i>suck</i>\" on your " + pc.cockDescript(x) + " deeply, rocking her hips back and forth.  The suction inside her drooling cunt feels like one of the most intense deepthroats you've ever felt, and you forget for a moment that it's coming from her vagina until Zetsuko's loudest moan yet snaps you back to reality.\n\n");

	output("Deciding to give the crazy slut a little payback for so rudely interrupting your fantasy, you reach down and begin to twist the studs in her nipples lightly, grinning like a maniac as her slavering cunt suddenly clenches up around you from the sensations.\n\n");

	output("\"<i>Ahh! Yes, " + pc.mf("Master", "Mistress") + "! Punish bad Zetsuko! More, more, please!</i>\"\n\n");

	output("As you continue to torture her nipples, she arches her back in ecstasy and begins to buck wildly, her pussy-tongue slapping around erratically now, flinging saliva-juices everywhere.  The tongue in her normal mouth is hanging out now, long enough to reach her chest, her eyes rolled back with a blissful grin on her face.  You can feel your climax coming on, and apparently Zetsuko can too as she yells out between moans, \"<i>Ah! " + pc.mf("Master", "Mistress") + ", give Zetsuko your tasty cum!</i>\"\n\n");

	output("With the way her pussy and tongue are squeezing you now, it would be nearly impossible not to indulge her request.  Your " + pc.cockDescript(x) + " twitches inside her, releasing a creamy deluge that causes Zetsuko to begin drooling from both ends.  \"<i>Oooh...  so good, so thick, so creamy...  Fill Zetsuko up, yes!</i>\"");
	if (pc.cumQ() <= 100) output("  Your orgasm ends quicker than it seems Zetsuko wanted it to, the last of your few thin streams of cum spraying into her pussy.  It seems to suck on you all the harder, as if trying to dredge out just a few more drops.");
	else if (pc.cumQ() <= 500) output("  You fire creamy ribbons of cum into her, feeding what seems to be a never-ending hunger for semen as her pussy clenches and squeezes you for every drop.  Her tongue wraps around your member and squeezes along the length inside her to force out the remaining contents of your urethra, and a strong swallowing motion inside her vagina carries your thick load away.");
	else output("  The strong sucking motions of her cunt milk your shaft for everything it has, her pussy greedily swallowing load after load of your hot spunk.  Her walls continue to milk you even as her abdomen begins to swell with the volume of your seed, growing outward into a gravid, jiggling belly.  When your orgasm finally ends, Zetsuko looks like she's several months pregnant, and she has a look of utter satisfaction on her face.  \"<i>NNnnnaaaaahhhhh....  Zetsuko...  is full.</i>\"");
	output("\n\n");

	output("Her pussy continues to suck on you gently as you pull out, and when your " + pc.cockDescript(x) + " finally comes free of her bizarre lovehole, her tongue gently swirls around the lips before retracting itself inside.  You back up, wondering if you should help the bound kitsune to her feet, but as you are considering this, she flashes you a crazed grin and is suddenly bathed in purple flames, disappearing before your eyes.\n\n");

	output("\"<i>Zetsuko hopes to taste " + pc.mf("Master", "Mistress") + " again sometime...</i>\"");
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("lib", .25, "sen", -5, "cor", 2);
	pc.slowStatGain("l", 0.25);
	pc.cor(2);
	addNextButton();
}

//▶[GetTongued] requires vagina
private function getTonguedByZetsuko():void
{
	clearOutput();
	var x:Number = -1;
	if (pc.hasCock()) x = pc.biggestCockIndex();
	output("Heat rushes to your groin as you stare at the outlandish appendage wriggling between Zetsuko's legs, feeling yourself becoming wet with anticipation.  Seeking to entice you further, she rolls herself back, placing most of her weight on her shoulders as she curls her lower body up into the air, her tongue slithering back and forth along her thighs.\n\n");

	output("\"<i>Pleeeease, let Zetsuko taste Mistress's pussy?</i>\" she says, grinning up at you as you approach.  \"<i>She's certain her tongue can please Mistress greatly...</i>\"\n\n");

	output("The salacious organ slithers toward you, caressing the outer lips of your " + pc.vaginaDescript(0) + " and gently prodding your " + pc.clitDescript() + " before receding, making what can only be described as a \"<i>come hither</i>\" motion.  You take a step forward, pressing your hips up against the heavy cushions of her ass, and her tongue immediately curls toward your groin, ");
	if (x >= 0) output("wrapping itself around your " + pc.cockDescript(x) + " and squeezing momentarily before ");
	output("heading straight toward your slit.\n\n");

	output("As the tip begins to probe your depths, you can feel that the surface of her tongue is covered in hundreds of tiny nubs and bumps that give it an incredible texture.  You can't help letting out a lewd moan as the muscular organ pushes yet deeper still inside you, flexing and contorting into various shapes to augment the intense sensations.\n\n");

	if (x >= 0) {
		output("In a somewhat impressive feat of contortion, Zetsuko brings her feet in toward her groin to stimulate your [pc.cocks], lifting ");
		if (pc.cockTotal() == 1) output("it");
		else output("them");
		output(" up using her toes and stroking along the underside of the shaft");
		if (pc.cockTotal() > 1) output("s");
		output(" with the soles of her feet.  Her toes are surprisingly dextrous, able to curl around and grip your " + pc.cockDescript(x) + " lightly, gently pinching and tugging at the skin just under the head and manipulating your throbbing member");
		if (pc.cockTotal() > 1) output("s");
		output(" almost as skillfully as if she were using her hands!\n\n");
	}

	output("You slide your hips forward, curling her body back further and resting your weight on the pillowy cushions of her bottom, riding down onto her tongue and shivering deliriously.  You can feel it plumbing your depths, slithering into you and filling every nook and cranny as it swells and flows along your walls to take up every last bit of room you have.  The degree of control she has over it is simply incredible, becoming thicker to stretch your " + pc.vaginaDescript(0) + " and then suddenly retracting to swirl itself into a spiralling tendril that drills your hole lewdly.\n\n");

	output("\"<i>Oooh, Mistress's pussy is delicious!</i>\"\n\n");

	output("Grabbing hold of her thighs, you begin to rock yourself back and forth across her tongue, moaning powerfully as you feel it begin to thrust in and out of you now.  The numerous studs that line the center of the organ begin to press firmly against the roof of your " + pc.vaginaDescript(0) + ", stimulating your G-spot and flicking your " + pc.clitDescript() + " each time her tongue dives back inside you.  Your fingers dig into her flesh like a vice now as you grind yourself down on the indecent tendril, moaning salaciously as the waves of your climax begin to overtake you.\n\n");

	output("Your " + pc.vaginaDescript(0) + " cinches tight around Zetsuko's tongue, and it continues to wriggle inside you while you ride out your orgasm.");
	if (x >= 0) {
		output("  [pc.EachCock] twitches powerfully between her feet, ");
		if (pc.cumQ() <= 100) output("spurting a healthy spray of hot cum all over her face and chest.");
		else if (pc.cumQ() <= 500) output("distending visibly as it begins to pump out thick streams of spunk all over her waiting face and tits.");
		else output("unleashing a heavy downpouring of cum all over her face and tits that soaks through her straitjacket and mats her hair down with your thick load.");
		output("  She grins lasciviously and opens her mouth to reveal her other freakishly long studded tongue, using it to lap up your spunk hungrily and clean herself off.  \"<i>Mistress's cum is so tasty...</i>\"");
	}
	output("\n\n");

	output("The slick juices of your climax trickle down, pooling inside Zetsuko's gaping pussy");
	if (pc.wetness() >= 4) output(" and overflowing to dribble down her bountiful ass cheeks and stomach");
	output(".  You hear an odd gurgling sound, and watch as the puddle of juices slowly begins to drain down into her vagina, a visible swallowing motion carrying it away inside her.  \"<i>MMmmmm...  Zetsuko loves the taste of Mistress's juices...</i>\"\n\n");

	output("Fully spent, you pull yourself back, grasping Zetsuko's still-writhing tongue in your hand and sliding it out of you, letting her lower body thump to the ground.  You watch as her tongue gently swirls around the lips and then retracts within the bizarre orifice, looking for all the world to be an ordinary — if slightly overstretched — pussy.  You wonder if you should help her up for a moment, but as you are considering reaching down to bring her to her feet, she is suddenly bathed in corrupted flames, disappearing before your eyes.\n\n");

	output("\"<i>Zetsuko hopes to taste " + pc.mf("Master", "Mistress") + " again sometime...</i>\"");
	processTime(20 + rand(5));
	pc.orgasm();
	//dynStats("lib", .25, "sen", -5, "cor", 2);
	pc.slowStatGain("l", 0.25);
	pc.cor(2);
	addNextButton();
}

//▶[Banana?] silly mode
private function zetsukoBanana():void
{
	clearOutput();
	output("Banana? What the flying fuck is a banana?\n\n");
	output("Banana.\n\nBanana banana banana.  Just saying it feels kind of funny, so you say it a few more times just to be sure.  Yep, still funny.\n\n");

	output("\"<i>FUCKING MARAE PLEASE STOP SAYING BANANA — FUCK!!</i>\"\n\n");

	output("You hear a thud and turn to see Zetsuko lying face-down on the ground, struggling in vain to get back up with her arms bound.  She finally manages to wrench herself into a kneeling position, panting from exertion.  Her forehead has a big blotch of dirt on it like she has been repeatedly slamming it on the ground.\n\n");

	output("Banana.\n\n");

	output("\"<i>FUCK!</i>\"\n\n");

	output("As the word leaves your lips, you see the studs on Zetsuko's collar glow, and she is suddenly forced down to the ground again, face mashed in the dirt and her ass raised high while her pussy-tongue flails about wildly between her thighs.\n\n");

	output("\"<i>Hah... hah...  Zetsuko dislikes... those fruit... immensely,</i>\" she says, avoiding speaking the word aloud herself as she tries to lift herself back up yet again.\n\n");

	output("Oh, so a banana is a fruit? *THUD*\n\n");

	output("\"<i>FUCK!</i>\"\n\n");

	output("You'll take that as a yes.\n\n");
	
	processTime(3 + rand(2));
	addNextButton();
}

private function noZetsukoLoveToday():void
{
	clearOutput();
	output("You tell her to be gone; you wanted Ceraph, not some lowly slave that can't even be bothered to show you proper respect.  You order her to tell Ceraph not to waste your time with undisciplined servants that she's too inept to properly break.\n\n");

	output("\"<i>Oohoh, Mistress is certain to be FURIOUS with Zetsuko...</i>\" she says, licking her lips and showing off the numerous studs that line her normal tongue as well.  \"<i>Zetsuko cannot wait...</i>\"");
	
	processTime(2);
	addNextButton(campSlavesMenu);
}

private function giveFollowerBodyBits():void
{
	//spriteSelect(87);
	clearOutput();
	output("You ask Ceraph just what all giving up a body-part would entail.  Your submissive demonic slut presses herself against you, stroking her hands under your [pc.gear] as she answers, \"<i>Well, [pc.Master], I would use my body-shifting black magics to remove a choice portion of your 'fun-bits', if you know my meaning.");
	if (pc.hasCock() || pc.hasVagina() || pc.hasBreasts()) {
		if (pc.hasCock()) output("  I could take your cock.");
		if (pc.hasVagina()) output("  I could remove your snatch.  Don't worry, once it's off of you, anything I put in it won't wind up in your womb.");
		if (pc.hasBreasts()) output("  I could even make off with your tits if you like.");
	}
	else output("  Sadly, you don't have anything that would be worth taking right now.  A true shame, my [pc.Master].");
	output("</i>\"");
	if (pc.hasGenitals() || pc.biggestTitSize() > 0) {
		output("\n\nYou scratch your head as she prattles on, growing more animated and a touch aroused. \"<i>Then, I can fly back to the harem and add them to my collection.  My pets do so love when I give them an exotic endowment and then spend all night teasing it.  Could you imagine it?  Going to bed at night and dreaming of all the debauched things my slaves and I are doing, over and over?</i>\"");
		output("\n\nWell, that's quite the pitch she's put together.  Do you want to give her something?\n");
		
		//[(Biggest )Penis] [Smallest Penis][pc.vagina] [TopBreastRow] [2ndBreastRow] [3rdBreastRow]
		addDisabledButton(0, "Bigst. Pen.");
		addDisabledButton(1, "Smllst. Pen.");
		addDisabledButton(2, "Vagina");
		addDisabledButton(3, "BreastsRow1");
		addDisabledButton(4, "BreastsRow2");
		addDisabledButton(5, "BreastsRow3");
		addDisabledButton(6, "BreastsRow4");
		
		if (pc.hasCock()) {
			output("\nYou can give her your ");
			addButton(0, "Bigst. Pen.", ceraphFollowerCockTaking);
			if (pc.cockTotal() == 1) output("penis.")
			else {
				output("biggest penis or smallest penis.");
				addButton(1, "Smllst. Pen.", ceraphFollowerCockTaking, true);
			}
		}
		if (pc.hasVagina()) {
			output("\nYour vagina would probably give you the most amazing sensations while being used in Ceraph's orgies.");
			addButton(2, "Vagina", ceraphFollowerCuntTaking);
		}
		if (pc.biggestTitSize() >= 1) {
			output("\nDo you really need your boobs?");
			addButton(3, "BreastsRow1", ceraphFollowerTitTaking);
			if (pc.bRows() > 1) addButton(4, "BreastsRow2", ceraphFollowerTitTaking, 2);
			if (pc.bRows() > 2) addButton(5, "BreastsRow3", ceraphFollowerTitTaking, 3);
			if (pc.bRows() > 3) addButton(6, "BreastsRow4", ceraphFollowerTitTaking, 4);
		}
		
		addButton(14, "Back", ceraphFollowerAppearance);
	}
	else addNextButton(ceraphFollowerAppearance);
}

private function ceraphFollowerCockTaking(smallest:Boolean = false):void
{
	//spriteSelect(87);
	clearOutput();
	var x:int = smallest ? pc.smallestCockIndex() : pc.biggestCockIndex();
	
	output("You sigh and undress enough to point at your [pc.cock " + x + "], indicating that Ceraph is welcome to have it.  Ceraph titters, \"<i>With pleasure, my [pc.Master].</i>\"");
	output("\n\nCeraph's fingers feel unexpectedly hot as they brush your " + pc.cockDescript(x) + ", as if she had just come out of a heated tub.  You don't have long to ponder that little detail as they pinch into a tight ring");
	if (pc.cocks[x].thickness() >= 4) output(", compressing your massive girth into the rigid shaft");
	output(", slowly closing.  It should hurt but it doesn't, it just feels warmer and warmer, and then with a sudden 'PYOING!', Ceraph is holding your " + pc.cockDescript(x));
	if (pc.balls > 0 && pc.cockTotal() == 1) {
		output(" and balls");
		//Gotcher balls!
		pc.balls = 0;
		pc.ballSizeRaw = 1 * Math.PI;
	}
	if (pc.cockTotal() == 1) pc.removeStatusEffect("Infested");
	output(" in her hand!  At the base there's smooth flesh and an arcane mark, somehow keeping the disembodied dick alive to pulse and squirm in her grasp.  The place on your groin is left completely smooth and featureless, as if it had never been there at all.");
	output("\n\nCeraph runs a finger up and down the length, setting off fireworks in your brain – you can still feel it!  The demoness laughs and says, \"<i>Don't worry, that will fade once I get it further away, though you know what to expect at night, right?  For now, enjoy the pleasure!  Oh, and thank you again for this, you won't regret it.  If you do, no refunds.</i>\"");
	output("\n\nShe pirouettes away, practically dancing into the sky while she strokes and teases the cock you just lost.  You shudder and shake as orgasm wracks your body, your cum falling like rain thousands of feet away.  You swear, you can hear your pet laughing.");
	processTime(15);
	pc.orgasm();
	pc.slowStatGain("l", -2);
	pc.cor(5);
	//dynStats("lib", -2, "sen", -2, "cor", 5);
	IncrementFlag("COC.CERAPH_COCKS_GIVEN");
	pc.removeCock(x, 1);
	addNextButton();
}

private function ceraphFollowerCuntTaking():void
{
	//spriteSelect(87);
	clearOutput();
	output("You undress, just enough to point at your [pc.vagina].  Ceraph smiles happily and muses, \"<i>I have just the troublesome slut that could learn a thing or two by having her mouth replaced by a pussy.  Face-fucking is such an effective discipline technique, thank you dear.</i>\"");
	output("\n\nCeraph's fingernails stab at your [pc.skinFurScales] painfully, dragging them in a circular motion around your vulva.  The pain of the action fades to a gentle, throbbing heat while her fingers go deeper, corkscrewing through your flesh.  A second later she pulls back, a featureless pillar of flesh wrapped in skin and sitting in her hand, topped with your " + pc.vaginaDescript() + ".  The other end is capped with a strange, arcane mark, seemingly tattooed into the skin.  You glance down, expecting to find your groin ruined, but the spot your vagina once occupied is replaced with bare, unmarked skin.");
	output("\n\nThe demon slips a finger into her hand-held pussy, and you inexplicably moan, still feeling every sensation with perfect clarity.  She plays with it for a few more seconds, the gentle 'schlick-schlick-schlick' of her fingers carrying through the air before she seems to tire of teasing you.");
	output("\n\n\"<i>Oh don't mind the feelings, they'll fade once I get farther away and get this stuffed into one of my pets.  Thank you again, [pc.Master] for supporting your pet's ever-growing harem.  I'll be sure and put the new pocket-pussy to use right away so that you'll have some good dreams soon.  I'll miss seeing it on you though, so if you would, please replace it. </i>\" instructs Ceraph with an air of feigned meekness.");
	output("\n\nYou work your jaw in consternation, trying to stay upright as Ceraph starts to fly away, amusing herself by masturbating your old cunt as she flies.  The lewd squishes seem to hang in the air, and you're helpless to do naught but writhe in the dirt and moan as you're brought to orgasm from a nonexistent vagina.  It seems as soon as she leaves camp she forgets she's supposed to be YOUR subservient bitch.");
	processTime(15);
	pc.removeVagina(0, 1);
	//pc.genderCheck();
	//(-100 lust, -1 fetish, +1 vagina toy status)
	pc.orgasm();
	//dynStats("lib", -2, "sen", -2, "cor", 5);
	pc.slowStatGain("l", -2);
	pc.cor(5);
	IncrementFlag("COC.CERAPH_VAGS_GIVEN");
	addNextButton();
}

private function ceraphFollowerTitTaking(rowNum:int = 0):void
{
	//spriteSelect(87);
	clearOutput();
	var x:Number = rowNum;
	//Store nipplecuntz or milks
	if (pc.breastRows[x].fuckable) flags["COC.CERAPH_EXCHANGE_TARGET"] = 4;
	else if (pc.lactationQ() >= 100) flags["COC.CERAPH_EXCHANGE_TARGET"] = 5;
	else flags["COC.CERAPH_EXCHANGE_TARGET"] = 3;
	output("You pull down your [pc.gear] to bare your bosom to Ceraph and indicate that you'd like her to take it.  She smiles like a cat who's gotten the cream and whispers, \"<i>Your wish is my command, [pc.Master].</i>\"");
	output("\n\nCeraph bounces your " + pc.breastDescript(x) + " in her hands, playing with them for just a few seconds before she digs her nails in and pulls.  Your tits stretch for a moment, pulled tight while Ceraph giggles cruelly.  Heat blooms inside your chest, vivid tingles radiating from Ceraph's fingertips deep inside you.  At last it peaks and with a deep 'POMF', your tit-flesh separates from your body.  You look closely at the departing bosom – where it once joined with your body, it's covered in healthy pink skin and intricate, arcane tattoos.  Meanwhile, ");
	//More than 1 set of tits and not on bottom row?
	if (x < pc.breastRows.length - 1 && pc.breastRows.length > 1) {
		//If only 1 row below
		if (x >= pc.breastRows.length - 2) output("your torso has shifted and your " + pc.breastDescript(x + 1) + " have moved up to fill the void.");
		//Multiple below
		else output("your torso has shifted and your other breasts have moved up to fill the void.");
		pc.removeBreastRow(x, 1);
	}
	//Top row is only row
	else if (x == 0) {
		output("your now-flat chest slowly gains two tiny nipples.");
		pc.breastRows[0].breastRatingRaw = 0;
		pc.nippleLengthRatio = 1;
		pc.breastRows[0].breasts = 2;
		pc.nipplesPerBreast = 1;
		pc.breastRows[0].nippleType = GLOBAL.NIPPLE_TYPE_NORMAL;
		pc.milkMultiplier = 0;
		pc.milkFullness = 0;
	}
	//everybody else
	else {
		output("your torso leaves the now-empty spot as a flat, featureless void.");
		pc.removeBreastRow(x, 1);
	}
	//Oh shit something went wrong.
	if (pc.breastRows.length == 0) pc.createBreastRow();
	output("\n\n");

	output("You gasp when Ceraph ");
	if (flags["COC.CERAPH_EXCHANGE_TARGET"] == 3) output("rolls the nipples in her hands");
	else if (flags["COC.CERAPH_EXCHANGE_TARGET"] == 4) output("pushes her fingertips inside the leaky nipple-cunts");
	else output("squeezes out a squirt of milk");
	output(", going a little weak in the knees.  Ceraph laughs and lowers the bouncy orbs down between her legs, and you can feel every little bump and nodule of her corrupted cock as she tit-fucks herself on your disembodied breasts.\n\n");

	output("\"<i>Oh oh, does someone like having a nice hard cock buried in her tits?  Maybe I should've left these on you so that I could get the full benefit before I left.  Maybe next time,</i>\" taunts the demoness while she continues to tit-fuck herself on your former bosom.  \"<i>Don't worry, [pc.Master], I'll be sure to give them a good home.  You should get plenty of nice dreams out of these sweater puppies!</i>\"\n\n");

	output("Ceraph turns and prances off through the rocks, tweaking your nipples HARD every few moments to remind you of your choice.  She vanishes before long, leaving you to deal with the slowly dwindling sensation of her cock in your tits.\n\n");
	//(-1 fetish, +1 tit toy status)
	processTime(15);
	pc.lust(20);
	pc.cor(5);
	IncrementFlag("COC.CERAPH_BREASTS_GIVEN");
	addNextButton();
}

//NippleCunt Stuffing (Ceraph grows dick-nipples to plow your lusty twats!)
private function stuffSomeNippleCunts():void
{
	//spriteSelect(87);
	clearOutput();
	output("Wanting to take advantage of some of the more extreme of your body's changes, you pull down your [pc.gear] to bare your hungry nipple-twats, the well-lubricated tips of your nipples slowly opening in anticipation of what's to come.  You kick the discarded gear aside and command, \"<i>Slave, fuck my nipples.</i>\"");
	output("\n\nCeraph looks at you, then down at your chest, and finally back up at you with a look of incredulousness glinting in her eyes.  \"<i>You want... [pc.Master] is... kinky,</i>\" she coos, peeling out of her tight outfit to bare her demonic bosom.  Your demonic slave approaches, hips swaying as her bottom falls away to display her puffy purple womanhood");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(" and proud demon-dick");
	output(".  She grabs your [pc.chest] to examine, and her fingers probe hesitantly around the entrances of your budding chest-cunnies.  Ceraph smiles with wicked intent.  Her fingers thrust in forcefully, drawing a sensual moan from your lips as she violates ");
	if (pc.totalNipples() > 2) output("two of ");
	output("your tit-pussies.");
	output("\n\nThe demoness' digits forcefully enter you again and again, pushed in to the knuckle.  Juices drip down the swells of your breasts as Ceraph gets a feel for your depth, width and sensitive spots.  Her probing fingers casually rape your areola, and it feels goddamn good.");
	if (pc.totalNipples() > 2) output("  She moves from pussy to pussy with ease, exploring every single one of your myriad holes, a gleeful smile on her face.");
	if (pc.isLactating()) output("  A squirt of breastmilk nearly takes your slave in the eye, your milk letting down uncontrollably from the tit-puckering finger-fuck.");
	if (pc.hasCock()) output("  [pc.EachCock] is so hard by this point that it's smearing its pre-cum all over Ceraph's belly, but she doesn't mind.");
	if (pc.hasVagina()) output("  As for your [pc.vagina], you've grown more than wet enough for a hard dicking, but honestly, right now, all you want is your [pc.nipples] to be perfectly and completely fucked.");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  The fetishistic slut's sloppy cock is dribbling on your hip, neglected and aroused.  Poor thing.");
	output("\n\nSatisfied with her work, your submissive Omnibus steps back to look at you.  Your " + pc.skin() + " is flushed.  Every inch of your underboob is wet with lubricant[if (isLactating = true)  and milk].  Your [pc.nipples] are a soggy, inflamed mess.  Worst of all, you're panting like some bitch in heat.  Your slave is just out of arm's reach, watching you with a knowing smile.  Her own purple-hued dermis is tinted rose, though she seems to be hiding her arousal better than you.  You growl, \"<i>I said, fuck my gods damned nipples!</i>\" at her and jiggle your dripping teats for emphasis.");
	output("\n\nCeraph frowns with distaste, but she answers, \"<i>[pc.Master], please, shapeshifting takes time and preparation.  However, I believe I am almost ready to serve you.  Watch me change, for you...</i>\"  Ceraph cups her own sizable breasts in her palms and begins to rub them.  Her nipples, while already hard, pop out further, elongating with a well-timed, breathy exhalation of pleasure from their owner.");
	if (pc.bRows() > 1) {
		output("  A second later, ");
		if (pc.bRows() == 2) output("another row of female flesh begins");
		else output("more rows of female flesh begin");
		output(" to sprout beneath her top pair, the demoness's chest mimicking yours in size and structure.  While the top pair of super-sized nipples continue to grow into massive teats, Ceraph repeats her caresses lower, and the newly-formed nipples mimic their big brothers, filling out to obscene length.");
	}
	output("  At first, the changes make her areola look more like something that belongs on an udder, but as they enlarge beyond even that, you realize they're taking on a distinctly masculine shape, with a slight ridge just below their bulbous tips.  After growing out almost seven inches, the upward-curving nipples stop filling out.  Ceraph has sprouted nipple-dicks!");
	if (pc.averageNipplesPerBreast() > 1) output("  She strokes them, one by one, and they split down the middle, dividing into a multitude of penises, a perfect match to your quad-nipplecunts.");
	output("\n\nYou cannot help but gape at the lascivious demonette's new form.  She's absolutely, unquestioningly built for sex, from her wide hips and well-defined pussy-lips to the absolutely obscene growths she's produced for your whims.  Ceraph brushes her hair back and asks, \"<i>I take it you like the look, [pc.Master]?</i>\"  You nod and stick your fingers into your chest, pulling open the holes to tempt her.  It's hard to bite back the moan that wells up in your throat, but you manage, somehow, to keep your expression placid and seductive.");
	output("\n\nYour freakishly-endowed minion steps forward with an enthusiastic expression plastered on her face, taking care and time to line up each of her tit-mounted tools with your [pc.nipples].  Ceraph glances up at you deferentially, and you nod, perhaps a bit more eagerly than you intended to.  At once, " + num2Text(pc.totalNipples()) + " shafts are sliding into your udder-mounted vaginas, their pulsating demon-flesh wetly stroking your multiple interiors in perfect, exquisite sync.  A sense of barely-understood bliss erupts from your chest-pussies as they're taken, utterly filled.  It's difficult to think, let alone stand under such circumstances, and you clutch on to Ceraph's shoulders, pulling her down to the ground atop you.");
	output("\n\nYour pet demon immediately gives in to her instincts and begins to raise and lower herself atop you.  At the bottom of each stroke, fluids squirt from your violated holes and the pairs of docked boobflesh squish outward, bulging obscenely.  Interlocked bodies grind together in the throes of passion, Ceraph going faster and faster, filling the air with squishing slaps of intercourse.  Soon, she is going so fast that it's impossible to pick apart the myriad of sultry sounds, not that you can think properly at present to try.  You lie there to simply enjoy the sex, wallowing in it like a sow in mud.");
	output("\n\nCeraph chews on her lower lip in nervous pleasure as she bobs up and down atop you, and in a moment of surprising clarity, you order, \"<i>Slave, kiss me.</i>\"  She does so with gusto, her purple-hued mouth instantly locking to yours, tongues twisting around each other like warring snakes.  It's almost enough to make you forget the pounding rhythm of her lube-soaked tits slapping against your own, ALMOST.  The turgid tit-cocks feel even bigger with every pistoning movement in and out of your cavities.  You realize she's getting close to orgasm, and a moment later, it dawns on your lust-fogged mind that you too are about to climax.");
	output("\n\nBiting down on Ceraph's lower lip, you get her to pull back long enough for you to command, \"<i>Cum inside me pet, fill my tits!</i>\"  Ceraph's violet eyes cross ever so slightly, the black sclera glittering with moisture as her eyelids flutter in rapture.  She throws herself down on top of you with bruising force, bottoming out all " + num2Text(pc.totalNipples()) + " twitching dicks inside you, just in time to release their creamy cargo.  Gods, she's filling you up so good!  You reach up with your hands and squeeze the edges of your [pc.chest] hard enough to feel the rigid, cum-spouting flesh inside you.  Jizz wells up from each entrance in sync as you begin to tremble and shake.  Ceraph lets out a low moan as she fills you");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(", her cock spouting its own ivory wetness onto your belly in sympathetic release.");
	else output(", her pussy dripping weakly in sympathetic release.");
	output("  Her hands run through your [pc.hair] and pull your [pc.face] into her shoulder.  She holds you tightly, clingingly even.  If you weren't so enraptured by the sensation of your sperm-filled nipples, you might actually care.");
	output("\n\nThe two of you slowly relax, dueling climaxes winding down to return some level of sanity at last.  As soon as the demoness' eyes uncross, she stands up, " + num2Text(pc.totalNipples()) + " dicks sliding free of clutching, spunk-stuffed twats at once.  You gasp and shudder, the sensitive flesh nearly setting you off again.  As she stretches, Ceraph's new appendages shrink, losing their masculinity and even faster their size.  You rise while trying to ignore the runnels of demon-spunk that spout from your well-fucked chest, your [pc.chest] wobbling fantastically with the extra fluid weight.  Ceraph leans over to suck a [pc.nipple] into her mouth, and after a few quick swallows, she sighs contently.");
	output("\n\n\"<i>Delicious, my [pc.Master],</i>\" the demoness coos as her wings unfurl, \"<i>Please, let's do this again.</i>\"  She leaps into the sky and flies off, no doubt to tend to her own pets.");
	processTime(20 + rand(10));
	pc.orgasm();
	//dynStats("sen", 2, "cor", 1);
	pc.cor(1);
	addNextButton();
}

//Portal Fuck (AKA Ceraph Hung Out With Cinnabar, Req's PC dick)
private function portalFuckWithFollowerCeraph():void
{
	//spriteSelect(87);
	clearOutput();
	var x:int = pc.cockThatFits(cockVolume(100));
	var y:int = x + 1;
	//FIRST TIME:
	if (flags["COC.TIMES_CERAPH_PORTAL_FUCKED"] == 0) {
		output("You undress and ask Ceraph if she has any ideas to mix things up.  Your demon smiles and answers, \"<i>Oh, I think I have just the thing: a pair of trinkets I picked up at the bazaar.  There's a... gifted prostitute there who I would love to have in my harem, but alas, if I am to have access to that cursed place, I must abide by their rules.</i>\"  A shadow clouds the greedy demoness's expression at that admission, but she continues on, \"<i>I was able to get her to produce for me two magical cock-rings.  They're powerfully enchanted with white AND black magic.</i>\"");
		output("\n\nCareph smiles knowingly, still not revealing their true purpose.  With an impatient wave of your hand, you command her to finish.  She harrumphs, \"<i>Fine, take all the drama out of it!  These cock-rings create portals, portals to anywhere the user desires.  You could put one on, and have your dick rammed into my throat, simply by imagining it.  You could sit there, in a chair, masturbating yourself with the ring and actually manage to fuck my hot little cunt at the same time.</i>\"");
		output("\n\nYou look at the golden rings a bit skeptically, but Ceraph assures you, \"<i>Trust me, they work.  I resized one of them to fit me perfectly, and I'll often use it to keep my pets in line, no matter what part of my lair they're in - even the sensory deprivation tanks.");
		if (flags["COC.CERAPH_HIDING_DICK"] == 1) output("  Of course, you don't seem to like that appendage, so my ring won't get much use today, will it?");
		output("</i>\"");
		if (flags["COC.CERAPH_HIDING_DICK"] == 1) output("  Ceraph twirls one of the rings into her palm, where it promptly vanishes in a puff of purple smoke.");
		output("\n\nThe mauve miscreant tosses the ring to you, still warm from her body heat and tingling with embedded magic.  You sit down in a simple chair and turn it over in your hand before deciding to go with one of her suggestions.  \"<i>Slave!</i>\" you bark, \"<i>Lie on your back before me with your legs spread.</i>\"");
	}
	else {
		output("You suggest Ceraph retrieve her fantastically enchanted cock-rings, and with an impish smile, your slave produces a pair of them in puffs of purple smoke.");
		if (flags["COC.CERAPH_HIDING_DICK"] == 1) output("  She sadly teleports one of them away, knowing you've commanded her to stay female for you.");
		output("  The mauve miscreant tosses your ring to you, still warm from her body heat and tingling with the embedded magic.  She requests, \"<i>Please, [pc.Master], do me like you did before!  It was so hot for you to watch me like that!</i>\"");
	}
	output("\n\nCeraph obediently lays on the ground beneath you and spreads the flawless purple skin of her thighs apart to reveal her womanhood");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output(" and eager cock");
	output(".  She scoots her ass up so that it's resting against your [pc.legs] and the front side of the chair, a tantalizing heart-shaped butt just within arms' reach.  You give it a slap, which garners a delighted coo from the tainted slut.");
	output("\n\nNow that everything is in position, it's time for the moment of truth.  You push the ring down on your [pc.cockHead " + y + "] until the warm metal frame is snugly secured just above your [pc.sheath].  The tingling you could feel when it was in your hand was a mild pinprick compared to the prickling sensations it shoots through your [cock " + y + "].  They aren't unpleasant, but they are certainly intense, and combined with the tightness of the ring, they keep you nice and hard.");
	if (flags["COC.TIMES_CERAPH_PORTAL_FUCKED"] == 0) output("  Well, your dick doesn't look any different, aside from the gilden adornment stuck near the bottom.  Now, if it were hilt-deep in the demon's cunt, that would be something!");
	else output("  Well, no sense wasting time!  You look down at Ceraph's moist box and imagine your dick spearing through her folds.");
	output("\n\nWhite light flashes along with a wave of tingling pinpricks under the ring on your [cock " + y + "]!  You blink and look down, seeing a strange arcane symbol INSIDE the cock-ring's center.  That glimmering glyph has become the terminus of your suddenly-stunted, plateau-like member.  Ceraph's coo of pleasure tears your gaze further down, and you see a matching glyph just above her pussy, with the rest of your [cock " + y + "] completely buried into her wetness.  You don't just see it, you can feel it too.  Her wet snugness is molding around your girth, yielding to the intrusion like a glove wrapping around a hand.");
	output("\n\nExperimentally, you grab the ring and move it slightly.  Taking it up slides your dick partway out of her cunt, more flesh appearing by magic on your loins as the glyph is pushed away.  Moving it down diminishes your visible erection, but it also fucks Ceraph's twat.  The demoness's gaze is riveted on her magic-illuminated snatch, watching happily as you experimentally plunge in and out of her sodden box.");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("\n\nNot one to be outdone, your pet takes the other ring and begins to force it down her nubby demonic dong.  The gold-gilt dick-jewelry settles quite firmly just above her creamy pussy, and with a matching flash of light, her own member disappears.  Surprisingly, it doesn't appear in any of your orifices.  A quick glance her way reveals just where her dick wound up - in her mouth.  Ceraphs glossy lips are spread in a wide 'o', a thick demon-dick holding them open as she bobs her head up and down.  Greedy slurps and muffled moans drift up from her through the autofellatio, and you watch excitedly while masturbating yourself with her cunt.");
	output("\n\nYou make good use of your new toy, pulling it up to just below the head before slamming it down hard, all the way to your [pc.sheath].  It feels every bit as good as fucking her normally, but without having to actually move your whole body, you're able to relax and enjoy the experience more.  As an added benefit, you can see the way your pet slut's purple nether-lips blush as she gets more aroused, moisture spilling out around your thickness to drizzle through her asscrack.  With your free hand, you grope one of the slaves contoured cheeks, feeling its heft, its softness, and its lewd jiggles.  You begin to moan, enjoying this more than you ought to, yet helpless to slow your pumping hand.");
	output("\n\nThere's no stopping the surging passion as it races through you, and with a throaty sigh, you release your seed.  It's amazing, from this vantage you can do more than just experience your orgasm, you can watch it happen.  You can see the underside of your disembodied cock bulging with each urethra-stretching load.[if (cumQuantity > 500)   Jizz foams at her lips as her belly rounds, and you're treated to the sight of Ceraph's bellybutton suddenly becoming an outtie.][if (cumQuantity > 1000)   A moment later, her stomach rounds further, taking on a positively pregnant appearance.][if (cumQuantity > 1500)   Spunky rivers pump from the demon's overfull womb as it loses its ability to stretch any further.]  You sigh and idly move the portal up and down, fucking through the sloshing, sperm-filled mess that the demon's cunt has turned into.  Delightful.");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("\n\nCeraph gurgles happily for a second, then her cheeks bulge.  Her throat begins working, and you realize she's cumming into her own mouth.  By the look of how squirrel-like her visage has become, she can barely manage to swallow a mouthful before the next is stuffing her full, dribbles of pearly cream running freely from the corners of her mouth.  Ceraph quietly gulps and swallows over and over until her dick finally begins to soften, spent at last.");
	output("\n\nYou stand up and stretch, your cock still lodged tight in Ceraph's cooch.  Alas, all good things must come to an end, and with one slow tug, you remove the ring from your [cock " + y + "] (and your maleness from her cunt).  You toss the borrowed item back to her, letting it fall on your slave's heaving bosom as she tries to recover, a fucked-out mess in the dirt.  You turn to get dressed, and when you glance back, Ceraph is gone, until the next time you call for her.");
	processTime(20 + rand(10));
	pc.orgasm();
	pc.cor(1);
	//awardAchievement("Now You're Fucking With Portals", kACHIEVEMENTS.GENERAL_FUCK_WITH_PORTALS, true, true);
	IncrementFlag("COC.TIMES_CERAPH_PORTAL_FUCKED");
	addNextButton();
}

private function layEggsInSlaveCeraph():void
{
	clearOutput();
	//Either Type on Ceraph Follower: Finished (Posthuman) (Zedit)
	output("You ");
	if (!pc.isTaur()) output("absently rub the sensitive bulge in your abdomen as you ");
	output("regard your slave.  There certainly is something she could do for you.  Imperiously, you let her know that you have a load you wish to get rid of, and you intend to plant it in her.");

	//[if (cocks > 0) 
	if (pc.hasCock()) output("  Ceraph glances at the bulge in your [pc.gear] quickly before she demurely lowers her eyes.  A wicked smile plays across her beautiful face as she responds, \"<i>Yes, [pc.Master].</i>\"");
	else output("  Ceraph frowns as she glances towards your crotch.  She is disciplined enough to answer you quickly, however, with a sharp \"<i>Yes, [pc.Master].</i>\"");

	output("\n\nYou command her to turn around and bend over.  Your demonic slave hastens to comply, presenting her latex-covered sex to you brazenly.  The shimmering scrap of fabric hovers on the bare edge of decency; the strip is so narrow, you can see her puffy outer lips bulging out on both sides.");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("  The whole garment creaks and strains under the pressure of her hardening member.");

	output("\n\nYou frown.  Your slut knows that you're going to use her as an egg dump; how does she expect you to do that with panties in the way?  Growling, you grasp the shear latex around the waistband, right beneath her twisting tail, and [if (strength < 80) haul upwards.|pull upwards with such force that Ceraph is left dangling from the bikini bottom.]  The omnibus screams as the fabric cuts into the soft flesh of her sex");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("; unable to keep it penned up, her demonic cock spills out the side, waving back and forth obscenely as you saw the offending garment into her crotch");
	output(".");

	output("\n\n\"<i>Stop!</i>\" Ceraph cries as you jerk the bottoms back and forth savagely, \"<i>I'll take them off, " + pc.mf("Master", "Mistress") + "!  I'm sorry!</i>\"");

	output("\n\nYou roll your eyes and drop her to the dirt.  Knowing that she could have vaporized her clothing with a thought, had she been inclined, you let her make a show of slowly, painfully peeling off the bottoms before she resumes her original position, on her knees with her round, purple ass facing you.");

	output("\n\nYour ovipositor slips free of its sheath as you size up your slave's collection of holes");
	if (!pc.isTaur()) output(", and your fingers tremble slightly as you trace its segmented length, leaving a trail of lubricating mucus from tip to base");
	output(".  When you order your demonic slut to present her pussy to you, she slides an impeccably manicured hand between her thighs, opening her dark, glistening lips for you.");

	output("\n\nSurely, she can do better than that.  You step forward and plant one [pc.foot] against her ass, shoving her face forward into the campsite dirt.  \"<i>Wider,</i>\" you order.  She arches her back and reaches with both hands; each takes a violet lip and pulls it, exposing the inside of her vulva to you.  You see her hole gaping open and overflowing with juices, leaving a long strand of goo dangling between her thighs.");

	output("\n\nShe is doing better, but why not see how far she can take her tainted body?  \"<i>Wider!</i>\" you bark.  Without missing a beat, Ceraph slips her fingers inside her sopping box itself and pulls it open until you can see inside her.  A veritable forest of feelers and growths in various shades of purple and black writhe on every inner surface of her vagina.  Actually seeing them move makes you feel a little nauseous, but at the same time, you can't help but note the tingling arousal spreading up from your groin.");

	output("\n\nAt the back of her vagina, the omnibus's cervix almost glows, several shades lighter than the surrounding flesh.  You smile and order her to open it.  Ceraph grunts with effort, but you are rewarded by the sight of the tiny slit dilating.  There is certainly something to be said for how... accommodating demonic corruption can make a creature's body.");

	output("\n\nYou position yourself behind your slave and begin slowly working your ovipositor into her.  With her fingers still pulling her sex open, all you feel is the slight tickling as the longest of the growths stroke your alien member.  Ceraph coos beneath you as the tapered head of your egg tube butts up against her cervix.  You barely have to exert any pressure to get into her tainted womb, as it welcomes you by sliding open further.  Your breathing becomes rough as you feel muscles inside your abdomen contract, bringing the first egg from deep inside you; your demon whore goes crazy as she feels the base of your organ swelling, grinding her ass against your hips.");

	output("\n\nAs your eggs travel towards your tip, they swell your organ until it rubs the sides of her distended pussy.  It feels as if the hot flesh is trying to close around your pseudo-prick like a mouth, making obscene sucking noises and dripping a steady stream of the frothed, mixed lubricant from both you and your slave.");

	output("\n\nThe feeling is too much for you to bear, and you cum as you spurt your first egg deep into Ceraph's body.  ");
	if (pc.hasGenitals()) output("Your orgasm spatters your degraded demon's rear, adding to the sopping mess your ovipositor is leaving.  ");
	output("More eggs follow the first, each one triggering a miniature orgasm for your slut as it fills her up. She screams and shudders, but is careful not to let go of her pussy.  What a considerate slave, you think, as you watch her belly expand with your eggs.  The faux-corset melts away as Ceraph quickly goes from bloated, to pregnant, to filled to bursting.  The surface of Ceraph's stomach actually ripples slightly under the pressure of dozens and dozens of your eggs.");

	output("\n\nFinally, after a few minutes that feel like a blissful eternity, you feel empty.  You let your slave know that you are going to pull out, and that if she lets a single egg out of her stretched-out pussy, you will sew it shut for her.  Your spent ovipositor slides from her packed cunt, accompanied by a gush of lube.  While Ceraph's sex gapes lewdly at you, you are proud to see she manages to keep all your eggs inside her.  You pat the slut's sensitive cunny, sending her into gasping spasms.");

	output("\n\nHumming a happy tune to yourself as you walk around Ceraph's twitching form, you grab a handful of her hair and pull her up off the ground.  Her face is crusted with dirt and her sparkling, gem-like eyes stare senselessly at you.  You rub your ovipositor over her head, carefully wiping your mingled lubes off on her hair before retracting the organ back into its holding sleeve.  \"<i>That will be all,</i>\" you tell her, and she smiles dreamily at you.  You turn around to gather your things, and don't bother to look back.");
	processTime(20 + rand(10));
	pc.dumpEggs();
	pc.orgasm();
	addNextButton();
}


//Ceraph Pegging + Bonus Petplay!
//Adds "Submission" option to the roleplay menu.
private function sumissivenessToCeraphFollower():void
{
	clearOutput();
	//spriteSelect(87);
	output("When you broach the idea of submitting to your fetish queen, delight washes across Ceraph's face.  Before another word can be spoken, she lashes out with her whip (where did she get that from?) and catches you around the neck with the taut leather, yanking hard enough to drag you to the ground and make you sputter for air.  The shining leather slides off as soon as your hands hit the ground, but the demoness is already standing above you, pushing on you with her stiletto-like heels to roll you aside.");
	output("\n\n\"<i>That's a better place for a useless little " + pc.mf("boy", "girl") + " like you, down in the dirt where you belong,</i>\" the demoness declares, pacing back and forth.  She crouches next to you and whispers in your ear, \"<i>The safe word is 'apple', you pitiful pig.</i>\"");
	output("\n\nYou nod meekly, awed by the demonic dominatrix's imposing, self-assured aura of command.");
	output("\n\n\"<i>Bend over, slut,</i>\" Ceraph commands.");
	output("\n\nYou start to stand up, but Ceraph again lashes out with her whip, striking you across the back four or five times.  It's hard to keep count through the pain.  Stinging welts rise on your " + pc.skin() + ", and a heady thrill runs through your groin.  You're totally stiff by the time she finishes the punishment, and it's plainly visible to the cruel hermaphrodite above.");

	output("\n\nScowling down at you, Ceraph commands, \"<i>Pets don't get to sit up - they roll over in the mud and crawl on your hands and knees like the beasts they are.  Remember that, [pc.name].  You aren't a person.</i>\"  Her whip lightly smacks your hip.  \"<i>You're a pet.</i>\"  SMACK!  \"<i>A slave.</i>\"  CRACK!  \"<i>Property.</i>\"  SNAP!");
	output("\n\nYou mewl pathetically under the blows but do your best to present yourself as ordered, rolling over and climbing up, [pc.gear] covered in grime.  Worse still, your excitement is showing in more ways than one");
	if (pc.isHerm()) {
		output(", both in the hardness of your manhood");
		if (pc.cockTotal() > 1) output("s");
		output(" and the moisture leaking from under your equipment");
	}
	else if (pc.hasVagina()) output(", what with the beads of moisture forming between your [pc.legs]");
	else output(".  Your hardness is easily visible to anyone who knows where to look, and the demoness definitely knows where to look");
	output(".");

	output("\n\nCeraph smirks and asks, \"<i>Does my subby slut like it when I play rough?  Or did you just get hard when you realized how right I am?  There's no shame in enjoying your station, pet.  After all, animals are there to please their owners.</i>\"  She strokes your " + pc.hairDescript() + " with an unfamiliar gentleness.  It's like a pleasant balm after the rough whipping, and you find yourself leaning into it, accepting the demeaning affection just to feel something that doesn't hurt.");

	output("\n\n\"<i>Good " + pc.mf("boy", "girl") + ",</i>\" the purple-skinned dom coos as she begins to undress you, keeping you on the ground the whole time.  \"<i>Let's get you out of these pesky clothes.  Good pets are naked, and I can see how <b>hard</b> you're trying to be a good pet.</i>\"  Her hand dances across ");
	if (pc.hasCock()) output("[pc.oneCock]");
	else output("your rigid clit");
	output(" with ticklishly-soft touches");
	if (pc.balls > 0) output(" before gently squeezing your [pc.sack]");
	output(", savoring your state.  You groan out loud at the sudden sensation, and a bead of ");
	if (pc.hasCock()) output("pre-cum has begun to form on your [pc.cockHead " + pc.biggestCockIndex() + "]");
	else output("girl-cum has begun to form at your quivering entrance");
	output(".  The crystal-clear droplet of congealed lust slowly begins to dangle down, connected for a few seconds by a string of moisture before it snaps and disappears into the dirt.");

	output("\n\n\"Oh, pet is dripping?</i>\" Ceraph wonders aloud as she stands and pivots, immediately taking a seat on your back.  \"<i>Perhaps pet is feeling a little pent up.</i>\"  She loops the whip around your neck and tugs slightly, enough to make you realize that she could control your breathing right now, if she wanted to.  The damnable magic of that whip has your blood boiling, and the erotic tingle of the treated leather against your " + pc.skinFurScales() + " doesn't help.  Another drop falls, and you start to answer, \"<i>Yes...</i>\"");
	output("\n\nThe word is choked off as soon as its started.  Ceraph lectures, \"<i>Pet, that isn't how you speak!  If you're going to be more than a useless submissive, you need to learn how to communicate.  Now, if you want me to ease that pressure, you can mewl like a cat or bark like a dog once for yes.  Do it twice for no, and we can go for a walk.</i>\"  The crushing pressure around your windpipe is relaxed, and you are given a chance to respond.");
	if (pc.hasCock()) output("\n\n(Agreeing could result in some humiliating milking...)");
	else output("\n\n(Agreeing could result in some humiliating pegging...)");
	//+50 lust, affected by resistance
	//dynStats("lus", 50);
	pc.lust(50);
	clearMenu();
	//[Mewl once] [Bark once] [Either twice][Apple]
	addButton(0, "Mewl Once", barkToCeraphOnce, false);
	addButton(1, "Bark Once", barkToCeraphOnce, true);
	addButton(2, "Meow Twice", barkOrMeowTwiceToCeraph, false);
	addButton(3, "Bark Twice", barkOrMeowTwiceToCeraph, true);
	addButton(4, "Apple", sayAppleToCeraph);

}

//[Apple]
private function sayAppleToCeraph():void
{
	clearOutput();
	//spriteSelect(87);
	output("Fuck this!  \"<i>Apple!</i>\"");
	output("\n\nCeraph gets up with a shocked expression painted on her violet features.  \"<i>Didn't you have any fun?</i>\" she asks.  \"<i>We were just about to the good part!</i>\"");
	output("\n\nYou tell her that it wasn't fun in the slightest, and you want out.");
	output("\n\n\"<i>Well, okay then... [pc.Master]...</i>\" she grumbles.");
	addNextButton();
}

//[Either Once]
private function barkToCeraphOnce(dog:Boolean = true):void
{
	clearOutput();
	//spriteSelect(87);
	output("\"<i>");
	if (dog) output("Arf!</i>\" you bark");
	else output("Meowwwww!</i>\" you mew");
	output(", loud and almost proudly");
	if (pc.hasTail()) output(", wagging your [pc.tail] excitedly");
	output(".");
	output("\n\nCeraph casually pulls her panties a bit lower to ");
	if (int(flags["COC.CERAPH_HIDING_DICK"]) == 0) output("ease the pressure on her tightly-contained phallus");
	else output("allow a penis to grow, fully-formed from where her clit was");
	output(".  The stalk of her cock drips with the swampy cunt-lubricant her delta exudes, and she pumps it a few times to make it stand long and erect, nine inches of pulsating, demonic horror.  Tiny nodules decorate the shaft in concentric rings to stimulated anyone lucky enough to experience her cock.  As Ceraph eyes your backside, you realize that you're going to be feeling it before long.");

	output("\n\n\"<i>");
	if (dog) output("ARF!  ARF!");
	else output("REOOOOW!");
	output("</i>\" you ");
	if (dog) output("bark");
	else output("meow");
	output(" in distress, trying to crawl away.  You didn't mean to get ");
	if (pc.hasCock()) output("milked ");
	else output("fucked ");
	output("like... like that!  Her whip snaps taut before dragging you back.  You scrabble in the dirt for a half-second, choking yourself before you give up and sag limply down at her feet.  Slowly, you lift your [pc.butt] up into the air to allow Ceraph access, regretfully yielding to her like you should have initially.");

	output("\n\nSWAT!  Her hand claps against a cheek, lingering to squeeze the raw flesh after the spank.  She explains, \"<i>That was for resisting, and this...</i>\"  You feel a slick, wet warmth at your tender, rear opening.  \"<i>...is for being my obedient, playful little ");
	if (dog) output("doggie");
	else output("kitty-cat");
	output(".</i>\"  Her hips press the hot spear harder against your [pc.asshole].  ");
	if (pc.analVirgin) {
		output("Even though you're a virgin, the cunt-slick tool worms its way into your rectum with ease, the nodules massaging your sorely-stretched anal ring as it accommodates to handle the bigger width, forever ruined by Ceraph's boner.");
	}
	else if (pc.analCapacity() < cockVolume(20)) output("Even though you're pretty tight, the cunt-slick tool slides into your rectum with ease, the semi-soft nodules massaging your anal ring as it adjusts to the heated impalement.");
	else if (pc.ass.looseness() >= 4) output("The cunt-slick tool has no problem wiggling inside your well-used and abused asshole, hilted in a split second, the hundreds of nubs gently caressing your anal ring like a lover as they nestle inside you.");
	else output("The cunt-slick tool slides right on in thanks to your capacitative anus, the gentle nubs each massaging your snug ring as they slide on through.");
	output("  You groan as you're taken by your owner, catching yourself halfway and arresting the pleasured grunt as soon as you can, but it doesn't matter - the damage is already done.");
	pc.buttChange(cockVolume(16), true, true, false);

	output("\n\nThere's a ring of larger bumps, just around the edges of Ceraph's glans, and they catch on something inside you as she grinds through your butthole, sending heat-spikes of inadvertent pleasure through ");
	if (pc.hasCock()) output("your twitching maleness");
	else if (pc.hasVagina()) output("to your achingly empty pussy");
	if (pc.cockTotal() > 1) output("es");

	output(".  Almost immediately, you squirt out a huge dollop of ");
	if (pc.hasCock()) output("pre-cum");
	else output("lady spunk");
	output(".  It dangles heavily enough to ");
	if (pc.hasCock()) output("make your [pc.cock " + pc.biggestCockIndex() + "] bob below");
	else output("tantalize and tease your clit");
	output(", and you give up another grunt of pleasure while your hips press harder against your owner's.");

	output("\n\nCeraph's hands fall on either side of your waist.  She reassures, \"<i>I treat my pets well, [pc.name].</i>\"  Her hips pull out, the nubby, textured tool bouncing and grinding all along your insides as she continues.  \"<i>I make them happy to be pets...</i>\"  That thick, demonic dick pushes back in a little harder, pushing your arms down so that your face is pressed into the dirt.  \"<i>...Happy to be owned, because obedience IS pleasure.</i>\"  Ceraph adjusts the angle so the blunted tip of her erection ");
	if (pc.hasCock()) output("rams straight into your inner, cock-milk reserve");
	else output("rubs against your quivering vaginal walls, stimulating you from the inside out");
	output(", and fireworks start to go off inside your brain.");

	output("\n\n");
	if (pc.hasCock()) output("Dick-milk");
	else output("Love-juice");
	output(" drizzles from ");
	if (pc.hasCock()) output("[pc.eachCock]");
	else output("your slightly parted twat");
	output(" into a pool on the floor as you're expertly brought to a tingly, body-quivering, anal orgasm.  It can barely be called an ejaculation, really.  The ");
	if (pc.hasVagina() && !pc.hasCock()) output("fem-");
	output("cum is just ");
	if (pc.hasCock()) output("sliding");
	else output("pouring");
	output(" smoothly out of it as your ");
	if (pc.hasCock()) output("inner reservoir is squeezed");
	else output("cunt walls are stimulated through your anal walls");
	output(".  Ceraph continues to push, but her dicktip slips off its mark, and she quickly buries herself back inside, each nodule responsible for small blurts of jism as they slip across your orgasmically tightening ");
	if (pc.hasCock()) output("prostate");
	else output("walls");
	output(".  ");
	if (pc.hasCock()) output("Ironically, [pc.eachCock] has begun to lose some of its stiffness, and you grow limper and limper as more of your cum leaks from you");
	else output("Strangely, the more femcum that leaks from your winking, tender twat, the more your body tingles and shivers with barely-constrained delight");
	output(".");

	output("\n\nMost amazingly of all, though ");
	if (pc.hasCock()) output("the 'pressure'");
	else output("a need within you");
	output(" feels released, you're still horny");
	if (pc.hasCock()) {
		if (pc.cockTotal() == 1) output(", even with a soft cock");
		else output(", even with soft cocks");
	}
	output(".  Ceraph purrs, \"<i>I told you that I was a good owner, didn't I?  Now just lie there and enjoy myself on your sensitive tush.</i>\"");

	output("\n\nShe rapidly begins to pump her penis through your sphincter, battering your [pc.asshole] with firm but gentle thrusts.  You ");
	if (dog) output("bark in pleasure like the cum-slut doggy that you are");
	else output("mewl in delight like the cock-loving kitty that you are");
	output(" and start to push back against her before long.  Those nodules rub your insides so well, and they keep you dripping wasted ");
	if (pc.hasCock()) output("semen");
	else output("juices");
	output(" from your ");
	if (pc.hasCock()) {
		output("limp cock");
		if (pc.cockTotal() > 1) output("s");
	}
	else output("snatch");
	output(" the entire time, tingling in ecstatic pleasure.  Soon, you're panting hard while Ceraph's hips slap off your [pc.butt] hard enough to sound like miniature thunderclaps, and your poor ");
	if (pc.hasCock()) output("prostate is getting pushed up against each time");
	else output(", depressingly empty cunt walls are getting teased with every thrust");
	output(".");

	output("\n\nCeraph moans out loud and suddenly rams herself into you brutally hard, hard enough to make you feel like your guts are being smushed into each other and your ");
	if (pc.hasCock()) output("prostate is");
	else output("vaginal walls are");
	output(" being smashed flat.  Warmth explodes inside your intestines, slowly spreading out around the flaring, demonically enhanced dick as it orgasms.  You can hear your owner's lady-spunk splattering into the ground behind you as she whimpers, \"<i>G-g-good... " + pc.mf("boy", "girl") + "...</i>\", her dick firmly spraying its thick, tainted milk ");
	if (pc.hasCock()) output("straight onto your sore prostate");
	else output("putting more delicious pressure on your sensitive walls");
	output(".  You scrunch your eyes closed as Ceraph claims your ass for her own, and ");
	if (pc.hasCock()) {
		if (pc.cockTotal() > 1) output("each of your cocks");
		else output("your cock");
		output(" lets go the very last of your sticky, stinky, pet-cum");
	}
	else output("your pussy lets go of the last of its sticky, slippery snatch secretions");
	output(".");
	if (pc.cumQ() >= 700) output("  It floods out everywhere.  You're just so productive that your hands and [pc.legs] sink partway into the mess.");

	output("\n\nYour Mistress eventually finishes and pulls out, offering a ");
	if (dog) output("tasty bone-shaped biscuit");
	else output("fishy-smelling treat");
	output(" for you to gobble down, and she pats you on the head as you gratefully accept your reward.");
	output("\n\n\"<i>Good, " + pc.mf("boy", "girl") + ".</i>\" her voice says, slowly fading into the wind.");
	//Increase corruption, reset lust, increase sensitivity.
	//pc.slimeFeed();
	processTime(25 + rand(10));
	pc.orgasm();
	pc.cor(1);
	//dynStats("sen", 2, "cor", 1);
	addNextButton();
}

//[Either Twice]
private function barkOrMeowTwiceToCeraph(dog:Boolean = true):void
{
	clearOutput();
	//spriteSelect(87);
	output("\"<i>");
	if (dog) output("Arf! Arf!</i>\" you bark");
	else output("Meow!  Meowwwww!</i>\" you mew");
	output(", wiggling your ");
	if (pc.hasTail()) output("[pc.tail]");
	else output("[pc.butt]");
	output(" happily.  For some reason, the idea of denying yourself release in exchange for more humiliation is appealing to you.");

	output("\n\nGently tying the end of her whip around your neck into an improvised collar, Ceraph smoothly strokes your back, praising you again, \"<i>Such a good pet.  Let's go for that walkie, and let all your friends see just how good you can be.</i>\"  There's a gentle tug on your new collar, and you crawl along after your slave-turned-mistress, ");
	if (dog) output("whining");
	else output("mewling");
	output(" like a needy animal.");

	var choices:Array = [];
	//Choose one of the following at random
	if (flags["COC.FUCK_FLOWER_LEVEL"] >= 4 && int(flags["COC.FUCK_FLOWER_KILLED"]) == 0)
		choices[choices.length] = 0;
	if (amilyFollower() && amilyCorrupt())
		choices[choices.length] = 1;
	else if (campCorruptJojo())
		choices[choices.length] = 1;
	choices[choices.length] = 2;

	var select:int = choices[rand(choices.length)];

	//HOLLI
	if (select == 0) {
		//{Normal Holli}
		if (int(flags["COC.HOLLI_SUBMISSIVE"]) == 0) {
			output("\n\nThe corrupted dryad peeps out of her tree when Ceraph leads you by.  \"<i>Oh, this is just too rich!  Are you a little ");
			if (dog) output("doggie");
			else output("kitty-cat");
			output(" now?  Why the hell did Mother Marae send me out to thank someone like you?  It's pathetic!</i>\"  Lowering out of her canopy, an array of cock-like tentacles homes in on you while Ceraph watches, bemused.  They start to pat your head, pushing down a little harder than necessary and rubbing down your back like condescending hands.  She's laughing and petting you, thrilled to have you in such a position.  The shame is more potent than a minotaur's spunk, and when combined with the magic of your demonic 'collar', it twists in your head, twining inexorably with arousal to make you leak even harder.  It feels soooo good to wallow in the piteous, condescending touches.");
		}
		//{Intimidated Holli}
		else {
			output("\n\nThe corrupted dryad peeps out of her tree when Ceraph leads you by.  \"<i>[pc.name]?  What... what are you doing?  Oh my god!  Are you some kind of secret submissive?</i>\"  Holli giggles cruelly, \"<i>You're a fucking submissive slut!  I should've known that tough act was all bluster!  Damn, you really SHOULD be begging me just to let me fuck you.  What do you have to say for yourself?</i>\"");
			output("\n\nCeraph smiles but looks down at you, motioning towards you expectantly.");
			output("\n\n\"<i>");
			if (dog) output("Arf!?");
			else output("Meow!?");
			output("</i>\"");
			output("\n\nHolli roughly slaps the back of your head with a tentacle in a crude approximation of petting.  \"<i>That's a good ");
			if (dog) output("doggie");
			else output("kitty");
			output(",</i>\" she says, thrilled to see you so debased and no longer concerned with obeying you.  The shame is more potent than a minotaur's spunk, and when combined with the magic of your demonic 'collar', it twists in your head, twining inexorably with arousal to make you leak even harder.  It feels soooo good to wallow in the piteous, condescending touches.");
			flags["COC.HOLLI_SUBMISSIVE"] = 0;
		}
		//Either Holli ending:
		output("\n\nCeraph and you continue your walk, though she has to scold you a number of times for dripping on her heels.  Whenever you misbehave, she flicks ");
		if (pc.hasCock()) {
			if (pc.cockTotal() > 1) output("one of ");
			output("your rebellious boner");
			if (pc.cockTotal() > 1) output("s");
			output(", which has the unintended side-effect of making it puff up even harder");
		}
		else output("your rebellious clitoris, which has the unintended side-effect of making it and your drooling cuntlips puff up, redder than ever before");
		output(".  ");
		if (pc.hasCock()) output("It bounces against your tummy");
		else output("Your vaginal muscles clench and contract");
		output(" with unfilled need, but there's no sating it.  Only after all your muscles are sore and exhausted does Ceraph take you home.  You collapse onto your belly, panting while the whip is untied.  When you turn to talk to Ceraph, you find she's left you there, aroused beyond measure.");
	}
	//Corrupt Jojo or Amily
	else if (select == 1) {
		//Both
		if (amilyFollower() && amilyCorrupt() && campCorruptJojo()) {
			//Both Corrupt Jojo & Amily
			output("\n\nBefore long, you come across both of your corrupt, mouse-like slaves.  They stop fondling each other's genitals long enough to ask, \"<i>[pc.Master], what are you doing?</i>\"");
			output("\n\nCeraph looks down at you with her hand tight on your leash.");
			output("\n\n\"<i>");
			if (dog) output("Arf!");
			else output("Meow!");
			output("</i>\"");
			output("\n\n\"<i>[pc.Master] is Ceraph's pet?  Then... then, we're her pets too...</i>\" Amily says as the spokeswoman for the group.  They both proceed to drop down on all fours and crawl up alongside you.  Ceraph nonchalantly tears off strips of Amily's clothing and fixes them into a pair of improvised collars, connected to her whip with simple knots.  The four of you then continue the walk together, though you're scolded again and again when you let the mice rub up against you sensually.  Having sister and brother pets is somewhat comforting, but being constantly exposed to their sexual scent is more than distracting.  Ceraph squirts the two of you with water a half-dozen times to keep you from fucking, and each time the shame is greater.  You really are a pet, one that can't even keep " + pc.mf("his", "her") + " most basic needs in check.");
		}
		else {
			var jojo:Boolean = campCorruptJojo();
			output("Before long, your corrupt, mouse-like slave sees you awkwardly clambering after the purple-hued dominatrix.  ");
			if (jojo) output("He");
			else output("She");
			output(" asks, \"<i>[pc.Master], what are you doing?</i>\"");
			output("\n\nCeraph looks down at you with her hand tight on your leash.");

			output("\n\n\"<i>");
			if (dog) output("Arf!");
			else output("Meow!");
			output("</i>\"");

			output("\n\n\"<i>[pc.Master] is Ceraph's pet?  Then ");
			if (!jojo) output("cum-slut is");
			else output("I guess I'm");
			output(" her pet too...</i>\" ");
			if (!jojo) output("Amily");
			else output("Jojo");
			output(" says, dropping to all fours and crawling up alongside you.  Ceraph tears a strip of their clothing off nonchalantly and fixes it into another improvised collar that she ties on to her whip.  The three of you then continue the walk, though you're scolded again and again when you and ");
			if (!jojo) output("Amily");
			else output("Jojo");
			output(" rub up against each other.  Having a ");
			if (!jojo) output("sister");
			else output("brother");
			output("-pet is somewhat comforting, but being constantly exposed to ");
			if (jojo) output("his");
			else output("her");
			output(" sexual scent is more than distracting.  Ceraph squirts the two of you with water a half-dozen times to keep you from fucking, and each time the shame is greater.  You really are a pet, one that can't even keep " + pc.mf("his", "her") + " most basic needs in check.");
		}
		//Mice finisher
		output("\n\nYou go for an exhausting walk around the nearby wasteland with your companion");
		if (amilyFollower() && amilyCorrupt() && campCorruptJojo()) output("s");
		output(", and you thoroughly enjoy the degrading experience.  Lust and humiliation are all jumbled up inside you into one big mass of sex, such that getting turned on from this humiliates you, and being humiliated gets you even more aroused");
		output(".  It's an endless feedback loop of sexual excitement that has you about to blow, except you're back in camp.  The collar is untied, and your owner's sweet voice whispers, \"<i>Good walk, pet.</i>\" before vanishing into the wind.");

		output("\n\n");
		if (campCorruptJojo()) {
			output("Jojo");
			if (amilyFollower() && amilyCorrupt()) output(" and ");
		}
		if (amilyFollower() && amilyCorrupt()) output("Amily");
		if (amilyFollower() && amilyCorrupt() && campCorruptJojo()) output("look around uncertainly before darting back to their usual places, knowing you'll give the command if you want them to take care of your desires.");
		else output("looks around uncertainly before darting back to the usual places, knowing you'll give the command if you want a slave to take care of your desires.");
	}
	//Generic
	else {
		output("\n\nCeraph leads you out into the wasteland on an exhausting, humiliating journey.  Somehow, she keeps finding imps and goblins to show you off to.  The ");
		if (pc.hasCock()) output("goblins");
		else output("imps");
		output(" seem intrigued by the sight of your compulsively ");
		if (pc.hasCock()) output("erect maleness");
		else output("quivering quim");
		if (pc.cockTotal() > 1) output("es");
		output(", and often offer Ceraph a bounty of gems to fuck you.  Your mistress insists that you don't need any such sexual release, because you are a good ");
		if (dog) output("doggie");
		else output("kitty");
		output(" and get all you need out of obedience.  Her words draw an exaggerated whimper from your lips along with a few fresh drops of pearly ");
		if (pc.hasCock()) output("cock");
		else output("cunt");
		output("-cream, but you hold still, [pc.legs] quaking eagerly.  It feels like all it would take to get your release would be a few soft touches on your aching ");
		if (pc.hasCock()) output("cock");
		else output("nethers");
		if (pc.cockTotal() > 1) output("s");
		output(".");

		output("\n\nOne of the ");
		if (pc.hasCock()) output("goblins");
		else output("imps");
		output(" even notices your state and comments on it, holding ");
		if (pc.hasCock()) output("her");
		else output("his");
		output(" hand beneath your freely drooling ");
		if (pc.hasCock()) output("erection");
		else output("pussy");
		if (pc.cockTotal() > 1) output("s");
		output(" to collect a palmful of slippery ");
		if (pc.hasCock()) output("boy");
		else output("girl");
		output("-honey.  ");
		if (pc.hasCock()) output("She");
		else output("He");
		output(" holds it up in front of her nose and sniffs it, sighing, \"<i>" + pc.mf("He", "She") + " certainly does seem to be well tamed, miss demon.  You're lucky you caught " + pc.mf("him", "her") + " before I did.  With ");
		if (pc.hasCock()) output("cum this nice, I'd be milking " + pc.mf("him", "her") + " dry every time " + pc.mf("he", "she") + " could get it up");
		else output("a scent like this, I'd be fucking " + pc.mf("him", "her") + " every chance I could get");
		output(".  Maybe you'll change your mind sometime.</i>\"");

		output("\n\nCeraph shakes her head but smiles down at you, patting you on the head.  The humiliation of it all is twisting around with your lust, the two emotions so confused that you feel yourself getting harder from being treated like a house-pet.  A dollop of ");
		if (pc.hasCock()) output("pre-cum rockets");
		else output("fem-juice spurts");
		output(" onto the ground while you whine softly.  Your owner notices and commands, \"<i>Now, pet, we can't have you making this ");
		if (pc.hasCock()) output("goblin");
		else output("imp");
		output("'s home a mess.  Lick it up.</i>\"");
		output("\n\nYou bend down and lick up your sexual leavings, tasting the dirt below until there's a mess of spit and cum mud where your ");
		if (pc.hasCock()) output("pre-ejaculate");
		else output("lady jizz");
		output(" landed.  \"<i>Good enough.  Come on, ");
		if (dog) output("doggy");
		else output("cat");
		output(", let's finish our walk!</i>\"");

		output("\n\nCeraph drags at your collar, picking up the pace as she takes you home.  Each movement is torturous, as your dangerously excited ");
		if (pc.hasCock()) output("boner");
		else output("twat");
		if (pc.cockTotal() > 1) output("s");
		if (pc.cockTotal() > 1) output(" feel like they");
		else output(" feels like it");
		output(" could go off at any second.  The journey is murder for your poor, ");
		if (pc.hasCock()) output("over-inflated maleness");
		else output("puffy, aching cleft");
		if (pc.totalCocks() > 1) output("es");
		output(", but you somehow make the whole way home without ");
		if (pc.hasCock()) output("popping");
		else output("tipping over the edge");
		output(".  The trail of musky slime that clearly marks your journey is another thing though.");

		output("\n\nClick.");
		output("\n\nYour collar is removed, and you look around realizing your owner is gone.  Your muscles are sore from the journey and you NEED to masturbate...  You aren't even sure why you did that.");
	}
	//dynStats("sen", 4, "lus=", 100, "resisted");
	processTime(25 + rand(10));
	pc.lust(pc.lustMax(), true);
	addNextButton();
}