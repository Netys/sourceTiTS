﻿import classes.Items.Toys.EggTrainer;

//TamaniCorp Egg Trainer
//By Savin

/*Notes
Bought from some kinda sextoy store -- same place you'd get BionaHoles, I guess??? 

Anyway. It's a bright pink box with a TamaniCorp logo stamped on the side. On one of its top edges in a big, fat plastic tube covered with nubs all along the length. This is basically a mechanical tentacle-cock that will oviposit you. The rest of the box's top slides off, revealing a pool of perpetually warm cleaning gel that the eggs rest in when not in use. You can squat on the edge, get tenta-egged, then pull the tube out and squirt your eggy load right back into the pool without really moving. Convenient! 

Has three settings: Lay Training, Carry Training, or Faux Preg. 

Lay Training has the tube oviposit you with eggs and a shit-ton of sex-lube, making the insertion and oviposition easy. Once it's done, the tube slides out of you, and you're able to squeeze the lil' plastic eggs back out in the cleaning pool. Plop plop. Depending on how elastic you are, you'll get more eggs.

Carry Training's a bit more complex. The machine fucks you full of as many eggs as you can possibly carry, and then seals them into your womb with a sealant lube. You can then walk around with a belly-stretching gut of eggs for about a week until the sealant wears off, and then you give "birth." 

Faux Preg is the real deal, though. The tentacle oviposits you with a single egg, and then seals it in there like with Carry Training. This time, though, the egg starts growing. And growing. And growing. Over the course of a few weeks, it expands until you look nine+ months pregnant, and then just STAYS THERE. Basically meaning you get to have a nice, plump preg-belly forever. Until you go back to the Egg Trainer and hit the extract button, which will have the tentacle go in and "deflate" the egg for you. 

IMPORTANT
This introduces an "Egg Trained" score for the PC. The more ET you have, the more eggs that the machine will shove up yer butt. Rated from 0-5.

0: Random 6-12 eggs. Can't use Carry Training or Faux Preg Egg options.
1: Random 10-25 eggs. Carry Training unlocked. 
2: Random 20-40 eggs. Huge, permanent looseness and wetness bonus. 
3: Random 35-70 eggs. Faux Preg Egg unlocked. 
4: Random 50-80 eggs. Moderate raw Bonus Capacity for all holes.
5: Random 75-100 eggs. Huge, permanent looseness bonus. 

You lose 1 level of Egg Trained each week you go without either using the machine or having some kind of egg in your hole. 
*/

//Getting the Egg-Trainer

//Bought in any sex-shop of your choosing. Like the Dong Designer, it slows you down until you install it (cuz it's xbawksheug and heavy). 
//Cost: 7,500C

//Shop Tooltip: A bright pink box about a yard long, emblazoned with the TamaniCorp logo on either side. The Egg Trainer advertises itself as your one-stop-shop for your oviposition needs. The trainer, as its name suggests, induces artificial pregnancy via inserted eggs that swell to huge sizes, or helps to train your body to take gargantuan loads of alien eggs. Satisfaction guaranteed with every use!

//Ship Tooltip: Your bright pink Egg Trainer is sitting in the corner, rumbling slightly as the heating and cleaning processes inside it percolate. {if PC has a belly full of eggs: You run a hand across your swollen belly, vaguely wishing you could squat the current load out... only to get another mind-melting orgasm from the next batch going in! //if PC has a faux-preg egg: You run a hand across your [pc.belly]. You could get your Faux Preg Egg out at any time with the device, if you wanted to.}

//Installing it in the Ship
//Inventory -> Egg Trainer. Sets it up in the Cargo hold, just like a Dong Designer. 
public function eggTrainerInstallation():void
{
	clearOutput();
	author("Savin");

	if(currentLocation == "SHIP INTERIOR")
	{
		showName("\nINSTALLING...");
		output("You heft the giant pink box down onto the deck of your cargo hold and take a deep breath, happy to have the extra weight off you. Though something tells you that if you end up actually using this thing, you’ll just end up with a whole new chunk of extra weight... For the moment, though, you distract yourself from wandering thoughts by hooking the Egg Trainer up to a power outlet nearby. The moment you do, it thrums to life with a mechanical shudder and a cheery digital tune played from a small speaker under a flickering holographic display.");
		output("\n\nThe readout shows the Tamani Corp logo for a moment before resolving into a product registration screen, prompting you for your email address. You give it somewhat reluctantly - there doesn’t seem to be any way to skip the screen - and watch as the screen fades out and into a main menu of sorts, indicating a button labeled <i>“Tutorial”</i>. You click it.");
		output("\n\nA cute, hand-drawn-looking doodle of the machine dances around underneath the option buttons, cavorting its way to the center of the screen. After a moment, a facsimile of a person appears on the menu, sitting down on the saddle-like seat on the far side of the box, straddling it like an animal - or a lover - with spread legs. The image of the training box cuts away, showing a tube-like tentacle rising from within, lurching up through the bottom of the saddle-seat and into the box’s owner. The view then shifts to a tub of eggs floating in a bubbling liquid, which start to get sucked up through one end of the tube like a vacuum, pumping into the cartoon human.");
		output("\n\nYou watch with wide eyes as the tentacle pumps its rider full of eggs, one after another, until his belly is swollen to bursting with them, looking as gravid as a woman nine months pregnant. A cartoon boner appears between his legs as the eggs flood in, erupting in a white geyser just as the final one pops into his ass. The tentacle then withdraws, leaving the rider agape... and letting the eggs fall out, one after the other, causing the animated figure to climax messily as his belly shrinks back down and the pool refills with its eggs.");
		output("\n\nWell, that doesn’t leave much to the imagination... You turn your attention to the buttons appearing on the screen, showing you what this lascivious device is offering.");
		output("\n\n<b>You’ve installed a TamaniCorp Egg Trainer in your ship! You can access it from the storage menu.</b>");
		processTime(4);
		flags["EGG_TRAINER_INSTALLED"] = 1;
		//Consume the item
		pc.destroyItem(new EggTrainer());
		//Display egg trainer options here.
		eggTrainerMenu();
	}
	else
	{
		output("You must be onboard your ship in order to install the Egg Trainer.");
	}
}

//Approach the Box
//Repeat. Storage -> Egg Trainer
public function repeatEggTrainerApproach():void
{
	clearOutput();
	showName("EGG\nTRAINER");
	author("Savin");
	output("You find yourself drawn back to the bubblegum-pink Tamani Corp box sitting in your hold. The Egg Trainer is humming ever so faintly, thrumming as its internal mechanisms slosh around and heat the dozens and dozens of eggs inside it. It smells faintly of lilacs and lube. The saddle-seat atop it beckons you, inviting you to take a seat and take a load in.");
	if(pc.lust() >= 75 || pc.libido() >= 75) output(" You’re already shuddering with anticipation....");
	output("\n\nThe holo-screen on the front of the box presents you with several options....");
	processTime(1);
	eggTrainerMenu();
}

//Egg Trainer Options
public function eggTrainerMenu():void
{
	clearMenu();
	//[Raw Tentacle] [Egg Training] [Carry Training] [Faux Preg] [Leave]
	addButton(0,"Raw Tentacle",rawTentacleGogogo,undefined,"Raw Tentacle","No eggs this time. You just want to feel that slippery tentacle slithering inside you...");
	if(pc.findEmptyPregnancySlot(0) != -1)
	{
		addButton(1,"Egg Trainer",eggTrainingMachineTime,undefined,"Egg Training","Have the machine fill you with eggs and lube, then lay them right back into the cleaning pool. Something tells you between a tentacle fucking and a two-way oviposition, you’d be in for a wild ride.");
	}
	else
	{
		addDisabledButton(1,"Egg Training","Egg Training","You have no room for eggs.");
		addDisabledButton(2,"Carry Train","Carry Train","You have no room for eggs.");
		addDisabledButton(3,"Faux Preg","Faux Preg","You have no room for eggs.");
	}
	addButton(14,"Leave",shipStorageMenuRoot);
}

//Raw Tentacle
//No eggs this time. You just want to feel that slippery tentacle slithering inside you...
//Significantly increase looseness of hole fucked.
public function rawTentacleGogogo():void
{
	clearOutput();
	showName("EGG\nTRAINER");
	var x:int = pc.findEmptyPregnancySlot(0);
	//If all holes full, pick a vagina.
	if(x == -1) 
	{
		if(pc.hasVagina()) x = rand(pc.totalVaginas());
	}
	if(x == 3) x = -1;

	output("You press the cheerful blue <i>“Tentacle Training”</i> button, which somehow seems to be the <i>least</i> invasive of the options presented. The holo-screen instructs you to disrobe and take a seat on the saddle. The device will take care of the rest... though a second pop-up helpfully mentions that you might want to hold on to something. You gulp and do as it commands, setting aside your [pc.gear] and ");
	if(pc.isTaur()) output("awkwardly moving to position your lower body over the entire box, angling your [pc.vagOrAss " + x + "] towards the saddle.");
	//if naga: 
	else if(pc.isNaga()) output("coil yourself around the box, angling your [pc.vagOrAss " + x + "] into the fuck-saddle as best you can.");
	else if(pc.isGoo()) output("squirm around the box, all but enveloping the entire box and wiggling your behind into the saddle.");
	else output("swing a leg awkwardly over the edge of the box, plopping down in the seat of the saddle.");
	output(" The moment you’re seated, the holoscreen on the front of the box swivels around to face you, and a pair of metal bars slide out from the sides of the box: handlebars.");

	output("\n\nNothing happens for a moment, until you lean forward over the box and take hold of the metal bars. You feel a faint heat in the metal, and a vibration as the machine ");
	if(pc.legCount <= 1) output("under you ");
	else output("between your [pc.legs] ");
	output("hums to life. The saddle shifts underneath you, and you feel something slide right beneath your rump: a hole opening up under your butt.");
	if(pc.balls > 0)
	{
		if(pc.balls > 1) output(" Your [pc.balls] immediately flop");
		else output(" Your [pc.ball] immediately flops");
		output(" into the hole, dangling into the black depths of the bubble-gum pink fuck machine.");
	}
	output(" The holo-screen beeps and displays a cartoonish red <i>“HANG ON!”</i> in huge capital letters, and you feel the ever-present rumbling in the machine intensify.");

	output("\n\nSomething moves violently underneath you, and you feel a sudden rush of wet heat splatter against your [pc.vagOrAss " + x + "]. You gasp as heated lube squirts through your crack");
	if(x >= 0) output(" and all over your groin");
	output(", and the stuff keeps coming and coming, like a sexified bidet. The holo-screen tells you to relax, breathe deep, and relax your body: your role is entirely passive in this. A ragged breath escapes your lips, which tremble with wet pleasure. You’re not sure if this lube-geyser has some kind of aphrodisiac mixed in, or if the constant squirt of hot, sticky, wetness against your hole is really just <i>that</i> pleasurable. Whatever the answer is, it’s only a prologue for what’s to come.");

	output("\n\nWhich comes right about now, as it happens. You feel something thick and wriggling moving up through the stream of lube battering your backside, followed by a plasticy sensation against your [pc.vagOrAss " + x + "]. Your whole body clenches as a pressure begins to build, insistent but gentle, pressing in amidst the sea of lube coating your hole until you start to feel your body stretch. The tip of the tendril is nice and rounded, smooth and latexy like a proper dildo, though you instantly feel that something’s not quite human about it: the head seems hollow, like a crater caving in to reveal the long tube leading into the depths of the device it’s attached to. Even this inner passage is squirting lube into you, blazing its own trail through your ");
	if(x >= 0) output("pussy’s clenching walls");
	else output("bowels");
	output(" as it starts to worm its way into you.");
	if(x >= 0) pc.cuntChange(x,pc.vaginalCapacity(x));
	else pc.buttChange(pc.analCapacity());

	output("\n\nThe tentacle doesn’t get an inch in before you feel something <i>else</i> coming with it. A ring of short, stubby nubs ring the tube, grinding into your [pc.vagOrAss " + x + "] on a bed of hot lube. You groan, eyes wide and knuckles going white on the handlebars. Instinctively, your body tries to fight back, to push the invading thing out of you, but it’s so slick and so strong that your defenses simply cave to the incessant pressure the machine puts on you. All that’s left to do is feel the thing squirming inside you, writhing about inside your ");
	if(x >= 0) output("twat");
	else output("ass");
	output(" with mounting speed. More and more of the little nubs snake into you, rubbing pleasurably against your ");
	if(x >= 0) output("pussy’s walls");
	else if(!pc.hasCock()) output("anal walls");
	else output("prostate");
	output(".");

	output("\n\nWhat feels like the better part of a foot lodges in you before the tentacle seems to think it’s done its job. At least, the prologue. The tentacle goes completely rigid for the span of a heartbeat, making sure you’re nice and stretched out around its thick girth, before it starts to thrust. It moves fast and furious, pounding into you with its nub-ringed shaft.");
	if(pc.hasCock())
	{
		output(" Your [pc.cock] bounces, half hard and leaking pre all across your thighs. Pleasure hammers through your cock like it’s ready to spurt already.");

	}
	if(pc.biggestTitSize() >= 1) 
	{
		output(" Your hands are drawn from the handlebars and onto your [pc.breasts], cupping and squeezing your tits");
		if(pc.isLactating()) output(" until milk drizzles down around your fingers");
		output(".");
	}
	output(" Biting your lip and clenching your fingers tight, you find yourself bucking your [pc.hips] against the curve of the saddle.");

	output("\n\nThe tentacle squirts even more lube into you, letting itself fuck you harder. You moan like a bitch in heat, riding the writhing cock like a cow" + pc.mf("boy","girl") + " until the pleasure’s just too much to bear. ");
	if(pc.hasCock()) output("Your cock cums first, geysering spooge across the top of the box and the deck of your cargo hold. ");
	output("A scream of pleasure tears through your throat, arching your back, demanding you squeeze hard around the spasming, lube-spraying device.");

	output("\n\nThe fucking couldn’t have lasted more than a minute, but as suddenly as it started, the tendril goes rigid once more... and the begins to withdraw. You give one last orgasmic shudder as the rounded ovipositor pops free of your [pc.vagOrAss " + x + "] and slinks like a snake back into the embrace of the rumbling machine.");

	output("\n\nYou flop forward onto your [pc.belly] with a contented moan, breathing hard as what feels like gallons of lube drools back into the hole in the saddle, pouring out of your hard-fucked hole. The holo-screen, now inches from your face, displays <i>“Hope you enjoyed, sugar~!”</i>");
	output("\n\nYou let a few minutes of air-drying pass you by before you grab your gear and stagger off to the shower.");
	
	processTime(22);
	pc.orgasm();
	processTime(4);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Egg Training
//Have the machine fill you with eggs and lube, then lay them right back into the cleaning pool. Something tells you between a tentacle fucking and a two-way oviposition, you’d be in for a wild ride.
//Significantly increase looseness of hole fucked.
public function eggTrainingMachineTime():void
{
	clearOutput();
	showName("EGG\nTRAINER");
	author("Savin");

	var x:int = pc.findEmptyPregnancySlot(0);
	//If all holes full, pick a vagina.
	if(x == -1) 
	{
		if(pc.hasVagina()) x = rand(pc.totalVaginas());
	}
	if(x == 3) x = -1;

	output("You press the bright pink <i>“Egg Training”</i> button, ");
	//lf first time: 
	if(flags["EGG_TRAINING_TIMES"] == undefined) output("ready to see what this machine’s really about");
	else output("eager to train your body to take bigger and bigger loads of eggs - with the promise of more and more mind-melting orgasms as reward");
	output(". The screen dings cheerfully, instructing you to disrobe and take a seat on the saddle. It further recommends you use this option on an empty stomach. Your belly is in for quite the strain, you ");
	if(flags["EGG_TRAINING_TIMES"] == undefined) output("imagine. You warily set your gear aside, wondering just what this device has in store for you.");
	else output("know all too well. You wiggle out of your [pc.gear], heart already hammering with anticipation.");
	output(" Following the screen’s instructions, you ");
	if(pc.isTaur()) output("awkwardly move to position your lower body over the entire box, angling your [pc.vagOrAss " + x + "] towards the saddle.");
	else if(pc.isNaga()) output("coil yourself around the box, angling your [pc.vagOrAss " + x + "] into the fuck-saddle as best you can.");
	//if goo:
	else if(pc.isGoo()) output("squirm around the box, all but enveloping the entire box and wiggling your behind into the saddle.");
	else output("swing a leg awkwardly over the edge of the box, plopping down in the seat of the saddle.");
	output(" The moment you’re seated, the holoscreen on the front of the box swivels around to face you, and a pair of metal bars slide out from the sides of the box, giving you something to hold onto. Between them, the metal top of the box slides back underneath the saddle, revealing a tub of sloshing off-green liquid bubbling inside it. What looks like hundreds of small, yellow plastic eggs slosh around in the pool, piling up against a single hole on the wall right under the saddle. Doesn’t take a genius to figure out where that leads...");
	output("\n\nNothing happens for a moment, though, until you lean forward over the box and take hold of the metal bars. A faint heat starts rising from the metal, and you feel a shuddering vibration as the machine ");
	if(pc.legCount <= 1) output("under you ");
	else output("between your [pc.legs] ");
	output("hums to life. The sea of liquid inside the box starts heating up, bubbling and sloshing like a washing machine on high - and the box you’re leaning on heats up, as hot as a lover’s body. The saddle shifts underneath you, and you feel something slide right beneath your rump: a hole opening up under your butt.");
	if(pc.balls > 0)
	{
		if(pc.balls > 1) output(" Your [pc.balls] immediately flop");
		else output(" Your [pc.ball] immediately flops");
		output(" into the hole, dangling into the black depths of the bubble-gum pink fuck machine.");
	}
	output(" The holo-screen beeps and displays a cartoonish red <i>“HANG ON!”</i> in huge capital letters, and you feel the ever-present rumbling in the machine intensify.");

	output("\n\nSomething moves violently underneath you, and you feel a sudden rush of wet heat splatter against your [pc.vagOrAss " + x + "]. You gasp as heated lube squirts through your crack");
	if(x >= 0) output(" and all over your groin");
	output(", and the stuff keeps coming and coming, like a sexified bidet. The holo-screen tells you to relax, breathe deep, and relax your body: your role is entirely passive in this. <i>“A good incubator lies back with spread legs and a smile for his or her ovipositor,”</i> the screen tells you. A ragged breath escapes your lips, which tremble with wet pleasure. You’re not sure if this lube-geyser has some kind of aphrodisiac mixed in, or if the constant squirt of hot, sticky, wetness against your hole is really just <i>that</i> pleasurable. Whatever the answer is, it’s only a prologue for what’s to come.");

	output("\n\nWhich comes right about now, as it happens. You feel something thick and wriggling moving up through the stream of lube battering your backside, followed by a plasticy sensation against your [pc.vagOrAss " + x + "]. Your whole body clenches as a pressure begins to build, insistent but gentle, pressing in amidst the sea of lube coating your hole until you start to feel your body stretch. The tip of the tendril is nice and rounded, smooth and latexy like a proper dildo, though you instantly feel that something’s not quite human about it: the head seems hollow, like a crater caving in to reveal the long tube leading into the depths of the device it’s attached to. Even this inner passage is squirting lube into you, blazing its own trail through your ");
	if(x >= 0) output("pussy’s clenching walls");
	else output("bowels");
	output(" as it starts to worm its way into you.");
	if(x >= 0) pc.cuntChange(x,pc.vaginalCapacity(x));
	else pc.buttChange(pc.analCapacity());

	output("\n\nThe tentacle doesn’t get an inch in before you feel something <i>else</i> coming with it. A ring of short, stubby nubs ring the tube, grinding into your [pc.vagOrAss " + x + "] on a bed of hot lube. You groan, eyes wide and knuckles going white on the handlebars. Instinctively, your body tries to fight back, to push the invading thing out of you, but it’s so slick and so strong that your body simply gives in to the incessant pressure the machine puts on you. All that’s left to do is feel the thing squirming inside you, writhing about inside your ");
	if(x >= 0) output("twat");
	else output("ass");
	output(", faster and faster. More of the little nubs snake in with the shaft, rubbing pleasurably against your ");
	if(x >= 0) output("pussy’s walls");
	else
	{
		if(!pc.hasCock()) output("anal walls");
		else output("prostate");
	}
	output(". This is just a taste of the pleasure your Egg Trainer is promising, though.");

	output("\n\nWhat feels like the better part of a foot lodges in you before the tentacle seems to think it’s deep enough to start <i>really</i> working. The tentacle goes completely rigid for the span of a heartbeat, making sure you’re nice and stretched out around its thick girth, before it starts to swell and shudder, and you feel something moving <i>inside</i> it. Your eyes go wide as the tentacle hilted in your [pc.vagOrAss " + x + "] stretches out, passing the first thick knot of plastic through your ");
	if(x >= 0) output("pussy lips");
	else output("sphincter");
	output(". A much stronger geyser of lube squirts out of the tentacle-dildo’s crown before the latex cockhead engorges wetly, and you feel something thick and round and sloppy-wet shoot into your ");
	if(x < 0) output("bowels");
	else output("womb");
	output(".");

	output("\n\nPleasure rocks your world as the first egg lodges inside you. Your hips rock forward, bucking on the thick member in your [pc.vagOrAss " + x + "] and gasping for breath.");
	if(pc.hasCock()) 
	{
		output(" Your [pc.cocks] bounce");
		if(pc.cockTotal() == 1) output("s");
		output(", half hard and leaking pre all across your thighs. Pleasure hammers through your cock like it’s ready to spurt already.");
	}
	if(pc.biggestTitSize() >= 1)
	{
		output(" Your hands are drawn from the handlebars and onto your [pc.breasts], cupping and squeezing your tits");
		if(pc.isLactating()) output(" until milk drizzles down around your fingers");
		output(".");
	}
	output(" Moaning like a bitch in heat, you ride the writhing cock like a cow" + pc.mf("boy","girl") + " until the pleasure’s just too much to bear.");
	if(pc.hasCock()) output(" Your cock cums first, geysering spooge across the top of the box and the deck of your cargo hold.");
	output(" A scream of pleasure tears through your throat, arching your back, demanding you squeeze hard around the spasming, lube-spraying device.");

	output("\n\nAnd that was just the first egg. Another thick engorgement wriggles its way up through the tube, making it push out on your lubed-up walls, rubbing its dozens and dozens of rounded nubs against you. The orgasmic pleasure tearing through you refuses to abate, especially with that kind of handling - and with another thick, heavy bulb plopping into your body, followed by another... and another. You watch with bulging eyes as egg after egg slurps out of the see-through tub and vanishes into the throbbing tube beneath you. Your [pc.butt] bounces on the fuck-saddle, riding that plastic shaft as it thoroughly breeds your [pc.vagOrAss " + x + "] with its eggy load.");

	//{@eggTraining: eggTrained pc} //That’s a new stat to see how many eggs you can take!
	if(flags["EGG_TRAINING"] == undefined || flags["EGG_TRAINING"] == 1)
	{
		output("\n\nThe tentacle squirts and thrusts, laying a belly-straining load of tumbling spheres inside you. You lose count after six big, orgasmic pops that bloat your ");
		if(x >= 0) output("womb");
		else output("gut");
		output(". By the time the wriggling tentacle finishes, you’re a swollen and sordidly wet mess, drooling hot lube like a waterfall from your well-fucked hole. As the tentacle starts to withdraw, one of your hands slips down to your belly, feeling a distinct set of uneven bulges pushing against your [pc.skin] from within.");
	}
	else if(flags["EGG_TRAINING"] <= 3)
	{
		output("\n\nThe tentacle just keeps on fucking you, ceaselessly filling your belly with its artificial get. Egg after egg squeezes through its bloated head and into your ");
		if(x >= 0) output("womb");
		else output("ass");
		output(" on a constant bed of heated sex lube until you’re positively stuffed with them. There’s well over a dozen inside you, maybe two - your belly is bloated by the mass of eggs, and you can feel the added weight of them hanging heavily in front of you, making you lean forward and rest your pregnant gut on the top of the machine. Your skin bulges and shifts unevenly, and your whole body feels incredibly wet - even as lube absolutely pours out of your gaping hole.");
	}
	else
	{
		output("\n\nThe familiar, wonderful pleasure of the tentacle hammers through you, burrowing deep inside to discharge its belly-filling load. Eggs come flooding easily out of its engorged cockhead, blasting into your ");
		if(x >= 0) output("womb");
		else output("bowels");
		output(" in a flood of hot lube and smooth plastic. Dozens and dozens of eggs pump into your well-trained body, swelling you up just the way you like it. You cum again - if you really stopped at all in the first place - and let yourself go completely with screams of pleasure that echo across the cargo hold. Your hands clench around your belly, feeling your skin stretch around the growing load of eggs: you look ");
		if(pc.isPregnant()) output("an extra ");
		output("nine months pregnant by the time the machine’s decided you’ve had enough, filled with almost a hundred eggs that churn wetly ");
		if(x < 0) output("up your ass");
		else output("in your swollen womb");
		output(". The sensation is wonderful, comforting... you find yourself wrapping your arms around yourself, basking in the artificial sense of motherhood and the very real, all-encompassing sense of fullness.");
	}
	output("\n\nThe turgid, slimy tentacle stretching your [pc.vagOrAss " + x + "] out has finally finished its job, and slowly starts to soften inside you. You give a little moan, rocking your hips in the saddle as the machine begins withdrawing, slithering back out. It leaves you gaping open, teasing your walls with its nubby texture and serpent-like motions until its curved crown finally pops out.");

	//[Next]
	//Update pc.belly until the end of the scene, with gravidity based on Egg Training/eggs rolled.
	pc.lust(200);
	processTime(20);
	clearMenu();
	addButton(0,"Next",layingTrainingTwo);
}

public function layingTrainingTwo():void
{
	clearOutput();
	showName("EGG\nTRAINING");
	author("Savin");
	output("Like a cork, the tentacle slipping out lets loose a flood of hot lube. Your eyes widen as the floodgates open, and your hands leap towards the handlebars, gripping them with white knuckles as a whole different type of pleasure hits you. Without the thick, plastic plug to keep them in, your ovi-load is starting to shift downwards!");

	output("\n\nBefore anything can happen, though, the see-through panel atop the machine slides aside. A rush of humid heat rushes up to greet you, billowing across your [pc.skinFurScales].");
	//if not Egg Trained 5:
	if(flags["EGG_TRAINING"] != undefined) output(" The remaining eggs inside roll listlessly about in the sea of viscous lube.");
	output(" The holo-screen on the Egg Trainer’s front beeps at you, instructing you to move in the saddle so that your hole is aimed at the tub. With a groan, you manage to shift your [pc.butt] around in the slicked-up saddle to comply with the machine’s commands. Even a moment’s movement leaves you reeling, your belly shifting with the weight of ");
	if(flags["EGG_TRAINING"] == undefined || flags["EGG_TRAINING"] == 1) output("several");
	else if(flags["EGG_TRAINING"] <= 3) output("more than a dozen");
	else output("dozens of");
	output(" eggs.");

	output("\n\nYour hands run across your bare, swollen belly, feeling the eggs shift inside you, tumbling towards your gaping opening. A shockwave of pleasure hammers through your [pc.vagOrAss " + x + "], forcing you to clench down around the flood of lube and growing pressure inside you. The holoscreen urges you to relax: <i>“You don’t want to hurt your eggs, do you? Relax that cute little hole of yours and push!”</i>");

	output("\n\nSeems like a contradiction in terms from where you’re sitting, but you try your best. Your [pc.legs] squeeze around the sides of the box, steadying you as the first egg starts to crown. Looking down, you watch with wide eyes as the firm, sloping head of the egg peeks out. You push, as hard as you can with gritted teeth and white knuckles until with a wet squirt the first <b><i>pops</i></b> out of you, plopping into the lube-tank inside the machine. More of the hot, thick liquid splashes up onto your thighs, as if to pave the way for the next egg... and the next. Each egg you pass is an explosion of pleasure that drowns out all thought, all other sensation. You cum again");
	if(pc.hasCock())
	{
		output(", your ");
		if(pc.cockTotal() == 1) output("cock blasting a thick rope of semen");
		else output("cocks blasting thick ropes of semen");
		output(" into the lube-pool, coating the eggs with even more of your erotic juices");
	}
	output(", and your [pc.vagOrAss " + x + "] clenches and squeezes uncontrollably. Your body is entirely on auto-pilot now, laying and cumming");
	if(x >= 0 || pc.hasCock()) output(", drooling sex-juice and lube all over");
	output(". The coating of lube every egg is slathered in makes their passage as easy as what feels like fist-sized lumps of plastic can go.");
	//if gaping: 
	var gaped:Boolean = false;
	if(x >= 0)
	{
		if(pc.vaginas[x].looseness() >= 4) gaped = true;
	}
	else if(pc.ass.looseness() >= 4) gaped = true;
	if(gaped) output(" At least you’re already stretched out pretty well, making this a little easier!");
	else output(" You can only imagine how gaped you’re going to be after this...");

	output("\n\nFinally");
	if(flags["EGG_TRAINING"] >= 4 && flags["EGG_TRAINING"] != undefined) output(", after what seems like hours of orgasm after orgasm across dozens of eggs");
	output(", the last egg crowns from your gaping, drooling hole. One final push, one last scream of ecstasy, and you squirt the last of your artificial progeny into the bath of warm lubricant. A ragged, gasping sigh escapes your lips, and you flop back onto the rumbling top of the Egg Trainer.");
	if(x >= 0) pc.cuntChange(x,pc.vaginalCapacity(x));
	else pc.buttChange(pc.analCapacity());

	output("\n\nThe holo-screen bleeps at you: <i>“A good egg-slut makes sure their eggs are safe and secure after laying, then presents themselves to the egg’s layer for a second load... keep your belly nice and full!”</i>");
	output("\n\nYou shudder at the thought, and let your eyes flutter closed for a few minutes of air-drying before you grab your gear and stagger off to the shower.");

	if(flags["EGG_TRAINING"] == 1 || flags["EGG_TRAINING"] == undefined) processTime(15);
	else if(flags["EGG_TRAINING"] == 2) processTime(25);
	else if(flags["EGG_TRAINING"] == 3) processTime(39);
	else if(flags["EGG_TRAINING"] == 4) processTime(55);
	else processTime(80);

	if(flags["EGG_TRAINING"] != 5) IncrementFlag("EGG_TRAINING");
	IncrementFlag("EGG_TRAINING_TIMES");

	pc.orgasm();
	processTime(5);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

/*
output("\n\nCarry Training");
output("\n\n//Have the tentacle-device fill your {womb / bowels} with eggs. This option advertises TamaniCorp brand Lock-Lube, made to ensure that your eggs are lodged inside you for a good long while... You’ll be carrying so many eggs that you’ll look positively pregnant for about a week, it tells you.");
output("\n\n//Increase looseness & wetness of hole.");

output("\n\n{First time: Having experimented to your heart’s content with the lesser option on the ovi-obsessed machine, you decide it’s time to step up your egg-game. You brush your fingers lovingly across the holo-screen, as if it were a lover’s cheek, and tap the <i>“Carry Training”</i> button. //else: Your body feels so empty without a swollen belly, without the familiar shift and tumble of eggs filling you day in and day out. You can’t help but miss the fullness, the never ending pleasure... you push the <i>“Carry Training”</i> button without hesitation.} You don’t have to wait for the screen to tell you to disrobe, tossing your [pc.gear] aside with an eager grin spreading across your face.");

output("\n\nAs always, you {if taur: awkwardly move to position your lower body over the entire box, angling your [pc.vagOrAss " + x + "] towards the saddle. //if naga: coil yourself around the box, angling your [pc.vagOrAss " + x + "] into the fuck-saddle as best you can. //if goo: squirm around the box, all but enveloping the entire box and wiggling your behind into the saddle. //else: swing a leg awkwardly over the edge of the box, plopping down in the seat of the saddle.} The moment you’re seated, the holoscreen on the front of the box swivels around to face you, and a pair of metal bars slide out from the sides of the box, giving you something to hold onto. Between them, the metal top of the box slides back underneath the saddle, revealing a tub of sloshing off-green liquid bubbling inside it. What looks like hundreds of small, yellow plastic eggs slosh around in the pool, piling up against a single hole on the wall right under the saddle. Doesn’t take a genius to figure out where that leads...");

output("\n\nNothing happens for a moment, though, until you lean forward over the box and take hold of the metal bars. A faint heat starts rising from the metal, and you feel a shuddering vibration as the machine {under you // between your [pc.legs]} hums to life. The sea of liquid inside the box starts heating up, bubbling and sloshing like a washing machine on high - and the box you’re leaning on heats up, as hot as a lover’s body. The saddle shifts underneath you, and you feel something slide right beneath your rump: a hole opening up under your butt. {if pc has balls: Your [pc.balls] immediately flop into the hole, dangling into the black depths of the bubble-gum pink fuck machine.} The holo-screen beeps and displays a cartoonish red <i>“HANG ON!”</i> in huge capital letters, and you feel the ever-present rumbling in the machine intensify.");

output("\n\nSomething moves violently underneath you, and you feel a sudden rush of wet heat splatter against your [pc.vagOrAss " + x + "]. You gasp as heated lube squirts through your crack{ and all over your groin}, and the stuff keeps coming and coming, like a sexified bidet. The holo-screen tells you to relax, breathe deep, and relax your body: your role is entirely passive in this. <i>“A good incubator lies back with spread legs and a smile for his or her ovipositor,”</i> the screen tells you. A ragged breath escapes your lips, which tremble with wet pleasure. You’re not sure if this lube-geyser has some kind of aphrodisiac mixed in, or if the constant squirt of hot, sticky, wetness against your hole is really just <i>that</i> pleasurable. Whatever the answer is, it’s only a prologue for what’s to come.");

output("\n\nWhich comes right about now, as it happens. You feel something thick and wriggling moving up through the stream of lube battering your backside, followed by a plasticy sensation against your [pc.vagOrAss " + x + "]. Your whole body clenches as a pressure begins to build, insistent but gentle, pressing in amidst the sea of lube coating your hole until you start to feel your body stretch. The tip of the tendril is nice and rounded, smooth and latexy like a proper dildo, though you instantly feel that something’s not quite human about it: the head seems hollow, like a crater caving in to reveal the long tube leading into the depths of the device it’s attached to. Even this inner passage is squirting lube into you, blazing its own trail through your {pussy’s clenching walls // bowels} as it starts to worm its way into you.");

output("\n\nThe tentacle doesn’t get an inch in before you feel something <i>else</i> coming with it. A ring of short, stubby nubs ring the tube, grinding into your [pc.vagOrAss " + x + "] on a bed of hot lube. You groan, eyes wide and knuckles going white on the handlebars. Instinctively, your body tries to fight back, to push the invading thing out of you, but it’s so slick and so strong that your body simply gives in to the incessant pressure the machine puts on you. All that’s left to do is feel the thing squirming inside you, writhing about inside your {twat // ass}, faster and faster. More of the little nubs snake in with the shaft, rubbing pleasurably against your {pussy’s walls // anal walls // prostate}. This is just a taste of the pleasure your Egg Trainer is promising, though. ");

output("\n\nWhat feels like the better part of a foot lodges in you before the tentacle seems to think it’s deep enough to start <i>really</i> working. The tentacle goes completely rigid for the span of a heartbeat, making sure you’re nice and stretched out around its thick girth, before it starts to swell and shudder, and you feel something moving <i>inside</i> it. Your eyes go wide as the tentacle hilted in your [pc.vagOrAss " + x + "] stretches out, passing the first thick knot of plastic through your {pussy lips // sphincter}. A much stronger geyser of lube squirts out of the tentacle-dildo’s crown before the latex cockhead engorges wetly, and you feel something thick and round and sloppy-wet shoot into your {bowels // womb}.");

output("\n\nPleasure rocks your world as the first egg lodges inside you. Your hips rock forward, bucking on the thick member in your [pc.vagOrAss " + x + "] and gasping for breath. {if cock: Your [pc.cock] bounces, half hard and leaking pre all across your thighs. Pleasure hammers through your cock like it’s ready to spurt already.} {if tits: Your hands are drawn from the handlebars and onto your [pc.breasts], cupping and squeezing your tits{ until milk drizzles down around your fingers}.} Moaning like a bitch in heat, you ride the writhing cock like a cow{boy / girl} until the pleasure’s just too much to bear. {Your cock cums first, geysering spooge across the top of the box and the deck of your cargo hold.} A scream of pleasure tears through your throat, arching your back and squeeze hard around the spasming, lube-spraying device.");

output("\n\nAnd that was just the first egg. Another thick engorgement wriggles its way up through the tube, making it push out on your lubed-up walls, rubbing its dozens and dozens of rounded nubs against you. The orgasmic pleasure tearing through you refuses to abate, especially with that kind of handling - and with another thick, heavy bulb plopping into your body, followed by another... and another. You watch with bulging eyes as egg after egg slurps out of the see-through tub and vanishes into the throbbing tube beneath you. Your [pc.butt] bounces on the fuck-saddle, riding that plastic shaft as it thoroughly breeds your [pc.vagOrAss " + x + "] with its eggy load.");

output("\n\n{@eggTraining: eggTrained pc} //That’s a new stat to see how many eggs you can take!");
output("\n\n{== 1 The tentacle squirts and thrusts, laying a belly-straining load of tumbling spheres inside you. You lose count after six big, orgasmic pops that bloat your {womb / gut}. By the time the wriggling tentacle finishes, you’re a swollen and sordidly wet mess, drooling hot lube like a waterfall from your well-fucked hole. One of your hands slips down to your [pc.belly], feeling a distinct set of uneven bulges pushing against your [pc.skin] from within.}");


output("\n\n{>3 more words here. The familiar, wonderful pleasure of the tentacle hammers through you, burrowing deep inside to discharge its belly-filling load. Eggs come flooding easily out of its engorged cockhead, blasting into your {womb // bowels} in a flood of hot lube and smooth plastic. Dozens and dozens of eggs pump into your well-trained body, swelling you up just like you like it. You cum again - if you really stopped at all in the first place - and let yourself go completely with screams of pleasure that echo across the cargo hold. Your hands clench around your belly, feeling your skin stretch around around the growing load of eggs: you look {an extra }nine months pregnant by the time the machine’s decided you’ve had enough, filled with almost a hundred eggs that churn wetly {up your ass // in your swollen womb}. The sensation is wonderful, comforting... you find yourself wrapping your arms around yourself, basking in the artificial sense of motherhood and the very real, all-encompassing sense of fullness.}");


output("\n\n{!= 0 The tentacle just keeps on fucking you, ceaselessly filling your belly with its artificial get. Egg after egg squeezes through its bloated head and into your {womb / ass} on a constant bed of heated sex lube until you’re positively stuffed with them.There’s well over a dozen inside you, maybe two - your belly is bloated by the mass of eggs, and you can feel the added weight of them hanging heavily in front of you, making you lean forward and rest your pregnant gut on the top of the machine. Your skin bulges and shifts unevenly, and your whole body feels incredibly wet - even as lube absolutely pours out of your gaping hole.}");

output("\n\nThe turgid, slimy tentacle stretching your [pc.vagOrAss " + x + "] out has finally finished its job, but instead of softening and sliding out, the tendril stiffens inside you, engorging from base to tip. The holo-screen tells you to hold still and enjoy TamaniCorp’s patented Lock-Lube, guaranteed to keep those eggs nestled deep (but harmlessly) inside you for a good week before it finally gives way, and you’ll give birth like a real egg-slut.");

output("\n\nThe tentacle throbs, and you feel another surge of hot, sticky wetness flooding your {womb/bowels}, basting the eggs in Lock-Lube. The gallon or so of lube already sloshing around inside you comes blasting back out, pushed out around the tendril by the hose-like lube enema you’re getting. But that only lasts a moment, before you feel a clenching sensation shudder through you, though it’s certainly not your muscles at work. Your [pc.vagOrAss " + x + "] feels like it’s being squeezed from the inside, the sodden feeling of lube slowly fading into a firm plug for all the eggs in your gut.");

output("\n\nThe tendril pops out of you with a wet squelch, letting the last trickles of lube pour out of your abused hole and back into the machine. You thought you were full before, but this is something new altogether: a total, swollen fullness that refuses to abate, stretching your [pc.skin] around your faux-baby bulge.");

output("\n\n<i>“Take good care of ‘em, sugar!”</i> the holo-screen tells you, and the tentacle gives you a resounding slap on the ass before wriggling back into its hole. You groan, running your hands across your lumpy belly as the machine shuts down, leaving you to recover - and to enjoy your wonderfully pregnant belly before you eventually get up and stagger towards the shower, slowly adjusting to your new weight.");

output("\n\n");

output("\n\nFaux Preg");
output("\n\n//Replace with <i>“Remove Egg”</i> if already has Faux Preg Egg installed in body.");
output("\n\n//This special <i>“service”</i> causes the tentacle to fuck a single, unique egg into you - what the screen labels a <i>“faux-preg egg.”</i> This special egg lodges inside you and grows, grows, grows in your {womb / bowels} until your belly is completely gravid. And there’s no way it’s coming out once it goes in without some medical intervention, or the help of the Egg Trainer machine. All the joys of being perpetually, gravidly pregnant without the inevitable childbirth.");


output("\n\nHaving thoroughly enjoyed the other services your lewd little egg-trainer has to offer, you wistfully contemplate the <i>“faux preg egg”</i> option {wondering what it does, exactly // already yearing for the wonderfully, impossibly full sensation inside you at all times}. You press the button, and are treated to another of the brief holographic demonstrations. This time, the device cheerily advertises TamaniCorp’s latest and greatest scientific breakthrough: an egg that will actually grow inside you like a child, swelling your womb over weeks and months like a real pregnancy... without the inevitable letdown of birth. You could stay forever gravid if you wanted, perhaps even ever expanding. The video fails to mention if there’s an upper limit on just how swollen this one little egg can get, but judging from some of the promotional pictures it uses - displaying Tamani herself reclining on a couch, nude and with legs splayed to show off a belly that looks far, far larger than what you’d expect from a human pregnancy... you’re not convinced the lascivious executive’s company was too concerned about limitations.");

output("\n\nThe holographic Tamani on-screen gives you a wink, rubbing her tremendous belly, and text on-screen tells you simply <i>“Good luck, slut!”</i>");

output("\n\nNot sure how you feel about getting called a slut by a sophisticated deep-fryer, you neverthless do as you always do. Your body shivers with anticipation, even knowing that though this time you’re not in for the sudden, orgasmic swelling of a dozen... or ten dozen... eggs being pumped inside you one after the other. This is going to be a slow, steady build-up, a change in lifestyle to let you enjoy the fruits of your {nocunt: wanna-be} womb. Following the screen’s familiar instructions, you {if taur: awkwardly move to position your lower body over the entire box, angling your [pc.vagOrAss " + x + "] towards the saddle. //if naga: coil yourself around the box, angling your [pc.vagOrAss " + x + "] into the fuck-saddle as best you can. //if goo: squirm around the box, all but enveloping the entire box and wiggling your behind into the saddle. //else: swing a leg awkwardly over the edge of the box, plopping down in the seat of the saddle.} The moment you’re seated, the holoscreen on the front of the box swivels around to face you, and a pair of metal bars slide out from the sides of the box, giving you something to hold onto.");

output("\n\nThis time, though, the top of the heat-and-clean tub inside doesn’t come sliding off. Instead, the screen blinks a reminder that you’re not going to be able to get the faux-pre egg out on your own... ever... without serious medical intervention, or the use of the machine again since it can flood your hole with a special deflation agent. At least you can remove it any time you want if you just come back to the egg trainer.");

output("\n\nNothing actually happens for a long moment, though, until you lean forward over the box and take hold of the metal bars. A faint heat starts rising from the metal, and you feel a shuddering vibration as the machine {under you // between your [pc.legs]} hums to life. You squeeze your eyes shut and hold on tight as a thick, tapered tentacle wriggles up from the machine and presses its pointed crown against your [pc.vagOrAss " + x + "]. It gives you a squirt of lube, painting your thighs and ass indiscriminately before forging again. There’s a moment of pressure as it aligns itself, and then the familiar, wonderful pleasure that presages the real treat; the tentacle slithers inside you, stretching your hole ever wider as it grows thicker, and inch after inch of smooth tube is fed into your [pc.vagOrAss " + x + "].");

output("\n\nYou moan out your enjoyment, bucking your [pc.hips] back against the steadily thrusting artificial member. The familiar sensation still sends a thrill through you no matter how many times you get to enjoy it. Your knuckles turn white, squeezing down around the handle bars and letting the tentacle fuck you. It’s more vigorous and more thorough in its business than it strictly needs to be, you well know by now, but you can hardly complain as it {milks your prostate // pounds your pussy} to orgasm. {if cock: Your [pc.cock] sprays its load all over the top of the box, throbbing and squirting in wondrous ways even without a single bit of direct stimulation.}");

output("\n\nWith a soft moan, you slump forward against the grip of the trainer box. You can feel the tentacle pumping lube into your [pc.vagOrAss " + x + "] like a cock blowing its load, making sure that your insides are completely soaked and ready for anything. After a moment, the holoscreen blinks the message, <i>“Egg implanted! Be sure to feed your baby with lots of cum!”</i>");

output("\n\nThe tentacle slips out of you without a moment’s more notice, leaving you feeling a little gaped, and a little more full. But you didn’t even feel the egg go inside you! You huff, feeling cheated by the lack of sensation... then again, when your body’s been trained to take dozens and dozens of eggs all at once, what’s a lone little egg to you?");

output("\n\nYou sigh, hoping the egg doesn’t fall out of your loose hole as you grab your gear back and stagger to the washroom to clean up.");

output("\n\n[Next]");






output("\n\nRemove Egg");
output("\n\n//Have the Egg Trainer remove your Faux Preg Egg... somehow?");

output("\n\nAs enjoyable as it’s been, you’ve decided it’s time to let go of your faux-preg egg. {Vagpreg: If anything, having it has made you crave a real baby - or just a belly full of alien eggs - more than ever!} You run a hand over your [pc.belly], feeling an odd connection to the synthetic pregnancy that’s been growing inside you. It’s been fun.");

output("\n\nWith a sigh, you tap the egg-trainer’s holoscreen and select the removal option. As usual, it tells you to disrobe and relax in the saddle, assuring you that it’ll take care of everything. You do as it says, settling down in the fuck-saddle and angling your pregnant hole with the slit under your [pc.butt]. You don’t even need to be told to grab the handlebars and relax, familiar with the device’s modus operandi as you are. Still, it goes through the usual motions of facing the screen towards you and telling you that, depending on how gravid you’ve let yourself get, this might be a hell of a ride.");

output("\n\nLooks like the <i>“faux pregnancy”</i> even includes birth. You shudder with anticipation, feeling your excitement mount. The tentacle’s bay opens under you, and the familiar, wriggling crown quickly presses against your [pc.vagOrAss " + x + "], spraying your ass and thighs indiscriminately with hot, slick lube. A little moan escapes your lips, forced out by a slow but insistent insertion that spreads your hole open wider and wider. {Your [pc.cock] is soon as hard as diamonds, begging for attention you don’t want to give it: letting the tentacle milk all the cum out of you is so much sweeter than giving in and using your hands!}");

output("\n\nYou rock your hips back against the tentacle, taking it as deep as you can. It fills you with lube, squirting the stuff into your {bowels // womb} and making sure that every blessed inch of your insides is absolutely drenched. After a few minutes of its usual, pleasant fucking, though... something changes. The tentacle goes completely still and rigid inside you, not budging an inch even against your grinding hips - the way it’s buried in your [pc.vagOrAss " + x + "], you can’t move at all!");

output("\n\nWith a grunt of displeasure, you try and squirm off the tentacle, but it holds you firm for a long moment. During the still second, you realize that the tentacle isn’t entirely frozen: it’s swelling, ever so slightly, but definitely growing thicker inside you. You gulp, feeling the slow and steady sensation of being stretched out by the inflating pseudo-phallus. When it finishes, you’re almost painfully stretched, groaning constantly from the intense pressure in your loins - and the fire of arousal burning in you, desperate for more.");

output("\n\nSomething ice-cold and sticky sprays from the tentacle’s tapered tip, blasting the bottom of the egg inside you. You yelp in surprise, almost orgasming from the shock... and finish as the tentacle decides it’s done, and slides right out of you. Gasping and crying out, you buck in the saddle and drench yourself and your trainer machine in {fem- // both masculine and feminine }cum. The unexpected climax leaves you slumping against the machine, knuckles white from how hard you’re gripping the handlebars and leaking lube from your pregnant hole.");

output("\n\nWhatever the tendril shot into your {womb / gut} seems to have affected your egg. The synthetic orb shifts restlessly inside you{if gravid or bigger: and, thankfully, seems to lose some of its mass. A waterfall of sexual fluids release from the pent-up ball, flooding out of you the same way the trainer-box’s lube does. As the ball drains, your belly ever so slowly deflates, down to a slightly more manageable size. You’re no longer nearly so overwhelmingly gravid now, but when the flood abates, you’re still left with a big, prominent baby bump. //less than gravid, bigger than baby bump: A small waterfall of pent-up sexual fluids cascades out of you as the ball of synthetic egg deflates somewhat, shrinking down with agonizingly pleasurable slowness until it’s just a big, firm baby bump bloating your belly out. //else: Your gut gurgles uneasily as the egg dislodges and shrinks a bit, getting properly aligned for what’s to come.}");

output("\n\nThe holoscreen helpfully tells you to please face your rump into the lube-tank. The lid slides off, revealing the sloshing tank of hot, steamy lube for you to give <i>“birth”</i> into. You swing your [pc.legs] forward, grabbing your belly to steady yourself as you feel the egg start to drop. A big, bold, pink word appears on screen: <i>“<b>PUSH</b>.”</i>");

output("\n\n{Small egg fork:");
output("\n\nYou grit your teeth and push as hard as you can, bracing against the box for a little extra leverage.");

output("\n\nThe egg inside you might not have grown very much, but it’s still bigger than what would normally pass through you - and bigger than the average TamaniCorp egg. Whatever the tentacle pumped into you {has relaxed your womb, making it open up and regurgitate its unwanted occupant // is make your ass spasm, finally flushing the thick bundle of synthetic substance that’s been nesting inside you for ages}. You grunt and push, and nearly orgasm again thanks to how well-trained to pump out eggs your body has become.");

output("\n\nIt doesn’t take long for your trained muscles long to work the egg out, right up to your {anal ring // pussy-lips} and then, with a climactic burst of effort, it pops out and goes sailing into the lube-bath, splashing into the tank with its friends. The breath goes out of you with a ragged gasp of pleasure, and you all but collapse backwards. A feeling of utter, absolute contentment spreads slowly through you. After that, you feel like you could drift off to sleep.");

output("\n\nThe machine beeps something at you, but you’re way too worn out to get up and read it. Smiling to yourself, you glance into the tub, and see a black ball of what looks like plastic about twice the size of the other eggs resting atop the trainer’s payload, slowly submerging in the heated lube. A pang of... regret? Longing? Some emotion you can’t quite put words to tugs at your heartstrings for a moment as the lid slides closed, and you’re left to recover.");



output("\n\n{Bigger Egg Fork:");
output("\n\nYou know oviposition is just another part of the process, but isn’t this a little big? The egg inside you is still absolutely huge, probably bigger around than an actual baby. Lucky you, the tentacle’s lube has relaxed your [pc.vagOrAss " + x + "], making your hope open wide of its own accord. You moan, shuddering as a heavy, heavy weight shifts downwards in your [pc.belly], starting to make its descent.");

output("\n\nAll you can do is push as hard as you can! The egg moves slowly down, coaxed by your well-trained muscles, but the sheer size of it drives you wild with pleasure and strain. Your hole is stretched wider and wider open, forced to bear the immense pressure of the egg’s descent through your body. The sensation is overwhelming, making you scream with orgasmic ecstasy, echoing your voice from the bulkheads all throughout the deck.");

output("\n\nAfter several minutes of pushing until your knuckles are white and your [pc.vagOrAss " + x + "] is radiating with agonizing pleasure, you can feel the egg starting to crown. Your hole stretches even wider than before, straining to its absolute limit to accommodate the slick, smooth bulk of the artificial egg. The holoscreen urgently flashes its command to push again, giving you the only guidance you’re going to get. So you keep pushing, throwing every ounce of will and force you’ve got into getting the over-sized egg out of you. You can actually feel your belly deflating, getting smaller as the massive weight that’s been stretching it out finally departs.");

output("\n\nWith one last, climactic push, you feel the sweet release as the egg hurtles out of your [pc.vagOrAss " + x + "] on a bed of lube and cum. Orgasm hits you again when you finally lay your faux-preg egg, rocking your body with unbearable pleasure. Though you hear a splash of it tumbling into the lube-bath inside the box, you can’t muster the strength to sit up and look. The trainer machine bleeps something at you and shuts off, leaving you to slowly recover.");

output("\n\nWhen you’ve finally caught your breath, you manage to stagger up and glance into the lube bath. The egg is sitting at the top, deflating. Already, it’s barely any bigger than the normal eggs inside, a big ball of black synthetic material about the size of your fist. Your heart throbs with familiar yearning, remembering the time you were so intimately connected.");

output("\n\nSighing to yourself, you close the lube bath and stagger off to clean up.");








output("\n\nLeave");
output("\n\nYou decide against using the egg trainer, and put it on standby for the time being. The screen flickers off, and the burbling noises you occasionally hear inside it fade to a low murmur.");


output("\n\nCarrying Eggs!");


output("\n\nNormal Eggs");
output("\n\nBelly Descriptions");

output("\n\n//Training 1-2:");
output("\n\n//PC gains a small belly bulge, ~equivalent to 3-4 months preggers.");
output("\n\n<i>“You have a small but noticeable false baby bump. Though not noticeable from a distance, close inspection reveals your slightly strained flesh to be somewhat lumpy and uneven, thanks to the many small eggs clumped inside you.”</i>");

output("\n\n3-4");
output("\n\n//PC gains a moderate belly bump, ~9 months preggers");
output("\n\n//PC gains a small lust over time increase");
output("\n\n<i>“Your belly is very obviously swollen with artificial pregnancy - you look about as gravid as a human woman in her third trimester now. Your skin is unevenly bulging and shifts constantly as the many, many eggs inside you. Every step makes your full gut jiggle, sending little shockwaves of pleasure through you.”</i>");

output("\n\n5:");
output("\n\n//PC gains a hugely gravid belly, way more than a pregnant human’s.");
output("\n\n//PC gains a moderate lust over time increase, and a -10 penalty to Reflexes.");
output("\n\n<i>“Your belly is hugely swollen, full of what must be near to a hundred plastic eggs that rustle, shift, and jostle inside you with even the slightest motion. You’re in a constantly state of near-orgasmic high from the unending sensation, shivering every time you take a step or rub a hand against your belly.”</i>");

output("\n\nEvent: Jiggle Jiggle!");
output("\n\n//Play sometimes when PC is walking. Increase Lust by 10 per Training level.");
output("\n\nYour progress is interrupted by a sudden shift in your [pc.belly], making you nearly double over with intense, overwhelming pleasure. Just feeling the {dozen // dozens // close to a hundred} eggs moving around inside you, jiggling with your movements, is almost enough to make you cum on the spot. You bite your lip and hold on, {ignoring the curious looks from passersby // more than a little aroused by the way people are looking at you //thankful that you’re all alone}.");

output("\n\nYour body’s betrayal lasts only for a moment before the eggs settle down again. You sigh, taking a deep breath to steady yourself before you get going again, a {little // good deal} more flushed than before.");


output("\n\nFaux Preg Egg");
output("\n\n//FPE basically acts like a normal pregnancy, occupying the given womb/butt and preventing anything else from taking root. It grows (very) slowly over time, basically about 2x the rate of a 9-month human pregnancy. If we have the ability to determine when a given orifice gets semen/etc. blasted into it, then the FPE basically absorbs cum to get bigger - increases slightly in size per load of cum. Having a very wet orifice also increases its growth rate, to about 3x human rate.");

output("\n\n//Very Small Egg (Unnoticable Belly)");
output("\n\nThough it’s not quite noticable yet, you’re well aware that there’s a slowly growing egg inside you.");


output("\n\n//Small Egg (Slight Belly)");
output("\n\nThe faux preg egg inside you has grown somewhat, causing your belly to expand. You’ve got a slight, barely noticeable but false baby bump now.");


output("\n\n//Medium Egg (Moderate Belly, ~3-4 months preggers looking)");
output("\n\n//Slight passive lust gain");
output("\n\nYou’ve got a fairly sizable belly now, thanks to the ever-growing TamaniCorp egg inside you. If moves ever so slightly with every step, making you shiver with pleasure almost constantly.");


output("\n\n//Big Egg (5-8 months preggers)");
output("\n\nYour egg has grown bigger and bigger, now stretching your {womb // bowels} so thoroughly that you look positively <i>gravid</i>. You’re nearly as big around as a woman in her third trimester, and constantly find yourself putting your arms around your [pc.belly] to support the weight. It feels wonderful, when you’re not complaining about your back or struggling through doors - the feeling of your belly stretched out around the sheer size of the egg, the way it moves around inside you - it’s constantly bathing you in pleasurable sensations.");

output("\n\n//Very Big Egg (9 Months +)");
output("\n\n//Modest passive Lust gain.");
output("\n\nYour belly has grown to the size of a woman about to give birth - and maybe a little more at that! The egg inside you has swollen to massive proportions, stretching your body out as if you’re carrying a pair of twins inside you. Every slight motion you make causes the tremendous weight inside you to shift and churn, sending shockwaves of ecstatic pleasure through you.");


output("\n\n//Giga Hyper Eggo (Jacques Tier But With Belly)");
output("\n\n//Major passive Lust gain");
output("\n\nYour egg has grown truly, unnaturally, enormously massive inside you. Your belly is swollen beyond anything you’d have thought possible, stretching out ahead of you in swollen majesty. Every step, every slight motion you make, is nearly orgasmic now. You can’t help but play with yourself constantly: not sexually, but simply rubbing your hands on your [pc.belly]. Sometimes, you find yourself spending minutes just enjoying the feeling of fullness, of your fingers brushing across your taut flesh. You can’t wait to see how big it can get...");
