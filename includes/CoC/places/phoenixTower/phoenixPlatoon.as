import classes.Characters.CoC.CoCPhoenixPlatoon;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get phoenixPlatoon():CoCPhoenixPlatoon {
	return new CoCPhoenixPlatoon();
}

//Phoenix Platoon -- PC is Defeated
public function phoenixPlatoonMurdersPC():void {
	clearOutput();
	output("You collapse, too ");
	if (pc.lustQ() >= 100) output("turned on");
	else output("badly injured");
	output(" to continue the fight.  The platoon of heavy infantry breaks their formation, circling around you with shields still raised, keeping you from making any kind of last-ditch attack.  One prods you with the flat of her blade.  \"<i>Is " + pc.mf("he","she") + " down?</i>\"");

	output("\n\n\"<i>Yeah,</i>\" another says. \"<i>This one's a goner. Let's bring " + pc.mf("him", "her") + " up to mom.</i>\"");
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	processTime(15);
	clearMenu();
	addButton(0, "Next", harpyQueenBeatsUpPCBadEnd);
}

//Phoenix Platoon -- PC is Victorious
public function phoenixPlatoonLosesToPC():void {
	clearOutput();
	output("With one final grunt, the last of the phoenixes collapses onto the pile of defeated warriors you've left in your wake.  The once-mighty platoon of soldiers has been reduced to a bruised, lusty heap of flesh, scales and feathers.  Seeing that the battle is won, you lower your [pc.mainWeapon] and take a look around.");
	flags["COC.HEL_PHOENIXES_DEFEATED"] = 1;
	
	output("\n\n");
	processTime(15);
	CombatManager.genericVictory();
}

//[Phoenixes]
public function checkOutDemBirdBitches():void {
	clearOutput();
	clearMenu();
	output("You loom over the defeated heavy infantry, marveling at them.  The half-breeds were probably the most organized and efficient fighting unit you've ever come across here in Mareth, and though you defeated them, you know most denizens of the region wouldn't have stood a chance.");
	addDisabledButton(0, "Missionary", "Missionary", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(1, "Get Wanked", "Get Wanked", "This scene requires you to have cock and sufficient arousal.");
	addDisabledButton(2, "Ride Vaginal", "Ride Vaginal", "This scene requires you to have vagina and sufficient arousal.");
	addDisabledButton(3, "Ride Anal", "Ride Anal", "This scene requires you to have sufficient arousal.");
	if (pc.lust() > 33) {
		output("\n\nYou suppose you could use one of them to get yourself off.");
		//(Display Options:
		//If Male: [Missionary] [Get Wanked] [Ride Anal] (Capacity: 80)
		if (pc.hasCock()) {
			if (pc.cockThatFits(phoenixPlatoon.vaginalCapacity()) >= 0) addButton(0, "Missionary", phoenixMissionary, undefined, "Missionary", "Fuck one of the phoenixes with your penis.");
			else addDisabledButton(0, "Missionary", "Missionary", "You're too big to fuck one of them properly.");
			addButton(1, "Get Wanked", phoenixWanking, undefined, "Get Wanked", "Force one of the phoenixes to jerk you off.");
		}
		if (pc.hasVagina()) addButton(2, "Ride Vaginal", phoenixAginal, undefined, "Ride Vaginal", "Ride one of the phoenixes' cocks vaginally.");
		//If Female: [Ride Vaginal] [Ride Anal]
		//If Genderless: [Ride Anal]
		addButton(3, "Ride Anal", gitButtRoadPhoenix, undefined, "Ride Anal", "Ride one of the phoenixes' cocks anally.");
	}
	addButton(14, "Back", mainGameMenu);
}

//Phoenixes -- [Missionary]
public function phoenixMissionary():void {
	clearOutput();
	var x:Number = pc.cockThatFits(phoenixPlatoon.vaginalCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	var y:Number = pc.cockThatFits2(phoenixPlatoon.analCapacity());
	output("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\" Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, fixing her expression in place like chiseled marble, determined not to look you in the eye as you take your pleasure.");

	output("\n\nYou grab her legs and force them apart, revealing her slick pussy and half-rigid cock, surprisingly aroused for someone who seems insistent on not enjoying herself.  You slip a hand into her soaking twat, letting a pair of fingers slither inside her. She groans, gritting her teeth as you go deeper and deeper inside her.  With a grin, you pull out and force those same fingers into her mouth.  Wide-eyed, she sputters and shakes her head, but you don't let up until she's had a good, long taste.");

	output("\n\nYou chide her, telling her that if she doesn't want it so much, why is she so wet?");

	output("\n\n\"<i>I-I am not! It's natural!</i>\"");

	output("\n\nOh, really? Is she sure she doesn't just want your cock?");

	output("\n\n\"<i>I... well... maybe...</i>\" she admits, and you nod as her once-struggling legs go a bit limp.");

	output("\n\nYou return your attention to between her legs.  Getting her fully erect reptilian cock out of the way, you expose your prize - her sodden cunt");
	if (y != -1) output(" and the tight ring of her pucker");
	output(".  You grasp her wide flanks and, lining your [pc.cock " + x + "]");
	if (y != -1) output(" and extra boner up with her holes");
	else output(" up with her hole");
	output(", push in, penetrating her cunt");
	if (y != -1) output(" and ass");
	output(" and sliding into her warm, wet channel");
	if (y != -1) output("s");
	output("."); 

	output("\n\nThe phoenix squirms as you push into her depths, groaning as more and more of your cockmeat pierces her until you finally hilt her.  Gritting her teeth, the phoenix reaches up and grabs your shoulders, holding onto you as your cock");
	if (y != -1) output("s drive");
	else output(" drives");
	output(" into her; you roll your hips back and forth for short but powerful strokes into her blazing hot innards.  As the pace picks up, you pull the phoenix-girl into a long, tender kiss.  The kiss soon turns into her moaning into your mouth as you fuck her cunt ");
	if (y != -1) output("and ass ");
	output("hard, slamming your hips into hers.");

	output("\n\nShe cums first");
	if (y != -1) output(", your double penetration too much for her to handle");
	output(".  The phoenix grips your shoulders tight enough for her claws to cut into you as her tight pussy ");
	if (y != -1) output("and tighter sphincter spasm");
	else output("spasms");
	output(" around your dick");
	if (y != -1) output("s");
	output(".  With her squirming in your embrace and squeezing down so hard, you can't help but blow your load.  You press your lips hard into hers and cum, pumping thick ropes of steaming jizz into her wet box");
	if (y != -1) output(" and hot asshole");
	output(".  As you cum into her, you feel her reptile prick shoot off, squirting a long white rope onto her chest and yours until her tits are soaked with her spunk.");

	output("\n\nYou release the phoenix from your embrace, and are pleased to see she's passed out from the overwhelming pleasure.  Grinning, you pull your cock");
	if (y != -1) output("s");
	output(" out of her ravaged hole");
	if (y != -1) output("s");
	output(" and gather your gear.");
	//(Return to Mezzanine main menu)
	processTime(15 + rand(5));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Phoenixes -- [Get Wanked]
public function phoenixWanking():void {
	var y:Number = pc.biggestCockIndex();
	clearOutput();
	output("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\"  Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  You grope one of her breasts roughly, pinching the nipple between your fingers until she's whimpering with pain and pleasure.  You let up for just a moment and tell the girl that she's going to get you off with her special endowments, or you're going to put her in a world of hurt.");

	output("\n\nWith a groan, she nods her head.  You release her sensitive breast and present your [pc.cock " + y + "].  Reluctantly, the phoenix-girl brings her fiery tail around and, extinguishing it, begins to snake it around your prick.  You urge her on as she wraps her long, prehensile appendage around your shaft, wringing it like a sponge as her tail's grip tightens.  You run your hands through the girl's bright red hair, stroking her gently as she starts to jerk your [pc.cock " + y + "] off with her tail.");

	output("\n\nIt feels heavenly, and you shudder with delight as her warm, scaly tail rubs and strokes and squeezes you... But it isn't quite enough, not with so many other parts of her left!  You push her looped tail off the tip of your [pc.cock " + y + "] and tell the phoenix to put her soft, feathery red wings to good use.  She gawks at you, but a quick grope of her tits urges her to the task.  She furls her auburn wings around her shoulders, letting the fringes stroke and caress the sensitive [pc.cockHead " + y + "] of your cock.  You barely contain yourself at the downy touch of her feathers along your [pc.cock " + y + "]'s head and length, and urge her onwards with encouraging words and more gentle, loving squeezes and teases of her lush tits.");

	output("\n\nYou notice that by now the phoenix-girl is openly fingering herself.  You continue to run your fingers through her hair, whispering encouragements and sweet nothings at her as she continues to squeeze and gently caress your [pc.cock " + y + "].  You feel your orgasm coming, and quickly grab the phoenix by the shoulders and push her forward, forcing her to take your cockhead into her mouth as you cum.");

	output("\n\nYour [pc.cock " + y + "] explodes, pumping a thick load into the shocked phoenix's mouth.  She gags on your cum, finally swallowing it as the last of your sperm drips into her mouth.  With a grin, you tell her what a good job she did as you withdraw your [pc.cock " + y + "]  from her grip.  With little rivulets of cum dripping down her face, the half-breed collapses onto her back, rapidly fingering herself.");
	//(Return to Mezzanine main menu)
	processTime(15 + rand(5));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
	
//Phoenixes -- [Git Butt-rode]
public function gitButtRoadPhoenix():void {
	clearOutput();
	output("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\" Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath. The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  Gripping the warrior by her hefty boobs, you tell the phoenix that it's her lucky goddamn day: you're going to let her fuck your ass.");

	output("\n\nThe phoenix stares up at you with a mix of eagerness and caution.  \"<i>Wait... you're gonna let me... do that? Really?</i>\"");

	output("\n\nYou nod.");

	output("\n\n\"<i>Uh, well... okay, then. If that's what you want....</i>\"");

	output("\n\nYou quickly discard your [pc.gear] and, pushing the girl back onto her back, squat over your prize.  You wrap your hand around her stiff lizard prick and start to stroke it, running your hand along her bulbous purple shaft.  The phoenix makes a pleasured gasp as you start to jerk her off, idly playing with her lush tits or slick pussy as you stroke her to full hardness.");

	output("\n\nOnce you're satisfied that she's completely rigid, you shift your [pc.hips] so that your [pc.asshole] is hovering over the phoenix's thick twelve-incher.  You allow her to put her hands on your hips and guide you down, until you can feel her narrow head pressed against your backdoor.  Biting your lip to stifle a cry of pain and pleasure, you do the honors, guiding her wide prick to slip past your relaxed sphincter and into your bowels.");
	pc.buttChange(phoenixPlatoon.cockVolume(), true, true, false);

	output("\n\nYou grunt as she bottoms out inside you, leaving you with a feeling of intense fullness and warmth, grinning down at the phoenix-girl and pleased to see the look of rapture on her face as your ass muscles squeeze down on her stiff lizard-cock.  You feel her hands digging into your [pc.hips], and in return you give her soft breasts a playful squeeze.  You start to rock your hips, letting an inch or two of her dick spill out of you before your [pc.asshole] sucks it back up.");

	output("\n\nSurprisingly, the phoenix-girl shifts her hands from your hips to your shoulders and pulls you down on top of her, pushing your face into her pillowy breasts.  Before you can chastise her, your lover slams her cock into you, making you scream with pleasure into her soft flesh.  Grinning, she wraps her wings, legs, and tail around you, completely immobilizing you as she starts to hammer your ass, pistoning her cock in and out of you.");

	output("\n\nHelpless under the phoenix's surprise attack, you can do little more than grit your teeth and let the pleasure take you.  You return her embrace, taking one of her nipples into your mouth to play with as she fucks you raw.  You can feel an anal orgasm mounting and quickly try to relax yourself, letting in more and more of her cock until she is again hilting you, her hips slamming into your [pc.butt].");

	output("\n\nUnable to hold on for long, you bite down on her pink nipple and cum, letting waves of pleasure wash over you from your rectal intruder.  Your sphincter clamps down hard on the lizard prick inside you, milking it just like a pussy would until, spurred on by your orgasm and bite to her most sensitive flesh, the phoenix-girl cums.  You yelp as her burning-hot cum rushes into your ass, scalding your walls until you feel a massive wave of pleasure crash into you - a second orgasm! Your mind goes utterly numb, nearly blacking out as tremors of ecstasy pump into you from her dick.");

	output("\n\nWhen you come to your senses a few minutes later, the phoenix-girl is asleep, still holding you tight.  You pull her deflated lizard dick out of your ass and shudder as a torrent of her sizzling hot spunk dribbles out onto her thighs and hips.  You wriggle out of her tight embrace and give her a little kiss on the cheek before collecting your [pc.gear] and heading out.");
	//(Return to Mezzanine main menu)
	processTime(15 + rand(5));
	pc.loadInAss(phoenixPlatoon);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Phoenix -- [Ride Vaginal]
public function phoenixAginal():void {
	clearOutput();
	output("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\"  Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  You ignore her temporary defiance and grab her cock.");

	output("\n\n\"<i>Heeeey,</i>\" the phoenix whines squirming to get out of your grip.");

	output("\n\nYou maintain your grasp on her long, purple lizard dick and tell her that you're doing her a favor: you're going to let her fuck your [pc.vagina].  She stops struggling at the invitation.");

	output("\n\n\"<i>Oh. Well,</i>\" she says, smirking slightly.  \"<i>If you want a bit of phoenix seed... I guess I wouldn't mind a chance at being a daddy.</i>\"");

	output("\n\n");
	//[If Broodmother, not pregnant: 
	if (pc.fertility() > 0 && pc.pregnancyIncubationBonusMother() > 2) output("You assure her she will be soon");
	else output("You grin at her");
	output(" and strip out of your [pc.gear]. The phoenix, a bit more dominant than you might have liked, roughly grabs your [pc.chest], pinching your nipples as she takes over wringing her cock from you. Oh well. You decide to roll with it and slide a hand down to your [pc.vagina], stroking your pussy as your lover warms up.");

	output("\n\nWhen she's nice and hard, you give the phoenix a little push onto her back and clamber into her lap, lining her lizard prick up with your [pc.vagina].  Before you can get properly situated, though, the girl pulls you down onto her cock, impaling you up to her hilt in one massive thrust.  You roll your head back and scream, a mix of pleasure and burning pain shooting through you as her white-hot rod slams into your innermost depths.");
	pc.cuntChange(0, phoenixPlatoon.cockVolume(), true, true, false);

	output("\n\nBy the time you're somewhat recovered from her surprise attack, the phoenix-girl has started rocking her hips into yours, grinding her long prick into you.  You give her hefty tits a rough squeeze and push her back down, holding her down by her mammaries as you start to ride her cock.  Having gotten her thrill, the phoenix-girl submits to you, only venturing to hold onto your [pc.hips] as you fuck her.  For your part, you bask in the sensation of her thick dick sliding in and out of your well-lubricated depths, rubbing and stroking your sensitive inner walls with its bulbous length."); 

	output("\n\nNow that you're into the swing of things, you give your phoenix lover a hand up, pulling her into a sitting position and burying her face into your [pc.chest].  She struggles for a moment but, after seeing how nice cuddling against your warm flesh is, she relaxes into your embrace.  You start to bounce on her cock, smushing her face into your breasts at the apex of each bounce, and slamming her prick deep inside you as you fall.");

	output("\n\nUnable to take the cumulative pleasure, the phoenix cums.  You go wide-eyed as her burning hot cum pours into your waiting womb, scalding your depths with her sizzling, potent seed.  You can only keep riding her, letting her jizz flow into you until the heat and pleasure sends you over the edge too.  You hug the phoenix tight as orgasm hits you, shuddering and gasping as ecstasy threatens to overwhelm you.  Your [pc.vagina] milks your lover for every last drop until, breathless, you release your death-hold on your lover, letting her flop, insensate, to the ground.");

	output("\n\nYou stand, a bit bow-legged, and watch as a bucket's worth of her extra seed pours out of your sodden twat, pooling on the phoenix's breasts and belly.  Giggling, you stumble off her and collect your [pc.gear].");
	//pc.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, 120, 100);
	//v1 = egg type.
	//v2 = size - 0 for normal, 1 for large
	//v3 = quantity
	//pc.createStatusEffect(StatusEffects.Eggs,rand(6),0,(5+rand(3)),0);
	//(Return to Mezzanine main menu)
	processTime(15 + rand(5));
	pc.loadInCunt(phoenixPlatoon);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}