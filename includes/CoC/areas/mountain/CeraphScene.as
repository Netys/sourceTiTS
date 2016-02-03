import classes.Characters.CoC.CoCCeraph;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function encounterCeraph():void
{
	showName("\nCERAPH");
	if (flags["COC.PC_MET_CERAPH"] == undefined) ceraphFirstTime();
	else ceraphFirstTimeRepeat();
}

//[Initial Meeting Text]
private function ceraphFirstTime():void
{
	clearOutput();
	output("The demon steps out of the bushes and introduces herself, \"<i>This is the beginning of your life as Ceraph the Omnibus' slave-" + pc.mf("boy", "girl") + ".</i>\"\n\n");
	output("Ceraph adopts a suggestive pose and tweaks her nipple, clearly more intent on turning you on than physically harming you.");
	
	flags["COC.PC_MET_CERAPH"] = 1;
	
	clearMenu();
	addButton(0, "Next", fightCeraph);
}

//[PC 'BEAT OFF' Ceraph the first time...]
private function ceraphFirstTimeRepeat():void
{
	clearOutput();
	output("Ceraph saunters out of the bushes, uncurls a whip that lights aflame and says, \"<i>Time for your spanking!</i>\"\n\n");
	
	clearMenu();
	addButton(0, "Next", fightCeraph);
}

private function fightCeraph():void{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCCeraph());
	CombatManager.victoryScene(CoCCeraphPCVictory);
	CombatManager.lossScene(CoCCeraphPCLoss);
	CombatManager.displayLocation("CERAPH");
	CombatManager.beginCombat();
}

public function CoCCeraphPCVictory():void
{
	//Normal stuff here
	clearOutput();
	if (enemy.HP() <= 1) output("Ceraph collapses in a beaten, bloody heap.\n\n");
	else output("Ceraph masturbates futilely, too driven by desire to fight.\n\n");
	
	addButton(14, "Leave", function():* { processTime(20 + rand(10)); CombatManager.genericVictory(); } );
	
	addDisabledButton(0, "Fuck Her", "Fuck Her", "This scene requires you to have cock.");
	addDisabledButton(1, "Ride Her", "Ride Her", "This scene requires you to have vagina.");
	addDisabledButton(2, "Fuck Her Ass", "Fuck Her Ass", "This scene requires you to have fitting cock.");
	
	if (pc.lust() >= 33 && pc.hasGenitals()) {
		output("  Do you have your way with her? (And if so, which of your body parts do you do it with?)");
		
		if (pc.hasCock()) {
			addButton(0, "Fuck Her", maleFuckCeraphsPussy);
			if (pc.cockThatFits(enemy.analCapacity()) != -1) addButton(2, "Fuck Her Ass", buttRapeCeraph);
		}
		addButton(1, "Ride Her", rideCeraphsCockLikeaBAWSSexclamation11eleven);
	}
}

public function CoCCeraphPCLoss():void
{
	clearOutput();
	flags["COC.CERAPH_RAPE_COUNT"] = 0;
	output("The demoness touches your forehead, and suddenly your mind is awash with fetishes!  Judging by the playful look she has, it's temporary, and you play along.  ");
	output("Ceraph throws her head back and laughs as you ");
	
	if (pc.HP() <= 1) output("slump down, defeated");
	else output("give up and start masturbating");
	
	output(", \"<i>Really?  Is that it?  After being under my magic for so long, you try to make a stand and fail, like this?!  Pathetic.</i>\"\n\n");
	
	output("The demonic hermaphrodite steps one foot onto your chest");
	if (pc.biggestTitSize() > 1) output(", right between your [pc.breasts]");
	output(".  Her foot is arched like a high-heel, with a bone-like protrusion forming the heel and digging painfully into your chest.  She looks down at you, watching with a bemused expression while her right hand traces idle circles over her puffy feminine sex.  You can't help but enjoy the situation, pinned under the sexy demon and restrained by her heel.  Ceraph smirks and taunts, \"<i>So what am I to do you with you?  I want you to submit to my harem, not become a bound and unwilling slave.</i>\"\n\n");

	output("She reaches down to pinch one of your erect nipples, \"<i>Though I'm sure you'd enjoy the restraint and humiliation...  I suppose I'll just have to punish you for your transgression and hope you've learned your lesson.  Now I'm not letting you go until you get me off or suffocate, so I hope you have a talented tongue!</i>\"\n\n");

	output("For a brief, confused moment you wonder what she means, but then your hands and [pc.legs] are swiftly hog-tied together with her whip.  Ceraph is so quick at her task that she finishes before your dumbstruck mind gets a handle on the situation.  You're utterly helpless to resist this demon's whims, and the best you can do to resist her would be to roll on your side.  It would be a hopelessly futile gesture, and you resolve to deal with whatever is to come without showing any fear or remorse.\n\n");

	output("The sky is blocked out by Ceraph's curvy shadow as she steps over your head, dripping sweet-smelling demonic fluids onto your [pc.face].  An inch at a time, she lowers herself down, her sex dripping anxiously and her thick demon-shaft pulsating hotly.  The fluid-slicked lips get closer and closer to your own, dripping more and more moisture from the excited demonette's passage onto your neck.  Plunging down with violent force, she slams her hungry twat against your [pc.face], smearing you from chin to nose with demon-juice.\n\n");

	output("Her nodule-covered demon-cock flops across your nose and forehead, already dripping with thick pre-cum that slowly rolls up towards your [pc.hair].  Ceraph's well manicured hand wraps around, stroking it and totally blocking your view while her pussy continues to block your airflow.  Knowing that you've no choice but to get her off, you struggle with arousal of your own from the crude restraint. You open wide and plunge your [pc.tongue] inside her, tasting her sweet yet tangy fluids and feeling the oddly-textured interior of her passage.\n\n");

	output("Ceraph moans out, \"<i>Ooooh good fuck-toy, eat out your mistress' box!  How does it feel to suffocate on submission and fragrant demon-cunt?</i>\"\n\n");

	output("Rocking her hips, she grinds herself into you, enhancing her stimulation as you begin to run out of breath.  With a mix of frantic sexual need and desire for oxygen, you lash your tongue around inside her, tilting your head slightly to rub your nose against her clit.  Your efforts pay off, and the demon's taunts die off into moans and gasps that you would think were cute, were you not being smothered in dripping demon-box.\n\n");

	output("You start to black out as you feel her release a wave of seed onto your [pc.hair].  Though you're too far gone to realize it, your eyes are slowly rolling back as your vision goes black.  Copious demonic fluids fill your mouth while Ceraph gets off on riding your face.  You're nearly gone when she finally pulls herself off of you, jacking her cock off and splattering a few ropes of thick male cum onto your chest and neck.  Coughing and sputtering out her sexual fluids, you fight back to consciousness, humiliated and aroused beyond measure.\n\n");

	if (pc.hasCock()) {
		output("[pc.EachCock] is twitching and dripping pre-cum, on the edge of orgasm.  ");
	}
	if (pc.hasVagina()) {
		output("Your [pc.vagina] twitches, aching with the desire to be touched or filled, and your hips twitch lewdly, desperate for sensation.  ");
	}

	output("The perverse sexuality fills you with need, but Ceraph only smirks and puts her foot against your cheek, shoving your [pc.face] into the sex-fluid-filled mud.  She mutters, \"<i>It looks like you managed to save a few brain-cells this time slut.  Because you've been so disobedient you don't get to cum with me.  You can lay here and ache for sex for a few hours I think.</i>\"\n\n");

	output("Her whip uncurls itself from around you, but by some sorcerous trick, you're unable to separate your limbs and free yourself.  Ceraph snickers and gives your rump a crack with her whip before sauntering off, leaving you to lie there, growing more and more sexually frustrated.  Eventually you doze off into a sort of half-sleep, dreaming of being dominated as the demon's fluids dry on your face.\n\n");
	pc.girlCumInMouth(enemy);
	pc.lust(pc.lustMax(), true);
	processTime(90 + rand(30));
	CombatManager.genericLoss();
}

//(REQ's – HUGE WANG, Exgartuan or Jojo corruption, and !centaur)
private function hugeCorruptionForceFuckCeraph():void
{
	IncrementFlag("COC.CERAPH_RAPE_COUNT");
	clearOutput();
	var x:Number = pc.biggestCockIndex();

	output("You laugh at Ceraph's ");
	if (enemy.HP() <= 1) output("beaten, prone");
	else output("prone, masturbating");
	output(" form, \"<i>You fucking demons are all the same.  That smug superiority complex makes you forget that being a demon doesn't come with an invincibility clause.</i>\"\n\n");
	
	output("The hermaphrodite dominatrix frigs her dripping slit, getting off on the dominance in your words, but she still manages to snarl defiantly, \"<i>F-uuuck off.  Just... rape me or whatever and get it over with.</i>\"\n\n");
	
	output("She's quite the sore loser!  You drop your [pc.gear] on the ground and stroke your ");
	if (pc.cockTotal() > 1) output("largest ");
	output("[pc.cock " + x + "], feeling the blood pump into it.  The thick, penile flesh inflates to the ludicrous size it adopts every time you get hard.  Ceraph's eyes widen into dinner plate-sized saucers of shock as she beholds the behemoth that sprouts from your loins.  She actually tries to scrabble away in the dirt, but she fails miserably.  ");
	if (enemy.HP() <= 1) output("Her hands are too busy starting to pump away at her nodule-covered demon-dick to help her crawl away.");
	else output("Both her hands are too busy at her groin to help her escape.");
	output("\n\n");

	output("You drop the swollen mass of dick-flesh on top her, pinning her under the weight of your lust.  Ceraph gasps in shock and pain, but her hard nipples are pressing tightly into your [pc.cockNoun " + x + "]'s underside.  The slut is loving it – could she secretly be a submissive?  It doesn't matter one way or the other; this demon is going to pay.  You shimmy back, dragging the elephantine fuck-stick over the defeated demon's body until the bloated tip is resting on her purplish demon-snatch.  She screams, \"<i>OH FUCK NO!  That would kill me!  Please, don't!</i>\"\n\n");

	output("Please?  She said the magic words.  ");
	output("You blink your eyes closed and focus your corruptive powers in your crotch.  ");
	output("Pleasure blooms in your midsection, spreading through your over-sized prick until it begins to dribble from the tip in the form of black ooze.  The viscous, dark substance splashes into Ceraph's demonic cunt, wicking into her drippy hole in an instant.  She moans, probably getting off on the influx of perverse magic.  The effect is immediate and gravity is able to pull your tip into her unassisted.  The demon's corrupted cunt starts to stretch around you, and you haven't even started to push!\n\n");

	output("The flawless skin of her thighs slips through your fingers before you get a grip on her legs, just below the knees.  Ceraph is alternatively moaning and begging, \"<i>Wha-what are you doing to meeee?  Stop... please... don't... push it in!  Oh by the Queen, it's good... it shouldn't feel goooooood...</i>\"");
	pc.cockChange();
	output("\n\n");

	output("She doesn't seem to mind receiving it at all.  You push forwards into the clenching tightness of a demon's pussy and groan with delight at the feeling of her tight walls clamping down on you.  The once-dominatrix's belly visibly distorts, mirroring the shape of your member as her cunt expands to handle you.  Her curvy hips visibly shift, spreading apart as Ceraph's body bends to your will.  Your [pc.cockHead " + x + "] hits a token block of resistance, but a quick spurt of black, transformative cum dilates her cervix to allows you to pass through. The demonic love canal continues to widen in order to accept the gift of your [pc.cock " + x + "] and you have an easy time pushing the distortion past her belly button to just below her large, firm breasts.\n\n");

	output("Even with your dark magic twisting her body, it doesn't look like Ceraph's body can take any more.  Her mind sure as hell can't; her eyes are rolled most of the way back and she's panting pornographic nonsense, \"<i>Fuck.. ahh... pussy-cock... oooh... so... big... more... cum-sleeve...</i>\"  You're a bit disappointed that you've broken her already, but it quickly fades when you feel her body sucking more of you inside her.  It might be her inherent magic falling under your influence, or maybe her fractured personality has decided to assist you in fully penetrating her.  Whatever the case, a cylindrical bulge forms between her tits, mirroring every vein of your [pc.cock " + x + "] through her skin.\n\n");

	output("Ceraph's throat balloons out to handle your girth, just in time for her to suck you further inside.  You aren't even pushing forwards at this point; her entire body feels like the inside of a succubus' cunt, entirely focused on pleasing male organs.  Her babbles cut off into pleased gurgles, and then die down entirely.  You aren't sure how she's breathing, but her jaw unhinges and stretches obscenely.  You can actually see your tainted pre-cum spilling out from between her lips to run down her face, and then your cunt-slicked tip is tasting the air.");
	if (pc.cocks[x].cLength() < 68) output("  It's impossible!  You aren't long enough for that.  Her body must have shrunk itself to a more appropriate length...");
	output("\n\n");

	output("As you're squeezed and massaged by ");
	if (pc.cocks[x].cLength() < 68) output(num2Text(int(pc.cocks[x].cLength() / 12)));
	else output("six");
	output(" feet of love-tunnel, you struggle not to blow your load.  ");
	if (pc.cocks[x].cLength() > 84) output("You've still got a lot more dick to get wet, and you start pushing the rest through her, using her like a plus-sized, organic onahole.  ");
	else {
		output("You sigh happily, rubbing your [pc.sheath " + x + "] against her slippery, split slit, before you pull back and start fucking her like a plus-sized, organic onahole.  ");
	}
	output("The once-formidable demon sighs happily each time you pull back out of her throat, and the obscene 'schlick' her cunt makes as you penetrate it is auditory heaven.  You slap her tits and watch them jiggle, but the absurd eroticism of it all overwhelms even your perverse standards.  Ceraph slides down, bottoming out on you while her full-body cunt convulses with orgasm.  ");
	if (pc.cumQ() < 100) output("You squirt your load into the dirt, but some rolls back along the underside of your urethra, catches on Ceraph's upper lip, and drips up her cheek into her tangled hair.");
	else if (pc.cumQ() < 1000) output("You squirt your copious [pc.cum] everywhere, splattering the dirt and dripping white goo onto Ceraph's face, forehead, and hair.  By the time you finish she's got a nice glaze going on.");
	else output("You expel huge waves of seed in what can only be described as eruptions.  They splatter into the dirt, forming thick puddles that are joined together with each successful splash of goo.  In between blasts, a steady stream leaks from the tip, travels down the underside, and catches on Ceraph's lip.  The spunk-flow is pulled over her face and into her hair by gravity.  She's glazed white and dripping into a puddle by the time you finish.");
	output("\n\n");

	output("You push the used fuck-toy off your [pc.cockNoun " + x + "]");
	if (pc.cockTotal() == 2) output(" and marvel at the [pc.cumNoun] your other cock dumped into the puddle");
	else if (pc.cockTotal() > 2) output(" and marvel at the [pc.cumNoun] your other cocks dumped into the puddle");
	output(".  Ceraph's pussy gapes at least " + num2Text(int(pc.cocks[x].thickness() + 1)) + " inches wide, pushing her hips so far apart as to make it difficult to walk.  She shudders, drooling spit, pussy-juice, and sperm as her mouth, neck, and chest tighten up.  Her lower body doesn't change one iota; your magics are still overpowering her natural abilities below the waist.  The abused dom twitches a few more times before her eyes reappear and she pulls her tongue back into her mouth.\n\n");

	output("Ceraph gasps, \"<i>Ohhhhkay.  That felt goooooooood.</i>\"  She gathers some of your sperm from her space and swallows it with a smile before she offers, \"<i>You've shown me a good time, mortal.");
	output("</i>\"\n\n");
	//Y/N – remove 1 fetish level or +10 gems
	enemy.loadInCunt(pc);
	processTime(40 + rand(10));
	pc.orgasm();
	pc.slowStatGain("libido", 3);
	pc.cor(1);
	CombatManager.genericVictory();
}

internal function buttRapeCeraph():void
{
	IncrementFlag("COC.CERAPH_RAPE_COUNT");
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	if (x < 0) x = 0;
	clearOutput();
	output("Completely defeated, the haughty demoness lies face down in the dirt, ");
	if (enemy.HP() <= 1) output("her tail hanging limp between her legs.  She spits a wad of bloody saliva and says, \"<i>What's the matter?  Beat a girl senseless and lose your nerve?  I thought you were going to rape me.</i>\"");
	else output("her rump up in the air while her tail plunges violently into her cunt over and over again.  She moans up to you, \"<i>What's the matter?  Are you nervous about putting it inside me?  Come on... rape me already!  Punish my gushing-wet cunt with your divine rod!</i>\"");
	output("\n\nYou reach down and slap her ass hard, ");
	if (pc.physique() < 40) output("making her whole body jiggle");
	else output("making her jiggle and slide a few inches in the dirt");
	output(" and shutting her up while you tear off your [pc.gear].\n\n");

	output("Now naked, you waste no time in grabbing her by her toned thighs and lifting her up, rubbing her face in the dirt while you get a nice look at her tightly-clenched asshole and ");
	if (enemy.HP() <= 1) output("wet ");
	else output("achingly wet ");
	output("demon-twat.  Her vulva flares out, massively engorging and unfolding like a flower, practically begging you to plunge into the dripping tunnel.\n\n");

	output("\"<i>Nooooo... don't stick it in my pussy!  You'll get me pregnant!  Or is that what you're after?  Are you gonna keep cumming in my naughty hole until I'm too pregnant to move?  Is that your plan, champion? Are you going to keep all the demons too pregnant to resist you?  Look at how wet you've made my pussy... I'm a high class demon, y-you can't make me pregnant!  Nooooo,</i>\" groans Ceraph while her tail wraps around your [pc.cock " + x + "], clearly trying to entice you, but you've got a surprise in store for her.\n\n");

	output("You rub your [pc.cockHead " + x + "] against the demonic juice-fountain, letting Ceraph slather you with corrupted lubricants while you tease her whorishly-ready fuck-lips.  In seconds you're soaked from tip to hips, and before Ceraph can con you into filling her full of demonic children, you drop her low and ram your [pc.hips] forward.  Her pucker, though tight, yields before your onslaught, gradually dilating to accept your [pc.cockHead " + x + "] and the first few inches of your [pc.cockNoun " + x + "].");
	pc.cockChange();
	if (pc.cockTotal() == 2) output("  The other [pc.cock " + (x == 0 ? 1 : 0) + "] rubs against her butt-cheeks, sliding through them with ease thanks to her copious secretions.");
	else if (pc.cockTotal() > 2) output("  The rest of your male genitals slide between the demoness' pert butt-cheeks in one huge, femcum-slicked bundle.");
	output("  Ceraph squeaks in distress, taken completely by surprise and for once, completely lacking a witty retort.\n\n");

	output("The demon grunts like a wounded animal underneath you, her long, demonic tongue hanging out to flop in the dirt while you rock her half-comatose form closer to your crotch.  Inside, your [pc.cockHead " + x + "] squeezes past the tightness of her anal ring to the unusual warmth of a demon's innermost depths.  More and more of your [pc.cock " + x + "] slips into the wonderfully tight, hot little hole, the penetration growing ever easier as the defeated demon relaxes into her role as a cum-dump unworthy of your children.");
	if (enemy.HP() <= 1) output("  Cunt-juice splatters over your [pc.legs] as Ceraph's now-energetic tail plunges into her sodden box, pumping into it in time with the penetration of her asshole.");
	else output("  Cunt-juice dribbles over your [pc.legs] as Ceraph's tail slowly and purposefully plows her box, mimicking the penetration of her asshole.");
	output("\n\n");

	output("Ceraph whimpers and begs, \"<i>Noooo... you're raping my ass... g-get it out of there!  Aren't you supposed to be p-pure?  Untainted?  You're – unf – fucking a demon's butt like some kind of pervy animal!  Please... f-fuck my pussy.  I don't even mind if you don't wash it off... just stick it in my cunt.</i>\"\n\n");

	output("Like hell!  You pull harder, splitting her asscheeks until they're squished into your body, her cock-gaped asshole ");
	if (!pc.hasSheath(x)) output("barely touching your groin");
	else output("rubbing your sheath");
	output(".  The demon's ass is warm enough to make you feel you could melt like an icicle in an oven, the blissful sensations spurring you to play with her supple ass-cheeks while you enjoy the complete penetration of a demon's backdoor.  You give those cheeks a hard slap and pull back, enjoying the feel of her gloriously tight ring as it slides over the pussy-slicked length of your [pc.cock " + x + "].\n\n");

	output("Without waiting, you slam it back home, burying it in the swelteringly hot backside.  Ceraph grunts, her tail locked in time with you and clearly bringing her great pleasure.  You take the time to reach down and pull it out – if she's going to cum, she's going to cum to the feel of you packing her bowels full of wasted seed.  She cries in distress, \"<i>Noooooo... fuck you!  Please... at least let me cum from this.  You're fucking me so dominantly... so hard... by Lethice it's making me so soaking wet.  Please!  Let me cum, let me cum... letmecumletmecumletmecum!</i>\"\n\n");

	output("You don't let go of her tail.  She's going to pay for constantly trying to turn you into some kind of fetish-bound bitch!  You pump her hard, the echoes of your sweating bodies slamming together echoing over the mountainside, likely attracting all manner of demons and beasts.  A voice in the back of your mind warns you to hurry, lest you get caught unawares by another monster, and you speed up your thrusts in response.  Ceraph stops fighting after a few particularly powerful, hip-slamming hits, a string of pre-cum dangling from her half-limp cock.  Each frenzied butt-fuck squeezes out more of the stuff, but before she can cum, you feel your own orgasm hit.\n\n");

	output("Ropes of jism splatter into the demon's rectum, and while it turns her tight back-door into a drooling wet fuck-hole, it actually lowers the temperature to a saner threshold.  ");
	if (pc.cumQ() >= 500 && pc.cumQ() < 1500) output("Her belly bulges slightly from the cummy deposit, marking her even more obviously as a cum-bucket for your cock.  ");
	else if (pc.cumQ() >= 1500) output("Her belly burbles and swells, bulging out to look positively pregnant, though you know she's packed from the other end.  ");
	output("You pull out, and Ceraph's ");
	if (pc.cocks[x].thickness() < 3) output("slightly-gaped");
	else if (pc.cocks[x].thickness() < 5) output("gaped");
	else output("gaping-wide");
	output(" asshole leaks spunk everywhere. Disgusted with her");
	if (pc.cor() < 33 && pc.isNice()) output(" and a little bit by yourself");
	output(", you drop her like a discarded rag.  She moans and begins masturbating, half-insensate from the rough treatment.  You ignore her, get dressed, and get out of there before the mountain's beasts show up.  Ceraph is in for a wild night!\n\n");
	enemy.loadInAss(pc);
	processTime(30 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

//[Beat Ceraph And Rape Her]
//Ceraph's fluids boost PC libido and sensitivity massively either way.
internal function maleFuckCeraphsPussy():void
{
	IncrementFlag("COC.CERAPH_RAPE_COUNT");
	clearOutput();
	//UBER-Fullbodypenetration
	if (!pc.isTaur() && pc.biggestCockVolume() > 500 && pc.cor() > 90) {
		hugeCorruptionForceFuckCeraph();
		return;
	}
	
	var x:Number = pc.biggestCockIndex();
	if (pc.cockVolume(x) <= enemy.vaginalCapacity()) {
		//[Male] Fuck 'Dat Pussah
		//[lust]
		if (enemy.lustQ() > 99) {
			output("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Mindful of her demonic wiles, you pull her hands together and use a few tattered strips of cloth to bind them over her head.  Moaning with helpless desire, the demon grinds her crotch against your [pc.leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n");
		}
		//[hp]
		else {
			output("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Wary of the demon's abilities, you tie up her hands with a few tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n");
		}
		output("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me, champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n");

		if (pc.cor() < 33) output("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
		else if (pc.cor() < 66) output("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
		else output("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
		output("  It's too late for her to have any hope of swaying you anyway.  You strip off your [pc.gear] ");
		if (pc.exhibitionism() >= 66) {
			output("getting an exhibitionist thrill ");
		}
		output("and begin stroking [pc.oneCock], preparing to penetrate her.\n\n");
		
		output("Ceraph squirms in the dirt as you bring your [pc.cock " + x + "] closer and closer to her female hole, her cock twitching with need like some kind of perverse, mutant clit.  Her hips twitch at you, as if eager to devour your maleness.  You don't keep her waiting, ");
		
		if (pc.cockVolume(x) < 40) {
			output("and with a forceful thrust, you sheath yourself inside the demon's unholy pussy");
		}
		else output("and with a mighty effort, you force your over-sized cock inside her.  For a moment all you can do is stare in awe as it distorts her body – the fact that such a thing is possible puzzles you");
		output(".  Her interior is inhumanly hot and covered with thousands of slippery protrusions, each rubbing against your dick's flesh.  The orgy of sensation is incredible, and you immediately begin fucking your bound, demonic captive as the need to orgasm rises within you.");
		pc.cockChange();
		output("\n\n");
		
		output("The defeated omnibus mewls in mock protest, \"<i>Oh, don't cum in my demonic twat, dear champion!  If you do, you'll never want any other pussy ever again!</i>\"\n\n");
		
		output("You grunt, pounding her harder and faster than before, knowing you couldn't pull out of her vise-like pleasure-hole if you wanted to.  It feels too good to hold out or resist, and you drop down, adjusting your angle as you rape the beautiful omnibus.  You're grunting like an animal, humping her as fast as your body will let you, but she lies under you with a serene and enticing expression, as if she's greatly enjoying the situation and awaiting your orgasm.  You pinch her nipple roughly, irritated by her superior air, but it only makes her wriggling pussy get even wetter.  It clamps down on you, wringing your [pc.cock " + x + "] dry as it erupts in a powerful orgasm.\n\n");
		
		output("Ceraph squeals happily, her sultry visage fracturing into an uninhibited expression of pleasure as she cries, \"<i>Fill me with your seed, champion!  Dominate the demon with your mighty spear!</i>\"\n\n");
		
		output("Her purple-hued pussy spasms around you, its oddly textured interior rippling and sucking in time with your ejaculations, drinking down your [pc.cumNoun].  Ceraph squirms happily while her body absorbs your jizz with her impossibly pleasurable hole.");
		if (pc.cumQ() >= 500 && pc.cumQ() < 1000) output("  Her belly begins to rise with the volume of [pc.cumNoun] she's absorbed, and you finish your orgasm with a mildly pregnant demon underneath you.");
		else if (pc.cumQ() >= 1000) output("  Her belly rises quickly from the volume of [pc.cumNoun] you're pumping into her, swelling up until she looks ready to give birth, but her taut purple body seems to handle the strain quite well, save for her belly-button turning into an outtie with an abrupt 'pop'.");
		output("  The omnibus' nubby shaft twitches happily and squirts out tiny dribbles of demon-semen, too left out by the sex to achieve a truly enjoyable orgasm, but more than willing to leak cum.\n\n");
		
		output("Ceraph exhales with exhaustion and rubs her hands over her belly, cooing, \"<i>So, you really did give up all your semen to me.  I guess I'll have to name the first imp I birth from this after you, won't I?</i>\"\n\n");
		
		if (pc.cor() < 33) output("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
		else if (pc.cor() < 66) output("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
		else output("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit him on my cock first chance I get, dear.</i>\"\n\n");
		output("As you leave, you don't bother to spare a glance at the confused omnibus.  She isn't worth your time.\n\n");
	}
	else {
		//[MALE TOO DAMN BIGGA WIGGA]
		//[lust] 
		if (enemy.lustQ() > 99) output("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Wary of the demon's wiles, you pull her hands together and use some scraps of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [pc.leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n");
		//[hp] 
		else output("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat. Wary of the demon's abilities, you tie up her hands with a few pieces of tattered cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n");
		
		output("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please, don't rape me Champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n");
		
		if (pc.cor() < 33) output("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
		else if (pc.cor() < 66) output("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
		else output("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
		output("  It's too late for her to have any hope of swaying you anyway.  You strip off your [pc.gear] ");
		if (pc.exhibitionism() >= 66) {
			output("getting an exhibitionist thrill ");
		}
		output("and begin stroking [pc.oneCock], preparing to penetrate her.\n\n");

		output("The [pc.cockHead " + x + "] squishes flat against her twat, too big for her prodigious demon-cunt to swallow.  Spurred by frustrated desires, you lift her legs and wrap her girlcum-slicked thighs about your [pc.cock " + x + "]. Ceraph's smooth skin and soft thigh-flesh form a comfortably tight masturbation tube.  Starting slowly, you begin rocking back and forth, sawing your prodigious cock-flesh over her body.  The demoness swivels her hips underneath your [pc.cockNoun " + x + "], her slippery gash and near-crushed member feverishly rubbing into you.  Though you didn't get to truly violate her, her thighs and unblemished skin are more than good enough to bring you to the brink of orgasm.\n\n");
		output("The defeated omnibus wraps her arms around your [pc.cockNoun " + x + "] and whines lustily, \"<i>No, please!  You'll cover me in seed and despoil my face!  Please don't glaze me in that awful stuff!</i>\"\n\n");
		output("You grunt, hold the captive by her ankles, and use her like a disposable sex-toy.  The slap of your [pc.hips] slapping into her thighs echoes loudly, nearly drowning out the wet squishing of your [pc.cockNoun " + x + "] with each violent brush against her cuntlips.  ");

		if (pc.cocks[0].cLength() < 18) output("Your [pc.cockHead " + x + "] crests between her breasts with every stroke, bumping against her chin.  It grows larger as the pleasure of the act intensifies to orgasmic levels.\n\n");
		else if (pc.cocks[0].cLength() < 24) output("Your [pc.cockHead " + x + "] slides over her cheek with every stroke, leaving a trail of pre-cum on her face.  The smudges of glistening pre grow larger and larger as the pleasure of the act nears orgasmic levels.\n\n");
		else output("Your [pc.cock] slides over her face with every stroke, smearing the demon's hair with your thick pre-seed before you pull back and dribble it on her face.  The pleasure of the act is incredible, and you feel yourself getting harder as the sensation nears orgasmic levels.\n\n");
		
		output("Ceraph squeals and blubbers incoherently for a moment as she cums, eventually managing to scream out, \"<i>Yes, splatter me with seed!  Punish this lowly demon with your powerful spunk.  Dominaaaaate meeee~</i>\"\n\n");
		
		output("Underneath your own mammoth erection, you can feel Ceraph's smaller cock twisting and squirming, unloading its own hot fluids onto her sweat-slicked belly.  She wriggles and twitches under you, her thigh muscles clenching and releasing in time with her spurts as they push you beyond your limit.  You watch your [pc.cock " + x + "] as it strains and squirts, dumping your thick load into the demon's ");
		if (pc.cocks[0].cLength() < 18) output("tits");
		else if (pc.cocks[0].cLength() < 24) output("face");
		else output("long hair");
		output(".  The orgasming demonette continues to squirt underneath you, drenching and smearing herself with even more cum and her entire mid-section looks glazed in thick whitish goo.");
		if (pc.cumQ() >= 1000) output("  Your prodigious fertility quickly forms a puddle around her, leaving the deceptive seductress practically submerged in [pc.cum].");
		output("\n\n");
		
		output("You sigh, feeling immense relief, and remove your softening bulk from atop her form.  Ceraph exhales in exhaustion and smears the mixture of cum over her belly, cooing, \"<i>So you really did give me a huge load.  I'll be sure to scoop a few batches of it into my womb so we can have lots of imps together.</i>\"\n\n");
		
		if (pc.cor() < 33) output("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
		else if (pc.cor() < 66) output("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
		else output("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit them on my cock first chance I get, dear.</i>\"\n\n");

		output("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.\n\n");
	}
	enemy.loadInCunt(pc);
	processTime(30 + rand(10));
	pc.orgasm();
	pc.slowStatGain("libido", 3);
	pc.cor(1);
	CombatManager.genericVictory();
}

//[Female] Ride 'Dat Cawk
internal function rideCeraphsCockLikeaBAWSSexclamation11eleven():void
{
	IncrementFlag("COC.CERAPH_RAPE_COUNT");
	clearOutput();
	//lust
	if (enemy.lustQ() > 99) output("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants. Wary of the demon's wiles, you pull her hands together and use some tattered strips of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [pc.leg], spreading her thighs apart into a near split and giving you a world-class view of her pulsating black demon-cock.\n\n");
	//[hp] 
	else output("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Mindful of the demon's abilities, you tie up her hands with some tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her pulsating black demon-cock.\n\n");

	output("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me!  I took a vow of chastity!</i>\"\n\n");

	if (pc.cor() < 33) output("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to get off on a sex-demon's tool.");
	else if (pc.cor() < 66) output("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
	else output("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");

	output("\n\nIt's too late for her to have any hope of swaying you anyway.  You strip off your [pc.gear] ");

	if (pc.exhibitionism() >= 66) output("getting an exhibitionist thrill ");
	output("and begin touching your [pc.vagina], getting yourself ready for what is to come.\n\n");

	output("You sink down, feeling yourself part around the hot demon-tool, its ring of crown-nubs stroking your walls as you slide down, and the bumpy texture of its shaft makes your [pc.legs] feel weak.  You drop the rest of the way down in one smooth, wet slide, ");
	if (pc.vaginalCapacity() < enemy.biggestCockVolume()) output("unable to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.\n\n");
	else output("able to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.");
	pc.cuntChange(0, enemy.biggestCockVolume());
	output("\n\n");
	
	output("Ceraph cries in mock protest, \"<i>No, don't make me cum inside you!  Please Champion, I swore not to spill my seed, lest I father a bastard child!</i>\"\n\n");
	
	output("The sensations of her vibrating nodules ensure you don't have the will or the strength to pull off of her, and what little power your [pc.legs] have is used to keep bouncing and grinding on top of her, filling the air with wet squelches and slippery squishes.  You fall forwards, barely catching yourself before you slam into the sultry demoness.  Your ");
	if (pc.biggestTitSize() < 1) output("chest ");
	else output("tits ");
	output("squish against hers, squeezing a gout of milk from her nipples.  Both pairs of ");
	if (pc.biggestTitSize() < 1) output("nipples");
	else output("jiggling mounds");
	output(" feel wonderful as they're pressed between you, sliding back and forth in time with your body's urgent grinding.\n\n");
	
	output("The omnibus' facade of feigned innocence drops under the force of the hot, wet fuck.  Her mouth opens into an 'o' of pleasure, and you feel her rod thicken as it begins pumping the proof of her ecstasy inside you.  The nodules that cover Ceraph's demonic erection wildly vibrate as she orgasms, throwing you over the edge and into the midst of a body-shaking orgasm.  Demon-seed floods your womb, squeezed inside it by your body's orgasmic contractions.  You shudder with the demon as you both begin calming down.\n\n");
	
	output("She groans, \"<i>Ooooh... Champion why did you make me despoil your womb?  ");
	if (!pc.isPregnant()) output("You're only feeding the swarms of imps that are despoiling this land.");
	else output("I'm sure whatever baby you have in there won't enjoy being so soaked in corruption.");
	output("</i>\"\n\n");

	if (pc.cor() < 33) output("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
	else if (pc.cor() < 66) output("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
	else output("You bend over and rub your belly while whispering in her ear, \"<i>Like mother, like child.</i>\"\n\n");
	output("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.\n\n");
	pc.loadInCunt(enemy);
	processTime(30 + rand(10));
	pc.orgasm();
	pc.slowStatGain("libido", 3);
	pc.cor(1);
	CombatManager.genericVictory();
}