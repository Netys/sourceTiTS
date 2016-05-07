import classes.Characters.CoC.CoCHarpy;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function harpyFight():void {
	clearOutput();
	output("A harpy wings out of the sky and attacks!");
	//if (flags[kFLAGS.CODEX_ENTRY_HARPIES] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_HARPIES] = 1;
		//output("\n\n<b>New codex entry unlocked: Harpies!</b>")
	//}
	//spriteSelect(26);
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCHarpy());
	CombatManager.victoryScene(harpyVictoryuuuuu);
	CombatManager.lossScene(harpyLossU);
	CombatManager.displayLocation("HARPY");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

//*If male/shemale, rape options are Pussy, Ass, Breasts*
//*If female, rape options are Finger Her, Forced Cunnilingus, 69*
//*If hermaphrodite, rape options are Pussy, Ass, Breasts, Forced Cunnilingus, 69*
//*If genderless, rape options are Finger Her*
public function harpyVictoryuuuuu():void
{
	clearOutput();
	//(Enemy defeated by damage) 
	if (enemy.HP() <= 1) output("The harpy screams out in one last, pained cry before her wings give way, the feathered woman collapsing into a weary heap.\n\n");
	//(Enemy defeated by lust)
	else output("The harpy can't contain her lust anymore and crumples to the ground before you, on her knees with her plush, heavy ass resting on her feet. She coos pathetically, with one hand between her legs furiously fingering herself, and the other pressed against your crotch, a needy look in her eyes.\n\n");
	
	clearMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); } );
	
	addDisabledButton(0, "Anal", "Anal", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(1, "Pussy", "Pussy", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(2, "Oral", "Oral", "This scene requires you to have genitals and sufficient arousal.");
	addDisabledButton(3, "Scissor", "Scissor", "This scene requires you to have vagina, non-naga body and sufficient arousal.");
	addDisabledButton(4, "Clit Fuck", "Clit Fuck", "This scene requires you to have big clit and sufficient arousal.");
	
	
	//Genderless get nothing.
	if (!pc.hasGenitals() || pc.lust() < 33) {
		return;
	}
	//Rape options
	if (pc.hasCock()) {
		if (pc.cockThatFits(enemy.analCapacity()) >= 0) addButton(0, "Anal", winAndRapeHarpyAnally, null, "Anal", "Put your cock to a good use and take the harpy from behind.");
		if (pc.cockThatFits(enemy.vaginalCapacity()) >= 0) addButton(1, "Pussy", victoryHarpyGetsHerPussyRaped, null, "Pussy", "That harpy's pussy looks inviting...");
	}
	addButton(2, "Oral", WinOnHarpyAndOralRape);
	if (pc.hasVagina()) {
		if (!pc.isNaga()) addButton(3, "Scissor", harpyScissorSurprise, null, "Scissor", "Get into some girl-on-girl activity with the harpy.");
		if (pc.clitLength >= 3.5) addButton(4, "Clit Fuck", clitFuckAHarpy, null, "Clit Fuck", "Fuck the harpy with your big clit.");
	}
}

public function harpyLossU():void
{
	clearOutput();
	//NO MALE RAPE IF DICK TOO BIG
	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.vaginalCapacity());
	//Genderless people get boned
	if (!pc.hasGenitals() && pc.isGoo()) {
		harpyGooGenderlessLoss();
		return;
	}
	//Dick that fits or has cunt
	if (x >= 0 || pc.hasVagina()) {
		if (pc.lustQ() > 99) harpyLossLust();
		else harpyDamageLoss();
	}
	//No fitu
	else {
		output("Though you've been defeated by the harpy, it doesn't seem she wants anything to do with you, and gives you a whack upside your head before departing.  ");
		processTime(10 + rand(10));
		CombatManager.genericLoss();
	}
}

private function harpyGooGenderlessLoss():void
{
	clearOutput();
	output("The triumphant harpy looks down at your goopy form, ready to take you.  She seems a little confused though, and begins poking at your gelatinous body.\n\n");

	output("\"<i>Penis?</i>\" she eventually asks.\n\n");

	output("You tell her no.\n\n");

	output("\"<i>Pussy?</i>\"\n\n");

	output("Nope.\n\n");

	output("\"<i>Oh...</i>\"\n\n");

	output("She grabs a handful of you and releases it, watching your body jiggle about. This seems to amuse her greatly and she plunges both hands inside you then shakes them about. Retracting them, she takes a few steps back and gives you an evil grin, then lets out a blood-curdling shriek.\n\n");

	output("Two more harpies flap down beside her and the trio huddles together, periodically pointing at you.  Most of what they're saying is inaudible to you, though you're fairly sure you heard 'goop' somewhere in there.  You're not given much time to stew on it though, as they seem to agree on something and approach.\n\n");

	output("The smallest of the bunch walks right up to you and punches your chest, laughing and chittering as your body undulates in response.  The other two stick their arms inside you and begin shaking them about, also laughing.  This goes on for quite a while, with the bird women trying various positions and levels of force (including a particularly odd one in which two attempted to shove your entire body up the third's vagina; not exactly a situation you want to find yourself in again...). Eventually they get bored of you and flap off, leaving your exhausted body in a pile until you get enough energy to pull yourself together and head back.");
	
	processTime(40 + rand(20));
	CombatManager.genericLoss();
}

//Requires pussy or cock small enough for harpy!
private function harpyLossLust():void
{
	clearOutput();
	//Merauder wroted.
	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.vaginalCapacity());

	output("You collapse in a broken heap, panting as your body feels hot and heavy with desire.  The wanton blood coarsing through your veins is a testament to the sumptuous shapes of the harpy's lithe bodies. Turning your aching head to look at the ever-circling harpy, you see her mad-looking eyes narrow as she gains height, flapping her two pairs of wings frantically.\n\n");

	output("She lets out a psychotic cry that seems to echo through the area around you, carrying into the hills and back again. You could swear that more cries come back than the one that started the rolling echo, but before you can dwell on this, the crazed bird-girl dives at you with incredible speed. She lands elegantly in front of you, teasing you by obscuring parts of her body with a fan of feathers. When she gets close enough, the horny harpy plucks at your [pc.gear], attempting to remove it.\n\n");

	output("It's not just her claws moving across your body! From behind and from the side, three more ornately plumed ladies have descended and are running their talons curiously across the last trappings holding your gear to your body. When these are undone, your [pc.gear] falls to the ground. You cover your " + pc.allBreastsDescript() + " and crotch as the foursome leer at you unnervingly with their pitch black eyes and yellow pupils. The sensation is not so bad however, being surrounded by these fair and elegant creatures. When the four spread their wings, they screen your body from the outside world in a palette of colorful plumage. The one that took you down lets a single lock of your [pc.hair] fall across her talons admiringly");
	//if long hair
	if (pc.hairLength > 12) output(" and moves it out of your face");
	output(".  When she smirks, you know you're in for quite a ride.\n\n");

	//{If Player has only a pussy} Fan of feathers: 
	if (pc.hasVagina() && x < 0) {
		output("Grabbing your sedate body by ankles and wrists, the four yank you roughly towards a large stone slab, upon which they lie you down, warbling and squawking. Three hold you down and as though they're trying to avoid other harpies getting in on the fun, the three to your side spread their wings wide and cover you up in a feathery dome.  While you are pinned down, the fourth climbs in on top of you as you struggle, taking it amazingly slow. She extends an open hand, revealing the long talons that constitute her fingers and runs the tip of one across your bare chest, leaving a red trail. It makes you gasp a little. The nail would be sharp enough to carve your flesh if she didn't put it down with such care. She seems to like the reaction of both you and your [pc.skin] and chirps bemused.  ");
		if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN) output("Shortly after, she repeats her journey, this time by folding her wing towards you and almost like soothing the trek, swishing the tip of her tallest feather across it, evoking a thankful moan. The downey barbules are some of the softest materials you've yet encountered. The harpies must not be familiar with sensitive skin like yours and they're exhilarated with the discovery.  ");
		output("Within moments, the three harpies holding you down join in on the fun, running their razor digits carefully across your body");
		if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN) output(" and quickly alleviating the pain by brushing their wings across your hide", false);
		output(".  You instantly stop struggling, no matter how insane the sensation is. One wrong move and you'd lance yourself on their talons even if the harpies did not intend it. It's hard to lie still however. Every inch of your body is beset by the hair-raising scratch of their razor sharp nails");
		if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN) output(", always followed by a soothing brush of their feathers");
		output(". They line the curve of your " + pc.breastDescript(0) + ", brush around your aurela, and harden your [pc.nipples]. They trace your inner thigh, and not even your " + pc.feet() + " are safe. It does not tickle, but your nerves are lit up like a Christmas tree and a tear wells up in your eyes as you're forced to lie still in the face of such a soft, yet overpowering sensation.\n\n");

		output("Suddenly, there's a different feeling altogether. You look down and through the feathered fans, spot one of the harpies with her face between your spread legs. She looks at you, a sultry expression in her black-yellow eyes as her black, stout tongue runs up and down your [pc.vagina]. You close your eyes and focus on that, instead of the maddening sensation of the rolling waves of talons");
		if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN) output(" across your reddening skin");
		output(". Her little black tongue feels divine as it bumps up against your [pc.clit]. WHen you let out a small, alleviated coo, the other harpies once again follow suit. The two previously holding your arms, bend down and put their stiff lips on top of your antagonized nipples, rewarding them after having brushed past them so many times.\n\n");

		output("You feel your " + pc.legs() + " being lifted up and out of the way. Feathered arms curl around either side of your thighs to keep them in place as the harpy teasing and suckling your [pc.clit] gives the last harpy enough room to scoot in below her. A teasing of soft harpy hair feathers against your [pc.ass] is the only warning you receive before you feel the wet warmth of that final black tongue pressing against your [pc.asshole].\n\n");

		output("It doesn't take long for you to reach climax when the harpies continue to titillate your skin with their digits while suckling your pleasure button and nipples. You count yourself fortunate that they have the sense to retract their talons when you shudder and convulse upon the slab.\n\n");

		output("When you recover a few hours later, the harpies are gone. All they've left you with is a sloppy cunt and a few downey feathers clinging to your nipples and inner thigh.\n\n");
	}
	//{When player has a cock} Airborne sex! 
	//(Reminds me of what my own Succubus does in my novel)
	else {
		output("The ladies flap their wings and you're surprised by their grace and power. Three of them grab you by the shoulders with their hawk-like feet and lift you up effortlessly and with good speeds like mere prey. When the ground is removed beneath your feet, your heart jumps, but it leaves you completely at the mercy of the harpies who begin to fly up higher and higher. By the time you begin to protest, you're already fifty feet up into the air. If they'd drop you now, your fall would be fatal. It only makes the way in which they begin to toy with you all the more frightening.\n\n");

		output("They drop you on purpose, only for you to be caught again mid-air by one of the harpies. Using the momentum, your sadistic savior then throws you around like a sling for others to catch, which they do crying with joy, before passing you along again with dizzying speeds and heights. The ground below rushes towards and away from you in rapid succession. After five times, they squabble and two of them nearly pull you apart between them. It is then however, that a third gets an idea. Using the fact that your body is suspended between two others pretty stably, she flies into you and latches on by crossing her legs and arms around your hips and waist. There, high up in the sky and in intimate embrace, the other two harpies still quarreling, she smiles at you while straddling you. In an unknown language of whistles and chirps, she assures you it's going to be all right and reaches underneath her to fondle your cock. With the warmth of her body so near to yours and now armed with wings of your own in the form of the harpy on top of you, it works. Held between three digits, your [pc.cock " + x + "] assumes its erect shape. It makes the latched harpy give a pleased warble, and with a quick slip, she pushes her womanhood against it until you sink into her.\n\n");

		output("The little slit is a bit dry, but her shaft is silky smooth and pliable. With no effort, she starts to hump you, running her arid canal across your [pc.cock " + x + "] and holds on tight. Within minutes, the efforts of the eager little lithe parachute latched on front of your body makes you wheeze. Her entire body bucks and bends frantically on top of yours. Another harpy comes flying up and demands a turn of her own, but cannot find an opening. Instead, she chooses to fly underneath your chafing bodies and starts licking the embracing nethers enthusiastically. ");
		if (pc.balls > 0) output("You can feel her little tongue rolling across your balls and the base of your ");
		else output("You can feel her little tongue rolling across the base of your ");
		output(pc.cockDescript(x) + " whenever the one on top of you doesn't take you up to the hilt.\n\n");

		output("You were just about to climax, when the harpies keeping you airborn decide they want their own turn. Spurned, they let go of you, sending you to plummet back to earth with one of the harpies still fucking on top of you. This time, the other three don't seem bothered to save you anymore.\n\n");

		output("The ground rapidly aproaches, but the harpy fucking you doesn't even seem to notice. She simply continues to dry hump, a stupored stare of sex in her eyes. You try to alert her, but as she starts squeezing your cock within the hawk-like confines of her birdhole, she doesn't even attempt to flap her wings. With just a few feet remaining, you finally orgasm and release your load into her eager cunt, yelling and flailing your arms as textured details of the mountain's granite ground rushes towards you. As you fill her up with your last desperate throes, it seems to do it for the bird-lady. With the last ten feet remaining, she disconnects, spreads her wings and uses the velocity to tumble forcefully and hurl you away horizontally. With a faint arc, you skip across the floor for over a dozen feet.\n\n");

		output("In your last conscious moment before you pass out from the hit, you hear the harpy sisters cackling above you.\n\n");
	}
	pc.orgasm();
	pc.slowStatGain("l", 1);
	processTime(40 + rand(20));
	CombatManager.genericLoss();
}

//No genderless folks.
private function harpyDamageLoss():void
{
	clearOutput();

	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.vaginalCapacity());
	if (x < 0) x = 0;
	var y:Number = x + 1;
	//If second cock is out of bounds, choose one in bounds
	if (y >= pc.cocks.length) y -= 2;
	if (y == x && pc.totalCocks() > 1) {
		if (y == 0) y++;
		else y--;
	}

	output("You collapse in a broken heap, gasping for breath as your wounds sting and throb, a testament to the sharpness of the harpy's claws. Turning your aching head to look at the ever-circling harpy, you see her mad-looking eyes narrow as she gains height, flapping her two pairs of wings frantically.\n\n");

	output("She lets out a psychotic cry that seems to echo throughout the area around you, carrying into the hills and back again. You could swear that more cries come back than the one that started the rolling echo, but before you can dwell on this, the crazed bird-girl dives at you with incredible speed, her thick frame colliding with you. You are sent spinning and rolling across the ground, your wounds singing a hymn of pain and weariness. After a few complex moments, the pair of you are dumped in a heap on the floor, with the horny harpy clawing brutally at your [pc.gear], tearing it away from your body in no time at all.\n\n");

	//[(Male, shemale, herm)
	if (pc.hasCock() && x >= 0) {
		output("As her crazed, brutal hands clutch at every part of your body, grasping every ounce of flesh they can reach, your hazed, weary mind seemed to be receiving more signals than you thought, more hands clawing at you, more crazed avian cries. Your vision swims from the pain and, as you look down, conscious for just a few seconds, ");
		if (pc.cockTotal() > 1) output("each of ");
		output("your [pc.cocksLight] flopping from side to side from the ministrations, you see not one, but THREE deranged, randy bird-girls, all squabbling over your genitals.\n\n");

		//[(Male/shemale)
		if (!pc.hasVagina()) {
			output("The hierarchy is eventually settled, it seems, because two of those heavy-hipped bird babes wrap their lips around your [pc.cock " + x + "], sucking and pecking at the hot flesh");
			if (pc.balls > 0) output(", craning their necks to slurp and massage your [pc.balls] eagerly, trying to coax up your cum production as much as they can");
			output(". The third, estranged harpy leaps at your torso, straddling your navel with her weighty rear, knocking the breath out of you and leaning down, ");
			//(If breasts)
			if (pc.biggestTitSize() >= 1) output("her petite bosom grinding across your " + pc.allBreastsDescript() + ", her nipples tickling at your [pc.nipple], ");
			output("her golden lips glinting in the light as they make for your own.\n\n");
		}
		//[(Herm)
		else {
			output("The hierarchy is settled between the warring bird-girls, and two of them grasp onto your thighs with their clawed hands, those gold-lipped mouths starting to hungrily suckle and taste every inch of your [pc.cock " + x + "], their squawking, feathered heads occasionally diving down to probe their short, stubby tongues into your [pc.vagina], sending sharp spikes of pleasure rippling through your body, ");
			//(If balls)
			if (pc.balls > 0) output("their hands moving up to grope and fondle your [pc.balls], massaging them to boost your cum production as much as they can, ");
			output("tiny tingles left on your body at every spot their gilded lips caress. The third harpy dives at your chest, her thick hips SLAMMING into your stomach, knocking the breath out of you");
			//(If breasts)
			if (pc.biggestTitSize() >= 2) output(", causing your " + pc.allBreastsDescript() + " to bounce and sway violently");
			output(".  She slowly leans down, her eyes locked on yours, her lips glinting a malicious gold");
			//(if breasts)
			if (pc.biggestTitSize() >= 2) output(" her toned chest and pert breasts squishing your " + pc.breastDescript(0) + " beneath them");
			output(".\n\n", false);
		}
		//Apply harpy status.
		luststickApplication(8);
	}
	//[(Female) 
	else {
		output("The hierarchy is determined, and two of the harpies dive forward, burying their fat golden lips into your [pc.vagina], their short, stubby tongues probing and exploring every inch of your feminine love-tunnel.  Together they circle and push at your [pc.clit] sensuously, leaving a sharp tingle at every little point their plump golden lips brush against.  Growing more and more horny, each harpy probes one hand behind herself to toy with her drooling pussy, coaxing aroused squawks and moans from the group as they tend to you. The leading harpy makes a reckless dive for your chest, intent on claiming her prize before anyone else can take it from her. Careering down upon your stomach, her immense, wobbly ass pounds into you, knocking the breath out of your lungs");
		//(If breasts)
		if (pc.biggestTitSize() >= 3) output(" and causing your " + pc.allBreastsDescript() + " to jiggle, slapping into one another");
		output(". She leans slowly over you, her gilded lips glistening with saliva as they approached yours");
		//{(If breasts)
		if (pc.biggestTitSize() >= 2) output(", her petite chest squashing your " + pc.breastDescript(0) + " against hers");
		output(".\n\n");

		output("When the harpy's lips press against yours, your vision starts to swim. She kisses you ferally, fuelled by a primeval lust.  Her short, sharp tongue slaps yours all over your mouth, tickling and scratching across your lips. As you are forced into the crushing, vicious kiss, you notice that the pleasure shooting up and down your body seems somehow sharp, and your lust is beginning to swell and surge around your mind.  Everywhere their lips have brushed on you feels tingly and pleasurable... those golden lips... they must be drugged! Even as you realize this, it is too late, and your tense muscles collapse in the overwhelming feel of it, your libido burning hot even as your body feels so weary.\n\n");

		output("As you succumb to the powerful aphrodisiac in the harpy girls' lipstick, the feathered beauties are squabbling all over again, but this is lost to you.  The harpy girl straddling your chest shifts up, her moist, glistening sex shining in the light and peeking out from between her incredible asscheeks. Without waiting for you to draw breath she lets her whole weight SLAM down onto your face, her slick honeypot grinding back and forth across your nose as she rolls her hips.  She squawks and moans in slutty enjoyment while you struggle for breath in vain.  The chemicals in that lipstick shut down your sense of self-preservation, forcing you to perk up and mash your face lustfully into her sweet-tasting pussy.  Both of your hands snap up, seemingly of their own accord, and knead and squeeze at her fat rear cheeks.  Her feathers become ruffled in short order from the groping. The squawking in the background has quietened down and some part of your mind steels yourself for what's coming.\n\n");
	}
	//[(Male, Shemale, Herm, One cock)
	if (x >= 0 && pc.cockTotal() == 1) {
		output("Another powerful sensation shoots through you, forcing your back to tense from the simple, pure pleasure, and further forcing your face to lick and taste her moist cunt. You're blinded completely by the huge ass-cheeks stifling your face, and can only feel the hot, rough walls of a harpy's pussy as it descends on your [pc.cock " + x + "], slipping all the way down to the base as the slutty harpy squawks in a perfect duet with her face-riding sister. The clutching tightness engulfs your whole length as she slips down to the base");
		if (pc.balls > 0) output(", her huge feathery bottom coming to rest on your [pc.balls]");
		output(". Even as you come to bear this tremendous pleasure, you feel your hands wrenched carelessly from the big butt that's grinding against your face, and a small feathery pair of hands guides them to their goal.  Your fingers slip into the hot, clutching tightness of two harpy holes, the sensations made even more vivid by the blinding faceful of ass.  A sharp-clawed foot steps dominantly on your navel, digging the claws into your " + pc.skinFurScales() + ". The two harpies whose asses are pinning you to the ground start to bounce their full weight brutally on your already broken body in unison.  The sheer, vast weight of their hips batters every inch of you, twin feathery punchbags slamming into your cheeks and onto your crotch. Were it not for the hot, moist hole that's coating your mouth, you would be screaming in pain");
		if (pc.balls >= 0) {
			output(".  Your [pc.balls] bounce with such force as to fetch the cock-speared harpy a stinging slap on the rear with every brutal, mechanical fuck");
			//{(If herm)
			if (pc.isHerm()) output(" before swinging back to spanking your [pc.vagina] wetly.");
			else output(".");
		}
		else if (pc.biggestTitSize() >= 2) output(" while your " + pc.allBreastsDescript() + " are shaking and jiggling around helplessly.");
		else output(".");
		output("  It's anyone's guess how long you'll be able to maintain consciousness while being ridden to exhaustion.\n\n");
	}
	//[(Male, Herm, Shemale, Multi-cock)
	else if (x >= 0 && pc.cockTotal() > 1) {
		output("The squabbling hasn't gone on for very long this time, and you know why.  You steel yourself beneath the tremendous quivering rumpcheeks; you can't help but gasp for breath, moaning sluttily as your [pc.cock " + x + "] and " + pc.cockDescript(y) + " are crushed by the tight walls of a pair of unbelievable harpy pussies.  As the face-riding bird-girl releases a thick, creamy load of feminine juices onto your face, she leans forward and moans out in bliss.  You're allowed to peek between her thighs at the action on your crotch. One of the monstrous-assed harpies is bent down, her hands grasping onto your calves as she slips her plump-cheeked pussy down onto your " + pc.cockDescript(y) + ".  Her sister is back-to-back with her, and her own sweet, rough cunt grinds down onto your [pc.cock " + x + "]. Just as you catch the glimpse of this amazing sight, your vision is obscured once more by the pudgy cheeks of the third girl, her rear shifting back and smearing that cum-stained vagina against your mouth. All three girls, once they've established their positions, start to mercilessly pound their chunky buns against your body.  The girls on your two cocks are pumping in opposition.  Just as one clutching, roasting pussy releases its grip on your meat, the other slams down forcefully, giving you no time to catch your breath, even as the fat-assed fowl on your face bounces and jiggled. Your head is savagely slammed against the ground with each wet, splattering rebound.\n\n");
	}
	//[(Female)
	else {
		output("The harpy whose immense ass is pinning your face to the ground raises her dripping cunt from your hungry lips, turning with her feet placed on either side of your head.  She shakes her feathered rear gently with her tail swaying in the breeze. Without so much as a warning, the hungry harpy drops that massive ass HARD onto your face, the impact cushioned pleasantly by the sweet, jelly-like flesh of her honeypot slapping onto your mouth.  Her tight rear passage squishes against your nose, ticklish feathers pressing at your cheeks while her powerful thighs clutch at the sides of your head.  You feel the tense, feathery bodies of the other two harpies clutching at your flanks, their hands sweeping over every inch of your body in pure lust.  ");
		//{(If breasts)
		if (pc.biggestTitSize() >= 2) output("Their hungry feminine mouths creep beneath the body of the harpy atop you and grab hard onto your " + pc.breastDescript(0) + ".  They pull them towards their mouths, those gold lips wrapping themselves around your [pc.nipples] to suckle gently.  ");
		//{(If lactating)
		if (pc.isLactating()) output("You hear some subtle slurps around the big feathery earmuffs crushing your head, and feel your " + pc.breastDescript(0) + " begin to drain, sending motherly shivers through your whole being.  The monster-girls drink and drink, those stubby tongues circling each nipple while the drugged golden lips make you tingle sensually.  ");
		output("Their hands find their way to your [pc.vagina], and two sets of fingers start to explore your lush, velvety depths.  They seem intent on making their captive quiver and scream in ecstasy beneath the stifling birdy bottom. The riding harpy leans down, ");
		//{(If breasts)
		if (pc.biggestTitSize() >= 2) output("her belly squishing your " + pc.allBreastsDescript() + " beneath her weight, ");
		output("and her drug-laced mouth joins the two intruding fingers in exploring your moist, feminine sex. Even as your [pc.vagina] lets out its first wave of sticky girl-cum, your body tightens from the strength of the orgasm.  The harpy's stubby tongue drives into you, licking up your hot, sticky fluids.  Those tingly drugs even slip past your nether lips, seeming to warm you from the inside out while her insane birdy tongue thrashes around in your [pc.vagina]. The other bird-girls' practiced fingers don't let up in the slightest.\n\n");
	}
	//[(Male, Herm, Shemale)
	if (x >= 0 && pc.hasCock()) {
		output("They ride you brutally, switching position every now and then to make sure all three harpies get the satisfaction they need. You lose track of the amount of times you've spurted thick, creamy cum into those hot, rough passages");
		//{(If herm)
		if (pc.isHerm()) output(", and the number of times your [pc.vagina] has dripped your sweet feminine cum over your thighs");
		output(". Every part of your being screams in pain from the hours of relentless hammering by the harpies' immense, wobbling rears; you think a few bones might even have broken.  Yet every time you came close to blacking out from the pain, the three harpy girls had squawk and trill loudly, abandoning their actions to all lick and slurp at your [pc.cocksLight].  Their drug-laced kisses pull you back from the brink and allow them to continue their relentless pounding!");
	}
	//[(Female)
	else {
		output("The harpies' fingers and that firm, buffeting tongue have driven you to orgasm over and over again.  You're lying in an immense pool of your own sexual fluids as the bird-girls' lips pump you full of those lust-inducing drugs, keeping you from blacking out by just a smidgeon.  Those hips batter your head, slamming it repetitively into the ground and dazing you.  The girls rotate, making sure they all have a nice, long turn riding your face and nibbling on your breasts.  ");
		//{(If lactating)
		if (pc.isLactating()) output("  Their bellies seem a little pudgier than when they'd started, a result of the endless drinking from your [pc.nipples].  ");
		output("  At long last, all three bird-girls raise their drooling, swollen fuck-holes above your head.  Each of them bares their buxom backsides and feverishly rubs their delicate hands over their clits until, in unison, they cry out with a bone-crushing orgasms.  All three girls' eager cunts spurt out hot feminine cum over your face, neck and chest.  The effects of their drug-laced kisses start to wear off and your vision swims. You catch a last glimpse of the harpies going through the bags and pockets of your long-discarded [pc.gear] before the blissful embrace of unconsciousness finally takes you.\n\n");
	}

	//[Male, Shemale, Herm]
	if (x >= 0 && pc.hasCock()) {
		output("After countless hours of remorseless, relentless poundings from three heavy bird-butts, even the effects of their drug-laced kisses aren't enough to stave off unconsciousness.  You struggle for breath beneath a pair of crushing, feathery thighs as ", false);
		if (pc.totalCocks() > 1) output("each of ");
		output("your [pc.cocksLight] shakes and quivers under the attentions of the merciless bird-girls, releasing a powerful blast of hot, sticky seed, coating the three cruel harpies.  They're still rubbing and probing their pussies with delicate fingers while you cum. You hear some angry squawking and a few syllables of recognizable language before you finally give in to unconsciousness, fading into a warm dream of soft, velvet thighs...\n\n");
	}

	output("After a few hours, when you wake, every muscle in your body is aching as though you've just run a marathon. Looking down at your " + pc.legs() + " in a weary haze, you see signs that even after you'd blacked out, your body had continued to be abused by the three lust-crazed harpies.");
	//fatigue(20);
	pc.energy( -20);
	pc.orgasm();
	//dynStats("str", -1, "tou", -1, "lib", 1, "sen", 2);
	pc.slowStatGain("l", 1);
	pc.slowStatGain("p", -1);
	processTime(3 * 60 + rand(60));
	CombatManager.genericLoss();
}

private function victoryHarpyGetsHerPussyRaped():void
{
	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.vaginalCapacity());
	if (x < 0) x = 0;
	var y:Number = x + 1;
	//If second cock is out of bounds, choose one in bounds
	if (y >= pc.cocks.length) y -= 2;
	if (y == x && pc.totalCocks() > 1) {
		if (y == 0) y++;
		else y--;
	}

	clearOutput();
	output("You step over the now-submissive feathered beauty and grin, your [pc.hips] swaying from side to side idly as you eye up the sweet curves of your latest conquest. Stripping off your [pc.gear] and tossing it aside carelessly, you waste no time with words, pushing her roughly down to the ground face-down and rubbing your [pc.cocksLight] in anticipation. She raises her magnificently-plumed head and turns it, looking at you pathetically with a glint of fear in her eye, squawking and crooning as if pleading with you. This passes unnoticed to you, however, as the sight of her thick, fluffy ass and meaty thighs has captured your attention FAR more effectively.\n\n");

	output("Wrapping your arms around those immense, motherly hips, you drag her rump up so that it sways and jiggles in the air, forcing the big-butted bird-girl into the doggy position. Her cheeks burn red with embarrassment, but the way she is jiggling and shaking her blubbery bottom at you tells you she wants it just as much as you do. Finally getting a really good view of it, your eyes widen as you run your hands over every inch of her bouncy rear - it's more like standing behind a horse than a harpy! An ass this fine isn't to be wasted, and so you lean down and bury your " + pc.face() + " between those luxurious orbs, planting your mouth firmly over her drooling pussy and tasting her sweet juices, suckling and kissing around her beautifully-formed clit and breathing her intoxicating feminine scent in with enjoyment, letting it fill your lungs as your expert ministrations coax a plethora of moans and subtle squawks from your partner.\n\n");

	output("But as sumptuous as her enormous rump is, you can't resist taking her right then and there. The scent from her pussy has taken a serious effect on you as, with an almost feral roar, you break away from her drooling velvet pussy and grasp onto those immense hips, which feel as soft as digging your hands into the most luxurious cushions you can imagine. Guiding her sweet, dribbling fuck-hole onto your [pc.cock " + x + "], you aim to impale the disheveled harpy with all your might, pulling hard on her waist to bury yourself as deep as you can.\n\n");

	//(Added bit for multi-dicks) 
	if (pc.totalCocks() > 1) output("As your head creeps past her tight entrance, your " + pc.cockDescript(y) + " brushes past her hot, clenched anus and a wicked idea forms in your brain. Pulling your [pc.cock " + x + "] free for the time being, you grasp your two lengths of meat in one hand and smear them enthusiastically against her slick honeypot, coating them in slippery-sweet feminine fluids, before trying a second time. You squeeze her plump rump and force those two hot, throbbing cocks deep inside her holes, letting out a breathless moan which is echoed by the stricken harpy as she tries to adjust to the sudden intrusion.\n\n");

	output("You slowly slip your [pc.cocksLight] into her hot, clutching depths, inch by inch, seeming to take an eternity as all the sensations of her rough, ribbed pussy ");
	if (pc.totalCocks() > 1) output("and viciously-clenching ass ");
	output("pulse through you. She throws her head back and moans out in sheer, slutty enjoyment as you plumb her luxurious depths, different from anything you've experienced before in its firmness and the powerful, brutal sensations it is giving to you.\n\n");

	//(If balls)
	if (pc.balls > 0) output("You eventually bottom out, your [pc.balls] coming to rest between her powerful, gelatinous thighs, her soft feathers tickling at your [pc.sack] maddeningly.\n\n");
	//(If balls-less) 
	else output("Leaning low over her back, you adjust to drive yourself ever deeper, forcing the whole length of your [pc.cock " + x + "] into her, the soft down on her gelatinous thighs prickling at your thighs maddeningly.\n\n");

	if (pc.hasCock() && !pc.isHerm()) {
		//(Male, no breasts)
		if (pc.biggestTitSize() < 1) {
			output("Taking care not to waste your opportunity with an immense butt by cumming too soon, you slowly start to push and pull her fat, quivering cheeks up and down your [pc.cock " + x + "], feeling her rough walls and clutching, gasping convulsions massage your manhood");
			if (pc.totalCocks() > 1) output("s");
			output(" along ");
			if (pc.totalCocks() > 1) output("their");
			else output("the");
			output(" whole length, already bringing you close to the edge of a bone-shaking orgasm.\n\n");
		}
		//[(Male w/ breasts)
		else {
			output("You laugh in glee as the bird's groping, clutching hole");
			if (pc.totalCocks() > 1) output("s massage");
			else output(" massages");
			output(" your " + pc.cockDescript(x));
			if (pc.totalCocks() > 1) output(" and " + pc.cockDescript(y));
			output(" while you knead over your " + pc.allBreastsDescript() + " hungrily.  You start to pound her tight, harsh hole roughly, groaning and licking your lips, trying to master the power of the sensations her hot, clenching hole are giving to you. You lean down low over her back, your " + pc.allBreastsDescript() + " pressing against the tickly, prickling feathers, as you bite down onto her shoulder.  Your [pc.hips] raise and drop mercilessly into that jiggling, jelly-like ass, giving a noticeable bouncing effect from it as the squishing flesh catapults your rear back into the air with every lewd, slapping thrust.\n\n");
		}
	}
	//[(Herm)
	else if (pc.isHerm()) {
		output("Grinning and massaging your conquest's round, soft ass in anticipation, you gently begin to thrust your [pc.hips], moaning loudly as her rough, grasping walls drag over the sensitive flesh of your [pc.cocksLight]. Your [pc.vagina] practically spurts fluids out, dribbling down the inside of your thighs as you pump in and out of the helpless harpy.  You love every second you get to spend in her harsh inner walls.\n\n");
	}

	output("It seems the exposed girl is enjoying herself just as much.  Every tiny motion of your [pc.hips] causes her to writhe and moan, her moans punctuated with birdlike squawks as she pushes her huge egg-bearing hips back at you in sheer, undisguised desire to have you fuck her harder and deeper.\n\n");

	output("You decide to give her what she so clearly wants and plant both your hands onto her massive bottom, squashing and groping it around your impaling [pc.cocksLight] as you speed up the pace of your thrusts, driving the full length of your " + pc.cockDescript(x));
	if (pc.totalCocks() > 1) output(" and " + pc.cockDescript(y));
	output(" into her grinding, overwhelming hole");
	if (pc.totalCocks() > 1) output("s");
	output(".  ");
	//{(If balls)
	if (pc.balls > 0) output("Your [pc.sack] slaps wetly into her immense, wobbling thighs.  ");
	output("She screams, and thrusts her fat rear back against you, its impact cushioned by the sheer amount of meat on her wide hips.\n\n");

	output("For what seems like hours the pair of you go on, the harpy screaming in ecstasy as she cums over and over again, spattering obscene amounts of sticky feminine cum onto your " + pc.legs() + ". The slippery cum coats the ground beneath you, covering a wider and wider area as your brutal pounding becomes more and more intense.  Finally you throw your head back, scream out in orgasm and pump the whining, quivering harpy girl's love tunnel full of your hot, sticky cum.  You keep thrusting yourself in and out to get as much of that hard, grueling pleasure as you can out of her sweet, plump bottom.  It bounces against your crotch each time, as though you were fucking a pair of warm velvet pillows...\n\n");

	output("Once your flow of seed subsides, you pull free of the fat-reared harpy.  She collapses into an orgasm-wracked pile on the ground, her plump ass and tender thighs waving in the air for whomever comes along after you.  You wipe yourself down and continue on your way, pleased with the brutal fuck and looking forward to your NEXT encounter...\n\n");

	pc.orgasm();
	processTime(30 + rand(10));
	CombatManager.genericVictory();
}

private function winAndRapeHarpyAnally():void
{
	clearOutput();
	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.vaginalCapacity());
	if (x < 0) x = 0;
	var y:Number = x + 1;
	//If second cock is out of bounds, choose one in bounds
	if (y >= pc.cocks.length) y -= 2;
	if (y == x && pc.totalCocks() > 1) {
		if (y == 0) y++;
		else y--;
	}

	output("Grinning to yourself and stripping free of your [pc.gear], you lean down and grasp the harpy's pointed chin, turning it from side to side, your eyes roaming across her sharp, beautiful features as you inspect your prize. Her body just begs to be touched!  You gaze at those marvelous, tickly feathers coating her slender chest and those awe-inspiring hips, each supporting a fat, jiggling buttock that's nearly as large as a centaur's whole rear!  Without hesitation, the stricken harpy raises herself and starts to press that sweet, feathery body against yours, squawking and crooning pathetically.");
	if (pc.biggestTitSize() >= 2) output(" Her petite bust squishes against your " + pc.allBreastsDescript() + ". Her downy tits tickle, and grind against your chest maddeningly, tickling and scratching them gently as the lust-fueled bird-girl seems to ache for you.");
	output("\n\n");

	output("Not wishing to keep her fantastic butt waiting, you grasp onto her shoulders and pull her back with you, laying back against the hard ground with the squawking avian slut grinding and bouncing her bean-bag ass against your [pc.cocksLight].  Blood flows through your [pc.cock " + x + "] as it is sandwiched between her hot, caressing, luxurious ass cheeks, and you grind the head brutally against her impossibly tight pucker, which seems to make her panic a bit. She starts squawking and flapping her arm-wings in a vain attempt to escape your grasp, and the imminent butt-fucking she is about to receive! You smirk to yourself as the fluids from her womanhood drool and spill over your entrapped [pc.cock " + x + "], your slowly-pumping [pc.hips] smearing her own sticky sexual juices over those downy butt cheeks.\n\n");

	output("The bird-girl's attempts to escape only turn you on more, and you grab HARD onto those gelatinous orbs, guiding your [pc.cock " + x + "] into her gloriously tight and hot rear entrance; it feels harsh and rough, practically scratching every inch of your member as it's driven hard against her resisting inner walls.  She's far tighter and hotter than any human girl could possibly be! Your [pc.cock " + x + "] pushes so viciously and painfully into her clenching tight depths that the harpy squeals and cries out, trying to fly away from you again.  However, she only succeeds in clenching and waving her enormous ass, sending viciously sharp sensations through your blood-engorged dick. Inch by inch you force your [pc.cock " + x + "] into her, her movements getting more frantic as you plumb her most lustful and forbidden hole.  Finally, you bottom out and stop for breath, her powerful, jiggling thighs pressing against yours.");
	//(if balls)
	if (pc.balls > 0) output("  Your [pc.balls] come to rest against her thick, wiggly rear.");
	output("\n\n");

	output("The harpy girl seems to freeze above you, wincing and trilling in pain. You are bordering on pain yourself; her crushing ass is so tight and so hot it nearly burns your [pc.cock " + x + "]! You smirk and raise your hand, before bringing it down onto her blubbery feminine rear.  With a loud, ringing slap, her ass jiggles as you scream \"<i>Giddy-up!</i>\"\n\n");

	//[(Males, no breasts)
	if (pc.biggestTitSize() < 1 && !pc.hasVagina()) {
		output("Her pupils constrict, and the feathery fat-reared fowl squawks loudly, going completely crazy atop you! She writhes and bounces this way and that, growing more and more desperate and insane as her pain increases.  Your [pc.cock " + x + "] slams this way and that into her rough, gripping walls, as moans and grunts escape your lips. She flaps frantically from side to side, almost slipping her clutching rump free of your [pc.cock " + x + "] before you grasp hard onto her meaty thighs, forcing yourself back into the distressed harpy with a lewd grin.  It is clear that some part of her is loving this brutal intrusion; her feminine fluids are spilling free, coating your torso with her strong scent.\n\n");
	}
	//[(Herms/Shemales) 
	else {
		output("Her pupils constrict, and the feathery fat-reared fowl squawks loudly, going completely crazy atop you! Struggling to escape from your impaling shaft, she drives her clutching, ribbed inner walls into the sides of your throbbing dick, her gelatinous ass wobbling this way and that");
		if (pc.biggestTitSize() >= 2) output(", the motions causing your " + pc.allBreastsDescript() + " to bounce and sway wildly, slapping into one another lewdly, adding to your growing lust");
		output(". You keep a firm grip on her rump and thighs, ensuring that every time she nearly wriggles her hot anus free of your cock, you can drive your hot meat straight back into her lush depths, laughing at her helplessness.");
		//(If herm)
		if (pc.isHerm()) {
			output("  Her struggles are driving you wild, and your [pc.vagina] is seeping fluids, growing more and more aroused as she bounces and slamming that immense, rippling rear into you, the force squishing your moist lips together, releasing yet more sticky juices and adding an extra little tone of pleasure.");
			//{(If balls)
			if (pc.balls > 0) output("  She even makes your [pc.balls] slap against your [pc.vagina], a hot, moist SPLAT accompanying every tiny motion the harpy makes.");
		}
		output("\n\n", false);
	}
	output("With an ear-splitting squawk, the impaled harpy's drooling pussy absolutely explodes.  It fires huge streams of her sticky feminine cum onto your ever-thrusting [pc.hips], her muscles locking in ecstasy, before the exhausted bird-girl collapses over you, ");
	//(if breasts)
	if (pc.biggestTitSize() >= 2) output("her chest mashing against yours as she becomes still, ");
	output("submitting to your will. Growling, you start to fuck her in earnest and grab a handful of her squishy rear in each hand, pounding her up and down on your [pc.cock " + x + "]. Though the harpy has collapsed, her body is still panicking, forcing her rough inner passage to clutch and massage your shaft, feeling harsh and grating, but oh-so wonderful! Pathetic squawks and trills of pain escape her golden lips as you roughly pound her tender ass, and her hips pound back against you, ass bouncing on your lap with a dull SLAP every time, which spatters pre-cum across your legs as well as her enormous thighs.\n\n");

	output("Throwing your head back and crying out in sheer lust-consumed ecstasy, you hilt your [pc.cock " + x + "] deep inside her thick, tight anus, releasing a flood of hot, sticky seed into her butt. The sudden surge of cum into her rough depths causes the exhausted harpy to tense up once more, and she releases a second, more pathetic wave of her fluids, a little less than last time. Her creamy feminine cum leaks out over your thighs as you lock with her. Your eyes roll back from the intensity of your orgasm, and you bite down on your bottom lip; for what seems like weeks you cum into her plump rump, her hands pressed on your chest as if trying to push you away. Eventually, your flow subsides, and the harpy collapses on top of you, sound asleep.\n\n", false);

	output("Still leaking seed, you pull free of her gaping ass, and dump the worthless bird-slut on the floor in a heap. Passed out and woefully exposed, her lush holes await whatever horny beast or demon will come alone after you.\n\n");

	pc.orgasm();
	processTime(30 + rand(10));
	CombatManager.genericVictory();
}


private function WinOnHarpyAndOralRape():void
{
	clearOutput();
	var x:Number = -1;
	if (pc.hasCock()) x = pc.cockThatFits(enemy.analCapacity());
	var y:Number = x + 1;
	if (y == x && pc.totalCocks() > 1) {
		//If second cock is out of bounds, choose one in bounds
		if (y >= pc.cocks.length) y -= 2;
	}

	output("You stand threateningly over the helpless harpy, stroking yourself through your [pc.gear] before grasping onto her chin, turning it this way and that, inspecting your prize thoroughly. Those golden lips glisten in the light as she trills feebly, her eyes looking soulfully up at you.\n\n");

	output("Grinning lewdly you squeeze her cheeks, the stricken harpy opening her mouth obediently. Her tongue is short and stubby like that of a normal bird, glistening with saliva and looking terribly inviting. You strip off the lower portion of your [pc.gear]");
	//(if pussy)
	if (pc.hasVagina()) {
		output(", fluids seeping from your plush [pc.vagina] all the while");
	}
	//(if cock)
	if (pc.hasCock()) {
		output(", ");
		if (pc.hasVagina()) output("and ");
		if (pc.totalCocks() > 1) output("each of ");
		output("your [pc.cocksLight] jumps to attention, throbbing and begging to be touched");
	}
	output(". Grasping onto the harpy's head-feathers, you lean down close and wrap your lips around her golden mouth, passionately driving your tongue into the wet opening.  You explore every little corner of her moist, tender orifice. Her tongue presses back against yours, tentatively at first");
	//(if boobs)
	if (pc.biggestTitSize() >= 2) output(", but soon she presses her toned, petite chest against your " + pc.allBreastsDescript() + ", that stubby tongue tangling around yours lustily.");
	else output(", but soon she is pressing against you, rubbing her toned body against yours, driving her tongue back against yours in a haze of lust, turning her head quickly and sharply, birdlike.");
	output("\n\n");

	//[(Male, shemale, herm, one cock)
	if (pc.cockTotal() == 1) {
		output("Breaking the kiss, your lips tingle sharply as you realize her golden lipstick is drugged! The heat flows to your groin, your [pc.cocksLight] swelling noticeably and growing even more sensitive.  Even the slightest breeze feels like a lover's hands passing across the tender flesh. Almost apologetically, the harpy leans in to wrap her hands around your [pc.cock] those drugged lips brushing sensuously across your cock-tip. Her beautifully formed hands give your shaft a squeeze, sending a wave of pleasure through you that brings you to your knees.  You throw both hands out behind you as you lean away from her, pushing your [pc.hips] towards her. The submissive bird-girl waggles her huge, jiggling ass behind her, softly guiding the very tip of your [pc.cock] between those tainted lips, that tingling sensation slipping down your hyper-sensitive member. Her mouth is warm, soft and suckling while her short tongue is flicking frantically across the underside of your shaft, the pleasure being harsh but oh-so intense.");
		//(if herm)
		if (pc.isHerm()) output("  Her expert fingers tease up the sides of your thighs, coming to softly brush across your moist nether lips, her fingers spreading your [pc.vagina] wide before plunging into the warmth within, adding another sweet sensation of pleasure to the amazing orchestra of sensations her lips were giving to you.");
		//(If balls) 
		if (pc.balls > 0) output("  Her hands creep down to softly squeeze and massage your [pc.balls], the harpy's eager head bobbing back and forth along the sweet tasting shaft of your [pc.cock], sending waves of powerful, overwhelming pleasure resonating through your body.");
		output("\n\n");
	}
	//[(Male, Shemale, Herm, multicock)
	else if (pc.cockTotal() > 1) {
		output("You break the kiss, the soft tingle lingering on your lips for longer than it should... much longer. Her golden lipstick is drugged! The tingle spreads over your whole body");
		//if breasts) 
		if (pc.biggestTitSize() >= 2) {
			output(", and your " + pc.allBreastsDescript() + " jiggle slightly from the sheer intensity of the pins-and-needles feeling coating your body.  Your [pc.nipples] perk up and harden.");
			if (pc.isLactating()) output("  Milk dribbles out gently onto the areola, trickling sensually between your cleavage.");
		}
		else output(".");
		output("  Surging down your body, an alien sensation focuses on your crotch, the pinpricks conglomerating on your [pc.cocksLight], and you fall to your knees, hunched over and quivering from the powerful orgasmic sensations. The big-bottomed harpy creeps forward on her knees; her eyes gaze expressively at your face. One arm reaches out to wrap her sweet hand around your [pc.cock]. As she pumps it gently, the pleasure is magnified tenfold by the lingering effects of those treacherous golden lips.");
		//(If balls)
		if (pc.balls > 0) output("  She moves that hand to softly squeeze and pet at your [pc.balls], massaging those bloated cum-factories with expertise. You can feel a distinct rumble as your [pc.sack] really ups its production, almost feeling heavier.");
		//(If herm)
		if (pc.isHerm()) output("  Her other perfect hand creeps beneath your tense [pc.cocksLight] to the [pc.vagina] that's nestled between your thighs. At the first touch of her hand, an explosive ecstasy shoots through you, forcing you to tense up and arch your back.  You grit your teeth while puissant waves of orgasmic glee flood through you.");
		output("\n\n");
	}
	//(Female) 
	if (pc.hasVagina() && !pc.isHerm()) {
		output("Tearing your lips away from hers, you feel a distinct, sharp tingle across your mouth and cheeks as you realized that her shining, gilded lipstick was drugged! The tingle spreads through your body, prickling across your whole body, flowing inexorably in a wave of sensation towards your groin, the ticklish feeling concentrating on your [pc.vagina]. You fall to your knees at the sheer unbridled pleasure shooting up and down your body, the thick hipped harpy crawling towards you meekly, applying a gentle pressure to your shoulder and pressing your back to the ground, trilling and squawking quietly, her perfectly formed hand reaching to your overwhelmed pussy. At the slightest first touch of her hand an explosive ecstasy shoots through you, forcing you to tense up and arch your back, teeth gritted. ");
		//(If breasts)
		if (pc.biggestTitSize() >= 2) output("You grasp onto your " + pc.allBreastsDescript() + " violently, kneading and tweaking your [pc.nipple] in a horny haze as the harpy's fingers tease around your pussy.  ");
		output("She parts your thighs gently, her eyes focused on yours as her hands come together to tease at your [pc.vagina], gently lowering her magnificently-plumed head to plant those drug-laced lips on your sweet, seeping pussy. Her stubby tongue tickles around your [pc.clit] before plunging hungrily into your warm depths. The heightened sensitivity of your [pc.vagina] means that every tiny flick of the bird's tongue coaxes a violent muscular spasm as you struggle to deal with the overwhelming sensations, her expert ministrations keeping you just on the edge of orgasm, but never driving you over the edge.\n\n");
	}
	//[(Male, Shemale, Herm, multicock, cont. from last paragraph)
	if (pc.cockTotal() > 1) {
		output("The harpy isn't finished yet; she grasps your [pc.cock] with one hand and takes your " + pc.cockDescript(1) + " in the other, pressing them against one another. Little pinpricks of pleasure course through your groin.  She forces both of those quivering cocks into her aphrodisiac-tainted lips, working them into her well-practiced throat. As the suction mashes them together pleasurably, her tight throat's grip on your dicks forces them to grind together. The feelings are just incredible, especially since her drugged lips are still forcing chemicals into your body, magnifying the intensity of the blissful sensations by the second.\n\n");
	}

	//(Male, Shemale, Herm, one cock)
	if (pc.cockTotal() == 1) {
		output("The horny harpy slips one hand between her fat thighs, digging her fingers into her plush, leaking pussy", false);
		//(if herm)
		if (pc.isHerm()) output(", her other hand doing the exact same to your own [pc.vagina], digging those perfect fingers deep into the wet, hyper-sensitive flesh, spreading those lips wide");
		output(".  Her mouth greedily gobbles up inch after inch of your [pc.cock], until at last she bottoms out, pressing her nose against your groin, those tainted lips tingling all the way down, increasing the intensity of the pleasure by the second. It takes a surprisingly short time of the harpy bobbing her head, that stubby tongue wetly caressing the sweet shaft of your [pc.cock], before you let out a vast, quaking moan, blasting a much larger load than normal into her gentle throat. She doesn't stop though, quite the opposite in fact, as her attentions to your dick became even more aggressive. Her submissive side all but vanishes as her golden lips brush up and down the hot shaft of that [pc.cock].  ");
		//(If balls) 
		if (pc.balls > 0 && pc.cocks[0].cLength() <= 16) output("She even deep throats you, taking your length into her expertly-controlled mouth, that tongue creeping out to tickle at your [pc.balls].  ");
		output("More slutty trills and squawks creep from her tainted lips, muffled by the girth of meat plugged so perfectly into her sucking, slurping mouth. For nearly an hour she keeps milking you of your seed, and you cum a full six times into her incredible mouth before she finally pops free, gasping for her breath with her fat, wobbling thighs coated in her feminine cum. How many times she orgasmed while giving herself to you was a mystery, but she bears down on you with a smile and a slightly-bulging belly. You flinch as she dives at your head, but it was merely to deliver a soft, drugged kiss to your forehead, which lulls you into sleep just as she turns on her heel and takes wing.\n\n");
	}
	//(Female)
	if (pc.hasVagina() && !pc.hasCock()) {
		output("Her approach changes quickly however, as her stubby tongue soon starts to flick rapidly across your [pc.clit] the shuddering, powerful sensations rendering you powerless on the ground before the horny harpy. More aphrodisiac slowly seeps into your body as you gasp, your hand reaching down to mash her finely-feathered face into your [pc.vagina], forcing the big-bottomed bird to probe deeper into your cunt. For an hour you keep her face buried between your thighs, your [pc.hips] raising and falling uncontrollably, her tongue thrashing around inside your lush depths more and more desperately, compelling you to cum over and over onto her beautiful face. For the final time you explode, releasing a massive load of sticky girl-cum onto her face before releasing her, the harpy recoiling. Her tongue licks its way across those golden lips, her pudgy thighs coated with her own cum. Your vision swims as you wonder whether this thick-hipped beauty came from the simple act of serving you so submissively, as she clambers over your body to plant a long, loving kiss on your lips, tangling her stumpy bird-tongue with yours as the last dose of those tainted lips slips into your brain, carrying you off to sleep. You are left with just one last glimpse of her fine, feathered ass before blacking out.\n\n");
	}

	//[(Male, herm, shemale, multi-dick)
	if (pc.cockTotal() > 1) {
		output("The lusty harpy continues to suck and swirl your cocks in her tight, hot mouth and throat, your [pc.cock] and " + pc.cockDescript(1) + " brushing across one another, lubricated by her slippery saliva. The pair of shafts stretch her jaw to the absolute limit, with ropes of pre-cum and saliva drooling from her golden lips");
		//(if balls)
		if (pc.balls > 0) output(", dribbling all over your [pc.sack]");
		output(".  You cum over and over again under the powerful ministrations of her drooling mouth, the horny harpy's tainted lips coaxing even more sticky seed out of you than usual.");
		//(If herm)
		if (pc.isHerm()) output("  Her fingers never stop their sweet teasing of your [pc.vagina], using all four fingers on her hand to plumb your velvet depths.");
		output("  For one last time, you feel the rising intensity of the pleasure, galloping headlong towards an explosive final orgasm.  Reaching down, you plant both your hands on the back of her head and violently thrust your [pc.hips] forward to cram the full length of your cocks into her gagging, clenching throat. A final detonation of seed escapes down her esophagus and into her already-swollen belly.  You shiver, biting on your lower lip, as your orgasm gradually subsides and you collapse backwards as your leg muscles give way, wrenching your [pc.cocksLight] away from the breathless bird-girl. Your vision becomes hazy as her beautiful face comes into view above you, descending to softly smooch across your lips, giving a last dose of those drugs into your brain. You black out, catching one final glimpse of her fine, feathered rear before you do.\n\n");
		//Apply harpy status.
		luststickApplication(8);
	}
	//monster.lust = 98;
	//monster.HP = 2;
	pc.lust(pc.lustMax(), true);
	//flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = monster.XP;
	pc.orgasm();
	pc.slowStatGain("l", 1);
	processTime(2 * 60 + rand(60));
	CombatManager.genericLoss();
}

private function harpyScissorSurprise():void
{
	clearOutput();
	output("You stare down at the defeated harpy, watching as ");
	if (enemy.HP() <= 1) output("her arms tremble from the effort of trying to keep her body from collapsing to the floor.");
	else output("she leans back from her kneeling position, spreading her legs and digging her fingers into her soaking cunt. Her other hand darts up to her ample bosom, giving it a hard squeeze before starting to tease her erect nipple, pinching and flicking as she continues to fingerfuck herself ever more forcefully.");
	output("  With no time to waste, you set about loosening your [pc.gear], nimble fingers quickly exposing your [pc.crotch] to the cool mountain air.  A gentle breeze catches your nethers and the sensation shoots a small shudder up your spine, alerting you as to how incredibly wet you are becoming at the sight of the ");
	if (enemy.HP() <= 1) output("vulnerable");
	else output("lust-mad");
	output(" harpy.");

	output("\n\nSliding one of your hands between your legs as you advance on the girl, you start preparing yourself for what's to come.  Your palm grinds against your mons as your fingers begin rubbing your glistening slit, smearing your copious juices over your crotch.  A deep moan escapes you as you tower over the Harpy, forcing you to withdraw your hand before you make yourself cum without even touching the girl.")
	if (pc.isHerm()) output("  However, before you fully remove it from your groin you quickly run your fingers up your engorged shaft, producing a spurt of pre-cum that splatters onto the harpy's chest.");

	output("\n\nShe looks up at you, eyes filled with ");
	if (enemy.HP() <= 1) output("worry");
	else output("desire");
	output(", but before she can even begin to talk you grab the mess of short hair atop her head and yank her forwards, roughly grinding her face into your soaked pussy");
	if (pc.isHerm()) output(", leaving your stiff cock resting on her head where the stimulation from her feathery hair causes it to steadily drip pre-cum down the back of her neck.");
	output("  She struggles furiously, her hands shooting up to your thighs as she tries to push away from your slick, aching entrance.  Your grip is far too strong and she's too exhausted from the fight though, and you demonstrate the pointlessness of her attempts at freedom by slowly dragging her face up and down against your [pc.vagina], smearing even more femcum over her increasingly distraught visage.");

	output("\n\nHer eyes are wide with fear at this point and you gaze into them unblinkingly, trying to force her to understand that the only way out of this is your way, so she'd better play along. She seems to get the message as her struggles lessen and her arms go limp, although her hands don't move from your thighs.  Happy to see her so eager to serve you, you thrust your hips forwards and pull her head back, making sure she can see both your face and your pussy");
	if (pc.isHerm()) output(", as well as your throbbing rod.");

	output("\n\n<i>\"Lick.\"</i>");

	output("\n\nThe girl can barely hold your gaze and tears start forming in her eyes, but like a good slut she does what she's told and you feel her short, powerful tongue reluctantly dart into your passage. Sighing, you lessen your grip on the girl's hair, but still guide her head as you try to get her probing tongue to hit all the best spots. Her tongue flicks at your clit as you grind her chin into your opening, before darting back down and driving itself between your engorged lips. She continues for a while, her chin quickly becoming a veritable waterfall from your arousal.");

	output("\n\nYou close your eyes, getting lost in the sensation of the harpy's deceptively skilled tongue.  Slipping a hand under your still-clothed upper body, you start to play with your tits as the harpy stops tongue-fucking your opening and instead starts to move higher, with almost no direction from yourself.  You tweak your nipple as the girl flicks her tongue over your throbbing clit, the double-pronged attack on your senses making you go weak from the waist down.  She continues to ravish your engorged button, sucking it, flicking it and even occasionally nipping at it gently, and it takes almost everything you have not to collapse down on your [pc.legs] and slam her face as hard as you can into your cunt.  It seems like she's trying her hardest to get you off quickly, so that she can escape before you doing anything else to her.");

	output("\n\nShe finally brings her mouth forwards, her lips meeting yours in an obscene parody of a kiss.  Her tongue starts sliding up and down your slit as she starts to play with your dripping sex.  She nibbles your lips, trying to do anything she can to make you cum, but you're able to hold yourself back - barely.  After a few moments, her efforts wane somewhat and you hear a slight whimpering from the submissive girl.  Pulling her head away from your crotch, you prepare to admonish her for slowing down when you were so close.  However, you see that the horny bitch has started to play with herself");
	if (enemy.lustQ() > 99) output(" again");
	output(", her fingers firmly stuffed down between her plush thighs and frantically toying with her pussy. Seeing her get off to your treatment almost makes you climax right then and there, but you manage to hold yourself back, reasoning that she hasn't quite paid enough just yet for deciding to attack you.");
	pc.lust(pc.lustMax(), true);
	clearMenu();
	addButton(0, "Next", harpyScissorSurprisePtII);
}

//{New page}
private function harpyScissorSurprisePtII():void
{
	clearOutput();
	output("Planting your [pc.foot] squarely on her chest you push her onto her back, her tongue still vainly lapping at the air in a lust-filled daze on the way down.  Before she has time to recover you remove the remainder of your [pc.gear] and grab her wrists, coming down on top of her and pinning her arms above her head as you straddle her");
	if (pc.isHerm()) output(", your cock resting on her toned stomach");
	output(".  Her tits heave gently as she squirms, desperately trying to stimulate her soaked pussy.  She starts to rub her legs together but you stop her almost immediately, grabbing a leg just above the talon with your free hand and yanking it away, revealing her obscenely puffy sex and drenched thighs.  She whimpers pathetically at you, virtually begging for release, the desperation and desire in her eyes clear to see.");

	output("\n\nGrinning at the girl, you shift so that your legs intertwine, steadying yourself as your crotch hovers above her own.  Your firm grip on her leg allows you to spread her thighs even further, your knee blocking her from closing her legs.  She's writhing madly by now, trying to break your grip and do something to quench the need between her legs, most of the feathers on her thighs having become a sodden mess.  Gently thrusting your hips, your slick lips brush tantalisingly across the harpy's own, drawing out a soft sigh from your own mouth and a gasp of pleasure from the other party.  Releasing her leg, you reposition it so that it is now trapped by your own. You move a hand to her breasts and start pinching and flicking the hard nubs of her nipples, teasing her with the lack of attention to her pussy.  She moans and quivers, clenching her teeth as she tries desperately not to cry out.  You move your hips again, putting a little more force behind it this time and fully grinding your crotches together.  The feeling of her wet lips slipping across your own, your stiff button bumping into hers, is overpowering.  You moan loudly, but it is completely muffled as your partner arches her back and cries out like the little slut she is, her body spasming wildly.  Was that all it took to push her over the edge?  Unluckily for her, you're not even close to finishing yet.");

	output("\n\nHer sensitive snatch is still quivering as you continue to slide against it, the small feathers on her thighs tickling your " + pc.skin() + " as you mash together faster and faster.[if (isHerm = true) \"  Your [pc.cock] bounces with each thrust that hits, the harpy's stomach with a sharp slap and spraying ropes of pre-cum over her, covering her abdomen and the bottom of her breasts with thick streaks of fluid.\"]  The harpy shudders with each long stroke of your hips and you lean forwards, lying your upper body down on top of hers and squashing your [pc.chest] against her own pert tits.[if (isHerm = true) \"  The move traps your throbbing [pc.cock] between your two taut, sweat-slicked bodies, the crushing sensation nearly making you peak.  You steel yourself though, your shaft instead releasing a veritable flood of pre-cum, the slick juice pooling in the harpy's bellybutton and making its way down the cleft of her pussy, soaking both the ground and your interlocked thighs even more.\"]  Your move the hand that had been playing with her nipples, sliding it sensually down her side, [if (isHerm = true) \"smearing some of the pre-cum leaking from between your bodies into the girl's skin as it goes, eventually \"]slipping around to her full asscheeks and squeezing one of the soft pillows roughly.  You start pulling her hips so they slam into yours in time with your own thrusts, relishing in the force of the contact between your two bodies, feeling the ripples of her luscious ass with each hit. Her heavy panting seems to get even more husky as your face gets closer to hers, hard nipples gently prod your boobs as her chest heaves with exertion. Her recent orgasm does little to help her body keep up with your savage assault.");

	output("\n\nFully aware of the threat of her lipstick, you avoid her gasping mouth and instead dip to her collarbone, nipping at her sweat slicked skin as you increase the speed of your hips, the sound of your twat slapping into hers echoing from the surrounding rocks.  Every time you connect, your lower body tenses with pleasure, bringing you closer and closer to your peak and triggering a low groan in your throat.  She bites her lip as you move your mouth to her jawline, biting and kissing along it as you move up to her pointed ear.  Her eyes are squeezed closed and you swear you can still hear her whimpering slightly over the moans that continue to force their way out of her throat, as well as the constant, wet slap of your bodies.  You suck on her earlobe slightly, teasing it with your teeth as you force yourself on her with ever increasing speed, pulling her into you more forcefully each time and digging your hand into her plush rear.  Your twats slap together with each thrust, lips obscenely mashing and slipping against one another, grinding slightly before you pull away again.  Every so often one of your clits will slide up the other's cleft, drenching it with fluid and drawing out a tortured screech from both of you.  Each time you pound into the girl below you another load of femcum spatters and leaks from both of your bodies onto the slick rock beneath, leaving thick streams of fluid running down both your bodies.[if (isHerm = true) \"  More pre leaks from your [pc.cock] as your bodies smack together around it, the soft, wet flesh milking your shaft for all it's worth. Every time you pull back, it aches from the lack of contact, throbbing painfully and drawing forth another glob of sticky wetness that adds to the mess on the stomach of the submissive bird-girl.\"]");

	output("\n\nYour clits grind against one another once again and she inhales sharply, her features broken out of their mask of dismay and quickly changing to one of pure orgasmic rapture.  Lightning ignites your nerves and your sex bristles with need, the relentless pace of your hips barely able to keep the inferno burning within you in check.  Your body forces out a strangled moan, which you ensure that she hears in utmost detail, licking around her ear as your draw out the low, pleasure-filled sound.  You feel your orgasm building and withdraw your tongue, whispering to her.");

	output("\n\n\"<i>I'm glad I found such an accommodating little slut, it's always nice when they're more concerned about getting off than winning fights.  I'm pretty sure that this is exactly what you wanted, considering how much you <b>aren't</b> fighting back.  I'll remember to look you up if I'm ever back in the neighbourhood and need a good fuck.</i>\"");

	output("\n\nHer eyes shoot open as your last line sinks in and you see her pupils are tiny.  Seems like you managed to intimidate the poor girl a bit.  Maybe you should do something to make it up to her and help her relax?  You stop slamming your hips into her, starting instead to grind against her dripping undercarriage, ensuring your button bumps against hers as often as possible.  At the same time, you release her arms and relocate your hand to her unoccupied asscheek, pulling her against you as tightly as possible, attempting to get as much friction on your slippery pussies as you can.  You notice that she doesn't even try to move her arms, leaving them lying limply above her head.  From her face, it looks as though she's too lost in the sensations of you fucking her to even care.  Her eyes are wide, staring off into the open, empty sky and her tongue sticks slightly out of her mouth.  Each movement between your pussies brings a sultry moan from her, any attempts to hide the pleasure she's getting from being used long gone.[if (isHerm = true) \"  Your cock feels as though it's fucking the harpy itself, trapped between two shifting layers of tight, wet muscle.\"]  You grind against her, wiggling her ass to make sure she hits all your needy spots as you trail your lips down her neck, kissing and nipping your way to her modest rack.  You run your tongue around one of her nipples, teasing it before you take it into your mouth and begin to suck.  Her breaths become even more rapid as you play with her, moving your head in time with the shuddering rise and fall of her chest.");

	output("\n\nAfter a few minutes of grinding your cunts together, the feelings become too much.  Squeezing her ass hard enough to leave handprints, you slam into her again as hard as you can, femcum splattering everywhere with each echoing slap.  You bite down on her stiff nipple before mashing her pussy to yours as you reach your peak, holding it there in an iron grip.  She screams again, body going wild with pleasure as she comes for the second time.");

	output("\n\nHer thrashing finally sends you over the edge, your twat spasming uncontrollably and gushing all over hers, which responds in kind.[if (isHerm = true) \"  At the same time, your shaft quakes painfully, before finally releasing its long pent-up load.  Your cum drenches the space between your bodies, soaking both of your bellies ans well as painting the underside of your breasts a soft, sticky white.\"]  You release her tit, instead pushing your head into her cleavage and crying out as your bodies shake with the force of your violent orgasms.[if (isHerm = true)   Another spurt of cum shoots out of you, accidentally giving you a surprise facial.]  The feeling of your cunts quivering against one another is incredible, it feels as though every nerve ending in your sex is alight and hyper-sensitive.  Your clit stays in contact with hers as you both come, quivering against one another and sending you both into a second orgasm.  The harpy is squealing at this point, her arms still limp above her head, but her face is contorted as she rides out what must be one of the most powerful orgasms she's ever had.  You piston her into you as you finish peaking, trying desperately to prolong the pleasure for as long as possible.  Each time her pussy connects with yours, another jolt of ecstasy shoots through you, but it diminishes with every hit.  The harpy cries out weakly with each thrust, her body simply too sensitive to withstand such treatment.");

	output("\n\nEventually, your body too drained to continue, you stop and release the harpy's cheeks, letting her ass drop back down onto the drenched rock.  You pant heavily, lying back and giving yourself a few minutes to recover before disentangling from her body.  Your strength slowly returns to you and you start to don your armor once more, readying yourself for the trip back to camp.  You're glad you didn't leave your [pc.gear] too close, considering how wet the floor managed to become during your interlude.  It seems as though it'll still get drenched though, considering how your thighs are soaked and your pussy[if (isHerm = true)  and your slightly sore cock] still oozes copiously from the ridiculously energetic session, but apparently it was all too much for the harpy who has now curled up and started snoring gently on the rocky ground.  Her lower body is utterly soaked, the feathers matted together with your shared juices, and her rear still has bright red handprints where you were holding her as you rode out your climax.[if (isHerm = true)   Her tits are also covered with fluid, white jizz starting to drip its way down her body towards the already overwhelming puddle of femspunk on the floor.]  You even catch a glimpse of her pussy between her thick thighs, smirking at how it continues to quiver and leak slightly, still enjoying the aftershocks of her last climax.");

	output("\n\nYou smile to yourself as you grab a few gems from the slumbering girl, making a mental note to visit the mountains again sometime.\n\n");
	pc.orgasm();
	processTime(40 + rand(10));
	CombatManager.genericVictory();
}

//private function spoidahsLegEggsInHarpeis():void
//{
	//clearOutput();
	////requires spiderbite or naga bite
	//output("Perched above the downed bird-bitch, you look her over as you weigh up your options.  Your eyes slide across her petite breasts, tracing her curves until your gaze rests upon her flared hips and curvaceous ass.  Unfortunately your appreciation of the finer things in life is interrupted by the feather-brained eyecandy; she simply will not stop squawking.");
//
	//output("\n\nYou watch her golden-hued lips move, though every bit of noise that escapes them just heightens your irritation a little more.  The sight of her lipstick as it catches the light makes you wonder; the harpies use drug-laced cosmetics to catch potential mates.  Without males, the eggs they lay will never hatch.");
//
	//output("\n\nEggs...");
//
	//output("\n\nYour brain strings all of your problems and irritations together, and produces a wonderfully clever solution.");
//
	//output("\n\nDrawing a bit of webbing into your hands, you step up to the screeching harpy and silence her with a question.  \"<i>How would you like a kiss?</i>\"");
//
	//output("\n\nThe feather-clad girl quiets down immediately, eyes alight, and she gives you a wide smile, thinking she's found an easy way out of her current predicament.");
//
	//output("\n\nShe manages to stand up, and hops a step closer, an action that sends a tantalizing jiggle through her expansive behind.  She leans ");
	//if (pc.tallness > 78) output("up");
	//else if (pc.tallness == 78) output("forward");
	//else output("down");
	//output(", eyes closed and lips puckered seductively, ready to deliver a heady dose of her drugged lipstick.");
//
	//output("\n\nHer eyes snap open in panic as you plaster the webbing across her mouth, sealing it with your sticky secretion.  You easily catch her hands with your own before she can grab at the impromptu gag, and the muffled sounds of her displeasure are music to your ears.  She squirms in your grasp as you pull her close, and give her the promised kisses, brushing your lips across her gag.  Your lips progress across her forehead, her cheeks, down the soft curve of her neck, and over her collar.  She hasn't stopped her struggling, but both the slick sound of her thick thighs grinding together and the hard points of her nipples pressing against your chest show that she isn't entirely opposed to it anymore.");
//
	//output("\n\nHer stifled moans take on a sensual note, and you hold her even tighter and whisper into her ear, informing your taloned captive that she's not the only one with a trick up her sleeve.  She grinds into you anyway, as you nip at her pointed ear before trailing kisses down her neck.  As you reach her nape again, you open your mouth wide and sink your fangs into her sweet flesh.  Held securely against you, she's helpless to do anything other than twitch and moan as you pump your venom into her veins.  Her head lolls to the side, her breathing gets heavy and a blush spreads its way across her entire body as the lust-inducing poison burns through her.");
//
	//output("\n\nReleasing her as you pull free, she collapses nervelessly to the ground, limbs limp and eyes unfocused.  Taking her chin in your hands, you tilt her head until her gaze meets yours, and smile as sweetly as you can, asking if she would like to get off.  The harpy's pleading eyes say all you need, and you cut away her web-gag, telling her that if she can present herself appropriately, and tell you what it is she wants, of course you'd be more than happy to give it to her.");
//
	//if (pc.gender > 0) {
		//output("\n\nLeaning back onto your spider-half, you idly run your hands across ");
		//if (pc.hasCock()) output("[pc.eachCock]");
		//if (pc.hasVagina() && pc.hasCock()) output(" and ");
		//if (pc.hasVagina()) output(" your [pc.vagina]");
		//output(", enjoying the view.");
	//}
//
	//output("\n\nIt takes the feathered slut a few tries to stand up.  Her first attempt goes awry immediately; the sensation of her thighs rubbing together sets her off, and she tumbles back down, squirting thick girlcum over her already soaked legs.  She finally manages to get herself upright, panting so heavily with lust that, for a moment, she reminds you more of a dog than a bird.  She staggers over to a nearby boulder and leans heavily into it, spreading her cushiony cheeks wide, presenting herself to you.");
//
	//output("\n\nYou have to admit, the sight of a lust-drunk harpy, moaning into a boulder with her dripping box revealed for the world to see is even better than you thought it would be.  You can feel your pulse rising as your ovipositor slips free of its chitinous hideaway, already drooling copious amounts of lube in preparation for the fun to come.  Licking your lips, you advance on the moaning harpy, propping yourself up on the boulder with a few of your spindly arachnid legs, letting your thick egg-chute slap wetly onto her plump ass.  She bucks her hips immediately, grinding herself against you, whimpering in relief at the unspoken promise of respite your ovipositor provides.  Standing immobile above her, you watch with amusement as her desperation increases, giggling as she plants both hands against the stone, working your lube-leaking rod between her wide buns in a frantic attempt to get you to start moving.");
//
	//output("\n\nYou casually shift a pair of your plated legs, pinning her hands against the rock before you lean down.  One hand runs through her feathery hair, while the other cups her chin, insistently drawing her eyes to meet your own.  You smile serenely as she mewls beneath you, practically in tears with desperate desire.");
//
	//output("\n\nYou calmly, smoothly remind her that she still hasn't let you know what it is she wants.");
//
	//output("\n\nThe harpy's mouth works open, silently forming shapes and pleas, but all she manages is a whispery croak.  Shutting her eyes tight, she swallows hard before opening them again, and looking into your composed face.");
//
	//output("\n\nHer face glowing with the heat of her craving, you almost confuse her passion-fueled plea for the quiet hiss of the wind over the cliffs, but the words are unmistakable.");
//
	//output("\n\n\"<i>Please... Fill me...</i>\"");
//
	//output("\n\nSmiling all the while, you slide your stiffening rod into her sopping cunt, piercing all the way to her core, your easy thrust pushing her face up against the stone.");
//
	//output("\n\nThe cross-eyed look of ecstasy on your bird-slut's face is more than worth the price of admission, her tongue drooping from her open mouth as she issues an utterly satisfied moan.  She comes again, just as freely as the first time, her burning walls clenching around you as her strength leaves her for the second time, held up only by her pinned hands and your thick ovipositor.  Bracing yourself above her, you begin to rhythmically thrust into her, pounding away at her juicy snatch, your free-flowing lube squirting out with every motion, an emerald puddle forming beneath you.");
//
	//output("\n\nYour breath catches in your throat as you feel the first of many eggs begin to work its way down your ovipositor, and you drive yourself as far into her as she can handle, causing another orgasm in the overstimulated harpy, lubrication spraying across your chitinous underside.  She delivers a single pitiful squawk as your egg slides easily into her womb, followed by a long moan as your pulsing egg-tube pushes a second, third, fourth...");
//
	//output("\n\nFinally relieved of your uncountable eggs, you pull out of your surrogate, ovipositor retracting, and watch as she slowly slides down the boulder face; she comes to rest on her knees, feathered arms wrapping around her swollen midsection.  The harpy looks back at you, her eyelids drooping as her breathing slows, and you lean in to give her a quick kiss on the cheek before you suit up and head back to camp.");
//
	//pc.dumpEggs();
	//pc.orgasm();
	//cleanupAfterCombat();
//}

//Fuck a harpy with the players throbbing clit.
private function clitFuckAHarpy():void
{
	clearOutput();
	output("Eyeing the hapless bird-woman up and down, you feel your lusts kindling.  Moisture seeps from your [pc.vagina] as you watch the harpy ");
	if (enemy.lustQ() > 99) output("moan and masturbate, dipping her fingers into her honey-pot with wild abandon.");
	else output("moan and struggle to rise, jiggling in the cutest way each time she slumps down, defeated.");
	output("  You wrench her thick thighs apart to get a better view of her avian snatch.  Her lips are shrouded in a downy, feathery fuzz, but you can easily make out the heavy, lust-glossed labia.  The thought of tasting her dripping honey makes your mouth water and inside your [pc.gear], your [pc.clit] has emerged from its hood, straining as blood rushes to your loins.   The sensitive organ is so swollen that it's more lady-cock than joy-buzzer, the thick hood resembling an animal's sheath more than a natural flesh fold.");
	output("\n\nThe harpy stops her struggles when she sees you smiling at her.  \"<i>Are you gonna make me lick your pussy or somethin',</i>\" she quips, folding her arms across her modest, barely B-cup breasts.  Her eyebrows knit together while she glowers in your direction, one leg still pulled into the air by your rushing passions.");
	output("\n\nYou drop her taloned toes to the side and slowly remove your [pc.gear], forcing the harpy to watch and wait.  You expose your [pc.chest] and puffy nipples first, shimmying from side to side as you wiggle out of your bottoms, pivoting to shake your [pc.butt] while your rigid clit is freed from confinement.  When you turn back around and nearly bop her on the nose with your [pc.clit], the bird-girl's surprise is complete.  To your amusement, she spends a full ten seconds just staring at it, half in surprise and half in disbelief. You break her reverie by smearing it across her lips, gathering some of the trademark harpy lip-gloss upon your faux girlcock.");
	output("\n\nThe drugged make-up makes your clit-dick tingle wonderfully, and once you have it gilt in gold, you ask the bird-bitch if she's figured out what you intend yet.  She dumbly shakes her head, lust-dazed and confused.  Her feathers work lamely behind her she marvels at your unusual endowment, eventually daring to touch it with one of her feather-clad hands.  You nearly drop from the sensation.  It may be as big as a dick, but your [pc.clit] is a far more sensitive organ, and it feels even better than usual with that drugged lip-gloss slathered on.");
	output("\n\nSmiling mischievously, your fallen foe dares to tease, \"<i>I've never seen a girl with a dick growing out of her vagina before.  Does it feel like fucking yourself when it gets hard?</i>\"");
	output("\n\nYou roll the cheeky chick over none-too-gently with a [foot], ruffling quite a few feathers in the process.  She squawks in dismay at your rough handling, but endures the dismissive treatment regardless.  Her tailfeathers fluff up and down as she tries to catch her balance, eventually pulling herself up on all fours, and you're given the perfect view of the harpy's plump rump.  She has wide, strong hips to match her gorgeous rump, cheeks jiggling softly whenever she makes a move.  In between, you can see the harpy's glimmering vulva and winking star tempting you.");
	output("\n\nSinking your fingers into her fleshy backside- that posterior promised land- you pull her closer, sliding your slick girl-buzzer through the enveloping buttcheeks for a quick grind.  Her soft cheeks squish from a fleshy crevasse to a swaddling sheath, encircling your girth. You ride the harpy's delightfully wobbling ass, squeezing the rippling curves into a cunt-tight embrace with your hands while you gleefully hump her heart-shaped bottom like you were breaking in a fresh sex-toy.  Delicate feminine fingers with well-manicured nails thumb through your [pc.vagina] shortly after, lubricated with another woman's juices.  The harpy's hand slides back and forth through the twin twats, knuckles tickling over her clit and your base, fingernails teasing the flowering folds of your labias, digits probing the tightening wetness of both passages.  She's stopped fighting against your lascivious attentions, at last.  She seems to have given in completely: her every effort seems dedicated to getting you both off.");
	output("\n\nYou pull out and release the gelatinous backside, tiring of the foreplay.  It wobbles dangerously, the crack and cheeks gilded with leftover gold that rubbed off your [pc.clit].  The feathery rump waves back and forth as the harpy jills herself off, oblivious to the respite. As you watch that hypnotizing ass, you know you're going to have to fuck this girl until she can't walk.");
	output("\n\nLunging forward, you grab hold of the thick-hipped harlot and aim your [pc.clit] for her velvet-rimmed muff.  Your aim is true, and you slide right in, displacing probing fingers as you go.  It feels so good that your [pc.legs] do give out this time, but you merely fall forward, simply flopping against your victim's prodigious backside.  Your [pc.nipples] dig into her wings and the feathers tickle your face, but she proves adequate leverage for your pleasure-blasted body to continue its assault.  Once you adjust to the tingling bliss radiating into your [pc.vagina], you grab hold of your ruffled avian friend by her tits, shamelessly groping the palm-sized orbs as your [pc.hips] begin to thrusting in shallow, gradual motions, sinking deeper and deeper by the moment.");
	output("\n\nNow [pc.clit]-deep in bird-pussy, you let your body fuck in autopilot, a bestial urgency giving ferocity to your motions.  Barely conscious of your movements, you slam your [pc.hips] against that glorious butt again and again.  Ripples of kinetic energy bounce through each cheek with every impact, short gasps of excitement soon slipping from both of you, high pitched and needy.  You bite your lip to keep from screaming, focusing yourself on the pulsing heat and nether-drenching moisture of your feathered clit-sock.");
	if (pc.wetness() < 3) output("  Runnels of your lubricant are dripping down your [pc.legs] in streams,");
	else if (pc.wetness() < 4) output("  Streams of lubricant are soaking down your [pc.legs] in waves,");
	else output("  Squirts of lubricant are gushing down your [pc.legs] to puddle on the floor,");
	output(" evidence of just how hungry your clenching, empty hole is.");
	output("\n\nThe harpy is primarily focused on fondling her own lil' button, but she strokes the base of your girlish dipstick from time to time in her tight, rapid vibrations.  She squawks again, a high pitched trill that rings in your ears, and her pussy clenches vice-tight around your [pc.clit].  The harpy is cumming; the tight, squeezing motions of her glittering, gold-painted cunt push you past your limits.  Your tongue lolls out while your hips twitch atop the fat-bottomed slut, pumping your over-sensitive rod in and out of the clutching channel with wild abandon.");
	if (pc.wetness() < 3) output("  A fresh gush of fluid washes out of your pussy at the peak of your pleasure even though you're far from a squirter");
	else if (pc.wetness() < 4) output("  A fresh spout of girlspunk washes out of your pussy at the peak of your pleasure");
	else output("  A torrential splash of girlspunk shoots out of your pussy in a river at the peak of your pleasure");
	output(", timed with a full-body seizure that causes you and your partner to slump down into sticky pile.");
	output("\n\nSmiling drunkenly, the harpy manages to roll you onto your back.  Thus positioned, you're mounted, [pc.clit] deep in harpy muff.  The sodden feathers that ring her snatch stick to your abs as she grinds on you, and soon, the two of you are shuddering and shaking through another explosive orgasm.  This time, you bear the brunt of feminine splashes, stained with fragrant harpy honey.  Spent after the double-orgasm, you feel your clit begin to retract.  The harpy frowns at this and kisses you, planting a warm, wet kiss square on your lips.  The effect is immediate.  A sizzling bolt of lust hits your clit and fills it to full hardness, shockingly erect and aching slightly after all the sex.");
	output("\n\n\"<i>Another round?</i>\" she asks, rolling to be back on the bottom.  As horny as that kiss made you?  You're more than ready for another round.");
	output("\n\nYou and the bird-brained bimbo fuck for the better part of an hour.  Through countless quim-clenching orgasms you soldier on until at last");
	if (pc.WQ() / 20 + rand(20) < 6) {
		output(" your endurance gives out, and you slip into unconsciousness.  This time it seems you met your sexual match.");
		//monster.lust = 98;
		//monster.HP = 2;
		pc.lust(pc.lustMax(), true);
		//flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = monster.XP;
		//cleanupAfterCombat();
		pc.orgasm();
		//dynStats("lib", .5, "sen", -1);
		pc.slowStatGain("l", 0.5);
		processTime(60 * 2 + rand(60));
		CombatManager.genericLoss();
	}
	else {
		output(" the harpy's eyes close, and she slips into unconsciousness.  You give her round bottom a little pat before you depart, still shivering from the cascades of pleasure it brought you.");
		pc.orgasm();
		//dynStats("sen", -1);
		processTime(40 + rand(20));
		CombatManager.genericVictory();
	}
}