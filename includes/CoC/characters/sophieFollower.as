import classes.Characters.CoC.CoCSophie;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCBimboLiqueur;
import classes.Items.Transformatives.CoCDeBimbo;
import classes.Items.Transformatives.CoCEggs.CoCBlackEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCBlueEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCBrownEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCPinkEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCPurpleEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCWhiteEggLarge;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Make Sophie \"smart\" again: Doing the Deed
//Visit Rathazul and he bitches.
//Notification (On Approaching Rathazul)*

//SOPHIE_DEBIMBOED
//SOPHIES_DAUGHTERS_DEBIMBOED
//SOPHIE_RECRUITED_PURE

//const SOPHIE_DEBIMBOED:int = 745;
//const SOPHIES_DAUGHTERS_DEBIMBOED:int = 746;
//const SOPHIE_RECRUITED_PURE:int = 747;
//const SOPHIE_FOLLOWER_IRRITATION:int = 748;
//const TIMES_MORNING_SOPHIE_FEMDOMMED:int = 749;
//const NO_PURE_SOPHIE_RECRUITMENT:int = 754;
//const SOPHIE_FOLLOWER_PROGRESS:int = 755;

public function sophieFollower():Boolean {
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00283"] > 0) return false;
	if (bimboSophie()) return false;
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0 && flags["COC.SOPHIE_DEBIMBOED"] > 0) return true;
	if (flags["COC.SOPHIE_RECRUITED_PURE"] > 0) return true;
	return false;
}

//Un-Bimbo*
public function unbimboSophie():void {
	clearOutput();
	output("Taking the potent mixture out of your pouch, you consider giving it to the bimbo harpy fluttering about in front of you.  She'd probably be pretty mad about the whole affair, but if you want to repair the damage you've inflicted, this is probably your best bet.  Do you un-bimbo Sophie?");
	//[Yes] [No]☼
	clearMenu();
	addButton(0, "Yes", yesDebimboSophie);
	addButton(1, "No", noDontDebimbo);
}

//No (You Monster)*
private function noDontDebimbo():void {
	clearOutput();
	output("You shrug and put the potion back in your pack.  Maybe later...  A mad Sophie isn't something you particularly want to deal with right now.");
	//(Return to Sophie menu.  You monster)
	clearMenu();
	addButton(0, "Next", approachBimboSophieInCamp);
}

//Yes (God dammit what the fuck did I just say)*
private function yesDebimboSophie():void {
	clearOutput();
	
	pc.destroyItem(new CoCDeBimbo());
	
	output("You grab the air-headed harpy and pull her over to you, pressing her impressive chest against you as you ready your intellectual beverage.  \"<i>Oooh! Hey, babe, what'cha got there?</i>\" Sophie asks, staring wide-eyed at the tincture.  Telling her not to worry about it, you pop the cork and bring the vial's neck up to Sophie's mouth, her big, full lips parting eagerly.  \"<i>Hey, is it wine?  I could just <b>DIE</b> for some wine!  Then maybe, like, a good hard fucking afterwards!</i>\" she declares, jumping excitedly in your grasp - almost making you spill the drink.  You grasp her chin, steadying the harpy's head just long enough to upend the liquid into her mouth, making sure to drain every last drop into her before you tickle her throat, forcing her to swallow it all in one audible gulp.");
	
	output("\n\n\"<i>Ew!  That TOTALLY wasn't booze!</i>\" Sophie complains, struggling out of your grasp and pouting, feather arms crossed beneath her heavy bosom.  You observe her for a long moment, waiting... waiting....  \"<i>Hey, I like, don't feel so good...</i>\" Sophie finally says, clutching her head, fingers running through her thick blonde locks.  \"<i>Ugh, I don't... Why... Oh, shit, where am I?  And what happened to my TITS!?</i>\" Sophie staggers forward, blinking hard.  When she looks up at you a moment later, you can see that gleam of intelligence flaring brightly once more in her blue eyes.");
	
	output("\n\n\"<i>Wha... what did you DO TO ME!?!?!</i>\" Sophie screams, a look of sheer feral rage splayed across her still-bimbofied face, full-lips drawn into a snarl beneath gleaming eyes and long golden hair.  Her shiny yellow feathers ruffle as she stomps up to you, putting her face right up to yours.  \"<i>You " + pc.mf("bastard","bitch") + "!  WHAT DID YOU DO TO ME?</i>\"");
	
	output("\n\nYou recoil at the sudden outburst of rage, mind racing for an appropriate course of action...");
	flags["COC.SOPHIE_DEBIMBOED"] = 1;
	if (flags["COC.SOPHIE_ADULT_KID_COUNT"] > 0) flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"] = 1;
	//[Beat her] {if Int > 30: [Apologize] [Why I Did It]} [Let Her Go] [Bimbo again!(if PC has Bimbo Liqueur)]
	clearMenu();
	addButton(0, "Beat Her", beatSophieAroundYouMonster);
	addDisabledButton(1, "Apologize", "Apologize", "You are not smart enough to make her listen to reason without a fight.");
	addDisabledButton(2, "WhyIDidIt", "Why I Did It", "You are not smart enough to make her listen to reason without a fight.");
	if (pc.intelligence() > 30) {
		addButton(1, "Apologize", apologizeToDebimboSophie);
		addButton(2, "WhyIDidIt", whyIDidItToDebimboSophie);
	}
	addButton(3, "Let Her Go", letDebimboSophieGo);
	
	if (pc.hasItem(new CoCBimboLiqueur())) addButton(4, "Bimbo Again", bimboSophieAgain);
	else addDisabledButton(4, "Bimbo Again", "Bimbo Again", "This option requires you to have a bottle of Bimbo Liqueur.");
}

//Bimbo Again! (You monster)
private function bimboSophieAgain():void {
	clearOutput();
	
	output("Oh no, fuck this!  You lunge forward, seizing the recovering harpy while removing another Bimbo Liqueur from your belt.  \"<i>Wha- No!</i>\" she cries, but too late!  You pop the cork, and dump the braincell-killing booze down her gullet, keeping her mouth muffled and nose pinched shut until she swallows it allllllll down like the good little slut she truly is; the spent bottle rolling around on the floor as the sound of wet gulping fills the air.  The deed done, she slumps to the ground, her eyes crossing with familiar confusion as the liqueur does its job, frying her brain back into oblivion.");
	
	output("\n\n\"<i>B... babe?</i>\" she asks a moment later, looking up at you with wide, dim eyes.  Her hand drifts down toward her sodden box, idly fingering it as she looks to you.  \"<i>Wanna, like, fuck or something?</i>\"");
	output("\n\nWell then, crisis averted!");
	
	
	flags["COC.SOPHIE_DEBIMBOED"] = 0;
	flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"] = 0;
	pc.destroyItem(new CoCBimboLiqueur());
	
	processTime(15 + rand(5));
	if (inCombat()) CombatManager.abortCombat();
	approachBimboSophieInCamp(false);
}

//Beat Her (You Monster)*
private function beatSophieAroundYouMonster():void {
	clearOutput();
	output("Oh no, fuck this!  You [pc.readyWeapon] to knock some sense into the harpy slut.  Seeing your hostile movements, Sophie draws a sharp breath, preparing to defend herself.");
	
	output("\n\n\"<i>I'm gonna make you pay for this!</i>\"");
	processTime(1);
	//(Go to normal Sophie Combat screen)
	
	var soph:CoCSophie = new CoCSophie();
	soph.createStatusEffect("Flee Disabled");
	soph.createStatusEffect("BimboBrawl");
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCSophie());
	CombatManager.victoryScene(beatUpDebimboSophie);
	CombatManager.lossScene(debimboSophieBeatsYouUp);
	CombatManager.displayLocation("SOPHIE");
	CombatManager.beginCombat();
}

//Successful Beat the Shit Out of Sophie (You Monster)
internal function beatUpDebimboSophie():void {
	clearOutput();
	output("Sophie stumbles back, unable to withstand your furious assault.  You grab the harpy before she collapses, asking if she's ready to fucking listen now.  Defiantly, she looks away from you, though otherwise too weakened to resist you.");
	//[Apologize] [Why I Did It] [Let Her Go] [Bimbo again!(if PC has Bimbo Liqueur)]
	//{No INT gate now!}
	clearMenu();
	//addButton(0,"Beat Her",beatUpDebimboSophie) {
	addButton(1, "Apologize", apologizeToDebimboSophie);
	addButton(2, "WhyIDidIt", whyIDidItToDebimboSophie);
	addButton(3, "Let Her Go", letDebimboSophieGo);
	
	if (pc.hasItem(new CoCBimboLiqueur())) addButton(4, "Bimbo Again", bimboSophieAgain);
	else addDisabledButton(4, "Bimbo Again", "Bimbo Again", "This option requires you to have a bottle of Bimbo Liqueur.");
}

//Get the Shit Beaten Out of You by a God-damn Bimbo (You (weakling) Monster)
internal function debimboSophieBeatsYouUp():void {
	clearOutput();
	output("You fall backwards, right onto your [pc.butt], unable to resist the harpy's attacks.  She looms over you, glowering, her face flushed red with intense loathing.  \"<i>What the fuck is WRONG with you!?  How... WHY would you do something like THIS - to a poor old woman?  You... you turned me into a freak!  I-I'm an abomination!</i>\"");
	
	output("\n\nSophie buries her face in her hands and starts to cry, tears soon streaming around her fingers, staining her platinum blonde feathers.");
	//[Apologize] [Why I Did It] [Let Her Go]
	clearMenu();
	addButton(1, "Apologize", apologizeToDebimboSophie);
	addButton(2, "WhyIDidIt", whyIDidItToDebimboSophie);
	addButton(3, "Let Her Go", letDebimboSophieGo);
}

//Let Her Go*
private function letDebimboSophieGo():void {
	clearOutput();
	output("You decide it's probably best to let Sophie go.  She remains still for a long moment, before finally looking at you with her big, blue eyes, a strange mixture of loathing and wonder in them.  Without further hesitation, she turns and rushes off, back toward the High Mountains you'd imagine.");
	
	output("\n\nMaybe you'll see her again one day.  Though with a body like hers... you wonder just how 'successful' she can be out in the wild.");
	
	output("\n\nWill she even get back up the mountain, ladened down with huge tits and bimbofied ass as she is?");
	if (pc.libido() >= 50) {
		output("\n\nThoughts drift through you of her bouncing breasts flopping around, her enormous plush ass pulling her ever downwards towards an unforgiving earth filled with lustful monsters and demons just aching to fuck and satisfy their throbbing, cum-filled members inside her until she's fit to burst.  You picture her pretty bimbofied face completely worn red, tongue panting through exhausted cocksucker-swollen lips from the exertion necessary to maintain high-altitude flight with her sinfully fuck-doll body.");
		if (pc.cor() < 40) {
			output("  You blink repeatedly, trying to clear your head of these idle thoughts, but are nonetheless aroused.");
			//{+10 AROUSAL}
			pc.lust(10);
		}
		else {
			output("\n\nYou let these fantasies run wild through your head, imagining a group of three opportunistic minotaurs gangbanging a flight-exhausted Sophie; their ribbed, flared cocks completely renovating her yielding pussy and convulsing asshole while she gurgles helplessly around a third pulsing horseshaft lodged deep in her throat.  The two double-penetrating her holes grunt, their grossly sperm-swollen, watermelon-sized ball sacs and quivering dark taints rubbing up against one another in a fevered race to see who can cum first and claim this bimbo bird as their own personal cumdump and breeding slave.");
			
			output("\n\nThe pheremonal scent of pussy wetting equine musk in the air becomes steadily more suffocating as the minotaurs grow nearer and nearer to climaxing and releasing the aching pressure that's been built up in their engorged balls over the past two-months.  Their frenzied pace, going from rough hole-pounding to ramming balls-deep, shows how eager each wants to claim this Milfy harpy, her body only fit for pleasing cocks and birthing more babies.  Owning such a fertile 'mare' would mean that their ever-expanding minotaur cum factories would never again throb with the pain of holding pent up loads.");
			
			output("\n\nSuddenly, the minotaur pounding Sophie's face emits a loud bellow, thick spongy equine shaft widening apart her already tortuously stretched, yellow lips with thick pulses of cum that race towards a fully-widened flared head.  It blocks any hope of air reaching Sophie's aching lungs, a bestial flesh cone pushed directly into her stomach, dripping, and cum-tube pointed towards its deepest, hungry depths.  As hot cum emerges from the equine fleshcork, Sophie's blue eyes roll back in her head, completely overwhelmed by the minotaur's aphrodisiac ball juice.  She doesn't feel pain from each progressively thicker ribbed-shaft layer scraping past her teeth, forcing her jaw wider and wider, or from the minotaur's flared head pulling up against her narrow esophagus, trying to escape.  The minotaur gives in fully to his victory orgasm, hilting all two-feet of his cock down Sophie's throat, her nose pressing firmly against his animalistic crotch, saliva frothing over the minotaur's rapidly deflating black orbs.  Sophia responds immediately to the minotaur jism bulging and doming her increasingly shiny stomach, her battered cock holders flexing powerfully as a masochistic orgasm wracks her, pounding her into the ground with great force and raising her exposed, tailfeathered bubble-butt high to the musk-filled air for deeper penetration.  The thick, darkly ribbed minotaur meat moving in and out of her tight butthole and squishy pussy produce more squeezing shudders, further teasing the cocks inside her as she's orgasming on them.");
			
			output("\n\nThe two remaining minotaurs, unable to withstand the hot sensation of the harpy's rippling anal and pussy muscles through their extremely pleasure-worn, turgid horsecocks, let loose a roar, dwarfing even the still-cumming minotaur who's enjoying filling her with what will be the first of countless future cum loads as his 'mare.'  Meanwhile, inside Sophie's rear, as the two minotaur cocks separated by only a thin anal-wall start cumming, they feel the gurgling cum deluge leaving each minotaurs' sweat-drenched horse balls as pleasurable vibrations, increasing as it geysers up their pulsing sheathes pressed against one another.  That stimulation grows as each minotaur's rhythmically contracting taint makes their cock repeatedly jerk and press deliciously against the other minotaur's trapped member through the anal-wall, only further enhancing their long anticipated ejaculations.  Sophie's body goes into an ecstatic seizure as she feels both bulls' flares fattening up inside her, rubbing in <i>allllll</i> the right spots, only staying conscious because of her incredible avian lungs.  Despite not winning the \"mare,\" the minotaurs have no regrets as they experience their two seed-swollen flares and ribbed minotaur skin brushing past one another inside the harpy's gripping tightness.  This drives them both to jam in one final time, deeply as possible, skewering her asshole and pussy.  The sound of two fully sheathed cocks slapping Sophie's ass fills the air as the minotaurs start mooing softly, orgasm overtaking them, the sound of squirting fluids growing louder and louder.");
			
			output("\n\nSophie's vision grows dim as the second dick explodes, filling her ass with an almost fire-hydrant pressurized orgasm, ensuring that the anally exploring minotaur's seed would become good friends with the other skullfucking minotaur's sperm inside her gravid belly.  Good friends at least until both colliding waves of cum decide to leave the warm confines of Sophie's belly.  The victorious minotaur grunts in jealousy upon seeing the other bull's potently anal-enhanced spurts force his own waves of heady bull-batter from Sophie's spit roasted mouth back at him.  It drenches his furry crotch before puddling near his trembling hooves.  The third bull lodged in her quivering cunt causes Sophie to black out as he rams his flared head against her cervix, completely hugging all sides of her sensitive womb's opening with sucking, spongy, soft-ridged horseflesh.  The brutal flare plunger-movement makes Sophie's cunt squirt feminine fluid all over herself, soaking the invading cock and making the sex sound even lewder; her body's instinctive contractions a mechanism for drawing any released sperm into the deepest parts of her womanhood where it would be sure to knock-up her needy egg.  And as nature intended, the sheer size of the minotaur's flare in comparison to Sophie's tiny opening ensured every drop of sperm leaving the widened piss hole went directly into her unprotected womb...at least until the flood of excess sperm from her brimming baby hole creampies past the vacuum-seal of the minotaur's flare.  The sound of cumming, mooing, and smelly wet fluids being pumped is so loud that other minotaurs emerge from nearby caves, gathering around to bear witness to the induction of a new \"mare\" into the herd.  As rivers of hot semen and sperm drizzle around Sophie's legs, the rest of her exposed body and feathers becomes matted with layers of goo, the gathering minotaurs baptizing her bukkake style, officially welcoming her into the herd.  Eventually, the gangbang ends, all three minotaurs unsheathing themselves with wet 'SCLUUUUUUUUURPS' that echo across the mountains, their ribbed horsecocks growing flaccid, ebony balls now the size of baseballs.");

			output("\n\nGrunting happily, the victorious minotaur grabs his new \"mare\" slightly above the talons, and starts dragging her back into the intricate network of caves where the minotaur's live.  Regaining consciousness, the new mare sputters - coughing up inhuman amounts of jizz onto her pillowy breasts; the very same fluid that's oozing from her other soon-to-be forever minotaur-sized cumdump orifices.  She reaches out  to the sky, silently mouthing \"<i>P-please [pc.name] - h.....help</i>,\" hand slumping into the shadows of the caves as the light of day is seen no more.");
			
			output("\n\nYou smile perversely from your fantasy, thoroughly aroused by it.");
			//{+25 AROUSAL}
			pc.lust(25);
		}
	}
	flags["COC.UNKNOWN_FLAG_NUMBER_00283"] = 1;
	
	processTime(15 + rand(5));
	if (inCombat()) CombatManager.abortCombat();
	addNextButton();
}

//Why I Did It (I'm a Monster, you see)*
private function whyIDidItToDebimboSophie():void {
	clearOutput();
	output("Gently, you decide to try and explain yourself, telling Sophie about how you came across the Bimbo Liqueur... how you decided to use it on her, and why.  She listens silently, averting her eyes from you as you talk.  You note, though, as you speak, that her hands slowly drift down, feeling along the new body she's been given as if discovering her enhanced 'assets' for the first time.  The platinum-blonde harpy shudders as her hands drift across her huge F-cups, fingertips gently caressing her prominent nipples, which stiffen instantly at her touch, ready to be played with or suckled on.");
	
	output("\n\nWhen you finish explaining yourself, there's a long moment of silence.  Sophie continues to avert her gaze, but you can see that's she's calmed somewhat, perhaps soothed by your honesty.  Finally, though, she speaks: quietly, and with barely more than a whisper, the harpy woman says, \"<i>I can't go back.</i>\"");
	
	output("\n\nWhat?");
	
	output("\n\n\"<i>Just look at me,</i>\" she says, her voice quavering.  \"<i>I can't fly like this... Even if I could, the other girls would just... oh, the things they'd say.  I can't go home.</i>\"");
	
	output("\n\nShe pauses a moment.  Then, to your surprise, a wry chuckle escapes her lips.  \"<i>Hell, I always wanted to get off that fucking mountain anyway.  I'm tired of the girls making fun of me... calling me a fat-tit slut.</i>\"  Sophie looks up, locking eyes with you, \"<i>Well, since you seemed so keen on having me around, I guess you wouldn't mind me sticking around, would you, [pc.name]?  It's not like I have anywhere else to be, and maybe at least YOU can appreciate my new physique....  I have to admit, these are rather sexy,</i>\" she says, cupping her hefty teats.");
	
	output("\n\n\"<i>Maybe I'll just set up a nest over there,</i>\" she adds, idly pointing to a bare space on the edge of camp, sheltered by a circlet of rocks.");
	
	output("\n\nYou nod, and tell Sophie to make herself at home.");
	output("\n\n(<b>Sophie has been moved to the \"Followers\" tab!</b>)");
	
	processTime(15 + rand(5));
	if (inCombat()) CombatManager.abortCombat();
	addNextButton();
}

//Apologize (Sorry I'm a Monster)*
private function apologizeToDebimboSophie():void {
	clearOutput();
	output("You decide to apologize to Sophie, saying you didn't mean for things to get so out of hand... you didn't know she'd change quite so much!  You only thought the potion would enhance her physique, maybe make her a little more receptive to your advances.");
	
	output("\n\nShe listens silently, averting her eyes from you as you talk.  You note, though, as you speak, that her hands slowly drift down, feeling along the new body she's been given as if discovering her enhanced 'assets' for the first time.  The platinum-blonde harpy shudders as her hands drift across her huge F-cups, fingertips gently caressing her prominent nipples, which stiffen instantly at her touch, ready to be played with or suckled on.");
	
	output("\n\nWhen you finish explaining yourself, there's a long moment of silence.  Sophie continues to avert her gaze, but you can see that's she's calmed somewhat, perhaps soothed by your honesty.  Finally, though, she speaks: quietly, and with barely more than a whisper, the harpy woman says, \"<i>I can't go back.</i>\"");
	
	output("\n\nWhat?");
	
	output("\n\n\"<i>Just look at me,</i>\" she says, her voice quavering.  \"<i>I can't fly like this... Even if I could, the other girls would just... oh, the things they'd say.  I can't go home.</i>\"");
	
	output("\n\nShe pauses a moment.  Then, to your surprise, a wry chuckle escapes her lips.  \"<i>Hell, I always wanted to get off that fucking mountain anyway.  I'm tired of the girls making fun of me... calling me a fat-tit slut.</i>\"  Sophie looks up, locking eyes with you, \"<i>Well, since you seemed so keen on having me around, I guess you wouldn't mind me sticking around, would you, [pc.name]?  It's not like I have anywhere else to be, and maybe at least YOU can appreciate my new physique.... And I have to admit, these are rather sexy,</i>\" she says, cupping her hefty teats.");
	
	output("\n\n\"<i>Maybe I'll just set up a nest over there,</i>\" she adds, idly pointing to a bare space on the edge of camp, sheltered by a circlet of rocks.");
	
	output("\n\nYou nod, and tell Sophie to make herself at home.");
	//{Sophie has been moved to the \"Followers\" tab!}
	output("\n\n(<b>Sophie has been moved to the \"Followers\" tab!</b>)");
	
	processTime(15 + rand(5));
	if (inCombat()) CombatManager.abortCombat();
	addNextButton();
}


//Catch Sophie Teaching Her Daughters Not To Talk Like Idiots*
public function sophieDaughterDebimboUpdate():void {
	if (flags["COC.SOPHIE_ADULT_KID_COUNT"] == 1) {
		output("\nPerhaps the most impressive change that happens around your camp is Sophie taking charge of the daughter she had BEFORE you gave her the cure.  She's right next to her mom, preening her feathers and checking her make-up against a shiny piece of metal.  Sophie get her attention, and immediately sets to making some changes - leading her in choruses of vocalization training.  She seems utterly intent on eradicating the 'accent' that her daughter picked up from her, and the younger harpy takes to it with surprising swiftness.  You guess you won't be hearing too many 'like's or 'totally's in the days to come.\n");
	}
	else if (flags["COC.SOPHIE_ADULT_KID_COUNT"] == 2) {
		output("\nPerhaps the most impressive change that happens around your camp is Sophie taking charge of the daughters she had BEFORE you gave her the cure.  They're both gathered up around her, preening their feathers and checking their make-up against shiny pieces of metal.  Sophie gets their attention, and immediately sets to making some changes - leading them in choruses of vocalization training.  She seems utterly intent on eradicating the 'accent' that her daughters picked up from her, and the younger harpies take to it with surprising swiftness.  You guess you won't be hearing too many 'like's or 'totally's in the days to come.\n");
	}
	else {
		output("\nPerhaps the most impressive change that happens around your camp is Sophie taking charge of the daughters she had BEFORE you gave her the cure.  They're all gathered up around her, preening their feathers and checking their make-up against shiny pieces of metal.  Sophie gets their attention, and immediately sets to making some changes - leading them in choruses of vocalization training.  She seems utterly intent on eradicating the 'accent' that her daughters picked up from her, and the younger harpies take to it with surprising swiftness.  You guess you won't be hearing too many 'like's or 'totally's in the days to come.\n");
	}
	flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"] = 0;
}


//BimboBody Sophie Follower, Main Screen
public function followerSophieMainScreen():void {
	clearOutput();
	sophieSprite();
	//Sophie is in season
	if (sophieIsInSeason() && pc.hasCock() && int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) {
		//Replacement Greeting Screen For In Season
		//Similar to bimbo sophie
		output("Sophie's entire soft body jiggles and shudders visibly when she hears you call her.  Her walk towards you is a bit too fast to be sensuous, despite her best attempts, and her tail feathers twitch, fanning a breeze towards you that reeks of pheromones and her needy sex.  She puts a hand on her hip, making a small show of her jiggling butt and immense mammaries as she gives you a wink and stares at you with lowered eyelids, bedroom eyes seeking to provoke more arousal from you.  Her finger presses against your [pc.chest] as she speaks, slowly and seductively, trying to accentuate every word by adding the power of her lips to it.  \"<i>Sooo, you wanted to see me?  That's good, because Momma Sophie wanted to see you as well.</i>\"");
		output("\n\nHer hand travels down your belly all the way to your [pc.oneCock], rubbing against it affectionately as she presses her prodigious bosom against you.  \"<i>You see, you need to put \"momma\" back into Momma Sophie, [pc.name].  You really have to do it, it's <b>very</b> important, wouldn't you agree?</i>\"  When she grabs at your [pc.cockHead " + pc.biggestCockIndex() + "], you stiffen immediately, and almost catch yourself nodding to her words.  \"<i>Your cock seems to agree, [pc.name].  It pulls you towards me, egging you on to pump me full of eggs, right?</i>\"  She chuckles as she continues to rub your member.  \"<i>To just put it in and squirt until I'm totally full of your cum, and then your baby.</i>\"  She continues to caress you, and you realize that with her being more needy than usual, it's natural that she'd try to compel you to have sex with her, and ");
		if (bimboSophie()) output("restoring her intellect made her quite skilled at it again");
		else output("she's quite skilled at it");
		output(".  \"<i>Ohhh, come on, [pc.name]!  Just give it to me like a good " + pc.mf("boy","girl") + ", would you?  I could even give you a special treat.  <b>Just give. It. To. Me.</b></i>\"");
		output("\n\nYou guess there's no way Sophie would really accept any non-impregnating kind of sex right now, but you could refuse... or pick that special treat over your usual sex.");
		pc.lust(20);
		//[Vaginal][Special]
  		//[Vaginal] → Leads to the \"fertile\" variation of vaginal smex!
		//[Special]
		clearMenu();
		addButton(0,"Appearance",sophieAppearance);
		if (pc.hasCock()) {
			if (pc.cockThatFits(sophieCapacity()) >= 0) {
				addButton(1, "Vaginal", fuckFollowerSophie);
				addButton(2, "Special", sophieSpecial);
			}
			else {
				output("\n\nYou're too big to fit inside her!");
				addDisabledButton(1, "Vaginal");
				addDisabledButton(2, "Special");
			}
		}
		else output("\n\nYou need a penis to fuck her!");
		
		if (flags["COC.SLEEP_WITH"] == "Sophie") {
			addButton(8, "NoSleepWith", sleepWithSophieToggle);
			output("\n\nYou're currently sharing your bed with Sophie at night, but you could kick her out, if you wanted.");
		} else addDisabledButton(8, "NoSleepWith");
		addButton(14, "Back", campFollowersMenu);
		return;
	}
	else if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) {
		if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("Sophie leans back in her nest as you approach, her prominent, bare F-cups on display.  She's completely nude, as always, and sits with her avian legs shamelessly spread, revealing the slick slit of her womanhood framed by downy-soft platinum blonde feathers.  \"<i>Hey there, " + pc.mf("handsome","cutey") + ".  What can Momma Sophie do for you?  Come for a cuddle in my welcoming wings, maybe; or for something more... exciting?</i>\"");
		else output("Sophie leans back in her nest as you approach, her prominant, bare DD-cups on display.  She's completely nude, as always, and sits with her avian legs demurely crossed, concealing the slick slit of her womanhood from you.  \"<i>Hey there, " + pc.mf("handsome", "cutey") + ".  What can Momma Sophie do for you?</i>\"");
	}
	else
	{
		output("When you call her name, Sophie's gold-glossed lips curve upward in a smile. She takes her time picking her way out of her nest, and then glides down to you.");

		output("\n\n“<i>Need something from Momma Sophie?</i>” she coos.");
	}
	
	//BimboBody Sophie Follower, Options*
	clearMenu();
	addButton(0,"Appearance",sophieAppearance);
	if (pc.lust() >= 33) addButton(1, "Sex", sexWithFollowerSophie);
	else addDisabledButton(0, "Sex", "Sex", "You aren't aroused enough to sleep with Sophie at the moment.");
	
	if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) addButton(8, "Sleep With", sleepWithSophieToggle);
	if (flags["COC.SLEEP_WITH"] == "Sophie" && int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) {
		addButton(8, "NoSleepWith", sleepWithSophieToggle);
		output("\n\nYou're currently sharing your bed with Sophie at night, but you could kick her out, if you wanted.");
	}
	
	if (flags["COC.SOPHIE_CAMP_EGG_COUNTDOWN"] > 0 && int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) output("\n\n<b>Sophie's egg is sitting nearby.</b>");
	if (flags["COC.SOPHIE_DAUGHTER_MATURITY_COUNTER"] > 0) {
		addButton(7, "Daughter", daughterCheckup);
	}
	if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0) addButton(14, "Back", campFollowersMenu);
	//else addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
	//
	//if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) addButton(2, "Farm Work", sendSophieToFarm);
	//if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 1) addButton(2, "Go Camp", backSophieToCamp);
	//
	//if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE] == 0) addButton(3, "Harvest Eggs", harvestSophieEggs);
	//if (int(flags["COC.FOLLOWER_AT_FARM_SOPHIE"]) == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE] == 1) 
	//{
		//addButton(3, "Change Eggs", changeEggs);
		//addButton(4, "Stop Harvest", stopHarvest);
	//}
}

private function sendSophieToFarm():void
{
	clearOutput();
	sophieSprite();
	
	output("You tell your live-in harpy that she is to head towards the lake, find a farm, present herself to the lady who works there and do as she says. Sophie isn’t exactly enthused by this idea.");

	output("\n\n“<i>I'm here to be with you, not till some farm,</i>” she flounces. She looks at you slyly and sidles her warm, pillowy weight into your side. “<i>Wouldn’t you get lonely out here on your own, [pc.name]? Yes, you would. Give mama Sophie a kiss and we’ll forget all about this...</i>” You take a step back and firmly point in the direction of the farm.");
	
	output("\n\nHer whining and complaining can be heard long after her pink feathers have disappeared over the rise. She’ll be useless as a worker, you think, but she’s considerably more vigilant and sharp than she lets herself on to be. And who knows, maybe she can produce some eggs whilst she’s there.");
	
	flags["COC.FOLLOWER_AT_FARM_SOPHIE"] = 1;
	
	addNextButton();
}

private function backSophieToCamp():void
{
	clearOutput();
	sophieSprite();
	
	output("You tell her she’s welcome to head back to camp now.");

	output("\n\n“<i>Thank the Gods,</i>” she says, rolling her eyes. “<i>Any longer out here and I was going to suffocate from boredom.</i>” She kisses your cheek affectionately before stretching her huge wings out to fly off in the direction of the portal.");

	flags["COC.FOLLOWER_AT_FARM_SOPHIE"] = 0;
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function harvestSophieEggs():void
{
	clearOutput();
	sophieSprite();
	
	output("You ask Sophie if it’s possible for her to produce eggs of a certain color whilst she’s here.");

	output("\n\n“<i>Using the lake magic? Sure,</i>” she says, yawning, and stretching. “<i>Some of my sisters used to come down here so they could get knocked up with eggs they could sell on the side. What color would you like?</i>”");
	
	eggSelector();
}

public var eggColors:Array = [
	"Black",
	"Blue",
	"Brown",
	"Pink",
	"Purple",
	"White",
]

private var _eggTypes:Array

public function get eggTypes():Array
{
	if (_eggTypes == null)
	{
		_eggTypes = [
			new CoCBlackEggLarge(),
			new CoCBlueEggLarge(),
			new CoCBrownEggLarge(),
			new CoCPinkEggLarge(),
			new CoCPurpleEggLarge(),
			new CoCWhiteEggLarge(),
		]
	}
	return _eggTypes;
}

private function eggSelector():void
{
	for (var i:int = 0; i < eggColors.length; i++)
	{
		addButton(i, eggColors[i], postEggSelector, eggColors[i]);
	}
}

private function postEggSelector(selected:String):void
{
	clearOutput();
	sophieSprite();
	
	output("“<i>I’ll make some nice " + selected.toLowerCase() + "eggs for you then, hun,</i>” she says with a small grin. “<i>I can only produce one a week, though. I’ll put it with everything else you earn out of this hole in the ground. How’s that?</i>”");
	
	flags["COC.FOLLOWER_PRODUCTION_SOPHIE"] = 1;
	if (flags["COC.FOLLOWER_PRODUCTION_SOPHIE_COLORCHOICE"] != selected)
	{
		flags["COC.FOLLOWER_PRODUCTION_SOPHIE_COLORCHOICE"] = selected;
		flags["COC.FARM_EGG_STORED"] = 0;
		flags["COC.FARM_EGG_COUNTDOWN"] = 7;
	}
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function stopHarvest():void
{
	clearOutput();
	sophieSprite();
	
	output("You tell Sophie to stop giving you eggs; you’d rather she’d put them towards making the farm money.");

	output("\n\n“<i>Awww,</i>” she replies with pleading eyes. “<i>Couldn't you just fuck some REAL eggs into me instead?</i>”");

	output("\n\nYou respond to the negative, earning a pout from the busty hen. She looks like she's going to obey you regardless.");

	flags["COC.FOLLOWER_PRODUCTION_SOPHIE"] = 0;
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function changeEggs():void
{
	clearOutput();
	sophieSprite();
	
	output("You ask Sophie if she will change the type of eggs that she is producing for you.");
	
	output("\n\n<i>I'd </i>much<i> prefer you to be fucking me full of eggs yourself, but I guess I can change just for you...</i>”");
	
	eggSelector();
}

//[Sex]
private function sexWithFollowerSophie():void {
	clearOutput();
	clearMenu();
	output("\"<i>Oh, really? I was kind of hoping you'd want a taste of me soon.</i>\"  Sophie somewhat perks up at the mention of having sex with you.  \"<i>So, what'd you like? The usual, or should Momma do something special for you this time around?</i>\"  She licks her lips at the suggestion.");
	
	//[Usual] [Nurse] [YouMove] [IMove] [Titfuck] [GetDMilked] [Extra1] [....]
	if (pc.hasCock()) {
		if (pc.cockThatFits(sophieCapacity()) >= 0) addButton(0, "Vaginal", fuckFollowerSophie);
		else addDisabledButton(0, "Vaginal");
		addButton(1, "Blowjob", sophieFollowerGivesBlowjobs);
	}
	if (flags["COC.SOPHIE_ADULT_KID_COUNT"] > 0 && flags["COC.SOPHIE_FAMILY_INCEST"] > 0 && pc.cockThatFits(sophieCapacity()) >= 0)
		addButton(8, "DaughterFuck", sophieIncestInHerCooterOrSomethingIDunno);
	else addDisabledButton(8, "DaughterFuck");
	
	addButton(14, "Back", followerSophieMainScreen);
}

//Appearance:
private function sophieAppearance():void {
	clearOutput();
	output("Sophie is a big, buxom harpy, no two ways about her.  She has ");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("very ");
	output("long ");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("platinum-blond");
	else output("pink");
	output(" 'hair' that dangles off her shoulders, like a bird's plumage.  She wears a thick layer of golden lipstick over her plump");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output(", super-sized");
	output(" lips at all times, like most of her kind, the gloss capable of giving her voice a compelling quality or inducing arousal on contact with males or herms.  Her face lacks the youthful quality found among many of her sisters, though you don't see any of the lines that would indicate age.");
	
	output("\n\nSophie's breasts are ");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("so immense they would drag her to the ground if she tried to fly, a sexy, lingering aftereffect of the draft you gave her.  The wobbly bimbo-tits look to be about F-cups.");
	else output("unusually large.  The buxom harpy does seem slightly encumbered by them, but still capable of flight.  Her breasts look to be about DD-cups, nice and big enough for a soft squeeze or rough tit-fuck.");
	
	output("\n\nShe has a glittering, moist pussy concealed between her thick thighs, both of which start the feathery covering that reaches all the way to her bird-like, taloned feet.  Her jiggly backside wobbles slightly with every exaggerated step she takes, with her long tailfeathers fanning above it.  You're sure there's a tight butthole located between them, where it belongs, but you can't really get a look at it with all the plump ass surrounding it.");
	
	output("\n\nSophie's arms are covered in feathers as well, and are somewhat wing-like in appearance, though she has human hands at the ends of them.  Her primary wings are larger and sprout out above her shoulder blades.  She often keeps them folded out of the way behind her, but she can kick up a huge dust-storm with them when she wants.");

	//if (kGAMECLASS.farm.farmCorruption.hasTattoo("sophie"))
	//{
		//output("\n\n");
		//if (kGAMECLASS.farm.farmCorruption.sophieFullTribalTats())
		//{
			//output("She is covered from head to tail in tribal tattoos, erotic lines snaking all over her naked frame, giving her the look of a barely tamed savage.")
		//}
		//else
		//{
			//if (kGAMECLASS.farm.farmCorruption.numTattoos("sophie") > 1) output("She has the following tattoos emblazoned across her body:\n");
			//else output("She has ");
			//
			//if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] != 0) output(flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] + "\n");
			//if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] != 0) output(flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] + "\n");
			//if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] != 0) output(flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] + "\n");
			//if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] != 0) output(flags[kFLAGS.SOPHIE_TATTOO_BUTT] + "\n");
		//}
	//}

	clearMenu();
	addButton(0, "Next", followerSophieMainScreen);
}


//Sleep With:*
private function sleepWithSophieToggle():void {
	clearOutput();
	if (flags["COC.SLEEP_WITH"] != "Sophie") {
		output("You ask Sophie if she'd like to start sleeping with you at night.  Sophie cocks an eyebrow up at the suggestion.");
		//DEBIMBO'ed
		if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) {
			output("\n\n\"<i>First you turn me into a bimbo, then you give me back my faculties.  Now, you expect me to just jump into bed with you like a brainless bimbo?</i>\" she asks, looking you up and down.");
			output("\n\nYou ");
			if (pc.cor() < 33) output("sheepishly ");
			output("answer that you thought it might be nice to snuggle up with her at night, not even necessarily sexually.  Just having someone to hold during the long, cold nights would be nice, and you admit that Sophie would be a rather lovely body to cuddle up against.");
			
			output("\n\nThe matron smiles at the thought before giving you a big, down-soft hug.  She whispers, \"<i>I'd like that too,</i>\" in your ear while both sets of wings run up and down your body.  Reluctantly, Sophie pulls away.");
			
			output("\n\n\"<i>I'll see you tonight, [pc.name]");
			if (pc.smallestCockArea() <= cockVolume(5) && pc.hasCock()) output(", but don't be surprised if I go a little rough on that tiny dick of yours in the morning");
			output("!</i>\" she calls.");
			if (pc.smallestCockArea() <= cockVolume(5) && pc.hasCock()) output("\n\n<b>If you don't want her to tease you about your small penis, you had better tell her to stop sleeping with you.</b>");
		}
		//NORMAL
		else {
			output("\n\nSophie smiles radiantly and hugs you, her wing-tips fluttering excitedly for a few moments before wrapping around into an even more all-encompassing embrace.  She says, \"<i>That sounds lovely.</i>\"");
			output("\n\nShe separates from you with a happy smile.");
			if (pc.smallestCockArea() <= cockVolume(5) && pc.hasCock()) output("  \"<i>You won't mind me teasing your cute little dick in the mornings, will you [pc.name]?  It's so cute...</i>\" she muses.\n\n<b>If you don't want her to tease you about your small penis, you had better not sleep with her.</b>");
		}
		flags["COC.SLEEP_WITH"] = "Sophie";
	}
	else {
		//Don't Sleep WIth:*
		output("You tell Sophie that you'd rather not sleep with her for now.  She sighs heavily at the proclamation and says, \"<i>");
		if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] == 0) output("Well, it is your bed.  Let me know if you want me coming back for snuggles, okay?");
		else output("Couldn't handle all these curves, huh, [pc.name]?  Don't fret, Momma Sophie will stick around until you can't stop yourself from cuddling up on her.");
		output("</i>\"");
		flags["COC.SLEEP_WITH"] = "";
	}
	clearMenu();
	addButton(0, "Next", followerSophieMainScreen);
}


//vaginal Fuck*
//Needs some mods for when she's in season!
private function fuckFollowerSophie():void {
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	var y:int = pc.cockThatFits2(sophieCapacity());
	clearOutput();
	//In season intro
	if (sophieIsInSeason()) {
		output("Sophie pulls you into her feathery embrace, her fingertips sensually exploring every inch of your form.  Her voice coos huskily, \"<i>So you want to help make a momma out of Momma Sophie, huh?</i>\"  She grabs your hand and stuffs it between her luscious thighs, right into the dripping-wet delta of her mons.  \"<i>Don't keep me waiting... you got me all... hot and bothered...</i>\"");
	}
	//Regular Intro
	else {
		output("Sophie smirks as she saunters closer, fingertips casually exploring your body.  She coos huskily, \"<i>So, you want to have a little fun with Momma Sophie, huh?</i>\"  She spreads her luscious thighs apart, just enough to show you the glittering moisture on her mound.  \"<i>Well, let's see how much of a " + pc.mf("man", "'man'") + " you are...</i>\"");
	}
	//Both
	output("  You strip out of your [pc.gear] without a second thought and present your " + pc.cockDescript(x) + " to Sophie.");
	
	//Small
	if (pc.cockVolume(x) <= cockVolume(5)) {
		output("\n\nShe snickers, \"<i>That little thing is going to fuck me?  " + (!pc.hasVagina() ? "I thought you were a man, but that looks like a little girl-clit!" : "I know you're a herm, but maybe you should just turn that little thing into a proper clit!") + "</i>\"  Prodding your girlish member, she comments, \"<i>It's kind of cute in its own way, though I don't think I'll feel much.</i>\"  Her fingers tickle along the underside of it as she giggles, \"<i>I could just play with this dainty girl-cock all day long...</i>\"");
	}
	//Medium
	else if (pc.cockVolume(x) <= sophieCapacity()/2) {
		output("\n\nShe asks, \"<i>So this is what you want to fuck me with, huh?  It's not THAT impressive.</i>\"  Her hand wraps around your " + pc.cockDescript(x) + ", squeezing it softly until it rises in her palms.  \"<i>Oooh, it does seem nice and virile, though, doesn't it?</i>\"  She strokes the underside and coos to it, watching raptly as you fully erect.");
	}
	//Big
	else {
		output("\n\nShe gasps, \"<i>Well, that's a big, fat cock you've got there, isn't it?  I can see why the younger girls would lust after such a beast.</i>\"  She slowly strokes it, hefting the sizable weight and girth of the member.  \"<i>Such an immense dong...  I bet it's nice and virile,</i>\" she comments as it thickens in her grip.");
	}
	output("\n\nSophie gives your " + pc.cockDescript(x) + " an appreciative swat before pirouetting around, bent over with her hands on her knees and her butt up in the air.  She wiggles back and forth, her lasciviously luscious backside jiggling, the cheeks clapping audibly at the apex of each sway.  Her voice purrs, \"<i>Come and get it, if you think you're " + pc.mf("man","woman") + " enough!</i>\"");
	
	output("\n\nYou prowl forward, but Sophie backs up, wings flapping, her rump pushing right into you.  Her bubble-butt drives you back against one of the many standing stones, pinned between a cunt and a hard place.  Squishing noisily, your " + pc.cockDescript(x) + " slides right into Sophie's ");
	if (sophieIsInSeason()) output("gushing, sperm-hungry");
	else output("slippery");
	output(" cunt.  You moan out load at the sudden penetration and grab onto Sophie's ass for dear life.  Her ass practically devours your fingertips, the expansive backside sinking exquisitely under your touch.  It's a detail you barely have time to register, as most of your attention is riveted on the tight walls gripping you, sliding along with well-practiced sexual skill.  Sophie's hips roll slowly, pinning you against the rock in the most pleasant of ways.");
	
	output("\n\nThe harpy's wing-tips flutter from time to time, perhaps the only sign of how much the matron is enjoying this lewd fuck amongst the rocks, tucked away from view.  She turns her head around  over her shoulder and begins to talk with an unnatural vibration carrying along underneath her words.  \"<i>Oh, [pc.name], don't cum yet.  You CAN'T cum until my pussy does, even if it feels mind-blowingly good - even if it makes your dick feel so good that you can barely hold yourself up.  The pleasure will just keep getting better and better... and better, until you finally get me off.  Then you'll cum so hard you won't be able to walk.</i>\"  She grins mischievously, then moans, biting her bottom lip as she grinds you into the stone.");
	
	if (pc.intelligence() < 35) output("\n\nAbruptly");
	else output("\n\nEven though you know she's using her compulsion");
	output(", her words still affect you.  Her pussy just feels... so... exquisite.  It's so hot and wet that you almost feel like you could cum right now.  Your [pc.legs] wobble, but Sophie just pushes back even harder, holding you up by your " + pc.cockDescript(x) + " and the friction of your [pc.butt] on the boulder.  The harpy watches your expression as her hips continue their slow roll, feeling your fingers twitch and knead her immense backside when the pleasure begins to mount.  You try to stay composed, but it's just so gods-damned good!  Her silken slit is so warm, wet, and just plain... erotic.  Slowly, the point where you would normally orgasm approaches, but instead of the spasming clenches that signal release, your jizz stays bottled up inside you tighter than sperm in a goblin's womb.");
	
	output("\n\nSophie begins to grunt and move more forcefully.  Her slit batters hard up against you as she cries, \"<i>Fuck yes!  Oooh, yeah that feels good.  You're a good " + pc.mf("boy","girl") + ", not cumming just yet.</i>\"  The compelling tone returns.  \"<i>Massage my butt and ");
	if (y >= 0) output("fuck it");
	else output("finger my asshole");
	output(" while I fuck you, [pc.name]!</i>\" she commands, fixing you with her eyes authoritatively.  ");
	if (y >= 0) output("You shift to bring your " + pc.cockDescript(y) + " up in place, just in time for Sophie's wiggling rectum to spread around it.  It slides on in without so much as a whimper.");
	else output("You thumb at her asshole hesitantly, right up until her wiggling rectum presses on it, easily dilating around your invading finger.");
	output("  You squeeze tighter and begin to massage without knowing why, actually able to feel yourself through her thin, internal walls.");
	
	output("\n\nYou're having a hard time focusing on it, though.  Squeezing her bottom by instinct, you slump back with your eyes rolling up into your head, overwhelmed by pleasure.  The boiling heat of your seed is churning within you, just begging to release, but <b>you can't - not until she cums!</b>   Your tongue lolls out as the sensation slowly robs you of your faculties, your only job to worship Sophie's ass with your hands and let her pussy slowly get creamier and creamier around you.  If you could think, you'd be glad this boulder is so smooth, but instead, you simply moan like a whore in heat.");
	output("\n\nThe harpy squeezes her tits suddenly, pinching her own nipples roughly.  Her inner walls begin to convulse, and Sophie squawks in excitement, flapping like crazy.  You're buffeted by the orgasmic wing-twitches, smacked silly by feathers, yet you hardly feel it - that's how focused on her contracting cunt you are.  Sophie's lady-spunk squirts from her swollen slit in a tidal wave.  Tilting back, her gaze seems to say that you ought to be focusing on her asshole, a task made difficult with her twitching body, as she whimpers, \"<i>You're making me cum, [pc.name]!  You're making Momma Sophie cum so HARD!!!</i>\"");
	
	output("\n\nYou shudder from head to toe, feeling like a high-pressure valve was just suddenly, violently wrenched open.  A torrent of bottled-up lust boils out of your [pc.balls] in a slippery wave.  Moaning in orgasmic bliss, Sophie shudders when the hot, white love-juice spatters against her cervix");
	if (y >= 0) output(" and anal walls");
	output(".  Your fingers dig into her plush butt, no longer kneading, but instead curling possessively, claiming absolute ownership of that supple behind and the rapidly-filling cunt below.");
	if (y >= 0) output("  You pack her intestines full of cum at the same time that you sperm up her clingy cunny tunnel.");
	if (sophieIsInSeason()) output("  Her pussy seems to drink the spunky deposit down, her cervix opening to allow in as much in as possible.  You can feel the suction, and if you weren't already riding out a mind-bending orgasm, you're sure you'd be cumming harder than normal right now.");
	output("  Your body slacks over her, the only muscles that are actually working are the ones spasming in your loins, pumping out fresh batches of sperm.  You whimper with primal pleasure, spittle frothing at the corners of your mouth.");
	if (pc.cumQ() >= 500) {
		output("  Sophie's belly ");
		if (pc.cumQ() < 1000) output("has begun to inflate");
		else output("has inflated to an absurd degree");
		output(" due to all the spooge you're squirting");
		if (pc.cumQ() >= 4000) output(" and it's still growing larger");
		output(".");
	}
	if (pc.cumQ() >= 5000 || (pc.cumQ() >= 500 && sophieIsInSeason())) {
		output("  A huge wash of [pc.cumColor] rushes out from her well-sexed fuck-hole, soaking your legs with the mixed cum.");
	}
	output("  Then, you black out, with your " + pc.cockDescript(x));
	if (y >= 0) output(" and " + pc.cockDescript(y));
	output(" still pulsing in ecstasy.  It was such a good cum...");
	processTime(20 + rand(10));
	pc.orgasm();
	//dynStats("sen", -2);
	if (sophieIsInSeason()) sophiePregChance();
	clearMenu();
	addButton(0, "Next", sophieVagFollowerFollowup);
}
	
//[Next]
private function sophieVagFollowerFollowup():void {
	clearOutput();
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	var y:int = pc.cockThatFits2(sophieCapacity());

	output("You're roused a few moments later by a smiling Sophie, the proof of your union dripping between her thighs.  She quips, \"<i>");
	if (sophieIsInSeason()) output("If that didn't take, I don't know what will!");
	else if (pc.cockVolume(x) <= cockVolume(5)) output("Not too bad for a tiny girl-dick!");
	else output("It's always better when you have to wait for it, isn't it?");
	output("</i>\"");
	output("\n\nYou'd come up with a snarky reply, but you're just so fucking tired.  You sigh and try to get dressed, having some difficulty getting on your [pc.feet] until Sophie lends a hand.  She kisses you on the cheek and mouths \"<i>thanks</i>\" before flouncing off, fluttering happily.");
	processTime(4);
	addNextButton();
}

//Blowjob*
//Sucking dicks.
private function sophieFollowerGivesBlowjobs():void {
	clearOutput();
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	
	output("Sophie cocks her head to the side and chuckles, \"<i>You wanna feel Momma Sophie's lips around that ");
	if (pc.cockVolume(x) <= cockVolume(5)) output("tiny clit you call a penis");
	else if (pc.cockVolume(x) <= sophieCapacity() / 2) output("needy boy-cock");
	else output("over-swollen engorgement you call a cock");
	output("?</i>\"  She saunters up with her hips swaying seductively, her juicy mound squelching noisily, webs of lubricant dangling between her thighs whenever they spread.  The harpy's fingertip punches into your chest");
	if (pc.biggestTitSize() >= 1) output(", right between your [pc.chest]");
	output(", and she slowly trails it up to your chin, which she gently grabs in her long-nailed fingers.  \"<i>");
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("You may have given me a bimbo's body and an insatiable need for sex,");
	else output("You may have seduced me into your camp with hot sex,");
	output("</i>\" she coos, \"<i>but that doesn't mean I'll wrap these beautiful lips around you for nothing.  How about you let me use that cute [pc.face] of yours to grind my pussy on, and I'll return the favor?</i>\"  She blows you a kiss that culminates in her running her tongue over her swollen lips in a slow, wet circle.");
	//[Force Her] [Sixtynine]
	clearMenu();
	addButton(0, "Force Her", forceSophieBlowjob);
	addButton(1, "Sixtynine", sophieBlowsSixtyNine);
}

//Blow Sixtynine*
private function sophieBlowsSixtyNine():void {
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	clearOutput();
	output("You nod eagerly, something that gets the busty harpy smiling as her whole body flushes.  She rushes at you, leaping and flapping, speeding towards you faster as old feathers kick up in a wake behind her.  You spread your arms and let her slam into you, the impact cushioned by her weighty breasts and large, soft thighs.  Both of you roll end over end through the dirt, eventually coming to rest with her straddling your [pc.chest] and rubbing a finger through her slippery folds.  She adds another finger to spread them wide, the pink interior pulsing wetly and dripping with female moisture.");
	
	output("\n\nSophie coos, \"<i>Just a few licks on Momma Sophie's twat, [pc.name], and I'll suck you so good that you'll get addicted to having a faceful of harpy cunt.</i>\"");
	
	output("\n\nYou cock an eyebrow in response, but before you can properly answer, the motherly woman is lifting herself up and spinning about, giving you a perfect view of her bodacious heiny before it dips down towards your " + pc.face() + ", the heavy butt-cheeks and thick thighs utterly blotting out the light as the woman's sodden snatch descends towards your mouth.  Her tangy, sweet scent fills your nostrils more potently by the second, until her slippery warmth and feminine odor are dominating your perception.  Her labia spread wide over your nose and mouth as Sophie's supple, curvy thighs clasp over your ears.  You're literally deaf, blind, and mute at this point, yet there's still one way you can communicate at this point - with your tongue.");
	
	output("\n\nSimultaneous to your vaginal ensnarement, Sophie attends to the pressing bulge");
	if (pc.cockTotal() > 1) output("s");
	output(" that ");
	if (pc.cockTotal() > 1) output("are");
	else output("is");
	output(" mounting higher and higher.  She easily pulls [pc.eachCock] from your constraining [pc.gear], testing the girth and rigidity of the swollen shaft");
	if (pc.cockTotal() > 1) output("s, searching for her target of the day.  At last, she settles on your " + pc.cockDescript(x) + ", giving it an affectionate squeeze");
	else output(", giving it an affectionate squeeze");
	output(".  She exhales on it with breath so hot and moist you almost think the blowjob has begun, but when her lips truly meet your [pc.cockHead " + x + "], that notion is shattered by the slippery-sweet embrace.  With your senses so deprived by snatch, smothered in quim, the touch of Sophie's golden cock-pillows on you seems multiplied seven-fold.  Your back arches instinctively, trying to lift your [pc.hips] higher, but the matron's gentle, firm hand pushes you back down.  Her tongue flicks out to dance along the underside of your urethra while her cushiony mouth slips ever-lower.");
	
	output("\n\nYou put your own oral endowment to work eagerly.  It pushes through Sophie's lubricated inner folds with ease, her channel's copious moisture staining your lips with her lust.  ");
	if (pc.hasLongTongue()) output("Longer and longer, your [pc.tongue] continually unspools from your mouth, plunging deeper into the slippery channel with each passing moment.  Her taste saturates your many taste buds, and the velvety folds of her interior feel wonderful as you repeatedly slither your inhuman muscle through that syrupy passage.");
	else output("Your [pc.tongue] slides right in, the harpy's pussy seeming almost like a second home.  Her taste saturates your taste buds as you plunge in as deeply as possible, gliding over her velvet folds as it goes.");
	output("  Sophie's immense thighs squeeze tighter in response, shutting out any last vestiges of light and pushing you harder into her sopping-wet mound.  You let your lower lip graze her rigid clitty and savor the lubricating fluid that she leaks into your waiting mouth.");
	
	output("\n\nHer tongue and yours seem to be the only things that matter anymore.  Hers circles the entirety of your " + pc.cockDescript(x) + ", accompanied by golden lips that leave behind their drugged, amber residue.  The enjoyable tingling that those chemicals induce is driving you wild with desire.  Your heart is hammering like crazy in your chest, each thrumming beat reinforcing the thickness of your erection in the bird-woman's mouth.");
	if (pc.hasVagina()) {
		output("  She tenderly");
		if (pc.balls > 0) output(" reaches under your [pc.balls] and");
		output(" explores your [pc.vagina] with two fingers, her thumb brushing across your [pc.clit] every few seconds.  It seems the harpy is considerate of even your feminine needs - ones that serve to make you even harder, so full it almost hurts.");
	}
	//else
	else if (pc.balls > 0) {
		output("  She tenderly caresses your [pc.sack], allowing her fingers to dance over your [pc.balls].  It seems the harpy is considerate of all your needs in a way that makes you even harder, so full it almost hurts.");
	}
	else output("She tenderly strokes a long nail across the sensitive skin of your taint.  It seems she's being very considerate to your pleasure, so considerate she has you so hard and full that it almost hurts.");
	output("  Her feathery hair dangles over your [pc.legs], tickling you as she noisily slurps and sucks, while you moan directly into her bare-skinned twat.  The vibrations set her dripping even more fiercely than before.  You do your best to dutifully drink it down.");
	
	output("\n\nSophie hums happily as you begin to drip directly onto her tongue, the pre-cum bubbling out of your spit-polished cum-slit in a steady flow.  Though you know just what is plying your " + pc.cockDescript(x) + " with slices of heavenly sensation, your gloss-drugged mind begins to slip into fantasy anyway.  Just like in the real world, Sophie's cunt is slathering your [face] with her fragrant arousal, and your pole is smothered with amber aphrodisiacs.  In the fantasy though, there's a pussy squeezing down on you and a second set of thick harpy thighs clenching around your waist.  Those fertile, egg-bearing thighs are bouncing up and down your length, and the twat above you is ripe with arousal, bounded above by a belly swollen with incubating life that will someday be your daughter.  Every morning you're sucked off to completion by one of your girls and kissed until your lips and rod are slathered to an amber shine.  Then you lie back and partake in the fruits of your position as " + pc.mf("king","breeder-queen") + " of the harpies: creampie after creampie, tangy harpy-cunt to lick, and skilled fellatio every single time your lust begins to flag.  You groan into the slit above, your hands grabbing hold of the juicy haunches and pulling them down into you.");
	
	output("\n\nAn answering cry of pleasure reverberates down your phallus in response, accompanied by a gradually increasing suction that rouses you from the fantasy.  Your [pc.hips] slowly rock to the tempo of Sophie's lip-vacuum, and as you aggressively lick and lap at her ever-wettening box, you realize that both of you are getting closer to orgasm.  Sophie plunges her swollen, cock-sucking lips down your length ");
	if (pc.cockVolume(x) <= cockVolume(60)) output("to the [pc.sheath]");
	else output("as far as she can, gagging slightly");
	output(".  Her thighs begin to tremble around you, hard enough that you begin to worry that she might somehow crush your head, yet it's more like being smothered with soft pads than anything truly worrisome.  You shudder in excitement of your own and begin to flick her clit, eager to make her share in the pleasure.");
	
	output("\n\nTwo simultaneous hums of delight vibrate through both pairs of genitals, matched in perfect, harmonious climax.  Sophie's cheeks bulge as you offer your liquid lust up to her sucking, oral opening.  Her tongue tickles along your bulging urethra as it pumps wave after wave of jizz into the back of her mouth.  She noisily gulps it down, belly gurgling as she tries to keep up with you.  The puffy mound above you spasms around your mouthy movements and releases a wave of tangy harpy-cum, the fragrant, slippery stuff splattering over the whole of your [pc.face] and forcing you to drink deep gulps of musky girl-jizz.");
	if (pc.cumQ() >= 1000 || pc.cockTotal() > 1) output("  Warm goo covers your [pc.hips] and [pc.butt] once your virile deposit becomes too much for Sophie to handle.");
	if (pc.cumQ() >= 500) output("  She quickly gives up on trying to swallow it after she starts showing some cum-pudge, but her hand pumps you energetically as she milks your " + pc.cockDescript(x) + ", squeezing the voluminous ropes of [pc.cum] all over your [pc.chest].");
	if (pc.cumQ() >= 3000) output("  You make a big [pc.cumColor] puddle with all the drippings, sinking into the cummy mud as you eat out the orgasmic harpy matron.");
	
	output("\n\nSophie shakes a few more times, mirrored by your own pleasured undulations.  You lie there, panting into her pussy while she breathily gasps over your tumescent cock.  Eventually, she climbs off of you and helps you up to your feet.");
	
	output("\n\n\"<i>I just knew you'd get off harder once you had a few licks of Momma Sophie's slit,</i>\" the feathery woman coos after noisily swallowing.  \"<i>You should've seen all the blood rushing into your dick... just like now.</i>\"  She squeezes your already-stiff mast once more.  \"<i>Let me know when you want more, though with all the lipstick soaking into this guy... that might be now.</i>\"  Sophie smirks and spins on her heel, swaying her hips with a saucy swagger as she wanders away.  You DO kind of want to go again...");
	//Resets Displeasure Counter
	flags["COC.SOPHIE_FOLLOWER_IRRITATION"] = 0;
	//Slimefeed
	//pc.slimeFeed();
	processTime(15 + rand(5));
	pc.girlCumInMouth(sophie);
	//8 hours lust stick
	luststickApplication(8);
	//+10 lust
	pc.orgasm();
	//dynStats("sen", 1);
	pc.lust(10);
	addNextButton();
}

//Forceful Blowjob*
private function forceSophieBlowjob():void {
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	clearOutput();
	//Increments a displeasure counter - doing enough of these causes her to leave in the night if it gets too high.
	IncrementFlag("COC.SOPHIE_FOLLOWER_IRRITATION");
	output("You grab hold of her and push her down on her knees, a task aided by Sophie's utter, uncomprehending surprise.  She hits the ground, pouting, her thick thighs flexing to try and help her rise.  You scold her - if she didn't want to suck your dick, she shouldn't have moved into your camp.  Instead, she should be glad that you decided to ALLOW her to stay in your camp for a simple blowjob.  Pointing out her oozing snatch, you remind her that she's clearly enjoying this as much as you, and that she ought to just get to work and tend to her own needs while she satisfies you.");
	
	output("\n\nSophie grumbles, but one of her hands does nestle itself down between her feathery thighs, her other going to your groin to fish out your " + pc.cockDescript(x) + ".  She looks up at you through angry eyebrows softened slightly by concealed lust.  \"<i>I'll suck you off... this time,</i>\" she declares, ");
	if (pc.balls > 0) output("fondling your [pc.balls] with almost eager attention,");
	else output("rubbing your length with almost eager attention,");
	output(" \"<i>but don't make a habit of this, or you'll wake up alone.</i>\"  Sophie's tongue flicks across your [pc.cockHead " + x + "] experimentally.  \"<i>At least you taste good.</i>\"  The slippery muscle slides across your sensitive dick-skin again, longer this time, lingering on the underside as the golden lips edge closer.");
	
	output("\n\nImpatient, you slide your fingers through her feathery locks and edge her closer.  Her shining, amber mouth bumps into your [pc.cockHead " + x + "], followed by a surprised chirp from the unresisting harpy.  At that first touch, the electric tingle of her glossy gold lipstick hits you, causing your heart to beat faster and your " + pc.cockDescript(x) + " to thicken slightly with arousal in her hand.  You involuntarily push harder without meaning to, spreading Sophie's plump cock-kissers around the thickening meat, her spit slicking the slow, steady journey into her mouth.  Like magic, she begins to push forward on her own, almost pulling out of your grip in her eagerness.  Her mouth smoothly slides down ");
	if (pc.cockVolume(x) <= cockVolume(60)) output("as far as it can go, even taking you part way into her throat before she runs out of room");
	else output("the whole way to your base, inch after inch of dick-flesh vanishing into her pliant throat");
	output(".");
	
	output("\n\nWith her snug, gold lips clinging around your rod, Sophie looks up with lust-lidded eyes, the noisy squelching that's coming from below leaving no doubt in your mind as to her state.  The burning, lust-fueling make-up that girds her cock-pillows seems to be seeping into you in greater and greater quantities.  It makes your whole body feel flush, burning-hot and ready to fuck her sweet, feathery behind.  You prepare to pull out, until you see those plush golden lips locked in place, sliding with slippery friction along every single inch of your " + pc.cockDescript(x) + ".  You throb powerfully at that sight and flex inside her oral embrace, causing the harpy to churn out a delighted giggle, interrupted by a pleasured moan as she masturbates beneath your maleness.");
	if (pc.cockTotal() == 2) output("  Your extra cock flops against her cheek, catching on her ear and slowly leaking pre-cum into her down-soft hair.");
	else if (pc.cockTotal() > 2) output("  Your extra cocks flop against her cheeks, catching on her ear and shoulder and slowly leaking pre-cum into her down-soft hair.");
	
	output("\n\nSophie abruptly grabs hold of one of her big, motherly tits and gropes herself passionately.  Her lips open just enough to separate from your " + pc.cockDescript(x) + " and exude a lascivious moan as she masturbates herself.  The quivering tongue tickling at your underside is utterly enjoyable, a fact enhanced by the golden gloss now smeared all over your rod.  There's a tingling, pulsating quickening inside you.");
	if (pc.balls > 0) output("  Your [pc.balls] feel almost like they're filling up, taut with liquid weight that begs to pump out");
	else output("  It feels tight, like you're filling up with a warm liquid weight that's just begging to be let out");
	output(" all over the motherly harpy's face.  You groan out loud with sheer excitement and fixate your eyes on Sophie's bodacious rump and thick thighs, partly obscured by her trembling tailfeathers.");
	
	output("\n\nSlobber and drool drip down");
	if (pc.balls > 0) output(" your [pc.sack] and over");
	output(" your legs.  Sophie's eyes roll back slightly - not all the way but enough to proudly display her penultimate pleasure as she cums.  Her syrupy girl-cum splatters off the waste-land earth below, though the sound changes to a wetter, muddy splashing after a few seconds.  Squeezing tightly, the harpy's throat convulses around you.  Her lips lock tight as she hums in ecstasy, languidly beginning to suckle your " + pc.cockDescript(x) + " as her own orgasm dies down.  You force her to move faster, pushing her head to pop back and forth, too eager for release to care for her comfort.  Judging by the steady, squelching pumping that begins anew, she doesn't care that much either.");
	output("\n\nSophie suddenly compresses her gold-lacquered cock-pillows around you and sucks harder.  She flicks her eyes up at you to beg for your cum with a sluttier expression than you thought the harpy matron capable, inaudibly demanding you release inside her.  Your [pc.hips] lurch forward to pound your " + pc.cockDescript(x) + " deep into her face, and your [pc.cockHead " + x + "] tingles, expanding in orgasm.");
	if (pc.hasKnot(x)) output("  The knot inflates just behind her lips, a golden orb that entraps you within her slick mouth and makes sure all your [pc.cumFlavor] cremè is going to go down her throat.");
	output("\n\nSemen jets from your urethra almost immediately, the long lance of jizz spouting right into Sophie's throat where it can dribble down into her belly.  You let your mouth hang open and close your eyes, instantly envisioning yourself surrounded by a brood of harpy girls, most pregnant and kissing you while the others milk your dick with their bird twats, again and again.  The drug-fueled fantasy ensures that your orgasm lasts even longer than it otherwise would, and you continue to erupt slippery spunk straight into Sophie's stomach.");
	if (pc.cumQ() >= 500) {
		output("  She gurgles noisily when her midriff begins to bulge from your liquid deposit");
		if (pc.cumQ() >= 2000) output(", but that's just the beginning.  You bloat her tummy to an obscene, almost spherical shape");
		if (pc.cumQ() >= 4000) output(", and then cum some more, the flooding jizz forced to escape from her nostrils after you finish flooding every inch of her digestive system");
		output(".");
	}
	
	output("\n\nAlmost regretfully, you ");
	if (!pc.hasKnot(x)) output("slip your spasming boner out of her golden gates, dripping the last few drops onto her pouty lower-lip.");
	else {
		output("pull against Sophie's cock-locked mouth, but your knot won't budge.  You sit there waiting for it to go down for what seems like forever, and her lipstick doesn't exactly help - it seems like your [pc.cumNoun] continues to flow and dribble the entire time, your animal-dong intent on inseminating the harpy's mouth.  Still, you manage to 'pop' free eventually, even though it stretches Sophie's jaw and echoes around your camp.");
		processTime(15 + rand(10));
	}
	output("\n\nThe harpy blushes up at you, gulping down the last thick deposit as she continues to masturbate her way to a second breathless orgasm, her tailfeathers quivering as it runs through her.  You tweak one of her tits for good measure before getting dressed and reminding her that she enjoyed it.  Sophie protests through her white-stained lips, \"<i>");
	if (flags["COC.SOPHIE_FOLLOWER_IRRITATION"] == 1) output("Ahhh... not... not as much as... I would if you'd reciprocate!");
	else if (flags["COC.SOPHIE_FOLLOWER_IRRITATION"] < 4) output("Ahhh... I... I don't know how many times I'll put up with this kind of treatment!");
	else if (flags["COC.SOPHIE_FOLLOWER_IRRITATION"] < 8) output("Ahhh... are... are you ever going to reciprocate?");
	else if (flags["COC.SOPHIE_FOLLOWER_IRRITATION"] == 8) output("Ahhh... I think... I've had enough...");
	else output("Ahhh... actually... I think... <b>I think if you don't treat me nicer, I might leave.</b>");
	output("</i>\"");
	
	output("\n\nYou get dressed with a self-satisfied sigh.");
	processTime(15 + rand(5));
	pc.orgasm();
	//dynStats("sen", -1);
	addNextButton();
}

//SixtyNine (* Temp until someone writes dis shit)
//Get that vajajay in yo face.
private function sophieSixtyNine():void {
	clearOutput();
	output("Sophie cocks an eyebrow and asks, \"<i>A little sapphic delight for the horny champion?</i>\"  She snorts and rolls her eyes, \"<i>No thanks.  I'm not really that into girls.</i>\"  It doesn't seem like she's up for it.");
	clearMenu();
	addButton(0, "Next", sleepWithSophieToggle);
}

//Sophie Teases Small Dicks In The Morning*
//No toggles.  If you have a small penis you deserve the small penis femdom.
public function sophieSmallDongTeases():void {
	var x:int = pc.smallestCockIndex();
	output("\n<b><u>As you're waking up that morning...</u></b>");
	output("\nTingly warmth envelops your [pc.oneCock] with supple, soft sensation, wrapping it up tight in pulsing warmth.  A slippery protrusion slithers around your girth, tickling at your [pc.sheath]");
	if (pc.balls > 0) output(" and [pc.balls]");
	output(" before lavishing its slickness along the underside.  You get so stiff - so hard - in just seconds, " + pc.cockDescript(x) + " swelling to try and fill the slick prison, but no matter how hard you get, that compressing cavern still seems so much larger and more capable than the small penis that it has to contort itself around.");
	output("\n\nAbruptly, your lusty erection is removed from the heated embrace and left cold and wanting.  You shiver in your bed, still not quite woken, at least not until a playful flick slaps the " + pc.cockDescript(x) + " as it pulsates, just hard enough to be noticed without pain.  You start to jolt upright, but are immediately pushed back down by a taloned footclaw pressing down on your shoulder.  You catch a view of feathers and gigantic breasts - it must be the harpy matron, Sophie, come to play with you in the morning.");
	if (pc.physique() >= 40) output("  You could force her off you if you wanted, but you didn't bring her to bed for nothing.");
	output("  Her fluffy behind crashes down on your [pc.legs], just below your waist.  With a familiar coo, she places her other foot on your chest");
	if (pc.biggestTitSize() >= 1) output(" and squeezes your " + pc.breastCup(pc.biggestTitRow()) + " breast roughy.");
	else output(" and lets the talons dig into your " + pc.skinFurScales() + " just enough to hurt a little.");
	
	output("\n\nSophie licks her shining lips as she looks down at the little spit-soaked pole that's twitching between her legs, just inches away from her pussy.  \"<i>Oooh, does Momma Sophie's favorite girl" + pc.mf("-boy","y-girl") + " want her little bitch-stick played with?</i>\"  She touches it, right below the [cockHead smallest], her warm fingertip sliding in slow, sensuous circles until you begin to twitch at her touches.  \"<i>You know what I think?</i>\" she purrs, bending over to look you face to face- an amazing feat of flexibility considering her foot is locked on your shoulder.  \"<i>I think you like it when I play with this tiny girl-cock.  I think some depraved, sick, nasty part of your brain makes you cum harder when I tease you about how feminine this bitch-cock is.</i>\"");
	
	output("\n\nYou vehemently shake your head, denying her accusations, even though your erection seems to be growing even more tumescent than before.  It's almost painfully hard by this point.  ");
	if (flags["COC.TIMES_MORNING_SOPHIE_FEMDOMMED"] > 0) output("In the back of your mind, you know that if her words weren't true you wouldn't have kept sleeping with her and letting her do this to you.");
	else output("In the back of your mind, you almost have to wonder if it's true, or if her lipstick is just now getting into your system...");
	
	output("\n\nPumping your cock now, Sophie plants a quick kiss on your lips and leans back, teasing, \"<i>Puhlease!  If you didn't like this, you wouldn't be dripping all over my fingertips and shuddering every few seconds.</i>\"  She takes her hand away and fixes her gaze on your small, rebellious erection.  It bounces back and forth like a tiny metronome until Sophie crosses her legs, placing a foot on each of your shoulders.  Her thighs scissor shut like an immobilizing vice, which has the unfortunate effect of causing your slippery boner to twitch hard enough to slide against the smooth skin, gaining the friction it so craves and spurring it to bounce harder.  Your [pc.hips] make weak, half-humping motions against her despite your efforts to control yourself.");
	
	output("\n\nSophie checks her nails while you grind yourself against her, until one of your movements is actually enough to shake her bodily.");
	
	output("\n\n\"<i>Oh?  I thought you didn't like me humiliating your pathetic little erection?</i>\" the bird-woman says, over-exaggerating her feigned surprise.  \"<i>You know, I've always been partial to dicks like this - little, sensitive ones.  They always seem to pop riiiiight when my pussy presses up against them.  The best ones even cum before then, spurting all over themselves just when they think they're gonna get to cum inside me, ha!</i>\"  Her gash has begun to drip all over your [pc.legs] by this point.  It's quite clear that every word is turning the harpy on as well as you, even though she has yet to begin touching herself.");
	
	output("\n\nYou catch yourself wondering if you're going to cum that easily for her and waste your spunk over your own belly instead of getting to creampie inside your feathery mistress's quim.  Sophie sees your indecision and sticks a finger into her crotch, coming up with her finger wreathed in her musky fluids.  She smears it across your forehead, down the bridge of your nose, and then on each of your cheeks, forcing you to smell her odor with every breath, your face marked with pussy.");
	
	output("\n\nShe titters, \"<i>There we go.  I think that smell is good on you, way more fitting than whatever dick-musk this can put out.</i>\"  She smears the wet finger across your [pc.cock " + pc.smallestCockIndex() + "], getting you to moan without meaning to as you bubble out another trickle of pre-cum.  The harpy suddenly clenches her thighs to grip your erection tight, and she laughs, \"<i>You look so fucking happy, you little slut.  Is that it?  You want to be pinned under a sexy girl and denied even a good look at her pussy, barely able to oogle her tits while she smears you with her cunt-juices and laughs at how poorly-endowed you are?</i>\"  Your eyes flick to her nipples without meaning to.  They do look mighty nice, and the throbbing heat between your [pc.hips] intensifies simultaneously.");
	
	output("\n\nSophie pulls herself a little further up, almost bumping you with her pussy.  \"<i>Now, I'll get to see what kind of girl you are- a slut who cums all over herself just from a little pussy-breath, or one that spurts from a brush with my soaked lips.  Which is it?  You <b>WILL</b> cum from one, my messy little squirt-girl...</i>\" she promises, staring into her eyes as she slides closer.");
	
	output("\n\nThe warmth around you seems to double, moisture beading on your [pc.cock " + pc.smallestCockIndex() + "] from the foggy lust within Sophie's thigh-canyon.  She slowly spreads her legs until they're split almost horizontal, hanging off of you to either side, her moist vulva closing in on you with each passing second.  She mouths, \"<i>You can cum, if you want to be a total bitch...</i>\"  Her hands hook onto the slippery skin and spread her passage wide, so close to you that your petite maleness can practically taste the pussy.  You throb in painful pleasure and wonder if this is it...");
	//{Low Sensitivity}
	if (pc.willpower() / 5 + rand(20) + 1 > 20) {
		output("\n\nEven though you're so hard, so very very hard, climax eludes you.  A small part of you wonders why you couldn't cum and be Sophie's bitch, yet you hastily dismiss it, focusing back on her breasts.  Sophie smiles tauntingly, smooshing her bouncy bosom together to give you a better view as she taunts, \"<i>Awww, your delicate boner must not be trained well enough.  Still, you look so close, and I'm sure a submissive slut like you will cream the outside of my nether-lips once I touch you...</i>\"  Her voice rings out, erotic and compelling, \"<i>Can't you feel the pressure in your [pc.balls]?  All that cum just ready to burst out across my slick pussy?  It must be so hard to hold in, and your weak erection can't possibly keep all that slutty, submissive cum inside you for long, right?</i>\"");
		
		output("\n\nSophie slides her hips closer, just barely avoiding a sensuous brush across your [pc.cock " + pc.smallestCockIndex() + "].  You whine plaintively, feeling that upwelling jism inside, her hypnotic compulsions bending your perceptions to plant you right atop the peak, right on the edge of submission.  She coos, \"<i>Not yet...  I'll let you cum, but only after you beg me to touch your pathetic dick.  Beg!  Say, 'Please Momma Sophie, touch my slutty cock!'  <b>Do it!</b></i>\"");
		
		output("\n\nNearly crying from how pent up you are, you comply without thinking, only wanting release- to feel her juicy, slobbering snatch against you as it grants orgasm, \"<i>Yes!  Please, Momma Sophie!  Rub my slutty cock!  Touch it, make it waste its seed on you!  Anything, just let me cum!</i>\"");
		
		output("\n\nRubbing her chin, the harpy matron slowly begins to nod.  \"<i>Not bad, though maybe next time I'll put some makeup on you first, to complete the experience.</i>\"  She flicks your boner again and asks, \"<i>Are you ready?</i>\"");
		output("\n\nYou bite your lip and nod eagerly, nearly cumming from that single touch.  Your ");
		if (flags["COC.UNKNOWN_FLAG_NUMBER_00282"] > 0) output("golden");
		else output("pink");
		output("-haired mistress looks down at you graciously as she inexorably slides closer, and you find the intense anticipation is almost a pleasure all its own.  Then, her feverishly-warm delta contacts your sweating cock-skin, the sweet sensation of her juicy snatch against you too much to endure.  Your dainty cock dilates as wide as its diminutive girth will allow, and as you meet Sophie's knowing smile, you moan and release, spraying sperm against her plump clit and [pc.belly], most of it deflecting around and over her moist lips in a spray of syrupy white.");
	
		output("\n\nSophie moans with you, and her hand dives down into the fountain of spermy stickiness, spreading it over her sensitive nub as she begins to masturbate.  She pants, \"<i>Cum, little slut!  Cum for Momma Sophie!  Mmmm, yeah, right there!</i>\"  Her fingers circle faster and faster, frothing your semen into a bubbly mess, one you're more than happy to keep adding to.  The domineering harpy screams after a few seconds, grinding her hips slowly along your [pc.cock " + pc.smallestCockIndex() + "], barely caring when some of your [pc.cumVisc] cream slips into her.");
		if (pc.cumQ() >= 500) {
			output("  You cum so much that both you and Sophie wind up");
			if (pc.cumQ() < 1000) output(" with huge wet spots over your bodies");
			else output(" soaked from the waist down");
			output(".  It feels so good that neither of you mind.");
		}
		if (pc.cumQ() >= 2000) output("  Your bed is a reflective, [pc.cumVisc] [pc.cumColor] as well, practically a lake of seed by now.");
	}
	//{High Sensitivity}
	else {
		output("\n\nWithout warning, a wave of pleasure races through your midsection, culminating in an explosion of excitement.  A single drop of white drips from your tip, before the muscular contractions racing through your form hit their peak and launch a fat glob of cum right onto your [pc.chest], the next arcing high enough to hit your face.  Sophie shifts position mid cum-gasm, planting her plush, excited labia around your small cock and feverishly grinding back and forth, jilling her clit against your spasming urethra as it distends with each load of jism.  The heated pressure pushes your cock down, and the remaining spurts all deposit themselves across your belly in messy spurts");
		if (pc.isPregnant() && pc.bellyRating() >= 30) output(", rolling off the pregnant dome you call your tummy");
		output(".");
		if (pc.cumQ() >= 500) output("  You cum for what seems like hours, emptying your [pc.balls] onto yourself, every drop of wasted seed a testament to your pussy-whipped status.");
		if (pc.cumQ() >= 1000) output("  A puddle of jizz forms around you before long, mixing with the drippings from her pussy as she rides you into your own soaked bedding.");
		output("  When you're about empty, Sophie says, \"<i>Spurt all that nasty boy-cum out for me, then you can be my lady-pet.</i>\"  Your orgasm redoubles, surging to lance out several more long, thick dribbles of pleasure onto your soaked middle.");
		
		output("\n\nOnly after your orgasm concludes does the harpy finally climax, shuddering atop you and drenching your poor, teased-out cock with her girl-cum.");
	}
	//{BOTH END HERE}
	output("\n\nThe older harpy giggles, when it ends.  \"<i>I love sensitive " + pc.mf("lady-boys","girls") + " like you...  You let me feel so powerful...</i>\"");
	
	output("\n\nSophie suddenly leans down to hug and snuggle against you, whispering, \"<i>Thanks for indulging my fantasies, [pc.name].</i>\"  She departs with a sexy wiggle, off to find some breakfast.");
	
	output("\n\nYou get up with shaky [pc.legs] and try to clean up the ");
	if (pc.cumQ() >= 1000) output("huge ");
	output("mess you made, wondering why you enjoyed that so much.");
	
	IncrementFlag("COC.TIMES_MORNING_SOPHIE_FEMDOMMED");
	processTime(40 + rand(10));
	pc.orgasm();
	//dynStats("lib", -1, "sen", 3);
	pc.slowStatGain("l", -1);
	addNextButton();
}

//Alert Message For Going Into Season☼
//Similar to bimbo sophie
public function sophieFollowerGoesIntoSeas():void {
	output("\nWhenever you look towards Sophie, she seems to be trying to grab your attention.  She gives you small touches whenever you're close to her, apparently without any excuse for it, always trying to get a touch of your bulge and your [pc.cock " + pc.biggestCockIndex() + "] when you're close enough.  She smells like smoked lust, too, and when you're too far from her to touch, she looks to you with a gleam in her eyes, spreading her lower lips, puffier and more enlarged than usual.  When she notices you looking in her direction when behind her, she instinctively bends, accentuating the curves of her jiggly ass and showing off her pussy.");
	output("\n\nThere's no mistaking it - Sophie wants to breed.\n");
}

//Sophie Fertility Done (Expired or PC lost cock):*
public function sophieFertilityExpired():void {
	output("\nSophie seems to have lost most of her unusual interest in you, and although she's sensual and provoking as usual, she no longer seems so hyper-focused on getting a cock in her pussy.  It appears her season, heat, or whatever, is gone for now.\n");
}

//Sophie Fertility Knocked Up*
public function sophieFertilityKnockedUpExpired():void {
	output("\nSophie rubs her abdomen periodically and smirks or smiles, especially when looking at you while doing it.  She's a bit messy after the helping she got from you, but seems to care less about her looks and more about the results of your 'intervention', her eyes a bit dreamy as a finger reaches her mound, seeking your fluids.\n");
}

//{I'll write the special thingy this evening (a couple of hours from now on), it's basically Sophie femdomming again, starting with a blowjob and a premature ejaculation once she inserts the PCs cock. Of course, she continues after that. - Ven }
//[special]
private function sophieSpecial():void {
	clearOutput();
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) pc.smallestCockIndex();
	output("\"<i>Ahhh, so you do want a bit of Momma Sophie's special treatment... such a brave " + pc.mf("boy", "girl") + ", aren't you?</i>\" She leans in closer as she starts to get rid of your [pc.gear].  \"<i>Very brave... we might have to put you back into place.  Momma Sophie will milk this " + pc.cockDescript(x) + " until the only thing that even allows you to cum anytime in the future will be the fact I drugged you with my lipstick.</i>\"");
	
	output("\n\nSlowly, she sinks to her knees, fishing out your " + pc.cockDescript(x) + " from your [pc.gear], licking her lips eagerly.  \"<i>First, we cover it with a lot of my special lipstick, so you'll stay hard no matter what.  That, and, well, so you can't resist when Momma Sophie wants you to squirt.</i>\"");
	
	output("\n\nIndeed, her plush golden lips wrap about your " + pc.cockDescript(x) + ", slathering it with both her saliva and lipstick as she bobs her head up and down on your member, causing it to become painfully hard as you thrust your [pc.hips] instinctively, seeking more of this delicious mouth.  She grumbles, displeased at you moving and tries to hold you in place by grabbing your [pc.ass] and trying to hold you in place; however, this proves to be rather uneffective as you begin to shake from her oral assault, her tongue licking up and down your " + pc.cockDescript(x) + ", covering it completely in a mix of slutty spit and drugged lipstick... as a matter of fact, you feel light in the head");
	if (pc.balls > 0) output(", and your [pc.balls] are just waiting to unload a virile, sticky package down her throat");
	output(".  Sophie seems to sense it and chuckles, pulling her mouth off your " + pc.cockDescript(x) + ", causing you to whine as you seek out her mouth again.  \"<i>There, there, my little cum pump.  Momma Sophie wouldn't be so mean as to leave you and your ");
	if (pc.cockVolume(x) <= cockVolume(5)) output("squirting clitty");
	else if (pc.cockVolume(x) <= cockVolume(30)) output("needy boy-cock");
	else output("giant piece of a meat rod");
	output(" without blowing a nice big load. It just can't go in my mouth... and you should be nice and compliant, not doing things on your own.</i>\"");
	
	output("\n\nYou feel Sophie simultanously push at your [pc.chest] and pull at your [pc.legs], causing you to slowly move down on your back, as you realize your [pc.gear] has apparently disappeared in the meantime.  The confident harpy matron smirks and giggles while stepping over your body and showing you her plump, jiggly ass as her wet pussy lowers towards your " + pc.cockDescript(x) + ", eager to devour it.  With a wet squelch, you're buried inside her and shuddering beneath her big, wobbly ass.  \"<i>My, my... you really can't hold it in at all, can you? I've barely even put you inside me and you're already so eager to paint my walls white that you're simply going to squirt straight away?</i>\"");
	
	output("\n\nYou're not able to recognize if there's a command behind those words, but with a loud moan, you simply discharge the contents of your ");
	if (pc.balls > 0) output("[pc.balls] and ");
	output(pc.cockDescript(x) + " inside Sophie's schlong-milking passage, causing her to moan in satisfaction as the first of your virile cum hits her inner walls.");
	if (pc.cumQ() < 250) output("  She milks you for all you're worth.");
	else if (pc.cumQ() < 750) output("  She whimpers at how much you've discharged into her.");
	else if (pc.cumQ() <= 1500) output("  Your cum soon gushes out into a small puddle from her pussy and onto your [pc.hips].");
	else output("  Her ass is suddenly pushed out more towards you, cum gushing out of her wet cunt as she starts inflating from the sheer amount of cum in your first load.");
	
	output("\n\n\"<i>Good " + pc.mf("boy","girl") + " with a nice, obedient ");
	if (pc.cockVolume(x) <= cockVolume(5)) output("clitty");
	else if (pc.cockVolume(x) <= cockVolume(30)) output("pretty cock");
	else output("humongous cunt-stretcher");
	output("... all for me... but you can't go soft, can you?  You just want to squirt more of your virile cum into Momma Sophie.</i>\"  Sophie rolls her hips atop of you, her jizz and girl-cum slickened ass hitting against your pelvis as she ruthlessly uses your overly sensitive " + pc.cockDescript(x) + ", going from the tip to the base as she bounces atop of you.  The drugged lipstick and her constant, magic-powered demands don't allow you to go soft even for a moment as she rides you to completion, her hand working between her thighs at her own clit all the while when finally her pussy grips hard at you, causing you to thrust your hips and moan from sheer sensitivity, unable to achieve another orgasm so quickly.");
	
	output("\n\nWith a grin, Sophie rises from your " + pc.cockDescript(x) + ", ");
	if (pc.cumQ() < 250) output("her pussy dripping your cum down onto the ground");
	else output("your own semen drowning your [pc.hips] and [pc.butt] in a messy cum-puddle as it drips out of her");
	output(", and turns towards you, jiggling her tits right above your [face] as she bends over you, asking, \"<i>Now, wasn't that fun, [pc.name]?  You think we should end now, shouldn't we?  Or do you want to give momma Sophie more of your thick cum so she's definitely pregnant twice over?</i>\"  Drugged and fucked to the edge of your sense of self-worth, you practically beg her to put you inside her again, your golden-tinted member standing proudly in the air, waiting for her hips and pussy to descend.  \"<i>Good answer, very good answer.</i>\"  She descends upon you again, rubbing her pussy against the tip of your " + pc.cockDescript(x) + ", teasing both herself and you before drawing you inside and hilting you down to your [pc.sheath] into her!");
	
	output("\n\nSophie's wet pussy is like heaven after being separated from it.  With her lipstick making your member so sensitive and so itching with want and her breasts bobbing over your head, they prompt you to grab them as she bounces atop of you.  \"<i>Ohhh, my cutie wanted to play with Momma's breasts!  Too bad Momma is too intent on fucking this cutie's ");
	if (pc.cockVolume(x) <= 5) output("dainty little fem-cock");
	else if (pc.cockVolume(x) <= 30) output("nice, sweet cum-squirter");
	else output("immense, gorgeous beast of a cock");
	output(" until it's almost broken!  Come on you sweet thing, you know you want to squirt it in me like you're a broken faucet!</i>\"");
	
	output("\n\nWith a grunt, you manage to withhold from her command, and Sophie coos with delight at your resistance.  \"<i>Look at my " + pc.mf("boy","girl") + ", all grown up now, resisting the pleasures of Momma Sophie's fertile, cum-thirsty cunny!  You shouldn't do that... though, maybe we could cum together if you do... Okay, baby, once you feel Momma Sophie's pussy squeeze you extra hard, you will cum and you won't try to hold back, okay?</i>\"  You grunt and nod, but already find it hard to hold back when you imagine how Sophie will look knocked up with your kids. Once you cum inside her a second time, there's probably no way it won't hold.");
	
	output("\n\nYou hear Sophie's shlicking vagina swallow your entire " + pc.cockDescript(x) + " and release it repeatedly, her hips and soft, plump ass bouncing off of your [pc.legs] as she continues to fuck herself on your " + pc.cockDescript(x) + " harder and harder.  The way her inner folds lap and massage at your drug-infused cock is exquisite, and it takes every ounce of willpower to indeed stop yourself from cumming inside her repeatedly like you were broken down there.  Finally, Sophie slaps her hips into your hardness, moaning out loud as her cunt squeezes and tugs at your member violently, temporarily stopping the flow of cum out of your " + pc.cockDescript(x) + ", but only for a split second.  It churns and boils in your [pc.balls], raising through your " + pc.cockDescript(x) + " to be fired into Sophie's wet, ravenous cunt and baby-wanting womb.  Sophie's own orgasm and yours blend into one and prolong one another as you release ");
	if (pc.cumQ() < 250) output("several ropes");
	else if (pc.cumQ() < 750) output("a large, chaotic stream");
	else if (pc.cumQ() < 2000) output("wave after wave");
	else output("massive amounts");
	output(" of cum into her, causing her to ");
	if (pc.cumQ() < 500) output("moan in satisfaction");
	else if (pc.cumQ() < 1000) output("groan as her cunny is unable to hold it all");
	else if (pc.cumQ() < 2000) output("stretch atop of you, a cum-filled tummy added to the jiggling tits and soft butt");
	else output("erupt your cum violently around your shaft as you stretch her to pregnancy-looking visage with your cum alone");
	output(".");
	
	output("\n\n\"<i>Ahhh... ahhh... good " + pc.mf("boy","girl") + "... very good... I'm definitely a momma now.  But... buuuut... You should squirt out more just to make sure... and as punishment for trying to resist when Momma Sophie ordered you to cum!</i>\"");
	
	output("\n\nYou squeal, unsure if in joy or in peril, or from the sheer sensitivity of your fuckstick as Sophie's cunt takes you down to the hilt again.");
	
	output("\n\nIt feels like you're drowning in liquid... but it's way too sticky, her vaginal muscles clenching around you as you're treated to a faceful of boob when she roughly pushes your face against them, her cunt picking up where it left. Your " + pc.cockDescript(x) + " is sore and sensitive, and you definitely already shot out everything you've had, but the harpy's lipstick and her sheer lust for being impregnated seem to keep you going. You almost black out from being suffocated in her breasts, but every few loud smacks she pulls you away for a while, letting you breathe while her breeding passage sups at your erection, drinking your pre and the remains of cum from your urethra greedily, seeking to slowly build another orgasm in you.");
	
	output("\n\nYou feel Sophie's lips on your own before she coos in your ear, enticing you to keep going and to cum together with her again.  \"<i>Hold it in for a while... just let me have my fun, dear... and I will let you cum again.  Yes, you should cum as soon as I do.  Don't worry, you breeding me got me so horny it won't take long... and your sensitive, tormented");
	if (pc.cockVolume(x) <= cockVolume(5)) output(" clitty");
	else if (pc.cockVolume(x) <= cockVolume(30)) output(", pretty cock");
	else output(", humongous cunt-stretcher");
	output(" is probably ready to blow another load very soon, isn't it?  You just can't keep up with Momma Sophie's exquisite pussy, you have to keep cumming and cumming over and over again.</i>\"");
	
	output("\n\nYou nod desperately, realizing that indeed, you're unable to pull out or stop before you orgasm again.  The only thing stopping you is her request for you hold it inside until she can cum too, somehow stopping you from flooding her insides with whatever remains in your [pc.balls]; you don't think you have much cum left to give, though...");
	
	output("\n\nSophie forces you to suck on her now hard nipples as she hilts you inside herself, her plump ass warming your [pc.legs] every time it slaps against you or rests atop you for a bit of gyrating.  After a while, Sophie reaches out between her legs, starting to fondle her clit, her passage tugging and massaging your cock as she seems to approach her own orgasm.  \"<i>Just... a little... bit... more!</i>\"");

	output("\n\nShe says that, but every lift and fall of her hips is a torture on your thoroughly milked, overly sensitive " + pc.cockDescript(x) + ".  Her pussy is trying to draw out every drop of fluid you have in your body, and soon, it will succeed at doing just that it seems...");
	
	output("\n\nAfter what feels like an eternity of torturous schliking and slurping noises from her cum-filled cunt, grappling with and tugging on your lipstick-laden member, Sophie finally reaches her second orgasm, moaning out loud as your dam breaks as well.");
	if (pc.cumQ() < 250) output("  You only drop a meager few squirts inside of her");
	else if (pc.cumQ() < 750) output("  Even your large cum production can't keep up with that pace");
	else output("  Inhuman as your cum factories are, you're only capable of delivering a few big spurts before it slows to a dribble");
	output(".  You thrash and moan and shudder under her, calling her name as she strokes your [pc.hair] and coos, pressing her nipple against your mouth again.  \"<i>Shhh... you've done well for me, little cum-pump... give it all to Momma Sophie... It'll be over in just a moment...</i>\"");
	
	output("\n\nIndeed, the intensity of her cunt quivering and pulsing around your cum-spewing member is too much and you black out for a moment, waking up with her tit in your mouth, your fingers in her cunt as she drips your cum everywhere.  She's still stroking your head as she cuddles up to you, possessively.");
	
	output("\n\nYou feel like you may need to rest a few hours.");
	processTime(40 + rand(20));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	if (sophieIsInSeason()) sophiePregChance();
	addNextButton();
}

//Regular Sophie Follower
//Requirements: Fuck Sophie five times without pissing her off
//Initial Intro
public function sophieFollowerIntro():void {
	output("<b><u>Something unusual happens this morning...</u></b>");
	output("\nYou're drifting along a wonderfully warm river, hand firmly grasping your crotch as you think about all the sexual encounters you had with that wonderfully sexual Sophie.  Her haughty, mature attitude seems to tickle you in just the right way, and if it were up to yourself you'd have the Milfy matron bouncing on your dick every hour of the day.  Speaking of which, your journey down the river seems to be getting rockier the more you think about your sophisticated sexual partner.  Rocking harder and harder, you suddenly realize that you have no idea as to why you're floating down a river in the first place...");
	output("\n\n\"<i>Fuck me hard, darling!</i>\"");
	output("\n\nYou snap back into reality, waking up to find the object of your obsession bouncing gleefully on your exposed groin.  Her tousled hair jumps around with every plunge of the bird-woman's heavenly thighs.  She quickly notices your stark awakening, and blushes hard while she tries to remove herself.");
	
	output("\n\n\"<i>Oh shit - dear, it's hardly what you think.  I've just always been the one to capture young men to bone me raw, but ever since you've come along, all I can think about is your cock!  Oh and you, of course.  Please don't get mad darling, it was hard enough to try and find this place, and-</i>\"");
	pc.lust(10);
	//Plus lust!
	//[Kiss Her][Get Out]
	clearMenu();
	addButton(0, "KissSophie", kissSophieRecruitment);
	addButton(1, "Get Out", getOutSophieRecruitment);
}

//Get Out
private function getOutSophieRecruitment():void {
	clearOutput();
	output("Invading your camp is one thing, but Sophie's overstepping her boundaries by thinking she can get sex from you whenever she wants.  You push her off of your body, standing up to announce that you'll get sex when you need it, not when she desires.  The poor bird nods feverishly, completely embarrassed by the entire ordeal.");
	output("\n\n\"<i>Absolutely dear, let's never speak of this again.  I'll be off now.</i>\"");
	output("\n\nWith that, she darts above the camp, flying back to her home in the high mountains.  You were having such a nice dream, too.");
	pc.lust( -5);
	flags["COC.NO_PURE_SOPHIE_RECRUITMENT"] = 1;
	processTime(4);
	addNextButton();
}

//Kiss Her
private function kissSophieRecruitment():void {
	clearOutput();
	output("You shut her up the best way you know how - planting your lips upon her own, knowing full-well of the effects of her lustful lipstick.  Sophie returns the gesture, locking her tongue around yours while she tastes you, grinding her other set of lips against your attentive member.");
	
	output("\n\nYou take a hold of her motherly hips, guiding them up and against your hardening rod.  Sophie's fine with allowing you to take the reins, leaning down to press her beautiful bosom against your [pc.chest].  Lifting her ass up, you slap it back down against your pent-up cock");
	if (pc.cockTotal() > 1) output(", your second one sliding up between her butt");
	if (pc.cockTotal() > 3) output(" while the others press against her");
	output(".  Sophie cries out in pleasure, almost waking up the entire neighbourhood - which would be a bad thing, considering your neighbours.  You quickly take another taste of her lips, shutting her up while you start to pound upwards into her hungry quim.");
	
	output("\n\nYour ravenous glans presses against the tight confines of your feathery matron, squeezing against her velvet walls with every push of your [pc.hips].  The rose-colored harpy rests herself against you, gently whispering cries into your ear as you focus all your carnal attention on the bouncing hips in front of you.");
	output("\n\nThe two of you slump back, exhausted over a good night's sex.  Sophie lies in your arms, twirling her finger around your chest.");

	output("\n\n\"<i>You've got a cute set up here, sweetheart.  I don't mind moving away from all those harpies, if there was the possibility that I could stay here with you.</i>\"");
	pc.lust(20);
	//[Sure][No] – Note: [No] leads to the [Get Out] scene.
	processTime(7);
	clearMenu();
	addButton(0, "Sure", sophieRecruitmentFinale);
	addButton(1, "No", getOutSophieRecruitment);
}
	
//If Sure
private function sophieRecruitmentFinale():void {
	clearOutput();
	output("Sophie gives you a peck on the cheek, removing herself from your body to prepare for flight.");
	output("\n\n\"<i>I'm so glad.  I haven't felt this young in quite a while - I'll move in before you know it!</i>\"");
	output("\n\nWith that, the milfy matron lifts her wings to head straight for the high mountains, returning not long after with her few belongings.");
	
	output("\n\n\"<i>I know you're probably busy championing and all, so I'll try and stay out of your hair.  Just be sure to show Momma Sophie some sugar, okay?</i>\"");
	
	output("\n\nYou nod and welcome her to your camp");
	if (companionsCount() >= 3) output(", sure to introduce her to the other denizens along the way and smooth over any ruffled feathers before things escalate.  Sophie does a good job helping with that.  She seems to have a natural ability to defuse angry situations, something she attributes to raising her many daughters");
	output(".");
	output("\n\n(<b>Sophie is now available in the followers tab!</b>)");
	flags["COC.SOPHIE_RECRUITED_PURE"] = 1;
	processTime(16);
	addNextButton();
}

/*Sophie daughter incest.  scenes
vaginal, maybe anal.
daughter 1: Big soft, sensitive lips, very large breasts.  
daughter 2: Huge round ass, very long feathers
daughter 3: Average harpy body, human feet
daughter 4: Body as curvy and voluptuous as sophie, very soft wings.

all purpose vaginal and anal sex scene, with modifiers for each daughters body type

intro for all scenes*/
internal function sophieIncestInHerCooterOrSomethingIDunno():void {
	clearOutput();
	output("Approaching the harpy nest you call out for one of your daughters.  ");
	if (flags["COC.SOPHIE_ADULT_KID_COUNT"] > 1) output("The prospect of their " + possessive(pc.mf("father", "mother")) + " attention causes a small scuffle to break out between your feathery daughters. Thankfully, the small fight is soon ended and one of your daughters flies down and stands before you.  ");
	else output("Your daughter, hearing your call, is more than happy to come to you.  ");
	output("The curvy girl smiles at you, her eyes bright and attentive, positively sparkling with the taboo affection she holds for her beloved daddy.  Smirking to her you give her an appraising look, your eyes wandering up and down her beautiful womanly body.");
	
	var daughterCap:int = flags["COC.SOPHIE_ADULT_KID_COUNT"];
	if (daughterCap > 4) daughterCap = 4;
	daughterCap = rand(daughterCap);
	
	if (daughterCap == 0) {
		//[first daughter: 
		output("\n\nYour busty bimbo of a daughter poses for you, pushing her massive mammaries out and blowing you a kiss, showing off her body's tremendous assets.  Lifting her hands, she pushes her soft pillows up before releasing them, letting them enticingly bounce and sway before your eyes.  Not able to wait a moment longer, she bounds over to you.  Her creamy cleavage shakes and jiggles like jello with every step until she wraps her arms around you and presses them against you, her marshmallow-like chest spilling over you as she tries her best to entice you into her nest, ");
		if (flags["COC.DAUGHTER_ONE_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("\"<i>Like, how do I look, " + pc.mf("Daddy", "Mommy") + "?  Aren't my breasts so totally soft?  Don't you just want to suck and squeeze them?  Ooohhh!  " + pc.mf("Daddy", "Mommy") + ", can you please touch me?  I want you so bad!  My pussy gets sooo wet when I, like, think about you pounding my cunny!</i>\"");
		//normal speech:
		else output("\"<i>Don't you like how big and soft my breasts are, " + pc.mf("Daddy","Mommy") + "?  Don't you just want to squeeze them and suck on them?  Ooohh, " + pc.mf("Daddy","Mommy") + ", please, I want you so bad.  I get so hot and wet when I think of you!  I just want your [pc.cock] inside me, pounding my hot cunt until I scream!</i>\"");
		
		output("\n\nWith such soft, gropable breasts pressing against you and your daughter, so very willing to let you touch them, even begging for you to touch them, how could you ever resist the incestuous temptation?  Reaching down, your hands spank her voluptuous ass, forcing a bird like tweet from her plump, pillowy lips.  Leaning in, you kiss those soft, pouty cock-pillows.  The sensation of your lips against those tender, sensitive lips pulls a deep moan from your daughter, her lips seeming to be just as sensitive as her hot, wet cunt is sure to be.  You slide your hands from her round harpy butt to her massive mammaries, your fingers sinking into the soft, plush flesh as if they were made of the finest mousse.  Squeezing and groping, you go to town on her breasts as you kiss her forcefully, your lips, tongue and hands teasing the most sensitive parts of your daughter's body.  Her big, milky udders seem more fit for a cowgirl than a harpy.  It's a wonder she can even fly with such a bountiful bosom.");
		
		output("\n\nUnable to resist the feeling of her achingly hard nipples being pressed against you so tightly, you reach out for your daughter's big, creamy udders and grab her hard nipples.  You pull your stacked daughter's sensitive buds before you pinch and squeeze them.  Not quite done with her, you let go of her nipples, letting your hands sink into the supple flesh of her enormous breasts before grabbing them harder, starting to knead and massage the soft, pliant jugs.  The rough and passionate touching of her body only seems to excite and arouse your firstborn further.  She's clearly enjoying the groping and teasing of her sensitive breasts, and you draw needy, birdlike coos and cries from her pouty lips.  ");
		
		if (flags["COC.DAUGHTER_ONE_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("\n\n\"<i>Ohhh, oooohhhh!  " + pc.mf("D-Daddy","M-Mommy") + "!  L-like, I can't take so much teasing!  Please, Gimme your h-haaard cock, " + pc.mf("Dad","Mom") + "!<i>\"");
		//[normal speech:
		else output("\n\n\"<i>Ohhh, oooohhhh!  " + pc.mf("D-Daddy","M-Mommy") + "!  Nnnnn... I can't take so much teasing!  Please, please give it to me, fuck me as hard as you can, " + pc.mf("Daddy","Mommy") + "!<i>\"");
	}
	//second daughter: 
	else if (daughterCap == 1) {
		output("\n\nYour huge assed daughter poses for you, turning her back to you and showing off her huge, rounded ass and thick, fertile hips.  Her bountiful badonkadonk is teasingly hidden by her long, feathery hair and tail.  Looking back at you, she pouts her plump ");
		if (flags["COC.DAUGHTER_TWO_BIMBO"] > 0) output("bimbo ");
		output("lips and blows you a kiss.  She slides her hands over her hips, pushing her taut butt out even more before spanking herself for your pleasure, her lips gasping at the feeling of her self-spank as she tries to work you into a breeding frenzy.");
		
		output("\n\nYou bite your lip at her erotic display, the sight of your own daughter trying so hard to entice you into a incestuous romp.  The growing desire to grab your girl and fuck her right then and there only grows stronger when you smell her.  The hungry harpy fans her long feathers to blow her hot and heady scent to you, letting you smell her arousal, the scent of a ripe and wanting female, ready to be bred.  ");
		if (flags["COC.DAUGHTER_TWO_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("\"<i>Mmmm... doncha want to just like, pound my sexy ass, " + pc.mf("Daddy","Mommy") + "?  It's so big, it's just begging to be spanked and squeezed till it's totally red and sensitive</i>\"");
		else output("\"<i>Come on, " + pc.mf("Daddy","Mommy") + ", touch me, spank me like the bad girl I am, lusting after my " + pc.mf("Daddy","Mommy") + " like this.  Give it to me hard, spank my big round ass and pound my hot tight cunt like I know you want</i>\"");
		
		output("\n\nUnable to take her teasing any longer, you step forward, raising your hand, and you give her the swat on the butt she wanted, the hard touch pulling a gasp from your daughters lips.  Leaning your girl over, you take the time to properly inspect your voluptuous daughter's needy backside.  Sliding your hands over her round rump, you squeeze and grope the soft flesh, your hands kneading the blatantly begging behind before racing back and giving her the spanking she so wants.  Her cheeks burn red with embarrassment, but the way she is jiggling and shaking her blubbery bottom at you tells you she wants it just as much as you do.  Finally getting a really good view of it, your eyes widen as you run your hands over every inch of her bouncy rear.  An ass this fine isn't to be wasted, and so you lean down and bury your face between those luxurious orbs, planting your mouth firmly over her drooling pussy and tasting her sweet juices.  Your senses quickly get overwhelmed from how good the lewd flower of your big-assed daughter tastes.  She exudes the sweet flavor of a fine, feathery, daughterly 'bitch' in heat, lusting to have daddy's cock stuffed inside her dripping, eager pussy.  As sumptuous as her enormous rump is, you can't resist taking her right then and there.  The scent and taste of her pussy has taken a serious effect on you.  The call to rut and breed your daughter is just too much to stop.");
	}
	//third daughter:
	else if (daughterCap == 2) {
		output("\n\nUnlike her two older sisters, the daughterly harpy before you is far more average compared to her mother and sisters, though she is still more sumptuous and sexy than a common, mountain harpy.  Under your watchful gaze, your daughter can't help but be bashful.  She blushes and looks down, her hands fidgeting and feet playing with the dirt under them.  The harpy girl is clearly embarrassed by how she isn't as juicy and stacked as her mother and older sisters.  Despite how eager she is for you, she can't help but think herself unworthy of you when you could fuck her mother or older siblings.  She takes a deep breath, putting on a brave face before striking a pose for you.");
		output("\n\nSeeing her try so hard despite her self consciousness, warms your heart.  Your daughter is trying hard just to please you.  You watch her for awhile, watching as your daughter starts to dance and undulate for you, showing off her toned body as best she can.  Her hands slide up and down her body, feeling up her hips, her flat tight belly, her soft perky breasts.  As soon as she grabs her tender tits, she lets out a groan as she looks over at you with her violet eyes, hoping that she was able to please you with her dance.");
		
		output("\n\nYou clap your hands and applaud your daughter's work.  The curvy little harpy is working so hard to please her " + pc.mf("daddy","mommy") + " and entice him into her nest...  ");
		if (flags["COC.DAUGHTER_THREE_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("\"<i>L-like, did I do a good job, " + pc.mf("Daddy","Mommy") + "?  I so totally did my best for you.  I know I'm not super sexy like Mom and my sisters... but, " + pc.mf("Daddy","Mommy") + ".. I will like, still please you, like, totally the best that I can!</i>\"");
		else output("\"<i>W-well, what did you think, " + pc.mf("Dad","Mommy") + "?  Did I do a good job?  I know I'm not as hot as Mom, but I promise I'll please you as best I can!</i>\"");
		output(" she says, wanting more than anything to be able to please you.");
		
		output("\n\nSmirking at your daughter and reaching out with your hands as you approach her, you grab her and pull your desirable daughter against you, pushing your hips together.  Your closely pressed bodies make sure she feels [pc.oneCock] straining against the confines of your [pc.gear].  The needy harpy lets out a coo as she grinds her body against your own, her hands gripping and sliding over you as she looks to you with her big, violet eyes.  Her desire for you is as clear as the lust on a goblin.  Reaching down, you grab her sumptuous harpy rump, kneading that luscious, spankable ass with hunger and desire, your rapidly growing need to fuck and breed this delectable bird-girl overpowering what little sense you have left.  Despite her 'normal' feet, the idea of fucking your eager, beautiful daughter fills you with an aching hunger that must be sated.");
	}
	else {
		output("\n\nYour daughter unfurls her wings in an elegant display, her downy soft feathers looking snuggly soft as she brings them down around her, using them to just barely conceal her nudity.  Moving as gracefully as she can, your daughter starts to dance for you, swaying her body and undulating like the finest dancers in the seediest bars.  Moving her voluptuous hips, shaking her spankable ass, and squeezing her suckable breasts, the pink woman croons for you.  She moans and groans as she dances and plays with herself, her blue eyes flicking over to you every chance she gets, her gaze wandering across your body, betraying her lust for you.");
		
		output("\n\nSlowly approaching you, she swings her hips back and forth enticingly, showing off her fertile hips.  ");
		if (flags["COC.DAUGHTER_FOUR_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("\"<i>Come on " + pc.mf("Daddy","Mommy") + ", can't you see how totally hot I am?  Don't you just want to let loose and like, just fuck me till I scream.</i>\"");
		else output("\"<i>Just look at me, " + pc.mf("Daddy","Mommy") + ", so curvy, so ready, so hot and wet for you.  Just let loose and show me your love, show me how much you love me, " + pc.mf("Daddy","Mommy") + ", fuck me hard, make me scream and claim me as yours.</i>\"");
		output(" the horny birdgirl says with a lick of her plump, kissable lips, aching hunger for your incestuous seed.  She wraps her arms around you, pulling her body against yours and sliding a long downy leg around you.  Her position opens her up to you and presses her sodden sex against your crotch.  She's such a lusty, lovely woman, and she wants you so badly, her body begging for you to take her and to seed her fertile body with your potent virility.");
		
		output("\n\nUnable to hold back a moment longer, you grab hold of your fluffy, feathery daughter, your hands grabbing her ass, kneading and pulling at the soft curvaceous behind.  At your behest, she presses herself tighter against you, her perverted cock-pillows squishing like the softest, sweetest marshmallows between you.");
		//bimbo speech
		if (flags["COC.DAUGHTER_FOUR_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0) output("  \"<i>Ahh... ohhh... oh, " + pc.mf("Daddy","Mommy") + "!  You like my butt, don't you; isn't it nice?  It's so good to grab and squeeze.  I bet it would be fun to, like, spank it too....</i>\"");
		//[normal speech:]
		else output("  \"<i>Mmmm... Oh, " + pc.mf("Daddy","Mommy") + ", yessss...  That's it, touch me, touch me and play with me, do whatever you want with me.</i>\"");
		output(" she coos into your ear, temping you even more with the taboo of her incestuous flesh.  With such a demanding offer of pleasure, your daughter so open and ready to receive your pleasure, how could you say no to such a lovely girl?");
	}
	processTime(12);
	clearMenu();
	addButton(0, "Next", phaseTwoOfIncest, daughterCap);
}

private function phaseTwoOfIncest(daughter:int):void {
	clearOutput();
	var x:int = pc.cockThatFits(sophieCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	daughter++;
	output("Tightening your hold on your curvaceous daughter, you shove her down onto the ground.  Growling with an almost primal edge, you lean down and inspect your prize, hands running over her ");
	if (daughter == 1) output("massive pillowy tits");
	else output("tender perky breasts");
	output(", your fingers sinking into her soft flesh as you caress and squeeze your daughter's bountiful body.  You lean down, kissing and sucking her neck, your lips latching on and sucking hard enough to leave your mark on her skin for the world to see.  She's unwilling to do anything against your lustful advances, mind and body ready and fully accepting whatever naughty things you would do to her.  With how heavily she is breathing and how lusty her moans and calls to you are, your daughter clearly wants the sweet incestuous union between " + pc.mf("father","mother") + " and daughter even more than you do.  What a sexy and lovely daughter you have here...  at your aggressive touch, she groans and croons for you, beckoning to you to continue your familial onslaught.  She wraps her legs around your body, grinding her hips against you.  \"<i>Yesss, yessss!  More, " + pc.mf("Daddy","Mommy") + "!</i>\" she squawks in between her breathy moans.");
	
	output("\n\nYou run your hands up and down her body, exploring and stroking every inch of her curvaceous form you can reach.  You move down to her ");
	if (daughter == 2) output("massive, round, spankable ass");
	else output("gropable, soft ass");
	output(" and grab her hard, squeezing and pulling her pliant flesh.  You growl to her, giving her rump a hard spank before pushing her down and pinning her beneath you.  Your eyes run over her body, taking in her creamy skin and her colorful feathers, her eyes looking back at you with burning, aching desire.  Not wanting to wait a moment longer, you free yourself from her long, silky legs and strip yourself of your [pc.gear].");
	//[if breasts: 
	if (pc.biggestTitSize() >= 1) {
		output("  Your [pc.chest], free from the confines of your gear");
		//if small bust:
		if (pc.biggestTitSize() < 3) output(", perk up as the cool air brushes past your hard, aroused nipples.");
		else if (pc.biggestTitSize() < 10) output(", bounce perkily, nipples hard as your handful of breast flesh touches the cool air.");
		else output(", spring forth in a wave of soft, squeezable bustiness; the kind of breasts one could curl up with and use as a pillow.");
	}
	
	output("\n\nBetween your legs, [pc.eachCock] flops free, your " + pc.cockDescript(x) + " achingly hard and ready for your fuck-hungry daughter.  The mass of masculine flesh throbs with your arousal, the insatiable organ longing to be sheathed within the welcoming depths of your daughter's soaking cunt, her tight, velvety folds ready to accept your potent, virile essence.");
	
	if (flags["COC.DAUGHTER_FOUR_BIMBO"] > 0 && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0)
	
	var bimbo:Boolean = (((daughter == 4 && flags["COC.DAUGHTER_FOUR_BIMBO"] > 0) || (daughter == 3 && flags["COC.DAUGHTER_THREE_BIMBO"] > 0) || (daughter == 2 && flags["COC.DAUGHTER_TWO_BIMBO"] > 0) || (daughter == 1 && flags["COC.DAUGHTER_ONE_BIMBO"] > 0)) && int(flags["COC.SOPHIES_DAUGHTERS_DEBIMBOED"]) == 0);
	
	if (bimbo) output("\n\n\"<i>Yessss!  Please, " + pc.mf("Daddy","Mommy") + "!  Give it to me!  Like, fuck my brains out till I can't think of anything but your, like, totally amazing cock!</i>\"");
	else output("\n\n\"<i>Yesssss! Please, " + pc.mf("Daddy","Mommy") + ", I've been wanting this so badly!  Give it to me, fuck me like the stud you are and fuck my cunt full of spunk!</i>\"");
	output(" she croons, her words dripping with raw, passionate need for you and your incestuous love.  The sight of her so needy, so wanting, her body aflame with an unquenchable hunger for you is just too tempting.  Your own lust boils over as a thick dollop of pre-cum bursts from your [pc.cockHead " + x + "] and splatters across your daughter's sodden snatch, adding to the lube already waiting to welcome you into her body.");
	
	output("\n\nTaking your sensitive, throbbing cock in hand, you give yourself a stroke and let out a groan at how ready you are; how hard you are for the incestuous fuck you're going to enjoy.  With as much grace as a fuck-hungry beast, you align yourself with your daughter's tender folds and plunge yourself in, your " + pc.cockDescript(x) + " sliding into her slippery cunt easily thanks to all the sweet juices oozing from her.  The sudden hard thrust into her body sends shockwaves of pleasure through your over-aroused daughter, her legs wrapping around your waist as soon as you hilt yourself inside her.  Not waiting for her to get used to you, you start to buck your hips, pistoning your " + pc.cockDescript(x) + " into her over and over as you keep her pinned to the ground.  Her bird-like cries of delight fill the air and mix with the hard, slippery slaps of your hips against hers, telling you all you need to know about her pleasure and how she loves to be fucked by her " + pc.mf("father","mother") + ".");
	
	output("\n\nNot content to merely fuck and breed your slutty girl like this, you lean down and capture her lips with your own.  ");
	if (daughter == 1) output("The sensation of your lips pressing against her puffy, sensitive lips so roughly only makes her pleasure greater; her pussy quivering around you and clenching hard as you kiss her.  ");
	output("Eagerly, she kisses you back, wrapping her feathery arms around you as she opens her lips to you.  Her tongue slides out to lick your lips and seek out your tongue to draw it into a sweet, illicit dance of incestuous delight.  Pushing her body, your feathery spawn bucks back against you, wanting more of this spine tingling ecstasy she feels, the all consuming need to rut and breed with her virile mate taking full hold over her, nothing but the dream of having her eggs fertilized by her " + pc.mf("father","mother") + " filling her mind.");
	
	output("\n\nKissing the horny, needy girl back, you force your tongue against hers, plunging into her warm, wet mouth and silencing her rampant, lusty moans.  Sliding a hand down, you grab a handful of your daughter's ample, spankable butt and squeeze, using her body as a handhold while you screw her and claim her quivering form as yours.  Like her mother before her, she belongs to you.  Your daughter's body is your property, made to sate your boiling lust and take your seed deep into her womb to mother your young as a good, fertile female should.  Already you can feel the swelling pressure inside you, the searing hot pleasure of your impending orgasm, the seed that gave your daughter life soon to be flooding her womb in an explosion of " + pc.mf("father","mother") + "ly lust.");

	output("\n\nSoon, the swelling might of your climax falls upon you.  Valiantly, you hold back as long as you can.  ");
	if (pc.balls > 0 && pc.ballDiameter() < 8) output("Your seed swollen balls clench and lurch under the power of your orgasm, sending forth your creamy load into her waiting depths.  ");
	else if (pc.balls > 0) output("Your huge, breeder balls slap hard against your daughter's soft, creamy skin, letting her feel how heavy and overflowing they are with your virile essence.  The very feeling of your aching orbs against her body makes her shudder in delight at the thought of having your frothy seed bloating her belly.  Clenching with mighty contractions, your fat, bloated sack discharges its gushing virility in great, geyserious bursts of thick, sperm-packed spunk.  ");
	output("Your distended cumvein bulges as your sticky seed dilates your [pc.cockHead " + x + "], streaming forth in great lances of egg-raping potency.  The very feeling of your spermy seed flooding her clenching, quivering cunt, drives your curvaceous daughter into an eye rolling orgasm, her body bucking and writhing in raw, mind-bending ecstasy as her body clenches and squeezes you tightly.");
	
	output("\n\nHolding your bodies close together, you jerk and grind your hips against hers, making sure that all of your precious seed goes only where it oh so rightfully belongs, into your sweet daughter's eager cunt and fertile womb.");
	//[cum volume low:
	if (pc.cumQ() < 250) output("  Squirting over and over into your sweet, lusty girl, you inseminate your fertile daughter, spilling as much of your cream right into her needy, hungry womb as possible.");
	//cum volume medium:
	else if (pc.cumQ() < 500) output("  Gushing over and over into your sweet, lusty daughter, you hold yourself tighter against her, making sure you force as much of your spunk into her waiting, hungry womb as you can.");
	//[cum volume high:
	else if (pc.cumQ() < 2000) output("  Gush after gush of thick rich cum flows from you, basting your daughter's womb with your virile spunk.  Wedging yourself as tightly against her as you can, you make sure that every drop packs into her fertile belly.  The potent flow of your seed quickly swells her stomach into a cute cum bloated paunch.");
	else output("  Your seed floods your daughter's tight, squeezing cunt like a flood, wave after wave of your thick, frothy spunk forces its way through her convulsing cunt and right into her eager, waiting womb.  Geysers of thick, frothy spunk force their way into her womb, filling it fuller and fuller until her belly swells and swells.  Her once tight, flat tummy rounds out into a healthy round cumbaby, your thick, yogurt-like spunk overflowing from her overstuffed snatch in thick, sticky streams.");
	output("  In a moment of lucidity, you look down at your daughter and see the blissed-out look on her face; her creamy skin red; her eyes rolling up into her head.  Her tongue is lolling out from her plump, cocksucking lips.  The sight of your daughter consumed by such mind bending pleasure, the ecstasy of having her " + pc.mf("father","mother") + " cumming inside her, only gives you a sense of pride and affection for your sweet daughter.");
	
	output("\n\nWhen you finally come down from your orgasmic high, you let out a sigh and lean down, snuggling up with your daughter.  Your arms wrap around her body, her legs not once loosening as she wraps her feathery arms around you and starts kissing you softly.  She coos to you as she kisses you over and over.");
	if (bimbo) output("  \"<i>Oh, " + pc.mf("Daddy","Mommy") + ", oh, " + pc.mf("Daddy","Mommy") + "...  So good!  My " + pc.mf("Daddy","Mommy") + "'s such a hot, sexy " + pc.mf("stud","herm") + ".  I so totally thought I was going to like, lose my mind for a second.  I love you, " + pc.mf("Daddy","Mommy") + ".</i>\"");
	else output("  \"<i>Oh, " + pc.mf("Daddy","Mommy") + ", oh, " + pc.mf("Daddy","Mommy") + "... so good, you're such a fucking " + pc.mf("stud","perfect breeder") + "!  I could just get addicted to you.  I love you, " + pc.mf("Daddy","Mommy") + ",</i>\"");
	output(" she says to you as she kisses you with her soft lips.  Chuckling at your affectionate daughter, you snuggle up with her, spending some sweet, comfortable pillow time with your freshly seeded girl.");
	
	output("\n\nFor nearly an hour you lay there, cuddling, kissing and stroking your daughter's body as she hogs you all to herself.  Despite how comfortable it is to cuddle with your daughter like this, you have to pull yourself away from her curvaceous, cock-pleasing body.  She can't help but pout as you pull away, clearly wanting to spend more time with her beloved " + pc.mf("father","mother") + ".  Not wanting to leave her so disappointed, you reach around and give her a spank on the ass and pull her close to you, kissing her once more before promising to spend more time with her later.  With a smile, she giggles and nods, her mind happily thinking about the next time you will spend some quality time with her.");
	//pass time 1 hour//
	//return PC to camp interface//
	processTime(40 + rand(10));
	pc.orgasm();
	addNextButton();
}