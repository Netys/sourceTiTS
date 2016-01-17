import classes.Characters.CoC.CoCSecretarialSuccubus;
import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Succubus Secretary
private function DemonFactoryTalkSuccubus():void {
	//spriteSelect(55);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("\"<i>I suppose I really should thank you for coming down all by your lonesome.  The boss is gonna be sooo happy we found you.  Just think, in an hour or two we can get you strapped in and working with the others,</i>\"  says the secretarial succubus as she saunters over, still sipping her coffee, \"<i>You're so cute!  I tell you what, if you agree to come with me, I'll, like, make sure the experience is pleasurable.</i>\"\n\n");
	output("She runs a stocking covered foot up your leg and thigh, almost to your groin.  Giggling, the succubus pulls it away and asks, \"<i>So are you ready and willing?</i>\"");
	
	addButton(0, "For what?", DemonFactoryTalkSuccubusForWhat);
	addButton(1, "Yes", DemonFactoryTalkSuccubusYes);
	addButton(2, "No", DemonFactoryTalkSuccubusNo);
	return;
}

private function DemonFactoryTalkSuccubusForWhat():void {
	//spriteSelect(55);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("The succubus looks at you with a bemused expression, \"<i>You haven't figured it out yet?  Really?  What do you think we make at this factory, bubble-gum?</i>\" she asks with a cruel smile, \"<i>We take human and once-human champions like you, pump you full of aphrodisiacs, body-altering drugs, and corrupting agents, and then milk you of your tainted fluids continually for the rest of your life!  And don't even start to ask why, I'll tell you – there are still pockets of purity out there that repel cute demons like me.  So the best way to deal with those is just to release a river of drug-filled sex-juice at them.  By the time the area dries off, the locals welcome us with open arms... and spread legs.</i>\"");
	
	addButton(0, "Sick!", DemonFactoryTalkSuccubusNo);
	addButton(1, "Sounds Fun", DemonFactoryTalkSuccubusYes);
}

private function DemonFactoryTalkSuccubusItsMe():void {
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("You laugh mockingly at the stupid demon, roaring, \"<i>I'm the bloody champion you vapid cunt!</i>\"\n\nShe whirls, her beautiful face marred by rage.  It looks like you have a fight on your hands...");
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCSecretarialSuccubus());
	CombatManager.victoryScene(DemonFactorySuccubusDefeated);
	CombatManager.lossScene(DemonFactorySuccubusWon);
	CombatManager.displayLocation("SUCCUBUS");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

private function DemonFactoryTalkSuccubusYes():void {
	////spriteSelect(55);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("The blue skinned seductress steps forward and wraps her arms around you, pulling your head down and crushing it into her heavenly breasts as she speaks, \"<i>My my, aren't you the kinky little play-toy.  Let's get you hooked up.</i>\"\n\n");
	output("She catches you off-guard, lifting your feet off the ground.  You realize she has somehow grown taller.  You stretch to see what's going on, but have no leverage to pry your face from the smooth globes of flesh that smother you.   Vaguely, the click-clack of heels reaches you through the walls of flesh.  You're being moved deeper into the facility.   A creaky door opens, allowing you to hear the loud humming of machinery, mixed with what sounds like desperate sexual moans.\n\n");
	output("Abruptly you are pulled free from the succubus' fleshy prison and bodily thrown into padded restraints.  Blinded by the sudden onslaught of light, you blink away tears as restraints are placed securely around your wrists.  Warm lips press against your own as a foreign tongue penetrates your lips, mouth-raping you.  It tastes of sweet exotic spices, like nothing you've ever had before.   Helpless to do anything but return the kiss, you respond, sliding your tongue along the slippery sweetness of your captor's.  You risk opening your eyes and see your inhuman captor to be enjoying the kiss every bit as much as you.");
	
	addButton(0, "Next", DemonFactoryDoBadEndSuccubusPart1);
}

private function DemonFactoryTalkSuccubusNo():void {
	//spriteSelect(55);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("She frowns, \"<i>I was secretly hoping you would say that... I'm going to make you beg me to hook you into the machines.  Just wait.</i>\"");
	
	addButton(0, "Next", DemonFactoryDoFightSuccubus);
}

private function DemonFactoryGoDemon():void {
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("Advancing slowly, the succubus gives you a hungry look.  She extends a hand, allowing her fingers to lengthen into razor-sharp claws.  With a single expert slash, she cuts away everything holding together your [pc.gear].  They fall into a discarded pile, already forgotten as your ");
	//[genderless]
	if(!pc.hasGenitals()) {
		output("entire body blushes read before the sexy seductress.  She looks at you, frowning as she murmers, \"<i>Now this just won't do.  You look more like a " + pc.mf("boy", "girl") + " to me, so why don't I make the plumbing match the exterior?</i>\"\n\n");  
		output("Her palm caresses your crotch, stoking the warmth inside you until it blazes white-hot with new sensation.  Your skin ripples and parts, ");
		if(pc.mf("boy", "girl") == "boy") {
			output("pushed apart the thick flesh of a powerful demonic member, complete with two swollen balls.");
			pc.createCock(10);
			pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			pc.balls = 2;
			pc.ballSizeRaw = 3;
		}
		else {
			output("gushing with fluids as it shapes itself into a hungry demonic cunt.");  
			pc.createVagina();
			pc.vaginas[0].wetness(3, true);
		}
		output("\n\n\"<i>Much better,</i>\" the demon coos, licking her lips as your ");
	}
	
	//[male]
	if(pc.hasCock() && !pc.hasVagina()) {
		//Multispoooooo
		if(pc.cockTotal() > 1) {
			output("[pc.cocks] pulsate, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your [pc.cocksLight] seem to follow her, twitching and thickening any time she takes a step closer.\n\n");
			output("She reaches out, cupping the underside of a shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your [pc.cock] already has.</i>\"\n\n");
			output("You glance down, seeing just how hard her words have made you.  You squirm your [pc.hips] pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ");
			if(pc.balls > 0) output("your [pc.balls] and ");
			output("the bases of your [pc.cocksLight].\n\n");
			output("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n");
			output("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cocks, as if possessed, angle themselves upward towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n");
			output("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your [pc.cock] tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your [pc.cocksLight].  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n");
			output("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n");
			output("You moan pitifully, begging for her to remove it and allow you to cum.\n\n");
			output("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n");
			output("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n");
			output("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your [pc.cock] empties, you feel drained and strangely energized at the same time, and your entire torso is spattered with rapidly hardening pink crystals.\n\n");
			output("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n");
			output("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, yours was potent!</i>\"\n\n");
			output("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ");
			if (pc.hasKeyItem("Marae's Lethicite"))
				output("gather some yourself at the next opportunity...");
			else
				output("devour Marae's as soon as you get a chance.");
			output("You greedily gather up the lethicite splattered on your body and devour it, turning it into raw demonic power.  You really do need to get more of this... but first you know a certain demoness you intend to wrap around your ");
			if(pc.cockTotal(GLOBAL.TYPE_DEMONIC) > 0) output("growing");
			else output("new");
			output(" demon-cock for a few more orgasms.");
			
			for (var i:int = 0; i < pc.cocks.length; i++) 
				if (pc.cocks[i].cType != GLOBAL.TYPE_DEMONIC) pc.shiftCock(i, GLOBAL.TYPE_DEMONIC);
		}
		//SINGLEZ NITE
		else {
			output("[pc.cock] pulsates, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your [pc.cock] seems to follow her, twitching and thickening anytime she takes a step closer.\n\n");
			output("She reaches out, cupping the underside of the shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your [pc.cock] already has.</i>\"\n\n");
			output("You glance down, seeing just how hard her words have made you.  You squirm your [pc.hips] pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ");
			if(pc.balls > 0) output("your [pc.balls] and ");
			output("the base of your [pc.cock].\n\n");
			output("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n");
			output("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cock, as if possessed, angles itself upwards towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n");
			output("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your [pc.cock] tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your [pc.cock].  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n");
			output("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n");
			output("You moan pitifully, begging for her to remove it and allow you to cum.\n\n");
			output("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n");
			output("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n");
			output("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your [pc.cock] empties, you feel drained and strangely energized at the same time.\n\n");
			output("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n");
			output("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm your's was potent!</i>\"\n\n");
			output("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ");
			if (pc.hasKeyItem("Marae's Lethicite")) output("gather some yourself at the next opportunity...");
			else output("devour Marae's as soon as you get a chance.");
			output("  But first you know a certain demoness you intend to wrap around your ");
			if(pc.cockTotal(GLOBAL.TYPE_DEMONIC) > 0) output("growing");
			else {
				output("new");
				pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			}
			output(" demon-cock for a few more orgasms.");
		}
	}
	//[female]
	else if(pc.hasVagina() && !pc.hasCock()) {
		output("[pc.vagina] grows wet and ready, practically juicing itself as the demoness' hand caresses your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until all your humanity drips out?</i>\"\n\n");
		output("The words make you blush hard, shaming you and stoking the growing fire between your [pc.legs].  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your [pc.legs] spread.  \"<i>There,</i>\" she comments, \"<i>now your juicy snatch is on display, just like you've always wanted.</i>\"\n\n");
		output("She effortlessly swings her lissomelegs onto the table as she pulls herself up, mounting you as a man might.  You can feel waves of heat rolling off her sex, bathing your own slit in her warmth.  ");
		if(pc.clitLength >= 2) output("Your [pc.clit] pushes free, nuzzling against her hairless cunt and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your [pc.clit], fucking and grinding against it.  ");
		else output("She lowers herself down, rubbing smooth hairless netherlips over you, smearing you with her fragrant demon-honey.  You feel her clit grinding on your own, drawing out gasps of delight from both of your mouths as she relentlessly scissors against you.  ", false);
		output("In no time flat you feel your climax building.  Your [pc.vagina] quivers and grows wetter in anticipation.  Tugging on your aching [pc.nipples] and aching for release, you squirm under your demonic mistress, smashing your [pc.vagina] against her in a lewd attempt to find your orgasm.  It does not happen, and you moan in disappointment as the pleasure continues to build, oblivious to your desire for orgasm.\n\n");
		output("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n");
		output("You moan pitifully, begging for her to remove it and allow you to cum.\n\n");
		output("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, oh I don't know, the focused remains of your soul and humanity.  Now you think on that while I grind away any remaining doubts you might have.</i>\"\n\n");
		output("The beautiful succubus on top of you picks up the pace, grinding harder against your [pc.vagina] and [pc.clit], pushing you beyond anything you've ever felt before.  She leans down over you, licking her lips to reveal an inhumanly long tongue.  It snakes down, curving around you [pc.fullChest] before it arches up to flick a [pc.nipple].  ");
		if(pc.hasFuckableNipples() && pc.biggestTitSize() > 2) output("You gasp as the tongue slides inside each of your breasts, violating them in turn thanks to your strange anatomy.\n\n");
		else output("You gasp as it curls around each of your [pc.nipples] in turn, tugging them lewdly.\n\n");  
		output("She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you find yourself craving release, and over time you cave in further and further to the need.  You start to feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, and this need for release.  The block shatters, melting away under the force of your need as you explosively orgasm.\n\n"); 
		output("Sparkling pink fluid splatters between the two of you as you cum, squirting hard");
		if (pc.vaginas[0].wetness() < 4) output(" for the first time");
		pc.vaginas[0].wetness(5, true);
		output(".  The succubus throws back her head and lets loose a moan of ecstasy, her entire body shivering with your own as both of your heads fill with fireworks of pleasure.  Nervelessly, she rolls off of you, her tail contracting hard around your leg while the two of you share the moment.\n\n");
		output("The succubus interrupts your delight by recovering far faster than you, rolling up to a standing position and watching something between your legs.  You prop yourself up on your elbows to see what the fuss is about.  Between your legs something curious is happening – a trickle of pinkish fluid is still escaping your nethers, rolling towards a rapidly expanding pool, along with every other drop of the pink goop.  Before your very eyes the pool grows until every drop of pink fluid has collected together, and it grows upwards, solidifying into a sparkling crystalline shape.\n\n");
		output("Before you can react, she grasps the newly-formed lethicite and noisily begins eating it, her eyes glowing with newfound power.  Watching her makes you more than a little jealous and angry with yourself.  You should've taken the lethicite and gained its power!  No use fretting about it, you can still fuck this succubus for a few hours before you go out in search of your own victims...\n\n");
	}
	//[HERM ENDING]
	else {
		//Buh.  Zombie fen need brains.
		output("[pc.cocks] and [pc.vagina] grow wet and ready, both starting to leak fluids as the succubus' hand traces your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  And that throbbing cock!  How obscene!  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until your humanity is splattered between my legs?</i>\"\n\n");
		output("The words make you blush hard, shaming you and stoking the growing fire between your legs.  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your legs spread.  \"<i>There,</i>\" she comments, \"<i>now all of your fun-parts are on display.  Maybe I should call in an incubus and a few imps to watch.  I bet you'd like that wouldn't you?</i>\"\n\n");
		output("She effortlessly swings her lissomelegs onto the table as she pulls herself up, mounting you in a single swift motion.  You can feel waves of heat rolling off her sex, bathing your [pc.cock] in her warmth.  ");
		if(pc.clitLength >= 2) output("Your [pc.clit] pushes free, nuzzling against her tight asshole and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your [pc.clit], fucking her ass and grinding against it.");
		else output("She lowers herself down, rubbing smooth hairless netherlips over your crotch and vulva, smearing you with her fragrant demon-honey.  You feel her clit grinding on your belly, drawing out gasps of delight from both of your mouths as she relentlessly works her body against your own.");
		output("\n\nMarvelous heat and wetness wraps your [pc.cock] tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be cumming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by something deep inside you, pushing away your release and hiding it somewhere inaccessible.\n\n");
		output("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n");
		output("You moan pitifully, begging for her to remove it and allow you to cum.\n\n");
		output("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n");
		output("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  Eventually, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n");
		output("A look of shock and pleasure spreads over the succubus' face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your [pc.cock] empties, you feel drained and strangely energized at the same time.\n\n");
		output("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n");
		output("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, your's was soooo potent!</i>\"\n\n");
		output("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with her new-found power.  You resolve to ");
		if (pc.hasKeyItem("Marae's Lethicite")) output("gather some yourself at the next opportunity...");
		else output("devour Marae's as soon as you get a chance.");
		output("  But first you know a certain demoness you intend to wrap around your ");
		if(pc.hasCock(GLOBAL.TYPE_DEMONIC)) output("growing");
		else output("new");
		output(" demon-cock for a few more orgasms.");
		output("  Before you get into that, you spy a small piece of pink crystal on the floor between your legs.  You snatch it and devour it before the succubus has a chance and eat it, turning part of your soul into new-found demonic strength before you return to a long night of sex...");
	}
	pc.orgasm();
	//dynStats("str", 2, "tou", 2, "spe", 2, "int", 2, "lib", 2, "sen", 2, "cor", 100);
	pc.cor(100);
	doNext(DemonFactoryBadEndDemon);
}

private function DemonFactoryBadEndDemon():void {
	clearOutput();
	if(pc.hasCock() && !pc.hasVagina()) output("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion.");
	else if(!pc.hasCock() && pc.hasVagina()) output("Now a full-fledged demon, you leave the factory, setting off on your own.  Over the next year you capture many foolish mortals, and even convince more than a few of them to give up their souls.  With your rapid gain in power, it's easy to rise in the demonic ranks, and in no time flat your power far exceeds that of the succubus that 'turned' you.  You live in luxury, surrounded by a harem of slaves, waiting in your camp for the next victim to step through...");
	else output("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion. It should be quite satisfying...");
	badEnd();
}

private function DemonFactoryDoFightSuccubus():void {
	//spriteSelect(55);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("\"<i>You're going down!</i>\" you yell at her as you ready your [pc.mainWeapon]! \n\nAn unseen force closes the door, preventing you from running away. \n\nIt's a fight!")
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCSecretarialSuccubus());
	CombatManager.victoryScene(DemonFactorySuccubusDefeated);
	CombatManager.lossScene(DemonFactorySuccubusWon);
	CombatManager.displayLocation("SUCCUBUS");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function DemonFactoryDoRapeSuccubus():void {
	//pc.slimeFeed();
	clearOutput();
	//MALE
	if(pc.hasCock() && (!pc.hasVagina() || rand(2))) {
		//(LUSTY) 
		if(enemy.LQ() > 99) output("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your [pc.gear] are on the floor and you approach your prize.\n\n"); 
		//(HP) 
		else output("The succubus collapses on the floor, groaning in pain.  Most of her clothes have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.\n\n");
		//START ZE RAEP CANNONZ
		output("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ");
		if(pc.hairLength > enemy.hairLength) output("lengthens");
		else output("shortens");
		output(", shifting to [pc.hairColor].  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your [pc.cock] is as hard as a rock.\n\n");
		output("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your [pc.cock] and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your [pc.cock], perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your [pc.cock] gets harder and harder as it grows slightly beyond its normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.\n\n"); 
		//((TOO BIG))
		var x:int = pc.cockThatFits(enemy.vaginalCapacity());
		if(x == -1) {
			output("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.\n\n");
			output("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your [pc.cock] drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your [pc.hip] back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.\n\n");
			pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			//[normal]
			if(pc.cumQ() < 50) output("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your [pc.hips] continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.\n\n"); 
			//[high]
			if(pc.cumQ() >= 50 && pc.cumQ() < 500) {
				output("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ");
				if(pc.balls > 0) output("Your [pc.balls] practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ", false);  
				output("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.\n\n");
			}
			//[ultrahigh]
			if(pc.cumQ() >= 500) {
				output("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your [pc.cock] flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured [pc.cock] overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your [pc.cock] forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ");
				if(pc.balls > 0) output("Your [pc.balls] twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ");
				output("\n\nLike a perverted version of the wave, the nodules along your length fill with blood, doubling in size along your length as a massive bulge of cum rushes out your urethra.  Black cream drizzles from the tiny growths as the first blast of cum passes into your dick's crown moments before erupting like a volcano.  One second the sexy female version of you is moaning like a whore and licking her lips. The next she is sputtering and gasping as a half-gallon of inky black cum soaks her from head to tits.  Heedless of her discomfort, your legs keep sawing your [pc.cock] deeper into this perfect titfuck as more thick bulges of tainted spunk begin to stretch your urethra on their way out.  You babble incoherently as your cock's tip plants itself against her open lips, blasting even more spunk directly into her waiting gullet.  Her cheeks bulge comically as the stuff drips from her nose, but somehow she manages to swallow the bulk of it, her hands vigorously milking your [pc.cock] with her fuck-bags.  By the time the third jet of cum erupts, she's unhinged her jaw and somehow taken the head into her mouth, giving unfettered access to pump her belly full of your black jism.  You groan with uncontrollable pleasure as her belly fills with spunk.  Her eyes roll back as the next blasts expand her belly further, at first making her look slightly pregnant and then gradually stretching her belly until she looks like she could have minotaur twins.  You lose count of how much cum you put into her, but eventually she can take no more and your cock is pushed free by the pressure, splattering her face again.  Far from finished, you blast cum over her face as you realize she's lost consciousness; her eyes are totally rolled back and her tongue lolls from her mouth like that of a sleeping bitch.  Eventually your orgasm winds down, but not before leaving her in a 4 inch deep puddle of spunk, looking like more like a blue balloon full of dark water than woman.\n\n"); 
			}
			output("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...\n\n\nHours later you pull away, sated.  For now.");
		}
		//((IT FITS))
		else {
			output("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ");
			if(pc.balls > 0) output("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ");
			output("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ");
			if(pc.biggestTitSize() > 0) output("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"");
			//New PG
			output("\n\n");
			pc.shiftCock(x, GLOBAL.TYPE_DEMONIC);
			output("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ");  
			output("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.");
			//New PG
			output("Each of the new bumps and rounded spines of your [pc.cock " + x + "] flood with blood, doubling in size as orgasm overtakes you.  ");
			output("Your hips bury your entire length inside her, acting on their own as your [pc.cock " + x + "] clenches, pouring more and more spunk inside her");
			if(pc.balls > 0) output(" as your balls empty their load queue");
			output(".  ");
			//Big cum
			if(pc.cumQ() >= 50 && pc.cumQ() < 400) output("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.  ");
			//((Ginormohuge)) 
			if(pc.cumQ() >= 400) output("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.");
			output("\n\nYou pant with exertion and pull back, only to have your [pc.cock " + x + "] plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.\n\n\nHours later you pull away, sated.  For now."); 
		}
		output("\n\nThe succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out the door, disappearing.\n\n");
		pc.orgasm();
		pc.cor(5);
		
		CombatManager.genericVictory();
		processTime(90);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
	//FEMSAUCE
	else {
		if(enemy.HP() <= 1) output("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes, leaving only the damaged stockings that gird her legs. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.\n\n");
		else output("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes, leaving her wearing only the remains of her stockings as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.\n\n");
		output("Her budding clit rises from between her folds, hardening like a tiny three inch dick.\n\n");
		if(pc.isLactating()) {
			output("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>");
			
			processTime(3);
			clearMenu();
			addButton(0, "Scissor", DemonFactoryDoScissorSuccubus);
			addButton(1, "Force Feed", DemonFactoryDoForcefeedSuccubus);
		}
		//No choices if not lactating...
		else {
			DemonFactoryDoScissorSuccubus();
		}
	}
}
public function DemonFactoryDoScissorSuccubus():void {
	clearOutput();
	
	output("You shiver with anticipation as you hook your leg under her thick thighs, lining up your [pc.vagina] as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own [pc.clit] erecting and rubbing against her smooth mound.\n\n");
	if(pc.clitLength >= 3) output("You groan with wanton desire as your [pc.clit] continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ");
	output("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with her's, eliciting pants and squeals from the both of you.  In no time flat, you find yourself cumming and feel your [pc.vagina]'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your [pc.vagina] languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.");
	output("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!\n\n");
	pc.orgasm();
	pc.cor(1);
	
	processTime(20);
	CombatManager.genericVictory();
}
public function DemonFactoryDoForcefeedSuccubus():void {
	clearOutput();
	
	output("You chuckle as you decide to release some of the pent up pressure in your [pc.fullChest].  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face");
	if(pc.biggestTitSize() > 6) output(", nearly smothering the succubus with the swell of tit-flesh");
	output(".  You jiggle back and forth, lining up a [pc.nipple] with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.\n\n");  
	output("\"<i>Drink up bitch, these tits are full!</i>\" you command.\n\n");
	output("The succubus tentatively takes a [pc.nipple] into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your [pc.breast] and the succubus smiles, now working to free more of your trapped [pc.milkNoun].\n\n");
	if(pc.milkQ() < 350) output("Her flexible tongue easily curls around one of your [pc.nipples], letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.\n\n"); 
	else if(pc.milkQ() < 750) {
		output("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ");
		if(pc.totalBreasts() > 2) output("tits.\n\n");
		else output("tit.\n\n");
	}
	else if(pc.milkQ() < 1500) {
		output("Her flexible tongue wraps around a swollen nipple, immediately squeezing out a jet of thick [pc.milk].  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of [pc.milk], forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the [pc.skinFurScales] on your chest, pooling around the succubus' groin and your own as the unattended nipple");
		if(pc.totalBreasts() > 2) output("s");
		output(" can't help but dribble in sympathy.\n\n");
	}
	else {
		output("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of [pc.milk] that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output of milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple");
		if(pc.totalBreasts() > 2) output("s");
		output(" in sympathy, drenching your [pc.skinFurScales] with creamy goodness until it puddles on your captive demon.\n\n");
	}
	if(pc.totalNipples() == 2) output("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your [pc.foot].  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ");
	if(pc.totalNipples() > 2 && pc.totalNipples() < 6) output("As your first [pc.nipple] drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next [pc.nipple].  After she drains each of your " + num2Text(pc.totalNipples()) + ", you smile happily at your now emptied breasts.  ");
	if(pc.totalNipples() >= 6) output("As your first [pc.nipple] drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that [pc.nipple] also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your [pc.milk].  ");
	if(pc.milkQ() < 1000) output("Her belly bulges slightly from all the breast-milk she's consumed.\n\n");
	else output("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.\n\n");
	output("Despite the relief your [pc.chestFull] now feel, your [pc.vagina]");
	if(pc.cocks.length > 0) output(" and [pc.cocksLight] feel hungrier than ever.  ");
	else output(" feels hungrier than ever.  ");
	output("You shove your crotch into your milk-dazed foe's white-stained visage, grinding your [pc.vagina] into her mouth until you cum all over her");
	if(!pc.hasCock()) {
		if(pc.vaginas[0].wetness() < 3 ) output(", soaking her with girl-cum.");
		else if(pc.vaginas[0].wetness() < 4) output(", slicking her face with girlish cum.");
		else output(", drenching her with a deluge of girlcum.");
	}
	else output(", and unloading a wave of hot spunk into her hair.");
	output("\n\nYou push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum");
	if(pc.hasCock()) output(" and a thick layer of spunk");
	output(".");
	output("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!\n\n");
	pc.orgasm();
	
	processTime(40);
	CombatManager.genericVictory();
}

public function DemonFactoryDildoSuccubus():void {
	clearOutput();
	output("Your defeated opponent eyes you warily as you advance upon her, thrusting her chest forwards lewdly, with a hopeful gleam in her eye.  That gleam vanishes in sudden surprise when you stop and pull the oblong form of Tamani's dildo from your pouches.  The busty demon giggles happily, \"<i>I, like, love those things!  Those little sluts never let me keep one though!  Greedy bitches...</i>\"\n\n");
	output("The succubus spreads her fishnet-coated legs, exposing her moist vulva while she reclines against a table, beckoning you forwards.  Well, you certainly didn't expect her to be so willing, but you may as well go through with it!  You push up her tiny skirt for better access and position the toy for a perfect insertion. She begs, \"<i>Quit teasing me and just jam it in me already!  Honey, I just want to feel it stretch me while my hot little box drools all over it.  Would you mind giving my clitty a lick too?  It's aching for a touch.</i>\"\n\n");
	output("You see her button poking between her folds, far larger than the mortal women you've met, and you feel more than a little compelled to do as she's asked.   The toy slides in easily, though the further it penetrates her dark-blue cunt, the thicker it gets, and the more difficult it becomes to force it deeper inside.  Eventually you get it the entire way in.  The pair of you, demon and champion, watch together as her glistening cunt-lips are slowly forced apart, stretched wider and wider by the exotic dildo.  She giggles as you watch transfixed, and begins stroking her fingers all over her juicy outer folds while she asks, \"<i>Are you going to rape me or just stare at my cunt all day?</i>\"\n\n");
	output("Shaking your head and blushing ");
	if(pc.cor() < 50) output("in shame");
	else output("with lust");
	output(", you begin tracing your finger over her clit, smiling when it twitches.  It begins visibly growing every time you touch it, puffing up until it's nearly four inches of smooth purple succubus sex.   Glancing down further, you see her cunt stretched massively, the pink blob spreading her so wide it looks like any more swelling would dislocate her hips.  You give her clit a little squeeze and the succubus cums, noisily and happily.  Her clit spasms wildly, growing slightly bigger before beginning to wilt as the cunt-contractions force the dildo out.\n\n");  
	output("With a sodden 'plop', it hits the floor, revealing a gaping canal dripping with the dildo's pink aphrodisiacs.  The secretary-impersonating slut flops back, fondling her tits through her clothing as she languidly sighs, \"<i>Oooooh yeah those little cunts can make a good toy.</i>\"   She props herself up and begins touching her sex, holding open the gaped love-tunnel for you as she teases, \"<i>Yes, you've defeated me, like, for sure, mighty champion!  I don't think I'm capable of standing up to stop you! *Giggle*</i>\"\n\n");
	output("Good.  You pick up the toy ");
	if(pc.cor() > 75) output("giving it a long lick to taste the succubi's delicious flavor ");
	output("and put it away.  When you glance back towards the Succubus, she's gone, leaving you alone and horny...\n\n");
	pc.lust((20 + (pc.libido() / 5) + (pc.cor() / 10)));
	
	processTime(20);
	CombatManager.genericVictory();
}

public function DemonFactoryDoLossSuccubus():void {
	clearOutput();
	if(pc.hasCock()) {
		if(pc.LQ() > 99) output("Driven half mad with lust, you drop to your knees. Your fingers fly over your body as you pry off every last piece of your [pc.gear], displaying just how hard your alluring opponent has gotten you.  The succubus saunters over, every sinuous step radiating the inhuman sexuality that pours off her skin like heat from a bonfire.\n\n");
		else output("Exhausted, you collapse before the succubus.  She effortlessly slices away your [pc.gear], peeling your possessions away with practiced ease.  In moments you are stark naked and wholly exposed to your captor.  In spite of yourself, your body begins to respond to her sultry aura, displaying the hardness of your desire and shame immediately.\n\n");
		output("\"<i>Awww, did I get you all <b>HOT</b> and bothered?</i>\" She croons, poising a stocking clad foot above you as her high-heels seem to fade away.  Warm silk begins to press against your groin as slender toes curl around the head of your throbbing maleness, your foe having her way with your desire-saturated form.  You mewl pitifully at the sensation, your hips twitching involuntarily against her demonic sole. The slippery surface of her foot squeezes as she expertly strokes you with her foot, delighting in her complete dominance over your easily controlled member.\n\n");  
		//balls or pussy play
		if(pc.balls > 0) {
			//[[balls]]
			if(pc.ballSize() < 6) output("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses your [pc.balls] with soft touches.  Almost immediately you feel them clench with boiling heat, growing heavy and churning with a load big enough to satisfy a thirsty succubus."); 
			//[[huge balls]]
			else output("Your sultry captor leans low, marveling at the size of your [pc.balls] as she reaches down to caress them.  Her tits swing lewdly above you, bouncing in hypnotic motions. Her hands work gently, taking each one of your [pc.balls] and hefting it gently.  Almost immediately you feel them fill with an unnatural heat that spreads everywhere her slender fingers touch.  They begin to feel full and heavy, practically sloshing as the pent up need inside you is channeled into liquid form.  \"<i>So ripe... and full,</i>\" she whispers to herself as she caresses them, her silken foot still sliding all over your [pc.cock], pumping stroke after stroke of pleasure into your lust-weakened form.");
		}
		else {
			//[[no balls no pussy]]
			if(!pc.hasVagina()) output("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the skin between your [pc.cock] and [pc.asshole] with a slender finger.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning out from your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
			//[[no balls + pussy]]
			else output("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the slick skin of your slit with a single digit.  Other fingers circle your [pc.clit], teasing it from between the folds as it grows hard, peeking out from the hood and turning cherry-red.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning in your prostate as your body readies a load large enough to satisfy a thirsty succubus.");
		}
		output("\n\n");
		//[[Cum]]
		output("The succubus licks her lips in anticipation as she curls her silk-clad toes tighter around you, making you bulge and twitch in obscene pleasure.  With a naughty smile, she caresses your ass with her bulbous demonic tail.  Before you can react, it plunges inside you, easily slipping through your [pc.asshole] and pressing tightly against your prostate.  The suddenness pushes you over the edge, but she immediately wraps her fingers around you, pinching tightly, bottling your cum inside you.  You cry out in pain and surprise as your entire thick load is trapped inside you.  After nearly a full minute, your groin aches with the discomfort of it all.\n\n");
		//More cum paragraph.  HAHA! TINY BABY CUM! 
		output("She wastes no time, and caresses you again.  You instantly feel another surge of heat and desire as a fresh load of cum brews behind your first strangled orgasm.  You need to cum so bad, her foot still stroking and squeezing you full of perverted desire.  She slaps your ");
		if(pc.balls > 0) output("balls");
		else output("ass");
		output(" as she releases your [pc.cock], shouting, \"<i>CUM!  Feed me!</i>\"  You are all too happy to oblige.  ");
		//[[normal volume]]
		if(pc.cumQ() < 50) output("Freed at last, your body clenches tightly as it squirts the first jet of cum from your [pc.cock].  She smears her foot over the head, catching the cum and using it to lubricate her silken foot as it massages your member with merciless strokes, alternatively catching your spooge and milking more from your obedient maleness.  Your orgasm lasts many times longer than normal as your dual loads feed her demonic hunger."); 
		//[[big volume]]
		if(pc.cumQ() >= 50 && pc.cumQ() < 400) output("Freed at last, your body clenches tightly as it spurts a big glob of cum onto her waiting sole, soaking the bottom of her foot with slippery male-milk.  She smears her cum-covered foot over every inch of your [pc.cock], making each successive spurt bigger and messier than the last. Somehow she manages to catch more and more of your jizm over her foot, bathing you in cummy silkiness.  You groan helplessly as she milks more and more of from you till her foot is dripping steadily, your own groin and belly soaked with the stuff.  You give a few final exhausted squirts as she languidly rubs it into you.");
		//[[huge volume]]
		if(pc.cumQ() > 400) output("Freed at last, your body clenches powerfully as a massive eruption of cum launches from your [pc.cock] onto her waiting foot.  The succubus looks on incredulously as her entire foot is soaked with your sticky whiteness, forgetting to move as the second wave of cum drenches her to the ankle and rains down over your stomach.  She giggles and moves it back to your cock, massaging your slick spooge into your cock with her foot, wringing an even bigger explosion of cum from your tortured body.  Flopping back, she gets her other foot in on the action, milking you between her feet as you soak yourself completely with bigger and bigger eruptions until at last your orgasm begins to wane.  She slides forwards, rubbing against you and smearing the mess over herself with a blissful expression.");
		output("\n\n\"<i>Good boy,</i>\" she croons, mopping the cum up as it seems to wick into her stockings, \"<i>You'll do well once we get you on the line.</i>\"  You don't have time to ponder the significance of that as you lose consciousness.");
		//ONWARD TO BAD-END-IA!
		pc.orgasm();
		doNext(DemonFactoryBadEndGeneric);
	}
	else {
		if(pc.LQ() > 99) {
			output("Driven half mad with lust, you shake yourself free from the trappings of your [pc.gear], first revealing your [pc.fullChest], then [pc.hips] and finally your ");
			if(pc.hasVagina()) output("[pc.vagina] as the last pieces fall away.\n\n");
			else output("bare groin as the last pieces fall away.\n\n");
		}
		//(HP loss)
		else output("You realize you're wobbling unsteadily, either from a blow to the head or blood loss, you can't be sure which.  In a display of sublime defiance, you manage to stay on your feet.  Though your tenacity does little good as your lightning-fast foe effortlessly undresses you, easily avoiding your clumsy and pain-addled movements.\n\n");  
		//START ZE RAPE
		output("The succubus steps away from you, withdrawing a tiny vial from a pocket in her vest.  She uncaps it with practiced ease, her outfit shifting into latex parody of a nurse's uniform as she attaches a small needle, completing the assembly of her injector.  \"<i>Like, don't worry about a thing hun, this will only hurt for a second,</i>\" she coos as she prances forwards, easily sinking the entire needle into your shoulder.\n\n\"<i>W-what did you do to me?</i>\" you manage to stammer.\n\n", false);
		output("She merely smiles and slips a delicately manicured finger under a rapidly disappearing skirt.  You ignore her crude display of wanton sexuality for the moment and try to focus on figuring out what the drugs did you, and what her needy slit smells like.  No, that wasn't it... you wanted to taste her nipples!  You shake your head and try to focus, but fail completely as the succubus lifts her sticky latex skirt, exposing her dripping snatch to you.  Your eyes lock on to the wondrous slut's fuckhole as her fingers tease you with glimpses between her folds every few seconds while she continues pleasuring herself.  With a flash of intuition, you realize what you were trying to think about:  finding something hard to penetrate that perfect hole with.  That little hungry snatch deserves to be filled with something throbbing and hard...\n\n");
		output("\"<i>OoooooOOOOH!  ...you're feeling it now are-AH AH YES-you dear?  Mmmmm yes, I bet this pussy is all you can think about.  I wonder if you can feel it-aaahhhhhhmmmm-yet?  This is always, like, the best part...</i>\" gasps out the succubus as she pleasures herself.  You wonder what she could be talking about as ");
		if(pc.hasVagina()) output("your [pc.clit] parts your folds, growing harder.");
		else output("a fleshy growth erupts from your pale flesh, growing harder.");
		output("  In seconds you're playing with it, tugging the sensitive button as it fills up with more and more blood, growing bigger and harder than ever before.  Your legs give out as you begin stroking it with feverish intensity, barely registering as it grows to nearly eighteen inches in length, not noticing the increasingly veiny surface or different texture at the tip.  You force yourself to stop as a sudden truth asserts itself upon your consciousness - you need to shove your clit-like cock into a pussy.  You need to cum inside that hungry slut's blue spunk-receptacle.\n\n");
		output("You stand on shaky legs and lunge forwards, impaling the slutty nurse on your new tool with a violent animalistic passion.  Fucking her roughly, you lick her nipples to finally get the taste you've ached for.  Girl-cum squirts from the sloppy fuck-hole of the latex-nurse underneath you as you fuck her like a desperate animal.  She squeals with pleasure, splitting her legs wide apart to encourage your new maleness.  Your eyes roll back from the drug-enhanced pleasure of her dripping cunt as a male orgasm rocks your mind.  Mixed fluids splatter your pistoning hips as you do what you were always meant to do - feed and pleasure succubi.  Somehow your tool remains rigid and your hips continue plunging your new cum-spigot deeper and deeper into your mistress as the next orgasm begins to build inside your drug-addled mind, even as you black out.");
		pc.createCock(16);
		pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
		//[[[[To bad end!]]]
		pc.orgasm();
		doNext(DemonFactoryBadEndGeneric);
	}
}
public function DemonFactoryDoLeaveSuccubus():void {
	processTime(5);
	CombatManager.genericVictory();
}

public function DemonFactoryDoBadEndSuccubusPart1():void {
	//spriteSelect(55);
	//Arousal
	output("In no time flat your blood begins to burn hot with the fires of unnatural lust.  ");
	//Tits – regular
	if(!pc.isLactating()) output("Your [pc.nipples] begin prodding painfully against your [pc.gear], every touch serving to make them harder and more erect.  ");
	//Tits – lactating
	if(pc.isLactating() && pc.milkQ() < 1000) output("Your [pc.nipples] get painfully hard as you feel milk begin backing up inside your [pc.fullChest].   The succubus glances down mischieviously as her hands begin to grope you through your [pc.gear], squeezing out a few drops of milk.  ");
	//Tits – megalactating
	if(pc.milkQ() > 1500) output("Your [pc.nipples] get painfully hard as milk begins drooling down your over-productive chest, making your [pc.gear] slide across your leaky milk-spouts in an agonizingly pleasurable way.  "); 
	//Cock – single
	if(pc.cocks.length == 1) {
		if(pc.cockVolume(0) < 30) output("Swooning from sudden blood loss, you struggle to maintain the kiss as your body takes your [pc.cock] to full hardness in seconds.  ");
		//Cock – single big
		if(pc.cockVolume(0) >= 30 && pc.cockVolume(0) < 100) output("Nearly blacking out, you struggle to stay awake as your body shifts your blood to your disproportionate [pc.cockNoun].  ");
		//Cock -megahuge
		if(pc.cockVolume(0) >= 100) output("As you struggle not to lose consciousness, you realize your over-aroused body had pumped most of your blood to your over-sized [pc.cockNoun], which now droops to the floor, pulsing hotly.  ");
	}
	//DO MULTIZ
	if(pc.cocks.length > 1) output("The feeling of light-headedness nearly robs you of consciousness as your [pc.cocks] fill with blood, pulsating with arousal as they reach full size.  ");
	//Vagooooz
	if(pc.vaginas.length > 0) {
		//'uge clit
		if(pc.clitLength >= 4.5) output("Popping from between your thighs, your [pc.clit] responds to the sheer hotness of the situation by making itself known.   You squeeze your legs tightly together, hungry for additional sensation.  ");
		//big clit
		if(pc.clitLength > 1 && pc.clitLength < 4.5) output("A wave of pleasure erupts from between your legs as your [pc.clit] pops free.    You squeeze your legs tightly together, hungry for the additional sensations.  ");
		//slick
		if(pc.vaginas[0].wetness() >= 3) output("Squishing wetly, your bottoms become soggy with the flood of fluids leaking from your [pc.vagina].   Your legs spread apart on their own, begging for any kind of intrusion.  ");
		//normal
		else output("Groaning softly, you feel yourself getting wetter and wetter with arousal.  You wish your sticky bottoms were off so you could let something into your [pc.vagina].  "); 
	}
	output("\n\n");
	//New PG
	output("No longer caring about modesty, etiquette, or even your own safety, you squirm against your bindings, lewdly putting on a display for your captor as you suck her tongue as if your life depended on it.   She breaks the kiss with a smile, \"<i>I told you I'd make sure it was pleasurable.  Now you sit tight while I get you hooked up, and we'll have you cumming what's left of your brains out in no time,</i>\" she promises.\n\n");
	output("The succubus pushes a button on the wall, and a number of strange looking suction tubes and hoses drop down from above you.   Moving with practiced efficiency, she hooks a ");
	if(pc.totalBreasts() == 2) output("pair of");
	else output("number of");
	output(" hoses to your breasts, ");
	if(pc.hasCock()) {
		if(pc.hasClit()) output("and a vacuum pump to your clit.  ");
		else {
			output("and another vacuum pump to your bare groin.  In seconds a wet fleshy growth erupts.  You have grown a cock!  ");
			pc.createCock();
		}
	}
	else {
		if(pc.vaginas.length > 0) output("a vacuum pump to your clit, and a pump many times bigger than your [pc.cock] to it.  ", false);
		else output("and a pump many times bigger than your [pc.cock] to it.  ", false);
	}
	output("At first there is only a gentle suction, you assume in order to keep them in place.  Unfinished, your captor places something large and hollow against your backdoor", false);
	if(pc.vaginas.length == 0) output(".", false);
	else output(" and an ever larger dildo against your [pc.vagina].  It seems to pulse and wiggle with a life of its own rubbing the bumps of it's lumpy head against your lips.", false);
	output("  You swoon as you hear the solid click of a button being pushed, and all at once all devices attached to you leap to life.", false);
	doNext(DemonFactoryDoBadEndSuccubusPart2);
}

private function DemonFactoryDoBadEndSuccubusPart2():void {
	//spriteSelect(55);
	clearOutput();
	output("The beautiful seductress that bound you giggles and says, \"<i>Oh it only gets better baby,</i>\" as she pushes another button.  You see a number of needles lower from the equipment above.  Two pause at chest height.  Faded parchment labels on the tubes mark them as \"Gro+\".  You spot the same markings on at least some the hoses gathering around your groin.  A few are marked with different labels, but you cannot make out the demonic script.  As one, the hoses rear back, then plunge forward, burying themselves into your supple flesh and injecting their drugged payload into your body.  It hurts at first, but the drugs fog your mind, blocking the pain with pulsing waves of desire.   You begin cumming as your body erupts with artificial pleasure.\n\n"); 
	//Nipples
	output("The suction pulls squirt after squirt of milk from your breasts as your [pc.fullChest] start to grow, swelling heavier as they enlarge to produce more milk.  You squeal with delight as your nipples turn black, tainted by corruptive chemicals that are slowly dripped into you.  ");
	//Dick  
	if(pc.hasCock()) {
		output("The vacuum-pump on your cock noisily sucks down all your spoo, ");
		//High cum variant
		if(pc.cumQ() > 300) output("struggling with the amount you put off.  Grinning, the succubus reaches over and flips a lever.  You feel the suction increase as the machine is turned up to accommodate your altered physique.  ");
		//else
		else output("the suction and drugs make it so easy to just keep cumming and cumming.  ");
		//either or:
		output("Dimly, you feel a needle lodged in your taint, pumping your prostate full of something.  Your [pc.cock] begins growing mid-orgasm, the skin turning a deep purple even as small nodule-like bumps form all over it, rapidly becoming a bloated parody of it's demonic counterparts.  ");
	}
	//Puss Orgasmz
	if(pc.vaginas.length > 0) output("Clenching tightly, your [pc.vagina] squeezes tightly on it's intruder as it's repeatedly violated by the machines.  ");
	//End
	output("\n\nThe world around you disappears, leaving you alone with the drug-enhanced sensations assaulting your body.  In truth, you don't want it to end.  You find yourself wishing it would never end, and no doubt the equipment you're hooked in to will see to that.\n\n");
	//if(pc.statusAffectv3(StatusAffects.Marble) == 1) {
		//output("Later on, you are briefly pulled out of your reverie by a familiar warm fluid flowing down your throat.  You come to your senses and see Marble looking down at you with an odd expression on her face.  ", false);
		//output("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
	//}
	//else if(pc.findStatusAffect(StatusAffects.CampMarble) >= 0) {
		//output("You are given a brief moment of clarity as you see Marble standing in front of you.  ", false);
		//output("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
	//}
	//else 
	output("Later on, in a moment of clarity, you look around and realize you aren't alone.  ");		
	output("In rows alongside you are a large number of other captives, every single one endowed with freakishly sized breasts, and nearly all gifted with throbbing demonic dicks.  Some small analytical part of you notes that the farther down the line they are, the older and larger they have become.   You look down and see your own massive tits, shiny tainted nipples still pumping out streams of milk.  The huge throbbing demon-cock between your legs begins to get hard as the machines crank back up, filling you full of happy horniness.");
	//if(pc.statusAffectv3(StatusAffects.Marble) == 1 || pc.findStatusAffect(StatusAffects.CampMarble) >= 0) output("  With Marble here too, you'll be around for a long time.", false);
	badEnd();
}

public function DemonFactorySuccubusDefeated():void
{	
	kGAMECLASS.userInterface.showName("VICTORY:\nSUCCUBUS");
	clearOutput();
	clearMenu();
	
	if (enemy.LQ() > 99) output("You smile in satisfaction as the [enemy.name] gives up on fighting you and starts masturbating, begging for you to fuck her.");
	else output("You smile in satisfaction as the [enemy.name] collapses, unable to continue fighting.");
	pc.lust(1);
	flags["COC.FACTORY_SUCCUBUS_DEFEATED"] = 1;
	
	if (!pc.hasGenitals() || pc.lust() < 33)
	{
		addButton(0, "Next", DemonFactoryDoLeaveSuccubus);
		return;
	}
	
	output("  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?");

	
	addButton(0, "Rape", DemonFactoryDoRapeSuccubus);
	if (pc.hasKeyItem("Deluxe Dildo")) addButton(1, "Dildo Rape", DemonFactoryDildoSuccubus);
	else addDisabledButton(1, "Dildo Rape", "Dildo Rape", "Deluxe Dildo exclusive scene.");
	addButton(14, "Leave", DemonFactoryDoLeaveSuccubus);
}

public function DemonFactorySuccubusWon():void
{
	kGAMECLASS.userInterface.showName("DEFEAT:\nSUCCUBUS");
	DemonFactoryDoLossSuccubus();
}