import classes.Characters.CoC.CoCValeria;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//[pc.gear]:
public function takeGooArmor():void {
	clearOutput();
	output("You approach the armor rack.  A suit of heavy plated armor sits upon it, overlaying a flexible chain vest.  Contrasting against the rotting room, the armor seems to be in pristine condition, even shining.  Perhaps someone uses this heavy equipment - but surely not a harpy? You suppose you could take it.");
	//(Display Options: [Take Armor] [Back])
	clearMenu();
	addButton(0, "Take Armor", takeGooArmor4Realz, undefined, "Take Armor", "Take the armor for sure. It can come in handy." + (pc.intelligence() >= 40 || pc.aim() >= 40 || pc.isPsionic() ? " You have a feeling that there might be something living inside the armor." : ""));
	addButton(14, "Back", mainGameMenu);
	//(Back takes you back to Room 1 menu)
}

//[pc.gear] -> [Take]:
public function takeGooArmor4Realz():void {
	clearOutput();
	//spriteSelect(79);
	output("You reach out to grab the armor, but as soon as your finger brushes the shiny surface, a human-like face appears in the helm!  You recoil as a daintily feminine and bright blue face takes shape out of nowhere, staring at you with eyes afire with rage.  More of the gooey substance that makes up the girl's face fills out the armor, yanking it off the racks on feet made of goop.");
	output("\n\nQuietly, the armored goo-girl growls, \"<i>You dare to disturb my rest, mortal? Prepare yourself for my vengeance!</i>\"");
	output("\n\nWhat the fuck!? Oh well, looks like she wants a fight!");
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCValeria());
	CombatManager.victoryScene(beatUpGooArmor);
	CombatManager.lossScene(gooArmorBeatsUpPC);
	CombatManager.displayLocation("GOO ARMOR");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//Goo Armor -- PC Defeated (PC has Gender)
public function gooArmorBeatsUpPC():void {
	//spriteSelect(79);
	output("\n\nYou collapse, unable to resist the goo-armor's onslaught.  Laughing, she slithers out from underneath her armor, completely encasing you before you can do anything more than scream.  Laughing maniacally, the goo looms over you, hands on her hips.  \"<i>Tsk, tsk, tsk.  Not so eager to steal my armor now, are you?  Well... what am I to do with you, hmm?</i>\"  You struggle, but wrapped snugly in her goo, you can do little more than wiggle your hips and chest, accidentally moving yourself seductively.");
	output("\n\nAs you realize your mistake, a little smile spreads on her face.  \"<i>Ah, I know... I haven't had my precious fluids in so very long...</i>\"");
	//(PC has Vagina)
	if (pc.hasVagina() && !pc.hasCock()) {
		output("\n\nShe begins to use her goo to peel back your [pc.gear], soon revealing your defenseless [pc.vagina], and makes a show of licking her lips as tendrils of goo seep into your cunt, filling you utterly.  You writhe and struggle against your gooey bonds, but your efforts are futile.  The goo-girl inside the armor only shakes her head at you, and withdraws herself from your [pc.vagina].");
		output("\n\nYou have only a moment to figure out what's coming before her goo -- now perfectly shaped like the inside of your cunt -- slams back into you like a stiff cock. You can't help yourself as a moan escapes your lips, barely audible through the goop covering your mouth."); 
		output("\n\n\"<i>Oh, you like that do you?</i>\" the armor-goo asks, smiling evilly.  \"<i>Well, maybe this can be mutually... beneficial.</i>\"  Still grinning, she begins to hammer her cock-like appendage into your pussy, fucking you fast and hard with her goo-dildo.");
		pc.cuntChange(0, 39, true, true, false);
		//[If PC has breasts > A-cups: 
		if (pc.biggestTitSize() >= 1) {
			output("  As she hammers your cunny, bits of her goo swirl around your [pc.chest], squeezing and massaging your tits.  You squirm as she roughly teases your boobs, pinching at your nipples and squeezing your tender flesh roughly.");
			//[if PC is lactating: \"<i>
			if (pc.isLactating()) output("  To her delight, a spray of warm [pc.milkNoun] jets out of your sore nipples, [pc.milkColor] mixing into blue goo like oil in water. \"<i>Mmm, tasty!</i>\" she teases, massaging more and more from you.</i>\"");
		}
		output("\n\nShe continues to pound your cunt mercilessly, her grin spreading to inhuman width as your juices begin to flow around and into her gooey penetration.  She soaks your fem-lube up greedily, enjoying the meal, but her fucking is relentless until you feel orgasm approaching.  \"<i>Aw, ");
		//[if height is less than 6': 
		if (pc.tallness < 70) output("little");
		else output("big");
		output(" girl ready to cum?  Well, go on then. Feed me!</i>\"");

		output("\n\nYou erupt, femspunk gushing out of your [pc.vagina] and into the goo-cock.  Laughing, the goo-girl absorbs your cum, growing larger and larger as you feed her, until she towers over you, her massive cock now wide enough to painfully stretch your walls.  \"<i>Oh, that's good.  Good, girl, good.  Yes, let it all out, just like that... just like that,</i>\" she coos, soaking your juices up until your orgasm finally passes.  Sated, she withdraws from inside you, leaving a decidedly empty feeling in your gut as she allows you to stand."); 

		output("\n\n\"<i>Mmm, that was fun,</i>\" the goo-girl says, patting her full belly.  You can see a bit of your cum ");
		if (pc.biggestTitSize() >= 1 && pc.isLactating()) output("and milk ");
		output("swirling around inside her.  \"<i>Well, I suppose since you fed me so well, I'll let you go.  This time! See you around, tasty!</i>\"");

		output("\n\nBefore you can recover enough to say a word, the goo-girl saunters off out the door.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//(PC has Dick)
	else if (pc.hasCock()) {
		output("She begins to use her goo to peel back your armor, soon revealing your defenseless, half-erect [pc.cocksLight].  She makes a show of licking her lips as tendrils of goo wrap tightly around [pc.eachCock] like a warm, wet onahole. You writhe and struggle against your gooey bonds, but your efforts are futile.  The goo-girl inside the armor only shakes her head at you, and squeezes [pc.eachCock] tighter.");
		output("\n\nYou gasp with pleasure as she starts to stroke your [pc.cocksLight], jerking you off as she looms over you, grinning wickedly.  \"<i>Oh, you like that do you?</i>\" the armor-goo asks.  \"<i>Well, maybe this can be mutually... beneficial.</i>\"  She starts to increase her tempo, making you squirm and writhe as she wanks your [pc.multiCocks], licking her lips as little bubbles of pre-cum form.  Helpless, you can only submit and try to enjoy yourself as the armored goo-girl continues to milk you.");
		output("\n\nShe continues to jerk you off mercilessly, her grin spreading to inhuman width as your pre begins to flow around and into her gooey 'hands'.  She soaks you up greedily, enjoying the meal, but her fucking is relentless until you feel orgasm approaching.  \"<i>Aw, ");
		if (pc.tallness < 70) output("little");
		else output("big");
		output(" " + pc.mf("boy","girl") + " ready to cum? Well, go on then. Feed me!</i>\"");
		
		output("\n\nYou climax, ropes of thick, white jizz shooting out of [pc.eachCock] and into the goo's waiting body.  Laughing, the goo-girl absorbs your cum, growing larger and larger as you feed her until she towers over you, her expanding breasts and belly now hanging over you. \"<i>Oh, that's good. Good, " + pc.mf("boy","girl") + ", good.  Yes, let it all out, just like that... Just like that,</i>\" she coos, soaking your cum up until your orgasm finally passes.  Sated, she withdraws from around you, leaving your [pc.cocksLight] decidedly empty and sore.");

		output("\n\n\"<i>Mmm, that was fun,</i>\" the goo-girl says, patting her full belly.  You can see a bit of your cum swirling around inside her.  \"<i>Well, I suppose since you fed me so well, I'll let you go.  This time!  See you around, tasty!</i>\"");
		
		output("\n\nBefore you can recover enough to say a word, the goo-girl saunters off out the door.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//Genderless
	else {
		output("You collapse, unable to resist the goo-armor's onslaught.  Laughing, goo slithers out from the bottom of her armor, completely encasing you before you can do anything more than scream.  Laughing maniacally, the goo looms over you, hands on her hips.  \"<i>Tsk, tsk, tsk.  Not so eager to steal my armor now, are you?  Well... what am I to do with you, hmm?</i>\"  You struggle, but wrapped snugly in her goo, you can do little more than wiggle your hips and chest, accidentally moving yourself seductively.");

		output("\n\nAs you realize your mistake, a little smile spreads on your face.  \"<i>Ah, I know... I haven't had my precious fluids in so very long...</i>\" She begins to use her goo to peel back your armor, but stops with a look of horror as she reveals you bare, empty crotch.");

		output("\n\n\"<i>What. Just... WHAT. How do you... " + pc.mf("Dude", "Babe") + ", how do you PEE!?</i>\"");

		output("\n\nYou struggle weakly, unable to respond.");

		output("\n\n\"<i>Oh... fuck it. Just... whatever. Go away, you freak.</i>\"");

		output("\n\nThe goo-girl shrugs and saunters out the front door.");
		
		output("\n\nSore, you pick yourself up off the floor and wipe a bit of gooey residue off your gear.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//(PC regains HP)
	flags["COC.LOST_GOO_ARMOR_FIGHT"] = 1;
	processTime(25);
	pc.HP(pc.maxHP());
	pc.orgasm();
	pc.slowStatGain("l", 1);
	
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//Goo Armor -- PC is Victorious (Intro)
public function beatUpGooArmor():void {
	//spriteSelect(79);
	clearOutput();
	output("Succumbing to your ");
	if (enemy.lustQ() >= 100) output("erotic abilities");
	else output("skill in battle");
	output(", the armored goo slumps backwards against the wall, unable to stand.  You loom over her, grinning as you contemplate what to do with your helpless opponent.");

	output("\n\n\"<i>Hey... hey wait!</i>\" the goo gasps, waving a hand emphatically to ward you off.  \"<i>It... it doesn't have to be like this.  I think... Hey, yeah, I think we can come to an understanding.  You're a reasonable sort, right? No need to get violent...</i>\"");

	output("\n\nYou scowl at the armor-goo, but allow her to speak.");

	output("\n\n\"<i>Eheh. Uh, I was only playing, see? Just hungry, is all.  Don't get many folks up hereabouts, except the damn harpies, who don't bother me much.  Uh, so, what do you say we cut a deal, huh?</i>\"  You raise an eyebrow at her.  \"<i>You just kicked my ass royally.  That's damn impressive, considering I used to be pretty hot stuff with a sword back in the day.  Now that I'm, uh, less solid than I was... Well, I'm just not cut out to be an adventurer on my own anymore.  You proved that all right.</i>\"");

	output("\n\n\"<i>So what do you say... I come with you? Hmm? How about it?  You can fit right inside me and this old lug,</i>\" she raps her gooey knuckles silently on her shiney breastplate.  She scowls; her fist's lack of solidity seems to perturb her greatly.  \"<i>Seriously, though.  You can wear me just like any other armor - damn good armor at that!  And, if you're feeling antsy on your - our - adventures, then maybe I can help you out with that, too?</i>\"");

	output("\n\nWell, that's certainly an interesting offer. Do you take the goo-girl armor with you?");
	//(Display Options: [Take Her] [Refuse Her])
	
	flags["COC.WON_GOO_ARMOR_FIGHT"] = 1;
	
	clearMenu();
	addOverrideItemButton(0, new CoCGooArmor(), "Take Her", takeGooArmorAndWearIt);
	addButton(1, "Refuse Her", refuseGooArmorOffer, undefined, "Refuse Her", "Refuse the goo armor offer. You don't want her after all! However, you might not be able to get her for some time.");
	addButton(2, "2Camp", refuseGooArmorOfferPolitely, undefined, "Invite To Camp", "Politely decline the goo armor offer. You don't want her for now.");
}

//[Refuse Her]
public function refuseGooArmorOffer():void {
	//spriteSelect(79);
	clearOutput();
	//In Tower of the Phoenix
	if (flags["COC.VALERIA_FOUND_IN_GLACIAL_RIFT"] == undefined) {
		output("You tell her to fuck off -- you don't need armor that might try to kill or rape you at night.");
		output("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, and fuck you anyway.  I hope you get raped by harpies, " + pc.mf("sir","madam") + ".</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... Well, we'll see if you live through this place without me!</i>\"  Before you can stop her, she ducks out the front door and off to... Wherever goo-armor-girl-things would go, you guess.  Still, to your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//In Glacial Rift
	else {
		output("You tell her to fuck off -- you don't need armor that might try to kill or rape you at night.");
		output("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, and fuck you anyway.  I hope you get raped by jotuns, " + pc.mf("sir", "madam") + ".</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... Well, I guess I’ll be around here!</i>\"  Before you can stop her, she huffs off to... wherever goo-armor-girl-things would go, you guess.  You make your way back to your camp.");
	}
	
	pc.HP(pc.maxHP());
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[Refuse Polite]
public function refuseGooArmorOfferPolitely():void {
	//spriteSelect(79);
	clearOutput();
	//In Tower of the Phoenix
	//if (flags["COC.VALERIA_FOUND_IN_GLACIAL_RIFT"] == undefined) {
		//output("You tell her that... no thanks, not now -- you don't need armor right now.");
		//output("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, maybe you can take me later, " + pc.mf("sir", "madam") + "?</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... Well, we'll see if you live through this place without me! But if you need me later, I'll be at Glacial Rift.</i>\"  Before you can stop her, she ducks out the front door and off to... Wherever goo-armor-girl-things would go, you guess.  Still, to your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	//}
	////The Glacial Rift
	//else {
		//output("You tell her that... no thanks, not now -- you don't need armor right now.");
		//output("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, maybe you can take me later, " + pc.mf("sir", "madam") + "?</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... You know where to find me, right?</i>\"  You give her a nod as you make your way back to your camp.");
	//}
	
	output("You tell her that... no thanks, not now -- you don't need armor right now.");
	output("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, maybe you can take me later, " + pc.mf("sir", "madam") + "?</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... Well, we'll see if you live through this place without me!</i>\"  Before you can stop her, she ducks out the front door.  Still, to your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	
	flags["COC.TOOK_GOO_ARMOR"] = 1;
	flags["COC.VALARIA_AT_CAMP"] = 1;
	
	pc.HP(pc.maxHP());
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//[Take Her]
public function takeGooArmorAndWearIt():void {
	//spriteSelect(79);
	clearOutput();
	
	
	//Set flags
	//flags["COC.VALERIA_FLUIDS"] = 80;
	flags["COC.TOOK_GOO_ARMOR"] = 1;
	flags["COC.VALARIA_AT_CAMP"] = 0;
	takeValeria();
	output("\n\nTo your surprise, you feel rather invigorated after the battle, thanks to Valeria's strange healing properties, and with a smirk, you turn your attention back to the adventures ahead.\n\n");
	
	//(PC regains HP)
	pc.maxOutHP();
	processTime(15 + rand(5));
	CombatManager.genericVictory();
	addButton(0, "Next", mainGameMenu);
}

//[Valeria]
public function talkToValeria():void {
	clearOutput();
	//spriteSelect(79);
	output("Now that you have a few moments to catch your breath, you ask your goo-armor what she thinks about the situation.");
	output("\n\n\"<i>Oh, hi,</i>\" she laughs.  She pours half-way out of your armor, forming her face a few inches from yours.  Kiri leaps in shock, wide-eyed as your armor becomes a new person before you.");
	output("\n\n\"<i>Well hey there, cutie,</i>\" Valeria says, giving Kiri a little wink.  The harpy shudders slightly and shakes the surprise off.");
	output("\n\nYou clear your throat and repeat your question.");
	//[If Broodmother hasn't been defeated]
	if (flags["COC.HEL_HARPY_QUEEN_DEFEATED"] == undefined) output("\n\n\"<i>Oh, right. Well, that harpy broodmother is serious business. She's a powerful mage, and a heavy-hitter besides.  Careful with her, or you're liable to end up drugged out of your mind and used as breeding stock 'till you die.  I've seen it happen to other adventurers coming through.</i>\"");
	//[If Jailer hasn't been defeated]
	if (flags["COC.HEL_BRIGID_DEFEATED"] == undefined) output("\n\n\"<i>Brigid the Jailer is a big girl, probably the meanest harpy here. The others give her plenty of space, from what I've seen.  She uses a hot poker as her weapon, too.  Watch out unless you wanna get burned!</i>\"");
	//[If phoenixes haven't been defeated]
	if (flags["COC.HEL_PHOENIXES_DEFEATED"] == undefined) output("\n\n\"<i>There's some freaky-ass half-breed harpy things upstairs that I've seen around a bit.  Phoenixes, I guess they're called.  They breathe fire, so watch your ass.  I can absorb some of the heat, but... Don't get roasted, okay?</i>\"");
	processTime(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}