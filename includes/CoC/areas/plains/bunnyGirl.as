import classes.Characters.PregnancyPlaceholder;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCNeonPinkEgg;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Easter Bunny 
//5'4", small B cup breasts.
//14" Human dick with a pointed head.  A pair of egg-shaped testes.
//Egg preg changes – Bunny Ears, Bunny Tail, Bunny Legs?, Hot pink nose & whiskers?

public function get bunny():PregnancyPlaceholder
{
	var pp:PregnancyPlaceholder = new PregnancyPlaceholder();
	if(!pp.hasCock()) pp.createCock();
	pp.cocks[0].cLengthRaw = 14;
	pp.createPerk("Fixed CumQ", 6000, 0, 0, 0);
	pp.impregnationType = "CoCBunnyPregnancy";
	
	return pp;
}

public function isEaster():Boolean {
	return checkDate(27, 3, 1);
}

public function bunnbunbunMeet():void {
	clearOutput();
	clearMenu();
	//spriteSelect(13);
	if (flags["COC.MET_BUNBUN"] == undefined) flags["COC.MET_BUNBUN"] = 0;
	
	if(flags["COC.MET_BUNBUN"] == 0) {
		output("A ", false);
		if(pc.tallness > 64) output("short ");
		output("bunny-girl appears from behind some bushes, hopping about and clutching a basket full of multicolored eggs tightly in front of her muscular, fur-covered thighs.  She hops around a few times, peering closely at the ground as if searching for something.  Her slow, deliberate hopping comes to an end as she looks up and spots you.  The bunny's eyes widen into shocked dinner-plates, like she's utterly amazed someone saw her.  She freezes completely still, watching you, and you're given the chance to give her a good looking over.\n\n");
		
		output("Starting above the bunny's hips, her fur vanishes into dusky, olive skin, save for two 'poofs' of fur that ring her wrists like bracelets and a large, fluffy white tail above her butt-cheeks. It twitches nigh-constantly, the only part of the girl that's moving.  Her breasts are small - perhaps B-cups – and pear-shaped.  A tight, bright pink nipple perches atop each tiny tit's fleshy swell, hard from arousal or cold. Her face is human save for a bright pink nose and a few whiskers that sprout from the freckles on her cheeks.  The strange woman's groin is concealed behind the basket, ");
		
		if(pc.libido() > 50) output("and you find yourself wondering what sort of treasures she conceals behind it.");
		else if(pc.cor() < 40) output("and you find yourself thankful for her modesty.");
		else output("and you find yourself considering tearing away the basket so you can see what she's hiding down there.");
		output("\n\n");
		
		output("Even though nearly a minute has passed, the bunny-lass is STILL frozen and staring.  She hasn't done anything since realizing that you're looking at her.  Well, it looks like the ball's in your court.  What do you do?", false);
		//[Talk] [Rape Her]
		addButton(0, "Talk", talkToBunnyBunBun);
		addButton(1, "Rape Her", rapeBunBun);
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	//Met her
	else {
		//Bunbunsplosions!
		if(rand(6) == 0 || (isEaster() && rand(3) == 0)) {
			adjathaEggsplosions();
			return;
		}
		output("While exploring the plains, you spy the familiar ears of a bunny-girl bobbing up and down behind a particularly tall patch of grasses.  You peek over the top of the grasses to find the dusky-skinned rabbit-girl playing with herself.  Both of her dainty, dextrous hands are clamped tightly around the wet, dripping length of her 14-inch cock as she hammers at the ground with her feet and humps away at her tightly-balled fists.\n\n");
		output("You lean forwards for a better look, dislodging a small pebble with your " + pc.foot() + " while shifting position.  The bunny-girl leaps to her feet in a panic until her terrified irises lock onto your " + pc.face() + ".  Her panic turns to embarrassment and in a flash every inch of her tanned skin is colored red.  She asks, \"<i>Ummm, since I'm still in s-season, c-could we b-breed or something?  Maybe just a little fuck?</i>\"\n\n");
		
		output("She claps both hands over her mouth, leaving her swollen prick to bounce precipitously while she awaits your response.\n\n");
		
		output("If you're going to sex her, which of her body parts will you use?\n\n");
		pc.lust(5 + pc.libido() / 20);
		
		addDisabledButton(0, "Your Vagina", "Your Vagina", "This scene requires you to have vagina.");
		addDisabledButton(1, "Her Vagina", "Her Vagina", "This scene requires you to have fitting cock.");
		addDisabledButton(2, "69", "69", "This scene requires you to have genitals.");
		
		if (pc.hasVagina()) addButton(0, "Your Vagina", bunbunFucksYourVag);
		if (pc.cockThatFits(40) >= 0) addButton(1, "Her Vagina", bunbunGetsFucked);
		if (pc.hasGenitals() && (pc.IQ() < 20 || !pc.isTaur())) addButton(2, "69", bunbun69);
		
		addButton(3, "Your Ass", bunbunFucksPCInAss);
		
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}
//[Talk]
private function talkToBunnyBunBun():void {
	//spriteSelect(13);
	flags["COC.MET_BUNBUN"]++;
	clearOutput();
	output("You slowly introduce yourself, and let the bunny-girl know that you mean her no harm. She doesn't move until you finish, but as you conclude she visibly relaxes and nods.  It doesn't stop her tail from twitching, and if anything, her nose joins it in twitching, but she asks, \"<i>How is it you can see me?  I've got a lot of eggs to hide and normally no one sees me.</i>\"\n\n");
	
	output("A shrug of your shoulders is the only answer you've got.  Does she think she's some kind of invisible bunny?  How crazy is that!\n\n");
	
	if(isEaster()) output("She sighs and wipes the sweat from her brow with one of the bracelet-like fur-poofs on her wrist as she tries to explain, \"<i>I've got to put out all these eggs! It's my duty! Once every year I turn invisible and go around hiding eggs for children to find.  It's a family duty that's been passed down for generations.  I seem to have gotten lost though.  I've never been anywhere like this and the food here makes me so terribly hot. It's like I just want to fuck and lay eggs all day!</i>\"\n\n");
	else output("She sighs and wipes the sweat from her brow with one of the bracelet-like fur-poofs on her wrist as she tries to explain, \"<i>I've got all these eggs to get rid of.  I'm not supposed to make so many, but I keep going into season over and over again that I make sooo many.  The worst part is every time I pop out a few eggs I want to do it even more the next time.  It's like I just want to fuck and lay eggs all day!</i>\"\n\n");
	
	output("Rose color erupts on her face as she drops her basket and covers her mouth, \"<i>Did I just say fuck!? EEP!</i>\"  With her basket no longer in hand, her groin is revealed!  A mammoth, 14-inch dong bounces proudly between her legs.  It's veiny and tipped with a narrow head while a pair of egg-shaped orbs bounce in the sack underneath it.  She jumps and tries to cover it up again, but all she succeeds in doing is accidentally giving it a stroke.  A dollop of pre-cum squirts onto her hand as she moans without thinking, \"<i>Ooooh damn I need to breed.</i>\"\n\n");
	
	output("In no time flat she's on her back, playing with herself and lifting her balls to expose a bubblegum-pink gash.  You could 'help' her with that or you could leave.  Of course if you leave you doubt you'll find her again.  Maybe a good fucking will clear her head long enough for her to figure out how to leave this land and return to wherever she came from?\n\n");
	output("(If you're going to sex her, which of her body parts will you use?\n\n");
	
	pc.lust(5 + pc.libido() / 20);
	
	addDisabledButton(0, "Your Vagina", "Your Vagina", "This scene requires you to have vagina.");
	addDisabledButton(1, "Her Vagina", "Her Vagina", "This scene requires you to have fitting cock.");
	addDisabledButton(2, "69", "69", "This scene requires you to have genitals.");
	
	if (pc.hasVagina()) addButton(0, "Your Vagina", bunbunFucksYourVag);
	if (pc.cockThatFits(40) >= 0) addButton(1, "Her Vagina", bunbunGetsFucked);
	if (pc.hasGenitals()) addButton(2, "69", bunbun69);
	
	addButton(3, "Your Ass", bunbunFucksPCInAss);
	
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
//[Rape Her]
private function rapeBunBun():void {
	//spriteSelect(13);
	clearOutput();
	if(pc.RQ() < 60) {
		output("You lunge forward off your " + pc.feet() + ", trying to tackle and pin the poor girl, but at the first sign of movement from you, she bounds off in the other direction!  She's hopping so fast there's no way you could possibly catch her, and in a matter of seconds you're left totally alone.  Well, perhaps not TOTALLY alone – there's one small egg nestled in the grass.  It fell from the bunny's basket in her haste to flee!");
		//(pick and loot random egg)
		
		processTime(15 + rand(10));
		itemScreen = mainGameMenu;
		lootScreen = mainGameMenu;
		useItemFunction = mainGameMenu;
		itemCollect([new CoCNeonPinkEgg()]);
	}
	//[Rape Her Faster]
	else {
		flags["COC.MET_BUNBUN"]++;
		output("You lunge forward off your " + pc.feet() + ", trying to tackle and pin the poor girl, but at the first sign of movement from you,  she launches herself up and back with a powerful hop.  She didn't count on your speed, and you manage to tackle her mid-air.  Both of you slam into the ground, the bunny pinned tightly underneath you.  Her basket and eggs went flying when you hit her, and now there's a few dozen eggs scattered in the tall grass.   The girl wriggles, trying to squeeze out of your grip, but you hold firm to her as she cries, \"<i>YOU MEANIE!</i>\"\n\n");
	
		output("Your belly feels warm and wet, and as you pull back to examine the bunny, the source of the moisture is revealed.  The girl isn't a girl at all!  She's got a hard 14-inch dick and a pair of bouncing, egg-sized balls that are working quite hard to leak bunny-cum onto you.  You reach down underneath the orbs and thankfully find another source of wetness.  At least you weren't completely wrong!  You're dealing with a hermaphrodite, and a horny one at that.  Why would she bother resisting when her body is so thrilled to be so close to you?\n\n");
		
		output("The horny bun-herm follows your gaze and breaks into a slowly spreading grin, revealing a pair of cute buck-teeth as she asks, \"<i>Oh, you just wanted to fuck?  Why didn't you just ask?  I thought you were going to eat me!</i>\"  Her confident declaration does little to hide the bright red blush coloring her cheeks, making it clear this situation is a little strange to her.\n\n");
		
		pc.lust(10);
		pc.cor(3);
		
		addDisabledButton(0, "Your Vagina", "Your Vagina", "This scene requires you to have vagina.");
		addDisabledButton(1, "Her Vagina", "Her Vagina", "This scene requires you to have fitting cock.");
		addDisabledButton(2, "69", "69", "This scene requires you to have genitals.");
		
		if (pc.hasVagina()) addButton(0, "Your Vagina", bunbunFucksYourVag);
		if (pc.cockThatFits(cockVolume(40)) >= 0) addButton(1, "Her Vagina", bunbunGetsFucked);
		if (pc.hasGenitals()) addButton(2, "69", bunbun69);
		
		addButton(3, "Your Ass", bunbunFucksPCInAss);
		
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//[Take Dick in Vag Fukked]
private function bunbunFucksYourVag():void {
	//spriteSelect(13);
	clearOutput();
	output("A anticipatory grin widens across your " + pc.face() + " as you speedily disrobe, discarding your [pc.gear]");
	if(pc.hasWeapon()) output(" and " + pc.getWeaponName());
	output(" in a hurry.   Meanwhile the bunny looks on in a semi-aroused stupor, stroking her length with one hand while her other teases one of the hard nubs of her nipples.  You sigh with excitement as you position yourself above her, lining up her somewhat angular crown with the entrance to your [pc.vagina] before you start to drop.");
	if(pc.vaginas[0].wetness() >= 4) output("  Moisture leaks in a steady drizzle, mixing with bunny-pre to totally slick the soon-to-be invading member.");
	output("\n\n");
	
	output("Gasping hotly, you swallow her pointed tip into your depths, feeling the rabbit-like girl's tip swell and pump out a few more drops of lube");
	if(pc.vaginas[0].wetness() >= 3) output(", not that you needed it");
	output(".  You don't need any more encouragement.  The long, slow slide down her thick bunny-dick is heavenly, as the veins on its surface scratch your 'itch' in just the right way.  ");
	if(pc.vaginalCapacity() < bunny.cockVolume() * 0.66) output("By the time you're getting close to the bottom you have to work to encompass her length and girth within your velvet folds and grunt with discomfort from each new inch of throbbing fuck-stick, but you take it all.  ");
	else if(pc.vaginalCapacity() < bunny.cockVolume() * 1.2) output("By the time you get to the bottom you're panting and moaning, delighting in the feeling of being so perfectly impaled on a rigid fuck-stick.   With her entirely inside you, you're ready to fuck her in earnest.  ");
	else output("It doesn't take long to slide down the more-than footlong meat-pole, and to be honest you wish she was a bit bigger.  Your [pc.vagina] is so ready for big dicks that this disproportionate member is average at best.  Still, you clench your thigh muscles to wring it a little tighter, and swoon from the feeling of warm maleness filling your loins.  ");
	pc.cuntChange(0, bunny.cockVolume(), true);
	output("\n\n");
	
	output("While the bunny was content to remain passive up until this point, a fire lights in her eyes now that she's had a taste of pussy.  Her petite hands grab hold of your [pc.ass] while she pulls her powerful, oddly-jointed legs underneath of her.  A split second later she pushes up with enough force to bounce you a few inches into the air before you drop down on top of her.  ");
	if(pc.tallness >= 72) {
		output("Your sheer weight makes her grunt in discomfort when you land back atop her, but the squish of copious sexual fluids nearly drowns it out. She even squirts another thick gout of pre inside you.  ");
		if(pc.cor() < 33) output("You'll have to try to slow your descent next time!  ");
		else output("If she's going to fuck you like this, she can handle your weight!  ");
	}
	else output("Your bodies clap together with a loud squish of copious sexual fluids, and another thick burble of pre warms your cunny.  ");
	output("How much pre-cum can she squirt?!\n\n");
	
	output("You reach down and grab the bunny's hips for support as she bounces you again, higher this time.  A solid five or six inches of her length slide in and out of your [pc.vagina] before you slap into her, and a split second later, you're airborne again.  She bounces you harder and harder until each thrust of her muscled thighs is launching you nearly a foot off her loins and letting gravity guide you back down her shaft.");
	if(pc.clitLength >= 4) output("  Your [pc.clit] bounces on her belly, tingling like mad every time it slaps into her tanned, sweat-slicked skin.");
	if(pc.isLactating()) output("  Milk begins to bead on your " + pc.allBreastsDescript() + " from the sensation of the bunny's brutal, almost mechanical fucking.");
	output("  The eager girl moans, \"<i>Ooooh fuckfuckyes... gotta fuck... gotta breed... ungh... eggs eggs eggs!</i>\"\n\n");
	
	output("Eggs?  Is she going to knock you up with eggs?  The confusion she's caused actually distracts you from the sex long enough to push back your orgasm, but the amorous bunny-gal pushes herself over the edge with one last thrust, hard enough to nearly launch you from her tumescent cock.  You slide back down the exhausted bunny, but don't feel the telltale spurting and warmth you'd expect to be bursting inside your [pc.vagina].  Sure, there is a trickle of warmth, but your convulsing lover's rod hasn't spurted like a male's organ should.   You turn to get a better look at her and notice that she STILL seems lost in orgasm, and her balls are GONE!\n\n");
	
	output("Your eyes cross from a sudden, massive change in thickness of your lover's pole.  It starts out at your lower lips, spreading them until they're positively gaping.  Muscular contractions in the bunny's shaft make her dick pulse inside you, slowly pushing the bulge upwards and stretching your [pc.vagina]'s walls as it travels towards your womb.  More and more fluid leaks inside of your channel until your " + pc.legs() + " relax and go limp.  It isn't just pre-cum anymore – it's dulling the pain and relaxing your body!  You can actually feel your cervix starting to open involuntarily as the bulge passes the halfway point.  From the distended spot downwards, your cunt hangs loosely around the swollen cock, but another knot emerges at the base and starts to slide up your abused tunnel.  ");
	//(Cunt Change HERE)
	pc.cuntChange(0, bunny.cockVolume() * 2, true);
	output("\n\n");
	
	output("The girl underneath you is thrashing and moaning, chanting, \"<i>Yes... eggs eggs EGGS! YES!</i>\" while her ovipositor-like cock robs you of your strength and slides egg-shaped bulges inside you.  Amazingly, your [pc.vagina] is awash with pleasure, and you reach down to ");
	if(pc.clitLength >= 4) output("fondle your [pc.clit] a moment before wrapping your hand around it and stroking the girl-cock excitedly.");
	else output("caress your [pc.clit] a moment before you start to circle it with a finger, teasing it expertly.");
	if(pc.cockTotal() > 0) {
		output("  [pc.EachCock] twitches and drools ");
		if(pc.longestCockLength() < 10) output("on the bunny's belly");
		else if(pc.longestCockLength() < 18) output("between the bunny's tiny tits");
		else if(pc.longestCockLength() < 28) output("on the bunny's face");
		else output("past the bunny's head");
		output(", and your free hand wastes no time in tending to your male ");
		if(pc.cockTotal() == 1) output("half's needs, slathering it in pre-cum and stroking hard and fast.");
		else output("halfs' needs, slathering them in pre-cum and stroking hard and fast.");
	}
	output("  The futanari rabbit's dick-head swells as the egg reaches her tip, completely opening your womb, and then with one last explosive push, launches it deep inside you.\n\n");
	
	output("You get off hard.  Despite the drug-induced relaxation that's overwhelmed you from the waist down, rippling convulsions erupt up and down your "+ pc.vaginaDescript(0) + ", squeezing the egg-spurting cock tightly.  This only speeds the passage of the bunny's second bulge, and in seconds her distended cock-head is stretched wider than before, locking her inside you for a moment.   The pair of you rock and grind your hips together futilely until the final egg erupts inside of you, accompanied by a huge wave of whatever it is that's made your lower body so nerveless.");
	if(pc.cockTotal() > 0) {
		output("  At last, [pc.eachCock] blasts sticky ropes of seed everywhere, cumming with you as your body slides sideways off the exhausted bunny into the dirt.  A few thick strands hit her tits and face, but judging by her half-closed eye-lids and questing tongue, she doesn't mind.");
		if(pc.cumQ() > 500) output("  Not content with that, [pc.eachCock] continues to pump until the bunny is coated with a generous layer of seed");
		if(pc.cumQ() > 2000) output(" and the excess is running down the hill in a small river");
		if(pc.cumQ() > 500) output(".");
	}
	output("\n\n");
	
	output("You sprawl out, leaking sexual fluids as your womb closes in around the foreign cargo, closing your cervix to hold in both the eggs.  An indeterminate amount of time has passed, but the forced euphoria of your new pregnancy makes it hard to get up just yet.  You see the bunny standing up with her dick finally going limp and no balls to speak of.  She leans down and gives you a kiss on the lips before whispering, \"<i>");
	if (pc.bunnyScore() < 4) output("It's so good to finally think straight!  I don't know why I went into heat right now, but it's so much easier to think now that I've gotten rid of those eggs.  Don't worry, you won't be popping out rabbits since you aren't an easter-bun.  Your body will probably absorb them in a few days.  Just don't be surprised if you feel a little bloated or feel a little weird after.</i>\"\n\n");
	//Pregnant already
	else if(pc.isPregnant()) output("It's so good to finally think straight!  I don't know why I went into heat right now, but it really is a shame you're pregnant.  Your body will destroy the little eggs before they can even do anything!  Well, at least I feel sooo much better...</i>\"\n\n");
	//Preggers
	else output("It's so good to finally think straight!  I don't know why I went into heat right now, but it feels so good to pour my babies into a nice, ready breeder-mom like yourself.  I bet the kids come out so cute!  Oh, I feel so much better.</i>\"\n\n");
		
	output("She walks away, her puffy tail twitching with the breeze while your eyes drift closed.");
	//(Easter vag-preg + 8 hours pass)
	//if (pc.bunnyScore() < 4) {
		//pc.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS);
	//}
	//else {
		//pc.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_BABY, 60);
	//}
	pc.loadInCunt(bunny);
	pc.orgasm();
	//dynStats("lib", 1, "sen", -3);
	pc.slowStatGain("l", 1);
	processTime(4 * 60 + rand(2 * 60));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Take Dick In A] 
private function bunbunFucksPCInAss():void {
	//spriteSelect(13);
	clearOutput();
	output("You get a very naughty idea and silently discard your [pc.gear], tossing it aside as you turn around and present your [pc.ass] to the bunny-girl.  With a lewd shake, you tease her and give her a good view of your [pc.asshole] while it lowers closer and closer to the turgid bunny-cock, just inches away.  Drops of clear pre-cum roll down her shaft as it twitches eagerly, and the girl watches you through a gleam of sexual excitement while her shaft gets closer and closer to your rear entrance.  You let your " + pc.legs() + " relax a little until it's pressing tightly against your sphincter, feeling it slather pre-cum in preparation for the coming penetration.\n\n");
	
	output("Looking over your shoulder at the bunny's beet-red face, you let a little of your weight down and start to spread around the bunny-herm's cock.  It slides inside you easily, aided by her copious drops of pre-cum, but ");
	if(pc.analCapacity() < bunny.cockVolume() * 0.66) output("it stretches you dangerously wide as you slide down the thick shaft.  The further down it gets, the more you have to work to relax your muscles and push yourself along.  With enough time, patience, and copious bunny-pre, you manage to take it completely inside you.  It twitches happily while you adjust to the intrusion, but you know you're just getting started.");
	else if(pc.analCapacity() < bunny.cockVolume() * 1.2) output("you have to keep pausing as you slide down to let more of her pre-cum bubble out and lubricate the fourteen inch shaft.  It fills you nicely, pressing on your innards in all the right ways as you slowly engulf the bunny-cock with your [pc.asshole].  After bottoming out, your nervous lover's prick pulsates happily inside you, but you're just getting started.");
	else {
		output("you wish it was a bit bigger.  A few seconds is all it takes to get her thick shaft completely inside your [pc.asshole].  You clench and squeeze your muscles around it as you sit on the bunny-");
		if(pc.cor() < 50) output("girl");
		else output("bitch");
		output("'s lap, giggling as you feel it twitch happily inside you, but you're just getting started.");
	}
	//(BUTT CHANGE HERE)
	pc.buttChange(bunny.cockVolume(), true);
	output("\n\n");
	
	output("Your partner gasps in surprise as you pull yourself up, dragging her cock slowly through the tight ring of your pucker until she's about to slip out, and then dropping back down to envelop her again.  She involuntarily grunts wordless pleasure noises, thrilled with the sensation your warm body provides.  Her hands grab her nipples as you repeat your actions, working her with a slow, smooth rhythm that should bring her to orgasm... eventually.  ");
	if(pc.hasCock()) output("Each time she bumps and slides past your prostate a dollop of your pre-cum spurts from [pc.eachCock] onto the ground, and you have a hard time not using your new lover like an anal toy and masturbating yourself.  ");
	output("The long-eared slut makes a display of touching her nipples, pulling and twisting on them as you watch her over your shoulder.\n\n");
	
	output("Without meaning to, you begin to pick up the speed of your up and down strokes.  Your body is feeling horny and warm from all the sex, and having such a strange, attractive lover mating with your backside isn't helping.  ");
	if(pc.hasVagina()) {
		if(pc.isSquirter()) output("Juices begin to run from your [pc.vagina], but you ignore the empty feeling and focus on the throbbing meat inside your backdoor.  ");
	}
	output("Fingers find their way to your nipples without conscious thought, and begin ");
	if(!pc.hasFuckableNipples()) {
		output("pulling and tugging on them");
		if(pc.isLactating()) {
			output(", spurting out ");
			if(pc.milkQ() > 500) output("sprays");
			else output("drops");
			output(" of milk");
		}
		output(".");
	}
	else output("sliding inside them, fucking their cunt-like interiors as you start to lose yourself to the pleasure.");
	output("  The bunny reaches down to your [pc.ass] and gives it a gentle caress and squeeze.  A moment later both her hands are holding your butt-cheeks, guiding you up and down as you bounce atop her faster and faster.\n\n");
		
	output("You stroke the downy fur of her thighs through your fingers, marveling at her softness as you let the bunny start to set a tempo so fast that her pre-cum is squirting out with each wet, gushy fuck.   She occasionally gives your ass a gentle slap and starts moaning and panting out loud with every heated penetration, \"<i>Fuck... breed... mmm... yes... eggs eggs pleaseletmeegg!</i>\" It's hard to pay attention with the rising pleasure surging through your body");
	if(pc.cockTotal() > 0) {
		output(", and [pc.eachCock] pouring incredibly sticky pre-cum each time she squeezes your prostate");
	}
	else if(pc.hasVagina()) output(", and your [pc.vagina] clenching and dripping on the verge of orgasm");
	output(".", false);
	if(pc.isLactating()) {
		output("  [pc.Milk] ");
		if(pc.milkQ() < 500) output("leaks");
		else if(pc.milkQ() < 1000) output("drips");
		else output("pours");
		output(" from your [pc.nipples], turning your front to a leaky mess as you ride the very edge of pleasure.");
	}
	output("\n\n");
	
	output("Wait a second, what was that about eggs?  The confusion that comes with that thought distracts you enough to keep you from cumming, but the bunny orgasms before you have a chance to reconsider your position atop her.  She convulses, her rod twitching and thickening slightly, but you don't feel the warmth of erupting cum that you would expect.  You look down at her, but the bunny-girl is too insensate to provide any answer, and it's not until you notice that her balls are missing that you realize something is wildly different about the way her orgasms work.\n\n");
	
	output("You gasp in pain as the thickness at the base of your lover's shaft doubles.  It stretches your [pc.asshole] wide, almost painfully wide as something starts to push up her dick from the inside.  Before you can pull yourself off her, a massive gush of fluid drizzles inside of you, quickly numbing any pain and stealing the strength from your " + pc.legs() + " and muscles.  You twist back and forth, but the pleasure intensifies as the bulge slips past your sphincter, leaving your body slightly agape in its wake.  You find the rest of its passage to be more comfortable ");
	if(pc.cockTotal() > 0) {
		output("and as it squeezes past your prostate, [pc.eachCock] spurts thick [pc.cum] on the ground, though you don't QUITE orgasm.");
	}
	else output("and your arousal returns in force.");
	//(BUTT CHANGE HERE)
	pc.buttChange(bunny.cockVolume() * 2, true);
	output("\n\n");
	
	output("A moment before the bulge reaches the tip of the rabbit-cock, you feel another sliding through your [pc.asshole].  The bunny-dick's head thickens for a moment before it dwindles down to its normal shape.  You feel something warm and orb shaped inside you – it's an egg!  The strangeness of the insemination can't hold back the excitement your body built up or the feelings the second egg's passage is leaving in its wake, and you cum hard.  Somehow your body gets enough control to squeeze the girl's penis tightly, but all it accomplishes is speeding the eggs passage as it spurts into your rectum along with another big burst of pleasant, relaxing fluids.");
	if(pc.cockTotal() > 0) {
		output("  [pc.EachCock] erupts in truth, spraying and splattering white goop over the grass and ground.");
		if(pc.cumQ() > 500) output("  The splattering of your seed only increases in volume as it makes a rather large puddle");
		if(pc.cumQ() > 2000) output(", but you just keep going until you create a lazily winding river of cum that flows its way through the grasses");
		if(pc.cumQ() > 500) output(".");
	}
	if(pc.hasVagina()) output("  Your [pc.vagina] clenches, empty, drooling, and neglected, wishing it something inside it.");
	output("\n\n");
	
	output("You slide off still-dripping bunny-tool and roll onto your back, panting from the force of your orgasm and remarkably sated.   The eggs inside you don't feel uncomfortable at all, in fact, you barely notice them.  Looking over, you see the rabbit-girl is finally done cumming, though her eyes haven't quite rolled the whole way back down.  Exhausted and filled with pleasant hormones that make it hard to think, the both of you simply lie and rest a bit.\n\n");
	
	output("An indeterminate amount of time later, the cute bunny-girl is giving you a long, wet kiss on the lips.  She stops to whisper, \"<i>It's so good to finally think straight!  I don't know why I went into heat right now, but it's so much easier to think now that I've gotten rid of those eggs.  Don't worry, I'm sure you'll absorb them in a couple days and be fine.  Just don't be surprised if you feel a little bloated and weird.</i>\"\n\n");
	
	output("She walks away, her puffy tail twitching with the breeze while your eyes drift closed.");
	//(Easter ass-preg + 8 hours pass)
	//pc.buttKnockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS, 1, 1);
	pc.loadInAss(bunny);
	pc.orgasm();
	//dynStats("lib", 1, "sen", 1);
	pc.slowStatGain("l", 1);
	processTime(4 * 60 + rand(2 * 60));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//FUCK DAT BUNNYBUNBUNBUN.
private function bunbunGetsFucked():void {
	//spriteSelect(13);
	clearOutput();
	//Requires wang that fits
	var x:Number = pc.cockThatFits(cockVolume(40));
	//Second wang that fits for DP
	var y:Number = pc.cockThatFits2(cockVolume(40));
	
	output("You disrobe and toss your [pc.gear] to the side, immediately forgetting about it as the bunny-girl lifts her sack to expose the bright pink flesh of her femininity.  It glistens, practically steaming up the air with her plentiful lubricants.  She runs a slender finger around the moist hole, beckoning you to plunge inside and fill her hungry flesh with your [pc.cock " + x + "].  Lust burns through you as you drop to your knees and line your [pc.cock " + x + "] up with that ready opening");
	if(y != -1) output(", taking care to align your " + pc.cockDescript(y) + " with her tightly puckered backdoor as well.");
	else output(", barely able to restrain yourself as the time for penetration approaches.");
	output("\n\n");
	
	output("The nubile bunny's eyes cross as you push forwards, sliding your [pc.cockHead " + x + "] over her love-slicked lips until it has a generous coating and pressing harder.  ");
	if(y != -1) output("She squeaks at the pressure on her tender asshole, but doesn't object as your pre-cum smears over it.  ");
	output("At once, her greedy breeding hole relaxes ");
	if(y != -1) output("along with her anus ");
	output("and your " + pc.cockDescript(x));
	if(y != -1) output(" and " + pc.cockDescript(y) + " sink");
	else output(" sinks");
	output(" into her slippery, warm depths.  She pants and groans with happiness, going so far as to vocalize her pleasure, \"<i>Oooh yes, I don't know why but it feels just as good as breeding season!  If you keep this up, " + pc.mf("stud","sexy") + ", you might... ahhhh.. make me egg!</i>\"\n\n");
	
	output("You don't try to make sense of it and instead plunge further forward, watching with delight as more and more of your length is devoured by the horny bunny's body.  ");
	if(pc.cockVolume(x) >= 25) output("Her belly bulges pleasantly, displaying the vaguely cylindrical shape of a cock through her skin in a way that makes you feel utterly dominant over this 'female'.  ");
	output("Once you bottom out, the hermaphrodite actually starts to squirt pre-cum onto herself.  It isn't quite as much as you'd expect from a real orgasm, but it's enough that she makes a slippery mess of her tits and belly.  She gathers it up and starts stroking herself off with it, and you watch the enthusiastic bunny masturbate herself.\n\n");
	
	output("\"<i>Nooooooo,</i>\" she cries, thinking you meant to stop, but you savagely slam back in, rocking her body and making her petite, pre-cum-glazed tits jiggle pleasantly.   Her 'no' turns into an 'OHHH' in that split second, and before she can stop or catch her breath, you start fucking hard, watching her cum-shined breasts wobble underneath you.  ");
	if(y != -1) output("Her tight asshole slowly loosens around your " + pc.cockDescript(y) + ", and so much lubricant splatters from her cunt with each thrust that the sensations of both your dicks become nigh-identical, save for the tight ring gripping the bottom one.");
	else {
		output("So much lubricant splatters from her cunt that your thighs");
		if(pc.balls > 0) output(", belly, and balls");
		else output(" and belly");
		output(" are soon sticky with the stuff, but it only spurs you on to fuck her harder.");
	}
	output("\n\n");
	
	output("The bunny-girl never lets up on the fourteen inch monster between her legs, and it seems to have gotten a little bit thicker and harder from all the attention.  Her cock has never stopped dripping and spurting pre-cum in all this time, and she's turning into a syrupy, cum-slicked mess before either of you have even gotten off.  The moans and heat pouring off her loins make it very clear that's going to change very soon, so you reach down and give her taut ass a rough slap.  It sets off a far different orgasm than you would've expected.\n\n");
	
	output("Before your eyes the rabbit-girl's balls disappear and the flesh of her sack pulls tight against her.  It actually looks like she never had one at all.  You look to her for answers, but her eyes are rolled back, her body is quaking around you, and her mouth is babbling, \"<i>Eggfuck... eggbreedegg... ungungegg... eggegg,</i>\" over and over.  Her cunt clamps down on you with a vice-like grip that makes your eyes cross and your crotch bubble with the heat of a coming orgasm.");
	if(y != -1) output("  Surprisingly, her asshole stays about the same, but it was already a little tighter and you know you'll be pumping it full of [pc.cum] in a second.");
	output("\n\n");
	
	output("The bunny's convulsions take on a manic, thrashing pace, and before your eyes the base of her swollen cock begins to distend, nearly doubling in width from some internal object.  You wonder how she could enjoy something like that, but maybe her body is built for it?  It slowly works its way up the shaft while your long-eared lover stays locked in orgasm, panting, gasping, and leaking whiter-colored pre-cum that stops the convulsions anywhere it hits.  There must be something in it that forcibly relaxes the muscles, but before you can ponder it further your own climax has arrived.\n\n");
	
	output("You bottom out with brutal force");
	if(pc.balls > 0) output(", slapping your balls against her ass");
	output(", as your [pc.sheath] rubs her passion-inflamed pussy-lips.  [pc.EachCock] unloads, splattering out ropes of cum into ");
	if((pc.cockTotal() == 2 && y == -1) || pc.cockTotal() > 2) output("and onto ");
	output("the insensate bunny-breeder.  Her silken pussy milks and squeezes as you cum, seeming to draw your seed from your cock itself and pull it deeper inside, leaving none to waste.");
	if(y != -1) {
		output("  Her ass gurgles from your deposit");
		if(pc.cumQ() > 500) output(", and her stomach gains a bit of pudge from the copious jism deluge you pump into her");
		output(".");
	}
	if(pc.cumQ() > 500) output("  You keep cumming, slamming blast after blast of spooge into her welcoming nethers, delighted that none seems to leak out.");
	if(pc.cumQ() >= 1500) output("  Somehow her womb never seems to fill or bulge, even though you must be pumpings gallons of fertile baby-batter into her cunt.  By the time your orgasm winds down, you feel a little confused by it all, but sated.");
	output("\n\n");
	
	output("The bunny's swollen cock has pushed the bulge all the way up to the tip, though you see another forming at the base.  She doesn't seem to mind, in fact she actually stops babbling and moaning long enough to scream with delight as she launches an egg onto her tits.  It sits between her small mounds, rolling and dripping white goo onto her nipples.  Her dick spurts out a few more blasts of whatever her 'cum' is before trailing off.  The other bulge isn't far from her still-somewhat stretched tip, and you know she'll be 'laying' another egg soon.\n\n"); 
	
	output("There's a feminine grunt, a moan, and a burst of fluid as the second egg falls onto her belly.  The bunny-girl finally stops convulsing as she soaks herself with more white goop, and though her eyes make an attempt to focus on you, they seem a little more dilated than they should be.  The only movements she bothers to make are breathing and weakly pushing a globule of white stuff away from her eyes.  The bunny sighs dreamily while you pull out, and pets her eggs as she comes down from the absurdly long and unusual orgasm.\n\n");
	
	output("You ask her if that's normal, and she weakly nods.  A second later, a distinct rumble can be heard from the area of her groin.  You look at her as her cheeks turn red and she slowly starts to pant.  A moment later, her 'sack' reappears with a single 'ball' in it, though at this point you know what it is – an egg.  The bunny starts stroking her cock again, though this time without the feverish intensity she had before, and another egg drops down, restoring her 'pair'.");
	if(pc.cumQ() > 100) output("  A few seconds later another rolls in, cramming three into her increasingly obscene looking 'sack'.");
	if(pc.cumQ() > 250) output("  One more follows, giving her quads");
	var z:Number = 8 + rand(pc.cumQ() / 100);
	if(z > 50) z = 50;
	if(pc.cumQ() > 700) output(", but she's not done.  Her gut rumbles loudly, and then one after another egg after egg pours into the sack, stretching it out until you're sure she has at least " + z + " in there and will have trouble walking.");
	else output(".");
	output("  She moans contentedly and closes her eyes, sighing blissfully.\n\n");
	
	output("You shrug and pick up one of her eggs, noticing that it's turned neon pink in color.  The bunny mumbles, \"<i>Have it, iz good for youuuu...</i>\" before she starts to snore and murmur out a sexual dream.\n\n");
	pc.orgasm();
	processTime(20 + rand(20));
	pc.slowStatGain("l", 1);
	//dynStats("lib", 1, "sen", 1);
	
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCNeonPinkEgg()]);
}

private function bunbun69():void {
	//spriteSelect(13);
	clearOutput();
	clearMenu();
	var prevTail:Boolean;
	//Centaur
	if(pc.isTaur() && !pc.isFlexible()) {
		if(rand(2) == 0) {
			//should trigger if PC is a centaur and height > 4'0", since a horse <= 4feet could 69 the bunny >_>
			output("Without thinking it over beyond 'that sounds hot', you declare your intention to 69 the bunny girl.  She stands there, mouth hanging open and heat briefly forgotten.\n\n");
			
			output("\"<i>What?</i>\"\n\n");
	
			output("By now you've realized the absurdity of your statement, but you're too proud to admit it and simply restate your goal.  You cross your arms to try to look as serious as possible.  She looks down at your equine portion while idly stroking her cock, making sure your \"equipment\" is where she thinks it is.\n\n");
	
			output("\"<i>You're weird,</i>\" declares the rabbit.\n\n");
	
			output("Before you can return with a witty remark, the bunny has hopped off, leaving you alone in the field with your face in your palm.\n\n"); 
			//- Intelligence
			//+ Lust
			//pc.orgasm();
			//dynStats("int", -2);
			//pc.slowStatGain("i", -2);
			processTime(10 + rand(10));
			addButton(0, "Next", mainGameMenu);
		}
		else {
			output("Without thinking it over too hard beyond 'that sounds hot', you declare your intention to 69 the bunny girl.  She bursts into laughter.  You're a little perturbed by this and make it clear you're quite serious by restating your goal.\n\n");

			output("\"<i>No, no, stop – ahaha - you're killing me - haha!</i>\" she splutters.  \"<i>Hahaha - oh gods - I'm going to egg from laughter - HAHAHA!</i>\"\n\n");

			output("You realize the absurdity of your proposition just as she falls backwards, one hand on her belly and one on her cock.  You try to imagine some way to make your proposal work and save face, but the humiliation of having said something so ridiculous and thoughtless leaves you bereft of any more suggestions.\n\n");

			output("She's laughing so hard that her entire body starts to shake violently.  Thinking that it wasn't <i>that</i> funny, you're about to turn and leave when one of her testicles disappears.  You watch in mixed curiosity and confusion as the lump makes its way up the hysterical rabbit's cock and launches into the air, revealing itself to be a pastel pink and white egg.  You bend down to pick it up just as the other \"teste\" splatters onto your face.\n\n");

			output("\"<i>Hahah! Egg on your face! Ahahah!</i>\"\n\n");

			output("You wipe off what you can of the sticky goop and trot off with a scowl, leaving the hysterical rabbit to calm herself down.\n\n");
			//- Intelligence
			//pc.orgasm();
			//pc.slowStatGain("i", -2);
			//+ Lust
			//+ Pink Egg 
			processTime(10 + rand(10));
			itemScreen = mainGameMenu;
			lootScreen = mainGameMenu;
			useItemFunction = mainGameMenu;
			itemCollect([new CoCNeonPinkEgg()]);
		}
		return;
	}
	//Dudes
	if(pc.cockTotal() > 0) {
		////EASTER CANDY VERSION
		if(isEaster()) {
			output("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [pc.legs] on either side of her ears and lean down toward her crotch, savoring the slightly sweet scent of chocolate that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. Warily, you bring your nose up to her shaft and sniff, pleasantly surprised to find that the bulbs of sticky semen smell more like fresh marshmallows than the salty discharge you're used to. Actually, it smells really, REALLY good. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it's even better than it smells- like an orgy of cotton candy, marshmallows, and sweet juice swirling in your mouth, as tantalizing as the first spoonful of ice cream. Invisible bunny or no, you just have to get more of her cum!\n\n");
	
			output("Underneath you, the bunny seems to be admiring your length with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to try to lubricate you before taking your cock whole. A long, broad tongue licks up and down your manhood, hot and wet, her cute little nose rubbing against your bulging veins with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she decides that treating your dick like a popsicle isn't enough and guides your tip to her eager lips with hungry relish. She slips your cock into her mouth with a satisfied gulp and uses the edge of her tongue to massage just under your cockhead, pressing into the swell of flesh while she uses the ridges of the top of her mouth to tease your urethra, opening and closing the tender hole with every bobbing head motion.\n\n");
			
			output("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver like hot jelly. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as a jelly bean and you circle it with the tips of your fingers, almost as if trying to tease it out of its dark chocolate-colored fleshy hood.\n\n");
			
			output("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's frenzy is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into a deep throat. You begin to choke in response to the sudden intrusion, but the bunny is just as eager to get cream-filled as she is to give you a rich, chocolate center. With a gleeful 'squeek' noise she opens her esophagus and works her head deeper onto your shaft, her broad, gentle rabbit teeth pressing your over-burdened veins just enough to send shivers through your body.");
			//[8"+ : 
			if(pc.cocks[0].cLength() >= 8) output("  As she passes six inches into her throat, her sucking grows more anxious, her arms wrapping around your hips, fingers digging into your ass, drawing your groin down faster.");
			//[12"+ : 
			if(pc.cocks[0].cLength() >= 12) output("  You can't concentrate with a foot of bunny cock plowing your lungs so you aren't prepared for the girl's desperation until it boils over. She takes a deep breath through her tiny nostrils and slams her head as hard as she can into your groin, fucking your cock with her face until the soft folds of her throat part and she buries her freckled cheeks in your thighs.");
			output("\n\n");
			 
			output("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n");
			
			output("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your [pc.chest] has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like taffy to your forceful grip. Digging in as many as you can fit, you hook your fingers around and drag them out until you find the squirming girl's G-spot. Her frenzied hops cease immediately and her whole body quivers in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your straining inches. You pull against her grip, the egg-shaped bulge of her testicle working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of marshmallow cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sugarcoated ejaculate when your attempt to swallow her load closes your esophagus. The girl's testicle plops into your mouth a moment later and you're relieved to find that it seems to be an egg that's rolling around your tongue.\n\n");
			
			output("Still possessed by the delirious breeding hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's egg-ball slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've just finished eating a small mountain of candy treats. A surge of heat stuffs your belly like a confectionary oven and the bunny's egg between to bloat, soaking up her cum and your body heat, growing like a baking cake inside you. You become dizzy from the bunny's stuffing and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say you don't want seconds. The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your ");
			if (pc.balls > 0) output("balls");
			else if (pc.hasVagina()) output("clit");
			else output("[pc.sheath]");
			output(", whiskers vibrating with a happy little hum, her buck teeth massaging your root enthusiastically, impatient for her Champion-cream filling. Her hands slide from the back of your head, along your neck, down your back, and to your ass, fingers wrapping around to find your [pc.vagOrAss]. Slipping both middle fingers in, she strokes your ");
			if(!pc.hasVagina()) output("prostate");
			else output("inner walls");
			output(" until your orgasm overpowers your saccharine-fat daze and you peak, egg-bloated body spurting in creaming jets of pale seed to paint the brown bunny's insides white.\n\n");
			
			output("Her second egg forces its way down your throat with gushing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your cock or maybe it's the swelling of the second egg, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, willing yourself to digest the bunny's candy eggs and, to your surprise, your belly slows its expansion, gradually shrinking as the eggs burst in your stomach, unloading their gooey candy filling.");
			//pc.refillHunger(60);
			prevTail = pc.hasTail();
			if(!pc.hasTail(GLOBAL.TYPE_LAPINE) && Mutator.changeTail(pc, GLOBAL.TYPE_LAPINE, 1, [GLOBAL.FLAG_FURRED], null, null, false)) {
				//[No Tail: 
				if(!prevTail) output("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as a fluffy bunny's tail pops out of your back, twitching excitedly!");
				//Existing tail: 
				else output("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into a cuddly, twitching bunny tail!");
			}
			if(pc.earType != GLOBAL.TYPE_LAPINE && Mutator.changeEars(pc, GLOBAL.TYPE_LAPINE, 0, false)) {
				output("  The top of your head is next, it seems.");
				//[No antennae:
				output("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and large, floppy bunny ears bounce in front of your eyes.");
			}
			output("\n\n", false);
			
			output("With a happy sigh, the girl slides off of your cock and lets it flop against your leg, not a single drop of cum wasted. Her belly has ");
			if(pc.cumQ() < 250) output("a slight swell");
			else if(pc.cumQ() < 1000) output("a noticeable girth");
			else output("bloated obscenely");
			output(", your spunk calming the egg-laying passion that had her bouncing like whipped caramel. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her rich cum sweet on your lips. She rises to a crouch and gives your new ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Hope you had a happy, tasty day! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still feeling fat and bloated from the 'meal.'\n\n");
			
			pc.loadInMouth(bunny);
			pc.orgasm();
			pc.slowStatGain("l", 1);
			processTime(30 + rand(20));
			addButton(0, "Next", mainGameMenu);
		}
		//REGULAR SHOW
		else {
			output("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [pc.legs] on either side of her ears and lean down, toward her crotch, savoring the slightly sweet scent that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it gives you an oddly numb feeling in your mouth, cold and warm at once, but making the flesh inside your cheeks swell a bit, tightening your mouth.\n\n");
			
			output("Underneath you, the bunny seems to be admiring your length with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to try to lubricate you before taking your cock whole. A long, broad tongue licks up and down your manhood, hot and wet, her cute little nose rubbing against your bulging veins with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she mumbles something about 'eggs' and guides your tip to her eager lips with hungry relish. She slips your dick into her mouth with a satisfied gulp and uses the edge of her tongue to massage just under your glans, pressing into the swell of flesh while she uses the ridges of the top of her mouth to tease your urethra, opening and closing the tender hole with every bobbing head motion.\n\n");
			output("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver with a breeder's anticipation. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as the tip of your pinkie and you circle it with your fingers, trying to tease it out of its pink, fleshy hood.\n\n");
			
			output("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's face-fucking jubilation is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into your neck. You begin to choke in response to the sudden intrusion, but the bunny's trickling pre-cum provides a woozy numbness that relaxes your gag reflex and swells your throat into a soft, squishy tunnel, pulsing with cunt-tightness. Rocking her head in time to her hips, she seems just as eager to earn your load as she is to give you hers. With a gleeful 'squeek' noise she opens her esophagus and works her mouth deeper onto your shaft, her broad, gentle rabbit teeth pressing your over-burdened veins just enough to send shivers through your body.");
			//[8"+ : 
			if(pc.cocks[0].cLength() >= 8) output("  As she passes six inches into her throat, her sucking grows more anxious, her arms wrapping around your hips, fingers digging into your ass, drawing your groin down faster.");
			//[12"+ : 
			if(pc.cocks[0].cLength() >= 12) output("  You can't concentrate with a foot of bunny cock plowing your lungs so you aren't prepared for the girl's desperation until it boils over. She takes a deep breath through her tiny nostrils and slams her head as hard as she can into your groin, fucking your cock with her face until the soft folds of her throat part and she buries her freckled cheeks in your thighs.");
			output("\n\n");
			
			output("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n");
			
			output("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your [pc.chest] has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like velvet to your forceful grip. Digging three fingers in, you hook your fingers around and drag them along the girl's quivering walls until her choked squeals tell you that you've found her most sensitive spot. Her gleeful hops cease immediately and her whole body trembles in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your groin. You pull against her grip, the egg-shaped bulge working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of tingling cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sticky ejaculate when your attempt to swallow her load closes your esophagus. The girl's load rolls in your mouth for a moment and you find that the cummy mess seems to have deposited an egg on your tongue!\n\n");
			
			output("Still possessed by the delirious egg-laying hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's load slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've been swallowing spunk and eggs for hours. You become dizzy from the bunny's numbing jizz and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say 'no more.' The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your ");
			if(pc.balls > 0) output("balls");
			else if(pc.hasVagina()) output("clit");
			else output("groin");
			output(", whiskers vibrating with a happy little hum, her buck teeth massaging your root enthusiastically, impatient for her own creamy meal. Her hands slide from the back of your head, along your neck, down your back, and to your ass, fingers wrapping around to find your [pc.vagOrAss]. Slipping both middle fingers in, she strokes your ");
			if(!pc.hasVagina()) output("prostate");
			else output("inner walls");
			output(" until your orgasm overpowers your bunny-fucked daze and you peak, your egg-bloated body spurting in gushing jets of pale seed to paint the olive girl's insides white.\n\n");
			
			output("Her second egg forces its way down your throat with pulsing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your cock or maybe it's the swelling numbness of the eggs, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, grunting through the heat of the bunny's eggs and, to your surprise, your belly begins to feel like it's emptying.");
			//pc.refillHunger(60);
			prevTail = pc.hasTail();
			if(!pc.hasTail(GLOBAL.TYPE_LAPINE) && Mutator.changeTail(pc, GLOBAL.TYPE_LAPINE, 1, [GLOBAL.FLAG_FURRED], null, null, false)) {
				//[No Tail: 
				if(!prevTail) output("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as a fluffy bunny's tail pops out of your back, twitching excitedly!");
				//Existing tail: 
				else output("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into a cuddly, twitching bunny tail!");
			}
			if(pc.earType != GLOBAL.TYPE_LAPINE && Mutator.changeEars(pc, GLOBAL.TYPE_LAPINE, 0, false)) {
				output("  The top of your head is next, it seems.");
				//[No antennae:
				output("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and large, floppy bunny ears bounce in front of your eyes.");
			}
			output("\n\n");
			
			output("With a happy sigh, the girl slides off of your cock and lets it flop against your leg, not a single drop of cum wasted. Her belly has ");
			if(pc.cumQ() < 250) output("a slight swell");
			else if(pc.cumQ() < 1000) output("a noticeable girth");
			else output("bloated obscenely");
			output(", your spunk calming the egg-laying passion. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her strange cum sweet on your lips. She rises to a crouch and gives your ");
			if(pc.earType != GLOBAL.TYPE_LAPINE) output("new ");
			output("ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still recovering from the eggs.");
			
			//dynStats("lib", 1, "sen", 1);
			pc.loadInMouth(bunny);
			pc.orgasm();
			pc.slowStatGain("l", 1);
			processTime(30 + rand(20));
			addButton(0, "Next", mainGameMenu);
		}
	}
	//CUNTS
	else {
		output("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [pc.legs] on either side of her ears and lean down, toward her crotch, savoring the slightly sweet scent that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it gives you an oddly numb feeling in your mouth, cold and warm at once, but making the flesh inside your cheeks swell a bit, tightening your mouth.\n\n");
		
		output("Underneath you, the bunny seems to be admiring your pussy with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to keep herself from jamming her nose into your hot gash. Her long, broad tongue licks up and down your womanhood, hot and wet, her cute little whiskers rubbing against your labia with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she mumbles something about 'eggs' and guides her teeth to your clitty with hungry relish. Using her teeth and her tongue, she strokes your sensitive button like she's wetting the tip of a carrot. She slips her tongue into your folds with a panting gladness. \"<i>Please please please please,</i>\" she chants, lips drinking in your moisture with each breath. \"<i>Must lay eggs, must breeeeeeed,</i>\" she whines before flicking her tongue into your inner labyrinth, flicking rapidly as her buck teeth massage your enflamed clit, every head bob sending shivering weakness through you from the delightfully cold incisors.\n\n");
		
		output("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver with a breeder's anticipation. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as the tip of your pinkie and you circle it with your fingers, trying to tease it out of its pink, fleshy hood.\n\n");

		output("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's face-fucking jubilation is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into your neck. You begin to choke in response to the sudden intrusion, but the bunny's trickling pre-cum provides a woozy numbness that relaxes your gag reflex and swells your throat into a soft, squishy tunnel, pulsing with cunt-tightness. Rocking her head in time to her hips, she seems just as eager to earn your orgasm as she is to give you hers. With a gleeful 'squeek' noise she opens her mouth wider than you would've believed possible and feeds her broad tongue into your nethers filling you with muscled flesh as thick as a cock, her gently stroking rabbit teeth pressing your over-stimulated clit just enough to send orgasmic shivers through your body.\n\n");
		
		output("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n");
		
		output("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your [pc.chest] has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like velvet to your forceful grip. Digging three fingers in, you hook your fingers around and drag them along the girl's quivering walls until her choked squeals tell you that you've found her most sensitive spot. Her gleeful hops cease immediately and her whole body trembles in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your groin. You pull against her grip, the egg-shaped bulge working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of tingling cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sticky ejaculate when your attempt to swallow her load closes your esophagus. The girl's load rolls in your mouth for a moment and you find that the cummy mess seems to have deposited an egg on your tongue!\n\n");
		
		output("Still possessed by the delirious egg-laying hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's load slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've been swallowing spunk and eggs for hours. You become dizzy from the bunny's numbing jizz and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say 'no more.' The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your vulva, whiskers vibrating with a happy little hum, her buck teeth massaging you enthusiastically, impatient for her own creamy meal. Her hands slide from the back of your head, along your neck, down your back, and to your rump, fingers wrapping around to find your sphincter. Slipping both middle fingers in, she strokes your inner walls with fingers and tongue until your orgasm overpowers your bunny-fucked daze and you climax again, your egg-bloated body spurting in gushing jets of female lubrication into the olive girl's twitching nose.\n\n");
		
		output("Her second egg forces its way down your throat with pulsing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your clit or maybe it's the swelling numbness of the eggs, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, grunting through the heat of the bunny's eggs and, to your surprise, your belly begins to feel like it's emptying.");
		prevTail = pc.hasTail();
		if(!pc.hasTail(GLOBAL.TYPE_LAPINE) && Mutator.changeTail(pc, GLOBAL.TYPE_LAPINE, 1, [GLOBAL.FLAG_FURRED], null, null, false)) {
			//[No Tail: 
			if(!prevTail) output("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as a fluffy bunny's tail pops out of your back, twitching excitedly!");
			//Existing tail: 
			else output("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into a cuddly, twitching bunny tail!");
		}
		if(pc.earType != GLOBAL.TYPE_LAPINE && Mutator.changeEars(pc, GLOBAL.TYPE_LAPINE, 0, false)) {
			output("  The top of your head is next, it seems.");
			//[No antennae:
			output("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and large, floppy bunny ears bounce in front of your eyes.");
		}
		output("\n\n");
		
		output("With a happy sigh, the girl rubs your slick honey off of her face and gives your clit a final, pleased lick. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her cum sweetly icy on your lips. She rises to a crouch and gives your ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still recovering from the eggs.");
		pc.loadInMouth(bunny);
		pc.orgasm();
		pc.slowStatGain("l", 1);
		processTime(30 + rand(20));
		addButton(0, "Next", mainGameMenu);
	}
}


//Bee on Bunny, by Eliria
//Coded or questionable parts are in {}.
//Thank you for your time! Scene as follows (also in attachment):
//public function layEggsInBunbuns():void {
	//clearOutput();
	//output("The displayed lapin in front of you has you excited, but not for a simple roll in the grass.  Your ");
	//if(pc.eggs() < 20) output("eager egg-tube slips free, ready to show the rabbit you can play the egg game too.");
	//else if(pc.eggs() < 40) output("distended bug part quivers in anticipation, the ovipositor pushing into view with a drop of honeyed pre on its tip.");
	//else output("low-hanging bee abdomen drools honey-like ichor down its carapace from the bulge where the thick black organ shows its need to relieve your burden.");
	//output("  The bunny gasps upon noticing it, the herm's hips wiggling. \"<i>Oh my, could... could you mount me with that?  I need to egg so badly.</i>\"  Not needing to be urged further, you arch your bee-section up underneath you while lifting the lusty bunny against you.");
	//output("\n\nPulling her so that she presses her tits against your [pc.chest], the throbbing egg-depositor rubs between her legs.  With a high squeal she pushes forward harder, the long lapin cock twitching with her heartbeat");
	//if(pc.gender == 0) output(" against the empty place of your crotch.");
	//else {
		//if(pc.hasCock()) output(" alongside [pc.eachCock]");
		//if(pc.hasVagina()) output(" and her hefty oval balls rubbing the [pc.vagina] tucked between your thighs");
		 //output(".");
	//}
	//output("  She braces herself with arms around your shoulders, trying to nearly jump onto you as you ram your engorged ovipositor into her tight ass.");
	//
	//output("\n\nYou shudder, adjusting to her position and beginning to buck up in order to stuff the length of flesh deeper into the warm passage under the rabbit's tail.  Wiggling her hips as it pushes half of itself further, the egg-chute pulses, then deposits some bee-secretion into the happy companion.  Having prepared her insides, your organ and abdomen flexes, sticking the egg-tunnel up to its base.");
	//output("\n\nThe forces moving along the sensitive shaft give you a pseudo-orgasm, pushing an egg down the flesh-tube pleasurably slow.  She relaxes a moment, tongue hanging out cutely before her big dick spurts pre onto your stomach and [pc.chest] just as the first ovoid finds her puckered entrance.  Another egg finds its way from your cache as soon as the first passes the entrance and joins it on its way to being planted inside her.");
	//
	//output("\n\nShe continues writhing against you, bouncing up and down against the bee-abdomen and working the eggs in faster.  As you feel the first one reach the end of the trail you find yourself experiencing an ecstatic energy");
	//if(pc.gender > 0) {
		//output(", ");
		//if(pc.hasCock()) output("[pc.eachCock]");
		//if(pc.gender == 3) output(" and ");
		//if(pc.hasVagina()) output("your [pc.vagina]");
		//output(" lathering the bunny-girl in ");
		//if(pc.hasCock()) output("spunk");
		//if(pc.gender == 3) output(" and ");
		//if(pc.hasVagina()) output("femcum");
	//}
	//output(".  Stuffing a warm hole with egg after egg is not only fulfilling (for <i>both</i> involved) but is also damn fun, which the rabbit agrees with!");
	//output("\n\nAnother egg, then another and another pump down your egg-cock with plenty of honeyed goo between to push her belly further and further out. You lose count of how many slip into her, completely engulfed by the orgasmic joy. Your legs had given out sometime during the process and the hour has passed, but it doesn't matter to you so long as there is another egg to lay.");
	//
	//output("\n\nYour front is coated with the bunny-girl's spooge, dripping down both your thighs onto the yellow and black chitin of your bee-abdomen.");
	//if(pc.gender > 0) {
		//output("  You add to the mess, ");
		//if(pc.hasCock()) output("spraying a long, thick load against the bunny's soft tits from [pc.eachCock]");
		//if(pc.gender == 3) output(" and ");
		//if(pc.hasVagina()) output("splashing her balls with your girlcum");
		//output(".");
	//}
	//output("\n\nFinally you find you no longer have any to give to the egg-obsessed rabbit girl and the ovipositor retracts into its slit.  Tired but blissful, she curls up to slumber, and you leave her to deal with having a stomach chock full of eggs 'n honey, returning to camp until you once again need a warm body to play host.");
	//pc.dumpEggs();
	//pc.orgasm();
	//doNext(returnToCampUseOneHour);
//}


//public function ovipositBunnyEaster():void {
	//clearOutput();
	//output("Smiling a little over-eagerly, you suggest, \"<i>You know, if you really like eggs, I know where you can get a few...</i>\"");
	//output("\n\n\"<i>Oh?  Where's that?</i>\" she responds, both her floppy ears standing up stock-straight and quivering with excitement.  She hops over to you, unconsciously letting her dripping phallus bob ponderously with each jump, the inertia turning it into a sexual pendulum of ridiculous, fourteen-inch proportions.  \"<i>Are they behind you?</i>\"");
	//output("\n\n\"<i>It's a surprise,</i>\" you promise, \"<i>Get on all fours, and I'll give you all the eggs you could ever want.</i>\"");
	//output("\n\nThe confused, almost clueless look in her eyes betrays her hesitancy, but she obeys, spurred by needs she doesn't even seem to truly understand.  Her poofy little tail flips up as far as it can, and you're treated to the sight of her big, surprisingly muscular rump.  All that hopping around has done wonderful things for her rear, and the bunny-girl's thighs are similarly toned, obscured only by a hint of fat and her down-soft fur.  You can see moisture running freely from a puffy pink mound, much of it clinging to her smooth sack's gentle, oblong curves.  She shudders slightly as the enormity of the pose she has struck settles into her mind.");
	//
	//output("\n\nYou don't give her a chance to regret adopting such a sensual stance.  Instead, you grab two big handfuls of furry butt and squeeze as you climb atop her, not as a male taking a female but as an ");
	//if(pc.canOvipositBee()) output("insect");
	//else output("arachnid");
	//output(" claiming an incubator.  When she feels your groin pressing on the small of her back, the fluffy hare grows concerned, looking over her shoulder and declaring, \"<i>You... you can't put eggs in me like THAT!</i>\"");
	//output("\n\nYou snicker and pat her right between the ears, even stretching down to lick at the flawless, dusky skin of her shoulder, tasting the salty flavor of the sweat she's started to bead.  Suggestively, you whisper, \"<i>Oh, I brought you LOTS of eggs...</i>\"");
	//
	//output("\n\nOn instinct, your ovipositor slides free of the concealing slit on your abdomen in an instant, spraying a fan of slippery, lube strands across the bunny-girl's tight ass.  The exotic organ squeezes right through her plush bottom-cleavage, twitching with pleasure as the rounded tip glides through the folds of her pussy, smearing fresh lubricant over itself and the ready, heated lips.  It goes on to bump up against the lapine woman's newly-exposed clit, which forms the perfect backstop for your ovipositional onslaught.  She gasps beneath you, squirming her fuzzy hips back at you as she reacts to the sensations unthinkingly.  Her damp nethers flush hotter, and you can feel a trickle of wetness dripping out of her snatch and down your alien rod.");
	//
	//output("\n\nYou chitter excitedly at the thought of having such a willing partner, and shift slightly, adjusting your egg-bound abdomen in an attempt to line up with the thick-thighed woman's entrance.  Her squirming and wiggling doesn't make it much of an easy task.  Again and again, you smack your thick tool into her butt, into her sack, or across one of her furry cheeks.  The attempts excite her further, to the point where she's openly moaning and crying, \"<i>Ohhhh, you're gonna egg me right?  Mmm, yeah, egg me!  Please, egg me!  I... I need them!</i>\"");
	//output("\n\nIf she'd settle down, you'd already be filling her!  The troublesome slut is holding herself up with one hand and using the other to pump away at her disproportional dong with feverish, sloppy strokes, her pre noisily schlicking across her length with every stroke.  She's so big that you can think of an easy way to silence her...  You push down on the back of her head and drive the tip of her gushing cock-tip straight into her mouthy little maw.  She struggles at first, but as her pre-cum pools in between her lips, the fight flows out of her.  Drooling and moaning incoherently, her hips begin to rock slightly as her shoulders relax.  Her spittle hangs in long strands and froths at the corners of her mouth as she starts to autofellate, eyes slightly unfocused and body relaxing as if under the influence of some kind of drug.");
	//
	//output("\n\nLuckily, one of her backstrokes presses her juicing mound perfectly against your prong.  You gasp as more of it pushes free from your slit.  The fresh inches ensure that you're immediately docked with her fertile innards, connected by the thick protrusion while your eggs roll into position, some already migrating down the hollow tube, much to your relief and excitement.  Grabbing hold of her nerveless, relaxed shoulders, you pivot your body to force yourself deeper, the slick lubricants already running out of you to mix with the bunny's own.  Her lapine body is just waiting to be bred; you can feel it in the heat of her tunnel and the way it squishes down around your ovipositor.  You give up your own sigh of indulgence and relax muscles you didn't know you had, releasing your cargo to flow into your moaning mate.");
	//output("\n\nYour prong ripples and distends to make room for what's passing through it, though the tip is still narrow enough that you can easily poke it through the bunny-gal's dilating cervix.  You actually felt it starting to yawn open before you plunged it into her womb, and it's still spreading even now, allowing you to spear deeper and deeper with each push.");
	//
	//output("\n\nSuddenly shifting, the hare-woman's body tilts as her arms give out, uselessly splayed alongside her.  Her dick is still barely inside her mouth, but the flow of pre-cum seems to be even faster than before.  Her cheeks keep puffing out with whenever a fresh wave of the stuff rolls into her maw, and though her throat is swallowing and unchecked rivers of the stuff leak out through the loosening seal around her shaft, you can tell she's just getting started.  Of course, the way she's just completely relaxing into your fuck hasn't stopped her from humping her own mouth or having her pussy caress your prong.  Sexual instinct seems largely unaffected by whatever her pre-cum is doing to her...");
	//output("\n\nYou let your muses fade into the gentle thrum breeding pleasure that's taken hold of your mind.  Moving with swift contractions down your fleshy tube, many of your eggs are already stretching you and the bunny-girl out.  They glide through you and her together, setting off cascades of delightful nerve-impulses in both your bodies.  When the first one crests through her opened cervix, you're transported to an ecstatic nirvana.   Gentle, muffled 'pops' can be heard whenever one of your spheres is released from your prong.");
	////{Some Eggs}
	//if(pc.eggs() < 20) {
		//output("\n\nOne after another, your eggs are perfectly deposited in the lapine's now-conquered womb.  It does not take long, as you didn't have that many eggs built up, but the pleasure from your organ is too great to simply withdraw.  You keep yourself buried inside and continue to slowly ply the slippery quim with your insectile tool, releasing plenty of lubricant for your eggs to swim in.  Your rutting [pc.hips] keep their slow tempo until you run out of liquid to inject.  The orgasms are all blurred together, one after another, such that all you can really remember is a haze of pleasure and grinding bodies.");
	//}
	////{Plenty of eggs}
	//else if(pc.eggs() < 40) {
		//output("\n\nOne after another, your eggs lurch into the conquered womb in a steady stream of oviposition, each one coming closer on the heels of the previous one.  You release a whimper of bliss at the same time as your incubator, her tight pussy actually trying to milk you of sperm.  Of course, that just makes your eggs flow into her that much faster.  Her uterus is soon stuffed with your ");
		//if(!pc.canOvipositBee()) output("arachnid");
		//else output("insectile");
		//output(" cargo, but you aren't empty, so you force more and more inside her.  She's so stretchy that it's easy to do, and before long she has a nicely rounded, pregnant belly (even if it is a little bit bumpy).  Shuddering, you release a few long, thick squirts of lubricant over your leavings and sag down, spent.");
	//}
	////{Lots of Eggs!}
	//else {
		//output("\n\nOne after another, your eggs are forcefully crammed into the lapine's conquered womb.  You've got so many that the spheres seem like an endless tide, one that feels like an equally endless orgasm, a constant surge of sexual release directly into the deepest part of your limp mate's incubator.  She's filled almost immediately, but you just keep forcing egg after egg into her.  At first, this only rounds her belly slightly.  You just keep going and going ");
		//if(silly()) output("like an energizer bunny");
		//else output("like some kind of endless, pregnancy-inducing fuck-beast");
		//output(", forcing your willing prey's womb to stretch to new limits, so huge and full that it's pressing against the ground.  Rounded, pebble-like protrusions are visible on the gravid dome, each one of your deposits.  You groan as you push the last one inside of her and begin to drain the last of your lubricants inside her, savoring the last of your pleasure as you come down from the immense high.");
	//}
	////{END FORKS}
	//output("\n\nYou climb off as your ovipositor retracts into its slot.  The emptiness is a blessed change from the constant, needy weight of an unlaid brood.  As you gather your wits, you realize that the bunny-girl is still orgasming.  Her dick finally popped out of her mouth, and you're treated to the sight of her bukkaking herself with thick, clear sex-juice.  A huge bulge distends her urethra as it's forced through her shaft, erupting out into a bright pink egg.  It bounces off her drugged, dopey cheek as her nerveless lips try to moan, followed shortly after by a second.  In the wake of the two surprises, a wave of jism splatters across her head, plastering her ears back into her hair.");
	//output("\n\nThe hare goes limp after that, her eyes drifting shut as her tongue idly licks her spent seed from her face.  It looks like she got more eggs than she reckoned for.");
	////ITS OVER
	//pc.dumpEggs();
	//pc.orgasm();
	//dynStats("sen", -2);
	//doNext(returnToCampUseOneHour);
//}

//Bunny Girl Eggsplosion 
//Additional, low chance encounter in the plains. Options in parentheses should be adjusted to the following format: (Normal text/ Easter text)
 //-----------
private function adjathaEggsplosions():void {
	clearOutput();
	output("Your trek through the plains is interrupted by a shrill, piercing cry that jolts you out of the daydreams that were floating through your mind.  The piercing wail of a woman in distress grabs your attention and you hurry over the rising hills to the source of the howling bluster.  You weren't sure exactly what to expect, but as the source of the commotion comes into view, you have to admit this wasn't exactly what you thought you'd find.");
	
	output("\n\nLying in a shallow valley is a ");
	if(!isEaster()) output("dusky");
	else output("chocolate");
	output(" skinned woman.  Atop her ");
	if(!isEaster()) output("tanned");
	else output("caramel");
	output(" head, two large pairs of bunny ears flop back and forth helplessly as she shakes her head in frustrated tension. Her long, muscled legs kick the ground in futile anguish, though you notice her feet are long and fuzzy, ending in thick paws with little pink pads underneath. Her arms appear to be secured behind her back by a corded rope that has her bound to a pair of tawny boulders. Between her legs, a fourteen inch erection throbs, fully erect and frothing with ");
	if(!isEaster()) output("thin, gushing pre-cum");
	else output("thick, syrupy cream");
	output(". It's a bunny-girl, certainly, but who would go through the effort of tying her up and then just leave?");
	
	output("\n\nAs you approach, she takes notice of you, turning her full attention to you with desperation dripping from every pore of her freckled, ");
	if(!isEaster()) output("olive");
	else output("cinnamon");
	output(" skin.  \"<i>Oh thank goodness,</i>\" she pants, her tongue lolling under her tiny buck teeth.  \"<i>You have to help me,</i>\" the ");
	if(!isEaster()) output("coffee");
	else output("toffee");
	output("-colored woman implores.  \"<i>I was minding my own business when some gnoll lady charged me and knocked me out!  When I came to, she'd bound me up and said she was leaving me here as punishment for invading her lands.  I've been helpless for hours and monsters keep finding me!</i>\"  You notice that a steady stream of pale semen leaks from between her legs - the sticky aftermath of those who found her before you.  Glancing at the ground, there are dozens of footprints in the loamy soil, most of them with cum pooling in the depressions. Considering the cacophony she was making just a moment ago, it's no wonder everything in the area seems to have found and sated themselves in her.");
	
	output("\n\n\"<i>That's not even the worst paaaaaaart!</i>\" she moans, squeezing her knees together tightly, trying to rub the throbbing back of her untended erection.  You notice a small, metallic glimmer at the base of her shaft and realize that the gnoll left her with a bronze cock-ring.  With her hands tied behind her, the bunny girl's been unable to get off throughout a full day of being fucked by anything with a sex drive.  A thought strikes you and you look at the boulders she's bound to a little closer.  Sure enough, what you mistook for darkish, strangely spherical stones are, in fact, the bunny girl's balls.  The swarthy surface strains with bloated need, their burden ballooning her taut testes with a throbbing multitude of eggs.  \"<i>Pleeeeeease! You've gotta let me go!  The pressure's unbearable!</i>\"  You notice a dangerous glint in her eyes as she says it, eyeing your [pc.ass] with a frantic madness.  You could let her go, if you wanted, or use her like everyone else who's come before you.  Alternately, you could leave her bound and get her eggs out on your own terms.");
	
 	output("\n\nWhat will you do?");
	
	clearMenu();
	
	addDisabledButton(1, "Get Egged", "Get Egged", "This scene requires you to have vagina.");
	addDisabledButton(2, "Fuck Her", "Fuck Her", "This scene requires you to have fitting cock.");
	
	//[Free Her (any)] [Fuck Her (male/futa)][Get Egged (female/futa)] [Leave]
	//[Free Her] (Any gender)
	addButton(0, "Free Her", freeHerOhGodWhyDidYouDoThis);
	//[Get Egged] (Female/Futa only)
	if (pc.hasVagina()) addButton(1, "Get Egged", getEggflated);
	//[Fuck Her] (Male/Futa Only)
	if (pc.cockThatFits(cockVolume(40)) >= 0) addButton(2, "Fuck Her", fuckTheEggBoundBun);
	
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
 
//[Free Her] (Any gender)
private function freeHerOhGodWhyDidYouDoThis():void {
	clearOutput();
	output("Taking a chance, you step up to the wriggling bunny and inspect her bonds.  The girl's body is covered in a ");
	if(!isEaster()) output("sheen of sweat");
	else output("shimmering glaze");
	output(", her urgent lust pulsing in every inch of her ");
	if(!isEaster()) output("freckled brown");
	else output("pudding rich");
	output(" skin.  Her abdomen is slightly rounded with a pot-bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her ");
	if(isEaster()) output("cony ");
	output("cock jerks in the air with every hyperventilating breath, ");
	if(!isEaster()) output("bubbling pearls");
	else output("gooey marshmallows");
	output(" of pre dribbling from the narrow, spear-like crest. The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if(!isEaster()) output("the carnal fruit of her unwelcome, monstrous couplings");
	else output("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	output(". She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	output("\n\nGently bending her forward at the waist, you examine the ropes around her wrists.  They appear to have been tied with a simple slip knot designed to cinch tighter the harder she struggles against it.  The girl's tuffed tail twitches eagerly atop her supple rump, as she bobs up and down on her large bunny toes.  With a few firm tugs, you manage to undo the cords and let her arms loose.  You almost expect the bunny-girl to make a grab for you, but she's so overcome by the need for release, she all but forgets her emancipator.  Breathlessly, the energetic hare seizes the constraining loop of metal and rolls it off her shaft with moaning delight, throwing it into the tall grasses triumphantly.");
	
	output("\n\nBefore the cock ring even lands, she's sunk to her knees, both hands pumping her length feverishly, coaxing her pent-up reservoirs to sweet release.  The behemoth balls next to you churn and gurgle in sympathetic fervor, trembling at the intensity of her passion.  A thick bulb forms at the base of her member, the pliant flesh distending to twice its normal girth.  Slowly, achingly, the protuberance is forced up her fourteen inch rod, the tip of her cockhead dilating like a gaping mouth.  Then, with a loud, gushing pop, the first egg spurts from her breeding pole, shooting through the air at the head of a tremendous fountain of ");
	if(!isEaster()) output("splattering spoo");
	else output("climaxing cream");
	output(".  The showering spray continues in an unbroken outpouring, a river of alabaster arcing and gushing in a throbbing surge that white-washes everything within ten feet of her frontal arc.  Countless ");
	if(!isEaster()) output("bright pink eggs");
	else output("candy-coated confections");
	output(" issue forth amid the ");
	if(!isEaster()) output("cum");
	else output("icing");
	output(" geyser, plopping moistly here and there.  Some stop in plain sight, others roll into hidden hollows, left for some curious treasure hunter.");
	
	output("\n\nGasping and squealing in unfettered release, the bunny girl continues pumping her torrential spigot with one hand while the other runs across her heaving, glistening breasts, pinching her ");
	if(!isEaster()) output("pert");
	else output("gum drop");
	output(" nipples as her big, soft toes dig rutting furrows into the ground beneath her.  Her orgasmic throes send spasms of bliss through her whole body, her clenched inner muscles finally relaxing enough to release the jism inside her womb, vulgar globules oozing down her trembling inner thighs.");
	
	output("\n\nThe frantic pace of her initial discharge ebbs as her hulking testes visibly shrink.  She leans up against the wobbling factories, resting atop them like they were hefty, liquid pillows.  It'll take her a while to finish emptying herself completely, but for the time being, she seems content.  You give her fluffy tail a playful poof and head back to camp, stooping to retrieve one of the girl's eggs from the ground as you go.\n\n");
	//[End Encounter, gain neon pink egg]
	//dynStats("lus", 25);
	pc.lust(25);
	processTime(15 + rand(10));
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCNeonPinkEgg()]);
}

//[Fuck Her] (Male/Futa Only)
private function fuckTheEggBoundBun():void {
	clearOutput();
	var x:int = pc.cockThatFits(cockVolume(40));
	output("It's not often you find a treat gift wrapped so neatly for you; what kind of ingrate would you be if you just turned it down?  You step up to the wriggling bunny and inspect her carefully.  The girl's body is covered in a ");
	if(!isEaster()) output("sheen of sweat");
	else output("shimmering glaze");
	output(", her urgent lust pulsing in every inch of her ");
	if(!isEaster()) output("freckled brown");
	else output("pudding rich");
	output(" skin.  Her abdomen is slightly rounded with a pot bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her cony cock jerks in the air with every hyperventilating breath, ");
	if(!isEaster()) output("bubbling pearls");
	else output("gooey marshmallows");
	output(" of pre dribbling from the narrow, spear-like crest.  The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if(!isEaster()) output("the carnal fruit of her unwelcome, monstrous couplings");
	else output("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	output(".  She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	output("\n\nYou plant yourself firmly in front of the ");
	if(!isEaster()) output("dusky");
	else output("caramel-skinned");
	output(" bunny-girl with an easy smile.  Loosening your [pc.gear] just enough to let your stiffening cock");
	if(pc.cockTotal() > 1) output("s");
	output(" free, you set your hands lightly on her ample hips, guiding your fingertips up her narrow waist and along the slick flesh of her tensed arms.  She trembles at your touch, but the boiling lust within her turns the fearful shudder into an orgasmic one in the very next second.  In this state, even just the touch of your fingers is enough to set her off, the bound hare's shaft spasming fruitlessly as the thick bronze of her cock ring holds back the torrential flood of her impotent climax.  You wrap your hands around her back, guiding them back down, over the ");
	if(!isEaster()) output("supple mounds");
	else output("taut dough");
	output(" of her wiggling ass and across the fidgeting girl's athletic legs.  Hooking one hand under her knee, you hoist up one leg and spin the girl in place, pushing her face-first into her own colossal, egg-bloated ballsac.  She lets out a thin \"<i>eep!</i>\" as her boundless energy sets off another futile bout of struggling against her bindings.");
	
	output("\n\n\"<i>Please,</i>\" she begs, \"<i>not more eggssss!</i>\"  Despite her squeaking protests, the girl's overflowing urges put a husky, wanton thickness in her voice.  She wobbles from one leg to the other, wiggling her fluffy tail as her jutted ass slides up and down your crotch, carnal cravings to breed leaving her little more than a paper-thin ounce of restraint, the frothing mania of lewd depravity electrifying her every nerve.  She's so tightly wound, she doesn't even notice when you grab her butt cheeks and sink your fingers into the ");
	if(!isEaster()) output("yielding flesh");
	else output("semi-spongy hotcakes");
	output(".  Some light prodding tells you that her ass is far too tightly squeezed from the tension in her bloated organs to have any hope of penetration.  Her snatch is nearly as secure, but the drooling seed of her earlier suitors, along with her own glistening honey should provide all the lubrication you need.  The slimy spunk of countless suitors is warm against the throbbing flesh of your [pc.cock] and you ");
	if(pc.cor() < 33) output("grimace at the vulgar goo that washes over your flesh");
	else if(pc.cor() < 66) output("swallow a gulp as the lewd spoo squelches around your member");
	else output("revel in the profane stimulation of bestial batter anointing your length in impure, liquid virility");
	output(".");
	
	output("\n\nWith a grunt, you force yourself into her, pulsing phallus parting her overwrought pussy lips in a spearing thrust.  The bunny-girl gasps, her control suffocated under the fathomless ocean of her keening lust.  She bucks wildly against you, desperate to hilt your [pc.cock " + x + "] as swiftly and fully as she can.  Her stomach bulges while ropes of spunk splatter out of her stuffed cunny, displaced by your girth.  It's amazing she's so frisky after being taken so many times, you consider with delight as you grasp her slender waist to set her pace to your own.  Before long, you have her thrashing in ecstasy, a writhing parade of unfulfilled orgasms setting her body ablaze, her inner walls virtually vibrating around you while rivers of spunk flow down her legs, painting her ");
	if(!isEaster()) output("darkly freckled thighs ivory");
	else output("savory, chocolate thighs with pale cream");
	output(".  Reaching your own threshold, you lean forward, pressing your cheek against hers, the intake of your breath hissing between your teeth.  She instinctively understands, slamming her ass against your [pc.hips] with as much force as she can muster.");
	
	output("\n\nYou orgasm, [pc.oneCock] erupting inside the frenzied woman's womb with thick gouts of heavy seed ");
	if(!isEaster()) output("flooding her semen-gorged cunt with fresh issue");
	else output("glazing her cream-filled center with your silky spunk");
	output(".  She bucks helplessly as her gut swells under your load, ");
	if(pc.cumQ() < 250) output("steady streams of cum seeping from her pussy");
	else if(pc.cumQ() < 1000) output("bulging enough that her belly button turns outward as the cum oozing from her pussy gushes between the two of you");
	else output("growing larger and larger as cum splatters in thick streams from her saturated pussy. Your seemingly endless gallons of flooding cum wash the remnants of her previous partners away, immersing the caramel woman in the fluid wealth of your liquid possession.");
	output("  No sooner has your spunk taken root inside her, than the bunny's already colossal testes tremble anew.  Before your eyes, they balloon even larger, fattening with the profit of your claim.  You remain inside her a moment longer to marvel at the impossible bulk of her egg-stuffed body, before withdrawing and stepping back to clean yourself off.  Bulbous dollops of spunk bubble from her cunny as she impotently grinds her shaft against the mammoth bulk of her stoppered balls.  Satisfied, you head back to camp, leaving the bunny to the mercies of the next rescuer.");
	//[End Encounter, corruption up]
	pc.orgasm();
	//dynStats("cor", 2);
	pc.cor(2);
	processTime(25 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Get Egged] (Female/Futa only)
private function getEggflated():void {
	clearOutput();
	output("Deciding it'd be too cruel to leave her like this, you resolve to put the bunny-girl at ease. However, you're not so foolish that you're willing to just untie her - if that hungry look in her eyes is any warning.  Stepping up to the wriggling bunny, you inspect her carefully.  The girl's body is covered in a ");
	if(!isEaster()) output("sheen of sweat");
	else output("shimmering glaze");
	output(", her urgent lust pulsing in every inch of her ");
	if(!isEaster()) output("freckled brown");
	else output("pudding rich");
	output(" skin.  Her abdomen is slightly rounded with a pot bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her ");
	if(isEaster()) output("cony ");
	output("cock jerks in the air with every hyperventilating breath, ");
	if(!isEaster()) output("bubbling pearls");
	else output("gooey marshmallows");
	output(" of pre dribbling from the narrow, spear-like crest.  The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if(!isEaster()) output("the carnal fruit of her unwelcome, monstrous couplings");
	else output("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	output(".  She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	output("\n\nSettling standing in front of her, you turn your attention to the ");
	if(!isEaster()) output("twitching length");
	else output("succulent delicacy");
	output(" before you.  The thought of letting her empty her eggs into your body flickers across your mind.  It's a mad impulse, you have to admit, but you kind of want to see what she's capable of.  Stripping your [pc.gear] and setting it far enough away to avoid potential spills, you carefully place your fingers on the bronze ");
	if(!isEaster()) output("ring");
	else output("donut");
	output(" around her conical cock.  The engorged flesh is swollen with pent-up need and you almost swear it gets a bit bigger when your fingertips press against her bindings.  Slowly, carefully, you start to remove the cock ring.  Luckily, the steady flow of her ");
	if(!isEaster()) output("pre-cum");
	else output("milky cream");
	output(" has lubricated her shaft enough to make the loop's passage relatively simple.  Up, up, up it slides, over bulging veins and over the flared peak of her cockhead until, at last, you peel the cinch from her distressed member.  She reflexively bucks at the air, groping for any friction with a weak whimper.  You take a deep breath to steady your own accelerating heart rate and prepare yourself.");
	
	output("\n\nStepping forward, you press against the girl, her perky B-cup breasts squishing against your [pc.chest] until you can feel her racing pulse pounding in her chest.  Her mouth opens in a wanton moan as you grind against her with your [pc.hips], guiding her pulsing pecker toward your [pc.vagina].  Pre-lubricated in her own ");
	if(!isEaster()) output("frothy juices");
	else output("slick honey");
	output(", her spear-like head slips easily past your labia, fervent flesh filling your trembling cavity. The girl's ");
	if(!isEaster()) output("thick pole");
	else output("sweet shaft");
	output(" sends ripples of hot and cold through your gut as her peculiar, almost numbing jism bubbles up inside you.  In another moment, you find yourself completely impaled on her turgid length, despite the throbbing girth of her ");
	if(!isEaster()) output("swollen mast");
	else output("bloated baster");
	output(".  Pressing her backwards, the two of you lean against her ");
	if(!isEaster()) output("supple");
	else output("marshmallow");
	output(" testes, their soft, pliant surface enveloping her as you straddle the helpless bunny.  Testing the tension of her scrotum, you find that the egg-filled sac is firm enough to support both of your weights without causing the girl any pain.  Gleefully, you wrap your arms around her waist and push forward, rolling up and over until the two of you rest atop the gargantuan balls like spherical, ");
	if(!isEaster()) output("well-padded bedding");
	else output("sponge cakes baked for a giant");
	output(".");
	pc.cuntChange(0, bunny.cockVolume(), true, true, false);
	
	output("\n\nAtop your perch, bound to the lapin by fourteen inches of caramel-colored flesh, you take a moment to rock back and forth atop the girl.  Merely being mounted has taken every ounce of her restraint, but you can tell it's a matter of seconds before her resolve crumbles.  Positioned perfectly to take the full geyser of her ");
	if(!isEaster()) output("gurgling seed");
	else output("saccharine seed");
	output(", you realize there's really only one thing left to do.  Sliding a hand between her waist and the tender flesh the two of you are balanced upon, your fingers seek out the ");
	if(!isEaster()) output("twitching tuft");
	else output("cotton candy poof");
	output(" of her fluffy tail.  You find the junction where it meets the base of her spine and bear down on the sensitive point with your knuckles, eliciting a shrieking squeal of bliss from the over-burdened bunny-girl.  An intense pressure floods your cunt as her ");
	if(!isEaster()) output("swollen dick");
	else output("candied cock");
	output(" distorts under the heft of the emerging eggs.  As the first oval bulge travels up her shaft, you grind and slam deeper on her until the narrow point of her ");
	if(!isEaster()) output("jizz-burbling");
	else output("jelly-bubbling");
	output(" crest presses hotly against your cervix.  The sputtering flood of her opiate spunk saturates your inner walls, giving them a yielding elasticity.  As the egg nears her tip, you spear yourself down on the climaxing girl's prominence, feeling her dilating peak penetrating your womb.  With an exquisite moan of drugged euphoria, you watch your abdomen bulge as the egg pops free, followed by jets of ");
	if(!isEaster()) output("tingling, liquid passion");
	else output("fattening, cream filling");
	output(".  Another egg rushes up, followed by another, the pace accelerating as you bounce atop the vivacious hare with fast, short strokes that rub your [pc.clit] against her cum-bloated belly.");
	
	pc.cuntChange(0, bunny.cockVolume() * 2, true, true, false);
	
	output("\n\nEgg after egg fills your womb, swelling your abdomen with the heavy ");
	if(!isEaster()) output("load");
	else output("treat");
	output(". You pant, finding it difficult to draw a breath with the burden massing in your inner recess, your tongue hanging freely  and drool trickling down the side of your mouth.");
	//Futa:
	if(pc.hasCock()) {
		output("  Quite without realizing it, [pc.eachCock] spasms in messy orgasm, spurting ropes of spunk  across the bunny girl's tawny skin like a gooey glaze.");
	}
	output("  Your vision swims and when you blink back the dizziness, you find your gut has bloated to the size of ");
	if(!isEaster()) output("advanced pregnancy");
	else output("gluttonous excess");
	output(".  Though her cushioning balls have emptied some of their load inside you, they're still huge enough to support you both, so you regretfully begin to slide off the bunny girl's cock, eggs filling the gap her distended shaft leaves.  Pausing, with the tip at the cusp of your flush lower lips, you turn around atop the delirious bunny, popping her crest out, a rivulet of ");
	if(!isEaster()) output("cum");
	else output("cream");
	output(" leaking from your freshly stuffed snatch.  With a guiding hand, you steer her surging spout to your [pc.ass] and drop your full ");
	if(!isEaster()) output("egg-loaded");
	else output("candy fattened");
	output(" weight on the conical cock.  With fresh space to fill, the eggs flow into you once more, one pushing another in a procession up your large intestine.");
	//Futa:
	if(pc.hasCock()) output("  The steady movement of the orbs pushing past your prostate drills another, even messier orgasm from your [pc.cocksLight], cum arcing into the air to shower down on the two of you in pearl beads.");
	
	output("\n\nTime seems to flow from one moment to the next, your consciousness fading in and out as a small deluge of ");
	if(!isEaster()) output("bunny seed");
	else output("marshmallow and chocolate");
	output(" loads up your belly as fully as your twitching, clenching womb.  You can practically taste the sweetness in the back of your throat by the time the bunny-girl's orgasm ends.  Your body is inflated far beyond anything you could've imagined, eggs and spunk leaking from your gravid abdomen.  The bunny girl is lost to the world, dazed in a private bliss as her basketball-sized balls slowly push the last few eggs out of her dusky stalk with splattering plops.  You couldn't move if you wanted to, so you just remain on the ground, enjoying the feeling of utter, immobile bounty.  Gradually, the eggs in your belly and womb begin to melt, losing their firmness in favor of a fresh flux of raw warmth that wrings a final climax from your overtaxed body.");
	
	output("\n\n");
	//Futa:
	if (pc.hasCock()) {
		output("Your exhausted [pc.cocksLight] somehow find" + (pc.cocks.length > 1 ? "" : "s") + " the strength for a gushing orgasm of " + (pc.cocks.length > 1 ? "their" : "its") + " own, strands of spoo spilling across your own body, white hot spunk bringing a fresh sheen to your sweat-slick [pc.chest].  ");
	}
	output("Eventually, enough of the eggs melt to let you stand under your own power.  You grab your [pc.gear] but hold off on putting it on until you have a chance to shrink down to a more normal size.  Before you leave, you make sure to remove the rope from her wrists, for when she gathers her orgasm-blasted wits.");
	//[If full bunny morph, End Encounter. Weight up, sensitivity down, fertility up.]
	//if (pc.bunnyScore() < 4) {
		//pc.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS);
	//}
	//else {
		//pc.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_BABY, 60);
		//pc.fertility++;
	//}
	//dynStats("lib", 1, "sen", -3);
	pc.loadInCunt(bunny);
	pc.loadInCunt(bunny);
	pc.slowStatGain("l", 1);
	output(pc.modThickness(3));
	output(pc.modTone( -3));
	pc.orgasm();
	processTime(6 * 60 + rand(2 * 60));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
//If not full bunny morph: [Next]
//On the way back to your camp, the torrid heat of the melting eggs inside you become unbearable and you drop to your hands and knees. Something is changing!
//[Insert every bunny morph change text that the player does not have. End Encounter. Weight up, Sensitivity down, fertility up.]

public function giveBirthToBunny(pregSlot:int):void
{
	clearOutput();

	var pData:PregnancyData = pc.pregnancyData[pregSlot] as PregnancyData;
	
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
		output("\n\n");
	}
	
	if (!pc.canLactate()) pc.boostLactation(50);
	
	//Main Text here
	output("A dangerous rumble comes from your womb, signaling that it's time to birth your body's cargo at last. Your [pc.legs] wobble unsteadily as your strength ebbs with every gush that erupts  from your now-broken water until you collapse on your [pc.butt], grunting and groaning.  At first it goes slow - there's just a few small contractions that are more strange than anything else, rippling down your [pc.vagina " + pregSlot + "] and squirting out more of your pregnancy's fluid.  All too soon the tempo kicks up, and you feel something starting to stretch you wider and wider.");
	
	output("\n\nYou heave and push, instinctively driven to flex muscles you didn't even know you had to speed the super human labor you've entered into. ");
	if (pc.vaginalCapacity(pregSlot) < cockVolume(60)) output("It hurts a little as your cervix starts to stretch wide");
	else output("It actually feels kind of nice as your cervix is stretched wide");
	output(", but somehow your body accommodates the forced dilation without too much discomfort.  It's soon forgotten as you feel your [pc.vagina " + pregSlot + "] pushed into a large sphere, stretched around the inhuman form of your child as it squirms and writhes inside you on its path to freedom.  You grunt and flex, watching with disbelief as a tiny, rabbit-eared form slides from your slick canal into the grass, the process leaving your [pc.chest] heaving with unexpected pleasure.");
	
	output("\n\nThe whole process starts over again - there's another one!  By now your well-stretched pussy is oozing both the birthing fluids and your own lubricants, and the second bunny-child slides down to bump into its sibling with ease.  You shake and shudder, groaning and spasming as you nearly cum from the stimulation, but in the end you're left panting and horny.  The two bunnies look like miniature people except for their ears, tails, and fuzzy legs.  Your children lick themselves clean before hopping up onto your [pc.chest] and suckling your nipples for a while");
	if (pc.lactationQ() > 500) outputText(", growing fat from all the milk");
	output(".  At last they finish, and with one last nuzzle, your strange bunny-children go hopping off, doubtless to find more of their own kind.");
	
	output("\n\nYou sink into restful unconsciousness, marveling at how stretchy and sensitive your [pc.vagina " + pregSlot + "] feels now.");
	
	pc.cuntChange(pregSlot, cockVolume(60), false, true, false);
	
	if (pc.milkMultiplier < 100) {
		output("\n\nYour breasts won't seem to stop dribbling milk, lactating more heavily than before.");
		pc.boostLactation(10);
	}
	
	if (pc.vaginas[pregSlot].wetnessRaw == 0) pc.vaginas[pregSlot].wetnessRaw++;
	if (pc.vaginalCapacity(pregSlot) < cockVolume(300)) pc.vaginas[pregSlot].bonusCapacity += 10;
	
	pc.lust(pc.lustMax());
	//pc.orgasm();
	
	pc.slowStatGain("l", 1);
	// sen +10
	pc.cor( -2);
	
	processTime(4 * 60);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}