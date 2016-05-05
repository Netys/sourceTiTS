import classes.CockClass;
import classes.GameData.CommandContainers.FapCommandContainer;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function getCoCFapOptions(faps:Array, roundTwo:Boolean):void {
	var fap:FapCommandContainer;
	if(pc.isFlexible() && (pc.felineScore() >= 6 || !pc.isTaur())) { // ugh... really want proper cat-taur variant of scene
		if(pc.hasCock() && pc.smallestCockLength() <= 12) // scene does little sense for longer ones
		{
			fap = new FapCommandContainer();
			fap.text = "Lick Cock";
			fap.ttHeader = "Lick Cock"
			fap.ttBody = "Use your flexibility to suck yourself!";
			fap.func = catAutoLick;
			fap.ignoreRandomSelection = false;
			fap.ignorePublic = false;
			faps.push(fap);
		}
		if(pc.hasVagina())
		{
			fap = new FapCommandContainer();
			fap.text = "Lick 'Gina";
			fap.ttHeader = "Lick 'Gina"
			fap.ttBody = "Use your flexibility to lick yourself!";
			fap.func = lickYerGirlParts;
			fap.ignoreRandomSelection = false;
			fap.ignorePublic = false;
			faps.push(fap);
		}
	}
	
	if(pc.hasCock(GLOBAL.TYPE_TENTACLE) && pc.hasVagina())
	{
		fap = new FapCommandContainer();
		fap.text = "Tentapussy";
		fap.ttHeader = "Tentapussy"
		fap.ttBody = "Take advantage of being tentacle monster to fuck yourself!";
		fap.func = tentacleSelfFuck;
		fap.ignoreRandomSelection = false;
		fap.ignorePublic = false;
		faps.push(fap);
	}
	
	if(pc.hasCock(GLOBAL.TYPE_TENTACLE))
	{
		fap = new FapCommandContainer();
		fap.text = "Tentabutt";
		fap.ttHeader = "Tentabutt"
		fap.ttBody = "Take advantage of being tentacle monster to fuck your own ass!";
		fap.func = tentacleGoesUpYerPooperNewsAtEleven;
		fap.ignoreRandomSelection = false;
		fap.ignorePublic = false;
		faps.push(fap);
	}
	
	if(pc.hasStatusEffect("Exgartuan")  && pc.statusEffectv2("Exgartuan") == 0 && inCamp())
	{
		fap = new FapCommandContainer();
		fap.text = "Exgartuan";
		fap.ttHeader = "Exgartuan"
		fap.ttBody = "Het some action with Exgartuan.";
		fap.func = exgartuanMasturbation;
		fap.ignoreRandomSelection = false;
		fap.ignorePublic = false;
		faps.push(fap);
	}
	
	if(pc.hasKeyItem("Fake Mare") && pc.hasCock() && pc.isTaur() && inCamp())
	{
		fap = new FapCommandContainer();
		fap.text = "Fake Mare";
		fap.ttHeader = "Fake Mare"
		fap.ttBody = "Use a toy appropriate to your tauric body.";
		fap.func = centaurDudesGetHorseAids;
		fap.ignoreRandomSelection = false;
		fap.ignorePublic = false;
		faps.push(fap);
	}
	
	if(pc.hasKeyItem("Centaur Pole") && pc.isTaur() && inCamp())
	{
		fap = new FapCommandContainer();
		fap.text = "Cent. Pole";
		fap.ttHeader = "Cent. Pole"
		fap.ttBody = "Use a toy appropriate to your tauric body.";
		fap.func = centaurGirlsGetHorseAids;
		fap.ignoreRandomSelection = false;
		fap.ignorePublic = false;
		faps.push(fap);
	}
	
	if(pc.hasKeyItem("Dildo") && pc.genitalLocation() <= 1)
	{
		fap = new FapCommandContainer();
		fap.text = "Anal Dildo";
		fap.func = CoCDildoButts;
		faps.push(fap);
		
		if(pc.hasVagina()) {
			fap = new FapCommandContainer();
			fap.text = "Dildo";
			fap.func = stickADildoInYourVagooSlut;
			faps.push(fap);
		}
	}
	
	if(pc.hasKeyItem("Deluxe Dildo") && pc.hasVagina() && !pc.isTaur())
	{
		fap = new FapCommandContainer();
		fap.text = "Dx. Dildo";
		fap.func = CoCDeluxeDildo;
		faps.push(fap);
	}
	
	if ((pc.hasPerk("History: Religious") && pc.cor() <= 66 // History perk (maybe)
		|| pc.hasPerk("Enlightened") && pc.cor() < 10 // Jojo training
		|| pc.hasPerk("Enlightened Nine-tails") && pc.cor() <= pc.WQ()) // Self-training as pure Kitsune
		&& !pc.isBimbo() && !pc.isBro()) // You? Meditate? No way.
	{
		fap = new FapCommandContainer();
		fap.text = "Meditate";
		fap.ttHeader = "Meditate"
		fap.ttBody = "You could meditate to cleanse your urges.";
		fap.func = meditate;
		fap.ignoreRandomSelection = true;
		fap.ignorePublic = true;
		faps.push(fap);
	}
}

public function meditate():void {
	clearOutput();
	processTime(100 + rand(40));
	
	output("You find a comfortable and secluded place to sit down on and meditate.  As always, meditation brings a sense of peace and calm to you, but it eats up two hours of the day.");
	
	pc.cor( -0.3); // Cleanse some corruption.
	if(pc.libidoRaw > 5) pc.slowStatGain("l", -0.25); // Small libdo loss.
	pc.slowStatGain("w", 0.25); // Small willpower training.
	pc.lust(pc.lustMin(), true); // Calm as much as possible.
	pc.energy(pc.energyMax() / 4); // You are basically resting, so energy restoration is appropriate.
	
	if (pc.hasPerk("Enlightened") && pc.cor() < 10) pc.HP(pc.maxHP() / 2); // Enlightened by Jojo training can also heal from meditation.
	if (pc.hasPerk("Enlightened Nine-tails") || pc.hasPerk("Corrupted Nine-tails")) pc.energy(pc.energyMax() / 4); // Nine-tails have increased energy gains.
	
	//updatePCStats();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//(D. Dildo) - a floppy pink dildo with aphrodisiac reservoir
public function CoCDeluxeDildo():void {
	//pc.slimeFeed();
	clearOutput();
	//[USE FEMALE]
	if (pc.hasVagina()) {
		//(highcor)
		if (pc.exhibitionism() >= 66 && rooms[currentLocation].hasFlag(GLOBAL.PUBLIC))
			output("You retrieve the floppy pink dildo from your possessions and strip down on the spot, shivering with the sexual thrill of your exhibitionism.");
		//(medcor)
		else if (pc.slut() > 33)
			output("You retrieve your floppy dildo and sigh happily as you squeeze it, feeling the spongy surface give a little bit.");
		//(lowcor)
		else output("You blush feverishly as you grab your pink dildo.  You feel like such a pervert.");
		output("\n\n");
		//(low cor)
		if (pc.slut() < 50)
			output("You hold the fake dong away from you, aroused but still somewhat disgusted by its lewd shape.");
		//high cor
		else output("You hold the fake dong, squeezing it and giggling at the realistic texture.  You can't wait to try it out.");
		output("  A drop of pink aphrodisiac leaks from the tip, offering you a hint of the pleasure you're in for.   You make sure to catch it on your crotch, letting the fluid seep into your [pc.vagina].  Warmth radiates outwards, spreading to your thighs as your [pc.clit]");
		if (pc.clitLength < .5)
			output(" becomes hard and sensitive");
		else if (pc.clitLength < 3)
			output(" peeks through your folds");
		else if (pc.clitLength < 6)
			output(" fills with blood, growing erect like a tiny cock");
		else output(" fills with blood, twitching and pulsating like a man's cock");
		output(".  You ");
		if (pc.slut() > 50) output("don't ");
		output("hesitate ");
		if (pc.slut() < 50)
			output("before slowly working it inside you, gasping at the enhanced sensitivity of your [pc.vagina].");
		else output("ramming it deep inside you, moaning as it rubs your now over-sensitive walls.");
		output("  You");
		if(pc.isBiped()) output(" splay your [pc.legs] and");
		output(" lie there with it inside you, feeling it respond to your wetness, becoming more and more turned on by the second.\n\n");
	
		//(Kinda dry)
		if (pc.vaginas[0].wetness() < 2)
			output("The thickness of the toy gradually increases, filling you more and more effectively as it reacts to your bodily fluids.  You grab it two-handed and start slamming it into your [pc.vagina], vigorously fucking yourself with the swelling dong.  The sensations just keep getting better and better as more and more of the goblin's sex-drug leaks into you.  Even your [pc.clit] and cunt-lips tingle with need.  You answer that need by picking up the pace, pistoning faster and faster.\n\n"); 
		//(Pretty wet)
		else if (pc.vaginas[0].wetness() < 4) {
			output("The toy's girth seems to pulse and swell within you, spreading you wide open as it sops up your natural wetness and grows larger.  You grab it in a two-handed grip and begin working it in and out of your [pc.vagina], gasping and twitching as every ridge and feature of the dildo rubs you just right.  Every inch of your nethers tingles with a desire to be touched, rubbed, and squeezed. ");
			if (pc.cocks.length > 0) {
				output("Even your " + pc.multiCockDescript() + " ache");
				if (pc.totalCocks() == 1) output("s");
				output(" and pulse");
				if (pc.totalCocks() == 1) output("s");
				output(", bouncing on your belly.  ");
			}
			output("You answer that need by pistoning the fat juicy dick even harder into your tightly stretched box, cooing as tiny squirts of fluid erupt with every thrust.\n\n");
		}
		//(Soaked)
		else output("You can feel the dildo growing inside you, reacting to gushing feminine fluids by stretching your [pc.vagina] wide.  It doesn't seem to stop when you start fucking yourself with it.  If anything, it only seems to get thicker and thicker until there is barely room for your juices to squirt around it and your hips feel sore.  However, the tingling hotness of the dildo's aphrodisiac cum overwhelms the discomfort of the fattening fuck-tool, and you work it harder and harder, reveling in being stretched beyond your normal capacity.\n\n");
		
		//Sensitivity based orgasms.
		//(Low sensitivity) 
		if (pc.lust() < 80) {
			output("Practically brutalizing your cunt with the swollen puss-plug, you bring yourself to orgasm.  Your [pc.hips] leap off the ground, quivering in the air against your [pc.hands] as you ram the toy into yourself as far as it will go.  You can feel it spurting inside you, just like a real man.  You wiggle and moan as the muscle spasms work their way through your " + pc.legs() + ", leaving you drained and exhausted.  The pink dildo suddenly shrinks back to its original size and flops free, leaving your [pc.vagina] stretched open to drool a puddle of pink cum.");
			//(+sensitivity by 5)
			//dynStats("sen", 5);
		}
		////High sensitivity (80+)
		else {
			output("Brutalizing your stretched fuck-hole with the bloated toy, you manage to get yourself off.   Your body quakes and spasms while your [pc.hips] buck into the air, fucking an imaginary lover.  The dildo sinks into your core, your arms instinctively fulfilling your desire for complete penetration.  A warm wetness suddenly soaks your womb as the fuck-stick erupts, filling you.  Just like that the orgasm you had seems like foreplay.  Your eyes roll back into your head and you begin convulsing, practically having a pleasure-seizure from the drugs and your already oversensitive twat.   You sprawl there, wiggling and cumming your brains out for what feels like an eternity, but it does eventually end, and when it does the dildo is back to its normal size, lying in a puddle of aphrodisiacs and girlcum.");
			//(+sensitivity by 3 & intellect -2 & libido +1	)
		}
		//Option Jojo veyeurism?
		//if (getGame().monk >= 5 && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
			//output("\n\nAs you stand and try to clean up you manage to spot Jojo off in the woods, ");
			//if (pc.findStatusAffect(StatusAffects.TentacleJojo) >= 0)
				//output("his tentacles splattering mouse-jizz everywhere as he gets off from your show.");
			//else output("splattering himself with mouse-spunk as he finishes enjoying your inadvertent show.  He runs off before you have a chance to react.");
		//}
		output("\n");
		pc.cuntChange(0, Math.min(500, pc.vaginalCapacity() * 0.9), true);
		pc.loadInCunt();
		processTime(45);
		pc.orgasm();
	}
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function lickYerGirlParts():void { //Female cat masturbation
	clearOutput();
	IncrementFlag("COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY");
	//[1st time doing this]
	if (flags["COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY"] == 1) {
		output("You take off your [pc.gear] and take a seat. You");
		if (pc.isBiped()) output(" spread your [pc.legs] and");
		output(" look down at your sex. It's aching for something more than just your fingers, and you have a craving to taste the lustful juices leaking out. A very perverted idea flashes through your brain, putting a smile on your [pc.face]. You lay on your side");
		if (pc.isBiped()) output(" and spread your legs again,");
		output( " giving you a perfect view of your [pc.vagina]. You lean your head down with your [pc.tongue] sticking out; closer and closer you come to your own cunt, feeling the heat from your puss flowing against your face as your own hot breath returns the warmth");
		if (pc.isBiped()) output(". You're only a small distance away from tasting it before you can't bend any farther.  Your cunny can almost feel your [pc.tongueNoun] wriggling its slimy warm wetness only a few centimeters away. You pull your head back and let out a frustrated sigh before you remember how the cats got to those hard to reach places: they stretched one of their legs straight up. Following their example, you point one leg straight to the sky and close your eyes as you plunge your head down. You slowly open one eye to see that you're face to face with your [pc.vagina]");
		output("; you're amazed that you are actually able to do it. You begin lapping your [pc.tongueNoun] up and down the slutty snatch.\n\n");
			
		output("The feeling is amazing, as you flick your [pc.tongue] across your swollen [pc.clit]. Juices leak from your moist hole, filling your mouth with the [pc.girlCumFlavor] taste of your [pc.girlCumNoun]. You can feel your entire sex pulsing and throbbing around your [pc.tongueNoun] as you plumb the depths of your [pc.vagina].  The vibrations from your moans and screams of pleasure cause the intense feelings to increase, making you a slave to your own needs. Your juices flow down your chin as you try to swallow every last drop. You crane your neck, giving you deeper access to your wanting honey pot. You can feel yourself tightening around your [pc.tongueNoun] as it rams into your [pc.vagina], soaking up the juices as you slowly reach your peak.  You lick and suck hard around your [pc.clit], using both your [pc.hands] to spread your cunt farther open. You move your head in an up and down motion just like a cat when they groom themselves. Your lapping and [pc.tongueNoun] play continues until you can feel your body tense up, ready to cum.\n\n");
		
		output("You cover your entire pussy with your mouth and send a wave of hot air into it; suddenly, a powerful and erotic feeling washes over your entire body. Your pussy clenches hard around your [pc.tongueNoun], as your juices release all over your [pc.face]. You try as hard as you can to catch it all in your mouth, but you find it difficult; your entire body is shaking uncontrollably from the amazing orgasm you gave yourself, making it hard to catch your [pc.girlCum]. Finally, the orgasm comes to a close as you swallow your juices with pride, giving a relaxed sigh. Still lying on the ground, you savor your own unique flavor with a lick across your [pc.lips] and sigh of achievement. You feel like taking a cat nap right about now.");
	}
	//[Repeatable]
	else {
		output("You quickly get rid of your [pc.gear], both of your mouths drooling in anticipation for one another.  ");
		if (pc.isBiped()) output("ou're going to do some stretches so you can be more nimble with your [pc.tongueNoun] work. You stand straight and spread your [pc.legs] apart before leaning back and sticking your [pc.vagina] out in front of you. After holding for a moment, you change positions, leaning your [pc.fullChest] forward and sticking your [pc.ass] out for all to see.  You alternate leaning back and forth; it looks like you're teasingly thrusting at some unknown creature in the wilds, letting them know you're ready to get fucked. Soon, your spine is nice and limber - working on your legs is next. You stand up straight again, then lift and hold one knee up to your chest, pressing it against your [pc.chest]. This loosens it up a bit, but you know you can be more flexible than that. You support the underside of the leg with your hands and then lift the rest of your [pc.leg] up, pointing your [pc.toes] at the sky. You slowly take your [pc.hands] off your leg, and are astonished that you're able to hold it up by itself.  Being naked in this position has allowed your funhole to be exposed to the elements, and you feel a cool breeze blow past your dripping wet sex.  It shakes and quivers, causing you to coo and moan at the sensation. Your leg feels as limber as your spine, so you switch to the other leg.  You immediately launch the other leg up next to your head, not needing the support of your [pc.hands] to get your ankle behind your ear. You hold the pose for a few minutes, your cunt now drooling with pussy juice and eagerly waiting for you to kiss it. You soon put the leg down; now your back, legs and even your aching sluthole is stretched. You do some quick jaw stretches as you lay down on your bedroll.  Throwing one leg over your head, ");
		else output("With a twist of your incredibly flexible body, ");
		output("you easily bend your head down to your other pair of lips.\n\n");
		
		output("Your [pc.vagina] is now right in front of your [pc.face], and you can't help but give it a lick with your [pc.tongue]. The feeling is amazing as you flick your [pc.tongueNoun] across your swollen [pc.clit]. Juices leak from your moist hole, filling your mouth with the [pc.girlCumFlavor] taste of [pc.girlCumNoun]. You can feel you entire sex pulsing and throbbing around your [pc.tongueNoun] as you plumb the depths of your [pc.vagina].  The vibrations from your moans and screams of pleasure cause the intense feelings to increase, making you a slave to your own needs. Your juices flow down your chin as you try to swallow every last drop. You crane your neck, giving you deeper access to your wanting honey pot. You can feel yourself tightening around your [pc.tongueNoun] as it rams into your pussy and soaking up all the juices as you slowly reach your peak. You lick and suck hard around your [pc.clit], using both your [pc.hands] to spread your cunt farther open. You move your head in an up and down motion just like a cat when they groom themselves. Your lapping and [pc.tongueNoun] play continues until you can feel your body tense up, ready to cum.\n\n");
	
		output("You lap harder and faster with each second, coming closer and closer to tasting the [pc.girlCum] about to squirt out of you. You feel your eager sex tighten one more time around your [pc.tongue] before it releases its sweet nectar into your craving mouth. You guzzle as much as you can, but some leaks onto your [pc.face].  You stick your [pc.tongueNoun] into your slick cunt to tease out the last few drops of [pc.girlCumNoun]. You [pc.tongue] explores the depths once more, feeling its way around your [pc.vagina] walls and gathering up everything that may not have come out. You wriggle it around for a while until you're satisfied that you got most of the [pc.girlCum]. You pull away from your sex and spread out relaxed on your bedroll, letting out a sigh like you just drank a whole pitcher of ale in one chug.");
		if (rooms[currentLocation].hasFlag(GLOBAL.PRIVATE) && !rooms[currentLocation].hasFlag(GLOBAL.HAZARD)) output(" You stretch out your arms and legs and curl up, ready to take a catnap.");
	}
	//Stats & next event
	//DONE!
	processTime(20 + rand(10));
	pc.girlCumInMouth(pc);
	pc.orgasm();
	//dynStats("sen", -0.5);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function catAutoLick():void { //Male cat masturbation
	clearOutput();
	IncrementFlag("COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY");
	var x:int = pc.cockThatFits(12, "length");
	if (x == -1) x = pc.shortestCockIndex(); // failsafe, should never happen
	
	//1st time
	if (flags["COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY"] == 1) {
		output("You get rid of your [pc.gear] and take a seat. You take a look at your inhuman body, making notes of things you haven't noticed before. Suddenly, an idea pops into your head: the cats could reach any place on their body with their tongues! You wonder... closing your eyes and slowly bending down, you try to get as close as possible to your [pc.cock " + x + "]. It only takes a moment before you feel warm breath blowing against your [pc.cockHead " + x + "]. You open your eyes, coming face to face with your erect member. Your body is twisted and bent in a way that only someone with cat-like flexibility can manage. You huff a cloud of hot air on your pecker, and the resulting sensation causes your [pc.eyes] to roll back in your head. That was incredible and it's about to get better as another thought passes through your head, giving you a dirty smile.\n\n");
	
		output("You lick the [pc.cockHead " + x + "] of your throbbing man-meat and another bodyshaking shudder flows through you. You do it a few more times, enjoying the sensations running around inside of you. You bend down farther and lick from the [pc.base " + x + "] of your dick to the head. Slowly, you take the [pc.cockHead " + x + "] inside of your mouth and begin sucking on it, trying to keep the drool in your mouth. The feeling is enough to make you cum, but you hold it in and move on. You take a few more inches inside your mouth as you begin pumping and thrusting, making lewd noises of moaning and sucking. The feeling is better than any blowjob you've ever had. You start to pump faster and faster, desperate to cum all over your own [pc.face]. Just thinking about the fact that you're doing this to yourself turns you on even more. You take the rest of your [pc.cock " + x + "] inside of your mouth.");
		if(pc.balls > 0) output(" You can smell the musty scent coming off of your [pc.sack].")
		output(" Your throat closes up on your member as you hum and flick your [pc.tongueNoun] across its [pc.cockHead " + x + "].\n\n");
		
		output("A very familiar feeling of pleasure rushes through your body, causing you to shudder. You pull your cock out and begin to stroke it as you suck on the tip, practically drinking your pre-cum. You can feel your [pc.cumNoun] building up as it gets ready to be released. After flicking your [pc.tongue] against the tip of your [pc.cock " + x + "], you feel the flood of [pc.cumNoun] flowing up your dick");
		
		output(". Suddenly, a feeling of complete bliss takes over your body, and you start to squirm and writhe as [pc.cumFlavor] [pc.cumNoun] shoots down your throat. You pull off of the tip and let the next burst hit your [pc.face]. Soon, the torrent of [pc.cum] subsides, though your hips are still jerking in the air from the intense orgasm.");
		if (rooms[currentLocation].hasFlag(GLOBAL.PRIVATE) && !rooms[currentLocation].hasFlag(GLOBAL.HAZARD)) output(" You take a moment to lie down properly and decide to take a small cat nap.");
	}
	//[Repeatable]
	else {
		output("You quickly get rid of your [pc.gear], your cock drooling with pre-cum in anticipation of your [pc.tongue]'s magic.");
		if (pc.isBiped()) output(" You're going to do some stretches so you can be more nimble with your [pc.tongueNoun] work. You stand straight and spread your [pc.legs] apart, before leaning back and sticking your erect [pc.cock " + x + "] forward. After holding for a moment, you switch positions, leaning your [pc.chest] forward and sticking your [pc.ass] out for all to see - if anyone is around. You alternate leaning back and forth; it looks like you're fucking some invisible bitch. Soon, your spine is nice and limber - working on your [pc.legs] is next. You stand up straight again, then lift and hold one knee up to your chest, pressing it against your [pc.fullChest]. This loosens it up a bit, but you know you can be more flexible than that. You support the underside of the leg with your hands and then lift the rest of your leg up, pointing your [pc.toes] at the sky. You slowly take your hands off your leg, and are astonished that you're able to hold it up by itself. Being naked in this position has allowed [pc.eachCock] to be exposed to the elements, and you feel a cool breeze brushing against your [pc.cocksLight].  It throbs harder, causing you to coo and moan at the sensation. Your leg feels as limber as your spine, so you switch to the other leg. You immediately launch the other leg up next to your head, not needing the support of your hands to get your ankle behind your ear. You hold the pose for a few minutes, [pc.eachCock] throbbing and leaking pre-cum, eagerly waiting for you to lick and suck it. You soon put the leg down, hornier then you've ever been. You do some quick jaw stretches as you lay down. Throwing one leg over your head,");
		else output(" With a twist of your incredibly flexible body");
		output(" you easily bend your [pc.face] down to your member.\n\n");
		
		var throat:Boolean = pc.cocks[x].cLength() > (4 + (pc.hasMuzzle() ? 2 : 0) + (pc.hasFaceFlag(GLOBAL.FLAG_LONG) ? 2 : 0));
		
		output("Your [pc.cock " + x + "] is now poking at the left cheek of your [pc.face]; you miscalculated how much flexibility you needed. You use your [pc.tongueNoun] to guide the eager meat-rod into your dripping wet mouth. Your [pc.lips] latch around the tip, sucking on it while your [pc.tongue] rolls around the [pc.cockHead " + x + "]. You begin leaning your head forward, bringing the [pc.cock " + x + "] further into your mouth. Your [pc.tongueNoun] massages the underside as you stick it out to cover as much cock as you can. Small bits of pre-cum shoot out, sending its [pc.cumFlavor] taste down your throat. You lift your head off and your [pc.tongueNoun] follows close behind, leaving a trail of saliva and resulting in a slurp as you continue to lick the throbbing head. You take the cock " + (throat ? "down your throat" : "in your mouth") + " once more, bobbing your head up and down the shaft while flicking your [pc.tongueNoun] from left to right. You begin moving your head faster and harder, making you let out lewd gagging sounds, but it feels too good to stop now. Your entire cock is soaked in saliva, dripping down your shaft and onto the ground. Soon you're moving your hips as much as you can; you are no longer giving yourself a blowjob - you're " + (throat ? "throat" : (pc.hasMuzzle() ? "muzzle" : "face")) + "-fucking yourself. The lewd, gagging sound grows louder and more aggressive.\n\n");
		
		output("Another shot of pre-cum is sent down your throat, followed by the building pressure of your release. You force your head down to the [pc.base " + x + "] of your [pc.cockNoun " + x + "], ");
		if (throat) output("sending it deeply down your throat, feeling the warm and smooth inside as it tightens around the invading member. Thank goodness you're holding your breath, or you would be suffocating right now. You hurry up before you choke on your cock,");
		else output("taking advantage of your small package to caress it whole with your [pc.tongueNoun],");
		output(" moving your head back and forth while your hand caresses the [pc.base " + x + "] of your cock. ");
		
		if (flags["COC.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY"] > 5 && pc.balls >= 2 && rand(2) == 0) {
			output("But it's not enough");
			if (throat) output(" and you are forced to come up for air.\n\nWhile gasping for air");
			output(", you scowl at your [pc.cock " + x + "] in disapproval. That's when your [pc.sack] catches your attention. It's gleaming with your sex sheen and you watch one of your balls slowly slide off to one side.");
			
			output("\n\nYou think you can make it! ");
			if(pc.isBiped()) output("You throw your other leg over your head and both feet come to rest on your back. ");
			output("You push your mouth towards your [pc.sack], slowly walking your [pc.toes] down your back. You are only an inch from your [pc.balls] now and your own aroma fills your nostrils, spurring your on. Then, finally, you are there! And it nearly knocks you out! The sensation of your own balls in your mouth is incredible--you can feel them churning in your mouth");
			if(pc.isBiped()) output("--and your [pc.feet] start kneeding your back");
			output(". You bring your hands up to massage your [pc.balls] as well, making them take turns in your mouth. Completely intoxicated by your own scent you loose all track of time--there is only the bliss of sucking, licking, and massaging your own balls...");
			
			output("\n\nAbrubtly you realize that your [pc.cocks] have soaked your torso in precum--apparently you've been on the edge for some time. In one swift motion, you pick your head up and slam your mouth down over your [pc.cock " + x + "] leaving your hands to continue their ball massage.");
			
			//add cum quantity conditional text...
			output("\n\nThe release is immediate. You feel the contractions of your climax against your [pc.face], your [pc.feet] involuntarly start massaging your back, and you feel your [pc.cock " + x + "] expand and contract in your mouth as [pc.cum] pumps through it into your stomach. It's more relaxing than anything else--each contraction makes you feel like you might be melting a little, like you might remain in this position forever.");
			
			output("\n\nYour [pc.feet] and hands are still masagging their respective charges when you realize you are starting to go flaccid! You make an attempt to massage every last drop of cum from your [pc.balls], sucking on your [pc.cock " + x + "] continuously as it goes down. It slowly slips from your mouth once it's completely deflated, causing you to frown slightly. Still feeling great in this position, you go down on your [pc.balls] again--alternating between licking and sucking them with your mouth and massaging them with your hands.");
			
			output("\n\nFinally satiated, you begin untangling yourself and realize how sweaty and sticky you are. Again, remembering the cats, you begin to lick ever square inch clean you can reach just like they do and you discover a new form of pleasure. After you lick yourself clean, you stretch out into the spread-eagle position to get a few small kinks out and to admire your naked body glistening in your spit. As you begin to doze off, <b>you think your balls feel a little denser.</b>");
			
			processTime(5 + rand(5));
			pc.shower();
			pc.cumMultiplierRaw += 0.1;
		}
		else {
			output("This releases the pent - up pressure through your cock and down your throat. It's too much for you to handle; your cheeks fill up with [pc.cum] and you pull your head back, making a loud popping sound when you finally free your mouth, as the [pc.cumNoun] pooled in your cheeks spills out all over your cock. Your cock spurts a few more lines of sperm onto your stomach. You stroke the exhausted member a few times, milking the last drops of [pc.cumNoun] out.");
			if (rooms[currentLocation].hasFlag(GLOBAL.PRIVATE) && !rooms[currentLocation].hasFlag(GLOBAL.HAZARD)) output(" Satisfying the final bits of lust, you lay down and fall into a short cat nap.");
		}
	}
	//Stats & next event
	//DONE!
	processTime(30 + rand(10));
	pc.loadInMouth(pc);
	pc.orgasm();
	//dynStats("sen", (-0.5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Maturbate] -- [Fake Mare] (Cock Centaurs Only)
public function centaurDudesGetHorseAids():void {
	var x:int = pc.biggestCockIndex();
	clearOutput();
	if (pc.keyItemv1("Fake Mare") == 0) {
		if (pc.slut() < 50)
			output("Deciding to give the mare-like cocksleeve you got from Whitney a try, you spend a few awkward minutes dragging the lump of metal off to someplace secluded and setting it up.  When you're done, you stand behind a wood-and-iron replica of a mare, adjusted to the perfect height for you.  Looking \"<i>her</i>\" over, your eyes are drawn to the slick black lips of the Onahole between her legs, craftily shaped like a horsecunt, and what looks like a second, smaller one above it simulating an anus.\n\n");
		//[If Med-High Corruption:] 
		else output("You decide to play with the mare-shaped cocksleeve Whitney gave you.  You pull it out of your stash and spend a few minutes setting it up in the heart of camp.  Once done, you stand behind a wood-and-iron replica of a mare, adjusted to the perfect height for you.  Looking \"<i>her</i>\" over, your eyes are drawn to the slick black lips of the Onahole between her legs, craftily shaped like a horsecunt, and what looks like a second, smaller one above it simulating an anus.\n\n");
	}
	
	output("Seeing the toy's exposed, gaping genitals, you feel a stirring in your [pc.cocks].  You yearn to touch yourself, but your tauric lower body prevents you, as usual.  Grunting with annoyance, you trot up to the toy and give its wide cunt an experimental fisting.  ");
	//[If small cock: 
	if (pc.cockVolume(x, false) < 30)
		output("Your hand slips in easily... since it's made for real horsecocks, it's a bit too big to give you any satisfaction.  Your gaze shifts upwards to the toy's fake anus, which seems a bit more your size.</i>\"");
	else output("Your fist slips in easily, and you give the toy a few preparatory thrusts to make sure it's nice and ready for your hefty cock.");
	output("\n\n");
	
	output("Satisfied the toy is ready for you, you clop back a few paces and surge forward.  You mount the toy easily, your belly running across its smooth, warm back until your chest bumps against the mare's head.  You grip her shoulders for support and start to buck your hips, your [pc.cock " + x + "] poking around in search of entrance.  Finally, you feel the [pc.cockHead " + x + "] of your prick ");
	if (pc.cockVolume(x, false) < 30)
		output("pressing against the tight ring of the toy's anus");
	else output("lining up with the toy's gaping cunt");
	output(".  You rear your [pc.hips] and slam yourself into the mare's waiting hole.\n\n");
	
	output("The toy's passage seems to shift and contract around your [pc.cock " + x + "], molding itself to perfectly sheathe you.  What a marvelous little toy!  You slide on up until you hilt yourself, your crotch pressed against the mare's wide ass as your [pc.chest] squeezes against her back.  Now fully mounted, you begin to rut on the mare toy, slapping your hips");
	if (pc.balls > 0)
		output(" and [pc.balls]");
	output(" hard against her rump as you pound into her tight, slick ");
	if (pc.cockVolume(x, false) >= 30)
		output("horsecunt");
	else output("asshole");
	output(".\n\n");

	output("Finally able to get the release you weren't able to give yourself, you feel an orgasm mounting deep within you.  You");
	if (pc.isCentaur()) output(" let out a loud, equine whinny as you");
	output(" hump the toy faster and faster, pounding her with your [pc.cock " + x + "] until the pleasure overwhelms you.  You cry out as you cum, squirting your [pc.cum] as far into the toy as you can shoot it, until she's full up and leaking onto the ground.\n\n");

	output("Sated, you spend a few blissful minutes enjoying the warmth and tightness of the mare-like onahole until your [pc.cock " + x + "] is soft inside it.  You scamper off of her, dropping back to your " + num2Text(pc.legCount) + " [pc.feet].  With a contented yawn, you disassemble the toy and haul it off back to your stash, leaking your [pc.cum] the entire way.");

	pc.addKeyValue("Fake Mare", 1, 1);
	processTime(50 + rand(20));
	pc.orgasm();
	//dynStats("sen", -2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Masturbate] -- [CentaurPole] -- [Fem/Herm Centaurs]
public function centaurGirlsGetHorseAids():void {
	clearOutput();
	if (pc.keyItemv1("Centaur Pole") == 0) {
		//[If low Corruption:] 
		if (pc.exhibitionism() < 66)
			output("Feeling a bit antsy, you decide to give Whitney's so-called \"<i>Centaur Pole</i>\" a try.  You dig it out of your stash and spend a few awkward minutes dragging it off someplace secluded and setting it up.\n\n");
		//[If Med-High Corruption:]
		else output("Unable to sate your own lusts due to your centaur configuration, you decide to put one of Whitney's centaur toys to use.  You dig the Centaur Pole out of your stash and drag it to the middle of camp.\n\n");
	}
	output("When you've got it ready, the \"<i>Pole</i>\" is actually quite impressive.  It's a large metallic statue of what seems to be a particularly well-endowed imp, equipped with a huge, flared horsecock displayed proudly between his muscular legs.  You give the tremendous purple cock a few experimental strokes, and to your delight it inflates just like a real boner, becoming rock-hard in your grasp.  You lick your [pc.lips] and, unable to resist, take the cock into your mouth.\n\n");

	output("Though it tastes rubbery, the heft and size of the prick feels... right... inside you.  You spend a few blissful minutes sucking off the horse dildo, getting it nice and wet and ready for you.  When you're satisfied the imp-statue's wang is sufficiently lubed up, you let it pop out of your mouth and, making sure it's still standing straight out of the statue, you turn around.\n\n");

	output("Your [pc.hips] wiggle in anticipation as you work to get your ready [pc.vagOrAss] lined up with the horse dildo.  Unable to see the toy past your tauric rump, it's a long, desperate minute until finally you feel its flared head against your [pc.vagOrAss].  You shimmy back, gasping in delight as the meaty horsecock pushes into you.  It seems to inflate and expand inside you as you take it");
	
	if (pc.vaginalCapacity() < 1000) output(", until you're completely and utterly full of purple rubber -- and then some.  You grunt as the cock continues to grow, stretching your [pc.vagOrAss] until you let out a pained whimper.");
	else if(silly) output(" until it feels like you have whole horse inside you. Which, considering hammerspace in your [pc.vagOrAss], is totally possible.");
	else output(".");
	
	if (pc.hasVagina()) pc.cuntChange(0, Math.min(pc.vaginalCapacity() - 3, 1000), true, true, false);
	else pc.buttChange(Math.min(pc.analCapacity() - 3, 1000), true, true, false);
	output("\n\n");

	output("Just then, though, the cock seems to stop.  You grunt and groan as it settles inside you, finally letting out a relieved sigh when it's only giving you a modest, pleasant stretching.  Now that you're stuffed full of fake horsecock, though, you're not sure what to do... \"<i>EEP!</i>\" you yelp as the imp-statue's hands suddenly reach out and grasp your [pc.hips].  Your eyes go wide as you feel the thick dildo withdraw from your [pc.vagOrAss], the imp's hips pulling back.\n\n");
	
	output("You have time only to let out a desperate curse before the toy rams itself back into you.  You try to leap forward from the massive, yet mind-numbingly pleasurable, impact, but its strong hands hold you fast.  You yelp and scream as the statue begins to fuck you roughly, making forceful thrusts deep into your [pc.vagOrAss]");
	if(pc.hasVagina()) output(" until the dildo is battering your cervix");
	output(".  Something inside the cock begins to contract and expand, altering the thickness and heft of the rod inside you, stretching the walls of your ");
	if (pc.hasVagina()) output("cunt");
	else output("rectum");
	output(" even further until your [pc.tongue] hangs out and your eyes roll back, overwhelmed with pleasure.\n\n");

	output("You sense your own orgasm coming as a hot, sticky fluid rushes into you.  You scream your pleasure as the statue unloads a load of hot faux-spunk into your ");
	if (pc.hasVagina()) output("womb");
	else output("depths");
	output(", flooding your [pc.vagOrAss] with its strange seed.  So utterly and completely filled, you cannot hold back your orgasm.  You cum, your [pc.vagOrAss] clamping down hard on the fake cock buried inside you, milking it for more and more of its thick, creamy spooge.\n\n");

	output("When your climax finally passes, you've collapsed, swaying light-headed as the statue continues to leak a steady trickle of spooge onto your [pc.ass].  You stagger to your [pc.legs] and begin to disassemble the pole.  You drag it back to your stash, your hips making a lewd squishing noise with every step as globs of fake cum leak out of your [pc.vagOrAss].");
	
	pc.addKeyValue("Centaur Pole", 1, 1);
	processTime(50 + rand(20));
	if (pc.hasVagina()) pc.loadInCunt();
	else pc.loadInAss();
	pc.orgasm();
	//dynStats("sen", -2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Tentacle In Gina Faps.
//Normal intro.
//Segue into tentacle-faps.
//Pick biggest tentacle that can possible fit into 'gina
public function tentacleSelfFuck():void {
	var x:int = -1;
	var y:int = -1;
	temp = 0;
	while (temp < pc.cocks.length) {
		if (pc.cocks[temp].cType == GLOBAL.TYPE_TENTACLE) {
			if (x == -1 || pc.cocks[x].cLength() < pc.cocks[temp].cLength()) x = temp;
		}
		temp++;
	}
	//Pick a second dick that isn't the first.
	temp = 0;
	while (temp < pc.cocks.length) {
		if (temp != x) {
			if (y < 0)
				y = temp;
			else if (pc.cocks[y].cLength() < pc.cocks[temp].cLength() && (pc.cocks[y].cType != GLOBAL.TYPE_TENTACLE || pc.cocks[temp].cType == GLOBAL.TYPE_TENTACLE))
				y = temp;
			else if (pc.cocks[temp].cType == GLOBAL.TYPE_TENTACLE)
				y = temp;
		}
		temp++;
	}
	clearOutput();
	
	output("Your [pc.cock " + x + "] perks up like a pet expecting to be fed, and you have to admit that you plan to give that squirming tentacle exactly what it desires - a hot, slippery slit to nestle inside of.  Already, your [pc.vagina] has grown ");
	if (pc.wetness() <= 2)
		output("moist");
	else if (pc.wetness() <= 3)
		output("wet");
	else if (pc.wetness() <= 4)
		output("sloppy and wet");
	else output("beyond soaked");
	output(".  The slick slit is slowly parting as you reach to wrangle the wiggly cock");
	if (pc.cocks.length > 1) {
		output(", brushing your hand against your other ");
		if (pc.lust() <= 70)
			output("half-hard");
		else output("erect");
		output(" penis");
		if (pc.cocks.length > 2) output("es");
		output(" on the way");
	}
	output(".  Moaning out loud, you try your best to handle the flood of alien sensations, but the pleasure-sparking tendril in your grip feels so different from a human penis.  It's almost like you're compelled to thrust it inside of some orifice, any orifice, so long as it's somewhere warm and tight.");
	if (y >= 0) output("  It loops around your [pc.cock " + y + "] while you fight with it, strangling the other phallus in tight coils of squeezing, floral friction.");
	
	output("\n\nYou arch your back as you try to contain the unexpected waves of desire that flood your groin, but it's no use.  In the span of a few seconds, you decide to accept that you need to fuck something now.  Foreplay is no longer an option.");
	if (pc.balls > 0)
		output("  You lift you [pc.balls] out of the way and");
	else output("  You");
	output(" twist your wrist down.  That change in direction comes far easier than trying to stroke it.  Releasing sets of alien muscles that you had held instinctively, you let your [pc.cock " + x + "] do what it was made to do.  It slithers down sinuously, the purplish head pressing heavy and hot against your juicy mound just hard enough to encourage you to press back against it.  It slowly spreads your clinging tunnel around its obscene girth one fold at a time.");
	//Cunt change!
	pc.cuntChange(0, pc.cockVolume(x), true, true, false);
	
	output("\n\nRipples of delight radiate along your [pc.cock " + x + "] as it buries itself as deeply into your velvet tunnel as possible.  The fat, purplish head stretches you out as it goes, just enough that the trailing stalk is comfortably ensconced in twat.  Tugging on the exposed portion, you find yourself pumping wildly on your length, squeezing it while paroxysms of ecstasy render your fine muscle control useless.  The dual sensations of being fucked and dishing out a hot dicking have overlapped into a tangled-up knot inside you.");
	if (y >= 0) {
		output("  Your [pc.cock " + y + "] is getting jacked off by the engorged cock-coil's motions and slowly leaks creamy pre over the jerking length.");
		if (pc.cocks[y].cType == GLOBAL.TYPE_TENTACLE) {
			output("  In no time flat the second tendril has gotten the idea, and it elongates to reach for your unoccupied asshole.  There's a moment of token resistance before it violates your [pc.asshole], but then, there's only the warm heat of a torrid butt-fuck.");
			//BUTTCHANGE IF APPROPRIATE
			pc.buttChange(pc.cockVolume(y), true, true, false);
		}
	}
	output("\n\nDelirious with excitement, you grab hold of your [pc.chest]");
	if (pc.biggestTitSize() >= 1) output(", kneading the soft mammary");
	output(" and twisting your [pc.nipple] as your body goes white-hot with pleasure");
	if (pc.hasFuckableNipples()) output(", even stuffing a finger inside a sloppy, dripping nipplecunt");
	output(".");
	if (pc.lactationQ() >= 250) output("  Milk squirts from your engorged teat almost immediately to fall in a moist, creamy rain across your writhing form.");
	//{no new PG}  Three + Tentalce fork - one in mouth
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 3) {
		output("  The pleasured noises that have been issuing forth from your 'O'-gaped lips are cut off by a sudden intrusion from another of your arboreal phalluses.   This one punches straight into your throat without pause, sliding so smoothly across your tongue that you barely care about gagging when it feels so good.  Trickles of your sweet pre-cum are dribbling out from [pc.eachCock] into your holes");
		if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) < pc.cockTotal()) output(" and the open air");
		output(".");
		if (pc.biggestTitSize() >= 4) output("  Laying right between your boobs, it doesn't take long for the shaft to extend far enough to loop around each tit, sliding slowly encircling each curvy mound as it presses them together around itself, getting a titfuck while it plows your unresisting mouth.");
	}
	//No bonus cawks!
	else {
		output("  The pleasured noises issuing forth from your 'O'-gaped lips get higher and higher pitched with each passing second, and for a split second, you find yourself wishing you had a third tentacle so you could suck it while you fuck yourself.");
		if (y >= 0 && pc.cocks[y].cType == GLOBAL.TYPE_TENTACLE && pc.cocks[y].cLength() >= pc.tallness / 4) {
			output("  Luckily, you're so big down there that a juicy [pc.cockHead " + y + "] is right there within reach, and you bend to slurp it up without thought, busily self-sucking with reckless abandon.");
		}
	}
	//MORE
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 6) {
		output("\n\nThe excess green tools rise up above you.  They survey the view before them in a crude approximation of a sentient surveyor, seeming to take in the shifting, squiggling view of your ardent masturbation.  In truth, you're just trying to think of where to stick them.  A few droplets of liquid lust leak from their tips in sympathetic pleasure, and it gives you an idea for just what to do with them.  They stretch out towards your torso, veering to the sides at the last second.  Dripping onto your shoulders, the pulsating plant-pricks slowly push into your armpit, lubricating your " + pc.skinFurScales() + " with their amorous liquid.");
		if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 7) output("  They pile in there, really squirming against each other as much as you, frotting against your sweat-slick flesh.  ");
		output("  You're fucking your armpits, and it feels divine, so good that your pits are swampy pits of sex within moments.");
	}
	//One more:
	else if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 4) {
		output("\n\nThe last green tool rises up above you.  It surveys the view before it in a crude approximation of a sentient surveyor, seeming to take in the shifting, squiggling view of your ardent masturbation.  In truth, you're just trying to think of where to stick it.  A droplet of liquid lust leaks from the tip in sympathetic pleasure, and it gives you an idea for just what to do with it.  It stretches out towards your torso but veers left at the last second.  Dripping onto your shoulder, the pulsating plant-prick slowly pushes into your armpit, lubricating your " + pc.skinFurScales() + " with its amorous liquid.  You're fucking your armpit and it feels divine, so good that you quickly slick your pit and twist the spare cock around yourself so that it can double-fuck both sides.");
	}
	
	//JIZZBOMB
	output("\n\nFamiliar twinges start down in your ");
	if (pc.balls > 0)
		output("balls");
	else output("groin");
	output(".  Orgasm is rapidly closing in, and there's no slowing your frenzied flora at this point.  You ");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 3)
		output("gurgle");
	else output("moan");
	output(" as your inner muscles begin to contract into tight knots, the pressure building to a turgid, throbbing peak.  Then, as you");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 3)
		output("r multitude of penises");
	output(" thrust deep inside yourself, a volcano of pleasure erupts, pumping thick flows of [pc.cum] straight into your snatch");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) == 2)
		output(" and ass");
	else if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 2)
		output(", ass, and mouth");
	output(".");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 3) {
		output("  You gulp the [pc.cumFlavor] flow down as best you are able");
		if (pc.cumQ() >= 500) {
			output(".  That doesn't really count for much with how heavy your load is, ");
			if (pc.cumQ() < 1000)
				output("and your cheeks bulge with the size of each squirt");
			else output("and the [pc.cum] is soon squirting out the corners of your mouth while your cheeks bulge cartoonishly");
		}
		output(".");
	}
	output("  Your birth canal is quickly flooded with [pc.cum]");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 2) output(", while your [pc.ass]'s interior is painted [pc.cumColor]");
	output(".");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) == 2) {
		output("  Your untended [pc.cock " + y + "] blows spunk over you ");
		if (pc.cumQ() < 50)
			output("in small spurts");
		else if (pc.cumQ() < 200)
			output("in thick ropes");
		else if (pc.cumQ() < 500)
			output("in huge blobs");
		else output("like a virile sprinkler");
		output(".");
		if (pc.cocks.length > 2) {
			output("  The other one");
			if (pc.cocks.length > 3)
				output("s match");
			else output(" matches");
			output(" it in output, even though you haven't done anything to stimulate ");
			if (pc.cocks.length == 3)
				output("it");
			else output("them");
			output(".  The sensations coming from your prehensile penises are just so overwhelming that it's like a whole-body-gasm.");
		}
	}
	else if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 4) {
		output("  Meanwhile, the purple tip");
		if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) == 4)
			output("s swell");
		else output(" swells");
		output(" in your armpit");
		if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) >= 5) output("s");
		output(", engorging immensely as they press right into the soft, concave flesh within, the semen squirting out in pressured, arm-soaking jets.");
	}
	
	output("\n\nAt once, your whole body sags back, limp and drained.  The elongated tentacle");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 1)
		output("s retract");
	else output(" retracts");
	output(" back to ");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) == 1)
		output("its");
	else output("their");
	output(" normal length, popping out of your vagina");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) == 2)
		output(" and ass");
	else if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 2) output(", ass, and mouth");
	output(", leaving your orifice");
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 1) output("s");
	output(" to dribble the spent passion on the ground.  Damn, that was satisfying.");
	//(-2 sens + 1 per tentacle dick, -100 lust)
	//dynStats("sen", ( -1 * (1 + pc.cockTotal(GLOBAL.TYPE_TENTACLE))));
	processTime(50 + rand(20));
	pc.loadInCunt(pc);
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 1) pc.loadInAss(pc);
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 2) pc.loadInMouth(pc);
	if (pc.cockTotal(GLOBAL.TYPE_TENTACLE) > 3 && pc.cumQ() >= 50) {
		applyCumSoaked(pc);
	}
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Upon selecting the option to masturbate you should have the option to fuck your own ass if you have a tentacle dick
//Replace n with the tentacle cock number
public function tentacleGoesUpYerPooperNewsAtEleven():void {
	var tentacle:int;
	for (tentacle = 0; tentacle < pc.cocks.length; tentacle++) {
		if (pc.cocks[tentacle].cType == GLOBAL.TYPE_TENTACLE) break;
	}
	for (var x:int = tentacle + 1; x < pc.cocks.length; x++) { //Find the biggest tentacle cock you've got
		if (pc.cocks[x].cType == GLOBAL.TYPE_TENTACLE && pc.cocks[x].effectiveVolume() > pc.cocks[tentacle].effectiveVolume()) tentacle = x;
	}
	clearOutput();
	
	output("You eagerly pet your flora pecker as it squirms and wriggles on its own, gently caressing the green surface here and there, its coloration changing as you tease yourself.  After toying with your tentacle dick for a while, you decide to get down to business; using your newly acquired shaft muscles, you expertly guide your ever-writhing [pc.cock " + tentacle + "] to your back, pointing it toward your buttocks.  You grind the tip against your [pc.butt], making pre-cum flow from your mushroom-like head and smearing it against your " + pc.skinFurScales() + ".  Using your own seminal fluid as a natural lube, you press the tip of your [pc.cockNoun " + tentacle + "] in front of your own backdoor, stretching your [pc.asshole] little by little, careful not to tear your own insides.  This goes on for a while, until you suddenly lose all patience and roughly stuff your own [pc.cock " + tentacle + "] at full force inside your colon.");
	//[anal tightness check]
	pc.buttChange(pc.cockVolume(tentacle), true, true, false);
	
	output("\n\nThe impetuousness of the act makes you cry in a mixture of pleasure and pain, your [pc.asshole] being overloaded with intense sensations.  Fortunately the tender and rubbery texture of your [pc.cockNoun " + tentacle + "] allows for more sensitivity, the subtle friction sending tingles from your crotch all the way up your spine.  You shiver from the sheer cocktail of raw pleasure you're inflicting on your own body.  Your [pc.cockNoun " + tentacle + "] keeps squirming against your insides, making you quiver and giggle like a whore, until it lodges all the way inside your colon, adopting a more comfortable position.  You then proceed to ferociously fuck your own [pc.asshole], stretching it a bit more at every thrust.");
	
	//[Standard text for stroking other cocks/vagina goes here; text between ()s should be removed if the PC doesn't have multicocks]
	
	output("\n\nThe conjugated friction of your [pc.cock " + tentacle + "] writhing inside your devastated interior");
	if(pc.cockTotal() > 1) output(" (as well as the rough hanjdob you're giving yourself)");
	output(" eventually proves too much for your horny body, and [pc.eachCock] releases a massive load, squirting sexual juices everywhere inside");
	if (pc.cockTotal() > 1) {
		output(" (and outside)");
		if (pc.cumQ() >= 100) applyCumSoaked(pc);
	}
	output(" your body.  Pressure builds in your ass as [pc.cum] flows out of you");
	//[if cum production is massive]
	if (pc.cumQ() >= 1000) output(", making [pc.eachCock] bulge.  The extra feeling sends you over the edge and you quickly reach your climax as you cum and cum");
	output(".");
	//[if cum production is moderate]
	if (pc.cumQ() >= 500) output("  Your belly swells a bit from all the [pc.cum] being packed inside you.");
	//[if cum production is massive] 
	if (pc.cumQ() >= 1500) output("  Your poor insides cannot handle the enormous cumshot being unloaded in your [pc.asshole] and a significant volume of [pc.cum] dribbles outside, carelessly polluting the floor.");
	//[Standard text for other cocks cumming goes here.]
	output("  You groan and lazily remove your [pc.cockNoun " + tentacle + "] from your anus as you give in to your pleasure-induced drowsiness.");
	if (pc.cocks.length > 0) {
		//Single Cock
		if (pc.cocks.length == 1) {
			if (pc.libido() < 30)
				output("  You quickly fall asleep, spent. ");
			else if (pc.libido() < 55)
				output("  You roll and begin to doze, your semi-erect [pc.cocks] flopping against you. ");
			else if (pc.libido() <= 80) {
				output("  As you close your eyes and relax, your [pc.cocks] surges back to erectness, ensuring ");
				if (pc.slut() < 50)
					output("your dreams will be filled with sex.");
				else output("you dream in a depraved kinky fantasia.");
			}
			else output("  You groan and drift to sleep, your rigid [pc.cocks] pulsing and throbbing with continual lust.");
		}
		//Multi Cock
		if (pc.cocks.length > 1) {
			if (pc.libido() < 30)
				output("  You quickly fall asleep, spent. ");
			else if (pc.libido() < 55)
				output("  You roll and begin to doze for an hour, your semi-erect cocks flopping against you. ");
			else if (pc.libido() <= 80) {
				output("  As you close your eyes and relax, your dicks surge back to erectness, ensuring ");
				if (pc.slut() < 50)
					output("your dreams will be filled with sex.");
				else output("you dream in a depraved kinky fantasia.");
			}
			else output("  You groan and drift into a brief catnap, your rigid erections pulsing and throbbing with continual lust.");
		}
	}
	processTime(50 + rand(20));
	pc.loadInAss(pc);
	pc.orgasm();
	//dynStats("sen", -2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function stickADildoInYourVagooSlut():void {
	clearOutput();
	
	var dildo:CockClass = new CockClass();
	dildo.cLengthRaw = 7;
	
	if (pc.vaginalVirgin && pc.vaginas[0].hymen) { //LOW CORRUPTION DEFLOWER
		if (pc.slut() <= 50) {
			output("You blush nervously as you grasp your phallic toy. The firm dildo bends slightly as you hold it in your hand. You feel perverse to consider doing this, and shakingly drop your [pc.gear].");
			output("\n\nSitting on your ");
			if (pc.isBiped()) output("[pc.butt]");
			else output("[pc.lowerBody]");
			output(", you begin to rub the length of the slender tube against your [pc.vagina], the gentle stimulation calming your nerves and helping to relax the tension.  As you pick up the pace, moans begin to escape your lips.  Your [pc.clit] fills with blood and twitches as the faux cock slides against it.  You tenderly caress your [pc.nipples] with your other hand, becoming more breathy as you do so. ");
			if (pc.wetness() <= 2)
				output("The toy slides easier as your juices cover it.");
			else output("The toy slides effortlessly thanks to your copious, almost inhuman lubrication.");

			output("\n\nSwallowing, you lean back and position the dildo toward your [pc.vagina], the entrance twitching as it yearns for penetration. With an experimental push, you prod at the hole, jumping at the realization of how large the object really is. It's not nearly as thin, short, and bendable as a finger. You think about why you'd do such a thing. Your virginity too precious to risk a demon stealing away, or perhaps you're simply grown more perverted in this corrupt world. Whatever the case, you bite your [pc.lip] and press the toy into you. Your decision made, the pain of your splitting hymen shoots through you. You gasp, easing the pressure on the toy, letting it sink one more inch before letting go altogether.");
			pc.cuntChange(0, dildo.effectiveVolume(), true, true, false);
			//Cunt change text go here!
			output("\n\nBreathing heavily, you slowly pull the invasive, fake phallus from your stinging vagina. A light stain of blood now coats the first several inches of the dildo. Taking a deep breath, you push the toy back in, this time feeling less pain. The worst of the experience behind you, you gently pump in and out. Your once pure pussy is now accepting the intruder deeply. Your speed increases as you get used to it. Breathing heavier in between moans, you thrust your cherry-picker in towards unforeseen ecstasy. The tears in your eyes, accumulated from pain, well up even larger in pleasure. Using one hand to piston the imitation cock in your [pc.vagina] and the other to massage around your [pc.clit], the stimulation becomes almost unbearable. Even with the remnants of pain from your recent deflowering, you can't help but");
			if (pc.legCount <= 2) output(" grind your [pc.hips] and slide slowly onto your back");
			output(" in preparation for your first penetrative orgasm. Your moans becoming louder and more intense while vaginal juices drip down. In one last screaming moan, your thighs lift, and you thrust the dildo as deeply into you as it will go, pushing you over the edge into orgasm.");
			output("\n\nYou rest your ");
			if (pc.isBiped()) output("[pc.butt]");
			else output("[pc.lowerBody]");
			output(" back onto the ground and your arms limply at your sides. After several minutes of catching your breath, you pull the toy out of you with a sigh of relief and pleasure. The experience has been quite draining; you decide to rest for some time longer before cleaning up.");
		}
		//50+ Corruption Shit
		else {
			output("\n\nYou blush perversely as you grasp your phallic toy. The firm dildo bends slightly as you hold it in your hand. A small jolt of giddiness runs through you as you remove your [pc.gear].");
			output("\n\nPrancing nude to a comfortable spot, you proceed to rest on your [pc.butt] and place the toy cock aside as you eagerly prepare your [pc.vagina]. You rub your lips gently as you relax your vaginal muscles. Not wishing to leave your mouth out of the fun, you grasp this dildo and begin to lick and suckle it. The passion of the act urging you on, you push a finger inside your [pc.vagina]. Its tight grip on your finger emphasizes the inexperience of the little hole - a problem you're soon to fix.");
			output("\n\nWith your faux phallus slick with saliva, you remove the digit from your virgin depths. You press the tip against your entrance, savouring your last moments of virginity. Your poor hymen was only an obstacle for cock, and you're the only one truly worthy of taking your virginity. You push the lust-driving object inside. Pain shoots through you, forcing a gasp from you, but failing to halt your beloved cherry-picker's progress. When you finally reach the greatest depth you can, you release the dildo, breathing deeply as the pain passes.");
			//CUNT CHANGE CALL
			pc.cuntChange(0, dildo.effectiveVolume(), true, true, false);
			output("\n\nYet to be satisfied, you regain composure and start pumping into your freshly plucked flower. Your other hand rushes to massage and caress your sensitive [pc.chest]. The fantasies of all the monstrous cocks you'll have thrusted into you spur the rough piston motion, eager to train your [pc.vagina] for its fated task. You slide");
			if (pc.legCount <= 2) output(" onto your back");
			else output(" lower");
			output(" as your body devotes itself to pleasure, moans and whimpers fleeting from your mouth. The stimulation builds, only enhanced by the mild pain of inexperience, and within minutes you tense up and scream in ecstasy. Fluids squirt from your [pc.vagina], and you smile gleefully. When the orgasm has passed, you pull your well-used toy from your newly trained slutting-slot. You bring the dildo to your lips to give it an affectionate kiss and lick your virginal blood from it's surface.");
			output("\n\nAfter basking in the afterglow, you clean yourself up and redress.");
		}
	}
	//Repeat Dildo For Ladyboners
	else {
		output("You remove your [pc.gear] and sit yourself down, being sure to bring your toy with you.");
		if (pc.isBiped()) output("\n\nSpreading your [pc.legs], y");
		else output("\n\nY");
		output("ou rub two fingers between your lips, while also suckling your healthy - sized faux cock to lubricate it. Your [pc.vagina] becomes slick with your [pc.femCum] in moments and you eagerly delve a [pc.finger] into the thirsty hole. The digit goes in slowly and deeply, pleasuring your inner walls with tender stimulation. Your muscles begin to relax, and you feel ready to move onto the main event. Removing the saliva - slicked toy from your mouth, you trade it with your [pc.finger]. The satisfying easing of the dildo into your nethers is matched by your [pc.girlCumFlavor] flavor pushing across your [pc.tongue]. Muffled moans escape your plugged maw as the beloved toy sinks deep into your [pc.vagina]. Using your free hand, you grope and caress your [pc.chest].");
		pc.cuntChange(0, dildo.effectiveVolume(), true, true, false);
		output("\n\nThe erotic pumping of the phallic object picks up the pace as you gently build a rhythm with the beating of your heart and tensing of your vaginal walls. Your breathing heaves, and your moans become almost as desperate as they are lustful. Soon the pleasure is rising up into unstoppable tide of phallus-induced ecstasy, and you slide from against the rock to on your side, still fucking yourself with blissful joy. The constant thrusting of the toy begins to make you shake and lose rhythm, your body wanting only to fuck as hard and fast as possible.");
		output("\n\nYour orgasm arrives with supreme relief as you force the dildo to your furthest depths. Juices spurt from your genitals, and you roll onto your back to rest. When your breathing regulates, you pull the thoroughly used toy from your [pc.vagina] and prepare to move on.");
	}
	processTime(15 + rand(10));
	pc.orgasm();
	//dynStats("sen", -1.5);
	//statScreenRefresh();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Dildo in the butt because why not?
public function CoCDildoButts():void {
	clearOutput();
	
	var dildo:CockClass = new CockClass();
	dildo.cLengthRaw = 7;
	
	output("A kinky idea crosses your mind, and you grab your dildo, get rid of your [pc.gear] and rest on your [pc.butt].");
	output("\n\nYou adjust your position");
	if(pc.isBiped()) output(" as you spread your [pc.legs]");
	output(", giving you the most comfortable access to your [pc.asshole]. You sloppily lick an experimental [pc.finger] and carry it down to the eager entrance between your cheeks. ");
	if (pc.analCapacity() <= dildo.effectiveVolume())
		output("Your tight hole offers resistance at first, but soon relaxes with a tender, lubricated fingering.");
	else output("Your stretchy hole readily accepts your saliva-coated finger.");
	output(" As you gently rub your insides, you use your free hand and reach up to pinch and rub your [pc.nipples]. As the motions become easier, you push a second finger inside as well. You soon find your sensitive anal entrance begging for something more appropriate, and you happily oblige.");
	output("\n\nGrabbing your toy, you give it several long wet licks before");
	if (pc.isBiped()) output(" holding your [pc.legs] up");
	output(" and sending the substitute cock to its true task. You rub the tip against your [pc.asshole] momentarily before finally pushing it inside.");
	pc.buttChange(dildo.effectiveVolume(), true, true, false);
	output(" Stuttering moans escape your lips as your butt gets its much-needed fill of firm faux phallus");
	if (silly) output(", the alliteration of the experience further arousing you");
	output(". Y");
	if (pc.hasToes()) output("our [pc.toes] curl as y");
	output("ou begin to pull in and out, pumping the dildo with smooth motions. Your [pc.tongue] hangs from your mouth, your breathing becomes heavy, and your moans lewdly express pure lust as you increase your tempo. Before too long, you feel your pucker becoming more sensitive and know an orgasm is quickly approaching.");
	
	if (pc.hasCock() && pc.hasVagina())
		output("\n\nYou moan in ecstasy while your [pc.vagina] and [pc.cocks] erupt with sex juices. ");
	else if (pc.hasCock())
		output("\n\nYou moan in ecstasy while [pc.cum] spurts from your [pc.cocks]. ");
	else if (pc.hasVagina()) {
		output("\n\nYou moan in ecstasy while [pc.femCum] ");
		if (pc.isSquirter())
			output("squirt");
		else output("trickle");
		output(" from your [pc.vagina]. ");
	}
	else output("\n\n");
	output("Your body shakes and rocks from the anal orgasm");
	if (pc.legCount <= 2) output(" before slumping onto your back");
	output(". Happily tightening around the toy with each beat of your hammering heart, you rest.");
	output("\n\nSome time later, you gather your things and return to your business.");
	processTime(20 + rand(10));
	pc.orgasm();
	//dynStats("sen", 0.5);
	//statScreenRefresh();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}