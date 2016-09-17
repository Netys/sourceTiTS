import classes.Characters.CoC.CoCWorms;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function showWorms():void {
	userInterface.showName("\nWORMS");
}

public function wormEncounter():void {
	clearOutput();
	clearMenu();
	
	var canEncounterWorms:Boolean = true;
	if (pc.hasStatusEffect("Worms Infested")) canEncounterWorms = false;
	if (flags["COC.WORMS_ENABLED"] == -1) canEncounterWorms = false; // disabled
	
	if (!canEncounterWorms || flags["COC.WORMS_ENABLED"] == 1 && rand(2) == 1 /* half chance */)
	{	
		if (pc.cor() < 90) {
			output("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.");
			pc.lust(pc.libido() / 10 - 15);
		}
		else {
			output("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.");
			pc.slowStatGain("l", 0.25);
			pc.lust(pc.libido() / 10);
		}
		pc.slowStatGain("p", 0.25);
		pc.slowStatGain("r", 0.25);

		clearMenu();
		addButton(0, "Next", function():*{ processTime(40 + rand(10)); mainGameMenu(); } );
		return;
	}
	
	showWorms();
	if (flags["COC.WORMS_ENABLED"] == undefined) { // undefined for a reason
		wormToggle();
		return;
	}
	if (int(flags["COC.WORMS_MET"]) == 0) { //First encounter
		output("As you are exploring, a rather pungent, peaty smell assails your nostrils. You hear a strange rustling and an off-kilter squishing noise in the distance. As you explore the area you come upon a most grotesque sight. Before you is a cohesive mass of writhing, wriggling worms! While normally solitary creatures, these appear to have coalesced into a monstrous living colony!\n\n");
		output("You have never before seen such a bizarre freak of nature. You see the mass of annelids creep about across your path. It stops and spreads slightly in your direction before halting. The stench of the mass is indescribable and a thick, viscous slime covers each of the countless worms forming the collective.\n\n");
		output("You stop dead in your tracks, wondering what this swarm will do. After a few tense moments, the mass crawls away in a direction opposite of both you and your current path. You breathe a sigh of relief as you are confident that no good could have come from confronting such a zoological travesty.");
		pc.lust( -10);
		flags["COC.WORMS_MET"] = 1;
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	else if (pc.hasCock()) {
		output("Minding your own business, you make your way through the mountain and you find yourself stopped by another mass of the sickly worms. The collective stops, apparently sensing your presence and briefly ebbs in your direction. After a few tense moments, the mass begins moving again... straight towards you at an alarming rate!\n\n");
		output("What do you do?");
		clearMenu();
		addButton(0, "Confront", wormsConfront);
		addButton(1, "Do Nothing", wormsDoNothing);
		addButton(2, "Run", wormsRun);
	}
	else {
		output("Making your way, you stumble on another gross mass of worms. The countless struggling creatures bar the path before you. Again, you freeze in place as the horror gropes about on the ground. It appears to have no real interest in your presence and it makes its way in a direction other than yours, much to your relief.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

public function wormToggle():void {
	showWorms();
	clearOutput();
	output("While wandering, you come across a crudely illustrated sign.  It depicts an imp in obvious discomfort, covered in white little worms.  It looks as if one of them is even crawling into the imp's penis!\n\nHow do you feel about that?");
	clearMenu();
	addButton(0, "Aroused", wormsOn);
	addButton(1, "Grossed Out", wormsOff);
	addButton(2, "Who Cares?", wormsPartiallyOn);
}

private function wormsOn():void {
	clearOutput();
	output("You actually think it's kind of a hot idea, and wonder if such creatures actually exist in this land as you make your way back to camp.");
	//output("\n\n<b>If you ever change your mind, you can toggle from Fetishes menu in game settings.</b>");
	flags["COC.WORMS_ENABLED"] = 0; // normal
	doNext(returnToCampUseOneHour);
}

private function wormsPartiallyOn():void {
	clearOutput();
	output("You shrug and keep walking, not sure how you feel about the strange sign.");
	//output("\n\n<b>If you ever change your mind, you can toggle from Fetishes menu in game settings.</b>");
	flags["COC.WORMS_ENABLED"] = 1; // half
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function wormsOff():void {
	clearOutput();
	output("You shudder in revulsion and figure the sign to be the result of someone's perverted fantasy.");
	//output("\n\n<b>If you ever change your mind, you can toggle from Fetishes menu in game settings.</b>");
	flags["COC.WORMS_ENABLED"] = -1; // none
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function fightWorms():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCWorms());
	CombatManager.victoryScene(function():*{
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	});
	CombatManager.lossScene(infest1);
	CombatManager.displayLocation("WORMS");
	CombatManager.beginCombat();
}
	
private function wormsConfront():void {
	showWorms();
	clearOutput();
	output("You turn to confront the worms and combat begins!");
	addNextButton(fightWorms);
}

private function wormsDoNothing():void {
	showWorms();
	clearOutput();
	output("You do nothing, allowing the worms to enter combat range!");
	addNextButton(fightWorms);
}

private function wormsRun():void {
	clearOutput();
	if (pc.canFly()) {
		output("You beat your [pc.wings] quickly and burst into the air! Wasting no time you fly away.");
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	else if(pc.reflexes() > rand(35)) {
		output("Your instincts overwhelm you and you immediately turn around and run like hell in the opposite direction. You look behind you as your heart feels as if it is about to burst only to discover that the creature did not follow you. You take a moment to catch your breath and consider yourself fortunate.");
		processTime(5);
		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	else {
		output("You turn to run, but before your " + pc.feet() + " can get you away, the worms are upon you!  You turn to face them, lest they launch onto your unprotected back.");
		addNextButton(fightWorms);
	}
}

public function infest1():void {
	showWorms();
	clearOutput();
	
	output("Overcome by your " + (pc.HP() < 1 ? "wounds" : "lust") + ", you sink to your knees as the colony of worms swarms all over your body...\n\n");
	
	output("Trapped within the mass of worms, you are utterly helpless. The constant moving all over your body provides naught but unwanted stimulation. [pc.EachCock], not knowing any better, springs to attention, creating a peak in the mass. The worms immediately recognize what has happened to you. One particularly fat worm finds itself perched on top of your dick's throbbing glans. You feel it prodding about your urethral opening and come to a horrible realization that your precious penis is completely vulnerable to thousands of creatures capable of invading your body!!! Before you can react or curse your fate, the fat worm quickly forces open your urethra and begins to push its way inside your dick!\n\n");
	
	output("Crying out in shock, you feel the fat worm push its way, inch by inch, into your urethra. Your nerves light up like a Christmas tree as each individual cell tells you of the creature's presence and movement deeper into your body. The fat beast easily finds its way into your prostate and settles within the organ. As it settles, it begins flailing inside your sex. The sensations shift from shock to grotesque pleasure as your body only senses the stimulation conductive to orgasmic response. Your groin cramps and bloats quickly by the torrent of semen building within you and the invader's presence. Obviously sensitive to your fluids, you feel the worm thrash around some more, causing your body to respond by making more semen. The flopping creature quickly erodes any orgasmic discipline you are capable of and with a great shrill cry, you force lances of cum into the air, launching goo and worms alike in a sick display of forced pleasure. After you empty your body of spunk, the remaining worms become hyperaggressive.\n\n");
	
	output("Excited by the feel of your fluids on them, many smaller worms push their way into your penis. Your cock distends as the worms fight to get inside you and to the source of the milk that has so excited them. Your prostate quickly fills up with the squirming creatures. The discomfort in your bloated bludgeon and the ceaseless stimulation of your organs causes your body to produce more cum. However, you find yourself unable to climax as the invaders rest inside your body submerged in your [pc.cumFlavor] lust. The rest of the colony disperses, having accomplished its true goal of infesting your body.\n\n");
	
	if(pc.cor() < 25) pc.cor(25, true);
	trace("GET INFESTED HERE");
	if(pc.hasStatusEffect("Infested")) {trace("BWUH?");}
	else {
		if(int(flags["COC.EVER_INFESTED"]) == 0) flags["COC.EVER_INFESTED"] = 1;
		pc.createStatusEffect("Infested", 0, 0, 0, 0);
	}
	
	processTime(15 + rand(5));
	CombatManager.genericLoss();
}

//spontaneous orgasm - chance to avoid being raped by monsters who would care.
public function infestOrgasm():void {
	//showWorms();
	output("The ceaseless squirming of your uninvited guests send your body into paroxysms. Collapsing to your knees, you immediately begin pushing gouts of dick milk out of your body. You feel tremendous pressure in your pelvis and in your cock as you realize that you are pushing worms out with each torrent of cum! Stream upon stream of cum breaks free from the prison of your body, carrying some of the worms inside you with it. Once the orgasm passes, you collapse to the ground, totally spent. Before you pass out, you feel the unfortunate presence of the fat worm still in your body.");
	pc.orgasm();
	//Check infestation and update it
	if(pc.hasStatusEffect("Infested")) {
		//Increment infestation number
		if(pc.statusEffectv1("Infested") < 5) {
			pc.addStatusValue("Infested", 1, 1);
			pc.cumMultiplierRaw += 1;
			//fifth time is the charm!
			if(pc.statusEffectv1("Infested") == 5) {
				//Futaz
				if(pc.balls == 0) {
					output("\n\nAfter you empty yourself, you feel your body shift. The presence of the large worm is no longer discomforting. It is as if your seminal bladder has enlarged to accommodate the new thing inside you. Likewise, your ejaculations have become truly monstrous and the amount of worms you expel has also increased. You realize that the large worm has become a part of you and you can now <b>infest</b> your enemies much in the same manner as you have been infested, yourself. All you need now is some poor fool to overwhelm with your new 'pets'.");
				}
				//non-ball-less
				else {
					output("\n\nYou feel an awkward sensation in your prostate.  You sense the fat worm squirming wildly triggering multiple, sloppy orgasms, leaving you spraying semen everywhere.  After a moment, the orgasms and the worm's twitching stop.  You feel " + num2Text(pc.balls) + " separate sensations in your prostate and feel the sensation of pressure pushing on both sides of your body.  The reality hits you.  The fat worm has divided into " + num2Text(pc.balls) + " smaller worms!  Each worm has found its way into your vesicles and is pushing down the vas deferens on each side.  You feel each worm push its way into your testicles and they immediately begin to swell to an impressive size.  Your pelvic muscles begin their familiar rhythmic squeezes and you see your sac bob in its tell-tale fashion of an impending orgasm.  Your muscles seize up and your now-massive scrotum tightens up in a vice-like grip around your fat, infested nuts as a huge solid stream of cum rockets from your cock.  You are utterly speechless as you literally shoot cum for five minutes straight!  When the orgasm subsides, you see a small colony of worms in the massive puddle of spunk you made, which quickly creeps off.  You realize that the creature is now a part of you and that you can use this to your advantage in a fight if you learn to control your ejaculations.");
					
					pc.ballSizeRaw += 2;
					pc.cumMultiplierRaw += 2;
				}
			}
		}
	}
	clearMenu();
	addButton(0, "Next", function():*{ processTime(100 + rand(40)); mainGameMenu(); } );
}

//public function playerInfest():void {
	//showWorms();
	////Keep logic sane if this attack brings victory
////Gone	menuLoc = 0;
	//if(pc.fatigue + kGAMECLASS.physicalCost(40) > pc.maxFatigue()) {
		//output("You try to summon up an orgasm, but you're too tired and waste your time trying!");
		//fatigue(100-pc.fatigue);
		//enemyAI();
		//return;
	//}
	//
	////(if PC uses Infest)
	//if(monster.short == "Izma") {
		//fatigue(40,2);
		//output("With a great squeeze, you will your body to push out a load of semen filled with worms.  Izma's eyes widen in shock as she dives and rolls away from the torrent.  \"<i>What the fuck!</i>\" she yells. \"<i>Is that what that smell was?  That's disgusting!  Get away from me " + pc.short + ", I DON'T want what you've got.  Don't talk to me again while you've got those nasty things!</i>\"  Izma grabs her locker between her hands and wades into the lake, swimming away by means of her tail while holding the books out of the water.", true);
		////(set Izmacounter to 0)
		//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00230] = 0;
		//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00233] = 1;
		////clear status
		//kGAMECLASS.inCombat = false;
		//kGAMECLASS.clearStatuses(false);
		//doNext(returnToCampUseOneHour);
		//return;
	//}
	//if(monster.findStatusAffect(StatusAffects.TwuWuv) >= 0) {
		//output("You expose yourself and attempt to focus on expelling your squirming pets toward Sheila but as you picture launching a flood of parasites from [eachCock], the fantasy she sent returns to you, breaking your concentration!  Your hand darts automatically to your crotch, stroking [pc.oneCock] as you imagine unloading into her cunt... only with effort do you pull it away!\n\n");
		//output("\"<i>Oh, my,</i>\" the demon teases.  \"<i>You don't have to masturbate yourself, [pc.name]... I'll be happy to do it for you.</i>\"\n\n");
		//dynStats("lus", 5 + pc.sens/10, "resisted");
		//enemyAI();
		//return;
	//}
	//fatigue(40,2);
	//output("With a great squeeze, you will your body to push out a load of semen filled with worms. You moan in pleasure and release as your fluids launch at your enemy. Worms and cum fly through the air in an attempt to coat your opponent with your new pets.  ", true);
	////Viable target?
	//if(monster.short == "minotaur" || monster.short == "imp") {
		//if(monster.lust > 70) {
			//output("Your load washes over the " + monster.short + " and " + monster.pronoun1 + " stops dead in " + monster.pronoun3 + " tracks as " + monster.pronoun1 + " chokes and sputters to clear the cum from " + monster.pronoun3 + " face and nose to breathe. The " + monster.short + " stumbles, attempting to stand in your fresh cum puddle and quickly busts its ass on the ground. The worms quickly take over and swarm around the " + monster.short + "' s " + monster.cockDescriptShort(0) + ". With wild hunger, the worms easily push into the " + monster.short + "'s urethra and begin venturing into your victim's body. The " + monster.short + " begins to convulse wildly as " + monster.pronoun3 + " body begins to react to the squirming invaders. The " + monster.short + " quickly peaks and cum flies in all directions, along with some worms. You laugh hysterically as the " + monster.short + " must now endure the endless orgasms your new pets provide. You choose to unload one last batch on your fallen foe to ensure a good infestation and walk away to leave the " + monster.short + " in the hell of endless pleasure.\n");
			//monster.lust = 100;
			//cleanupAfterCombat();
			//return;
		//}
		//else {
			//output("The monster watches your display as they step out of the way, a little grossed out by your actions.\n");
			//monster.lust+=5;
		//}
	//}
	//else if (monster.short == "lizan rogue") {
		//output("The lizan makes no attempt to dodge your worm-infused attack. The worms hit him with a fierce clash and slide down his body, disappearing into the ground without even attempting to infect the lizan. Maybe they prefer mammals...");
	//}
	//else if(monster.short == "anemone") {
		////Infest vs. anemone:
		//output("The white mess takes the anemone square in the torso, and the worms nearest her blue shaft waste no time in heading for it.  You both watch curiously as the lead worms ascend her dick, only to run headlong into the tentacles and slip off, stunned.  Eyes twinkling, the girl scoops up a handful of the squirming load still on her stomach and slurps it down greedily.  She smacks her lips and says, \"<i>Chewy!</i>\"\n");
		//monster.HP += 20;
		////(minus PC lust, of course)
	//}
	////nonviable
	//else {
		//output("While your fluids bathe the " + monster.short + " in your salty lust, the worms take no interest in your foe and scurry off.\n", true);
	//}
	//awardAchievement("Cum Cannon", kACHIEVEMENTS.COMBAT_CUM_CANNON);
	//dynStats("lus", -20);
	//enemyAI();
//}
//
//
//public function nightTimeInfestation():void {
	//output("\n<b><u>Something odd happens that night...</u></b>\n");
	//output("You're dreaming of the time you were infected with the worms... the way their comforting bulk sat so heavily in your body, constantly keeping you horny and potent, jism and slippery white parasites practically dripping from your cum-slit with every heated moment.  It felt so good to let them in, to let them claim you, and to become the worm-packing carrier you were meant to be.  You can remember how it felt to have one slithering up your urethra even now, the tiny body trailing slime as it squirmed through your shaft towards its goal.");
	//output("\n\nMmmm, the way that little annelid rubbed your insides felt so good, and it only got better from there on.  After you let them get comfortable inside, you were also so horny, and it was so easy to get off.  You could just... think about squirting worms into some unsuspecting demon's vulnerable holes, and your little pets would coax your [balls] to climax.  They made you cum so fast and so hard!  You can still feel the squirming inside you, though it's getting deeper and deeper, just like the first time...");
	//output("\n\nWait!  You snap awake from your fantasy to the sensation of hundreds of worms swarming [eachCock].  Your urethra");
	//if(pc.cockTotal() > 1) output("s are");
	//else output(" is");
	//output(" open and vulnerable to the piles of spunk-hungry parasites, and as you look on in shock, you see four of them slide into your worm-packed tunnel");
	//if(pc.cockTotal() > 1) output("s");
	//output(", one after another!  No!  You reach for your [cock biggest] to somehow try and stop the infestation, but it's a futile gesture.  The worm pile on your [legs] is as big as the rest of you.  Worse still, you doubt you can pull out the ones that have already crawled inside.");
	//
	//output("\n\nGrabbing hold of [pc.oneCock] with both hands, you pinch your fingers around ");
	//if(pc.cocks[pc.biggestCockIndex()].cockThickness >= 6) output("as tight around the girth as you can");
	//else output("tightly around your girth");
	//output(", hoping to contain the squiggling menace in the upper reaches of your erection.");
	//if(pc.cockTotal() > 1) {
		//output("  It's a vain effort, as your other penis");
		//if(pc.cockTotal() > 2) output("es are");
		//else output(" is");
		//output("already turning into ");
		//if(pc.cockTotal() == 2) output("an ");
		//output("infestation highway");
		//if(pc.cockTotal() > 2) output("s");
		//output(".  ");
		//if(pc.cockTotal() == 2) output("Its");
		//else output("Their");
		//output("inside");
		//if(pc.cockTotal() > 2) output("s are");
		//else output(" is");
		//output(" filled to the brim with moist wigglers.");
	//}
	//output("  You can feel narrow, tapered heads pushing at where you've pressed your urethra closed, and they try to force their way under again and again while more of their brethren pile in behind.  You stay resolute in your efforts to prevent the coming infection, pinching so hard it's painful and crying out as a result.  The pressure on your [cock biggest] wars with the way your body is reacting to the other sensations assaulting it.  Your [cock biggest] spasms powerfully when a big, fat worm perches on your [cockHead biggest], slithering all around it, leaving behind a trail of slimy gunk and sending accompanying tingles of delight through your rigid pole.");
	//
	//output("\n\nThe surge of blood into your erection shifts your grip just enough that one - no, two worms slip through.  Oh nooo!  They wriggle deeper inside you, little tails lashing at the side of your sensitive, innermost flesh, massaging your concentration away with each motion they make.  Your grip fails completely, and the torrent of parasites flows unimpeded past your pleasure-weakened digits.  They move through your urethra, getting deeper by the second.  At the same time, the big, heavy worm, arguably the king of this little colony, pushes its thick, white head into your piss-hole.  Your flagging resolve shatters as you're stretched wide by the insectile invasion, utterly penetrated.   The littler worms have already started to move into your prostate, and once there, they start to convulse, each slapping its head and tail against the sensitive organ again and again.");
	//
	//output("\n\nMoaning, you look on as the distended bulge makes its way down your [cock biggest], thrashing slightly when it disappears into your crotch, the sensations far stronger once it passes beyond your sight.  This is it... you're definitely infested now.  The worms are inside of you, and they're going to make you cum.  Lying back while your [hips] fruitlessly twitch upward, you let your eyes close and give in to the knowledge that soon, you'll be another horny worm-factory, roaming around and spraying them out at every opportunity.  That big, slithering blob joins the rest in your prostate, stretching it dangerously, and it starts to shake, thumping at the sides of your innermost organ.");
	//
	//output("\n\nThe painful pressure and erotic horror rise with the onslaught of spasming ecstasy in your reproductive organs, peaking when that huge intruder nestles itself completely inside you, squeezing your organ until you're wailing and bucking your hips, slapping [eachCock] on your belly while you cum.  The torrent of cum that you loose is unexpectedly voluminous, splattering off your [chest] and chin, dripping onto the ground in gooey streams.  Reacting quickly, the rest of the colony smushes over your spurting boner");
	//if(pc.cockTotal() > 1) output("s");
	//output(" to absorb the sensual nutrition.  Some of them even slop off the sides after the dripping whiteness, to get to it before it absorbs into the brittle, wasted earth.  You cum and cum, almost without end, yet each thick jet is slurped into the writhing mass immediately, leaving behind just the parasitic, clear slime.");
	//
	//output("\n\nThe big one bathes in your jism, moving faster and faster to spur you to release even more.  Glittering spunk drains out of your tip mixed with a few white creatures until [eachCock] is twitching against you, convulsing with pleasure but unable to leak a single drop.  Only after you've given everything does the internal prostate massage subside, the uncomfortable weight settling into a steady throb.  They feel so good, and a hot wave of contentment slowly rolls through you.  Maternal pride wells up unbidden - these things are a part of you now, and keeping them fed feels so good.");
	//
	//output("\n\nYou relax in the afterglow, pondering just how you'll handle living with the constant desire, barely noticing the colony slinking off, freshly lubricated by your sexual fluids.  You drink into a lusty slumber, absently fingering [pc.oneCock].");
	//output("\n\n<b>You are infested, again!</b>");
	////Reinfest
	//if(pc.findStatusAffect("Infested") >= 0) {trace("BWUH?");}
	//else {
		//pc.createStatusAffect("Infested",0,0,0,0);
		//dynStats("cor", 0);
	//}
	//if(cor() < 25) {
		//dynStats("cor", 2);
		//cor() = 25;
	//}
	//doNext(playerMenu);
//}