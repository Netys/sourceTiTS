import classes.Characters.CoC.CoCTamani;
import classes.Characters.CoC.CoCTamanisDaughters;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//New Status:
//+Tamani's Husband – (Still need too big loss scene and centaur version)
//--Every point in it adds to lust gain per turn vs Tamani or Tamani/wdaughters
//--Slight alteration to some scenes
//--Leads up to perk with Tamani autosexing (maybe bad end)

//Fuck Them:
//	*Fits
//	 *Alternate Tamani scenes directly in the event.
//	*Doesnt Fit
//	 *Alternate Tamani scenes directly in the event.

//Let Them:
//	*Fits
//	 *Tamani Is Here
//	 *No Tamani
//	*Doesnt Fit
//	 *No Tamani
//	 *Tamani is here

//Win:
	//*Rape -> "Fuck Them" scenes.

//Lose:
//	*Daughters drag PC back to caves and milking machine action ensues.
//	*Tamani is there and hypno's the PC, then orgy ensues.

//Variables to track:
//	Number of Daughters – Capped at 19 if PC has not yet encountered them yet.
	//"Tamani" v2
//	Times Encountered – 0 → infinity
	//flags["COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS"]
//	Tamani Hypno Level – increases by 1 for each hypno event.  1-4 slight lust raises, 5-9 medium lust raises, 10-19 super high lust raises, 20+ high chance of autorape with special scene. 
	//flags["COC.TAMANI_TIMES_HYPNOTISED"]
//	Daughter Preg Counter – they will not return until this countdown timer is 0.  Same length as Tamani's incubation – approx 1 week. 
	//flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN]	
//Tamani's Daughters – Tracked every birthing.  High cum production characters will produce more //Tamani babies and thus grow the mob (and achieve bad-end) faster.  
	//Tamani's Daughters first arrive after #12 is born.  
	//Tamani's Daughters encounter is expanded after #20
	//Tamani's Daughters gets much harder @ #40
	//Tamani's Daughters gets nigh-impossible @ #60

//public var pregnancy:PregnancyStore;
//
//public function TamainsDaughtersScene()
//{
	//pregnancy = new PregnancyStore(kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE, kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN, 0, 0);
	//CoC.timeAwareClassAdd(this);
//}

//Implementation of TimeAwareInterface
public function TamaniDaughtersTimePassedNotify():void
{
	if (minutes != 0) return;
	if (flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"] > 0) flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"]--;
	//pregnancy.pregnancyAdvance(); //Preg should be 7*24, ends at 0 to -48 --> 9*24, ends at 0
	//trace("\nTamani's Daughters time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
	if (flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"] == 0) {
		flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"]) + int(flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]);
		flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"] = undefined;
		flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"] = undefined; //Clear Pregnancy
	}
	//Put a cap on daughters if they havent been met yet.
	if (int(flags["COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS"]) == 0 && flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] > 30) {
		flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] = 30;
	}
	//Lower daughter population by 1 every fourth day once population gets high
	if (flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] > 40 && hours == 0 && days % 4 == 0) {
		flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"]--;
	}
	return;
}

private var TamaniDaughtersTimePassedNotifyHook: * = TamaniDaughtersTimePassedNotifyGrapple();
private function TamaniDaughtersTimePassedNotifyGrapple():* { 
		timeChangeListeners.push(TamaniDaughtersTimePassedNotify);
	}

public function get tamaniPresent():Boolean {
	return flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] == 1;
}

//Prime daughter tit-size
//12-20 – C
//21- 40 DD
//41 –60 E
//30+ - F mother fucker!
private function tdCup():String {
	var daughtersCount:int = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"]);
	if (daughtersCount < 20) return "C";
	else if (daughtersCount < 30) return "D";
	else if (daughtersCount < 40) return "DD";
	else if (daughtersCount < 50) return "E";
	else if (daughtersCount < 60) return "EE";
	return "F";
}


//ENCOUNTER:
public function encounterTamanisDaughters():void {
	//spriteSelect(57);
	IncrementFlag("COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS");
	clearOutput();
	if (flags["COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS"] > 1 && rand(10) == 0) {
		flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] = 1;
		//tamaniPresent = true;
		output("While roaming along, you find your path ahead blocked by " + num2Text(int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 4)) + " goblins.  At the forefront of the mob is Tamani");
		if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) >= 10) output(", your wife");
		output(".  You realize now that the other goblins must be your daughters.  Another crowd of small women emerges from the bushes, closing in a ring around you, preventing any chance of escape.  The largest of the younger goblin-women steps forwards, her " + tdCup() + " breasts jiggling, barely contained by the bondage ropes she has tied around herself.  She stops once she's next to her mother and Tamani explains, \"<i>I just can't keep their aching cunts at home anymore!  They're fertile adults now and they're wanting to get some experience with real dicks.  I figured you wouldn't mind helping them out a little.</i>\"\n\nWhat do you do? (Fight them off, Fuck them willingly, Let them fuck you)");
		//[Fuck Them] [Let Them] [Fight]
		clearMenu();
		addButton(0, "Fight", fightTamanisDaughters);
		addButton(1, "Fuck Them", fuckYoDaughtersHomie);
		addButton(2, "Let Them", legTamanisDaughtersRAEPYou);
		return;
	}
	flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] = 0;
	output("While roaming along, you find your path ahead blocked by " + num2Text(int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 4)) + " goblins.  You [pc.readyWeapon] and glance around evaluating your options.   Another crowd of small women emerges from the bushes, closing in a ring around you, preventing any chance of escape.  The largest of the goblin-women steps forwards, her " + tdCup() + "-breasts jiggling, barely contained by the bondage ropes she has tied around herself.\n\n");
	//first time
	if (int(flags["COC.TIMES_FUCKED_TAMANIS_DAUGHTERS"]) == 0) {
		output("She calls out, \"<i>We're tired of getting leftovers, so we're coming to the source.  Are you going to give us what we want?</i>\"\n\n");
		//[Fuck them] [Fight] [Play Dumb]
		clearMenu();
		addButton(0, "Fight", fightTamanisDaughters);
		addButton(1, "Fuck Them", fuckYoDaughtersHomie);
		addButton(2, "Let Them", legTamanisDaughtersRAEPYou);
		addButton(3, "Play Dumb", playDumbToTamanisDaughters);
	}
	else {
		output("She calls out, \"<i>We came back for more cream!  Come on, let's fuck again!</i>\"\n\nIt doesn't look like 'no' is a word they understand.  What do you do?</i>");
		clearMenu();
		addButton(0, "Fight", fightTamanisDaughters);
		addButton(1, "Fuck Them", fuckYoDaughtersHomie);
		addButton(2, "Let Them", legTamanisDaughtersRAEPYou);
	}
}

public function fightTamanisDaughters():void {
	var mob:CoCTamanisDaughters = new CoCTamanisDaughters();
	if (flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] == 1) {
		mob.HPMod += 10;
		mob.lust( -20);
		mob.maxOutHP();
	}
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(mob);
	CombatManager.victoryScene(combatWinAgainstDaughters);
	CombatManager.lossScene(loseToDaughters);
	CombatManager.displayLocation("GOBLIN MOB");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//[Play Dumb]
private function playDumbToTamanisDaughters():void {
	//spriteSelect(57);
	clearOutput();
	output("You shrug and ask, \"<i>What exactly is it you want again?  I'm not sure you have the right " + pc.mf("guy", "person") + ".</i>\"\n\n");
	
	//approx 33% chance at 0 int, going up the smarter you are.
	if (pc.intelligence() / 2 + 25 > rand(75)) {
		output("The leader looks you up and down for a moment.  Her face slowly contorts to puzzlement, then rage, \"<i>Tammi you ditz!  I thought you said this was his trail?  Come on girls, we've got a dad to hunt.</i>\"\n\n");
		if (flags["COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS"] > 1) output("They really must not be paying much attention to what you look like.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	
	output("The leader stamps her foot in a fit of rage.  It would be more imposing if she wasn't three feet tall... Her eyes lock onto your crotch and she says, \"<i>Last chance.   We're getting our ");
	if (flags["COC.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS"] == 1) output("first ");
	output("litters one way or another!</i>\"\n\n");
	
	//[Fuck them] [Fight] [Let them have their way with you]
	clearMenu();
	addButton(0, "Fight", fightTamanisDaughters);
	addButton(1, "Fuck Them", fuckYoDaughtersHomie);
	addButton(2, "Let Them", legTamanisDaughtersRAEPYou);
}

//(COMBAT TEXT:  You're fighting Tamani's brood.  All total, there are (x) of them spread in a loose circle around you.  Most of them have their hair dyed wild colors, and dress in little more than fetish clothing – for easy access you assume.  Some are dolled up with make-up, others have oiled their luscious forms, and a few are stopping to kiss and lick each other, putting on a show for their latest victim.  (Tamani is here as well, fighting her way to the forefront and absently massaging one of her \" + tamaniChest + \" as eyehumps your body.\")
//(Combat is 1 attack per 10 girls + 1x Tamani attack)

//[Fuck them]
private function fuckYoDaughtersHomie():void {
	//spriteSelect(57);
	IncrementFlag("COC.TIMES_FUCKED_TAMANIS_DAUGHTERS");
	var cocks:Number = pc.totalCocks();
	var daughters:Number = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 2);
	
	clearOutput();
	output("You shrug out of your [pc.gear] and grab hold of [pc.oneCock], swinging it around as it hardens, teasing the crowd of lusty bitches.\n\n"); 

	output("\"<i>Come and get it,</i>\" you shout, strutting forwards.  The ");
	if (daughters < 12) output("girls");
	else output("crowd");
	output(" surges forwards, mobbing you from all sides.  ");

	//Find a dick that fits
	var primary:Number = pc.cockThatFits(cockVolume(50));
	//(Fits)
	if (primary >= 0) {
		output("You pick a random body from the crowd, impaling her on your " + pc.cockDescript(primary) + ".  The others crowd around, jealous of your chosen cock-sleeve.   She looks up at you, blissful as she hugs against you and grinds her tight body down, raping her virginal hole on the firmness of your " + pc.cockDescript(primary) + ".   The others massage your " + pc.legs() + ", licking and nibbling your skin as they compete to tempt you into taking them next.");
		if (tamaniPresent) {
			output("  Tamani pushes aside the smaller sluts and ");
			if (pc.balls > 0) output("cups your " + pc.ballsDescript() + ".");
			else output("licks your taint.");
		}
		output("\n\n");
		
		output("In no time, the vise-like grip of her cunt and thrill of taking her virginal passage push you beyond your threshold.  You groan and pump thick loads of jism deep into the tiny twat");
		if (pc.cumQ() >= 500) output(", bloating her belly until she gurgles and squishes on top of you");
		output(".  She falls off with her eyes crossed as her sisters scramble to take her place.");
		if (tamaniPresent) {
			output("  Tamani shoves the rest of them away and mounts you, ");
			if (pc.tallness >= 60) output("scrabbling up enough to ");
			output("kiss you roughly on the lips, tasting of cherries and sweat.  Your body goes limp, dropping down onto your back as your green mistress has her way with you.\n\n");
		}
		else {
			output("  Another mounts you, launching herself at you with such force that she knocks you off your " + pc.feet() + " and onto your back.  A hand clamps over your mouth and jams something inside while another massages your throat, forcing you to swallow it.  Numbness flows through most of your body, robbing you of strength and feeling in all but one place...\n\n");
		}
		
		output("You're swarmed as you lie in the mud, covered head to toe in nubile young goblin flesh.  Some part of you KNOWS you're being raped, but you're so effectively drugged there really isn't anything to do but try to enjoy it.   The tight goblin-cunt wrapped around your dickflesh refuses to let it go soft, massaging it with clenching ripples of muscle.  ");
		if (tamaniPresent) {
			output("Tamani's massive jugs rest against your " + pc.breastDescript(0) + ", bouncing and wobbling.  She crosses her arms over them and sucks on a finger, watching your expression with a mix of amusement and arousal.  She asks, \"<i>So what do you think of your daughters, sweet stuff?  They're just aching for a taste of their daddy's spunk, and it's hard to keep so many rambunctious sluts under control.</i>\"\n\n");
		}
		else output("Tamani's daughter looks up at you, giggling happily while her hips vigorously abuse you.   She asks, \"<i>Do you think my cunt is tighter than mom's is?  Bet you never thought you'd be fucking one of your daughters pregnant, did you?</i>\"\n\n");
		
		output("Such perverse thoughts, and coming from your own daughters.  ");
		if (pc.cor() < 33) output("You were supposed to save the village from corruption, not breed tiny sluts to overrun it... y");
		else if (pc.cor() < 66) output("You came here to make things better for everyone... well, at least you're helping these girls. Y");
		else output("You came here to make things better, but you know you'll keep knocking up Tamani every chance you get.  It's too much fun to resist adding to the sea of green girls. Y");
		output("ou moan as a drooling green cunt is pressed into your " + pc.face() + ", smothering away any protests you might have offered.  Your tongue laps away, servicing another one of your many goblin offspring as best it can.  It plunges deep to harvest her nectar, making her soak you with juice, performing oral as if it were possessed.  Your eyes cross and you feel your release building, cresting in a wave as it prepares to dump into your ");
		if (!tamaniPresent) output("daughter");
		else output("favorite goblin MILF");
		output(".\n\n");

		output("The pressure of orgasm spikes as the first blast takes ");
		if (!tamaniPresent) output("your goblin daughter");
		else output("Tamani");
		output(" in her waiting womb, painting her walls white.  Each successive glob mixes into the slurry of sexual fluids brewing in her slit, until it starts to dribble out.  The goblin on your face cums noisily, filling your mouth with female moisture.   With no other choice, you swallow it down while your tongue keeps trying to pleasure her.  A sudden void of sensation and cold air overtakes your " + pc.cockDescript(primary) + " as you hear the goblins squabbling.  In no time flat a fresh cunt is squeezing over your still-orgasming member, clamping down to form a tight seal as you pump it full of even more fertile seed.\n\n");

		//(Go to End if < 10 daughters), else keep goin
		if (daughters > 10) {
			output("As your orgasm trails off, your green cock-sleeve is removed.  You sigh happily, glad the ordeal is over.  Your " + pc.cockDescript(0) + " manages to continue to throb, and you wonder just how long you'll have to wait for the goblin drugs to wear off.  The answer comes sooner than you think, in the form of a large vial of sweet-tasting liquid.  Your nose is pinched shut by a teal hand and your throat is massaged until you swallow the entire thing.  The result is immediate.  Slight shakes work their way through your body as it reacts to the corrupted drugs.  ");
			if (pc.balls > 0) output("Your balls visibly puff up and slosh as one of your daughters plays with them, filling with more seed than ever before.");
			else output("Your gut clenches painfully as something inside puffs up.  Pressure builds at the base of your cock and you realize somehow you're more full of cum than ever before.");
			output("\n\n");
		
			if (tamaniPresent) {
				output("Tamani pushes the slut on your face off and plants herself there, smearing your " + pc.face() + " with a mixture of cum and vaginal wetness.  ");
				if (flags["COC.INCUBATION_TAMANI"] != undefined) {
					output("She rubs her pregnancy swollen belly");
				}
				else output("She fondles her nipples");
				output(" and moans as she grinds against you, \"<i>Ahh, you're going to have so many more daughters!  You realize if you keep cumming into them like this, I'll never be able to restrain them all.  So if you don't want to be gang-raped by your daughters like this you should probably stop orgasming, ok?  Just don't cream any more dripping virginal cunts.</i>\"\n\n");
			}
			//Else:  
			else {
				output("The first daughter to take your seed climbs onto your face and plants herself there, smearing your " + pc.face() + " with a mixture of cum and vaginal wetness.  She pinches her budding chest and grinds on top of you, asking, \"<i>You realize I'm going to be pregnant don't you?  I can already feel your little swimmers tickling all my eggs.  Can you imagine what I'll look like in a few days?  With bigger tits leaking milk and my belly stuffed with offspring?  Just let your dick do the thinking and keep cumming until we're all stuffed, ok?  Don't hold back now, we're just aching for more!</i>\"\n\n");
			}

			output("The perverse thoughts get to you, worming their way inside you until they reach your " + pc.cockDescript(primary) + ".  It clenches and explodes, packing the slut's womb with cream.  She's lifted off by her sisters, and your next blast fires into the air, splattering over the assembled goblins with a wet plop.  Many gather it up, licking and slurping it, or shoveling it directly into their waiting cunts.  Another pussy is placed on you, and the sensation of new flesh taking you makes the contraction feel even longer.  She staggers off a few moments later, looking pregnant already.  The cycle repeats until");
			if (daughters < 20) output(" the majority ");
			else output(" half ");
			output("of the girls have spooge-slicked cunts and big grins.\n\n");

			output("As your ");
			if (pc.balls > 1) output("[pc.balls] empty");
			else output("[pc.balls] empties");
			output(", one of the girls wanders over and asks, \"<i>How does it feel knowing your daughter is pregnant with even more children? Does it turn you on, <b>Daddy</b>?</i>\"\n\n");

			//(Go to end unless daughters > 20)
			if (daughters > 20) {
				output("You lie there, feeling like an empty husk.  The crowd starts to disperse");
				if (tamaniPresent) output(" while Tamani walks away");
				output(", but a few of the little sluts don't look satisfied yet.  They crowd around.  One straddles your chest and begins dancing in an erotic display.  Somehow, your " + pc.cockDescript(primary) + " still manages to twitch weakly in response.  Another goblin opens a satchel and pulls out some fruit and a canteen.  She delicately begins feeding you, clearing wanting you to regain your strength.  It seems they aren't finished with you yet.  You down what feels like gallons of water, and then find yourself presented with another flask of pink goo.  Shrugging, you gulp it down willingly, enjoying the sensation of your " + pc.cockDescript(0) + " re-inflating to its maximum, turgid size.\n\n");
				
				output("Sighing happily, you lie there as the remainder of your daughters take you, fucking you one after another.  The whole time you don't stop eating, converting all of the girl's rations into gallons of baby batter.  Your daughters don't seem to mind, and take turns posing sexily and feeding you while they take turns riding your pole until they're bloating and pregnant.  By the time the last one rises up on shaky legs, you're exhausted and your eyes are drifting closed.  ");
				if (daughters < 50) output("Girlish giggles sooth you to sleep as the crowd slowly disperses.");
				else output("Girlish giggles sooth you to sleep as your body caves in to its fatigue.  The last thing you hear is the biggest daughter suggesting, \"<i>We should keep daddy around all the time...</i>\"");
			}
		}
		//(Normal end)
		if (daughters <= 20) {
			output("Exhausted and shaken by the ordeal, you lie there as the girls regroup, gathering any dripping seed into bottles or their puffy cunts.  Several of them blow you kisses");
			if (tamaniPresent) output(" and Tamani passionately frenches you.");
			else output(".");
			output("  One of them licks your sore member and says, \"<i>Thanks for all the cream!</i>\"\n\n");
		}
	}
	//[DOESNT FIT]
	else {
		output("You pick a random girl from the crowd, and the others crowd around, jealous of your chosen cock-sleeve.   Her cries of excitement rapidly turn to pain when you try to push in though.  She's just too small, even for a goblin.  You set her down, disappointed, but then she lies down in the grass and spreads her legs wide.  She says, \"<i>Since you're too big for us, how about we take turns lining up on the ground while some of us suck out your sticky goop?</i>\"\n\n");
		
		output("The idea sounds great to you.  Two of the horny sluts are already climbing forwards while their sisters lay out, pulling their vulva apart and toying with their tiny green clits.  They must be twins, because aside from their wildly different hair, their features are identical.  The paired cock-sluts both kiss your swollen " + pc.cockHead() + ", then drag their lips and tongues over your length.  At first they're working in sync, but as their efforts intensify they slowly get out of rhythm, until they're each slobbering over a different part of your " + pc.cockDescript(0) + ".\n\n");
		
		if (tamaniPresent) {
			output("Tamani steps up and reaches into a pouch.  As she withdraws her hand, you get your first glimpse of her cargo.  It appears to be a massive double-ended dildo, pink and floppy.  One end is shaped like a canine, with a huge knot, while the other ends in the flared tip of a horse-cock.  Tamani grunts as she spears herself with the pointed canine side, even forcing the massive dildo's knot inside.  She releases the dildo and the horse-half bobbles imposingly in front of her, dripping pink fluids.  She grins up at you saying, \"<i>If my daughters are going to claim all your cream, I'm going to make sure you don't hold back.  You saw the knot on this thing, didn't you?  Well, it's filled with aphrodisiacs, so when I cum and clamp down on it, you'll be forced to squirt every ounce of seed into my girls.</i>\"\n\n");
		
			output("She disappears behind you and you cringe, knowing this will probably be at least slightly uncomfortable.  ");
			if (pc.tallness > 48) output("You can hear her climbing up on something behind you, in order to get to the right height.  ");
			output("Your expression of disdain is ruined when one of the sluts stretches wide and slurps your " + pc.cockHead() + " into her mouth.  Her tongue feels like heaven as it slides over your tip, and her sister works the shaft, jerking the spit-lubed monster off with fast strokes.   Your enjoyment is interrupted by a sudden intrusion at your backdoor.  The rubbery flared horse-toy presses against your " + pc.assholeDescript() + ", dribbling a little bit of its strange lubricants into your backdoor as Tamani pushes it forward.   Tiny hands grab your " + pc.buttDescript() + " as it's pushed forward, and you have no choice but to relax and allow it inside.\n\n");
			
			output("Half the head slips inside you, then the other, and in no time Tamani is slowly forcing it inside you.  It hurts just a little, enough to make your hips swivel forwards in a futile attempt at escape.  The goblin on your cock nearly chokes from the sudden change, though her sister gives you a wicked grin and strokes harder.  A flash of warmth squirts inside you in time with a moan from Tamani, and suddenly your body is exploding with pleasure.\n\n");
			
			output("Cum bubbles from the first goblin's nose as she falls off you, getting a massive facial in the process.  Her twin sister happily jacks you off, aiming your tool down at the row of cunts below you.  The sticky spooge splatters into their holes, painting their toned midriffs and ample thighs with sticky whiteness as you're used like some kind of fertility sprinkler. Tamani shoves her artificial dong further into your backdoor and somehow you manage to squeeze out a few more splattering drops of whiteness for her daughters.\n\n");
			
			output("Spent, your " + pc.cockDescript(0) + " wilts, drooping downward as it drips the last of its seed.  Tamani seems oblivious to that fact though, and continues to violate you from behind.  You're about to reach around to dislodge the tiny anal rapist when another squirt of aphrodisiacs releases inside you, catching some of your prostate with the goop.  A torrent of blood rushes to your " + pc.cockDescript(0) + " and you're suddenly achingly hard again.");
			if (pc.balls > 0) output("  Your " + pc.ballsDescript() + " ache from the strain, but struggle to churn up more sperm.  ");
			output("A drop of pre-cum beads on the tip and you find yourself relaxing, letting Tamani slide her drug-slicked horse-cock the rest of the way into you.\n\n");
		}
		output("A third goblin suddenly attacks your taint, licking between your " + pc.assholeDescript() + " and ");
		if (pc.balls > 0) output(pc.ballsDescript());
		else if (pc.hasVagina()) output(pc.vaginaDescript(0));
		else output("shaft");
		output(" as she presses her hard nipples up against your " + pc.legs() + ". ");
		//(No Tamani:
		if (!tamaniPresent) output("She presses something against your backdoor and before you have a chance to react, something hot and wet is filling your " + pc.assholeDescript() + ".  You look down as she pulls out a tube of pink residue, and sways with burning desire.\n\n");
		else output("The feeling of the ridges and flare of Tamani's fake cock as it slides inside you makes you sway on your feet, drunk with the lust its fluids have induced.   You sway back and forth with burning desire as both of the twins caress and stroke your meat, coaxing as much pleasure from it as possible.\n\n");
			
		output("You explode, coming harder than ever from the pressure and drugs buried against your prostate.  One of the twins, tired of waiting, pulls your " + pc.cockDescript(0) + " over and shoves your tip against her slickened folds.  You manage to pump a thick blob of cum deep inside her before her sister snatches it away, grinding her own hungry twat against you until her entire groin is stained white.  They glare at each other, but after seemingly being sated, they return to fondling your " + pc.cockDescript(0) + " together, using it like a hose to drench their smiling sisters with the remaining cum.\n\n");
		
		if (tamaniPresent) {
			output("Tamani pushes hard and screams behind you, \"<i>OH FUCK YES KNOCK THEIR LITTLE CUNTS UP!  Oooooohh...</i>\"\n\n");
			
			output("Her voice trails off into indecipherable gibberish as her orgasm takes her.  You can feel the horse-dick shaped dildo in your ass squirting its tainted fluids into you as Tamani's cunt clenches down on its other side.  Abruptly, the entire thing slides out, and you hear Tamani collapse in the grass.  You turn around as your cock responds to the drugs again, and note that she's totally out of it, mashing her tits with both hands and trembling with short involuntary muscle spasms.\n\n");
		}
		if (!tamaniPresent) output("You're handed another bottle as t");
		else output("T");
		output("he girls shift position, rearranging themselves so that those who got the most love-juice are now positioned alongside you.  ");
		if (!tamaniPresent) output("You shrug and drink it, ");
		else output("You begin ");
		output(" feeling hornier and hornier, as ready now as you were when you got here.  Twitching, your " + pc.cockDescript(0) + " announces its readiness to repaint these living cum-sponges.  A trio of goblin tongues slip over your shaft, and lip-gloss smeared lips worship every ounce of your life-giving rod.  One of the girls, an older one with prominent breasts, breaks off and begins to scale her way up your body.  She doesn't stop until she's sitting on your shoulders with her hot messy cunt pressed against your face.\n\n");
		
		output("One of the girls on your " + pc.cockDescript(0) + " gets an idea and mashes her tits against it you while she licks and strokes you.  The combined goblin assault once again achieves its goal, and you are brought to a body shaking orgasm AGAIN.   The swarm of goblins giggles happily as they gather your falling spunk into their waiting cunts.  What doesn't fit inside is slurped up, and soon you're covering a writhing orgy of curvy green women with a thick coat of spunk.\n\n");
		
		output("You finish and collapse backwards, totally drained and losing consciousness.  ");
		if (daughters < 20) {}
		//(20+ daughters:
		else if (daughters < 30) {
			output("A glass vial is slipped into your mouth as you lose consciousness, and you reflexively swallow.  You swear you could hear something about, \"<i>not done yet,</i>\" but you pass out.  Your dreams are far from restful, but full of pleasure.");
			//dynStats("tou", -.5, "int", -.5);
			pc.slowStatGain("p", -0.5);
			pc.slowStatGain("i", -0.5);
		}
		//(30+ Daughters: 
		else {
			output("Vial after vial is pressed against your mouth as liquids are poured down your throat.  Your body reflexively swallows and the massive jump in arousal prevents you from totally passing out.  You can't remember much before you truly lose consciousness, but one thing that sticks in your mind is some of your daughters asking, \"<i>Why don't we just bring Daddy back to camp and then we can fuck him whenever we want?</i>\"\n\nYou passed out before you could hear the answer.");
			pc.slowStatGain("p", -0.75);
			pc.slowStatGain("i", -1);
			pc.slowStatGain("l", 0.5);
		}
	}
	processTime(3 * 60 + rand(2 * 60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.slowStatGain("l", 1);
	pc.cor(1);
	//Knock the bitches up, boost libido, corruption
	if (tamaniPresent) tamaniKnockUp(); //If she wasn't pregnant she will be now
	knockUpDaughters();
	pc.cumMultiplierRaw += .3;
	
	if (inCombat()) {
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	}
	else {
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//[Let them]
private function legTamanisDaughtersRAEPYou():void {
	//spriteSelect(57);
	IncrementFlag("COC.TIMES_FUCKED_TAMANIS_DAUGHTERS");
	var cocks:Number = pc.totalCocks();
	var daughters:Number = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 2);
	//Find a dick that fits
	var primary:Number = pc.cockThatFits(cockVolume(50));
	
	clearOutput();
	output("Knowing full well that a ");
	if (daughters > 20) output("large ");
	output("crowd of goblins isn't going to let you leave while you still have a drop of sperm in your body, you disrobe and walk into their midst, lying down in a soft mossy patch and giving yourself up to the horde completely.  In an instant you're smothered in a sea of supple green flesh, and caressed from head to toe.  The largest of the group is happily stroking ");
	if (cocks > 1) output("one of ");
	output(" your [pc.cocks], teasing you as it near-instantly rises, \"<i>Mommy never told me you were such an easy " + pc.mf("man-", "") + "slut.</i>\"\n\n");
	
	output("A slippery gash mounts your " + pc.face() + ", blocking your view of anything but a cute navel as pungent pussy slobbers over your lips.  With a resigned sigh, you open your mouth and bury your tongue into one of your many daughters' snatches.  It's tangy and sweet, and juicier than fresh fruit.   The girlish moans you hear let you know how successful your tongue is, and you work harder than ever to kiss and lick her slippery lips, pausing only to suck the tiny bud of her clit into your mouth.\n\n");
	
	output("Through it all the other girls stay busy, Tamani's eldest daughter gets most of your attention while she continues  to stroke you off.  She squeezes and caresses it until your member is trembling in her hand, ready to explode.\n\n");
	//(FORK BETWEEN TOO BIG AND FITS)
	//[FITS]
	if (primary >= 0) {
		output("Effortlessly, she straddles you and guides the entire length of your rod into her honeypot.  Amazingly the tiny girl is able to spread her cunt around you, forming a tight, but not uncomfortable, fit.  ");
		if (cocks == 2) output("Another set of hands latches on to your free dick and forces herself down on top it, sitting back to back with the other lucky slut as she takes it to the hilt.  Somehow you know that if you could see beyond the tight body smothering your face, watching your daughters fuck together would push you over the edge.");
		else if (cocks > 2) output("More and more hands latch onto the rest of your [pc.cocks], guiding each of them into a tight cunt-hole.   If you could see around the tight body of the slut on your face, you're sure the scene on your crotch would push you over the edge.");
		else output("You stiffen as a tongue suddenly presses against your [pc.vagOrAss] sliding inside and intensifying the feelings radiating down your fuck-pole until you're unable to hold on.");
		output("\n\n");
		
		output("A sudden flow of fluids soaks your " + pc.face() + " and dribbles from your chin.  The face-riding goblin bucks like a bronco, nearly breaking your nose before the strength drains from her body and she slides off into the dirt, panting weakly.   Confronted with the sight of ");
		if (cocks > 2) output("so many girls impaled on your flesh");
		else if (cocks == 2) output("your daughters' whorish expressions of pleasure");
		else output("the sultry gaze of Tamani's oldest daughter as she rides your " + pc.cockDescript(primary), false);
		output(", you can do nothing but cum.  ");
		if (cocks > 1) output("Twitching powerfully, your body unloads into the tight, fertile cum-receptacles, giving them exactly what they want.");
		else output("Twitching powerfully, your body unloads into the tight, fertile cum-receptacle, giving her exactly what she wants.");
		if (pc.cumQ() >= 1000) {
			output("  The near-supernatural amount of spooge you produce easily bloats ");
			if (cocks == 1) output("her belly until she looks a little pregnant");
			else output("each of their uteruses until they look a little pregnant");
			output(".");
		}
		if (cocks == 1) output("  She rises up off of your wilting member, blowing you a kiss and saying, \"<i>I think you got me pregnant Daddy!</i>\"\n\n");
		else output("  They rise up off your wilting members.  The eldest daughter blows you a kiss and says, \"<i>I think you got us pregnant Daddy!</i>\"\n\n");
		
		//TAMANI IS THERE: 
		if (tamaniPresent) {
			output("Tamani shoves the cum-filled girls out of her way and looks down at you with an expression of disdain, \"<i>I swear honey, the way you act, I think your dick is already a slave to goblin-twat.</i>\"\n\n");
			
			output("She gives ");
			if (cocks > 1) output("one of ");
			output("your deflating [pc.cocks] a playful slap, smirking when it stiffens in response, \"<i>Honestly, you're so shameful, getting hard again from such an innocent touch.  I didn't know you wanted to make our little family that much bigger.</i>\"\n\n");
			
			output("Pantomiming a sigh, Tamani drags her finger from your ");
			if (!pc.hasSheath()) output("base");
			else output("sheath");
			output(" to the tip, giggling with mirth as her words and touches bring you to full readiness.\n\n");
			
			output("\"<i>Well, I wouldn't be a very nice wife if I didn't let you empty your stress into my hungry cunny from time to time would I?  Here, drink this, it'll make sure we have lots of daughters,</i>\" says the goblin, shoving a flask into your hand.  You nod, made agreeable by constant touches and strokes the goblin lavishes upon your groin.  The drink goes down smoothly, disappearing into you with a few quick sips from the colored glass bottle.  It settles into your belly, radiating pleasant warmth that seeps down to your crotch while it fills your mind with fuzz.\n\n");
			
			output("Tamani massages your ");
			if (pc.biggestTitSize() < 1) output("chest");
			else output(pc.allBreastsDescript(), false);
			output(" as she mounts you, ");
			output("squeezing her dripping wet cunt around your " + pc.cockDescript(primary) + ".  She explains, caressing your cheek as you start to drool, \"<i>You see, " + pc.short + ", this potion is a special one.  You can probably feel it now, emptying your mind and shutting down your thought processes.  That's what it's supposed to do.  You won't remember anything when I'm done either, aside from how great my pussy feels on your " + pc.cockDescript(primary) + "</i>.\"\n\n");
			
			output("You drool, accepting the truth.  She's so right, there's no way you'd ever forget the feeling of hot wetness as it rubs around your shaft.  Tamani keeps talking, confidently riding you as your mind soaks up her instructions, \"<i>My hot little cunt needs filling, and your cock knows it.  It wants it.</i>\"  She leans back, allowing you a glimpse of pinkness and sticky female juices while she teases her button, \"<i>Just the sight of my pussy gets you hard and ready.  The thought of feeling that hot hole mounting you just diverts all your blood and willpower into your ready fuckstick.  You CAN'T resist my pussy.</i>\"\n\n");
			
			output("The words she's saying stop mattering.  All that matters is how much a slave your cock is to that tight little hole, and how great it feels to give yourself over it.  Your spunk-hungry wife never shuts up, and you just lie there, listening placidly, contentedly twitching against her as orgasm approaches.  A happy smile spreads over your face as you feel your ");
			if (pc.balls > 0) output("balls");
			else output("groin");
			output(" churning with lust and desire, ready to give life to another batch of daughters for your mistress.  ");
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) < 10) output("'Wait... wife... mistress?' your mind wonders, rejecting the foreign thoughts.  You look up at Tamani, confused for a moment");
			else output("Yes, that sounds so right – Tamani is your wife, and it's your husbandly duty to keep her pregnant.  You dwell on that for a moment");
			output(", until an orgasm wracks your body and derails your train of thought, drowning it in a sea of pleasure.\n\n");
			
			output("She wriggles and moans as your internal muscles clench, pumping thick spurts into the goblin's womb.  A new-found sense of satisfaction and pleasure spreads through you.  It feels so good to knock Tamani up that your orgasm drags on forever, until you feel empty and exhausted.   Looking back, you realize just how much more pleasurable her box is in comparison to the other holes you've tasting in your travels, even her daughter's.  As Tamani rises up off of you, dripping with cum, the memories of everything but the sex slowly slip away, leaving behind happiness and anticipation of your next chance to fill her.\n\n");
			
			output("Your mistress steps away, swaying her more-than ample hips from side to side as she saunters past the throng of still-hungry goblins.  You shake your head, feeling a little out of sorts, but before you get a chance to puzzle it out, ");
			if (daughters < 20) output("the small pack of goblins is upon you, forcing liquids down your throat and making you fill cunt after cunt with sticky seed.");
			else if (daughters < 30) output("the pack of goblin daughters is upon you, forcing potent aphrodisiacs down your throat as you're raped for hours, forced to pack cunt after cunt full of jism.");
			else output("the massive group of goblins is on top of you, drugging and raping you over and over until you've had dozens of orgasms and licked off nearly as many cream-bloated sluts.");
			output("  As you lie there, drugged and drained, your daughters form up in a line and kiss you, one after another, each whispering pleasantries like, \"<i>Thanks dad,</i>\" or \"<i>Yummy cum daddy,</i>\" before flouncing off, sloshing into the woods.");
			//increase hypno value
			IncrementFlag("COC.TAMANI_TIMES_HYPNOTISED");
			//preggo up tamani
			tamaniKnockUp();
		}
		//NO TAMANI:  
		else {
			//(SMALL PACK)
			if (daughters < 20) {
				output("The smaller girls take turns, mounting your cum-soaked rod one after another, using their hungry cunts like cum-sponges until your " + pc.cockDescript(primary) + " is polished with feminine fluids and cleaned of any residual jism.  After so many repeated mountings, you're hard and ready to cum again, and the horny sluts know it.   You're crammed back into each one of them, one after another in a barrage of quick fucks.  Each girl is only given a few seconds on your rod before she's pulled off by her peers and replaced by another ecstatic goblin.  While waiting for their next turn, the spare girls tease you, tweaking your " + pc.nippleDescript(0) + "s while licking your ears and whispering, \"<i>Don't cum for her, it'll be much better in my hot little box,</i>\" or, \"<i>You won't cum for that skank, will you?  Save your baby-batter for me!</i>\"\n\n");
				
				output("Amazingly, you orgasm again.  An orgiastic squeal erupts from your " + pc.cockDescript(primary) + "'s current owner, breaking off into pants and gasps ");
				if (pc.cumQ() < 100) output("as you twitch underneath her, emptying the last of your cum inside her.");
				else if (pc.cumQ() < 500) output("as you twitch underneath her, pumping her full of cum, thoroughly seeding her womb with spunk.");
				else output("as you twitch underneath her in powerful spasms, blasting huge gouts of cum into her waiting body until her belly is bloated with seed and it begins to squirt out around you in time with each eruption of spunk.");
				output("  Disappointed moans rise up from the others as they realize they've lost the cum-lottery.   The winner, patting her belly happily, stands up, filling the air with a loud 'slurrrrrp' as her twat noisily releases your " + pc.cockDescript(primary) + ".");
				if (pc.cumQ() >= 500) output("  A few enterprising goblins gather around, gathering up the loose spunk and shoveling it into their holes.");
				output("\n\n");
				
				output("Tired from the sexual acrobatics, your daughters gather up their possessions and begin dispersing, but a few stick around to lick your " + pc.cockDescript(primary) + " clean and give you deep french-kisses.  Exhausted as well, you begin to doze off, but not before a girlish voice whispers in your ear, \"<i>Thanks daddy!  I'll bring your daughters back once they've grown up so you can have their cherries too.</i>\"\n\n");
			}
			//(MEDIUM PACK (or bigger))
			else {
				output("The smaller girls take turns, mounting your cum-soaked rod one after another, using their hungry cunts like cum-sponges until your " + pc.cockDescript(primary) + " is polished with feminine fluids and cleaned of any residual jism.  After so many repeated mountings, you're hard and ready to cum again, and the horny sluts know it.   You're crammed back into each one of them, one after another in a barrage of quick fucks.  Each girl is only given a few seconds on your rod before she's pulled off by her peers and replaced by another ecstatic goblin.  While waiting for their next turn, the spare girls tease you, tweaking your " + pc.nippleDescript(0) + "s while licking your ears and whispering, \"<i>Don't cum for her, it'll be much better in my hot little box,</i>\" or, \"<i>You won't cum for that skank, will you?  Save your babby-batter for me!</i>\"\n\n");
				
				output("Amazingly, you orgasm again.  An orgiastic squeal erupts from your " + pc.cockDescript(0) + "'s current owner, breaking off into pants and gasps ");
				if (pc.cumQ() < 100) output("as you twitch underneath her, emptying the last of your cum inside her.");
				else if (pc.cumQ() < 500) output("as you twitch underneath her, pumping her full of cum, thoroughly seeding her womb with spunk.");
				else output("as you twitch underneath her in powerful spasms, blasting huge gouts of cum into her waiting body until her belly is bloated with seed and it begins to squirt out around you in time with each eruption of spunk.");
				output("  Disappointed moans rise up from the others as they realize they've lost the cum-lottery.   The winner, patting her belly happily, stands up, filling the air with a loud 'slurrrrrp' as her twat noisily releases your " + pc.cockDescript(primary) + ".");
				if (pc.cumQ() >= 500) output("A few enterprising goblins gather around, gathering up the loose spunk and shoveling it into their holes.");
				output("\n\n");
				
				output("You're exhausted from the sexual battering you've had to endure, but the giggling swarm won't let you rest.  Tiny hands pry open your jaws and force a bubbling concoction past your lips.  Another one massages your throat and you're forced to swallow the stuff.   The drug's effects are strong and immediate.  Your ");
				if (pc.balls > 0) output("balls begin swelling, trembling as they visibly inflate, preparing a massive load of seed.");
				else output("groin shifts uncomfortably, trembling as it begins preparing a massive load of seed.");
				output("  Your [pc.cocks] spasms, twitching as unearned pleasures fill the flesh and bring you to climax.\n\n");
				
				output("You grunt, squirting a long rope of the stuff that splatters onto your belly.  A palpable sense of relief comes with it, though the mystery drug they've fed you immediately turns that relief back into uncomfortable fullness.  Your hips twitch and try to launch the next load, but it's intercepted by a pierced goblin-twat that slides down on top of you.  The goblin pinches her nipples and coos happily as you send squirt after squirt into her, until she's cumming loudly and her over-full twat is squirting out each time you try to pack more in.\n\n");
				
				output("The filled goblin is pulled off by her sisters, and through your haze of artificially-induced pleasure she looks completely insensate.  Her mouth is drooling, her eyes are rolled back, and her entire body is twitching in the arms of her sisters as they lay her in the grass to recover.   Despite being exposed to the air, you're still cumming hard, and a few more ropes of cum spatter your neck and chest with goo before the next daughter climbs aboard.\n\n"); 

				output("This goblin is riding you reverse cowgirl, grinding up and down, peeking over her shoulder to give you seductive smiles as she's fully fertilized.  Her thighs quiver and her vaginal muscles squirm around you, contracting and squeezing until it gets hard to push any more jizz inside her.  With a self-satisfied smile, she rises up off of you and helps the next of her sisters into place.\n\n");
				
				if (daughters < 40) {
					output("Locked in a ceaseless orgasm, you're raped by one goblin after another.  A parade of tight pink pussies and their green-skinned owners passes by you, and once each of them is dripping with white seed, they take the time for a second pass.  By the time it's over, you're raw and sore, and your ");
					if (pc.balls > 0) output(pc.ballsDescript() + " hurt");
					else output("crotch hurts");
					output(" from having to generate such a ridiculous quantity of spooge.  The crowd of milling goblins seems much less frantic now that they've gotten what they want.  You're kissed and licked and massaged by the thankful mass, and you lose yourself to unconsciousness, still dribbling semen.");
				}
				//(LARGE PACK – as above minus last PG)
				else {
					output("Locked in a ceaseless orgasm, you're raped by one goblin after another.  A parade of tight pink pussies and their green-skinned owners passes by you, and once each of them is dripping with white seed, they take the time for a second pass.  You're raw, sore, and losing consciousness, but the huge mass of young goblins is far from done with you.  They force another potion into your throat as you lose consciousness.   Your dreams are filled with demented orgies where your dick is kept in one tight hole after another, a cruel reflection of reality.  When you awake they're gone and you're incredibly sore, but somehow still horny.  Getting dosed with so many goblin drugs in such a short time-span might not have been a good idea.");
					//libido/cumq/corruption booster?
					pc.slowStatGain("l", 1);
					pc.cor(0.5);
					pc.cumMultiplierRaw += .3;
				}
			}
		}
	}
	//[NO FIT]
	else {
		//	[No Tamani]
		if (!tamaniPresent) {
			output("Effortlessly, Tamani's daughter launches herself onto you, straddling your body as she tries to work your " + pc.cockDescript(0) + " into her tight gash.  No matter how hard she tries, she just can't get it in.  She looks up at you in confusion and asks, \"<i>How in Marae's cunt can my Mom take this beast?</i>\"\n\n");
			
			output("Frowning in consternation, she presses it down onto your belly and sits on top, spreading her cunt as wide as she can around the bulge your urethra makes on the underside of your " + pc.cockDescript(0) + ".  Though you can't see her, the feeling of her starting to slide along your length is wonderfully pleasurable.  After a few moments you can feel her getting into it, leaning over and pressing her taut body and heavy breasts against you as well.  Incredibly turned on by the mental picture you're forced to form, you attack the cunt riding your " + pc.face() + ", licking it with feverish intensity.\n\n");
			
			output("A sudden flow of fluids soaks your " + pc.face() + " and dribbles from your chin.  The face-riding goblin bucks like a bronco, nearly breaking your nose before the strength drains from her body and she slides off into the dirt, panting weakly.  Now freed from your juicy prison, you can see the oldest daughter as she's squeezing on your " + pc.cockDescript(0) + ", sliding her gash and ");
			if (daughters < 20) output("pert ");
			else if (daughters > 40) output("heavy "); 
			output("breasts over every part of it.");
			if (cocks == 2) output("  Another one of the petite sluts climbs aboard your " + pc.cockDescript(1) + ", squealing happily to her sister as she joins her in riding you.");
			if (cocks > 2) {
				output("  A third, wearing slutty pink make-up with platinum blonde hair, lays out across your ");
				if (cocks > 3) output("remaining [pc.cocksLight]");
				else output(pc.cockDescript(2));
				output(".");
			}
			output("\n\n");
			
			output("She pivots around, placing her drooling, wet gash against your " + pc.cockHead() + " and begins vigorously jerking you off.   Her ass bounces hypnotically on your ");
			if (pc.biggestTitSize() < 1) output("chest");
			else output(pc.allBreastsDescript(), false);
			output(", sending a fresh surge of arousal through your [pc.cocks].   Another one of the girls leans down between your " + pc.legs() + " licking your ");
			if (pc.balls > 0) output("balls");
			else if (pc.hasVagina()) output("pussy");
			else output("taint");
			output(", massaging your ");
			if (pc.hasSheath()) output("sheath");
			else output("crotch");
			output(", and the sensitive [pc.skinFurScales] around your crotch.   The busty girl on your " + pc.cockDescript(0) + " teases, \"<i>Go ahead and let it out " + pc.mf("stud","sexy") + ".  I'm tired of getting your cream second-hand, so squirt it right into my hot little cunt.</i>\"\n\n");
			
			if (cocks == 2) output("Her sister agrees, \"<i>Yeah, I want to feel the hot cum squirting into my cunt.  Fill me full of so many babies that you make Mom jealous!</i>\"\n\n");
			else if (cocks > 2) output("Her sisters agree, \"<i>Yeah, we want to feel the hot cum squirting into our cunts!  Fill us up with so many babies that Mom gets jealous!</i>\"\n\n");
	
			output("Your body caves into their demands.  The girl between your " + pc.legs() + " licks hard as your muscles tense with orgasm.  ");
			//Single cock jizz scene
			if (cocks == 1) {
				output("The daughter giggles and squeals as bulges of cum squeeze up your urethra, visibly shifting her tight body before squirting inside with wet, fluid noises.  Sloshing squishing noises fill the air as you submit to your jizz-devouring pack of daughters, feeding their insatiable need for sperm.  Pleasure rocks you as ");
				//Cum stuff
				if (pc.cumQ() < 100) output("your orgasm ends, pulsing weakly inside the sloppy goblin flesh.");
				else if (pc.cumQ() < 500) output("your orgasm drags on, pumping the slut up until she looks slightly pregnant.");
				else {
					output("your orgasm drags on, splattering cum everywhere as you plump up the girl until she looks pregnant.");
					if (pc.cumQ() > 1000) output("  Seed gushes out her opening, actually pushing the goblin away as your orgasm splatters cum into the grass.");
					if (pc.cumQ() > 5000) output("  The other goblins frolic around in the stuff, greedily shoveling it into their dripping pussies with both hands as you form a small lake of seed.");
				}
			}
			//Multi jizz scene
			else {
				output("The daughters giggle and squeal as bulges of cum squeeze up your urethras, visibly shifting their tight bodies before squirting inside with wet, fluid noises.  Sloshing squishing noises fill the air as you submit to your jizz-devouring pack of daughters, feeding their insatiable need for sperm.  Pleasure rocks you as ");
				//Orgazmo
				if (pc.cumQ() < 100) output("your orgasm ends, pulsing weakly inside the sloppy goblin flesh.");
				else if (pc.cumQ() < 500) output("your orgasm drags on, pumping the sluts up till they look slightly pregnant.");
				else {
					output("your orgasm drags on, splattering cum everywhere as you plump up the girls until they look pregnant.");
					if (pc.cumQ() > 1000) output("  Seed gushes out their openings, actually pushing the goblins away as your orgasm splatters cum into the grass.");
					if (pc.cumQ() > 5000) output("  The other goblins frolic around in the stuff, greedily shoveling it into their dripping pussies with both hands as you form a small lake of seed.");
				}
			}
			output("\n\n");
	
			output("Spent, you lie in the dirt, twitching weakly with an exhausted grin on your face.  A goblin with a long pierced tongue kneels next to your face and gives you a long kiss, twisting her tongue around your own.  Her spit tastes almost sweet to you, and the passionate tongue-fuck has you getting hard again even as you're running out of breath.  She breaks it off, and as you gasp for air, she forces a pill into your mouth.  Knowing they'll make you swallow it one way or another, you sigh and ingest the foreign drug.  Your tongue-twisting partner licks her shiny, cock-sucking lips and says, \"<i>Mom always did say you were an eager fuck.  I even stole that pill from her – it should make you cum enough to stuff every single one of us!  I can't wait to catch the first blast in my tight little snatch!</i>\"\n\n");
			
			if (cocks == 1) output("Y");
			else output("Each of y");
			output("our [pc.cocks] is now rock solid and beading pre-cum at the tip.  ");
			//(single)
			if (cocks == 1) output("The purple-lipped cock-slut grabs your " + pc.cockDescript(0) + " and makes a show of smearing the slippery fluid over your shaft, lubricating it as she jacks you off.  Her warm lips form a tight seal on your " + pc.cockHead() + " as the young goblin begins lapping at your pre-cum as she sucks it from your urethra.   It feels heavenly, and your " + pc.hipDescript() + " pump weakly into the air in an instinctive bid to enhance the sensation.");
			//(multiple)
			else {
				output("The purple-lipped cock-slut grabs hold of one of your [pc.cocks] and makes a show of smearing the slippering fluid over the shaft, lubricating it as she begins to jack you off.  Her sisters, taking the cue, step over the other sated sluts and grab hold of your " + pc.cockDescript(1) + ", fondling it lovingly.  ");
				if (cocks > 2) output("They spread out until every one of your [pc.cocks] has at least one goblin hanging off it, stroking and touching you.  ");
				output("It feels heavenly, and your " + pc.hipDescript() + " pump weakly into the air in an instinctive bid to enhance the sensation.");
			}
			output("\n\n");
			
			output("The goblin who served between the legs crawls back into position, and you realize she must be the youngest, and therefore the lowest on the goblin totem-pole.  Her eager tongue is just as skilled as it was minutes ago, and between her attentions and the tongues on your [pc.cocks], you're leaking streamers of liquid lust.  Hands run over your ");
			if (pc.biggestTitSize() < 1) output("chest");
			else output(pc.allBreastsDescript());
			output(", circling your nipples and massaging your chest while a girlish voice whispers in your ear, \"<i>Cum for us now daddy, we've gotten so wet having to wait on you...</i>\"\n\n");
			
			output("Ripples of convulsive pleasure wrack your midsection as you feel the muscular contractions of your orgasm threatening to tear you apart.   Your ");
			//(single)
			if (cocks == 1) output(pc.cockDescript(0) + " blasts a wave of seed directly into your cock-obsessed daughter's mouth, flooding it until she falls off of it with jism dripping from her nostrils.  You squirt a massive spurt high into the air overhead, and more than a few goblins are running around with their tongues out, trying to catch it in their mouths.   Each wave of seed is larger than the last, erupting from your " + pc.cockDescript(0) + " like a geyser.   Soon everyone is spattered in a layer of the stuff, and your gut-clenching orgasm tapers down to a more reasonable, but constant, slow flow of semen.  Each of your daughters comes up and takes turns angling your shaft into her waiting cunt, allowing the thick fluid to fill her to capacity before waddling off.  Then the next girl does the same, and the next, and the next...");
			//(Multi)
			else output("[pc.cocksLight] blast waves of seed directly into your cock-obsessed daughters' mouths, flooding them until they fall off with jism dripping from their nostrils.   You spurt massive loads high into the air overhead, and more than a few goblins are running around with their tongues out, trying to catch the seed in their mouths.  Each wave is larger than the last, erupting from your [pc.cocks] like a geyser.  Soon everyone is covered in a thick coating of the stuff, and your gut-clenching orgasm tapers down to a more reasonable, but constant, slow flow of semen.  Each of your daughters comes up and guides a shaft into her waiting cunt, filling herself to capacity with the thick fluid before waddling off.   Then the next set of girls does the same, and the next, and the next....");
			output("You're done in by the effort, and quickly lose consciousness.");
		}
		//[Tamani is There]
		else {
			output("A scuffle in the crowd breaks out to your right, and though you can hear it, the jiggling ass and delicious pussy of the goblin slut on your face makes it impossible to see what's going on.  You do what any horny " + pc.mf("male","herm") + " would do in your position – groan into the slippery box and ignore it, focusing on the feel of skilled hands fondling ");
			if (cocks > 1) output("each of ");
			output("your [pc.cocks].\n\n");
			
			output("High pitched voices rise in pleading tones, followed by the impact of flesh on flesh.  A sultry, familiar voice clears her throat and asks, \"<i>Oh, so this is where you've been.  Tamani would've expected her husband to be in his proper place – lodged deep between her legs, rather than rewarding his ditzy daughters' misbehavior.</i>\"\n\n");
			
 			output("You sigh into the fragrant pussy, the warm air-flow turning the slippery box a dripping fountain of orgasm.   The walls clamp around your tongue, squeezing it from base to tip in a milking motion you've become intimately acquainted with.   A high pitched shriek of pleasure rises, then cuts off.  You blink away a sudden burst of light as the orgasming girl is ripped from your questing tongue, revealing the crowd of sultry bodies and Tamani's knowing smirk.\n\n");
			
			output("\"<i>Mother always said you had to keep your men on a tight leash, and boy was she ever right – you've been cheating on Tamani!  With your own daughters!</i>\" exclaims your ");
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) >= 10) output("wife");
			else output("\"wife\"");
			output(" in mock indignation.   She taps her chin for a moment, ignoring her daughters as they continue to lick and stroke ");
			if (cocks) output("each of ");
			output("your [pc.cocks].  Your eyes roll back in blissful pleasure as Tamani declares, \"<i>Tamani will take care of you, husband.  You're going to cum into these girls' hungry twats until they have to waddle home, and then you're going to remember why Tamani's cunt owns your [pc.cockNoun], forever.</i>\"\n\n");
			
			output("Tamani pulls out a ring gag, shoves it into your protesting mouth, and pulls the straps securely around the back of your neck.  She tousles your " + pc.hairDescript() + " as you squirm, but the crowd of goblins easily keeps you subdued, assisting their mother now that they know her plans.   You ");
			if (pc.cor() > 66) output("sigh, actually anticipating what's about to come");
			else if (pc.cor() > 33) output("don't resist, knowing there's no way to stop what's about to happen");
			else output("shudder, struggling to pull free");
			output(" as Tamani pulls out a half dozen vials and a handful of pills.  She drops the drug-filled capsules into your mouth, pouring in the potions, one at a time, to wash down her concoctions.\n\n");
			
			output("\"<i>Ok girls, line up; Daddy's gonna start squirting for you, so grab hold of that monster he's got and hold the tip against your horny little cunts until you're full.  And don't be greedy, once you've got a puss full of seed waddle on home, ");
			if (daughters < 20) output("there's other girls waiting");
			else if (daughters < 35) output("we've got a lot of girls to fill up");
			else output("there's a TON of you here so you'll need to move quick if you each want a turn");
			output(",</i>\" commands the goblin mother.\n\n");
			
			output("Her words are downright prophetic.  Churning, bubbling warmth floods your crotch with need as you look on, moaning.  Your back arches and your eyes cross in an involuntary reaction to your drug-induced orgasm.  Grunting, you twitch as the goblins line up, the eldest daughter grabbing home of your flexing " + pc.cockDescript(0) + " as it begins to erupt.  Strangely, it isn't the pulsing, squirting orgasms you're used to.  Instead, a steady stream of cum washes out over the girl's abdomen as she lines up, eventually grinding her wet pussy against your straining urethra.  She giggles with lewd pleasure, grinding against your swollen " + pc.cockHead() + " as her womb is pumped full of semen.  Her belly quickly rounds out, and she's forced to step away, leaving you to soak your belly while the next of your daughters gets in position.\n\n");
			
			//(MULTI)
			if (cocks > 2) {
				output("Meanwhile your other " + plural(pc.randomSimpleCockNoun()) + " are wasting their spunk over your belly, so some of the waiting girls grab them and pull them aside, ramming their tips deep inside their seemingly bottomless fuck-holes.  They giggle and run their manicured nails over your ");
				if (pc.biggestTitSize() < 1) output("chest");
				else output(pc.allBreastsDescript());
				output(", circling your sensitive nipples");
				if (pc.isLactating()) {
					output(" as they start to ");
					if (pc.lactationQ() < 500) output("leak");
					else if (pc.lactationQ() < 1000) output("drip");
					else if (pc.lactationQ() < 2000) output("spew");
					else output("fountain");
					output(" milk");
				}
				output(".  The perverse scene seems to feed you even more pleasure, and you feel your orgasm increase in intensity, thickening the flow of cum.\n\n");
			}
			//(SINGLE EXTRA)
			else if (cocks == 2) {
				output("Meanwhile your other " + pc.randomSimpleCockNoun() + " is wasting its spunk over your belly, so one of the waiting girls grabs it and pulls it to the side, ramming its tip deep inside her seemingly bottomless fuck-hole.  She giggle and runs their manicured nails over your ");
				if (pc.biggestTitSize() < 1) output("chest");
				else output(pc.allBreastsDescript());
				output(", circling your sensitive nipples");
				if (pc.isLactating()) {
					output(" as they start to ");
					if (pc.lactationQ() < 500) output("leak");
					else if (pc.lactationQ() < 1000) output("drip");
					else if (pc.lactationQ() < 2000) output("spew");
					else output("fountain");
					output(" milk");
				}
				output(".  The perverse scene seems to feed you even more pleasure, and you feel your orgasm increase in intensity, thickening the flow of cum.\n\n");
			}
			
			output("The next slut grabs your " + pc.cockHead() + " with both hands as she straddles you, pinching it tightly enough to make you wince.  The flow of white goo is pinched off, backing up painfully as she gets in position.  Just when you're about to cry, she's in position, and releases her too-tight grip.   Your body rewards the slut for her pain with a blast of seed so powerful it nearly blows her off your midsection, splattering out around her lips.  She holds on through an orgasm as you fill her depths with even more of your creamy load.  Surprisingly, she manages to take even more than her older sister, staying on until she looks a few months pregnant.  She staggers off, sloshing wetly while seed drips between her thighs.\n\n");

			output("While you continue to fertilize the slutty goblin girls, Tamani is nice enough to remove your gag.  Sadly, you're too drunk with pleasure and Tamani's chemicals to do anything but pant and drool, but it was a nice gesture.  ");
			//(SMALL CROWD: 
			if (daughters < 20) output("The crowd of girls takes their time since there's only around a dozen or so left to fill.  They ride you long and hard, getting their wombs packed full and making a mess while they do it.  Even after all of them has been filled, Tamani's potent chemicals keep you locked in orgasm, dripping unholy amounts of semen everywhere.  A few of the more daring of your offspring take turns sliding the tip into their tight assholes, allowing you to fill them completely as the drugs finally begin to wear off.\n\n");
			//(ALT MORE GIRLZ)
			else if (daughters < 35) output("The crowd of girls seems to take forever to get filled.  Every time one of them gets too into it, her mother pulls her back and guides the next willing hole into place.  In spite of the orderly procession, cum manages to get everywhere, soaking your torso and more than a few goblin thighs with a glaze of whiteness.  The whole time, you're kept in constant orgasm, though by the time you're filling the last girl with cum, the flow is slowing while the chemicals wear off.\n\n");
			//(ALT TOO MANY GIRLZ)
			else output("The massive crowd is forced to carefully ration your semen, bountiful though it is.   Tamani doesn't even let the girls get completely filled, instead forcing each of them to only get a few cunt-filling moments of your orgasm.  Those who've already had a turn hang around, scooping up the sperm-filled fluid that's leaking out and shoveling it into their baby-craving bodies.  The whole time you're kept locked in incredible climax.  If you had any capacity for reason you'd probably feel more like a tool than " + pc.mf("man", "woman") + ", but the synapses of your brain are too busy firing off about how good it feels to think.  By the time the last girl gets her turn, your orgasm has trailed off to a weak flow, so she stays on until the drugs finally wear off.\n\n");
			
			output("The soon-to-be-pregnant goblins stagger off, a bit bow-legged and generously glazed with semen.  You come down from your high, panting weakly and trembling.  Tamani wraps her arms around your head, cradling you deep into her incredible bust.  The soft skin completely envelops you in breast-flesh as her sweet, fruity scent fills your lungs with every breath.  ");
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 10) output("She's the best wife ever.  You nuzzle deep into her cleavage, sighing happily.");
			else if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 5) output("She really is a great wife... wait, wife? You shrug away the thought and enjoy slowly motorboating her breasts.");
			else output("She really isn't that bad to you, is she?  You sigh and nuzzle against her jiggly love-pillows.");
			output("  Eventually she pulls you back and kisses you on the lips.\n\n");
			
			output("Tamani offers you a canteen, and you readily accept it, thirsty after such a physics-shattering orgasm.  The water is cold and satisfying.  You gulp it down in record time, chugging and guzzling until the container empties.  Satisfied, you lie back down.  The pleasure is short-lived, short-circuited by the realization that the water you just drank had a tangy after-taste.  You try to glare at ");
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 10) output("your wife");
			else output("Tamani");
			output(" in anger, but your head feels all numb, and looking over at her makes the world spin dizzily.\n\n");
			
			output("Pink haze crowds away your thoughts as your glare melts away into dopey confusion.  Tamani giggles and says, \"<i>");
			//(Done before)
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 0) output("Don't you remember the last time we did this?  Of course not.</i>\"  Your hot goblin wife gestures at your suddenly swollen and erect " + pc.cockDescript(0) + ", and continues, \"<i>Your dick remembers my special potion though.  Now, let's get back to teaching that wonderful cum-spout of yours how to behave around its wife and mistress.</i>\"\n\n");
			//(Not Done Before)
			else output("I mixed a special potion in that drink.   It shuts down all those pesky thoughts so you'll listen to your wonderful wife and let her tell you how to think and feel.</i>\"  She strokes your partially softened " + pc.randomSimpleCockNoun() + ", giggling as it hardens for her, \"<i>You won't remember what Tamani tells you once it wears off, but your dick won't ever forget.</i>\"\n\n");
			
			output("Tamani slides her jiggling body overtop of you, placing her sopping wet pussy directly over-top of your " + pc.cockDescript(0) + ".  The warm wet fluids of her desire slowly drip down onto you until your entire surface is coated in her clear feminine-drool and the entire area smells like her cunt.  She shivers and looks into your eyes, smiling at your mindless expression as she lectures, \"<i>Feel how hard your dick is?  That's because it smells my hungry, wet pussy.  It knows that it wants to cum for my pussy.  Your cock wants nothing more than to touch my cunt, worship it and bathe it with cum.</i>\"\n\n");

			output("She lets her pink-lipped entrance touch you at last, gliding it up and down your length.  You drool on yourself as she reaches your tip, leans back, and displays her glistening entrance to you as she talks, \"<i>This is what you want, what you need.   Just looking at it makes you hot and ready to fuck.  One glance and all your worries melt into arousal and desire to please your goblin wife.</i>\"\n\n");
			
			output("She's completely right.  You're past truly comprehending words, all you know is how hot your wife is making your cock and had bad it wants to cum in her.   Tamani smirks knowingly and begins sliding herself along the sensitive shaft again, slowly bringing you closer to an inevitable orgasm with her glorious vagina.  She leans over and whispers, \"<i>You'll be a good obedient husband and fuck your wife, won't you?  That's a husband's duty – to worship his wife's beautiful pussy, bathe it in semen, and be obedient in her presence.</i>\"\n\n");
			
			output("The words she's saying stop mattering.  All that matters is how much a slave your cock is to that wonderful, wet gash, and how great it feels to give yourself over to it.  Your spunk-hungry wife never shuts up, and you just lie there, listening placidly, contentedly twitching against her as orgasm approaches.  A happy smile spreads over your face as you feel your ");
			if (pc.balls > 0) output("balls");
			else output("groin");
			output(" churning with lust and desire, ready to give life to another batch of daughters for your mistress.  ");
			if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) < 10) output("'Wait... wife... mistress?' your mind wonders, rejecting the foreign thoughts.  You look up at Tamani, confused for a moment");
			else output("Yes, that sounds so right – Tamani is your wife, and it's your husbandly duty to keep her pregnant.  You dwell on that for a moment");
			output(", until an orgasm wracks your body and derails your train of thought, drowning it in a sea of pleasure.  She moans and slides down, pressing her entrance against your urethra as your internal muscles clench, pumping thick spurts into the goblin's womb.  A new-found sense of satisfaction and pleasure spreads through you.  It feels so good to knock Tamani up that your orgasm drags on forever, until you feel empty and exhausted.   Looking back, you realize just how much more pleasurable her box is in comparison to the other holes you've tasting in your travels, even her daughter's.  As Tamani rises up off of you, dripping with cum, the memories of everything but the sex slowly slip away, leaving behind happiness and anticipation of your next chance to fill her.\n\n");

			output("Your mistress steps away, swaying her more-than ample hips from side to side as she saunters off.  You shake your head, feeling a little out of sorts, but before you get a chance to puzzle it out, the exhaustion of the encounter overwhelms you, blacking you out.");
			//knock up tamani chance
			tamaniKnockUp();
			//increase hypno value
			IncrementFlag("COC.TAMANI_TIMES_HYPNOTISED");
		}
	}
	//knock bitches up, slight libido gain, slight strength/toughness loss.
	processTime(3 * 60 + rand(2 * 60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.slowStatGain("p", -0.75);
	pc.slowStatGain("i", -1);
	pc.slowStatGain("l", 0.5);
	pc.cor(1);
	
	if (tamaniPresent) tamaniKnockUp(); //If she wasn't pregnant she will be now
	knockUpDaughters();
	if (inCombat()) {
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	else {
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//[Lose Combat, Get Your Dick DRAINED]
private function tamaniDaughtersCombatLossDrain():void {
	//spriteSelect(57);
	IncrementFlag("COC.TIMES_FUCKED_TAMANIS_DAUGHTERS");
	clearOutput();
	
	//Vars
	var cocks:Number = pc.totalCocks();
	var daughters:Number = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 2);

	output("Your efforts to resist were in vain – there's simply too many of your slutty daughters to fight off.  The crowd flows over your ");
	if (pc.HP() <= 1) output("defeated");
	else output("lust weakened");
	output(" form, pulling you off your feet and carrying the whole of your body off.  ");
	if (pc.lustQ() >= 100) {
		output("It doesn't bother you too much... they keep ");
		if (pc.balls > 0) output("fondling your balls and ");
		output("stroking your shaft to keep you nice and excited, squirming helplessly with desire.");
	}
	else output("Your abused body slips in and out of consciousness, but the crowd applies salves as they travel to slowly invigorate your form.  Their hands keep touching and stroking you, and despite your mighty efforts to resist, you find yourself aroused and willing in short order.");
	output("\n\n");
	
	output("Perhaps an hour later, you're pulled into a cave.   Daylight fades away, replaced by the flickering light cast by a few torches and candles.  Your daughters are giggling and gossiping as they parade you through their subterranean lair, taking you ever-deeper.   An indeterminate amount of time later, you hear a door opening and are pulled through an entryway into what passes for a room.  You pant and moan as one of the tallest of Tamani's brood does her best to fellate ");
	if (cocks > 1) output("one of ");
	output("your [pc.cocks], keeping your more than turned on enough to go along with whatever they have planned.\n\n");
	
	//(regular lower body)
	if (!pc.isTaur()) {
		output("The hands holding you slowly lower you into a comfortable feeling chair, securing your " + pc.legs() + " into tightly bound stirrups.  A moment later, your hands are strapped into equally firm cuffs.  By this point, your lust-dulled mind has begun to worry, and you start to struggle, but binding leather straps are passed over your chest, midsection, and upper thighs, then tightened against the chair to completely restrain you.  Perhaps the only ");
		if (cocks > 1) output(" things not restrained are your [pc.cocks], standing at attention despite, or perhaps because of, your predicament.\n\n");
		else output(" thing not restrained is your [pc.cocks], standing at attention despite, or perhaps because of, your predicament.\n\n");
	}
	//(Shit taurs go!)
	else {
		output("The hands holding you slowly lower you down onto your back, guiding you into a combination chair and harness designed to accommodate a centuar's size and shape.  Before you know it, straps secure your " + pc.legs() + " into tightly bound restraints.  A moment later your, hands are strapped into equally firm cuffs.  By this point, your lust-dulled mind has begun to worry, and you start to struggle, but binding leather straps are passed over your chest, midsection, and hindquarters, then tightened against the chair to completely restrain you.  Perhaps the only ");
		if (cocks > 1) output(" things not restrained are your [pc.cocks], standing at attention despite, or perhaps because of, your predicament.\n\n");
		else output(" thing not restrained is your [pc.cocks], standing at attention despite, or perhaps because of, your predicament.\n\n");
	}
	
	output("A goblin with lustrous blue hair pulls a lever on the side of the chair, shifting your position to further expose you.  She assures, ");
	if (int(flags["COC.UNKNOWN_FLAG_NUMBER_00058"]) == 0) output("\"<i>Stop worrying.  I invented this while I was waiting on mom to bring me back more of your cum, just in case we ever got our hands on you.  I promise, after you've had a taste of my chair you'll never want to leave.</i>\"\n\n");
	else output("\"<i>Stop worrying!  We both know you love my little love-seat.  Just lie back and you'll be cumming too hard to care before long.</i>\"\n\n");
	
	
	output("You hear a commotion to the side and crane your head to watch.  There's a crowd of the girls clustered around a machine.   It's about the size of a large dresser or cabinet, only instead of holding clothes it's covered in knobs, levers, and various mechanical dials.  A goblin with light blue, almost silvery hair looks back at you and blows you a kiss while she pulls a lever.  A mechanical whirring noise fills the room, emanating from the ceiling.  You tilt your head back and look up, and see a massive metal bulb descending from the ceiling.\n\n");
	
	output("The goblin-made device is clearly sexual in nature.  Dozens of openings cover the bottom surface, and inside each one is a some kind of pink-lined hole, dripping with lubricants.  Most intriguing of all, you realize that the different holes all have different shapes, patterns, and sizes.  Some are huge, resembling something that would be at home between a monster's legs, and others are tiny, practically elf-like in appearance.   The bulb pauses just over your crotch, and a few snickering, green skanks guide [pc.eachCock] into a perfectly sized hole.\n\n");
	
	output("You shiver as your manhood");
	if (cocks > 1) output("s are");
	else output(" is");
	output(" totally encapsulated within ");
	if (cocks == 1) output("a ");
	output("wet orifice");
	if (cocks > 1) output("s");
	output(".  They're so cold that you shiver involuntary against your restraints.  The blue-haired girl growls, \"<i>Hey bitch!  Crank the fuckin' machine up before you make Dad's dick");
	if (cocks > 1) output("s");
	output(" wilt!</i>\"\n\n");
	
	output("The machinery's humming gets louder as an unseen goblin does as she is told.  Noisy, wet suckling fills the room as the dozens of artificial mouths activate.  The wet, slimy substance encapsulating you immediately heats until it feels as warm as a maiden's love, and a gentle suction pulls on [pc.eachCock] until it feels much harder and thicker than normal.  You stifle an involuntary groan, but fail to conceal your lust-filled pants from your audience.   A daring girl leaps onto your ");
	if (pc.biggestTitSize() < 1) output("chest");
	else output(pc.allBreastsDescript());
	output(" and shoves a lactating nipple into your mouth, commanding, \"<i>Drink up, the more fluid you have the more baby batter you can cook up for us!</i>\"\n\n");
	
	output("Unable to fight back in any way, you shrug and begin suckling the purplish nipple, tasting the creamy goblin milk as it easily fills your mouth.  You gulp it down, slowly relaxing between the mechanized cock-sucking and gentle breast-feeding.  Your daughter was right, it's almost like paradise. Unfortunately, the pleasure is interrupted by something probing at your backside.  Unable to look with your mouth full of delicious tit, you can only gurgle and dribble in protest as a lubricated tube is inserted into your " + pc.assholeDescript() + ".\n\n");
	
	output("The familiar voice of the machine's inventor whispers, \"<i>");
	if (int(flags["COC.UNKNOWN_FLAG_NUMBER_00058"]) == 0) output("Time for your medicine!  We need you to cum enough for each of us, and maybe have a little left over to play with, so suck up the medicine, okay?  Just relax and let it fill you so that you give us all that yummy cummy!</i>\"\n\n");
	else output("Relax Dad, we're just giving you your cummy medicine.  I know you're a sexy, virile " + pc.mf("stud","slut") + "and all, but take your medicine and you'll have more than enough cum for us!</i>\"\n\n");
	
	output("You blush, ");
	//EXHIBITIONISTZ
	if (flags["COC.PC_FETISH"] > 0) output("unimaginably turned on by being used and abused by such machinery in front of an audience of your own horny children.");
	else if (pc.exhibitionism() > 60 || pc.cor() > 60) output("turned on by being milked in such an obscene way.");
	else output("horrified at the situation but unable to resist arousal as you're constantly sucked and pleasured.");
	output("\n\n");
	
	output("A trickle of warm fluid flows into you, and immediately your skin tingles, burning with heat and need.  ");
	if (pc.balls > 0) output("Your balls tighten inside your sack and swell up like sponges, slowly increasing in size in time with your desire.");
	else output("Your body feels tight and needy, your gut clenching as your body adjusts to the drugs it's absorbing so readily through your " + pc.assholeDescript() + ".");
	output("  The suckling pleasure around ");
	if (cocks > 1) output("each of ");
	output("your [pc.cocks] seems to slowly increase as more of the drugs are absorbed by your body, until escaping the straps for your freedom is longer a concern.   Now all that matters is getting free so that you can fuck ");
	if (cocks == 1) output("that");
	else output("those");
	output(" mechanical hole");
	if (cocks > 1) output("s");
	output(" until you feel that wonderful, delicious release that you crave.\n\n");
	
	output("The goblins, upon seeing your change in demeanor, begin smiling to one another and congratulating each other on their hard work.  The girl at the console twists a few more levers and the warmth inside you seems to double as more drugs are forced into your captive frame.  You start " + pc.mf("laughing","giggling") + ", the narcotics and pleasure overwhelming your thought processes, leaving you feeling like you're floating in heaven.  To anyone watching, you're panting and moaning in between the laughter, slobbering all over the milky goblin-tit in your mouth as your body begins squirting pre-cum into the cock-milker.\n\n");
	
	output("A few seconds away from your orgasm, the goblin running the machinery makes a few adjustments, and you feel the flow into your rectum growing stronger until you start to feel full and bloated.  Your body caves in to the pleasure, every inch of your skin tingling as you're forced to climax.  ");
	if (pc.balls > 0) output("Straining and shaking, your " + pc.ballsDescript() + " clench against you, feeling tight as your body struggles to pump out the spooge they're producing.");
	else output("Straining and shaking , your body struggles through the orgasm as it tries to deal with all the cum your prostate and glands are putting out.");
	output("  The drugs and milking machines squish, suck, and whir noisily as you cum, flooding the tubes above the mechanical cunt-bulb with white.\n\n");
	
	output("The lactating green girl stops breast-feeding you and climbs off you, fed up that you're too busy moaning to properly suckle.  A few of the giggling goblins slap your face, laughing out loud when you fail to even register the blows.  The never-ending flow of orgasmic goop flooding out from ");
	if (cocks > 1) output("each of ");
	output("your [pc.cocks] has your brain flooded with pleasure, blocking any other thoughts or feelings from arising from the swirling morass of fuck.\n\n");
	
	output("Another voice joins you in ecstatic moaning, echoing from the other side of the room.  The source is a curvy goblin with a hose rammed up her glistening snatch, buried to the hilt.  Her sisters are teasing her, opening and closing a valve on the machine, filling their sister up with short bursts of your copious cum.  She's moaning and fucking herself in desperation with the dildo-shaped tube-tip, but her brood-mates seem intent on staggering the flow of semen to prevent her from reaching orgasm.  It doesn't take more than a dozen seconds to fill her, and she's pulled off, crying and pouting about how she wasn't done.  The next girl steps in line, rams the juice-coated dispenser inside herself, and gets ready to become a mother...\n\n");
	
	output("Trapped in a constant orgasm by cruel machinery and a steady flow of specially tailored drugs, you start to smile uncontrollably.  True, you're utterly incapable of thinking by this point, but your body and mind are too pleased with the situation not to grin.  The situation in the corner of the scene repeats over and over as your daughters enjoy your 'milk'.  After they've had their fill they fall on each other, filling the room with orgiastic moans as any sense of order is blown away by a tide of female lust.\n\n");
	
	//// Chance of tamani saving you
	if (int(flags["COC.UNKNOWN_FLAG_NUMBER_00058"]) < 4) {
		output("You lose consciousness a few hours into the ordeal, still cumming with no sign of stopping, your body sustained by the fluids pouring into your backside.  The dreams are a constant barrage of sexual situations, flitting between various incongruous orgasmic acts.  Were you capable of comprehending your situation, you probably wouldn't even want to wake up.  Alas, the pleasure does end, and you settle into a deeper slumber.  A gentle rocking and the exhaustion of your crotch keep you snoring soundly for hours.\n\n");
		
		output("When you do wake, you find yourself alone in a forest clearing, with a note taped to your face:\n\n");
		if (int(flags["COC.UNKNOWN_FLAG_NUMBER_00058"]) == 0) {
			output("<i>   " + pc.mf("Husband","Baby") + ",\n");
			output("      Do you have any idea how hard it is for Tamani to drag you out here all by herself?  If you weren't my favorite breeder, I would've let my daughters keep you.  Next time stand up to the little twats or Tamani might look the other way while you're being milked!\n\n");
			output("   Hugs & cums,\n");
			output("      -Tamani</i>");
		}
		else {
			output("<i>   Seriously, it isn't funny.  " + pc.mf("Man", "Toughen") + "-up and beat the little cunts silly instead of letting them force themselves on you.   Do you have any idea how hard it is to drag you out here?  If you weren't so much fun in the sack Tamani would be tempted to let her daughters keep you in their milker.   Maybe the girls would give Tamani a good cut of your production to join the operation?\n\n");
			output("   Fucks & Love,\n");
			output("      -Tamani</i>");
		}
		
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	//(ALT – BAD END GATEWAY)
	else {
		output("You lose consciousness a few hours into the ordeal, still cumming with no sign of stopping, your body sustained by the fluids pouring into your backside.  The dreams you have are a constant barrage of sexual situations, flitting between various incongruous orgasmic acts.  Were you capable of comprehending your situation, you probably wouldn't even want to wake up.  Thankfully, your unwished desires become reality.");
		//[NEXT]
		addNextButton(tamaniDaughtersBadEndChoice);
	}
	//Needz variable to track how many times PC has been 'chaired'
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00058");
	//moar daughters, increment 'times milked' by the daughters.
	knockUpDaughters();
	//boost cum production slightly.
	pc.cumMultiplierRaw += .3;
	//increase libido, slight corruption, minus stregth and speed.
	processTime(3 * 60 + rand(2 * 60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.slowStatGain("p", -0.5);
	pc.slowStatGain("i", -0.5);
	pc.slowStatGain("l", 1);
	pc.cor(1);
}

private function tamaniDaughtersBadEndChoice():void {
	//spriteSelect(57);
	output("The next morning your unfocused eyes blink open, and you find yourself in the same situation as before.  Thankfully your orgasm has been allowed to end, though you still feel dopey and unfocused from whatever is flowing into you.  You manage to twist your head around to get a better look at the situation and discover a pair of IV's lodged in your arms.  Twisting your body, you realize you can still feel the drug-enema tube lodged in your " + pc.assholeDescript() + ".  Oddly, it's hard to feel worried or concerned about the situation.\n\n");
	
	output("A goblin leans over your face and hugs her jiggling breasts against you as she gushes, \"<i>Thank you so much daddy!   You probably can't see with all the straps holding you down, but you got me and my sisters totally pregnant.  There's even enough of your spunk left over to knock us up a few more times!  We decided that even though we don't need you to cum right now, we'd let you keep coming forever.  Do you want that?</i>\"\n\n");
	
	if (pc.statusEffectv1("Exgartuan") == 1) output("Exgartuan barks, \"<i>Hell yes I do!</i>\" but the goblin only smirks down for a moment before looking back at you.\n\n");
	
	output("(Options: Yes, No, I'd rather fill your cunts individually & personally)");
	clearMenu();
	addButton(0, "Yes", tamaniDaughtersYesBadEndMePlease);
	addButton(1, "No", tamaniDaughtersDeclineBadEnd);
	addButton(2, "Individual", tamanisDaughtersFillIndividuallyBADEND);
}

//[Yes]
private function tamaniDaughtersYesBadEndMePlease():void {
	//spriteSelect(57);
	clearOutput();
	output("\"<i>Wonderful!</i>\" cries the excited pregnant slut.   She gives you a quick peck on the cheek as she prances back over to the machine.  You brace yourself in anticipation, eager to lose yourself to an eternal orgasm.  A switch clicks, and a dial whirs as it's turned up to the maximum.  The fluids pumping into your backside and directly into your veins suddenly jump in pressure, stinging painfully for a moment before the pleasure returns.  Your eyes slowly roll back, your jaw goes slack, and your [pc.cocks] spew");
	if (pc.totalCocks() == 1) output("s");
	output(" [pc.cum] into the tubes.\n\n");
	if (pc.statusEffectv1("Exgartuan") == 1) output("Exgartuan moans, \"<i>Ohhhhhh yeeeeaaaaahhhh...</i>\" before slipping into silence.\n\n");
	
	output("You spend the rest of your life trapped in orgasm, constantly feeding the growth of what becomes the biggest goblin tribe in all the land of Mareth.  Even when every single one of them is pregnant, they let you enjoy your reward.  Over time your capacity for memory, morals, or anything other feeling besides pleasure dwindles.  Trapped in a heaven of your own choosing, you gave up everything that you were for never-ending bliss.");
	badEnd();
}

//[NO]
private function tamaniDaughtersDeclineBadEnd():void {
	//spriteSelect(57);
	clearOutput();
	output("\"<i>Seriously!?</i>\" exclaims the pregnant slut, \"<i>What kind of person wouldn't want to cum all the time?  Fuck, just the idea of it is making me drip!</i>\"\n\n");
	
	output("She sighs, \"<i>Whatever, Dad.  Next time we need you I'm sure you'll remember how much fun this was and come running home.</i>\"\n\n");
	
	output("The restraints pop off you at once, and you pull the tubes and IV's from your skin.  You grunt with discomfort and remove the final tube from your " + pc.assholeDescript() + ".  Climbing off the table, your " + pc.legs() + " wobble unsteadily as you try to get your balance.   The goblin says, \"<i>Go on home dad before I strap you back down and teach you to enjoy my gifts!</i>\"\n\n");
	
	output("You sheepishly leave the cave and head home, glad to be out of there before your growing tribe of daughters decides to milk you forever.\n\n");
	
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//[Rather Fill Individually]
private function tamanisDaughtersFillIndividuallyBADEND():void {
	//spriteSelect(57);
	clearOutput();
	output("\"<i>Really?</i>\" asks the pregnant goblin before she exclaims, \"<i>You do love us!  Oh Dad, once mom comes home will you fuck all of us?  I want to feel you make love to my drippy, pregnant pussy while she watches!</i>\"\n\n");
	
	output("You agree to do just that, [pc.eachCock] rising to full hardness in anticipation.  Your daughter pats ");
	if (pc.cockTotal() > 1) output("one of them");
	else output("it");
	output(" as if it were a person and smiles as she pops the restraints from your chair.  She helps you as you stagger up to your " + pc.feet() + ", though the feeling of her hand stroking ");
	if (pc.cockTotal() > 1) output("a");
	else output("your");
	output(" " + pc.cockDescript(0) + " doesn't make it easy.  The pair of you journey deeper into the caves to a massive antechamber filled with pregnant goblins.  Some are eating, others are sewing at tables, tinkering with machinery, or fiddling with alchemical equipment.  All of them turn to look at you as you enter.\n\n");
	
	output("The well endowed goblin next to you announces, \"<i>Dad has decided that he will willingly stay here and fuck each of us as often as we want.  Let's get him some succubi's delight, I want mom to watch him fill me when she gets home!</i>\"\n\n");
	
	output("A cheer reverberates off the ceiling as your daughters crowd around you, pressing their buxom chests and rounded backsides against you.  You're led to a secluded corner and fed food and strange drinks, while being kept incredibly horny for hours as you await Tamani's return.  True to her word, your daughter is on top of you in a flash once the clan's matriarch enters the room, and you're helpless to do anything but submit to her velvet pussy.  You cum loudly and messily, creaming her walls and flooding the area around you with spunk while Tamani is forced to watch with a jealous look on her face.\n\n");
	
	output("The rest of your life continues on in a similar fashion – you're kept happily fed, full, and pleasured by your hundreds of pregnant wives as your harem grows.  There's no shortage of sex, and no shortage of desire thanks to your wives' alchemical talents.  Within the span of a month you've utterly forgotten about your quest – it's hard to focus on anything but cuddling with your wives and daughters while you await your next fuck.");
	
	badEnd();
}

//[Lose to Daughters With Tamani There]
private function loseToDaughtersWithTamaniThere():void {
	//spriteSelect(57);
	clearOutput();
	IncrementFlag("COC.TIMES_FUCKED_TAMANIS_DAUGHTERS");
	//Find a dick that fits
	var primary:Number = pc.cockThatFits(cockVolume(50));

	output("Your attempts to resist prove to be in vain, as your daughters and their extra-curvy mother have completely defeated you.  ");
	if (pc.HP() <= 1) output("Lying in the dirt, too hurt to fight back, you can only tremble in anticipation of what pleasures they're going to force upon you this time.");
	else {
		output("Lying back in the dirt, you're too hard to fight back.  You stroke ");
		if (pc.totalCocks() > 1) output("one of ");
		output("your trembling [pc.cocks], feeling it leak pre-cum in anticipation of getting to knock up some of these beautiful curvy women.");
	}
	output("  Tamani pushes her way to the front of the pack, her daughters looking disappointed but yielding to their mother's authority for the time being.  She walks over to you, stepping over your fallen form and uncorking a a potion.  You grunt as she drops her jiggling ass down on your ");
	if (pc.biggestTitSize() < 1) output("chest");
	else output(pc.allBreastsDescript(), false);
	output(" and says, \"<i>Now husband, you've let your daughters beat you fair and square, so now it's time to take your medicine and give them their reward for becoming so strong.</i>\"\n\n");
	
	output("The potion's bottle becomes a plug for your mouth as Tamani forces your mouth open.  She tips it back and massages your throat with one hand, forcing you to gulp down the fluid.  ");
	if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) < 2) output("It tastes syrupy-sweet");
	else output("It has a familiar taste that you can't quite place");
	output(" and nearly makes you gag, but Tamani makes sure you drink down every drop.  An immediate numbness spreads through your body, starting at your fingertips.  It slowly crawls up your arms and then starts at your " + pc.feet() + " as well.  In no time it's hard to move, and it becomes hard to think.  Your mind feels almost like its full of cotton-candy, with fuzzy pink stuff constantly getting in the way of your thoughts.\n\n");
	
	output("Tamani rubs your temples soothingly as your " + pc.face() + " creases with worry and reassures you, \"<i>Don't worry, this will wear off soon.  This drug just shuts down your mind so it'll be nice and open to suggestion.  You can feel how hard it is to think, can't you?  Every time you muster up a thought it gets caught up in the little pink clouds and whisked away.  Don't bother, just relax and listen to Tamani's voice.</i>\"\n\n");
	
	output("She reaches into your [pc.gear] to rub ");
	if (pc.totalCocks() > 1) output("one of ");
	output("your [pc.cocks], casually stroking the hard member as she pivots around to explain, \"<i>You get so hard for Mistress Tamani, don't you?  ");
	if (int(flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 10) output("Your body must remember how much it loves being my pussy-hungry husband.");
	else output("That's because your body knows how hot and moist Tamani's pussy is and how much you want to service it.");
	output("</i>\"\n\n");

	output("Of course she's right – you can feel her wetness on your chest and you want to bury your face in it while she strokes you.  Tamani watches your eyes and turns to give you a better view, presenting her snatch while she leans back to stroke you.  She titters, \"<i>Yes, get a good look at your wife's cunt.  It looks so delicious, so warm, so inviting.  You want nothing more than to bury your cock or face into it, don't you?  That's because it's your wife's cunt, and you're a good husband.</i>\"\n\n");
	
	output("Her hand starts stroking you faster and her juices start to drip down the sides of your torso");
	if (pc.hasFur()) output(", matting your [pc.skinFurScales]");
	output(" as she continues ");
	if (int(int(flags["COC.TAMANI_TIMES_HYPNOTISED"])) < 10) output("filling your mind with truths");
	else output("reinforcing your image of yourself as an obedient husband");
	output(", \"<i>It feels so good to service your wife's aching pussy and fill it full of cum.  Your cock knows it and wants it so much that any time you see your wife, Tamani, you'll get so hard and hot for her that you'll forget about anything but worshipping her cunt, won't you?</i>\"\n\n");
			   
	output("You start nodding while she talks, your eyes never leaving the glistening fuck-hole a few inches away.  Your wife is so smart, and though you stop hearing the words, you know everything she's telling you is the truth.  The smooth skin of her hands strokes you perfectly, only getting better as they become slick with pre-cum.  Tamani's voice rises, taking on a tone of command, and then you're squirting obediently for her – a good husband.\n\n");
	
	if (pc.cumQ() < 50) output("Cum splatters and drips down Tamani's hand, forming a tiny puddle on your chest.");
	//(ALT)
	else if (pc.cumQ() < 250) output("Cum splatters over Tamani's hand and forearm, even hitting her ass and hips as you form a thick puddle over your torso that drips to the ground.");
	//(ALT2)
	else if (pc.cumQ() < 600) output("Cum splatters out in thick waves, soaking Tamani's hand, forearm, and hips with thick puddles of the stuff.  It pools on your belly for a moment, then rolls off you, forming a small pool on the ground as you keep squirting.");
	//(ALT3)
	else {
		output("A massive wave of cum erupts from you, soaking Tamani from the shoulders to the knees in thick goop.  The next wave comes out with less force, pooling your belly before rolling off to puddle on the ground.   The puddle grows into a thick pool of the stuff as your orgasm drags on.");
		if (pc.cumQ() >= 2000) output("  Eventually it stops, but by then the pool is huge and nearly five inches deep.");
	}
	output("  Pride wells up in you when you realize what a good husband you've been.  Tamani pats you on the head, and whispers, \"<i>Good job lover</i>\" as the cobwebs slowly clear away.   You remember your wife pouring a lust draft down your throat and giving you the 69 of a lifetime, but now it's time to be a good husband and father and help your daughters out too.   The girls clamber forwards, giggling to each other excitedly as they remove what little garments they have.\n\n");
	
	output("You welcome them into your arms as Tamani steps away with a strange glint in her eye, rubbing the seed on her hand into her snatch.  Potions are pressed to your lips, and you happily accept your daughters' gifts, guzzling them happily and taking the time to compliment them on their alchemical skills while ");
	if (pc.cockTotal() > 1) output("each of ");
	output("your [pc.cocks] grows back to full erectness and trembles with desire, ready to seed a womb.  The girls ");
	if (pc.cockTotal() == 1) output("grab your [pc.cocks] and stroke it with long slow strokes, just like their mother.  Unlike her, they don't seem content to wait, and in seconds a slippery gash is stretching to accommodate your cock-head.\n\n");
	else output("each grab one of your [pc.cocks] and stroke it with long slow strokes, just like their mother.  Unlike her, they don't seem content to wait, and in seconds a slippery gash is stretching to accommodate each cock-tip.\n\n");
	
	//(TOO BIG)
	if (primary < 0) {
		output("Sadly, you're just too big to properly impregnate your daughter, and a stab of worry that you might be a bad father lances through you.  ");
		if (pc.cockTotal() == 1) {
			output("Thankfully your daughter doesn't seem to mind.  She switches to resume stroking you, though the wet tightness of goblin cunt stretches around as much of your tip as it can.  Between the drugs, the sexy girl on top of you, and your desire to be a good patriarch, they have no problem getting you off into their waiting, fertile wombs.  You cry out and twitch, seeding your daughter's womb with spunk, treating her just like her mother now that she's all grown up.");
			if (pc.cumQ() > 700) output("It gets everywhere as her womb fails to contain your massive load, even after you've bloated her belly with the stuff.");
			if (pc.cumQ() > 2000) output("After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.");
		}
		else {
			output("Thankfully your daughters don't seem to mind.  They switch to resume stroking you, though the wet tightness of goblin cunts stretches around as much of your tips it can.  Between the drugs, the sexy girls on top of you, and your desire to be a good patriarch, they have no problem getting you off into their waiting, fertile wombs.  You cry out and twitch, seeding your daughters' womb with spunk, treating them just like their mother now that they're all grown up.");
			if (pc.cumQ() > 700) output("It gets everywhere as their wombs fail to contain your massive load, even after you've bloated their bellies with the stuff.");
			if (pc.cumQ() > 2000) output("After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.");
		}
		output("\n\n");
		
		output("Drained from two amazing orgasms, you start to nod off, but you're happy knowing they'll keep you hard and cumming until every empty pussy is full of thick baby-making cream.");
	}
	//(FITS)
	else {
		output("Thankfully, the hungry goblin twat is able to devour your " + pc.cockDescript(0) + " with ease.  Those pliable, fluid-slicked cunt-walls clench ever-so-tightly around you");
		if (pc.biggestCockVolume() < cockVolume(30)) output(" in spite of the large sizes they usually handle.");
		else output("r large size.");
		if (pc.totalCocks() > 1) {
			output("  You grunt happily as your daughters begin to slide up and down your lengths, moaning lewdly with every wet squelch that escapes their drooling pussies.  Thanks to the drugs, the writhing form of your sexy daughters, and the desire to be a good patriarch for your family, you get off in no time.  You cry out and twitch, seeding your daughters' womb with spunk, treating them just like their mother now that they're all grown up.");
			if (pc.cumQ() > 700) output("  It gets everywhere as their wombs fail to contain your massive load, even after you've bloated their bellies with the stuff.");
			if (pc.cumQ() > 2000) output("  After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.");
		}
		else {
			output(" You grunt happily as your daughter begins to slide up and down your length, moaning lewdly with every wet squelch that escapes her drooling pussy.  Thanks to the drugs, the writhing form of your sexy daughter, and the desire to be a good patriarch for your family, you get off in no time.  You cry out and twitch, seeding your daughter's womb with spunk, treating her just like her mother now that she's all grown up.");
			if (pc.cumQ() > 700) output("  It gets everywhere as her womb fails to contain your massive load, even after you've bloated her belly with the stuff.");
			if (pc.cumQ() > 2000) output("  After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.");
		}
		output("\n\n");
		
		output("Drained from two amazing orgasms, you start to nod off, but you're happy knowing they'll keep you hard and cumming until every empty pussy is full of thick baby-making cream.");
	}
	//Chance of tamani pregnancy, chance of daughter preggers
	knockUpDaughters();
	tamaniKnockUp();
	IncrementFlag("COC.TAMANI_TIMES_HYPNOTISED");
	//daughter countdown reset. 
	processTime(40 + rand(20));
	pc.orgasm();
	pc.slowStatGain("p", -0.5);
	pc.slowStatGain("i", -0.5);
	pc.slowStatGain("l", 1);
	pc.cor(1);
	if (inCombat()) {
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	else {
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	}
}


private function knockUpDaughters():void {
	if (flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"] != undefined || pc.virility() <= 0) return;
	flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"] = 216; //Nine day long pregnancy, just like mom
	//Determine how many kids...
	flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"] = 2;
	var cum:Number = Math.max(pc.cumQ(), pc.maxCum()) * pc.virility();
	//Breeder perk is awesome
	if (pc.hasPerk("Marae's Gift: Stud")) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"] += 3;
	if (cum >=  50 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 100 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 200 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 300 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 400 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 500 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
	if (cum >= 600 && rand(2) == 0) flags["COC.TAMANI_DAUGHTERS_PREGNANCY_COUNT"]++;
}

internal function combatWinAgainstDaughters():void {
	//spriteSelect(57);
	processTime(15 + rand(5));
	if (enemy.HP() <= 1) {
		output("You smile in satisfaction as " + enemy.a + enemy.short + " collapses, unable to continue fighting.");
		if (pc.lust() >= 33 && pc.cockTotal() > 0) {
			output("In spite of their injuries, they do try to present their bodies in as lewd a way as possible.  You could still fuck them, but things might get out of hand...\n\nDo you fuck them?");
			output("\n\n");
			clearMenu();
			addButton(0, "Yes", fuckYoDaughtersHomie);
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); } );
		}
		else {
			output("\n\n");
			processTime(15 + rand(5));
			CombatManager.genericVictory();
		}
		return;
	}
	else {
		output("You smile in satisfaction as your daughters collapse in upon themselves, devolving into a frenzied orgy.  It looks like they're too distracted to continue fighting.  They're putting on quite a show...\n\n");
		pc.lust(5);
		if (pc.lust() >= 33 && pc.cockTotal() > 0) {
			output("You could still fuck them, but things might get out of hand...\n\nDo you fuck them?");
			output("\n\n");
			clearMenu();
			addButton(0, "Yes", fuckYoDaughtersHomie);
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); } );
		}
		else {
			output("\n\n");
			processTime(15 + rand(5));
			CombatManager.genericVictory();
		}
		return;
	}
}

public function loseToDaughters():void {
	//spriteSelect(57);
	if (pc.lustQ() >= 100) {
		//worms r gross mmmmkay?
		if (pc.hasStatusEffect("Infested")) {
			infestOrgasm();
			output("\n\nOne of the goblins sigh and say, \"<i>Dad, that's just gross.  Don't get me wrong, we're still gonna have you knock us up, but I hate the feeling of those worms inside me.</i>\"");
			pc.orgasm();
		}
		output("\n\nYou give up, you're just too turned on by the sea of sexually charged deviants to resist them anymore.  You're ready to fuck them all.");
		if (pc.cockTotal() == 0) {
			output("The sexy sluts pout, \"<i>Why did you have to go and get rid of your dick!?</i>\" before something hits you in the head, HARD, knocking you out.");
			output("\n\n");
			processTime(150 + rand(50));
			CombatManager.genericLoss();
			return;
		}
		if (tamaniPresent) {
			if (rand(2) == 0) addNextButton(loseToDaughtersWithTamaniThere);
			else addNextButton(legTamanisDaughtersRAEPYou);
			return;
		}
		else {
			if (rand(2) == 0) addNextButton(tamaniDaughtersCombatLossDrain);
			else addNextButton(legTamanisDaughtersRAEPYou);
			return;
		}
	}
	//hp loss
	else {
		output("\n\nOverwhelmed by your wounds, you can't even try to stop the goblin horde...");
		if (pc.cockTotal() == 0) {
			output("The sexy sluts pout, \"<i>Why did you have to go and get rid of your dick!?</i>\" before something hits you in the head, HARD, knocking you out.");
			output("\n\n");
			processTime(150 + rand(50));
			CombatManager.genericLoss();
			return;
		}
		if (tamaniPresent) {
			addNextButton(loseToDaughtersWithTamaniThere);
			return;
		}
		else {
			if (rand(2) == 0) addNextButton(tamaniDaughtersCombatLossDrain);
			else addNextButton(legTamanisDaughtersRAEPYou);
			return;
		}
	}
}