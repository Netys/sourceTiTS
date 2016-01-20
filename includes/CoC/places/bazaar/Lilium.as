import classes.Characters.CoC.CoCImp;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//I dunno about the term 'satanic streetwalker', and it
//probably needs to increment your corruption if you're fucking
//a proper demon. -Z

//Notes: Requires just a penis, penis and long demonic tongue 
//or a vagina. There's a couple of small conditionals to stop 
//references to legs for nagas so it's ok for them, but it 
//doesn't really make sense for centaurs.

//Vars:
//267 Times Bought Smexin'

public function showLilium():void
{
	//spriteSelect(93);
	//userInterface.showBust("LILIUM");
	if(Flag("COC.UNKNOWN_FLAG_NUMBER_00267") == 0) userInterface.showName("\nDEMON");
	else userInterface.showName("\nLILIUM");
}

//#########AREA TEXT#########
public function LiliumText(display:Boolean = false):Function {
	if(hours < 17 && hours > 5) return null;
	if(display) {
		//Before paying:
		if(Flag("COC.UNKNOWN_FLAG_NUMBER_00267") == 0) output("\n\nYou can see a pale, scantily clad demon woman leaning casually against the wall of a building.");
		//After paying:
		else output("\n\nYou can see Lilium standing in her usual spot.");
	}
	return approachLilium;
}

private function approachLilium():void {
	clearOutput();
	showLilium();
	var pay:Function = null;
	//#########FIRST TIME INTRODUCTION#########
	if(Flag("COC.UNKNOWN_FLAG_NUMBER_00267") == 0) {
		output("As you approach the demon woman, her gaze shifts to you, and she runs her eyes down your body, scrutinizing you.  You respond in kind, taking in her form.  Two nearly foot-long horns grow up and out of her forehead, one of which is adorned with a shiny, silver band.  Her dark hair spills across her bare shoulders in loose coils and her black lipstick and heavy eyeshadow contrast with the paleness of her skin.  A black underbust corset wraps around her waist, leaving her breasts exposed, and long black gloves adorn her arms up to the shoulder.  She also wears a crinoline skirt with an opening at the front which reveals her smooth bare legs, a tail which wraps around her thigh like a garter, and her crotch, which sports an average cock curiously clad in a lacy sock in spite of her otherwise brazen exposure.\n\n");

		output("Her assessment of you seems to be positive, as a smile crosses her face and she says, \"<i>You look like you've got more than a few gems to rub together; looking for a little fun?</i>\"\n\n");

		output("Of <i>course</i> that would be why she's standing there dressed like that.\n\n");

		output("\"<i>25 gems and I'm all yours,</i>\" she continues, sweeping her arms out wide for emphasis.\n\n");
	}
	//#########REPEAT INTRODUCTION#########
	else {
		output("Lilium stands before you.  Her two nearly foot-long horns grow up and out of her forehead, one of which is adorned with a shiny, silver band.  Her dark hair spills across her bare shoulders in loose coils and her black lipstick and heavy eyeshadow contrast with the paleness of her skin.  A black underbust corset wraps around her waist, leaving her breasts exposed and long black gloves cling to her arms up to her shoulders.  She also wears a crinoline skirt with an opening at the front which reveals her smooth bare legs, a tail which wraps around her thigh like a garter, and her crotch which sports her average cock curiously clad in her lacy cock sock in spite of her otherwise brazen exposure.\n\n");

		output("\"<i>Back again?  I thought I was finally rid of you!</i>\"  Lilium teases, but you can see the eager smile on her face.  \"<i>Is this visit business or pleasure?  I'm hoping both.</i>\"\n\n");
	}
	
	processTime(2);
	clearMenu();
	
	if (pc.credits >= 250) addButton(0, "Pay", payForLilium);
	else addDisabledButton(0, "Pay", "Pay", "You can't afford this.");
	
	addButton(14, "Leave", leaveLilium);
}


private function payForLilium():void {
	clearOutput();
	showLilium();
	//#########GENDERLESS SCENE######### REQUIRES unsexed (hah)
	if(!pc.hasGenitals()) {
		output("You follow Lilium to a secluded spot. With a grin on her face she squats before you and helps you remove your [pc.gear].  The grin is quickly replaced by a look of surprise and confusion as she looks at your flat, featureless crotch.\n\n");

		output("She looks up at you and then back at your groin a few times before scratching her head and crossing her arms.  \"<i>Well,</i>\" she begins, breaking the awkward silence.  \"<i>That's not something you see every day.  Did you get in an accident or something?  I mean, I've seen people with missing parts before, but...</i>\"  The woman trails off as she lightly prods your bare mons with one gloved finger.  \"<i>Actually, you know what?  I really don't think I want to know what could have done this to you.</i>\" With that she stands back up, grabs one of your arms and drops the small pouch of gems containing your payment to her back in your hand.\n\n");

		output("\"<i>Look, I'm sorry, but I can't really do anything for you right now.  If your, uh, situation changes, come see me again.</i>\"  Lilium then walks off, leaving you alone and naked.\n\n");

		output("Bummer.");
		
		processTime(4);
		clearMenu();
		addButton(0, "Next", enterTheBazaar);
		return;
	}
	//First time - Pay: 
	if(Flag("COC.UNKNOWN_FLAG_NUMBER_00267") == 0) {
		output("\"<i>Sounds good,</i>\" you answer while fishing for your gem stash.\n\n");
	
		output("\"<i>I'm Lilium, by the way,</i>\" she states, as you give the woman your name and your payment in return.\n\n");
	
		//(If player name is also Lilium)
		if(pc.short == "Lilium") output("\"<i>No way!</i>\" she cries upon learning of your identical name.  \"<i>Well... I hope you're not going to ask me to scream your name during sex.  That might be a bit awkward.</i>\"\n\nHow do you want to have the whore?\n\n");
		
		output("What will you do with her?");
	}
	else {
		output("You toss the gems to the hooker and while she counts them, you wonder just what you want her to do this time.");
	}	
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00267");
	showLilium();
	pc.credits -= 250;
	//statScreenRefresh();
	//Sex Menu here
	
	processTime(2);
	
	clearMenu();
	addDisabledButton(0, "Buttfuck", "Buttfuck", "This scene requires you to have cock and long tongue.");
	addDisabledButton(1, "Ride Her", "Ride Her", "This scene requires you to have vagina.");
	addDisabledButton(2, "Nipple-Fuck", "Nipple-Fuck", "This scene requires you to have cock.");
	
	if (pc.hasCock() && pc.hasTongueFlag(GLOBAL.FLAG_LONG)) addButton(0, "Buttfuck", buttFuckTongueJeorb);
	if (pc.hasVagina()) addButton(1, "Ride Her", liliumDickRidah);
	if (pc.hasCock()) addButton(2, "Nipple-Fuck", liliumNippleFuck);
}

//- Leave:
private function leaveLilium():void {
	clearOutput();
	showLilium();
	if(Flag("COC.UNKNOWN_FLAG_NUMBER_00267") == 0) output("\"<i>I'm deathly allergic to fun, unfortunately,</i>\" you reply before moving on to examine more of the bazaar.");
	else output("\"<i>Just passing through, and I thought I'd see how you were doing,</i>\" you reply, and leave Lilium alone at her post.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", enterTheBazaar);
}

//#########BUTTFUCK + TONGUEJOB SCENE######### REQUIRES PENIS AND LONG DEMONIC TONGUE
private function buttFuckTongueJeorb():void {
	clearOutput();
	showLilium();
	var x:Number = pc.cockThatFits(40);
	if(x < 0) x = 0;
	output("The two of you find a secluded alley between two buildings.  Lilium removes her corset and skirt before moving to help you remove your [pc.gear].\n\n");
	
	output("Squatting before you, she traces a single gloved finger along the underside of your [pc.cock " + x + "], teasing it until it grows to its full " + Math.round(pc.cocks[x].cLength()) + "-inch length.  Once your maleness has sprung to life, she turns around and bends over to brace herself against the wall before looking back over her shoulder at you mischievously and giving her hips a little wiggle.  Taking position behind her, you slide your [pc.cock " + x + "] between her soft thighs.");
	//(If player cock length > 8 inches)
	if(pc.cocks[x].cLength() > 8) output("  You can feel Lilium's smaller cock resting atop your [pc.cock " + x + "].");
	output("  With each thrust you can feel more and more feminine lube coating your shaft as you glide across Lilium's labia, her dick stiffening with arousal.\n\n");

	output("One last time, you slowly draw your [pc.cock " + x + "] from between her thighs and let it flop against her lower back, your hands moving from Lilium's hips to her pearlescent ass cheeks.  Spreading her wide, you let your [pc.cock " + x + "] gradually inch down the cleft between them until the head rests against her back entrance.  With an agonizing slowness you begin to push.  The faintest gasps escape Lilium's lips as her ass finally envelops the head of your cock, followed by a squeak of surprise as you suddenly drive the remaining length in; the force of your [pc.hips] meeting her ass pushes her entirely up against the wall.\n\n");
	
	output("Your lips part slightly as you let your tongue begin to extend.  It journeys around Lilium's trim waist and down across her taut tummy until it finds its target: her turgid penis.  Your long tongue wraps around her shaft tightly and as its tip meets her tip you can taste the pre-cum leaking through her perfumed cock sock.  You begin to massage the unholy herm's cock by flexing your tongue as you speed up your thrusts into her round ass.\n\n");
	
	output("You establish a rhythm of pleasuring Lilium from both sides; thrust in, flex tongue, pull out, release and soon she begins pushing her hips back in time to meet you on every thrust.");
	//(If player has breasts)
	if(pc.biggestTitSize() >= 1) {
		output("  A tingle emanates from your [pc.nipples] as your [pc.fullChest] slide across her sweat-slicked back with every thrust.");
		//(If player has a lot of milk)
		if(pc.isLactating()) output("  The stream of milk that leaves your breasts each time you press your body against Lilium's adds further lubrication between you.");
	}
	output("\n\n");
	
	output("The pace of Lilium's breathing quickens and soon she begins to shudder as her cock throbs within your tongue's grasp.  Jets of the satanic streetwalker's cum shoot out against the tip of the sock and she lets out a moan of contentment.  Her internal muscles clench down on your shaft as she ejaculates, causing a wave of goose bumps to cover your body which signals your own impending orgasm.  Your knees buckle and tongue loses its grip on her sock; the wet fabric flies off her cock with her next spurt, hitting the ground with a tiny 'plap'.  The tingling across your body focuses itself in on the base of your [pc.cock " + x + "], and you grab the root of Lilium's demonic tail for more leverage, pulling her roughly against you as you grunt loudly, the proof of your pleasure exploding into her bubble butt.  This final thrust forces an extra gout of cum from her cock, which then leaks down its tongue prison, giving you a last taste of her fluids.\n\n");

	output("Panting, Lilium grabs your hands and moves them around her waist, holding them against her stomach.  ");
	//(If naga body)
	if(pc.isNaga()) output("As you both stand there, reeling in the wake of your ecstasy, she leans back against you causing you to flop onto your [pc.ass] with the demon girl on top of you; you haven't the strength to remain standing.");
	//(else) 
	else output("As you both stand there, reeling in the wake of your ecstasy, she leans back against you causing you to flop onto your [pc.ass] with the demon girl on top of you; your wobbling legs have temporarily lost the strength to keep you both upright.");
	output("  Lilium lets out a laugh and soon you find yourself laughing with her.\n\n");
	
	output("After you both recover, you get up to don your [pc.gear], thanking Lilium and beginning the trip back to camp.  Maybe you'll take a bath too...");
	
	pc.orgasm();
	pc.cor(1);
	processTime(18);
	clearMenu();
	addButton(0, "Next", enterTheBazaar);
}

//#########DICK RIDE SCENE######### REQUIRES VAGINA
private function liliumDickRidah():void {
	clearOutput();
	showLilium();
	output("Lilium takes you to a secluded spot away from the Bazaar.  She removes her corset and skirt and slips the lacy cock sock off her cock and you eagerly remove your own [pc.gear].\n\n");

	output("You gently push Lilium down onto her back and straddle her waist.  As she looks up at you with a demure expression you move your hands to her pert breasts and begin a slow circular massage of her chest.  With each pass you ever so slightly lighten your grip and move your fingers closer to her nipples until finally you are lightly trailing your index fingers around their rosy tips.  You can see Lilium's eyes close as she enjoys your touch on her body.  Gently you slip just the very tip of one finger into each of her fuckable nips and the woman beneath you arches her back, seeking to force your fingers into her heaving breasts further.  With a grin you tear your fingers away from her breasts and Lilium's eyes snap open and a look of disappointment crosses her face.  Quickly you lean down and plant a kiss on her dark, pouting lips, letting your tongue slip between them just the slightest bit to taste her.\n\n");

	output("Slowly you begin moving down Lilium's body.  You leave a trail of kisses down her neck before running your tongue along her collar bone.  Further down you go, letting your lips gently slide down the center of the demon herm's chest until you reach her navel.  ");
	//(if player has long hair)
	if(pc.hairLength >= 15) output("You can feel Lilium shudder slightly beneath you as your hair tickles her nipples.  ");
	output("First you begin to circle her navel with the tip of your tongue, following up with long licks beginning at the base of her belly and trailing up and into her belly button. Lilium's breathing begins to quicken and her hips start to dart back and forth beneath you as you continue to tongue her navel. As you become more conscious of the hardened cock poking into your own chest you draw your head back, leaving a long shiny strand of saliva that joins your mouth to her smooth tummy.\n\n");

	output("You draw yourself up and position yourself above Lilium's twitching cock.  Your fingers part the lips of your [pc.vagina] which are slick with your own arousal.  ");
	//(If virgin/tight)
	if(pc.vaginalCapacity() < 25) output("Gingerly you lower yourself down onto Lilium's cock, your breath tight in your chest as the head strains against your moist inner walls.  Each inch is easier than the last and soon you release a long slow exhale as your crotch meets hers and the pleasurable feeling of fullness washes over you.  ");
	//(if loose or produce lots of lube)
	else output("Without a second thought you plunge yourself down on Lilium's fuckrod, your [pc.ass] jiggling from the sudden impact.  ");
	output("You pull yourself up until only the head of the demon girl's dick remains within you, before sliding back down to let her fill you again.  Up and down you bounce on top of her, your speed and force increasing with every stroke.  You let out a contented half moan, half grunt each time your [pc.hips] collide with hers as her stiff cock stimulates your insides.  Lilium's own search for more pleasure brings her hands to her breasts and she begins to finger-fuck her nipples.  Before long she has two and then three fingers furiously plunging in and out of her gaping nipplecunts and you can see her eyes rolled back in her head as her mouth hangs open in testament to the excitement flowing through her body.");
	pc.cuntChange(0,14,true,true,false);
	output("\n\n");

	//(if player has breasts)
	if(pc.biggestTitSize() >= 1) {
		output("You turn your attention to your own [pc.fullChest] and how they bounce from the force of your vigorous fucking, supporting the weight of your " + pc.breastDescript(0) + " with your hands as you continue to ride Lilium's cock.");
		//(if demonic tongue)
		if (pc.hasTongueFlag(GLOBAL.FLAG_LONG)) output("  Letting your long tongue extend out from between your lips, you wrap it around one [pc.nipple] and gently squeeze, sending an electric thrill that flows to your core and back out to the tips of your fingers.");
		//(else if no demonic tongue)
		else output("  You begin to squeeze your [pc.nipple] between two fingers, sending an electric thrill that flows to your core and back out to the tips of your fingers.");
		//(if lactating a little)
		
		if(pc.isLactating() && pc.milkQ() > 100 && pc.milkQ() < 500) output("  A small stream of milk leaks out and dribbles over your tongue, giving you a taste of your own fluids.");
		//(else if lactating a lot)
		else if(pc.isLactating() && pc.milkQ() >= 500) output("  A powerful stream of milk fires out of your [pc.nipple], coating Lilium's flat stomach.");
		output("\n\n");
	}

	output("With several fingers still inside her nipples, Lilium bites her lip and forcefully pushes her breasts together as her hips begin bucking to meet your own [pc.hips].  Seeing that her orgasm is near, you begin flexing your internal muscles in addition to pumping up and down on her cock.  With a sudden burst of movement that surprises you, Lilium tears her hands from her breasts and roughly grabs your [pc.ass], her fingers digging into your buttcheeks as she attempts to hold you down tight upon her.  Her eyes bulge wide and she lets out a loud cry as you feel her pump load after load of demonic cum into you, flooding your [pc.vagina].  Lilium drops her arms to her sides with eyes half-lidded as she pants heavily.\n\n");

	output("Not finished with her yet, you draw yourself up off her wilting willy, clenching your lower muscles to keep as much of her cum inside you as possible as you flip yourself around and position your body above her face.  Lilium quickly catches on to what you're doing and you think you can see her gulp nervously as you lower your cum-stuffed pussy to her mouth.  Rolling your [pc.hips] back and forth you begin grinding your [pc.vagina] into the demon woman's face as her tongue worms and tickles inside you, beginning its task of cleaning out the remnants of her ecstasy from your love hole.  While Lilium's tongue gently strokes your insides with lips occasionally sucking gently on your labia, you turn your attention to your clit.  ");
	//(if little clit)
	if(pc.clitLength < 2) output("With one finger you begin to knead your [pc.clit], which instantly increases the pleasure emanating from your lower body.");
	//(else if big clit)
	else output("Tenderly grasping it between your fingers you begin to rub your [pc.clit] from base to tip, each stroke adding a wave of pleasure to that of the tongue treatment your [pc.vagina] is receiving.");
	output("  The tingle of pleasure across your body begins to strengthen and you grind your crotch into your demon lover's face that little bit harder, trying to get yourself over the edge; suddenly you feel a burst of electricity inside you.  Your muscles all contract, your arms pull tight to your body and you collapse inwards, on top of Lilium as the pulses of pleasure shoot out across your body.  The tingles in your [pc.nipple], your [pc.clit], your insides and out, through your arms and " + pc.legs() + ", reach a fever pitch and you let out a short, strained squeak through gritted teeth to voice your pleasure.\n\n");

	output("Exhausted, you flop to the side, leaving you lying supine beside Lilium.  You turn your head to look at her and she tilts her own head to meet your gaze.  You can see a similar look of contented exhaustion on her face, although you're fairly sure you lack the mix of cum and feminine lube and the smeared makeup.\n\n");

	output("After a moment of recovery time you get up to get dressed before starting your journey back to camp.  \"<i>Don't be a stranger, now,</i>\" calls the voice over your shoulder. A slight smile appears on your face.\n\n");

	pc.orgasm();
	pc.cor(1);
	//(imp preg check)
	//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14, 61); //Lilium causes faster pregnancies
	pc.loadInCunt(new CoCImp());
	processTime(25);
	clearMenu();
	addButton(0, "Next", enterTheBazaar);
}

//#########NIPPLE FUCK SCENE######### REQUIRES PENIS
private function liliumNippleFuck():void {
	var x:Number = pc.cockThatFits(40);
	if(x < 0) x = 0;
	
	clearOutput();
	showLilium();
	
	output("Lilium takes you to a secluded spot in the Bazaar for you to be able to enjoy each other's company. She kneels down before you and you strip out of your [pc.gear], baring your naked body before her.\n\n");

	output("Lilium begins to gently rub her palms against the side of your flacid cock.  As it begins to harden in her hands she leans in close, letting it grow stiff against her soft cheek.  You feel her wet tongue against the base of your [pc.cock " + x + "] before it begins sliding along the underside of your cock as Lilium licks the length of your maleness right to the tip.  ");
	//(If cock is pierced)
	if(pc.cocks[x].pierced > 0) output("You can feel a slight bump as her tongue passes over each piercing and she gives the head of your cock a flick with the tip of her tongue as she reaches the end.  ");
	//(else)
	else output("As her tongue reaches the end of its journey she gives the head of your [pc.cock " + x + "] a little flick with the tip of her tongue.  ");
	output("Taking one black tress in hand she draws it slowly across your glans, sending a shiver down your spine. Taking obvious delight in your reaction she starts brushing the lock of plush hair up and down your shaft.  You can see her bring her free hand up to her breast as she continues to tickle your [pc.cock " + x + "] with the soft strands of hair.  At first she cups and massages the pale flesh slightly, before slipping a finger inside her rosy nipplecunt.  She bites down on her lip as she begins working the finger in and out.\n\n");

	output("Not content with just the teasing Lilium continues to give your [pc.cock " + x + "], you grab her shoulders and push her back against the wall, the shock of which causes her finger to come free of her nipple.  With one hand you line the head of your [pc.cock " + x + "] up with the now dripping entrance to her breast and drive forward.  There is a slight resistance at first, but then Lilium coos as you overcome it and her breast envelops you.  Her boobs are sadly not large enough to take you to the hilt, but pumping part of your shaft in and out of her chest is pleasurable all the same. The soft flesh mound distorts as you fuck it, stretching out as you draw back and squishing together as you thrust in.  Lilium's eyes unfocus and she begins to pant louder and louder as you fuck her breast.\n\n");

	var doubleNipFuck:Boolean = false;
	//(if multicock)
	if(pc.cockTotal() >= 2) {
		doubleNipFuck = true;
		output("Thinking it unfair that just one of her breasts receives your attention, you grab another of your [pc.cocksLight] and unceremoniously jam it into Lilium's lonely nipple-cunt, causing her to let out a loud squeal from the extra penetration.  The extra purchase on Lilium's body from both your cocks now being inside her breasts causes the demon's body to rock back and forth vigorously with each of your thrusts.  You move yourself backwards slightly, pulling her with you away from the wall to avoid concussing her.  When you resume your thrusts you can hear her moans warble as her body rocks with yours.\n\n");
		doubleNipFuck = true;
	}
	//(else if demon/naga tail)
	else if(pc.hasTailCock() || pc.isNaga()) {
		output("Thinking it unfair that just one of her breasts receives your attention, you draw your [pc.tail] up and unceremoniously jam it into Lilium's lonely nipple-cunt, causing her to let out a loud squeal from the extra penetration.  The extra purchase on Lilium's body from both your cock and your tail now being inside her breasts causes the demon's body to rock back and forth vigorously with each of your thrusts.  You move yourself backwards slightly, pulling her with you away from the wall to avoid concussing her.  When you resume your thrusts you can hear her moans warble as her body rocks with yours.\n\n");
	}
	
	output("Giving up trying to steady herself, Lilium brings her hands to her own cock and begins to stroke and massage it in time with you.  The wet shlicks and pops of you fucking Lilium's dripping nipple");
	if(doubleNipFuck) output("s");
	output(" and the soft sound of her stroking her dick combine with your grunts and her moans to form a sexual chorus in this isolated part of the Bazaar.  Soon you feel the familiar pressure building in your loins and you speed up your thrusts; with one great, final effort you drive as far into Lilium's tit");
	if(doubleNipFuck) output("s");
	output(" as you can.  A wave of ecstasy washes over you from your head to ");
	if(pc.hasTail()) output("your tail");
	else output("your " + pc.feet());
	output(" as you cum");
	if(pc.cockTotal() > 2) output(", your unused cocks drenching her with seed");
	output(".  The tightness of her ");
	if(doubleNipFuck) output("nipple-cunts around your twin cocks causes some of your cum to squirt back out of her nipples");
	else output("nipple-cunt around your cock causes some of your cum to squirt back out of her nipple");
	output(" each time you fire another load into her, the balance leaking down on Lilium's stomach and thighs.");
	if(pc.cumQ() >= 700 && pc.cockTotal() > 1) output("Rivers and rivers of cum pour out of your cocks, distending her nipple-holes as the backflow gushes from around the heads.");
	output("\n\n");

	output("The sensation of you pulling out of her fuck-able nipple");
	if(doubleNipFuck) output("s");
	output(" drives Lilium herself over the edge, causing jets of her own cum to explode out of her cock.  The outline of the spurt is visible in the end of the lacy sock for a moment; it bulges and drips obscenely as she fills it up, squeezing her cock and letting out a loud cry in pleasure.  As she kneels before you panting, cum dripping from her gaping nipple");
	if(doubleNipFuck) output("s");
	output(" and soaked sock, you brush a wayward strand of hair from her face.  Her eyes make their way up to meet yours and you give her a wink as you both smile lasciviously.\n\n");

	output("You get dressed again and begin to leave; as you look back over shoulder, Lilium - still seated and leaning against the wall - blows you a kiss.");
	pc.orgasm();
	processTime(25);
	clearMenu();
	addButton(0, "Next", enterTheBazaar);
}