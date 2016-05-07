import classes.Characters.CoC.CoCImpHorde;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

private function fightImpHorde():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCImpHorde());
	CombatManager.victoryScene(ZetazCaveImpGangVICTORY);
	CombatManager.lossScene(ZetazCaveLoseToImpMob);
	CombatManager.displayLocation("IMP HORDE");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//Imp gang
public function ZetazCaveImpGangVICTORY():void {
	clearOutput();
	//Flag them defeated!
	flags["COC.ZETAZ_IMP_HORDE_DEFEATED"] = 1;
	
	if(enemy.HP() <= 1) output("The last of the imps collapses into the pile of his defeated comrades.  You're not sure how you managed to win a lopsided fight, but it's a testament to your new-found prowess that you succeeded at all.");
	else output("The last of the imps collapses, pulling its demon-prick free from the confines of its loincloth.  Surrounded by masturbating imps, you sigh as you realize how enslaved by their libidos the foul creatures are.\n\n");
	
	clearMenu();
	addButton(14, "Leave", function():*{
		processTime(15 + rand(10));
		CombatManager.genericVictory();
	} );
	
	addDisabledButton(0, "Male Rape", "Male Rape", "This scene requires you to have cock.");
	addDisabledButton(1, "Female Rape", "Female Rape", "This scene requires you to have vagina.");
	
	if(pc.lust() >= 33 && pc.hasGenitals()) {
		output("Feeling a bit horny, you wonder if you should use them to sate your budding urges before moving on.  Do you rape them?\n\n");
		if (pc.hasCock()) addButton(0, "Male Rape", ZetazCaveImpGangGetsRapedByMale);
		if (pc.hasVagina()) addButton(1, "Female Rape", ZetazCaveImpGangGetsRapedByFemale);
	}
}

public function ZetazCaveImpGangGetsRapedByMale():void {
	clearOutput();
	output("You walk around and pick out three of the demons with the cutest, girliest faces.  You set them on a table and pull aside your [pc.gear], revealing your [pc.cocksLight].  You say, \"<i>Lick,</i>\" in a tone that brooks no argument.  The feminine imps nod and open wide, letting their long tongues free.   Narrow and slightly forked at the tips, the slippery tongues wrap around your [pc.cock], slurping wetly as they pass over each other in their attempts to please you.\n\n");
	
	output("Grabbing the center one by his horns, you pull him forwards until your shaft is pressed against the back of his throat.  He gags audibly, but you pull him back before it can overwhelm him, only to slam it in deep again.  ");
	output("The girly imp to your left, seeing how occupied your [pc.cock] is, shifts his attention down to your ");
	if(pc.balls > 0) output("[pc.balls]");
	else if(pc.hasVagina()) output("[pc.vagina]");
	else output("[pc.asshole]");
	output(", licking with care");
	if(pc.balls == 0) output(" and plunging deep inside");
	output(".  The imp to the right wraps his tongue around the base ");
	if(pc.hasSheath()) output("just above your sheath ");
	output(" and pulls it tight, acting as an organic cock-ring.\n\n");
	
	output("Fucking the little bitch of a demon is just too good, and you quickly reach orgasm.  ");
	if(pc.balls > 0) output("Cum boils in your balls, ready to paint your foe [pc.cumColor].  ");
	output("With a mighty heave, you yank the imp forward, ramming your cock deep into his throat.  He gurgles noisily as you unload directly into his belly.   Sloshing wet noises echo in the room as his belly bulges slightly from the load, and his nose dribbles cum.   You pull him off and push him away.  He coughs and sputters, but immediately starts stroking himself, too turned on to care.");
	if(pc.cumQ() > 1000) output("  You keep cumming while the other two imps keep licking and servicing you.   By the time you finish, they're glazed in spooge and masturbating as well.");
	output("\n\n");
	
	output("Satisfied, you redress and prepare to continue with your exploration of the cave.\n\n");
	pc.orgasm();
	
	processTime(25 + rand(10));
	CombatManager.genericVictory();
}
public function ZetazCaveImpGangGetsRapedByFemale():void {
	clearOutput();
	output("You walk around to one of the demons and push him onto his back.  Your [pc.gear] falls to the ground around you as you disrobe, looking over your tiny conquest.  A quick ripping motion disposes of his tiny loincloth, leaving his thick demon-tool totally unprotected. You grab and squat down towards it, rubbing the corrupted tool between your legs ");
	if(pc.vaginas[0].wetness() >= 3) output("and coating it with feminine drool ");
	output("as you become more and more aroused.  It parts your lips and slowly slides in.  The ring of tainted nodules tickles you just right as you take the oddly textured member further and further into your willing depths.");
	pc.cuntChange(0, enemy.cockVolume(0), true, true, false);	
	output("\n\n");
	
	output("At last you feel it bottom out, bumping against your cervix with the tiniest amount of pressure.  Grinning like a cat with the cream, you swivel your hips, grinding your [pc.clit] against him in triumph.  ");
	if(pc.clitLength > 3) output("You stroke the cock-like appendage in your hand, trembling with delight.  ");
	output("You begin riding the tiny demon, lifting up, and then dropping down, feeling each of the nodes gliding along your sex-lubed walls.   As time passes and your pleasure mounts, you pick up the pace, until you're bouncing happily atop your living demon-dildo.\n\n");
	
	output("The two of you cum together, though the demon's pleasure starts first.  A blast of his tainted seed pushes you over the edge.  You sink the whole way down, feeling him bump your cervix and twitch inside you, the bumps on his dick swelling in a pulsating wave in time with each explosion of fluid.  ");
	if(pc.isSquirter()) output("Cunt juices splatter him as you squirt explosively, leaving a puddle underneath him.  ");
	else output("Cunt juices drip down his shaft, oozing off his balls to puddle underneath him.  ");
	output("The two of you lie together, trembling happily as you're filled to the brim with tainted fluids.\n\n");
	
	output("Sated for now, you rise up, your body dripping gooey whiteness.  Though in retrospect it isn't nearly as much as was pumped into your womb.");
	if (!pc.isPregnant()) output("  You'll likely get pregnant.");
	output("\n\n");
	pc.orgasm();
	//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14, 50);
	pc.loadInCunt(enemy);
	
	processTime(25 + rand(10));
	CombatManager.genericVictory();
}

public function ZetazCaveLoseToImpMob():void {
	clearOutput();
	//(HP) 
	if(pc.HP() <= 1) output("Unable to handle your myriad wounds, you collapse with your strength exhausted.\n\n");
	//(LUST)
	else output("Unable to handle the lust coursing through your body, you give up and collapse, hoping the mob will get you off.\n\n");
	
	output("In seconds, the squirming red bodies swarm over you, blotting the rest of the room from your vision.  You can feel their scrabbling fingers and hands tearing off your [pc.gear], exposing your body to their always hungry eyes.   Their loincloths disappear as their growing demonic members make themselves known, pushing the tiny flaps of fabric out of the way or outright tearing through them.   You're groped, touched, and licked all over, drowning in a sea of long tongues and small nude bodies.\n\n");
			   
	output("You're grabbed by the chin, and your jaw is pried open to make room for a swollen dog-dick.   It's shoved in without any warmup or fan-fare, and you're forced to taste his pre in the back of your throat.  You don't dare bite down or resist in such a compromised position, and you're forced to try and suppress your gag reflex and keep your teeth back as he pushes the rest of the way in, burying his knot behind your lips.\n\n");
	
	//(tits)
	if(pc.biggestTitSize() > 1) {
		output("A sudden weight drops onto your chest as one of the demons straddles your belly, allowing his thick, tainted fuck-stick to plop down between your [pc.fullChest].  The hot fluid leaking from his nodule-ringed crown  swiftly lubricates your cleavage.  In seconds the little devil is squeezing your [pc.breast] around himself as he starts pounding his member into your tits.  The purplish tip peeks out between your jiggling flesh mounds, dripping with tainted moisture.");
		if(pc.isLactating()) output("  Your [pc.milk] starts to squirt from the pressure being applied to your [pc.breasts], which only encourages the imp to squeeze even harder.");
		output("\n\n", false);
	}
	//(NIPPLECUNTS!)
	if(pc.hasFuckableNipples()) {
		output("A rough tweak on one of your nipples startles you, but your grunt of protest is turned into a muffled moan when one of the imp's tiny fingers plunges inside your [pc.nipple].  He pulls his hand out, marveling at the sticky mess, and wastes no time grabbing the top of your tit with both hands and plunging himself in.");
		if(pc.biggestTitSize() < 7) output("  He can only get partway in, but it doesn't seem to deter him.");
		else output("  Thanks to your massive bust, he is able to fit his entire throbbing prick inside you.");
		output("  The demon starts pounding your tit with inhuman vigor, making the entire thing wobble enticingly.  The others, seeing their brother's good time, pounce on ");
		if(pc.totalNipples() > 2) output("each of ");
		output("your other [pc.nipple]");
		if(pc.totalNipples() > 2) output("s");
		output(", fighting over the opening");
		if(pc.totalNipples() > 2) output("s");
		output(".  A victor quickly emerges, and in no time ");
		if(pc.totalNipples() == 2) output("both");
		else output("all the");
		output(" openings on your chest are plugged with a tumescent demon-cock.\n\n");
	}
	//(SINGLE PEN) 
	if(!pc.hasVagina()) {
		output("Most of the crowd centers itself around your lower body, taking a good long look at your [pc.asshole].  An intrepid imp steps forwards and pushes his member into the unfilled orifice.  You're stretched wide by the massive and unexpectedly forceful intrusion.  The tiny corrupted nodules stroke every inch of your interior, eliciting uncontrollable spasms from your inner muscles.  The unintentional dick massage gives your rapist a wide smile, and he reaches down to smack your ass over and over again throughout the ordeal.");
		pc.buttChange(enemy.cockVolume(0), true, true, false);
		output("\n\n");
	}
	//(DOUBLE PEN)
	else {
		output("Most of the crowd centers itself around your lower body, taking a good long look at your pussy and asshole.  Two intrepid imps step forward and push their members into the unplugged orifices.  You're stretched wide by the massive, unexpectedly forceful intrusions.  The tiny corrupted nodules stroke every inch of your interiors, eliciting uncontrollable spasms from your inner walls.  The unintentional dick massage gives your rapists knowing smiles, and they go to town on your ass, slapping it repeatedly as they double-penetrate you.");
		pc.buttChange(enemy.cockVolume(0), true, true, false);
		pc.cuntChange(0, enemy.cockVolume(0), true, true, false);
		output("\n\n");
	}
	//(DICK!)
	if(pc.hasCock()) {
		output("Some of the other imps, feeling left out, fish out your [pc.cocks].  They pull their own members alongside yours and begin humping against you, frotting as their demonic lubricants coat the bundle of cock with slippery slime.   Tiny hands bundle the dicks together and you find yourself enjoying the stimulation in spite of the brutal fucking you're forced to take.  Pre bubbles up, mixing with the demonic seed that leaks from your captors members until your crotch is sticky with frothing pre.\n\n");
	}
	//(ORGAZMO)
	output("As one, the crowd of demons orgasm.  Hot spunk gushes into your ass, filling you with uncomfortable pressure.  ");
	if(pc.hasVagina()) output("A thick load bastes your pussy with whiteness, and you can feel it seeping deeper inside your fertile womb.  ");
	output("Your mouth is filled with a wave of thick cream.  Plugged as you are by the demon's knot, you're forced to guzzle down the stuff, lest you choke on his tainted baby-batter.");
	if(pc.biggestTitSize() > 1) {
		output("  More and more hits your chin as the dick sandwiched between your tits unloads, leaving the whitish juice to dribble down to your neck.");
		if(pc.hasFuckableNipples()) {
			if(pc.totalNipples() == 2) output("  The pair");
			else output("  The group");
			output(" of cocks buried in your [pc.nipple] pull free before they cum, dumping the spooge into the gaping holes they've left behind.  It tingles hotly, making you quiver with pleasure.");
		}
	}
	output("  Finally, your own orgasm arrives, ");
	if(pc.cockTotal() == 0) output("and you clench tightly around the uncomfortable intrusion.");
	else {
		output("and [pc.cocksLight] unloads, splattering the many demons with a bit of your own [pc.cum].  You'd smile if your mouth wasn't so full of cock.  At least you got to make a mess of them!");
	}
	if(pc.hasVagina()) {
		output("  Your cunt clenches around the invading cock as orgasm takes you, massaging the demonic tool with its instinctual desire to breed.  Somehow you get him off again, and take another squirt of seed into your waiting cunt.");
	}
	output("\n\n");
	
	output("Powerless and in the throes of post-coital bliss, you don't object as you're lifted on the table");
	if(!pc.hasVagina()) output(" and forced to start drinking bottle after bottle of succubi milk");
	output(".  You pass out just as round two is getting started, but the demons don't seem to mind....");
	clearMenu();
	addButton(0, "Next", ZetazCaveLoseToImpMobII);
}

//[IMP GANGBANG VOL 2]
public function ZetazCaveLoseToImpMobII():void {
	clearOutput();
	output("You wake up, sore from the previous activity and a bit groggy.  You try to move, but find yourself incapable.  Struggling futilely, you thrash around until you realize your arms and legs are strapped down with heavy iron restraints.  You gasp out loud when you look down and discover your ");
	if(pc.biggestTitSize() < 1) output("new");
	else output("much larger");
	output(" tits, wobbling with every twist and movement you make.  You're stark naked, save for a sheer and somewhat perverse nurse's outfit.   The room around you looks to be empty, though you can see a number of blankets piled in the corners and a few cages full of spooge-covered faeries, all snoring contently.\n\n");
	
	output("Eventually a lone imp enters the room.  It's Zetaz!  He looks you up and down and decrees, \"<i>You're ready.</i>\"  You struggle to shout him down, but all that escapes the gag in your mouth is incomprehensible gibberish.  He chuckles and flips a switch on the wall, and suddenly the most heavenly vibration begins within your sopping twat.");
	if(!pc.hasVagina()) {
		output(".. Wait, your what?  You have a cunt now!?");
	}
	output("  Your eyes cross at the pleasure as your mind struggles to figure out why it feels so good.\n\n");
	
	output("Zetaz pours a few bottles into a larger container and connects a tube to an opening on the bottom of the bottle.  Your eyes trace the tube back to the gag in your mouth, and after feeling around with your tongue, you realize it's been threaded through the gag and down your throat.   Zetaz lifts up the bottle and hangs it from a hook on the ceiling, and you watch in horror as the fluid flows through the tube, helpless to stop it.  You shake your head desperately, furious at having fallen into the little fucker's hands at last.\n\n");
	
	output("Zetaz walks up and paws at your ");
	if(pc.biggestTitSize() < 1) output("new");
	else output("larger");
	output(" mounds, flitting into the air to bring himself to eye-level.  He rambles, \"<i>It's so good to see you again, [pc.name].  Because of you, I had to flee from my honored place by Lethice's side.  I've had to hide in this fetid forest.  I'll admit, it hasn't been all bad.  We've caught a few faeries to play with, and with you here, the boys and I will have lots of fun.  We just need to reshape that troubled mind a little bit.</i>\"\n\n");
	
	output("You barely register his monologue.  You're far too busy cumming hard on the vibrating intruder that's currently giving your stuffed snatch the workout of a lifetime.  Zetaz chuckles at your vacant stare and massages your temples gently, and you feel the touch of his dark magic INSIDE you.  It feels warm and wet, matching the feel of your body's other intrusion.   You try to fight it, and for a moment you feel like you might push the demon out of your mind.  Then your body cums, and your resistance melts away.  You violently thrash against your restraints, caving in to the pleasure as the imp rapes your body and mind as one.\n\n");
	
	output("The desire to protect your village drips out between your legs, and thoughts of your independence are fucked away into nothing.  It feels good to cum, and your eyes cross when you see the bulge at your master's crotch, indicative of how well you're pleasing him.  It feels so good to obey!  Zetaz suddenly kisses you, and you enthusiastically respond in between orgasms.\n\n");
	
	output("You gladly live out the rest of your life, fucking and birthing imps over and over as their live-in broodmother.");
	pc.orgasm();
	pc.HP(pc.maxHP());
	//GAME OVER NERD
	badEnd();
}