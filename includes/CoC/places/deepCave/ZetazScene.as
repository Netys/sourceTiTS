import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function ZetazCaveDefeatZetaz():void {
	flags["COC.DEFEATED_ZETAZ"]++;
	clearOutput();
	//[VICTORY HP]
	if(enemy.HP() <= 1) output("Zetaz sinks down on his knees, too wounded to continue.  He looks up at you with helpless rage in his eyes and asks, \"<i>Are you satisfied now?  Go ahead then, kill me.  My life hasn't been worth living since I met you anyway.</i>\"\n\n");
	//[VICTORY LUST] 
	else output("Zetaz sinks down on his knees and fishes his massive, pre-drooling member from under his loincloth.  He looks up at you, nearly crying and moans, \"<i>Why? Ruining my life wasn't enough?  You had to make me jerk off at your feet too?  Just kill me, I don't want to live anymore.</i>\"\n\n");
	
	//[Both] 
	output("He can't die yet.  You need to know where his master, this 'Lethice', is.  It sounds like she's the queen-bitch of the demons, and if you're going to break this vicious cycle");
	//( or take her place)
	if(pc.cor() > 66) output(" or take her place");
	output(", you need to find her and bring her down.  What do you do?");
	output("\n\n(Sexually Interrogate, Kill Him, or Offer Safety for Information?)\n");
	
	//[Sexual Interrogation] [Brutal Interrogation] [Release for Info]
	clearMenu();
	addButton(0, "Sexual", ZetazCaveSexualInterrogation, null, "Sexual", "Chain the imp up and sexually interrogate him.");
	addButton(1, "End Him", ZetazCaveEndZetaz, null, "End Him", "Kill the imp. After all, he deserves to be bad-ended.");
	addButton(2, "Safety", ZetazCaveReleaseZForInfo, null, "Safety", "Release the imp after you get the information you need.");
	//addButton(3, "Rape", rapeZetaz);
}

//[Release Zetaz 4 Info Win]
public function ZetazCaveReleaseZForInfo():void {
	clearOutput();
	output("You look the pathetic imp up and down and smirk.  He closes his eyes, expecting a summary execution, but you present him with an offer instead.  If he gives you more information on Lethice and where to find her, you'll let him go scot-free and avoid him if he doesn't make a nuisance of himself.\n\n");
	
	output("\"<i>Really?</i>\" questions Zetaz in a voice laced with suspicion. \"<i>For fuck's sake, I'm already a renegade.  I'll take your deal.  It's not like it costs me anything I wouldn't give away for free anyway.</i>\"\n\n");
	
	output("Invigorated by the promise of safety and freedom, Zetaz pulls himself up and ");
	if(enemy.HP() <= 1) output("staggers");
	else output("nearly stumbles over his lust-filled cock");
	output(" towards a desk.  His dextrous fingers twist the knob on the top drawer expertly until a quiet 'click' comes from the furniture.  He reaches down to the divider between the drawers and pulls on it, revealing a tiny, hidden compartment.  In the center of it is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n");
	
	output("A loincloth flies across the room and deposits itself on your shoulder, startling you from your planning.  You glance back and see Zetaz tearing through his possessions, tossing his most prized items into a burlap sack with reckless abandon.  His whole body is trembling, as he ties it to a wooden pole, never once looking up at you.  Perhaps he fears you might change your mind?  ");
	if(pc.cor() > 66) {
		output("You smirk down at him and fold your arms over your [pc.chest], relishing his fear while you consider the possibilities");
	}
	else if(pc.cor() > 33) {
		output("You chuckle with amusement and watch the little bastard scrabble to pack up his life, relishing the chance to pay him back for your previous encounter");
	}
	else {
		output("You sigh and rub at your temples as the little jerk scrabbles to pack his life away.  In spite of yourself, you actually feel a little bad about the situation");
	}
	output(".  Zetaz scrambles out the south door, never once looking back at the tattered remnants of his old home.");
	output("\n\n<b>(Key Item Acquired: Zetaz's Map!)</b>");
	pc.createKeyItem("Zetaz's Map", 0, 0, 0, 0);
	processTime(20 + rand(10));
	clearMenu()
	CombatManager.genericVictory();
}
	
//[Sexual Interrogation]
public function ZetazCaveSexualInterrogation():void {
	clearOutput();
	output("You lean down until your face hovers over Zetaz, looking him square in the eyes, and explain, \"<i>I can't have someone who knows the way to the demons' headquarters dying before they tell me how to get there, can I?</i>\"\n\n", false);
	
	output("\"<i>Piss off!  You won't get shit from me,</i>\" retorts the defeated demon, \"<i>You may as well finish me off – I'll NEVER help a " + pc.mf("jackass","bitch") + " like you!</i>\"\n\n", false);
	
	output("Smirking, you grab a strip of leather from Zetaz's dresser and dangle it over his nose.\n\n", false);
	
	output("You whisper, \"<i>This is all I'll need.</i>\"\n\n", false);
	
	output("The imp looks up with his face shrouded in confusion as he asks, \"<i>I don't think a string is going to help you much, " + pc.mf("dork", "skank") + ".</i>\"\n\n", false);
	
	output("\"<i>Give me a moment, my stupid little snitch,</i>\" you taunt as you lift his loincloth, exposing the hardness concealed within.  It pulses, growing harder and an inch longer just from your brief touch and exposure to the air.  Perhaps the imp isn't as in control of his libido as he'd like you to think?  You twirl the leather strip around his base and swiftly knot it, getting a tight enough seal to make Zetaz grunt in discomfort. \"<i>Ungh! What the fuck!? Ow, goddamnit!</i>\"\n\n", false);
	
	output("Even with his protests and cries, you watch his cock inflate further, until it looks stuffed far beyond his normal capacity.  It twitches and drools corrupted pre-seed as you slide your finger along his urethra, watching the member bob and twitch from the slight, soft touches.  That must feel quite good.  Zetaz confirms your hunch by lifting his hips off the ground, shaking them lewdly to try to grind against your hand.  You don't deny him the friction he craves, wrapping your hand around as much of his meat as your fingers will encircle until steady dribbles of fluid escape from his urethra.  The tainted nodules of his demonic dick begin to flare and pulse, signaling that his orgasm is almost upon him.\n\n", false);
	
	output("He's NOT allowed to cum – not until you get the information you need!   You slide your fingers down to his base in one fluid stroke, slamming your hand against his crotch as his orgasm starts to bubble up.  Before your opponent can attain release, you squeeze hard with one hand and tighten the leather cord with the other, clamping the base until the imp's cum is bottled up in his abdomen.  Zetaz cries, \"<i>No-no-no, let me cum, please let me cum, need-ta-cum-nooowwww.</i>\"\n\n", false);
	
	output("No such luck.  You wait for his body to stop convulsing and return to your task, one hand sealed around his base while the other begins to stroke him with firm, steady motions, sliding over the pebbly surface of his dick's nubs.  Your victim continues his begging and crying, but you don't let up as you pause to gather his escaped pre-cum and smear it over his tip.  Zetaz pants and groans, trembling and swelling in your hand from your efficient hand-job.   Spitting on your palm, you bump up the tempo and begin to stroke him hard and fast, sliding over his cockring-swollen prick with practiced, deliberate motions.\n\n", false);
	
	output("\"<i>Tell me how to find the head demon and I'll let you cum.  Don't make this any 'harder' than it has to be,</i>\" you whisper.\n\n", false);
	
	output("The demon's voice starts to crack in spite of his efforts to remain defiant. \"<i>No!  I-uh-won't let yo-oooooh-control meeeeee!</i>\"\n\n", false);
	
	output("His protests trail into incoherent squeals and babbles as you bottle up his second orgasm behind the tightly tied strap.  Again, his body twists and writhes in your grip, tortured with the ever-increasing sexual tension.  Zetaz looks up at you with a pleading, cross-eyed expression as he tries to regain his wits, but you just keep pumping away.  His balls are visibly pulsing and quivering, desperately needing to release the building pressure.  You meet his gaze calmly, your hands continuing their work on the bloated imp-cock, and you break into a knowing smile as he thickens in your grip for the third time.\n\n", false);
	
	output("\"<i>Well Zetaz?  Is three the lucky number, or do I have to switch hands and keep backing you up until you go mad?</i>\" you ask.\n\n", false);
	
	output("His hands claw the rug underneath him as he gasps, \"<i>You win, you win!  The desk has a-ah ah ahh-hidden drawer with a map to Lethice's hideout.  Please justletmecomeletmecomeletmecomePLEAAAAASE!</i>\"\n\n", false);
	
	output("What do you do?", false);
	//['Release' him] [Tighten Strap] [End Him]
	clearMenu();
	addButton(0, "'Release'", ZetazCaveSexualTortureReleaseZetaz, null, "'Release'", "Let the imp cum and release him from the bonds.");
	addButton(1, "Tighten", ZetazCaveSexualTortureTightenZetaz, null, "Tighten", "Tighten the straps.");
	addButton(2, "End Him", ZetazCaveEndZetaz, null, "End Him", "Kill the imp. After all, he deserves to be bad-ended.");
}

//[Release Him]
public function ZetazCaveSexualTortureReleaseZetaz():void {
	clearOutput();
	output("In a moment of kindness", false);
	if(pc.LQ() > 60 || pc.libido() > 60 || pc.cor() > 60) output(", or perhaps perversion,");
	output(" you release the taut cord and allow it to unravel.  It whips off Zetaz's prick at once, tossed across the chamber by the pressure boiling forth from the imp's shaking hips.   Nodules flare from his prick's base to his tip in a wavelike motion, nearly doubling in size by the time the 'wave' reaches the ring around his crown.  Simultaneously, his urethra parts and unloads the imp's pent-up cargo with cannon-like force.  Sticky spoo rockets upwards, splatters against the ceiling, and hangs for a moment as the first 'jet' glazes the roof.  The eruption slowly peters out, letting the last of the rope fall over Zetaz's form.\n\n");
	
	output("You marvel at the force as you feel the next bulge moving up that demon-dick, squeezing past your gently caressing fingertips.  The next burst doesn't surface with the explosive force of its precursor, but what it lacks in speed, it makes up for in raw volume.  Zetaz's body arches and twitches with the effort of trying to push out three orgasms worth of backed-up demon jizz, and easily launches a missile-like globule onto his bed, where it splatters to great effect.  The third spout of white lacks the thrust and mass of it's predecessors, but easily puts out more love juice than most people's entire orgasm.  With a knowing smile on your face, you stroke out the remainder of his seed, keeping count of each rope as it's fired – four, five, six, seven, eight, nine, ten... eleven.\n\n");
	
	output("The imp has managed to soak his body, his nightstand, the bed, one of the walls, and even the ceiling, but all that pleasure came at a cost.  Zetaz's eyes have closed – the little guy passed out.  Smirking, you wipe your hand off in his hair and head over to the desk.  Somehow it managed to avoid the great spoogey deluge, and it almost seems to be standing aloof from the depraved scene that's devoured the rest of the room.  It has two visible drawers with a divider between them, but at a glance there doesn't seem to be enough room in the furniture to contain a hidden drawer or compartment.\n\n");
	
	output("You poke and prod around the desk's circumference, checking for false panels, weak points, or hidden latches inside the woodwork.  It refuses to give up its secrets, and you find yourself wondering for a moment if it's somehow capable of such deception before you dismiss the notion as insane.  For all this place's craziness, you doubt Zetaz would have a piece of possessed furniture in his bedroom.  Irritated, you yank open each drawer, but nothing seems out of the ordinary.  You grumble and slam them closed, twisting on the knobs with accidental fury.  A barely audible 'click' reaches your ears, and the divider between the drawers now protrudes ever so slightly forward, far enough to get a good grip on.\n\n");
	
	output("The unfinished wood behind the divider's facade chafes your fingertips as you gently pull on it, revealing a narrow, hidden compartment.  The only object inside is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n");
	
	output("You hear the faint scrabble of claws on stone and turn around, alarmed, but there's nothing there.  Not even Zetaz.  You imagine the cum-slicked imp sprinting from his own cave and into the deep woods, and the absurd image brings a smile to your face.\n\n");
	
	output("<b>(Key Item Acquired: Zetaz's Map!)</b>", false);
	pc.createKeyItem("Zetaz's Map", 0, 0, 0, 0);
	processTime(90 + rand(60));
	clearMenu()
	CombatManager.genericVictory();
}

//[Tighten Strap] 
public function ZetazCaveSexualTortureTightenZetaz():void {
	clearOutput();
	output("\"<i>Idiot,</i>\" you taunt while you tighten the strap further.  Zetaz actually starts to bawl in anguish while another orgasm worth of cum backs up inside him.  You don't want him to get out of the binding while you search for his map, so you pull the cord under his leg and use the free end to bind his wrists together behind his back.  Fondling his turgid prick one last time for good luck, you leave him to struggle with his need as you search for your map.  It's difficult to blank out all the whines and cries, but you manage.\n\n");
	
	output("Zetaz's desk sits against a wall, just far enough away from the rest of the furniture to give it an aloof appearance.  You get up and walk closer, kicking the imp in the belly on your way in order to get a little peace and quiet.  The desk has two visible drawers with a divider between them, but at a glance there doesn't seem to be enough room in the furniture to contain a hidden drawer or compartment. It will take a more careful examination to uncover this 'map'.\n\n");
	
	output("You poke and prod around the desk's circumference, checking for false panels, weak points, or hidden latches inside the woodwork.  It refuses to give up its secrets, and you find yourself wondering for a moment if it's somehow capable of such deception before you dismiss the notion as insane.  For all this place's craziness, you doubt Zetaz would have a piece of possessed furniture in his bedroom.  Irritated, you yank open each drawer, but nothing seems out of the ordinary.  You grumble and slam them closed, twisting on the knobs with accidental fury.  A barely audible 'click' reaches your ears, and the divider between the drawers now protrudes ever so slightly forward, far enough to get a good grip on.\n\n");
	
	output("The unfinished wood behind the divider's facade grates your fingertips as you gently pull on it, revealing a narrow, hidden compartment.  The only object inside is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n");
	
	output("You hear the faint scrabble of claws on stone and turn around, alarmed, but there's nothing there.  Not even Zetaz.  You imagine the partly hog-tied imp sprinting from his own cave and into the deep woods, his bloated cock bobbing dangerously with every step, and the absurd image brings a smile to your face.\n\n");
	
	output("<b>(Key Item Acquired: Zetaz's Map!)</b>");
	pc.createKeyItem("Zetaz's Map", 0, 0, 0, 0);
	processTime(90 + rand(60));
	clearMenu()
	CombatManager.genericVictory();
}

//[END HIM – Ew death!]
public function ZetazCaveEndZetaz():void {
	clearOutput();
	output("You grab his head in both hands and twist violently, popping his neck in an instant.  Glaring down at the corpse of your first demonic foe, you utter, \"<i>Wish granted.</i>\"\n\n");
	output("With him dead, you'll have to see if there's anything here that could lead you to this 'Lethice', so that you can put an end to the ridiculous plague affecting Mareth once and for all.  Perhaps you'll even get to go home, see your family, and have a rather violent talk with certain elders?  You tear through every drawer, pack, and chest in the place, but all you find are loincloths, extraordinairily fetishist porn, and junk.  Desperate for any clue, you even search under the bed and move the furniture, but it doesn't help.  You take your displeasure out on Zetaz's furnishings, slamming them into one another with all your might.\n\n");
	output("The chair in your hands disintegrates, the desk it impacts splinters apart, and you feel a little bit better.  A piece of parchment flutters back and forth in the middle of it all, freed from some hidden compartment and mostly unscathed.  One of the corners is ripped off, and it has a tear half way across, but it's still perfectly legible.  It's a map!  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n");
	output("<b>(Key Item Acquired: Zetaz's Map!)</b>");
	pc.createKeyItem("Zetaz's Map", 0, 0, 0, 0);
	//(ZETAZ IS DEAD)
	flags["COC.ZETAZ_DEFEATED_AND_KILLED"] = 1;
	processTime(90 + rand(60));
	clearMenu()
	CombatManager.genericVictory();
}

//[Lose to Zetaz]
public function ZetazCaveLoseToZetaz():void {
	clearOutput();
	output("\"<i>Well, isn't this familiar?</i>\" asks Zetaz as he watches your ");
	if(pc.LQ() >= 99) output("masturbating");
	else output("prone");
	output(" form with an amused expression, \"<i>The first champion in ages to retain " + pc.mf("his","her") + " free will for more than a few minutes, and " + pc.mf("he","she") + "'s brought to " + pc.mf("his","her") + " knees by the very imp " + pc.mf("he","she") + " escaped!  Once you've learned your proper place, you'll guarantee my safe return to my rightful station.  Perhaps I'll even get a promotion?  After all, you've defeated so many higher ranking demons already.</i>\"\n\n");
	
	//'Fix' genderless folks.
	if(!pc.hasGenitals()) {
		output("He squints down at you with a bemused look and laughs, \"<i>How did you lose your gender anyhow?  Never mind, we've got to do something about that!</i>\"\n\n");
		output("Zetaz grabs a bottle, uncorks it, and crams it against your lips while you're still too dazed to resist.  He massages your throat to make you swallow the milk-like fluid, and in seconds the skin of your groin splits to form a new, virgin pussy.\n\n");
		pc.createVagina();
	}
	//(fork to male/female/herm)
	if(pc.isHerm()) ZetazCaveHermZetazOver();
	else if(pc.hasCock()) ZetazCaveMalesZetazOver();
	else if(pc.hasVagina()) ZetazCaveFemaleZetazOver();
}

public function ZetazCaveFemaleZetazOver():void {
	clearOutput();
	//F-drugged up and tied to the table in the main room.  Cum in by all the imps till pregnant.  Daily fuckings with accompanying mind-fuck.
		
	output("With your resistance ");
	if(pc.HP() <= 1) output("beaten out of you");
	else output("moistening the delta of your legs");
	output(", you don't even struggle as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you... not with food, anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ");
	if(pc.cor() < 33) output("shame");
	else if(pc.cor() < 66) output("confuse");
	else output("arouse");
	output(" you as you're thrown atop one of the tables.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your [pc.legs] kept to allow easy access to your [pc.vagina].\n\n");
	
	output("Shuffling as they remove their garments, the entire gang of imps, as well as Zetaz, are completely nude.  They've all grown full and hard from the sight of your nubile, restrained body, and in spite of yourself you get ");
	if(pc.vaginas[0].wetness() >= 3) output("even more wet ");
	else output("a little wet ");
	output("from the masculine scent the aroused penises are producing.  ");
	if(pc.cor() < 33) output("How could you be turned on by such a repulsive situation?  You're going to be raped, brainwashed, and either kept as a pet or tossed in a milking tube for the rest of your life and your body is acting like some horny slut!");
	else if(pc.cor() < 66) output("You marvel at just how turned on you're getting from the strange situation.  You know you'll be raped, drugged, and used as a toy or milk cow, but your loins are thrumming with warm, wet desire.");
	else output("How did you wind up in such an arousing situation?  You're going to be raped, drugged, and probably milked in a factory for the rest of your life.  Your body is so fucking turned on that you know you'll love every second of it, but your desire to triumph and dominate mourns the loss of your freedom.");
	output("  The crowd draws close, but Zetaz's voice rings out, thick with the tone of command, \"<i>Not yet, my brothers; this one will be mine first.  I'll claim each of her holes, then you may each have your fill of her.</i>\"\n\n");
	
	output("The imps draw back, clearing a path for their leader to emerge, and the new, much more imposing Zetaz climbs atop the table.   He glances at your [pc.vagina] with a knowing eye and smiles, walking further forward until he's standing next to your face with his tainted, corruption-filled cock dangling overhead.  You're so distracted by the purplish-black demon-cock swinging above your lips that the sharp pain takes you completely off-guard. As soon as the discomfort passes you twist your head around to try and find the source of your irritation.\n\n");
	
	output("Zetaz turns away from you, holding a spent needle in one of his clawed hands as he exchanges it with one of his kin for another injector, only this one is filled with viscous white fluid.  He glances down at you, watching you intently for some kind of reaction, but you won't give him the satisfaction!  Even so, the room is getting so bright that your eyes start tearing up, and you blink repeatedly to rid yourself of them before half-closing your eyelids to shield your poor pupils.  Maybe that's what he's looking for?  The room spins and you find yourself thankful to be strapped down; even if only seated, you would probably tumble from your chair.\n\n");
	
	output("Your lips start to tingle, and you run your tongue over them reflexively.  A shiver of pleasure worms through your body, and you instinctively press your [pc.legs] against the straps in an effort to spread them further.  Worse yet, your lips feel much plumper and fuller than a few moments ago.  ");
	if(flags["COC.NUMBER_OF_TIMES_MET_SCYLLA"] > 0) output("Unbidden, Scylla's face comes to mind, and you realize the drugs coursing through your veins must be doing something similar to you!  Her visage changes to your own, though the thick, cock-sucking lips remain behind, eager to be penetrated.");
	else output("Unbidden, you imagine yourself with thick, cock-sucking lips, so swollen and bloated that they're slightly pursed and ready to be penetrated.");
	output("  Warm slipperiness slides over your lips again, feeling nearly as good as it would on your lower lips, and you pull your rebellious tongue back into your mouth with a gasp of pleasure.\n\n");
	
	output("This must be what Zetaz was waiting for, and the imp carefully injects the next chemical cocktail into the other side of your neck while you're distracted by orally masturbating your new mouth.  Your [pc.vagina] ");
	if(pc.vaginas[0].wetness() >= 4) output("gushes fresh fluids into a puddle on the table");
	else if(pc.vaginas[0].wetness() >= 3) output("drools a heavy flow of liquid arousal onto the hardwood table");
	else output("begins to dribble a steady flow of liquid on to the table's girl-slicked boards");
	output(".  ");
	if(pc.hasStatusEffect("Heat")) output("D");
	else output("Foreign d");
	output("esires wash through your doped up body, and your hungry slit practically demands to be filled with cock and injected with semen.  It wants to be filled with... with males, and with their hot, sticky cum. No, your hot little pussy doesn't want that – you do.  Gods above and below, you want to feel your belly pumped full of imp sperm until their offspring are wriggling in your womb.  And then you want them to come in you some more!\n\n");
	
	output("That sexy-... no, that bastard's dick is so hard, and he's starting to squat down now that you're feeling so randy.  The artificial needs coursing through your body make it hard to resist, but you've got to try!  You can't open your mouth and... mmm, it feels so good when those nubs touch your bee-stung lips.  Giving in isn't an option, even if you can't stop him from fucking your mouth, you aren't going to curl your tongue around his member and lick it, just like that, sliding it over his bumpy surface until corrupted pre is dripping onto your tongue. Yes, you won't let him out of your mouth until you can get his seed inside you, what are the other imps waiting for?  Your other hole is soooo hungry!\n\n");
	
	output("The mental incongruities in your thoughts are subsumed in a wave of hot, sticky fuck that's slowly rising over your thought processes with each lick and suck of Zetaz's thick, sexy dick.  He plunges down, stuffing your greedy gullet with the full length of his elephantine member and letting you know just how much he's enjoying your oral cum-hole.  You stick your tongue out to slurp at his desire-filled balls, swooning at the feeling of so much cock-flesh and slippery tongue sliding between your sensitive-as-a-pussy lips.  They twitch and pull tightly against his groin as he grabs your [pc.hair] and hilts himself, allowing your lips to seal around his base as his urethra rhythmically bulges with orgasm.  A feeling of warm fullness grows in your gut with each pulse of cum, and you work your throat muscles to squeeze his tip of every last drop while you try to get off on the feelings coming from your mouth.\n\n");
	
	output("Once finished, the imp yanks himself up and pulls his orgasm-distended member from your lips with such force that it feels like each of his nubs is flicking your lips.  The orgy of oral pleasure sets off fireworks in your head strong enough to cross your eyes and make you babble incoherent 'thank-you's and moans.  You pant happily and lick the residue of Zetaz's love from your lips, shivering from the sensitivity and trying to come to grips with what happened.  It doesn't do much good – you're already getting horny again, and you still haven't been knocked up.  Even though you know something about the situation is deeply wrong, you're horny as hell and desperately desire to be a mother.  Maybe it's just that there's all these strong, handsome males here but none of them are fucking your horny, wet twat.  There's something wrong with that!");
	//(max libido, lust, and sensitivity)
	//dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
	pc.libido(100, true);
	pc.lust(pc.lustMax(), true);
	pc.cor(50);
	//[NEXT]
	clearMenu();
	addButton(0, "Next", ZetazCaveFemaleZetazOverPtII);
}

public function ZetazCaveFemaleZetazOverPtII():void {
	clearOutput();
	//hideUpDown();
	output("While you're gathering your thoughts, Zetaz staggers back down the table and accepts a flask from one of his lackeys.  He guzzles down the bubbling pink fluid in seconds, and the effect is immediate and greatly pleasing to your fuck-happy worldview.  The imp's cock, which had been slowly retracting, thickens at the base and rapidly fills until it's hard and twitching with sexual need.  He glances down at your exposed [pc.vagina] with a hungry look and drops to his knees, lining the nodule-ringed crown of his wondrous dick up with your lust-juiced slit.\n\n");
	
	output("You look down at the male and moan, \"<i>Please, hurry up... I need your cum... your babies.  Put your cock inside me!</i>\"\n\n");
	
	output("Zetaz looks surprised at your words, and you start to wonder why, but the heat and pleasure of his long, thick member spearing your love-canal interrupts your thought process.  He reaches up, and begins to ");
	if(pc.biggestTitSize() < 1) output("tweak your [pc.nipples] roughly, pulling and yanking on them as");
	else output("maul at your [pc.fullChest], slapping and squeezing them as");
	output(" he begins to repeatedly thrust against your [pc.vagina], fucking you in earnest.  The wet slap of his balls on your juice-slimed body fills the chamber and sends ripples of pleasure down your [pc.legs].  With your eyelids half-closed, your tongue masturbating your lips, and your pussy practically squirting lubricants at the end of each thrust, you must look like every male's wet dream.\n\n");
	
	output("Looking around, you see a large number of the imps are masturbating, and one of the larger ones has the audacity to speak while his boss is plowing your quim with savage strokes. \"<i>Since you already got to use her mouth, I'm going to put that fuck-hole to use.</i>\"\n\n");
	
	output("Zetaz waves his hand, though you aren't sure if it's meant to be a dismissal or permission.  He's far too busy sawing away, sending bliss up your spine that makes you giggle and moan with desire.  You're already getting close to cumming!  Before you can vocalize just how great it feels, the imp that spoke is straddling your neck and dangling his own member towards the bloated, bimbo-like cum-receptacle that was once your mouth.\n\n");
	
	output("The pointed tip of the new imps dick slides through your sensitive orifice with ease, at least until you feel the curvature of his knot pushing apart your jaw.  The utter wrongness of being double-teamed by tiny, huge-cocked demons rears its ugly head, and you knit your brows together as you try to puzzle it out.  What could be wrong?  Your lips feel so good and you're about to be pregnant.  Wasn't there a reason not to, though?  Something about saving something?  You unconsciously lick at the new invader as his knot finally gets past your lips, humming and sucking while your drug-dulled mind tries to refocus on something other than getting knocked up.\n\n");
	
	output("Zetaz grunts and bottoms out, punching his tip into your cervix and blasting a thick rope of seed into your empty, ready womb.  You climax immediately from the act, and moan into the dog-cock that fills your mouth, using it like a ballgag.  There wasn't any natural buildup, just spunk hitting your womb and then a climax strong enough to make you see white.  Your [pc.vagina] clenches tightly, hugging and squeezing Zetaz's potent prick as it dumps more and more of his corrupt demon-spoo into your fertile breeding grounds.  The thick goop tingles in a way that makes you sure you'll be giving him a litter of horny little sons before long.  Maybe they'll fuck you like they do Vala?\n\n");
	
	output("The knot in your mouth pops out, and your belly gurgles, feeling very full.  The second imp must have come while his master was fertilizing your pussy.  You sigh and sag against your restraints as Zetaz steps away and lines begin to form.  In a few seconds, you've got a rubbery, spined cat-cock twitching inside your cunt, and are wrapping your sensitive lips around a horse-cock.  This must be what nirvana feels like.");
	pc.orgasm();
	//dynStats("cor", 50);
	pc.cor(50);
	
	//[Epilogue]
	clearMenu();
	addButton(0, "Next", ZetazCaveZetazBadEndEpilogue);
}

//[HERMS]
public function ZetazCaveHermZetazOver():void {
	clearOutput();
	//H-fed incubi and succubi potions repeatedly until demonic and even more over-endowed, knocked up while dick is milked by factory like milker + MC?
	output("With your resistance ");
	if(pc.HP() <= 1) output("beaten out of you");
	else output("moistening the delta of your legs");
	output(", you don't even struggle as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you, not food anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ");
	if(pc.cor() < 33) output("shame");
	else if(pc.cor() < 66) output("confuse");
	else output("arouse");
	output(" you as you're thrown atop one of the tables.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your [pc.legs] are kept spread to allow easy access to your [pc.vagina].\n\n");
	
	output("Your willpower starts to come back, and you struggle in vain against the tight leather straps, accomplishing nothing.  Zetaz leers down at your double-sexed form and roughly manhandles both your male and female organs as he taunts, \"<i>I don't remember ");
	if(pc.cockTotal() == 1) output("both");
	else output("all");
	output(" of these being here when we met.  Did you sample some incubi draft?  Or did you guzzle some succubi milk?  Perhaps both?  In any event, I think you could do with a little more of each.</i>\"\n\n");
	
	output("Oh no.  Your eyes widen in fear at his bold declaration, but Zetaz only throws back his head and laughs, \"<i>Oh yes!</i>\"  He turns to the mob and orders something in a tongue you don't understand, then returns to fondling your [pc.cock].  \"<i>How perverse.  Why would you have something like this when you have such a beautiful pussy hiding below it?</i>\" asks the imp lord.  Despite his questioning words, he doesn't stop stroking you until you're full, hard and twitching.  Your poor [pc.vagina] is aching from being ignored with all this building sexual tension.\n\n");
	
	output("The sounds of numerous footfalls and clinking glass signal that the mob of imps has returned, bringing what sounds like hundreds of vials worth of their foul concoctions.  Zetaz releases your tumescent member and reaches over for something, then returns to your view bearing a ring gag.  Even turned on, defeated, and immobilized on a table, you try your best to fight him, but all that gets you is slapped.  The imp's palm smacks you hard enough to stun you and leave your ears ringing, and when you blink the stars from your eyes, your mouth is forced open with your tongue hanging out lewdly.\n\n");
	
	output("Another of Zetaz's brothers, or perhaps sons, hands him a tube with a funnel, and he easily threads the funnel's tube through the ring gag.  Foul remnants of whatever it was used for last leave a sour taste on your tongue, but worse yet is the knowledge that you're going to be force-fed tainted, body-altering, mind-melting drugs.  A drop of pre-cum hits your belly and your thighs grow ");
	if(pc.vaginas[0].wetness() < 4) output("sticky");
	else output("soaked");
	output(" from the thoughts.  ");
	if(pc.cor() < 33) output("Are you really being turned on by such lewd, debased thoughts?");
	else if(pc.cor() < 66) output("Are you this much of a pervert?  Yes, it'll feel good, but you're a little ashamed of your body's immediate and lewd reaction.");
	else output("Are you really this much of a submissive?  Yeah, sucking down drinks like this is hot as hell, but you'd like to be doing it on your own terms.  At least you'll probably start cumming after a few bottles worth of the stuff.");
	output("\n\n");
	
	output("\"<i>Hey boss!  She's already starting to drip!  To think she tried to fight us.  She's showing us her true nature – that of a pervert-slut,</i>\" raves one of the horde.  You can't pick out the source of his voice in the crowd, but the words sting enough to make your whole body blush with ");
	if(pc.cor() < 33) output("shame");
	else if(pc.cor() < 66) output("confusion");
	else output("arousal");
	output(".  The imp lord nods in agreement and upends the first bottle over the funnel, channeling fragrant white fluid into your mouth.  It tastes fantastic!  Your throat instinctively gulps down the creamy delight before you can make a conscious decision.  The effect is immediate and strong.  Warmth builds on your chest as weight is added to your [pc.fullChest] while a gush of fluid squirts from your [pc.vagina].\n\n");
	
	output("Zetaz is just getting started.  Before you have time to react to your predicament, the next bottle is empty and thicker cream is flooding your mouth.  You don't swallow for a moment, so the imp pours another bottle in, backing up more of the fluid.  Faced with a choice between corruption and drowning, you try to gulp down enough liquid to breathe.  Your [pc.multiCocks] puffs and swells, spurting thick ropes of cum as it adds a half-dozen inches to its length.  Your eyes cross from the sudden change, but you get a fresh breath before the imps begin to pour several bottles in at once.\n\n");
	
	output("You swallow in loud, greedy gulps as your body is slowly warped by the fluids you're consuming.  Though your [pc.fullChest] and [pc.cocksLight] sometimes shrink, they grow far more often, and after a few minutes of force-feeding, you're pleading for more each time they stop to let you breath.  You're a mess of sexual fluids, your tits are squirting milk, and your pussy squirts from every touch.  Demon horns are swelling from your brow, curling back over your ears");
	if(pc.hasHorns()) output(", adding to your existing set");
	else output(" and giving you an exotic, tainted appearance");
	output(".  ");
	if(!pc.hasLegFlag(GLOBAL.FLAG_HEELS)) output("Your [pc.feet] have been changing throughout the ordeal, but you didn't notice your [pc.feet] becoming such lissom, lengthy legs, or your heels growing long, high-heel-like spikes.  ");
	if(!pc.hasTail(GLOBAL.TYPE_DEMONIC)) output("A spaded tail snakes around your leg and begins to caress your [pc.vagina], then plunges in to fuck the squirting orifice while you drink.  ");
	else output("Your tail snakes around your leg and begins to caress your [pc.vagina], then plunges in to fuck the squirting orifice while you drink.  ");
	output("The imps start hooting and cat-calling, laughing and prodding your body with their twisted demonic members as your mind starts to come apart in the seething oven of unnatural lust.\n\n");
	//NEXT
	//dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
	pc.libido(100, true);
	pc.lust(pc.lustMax(), true);
	pc.cor(50);
	clearMenu();
	addButton(0, "Next", ZetazCaveHermZetazOverPtII);
}

public function ZetazCaveHermZetazOverPtII():void {
	//hideUpDown();
	clearOutput();
	output("You awaken midway through a loud moan and nearly jump out of your [pc.skin] in surprise, but the fire of your unnaturally stoked libido immediately reasserts yourself.  You twitch your hips to and fro, thrusting against a ");
	if(pc.cockTotal() > 1) output("number of ");
	output("mechanical milking device");
	if(pc.cockTotal() > 1) output("s");
	output(".  [pc.multiCocks] is sucked rhythmically, producing a loud, wet, slurping noise that echoes around the small room.  You're suspended from a set of shackles on the wall, next to Vala.  The sexy faerie is chained up in a similar manner, but she's locked in coitus with a well-endowed imp, and making no secret of her enjoyment.  The sexual sight stirs your well-stimulated loins and you groan, filling the milker with what feels like gallons of male cream over the next minute and a half.\n\n");
	
	output("Slumping forwards, you hang there, but the corruption and lust in your blood refuses to be sated.  [pc.multiCocks] is already hard again, and after sucking your cum down some tubes, the milker begins its oh-so-pleasurable work again.  Still, you estimate it will be a few minutes before it gets you off again, so you look around the room.  A platform is set up in front of you, about knee-height and poorly built.  Judging by its height, it's probably there so that the imps can use it to fuck you without having to fly.  There's also a pair of platforms built into the walls next to each of your shoulders, though their function is less clear.\n\n");
	
	output("The door to the room bangs open, and Zetaz steps in, followed by two scrawnier-than-usual imps.  He smiles when he sees you awake and flushed, and steps up onto the platform, rubbing his palms together in excitement.\n\n");
	
	output("\"<i>You took quite well to our little experiment,</i>\" he announces, \"<i>In fact, your body is a demonic fucking machine.  I won't be transforming you into an actual demon though.  But we're going to have to have a little training to get you ready to meet Lethice.  After all the trouble you've caused her, she might want to turn you herself, or maybe hook you up in a factory?  I can't say for sure.</i>\"\n\n");
	
	output("With a flourish, the imp lord discards his loincloth, tossing it over his shoulder to reveal his erect demon dick.  He taunts, \"<i>Like what you see?</i>\" and orders his lackeys, \"<i>Go on, you know what to do.</i>\"  The pair of scrawny imps flit up to their perches while Zetaz advances and strokes himself, preparing for penetration.  Dozens of unanswered questions swarm through your mind, actually distracting you from your pending orgasm enough to ask, \"<i>Wha-what are you going to do to me?</i>\"\n\n");
	
	output("\"<i>Shhhh, shhh,</i>\" responds Zetaz, \"<i>just relax my pet.</i>\"  He ");
	if(pc.balls > 0) output("gently shifts your  [pc.balls] out of the way and ");
	output("lines up with your drooling fuck-hole, and with a long smooth stroke, he's inside you.  You cum immediately and hard, barely noticing the chanting that has started up on the adjacent platforms.  Each squirt of cum is accompanied by a thrust from Zetaz, sliding over your lube-leaking walls with ease.  The orgasm lasts nearly twice as long as your last one.  It never seems to end, but when it slowly trails off, you find yourself wondering how soon you can cum again.\n\n");
	
	output("You envision yourself on all fours, being taken in both openings by a pair of imps while you suck off a shadowy figure that your mind recognizes as your lord and master.  [pc.multiCocks] spurts and squirts with each penetration as your twin violators get off and stuff you full of their yummy imp cum, glazing your insides with corrupted white goo.  Maybe you'll get pregnant this time?  It's been a few weeks since your last litter.  You suck harder on your master's penis and caress his balls until he shows his affection by giving you a salty treat.  He pulls out and blasts a few ropes over your face and hair, so you do your best to look slutty to encourage him.  When he finishes, you lick your lips and beam at your master, Zetaz.\n\n");
	
	output("Wait- what!?  You shake your head and clear away the fantasy, though your sexual organs' constant delightful throbbings aren't doing much to help.  Zetaz is still fucking your pussy, taking it with long slow strokes that would've made your demonic legs give out ages ago if you weren't hanging on a wall.  The chanting is so loud, so insidious.  You can feel it snaking through your brain, twisting your thoughts and ideas.  You close your eyes, desperate to fight it, but it only enhances the sensation of dick-milking and being fucked by your- no, by that demon!\n\n");
	
	output("Glancing down at him, you remark that the little bastard is quite handsome for an imp.  With his perfect jawline and marvelous cock, you find yourself hard-pressed to justify resisting him so long ago.    How did you resist his charms?  His cock feels soooo fucking good inside you.  With an explosive burst, [pc.multiCocks] erupts again, squirting thick arousal and submission into the milker while your [pc.vagina] wrings Zetaz's nodule-ringed cock incessantly.  His turgid member bulges obscenely, and he starts to cum inside you, squirting master's thick seed into your breeding hole.  Breeding hole?  Why would you call your slutty fuck-hole a breeding hole?  Something seems off about that last thought, but you can't place it.\n\n");
	
	output("Your master finishes squirting inside you and withdraws, pawing at your milk-leaking teats for a moment as you continue to shudder and cum like a good bitch.  Wow, you really are a good bitch aren't you?  Pride wells in your breast as the imp's chanting reaches a crescendo and a relaxed smile forms on your [pc.face].  Yes, you're a good, breeding bitch.   Master is smiling up at you and you know you've made him feel very happy.  Hopefully he'll come back soon and fuck you some more.  Your pussy feels so empty without him.");
	//pc.orgasm();
	//dynStats("cor", 50);
	pc.cor(50);
	clearMenu();
	addButton(0, "Next", ZetazCaveZetazBadEndEpilogue);
}
	
//M-Males – drugged & pegged, slowly have their memories erased/brainwashed.
//[Males]
public function ZetazCaveMalesZetazOver():void {
	clearOutput();
	output("You've been so thoroughly ");
	if(pc.HP() <= 1) output("beaten");
	else output("teased");
	output(" that you don't even resist as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you... not with food anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ");
	if(cor() < 33) output("shame");
	else if(cor() < 66) output("confuse");
	else output("arouse");
	output(" you as you're thrown atop one of the tables and rolled onto your side.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your " + pc.legs() + " are kept spread to allow easy access to [pc.multiCocks] and [pc.multiCocks].\n\n");
	
	output("Zetaz leaps atop the table in a single bound, the barely concealed bulge in his loincloth dangling freely underneath.  You begin to struggle, fearful of the cruel imp's intentions and ");
	if(pc.ass.capacity() < enemy.cockVolume(0)) output("worried he'll try to force the mammoth between his thighs into your backdoor");
	else output("worried he'll take advantage of your well-stretched backdoor");
	output(", but your feverish efforts are in vain – the restraints are too strong!  The imps start to laugh at your predicament, and Zetaz pushes the humiliation a step further by stepping squarely on your groin, painfully squeezing your [pc.cock] with his heel.  He throws his arms up in the air and shouts, \"<i>I am your champion!  I have brought the scourge of our kind to his knees, and ground him under my heel!</i>\"\n\n");
	
	output("You whine plaintively and squirm under the imp's heel, utterly humiliated and helpless.  Zetaz smirks down at your taunts, \"<i>What's the matter?  Is something bothering you?</i>\"  He raises his foot, letting you gasp, \"<i>Thank you,</i>\" before he delivers a kick to your gut, knocking the wind out of you.  Restrained as you are, your body convulses underneath the leather, trying to curl up while your diaphragm spasms repeatedly.  A strap is fastened around your head, and a ring gag is slipped into your mouth, holding it open and ready for whatever sick plans the imps have devised.\n\n");
	
	output("The imp lord gestures at his underlings with an irritated scowl while you catch your breath, and the horde scrambles to satisfy him before they can draw his ire.  A funnel with a clear tube suspended from the bottle is passed from the mass of bodies up to Zetaz, along with a few bottles filled with roiling pink and red fluids.   The funnel's exit-tube is threaded into your ring gag and there's nothing you can do but grunt in wide-eyed panic while it's secured in place.  The first bottle of what you assume to be lust-draft is upended into the funnel, and there's nothing you can do but drink or drown.\n\n");
	
	output("It has a bubblegum-like taste that makes your tongue tingle as it passes into your belly, but the more pressing sensation of [pc.multiCocks] getting rock-hard lets you know exactly what you just drank.  Even though you just finished chugging down that foul drink, the imps uncork another pair of potions and dump them into the funnel.  The sweet fluids flood your mouth, and once again you swallow and chug rather than drown.   After you finish the last swallow, you pant, completely out of breath and getting hotter by the moment.  Your [pc.skin] tingles and sweats, growing more and more sensitive with every passing second while [pc.multiCocks] begins to drip and drool.\n");
	
	output("Zetaz hands the funnel to an underling with a knowing laugh and repositions himself over your [pc.legs].  Warm pressure pushes at your [pc.asshole], forcing your clenching flesh to yield around the intruder.  Normally such an instant penetration would be irritating, or perhaps painful, but the sudden pressure on your prostate only serves to release a copious squirt of pre-cum.  An unwelcome moan slips past your lips and sends a titter of laughter through the mob.  As if losing wasn't bad enough – they all know you're getting off on having your [pc.ass] penetrated.  The worst part is that the humiliation is just making the situation hotter and [pc.multiCocks] harder.\n\n");
	
	output("You nearly choke as an unexpected wave of potions washes through the funnel into your mouth, but you start swallowing and gulp down what feels like a half-dozen lust potions before you can breathe again.  [pc.multiCocks] starts squirting and spurting, dumping heavy loads of cum onto the table and your belly from the effects of the potions alone.  Zetaz gathers a massive dollop in his hand and smears it over himself, using it as lubricant to penetrate your poor, beleaguered asshole with savage, rough strokes that smash against your prostate at the apex of each thrust.  You moan loudly and lewdly through the tube in your mouth, wriggling against your restraints and spurting helplessly as you're penetrated over and over.\n\n"); 
	
	output("As soon as your orgasm concludes, another wave of aphrodisiacs enters your mouth, and you have to drink all over again.  Something warm flashes in your backside, making you feel stuffed and hot, but then Zetaz pulls his cock free and another, slightly different prick is buried in your asshole.  The imps take turns battering your backdoor, force-feeding you potions, and sometimes even jerking you off to see how much you squirt, until your mind shuts down from the constant assault of drugs, sex, and pleasure.\n\n");
	
	//dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
	pc.libido(100, true);
	pc.lust(pc.lustMax(), true);
	pc.cor(50);
	clearMenu();
	addButton(0, "Next", ZetazCaveMalesZetazOverPtII);
}

public function ZetazCaveMalesZetazOverPtII():void {
	clearOutput();
	output("You wake to a desert-dry, sandpapery feeling in the back of your throat as yet another moan escapes your mouth.   The ring gag is still there, and easily thwarts your tongues attempts to lick at your parched lips, but the jolts of pleasure exploding up your spine make it hard to get upset about it.  Hips rocking, you keep squirting and squirting from your orgasm, feeling each hot blast burst from your manhood until the wave of lust passes and you open your eyes.  You're in a dim cave, the one they used to hold Vala, and chained up to the wall in a similar manner.\n\n");
	
	output("While you observe the room, you realize that the waves of pleasure sliding up your spinal cord haven't stopped, and that your entire body is being shaken rhythmically.  You look down with a look of incredible, still-drugged confusion and behold the last thing you expected to see.  Somehow [pc.multiCocks] has been shrunk to less than half of its previous size");
	if(pc.balls > 0) output(", and your balls have completely vanished");
	output("!  Just below your pint-sized shaft, a massive imp-cock is plowing in and out of your new, wet snatch with juicy-sounding slaps.  Y-you're a hermaphrodite!?  And what's happening to your dick?\n\n");
	
	output("A nearby imp with a limp dick and a bored-but-tired look on his face steps up after your orgasm and slathers your dick in some strange, pungent cream, chuckling up at you while he does so, \"Heh heh, your ");
	if(pc.cockTotal() == 1) output("cock's");
	else output("cocks're");
	output(" gonna be so tiny ");
	if(pc.cockTotal() == 1) output("it");
	else output("they");
	output("'ll make a baby's look huge.  Boss said we need to dose you with Reducto after each orgasm, so try not to cum too much while we gangbang you, okay?  Oh yeah, I almost forgot, I have to inject something too...</i>\"\n\n");
	
	output("The little demon picks an small, glass injector stamped in black ink with the words 'GroPlus'.  Your eyes go wide at sight of the lettering.  As your maleness dwindles, the imp carelessly flicks it to the side and lines the needle's tip up with your tiny bud – they're going to shrink your dick to nothing and pump your clit full of growth chemicals!  He plunges it in, lighting your world up with pain, but the bindings around your body prevent you from escaping or injuring yourself in struggle.  Heat erupts inside your clitty, and it visibly swells up until it nearly reaches the size of your shrinking wang.  Your rapist, or 'sexual partner' with how horny you are, thrusts hard inside you and swells, stroking your walls with the nubby protrusions of a demon's cock.  It feels so good that another orgasm builds on the spot.\n\n");
	
	output("With hot, tainted jism filling your womb, your body starts to spasm and squirt, actually making your increasingly tiny dick shake around from the force of ejaculation.  It splatters off the imp's horns and forehead, but he doesn't seem to mind much as he slumps down, dragging his still-rigid member from your cock-hungry fem-sex.  You moan wantonly, still spurting as the imp 'medic' applies another layer of Reducto to [pc.multiCocks], rapidly shortening ");
	if(pc.cockTotal() == 1) output("it until it's");
	else output("them until they're");
	output(" barely three inches long, even while hard.  He pulls out another plunger and rams the needle into your still-aching clit, making it swell until it's almost five inches long and trembling like your manhood used to.\n\n");
	
	output("\"<i>Now you're starting to look like a proper bitch.  ");
	if(pc.biggestTitSize() < 2) output("It doesn't look right without a decent rack, but boss said no tits for the new breeding bitch.  Sure makes it hard to get excited about fucking that new twat of yours though...");
	else output("With a rack like that and a nice, wet cunt, you'll have the other guys lining up for their turn in no time...");
	output("</i>\" rambles one of the imps.  You groan and shake your hips lewdly, still turned on after all the fucking, feeling empty without the unholy heat of an imp inside you.  A hunger buzzes away in your womb, demanding you get pregnant, and you're thrilled to see Zetaz stride in with a raging, fully erect stiffy.  It throbs hungrily as he smiles up at you and climbs atop the conveniently positioned platform.\n\n");
	
	output("\"<i>It looks like you're ready now, huh?  Nice, wet cunt, barely discernible dick, and a huge, lewd clit.  I considered getting rid of your dick, but I figured it would be more humiliating to keep that to remind you how far you've fallen.  And with all that cum dripping from that hole above your [pc.legs], you'll probably get pregnant, but I should make sure shouldn't I?</i>\" questions your old foe.\n\n");
	
	output("Before he gets started, Zetaz picks up another needle of GroPlus and jams it into your clit, making the love-button swell up to the size of a large, veiny prick.  He strokes it hard and slides himself into you, spearing you while you're distracted by the sensations of your over-sized buzzer.   The sudden penetration makes your eyes cross and your tongue loll out from its ring-gag prison.  You moan and pant, shaking against him, still dripping the last of your male orgasms from your tiny, under-sized dick onto your long, thick clit.\n\n");
	
	output("Zetaz laughs and pumps at the huge button; even though it's quite lacking in femininity, it still makes you squeal like a little girl.  Your [pc.legs] shake wildly, trembling against the wall while your juicy snatch gets fucked good and hard and the mixed jism boils out around the imp lord's massive, swollen member.   The fucking is hard, fast, and so brutal that you get off multiple times in the span of a few minutes, though the imps don't even try to dose you for each one.  Zetaz slaps your [pc.ass] a few times before he pushes himself to the hilt, stretching your well-fucked cunt to its limits.  He twitches and grunts, and a blast of gooey heat suffuses your core with corrupt pleasure.  Somehow you know, just know, that you'll be pregnant from this, but you have a hard time caring.  It feels too good...\n\n");
	
	//dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
	pc.libido(100, true);
	pc.lust(pc.lustMax(), true);
	pc.cor(50);
	clearMenu();
	addButton(0, "Next", ZetazCaveZetazBadEndEpilogue);
}

public function ZetazCaveZetazBadEndEpilogue():void {
	clearOutput();
	if(pc.hasVagina() && !pc.hasCock()) {
		output("The once-champion, [pc.name] was raped repeatedly by every imp that survived her initial assault.  Her mind never recovered from the initial orgy, and she found herself happy to be named 'Fuck-cow'.  She quickly became a favorite of Zetaz's ever growing brood, and surprised them all with her fertility and rapidly decreasing incubation times.  Within a few months, she was popping out litters of tiny masters even faster than Vala.  Within a year, her body was so well trained and her womb so stretched that she could keep multiple litters growing within at all times.\n\n");
	
		output("It was rare for Fuck-cow's cunt or mouth to be empty, and she delighted in servicing any male she was presented with.  Her masters even captured bee-girls, so that fuck-cow's ass could be kept as pregnant as her belly.  Fuck-cow came to love her masters dearly, and with her constantly growing ability to birth imps, she was able to incubate enough troops for Zetaz to challenge Lethice's armies.  The imps never managed to overthrow the old demon lord, but the land was eventually divided in half, split between two growing demonic empires.");
	}
	else if(pc.isHerm()) {
		//[Epilogue]
		output("The champion was fucked and brainwashed repeatedly for a few more days until Zetaz was sure she understood her place in the world.  Once rendered completely obedient, they released her from her bindings.  It was time she was turned over to Lethice.  ");
		if(!pc.hasWings(GLOBAL.TYPE_DEMONIC)) output("Zetaz gave her one of the weaker imps to penetrate and taught her to fly with her new, demonic wings.  ");
		else output("Zetaz gave her one of the weaker imps to penetrate during the journey.  ");
		output("With preparations complete, Zetaz, the champion, and a few dozen imps flew to the mountain peak.\n\n");
		
		output("The champion was presented to Lethice, and the demonic mistress was so pleased with Zetaz's gift that she gave him a pair of nubile slave-girls and promoted him over a small army of his own kind.  Once the imps departed, Lethice put the champion through her paces, using her as a fucktoy whenever the mood took her.  The rest of the time the champion was kept bound and unable to orgasm, tortured with unholy levels of arousal, but she didn't mind.  When Lethice allowed her to cum, the champion's orgasms were long and intense enough for her to love her mistress in spite of having to be so pent up.");
	}
	else {
		output("The imps never released the champion from that chamber after that.  'He' gave birth to a healthy litter of imps a few weeks later, and the hormones from the pregnancy ");
		if(pc.biggestTitSize() < 1) output("created a decent set of chest-bumps.");
		else output("swelled her already impressive rack with milk.");
		output("  After that, the imps really took a liking to her, and she was let down from her restraints.  She never got much chance to get up though; she was well and truly fucked at every opportunity.  She was already hooked.  With her incredible libido and the constant fucking, staying was the easy choice.\n\n");
		
		output("After a few months the champion started to become acclimated to her new life, and began birthing imps in larger broods with shorter gestations.  She had become the ideal broodmother, and her worldview shrank down to two powerful priorities: acquiring cum, and birthing.");
	}
	pc.orgasm();
	pc.HP(pc.maxHP());
	badEnd();
}