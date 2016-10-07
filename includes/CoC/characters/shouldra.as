import classes.Characters.CoC.CoCShouldra;
import classes.CockClass;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCEctoplasm;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get shouldra():CoCShouldra
{
	return new CoCShouldra();
}

public function shouldraCombatStart():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(shouldra);
	CombatManager.victoryScene(defeatDannyPhantom);
	CombatManager.lossScene(loseToShouldra);
	CombatManager.displayLocation(shouldra.short.toUpperCase());
	CombatManager.beginCombat();
}

public function shouldraSprite(ghost:Boolean = false):void {
	if (followerShouldra()) showName("\nSHOULDRA");
	else if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] != undefined) showName("\nGHOST GIRL");
	else showName("\nPLAIN GIRL");
}

//Implementation of TimeAwareInterface
public function ShouldraTimePassedNotify():void
{
	if (minutes != 0) return; // once per hour
	
	if (flags["COC.SHOULDRA_MAGIC_COOLDOWN"] >= 1) flags["COC.SHOULDRA_MAGIC_COOLDOWN"]--;
	if (followerShouldra()) {
		if (pc.statusEffectv1("Exgartuan") == 1 && pc.hasCock() && rand(10) == 0) {
			if (flags["COC.SHOULDRA_EXGARTUDRAMA"] == 1) {
				eventQueue.push(exgartumonAndShouldraFightPartII);
			}
			else if (flags["COC.SHOULDRA_EXGARTUDRAMA"] == 2) {
				eventQueue.push(exgartumonAndShouldraFightPartIII);
			}
		}
		flags["COC.SHOULDRA_SLEEP_TIMER"]--;
		shouldersWarnings();
		if (flags["COC.SHOULDRA_SLEEP_TIMER"] == 0 || (flags["COC.SHOULDRA_SLEEP_TIMER"] < 0 && flags["COC.SHOULDRA_SLEEP_TIMER"] % 16 == 0)) {
			shouldraWakesUpOrPokesPCsForShitsAndGigglesIdunnoHowLongCanIMakeThisFunctionNameQuestionMark();
		}
		if (flags["COC.SHOULDRA_PLOT_COUNTDOWN"] > 0 && hours == 3) flags["COC.SHOULDRA_PLOT_COUNTDOWN"]--;
	}
}
//End of Interface Implementation

private var ShouldraTimePassedNotifyHook: * = ShouldraTimePassedNotifyGrapple();
private function ShouldraTimePassedNotifyGrapple():* { 
		timeChangeListeners.push(ShouldraTimePassedNotify);
		followerCampMenuBlurb.push(followerCampMenuBlurbShouldra);
	}

//Intro
internal function shouldraGreeting():void {
	shouldraSprite();
	clearOutput();
	
	if (silly && flags["COC.SHOULDRA_SILLY_ENCOUNTER"] == undefined) {
		//NO MUTANTS ALLOWED
		if (pc.cockTotal() > 1 || pc.faceType != GLOBAL.TYPE_HUMAN || pc.legType != GLOBAL.TYPE_HUMAN || pc.hasTail() || pc.hasHorns() || pc.cor() > 15 || pc.longestCockLength() > 10 || pc.tallness < 65 || pc.tallness > 78 || pc.hasVagina()) {}
		else {
			superCoolPaladinSexStuffDudeGasmJizzMonkies();
			return;
		}
	}
	
	//First 3 encounters
	if (flags["COC.TIMES_MET_SHOULDRA"] == undefined || flags["COC.TIMES_MET_SHOULDRA"] < 3) {
		output("You step into the ruins of the village cautiously, zigzagging through passageways and searching for anything worth pocketing. A sound from the inside of a half-collapsed cottage stops you in your tracks. You furrow your brow, upset at allowing yourself to drop your guard in a place like this. Unluckily, the presence seems aware of you, and you hear it shuffling towards the disfigured doorway. You drop into a crouch, [pc.readyingWeapon] and preparing for battle. You are caught off-guard when a completely normal female leg steps out of the frame. The young woman takes a few steps closer, apparently ignoring your intimidating stance for a moment as she sizes you up. ");
		//([if first time] 
		if (flags["COC.TIMES_MET_SHOULDRA"] == undefined) output("\"<i>You're the asshole that took my racks, aren't you?  I was hoard-...er, I was keeping an eye on those!</i>\" she accuses, eyes narrowing angrily.  ");
		output("Finally, she acknowledges your readiness to fight. With a sigh and a shrug, she raises her arms and drops into an orthodox boxing stance. Once again, you [pc.readyWeapon].");
	
		//fight
		clearMenu();
		addButton(0, "Next", shouldraCombatStart);
	}
	//(after three encounters with her)
	else {
		if (flags["COC.TIMES_BEATEN_SHOULDRA"] >= 3 && flags["COC.TIMES_MET_SHOULDRA"] % 10 == 0 && allowFollowers()) {
			initialShouldersRecruitment();
			IncrementFlag("COC.TIMES_MET_SHOULDRA");
			return;
		}
		output("You step into the ruins of the village cautiously, zigzagging through passageways and searching for anything worth pocketing. A now-familiar sound from inside one of the half-collapsed cottages gives you pause, and you're not surprised when a normal-looking girl steps out and faces you. She plants her hands on her hips, cocking her head curiously. \"<i>You again?</i>\" she asks amiably, the beginnings of a grin playing across her freckled features. \"<i>Now, you couldn't have come back just to see me.</i>\"\n\n");
		
		output("Before you can either confirm or deny her suspicions, she falls into a fighting crouch, beaming at you from behind her raised fists. \"<i>What say we have a friendly little brawl?</i>\" she asks. \"<i>I win, I get to play with you.</i>\"  With a nod, you [pc.readyWeapon] and get ready for a fight.  \"<i>You don't stand a ghost of a chance,</i>\" she teases.\n\n");
		
		//(option to skip the fight and just get to the sex, have to have beaten her five times beforehand [add this to the 3-encounter text when it happens, basically])
		if (flags["COC.TIMES_BEATEN_SHOULDRA"] >= 3) {
			output("\"<i>Or... maybe not?  Truth be told, I think you've proven your ability to pummel me enough.  Wanna just skip to the good part?</i>\"\n\n");
			//([if first time] 
			if (flags["COC.TIMES_BEATEN_SHOULDRA"] == 3) output("You can't say you saw that coming.  It seems she has offered to forego the fight in lieu of sexings.  ");
			output("Would you like to accept her offer, or do you want to fight her regardless?");
			//Now back to the good part!
			clearMenu();
			addButton(0, "Accept", yankeeEchoPapa);
			addButton(1, "Fight", novemberAlphaHotel);
		}
		else {
			//FIGHT!
			clearMenu();
			addButton(0, "Next", shouldraCombatStart);
		}
	}
	IncrementFlag("COC.TIMES_MET_SHOULDRA");
}

//[yep]  
private function yankeeEchoPapa():void {
	shouldraSprite();
	clearOutput();
	output("You graciously accept her offer, and she nods happily.  \"<i>Perfect!  Now then, let's get to it...</i>\"\n\n");
	//[skip to 'let her in' text (i.e. win sex intro)]
	clearMenu();
	addButton(0, "Next", littlePigLittlePigLetMeIn);
}

//[nah] 
private function novemberAlphaHotel():void {
	shouldraSprite();
	clearOutput();
	output("You shake your head slowly, [pc.readyingWeapon] as you regard her.  \"<i>Ah, so that's how you want it?</i>\" she titters, a smile gracing her features.  \"<i>In that case, enough talk... have at you!</i>\"\n\n");
	clearMenu();
	addButton(0, "Next", shouldraCombatStart);
}

//Victory Scenarios
//Ghost Girl Defeated
internal function defeatDannyPhantom():void {
	shouldraSprite(true)
	clearOutput();
	//defeat by damage)
	if (enemy.HP() <= 1) {
		output("With an ear-splitting, ghostly wail that forces you to your knees, the ");
		if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] >= 1) output("ghost ");
		output("girl falls back, overcome by her injuries. Before you can stop her, she simply becomes insubstantial, her clothes undergoing the change as well. A breeze slips through the ruins, picking the ghost up and scattering her to the winds.");
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericVictory();
	}
	//(defeat by lust)
	else {
		output("The girl glances down at her leggings, then does a double take, realizing as if for the first time she was completely overwhelmed by her lust. She sinks to her knees, dragging her breeches down and pressing a hand against her pubic mound.  ");
		if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] < 1) output("Strangely, the action seems to have little to no effect.");
		else output("Of course, the motion has no effect on her libido, due to her ghostly state.");
		output("  Looking up at you with what can only be described as desperation, she pants, \"<i>Please, hero... I need release... let me in?</i>\"  You take a step forward, stroking your chin softly in contemplation.  ");
		//([if first time]
		if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] < 1) {
			output("What does she mean, \"<i>let me in?</i>\" Do you want to find out?");
			clearMenu();
			addButton(0, "Yes", littlePigLittlePigLetMeIn);
			addButton(1, "No", noSlimingSlimer);
		}
		else {
			output("What do you do?");
			clearMenu();
			addButton(0, "Let Her In", littlePigLittlePigLetMeIn);
			addButton(1, "Deny", noSlimingSlimer);
		}
	}
	IncrementFlag("COC.TIMES_BEATEN_SHOULDRA");
}

//(deny entry)
private function noSlimingSlimer():void {
	shouldraSprite(true)
	clearOutput();
	output("You shake your head angrily at the brazen girl, ");
	//([if first time] 
	if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] == undefined) output("not feeling up to heed the strange girl's whims.");
	else output("mystified at the thought of letting a ghost possess your body.");
	output("You whirl about and stomp away.  She rises, screaming, \"<i>Fine! I'll go and take over a fucking goblin, again!</i>\" and storms the other direction. Before you move out of earshot, you hear a sniffle from the departing ");
	//([if first time]
	if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] == undefined) output("girl (what was that about her 'taking over' a goblin?)");
	else output("spirit");
	output(", and a twinge of guilt runs through you.");
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

//(let her in)
private function littlePigLittlePigLetMeIn():void {
	shouldraSprite(true)
	clearOutput();
	output("You decide ");
	if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] == undefined) output("you can afford being a little adventurous with the obviously desperate girl");
	else output("having a spiritual tag-along might be a bit of fun");
	output(", and agree to her request to possess you. She staggers to her feet and undresses, panting and shivering with unfulfillable sexual need. You reach out to her, drawing her");
	//[if <~7' tall]
	if (pc.tallness < 84) output(" into your arms for a tight hug");
	else output(" up into your arms for a tight hug");
	output(". The young woman heaves a happy sigh, then begins mumbling an incantation into your shoulder. Soon enough, the girl's body turns translucent and she begins to sink into you, planting a little peck on your cheek on her way in.  ");
	//([if first time] 
	if (flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] == undefined) output("Wait... WHAT!?  Did you just let some sort of... g-... g-... g-... G-... G-... GHOOOOOST possess you?");
	output("  \"<i>D-Damn,</i>\" she sighs, her voice wavering from her lust build-up, \"<i>Gotta get used to all of this " + pc.skinFurScales() + "...</i>\"  You adjust the best you can to the realization that you are sharing your body with a spirit, then turn your attentions to her. You telepathically ask her if she has anything in particular in mind for relieving her of her arousal. She pulses back a 'hmm' at you, indicating she will allow you to decide her fate.\n\n");
	
	IncrementFlag("COC.TIMES_POSSESSED_BY_SHOULDRA");
	clearMenu();
	
	if (pc.isHerm()) addButton(0, "Sex Here", hermaphroditeGhostsCumEctoplasm);
	else if (pc.hasCock()) addButton(0, "Sex Here", penisLossThatIsntALoss);
	else if (pc.hasVagina()) addButton(0, "Sex Here", ghostGinaWinSexings);
	else addButton(0, "Sex Here", genderlessGhostBuster);
	addDisabledButton(1, "Lake", "Lake", "This option requires you to have genitals and know more about local habitants.");
	//CHOICES HURRAH
	if (pc.hasGenitals() && ((flags["COC.BOAT_DISCOVERED"] != undefined && flags["COC.SHARK_GIRLS_MET"] > 0) || flags["COC.TIMES_MET_OOZE"] > 0)) {
		output("You could take her to the lake to find someone to play with...\n\n");
		addButton(1, "Lake", nowOnVickiLake);
	}
}

//Lake Victory Scenes
private function nowOnVickiLake():void {
	shouldraSprite(true)
	clearOutput();
	//(go to lake), (penis), (vagina), (herm)
	//(go to lake)
	//Lake Introduction
	output("On sudden impulse, you spin around and begin marching determinedly toward the nearest landmark: the lake! It takes you a little bit, but you eventually locate the correct trail and begin your trek. The ghost girl begins stirring inside you, and you feel her spirit concentrating toward your bicep. A face resembling her human-esque form pushes out of the skin, and she waits patiently for you to get over your initial shock of her freckled face appearing on your arm. \"<i>Where are you going?</i>\" she eventually queries worriedly. \"<i>I thought we were gonna get off!</i>\" You implore her to wait and watch, and with a huff, she falls back into you in anxious anticipation.\n\n");
	
	//SHARK-GIRL - REQUIRES BOAT AND MET SHARKGIRL
	//SLIME - REQUIRES MET SLIME
	processTime(3);
	clearMenu();
	addDisabledButton(0, "???");
	addDisabledButton(1, "???");
	
	if (flags["COC.BOAT_DISCOVERED"] != undefined && flags["COC.SHARK_GIRLS_MET"] > 0)
		addButton(0, "Shark", sharkbustersVictory);
	if (flags["COC.TIMES_MET_OOZE"] > 0)
		addButton(1, "Ooze", ghostGooGurlzDuckfaces);
}
		
//Shark Girl x Ghost Girl - Introduction
private function sharkbustersVictory():void {
	shouldraSprite(true)
	clearOutput();
	processTime(10 + rand(10));
	output("You reach the lake without incident, and quickly hop into the waiting boat. As you cast off the dock, you keep an eye out for any signs of your intended prey; luckily, you did not have to wait long. A telltale fin breaks the surface of the water, heading unerringly towards you. You turn about and row back to shore, hopping out and waiting anxiously (the ghost girl screaming warnings in your ear about sharks in the lake not helping anything). The \"<i>shark</i>\" reaches the shore and breaches beautifully. You narrowly avoid getting splashed, and she lands solidly, spinning to face you. The shark girl gives you one of her vicious, tooth-filled smiles. \"<i>Wanna play? Heads up th-...grfgh!</i>\"\n\n");
	
	output("You don't even give her time to finish, rushing up to her and slamming your lips against hers in a passionate kiss");
	//[if breasts larger than flat]
	if (pc.biggestTitSize() >= 1) output(", " + pc.allBreastsDescript() + " squishing and squashing against her own barely-clad bosom");
	output(".  Confused, the shark girl stands stiffly, arms flailing about. The corrupted creature's confusion only heightens when, on telepathic command, the ghost-girl's form suddenly substantiates... in your mouth. Taking the form of a serpent, the ghost lances across the bridge of lips, zipping down the shark girl's throat before she can even draw a surprised breath. You gently break the embrace and back off while the two girls begin their internal battle. After long moments of gasping, head-grasping, and teeth-gnashing, the shark girl quiets and looks up into your face. The formerly red eyes now shine with a pale yellow light, the same glow you previously housed. She smiles and nods, signifying the ghost-girl's successful dominance of the body. You stand patiently while she gets used to her new host, gray hands roaming over the alien dermal denticles that make up her skin. You notice she lingers for a long while at the groin. The ghost girl veritably purrs when she inserts a probing finger into the shark girl's snatch to find cilia-like structures wriggling inside it. With her analysis complete, the ghost girl returns the shark's gaze to you. \"<i>Well, we COULD just fuck,</i>\" she begins, \"<i>but let me make this a bit more interesting...</i>\"\n\n");
	
	output("She muses over her choices for several moments, snapping her fingers when she appears to find a good one. \"<i>Oh, this will be fun,</i>\" she purrs, then begins casting the archaic spell. A short way into the chant, however, the ghost-girl's voice wavers, and she falls to a kneel. You figure the shark girl decided her mind was not completely taken yet, but that never stops the ghost, whose voice hardens as she forces the rest of the words out of her mouth, ending the last word with an uncomfortable groan. As soon as her concentration returns to her, she mentally cows the shark girl back into submission, then stands, brushes herself off, and shrugs at you. You return the gesture, then move forward to check the results of the spell.");
	
	clearMenu();
	if (pc.hasCock()) addButton(0, "Male", ghostIzmaPenis);
	else addDisabledButton(0, "Male", "Male", "This option requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "Female", sharkyEctoginas);
	else addDisabledButton(1, "Female", "Female", "This option requires you to have vagina.");
}

//Shark Girl x Ghost Girl - Vagina Scene (Giantess)
private function sharkyEctoginas():void {
	shouldraSprite(true)
	clearOutput();
	output("On her beckoning, you approach the ghost-turned-shark with an eyebrow raised. In lieu of words, the ghost gestures towards her undercarriage, still (hardly) enclosed in her black bikini. To her bemusement, the gray arm spasms as its host fights against this third-party rape. It seems as if the shark girl nearly succeeds, the yellow eyes even changing shade slightly, before the ghost girl thrusts herself back into the driver's seat. Despite signs of continued struggle, she winks an again-amber orb at you, and runs a hand along her rough thigh in anticipation. You push her backwards until she is forced to use her shark tail as a tripod, then drop level to her nautical nethers, the cloth dripping with a mixture of water, sweat, and an occasional small droplet of femspunk. You give it a little lick, not surprised with the salty taste in your tongue, then go at it with steadily increasing vigor. Her legs quiver with the power of her budding arousal, and her breathing quickens, short moans and sultry sighs escaping her throat. You hook your fingers around her bikini bottom and prepare to expose her naughty bits, but are stopped when her hips suddenly puff up to pull the fabric tight against her flesh once again. You slip your digits away and lean back, realizing you're about to be treated to the effects of her spell. The ghost girl gives an especially passionate groan, but interrupts it with a concerned gasp. The shark girl's visage momentarily restructures while she's distracted, showing hints of her possessor's features. After noticing and correcting the slight, she turns to you. \"<i>...I think... I cast... the wrong spell...");
	//[if repeat]
	if (flags["COC.TIMED_SHARKGINAS"] > 0) output(" again...");
	output("</i>\" she pants, brow suddenly furrowed with worry.  ");
	if (flags["COC.TIMED_SHARKGINAS"] == undefined) output("You begin to ask what she's talking about, but the words die in your mouth when");
	else output("You can only shake your head resignedly as");
	output(" the muscles of her right arm wriggle wildly before surging against the skin, stretching and swelling. Her hand swiftly grows as large as her head; her upper arm similarly enlarges until her elbow nearly touches her waist. The weight becomes too much of a strain on her still-regularly proportioned body, and the appendage flops onto the ground. Undaunted, the limb continues its growth.\n\n");
	
	output("Now as alarmed as she is, you start to pull back and get up, but are stopped dead in your tracks by a surprised 'oooh' coming from the now very-flushed girl before you.  Your hesitation costs you your chance of escape as she brings her newly enlarged arm to bear, grabbing you roughly by the back of the head and shoving you back between her legs.  As if in concert, the shark-girl's labia surge forward, engulfing the strained garment attempting to restrain it, then slapping against your face with a juicy smack.  Her clit follows soon after, growing to its full size before the rest of her body can catch up.  If she felt like it, she could most likely pull the engorged prick right into her cleavage.  Knowing that appeasing the spectral shark girl will be your only means of escape, you feverishly assault her love canal with your tongue, slipping across and smooshing against the feelers lining it. Meanwhile, you manage to tilt your head enough to see her left arm swelling up to match the right, and judging from the increasingly urgent rumblings of her abdominal muscles, you can tell her torso won't be far behind.  Unexpectedly, your head is forced up a couple inches, and you reach across to confirm your suspicion; her tail, and the toned ass surrounding it, is going along for the ride.  On impulse, you roughly massage the muscular cheek, eliciting a throaty groan from your lover and a quickening of the growth.  Her hips, butt, and tail continue to swell up until her overburdened, incredibly tight thong's straps burst under the pressure and fall free, eliciting a relieved gasp from the girl.  You pause only enough to slowly draw out the remnants of the swimwear from her lubricated fuck-tunnel, causing the ghost-girl's steady stream of erotic sounds to climb slightly higher in pitch from the additional stimulation. You're heaved up from your spot betwixt her loins suddenly, picked up around the waist as she finally collapses under the pleasure, forced slightly to one side by the fin as she falls to the soft grass. You need no explanation as you glance back and watch her now-squirming legs swell with the power of the spell, thickening thighs closing in on each other with enough force to crush any poor soul foolish enough to stay between them. \"<i>What are you...stupid!?</i>\" the possessed shark girl pants. By the way her voice shifts from melodious to coarse, you can guess who it was who saved you from your fate. \"<i>Don't just stand there when...a girl's legs are grow-...o-oh...oooooh...</i>\"\n\n");
	
	output("You redirect your attentions to her breasts, glancing back around just in time to see one heaving orb burgeon with new mass, quickly followed by the other, the motion seeming like some ridiculous dance. While you could sever the straps beginning to sink into the swelling mammaries, you hold back, nearly drooling with arousal as the breasts bulge around the restrictive fabric. Her boobs climb the alphabet in a breakneck pace, reaching I-cups before the bikini top finally gives in to the pressure, causing a ripple to run from her nipples all the way to her feet as the surging breasts break free of their prison. Your eyes widen as you bask in the glory of the unveiled and still-swelling tits. They give one last surge, then stop, and you glance around to see the changes mostly complete. With one last shuddering sigh, the ghost girl raises her head to consider your suddenly insignificant frame. Where once stood (or, you suppose, laid) a short, rowdy shark girl now lays a moaning, sweating, and incredibly horny shark giantess! You make a swift mental note to forgive all of the faeries you had ever thought to take advantage of as the shark-ghost scoops you up once more, drunk with the arousal of the unexpected results of her wayward spell. You manage to take one desperate breath before she quite literally plunges you back between her love-lips, buried up to your waist in wiggly, jiggly chaos.\n\n");
	
	output("You set your jaw and go at your work with fervor, caressing, groping, and licking every inch of her that you can reach, taking note of the increased frequency of her gasps and groans. As if to reward your efforts, the girl reaches down and lines up her pinky with your own neglected snatch, and before you know it, you're suddenly being stretched");
	//[if dildo in possession]
	if (pc.hasKeyItem("Deluxe Dildo")) output(" by the biggest object you've experienced since Tamani's deluxe dildo");
	output(", and your eyes almost cross by the sheer scale of the insertion. Within a minute an orgasm rocks your body, the ensuing spasm pushing the ghost girl over the edge with a final, urgent scream resounding with equal parts ghost and shark girl. With as much concentration as you can muster while your stomach is stretched as large as it is, you desperately wriggle out of the gigantic shark-pussy a moment before her climax. Not able to completely escape, you receive a face-full of female lovejuice for your trouble, bowling you over ");
	//[if breasts present]
	if (pc.biggestTitSize() >= 1) output("and caking your cleavage with the excess lubrication");
	output(". After the cloud of arousal disperses from the ghost-girl's normally intelligent mind, she can't help but notice how uncomfortable you must be, squirming about with her gigantic pinky shoved up your " + pc.vaginaDescript(0) + ".\n\n");
	
	output("As gentle as she can possibly be, given her current stature, she extricates the finger from your vagina with a 'pop' and nestles you against her breasts, letting you rest against the soft, human-like nipple until the enchantment wears off. Sure enough, within minutes, you feel her frame shiver and begin to scale down, and you cling to her tits all the way back until the shark girl is back to her normal athletic proportions.\n\n");
	
	output("Some time later, with another, much softer kiss, you draw the spirit back into yourself, leaving a very tired and surprisingly content shark girl in her wake. She reveals her consciousness throughout the experience, going so far as to apologize ");
	//(if repeated: again) 
	if (flags["COC.TIMED_SHARKGINAS"] > 0) output("again ");
	
	output("to the ghost girl for disrupting the spell—though the spirit would have nothing of that, claiming that though the spell was not what she had meant—or even readily knew how—to cast, she enjoyed the experience as well.  With a friendly wave, the now-naked shark girl dives back into her habitual home.\n\n");
	
	output("With that settled, you and your temporary ghostly companion decide to part ways here. Pushing out of your stomach, the ghost girl flows out of you and reforms, giving you a quick hug and a reassurance of the good time she had. As she begins her trek back to the ruined city, she warns that if you expect her to follow along with your wishes, you'd best be ready to put up a fight.");
	IncrementFlag("COC.TIMED_SHARKGINAS");
	output("\n\n");
	processTime(25 + rand(5));
	pc.orgasm();
	if (!inCombat()) {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
	else if (enemy.alreadyDefeated) CombatManager.genericVictory();
	else CombatManager.genericLoss();
}

//Shark Girl x Ghost Girl - Penis Scene (Saliva Growth)
private function ghostIzmaPenis():void {
	shouldraSprite(true)
	clearOutput();
	output("You swiftly disrobe and lay your [pc.gear] to the side, revealing your stiffening [pc.cocks] in all of its glory. The ghost-girl's eyes brighten at the sight, and she even allows herself a little swoon (which looks absolutely silly, given her current tough shark-like vessel) as she regards your manhood.  ");
	output("She staggers forward, dropping to her knees in front of you");
	//[if testicles present] 
	if (pc.balls > 0) output(" and cradling your [pc.balls] with almost reverent gentleness, running her coarse shark-skinned fingers across your sack as gently as she can manage");
	output(".\n\n");
	
	output("She lifts her chin and slides her tongue across the bottom of your cockhead, stimulating it wonderfully and making you involuntarily tense in anticipation. With a wide-eyed grin promising nothing but pleasure, she steers you softly towards the boat, and you comply, stepping aboard the beached vessel and stretching yourself across its deck, the shark-ghost in close pursuit. She leans down, thin lips forming an 'O' as she closes in on your cock. Her plans change, however, when she gets poked on the cheek with your head... a tip that's suddenly at least six inches farther away from your hips than it should be. You fix a concerned gaze upon the ghost-girl, ");
	//[if first time]
	if (flags["COC.TIMES_SHARKPENISED"] == undefined) output("whose expression reveals she's as clueless as you are.");
	else output("who only smiles as she realizes her 'mistake' in her spellcasting once again.");
	output("  \"<i>That wasn't nearly what the spell should have been,</i>\" the girl muses, licking her lips ");
	if (flags["COC.TIMES_SHARKPENISED"] == undefined) output("absently as she contemplates what could have caused the lengthening of your loins");
	else output("in anticipation for the experience you both are about to undergo, yet again");
	output(". Your jaw drops as her lips puff out, suddenly looking much more sultry and far fuller than before. Your spiritual seductress swiftly takes note, as well, and her lips curl up into a mischievous smile ");
	if (flags["COC.TIMES_SHARKPENISED"] == undefined) output("as she deduces the nature of the spell. \"<i>I think... oh my... my host's saliva may have expansive qualities on... sexual aspects of the body,</i>\" she explains. \"<i>So, if I were to do this...</i>\"");
	else output("\"<i>Would you look at that, my magic spittle still works! How about I just...</i>\"");
	output("\n\n");
	
	output("Before you can stop her, she positions her head over your twitching shaft and opens her mouth wide. Out pours a torrent of drool amassed from a mixture of her arousal and undoubtedly magical influence to splatter against your maleness");
	if (pc.balls > 0) output(" and softly churning sack");
	output(". You cringe, then thrash as the enchanted spittle begins to take effect. \"<i>What an intriguing mistake,</i>\" she muses, and you sense she's talking to the dormant shark girl as much as she is to you. She sits up and redirects her stream of saliva straight down, washing over her breasts as she massages the spit into the small—but not for long—bosom, not even bothering to remove the bikini. Hands still dripping with moisture, she shrugs and reaches back to give her taut ass a double-handed slap, spreading the rest of the fluid evenly across her buttflesh and down her tail, finishing by running a hand down the front of her thong and exchanging spit for femspunk. She glances up to regard your throbbing, reddened member, and stands on her tiptoes to reach it, seizing your glans with both hands and squishing her lips against your opening. She allows her saliva to flow around and down your shaft, and you nearly scream as your dick burgeons forth, even faster than before. Several disturbingly arousing moments pass as your unit widens and sprouts forward, reminiscent of a sapling aging rapidly. As the proverbial dust settles, your penis resembles a fleshy mast for the stationary lake-boat. As if only then realizing the changes going on with her shark girl's body, the ghost cries out ecstatically as her measurements bulge against her garments. Her breasts swell up and contort weirdly against her top, and she gives her shoulders a little shake, marveling in the amount of jiggle her new breasts have. Meanwhile, her new bubble-butt practically swallows her straining thong, and she shimmies her hips furiously, causing a veritable earthquake of assflesh.\n\n");
	
	output("The ghost girl promptly slips out of the poor garment, redirecting her attention to her engorged vagina. With surprising flexibility, the girl plops her big butt against the deck and grabs her ankles, hoisting them up to position her cock-sucking lips even with her labia. Predictably, her mouth opens, and the largest volume of drool yet pours out into her waiting canal, the sensation quickly reducing the ghost girl to a writhing, moaning pile of jiggly flesh. Finally, she musters herself and stands. \"<i>Mmmmf...</i>\" she groans, \"<i>S-sit up... I wanna be your... 'flag'...</i>\" Glancing at her now-cavernous cunt, lady-fluids gushing in waves to splash against the deck-boards, your concern for her well-being is tempered, and you figure this is the only way to please her, at this point. You rise, your enchanted dick flopping out of the boat and onto the grass beyond it.\n\n");
	
	output("With not even a hint of hesitation, the shark-bodied ghost bolts out in pursuit. She falls to her back and wriggles forward, grabbing a hold of your glans with both hands (eliciting a sharp inhale from you) and impaling herself on your pole with only the slightest hint of discomfort. \"<i>Lay back down!</i>\" she begs, and though you think this whole thing completely insane, you comply. Bunching her well-defined legs under her, she hops off the ground as you lean back. She swings up with an excited 'whee!' until she comes to a stop, hovering above you. Panting, groaning, and crying out in elation, the ghost girl begins wriggling around on your gigantic cock, trying her hardest to lower herself onto you. She suddenly stops, her whole body stiffening. Though you can't see her face, you can tell something's happened inside her head as she growls, \"<i>God DAMN it, you useless... thing, you're doing it all wrong,</i>\" in a frustrated voice laced with hints of pleasure. \"<i>Let me do it!</i>\" Before you can consider the personality shift, the shark girl's strong, elastic tail wraps around your shaft and heaves. Inch by inch, she drops further, stretching her quickly-bulging vagina further than what should be physically possible. Her screams rise in pitch and flit between the graceful tone of the ghost and the rough cadence of the shark with each slide, the motion drawing a long moan from you. This feels way too good. Your eyes widen so far they almost roll out of the sockets as you feel a familiar tingling in your mast, and you look up to find the impaled girl shaking her head furiously, babbling something indecipherable; you catch the words 'grow' and 'fuck' over and over again. You must have reacted with the traces of saliva left in her pussy, you realize, and eager to get this whole thing over with, you reach up and grab her ankles, dragging her down several inches over your still-swelling maleness and eliciting a half-pained, half-orgiastic scream. The tightness is too much, and you are pushed to the very brink of your endurance. Your halted gasps are enough of a clue to the similarly peaking shark-ghost-girl, and she increases her efforts to push both of you over the edge. \"<i>MORE!</i>\" she cries, and you oblige her by putting all of your strength into one last tremendous yank. She bottoms out as your engorged glans strikes the top of her magically-enhanced womb, the motion giving both of you the little shove you needed.");
	if (pc.balls > 0) output("  Your enchanted testes give an audible groan as you reach climax.");
	else output("  You feel something stirring in your groin, and you squirm as the tingling intensifies.");
	output("  Your urethra bulges as thick, very thick seed surges through it, and the little bit of extra girth is all the ghost girl needs to reach her own orgasm, hands passionately roaming her inflated body and voice climbing to a shriek as the sensation rocks her. Your first and second spurt of semen rounds her distended belly out, and by the third blast, the shark girl's midsection looks like the aftermath of a week-long demonic orgy. Finally, with your fourth and last explosive gout, her lips relinquish their vice-like grip on your shaft, and the massive wave of semen and spunk rains down upon you, nearly filling the boat and leaving you floating in a bath of sex.\n\n");
	
	output("The ghost girl doesn't even bother to extricate herself from your towering cock, dangling happily until the magic begins to wear off. She whimsically rides your cock down to the boat, and plants her feet on either side, balancing over you as her own measurements regulate. You rise, dive into the lake to wash the smelly fluids off you, then wander back onto shore where the possessed shark-girl is waiting. You walk into her outstretched arms, lips locking into a soft kiss as the girl leaps back into your waiting throat. You are a bit relieved when the shark girl doesn't even question the events that just took place, just turning and wading back into her watery home, leaving you alone with your ghost.\n\n");
	
	output("With that settled, you and your temporary ghostly companion decide to part ways here. Pushing out of your stomach, the ghost girl flows out of you and reforms, giving you a quick hug and a reassurance of the good time she had. As she begins her trek back to the ruined city, she warns that if you expect her to follow along with your wishes, you'd best be ready to put up a fight.");
	IncrementFlag("COC.TIMES_SHARKPENISED");
	output("\n\n");
	processTime(25 + rand(5));
	pc.orgasm();
	if (!inCombat()) {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
	else if (enemy.alreadyDefeated) CombatManager.genericVictory();
	else CombatManager.genericLoss();
}

//Slime x Ghost Girl - Introduction
private function ghostGooGurlzDuckfaces():void {
	shouldraSprite(true)
	clearOutput();
	//[if boat not unlocked, and if it is, 50/50 chance of either encounter; preliminary stuff: breasts smaller than Z's, met Markus; also, choice for herms and all that]  
	output("You hike easily along a path leading around the lake, keeping a wary eye on any potential playthings. With effort, you ignore the increasingly frustrated telepathic protests from your otherworldly companion. You begin to whistle a jaunty tune, but cut the noise short as you glance over and see a perfect recipient for the ghost girl's lust; an amoeba-like glob of goo. The ghost girl's complaints cease as she notices the squishy thing, and you can imagine her eyes lighting up as she queries, \"<i>Ooh, ooh, can we rape that?</i>\"  With a widening smile, you confirm her excitement. Realizing you can't exactly sneak up on the thing, as you don't know how exactly its perception works, you bid the ghost to act as vanguard. \"<i>...Exactly what does that involve?</i>\" she responds hesitantly, and you sigh, bluntly telling her to go and possess the thing. \"<i>Ah,</i>\" she says softly. \"<i>That makes sense.</i>\"\n\n");
	
	output("The ghost girl wriggles her way out of your torso, hovers hesitantly for a moment as she sizes up her intended prey, then floats towards it. You stifle a giggle as she 'crawls' slowly through the air, a near-intangible, vaguely human-shaped wisp. She reaches the slime, steels herself, and dives in. The slime jiggles like... well, gelatin, as the spirit pushes herself into the green mass. You wait several moments, confusedly observing the gyrations of the agitated stuff.  Then, the motion just... ceases. Curious as to if the attempt worked or not, you approach hesitantly. The green slime shuffles in place as it turns itself to regard you. Looking carefully into the stuff, you make out glimpses of the ghost girl's face, and you catch a wink. Knowing what that signifies, you throw off your [pc.gear] as you stride towards her, ");
	//([if penis present] 
	if (pc.hasCock() && !pc.hasVagina()) output(" presenting your [pc.cocks] to the spectral slime.");
	else if (pc.hasVagina()) output(" slipping a hand down to your " + pc.clitDescript() + " eagerly.");
	//[if herm] 
	else output(" both of your sexes throbbing in excitement.");
	output(" The gelatinous mass shudders as the girl giggles, the sound strangely distorted. \"<i>This thing is so... empty,</i>\" she says in a curiously watery and gurgly voice. \"<i>It's like taking over a sponge!</i>\"  You raise an eye at the curious simile, but don't think much of it. You have work to do.\n\n");
	
	//SELECT VARIANT?
	if (pc.isHerm()) {
		if (flags["COC.SLIMEGINAED"] > 0 && flags["COC.SHOULDRA_SLIME_PENOR_TIMES"] > 0) slimeGhostGalForHerms(false);
		else if (rand(2) == 0) slimeyPenorsAhoy();
		else slimeGinaFlation();
	}
	else if (pc.hasCock()) slimeyPenorsAhoy();
	else slimeGinaFlation();
}

//Slime x Ghost Girl - Vagina Scene (Female Inflation)
private function slimeGinaFlation():void {
	shouldraSprite(true)
	//[if vagina]  
	output("You stand for a moment, chin resting upon your hand as you consider the best way to pleasure both of you. Nodding as a thought comes to you, you kneel down next to the ghost girl turned slime girl and sink your fingers into her pliable form. The mass responds with a shudder of pleasure, and you're a bit surprised at the reaction. You ask her if that actually felt good, and her semi-tangible mouth pulls up into a smirk. \"<i>Very,</i>\" she says in the most alluring voice she can manage given the strange voice she has to work with. Encouraged, you go back to your work with vigor, digging deeply into the squishy ooze. You massage the stuff as it quivers under your capable hands. Aroused groans begin issuing from the sensitive girl. You slowly centralize the stimulation into one grabbable region. Like a ceramic sculptor you begin kneading the green goo, forming the stuff into a rounded-off cone.\n\n");
	
	output("You continue shaping your creation until finally releasing it and rising to scrutinize your creation. You seem to have successfully molded an eight inch long slime protrusion.  Giving it a little flick that sends a shiver through the ghost girl's gooey host, you confirm its solidity with a grin. The ghost girl offers a low moan as you climb up onto the green slime and aim yourself above your phallic creation. Although you think to tease the girl a little bit by hovering over her makeshift phallus, she's clearly not in the mood for foreplay. The quivering mass thrusts itself upwards at you, and you're neatly impaled by all eight inches straight off. Her slime, however, will not stop there, and the goo returns to its semi-solid state... in your " + pc.vaginaDescript(0) + ". You bite your lower lip as you feel the ooze pressing tightly against your tunnel. The malleable mush squeezes past your cervix and quickly fills your womb tight. Her redistribution of volume compromises your balance, and you slip. Your " + pc.buttDescript() + " slaps against the slime, right above the ghost girl's face; ");
	if (pc.isNaga()) output("your tail is thrust to one side to make way for the penetration");
	else if (pc.isGoo()) output("your gooey mass smooshes into the green slime, a near-mirror of jiggling substances");
	else output("your [pc.legs] are forced to do the splits as you sink down");
	output(". Although the feeling is wonderful, you ask the ghost girl to slow down a bit. She responds by forcing even more goo into your cunt, your belly bulging slightly to accommodate. Yelping in surprise, you press your hands against the emerald surface in an attempt to calm the wraith. She reacts in the exact opposite way, quickening her rough treatment. A tendril of slime reaches up to teasingly circle your pucker, and ");
	//([if corruption <50]
	if (pc.slut() < 50) output("you beg her to stop before this gets out of hand.");
	else output("you feel the constant stimulation of your carnal canal weakening your resolve until you're almost encouraging her.");
	output("\n\n");
	
	output("The ghost girl gives a concerned groan. \"<i>It's not me... this thing, it's... hungry,</i>\" in an increasingly desperate voice. \"<i>I'm sorry!</i>\"  With that, the protrusion lances up your " + pc.assholeDescript() + ", wriggling its way through your colon eagerly. Although not as painful as you'd imagine, the insertion still inspires a sharp breath hissed through clenched teeth. Before you can stop it, the green slime shoots another prehensile appendage straight towards your " + pc.face() + ". The thing floods your mouth and bulges your cheeks as it demands entry. You keep your jaw firmly shut, knowing you must keep the situation from getting out of hand, but tiny tentacles simply break off the main one and begin to seek other means of access. Two of the things slide through your nose, and your eyes widen as they wriggle through and down into the back of your mouth. The monstrous ooze jiggles in victory, though the ghostly visage within winces worriedly. Once inside, the goo surges against your jaw, forcing it open just far enough to open the floodgates. Like a jade river, the stuff flows down your throat. You snap your head back to attempt to extricate the stuff, but it simply follows you, pushing you even farther backwards as it goes. A muffled cry is the only protest you are allowed at the grotesque triple penetration. Your only consolation is you can still somehow breathe, and you figure your spiritual friend has something to do with that.\n\n");
	
	output("You hear, as if from a great distance, the hasty chant of the ghost girl as she casts another spell. Not even allowing you a thought as to what in the world she might to do you in this state, the goo surges deeper into you in all three holes. Your stomach bloats obscenely as the slime slips down your throat, through your intestines, and against your womb. \"<i>This might help,</i>\" the ghost girl breathes, finishing her spell. \"<i>Please, hurry up... the thing won't stop until it's had its way with you, and I... oh... I feel myself... losing...</i>\"  Though wishing to heed the girl's warning, you're unable to do much against the onslaught of the gelatinous thing. You feel a lancing pain in your belly as it's stretched to its breaking point, and you wonder if this will be the end of you. Suddenly, the pain is lifted, and you glance down to witness the power of the spell. You reach down and pinch the flesh, and you gasp as it easily squishes...despite how tight it was a moment before. The ghost girl heaves a distorted, relieved sigh at the success of her magic. Of course, the only thought the green slime registers is the amount of goo it can stuff into you, now. The assault doubles, then triples in intensity, slime pulsing into your body recklessly.  ");
	if (pc.biggestTitSize() < 1) output("Your frame is jostled about as the slime under you shrinks.");
	else output("Your frame is jostled about as the slime under you shrinks, your goo-filled gut pushing your " + pc.allBreastsDescript() + " up into your overburdened jaw.");
	output("\n\n");
	
	output("Your distended belly shivers as the goo jostles around, puffing up like a goblin after a minotaur bukakke. Some small thought, buried under layers of agonizing pleasure, calls to you repeatedly. The green slime likes it when you massage it; massage it, and you'll get out of here. As solid of reasoning as you'll get in a situation like this, you reach up and wrap your fingers around the thick oral tentacle. Treating it as you would a huge phallus, you caress, squeeze and stroke as much of the mostly solid ooze as you can reach. The stimulated green slime rewards you with a huge bulge of itself, beginning at the base and working its way toward you. The nearly-overwhelmed ghost girl screams out a warning, and you almost panic as you consider the thing. You can't see them, of course, but the appendages filling your lower crevices begin forming similar bulges, and they begin their way towards you as well. You can only wait in horror as the mouth-tentacle's lump squeezes under your now-still fingers, forcing them apart with its thickness. It's a macabre race to see what can stretch you first, and no matter the outcome, you have a feeling you won't enjoy the prize. Your cunt-tendril wins out, and your wail falls on deaf ears as your vagina dilates to compensate.\n\n");
	
	output("Content in taking second place, your anus also stretches as the bulb flows into it. Moments later, before you are even allowed to recover from the first two, your jaw is forced farther open to make room for the bulbous deposit. You hum unhappily as your throat widens, not unlike a croaking frog. Your already-huge belly burgeons with the new additions until it's at least twice as large as ");
	if (flags["COC.MARCUS_MET"] != undefined) output("both of Markus's testicles, combined!");
	else output("a wheelbarrow!");
	output("\n\n");
	
	output("The slime is too small to keep you up at this point, and your " + pc.buttDescript() + " touches the soft grass. Finally, the green slime breaks apart into three separate pieces. The bottom two slide into your orifices, making you sigh in relief as they settle in and leave your poor stretched holes alone, but the one connecting your mouth has one last surprise in store. The ghost girl, struggling frantically to hold onto herself in the midst of the mindless shell she's in, wriggles towards you. Her barely-visible face is locked in a determined, yet lust-filled grimace. \"<i>Do something!</i>\" she implores, seconds before the last of the goo disappears into your maw.\n\n");
	
	output("You're stuck on your back like an unlucky turtle, the weight of your still-ballooning belly pressing down on you. The goo in your gut sloshes impatiently, roiling under the skin like a quintuplet of angry minotaurs. A thought strikes you, and though it's a bit insane, you figure you might as well work with what you're given. You lean as far as your belly allows you to one side, then with an almighty heave, throw yourself the other way. The momentum carries you up and over until you're resting on your own squishy stomach. Your weight squishes your swollen body, and you can feel goo threatening to spurt back out of the gaping orifices that the stuff entered through. The substance inside you quakes happily from the pressure, and you're relieved to finally be making progress. You knead and press your tight-stretched skin furiously with your ");
	if (pc.isNaga()) output("snake-like lower body");
	else if (pc.isGoo()) output("undulating, gooey mass");
	else if (!(pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_PREHENSILE))) output("arms and [pc.legs]");
	else output("arms, [pc.legs], and [pc.tails]");
	output(", taking pleasure in the distant cries and moans from the ghost girl inside. The ingested green slime begins rumbling, softly at first, but with increasing intensity. You're actually knocked from your tentative perch as the quake of flesh continues growing, landing heavily on your side. As abruptly as it began, the vibrations cease, but you continue to rub, feeling the worst is not yet over.\n\n");
	
	output("Indeed, your ministrations proved just what the green slime (with the increasingly overwhelmed ghost girl in tow) needed to reach its 'orgasm'. A strangled cry is the only reaction you can give as your poor belly bloats even further. This new filling feels...different, however. Squishier. You poke your middle—it isn't difficult, as the flesh is nearly surging over your arms at this point—and ascertain the fairly obvious; the slime just came. You lie there for several more moments before you have to wonder how exactly you're going to get the goo out of you. As if reading your mind, the mass of gel pulses once, then begins receding. Your belly finally knows comfort as the stuff shrinks into you, and you're left to guess which hole the stuff will come out of. A sudden twinge of discomfort from your chest gives you a fairly good idea, and you glance down to ");
	if (pc.biggestTitSize() < 1) output("see your " + pc.nippleDescript(0) + " wiggling sporadically.");
	else output("see your " + pc.allBreastsDescript() + " trembling, " + pc.nippleDescript(0) + " twitching eagerly.");
	output("  Your jaw drops as your chest heaves forward, filled with the same slime that was just stuffing your stomach.\n\n");
	
	output("You hardly notice you're on your back again; the feeling of the ooze somehow pumping into your tits threatens to overwhelm you. The growth of your boobs is directly proportional to the shrinking of your gut; it's as if the slime is actually just trading places. You can't resist the urge to squeeze one of the burgeoning boobs, and the compression does nothing but excite the slime and cause it to move faster. Resolving to get the goo out of you in the most efficient way you can, you go to town on the billowing breasts. You smash them together, rub them down, run a thumb across your lengthening nubs... anything to further the process along. Before long, enough slime has flowed into your breasts to make them at least three cup sizes larger than original, and ");
	if (!pc.hasFuckableNipples()) output("your nipples grow until you can wrap your hand around them... which you promptly do. Stroking the teats as you would a pair of veiny cocks, your arms are forced to bend to accommodate for the increasing amounts of squishy boobflesh. You feel a warm tingling beginning at your sternum and working its way up your engorged tits, and you speed up your self-stimulation.");
	else output("your throbbing nipplecunts gape further. The things almost beg for loving, so you oblige; you slip a finger into the nubs, then two, then four, then your thumb. You easily slide your hands through the openings, and you waste no time in fisting the soaking tittytwats. The lubricated canals close around you as your titflesh continues to grow. Nonetheless, you don't dare slow the stimulation, knowing that the sooner the creature is out of you, the easier it will be to extricate the ghost girl from it. Finally, after around a minute of twisting, pushing, and tugging, you feel a tingling sensation begin at your sternum. The warm tingle works its way up through your mammaries until reaching your teats. You extract your arms from the hungry tittietwats with a loud slurping sound, settling with teasing the areola.");
	output("  A pale emerald moisture starts to work its way through the pores of your nipples, and a few strokes later, you reach your boob-crescendo. You throw your head back, mouth open in a wordless moan of orgasmic pleasure as the slime, mixed with your boobmilk, explodes out of your body in a heady spray.\n\n");
	
	output("The oozy evacuation keeps up for many long, pleasure-filled heartbeats, your breasts deflating as the slime spurts out of your body. Eventually, the spurts turn to a drizzle, and you push out the remainder of the goo with a compression of your back-to-normal boobs. Reaching into the diluted sage substance, you feel around for any signs of life for the poor ghost girl. You feel a slender hand wrap around your wrist, and you easily heave the spirit free of the twitching mess. Free of the mostly-empty influence of the green slime, she whimsically floats about you. \"<i>It took you long enough!</i>\" she berates you angrily. \"<i>...But, you managed to get me out of there with my sanity intact... and I DID have a good time, so...</i>\"  She substantiates in front of you, smiling radiantly. \"<i>Thanks,</i>\" she says amiably. \"<i>I'm gonna go home. Oh, before I go...</i>\"  She brazenly undoes her leggings, pulling them away from her crotch and reaching into her box. She extricates a good amount of ectoplasm, then pulls a small bottle from a pocket inside her tunic and squeezes the goop inside. With an amiable grin, she hands the bottle to you, and you nod your appreciation. You part ways there, with you redressing and heading back to your campsite, and the ghost girl beginning her trek back to the town ruins.");
	output("\n\n");
	pc.orgasm();
	IncrementFlag("COC.SLIMEGINAED");
	processTime(25 + rand(5));
	
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Slime x Ghost Girl - Penis Scene (Slime Cum Inflation)
private function slimeyPenorsAhoy():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	output("\"<i>Wait a sec,</i>\" she bids, and you watch curiously as the slime begins to roil angrily. Before your eyes, the unremarkable mass shoots upwards and reforms into a jiggling recreation of the spirit you've come to know. The two large circles that stood in for eyes even glow with the same amber fire. \"<i>Ever get taken for a ride by a goo-ghost?</i>\" she asks coyly, sliding towards you with arms outstretched. With a grin and a head shake, you move to meet her.  To your surprise - and hers as well, judging from her reaction - her skin seems incredibly sensitive to your touch. The goo nearly flinches away from your questing fingers as you caress every part of her \"<i>body</i>\" that you can reach. You're rewarded by a satisfied grunt, and suddenly, she hooks her hands around your head and pulls you into her slime-filled bosom. The enamoured ghost girl ignores your struggles for several moments before she apparently comes to her senses and releases you from your suffocating predicament. \"<i>Sorry!  This slime is a bit more insidious than I thought...</i>\" she explains, a blush inexplicably finding its way to her emerald face. No harm, no foul, you insist, and she nods in appreciation. \"<i>Oh!</i>\" she exclaims, struck with inspiration, \"<i>I've got a good idea!</i>\"\n\n");
	
	output("She falls into spell-chanting- a strange-sounding thing, considering her current body- and you're forced to wait impatiently until her incantation is complete. She ends the chant with a gesture towards you, cluing you in on the recipient of the spell. With a wry smile, you spread your arms, and she happily accepts the offer. Neither of you waste time with foreplay, both of you too aroused to care about much at all. The spectral slime girl happily hops up and impales herself upon your " + pc.cockDescript(x) + ". She twitches eagerly as she wraps her legs around your waist, pinning herself to your still-standing frame");
	//([if boobs present] 
	if (pc.biggestTitSize() < 1) output(" while squishing her small boobs into your own " + pc.allBreastsDescript());
	output(". Before you can dwell on her seemingly sexually-hindering actions, however, a sensation in your genitals steals your attention—the spirit screams in ecstasy as your slime-sheathed penis magically broadens substantially.  ");
	if (flags["COC.SHOULDRA_SLIME_PENOR_TIMES"] > 0) output("You can't shake the feeling that she's used this particular spell before. What an unoriginal ghost.  ");
	output("Your growing girth stuffs the goo-ghost more and more, and she enthusiastically squirms against you. \"<i>Nnngghh... touch me, idiot!</i>\" she demands between excited gasps. Happy to comply, you reach up and tickle her jade-colored tits. The stimulation elicits a gurgle from the enamored eldritch woman, and you feel her pulsating mass of slime tighten around your swollen cock. Your efforts redouble, nearly pushing right through her as you work the goo as a chef does stubborn dough. Her legs weaken their grip on your " + pc.hipDescript() + "; capitalizing on the slip-up, your grip instantly drops to her forcibly widened hips.\n\n");
	
	output("Ignoring her hardly-genuine protests, you raise the ghost girl as high as your arms can manage, then simply release your grip. On cue, the goo around the perimeter of your shaft begins to vibrate, drawing her back down onto you. A crazed burst of laughter flies from the wraith as she slides down your still-growing phallus.  You take almost as much pleasure in the activity as she did, and her almost predictable request to \"<i>Do it again!</i>\" is answered swiftly. The goo-ghost whoops and screams like an excited child on an amusement park ride as she ascends your pole, and the whimsical sounds quickly fade to orgasmic utterances as she begins her descent. \"<i>Nnnngh- I'm... aaaaah...</i>\" she gurgles, her slimy insides beginning to roil in anticipation.\n\n");
	
	output("Her gel encircling your unnaturally wide maleness nearly drives you insane, and it's not long until you feel yourself reaching the end of your rope as well. Driving her as far down onto your groin as you can, you tense in climaxial preparation, noting she is doing the same. The ooze begins milking your penis ");
	if (pc.balls > 0) output("and teasing your quaking testes ");
	output("to provoke your orgasm, with impressive results. Soon, copious amounts of baby-batter begin bulging your cum-canal as your grip tightens on her gooey skin, the slime inside still swirling around and teasing you. Somehow, you manage to keep your balance as your first eruption of cum surges into the similarly climaxing ghostly gel. You quickly realize her spell was designed with more than penile widening in mind as your spooge continues to pour into her, not even slowing down in its ejaculatory parade. The gooey ghost's body begins to balloon outward to make room for the flooding fluid... it isn't long until she looks positively rotund. The combined weight of her goo and your semen makes it hard to stay upright, forcing you to your knees.  As gently as you can, you lower the twitching girl to the grass, still pumping semen into her swelling frame. After at least two minutes of ceaseless release, your seed finally slows to a trickle, to your relief. You heave a sigh as you pull out, a light-headedness washing over you. Making a note to admonish the overzealous wraith for her potentially hazardous magic use, you rise to depart.\n\n");
	
	output("\"<i>Hold up there,</i>\" a curiously muffled watery voice demands behind you. \"<i>I'm not... done yet.</i>\"  You turn curiously to regard the slime, breath catching in your throat at the changes you hardly noticed occur. As you watch, your copious amounts of trapped semen swish around the ghost girl's body, slowly being incorporated into the goo. The slime, while before a dark green, lightens considerably with your addition. The swollen ghost girl looks up at you, petting her cum-bloated belly. Strangely, her yellow eyes fade to a more yellow-green coloration as she continues to regard you. \"<i>Get over here... and fuck me,</i>\" she demands, her voice deepening and becoming nearly unintelligible. Perhaps the 'sponge' is stronger than she gave it credit for. Her ballooned belly shudders visibly, and you can't help but lean forward a bit as your seed starts to disperse into the rest of her body. Her C-cup bosom bulges with newfound volume, and her butt quickly follows suit. The ghost-goo's formerly slender waist and thighs bulk up as well; before long, your post-mortem playmate has gone from skinny, unremarkable girl to curvaceous temptress. Your breath catches in your throat, and before it registers in your mind to flee from the cum-crazed slime girl, she tackles you to the ground. Her enhanced weight pins you down, a tendril sprouting from her plump jelly-stomach and teasing your semi-flaccid, still-broadened penis. The prehensile protrusion goads you incessantly; caressing, circling, squeezing, stroking... it's not long until you're once again completely stiff and ready to go. With a delighted cry—and a bit of trepidation in that outburst, you notice—she plunges herself onto you once more.\n\n");
	
	output("Even if you were to attempt to assist her with the lovemaking, at this point, the ghost girl is too out of it to realize. Keeping your arms and legs pinned, she vigorously goes at her work, her extra-large ass ");
	if (pc.isNaga()) output("slapping against your tail");
	else if (pc.isGoo()) output("smooshing against your goo");
	else output("swiftly bruising your thighs");
	output(".  A bestial groan rumbles from the goo-ghost as she continues to ride you, and despite everything, you begin to enjoy the treatment, going so far as to begin bucking your hips in rhythm.");
	if (pc.balls > 0) output("  The near-vacant-minded girl rewards you with two slime-tentacles to fondle your scrotum.  You hiss in a sharp breath at the sudden stimulation, but swiftly come to welcome it.");
	output("  Climax comes soon, and though the spell has started to wear off, a good thirty seconds of ejaculation leaves the ghost-girl-turned-slime even bigger than before; her breasts reaching at least G-cups that dangle just above her bloated belly, her butt jutting obscenely far behind her, and her hips as wide- or wider- than a cow's. Exhausted, you fall back, thinking the worst to be over. The slime, however, has other plans.\n\n");
	
	output("A crazed look comes into her increasingly green eyes as the ghostly goo-girl's gaze shifts to your trapped frame, paying particular attention to your twitching, softening member. Although you wish the ride to be over, her near-hysterical expression assures you it won't end anytime soon. Another spell begins to roll out of her mouth, leaving you to only guess what this one might do. Heat builds in your cock, quickly climbing from 'warm' to 'uncomfortably hot'. Against your will and (most) of your wishes, your penis again stiffens, enchanted by the fluid-crazed ghost-goo already grinding against it. She must be insane; how much can her current body even hold?  Your doubts are doubled when ");
	if (pc.balls > 0) output("the heat spreads to your testicles, promptly puffing them up with arcane virility");
	else output("you feel a discomfort beginning in your prostate, as if the organ is beginning to grow with arcane virility");
	output(". Once more, she hops upon you, beginning a ferocious assault against your genitals. Looking up at her face, however, she does not seem very satisfied with the predicted output. Although not surprised, you're nonetheless horrified when she begins casting the same spell, and then a third time.  ");
	if (pc.balls > 0) output("Your " + pc.legs() + " are forced apart by your burgeoning cum-sack");
	else output("You nearly go insane with the pressure upon your sex");
	output(", but she doesn't even notice, too excited by the notion of being so filled up.\n\n");
	
	output("In your current overfilled state, it takes a mere two minutes of her frenzied ministrations to cause your ");
	if (pc.balls > 0) output("balls to churn");
	else output("body to prepare itself for release");
	output(". The only warning the enamoured ghost girl receives is a small groan before the floodgates quite literally open. The first wave completely distorts her abdomen, the second stretching the gooey skin remarkably thin. With all the pressurization, your third and final explosion lifts the slime-ghost with all of her added mass right off you, landing her heavily nearly ten feet away. You both lie still for minutes, chests heaving and genitalia dripping. Eventually, you force yourself to your feet and ", false);
	if (pc.balls > 0) output("waddle over to where the mewling ghost girl is twitching on the ground; your now-shrinking testicles hindering your gait.");
	else output("limp over to where the mewling ghost girl is twitching on the ground; your now-shrinking prostate hinders your gait.");
	output("  Like pushing through a huge plate of jello, you reach into the distended slime's stomach, fishing around for any signs of... afterlife. A slender hand catches onto yours, and you heave the ghost girl out of her host easily. She floats in circles around you. \"<i>Thank you so much,</i>\" she cries happily. \"<i>I was nearly lost in there!  There was so much... emptiness.</i>\"\n\n");
	
	output("You smile and shake your head. How much of her was left in that slime at the end, you wonder. Enough to recall a spell... oh well, you decide. You all came out unharmed, eventually. As soon as the ghost girl materializes, she rushes you and wraps you in a big hug. \"<i>I should be getting back now,</i>\" she admits. \"<i>Can't stick around here all day. Oh, before I go...</i>\"  She brazenly undoes her leggings, pulling them away from her crotch and reaching into her box. She extricates a good amount of ectoplasm, then pulls a small bottle from a pocket inside her tunic and squeezes the goop inside. With an amiable grin, she hands the bottle to you, and you nod your appreciation. You send her off, then begin back to your own camp. While redressing, you can't help a final cursory glance at the pile of slime, still humanoid in shape and now rubbing its enlarged measurements in mindless bliss. Interesting...\n\n");
	IncrementFlag("COC.SHOULDRA_SLIME_PENOR_TIMES");
	pc.orgasm();
	processTime(25 + rand(5));
	
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Victory Scenes (Repurposed Loss Scenes)
//Genderless Scene
private function genderlessGhostBuster():void {
	shouldraSprite(true)
	clearOutput();
	var dildo:CockClass = new CockClass();
	dildo.cLengthRaw = 13;
	dildo.cType = GLOBAL.TYPE_EQUINE;
	dildo.cockFlags = [GLOBAL.FLAG_BLUNT, GLOBAL.FLAG_FLARED];
	
	output("Excited to help relieve the girl of her accumulating lust, you allow her control of your arms. She eagerly cups a hand against your crotch to feel... nothing. Confused, she quickly wriggles out of your [pc.gear] and goes in for another grope, feeling nothing but skin. \"<i>Son of a...please don't tell me you don't have any sexual bits I can play with!</i>\" she huffs, and you chuckle sheepishly, not knowing what to tell her. She groans and falls back onto your " + pc.buttDescript() + ", muttering a string of curse words under your breath. \"<i>That's it!</i>\" she fumes. \"<i>I'm going to get off, whether you want me to or not!</i>\" She resumes cursing and wiggling your hips for a bit longer, then stops suddenly, a smirk playing across your face. \"<i>Whether you want me to or not...</i>\"\n\n");
	
	output("She hops to your [pc.feet] and makes for the decrepit hut you first saw her in.  ");
	if (flags["COC.SHOULDRA_GENDERLESS_FUCK_COUNT"] == undefined) output("You raise an eyebrow, genuinely curious as to how she'll figure out how to relieve her desire.  ");
	output("Darting inside, the ghost girl heads unerringly towards a warped and half-rotted dresser. After searching several drawers filled with various knickknacks and trinkets, the spirit squeaks in excitement as she produces a seemingly regular egg carton. She moves to the other side of her room and opens a curiously well-made chest, setting the carton on a nightstand as she goes.  ");
	if (flags["COC.SHOULDRA_GENDERLESS_FUCK_COUNT"] == undefined) output("Curious as to its contents, you glance inside—it's a chest of dildos, of every shape and size. Before you can ask why the hell a ghost would carry a CHEST of dildos, ");
	else output("You recall distinctly the contents of that chest, and are not surprised ");
	output("when she reaches in and rummages about, producing two eight-inch vibrators with bumpy demon-shafts. She moves back to the center of the room, launching into a short spell as she goes. She sets the dildos on the same nightstand and opens the carton, pulling out four large white eggs. You marvel at how resourceful the ghost-girl is, then pause and consider the ramifications of the eggs. Your suspicions are confirmed as ");
	if (pc.biggestTitSize() < 1) output("two new additions bud on your chest.");
	else if (pc.biggestTitSize() <= 8) output("your " + pc.allBreastsDescript() + " begin to bounce all around.");
	else output("your " + pc.allBreastsDescript() + " swell slightly to make room for a sudden increase in milk production.");
	output("As the ghost continues darting around the room, ");
	//[if flat to E-cup]
	if (pc.biggestTitSize() <= 8) output("your new EE-cup breasts settle");
	else output("the lactation continues, and the ghost girl moves back to the table and settles down a bit");
	output(".  Satisfied with the changes, she wastes no time on tapping the eggs against the table, cracking them cleanly. Your arm freezes up momentarily as she tips the half-shell towards your similarly conflicted mouth, but she wins out quickly, forces your jaw open, and drops the contents inside. She swallows the contents excitedly, then reaches down and hefts your weighty tits in anticipation. Your nipples swell up and out, lengthening and stiffening as the first three eggs are consumed. The last one, however, produces a completely different reaction on your body; a comfortable warm tingle begins, deep in the center of your oversized breasts, migrating up steadily to your nipples. With a satisfied groan, the ghost-girl circles the tingling teats with a teasing finger as the change continues. Finally, she sinks a finger into each of the suddenly yielding nipples, shivering in pleasure from the penetration. Wasting no more time, she snatches up her two dildos and shoves them into your ");
	if (!pc.hasFuckableNipples()) output("new ");
	else output("even larger ");
	output("nipplecunts, flicking them on as the bumpy demon-dildos penetrate your hungry tits. The ensuing vibration sends little waves up and down your boobs as they jostle about, and the ghost-girl gives a strangled yelp of pleasure. Drunk with the sensation, she staggers about, mewling and gurgling in the pleasure of having your nubs violated. Her foot gets snagged on a bedpost and she flops onto the ground, chest first, the bumpy sextoys pushing slightly further into your tits. She slams your pelvis onto the floor several times in a futile attempt to further her joy, then flops to the side, eyes finally falling upon the still-open chest of dildos. She slowly drags herself to it, mashing your bosom against the ground and inciting a few happy grunts, reaching in and grabbing up a 13-inch floppy horsecock replica.");
	if (pc.analCapacity() < dildo.effectiveVolume()) output(" Your irises shift halfway between the yellow pallor of your possessor and your natural palette as your eyes widen in horror. She couldn't possibly...");
	output("\n\n");
	
	output("She smacks it between your legs, seemingly forgetting about your lack of genitalia, and grudgingly goes for the next penetrable orifice; your " + pc.assholeDescript() + ". With blatant disregard for safety, the vibrators still buzzing happily in your increasingly warm nipples, she slams the horsecock against the ground, waits for the wiggling to somewhat cease, then lines your butt up with the flared tip.");
	if (pc.analCapacity() < dildo.effectiveVolume()) output(" Her crazed laughter mingles with your horrified scream as she sits on it, driving it at least four inches inside in its initial penetration");
	else output(" With crazed laughter she sits on it, driving it at least four inches inside in its initial penetration");
	//[if anus is not gaping]
	if (pc.ass.looseness() <= 4) output(" and stretching your butt obscenely");
	output(".");
	pc.buttChange(dildo.effectiveVolume(), true, true, false);
	output("  Babbling like a crazed addict, her mind clouding increasingly by the triple penetration, she hops up and down, driving the dildo further into your anus with every bounce. Finally, with eight inches of horsey wang shoved into your butt, and vibrating demon-dicks never ceasing their barrage of pleasure on your tits, the ghost-girl climaxes in a big way. She reaches up and roughly pulls the vibrators out of your nipplecunts, stroking them vigorously as they spurt a mixture of transparent spunk and thick white milk, two mini-fountains of orgasmic pleasure. After some time on the ground, taking deep breaths that jostle your boobs against each other, the ghost girl finally reaches down and extricates the equine dong from your pucker, tossing it to the side with a contented sigh. \"<i>What did I tell you?</i>\" she asks softly. \"<i>Any means necessary.</i>\"\n\n");
	
	output("You chuckle to yourself, admittedly impressed by her prowess. A pressure lifts from your chest, and you absently raise a hand to find ");
	if (pc.biggestTitSize() < 1) output("your tits, along with the elongated nipples, receding back into a flat chest.");
	else if (pc.biggestTitSize() <= 8) output("your boobflesh shrinking back down into its normal size, nipples included.");
	else output("the nipples shortening once again, and the lactation finally stabilizing.");
	output("  With a happy sigh, you heave yourself upright, slipping back into your [pc.gear] and moving out into the ruins once more.");
	output("Her pleasure dealt with, the ghost girl appears head-first from your belly, flowing out and reconstituting herself into the normal, brown-eyed girl you first encountered.  Almost as an afterthought, she smiles, moving to her clothing and swiftly dressing, then gives you a little wave before wandering away, rounding a corner and disappearing from sight. You resolve to find her again- her magic was pretty fun!");
	
	IncrementFlag("COC.SHOULDRA_GENDERLESS_FUCK_COUNT");
	processTime(15 + rand(5));
	pc.orgasm();
	
	if (inCombat()) {
		output("\n\n");
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Penis Scene
private function penisLossThatIsntALoss():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	clearOutput();
	if (pc.hasStatusEffect("Infested")) {
		dewormYourGhost();
		return;
	}
	if (pc.statusEffectv1("Exgartuan") == 1) {
		penisGartuanGhostSmexVictory();
		return;
	}
	if (flags["COC.SHOULDRA_PENIS_DEFEAT_TIMES"] == undefined) output("She abruptly gasps in excitement and begins moving your hands towards your groin, though you swiftly reclaim control. \"<i>You have a penis,</i>\" she telepathically pulses to you with an anxious and excited edge to her voice. \"<i>My hosts... they rarely... they...</i>\"");
	else output("She chuckles softly as she recalls the times you've shared, and she hungrily goes for your maleness once more, though you throw her off of it.");
	output("  The communication suddenly breaks as the ghost girl's will surges against yours, all thoughts of submissiveness vanishing from her mind.  ");
	//[if intelligence <50] 
	if (pc.willpower() < 30) output("It's not very hard for her to break down your fortifications, and you soon feel yourself being pushed aside by her vast mental capacity.");
	else if (pc.willpower() < 45 || pc.cockThatFits(200) == -1) output("You begin to gain an edge, but the ghost girl is craftier than you expected. She begins to pulse mental intrusions at you, scrambling your thoughts just long enough for her to overtake you and push you to the side.  \"<i>You are one hundred years too early to challenge me,</i>\" she chides. \"<i>My intellect has long surpassed most any living creature on this plane.</i>\"");
	else {
		x = pc.cockThatFits(200);
		output("The ghost girl puts up a good fight, but you're more than prepared for her mental assault. You feel her panic well as her intrusions are overwhelmed, and though she attempts to disengage the mental link, you easily stop her. She screams mental protests at you, but your ringing ears only strengthen your psychological dominance over the poor spirit. Before long, she's reduced to a whimpering wreck. \"<i>Out,</i>\" you command, tired of the troublesome specter's meddlings. Of course, she won't even try to rebel now, resignedly accumulating her essence and beginning her exit. Within moments the ghost girl flows out of your body and resolidifies before you.\n\n");
	
		output("She moves to leave in a huff, but you stop her with a single telepathic demand. She's yours, you remind her, and since she's gone through the trouble of trying to get you off, she might as well finish the job. Even as her lips purse in a stubborn pout, a dominating wave of influence sweeps over her, and regardless of herself, she begins unsteadily moving towards you. Resolving to meet halfway, you stride over to her and push her to your knees. As she watches, you shed your [pc.gear] and hoist your " + pc.cockDescript(x) + " up to her lips, leaving a fairly clear implication of your expectations. The ghost girl's eyes widen at the sight of your manhood, and she cringes as a new wave of arousal sweeps through her. She gives a little whimper at her inability to quell her overwhelming libido, but you simply laugh mockingly and gesture at your maleness.  \"<i>Ghost blowjob,</i>\" you mutter snidely.\n\n");
		
		output("You don't even give her the chance to act of her own volition, simply reaching out, taking ahold of her head, and slamming her onto your " + pc.cockDescript(x) + ".  She takes it surprisingly well, unsurprisingly easily, taking most of the shaft in the first thrust alone.  With not as much as even a sputter, she impatiently double-handedly grabs your " + pc.buttDescript() + " and thrusts her head forward.  Before you know it, your entire " + pc.cockDescript(x) + " is wrapped in a fleshy tunnel of love.");
		
		if (pc.cockTotal() > 1) {
			output("  Mindful of ");
			if (pc.cockTotal() == 2) output("your other dick");
			else output("the rest of [pc.eachCocks]");
			output(", the mentally dominated girl quickly clutches ");
			if (pc.cockTotal() == 2) output("your other shaft and pumps it vigorously.");
			else if (pc.cockTotal() == 3) output("your other two shafts and pumps them vigorously.");
			else output("two other shafts and pumps them vigorously.");
		}
		output("\n\n");
		
		output("The ghost girl goes to town on your genitals, the combination of your will and her still-rising lust fueling her movements.\n\n");
		
		output("Although her mouth is quite full, her voice rings clearly in your head as she starts casting a spell.  You glance down at her, surmising from her almost serene expression and heavy-rimmed eyes that she's even gotten over her inability to orgasm.  She finishes her spell with the usual flourish before once more focusing her attention to your pleasure.  ");
		if (pc.cockTotal() == 2) output("Taking her hand away from your other dick, the ");
		else if (pc.cockTotal() >= 3) output("Taking her hands away from your other dicks, the ");
		else output("The ");
		output("ghost girl smiles around your phallus, and you can only guess what she has planned.  You don't have long to wait, however; a strange roiling arises ");
		if (pc.balls > 0) output("in your [pc.balls]");
		else output("near the base of your shaft");
		output(".  ");
		if (pc.balls == 0) output("The first effects of the spell make themselves known in a big way when an overladen cumsack forms and drops between your [pc.legs].  ");
		output("The strange feeling focuses on your testes, making it a bit hard to concentrate on keeping the ghost girl subdued.  Your management of willpower does not waver until you feel your legs being pushed farther apart.  A curious glance turns into a horrified stare as you gaze upon your now ");
		if (pc.ballDiameter() >= 9) output("gargantuan");
		else output("basketball");
		output("-sized balls.\n\n"); 
		
		output("Taking advantage of your distraction, your former mind slave pushes you over and jumps on top of you.  Her impotently sopping box leaves streaks of clear fluid across your belly as she continues her work on your cock");
		if (pc.cockTotal() > 1) output("s");
		output(" while swaying her hips to and fro.  Both of her hands get to work on rubbing your ever-growing testicles, but two hands can't cover the growing amount of space necessary for effective stimulation.  She shrugs, content with patting, tickling, and squeezing the skin she can reach.  A massive churning begins in your gargantuan cumsack, a movement that actually shakes the ground.  Both of you knows what that signifies, the ghost girl going so far as to disengage from her feverish oral to stare longingly at you.  It seems you hold the key to sating her lust or denying her the orgasm she so craves; what do you do?");
		
		processTime(12);
		clearMenu();
		addButton(0, "LetHerCum", letShouldraIn);
		addButton(1, "KeepHerOut", kickShouldraOut);
		return;
	}
	output("\n\n");
	output("Taking complete control of your body as if it was never actually yours, she removes your [pc.gear] and throws them carelessly to the ground. Grabbing up your " + pc.cockDescript(x) + " in both hands and fondling it awkwardly, she strikes you as obviously inexperienced with the male anatomy, despite her levels of intelligence. She continues to grope your lengthening member, admitting, \"<i>Even with the rare male bodies I have possessed, I rarely got to play with their...</i>\" You feel your face flush as the ghost girl relives her awkward previous possessions. Your penis finally extends to its full length, and your hands slide up and down its length in a clumsy yet admittedly effective technique. Sweat soon begins lathering your body as you sink to your knees, confusingly overwhelmed by the pleasure of a simple self-stimulation. You've never felt this good while masturbating! You figure the otherworldly influence of your new 'room-mate' has something to do with this. As if to prove your theory, your mouth moves in the strange archaic language of the girl, and your body stiffens in both pain and pleasure as ");
	if (pc.balls > 0) output("your testicles churn with fertility and ");
	output("your manhood swells with new-found girth. The growth forces your hands further apart until your quivering pecker resembles a very excited fire hydrant. Drool begins to run from the corners of your mouth as she bites against your lower lip, head thrown back in the ecstasy of the stimulation. Finally, you feel a tightening in your scrotum, and you—all by yourself this time, as the ghost girl is in complete thrall of your body's orgasm—move your hand down to the bottom of your shaft. Remarkably, you actually feel the semen wriggling towards release under your fingers. With a final ecstatic scream equally parts ghost and human, your back arches as a geyser of semen bursts forth, showering you not unlike a fountain. After a long while kneeling and quivering, you finally get your wits about you and raise yourself back up, noting the lack of resistance from your non-corporeal friend. You sigh in relief as you watch your now-flaccid penis diminishing to its original proportions.\n\n", false);
	output("Her pleasure dealt with, the ghost girl appears head-first from your belly, flowing out and reconstituting herself into the normal, brown-eyed girl you first encountered.  Almost as an afterthought, she reaches down and plunges a hand into her still-dripping cunt. Evidently, she's taken ahold of something, and with a bit of effort she tugs a handful of translucent green goo right out. \"<i>Ectoplasm,</i>\" she explains, reaching down and grabbing her tunic. Reaching into a pocket, she produces a small bottle and pushes the slimy substance inside. \"<i>Essentially the product of a ghost orgasm, which you've so kindly provided for me.</i>\" She smiles, hands you the bottle, then moves to her clothing and swiftly dresses. With a little wave, she wanders away, rounding a corner and disappearing from sight. You resolve to find her again—her magic was pretty fun!");
	output("\n\n");
	IncrementFlag("COC.SHOULDRA_PENIS_DEFEAT_TIMES");
	processTime(15 + rand(5));
	pc.orgasm();
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}


private function letShouldraIn():void {
	shouldraSprite(true)
	clearOutput();
	output("The ghost girl squeals in excitement as you allow her partial control- only enough for her to feel your penis as if it were her own.  With an ecstatic, victorious scream, she impales herself upon your dick, taking the entire thing down her throat like it's nothing.  Your jet-stream of cum rockets into her gob, blasting her head straight off your dick to slam into your " + pc.chestDesc() + " with an \"<i>Oof.</i>\"\n\n");
	ghostBJFinisher(true);
}

//deny her
private function kickShouldraOut():void {
	shouldraSprite(true)
	clearOutput();
	output("Reminding her that this is a punishment for underestimating you, you firmly deny her request for entry.  Her bright yellow eyes glaze over in her disappointment, but she dare not go against your wishes.  The ghost girl turns back around and mechanically goes back to her work.  As soon as she slides her puckered lips down your twitching shaft, however, you're already past your point of endurance, and a jet of cum lifts her head right off of your dick.  The back of her head slams into your " + pc.chestDesc() + " with an \"<i>Oof.</i>\"\n\n");
	ghostBJFinisher(false);
}

//back to this thing okay
private function ghostBJFinisher(inside:Boolean):void {
	shouldraSprite(true)
	var x:Number = pc.cockThatFits(200);
	output("Like a backed up geyser, your gigantic testicles push hot, thick strands of seed out of your belaboured " + pc.cockDescript(x) + " straight up in the air.  The cum splatters on both you and the ");
	if (inside) output("excitedly convulsing");
	else output("practically lust-paralyzed");
	output(" girl, both of you too tired to bother moving away from the raining semen.  Panting heavily, you eventually haul yourself up, dragging the dainty ghost girl up with you.\n\n");
	pc.orgasm();
	IncrementFlag("COC.SHOULDRA_PENIS_DEFEAT_TIMES");
	//if ejaculation allowed
	if (inside) {
		output("\"<i>Thank you so much,</i>\" she breathes softly, wrapping her arms around you in a soft embrace.  \"<i>I wouldn't even be able to think straight if that much lust was built up without release.</i>\"  You smile and flick her nose, and she retorts with a sly half-grin.  \"<i>Oh, and you can have this,</i>\" she adds, swiftly tugging her pants down and reaching into her still-drooling cunt, dragging out a handful of ectoplasm.  She tugs out a small bottle from her shirt pocket and sticks the gooey stuff inside before offering it to you with a wink.  \"<i>Thanks again!</i>\"\n\n");
		output("You watch her move off into the ruins with a new spring in her step, chuckling as she goes before heading back to camp yourself.");
	}
	//if that bitch didn't get nothing
	else {
		output("She wobbles almost exaggeratedly before falling sideways, smacking her head against the ground and sending up a small splash of cum.  If she felt any pain, however, she doesn't react to it at all, staring vacantly at a dilapidated building and drooling slightly.  That outta teach her to try to pull a fast one on you twice, you figure.  As you stride past her, you tug her pants down to her knees and scoop out a good amount of ectoplasm from her vagina.  You reach into her pocket and grab a bottle (honking her boob for good measure and eliciting an aroused twitch), dumping the goo in and stuffing it in your pack.  She'll probably find a goblin eventually, you figure as you begin your journey back to the camp.");
	}
	output("\n\n");
	
	processTime(25 + rand(5));
	pc.orgasm();
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Penis With Worm Infestation Scene
//[penis selection with worm infestation] 
private function dewormYourGhost():void {
	shouldraSprite(true)
	clearOutput();
	output("As the ghost girl settles into your body, she swiftly recognizes the unfamiliar bulge against your [pc.gear], and you feel a wave of joy run though your body as she regards your dick. The skin on the back of your hand shudders, and you jump in surprise when the spirit's face appears on it. She waits patiently for you to get over the initial shock, then asks, \"<i>May I... please... I mean, you... ah...</i>\" You guess she must be slightly overwhelmed by her discovery. You softly ask her if she is referring to your maleness, and she responds with a suddenly anxious \"<i>Mmhmm!</i>\"\n\n");
	
	output("Chuckling to yourself, you consent to her pleadings, and she falls back into your body with a gleeful squeal. You climb out of your [pc.gear] and put a hand on your not-so-erect maleness, taking pleasure in the way she coos as blood begins to surge into your tool. Soon enough, your penis pulses in your hand, erect and ready for stimulation. You give it a little squeeze, not even noticing when one of the worms sheltering in your crotch slips out and wriggles across the floor, but the ghost girl surely does, and she makes herself known with a shrill scream that leaves your ears ringing and your head pounding. Worried, you ask her what's the matter ");
	if (flags["COC.SHOULDRA_WORM_SCENE_COUNTER"] == undefined) output(", and she responds by taking control of your hand and pointing down at the wriggling creature that crawled out of your junk. \"<i>Oh, that?</i>\" you scoff, waving your other hand in the air dismissively; your other, ghost-controlled appendage still quivers stubbornly as you attempt to explain. \"<i>There are tons of the little guys crawling around inside me. Wanna see?</i>\"");
	else output(", and your eyes flare with a yellow light as she takes control of your mouth. \"<i>You're still carrying those disgusting, awful, terrible, horrible things!?</i>\" she cries in disbelief, and it's obvious she doesn't understand the allure of the wriggly creatures. You try to appeal to her on a more basic level, informing her of the tactical advantages of combat-ready dickworms.");
	output("\n\n");
	pc.lust(15);
	output("There's silence for a moment, then you are almost rendered unconscious as she cries, \"<i>NOOOOOOOOPE,</i>\" telepathically, surging out of your body in record time. She corporealizes and backs away from you until she bumps into one of the ruined buildings. Then, she's off, booking it down the street to get as far away from you as possible. You shrug, figuring at the very least you dealt with her arousal, albeit in an unexpected way, and begin your trek back to your camp.");
	output("\n\n");
	IncrementFlag("COC.SHOULDRA_WORM_SCENE_COUNTER");
	
	processTime(25 + rand(5));
	pc.orgasm();
	if (inCombat()) {
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Penis With Exgartuan Scene
private function penisGartuanGhostSmexVictory():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	clearOutput();
	output("You feel an almost overwhelming surge of anxious arousal as the ghost girl regards your excessively large " + pc.cockDescript(x) + ". You decide to play along and place your hand over the bulge in your [pc.gear], enjoying her gleeful titter as your member twitches and hardens, just a tad. You begin to strip, but are halted by a familiar booming voice coming from the half-erect member. \"<i>WHO THE HELL IS THIS BITCH?</i>\" a perplexed Exgartuan yells grumpily. \"<i>Living in peoples' bodies is MY THING!</i>\"\n\n");
	
	output("The shocked ghost girl nearly leaps out of your body right then and there. \"<i>O-oh... I'm so-sorry for the... uh... ah...</i>\" she stutters in your voice, the words almost refusing to form in your mouth. Telepathically, she pulses to you, \"<i>Why didn't you tell me there was... someone else here?</i>\" angrily, and you meekly apologize for the oversight. \"<i>WELL!?</i>\" Exgartuan bellows, and your semi-flaccid dick twitches angrily.\n\n");

	output("After a moment's more of hesitation, the ghost girl sinks down to your waist, pushing her head out of your " + pc.hipDescript() + ".  \"<i>I apologize, sir, but our- er, sorry, your host did not mention he was already... occupied,</i>\" she admits in her soft, feminine voice.\n\n");
	
	output("\"<i>Hold up,</i>\" the demon requests, suddenly far less boisterous. \"<i>You're sayin' you're a chick, right?  And not some chick with a dick");
	if (pc.hasVagina()) output(" like this bitch here");
	output("?</i>\"\n\n");
	
	output("A blush (somehow) coming over her " + pc.skinTone + " cheeks, the ghost girl nods her head meekly. She obviously doesn't know what to expect from the volatile creature. She suddenly gives a little cry, and her head is sucked back into your body. You can vaguely feel her presence shift, and then, as if pulled, moving... into your penis?  You feel full control returning to you, and you place a hand under your prodigious pecker and hoist it slightly. You jump as the thing bucks in your grasp. \"<i>ALRIGHT, BITCH, LET'S GET TO SPIRIT SEX,</i>\" Exgartuan exclaims, and to your surprise, your spiritual newcomer groans expectantly.\n\n");
	
	output("\"<i>But you're soooo big,</i>\" she teases huskily, and your mind is suddenly filled with the mental image of the girl and the demon. They're located in a large, fleshy tunnel... you can easily guess what that signifies. You see what only can be Exgartuan in a vaguely humanoid (and obviously naked) shape, red wisps floating off of and around him. His enormous maleness is bared and twitching, dragging across the spongy ground. The ghost girl is as you remember her; however, she has thrown her tunic to the side and pulled her leggings down to her knees. The aroused apparition is kneeling on all fours in front of the endowed demon, swaying her squeezable hips softly as she looks lustily over her shoulder to her intangible lover. Taking control of your distraction, Exgartuan's influence surges into your frame, and you're finding yourself thrown farther into the mental image as he takes over. Your hands move to your dick, the mirror of his own, and he lifts the unit up onto the ghost girl's back; this causes a strange sight of your own manhood hovering in the air, and you can't get enough control back to fix the oddity. She shudders, the weight stimulating her and eliciting a few aroused squeaks.\n\n");
	
	output("Exgartuan slowly drags his mast back (and your own body mirrors the movement), and the ghost girl veritably vibrates with pent-up excitement as the cockflesh slides down her bared skin. Finally, the demon reaches her dripping mons, and pokes her lips tantalizingly with his head, lubricating her further with little bubbles of pre-cum. Impatient, she throws herself backwards onto the massive thing, but Exgartuan ");
	if (flags["COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT"] > 0) output("once again ");
	output("deviously shifts his hips upward at the last moment.  Instead of the expected vaginal penetration, the ghost girl is treated to an excess of demon girth jammed into her anus. You wince at the perceived discomfort, but are surprised when she moans ecstatically; you're even more surprised when you feel a near-vice-like tightness seal around your own shaft. Her hips widen to accommodate the insertion, and the beginnings of a paunch appear on her flat belly. The ghost girl writhes in bliss, and her moans only intensify when Exgartuan demands, \"<i>FACE DOWN, ASS UP.</i>\"  She complies, squishing her firm tits against the fleshy floor and jutting her lower body upward. The demon widens his stance, then gives an almighty hip thrust- and, of course, you feel outright silly as you perform the movement. You silently thank Marae that no one is around to watch you... or, at least, no one that you can see. He buries his oversized cock into the eager ghost girl, sinking in no less than eight inches, much to her delight. You stifle a groan as you feel the tight tunnel sliding up your member as well, and you'd surely fall if not for Exgartuan's control over you.\n\n");
	
	output("The specter's belly balloons forward as the giant genitals continue their journey, nearly unfettered by any semblance of human anatomy. A nonsensical stream of words flow out of her mouth as she bathes in the 'spirit sex.'  Your dick begins a steady drip of pre, the fluid splashing against the pavement as your body mirrors the lewd pelvic movements of your demonic accomplice. You feel her body, impaled up to her chest with your " + pc.cockDescript(x) + ", tighten further around the flesh as the demonic pre pulses into her over-stretched stomach. Her hands fly to her midsection as it steadily pulses further and further out. The spirit finally bottoms out with Exgartuan's glans lodging where her rib cage would be. Realizing the penetration will go no farther, the phantom winds her arms up and spins herself around; your eyes nearly cross as the twist transfers to your pole. The ghost girl attempts to locate the demon, but her belly has grown beyond her field of vision. That goal failed, she squeezes her thighs and rubs her ankles against the trembling flesh. Neither you nor Exgartuan are surprised when her applications succeed in a big way. The base of your- and his- dick bulges with the first pulse of seed. Your cum-tunnel swells to make room for the eruptions soon to come.\n\n");
	
	output("The ghost girl screams her pleasure as the first rope of cum squeezes its way into her abused pucker. Your body locks in Exgartuan's climatic pose; hands pumping your semen along, pelvis shaking to and fro in anticipation. The over-sensitized woman's cries rise in tempo with each blast of cum spilling into her, the demon treating her like a living condom. He pumps her up larger and larger, the otherworldly orgasm keeping up for what seems to you like hours. Unable to even shift your posture, you stand there cringing as at least a gallon of seed pours onto the cracked road. Like a broken water main, the sticky substance flows freely from your towering maleness.");
	if (silly) output("  In the middle of your ejaculatory adventure, a flap of wings alerts you to a presence above. Although unable to move your head in your current situation, you're made very well-aware of the nature of the intruder when a bird-like voice shrieks, \"<i>SLUUUUUUUUUUUUT,</i>\" at the top of her lungs. With a final caw, she flies away without a trace.");
	output("  Finally, after at least a minute and a half of orgasm, your 'fire hose' slows to a stream, then a trickle. Satisfied, Exgartuan releases control of you, and you collapse backwards into a deep puddle of baby-batter. Of course, you hardly notice, too focused on the rotund ghost girl wriggling weakly on the fleshy floor under her. Her gut resembles a huge, sloshy blimp, and you feel your tongue flashing across your lips like a curious snake as Exgartuan regards her.\n\n");
	
	output("Plugged as she still is on the demon's slowly softening dick, she can't even get her feet under her to rise. Unfazed, the girl giggles helplessly as she waits for Exgartuan to release her from his phallic grasp. The demon does her one better; he not only tugs his maleness out of her now-gaping ass, but he even stalks over to her after the removal and gives her a 'helping hand'. He reaches up, pressing his hands against the ghost girl's burgeoning belly and pushes downward. She begins to accost him for his rough treatment, but the words quickly fade to a gurgling shriek as cum bubbles from her throat and leaks out the corners of her mouth. Meanwhile, seed spews from her anus at a breakneck pace—the poor girl's eyes roll up towards the opposite wall as she's drained of the cum.\n\n");

	output("When the proverbial dust settles, you stir groggily. Blinking the sleep out of your eyes, you do a double take at the sheer amount of semen flooding the street. You feel a sensation building in your finally flaccid member, and you glance down. A pale, transparent smoke flows gently from your urethra, reforming into a very tired, moderately sore, but incredibly satisfied ghost girl.  ");
	if (flags["COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT"] == undefined) output("\"<i>Spirit sex... I can't say I've ever tried that,</i>\" she admits. \"<i>Damn if it isn't good.</i>\"\n\n");
	else output("\"<i>Damn,</i>\" she sighs, \"<i>that is still a great ride, I'd say...</i>\"\n\n");
	
	output("\"<i>THEY DON'T CALL ME 'THE DEVIL OF DICKINGS' FOR NOTHIN',</i>\" your dick-demon pipes in. The two of you share a laugh, and with a friendly wave, the spirit turns away. She sloshes through the layer of seed coating the ground, and you can't help but notice a little white fluid drip from her bare buttocks. The droplet causes a small wave to disperse through the jizz. You shake your head with a smile creeping across your cheeks. Spirit sex... what a ridiculous thing.\n\n");
	
	IncrementFlag("COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT");
	processTime(35 + rand(10));
	pc.orgasm();
	
	if (inCombat()) {
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}
	
//Vagina Scene
private function ghostGinaWinSexings():void {
	if (pc.statusEffectv1("Exgartuan") == 2 && rand(2) == 0) {
		ginaBoobgartuanShouldra();
		return;
	}
	shouldraSprite(true)
	clearOutput();
	output("The ghost girl heaves a mildly disappointed sigh as she settles into your body fully.  \"<i>I've had... many female hosts,</i>\" she explains. You momentarily feel embarrassed by the ghost's disapproval, and you almost move to apologize before the words catch in your throat and you cross your arms defensively.  ");
	if (flags["COC.SHOULDRA_VAGINAL_POSSESSIONS"] == undefined) output("She 'hmm's several times inside your head, but you can feel a surge of elation as she apparently reaches a solution. \"<i>Of course!</i>\" she cries excitedly.  \"<i>I actually have never done this before!</i>\"\n\n");
	else output("\"<i>Oh well, I suppose we can always just do that again,</i>\" she muses. \"<i>It worked well enough the first time.</i>\"\n\n");
	
	output("You are about to question exactly what she is referring to, but quickly fall silent as she gently but firmly takes control of your body, sliding out of your [pc.gear] and idly stroking your cunt. You allow her control of your mouth, and she chants a fairly lengthy spell, her absent-minded masturbation steadily gaining fervor as she progresses. With a final, shouted word of power, both of you cry out as your clitoris suddenly pulses and swells into your hand, the increased sensitivity nearly driving you insane. Your bitch-button does not stop there, however, puffing up with each heartbeat. Your eyes roll back in your head and small primitive grunts and moans escape your lips as your clit engorges in the ghostly magic, not stopping until it reaches at least four times its original length. A breeze blows through the ruined rooftops, and you scream as the wind brushes against your elongated bitch-button.  Too sensitive... the thing is way too sensitive!\n\n");

	output("Against your will, and against all of your better instincts, the ghost-girl, as aroused as you are uncomfortable, moves both hands to your sex, gripping it and giving it a squeeze. Your entire body locks up, causing you to fall backwards onto the pavement as a devastating orgasm rocks through your system. A strangled cry is the only reaction you can give to the explosive sensations. The ghost-girl, however, not satisfied with the suddenness of the climax, begins feverishly stroking your clitoris with one hand, the other reaching into your love-tunnel and stimulating the rosy flesh inside. You arch your back and attempt to dig small holes into the road with your " + pc.feet() + " as shock-waves run through your system over and over, never giving you a chance to recuperate. You hear, as if from a great distance, a mix of frenzied laughter and orgasmic cries of pleasure ringing inside your head. Finally, mercifully, you fade into unconsciousness, leaving the ghost girl to her constant stimulation.\n\n");
	
	output("You awake some time later in a prodigious puddle of girly spunk. Your attempt to sit up is impeded by a clunk against the ground.  A clunk? You prop yourself up on your elbows and glance down to see a large metal pipe, stuck in your vagina presumably some time during your black-out. Reaching down, you extricate a full ten inches of piping from your cunt, and shake your head at the tenacity of your unworldly bodily invader. You are happy to feel a tightening in your crotch, however, as the magic finally wears off, returning your womanliness to a " + pc.vaginaDescript(0) + ". You also note the absence of your gigantic clitoris, and give yourself a little stroke to confirm; it's reverted to normal size as well. All's well that ends well, you suppose.\n\n");
	
	output("Her pleasure dealt with, the ghost girl appears head-first from your belly, flowing out and reconstituting herself into the normal, brown-eyed girl you first encountered.  Almost as an afterthought, she smiles, moving to her clothing and swiftly dressing, then gives you a little wave before wandering away, rounding a corner and disappearing from sight. You resolve to find her again- her magic was pretty fun!");
	
	IncrementFlag("COC.SHOULDRA_VAGINAL_POSSESSIONS");
	
	var dildo:CockClass = new CockClass();
	dildo.cLengthRaw = 13;
	dildo.cType = GLOBAL.TYPE_EQUINE;
	dildo.cockFlags = [GLOBAL.FLAG_BLUNT, GLOBAL.FLAG_FLARED];
	
	pc.cuntChange(0, dildo.effectiveVolume(), true, true, false);
	processTime(35 + rand(10));
	pc.orgasm();
	
	if (inCombat()) {
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}
//Hermaphrodite Scene
private function hermaphroditeGhostsCumEctoplasm():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	clearOutput();
	if (flags["COC.SHOULDRA_HERMSEX_COUNT"] == undefined) output("She abruptly gasps in excitement and begins moving her hands towards your groin, though you swiftly reclaim control of the unruly appendages. \"<i>You have a penis,</i>\" she telepathically pulses to you with an anxious and excited edge to her voice. \"<i>My hosts... they rarely... they... </i>\"  ");
	//[if repeated] 
	if (flags["COC.SHOULDRA_HERMSEX_COUNT"] > 0) output("She chuckles softly as she recalls the times you've shared, and she hungrily goes for your maleness once more, though you mentally throw her off of it.  ");
	output("The communication suddenly breaks as the ghost-girl's will surges against yours, all thoughts of submissiveness vanishing from her mind.  ");
	
	if (pc.willpower() < 30) output("It's not very hard for her to break down your fortifications, and you soon feel yourself being pushed aside by her vast mental capacity.");
	else if (pc.willpower() < 45 || pc.cockThatFits(200) == -1) output("You begin to gain an edge, but the ghost girl is craftier than you expected, and she begins to pulse mental intrusions at you, scrambling your thoughts for just long enough for her to overtake you and push you to the side.  \"<i>You are one hundred years too early to challenge me,</i>\" she chides. \"<i>My intellect has long surpassed most any living creature on this plane.</i>\"");
	else {
		x = pc.cockThatFits(200);
		output("The ghost girl puts up a good fight, but you're more than prepared for her mental assault. You feel her panic well as her intrusions are overwhelmed, and though she attempts to disengage the mental link, you easily stop her. She screams mental protests at you, but your ringing ears only strengthen your psychological dominance over the poor spirit. Before long, she's reduced to a whimpering wreck. \"<i>Out,</i>\" you command, tired of the troublesome specter's meddlings. Of course, she won't even try to rebel now, resignedly accumulating her essence and beginning her exit. Within moments the ghost girl flows out of your body and resolidifies before you.\n\n");
	
		output("She moves to leave in a huff, but you stop her with a single telepathic demand. She's yours, you remind her, and since she's gone through the trouble of trying to get you off, she might as well finish the job. Even as her lips purse in a stubborn pout, a dominating wave of influence sweeps over her, and regardless of herself, she begins unsteadily moving towards you. Resolving to meet halfway, you stride over to her and push her to her knees.  As she watches, you shed your [pc.gear] and hoist your " + pc.cockDescript(x) + " up to her lips, leaving a fairly clear implication of your expectations. The ghost girl's eyes widen at the sight of your manhood, and she cringes as a new wave of arousal sweeps through her. She gives a little whimper at her inability to quell her overwhelming libido, but you simply laugh mockingly and gesture at your maleness.  \"<i>Ghost blowjob,</i>\" you mutter snidely.\n\n");
		
		output("You don't even give her the chance to act of her own volition, simply reaching out, taking ahold of her head, and slamming her onto your " + pc.cockDescript(x) + ".  She takes it surprisingly well, unsurprisingly easily, taking most of the shaft in the first thrust alone.  With not as much as even a sputter, she impatiently double-handedly grabs your " + pc.buttDescript() + " and thrusts her head forward.  Before you know it, your entire " + pc.cockDescript(x) + " is wrapped in a fleshy tunnel of love.");
		if (pc.cockTotal() > 1) {
			output("  Mindful of ");
			if (pc.cockTotal() == 2) output("your other dick");
			else output("the rest of [pc.eachCock]");
			output(", the mentally dominated girl quickly clutches ");
			if (pc.cockTotal() == 2) output("your other shaft and pumps it vigorously.");
			else if (pc.cockTotal() == 3) output("your other two shafts and pumps them vigorously.");
			else output("two other shafts and pumps them vigorously.");
		}
		output("\n\n");
		
		output("The ghost girl goes to town on your genitals, the combination of your will and her still-rising lust fueling her movements.\n\n");
		
		output("Although her mouth is quite full, her voice rings clearly in your head as she starts casting a spell.  You glance down at her, surmising from her almost serene expression and heavy-rimmed eyes that she's even gotten over her inability to orgasm.  She finishes her spell with the usual flourish before once more focusing her attention to your pleasure.  ");
		if (pc.cockTotal() == 2) output("Taking her hand away from your other dick, the ");
		else if (pc.cockTotal() >= 3) output("Taking her hands away from your other dicks, the ");
		else output("The ");
		output("ghost girl smiles around your phallus, and you can only guess what she has planned.  You don't have long to wait, however; a strange roiling arises ");
		if (pc.balls > 0) output("in your [pc.balls]");
		else output("near the base of your shaft");
		output(".  ");
		if (pc.balls == 0) output("The first effects of the spell make themselves known in a big way when an overladen cumsack forms and drops between your legs.  ");
		output("The strange feeling focuses on your testes, making it a bit hard to concentrate on keeping the ghost girl subdued.  Your management of willpower does not waver until you feel your legs being pushed farther apart.  A curious glance turns into a horrified stare as you gaze upon your now ");
		if (pc.ballDiameter() > 10) output("gargantuan");
		else output("basketball");
		output("-sized balls.\n\n"); 
		
		output("Taking advantage of your distraction, your former mind slave pushes you over and jumps on top of you.  Her impotently sopping box leaves streaks of clear fluid across your belly as she continues her work on your cock");
		if (pc.cockTotal() > 1) output("s");
		output(" while swaying her hips to and fro.  Both of her hands get to work on rubbing your ever-growing testicles, but two hands can't cover the growing amount of space necessary for effective stimulation.  She shrugs, content with patting, tickling, and squeezing the skin she can reach.  A massive churning begins in your gargantuan cumsack, a movement that actually shakes the ground.  Both of you knows what that signifies, the ghost girl going so far as to disengage from her feverish oral to stare longingly at you.  It seems you hold the key to sating her lust or denying her the orgasm she so craves; what do you do?");
		
		processTime(12);
		clearMenu();
		addButton(0, "LetHerCum", letShouldraIn);
		addButton(1, "KeepHerOut", kickShouldraOut);
		return;
	}
	output("\n\n", false);
	
	output("Taking complete control of your body as if it was never actually yours, she removes your [pc.gear] and throws them carelessly to the ground. Grabbing up your " + pc.cockDescript(x) + " in both hands and fondling it awkwardly, she strikes you as obviously inexperienced with the male anatomy, despite her levels of intelligence. She continues to grope your lengthening member, admitting, \"<i>Even with the rare male bodies I have possessed, I rarely got to play with their...</i>\"\n\n");
	
	output("You feel your face flush as the ghost girl relives her awkward previous possessions. Your penis finally extends fully, and your hands slide up and down its length in a clumsy yet admittedly effective technique. She 'ooo's in surprise as one of your hands slips a bit lower and brushes against an entirely and completely female cunt.  ");
	if (pc.balls > 0) output("Stopping her double-handed stroke technique, she slips your hand under your obtrusive " + pc.ballsDescript() + " and gently pushes them aside to get a better look at your previously unnoticed female sex.  ");
	output("She chuckles malevolently, and you groan, mind cycling through the possible outcomes of the girl's impulses. Your lips curl unbidden in an evil smile, then begin mouthing an archaic incantation. You wince inwardly, bracing for the worst. She finishes and goes back to the vigorous stroking, and you are left to wonder what the spell was meant to do- that is, until you feel a tingling beginning at the base of your " + pc.cockDescript(x) + ", slowly climbing up the shaft until your entire length is covered in the sensation.\n\n");
	
	output("Your eyes widen as your proud, rigid member becomes significantly more elastic. As the ghost girl continues to stroke, you marvel at the odd sensation, flexible yet still firm. She stops suddenly, and begins bending the shaft downwards, and you have a fairly good idea of what she plans to do with your magically-altered manhood. True enough, she promptly loops your bendy dick over and inserts it firmly into your fuck-hole, creating the most confusingly arousing feeling you've ever experienced. She continues to push until your shaft reaches its limit, shoving the entire thing into your slavering slit.");
	pc.cuntChange(0, pc.cockVolume(x), true, true, false);
	output("  Unable to do much in your current position, the ghost girl launches into spellcasting once more with a determined edge to her voice. The tingling feeling returns, this time beginning in your head and intensifying. You sharply inhale as your glans begins vibrating and wiggling around, stimulating your tunnel better than any dildo. The vibration has a similar effect on the penis itself, and you can't resist a moan as the tingles creep up your shaft. This tension lasts for an impressive amount of time, and the ghost-girl, getting sick of your endurance, cries a single word, intensifying the jostling of your dick and drawing a throaty gurgle from you. Any conceptions of restraint are quickly shattered under the stimulation, and you climax hard, writhing on the cracked pavement and crying out in ecstasy as a result of an actual occurrence of a ghost-assisted self-fuck. You're only pushed further over the edge with the journey of your seed through your misshapen urethra, the curve causing a small 'traffic jam' of cum and stretching the urethra further out.\n\n");
	
	output("Finally, the seed spills out with an explosive splash into your carnal canal, and your scream only intensifies, the ghost girl joining in with her own melodic voice inside your mind. Gout after gout of cum bursts into you. Your vibrating head keeps the semen from leaking out as your belly protrudes a bit to accommodate. After many blissful moments, your orgasm winds down, and you collapse. Luckily, you remain mindful enough to drag your dick, with the vibration dying down, back out into the open, a torrential mixture of female lovejuice and semen pouring out and pooling around your " + pc.buttDescript() + ". You lie there for minutes, gathering your wits and feeling your penis gradually stiffen once more, the effects worn out. After several attempts, you manage to summon enough strength to slide yourself into a sitting position, wondering what happens now.\n\n");
	
	output("Her pleasure dealt with, the ghost girl appears head-first from your belly, flowing out and reconstituting herself into the normal, brown-eyed girl you first encountered.  Almost as an afterthought, she smiles, moving to her clothing and swiftly dressing, then gives you a little wave before wandering away, rounding a corner and disappearing from sight. You resolve to find her again- her magic was pretty fun!");
	IncrementFlag("COC.SHOULDRA_HERMSEX_COUNT");
	processTime(35 + rand(10));
	pc.orgasm();
	
	if (inCombat()) {
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Loss Introduction
internal function loseToShouldra():void {
	shouldraSprite(true)
	clearOutput();
	output("You fall with a dull thud onto the abandoned road, thoroughly beaten by the seemingly unremarkable young woman.  As you struggle to rise, she casually walks over to you, standing with hands on hips and staring down at you.  You freeze, not wanting to make any sudden moves against this unpredictable opponent.  She slowly takes off her loose-fitting tunic, exposing her firm and squeezable C-cups. Curiously, she kicks off her comfortable shoes, but leaves her tight leggings on. You suspect something fishy, and raise an eyebrow as she straddles you. Unexpectedly, she hops up and spins completely around, landing on your abdomen, butt facing you, with enough force to elicit an 'oof'. You glance down at her; she half-turns, looking mischievously (and with a hint of evil intent) back at you. A small rumbling against your belly is the only warning you get before her leggings suddenly bulge weirdly, containing a substantially larger amount of flesh than a moment previous. Her ass continues to swell up, beginning to billow up and over the increasingly more constrictive waistband, and you can't help but raise a hand and squeeze the burgeoning buttflesh. You take pleasure in the sensation as it pulses further around your hand, squishing deeper into the cheek. Small rips begin to form on the cloth as her hips join in on the growth, the increasing amount of posterior raising her up slightly with each passing moment.  ");
	//[if dick] 
	if (pc.hasCock()) output("Each pulse pushes her a bit further onto your hardening manhood");
	else if (pc.hasVagina()) output("You can't deny the heat slowly welling up in your loins, your love-tunnel getting more lubricated by the moment");
	else output("You can't deny the heat slowly starting to gather in your bare loins");
	output(". Finally, the waistband of her poor garment bursts, and several handfuls of butt spill onto your torso.\n\n");

	output("Wondering what the point of that was, you raise your head and glance up at her face, now at least four inches higher that she just was. She reaches down and gives your ");
	if (pc.hasCock()) output("quivering member");
	else if (pc.hasVagina()) output("sopping gash");
	else output("sensitive crotch-flesh");
	output(" an absent stroke, then closes her eyes and begins chanting in a strange language, her voice sounding akin to a gentle breeze flowing through a copse of trees. Your eyes widen as a light blue fire outlines her body, and her form becomes... less than corporeal. She opens her eyes, her previously brown irises now glowing with a pallid yellow light. She whispers the final word of her incantation, and for a moment, nothing happens... until, to your surprise, she begins to sink into your torso! \"<i>Boo!</i>\" she cries with a cute little cackle.  You begin to rise, but stiffen as her otherworldly influence begins seeping through you. Falling back again, you struggle to fight against the unwanted intruder, but to no avail; at this point, she has sunken down to her shoulders, and she offers you an excited wink as her head descends. Your fingers twitch for about a minute more as the ghost girl struggles against you for control of your muscles. Eventually, however, she finds a means of control; your already heightened libido. Your mind clouds, and the only moments of clarity are filled with enough perverse stimulation to make the hardiest paladin blush.\n\n");
	
	output("As you finally come out of the ghostly-influenced imagery, you find yourself unwillingly sitting up, the ghost girl beginning to explore your body freely. With a frustrated sigh, you concede control of your body to the ghost girl- for the time being, at least. With her at the wheel, your body reacts by shifting the color of your eyes to the same yellow tone of her ghostly form.\n\n");

	if (pc.hasCock()) {
		if (pc.hasStatusEffect("Infested")) loseToShouldraWithWorms();
		else if (pc.statusEffectv1("Exgartuan") == 1) ghostGartuanLossSceneOrSomeShit();
		else if (pc.biggestCockVolume() >= 800) shouldraGiantCockLoss();
		else if (pc.isHerm()) loseToShouldraAsHerm();
		else ourDadTaughtUsNotToBeAshamedOfOurDicks();
	}
	else if (pc.hasVagina()) ghostGinaLosses();
	else genderlessShouldrasLossRapes();
}
	
//Loss Scenes
//Penis Scene
//[If you have a penis] 
private function ourDadTaughtUsNotToBeAshamedOfOurDicks():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	//[first encounter] 
	if (flags["COC.SHOULDRA_PENIS_DEFEAT_TIMES"] == undefined) output("She abruptly gasps in excitement, ");
	else output("She 'ooo's softly as she recalls your anatomy, ");
	output("and you feel your hands moving unbidden towards your crotch. You snap the sneaky extremities back to your sides, knowing exactly what she wants to do. The ghost girl soon proves herself the stronger in the contest of wills, however, and eventually, your will breaks and she takes complete control once again. She forces your body to stand, removing your [pc.gear] and throwing them carelessly to the ground. She takes your " + pc.cockDescript(x) + " in both hands and fondles it awkwardly, obviously inexperienced with the male anatomy.  \"<i>Most of my hosts have been women,</i>\" she explains as she continues to grope your lengthening member.  \"<i>And even then, I rarely got to play with their...</i>\"\n\n");
	
	output("You feel your face flush as the ghost girl relives her awkward previous possessions. Your penis finally extends to its fullest, and your hands slide up and down its length in a clumsy yet admittedly effective technique. Sweat soon begins lathering your body as you sink to your knees, confusingly overwhelmed by the pleasure of a simple self-stimulation. You've never felt this good while masturbating! You figure the otherworldly influence of your new 'room-mate' has something to do with this. As if to prove your theory, your mouth moves in the strange archaic language of the girl, and your body stiffens in both pain and pleasure as ");
	///[if present] 
	if (pc.balls > 0) output("your testicles churn with fertility and ");
	output("your manhood swells with new-found girth. The growth forces your hands further apart until your quivering pecker resembles a very excited fire hydrant. Drool begins to run from the corners of your mouth as she bites against your lower lip, head thrown back in the ecstasy of the stimulation. Finally, you feel a tightening in your scrotum. The ghost girl is caught in the complete thrall of your body's orgasm, so you move your hand down to the bottom of your shaft yourself. Remarkably, you actually feel the semen wriggling towards release under your fingers. With a final ecstatic scream equally parts ghost and human, your back arches as a geyser of semen bursts forth, showering you not unlike a fountain. After a long while kneeling and quivering, you finally get your wits about you and raise yourself back up, noting the lack of resistance from your non-corporeal friend. You sigh in relief as you watch your now-flaccid penis diminishing to its original proportions.\n\n", false);
	
	output("A strange sensation begins in your midsection, and you press a hand against the flesh curiously. You remove it swiftly as a familiar head suddenly pushes out, wiggling about until it faces you. She smiles, then draws her arms out of her torso and uses them as leverage (with a whispered spell to make her hands tangible) to remove herself from you completely. Muttering an incantation and solidifying her again-unremarkable form, she winks at you and gathers her tunic, slipping it over her frame. As you watch, she slips her thumb and forefinger into her satisfied snatch, producing a healthy helping of a spooky gooey substance. Reaching into a pocket inside her tunic, she draws out a small bottle, which she promptly squishes the ectoplasm into. She offers you the bottle, explaining, \"<i>The product of a... ghost climax, if you will. Keep it, it's good for you.</i>\"  With a happy goodbye, she wanders into an alley, grabbing her ruined leggings and discarded shoes as she goes, and disappears into the shadows. You move to leave, but find your " + pc.legs() + " growing heavy, fatigue washing over you in the aftermath of the possession. Before you know it, you're on your knees, and you have to struggle to keep your eyelids from drooping. You succumb to the exhaustion, slumping to the ground and soon snoring contentedly.");
	output("\n\n");
	//dynStats("sen", 1);
	
	IncrementFlag("COC.SHOULDRA_PENIS_DEFEAT_TIMES");
	processTime(65 + rand(15));
	pc.orgasm();
	
	if (inCombat()) {
		itemScreen = CombatManager.genericLoss;
		lootScreen = CombatManager.genericLoss;
		useItemFunction = CombatManager.genericLoss;
		itemCollect([new CoCEctoplasm()]);
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Penis With Worm Infestation Scene
private function loseToShouldraWithWorms():void {
	shouldraSprite(true)
	//[first encounter]
	if (flags["COC.SHOULDRA_WORM_SCENE_COUNTER"] == undefined) output("She abruptly gasps in excitement, ");
	else output("She 'ooo's softly as she recalls your anatomy, ");
	output("and you feel your hands moving unbidden towards your crotch. The ghost girl soon proves herself the stronger in the contest of wills, however, and eventually, your will breaks and she takes control. She heaves your body off the ground, removing your [pc.gear] and throwing them carelessly to the ground. She takes your " + pc.cockDescript(0) + " in both hands and fondles it awkwardly, obviously inexperienced with the male anatomy. \"<i>Most of my hosts have been- WHAT THE FUCK!?</i>\"\n\n");
	
	output("She clumsily throws your body backwards and thrusts your pelvis forward (as if to distance herself as much as possible from your blighted meat) as several worms wriggle out of your cockslit. Your whole body shudders as she regards them. \"<i>Why the hell are things crawling out of your cock?</i>\" she demands to know, screaming again as another worm falls out. You don't notice, but your eyes shift from yellow back to their normal coloration as you explain to her your infestation with the things. You attempt to soothe her with a promise that they mostly stay out of the way, but she's obviously had enough of the things. Before you can react, she flows out of your body and shifts back into her fleshy form. As soon as her feet become solid enough to walk, she lurches back with a horrified expression playing across her features. You give one last attempt to salvage the situation, offering, \"<i>Hey, at least they're small, right?</i>\"\n\n");
	
	output("The ghost-girl responds by meeting your eyes and staring daggers at them, and before you can stop her, she leaps towards you, spins, and cracks a kick against the side of your neck. You go tumbling to the ground and unsteadily raise your head to watch her stomp away, grumbling about worms and freaky fetishists. The pavement rushes up to meet you, and the world fades away as you slip into unconsciousness.");
	output("\n\n");
	IncrementFlag("COC.SHOULDRA_WORM_SCENE_COUNTER");
	pc.HP( -pc.HP() + 1);
	processTime(65 + rand(25));
	CombatManager.genericLoss();
}

//Vagina Scene
private function ghostGinaLosses():void {
	shouldraSprite(true)
	output("The ghost girl heaves a mildly disappointed sigh as she settles into your body fully.  \"<i>I've had... many female hosts,</i>\" she explains. You are almost embarrassed regarding her disapproval, and actually contemplate apologizing before remembering the source of the lament. You cross your arms (or try, as the ghost still has full control of your body) and give an annoyed huff.  ");
	if (flags["COC.SHOULDRA_VAGINAL_POSSESSIONS"] == undefined) output("She 'hmm's several times, raising your hand and tapping your finger against your chin. She snaps your fingers as a revelation washes over her.  \"<i>Of course!</i>\" she cries excitedly.  \"<i>I actually have never done this before!</i>\"");
	else output("\"<i>Oh well, I suppose I can always just do that again,</i>\" she muses. \"<i>It worked well enough the first time.</i>\"");
	output("\n\n");
	
	output("You are about to question exactly what she is referring to, but quickly fall silent as she slides out of your [pc.gear] and idly strokes your cunt. She takes control of your mouth and chants a fairly lengthy spell, her absent-minded masturbation steadily gaining fervor as she progresses. With a final, shouted word of power, both of you cry out as your clitoris suddenly pulses and swells into your hand, the increased sensitivity nearly driving you insane. Your bitch-button does not stop there, however, puffing up with each heartbeat. Your eyes roll back in your head and small primitive grunts and moans escape your lips as your clit engorges in the ghostly magic, not stopping until it reaches at least four times its original length. A breeze blows through the ruined rooftops, and you scream as the wind brushes against your elongated bitch-button. Too sensitive... the thing is way too sensitive!\n\n");
	
	output("Against your will, and against all of your better instincts, the ghost-girl, as aroused as you are uncomfortable, moves both hands to your sex, gripping it and giving it a squeeze. Your entire body locks up, causing you to fall backwards onto the pavement as a devastating orgasm rocks through your system. A strangled cry is the only reaction you can give to the explosive sensations. The ghost-girl, however, not satisfied with the suddenness of the climax, begins feverishly stroking your clitoris with one hand, the other reaching into your love-tunnel and stimulating the rosy flesh inside. You arch your back and attempt to dig small holes into the road with your " + pc.feet() + " as shock-waves run through your system over and over, never giving you a chance to recuperate. You hear, as if from a great distance, a mix of frenzied laughter and orgasmic cries of pleasure ringing inside your head. Finally, mercifully, you fade into unconsciousness, leaving the ghost girl to her constant stimulation.\n\n");
	output("You awake some time later in a prodigious puddle of girly spunk and attempt to slowly sit up, only to be impeded by a clunk against the ground.  A clunk?  You prop yourself up on your elbows and glance down to see a large metal pipe, stuck in your vagina presumably some time during your black-out. Reaching down, you extricate a full ten inches of piping from your cunt, and shake your head at the tenacity of your unworldly bodily invader. You are happy to feel a tightening in your crotch, however, as the magic finally wears off, returning your womanhood back to a " + pc.vaginaDescript(0) + ". You also note the absence of your gigantic clitoris, and give yourself a little stroke to confirm; it's reverted to normal size as well. All's well that ends well, you suppose.\n\n");
	
	output("A strange sensation begins in your midsection, and you press a hand against the flesh curiously. You remove it swiftly as a familiar head suddenly pushes out, wiggling about until it faces you. She smiles, then draws her arms out of her torso and uses them as leverage (with a whispered spell to make her hands tangible) to remove herself from you completely. Muttering an incantation and solidifying her again-unremarkable form, she winks at you and gathers her tunic, slipping it over her frame. As you watch, she slips her thumb and forefinger into her satisfied snatch, producing a healthy helping of a spooky gooey substance. Reaching into a pocket inside her tunic, she draws out a small bottle, which she promptly squishes the ectoplasm into. She offers you the bottle, explaining, \"<i>The product of a... ghost climax, if you will. Keep it, it's good for you.</i>\"  With a happy goodbye, she wanders into an alley, grabbing her ruined leggings and discarded shoes as she goes, and disappears into the shadows. You move to leave, but find your " + pc.legs() + " growing heavy, fatigue washing over you in the aftermath of the possession. Before you know it, you're on your knees, and you have to struggle to keep your eyelids from drooping. You succumb to the exhaustion, slumping to the ground and soon snoring contentedly.");
	output("\n\n");
	
	IncrementFlag("COC.SHOULDRA_VAGINAL_POSSESSIONS");
	processTime(65 + rand(15));
	pc.orgasm();
	
	if (inCombat()) {
		itemScreen = CombatManager.genericLoss;
		lootScreen = CombatManager.genericLoss;
		useItemFunction = CombatManager.genericLoss;
		itemCollect([new CoCEctoplasm()]);
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Hermaphrodite Scene
private function loseToShouldraAsHerm():void {
	shouldraSprite(true)
	if (flags["COC.SHOULDRA_HERMSEX_COUNT"] == 0) output("She abruptly gasps in excitement, ");
	else output("She coos softly as she recalls your anatomy, ");
	output("and you feel your hands moving unbidden towards your crotch. You snap the sneaky extremities back to your sides, knowing exactly what she wants to do. The ghost girl soon proves herself the stronger in the contest of wills, however, and eventually, your will breaks and she takes complete control once again. She forces your body to stand, removing your [pc.gear] and throwing them carelessly to the ground. She takes your " + pc.cockDescript(0) + " in both hands and fondles it awkwardly, obviously inexperienced with the male anatomy.  \"<i>Most of my hosts have been women,</i>\" she explains as she continues to grope your lengthening member.  \"<i>And even then, I rarely got to play with their...</i>\"\n\n");
	
	output("You feel your face flush as the ghost girl relives her awkward previous possessions. Your penis finally extends to its full length, and your hands slide up and down its length in a clumsy yet admittedly effective technique. She 'ooo's in surprise as one of your hands slips a bit lower and brushes against an entirely and completely female cunt. ");
	if (pc.balls > 0) output("Stopping her double-handed stroke technique, she slips your hand under your obtrusive " + pc.ballsDescript() + " and gently pushes them aside to get a better look at your previously unnoticed female sex.  ");
	output("She chuckles evilly, and you groan, mind cycling through the possible outcomes of the girl's impulses. Your lips curl unbidden in an evil smile, then begin mouthing an archaic incantation, and you wince inwardly, bracing for the worst. She finishes and goes back to the vigorous stroking, and you are left to wonder what the spell was meant to do—that is, until you feel a tingling beginning at the base of your " + pc.cockDescript(0) + ", slowly climbing up the shaft until your entire length is covered in the sensation.\n\n");
	
	output("Your eyes widen as your proud, rigid member becomes significantly more elastic. As the ghost girl continues to stroke, you marvel at the odd sensation, flexible yet still firm. She stops suddenly, and begins bending the shaft downwards, and you have a fairly good idea of what she plans to do with your magically-altered manhood. True enough, she promptly loops your bendy dick over and inserts it firmly into your fuck-hole, creating the most confusingly arousing feeling you've ever experienced. She continues to push until your shaft reaches its limit, able to shove the whole thing into your slavering slit. Unable to do much in your current position, the ghost girl launches into spellcasting once more with a determined edge to her voice. The tingling feeling returns, this time beginning in your head and intensifying. You sharply inhale as your glans begins vibrating and wiggling around, stimulating your tunnel better than any dildo. The vibration has a similar effect on the penis itself, and you can't resist a moan as the tingles creep up your shaft. This tension lasts for an impressive amount of time, and the ghost-girl, getting sick of your endurance, cries a single word, intensifying the jostling of your dick and drawing a throaty gurgle from you. Any conceptions of restraint are quickly shattered under the stimulation, and you climax hard, writhing on the cracked pavement and crying out in ecstasy as a result of an actual occurrence of a ghost-assisted self-fuck. You're only pushed further over the edge with the journey of your seed through your misshapen urethra, the curve causing a small 'traffic jam' of cum and stretching the urethra further out.\n\n");
	
	output("Finally, the seed spills out with an explosive splash into your carnal canal, and your scream only intensifies, the ghost girl joining in with her own melodic voice inside your mind. Gout after gout of cum bursts into you. Your vibrating head keeps the semen from leaking out as your belly protrudes a bit to accommodate. After many blissful moments, your orgasm winds down, and you collapse. Luckily, you remain mindful enough to drag your dick, with the vibration dying down, back out into the open, a torrential mixture of female lovejuice and semen pouring out and pooling around your " + pc.buttDescript() + ". You lie there for minutes, gathering your wits and feeling your penis gradually stiffen once more, the effects worn out. After several attempts, you manage to summon enough strength slide yourself into a sitting position, wondering what happens now.\n\n");
	
	output("A strange sensation begins in your midsection, and you press a hand against the flesh curiously. You remove it swiftly as a familiar head suddenly pushes out, wiggling about until it faces you. She smiles, then draws her arms out of her torso and uses them as leverage (with a whispered spell to make her hands tangible) to remove herself from you completely. Muttering an incantation and solidifying her again-unremarkable form, she winks at you and gathers her tunic, slipping it over her frame. As you watch, she slips her thumb and forefinger into her satisfied snatch, producing a healthy helping of a spooky gooey substance. Reaching into a pocket inside her tunic, she draws out a small bottle, which she promptly squishes the ectoplasm into. She offers you the bottle, explaining, \"<i>The product of a... ghost climax, if you will. Keep it, it's good for you.</i>\"  With a happy goodbye, she wanders into an alley, grabbing her ruined leggings and discarded shoes as she goes, and disappears into the shadows. You move to leave, but find your " + pc.legs() + " growing heavy, fatigue washing over you in the aftermath of the possession. Before you know it, you're on your knees, and you have to struggle to keep your eyelids from drooping. You succumb to the exhaustion, slumping to the ground and soon snoring contentedly.");
	output("\n\n");
	IncrementFlag("COC.SHOULDRA_HERMSEX_COUNT");
	processTime(65 + rand(15));
	pc.orgasm();
	if (inCombat()) {
		itemScreen = CombatManager.genericLoss;
		lootScreen = CombatManager.genericLoss;
		useItemFunction = CombatManager.genericLoss;
		itemCollect([new CoCEctoplasm()]);
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Enormous Cock Scene
private function shouldraGiantCockLoss():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	output("Her attention inevitably moves to your gigantic dick, somehow still contained in your garments, and she swiftly clamors to free it from its prison. Practically tearing off your [pc.gear], she tilts your head back in order to fully take in your " + pc.cockDescript(x) + ", a small line of drool escaping the edge of your mouth. She opens your mouth as if to speak, but cannot find words, instead settling for a long and anxious groan. Her first reaction is to simply hug the titantic shaft, squeezing happily. Eventually, she seems to realize her original intent and draws back, stroking your chin with your hand while she apparently ascertains the best way to stimulate your monster. With a small 'aha!', she struggles to stand, unused to such a strange center of balance. Bringing you along for the ride, she begins wandering the streets of the city, taking control of your mouth and shouting \"<i>My oh my, how on earth will I ever blow my load with this GIANT dick?</i>\" Her efforts are rewarded when you hear a small pitter-patter of feet, distantly at first, but hastily heading toward you. A duo of goblins rush out around a corner, take a moment to confirm the reported size of your manhood, and hurry over, undressing, tripping and shoving each other in an effort to win the race to win your attention. As they reach you the excited little creatures nearly bowl you over as they start stroking and licking every inch of cockflesh they can reach. \"<i>Girls!</i>\" the ghost exclaims sternly (with your voice), crossing your arms in front of you as they turn their heads to regard you. She allows a hint of a smile to show at the corners of your mouth as she continues, \"<i>Trust me when I say there will be enough of me for both of you.</i>\"\n\n");
	
	output("Without another word, she reaches out and grabs one of the goblins by the shoulder and begins chanting in her strange unknown language, wiggling the fingers of your absent hand at the ");
	//[if first time]
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("bemused ");
	else output("excited ");
	output("girl. With a flair, she finishes the incantation, then moves to the other goblin and repeats the process. The first goblin, meanwhile, ");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("searches her body for any signs of change, and when she finds none, begins pouting.");
	else output("resists the urge to smash her tits together, waiting with as much patience as she can muster.");
	output("  By this time, the ghost girl has finished with the spell, ");
	//[if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("and instead of offering an explanation, she merely ");
	else output("and, to the green girl's obvious delight, ");
	output("reaches over and kneads the goblin's ");
	//([if first time]
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("small, firm B-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 1) output("perky, sizeable C-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 2) output("well-formed, jiggly D-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 3) output("big and squishy E-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 4) output("oversized, heaving F-cups");
	else output("gigantic and openly-bared G-cups");
	output(". The goblin ");
	//[if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("instantly stops her protests, suddenly too stimulated by the massage to worry about any magical favoritism, ");
	else output("cries out in ecstasy at the still-incredible sensation, ");
	//[if first time]
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("although that doesn't stop the second goblin to begin voicing her own dissent");
	else output("and you can't help but notice the excited blush running across the second goblin's face");
	output(". The ghost girl pinches a quickly-stiffening nipple and pulls it out, ");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("and... pulls the breast along with it?");
	else output("and pulls the breast along with it.");
	output("  You inwardly gasp ");
	//[if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("as the effects of the magic are revealed");
	else output("despite seeing the magic before, always enthralled by the process");
	output("; it has turned the goblin's breasts into an almost putty-like substance");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output(", evidently!");
	else output(" once again");
	output(". The ghost girl begins to speed the process up, softly laying the goblin on the ground and kneading out the green girl's tits, adding at least half a cup size with every tug. The second goblin, watching intently behind your back, ");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("gasps in amazement, ");
	else output("can't restrain her urges any longer, ");
	output("swiftly reaching down to roughly grab at her own ");
	//[if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("petite boobs");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 1) output("modest bosom");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 2) output("sizable chest");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 3) output("large endowments");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 4) output("huge tits");
	else output("titanic melons");
	output(", crying in excitement as her breasts also begin to billow out under her own ministrations.\n\n");
	
	output("The first goblin's breasts, at this time, have reached at least ");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("E-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 1) output("F-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 2) output("G-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 3) output("H-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 4) output("I-cups");
	else output("J-cups");
	output(", and the ghost girl speeds up the massage ever further. Not satisfied with the progress, she raises the goblin's head to your lips and blows a steady gust of wind down the little woman's throat, ballooning her glistening mammaries out much more efficiently. This continues until the goblin nearly collapses under the weight of her new ");
	//[if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("HH-cups");
	//[if repeated once] 
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 1) output("II-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 2) output("JJ-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 3) output("KK-cups");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 4) output("LL-cups");
	else output("MM-cups");
	output(", and the ghost girl turns your attention to the second goblin, whose boobs are embarrassingly uneven due to her...unpracticed skills. The ghost girl moves you over to her, mercifully evening the currently ");
	//([if first time] 
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == undefined) output("DD-cup (and C-cup, on the other side)");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 1) output("EE-cup (and D-cup, on the other side)");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 2) output("FF-cup (and E-cup, on the other side)");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 3) output("GG-cup (and F-cup, on the other side)");
	else if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] == 4) output("HH-cup (and G-cup, on the other side)");
	else output("II-cup (and H-cup, on the other side)");
	output("breasts out, before again blowing into the goblin's mouth, inflating the goblin until she matches the first. With an excited giggle, the ghost girl swings you around to stand between the two amazed goblin girls, flinging a large glob of pre-cum into the first goblin's face, which she promptly smears over her breasts, enjoying the extra lubrication. She slowly drops to your back, presenting your cock vertically to the two increasingly eager girls, and gives a simple order: \"<i>Titfuck.</i>\"\n\n");
	
	output("Not needing to be asked twice, the two girls fall into place on each side of your prodigious shaft, heaving their engorged bosoms up and wrapping them around your penis. Pillowy boobflesh smooshes delightfully onto your crotch, around your " + pc.cockDescript(x) + ", and meeting in the middle, the goblins' nipples slipping against each other. They look to you for final confirmation, and the ghost girl nods your head; at this point, you find yourself voluntarily nodding along with her, completely entranced by this situation. With aroused grunts and moans, the goblins begin sliding their soft, slippery flesh up and down your shaft, and, on a sudden influence, they step onto your hips, heaving themselves up and using the increased height to stimulate even more of your " + pc.cockDescript(x) + ". You and the ghost girl both reel back by the sensations of the goblin double-paizuri, and it's not long before you feel yourself reaching the end of your sexual rope, and the ghost girl informs the goblins of this. Faster than you thought possible, given their recent additions, the second goblin zooms over to your shoulders and hoists you up to a sitting position, your gigantic cock falling right into the hands of the first girl, who promptly wraps her pair of tips around each side of your head and plunges her lips around your now-dilating urethra, sucking eagerly and squeezing dollops of breast milk out of her over-stimulated bosom. To help push you over the edge, the second goblin squishes her own pair of boobs against your back and slides up and down, leaving small milky trails across you.\n\n");
	
	output("With an anxious moan, you tilt your head back and tense your body as seed begins to trek across the expansive tract of land between your crotch and your cockhead, and the second goblin promptly scrambles over, leaving you to prop yourself up as you wiggle about and clench your jaw in anticipation. The goblin duo position themselves against your manhood and open wide as the first glob of semen slams against them with enough force to bulge both of their cheeks with the stuff. They quickly heft their bosoms under them, catching any errant seed in their vast canyons of cleavage. This continues, the volume of cum increasing with every pulse until both goblins might as well have dumped four gallons of white paint onto themselves. With a final, intense blast, you fall backwards, chest heaving while the aftermath of the climax hits you. While you lay there, occasional drops of semen splattering onto your " + pc.chestDesc() + ", you manage a glance at the two to find them working together to scoop as much accumulated cum as possible into their needy fuck-holes. You zone out for around five minutes, snapping out of your daze soon after when you realize the lack of ghostly presence. You unsteadily rise to see the goblins still going at it with your semen, bellies bloated with the volume of your impressive orgasm. They stumble to their feet, making sure to move a hand under their cunts to hold in as much seed as they can while they redress—if you can even refer their get-ups as clothing. You notice their oversized breasts rapidly shrinking, deflating until they return to near-normal conditions. You manage a bit of a smile when you realize that ");
	if (flags["COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT"] <= 4) output("they have kept at least a cup size of flesh from their experience");
	else output("their breasts seem to have reached their crescendo, keeping the same (admittedly incredibly stacked) measurements");
	output(", which they happily fondle as they wander away, side-by-side. Moving to your [pc.gear] and redressing, you shake your head, wondering, not for the first time, if such a large appendage is truly beneficial to you, and wondering if this was the last you've seen of your two new goblin friends.\n\n");
	output("A strange sensation begins in your midsection, and you press a hand against the flesh curiously. You remove it swiftly as a familiar head suddenly pushes out, wiggling about until it faces you. She smiles, then draws her arms out of her torso and uses them as leverage (with a whispered spell to make her hands tangible) to remove herself from you completely. Muttering an incantation and solidifying her again-unremarkable form, she winks at you and gathers her tunic, slipping it over her frame. As you watch, she slips her thumb and forefinger into her satisfied snatch, producing a healthy helping of a spooky gooey substance. Reaching into a pocket inside her tunic, she draws out a small bottle, which she promptly squishes the ectoplasm into. She offers you the bottle, explaining, \"<i>The product of a... ghost climax, if you will. Keep it, it's good for you.</i>\"  With a happy goodbye, she wanders into an alley, grabbing her ruined leggings and discarded shoes as she goes, and disappears into the shadows. You move to leave, but find your " + pc.legs() + " growing heavy, fatigue washing over you in the aftermath of the possession. Before you know it, you're on your knees, and you have to struggle to keep your eyelids from drooping. You succumb to the exhaustion, slumping to the ground and soon snoring contentedly.");
	
	IncrementFlag("COC.SHOULDRA_USES_YOUR_GIANT_COCK_COUNT");
	//dynStats("lib", 1, "sen", 1);
	pc.slowStatGain("l", 1);
	
	processTime(65 + rand(15));
	pc.orgasm();
	if (inCombat()) {
		itemScreen = CombatManager.genericLoss;
		lootScreen = CombatManager.genericLoss;
		useItemFunction = CombatManager.genericLoss;
		itemCollect([new CoCEctoplasm()]);
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}
//Genderless Scene
private function genderlessShouldrasLossRapes():void {
	shouldraSprite(true)
	output("Excited to find out what manner of host you are, the ghost-girl swiftly assumes complete control of your body and cups a hand against your crotch to feel... nothing. Confused, she quickly wriggles out of your [pc.gear] and goes in for another grope, feeling nothing but skin. \"<i>Son of a... please don't tell me you don't have any sexual bits I can play with!</i>\" she huffs, and you chuckle sheepishly, not knowing what to tell her. She groans unhappily and falls back onto your " + pc.buttDescript() + ", muttering a string of curse words under your breath. \"<i>That's it!</i>\" she fumes. \"<i>I'm going to get off, whether you want me to or not!</i>\" She resumes cursing and wiggling your hips for a bit longer, then stops suddenly, a smirk playing across your face. \"<i>Whether you want me to or not...</i>\"\n\n");
	
	output("She hops up and makes for the decrepit hut you first saw her in.  ");
	if (flags["COC.SHOULDRA_GENDERLESS_FUCK_COUNT"] == undefined) output("You raise an eyebrow, genuinely curious as to how she'll figure out how to relieve her desire.  ");
	output("Darting inside, the ghost girl heads unerringly towards a warped and half-rotted dresser. After searching several drawers filled with various knick-knacks and trinkets, the spirit squeaks in excitement as she produces a seemingly regular egg carton. She moves to the other side of her room and opens a curiously well-made chest, setting the carton on a nightstand as she goes.  ");
	if (flags["COC.SHOULDRA_GENDERLESS_FUCK_COUNT"] == undefined) output("Curious as to its contents, you glance inside- it's a chest of dildos, of every shape and size. Before you can ask why the hell a ghost would carry a CHEST of dildos, ", false);
	else output("You recall distinctly the contents of that chest, and are not surprised ");
	output("when she reaches in and rummages about, producing two eight-inch vibrators with bumpy demon-shafts. She moves back to the center of the room, launching into a short spell as she goes. She sets the dildos on the same nightstand and opens the carton, pulling out four large white eggs.\n\n");
	
	var dildo:CockClass = new CockClass();
	dildo.cLengthRaw = 13;
	dildo.cType = GLOBAL.TYPE_EQUINE;
	dildo.cockFlags = [GLOBAL.FLAG_BLUNT, GLOBAL.FLAG_FLARED];
	
	output("You marvel at how resourceful the ghost-girl is, then pause and consider the ramifications of the eggs. Your suspicions are confirmed as ");
	if (pc.biggestTitSize() < 1) output("two new additions bud on your chest.");
	else if (pc.biggestTitSize() <= 8) output("your " + pc.allBreastsDescript() + " begin to bounce all around.");
	else output("your " + pc.allBreastsDescript() + " swells slightly to make room for a sudden increase in milk production.");
	output("  As the ghost continues darting around the room, ");
	if (pc.biggestTitSize() <= 8) output("your new EE-cup breasts settle");
	else output("the lactation continues");
	output(", and the ghost girl moves back to the table and settles down a bit. Satisfied with the changes, she wastes no time on tapping the eggs against the table, cracking them cleanly. Your arm freezes up momentarily as she tips the half-shell towards your similarly conflicted mouth, but she wins out quickly, forces your jaw open, and drops the contents inside. She swallows the tasty contents easily, then slides her hands to your chest and lifts your huge tits in anticipation. Your nipples swell up and out, lengthening and stiffening as the first three eggs are consumed. The last one, however, produces a completely different reaction on your body; a comfortable warm tingle begins, deep in the center of your oversized breasts, migrating up steadily to your nipples. With a satisfied groan, the ghost-girl circles the tingling teats with a teasing finger as the change continues. Finally, she sinks a finger into each of the suddenly yielding nipples, shivering in pleasure from the penetration. Wasting no more time, she snatches up her two dildos and shoves them into your ");
	//[if new]
	if (!pc.hasFuckableNipples()) output("new ");
	else output("even larger ");
	output("nipplecunts, flicking them on as the bumpy demon-dildos penetrate your virgin tits. The ensuing vibration sends little waves up and down your boobs as they jostle about, and the ghost-girl gives a strangled yelp of pleasure. Drunk with the sensation, she staggers about, mewling and gurgling in the pleasure of having your nubs violated. Her foot gets snagged on a bedpost and she flops onto the ground, chest first, the bumpy sextoys pushing slightly further into your tits. She slams your pelvis onto the floor several times in a futile attempt to further her joy, then flops to the side, eyes finally falling upon the still-open chest of dildos. She slowly drags herself to it (mashing your bosom against the ground and inciting a few happy grunts), reaching in and grabbing up a 13-inch floppy horsecock replica.");
	if (pc.analCapacity() < dildo.effectiveVolume()) output(" Your irises shift halfway between the yellow pallor of your possessor and your natural palette as your eyes widen in horror. She couldn't possibly...");
	output("\n\n");
	
	output("She smacks it ");
	if (pc.isNaga()) output("against your naga-crotch");
	else if (pc.isGoo()) output("into your cushiony goo");
	else output("between your legs");
	output(", seemingly forgetting about your lack of genitalia, and grudgingly goes for the next penetrable orifice; your " + pc.assholeDescript() + ". With blatant disregard for safety, the vibrators still buzzing happily in your increasingly warm nipples, she slams the horsecock against the ground, waits for the wiggling to somewhat cease, then lines your butt up with the flared tip.");
	if (pc.analCapacity() < dildo.effectiveVolume()) output(" Her crazed laughter mingles with your horrified scream as she sits on it, driving it at least four inches inside in its initial penetration");
	else output(" With crazed laughter she sits on it, driving it at least four inches inside in its initial penetration");
	//[if anus is not gaping]
	if (pc.ass.looseness() <= 4) output(" and stretching your butt obscenely");
	output(".", false);
	pc.buttChange(dildo.effectiveVolume(), true, true, false);
	output("  Babbling like a crazed addict, her mind clouding increasingly by the triple penetration, she hops up and down, driving the dildo further into your anus with every bounce. Finally, with eight inches of horsey wang shoved into your butt, and vibrating demon-dicks never ceasing their barrage of pleasure on your tits, the ghost-girl climaxes in a big way. She reaches up and roughly pulls the vibrators out of your nipplecunts, stroking them vigorously as they spurt a mixture of transparent spunk and thick white milk, two mini-fountains of orgasmic pleasure. After some time on the ground, taking deep breaths that jostle your boobs against each other, the ghost girl finally reaches down and extricates the equine dong from your pucker, tossing it to the side with a contented sigh. \"<i>What did I tell you?</i>\" she asks softly. \"<i>Any means necessary.</i>\"\n\n");

	output("You chuckle to yourself, admittedly impressed by her prowess. A pressure lifts from your chest, and you absently raise a hand to find ");
	if (pc.biggestTitSize() < 1) output("your tits, along with the elongated nipples, receding back into a flat chest");
	else if (pc.biggestTitSize() <= 8) output("your boobflesh shrinking back down into its normal size, nipples included");
	else output("the nipples shortening once again, and the lactation finally stabilizing");
	output(".  With a happy sigh, you heave yourself upright, slipping back into your [pc.gear] and moving out into the ruins once more.\n\n");
	output("A strange sensation begins in your midsection, and you press a hand against the flesh curiously. You remove it swiftly as a familiar head suddenly pushes out, wiggling about until it faces you. She smiles, then draws her arms out of her torso and uses them as leverage (with a whispered spell to make her hands tangible) to remove herself from you completely. Muttering an incantation and solidifying her again-unremarkable form, she winks at you and gathers her tunic, slipping it over her frame. As you watch, she slips her thumb and forefinger into her satisfied snatch, producing a healthy helping of a spooky gooey substance. Reaching into a pocket inside her tunic, she draws out a small bottle, which she promptly squishes the ectoplasm into. She offers you the bottle, explaining, \"<i>The product of a... ghost climax, if you will. Keep it, it's good for you.</i>\"  With a happy goodbye, she wanders into an alley, grabbing her ruined leggings and discarded shoes as she goes, and disappears into the shadows. You move to leave, but find your " + pc.legs() + " growing heavy, fatigue washing over you in the aftermath of the possession. Before you know it, you're on your knees, and you have to struggle to keep your eyelids from drooping. You succumb to the exhaustion, slumping to the ground and soon snoring contentedly.");
	output("\n\n");
	IncrementFlag("COC.SHOULDRA_GENDERLESS_FUCK_COUNT");
	
	processTime(65 + rand(15));
	pc.orgasm();
	if (inCombat()) {
		itemScreen = CombatManager.genericLoss;
		lootScreen = CombatManager.genericLoss;
		useItemFunction = CombatManager.genericLoss;
		itemCollect([new CoCEctoplasm()]);
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

//Penis With Exgartuan Scene
private function ghostGartuanLossSceneOrSomeShit():void {
	shouldraSprite(true)
	var x:Number = pc.biggestCockIndex();
	output("Your entire body shivers in delight as the ghost girl regards your excessively large " + pc.cockDescript(x) + ". She places your hand over the bulge in your [pc.gear] and titters in glee as your member twitches and hardens, just a tad. She strips eagerly, but is halted by a familiar booming voice coming from the half-erect member. \"<i>WHO THE HELL IS THIS BITCH?</i>\" a perplexed Exgartuan yells grumpily. \"<i>Living in peoples' bodies is MY THING!</i>\"\n\n");
	
	output("The shocked ghost girl nearly leaps out of your body right then and there. \"<i>O-oh... I'm so-sorry for the... uh... ah...</i>\" she stutters in your voice, the words almost refusing to form in your mouth. Telepathically, she pulses to you, \"<i>Why didn't you tell me there was... someone else here?</i>\" angrily, and you meekly apologize for the oversight. \"<i>WELL!?</i>\" Exgartuan bellows, your semi-flaccid dick twitching angrily in tandem.\n\n");
	
	output("After a moment's more of hesitation, the ghost girl sinks down to your waist, pushing her head out of your " + pc.hipDescript() + ". \"<i>I apologize, sir, but our—er, sorry, your host did not mention he was already... occupied,</i>\" she admits in her soft, feminine voice.\n\n");
	
	output("\"<i>Hold up,</i>\" the demon requests, suddenly far less boisterous. \"<i>You're sayin' you're a chick, right?  And not some chick with a dick");
	if (pc.isHerm()) output("like this bitch here");
	output("?</i>\"\n\n");
	
	output("A blush (somehow) coming over her " + pc.skinTone + " cheeks, the ghost girl nods her head meekly. She obviously doesn't know what to expect from the volatile creature. She suddenly gives a little cry, and her head is sucked back into your body. You can vaguely feel her presence shift, and then, as if pulled, moving...into your penis?  You place a hand—and now that the ghost girl is preoccupied, you feel full control returning to you—under your prodigious pecker and hoist it slightly. You jump as the thing bucks in your grasp. \"<i>ALRIGHT, BITCH, LET'S GET TO SPIRIT SEX,</i>\" Exgartuan exclaims, and to your surprise, your spiritual newcomer groans expectantly.\n\n");
	
	output("\"<i>But you're soooo big,</i>\" she teases huskily, and your mind is suddenly filled with the mental image of the girl and the demon. They're located in a large, fleshy tunnel... you can easily guess what that signifies. You see what only can be Exgartuan in a vaguely humanoid (and obviously naked) shape, red wisps floating off of and around him. His enormous maleness is bared and twitching, dragging across the spongy ground. The ghost girl is as you remember her; however, she has thrown her tunic to the side and pulled her leggings down to her knees. The aroused apparition is kneeling on all fours in front of the endowed demon, swaying her squeezable hips softly as she looks lustily over her shoulder to her intangible lover. Taking control of your distraction, Exgartuan's influence surges into your frame, and you're finding yourself thrown farther into the mental image as he takes over. Your hands move to your dick, the mirror of his own, and he lifts the unit up onto the ghost girl's back; this causes a strange sight of your own manhood hovering in the air, and you can't get enough control back to fix the oddity. She shudders, the weight stimulating her and eliciting a few aroused squeaks.\n\n");
	
	output("Exgartuan slowly drags his mast back (and your own body mirrors the movement), and the ghost girl veritably vibrates with pent-up excitement as the cockflesh slides down her bared skin. Finally, the demon reaches her dripping Mons, and pokes her lips tantalizingly with his head, lubricating her further with little bubbles of pre-cum. Impatient, she throws herself backwards onto the massive thing, but Exgartuan ");
	if (flags["COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT"] > 0) output("once again ");
	output("deviously shifts his hips upward at the last moment. Instead of the expected vaginal penetration, the ghost girl is treated to an excess of demon girth jammed into her anus. You wince at the perceived discomfort, but are surprised when she moans ecstatically; you're even more surprised when you feel a near-vice-like tightness seal around your own shaft. Her hips widen to accommodate the insertion, and the beginnings of a paunch appear on her flat belly. The ghost girl writhes in bliss, and her moans only intensify when Exgartuan demands, \"<i>FACE DOWN, ASS UP.</i>\"  She complies, squishing her firm tits against the fleshy floor and jutting her lower body upward. The demon widens his stance, then gives an almighty hip thrust—and, of course, you feel outright silly as you perform the movement. You silently thank Marae that no one is around to watch you... or, at least, no one that you can see. He buries his oversized cock into the eager ghost girl, sinking in no less than eight inches, much to her delight. You stifle a groan as you feel the tight tunnel sliding up your member as well, and you'd surely fall if not for Exgartuan's control over you.\n\n");
	
	output("The specter's belly balloons forward as the giant genitals continue their journey, nearly unfettered by any semblance of human anatomy. A nonsensical stream of words flow out of her mouth as she bathes in the 'spirit sex.'  Your dick begins a steady drip of pre, the fluid splashing against the pavement as your body mirrors the lewd pelvic movements of your demonic accomplice. You feel her body, impaled up to her chest with your " + pc.cockDescript(x) + ", tighten further around the flesh as the demonic pre pulses into her over-stretched stomach. Her hands fly to her midsection as it steadily pulses further and further out. The spirit finally bottoms out with Exgartuan's glans lodging where her rib cage would be. Realizing the penetration will go no farther, the phantom winds her arms up and spins herself around; your eyes nearly cross as the twist transfers to your pole. The ghost girl attempts to locate the demon, but her belly has grown beyond her field of vision. That goal failed, she squeezes her thighs and rubs her ankles against the trembling flesh. Neither you nor Exgartuan are surprised when her applications succeed in a big way. The base of your—and his—dick bulges with the first pulse of seed. Your cum-tunnel swells to make room for the eruptions soon to come.\n\n");
	
	output("The ghost girl screams her pleasure as the first rope of cum squeezes its way into her abused pucker. Your body locks in Exgartuan's climatic pose; hands pumping your semen along, pelvis shaking to and fro in anticipation. The over-sensitized woman's cries rise in tempo with each blast of cum spilling into her, the demon treating her like a living condom. He pumps her up larger and larger, the otherworldly orgasm keeping up for what seems to you like hours. Unable to even shift your posture, you stand there cringing as at least a gallon of seed pours onto the cracked road. Like a broken water main, the sticky substance flows freely from your towering maleness. Finally, after at least a minute and a half of orgasm, your 'fire hose' slows to a stream, then a trickle. Satisfied, Exgartuan releases control of you, and you collapse backwards into a deep puddle of baby-batter. Of course, you hardly notice, too focused on the rotund ghost girl wriggling weakly on the fleshy floor under her. Her gut resembles a huge, sloshy blimp, and you feel your tongue flashing across your lips like a curious snake as Exgartuan regards her.\n\n");
	
	output("Plugged as she still is on the demon's slowly softening dick, she can't even get her feet under her to rise. Unfazed, the girl giggles helplessly as she waits for Exgartuan to release her from his phallic grasp. The demon does her one better; he not only tugs his maleness out of her now-gaping ass, but he even stalks over to her after the removal and gives her a 'helping hand'. He reaches up, pressing his hands against the ghost girl's burgeoning belly and pushes downward. She begins to accost him for his rough treatment, but the words quickly fade to a gurgling shriek as cum bubbles from her throat and leak out the corners of her mouth. Meanwhile, seed spews from her anus at a breakneck pace- the poor girl's eyes roll up towards the opposite wall as she's drained of the cum.\n\n");
	
	output("When the proverbial dust settles, you stir groggily. Blinking the sleep out of your eyes, you do a double take at the sheer amount of semen flooding the street. You feel a sensation building in your finally flaccid member, and you glance down. A pale, transparent smoke flows gently from your urethra, reforming into a very tired, moderately sore, but incredibly satisfied ghost girl.  ");
	if (flags["COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT"] == undefined) output("\"<i>Spirit sex... I can't say I've ever tried that,</i>\" she admits. \"<i>Damn if it isn't good.</i>\"");
	else output("\"<i>Damn,</i>\" she sighs, \"<i>that is still a great ride, I'd say...</i>\"");
	output("\n\n");
	
	output("\"<i>THEY DON'T CALL ME 'THE DEVIL OF DICKINGS' FOR NOTHIN',</i>\" your dick-demon pipes in. The two of you share a laugh, and with a friendly wave, the spirit turns away. She sloshes through the layer of seed coating the ground, and you can't help but notice a little white fluid drip from her bare buttocks. The droplet causes a small wave to disperse through the jizz. You shake your head with a smile creeping across your cheeks. Spirit sex... what a ridiculous thing.");
	IncrementFlag("COC.SHOULDRA_EXGARTUAN_SPIRIT_SEX_COUNT");
	pc.orgasm();
	//dynStats("sen", 1);
	output("\n\n");
	processTime(35 + rand(5));
	CombatManager.genericLoss();
}

//[super secret paladin 'sex' scene; prerequisites: human face, human body, human legs, no tail, no horns, light/olive/dark/ebony complexion, slightly to severely masculine face, 0-15 corruption, 4-10 inch normal penis, 1-2 inch testicles, no-adjective to narrow hips, height between 5'5</i>\" and 6'5</i>\"]  
private function superCoolPaladinSexStuffDudeGasmJizzMonkies():void {
	shouldraSprite();
	clearOutput();
	
	output("While gallantly striding through the wreckage of the town, you sense danger, and pause mid-stride. You strain your valiant ears for any out-of-place sounds, and your heroic eyes widen as you hear a shuffling from one of the heretical half-destroyed huts. Cursing your wise self for getting caught off-guard in such an unlawful place as this, you [pc.readyWeapon] and wait. Another unsanctimonious sound issues forth, and you tense yourself. You are caught very slightly off-guard when a completely human leg steps out of the doorway. A virtuous maiden soon stands before you, eyeing you up curiously. After taking a breath to steady yourself, you inquire upon how such an untainted woman would find herself in a place such as this. Instead of the very reasonable response of being cowed by your almighty presence, the girl laughs softly, arching an eyebrow at your behavior. You narrow your eyes angrily at such a slight to your devout mannerisms and demand an apology. \"<i>Ah, I'm very sorry,</i>\" she replies, only a hint of humor to her admittedly lovely voice, \"<i>I was not expecting such a... remarkable man, such as yourself, to wander by. What business have you here?</i>\"\n\n");
	
	output("While she speaks, you cannot help but notice how pure her body is in appearance; her loose-fitting tunic flows very modestly down to her thighs, preserving her frame from the lecherous eyes of any devious creatures that may be lurking about. Her leather leggings, while form-fitting, are done so in a stylish and innocent way, and you take little offense. You inform her of your ecclesiastical quest to rid the world of all taint, and she nods with what you assume to be admiration. On impulse, you take the hand of the lady before you and raise it to your lips, then inquire on her marital status. It takes her a moment to get over the shock of such a blunt question, but she composes herself quite quickly. \"<i>I am quite single,</i>\" she assures you, a smirk beginning to play across her face. \"<i>Is this a remarkably subtle attempt to court me?</i>\"\n\n");
	
	output("You look up to gaze into her moderately attractive face. Is it?");
	IncrementFlag("COC.SHOULDRA_SILLY_ENCOUNTER");
	processTime(5);
	clearMenu();
	addButton(0, "Yes", courtCrazyGirlsDotCom);
	addButton(1, "No", noCourtingYouFag);
}

//(no)
private function noCourtingYouFag():void {
	shouldraSprite();
	clearOutput();
	output("You quickly tell her that there's been a misunderstanding; surely your order would not allow such a relationship. She nods, not seeming very bothered by the dismissal. \"<i>What a shame. Farewell, then, paladin friend,</i>\" she says, turning back towards her shack. \"<i>Perhaps we will meet again.</i>\"  You're left to watch her go, and you soon depart as well.");
	processTime(2);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//(yup)
private function courtCrazyGirlsDotCom():void {
	shouldraSprite();
	clearOutput();
	output("Her smile widens as she regards your venerable visage. \"<i>Is that so?</i>\" she says softly. \"<i>Interesting. I'll be back in a moment.</i>\" She returns to her \"<i>house,</i>\" rummaging around for some time before returning to you, hands hidden behind her. \"<i>If I am to be sought by a paladin, we must do things right,</i>\" she explains, handing you a small silk handkerchief. The white fabric slides around your fingers like a sacrosanct flow of holy water, and you reverently tuck her gift into your [pc.gear], laying it over your heart. \"<i>Come back in two days' time, please,</i>\" she asks softly. Your eyes meet for a long moment, and it appears as if she's struggling to say something. She instead breaks away and starts back towards her shelter. \"<i>Be safe,</i>\" she advises, and with a smile and a wave, she's gone. For moments you stand silently, then you turn and start away with long, saintly strides. There's more work to do.\n\n");
	flags["COC.SHOULDRA_SILLY_ENCOUNTER_FOLLOWUP_TIMER"] = timeAsStamp + 2 * 24 * 60;
	processTime(3);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//(two days later)
public function paladinModeFollowup():void {
	shouldraSprite(true)
	output("You feel a very slight bit anxious after two days away from the innocent maiden that you have professed your interest in. Your wanderings lead you to the spot where you first met, and sure enough, you hear a sound from a nearby dilapidated building. The completely human girl is soon standing in front of you once again, and you exchange smiles. \"<i>How's life been treating you?</i>\" she asks politely, intending to spark a conversation. You take a short while describing your continuing quest to slay all corruption that stands before you, and she hangs on every word, nodding every once and a while to show she's paying attention. The conversation inexorably shifts to your budding relationship, and a gleam begins in her completely normal brown eye. \"<i>Why don't you and I continue this chat away from prying eyes?</i>\" she suggests, grabbing you by the wrist with a surprisingly strong hand and leading you into her abode.  You duck under the warped entryway and step into the shack. Surprised, you take in the spartan-like furnishings and the lack of clutter in the room; it's as if she was raised by monks!\n\n");
	
	output("The woman notices your admiration and graces you with a radiant smile. Unable to contain your attraction to her, you move to her and place a hand on each of her delicate shoulders. You confess your undying love to her, and despite your darkening cheeks, you push forward and beg her to perform consensual missionary copulation for the sole purpose of procreation. Her eyes widen and she again seems to want to tell you something, but she seems unable to. \"<i>Foolish boy,</i>\" she mutters to you, \"<i>demanding such raunchy and inappropriate fetishes to someone you've just barely met.</i>\" You avert your gaze in embarrassment and begin to move away. A tap on your shoulder brings your head back around just in time to catch a kiss from the flattered woman. She breaks away from you, a small glistening trail of saliva connecting your lips. \"<i>Foolish boy,</i>\" she breathes huskily, pulling you forward onto the neatly-made bed in the corner of her room. Her first action, before you can even think to point it out, is to light the candles on her nightstand. Truly, no pure coupling can take place without lights on! The attractive girl pulls open a slightly rotted drawer, reaching in and producing a weathered manual. \"<i>I bought this from a mysterious traveling merchant,</i>\" she explains, plopping her modest, toned butt onto the bed. \"<i>It explains how to pleasure a woman.</i>\"\n\n");
	
	output("You begin to ask why she would own such a thing, but she silences you with an outstretched hand. Her open palm turns into a gesture to sit next to her, and you comply, confused. \"<i>To please a woman,</i>\" she begins in an exaggeratedly articulate way, \"<i>you must first let her know you want her-...</i>\" She's cut off as you gently lay a hand on her breast, the words dying in her throat. She tosses the manual aside, and happily begins teasing your uncorrupted manhood. You've had enough of the foreplay; your hallowed staff requires attention. Her smile widens as you tug your [pc.gear] off and lay the garment at the foot of the bed, and she follows suit. The two of you slide onto the bed, her assuming the position under you. With a last lingering gaze into her eyes, you insert your sacred manhood into her waiting vagina. You then proceed to have consensual sex in the missionary position for the sole purpose of procreation... however, you can't help but notice how bored she looks. You give her an extra-hard thrust, and she jumps slightly, as if coming out of a daydream. Her moans, while still sounding oddly lackluster, propel you enough to bring you to orgasm, depositing your seed into her womb in a completely vague but assuredly sexy way. After a few minutes of hugs and cuddles, you both redress, and you announce your need to depart. She nods in understanding, and she follows you to the road as you exit her home. \"<i>Oh, by the way,</i>\" she calls, turning you around curiously. \"<i>You totally just fucked a ghost.</i>\"\n\n");
	
	output("Her eyes light up, the brown orbs becoming two unholy amber flames as she laughs at your completely stunned expression. With a devilish wink and a proclamation of, \"<i>I'm going ghost!</i>\" she fades into intangibility and is swept away by a gust of wind. As you track her wispy path, you set your jaw determinedly. Looks like \"<i>undead</i>\" will be back on your \"<i>vindictive eradication</i>\" list... though, you have to admit, she gave pretty good consensual sex in the missionary position for the sole purpose of procreation. For an abomination.");
	if (hours < 6 || hours >= 23) output("\n\nYou rage fap and consider going back to bed.");
	pc.orgasm();
	flags["COC.SHOULDRA_SILLY_ENCOUNTER_FOLLOWUP_TIMER"] = undefined;
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}


//Vagina with Boobgartuan Scene
//[vagina selection with BoobGartuan in tow] 
private function ginaBoobgartuanShouldra():void {
	shouldraSprite(true)
	clearOutput();
	output("\"<i>Ah,</i>\" she sighs while settling into your form, \"<i>only ladyparts... well... ugh.</i>\"  You can sense her disappointment, and regardless of the ridiculousness of the situation, you feel cheering her up would be helpful. On sudden inspiration, you begin to tickle and tease your " + pc.allBreastsDescript() + ".  Before long, the ghost girl's protests change to grunts of satisfaction.  \"<i>Those are... nice,</i>\" she admits, and with her pleasure in mind, you knead the torpedoes more forcibly, eliciting a small gasp from her.  What you didn't have in mind, however, was the occupant of the oversized orbs you're handling.  With a boobquake that actually forces your hands away, the archdemon Exgartuan surges to alertness.");
	output("\n\n\"<i>RIGHT, THEN, WHAT THE FUCK IS THIS!?</i>\"  Several moments pass before you realize your demonic knockers are referring to your temporary \"roommate.\"    Before you can begin to explain, the spirit moves her essence up into your shoulder, her head pushing out of the skin to get a better look at your moving, talking " + pc.allBreastsDescript() + ".");
	output("\n\n\"<i>Who the fuck is THIS?</i?\" she retorts, her sharp tone making you wince.  \"<i>And why are you in this gal's boobs?  Oh, and-</i>\"  She's cut short, her face contorting into a mask of discomfort.  The specter's head begins bobbing, as if she something were tugging her foot.  With a small yelp, she disappears completely, pulled back into your body, and... into your breasts?  Indeed, you can actually feel the spirit moving into the " + pc.biggestBreastDescript() + ", and you can't help but shudder at the sensation.  As you're moving a hand curiously to your endowments, a voice -- it has to be the ghost girl's -- rings out.  \"<i>Oh nooo!  I've been caught!</i>\" she wails, but despite the words, you detect nearly cloying overtones of arousal.  While you're pondering her change of heart, you suddenly fall into a dream-like trance.  When your vision clears, you're struck with a vision of two figures in a huge chamber. The walls, you notice, have a suspiciously fleshy texture.");
	output("\n\nCombined with the semi-spherical shape of the room, you can easily surmise where the \"dream\" is located.  The two figures shift, and your view is brought closer in.  Your eyes immediately lock on what can only be Exgartuan, and you can't help but stare at her personification.  The demon's " + pc.allBreastsDescript() + " glisten, illuminated by the fel fire simmering in her eyes.  Unconsciously, your eyes begin moving south, taking in her impossibly narrow waist and the comparatively enormous pair of hips.  The exquisitely proportioned woman approaches the kneeling ghost girl, the sway of her lower body holding both you and the spirit in a mild trance.");
	output("\n\nBefore either of you can react, Exgartuan has closed the distance.  The demon deliberately runs a finger under the ghost's chin, propping her head up gently.  As if bogged down by the sheer amount of lust, she slowly blinks and parts her lips, trying to speak to the demoness.  As soon as her mouth opens, however, it's filled with Exgartuan's " + pc.nippleDescript(0) + ", eyes widening shortly before dipping out of sight as your corrupted copycat presses her huge breast into the wraith's face.  Her freckled features are completely buried in a sea of flesh.  With no alternatives presented, the ghost simply begins suckling passionately on the nub, groaning happily into the wall of breast threatening to engulf her.");
	output("\n\nThe nursing instantly transfers to your own bosom, and your immobile body is wracked with waves of pleasure, the likes of which you never would have imagined from a simple breast suck.  Her hands, hanging limply at her sides until now, come to life on evident sudden inspiration; one raises to tickle and squeeze Exgartuan's other, more vacant breast, while the other drops below the ghoul's legs.  The moment the ghost girl's fingers brush her sex and elicit an actual stimulation, she goes into a frenzy, sucking as hard as she possibly can on the demoness' tit. The enamored spirit gropes and shakes the other massive mammary with reckless abandon as she goes to town on her uncharacteristically responsive fuck-box.");
	output("\n\nAs good as the suckling feels, you cannot deny your arousal from the ghost girl's near-berserk reaction.  You would give anything for control of just one hand... but, of course, Exgartuan knows that, and she's calling the shots for now.  Big rivulets of pure white breast milk leak from the demoness' " + pc.nippleDescript(0) + ", pouring over the ghost girl's hand and dribbling down her chin.  Both you and Exgartuan can just feel the release coming, building and building until... boom!  A huge gout of milk pours from her teats, bulging the spirit's cheeks with the sheer amount of liquid.  She happily gulps it down, not even allowing the lactation to interrupt her masturbation.  She gulps mouthful after mouthful of the stuff, and even the mighty Exgartuan seems impressed with her capacity.  From where you're watching you can clearly see the ghost girl's stomach billow out rapidly from her wanton consumption, swiftly growing big enough to bump against Exgartuan's thighs.");
	output("\n\nThe paranormal plaything's stomach gurgles, its lactic cargo swishing and sloshing with every stroke she makes.  Her moans only intensify when the demoness pushes her over and steps on her overladen belly, forcing a little bit of milk back out to run down her cheek.  The ghost girl shudders in ecstasy at the treatment, only responding with orgasmic cries as Exgartuan continues to push her foot into the spirit's medicine ball-shaped stomach.  Evidently growing tired of that, the demoness kneels between the wraith's legs, inspecting her puffy labia curiously.  \"<i>Make it bigger,</i>\" Exgartuan commands the ghost girl, slapping the lips lightly to specify her demand.  \"<i>Big enough to fit whatever I wish to insert.</i>\"");
	output("\n\n\"<i>Of... course... ma'am,</i>\" the ghost pants, gathering some semblance of wits before beginning one of her many incantations.  The demon seems to take pleasure in the waver of her voice whenever the spirit is teased, be it a press on her belly or a flick of her quivering clit.  With an enthusiastic yelp, the ghost girl finishes her spell, going back to squeezing and rubbing every part of her she can that brings her pleasure as the spell begins to set in.  Like a budding flower, the ghost girl's vulva engorges in the arcane power, blooming into a truly enormous, pillowy expanse of sanguine nether-flesh.");
	output("\n\n\"<i>Perfect,</i>\" Exgartuan purrs in satisfaction, pinching and probing her newfound folds.  The spiritual slave's mouth flies open, tongue lolling from one side as she squirms under the demoness' teasing touch.  With only a little chuckle as a warning, Exgartuan pulls the lips as far apart as possible, baring her dark recesses and eliciting a shrill scream of surprise from the ghost girl.  Before she can even recover, the huge-breasted demon cups one of her " + pc.breastDescript(0) + "s and leans forward, slipping the " + pc.nippleDescript(0) + " and a good amount of her boob in with hardly an effort.  A grunt from the kneeling girl and a groan from the demoness is all it takes.  The ghost girl seems unable to even cry out as her already-rotund belly is pushed up to make way for Exgartuan's boob.  Completely under the influence of the corrupt boob-demon, you mimic the motion, boob compressing into thin air.  A fierce blush paints your features as this awkward scene plays out; you can only hope no one's spying on you.");
	output("\n\nGood thing she's a ghost, you figure as you watch the girl's poor stomach grow to absolutely ridiculous size.  Even with the enhanced box, the pressure of her walls pressing down against Exgartuan's breasts - and yours by extension, you lament while watching the stream of milk splatter against the ground - sends a hearty spray of lactate into the ghost girl's depths.  Cackling devlishly, the demoness takes a hold of the too-big tummy, pressing into it and forcing a gargle from the stuffed specter.");
	output("\n\nThe ghost girl tries her hardest to grab her big belly, but she can't even reach all the way around... she can hardly reach halfway!  Exgartuan, cackling excitedly, draws her boob halfway back before leaning back in, squishing the boobflesh against the wraith's loins and guiding it back inside.  The bizarre boobsex starts off slow, then gains speed as lubrication from the ghost girl's plentiful fluids and Exgartuan's own lactate builds.");
	output("\n\nA duet of beautiful screams echoes around the huge fleshy chamber as the girls fall into rhythm, the ghost girl's heavy lurching complementing the encumbered-yet-lithe manipulations of the demon.  Soon, both girls are panting heavily, Exgartuan squeezing and stroking her other unattended breast.  With the gusto of one rapidly approaching climax, Exgartuan rams with all of your strength into the ghost girl's depths instants before her 'floodgates' open.");
	output("\n\nWhat used to be an exercise ball swiftly grows to even more exaggerated proportions as the combined milk load of her belly and womb swish against each other.  The prone spirit coughs once, then passes out with a content hum.  Exgartuan withdraws from the slowly-shrinking vagina with a little pop, rising to her feet with a smooth movement and dropping a hand between her legs.  It's only then, when you feel the sheer amount of fluid soaking your thighs (as you're forced to mimic Exgartuan's movements, of course), do you realize; you just came from lactation alone!");			   
	output("\n\nShe chuckles once, then snaps her fingers, throwing your perception back to reality.  You find yourself in the same flamboyant pose as the one Exgartuan left off in, which you hastily adjust.  A little rumbling and a numb sensation begins in your abdomen; the ghost girl tumbles out, snoring blissfully.  Luckily for you and the integrity of your midsection, her belly's back to its taut normality, but that doesn't stop her from rubbing her midsection and occasionally groaning.");
	output("\n\nThough exhausted and a little sore from Exgartuan's treatment of your body, you keep the presence of mind to lean down -- pushing your " + pc.breastDescript(0) + " out of the way -- and scoop up a little ectoplasm from her still-gaping box.  You make a point to ignore Exgartuan's triumphant chortle as you leave the ghost girl to her sleep and walk back to camp.  What a day.");
	output("\n\n");
	processTime(35 + rand(5));
	pc.orgasm();
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}

/*Slime x Ghost Girl - Herm Edition
Requirements:
Encountered both cock and vagina slime possession scenes at least once (need tracking variable added to Ghost Girl x Slime vagina slime inflation scene slimeGinaFlation())
PC has at least one cock and vagina
Scene is selectable along with original two*/
private function slimeGhostGalForHerms(clearOut:Boolean = false):void {
	if (clearOut) clearOutput();
	output("Your naked trot towards the emerald ooze stops as worry washes over your sexual cravings.  The contemplative expression forming on your face catches the attention of your ghostly friend.  \"<i>I know exactly what you're mulling over, but don't worry,</i>\" she assures you with a condescending chuckle.  The haunted blob slowly approaches you, seamlessly transitioning from its shapeless form to a perfect representation of the apparition mid-stride.  \"<i>");
	//{event occurrence == 0}
	if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] == 0) output("I've got this thing all figured out.");
	//event occurrence =1
	else if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] == 1) output("I've got this thing all figured out.  For real this time.");
	//event occurrence >=2
	else if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] == 2) output("I've got this thing all figured out.  For real this time.  Promise.");
	//event occurrence >=3
	else output("Well... don't worry TOO much.");
	output("</i>\"");
	output("\n\nHer confidence was never an issue any of the previous times the two of you did the slimy shuffle.  There doesn't seem to be even the slightest hint of distortion to her speech.  Her form certainly appears much more impressive than you remember her being capable of.  The possessed pudge is more solid than any goo girl you've ever come across.  It even has slight dimples in place of where the ghost girl would otherwise feature her freckles.  ");
	//event occurrence == 0
	if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] <= 2)output("Maybe she really does have a firm grip on the reigns of this beast.");
	//event occurrence >=3
	else output("Regardless, you've been through this dog and pony show enough times to know that something is bound to go wrong anyway.");
	output("\n\nA moist hand on your shoulder belays your skepticism.  A mischievous grin dissolves your apprehension.  A rather large mitt cupping your crotch reinforces your ardor.  \"<i>You didn't take me to the lake just so we could frolic in the water, right?</i>\"  The not-so-subtle arsenal of hints have breached the last of your defenses, forcing your surrender.  Accepting your unspoken peace treaty, the ghost girl breaks into her indecipherable tongue of wizardry.  Despite every syllable slipping past your comprehension, a tinge of familiarity is laced through them.  The tingling in your still-cupped crotch confirms your suspicions.  Your [pc.cock] has widened substantially.  You try and respond with a patronizing smirk, but the supposedly uninventive spector isn't through.  \"<i>I had to refamiliarize myself with some of my favorite work,</i>\" she says while waving her amorphous extremity away from your groin and towards her own.  \"<i>How else would I perfect the set?</i>\"");
	
	output("\n\nThe blob reforms to her otherwise unremarkable hand - disregarding the emerald tone - revealing a perfect replica of your manhood on her midsection.  ");
	//if cockLength(0) > 24
	if (pc.cocks[0].cLength() > 24) output("However... it isn't exactly up to your immense scale.  ");
	output("Other than the sparkling green complexion, her [pc.cock] matches your every facet, right down to even the [pc.vagina] resting snugly above it... Wait.  Your perplexity over the flipped genitalia is met with a promiscuous amber glare.  \"<i>Use your imagination,</i>\" the apparition insists as she lowers the two of you to your knees.");
	output("\n\nThe haunted slime parts your legs as she moves in closer to embrace you.  You're no less surprised by her silken touch; it's still slightly moist and a tad chill, but she's about as impermeable as most any other non-goo related species around here.  No, what does surprise you is when her rod impales your love canal.  Owing to intuitive foresight, your little adventurer also makes its trip down your lover's lane, completing the circuit of lust between the two of you.  The ghostly goo girl shoves her [pc.cock] hard into you, her initiative almost bowling you over had you not been sitting the way you are.  Satisfied moans slip from her mouth as she slows down and eases up on you, her damp body mashing up against yours as if she were lifting you on a swing.  You catch on quick, pushing your partner back as you lean into her [pc.vagina].  Thanks to your prick's \"higher ground\" over your opponent's, leverage is easily on your side in this duel.");
	
	output("\n\nThe war of seesaw sex rages on, each of you driving your girth-enhanced weapons further and further into the other's ");
	//vaginalLooseness == 0
	if (pc.looseness() == 1) output("tight");
	//vaginalLooseness == 1
	else if (pc.looseness() == 2) output("forgiving");
	else if (pc.looseness() == 3) output("loose");
	else if (pc.looseness() == 4) output("gaping");
	else output("cavernous");
	output(", velvety scabbard.  Hands too busy latched onto one another's hips, ");
	if (pc.biggestTitSize() > 0) output("both you and the spooky slime press your tits together, your swaying thrusts only enhancing the mammary meltdown.");
	else output("the spooky slime presses her tits hard into your flat chest, your gyrations teasing them to no end.");
	output("  The fierce battle increases in tempo; the sly leering the two of you used to try and psyche the other out is giving way to slight head-lashing and gasps through clenched teeth.");
	output("\n\nAt last, you seize victory.  The slimy spector's grip fastens to your flesh as she pumps your depths full of, well, herself; she howls to the heavens in divine satisfaction.  Your libido stands little chance at this point, falling victim to the chain reaction as your [if (cumNormal = true) trickle][if (cumMedium = true) dam][if (cumHigh = true) tidal wave][if (cumVeryHigh = true) tidal wave][if (cumExtreme = true) tidal wave] bursts forth into the goopy girl.  Winding down from your sexual high, you take a little amusement as the fruit of your loins swirls around in the dark green gel.  You also notice that your adversary's form isn't quite as impressively rigid as it was just moments ago.  She's also slumped over, head buried down in your [pc.chest] while meekly thrusting away at your crotch.  This sudden change in temperament reawakens the looming dread you pondered earlier, leading you to place your hand on her quivering shoulder.");
	output("\n\nThe moment your " + pc.skinFurScales() + " makes contact, the slimy ghost's gaze darts up to face your own.  Her eyes are inhumanely wide... and the deepest, coldest shade of black you've ever known.  Your eyes get nearly as wide as you fly to your feet, a hushed obscenity barely accompanying your breathless gasp.  You make a nervous turn towards the lake to grab your gear... failing to notice the thick cord of goop leading directly into your [pc.vagina].  With your plugged-up pussy, the mad spectral sludge easily tugs at your groin from behind you, destroying your footing and causing your chin to smack into the ground.  You slowly manage to flip onto your back, just in time to see the lumbering goop already at your feet.");
	output("\n\nStill breathless from your sexual escapades, you're left with very few options as the phantom ooze kneels down to consider your array of sexual genetalia.  The pristine form the ghost girl was so proud of has all but vanished now--save for a vague semblance of her face.  The impressive likenesses of your armaments have reduced to decommissioned duds fading away into the wet gunk.  Looks as though you were right to worry.");
	if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] > 0) output("  Again.");
	output("\n\nHowever, much to your surprise, the mire isn't boogying down on your nether regions.  Actually, it looks like she's... it's studying them?  She's also murmuring to herself in an incredibly low pitch.  It sounds like she's just repeating \"<i>cold</i>\" and \"<i>hungry</i>\" over and over.  [if (hasBalls = true) You cringe as you feel the viscous blob massage your testicles, its gaze completely fixated on them.][if (hasBalls = false) You unsuccessfully stifle a gasp as the viscous blob mindlessly prods away at your groin, focusing on the gap between your rod and reel.] Your paranormal pal certainly has succumbed to her brain-dead host... again... but there appears to be a method to her prurient madness this time around.  You only grow more anxious as the creature's murmuring picks up in volume, turning more to some sort of chanting instead of...");
	output("\n\n...The damn thing is casting another spell!  The ghost girl's voice is incredibly distorted; the recital of the incantation is moving at a snail's pace as each syllable painfully oozes out of the thing's craw.  She could be summoning a demon from the underworld for all you know, but the slime's massaging of your [pc.balls] has you thinking otherwise.  The final verse of the incantation bellows out into the air, summoning a mighty rumble deep within your midsection [if (hasBalls = true) A familiar feeling courses through your being.  Your tense muscles relax around your groin.  It feels as if the boundaries of your skin have... oh no.][if (hasBalls = false) \"Something begins forcing its way out from underneath your [pc.cock].  You want to try and squirm at the pain, but it's only a fleeting fantasy under the strong confines of your slimy aggressor.  The fleshy growth bursts out from you, gently brushing up against your [pc.clit] you may not be able to see them, but it's abundantly clear that you've grown a pair of testicles right between your pride and joy.  The thrill ride doesn't end there, however; tingling sensations course through your skin, your tense muscles slowly easing up.  You feel as if you could stret--oh crap.\"]");
	output("\n\nThat recognizable sensation is alarmingly similar to a previous occasion when your every orifice was primed full of ghostly goo.  A frightening realization dawns on you: could... could your slimey participant be the same contestant in every one of your spectral misadventures?  The deranged ghost girl certainly seems to have an objective in mind this time around, and her telltale signs of struggle have yet to make an appearance.  Your chilling discovery rockets to realms unknown with a piercing yelp; the spooky sludge has suddenly cranked it to eleven, pumping itself into every hole it can find below your waistline.  Her preparatory hocus-pocus means that your physique can unfortunately withstand whatever the slick apparition can dish out.");
	output("\n\nAnd dish out she does with gusto; your pliable exterior doesn't make the torrent of torment any less excruciating, though.  The grass gets slick with your sweat, your body sliding with each powerful thrust down your dick, against your ass, and straight through your snatch.  Your womb looks to be puffing up, but the flood of sludge seems to only be using it as a rest stop to somewhere else in your body.  Peering through the jade jelly, you make out a new form rising up from behind your undulating belly: [if (hasBalls = true) your expanding [pc.balls].][if (hasBalls = false) your newly acquired cum factories.] No wonder the ghost girl was grumbling on about being cold and hungry!  If this is indeed the same slime you've been fucking with all this time, you've already treated it to a deviant spin on life's basic necessities.  The ghoul-enhanced critter has gotten to wallow in perverse shelter and bask in a feast fit for the greatest whore queen in all of Mareth thanks to your poltergeist-ing shenanigans.  The distressing concoction of both the ghost girl and slime's sexual cravings has bared a new level of depravity in the dangerous duo: one of intent.");
	output("\n\nThese revelations are the last thing on your agenda, however.  The roiling cum sac [if (isGoo = true) \"easily over-encumbers your slimy lower half, mashing it against the grass.\"][if (isNaga = true) burgeons forth from your serpentine slit, its weight beginning to pin down your lower half.][if (isBiped = true) has already encompassed your legs, pinning them down with its surprisingly dense mass.][if (isTaur = true) is only growing larger, anchoring your body more and more as it increases in size and density.]  The unearthly ooze pays you one last soulless stare before its face splits off into several sections, each retreating into your body.  Some much needed respite is finally within your means now that the unnatural cataclysm on your sexual slots has ended.  What's left of the invader appears to have finished setting up shop deep within your stretchy loins.  Your cum-case still appears to be slowly swelling- the glutton is obviously having a field day in there as it mucks about- but it isn't anywhere near as severe as before.");
	output("\n\nAnxious to be rid of the burden, you try and raise up off the ground.  But much like your earlier run-ins, even the slightest graze to your haunted region causes it to wriggle around in delight.  The most you accomplish against the jiggling hulk is merely circling and stumbling in place back to the ground.  Perhaps you can coax it out of you just as you did before?  Your mission clear, you slowly try and sit up, placing your hands firmly on your nads.  The haunted scrotum violently rears up against you, the impact forcing you and your failed grasp back to the ground as just the sheer sensation of the act sends a tingle up your spine.  Your still-broadened [pc.cock] goes to full alert, an emerald-tinged blast of pre spurting forth.  Your cursed coin purse then surges forward, dragging you carelessly behind it as it crawls towards the lake, one nut in front the other  [if (balls > 2) followed in concert by the rest.]!");
	output("\n\nNow things have spiraled completely out of control.  You have no intention of letting this possessed pile tow you to your doom!  The strength of your mutinous cojones easily shatters any of your feeble attempts to grasp onto the ground.  You're left with only one option: to empty your load the best way you know how.  Grasping your moist [pc.cock], you begin jerking it as well you can.  Your tugging tormenter makes it difficult for you to maintain your grip, let alone hold your back up.  But your manhood is still cursed with its abundant girth, forcing you to go two-handed on this job.  Your sac shudders in delight as you achieve a fairly respectable outburst, sending green-tinged jism high into the air.  But it's hardly the effort required to bust balls this blue.");
	output("\n\nThe events are finally catching up to you, the hold on your cock wavering as your arms tire out on you.  Your deep breathing is interrupted by a gasp; water is lapping up against your crawling cumsac.  This ridiculous charade has gone on long enough!  You feel renewed vigor surging through your body as you firmly retake your [pc.cock] in both hands.  Rewriting every \"master-bator\" joke in existence, skilled, powerful strokes dominate your dick, your teeth clenched shut as deep breathes surge in and out your mouth.  Your nether regions quake, a foreboding sign for the eruption just on the horizon.  Even the gooey stowaway's mighty scramble gives way, your mounting tension overpowering it into frightened spasms.");
	output("\n\nBeings for miles must have heard the fearsome shouts that filled the air that ");
	if (hours < 11) output("morning");
	else if (hours < 17) output("afternoon");
	else output("night");
	output(".  The sound is of no concern to you, however; you're too busy making it rain.  Your back arches as high it can - possibly even higher than that.  With each unnaturally colossal surge of spunk, your possessed [if (hasBalls = true) [pc.balls]][if (hasBalls = false) balls] shift, shuffle, thrash, and flail about as they are forcefully drained of your gelatinous oppressor.  Everything within eyeshot is drenched in emerald-tinted semen; even the lake gets a healthy dose of your gooey baby batter.  There's no telling just how many immense heaves it takes to completely dispel the rogue...");
	output("\n\nYou're left on the shore of the lake with just your deep breathes, caked in quivering cum as the equally-assaulted waters brush up against your midsection.  You let out a resounding sigh as you feel your [pc.cock] finally allaying you of its burdensome girth.  An equal sense of ease sets in as [if (hasBalls = true) \"your [pc.balls] finally return to their normal size, resting comfortably between your cock and [pc.vagina] after a hard day's work.\"][if (hasBalls = false) your unwanted sac of anguish retreats into your groin, vanishing back to the unholy depths that it spawned from.] It seems as though you can finally clock out and head back to camp...");
	output("\n\n...But, what happened to the ghost girl? Her unknown fate finally dawns on you, prompting a swift jump up from the ground.  You peer down at the mess all along your body and the surrounding area, the shivering semen aimlessly milling about in a lazy attempt to reform itself.  Could she still be stuck in that thing?  Maybe you should try and help reassemble her... but that could take the rest of the day!  But out the corner of your eye, a clear spot in the surface of the lake calls out to you.  You peer down into the reflection... your eyes glowing with a pale yellow light.");
	output("\"<i>Boo!</i>\"  your face shouts at you, triggering a panicked backwards jolt from you which then results in you slipping back down on your [pc.butt].  The spook easily phases out of you during your tumble, standing perfectly still from your previous position as she glares down at you with the same mischievous smile from earlier.");
	output("\"<i>Yea, I jumped ship from that senseless slime the moment it finished filling you up to christen the S.S.  Ballsac,</i>\" she explains, her tone free of any responsibility.  \"<i>You're lucky I was around to pick up the slack for you.  ");
	if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] == undefined) output("You couldn't spank it even to save your life, as we've learned today.</i>\"");
	else output("Evidently, you haven't put in any meaningful practice since last time,</i>\" the specter chides you while making an exaggerated jerking-off motion.");
	if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] == 1) output("  \"<i>I was afraid you'd have... given up the ghost.</i>\"");
	else if (flags["COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER"] > 1) output("  \"<i>But I'm more than willing to do it again next time with a conclusion like that!</i>\"");
	output("\n\nThe ghost girl pays you a warm hearted grin before reaching into her tunic to pull out a bottle, quickly tossing it to your fumbling grasp.  \"<i>I came prepared this time... in more than one way.</i>\"  With a faint wave, the phantom takes off back to the ruins, leaving you to reorient and clean yourself up.  As you redress, you stare at the <b>container of ectoplasm</b> the wraith left with you.  ...Where in the world does she hide these things while she's jumping in and out of bodies? You're left to ponder the mystery as you shuffle on back to camp, brushing free the last bits of sentient jade semen that cling to your shoulder.");
	output("\n\n");
	IncrementFlag("COC.GHOST_GIRL_SLIME_X_SHOULDRA_COUNTER");
	//ECTOPLZ
	processTime(35 + rand(5));
	pc.orgasm();
	if (inCombat()) {
		if (!enemy.hasItem(new CoCEctoplasm())) enemy.inventory.push(new CoCEctoplasm());
		CombatManager.genericVictory();
	}
	else {
		quickLoot(new CoCEctoplasm());
	}
}