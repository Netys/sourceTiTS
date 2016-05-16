import classes.Characters.CoC.CoCHellHoundInfested;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//[INTRO – 50% chance split with regular hellhound if worms
//turned on and over level 2]
public function infestedHellhoundEncounter():void
{
	userInterface.showName("INFESTED\nHELLHOUND");
	clearOutput();
	output("A low snarl vibrates through your body, ");
	if (pc.isGoo()) output("making your jello-like body jiggle");
	else output("rattling your teeth");
	output(".  Peeking fearfully over your shoulder, you see the black-furred form of a hell-hound emerging from behind a rock.  Its eyes narrow as its gaze locks onto your [pc.vagOrAss], a pair of black, shiny dog-cocks emerge underneath him, dangling freely.  His balls look bloated and distended, the skin around them crawling and wriggling.  A few worms drip from its over-sized peckers, crawling on the ground under the infested beast.\n\n");
	output("Somehow you know this thing isn't going to let you just walk away.");
	//if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
		//output("\n\n<b>New codex entry unlocked: Hellhounds!</b>")
	//}
	fightHellHoundInfested();
	//spriteSelect(27);
}

private function fightHellHoundInfested():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCHellHoundInfested());
	CombatManager.victoryScene(CoCHellHoundInfestedDefeated);
	CombatManager.lossScene(infestedHellhoundLossRape);
	CombatManager.displayLocation("HELLHOUND");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function CoCHellHoundInfestedDefeated():void
{
	clearOutput();
	if (enemy.HP() < 1) {
		output("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated, unconscious, and yet still drooling worms.");
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	} else {
		output("Unable to bear its unnatural arousal, the infested hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n");
		
		clearMenu();
		addDisabledButton(0, "Lick", "Get Licked", "Let it pleasure you orally.");
		
		if (pc.hasGenitals() && pc.lust() >= 33) {
			output("You realize your desires aren't quite sated.  You could let it please you.  Do you?\n\n");
			addButton(0, "Lick", hellHoundGetsRaped, undefined, "Get Licked", "Let it pleasure you orally.");
		}
		
		addButton(14, "Leave", function():*{
			output("You turn away, not really turned on enough to be interested in such an offer from such a beast.\n\n");
			processTime(10 + rand(10));
			mainGameMenu(); } );
	}
}

public function infestedHellhoundLossRape():void
{
	clearOutput();
	//[BOTH INFESTED]
	if (pc.hasCock() && pc.hasStatusEffect("Infested")) {
		//(LUST)
		if (pc.lustQ() >= 100) {
			output("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ");
			if (pc.cor() < 33) output("In spite of your revulsion ");
			else if (pc.cor() < 66) output("In spite of your better sense ");
			else output("With a perverse sense of anticipation ");
			output("you remove your [pc.gear] and roll onto your back, exposing your vulnerable groin to the beast.\n\n");
		}
		//(HP) 
		else output("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-sharp teeth easily sink into your [pc.gear] before tearing away the offending armor, exposing your [pc.asshole] and [pc.cocks].  A cold mountain breeze blows across your now-exposed [pc.skinFurScales], reminding you just how utterly vulnerable you are to the alien lusts of this symbiotic monstrosity. With a brutal lunge it knocks you off your " + pc.feet() + " and onto your back.\n\n");

		output("The beast takes a sniff at your groin, then backs away, looking confused.  You glance down and realize just how hard you've become.  A few of your worms are hanging from [pc.eachCockHead], starting to flow out in a steady stream.  It feels better than it has any right to.   A shadow falls across you as the hellhound moves over you, its imposing twin members hard and pulsating above you.  Hot splatters of jism drip onto your chest as the beast's worms begin escaping, forcing thick globules of dog-semen out along with them.\n\n");

		output("Overcome by the worms, both you and the beast begin orgasming, without external stimulation of any kind.  Worms and cum mix together on top of you, slowly building into a large mound that covers the better part of your torso.  Exhausted and drained, you both squirt weakly, emptying the last of your smallest worms into the pile.   Your eyes close as the beast lies down with you, and together the two of you lose consciousness as your newly birthed worm colony squirms away.");
		pc.orgasm();
		pc.slowStatGain("l", 1);
		pc.cor(1);
		//dynStats("lib", 1, "sen", 1, "cor", 1);
		pc.cumMultiplierRaw += 1;
		applyCumSoaked(pc);
		
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	//[PLAYER'S COCKS ARE BIG ENOUGH TO BE INFECTED]
	else if (!pc.hasStatusEffect("Infested") && pc.biggestCockVolume() >= cockVolume(40) && pc.hasCock()) {
		//(LUST)
		if (pc.lustQ() >= 100) {
			output("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ");
			if (pc.cor() < 33) output("In spite of your revulsion ");
			else if (pc.cor() < 66) output("In spite of your better sense ");
			else output("With a perverse sense of anticipation ");
			output("you remove your [pc.gear] and roll onto your back, exposing your vulnerable groin to the beast.\n\n");
		}
		//(HP)
		else {
			output("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your [pc.gear] before tearing it off, exposing your [pc.asshole] and [pc.cocks].  A cold mountain breeze blows across your now exposed [pc.skinFurScales], reminding you just how utterly vulnerable you are to the alien lusts of this symbiotic monstrosity.  With a brutal lunge it knocks you off your " + pc.feet() + " and onto your back.\n\n");
		}
		if (pc.totalCocks() > 1) {
			output("The infested hound repositions itself, blocking out the sun with its dark fur, leaving you with only the pale flames surrounding its fuzzy sack to look at.   The warm wetness of its smooth tongue starts sliding over [pc.eachCock].  It feels good, better than it has any right to.  ");
			output("Every single one of your [pc.cocks] hardens under the stimulation, happy to be so well-treated.\n\n");

			output("Stopping its licking, the beast begins to shuffle forwards, pre-cum coated worms plopping out of its double-dicks onto your belly.  They crawl lamely around as the beast works to line itself up, though you're unsure what it could possibly be aiming for.  Your questions are answered as the slightly pointed tips of its twin members press forwards, bumping against the crowns of your own cocks.   It pushes forward with an intense sort of care, slowly forcing itself into your urethras, dribbling painfully hot cum directly into your cock-passages.\n\n");

			output("Gods, it's shoving its infected cocks up your urethras!  It's trying to infect you with those worms!  The dog-demon keeps pushing further and further, sliding deep inside you, the outline of its members easily visible through the skin of your [pc.multiCocks].  It starts feeling good, the wriggling parasite-infested dicks begin sliding in and out, fucking your urethras in earnest and depositing their wormy cargo deep inside you.\n\n");

			output("Your ");
			if (pc.balls > 1) output("[pc.balls] shiver as hot doggie-cum and wiggling worms are pumped directly into them.  ");
			else output("body feels uncomfortably full as hot doggie-cum and wriggling worms are pumped directly into your [pc.balls].  ");
			output("Despite the strange freakishness of the situation, you find yourself getting off on having so many wriggling forms stuffed inside you.  The thickness of a large obstruction working its way down your urethra prevents your orgasm from taking you anywhere, but you feel the pleasure and pressure all the same.  Your body clenches and writhes under the beast, a helpless slave to the unholy pleasures being forced upon you.\n\n");

			output("The demonic dog backs away with what looks like a grin on its face after filling you with worms and boiling spooge, your urethras stretched and dripping with white squirming goop.  Pushed beyond your endurance, you start blacking out, your last thought a lamentation on how you'll be a carrier for these parasites, just like this demon-dog.");
		}
		else {
			output("The infested hound repositions itself, blocking out the sun with its dark fur, leaving you with only the pale flames surrounding its fuzzy sack to look at.   The warm wetness of its smooth tongue starts sliding over ");
			output("your [pc.cocks].  It feels good, better than it has any right to.  ");
			output("Your [pc.cocks] hardens under the stimulation, happy to be so well-treated.\n\n");

			output("Stopping its licking, the beast begins to shuffle forwards, pre-cum coated worms plopping out of its double-dicks onto your belly.  They crawl lamely around as the beast works to line itself up, though you're unsure what it could possibly be aiming for.  Your questions are answered as the slightly pointed tip of one of its twin-members presses forward, bumping against your [pc.cockHead].   It pushes forward with an intense sort of care, slowly forcing itself into your urethra, dribbling painfully hot cum directly into your cock-passage and dripping the stuff all over your groin.\n\n");

			output("Gods, it's shoving its infected cock up your urethra!  It's trying to infect you with those worms!  The dog-demon keeps pushing further and further, sliding deep inside you, the outline of its member easily visible through the skin of your [pc.cocks].  It starts feeling good, the wriggling parasite-infested dick begins sliding in and out, fucking your urethra in earnest and depositing its wormy cargo deep inside you.\n\n");

			output("Your ");
			if (pc.balls > 1) output( "[pc.balls] shiver as hot doggie-cum and wiggling worms are pumped directly into them.");
			else output("body feels uncomfortably full as hot doggie-cum and wriggling worms are pumped directly into your [pc.balls].");
			output("Despite the strange freakishness of the situation, you find yourself getting off on having so many moving forms stuffed inside you.  The thickness of a large obstruction working its way down your urethra prevents your orgasm from taking you anywhere, but you feel the pleasure and pressure all the same.  Your body clenches and writhes under the beast, a helpless slave to the unholy pleasures being forced upon you as the dog-demon's exposed member drops a huge worm into the wet puddle on your crotch.  You're horrified when you realize that a similar worm must be making its way inside you now.\n\n");

			output("The demonic dog backs away with what looks like a grin on its face after filling you with worms and boiling spooge, your urethra stretched and dripping with white squirming goop.  Pushed beyond your endurance, you start blacking out, your last thought a lamentation on how you'll be a carrier for these parasites, just like this demon-dog.");
		}
		//(+infested)
		pc.createStatusEffect("Infested", 0, 0, 0, 0);
		pc.orgasm();
		pc.slowStatGain("l", 1);
		pc.cor(1);
		//dynStats("lib", 1, "sen", 1, "cor", 1);
		pc.cumMultiplierRaw += 0.5;
		if (pc.cor() < 25) pc.cor(25, true);
		if (int(flags["COC.EVER_INFESTED"]) == 0) flags["COC.EVER_INFESTED"] = 1;
		
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	//[HAS PUSSY AND NO DICK BIG ENOUGH TO BE INFECTED]
	else if (pc.hasVagina() && pc.biggestCockVolume() < cockVolume(40) && !pc.isNaga()) {
		//(LUST) 
		if (pc.lustQ() >= 100) {
			output("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ");
			if (pc.cor() < 33) output("In spite of your revulsion ");
			else if (pc.cor() < 66) output("In spite of your better sense ");
			else output("With a perverse sense of anticipation ");
			output("you remove your [pc.gear] and drop to all fours, mimicking what you think a dog would do.\n\n");
		}
		//(HP) 
		else {
			output("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your [pc.gear] before tearing it off, exposing your [pc.asshole] and [pc.vagina].  A cold mountain breeze blows across your now exposed [pc.skinFurScales], reminding you just how utterly exposed you are to the alien lusts of this symbiotic monstrosity.\n\n");
		}
		output("The hell-hound rises up, looking nearly humanoid in shape for a moment before it drops down, planting its paws on your shoulders.  ");

		if (pc.cor() < 66 && pc.lustQ() < 100) output("You beg, \"<i>Please, no, no!  I don't want them... in me!</i>\"\n\n");
		else output("You start to beg it not to put them inside you, but your protests drop off when you realize how good they could feel squirming inside you.\n\n");

		output("The demon-dog tries to double-penetrate you all at once, but it isn't lined up properly, and all it manages to do is bump against your taint and drag its main member across your labia.   You gasp in pain, momentarily thankful not to be impaled by such bestial implements, but knowing all too well the brief reprieve will be over all too soon.   As if it can read your thoughts, the beast on top of you repositions itself and slams forward, this time managing to line its two dog-dicks up to your holes correctly.  The pair of them feel far larger than they looked, filling you with a painful suddenness that brings tears to your eyes.");
		pc.cuntChange(0, enemy.cockVolume(0));
		pc.buttChange(enemy.cockVolume(1));
		output("\n\n");
		output("Incredible heat radiates from the pair of rods inside you, making your whole body break out in a cold sweat in an attempt to deal with the situation.  You're rocked back and forth as the beast begins fucking you in earnest, slamming its fur-covered hips against your [pc.ass] with animalistic intensity.  Thankfully, the fucking isn't that painful, but the small mercy is ruined by the hot fluid you can feel starting to pour into you.\n\n");

		output("Oh gods no, you can feel something squirming inside you!  It's dripping worms into your intestines and pussy!   Its hot spittle drips onto your back as it ruts hard and fast, spurting and dripping a small portion of its wormy cargo inside you.  They're wriggling and squirming around, rubbing you in such an obscene way, bringing you closer and closer to orgasm in spite of the budding horror gnawing at your gut.   The beast on your back seems oblivious to it all, pushing more roughly into your [pc.vagina] and [pc.asshole] with every stroke until with a burst of pressure, he manages to bottom out both of his throbbing, black fuck-sticks at once.\n\n");

		output("It's so wrong... but so hot.  He's filling you with them!  The fucking hell-mutt is cumming and plugging both your holes full of his parasitic cargo!  Gods, you're filled with wriggling worms, squirming and writhing against your tender cunt-walls and rectum.   You're getting fuller and fuller, and the spooge they're swimming in is so fucking hot it practically burns you.  You cum hard, clamping down on the invading members, and squealing with a mix of pain and pleasure, driven beyond rational thought by the absurdity and pleasure of the situation.\n\n");

		output("Unable to support yourself any longer, you collapse, your hips held up by the pair of demonic black dog-dicks lodged in your orifices.  They keep cumming and cumming, until your body takes a slow slide off to the ground.  Your eyes drift closed, lulled to sleep by the squirming warmth plugging both your holes.  ");
		//(Status applied – worm plugged) – 
		//random chance of big lust boost as worms evacuate 
		//your body.  When worms leave they take with them up 
		//to 5 fertility, to a minimum of 10. 
		//if (pc.findStatusEffect(StatusEffects.WormPlugged) >= 0)
			//pc.addStatusValue(StatusEffects.WormPlugged, 1, 1 + rand(5));
		//else
			//pc.createStatusEffect(StatusEffects.WormPlugged, 1 + rand(5), 0, 0, 0);
		//pc.knockUpForce(PregnancyStore.PREGNANCY_WORM_STUFFED, 100 + pc.statusEffectv1(StatusEffects.WormPlugged)); //Will be cleared when the WormPlugged effect ends
		pc.orgasm();
		pc.slowStatGain("l", 1);
		pc.cor(1);
		pc.loadInAss(enemy);
		pc.loadInCunt(enemy);
		
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	//[GENDERLESS OR MALE WITH DICK TOO SMALL]
	else {
		//(LUST) 
		if (pc.lustQ() >= 100) {
			output("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ");
			if (pc.cor() < 33) output("In spite of your revulsion ");
			else if (pc.cor() < 66) output("In spite of your better sense ");
			else output("With a perverse sense of anticipation ");
			output("you remove your [pc.gear] and drop to your elbows, mimicking what you think a dog would do.\n\n");
		}
		//(HP) 
		else {
			output("Too wounded to stand, you drop down to on your elbows in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your [pc.gear] before tearing it off, exposing your [pc.asshole].  A cold mountain breeze blows across your now exposed [pc.skinFurScales], reminding you just how utterly exposed you are to the alien lusts of this symbiotic monstrosity.\n\n");
		}
		output("The hell-hound rises up, looking nearly humanoid in shape for a moment before it drops down, planting its paws on your shoulders.  ");
		if (pc.cor() < 66 && pc.lustQ() < 100) output("You beg, \"<i>Please, no, no!  I don't want it... in me!</i>\"\n\n");
		else output("You start to beg it not to put it inside you, but your protests drop off when you realize how good they could feel squirming inside you.\n\n");

		output("The demon-dog tries to penetrate you all at once, but it isn't lined up properly, and all it manages to do is bump against your taint and rub its other dick on your back.   You gasp in pain, momentarily thankful not to be impaled by such a bestial implement, but knowing all too well the brief reprieve will be over all too soon.   As if it can read your thoughts, the demon-hound repositions itself and slams forward, this time managing to line its dog-dicks up with your " + pc.assholeDescript() + " correctly.  It feels far larger than it looked, filling you with a painful suddenness that brings tears to your eyes.");
		pc.buttChange(enemy.cockVolume(0));
		output("\n\n");
		output("Incredible heat radiates from the thick black rod inside you, making your whole body break out in a cold sweat in an attempt to deal with the situation.  You're rocked back and forth as the beast begins fucking you in earnest, slamming its fur-covered hips against your [pc.ass] with animalistic intensity.  Thankfully, the fucking isn't that painful, but the small mercy is ruined by the hot fluid you can feel starting to pour into your " + pc.assholeDescript() + " and onto your back.\n\n");

		output("Oh gods no, you can feel something squirming inside you!  It's dripping worms into your intestines!   Its hot spittle and doggie-cum drips onto your back as it ruts hard and fast, spurting and dripping a small portion of its wormy cargo inside you.  They're wriggling and squirming around, rubbing you in such an obscene way, bringing you closer and closer to orgasm in spite of the budding horror gnawing at your gut.   The beast on your back seems oblivious to it all, pushing more roughly into your [pc.asshole] with every stroke until with a burst of pressure, he manages to bottom out his throbbing, black fuck-stick.\n\n");

		output("It's so wrong... but so hot.  He's filling you with them!  The fucking hell-mutt is cumming and plugging your hole full of his parasitic cargo while he paints your back with even more of them!  Gods, you're filled with wriggling worms, squirming and writhing against your rectum.   You're getting fuller and fuller, and the spooge they're swimming in is so fucking hot it practically burns you.  You cum hard, clamping down on the invading member, and squealing with a mix of pain and pleasure, driven beyond rational thought by the absurdity and pleasure of the situation.\n\n");

		output("Unable to support yourself any longer, you collapse, your hips held up by the demonic black dog-dick lodged in your orifice.  They keep cumming and cumming, until your body takes a slow slide off to the ground.  Your eyes drift closed, lulled to sleep by the squirming warmth plugging your [pc.asshole] and coating your back.");
		
		pc.orgasm();
		pc.slowStatGain("l", 1);
		pc.cor(1);
		pc.loadInAss(enemy);
		
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
}