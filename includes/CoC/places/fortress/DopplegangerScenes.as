import classes.Characters.CoC.CoCDoppleganger;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function getDemGlasses():void
{
	clearOutput();
	output("You step into the room and move across to the optician stand. The metal door clicks shut behind you. A feeling of unease grows in your gut as you walk further into the room; the place seems gloomier and larger than it did from the door. You almost jump out of your skin as somebody suddenly emerges to your right- but of course it’s just you, reflected in the intricately decorated, oval-shaped mirror which centers the room. You smile at your own silliness, before watching your expression change to a frown. You seem very sharply focused in it; the room behind you barely seems there at all. Some kind of enchantment to refine a demon’s appearance, you guess.");

	output("\n\nYou turn away and head over to the upright display of dark shades, pulling a pair out of their indents. They are completely reflective on the side facing away from your eyes, and the word 'Laybans' is engraved down one arm. Whatever they are used for, you know one thing for certain: you are going to look ice cool wearing them. Pleased, you turn back towards the door- and get a start. Was the standing mirror facing this way when you came in here? Maybe it is double sided, but... you grin uneasily at your own reflection. It grins back. It looks a great deal more confident than you think your smile should look, given the circumstances. You find it difficult to look away now you are confronted with a clear, full length image of what you look like; for so long now you’ve relied on the vague, faltering surface of the stream near your camp it’s almost startling to be given such a clear picture of yourself.");
	if (pc.humanScore() > 4) {
		output("  It is honestly surprising, given everything you have encountered since you stepped through that portal what seems years ago, that you are still recognizably human. You wonder if your parents would be able to recognize the battle-hardened " + pc.mf("man", "woman"));
		if(pc.hasArmor()) output(" clad in " + pc.mf("his", "her") +" [pc.armor]");
		output(" standing in front of you to be the wide-eyed youth they bade their heartfelt goodbyes to all that time ago, though.");
	}
	else output("  The last time you looked into such a sharp reflection you were human; a pang of regret steals through you as you consider probably not even your parents would be able to recognize the strange "+ pc.race() +" clad in "+ pc.mf("his", "her") +" [pc.gear] standing in front of you now.");

	output("\n\nYou continue to stare at yourself, transfixed. The image is so vivid, and yet you cannot shake the feeling that it isn’t really you - the more you look, the more you pick out details which don’t seem right. It has to be you, right? But do you really look that intense? Where did that wild look in your eye come from? Unreality washes over you as the mirror and the room seem to swim. Everything is vague except your image in the mirror, still staring back at you, seeming to move independently of you, perspective causing it to bend and distort bizarrely. When the image’s mouth splits into a grin, opens and speaks whilst yours remains shut, it is no longer surprising. It is not you.");

	output("\n\n“<i>I was expecting an imp,</i>” it says. The voice sounds like it is coming from some distance away, but a cold sensation spreads itself over your shoulders as you recognize it. It’s what you would sound like to someone standing a couple of rooms away from you. It looks down and clenches your... <i>" + pc.mf("his", "her") + "</i> fists with an expression of wild wonder, before turning " + pc.mf("his", "her") +" eyes back to you. “<i>That would be the fitting thing, wouldn’t it? Robbed of my form by Lethice, bound to a glass prison for a decade, forced to seize and use the first thing stupid enough to be transfixed by it. It would have to be an imp, wouldn’t it? But this...</i>” The doppelganger walks slowly towards you, " + pc.mf("his", "her") +" voice, your voice heard through a bottleneck of madness, getting louder all the time. As " + pc.mf("he", "she") +" comes " + pc.mf("he", "she") +" stretches " + pc.mf("his", "her") +" limbs luxuriously, examining the form " + pc.mf("he", "she") +" has stolen, running " + pc.mf("his", "her") +" hands down your trunk to touch the top of your [pc.hips], marvelling. You feel violated in a way you never thought possible. “<i>... This, I could get used to. This, I could use. Who are you?</i>”");

	output("\n\nRight at the front of the mirror now, "+ pc.mf("he", "she") +" flicks "+ pc.mf("his", "her") +" borrowed fingers at the air, as if coaxing the answer out of it. As "+ pc.mf("he", "she") +" does so, "+ pc.mf("he", "she") +" casually steps through the surface of the mirror, as if it were an open window. The feeling of unreality intensifies; you can’t shake the sensation of being mired in vagueness, at how vivid the mirror demon looks in comparison to how you feel.");

	output("\n\n“<i>[pc.name]. There we go. Not what I would choose to describe this business...</i>” " + pc.mf("he", "she") +" pats " + pc.mf("his", "her") +" [pc.butt] mockingly, “<i>but then I’m not you, right? Not yet, anyway.</i>” " + pc.mf("He", "She") +" laughs, suddenly, madly, and you cringe inwardly. It is what you would sound like if you were completely, utterly insane.");
	output("\n\n“<i>Do you know what it is like to spend ten years without a form? To spend ten years imitating an empty room? Well, don’t worry, [pc.name]. When I have taken your place and bound you to this thing I’ll make sure to put it somewhere nice and busy, so you will never have to know that torment!</i>” " + pc.mf("He", "She") +" draws the mirror image of your [pc.mainWeapon] and advances upon you, your own features hiked into a rictus of madness.");
	output("\n\nYou must fight yourself!");
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCDoppleganger());
	CombatManager.victoryScene(punchYourselfInTheBalls);
	CombatManager.lossScene(inSovietCoCSelfFucksYou);
	CombatManager.displayLocation("\nDOPPELGANGER");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function punchYourselfInTheBalls():void
{
	flags["COC.D3_DOPPLEGANGER_DEFEATED"] = 1;
	pc.createKeyItem("Laybans", 0, 0, 0, 0, "Protective glasses, effective against basilisks.");
	
	clearOutput();
	output("The doppelganger falls to the floor, sobbing and broken. For one long moment you feel the nagging pull to exactly replicate [pc.hisHer] actions... and then it’s gone. The world comes back sharply into focus. You have won.");

	output("\n\n“<i>No...</i>” your mirror image snivels in front of you. “<i>Ten years, ten years I waited for this. You can’t put me back in there, you can’t!</i>” You gaze down at what you look like when you are defeated: mouth open, eyes glazed, " + pc.hairDescript() + " muddled, your flesh trembling and clenching, the very picture of a bitch awaiting further subjugation. No wonder 90% of Mareth is so keen on wanting to make this sight happen. The doppelganger chances a look up, catches your expression, and freezes. “<i>You... you wouldn’t.</i>”");
	
	clearMenu();
	addDisabledButton(0, "Oh Really?", "Oh Really?", "This scene requires you to have genitals and not to be 'taur.");
	if (!pc.isTaur() && (pc.hasCock() || pc.hasVagina())) addButton(0, "Oh Really?", fuckYourself);
	addButton(1, "End It", killYourself)
}

public function fuckYourself():void
{
	clearOutput();
	output("This, you feel, is an opportunity which is not likely to arise again.");
	
	if (pc.cockVirgin && pc.hasCock() || pc.vaginalVirgin && pc.hasVagina()) output("  You smile widely at your clone as you undress. Now neither of you will be virgins.");
	else output("  You smile widely at your clone as you begin to shake off your [pc.gear].");
	output("  [pc.heShe] moans lowly in miserable disbelief, but [pc.heShe]’s not capable of resisting you as, butt naked, you sit yourself down and methodically repeat the action, sliding your hands over and into [pc.hisHer] replicated clothing, finding [pc.hisHer] warm flesh, clutching and testing it curiously. Obviously you’ve laid your fingers upon this many times before, but touching it now second hand causes an emotion you cannot name to rise in your breast. Is this getting you hot? Yes. In the strangest, most perverse way imaginable, it is.");
	
	if (!pc.hasGenitals())
	{
		output("\n\nStrangely, the more you think about fucking this strange creature, the hotter your groin becomes. In moments, you find your fingers pushing against a dampening slit with feather-light caresses. <b>Somehow this place's magic has given you a vagina to match your duplicate!</b> You pull away with a shuddering breath and marvel at the glittering wetness oozing down your fingertips. This is going to be fun.");
		pc.createVagina();
	}
	if (pc.hasCock() && !pc.hasVagina())
	{
		output("\n\nYou turn the mirror demon’s wild stare and ragged breath away from you, laying a comforting but firm hand upon [pc.hisHer] shoulder as, grinning, you lower your eyes to [pc.hisHer] [pc.butt]. Nice.");
		if (pc.isNaga()) output("  You sigh at the smooth, pleasurable feeling of your scales rubbing over each other as you sensuously wind yourself around [pc.hisHer] tail until you are tightly bound together. Twin lithe snake boys wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and [pc.heShe] groans raggedly in response.");
		else if (pc.isDrider()) output("  The tangle of spindly legs in front of you initially puts you off, but then your arachnid instincts take over and you find yourself eagerly clambering onto [pc.hisHer] bulging back before you know it, your hardening dick pressing against the human softness which rises above the gleaming chitin as your monstrous body presses heavily down onto its mirror counterpart, making [pc.himHer] groan raggedly.");
		else if (pc.hasFur() && pc.hasTail()) output("  You clamber on top of [pc.himHer], the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your hardening dick presses against [pc.hisHer] [pc.tail] and [pc.heShe] groans raggedly in response.");
		else output("  You clamber on top of [pc.himHer], enjoying the give and take of [pc.hisHer] [pc.skinFurScales] as you lock your [pc.hips] around their mirror counterparts, making [pc.himHer] groan raggedly in response.");

		output("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bastard even are you?</i>“");

		output("\n\n“<i>Oh, shut up,</i>” you reply breezily. The movement of your [pc.skinFurScalesNoun] against [pc.hisHer] has kindled your arousal, and you push your [pc.cockBiggest] between [pc.hisHer] butt cheeks, hardening even further with the pleasurable motion. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” There’s no lubricant available at all.");
		if (pc.ass.wetness() >= 2) output("  No problem for a clone of you, though. You sigh as you push your bulging head against [pc.hisHer] rose, easily opening [pc.himHer] and pushing deep into [pc.hisHer] oily, pliable depths.");
		else output("  Well, tough. [pc.heShe] is a demon, after all. You sigh as you push your [pc.cockHeadBiggest] against [pc.hisHer] rose, slowly working it loose with the repetitive, pleasurable motion until [pc.heShe] finally relaxes enough for you to push into [pc.hisHer] warm, tight depths.");

		output("\n\nYou go slowly, enjoying the warmth and syncopated clenching of the mirror demon’s tunnel at leisure. Although [pc.heShe] is initially frozen with sheer disbelief the need to relax in order to take your insistent [pc.cockBiggest] softens [pc.himHer] up, moving [pc.himHer] in time with your thrusting. [pc.heShe] moans from a combination of misery and intensity of the sensation you’re pushing upon [pc.himHer].");
		if (pc.hasPerk("Marae's Gift: Buttslut")) output("  You glory in your own decision to transform into an eager butt slut; the doppelganger’s back passage is tight, warm butter, accepting and clenching around your bulging prick like the perfect little boypussy you know it to be.");
		output("  Now that you’re locked into your defeated clone you feel no real wish to cause [pc.himHer] pain. Indeed, as you lose yourself to the rhythm to the slow, tight, gradual sex a desire to force [pc.himHer] to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");
		
		output("\n\nYou hook an arm around [pc.hisHer] shoulder and let your fingers graze one of [pc.hisHer] nipples teasingly. [pc.heShe] gasps, [pc.hisHer] sphincter tightening up around your [pc.cockBiggest] delightfully.");

		output("\n\n“<i>Don’t- don’t do that,</i>” [pc.heShe] rasps. “<i>Fuck me if you must, but please...</i>“ ignoring [pc.himHer] with silent glee, you touch [pc.hisHer] other nipple, this time rubbing it gently in concentric circles until it is "+ (!pc.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") + ", before going to work on the other one, sliding in and out of [pc.hisHer] contracting warmth all the while. As you continue to tease [pc.himHer] you let your other hand slide down [pc.hisHer] abdomen, remorselessly leading down until your fingertips touch [pc.hisHer] semi-erect [pc.cockBiggest].");

		output("\n\nAs you do [pc.heShe] makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

		output("\n\nYou wrap your hand around the mirror image of the girth which is currently wedged in your partner’s rear, gripping tight and then softening, slowly rolling your wrist as you repeat the motion, knowing exactly how to work the prick in your hand to make it bulging hard. [pc.heShe] arches [pc.hisHer] back to the sensation, [pc.hisHer] smooth muscle pushing into your [pc.chest] as [pc.heShe] whimpers.");

		output("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold [pc.himHer] close, your fingers still on [pc.hisHer] [pc.nipples] as you withdraw almost all the way out before thrusting your hips into [pc.himHer] hard, holstering your whole length into [pc.hisHer] warmth, making [pc.himHer] cry out with that same delicious cadence as you touch something deep. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

		output("\n\n“<i>Let me guess,</i>” you breathe into [pc.hisHer] ear, as you make your hand go soft and hard, soft and hard around [pc.hisHer] urgently erect penis. “<i>Lethice made it so that even if you did manage to crawl out here, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, move smoothly at first as you enjoy [pc.hisHer] tight tunnel before finally unleashing your own urge, your [pc.hips] clapping into [pc.hisHer] [pc.butt] as you hold [pc.hisHer] hot, tautening body close, jerking [pc.hisHer] bulging prick with curt, cramped flicks of the wrist. You push into [pc.hisHer] prostate, milking [pc.himHer] ruthlessly and [pc.heShe] cries out, trying now to pull away from you but far too weak to do it. Your flesh imprisons [pc.himHer] doubly and you force sensation upon [pc.himHer] from every direction you can, your [pc.cockBiggest] thrusting into the clenching passage you’ve made your own, one hand flicking at [pc.hisHer] needily erect/beading nipple, the other stroking [pc.hisHer] sensitive prick, relentlessly pulling [pc.himHer] with you to a shared high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone pangs. The doppelganger no longer struggles, can’t even find words anymore; [pc.heShe] just barks and groans in helpless pleasure as you use every tight, warm inch of [pc.himHer].");

		output("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, seed rising in your loins. “<i>Ten minutes after stealing it, and you’re its true owner’s boy-slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>”");

		output("\n\nYou bury as much of yourself into [pc.himHer] as you can, driving your bulging length over [pc.hisHer] prostate as you tense, open wide and surge line after line of cum into [pc.hisHer] tunnel. Your mirror image howls, finding a note you never knew your vocal chords could reach as [pc.heShe] thrashes back into you, [pc.hisHer] [pc.hair] flapping into your face as [pc.heShe] orgasms in tandem.");
		if (pc.cumQ() >= 1000) output(" You know exactly what to expect; [pc.hisHer] over-clocked physiology makes [pc.himHer] a veritable [pc.cumNoun] fountain. As you ride your high, pumping [pc.hisHer] guts full of your warm seed [pc.heShe] spurts geysers of [pc.cum] the length of [pc.hisHer] body onto the floor, wailing at the sheer size of the high owning your body forces [pc.himHer] to feel. You sit astride [pc.himHer], admiring and exulting in it at the same time.");
		else output("  You ride your high, pumping [pc.hisHer] guts full of your warm seed as you force [pc.himHer] along with you, guttering [pc.cum] on the floor in front of you.");

		output("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you bury yourself one last time into your defeated buttslut- and then stagger forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced [pc.himHer] to create. Except that’s not there anymore, either. All that you are suddenly left with is you, your oozing, gently aching [pc.cockBiggest], and a great deal of broken glass lying in front of you. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could be in any way an object of dread- indeed, standing here naked in this shabby storage room, you feel more than a little ridiculous. Was this all just a really weird fugue? Well, whatever just happened, there’s no mistaking the warm fuzz of deepest sexual satisfaction. Shaking your head you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
	}
	else if (pc.hasCock() && pc.hasVagina())
	{
		output("\n\nYour gaze drops from the mirror demon’s wild stare, down to [pc.hisHer] [pc.chest]. Nice. You lay a comforting but firm hand upon [pc.hisHer] shoulder as you sink down on top of your clone, your own [pc.chest] pushing into " + pc.mf("his", "hers") + ", your hardening [pc.cockBiggest] pressing and rubbing impatiently against its supple, turgid clone. You find yourself intensely aware of every sensation- exactly how your perverse, hermaphroditic body feels to your own touch.");
		if (pc.isNaga()) output("  You sigh at the smooth, pleasurable feeling of your scales rubbing over each other as you sensuously wind yourself around [pc.hisHer] tail until you are tightly bound together. Twin lithe snake futa wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and [pc.heShe] groans raggedly in response.");
		if (pc.isDrider()) output("  For a moment you consider mounting [pc.himHer] from behind, allowing your monstrous instincts to take over and fuck [pc.hisHer] ovipositor in a deathly arachnid craze, but the tangle of spindly legs in front of you puts you off. Better to do it face-to-face. You want to drink in your mirror image’s every reaction. Your prick pressing against the human softness which rises above [pc.hisHer] gleaming chitin as your body presses heavily down onto its mirror counterpart, making [pc.himHer] groan raggedly.");
		if (pc.hasFur() && pc.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) output("  You clamber on top of [pc.himHer], the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your dick presses into [pc.hisHer] digitigrade thigh and [pc.heShe] groans raggedly in response.");
		else output(" You clamber on top of [pc.himHer], enjoying the give and take of [pc.hisHer] [pc.skinFurScales] as you lock your [pc.hips] around their mirror counterparts, making [pc.himHer] groan raggedly in response.");

		output("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bitch are you?</i>\"");

		output("\n\n“<i>Oh, shut up,</i>” you reply breezily. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” You roll [pc.hisHer] [pc.hips], [pc.hisHer] cock");
		if (pc.cocks.length > 1) output("s");
		output(" batting back into [pc.hisHer] stomach as you expose [pc.hisHer] [pc.vagina], ");
		if (pc.highestWetness() < 3) output(" gleaming invitingly");
		else output(" drooling lubricant eagerly");
		output("- as you knew it would be. You glory in your decision to transform yourself so that you could enjoy the best of both genders. If this isn’t clear vindication of being a hermaphrodite, what is? Your doppelganger wriggles and whines but can’t resist as you push your bulging head against [pc.hisHer] pussy, slowly pushing [pc.hisHer] oily lips wide and into [pc.hisHer] warm, tight depths.");

		output("\n\nYou go slowly, enjoying the warmth and syncopated clenching of the mirror demon’s juicy cunt at leisure.");
		if (pc.hasVirginVagina()) output("  You grunt as something gives in front of your cock and the doppelganger gasps and tightens up in momentary pain. Looking down at your withdrawing cock, you see spots of blood mingling with the demon’s wet. Dreamily you consider that, having somehow managed to experience taking your own virginity, whether there’s anyone else in the world it’s worth gifting that sensation to.");
		output("  Although [pc.heShe] is initially frozen with sheer disbelief the need to relax in order to take your insistent [pc.cockBiggest] softens the doppelganger up, moving [pc.himHer] in time with your thrusting. [pc.heShe] moans in a combination of defeated misery and from the intensity of the sensation you’re pushing upon [pc.himHer], your dick smoothing against [pc.hisHer] [pc.clit] as you extend and recede. Now you’re locked into your defeated clone you feel no real wish to cause [pc.himHer] pain; indeed, as you lose yourself to the rhythm of the slow, sensual missionary a desire to force [pc.himHer] to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");

		output("\n\nYou place your palm upon [pc.hisHer] ribs, sliding slowly upwards, enjoying the give and take of [pc.hisHer] heaving flesh before letting your fingers graze across one of [pc.hisHer] nipples teasingly. [pc.heShe] gasps, [pc.hisHer] pussy tightening up around your [pc.cockBiggest] delightfully.");

		output("\n\n“<i>Don’t- don’t do that,</i>” [pc.heShe] rasps. “<i>Take your satisfaction if you must, but please...</i>” ignoring [pc.himHer] with silent glee, you touch [pc.hisHer] other nipple, this time rubbing it gently in concentric circles until it is "+ (!pc.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") + ", before going to work on the other one, sliding in and out of [pc.hisHer] contracting warmth all the while. As you continue to tease [pc.himHer] you let your other hand slide down [pc.hisHer] abdomen, remorselessly leading down until your fingertips touch [pc.hisHer] semi-erect [pc.cockBiggest].");

		output("\n\nAs you do [pc.heShe] makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

		output("\n\nYour grin widening, you wrap your hand around the mirror image of the girth which is currently wedged in your partner’s sensitive cunt, gripping tight and then softening, slowly rolling your wrist as you repeat the motion, knowing exactly how to work the prick in your hand to make it bulging hard. [pc.heShe] arches [pc.hisHer] back to the sensation, [pc.hisHer] [pc.chest] pushing into your own flesh as [pc.heShe] whimpers.");

		output("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold [pc.himHer] close, your fingers on one hand still on [pc.hisHer] [pc.nipples] as you withdraw almost all the way out before thrusting your hips into [pc.hisHer] hard, holstering your whole length into [pc.hisHer] wet warmth, making [pc.himHer] cry out with that same delicious cadence as you touch something deep. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

		output("\n\n“<i>Let me guess,</i>” you breathe into [pc.hisHer] ear, as you make your hand go soft and hard, soft and hard around [pc.hisHer] urgently erect penis. “<i>Lethice made it so that even if you did manage to make it out, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, smoothly at first as you enjoy [pc.hisHer] long, soft tunnel, pushing deliberately into [pc.hisHer] bulging [pc.clit] before finally unleashing your own urge, your [pc.hips] clapping into hers as you hold [pc.hisHer] hot, tautening body close, jerking [pc.hisHer] bulging prick with curt, cramped flicks of the wrist. You push into [pc.hisHer] prostate, milking [pc.himHer] ruthlessly, and [pc.heShe] cries out, trying now to pull away from you but far too weak to do it. Your flesh imprisons [pc.himHer] doubly and you force sensation upon [pc.himHer] from every direction you can, your [pc.cockBiggest] thrusting into the clenching passage you’ve made your own, one hand flicking at [pc.hisHer] " + (!pc.hasFuckableNipples() ? "needily erect" : "beading nipple") + ", the other stroking [pc.hisHer] sensitive prick, relentlessly pulling [pc.himHer] with you to a twin high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone snaps. The doppelganger no longer struggles, can’t even find words anymore; [pc.heShe] just squeals and groans in helpless pleasure as you use every tight, warm inch of [pc.hisHer].");

		output("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, seed rising in your loins. “<i>Ten minutes after stealing it you’re its true owner’s futa slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>” You bury as much of yourself into [pc.himHer] as you can, driving your bulging length across [pc.hisHer] prostate as it tenses, opens wide and surges line after line of cum into [pc.hisHer] womb. Your mirror image howls, finding a note you never knew your vocal chords could reach as [pc.heShe] thrashes back into you, [pc.hisHer] " + pc.hairColor + " flapping into your face as [pc.heShe] orgasms in tandem, driven further beyond the edge of sanity with the force of a simultaneous male and female orgasm.");
		if (pc.cumQ() >= 1000) output("  You know exactly what to expect; [pc.hisHer] over-clocked physiology makes [pc.himHer] a veritable [pc.cumNoun] fountain. As you ride your high, pumping [pc.himHer] full of your warm seed [pc.heShe] spurts streams of [pc.cum] the length of [pc.hisHer] body on the floor, wailing at the sheer size of the high owning your body forces [pc.himHer] to feel. You sit astride [pc.himHer], exulting in and enjoying the sight of it at the same time.");
		else output("  You ride your high, pumping [pc.himHer] full of your warm seed as you force [pc.himHer] along with you, guttering [pc.cum] on the floor in front of you.");

		output("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you thrust one last time into your defeated clone- and then stagger forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced the doppelganger to create. Except that’s not there anymore, either- all that you are suddenly left with is you, your oozing, gently aching [pc.cockBiggest], and a great deal of broken glass. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could in any way be an object of dread- indeed, standing here naked in this shabby storage room, you feel faintly ridiculous. Was this all just a really weird fugue? There’s no mistaking the warm fuzz of deep sexual satisfaction at least. Shaking your head, you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
	}
	else if (pc.hasVagina() && !pc.hasCock())
	{
		output("\n\nYour gaze drops from the mirror demon’s wild stare, down to her [pc.chest]. Nice. You lay a comforting but firm hand upon her shoulder as you sit yourself down in front of your clone, your own [pc.chest] pushing into hers as, almost mockingly, you cuddle her.");
		if (pc.isNaga()) output("  You sigh at the smooth, pleasurable feeling of scales rubbing over each other as you sensuously wind yourself around her tail until you are tightly bound together. Twin lithe snake girls wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and she groans raggedly in response.");
		else if (pc.isDrider()) output("  You are momentarily thrown by your sixteen spindly legs tangling together, a creepy twitching maze devolving across the floor- but this is definitely the way to do it. Face-to-face. You want to drink in your mirror image’s every reaction. Your [pc.vagina] presses against the human softness which rises above her gleaming chitin as your body presses heavily into its mirror counterpart, eliciting a ragged groan.");
		else if (pc.hasFur() && pc.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) output("  You clamber on top of her, the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your [pc.vagina] presses into her digitigrade thigh and she groans raggedly in response.");
		else output("  You clamber on top of her, enjoying the give and take of her [pc.skinFurScales] as you lock your [pc.hips] around their mirror counterparts, making her groan raggedly in response.");

		output("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bitch are you?</i>”");

		output("\n\n“<i>Oh, shut up,</i>” you reply breezily. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” With your [pc.hips] wrapped around hers she cannot stop you bending her open, exposing the mirror image of your [pc.vagina],");
		if (pc.highestWetness() < 3) output(" gleaming invitingly");
		else output(" drooling lubricant eagerly");
		output(" - as you knew it would be. Your doppelganger wriggles and whines but can’t resist as you push your pussy into hers, the mirrored sex meeting with a pleasingly wet sound.");

		output("\n\nYou go slowly, enjoying your abdomens smoothing across each other and the warm wetness of the mirror demon’s juicy cunt moving over your own [pc.clit] and sensitive lips at leisure. Although she is initially frozen with sheer disbelief the need to relax in order to take your insistent sex softens the doppelganger up, moving her in time with your thrusting. She moans in a combination of defeated misery and from the intensity of the sensation you’re pushing upon her, your lips locking together and your clits gently colliding as you extend and recede. Now you’re locked againstinto your defeated clone you feel no real wish to cause her pain; indeed, as you lose yourself to the rhythm of the slow, sensual tribbing a desire to force her to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");

		output("\n\nYou place your palm upon her ribs, pushing slowly upwards, enjoying the give and take of her heaving flesh before letting your fingers graze across one of her nipples teasingly. She gasps, her pussy contracting around your [pc.clit] delightfully.");

		output("\n\n“<i>Don’t- don’t do that,</i>” she rasps. “<i>Take your satisfaction if you must, but please...</i>“ ignoring her with silent glee, you touch her other nipple, this time rubbing it gently in concentric circles until it is " + (!pc.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") +", before going to work on the other one, revolving your hips into hers all the while. As you continue to tease her you let your other hand slide down her abdomen, remorselessly leading down until your fingertips touch her [pc.clit].");

		output("\n\nAs you do she makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

		output("\n\nYour grin widening, you delicately place two of your fingers against her bulging clitoris, kneading it with the softest but most persistent of motions. She arches her back to the sensation, her [pc.chest] pushing into your own flesh as she whimpers.");

		output("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold her close, your fingers on one hand still on her [pc.nipples] as you suddenly clap your hips into her hard,");
		if (pc.thickness > 75 && pc.tone < 25) output(" sending your shared jiggly flesh rippling in separate directions");
		else {
			output(" your shared,");
			if(pc.tone > 66) output(" muscled");
			output(" flesh barely moving");
		}
		output(" as you push your clit into her wet opening, making her cry out with that same delicious cadence as she closes her eyes. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

		output("\n\n“<i>Let me guess,</i>” you breathe into her ear, as you keep your fingers moving slowly over her button. “<i>Lethice made it so that even if you did manage to make it out, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, your [pc.hips] clapping into hers insistently as you hold her hot, tautening body close, flicking her bulging clit with curt movements of the wrist, fem-jizz dampening your thighs. You push into her opening again, fucking her ruthlessly and she cries out, trying now to pull away from you but far too weak to do it; your flesh imprisons her doubly and you force sensation upon her from every direction you can, your [pc.vagina] thrusting into its dominated mirror image, one hand squeezing her needily erect/beading nipple, the other stroking her sensitive clit, relentlessly pulling her with you to a twin high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone snaps. The doppelganger no longer struggles, can’t even find words anymore; she just squeals and groans in helpless pleasure as you use every soft, warm inch of her.");

		output("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, orgasm closing. “<i>Ten minutes after stealing it you’re its true owner’s lesbian slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>” You thrust as much of yourself into her as you can, pushing your clit against hers as your body tenses and flings itself into orgasm. Your mirror image howls, finding a note you never knew your vocal chords could reach as she thrashes back into you, her " + pc.hairDescript() + " flapping into your face as she orgasms in tandem.");
		if (pc.cumQ() > 1000) output("  You know exactly what to expect; her over-clocked physiology makes her a veritable fem-cum fountain. Your vaginas spurt and spatter against each other, rivulets of shared delirium dribbling onto the floor and dousing your abdomens, the doppelganger wailing at the sheer size of the high owning your body forces her to feel. You sit astride her, exulting in and enjoy the sight of it at the same time.");
		else output("  You ride your high, shared female delirium wetting your thighs as you force her to ride her high locked deep into you.");
		
		output("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you thrust one last time into your defeated slut- and then jerk forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced the doppelganger to create. Except that’s not there anymore, either- all that you are suddenly left with is you, your oozing, gently aching [pc.vagina], and a great deal of broken glass. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could in any way be an object of dread- indeed, standing here naked in this shabby storage room, you feel faintly ridiculous. Was this all just a really weird fugue? There’s no mistaking the warm fuzz of deep satisfaction at least. Shaking your head, you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
	}
	
	output("\n\n<b>(Key Item Acquired: Laybans!)</b>\n\n");
	flags["COC.D3_MIRRORS_SHATTERED"] = 1;
	pc.orgasm();
	
	processTime(35 + rand(5));
	CombatManager.genericVictory();
}

public function killYourself():void
{
	clearOutput();
	output("You hold its gaze for a moment more, and then with a single, fluid movement turn and smash your [pc.mainWeapon] into the engraved mirror. A shrill scream mingles with the sound of breaking glass, but by the time the shards begin to tinkle and chime to the floor it’s keened away, and when you turn back the doppelganger is gone. The shrill sound could have been the sound of the mirror itself when you hit it, you suppose. This could all have been a very strange fugue. Certainly, standing here now in this dishevelled storage room, it’s difficult to believe what just happened. Shaking your head, you make sure the protective glasses you came here for are still in your pocket before heading to the door and leaving.\n\n");
	flags["COC.D3_MIRRORS_SHATTERED"] = 1;
	
	processTime(10 + rand(5));
	CombatManager.genericVictory();
}

public function inSovietCoCSelfFucksYou():void
{
	clearOutput();
	
	output("Everything feels so vague, so inconstent; your body and mind shimmer like a lake hit by rain, incapable of focusing, incapable of holding onto a shape, a slave to any force that wants to form you. Who are you? It is obvious, isn’t it. Your image floats in front of you, the only clear thing you can perceive. It grins triumphantly, and you grin back: it is all you can do. Its movements define you, dominate you utterly, within and without. When it steps forward and puts its hand out, it isn’t by choice you mimic the action - it is all you can do. Your fingers stretch out to meet their mirror image, but before they meet they touch a cold, invisible barrier. Glass. True understanding of your situation permeates you like spreading oil, but you cannot gasp, scream in horror, pull at your hair. You slowly pull away from the mirror’s surface, your grin widening, because that is what the demon who has taken your form is doing.");

	output("\n\n“<i>Beautiful,</i>” you and [pc.heShe] breathe. “<i>I will do great things with this body, [pc.name], things you couldn’t have imagined, poor soulful innocent that you were. I will take my revenge with it, but first...</i>” [pc.heShe] stares at [pc.hisHer] reflection smoulderingly as [pc.heShe] raises [pc.hisHer] hands to [pc.hisHer] armor. [pc.heShe] forces you to take off your clothes with [pc.himHer], and you feel it just as clearly as if you were controlling the actions; the way your underclothes whisper off you, the way your naked flesh goose bumps in the coolness of the room");
	if (pc.hasCock()) output(", the way your turgid [pc.cockBiggest] feels when you grasp it at the base.");
	else if (pc.hasVagina()) output(", the way your [pc.vagina] feels when you slide your fingers along its lips.");
	else 
	{
		output(", the way your");
		pc.createVagina();
		output(" [pc.vagina] feels when you slide your fingers against your... Wait, where did that come from? You push your fingers in more forcefully, determined to see through this illusion, but all you manage to do is arouse yourself beyond all reasonable measure. Somehow, <b>you've grown a tight, wet pussy to match your duplicate's!</b>");
	}
	if (pc.hasCock() && !pc.hasVagina())
	{
		output("\n\nYou masturbate with [pc.himHer], forced to stand there and repeat [pc.hisHer] every pleasurable stroke, growing less gloating and more urgent with each jerk of the wrist as ten years of chastity step into the room and set their weight upon his groin. You feel that weight, terrible for an incubus to endure, and you cannot possibly last long against it. Your face contorts into one of unspeakable joy and release as you tap that urge, your cock contracting and then unleashing a font of [pc.cum], your body caught in orgasm for what seems like an eternity.");
		if (pc.cocks.length > 1) output("  Your other cocks deliriously tighten and spurt their own loads at the same time, an uncontrollable storm of a high.");
	}
	else if (pc.hasCock() && pc.hasVagina())
	{
		output("\n\nYou masturbate with [pc.himHer], forced to stand there and repeat [pc.hisHer] every pleasurable stroke, growing less gloating and more urgent with each jerk of the wrist as ten years of chastity step into the room and set their weight upon [pc.hisHer] groin. You feel that weight, terrible for an omnibus to endure, and you cannot possibly last long against it- your female sex, caught in the impetus, softens and drips to the movement of your hand. Your face contorts into one of unspeakable joy and release as you tap the urge, your cock contracting and then unleashing a font of [pc.cum]. Your [pc.vagina] quivers, tightens and wets itself at the same time, your whole body caught in orgasm for what seems like an eternity.");
		if (pc.cocks.length > 1) output("  Your other cocks deliriously tighten and spurt their own loads at the same time, an uncontrollable storm of a high.");
	}
	else if (!pc.hasCock() && pc.hasVagina())
	{
		output("\n\nYou masturbate with her, forced to stand there and repeat her every pleasurable schlick, growing less gloating and more urgent with each flick of the finger as ten years of chastity step into the room and set their weight upon her groin. You feel that weight, terrible for a succubus to endure, and you cannot possibly last long against it. Your face contorts into one of unspeakable joy and release as you tap that urge, your [pc.vagina] quivering, contracting and then wetting itself, your body caught in orgasm for what seems like an eternity. ");
	}
	
	output("\n\n“<i>Ahh...</i>” your mouth says finally, as you step back from the mirror, your eyes half-lidded with contentment. “<i>I really needed that.</i>” [pc.name] turns away from the surface you now embody to put [pc.hisHer] [pc.gear] back on and you follow suit, gazing dumbly at the reflection of the room behind you. You want to shout and scream at [pc.himHer] now, begging [pc.himHer] to give you your body back, for [pc.himHer] not to do what you know comes next, but you can’t- you can’t stop turning back around, you can’t stop yourself touching the surface of your mirror one last time and, smirking, stride out of the room. You mimic your body exiting out of sight of the mirror’s edge, and then... then you mimic a grey, empty room. Staring back at you hollowly, inert and empty. Listening to a metal door shutting behind you with a terrible finality.");

	output("\n\nWith your body and brain full of memory of how to defeat demons, coupled with [pc.hisHer] own knowledge and thirst for revenge, your impostor surprises Lethice and manages to destroy her, taking her place and ruling the mountains and beyond with a mania born of horizons and insanity she never knew. You know all this because [pc.name] is true to [pc.hisHer] promise not to inflict the same suffering [pc.heShe] endured upon you, and you don’t have to stand in the mirror room for very long (although being a deserted storage chamber, you quickly learn, makes a mockery of concepts like “very long”). [pc.HeShe] has your glass prison brought to [pc.hisHer] lavish inner chambers and installs you there- nailed to the ceiling above [pc.hisHer] bed, specifically. From your vantage point you mimic [pc.hisHer] orgies, each more deranged than the last. You experience sensation even the doppelganger [pc.himHer]self never knows, because you are forced to embody everything in the room. Not just every slave girl, boy and favored demon there, every bulging prick and tight, eager hole, not just your old body bucking, slithering and glorying in it all, but every dildo, butt-plug, whip, bead, chain, every satin sheet upon which soft flesh is urgently pressed. You encompass everyone’s thoughts, the slavering succulence of total submission, the coursing power and glory of [pc.name]’s maddened domineering, every mind-wiping orgasm and sensation bordering between screaming pain and ecstatic pleasure is yours to endure. ");

	output("\n\nYou quickly go completely insane, just like your bodysnatcher did, although not in a way [pc.heShe] ever knew. You will never be able to express that insanity though. Every hour there is a new scene of complete depravity for you to reflect, personify and act out. A demon’s dearest wish - an eternity of constantly changing, mind-boggling sex - is your final fate.");

	badEnd();
}