import classes.Characters.CoC.CoCGoblinAssassin;
import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.damageRand;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function goblinAssassinEncounter():void {
	clearOutput();
	//First Time Intro
	if (flags["COC.TIMES_ENCOUNTERED_GOBLIN_ASSASSIN"] == undefined)
	{
		output("A needle whizzes through the air and lands next to your foot. The fine craftsmanship along the side of the glass tube only brings you to one conclusion - it's owner has access to precision machinery and manufacturing capabilities uncommon in this land.");
		output("\n\nYou ready your [pc.mainWeapon] as the needle's owner makes herself known, jumping down from on high into the dirt. It's a goblin, but one with an air of confidence and poise, obviously an experienced fighter. Whether you planned on fighting or not, the goblin has no intention of letting you leave unspoiled.");
		//[Initiate combat encounter – goblin assassin]
	}
	//Repeat Intro - Cell Chambers
	else {
		output("A familiar sight catches your attention as a shadowy blur lands in front of you - another goblin assassin appears to be lurking around these parts. You ready your [pc.mainWeapon] as she straps on a belt loaded with various types of needles and assumes a combat stance.");
		//[Initiate combat encounter – goblin assassin]
	}
	IncrementFlag("COC.TIMES_ENCOUNTERED_GOBLIN_ASSASSIN");
	//if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
		//output("\n\n<b>New codex entry unlocked: Goblins!</b>")
	//}
	fightGoblinAssasin();
}

private function fightGoblinAssasin():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCGoblinAssassin());
	CombatManager.victoryScene(CoCGoblinAssassinPCVictory);
	CombatManager.lossScene(CoCGoblinAssassinPCLoss);
	CombatManager.displayLocation("GOB. ASSASSIN");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//[LOSS SEXAHNZ]
public function CoCGoblinAssassinPCLoss():void {
	clearOutput();
	if (!pc.hasGenitals()) {
		output("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"");
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
		return;
	} 
	
	if (pc.lustQ() <= 99) {
		output("You collapse, utterly beaten. To make sure you'll be easier to handle, the victorious assassin saunters up, a pair of fluid filled needles in her hands. She jams them into your [pc.legs], emptying the contents into you before you can so much as stammer a protest. Burning lust pours through your veins unbidden, and you moan out loud as the chemicals have their way with you as easily as the goblin soon will.\n\n");
		pc.lust(pc.lustMax());
	}
	
	var x:int = pc.cockThatFits(enemy.vaginalCapacity());
	//i. *Lust Loss – Male/Herm (Fits)(FENCRAFTED)
	//50% odds for herms
	if (x >= 0 && pc.hasCock() && (!pc.hasVagina() || rand(2) == 0)) 
	{
		if(!pc.isCrotchExposed()) output("You tear through your [pc.gear] in a rush, anything to release [pc.eachCock] from its hellish confinement.  ");
		output("You’re so aroused, so horny.  Any passing thoughts of modesty are immediately discarded and forgotten, washed away under the wave of your all-consuming lust as your fingers slide home around [pc.oneCock] and begin to play with the turgid tool.  You immediately buck from the sensation of incredible, pent-up need, nearly cumming on the spot.  Looking up, you meet the emerald-skinned woman’s eyes pleadingly.");
		output("\n\nThe goblin assassin watches impassively for a moment, but as your need intensifies, her attitude softens while your member hardens.  \"<i>Oh, I think I’m gonna regret this, but ");
		if (pc.cockTotal() == 1) output("that thing");
		else output("those things");
		output(" look mighty tasty.  You don’t mind if I sample just a little bit of your seed do you?</i>\"  The sapphire-maned beauty kneels down next to you and lets her tiny, delicate digits dance across the underside of [pc.cock " + x + "], drawing a lurid moan from your lips as she wonders out loud, “I don’t hear a no, " + pc.mf("stud", "sexy") + ".  That’s good... I’m just going to take a little bit of cum... just a few squirts.  Surely a ");
		if (pc.tallness >= 60) output("big, ");
		output(pc.mf("strapping young man", "sexy breeder") + " will have enough jizz to pay for " + pc.mf("his", "her") + " trespass?</i>\"");
		output("  Those delightful, dancing fingers pirouette down to your ");
		if (pc.balls > 0) output("[pc.sack], giving it a gentle caress before vanishing.");
		else if (pc.hasVagina()) output("[pc.vagina], the tips giving your soaked mound only the barest ghost of a touch.");
		else output("taint, the tips giving your sensitive skin only the barest ghost of a touch.");
		
		output("\n\nShe explains, \"<i>I won’t help with that until you give me an answer.  Be honest with yourself - you don’t care about other girls at all.  You just came up here to fuck a goblin assassin.  Am I right?</i>\"");
		
		output("\n\nYou try to answer ‘no’, but it trails off into a weak, ");
		output(pc.mf("almost ",""));
		output("girlish moan.  The need thrumming through [pc.eachCock] is telling you - no, demanding - that you do what she says and fuck her.  Like a beast in rut, you groan.  You look the short-but-stacked aggressor in her big, liquid blue eyes and make a decision entirely rationalized by your aching, drug-fueled needs.  Still pumping your shaft like a man possessed, you whimper, \"<i>Yes... I... I came to have sex with you.</i>\"");
		output("\n\nVeridian skin caresses you just above");
		if (pc.hasSheath()) output(" the sheath");
		else output("your base");
		output("for a brief moment but vanishes before you can gain any satisfaction from the act.  \"<i>I’m sorry, that was too slow,</i>\" the diminutive fighter teases, a moment before she slams a pair of needles into your [pc.legs].  [pc.EachCock] rises and imeediately spurts a trickle of white pre-cum, unable to resist the potent chemical concoction flooding your bloodstream, so perfectly tailored to inflame your passions past the point of reason.  You fail to notice the removal of the spent plungers, but you sure as hell notice the return of the lithe green woman’s probing caresses.  She whispers, \"<i>Now tell me how other girls don’t matter.  This was all just a ruse to get you some green love, wasn’t it?</i>\"");
		output("\n\nYour response is as immediate as it is enthusiastic.  You tell her exactly what she wants and then some more, panting and moaning as the assassin’s nimble fingers tickle every throbbing-hard inch of your over-filled fuck-tool.  It spews another rope of pre so thick and white it may as well be the real deal as you finish, begging, \"<i>Yes, I came here for your delicious, juicy cunny.  Please, fuck my cock.  I need it so bad!  I’ll do anything!</i>\"");
		output("\n\n\"<i>Awww, you’re squirting for me already.  I just hope there’s enough left to pay your fine.  If not, I can always put some succubi’s delight in a few of these needles,</i>\" muses the emerald slut.  She steps over you, the jiggly, rounded curves of her ass hanging over you for a moment before she drops her musky, squishing box straight down onto your nose and lips.  Droplets of fem-spunk roll down your cheeks as the goblin grinds her swollen mound against you, her fragrant pussy driving your neglected cock");
		if (pc.cocks.length > 1) output("s");
		output(" wild with need.  Thankfully, as soon as you submit to her puffy mound and give it a lick, a pair of soft, wrinkled feet wrap around your [pc.cock " + x + "], drawing out a thick flood of your pre-cum.");
		output("\n\nToes smear your precum around your [pc.cockHead " + x + "] before the warm soles drag them down the " + num2Text(Math.round(pc.cocks[x].cLength())) + " inches of your length, basting your [pc.cock " + x + "] in a mixture of goblin sweat and your personal juices.  You moan in delight, your sounds of rapture muted by the puffy, soaked lips that obscure your mouth, your cock spurting helpless trails of [pc.cumColor] submissively onto her feet.  Every brush of your lips is rewarded with caresses from the goblin’s tiny toes.  Every lick sends those squeezing, cum-lubed feet sliding up and down.  Every suck on her clit causes her pace to increase.  With encouragement like that, you cannot stop yourself from attending to the goblin’s syrupy box, worshipping her womanhood like a slave before an altar of a glorious god.");
		output("\n\nThe short, stacked woman moves her legs to lay your cock on her left foot while the entirety of her right foot presses down on your [pc.cock " + x + "]’s underside, squeezing a thick flow of your pent-up jism from the cum-slit at its tip.  Her sole rocks up and down your length, milking dollop after dollop of jizz onto the goblin’s toes.  After a while, she switches her legs to let her now-soaked foot do the rest of the squeezing.  You happily squirt and squirm, dripping like a sieve but not yet achieving true release.  The goblin, having no such problem, cums noisily atop you, numerous times.  Each successive squirt of girl-fluid soaks your face more than the one before, and by the time she’s done, your " + pc.hairDescript() + " is sticky with it, half-buried in a puddle of goblin-lust.  You’re so close.  So very close.  Just a little bit more... a few more strokes.");
		output("\n\n\"<i>");
		if (silly) output("Stop right there, criminal scum.");
		else output("Hold your horses.");
		output("</i>\"  The emerald assassin glances over her shoulder at you and urges, \"<i>Come on now.  Fill me up.  Let out all that spunk I’ve been making build up ");
		if (pc.balls > 0) output("in your balls");
		else output("inside you");
		output(".  Pay your ‘fine’, and I might let you go.</i>\"");
		if (pc.balls > 0) output("  A hand squeezes your [pc.sack] encouragingly");
		else output("  Hands squeeze your [pc.butt] encouragingly");
		output(" as the goblin impales herself to the hilt with a sloppy squelch.");
		pc.cockChange();
		output("  You orgasm, cumming hard inside her.  Your back arches, your body clenches, and rope after rope of seed sprays inside the goblin’s baby-hungry womb.  Her pussy seems to drink it down, wicking the jizz away from you just as fast as you can put it out.");
		if (pc.cumQ() >= 750) {
			output("  Even her near-supernatural fertility can’t keep up with your fantastic virility, and soon the goblin is sporting a small bump on her belly.");
			if (pc.cumQ() >= 2000) output("  It swells to a rounded, pregnant dome by the time you finish.");
		}
		output("  All of your passion spends itself in the glorious climax, leaving you feeling like an empty, wasted husk.");
		output("\n\nStanding up with your [pc.cum] dripping from her nethers, the goblin gives you a wink and disappears around a corner, leaving you alone to slumber.");
	}
	//ii. Lust Loss - Male - No Fit
	else if (x == -1 && pc.hasCock() && (!pc.hasVagina() || rand(2) == 0))
	{
		x = pc.biggestCockIndex();
		if(!pc.isCrotchExposed()) output("You tear through your [pc.gear] in a rush, anything to release [pc.eachCock] from its hellish confinement.  ");
		output("You’re so aroused, so horny.  Any passing thoughts of modesty are immediately discarded and forgotten, washed away under the wave of your all-consuming lust as your fingers slide home around [pc.oneCock] and begin to play with the turgid tool.  You immediately buck from the sensation of incredible, pent-up need, nearly cumming on the spot.  Looking up, you meet the emerald-skinned woman’s eyes pleadingly.");
		output("\n\nThe assassin sighs and grumbles, \"<i>Another one with a fucking tree-trunk for a cock.</i>\"  She begrudgingly slips out of her straps, perky, dark-green nipples popping free from their confinement to jut proudly from her chest.  “The downside of being a goblin,” explains the athletic green-skinned beauty, \'<i>is that around a dick like that... a heaving, pulsating tower of cock-flesh like that... I’ve just gotta TRY it.</i>\"  Now nude, your captor saunters up, wide hips shaking from side to side with every step.  \"<i>Being a size-queen is suffering,</i>\" she finishes with a wry smile.");
		output("\n\nYou watch her tirade with confused indifference, comprehending little beyond the petite slut’s desire to mount your member.  Tracing your hands over the pulsating veins on your [pc.cock " + x + "], your body continues on autopilot, masturbating hard and fast for the emerald beauty as she climbs atop you.  Her juicy gash spreads over the bulge of your urethra as the goblin sinks down atop you, her legs splaying to the sides obscenely.  She commands, \"<i>Hands off bub.  You lost to a goblin, and that means you get to be a dad, whether you want to or not.</i>\"");
		output("\n\nThe puffy emerald curtains drape your dick in elastic goblin pussy and brush your feverishly pumping fingers away.  Your captor lets a lewd moan slip through her lips as she begins grinding along your mammoth pole, dragging dark-hued genetalia back and forth on your massive dong.  A perky, hard little clit pops out of the top of the goblin’s glittery pussy-folds, visibly twitching in a display of supreme enjoyment.  Driven by your own insatiable desire, you shift under her, trying to slide your [pc.cock " + x + "] even faster through her pussy.");
		if (pc.biggestCockLength() > pc.tallness / 2) output("  Your incredibly long phallus blocks your view of the sultry goblin, and you never see the blow coming.");
		output("  A none-too-tender swat connects with your ");
		if (pc.balls > 0) output("[pc.balls]");
		else output("cock");
		output(" as the goblin grunts, \"<i>Stop squirming!</i>\"");
		output("\n\nYou hesitantly obey, too startled by the sudden pain to risk movement again.  You’ll just have to wait until the short, stacked woman decides she’s had her fun and lets you get off.");

		output("\n\n\"<i>Oh, you finally figured it out?  You’re just livestock to me - just a cum-nozzle for me to play with until I tire of you and put you up in a pen.  Maybe if your cum is thick enough, I’ll take you back and chain you up with our other animals.  Of course, if I did that you’d have to pump out enough spunk to keep a few dozen matrons pregnant,</i>\" says the viridian tart in between the lurid squelches of her flexible pussy on your dick.  No... if she takes you back, you’ll never get to do what you came here for!  She drags herself forward until she’s ");
		if (pc.biggestCockLength() < pc.tallness / 2) output("sitting on your face, the [pc.cockHead " + x + "] of your maleness jutting against her drooling lips.");
		else output("sitting on the ground ‘above’ you, your [pc.cockHead " + x + "] reaching all the way up to spear her moist box, judging by what you’re feeling anyway.");

		output("\n\nHer soft feet clasp your dick from each side, displaying a level of flexibility you would not have expected from the girl.  The supple soles slide and caress your length.  Her toes curl around to stroke the sensitive sides of your urethral bulge.  Even the hard knobs of her heels cradle your [pc.cock " + x + "] underside as she masturbates you with her feet.");

		output("\n\nLubricated as they are by the copious vaginal drippings, the assassin's feet have an easy time bringing you to the very edge of orgasm.  Every squishy, delicate step she takes brings you closer and closer, and soon you are trembling beneath her sweat and fem-spunk lubricated soles.  ");
		if (pc.cumQ() >= 1000) output("You spurt huge dollops of pre-cum into her waiting twat thanks to your prodigious virility, though it is only a hint of things to come.  ");
		else if (pc.cumQ() >= 250) output("You drool a steady flow of pre-cum into her waiting twat, though it’s only a hint of things to come.  ");
		output("  \"<i>It won’t be long now.  Yeah, I’m an assassin, but I take care of myself too.  I keep these puppies nice and moisturized, just in case I need to use them on a freak-cock like yours.</i>\"");

		output("\n\nYou try to grunt in protest, but it’s muffled by your ");

		if (pc.biggestCockLength() >= pc.tallness/2) output("pulsating, iron-hard cock");
		else output("captor’s pillowy asscheeks");
		output(".  The goblin pulls hard with her feet, and her sloppy, stretched cunt just barely slurps in your entire [pc.cockHead " + x + "].  You shiver in delight from the tight, vise-like grip constricting your maleness, and nearly erupt from sensation when the little green minx manages to pull another inch inside herself.");
		pc.cockChange();
		output("  She trembles and shudders, her feet suddenly going wild along your length.  The goblin’s cushy soles smear along your [pc.cock " + x + "] with the wild abandon of one lost to pleasure, her juices squirting out from her slit as she climaxes.  The onslaught of touches is too much for your straining member, and with a tight, hot clench, you feel your imminent release has arrived.  A fat bulge appears at the base of your shaft, coupled with an explosion of warm pleasure from within you.  It travels from your base all the way towards the tip, before disappearing into the goblin with a cunt-stretching squirt.  She moans out loud, clearly enjoying the sensation of being stuffed with cream, and the two of you sigh together while your dick finishes pumping ");
		if (pc.cumQ() <= 10) output("dribbles");
		else if (pc.cumQ() <= 100) output("squirts");
		else if (pc.cumQ() <= 250) output("thick wads");
		else if (pc.cumQ() <= 1750) output("waves of [pc.cumVisc] spooge");
		else output("rivers of [pc.cumNoun]");
		output(" into the goblin’s box.");
		if (pc.cumQ() >= 2500) output(" Her belly rounds up nicely under your voluminous attentions.");

		output("\n\nThe green girl gives your [pc.cock " + x + "] a few last affectionate squeezes before she disentangles herself from you.  You slump down, still feeling a little turned on, and return to masturbating.  The goblin laughs, \"<i>A few more performances like that and I just might have to keep you.</i>\"  You play with yourself until you fall asleep, and even then, you dream of the feel of that silken pussy back on top of your dick.");
	}
	//iii. Lust Loss - Female
	else {
		output("Defeated by your own needs, your fingers dart to your [pc.gear], rapidly disassembling it in your hurry to expose your aching, tender puss to the goblin’s eyes.  The assassin watches you with an unimpressed, bemused expression, though she remains rooted in place, her gaze locked onto you as you succumb to your lusts.  Knowing that you have an audience, you twist and contort your body to present your [pc.chest] and [pc.vagina] to the petite greenskin.  Glistening moisture forms on your exposed nether-lips, tempting you to slide your fingers into their slick warmth.  As if you could resist.");
		output("\n\nYou begin masturbating, violently and unabashedly ravishing your form, forgetting entirely about the one who put you in such a state.  Parting your slippery flesh with questing digits, you lose yourself to the pleasant, warm explosions firing through your nerves with every caress of your honeypot.  At the same time, the fingers on your free hand ");
		if (pc.hasFuckableNipples()) output("piston in and out of your [pc.nipple], masturbating it just as hard as the real thing.");
		else output("squeeze around a taut nipple, twisting and pulling on it unthinkingly.");
		output("  Your masturbatory reverie is interrupted sudden impacts against both your wrists.");

		output("\n\nLooking on in confusion, you can only stare as the goblin steps over you, straddling your prone form and easily batting away every attempt you make to touch yourself.  She pulls off her belt of needles and casually removes a set of small leather thongs from its inner lining.  With practiced skill, she binds your hands together with a narrow leather leash.  You don’t resist, expecting the kinky viridian bitch is planning some perverse sex game to get you both off that much harder.  She smirks down and says, \"<i>I don’t see much point in fucking a two-bit twat like yourself, but you got me horny, so by Lethice’s drippy tits, you’re gonna get me off.</i>\"");
		output("\n\nBefore you can mutter a protest, the goblin pivots and drops atop your face, plugging your mouth-hole with her wet gash.  Musky fem-drool slimes over your cheeks, running down to the nape of your neck where it drips on the ground.  The goblin utters a quiet, appreciative moan, rocking her hips ever so slightly to drag the bump of her clitty across your parted lips.  She doesn’t do anything for your needs at all!  You try to protest, but all that gets you is a mouth full of slime, tangy and arousing though it may be.  The leather thong binding your hands goes taut as you try to pull your fingers back into your aching cunt, but in your compromised position, you cannot will up the strength to overpower the tiny, dominating minx.");

		output("\n\n\"<i>Oh, you wanna cum too?  Then you better lick faster, slut.  You’re not getting anything until you get me off,</i>\" taunts the face-fucking box’s owner.  Determined to convince her to tend to you, you close your mouth and hide away your tongue, bargaining with the only thing you can still control.");

		output("\n\nAn irritated slap cracks against the " + pc.skin() + " of your [pc.chest] with stinging force.  The explosion of pain sends stars through your cunt-clouded vision, but you hold fast, only giving a tiny muffle of discomfort.  Sighing, the goblin fiddles with her bandolier.  You can’t see what she’s doing, but you know she’s up to no good!  There’s a brief sting of pain in your arm, followed by a rush of ecstatic, burning euphoria.  Your [pc.vagina] juices itself, and you moan uncontrollably.  Lust thrums through your veins.  Desire mounts to new levels.  You can’t resist this... not anymore.  You open wide and start to lick, assaulting the lush green pussy with your tongue, anything to get her off and bring you the relief you ACHE for.");

		output("\n\nThere’s a momentary pain in your other arm, followed by a wave of vertigo.  In its wake, your arousal seems to double, climbing so high that your previous levels of sexual need seem insignificant by comparison.  Your [pc.hips] lift from the ground of their own accord, the electric sensation of every air current over your engorged mons too delicious to resist.  The goblin, clearly enjoying your efforts, comments, \"<i>Oh my, are you fucking the air?  Are you seriously getting off on feeling the breeze on your bare, exposed cunt?  And you’re so wet down there!  Honey, I’m a fucking goblin, but you’d put me to shame right now.</i>\"");
		output("\n\nYou suck on her clit to shut her up while sliding your [pc.butt] on the ground.  Every hump, every movement, and every pointless undulation against your phantasmal lover seems more fevered and desperate than the last.  Already, the dirt beneath you has turned into fragrant, soupy mud.  Your ass is painted brown with it, and the wet squishes it makes as you drag your bottom through the mud-puddle only serve to arouse you and your captor further.  She moans, \"<i>Want some more?  Mmm... I don’t think you’ll be able to get off like you are now.</i>\"");
		output("\n\nPanting into the goblin’s green, leaky cunt, you can’t do anything to answer except to hum against her lips and trace your tongue in circles over her clit.  You’re so turned on that you feel like your sense your orgasm, lurking over a hill that you can’t quite mount.  Your desperate, obscene motions bring you pleasure, but it just isn’t enough, even with the flood of accursed goblin drugs flooding your system.");

		output("\n\nA pinprick on your tender, engorged nipple is the only warning you have before another wave of narcotic aphrodisiacs assault your system.  Your muscles locks as your pussy seems to come alive, practically fountaining fem-slime.  The puddle beneath you is up your shoulders, but you’re too lost in fantasies of sex and the tasty cunt atop your face to care.  The goblin’s thick, well-rounded thighs squeeze on your head as she begins panting, \"<i>Fuck yes, lick it there you hungry slut, lick my birth-hole you insignificant tongue-slut.  I ought to bring you inside our city.  I’m sure we could put you in a stall, maybe lock everything but your mouth behind a wall and make you chain-lick dozens of pregnant green cunnies until you’re living on nothing but sticky-sweet girl-cum.</i>\"");
		output("\n\nYour eyes roll back, not that they had anything to look at besides curvy veridian buttocks, and your tongue goes absolutely nuts, whipping back and forth through the curtains of slime that drool down into your open, moaning maw.  The goblin grinds atop you, moaning loudly as she reaches her own peak, barely caring about your pleasure.  Thankfully, with the latest injection, your [pc.vagina] has grown so sensitive that every whisper of air over your red, swollen folds feels like an individual tongue.  You squirm, complete, irressistable need controlling your body from the waist down.  The torrent of lady-jizz that suddenly fills your mouth startles you for a moment, and then you too are cumming, your [pc.vagina] climaxing from nothing more than faint air currents.");
		output("\n\nPassing out in a puddle of mixed juices, you barely notice the goblin’s departure.");
	}
	output("\n\n");
	processTime(15 + rand(5));
	pc.orgasm();
	CombatManager.genericLoss();
}

//[WIN RAEPZ]
public function CoCGoblinAssassinPCVictory():void
{
	//spriteSelect(24);
	clearOutput();
	output("The assassin falls to her feet, desperately trying to regain her composure but ultimately caving in to the exhaustion of defeat. The leather belt that was once wrapped around her pillowy breasts now hangs unfastened around her waist, the syringes once adorning it now littered around her. A shattered needle by her side emits a sweet-smelling vapor that soon reaches her nose, causing the girl to blush furiously as lust begins to overcome her senses.  ")
	applyDamage(damageRand(new TypeCollection( { tease : 10 + pc.libido() / 10 } ), 15), enemy, target);
	output("\n\n");
	
	addDisabledButton(0, "Dick Fuck", "Dick Fuck", "This scene requires you to have fitting cock.");
	addDisabledButton(1, "DickTooBig", "Dick Too Big", "This scene requires you to have overly large cock.");
	addDisabledButton(2, "CorruptDick", "Corrupt Big", "This scene requires you to have overly large cock and high corruption.");
	addDisabledButton(3, "Dick In Ass", "Dick In Ass", "This scene requires you to have cock and high corruption.");
	addDisabledButton(4, "Jog Fuck", "Jog Fuck", "This scene requires you to have fitting cock.");
	addDisabledButton(5, "Breastfeed", "Breastfeed", "This scene requires you to have enough milk.");
	addDisabledButton(6, "Web Condom", "Web Condom", "This scene requires you to have spider abdomen and fitting cock.");
	addDisabledButton(7, "Pussies", "Pussies", "This scene requires you to have vagina.");
	//addDisabledButton(8, "Lay Eggs", "Lay Eggs", "This scene requires you to have ovipositor.");
	
	//if (pc.canOvipositSpider()) {
		//eggs = laySomeDriderEggsInGobboTwat;
	//}
	//cunt stuff
	if (pc.hasVagina() && pc.lust() >= 33) addButton(7, "Pussies", gobboGetsRapedFem);
	//Dick stuff:
	if (pc.hasCock() && pc.lust() >= 33) {
		//Corrupt too big scene
		if (pc.cockVolume(pc.biggestCockIndex()) > enemy.vaginalCapacity() && pc.cor() > 80)
			addButton(2, "CorruptDick", manRapesGoblinTooBig);
		//Regular too big scene
		if (pc.cockVolume(pc.biggestCockIndex()) > enemy.vaginalCapacity())
			addButton(1, "DickTooBig", manRapesGoblinTooBig);
		//It fits!
		if (pc.cockThatFits(enemy.vaginalCapacity()) >= 0) {
			addButton(0, "Dick Fuck", gatsGoblinBoners);
			addButton(4, "Jog Fuck", gobboGetsRapedMaleFits);
		}
		//Buttsex toggle
		if (pc.cockThatFits(enemy.analCapacity()) >= 0 && pc.cor() > 70) addButton(0, "Dick In Ass", gobboButtSecks);
		//Spidercondom
		if ((pc.hasTail(GLOBAL.TYPE_ARACHNID) || pc.hasTail(GLOBAL.TYPE_DRIDER)) && pc.cockThatFits(enemy.vaginalCapacity()) >= 0)
			addButton(6, "Web Condom", goblinCondomed);
	}
	//Breastfeed adds an option
	if (pc.lactationQ() >= 500) addButton(5, "Breastfeed", giveGoblinAMilkMustache);
	
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); } );
}