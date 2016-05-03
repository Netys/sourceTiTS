import classes.Characters.CoC.CoCLustyDemons;
import classes.GameData.CombatAttacks;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.StringUtil;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

private function intoTheDemonPit(sacrifice:Boolean = true):void {
	clearOutput();
	//N is the number of hours left before night
	if (hours < 21) {
		var passed:int = (21 - hours) * 60 + rand(60);
		processTime(passed);
		output("<b>" + StringUtil.capitalize(num2Text(Math.ceil(passed / 60))) + " " + (Math.ceil(passed / 60) > 1 ? "hours pass" : "hour passes") + "...</b>\n");
	}
	output("You are awakened by a sudden cackling, and open your eyes; you are almost entirely surrounded by darkness, and the dim light provided by the menacing red moon only makes the landscape bleaker.");
	output("\n\nYou look around, puzzled.  Nothing seems to break the ever-present, nightly silence.  Then, as if to tease you, the cackling is heard again, this time behind you.  You turn around and eventually spot its origin: a crowd of silhouettes, all rushing in your direction, tittering and giggling like a bunch of naughty kids about to play a dirty trick.  As they get closer and closer to the pit, their colorful bodies and alien features are given a shining outline by the bloody moon; it seems that they are all full demons, sporting horns, claws, tails and wings.  Most of them are naked, shamelessly displaying gigantic erections or cavernous pussies as well as watermelon-sized, milk-dribbling tits.  Some of them are wearing leather straps that barely cover their taboo parts, as if to mock all notions of human prudishness.  You even spot an imp wearing a weird greenish vine like a belt; you stare at him for a few seconds, knowing something is out of place, then realize the belt is actually the imp's very flexible tentacle dick.");
	output("\n\nSoon, they are all gathered in the pit, surrounding you completely and eyeing you with gleeful lust; whatever plans these demons have in mind, they must be dirty.");
	output("\n\nA tall purple demoness walks up to you as you stand there");
	if(sacrifice) output(", tangled in your restraints");
	output(".  She leans down and coos, ");
	//[if first time]
	if(flags["COC.TIMES_IN_DEMON_PIT"] == undefined) output("\"<i>Awww, look at the poor little thing!  So this is what they gave us this time... Look at [him], everyone!  Do you know you'd be a cute pet?  People here call me Vapula, and I don't think you'll forget that name any time soon.</i>\"");
	//[else if Vapula Submissiveness >50]
	else if(flags["COC.VAPULA_SUBMISSIVENESS"] > 50) output("\"<i>You again?  By Lethice, you must really enjoy it!  You love being a bitch for Vapula, don't you?  Yes you do!</i>\"");
	//[else]
	else output("\"<i>Fuck, you again?  Tell me it's so!  I've been looking forward to putting you in your place as my newest slut!</i>\"");
	//[(if sacrificed)
	if(sacrifice) {
		//[if str >= 80]
		if(pc.physique() >= 40) {
			output("\n\nYou test the chains holding you to the pole; they're slack enough that you have room to flex and you could probably break them if you decided to fight...");
		}
		else if(pc.reflexes() >= 40) {
			output("\n\nYou test the chains holding you to the pole; they're slack enough that you could probably make use of your incredible dexterity to slip free...");
		}
		else if(flags["COC.SPELL_MIGHT"] == 1 && Math.max(pc.intelligence() / 2, 10) + pc.physique() >= 40) {
			output("\n\nYou test the chains holding you to the pole; you are not strong enough normally, but you can enchance your physique with magical might to break them if you decided to fight...");
		}
		//[else]
		else output("\n\nThe chains binding you aren't very tight or of the finest craftsmanship, but they're sufficient to hold you more or less in place; though you can probably twist to avoid a few attacks, you won't be able to make any of your own if you decide to resist... at least, not physically.");
		output("  You're once again feeling regret over letting the villagers hold your equipment, but there's nothing for it now.");
	}
	
	//if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
		//output("\n\n<b>New codex entry unlocked: Succubus!</b>")
	//}
	
	IncrementFlag("COC.TIMES_IN_DEMON_PIT");
	flags["COC.DAYS_SINCE_LAST_DEMON_DEALINGS"] = 0;
	
	clearMenu();
	addButton(0, "Fight", fightZeDemons, sacrifice);
	addButton(1, "Submit", CoCLustyDemonsPCLoss);
}

//Submit/Fight
private function fightZeDemons(sacrifice:Boolean = true):void {
	clearOutput();
	//Fight leads to the Horde Fight
	//When acting as sacrifice, Item button is disabled; Fight, Run, and Phys Special buttons are disabled unless PC has str >= 80; Run is furthermore prevented entirely if PC is non-winged; outputs text: \"<i>You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!</i>\"
	//PC's weapon is temporarily set to fists and armor to comfortable clothes during a Horde Fight if he triggered it in response to a sacrifice request, but not if triggered through volunteering to guard the pit later once the village is unlocked
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCLustyDemons());
	CombatManager.victoryScene(CoCLustyDemonsPCVictory);
	CombatManager.lossScene(CoCLustyDemonsPCLoss);
	CombatManager.displayLocation("DEMONS");
	CombatManager.beginCombat();
	
	if (sacrifice) {
		pc.createStatusEffect("Disarmed", 9999, 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", false, 0);
		
		if (pc.physique() < 40 && pc.reflexes() < 40)
			if(flags["COC.SPELL_MIGHT"] == 1 && Math.max(pc.intelligence() / 2, 10) + pc.physique() >= 40)
				CombatAttacks.Might.execute(CombatManager.getFriendlyCharacters(), CombatManager.getHostileCharacters(), pc, pc);
			else CombatManager.getHostileCharacters()[0].createStatusEffect("Sacrifice");
		
		CombatManager.showCombatUI();
	}
}

//Loss scene/Submit (gangrape) (Z)
public function CoCLustyDemonsPCLoss():void {
	clearOutput();
	if (enemy == null) setEnemy(new CoCLustyDemons());
	output("Vapula taunts you as she circles around you.  \"<i>Look at the slutty pet!  Ain't you a slutty pet?  Yes, you are!  Don't pretend you're not hungry for some fat demon cock, I know you are.</i>\"  As she speaks, the crowd gathers closer.  A few creatures show some temerity, giving you pinches and gropes as they near.  The cock-belted imp unties his tentacle; the horror wriggles and squirms as it drops to the ground and slithers toward you.  The tip of the absurdly long pecker inspects your body, pressing itself against your flesh, massaging you in the most sensual places, wetting you with sap-like pre-cum and teasingly grinding itself against your mouth, and then your [pc.asshole]");
	if (pc.hasVagina()) output(", followed by your [pc.vagina]");
	if (pc.hasCock()) output(", before finally wrapping around [pc.oneCock] and stroking it; the friction uncontrollably arouses you, and you find yourself reaching full erectness");
	output(".  As more and more hands start playing with your flesh, the succubus grabs your head and gives you a fierce kiss, literally crushing your lips under hers; her mouth tastes like wine and her tongue is driving you over the edge as it intertwines with yours.  Her strong natural scent makes you dizzy and you gradually lose control over your body.  \"<i>Don't worry, darling, it'll be all right...</i>\"");
	output("\n\nSoon you find yourself completely overwhelmed by hot demon hands and dicks touching every part of your body.  In no time at all two imps bend you over and forcefully ram your [pc.asshole] with their mammoth peckers.");
	//[ass stretching check]
	pc.buttChange(60, true, true, false);
	output("  The double penetration is brutal, unexpected and painful.  Your insides are protesting vigorously against this rough treatment, even though you feel a tingle of pleasure gently tickling your colon at every thrust.  ");
	//[(no Buttslut)
	if(pc.slut() < 33) output("No!  You aren't supposed to enjoy it...  ");
	output("You try to cry out but as soon as your mouth opens it is filled with another dick, then a second one.  A third tries to push its way between the first two, stretching your cheeks and making you drool.  Seeing that the monstrous dong won't fit in your already double-stuffed mouth, its owner groans in frustration and proceeds to slap your cheek with it.  He is soon joined by other demons who find the idea very entertaining.");
	output("\n\nIt's a matter of minutes before a dozen hungry omnibuses and incubi are repeatedly cock-slapping your entire body, hitting every part of you with their heavy meat, grinding their rods against every fold and curve of your flesh and staining it with seminal fluids.  Your poor butt, already abused by two giant pricks thrusting back and forth at an unnatural pace, is now the prey of numerous hands and full, erect dicks slapping it in every possible way, smearing it with pre-cum and sweat as they run across your tender skin.  You can't see anything: your eyesight has been blocked by a never-ending row of wriggling cocks.  Nor can you hear anything over the sound of a full horde of libidinous demons panting and moaning as they abuse their fuck-toy in an overwhelming orgy of pleasure; besides, a pair of imps are rubbing the tips of their dongs against your ears, as if they wanted to fill them with seed.");
	output("\n\nYou can't talk, muted as you are by a pair of fat red peckers stuffing your mouth and bumping against your throat as you unwillingly suck them off.  Your jaw hurts, your itching insides are driving you mad; your whole body is being bruised from the cock-slaps, your palms are forced to rub four shafts at the same time, and even as you pump, your fingers are occasionally grabbed and stuffed into wet fuck-holes, making a few succubi moan.  A tentacle dick brushes against you, then wraps around your limbs, slithering against your [pc.skinFurScales] and leaving behind a trail of pre-cum on your torso and [pc.belly].");
	if(pc.hasCock()) output("  It wraps around [pc.eachCock] for a while, jerking it for a bit and rubbing its tip against yours.");
	//[if antennae]
	if(pc.hasAntennae()) output("  Your [pc.antennae] are being harshly pulled and twisted; some imps, in a crazy show of libertinism, start inserting your sensitive peduncles down their bloated urethrae. The intimate friction and the sudden jolts when the internal walls slather your appendages in slick, hot pre-cum are driving you mad with irregular shots of unbearable pleasure.");
	//[if horns]
	if(pc.hasHorns()) output("  You feel your [pc.horns] being used as leverage to slap your head with even more rock-hard dick.  The impacts stun you until your whole forehead feels numb and coated with a mixture of ballsweat and pre-cum.");
	//[if vagina
	if(pc.hasVagina()) {
		output("\n\nYou suddenly feel a sharp sensation: your womanhood is finally being penetrated.");
		pc.cuntChange(0, 60, true, true, false);
		output("  A dick found a way into your [pc.vagina] and is pushing further inside.  Wait, what's this?  A second, and then a third!  There's no way these titanic columns of flesh will... this is too much... you fear you will be torn in half, but at the last moment, you feel someone spilling the content of a flask over your nether-lips.  As if you had lost control of your [pc.vagina], it automatically starts leaking [pc.girlCumNoun] in prodigious amounts, and you let out a stifled moan as a delicious shiver runs teasingly across your body.  Your fuck-hole widens under the corrupting effect of the weird mixture you were administered.  ");
		//[set vagstretch up a few levels]
		if (pc.vaginas[0].bonusCapacity < 200) pc.vaginas[0].bonusCapacity += 15;
		output("As soon as new space is created, it is immediately filled by a pussy-hungry cock.  The three cocks slide effortlessly inside you and start thrusting energetically, vying in intensity and ferocity with the peckers ramming your [pc.asshole].  The penetration of both holes is almost too much too handle, but you finally get used to it as your own anal and vaginal muscles try their best to milk as much spunk as possible from these cum-tubes.  Even though you are being violated in every hole, the raw and powerful sensation is quite pleasurable; it feels so right to be used this way, so full of demon wang.  You don't have to focus on anything, just to enjoy the sheer amazing feeling of being pounded by many pistons at once.  You squirt over and over again as the dicks and the fluid force you into a series of wild female orgasms.");
		//[crank up vaginal wetness one level, why not?]
		if(pc.wetness() < 5) pc.vaginas[0].wetness(1);
	}
	//[if cocks]
	if(pc.hasCock()) {
		output("\n\nA soft brush against [pc.oneCock] warns you that your crotch is going to get some more love.  At least four hands are caressing it, helping you rise and thicken until it can't grow anymore.  After a while of playful stroking, the hands are suddenly gone, only to be replaced by a fluid-gushing cunt.  It impales itself on your [pc.cockBiggest] at full force, driving a very whorish and high-pitched cry from its owner.");
		//[if more than 1 and less than 4 cocks]
		if(pc.cockTotal() > 1) output("  She is soon joined by other horny girls, too eager to wait for a piece of your crotch to play with.  They all comfortably position themselves, positioning their pussy or anus atop [pc.eachCock] before riding you like there's no tomorrow.");
		//[if 4 to 7 cocks]
		if(pc.cockTotal() >= 4) output("  Nevertheless, they aren't satisfied with a single insertion and most grab hold of one of your extra cocks before forcefully stuffing it in their other hole, howling and thrashing all the more as they are penetrated a second time.");
		//[if 7 cocks or more]
		if(pc.cockTotal() >= 7) {
			output("  Sadly, surrounded as you are, no one will be able to find extra room to ride your remaining cocks; fortunately, you feel warm, long demonic tongues being pressed against your [pc.cock 6]");
			if(pc.cockTotal() > 8) output(" as well as your remaining pricks");
			output(".  The tongues expertly lick your meat and wrap themselves around it, and questing lips give it multiple kisses before one pair suddenly loses patience and deepthroats you with voracity; the tightness of these lips makes them feel like a very efficient cock-ring.  However, it is hard to focus on the sweet warmth provided by these avid mouths when all your other cocks are being clamped by powerful, inhuman vaginal muscles.");
		}
		output("\n\nBetween every thrust, you feel hands working and polishing your shaft");
		if(pc.cockTotal() > 1) output("s");
		output(", as if every inch had to be taken care of at every instant.  As you slide back into the pussy, the hands return to crawling over your body, caressing your groin and staining your belly with pre-cum - yours and others.");
		output("\n\nYou are ridden for a while, the hell-girls thrashing wildly and yelling in pure ecstasy as they reach their climax.  They release so many powerful orgasms you stop keeping track of them.");
	}
	//[if lactating breasts]
	if(pc.isLactating()) output("\n\nLost in your feverish state of arousal, you feel your [pc.nipples] harden and a thin trickle of [pc.milk] comes out.  A couple of demons spot this new source of fluids and rush to your [pc.fullChest], wolfishly suckling them.  Their dexterous tongues keep teasing your nipples, stimulating you further as they drink your essence.  Your [pc.milkNoun]-udders are being roughly groped and licked by these careless creatures, oblivious of everything but your mounds.");
	output("\n\nEventually, your insane mix of violation-induced pleasure and pain proves too much for your wrecked body and your whole consciousness winds up as you brace yourself for your incoming climax.  Your eventual spasm is so strong that some of the demons lose the grip they have on you.  Your hands twitch, unintentionally squeezing the cocks pressing against them.  Your head bumps against a wall of dicks, and your nose lodges itself in a miraculously free pussy that was waiting its turn near your mouth.  You even manage to liberate your mouth from that duo of monster-sized members; as you gasp for some air, you can't help but let out a shrilling cry of pleasure.  You scream aimlessly; all the violations you've endured, every sensation inflicted upon your body is expressed in that helpless shriek.  Of course, you can't hear yourself screaming because of all the cum that has been unloaded onto your ears, but you don't care.  Your body is becoming a nexus of pleasure in this show of debauchery as unholy liquids are pumped in and out of it.  As you scream, your groin clenches and you climax with unequaled intensity.");
	//[if cocks]
	if(pc.hasCock()) {
		output("  [pc.EachCock] pulsates and throbs");
		//[[if balls]
		if(pc.balls > 0) output(", and your balls swell and boil");
		output("; a gigantic spooge-flow pushes its way up your urethra and spurts outside in the waiting love-tunnels");
		if(pc.cockTotal() > 7) output(" and mouths");
		output(".  The violent cumshot almost instantly produces a shiver of orgasm once again and vaginal walls contract furiously, determined to absorb as much of your baby-batter as possible.");
		//[if cum production is massive]
		if(pc.cumQ() > 1500) output("  The effort appears to be vain, as the absurdly high volume you've ejected is enough to completely pack every hole; the remaining [pc.cumNoun] spills on the tainted ground, soaking it further.");
	}
	output("\n\nAfter what seems like hours of forceful penetration, the gigantic members inside you release a milky torrent of corrupted seed, completely packing your colon through your [pc.asshole]");
	if(pc.hasVagina()) output(" and filling your womb to its maximum capacity");
	output(".  The remaining cum spurts outside and dribbles onto your [pc.legs].  Your asshole clenches, squeezing the dongs inside you and milking their very last drops of spunk.");
	//[if vagina]
	if(pc.hasVagina()) output("\n\nYour own [pc.vagina] clenches too, doing its best to waste as little semen as possible.  Your muscles quiver as they feel the incoming last release.  Then, in climax, you squirt your own [pc.girlCum], splattering the demon dicks with your juice.");
	//[if lactating breasts]
	if(pc.isLactating()) output("\n\nThe combined efforts of a dozen demons proves too much for your poor [pc.breasts] and your nipples let out a flood of [pc.milk], which is immediately gobbled by thirsty imps.  ");
	else output("\n\n");
	output("Everywhere around you, people keep cumming and shooting ropes of jism.  In no time your entire body is drenched with spooge.  Your [pc.eyes] and [pc.ears] are completely covered with sticky goo, preventing you from hearing and seeing.  Still, you can feel penises being stuffed into your mouth again as they unload their unholy swill.  The taste is strong, hot, and salty, but not unpleasant.  You swallow until your [pc.belly] swells, but you don't care; temporarily reduced to the instincts of breeding stock, you want more spunk and you suck it up as if your life depended on it.");
	output("\n\nYou keep oozing out fluids until you reach your own body's capacity.  When the flow of various juices starts to ebb, you relax, completely exhausted.  You simply lie there in a bed of cocks and naked flesh, abandoning all hope of struggling against the demons' will.  Of course, they aren't done yet.  A few seconds later - the time needed for everyone to switch positions - and they're at it again.  You are touched and caressed, filled and used again, and again, and again.  You black out.");
	//[Vapula Submissiveness raises by 10. If it reaches 100 or more, go on to the Vapula Slave Bad End. Otherwise Wake up scene. Additionally, if it is raised to 90 or more this way, display warning:]
	flags["COC.VAPULA_SUBMISSIVENESS"] += 10;
	if(flags["COC.VAPULA_SUBMISSIVENESS"] >= 90 && flags["COC.VAPULA_SUBMISSIVENESS"] < 100) output("\n\n<b>You're starting to get dangerously used to this kind of treatment.  Your holes are being stretched to accommodate monstrous sizes and don't hurt that much anymore.  You feel like you could stand this as long as you need to with ease... maybe it's time to stop volunteering?</b>");
	
	processTime(7 * 60 + rand(60));
	pc.loadInCunt(enemy);
	pc.loadInAss(enemy);
	pc.loadInMouth(enemy);
	pc.girlCumInMouth(enemy);
	
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.milked(pc.milkFullness);
	pc.lust(pc.lustMax());
	
	pc.slowStatGain("l", 1);
	pc.cor(3);
	
	flags["COC.REBECCS_LAST_PLEA"] = undefined;
	pc.removeStatusEffect("Disarmed");
	if (!CombatManager.inCombat) setEnemy(null);
	
	clearMenu();
	if (flags["COC.VAPULA_SUBMISSIVENESS"] >= 100)
		addButton(0, "Next", slaveToVapulaBadEnd);
	else if (flags["COC.LOST_VILLAGERS_SPECIAL"] == 1)
		addButton(0, "Next", morningAfterRape);
	else addButton(0, "Next", wakeUpAfterDemonGangBangs);//WAKE UP
}

private function wakeUpAfterDemonGangBangs():void {
	clearOutput();
	output("When you wake up, you are alone, and your restraints are broken.  You are sloshing in a pool of stinky juices; your mouth and ears are still full of it.  Your whole body is covered with a thin white layer that must certainly be dried spooge.  Underneath, you're nothing but bruises and every movement seems to hurt.  A few meters away, outside the pit, you notice your possessions.  The village itself appears to be empty... your best assumption is that the residents are hiding, either from shame at having sacrificed you or from awkwardness at the prospect of talking to a sloshing, crusty cumdumpster.  Wearily, you head back to your camp.\n\n");
	pc.slowStatGain("p", -2);
	pc.slowStatGain("r", -1);
	pc.slowStatGain("i", -1);
	pc.slowStatGain("l", 1);
	pc.cor(3);
	if (CombatManager.inCombat) CombatManager.genericLoss();
	else addButton(0, "Next", mainGameMenu);
}
	
//Victory (Z)
public function CoCLustyDemonsPCVictory():void {
	clearOutput();
	flags["COC.REBECCS_LAST_PLEA"] = undefined;
	if(flags["COC.VAPULA_SUBMISSIVENESS"] <= 0) {
		subdueVapula();
		return;
	}
	//Sacrificed and bound
	if(pc.hasStatusEffect("Disarmed")) {
	   if(enemy.HP() <= 1) output("You grin wickedly as the last demons fall, defeated.  Some of the errant blows have broken and mangled the links of your chains, and you find you can get free with a bit of additional effort.\n\n");
		//[if won by Lust]
		else output("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even begins unfastening your bindings, hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.\n\n");
		pc.removeStatusEffect("Disarmed");
	}
	//Not
	else {
		if(enemy.HP() <= 1) output("You grin wickedly as the last demons fall, defeated.\n\n");
		//[if won by Lust]
		else output("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even has hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.\n\n");
	}
	//[(requires genitals and and corr >60)
	processTime(15 + rand(10));
	clearMenu();
	if((pc.cor() > 60 || !pc.isNice()) && pc.hasGenitals()) {
		output("Do you take advantage of them?\n\n");
		addButton(0, "Yes", rapeZeVapula);
		addButton(1, "No", noVapulaSex);
	}
	else {
		output("\n\nThough the display as they explore each other is somewhat arousing, you can't really get into it as you are, and simply use your new-found freedom to climb out of the hole.  It's too dark to return to the village now, so you head back to camp.\n\n");
		flags["COC.VAPULA_SUBMISSIVENESS"] -= 5;
		CombatManager.genericVictory();
	}
	
}

private function noVapulaSex():void {
	clearOutput();
	flags["COC.VAPULA_SUBMISSIVENESS"] -= 5;
	processTime(15 + rand(10));
	CombatManager.genericVictory();
}

//Yes/
//[Yes: submissiveness is lowered by 10. No or auto-reject: submissiveness is lowered by 5.]
private function rapeZeVapula():void {
	flags["COC.VAPULA_SUBMISSIVENESS"] -= 10;
	//Victory rape with penis [Anal Orgy and Bukkake] (NTR Vapula) (Z)
	if(pc.hasCock()) {
		clearOutput();
		var x:int = pc.biggestCockIndex();
		output("The demon horde struggles before you.  With a disdainful smile, you fully expose your [pc.crotch] for everyone to see.  ");
		//[if cocks]
		if(pc.hasCock()) output("\n\nYou gently stroke [pc.oneCock], bringing it to full erectness.  ");
		//[if vagina]
		if(pc.hasVagina()) output("You stick a finger in your own [pc.vagina] in order to lubricate it.  ");
		output("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if(enemy.HP() <= 1) output("the many bruises she's received");
		else output("the constant flushing due to intense arousal");
		output(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if(pc.hasVagina()) output("bitch in heat");
		else output("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		output(".  However, you have better plans for her.");
		
		output("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		output("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your [pc.tongue].  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal.");
		output("\n\n\"<i>What are you waiting for?</i>\" she moans.  \"<i>Fuck me already, you dirty bastard.  Go ahead, stuff me.  Why don't you get down to business?  Are you afraid that you might last only a minute?  What are you, a poor little sissy with no stamina?  You innocent little " + pc.mf("manlet", "maiden") + ", I will–</i>\"");
		output("\n\nSLAP!  The back of your hand impacts her cheek, muting her for a moment and opening the way for your own comment.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  You want sex?  Don't worry, you'll see plenty soon.</i>\"");
		output("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, another succubus; although not so tall or big-breasted as Vapula, her provocative curves are a delight to your eyes.  You bend her over and, without ceremony, start working her tight pucker, filling her insides with your [pc.cockBiggest].");
		if(pc.cockTotal() > 1) output("  Seeing that she has extra room left, you grab another of your dongs and put it at the entrance of her dripping cunt before forcing it in.");
		output("\n\nYou keep thrusting back and forth, treating the worthless horned-girl like a disposable cock-sleeve. As you pump in and out of her, you look at Vapula, warning her.  \"<i>Don't turn your head.  If you ever look away or close your eyes, you will regret it.</i>\"  Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.  You work the succubus's lush hole");
		if(pc.cockTotal() > 1) output("s");
		output(" in front of the once-powerful dominatrix, grunting and panting as you accelerate the pace, until you finally reach your climax and release rope after rope of jism in your fuck-toy, completely packing her backdoor");
		if(pc.cockTotal() > 1) output(" and her love-tunnel");
		output(".");
		//[if massive cum production]
		if(pc.cumQ() > 1000) output("  Some of it spurts by little jets outside of her, even as she instinctively contracts her muscles to keep as much spooge as possible and her belly accomodates by bloating out absurdly.");
		output("  Needless to say, watching this rough ");
		if(pc.cockTotal() == 1) output("anal");
		else output("double-penetration");
		output(" session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own and she whimpers from time to time, unable to control her lust.");
		output("\n\nYou throw away your expendable");
		if(pc.cumQ() > 1000) output(", expandable");
		output(" cumdumpster and grab another slut.  This time you feel like you could use a blowjob to clean off the demonic sweat and slime from your cock; you forcefully open her jaw and shove your [pc.cockBiggest] down her throat without any care.  The sudden influx of dickflesh blocking her air-flow makes her choke and cough, but a withdrawal and a good cock-slap reminds her of her place.  \"<i>You fucking bitch!  You goddamn worthless slut!  What good are you if you can't even give proper head?  Lick, you whore!  I want your tongue all over my crotch!  You can breathe when you've properly moistened my ");
		if(pc.balls > 0) output("balls");
		else output("skin");
		output("!</i>\"  The poor demoness, cheek stained with semen, mutters an apology and proceeds to lick your [pc.cockNoun " + x + "], suckling the [pc.cockHead " + x + "], ");
		if(pc.balls > 0) output("fondling your [pc.balls], ");
		//[if multicocks] 
		if(pc.cockTotal() > 1) output("alternatively deepthroating or jerking every cock of yours, ");
		output("warming up your dickflesh with her demonic tongue.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your semen-dribbling shaft");
		if(pc.cockTotal() > 1) output("s harden and thicken ");
		else output(" hardens and thickens ");
		output("again as the demoness sucks you off; Vapula can't help but take a quick glance at it, but you pretend not to notice.  After all, she's only teasing herself for you.");
		output("\n\n\"<i>Please... take me,</i>\" she whimpers.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll give you head, I'll give you my ass, anything.  Just fuck me!  My pussy is so horny it hurts!</i>\"");
		output("\n\n\"<i>Piss off, bitch.</i>\"");
		output("\n\nYou seize your fuck-toy by the waist and, turning her, gratuitously ram her asshole, her face right next to Vapula's pussy and staring at it with timid yet longing eyes.  She cries in pleasure and darts her tongue out; your toy almost manages to take a lick before you impale her all the way back on your [pc.cock " + x + "].  After a few more mad thrusts, you feel another wave of seed flooding your urethra and spurting inside the slut's colon.  But this time, you pull out your cream-spraying pecker");
		if(pc.cockTotal() > 1) output("s");
		output(" and aim at Vapula, splattering her body with your spunk.  Words cannot describe the sheer triumph you feel.  You burst into laughter as you drench that unworthy bitch with your seed.");
		output("\n\nGods, this is only the beginning.  Your next target is an unconscious imp with a monstrously thick pecker.  You lift him by his arms and jam his little pucker on your [pc.cockNoun " + x + "], making sure his own cock points toward Vapula.  The sudden anal penetration wakes him up and makes his dick, already half-mast from his perverted imp dreams, instantly rock hard.  You begin stroking his dick with enthusiasm as you violate his insides, your own [pc.cum] serving as lube for the rough anal penetration.  The tight confines of the little red creature as well as your furious handjob prove too much for both of you and in no time you are both ejaculating in chorus.  Milky torrents burst from his mammoth member, further soaking the horny ex-dominatrix.");
		output("\n\nBut you're not satiated yet.  You grab another demon, fuck it rough and fast; when you know you're about to reach another orgasm, you pull out before cumming what your body can manage on Vapula's body.  You fuck another creature this way.  And another, and another...  When whatever you're fucking happens to have a cock, you ruthlessly rub it until it squirts everything it has on the tied succubus.  ");
		if(pc.cockTotal() > 1) output("In an unholy sex-frenzy, you want more; you start grabbing creatures by groups and alternatively pump in and out of their asses with your [pc.cockNoun " + x + "], always hungry for more anal.");
		output("\n\nVapula is now entirely covered in a thick white liquid blanket.  The contact of all this hot seed against her untouched skin is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		output("\n\n\"<i>You're... you violate my pets, yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Look, it's aching for a cock like yours.  It needs you.  I need your meat inside of me, please fuck me fuck me fuck me fuckmefuckme... <b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		output("\n\nHa!  Without a word, you keep thrusting your [pc.cockNoun " + x + "] inside your current hot hole while staring at her.  You resolutely ignore her, determined to let her see you fuck the entirety of her horde.  The various demons in your grasp appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously stretch their interior; instead, they moan like the bunch of bitches they truly are, letting their mistress know that a dominant stud is giving them more pleasure than she ever did.");
		output("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done pounding the last untouched hole in the pit, when your [pc.cockNoun " + x + "] is done squirting its ultimate drop of goo over the wanton succubus, you relax and drop the fuck-toy you were using.  Your [pc.cockNoun " + x + "] is finally softening and you have no further use of any broken toy in the pit.  All but one...");
		output("\n\nWhen you walk up to Vapula, she is barely recognizable. Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		output("\n\nA few meters away, outside the pit, you notice your possessions.  The village appears to be deserted.  Considering these demons will have a hard time threatening anyone with [pc.cum] oozing out of their absurdly stretched holes, you let them rest, wallowing in a pool of mixed spunk.  You pick up your belongings and head back to camp.");
		if(silly) output("  As you look back, you snicker, \"<i>Ass for ass, assholes.</i>\"");
		//+med-high corruption, + strength/cons, -10 libido
	}
	//Victory rape using vagina/anus [Take Dicks in All Holes](Z)
	else {
		clearOutput();
		output("The demon horde struggles before you.  With a disdainful smile, you fully expose your [pc.crotch] for everyone to see.  ");
		//[if cocks]
		if(pc.hasCock()) output("\n\nYou gently stroke [pc.oneCock], bringing it to full erectness.  ");
		//[if vagina]
		if(pc.hasVagina()) output("You stick a finger in your own [pc.vagina] in order to lubricate it.  ");
		output("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if(enemy.HP() <= 1) output("the many bruises she's received");
		else output("the constant flushing due to intense arousal");
		output(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if(pc.hasVagina()) output("bitch in heat");
		else output("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		output(".  However, you have better plans for her.");
		
		output("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		output("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your tongue.  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal. The rest of the defeated horde watch, barely daring to breathe.");
		output("\n\n\"<i>What are you waiting for?</i>\" Vapula snarls.  \"<i>Use me already, you filthy bitch.  Shove your pussy into my face, let me lick your nasty juices, rub it all over me if that's the best you can do.  You haven't thought the logistics of this through, have you, cunt?  Or maybe you're too afraid.   Maybe you just need some cock up you, to remind you who-\"</i>");
		output("\n\nSLAP!  The back of your hand hits her across her face, muting her for the moment you need to lay down the rules.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  And what an interesting idea you've given me.  Let's find out who wants what, shall we?</i>\"");
		output("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, an incubus; shorter and younger than Vapula, his tight, pert body is a delight to your eyes.  Without ceremony you shove him to the ground and grind your [pc.vagina] into his crotch.  He looks at you, semi-comatose and bewildered, as you get a rise out of his dick, which hardens against your damp strokes.  You pin him down as you sink onto his red length, sighing as you rapidly engulf him, then begin to ride him ruthlessly.  ");
		pc.cuntChange(0, 40, true, true, false);
		if(pc.looseness() > 3) output("His cock is lost in your vast cunt and you work him as hard as you can to feel him against your walls, his body convulsing and dazed eyes rolling against the wet, savage rape.  ");
		output("You keep thrusting back and forth, treating the worthless horned boy like a disposable dildo.  As you pump him, you look at Vapula, warning her, \"<i>Don't turn your head.  If you ever look away or close your eyes you will regret it.</i>\" Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.");
		output("\n\nYou keep working the incubus's hot cock in front of the once-powerful dominatrix, panting as you accelerate the pace until you finally reach your climax, clenching your thighs tightly to his fit body as your [pc.vagina] clenches and spasms.  ");
		//[if squirter] 
		if(pc.isSquirter()) output("The sound of spattering fluid fills the air as your cunt spurts its juices around the incubus's cock, coating him in your fragrant slime.  ");
		output("Against your relentless milking pressure he stands no chance and he moans raggedly as he cums in tandem, still incapable of moving his body as your mixed juices dribble down him.");
		output("\n\nNeedless to say, watching this rough session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own accord and she whimpers from time to time, unable to control her lust.");
		output("\n\nYou throw your expendable cock toy to one side and grab another slut, this time a succubus.  Your semen-dribbling cunt is now in need of a cleaning, and without any ado you sit yourself straight down onto her face, banging the back of her head against the ground.  She whines into your [pc.vagina], to which you respond by pulling her hair.  \"<i>You fucking bitch!  You worthless slut!  What good are you if you can't even munch rug properly?  Lick, you whore!  I want your tongue to clean up what your useless fuckhead of a friend couldn't keep to himself.</i>\"  The poor demoness mutters an apology and proceeds to lap up the juices drooling out of your hole, licking your labia and mons clean of what the incubus left, darting her wet muscle across your [pc.clit] before reaching into your vagina, carefully teasing out and drinking every drop of jizz she can find, making your own juices run afresh.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your [pc.nipples] harden");
		if(pc.biggestTitSize() >= 2) output(" and your [pc.fullChest] bounce gently");
		output(" as you grind your snatch into the succubus's face; Vapula can't help but take a quick glance at your oozing, slippery cunt, but you pretend not to notice.  After all, she's only teasing herself for you.");
		output("\n\n\"<i>Please... take me,</i>\" the tied demon whines.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll lick your cunt, I'll scissor you, I'll magic you a strap-on, anything.  Just fuck me; my pussy is so horny it hurts!</i>\"");
		output("\n\n\"<i>Piss off, bitch.</i>\"");
		output("\n\nYou feel another high coming as you thrust harder and harder into the succubus's mouth; her eyes look timidly at an upside down Vapula as you ride her slippery tongue to another clenching climax.  Rather than sit down for it this time you raise yourself up and stare gloatingly at the dominatrix as a small torrent of semen-mingled girlcum gushes out of you and spatters all over the tied succubus.  The demon is so far past it she drinks and chokes over what you give her.  What is in Vapula's eyes as she watches this is something between total horror and raging thirst, and it fills you with incredible triumph.");
		output("\n\nGods, this is only the beginning.  You sashay into a beaten huddle of incubi and imps.  One of the more aware ones even tries to crawl away at your approach; you put an immediate stop to this by grabbing his bulging quartet of balls.  Holding him entirely at your mercy this way, you use your other hand to rub his monstrously thick pecker, quickly making it bulge with pressure.  Again you push the gasping, quaking incubus onto his back and guide him into your gaping pussy; your eyes catch those of an imp whose mouth is open with disbelief and whose dog dick is standing to attention.");
		output("\n\n\"<i>You!</i>\" you snap. \"<i>Fuck my ass.  Do a good job or I'll wring your neck.  The rest of you worthless spare pricks... gather around.</i>\"  You grip the incubus beneath you with your [pc.hips] as small, uncertain hands grasp you around your waist and something hot oozes moisture into your [pc.asshole].  You thrust forwards and then backwards, simultaneously working the incubus cock whilst driving the imp's meat into your bowels.");
		pc.buttChange(60, true, true, false);
		output("  Around you more dicks present themselves as other demons slowly draw closer, and with the cock inside you rubbing your sensitive inner walls backwards and forwards you enthusiastically grab two other turgid members and pump them in tandem.  One of the dicks you have grabbed is a sensitive cat dick and the owner is quickly moaning as your fingers brush his hooks; as you feel him reach his peak you ruthlessly jerk him around so he is facing Vapula, and he helplessly spurts his load onto her jiggling frame.  The imp begins to pump harder as he finds his rhythm, stretching your ass wide as he takes you to his plug, rubbing against the huge incubus cock trapped in your [pc.vagina].  You laugh breathlessly and manically as the other demon in your grasp helplessly falls over his own peak, further soaking the horny ex-domniatrix.");
		//[cunt nipples] 
		if(pc.hasFuckableNipples()) output("  Your freakish nipples moisten with excitement to the smell of man juice, and you feel your libido ratcheting up even higher.  Bending forward, you grab two other imps with smaller dicks, quickly guiding their lengths into your nipplecunts; they are small enough that you can mash their bodies against your soft flesh, doing all the work for them as your sensitive nubs are penetrated.");
		output("\n\nVapula stares at you through the creamy liquid which now covers her face and tits.  The contact of all this hot demon seed against her untouched body is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		output("\n\n\"<i>You're.. you violate my pets... yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Please fuck me fuck me fuck me fuckmefuckme....<b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		output("\n\nUnable to break your gaze, she stares at you as with slow, gloating exaggeration you put your sticky fingers into your mouth and moan, clenching down on the dicks deep in your holes as you do.  The incubus and imp");
		if(pc.hasFuckableNipples()) output("s");
		output(" gasp as they spurt their loads, filling you with inhuman warmth; four balls push into overload and the incubus beneath you spasms his hips uncontrollably as he releases surge after surge of cum until your gushing quim begins dribbling the fluid back onto him.  You sigh and clench your muscles to hold as much of the delicious hot fluid in as possible before lifting yourself off the insensate incubus and sashaying towards Vapula.  You stroke the line of her jaw and gently touch her inner thigh as you begin to loosen her bonds.  She sobs with relief as you go about the task.");
		output("\n\n\"<i>Oh thank you, thank you... please do it to me now!  I've been bad, I know, I've had my punishment now and I want to be good for you, and... wait, what are you doing?</i>\"  Freed of the chains, she's only shoved onto her knees; you pin her hands behind her whilst standing over her head, and then, with a blissful sigh, release your muscles.  Vapula weeps openly as you pour an unholy mixture of demonic cum and your own juices out of your cunt");
		if(pc.hasFuckableNipples()) output(", teats, ");
		else output(" ");
		output("and ass onto her, the copious tainted seed mixing with her tears.  Once it's all gone you wipe yourself with her hair, hoist her back into position and lash the restraints back into place.  Frankly, the process and the sight of her have made you even more turned on.  You lick your lips and turn back to the subdued demonic horde at your disposal.");
		output("\n\nWithout a word, you mercilessly fuck every demon you can lay your hands on, riding faces, sucking manpoles dry with your insatiable holes, pumping more and more spooge onto Vapula with your grasping hands and pussy.  The various demons in your power appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously milk them; instead, they moan like the bunch of bitches they truly are, letting their mistress know what a beta female she is in comparison to you.  You repeat the shower once, twice, thrice; by the end Vapula's hair is a sopping mat of white.");
		output("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done working the last untouched cock in the pit, when your [pc.vagina] is done squirting its ultimate drop of fluid over a wanton succubus, you relax.  Your gaping cunt aches pleasantly and you have no further use of any broken toy in the pit.  All but one...");
		output("\n\nWhen you walk up to Vapula, she is barely recognizable.  Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		output("\n\nA few meters away, outside the pit, you notice your possessions. The village appears to be deserted. Considering these demons will have a hard time threatening anyone with white goo oozing out of their absurdly milked urethras, you let them rest, wallowing in their pool of mixed spunk.  You pick up your belongings and head back to camp.");
		//+med-high corruption, + strength/cons, -10 libido, slimefeed, imp preg check
		pc.loadInCunt(enemy);
		pc.loadInAss(enemy);
	}
	//PC is redirected to camp, next morning. No nightly camp scenes. 
	pc.slowStatGain("p", 1);
	pc.slowStatGain("l", -4);
	pc.slowStatGain("w", 0.5);
	pc.cor(4);
	processTime(2 * 60 + rand(60));
	pc.orgasm();
	CombatManager.genericVictory();
}

//Pit (Z)
private function zePit():void {
	clearOutput();
	output("You announce to all the villagers present that you're going to guard the pit as well as the village's entrance against the demons, trusting them to spread the news; they seem glad that you took this initiative on your own.  Checking your equipment, you head toward the pit, ready to stand your ground against the lewd horde.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss/Victory scenes as usual.
	clearMenu();
	addButton(0, "Next", intoTheDemonPit, false);
}

//Option: Face Down the World (Z)
private function faceDownHordes():void {
	clearOutput();
	output("You tell Rebecc to go hide on the plains; you're going to handle the villagers as well as the demon horde on your own.  She cries, \"<i>But [pc.name]!  You stand no chance against this ruthless horde!  Besides, the villagers won't trust you.  They'll think you want to cheat them... they'll tie you up to prevent you from getting away!</i>\"");
	output("\n\nYou tell her not to worry and before her whining protestations can begin, you're already marching toward the village.  As you walk between the tiny houses, people keep staring at you with hostile or even despising eyes.  Some start following you as you walk to the pit, ignoring all the whispers and rumours rumbling about you.  When you're finally standing before the pole, with the whole town gathered around you, you speak in a loud, clear voice.");
	output("\n\n\"<i>It is unfair that a young innocent woman should suffer from the cowardice of her townsfolk.  Since you are all too reluctant to defend her yourselves, I'll do it for you.  Don't worry, you meek sheep.  No demon will abuse your kind on my watch.</i>\"  You then ready yourself in a combat stance and wait.");
	output("\n\nThe villagers keep staring at you, defiance as well as cautiousness reflected in their pondering eyes.  Caution wins out and they leave you, abandoning to your fate - and the horde.  It's time for you to prove your worth.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss sets Submissiveness to 100 and gives Bad End.  Victory sets Attitude to 60 and it can never shrink below 1.
	clearMenu();
	addButton(0, "Next", intoTheDemonPit, false);
}

//Slave to Vapula - Bad End (Z)
private function slaveToVapulaBadEnd():void {
	clearOutput();
	//[Displayed if Vapula Submissiveness reaches 100]
	output("When you wake up, you find yourself tied and gagged in a strange cave.  A pair of smelly red fruits dangle before your eyes, dripping sap.  Chattering and moaning sounds come from everywhere, and your crotch feels numb.  You come back to your senses and realize your mouth is full of cock - the red 'fruits' are actually an imp's balls, and the 'sap' the drippings of a pussy just behind them!  You struggle to remove the rod of dickflesh but there's not much you can do, bound as you are.  Your constant writhing only makes the hermaphrodite imp harder and she grabs a fistful of your hair as she cums, hard.  Her balls shrink even as the sticky vaginal wetness running along their underside swells, and you can feel the veins in her dong pulsate as she unloads an enormous deposit of spooge in your throat; you are forced to swallow the unnaturally hot globs just to clear room to breathe.  Gods, it is so humiliating... yet, somehow, it's also strangely habit-forming.  Each gulp is easier than the last.  You hear an inhuman snicker as the shaft is pulled out, wiped clean of any residual cum by your lips.  The glittering pair of balls is removed from your sight as the imp is pushed aside.");
	output("\n\n\"<i>Sooo... my little pet has just woken up.  Are you done gobbling cock yet?</i>\"");
	output("\n\nYou sit up uncomfortably, only to see two succubi caressing your crotch and another imp gently licking your [pc.asshole]; your vision is suddenly masked by a pair of gratuitous, squishy lips.  They squeeze your own, literally tongue-fucking your mouth.  You abandon yourself to the sweet kiss before recognizing the face behind these gorgeous lips: this is Vapula, the vicious dominatrix from the demon horde!");
	output("\"<i>Hmm, so tasty... so tender.  You will make an excellent fuck-pet.</i>\"  She snaps her fingers and in no time you are lifted and carried to a pole very similar to the one in the village, then quickly shackled and bound.  Before you can move, your mouth and your [pc.asshole] are already rammed with towering fuck-sticks.  You flutter and tremble, unable to control your body under the intense pleasure you're receiving.  You squirm, you writhe; all you want is more cock to fill you, more cum to be injected in your body.  It feels so right... so powerful to be used like that.  In the back of your mind you see Vapula shuffling the contents of several vials together, preparing some kind of boiling orange mixture.  These rational thoughts are however quickly replaced with dreams of more dickflesh stuffing your insides.");
	output("\n\nThe captivating purple succubus approaches you in a sexy manner, doing her best to display her wondrous curves, her appreciable tits and her drooling pussy.  With a disarming smirk, she holds up the vial with her mixture, shaking it before your eyes.");
	output("\n\n\"<i>Enough.  Remove that dick from my pet's mouth, I want to talk to " + pc.mf("him", "her") + " for a second.</i>\"");
	output("\n\nYou gasp for air as the imp complies to his mistress's orders, withdrawing his monstrous member to jerk it with his hand instead.");
	output("\n\n\"<i>You liked that, didn't you?  I know you did.  Now, you'd better listen to my offer, as it is probably the last question you'll ever have to answer in your new life as a dicksleeve.  Do you want to be a permanent cock-slut?  Do you want to be transformed into a whore, even hungrier for cum than you actually are?  Do you want your every hole to be pumped with more spunk that you'll ever dream of?  Speak, bitch!</i>\"");
	output("\n\nWith a violent thrust, the cock ramming your [pc.asshole] shoves you into Vapula's arms; you bounce off her delightful tits but she holds you tight, forcibly locking you into an unholy embrace.  Unable to see anything but a pair of voluminous breasts and your nose being impregnated with the sweet, entrancing scent of the succubus' aura, you stare blankly at her, then give the slightest tremble of a nod.");
	output("\n\n\"<i>What?  I didn't hear you.  Do you want to have more sex in one hour than some people will ever have in their lifetime?  Do you want your future to be filled with pussy, cock, and boobs?  Do you want it?</i>\"");
	output("\n\nYou finally pull your head back from her bosom and manage to mutter a feeble \"<i>Y-yes...</i>\"");
	output("\n\n\"<i>What?  I can't hear you.  Say it!  Say it aloud!</i>\"");
	output("\n\n\"<i>Yes...</i>\"");
	output("\n\n\"<i>Yes what?  Say it!  Say that you want to be my personal cumslut!  Do it!  I want everyone to know that you're willing to be a cum-slave forever!</i>\"");
	output("\n\n\"<i>Yes!  YES!  Mistress Vapula, please take me as your slut!  I'm your plaything, your toy!  Please use me in any way you like!  I want nothing more in life than a nice cock in my hole and a drooling pussy to please!  I need cum!  I'm so horny I think my ass is going to explode!</i>\"");
	output("\n\nThese spontaneous, dirty words make the imp fucking you from behind instantly cum; with a powerful last push, he blasts you with his seed, filling and soaking your backside with thick white goo.  You reach for Vapula, helplessly hugging her tits and suckling her nipples as you sob in pleasure-induced humiliation.");
	output("\n\n\"<i>Very well, slut.  Your former life as a villager is over.  It's time to move on to your new life; and trust me, it's going to be much more exciting.  Actually, I don't think you'll be willing to ever leave this place...</i>\"");
	output("\n\nYou furiously nod in approval.");
	badEnd();
}

//Subdue Vapula Scene - begins Vapula Follower Content(Z)
//[Triggered if submissiveness reaches 0 when beating the horde.] 
private function subdueVapula():void {
	clearOutput();
	pc.removeStatusEffect("Disarmed");
	
	output("At last, the final demon falls, ");
	if(enemy.HP() <= 1) output("overwhelmed by your might");
	else output("rendered insensate by his own lust");
	output(".  As usual, you walk among the forlorn bodies of your enemies.  Vapula is groveling on the floor again, looking up to you with imploring eyes.  Even beaten and broken, the luscious succubus remains the most preeminent figure of the motley rabble.");
	output("\n\nYou grip her by the shoulders and stare at her, asserting your dominance.  Your vanquished foe casts her gaze down but maintains eye contact; she looks solemn and reflective, probably knowing that her fate will depend on your next decision.");
	output("\n\nBy now, you've completely broken the back of the rapacious demon horde.  Their leader is starting to get used to her repeated defeats; it's time for you to make a decision... what do you do?\n\n");
	//choices: [Disband the horde]/[Enslave Vapula(requires cock or non-centaur vagina, D2 completion, libido >= 60, and corr >= 70)]
	
	addButton(0, "Disband", disbandHorde);
	
	addDisabledButton(1, "JustFuckEm", "Just Fuck Them", "This scene requires you to have genitals and sufficient arousal.");
	addDisabledButton(2, "EnslaveVapula", "Enslave Vapula", "This option requires you to have genitals, sufficient arousal and enough corruption.")
	
	if (pc.hasGenitals() && pc.lust() >= 33) addButton(1, "JustFuckEm", rapeZeVapula);
	if (pc.hasGenitals() && pc.cor() >= 66) addButton(2, "EnslaveVapula", enslaveVapulaWithYourWang);
	
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); } );
}

//Option: Disband (Z)
private function disbandHorde():void {
	clearOutput();
	output("You start speaking in a calm, measured voice.  \"<i>Here we are again.  I cannot count how often we've been in this same situation: you struggling before me, powerless.  How often do you need to be reminded your place?  Back off.  We don't want your kind here.  Go find some other prey; fuck each other for all I care.  Just stop bothering us.  If I see you or your minions hanging around this village again, you will regret it.  All of you.</i>\"");
	
	output("\n\nHer eyes are progressively filling with fear as you deliver your ultimatum, conscious of finding someone with more power than her.  She squirms uncomfortably in your grasp and nods feebly.");
	output("\n\nYou give the wanton succubus a loud slap for good measure and discard her.");
	output("\n\n\"<i>Begone.  Leave, all of you.  Out of my sight.</i>\"");
	output("\n\nShe nods again in acknowledgement and starts shaking her pets out of their torpor.  The imps quickly awaken each other, giving you a few frightened glances every now and then.  Then, a bit pathetically, Vapula gives the retreat signal.  In no time the once-proud bunch disappears, probably gone for good.  Hopefully, the demons have learned from their mistakes and won't bother the village again.\n\n");
	//Attitude set to 100
	flags["COC.OWCAS_ATTITUDE"] = 100;
	flags["COC.OWCA_SACRIFICE_DISABLED"] = 1;
	CombatManager.genericVictory();
}

//Option: Enslave - penis version (requires D2 completion and libido >= 60 and corr >= 70) (Z)
private function enslaveVapulaWithYourWang():void {
	clearOutput();
	if(!pc.hasCock()) {
		enslaveVapulaAsACuntWielder();
		return;
	}
	
	output("You speak in a feverish voice.  \"<i>You're such a bitch.  Damn, why did you ever think you were going to make me your slut?  How many times do you need to be shown that I'm not the bottom in our relationship?  You deserve to be turned in to Lethice so she can make you her personal fuck-toy; at least you'll remember your place.</i>\"");
	output("\n\nAs soon as you mention the name of the demon queen, the struggling woman in your grasp recoils, her purple eyes widening in fright.  She whimpers, terrified, \"<i>Please don't!  You don't know her!  She's going to kill me, or worse!  She hates me!  If you do this, she will... she will...</i>\"  Her voice breaks as she keeps muttering unintelligible words, half-paralyzed in horror.");
	output("\n\n\"<i>So you're a renegade, huh?  Very interesting.  I guess that's why a proud succubus is now forced to rely on marauding and scavenging.  But surely it wasn't Lethice who forced you to gang-rape a villager every week, right?</i>\"");
	output("\n\n\"<i>W-we had a reputation to maintain... what would people think if we behaved?  We were just having a little bit of fun, it didn't harm anyone.  I bet they all enjoyed it even if they won't admit it... fuck, it's in our nature to have sex with everyone. You can't change us.</i>\"");
	output("\n\nYou laugh at her in derision.  \"<i>At least you have the merit to acknowledge you're nothing more than a cock-hungry slut.  It would be a shame to waste such a body, you know.  You're going to be my slut!  It wouldn't change much from your ordinary life as a sex-horny bitch.  It's that or Lethice.</i>\"");
	output("\n\nThe succubus's eyes widen.  \"<i>Champion, I want nothing more than to please you!  Please take me!  Just... don't abandon me to her.  I'll do things to your genitals you cannot even conceive of.  We will both literally drown in cum.  You will scream in pleasure.  Please take me, you won't regret it!</i>\"");
	output("\n\n\"<i>Very well; I'm sure we will both have a lot of fun.  Tell your minions to go away, I don't want their kind.</i>\"");
	output("\n\n\"<i>Champion, they will likely follow regardless.  Of course, they will be too afraid to bother you... but expect them to hang around your camp.</i>\"");
	output("\n\n\"<i>As long as they don't disturb me while I fuck your brains out, I don't care.</i>\"");
	output("\n\nYou lend a hand to your newly-acquired succubus slut and help her to her feet.  She stumbles at first, still stunned by the recent fight; she quickly follows you though, firmly lead by your iron grip.  Hand in hand, you walk away from the pit and the scattered bodies without a look back.  On your way to the camp, you don't hesitate to give your succubus toy a few gropes to her boobs and buttocks, making her giggle; she playfully returns the favor, and by the time you reach your camp you are already stroking each other's crotches, your fingers softly probing her vaginal entrance until she openly moans in delight.  You stop teasing her and dismiss her at last.");
	output("\n\n(<b>The demon Vapula has been added to your slaves.</b>)");
	//[Vapula added as follwer.]
	flags["COC.VAPULA_FOLLOWER"] = 1;
	flags["COC.OWCAS_ATTITUDE"] = 100;
	flags["COC.VAPULA_HAREM_FUCK"] = 1;
	flags["COC.OWCA_SACRIFICE_DISABLED"] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	//Attitude set to 100, sacrifices will never be asked again. Lust set to 80 if below.
	if(pc.lust() < 80) pc.lust(80, true);
	CombatManager.genericVictory();
}

//Option: Enslave - vagina version (requires D2 completion and libido >= 60 and corr >= 70 and, apparently, no centaurs)(Z)
//NOTE: No Centaurs. Fuck Centaurs.
private function enslaveVapulaAsACuntWielder():void {
	clearOutput();
	output("You speak in a feverish voice.  \"<i>You're such a bitch.  Damn, why did you ever think you were going to make me your slut?  How many times do you need to be shown that I'm not the bottom in our relationship?  You deserve to be turned in to Lethice so she can make you her personal fuck-toy; at least you'll remember your place.</i>\"");
	output("\n\nAs soon as you mention the name of the demon lord, the struggling woman in your grasp recoils, her purple eyes widening in fright.  She whimpers, terrified, \"<i>Please don't!  You don't know her!  She's going to kill me, or worse!  She hates me!  If you do this, she will... she will...</i>\"  Her voice breaks as she keeps muttering unintelligible words, half-paralyzed in horror.");
	output("\n\n\"<i>So you're a renegade, huh?  Very interesting.  I guess that's why a proud succubus is now forced to rely on marauding and scavenging.  But surely it wasn't Lethice who forced you to gang-rape a villager every week, right?</i>\"");
	output("\n\n\"<i>W-we had a reputation to maintain... what would people think if we behaved?  We were just having a little bit of fun, it didn't harm anyone.  I bet they all enjoyed it even if they won't admit it... fuck, it's in our nature to have sex with everyone. You can't change us.</i>\"");
	output("\n\nYou laugh at her in derision.  \"<i>At least you have the merit to acknowledge you're nothing more than a cock-hungry slut.  It would be a shame to waste such a body, you know.  You're going to  be my slut!  It wouldn't change much from your ordinary life as a sex-horny bitch.  It's that or Lethice.</i>\"");
	output("\n\nVapula's face lights up with desire at first... but her evident arousal trades with cringing fear and doubt as you finish.  She struggles with herself for a moment, then speaks.");
	output("\n\n\"<i>Ch-champion, I want nothing more than to please you, I want to lick every inch of you, but... I'm a succubus.  I need manjuice to live and you don't... you know... have the right equipment.</i>\"  She giggles nervously.  \"<i>If you let me bring my servants, or if you have other toys I could milk, then...</i>\"  She trails off as she catches your expression.");
	output("\n\n\"<i>That isn't good enough, slut.  Why would I want to own you if all you're going to do is suck off other worthless bitches?  So I can smell cock on your breath when I'm making you squeal?  Think again.</i>\"");
	output("\n\n\"<i>I- wait!  Please don't hand me in to Lethice!</i>\" Vapula wails.  \"<i>I can work something out!  Just, just give me a bit of time!</i>\"");
	output("\n\nYou leave her hanging for a moment, then give her a curt nod.  \"<i>Go, then.  Don't forget who owns you now, slut.  If you betray my confidence in you, I will hunt you down and make you wish I gave you in to Lethice.</i>\"");
	output("\n\nVapula wags her head, ecstatic with relief; she quickly stumbles to her feet and scurries off, pushing through her defeated horde as if they weren't there.  You watch her bouncing ass, wondering if it was a wise thing to trust a demon.  You suppose it's no skin off your nose if she doesn't come back, but there is no doubting the attraction of being able to dig into that luscious body of hers whenever you want.  You shrug and slowly make your way back to camp, absentmindedly kicking a comatose imp out of the way as you do.");
	//[QUE VAPULA NIGHT MEETING]
	flags["COC.VAPULA_FOLLOWER"] = .5;
	//VILLAGE LOVES YOU + NO MORE SACRIFICES
	flags["COC.OWCAS_ATTITUDE"] = 100;
	flags["COC.OWCA_SACRIFICE_DISABLED"] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	CombatManager.genericVictory();
}