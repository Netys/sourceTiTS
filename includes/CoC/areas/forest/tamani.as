import classes.Characters.CoC.CoCTamani;
import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GameData.StatTracking;
import classes.GLOBAL;
import classes.kGAMECLASS;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function showTamani():void {
	userInterface.showName("\nTAMANI");
}

public function get tamani():CoCTamani
{
	return new CoCTamani();
}

public function CoCTamaniPCVictory():void
{
	clearOutput();
	clearMenu();
	IncrementFlag("COC.TAMANI_DEFEATS");
	if (enemy.HP() <= 1) {
		output("Tamani is defeated!\n\n");
	} else {
		output("Tamani gives up on defeating you and starts masturbating!\n\n");
	}
	
		
	addDisabledButton(0, "Fuck", "Fuck", "This scene requites you to have sufficient arousal.");
	addDisabledButton(1, "Buttfuck", "Fuck", "This scene requites you to have fitting cock and sufficient arousal.");
		
	if (pc.lust() >= 33 && pc.hasCock()) {
		output("You could fuck her, but if that's the case why did you bother fighting her?\n\nWhat do you do to her?\n\n");
		
		addButton(0, "Fuck", tamaniSexWon);
		
		if (pc.hasCock() && pc.cockThatFits(enemy.analCapacity()) >= 0)
			addButton(1, "Buttfuck", tamaniAnalShits);
	}
	
	addButton(14, "Leave", function():*{ processTime(20 + rand(10)); CombatManager.genericVictory(); } );
}

public function CoCTamaniPCLoss():void
{
	clearOutput();
	clearMenu();
	flags["COC.TAMANI_DEFEATS"] = 0;
	if (pc.HP() <= 1){
		if(pc.totalCocks() > 0) {
			if(rand(2) == 0) tamaniSexLost();
			else tamaniSexLetHer();
		}else {
			output("Tamani sighs as you begin to lose conscious, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"");
			processTime(60 + rand(30));
			CombatManager.genericLoss();
		}
	} else {
		if(pc.totalCocks() > 0) {
			//hypnoslut loss scene
			if(flags["COC.TAMANI_TIMES_HYPNOTISED"] > 19 && rand(2) == 0) {
				getRapedByTamaniYouHypnoSlut();
			} else if(rand(2) == 0) tamaniSexLost();
			else tamaniSexLetHer();
		} else {
			processTime(60 + rand(30));
			output("You give into your lusts and masturbate, but Tamani doesn't seem to care.  She kicks and punches you over and over, screaming, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"");
			pc.HP(-9999);
			CombatManager.genericLoss();
		}
	}
}

public function TamaniTimePassedNotify():void {
	if (flags["COC.INCUBATION_TAMANI"] == undefined) return;
	flags["COC.INCUBATION_TAMANI"]--;
	if (flags["COC.INCUBATION_TAMANI"] <= 0) tamaniGivesBirth(); //Silently clear Tamani's pregnancy if the player doesn't encounter her in time
}

private var TamaniTimePassedNotifyHook: * = TamaniTimePassedNotifyGrapple();
private function TamaniTimePassedNotifyGrapple():* { 
		timeChangeListeners.push(TamaniTimePassedNotify);
	}

private function tamaniGivesBirth():void {
	//if (pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) { //Don't want drider eggs to add to her daughers
		StatTracking.track("coc/pregnancy/tamani impregnated");
		StatTracking.track("coc/pregnancy/tamani daughters", flags["COC.TAMANI_PREGNANCY_COUNT"]);
		StatTracking.track("coc/pregnancy/total offsprings", flags["COC.TAMANI_PREGNANCY_COUNT"]);
	//}
	flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"]) + int(flags["COC.TAMANI_PREGNANCY_COUNT"]);
	flags["COC.TAMANI_PREGNANCY_COUNT"] = undefined;
	flags["COC.INCUBATION_TAMANI"] = undefined;
	
}

internal function tamaniChest():String {
	var descript:String = "";
	switch (StatTracking.getStat("coc/pregnancy/tamani impregnated")) {
		case -1:
		case  0: descript = (rand(2) == 0 ? "ample " : "handful of "); break;
		case  1:
		case  2:
		case  3: descript = (rand(2) == 0 ? "large " : "jiggling "); break;
		case  4:
		case  5:
		case  6: descript = (rand(2) == 0 ? "wobbling " : "impressive "); break;
		case  7:
		case  8:
		case  9:
		case 10: descript = (rand(2) == 0 ? "over-proportioned " : "super-sized "); break;
		default: descript = (rand(2) == 0 ? "massive " : "gigantic "); break;
	}
	switch (rand(11)) {
		case  0:
		case  1:
		case  2: return descript + "tits";
		case  3: return descript + "melons";
		case  4: return descript + "mounds";
		case  5: return descript + "muffins";
		case  6: return descript + "knockers";
		case  7: return descript + "love-pillows";
		default:
	}
	return descript + "breasts";
}

//[Encounter Tamani – female]
private function tamaniFemaleEncounter():void {
	showTamani();
	clearOutput();
	output("A goblin leaps out from behind a rock outcropping.  She keeps her arms folded across her " + tamaniChest() + " and glares at you.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts bulges out around her arms, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.\n\n");
	output("She says, \"<i>There's only so much cock around, and I got dibs on ALL of it, O.K. skank?</i>\"\n\n");

	//[Umm OK?] [No]
	clearMenu();
	addButton(0, "Umm OK?", tamaniFemaleYes);
	addButton(1, "No", tamaniFemaleNo);
	addButton(2, "PreferGirls", preferTamaniFemdom);
}

//(Umm OK?)
private function tamaniFemaleYes():void {
	showTamani();
	clearOutput();
	output("\"<i>That's what I thought,</i>\" says the goblin as she fishes around in her pouches, \"<i>but I'm not cruel, I'll give you my best dildo so you can keep your hot little box stuffed all the time.</i>\"\n\n");
	output("She pulls out a long pink dick and tosses it to you.  You catch it and it flops around, nearly slapping you in the cheek.  ");
	if(cor() < 50) output("Gross.\n\n");
	else output("Getting cock-slapped would've been kind of hot...\n\n");
	output("The goblin leaves you with a warning, \"<i>Be careful, it likes to leak aphrodisiacs like crazy.  Believe me, those are FUN to get addicted to.  Oh, and remember – Tamani owns all the cocks around here, so if you ever grow one, come pay your dues!</i>\"\n\n");
	output("(<b>Deluxe Dildo acquired!</b>)");
	pc.createKeyItem("Deluxe Dildo", 0, 0, 0, 0);
	processTime(5);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
//[No] 
private function tamaniFemaleNo(): void {
	showTamani();
	clearOutput();
	output("The goblin harrumphs, \"<i>We'll see about that slut.  I'll be knocked up from every monster and stud this side of the mountain.  Hell, just grow one dick, and see how fast Tamani's legs get wrapped around you!</i>\"\n\n");
	output("She flounces off, clearly planning on fucking everything capable of producing sperm on her way home.  ");
	if(pc.cor() < 33) output("What a slut.");
	else if(pc.cor() < 66) output("How odd.");
	else output("You hope she misses a few.");
	processTime(5);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
//[Encounter Tamani – HAZ COCK]
//[First Time]
private function tamaniMaleFirstEncounter():void {
	showTamani();
	flags["COC.TAMANI_MET"] = 1; //Indicates you've met her as a male at least once
	clearOutput();
	output("A goblin leaps out from behind a rock outcropping.  For something so small, she has a lot of curves.  She advances towards you, rolling her hips in a suggestive way, immediately diverting your blood-flow to your crotch.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts jiggles pleasantly with every step, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.\n\n");
	output("The goblin makes you an offer that's difficult to turn down, \"<i>Hey there stud, want to fuck me pregnant?  I promise my box will milk your dick dry.  Just let Tamani take care of all your boners OK?</i>\"");
	//[Fuck Her] [Refuse]
	clearMenu();
	addButton(0, "Fuck Her", tamaniFirstTimeConsentual);
	addButton(1, "Refuse", tamaniFirstTimeRefusal);
}
//[Fuck Her – Consentual First Time]
private function tamaniFirstTimeConsentual():void {
	showTamani();
	tamaniKnockUp();
	clearOutput();
	output("You almost can't believe your good fortune.  Finally you meet a creature willing to talk instead of just launching into violent rape.   Her direct advances were so crude and overtly sexual that you felt yourself stiffening before she could even finish her offer.   Your decision was made by the tent in your [pc.gear].  You'll give Tamani exactly what you both want.\n\n");
	output("Her hips sway seductively as she approaches with her right hand dipping into the moist honeypot of her sex.  You disrobe, throwing your [pc.gear] to the side before you reach down and lift her up, pressing her curvy body against your [pc.allChest].  She wraps her tiny arms around your neck and kisses you passionately, letting her tongue slither through your lips.   The two of you french kiss hard, virtually tongue-fucking each other.\n\n", false);
	output("She breaks the kiss and smiles, licking the shining purple lipstick she wears as she whispers in your ear, \"<i>Mmmhmm, I knew your juicy cock just couldn't resist a wet and ready pussy like mine.  I made sure to lace my lipstick with fertility enhancing chemicals too, so we'll be nice and messy.</i>\"\n\n");
	output("As if to emphasize her point, she curls her toes around your [pc.cock], squeezing as she slides her feet up and down your length, milking out a few large drops of pre-cum.  You groan and kiss her again – too turned on to care if the drug-laced lipstick turns your orgasm into a pregnancy-inducing flood. ");
	if(pc.balls > 0) output("Your [pc.balls] swell with seed, spurring your desire to new heights.");
	else output("Something inside you swells up with seed, spurring your desire to new heights.");
	output("  You NEED to fuck her pussy full – NOW.\n\n");
	
	var cockId:int = pc.cockThatFits(tamani.vaginalCapacity());
	//(FITS)
	if(cockId != -1) {
		output("Tamani breaks the kiss and gives you a coy smile as she shimmies down your body, dropping her moist cunt onto your [pc.cock " + cockId + "]'s [pc.cockHead " + cockId + "].  She swings her hips in a little circle, teasing you with her moist entrance as your drug-enhanced pre-cum bubbles and drools around her lips, mixing with her own copious fluids as it flows down your length");
		if(pc.balls > 0) output(" and drips from your [pc.balls]");
		output(".  She stops and teases, \"<i>Ready to stuff me full of your cream?  I just KNOW I'll get pregnant from such a purrfect mate.</i>\"\n\n");
		output("Tamani doesn't wait for an answer – she pauses until you're about to reply, then drops her weight down, fully impaling herself and turning the beginnings of your reply into a babbled moan.");
		pc.cockChange();
		output("  She plants her feet on your thighs and her arms around your back and begins bouncing up and down rapidly, squeezing and contracting, milking your [pc.cock " + cockId + "] in her tight wet walls the entire time. Your inner abdominal muscles begin clenching and squeezing, sending a wave of heat through your groin as your baby-batter begins its journey towards the goblin's womb.\n\n");
		output("You grab her with both hands and slam her down, taking her to the hilt");
		if(pc.cocks[cockId].cLength() > 12) output(" and watching her belly bulge from your size");
		output(".  She twists violently, practically thrashing in your arms as spunk begins pouring into her womb, making her belly start to bloat.  The goblin babbles incoherently with each blast of cum, stretching tighter and tighter around you as her pussy works to hold in every drop of spunk.  Her belly bloats a bit more, until the pressure is too much to bear and jism begins spurting around her opening, splattering into a puddle on the ground.\n\n");
		output("All good things eventually end, and with a sigh you pull the insensate goblin slut free of your [pc.cock " + cockId + "], watching a river of whiteness drain from between her thighs.  You set her down and the escaping jism suddenly stops, the remainder held inside by some kind of reflex.  Tamani giggles and pats her still pregnant-looking belly, \"<i>Wasn't the sample nice?  Come see me when your dick has had a chance to recover and we can do this again, and again, and again.  You're practically hooked already aren't you " + pc.mf("stud","hun") + "?</i>\"\n\n");
		output("It takes a moment to put your [pc.gear] back on and make ready to leave, but somehow you know this isn't the last you've seen of this goblin.");
		//[CORRUPT]
		if(pc.cor() > 66) output("  Your [pc.cock " + cockId + "] twitches at the thought, ready and wanting more.");
	}
	//(TOO BIG)
	else {
		output("Tamani breaks your sloppy kiss and shimmies down your body, clutching tightly to your [pc.cock] and [pc.skin] as she settles down lower on your groin.  The goblin somehow manages to turn herself around so that is she is hanging upside-down, with her legs and arms clutching tightly to your member while her tongue ");
		if(pc.hasSheath()) {
			output("licks the edges of your sheath");
			if(pc.balls > 0) output(" and balls");
		}
		else {
			if(pc.balls > 0) output("licks all over your balls");
			else if(pc.hasVagina()) output("sneaks between your folds to tease your now-hardening [pc.clit]");
			else output("licks the sensitive [pc.skinFurScalesColor] [pc.skinFurScalesNoun] of your inner thighs");
		}
		output("\n\n");
		output("Her cunt grinds on your crown, smearing it with a mixture of the drooling cunt-lubricant and your own drizzles of pre-cum.  As your dick becomes slick and wet, the feeling of her arms and legs wrapped around you feels better and better.   She even squeezes her arms tight around you like a cock-ring, making your dick pulse and swell with blood for a few seconds before she releases.  Your inner abdominal muscles begin clenching and squeezing, sending a wave of heat through your groin as your baby-batter begins its journey to freedom.\n\n");
		output("She feels it pass between the fingers she has pressing on her vulva, and with surprising athleticism, the goblin pushes herself up, landing the wet gash of her cunt directly on top of your over-sized urethra.  You groan as the first wad blasts free of your body, filling her rather adaptable love-canal with thick spoo.  A few sprays of spunk squirt out to the sides around the edge of the imperfect seal, while her hands work from the bottom to the top of your [pc.cock] trying to squeeze out even more.\n\n");
		output("Tamani's body starts to distend as you pack more and more spunk into her hungry womb.  Her belly bloats out as more and more jizz escapes around her wet lips, unable to fill her any further.  The goblin rocks from the force of your eruptions before falling off and landing flat on her back.  Still, your body keeps pumping out more");
		if(pc.balls > 0 && pc.ballFullness >= 100) output(", visibly draining your [pc.balls] down to their normal size");
		output(" as Tamani does her best to catch it in her mouth and soaked cunt.\n\n");
		output("You shake the last few drops of spoo free, letting them drip into her hair as you finish.  You look down at the satisfied goblin girl as she says, \"<i>Wasn't my free sample nice?  Come see me when your dick has had a chance to recover and we can do this again, and again, and again.  You're practically hooked already aren't you " + pc.mf("stud","hun") + "?</i>\"\n\n");
		output("It takes a moment to put your [pc.gear] back on and make ready to leave, but somehow you know this isn't the last you've seen of this goblin.");
		//([CORRUPT]
		if(pc.cor() > 66) output("  Your [pc.cock] twitches at the thought, ready and wanting more.");
	}
	pc.orgasm();
	//dynStats("lib", .5, "sen", -1, "cor", .5);
	pc.libido(0.5);
	pc.cor(0.5);
	processTime(15);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Refuse – First Time Meeting]
private function tamaniFirstTimeRefusal():void {
	showTamani();
	clearOutput();
	output("Tamani's eyes widen in surprise, \"<i>Don't let the size fool you, big " + pc.mf("boy", "girl") + ". I can take more than you think,</i>\" she says while her hands begins playing with her box, \"<i>Are you sure you don't want to just let off a little steam?</i>\"\n\n");
	pc.lust(5);
	processTime(1);
	//[Fuck Her (Goes to fuck her - consensual first time)]
	//[No means no]
	clearMenu();
	addButton(0, "Fuck Her", tamaniFirstTimeConsentual);
	addButton(1, "No", tamaniSecondRefusal);
}
//[No Means No]
private function tamaniSecondRefusal(): void {
	showTamani();
	clearOutput();
	output("The goblin pouts, anger clouding her cute little features.  She turns and storms off, clearly pissed at you, \"<i>Think about it.  Next time that dick better ache for me, or I'll MAKE you want it.</i>\"\n\n");
	output("...What?");
	processTime(1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[REPEAT MALE ENCOUNTER]
private function tamaniMaleRepeatEncounter():void {
	showTamani();
	clearOutput();
	//(IF FUCKED - check to see if she's pregnant or has given birth) 
	//if (pregnancy.isPregnant || flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] > 0) output("While exploring, you're startled by the feeling of tiny hands stroking the insides of your thighs.  You look down and find Tamani there, grinning wolfishly,  \"<i>Ready for another fuck, big " + pc.mf("boy", "girl") + "?\"\n\n", false);
	//(ELSE) 
	//else 
	output("While exploring, you're startled by the feeling of tiny hands stroking the insides of your thighs.  You look down and find Tamani the goblin there, grinning with desire, \"<i>Ready to stuff me with cum?  I'm not taking no for an answer this time.</i>\"\n\n");
	if(flags["COC.TAMANI_TIMES_HYPNOTISED"] > 19 && rand(2) == 0) {
		getRapedByTamaniYouHypnoSlut();
		return;
	}
	//(+1 lust per 10 sensitivity)
	pc.lust(pc.libido() / 10);
	//dynStats("lus", pc.sens/10);
	//[Take Her – win sex] 
	//[Let Her – Get dommed] 
	//[No – starts fight]
	clearMenu();
	addButton(0, "Take Her", tamaniSexWon);
	addButton(1, "Let Her", tamaniSexLetHer);
	addButton(2, "No", tamaniStartFight);
}

private function tamaniStartFight():void {
	clearOutput();
	output("Tamani adopts a fighting pose and says, \"<i>If I have to I'll beat my children out of you!</b>\"");
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCTamani());
	CombatManager.victoryScene(CoCTamaniPCVictory);
	CombatManager.lossScene(CoCTamaniPCLoss);
	CombatManager.displayLocation("TAMANI");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//[Let Her (Or Combat Rape)]
//[let her]
internal function tamaniSexLetHer():void {
	showTamani();
	tamaniKnockUp();
	clearOutput();
	//[lost combat]
	if (inCombat()) {
		//Taurs
		if(pc.isTaur()) {
			if(pc.HP() <= 1) output("You stumble, legs weaving drunkenly as you try to keep your feet.  ");
			else output("You stumble, legs weaving drunkenly as [pc.cocks] ache and drool with need.  ");
			output("Tamani sidles up to you and pats your flank, cooing, \"<i>There there horsey, everything's going to be okay.  Momma Tamani's going to take really good care of you.</i>\"  Before you know it your [pc.gear] is on the ground and the goblin is underneath you, climbing up to your crotch.\n\n");
		}
		//Not taur
		else {
			if(pc.HP() <= 1) output("You collapse, unable to fight back any longer.  For her part, Tamani seems disappointed with the outcome, but approaches your prone form in spite of your sorry appearance.");
			else output("You tear off your clothes in a frenzy of lust and stagger towards Tamani, openly fondling your groin.   She smirks and pushes you hard, throwing you off balance and onto your back.");
			output("  She wiggles her " + tamaniChest() + ", and despite your efforts to control your body, ");
			if(pc.cockTotal() == 1) output("an erection emerges");
			else output("erections sprout up like weeds");
			output(".  She strips you down, giving you a smirk as she says, \"<i>Just lie there and I'll take what I need, babe.</i>\"\n\n");
		}
	}
	//Voluntary submission
	else {
		//Taur
		if(pc.isTaur()) {
			output("You meekly " + (pc.isNude() ? "" : "undress and ") + "ask Tamani how she would like to take you today.  She titters and slowly walks around you, taking her time, taking in your formidable bestial body and your [pc.cocksLight]. \"<i>All this, for little ol' me,</i>\" she breathes. She sounds more tantalized than daunted. \"<i>Stand still for me, horsie,</i>\" she commands. Unable to see her any more behind your flank, you do as she says. You feel a pair of tiny hands on your back thigh and then a small but dense weight climbing steadily towards your groin. You bite back laughter at the ticklish sensation.\n\n");
		}
		else {
			output("You meekly undress and ask Tamani how she would like to take you today.  She titters and gives your ");
			output(RandomInCollection("[pc.cock]", "bellybutton", "[pc.nipple]"));
			output(" a quick kiss before pushing hard against you, shoving you onto the ground and flashing a brilliant smile.\n\n"); 
			output("\"<i>Just lie there and take it " + pc.mf("stud","slut") + ",</i>\" she commands.\n\n");
		}
	}
	
	var x:int = pc.cockThatFits(tamani.vaginalCapacity());
	if(x == -1) x = pc.smallestCockIndex();
	
	//Taur-zilla
	if(pc.isTaur()) {
		output("Hidden entirely by your relatively vast form, you cannot see anything that Tamani is doing, only feel. Perhaps aware of this, Tamani seems determined to make sure that what you feel is a lot. A hand clutches onto your flank as you feel her lean into your groin and begin to slather every part of your [pc.cock " + x + "] that she can reach with saliva. The goblin lipstick has its traditional effect and before long your [pc.cock " + x + "] is straining, a hard trembling pleasure-center. You hear a teasing giggle from somewhere underneath you, and then you gasp as Tamani clambers onto your groin proper, hands clutching onto your tender underside, most of her weight supported by your bulging cock.\n\n");

		output("Such is your arousal you find you can support her easily, but the sensation makes you cringe, particularly as Tamani sets about her work in earnest. Hanging onto your stomach she slathers your head with attention, her tingling lips and wet tongue all over your tip until you can barely stand it, beading pre-cum into her hungry mouth.\n\n");
		
		//If <18 Inches 
		if(pc.cockThatFits(tamani.vaginalCapacity()) != -1) {
			output("Before you can get too far she stops and agonizingly shifts her attention; you feel her transfer her weight to her hands, and then the rough but soft bottoms of her feet work their way down to the other end of your [pc.cock " + x + "], pressing against your inner thighs. The wet velvet sensation of her snatch envelopes your head and then slowly works its way down your shaft. Before she can bottom out, Tamani stops, teasingly and slowly withdraws until once again your head is pressed against her sopping entrance. She begins to work her thighs, smearing herself against the end of your straining cock with increasing urgency until she squeals in orgasm, slathering her juices onto your tip. Then, with a sigh and a snicker and again with agonising slowness, she works herself down onto your [pc.cock " + x + "].");
			pc.cockChange();
			//No balls: 
			if(pc.balls == 0) output(" You find yourself wondering vaguely where a goblin learns these kinds of gymnastics.\n\n");
			else output(" You find yourself wondering vaguely where a goblin learns these kinds of gymnastics, before the goblin in question drives all thoughts out of your head by mashing her soft soles into your [pc.balls].\n\n");

			output("Tamani has her way with you like this for what seems like hours, squealing as she gets off over and over until your underside is drenched in her juices, but drawing away every time you get close to your own release, playing you like the world's most sensitive fiddle until your human half is drenched with sweat. You stamp your back hooves in deep agitation and fill the forest with bellowing shouts. There is nothing you can do; attached securely to your nether regions as she is, you couldn't reach her or otherwise knock her off even if you wanted to. She is evidently enjoying every minute it, laughing cruelly every time she manages to draw a scream from you, spurring her on to invent some new way of agonizing your poor cock. There is something about this situation which is driving you wild; that you can't do anything about what a creature many times smaller than you is doing to you, and that you willingly allowed it to happen, is a shamefully powerful sensation.\n\n", false);
			output("\"<i>Go on then,</i>\" she breathes eventually. \"<i>I guess you've had enough. Cum for Mistress Tamani, " + pc.mf("stud","slut") + ". Fill me to the brim.</i>\" With this she finally works herself all the way to the bottom of your shaft, and with surprising strength grips your stomach and begins to pound her plump behind against your inner thighs with increasing force.\n\n");

			output("You need no further invitation, and with a ragged, blissful sigh you orgasm hard enough for stars to swim at the edge of your vision. Tamani holds onto you with all four of her limbs and milks you expertly as you spurt load after load into her hot, needy twat. She doesn't stop grinding you until you can feel spooge dripping out of her and hear it spatter lightly on the ground.\n\n");

			output("When you have finished, you feel an intense amount of relief as Tamani finally lets go of your underside and drops to the floor. She happily waddles around to face you, her cunt dripping with your seed. \"<i>Who knew that riding a horsie could be so much fun! We're going to have to do that again, stud. Next time I might make it a gallop instead of a canter. Won't that be nice? Until next time, big " + pc.mf("boy","girl") + ".</i>\" She swaggers off, leaving you to wonder if you'll ever be in a fit enough state to let her near your cock again, and where the nearest whereabouts of a gallon of water is.\n\n");
		}
		//If >18 Inches 
		else {
			output("Before you can get too far she stops and agonizingly shifts her attention; you feel her rough but soft bottoms of her feet work their way down to the other end of your [pc.cock " + x + "]. Hanging onto the base of your member she begins to rub her plump, diminutive form along the bottom of it, her tits and thighs caressing your length. ");
			if(pc.balls == 0) output("You find yourself wondering vaguely where a goblin learns these kinds of gymnastics.\n\n");
			else output("You find yourself wondering vaguely where a goblin learns these kinds of gymnastics, before the goblin in question drives all thoughts out of your head by beginning to mash her soft soles into your [pc.balls].\n\n");

			output("Tamani has her way with you like this for what seems like hours, crawling up and down your massive cock");
			if(pc.balls > 0) output(" and [pc.balls]");
			output(", sucking, tonguing, fondling, and foot rubbing you with horrible accuracy, slapping against you and squealing as she gets off over and over until your underside is drenched in her juices, but drawing away every time you get close to your own release, playing you like the world's most sensitive fiddle until your human half is drenched with sweat. You stamp your back hooves in deep agitation and fill the forest with bellowing shouts. There is nothing you can do; attached securely to your nether regions as she is, you couldn't reach her or otherwise knock her off even if you wanted to. She is evidently enjoying every minute it, laughing cruelly every time she manages to draw a scream from you, spurring her on to invent some new way of agonizing your poor cock. There is something about this situation which is driving you wild; that you can't do anything about what a creature many times smaller than you is doing to you, and that you willingly allowed it to happen, is a shamefully powerful sensation.\n\n");

			output("\"<i>Go on then,</i>\" she breathes eventually. \"<i>I guess you've had enough. Cum for Mistress Tamani, " + pc.mf("stud","slut") + ". Cover me from head to toe.</i>\" As she says this, she walks her hands down your belly, positions herself directly over your head, uses her own lubrication to rub her feet furiously down your [pc.cock " + x + "] and then, with one last evil giggle, sticks her tongue directly into your urethra.\n\n");

			//Low cum: 
			if(pc.cumQ() < 1200) {
				output("With a ragged sigh, you reach your peak. Your first blast of jizz goes straight into Tamani's mouth, but you feel the goblin nimbly and hastily changing her position so that the very tip of your [pc.cock " + x + "] can feel her moist snatch. Being teased for so long makes the sensation incredible, and it feels like entire minutes go by whilst you stand there, sweat dripping off you as you cum over and over again until your cock is doing nothing but flexing mindlessly.\n\n");

				output("When you have finished, you feel an intense feeling of relief as Tamani finally lets go of your underside and drops to the floor. She happily paws off the jizz coating her face and attempts to stuff more into her dripping cunt as she waddles around to face you. \"<i>Who knew that riding a horsie could be so much fun! We're going to have to do that again, stud. Next time I might make it a gallop instead of a canter. Won't that be nice? Until next time, big " + pc.mf("boy","girl") + ".</i>\" She swaggers off, leaving you to wonder if you'll ever be in a fit enough state to let her near your cock again, and where the nearest whereabouts of a gallon of water is.\n\n");
			}
			//High cum: 
			else {
				output("With a bellowing roar, you cum with mind blowing force. Your churning balls blast out a river of gooey fluid, the first glorious arc of which flies straight past your humanoid front and paints the tree in front of you. Totally insensate, you can do nothing for entire minutes but stand there and cum, over and over again, sweat dripping off your frame, until the entire area underneath you is covered with your spooge.\n\n");
				
				output("When you finally come to your senses, you wearily but with intense satisfaction clop around to take in the lake of jizz you have created. ");
				if(pc.balls > 0) output("Your [pc.balls] ache and you feel very thirsty indeed.");
				else output("You feel very thirsty indeed.");
				output(" It's only when you manage to drag your mind away from your own privations that you suddenly wonder where Tamani went. She isn't still attached to you, is she? It is then that a small lump in the center of the vast puddle in front of you stands up and begins to happily wipe herself down, taking care to stuff as much of the seed plastering her into herself as she can.\n\n");
				
				output("\"<i>Wheeeeeeeee,</i>\" she says, with a grin which almost splits her face in half. \"<i>Who knew that riding a horsie could be so much fun! We're going to have to do that again, stud. Next time I might make it a gallop instead of a canter. Won't that be nice? Until next time, big  " + pc.mf("boy","girl") + ".</i>\" She swaggers off, leaving you to wonder if you'll ever be in a fit enough state to let her near your cock again, and where the nearest whereabouts of a gallon of water is.\n\n");
			}
		}
		//chars["COC.TAMANI"].loadInCunt(pc);
		pc.orgasm();
		output("After a little while you redress, but the scent of horny goblin stays with you for hours.");
		//Combat end: 
		if (inCombat()) {
			output("  After the stress and strain of a lost fight and the stress of having your seed so expertly stolen, you lie down on your flank and go to sleep.");
			processTime(25 + rand(10));
			pc.orgasm();
				output("\n\n");
			CombatManager.genericLoss();
		}
		//(Noncombat end: 
		else {
			processTime(10 + rand(10));
			pc.lust(10);
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
	}
	//Not-taurs
	else {
		output("She gets down on all fours, crawling up your legs until her gloss-covered lips reach your [pc.cocksLight].   Warm wetness slides along your length as the gobbo-slut gets you slick and wet with her saliva.   It has quite the effect on you, turning your [pc.cock " + x + "] into a hard trembling pleasure-center.  You sigh, enjoying the attention but more than ready to release your pent-up sexual need into the willing girl.\n\n");
		
		//(fits)
		if(pc.cockThatFits(tamani.vaginalCapacity()) != -1) {
			output("Tamani turns about, dragging her wet gash across you and giving you a nice view of her plump butt-cheeks.  The soft skin of her palms squeezes around you as she lifts you up, positioning your [pc.cock " + x + "] against her womanhood.   She grinds against your [pc.cockHead " + x + "], her folds slowly parting to take you.  Slowly, inch after inch of dickflesh sinks into her amazingly elastic yet tight pussy.  ");
			if(pc.cocks[x].cLength() >= 12) output("Her body visibly stretches around you, and you silently thank whatever gods or demons adapted goblins to be able to fulfill this role.  ");
			output("Moaning like a whore, she easily slips the rest of the way down, bottoming out her sopping-wet fuck-tunnel.");
			pc.cockChange();
			output("\n\n");
			output("You gasp in pain and surprise as Tamani pinches and tugs ");
			if(pc.totalNipples() == 2) output("both");
			else output("all");
			output(" of your [pc.nipples].  She eases up her grip a bit when she sees how bad it hurts, but she does not release them.  The noisy squelching of her cunt fucking you draws your attention back to your groin.  Your body begins thrusting up to meet her, finally understanding it's on the receiving end of a passionate screw.  ");
			if(pc.biggestTitSize() >= 2) output("Your [pc.chestFull] bounce and jiggle obscenely as the goblin twists and pulls, abusing your nipples.");
			else output("Your " + pc.nippleDescript(0) + "s burn with pain as the goblin twists and pulls on them, abusing them.  Pleasure and pain mix together, overwhelming you, reducing your world to little more than the slap of genital against genital and the painful torture happening to your chest.\n\n");
			output("Tamani plays your body like a fiddle, keeping you near the edge as she noisily orgasms over your shaft again and again.  You can tell she's starting to tire, so she gives you a kind look and begins to pick up the tempo.   She whispers softly, \"<i>Go ahead, cream my honeypot until I can barely walk.</i>\"\n\n");
			output("That's all the encouragement you need.  ");
			if(pc.balls > 0) output("Your [pc.balls] twitch powerfully, venting their contents, releasing a jet of hot cum into the goblin.");
			else output("Your body's internal muscles twitch, pushing a jet of hot cum into the goblin.");
			output("  Tamani wriggles happily, giving your nipples one last tweak before releasing them to play with her own.  Rope after rope of your goopey jism paints the inside of her canal, and the happy slut only begs for more the whole time.");
			if(pc.cumQ() >= 250) output("  After a while you can feel the pressure building inside her, starting to give her a bit of a belly.  Tamani rubs it and begs, \"<i>More!</i>\"", false);
			if(pc.cumQ() >= 500) output("  Your body fulfills her requests and more, stuffing her until she's positively pregnant and your spunk is squirting from her entrance with each wave of sticky spooge.");
			else output("  Sadly, you only manage a few more spurts before your orgasm ends.");
			output("\n\nA sudden draft of cold air blows across your suddenly released member, making you shiver.   You look over at Tamani, watching your seed run down her thighs as she primps her hair and does a quick touch-up of her make-up.  She finishes up and blows you a kiss, bidding you farewell, \"<i>I'll be back for more if this one doesn't take");
			if(pc.cumQ() < 250)output(".  I really enjoy our fucks " + pc.mf("stud","hun") + ", and I can't wait to 'bump' into you again.");
			else {
				output(".  You make sure and let your ");
				if(pc.balls > 0) output("[pc.balls] fill back up with cum, ok?");
				else output("[pc.cock " + x + "] fills back up with cum, ok?");
			}
			output("</i>\"\n\n");
			//Combat end: 
			if (inCombat()) {
				output("You black out, exhausted from the ordeal.");
				processTime(25 + rand(10));
				pc.orgasm();
				//chars["COC.TAMANI"].loadInCunt(pc);
				output("\n\n");
				CombatManager.genericLoss();
			}
			//(Noncombat end: 
			else {
				output("You lie there, recovering from the intense sex.  After a little while you manage to get up and redress, but the scent of horny goblin stays with you for hours.", false);
				processTime(10 + rand(10));
				pc.orgasm();
				//chars["COC.TAMANI"].loadInCunt(pc);
				pc.lust(10);
				addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			}
		}
		//(Doesnt fit)
		else {
			output("Tamani turns about, dragging her wet gash across you and giving you a nice view of her plump butt-cheeks.  She looks over her shoulder and sucks on one of her lacquered fingernails, looking equal parts mischievous and sexy.   You rock your hips under her until she gives your ");
			if(pc.balls > 0) output("[pc.balls]");
			else output("[pc.cock " + x + "]");
			output(" a rough slap.  Whimpering, you still your rebellious hips and allow her to play you like the world's most sensitive fiddle.  Tamani pulls your [pc.cockHead " + x + "] up and rocks herself against it, openly moaning as you dribble pre into her sopping gash.\n\n");
			output("\"<i>Oooh, you're too big for little ol' me,</i>\" moans the goblin, easing back a bit, \"<i>but I have something that might make you cum just as hard.   I'll just make sure to catch all your cum with my cunny!</i>\"    She pulls out a hot-pink dildo and gives it a lick.  You watch in horror as a drop of thick fluid leaks from the tip.  No doubt Tamani intends for you to take take the entire thing in one way or another.\n\n");
			output("You pout, protesting meekly as she ");
			if(pc.balls > 0) output("lifts up your [pc.balls]");
			else output("leans forwards, looking between your legs");
			output(", and places the dildo's leaking tip against your [pc.vagOrAss].  You feel it stretching you out, reacting with your body's own fluids to swell up inside you like a pervert's balloon as Tamani pushes it further and further inside you.");
			if(pc.hasVagina()) {
				output("  ");
				pc.cuntChange(0, Math.min(pc.vaginalCapacity(), 100) * .95, true);
				output("Your walls squeeze tightly around it in an unconscious milking motion as your body reacts to it as if it were a real dick.");
			}
			else {
				pc.buttChange(Math.min(pc.analCapacity(), 100) * .95, true);
				output("Your body clamps down around it, resisting the strange intrusion as it swells up to fill you, pressing tightly against your prostate.");
			}
			output("  A burning heat radiates through your body, making your [pc.nipples] tingle and grow ever more sensitive.\n\n");
			output("Tamani rocks back and forth, sliding herself against your [pc.cock " + x + "], humping it lewdly as your veins rub her hard little nub of a clit.  She pants, making sure to keep giving you sultry looks over her shoulder, licking her glossy lips as she brutally teases you.  You can feel her getting off over and over as she grinds, sliding faster and faster on your shaft.   For your part, your [pc.cock " + x + "] begins making a puddle of pre-cum on your belly as the dildo's drug-like cum affects you, making you feel horny and hot.\n\n");
			output("The kinky goblin dominatrix on your [pc.cock " + x + "] leans even further forwards, angling the dildo in your [pc.vagOrAss] upwards to squeeze your ");
			if(pc.hasVagina()) output("cock's base ");
			else output("prostate ");
			output(" with delicious intensity.  You quiver underneath her, panting and moaning, totally subservient to the tiny girl giving your body the sexual workout of a life-time.  She slides back, her cunt squishing back and forth against your prick-head, driving you wild.  She coos, \"<i>Go ahead and cum stud,</i>\" while squeezing your ");
			if(pc.balls > 0) output("balls");
			else output("crotch");
			output(", \"<i>let out all that hot sticky spunk for Mistress Tamani.</i>\"\n\n");
			output("Your body immediately and happily complies, squirting a jet of thick white jism onto the goblin's jiggling ass-cheeks.  She slides down, aligning her cunt with your swollen cock-tip, taking the next squirt directly between her lips as she rubs against you.  Tamani slaps the dildo in your [pc.vagOrAss] gently, squeezing out an incredibly thick gout of semen as she stretches you wider.  ");
			if(pc.cumQ() >= 250) {
				output("You cum harder and harder, pushing her back a bit and splattering her belly with white cream.  She moans, rubbing it into her skin and twat");
				if(pc.cumQ() >= 500) output(" as you keep cumming, splattering her tits and face, soaking the little goblin slut");
				output(".  ");
			}
			output("The dildo slips out of your abused [pc.vagOrAss] forgotten in the heat of your lovemaking, leaking pink goo.\n\n");
			output("Tamani eases up off of you, dripping a mixture of sexual fluids and stretching as if she had just completed a long workout.  The slutty goblin winks at you and waves, \"<i>Thanks for the cum.  Be sure and take some time to refill.  I wanna be soaked again next time!</i>\"\n\n");
			
			//Combat end: 
			if (inCombat()) {
				output("You black out, exhausted from the ordeal.");
				processTime(25 + rand(10));
				pc.orgasm();
				//chars["COC.TAMANI"].loadInCunt(pc);
				output("\n\n");
				CombatManager.genericLoss();
			}
			//(Noncombat end: 
			else {
				output("You lie there, recovering from the intense sex.  After a little while you manage to get up and redress, but the scent of horny goblin stays with you for hours.");
				processTime(10 + rand(10));
				pc.orgasm();
				//chars["COC.TAMANI"].loadInCunt(pc);
				pc.lust(10);
				addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			}
		}
	}
}

//[NORMAL COMBAT – LOSS TEXT]
internal function tamaniSexLost():void {
	showTamani();
	tamaniKnockUp();
	clearOutput();
	output("Tamani gives you a knowing smile as you ");
	if(pc.HP() <= 1) output("lie there, unable to fight back.  ");
	else output("touch yourself, giving in to the tiny goblin's desire to breed.  ");
	output("She advances, her bare feet padding across the soil as she rummages in a faded leather pouch for something.  Her eyes light up as she finds whatever it is she was looking for.  In her hand is a ribbed silver ring, covered on every surface with numerous carved runes.  You whimper and back up, knowing she intends to fit it over your [pc.cock], but Tamani only 'tsks' and shakes her head.\n\n");
	output("\"<i>You were such a naughty boy, teasing me with that juicy dick and then pretending like you didn't want this.  I'll have to punish you for being bad, that's all there is to it,</i>\" she explains, pushing your hands away and fitting the ring around your [pc.cockHead].  ");
	if(pc.cocks[0].thickness() >= 5) output("Impossibly, despite your titanic girth, the ring somehow expands to squeeze onto you, though it's painfully tight.\n\n");
	else output("Somehow the ring fits onto you perfectly, as if it was made exactly for your [pc.cock], though it remains painfully tight.\n\n");
	output("\"<i>Don't fret, " + pc.mf("stud","hun") + ".  I'll still let you get off after I feel you've learned your lesson,</i>\" she offers, pulling up a large empty milk-bottle in her other hand.  \"<i>Of course I'll need to collect some for myself,</i>\" she says, \"<i>Since you played hard to get, you'll have to miss out on the feel of my juicy snatch!</i>\"  At the mere mention your eyes lock between her legs, zeroing in on her puffy engorged labia.  Why didn't you just submit right away and let her have your cum?\n\n");
	output("She forces the ring down your entire length, not stopping until it bottoms out against the flesh of your groin.  In response, the obviously magical ring cinches even tighter and begins a slow vibration, providing pleasure but denying you the ability to orgasm.  Tamani wraps a single hand around your tight tender shaft, squeezing and pulling, using discomfort to guide you up onto your hands and knees.  She eases up on the pressure, allowing you a bit of pleasure once she has you where she wants you.  You look down between your arms ");
	if(pc.biggestTitSize() >= 6) output("but can't manage to see your bloated prick past the wall of titflesh.\n\n");
	else output("at your bloated prick, looking almost overinflated from all the blood that tight ring has forced into it.\n\n");
	output("<b>*SMACK*</b>  Tamani's hand cracks against your [pc.butt] making you lurch and bite back a cry of pain.   \"<i>Bad boys get punished!</i>\" she yells as she brings her hand down again, slapping your other cheek.  You're sure there must be two tiny red hand-prints forming already. The kinetic impacts of her blows vibrate through your hips, traveling into your sensitive [pc.cock] and working with the magic-ring to spread equal measures of pain and pleasure through its length.\n\n");
	output("The spanking doesn't let up until your ass is cherry-red and tender.  Tamani gently pats it, making you wince in displeasure, and giggles, pleased with herself, \"<i>Hehe, do you think I've punished you enough?  I'm sure you do, but what I really want to know is – have you learned your lesson?  I need to make sure you'll be a good boy and jump right into my honeypot next time I ask.  I hate wasting time fighting when we could be making love and breeding.</i>\"\n\n");
	output("Tamani pours oil over your abused backside, letting it soak in and start to numb the pain.  She pours quite a different type of oil into her hands and starts massaging you, letting the alchemical mixture make your skin tingle and enhance the sensation of pleasure while numbing away the pain of your cock being kept so... tightly bound.  Your arms and [pc.legs] tremble from supporting yourself at such an awkward angle, struggling not to relax at the sudden influx of pleasure.  The feelings bring you to the edge, and you feel your body's internal muscles clenching, but the tight vibrating ring blocks your cum and your orgasm, leaving you backed up and desperate.\n\n");
	output("Your goblin mistress ");
	if(pc.balls > 0) output("cups your [pc.balls] tightly");
	else output("caresses you around the ring");
	output(" and asks, \"<i>So are you sorry for making me wait for my cream " + pc.mf("stud","slut") + "?  If you are, just say <b>I'm sorry mistress Tamani, please milk my cock whenever you want</b> and then beg me to cum.</i>\"\n\n");
	output("You NEED to cum.  Her hands... they keep stroking you, and each time your body begins to orgasm it's held back, trapped within you painfully.  ");
	if(pc.balls > 0) output("Your balls are getting VERY swollen and tender.");
	else output("Your body aches inside, feeling bloated and ready to pop.");
	if(pc.slut() < 50) output("  You have no choice, you'll say what she wants you to say.\n\n");
	else output("  Being denied like this was kind of fun, but you REALLY need to get off now, so you'll say what she wants you to say.\n\n");
	
	output("\"<i>Mistress Tamani, I'm so sorry!  Milk my cock dry any time you want!  Puhleeeeeaaaaase let me cum!  Please, I'm so fucking horny, I'll do what you want, just give me release!</i>\" you beg, ");
	if(pc.slut() > 50) output("blushing hotly and doing your best to look like a submissive toy.\n\n");
	else output("blushing in shame and embarrassment, but meaning every word.\n\n");
	
	output("She takes the empty bottle and presses it against your [pc.cockHead], caressing your length with loving affection with her free hand as she replies, \"<i>Not exactly what I told you to say, but it DID sound heartfelt.  Let's let out all that backed up cum now, hrmmm?</i>\"   Her free hand touches the ring and you feel the pressure relax a bit - still tight enough to keep you beyond-hard, but loose enough for you to cum.  She strokes and squeezes as your blocked orgasms slowly flow into the bottle, smiling as it thickens and begins spurting as pleasure overtakes you.  You hold yourself on all fours, red-assed and submissive as your goblin mistress milks you of the last of your cum.");
	if (pc.cumQ() >= 250) {
		output("  The bottle quickly overflows, but Tamani happily sets it aside and slides her own cunt under you, letting you pump the rest of your seed into her fertile womb.");
		pc.cockChange();
	}
	if(pc.cumQ() >= 500) output("  She coos happily when you still manage to pump enough jism into her to bloat her belly, but even with your impressive fertility, the orgasm has to end.");
	output("\n\n");
	
	output("Tamani removes the ring once you have finished.  She seals the bottle and places it in her pouch as you drop to the ground, exhausted.  All you can do is watch as she walks away, her ass swaying confidently from side to side.  Your last thought before you pass out is how much easier it would've been to just fuck her.");
	//chars["COC.TAMANI"].loadInCunt(pc);
	pc.orgasm();
	//dynStats("lib", .5, "sen", -1, "cor", .5);
	pc.libido(0.5);
	pc.cor(0.5);
	processTime(25 + rand(10));
	output("\n\n");
	CombatManager.genericLoss();
}
	
//[NORMAL COMBAT – VICTORY RAEEP]
//Shove her face in the mud and fuck her
internal function tamaniSexWon():void {
	flags["COC.TAMANI_DEFEATS"] = 0;
	showTamani();
	tamaniKnockUp();
	var x:Number = pc.cockThatFits(tamani.vaginalCapacity());
	var y:Number = pc.cockThatFits2(tamani.analCapacity());
	clearOutput();
	
	if(x != -1) {
		output("You grab hold of the insensate goblin by her pink-dyed hair and shove her into the mud, irritated with her constant demands and rape attempts.  The horny slut doesn't even have the grace to be ashamed of her defeat.  She just lies in the mud, wiggling her exposed ass back and forth in the air, trying to tempt you with it.\n\n");
		output("It's too tempting of a target to resist.  You open your [pc.gear] and allow your [pc.cocksLight] to flop free.  You're already hard from the enticing display, and in a moment you're pressing against her lust-slicked pussy");
		if(y != -1) output(" and tight asshole");
		output(".  You don't allow her any say in the matter, pushing forward as you feel the small girl's flesh yield around ");
		if(y != -1) output("each of ");
		output("your girth");
		if(y != -1) output("s");
		output(".");
		pc.cockChange();
		output("  She squeals happily, clearly getting what she desires.  For a moment you feel disappointed in yourself, but the sensations of her tight hole");
		if(y != -1) output("s");
		output(" clenching and squeezing around you quickly washes it away.");
		pc.cockChange();
		output("\n\n");
		
		output("You rock back and forth methodically, treating Tamani like a tight cock-sleeve.  The goblin slut's hands rub her belly, not even attempting to pull her face out of the mud as she moans and giggles like a whore.  You keep working her cunt like a ");
		if(!pc.isHerm()) output("[pc.manWoman]");
		else output("herm");
		output(" possessed, sawing in and out with brutal efficiency, the wet squelches of the slut's juices driving you to piston back and forth with even greater force.  She gurgles happily, her ");
		if(y == -1) output("pussy squeezing tightly as she cums hard.\n\n");
		else output("holes squeezing tightly as she cums hard.\n\n"); 
	
		if(y != -1) {
			output("Each of your [pc.cocksLight] pulsates, spasming inside your goblin-flesh prison, spraying a bit of sticky goo into the happy slut.   You can hear her babbling, pleasure-drunk as she quivers around you, \"<i>Fuck yes! Cu-ah-ahm in me!  Fuck fuckfuckfucKFUCKYEAH!  Oooh, that's it, put me in the dirt and show me who's boss!</i>\"  The words seem to have the desired effect, helping you empty every ounce of cock-cream into the slut's tight holes.");
			if(pc.cumQ() >= 250) output("  She pants, turning her head in the mud to watch as her belly visibly inflates, stuffed totally full of [pc.cumNoun]. ");
			if(pc.cumQ() >= 500) output("  In no time at all a river of jism pours from her, pooling below as you overwhelm her body's capacity to store spunk.");
		}
		else {
			output("Your [pc.cocksLight] pulsates, spasming inside your goblin-flesh prison, spraying a bit of sticky goo into the happy slut.   You can hear her babbling, pleasure-drunk as she quivers around you, \"<i>Fuck yes! Cu-ah-ahm in me!  Fuck fuckfuckfucKFUCKYEAH!  Oooh, that's it, put me in the dirt and show me who's boss!</i>\"  The words seem to have the desired effect, helping you empty every ounce of cock-cream into the slut's tight hole.");
			if(pc.cumQ() >= 250) output("  She pants, turning her head in the mud to watch as her belly visibly inflates, stuffed totally full of [pc.cumNoun]. ");
			if(pc.cumQ() >= 500) output("  In no time at all a river of jism pours from her, pooling below as you overwhelm her body's capacity to store spunk.");
		}
		output("\n\nTamani winks, sucking on her finger as she staggers up.  She coos, \"<i>Mmmm, Tamani loves it when her " + pc.mf("sexy lover","stud") + " dominates her.  Do you think your ");
	}
	//Too big? Jerk off with feet and bukkake
	else {
		x = pc.biggestCockIndex();
		output("You throw Tamani on her back, too drunk on desire to care how it feels for the tiny slut.  There's no way she could ever take ");
		if(pc.totalCocks() > 1) output("any of your massive members");
		else output("your massive member");
		output(", so you grab her by the ankles and wrap her soft-soled feet about yourself.   You start jerking yourself off, using Tamani as a cute but expendable masturbation aid.  She chews a fingernail and massages her " + tamaniChest() + " as she watches you, doing her best to put on a show.  The little slut seems to like it.\n\n");
		output("Her feet start to grow slick with your sweat and pre-cum, sliding effortlessly along the length of your shaft as you continue to bring yourself towards orgasm.  You watch while Tamani dips her fingers into the slick folds of her hungry cunt, getting off on being used in such a perverse manner.  She coos, \"<i>How do my feet feel " + pc.mf("stud","slut") + "?  Are they soft and slick when they slide on your cock?  Are you going to cum for Tamani and paint her white?  You are.  You know you are.  Cum for Tamani.</i>\"\n\n");
		
		output("Oh gods, you are... it'd be so easy to just release all over her tight little body, soaking her in cum from head to toe.  You know she'd like it.  Hell, you'd like it, but you want to make her wait.   Your hands keep sliding and squeezing, jerking her now-slippery soles with faster and faster strokes.  Holding back is TOO hard!  You need to release – the little slut's words ring true as you squeeze tightly, feeling warmth building in your crotch as your body begins to climax.\n\n");
		
		output("Tamani licks her lips and pushes with her legs, assisting you as you milk yourself with her feet, squeezing out the first jet of hot goblin-treat.   It spatters over the green girl's forehead, running into her pink highlights.  She opens wide, craning up to catch the next blast of [pc.cum] in her dirty lipstick-coated mouth.   Swallowing like a pro, she leans up further, letting you coat her tits with [pc.cumNoun].");
		if(pc.cumQ() >= 250) output("  You continue working your [pc.cock " + x + "] with her supple feet, watching your dripping spooge froth and bubble as you continue to pump more onto the sassy wench.");
		if(pc.cumQ() >= 500) output("  She sputters, blowing some of the caked up semen off her face so she can breathe.  The slut gathers up the goopy mess as you continue to paint her, alternatively devouring it with her mouth and shoveling drippy handfuls into her eager cunt.");
		output("\n\n");
		
		output("Tamani winks, blinking the cum out of an eye as you finish up, releasing her seed-covered form.  She coos, \"<i>Mmmm, Tamani loves it when you dominate her, " + pc.mf("stud","sexy") + ".  Do you think your ");
	}
	
	if(pc.balls > 0) output("sexy balls have ");
	else output("sweet cock has ");
	output("any more cream to give to me?</i>\"\n\n");
	output("She doesn't give you a chance to answer as she wobbles off, jiggling pleasantly in all the right places, \"<i>Of course you do.  I'll be back for the rest later!</i>\"\n\n");
	
	//chars["COC.TAMANI"].loadInCunt(pc);
	processTime(30 + rand(10));
	pc.orgasm();
	if (inCombat()) CombatManager.genericVictory();
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//[REPEAT MALE PREGNANT ENCOUNTER]
private function tamaniPregnantEncounter():void {
	showTamani();
	clearOutput();
	output("Tamani strolls out from behind a boulder, and wow is she ever pregnant.  It doesn't diminish the look of lust in her eyes when she meets your gaze, but her hands do keep rubbing the outside of her belly, only pausing to squeeze drops of milk from her nipples.  Her leather straps seem to fit her even better than before, accentuating her expanding curves and looking fantastic on her pregnant form.\n\n");
	output("She parts her legs and rubs her lower lips while she begs you, \"<i>Please fuck me!   I'm so horny from the pregnancy and I can't wait to give you daughters so you can knock me up all over again!</i>\"");
	//[Fuck Her] [Refuse]
	clearMenu();
	addButton(0, "Fuck Her", tamaniPregnantFuck);
	addButton(1, "Refuse", tamaniPregnantRefusal);
}

//[Refuse]
private function tamaniPregnantRefusal():void {
	showTamani();
	clearOutput();
	output("She bursts into tears and waddles away crying.  You aren't sure if you should feel bad or not.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[FUCK HER PREGGERS – Consentual]
private function tamaniPregnantFuck():void {
	showTamani();
	clearOutput();
	output("Tamani's eyes light up and she pounces you, somehow managing to jump up and latch onto your chest despite the weight of her burgeoning pregnancy.  The two of you overbalance as her weight carries you to the ground, flat on your back.   Your [pc.ass] hurts a little from the impact but it's the last thing on your mind.  More important are the milk-dribbling twin mounds pressing tightly against your [pc.chest].\n\n");
	output("You grab her under the arms and lift her up, examining her milk-laden nipples.  They shine with moisture, practically begging to be sucked.  You nuzzle them, gently sucking one into your mouth and drinking down the nutritious beverage.  Tamani grinds her hips against one of your [pc.nipples] as she moans softly into your ear, practically cumming on you from the suckling alone.  You take a break when her milk-flow slows and take the other into your mouth, squeezing both her " + tamaniChest() + ", enjoying the enhanced fullness her pregnancy has brought.");
	//(Very large: 
	if (StatTracking.getStat("coc/pregnancy/tamani impregnated") > 6) output("  They're almost too big for you to handle; they probably make it hard for the poor girl to walk.");
	output("\n\n");
	
	output("Tired of the teasing, Tamani yanks her nipples free of your mouth and kisses you fiercely.  Her lips are hot, almost feverish, and taste of sweet cherries.  Fiery warmth races through your body, collecting at your groin as her tongue curls around yours.  She sucks on your lower lip before pulling back and giving you an all-too-knowing smile.  Your [pc.cock] is just getting harder and harder, so tight it almost hurts.  You whine softly as Tamani wraps her feet around it, stroking it with her bare soles as she pulls herself down.\n\n");

	output("Her pregnancy swollen belly and growing breasts rub along your shaft as she kisses and squeezes it.  You're so turned on it hurts, and you KNOW it's from whatever she put in her lipstick this time.  You beg her, \"<i>Please, fuck me, I'm so horny it hurts!</i>\"\n\n");
	
	//(Fits) – pregnant capacity is lowered by about 50%
	if(pc.cockVolume(0) <= tamani.vaginalCapacity() * 0.5) {
		output("Tamani pulls herself up to her feet and grabs your [pc.cock] with a two-handed grip, guiding it towards her dripping cunny.  She squats down, taking the entire length in a quick thrust.   She giggles and starts bouncing on you relentlessly, teasing her nipples and talking dirty to you the whole time, \"<i>Come on stud, fuck your pregnant goblin wife.   I want to walk around pregnant and dripping with your cum for the rest of the day.  If you really stuff me up I can bring it back and share with the rest of my family, what do you think about that?  Dozens of my hot little sisters and daughters stuffed with your babies?</i>\"\n\n");
		output("You cum with near-painful intensity.  Tamani is actually lifted up by the force of your ejaculation.  Cum squirts from her abused fuckhole as she slips back down, rubbing her belly with both hands and tittering girlishly.  The waves of seed you're putting out seem far beyond your normal ability, and you try to manage a glare at her, blaming her, but she just licks her lips and winks in between orgasmic moans.    Cum squirts from her, streaming down her thighs and puddling under your [pc.ass].  At last you finish, leaving her looking even more pregnant than before.  Your [pc.balls] ache from the explosive discharge, leaving you sore and exhausted.\n\n");
		
		output("For her part, Tamani staggers to her feet, letting you flop free as a river of your cum pours between her legs, soaking your lower body.  She staggers over to your face, pleasure-drunk, and leans down to give you another sloppy kiss.\n\n");
		
		output("\"<i>Thanks for the good fuck, " + pc.mf("stud","lover") + ",</i>\" she says, smiling cruelly as you find yourself getting hard again from her drug-laced kisses.  Tamani doesn't hang around to help though; she waddles off, cradling her belly and smiling.\n\n");
	}
	//(Doesn't Fit)
	else {
		output("\"<i>Sorry " + pc.mf("stud", "lover") + ", you're just too big and <b>hard</b> for me.   Don't worry, I'll help you unload everything straight into my sweet cunt,</i>\" she apologizes, ");
		if(pc.balls > 0) output("massaging your balls with her feet");
		else output("jacking the base of your [pc.cock] with her feet");
		output(" while her hands caress and tease you.   Tamani pulls herself downwards, pressing the " + pc.cockHead() + " partway up her drooling box.  She grinds hard against your cock-head, nearly driving you mad with pleasure.  She grabs her " + tamaniChest() + " and squeezes, splattering you with a thick coating of milk before returning to jacking you off with her feet and hands.\n\n");

		output("You cum with near-painful intensity.  Tamani is actually pushed back a bit by your first blast, getting splattered from her chest down as jizz tries to escape her suddenly fluid-filled cunt.  She lunges forwards, grinding her pregnancy-bloated body against your pole, using her arms and legs like tight cock-rings.  Her gash and hard little clit spread her fragrant wetness as she orgasms with you, feeling each wave of your spunk pass underneath her.   With no receptacle, you end up drenched in a puddle of the stuff.  While it does eventually end, your sore body is a clear indication that some drug in her lipstick probably helped you push out such a ludicrous volume.\n\n");

		output("Tamani grinds on you a bit longer before staggering up and stretching.  She pauses to get a narrow bottle and abruptly jams the end into your urethra.  With one practiced motion, she squeezes your [pc.cock] from bottom to top, squeezing the last of your spoo into the container.  She pops it free, corks it, and pockets it.  She pats her pockets and explains, \"<i>A few of the girls back home aren't pregnant, and I thought you might like to help contribute to the local slut population.  Don't worry though baby, I'll always own your cock.</i>\"\n\n");
		flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"]) + 3;

		output("Tamani comes over to you and gives you a sloppy goodbye kiss, sending an immediate surge of hardness and desire to your groin.  She looks back and giggles, then waddles off, patting her pouches and dripping with your spooge.");
	}
	pc.orgasm();
	processTime(20);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Birth Encounter]
private function tamaniPoopsOutBabies():void {
	showTamani();
	clearOutput();
	output("You hear orgiastic screams in the distance as you explore.  You turn to investigate, and as you go, they become even louder and higher pitched.  You crest a rise and find Tamani ");
	if (flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] > 0) output("with her daughters, "); //She always has at least two daughters if she has any
	output("laying against a scrubby tree with her legs spread wide and surrounded by a small puddle.  Her " + tamaniChest() + " heave with deep breaths as she pushes hard, stretching her cunt wide.  Her eyes roll back as a green form slips free, revealing a tiny goblin that immediately stands up on wobbly legs.  The little girl turns and latches onto her mother's bloated nipple as another child slips free.");
	if (flags["COC.TAMANI_PREGNANCY_COUNT"] > 2) {
		output("  Moments later a third appears");
		if (flags["COC.TAMANI_PREGNANCY_COUNT"] > 3) {
			output(", a fourth");
			if (flags["COC.TAMANI_PREGNANCY_COUNT"] == 5) {
				output(", and a fifth");
			}
			else output(", and more than you can count");
		}
		output(".");
	}
	output("\n\n");
	
	if (flags["COC.TAMANI_PREGNANCY_COUNT"] == 2) {
		output("The twins drink deeply, growing taller before your eyes as Tamani comes out of her pregnancy induced orgasms.");
	}
	else {
		output("The goblin children drink deeply, squabbling for a chance at suckling the nipples as their mother recovers from her birthing-induced orgasms.");
	}
	output("  She looks up at you and whispers breathily, \"<i>Come fuck me a little later, I'll give you even more beautiful little girls.  These " + num2Text(flags["COC.TAMANI_PREGNANCY_COUNT"]) + " will be fully grown in a week or two and out man-hunting, but none of them will please you like me, I promise.</i>\"\n\n");
	output("Tamani sighs and relaxes, enjoying the breastfeeding and waving you away.  You shrug and head back to camp, more than a little aroused.");
	applyDamage(new TypeCollection( { tease : 5 + pc.libido() / 10 + pc.cor() / 10 } ), tamani, pc);
	tamaniGivesBirth();
	processTime(40 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

internal function tamaniKnockUp():void {
	if (pc.virility() <= 0) return;
	if (flags["COC.INCUBATION_TAMANI"] != undefined) return; // already
	
	//Determine how many kids...
	flags["COC.TAMANI_PREGNANCY_COUNT"] = 2;
	var cum:Number = pc.cumQ() * pc.virility();
	if (cum >=  50 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 100 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 200 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 300 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 400 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 500 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 600 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 1000 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 5000 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	if (cum >= 10000 && rand(2) == 0) flags["COC.TAMANI_PREGNANCY_COUNT"]++;
	
	flags["COC.INCUBATION_TAMANI"] = timeAsStamp + 9 * 24 * 60; // Nine day long pregnancy
	trace("Tamani preg result: " + flags["COC.TAMANI_PREGNANCY_COUNT"]);
}

public function encounterTamani():void {
	if (pc.hasCock() && int(flags["COC.TAMANI_DAUGHTER_PREGGO_COUNTDOWN"]) == 0 && flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] >= 24) {
		encounterTamanisDaughters();
	}
	
	//Fems:
	if (!pc.hasCock()) {
		tamaniFemaleEncounter();
	}
	//Dudezillaz:
	else if (flags["COC.TAMANI_MET"] == undefined) {
			tamaniMaleFirstEncounter();
	}
	else {
		if (flags["COC.INCUBATION_TAMANI"] == undefined) tamaniMaleRepeatEncounter();
		else if (flags["COC.INCUBATION_TAMANI"] <= timeAsStamp + 24 * 60) tamaniPoopsOutBabies(); //She's close to giving birth so do it now
		else tamaniPregnantEncounter();
	}
}
//TAMANI HYPNO SHIT

//[GIVE IN TO TAMANI'S HYPNO SHENANIGANS]
public function getRapedByTamaniYouHypnoSlut():void {
	showTamani();
	clearOutput();
	//Find a dick that fits
	var primary:Number = pc.cockThatFits(tamani.vaginalCapacity());
	var secondary:Number = pc.cockThatFits2(tamani.analCapacity());
	var cocks:Number = pc.totalCocks();
	
	output("Tamani crooks her finger and you come running, already feeling yourself straining against your [pc.gear] for a chance to fuck your wife and mistress.  She giggles, \"<i>Ohhh, how sweet, you're so ready to do your duty.</i>\"\n\n");
	
	output("The goblin traces her fingers over the bulge in your [pc.gear] before reaching inside of it to give you a tender squeeze.  You sigh, happy to have earned such tender treatment from your lovely wife.  Automatically, your hands undo your [pc.gear], removing the troublesome garment so as not to interfere with your lovemaking.   Tamani gives you another squeeze and teases, \"<i>Oh baby, you're hooked on Tamani's pussy, aren't you?  I can tell, you're practically trembling.  Let Tamani help take care of that for you.</i>\"\n\n");
	
	output("She smirks and bends over, looking back up at you from between her legs.  She offers, \"<i>Go ahead and stick it in.  A horny " + pc.mf("boy","herm") + " like you needs to have that delicious cock inside a nice, tight wife like myself.</i>\"\n\n");
	//[FITS]
	if(primary >= 0) {
		output("Tamani is completely right.  You grab her ass, feeling your fingers sink in to her supple flesh as you pull her back towards your ");
		if(cocks > 0) output("main ");
		output("[pc.cock " + primary + "].  Her warmth spreads over your [pc.cockHead " + primary + "] slowly, making you twitch and drip inside her, lubricating her already dripping channel with even more slick fluids.  With a mighty heave you push inside her, feeling yourself penetrating deep inside her, directly into her fertile womb.");
		pc.cockChange();
		output("  Tamani rubs your [pc.legs] with her hands, giving you a massage as you bottom out against her, feeling her juices stain your ");
		if(pc.hasSheath(primary)) output("sheath");
		else output("crotch");
		output("\n\n");
		
		output("You wait a second, adjusting to the feeling of being completely contained by such a warm, wet hole before you slowly push her away.  The slick walls of her tunnel clench around you as you pull her back, massaging the parts of you still inside her.  ");
		if(secondary != -1) {
			output("She moans and pulls your [cock " + secondary + "] into her mouth, running her tongue around the tip and sliding her palm along the underside.");
		}
		else output("She moans and pants, babbling about how good you are to her the whole time.");
		output("  You don't stop until your [pc.cockHead " + primary + "] is the only thing inside her.\n\n");
		
		output("  The second thrust is even better than the first.  It's slippery, hot, and passionate, and the idea of slowing down or stopping for any reason is inconceivable.  Tamani pants with each thrust, pawing at her bouncing breasts, grabbing one by the nipple with a free hand and moaning loudly");
		if(cocks > 0) output(" around your [cock " + secondary + "]");
		output(". Her tiny form jiggles, ");
		if(pc.tallness > 55) output("lifting off the ground as you get into it, giving yourself over to her sex.");
		else output("nearly falling over as you give your body over to her sex.");
		output("  She visibly orgasms, shaking and trembling from head to toe as her pussy milks your [cock " + primary + "].  It only lasts a few seconds, though they feel like heaven, before her body goes nerveless.\n\n");
		
		output("Taking that as an opportunity, you pick up the pace, plunging yourself in and out of her with a renewed, almost vicious vigor.  The wet slaps of your juice-");
		if(pc.skinType == GLOBAL.SKIN_TYPE_FUR) output("matted");
		else output("slicked");
		output(" [pc.skinFurScales] impacting her ass fill the air.  You fuck your wife harder and faster with every stroke, knowing you won't last more than a few more thrusts before you're painting her womb white.  Your wife is too cummed out to care or respond, ");
		if(cocks == 1) output("her tongue hanging out as she pants nonsensical pleasure-noises.");
		else output("and her mouth is too full of [cock " + secondary + "] to do anything but gurgle out nonsensical pleasure-noises.");
		output("  Swelling wider inside the wet hole, your [cock " + primary + "] tingles and clenches, about to unload.\n\n");
		
		output("An intense orgasm rolls through you, making your body clench as your piston your [cock " + primary + "] forwards, burying it deeply inside the goblin-shaped cum-receptacle.  ");
		if(pc.hasKnot(primary)) output("Your knot balloons inside her, locking her in place");
		else if(pc.cocks[primary].cType == GLOBAL.TYPE_DEMONIC && pc.hasCockFlag(GLOBAL.FLAG_NUBBY, primary)) output("The corrupted nodules along your [cock " + primary + "] pulsate in rippling, wave-like motions, massaging the interior of Tamani's twat");
		else if(pc.cocks[primary].cType == GLOBAL.TYPE_TENTACLE && pc.hasCockFlag(GLOBAL.FLAG_FLARED, primary)) output("Your tentacle-cock's tip widens, becoming mushroom-like inside Tamani's womb");
		else if(pc.hasCockFlag(GLOBAL.FLAG_FLARED, primary)) output("Your flare widens, actually holding itself inside Tamani's womb");
		else output("Your sensitive [cockHead " + primary + "] swells slightly in time with the contractions of your orgasm");
		output(" as you begin to fill your wife's womb with seed.   The orgasm is intense");
		if(pc.cumQ() < 50) output(", but brief, and after a few moments of spasming pleasure, the flood of cum slows to a trickle.");
		else if(pc.cumQ() < 300) output(" and voluminous, forcing more and more seed into Tamani's uterus until she sloshes with each new squirt.  After a few long moments of spasming pleasure, the flood of cum slows to a trickle.");
		else {
			output(" and massive, squirting thick gouts of semen directly into Tamani's waiting womb until each new explosion of spunk makes her slosh.  She moans, her belly bloating slightly until she's unable to take any more.");
			if(pc.cumQ() < 1000) output("  Though your orgasm tapers off, the additional seed squirts from between her thighs, trickling down to a slow drip of viscous white goo.");
			else output("  Trapped inside her and cumming as hard as ever, you raise the pressure inside the goblin until your seed is washing out of her cunt around you, puddling on the ground.");
			if(pc.cumQ() >= 1000 && pc.cumQ() < 4000) output("  It does eventually end, but not until a sizable puddle has formed between the pair of you.");
			else output("  It lasts seemingly forever, and by the time you're done, the two of you are standing in a puddle inches deep.");
		}
		if(cocks > 1) {
			output("  During it all Tamani's throat works to swallow every drop");
			if(pc.cumQ() > 300) {
				output(", but before long she's failing, with cum leaking out from the corners of her mouth.");
				if(pc.cumQ() > 600) output("  A few seconds later she pulls back coughing, and the perky goblin takes the rest of your load in her face.");
			}
			else output(".");
		}
		output("\n\n");
		
		output("Joined at the hips, the two of you manage to stay upright, each leaning into the other");
		if(pc.tallness > 55) output(" in spite of the height differential");
		output(".  Tamani regains her senses and pushes you back, waddling slightly after the intense fuck.   White jism and clear feminine fluids drool down her thighs, and your mistress couldn't be happier.  She pets your still-dripping [cock " + primary + "] affectionately as she says, \"<i>You're such a wonderful husband.  I can't wait to see how you get along with your new daughters!</i>\"\n\n");
		
		output("A surge of pride spreads through you at her praise, and you lean down to give your wife a long french kiss before heading back to camp.  On the way back your head slowly clears, and you wonder what came over you back there?!");
	}
	//[DOESNT FIT]
	else {
		primary = pc.biggestCockIndex();
		output("Tamani is completely right.  You grab her ass, feeling your fingers sink in to her supple flesh as you pull her back towards your ");
		if(cocks > 1) output("main ");
		output("[pc.cock " + primary + "].  Her warmth spreads over the [pc.cockHead " + primary + "] of your [pc.cock " + primary + "], but will go no further.  You tug harder on her bouncing backside, but you're simply too large to fit inside your wife's beautiful pussy.  She turns around and places a small hand ");
		if(pc.biggestTitSize() < 1) output("on your chest ");
		else output("between your [pc.breasts] ");
		output(" and commands, \"<i>Stop, you're just too big of a man for Tamani to do it the old fashioned way.</i>\"\n\n");
		
		output("Disgruntled but obedient, you stop your vaginal assault and release your wife.  It seems she has another way for your aching [pc.cock " + primary + "] to perform its duties anyway.  Tamani turns around and pulls out some clear tubing, along with a floppy, flexible sheath while she explains, \"<i>I'll just have to get you off and let you pump all your babies into me with this!</i>\"\n\n");
		
		output("Her small, dextrous fingers wrap the upper half of your ");
		if(cocks > 1) output("primary ");
		output("[pc.cock " + primary + "] inside the sheath, constricting it inside the tight, transparent material.  You sigh while you endure the treatment, disappointed you won't get to feel her clenching about you as you pour sperm into her fertile womb. She finishes up, slowly pushing the tube up her gorgeous, feminine hole until you're certain it'll be depositing your precious cargo into her deepest recesses. Tamani claps her hands together excitedly, \"<i>I haven't had a man big enough to use this with until you.  Oh husband, you're going to love this, just lie back for Tamani, okay?</i>\"\n\n");
		
		output("You do as you are told, like a good husband, and Tamani stays close, bound to you by a flexible, artificial umbilical.  She sits next to you, propping her feet up onto your [pc.cock " + primary + "].   The goblin doesn't have any shoes on her green-tinted feet, and in spite of the rough living conditions, they're softer than her hands, and nearly as dextrous.  You look over at her, questioningly at first, though it shifts to confused happiness as she begins stroking her left foot up and down your length.  Your wife shifts her right leg underneath you, and curls her toes around to interlock them with her left.\n\n");
		
		output("With both her feet locked together, wrapped around most of your sensitive [pc.cockNoun " + primary + "] and sliding along it, your petite wife begins giving you the foot-job of a lifetime.  The awkward position and intense desire make the both of you break out in a sweat, and before long her slippery feet are lubricated enough for her to pick up the tempo.  You rock against her soles, gazing lovingly into her eyes as she fondles her clit and gives you a perverted wink.  Tamani exclaims, \"<i>Oooh, I can feel you twitching under my toes!  Does Tamani's little feet feel good on her ");
		if(pc.tallness > 60) output("big ", false);
		output(pc.mf("strong man's","sexy lover's") + " [pc.cockNoun " + primary + "]?</i>\"\n\n");
		
		output("You assure her that they do like what she is doing – very much so – and ");
		if(cor() < 33) output("beg");
		else if(cor() < 66) output("ask");
		else output("command");
		output(" her not to stop.  Tamani starts to giggle, but bursts into a moan as her fingers slide along her easily visible clit. She pants, \"<i>Hurry up and come for Tamani baby, I wanna feel you pumping your cum inside me!</i>\"\n\n");
		
		output("Obedient until the end, you obey your tiny mistress and reach your climax.  You gasp out loud, twitching between her feet as your cum slowly boils out from your body.  Tamani watches in fascination as your urethra bulges out, actually shifting the position of her feet to make room for your jism.  White goop rockets out of your urethra, pumping through the tube and into your wife's waiting gash.  She squeals and dribbles clear fluid underneath the tube, actually getting off from the feeling of being impregnated.");
		if(pc.cumQ() > 250) output("  In no time, you've filled her to capacity, and white mixes in with the clear sexual fluids that are dripping from the goblin's cunt.");
		if(pc.cumQ() > 700) output("  A few more blasts visibly bloat her belly, and Tamani pulls her hands away from her pussy to stroke the slowly rounding dome on her abdomen.");
		if(pc.cumQ() > 1500) {
			output("  You just keep cumming, forcing the spooge to squirt out around the tube, puddling on the ground");
			if(pc.cumQ() > 3000) output(", and by the time you finish, both of you are in a thick puddle of spunk");
			output(".");
		}
		if(cocks > 1) {
			if(cocks == 2) output("  Your other [pc.cock " + pc.biggestCockIndex2() + "]");
			else output("  Each of your other [pc.cocks]", false);
			output(" splatters its own orgasmic juice everywhere, making a thorough mess of things, but neither of you seem to mind.");
		}
		output("\n\n");
	
		output("Tamani smiles as she pulls the tube out and stands up.  White jism and clear feminine fluids drool down her thighs, and your mistress couldn't be happier.  She peels her device off your still-dripping [pc.cock " + primary + "], pats it affectionately, and says, \"<i>You're such a wonderful husband.  I can't wait to see how you get along with your new daughters!</i>\"\n\n");
		
		output("A surge of pride spreads through you at her praise, and you get up to give your wife a long french kiss before heading back to camp.  On the way back your head slowly clears, and you wonder what came over you back there?!");
	}

	tamaniKnockUp()
	//chars["COC.TAMANI"].loadInCunt(pc);
	processTime(25 + rand(10));
	pc.orgasm();
	pc.slowStatGain("i", -0.5);
	//dynStats("int", -.5, "sen", -1);
		
	if (inCombat()) {
		//chars["COC.TAMANI"].loadInCunt(pc);
		output("\n\n");
		CombatManager.genericLoss();
	}
	else {
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	
}

public function tamaniAnalShits():void {
	flags["COC.TAMANI_DEFEATS"] = 0;
	showTamani();
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	clearOutput();
	output("You grab hold of the insensate goblin by her pink-dyed hair and shove her into the mud, irritated with her constant demands and rape attempts.  The horny slut doesn't even have the grace to be ashamed of her defeat.  She just lies in the mud, wiggling her exposed ass back and forth in the air, trying to tempt you with it.\n\n");

	output("It's too tempting of a target to resist.  You open your [pc.gear] and allow your prick to flop free.  You're already hard from the enticing display, and unable to resist any longer, you grab her hips and pull her plump ass up towards you.  She gasps as she's dragged along the ground and tries to crane her neck to face you.  \"<i>H-hey stud,</i>\" Tamani stammers, suddenly nervous, \"<i>you aren't thinking of-</i>\" You pull her close and press the tip of your [pc.cock " + x + "] against her tight asshole.  \"<i>HEY!</i>\" she shouts back, glaring threateningly at you.  \"<i>You better not, I need that baby batter in my womb, not my ass!</i>\"\n\n");

	output("Your menacing grin betrays no pity for the goblin, though.  You slowly press into her, her face contorting in pain as the tightness of her ass envelops you.  She grunts, hands clenched into tight fists as you bottom out in her.");
	pc.cockChange();
	output("  \"<i>Please,</i>\" she begs, her eyes watering in pain and frustration, \"<i>I need you in my cunt! It... I don't want- oof!</i>\"  You start pumping your shaft forcefully in and out of her, slamming her full cheeks against you with every thrust.  You can tell from the way she feels around you that she's not very experienced with this way of doing things.\n\n");

	output("The more your [pc.cock " + x + "] stretches her tight anus, though, the more comfortable she seems to get with it.  She still protests weakly between grunts, but every once in a while a moan bursts from her, and the passion in them tells you that she's starting to like this.  Eventually she relaxes in your grip, resigning herself to letting you abuse her ass like it's a cheap toy.  One of her hands even sneaks up to her wet snatch and dips in.  Her hips start to move a bit without your influence, too, bouncing back and forth and you ram into her harder and harder.  Clearly she likes the feeling, even if she knows she won't get pregnant from it.\n\n");

	output("The slutty creature's moans turn to shouts as the sensation overwhelms her, and she bucks wildly back against you, face still in the dirt and tongue lolling out of her mouth.  \"<i>Oh, fuck yes, harder, HARDER!</i>\" she bursts forth wildly.  You oblige and pick up the intensity, absolutely ravaging her tight ass now with the motions of your [pc.cock " + x + "].  She squeals somewhere down below you as her face is ground against the mud.  You rock her whole body back and forth as you slam into her, reveling in the feeling of her tight ass squeezing your cock as you slide inches in and out of her.\n\n");

	output("You can feel the cum building up inside you, and you know that you won't be able to hold out much longer.  Looking down, you can see that Tamani isn't far from orgasm, either.  Her fingers slip rapidly in and out of her cunt, and the look on her face is one of thoughtless bliss.  She shudders and goes limp in your grasp just as you cum, painting the insides of her ass with your [pc.cum].  Her eyes are still rolled up into the back of her head as you pull your softening prick out of her ass.  You drop her, letting her legs fall back to the ground with a dull thud.  She turns over onto her side, looking up at you.  Between exhausted pants, she manages to say, \"<i>Don't... think that I... enjoyed that... or anything... I'll be back for you, and you better not...</i>\" before she passes out.  You shake your head and laugh at the stubborn little slut as you tuck your [pc.cocks] back into your [pc.gear] and head back to your camp.\n\n");
	
	//chars["COC.TAMANI"].loadInAss(pc);
	processTime(20 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

//internal function tamaniBeaten():void {
	//clearOutput();
	//output("With the goblin defeated, you're finally free to tend to your body's true desires, even if they may be different than the ones the goblin was intent on stoking.  You shed your [armor] like a second skin, shrugging out of the offending garments with ease.  With your nude form revealed, Tamani ");
	//if(pc.hasCock()) output("licks her lips in anticipation, eyes locked on [eachCock]");
	//else output("frowns in displeasure, noting your lack of a penis");
	//output(".  She's clueless to the growing size that dangles beneath your spider-half, the secret drider treasure that you usually keep retracted.  A dollop of green goo drips from the tip of the semi-hard organ, still hidden from the goblin matron.");
	//
	//output("\n\nYou skitter up to her and calmly say, \"<i>Bend over.  I want to take you with my spider half.</i>\"");
	//
	//output("\n\nThe eager slut smirks and chuckles, \"<i>Whatever you say, ");
	//if(flags[kFLAGS.TIMES_OVIPOSITED_TAMANI] == 0) output("my baby-" + pc.mf("daddy","momma"));
	//else output("my egg-obsessed arachnophile");
	//output(".</i>\"  Soon, the purple-haired skank has assumed the position, though she has the temerity to look back over her shoulder and lick her lips.  Her smouldering gaze is just beckoning for cock, but in this case, she'll be making do with your ovipositor.  You look away from her hungry eyes down to the green bubble-butt, admiring the swell of her cheeks, her puckered anus, and best of all, her sopping wet nethers.");
	//
	//output("\n\nTamani exhales, \"<i>Eyes up here, " + pc.mf("stud","breeder") + ".  I want to watch your face while you fuck me,</i>\" in a tone that promises delights beyond imagining.  \"<i>Put it in my pussy and give me your babies.  There's nothing like fucking a woman who'll take your cock straight into her womb and let you bathe her eggs with cum");
	//if(flags[kFLAGS.TIMES_OVIPOSITED_TAMANI] > 0) output(", or in your case even more eggs");
	//output(".</i>\"  Petite hands massage the goblin's perky, lust-thickened nipples as she talks and wiggles her bouncy bum in your direction.");
	//
	//output("\n\nYour hard legs clatter noisily as you advance on the prostrate, baby-hungry goblin.  Flexing foreign muscles, you bring your abdomen down and align the turgid organ with the goblin's gushing lips.  Her glistening gateway parts for your masculine egg-layer, easily allowing the ooze-dripping prong to slide right through her passage, and soon enough, your carapace is rubbing on jiggly green bottom, the ovipositor completely swallowed by the goblin's rapacious cunt.  Her rippling passages squeezes it gently, as if to say 'hi'.  Your drider instincts answer with a thick squirt of green goo.");
	//output("\n\nTamani giggles happily and asks, \"<i>A little eager today, " + pc.mf("stud","baby") + "?  Is your spider-stick that happy to experience a little goblin loving?</i>\"  She gleefully begins to move herself, riding your arachnid tool like a bucking show-pony.  You moan at that, enjoying it for a moment before remembering that you just defeated this arrogant, cock-hungry slut.  You place your hands on her shoulders and push her down, filling her as you flatten her against the dirt, where she belongs.  With the goblin firmly hilted, you clench and release the first of your eggs; as soon as you allow one to roll down your fleshy tube, the next chases after.");
	//
	//output("\n\n\"<i>W-wha... oooohhhh.  That's niiiicccce,</i>\" Tamani sighs while trying to meet your gaze.  You smirk mirthfully at her and reach down to play with her " + tamaniChest() + ", squeezing and groping roughly while your eggs roll unimpeded into her willing, elastic womb.  The green girl shivers and moans, \"<i>Yes!  Fill me!  Fill me up!</i>\"");
	//output("\n\nStill holding her fast, you simply enjoy the sensation, slowly stuffing Tamani's womb full of round orbs and gushy green padding.  A trickle of extra ooze escapes the curvy skank's thighs, mixed with her own clear juices.  It forms a sticky puddle beneath her that only grows larger as the goblin bloats.  Trickles of milk suddenly burst from the darkened nipples to wet your fingers, so you squeeze harder, milking the little slut like the whore-cow she is.  She cries, \"<i>FUCK YES!  Make me carry your babes and squirt milk everywhere!  Gods... so... pregnant...</i>\"");
//
	//output("\n\nTamani's hands begin to roam across the taut dome of her gravid belly as it swells still bigger, and with a jubilant shriek, she climaxes, spraying gouts of green-tinged pussy-juice in a fan beneath her.  She goes limp in your grip, though her milk keeps flowing unimpeded.  You let her go, though she's held to your prong by the pressure of the last few eggs that pass into her stretchy, fertile womb.  You hum happily, feeling completely relieved, utterly languid and satisfied.");
	//if(pc.hasCock()) output("  White coats the goblin from her shoulders up, the only evidence of your male satisfaction.  You were so focused on the act of impregnation and the unique pleasure that it provides that you barely noticed [eachCock] erupting in sympathetic pleasure.");
	//output("\n\nAt last, the bloated bitch slides into the gooey green puddle with a splash, freeing your ovipositor to retract.  She immediately begins snoring, clearly as satisfied as you.  What a strange creature.");
	//flags[kFLAGS.TIMES_OVIPOSITED_TAMANI]++;
	////Don't encounter Tamani for 3 days if fertilized
	//if(pc.fertilizedEggs() == 0) pregnancy.knockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, 72);
	//pc.dumpEggs();
	//pc.orgasm();
	//cleanupAfterCombat();
//}
	
//Butts McGee Facesitting Tamaniz
public function preferTamaniFemdom():void {
	clearOutput();
	//Tamani Facesit
	//===========Tamani============
	//((Female PC has a third option when they encounter Tamani, labeled 'Like girls' if this is implemented; it gets them the following text.))
	output("\"<i>You're into girls, huh?</i>\" Tamani laughs, turning around and giving her fat butt a playful swat.  You watch as she does it a second time, laughing more at you than <i>with</i> you now, and then turns back around.  \"<i>Tell you what then, slut! I've had crap luck today finding a good stud, so I'll make you a deal.</i>\"");
	output("\n\nTamani advances closer, staring you straight in the eye with an impish smirk.  \"<i>I'll let you get me off if you swear to stay away from </i>my<i> cocks. Deal?</i>\"");
	processTime(1);
	clearMenu();
	addButton(0,"Accept",acceptTamaniFacesits);
	addButton(1,"Refuse",declineZeFacesits);
}

//(("Refuse" choice))
public function declineZeFacesits():void {
	clearOutput();
	output("You tell her you're not interested.");
	output("\n\nThe curvy goblin kicks you with a snarl.  \"<i>Fine, bitch. Have it your way. But if I find you taking <b>my</b> cocks again, you're going to be in trouble!</i>\"  She darts off before you can get a word in edgewise, leaving you alone.");
	//((Needs non-leg and centaur equivalents))
	processTime(2);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//(("Accept" choice))
public function acceptTamaniFacesits():void {
	clearOutput();
	output("You eye the goblin's wide hips again before you nod, anticipating the idea.");
	output("\n\nTamani's impish smirk blooms into a wide grin, and the little goblin gently shoves you.  \"<i>Lay down, then!</i>\" she tells you.  You decide to comply, reaching for your [armor] - but she stops your hand.  \"<i>No need to strip, skank. Just lay down,</i>\" she tells you, pushing again.  You shrug and comply with her request, finding a comfortable spot on the ground to lay on, and then look over at her.");
	output("\n\nShe's pulled a vial off of one of the straps of fabric draped over her body and uncorked it; she empties the vial's purple-hued contents into a hand, not even looking at you, and then smears them all over her pussy.  The goblin gives a lusty moan as her fingers dig in, jilling herself as her knees shake, and a heat starts to build between your legs as you watch her getting off.  Just as your hands are about to creep south for a little self-pleasuring of your own, Tamani starts to walk over to you, her engorged, green cunt dripping with her juices, rather than the fluid she just rubbed all over it.");
	output("\n\n\"<i>A little insurance.</i>\"  Tamani explains.  \"<i>I know </i>you're<i> going to enjoy getting me off, skank. I want to make sure I'll enjoy it just as much,</i>\"  She swings a leg over your head, one to either side of your neck - and then slowly sits down.  \"<i>Here we go~</i>\" she coos, sing-song.");
	output("\n\nYour field of view is already dominated by her giant green butt, the thick globes of her ass-cheeks jiggling as she lowers herself down - and her pussy drips all over your mouth, the little green whore using the fluids to line herself up.  There's a sudden rush of air as her butt drops the rest of the way all at once, her hips dropping straight down onto your [face], and her pussy lips mash against your mouth in a perverse, sloppy 'kiss'.");
	output("\n\nYour nose ends up jammed somewhere between her cheeks, tainting your every breath with the scent of goblin butt, and the juicy haunches of her backside block most of your view, most of the light you can see coming from the crack between them.  \"<i>Lick me, cunt!</i>\" she yells, grinding her hips left-to-right and rubbing her wet snatch against you in the process.");
	output("\n\nYou try to breathe - but find it difficult, most of your breath being blocked out by plump goblin ass, and so you reach your hands up and move the squishy cheeks, your tongue darting out as you breathe.  You run your tongue up and down along the goblin's gash, enjoying the weird, slightly-creamy taste of her juices, and she lets out a short moan.  \"<i>Come on, you can do better than that!</i>\"  She grabs your hands, then bounces up, bringing her gash smacking back down against your tongue - which slips between her outer lips.");
	output("\n\n\"<i>Fuck yeah!</i>\" she yells, bouncing on top of your [face] and smothering you with 50 pounds of dripping goblin pussy and ass.  Your tongue dips in and out of her honey pot, and you try your best to slather her walls and her lips with attention whenever they're within reach, drawing more and more juices out of the lusty bitch.  \"<i>Yeah, f-f-fuck, keep licking!</i>\"  You consider reaching up to grab her butt and <i>hold</i> her against your [face], but her constant bouncing keeps your efforts to move your hands from amounting to too much.");
	output("\n\nInstead she stops on her own, grinding her snatch against you instead, and her soppy cunt smears its juices all over your mouth as she rubs it back and forth, using your [face] like some kind of living sex toy before stopping with her cunt over your mouth.  \"<i>Get your tongue in there!</i>\" She playfully orders you, leaning forward and freeing a bit of your view from the thick green asscheeks.");
	output("\n\nIt takes all you have to not let out a frustrated 'finally' as the goblin settles down long enough for you to actually try to get her off, but you manage to slip your tongue deep between her folds instead.  You lick and lap at the inside of her tunnel, letting out a few hushed moans and sighs as your own cunt drips far below, and her juices keep flowing out in reward.  The slutty goblin herself 'helps' things along by constantly rubbing her breasts and moaning, and you keep licking away at her insides.");
	output("\n\nGetting an idea, you slip one hand around to her front and one towards her big ass - and attack her from both angles at once as you curl your tongue around inside of her, forcing its tip against her walls as you swirl it around and around in circles.  Your right hand reaches out and grabs the goblin's engorged clit, forcing a shrill cry of pleasure out of her whorish lips, and your left slips a pair of fingers between the cunt's cheeks, piercing her asshole.");
	output("\n\n\"<i>O-oh f-fuck!</i>\" she cries, cheeks clenching down on your hand - but you're not having any of that.  You pinch her clit and give it a little twist, making her hips jump forward as her legs try to close in front of her - and then quickly fingerfuck her asshole, stopping that movement with the sudden shock.  Back and forth you pleasure her, licking her sloppy cunt all the while, and she bucks atop you, crying out in pleasure.");
	output("\n\n\"<i>F-fuck yeah, fuck yeah, ye-he-he-hehhsss!</i>\" she screams, pinching and twisting her nipples.  Her hips move so that her lips are pushed at an awkward angle against your mouth and searching tongue - and you manage to snake it into rubbing against a weird-feeling little spot inside of her.  Instantly, her entire body seizes up as you lick what has to be a sensitive spot in her green twat, and you abuse the advantage by assaulting it with your tongue.");
	
	output("\n\nThe movements of her bucking hips and fat ass stop, instead replaced by a full-body shivering as you finger her ass and molest her clit on top of everything else, and she tries to speak again.  \"<i>F-f-f... ff-... f-f-f-f...</i>\"  All she manages to do is let out high-pitched, half-squealing little 'fffff' sounds, like she's trying to swear over and over and failing just as often, and then you pinch her clit one more time.");
	output("\n\n\"<i>FFFFFFFNNNNNnnnnnnnn!</i>\" the green whore cries out, her thighs clamping down on the sides of your head like a vice.  Her asshole grips down on your invading fingers, holding them in place, and her pussy undulates around your tongue like a living thing, more and more of her juices gushing out as the little slut comes <b>hard</b> before she just... goes limp.");
	output("\n\nYou withdraw your fingers from her ass and let go of her clit, and the little green fuck-doll topples over, falling into the dirt and muttering something incoherently. You sit up and look, admiring the sight of her fat green ass sticking up in the air with her juices still dripping down her thighs, and decide to walk away from the clearly unconscious goblin.");
	pc.lust(20 + pc.libido() / 20);
	processTime(15);
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function encounterTamaniPosible():Boolean {
	return int(flags["COC.TAMANI_DEFEATS"]) < 10 && pc.hasGenitals() && int(flags["COC.TAMANI_TIME_OUT"]) == 0 && (pc.hasCock() || !pc.hasKeyItem("Deluxe Dildo"));
}